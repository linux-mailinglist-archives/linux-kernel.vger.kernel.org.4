Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05C651E49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiLTKBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiLTKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:00:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034E193FF;
        Tue, 20 Dec 2022 01:59:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o12so11886759pjo.4;
        Tue, 20 Dec 2022 01:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cauaFNiqPINlpVTbAacRYyZ4uLK51Kok5P7g8b5r+nQ=;
        b=Q2bReRcCsrH/vi+opBe8UNLQoyLMSCADb6OgdPKV0v/mjDsQdb1vy2BEjZSn1oUJXC
         zjH1m6iqBhJ0jdMVB9wj7h1Ua0e0WjJfcZCxvNCFLx84+MeHY+R25gAA7KpscozJhau1
         LBmaDlfEINX3OZd/D3yn5aH0w2Jk1keUSdNyH17DKpnr9Mi32kOTIoqxGOhLYdKnoh11
         O7sWwoyowN7bsd0Mvq+WAHuRfW8UnFTCTzRJ75I7JsY36nSmROEkfc7R2IdMGwakkmfr
         jZLA2HV7W+0+kR2+lSIldO541k2Mu7M47yuTyTUDyliMjkJ09CBOAs4E5tAT1iccBE1p
         IA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cauaFNiqPINlpVTbAacRYyZ4uLK51Kok5P7g8b5r+nQ=;
        b=g9DnBkjluFMBHj0Uxgha0Eroqnak1JcuQ+/bhi6qylQO1isbo8Bl5ne5Hx8ti3BK6t
         +lC9bgOE3X4AAczykQbQC5mEubhHKRA/+bXIadFqzX2a8uGtjil+/n0MWgl0eeoDB5+y
         MyM+nfX/q9DIIp2A38mDqKXdGPylQa/W5TUTDu3ylqi3Y5gLPX+xM7WFeW31lML3POmq
         Vx9N4yUUqhLf//UAUE1tAyuz4urbpSAhQWcBbbQ/bukev+qRTTXFNTqskwAk3W3KR6KH
         aqEmRIFEDHozbbZk69Fa/5OwFXyqdWkN18AGvN0U9AoB7k+8EMWfeBGMYK5tU0uaWFma
         IfAQ==
X-Gm-Message-State: AFqh2kqU2AQGX2aILvMN8rwHDeEEyk585UBwBYTjvJxW8oyy1czPS4oX
        rulq0QZzfTwFwMq4JKPu50nieiETTyI=
X-Google-Smtp-Source: AMrXdXuilD1spu7C8U1YGi8V1Dkh3egAjErjeUrUSErra57V4JJrxc4uuRrFEauYLmDOfCYOE1/PmQ==
X-Received: by 2002:a17:90b:b17:b0:219:1a4e:349d with SMTP id bf23-20020a17090b0b1700b002191a4e349dmr13749833pjb.44.1671530339941;
        Tue, 20 Dec 2022 01:58:59 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090a414d00b00218ec4ff0d4sm10863568pjg.6.2022.12.20.01.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:58:59 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id BA6EF103E43; Tue, 20 Dec 2022 16:58:56 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     virtualization@lists.linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Cornelia Huck <cohuck@redhat.com>, kernel@collabora.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/3] docs: driver-api: virtio: slightly reword virtqueues allocation paragraph
Date:   Tue, 20 Dec 2022 16:58:28 +0700
Message-Id: <20221220095828.27588-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221220095828.27588-1-bagasdotme@gmail.com>
References: <20221220095828.27588-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=bagasdotme@gmail.com; h=from:subject; bh=pw/bpSlpuDl8DJekjRZ6GB3z3tpQJ/ORmO0bgzHPVoI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMkL252XfpF6ESk4ydlE4P6zlZ3THI+Fv3r6dePJPpWdL8UO lfjydJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAilfIM/4v07OOf/Dive7fwBNesS6 Fij7ek/F6pZ8Yf4X1o5wwdSWVGhm/MgZ/FFR7UcsYU5ujMaaq6ueyK3uY3jky/zko/ulgTzwUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"It's at this stage that" means "At this point", so use the latter as it
is more effective.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/virtio/virtio.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/virtio/virtio.rst b/Documentation/driver-api/virtio/virtio.rst
index 2e4ac9557f4a9f..88e2a9bcd8b3f7 100644
--- a/Documentation/driver-api/virtio/virtio.rst
+++ b/Documentation/driver-api/virtio/virtio.rst
@@ -123,10 +123,10 @@ When the device is registered to the virtio bus the kernel will look
 for a driver in the bus that can handle the device and call that
 driver's ``probe`` method.
 
-It's at this stage that the virtqueues will be allocated and configured
-by calling the appropriate ``virtio_find`` helper function, such as
-virtio_find_single_vq() or virtio_find_vqs(), which will end up
-calling a transport-specific ``find_vqs`` method.
+At this point, the virtqueues will be allocated and configured by
+calling the appropriate ``virtio_find`` helper function, such as
+virtio_find_single_vq() or virtio_find_vqs(), which will end up calling
+a transport-specific ``find_vqs`` method.
 
 
 References
-- 
An old man doll... just what I always wanted! - Clara

