Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858A62FBD1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiKRRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbiKRRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:40:50 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC8E24BDA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lageZJkc33pL7CXW4/ymN04sqSi7W8COah/UFdUglVlyYL11LMjjMER18ZrUWlRaRvZUow1lpK0b10bTyd3l9uMm5s81Cx/LuD2v7wyToWYsJFxOlzCAzokKi1yVYBOJNTN5lAv/HPeeBUSwFzUJISf9CVeEd1GgHgYBcwENtLDqEqt1L8W6xJvpLG8GwrJfcH4Az2WI2cUcQtZ/6N+29+2xGASSdV5b4SBeHjcQHZAnipCHqP9YQvAM0AHr0fUzGT/L20SfJNVN/i9s46o6MBHpU0SWy/Yjr/WEw9MBTTSymX9NryuMhwIEZF41B0f/u5iVa9DU6PzgNwtmnLZvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDwuWC9zt+tQ2uYJl+6EFV0UgX8G1S2XNuiwSk8RQig=;
 b=XJyu65sRrqTk5XQBRNCu6L5YsKoOyItg8qcylMuZNcLZDpdH3h9kjr8VUwevf6BVTw1H1VQ7lQpOFKjBnFP4W8fimQnucP5T7XZ3uQCCq5DOR8P89fMKJpvnrV7/371BYufCjTiiYDP/bsb16dq7fuwUH18Omn7oA/Yik3NH/UTCYDfodsWG11VV9RAxz/bxFSwYihkrpJeMrN2C3nJ/ct7Bgkw+6IH9lba9e+hICM3MJ+XfW4pEqrHHgteM0+yFyoUfKk8XBSkKRDX3xWQrsgohBNI56hXs7+EzVPzuUaVIT/nxbbUj6o5MdVx2jtXYKAOXncnidSVY3okgYw0K2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDwuWC9zt+tQ2uYJl+6EFV0UgX8G1S2XNuiwSk8RQig=;
 b=keB2yV2VZ/AOjVkEQM8taQ+3KS4KWmfBblsI7Cv8lhuCWsP+J0WlrWLSoWTg03NPHx/V9CP2U+ytIlNdS9mOjx6dQQp/f4PbuxCKCA17uBRWt4g2D4ndavBmnoAU5XBPl/kPxbgahLlq/3hC3jSTTUtSjYsCy5qExxqHXpvmy24+r6MN8n5NtGeODSzXZemRs+8VuhOXeapbyBpOgKlyGMP305qafvTrSnTKacJx8XCzZKrxbU0KnYnPQADMTGCHlt+k2OJUFqLgoREUpxwUoT/Rfyjd2sAhSfRpR+unD2UxrcS4K9xaXofoE4qw+qfpcv8sobsxH70079KRTjsh4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5749.apcprd06.prod.outlook.com (2603:1096:820:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 17:40:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%9]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 17:40:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix description about discard_granularity node
