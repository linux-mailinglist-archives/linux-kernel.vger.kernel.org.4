Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26643744DB3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGBNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EAFE55
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688303956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eRFmQdlxw9jHZzmDSJKkdmLa+U9dm/bDEqnPuYhGWmc=;
        b=Fpx6A1qDo6eWH+40Jkc4em2IxiMG4TvurWxVncBRSbZmUgBWCYHUq+coN6ogd3qWycpCvH
        UL6sbruL7pfkum/Wf/lr9jT7jpNzsIWn5tlZujKd5AgfKFXGOu5/9WdGhj/g2gt1tFcbRR
        Z5mt/Nyif6knwGnVeUC4vYUXe4d3je8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-OrUhQA0JOlWiSb9UKi8EKQ-1; Sun, 02 Jul 2023 09:19:15 -0400
X-MC-Unique: OrUhQA0JOlWiSb9UKi8EKQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7623a4864c2so418324585a.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 06:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688303955; x=1690895955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRFmQdlxw9jHZzmDSJKkdmLa+U9dm/bDEqnPuYhGWmc=;
        b=GUJkEvvylee/vUQ29KLhFBr1CJWraBzgsQw+NgAvipc4X8GGh9pjeBa7m2wRMsUKTD
         LruyPA6EydHHpxx+75QidzaHqJ52S2ox/uOzje1g1xlU8vYHzqTtmQxwhb2Hj6ERAuqf
         3LlBMmrJYExQcKgMlmeOy68whmHnta71Yq/+nTzrG+zp5YIml3QDSFgtpWMD5YSBWafG
         SWiEF5GqGWkJurIADm4khLJ330xpC8E9sPH0R841AkL9KQAFDORwXeznn4vb4bWDBtjJ
         vrrsIGGsTjCjsoEtNylJOu/ZVbN5fJihD0Isx+v1a/biTPDwfarJsRUfBKAu8qtIkJrE
         KjoQ==
X-Gm-Message-State: ABy/qLbEb9IJo6dtBhbv9/C+H/qmTwGe/ustx4yHYpPehZoIrJ7F8DPs
        1zwSCNjAmMEKUxjPx4OBfvLd594peuCbGnq0bX76vLinwkh4K/PrNWQ7tktZXEUxdAIQjaLWejR
        YDuESzeB2+laHS9ErC3aJG3LK3CyjVYYq
X-Received: by 2002:a05:620a:2586:b0:75e:b8b2:864d with SMTP id x6-20020a05620a258600b0075eb8b2864dmr7886252qko.69.1688303955087;
        Sun, 02 Jul 2023 06:19:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFuneZVSX6IXVYJYJruLlFIEsmVSI1DeaBt104pBOCwhHWqqS8FYyR68vARnn6WBmVRLSJZ2Q==
X-Received: by 2002:a05:620a:2586:b0:75e:b8b2:864d with SMTP id x6-20020a05620a258600b0075eb8b2864dmr7886241qko.69.1688303954891;
        Sun, 02 Jul 2023 06:19:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m4-20020ae9f204000000b007628f6e0833sm9145999qkg.100.2023.07.02.06.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:19:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] regulator: set variables clkin_name and xin_name storage-class-specifier to static
Date:   Sun,  2 Jul 2023 09:19:10 -0400
Message-Id: <20230702131910.3437751-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/regulator/raa215300.c:41:12: warning: symbol
  'clkin_name' was not declared. Should it be static?
drivers/regulator/raa215300.c:42:12: warning: symbol
  'xin_name' was not declared. Should it be static?

These variables are only used in their defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/regulator/raa215300.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/raa215300.c b/drivers/regulator/raa215300.c
index 24a1c89f5dbc..d21c6c207226 100644
--- a/drivers/regulator/raa215300.c
+++ b/drivers/regulator/raa215300.c
@@ -38,8 +38,8 @@
 #define RAA215300_REG_BLOCK_EN_RTC_EN	BIT(6)
 #define RAA215300_RTC_DEFAULT_ADDR	0x6f
 
-const char *clkin_name = "clkin";
-const char *xin_name = "xin";
+static const char *clkin_name = "clkin";
+static const char *xin_name = "xin";
 static struct clk *clk;
 
 static const struct regmap_config raa215300_regmap_config = {
-- 
2.27.0

