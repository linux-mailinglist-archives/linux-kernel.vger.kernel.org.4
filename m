Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7B6BE460
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCQIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCQIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:54:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83164B38
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a16so72441pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJa5hzcSxHV1UNHl0Z+HAwG9DVOliVTpLOBb+bOdpD8=;
        b=R4cNe28PtnjPGgY/kdH3vzhyNLnQ6gY5ABdja/hdkzunBPkU8EpJg5C/2JCJWPvghj
         otjBnWdxKLPZ2TeRlzc8bJHrEkKieBtWFQs4Cm1BvSzJSbnmgcAaz4zXslG+3R/61PRq
         dAlGCwduEUBQr16jG7JWJ9cZqID6XD0+EvgxxUq2a8Eohm9l850MsXzBqWAlRaRg2Pss
         VOroDJxN97aUmvEQqIDpgswfvIlb0uuAqikiNBbHnlpp3PvISdZCc1pNcUH9OO2vQt88
         J+WgwomI7hSn6XbYGQDKhDbIbXR4Y6LCkfzaas0PV3Bc+T7ksSc3ayjjBUI4qypE9Bb+
         /2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJa5hzcSxHV1UNHl0Z+HAwG9DVOliVTpLOBb+bOdpD8=;
        b=fvn9Lgs9HOeJU0ArKP/rOxBNvt1oApVK3H66mnEQjUuWLR3oMjFTuL++7gjCFutws+
         WaUQwQzbPLf1ENpnYeGs7/pQ9pK/Cpi9JRQIrehBntLPxNasMF9JE4XbSe6wM3h49bJH
         rJMnyobAueUo9soHX4CrXP3fmw13XtkE9kUVRAzQoH6mAcy3FP7vUu06BO7NemMFJwAe
         K8/TI0QRQs8RTjtj1cZY6FhXBQ9+sDeNZb44XEUrgxt5hkoJmBaUiVwMUpuaq1jlDGnA
         GSvBz9XWKUqo/Rf8UfS5G2dELPS/CO5uqTcI4Y2giQJ2LAnhJgUZ6FFnYokfYfo8Cr8E
         Kyvw==
X-Gm-Message-State: AO0yUKVnz0HEXq692z1JNWqi9oQwRdGbrzCe/Ru1YJ7bFqEWGy9F/aWF
        9UVCAu1gN5ka7qP3RxuuLZ0SUvDIlvfVmOTf
X-Google-Smtp-Source: AK7set/XuOaLwpKh2z63MgT5704V4VjkaxmjLBY4VKzkYMZnI1quUuHQT8a9s30en2oYgjKVj69rQg==
X-Received: by 2002:a17:90b:3b84:b0:237:8c42:27bc with SMTP id pc4-20020a17090b3b8400b002378c4227bcmr7272842pjb.13.1679043246320;
        Fri, 17 Mar 2023 01:54:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b0019a96a6543esm1030775plb.184.2023.03.17.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:54:05 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ARM: hisi: Support Hi3798 SoC
Date:   Fri, 17 Mar 2023 16:53:43 +0800
Message-Id: <20230317085347.10147-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables booting Hi3798 SoCs.

v2: add dt-bindings

David Yang (4):
  ARM: hisi: Add S40 IO map
  ARM: hisi: Add S5 IO map
  ARM: hisi: Support Hi3798 SoC
  dt-bindings: arm: hisilicon: Add Hi37xx SoCs

 .../bindings/arm/hisilicon/hisilicon.yaml     |  28 ++++
 arch/arm/mach-hisi/Makefile                   |   2 +-
 arch/arm/mach-hisi/core.h                     |   7 +
 arch/arm/mach-hisi/headsmp.S                  |  36 +++++
 arch/arm/mach-hisi/hisilicon.c                |  72 +++++++++-
 arch/arm/mach-hisi/hotplug.c                  | 128 +++++++++++++++++-
 arch/arm/mach-hisi/platsmp.c                  | 122 +++++++++++++++++
 7 files changed, 388 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-hisi/headsmp.S

-- 
2.39.2

