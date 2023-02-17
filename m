Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237DB69B426
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBQUqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBQUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:46:16 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7273582AD;
        Fri, 17 Feb 2023 12:46:13 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id i11-20020a9d53cb000000b00690ecb95d46so553751oth.2;
        Fri, 17 Feb 2023 12:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAJyXL5UIHwM0PDIVM8y/73X8JP6CNLgHiTuTaoHORQ=;
        b=ecaghSDQOVxgNd4wLoMmxZpzqWVP8PglnPaurqNsM9wSCje7wdy0HZicIw4w9k/sQF
         +YLzBjr1+unuBARdduaHMXUsS28S8H1hukcnbzU3QtfclGkEy8twQuUVZYJ4RJ5rnQdR
         0GlZKiHDnAJYzcv+q55o+CPTM9nCSSPRdV249+iULn7i3vyQOlxARQqgswc2f4pMPZza
         zBcsFwlq80/iZjQrrjl7CzlDNba40fBWWkRtGxJlb3LLM/HSHebMGpHVs0WFNdfH+jF3
         zgnNOP29oIzLDOIueB5MXcvWlmwHBPKGQdJ9wFilLc7JpTI8spE3oZLqa/6BZcD422UP
         eoDg==
X-Gm-Message-State: AO0yUKWVR2t9JgHQCKmU1zpGoRyajPPydWOVJ6635AyWTjEzwg1PWmid
        el3CnnSIFnAPoGwpX54T2sYCzoC4XQ==
X-Google-Smtp-Source: AK7set8B72/xBl+7uCNRtki2nhD+2cOdPd/Rwz/QkaeJ3AYft7ATAH2hOdk44JNb20yb7lutfhB2LQ==
X-Received: by 2002:a05:6830:4411:b0:68f:339f:832d with SMTP id q17-20020a056830441100b0068f339f832dmr1564469otv.35.1676666772858;
        Fri, 17 Feb 2023 12:46:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o10-20020a9d5c0a000000b0068bce0cd4e1sm2300483otk.9.2023.02.17.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:46:12 -0800 (PST)
Received: (nullmailer pid 1527511 invoked by uid 1000);
        Fri, 17 Feb 2023 20:46:11 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] spi: mpc52xx-psc: Modernize probe
Date:   Fri, 17 Feb 2023 14:45:39 -0600
Message-Id: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPn72MC/x2NywqDMBAAf0X23IUkIgV/pXjIY1MXNA1ZKwHx3
 7v0OAPDXCDUmATm4YJGJwt/ioJ9DBBXX96EnJTBGTcaZ5+YDtxrnHrvKJXRxHFKIZM12YNGwQt
 haL7EVbPy3TaVtVHm/r+8lvv+Aat1zHV1AAAA
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started as just removing open coded parsing and address translation 
of "reg", and ended up with cleaning up the probe functions to use 
modern, preferred APIs for driver probe.

It is compile tested only.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (3):
      spi: mpc5xxx-psc: Remove unused platform_data
      spi: mpc5xxx-psc: Convert probe to use devres functions
      spi: mpc5xxx-psc: Use platform resources instead of parsing DT properties

 drivers/spi/spi-mpc512x-psc.c |  90 +++++++--------------------
 drivers/spi/spi-mpc52xx-psc.c | 138 +++++++-----------------------------------
 2 files changed, 44 insertions(+), 184 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230217-dt-mpc5xxx-spi-0c35dbfe10fa

Best regards,
-- 
Rob Herring <robh@kernel.org>

