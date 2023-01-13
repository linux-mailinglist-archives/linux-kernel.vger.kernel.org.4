Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D56698B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjAMNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241584AbjAMNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:36:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87D559F1;
        Fri, 13 Jan 2023 05:28:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3a/gxHbPqAN7STEgIpqD9ZUixfwPfHwtkgo4C6zjmbt5qDfHteTwIBzD+N9rKLgbA6SJo65hsi3MgsM/sennEFvGcS9haNdzChtYkyOQvH+Jiu5QbwgVaB0PMWSBb/tN/g4vUFoyRxu/0BRGt2gjdHY70P5RmbQxivOi6iDnqzvJgbsc74J4/ZtB1uR/e36zCwLKCPSaWxzduElcEpuQbHMuij16t4jqDFJllIgkFFCobCT9K84BYt0qy+iwUxce0xvXJyqAdy/Iwd/apfGtPIP/FpkBAItu8r9lpbdjGkaZoZxBWctCpspxF4udd5ln5MnQLU1Y/r2i+c7WdeImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEiu0/4RXkt9aL4B/ncwEmmSWhdYGsaEoxDpzpDkp4o=;
 b=jzsaIc/5nSAILbK5TTj2Xp32o3B282/uH0DI+DBef1Ea4V5oL0kEeGmrOCki8CzniRPAR7d3GG+HOErLUWSXtVuYecdryRgakH5DDvrRazKxIrbi5ToxbkEi9lpWBsZ3rCwm3KQPXAqCJwjDMfXdWNm3nFQPsN+XgcYEkdrKLwswO9QWsTWQXAFYuw70sIqf9ypnkT+EG60tDgmDmV0z4OpUYAlcBq6AAE052gg316w1CdtqXVRJazFDMCe+kwvYK7QyztlNDWtPwMjPthBr7Sm76FrR/89cR8OWrqwKHOkndU9EIXULPiB49Q8cYL9WuY5iOw1nHREf8FDv/JhriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEiu0/4RXkt9aL4B/ncwEmmSWhdYGsaEoxDpzpDkp4o=;
 b=Mtb9INW+PsSd7yVGPYC9UCkDKkfDbq8+oUSzH5JsJVsbOdqGwVlvpaRzBzMWX2vA6/AFAKZE3kLnbc29P0p7tMiX18upR/ESb7XDQgKIKSqE+janHGDfpifnNTWCVAAInUg5zKqUQM5v2ryJfbcLWhLECaR/f7NuKj0TRvD6JNU=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 13:28:52 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::e6) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 13:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 13:28:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 07:28:50 -0600
