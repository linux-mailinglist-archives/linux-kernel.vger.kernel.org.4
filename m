Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8F63BCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiK2J3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiK2J3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:29:25 -0500
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 01:29:18 PST
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C45C759
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:29:18 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id A26311206575;
        Tue, 29 Nov 2022 12:23:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru A26311206575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1669713819; bh=34cO/GV9E8UjUhEC8QC8GWzLPIeTkL25yYRQJuX+RJo=;
        h=From:To:CC:Subject:Date:From;
        b=wNXwNb2PyZlCiXVoV0zKPn7PzUo6VPMGh5pnGxcAWqDJIjVYM2N9e/qfpR2mJ+T7G
         809eDYORrDSuCmMXodchd8NgtOFf6iZCuzsOZn1PvDVtHqI2rgSejZYXcy5D6yBg15
         69h5dAPnu5OlJeAL/rMFUJjt7pm7w5g/bsH4Gsig=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 955A130CCD5E;
        Tue, 29 Nov 2022 12:23:38 +0300 (MSK)
Received: from msk-exch-01.infotecs-nt (10.0.7.191) by msk-exch-01.infotecs-nt
 (10.0.7.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 29 Nov
 2022 12:23:38 +0300
Received: from msk-exch-01.infotecs-nt ([fe80::89df:c35f:46be:fd07]) by
 msk-exch-01.infotecs-nt ([fe80::89df:c35f:46be:fd07%14]) with mapi id
 15.02.1118.012; Tue, 29 Nov 2022 12:23:38 +0300
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Colin Ian King <colin.i.king@gmail.com>,
        wuchi <wuchi.zero@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] relay: Fix type mismatch when allocating memory in
 relay_create_buf()
Thread-Topic: [PATCH] relay: Fix type mismatch when allocating memory in
 relay_create_buf()
Thread-Index: AQHZA9RDQYv1MYkRoUybHQ6EQG7cLA==
Date:   Tue, 29 Nov 2022 09:23:38 +0000
Message-ID: <20221129092002.3538384-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 173812 [Nov 29 2022]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6, {Tracking_from_domain_doesnt_match_to}, infotecs.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2022/11/29 05:53:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2022/11/29 04:55:00 #20623102
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'padding' field of the 'rchan_buf' structure is an array of 'size_t'
elements, but the memory is allocated for an array of 'size_t *' elements.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b86ff981a825 ("[PATCH] relay: migrate from relayfs to a generic rela=
y API")
Signed-off-by: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
 kernel/relay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index d7edc934c56d..88bcb09f0a1f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -148,13 +148,13 @@ static struct rchan_buf *relay_create_buf(struct rcha=
n *chan)
 {
 	struct rchan_buf *buf;
=20
-	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t *))
+	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t))
 		return NULL;
=20
 	buf =3D kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
 	if (!buf)
 		return NULL;
-	buf->padding =3D kmalloc_array(chan->n_subbufs, sizeof(size_t *),
+	buf->padding =3D kmalloc_array(chan->n_subbufs, sizeof(size_t),
 				     GFP_KERNEL);
 	if (!buf->padding)
 		goto free_buf;
--=20
2.30.2
