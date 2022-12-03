Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379C641469
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 06:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLCF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 00:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLCF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 00:59:41 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2017.outbound.protection.outlook.com [40.92.103.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E58E5A98;
        Fri,  2 Dec 2022 21:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpGXJCT0rLIUXqOx3//wnEW/1wST/gUJMpqFgw0v4z5aSOR6PyHhMs5haN60DDuNQYb32bpRPFaAb4g5Lvvsz4PO71G3DxyXsCv0iNj2cpgq+wB5Qm3SNIWeFgOdbQaCL+wT8Z/c59p5C/MVGJHvH8DSEoyWMgzVrlI7XhW798DA5Aj3CcCP2DNuwzIG4Rwu6sNSWl6wU8Wsq49I3KM4iWlqmkPamtvBE444iBUGFIqZqzZCKOge50Ov053rmJnmiLtmQZJE6QOtARx/xnHPD9PnxOeFKNdgAHirUDzyjKwI+qHfsTCaKh6GSjmiU3gUG24veWmWaXBozsdpEex6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giE3QBeBTmVPj62IlLH7PSer47BohKgUrLjg0rvWJOg=;
 b=iP2f2FRJEF4EbsEsVeDqFwiM5udpHqGaCIVRfLdjP4Vtu7g1g36e9pX/4B2E2q2lo86bmZnU3AXc523BiiPZHgY9fuyPl6Ybm0MAKcch8tPTd43F5yzrm6wTgOYDSeucX2xz+Hpp2lmh3VW4nwNt64aa8xThi8PmiTy/Jv5nfsT583y1QBap904KCFVQOxmhj2L9ukRQHnsDdNPmuNDa4xCZsAQMaw2nUfI8PMFIh1fEksUF7+kcZuBO9ecPwFYIo2Foo6RE/nZS5PJmOUPJfSj1XHGgHFlVWK0AGQB/WlOU9X9ndNR8awExBwjA8heOPergDSPRb2uuyBb/RIiO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giE3QBeBTmVPj62IlLH7PSer47BohKgUrLjg0rvWJOg=;
 b=Atq8w8KNLs1uUnG9VQl6BT11HnB0Rp9DstD5n9Tots0G/RFsvYVxatsczBi6q1nSXRfGrHsfxgu5rSOox926v42mPX90z4ha48IWT0judYM0YtabWtDgSXXZR5N87oeA0Ird2HluDCuZEL8igvwmgApNrOJjSscaxvJnxAhc6Ep+WBioYQnxSEio9SPu9B537JTxfMAxS+sj8cboeCu6g4tDPcVnp4i8LW8R4lGyzf4ZMgrg1R5c3qALApFKtzwhZht0htOak0OWVcXh04DEOXp3yx4iPSYoN1BZL/s8KS+GMXzGrYRxLAigh18g1Rvhn2rVRsVBlj/+feUGggZH6w==
Received: from MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::7)
 by PN3PR01MB7000.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sat, 3 Dec
 2022 05:59:35 +0000
Received: from MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6806:768a:a02f:3aef]) by MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6806:768a:a02f:3aef%7]) with mapi id 15.20.5880.010; Sat, 3 Dec 2022
 05:59:34 +0000
