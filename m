Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D0629F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKOQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiKOQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:49:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3354A1A220
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:49:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b62so13814793pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sFPJMhL4zQAK/mKWhLbds2x5kABYr2ZkNwW8lGz7fQ=;
        b=LI1Y4dmrZ2qUaT5Be+eQi5GvLXg5LGquqTNlXqRX3gv2Ao+imEpKsrgnN6xMfvjmJW
         pg6woE2NcYs1cNYIbG7/DuG/r6eHxn5uiVcN9wmDPER1GMCrKFGdsWmpSVk46qLeF1Fm
         DbWioojc69dejvOy/u6cbDkn7yl1kAtZJNtexpkOePvBPZG1C7ZYvRJkdVuhz1NlVR+z
         w7leGp2ADRqrm3+A4fTZF4bA4cc3hyNg9EBKGc6kIByMnH+3q8OjeEOF2MtV1wd57olO
         hSNTtXCXxrEjpxr7njlqJoz7t2xsO6PF/cnzKJYix7nhcmSjdU+0h61BCfVyhtw87oA1
         PRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sFPJMhL4zQAK/mKWhLbds2x5kABYr2ZkNwW8lGz7fQ=;
        b=TjR3PMMchXGSymvmk85l5/WTWSlLsflvrT4I0V2kIz+jthKYSbvXfXtDwRuM9ieMTN
         JMFbn/wHmU/xF3A+NRsaLumKHau8BERwmoDI9sMu44eTM0tSIIoe/q8rlaEh9iTTObma
         0ejFKzUggB107DFo2YvE5/NoIuk1ZL6f7gXOdqde7CKtNU2a/Wu6MFC1evuZbL6oYjVt
         jgNg7y34eUD6jgU7laLrZHAZrRaq63e2OlK84lJZMwK4efSe+6pNjmy+Dtiw4setdhU+
         LtoXAocCaseLLbec8YYXALi/N4Fwm5LCZ7PlMxwRkaKEIlrBzMhs5XWt8PDEmESoIoNn
         VVhw==
X-Gm-Message-State: ANoB5pliyTT/ua6ybFeDBMHn2UTBWraLpNL1bdsWdSDBZF0LwsYvP9fg
        zH2lbPayK4uDGrZ6qFYUUoo=
X-Google-Smtp-Source: AA0mqf7q0LeWm3ohS3v+L4cwu2FwSthe2H0q3FclrVCanxfQDidmZ9kwV0I57K9V3dgKdDy/W8CHIg==
X-Received: by 2002:a63:5348:0:b0:456:d859:2145 with SMTP id t8-20020a635348000000b00456d8592145mr16867756pgl.56.1668530979561;
        Tue, 15 Nov 2022 08:49:39 -0800 (PST)
Received: from smtpclient.apple ([103.135.102.120])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b0017f9db0236asm10251511plh.82.2022.11.15.08.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:49:38 -0800 (PST)
From:   =?utf-8?B?6buE56eL6ZKn?= <hqjagain@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: [PATCH -next]pstore/zone: Preallocate zone buffer for 
 psz_kmsg_write_record
Message-Id: <DE6A3E0D-275B-4719-850A-41850749311A@gmail.com>
Date:   Wed, 16 Nov 2022 00:49:33 +0800
Cc:     WeiXiong Liao <gmpy.liaowx@gmail.com>, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>
To:     keescook@chromium.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The case found when triggering a panic_on_oom, pstore fails to dump
kmsg.
Partly fixed by: commit 99b3b837855b ("pstore/zone: Use GFP_ATOMIC to
allocate zone buffer"). After the patch, it also fails sometimes. As I =
use
64k as kmsg_size, it's hard to get 4-order free pages sometimes at this
case. So it's better to preallocate the buffer.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/pstore/zone.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 2770746bb7aa..86e47dbc9d53 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -136,6 +136,7 @@ struct psz_context {
 	struct mutex pstore_zone_info_lock;
 	struct pstore_zone_info *pstore_zone_info;
 	struct pstore_info pstore;
+	struct psz_buffer *kmsg_buf_swap;
 };
 static struct psz_context pstore_zone_cxt;
=20
@@ -758,14 +759,11 @@ static inline int notrace =
psz_kmsg_write_record(struct psz_context *cxt,
 		if (unlikely(!zone))
 			return -ENOSPC;
=20
-		/* avoid destroying old data, allocate a new one */
+		/* avoid destroying old data, use the swap buffer */
 		len =3D zone->buffer_size + sizeof(*zone->buffer);
 		zone->oldbuf =3D zone->buffer;
-		zone->buffer =3D kzalloc(len, GFP_ATOMIC);
-		if (!zone->buffer) {
-			zone->buffer =3D zone->oldbuf;
-			return -ENOMEM;
-		}
+		zone->buffer =3D cxt->kmsg_buf_swap;
+		memset(zone->buffer, 0, len);
 		zone->buffer->sig =3D zone->oldbuf->sig;
=20
 		pr_debug("write %s to zone id %d\n", zone->name, =
zonenum);
@@ -776,15 +774,14 @@ static inline int notrace =
psz_kmsg_write_record(struct psz_context *cxt,
 		if (likely(!ret || ret !=3D -ENOMSG)) {
 			cxt->kmsg_write_cnt =3D zonenum + 1;
 			cxt->kmsg_write_cnt %=3D cxt->kmsg_max_cnt;
-			/* no need to try next zone, free last zone =
buffer */
-			kfree(zone->oldbuf);
+			/* no need to try next zone, put last one to =
swap buffer */
+			cxt->kmsg_buf_swap =3D zone->oldbuf;
 			zone->oldbuf =3D NULL;
 			return ret;
 		}
=20
 		pr_debug("zone %u may be broken, try next dmesg zone\n",
 				zonenum);
-		kfree(zone->buffer);
 		zone->buffer =3D zone->oldbuf;
 		zone->oldbuf =3D NULL;
 	}
@@ -1373,6 +1370,12 @@ int register_pstore_zone(struct pstore_zone_info =
*info)
 			err =3D -ENOMEM;
 			goto fail_free;
 		}
+
+		cxt->kmsg_buf_swap =3D kzalloc(info->kmsg_size, =
GFP_KERNEL);
+		if (!cxt->kmsg_buf_swap) {
+			err =3D -ENOMEM;
+			goto fail_free;
+		}
 	}
 	cxt->pstore.data =3D cxt;
=20
@@ -1411,6 +1414,8 @@ int register_pstore_zone(struct pstore_zone_info =
*info)
 	return 0;
=20
 fail_free:
+	kfree(cxt->kmsg_buf_swap);
+	cxt->kmsg_buf_swap =3D NULL;
 	kfree(cxt->pstore.buf);
 	cxt->pstore.buf =3D NULL;
 	cxt->pstore.bufsize =3D 0;
@@ -1445,6 +1450,9 @@ void unregister_pstore_zone(struct =
pstore_zone_info *info)
 	flush_delayed_work(&psz_cleaner);
=20
 	/* Clean up allocations. */
+	kfree(cxt->kmsg_buf_swap);
+	cxt->kmsg_buf_swap =3D NULL;
+
 	kfree(cxt->pstore.buf);
 	cxt->pstore.buf =3D NULL;
 	cxt->pstore.bufsize =3D 0;
--=20
2.30.2=
