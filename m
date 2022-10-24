Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F260C04A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJYA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiJYA7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:59:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD24278146;
        Mon, 24 Oct 2022 16:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9p3Xo93srh5h0ET3kSCSd9T4erJEKyE0gJL/L/7vgSOybs39uEBWI50n/a7leZo7xw5DRhXWcifIIw6wVCr+zd/PDWBUojeeypcrLKo7Kf5LA9j9tj1JedduoZLhtlGAr90GZLEUG2mEvYdszfyy5Jk1fjCvLWhyhf7CAO7HXoHh3eAGqnPo5k1vAjq9+vsmjqQv4nLqGORFCENGLiCbDmYiLVQjAe0L70teZXbDWbdU5kwhsDvBolt9Q4r/a+y09jyg/KlqbMcqvdGoqgs8i3X0iOX8DArlrngHQOBaZQGGs9wKmA8/NMHadk4o3aWVOMmY//f4Uh6stLZ+mwcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Myqmr8C/l3MpJnx8kOn2oDE73WodCEUFni6UyUr+w8=;
 b=MhyvWw57mQGqQWg8DB8PLuXPy1ZBuwYH6Dfh+u6ecypF8aV89uH0q/vySbvjeCntr1D/wJzCNgVPowpfZbx47DcQ7oryNq7uJ1UgL1QiXYHUsA2U5Vw7hj/t8JFmwMCdiYqIcEjnXTV20SUSm12Iwkx/aj+ZJehJs3NyWSf6sljXIwQ7bcYivwViIHS/HFEdG7By3Er8xP+uOM7LS5RmW2l9Rlp2zT5Lav7MKQE/lRyhlX8ivWG0OmeIdKDNernlMS0UWmLcO/qSyj6pXcj5hHYhIDgn3Ls12WdoUuWunJQ9iVGb2fvqwNQ+yJSjL9dX5F4CqmILQ6G8utUULZHeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Myqmr8C/l3MpJnx8kOn2oDE73WodCEUFni6UyUr+w8=;
 b=K9CyUyvF223XDTKPRdO6XcBOpULUN+D5mLjQLhbdeK/Cw9A+GfMqznJqaFmEK9T+W2vCvdoj+4W3TG0DBdKxPi5sRo4h6uCKw1TBelr5wQfgKP06I2Wr1nm8LKbvgPnKC6wJIF3v8+eP86jlSRsmy6D3rZ5DPCZDwSAJvj9GJFs=
