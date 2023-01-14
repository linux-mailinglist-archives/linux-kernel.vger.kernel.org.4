Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C916B66ABC9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjANNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjANNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:48:55 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE830C4;
        Sat, 14 Jan 2023 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673704134;
        bh=MHib5s2xnggvAckPp9rWBYUxkS6Gf8A8iqIhBu+vGyE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Qp5jBEc8VaYBfFV+FetHQwVRsu9Rk7UUaaKhksuoU6cWcJCrUwSC2jgWdnAouYbom
         BMpB/MihtDx5PUjVSrVv679u/lhATJheuQW0IQfUZgZNrn9SVhaOfEFXHFAvu+DTX+
         9TDGyZEArMUCNZD7gTUGTmXGbrjbN89MHgqycnmY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 768F91280EA0;
        Sat, 14 Jan 2023 08:48:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z4bFrfYNfPCJ; Sat, 14 Jan 2023 08:48:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673704134;
        bh=MHib5s2xnggvAckPp9rWBYUxkS6Gf8A8iqIhBu+vGyE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Qp5jBEc8VaYBfFV+FetHQwVRsu9Rk7UUaaKhksuoU6cWcJCrUwSC2jgWdnAouYbom
         BMpB/MihtDx5PUjVSrVv679u/lhATJheuQW0IQfUZgZNrn9SVhaOfEFXHFAvu+DTX+
         9TDGyZEArMUCNZD7gTUGTmXGbrjbN89MHgqycnmY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E2D021280414;
        Sat, 14 Jan 2023 08:48:53 -0500 (EST)
Message-ID: <dae9db6e4507011bffe3beef9528c3dd7ee363a9.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.1-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 14 Jan 2023 08:48:52 -0500
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

Two minor fixes in the hisi_sas driver which only impact enterprise
style multi-expander and shared disk situations and no core changes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Xingui Yang (1):
      scsi: hisi_sas: Use abort task set to reset SAS disks when discovered

Yihang Li (1):
      scsi: hisi_sas: Set a port invalid only if there are no devices attached when refreshing port id

And the diffstat:

 drivers/scsi/hisi_sas/hisi_sas_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

With full diff below

James

---

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index e9c2d306ed87..8c038ccf1c09 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -704,7 +704,7 @@ static int hisi_sas_init_device(struct domain_device *device)
 		int_to_scsilun(0, &lun);
 
 		while (retry-- > 0) {
-			rc = sas_clear_task_set(device, lun.scsi_lun);
+			rc = sas_abort_task_set(device, lun.scsi_lun);
 			if (rc == TMF_RESP_FUNC_COMPLETE) {
 				hisi_sas_release_task(hisi_hba, device);
 				break;
@@ -1316,7 +1316,7 @@ static void hisi_sas_refresh_port_id(struct hisi_hba *hisi_hba)
 				device->linkrate = phy->sas_phy.linkrate;
 
 			hisi_hba->hw->setup_itct(hisi_hba, sas_dev);
-		} else
+		} else if (!port->port_attached)
 			port->id = 0xff;
 	}
 }

