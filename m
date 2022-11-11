Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5E6259EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiKKL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiKKL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:59:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EDF5BD71;
        Fri, 11 Nov 2022 03:59:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7j4r+KF6doDTQuynfvVGS5k/69JxOm7/sJFQ3xbQGe1h1CfF63LLPRztM1pEekrrWs32nR2vCyLR3uK6fBphiFKiLSJ0ovAvRUgML4oQB6Rwsn+YuejREUMrIhdYp8tpWCCFqDcwClDH9Lxfv5THmL4ubruEoQoveP0nwrsLC9jSga8k5OMZuZyVLF0zKFaUxUCkJINXZV0C4MR+f1BBYrhltlRz6aFuK2Tzdo2D+Yo7GcjZTmgqIlzqQN9rRIdnrRz40ZnVUT+qRuUfDbSPLQzE0fw0aPheyG5ClFRRbyuoHgbaSDrzXIMjfe+K2FklqkD6iVpis92C7kuoeYVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV1M0uoYqeTIeZMPfzYYYt0ZEvY/0CvXTkumUjpsR8Y=;
 b=bgXd8p6keke1yuLdQAnmpj9qlkn7GasMNVndkWae4xsNoff7YUl9qQyqzX3dnhUCffnGzqBxmvj2YMt6G6gBM1wnuTqF7hj413wFqMucnrhl78RqG/LHQweJx/WlE9HSm+hjUqCdrWtfnWNCbgd9LlAD4ufEZ1jGPpqwnqxTmHnSsZjK/lvTz2SkXFXbw/LPec1aBu8vD5qbjCSQDd+4zJai0GYeo/T6jbPiLGAOSIbayIVFk31bxUQjFakxIyv6BhPRpCeQHktoB/tr4xbO0GxE8UqKLdS7yE4JTomkyFQ46zFiliMWXwdPC9teUmme6/M2/DuzQzTJ4akrMpGPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV1M0uoYqeTIeZMPfzYYYt0ZEvY/0CvXTkumUjpsR8Y=;
 b=aximb0qi4I2dd1GH9odHoIy/KR167oaSkP8rNWGWIN+fg62e664kO7lEOaSmifJpOaMqlkOVNNBRLgSVouZTBPCrOojnYK7M0q9D/PTqFrTUt0zRERdfQd6/3uH8LB4m6X0/maqIrKHl9udDwEeRWTcsXlUrDe7LRwTzyaCn+P4=
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 11:59:50 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::57) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9 via Frontend
 Transport; Fri, 11 Nov 2022 11:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 11:59:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 05:59:47 -0600
Date:   Fri, 11 Nov 2022 12:59:45 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 8/9] cxl/pci: Extend devm_cxl_port_enumerate_dports()
 to support restricted hosts (RCH)
Message-ID: <Y245MZXYbrgG2O8I@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-9-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-9-rrichter@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 780b5c83-b5e6-44a4-bb23-08dac3dc3cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCpsglCkl6jhJpURYHDo7PBNXDfkfL/NvUhxbaVYkM5h6z7MURhYv+2DKoTOwtR/vCZf5OumizmmqAtaPAuE4Osy9DPFgl9zSKfkusMFs0BAlID2RSXzcQZSCdaGq0wbWu4uo5laLcMxt3jA4lhGFW4ub9JryieKCQd+eVRbs+kPURNQaIO/ZOEMgLGZejeG5/IC1+oIwckDeYybw+pLrGCvhKVIonfJTovynKLdVlm6WNAxM6Pfzw23Z34Q1K3phNCWwE5O4RdQQELgm3yXeNTYZ36rXJ8s2fVwqRtDtV96gXq8wXvc8i/Y2JyVHZW3tn2V8i+ltVOy38iH9bP1aXx5u4xNKCLvgbXvV6AMWeHMjzFnTSa/ox3OJUY8NY0Zz+Aku20fmHvwZpq/rfrvsP5OtHPmjG2eIa4p/ghy7nYBdulXCDCYhBiiMsX0OsBAEzWLDDZqJTRhsrdWhw0wev71Lt1uTczCjhMoiB+Q+dTZvAMCGWt1TqYOmPKGIihv5a3CyEOSUU9GXumv6aWolcI0wX3pQDkJiQcpJ5V7ghERrRso/8nEKhY54HDN3K6whbSRBm61CKSsQh+H7TuQFOutoeL1+uEZT58Mvq6ZpxLKfYp+s0vigDNjOlTKPcAfGu6gzS4Xq+3BhDlOlEuIerAjBo2XHlpbFbryOCiaktqd5ikZP/sQevtn9qEDKnsaxaLaxeUFLCovwzVL9jLGvut8e6UCpJVRMhgubsDqUBeOVRfGSzIb2ATAOvIQ3jWM/XJAmlRF8s5hZbznR8vbmD1Ki6JEo7KW6BSjIwZbOeGfssu2t2djqRlfyOR5pWZ8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(70206006)(4326008)(70586007)(8676002)(54906003)(356005)(316002)(82740400003)(81166007)(110136005)(40480700001)(41300700001)(36860700001)(5660300002)(7416002)(8936002)(83380400001)(2906002)(478600001)(40460700003)(82310400005)(186003)(336012)(426003)(26005)(7696005)(9686003)(16526019)(47076005)(53546011)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 11:59:50.7309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 780b5c83-b5e6-44a4-bb23-08dac3dc3cec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.22 11:40:58, Robert Richter wrote:

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 667de4f125f6..a6b1a1501db3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -48,6 +48,37 @@ static int pci_dev_add_dport(struct pci_dev *pdev, struct cxl_port *port,
>  	return 0;
>  }
>  
> +static int restricted_host_enumerate_dport(struct cxl_port *port,
> +					   struct pci_bus *bus)
> +{
> +	struct pci_dev *pdev;
> +	bool is_restricted_host;
> +	int rc;
> +
> +	/* Check CXL DVSEC of dev 0 func 0 */
> +	pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> +
> +	is_restricted_host = pdev
> +		&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> +		&& pci_find_dvsec_capability(pdev,
> +					PCI_DVSEC_VENDOR_ID_CXL,
> +					CXL_DVSEC_PCIE_DEVICE);
> +	if (is_restricted_host)
> +		rc = pci_dev_add_dport(pdev, port, CXL_RESOURCE_NONE);

See my comment in patch #6. This reads the port id from RCiEP's PCIe
cap, but instead the RCD UP RCRB should be used for this.
pci_dev_add_dport() needs to be updated to handle that.

-Robert

> +
> +	pci_dev_put(pdev);
> +
> +	if (!is_restricted_host)
> +		return 0;
> +
> +	dev_dbg(bus->bridge, "CXL restricted host found\n");
> +
> +	if (rc)
> +		return rc;
> +
> +	return 1;
> +}
