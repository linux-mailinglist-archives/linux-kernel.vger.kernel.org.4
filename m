Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2551665F59E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjAEVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjAEVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964F60861
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672953559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dr6WuGFgn3lsUzUTklOx1mec9m003HYE8pI42id0om0=;
        b=Ow9K/wEZs5J9178IkCkXursCmIH2Qq7Ci/g9l9JWnnAQjcEx78HL/JlqDAa52lRBwQ3uSn
        bmwDECFlvxNahNYy5Ec0yvksFTs4MwNOt3jXsdG3dlEt5ZULqQo9R5XkcC4l5UnOob4xBq
        dWysKxQjBmBQd6/f0oZhlR4m+I6pu4g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-n4cBn491OM69vaiduoZq6g-1; Thu, 05 Jan 2023 16:19:18 -0500
X-MC-Unique: n4cBn491OM69vaiduoZq6g-1
Received: by mail-qv1-f72.google.com with SMTP id cx11-20020a056214188b00b00531cacde854so5804058qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dr6WuGFgn3lsUzUTklOx1mec9m003HYE8pI42id0om0=;
        b=4xUH3nQnkX/P452B9AoeRDW1nmbRq6nh09mBxCWHYuGghLYR/0LkbPomNUOup8CGsT
         1CwMcPCmzBsne2tRglg8hUib3HjalELKwgG+l2RuSI7b6M/RWaxu0CJashvfPeM7r/7I
         ltn4U+CLcPwBUiSOr7p+WC3XOpU0Di8ehLa5XBDzT/MqwzoGk/osGENzohD/wjGN0FLr
         pP8kw/Re1dQQn2MheC3jKlknikC6UBYj4DBkol0aZApXopl16jx/uoCKP3ew+s/cBhSc
         VkgDLrYGfj8gkeRdeKuYzSDkZ0eI5I3feRHDFzVMcB7KfTm9gdbLLk0n1ywvGc7c3Hun
         Rsmg==
X-Gm-Message-State: AFqh2kocImkG7IasVtM/fK18z0+JU5nLudhlVyQt4huvdAgnJXMCHEiG
        +yyov2b17pQ+bfYfqeWzIbHRaC0y0YtuUZuE9CtATUrH6YfKZgYVw0p4pc+i43kWe0NgAq5+4KY
        uiKBdTEk7zSK56s/fW+Vl5t24
X-Received: by 2002:ad4:5362:0:b0:520:f8fa:5ad8 with SMTP id e2-20020ad45362000000b00520f8fa5ad8mr64600719qvv.17.1672953558072;
        Thu, 05 Jan 2023 13:19:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXseXrlDGPJVvsIgIjlWKLibyWOq+e3SjxItVbfKqMuTnJRcqgiNlKhtIddkByXDz+/MSbYMyw==
X-Received: by 2002:ad4:5362:0:b0:520:f8fa:5ad8 with SMTP id e2-20020ad45362000000b00520f8fa5ad8mr64600701qvv.17.1672953557847;
        Thu, 05 Jan 2023 13:19:17 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b00705377347b9sm11643264qko.70.2023.01.05.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:19:17 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nathan@kernel.org, ndesaulniers@google.com,
        Vijendar.Mukunda@amd.com, Syed.SabaKareem@amd.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: amd: Return ENODEV if acp63 is not found.
Date:   Thu,  5 Jan 2023 16:19:12 -0500
Message-Id: <20230105211912.824250-1-trix@redhat.com>
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

The clang build fails with
sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used
  uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
        default:
        ^~~~~~~

When no device is found -ENODEV should be returned.
A switch with a single case is overkill, change to if-else.

Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/amd/ps/pci-ps.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 401cfd0036be..cba8800ab4ea 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -205,8 +205,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 	}
 
-	switch (adata->pdev_mask) {
-	case ACP63_PDM_DEV_MASK:
+	if (adata->pdev_mask == ACP63_PDM_DEV_MASK) {
 		adata->pdm_dev_index  = 0;
 		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
 					     0, adata->res, 1, NULL, 0);
@@ -214,8 +213,8 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 					     0, NULL, 0, NULL, 0);
 		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
 					     0, NULL, 0, NULL, 0);
-		break;
-	default:
+	} else {
+		ret = -ENODEV;
 		dev_dbg(&pci->dev, "No PDM devices found\n");
 		goto de_init;
 	}
-- 
2.27.0

