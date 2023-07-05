Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970A748963
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGEQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGEQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:40:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7E10EA;
        Wed,  5 Jul 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688575232; x=1720111232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0L33/36rdLS6aViuBmvGQXiDgu8r0FRSWMucXF1m6U=;
  b=CHO5mBKw1YehsCwEQ/r6QMrERVmfYJH89XKeTVt9iTYXQ3/AhTV+zSt8
   ODtCUua++OjVu3IMq7NXWPld0HoNWIWvGmLfbfm9z1odfyoNeIWhbj3tC
   GZE55B+EUzlshKTULxJeC/5VrnnmMtYj9aYoi/VLndOz+AX1sdw29m0mv
   4B0z/P86qkZQkwUrE3hhS21llPT2HPVSh+Iacxs60f/KEMyolNVe5uznO
   Vw+hIagWXU88IbAqhxv/aEJqZDA7uSOPb/foDO1sflIi9Xh/CBss+60vn
   Urn+a5C5ivqz1ZcFBDNwZP4vP1ha4mxPG+lm6fWHlJYwbItcCYqVXEO2g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362258259"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="362258259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 09:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="893241761"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="893241761"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2023 09:40:28 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au, agk@redhat.com, snitzer@kernel.org
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, qat-linux@intel.com,
        heinzm@redhat.com, meenakshi.aggarwal@nxp.com, ebiggers@kernel.org,
        horia.geanta@nxp.com, V.Sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net, iuliana.prodan@nxp.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 1/3] dm integrity: do not filter algos with CRYPTO_ALG_ALLOCATES_MEMORY
Date:   Wed,  5 Jul 2023 17:40:07 +0100
Message-Id: <20230705164009.58351-2-giovanni.cabiddu@intel.com>
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

The flag CRYPTO_ALG_ALLOCATES_MEMORY indicates that an algorithm might
allocate memory in the datapath and therefore sleep.
Dm-integrity is filtering out implementations of skcipher algorithms
that have this flag set. However, in the same function it does
allocations with GFP_KERNEL.
As dm-integrity is re-entrant and capable of handling sleeps that could
occur during allocations with GFP_KERNEL, then it is also capable of
using skcipher algorithm implementations that have
CRYPTO_ALG_ALLOCATES_MEMORY set.

Remove the filtering of skcipher implementations with the flag
CRYPTO_ALG_ALLOCATES_MEMORY set.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/linux-crypto/ZILvtASXQKLG43y9@gondor.apana.org.au/
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 31838b13ea54..a1013eff01b4 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3785,7 +3785,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 		struct journal_completion comp;
 
 		comp.ic = ic;
-		ic->journal_crypt = crypto_alloc_skcipher(ic->journal_crypt_alg.alg_string, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
+		ic->journal_crypt = crypto_alloc_skcipher(ic->journal_crypt_alg.alg_string, 0, 0);
 		if (IS_ERR(ic->journal_crypt)) {
 			*error = "Invalid journal cipher";
 			r = PTR_ERR(ic->journal_crypt);
-- 
2.40.1

