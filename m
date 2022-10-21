Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84A360730F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJUI5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJUI5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:57:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFC2514C4;
        Fri, 21 Oct 2022 01:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=letGnJ8kIEoULYO6puSlykPfqqTOmCXhxyhX+zcc0LtDfvuiUgU4iKRjkEJUgWDv081TbpfAYF3gRGq+1gMr7WjFA5kl3ULV+Yd2U3QIKnASJKqMw42zqkxjlBk2un6GUpdvM/6Ctf1xsiAN//FuqCcwH8EeK/zLi22TvAIKyKaqcKV9IgMXrTuLoIYNOaTyh5yVmHuNuFBG3vb65wDwuU8r/3p40dcgp8Hx/xExZR+ki0mrA29bk2sxykpDBO817aF5qMY09b++PB6UW2TAyJYj5bw8Ho3aQrtSE4A+NWg5l0NTfdgeFZs70X1ZBwDDUx9s6CEU5OhUXFlbWzT91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Tb+OK1QKLfqxE4dXPiFqgHcG5XejK/YH27XH6TENHM=;
 b=CO6QYxb73Qj4bNRFdckgGUZids4Fgz9oRrbHghCBF7xyXlNqkltjmEn4POSO+C/qi6TvihwWroR6ev6nf3e+eE34JpmX73uD7sTN2CGbb5e6NhzyA1RGZKQpZpLgx07iwt5+TutM7PkI3Jl7YT1cLj+h3shbkFzIRoacDfE1cQ/6ascbvmDM9LcYygAkRadirsSeIkGZ3rYLaRBkpgGG2p1kpBrp1gO58E+Ck+GRJVlRd6sTeQaf+K3jONxltL6CORBtq8dhmNGYrGXTnCVlq6OpDf2IbjQBC2YBJg1xf3D6VpUt0PQkZAosL1xyYS3uUXqcim9hFG10j7EQE4OWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tb+OK1QKLfqxE4dXPiFqgHcG5XejK/YH27XH6TENHM=;
 b=ldICHe4Ad7uShcK6N++7DNlAe+i2MwEeRUHT2HQ8EicWpZRXF56MEW6ByiBcSm3ji/ctk4+M1RKFyQsUTrFwxNPfrENQr94OBOz+fZ5cBwpQHosKoZbEcpnAu5klGh6G11isV/CxYkJ2A6CeqHgaMURsN/+cjBbkBUcCvIxXWCU=
Received: from BN8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:408:c0::33)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 08:57:14 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::9) by BN8PR15CA0020.outlook.office365.com
 (2603:10b6:408:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28 via Frontend
 Transport; Fri, 21 Oct 2022 08:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 08:57:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 03:57:10 -0500
Date:   Fri, 21 Oct 2022 10:57:08 +0200
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 03/12] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <Y1Je5L67RAfTohQm@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-4-rrichter@amd.com>
 <6351e5ba56f96_4da3294b1@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6351e5ba56f96_4da3294b1@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 5831bc1a-a99f-42c5-2880-08dab3423fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XY9ltZ4KwuLnGlgdgdhcZ0KTFNEyGB/AuPAHhjjeN8tEyzIgK3nxSrD2b7fcmLVXOxyDRawVCWQFrmsXofNVA8ZU53RF34fgdRC2h9mwVTlblrZBrE5O8tTXSZLim9fBE36yIpYfERBthcgUiOIJge0Ip79SScI78vuB/ipeBZyQ08hNsVJlq7kp5eJsohAt6J7csSzwpG3vmHyHT1Vo42s1zc0+gG3LaUaIJ2HunodxxX/I1l8BrlRI9ZghZduu85rlkNicopWkmW4+1KzbV5KM4VCvUdbWie0rZjKIAbKV0jJN/sag1LS2VmguTrPIP72lDQsp6QYzOAm7APwJP4j42Qe7ilfG7a6lDn/9r64oLcFgvhiYIqAfxBEalfhIpA4efMx83udxduV1jmGIzYi/YLicOXS1njtEKd1msl6DH0QSHv5w9NO0ODEM5rlWcvyR+4m1w5paylOQHEH1Nhi3w/g49tQkszNFf4JqfrlbelJTjpuM04hhsOpAGQpkn7eTYMKBzm2BSoB7uKFFEffS7SedtNjvGaKjvRWX7CfBVWGj9RhCJeGL4+A+HU+Wvq9orAUCP0P3e6PgtWy5DJ+xYirwaew3zK/A/MwepCc+VwwO9isdPw4bXgK/XfuQajIv9LxFCv1OkzX8mnyusTeXMWyB6Cq5dVoYDIryxIfDzFHxO/GA1mFqMVQbEjAKwTHsnqGNlY5s3ZXW827XsmvyTL2HFhKlS3M5ONoR219nGypOkfjF2vaCYrzMiV3q8pSYCDCTcdCbRA9ZtE28xWj8ezolgdXyD4jhrhKKK1vqC7gZA4EMrW6JOAdQOKMX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(9686003)(8676002)(478600001)(4326008)(70206006)(70586007)(54906003)(6916009)(316002)(55016003)(26005)(36860700001)(81166007)(5660300002)(356005)(8936002)(40460700003)(53546011)(40480700001)(7696005)(47076005)(7416002)(83380400001)(426003)(15650500001)(82310400005)(336012)(2906002)(16526019)(41300700001)(4744005)(186003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:57:14.3862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5831bc1a-a99f-42c5-2880-08dab3423fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.22 17:20:10, Dan Williams wrote:
> Robert Richter wrote:
> > CXL ports are added in a couple of code paths using devm_cxl_add_
> > port(). Debug messages are individually generated, but are incomplete
> 
> Hmm, devm_cxl_add_port() got wrapped in a few places here. I fixed it up
> locally, but maybe take a look at your word wrap to keep function
> symbols unbroken in future changelogs.

Ok, will do. Thanks for the note.

> 
> > and inconsistent. Change this by moving its generation to devm_cxl_
> > add_port(). This unifies the messages and reduces code duplication.
> > Also, generate messages on failure. Use a __devm_cxl_add_port()
> > wrapper to keep the readability of the error exits.
> 
> Otherwise looks good, applied for v6.2.

Thanks,

-Robert
