Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031863C3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiK2PiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiK2PiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:38:17 -0500
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D593F50D63
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:38:13 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 02Ozp6txJm9gv02P0pWxE6; Tue, 29 Nov 2022 16:20:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669735208; bh=un5pkqfd2ZfN3kAgLbVdkbNuttBIuRIZqLiIVNxtmm0=;
        h=From:To:Subject:Date:MIME-Version;
        b=EyfefxKuuSj2+AvB3YIylF4jbtot8JYpnJCoE1O7Wc5fR4MYNPkeBnjfH0QIoKzf7
         tACqSTrGNU80JmFrL+mMf46sEfCAfgfdRKZ+1TY9hOeKwAzFuI9v7FTL3Xt/lWAqEY
         EhWxmKKqaw8zbQzoA3JJOu7XCLJ28FO/VdFRs3+kqVcq5KE95qfJKNH//yt72PpBTf
         noifRQrUXsSYyCwOffOMku1mgy12cb7nHWb3RxZ6ucqiaJc59vMo9VVKcDk0XFw9Gc
         xfWnigHpc7cBxTat1PrsgkKtpv45bKY+JrD6f66WCtd36scCR9i87JXo1omAxwuBTn
         mxMRDlUNpr3BA==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 0/3 RESEND] ads7846: fix support for ADS7845
Date:   Tue, 29 Nov 2022 16:19:56 +0100
Message-Id: <20221129151959.26052-1-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIskOuT1HglKhr+bn5x7ob2H9LawILPSzIGtOZ4MOH3F3sahwiBwyt6aJZhGRhP6U43aerw0WAP08aI+Em2cTkqpfpA16/Ptuze1/iAngB9fAC/xqclb
 4Jbg1jw8zpfU4p8TAGLrrGaPcY5FfwoQCu8MWCbiyxdQ4skihvKGp8s6p4JBPh+a94T0gZpk3oPchu55y2hxyq9Hk3Pzr0YFx9Hvp8uzA7e+FdikP+jvxxK3
 CZxCdVyd4+guLSDoYwpcG57sic5kF9lPJ3OOIenPA5znrcDBzSgQrEHWRFuaobpKp5k97B4CeRPZMwlbK3aJNbihCH23Mo1Lud/HHriud8TXZrpVQaLXrhNn
 sI6+NvdiyvxVGgXlDYiHEComaiaTV759gvEWMHtzy5mVPfeXd4iJ83tQi0ZYYhf/9GiLiw8VNmrl9vBTrUDhrXftbGpecPYdhBFpVJzq45HGy0qCU9d0EKou
 EHUJbOO1jzFeIuQ9b9AUo1ftSZgxbnWFxr2KQRbqgA6+0A7OHGQv88cb5J6d0gWWeOdA2SgqeOGhM2r3PzExACrfyB/g/8jTeFCo1frAa3LJ31AhZj19YXKv
 bdWSeLaQ7qh1tH5T5RaqfwtN
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 support is buggy in this driver.
These patches fix various issues to get it work properly.

Luca Ellero (3):
  ads7846: don't report pressure for ads7845
  ads7846: always set last command to PWRDOWN
  ads7846: don't check penirq immediately for 7845

 drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.25.1

