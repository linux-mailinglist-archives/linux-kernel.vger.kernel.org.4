Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7715FF38E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJNSWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJNSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:22:35 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288601C2EB8;
        Fri, 14 Oct 2022 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ntCfAKnHrcfFTXe48WBs/o5IfdVKymSy5keZJJ/v4gM=; b=lOFQ/R9as9KuXSfmXQZcdmIuya
        v9lLLOciET59b3qkca5tBPYzpIhU6lR34lWHDP1GnHXy6T37+fnLV6OxX5kg7O+P+VJxkJD21bJsZ
        oVRC/mJThCs36N2kLDt5V1Ecq7KoANyBYv8AdfeDS5UszAuuM9z93urR8550/ZN2NJKYmoZ1rlzge
        8iauQyY+ghPU3p1qf/H4iJsFxvpdPS/REa7j3MQdcbIlTjINLX4/MZzl75XBaMyPZ1zLU8BA+GHf9
        VKzbsmpM0p1Tt/BWWlCJTi/vFDe5TYSvSJqM+/AFpE9BCnWtw7cKNtFsUf248kqYfdaZe+R5R0CHf
        auGp6n3Q==;
Received: from [187.57.106.242] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojPKH-001Yom-4c; Fri, 14 Oct 2022 20:22:29 +0200
Message-ID: <f4950ab6-c7c7-499d-d895-777a0cf4a98d@igalia.com>
Date:   Fri, 14 Oct 2022 15:22:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <9a606366-6ac7-3802-5c25-91057ad833cb@igalia.com>
 <ca4b6a18-a44a-e248-f648-674e3805687a@igalia.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ca4b6a18-a44a-e248-f648-674e3805687a@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 15:20, Guilherme G. Piccoli wrote:
> On 14/10/2022 15:17, André Almeida wrote:
>> [...]
>>
>> Tested-by: André Almeida <andrealmeid@igalia.com>
>>
>> Tested on an Intel i7-1165G7 using a small benchmarking script, the
>> behavior is effectively reverted when using the sysctl option.
>>
>> Also, you might want to document this option somewhere? Maybe at
>> Documentation/admin-guide/sysctl/kernel.rst
> 
> Thanks André!
> 
> About documenting, it seems it's already done in the patch, right?
> Cheers,


oops, my bad :)
