Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550CC629472
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiKOJgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKOJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:36:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D313DCF;
        Tue, 15 Nov 2022 01:36:28 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBLdx3c0JzmVwj;
        Tue, 15 Nov 2022 17:36:05 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 17:36:26 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <David.Woodhouse@intel.com>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>, <hucool.lihua@huawei.com>
Subject: [PATCH] KEYS: asymmetric: Fix build errors as symbol undefined
Date:   Tue, 15 Nov 2022 18:05:12 +0800
Message-ID: <20221115100512.20147-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pkcs7_supply_detached_data is called by x509_key_parser module, but not exported:
    ERROR: modpost: "pkcs7_supply_detached_data" [crypto/asymmetric_keys/x509_key_parser.ko] undefined!

Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f6321c785714..4fa769c4bcdb 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -485,3 +485,4 @@ int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
 	pkcs7->data_len = datalen;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pkcs7_supply_detached_data);
-- 
2.17.1

