Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5333A6A6BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCALel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCALeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:34:37 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0AD2FCD0;
        Wed,  1 Mar 2023 03:34:33 -0800 (PST)
Received: from weisslap.aisec.fraunhofer.de ([31.19.218.61]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLA6m-1pFFuO0kpm-00IEk1; Wed, 01 Mar 2023 12:34:22 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        gyroidos@aisec.fraunhofer.de,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        dm-devel@redhat.com (maintainer:DEVICE-MAPPER (LVM)),
        Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        audit@vger.kernel.org (open list:AUDIT SUBSYSTEM)
Subject: [PATCH] dm verity: log audit events for dm-verity target
Date:   Wed,  1 Mar 2023 12:34:15 +0100
Message-Id: <20230301113415.47664-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tGtzLe56BXPRA/UJkQiHxLFGUNAsPjaOFYy/tcw9+uPqPJpJz3Z
 zj5Ye3Z3imqH6MRW+/HoKV3+n0oBXdPXSOf0LxvF2DeTb2JppDQpq7sQyQ37j1FL5FEwSRD
 cv3elYOu1ZkvMmjJsZvSAqFRI9ce18cvY2ehQZsiCCxNdrHNO5WPznAhvTmRUB4YFtQP8kr
 1ubAow1SvYeIt6QIB/L/w==
UI-OutboundReport: notjunk:1;M01:P0:3+LLLmlVKGE=;gastDA8YfJAfdqLlsH0jFPN6yVJ
 7ZIOlYmcHdb21dBEPg/HbaOG2a9LOy35DRcsE6+AYUrCnAsajzbo7HjWDrcwhdaP+nQE3Ojq3
 2mvydV49qUIDu2NpLqiTYaEnCd1Xu1SeV4en11qmDogveFs6E6FHfM/dODSXqmCxyB95L25Wk
 2ILRFKr3k24HZ8T7LJMAdR0wHqeg64Ismpk9OAGBhhmK91fap/v0Mndc/AECDuFhvAs1C+YFC
 AkxUav5auvRwVR9EZVeHL6RuFQV89oEUw5zM3zh8sX06+S8ao7wMXLr6/nxmpvMbJMMgf6jAF
 f8Q/kBCOR83eM0YlIsHpmXTZt+5BO6QjR/BGb+FuTmp8gRzGUN5EfX5MM3NLmhr4bJXBWJUQW
 APApuDDot99iSugazmMFipUWmMnxT4IOAQCqgep3L+Z2OPLZfF7GRBTQKgDmbQfIsmp4u+9Om
 gOv3RxK9FpTnOXj0VmaSgGX0T1y0hunXDyyQ41Si2buLOSa24X+BhtGICrcPHETu2kMl1m8cS
 3cu2zp0H8UTS6VJb94nAmaVdK1f3xOEeZO62+im38GbJN5DtlhfrqUhHm4OwD8F1CCakujcFW
 WxM16Dg/dzU534Cs5CKWjc2FWnQgaAeyvFkzUHmzmITX9kGz7INqcFJlkJPb6SgYLr4ZrzQln
 sPeLlSQWHxnpclMKOdgsFsrP6AHtGwghOY4g6DCoEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm-verity signals integrity violations by returning I/O errors
to user space. To identify integrity violations by a controlling
instance, the kernel audit subsystem can be used to emit audit
events to user space. Analogous to dm-integrity, we also use the
dm-audit submodule allowing to emit audit events on verification
failures of metadata and data blocks as well as if max corrupted
errors are reached.

The construction and destruction of verity device mappings are
also relevant for auditing a system. Thus, those events are also
logged as audit events.

We tested this by starting a container with the container manager
(cmld) of GyroidOS which uses a dm-verity protected rootfs image
root.img mapped to /dev/mapper/<uuid>-root. We than manipulated
one block in the underlying image file and reading it from the
protected mapper device again and again until we reach the max
corrupted errors like this:

  dd if=/dev/urandom of=root.img bs=512 count=1 seek=1000
  for i in range {1..101}; do \
    dd if=/dev/mapper/<uuid>-root of=/dev/null bs=4096 \
       count=1 skip=1000 \
  done

The resulting audit log looks as follows:

  type=DM_CTRL msg=audit(1677618791.876:962):
    module=verity op=ctr ppid=4876 pid=29102 auid=0 uid=0 gid=0
    euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=44
    comm="cmld" exe="/usr/sbin/cml/cmld" subj=unconfined
    dev=254:3 error_msg='success' res=1

  type=DM_EVENT msg=audit(1677619463.786:1074): module=verity
    op=verify-data dev=7:0 sector=1000 res=0
  ...
  type=DM_EVENT msg=audit(1677619596.727:1162): module=verity
    op=verify-data dev=7:0 sector=1000 res=0

  type=DM_EVENT msg=audit(1677619596.731:1163): module=verity
    op=max-corrupted-errors dev=254:3 sector=? res=0

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 drivers/md/dm-verity-target.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index ade83ef3b439..8beeb4ea66d1 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -16,6 +16,7 @@
 #include "dm-verity.h"
 #include "dm-verity-fec.h"
 #include "dm-verity-verify-sig.h"
+#include "dm-audit.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/scatterlist.h>
@@ -248,8 +249,10 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
+	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS) {
 		DMERR("%s: reached maximum errors", v->data_dev->name);
+		dm_audit_log_target(DM_MSG_PREFIX, "max-corrupted-errors", v->ti, 0);
+	}
 
 	snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
 		DM_VERITY_ENV_VAR_NAME, type, block);
@@ -340,6 +343,11 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 		else if (verity_handle_err(v,
 					   DM_VERITY_BLOCK_TYPE_METADATA,
 					   hash_block)) {
+			struct bio *bio =
+				dm_bio_from_per_bio_data(io,
+							 v->ti->per_io_data_size);
+			dm_audit_log_bio(DM_MSG_PREFIX, "verify-metadata", bio,
+					 block, 0);
 			r = -EIO;
 			goto release_ret_r;
 		}
@@ -590,8 +598,11 @@ static int verity_verify_io(struct dm_verity_io *io)
 				return -EIO;
 			}
 			if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
-					      cur_block))
+					      cur_block)) {
+				dm_audit_log_bio(DM_MSG_PREFIX, "verify-data",
+						 bio, cur_block, 0);
 				return -EIO;
+			}
 		}
 	}
 
@@ -975,6 +986,8 @@ static void verity_dtr(struct dm_target *ti)
 		static_branch_dec(&use_tasklet_enabled);
 
 	kfree(v);
+
+	dm_audit_log_dtr(DM_MSG_PREFIX, ti, 1);
 }
 
 static int verity_alloc_most_once(struct dm_verity *v)
@@ -1429,11 +1442,14 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	verity_verify_sig_opts_cleanup(&verify_args);
 
+	dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
+
 	return 0;
 
 bad:
 
 	verity_verify_sig_opts_cleanup(&verify_args);
+	dm_audit_log_ctr(DM_MSG_PREFIX, ti, 0);
 	verity_dtr(ti);
 
 	return r;
-- 
2.30.2

