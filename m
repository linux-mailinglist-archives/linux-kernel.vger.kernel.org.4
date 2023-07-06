Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2274A18C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjGFPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjGFPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:51:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E42680;
        Thu,  6 Jul 2023 08:51:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579ef51428eso12121657b3.2;
        Thu, 06 Jul 2023 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688658686; x=1691250686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uz+lgUHN9yYqQiHqcQxc47Z3ej05yzddV+WOmdJaJJA=;
        b=kzad0wqarRBIT+cz6ocHFO/4Lw8Zbe2MSUJeC5ljZ+foGYCd2yUpyWJRuq4YZ79yQB
         vKHECusDfAjF/3a41FhBD43W1xRGt/FhhzYgo2lBD5gdABkvBaJiRO+CSPa+jN9Okff/
         G2cw6Cjv9AXwDGWcsQD6YE9cB1ULy55Z6wHwftBtEQ0bv4wkcN9fn49YhGo55C604h6f
         manMTif6SVbIjtAcf3Mbr7Nfx1CLlf6tQDDcbrqyJpcf1S4ui4MfVEXplk06ndhNOrGD
         itmhxMi/bO1KJXDY9yJERACL15ol57chA8C2HU+rxHc2u8jfSKLLx9oPQI3miQtlqF1n
         PlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658686; x=1691250686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz+lgUHN9yYqQiHqcQxc47Z3ej05yzddV+WOmdJaJJA=;
        b=DMymva5LlphA18l+EW6r2rB7oRkC1Z3pN9NXQt4hiw/HXpClad5/lX5jTKmxaFXU7a
         FAo03po9N+Oy/VOgbWEEz7ZhGyblZqckQJx/pAfIRTJWQXldHGn2PqJRIJslKP9ILZea
         kkDO0A7ZmIz0WgZCkO/2w0DGC1V+1zL5ETEhn5cO8Lw8yNUru5+CG3iuUZ2uCeqw8g9n
         Oag6pAQ7J4HnaF4pBLXpJvIz5IgoRYyQGVJvMMUWr6giDsfIGZONE8JYIz9XJSpeoAtp
         MqQblI+0ISvpZIXQj7EgsNMHS8C52LTCxC1snxkj9Ev4rh6oBBetMhZ7DX8vMyJJ5ga1
         T5iw==
X-Gm-Message-State: ABy/qLZoVKHV4epbmVYCqowT0E/RlQRKqN8Lsb7o8sAcBsBhum687zYc
        4npf+CY5g8Mc9/V0ZpzL21U=
X-Google-Smtp-Source: APBJJlFzmWHcCUPCF7aOn7Rh555EMJB85fsUa7sv6IU5KwgJTr0E7gsaOFErxcyU7x0QKvSTCaPL9A==
X-Received: by 2002:a0d:ef07:0:b0:577:616e:2d72 with SMTP id y7-20020a0def07000000b00577616e2d72mr4171716ywe.5.1688658686158;
        Thu, 06 Jul 2023 08:51:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7-20020a815e07000000b0056d443372f0sm420401ywb.119.2023.07.06.08.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:51:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <01df12bd-2872-b9d4-50e7-14a1cfabf4ec@roeck-us.net>
Date:   Thu, 6 Jul 2023 08:51:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/6/23 08:39, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Thu, Jul 6, 2023 at 4:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Thu, Jun 01, 2023 at 11:22:17PM +0300, Sergey Shtylyov wrote:
>>> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
>>> return -EINVAL instead.  However, the kernel code supporting SH3/4-based
>>> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
>>> IRQ #s from 16 instead.
>>>
>>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>>> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip.
>>>
>>
>> Unfortunately it also affects all sh4 emulations in qemu, and results in
>> boot stalls with those. There isn't a relevant log to attach because there
>> is no error message - booting just stalls until the emulation is aborted.
> 
> Which sh4 platforms in particular?
> 
> I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
> (physical) two days ago.
> 

It is r2d. Example qemu command line:

qemu-system-sh4 -M r2d -kernel arch/sh/boot/zImage -no-reboot \
	-initrd rootfs.cpio -device rtl8139,netdev=net0 -netdev user,id=net0 \
	-append "rdinit=/sbin/init console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap" \
	-serial null -serial stdio -nographic -monitor null

Example set of logs:

https://kerneltests.org/builders/qemu-sh-master/builds/5/steps/qemubuildcommand/logs/stdio

Guenter