From:   Conghui Wang <conghui.wang@hotmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conghui Wang <conghui.wang@hotmail.com>
Subject: [PATCH] cpufreq: Remove CVS version control contents
Date:   Sat,  3 Dec 2022 13:59:12 +0800
Message-ID: <MAZPR01MB57230DDF21FC26147D0B0CAF8F169@MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [sYfUY2aFGFQaap3C8vJobwdNWpv5DfiS]
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:66::7)
X-Microsoft-Original-Message-ID: <20221203055912.5057-1-conghui.wang@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB5723:EE_|PN3PR01MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e4c52d-c9c2-4bd6-93b7-08dad4f38dc4
X-MS-Exchange-SLBlob-MailProps: RlF2DIMZ1qXVcfxocZznj9bxwo7Qz0X4M0RJRvTaWePFe7c/7JILwMB9fM8l1mUS59nSzvumNJRW5nv8Hmo6q6lgvfTHo8mKAXnMV0pOJs+17BWxmNof2WaMMImQ2pOHUZ78/EKa9rAvDrzHSUYNZtxoHXqnqFzto9urIbI6gPcHbuA53TSswImSTZrR88ShYNdAxOauwd9d8f2r4xyamrYLpatZrZlY8GfhvUrgMN256vY8KGnho6yMyucIp8BDtQAWsxkKZjdcf3ww0Cz7PkLg1pad3ffUg//njm8k5ZUh4X5M/5iqbyaR4y7TD/Nhf7/Fm70K1dXyXWLoR6SZNOTlJctv4UhpBmh6Uj0eox5ZP0r9b4cG57ghvrfrnH5ixrEO2564JU/Y2XabD0I6swv3hfw/E15kuuD3ZCpHMI/4fin4AJ2yaSK8JPFzwDanu7AcqO4I0fIV4FpIwtiKorKYeD373evqPF45DvORNkXNcY+6NchY1wdijsMwDVDdHe/yXBOw8bnWJ1d9mESFxPFQJQYaKeyQGHFRTJx6WTUghGycQmf1TF0IOCH7Ra+oa7n4LYC77XlyDxy9LSTOqXvL9Nim0S80lmROzN3RpfJ7rulslfjdUcYmbkvrO8JfW0TMFZorKCxO1J77MNMViYKIb4FZ1KCZznBZeiEho8+wPE4O2Su4n7BS4hLXRGjrrUQSVxFSIL3ah5LHAmyzs5UfgargQvzUu3KVqc1Wfh6jUf9eSRlQRygHYzmVdjLCctH0aGILyvKpNZCepNAt8mXutX8RXieaudh/BqIPOkNwYVWGnM6HJm0wVX/ump/P6jRzvrUozP0OYqvhtRixDu7FsY5JVPua
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywXepMXm95/na34BuKfgqg4P83fdQzw16HXjl/1SPtRkyR9TqSktO6gWliAZDpyKEh4mYFHBpmYrB1uY4QUIuyvigoIx9LMqYW8tWCH5LPh5UdtgWaUTHgNvh85HgaJy3F3SXYNeHM23uLmTjU7gdiSnMLvUc2zx1j92aYovgyNPuuFKk70QW/DvOjHQC+dqSE6+oX6A6BBUhN6Ab0+D4n52p7goVDNBIvlfZOijKZ8rnwGlzmzajW5lfXfsFjFC2C09OCHQxnQQhnJAzMymz0OSvhZDfrrCOrdFAOqfysMaHzGA5IBZHQFXgUl/WO7sBOsCgrp0B0x/EhPEO2JSuDEXBrqEWeC5vqWLIZuxIorP0lLYt6Ebnt2SRhFdYep1JzIU4UncY6cryW95uGKUQyuZQPW65rLE0yyvKxZMbhAsowFdEyFQHCbb7ALfc+WfuER3Gwbkby37Ui5pTpkkomuaQTLRJQflZ/TNaS8vbd107V36mEVENYM/aFd1gYgoJiusFRMvbWUCHzJ93u4uUJr0Ho5oxvBloqL6qRTNu4jb8sppO7mEcbbQkevYihC80KULeSF70xOAFW9nRkI0ayVaxrQa857I8tG0XT3/AC7dEqkbKRkaRdmDTY/C7gxHDAdZBtV71bgQEaarT9ccYw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzVXwPKQbxN3ay4U3swXywgxqIhND3/phRd1kO3dugp4JrZp3eIMbCwnL8Mo?=
 =?us-ascii?Q?5MwQABx84x+fbgH40iOq9lQ7CGjRefwKhk5iQp8FBDpv4OeMPgt5t0jpto72?=
 =?us-ascii?Q?PrmSabSO7jqftThF8i57/skBo0P3HxZLvzZ7MNaYS/LPhYU9wFDERLDsZrzu?=
 =?us-ascii?Q?qZ8VB7eX9cO1ILlsMM9zkMTZU9lQ9w0DaPqbZimbRFKV0DZfMofVCJTqZUb5?=
 =?us-ascii?Q?UEV51NtFKgGGOPThU9MELTFcafa4VzJjE3b4rXFWFjFgB3+rl2K2we+/xcwK?=
 =?us-ascii?Q?+A/+jbJ/S/olVUphY6+OpB4D52Xl04PJ0/X9yo6TZiIIWwzTbkvGorBjwvll?=
 =?us-ascii?Q?mQ/s+niBhuIVwMAyDHjdOMifqWq9fIO+7bh9CKxmsUYRrr9Duxs6L4juy8dD?=
 =?us-ascii?Q?VRPHpMq1H/zCQQcylffuPA700+hbPyV3N0rS4/wqrhiT6Iolw2GrsQ3t9Hhj?=
 =?us-ascii?Q?c9hb8xzylD4g9PADCRfamgYhjdM98oQmPcuPUhRkg+mkzwiUYJtm0z9/x45S?=
 =?us-ascii?Q?IiliyyXmlD2hmpjerk9sMZkOukmZnVmPolNCjp0bs3l61gamZvcOROzcH1nO?=
 =?us-ascii?Q?ToaV5FNaOwDEb2US5PGrSiuFWlDnSt1Odffy7g45GzAebkUc+kbGgYh8Kiv/?=
 =?us-ascii?Q?jtGkNVrSGCHvPXcV8glk4XW2sR9UG4mplY6mOKAmaNGO2mQnsfvjdeVIVWlc?=
 =?us-ascii?Q?e8/rotzLQbeQFHc6ycTwJOF6cRwZLtjBF4PRP30eg0VQl6UWMJgY+hXIDTUf?=
 =?us-ascii?Q?L/uAYJ30On39M+2S41VSpFzOB0I+nerRiJ0OQofNzDQ8gFh/ck8nZok/XuJV?=
 =?us-ascii?Q?D+eKYSvGRz3xpOoB6PMzFxbvXYibJreGLpHO2SFBGW5KMn5qnFpQkHOKLimh?=
 =?us-ascii?Q?uDdMQmJOVGi/5ydS5vlfX0IlklFUca/DrSuV2N5Pg89zMWgP8Xr0tYWB1HZD?=
 =?us-ascii?Q?UUMTf8Q7ec3I4hDpjCoJ/tsyhr0jV586sGY9qEQ79tksH27cYTPJN4KlXBiO?=
 =?us-ascii?Q?Bo0ZSIP3x+w/hbZHx1bAT7eCWa20/fR6c1Og30jiHXhGE3C4hqtORypcri3J?=
 =?us-ascii?Q?QxFjM66KJxU1R6OQUeQh+usWcoiuinPMtbB2Qe9jKgVtMbjR5erRo05T4cH8?=
 =?us-ascii?Q?OzZvHG0TG8OKln6zsmJ4GziHLbAqGeZZKKai3Pxg1mDjeCMp+cT36nJuLq4g?=
 =?us-ascii?Q?a6OJ2Pfggg+o05uQC02eHwUxwMOYOIKaleEyonwfpUxwZsBSNhGjH2S99Yi6?=
 =?us-ascii?Q?sWPzausNSzEzz1FaVSS7WtMM40ITG8nqJV0giOsUcQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e4c52d-c9c2-4bd6-93b7-08dad4f38dc4
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 05:59:34.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since linux moved to git, CVS contents are no longer used.

Signed-off-by: Conghui Wang <conghui.wang@hotmail.com>
---
 Documentation/cpu-freq/index.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index aba7831ab1cb..546c9161d906 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -20,18 +20,15 @@ Author: Dominik Brodowski  <linux@brodo.de>
 
 Mailing List
 ------------
-There is a CPU frequency changing CVS commit and general list where
-you can report bugs, problems or submit patches. To post a message,
-send an email to linux-pm@vger.kernel.org.
+There is a CPU frequency general list where you can report bugs, 
+problems or submit patches. To post a message, send an email to 
+linux-pm@vger.kernel.org.
 
 Links
 -----
 the FTP archives:
 * ftp://ftp.linux.org.uk/pub/linux/cpufreq/
 
-how to access the CVS repository:
-* http://cvs.arm.linux.org.uk/
-
 the CPUFreq Mailing list:
 * http://vger.kernel.org/vger-lists.html#linux-pm
 
-- 
2.25.1

