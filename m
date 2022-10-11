Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1915FAD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJKHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:21:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F532871C;
        Tue, 11 Oct 2022 00:21:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so15200933pjs.0;
        Tue, 11 Oct 2022 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6Q0KMRNTrEZQjUDQYg8rg5VFvAVxN3IpxOY5EJm1qY=;
        b=UNWRr0whTtFYvxVPmsm9xJsR55KviCr0CubpTjQAp4UJE48q01y0JT6G2mkcC1Zxzh
         jAf6MxfIpUSZOmcL0xBWasQtvbGrizxvtIldu3hwzvM8VhGzso63vxxNwePDB+9Hzfhe
         6z36Bv0Zn1CECYbrCOVunkW+EdpZvPu5vkXLIeOaR5rhHlJ5B7a/98FbCy7/7iaYg0TF
         rcdftq66WqVi3Z46devyCK6jhwu8vgE6IYsw9vAms6LrYJ8oif3oRAQYVEbgFDxpTEl9
         /4WhoaZ1joONAV0aTLDcnyXCNS9WxzX42lnRWSv0hO5+axbqpA/NWZVWw2BgLnFdJeOO
         IA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6Q0KMRNTrEZQjUDQYg8rg5VFvAVxN3IpxOY5EJm1qY=;
        b=8MuHtgUNQWCex/EicQSFZy+M2CLND61qaehUgNK5AusuLsGBr9G5mpM27pHDpXarHs
         u7zQFRVVcRA8dYTF9uBmA+gESSMvl40UjR8+LweAMucJuN9fBUI0zQLNFH63l511Dl5d
         qZnhEA1n3miuEhd6edGLblSY/OifCeOZfbFijsb4WzGy6lj/6ErwpDJwRQZOoA7enDJX
         1+NAOeyHnCZ/n1VQBp0+Wf6hpr6YmEWFbXUWzekf0YPjIPZM7R2AQ2DAizuJoCecKjUi
         DIaxEkf16JYvW/1hmhFujpbyhD8TJpQJ5n+4eGDR+Py9Nr3SpzibvhvWAHeLE4XxC/7T
         cV6Q==
X-Gm-Message-State: ACrzQf2/7zKUop1eAvdwTZectc0OfxZAguwKM+uK3UnV/obTXuZXmIkc
        3ibbdRJBOx6edc+UI919ImI=
X-Google-Smtp-Source: AMsMyM4ARawYwJxQC67ePPSVUlUL0wwFaH4YYgTrgeH98DMk3GAjImNYmszlgJ92xogLtnFCKsYMCg==
X-Received: by 2002:a17:90b:1808:b0:20d:4e7f:5f53 with SMTP id lw8-20020a17090b180800b0020d4e7f5f53mr7655217pjb.170.1665472894845;
        Tue, 11 Oct 2022 00:21:34 -0700 (PDT)
Received: from zeshkernups01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709027c9000b0017f756563bcsm7878884pll.47.2022.10.11.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 00:21:34 -0700 (PDT)
From:   Ten Gao <gaoyankaigeren@gmail.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ufs: core: remove encrypt when no data transfer
Date:   Tue, 11 Oct 2022 15:21:26 +0800
Message-Id: <20221011072126.30802-1-gaoyankaigeren@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ten Gao <ten.gao@unisoc.com>

when there is no data transmission, ufs is unnecessary to encrypt.
We need to adjust scsi crypto relation.

Signed-off-by: Ten Gao <ten.gao@unisoc.com>
---
 drivers/ufs/core/ufshcd-crypto.h | 10 ++++++----
 include/ufs/ufshci.h             |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-crypto.h
index 504cc841540b..5bc2a0cbdfa6 100644
--- a/drivers/ufs/core/ufshcd-crypto.h
+++ b/drivers/ufs/core/ufshcd-crypto.h
@@ -30,10 +30,12 @@ ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb *lrbp, u32 *dword_0,
 				   u32 *dword_1, u32 *dword_3)
 {
 	if (lrbp->crypto_key_slot >= 0) {
-		*dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
-		*dword_0 |= lrbp->crypto_key_slot;
-		*dword_1 = lower_32_bits(lrbp->data_unit_num);
-		*dword_3 = upper_32_bits(lrbp->data_unit_num);
+		if ((*dword_0 & UTRD_DIRECTION) != UTP_NO_DATA_TRANSFER) {
+			*dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
+			*dword_0 |= lrbp->crypto_key_slot;
+			*dword_1 = lower_32_bits(lrbp->data_unit_num);
+			*dword_3 = upper_32_bits(lrbp->data_unit_num);
+		}
 	}
 }
 
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index f525566a0864..7dbfeecaa36c 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -387,6 +387,8 @@ enum {
 	UTP_DEVICE_TO_HOST	= 0x04000000,
 };
 
+#define UTRD_DIRECTION	0x6000000
+
 /* Overall command status values */
 enum utp_ocs {
 	OCS_SUCCESS			= 0x0,
-- 
2.17.1

