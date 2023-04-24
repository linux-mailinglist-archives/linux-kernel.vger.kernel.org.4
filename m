Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E0C6ECDE2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjDXN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjDXN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:27:31 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34E10D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VJ6aqpWgPeGvM1GhnkNKoblslgPvV3JKY89c5BlTEXc=; b=JcP5wLNowUmLPotHeHcX+J9h86
        P80OboDWmzKLDUl079c4UbBnq6vWQAr4ObuR7aJTmtvccUuNBYMsdnxs0sKFCvE/PwznNz2GpLRH7
        p97HeEVbVvZmoTHqs3C3KH9xwTZUQpXHP4JWM9ARwTtgarqGpKeoR36v0V5yC3R/uYdvXUm7W4xUC
        SsneYGeoe6vVjHa6LM5mM8r2/NnW7a7OUfcqtBVWOHT27FpyDbkRvadM8RJomRY1Og0R7V6tBZdf6
        xwucKUMfkGr/kPcq0hsRe2aC5tOSmB3l09GoduUBJd87iobzYzhtcxrc2erJs8XDcGxTX2nbtFG8D
        fK3zo3nA==;
Received: from [152.249.146.45] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pqwDw-00AtVt-PD; Mon, 24 Apr 2023 15:27:20 +0200
Message-ID: <717b333b-7af6-063e-d50d-bb2b3bbcecb4@igalia.com>
Date:   Mon, 24 Apr 2023 10:26:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: Mark contexts guilty for any reset type
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20230424014324.218531-1-andrealmeid@igalia.com>
 <d7264c5a-29b4-0fb3-153b-673a8a73d635@amd.com>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <d7264c5a-29b4-0fb3-153b-673a8a73d635@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian, thank you for your comments.

Em 24/04/2023 04:03, Christian König escreveu:
> Am 24.04.23 um 03:43 schrieb André Almeida:
>> When a DRM job timeout, the GPU is probably hang and amdgpu have some
>> ways to deal with that, ranging from soft recoveries to full device
>> reset. Anyway, when userspace ask the kernel the state of the context
>> (via AMDGPU_CTX_OP_QUERY_STATE), the kernel reports that the device was
>> reset, regardless if a full reset happened or not.
>>
>> However, amdgpu only marks a context guilty in the ASIC reset path. This
>> makes the userspace report incomplete, given that on soft recovery path
>> the guilty context is not told that it's the guilty one.
>>
>> Fix this by marking the context guilty for every type of reset when a
>> job timeouts.
> 
> The guilty handling is pretty much broken by design and only works 
> because we go through multiple hops of validating the entity after the 
> job has already been pushed to the hw.

I see, thanks.

> 
> I think we should probably just remove that completely and use an 
> approach where we check the in flight submissions in the query state 
> IOCTL.

Like the DRM_IOCTL_I915_GET_RESET_STATS approach?

 > See my other patch on the mailing list regarding that.

Which one, the "[PATCH 1/8] drm/scheduler: properly forward fence 
errors" series?

> 
> Additional to that I currently didn't considered soft-recovered 
> submissions as fatal and continue accepting submissions from that 
> context, but already wanted to talk with Marek about that behavior.
> 

Interesting. I will try to test and validate this approach to see if the 
contexts keep working as expected on soft-resets.

> Regards,
> Christian.
