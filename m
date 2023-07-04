Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64DA746C7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGDI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjGDI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:57:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5AD136;
        Tue,  4 Jul 2023 01:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eawNPMEKD9mlVDmgJ1yT4CO/h8PP6E04cgAV9/5QUNhNRSDv3w3GFDC/uUqBFJQPsheG7q7LWoP0BWiMo1FXf+ZbZSBP3PqdemsrufUtj9WQ9qoPT49Ci+53c4xsNZUay+vnQtmjHfl0hWypRV5XeQzQYEuiv6cGpKJcW+Q7HVe3X3wFLgQGEkmuou9CpEwp+J+AQdyY0bDnEDmxkOpNjq7QzGEvp2bGB3kTZ8ZfGj4wVfwaPwEqQY7IG2cidYC28VHQvxUXldut6pa8b4EMLeBc4ac6Ol1Nrg2jhcZ50sDe2wi0ahGMfj5ZAIuhNKtnMwSm3eCqUM4ftH0kI3g3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HkL07nbHLh/ZLx5GiSjvSPMLEM3aqX9HEPbzlbr/Eo=;
 b=oNO9EMVf/rR93cLufklkWVb+5+nOXt3l3UdONHkn9r1jwLyTWaqXater1DSNOXXdqgR4EwCpePH2ObSXrMu27viIUHWPpeSQ9X7fZLpmPdD1cVvtM15H1l/G4zfCKXpTnzYEp/zrT8R8SChfcmDSy687MTOf5z24irh/15xo7ffKjGQILeQ+PepKGnkyJvPtyCgekC9svX2UL38YRyZc+yZAwgC9lHJiO+pvMERIDMdYvFDVtMuuQ+hJFvG4dQAgi1EdtSXsV/KOn4+e26runDR0gDy0er0P8nWdJj7rEjuNHBVgfGdR8Gf1JeZvGGJXvLKqqYnwT5KUrTv8557I2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HkL07nbHLh/ZLx5GiSjvSPMLEM3aqX9HEPbzlbr/Eo=;
 b=lJDaj1aq7IvpATnWhhu7KuyfA81qEPPmcu7usCBfy/QISkcNsJgpHYdF+HMXY6YkD2jDpiMt9bWiW/MfxVOUfRR4HnmpgqZplmEPBdGFGND3l8ZBASxbUj4ZWRLLZ9CeWduEYi9UyAiWVBx2AeHuFs4Pzgvbv4eHfhTjUj9Wt+4Kqc9yVBVi0BgFohcqdSRzFmVuJ6hhqgwFTDd0MhgEJGeSHEIbLPE+Lhh2rgCLVuRbIrf7TQXyRKPFxE5cMv+URuZy7OAEIgFgAoih4+MgA7MtCFC8bKv6LQLeJeJTDUWxZ1GxM8DOHS/UWsD3NpazYLLk0V5M2gzTdQ9wgJXltw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TY0PR06MB5659.apcprd06.prod.outlook.com (2603:1096:400:275::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:57:04 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:57:04 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Terrell <terrelln@fb.com>,
        apparmor@lists.ubuntu.com (moderated list:APPARMOR SECURITY MODULE),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] security: remove duplicate logical judgments in return
