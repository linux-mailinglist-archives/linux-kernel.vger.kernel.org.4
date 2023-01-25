Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6F67B38F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjAYNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjAYNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E54255287
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674653943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sxzotnx/8u7CTeCRsf3MJY8+svrxvajdNHO0lRdFPkg=;
        b=MuIFaMLdJ7x/dKw1ppNDS3oCUDen14eFbqbnZzroATFuOry9ej7ayLdZqxuVFPcQwWAsbU
        v0AUPUK0MY5Z72500q0yYcbrvlh4KptfpyPryGjAgpXTWo6lUmaQaDwQwGrtfYMOfaEkzT
        PFZ2qzBhJG8KRm5r4V2gxPRr7NOz1LQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-v-hyQZ0NNvKobEV39EIwFg-1; Wed, 25 Jan 2023 08:39:02 -0500
X-MC-Unique: v-hyQZ0NNvKobEV39EIwFg-1
Received: by mail-ej1-f71.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso12077283ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxzotnx/8u7CTeCRsf3MJY8+svrxvajdNHO0lRdFPkg=;
        b=R40sjG9XXo/elEcM4gCtKM3SlNK2yx/9oEYyAaJjtYyIzg9E5me+wf81pbetlWlkIv
         hQe9+nbsTbUrdihyccEdfngRWeQ6SGcrJ2ndPZ5tBlMCPzJRbZvHX/XRdZyMo3tslU2r
         gFMQkfhMVvFgrIDPLqWpcznUXUHfgvifR+5MkPT65auns8UyZcOtZnX9jWTb2huicSb5
         B9RAYae2jTVsTnB2TnNAlM8Pen9SoxjKbcbMSHvbC0AobU0V1e0MoPULDYCvqtKl2n9W
         AttOR2bfE/FQYjfyhi+okH4M+iG7xFJX+J6cGB/ouXU5ukWe+D2CaacMYwFpm3ID/R2p
         0sqA==
X-Gm-Message-State: AFqh2krMl7YYS26YL8SBBkQBhFdfJqWmhDMPpqEXr4m6DdZi/EHQpjcC
        hGxQnrkWThJ3ifJU82my87+MYTA/g5FZI0IW4vQFlygMqg3YgT746uQeWfUKVKKilI8TjlXd9Fy
        BTDQVwKURjlVoS70BJhe+FVw6
X-Received: by 2002:aa7:de9a:0:b0:482:d62c:cde with SMTP id j26-20020aa7de9a000000b00482d62c0cdemr48671601edv.13.1674653940736;
        Wed, 25 Jan 2023 05:39:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuSG9aMyPwztmzmC+kCrInOnj8mPzQEuCzuD4sdr5qzPHQ3vYBP3LEEv2c86PDwwr+WEAua5A==
X-Received: by 2002:aa7:de9a:0:b0:482:d62c:cde with SMTP id j26-20020aa7de9a000000b00482d62c0cdemr48671585edv.13.1674653940587;
        Wed, 25 Jan 2023 05:39:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7c7c2000000b0047eeaae9558sm2344417eds.60.2023.01.25.05.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:39:00 -0800 (PST)
Message-ID: <383fda33-143d-9e8e-1f7d-080931ae4496@redhat.com>
Date:   Wed, 25 Jan 2023 14:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH resend 0/2] i2c/extcon: intel-cht-wc: Lenovo Yoga Tab 3
 Pro YT3-X90F support
Content-Language: en-US, nl
To:     Wolfram Sang <wsa@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
References: <20230125111209.18343-1-hdegoede@redhat.com>
 <Y9Et7nlUmiiPrFUQ@ninjato>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y9Et7nlUmiiPrFUQ@ninjato>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/25/23 14:26, Wolfram Sang wrote:
> 
>> I'm resending these 2 patches since they seem to have fallen through
>> the cracks.
> 
> Which tree should the patches go via? I am assuming not-i2c, but maybe I
> am wrong?

That is a good point. I was under the assumption that the matching MFD
patch, which I did not resend, was already merged. But I'm wrong,
sorry about this.

So I'll do a v2 resend with 3 patches which does include the MFD
patch and then I guess ideally all 3 patches would go through
the MFD tree.

Wolfram, may I/we have your ack for merging the small i2c change
through the MFD tree?

The extcon patch already has an ack for that. So I'll hold of
on sending out a v2 with the missing patch until I have your
ack, so that v2 will be fully ready to merge through the MFD
tree.

Regards,

Hans


