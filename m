Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0FD748961
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGEQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGEQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:40:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6A010EA;
        Wed,  5 Jul 2023 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688575228; x=1720111228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+VSubnhebtlgoHhSLBc0KlFYiEEy9KGoyXqa32bmzwE=;
  b=QL940ZmLcVZKxTTMseXrjVlXouj2n1astk3OxzfgMap0LmUfQVwl51Ny
   qReAhDxCOgfKQOse2VarT9gpbcXRsm+p1wWgJ05KnHa1ci4iXVuyp8JGB
   hzAyMfeNs3HGdoQ6UKwiT8jFChvQkv/K2J8Od0Ln6HaJ5scPnkOg1vYjs
   sRV45RSsURil9AlMNsrU6bPik6VMk24bm10DuLVzGcrhPaAWW8LMonR9l
   c2gY21EBV7i2cvATMQ5SNtpIgRr4gSe2r9gwWJ2zqrbHSG0sCjQKihoBI
   hRy1fvunx/xxsdJoCpzD/HiMG/it0fwwTSJAAFq+6wX1mfC7B5fBLzJnJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362258234"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="362258234"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 09:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="893241756"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="893241756"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2023 09:40:24 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au, agk@redhat.com, snitzer@kernel.org
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, qat-linux@intel.com,
        heinzm@redhat.com, meenakshi.aggarwal@nxp.com, ebiggers@kernel.org,
        horia.geanta@nxp.com, V.Sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net, iuliana.prodan@nxp.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 0/3] crypto: adjust meaning of CRYPTO_ALG_ALLOCATES_MEMORY
Date:   Wed,  5 Jul 2023 17:40:06 +0100
Message-Id: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.40.1
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

Commit fbb6cda44190 introduced the flag CRYPTO_ALG_ALLOCATES_MEMORY.
This allows to mark algorithms that allocate memory during the datapath
so they are not used for disk encryption.
Following that, cd74693870fb limited dm-crypt to use only
implementations that don't set that flag.

After discussions in the crypto mailing list [1][2][3] about how we
could re-enable algorithms to be used by dm-crypt, we came to the
conclusion that we can change slightly the meaning of the flag
!CRYPTO_ALG_ALLOCATES_MEMORY. If an algorithm does not allocate
memory for requests with a scatterlist of 4 or less entries
(the typical case for dm-crypt), then it can avoid marking the
implementation with the flag CRYPTO_ALG_ALLOCATES_MEMORY.

This set adjusts the meaning of CRYPTO_ALG_ALLOCATES_MEMORY in the
documentation, removes the filtering for algorithms that do not
allocate memory in dm-integrity and removes the
CRYPTO_ALG_ALLOCATES_MEMORY from the algorithms registered in the QAT
driver as this is not allocating memory in the datapath for requests
with 4 or less entries in the source and destination scatterlists.

[1] https://lore.kernel.org/linux-crypto/20200722072932.GA27544@gondor.apana.org.au/
[2] https://lore.kernel.org/linux-crypto/20230523165503.GA864814@google.com/
[3] https://lore.kernel.org/linux-crypto/Ysw9E2Az2oK4jfCf@lucas-Virtual-Machine/

Giovanni Cabiddu (3):
  dm integrity: do not filter algos with CRYPTO_ALG_ALLOCATES_MEMORY
  crypto: api - adjust meaning of CRYPTO_ALG_ALLOCATES_MEMORY
  crypto: qat - remove CRYPTO_ALG_ALLOCATES_MEMORY flag

 drivers/crypto/intel/qat/qat_common/qat_algs.c | 13 ++++++-------
 .../intel/qat/qat_common/qat_comp_algs.c       |  2 +-
 drivers/md/dm-integrity.c                      |  2 +-
 include/linux/crypto.h                         | 18 ++++++++++++++++--
 4 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.40.1

