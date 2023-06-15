Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F2731E16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjFOQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjFOQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:33 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C42D68
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:27 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f764e9295dso3560527e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847465; x=1689439465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKrXpTuTUilsXuTU2ZCSebU2HevXpno2wTvArxmiD/I=;
        b=LcO9jiu05ylVTSZzr4SU4EZgahdLYPBHHgeZTetrC4fDUqTA7NAf80UFCBdrM4ZME6
         wohdzicshdhWcqZQOHaM4W4S5IkhVS9gcJGxnl49s2DrGH8WdF35bX/yP7RQWFRuASfN
         ENlP8IkX2JnwDto3haQPfvQ6ClW0WXsf3LsMsp05NQJTuS+ue+nMqU4gV9jE/0bjGUCB
         qLFsZoaUs23gb6fICZGxz225UiEiswUgpYc5v+7BmR3A9U6Yp4bxN4usqgulaiDz41y9
         4a9KN6/MYT5mWSlY6h1nFrBzwyVnwVGHU7fs2hgN90RGamUlAkdctOCDU9cD4gEiNKWo
         vBgg==
X-Gm-Message-State: AC+VfDxMawcGudHlCS7BI6BH94x/xtHEZWEvZelulSNV1YsoKyBDrQqc
        JFPlHp2dtEkCdn9ZFIIjiBM=
X-Google-Smtp-Source: ACHHUZ7Ej3e+4lEdxGSsJ/iaN/wwADaHZ1JD3PLw1zeo3YQ8ZJe+I3Cv3xKG4vBLE3ACixNIFMkPfA==
X-Received: by 2002:a19:7b14:0:b0:4f8:83f:babe with SMTP id w20-20020a197b14000000b004f8083fbabemr1970034lfc.62.1686847465120;
        Thu, 15 Jun 2023 09:44:25 -0700 (PDT)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003f8d770e935sm6143947wme.0.2023.06.15.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:24 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de
Cc:     leit@fb.com, hpa@zytor.com, x86@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/bugs: Break down mitigations configurations
Date:   Thu, 15 Jun 2023 09:44:11 -0700
Message-Id: <20230615164417.3588162-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to compile a kernel today with some of the speculative
mitigations disabled. Even if the kernel has
CONFIG_SPECULATION_MITIGATIONS=n, some Intel mitigations, such as MDS, TAA,
MMIO are still enabled and can only be disabled using a kernel parameter.

This patchset creates a way to choose what to enable or disable, and,
get the mitigations disable if CONFIG_SPECULATION_MITIGATIONS is not
set, as the rest of other mitigations.

Also, we want to print a warning message letting users know that these
mitigations are disabled.

This is a follow up to this discussion: https://lkml.org/lkml/2023/6/12/798

Breno Leitao (3):
  x86/bugs: Create an option to disable MDS
  x86/bugs: Create an option to disable TAA
  x86/bugs: Create an option to disable MMIO vulnerability

 arch/x86/Kconfig           | 31 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c | 23 +++++++++++++++++++----
 2 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.34.1

