Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0F6BBBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjCOSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjCOSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:15:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0ED7604E;
        Wed, 15 Mar 2023 11:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZo4vsR6dwTOXUSzL8+2gLe8S6ke5pO9vSQXss+PNR4PfseEzxmzt5z1cAUGjoa9s0bSugmQ+bFZcfM0bj8+ofRriPm87UWI9D2SyYBFEFtONxbutBGa6PA5fljf1YFOm0Kt0pD5lsj0T1xRmSTSWmC0zNsAj7aVvsKqOwDblHMgcMRyQs43/alSbExMcRxnSBUDRkg71PbAF9d0+6xIMpvg7XCAIzZvBOUMNorzuTdTeWkjA6ozGTtxl/v/bVNIiD5TVjVLd1uMBM286S0tnfGlLbOMKHUlM+NII2b8yO6SDAMW+/jeth1Z/T1WOQxsUPkgEJmMO4CV62145rDJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hGwN3VG0wQ7UEem3R3R3NGFVJPXwAJmw2rVSwRFJZ0=;
 b=HeyOdH9eHAiyJoTsk5306mL31zyme1c9FzA1IcX7JLYExM7NXeOqKPWi8ZjytODrGbVr6aTeCtJ1T/fXQsr1QcWq9xChp1TjXHrUF5zbYbqHycZ3c6DJ2NROh/zu5+0mMX42NXr5oCiOH+rfvil0aFK3V8APuqMSEB2duaTzIbNxXL1p4VYErJ7dqRY6/DuyljDySdOfeqAT+DYSms5dh4se7epjoNijK9pN31BKYSqx2/OjmKZ2ycGWZo4tdv93MGb8rzv+Dwsy89q7u0zgS+8T7aEG2JAy7Jfbq+zVqO8WHMsA++WIi4ArEl8bq8prtbPqfZzUzZb3pny1+Djdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hGwN3VG0wQ7UEem3R3R3NGFVJPXwAJmw2rVSwRFJZ0=;
 b=C/+MCM0z9n8z4Ts7rPujHexH1avkvf6EILFc0kZ8GGalsTTdpOF8UPyQpuqHrC7vaoCU+tqBk0oCcxmUJTiIKJBucV0G/LDmFmBHZr7soQ9oaNgdivBf02iRAWJF+gyMu5LauR3pnLk1pXzBJJW3Qa1Wi/IDFt71lkxQbCDRr94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BN7PR01MB3651.prod.exchangelabs.com (2603:10b6:406:84::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Wed, 15 Mar 2023 18:14:57 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::6f92:8006:1d6d:4cec]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::6f92:8006:1d6d:4cec%5]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 18:14:57 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] xhci: also avoid the XHCI_ZERO_64B_REGS quirk with a passthrough iommu
