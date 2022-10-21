Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668C0607325
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJUJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJUJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:00:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4522C4D94;
        Fri, 21 Oct 2022 02:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAFrXSFvZg+6hN4w0yxDlxMxQPg5YwMvpjRPVBxyzBwiOhTxmd1P4MTDYF29A0rtRruYy7osss1mAAnrY23wqBd3U8h99Ycl1xh3PsvzHAsf5v7X+It0mjek+t9cl6oU9Tig9kmeXIYiD27ZTcrf4MWxzz9dOVUVJSFQnno7mbsBEOrYNfUMOwlvOG7XLdr+RMcZqWUJj+2os7t9nP6oapjX9Mpvfi4nfMf0etD/BPJt20voi8pvr9/pACWnMmDR6Mtk1U9WLqbKPeyl4PCJmjRndS+CG6NdgrG4QfXsiHZbWMI17vNxyn6vweGCTnELM6qVutp/y0NfHPjZAQ7QMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgFZKHnVmrsxJ5kI1YvVoQay49t97/do1+G7pWsToIk=;
 b=eumU6p7jESOF6F8zToSl6H4TuGdZuAQLtyxl4RRLvb6xRALK+UaTv18ZhgsPhCxfxXcZ7Ii6ogdwm5O1FIJWQk4NMEB0LmHyKbcG/UA8yfQ42sFHllrskThSqeXDU1jBqljgACv+Oj+hzLdud/573Wk/by2kJDWa5INlSrCqP78eJubcAWIKpk8ESRFFqvzea0/WJav2vH0ZUFcV8/1apCmJo+tiGhdpsPxUEDdQN9tpEGim+dcS5uxZVcLfHspgEvAOFZN4IXi0/AaYEbnJkn9cQwKgiqdhUtKp+rW9lOb0i4OU8LuWMqd0TWX1oAhB+/+jSLF/NRn5Mwo4bXZoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgFZKHnVmrsxJ5kI1YvVoQay49t97/do1+G7pWsToIk=;
 b=n1eD3hshgBmQMDghhENVRu1EKJIjco6rD5rrda1V3SD3gw4FNsxblmKcnKmO/CIbHCTeRDEV7SmclFdb3yEZOdEkHJje4wQXobn90XniCk8viyeFqLnT4KAEQ2KIHzwMcsbJ6OKx1sH6YJw4JOEUg7Id4uqqABNrJdh9xkiKsS0=
Received: from BN7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:20::42)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 09:00:14 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::1) by BN7PR02CA0029.outlook.office365.com
 (2603:10b6:408:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Fri, 21 Oct 2022 09:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 09:00:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 04:00:11 -0500
Date:   Fri, 21 Oct 2022 11:00:09 +0200
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
Subject: Re: [PATCH v2 04/12] cxl: Unify debug messages when calling
 devm_cxl_add_dport()
Message-ID: <Y1JfmXH43ODfdSFs@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-5-rrichter@amd.com>
 <6351e8bac4623_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6351e8bac4623_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7c063f-eadd-44ba-1680-08dab342aa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tAjRdMxEQl5eu3RwgpnCWxK4I3TrqvTzU//phHIA6h5cxks0ph9wjypeYlo9EGeME2k2c2UEKe6lAyQCwhP50AaFNe0sQZmYy64ZPVOPjYz5W4p0GcqS7wH8VwwEBloxS3aiW9nt7H0IYzZDpd47t6QVkZrneCvIbKZv4N0E83SBB/u5JRMGaxPi7HXGA6jLnHrMuRfSrXSjZq1mq7eB4QHIpSym6EbLVIU2zQcPvXH9CuEDuZYvGys3uhf2iLg4QbtYgKmeYCi2HI7yN9ooUxwXmqYRiG7suVMY7K5a/lIdWGFmzmiJx+9ewksY2wK3qBZeQ7uIFRZzH/l8rSZusW7v4DBQu+u6rvLl8PtJc+72zc+RI3IXOiqLzGoUc5hIHp4gRk59dOq+OkenEEX/BWtVuwO+xGWxsVeqrvz7afn8tSMEwFByxsnxW6/7gUWtBvJe/jJRZ1lC+aOn8b75o97R+HeqQbqmyt5270sIik7iR4OLkJV/laqnJg4HwOh7ubpnWK6f5XldTQWiWhBPCUaEe0iw1DhpHZpLR1WdFD7vp+ULn6IveRTx25RZV/5CjnADNIN772iU2iDXR7lVnnBUfo0UU79dzYq0viN6EjnS6a2ljaIO2rS6I1J7auutsnDiYS1I8EI6ZZN0S2+Q3wBR3XLqPY23LjCwpswJvP/NMqWzQ8ide1wkXz4Ze7fQxsxCISBWa0Wh/1a9un6LKdQ8gqIrWtviw8xQnJeJIuGYxayRjRgn3NMcsysU0Tlf4tLzbygAPasEEPjNlTeayze5FA5RgDEj7eV109X0jDYGUPEmpVdWe1sjmqXAxO6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(7416002)(4326008)(8676002)(316002)(5660300002)(82310400005)(70206006)(40460700003)(16526019)(36860700001)(82740400003)(8936002)(54906003)(70586007)(336012)(6916009)(186003)(478600001)(7696005)(53546011)(26005)(47076005)(83380400001)(81166007)(41300700001)(55016003)(426003)(40480700001)(9686003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 09:00:13.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c063f-eadd-44ba-1680-08dab342aa87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.22 17:32:58, Dan Williams wrote:
> Robert Richter wrote:

> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index a072b2d3e726..c610625e8261 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -582,14 +582,8 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
> >  		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
> >  					   CXL_RESOURCE_NONE);
> >  
> > -		if (IS_ERR(dport)) {
> > -			dev_err(dev, "failed to add dport: %s (%ld)\n",
> > -				dev_name(&pdev->dev), PTR_ERR(dport));
> > +		if (IS_ERR(dport))
> >  			return PTR_ERR(dport);
> > -		}
> > -
> > -		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
> > -			dev_name(&pdev->dev));
> 
> This hunk causes this new compile error:
> 
> tools/testing/cxl/test/cxl.c: In function ‘mock_cxl_port_enumerate_dports’:
> tools/testing/cxl/test/cxl.c:559:24: error: unused variable ‘dev’ [-Werror=unused-variable]
>   559 |         struct device *dev = &port->dev;
>       |                        ^~~
> cc1: all warnings being treated as errors
> 
> I fixed it up locally, but just double check that you are building
> cxl_test if you touch tools/testing/cxl/:
> 
>     make M=tools/testing/cxl

Right. Thanks for fixing. Will build test in the future.

-Robert
