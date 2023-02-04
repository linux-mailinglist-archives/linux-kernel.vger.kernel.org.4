Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CD68ABE7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjBDSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBDShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:37:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431EC305D4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:37:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e19so432296plc.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtj8ePFbhQiPG0zynB3k/D6tkr93+Jvf/b43j2mgfsA=;
        b=CTtD56jKJyCWKF6oczzjVWFfHNQBR7wsP14zYt1UUXHHIZ5PPgohft234ZodVSzQQB
         u9VUyeI7/PnAYEuwQS4ZJwcV8VHuJ1iLInsG5ls8ZIrUuui+l3N8Uhf2msryfx/Q4pZp
         Xiv0sIU9D9ZlHqq5FTmSHwfPO/Kzck0QgVRuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtj8ePFbhQiPG0zynB3k/D6tkr93+Jvf/b43j2mgfsA=;
        b=WFDOwBhG7mvcgLu2lJd7UrgXvLjYNCkdy9eZzLkWAjq57xDFgGz6BZWHy7WBFms3Ej
         ALOAEtCb+d2ZYA/KITYy9hVwKE9x4VT/43uFPfMvMeA+/ktQfGRLLY7r050jc9L7DjD/
         XGWJOzrXouiqRy43lvEoEV2WeMbR8hIZ99n97+pBEbTMu2sCYn7GWXsYe/EkJ1EwElbj
         +GVQgBgGlMZGGKekqDmmKcy28xnpM/jwfZjGTV1rCsP5HPah10hA62+egFsJFQUpSomF
         OIi7Ka4Ln+OAaQiiO8qO05f4szzhjDbhKufHYBK6KcMi0+C1UFKanQY/lPeJNJH/9L8r
         b3Zg==
X-Gm-Message-State: AO0yUKWF07v4Uw0q1FfzrnhwZn+od1b6DOC/28gyuVYSd20aUBnk0PiW
        zOij2Qgd8nRVDMFKFiR4ckTq4g==
X-Google-Smtp-Source: AK7set+QtSjqK4Z2AcmPpZ19VnXHkqK6hOxWBy5bVoysvSXZKV3cswU21bDgUT0GFMy5J53pDX6ikw==
X-Received: by 2002:a17:902:ce85:b0:198:b86d:d50f with SMTP id f5-20020a170902ce8500b00198b86dd50fmr14573370plg.69.1675535842763;
        Sat, 04 Feb 2023 10:37:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c15100b00198e54b814bsm3012318plj.119.2023.02.04.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:37:22 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: mpi3mr: Replace 1-element array with flex-array
Date:   Sat,  4 Feb 2023 10:37:16 -0800
Message-Id: <20230204183715.never.937-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; h=from:subject:message-id; bh=v/6A6dqHF9nG+I4/CdpXvj/fFQYoTaxpQuCUlHL73og=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qXbrh7X1qT1Ov5Rs2IJFUOqZU2ugByk2p+2ZW+M VlT/SgaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96l2wAKCRCJcvTf3G3AJvjzD/ 9IHfybto4J1SrF1L7gdVt7ufGPP/7S/rHggSlbqVx3DLHHv4E8RRGjMaIdccXii4RMMNlPCsZJLwUX 12I3mQbxRdnizAMm8yX3Vyr79SzDFdOScTj+J1zR1yiXbD6l/iZ59yAxVymvniOZHTqYyiS2WqlHSX 24H/5uVZvUZ2unQlN8FUo+3oWumA3ztrOpdbrOU5YSJYDbvapFHYmDRDs4swtxoubeBroeJZ7LZliD 8xiyDjMWIkB71d6yuDtgrFTbLmh/V9rypGO7WoWd6haJjNGQkFywf2zqN6yVMhG1xSD0sJW9fJmIKO PCzuP9M/Y4tesQEDYz9L3L5rAkH7ZG4Td1KRKXYfK4I0vHMxywHKm3vW5lUUQMM/E1z3UxCp3baEO6 X/Fj0KOzXWU9SgaqMLjwHC0qIYwPSwKsCW4B/mKH2wbj9UG9WhW7kPB/dmg5cRz/aCNNsuZ9dE7AVU rsSxPFaRIHJA1ujMbrkar9CUMBRv15MI4zVgiSkns3RSpDySafO9XN0XBpjaL/Joj7CFJmOIavIRYm UGoI0cub4E1ULeTrcNfAUx2MozF+Ji8VhEUGA53y05x540Vg+8zXQIiNAP8WQI2Rt8L7+B8s1Z5c1S arzjBRbnSbfncpE7NlU+yKbnrufjgznQJISUYnItY6e/q1bnhZ0tzk6h+B6w==
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

Nothing else defined MPI3_NVME_ENCAP_CMD_MAX, so the "command"
buffer was being defined as a fake flexible array of size 1. Replace
this with a proper flex array. Avoids this GCC 13 warning under
-fstrict-flex-arrays=3:

In function 'fortify_memset_chk',
    inlined from 'mpi3mr_build_nvme_sgl' at ../drivers/scsi/mpi3mr/mpi3mr_app.c:693:2,
    inlined from 'mpi3mr_bsg_process_mpt_cmds.constprop' at ../drivers/scsi/mpi3mr/mpi3mr_app.c:1214:8:
../include/linux/fortify-string.h:430:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()?  [-Wattribute-warning]
  430 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: kernel test robot <lkp@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/scsi/scsi_bsg_mpi3mr.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_bsg_mpi3mr.h
index fdc3517f9e19..907d345f04f9 100644
--- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -455,12 +455,6 @@ struct mpi3mr_bsg_packet {
 	} cmd;
 };
 
-
-/* MPI3: NVMe Encasulation related definitions */
-#ifndef MPI3_NVME_ENCAP_CMD_MAX
-#define MPI3_NVME_ENCAP_CMD_MAX               (1)
-#endif
-
 struct mpi3_nvme_encapsulated_request {
 	__le16	host_tag;
 	__u8	ioc_use_only02;
@@ -474,7 +468,7 @@ struct mpi3_nvme_encapsulated_request {
 	__le16	flags;
 	__le32	data_length;
 	__le32  reserved14[3];
-	__le32	command[MPI3_NVME_ENCAP_CMD_MAX];
+	__le32	command[];
 };
 
 struct mpi3_nvme_encapsulated_error_reply {
-- 
2.34.1

