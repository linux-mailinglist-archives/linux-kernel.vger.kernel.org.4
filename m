Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15C5BC3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiISHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:52:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE23F1C133
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:52:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so26972433pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GTvbctvJNpJ5XFFAVjSyyK1oKWoGjmVgAKwPqHF7qTs=;
        b=rdAsr8pAkyV2pMx5d7GRQyk06KkZ4Hl2uYy+U8EVqK3K7MWt1wweat9xR1Ybh0GWYV
         TwXknqO5sbScM+BCarzDqQy2sYFoDQsUJzzWD6WXKzhZG/8wCZNbBQ3gADIokGuy/L+s
         H627sQXoPjtP1knfrxVoMpzaZKqiz3m20HU1M0EQjNdwekGUE6PS/HaEZXvHIXkG3qVV
         R8gQXMlRmqazLH8g6MjItsKliJLABLWrj4/qm3nZPyMjJtcCVfsviBAU0IDnk2xAHGG2
         Ytmsvb4rX9ybTzR89rEc89TRK05tIfLLSjRhczrBGOP2a/i3gf4e91BMbGiPSw/TVg4v
         SzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GTvbctvJNpJ5XFFAVjSyyK1oKWoGjmVgAKwPqHF7qTs=;
        b=u5FlLwsohEJEh/nCwhYf6x3pjUQTScDSlGvr6oYrF6nH584okXV0cZWVbmhbCQye8d
         LjHd3Vyz4jq+RTstmJ1JsZw4wxwIHbtNp9mnZzMqzF3dMrqvAxFYgRhgk5aXEMpCusZF
         j7MvoGP3GVMBryhHiFTmJfMaOjms76UpPddqnHVEMPOLHjp5tyswYmfxLKcF6yzAOUep
         K4mPou+Y6KUPLidxYxziD6lSe/0s2RSw94Lnk//xKGDZc2m9SOu/wSB20D7XnBCOmKay
         4dd7fuMvHXgjRP7bSJnYluGXMPCK/8qdd8lR4y26+K7EMdfcbCligQkhW4u0KBlwA105
         iK/g==
X-Gm-Message-State: ACrzQf0NFpvKmqcj1CYoxLKJPXx0FJ0p5S/0tbc1p9WCFXH72aXaLazK
        bC1Xx7AhzbYuX2oBvNG8csouSQ==
X-Google-Smtp-Source: AMsMyM643hgxLdb849WmJ4RhvZd9n5dCyv1lNXdROrTk43OBSVJLtSsqY08dfcqilV8P5C+JfdYxOw==
X-Received: by 2002:a17:90b:1e47:b0:200:b9b4:ba1e with SMTP id pi7-20020a17090b1e4700b00200b9b4ba1emr19166426pjb.172.1663573939338;
        Mon, 19 Sep 2022 00:52:19 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id k12-20020a65434c000000b00438e0db80dasm15339950pgq.65.2022.09.19.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:52:18 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au
Cc:     mst@redhat.com, arei.gonglei@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 RESEND] virtio-crypto: fix memory-leak
Date:   Mon, 19 Sep 2022 15:51:58 +0800
Message-Id: <20220919075158.3625-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
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

From: lei he <helei.sig11@bytedance.com>

Fix memory-leak for virtio-crypto akcipher request, this problem is
introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
The leak can be reproduced and tested with the following script
inside virtual machine:

#!/bin/bash

LOOP_TIMES=10000

# required module: pkcs8_key_parser, virtio_crypto
modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
modprobe virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m
rm -rf /tmp/data
dd if=/dev/random of=/tmp/data count=1 bs=230

# generate private key and self-signed cert
openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem \
		-outform der -out cert.der  \
		-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@always.com"
# convert private key from pem to der
openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der

# add key
PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
echo "priv key id = "$PRIV_KEY_ID
PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
echo "pub key id = "$PUB_KEY_ID

# query key
keyctl pkey_query $PRIV_KEY_ID 0
keyctl pkey_query $PUB_KEY_ID 0

# here we only run pkey_encrypt becasuse it is the fastest interface
function bench_pub() {
	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
}

# do bench_pub in loop to obtain the memory leak
for (( i = 0; i < ${LOOP_TIMES}; ++i )); do
	bench_pub
done

Signed-off-by: lei he <helei.sig11@bytedance.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2a60d0525cde..168195672e2e 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
 	struct virtio_crypto_akcipher_request *vc_akcipher_req,
 	struct akcipher_request *req, int err)
 {
+	kfree(vc_akcipher_req->src_buf);
+	kfree(vc_akcipher_req->dst_buf);
+	vc_akcipher_req->src_buf = NULL;
+	vc_akcipher_req->dst_buf = NULL;
 	virtcrypto_clear_request(&vc_akcipher_req->base);
 
 	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.20.1

