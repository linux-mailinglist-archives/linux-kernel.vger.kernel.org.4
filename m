Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334A674A93A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGGDHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 23:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGDG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:06:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA7919BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 20:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGEoQSERT/UxhrEMkRKPe/wdhJ1gT+xBs7wI3Zz6Vqe2h0gXGWSKEE1RGHGcRHEJum04xqOq79ZrItNxYM0WX50o4CZ2xb4LnD7ZcZr3vdPoscTOgDsclfUjvxAU3S0LV8GZdifAIskkEAYzFZ8IhpsUzBdHOepGIB1wWKB0gweAws/PBkB6xnwOmGVnQ/pfcBsVS5318HXuBzSo3oFf6UdpgrtSfOxN8gnkxIGUsb8bd4lHMSQ8OZeCLmai93+iuBwOTzvB0gegEyfWWHAB29eRGoCzqDg6G1EFNrjL+KYhGozhqxGAzBinAUlbw0wejy2VBstWlQt+L9Ij6+NiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7vyLiO02ta4Jaoxq9DIIiiBPL+EAK8xYJEVy/2fOGU=;
 b=BXXtWM1cxqnuvy25l/nTlsHnKRhNN2bwWNRFQ5b76e9t25YFfGvetaOyXDkwUBI4fTxilhuVE07QodJGDqu0s+D/Q3ZOPo0fUnkbqYb2GP3add7EhA1M18tI89dROSXW8jzkAigGBBzmrMXEM+opMq84hzfNxHLdTuADZOW4OGF+pxUjhFnwUFcB9x1msq/+JUkDaVCr7ZO4SrmwZx0emdtgnetX/DyPrWeqYnsu3ELLCDt6t+5P8PnY3aVV7tnw7V2ZwfFKVew1uh2y+DI6kF1PdKMcIRj09H+E5jyPht6vaeUkJjGdZ4zmAVScV+n4M7LjNUHauC42Cy/uWkmfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7vyLiO02ta4Jaoxq9DIIiiBPL+EAK8xYJEVy/2fOGU=;
 b=fJZWxsubb7qM3dYxtVM1swFHVX+kXX0whXlthHogAELdfPvSoIE+eatnY1pK25SJNrMzA+s5Q09cglYpm7mHgDth5P1c1LV4WpoV44pAHr6INwnZ0DH5VRrGGP6O5saBi79S4epmjbaMLgB+PZC92D89+g664yucLRpLwTPiAfcarh4HI61k+hWxZi+mGfCe3FvonJ9IOFf1R5ga3N3D5wQgf3TN/0iLFjBci7Co8C+Ey/MElcWbnZaTqcCKpk368iFcBwZCdB+kdJLmraHrqpEu2C5+KEhnJVnd05ZMkLRKRDhIN3CIyX/c7petpwLa0KkfHY6qLkg9VkIH9jfVbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by TYZPR06MB4093.apcprd06.prod.outlook.com (2603:1096:400:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 03:06:52 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 03:06:52 +0000
From:   Zehao Zhang <zhangzehao@vivo.com>
To:     thomas.lendacky@amd.com, bp@alien8.de, bp@suse.de,
        dionnaglaze@google.com, rafaelmendsr@gmail.com, pgonda@google.com,
        crobinso@redhat.com
Cc:     linux-kernel@vger.kernel.org, Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH] virt/coco/sev-guest: Convert to use time_after macro
Date:   Fri,  7 Jul 2023 11:06:35 +0800
Message-Id: <20230707030635.67881-1-zhangzehao@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To TY0PR06MB5706.apcprd06.prod.outlook.com
 (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|TYZPR06MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8021056e-9361-44bb-ec6a-08db7e973661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzLNN+dBjTEC5a0HASafd3SRJ9P+1JpStqFPu9EQHQwCxReGP9f+n35rfZ4fYmqqR7tIS3ki66p3mF00La/AFrXt0ITB/Sso4JfxiW0xUhBaquPzFfkvtSkgsORCTJbDIGDutXgdKrA2kYIx2q/ywmy8yYCph1vZPg+htPlb5cGMuJVopiiwElMlLtoe0GTymC+xvWHfqODXeZG+AcFaRD4EhyXhQAhrQKGMb+xwDXxpXZCsZdUfxQ9lr1t30CmXIC4tI20pw6rETHFi/n9tw+D/N+E9cQoTBHNSEOPXRSOJhDukSCZ8DBw4tqkcof+TghteB1rKJSwgI5pQgx2zke5Klodm7LjJTfNGCNK94A13TYaYYrpO/uC7RV0jW/ae6hFlA9DSBNzgdfMEwGqeHMaW2XoNEdP5x+Sd3FDl7xpoly08azHYB7qAR3HwEAM3tJWLqsVU2L34fMssCz/jRolDN79aDsGJ/Y0L7v1SO2LMN+YscBStUXTjE1LzvqS9J+AitjOtUnTssANSRMFIQzI/ONHyc0gFkj7c3yYYRT8fb0mCfrS1zUf3bD0AS0uuJBnnK9+Gl0s2CfdqwM0AUXS/sep6nMkJwnkyLJeASCZ62qK20haRQVMNNk/9VJTL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(2906002)(36756003)(86362001)(66899021)(186003)(83380400001)(38100700002)(26005)(6506007)(1076003)(107886003)(4326008)(52116002)(6486002)(38350700002)(6512007)(66946007)(66556008)(2616005)(41300700001)(478600001)(6666004)(316002)(66476007)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kow2Lql2qCcY0O8njMS+Dt44KV+DDGO+ROsAX+D6SlafzJAzgzF8P9436qyI?=
 =?us-ascii?Q?TAyR6mgvrW2y96M+1AZIBD9hYAaGedQUT/6acPvw0y/N93QoWCiaoowUbRBQ?=
 =?us-ascii?Q?Dtfx6F840ymUSkcaqRxeVxSVm4sZxA+adXLj5EPmCxD4mtld8HxY//KSeXGn?=
 =?us-ascii?Q?0x2gh50O+NiFyPAxQuG9FkJ4Fqu8v+e6I8iiEOtwtbn0KzLazzIEb+E5MKSA?=
 =?us-ascii?Q?9CLPZe6sQ97FkY02/RDiOXZ2iJ1qkcVxklvqm/rW8nIRwsICcVmDzDRWpkoy?=
 =?us-ascii?Q?i1p1iDDGX1RSkhTdq+XjRK9BtRZjvJbg6woIW4BqWMOccayOLBKn2nihAPvL?=
 =?us-ascii?Q?Kz7ubrXzBxOUPlpF2N+0A9jIixeGxsh0k0d9O5I6XHEAJy8UpS9B0dezvSpL?=
 =?us-ascii?Q?bRQQbntiuJzTKC8SBweBBhmrmmwLeq4bV0ZEL1s7L/RjNP8dBwEiu4a63WZo?=
 =?us-ascii?Q?H9cEC4ilDhO57XZEuoLwyZsBEUJ0He3mFwUI2UPHf+fs+tRmtVGL1PCcqB92?=
 =?us-ascii?Q?lu9g4uEefW5KRKatVAKu/xetwDaHuYsCOvCCScZRq2JwrQX0+gmVd83s889f?=
 =?us-ascii?Q?8qN89yS4R9i2wBAoXRe2DfMcCnPWptP5f2M+m8Q1bMOEB9VXnnQXTpY/J5hS?=
 =?us-ascii?Q?yNVzbyd0QMSriFiLobIKeK8aVkn6p+jY24jJqMHobBrbngmfDwztNhpGvx7W?=
 =?us-ascii?Q?0hty3lGkzOJMzDCQagp8Y5YkXigj1Vl7mJBmKgwmHY1Irr0VscPn72GM1ls4?=
 =?us-ascii?Q?+53uerxsjTi1jkiYoaVpaQK4+4IRq4bbWzWmcN4uoapf6ksViCLa2t80dAy3?=
 =?us-ascii?Q?oYjuReFfUFNgfTi3+t7yNu6SQEzj9d+AXEHgMvZezz0J1Uif2LUp6W5R41XB?=
 =?us-ascii?Q?RyC9NGp0jenRHdDtbc5LX5kZcXFLnQbNwk62F3g46Ox6LYBXrS3g4GKTxJXd?=
 =?us-ascii?Q?QsqMysmdKKohvp+tMRJ5F8MiJcX5GuzE+RId0VimJYBsgNK3rzOs6MyGZgFk?=
 =?us-ascii?Q?8WtQsc2alIQa8XUst5P8B7sGpDpdcCzC10sntLaz2IOE3QkVnBneqkpgnmi8?=
 =?us-ascii?Q?vqdbE1hL4mk/FG8IK5/TnO9t2DwFNolA8qlmrQSCqVRi82dmXQz43/cwxAXs?=
 =?us-ascii?Q?bB8OdRuw95/K8Vj13ieRUJR7V00xVxMV6AlLQPXhYYjfyi2pmcUUOMlkelPQ?=
 =?us-ascii?Q?HvJDMyp4PYyKwdTfYPW4iKT8/XwYbZ/2vrpv56egk9KbCQiW2oNysVdtZaFL?=
 =?us-ascii?Q?qeJ/TF7eCB2TMuh6ZJBqXek6zn0pgEse4UkLHSiqUh/AnSF2U+LDDXbr9xIV?=
 =?us-ascii?Q?9J98fm1laX6OxiEiKtbla2iyLBzlKehAv5sq6qNfJ8mwTmKQ/IbgCxzgOHU0?=
 =?us-ascii?Q?ClYFpTcGvdoiaDV07g1B043ITJrgCuXrNMD+lZI+bTZPqZwAcSmjOFB4d48P?=
 =?us-ascii?Q?NDu90OOeVAlGE3EHL2EVx0gJq5o8ppkVry6kFFQX1ZAM/3liy37v53/Rus7L?=
 =?us-ascii?Q?oNEDXWiB8fUecHVZa43AJLuvRij96p3xvNMjWrBCLfWrwvbCAgkCS65yr4Re?=
 =?us-ascii?Q?9UYt2cT1nG8IGdsXUIC+NofFKlYsvEk33RWUIvAK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8021056e-9361-44bb-ec6a-08db7e973661
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 03:06:52.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pll/TW7S1Kyew7hu93w6DQTtLDszfC5fSf85kZ1jLOJFNNfFGn23Q+xzvBRzZFGavfvHHog+kxiZOQkzC2kVCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use time_after macro instead of opening it for readability.

time_after(a,b) returns true if the time a is after time b.

The macro deals with the time wrapper correctly. If the timer wrap
changes in future, there will be no need to alter the driver code.

Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 97dbe715e96a..f17302117c18 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -21,6 +21,7 @@
 #include <linux/psp-sev.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
+#include <linux/jiffies.h>
 
 #include <asm/svm.h>
 #include <asm/sev.h>
@@ -383,7 +384,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * message sequence number on a different message.
 	 */
 	case -EAGAIN:
-		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
+		if (time_after(jiffies, req_start + SNP_REQ_MAX_RETRY_DURATION)) {
 			rc = -ETIMEDOUT;
 			break;
 		}
-- 
2.35.3

