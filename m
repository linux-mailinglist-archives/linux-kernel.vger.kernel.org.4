Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74373732B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjFPJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbjFPJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499AE423E;
        Fri, 16 Jun 2023 02:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC5461844;
        Fri, 16 Jun 2023 09:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B3C433C0;
        Fri, 16 Jun 2023 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906432;
        bh=SssK4C+MROZYzi+b4Qyu0IIYF+H8yC2OIjf9lSsuvAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Fzi//9ZxgLWQfoZfdtXHI64hId/FbDLxPXsJA0sig9i/8y+vTgILgL3B0gbK78OgQ
         pWOqcI8a3q2uq8HLkgEfQ5zCkQGXAk3VO3Yy3K3/E6WFGUtTB+LZlkl2Gdy8x2q544
         0BIm/723DnL+o3tMD/pJX6xIBGKG8qP1xinjGVCtWoaU6ikf9qqLsx9J4aqYECkrE9
         d/ay8T+HcYRMl9UHHkPDM9hD8fsPNos8NNmLtD1Xo5YtAY2ed8TDRXod1Aj29JnmR/
         mBA0S/t6/zjEWn1Rba8+mxH2EDydli+aEWC9MgbUzd/5QvtF6/mCmbvALM99j5ypBe
         tnh/wyjYUlFEQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] scsi: lpfc: fix lpfc_name struct packing
Date:   Fri, 16 Jun 2023 11:06:56 +0200
Message-Id: <20230616090705.2623408-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang points out that the lpfc_name structure has an 8-byte alignement requirement
on most architectures, but is embedded in a number of other structures that are
forced to be only 1-byte aligned:

drivers/scsi/lpfc/lpfc_hw.h:1516:30: error: field pe within 'struct lpfc_fdmi_reg_port_list' is less aligned than 'struct lpfc_fdmi_port_entry' and is usually due to 'struct lpfc_fdmi_reg_port_list' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct lpfc_fdmi_port_entry pe;
drivers/scsi/lpfc/lpfc_hw.h:850:19: error: field portName within 'struct _ADISC' is less aligned than 'struct lpfc_name' and is usually due to 'struct _ADISC' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
drivers/scsi/lpfc/lpfc_hw.h:851:19: error: field nodeName within 'struct _ADISC' is less aligned than 'struct lpfc_name' and is usually due to 'struct _ADISC' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
drivers/scsi/lpfc/lpfc_hw.h:922:19: error: field portName within 'struct _RNID' is less aligned than 'struct lpfc_name' and is usually due to 'struct _RNID' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
drivers/scsi/lpfc/lpfc_hw.h:923:19: error: field nodeName within 'struct _RNID' is less aligned than 'struct lpfc_name' and is usually due to 'struct _RNID' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

From the git history, I can see that all the __packed annotations were done
specifically to avoid introducing implicit padding around the lpfc_name
instances, though this was probably the wrong approach.

To improve this, only annotate the one uint64_t field inside of lpfc_name
as packed, with an explicit 4-byte alignment, as is the default already on
the 32-bit x86 ABI but not on most others. With this, the other __packed
annotations can be removed again, as this avoids the incorrect padding.

Two other structures change their layout as a result of this change:

- struct _LOGO never gained a __packed annotation even though it has the
  same alignment problem as the others but is not used anywhere in the
  driver today.

- struct serv_param similarly has this issue, and it is used, my guess
  is that this is only an internal structure rather than part of a binary
  interface, so the padding has no negative effect here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_hw.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index 663755842e4a4..aaea3e31944d0 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -365,7 +365,7 @@ struct lpfc_name {
 			uint8_t IEEE[6];	/* FC IEEE address */
 		} s;
 		uint8_t wwn[8];
-		uint64_t name;
+		uint64_t name __packed __aligned(4);
 	} u;
 };
 
@@ -850,7 +850,7 @@ typedef struct _ADISC {		/* Structure is in Big Endian format */
 	struct lpfc_name portName;
 	struct lpfc_name nodeName;
 	uint32_t DID;
-} __packed ADISC;
+} ADISC;
 
 typedef struct _FARP {		/* Structure is in Big Endian format */
 	uint32_t Mflags:8;
@@ -880,7 +880,7 @@ typedef struct _FAN {		/* Structure is in Big Endian format */
 	uint32_t Fdid;
 	struct lpfc_name FportName;
 	struct lpfc_name FnodeName;
-} __packed FAN;
+} FAN;
 
 typedef struct _SCR {		/* Structure is in Big Endian format */
 	uint8_t resvd1;
@@ -924,7 +924,7 @@ typedef struct _RNID {		/* Structure is in Big Endian format */
 	union {
 		RNID_TOP_DISC topologyDisc;	/* topology disc (0xdf) */
 	} un;
-} __packed RNID;
+} RNID;
 
 struct RLS {			/* Structure is in Big Endian format */
 	uint32_t rls;
@@ -1514,7 +1514,7 @@ struct lpfc_fdmi_hba_ident {
 struct lpfc_fdmi_reg_port_list {
 	__be32 EntryCnt;
 	struct lpfc_fdmi_port_entry pe;
-} __packed;
+};
 
 /*
  * Register HBA(RHBA)
-- 
2.39.2

