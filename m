Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF86F48F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjEBRMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjEBRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FDAB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683047485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BCPwBmzvLaaQc6gxjyWn7e1TifN6lS2tonHkoUxSAjg=;
        b=TQKr31tPXSghcryHO6M2M/ooh3UXkcHCnB/2UN2Pa/+/xU+K8/8i42z+MyPLRXSZ2aYXa4
        lfA/TdEGXhrAy7y5jmMifeQVTIc/rDWFGIol6cq6N9Yu6ymnFSqF9ptEgfs5HLFD2alwhj
        EGXZ39Wh5nlN2qomxcMWwCeQ+UYfNJo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-pDeh_6h9PUqh9Y7cD3mnEw-1; Tue, 02 May 2023 13:11:24 -0400
X-MC-Unique: pDeh_6h9PUqh9Y7cD3mnEw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef25aaeb5bso24070301cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 10:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047483; x=1685639483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCPwBmzvLaaQc6gxjyWn7e1TifN6lS2tonHkoUxSAjg=;
        b=C0KqDyO4xF5LWs0W8Te/DUmJ96gmJCg5uDr8hh8M9AGAo47I5c8hkpf1l6M1C9lRRQ
         xV31BAmXY5FRHlZv3+mGq9+4VSZ2b1q5EaLCx9xcQRXAOILslALzFETYTht1PtLUNwiY
         rLM5yxic41zBRQEhxB/XdQ66QPxmjC87JzwOy7l/7kb+5tegJ28Tn1JVGZF/78Vs41xE
         /cSF493VGzmT3FimBwcBHsccXtSoKTM8kQVh4fcsp+Rz1Aj0ZKbDtSqDqRSDRD4jC4aq
         BgK/JEom1ttWOdjR6Tc3R2uRd3inIJ0hmbFLQaJM5WvpagF+e2SQbU7BExqXwyG48r8G
         wo2g==
X-Gm-Message-State: AC+VfDzTHSpy7CeNl8rmjnZMmFIRFVJAazEpOiPoTeocNH5lDxxaUTjK
        vcv8Ag7FnDLHgLpTbFgbKHEXdvyplrr3PpSGRXSxoDwcTxMCK89EydqMUC0Nr4qvNatsj3meVA8
        brBFFC56dzDTxUpir/uC5mlWN
X-Received: by 2002:a05:622a:1d5:b0:3ed:e5ad:4a30 with SMTP id t21-20020a05622a01d500b003ede5ad4a30mr28588903qtw.10.1683047483688;
        Tue, 02 May 2023 10:11:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5omEpF8MjoAPICQs0ESyuLjfUk0Khqkvj6U1k1+IO6ZAtrWXrVSwuSR4FdJKKqjm+tqF0cfg==
X-Received: by 2002:a05:622a:1d5:b0:3ed:e5ad:4a30 with SMTP id t21-20020a05622a01d500b003ede5ad4a30mr28588874qtw.10.1683047483447;
        Tue, 02 May 2023 10:11:23 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f3-20020ac81343000000b003e3921077d9sm10425566qtj.38.2023.05.02.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:11:23 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfsd: define exports_proc_ops with CONFIG_PROC_FS
Date:   Tue,  2 May 2023 13:11:21 -0400
Message-Id: <20230502171121.2929222-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 and ! CONFIG_PROC_FS
fs/nfsd/nfsctl.c:161:30: error: ‘exports_proc_ops’
  defined but not used [-Werror=unused-const-variable=]
  161 | static const struct proc_ops exports_proc_ops = {
      |                              ^~~~~~~~~~~~~~~~

The only use of exports_proc_ops is when CONFIG_PROC_FS
is defined, so its definition should be likewise conditional.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfsd/nfsctl.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7b8f17ee5224..c159817d1282 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -153,18 +153,6 @@ static int exports_net_open(struct net *net, struct file *file)
 	return 0;
 }
 
-static int exports_proc_open(struct inode *inode, struct file *file)
-{
-	return exports_net_open(current->nsproxy->net_ns, file);
-}
-
-static const struct proc_ops exports_proc_ops = {
-	.proc_open	= exports_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
-};
-
 static int exports_nfsd_open(struct inode *inode, struct file *file)
 {
 	return exports_net_open(inode->i_sb->s_fs_info, file);
@@ -1458,6 +1446,19 @@ static struct file_system_type nfsd_fs_type = {
 MODULE_ALIAS_FS("nfsd");
 
 #ifdef CONFIG_PROC_FS
+
+static int exports_proc_open(struct inode *inode, struct file *file)
+{
+	return exports_net_open(current->nsproxy->net_ns, file);
+}
+
+static const struct proc_ops exports_proc_ops = {
+	.proc_open	= exports_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release,
+};
+
 static int create_proc_exports_entry(void)
 {
 	struct proc_dir_entry *entry;
-- 
2.27.0

