Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12B27131D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjE0CLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjE0CLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:11:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD19125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imw2iiFaLAKYgyUeJJSn9H1W88GSkV7IMSTzSqwBQGiWADanb/csU0IvwXUzoxnpHQCKXZCemhSvhP1f/kU2YNYsCD+eel3CEKiPdm7pWDqvXhwN5sn0xYH+hXbGWU6FTnE20bJ7HLERUASFlQrwHKSwh9hpszoLVkpLE/aELJtrDzbI547M3mWk6FnY78UnYL9rULoRW/vJwPNg8Dhfv81hC3qIlDx+Kb8W7UmHlg30sHJfKVLNmFPGwKeiwmbNYT5qsYyh16FfAnmbwL6HCXkWb4NxioNEzXTMpWZtoHg2k2FT8362RrjjkiySnWhpslYYzjcj5szeffoiUe1PVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Nsc4csPrepmhx0fAVjM7C2TLkrNTqpaodM6c+rmu2I=;
 b=Iz89r/sr6cK1D8mtgNDTNn9vSDF6ltu/eqiZyX6X+PkPD1GfLwz9M+X65X7zjpi+synm2xOGTg92QK4qpBaNddQ4T2vu7HySe9GzwB0hDuH3sdmqm2wdR9jb5VcrThF+N8HeJjpcsiv5P1T6H1Y4MdxqMcK0IuNcuLjl/uw+lVcbCgl64544hPp1OB/xSNIVN+W9Af71DpMSNNaSfKGdRRZ2IRPUsPWuOof1rDoXXfxe9XgttkXmns9qJnIutP7KK0Dc1oYOkUGHkE8eQtzUCxS2Zpv5vLZOgFyjaXfdzYY4loPH8+ybiqwOJxffcWuLYpqJpxcdbf2eZe4uOXciUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nsc4csPrepmhx0fAVjM7C2TLkrNTqpaodM6c+rmu2I=;
 b=kYy+lyf4KiDOEgti4477uWCCCNDApdcNxh0gAy28CMLdiGZaSX0tmuxEoCyZL+KxvhI1RhXHLRnCCxXsPONBjEma4MASO8F6Lq27UwDEZPu+8NZEx5C08BZPwNFjBNK0mc4kcqhdRPklnvoLn5AZWSLsvwlO9bwMn/pdJ7Jc8l8wd+i5nwWNKVZiig7H6JjrkLedl6ooo3I3aIYYFBjaK6mE0dWevLfIEgNrjrwwHE3J7UiWXTZxnd5lfnHCR9t6UhbYJqsWA0/gNnNcCAslAWzUP4iCHOmwSQK+5xjf/8GswtuF3DUmR7u/Ko7lQwiUC11D5C+x2Bg8wDjxI6+tXA==
