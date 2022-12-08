Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040AC647752
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLHUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:32:08 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A284B47
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isEKhI8za0ta5PMmE98jFVf+KKWwPX1EIgO63NEWtBvjUMkXit5RMTgTdo1DWTOmlAAn/8O2T3leUlOv4HbHWoVwzyL7Fdk+GFdpfyzm2RsgnZ24PeXskTe+WePm97Jz1gW4B1Q40TUcG0J3AkQYvL/7CxLVp81jamXzdwHthEPPrOv/RzugxetpA8dAh3nCNrk8OjwCs0uVDRGKrvS0vpx01zgmJ1XB7r68CNwlUz67HAHJs1V7a4aznGxjrgbbyfEjceo1Ydrfw3tgBdpfPp48rY12eMQC7sQax7q/6oT4kfqJklvxL21N+2lKHyBzspYAI7qNofo9BKq4ABhlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g3IxPvEfb+iMJgR5wVa/sE0GY1ub4ZVmOdUjQsaHh0=;
 b=CcMbR6HlsyCgBvPhvzDNHMtM++FaoH2JDoiw49g0s2MziYV2YNkGzpNsuhA1jiMY1HmijcWl6KRsXxGhtMeClpIhbRjK6HBoG2rQHPl4SYYZNSoktM03OgU5isVlm5pv8Pm5NatMEtrkhL1SExVCm44H8eedT17imjZRPKgsuzEbuLxxznLoKruoPaOjpk5td8Xczr6r50HjlFH3pUI+8DJuWA7MpfA9ukFubQ9FhLsj/iA+E35nZLUCfYrq8saeepYzNwZKuiBPlHuEQtVvfa+SPyMqhPLl4P5QrQrusr+laXuwFf2CmK98F0qwsaOZ0Yrc4XVhQfEtHvt61qFdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g3IxPvEfb+iMJgR5wVa/sE0GY1ub4ZVmOdUjQsaHh0=;
 b=CELnMHAUKs0cSQ/Sb3bGWZQLjYexRQf2E9I+bePo+3UTKrKebWf0+yxhKCYc1KLo/IiRrupj9lSs4R2K6VoaMxpt2nmBChcwehPRpFJy3WAk7qerK5/S3XLczQXYYWXrXv1C3zCAcK+2oSdFgFHT/1vWhxJ0MSiBmt1/uvcQTNVKaIadY5VpHYSclkpHqlvLTk/ZDdt1BEPInSHJdUxIEVHcYsziOw550LFcIDLEGWyxXPFGQHB08INf9ecgr8YWzRnHjG0VGNwJ5x/+AFDOpebk2fA7x737pvWWEdWOWxZETQFYDexWIH3KND3IL1+FRRJ+fJClx0r8am9Jq84lwA==
Received: from DS7PR03CA0159.namprd03.prod.outlook.com (2603:10b6:5:3b2::14)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 20:32:05 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::84) by DS7PR03CA0159.outlook.office365.com
 (2603:10b6:5:3b2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 20:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 20:32:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 12:31:50 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 12:31:49 -0800
Message-ID: <ca022ec5-1331-6e0c-f487-891a594a6263@nvidia.com>
Date:   Thu, 8 Dec 2022 12:31:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 04/10] mm/hugetlb: Move swap entry handling into vma
 lock when faulted
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "James Houghton" <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "David Hildenbrand" <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-5-peterx@redhat.com>
 <326789a5-85ba-f13c-389e-fd21d673e3ae@nvidia.com> <Y5EW+RTuGuGhfdNk@x1n>
 <86bff55b-d048-1500-cddc-2d53702d7a3b@nvidia.com> <Y5JJCZkUPyZdYjyn@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5JJCZkUPyZdYjyn@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6a92a3-854c-4264-83f9-08dad95b4570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aqy+oCzC0/tAn+EKLnmkGpybp0q54tPOB+xba4D+tsWRXkYgEXD8hjI/Pk2EcrSZ58xubKzWa1nd60S5OSUK0KZsR1ZBti/USHMB5iuzlcnOHtgxxBedDFT5tMHcIKlNg6GAuO+/736AIHTs0o3dYwbrS1o1THalW11XMlqhrsZ53px76A8KMhdX/I8E1TzEfar7Nj73HPmigWiFVQoGoV+l3EEjNPhPY4DrcSJ52S1KmiXYXu8HyL+S8hXZFb60Tzl9BlNfmUuK/2c9Gp0tYKePT2xMJH55iuYQwRSGe4xs7FgTdjhnYeK6y0TdYhUQUuL0u8jZ2XpbRqnGsgQv/3zIct2g3AqSa4h6ASKMA38ub+FlB3CkrX0sBKMyEtTIAOEkOqF5MfcdtMW42We8Q7+kxDV2Sktw7qAwXQdXEL3i4TYpb7xadmUxww3yyj9fRXguCxZOjdBB9xPZRUArYAkdPmQdmxjalhCjjMQiAFy1h/RLf8WZ4v3RJLtS+XGng2Kd8qsxrsi/XZcUbhOZWQIAQTSXBTqC88tuQZW9xYOQTBY9LmIAZIb49PUho5mmtGbCmmMtc4MV0EPBkJKGxtzWnr+i+NHGp+WVnNsO78zbI+9IeZ4XwQTel8t1RP7ODethH2vAZs6FNMTG8nfOeny7F/MATac7JMexbgs7VeASyXiA6EK5rO0nyaNHE8KEW3voQGFaVBm8QEQ6VckbTX4siRLEXY3C42pUX5NKu3A=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(186003)(41300700001)(16526019)(83380400001)(7416002)(336012)(36860700001)(2906002)(4744005)(40480700001)(82310400005)(86362001)(2616005)(40460700003)(82740400003)(8936002)(31696002)(7636003)(426003)(36756003)(356005)(16576012)(316002)(478600001)(6916009)(47076005)(26005)(31686004)(8676002)(54906003)(53546011)(70586007)(70206006)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 20:32:05.4099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6a92a3-854c-4264-83f9-08dad95b4570
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 12:28, Peter Xu wrote:
>> +/*
>> + * There are a few special cases in which this function returns while still
>> + * holding locks. Those are noted inline.
>> + */
> 
> This is not true, I think?  It always releases all the locks.
Agreed. It just looks that way at first, and I guess it was getting
late when I wrote that part. :)

thanks,
-- 
John Hubbard
NVIDIA
