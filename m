Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351945EF81A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiI2O6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiI2O5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:57:54 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D645413EAEB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0t8EXEN0WMFHzgw2HOC2b2lqxM9pZob9VZMkm7q5ttw=; b=hYRhPbGHnUjnN6D4Olr5bK4XEw
        cFXYyk0poQFBFBUlK1/ZL02TDImDZEJnB8LiNHitDiZZfVch1xsCaf01PaAOJ+7V+uS/tWyoMVBhk
        xd3Bjq8Dsc4G+OXtrOkhYwwUwpBSg2mbb2E7mHrOJM81gVkN//qQLTtejMP8+4v1VNekptq038wrT
        h4NcaPJDmTSMhTV+1ylTgGGA1Uwco3PJvCUDuvXynkH7DCuDcg/UuPjpgOFB8+uWtom0nTCUFr/aV
        Vuk8CwaU8EuOaCJalGco0HRoVaYrKQ0o9CscakFApodGPfbzVSIR714Gypq6p8G8Rs+WlJzc8FK/S
        VAJBtlQQ==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oduyk-00GdKB-Kr; Thu, 29 Sep 2022 16:57:34 +0200
Message-ID: <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
Date:   Thu, 29 Sep 2022 11:57:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, tony.luck@intel.com,
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:50, Dave Hansen wrote:
>[...]
> It boils down to either:
>  * The misery is good and we keep it as-is, or
>  * The misery is bad and we kill it
> 
> My gut says we should keep the warnings and kill the misery.  The folks
> who are going to be able to fix the issues are probably also the ones
> looking at dmesg and don't need the extra hint from the misery.  The
> folks running Windows games don't look at dmesg and just want to play
> their game without misery.
> 

Hi Dave, thanks for your response. I really appreciated your reasoning,
and I think it's a good argument. In the end, adding misery would harm
the users that are unlikely to be able to fix (or at least, fix quickly)
the split lock situation, like games or legacy/proprietary code.

I have a revert removing the misery ready and tested, let me know if I
should submit it.

Cheers,


Guilherme
