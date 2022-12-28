Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AF6576BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiL1NEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiL1NEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:04:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C158BC87
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:04:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s7so16005362plk.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6v2YmSNycBvHHVSyIhpcknHxxLC/ky6B8DaYNkU4as=;
        b=IzXQGTfAJnL8SZqPejRNGu4DCwKhM/6xI6045N/uqvrLmHLickIJiZTycRMQ12YjGH
         MQKfDXp1XTUL3yTNLGsVJM3ELWlylKjf8Z3EwBhtKR7E75ENIXxB6vg1Q9dzoC1cbeSF
         XlaetHECV1+Xu4xfCVYWd4Cj4FxN4rK6XKS0mIk29huFpOBtiEKlt6siX0gYAUEwTtw6
         5MEUoy45gbUsnXEY9o+/vzBUMtEfMjLbBdvusL8T2GpB7Th+HsSgfWTIhx/j2a5pGCVn
         xTHBmQwPVefGAjoYGILyrrzEj9IoBOpYhte+mFoVaB+NX+LkqPD9T4NxL51u1GoT8DJ3
         UUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6v2YmSNycBvHHVSyIhpcknHxxLC/ky6B8DaYNkU4as=;
        b=qIh1aCkZ/NvRbMrh4GW1Lf5BJeHL+Fewgdokf/2ZkgVTRRTPafzQ/9sN/+J+/k6XMI
         BNcvSt8OC5tQkLgRcbSZ9fh5N4HJUTh2p0sPMgoN12Xav9wxsLG6tmq9mVLm0Yhcv+z8
         WnfscXENGViRX/HjX+SuEyHhnxadt1zGVXygWn3QKe3vL1X6AL6wNIpvtCFUjpbjAWkf
         X0hKd8mvpOiPiOCOj3wqL3j93zgj88bN6WBNr3Yfov68DJwAezqUeJfCbqOhs7X5Uwrw
         EGz67CTCKTnk+SCqpEjO8oK9/t56yVrCAkDX1yLJ4sgaZsuFDfZSJNsrSXdEkZ8ir89d
         W15g==
X-Gm-Message-State: AFqh2kpaR+wzF6U5hJ0BpThJO/rrWzwRpP+/P/PedGxQKae0VimVmMcc
        YBcIBbeXuy/jY33VfjCScec=
X-Google-Smtp-Source: AMrXdXuMUmws13R2P9Ada4KTdhTD48NmoqIlUOGDyZ9bdDcd77IutruUVtsLBna9VS5au/KDfEIZAQ==
X-Received: by 2002:a17:902:8c92:b0:189:8412:7dd1 with SMTP id t18-20020a1709028c9200b0018984127dd1mr26063410plo.61.1672232682229;
        Wed, 28 Dec 2022 05:04:42 -0800 (PST)
Received: from smtpclient.apple ([103.135.102.121])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b00189dcc39215sm10869416plb.251.2022.12.28.05.04.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Dec 2022 05:04:40 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: [PATCH]pstore/zone: Preallocate zone buffer for 
 psz_kmsg_write_record
Message-Id: <778A2949-C5E7-4C4A-AF30-57CD1B45B3C0@gmail.com>
Date:   Wed, 28 Dec 2022 21:04:32 +0800
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
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

@@ -758,14 +759,11 @@ static inline int notrace =
psz_kmsg_write_record(struct psz_context *cxt,
		if (unlikely(!zone))
			return -ENOSPC;

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

@@ -1411,6 +1414,8 @@ int register_pstore_zone(struct pstore_zone_info =
*info)
	return 0;

fail_free:
+	kfree(cxt->kmsg_buf_swap);
+	cxt->kmsg_buf_swap =3D NULL;
	kfree(cxt->pstore.buf);
	cxt->pstore.buf =3D NULL;
	cxt->pstore.bufsize =3D 0;
@@ -1445,6 +1450,9 @@ void unregister_pstore_zone(struct =
pstore_zone_info *info)
	flush_delayed_work(&psz_cleaner);

	/* Clean up allocations. */
+	kfree(cxt->kmsg_buf_swap);
+	cxt->kmsg_buf_swap =3D NULL;
+
	kfree(cxt->pstore.buf);
	cxt->pstore.buf =3D NULL;
	cxt->pstore.bufsize =3D 0;
--=20
2.30.2=