Date:   Tue,  4 Jul 2023 16:56:52 +0800
Message-Id: <20230704085653.6443-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0232.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::28) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TY0PR06MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f29be2-58d9-4417-89f4-08db7c6ca33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UENz/a+qqtGbTEc0Sb00NJbDl+/CEO8Wy4UIjgqvWmnfuU6oaUR7y61/u7r7rFkS+xQAJq4u2+WSg3J5FNmZvt4pTssjI2WBHKz6yb9uC4hfe/4B/TKzIIXllAfCg05CPNCGO1GBqexrx7LWAzwVF7wqL7w84tdGqCjC/HqxbKzVEz2yBvPKKwVi5ZIgAgglGjwArIdPKVehM2TaArtC75ngwY+TyW+UM5iFQBWcG8d+83GwH3E0somKkhNwdkWz8wJVNXbneSHPRhzVWhpopVZY5qUCN+F9c4FqKIv3JAjBVg+BHswPCQIekmzbMORsvkkc6lMAt/9PnF1L1G098Mbb59NhEJfXV6IQCxtfxiN+U1M+2lp+05gtSdmqKUPnd1eijknMgUkMEhvrLo353c21il1PBKe2Am2Ryv1iSiuy1eaFdDhts6UABDyUJGBpGUDXahMkGIQHXnGyMieBQf3MFkxVRIYWBkC0Igngn1USu4jRSfF68MAq/ooHltrUG4WpMasfaP45RBdjyFCPRK1zVI8qXZnFvdQMDGlZRv7+7RjsiAkOSKCG68eZgzGYGGjkiBZ0YJbPnm0RVa+ys8sHl0yDVO82RImx58As69XEA1W09CDGjVRXo0OGkuZ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(4744005)(2906002)(41300700001)(8936002)(8676002)(15650500001)(36756003)(5660300002)(86362001)(186003)(2616005)(478600001)(107886003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(52116002)(316002)(66556008)(4326008)(66946007)(38100700002)(38350700002)(66476007)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPw3P8W5b0cEfX5JGVOyhklwi2JZyWZf2y2vRQCPTOAlZJzkwCepPlN7bCz8?=
 =?us-ascii?Q?SfHM6TbHn/TVvencelG3+Dsk+LHr3UYa27ODaNIyODhZu26FYPZ8mm5KFHKZ?=
 =?us-ascii?Q?bVPDT0Y9+Wr5b8FwhRbMOdBB8VBquTopj6C6guPL5jwzyp5gtxvV6kSqM/RW?=
 =?us-ascii?Q?czEjed0AMFBVJuw416jSP5yjqKAE+uCOj8r0+xzNGGtzzmv8gKxJAFyp3KJt?=
 =?us-ascii?Q?c+L6CbEmaJ6ppGwq1xpgzvedUm0BtQbQEqtv+nCMaTmLWVuZrubZeKDZfWDm?=
 =?us-ascii?Q?MUktuPQ4qk8lbHHWs0zzrxebyJhNQgXJyhntxtyCNGjuTi9G4M5BdIsG8MCI?=
 =?us-ascii?Q?ghtsO2ThDEejiVnhnZyZF47C4bvEaHusCmg0TrxLFlwrzKZf5PwVpHSQ3nzM?=
 =?us-ascii?Q?iVFOO7hfyqxmwE4xyLGq0o3AG5Xv454CcXDJjouU6z36hYBlnleH+BTjveAc?=
 =?us-ascii?Q?y+DbbyeoapNwEYrx/rYmM7gzd/hheeKug6b+sGFFyGDIWi5irpeLZp6QT7Mr?=
 =?us-ascii?Q?+e4mFbqxNHEfzilu1Z0K5YGDXB5n6l5HvKDPuEY5l5GF6K2UPpiwh4S4JSEI?=
 =?us-ascii?Q?pQZ+OGmwP2xsDGIogsz6WeZvQxAbDaDwD+apsvhQuVN6NdWMEcidT9y4vNR6?=
 =?us-ascii?Q?hfFyxJ4PAn60b7yQHiytGqU5IjV9ZnOZ7yEyhI59dgfqkfZmg3RFKXWFQaEq?=
 =?us-ascii?Q?H6hXyHhvA2kC2RDRFwJVnk3zHzgHwpWOJ+XFE0U5SR9/syav3VmRp3zQe+5o?=
 =?us-ascii?Q?H0Ul+El92Ee2b64hOboS4e4SM1fWyYNZKpi4LkWeVpupGgt4Iup4h9wgKOsr?=
 =?us-ascii?Q?ZF0SiqVvUXfHBFDwVMqEOpr+iyBGgOjYOq/4UfWJZyOvnmGdm3vA50RPBgzX?=
 =?us-ascii?Q?/+3xe+w3AnREZooFyO6evcpZJM0Du56gyq1NZMF1R4fGLvmGnhfDW2LR/fiG?=
 =?us-ascii?Q?PxpZnnuX1h55qZnorhWARMP931YIJByrRmND2VrINTCIyVeHnnZOGcusXZrD?=
 =?us-ascii?Q?4fyxTfwxfcREBWZ1VuZSCNq9UX89hgLke1X+YhgyJ0vxRyNUMLDl/Xe51DDY?=
 =?us-ascii?Q?QHpDz/FaX8xNSyVrhQzyhZq3A7yqtI1bcFbyKeW00Ww+54WUpxFlm1QNC62B?=
 =?us-ascii?Q?VCwfRzYFEsSPMqAjj/NTILRMuAj0d+KDIlGQxCb6Gnp1DCF4891fKByx+vzv?=
 =?us-ascii?Q?+2l/TOF33vQFl3rk3bLCLWnNp4sPdy8VSxNUBSYMEgZ6sE1gGs1eMlqSmhD1?=
 =?us-ascii?Q?I4I1jVZeXUEsuVP+BScWs4M6HkFEteSJ1y5pbb9vH6dQpGm2NnpMZY5C/xz7?=
 =?us-ascii?Q?MWCh7+++9nudqwCIruulX0+EjiLmYUk8uW4kUJJvxW25JKKTeYq92zxL7lOA?=
 =?us-ascii?Q?vGC+XiH737EInscV+XLAA7x66EDGICZvVKvnQO6pMEpWnY+cVCpVBJlmoHkP?=
 =?us-ascii?Q?HVDPqjB2SowGis8tTL2aNHweVo18/09me8aeKKd7s5Q1DR6aWQAPTsrlgvZg?=
 =?us-ascii?Q?9Xp4+Oo8v4nLcyzpkd7OI30D+VS1yejKBFCqkGCZkC/XhZy0nWjo1/EbRzTd?=
 =?us-ascii?Q?kGzWJozP6KqYXxkc6fEOSQL0yKSqTDxe2s/+X2JN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f29be2-58d9-4417-89f4-08db7c6ca33e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:57:04.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gy7Yzvx3acGXjV+7qcWAYyCof9JUM2x371XbejwM92+fR+u8BGpPP4rF7KZRUpfB4ZW7TwUNcb3SwGC4wW/cPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: delate duplicate logical judgments:
aa_unpack_u32(e, &perm->allow, NULL);
Please check this. Thank you!

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 694fb7a09..2069adf0a 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -646,7 +646,6 @@ static bool unpack_perm(struct aa_ext *e, u32 version, struct aa_perms *perm)
 		return false;
 
 	return	aa_unpack_u32(e, &perm->allow, NULL) &&
-		aa_unpack_u32(e, &perm->allow, NULL) &&
 		aa_unpack_u32(e, &perm->deny, NULL) &&
 		aa_unpack_u32(e, &perm->subtree, NULL) &&
 		aa_unpack_u32(e, &perm->cond, NULL) &&
-- 
2.39.0

