Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B366BE5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCQJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCQJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:39:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C474C241DB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:39:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l12so3824732wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devialet.com; s=google; t=1679045953; x=1681637953;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hOBn4e5T6xUiNDEfS19L/JMf68DDP0k8F17VJNjYBf4=;
        b=f2uRhrAEZPdb5nx02NGJvub4q39rm2gGkKuF4cWZZoe+I7+t/zCQHdTHCCwEE9AtKA
         NLzbPUg7DOJUrl/wq+e+pZZndixT1cbMcL6VctFbtv/HgDGZ6Wn2/ve6hKwoVJ+xZIwM
         Hi5EM5+gGBKi9Vr+2yan0yohW5dm2Ql6xf1P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045953; x=1681637953;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOBn4e5T6xUiNDEfS19L/JMf68DDP0k8F17VJNjYBf4=;
        b=dzrKlVsqe6pz7B1eGq5dzTTWxtI0XmrUzCyupRjuWWkZJcYBCyu8EQejAbghzArWdI
         uMG8sPIzKjp0gk0wVtrKAzACJoRJCppQK/FXUmzZzf1lVTHZFsNM3V9VQnO5mkkUOaI0
         TVdAteBJf5zdOLs2Fu6dVJuhaxFJyAH6vH5k+I1VcQvUGc1XBELr38PH7ex6bczA2Udg
         vOZEdDziGCYDmF3C+8b2dGROWv2NM2uKwmxceHjsKff2ilJtiwc+QFLazshurvb1fhic
         yZbzW4GNpWkyYdypbim9jrE3mX5L9zxt9w1FBqUrJ05p5IlQtY/j5tAGxQRinS1ftZEv
         WjJA==
X-Gm-Message-State: AO0yUKUMAR+ZPxIeZ3PCu99xf89HHGAQe6SqggH+pm+j7zjrUTpudr+B
        KRRR9N/B0r4XrkPFCbNB3QZtD1dvXEug7ZpvMdFcB3wV0Jy5TuGLG+RyWE4JNv1O/baG6+EmU8D
        d+rMWNn2T+EoHQAOBZxH/OKjHqH0EJmB7Tg==
X-Google-Smtp-Source: AK7set8rxqSrPsUEwq7946/+YdBForD0F5uTGEskekj4jOjfaaE0heXJDBD8UI5h7EDCfSYVUXRRtA==
X-Received: by 2002:a5d:5550:0:b0:2cf:e37f:2b with SMTP id g16-20020a5d5550000000b002cfe37f002bmr5922024wrw.0.1679045953336;
        Fri, 17 Mar 2023 02:39:13 -0700 (PDT)
Received: from nicolas-laptop.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b002c592535839sm1530823wrr.17.2023.03.17.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:39:13 -0700 (PDT)
From:   Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Subject: [PATCH 0/2] regulator: pca9450: add LOADSW regulator
Date:   Fri, 17 Mar 2023 10:39:09 +0100
Message-Id: <20230317093911.1254530-1-nicolas.heemeryck@devialet.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the load switch present in the PCA9450.

Nicolas Heemeryck (2):
  regulator: pca9450: Add LOADSW regulator
  bindings: regulator: pca9450: Add LOADSW regulator

 .../regulator/nxp,pca9450-regulator.yaml      | 14 ++++++++
 drivers/regulator/pca9450-regulator.c         | 32 +++++++++++++++++++
 include/linux/regulator/pca9450.h             |  4 +++
 3 files changed, 50 insertions(+)

-- 
2.34.1


-- 
- Confidential -
