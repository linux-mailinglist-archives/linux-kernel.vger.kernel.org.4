Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96E3749E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjGFN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjGFN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:57:07 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A891BE2;
        Thu,  6 Jul 2023 06:57:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579d5d89b41so8933667b3.2;
        Thu, 06 Jul 2023 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688651824; x=1691243824;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pZEJ43d+NAMmIrTo551RtzDddBeER6NhBfPjdNhrCGk=;
        b=ZK2545S8+cayJ/SkROlmQsz7hJCI4UZfi3iTrzJ8b2zSaNCVIqcd2GzY5gMizcNpi6
         YdN2Dt1VSJ0CIwXWVXZKUm1HlXMd5M0hVRWCWpwzNxOHiM0n7HjVCPQTRUfc543Rpd6e
         a0XRTrx+eD5D4PZcp1nLcI7Tp6d2ibsWP16HiPesUmu74BLmQYsvf3L5pbk5RThI247Y
         1Awm2Q+zVRXv4WIgYr17AA8CYXuHcazeV92Cre90gvpR1LWkvioSl1x2tF13oXrOKAP0
         +/DhzQjca6Yeif6qTQOZdpywhjarM4anZxFhH2JVE6WeFsDhg3p5bLiAOXKHGq3CrNzn
         0ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651824; x=1691243824;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZEJ43d+NAMmIrTo551RtzDddBeER6NhBfPjdNhrCGk=;
        b=BEA4csXlTkPtGshl3NmFGB+HAEpxO8qs9cyeNVP9H1D3bwuSxl3ucVbV8jJxVFXCpS
         BYe35tZ61ScigmlH9+aPs/BziuN+VAPFoWIRmlGJBpr97s5NcZdXt0ATSN6S3wP9v19o
         4OIK5IIct0ebx8yAi/G8b5mHd3PTpovqmEgUa154/n4yZX5JOk8TZP5w3G1lE2BCdTyX
         ImgRbs1AtjhUxVimyOFxK7qB7TSmNxzdFWimGe1b3kgwS/BKEK3pscrk3KEQqXi6ehdb
         5L/Pa/8Er2cx/C0qZqF0PKjGlGkicZXSAuJkeR9q6TgCuMbnUcq8AhLbIwqw8GYAriTO
         5jQw==
X-Gm-Message-State: ABy/qLamJRalXfEt194Z4OpIXNHJAurN2dn4M7kfbZDzSgHozX85lc16
        nNhIhsXZxqm3TbV+n5Cft2s=
X-Google-Smtp-Source: APBJJlFtMueb3U/FE2QuaSoGLA84VH6d80bL0vcD7tWNpYBm1eqI9OlMiLIE8un9/QkQO/fPnUJjCQ==
X-Received: by 2002:a0d:e241:0:b0:573:d710:6f88 with SMTP id l62-20020a0de241000000b00573d7106f88mr1885685ywe.36.1688651823857;
        Thu, 06 Jul 2023 06:57:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l195-20020a0de2cc000000b00565d056a74bsm354915ywe.139.2023.07.06.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:57:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Jul 2023 06:57:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
Message-ID: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 01, 2023 at 11:22:17PM +0300, Sergey Shtylyov wrote:
> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> return -EINVAL instead.  However, the kernel code supporting SH3/4-based
> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip.
> 

Unfortunately it also affects all sh4 emulations in qemu, and results in
boot stalls with those. There isn't a relevant log to attach because there
is no error message - booting just stalls until the emulation is aborted.

Reverting this patch fixes the problem.

Bisect log is attached for reference. Note that bisect requires applying
commit 7497840d462c ("sh: Provide unxlate_dev_mem_ptr() in asm/io.h"),
which is also the reason why the problem was not observed earlier since
it was hiding behind a build failure.

Guenter

---
# bad: [c17414a273b81fe4e34e11d69fc30cc8b1431614] Merge tag 'sh-for-v6.5-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux
# good: [b5641a5d8b8b14643bfe3d017d64da90a5c55479] mm: don't do validate_mm() unnecessarily and without mmap locking
git bisect start 'HEAD' 'b5641a5d8b8b'
# good: [15ac468614e5e4fee82e1eb32568f427b0e51adc] Merge tag 'media/v6.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 15ac468614e5e4fee82e1eb32568f427b0e51adc
# good: [73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5] Merge tag 'f2fs-for-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect good 73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5
# good: [6843306689aff3aea608e4d2630b2a5a0137f827] Merge tag 'net-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 6843306689aff3aea608e4d2630b2a5a0137f827
# good: [afa92949124abc25ddab1789dd654214e2e1b040] dt-bindings: phy: cdns,salvo: add property cdns,usb2-disconnect-threshold-microvolt
git bisect good afa92949124abc25ddab1789dd654214e2e1b040
# good: [37bd215fc48ef2a399f836d62d2e4a166efb31be] phy: qualcomm: fix indentation in Makefile
git bisect good 37bd215fc48ef2a399f836d62d2e4a166efb31be
# bad: [7497840d462c8f54c4888c22ab3726a8cde4b9a2] sh: Provide unxlate_dev_mem_ptr() in asm/io.h
git bisect bad 7497840d462c8f54c4888c22ab3726a8cde4b9a2
# bad: [01658fe3d6c02992846a038c8111e70ace169295] sh: Refactor header include path addition
git bisect bad 01658fe3d6c02992846a038c8111e70ace169295
# bad: [a8ac2961148e8c720dc760f2e06627cd5c55a154] sh: Avoid using IRQ0 on SH3 and SH4
git bisect bad a8ac2961148e8c720dc760f2e06627cd5c55a154
# good: [bc9d1f0cecd2407cfb2364a7d4be2f52d1d46a9d] sh: j2: Use ioremap() to translate device tree address into kernel memory
git bisect good bc9d1f0cecd2407cfb2364a7d4be2f52d1d46a9d
# first bad commit: [a8ac2961148e8c720dc760f2e06627cd5c55a154] sh: Avoid using IRQ0 on SH3 and SH4
