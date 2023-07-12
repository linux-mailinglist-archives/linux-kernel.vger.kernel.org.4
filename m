Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8563974FF08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGLGIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGLGH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:07:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2049.outbound.protection.outlook.com [40.107.241.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AFBB;
        Tue, 11 Jul 2023 23:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=karFzl4F+fgUS9z7cdsu+2rKH9zmJ4k4N+nF2GYiK6XmLZRNIlmTKAd1OcDNzmVF8GrTSIBGhVyUNDxZ3S/lEDNr0rwqPXepOzDzAclkwS/7OoztuUxSGur+1nquzUDeDnnZKwn+1lzQA011OjpyO7HwAWoTUsWIJDoDNcxR4RdmvJ14mqHzdiu4KOGHcOoxyvRcfA9EXPtpAVD/tMoXJkY615unxfMRYuehl5T1EYv1QnU5ZQ1CNFvfxHd46x2RSVaV+40N9SbNtpYmMBfeXlVJqdISTIh6K6To50aQ1tv501aFrZ8blM2EYHZPN93XJFWBxt3AIzI3aoMcQOffNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIAuaryKLmv/ULq1z+8gCYqgMdDq6s2daStRaxceYOY=;
 b=DfnkIdBVcwcIkuzkvpp5qGn6FzoJhfaGLG7rW1UjaYMRc/5QTnHGfrSclmnE0ZgO2FoBedQJASWEbj+iBod3n5eA+RzD0m1oC6iZR0GB+kIMdu0g6R3SKq7Q4LAM+GoVnfTwGoK7htmLgBaneWtDpDmK3I+eTIMNr7Xdi74QRcXnlJ6d23jQE6W+g/WNH0r41EFePzCHKKiMmvD4Cz/RNkzWKHMGoCW+s3f5jrNRbz6TisVJ6YZ70CGUXQ2HkEUEtwfv06u9y5qzPjBWGlU+k5fY+csg0gxq5NSSiI6P70SsB+bIIkAD6lpNrqc2lbzqRw+SnqIYGs+bZ2zs+nDw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIAuaryKLmv/ULq1z+8gCYqgMdDq6s2daStRaxceYOY=;
 b=nPDXtP+mtmhjVtjYd5d+TrBXc2rth7IzRqSypCZP81f6VLz5VZIZSgs8ffWnEgal3Y1ol487Nw/nuGyaBB3CcF25YJX+aZsTVwB+JWjPY04+7DKq2MyQftX5gEUT8n1RSQnYVIQ/UcUH+/fa70+l+9WesMi2d9PaXQF5pZuDioY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:07:53 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 06:07:53 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Franck LENORMAND <franck.lenormand@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 1/2] crypto: caam - Change structure type representing DECO MID
