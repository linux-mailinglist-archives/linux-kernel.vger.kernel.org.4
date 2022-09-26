Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCD5EB373
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIZVp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIZVpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:45:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25647A1D3D;
        Mon, 26 Sep 2022 14:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8BDB9CE13BB;
        Mon, 26 Sep 2022 21:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C883C433D6;
        Mon, 26 Sep 2022 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664228749;
        bh=CjBZnKnRvKVBkZH0ayQHLmeuzpZ0FS7tRJi2S9thecw=;
        h=Date:From:To:Cc:Subject:From;
        b=D/7/+gsOiT5VOoffv1GhrbJ7HbkA17xUM2kxSJnXb1lEuFbqh+dM17LX+PNbkYLQK
         7+uPXMdl+E18Zq4WDFW0U0S+mAvzZcKhbgN1xwE3dDuTQC2WSnBG85mUQhC1dezQBI
         BwRAxYGkSjcTqZ+6fPaNl0rxtxV0NBoqcZDCLIJYHhh5h9oFszjiTzgkct/2UryKqQ
         Y0MbGJBLaROEDqiH6PfYt0IX8ZzH48NkXwCOpabGMHKI/fNqpr3I0OFibH2v3nIpIm
         +HUFbnavzMNlnmqnN1dejk7Um3mWvgD0/Jul9qQjicl1AadckZtiSUP/6+jVgqhaJl
         KYqKTnbt4OWTQ==
Date:   Mon, 26 Sep 2022 16:45:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto: talitos - Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIdiQLXup1qtf6l@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members in unions.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/216
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/talitos.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index 32825119e880..1a93ee355929 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -65,8 +65,8 @@ struct talitos_edesc {
 	dma_addr_t dma_link_tbl;
 	struct talitos_desc desc;
 	union {
-		struct talitos_ptr link_tbl[0];
-		u8 buf[0];
+		DECLARE_FLEX_ARRAY(struct talitos_ptr, link_tbl);
+		DECLARE_FLEX_ARRAY(u8, buf);
 	};
 };
 
-- 
2.34.1