Date:   Sat, 19 Nov 2022 01:40:28 +0800
Message-Id: <20221118174028.63702-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: e3875e51-09f0-4c1a-55ca-08dac98c0453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2aGwfiny7eg6KBVZJQQdscewfMb2MCKCrAMqBxksmazgkBLdz9uk21DQsNresJgk0CECL89Abmtb8L7eRO+gCTGqHP1JMSFiNFXR3eP9W5RIIYMdpCxXi34L4hcqPhpjFg5MtqNYyDqTRGLb/asThbpmnITTTn7tLy6/6bA5oYO4IQA6nEbBJNC2QnFhQnkYvxJZwEawRpk+/1CRoLKOLGezFyyCC2lGozLLSAscaqtaj9HcFlsZsBILhkljte5HKiLkmKRuDxBqKVh8Zxy1AXFON3Fa5A6MbWHhJVGCTXI8SDMdvhXWYO3R25OP8k0uGKnUC7wJwNwODmfKWWrlQ6vbk30AnXj++JraUN+I0ntJ1Xq1v50ndgpWG5umfLVUiN0r3SjcZCg9msZ7VdAka4viTbXNHEi0L5786JQHyJB4iMBDJ1bLpokDQI+wjjxzBPxjuYK9OOTiWj7xU5PVp+1I4yu4X+P4czegALfGdPiZD00jV+PyDezWHBKW+YgqpvIaFhDDInDhrKnr995wFdqPqRNZgi2lTSJ45z4QpnQFUTlfWLQHFvfOmG6VVY65GSrStlSP0ED9WZ5ptSXih+BzbyClsYt/IiOE27nURC9e8xxcoqVlfgpUgnN6nSobjKhAtT0BFKysuU1qxT6/Rx0HGb52BfjD6Dl4omjqiKtGiqtT/81CkvJEY09IVWt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(1076003)(2616005)(186003)(83380400001)(38100700002)(38350700002)(4326008)(86362001)(41300700001)(19627235002)(26005)(6506007)(6512007)(6666004)(52116002)(2906002)(107886003)(5660300002)(66476007)(8676002)(4744005)(66946007)(66556008)(478600001)(316002)(6486002)(8936002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fa6T9jfkoaEvbiXwq4n6MBsb0E9IC85GEyt+vprtbGOSE/AFw1EyUSV8MPvj?=
 =?us-ascii?Q?ZoiyXAXPq3sSgsFluT+n8LGDbAW34EYOm+7xldq5BUbkZPBYGUXW8/cK2Sl4?=
 =?us-ascii?Q?J1odfbsca2XkHjYukVKiWGhj8dNFOHmJTo2dC2cP/EMPYXaINtoWC2umABse?=
 =?us-ascii?Q?Ec4MVvRRy9S8HuYaGL4JIiBClx0hzkEQTArPeFk+lh/u7qeJT33ilWyndZsP?=
 =?us-ascii?Q?9rb1Db1Huzxbik26AYn5trh0Y4nEjfZhc2vlU6MP5hSlFerIyNKKivvYiwAw?=
 =?us-ascii?Q?mbK5anvUe6H/r81SNVyA0ZDK028SuJl9CiPNhPKrR6mtou7geUNPwKDvWIZ6?=
 =?us-ascii?Q?V1xp5ZEoclh0/HZ40sKfjde6N1lRC9+p0yJIu9Nab16qG7IbQe1pPwp85wOv?=
 =?us-ascii?Q?gXEOH42MzU1yzCUAt750sd/7HvXc5WQppcBM71l72UIrMV9del/ZfTw4WYwn?=
 =?us-ascii?Q?UtRdsnQonIMYvungIGs9cQxl8H4evSVtsebVTniAqrQE52u1dK+Lu8NNZ+uP?=
 =?us-ascii?Q?yrhxmMWQbym9q7etDA7X6QCyFNJifh1oMHc7yjRju2spV6PRTxeXYbk1810c?=
 =?us-ascii?Q?Bk3e9yvZJIYcrR5miffdHnfqEpbmogh7cmeofyenkQDNzTHZq+cjI27CQzXg?=
 =?us-ascii?Q?6NqeAY+fnNdQlOwwUh2CVdc5qNyJf054UUSOCDttPIUI90Q4qFKWNEUo2308?=
 =?us-ascii?Q?Ff9eOWXOdIFWmfGfxV4hFflYLS9TtZamlZ6Tb3+2C4YNbZeePczjsrP0Wmxv?=
 =?us-ascii?Q?yTM43T7TqqApDzsKdeRuDQkVYHqKIhk87S5YITty+hnRAHOr7R/SysUxW6aj?=
 =?us-ascii?Q?sNcO+U8knf52z4v4mIR9HffgUWAucmXsniOrvZEodMvqQu2Ek3KKTz0hVCVr?=
 =?us-ascii?Q?J1Q3SmkimfyAUc/XKXz42oT9WG8ObXVAVSztJi4ucDIipO/UaADx0NwLS7aK?=
 =?us-ascii?Q?Px5m1rsFUz3hzq3Omb0awH6gV3OK+U/+Y0QEuWrNueU0U4etjf7Yl7D0Q3k6?=
 =?us-ascii?Q?I//LqeRuZJTZSXtxS+YFVXAdrG7vP3dirHIYXO9LC0l0YeFHSWCL1VgiPYcB?=
 =?us-ascii?Q?ymdbwTYWTPJH3SihoEqwKsHZxx0RKuKhCHToTdUT3D93h6evgtFcfqXs9hKX?=
 =?us-ascii?Q?9fdbE4K59b3YrPAz9jWCk5PJg+MJWkoyWgEWJZeU8i1y/3+bsVEqvbqFShVP?=
 =?us-ascii?Q?cr3lLSIz6/kVeQ14QwssUCyhDThUtHcEkoHYCCMS3/1UO3kIt4J34rol/Chs?=
 =?us-ascii?Q?+cL6Zc/Lm6XYEXrltcqiUMpSUnZAAJlx1Q2lveU9W8x+IgqaBcBxk6w15hxe?=
 =?us-ascii?Q?5Y+C8o7k3dHu7FLv+oGOo4eS1u/t8yCtqJpThhAhn9vWeZ3qgGTzVu8LacM2?=
 =?us-ascii?Q?fGxvMqwFNdF+EmDTY0DFMi3qs8HeC0BODdzEeNJ53MkihgdKhjRR2wlVxSHo?=
 =?us-ascii?Q?nkxznUQGl9EjnmKKKOIuzGQBtXck3cdC0yDfnQOvDLMgtZDjgzQxn7QcrJhi?=
 =?us-ascii?Q?9xeMBEnLCBWkw55rurb0MzBPGssMD3SVAXK4OFALS7TeFrQ5AOqoIEbSzZQz?=
 =?us-ascii?Q?HrWg5dFyS9t92Us/E8SjdZRE/ZXVQC2BaVs5/y4e?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3875e51-09f0-4c1a-55ca-08dac98c0453
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:40:43.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGJaJtKJ/pWo8COXMdYqVOhNhMV6e2XPXl/VMUE8oiTfdTAOo3f6qEHdWW9mmRMOQBQHTBT+dHFnvs1JuEZ2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's fix the inconsistency in the text description.
Default discard granularity is 16. For small devices,
default value is 1.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 24e7cb77f265..32404781e76f 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -138,7 +138,8 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Controls discard granularity of inner discard thread. Inner thread
 		will not issue discards with size that is smaller than granularity.
 		The unit size is one block(4KB), now only support configuring
-		in range of [1, 512]. Default value is 4(=16KB).
+		in range of [1, 512]. Default value is 16.
+		For small devices, default value is 1.
 
 What:		/sys/fs/f2fs/<disk>/umount_discard_timeout
 Date:		January 2019
-- 
2.25.1

