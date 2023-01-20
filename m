Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97580675FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjATVwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjATVwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:52:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2B981021
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:52:11 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a18-20020a62bd12000000b0056e7b61ec78so2980510pff.17
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUCHfM6ksm2j9ziQyxgA2TAJuZtKMQ5HI7hbyLcswG0=;
        b=kN5SBQN5rPmpYwqfPCYN+Nzpuhw94Z19rdN+KbYq0Q4f+yrl7w0UyU6ENTxKLl/EzR
         mS5pE2Hl9VvCMVThDGV0TqKROVmYCQcYcPfzmW4vs3iCvZ5K81LG3k1FD/Pu6+/W447M
         4Cky3a2MU+pFZg/plq4cCPI6wcK4QP5SPbxQhrsSG80NqTc/TXVocW9fHD8alPUSZ/5v
         iZeXt+zJ3/3s18HmJffjjOJ/bXI82/qy/pSlQxd/luv8Yx6PBEQ+tygwJayxzPpwkyP2
         itWMd+m03O+XVXOLiNBmMdpUNXLUm8gA8dgxWv9MG7ZEodEjRjtHuMyuNBdAGBRP0k0k
         dHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUCHfM6ksm2j9ziQyxgA2TAJuZtKMQ5HI7hbyLcswG0=;
        b=dkhyNpeiJQJbMNbGOO9PgeA0onu/XuxRinVF/zvWpiryRYaAxhm6jxAODoIvMdK6sR
         lgofT/dZr5LsYbpWGqb9UxLV3TGWTxtawbWIQ50Aal/VEGTOFkIufrP02SdN9sj7sB2O
         /vLFaIom6raQUmgm9M3MxsU8y/Qhdhxk3cNzJ63v5wYP/RiypR6IJwEXWCCz1KZCRQ49
         f0p9nQRZ0CBVQZueN6z6fXLLLXzCUJU3syFOedQ1EUWhu+AsGjnNxDLfwsp3BcE8BjsQ
         H/ntlYp912PkuLaL3/RAdJilzfenDwflLArK8THXyHGrNt1BS7uP6vlBYlVqx5XUrhfk
         QWvA==
X-Gm-Message-State: AFqh2krC6a9SME82SZwzpSfV1cC7LpoaBYz/Rb1B3fX4et3/tPKkxzGj
        1HJzeyERIAyPKphmEewGDFn59GWAD/yC5A6HpA==
X-Google-Smtp-Source: AMrXdXuHtzIs/NyctfTZ+MNIanuRRuoorwxpbCfb60PtSNh3IU4zGA0bfk7B09c5iLR+3FTnoRPuJTEmVja//toMiQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:fc41:0:b0:49b:2004:b42 with SMTP
 id r1-20020a63fc41000000b0049b20040b42mr1281142pgk.170.1674251530579; Fri, 20
 Jan 2023 13:52:10 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:48:56 +0000
In-Reply-To: <20230120214857.835931-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230120214857.835931-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230120214857.835931-4-dionnaglaze@google.com>
Subject: [PATCH v12 3/3] virt: sev-guest: interpret VMM errors from guest request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GHCB specification states that the upper 32 bits of exitinfo2 are
for the VMM's error codes. The sev-guest ABI has already locked in
that the fw_err status of the input will be 64 bits, and that
BIT_ULL(32) means that the extended guest request's data buffer was too
small. Add BIT_ULL(33) for "host refused the request for throttling
reasons".

The driver interprets the upper 32 bits of exitinfo2 for the user
anyway in case the request gets throttled. For safety, since the
encryption algorithm in GHCBv2 is AES_GCM, control must remain in the
kernel to complete the request with the current sequence number.
Returning without finishing the request allows the the guest to make
another request but with different message contents. This is IV reuse,
and breaks cryptographic protections.

When throttled, the driver will reschedule itself and then try
again after sleeping half its ratelimit time to avoid a big wait queue.
The ioctl may block indefinitely, but that has always been the case
when deferring these requests to the host.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Haowen Bai <baihaowen@meizu.com>

Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 Documentation/virt/coco/sev-guest.rst   | 21 +++++++++++------
 drivers/virt/coco/sev-guest/sev-guest.c | 31 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index e76393e389eb..fd8bf833f1cd 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -37,11 +37,12 @@ along with a description:
       the return value.  General error numbers (-ENOMEM, -EINVAL)
       are not detailed, but errors with specific meanings are.
 
-The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
-The ioctl accepts struct snp_user_guest_request. The input and output structure is
-specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
+The guest ioctl should be issued on a file descriptor of the
+/dev/sev-guest device.  The ioctl accepts struct
+snp_user_guest_request. The input and output structure is specified
+through the req_data and resp_data field respectively. If the ioctl
+fails to execute due to a firmware error, then the fw_error code will
+be set, otherwise fw_error will be set to -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
@@ -57,8 +58,14 @@ counter (e.g. counter overflow), then -EIO will be returned.
                 __u64 req_data;
                 __u64 resp_data;
 
-                /* firmware error code on failure (see psp-sev.h) */
-                __u64 fw_err;
+		/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+		union {
+			__u64 exitinfo2;
+			struct {
+				__u32 fw_error;
+		                __u32 vmm_error;
+			};
+		};
         };
 
 2.1 SNP_GET_REPORT
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index ed6fc14f6b00..1bffd9b1b7dc 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
+#include <linux/ratelimit.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
 #include <crypto/aead.h>
@@ -48,12 +49,22 @@ struct snp_guest_dev {
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
+
+	struct ratelimit_state rs;
 };
 
 static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
+static int rate_s = 1;
+module_param(rate_s, int, 0444);
+MODULE_PARM_DESC(rate_s, "The rate limit interval in seconds to limit requests to.");
+
+static int rate_burst = 2;
+module_param(rate_burst, int, 0444);
+MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
+
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
@@ -338,6 +349,16 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	if (rc)
 		return rc;
 
+retry:
+	/*
+	 * Rate limit commands internally since the host can also throttle, and
+	 * the guest shouldn't create a tight request spin that could end up
+	 * getting this VM throttled more heavily.
+	 */
+	if (!__ratelimit(&snp_dev->rs)) {
+		schedule_timeout_interruptible((rate_s * HZ) / 2);
+		goto retry;
+	}
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -347,6 +368,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
 				     &arg->exitinfo2);
 
+	/*
+	 * The host may return EBUSY if the request has been throttled.
+	 * We retry in the driver to avoid returning and reusing the message
+	 * sequence number on a different message.
+	 */
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_BUSY)
+		goto retry;
+
 	/*
 	 * If the extended guest request fails due to having too small of a
 	 * certificate data buffer, retry the same guest request without the
@@ -751,6 +780,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
+	ratelimit_state_init(&snp_dev->rs, rate_s * HZ, rate_burst);
+
 	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
-- 
2.39.0.246.g2a6d74b583-goog

