Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF93707C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjERJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjERJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:18:17 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE421FEB;
        Thu, 18 May 2023 02:17:58 -0700 (PDT)
Date:   Thu, 18 May 2023 09:17:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atinb.me;
        s=protonmail; t=1684401473; x=1684660673;
        bh=YWVeRBOpdAvOw0Rrw80vuaESvT2YD9shQDDbBZIXc50=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=t7esdlbVj3JHuVNwJjDNaU3HW1NjX7O1DcQ68u0MCZEc7BfVDZMqmNbPcqhNSR1La
         FDxHiQxNsm6svpv02TQ8oFYiWZQOvnUbQwXsT0yCenOI9Rwb6+7+JwlshSc5Sl2eAB
         4lyD9ECmAag8ZbtYr4IfKG4roN1noILYT2VShw5QewYHxqmQLBooBqqoY3tuu35VIx
         ePaQt+g9lLAUCk46t2ut7vGrPElG7iNBG2pjgiOj37l3hAsfEYYPgbsegbB9l79Rck
         lugJ9aI+jn5MY5b5z3x9d7VChuj4hqWt5wuSDZyPVv+VfwoTrNCg7C8ryP3rIlNPwF
         AH63y8O97+FWw==
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
From:   Atin Bainada <hi@atinb.me>
Cc:     linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Atin Bainada <hi@atinb.me>
Subject: [PATCH] media: av7110: Remove unnecessary (void*) conversions
Message-ID: <20230518091729.2431-1-hi@atinb.me>
Feedback-ID: 64551405:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct dvb_demux_feed *) or (struct av7110 *).

Signed-off-by: Atin Bainada <hi@atinb.me>
---
 drivers/staging/media/av7110/av7110_av.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/med=
ia/av7110/av7110_av.c
index a5c5bebad306..00dd6a7fea64 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -78,7 +78,7 @@ static int write_ts_to_decoder(struct av7110 *av7110, int=
 type, const u8 *buf, s
=20
 int av7110_record_cb(struct dvb_filter_pes2ts *p2t, u8 *buf, size_t len)
 {
-=09struct dvb_demux_feed *dvbdmxfeed =3D (struct dvb_demux_feed *) p2t->pr=
iv;
+=09struct dvb_demux_feed *dvbdmxfeed =3D p2t->priv;
=20
 =09if (!(dvbdmxfeed->ts_type & TS_PACKET))
 =09=09return 0;
@@ -837,7 +837,7 @@ static int write_ts_to_decoder(struct av7110 *av7110, i=
nt type, const u8 *buf, s
 int av7110_write_to_decoder(struct dvb_demux_feed *feed, const u8 *buf, si=
ze_t len)
 {
 =09struct dvb_demux *demux =3D feed->demux;
-=09struct av7110 *av7110 =3D (struct av7110 *) demux->priv;
+=09struct av7110 *av7110 =3D demux->priv;
=20
 =09dprintk(2, "av7110:%p, \n", av7110);
=20
--=20
2.40.0


