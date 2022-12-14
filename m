Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6964D29E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLNWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:53:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861542CCB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgBj32tHAVJFmaQty9Qd5Dmc3+Abk0hH+9ViX8KMuY8R9cjZYFg6N/5SjwEnj/2/tFvBHHkht7YPVYts8qHKup5YdU6MPJ6F+nOH8nE18rStqEV1RLq571QQDSCU/qda8Bgeuyj/wMr3Defct8XQosOzEBVGaPmar0sVX6UfJarEhzXl8s1bJ3zcV6jkpL+xr2ER6HMXJptCWgSZf0jJjYhAXsY6jwXQkWInSwzCPqAgvLPSUOVKcf24HdNF59YoaUxfQyybV29hWDgJZ05bs5FwOptu13udhVUdmNzmCq6QfdOFxCR66fhdGOTQl9uVd2VxpBbKaxidrSB+VhnOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdpjlXwwFP2hUEiotfnwS41G2dytZo4F0ypQ4lfXuEY=;
 b=mXeCi9g94H4soy72PTVNeq9NZJJOmKL98cBc3i1qqM6ivge/tfo0pBfE7ZCtPdGFsoaxA/75CPd55jRpAlaZLKRC7kG1dnn0ZJawJTPDQvGReEZdmVzRgQECrORwtMt329TMq47KtL2+OC6Sbd+d7zNuC5y3HppkmA+I7cb2N+28p1aEE7m+r8pHDFw9qelzr3mFK2aOurvlSZ8AKltwdCxerr0RjAP8KrH/9dpt0evl7kLcyRZg1p9to3oPyEy0t5j8FIiy3axRa6W38YmzWijxcusitvB6nnbJBkPGPHTboYNFjTPVR6TXNTYk6iSMikeGaw/opnkNa11jpe+wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdpjlXwwFP2hUEiotfnwS41G2dytZo4F0ypQ4lfXuEY=;
 b=amHWwd8irpxE7V56t2fdtufn9FUbdArxP89C3j9pW8n9DulYPaKe87As4JMboa6XDHdmTI0PtjSqeU3K0KKRvqw9jZTIzKvjKhXKAMsygRhuY6QN1raubkrwSSecRFMWyEDDmQJHUkMdS1tpvT133ic5qjzGjr2QXsCvqH8Au9wLuNFZbMSmLlsubgMNOc2+Vcl/nyIkL6igdN9470Y0nBzZ/ZDDI6s0N4meCXP1KEdkd31gf8pybvKR5WLlxVEgAaFOYMyIC3oEKw/nUii+rL4/SiVphSxcXVzZurhnBBBxwXTgL0fxiVu0GqMIwQ0XGuOY96J4t8W+cRoYUXcOyA==
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 22:53:21 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::a9) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 14 Dec 2022 22:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.8 via Frontend Transport; Wed, 14 Dec 2022 22:53:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 14:53:10 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 14:53:09 -0800
Message-ID: <b5932129-e438-9379-fa38-993b289ea591@nvidia.com>
Date:   Wed, 14 Dec 2022 14:53:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <willy@infradead.org>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
 <f149df8f-b3ae-b9ce-eb4c-4f684cba0fe8@nvidia.com>
 <cf3f6439-ac2b-53ae-6b55-5ff0b8003fb1@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <cf3f6439-ac2b-53ae-6b55-5ff0b8003fb1@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DM4PR12MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e28382-4c08-4f65-a5c6-08dade25ff93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bqb1tMi47Azvf2WjUXH6CR+IXkqh0NtKc2pfZWj61qWEXLebS0pBzZlorXjyln+rjZ8O4r2u1TwbTpfbv1NEREtGLx6RwNZ5DsSeXInuDeuAJJuytshOQu0mAETPrmWplENxkHz6F3HeEAEHU0PBoeLAKK61SCzzHOd1v3lVIuvJ2qT0tUnpnwsrEwLQO9CBzCY/41JN1RiPb27WbDqs6VJVpuFnNnytVFVCg7aj+jeAU2N5IvBq8LUYG+JjHxaW4VSES7DBMm2IhtWf7Z8+SViUkKsqG6FsbTQaVkGu2lsL6SyfRoWy7HNPfPTUv9cyZVVGzwTCECUO5lN5927G1spBAzKJKFhYTfkHLTOysapRbLBGKymz1AjaA/L3zbIoVov9JbP3MyHx+bjR1KJlU0Am9PLAV4mhiN0U8qlZSZRVzI7w5W45589vwxt7u0Od9tm5xkKuwwOMB2eklCJ7eGcQ1m6/FG9Ca2zqEwLQHjogyL+8wB+EtBO5AgSxEOV+MS7zOCeteDRsjzVaMgpOP7zTSujgOmFn23LSu7B10AOJd/an/5IBaqGzhFqQOawUth4CbX0Y1Aa6qw9fML8K5U099xjsBLK/QMcpCIGEJ8EZwN4gdBNiQX3ppH+MD/rYcNHHSvmJlnVh2U4+PXP1ocFZtwJRvU+0hmaRdbOu+fLwOgvEOPx9vUOECa0FhPnq6lDXnO81bYv++POAHNDWIm1OOH/K9bHUjhwsORiUksuX0HYWfhepgefC+Fg5DeLq
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2616005)(31696002)(86362001)(426003)(7636003)(83380400001)(82740400003)(47076005)(356005)(2906002)(8936002)(336012)(5660300002)(40480700001)(40460700003)(36860700001)(82310400005)(4326008)(26005)(41300700001)(16526019)(53546011)(70586007)(478600001)(8676002)(70206006)(316002)(110136005)(16576012)(54906003)(186003)(36756003)(558084003)(31686004)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:53:20.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e28382-4c08-4f65-a5c6-08dade25ff93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 12:35, Sidhartha Kumar wrote:
>>     if (WARN_ON_ONCE(!folio_test_large(folio)))
>>         return;
>> I agree that warning this way is clearer, I will change in a v2.
  
With that change, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
