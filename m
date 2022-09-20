Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB55BDD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiITGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiITGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:48:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B205E322;
        Mon, 19 Sep 2022 23:47:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l10so1427322plb.10;
        Mon, 19 Sep 2022 23:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/0Rz+GvF75/viJBLBQEbjgxFNtevAf1f19ZOsGn6xi4=;
        b=qh+ChxHC4uR5klCXtcOjAj1X+W2LtQ/QqVQ2Q7Jo9+fZTVVaW8YzwGVfiwk4yyuyXG
         NKA3KublXvFN2Ax747Y0MPS9dNbxIJG3eRiJR5OTauPBVbGLlcmRMxgcekw5N03ak37L
         pvPGSaKdLC4xTAMZSorUrirNa5ExFzPVlOsySzC+hhqDZDCHgE35aptcJS2Oj3ai4HoT
         VzH7to0IBR1F/X3i3gjOmMY/ye0kirpNOVkub0lv+lTssA8PtMVnW2fvau7wJul7rV1g
         E5MFk5610LiZy6mcjq51fPfdhb2ztWDpX4rYS8VEWQcQFiHktANzHBEtU2I/Cr4nCLXs
         TnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/0Rz+GvF75/viJBLBQEbjgxFNtevAf1f19ZOsGn6xi4=;
        b=1LnKVoyGKRHMDeTRdVuNDOL+KW72YF1oa4eAOgBh98uc3RR1UVGIKgw/cv524fkjf8
         6qyEdqAsdSWTU7J5jrZllNT7MpBgFMWyaDPgP1sOzmbtBhVbKMNqUNXKAnuyiWmPlyxS
         NbQzahWVkb0Nvib9A4drpRc1LvzaBTEnj1Pz0yomglaEKKmurlgUfhnva5Rm9DDhI95m
         4iU+NJxlG/kig2kaZElxTGKYBLU7CsUYFU4oQkCyiGrXdPWGQKpXKaqrQU28Z5y6HC8D
         R97l3ppYZz0pUWpqDmx/uLDDhezZ7Awo/IK1ixcCXOweOzOs12rz2qOlcG06nxMGvV56
         ROtA==
X-Gm-Message-State: ACrzQf3qPU9CiAm0nqsyK7rmduKr46zwWkNCutQCKCW3jttvNQsT9L5J
        Gcp8jMR1H4OZAfFoozpA2Eo=
X-Google-Smtp-Source: AMsMyM4wFjJ7dfYYWjRmeijZNDdyYepAdqexPx6ifurY8mKAZ94mGA4Rd77hVQjppW0uyneefh1ZEA==
X-Received: by 2002:a17:902:ee54:b0:178:7040:f87c with SMTP id 20-20020a170902ee5400b001787040f87cmr3533573plo.8.1663656478359;
        Mon, 19 Sep 2022 23:47:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b00543780ba53asm650468pfr.124.2022.09.19.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:47:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     herbert@gondor.apana.org.au
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: octeontx2 - Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:47:54 +0000
Message-Id: <20220920064754.215430-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value otx2_cpt_send_mbox_msg() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
index 02cb9e44afd8..75c403f2b1d9 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
@@ -191,7 +191,6 @@ int otx2_cptvf_send_kvf_limits_msg(struct otx2_cptvf_dev *cptvf)
 	struct otx2_mbox *mbox = &cptvf->pfvf_mbox;
 	struct pci_dev *pdev = cptvf->pdev;
 	struct mbox_msghdr *req;
-	int ret;
 
 	req = (struct mbox_msghdr *)
 	      otx2_mbox_alloc_msg_rsp(mbox, 0, sizeof(*req),
@@ -204,7 +203,5 @@ int otx2_cptvf_send_kvf_limits_msg(struct otx2_cptvf_dev *cptvf)
 	req->sig = OTX2_MBOX_REQ_SIG;
 	req->pcifunc = OTX2_CPT_RVU_PFFUNC(cptvf->vf_id, 0);
 
-	ret = otx2_cpt_send_mbox_msg(mbox, pdev);
-
-	return ret;
+	return otx2_cpt_send_mbox_msg(mbox, pdev);
 }
-- 
2.25.1
