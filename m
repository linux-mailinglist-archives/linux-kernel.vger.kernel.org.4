Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D597411E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF1NDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjF1NDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782B42110;
        Wed, 28 Jun 2023 06:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D81B61328;
        Wed, 28 Jun 2023 13:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EACC433C0;
        Wed, 28 Jun 2023 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687957428;
        bh=P66gHZJ7j77wWis96oF6KJ5NyIpuzPIhqa8Ws293cdw=;
        h=From:To:Cc:Subject:Date:From;
        b=IlYtPlZZ3p701Gno3JE7mrUNMem3fznktwgwgxczfNagLUHKsLJ4MokWmH/PcfHDD
         AU3/lYyNyvNbEV2gdEcwUzW6dgkH50DWwOdNR7zruAI/Nc4VtGhIsW33HwR/a1YIOX
         Yw0g1UjWDOrQNMUh///RlDNcRgjkWqGL/tRcfx786OjVKvbbzN8E+RVSqMR5xO+hn4
         a5CnSpQyG5dPI5OUMw9OQCPmqRPoqJdEcusDCQYCpXOhDuGeB/1sbR7lB/d+vUnlKq
         W+IWT55bRjAA6ec32RF5OPlK5ob1TYu+prViY84ixJ/2l8NavObCvC03t2x49T75C7
         LhPX409PkP5rQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1qEUpl-000rfb-2F;
        Wed, 28 Jun 2023 15:03:45 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: dvb: mb86a20s: get rid of a clang-15 warning
Date:   Wed, 28 Jun 2023 15:03:39 +0200
Message-ID: <20230628130339.206261-1-mchehab@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang-15: this warning is produced:

	../drivers/media/dvb-frontends/mb86a20s.c:1572:6: error: variable 'active_layers' set but not used [-Werror,-Wunused-but-set-variable]
	        int active_layers = 0, pre_ber_layers = 0, post_ber_layers = 0;
	            ^
	1 error generated.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-frontends/mb86a20s.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/mb86a20s.c b/drivers/media/dvb-frontends/mb86a20s.c
index b74b9afed9a2..125fed4891ba 100644
--- a/drivers/media/dvb-frontends/mb86a20s.c
+++ b/drivers/media/dvb-frontends/mb86a20s.c
@@ -1569,7 +1569,7 @@ static int mb86a20s_get_stats(struct dvb_frontend *fe, int status_nr)
 	u32 t_post_bit_error = 0, t_post_bit_count = 0;
 	u32 block_error = 0, block_count = 0;
 	u32 t_block_error = 0, t_block_count = 0;
-	int active_layers = 0, pre_ber_layers = 0, post_ber_layers = 0;
+	int pre_ber_layers = 0, post_ber_layers = 0;
 	int per_layers = 0;
 
 	dev_dbg(&state->i2c->dev, "%s called.\n", __func__);
@@ -1589,9 +1589,6 @@ static int mb86a20s_get_stats(struct dvb_frontend *fe, int status_nr)
 
 	for (layer = 0; layer < NUM_LAYERS; layer++) {
 		if (c->isdbt_layer_enabled & (1 << layer)) {
-			/* Layer is active and has rc segments */
-			active_layers++;
-
 			/* Handle BER before vterbi */
 			rc = mb86a20s_get_pre_ber(fe, layer,
 						  &bit_error, &bit_count);
-- 
2.41.0

