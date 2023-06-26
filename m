Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53973DB26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFZJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:19:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250610DF;
        Mon, 26 Jun 2023 02:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLJcOVYFLU/QqPHLCT2XB/a68Ggkom99mKSiTEmOdthcnH3M1Cln1f83DXQCQbnNWivr+i4DXGoQpziduu7uKVZrlJBRNKwy8CmEXMOYiPm+57LFPXaOtwvx5hF6pvun+ixETMeS+1qdYqIMLWceeWgxyJMgOeJ2hcU8oENDs5r62CpUnpKbnv3sECUAEkq98GrsC9LP3ti+lFO5kCFn4AbDRnVHdR0Fph0FkgHgjjdEp6yHVC5LInU+KZ4pR92A8gXbgxGyT+NqQYz7jVMnu/4aVz30uoFLKr2SQiQsi3Qi4KHELZv5yoqTNN/VgNeIudX0cXxRMbZ04mN3coB3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjV+lzXivtdH8yLp+NP91bwF+0ubG0YmUx0vLqlWAmk=;
 b=ZxngXOi5FHwdZgxHRbf3UxBl2hn4BZ36YjHThaiSC6NEP5H1xphgwvFAPXMSukbxgTPN/sr1yY81ivR5wbqHo+Xem/L+3AMneBzbe9LXuSjfl1TOm5edyEMnHcg3kgB7kGx/Dqs3NyDeMcIKRF8ISY2Xp/DcEkNlggEZJIzYbcozy26Xm45LfZ4Mt2ZqLKqar9W/oqz+xRY00D9/pBt3dM5WhtmwV9nvr1CQLiFI1OWDS446AYr9Xe/qDnw+F5o8eF68Tdz6d9rIN6jXcV0hnvY+X3dBWcvoWjBcmcIxEC6MTx/aaoW/IwnlRDgk0CK2+qyT4VxeaQVIK/ph8CstLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjV+lzXivtdH8yLp+NP91bwF+0ubG0YmUx0vLqlWAmk=;
 b=e9Ze8YbXULeUS5oo/ON8SS9/SAfomKFWqZW8+9Dh3mg8hHO6/3puyJ5AJb4kELE25Tzi68DtuLYbcUVHHPZVxAIgVdukTNRyZcaGj3OHovDTuXMzTtACOySrq81HCJbiyqnjqdKj0l6ZphqfXeFdkHhSKnkorJOW+iGdby08P4Whr52PQNf6cjRTWMwNiuzQEi1rXP+gz2HvfT+9+nafTh4/Yqeg1sIcou84qyznnvzo3MiKRIeR3KshEY2nq3JLBOK1BKkE5xQf8JTtSFqoz3QLfQRofI/gYIjGrcFx9xv00jBCTLtTYVxEr3RRNGyrBPMrDP8Kxdd5qMyv1HqFLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by TYZPR06MB5177.apcprd06.prod.outlook.com (2603:1096:400:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 09:16:02 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 09:16:02 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        You Kangren <youkangren@vivo.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] crypto: qat - Replace the if statement with min()
