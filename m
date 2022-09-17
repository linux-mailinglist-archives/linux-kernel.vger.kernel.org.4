Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB385BB604
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIQEPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQEPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:15:02 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D272530F7C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:14:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id v15so18086981qvi.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ytCQaxIOlYtm/dKsLmATBZ59cx0tQDdf4JFFJe4Z8fg=;
        b=mebDyI+PjI8xMukc3qC6r4xPbMiyVAY0UKPfWRlW4lbjLnmrB5auR5a8pDWq3X3fBG
         AdRivziUkOaa1qxGMgQpEasioyApa6Xw+fnbSJt154O5qqL5VE9yHCkbrs1uBNKLYC4j
         v7WYSB7iCixUjYpBEnLbrHhEu6Xaem+QigfJ1/vxHHO27vi6nQxtdVeg1+sj+qsawO/g
         6oWczHkZLm052GfFXZVSEuPubuUkMR82MtSpZqfW2V0Knwj1BBMJD1cnjjt0E/qEnFOK
         5Ad+bn600ERE3I38ni6BBVavhIKjW/UMKk9uufU3hz7aJ9RUNDyTawLqThmOXoEJfDjK
         jxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ytCQaxIOlYtm/dKsLmATBZ59cx0tQDdf4JFFJe4Z8fg=;
        b=d7l16w/L9eeBxbwfCdMjrg87ft4XYczi12yAfAimKZDbdSesLv+gp0BfIvkx0dIb/x
         3/HF4pNfpm1o2H2ABDgKLWFuHILAsFpLozx8Hm3O5Lo+QrkePnAdD1k5hbHrSh7rxHhI
         3zs8q7g+OdKxBEP4B2b+uudnK4xtaEtBO3/4oKrbn/UddpKhRAE6mIwehj5Vvg/5D8NG
         QRvM0aVi19DSQBxSg569/SMifLP1rD0Cp/GlkouOpoOV9/0+mVGCyHwyMTmbIaA+Fnmq
         5BfWGs6d75cUyZ5vvFh1s1Z7RYNmX4TUQFB2d9iZQSCZraPnSbVSiBc9TKMJtrEmqGaY
         lGzQ==
X-Gm-Message-State: ACrzQf1YeIDA1djBrJxVGuS9e2E3XwYfbLnPYQlKNXsHaJnOMAWU/3bT
        BoweH1ijxF/RzRQBaQBAxdz4OptOew2Edg==
X-Google-Smtp-Source: AMsMyM4ar7sfvHWOaWCd1ejCOTPtFmGdDCvJzta3Q3qG8TBX1ljQ28e1zpeoF26ryXv1I/eUPu5A2g==
X-Received: by 2002:a05:6214:c4e:b0:4ac:7870:81b3 with SMTP id r14-20020a0562140c4e00b004ac787081b3mr6424157qvj.93.1663388099017;
        Fri, 16 Sep 2022 21:14:59 -0700 (PDT)
Received: from Dell-Inspiron-15.. (c-73-149-35-171.hsd1.ma.comcast.net. [73.149.35.171])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm7345206qkb.108.2022.09.16.21.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:14:58 -0700 (PDT)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ben Wolsieffer <benwolsieffer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] ARM: v7m: handle faults and enable debugging
Date:   Sat, 17 Sep 2022 00:13:50 -0400
Message-Id: <20220917041403.4191780-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.37.2
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
2.37.2

