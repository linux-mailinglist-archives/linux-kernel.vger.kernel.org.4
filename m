Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEE6D8C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjDFBLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDFBK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB736E96
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680743380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gHoyjTxQNsIixkHB5UoenspL4I5fGKVvNYeLFs2CchU=;
        b=GgfimKgv/spC3Tz8NwS4NAjT5VWiBiToKF1w0gFZV1Ohk6lDhZmCJXDVsm2PidMqmO2hnU
        F6jPW46klkAVsllJOiVoRBv3cwfZRol7MYA5i4YFhieVGhUv9h8x2oF1ZlXcqS4wnYKV/M
        Eo1q5CcLpKHtQ4rSo5JhQaDLg588WgU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ZxC9hGGCOdecqGThSapg2g-1; Wed, 05 Apr 2023 21:09:39 -0400
X-MC-Unique: ZxC9hGGCOdecqGThSapg2g-1
Received: by mail-qt1-f197.google.com with SMTP id s23-20020a05622a1a9700b003e6578904c3so7170897qtc.17
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 18:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680743379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHoyjTxQNsIixkHB5UoenspL4I5fGKVvNYeLFs2CchU=;
        b=I0kgStpqkYFF+UDRcwqLigbWrHgRPMy+tRrEFTf0JXqXmWwVR4JotrnE8YzM8Hbn0z
         nJ4p/HgCtGp46MmuRCTZT1fx6TIxs3zkoG3e81LaCWt83XhYTU0RfQ3r1WIXbPxcyQf5
         zpMqdM9inYb7H/xzv4zXPlhdQv9jc2q3uQ8Ce2zZ0lTY6bQUPk0XYPlYZ6by8g/PF7Fp
         FMG2ZUBxGEur8c2cnuY3Q13Kg5usRtK0OnhtGqMCPjGPiOpR1M0Q1PIdl6wk7+cIUSz0
         ILllAsqzyxWQJwGf0rNqpetTvR/AQ7wn/pBkE9xV9TcHAymkqOqNMUUK/rrWMtiApkcU
         pxXQ==
X-Gm-Message-State: AAQBX9cwHBOKCGvL3O7q/pgi3bi8q9UsTeM9ubl3PzdiaVDex4/CQtFk
        8bUbjSYIP5zjP55wQEmD9SLdvNUbY3LIe7wPkBjqWmzJxYC7dayBUsFuYm17IBHlqMABJ+cRqGd
        uAyiruPS5l65MOBsz9Yp5aSGT
X-Received: by 2002:ac8:5f10:0:b0:3db:7f42:ab0f with SMTP id x16-20020ac85f10000000b003db7f42ab0fmr8396460qta.67.1680743379363;
        Wed, 05 Apr 2023 18:09:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZIbqKuhrrAyaCl1AzzFxLvOp0zEgA8xN+j2J99j+/2qw3uGQfHd57fnQTzqA2s828Rsp3zMQ==
X-Received: by 2002:ac8:5f10:0:b0:3db:7f42:ab0f with SMTP id x16-20020ac85f10000000b003db7f42ab0fmr8396435qta.67.1680743379073;
        Wed, 05 Apr 2023 18:09:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f9-20020ac84989000000b003defe5ab4aesm56174qtq.94.2023.04.05.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:09:38 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: mediatek: fhctl: set varaiables fhctl_offset_v1,2 storage-class-specifier to static
Date:   Wed,  5 Apr 2023 21:09:35 -0400
Message-Id: <20230406010935.1944976-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/clk/mediatek/clk-fhctl.c:17:27: warning: symbol
  'fhctl_offset_v1' was not declared. Should it be static?
drivers/clk/mediatek/clk-fhctl.c:30:27: warning: symbol
  'fhctl_offset_v2' was not declared. Should it be static?

These variables are only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/mediatek/clk-fhctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-fhctl.c b/drivers/clk/mediatek/clk-fhctl.c
index 45e4842cbf04..33b6ad8fdc2e 100644
--- a/drivers/clk/mediatek/clk-fhctl.c
+++ b/drivers/clk/mediatek/clk-fhctl.c
@@ -14,7 +14,7 @@
 #define PERCENT_TO_DDSLMT(dds, percent_m10) \
 	((((dds) * (percent_m10)) >> 5) / 100)
 
-const struct fhctl_offset fhctl_offset_v1 = {
+static const struct fhctl_offset fhctl_offset_v1 = {
 	.offset_hp_en = 0x0,
 	.offset_clk_con = 0x4,
 	.offset_rst_con = 0x8,
@@ -27,7 +27,7 @@ const struct fhctl_offset fhctl_offset_v1 = {
 	.offset_mon = 0x10,
 };
 
-const struct fhctl_offset fhctl_offset_v2 = {
+static const struct fhctl_offset fhctl_offset_v2 = {
 	.offset_hp_en = 0x0,
 	.offset_clk_con = 0x8,
 	.offset_rst_con = 0xc,
-- 
2.27.0