Received: from BN9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::30)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 02:11:16 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::35) by BN9P223CA0025.outlook.office365.com
 (2603:10b6:408:10b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19 via Frontend
 Transport; Sat, 27 May 2023 02:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.19 via Frontend Transport; Sat, 27 May 2023 02:11:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 26 May 2023
 19:11:06 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 26 May
 2023 19:11:06 -0700
Message-ID: <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
Date:   Fri, 26 May 2023 19:11:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <mgorman@techsingularity.net>, <baolin.wang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Khalid Aziz <khalid@kernel.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
 <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dcbc46-799d-4967-dde6-08db5e57a718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCiDQYuubsFYsmJ0geukr9UR/20YBIZ9D6tarVcOd5L/VF22cJ8IjU6HizIsdNFh1A3QLnGI1svEP4o4hRRRFyl++nwvUsjRgJn3iDzdUk1CmXdxKp3NJa2yi8kZN+Pp0w6ov5zMktC8bY/7zTJ9Tg9UuUKBphkSINgo+oASC2XRCuhfzMxVqKaNWI+YcRlxlzx5wV7/dRA+EIJbg55bwy0+u79FI76IxAPUuLBUJFGl7jsTxmhytmD6QY3fmGTBZAI7o0JYVuos2GZjZSl01mCvrCxAKD6pcRPzz+D/up0twvysBOn5eqty71ZjSbNMOzDHLI/pYs27WnN7HGbAs3LIRXfLU4XETlmYScSHiiwTTIPMgPcFvXdDeCNR36wliTRGlKa2Gx2/pPyAyBk6BYKQ32ZjJF0qruvXNoGqyZ8I72SQhHNN7EudsuS+R//HaXk3fb+Wb/2CeLNCdgtdSulWHsHRSNJKIcSs+gDn0e301U3sr3126PV0OTDZB01zk3J2/QLAiVKDMpO0t5waVEdQ6ESuJQoRPhJGx/LJmPJRueYW8LM6GbLWtzlXr8cf9jOpFTTQM1edmv9MRx/7w13n4YDdbxR+A3jwE7A2XxPimkuseCVq9JN2mIq8B+bX8WqWM7RbpPHAFTeiVA6fbgVjQfZAC3v8RIlkuTgZ7/LMYTC4UX68JknPxDX/njwExAwi7Q9X+gbDtrbPevdAW6jYZt995VF8rTyyfcAg86m0sd+bIyUDb/QkStXPy7sx9FYPQFHpv6s26lIseNxC1Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(110136005)(54906003)(16576012)(478600001)(70206006)(4326008)(70586007)(40460700003)(316002)(40480700001)(82310400005)(8936002)(8676002)(41300700001)(2906002)(5660300002)(7416002)(26005)(82740400003)(86362001)(31696002)(7636003)(356005)(47076005)(336012)(426003)(2616005)(83380400001)(186003)(53546011)(16526019)(36860700001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 02:11:15.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dcbc46-799d-4967-dde6-08db5e57a718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 11:50, David Hildenbrand wrote:
> On 26.05.23 20:46, Matthew Wilcox wrote:
>> On Fri, May 26, 2023 at 06:46:15PM +0200, David Hildenbrand wrote:
>>> On 26.05.23 18:44, Matthew Wilcox wrote:
>>>> On Fri, May 26, 2023 at 09:44:34AM -0600, Khalid Aziz wrote:
>>>>>> Oh, I think I found it!  pin_user_pages_remote() is called by
>>>>>> vaddr_get_pfns().  If these are the pages you're concerned about,
>>>>>> then the efficient way to do what you want is simply to call
>>>>>> folio_maybe_dma_pinned().  Far more efficient than the current mess
>>>>>> of total_mapcount().
>>>>>
>>>>> vfio pinned pages triggered this change. Wouldn't checking refcounts against
>>>>> mapcount provide a more generalized way of detecting non-migratable pages?
>>>>
>>>> Well, you changed the comment to say that we were concerned about
>>>> long-term pins.  If we are, than folio_maybe_dma_pinned() is how to test
>>>> for long-term pins.  If we want to skip pages which are short-term pinned,
>>>> then we need to not change the comment, and keep using mapcount/refcount
>>>> differences.
>>>>
>>>
>>> folio_maybe_dma_pinned() is all about FOLL_PIN, not FOLL_LONGTERM.
>>
>> But according to our documentation, FOLL_LONGTERM implies FOLL_PIN.
> 
> Yes. But folio_maybe_dma_pinned() will indicate both, long-term pins and short-term pins. There really is no way to distinguish both, unfortunately.

Not yet, anyway. :)

> 
>> Anyway, right now, the code skips any pages which are merely FOLL_GET,
>> so we'll skip fewer pages if we do only skip the FOLL_PIN ones,
>> regardless if we'd prefer to only skip the FOLL_LONGTERM ones.
>>
>>> folio_maybe_dma_pinned() would skip migrating any page that has more than
>>> 1024 references. (shared libraries?)
>>
>> True, but maybe we should be skipping any page with that many mappings,
>> given how disruptive it is to the rest of the system to unmap a page
>> from >1024 processes.
>>
> 
> So any user with 1024 processes can fragment physical memory? :/
> 
> Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().
> 

I was actually thinking that we should minimize any more cases of
fragile mapcount and refcount comparison, which then leads to
Matthew's approach here!


thanks,
-- 
John Hubbard
NVIDIA

