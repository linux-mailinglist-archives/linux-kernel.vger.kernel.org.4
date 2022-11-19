Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987F863114D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 23:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiKSWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 17:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiKSWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 17:47:08 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD745F7B;
        Sat, 19 Nov 2022 14:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668898024;
        bh=xCEcRGL+ey/wuog+28UO/CjsJEpRZMcFqZ3tvFJWnhE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=pJbVdZma8ERD+y3QIF1O69ZPcD6lmUpgG3PemkpngA7deO/LEli2jlDCKEnW/GKOq
         d0s1RH8GRXM1RZkgP8KHzYVSeIf4Y1EoRzbJeOc9AR/C/sfhzWJxm+0Q70lBET8TvH
         AQCzzBf8u9id3S/ng72euKAl6zw6S72C/zP/IDDI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8F5FD12812CB;
        Sat, 19 Nov 2022 17:47:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IdCgSsLQNmL0; Sat, 19 Nov 2022 17:47:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668898024;
        bh=xCEcRGL+ey/wuog+28UO/CjsJEpRZMcFqZ3tvFJWnhE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=pJbVdZma8ERD+y3QIF1O69ZPcD6lmUpgG3PemkpngA7deO/LEli2jlDCKEnW/GKOq
         d0s1RH8GRXM1RZkgP8KHzYVSeIf4Y1EoRzbJeOc9AR/C/sfhzWJxm+0Q70lBET8TvH
         AQCzzBf8u9id3S/ng72euKAl6zw6S72C/zP/IDDI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 028421280C7A;
        Sat, 19 Nov 2022 17:47:03 -0500 (EST)
Message-ID: <1034ecdfe7c4c07a45b5b59f21c3be2a7c0c1642.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Nov 2022 17:47:02 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Five small fixes, all in drivers.  Most of these are error leg freeing
issues, with the only really user visible one being the zfcp fix.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

Benjamin Block (1):
      scsi: zfcp: Fix double free of FSF request when qdio send fails

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Suppress command reply debug prints

Yang Yingliang (1):
      scsi: target: tcm_loop: Fix possible name leak in tcm_loop_setup_hba_bus()

Yuan Can (1):
      scsi: scsi_debug: Fix possible UAF in sdebug_add_host_helper()

Zhou Guanghui (1):
      scsi: iscsi: Fix possible memory leak when device_register() failed

And the diffstat:

 drivers/s390/scsi/zfcp_fsf.c        |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c     |  3 ++-
 drivers/scsi/scsi_debug.c           |  6 +++++-
 drivers/scsi/scsi_transport_iscsi.c | 31 ++++++++++++++++---------------
 drivers/target/loopback/tcm_loop.c  |  3 ++-
 5 files changed, 26 insertions(+), 19 deletions(-)

With full diff below

James

---

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 19223b075568..ab3ea529cca7 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -884,7 +884,7 @@ static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
 	const bool is_srb = zfcp_fsf_req_is_status_read_buffer(req);
 	struct zfcp_adapter *adapter = req->adapter;
 	struct zfcp_qdio *qdio = adapter->qdio;
