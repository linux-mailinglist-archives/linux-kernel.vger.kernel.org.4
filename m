Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0296A5EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjB1S2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjB1S2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:28:51 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B603345C;
        Tue, 28 Feb 2023 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5XDgmrCVldCZcKRfq8ly88XN9tFbmvTHx2oZvsD+P54=; b=rjt+/6zTNh9QtloPA0iKD7d45W
        vVp82Gm11hA67RpvQE2UVkGRTXDwoAHA6cbrgifvD91xlU2MhTI4yBv5amxhmtFNyyjMwd/QHOuRj
        rkTNF/pQMdrp9FOnQTsmTPOu2i0LvKif/eIcnESFvKwf9uTjFrDhuWw+1/BnM5CV6+5D55EJnCX09
        NkmtwJESPbnQtfGZWgxdLf0jh0jHmRA5L9ODYsOCYaiKXKF3aG7DpSz605b/yAjmQpk03N+9TIk16
        0EIdmcZqoJvBfCJv1ZlJ2fyi/pNzo6/4xP0Q276ssYRA8xIMJscdyd4erTytcSs+UKzV0hrVOVJ+C
        MXg37iGA==;
Received: from [2001:4d48:ad59:1403::17ca] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pX4iS-008oS5-9l; Tue, 28 Feb 2023 18:28:44 +0000
Date:   Tue, 28 Feb 2023 18:28:40 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Antoine Tenart <atenart@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] crypto: inside-secure: Raise firmware load failure
 message to error
Message-ID: <c51ebfc5ec0cdd1c5464a3c8e8d27cd1a8f04caa.1677608527.git.noodles@earth.li>
References: <Y/fkOF31BTQVocSe@sevai.o362.us>
 <cover.1677608527.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677608527.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment if there is no firmware available for the safexcel driver
it will fail to load with a cryptic:

crypto-safexcel f2800000.crypto: TRC init: 15360d,80a (48r,256h)
crypto-safexcel f2800000.crypto: HW init failed (-2)

Raise the logging level of the firmware load failure to err rather than
dbg so that it's obvious what the reason for the HW init failure is.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
Reviewed-by: Antoine Tenart <atenart@kernel.org>
---
 drivers/crypto/inside-secure/safexcel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 6858753af6b3..5e10ab24be3b 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -474,7 +474,7 @@ static int eip197_load_firmwares(struct safexcel_crypto_priv *priv)
 		goto retry_fw;
 	}
 
-	dev_dbg(priv->dev, "Firmware load failed.\n");
+	dev_err(priv->dev, "Firmware load failed.\n");
 
 	return ret;
 }
-- 
2.39.2

