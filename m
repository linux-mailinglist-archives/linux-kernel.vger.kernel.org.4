Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19C5BD16A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiISPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiISPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:47:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2022.outbound.protection.outlook.com [40.92.99.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE852CC97
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP2bDb57YN6q44VW9NOUVqpJ5NNQgsGpYO3/5HZRVZBgmbEW2fr9L1FQisulxegsivvm5MxxmZGnIFxCqEXO16JBmxGAOTMR6FlfLUwL0+b2mbLRfdWwCO0htcdgoXS1Rxd+M2IfyNITvcSh5TMYJZMdI2n+iBycSp5QHyvV0L18QwTTV1lZ7p78qkj6vBIlLGLPHYKWD7P5PCknZf3LNr/DajLliDEX3uQXk8AU8TkRquCNkaaGFgGx9ACmO24UOGiigS/8ht+mnh/Gz5k3F6lngSEbxFvn2HrduVGHRgJGCiiOc30sAY7r/aWCj9SZrubWulXOjRIA0/IWvA+3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ncQPNNiiAjbgrpdQhYbAOrHXjHfD7LpbjgtuogfaOU=;
 b=gieiIc1QCkP/iE8u3WxBp+DpvxXRS/1Hr6hnyjRcZ1TaCP2QmoekD4lxNGKU0RbmtgAQfkb9uPd36OzlIZMxY5wGxhAWOnjtM1FW5BfNqP4fQSn57d1OkPmCK+p3vsJ5J5stk07yZlFL33iywg+VtOCGlzoZwz8b7RoxS54dfVyW+f2kUpffvPJeCpACAQMXfa3d/zWIcZJgf1ZpM40XqQDs8KwQXTJweoE4OfXb6CgjIANtxKfJTpZ01JfYXlYd61iYnMTjHLnRsDBKBoqr3R6tL/Rhk/opNCWIowgFMoIMFPH9lBL4RKbX+VkaKXloybpdvXvDyLZL4rDBxH1DyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ncQPNNiiAjbgrpdQhYbAOrHXjHfD7LpbjgtuogfaOU=;
 b=ogRFNUfjn7mfVlnmpxspQ0uB34/h8oo1T6f6OoFQnLUXLy6aVJS5IM9VXbf/NPl4AIQq2W4pHwUNlAhsiAXL9fhUpMBwC7sTSLOVAJ4IpfVcUMdxCrIIlx9Easm320m9F4TOj84VLaEkX0Z2cUtzZXlEGuozzbzkV2rUk9QNJ49Jyg4m67NviGSmQg7v8Wq3eOsAOPGmUX2vUFYvxqq0vQOLkJP6JzNsBs34tDgMSkEH7boRl5jjRT1+sCcBsYuQ8mluWQXsa8pZ7g9jB/1bZK+PG4vO/NrvvsMyoJoppJ8zoL1i4Okm0nazX1TUzPp06zvu+HTW3Ominj9i1EpqZA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB1870.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 15:47:52 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f093:ab8c:7e3:f312]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f093:ab8c:7e3:f312%4]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:47:52 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     akpm@linux-foundation.org, hch@lst.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] mm: mmap lock holding assertion on remap_pfn_range
