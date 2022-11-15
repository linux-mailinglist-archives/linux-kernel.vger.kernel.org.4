Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D58C629DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKOPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKOPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:38:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600738B6;
        Tue, 15 Nov 2022 07:37:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkRInRRrL+1G8+ChFqmnO4jJ5AMTxj6+BLQYNvYPeLY+vPcggOFh3HEud3JtrsVGH+wrBbEjVpkUPdNjyr8DyHdP4VQh85pMHTHeMbZIBbs5LcECBKTnSYvKCxdIVA+olKIoM+kmjWLwwYU8tBy2PGMvka6QVC7l+iV8/xZMUObpxQ0zUS4gjxIKHw5vn1/kqUTe0L5+cKWj4QnxwUGmDDWP7r6emoEAUp/FTOCcwUYx9q6cwG/Of7KlVW5OFg4S/u+ejrt8VVvbGnv8icP1pVO5zHP4Gtl00zl1maVuaAaiQfU8Evn5eKNFzhbZykOR4yWEg146srmi+qLjkaompg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XebCDA1AR10jix7u8Si8JoUndTIrkQFR6rkGDd/mLI=;
 b=dnfVaCUa90KKp58likAdQNull98xAs3rU5Tbtoif/BeFuY7yWhaSHx04Oq00ZU9PhCWJ0Vv0828IpppmW6nN3EWphBuYSd6ctPy/OtoKIqE8CXTGpiE77zHPRvaTHZmdxIAmGgIgFqotR7mHjWtTLhcdfqhXrOuJKdeJ1CR6Kqze/MgbrBUywa1wMKJeovtoOXh6y2CwBZCFtl4auBb32xbllV7fJFmI0IAgK98I/TC4xDCI0ESuqKk4WFE+eU9HwRvX8w9hEVygMEYVxiSpaua43yg8+u3+zJx6dc2TDU2r28aMFJ8UazulUzcadaUxQLkG1dM6vsPFhWttEowUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XebCDA1AR10jix7u8Si8JoUndTIrkQFR6rkGDd/mLI=;
 b=aubCzpx0PARWnmMdsTCQiFarNx8PGI8AA6yC4VBNr2CMfJLERGsZyaYy8CvAia7zeFADW7C6LJDsvzp9hUfw2PNsZkanSjkYjUJZorvXWCAR8pas0TEn+lA4xxhQwqoXXCM14uZACMcZ/VCku8HrAEXinAnZWnXtB6TRede3wvI=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 MN2PR02MB6781.namprd02.prod.outlook.com (2603:10b6:208:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 15:37:56 +0000
Received: from DM3NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::6d) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 15:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT028.mail.protection.outlook.com (10.13.4.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 15:37:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 15 Nov 2022 07:37:54 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Tue, 15 Nov 2022 07:37:54 -0800
Envelope-to: mathieu.poirier@linaro.org,
 arnaud.pouliquen@foss.st.com,
 bill.mills@linaro.com,
 tanmay.shah@amd.com,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.206] (port=57936 helo=xsjblevinsk50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1ouy0Y-0009M7-0F; Tue, 15 Nov 2022 07:37:54 -0800
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <bill.mills@linaro.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/1] remoteproc: Enable getter for drivers that manage 2+ remotes
Date:   Tue, 15 Nov 2022 07:37:52 -0800
Message-ID: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT028:EE_|MN2PR02MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 061b4436-03ac-44b0-3a80-08dac71f5e3b
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWzd4/W4nQi2MGV/BU/sDMAqo0h/H8y6036Wor/k76i5d0spJWo2A5GdtZ3kBy50y/77qUTGoOx8bZ+wfJmHxSCWKpbhH1PNBmqED+PYnuYNjvuZNCaPH02hj5B7VcRjH4hQC6MbULE6PK889LX9sHwfEAOO79JPNG5SeO0VOTFTOjxTAupB53T/PucoEotT58qswMvq2ykYizNTcE8ZQ3fI9R6sPEIg5YAwF4RzG7UDl4jUMXFJgfLMHRFI352bWrtmdOR8AnybXwSnuTBv8bdyeIkaXAfH2A3sayAnPKyO2vgba5sGYjUzd77qmx57GSalegd4QK0UMMLucfuwovEOfIQBmKKZ4Y9Q4tTfqRCvhcqsnhsR2mNV7KqRGNXjCF/kATS0LqA1E2Hn/7Lf9uIApIQ5QlFlreLHJzlsvliUapOTf44o+toUJRtFT+Axmz0yo6xotmoyBweldQWxl6QjVHZW3bK8YP8xq465nfgtqfKfOqtyZGSpRbKM9edC0HPrm2PeBlTqC3rqkgAL/3fD9lkZHW4kpsAr0nwEte6vZDbsUpplG5BfbYTJEJsSDB71LmbQ9NV43MJ+Ron90AitQl5lgFZj0m31q8XVvFtASkLEjTZwft+6XiBjA4reAQR287Qhq7rSo3rENUaa1VAc7R23CjErqtVnqjKEtFRe2GXsVZ2H6pyx/EkqaFyamGMPbmHcZeOJxYp5j9iRy5MPZ+r4AAFrUMVFcX54aFBdqme2ejYFWEHGmPgs2jwNdW1ExYt/STKMv3lvcWECHgWavUHFypRnx7PW+2Ex5g7iCcWkb+Jp+yAYznc/ikhXI3MrIKOFBGF1EV+eeyT/bA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(4326008)(70206006)(8676002)(70586007)(9786002)(5660300002)(8936002)(41300700001)(54906003)(316002)(7636003)(82740400003)(356005)(44832011)(26005)(2906002)(110136005)(2616005)(7696005)(186003)(1076003)(40480700001)(36860700001)(47076005)(426003)(336012)(478600001)(966005)(83380400001)(40460700003)(82310400005)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 15:37:56.4106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061b4436-03ac-44b0-3a80-08dac71f5e3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6781
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is to show the following
(a) a use case for a new remoteproc API rproc_get_by_id()
(b) patch for the new API rproc_get_by_id() 

