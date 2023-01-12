Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B53666C95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbjALIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjALIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:39:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E084711A37;
        Thu, 12 Jan 2023 00:38:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l22so13243284eja.12;
        Thu, 12 Jan 2023 00:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBER51nUqdbhMcmVvfzoFzE/H+kk4GVd3N14pPK6ygs=;
        b=Tl8cFEMG9z/sNqo7hwBop0A4Wf7QeXvq1lFQipIfF6WmnKGzrTUrB2QipSBsTqHMro
         PPBhD8qQhqr0887Q2lcQyY6EbbhKRc1fLUcyhHRAKcmWqdmY8b775j6/XN7bXHDVccsc
         mp7EeU/wvnw7nAltdXgzWId0Oyrh2FPXMsGgM8y/gJrc6tUAqeHtfS+q72QcPtMwr/N0
         +S9EqNQGXjdf54VCw12L05ueuqJ2hTN1CyqtYG79cKVHYJLXpbgxkwD1KHYnTMOXMBXg
         fYYeU51o+H0/umYnac1ppM1rnLmVzr8SH6aRhcQ2hh1ssF9HV9wLTkWhnIxIXuV2wZwp
         O/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBER51nUqdbhMcmVvfzoFzE/H+kk4GVd3N14pPK6ygs=;
        b=a3pqivoOzqjTGDaYoPto5jDeXWPGsoYYESqe/RA5CBcDqqX8oW+5FpItdvvJe1srIe
         JWgPTczy+xkPrU/e1Asr1hYhy2KIDuAPwAoQVgoUr4n7Qj3+0HTgtaj4FKV7Yn16O7oT
         8Ii6nZEmc4rxz+3cxrIAPIvaqXoco6/oJNYSmNZaJ9WhycD+tVB0t4k2zyPulG0tIq2s
         XZ1mMau3TiYUx8A7CBRgS5o2kNAQ5QAI88nQ1O+1EhXxmKSwQ0gtGpI2l1m4zaSR8frt
         ynztGgwdeYX1x7U1b7GHBza5goIEY5mG2XQTHRMEoQfoJCd8ZKzRc4BN75en1Mb9rGU6
         R+wA==
X-Gm-Message-State: AFqh2koyYTDgdqWBVFvdRrYwK0rF0LZUhmKpCly5LbqK2LJQnyrV4sWC
        18/y610S2LF7AbskP6s6Nak=
X-Google-Smtp-Source: AMrXdXslHv6bQaFf+w9T/xsMdpR7POPVgrD1bt24i7J8a2fFNZ9xnpG+J0I13t5g1niHsNdwPwjSkQ==
X-Received: by 2002:a17:907:3445:b0:7ad:c5b7:1c79 with SMTP id ac5-20020a170907344500b007adc5b71c79mr53803391ejc.45.1673512687326;
        Thu, 12 Jan 2023 00:38:07 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm5670410ejv.189.2023.01.12.00.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:38:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/4] Further code removal after Arnd's latest cleanup
Date:   Thu, 12 Jan 2023 09:37:42 +0100
Message-Id: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd,

you have shared some further clean-up activities in linux-next (see the
specific commits mentioned in the patches for details). This allows us to
clean up even more code in the repository.

Please pick these patches on top of the commits mentioned in the
corresponding patches (I assume that it is your soc-next tree?).


Best regards,

Lukas

Lukas Bulwahn (4):
  ARM: s3c: remove obsolete s3c-cpu-freq header
  ARM: pxa: remove further dead code after pxa93 support removal
  usb: remove OMAP USB Device Controller and OHCI support for OMAP1/2
    chips
  ARM: debug: remove references in DEBUG_UART_8250_SHIFT to removed
    configs

 arch/arm/Kconfig.debug                   |    3 +-
 arch/arm/mach-omap1/board-osk.c          |    5 -
 arch/arm/mach-omap1/omap-dma.c           |  455 ----
 arch/arm/mach-omap1/usb.c                |   67 -
 arch/arm/mach-omap1/usb.h                |    4 -
 drivers/usb/gadget/udc/Kconfig           |   15 -
 drivers/usb/gadget/udc/Makefile          |    1 -
 drivers/usb/gadget/udc/omap_udc.c        | 3001 ----------------------
 drivers/usb/gadget/udc/omap_udc.h        |  207 --
 drivers/usb/host/Kconfig                 |    8 -
 drivers/usb/host/Makefile                |    1 -
 drivers/usb/host/ohci-omap.c             |  435 ----
 include/linux/omap-dma.h                 |   28 -
 include/linux/soc/pxa/cpu.h              |   47 -
 include/linux/soc/samsung/s3c-cpu-freq.h |  145 --
 15 files changed, 1 insertion(+), 4421 deletions(-)
 delete mode 100644 drivers/usb/gadget/udc/omap_udc.c
 delete mode 100644 drivers/usb/gadget/udc/omap_udc.h
 delete mode 100644 drivers/usb/host/ohci-omap.c
 delete mode 100644 include/linux/soc/samsung/s3c-cpu-freq.h

-- 
2.17.1

