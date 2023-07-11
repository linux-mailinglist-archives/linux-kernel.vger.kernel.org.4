Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B25F74EFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGKNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGKNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:14:22 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF50E75
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689081243; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ELDn88GjCHb9FDhGDrVmWLnQEEbibupq89mo0bFmn2babvONHg+DnXFgLUj5BAY2vaBi7Z6C0hGPPB95wtq8GdVn5uendxofDg2bO+mjuh1pbyE3jsOBNFrafeqvsGe/+GjiyyFIpUrRxihbsFpfnLWKtKaTUKiNJV/e8NuSlu0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1689081243; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=2FOLEAFpOmbo1ycqs1KmRF42XUVaEQORNQoO98IczvM=; 
        b=b2jGj1vkzTsqsfijns4O0xcLSeGEKgr8Wi9MNMz473xdO7WQunBcQnXtYQ3+6CfjxNGtafY0ZtsFF4WwXFpHHRrLngZIPrbR9bKJTvagcwsm4RsYbY/tJxVuMC0Ktu0HCTIzRG4VsvBVb7Hzt+Ug9hzWS00y6jpIsgJjlUC6QFo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689081243;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=2FOLEAFpOmbo1ycqs1KmRF42XUVaEQORNQoO98IczvM=;
        b=spX700JnTjGXwK37ZVWiHg9y5BYIY6WE9Fa8hy6KXmpF3tv/NmtIdTSJ0jGhc96S
        5duN0rxXvccoy/8lNN8ovFELTWyuKv4VoILWcrw77CDX9h2yyHzmjODbOAmTewy0yYf
        S/PlLoBdqCIyl1ZaU3lmYRKBU2bbym0k8sKOGaz8=
Received: from kampyooter.. (110.226.17.135 [110.226.17.135]) by mx.zoho.in
        with SMTPS id 168908124292161.94559325856801; Tue, 11 Jul 2023 18:44:02 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+37acd5d80d00d609d233@syzkaller.appspotmail.com
Message-ID: <20230711131353.40500-1-code@siddh.me>
Subject: [PATCH] Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no link
Date:   Tue, 11 Jul 2023 18:43:53 +0530
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hci_connect_sco currently returns NULL when there is no link (i.e. when
hci_conn_link() returns NULL).

sco_connect() expects an ERR_PTR in case of any error (see line 266 in
sco.c). Thus, hcon set as NULL passes through to sco_conn_add(), which
tries to get hcon->hdev, resulting in dereferencing a NULL pointer as
reported by syzkaller.

The same issue exists for iso_connect_cis() calling hci_connect_cis().

Thus, make hci_connect_sco() and hci_connect_cis() return ERR_PTR
instead of NULL.

Reported-and-tested-by: syzbot+37acd5d80d00d609d233@syzkaller.appspotmail.c=
om
Closes: https://syzkaller.appspot.com/bug?extid=3D37acd5d80d00d609d233
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple=
 hcon")
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 056f9516e46d..21176908069d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1684,7 +1684,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev=
, int type, bdaddr_t *dst,
 =09if (!link) {
 =09=09hci_conn_drop(acl);
 =09=09hci_conn_drop(sco);
-=09=09return NULL;
+=09=09return ERR_PTR(-ENOLINK);
 =09}
=20
 =09sco->setting =3D setting;
@@ -2254,7 +2254,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev=
, bdaddr_t *dst,
 =09if (!link) {
 =09=09hci_conn_drop(le);
 =09=09hci_conn_drop(cis);
-=09=09return NULL;
+=09=09return ERR_PTR(-ENOLINK);
 =09}
=20
 =09/* If LE is already connected and CIS handle is already set proceed to
--=20
2.40.1


