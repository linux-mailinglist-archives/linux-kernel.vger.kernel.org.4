Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD916FC093
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjEIHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEIHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:40:13 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3C0C183D2;
        Tue,  9 May 2023 00:40:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3A4C418013AEE1;
        Tue,  9 May 2023 15:40:05 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     auro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Baisong Zhong <zhongbaisong@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH] media: usb: remove unnecessary (void*) conversions
Date:   Tue,  9 May 2023 15:40:01 +0800
Message-Id: <20230509074001.136455-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct dvb_usb_device *),
(struct filter_info *) or (struct az6027_device_state *).

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/media/usb/dvb-usb-v2/az6007.c   | 16 ++++++++--------
 drivers/media/usb/dvb-usb/az6027.c      | 18 +++++++++---------
 drivers/media/usb/dvb-usb/pctv452e.c    |  4 ++--
 drivers/media/usb/ttusb-dec/ttusb_dec.c |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 62ee09f28a0b..81a498d24075 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -248,7 +248,7 @@ static int az6007_ci_read_attribute_mem(struct dvb_ca_en50221 *ca,
 					int slot,
 					int address)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 
 	int ret;
@@ -290,7 +290,7 @@ static int az6007_ci_write_attribute_mem(struct dvb_ca_en50221 *ca,
 					 int address,
 					 u8 value)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 
 	int ret;
@@ -321,7 +321,7 @@ static int az6007_ci_read_cam_control(struct dvb_ca_en50221 *ca,
 				      int slot,
 				      u8 address)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 
 	int ret;
@@ -367,7 +367,7 @@ static int az6007_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 				       u8 address,
 				       u8 value)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 
 	int ret;
@@ -398,7 +398,7 @@ static int az6007_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 
 static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 
 	int ret;
 	u8 req;
@@ -429,7 +429,7 @@ static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6007_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 
 	int ret, i;
@@ -485,7 +485,7 @@ static int az6007_ci_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6007_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 
 	int ret;
@@ -514,7 +514,7 @@ static int az6007_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6007_ci_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int open)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 req;
diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index f7a6ab29e530..9d0847190748 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -407,7 +407,7 @@ static int az6027_ci_read_attribute_mem(struct dvb_ca_en50221 *ca,
 					int slot,
 					int address)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6027_device_state *state = d->priv;
 
 	int ret;
@@ -449,8 +449,8 @@ static int az6027_ci_write_attribute_mem(struct dvb_ca_en50221 *ca,
 					 int address,
 					 u8 value)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -480,7 +480,7 @@ static int az6027_ci_read_cam_control(struct dvb_ca_en50221 *ca,
 				      int slot,
 				      u8 address)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6027_device_state *state = d->priv;
 
 	int ret;
@@ -526,7 +526,7 @@ static int az6027_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 				       u8 address,
 				       u8 value)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6027_device_state *state = d->priv;
 
 	int ret;
@@ -557,7 +557,7 @@ static int az6027_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 
 static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 
 	int ret;
 	u8 req;
@@ -588,7 +588,7 @@ static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6027_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6027_device_state *state = d->priv;
 
 	int ret, i;
@@ -644,7 +644,7 @@ static int az6027_ci_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6027_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6027_device_state *state = d->priv;
 
 	int ret;
@@ -673,7 +673,7 @@ static int az6027_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6027_ci_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int open)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct az6027_device_state *state = d->priv;
 	int ret;
 	u8 req;
diff --git a/drivers/media/usb/dvb-usb/pctv452e.c b/drivers/media/usb/dvb-usb/pctv452e.c
index 42763c12cf29..2aab49003493 100644
--- a/drivers/media/usb/dvb-usb/pctv452e.c
+++ b/drivers/media/usb/dvb-usb/pctv452e.c
@@ -159,7 +159,7 @@ static int tt3650_ci_msg_locked(struct dvb_ca_en50221 *ca,
 				u8 cmd, u8 *data, unsigned int write_len,
 				unsigned int read_len)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct pctv452e_state *state = d->priv;
 	int ret;
 
@@ -292,7 +292,7 @@ static int tt3650_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 
 static int tt3650_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 	struct pctv452e_state *state = d->priv;
 	u8 buf[1];
 	int ret;
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
-- 
2.30.2

