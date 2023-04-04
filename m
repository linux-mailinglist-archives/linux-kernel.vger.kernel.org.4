Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3D6D6C44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjDDSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjDDSfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6876A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680633100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kqVwTNITS5LavtxWV49y7pnbu9BH/mXm8R0NkMEV8rc=;
        b=QjbOaZ67AXXX9GpQpqlflUAuN9Y9Tv6A7kiCBmzcs2ezcf38/dFlJwxPj+B0JiU7qqIwsk
        DkK+TYjofcAHC/VD5Cxth33Mi5EZJAl55MsW6iC7qKGsJTXXkULX8NFDLySerxphv5+OFl
        6QkHbchghJtN3mfEsHni0EpTPE4rD7I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jWeqaMDsOkC0j_Cc6d4oRw-1; Tue, 04 Apr 2023 14:31:38 -0400
X-MC-Unique: jWeqaMDsOkC0j_Cc6d4oRw-1
Received: by mail-qv1-f71.google.com with SMTP id oo15-20020a056214450f00b005a228adfcefso15178299qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680633098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqVwTNITS5LavtxWV49y7pnbu9BH/mXm8R0NkMEV8rc=;
        b=Mi6l1qenwLRo6d+M8aMWkDzon5YRLfM6uPEz3+FjO1WEtWeCm9/I5X8tKxkKtZXgIX
         eeME/Ca5cUz9NhGp4/Ve5c61OH1MN5T4z1UOjbO1ilejpjA5fXDaMcpd+B1CAZ1GS565
         h03CmJWFrKAcFQ4ajNveixZLzcay3TnAQu+w7gYfECUtTO6WTa6WcPQqjEzMil6jx3UC
         Fc22R50SriGnxoWyhXvK0TPDHDm7c42QrESMSD9tBGKIIdaOSa5D1V2D6/+Ugl4BF5tL
         TYQwRmkiAuL1HIdFjMtmI48v1hqws5uEa08fVii8x3btOH5WmVOnc7n561EQiRPXUlef
         689g==
X-Gm-Message-State: AAQBX9fjsgmtTtG2FG8eDKW6C25OrizZ5cCpRwd+bBV41CPuGVpp+qg/
        nvLkIyOdPak/frBooBgjpRG1zzHZs7AjxS6GNZBL551kkXgtUi47AZcEIITYAlwNR8eGWaITh0x
        ayK3sceozcwl4ennOI0MMemMS
X-Received: by 2002:a05:6214:2aaa:b0:5d5:f87a:b3d8 with SMTP id js10-20020a0562142aaa00b005d5f87ab3d8mr5614261qvb.33.1680633098000;
        Tue, 04 Apr 2023 11:31:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350b9Ge5E6r7DJNheY8RCY2Na7i9I8CfgQKgpzynP2dooRuZfVKJr/E70TrE/gLzMl8hUYy2IbQ==
X-Received: by 2002:a05:6214:2aaa:b0:5d5:f87a:b3d8 with SMTP id js10-20020a0562142aaa00b005d5f87ab3d8mr5614227qvb.33.1680633097764;
        Tue, 04 Apr 2023 11:31:37 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r194-20020a3744cb000000b007465ee178a3sm3775341qka.96.2023.04.04.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:31:37 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nvmem: imx-ocotp: set varaiable imx_ocotp_layout storage-class-specifier to static
Date:   Tue,  4 Apr 2023 14:31:33 -0400
Message-Id: <20230404183133.1925424-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/nvmem/imx-ocotp.c:599:21: warning: symbol
  'imx_ocotp_layout' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ac0edb6398f1..fcea9c04be96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -596,7 +596,7 @@ static void imx_ocotp_fixup_cell_info(struct nvmem_device *nvmem,
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-struct nvmem_layout imx_ocotp_layout = {
+static struct nvmem_layout imx_ocotp_layout = {
 	.fixup_cell_info = imx_ocotp_fixup_cell_info,
 };
 
-- 
2.27.0