Date:   Wed, 15 Mar 2023 11:14:40 -0700
Message-Id: <20230315181440.1478259-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:610:38::18) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BN7PR01MB3651:EE_
X-MS-Office365-Filtering-Correlation-Id: 518d01d9-bcdc-4e05-2c67-08db25812e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3Njp92cCYo3d7GuYFeLU38sz+uzJB7rzPQ9I4PM+bJqWOq/xLXWUZbSt7N7R19W54N9cu7rWzOvW0jKkxipunCFRdfnPi/1cZDKp4k4YQrQbAI9TUcR6dfID0y9py/BqtE/c/3bKIKIOkXHeh26fz2v/qNdIeZuuH+I4MvmoKzEwp+6CFnWrIqiDRvyhS/YfzYfWMp+b2y2qi3h2dGz6EVc0uabyJTZsyVQPsUAzHkw+accPZrwAAjB2uEU30sDp3w8wgY0DdL1ccCp91LfNvIsWRv3L6WQ3+0uJ69RUl6ZhzVdACpq+edIfneCwl8+sGgdbpz4x7kHYlba3pGo1IOjgg+r1+rMR89zmjE+fPaQXWmy+jL924pf16Q7nMvQdyEd9XtG0fYULLKzRbeOTm+KITuhkQPOIL9XrcPAy6MefqPvgYKgdxzTpYmOot6S/Uqs9OqJ+k9Wn7PyA6vUX+NZwM48JKPpw0Ci9PLa8DL+wlCT5EVsxmTIVq2BmEvUq/GTYCy1lX29SSfVGkVUje6RvvhwilWSIsnUQquv7CaA3TnuOtxGrgdebtGxdsEcLjM1xcjYjujnqPt6rI00o+tFFGKP7qU2PkHDg76kLPU+m9U9wyPKsYXtYD60M7LZMOkAJJ9w8JXbvaOUqTRV4HVqm1QxmbdwAzBFVv8MyLbaucjgWMrSGirOsc8RCwv2K1GR61DL7BAgInnJWVokGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(451199018)(8936002)(5660300002)(2906002)(38350700002)(86362001)(38100700002)(52116002)(66556008)(66476007)(6916009)(6666004)(6486002)(41300700001)(8676002)(66946007)(478600001)(4326008)(83380400001)(1076003)(316002)(186003)(54906003)(6512007)(6506007)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9eYbVPs3SKdwwnPMPBJ2eK4Yhb9kWkj30PmbXlpEVIckQ76KEkz7Ieq8sMV1?=
 =?us-ascii?Q?0e0/hszJM+Rw1cqu7v6gyAassSH4twowryTE1KUtltkOqxnmuhLcTrqyvN1x?=
 =?us-ascii?Q?2RDDlN2NBXWUEp/t5lqWidbZDcERFIa9scfOgBtLAb5hNM8g8zrsc2hyumr+?=
 =?us-ascii?Q?BIQHrLIkF936JnQox15hxVWyFQyRbsYGnmDoM2Z1KlanDR5v/MKmNP82LMbs?=
 =?us-ascii?Q?pdyfb3lLrgPYixw6iGf13nsq5A5droZCE59vc7olQRT9vS9E7T0E+YMC8iWO?=
 =?us-ascii?Q?petzQs9M0kRwBdziHVS0y5Iyc4Zsi2OW14o+QL6/iRAZgjPNpOjrJWyzgKLx?=
 =?us-ascii?Q?636mI79xfMq8NiDY+cqACseCHwh7kDZ/wIwo+X3hnmkOpm20I1LVam60ylNu?=
 =?us-ascii?Q?2f+2wdq6KiRSOWQfmxjoc0vFLHnAhx/rkcaP2PHTBTBOrYa+gnH/OKOgcobP?=
 =?us-ascii?Q?cYr6lparFyU1daLWNkeWFfSSd/FsF6BOt+4FGR6H5YK0cCt78immf+u6BJPP?=
 =?us-ascii?Q?lqZyiawngR9t5oiar6tgXWrQ7CAod3kHFktdSwlAmJpckeTv/O7M26RrgUru?=
 =?us-ascii?Q?gff0JPMkMvqCoxshiqmP+IiJ3F9oy9OZHAkFBnnWOaE/JCPo1bzKaA79lG7P?=
 =?us-ascii?Q?R2QCtC4qspkZYiMRsiZ4gtzaKkFDl8YlrO1JOuN9CRKdqaLcaH+yNtLzSZzu?=
 =?us-ascii?Q?/wkrSugLbaYncVefWi3MkMhSPjZ4vJWm2jfVtfRXYjMq6TcE6W5UEXm7HjsV?=
 =?us-ascii?Q?Ek4xqGQsJjvEWgsbgRX6RweBzoFVWkG6eJrgMnUME6BQfazewT6GXaWxr3Z+?=
 =?us-ascii?Q?rXn4fr7+fk/3bQiDbTXNOIzOvn5Yar5wWRh9+RCwv9CBFOCK95X0wuqJcIwj?=
 =?us-ascii?Q?KsEFNQPW6m+Iyy+yvuro6Sq5lMJsjQ7CzpueA/10hQ30cWxiKoVzmppd59Ok?=
 =?us-ascii?Q?kQR5H3a7pLIt0EdDjulfKnKsLI8JMp3MsJSjDgzIhcea3K/ux3G8AYfDARO6?=
 =?us-ascii?Q?eJy2QwDB+/XvE5moGESzAXa1yC0Ph9F0V7LvEYRRZYTsS8SAGIDbszsWqUDE?=
 =?us-ascii?Q?ChP7m0B0WoZ7jk719v9nTCUEvJ5GIfHdjZgpDP2tEA9TmWisyceNlrm/K3E6?=
 =?us-ascii?Q?oudVS3MLdbMKeFg52HczDR7zLCBcSt57BLFnzIReSaLbse8d2QDw/MRoz9PG?=
 =?us-ascii?Q?bR2SPZKVaQkWaH+I+8OnN3zNIQ2R9y2NF9J4rDP9x7P2QHp2gL1iD7jJy6NJ?=
 =?us-ascii?Q?+lnALkO5MxsNdEdt4AyOnQd5URsbm/ULCJVs2mbg0CWVj80HSY+7DxgdgTsI?=
 =?us-ascii?Q?F1Xe/yoHprI0PBAN2e7HsI3BjTRZknRVlW+9+IaRBIqWWewabEVEosNWEX0h?=
 =?us-ascii?Q?O3age6EmaDZ4IjwrbF0F6AEFEjEhmzlzKtsUNaIagl7qui+tV7FEizSyMpQT?=
 =?us-ascii?Q?msPfv6cqFgBa0bIlujUXzJk2D2N9vJ+pzknVFgDRGXUlTCYsnVzz0EQ4l7i8?=
 =?us-ascii?Q?lnP59EA1IKf4BgvqLsLhJEoUUFAVROEyENQevboLAyIvV8PS00rthfYVVjhV?=
 =?us-ascii?Q?8MnOTjhNrXh4dhzTQkvBhbHDobHUXRf9OJpy25q5YFoMBbEaoEWS/IJNenyN?=
 =?us-ascii?Q?p1H4U67k7CD/l/WLWhZqFUE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d01d9-bcdc-4e05-2c67-08db25812e85
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:14:56.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YtdUT8/e5c0FZB6UdXlnfOYNbTgEcFjhSudoSlPXMRubjfUvUF4A8DhBP/KUMVuhtU4iEDa5gXna30739yRZ9Rf90I4TajYc9Adv8rvXvpnuOgJgrb57ACmzU+yRWzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3651
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the quirk was skipped when no iommu was present. The same
rationale for skipping the quirk also applies in the iommu.passthrough=1
case.

Skip applying the XHCI_ZERO_64B_REGS quirk if the device's iommu domain is
passthrough.

Fixes: 12de0a35c996 ("xhci: Add quirk to zero 64bit registers on Renesas PCIe controllers")
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
 drivers/usb/host/xhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6183ce8574b1..bdb6dd819a3b 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/log2.h>
@@ -228,6 +229,7 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 {
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct iommu_domain *domain;
 	int err, i;
 	u64 val;
 	u32 intrs;
@@ -246,7 +248,9 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 	 * an iommu. Doing anything when there is no iommu is definitely
 	 * unsafe...
 	 */
-	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
+	domain = iommu_get_domain_for_dev(dev);
+	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !domain ||
+	    domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
 	xhci_info(xhci, "Zeroing 64bit base registers, expecting fault\n");
-- 
2.39.1

