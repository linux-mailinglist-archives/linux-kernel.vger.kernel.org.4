Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330C65FAEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 06:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjAFFcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 00:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFFcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:32:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211259FBD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 21:32:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v23so516751pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 21:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDx13T1WyNEDcHgL9peK/d02wCsf6cJRukFaj1+Gvbw=;
        b=Q3mGGyvELCxJWF4lwpfWiujWC98eGd3PWJaTtu8NNQ1LC0obDeBWAM4pzJ92/B4sNF
         y0gJV/F4JiSymfTO7jWtvDungpO79zLd7SzReYTdsaJcX8UAyYrzOpMoFh5n600lgzdq
         4yGR5VUoefF/cGBxrGRYy++5Fm4wjKy7EUqoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDx13T1WyNEDcHgL9peK/d02wCsf6cJRukFaj1+Gvbw=;
        b=0HjvizCQbkJlGe09Wct/E3V6DE18okZw24QVlHfJ/VP1Xvf2LR54i0clDxC4stdNNv
         C5S/L0C9tle7uL1QrS3E+kX4EqJ4FQvtX+jwYviSnp7T7kdB7aTapPlMbQpEfeRIwIqj
         fGFXhVr4TveKJ9Kmi2PLxhZI7d8uicSZSzsemUxrEH+FE8m/8Cv9MEfSrisHOTKYAdaH
         hPzGcIfO48uHWCamEK9WoyRCls/CQ33k7tnewediNqNAc2DNQeZqw9CLVUF6C6LBKBH+
         yEzUo0cnhIil7vrigeNUGvJH/7z1nw+cA36Q8OaTzOeGxpgi8pd5kCCNlt9/jSOxe/Md
         QUkA==
X-Gm-Message-State: AFqh2kq4FJtar+p/ZhMjCVSHZh68T0XZbl36fk9njmaVedIf1jlQJMI6
        mpBNXTUImpM5bZ5OIR1TO3xG1A==
X-Google-Smtp-Source: AMrXdXuqhDqfl+8sh8p9pCHUOC5BZD44rVXtZ8kRGU/Wn/ZdYH9TqqBtPCeRFJTUnMscjFsTKnu9EQ==
X-Received: by 2002:a17:902:e884:b0:192:c014:f6ba with SMTP id w4-20020a170902e88400b00192c014f6bamr28912909plg.33.1672983122755;
        Thu, 05 Jan 2023 21:32:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00177faf558b5sm26793562plg.250.2023.01.05.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 21:32:01 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: Add flexible array member for SGLs
Date:   Thu,  5 Jan 2023 21:32:00 -0800
Message-Id: <20230106053153.never.999-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; h=from:subject:message-id; bh=PC3YosJyPt0nZ3KotlfA6dcjv2ic/ypDVABveuPLVK0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt7JPI4muvKe6X1dF8Tnm4AnDl5f26NWnzSTTup/O RyGk19SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7eyTwAKCRCJcvTf3G3AJiOkD/ 9mpgZd9EQxRFqOiY8Gklqldv7yrl9/sXFuydGTdfAoIfVTCv0izWV7ES+DGHywTbTtrLX6tWXzd+Yc BBajhlPUvW8ZyweXeV79hdwQkQJzOvT9FmXRkq9xYd0kIGd9JWS/z6gZFLsXw/TBTzLGuKv9835QBl NyvV47ggnZdgGWQqMDcVZ/yJraIj6WtI7YeVgu0+zapMUm8TxXHPzoLuVaJdRabDeGV/aiQFsYHkB3 Vrthbu0iZFSZtUoCHRfE9Ndso56Xmn66Tw0NysFITdITLPzLmsGLMOs9PcHgi2sqtNPLK/gJk8/Ruh yZkpFFnHT18hhLbCSJfa1LKE35XsdcpPqyzo18J/YPsq2yG5k0H+FSyiM+LyKDoJIbtZNiWmJfmuUG tFrmi4liD1BZgYq9MgSdmMB8jiUiDpi4c5JaN3NUnQJ0UuadlTfuTeSAOleb93JIUnPqMOF5ppjExt XSIw0GUxdz/Mn5gKgEK9yoOrCmooQnLdxd2/XwFU85Er0VNuvPwCtAy/7LJifhlA/85XhRTS+HLXQF J12bl9csOPN64j6q0zxJwfHeOvTvd2YfMm5QmQ08x1GkJ4xH/b7Fah5xlLivGHDytoYU/Dg+fyWEqp Q5UHufwTIuwEbUh4H64d92uIbLgrvF97RvS0qY89yBUOcuY3W8+RFXdhk9vQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct MPI2_RAID_SCSI_IO_REQUEST ends with a single SGL, but expects to
copy multiple. Add a flexible array member so the compiler can reason
about the size of the memcpy(). This will avoid the run-time false
positive warning:

  memcpy: detected field-spanning write (size 128) of single field "&r1_cmd->io_request->SGL" at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326 (size 16)

This change results in no binary output differences.

Reported-by: Holger Kiehl <Holger.Kiehl@dwd.de>
Link: https://lore.kernel.org/all/88de8faa-56c4-693d-2d3-67152ee72057@diagnostix.dwd.de/
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: megaraidlinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Holger, are you able to test this change? I expect it should do the
trick, but I don't have the hardware.
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index fe70f8f11435..6597e118c805 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3323,7 +3323,7 @@ static void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
 	/* copy the io request frame as well as 8 SGEs data for r1 command*/
 	memcpy(r1_cmd->io_request, cmd->io_request,
 	       (sizeof(struct MPI2_RAID_SCSI_IO_REQUEST)));
-	memcpy(&r1_cmd->io_request->SGL, &cmd->io_request->SGL,
+	memcpy(r1_cmd->io_request->SGLs, cmd->io_request->SGLs,
 	       (fusion->max_sge_in_main_msg * sizeof(union MPI2_SGE_IO_UNION)));
 	/*sense buffer is different for r1 command*/
 	r1_cmd->io_request->SenseBufferLowAddress =
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 49e9a9048ee7..b677d80e5874 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -526,7 +526,10 @@ struct MPI2_RAID_SCSI_IO_REQUEST {
 	__le32			Control;                        /* 0x3C */
 	union MPI2_SCSI_IO_CDB_UNION  CDB;			/* 0x40 */
 	union RAID_CONTEXT_UNION RaidContext;  /* 0x60 */
-	union MPI2_SGE_IO_UNION       SGL;			/* 0x80 */
+	union {
+		union MPI2_SGE_IO_UNION       SGL;		/* 0x80 */
+		DECLARE_FLEX_ARRAY(union MPI2_SGE_IO_UNION, SGLs);
+	};
 };
 
 /*
-- 
2.34.1

