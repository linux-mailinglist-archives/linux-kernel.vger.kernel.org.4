Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C754740B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjF1I0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjF1IYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:24:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6185730EA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:13:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so1249701a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687940030; x=1690532030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAAzD1zf6ehAjePnVBpKpHgOKHgWRG+m2JGrVjW9fnk=;
        b=XtF/5FKiEtqW97TE7eQWphWjI+POM/V7BL8kDGPHpqGfABLu7enDYGImhj2imAw8XT
         c9AGwngjmY33f6Youish5B9L1WqAu82M6qbupXKpcOL3PvxphyImitzAcMHXm/8wBLkA
         my79iBReJHRjN+TFsk7Q/QC7LtnucO2lKWim6DUt16xwihIDxArZU5ujdI9p7GYbiPOk
         nc/xOkfLEqnBBzXm1FBCZ1D2NgHyqHxcbUoZ1tVgI6hmuk6akaZ5rSpAFvfPBy0H6/Wp
         UCeX+RQR122pBAX6NgkgAWl/WthIn3jJ+NHehQ2VBEhpE45rb8pTQNyTT2xvB3yn3K5g
         BCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940030; x=1690532030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAAzD1zf6ehAjePnVBpKpHgOKHgWRG+m2JGrVjW9fnk=;
        b=MqJuwGSRYwTUb6Xee6TQn7yrVVulN7ii2Azo97AQZV16WQK6FjmecGosZcd8JWjzlI
         yZD2acCrkNjM92KEVq7PqbT2/stO9xmfdOP05VbBKFt0uKKCWhkMirPGmpXdBugnrPFd
         NaDPOseMQ7bQk+tgk2IPKL37TiGGd6YMj+ZP6+EpXY7mfTXcOpKzdGSM0EAT2Cpm1p9h
         EirsjLnujxWSyJT3np5yDI/EwZRFP8QP0mQdzdhDDGfkqBF0p/TfkS8A7l4Z/vCSDDdq
         89db9C4+0uFdYXnMJ3VmYPebT0QMRhdo/9gflieJFwCSwPO+Yn+pmbrIQ9LHSU+bjtqX
         EsUw==
X-Gm-Message-State: AC+VfDxE8jk6RHC5eW5CWQLRZOR7M2KJSHsRFMDmFJi6oP8HxxCHVZ8k
        InpRRtmTZJzF2hzBbdKnC6Q1OPXbD2VbmGXuyVfCJQ==
X-Google-Smtp-Source: ACHHUZ4TQAqqZFi7p64XQp13X/ESAevSlOsyrqVw9VilpZbMXh1J+Z7PLnmcd2EVMzh3kO/WoH3C9g==
X-Received: by 2002:a17:907:1c13:b0:991:db79:5666 with SMTP id nc19-20020a1709071c1300b00991db795666mr792076ejc.4.1687940029841;
        Wed, 28 Jun 2023 01:13:49 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709060c4600b0098654d3c270sm5436723ejf.52.2023.06.28.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 01:13:49 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] mailmap: Add Markus Schneider-Pargmann
Date:   Wed, 28 Jun 2023 10:13:41 +0200
Message-Id: <20230628081341.3470229-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add my old mail address and update my name.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ea246eac7ba1..f9094eefa762 100644
--- a/.mailmap
+++ b/.mailmap
@@ -305,6 +305,7 @@ Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
 Marek Behún <kabel@kernel.org> Marek Behun <marek.behun@nic.cz>
 Mark Brown <broonie@sirena.org.uk>
 Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
+Markus Schneider-Pargmann <msp@baylibre.com> <mpa@pengutronix.de>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
-- 
2.40.1

