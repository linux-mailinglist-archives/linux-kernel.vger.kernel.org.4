Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2E55EFC23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiI2Rhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiI2Rh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:37:28 -0400
X-Greylist: delayed 1211 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 10:37:27 PDT
Received: from mail.codeweavers.com (mail.codeweavers.com [65.103.31.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6113FB77
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y76a3/LbYUKYdSjtoM/XhejcVPUWArm4KSXbUioz5Kw=; b=L8OIccBo+X19LnR85a9CFewlSm
        8Aob3i8a/OjDjav/NBWmMDBKFaejZ6/zAggtiO4u/tw5eYPtkjO/FCQSiSDx/ZYjZoatYcAN2Us2d
        7lkzSyFezkwFV/aEEz3dW6+/bvIX41iFm6s8htNTBM7Bhtrz+75MmFp0wGzfN/BiYMuo=;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160])
        by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <zfigura@codeweavers.com>)
        id 1odx9n-000NYe-2D; Thu, 29 Sep 2022 12:17:07 -0500
Message-ID: <0e11f3e5-6a16-4a7a-8e1f-470c45dac64e@codeweavers.com>
Date:   Thu, 29 Sep 2022 12:17:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
From:   Zebediah Figura <zfigura@codeweavers.com>
In-Reply-To: <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 16:50, Dave Hansen wrote:
> I really don't like the idea of *both* a new boot parameter and a new
> Kconfig option.
> 
> The warning mode worked as intended in this case because it got a user
> to file a bug and that bug report made it back to us.  It's kinda funny
> to respond to that report by reducing the misery.
> 
> On the other hand, all the report resulted in was finger-pointing at a
> binary Windows applications that neither we nor probably anybody else
> can do anything about.
> 
> It boils down to either:
>   * The misery is good and we keep it as-is, or
>   * The misery is bad and we kill it
> 
> My gut says we should keep the warnings and kill the misery.  The folks
> who are going to be able to fix the issues are probably also the ones
> looking at dmesg and don't need the extra hint from the misery.  The
> folks running Windows games don't look at dmesg and just want to play
> their game without misery.

This seems like a reasonable position, but on the other hand...

> The other option is to wait and see if there's any kind of pattern with
> these reports.

...if the pattern ends up being "closed-source Windows software", as is 
not unlikely, then maybe this is something that could be made into a 
personality, that emulators like Wine could enable? I don't know how 
distasteful such optional workarounds are in general, but this would at 
least allow the original warning to continue working as intended for 
software that can be fixed.

ἔρρωσθε,
Zeb
