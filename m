Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24B62EEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiKRIMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbiKRIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:12:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1661582BDF;
        Fri, 18 Nov 2022 00:12:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXghgDr9LFpGvsTib5MLip7/sU7INysyLJ3KbwaxTFA2kmIOl9M1GXh8t1U+dxzeu983uvSAh2nUSwEv3cldjDLPu/Awmhu1yEfem9aPIUToDgUVfd3H1EanZt1inBfpjdyUURjRPeW557giEhlWhDYShg/dRL3c1sZ5r8COzyxv+rrmGDvAQ97CdfA9nNeTA1TtkFoW493AOvFiiw03+UHsbw5OSoge5Bb+0RmYCbquj84HhJjczPRiXHx3ymDzXn4ooozKXaaKw+1ungONE83BUQc6+KsbOftM2yd2b2rxvgkOu6lZFfuwHNX9xaAl09M1/WOw7l/NkyOqOLyzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etKnFGbDIFEhYjhCQGGReithEuXp/hkMA7DwAtrB4Gw=;
 b=TQy42rcarisghxo/pJVpcOHxmkNxiLfCTacZA5hHFLhtcauYFMUHHwNCePNa36lbhRGOQWg0MTBye+pyso4tDYHOFJjV++iK19dPEgeI/3NcYrIFRWGObEQ+bhGtA1oI02x6UExyJoxMUBINCYd9WtM6WzuHNxDUnaxxZQd7D5qSubjKN0nmw+UougURcD3KelkIPh+voJlToBaNDtM8vurs/2622h97i3wf/dKylJriRPgBStVb/DuQwejbsTVlpFT942WxpZDKYR+hVSXz1XV/l2ini4eiWO3lP8yh2cIM6V82BEfJmQaagNCaQp9PYj/hoN50mk2Mw3jwSmCriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etKnFGbDIFEhYjhCQGGReithEuXp/hkMA7DwAtrB4Gw=;
 b=Rvwcf3/Ru9c0pBC9A1dwEE9KVJ27P2EvTkE7XgFnEvVloDaKVpyrglPLhBwFJuLsJ/VlNEYUx+u82efr7TpTI1RBxuc7xRH+6L44q1xRAxOF20R1H1mTnfrx8tcjBpPV//VqWS3fWYMxemjEbkEm2+yMqog2i6liO05fyCh+Uwo=
Received: from BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20)
 by SJ0PR12MB5470.namprd12.prod.outlook.com (2603:10b6:a03:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 08:12:38 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::ee) by BN0PR04CA0045.outlook.office365.com
 (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 08:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 08:12:37 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 02:12:32 -0600
Date:   Fri, 18 Nov 2022 09:12:21 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 2/9] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <Y3c+BwrT3wCMsv7Q@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ODbwk+12JvWyhJ@rric.localdomain>
 <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3YoBpIsgRRbRyLk@rric.localdomain>
 <63766d77d1ece_12cdff29499@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3Z8kZym/37P6/yg@rric.localdomain>
 <63768a244a14_12cdff29469@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63768a244a14_12cdff29469@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|SJ0PR12MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d41aed-d760-4de5-4228-08dac93ca7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FARiyyUJKZuNbQ+OvAT/mjNRXE+v2CBmyvx5zmK2WMUrZNhJdst6AjH1eGaA9OYVyvbuNgZ2Fm2hsID3rdpbhU/Y/DsCcWNJsbatBPc2oXwacUJ+uH5bfybKPPvN5EyVCzbAhUzd1mo7iwa4CiwcTVOo7Fn1PD/SXlOehmSyibJYtEEN5cf7GWxTaYNcO8LTk/JkRAf1aUCuEPBUOHrvRR7ZFEMx6xWVVIhwbMttoTCncu2hurVohs885JBFO/qJsWAfVQwEJ7XVq0JFwhHWbZMz3o1mXyRP/k7T7b9jP0PUF3at2dXpqmGGlkrpBgGE1fMkuVI1iUUqBUicgcblsQ/2UxSiAaH40gv+3A8TxUhkb7jRsDKoPeqZufLkx8MxHesdXWbMgGiiTGgPY/oVmb3Zr+hLgbZ9+85Hzp8krhOmNgH1mfUgCbBESW0iYgUg8ehJZZGczntLbnTJFf/qSNtoEvaQPCjoBDIoXesCY5jBkUKONXplzjsImXLhx5lTpmxzjmmdCte3JC5KSwREoKjlMjdoIFIUaVeFFrWb3dY7+ifHPiP0+ghuM8xptOipJNm8/j8x38eu06tBKcFIdehPHDhLHjAPTO3zHZ9bhZlpIfG1o6wM0EHr19iGWRnxwK41poley/3JBMclgA0xJjTjyhCvOnPEOqSWk8gXoM5yswBnOawhSc677ZfpgR7aLppUUw7ckc3nNqJO0cPR3N9kHIOaF2GUgwZ249IDwEScR6dTsJtA4Lk+5qRayiGbcbfalN7N1NR9R9o2NQs2lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(478600001)(356005)(81166007)(83380400001)(40460700003)(82310400005)(36860700001)(70206006)(6666004)(7416002)(5660300002)(336012)(186003)(8936002)(2906002)(16526019)(426003)(4326008)(316002)(82740400003)(55016003)(8676002)(7696005)(47076005)(9686003)(53546011)(54906003)(6916009)(26005)(70586007)(41300700001)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:12:37.7983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d41aed-d760-4de5-4228-08dac93ca7e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.22 11:23:16, Dan Williams wrote:
> Robert Richter wrote:
> > On 17.11.22 09:20:55, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > On 15.11.22 09:54:16, Dan Williams wrote:
> > > > > Robert Richter wrote:
> > > > > > On 14.11.22 13:30:01, Dan Williams wrote:

> > > > > Oh, sorry, yes, my mistake. However, there is not much value in mapping
> > > > > less than 4K since all ioremap requests are rounded up to PAGE_SIZE.
> > > > > Since an RCRB is only 4K per port lets just map the whole thing.
> > > > 
> > > > I was going to keep the ranges small to avoid conflicts with other
> > > > requests for the same page (though request_mem_region() was missing
> > > > yet).
> > > 
> > > What else will be conflicting the RCRB? Linux has never accessed an RCRB
> > > in the past as far as I can see. If there is a conflict then we may need
> > > to move this mapping to the PCI core so that it is managed like other
> > > mmconf space.
> > 
> > The capabilities (PCIe and DVSEC) could be used by various subsystems
> > and parts of the driver. I am thinking of the various RAS caps (UP,
> > DP, CXL, AER variants) that are accessed from different parts of the
> > driver. Of curse, access could be delegated but else there is the
> > option to directly map and access that parts. In the component reg
> > block we already see issues with that broad mappings.
> 
> Sure, but lets cross that bridge when we get to that point. Something is
> broken if these competing usages can not at least have their own page
> mapping since that limits being able to hand out control across security
> boundaries (like VMs or userspace). Any ioremap less than PAGE_SIZE is
> somewhat suspect.
> 
> The cxl_port driver so far seems to be sufficient for owning the entire
> component register space.

Ok, I can change that.

Thanks,

-Robert
