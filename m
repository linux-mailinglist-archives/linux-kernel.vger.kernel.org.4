Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3FC748966
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGEQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGEQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:40:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF2610EA;
        Wed,  5 Jul 2023 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688575236; x=1720111236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORYP0BTPC9UmnZNKGK+aTCKZj4NImzCEscAgvgLWfvs=;
  b=RXiNreG3+paOmBxsCnkMvf53Q2N0KcC+WPdoNVo6HZ21LY7Bd35VIlQF
   7E94E5gGmgaZosxHxs56pktULVtSfMu6BGjExBDS8d31H+vL9UeMRe2oH
   pjQkoKMnSpmr0WC3jkHt6tDpZRAzMw9RbJavyYDq99isXiam1Est0sXCe
   UkDZb2leYdzBDSDZq3BK3bpzXy/ZtKped0Fx1k2YYRbSkBO9lEhmD9nN2
   LVFlvIoohd+AB41z2cAQOeAoIz+2ovb97j4ghgQPSEqdvu1fWbJykWuVO
   cJb0z0h7xABLrWzvaRZ+DNM+75mbJfkNLs6O1AcoSo2nTBJ0HaemSukFP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362258287"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="362258287"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 09:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="893241766"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="893241766"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2023 09:40:32 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au, agk@redhat.com, snitzer@kernel.org
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, qat-linux@intel.com,
        heinzm@redhat.com, meenakshi.aggarwal@nxp.com, ebiggers@kernel.org,
        horia.geanta@nxp.com, V.Sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net, iuliana.prodan@nxp.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 2/3] crypto: api - adjust meaning of CRYPTO_ALG_ALLOCATES_MEMORY
Date:   Wed,  5 Jul 2023 17:40:08 +0100
Message-Id: <20230705164009.58351-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CRYPTO_ALG_ALLOCATES_MEMORY flag doesn't allow to distinguish
between implementations which don't allocate memory for scatterlists
with 4 or less entries (the typical case for dm-crypt) and those that
do.
The flag's meaning is adjusted based on the ML discussion below.

This patch removes the need to set the flag if the implementation can
handle scatterlists up to 4 entries without allocating memory.
The documentation is updated accordingly, with an extra clarification
regarding sleeping.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Suggested-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/linux-crypto/20200722072932.GA27544@gondor.apana.org.au/
Link: https://lore.kernel.org/linux-crypto/20230523165503.GA864814@google.com/
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 include/linux/crypto.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 31f6fee0c36c..15884790a3d0 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -87,8 +87,13 @@
 
 /*
  * The algorithm may allocate memory during request processing, i.e. during
- * encryption, decryption, or hashing.  Users can request an algorithm with this
- * flag unset if they can't handle memory allocation failures.
+ * encryption, decryption, or hashing. Algorithms that do not set this flag will
+ * guarantee that memory is not allocated during request processing, except in
+ * the avoidable exception cases described below.
+ *
+ * Users can request an algorithm with this flag unset if they can't handle
+ * memory allocation failures or sleeping during request processing. They should
+ * also follow the constraints below.
  *
  * This flag is currently only implemented for algorithms of type "skcipher",
  * "aead", "ahash", "shash", and "cipher".  Algorithms of other types might not
@@ -102,6 +107,9 @@
  *	- If the data were to be divided into chunks of size
  *	  crypto_skcipher_walksize() (with any remainder going at the end), no
  *	  chunk can cross a page boundary or a scatterlist element boundary.
+ *	- The input and output scatterlists must have no more than 4 entries.
+ *	  If the scatterlists contain more than 4 entries, the algorithm may
+ *	  allocate memory.
  *    aead:
  *	- The IV buffer and all scatterlist elements must be aligned to the
  *	  algorithm's alignmask.
@@ -110,10 +118,16 @@
  *	- If the plaintext/ciphertext were to be divided into chunks of size
  *	  crypto_aead_walksize() (with the remainder going at the end), no chunk
  *	  can cross a page boundary or a scatterlist element boundary.
+ *	- The input and output scatterlists must have no more than 4 entries.
+ *	  If the scatterlists contain more than 4 entries, the algorithm may
+ *	  allocate memory.
  *    ahash:
  *	- The result buffer must be aligned to the algorithm's alignmask.
  *	- crypto_ahash_finup() must not be used unless the algorithm implements
  *	  ->finup() natively.
+ *	- The input and output scatterlists must have no more than 4 entries.
+ *	  If the scatterlists contain more than 4 entries, the algorithm may
+ *	  allocate memory.
  */
 #define CRYPTO_ALG_ALLOCATES_MEMORY	0x00010000
 
-- 
2.40.1

