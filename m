Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441E5F04A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiI3GPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiI3GOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:14:47 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB39230;
        Thu, 29 Sep 2022 23:14:32 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oe9Hy-00A54p-Fm; Fri, 30 Sep 2022 16:14:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Sep 2022 14:14:22 +0800
Date:   Fri, 30 Sep 2022 14:14:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     mst@redhat.com, arei.gonglei@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: Re: [PATCH v2 RESEND] virtio-crypto: fix memory-leak
Message-ID: <YzaJPuXVrB97ixvI@gondor.apana.org.au>
References: <20220919075158.3625-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919075158.3625-1-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 03:51:58PM +0800, Lei He wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> Fix memory-leak for virtio-crypto akcipher request, this problem is
> introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
> The leak can be reproduced and tested with the following script
> inside virtual machine:
> 
> #!/bin/bash
> 
> LOOP_TIMES=10000
> 
> # required module: pkcs8_key_parser, virtio_crypto
> modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> modprobe virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m
> rm -rf /tmp/data
> dd if=/dev/random of=/tmp/data count=1 bs=230
> 
> # generate private key and self-signed cert
> openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem \
> 		-outform der -out cert.der  \
> 		-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@always.com"
> # convert private key from pem to der
> openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
> 
> # add key
> PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
> echo "priv key id = "$PRIV_KEY_ID
> PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
> echo "pub key id = "$PUB_KEY_ID
> 
> # query key
> keyctl pkey_query $PRIV_KEY_ID 0
> keyctl pkey_query $PUB_KEY_ID 0
> 
> # here we only run pkey_encrypt becasuse it is the fastest interface
> function bench_pub() {
> 	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
> }
> 
> # do bench_pub in loop to obtain the memory leak
> for (( i = 0; i < ${LOOP_TIMES}; ++i )); do
> 	bench_pub
> done
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
>  1 file changed, 4 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
