Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885DA7207D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjFBQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFBQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:42:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC6196;
        Fri,  2 Jun 2023 09:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuA6JhE/ee2j+YxSwvqPeUaR+vxO8iLoisBxAtArNNJ/+r34AgSfuoO75YELgkJciUhRhRcZV07CgrxTxwaIw/cNohxz87A03fP/U/XhEOfI+EbUMvGWVeVLqRiYfpkg3hLF2NMtMHeiGEytono0sPml22qrHcRKMwzyNRiD5q4L0kFS01t+En5h2Ec/fRSjxPCvQSa8Dt9k+elovw6+EYmVpnDtbWENKIbtxJu2lQQXD5cPrGV063aj8edXqZCorHWJI7j+OYG046T9e46+tXneH8tEbPV5bSw0ZgEezLZ0D4vJpWYq8tZ7hFi9/3nUuC97iZKyjL7FJA0n53Arow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HTPUR1SlcKbZB27q74COuM7E6zqT7Xwc8gIfJAwKY8=;
 b=PULrBYGqjpErUhhL9AjTN8BBVb+sGTMcdr/s2pBHWoeZdqyAiE1gXFzPx1rJYl1Ql0VdFfN2uxnVrzHgesExyuDdFm6o8vk69jDwJDMQWz6Q8v2YajJCMlxcgCPBxDGnwvfFvJGZgGu6QOJjkm8xslJH8z2T4L1sra+twYemppg0auAG+ZwUvkcpObKlCGf5WYCCrj/7ueuCrNNc2m+GnTwJkTybXU8ZRia7jM4pw2W8t6FbWDchqR5qvtyVxBVaiGji3iKWND7+oAVLDQ76Q3/JK4Jr0tqyQxQLofq5rttDASAiliS1/D6eMwX+sRGJ7UpnIkarxKXdDmsTDCoK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HTPUR1SlcKbZB27q74COuM7E6zqT7Xwc8gIfJAwKY8=;
 b=NSKMxK7VfVPMRnCJDCx3Fwo8cP/L3tOx5bGRMwGH72Iif+MKvd7dUXcup14ACzXanyq6b4wGLYzcZvWY8yGvNBeNY2V2JqfcPP6g0bHggZJR78NTcoAOg4GR7VWxpNqc+7KGIrYqeFq+LggGooxogQCxnIEAM5pjlzOoUoQy/Ek=
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Fri, 2 Jun 2023 16:42:04 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::2f) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 16:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.27 via Frontend Transport; Fri, 2 Jun 2023 16:42:03 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 11:42:00 -0500
Date:   Fri, 2 Jun 2023 18:41:57 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v4 23/23] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <ZHob1YA3NUFNushM@rric.localdomain>
References: <ZG/cYUaZerXNqqJl@rric.localdomain>
 <ZHEXOlxfCCApI+NE@bhelgaas>
 <20230601151134.00006281@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601151134.00006281@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1784c3-60c5-4596-4450-08db63884b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5G4h42FUce4o+76u+TJ/hF3W9WbeHW/gcjjuQx+e1NYPs+xZsDi9xYmZazXCYMWAaw4X2uujUZKpvBLbSvRfTcSagOdGdqEghUPmGBwpMUP9/ZhshmvSG1WWYm2TGa1xhdV5OhvLBR4Kz0m59xsSVPlojteszt4vTGscF1OvHcd3o1uvc52Ctj1pZ/aY+eFlvsv1MmE5BcXKkvSRBH2E8PKOYrZEwj2SZTqq3kUV96UjJlgsCCuoVFW8STTShgfD7Y5gj8Mw5b3QZc12ILii0VT/VgoW2FPOhFOKhwlYuyVZt9X/jyRO0vaqeEILpirW+b6bVjYcU9O8tD80FvvBJMO8dZQd902oJ6apgXqaha66qRmCcRjN+ifIChsjEO53xVyaOd47VEAEMhZqj592lKXOIEnEH4yZU+6WmCBrhbNvtzSu3kMDmwf7kkzKuavfpKZbke07SPG8ZsXNYGpK9KFCm8ZMLaXtzK4QrLQoppDQSdyquzUi5nAn9yiApOzQOELxKOAIbsMkPKyFuO4gKgEz/ZzYtr4npN7j19GCiBGFusBUBlg9SDjUmRQdtmW/RGDE121EGl78Z41Ka33X6wV1y17bBY3RGsy1Ra39/X/CnOI6Pac86m22/ZhXllU78tABLMlwexEOozBTcFC1gHJEVnHyJPF1+TNE4u0v/KhiDM6sulFJtdaWQjxtve1cvmJqr1OLHuzlXtdWZEoNMhMkqR3rC91BQtjVr7q5WYxBJVXIqLxn17bLJp5ycuY9tgHMm1HibDdcbw+oBR0GfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(6916009)(54906003)(6666004)(7416002)(316002)(478600001)(70206006)(70586007)(426003)(26005)(9686003)(336012)(8676002)(5660300002)(8936002)(41300700001)(2906002)(53546011)(186003)(16526019)(83380400001)(47076005)(36860700001)(4326008)(81166007)(82310400005)(82740400003)(55016003)(40480700001)(356005)(7696005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:42:03.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1784c3-60c5-4596-4450-08db63884b72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 15:11:34, Jonathan Cameron wrote:
> 
> > > > > @@ -1432,6 +1495,7 @@ static int aer_probe(struct pcie_device *dev)
> > > > >  		return status;
> > > > >  	}
> > > > >  
> > > > > +	cxl_rch_enable_rcec(port);  
> > > > 
> > > > Could this be done by the driver that claims the CXL RCiEP?  There's
> > > > no point in unmasking the errors before there's a driver with
> > > > pci_error_handlers that can do something with them anyway.  
> > > 
> > > This sounds reasonable at the first glance. The problem is there could
> > > be many devices associated with the RCEC. Not all of them will be
> > > bound to a driver and handler at the same time. We would need to
> > > refcount it or maintain a list of enabled devices. But there is
> > > already something similar by checking dev->driver. But right, AER
> > > errors could be seen and handled then at least on PCI level. I tent to
> > > permanently enable RCEC AER, but that could cause side-effects. What
> > > do you think?  
> > 
> > IIUC, this really just affects CXL devices, so I think the choice is
> > (1) always unmask internal errors for RCECs where those CXL devices
> > report errors (as this patch does), or (2) unmask when first CXL
> > driver that can handle the errors is loaded and restore previous state
> > when last one is unloaded.
> > 
> > If the RCEC *only* handles errors for CXL devices, i.e., not for a mix
> > of vanilla PCIe RCiEPs and CXL RCiEPs, I think I'm OK with (1).  I
> > think you said only the CXL driver knows how to collect and interpret
> > the error data.  Is it OK that when no such driver is loaded, we field
> > error interrupts silently, without even mentioning that an error
> > occurred?  I guess without the driver, the device is probably not in
> > use.
> 
> It might be in use.  Firmware may well have set up the CXL device and
> even have put the kernel image in that memory for example. OS first RAS
> handling won't be up until the driver loads though.  Would be a bit
> odd to mix OS first handling with firmware setup. I'd expect firmware
> first handling in that case, but I don't think anything stops the two
> being mixed.

Right, CXL memory may have been set up by firmware. We will only see
AER errors (for the unmasked error types) then without further CXL
handling, which is IMO OK.

This all assumes a non-CXL aware system can clear the error status by
only using PCIe AER. That is, a CXL RAS error may not trigger again
(or at all) by only clearing the AER status and not the CXL RAS status
in the capability. I don't know what the spec says here and how
devices actually operate.

Maybe option (2) is easy to implement with the refcount_t API. So with
the first device probed we just enable the RCEC's internal errors and
disable them when the last device is removed. I think CXL RAS errors
will not be triggered then as internal error must be enabled for this,
either in the RCEC or the endpoint. Since internal errors must be
unmasked first which can only be done by the CXL driver, CXL RAS error
wont trigger an AER error message.

Thanks,

-Robert
