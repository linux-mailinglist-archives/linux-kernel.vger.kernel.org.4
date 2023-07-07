Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2974B224
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGGNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGGNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:47:33 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7B102
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:47:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 4094818640EF;
        Fri,  7 Jul 2023 16:47:28 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rlu8Olt3ypUm; Fri,  7 Jul 2023 16:47:28 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id E7C5A1864A12;
        Fri,  7 Jul 2023 16:47:27 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CVYtIonFtxSs; Fri,  7 Jul 2023 16:47:27 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.23])
        by mail.astralinux.ru (Postfix) with ESMTPSA id B75FD18640EF;
        Fri,  7 Jul 2023 16:47:26 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Rob Springer <rspringer@google.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 5.10] gasket: make interrupt_data NULL after free
Date:   Fri,  7 Jul 2023 16:47:12 +0300
Message-Id: <20230707134712.7019-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gasket common interrupt module was deleted in version 5.13,=20
but there is possible double free in versions 4.19-5.12.

gasket_dev->interrupt_data should be NULL when
gasket_interrupt_init returns error. For example,
it is necessary in gasket_enable_device to avoid
double free.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex dri=
ver")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/staging/gasket/gasket_interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/=
gasket/gasket_interrupt.c
index 864342acfd86..24fa5df0628b 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -337,6 +337,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_d=
ev)
 			sizeof(*interrupt_data->eventfd_ctxs), GFP_KERNEL);
 	if (!interrupt_data->eventfd_ctxs) {
 		kfree(interrupt_data);
+		gasket_dev->interrupt_data =3D NULL;
 		return -ENOMEM;
 	}
=20
@@ -346,6 +347,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_d=
ev)
 	if (!interrupt_data->interrupt_counts) {
 		kfree(interrupt_data->eventfd_ctxs);
 		kfree(interrupt_data);
+		gasket_dev->interrupt_data =3D NULL;
 		return -ENOMEM;
 	}
=20
--=20
2.30.2

