Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DEA64CE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiLNQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbiLNQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3D113C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671035438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntjy4bIssvEAdzLttb0Oirdk6ECvBiYBnXEucLTwyX4=;
        b=Qbgp1/VVy3Mx7jzfThfQ5F71naalQjDuO4OQrMr1/6ynoyJrYSR7E8Ybo9/lHJxFFNfPqh
        314C7koTYRd+8WoUf9EgpPeE8MF7Y9smb6tSS415g4FPkgYoo3n6woqdr4okRpCv3hQCEp
        4YM6XsU93eb01eyD2gGdgep3GPQPdCE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-ha83elm3PGec7Jkojlbzcw-1; Wed, 14 Dec 2022 11:30:33 -0500
X-MC-Unique: ha83elm3PGec7Jkojlbzcw-1
Received: by mail-wm1-f70.google.com with SMTP id m38-20020a05600c3b2600b003d1fc5f1f80so7439899wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntjy4bIssvEAdzLttb0Oirdk6ECvBiYBnXEucLTwyX4=;
        b=cCKG4Kxz59XXq9h64uTs61JTnfnt47vfYh9lGGlUEH7Dbr4XgCgG/uV4IGuhFwf/66
         v6ULay4HdBnQO9BX0CPiNhqxlm81p/838/sI32fF6j6N5QIHLS2//Eei9zdd5lmthjsg
         dGowpO2E7I8dcttFdLpPazYFo5nLGboxjOu33KKrU7kLTXG6SsjFXbXm/Kmg6VQQPgVA
         FHpLlUqjalY6UvLR7qByFFUF1/S83dhnc/CAGOCtT7iLwo54yrsyjEK8asa9nkvtIOev
         YuGMx+NSJdG02lXbAOFvQw8o6u0x8fnw2S5JA14hRRs7ilkFS8GUvZRkwVH0YT/ZCEy5
         eFoQ==
X-Gm-Message-State: ANoB5pm6lgMHDodXzddzTzxp66pkFPO1LpdHNm412vVYUXf4lKFz/Up5
        TovteVbAvS4BoWdQ+csMzgaM3cAgLhbO/ZcpQq6fOJALpXhNDKA/Up4yaSN6lgJjprEgBcxlKVt
        zrsLDRIIUcn47pBp6CQSa3Obp
X-Received: by 2002:a5d:43c8:0:b0:242:659f:9411 with SMTP id v8-20020a5d43c8000000b00242659f9411mr18656563wrr.9.1671035432137;
        Wed, 14 Dec 2022 08:30:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf749Y7E+BT4q6kPhJknMxXoEgk8H6qeSlLUTLbG1hIMjBAx7MTauP5T5GnuPa8o2ZC6K5qBtA==
X-Received: by 2002:a5d:43c8:0:b0:242:659f:9411 with SMTP id v8-20020a5d43c8000000b00242659f9411mr18656541wrr.9.1671035431915;
        Wed, 14 Dec 2022 08:30:31 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b002422816aa25sm3791759wrr.108.2022.12.14.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:30:31 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, eperezma@redhat.com,
        stefanha@redhat.com, netdev@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 2/6] vhost-vdpa: use bind_mm device callback
Date:   Wed, 14 Dec 2022 17:30:21 +0100
Message-Id: <20221214163025.103075-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214163025.103075-1-sgarzare@redhat.com>
References: <20221214163025.103075-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user call VHOST_SET_OWNER ioctl and the vDPA device
has `use_va` set to true, let's call the bind_mm callback.

In this way we can bind the device to the user address space
and directly use the user VA.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b08e07fc7d1f..a775d1a52c77 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -219,6 +219,17 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
 	return vdpa_reset(vdpa);
 }
 
+static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (!vdpa->use_va || !ops->bind_mm)
+		return 0;
+
+	return ops->bind_mm(vdpa, v->vdev.mm, current);
+}
+
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -276,6 +287,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 		ret = vdpa_reset(vdpa);
 		if (ret)
 			return ret;
+
+		ret = vhost_vdpa_bind_mm(v);
+		if (ret)
+			return ret;
 	} else
 		vdpa_set_status(vdpa, status);
 
@@ -679,6 +694,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
+		if (!r && cmd == VHOST_SET_OWNER) {
+			r = vhost_vdpa_bind_mm(v);
+			if (r) {
+				vhost_dev_reset_owner(&v->vdev, NULL);
+				break;
+			}
+		}
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vdpa_vring_ioctl(v, cmd, argp);
 		break;
-- 
2.38.1

