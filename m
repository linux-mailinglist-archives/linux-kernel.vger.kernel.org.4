Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF96F6422
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjEDEtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDEto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:49:44 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 25331199E;
        Wed,  3 May 2023 21:49:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9998B180126FE4;
        Thu,  4 May 2023 12:49:40 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH] media: dvb-usb: pctv452e: remove unnecessary (void*) conversions
Date:   Thu,  4 May 2023 12:48:22 +0800
Message-Id: <20230504044823.89197-1-suhui@nfschina.com>
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

No need cast (void*) to (struct pctv452e_state *).

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/media/usb/dvb-usb/pctv452e.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/pctv452e.c b/drivers/media/usb/dvb-usb/pctv452e.c
index da42c989e071..42763c12cf29 100644
--- a/drivers/media/usb/dvb-usb/pctv452e.c
+++ b/drivers/media/usb/dvb-usb/pctv452e.c
@@ -108,7 +108,7 @@ struct pctv452e_state {
 static int tt3650_ci_msg(struct dvb_usb_device *d, u8 cmd, u8 *data,
 			 unsigned int write_len, unsigned int read_len)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *buf;
 	u8 id;
 	unsigned int rlen;
@@ -160,7 +160,7 @@ static int tt3650_ci_msg_locked(struct dvb_ca_en50221 *ca,
 				unsigned int read_len)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	int ret;
 
 	mutex_lock(&state->ca_mutex);
@@ -293,7 +293,7 @@ static int tt3650_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 static int tt3650_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 buf[1];
 	int ret;
 
@@ -361,7 +361,7 @@ static void tt3650_ci_uninit(struct dvb_usb_device *d)
 	if (NULL == d)
 		return;
 
-	state = (struct pctv452e_state *)d->priv;
+	state = d->priv;
 	if (NULL == state)
 		return;
 
@@ -379,7 +379,7 @@ static void tt3650_ci_uninit(struct dvb_usb_device *d)
 static int tt3650_ci_init(struct dvb_usb_adapter *a)
 {
 	struct dvb_usb_device *d = a->dev;
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	int ret;
 
 	ci_dbg("%s", __func__);
@@ -417,7 +417,7 @@ static int pctv452e_i2c_msg(struct dvb_usb_device *d, u8 addr,
 				const u8 *snd_buf, u8 snd_len,
 				u8 *rcv_buf, u8 rcv_len)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *buf;
 	u8 id;
 	int ret;
@@ -516,7 +516,7 @@ static u32 pctv452e_i2c_func(struct i2c_adapter *adapter)
 
 static int pctv452e_power_ctrl(struct dvb_usb_device *d, int i)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *b0, *rx;
 	int ret;
 
@@ -567,7 +567,7 @@ static int pctv452e_power_ctrl(struct dvb_usb_device *d, int i)
 
 static int pctv452e_rc_query(struct dvb_usb_device *d)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *b, *rx;
 	int ret, i;
 	u8 id;
-- 
2.30.2

