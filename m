Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EE71413E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjE1XuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE1XuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:50:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0030BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 16:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZTJxzNl43iMrQfcZB/9ev1NnDtIxS32gSXosMGJzDlb4HsV20mN4kPVFhVH46SKZLFZX1lhMGoklSdzjjzZQa4tnerqrgqM9tbqVazqIykeuTfdtyFU1X5FLvA1CnFtrYIVmMBmbKmNj2qavSB75fIjTenwP8XYLTpEX+rwcG5tzH7ezsnRmionObEK8YvKllATdSa9h8ruxNlFSWfhGldxh4OP2v+bJDMABUx00a0ycVSYpJalboyecrSCw0FfxTSoXl3DouxuBS9YUL9X+bkYioZUuDa+CogiVOl1BHhL4EsBwa2QfZG7yfbib+j28qpjY4YsoB4WSmVaa1U9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkL+O0eOhzYMOCHQBmQj0cdLxPQ769MfUmuNSvjN6j0=;
 b=cUaKdvn+zqULTEXKHM/hKljqziEkesWRrLq9/SEvJzRc+9klBrlyxfRxlD+YIqjdqBl58T/qFOqpDCuxqwpIsST2I+7NYpSsxdGtR5rDI+piEmOCLf1PQ5Qz2gbJJD7Iu/AzqaOoB2oaaT6XBz8uIiwRio6n87qpC8okKY9Fa1ZW6ZNrbzP7IbFxEAVcbhMaSFjxDQ3z69Hc2oUeb3+54j81mMZGkztRvHN9+5BvnVjH5xi9vyD/rd5dspHU9Sc4WrjRheWE4fA6eFDdykoXOC4kYteJ92dFGoaKOrQUKJRFuLytp4PldJ8TlDVbKLQ1N+wzSV+sh51AQpV0+R7uaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkL+O0eOhzYMOCHQBmQj0cdLxPQ769MfUmuNSvjN6j0=;
 b=rYqVIbhzpY/TTj8I4WTvffv3Zx2rLu+qQhj7+HHYSp3nW7wJSTza3GuvEWBDp0L+7KMBeUr+ZDLDCtZm3OmS1wVO+mIK23JcT1yQOqvtRG8nkCQGn5J5EVXqmcYdqGhwNCkSAUBjTweZ9xfSPuZP8cM1BzunikpiGET4ewn9DTTQWkCF2KRCwLevo+egIWJdKsEMHAn6yrECpBrZRYmwm01WMZbq5fQeezPBmYTIMSCiJmli2zwKbJTBJRbcEISydnuR57pmsyLgqMlkZA3VLOR7Hgs8PLKOhZjU9cnYijKhhTYJw7GaBufdyuAaCPTQttxOYg5Q7+pNUZrBiIts9w==
Received: from CY8PR19CA0014.namprd19.prod.outlook.com (2603:10b6:930:44::19)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 23:50:02 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::4f) by CY8PR19CA0014.outlook.office365.com
 (2603:10b6:930:44::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Sun, 28 May 2023 23:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 23:50:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 16:49:53 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 16:49:52 -0700
Message-ID: <9821bd9c-7c30-8f0c-68e4-6b1d312bc032@nvidia.com>
Date:   Sun, 28 May 2023 16:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <mgorman@techsingularity.net>, <baolin.wang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Khalid Aziz <khalid@kernel.org>
References: <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
 <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
 <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
 <ZHF2byaRlaX3W6Md@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHF2byaRlaX3W6Md@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb9956d-6a37-41f6-64d3-08db5fd64076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOKt11gZ0N7NAgrRUHpFT5RS0/HEv2fcy3YpJpSVLcPwlueVb+zE2f4wuWxIjWx3ONYT3hi+v5v1foTqtXMjb6crPZjwjyFkUINMLbQ1uE7T4gkltUANBsZqMbOspz7+2hSjpc+pHdxgp3+18xQrHNru0Njokf7Om0D4nE55Rg8bX/ZdmaJ/t2phE0Y3HjWZAhplIkU+J38aPJQ+d0PNbWxcRgq0+nBX8LyuzpJPI7x+2hAQB89yz13ry4ChiCG/GzELg077KaxbJGdtcQ/K3MmFeBFfdy+JYZi+oNB57LTpOXf/ciqrX8GxAqpALgAThCJnVQ+IhCXXrazFv2Ybkid/+UG2UI0DgHRKAmiG6gvBVJ0v98r+UYx+7fgoM9OA/7BNRp+QPbCONoZI0nPXT17o9cERU8LtaXI9RJVZkn9jj+6Ol+PCLC9ATt6FafrIQE9qrqLl+bb+f4nbW9IdJYSbBy3NrCxR2L/C/DkDYHS8TRvI7K/t640WYoCMa4lwTDm+477bivsbB2RyiWiX1S18s0las6/HQ6P8zDKrhrPYqbr6fMsZmwrh+OZiwh0TYr5lB0zEu4KV4Xc8NQAI+J0gLQPYJ78ngHV2rSDPSXUycEJh12ndP9Z+V0+PX8WeM5O2LmPwkfk2qVQW5yl8pEltzeU5UMhhc4H5gML3wRWRrV3RxvNgqssRx87u3t+Z5UpwQWur7KLUXh5x2CDXBEeqMDmO97ah4BoF/uGhBGlRsAB1r6zym/fZcpKUcXk+vedBcUU2HlMsZhdJ5I1OPQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(83380400001)(47076005)(5660300002)(316002)(70206006)(70586007)(36756003)(7416002)(6916009)(4326008)(82310400005)(82740400003)(31696002)(356005)(8676002)(7636003)(41300700001)(8936002)(86362001)(40480700001)(54906003)(53546011)(2906002)(2616005)(16576012)(186003)(31686004)(16526019)(336012)(426003)(478600001)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 23:50:01.1104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb9956d-6a37-41f6-64d3-08db5fd64076
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 20:18, Matthew Wilcox wrote:
> On Fri, May 26, 2023 at 07:11:05PM -0700, John Hubbard wrote:
>>> So any user with 1024 processes can fragment physical memory? :/
>>>
>>> Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().
>>
>> I was actually thinking that we should minimize any more cases of
>> fragile mapcount and refcount comparison, which then leads to
>> Matthew's approach here!
> 
> I was wondering if we shouldn't make folio_maybe_dma_pinned() a little
> more accurate.  eg:
> 
>          if (folio_test_large(folio))
>                  return atomic_read(&folio->_pincount) > 0;
> 	return (unsigned)(folio_ref_count(folio) - folio_mapcount(folio)) >=
> 			GUP_PIN_COUNTING_BIAS;

I'm trying to figure out what might be wrong with that, but it seems
OK. We must have talked about this earlier, but I recall vaguely that
there was not a lot of concern about the case of a page being mapped
> 1024 times. Because pinned or not, it's likely to be effectively
locked into memory due to LRU effects. As mentioned here, too.

Anyway, sure.

A detail:

The unsigned cast, I'm not sure that helps or solves anything, right?
That is, other than bugs, is it possible to get refcount < mapcount?

And if it's only due to bugs, then the casting, again, isn't likely to
going to mitigate the fallout from whatever mess the bug caused.

thanks,
-- 
John Hubbard
NVIDIA

