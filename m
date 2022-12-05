Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2B642558
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiLEJEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiLEJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:03:31 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4D10053
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:03:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h193so9915188pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWxGCnE4cMT6K0HQFCyve+aNrYkKjwqaHEJoIAcYwCI=;
        b=HdyukylHw8JYnlc6L3Z96Hx1GieiRkN71kPt1UPuhOh1caX2gFVznQh/62l/cWUzOD
         RGUEwc8ODIw5rjeuB/EJif0iBKSn0s/1OcQHcEdLCYZozB2NQMZdV0f1yCN5GvJUsMb5
         wO2qaW5zJfVTuPZQMBxw+BBE1VgEjcpV/lm7aKruIZFdHwxMp5MX6s3ZUKVO90yb849u
         WwwarP9+CdRtF4a3qFjtXYihae1Jyo+Ou7M5ERXlsocx/5E76sDHiK7IcfhGdSo4FSCY
         y7Huk5OW5PBfnsi540sbwQwCKRYhZYcgInuL22L69S+p9l6Ay4XAwZ18t0csNLdCrg89
         ctiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWxGCnE4cMT6K0HQFCyve+aNrYkKjwqaHEJoIAcYwCI=;
        b=vIaI+lIOowXf8+s4iIGtgNU759u0eo/FIZBttvtiB5buu4m+q9nwNFieCzuM1utgBK
         H2ixNcph8x4v8GdrqfmHG3DMf4Ubos33+Ae6pRhQE5cDb2wvtaxBheWsdOZjbFutA/M1
         axCoWAL8HYJft71NIMPIn4dh+KnxC708tumRkEnc5skWdigYIA1kKKtefRYKuiiLRzPr
         4DvpwSuGtmg0Ecn3GnvRsYEj7BQKtWwAyd4pOx1iJ8Qte/oYxJogaU6wav+PJCtNzDHv
         mEgbeGRWtV6fthTyGvl3Hht7gZQp/hTks47RDG7u0jvqafWWWLzuGBth94M5jniLr3Nj
         muiA==
X-Gm-Message-State: ANoB5pnzaVDi4YAmklxpzJmYOWGr7eFLReILFWId8gFkBR7TmsCzStDv
        6QPisYAfwAtAmkbIuS0Xcc5g
X-Google-Smtp-Source: AA0mqf4E//l5lzN/D6CD+VdQR38n9uDxA2ZfurEZqoOTYhWrAG+IDxtBBxodCOmLIgIyTKQniD0R3Q==
X-Received: by 2002:a05:6a00:2483:b0:56c:12c0:aaf1 with SMTP id c3-20020a056a00248300b0056c12c0aaf1mr65048213pfv.50.1670230987635;
        Mon, 05 Dec 2022 01:03:07 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id p128-20020a62d086000000b00574db8ca00fsm2152429pfg.185.2022.12.05.01.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:03:07 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] vduse: Support specifying bounce buffer size via sysfs
Date:   Mon,  5 Dec 2022 17:02:43 +0800
Message-Id: <20221205090243.791-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205090243.791-1-xieyongji@bytedance.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in [1], this adds sysfs interface to support
specifying bounce buffer size in virtio-vdpa case. It would
be a performance tuning parameter for high throughput workloads.

[1] https://www.spinics.net/lists/netdev/msg754288.html

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 45 +++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index bd1ba6c33e09..0458d61cee1f 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -38,8 +38,11 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
+#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
+#define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
-#define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
+/* 128 MB reserved for virtqueue creation */
+#define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
 struct vduse_virtqueue {
@@ -1795,8 +1798,48 @@ static ssize_t msg_timeout_store(struct device *device,
 
 static DEVICE_ATTR_RW(msg_timeout);
 
+static ssize_t bounce_size_show(struct device *device,
+				struct device_attribute *attr, char *buf)
+{
+	struct vduse_dev *dev = dev_get_drvdata(device);
+
+	return sysfs_emit(buf, "%u\n", dev->bounce_size);
+}
+
+static ssize_t bounce_size_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct vduse_dev *dev = dev_get_drvdata(device);
+	unsigned int bounce_size;
+	int ret;
+
+	ret = -EPERM;
+	mutex_lock(&dev->domain_lock);
+	if (dev->domain)
+		goto unlock;
+
+	ret = kstrtouint(buf, 10, &bounce_size);
+	if (ret < 0)
+		goto unlock;
+
+	ret = -EINVAL;
+	if (bounce_size > VDUSE_MAX_BOUNCE_SIZE ||
+	    bounce_size < VDUSE_MIN_BOUNCE_SIZE)
+		goto unlock;
+
+	dev->bounce_size = bounce_size & PAGE_MASK;
+	ret = count;
+unlock:
+	mutex_unlock(&dev->domain_lock);
+	return ret;
+}
+
+static DEVICE_ATTR_RW(bounce_size);
+
 static struct attribute *vduse_dev_attrs[] = {
 	&dev_attr_msg_timeout.attr,
+	&dev_attr_bounce_size.attr,
 	NULL
 };
 
-- 
2.20.1

