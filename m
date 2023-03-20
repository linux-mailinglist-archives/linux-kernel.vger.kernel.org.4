Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD726C0AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCTGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:53:14 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6D13DC9;
        Sun, 19 Mar 2023 23:53:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C9C4A1A00ACB;
        Mon, 20 Mar 2023 14:53:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jUXAa7M24Gtc; Mon, 20 Mar 2023 14:53:13 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 848E51A0091B;
        Mon, 20 Mar 2023 14:53:12 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] media: ttusb-dec: remove unnecessary (void*) conversions
Date:   Mon, 20 Mar 2023 14:52:22 +0800
Message-Id: <20230320065222.735-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/media/usb/ttusb-dec/ttusb_dec.c  |  2 +-
 drivers/media/usb/ttusb-dec/ttusbdecfe.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index 38822cedd93a..6bf2e7e0f6d2 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -1128,7 +1128,7 @@ static int ttusb_dec_stop_sec_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
 	struct ttusb_dec *dec = dvbdmxfeed->demux->priv;
 	u8 b0[] = { 0x00, 0x00 };
-	struct filter_info *finfo = (struct filter_info *)dvbdmxfeed->priv;
+	struct filter_info *finfo = dvbdmxfeed->priv;
 	unsigned long flags;
 
 	b0[1] = finfo->stream_id;
diff --git a/drivers/media/usb/ttusb-dec/ttusbdecfe.c b/drivers/media/usb/ttusb-dec/ttusbdecfe.c
index ea25b96b8bbf..dff6bf532ce3 100644
--- a/drivers/media/usb/ttusb-dec/ttusbdecfe.c
+++ b/drivers/media/usb/ttusb-dec/ttusbdecfe.c
@@ -76,7 +76,7 @@ static int ttusbdecfe_dvbt_read_status(struct dvb_frontend *fe,
 static int ttusbdecfe_dvbt_set_frontend(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
+	struct ttusbdecfe_state *state = fe->demodulator_priv;
 	u8 b[] = { 0x00, 0x00, 0x00, 0x03,
 		   0x00, 0x00, 0x00, 0x00,
 		   0x00, 0x00, 0x00, 0x01,
@@ -103,7 +103,7 @@ static int ttusbdecfe_dvbt_get_tune_settings(struct dvb_frontend* fe,
 static int ttusbdecfe_dvbs_set_frontend(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
+	struct ttusbdecfe_state *state = fe->demodulator_priv;
 
 	u8 b[] = { 0x00, 0x00, 0x00, 0x01,
 		   0x00, 0x00, 0x00, 0x00,
@@ -137,7 +137,7 @@ static int ttusbdecfe_dvbs_set_frontend(struct dvb_frontend *fe)
 
 static int ttusbdecfe_dvbs_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd *cmd)
 {
-	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
+	struct ttusbdecfe_state *state = fe->demodulator_priv;
 	u8 b[] = { 0x00, 0xff, 0x00, 0x00,
 		   0x00, 0x00, 0x00, 0x00,
 		   0x00, 0x00 };
@@ -158,7 +158,7 @@ static int ttusbdecfe_dvbs_diseqc_send_master_cmd(struct dvb_frontend* fe, struc
 static int ttusbdecfe_dvbs_set_tone(struct dvb_frontend *fe,
 				    enum fe_sec_tone_mode tone)
 {
-	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
+	struct ttusbdecfe_state *state = fe->demodulator_priv;
 
 	state->hi_band = (SEC_TONE_ON == tone);
 
@@ -169,7 +169,7 @@ static int ttusbdecfe_dvbs_set_tone(struct dvb_frontend *fe,
 static int ttusbdecfe_dvbs_set_voltage(struct dvb_frontend *fe,
 				       enum fe_sec_voltage voltage)
 {
-	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
+	struct ttusbdecfe_state *state = fe->demodulator_priv;
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -187,7 +187,7 @@ static int ttusbdecfe_dvbs_set_voltage(struct dvb_frontend *fe,
 
 static void ttusbdecfe_release(struct dvb_frontend* fe)
 {
-	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
+	struct ttusbdecfe_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
-- 
2.11.0