Date:   Mon, 26 Jun 2023 17:15:40 +0800
Message-Id: <20230626091541.1064-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|TYZPR06MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb65a52-35af-4e07-c34a-08db7625f5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNvTEgsYZh2e+8QiozfhOpiQtuFHEUHdMwqCbMaRtsotcHFqmhxd4JWtlEtYvx4HONhy9Nfrg1JovReOoSS+cBN12uusbxrUAZy9hJK/4pDGPkPT/yqJIx4Cd5XqSthStzxQeF550hfuEyBFILcTwajwqiz5d/9cOdqdooBMsIOLHoSie48Vc+RfVii755uTuZtMX34ZJ4KdPHp+V0PJfPENrQHcaj7qBYgBX/ovWAsXgPo2JRxZWmNAiqI8RscPq0HoHOkmSzzaMzWoUAEO72Nuuv+V91NaBEkYxmk2c2DZARNm3yQeiFn2RofAekSY5cobjaMMqEBA6AgN3VGj3B86XnquuDewP+x7l7dVp5AR4v52WA4ViZMGhv+ZIylVP1xvVIaz70FM6g7jxAVrUdbcr3KoU00MoOD/DsZxLKQYBfD7M3I7+ENL33u86J05deG15gnsBjftPXrVlh+shSRZliGCx6ESOB9VAa9LVryk/vHKLzGJU2l7Y4WiEtvVqoY/CobUcn7CpdJrA+MrHJKJFQVCEJf4481UQQV22nGM7dLkfaO9WZCTFKG0ADSCQvPjqBnS9mTAeZ8ifLjDqs5NdGIAyDiRXX/vfmobyiVNUzq8sojmF38vF22B1Qjw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39850400004)(451199021)(52116002)(6666004)(6486002)(110136005)(478600001)(107886003)(26005)(2906002)(6512007)(186003)(1076003)(4744005)(6506007)(66476007)(4326008)(66556008)(66946007)(7416002)(316002)(8676002)(41300700001)(5660300002)(38350700002)(8936002)(38100700002)(921005)(36756003)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5PjN3DQNeAZ97wZf19ZjI3XrbOc3szmg/bE80he9sYDu+19sJyGHeEl76vi?=
 =?us-ascii?Q?z9UVjr+Lj6qshLrSoKGAclS+rqmn8aQOVuLRptW/jt7nRy6XL6og0XZR+2Qb?=
 =?us-ascii?Q?QOSxSrS+6tCFytUHN3UyPNgnGGoNzrqb0RRD4iCE5a8sDBWusVuIBKIe8di1?=
 =?us-ascii?Q?zPkTvYPrNdNn9lHmFO9r8ce4i4LuW4vreW/evCHgURlT891l3hOT0XrBEcWA?=
 =?us-ascii?Q?o6LP1Fu642s5ZuYwfH6Z9VEgvYuP1Yt0hnmmGYVLRxFduweVRvG8OtZHs89T?=
 =?us-ascii?Q?Fq7t65kO5w84cQapAQ8nIEbKi3W9y/E1g/37jTKanc3IQ6Oz8iJy3zBbNaQt?=
 =?us-ascii?Q?D0R5p+05WFwhAXJaU5+lBduTzpkMTFV2eendEqgDlNufr2XP9xrsTMFD3fMb?=
 =?us-ascii?Q?w6f0FkDyxk8uGDXhoSHIozj8eDLGwB8RLBllgFgkQnZymviz5QjIv462v7u5?=
 =?us-ascii?Q?x7eQLV4RPt+10hQR0SFrEwaQvLv3MVTGOVHPSjc0fhcOsxtARKLjDIkQOEci?=
 =?us-ascii?Q?aaePJU2f1K9Occqqbq6gIF1kieYUanyZMSo3vI5Bdu6/+FEhh1fA5oNRPc+h?=
 =?us-ascii?Q?b0bVbYycHGPuEeiL1UTQLiGZj//ZOtOInGGID9c60Hm74nhX4PYZ45iK3Ivc?=
 =?us-ascii?Q?B8oTpnsxghwoFUg7nTwS9C4NQ4JUaUcFDzC4dLjk7L4+2otbmfjPT4vATX4i?=
 =?us-ascii?Q?ammFO84UklbQKfcHWE74YjvAJ+w13ndR/GEAwvOupzY5m06r7aNmPB1gu2ww?=
 =?us-ascii?Q?ibaIenwyodqudBaWTREbfsWSWhT6dZEpkAsUl0K6i43BEYU0s8ZvM2SK+nd8?=
 =?us-ascii?Q?NUnR1SnBkXEBvkEbrpzbqaQb8H5quga5SnY2jok98txVHQjYcvLF+7ae6TLg?=
 =?us-ascii?Q?c7FYKuxULugOVimy9WThxvIYTPdSvICEw3QaeiH9tFxVarHoxWzJMU2hzJ9a?=
 =?us-ascii?Q?m2XU52Rx3B6/z88/kuGpw4e6JCIQhLOq0civTplXVD8zAr5KF8V/grZNt7uG?=
 =?us-ascii?Q?MZVKE9G3DHLBiqEJKqT9bwSCF/ETyhp+krDlC8qYVyAMc5OMud+Qelmilfi0?=
 =?us-ascii?Q?bLc3GMaypSBv5Htsc2qofJ7AKHZoFpLn1AVgeZSduSYcYsI0gkehx+Uncc/r?=
 =?us-ascii?Q?079JYEmCqSj7D6kI1PuHGOBrLvQlTjVGfu3bAFY8pyvYogUUdguiyqWfkLlY?=
 =?us-ascii?Q?Jw1svCuf/YtzJi2ZTDqsgB15NWnmRj/hs1H1oFr5iwKJZIl6va6ecZrJqFKQ?=
 =?us-ascii?Q?7qnIsg2u4c8QjCMIf2b1svIPxlEgWZrSyI3YvBLv0PaO+E26E+d+1KeP6uFq?=
 =?us-ascii?Q?/cow52vfLMaUZapJs2tAUluw8USiRwXDBXS68taMeE1rqrWYHp0ygAq0AUuQ?=
 =?us-ascii?Q?Vw6ZtxzA2L48vNKiX8KV3FheDPIQPR2osXyz3YI8dXNkPHyvh2pdjXA6/WVq?=
 =?us-ascii?Q?ObqTArFDxoFx4AtqV5qzTSdKhuABq4TpEXR5xnXECHigGAazMUO6ysKMyS9s?=
 =?us-ascii?Q?zWOle3+dRWsnhgBUzKj+fQiwHOl1wCwvsVkZ+4Phgc6lCsfh/blvnVTsgiKm?=
 =?us-ascii?Q?vWTmkld4xsXyw0l8aXa09jM4fx6EIrToLM9zOPE/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb65a52-35af-4e07-c34a-08db7625f5c6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:16:01.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TrDCQtUQNrX0Trp+zpN7SwnTxgX6sQvpn7xSibOBD1ZZOFcUvQ50R+idmwPcgKMeGjOuOTSO7GCVRiFBWhaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace the if statement with min() to make the code clean

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index ce837bcc1cab..56a1947c64ab 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
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

