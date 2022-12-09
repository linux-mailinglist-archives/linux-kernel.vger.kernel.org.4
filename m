Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3F3648A67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLIVx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLIVx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:53:56 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199527CCF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:53:54 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id cg5so4692577qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CogeahCDAeDbkConNno5D9xjUNwnhFqYTxCoNNSIi44=;
        b=gwMxZGYCwrO7jsCEDiClzh8A+LsHYs0+15yt63BjNCy9KjrzUYquIcXyHPsrWLu4aF
         lCqP/akNWkQuJWc2jILHnXhhokRpvFk2c39kf67zvtYXD3DmCKPMALytDx85LPEFwEod
         PTWxkjMNoP+AH8V4TfeiVGFpasFF5sMC2OeAa91RrrcG/Ps4Riufsf7MxvHQo74EbVCB
         Konk9THbEDwIitcvNth0DA1wMDfHcRVIRZOPRphuab1qx0RsRYzdRMIOOlDsbCtHV6qy
         Slvg4fD/GYEfZ9Supz0pUrMbfFAaMKYJnoGviAJ+U5cpIqELkbqvcP54ciHNUy2hd64m
         sTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CogeahCDAeDbkConNno5D9xjUNwnhFqYTxCoNNSIi44=;
        b=XhP+GIWk0tXITMk4zPIAaXMdD11TbY8h/0mEqC9Egb2OJXvwCVEaYeteo+LsccL1Gs
         pCDgndaDZFJ7WwkiIoUK+RsQlv76v8MlhFnSMS92O1NjlvGMIp4Da+ZJAO5LgRrldwj7
         iLWcLtUV82Nl7EaVKre7qROQ8kEQI56reub9oUGrqRTPYqUSieqwjL/wE89GdKXu+cv5
         CwPulLzOUSkKjppxC5PVH2WFGIE8svVKTMstsbFHiSRa/EgISkw3wAN1bgFtwpAk0w8A
         xMHPv9kBLRcI0lGXr6tkSnKVuuaWEJvlhgbmRrd9fSD9JwvkHjDgwkbELpG8zj46iYRY
         9vHg==
X-Gm-Message-State: ANoB5pmPN/SipmBTQoJtKso1AS/1vn71a1pQQtobv5dsdMaBj55kf9ms
        XKWwDVlXKmRXhdkupN88xOY=
X-Google-Smtp-Source: AA0mqf5Se2vnZARHxGLZnlgo8WFco4pE56l2BBYu/6YHuNmd5/aKI85W/31ebRGVZbDr/+KajsjjEg==
X-Received: by 2002:ac8:748d:0:b0:3a5:f909:8a7b with SMTP id v13-20020ac8748d000000b003a5f9098a7bmr9446273qtq.58.1670622833978;
        Fri, 09 Dec 2022 13:53:53 -0800 (PST)
Received: from Dell-Inspiron-15.. ([2601:18c:8380:74b0:e8e5:f40c:d741:8f07])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fee9a70343sm712718qkp.14.2022.12.09.13.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:53:53 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     linux-stm32@st-md-mailman.stormreply.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <benwolsieffer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] ARM: v7m: handle faults and enable debugging
Date:   Fri,  9 Dec 2022 16:48:11 -0500
Message-Id: <20221209214824.3444954-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables real exception handlers on no-MMU systems,
increasing robustness in the face of buggy user- or kernel-space
software. Previously, any fault would trigger the invalid exception
handler, which would hang the system. With this series, faults only
kill the offending process and allow the rest of the system to
continue operating.

The second patch in this series adds support for undefined instruction
hooks, enabling software breakpoints through ptrace. Using this
functionality currently requires a patch to gdb.

This series has been tested on an STM32F746 (Cortex-M7).

I would appreciate feedback in particular on the following questions:
* Is the fault table formatting acceptable? Or should the lines be
  wrapped/shortened?
* Does my chosen mapping between faults and signals make sense?

This time around this series has been sent to linux-stm32 as well, as I was
previously unaware of that list.

Ben Wolsieffer (2):
  ARM: v7m: handle faults
  ARM: v7m: support undefined instruction hooks

 arch/arm/include/asm/traps.h |   2 +
 arch/arm/include/asm/v7m.h   |  29 +++++++
 arch/arm/kernel/Makefile     |   2 +-
 arch/arm/kernel/entry-v7m.S  |  68 ++++++++++++++-
 arch/arm/kernel/traps-v7m.c  | 162 +++++++++++++++++++++++++++++++++++
 5 files changed, 258 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/kernel/traps-v7m.c

-- 
2.38.1

