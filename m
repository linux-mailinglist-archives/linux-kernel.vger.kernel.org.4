Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735516AA7F6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCDETu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCDETn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:19:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E71259B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 20:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677903582; x=1709439582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvEmsWuughcRdW3oGFQ5VdryPdej8zL62swUuDZTanw=;
  b=engCTQj2R9x0Q22X8Vgse2w7zPaAFGK2vfXALHnSLwgLJRutPMfrPfkO
   MR4UEl0rhBpwuxtj8I19f7oLs6DE1vwcQtS1gUjBEvzhQy91xFAlUBjvu
   EInGUSW4ZJxF94qUfvtTEgCsVYfFx3DpqV78eJbYMy9Hlq5vcblDgwWwV
   SGnMeE+thTk1Ny+tBm/dPLA9/wUComKln+i5sy82h70vByMyfzD3FjfCs
   clNtAkA6pK4Qyq8VkSzI+FKM2raR54wG9OgKrBXxaVIx/nVqJJZ6xNa5V
   Gl4n9l1z+HabPR2lIgQ8IzA4lJF0g7tdCI0ZYfa8Nb+CSIOMrWVjWCVQW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315618085"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="315618085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 20:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="708062006"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="708062006"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2023 20:19:37 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     arnd@arndb.de, akpm@linux-foundation.org, keescook@chromium.org,
        herbert@gondor.apana.org.au, josh@joshtriplett.org,
        jani.nikula@intel.com, corbet@lwn.net, jgg@mellanox.com,
        dmatlack@google.com, mizhang@google.com, pbonzini@redhat.com,
        seanjc@google.com
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org
Subject: [PATCH v1 1/3] security: keys: don't use data type as variable name
Date:   Sat,  4 Mar 2023 12:19:30 +0800
Message-Id: <20230304041932.847133-2-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230304041932.847133-1-wei.w.wang@intel.com>
References: <20230304041932.847133-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bool' is a specific name for the data type that is an alias for
the C99 _Bool type. It shoudn't be used as variable names as that causes
too much confusion either for the reader or the compilier.

CC: James.Bottomley@HansenPartnership.com
CC: jarkko@kernel.org
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 2b2c8eb258d5..390d7314f5a6 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -54,12 +54,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			       asn1_oid_len(tpm2key_oid));
 
 	if (options->blobauth_len == 0) {
-		unsigned char bool[3], *w = bool;
+		unsigned char bool_val[3], *w = bool_val;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
 		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
 			return PTR_ERR(w);
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+		work = asn1_encode_tag(work, end_work, 0,
+				       bool_val, w - bool_val);
 	}
 
 	/*
-- 
2.27.0

