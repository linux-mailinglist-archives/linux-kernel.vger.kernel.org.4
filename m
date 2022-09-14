Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389E5B8229
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiINHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiINHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:43:58 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA172B64
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:43:57 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663141433; x=1663400633;
        bh=HppxmTtawa0nrgXshMeDsopmQeqOWidtWPtFGQHpuZY=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=o5kNx5WbyZ0y8VrZOOCtDHVvRmBYC46vP+p9gAONc/8AXyQLuEbc66VXDoAezrdTl
         cPMQRvQ6IXevWE6Qi6pD40TYLOHcchUiIY3MeCsWRJzjIlQVAKHcKr3HumlxVjzVbI
         Rq3DEr2WrKrBP5DxkmCUvF9Kc6yoBqyxXSCdlhw+fDK1u4/xAnJJjJ1ObLKxXxiLi/
         Hj3Lp9nWgggSZSTvnLTDQOv3pBv7clOe7OuAeeCaqsN6TwJ0+Pgx4dxZyGDKoHs1Lt
         TzLUoWu+5i1IPYCFP3KwSnqOj1uYOx36EEFNphmOP6ucCbGucUfI3rjt/D3UjVJgdy
         qX7a0f0KL7l4g==
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Johnothan King <johnothanking@protonmail.com>
Subject: [PATCH] HID: nintendo: check analog user calibration for plausibility
Message-ID: <ByMO0BENaLBLEnGGrPwe37i3VDtN-VuRlSHqkdgk7Q1JHQ16bI_S1QuEtqtSdeV0XcwGMZwrAkFEGaEdXN_Z1qaN2r1cFeZnu5TyHMxszIU=@protonmail.com>
Feedback-ID: 1750573:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Wendt writes:
  Cheap clone controllers may (falsely) report as having a user
  calibration for the analog sticks in place, but return
  wrong/impossible values for the actual calibration data.
  In the present case at mine, the controller reports having a
  user calibration in place and successfully executes the read
  commands. The reported user calibration however is
  min =3D center =3D max =3D 0.

  This pull request addresses problems of this kind by checking the
  provided user calibration-data for plausibility (min < center < max)
  and falling back to the default values if implausible.

I'll note that I was experiencing a crash because of this bug when using
the GuliKit KingKong 2 controller. The crash manifests as a divide by
zero error in the kernel logs:
kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI

Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
Link: https://github.com/DanielOgorchock/linux/issues/36
Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
Signed-off-by: Johnothan King <johnothanking@protonmail.com>
---
 drivers/hid/hid-nintendo.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 6028af3c3aae..7f287f6a75f5 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -793,7 +793,17 @@ static int joycon_request_calibration(struct joycon_ct=
lr *ctlr)
 =09=09=09=09=09    &ctlr->left_stick_cal_x,
 =09=09=09=09=09    &ctlr->left_stick_cal_y,
 =09=09=09=09=09    true);
-=09if (ret) {
+
+=09/*
+=09 * Check whether read succeeded and perform plausibility check
+=09 * for retrieved values.
+=09 */
+=09if (ret ||
+=09=09ctlr->left_stick_cal_x.min >=3D ctlr->left_stick_cal_x.center ||
+=09=09ctlr->left_stick_cal_x.center >=3D ctlr->left_stick_cal_x.max ||
+=09=09ctlr->left_stick_cal_y.min >=3D ctlr->left_stick_cal_y.center ||
+=09=09ctlr->left_stick_cal_y.center >=3D ctlr->left_stick_cal_y.max
+=09) {
 =09=09hid_warn(ctlr->hdev,
 =09=09=09 "Failed to read left stick cal, using dflts; e=3D%d\n",
 =09=09=09 ret);
@@ -812,7 +822,17 @@ static int joycon_request_calibration(struct joycon_ct=
lr *ctlr)
 =09=09=09=09=09    &ctlr->right_stick_cal_x,
 =09=09=09=09=09    &ctlr->right_stick_cal_y,
 =09=09=09=09=09    false);
-=09if (ret) {
+
+=09/*
+=09 * Check whether read succeeded and perform plausibility check
+=09 * for retrieved values.
+=09 */
+=09if (ret ||
+=09=09ctlr->right_stick_cal_x.min >=3D ctlr->right_stick_cal_x.center ||
+=09=09ctlr->right_stick_cal_x.center >=3D ctlr->right_stick_cal_x.max ||
+=09=09ctlr->right_stick_cal_y.min >=3D ctlr->right_stick_cal_y.center ||
+=09=09ctlr->right_stick_cal_y.center >=3D ctlr->right_stick_cal_y.max
+=09) {
 =09=09hid_warn(ctlr->hdev,
 =09=09=09 "Failed to read right stick cal, using dflts; e=3D%d\n",
 =09=09=09 ret);
--=20
2.37.3


