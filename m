Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C1D733C73
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFPWf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjFPWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:35:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73242D6B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MggcmxyIXqHjgHI01Wor/1cdcGlFWLii4ZtUHf7Me+FukRpY2p2xgVCDP9h7nyazovW5aBWtWzThnaHYv2MSgRDJKRy2xVKmg1fkXCLbsi1Z8jSvUrH3PvbMkzX1mEM2QIVoS/vjpt5eC64mHOguVCM5R/3VTKATWdvGb9oU1sOyjW+x+ZcNiBs257o1MAurKQShav88T4cOxtR9qCTzB7cIQIaMOXg3toKMYtXB6AUyvdt7vWsUEdQd945YqgGzx2UXqZ401WdzUmKl+O8gT2cwfpJNrPQViEeTtjAf9cLKi/egB/IPeQSXB5HBEFPl71cHsmoFBLlQXucqMMH8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEuitt7bL/w5/varS4Wz5VGVewe1MJg1FxoB2i95x3I=;
 b=fWL/BmiIzjbuNa8HX5CIjatB8ESpnqzcsIFSDXp5D6XgBu9lvmt/JPcEP3/KQzuwDxagjrAzvqW2iMFwUix8NJ5MfHTsvOmFt8My6UgtHEc9QNzrYlaKTXWQd78RGTFJoiU5Q8LqCV3ls5vqykVTcZA6BNRxTz09ChdiF7wNClHRuypO2lAoVfS6EZRi6XFWH3UYMOBkTBmgEuDZnwjK6qUa93WE+li/M95j+V3nsQ0oRNncRykEQbSaGXIKxIeRJDQn5DZaIJHDduV/8FdIb11Kn7vqiDQTTc4qmmdyRZVxxHPLz7UcJRalsgA4BFdDbttHZXvPMblXIY1L0EwPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=efficios.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEuitt7bL/w5/varS4Wz5VGVewe1MJg1FxoB2i95x3I=;
 b=Vzu4QyNAHRTe1TwGVTuL5PCosmY93s8QfUo5UYV3s3NWQXnStfaDHLTylDnxOHIyA5hGsC+UO8lBcC5IQFjDkwFCbSKHkuIuYjGa5dK7lAEX6thBZAppUkw92S8WQLATX+i+pPt0VPdwtDK+i0a0Ahx+N88DLmuNc2CxeIxywz+P42pzh44yvMqWdFi9FlBMouCUSk1wRy4qDw59ab/uoZq/YY1Ic9GMp3MTSklhlJl0rYMdcMPKXfRlfzOxj5RSGnRNamy86Mn153wpls/jWcZKoQGe2q9mI+7Q8esxqtwAk8iGUT3rfszgmgY/yULcmZuES5+0JMEt2rpBavppbQ==
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Fri, 16 Jun 2023 22:35:20 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::81) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Fri, 16 Jun 2023 22:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 22:35:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 16 Jun 2023
 15:35:05 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 16 Jun
 2023 15:35:04 -0700