Date:   Mon, 19 Sep 2022 23:47:32 +0800
Message-ID: <TYCP286MB23233CBD7126B624E1832699CA4D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NXX6UXNSG5WbV6HKZk4LfNsDlqFadj3e]
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20220919154732.28368-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB1870:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ccd2b6-7473-4405-b521-08da9a564fe1
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKyNVnLBfCRsxQDYmorGN6ADpJkc/DEZ+42glMHHPDaIaOlvZiYRB71qt7FnV6mJpJFKTHLzbpSD6by/Fe565jOLRGjYV/vW4xeUAkaAg4JJyGKyo+U8KjYpssj2HbgTYbgQlkK0Jz+weKKyc4tS7RqPaDB84TtuYXCd8U4lS4+hBlWibs1owz1yR9lO6pUPOgjQU5uvDa77zzWFCd32H2N20YdSF2awrp0YFwHCYYmUgKq1GwT6GHUuOQsfebyECydu2zGTsaV5ZawwwdnWpN9LjG+ATAoscbsyK2DyiwqZHp6NdPs+IKZTxjVPGUn+oj/nmpjcHwIQc1davbeFKqy1PoEvb84I5tP+fAtAGZ2y9yx8ATLhosCCkbDQ9/YdQr2Gnniqu9Yz+0phSG9LoKEwpjezdLsZxdHVzXmbK8rRCEd0caN3S4VfniFJIws3Bz8+1xsABrEYNHAkb9MbSqcSGpceYDfWKUtBO5x1bSxTSq72zWod4LBLtewG0QwWEqkKl4DdXYHCmDRduhuKndkDjKKJWD/fFF5PvUOzz49QHPbcCRY1lbVXg08NuWCQCY4pxDofnkEvQvjnWVwBFfbPogzGk1MIcKtHpcpHxwlIYDg6rCLI2T7ZPUpE8PRN1O3KaasZNziHFixzEWlnK2vC6XYVjMh8D9FOrYNDUWoGgOJNaWEystSTexkv/QXVHuaGH56w8uB/rpg2BuleolWngB+PojKkcJ4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3B1YcgvzAzk7aCJesNA2PnpRR62H6hZFPKNo0bDzTAPbT++78UWN1Xls4NuGclGFSxEKQXarjcBDPnTGPEOqE8765jn5mC3VwYlOXv5mlceqPCHAR3SQgKVea3F/aZR932hxVVRgVT2ikU1nAF5GfbjGNGtnwuFGJvMmdiRZyVBXPsve12T7aXW9I9GxkgfboF48p9apmrsV1TCgvpFLxExi5dmZaFdG1VJcw1Nhd+VId/MBGzssSTt9J6/9s0Zm6TJGnPxz8BvedRv2K5iN6EvVmnR6W43Kipomt2uueV4cvFxzWuKh3nOGXr044Go4P9j6zZCneFUAZQg288ADzWfmjSACLuE7ATcq243TomRXpxecL6prZHGYmWhTAJdSWfNKMS4hyOULBIW9ZtvrgVTwL9p7hhy+ZMmFo8G4ogpIxZcg1e+pVwgJlXpngNQ2bGK9uh9uJmEad8SFdb02vzWsivAnio3BPozvPdA8hXVKYw6G5T2Ke0PIv1Xp+vM6k05UAPQZI2gJPU6ZTOyA362KAeQP662b2bGMF26ZTbLq+7Ce9J/YJQ6AhsjoFxK2gBYjjG2KmCGOx6elSPhc/EBMcerJB72m2BRPPQYCj6P7fzMjeHxTv2J/jzw3O7yD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgn65YMC2rsZt38Wp5K0c0KhzymbnVrKoGEfYT1uKOzzVG4XstUHX+wVzaMc?=
 =?us-ascii?Q?opmx4zR9cuN9TVApiZbjQIL/8SxTX18u1U4qcl84WzINW1hhIyLS9JmHWig1?=
 =?us-ascii?Q?yaeCgjnq0UA/F/GTJFRc5SVtuIXNodxhIJPQPHivpxjF/5U+2FxiKB/q2CTJ?=
 =?us-ascii?Q?v/AelfKZfyZPJUsM9NAXF1iM7lL21/PL76kAHRz1NXJ5oMuyKLD5yCCdqnnw?=
 =?us-ascii?Q?gmsWcn68i6D5Mw43gtu95neiJCzP2pkSat6JpxqxXBEcO5Tw2NIZrKHDS5da?=
 =?us-ascii?Q?L0HKRPTXtof1U+elFexYPCVp4XES8kgrY4Be+iDoA27TtTZn5bwLO4xyY/gB?=
 =?us-ascii?Q?1758eqkKqbrSyCLzEavq69Fy24FUfK8iPSK4ifHa2NJTCFKAD4q3jvGls17K?=
 =?us-ascii?Q?AePm6tYwnKBE1EKy2RE85cgtqw5zaSIfVbT712Y+ZApn0ZLKW7NjMoXHZQCw?=
 =?us-ascii?Q?WG9arGKNeVMxFg4wGx0FK5rG2IY04WVFuOI4SbWkuVig/Xf6jPYB82iF125Y?=
 =?us-ascii?Q?ehOporYKDAtFKBIVgx6Bgzkl19Vyv2bFKFIBjEyZM7p/BT2NyTWDSaloip1v?=
 =?us-ascii?Q?3aBOWpDKopCk39l547xrhPYzv+7xfKASsxwsB1d44g/n7R7wnXsGYynt0SN5?=
 =?us-ascii?Q?CaV2Or+38Fyj+2hROUBcTrCvy7auaGOE9BwkAA2tcvl2UJLLGiI89MOLPCk2?=
 =?us-ascii?Q?gGBVOAlHSmWSX65oRBStC9ljPjRzWLLFkZmMiVtKelgH57Q8wXTl5CQxk6D/?=
 =?us-ascii?Q?XEzmdPwYHKDoO/Edq1mI3NRNKHC59wlbU5mR4HgPzJQU4eO54+r1ON3HBlia?=
 =?us-ascii?Q?g9ntKDOC4rI3tUW+86uTTCtjvbAxxmf1meNxjnN8derxJKvJibGPTvpZgWWO?=
 =?us-ascii?Q?tP7v4OXdMfSCLCQZxbKrEc9OzDhJqLnIMa/ThPg8PGmG2GVVf41bIucZBHks?=
 =?us-ascii?Q?BebfISeg+f4im1bSz6ICz7AYwcw20sjvk4C5i9c+xzHN65xyM3N1vZED3ICD?=
 =?us-ascii?Q?XiPEY6323TSRb2Rzu+wX8p3xQeuMWXd5aPySMVi9h7pKdqFbOeDPC60L0MeB?=
 =?us-ascii?Q?cSyQENRsQethvpkR5YyfL0xJIerjS27e6OXRs0FIhzbkxfmsuQAyr/O6WKms?=
 =?us-ascii?Q?seX9mEBampgqlhZpj4gV4aseyy7u/Fu6VnZn6F+y32uj19itoeQMBM4WoyJk?=
 =?us-ascii?Q?wkz/pQp/wp+MHjMoGuxEZqFJ6fyu7RWazlKMPiZ3DItRF2MfhsNQUcZtSF1R?=
 =?us-ascii?Q?70ABcouUcuVs401oN7d7G/1m8RdmTDyls8ndAEpJNA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ccd2b6-7473-4405-b521-08da9a564fe1
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:47:52.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remap_pfn_range() creates/modifies the mapping between user virtual
address and physical address, the caller of which must hold mmap
writer lock to achieve access consistency of mapping.

The callers fall into categories below:
1) fops->mmap() implemented by driver
For this case, mmap_lock has been taken externally, the rule holds true.

2) Some arch codes do mapping on their own(vdso e.g.), rather than via
fops->mmap().

3) Some driver codes do mapping into user address space, for some
reasons, the mapping is not implemented by fops->mmap().

For the last two cases, an explicit assertion must be made.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 118e5f023597..fd0ec1250974 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2551,6 +2551,11 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 {
 	int err;
 
+	if (!vma->vm_mm)
+		return -EINVAL;
+
+	mmap_assert_write_locked(vma->vm_mm);
+
 	err = track_pfn_remap(vma, &prot, pfn, addr, PAGE_ALIGN(size));
 	if (err)
 		return -EINVAL;
-- 
2.25.1

