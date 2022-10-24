Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C42A60B703
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiJXTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiJXTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:14:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572A7D1CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC4EB8128A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD71C433D7;
        Mon, 24 Oct 2022 16:28:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OuR0REi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666628914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SBGplGN9wXQ6YLKsKfvWr4VPlcYFhGIJKX2SJ5Tbgz0=;
        b=OuR0REi93gSfWxI2j9p4sviZJruH4d2XvOwVipHS0AEud70IfxjbJv4Ywxb5KHJwn2D/u7
        sAvY7pYUeLJXrKoTVt/BiPkEqt8iyonJkVCFj+aXSsmTqCeL9TfK9VYGmYwQxE6CxKYNUX
        r917dy9emszDy6uLr7I2HUAU/DVsUV4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aef9884c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Oct 2022 16:28:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: sgi-gru: use explicitly signed char
Date:   Mon, 24 Oct 2022 18:28:23 +0200
Message-Id: <20221024162823.535884-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With char becoming unsigned by default, and with `char` alone being
ambiguous and based on architecture, signed chars need to be marked
explicitly as such. This fixes warnings like:

drivers/misc/sgi-gru/grumain.c:711 gru_check_chiplet_assignment() warn: 'gts->ts_user_chiplet_id' is unsigned

Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/misc/sgi-gru/grumain.c   |  6 +++---
 drivers/misc/sgi-gru/grutables.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 9afda47efbf2..6706ef3c5977 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -152,7 +152,7 @@ static int gru_assign_asid(struct gru_state *gru)
  * Optionally, build an array of chars that contain the bit numbers allocated.
  */
 static unsigned long reserve_resources(unsigned long *p, int n, int mmax,
-				       char *idx)
+				       signed char *idx)
 {
 	unsigned long bits = 0;
 	int i;
@@ -170,14 +170,14 @@ static unsigned long reserve_resources(unsigned long *p, int n, int mmax,
 }
 
 unsigned long gru_reserve_cb_resources(struct gru_state *gru, int cbr_au_count,
-				       char *cbmap)
+				       signed char *cbmap)
 {
 	return reserve_resources(&gru->gs_cbr_map, cbr_au_count, GRU_CBR_AU,
 				 cbmap);
 }
 
 unsigned long gru_reserve_ds_resources(struct gru_state *gru, int dsr_au_count,
-				       char *dsmap)
+				       signed char *dsmap)
 {
 	return reserve_resources(&gru->gs_dsr_map, dsr_au_count, GRU_DSR_AU,
 				 dsmap);
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index 5efc869fe59a..e467d78fcf64 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -351,7 +351,7 @@ struct gru_thread_state {
 	pid_t			ts_tgid_owner;	/* task that is using the
 						   context - for migration */
 	short			ts_user_blade_id;/* user selected blade */
-	char			ts_user_chiplet_id;/* user selected chiplet */
+	signed char		ts_user_chiplet_id;/* user selected chiplet */
 	unsigned short		ts_sizeavail;	/* Pagesizes in use */
 	int			ts_tsid;	/* thread that owns the
 						   structure */
@@ -364,11 +364,11 @@ struct gru_thread_state {
 						   required for contest */
 	unsigned char		ts_cbr_au_count;/* Number of CBR resources
 						   required for contest */
-	char			ts_cch_req_slice;/* CCH packet slice */
-	char			ts_blade;	/* If >= 0, migrate context if
+	signed char		ts_cch_req_slice;/* CCH packet slice */
+	signed char		ts_blade;	/* If >= 0, migrate context if
 						   ref from different blade */
-	char			ts_force_cch_reload;
-	char			ts_cbr_idx[GRU_CBR_AU];/* CBR numbers of each
+	signed char		ts_force_cch_reload;
+	signed char		ts_cbr_idx[GRU_CBR_AU];/* CBR numbers of each
 							  allocated CB */
 	int			ts_data_valid;	/* Indicates if ts_gdata has
 						   valid data */
-- 
2.38.1

