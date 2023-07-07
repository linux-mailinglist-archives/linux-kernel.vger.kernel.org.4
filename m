Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520B074B31C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGGOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGGOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:34:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EA011B;
        Fri,  7 Jul 2023 07:34:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso2086447276.3;
        Fri, 07 Jul 2023 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688740483; x=1691332483;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3p5aFfYXx0zUGHrXuEIgjjwQBqgXOALoH5J8KcvZyRY=;
        b=jrgiPVSwGYPEisBAsr29v837w9nqGK9uBxl4JdGnbWOgN3ntENbZ2lcN3YgKdstVQf
         i4+poi/qSdmIWcYmrlJ/UQCAtzOCAUTr7hdH84aNd00UYg2WrTHKwnhpKRmUUyqyQLH7
         Vp64mUsbhr6KNJEIB+CXgXF5MpmKsuawoUNoFi32Od8oM9GPRdSD8bm/qs5HzWdCjD6l
         W08L51jsjxjUz/F/zgE/Z33M01xk/QlAv16lerKzoc+HpSM4aVnGVhPPVCaRkUmhRaeR
         H0Sp8Pzpw0KXvx/GyEwcmImYQHIZdSNnLCPeubxKsqtQqbEZPFVkpiHQv3Ahfg8S6wRs
         HbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688740483; x=1691332483;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3p5aFfYXx0zUGHrXuEIgjjwQBqgXOALoH5J8KcvZyRY=;
        b=f2A0FqCIYpx1FZwR5yiI1jxRfFUhcbmvy32fgFzxUojby2mHSVFplCiwV6E/f0hGu7
         sIrKxo+vzW7vZz53zCkoGRun21RQg22UYJmeCkNbigLHVFX/3EavakkXH8py0eji08Oa
         +EqcvwW1jBNqp5Zl1TuZyC1XzvUov1AKvy/Uvk6YW3gMYzsfNbwTToOrbZKco/4rj/+N
         oSTVUBO8xkBnvq2IU/htUsjcTLIr403dim6rkc1mA7yLTshR2W4f0rdVjsByjZf/fcZh
         yzwqR4cXMalhu+XDPBcdhnebt4wVGfpFiaNm+6z3Hugm3iUcqq9HY5GBwN0ya7b78DxV
         eCEQ==
X-Gm-Message-State: ABy/qLYbLeYl1dQfdrfZWd/uo7WU7xg96BTGY7ab8zzZXf5nljGMLquq
        nM80adhQqFdrHQMyB249uDxU1jXkMVg=
X-Google-Smtp-Source: APBJJlGHhZuiTlSPpBvQzOHNGzjr3optRLDkfcVtnbiTex0B2yhUe4s5hIKckT1eprjkoVISxbbubQ==
X-Received: by 2002:a25:6d57:0:b0:bc3:8c94:8e34 with SMTP id i84-20020a256d57000000b00bc38c948e34mr4075892ybc.26.1688740483673;
        Fri, 07 Jul 2023 07:34:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t62-20020a254641000000b00be4f34d419asm959437yba.37.2023.07.07.07.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:34:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d8254cce-a6a6-46b4-ea28-3a1df2760499@roeck-us.net>
Date:   Fri, 7 Jul 2023 07:34:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
 <CAMuHMdWLdJPC6oQ0P4_DVbPXrVjg=PMjTUdX4MD4+tmc3BW9sg@mail.gmail.com>
 <CAMuHMdUzk8GuaqK6rBLaskVb=8Lsqe5hZ-=N=zqfWcxay-Euew@mail.gmail.com>
 <0a7c60cebf41e781f5c8f04d85dfba9e31e61e2b.camel@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
In-Reply-To: <0a7c60cebf41e781f5c8f04d85dfba9e31e61e2b.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/23 02:53, John Paul Adrian Glaubitz wrote:
> Hi Geert!
> 
> On Fri, 2023-07-07 at 10:48 +0200, Geert Uytterhoeven wrote:
>>> I can reproduce the issue with rts7751r2dplus_defconfig, but I may
>>> not be able to look into it today...
>>
>> Disabling CONFIG_USB_OHCI_HCD fixes the hang.
> 
> I picked rts7751r2dplus_defconfig, disabled CONFIG_USB_OHCI_HCD but it still
> hangs for me. Are you sure it's CONFIG_USB_OHCI_HCD and not something else?
> 

It seems to be related. With this patch reverted, ohci_irq() gets a single
interrupt, and boot continues. With this patch in place, ohci_irq() does
not get any interrupts, and boot hangs with qemu at 100% CPU. I confirmed
this by disabling CONFIG_MFD_SM501. After that, the hang is no longer seen.
Of course, that also means that OHCI and other emulated sm501 functionality
no longer works.

My suspicion is that something goes wrong with interrupt routing to
SM501 and with it to ohci_irq(), but that is just a wild guess.

Guenter

