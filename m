Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25DE746A54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGDHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGDHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:09:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C199136;
        Tue,  4 Jul 2023 00:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhTDlhFBS4/RoNkLYLoIuoZqlfJTOg4YZPvqmxGKR8fLyELIJyAdr40MGUZUwlFApmwe/UGIFeizjHcKZD6m67NFO1YlNBDX05McJoZR3H35a9kfz7xITJtOq1VxT62soabEmp6/ovDElOgBfWYvGGm22uHCyyGaMkl3NE/PEmLJolA28liAu2xJHVo0/693JQrvlb0Z6f7reU+FsOH/v20HQUn0+0oE+rGC9AvtmJ69DQ3i9H8f9sBqVtmDQIxEx6P67uXJMX2iqTGIs+RlXl6UXKn9JHZg4IgQQ+U1ltcHFrJg/aHpG62logavCPBTpdLoQPZTTvUWsvaiuE1wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYgeKieRI5XBKT49OYzjNGp8Z0GQXF+qUCsyiaysUM8=;
 b=IZw6U3NIt5AJ7xsp/0imSh0KXzU4sGFpR3ptSYUE40jvDUShzLwTMcUIYBPAkbAF9WcVpjc2B4j+QqRMI8i/Ztzv1Ew3T5+JVB30tAq7MAdDLi6OEYyBRbvp4MZS2B5ppWuuLGW5VbQNn9GcRzkURTQLTnPIRjT3vb1Bju6tXSSZCGI7K41I69Vq4aOl7zP4/oMVowhEkgQF9b4kP6qrjCDVGIijWNHxCejecW04AA5tMp+1U6up1Z4L4urLuErrkO3e4gMtKDlxJlRuf8FYjrmC1ikkRRxFcPq+NHrFHGT43wzrbzKodWZ+vW+aCVnA/GXhghJDY8qbwWhMzHF1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYgeKieRI5XBKT49OYzjNGp8Z0GQXF+qUCsyiaysUM8=;
 b=c6xowx3tL10ZTe0bvl46yiPjB5f5tUqcnjswA7N06EetpK+zGPsDRRglms9jnGUr1i1PkjkQjJY2pkCoM/zdRiuwuHsFIre8RQb5N0NkcawzWtFb8WrJB15K6ucSmloSnGMqsKKm9QyI48uSYTjTd5tMAA4bBkUZhxWpnWh2oTJii8NUwEwL0EEMmBgn3vZBOHUU60nLviOz1MVImRceeZ4GpQ8uYDxUnmgaMsItxpRqvigLgANTRXoZxgexaorKPE6kQD3mli/6O3SHfdEzmlucbvOmZ3zavSxDtI5DRH7Nv0o7X807bdWs26PnH98oS8FqOR7Vgqqsqu4tglrOIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by KL1PR0601MB4586.apcprd06.prod.outlook.com (2603:1096:820:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:09:22 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:09:22 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        You Kangren <youkangren@vivo.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH v4] crypto: qat - Replace the if statement with min()
