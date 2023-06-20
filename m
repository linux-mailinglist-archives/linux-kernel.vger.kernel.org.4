Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B0736117
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFTBVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFTBVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:21:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DA173C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaC5Hhf9N2fK7F6Vu9SS5FLnv1khb7bI5GkAomSIpHEPcO840Fh67uAzDKMWwec+FmLkQPDiISxONOEBcJZfiWDd463XceKvqkyl+jhlIWXXLfX+SJvuSKFG/Xk3afuljyGKHJQD1ft8FyAHa+rnkhMzPpkVMgNgMLmg2vi1VKnfff9ocwkL7RhLQYfkLioVmLNJsJ0SXs6g1256Ip2ZraGZxmgK6ryFm5/ujArasjet5O4+sF6uU29iV56cQdfYr9rvwh33C3EB1+W1r+6RCG5E4FnpH40uq57Gw3QKRBlC4R0SWNxDbN9uOiAVbCXONroOTaxSQ6T+GSZG8gw/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4av+cs1KZkhA/W9kGL257pj905P+GMKnV+y8xp+rZ0A=;
 b=U0ZkyIraXzdFO+MHoRvIDKTqS2Uf0kvvdbeP2M9vmlrTRfUncb4vMzejm5yJyBr/0mOAB9+pkCBQsXw0VmamVMalTMnxqURVuSVuL7UNBJb6GZPGy+KisdPszGu2iguQVls8lujJhp1xtnhhG+ChlVo5gCG6se9uZ/+NVxcY7FnEddtNV8QyryIUKnKQfB03UTkv06fw+WoXV3/iU3oIhaygpxCS343/KdHuvkQXnbNK6jnUHxzODo5HnAHGYdDGX1nobmalaDBHqtsyAEWWgWq5pLvoE26nsYCdk4UFvlg2xooX1CqVuKUwuTlvtZolDRT0lK/UEibJXGO38LZMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4av+cs1KZkhA/W9kGL257pj905P+GMKnV+y8xp+rZ0A=;
 b=cFk2FyR6YSKP4yudh/1LgpZX4Kr74DiSiX6CGXwTZwIgLPZe4BZ8Io7bHHSqvQFqxo8+7XSP838olDgTcSknTKj5bHvkEa17YlnlTJtvsmC+XypJoHiZYZPEXG3o3oC02kQ0x8bBYMeqT+1pq0l6hhJv6nl3yeeK6E+si6A+E3fjoJp7PcIVJVltp0tP01TlRKOcvRmGLkuFlNtgjdT+JFKGMnvYEInpVogZX3Mf9nERHqkIa8xumBesv1FaeiWaJTjoKeCO4gtu5pG1wwmtl9hgdWNv4GHGqW01DA/vzzRyTZkWhg8fUCiTK43og3a1HvY1fOUtuOmlN2GkwHDg+g==
Received: from SA0PR11CA0075.namprd11.prod.outlook.com (2603:10b6:806:d2::20)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 01:19:16 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::16) by SA0PR11CA0075.outlook.office365.com
 (2603:10b6:806:d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 01:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 01:19:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:19:08 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:19:08 -0700
Message-ID: <0379db8e-744d-2876-7304-2a6db8c9cac0@nvidia.com>
Date:   Mon, 19 Jun 2023 18:19:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Please disregard all of the selftest patches [PATCH v2 00/11] A minor
 flurry of selftest/mm fixes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
 <20230620011719.155379-2-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230620011719.155379-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: c1425e72-17b7-44f3-2f58-08db712c5d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUtQ0AS21H/NAXZ7TIF194Pe2R1m65RkjIO9pUK+w9aXJoJJPMGA/GefgFs946FnsSbTkpI/sDHAflB7roslUcbAKAoXo4SbM0gmk38rqP1isl2tE0pWD28pkp2OwQzq5R0ORXpcYKKPcXiKf/XJ6VJLFVJQQWOjNm8JZ4niiFT8jVg2Yq5A1730PZEkYX3TTCpJgDXW6rLJsaWH0f73/jRE0v8wVv0uDOcs7Zh/l8jeSfDjZhnJ5zdUR9CvENcfXDAu5lC9knFiCfKU6SntqHwkMcmEyNaDqPbHJhvONwMsBaKvKQFkTF+h05hzV5UGG9o/Z4GeNAgcALP05ewk49LR4y0KM7O1TqHRr5pMEx3JzIxTBtSiUvKDM67NfbI1XGuqUk8CS/kDVXUKv1QxoECn6Uvls+73R8/6efwMlwqpx4jbaFCCTxEfIqeAzPrIGqz3nK0h4+l7zydmXmXtJuhhrZmJ6TEBQeaa6TU/ZQDVoNtmcnWN4WxPcVUsNEz0povIL+t2VS05GluT0CBPvRPb8atLjTzBUz974b5KgUoPp0MS/io5A7VuETos5y1w3IRty2xQm0dUvR4Mt28NSjkUlji1e3syfjlPia2GTmMz4aS2YlTPTK35ISJ10BUvcIM1+IwvBNOZ/U3WdZmjDRZawNMVTc2Nz+2ZuN9v74/kY7m9ifmGwweDeIafGAserDuFyiE+L2+FPmISIJyAjFGDaQvs+Czr3z7REC5oFP3Rlzw+DSsX62aoHRpbt/p9BkxoehyAWiKIqPw1y5U1zA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(82740400003)(356005)(5660300002)(7636003)(26005)(53546011)(186003)(16526019)(558084003)(40480700001)(86362001)(31696002)(36860700001)(47076005)(2616005)(336012)(426003)(40460700003)(478600001)(16576012)(110136005)(54906003)(41300700001)(36756003)(316002)(4326008)(70206006)(70586007)(2906002)(82310400005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:19:15.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1425e72-17b7-44f3-2f58-08db712c5d37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 18:17, John Hubbard wrote:

My script picked up stale patches! Apologies!

...the first one, "[PATCH] mm/memory_hotplug.c: don't fail
hot unplug quite so eagerly", is the only one I wanted to
send. arghhh


thanks,
-- 
John Hubbard
NVIDIA