Date:   Fri, 13 Jan 2023 14:28:47 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <Y8Fcj+BJuUJmK5sk@rric.localdomain>
References: <20230103205937.1126626-1-rrichter@amd.com>
 <63b4a8153d6b6_517412948a@dwillia2-xfh.jf.intel.com.notmuch>
 <Y7VjfRZlBDnHewAd@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7VjfRZlBDnHewAd@rric.localdomain>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ce22fd-8716-4683-d2d4-08daf56a1c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n77WNsJI6Mw3Xbnandelq9aPsycA6jac2WcPxTTFphSfEzb5HmUPS/hjfQBey0YatHFigz/TQd9cg7FEcBsdIusP3hqhTW66bloldAPQdMuoCtjdju42awAwZKWkXTkeWuSBPqjwhyFjFlu94YC+po15NFrJbUIbUuKntlFH8E9twDS892zdy826gLcxTQwTMB1K/vKw20qXQD0kOH+mxzDldMZmHubjvGL4uTCXExjBLUEN6vk6/8eWYPdEqngQ8VSE1lecTS5a5rG9i1imBls8Yay2tCwEu5+H2Vm62RreVxb9CMzzpxPODXtIGbwBFowfMaHzCEMZVv4iAsnixweAn5dWj2IEq5IhcBhH6FnEZ5UcMXSif9jHWdS5R3uArZqhDLIc0nAnW27xPZhKrU7m4HfxaCdrbHFG+MCBmZkWTwxRDDauTGC3RF7ph6BzgGv4JiEvxnQscX/ErLXgIoY2HMYVbA+Wft96W70RgibTQ1H4+CEiCUOGRkhhda/1lQtRJ8nPlvsd9vvHKvMmBs0KZf6u2d+3ku+oThg/mCQWPVkf7GX5VxV2cydV1mtmb8YulbOklSLQLPGwb2p5VnFFKdERL+IBnuDUeLsNcNzlNO8r9kYKw2Hn3HJFmvlp/QJyP57vFh7DV2HBZGWZsW+eqN4KNXVkHgNUyPFUDrrltEKqND6cNtLm1T/1+JdauzZW8sB1T2kyTxx5yO3iS1TlVg3Zm/kRDqvbSODuGbJjbCymcbVX4pxBYvqRWFjSrfN4jCM5U92YYYeTcLb1eJqQAWltHQPd/Sp1RltiBwA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(54906003)(2906002)(40460700003)(82310400005)(36860700001)(336012)(83380400001)(426003)(47076005)(186003)(966005)(7696005)(55016003)(40480700001)(316002)(26005)(81166007)(53546011)(356005)(82740400003)(9686003)(16526019)(478600001)(8676002)(6666004)(70206006)(70586007)(8936002)(6916009)(4326008)(41300700001)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:28:51.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce22fd-8716-4683-d2d4-08daf56a1c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 04.01.23 12:31:59, Robert Richter wrote:
> On 03.01.23 14:11:33, Dan Williams wrote:
> > Robert Richter wrote:
> > > Commit 2aeaf663b85e introduced strict checking for variable length
> > > payload size validation. The payload length of received data must
> > > match the size of the requested data by the caller except for the case
> > > where the min_out value is set.
> > > 
> > > The Get Log command does not have a header with a length field set.
> > > The Log size is determined by the Get Supported Logs command (CXL 3.0,
> > > 8.2.9.5.1). However, the actual size can be smaller and the number of
> > > valid bytes in the payload output must be determined reading the
> > > Payload Length field (CXL 3.0, Table 8-36, Note 2).
> > > 
> > > Two issues arise: The command can successfully complete with a payload
> > > length of zero. And, the valid payload length must then also be
> > > consumed by the caller.
> > 
> > Perhaps this is confusion about what the "Log Size" field of Get
> > Supported Logs means? My reading is that the "Log Size" field indicates
> > the data "currently available" in the log. Correct me if I am wrong, but
> > it seems your reading is that it is the "possibly available" data and
> > software can not assume anything is available until it actually goes to
> > read the log.
> 
> > Are you sure that this is not a device-side implementation issue where
> > it needs to make sure that Get Supported Logs indicates what Get Log can
> > expect?
> 
> The spec is not really clear here and I have seen a CXL device
> firmware implementation that interprets it like that. We could demand
> a firmware fix for that, but the kernel driver would be more robust if
> we lower the strictness here.
> 
> Reading the spec again I just found that "the maximum size of each
> Log" is mentioned in the description:
> 
> """
> 8.2.9.5.1 Get Supported Logs (Opcode 0400h)
> 
> Retrieve the list of device specific logs (identified by UUID) and
> the maximum size of each Log.
> """
> 
> With that and the note in Table 8-36 stating that the exact payload of
> a variable length command should be determined using the Payload
> Length field, I think the commands can return different payload
> lengths.

any opinion here? Looks like the device may send a smaller payload in
the 401h command than the size given in 400h.

I have sent an updated patch last week:

 [PATCH v2] cxl/mbox: Fix Payload Length check for Get Log command
 https://patchwork.kernel.org/project/cxl/patch/20230104202954.1163366-1-rrichter@amd.com/

Please take a look.

Thanks,

-Robert