Date:   Tue,  4 Jul 2023 14:56:39 +0800
Message-Id: <20230704065643.32220-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::13) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|KL1PR0601MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a20d304-57cd-43b9-5402-08db7c5d979e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bs9Ed6szISxF1KaF8m+4LJV1qdDj4LQo6aX1tzYFjdBnr6YNlZjV59YRPUKRvvXgHJUEuKgXc/UVyRAOgmVOU39BMAo8eWZNLCWp/t1AVgDAEeXPXW5xxmMQnbGljOD3MOVCix/IP2SUCjaxuoCCpzXkDsL/jOrBZ0aWvTy+Wl/gYgNNcu/jY6wRXf5G/rtUrVVW/m6bb0xoBh97tnkBmcP4tAcSoshILSUKiTasWsOSYU4I4zpESApO24y6nOtGkSeRAKGcrvy4SmTiMF0hAPH85VBSpbONDqEa62NZ7Y08CIy1F6NMypK3yvnQxm0a0VIkbGrKMUOfaRlDrtQllGcf0hpb3Vxa7jbtIvyKVlqyAZb0dDqX7AwPl/OpZgpDWQn6Q0D8z2Ousyc1yXwFM3TFcuY1xwuzsSMFo4jfQbGnNly6jKsnf6hEvZ7XwrdeiwG3Vir3t+e3JuvlMBbjpVZdYjTAWxDO2zcYK4VaEalhJeGdJWOAjrWPvlOGBhwS02Mkz08KGqFMKbASgrGJXFFMwJDubHQja0s9+5fg1AciApG09rdDDt2Mu7TKfw4ScC6oqZaCwLTL44LC3mijsDHMjRaEXYYkabfw0Hfjs1+HmJAXU8HyVyVe4FrRYmePHQl03JxYU7ZJUBln+bMv4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(36756003)(86362001)(186003)(2616005)(26005)(478600001)(107886003)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(66476007)(4326008)(66556008)(38350700002)(66946007)(38100700002)(921005)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xiQS07ZejqvsOIpyX59Y5rmeFwBFfe3fpLERPyJE5AKfVOHquT3V2SLTtQC6?=
 =?us-ascii?Q?ohxxobPwn8iaylHyzdY5onTiJOwOyEDTHvq9D8SDgQLA8xkCboxmPN/O7Ftq?=
 =?us-ascii?Q?S72KPR9A0HCB400IuWN0EmVQZqKzOXV6MDi3+7rPslJJGfXjoqmlGj2SylS9?=
 =?us-ascii?Q?5THN8WBN1sV/zZq5vjx1SgfkJSv4IvDuv70kA43ERP+XTkmUT6UG1t1C2YEB?=
 =?us-ascii?Q?FzYc0XjDpQGmG3WFlOlgCDgb2NntfBZeUwcfWBbJ0RW7RYPpaZMrrGqEJ1Q1?=
 =?us-ascii?Q?5cq7nyFCdzH3wLvAO6YmUZ9Fp0oBOwu1Ig8BX5kOpNkpLPmy+JbXgXi9TTSx?=
 =?us-ascii?Q?PoZTRVh3wrVaEJCZV7KsRH7uW9qkZE/OodUU/Ac3y1dHCPWvMVndSepS48pA?=
 =?us-ascii?Q?KljzctXSqfSxy+P/fFiHAZ0+26+7RuKxr1xJN02maJHGPuJTUpzNwCnPEvHw?=
 =?us-ascii?Q?h2jlXPTysRASRK+EiX6lZjhFVNXW55HvVB1i+zLaYOQ1444HmJiyi5t9FNKk?=
 =?us-ascii?Q?A5+zPRBEGH9R9fUmJwS8xD0L57VRxfgipCdHgVXeKwJf3WM4U7ngk5t5BmPW?=
 =?us-ascii?Q?M692/8jAN39m76GZ59wN8ZRWG6SOttEx/gHnE7ooCaeawQIkVjz0YEheWBlC?=
 =?us-ascii?Q?2JWpWfiUXj3aEToGJl6ntSIE8hA4ace58kNylpypPii81gAGVklP55zRHUI+?=
 =?us-ascii?Q?x/q9oBuaSFdyNWxGlj9iaxwa6VHn6ra8II0Odt4S6Pn+nRJ521hL5BtSLBtB?=
 =?us-ascii?Q?azbb1ivwZC9LIAmWM2LyXBvUXSCf3kM1RdD7QcNa+ZzOZGCeMhrxIowKk6FG?=
 =?us-ascii?Q?37YU00uzEQe+/+LBe9xGPsyLg8lyxCrMaJjNSBvmCN9ipumbXlAABV2y9H7M?=
 =?us-ascii?Q?ib85WGxr07AGw+SedoPsgfFNp2pSsN//bAldIcVA7WSBS/YwgK4eBzPCsIvx?=
 =?us-ascii?Q?FfEdB6/zTStHndoOXSf2bD8OMAkUFsOoMQ0u5iYGzKyU04GYRFaCN06aoEgY?=
 =?us-ascii?Q?ynbKj4MekGP3GNtJXHRj9UAfMemBKrLOo+tydI3/0gEVb/Zi8KDtBJb/s4Bj?=
 =?us-ascii?Q?FnnCLb+LnbzxCJku1IfD5z3babgzCDQD64efFRULD2jGkNXpvvFSTIoc72HA?=
 =?us-ascii?Q?GQAgBiWn9dU8NqX48tx1AdVxfVz6x4C9iNIl72m5ZQuyKas+lLaeYH1HBZ5v?=
 =?us-ascii?Q?tnQBMYZ/69nkiQfxYO14ARrEWaRZmukD0hEW+IReM/HKEMLitSWjCC4Z3ejD?=
 =?us-ascii?Q?Xz/taCXXjQGpgtmg3H/Im5mL27scTKdaq4sxue3X2ezvLJMqwAgccGbtxVhc?=
 =?us-ascii?Q?XW/yF7Xg1swTFWIiS19BzR1On32hApa78oJtZGpEFOmQLYmZ/7TEf5wfbkFZ?=
 =?us-ascii?Q?QYU798Q3wfGPlCAlRfTKwpAyOhoLC148aZEU4u2Ni864D4lUmN+GlQgSdrdF?=
 =?us-ascii?Q?lCzxxW3LRdYOI1c9si3NL/2NRDK3gfc9GoUEPMuFOFxRTL3ji7mQmtumHpSE?=
 =?us-ascii?Q?kL1XharbQBJ5dQ4Zfc7DxCbN4xWoxprZwDBwnQIyvaoyjW0VCd2PRx+k91SN?=
 =?us-ascii?Q?/TuzNZMc51d3FKWqHqg6swLj8e2R/KhsuS7To7s0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a20d304-57cd-43b9-5402-08db7c5d979e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 07:09:22.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h8MxoOvwGJUjS+GPisDqz+eWMl8oR8X9VYK2lMdSrshBpwNRm8hKFV1CfVAeDyHjQdaGRw3COA0DSWG9MUQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark UWORD_CPYBUF_SIZE with U suffix to make the type the same with
words_num and replace the if statement with min() in 
qat_uclo_wr_uimage_raw_page() to make code shorter

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index ce837bcc1cab..4bd150d1441a 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -11,7 +11,7 @@
 #include "icp_qat_hal.h"
 #include "icp_qat_fw_loader_handle.h"
 
-#define UWORD_CPYBUF_SIZE 1024
+#define UWORD_CPYBUF_SIZE 1024U
 #define INVLD_UWORD 0xffffffffffull
 #define PID_MINOR_REV 0xf
 #define PID_MAJOR_REV (0xf << 4)
@@ -1986,10 +1986,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
 	uw_relative_addr = 0;
 	words_num = encap_page->micro_words_num;
 	while (words_num) {
-		if (words_num < UWORD_CPYBUF_SIZE)
-			cpylen = words_num;
-		else
-			cpylen = UWORD_CPYBUF_SIZE;
+		cpylen = min(words_num, UWORD_CPYBUF_SIZE);
 
 		/* load the buffer */
 		for (i = 0; i < cpylen; i++)
-- 
2.39.0