For context there exist multiple drivers in remoteproc that manage more than
one remote processor. For these drivers, calls to rproc_get_by_phandle()
are not sufficient as the check at
https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2111
will not work. This is because for r->dev.parent, r->dev's parent is 
expected to be the platform device that corresponds to the platform-probe()
call but instead is the child and this child does not have the driver field
set.

An example to show this issue is as follows:

If a remoteproc driver has the following DTS binding:

/{
	remoteproc_cluster {
		compatible = "soc,remoteproc-cluster";

		core0: core0 {
			memory-region;
			sram;
		};

		core1: core1 {
			memory-region;
			sram;
		}
	};
};

And in the corresponding driver the platform-probe() is as follows:

static int cluster_platform_probe(struct platform_device *pdev)
{
	struct device_node *np = dev_of_node(dev);
	struct device *dev = &pdev->dev;
	struct platform_device *cpdev;
	struct device *child_dev;
	struct rproc *rp;

	for_each_available_child_of_node(np, child) {
		cpdev = of_find_device_by_node(child);
		child_dev = &cpdev->dev;

		rp = rproc_alloc(cdev, dev_name(cdev), dummy_ops, NULL,
				 sizeof(struct dummy_ops));
	}

	return 0;
}


After the rproc call is done and when another driver tries to access this
rproc structure via a rproc_get_by_phandle(), the aforementioned check of
r->dev.parent->driver will be NULL.

To account for a remoteproc driver that manages multiple remote processors,
I have provided an API rproc_get_by_id() that enables getting rp
given a phandle to the core in question with a DT binding and usage of the API.

Sample binding:

/{
	platform_driver_sample {
		compatible = "custom_platform";
		rproc = <&core1>;
	};
};

Sample usage:

static int custom_platform_probe(struct platform_device *pdev)
{
	struct rproc *rp;
	struct device_node *node;

	node = of_parse_phandle(pdev->dev.of_node, "rproc", 0);

	/* Here get rproc 1, as its index should be 1 */
	rp = rproc_get_by_id(node->phandle, 1);

	return 0;
}
	
If we want further specification of getting the correct remoteproc ID,
this can be inferred from the pdev->dev child's device child node and
its dev->init_name field as this is set in rproc_alloc() as follows:

	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);

We can then parse the pdev->dev child device as follows:

	int index;

	sscanf(dev_name(dev), "remoteproc%d", &index);

Additionally I have provided the implementation for the API in
the subsequent patch.

Ben Levinsky (1):
  remoteproc: Introduce rproc_get_by_id API

 drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  1 +
 2 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.25.1

