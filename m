Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC1702CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjEOMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjEOMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:30:04 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100710E5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:30:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id F259C1866F9B;
        Mon, 15 May 2023 15:29:57 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gadpIjkrl_U1; Mon, 15 May 2023 15:29:57 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 9B6821866F6B;
        Mon, 15 May 2023 15:29:57 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R1ktNqj3NV5v; Mon, 15 May 2023 15:29:57 +0300 (MSK)
Received: from ekaterina-MACHD-WXX9.astralinux.ru (unknown [10.177.15.69])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 6366C1866739;
        Mon, 15 May 2023 15:29:56 +0300 (MSK)
From:   Esina Ekaterina <eesina@astralinux.ru>
To:     Rob Springer <rspringer@google.com>
Cc:     Esina Ekaterina <eesina@astralinux.ru>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 5.10] staging: gasket: interrupt: Clean interrupt_data after free
Date:   Mon, 15 May 2023 15:29:50 +0300
Message-Id: <20230515122950.100564-1-eesina@astralinux.ru>
X-Mailer: git-send-email 2.40.1
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

Add interrupt_data =3D NULL after kfree(interrupt_data) in
gasket_interrupt_init. It is needed to avoid double free
in gasket_interrupt_cleanup, there is a check for NULL
before kfree(interrupt_data).

Found by Astra Linux on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex dri=
ver")
Signed-off-by: Esina Ekaterina <eesina@astralinux.ru>
---
 drivers/staging/gasket/gasket_interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/=
gasket/gasket_interrupt.c
index 864342acfd86..48b664b9134a 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -337,6 +337,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_d=
ev)
 			sizeof(*interrupt_data->eventfd_ctxs), GFP_KERNEL);
 	if (!interrupt_data->eventfd_ctxs) {
 		kfree(interrupt_data);
+		interrupt_data =3D NULL;
 		return -ENOMEM;
 	}
=20
@@ -346,6 +347,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_d=
ev)
 	if (!interrupt_data->interrupt_counts) {
 		kfree(interrupt_data->eventfd_ctxs);
 		kfree(interrupt_data);
+		interrupt_data =3D NULL;
 		return -ENOMEM;
 	}
=20
--=20
2.40.1