-	int req_id = req->req_id;
+	unsigned long req_id = req->req_id;
 
 	zfcp_reqlist_add(adapter->req_list, req);
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index f77ee4051b00..3306de7170f6 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3265,7 +3265,8 @@ void mpi3mr_process_op_reply_desc(struct mpi3mr_ioc *mrioc,
 	}
 
 	if (scmd->result != (DID_OK << 16) && (scmd->cmnd[0] != ATA_12) &&
-	    (scmd->cmnd[0] != ATA_16)) {
+	    (scmd->cmnd[0] != ATA_16) &&
+	    mrioc->logging_level & MPI3_DEBUG_SCSI_ERROR) {
 		ioc_info(mrioc, "%s :scmd->result 0x%x\n", __func__,
 		    scmd->result);
 		scsi_print_command(scmd);
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 629853662b82..bebda917b138 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7323,8 +7323,12 @@ static int sdebug_add_host_helper(int per_host_idx)
 	dev_set_name(&sdbg_host->dev, "adapter%d", sdebug_num_hosts);
 
 	error = device_register(&sdbg_host->dev);
-	if (error)
+	if (error) {
+		spin_lock(&sdebug_host_list_lock);
+		list_del(&sdbg_host->host_list);
+		spin_unlock(&sdebug_host_list_lock);
 		goto clean;
+	}
 
 	++sdebug_num_hosts;
 	return 0;
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index cd3db9684e52..f473c002fa4d 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -231,7 +231,7 @@ iscsi_create_endpoint(int dd_size)
 	dev_set_name(&ep->dev, "ep-%d", id);
 	err = device_register(&ep->dev);
         if (err)
-		goto free_id;
+		goto put_dev;
 
 	err = sysfs_create_group(&ep->dev.kobj, &iscsi_endpoint_group);
 	if (err)
@@ -245,10 +245,12 @@ iscsi_create_endpoint(int dd_size)
 	device_unregister(&ep->dev);
 	return NULL;
 
-free_id:
+put_dev:
 	mutex_lock(&iscsi_ep_idr_mutex);
 	idr_remove(&iscsi_ep_idr, id);
 	mutex_unlock(&iscsi_ep_idr_mutex);
+	put_device(&ep->dev);
+	return NULL;
 free_ep:
 	kfree(ep);
 	return NULL;
@@ -766,7 +768,7 @@ iscsi_create_iface(struct Scsi_Host *shost, struct iscsi_transport *transport,
 
 	err = device_register(&iface->dev);
 	if (err)
-		goto free_iface;
+		goto put_dev;
 
 	err = sysfs_create_group(&iface->dev.kobj, &iscsi_iface_group);
 	if (err)
@@ -780,9 +782,8 @@ iscsi_create_iface(struct Scsi_Host *shost, struct iscsi_transport *transport,
 	device_unregister(&iface->dev);
 	return NULL;
 
-free_iface:
-	put_device(iface->dev.parent);
-	kfree(iface);
+put_dev:
+	put_device(&iface->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_iface);
@@ -1251,15 +1252,15 @@ iscsi_create_flashnode_sess(struct Scsi_Host *shost, int index,
 
 	err = device_register(&fnode_sess->dev);
 	if (err)
-		goto free_fnode_sess;
+		goto put_dev;
 
 	if (dd_size)
 		fnode_sess->dd_data = &fnode_sess[1];
 
 	return fnode_sess;
 
-free_fnode_sess:
-	kfree(fnode_sess);
+put_dev:
+	put_device(&fnode_sess->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_flashnode_sess);
@@ -1299,15 +1300,15 @@ iscsi_create_flashnode_conn(struct Scsi_Host *shost,
 
 	err = device_register(&fnode_conn->dev);
 	if (err)
-		goto free_fnode_conn;
+		goto put_dev;
 
 	if (dd_size)
 		fnode_conn->dd_data = &fnode_conn[1];
 
 	return fnode_conn;
 
-free_fnode_conn:
-	kfree(fnode_conn);
+put_dev:
+	put_device(&fnode_conn->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_flashnode_conn);
@@ -4815,7 +4816,7 @@ iscsi_register_transport(struct iscsi_transport *tt)
 	dev_set_name(&priv->dev, "%s", tt->name);
 	err = device_register(&priv->dev);
 	if (err)
-		goto free_priv;
+		goto put_dev;
 
 	err = sysfs_create_group(&priv->dev.kobj, &iscsi_transport_group);
 	if (err)
@@ -4850,8 +4851,8 @@ iscsi_register_transport(struct iscsi_transport *tt)
 unregister_dev:
 	device_unregister(&priv->dev);
 	return NULL;
-free_priv:
-	kfree(priv);
+put_dev:
+	put_device(&priv->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_register_transport);
diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 4407b56aa6d1..139031ccb700 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -397,6 +397,7 @@ static int tcm_loop_setup_hba_bus(struct tcm_loop_hba *tl_hba, int tcm_loop_host
 	ret = device_register(&tl_hba->dev);
 	if (ret) {
 		pr_err("device_register() failed for tl_hba->dev: %d\n", ret);
+		put_device(&tl_hba->dev);
 		return -ENODEV;
 	}
 
@@ -1073,7 +1074,7 @@ static struct se_wwn *tcm_loop_make_scsi_hba(
 	 */
 	ret = tcm_loop_setup_hba_bus(tl_hba, tcm_loop_hba_no_cnt);
 	if (ret)
-		goto out;
+		return ERR_PTR(ret);
 
 	sh = tl_hba->sh;
 	tcm_loop_hba_no_cnt++;