Date:   Wed, 12 Jul 2023 08:07:27 +0200
Message-Id: <20230712060728.3562376-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: c75084b9-bb07-4ca2-9cfd-08db829e5424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Op5gN6XXbw1q1eP80+Cah3eg6/nxHo8k/KoAzfml3PcRewmdlQKT10KIQUJf6UEt3eB0BIpJoEqnKGr132Dm7E713aHBINHNufkunggUo1vpwiFRoXKHp+bycStIyTJAehjZiYCReTVZpkCYzAJ8fZXJT6vOAlNDjSwDGdqwc85NXSeKRa0j5IBnt/GghuP/Hp2wq+oWK0ltoPI0PM/sqRBOJYBiUqcq8ggXeRrOfw1ej1GOSRBk7Cq58c76Zbp1hpoCdUE4yXOTMt+jzjxwbRVIclNQj5mFtPTEPKZJ5TLhvN0NoieV3g5uu2+4U1lIZV8uw0URCdQZmHu4p2rq7m7enQrYT4JZww2hplU7gyUSS7+Y9smTmr0u1z18dZbBs6sSfOLN/dP+BmkYIbxogwOV0ajF1ryvFQN03p12+AmZT1dfxCI5kE5drr3MRAe+SrQPxO5OEBpM3WiPCEPmBFmtm7zngO88R8SYRV6twrgmd/beRnPahcISIfiRbqETMUOZ6v0F44c8QpKDyXQPtIdm9n9AJqSrWs9o3xU7S5YdaCNHZS754eLrr7owto6cRP+m8skZPogY8QhPyYZoqhJkIdJ7tGQGi+xQxJJ3qnWg9CqEb4/so+nbJ57m27n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(52116002)(4326008)(6486002)(6512007)(316002)(5660300002)(8936002)(8676002)(478600001)(66476007)(66946007)(66556008)(54906003)(6666004)(26005)(186003)(6506007)(1076003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUN3YnlZSGZTd1VodlFVR2o4b09nZ3E5ZnVSeitxNTNIUllibnRUY00xZjV1?=
 =?utf-8?B?MzBMSlhCenZwVEcwVlZ0ZU1JWUo1bjZoUkZHenFLMXZXS2J6MXM3U0pxMjdt?=
 =?utf-8?B?TnJHTHpyR0RtQlFtSWFrQ3orNFRVOUFKOUtkV2RsdTFHT0RVOFphY2t2SVFV?=
 =?utf-8?B?OXdPeDRJbkJqNldyMkNHYzZ1c0xpdW5WUzRiUzhjaXhyY2lhSkdTL0Vma0Ex?=
 =?utf-8?B?aFNQMGlCcGE3emt1TjIxT2paWnFQYmNkMlIrTlFTS0MzSHlxaU51TnJjY2FS?=
 =?utf-8?B?eStkdEFtTHpkcnNvUlFTQkNvdlFZajNreHd0Mkt6RWRydU9xd1pBS3Fsekc2?=
 =?utf-8?B?UVR2MnlPMGk2S0NyejhIY21SRFdVODJlNlZsdGdnend5REhTbHlQZmw4b3N6?=
 =?utf-8?B?VEhSc2EvQTdxRkltWjNoMTdHTnhSb0xlUHo5Ynorb2IzZzJlRkI0R2xzbDg3?=
 =?utf-8?B?d1RTOHkxWnNKSXVESFFCWFgycUcvVFZiaGg1SGVYSlJmWVBDdTd0S2o0a2wr?=
 =?utf-8?B?dURqYzZ2NHlrOWpFQzlaUndEV2R1QzUxSDlCcEVxOU82bGd2U3dXRnQ4OVRF?=
 =?utf-8?B?Z1Q1SHJVRXI2TUtVWWhiUFBDdUcvSi9ZOXFTUjkvK1QwWWNDem1LclViQkEr?=
 =?utf-8?B?TG95bURJbDlmRWtBWllocXNHOGZvb2tOc2o0NmN2d0Z3Vzk1a0VjZkZKUVlE?=
 =?utf-8?B?MGowMkU3dkxRSy9ZWEFSVzBuRUlGYXAxS3VKMmxwY3p0RXNjdVJrTTRKUitt?=
 =?utf-8?B?N1g3T3dldUoyU3VENXI2U1J3ZmNUU3FUZGlCb1FFWVBjcTVWZjNOZVEyRitw?=
 =?utf-8?B?UjBwRWU2NnYvbWhNRWpVOXhlQnpJSitMWXhOT0lpVXdLZGdVUThEVjFkZEU5?=
 =?utf-8?B?OEhKcEhlR24xRXZwS3htN3JqdTRES3c1TllVYXJJNnp1SC9FTkZlajdIM2VO?=
 =?utf-8?B?eXJENWRIUW10ekVMSmFHQTVNWTdTRERETGFiajNIYzFoRDVOY1c2dmpWbjdv?=
 =?utf-8?B?L2o4WDNzZTZZeE5Rdm9nQVlGaTBiS1ErTkFEbEtYVEdEM2lIdFpUUzFpdlZu?=
 =?utf-8?B?NmZxTWN5V2U4cEdHd1F2Mk01ZFJjL1RLeUhqMGxmcjc2bzE4aFFqL2F4Mjc3?=
 =?utf-8?B?blJLbHZYbWRmRTd4bUtlQTV2RzhodkdMWTBtWUFQZCtiQWtXNE1PZVpHVXp4?=
 =?utf-8?B?YUkvdmRmRXhKTUxZWnFGbk5NQnNEcXlTaTNzTzJNUGxvc3JHRUIwT0ROSEti?=
 =?utf-8?B?QkJWc2RTZzdIQzdDbXpaZTlHQ2Rjc29VWHlXRzY4ZGxxWTdjZUUrZUdHUUpG?=
 =?utf-8?B?U2lZNk9Fd0M1UytST2V5alhPOVBJWXl1YVo0clhWSFdsWDRTMjFtRXo2bzcv?=
 =?utf-8?B?ZUlVWUhCNTNrNVRoKzg0RDhzclZwTTJMa2Y4czlBZkJ6U0wxRy9kZUp0bnkw?=
 =?utf-8?B?QXdMRkRGOEJOWVFvaTdQZ09qMUtzRDBZdmg1QXhyNWppaHRUSW9LY2hZaHNC?=
 =?utf-8?B?UkJhc1haajJBZ1BhNEQzQmpPZ0FDM0hNUWxzd0c5Y1pOU2Z4RG9XTEw4WHFK?=
 =?utf-8?B?b0Rrem1Zd0ZxYldneWUwcUthTzFrZ0tYaGNVRWgyYXdsSks4dm9BbU5LeVhZ?=
 =?utf-8?B?MUFaL2ZBMXpFR3N0d0xxUXZtNW5rNVVEeUh3cStpTE9xb3BYOW13aEVDckJ0?=
 =?utf-8?B?bm1OM2kwdWwrL1hoZDF0MGJ1QkNxaEFRcEZZOWlGVlRSV1BBZU91b3VsbFRt?=
 =?utf-8?B?RHk2V2loMVAwN0xyZDM4NlNzVVBSdDBNMUVwLzhRSVl5eWZYbnJ4dWIxUTBp?=
 =?utf-8?B?Q0N2VTNWb2hPWmNrdGFKTlVEU3NkN21tRmd4TjExeVRQUnduNWN5QjVKVXAy?=
 =?utf-8?B?TXAzVXZ0WnUrYnlCaDZYUjR2cGlkOE5rTHhoN3JGYTQ0bk5CR0xVVHhQOUl5?=
 =?utf-8?B?c3hxSnJYbnE5MUkzcVYrdk4vMmdiTHBGS0IrRU5USitRTHJnakY5R0t1bzJY?=
 =?utf-8?B?MHpYbnJWY1l1RVVheFFSTktvWktwbzVGU1VSYlFqRC9jeStocnNwcjZmVXll?=
 =?utf-8?B?bmpWYjFmUEsrTVB5RHlJektKSnVENXZpSHRRWjRheHNSSXNncUU1K09JOUpj?=
 =?utf-8?B?T1NrTVdJWW91RjNMTy9WZFFVeXVXYVE4K0g2U2hpeG5obnNXZUZTNldMMzJ0?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75084b9-bb07-4ca2-9cfd-08db829e5424
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:07:53.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmsoZmRJzI4nThCG9pHDMLHYDetpkkPrn5gS4/UMh8QbjX23pVrsv7NnSu1aJMPlqmSLq5aiKGeTwdKLNLcZf3TnR0I56ERbB5/JiJ1yLeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

The structure partid is not suitable to represent the DECO MID register.

This patch replace partid by masterid which is more appropriate.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/regs.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 189e74c21f0c..0f87bd365582 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -459,12 +459,6 @@ struct masterid {
 	u32 liodn_ls;	/* LIODN for non-sequence and seq access */
 };
 
-/* Partition ID for DMA configuration */
-struct partid {
-	u32 rsvd1;
-	u32 pidr;	/* partition ID, DECO */
-};
-
 /* RNGB test mode (replicated twice in some configurations) */
 /* Padded out to 0x100 */
 struct rngtst {
@@ -590,7 +584,7 @@ struct caam_ctrl {
 	u32 deco_rsr;			/* DECORSR - Deco Request Source */
 	u32 rsvd11;
 	u32 deco_rq;			/* DECORR - DECO Request */
-	struct partid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
+	struct masterid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
 	u32 rsvd5[22];
 
 	/* DECO Availability/Reset Section			120-3ff */
-- 
2.25.1

