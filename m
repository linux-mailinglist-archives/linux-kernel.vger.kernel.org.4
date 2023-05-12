Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230970087D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjELMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbjELMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:51:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85C10A1A;
        Fri, 12 May 2023 05:51:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42bcf5df1so44416535e9.3;
        Fri, 12 May 2023 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683895894; x=1686487894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHSm2/KIUMxn9PSy4M9xJMk3BijHptyN1h8qPqgp2w0=;
        b=YG4u4hfCZEII8wRpNYJ5f5EduKnb7digT4TNzzRD/PAevxlCpLRGR3/QheSOrJRSt1
         1j1DaPV7lh3T12jWcKD9I97bmFXoI/RJiRAfr6g/to2j6jZDjNvah8BatKD23lZQ5LfR
         eD/K440YSCmmJH/dfMqyfG2o0C7N7imLIez/OJvol2vtO0X3ymtmNKB+iTKrlAAT6Ly5
         9lWPvgRDrjxQ0+g5MetdLoogYlPAKDyVT6mxQ0slK0+UlOHTo9pyUnmpedw/mlD405Qo
         EVN8mMy+Jr/OodhXB/vTUmEUn6H5ZBmLZFc0uR0gk3ZXPsIBhb5J/qcHgEPIdkxNM8a5
         HTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895894; x=1686487894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHSm2/KIUMxn9PSy4M9xJMk3BijHptyN1h8qPqgp2w0=;
        b=WstDw9PLo4A1VuaNp9/6TBvKJUHsd789hfI4/zNtW+ajdnYRY5PX5CRSFbwbWPzGZK
         GKT287TXIoJU4pSn53CzD0foA6hMvCNQHRXxL5piD9rtU7x8aoD9WfRYhnoJawJ109D4
         G2iMgCUlzSM4e8KQwQdGcfzvzpaaTJBXrqLNIcXzHtsk8OC91hnzPX6uO8y/5CCfLiLv
         LzDs+BhKY5w17iO/rXXOhp7J7UEt0kMUt/rpojBjx3qaF22cbAgQZvTMSrnGnA5ysaBj
         cKzsMm/4JexLlYaVEKV2KojPqdSk8wJ92egPuZQXg9JJyPWg3GDhowjHPnfvkJKQemTG
         H2XA==
X-Gm-Message-State: AC+VfDwFqqmWtsSannHBJylntnoZy5m9/6iGTJcuiJZyOX4mnVzaOC40
        hES3ozvvD7tNMnAqPeYowRU=
X-Google-Smtp-Source: ACHHUZ4hqSxJZwtk7rzmd/iKgk3m1rt/NZ0Czm9Ez+OBQhgfo1tDbQbY8FDUy7n1N3N4ur5XnVx7CA==
X-Received: by 2002:a7b:c4c3:0:b0:3f2:549b:3ef2 with SMTP id g3-20020a7bc4c3000000b003f2549b3ef2mr15735468wmk.17.1683895893825;
        Fri, 12 May 2023 05:51:33 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003f42ceb3bf4sm9940148wme.32.2023.05.12.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:51:33 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scsi: aacraid: Prevent stopping of already finished thread on adapter reset
Date:   Fri, 12 May 2023 15:51:13 +0300
Message-Id: <20230512125114.1329613-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512125114.1329613-1-bigunclemax@gmail.com>
References: <20230512125114.1329613-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason `aac_adapter_check_health` may fail what leads to
`aac_command_thread` finish. After that if `scsi_try_host_reset` happens,
it leads to access to 'aac->thread->pid' and attempt to stop already
finished thread (`kthread_stop(aac->thread`). As a result we have
use-after-free warning and NULL pointer dereference crash.

This patch should prevent access to already finished thread.

[  461.707724] ------------[ cut here ]------------
[  461.707725] refcount_t: addition on 0; use-after-free.
[  461.707729] WARNING: CPU: 1 PID: 116 at lib/refcount.c:25 refcount_warn_saturate+0x72/0x100
[  461.707783] CPU: 1 PID: 116 Comm: scsi_eh_0 Tainted: G        W          6.3.0.0-g2cd293ea6f73-dirty #12
[  461.707785] Hardware name: Supermicro Super Server/X11SSH-LN4F, BIOS 2.7 12/07/2021
[  461.707786] RIP: 0010:refcount_warn_saturate+0x72/0x100
[  461.707804] Call Trace:
[  461.707805]  <TASK>
[  461.707806]  kthread_stop+0xdb/0xe0
[  461.707809]  aac_reset_adapter+0x409/0x6f0 [aacraid]
[  461.707815]  aac_eh_host_reset+0x50/0x90 [aacraid]
[  461.707819]  scsi_try_host_reset+0x26/0xc0 [scsi_mod]
[  461.707825]  scsi_eh_ready_devs+0x34e/0x920 [scsi_mod]
[  461.707831]  ? scsi_eh_get_sense+0x160/0x160 [scsi_mod]
[  461.707838]  scsi_error_handler+0x355/0x360 [scsi_mod]
[  461.707845]  kthread+0xda/0x100
[  461.707847]  ? kthread_complete_and_exit+0x20/0x20
[  461.707849]  ret_from_fork+0x1f/0x30
[  461.707852]  </TASK>
[  461.707852] ---[ end trace 0000000000000000 ]---

[  461.707855] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  461.708215] #PF: supervisor write access in kernel mode
[  461.708552] #PF: error_code(0x0002) - not-present page
[  461.708900] PGD 0 P4D 0
[  461.709234] Oops: 0002 [#1] PREEMPT SMP
[  461.709558] CPU: 1 PID: 116 Comm: scsi_eh_0 Tainted: G        W          6.3.0.0-g2cd293ea6f73-dirty #12
[  461.710521] RIP: 0010:kthread_stop+0x3f/0xe0
[  461.715884] Call Trace:
[  461.716267]  <TASK>
[  461.716651]  aac_reset_adapter+0x409/0x6f0 [aacraid]
[  461.717052]  aac_eh_host_reset+0x50/0x90 [aacraid]
[  461.717455]  scsi_try_host_reset+0x26/0xc0 [scsi_mod]
[  461.717856]  scsi_eh_ready_devs+0x34e/0x920 [scsi_mod]
[  461.718262]  ? scsi_eh_get_sense+0x160/0x160 [scsi_mod]
[  461.718656]  scsi_error_handler+0x355/0x360 [scsi_mod]
[  461.719044]  kthread+0xda/0x100
[  461.719429]  ? kthread_complete_and_exit+0x20/0x20
[  461.719823]  ret_from_fork+0x1f/0x30
[  461.720216]  </TASK>
[  461.724589] CR2: 0000000000000000
[  461.725038] ---[ end trace 0000000000000000 ]---

[  461.732223] note: scsi_eh_0[116] exited with irqs disabled

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/scsi/aacraid/commsup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index deb32c9f4b3e..9f253a360e9f 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1494,9 +1494,10 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	 *	  commands are completing in the interrupt service.
 	 */
 	aac_adapter_disable_int(aac);
-	if (aac->thread && aac->thread->pid != current->pid) {
+	if (!aac->aif_thread || (aac->thread && aac->thread->pid != current->pid)) {
 		spin_unlock_irq(host->host_lock);
-		kthread_stop(aac->thread);
+		if (aac->aif_thread)
+			kthread_stop(aac->thread);
 		aac->thread = NULL;
 		jafo = 1;
 	}
-- 
2.39.2

