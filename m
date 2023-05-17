Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15A706F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjEQRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:31:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501EE53;
        Wed, 17 May 2023 10:31:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-966287b0f72so187273966b.0;
        Wed, 17 May 2023 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344678; x=1686936678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJy59uOGIkw0Tx12sjP0NCVI47XHTTAmWTAfafiu4Ys=;
        b=gEE6G8rATNLJa3i+qONiA9wQm+IpGPsdMqs8RsdWFM8gnuxuk9i1wqteXq1x3/7vMp
         F1OkSVeBhKKR6p4PA18blyjLGg3JpdKK7qEXAXrL0NRNOfPmSH9TPXRX+4NJazugYAxI
         GTz+URmkRJaRdiQDCFuyDgiGGQrAnlzq1V6Xhy88zvEtM+TjthR/wGJn63xrdMtC806K
         lZnZ3OlarA/y51pNRvU2E7sPRkst+fK9JyFQyvWULsuaidkY6pV/nh2qJT9ar3AAkFPA
         IFI+rMSlbhs8NHfhryWNNtFo3XK+wNSn1NCmLmvuUmSrH2epLFBi/rHV90S5uHf7BvFg
         Ufvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344678; x=1686936678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJy59uOGIkw0Tx12sjP0NCVI47XHTTAmWTAfafiu4Ys=;
        b=NCC3BtUmqRtxIY0wjn1Ev+bGdI0cDtsN4jz1JXVAczsFYALNVZdwdvIacKtMpLq48Y
         +EmxTmlBSokqoser3a0LbNKQqkg1mubbdbOqd7mQgYTYy2dfpihA0mVu/gDB/WcI6C8D
         vJEkAGhfmGE50K/CUDpJJOUM5DyH0rcZKj8bp1POGITXSQD0Ki6jl+alv1XjKEI98fdS
         lXGcWP+Buw2JS2dNcOVumUYOzkXx1ryS6Ha8cRLJ+S0iCkvHh7Mc/pcllGOnxKqSAQfi
         XWl9cbV3medkO0NIwGJFJ+wHr/n+8PWIAacusoZa4aErbLn1jObknje2XFqwEkSJwIan
         To+A==
X-Gm-Message-State: AC+VfDzwDO3iBr/F0CpwPF+Y81TM7eIYAA+EymOdAFEXqSQ7Vm7p/u5w
        tber97j5Gj2BH75exegYIr4=
X-Google-Smtp-Source: ACHHUZ6PlEijcd5S5JblKdWaIcl37kIOdqbwEbny2EksL9zDUjlnSCSqY2a5ca6/GM/OB0YsYBsw8Q==
X-Received: by 2002:a17:907:31ca:b0:961:8570:4591 with SMTP id xf10-20020a17090731ca00b0096185704591mr34747833ejb.40.1684344677770;
        Wed, 17 May 2023 10:31:17 -0700 (PDT)
Received: from Osmten.. ([103.84.150.101])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709067ccf00b0094f23480619sm12714825ejp.172.2023.05.17.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:31:17 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     broonie@kernel.org, fancer.lancer@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] spi-dw-core.c: Fix error checking for debugfs_create_dir
Date:   Wed, 17 May 2023 22:31:02 +0500
Message-Id: <20230517173102.14096-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch fixes the error checking in spi-dw-core.c in
debugfs_create_dir. The correct way to check if an error occurred
is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ae3108c70f50..c9cdf6bbcd0e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -63,7 +63,7 @@ static int dw_spi_debugfs_init(struct dw_spi *dws)
 
 	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
 	dws->debugfs = debugfs_create_dir(name, NULL);
-	if (!dws->debugfs)
+	if (IS_ERR(dws->debugfs))
 		return -ENOMEM;
 
 	dws->regset.regs = dw_spi_dbgfs_regs;
-- 
2.34.1

