Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A06466FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLHCbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLHCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:31:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3981C90D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSVEr8H9fYXLKYaGSV+F9clEFP3v6xlR0VYP3HaaSq59FgjUjddDHIJLIbUVaT3KsE62jjAcJHNkbaBrZhAYf9lDf3jD5rjqidVHYMrBrfT835kM23BUyOveSEyuiOCkTxaXrfT4x0Lhm9n8xmxR3eDg2+tyHrZ4pNvKrRx9f2kfQgrFFu8xbB+FA3o3guqkqmhLWQgWpbYfkEWXvhUlmgZAueOBoN4BsAfixm04mYEGIxzUXartFrD4sUJEk4p2vPXH4IMOs+ZOZHPnMpKa/h0e/ifC1j7W57S+SkIrXJ77qWKPa9Lx7h3ztTbGebO6sUaq24GVsmq7ELCy3GeXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrG0xo76bDTKVM/v8DCJ/nbruHI6TxJDE3rIPSHZiWE=;
 b=acnoIVvMGeP60x5OKwm1B0ADxgZmGZ36ClRnkMY1tf1xd8J0c/MmnCBvXdNMQXKdVKefhJmY0HHsr2b5Op0RD2uTWKBcu0snttee9fuHWUyT82ZgPZMWfatfUFBnz+gHBwxoFwZ0oV5B8YmTtgQXHsVr34eCnlqgGiaefv60/6eNd8BphrVceS2zteWHJzJef4PQUYvd3Nk5duI+F8idiiyLyVNjLZx+5ybQlR9n4pKR/AfDP6/rmX7mpxiHv+ark9ZSkLXtCNPJ7jl6+AeBIFLNJCw2H223F3nsiADy+mcd94mSLqVnD9Ki7ApD9Zv+kMIQrLP/ThStMK1fC7zHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrG0xo76bDTKVM/v8DCJ/nbruHI6TxJDE3rIPSHZiWE=;
 b=j5jpZh3Z3FbAf3SN8SJdmGOe9kKkOOEIODaEPUaE+RcQM3QM8aKSBlDGyaHex04gp/zkPYaACMoiqUWWLBAyJHA1/WvxVatFKRrhEtBV08DgNrKUJlS8LSwL1hKZgNLwMGF8ypmQsRrLJq3UY/h8qbdjB87eGXrpyTz5CFTXukgU7YylvvXcGDPDmXDuL8fekf6cekGMyuwO4CKkX1Xe40/2LWnbfd2tAIdNw9aOGKCUe0vrKrpDcg4Ne2hGCvFLDMhUg5yu0nucteyAlnPQENZ0Sv4HvkPu48O5RmSrE6atz3Im2CQ7oj+i87KmW9PIbOD7sPyVc36J+cOJBXgt1A==
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 02:31:34 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::91) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 02:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 02:31:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 18:31:19 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 18:31:18 -0800
Message-ID: <9a3b3346-4916-7ae5-5abc-4d3c34a0a0fa@nvidia.com>
Date:   Wed, 7 Dec 2022 18:31:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Mina Almasry" <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <hughd@google.com>,
        <tsahu@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev> <Y5DXivFOA+bO0IYQ@monkey>
 <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
 <d5755326-a71e-242b-5e1e-86fc897dc292@oracle.com> <Y5DotA/pLbakONGl@monkey>
 <3F95112C-C1B3-4774-9E21-998CADEC38D4@linux.dev>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3F95112C-C1B3-4774-9E21-998CADEC38D4@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7c9905-e9ed-416b-6820-08dad8c4528e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7Sm/8KCfDV9zgy0hvzD4IAw7cypQEicZTr38bOMdknVEzpvqwjwTlrVN99VDVsK1+FA1ZjSRA70Uy3oNfiz6MxgIdV6cEPMqlQSIbfft5RToBeyW8qx0wbNXtqKcZRgymnROXiKBXQY+zpj7rni8hKssVU8IoGJiij7/dHS+Lxhxvi3HIbk4XZGUZDVIQO3r1jc1aJ9okbtT3h4AlkTIgGUuepZNrHIIKRcZfosBn8uWhqbFHW8nLw6kcpQit1GXSYGIEVG3AeDIISp3FyPg15X4L1jKrCdT9za6GwQh532fKDkURPgGInY12qZrH8xNLUEzUDbFTA/yvtnIRIRt/rdmC/2gy4VpfNk2EL2QVRzYV/TAf9y8Mix5KZJkJucCgJBaqqKw5DcQhiSN2Wm+tAmSTXqtwStf30tGF0WZdKRRh3OmDe9LWwpnO9tLzoOLPA+Uk2qLeRU9zYd4+DoeWLvXazQhlGPOp9iC7zzeqWgk+2soFlH+mpbyWo5cfBcf8itQyOYqpZiQuDmHIEO7i126/EZWSNkNaZr2unEPHvH2+AyKYNyyoxknm00tzIE5UbTiDWjE6exYcqpRoWTxJvi0LB3wTE1A7YuoDj9zIThTthIRCu36M3/IJiQ+MyP5TvqiT/8QZLAKK9TciMBUqfpFpdZKpgKfg/9B0uWghILsYGb7sg7Ej7V/NPyI4pQ79Kbcws4TdJEsam63DmVGOVIuGrGnPEC4v43YZsZbWx/+tHkqipPlsT437PaeywMdSIfWgjgbMSoE+tJ6FDPgEOIADGOUjz5F87qI6hwNd38am/IewGIRzvMLseqYAOU
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(16526019)(31696002)(336012)(7636003)(2616005)(4744005)(82740400003)(356005)(36860700001)(186003)(2906002)(41300700001)(82310400005)(40460700003)(5660300002)(36756003)(478600001)(47076005)(7416002)(8936002)(426003)(53546011)(966005)(31686004)(40480700001)(70586007)(86362001)(8676002)(70206006)(54906003)(26005)(110136005)(4326008)(316002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 02:31:33.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7c9905-e9ed-416b-6820-08dad8c4528e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 18:19, Muchun Song wrote:
> How about adding a new helper like "folio_dissolve_compound(struct folio *folio)"?
> then it may be unnecessary to add a comment.
> 

Yes, and in fact, I just finished spelling out exactly how to do that, in [1].


[1] https://lore.kernel.org/all/d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com/


thanks,
-- 
John Hubbard
NVIDIA
