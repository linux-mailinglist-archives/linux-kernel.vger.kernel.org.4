Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38813625A41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiKKMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:07:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B698857E;
        Fri, 11 Nov 2022 04:07:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9w+UjTmuK3jfRQ7cpuFDHK6Xi1WwM4dPDtuT++6bmDozjXwGi1Kd0etvD71bwJrqP/lyIGqHEXksL7+IAKeRDlEUG9wdYwgyNaZpkhRhiEFM3lF80/ViNiKJjg5qtsHhT3BaJPwn2HuU4RfXcl7fBTqVgXLgEvZ8LSVHzRCBcJo8b98NAZJe3100JbWdU3gTaB/F8nC3VtAV6QZouvXHb2AGsIO/G5Cv4XF+gSauvWEPsvAzGAWfDYXRgP5hTXm8jelH8kOuRnIqoecrFlSRNA2X1ySzMuZe5KCdRBZFZ9piiHrQPyS/B5uHCPbjk1HgL0OJGPMky82NoabW0TY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIk3OOVBI2/05EUURi8dUMBrUzW768KFtpspx4lXzUY=;
 b=AXhEd+fuX9f9n86bzi/G9cpnbJzs5gryBbQun4BT5Mq60pREDQQwlCI3GXM6zDqTpVbGmQt6Sggn3esX2XjlGTymcomP2AU+Hn7hmYQHNT5hqGY0cLOf4cJUISOkFfzd06H9N91kVpjiGoMTAKNGeqXX1dToyr9cFg/iP+aRoyqhzLCUWTjzK1t6ykTgiBVyetVBzpRBD9yG7U5YEV3b28a1/lP/E4YV3FaGiczXM1gjiaDuc8Ry3NmlolndKQL+FXzf1oiSn+asjaxeVSfB/T6a3ByeUgIUHxpjqzPsme9dqvjj36MR0OEGXClO21/nCHyGX1xGIJB9Y0n8fxuvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIk3OOVBI2/05EUURi8dUMBrUzW768KFtpspx4lXzUY=;
 b=ShZPB6MlnwBm4KIfBMPj79K58drrV3WRXsGAzeruLww+65qNzyFzwxk9W1MGnsmlHjLOMqd4T1q3oJso6kM+VWksnIgKMcaB98ZQWZo3S6pBGeKDGvTxUW8W5Mq0MgeUnBxdswFFMCwHc//WX1sOjxIqzJ2zQ/B1+wV0x6inuqA=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 12:07:29 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ec) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Fri, 11 Nov 2022 12:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 12:07:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 06:07:26 -0600
Date:   Fri, 11 Nov 2022 13:07:23 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 6/9] cxl/pci: Do not ignore PCI config read errors in
 match_add_dports()
Message-ID: <Y246+zR5odZlNlkW@rric.localdomain>
References: <20221109104059.766720-7-rrichter@amd.com>
 <20221109230956.GA581201@bhelgaas>
 <Y244ghE6SVZKWu6v@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y244ghE6SVZKWu6v@rric.localdomain>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf41f71-a895-4d08-a96a-08dac3dd4ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3ICcXQFKY5L4OCrwcoSOczQrpftGvMh3CfDF5M9J16qr2sAeOe2Ob+o5hnC2jK5BVb4xWMybCSVPeQQagDGD4InlVfKuE7P4FW8Vtz5HptYu2gvwdj5VulFSNJCQL4cA7OHfa6u/L3PK2UiqgQNyHgeVmI6KyEwXVkYdgj92C6rXqVMtNbIs8VlAhbkPrvxT6JsQ00ZNwdMmYyodwkTcxFfK0MOtcps5cRHpex/zVNpB3RHEEi6t2vb5XQPzmNTQAeSl56x+68VG2xlo4I/oXdj5CHyOaK8TA6sMuJlEpiXTfozWjCUI/p2uXC75IFtyecQnx0gvYLdH5UiTsPPTnH9PxE9s/O3dCgd2tj4p/X8O2iJwqA/sakMTte3VNaOV1wEyWboEEXEptcCWcLOuxchaWw3uJKFyiBEHhe3FK3Wf41wHae17tn+m4dYSMPiBS8QIIUkpIJne6CxKWP3U0bXWFgzDUURMliQ87xzguJnKqwv9WgqMSYJ676GSdpMcWikX5IPBA/Sie7UpRwq/2995kvZgFt+qPTvOZnD029CAWeNIVAv8i3IF0/OjF1BzgDsVo3G+oK/z3w2Mhrjj16GRF+Ut724whTtQ2FdbgJx3qRcF9WtEsAKKOuAqIGPmSw39PnrAMqHAV4HZuv5VxcFJfDDw5MzK5pNcjDkhFZcLXJtKqFURsGpnC2cGDgzvUtczpJptleMqi4lYoBAUOc7A4rxuiPDG+AwQbUne5YY7zRps1Sd0Ybbxts2/loBZ0seN0xeNDJ09eXllL862yvdpGpEIBRVIIKp0jqMD9eBAT4lIxiQGewn8dRb+5dEpxjwJ2lTk7rR4FBkPUmPAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82310400005)(82740400003)(4744005)(70206006)(6666004)(36860700001)(2906002)(40480700001)(336012)(356005)(478600001)(41300700001)(53546011)(26005)(8676002)(7416002)(70586007)(316002)(5660300002)(54906003)(6916009)(47076005)(16526019)(40460700003)(426003)(186003)(4326008)(55016003)(8936002)(9686003)(7696005)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 12:07:28.7393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf41f71-a895-4d08-a96a-08dac3dd4ded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.22 12:56:56, Robert Richter wrote:
> Which raises another question to extend struct pci_dev the following:
> 
> #ifdef CXL_PCI
> 	u16	cxl_dev_cap;	/* CXL DVSEC 3, 8.1.3.1 DVSEC CXL Capability (Offset 0Ah)*/

Correct is CXL DVSEC 0 here.

> 	u16	cxl_port_cap;	/* CXL DVSEC 7, 8.2.1.3.1 DVSEC Flex Bus Port Capability (Offset 0Ah) */
> #endif
> 
> Note: At least one cap is mandatory for all kind of CXL devices, see
> CXL 3.0, Table 8-2.

-Robert