Message-ID: <1634ca8f-2b22-712e-15f9-9980ba8a4e64@nvidia.com>
Date:   Fri, 16 Jun 2023 15:35:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>, Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <linux-mm@kvack.org>
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
 <20230616131639.992998157fe696eb0e0589aa@linux-foundation.org>
 <efb2e71a-9b18-4ccd-bdbc-3014fae032fc@efficios.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <efb2e71a-9b18-4ccd-bdbc-3014fae032fc@efficios.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e87d0c-b17f-4592-c67b-08db6eb9f69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3la9EgBRCXZor9YEhcQXr+JgFvysgUkznykVKPEQI6PvxuEYDwpl4cPvvzU3EM7GSD/uDR6dtVrvv4Cpkd7zphrInQvZ/wPhoqJLHRgSQJIwsqalBNkM6mC0R4fT2SHFKn6X2RMlKRzk1SexwrTMmRY3dGI0Hg3/ZMLpYm8eQZFC40VJV41gFBXTZNdZTWUJdc0Odk3s+u24pG2f+QaknlAbYRgz6pYxF4708irSrYl0xplD3YFfEW7c4R9kxqIrLQAKR+144+Sq1rndWDI5uafbOxRF3RJGeOS0I6IoLRwlzi/imcGak2NEe1Q538kZb3CpJKPkHFFyZp4cb5MZESrxGSG5Te4rxEDIawrVAmfeObC3o2HYu4vUKiQP55cAgUgzsmiwV6AgeTgcEmfAhN1ZBptb3PgBJfakXDAKUwTOGfcMnq74w4InIcI1k8GNWrVd4SQ94sNbuf1ixIPkIfzoLgxqATJyGl0+H9ePuIGckS1sP/mfh9nM5VYKV7V6j9gtOfhJ04YUf1a4qzLMUviQjE+/VVtMGXCPw3SiVjD28jx1Sp3bQtFuOE+PCc3W8Yrw8AyXiIhl5pFzZbFIh3leYpMDyDHl4mayOCPInTkc9+9OJ22nPcEn7D+J1pcwlLIWbMbINNZxuWidpJaktEgG1uoCPxjGv/sEwRJKv8S9SM3H5NKapn44k6RyDICXHxmXP2PRfpXjkXIs7OUXd9CRrxC6Awfp9/FtZrhoUlHjotjiu+M3twCijUQ1pT2mXO89b36rwtWsVv1DGzLvqg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(7636003)(82740400003)(356005)(40460700003)(40480700001)(478600001)(16576012)(110136005)(54906003)(5660300002)(316002)(7416002)(41300700001)(8676002)(8936002)(70586007)(2906002)(70206006)(83380400001)(4326008)(47076005)(426003)(82310400005)(26005)(36860700001)(336012)(186003)(16526019)(53546011)(2616005)(31696002)(36756003)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 22:35:18.7659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e87d0c-b17f-4592-c67b-08db6eb9f69d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 13:38, Mathieu Desnoyers wrote:
...
>>> This comment is rather odd for a few reasons:
>>>
>>> - It requires addition/removal of mm_struct fields to carefully consider
>>>    field alignment of _other_ fields,
>>> - It expresses the wish to keep an "optimal" alignment for a specific
>>>    kernel config.
>>>
>>> I suspect that the author of this comment may want to revisit this topic
>>> and perhaps introduce a split-struct approach for struct rw_semaphore,
>>> if the need is to place various fields of this structure in different
>>> cache lines.
>>>

Agreed. The whole thing is far too fragile, but when reviewing this I
wasn't sure what else to suggest. Now looking at it again with your
alignment suggestion, there is an interesting conflicting set of
desires:

a) Here: Feng Tang discovered that .count and .owner are best put in
separate cache lines for the contended case for mmap_lock, and

b) rwsem.h, which specifies precisely the opposite for the uncontended
case:

  * For an uncontended rwsem, count and owner are the only fields a task
  * needs to touch when acquiring the rwsem. So they are put next to each
  * other to increase the chance that they will share the same cacheline.

I suspect that overall, it's "better" to align rw_semaphore's .count and
.owner field so that the lock is optimized for the contended case,
because it's reasonable to claim that the benefit of having those two
fields in the same cacheline for the uncontended case is far less than
the cost to the contended case, of keeping them close to each other.

However, it's still not unlikely that someone will measure a performance
regression if such a change is made.

Thoughts?

...
>> If the plan is to put mm_count in "its own" cacheline then padding will
>> be needed?
> 
> It's taken care of by the anonymous structure trick. Here is an quick example showing the difference between alignment attribute applied to an integer type vs to an anonymous structure:

Thanks for explaining very clearly how that works, that's really
helpful!
thanks,
-- 
John Hubbard
NVIDIA

