Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8659C6A4A09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjB0Snc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0Sna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:43:30 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37326AE;
        Mon, 27 Feb 2023 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZIN4RUa47JWixv+iKRFDKHEww2SYThdo5L1ZrUf4BrI=; b=mYIfTSJGhbbyJuL7F2bcXQipOd
        VMT54s64OyCYw+8M0aTqMRIVnTpskim2lfe1gLCN2Gtdt16OQ1i+CMgasv1azSXv3vl8CDayZkcvS
        9cjtEMRpWpgrqcM/UIq7Y1cmZS1EnI5nc7nCVuea2taxGz/Zm+krtDBR+7V/j2vBimolZsO663PBF
        Vt0iyE58nI37tPYybkrZNKAIehi0E667MYbsqMmIk8jsBCfn26iXOm8zu182epbyNLZ/IrDfkhW04
        hm0O5FcTsYp4exEyhh3Tbc/8orabVGz7QjhE/A4M1/e1W/gowQGPMOD07AqA5ifEex/U56MiI/HAp
        Kn0gwdnA==;
Received: from [152.254.196.162] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pWiT6-00H0De-Pv; Mon, 27 Feb 2023 19:43:25 +0100
Message-ID: <f4c440ef-e0ec-ea07-71b2-3fd3c4d52088@igalia.com>
Date:   Mon, 27 Feb 2023 15:43:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: bcm: brcmstb: Remove bare-metal ARM suspend/resume
 code
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@vger.kernel.org
Cc:     drv@mailo.com, ssengar@microsoft.com,
        kumarpraveen@linux.microsoft.com, christophe.jaillet@wanadoo.fr,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Miaoqian Lin <linmq006@gmail.com>, Liang He <windhl@126.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230224215249.239405-1-f.fainelli@gmail.com>
 <421678cb-6ec0-903c-a84b-c833f013815d@igalia.com>
 <35dc0b00-0de4-f1b4-8d43-7efd181e7dbf@gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <35dc0b00-0de4-f1b4-8d43-7efd181e7dbf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 15:38, Florian Fainelli wrote:
> [...]
>>> -static int brcmstb_pm_panic_notify(struct notifier_block *nb,
>>> -		unsigned long action, void *data)
>>> -{
>>> -	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
>>> -
>>> -	return NOTIFY_DONE;
>>> [...]
>>
>> Hi Florian, thanks for the clean-up!
>>
>> I'm curious with the above panic notifier - is it not necessary when
>> PSCI is used?
> 
> This is a bit of long story, but no, it is not necessary.

OK then heh
Glad for the clean-up!
