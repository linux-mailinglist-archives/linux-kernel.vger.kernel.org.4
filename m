Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7E68CBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBGBXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBGBXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:23:00 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2134.outbound.protection.outlook.com [40.107.100.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE821631F;
        Mon,  6 Feb 2023 17:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxVVpy/wuoAYwH8MzNhQJiWUa49AU6az+o65dpvzffA4dS8PEZShk2bzUkImDG0VNRckIjEWWoSPqUuTreMZUphV/SrGew1QznQFVTMDKoiwp6RvgUbaT3sFwKI5+qZHy1KeAX0JmhCfYGRXn6nX9Lec76djBbVUbW5DDSY6zQNjRZazIyFR7mrBj0scYyMyinUqR2UFZGc4mI6ahZpcvxc6IcFgNIdzvWuHftO6NWdXYCq6f/X3QZCe0zaxWu9s70gCKOPykrv8GZxOSKu5Qj2KheV1gQZS4St9qjUKrOFqEpC5V0TZC4J9QiVzjwhfPTz6YK+2H6ZggQIQV4lnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5BEmjE5HkCyay18DKFiXx/euf0Saus1q0RH23W/d1E=;
 b=nQ6hmmGA2//9IbuXSTgRUxmWBtGcozKTNNpjmIy0MrIVwMhzoprh3wOtoji+tBTa1dYyP5i75Aq8LUln7jmUm/EjsES4P3SqRq4mcR7W/3E/e/+/3jOxJYgrjA+Q/Kj3hf34QLGDkf6Cbr67NQbY6UriyUwLWrmYViDKu8m9/k0anYJGZbu4V24lYvIfJRLUZ7ql6t208cIqaljJA2FuqfjvKbVk4ZR5HH5NIfBZooNEO44vl6TusnWi5SUz+7u6E9wbDt+8rzp3u6Q4yyw5vwl08uFjW5pswnN/+SsVRDeW2gqwGUamvCkcwT/1nSL7l06v2VfxmyMlyoaSO/rd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5BEmjE5HkCyay18DKFiXx/euf0Saus1q0RH23W/d1E=;
 b=DCYXNNdbfkLN+TMG62yLDxVAbID2kC+9OZhdEhDPu3eVTkjDy1GciWdfkRoEHT2os22Nst+TYX24IuvwP3Ac077QsKKPE1DaObeyPNEs+PNt+8shWdZelR4Szp4Gp1bfcvWSNcCecu8pCx9lAEPpGJZTzSPCfcBHnC+wj/pQF14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BYAPR01MB4728.prod.exchangelabs.com (2603:10b6:a03:84::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Tue, 7 Feb 2023 01:22:53 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::a0d2:ebe6:dfcb:f75c]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::a0d2:ebe6:dfcb:f75c%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 01:22:52 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: also avoid the XHCI_ZERO_64B_REGS quirk with a passthrough iommu
Date:   Mon,  6 Feb 2023 17:22:25 -0800
Message-Id: <20230207012225.3599929-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BYAPR01MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f222f84-088b-4c10-1098-08db08a9d573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEb3ExWl1y26iuFwMGrf13xH9FwJ7rz/2K5+Ee2H2gR2TJv+6iX3hqMM2/lHWjH82/1YnkUaOVt5LYqIqjJpYkBFx+SyknlbrIaMN8gk9p2E/Gy1W6dFg5lRckl2QNRIviSbiwBT+D+JAoFOau8am9PBlt7fq/zZV/XgXLTNNwXCAHfDCA28kxd4CXJ6L9iXEyIFqRXRG4og6QZZQeaHRYVNeARJz9UwAQo9i19utpShVGGSHvF3UDXI2pI0dFs/Ck4/GOcC9NdQTjFy/sVyQpYr+hYJGQ9vZaDVTTkoKieVYw9YtZft46MyYKCcpUmZekDtU8odHv4QRzk8exkK6sUVMp9TPNPfsazRXRaf2qY0B6vhRaFcAW7BIHMiwlLNvGdX8AyQ5d6W48XH8tf++3+FpBk13lhwVljsKJ83LPIoPsE84Aibva1cOKd1XRdz8Ax/fUezpJOIN+kDHfBpFGyqS3XgOSW3oAQfx1LSyYrK8Kpv1U+WX1N/aV/D9SLkcP925Qb0XEXkTz6WNVx5jd/2RprCvxCAkh7gm6IbwfPld8Tl6zzQPZI5b/Cl0VHD2rDvWrCUUwIi+yyyA5ZUMDGnAw4aGCGTZ7Pwk5oljLWKn58S0GRMgfT2M/mxpXPNwoU9U8qkYKz9nOpEyeP4XWeJeN8OBI9kftkWsmWdusUKknWd6UrEIvRR8zYaUtNKvrOzRA5CjJMWQEB+rDH01g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39850400004)(366004)(346002)(136003)(451199018)(6666004)(478600001)(52116002)(6486002)(2616005)(6512007)(186003)(26005)(6506007)(1076003)(8676002)(66946007)(66556008)(66476007)(6916009)(4326008)(8936002)(41300700001)(2906002)(54906003)(316002)(5660300002)(38350700002)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r9k8nHKNdYnN8zRSBYhEXWai1m+OkmyozrWIlpD7NzRHUriBL8QwefiZYULL?=
 =?us-ascii?Q?jnP/+0BaWT1t4lm2a6phUybieJpZK6npG0vDkBHwA5mOEv8N/z63Zp6xaTob?=
 =?us-ascii?Q?6AVBz17bL4CFirg85/cONwvbYGYJun64sNWCN0EBpf64nf3q16YCHovxKk47?=
 =?us-ascii?Q?x1zVwHoRYeftZwrxNXIDFozh6g/K0+VMa3vCsH5gfWcA8WUM7mUzKp/qjP/W?=
 =?us-ascii?Q?6+wI2AeZOux03HKlcSStRP+6hxrJKX/78qkq+yGVcToqf1Um315iKf9sRXpr?=
 =?us-ascii?Q?FzD3cBKrR6VjZTGBhUh/rz8Did0/LS9H2Fb5TNasuGpq2H1bo+Ajrplubpmi?=
 =?us-ascii?Q?ZKo0YYu5ouWCrlcwSxPnvw7tOLkeNXzKNx0r+YaGK+1/qxBBFsUWqgNFvr8+?=
 =?us-ascii?Q?m0Zl5Of6Ln1qCiHP10kVweWl2r2IkA+VzJkpu/xp2alvV3KXJJCwoxGmEhGC?=
 =?us-ascii?Q?0inqZbdamgMEahiOz1oFDBufM+Bix81MzDPHgGXB6xJnubTpdwzxZjZ8GYYP?=
 =?us-ascii?Q?HRHkGXr5tqhAUcczHpoqeTl8IkLK/1wNClTOpohdKBxWpX/Or/tC/Wo6F9ou?=
 =?us-ascii?Q?enLMiBIQETtLCRyYggubj6eG2TkPPLTmB5fGFzd5XW+coFQGBy3gIQ/QkHMj?=
 =?us-ascii?Q?X/B9jVO9tsl60aOjuGTkogX16bA7FzcBlJUVwp/Msxkn2IjLQ+U8/iF3LtzC?=
 =?us-ascii?Q?pghM3czpoKBldM735AFGLMihEfXvsKNvfvsgyFc6fgAw5ctUAAUzji4JX6tW?=
 =?us-ascii?Q?HAdMqFA8MKnDx319Q6UAco62fVl5ElkxFbfxvy2YJPkfDfNTMn68iPhngRiN?=
 =?us-ascii?Q?RlOyBbDoUwT71u4TfTXUfwfgaFNAKyMMXZYdyBXoxL8hGQ405xPNVl9M5RwE?=
 =?us-ascii?Q?uF0f6uZrndhiPxQhXl/xt8o7h+Z8AR2+v3sGfz6q3OYEBKXUjl+m19lv7F43?=
 =?us-ascii?Q?hkIfNO2Lf4wRZ2tsWfJXyvvYUM07XsUAaKbDpuJTBopW8nipOPM7vIZwh4uK?=
 =?us-ascii?Q?lPJLGgtZyBpamUtDDbxqkPEdy/s9nKPBBFLycD5NgzoEZm2ZIGTjziYLdK8G?=
 =?us-ascii?Q?3KqZe7t2U3kBROizADyX48Uc3dNrFiGptChoVxC7ykkOzfEhTyOKVFNxKRql?=
 =?us-ascii?Q?C4lILgEtWwEF100CMXgO2hUg/8DIETbl/7OOh8zgHKTD4SljJmgaFe89FHxD?=
 =?us-ascii?Q?owvUsrXPyMq/FqDEzzEd//gPxb5ybRceFIdGyRNMy4lpmT3Znpul8tlgng0R?=
 =?us-ascii?Q?IiqFCcvOvnrKXdG9fxg+vsavNFk2fipIK/WSnCCKUelsNlDfPkMxkvW3sHVZ?=
 =?us-ascii?Q?g9ju5P7/hHL9l8ATnUs9u2EUk+rVzd/tfg8LeDn985RCdTINqKkbngWON2Ew?=
 =?us-ascii?Q?CEfIYcSGrkCW6lUL6vuy1KvZG07bP+bpCzSmoxZKFIeRO4k3kG0jwiFmLCJQ?=
 =?us-ascii?Q?OfjP4vjuEaYIRt6au7rDTEkB9E1+8yW2oflsmEYZJTAu+AFyqxlCXEg9m/YW?=
 =?us-ascii?Q?iZF6rkhJIBRjxI4yN2GqQDf1b8jfnl0ywt1/AyrYL42C7whWrngk7F8RjYvf?=
 =?us-ascii?Q?omgFCFSFXuIaRrBIAReqWjuUTNkJKt1P6Z9f2vNozzuKBr54q47FvcWau9SM?=
 =?us-ascii?Q?RqtYO06r7Hc2poJrBFxAd4I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f222f84-088b-4c10-1098-08db08a9d573
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 01:22:52.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbUJfegj3f8x2CkfF+AMOwyTLD3Nl6fAWIsny7tfbs12J8DrfjCjPYCVC6npLaeQOP0JznSZQ7jFRt6QyJnT1q0H5XcerEO1zaeDBXhYovPFxAIcb6m5KeWqBmBk4lr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4728
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 2b280beb0011..b15864099c3c 100644
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
2.39.0

