Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09086B80BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCMScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCMScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97280E2C;
        Mon, 13 Mar 2023 11:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AB661365;
        Mon, 13 Mar 2023 18:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38018C433D2;
        Mon, 13 Mar 2023 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732251;
        bh=akchBNDul5kGQ4bbsIzqd3Wkn40724BLCL8j8t0kerc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SJ8103HKr4PjUlRjoNwdWxY4QSChA0Dk/7hva88/LA8GHYXMB8IgF/YEsYBqr+vs
         gCkkVmofymj5bAKAEru2Vmoo+ZVILdNd8f3XVaOVgXwXnz+xAa9cj9TGJ1FMgAsRq8
         fwX+Gz8OgKIeU7d53oSMYt7MCRVpkyQGNP0GlA7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 29/36] crypto: hisilicon/qm - make struct bus_type * const
Date:   Mon, 13 Mar 2023 19:29:11 +0100
Message-Id: <20230313182918.1312597-29-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=gregkh@linuxfoundation.org; h=from:subject; bh=akchBNDul5kGQ4bbsIzqd3Wkn40724BLCL8j8t0kerc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82dXSruqi1/y0HkotvSXhxmX3ft6cbz25eoLbzpoxH 69heZrYEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNR280wz/zjnVbzmU4HznI9 bXQ9/edf9BXehwwL1gstPiSTGlNWepzxOtuTnxffXLDbDAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function, qm_get_qos_value(), a struct bus_type * is used, but it
really should be a const pointer as it is not modified anywhere in the
function, and the driver core function it is used in expects a constant
pointer.

Cc: Weili Qian <qianweili@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e4c84433a88a..fd1a38ee55f8 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3691,7 +3691,7 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 			       unsigned long *val,
 			       unsigned int *fun_index)
 {
-	struct bus_type *bus_type = qm->pdev->dev.bus;
+	const struct bus_type *bus_type = qm->pdev->dev.bus;
 	char tbuf_bdf[QM_DBG_READ_LEN] = {0};
 	char val_buf[QM_DBG_READ_LEN] = {0};
 	struct pci_dev *pdev;
-- 
2.39.2

