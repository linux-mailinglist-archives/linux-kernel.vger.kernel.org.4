Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C707A65D173
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjADLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjADLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:32:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC71CB0D;
        Wed,  4 Jan 2023 03:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB1gvyHf95qNyHZ0s6yLv+/Ahgk22Mv3KQN/QadIbPMrspt4bq3RZhtdw44kZzfbzZsG+HU8Al+2v9UOaXPu6m2B/k3qObzWMdPGjSgPOPAnegZoK4Pwe0ipPB00M6n9K51WBT1fl8mlButYixKCH81FDZgdSGbrZ+20icZR+ZTJ2P4aEBuMGUz/YQnQ6yBJjCj5XP5079/ohDS4/Z0aXbvPfresVl9nOG/zka/YJx+lvW7nU6cQ6ZDrawBJuoDkmjWWdfOwRXVplINBRMggFQDk71LGkfKOnCrFKxRqJ8oNnHWag4pEIn8fhBAGY6DImFuS2vHWhi4g6bO8ecDtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj8svkgadGD3Qb5rIuQGbE3/MZsTBzkA6baTD1+gcjE=;
 b=jdaDb6a9w4duBU31Gs9KyPazG7rMEoPKE0z/T9pW3OrUTISjnOtK0pycNXg8zlc3aOOwSjyGBaVkIwEyMoTnbVuI/O6l+m+kh6zbroZBmxzk07nrzZjs/4kusuxV6AbkAqK/PDBCg6MC3aZc8DMbsMZHMc8ZGOkrvT5zi4MAQ8bodsHpl9BwrnMgPF8LkySiSMTFMb4oarlMA/3qpQRgVicvKgPFb1h5Ml3m1ktH877LWsLqTAPrU93aGol+fHSDDWUYKUqKOEw9R7lUWOayWaFnhds+Oy8M2USw3T9xAcOAB/KmrM4fW+jjtI9v3R9EcaCjUAJxu/1pxHCVx6U/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj8svkgadGD3Qb5rIuQGbE3/MZsTBzkA6baTD1+gcjE=;
 b=mQmSa0rSQ4u7zs6FfU/4MsCxGQSxNFDq2hYIuA2KHFWOd2BMfuGpqKz4wt3+F/EKMp2Hizc+EQvKEU2AT2ihAjKn8wsUQEyPM+n/1t2/3VRwKbA7+W92t/OFsX/5ChmnGTCF7OPKaVwR5vZPJFBcDncWCxew1JqAQ5qQcanfqlw=
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 11:32:00 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::c1) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 11:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Wed, 4 Jan 2023 11:32:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 05:31:58 -0600
Date:   Wed, 4 Jan 2023 12:31:54 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <Y7VjfRZlBDnHewAd@rric.localdomain>
References: <20230103205937.1126626-1-rrichter@amd.com>
 <63b4a8153d6b6_517412948a@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63b4a8153d6b6_517412948a@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 19883057-fbdb-43fb-e881-08daee474b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bHYJKs9sjkbqKJ0c6POhXzoxJZ9yDRj0LQ+HqMuCaV3But9ea9snFezToQYMwisanSuDsX1ASxe4fVDUU3kh/SAWFKGABiDE0jLl1qdnvPZ0azo7Qxpc2cN5X4/S3/+8mAcgcDeO0JHL8EaVofwva9yGcCiM3xvvUpn/ZpR6fvuAUWzUmRi9iAYrBsoRJuBtI2MbmIBwXdKntoOJfeBmqTmc0vBLkIbn+3rEYqrhKJVyiijGc8TbiceX+HjNRi+o3PQsws7dq9Uag7JmIpheQkG8p5Si4LUXwXCG5Ww2j7cbTtQRcO8iGyremDlE66vyHdiTe4eT4mHA61YKAM7M5FgomqTJqybrCmH0gJkd0zWyrSHkJef/Ybo4yNMjAVtUBEDxzUszC1O6yzAASIWigAIqHWmt4dSXQbw6WZNw4Ep6FrEf8dF5LDvyhJH+JOAg25mZ7r47uGtD6MX1Ah7+d64Xszv+MoqYwvQKN1ozyPnRweTVId2G+KiOK9gE/j9PoeXASxamWEq81TkgRNmVUKfjBIj8uV/37OUaPDsBTa1hQJePLY94zfPvNU+LaR/adXo0gfxL+WFIgAE7yJgl4DiBbxsCQl4VpGET7JtfW6oukU0tZ5CKVL9Hh3ShhTpb3mFzzzFvF5BEdIDOxQtXG/AUaGUJ9vn0SASOrNhbo4vzKYGioFnZA/s56qz/yfT+hW+L61Sq2ckWPSezzEBA0DvDgcLywi1oYK8jFbhPHg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(4326008)(41300700001)(316002)(70586007)(8936002)(8676002)(54906003)(6916009)(2906002)(70206006)(6666004)(7696005)(9686003)(478600001)(26005)(53546011)(186003)(16526019)(40480700001)(55016003)(83380400001)(36860700001)(336012)(426003)(47076005)(82740400003)(81166007)(356005)(82310400005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 11:32:00.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19883057-fbdb-43fb-e881-08daee474b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.23 14:11:33, Dan Williams wrote:
> Robert Richter wrote:
> > Commit 2aeaf663b85e introduced strict checking for variable length
> > payload size validation. The payload length of received data must
> > match the size of the requested data by the caller except for the case
> > where the min_out value is set.
> > 
> > The Get Log command does not have a header with a length field set.
> > The Log size is determined by the Get Supported Logs command (CXL 3.0,
> > 8.2.9.5.1). However, the actual size can be smaller and the number of
> > valid bytes in the payload output must be determined reading the
> > Payload Length field (CXL 3.0, Table 8-36, Note 2).
> > 
> > Two issues arise: The command can successfully complete with a payload
> > length of zero. And, the valid payload length must then also be
> > consumed by the caller.
> 
> Perhaps this is confusion about what the "Log Size" field of Get
> Supported Logs means? My reading is that the "Log Size" field indicates
> the data "currently available" in the log. Correct me if I am wrong, but
> it seems your reading is that it is the "possibly available" data and
> software can not assume anything is available until it actually goes to
> read the log.

> Are you sure that this is not a device-side implementation issue where
> it needs to make sure that Get Supported Logs indicates what Get Log can
> expect?

The spec is not really clear here and I have seen a CXL device
firmware implementation that interprets it like that. We could demand
a firmware fix for that, but the kernel driver would be more robust if
we lower the strictness here.

Reading the spec again I just found that "the maximum size of each
Log" is mentioned in the description:

"""
8.2.9.5.1 Get Supported Logs (Opcode 0400h)

Retrieve the list of device specific logs (identified by UUID) and
the maximum size of each Log.
"""

With that and the note in Table 8-36 stating that the exact payload of
a variable length command should be determined using the Payload
Length field, I think the commands can return different payload
lengths.

> > There could be other variable payloads commands affected by this
> > strict check, the implementation of GET_LSA and SET_LSA in this kernel
> > could possibly be broken too. A fix of this is not scope of this
> > patch.
> 
> SET_LSA cannot be broken because SET_LSA does not return an output
> payload, and GET_LSA never expects short reads.

Ok, I haven't checked the details here but thought it is worth to
note.

> Now, if short reads need to be supported on production devices for any
> variable length output payload command, I would rather see that handled
> as a cxl_internal_send_cmd() special case where mbox_cmd->size_out is
> consulted when cxl_internal_send_cmd() returns -EIO.

I will prepare a v2 with that change included.

Thanks,

-Robert