Received: from MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::23)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 23:50:48 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::5d) by MW4P222CA0018.outlook.office365.com
 (2603:10b6:303:114::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26 via Frontend
 Transport; Mon, 24 Oct 2022 23:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 23:50:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 18:50:45 -0500
Date:   Tue, 25 Oct 2022 01:50:34 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <Y1ckyqeoWQAs6R9B@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y1b92DF0c36/QDbo@rric.localdomain>
 <635702a652637_4da32941a@dwillia2-xfh.jf.intel.com.notmuch>
 <635713bd6bc15_4da329434@dwillia2-xfh.jf.intel.com.notmuch>
 <63cd195a-f5d0-b016-d833-b3a9c86ff6ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63cd195a-f5d0-b016-d833-b3a9c86ff6ee@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|CO6PR12MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: 551254ad-ffbe-40b6-c775-08dab61a9391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5MH7iDBYwEJ0D+KVyjZyw/2fSEpiTNIoIS1nVKeH4bFBKz0HupL1sPwtSV4YgEUJXCldfAAadMJsHEB1DUuwSyX/PA37zsCc/Khxa91IGU3wcLejvZufhD0KLBCrsg1fhIzwTwwL+zT53RciL226EQdkDnfuQDs2nShKbG9WnC2W+MLaK4ty7xevjaKehW5jacIue+XPdC366tj/Aic8/rot7GfdOlIi6DEQ5tv+ssmIDFThZ1WR3gL/U6Q7cOw6uPo1aZmUxxrudYHk9Tsa3xGxu9REWOzF9FPqux5m4Hu4cn1RKYiPAaYrd7Ri6gH6tjJR/rPG7rQssMdyTS6E9yRCwwQ3lyvNrtrlbc6PtJ7jpRNNPScfSFJo5J/2n4B4OVn1boU2CuqJlPmtz/Plc4llhBFXPzTM4yJ3EYhSIcdF5vjhdquHxUC3vHsNwfAGiPvmeXNsL+XlvcueFjeI2bEVP1RqVddxLg35dUcbXpTsNY6kpuJ4oKK8eoZ6Mqgw+izzdmsljW2k0Tn2gANFVtuoToMNAVdIfNEvb4uLkm5HJtrNxrBBpUQ68gl+IoLz5Zuvtc7YPbh7Kk6ht+qzkYRU6JlT6Xgd0j/2YeGSvlPzXvlYJ49LwJyXSBa12OMOVBVki8UiSU98t1k1g+UaNQ+7TyFXBPkCKRnflPkithQvcjUzl8VwMd8EasedaWeSB9v3Mzx10EO+QxK7SM1XLFdsO/XXmuR+gu5ZD3y92wg+OAldO4Oo+s1eES+rLJWG7L4yiq21pdCZMcxedVNytjNGfX0n2/9GzIy+Xaz+TXH14mg0V3aP8f5QJwUNMSIMXNWYDzUrVYL5XlL7ZKPdwTfu0fwNfXkAb4pGFN9OzThv5Do1R6vbIl9CYMlbuJv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(7416002)(40460700003)(55016003)(40480700001)(82310400005)(41300700001)(54906003)(47076005)(426003)(81166007)(356005)(82740400003)(36860700001)(6916009)(966005)(316002)(478600001)(6666004)(8936002)(8676002)(70586007)(70206006)(16526019)(4326008)(336012)(186003)(7696005)(9686003)(26005)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 23:50:48.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551254ad-ffbe-40b6-c775-08dab61a9391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.22 16:23:39, Dave Jiang wrote:
> On 10/24/2022 3:37 PM, Dan Williams wrote:
>     Dan Williams wrote:
>         Robert Richter wrote:

>             Ok, I see where to go here. Could you point me to Dave's postings you
>             are referring to? I checked linux-cxl and could not find anything
>             related to RCRB or that changes regs.c.
> 
>         He was in the middle of tidying them when you posted your series, but I
>         think it would not hurt to push them to a git tree so you can grab the
>         bits and pieces you want.
> 
>         Dave?
> 
>     Looks like the list delivery is backed up, so I added Dave to the Cc:.
> 
>     He pushed:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch
> 
>     ...which was his original attempt and:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch-robert
> 
>     ...which was an attempt to rebase on top of your bits.
> 
>     The common RCRB mapping function is here:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?h=cxl-rch-robert&id=5be44cad37972517dae6a79001080ccfbdb67c49

Thanks for the pointers.

> 
>     I think the path forward is to build on that common RCRB code, fix
>     cxl_acpi to register the pci host bridge device instead of the APCI
>     device as the dport device, and then rely on a flag to skip over
>     devm_enumerate_cxl_ports() in favor of just calling cxl_mem_find_port()
>     directly in the RCIEP / RCH case.

Yes, we can completely skip devm_enumerate_cxl_ports() now. Though, I
am not convinced on using the pci host bridge as dport_dev as RCD and
non-RCD mode will diverge too much then. Looking into details here.

>     Then we can figure out what to do
>     about RCDs that choose not to implement the HDM decoder capability which
>     was forbidden in CXL 2.0, but now allowed in CXL 3.0.
> 
> Hi Robert. As follow on to your work, I'm also working on reworking the hdm
> decoder enumeration. I have this table from Dan where rr - range register exist
> but not setup, RR - range register exist and setup, hdm - HDM decoder exist but
> not programmed, HDM - HDM decoders exist and programmed. And I'm trying to
> refactor the current code to cover all those scenarios:
> 
>          rr             RR               rr hdm          rr HDM          RR hdm         RR HDM
> D2       unsupported    emulate RR       enable HDM      keep HDM        enable HDM     keep HDM
> D1       unsupported    emulate RR       enable HDM      keep HDM        enable HDM     keep HDM
> 
> The current test device I have that's attached to RCH host, I'm seeing the RR
> has setup a single range, but none of the HDM decoders are programmed.
> 

Right, HDM decoder init need to be changed next.

Thanks,

-Robert
