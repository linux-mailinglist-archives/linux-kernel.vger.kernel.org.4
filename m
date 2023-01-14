Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E827D66A863
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjANBiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjANBiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61010B7A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673660249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VZy8c8fy0bsQa5T6EMyPtDGsQiznRhGW5hoUl+VQVKY=;
        b=Uh54Rr/081bbbmu6rOrF9VBsr2HWbxMhIOIQzAieHIc/V5P2EGSkLiA1hxPJA9lIJeQhCn
        LDsNmYvW2Ws8ZmjkkQ8RcxkgQFuDDozr5W5IIHeF8PhvLiZJM3WyQYHI0NNc81R6xXj8sz
        m75FDfSF8gOOJK8DU4G05leVeRFXKrs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-2wC9_HpGO1iHBUEEgdvzwg-1; Fri, 13 Jan 2023 20:37:28 -0500
X-MC-Unique: 2wC9_HpGO1iHBUEEgdvzwg-1
Received: by mail-qt1-f198.google.com with SMTP id z13-20020ac86b8d000000b003b322cbac99so1511206qts.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZy8c8fy0bsQa5T6EMyPtDGsQiznRhGW5hoUl+VQVKY=;
        b=oOGgzIf84+BZt1kMr+QpZNJa0xr4FVBBJ/VIb6wt5S+szKkafUxBDN+C7DigsnLhhU
         8EUXyKtTeQZ4LUFWFUj87W1IQ44vLwuHtxUoyuKitzUEimUSI54SjxqQJtNSooIGakRd
         2kdfObWX7+W+0eYMaZATfgIAitKlQsIkTTKFDO5NH+L0FN0edOTB6jhDBhYUAp97YK0+
         Ci20FUM0xZxm6nsoICn2P3MwATPAx1zaB0BK6d2fiG3DfVDkUucdyPjPr8mvgEXVX1gH
         RwRjJaayFGy1sEYgdSm+ynsgb3qUB8pvArTP8N1a8aga7M52b0d30jBQ7brx/rDivOkL
         eCVw==
X-Gm-Message-State: AFqh2kolXRDuWcA52tai+33RXbNs7QpgWjzQLnL88+e02S1p5Rvz/o27
        65KN8RktLcslLG4dSxXwD3qOVpnVBrG82aKH4RAm690RAi0+wIh8QpycVQItcKeta8Fcuwq6hJu
        PL9MWD0a1ch04qwj+zbWC72/9
X-Received: by 2002:a05:622a:5a85:b0:3a8:28fb:b076 with SMTP id fz5-20020a05622a5a8500b003a828fbb076mr107846186qtb.31.1673660247672;
        Fri, 13 Jan 2023 17:37:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvb2Tb9KjAktZHd4kQ+lb1N0KtnEmqYLvasUGIsxQAbnMndD0u7XJmgxkam6UrQA6YDD+2hMw==
X-Received: by 2002:a05:622a:5a85:b0:3a8:28fb:b076 with SMTP id fz5-20020a05622a5a8500b003a828fbb076mr107846169qtb.31.1673660247477;
        Fri, 13 Jan 2023 17:37:27 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b00705b4001fbasm10673981qkb.128.2023.01.13.17.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:37:27 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, qutran@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: qla2xxx: Change qla_trim_buf,__qla_adjust_buf functions to static
Date:   Fri, 13 Jan 2023 20:37:24 -0500
Message-Id: <20230114013724.3943580-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports
drivers/scsi/qla2xxx/qla_mid.c:1189:6: warning: symbol 'qla_trim_buf' was not declared. Should it be static?
drivers/scsi/qla2xxx/qla_mid.c:1221:6: warning: symbol '__qla_adjust_buf' was not declared. Should it be static?

These functions are only used in qla_mid.c, so they should be static.

Fixes: 1f8f9c34127e ("scsi: qla2xxx: edif: Reduce memory usage during low I/O")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qla2xxx/qla_mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index c6ca39b8e23d..bd6bc1a968b2 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -1186,7 +1186,7 @@ int qla_get_buf(struct scsi_qla_host *vha, struct qla_qpair *qp, struct qla_buf_
 	return 0;
 }
 
-void qla_trim_buf(struct qla_qpair *qp, u16 trim)
+static void qla_trim_buf(struct qla_qpair *qp, u16 trim)
 {
 	int i, j;
 	struct qla_hw_data *ha = qp->vha->hw;
@@ -1218,7 +1218,7 @@ void qla_trim_buf(struct qla_qpair *qp, u16 trim)
 	       qp->id, trim, qp->buf_pool.num_alloc);
 }
 
-void __qla_adjust_buf(struct qla_qpair *qp)
+static void __qla_adjust_buf(struct qla_qpair *qp)
 {
 	u32 trim;
 
-- 
2.27.0

