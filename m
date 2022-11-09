Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAE622DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiKIOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiKIOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:33:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734C278;
        Wed,  9 Nov 2022 06:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odDWdPj2P0/sB+XmILtX0guIrMk9lBEUtq6fpz9wkkBkUMpndwKtmwt5r8uolteSgfqmK++LSLOpDBMjSMgg+C0HuTtRFDYAfWCSF5DbYvOfdryU352RPL/S9MaXJ6VoJ/w5tCzjC2q4fGD9bkM+vP7x2ho859Ci3hwB3IzQb+FqbBMcgbbeSZTGhHDVjHO+s9AkSLMyikynybSXaiyp209bqbmI/0tSXC06CJO2q1Iobl8D6sDXNw0Fq7Ijolb8Db5cCghXHbh60xuzc3Fr1Y7q3LuG0nO8K+LYOaIEkvA4zRYiPbV375P/cH+jfs6DZSGJlO03H7Qs5ZKkDFnfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKgQ6iJyANVMJgIf5TzSYl3F1CQ1ZNtBrS76tEfr43A=;
 b=UvvhU7pEwZkQA4vaYagd4UeePd+ILOaY6VzOs0Lxo2g1UfzEV8j0GLMy01NEZrrw5lGF6/7BAD/FdUAUCMD+5fFzMCPz/5ezTA1rQEoVuEMm9yiFoghXJZEbB9ldh89k2bsVZfIfjp3HSbKsSRxcZmIHyeNziuaCMDv5cnHvTUexDbqoA2gev9Y5QrE3nUmc1hYXXityXh1Z75KPMo/jndN1Yb7yGOkSQ6+hBxhBKdMHTvrbzXIeHVFkqEJXVSe3lnLF0aI0s31v48BMDkATnUaB4fUQtCqUg5F5Wp110enMen5H7O1B4suxXrnXG5u9cX1rUBJgr/sajNRFkp15Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKgQ6iJyANVMJgIf5TzSYl3F1CQ1ZNtBrS76tEfr43A=;
 b=UoIxT9buvPMbfvUNT/1Ms1fy8GllfUAeHt1o4iSfpxKbQ4Cd8Cn/MrCmsij66YFm7ru+qYJS6aNrnI/QYhnWIgmd4z72Ftk60EtsdlsqrcP7qkdrsYK51ZwHWuOjidsnTOr/CB/LEHn2yVdpL/7vvyiK+tQta2ykNFTVzhObxIk=
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 9 Nov
 2022 14:33:23 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::d6) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 14:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 14:33:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 08:33:20 -0600
Date:   Wed, 9 Nov 2022 15:33:17 +0100
From:   Robert Richter <rrichter@amd.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH v2 07/12] cxl: Remove dev_is_cxl_root_child() check in
 devm_cxl_enumerate_ports()
Message-ID: <Y2u6La0znt7Jky9D@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-8-rrichter@amd.com>
 <6352303b266c_24ac29423@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <552e105ca749fae4517ef053b0439cb3eecd1e4c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <552e105ca749fae4517ef053b0439cb3eecd1e4c.camel@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 197573b0-56b3-4096-6b7a-08dac25f5b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWsjtorf6nYg5cP0+N4cuTNY2TM+gOXluZXyJuktpMEzGJt/4MBzOqLSPlOECK/uEmRXGLA+0+8S1hddRPbAbjkR9TAI/qbzUQFqF4TTVGJ3p4vKtUneO1ObALl78NxwvSokIAT/F4rnX7wItjBfRMvVpAA5yGwJvgBZ0jkN9sviQQQx9Y+Hcm5TZKJdV86zOcIsRXkALo+l2n6nU6WInrOz/QBeBNoTGp7s886xOXT3WfHytUE6jUG4Kk6CbcGSxYb7ncCl8YMy/H7lw7vwI2PnPWhry2O/RNn6nU+kgwB/hrQepQ2Ix0UxwBzVT7rjDhLQzfrU/9+2Srz5y6Uwvi2+mBVqovyeHDcsxReMxyXtl8tny2aPSQ/TRAX54VFR6j8QPcMO5apLoIAcbg73QQDmb9p39YzC8+qdYGXSKLaWgjdUwNrE7ZYsgD06VaitvaC4uit5nHhA3rWIGtuvXMvVtFpO7oNuEKdi6ULD0AMw9YkeKOIJ6DP+0yYp+Qmk3grD7SyJxoi9vTAMWToR8q2B5KNsH70b8No5iP5CU5fT285wFFOcnUgmczEW04mIXmKDFTqlWJsCkIqH8848P3MqVYVc7pUSLjLF/MTE9c7WR7EUqaIrl1q0Dyr7v0jhOsmZ/zlH5nbybpeXfbYn3V1lcOMznuiEx0h3P98uGwknPhbJU500sIehn42Bd/t9s2+TCHBYIa+S405UllxHi8rRHG5GrUPGfK0P++rkLsgcX66urK45MkPnpTkSQRDzBaAFDUX1rqjmM+qC/yp7HJ7zkiA0OULtgM5oH4ehVyJAfjFhivcp3hmkSALmluUFT/wa9+dRqPxMB5YRwwya0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(4744005)(82310400005)(7696005)(70586007)(5660300002)(7416002)(186003)(55016003)(426003)(16526019)(54906003)(47076005)(41300700001)(6916009)(8936002)(8676002)(966005)(478600001)(316002)(36860700001)(9686003)(356005)(336012)(40460700003)(40480700001)(6666004)(4326008)(26005)(53546011)(81166007)(82740400003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 14:33:23.1775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197573b0-56b3-4096-6b7a-08dac25f5b27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal,

On 21.10.22 06:32:33, Verma, Vishal L wrote:
> I was waiting to post the cxl-cli patches for this until the kernel
> discussion settles - but maybe this topology layout is settled enough?
> 
> In the meanwhile I've pushed a branch with these fixups here:
> https://github.com/pmem/ndctl/tree/vv/rch-support

I sent out the v3 series today, patch #1 contains the change of the
port's reference device. You need to adopt the ndctl patches for this.
To find the alias in sysfs, you need to lookup the firmware_node
instead of the physical_node. I would suggest to change the
implemenation to just check for both entries.

Thanks,

-Robert
