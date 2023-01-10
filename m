Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE36645E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjAJQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbjAJQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8445E66E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673367519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J7MvbGohPb9c5KuFVDOSy13hj72U3Wx/T4iJQbVeyfQ=;
        b=OdrCnAc/xoN+c6IFH7V6iuwLFxA/use7KNLx6ZYm+G0e8MJtcgtIxszfzLb+Rca2Psvs5B
        9xq0R0pyqPL7aoMGOFgpR0eQeiUcSoJL2mdS0zs7JBp/g/HhqBkr3OebU8to0IQyAURzpK
        NpesQ1HS52GlOuPZvGSXHxAA19kQI9A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-wRUgykLgO7CO8_FnisU21g-1; Tue, 10 Jan 2023 11:18:37 -0500
X-MC-Unique: wRUgykLgO7CO8_FnisU21g-1
Received: by mail-qv1-f72.google.com with SMTP id on32-20020a05621444a000b005319444bd2fso7122251qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7MvbGohPb9c5KuFVDOSy13hj72U3Wx/T4iJQbVeyfQ=;
        b=GaOmkEEnyaDBGzUsKPfbLYbdwxcpTzRVpxlEbSzkuZqHBL/YY1QzZa2wfF+WZUHsBA
         K/9j3JvCJRj2fV+sCGDB+g1mbJxaBHcRO/PxnvD4SPvTQ5aIDH5LnPfP97CX6HjZ0+Wd
         v3nJ/RQqigNUBdIH9zlZ0IN5EmjRA3V1Oi21ScZ4ewnbRFKcnJmRuCNSZyvqlexKUPxC
         IWp0hfJSiiu6IvjEdlhSp8Q2EEMYNXmMr5uaxiYMCmeqoB1XDpD835U7eah2VHUCsXzg
         zkQ//kK75JcavDBetcpgqgQaHEKr4Rfhodu0TrQ9GCv9mUWKsm9mAgPhw5+StE6Si+6A
         HxaQ==
X-Gm-Message-State: AFqh2koRAEDGUIrIemZSqSkSl2myx0tHp5BEL0i4DcRJ7JYXc3dQyjJc
        2XYi2DKMudPvvyOhTWoHlbeDn1zW1HpFaTbNl1+p3k5ToX68Pn46ww6pt80bB08kQZF55pUrPcP
        V9QjTPRuLnj0LkdnDBnrDReoJ
X-Received: by 2002:a05:622a:4d06:b0:3a9:9217:9e6c with SMTP id fd6-20020a05622a4d0600b003a992179e6cmr109627041qtb.55.1673367516965;
        Tue, 10 Jan 2023 08:18:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtvz6UJWZ+sKLEjeZfRYxKqad/zTOI/hkz1wPhI9svfnbTHZgxVGTtTAGAgwHNF9SUsIhqUjw==
X-Received: by 2002:a05:622a:4d06:b0:3a9:9217:9e6c with SMTP id fd6-20020a05622a4d0600b003a992179e6cmr109626901qtb.55.1673367515311;
        Tue, 10 Jan 2023 08:18:35 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t34-20020a05622a182200b003a527d29a41sm6190082qtc.75.2023.01.10.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:18:34 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        nathan@kernel.org, ndesaulniers@google.com, rientjes@google.com,
        marcorr@google.com, pgonda@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: initialize error
Date:   Tue, 10 Jan 2023 11:18:31 -0500
Message-Id: <20230110161831.2625821-1-trix@redhat.com>
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

clang static analysis reports this problem
drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
  argument is an uninitialized value [core.CallAndMessage]
    dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__sev_platform_init_locked() can return without setting the
error parameter, causing the dev_err() to report a gargage
value.

Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 56998bc579d6..643cccc06a0b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	int error, rc;
+	int error = 0, rc;
 
 	if (!sev)
 		return;
-- 
2.27.0

