Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FFD6EA3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDUGUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDUGTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:19:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355EE7693
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkhmJrVWZf5LWoUj1N6TuIgc0vu3H2+bd/ZZ268ALRk55HPzx5i25DRhaE4/2fbT74E7PddN91uGX3MomB2ikJps2FWjdEU60O7w0eqdQ80DlIJcJw5iT4fhohULGGUg2rXdTab4FmW4xOnllPnNZU6+WjMnt6HyituGOh3xiu/QTYZfwK23eNCma2gj4wf2WFtimAdZXDJSN0K+sP9UUCZnPtoTOB2Ep32UzsfsJkZ5ILCtq5DNgCf0g60KMF7L1Oz9xI2GbOVAO0oW4C79I9fSE96M7GJCEGRn6O465faqjk2XodtMjnCY6A1SiXIHqKZZYpadTAl7gTPESEjkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/C8nBRzIGECB/rZCIFapeHAZQ5QfqHuqPJvkOI/O8E=;
 b=SJLfoaGdhUviN3xEWQ6wZ7/gp0jZMlJ13y9O37BNttbqoxeE4EQPvjubjkscqjTKHN04M33k4y1zKE/5WTEfA9H8wPmjWUsBceNQhyloVXagPFRKuxzGKFR0Bw3en/19BzJwwAWdbdnlkr7QHXq1uGrmu78xwDXqP1xyHlkkPAeMUlihirb2xr7ZKD78Fp+ZF4ZkHTthMMx/xAd5gMRHBt/nRGfLYKM/58Rn0+Ykar8PIkGXVoESiu4+H8YvBY7kWzeVQhz0RmeY+tV6aaJyCEtweTsjFDT71DTXmaKzobXrnKcSTO8Fg+zVTpK2SGOQQCcID2yTDo5VZIGz2VAHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/C8nBRzIGECB/rZCIFapeHAZQ5QfqHuqPJvkOI/O8E=;
 b=2SFNvcHKHkJK3DkYDmEshV03IpHAQSZ1Jlo9cgouOscZ4Di5wZKMwv35V+aeNZyghaZWB4EB3+O8ybXt9yQz9il79V7d0QTiMaUvVfx+frMr2HmwJnps+rfqtoNaUwVTXrJ3pXSm0sFzwM5O6efUmXH0U4pWvo0VMLNoWkdbi3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 06:19:34 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::ba93:7430:35d:284]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::ba93:7430:35d:284%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 06:19:34 +0000
Message-ID: <3eca1508-b012-9c9d-d5cf-678ce3dd8665@amd.com>
Date:   Fri, 21 Apr 2023 11:49:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: amd: Fix up merge conflict resolution
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230420192013.733331-1-jsnitsel@redhat.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230420192013.733331-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::35) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: f21814e5-9b87-4dca-1a7b-08db42306039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bOCg7i751UiMzCVpoRcbdNpB4rHpJxT130XzJZo/zKcnvCafa7nZS0/I7d8MATjL2GDmIzDZF935t4UASjjdOG7iXmqo+0H6xqaGP2ZaRbzv/W4cdeQq4CaEhUL8rTUVa4Om+Gwi4j6B/JT5XD9ygKudxd6qo400L8I++ahODoMNNx42s7o+H4a5EdwN34G3dAJz0dER+162eo/lfS8pA4GeqecL7wbw+zPEUwOh0ftt92TxKkt7ueZEIzhDnPgkiV7BntyH64swY0Rqyz4ZyiL9SVzAr1ehnzpTii6EZSqUFcpjLwg1Q/Fx+VpuyRqcnJ2ZWJIuFpTukC7an8ihP3zk3G/O6Cv7ll8sdACHZlQDHp9yg8GN06eh7eGVD4sx0uidqzReg5+okSmvPylv8XGjApGbwslkyYXNJRf6TnTIEnCwMr5g1l6RudU1Ee8azp69B/8Uu8J/hh7GuT47zM2VFtmpwEI54Lra91y5IQYr25wKA9Q/nMap0ZU0L4WY1xBkl9hJwy1OaqG6402fBv9AZ8xl0RVDew9XDZe+jMMD23e2lHU3dB74LE8ScnGrov9Da+lUmwGAqjw2HAKrwhOheax5rdOrmb2HijUWymPz2/Ochar14fyXlgdsMdaAg+QB51EhdBWN8Zcl1kqFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(186003)(4326008)(316002)(54906003)(66556008)(66946007)(66476007)(6486002)(8936002)(478600001)(8676002)(5660300002)(41300700001)(6666004)(4744005)(2906002)(44832011)(86362001)(31696002)(36756003)(2616005)(6512007)(53546011)(26005)(6506007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1A2OG55bE54R0d1WTN0aUxMNWJiK0JsUmlZcXJuOXFqbHhQOGREM2E0czNP?=
 =?utf-8?B?eStjckZwUEtTWGFod20wVll3S1pxenRYUHE4QzhrSGg0NURtZjEvcE1jS3NG?=
 =?utf-8?B?V1JFZHdYemZTYU93VnlMOGllZWIwRWIrNHl0MmJlWExKbDQ5Wm9WTHR3VkE1?=
 =?utf-8?B?Q1BuY0NDZFNTUjBOMjVHSTdiUjhoNUdCeGxqQTZ1N1RlcEoxVmVtMGs0M1pt?=
 =?utf-8?B?WWpqZG5mSmdpQWFzTlJYaW5MWGpSeVNmTk1vY2NTV3BtNWZHVzR5UWVNY044?=
 =?utf-8?B?T3lUbUplbVk5U0UrYkJwdGpESVNXTVFQVFpUL29KSm41YXA5L0plbVppODdU?=
 =?utf-8?B?cS9saU90bjB4NjVjUmNIUjFkQ3NRZzdOQlgrTThvNEhPS21xN1ZhYmNnMG5X?=
 =?utf-8?B?OWJCWmRxMXJTSGJScng1UGxVcHg2dzFXYlhNRWF3ci9yckVNSmd1bzJLU09w?=
 =?utf-8?B?Zm5YSHR1Y2pKY2pTUzFUdVRwMnpCTTk0R3BzYndMeEt4ZTVmenZJdGF2M1U1?=
 =?utf-8?B?K0piR3ptSDFkeUpkYVE5am1Ub0RKclFkdWo4Q09qbVF5S25hWURWVTBFMCs5?=
 =?utf-8?B?NERVcExQOEFkVXQyakZCMm9KRVpsWkpmQjRYdjVRM1JZczVwMHFrdlpDSlht?=
 =?utf-8?B?QloybkQ4V0NHTDcrWDJVZE85ak1NZG1VSnNFNUZQcGJ4QlVxYlJqQzM1VHFs?=
 =?utf-8?B?aTVuMVNIN043MjkwRVhxbndJOEVqOFhDTXkzM2d0a1oxOFdxNXF6YVZzZHdq?=
 =?utf-8?B?WmVLVU4wNDFjTk5kTlNBSTdlMGpTQ2c3UDNxQlFKeWJwQ1crbmIyTDd6WEd3?=
 =?utf-8?B?SUdIYUhhM0w0THhMcDA5ZDFBbVdKZGdtcFZ3WEhUK3dHOWYxQU5uUWZtQ0Z3?=
 =?utf-8?B?OENWV3hjY0NCdXZ5dmV0ZTRFcUxSejN3K0dYSmdxVk9hSW1pREErbm9Rayt5?=
 =?utf-8?B?cjMyL1NNeVJhanBDS1dlZ0tLcTUrK3doeUZ1UnVSTmFiZlMwNmFjRCtMQTl5?=
 =?utf-8?B?S3k3TXFlVXE3Mms2NC8zekE5MmNacThjSUF3Q3VXY0tiVEgxMjNNUGpHelZM?=
 =?utf-8?B?UWh2MGZaSHJWemJ1L1F1S3ZlQm5xQ0NmRUlNeC9PcGxlaHFOOUp2SWliVy9u?=
 =?utf-8?B?QjNKKzc5VldLSy9LU1hUWHhla2xnWGlTbGJzTm9XUmtub3J0NHFOZ29Pdkpz?=
 =?utf-8?B?MW5WZjZnWjkyQTVDaEhUNytzbWJLa2RlbTNjZDd5eUZWSmdMT3JmQ01MaFBw?=
 =?utf-8?B?cU0ySFJqUTJnVTl4SEtIUnB4QTE2Q2RMaHdkNTF6TzZJTXdNWkJVSnN3N2Nl?=
 =?utf-8?B?YTdQVnpZVkQ5V0JzSWJjUm90VVBjUzA0bi9NOXAxUElMSFBTemV1VURlSy9l?=
 =?utf-8?B?b0lTWkJvbzIrc3R1SkhsV0k1RXVGSWlFYmFqYTR4WVpXN2JxdTJEZ0paaUFx?=
 =?utf-8?B?MmRYaHJuVi9EazBSSHBITkJxV3VCNW5McE4zSW1hb0FZdGtNOU1qVmw0cFdM?=
 =?utf-8?B?d1ZENk11d0JKSk0zaVlhY0FrWldRWnZWVzdnZ05TYXBwVzdtV0pUK0daZFBq?=
 =?utf-8?B?MkltSDdLcTErcm53b2lqZHBONXFJaHRhRjBUWVZwMTdiZGM2bStTc0FsUUhD?=
 =?utf-8?B?UjNmcEFXSjN0OGoyNTBhdFE4TEduMU00TEVYbUExcjllZzJHZlhOSUhLb2RH?=
 =?utf-8?B?Tyt6QTQrbkNPR2dES0RBV28vbCtmWm9sYnp4aFhtRkc3enpBWFNBbFZvYmY4?=
 =?utf-8?B?ZlJETmY1dHdwZXg3ZllJRHNmdUd1TlBRb2xQUWpOWjZSQ3FuNkNLVnhiSzIy?=
 =?utf-8?B?V1FiQU5kUjZBeEt1LzR1bmpMdmIzcU52NGtTUlJmejgzcHJqN0FuMXRRQ0lJ?=
 =?utf-8?B?K0ZCQ2dUVUVjYVpDaHJMR1FVVmpIV2haSG1LU3ZlR1c3Z2hKOG5IQkdGdGZY?=
 =?utf-8?B?Rk1DdEFPZy9MamV3TVJJUEVVbC92YU52UU1yQU1ldDNjRVlDUjV4T0dLT3gw?=
 =?utf-8?B?MXFya0ZZbFgwbE8vUmFnelZLUlJkeUVNVWpyclYvQlExaXN3VG50aXQwSGVE?=
 =?utf-8?B?TGRLSG1lMTBQYlcyYVN0L05xY3FMaHRGZTNXSThJYWl2R3RZK0NQWkJqaDI1?=
 =?utf-8?Q?h7Z+RrGkEFnuoz6zPxG6pPTMc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21814e5-9b87-4dca-1a7b-08db42306039
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 06:19:34.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwTCVHBD+nblgLhyA4+JmyjlVxRFLu+EfR5G5UsIXyKDGcpMoyVy2L0IM9TnMd2dphRZ6H2tQnHTrjEtwaQs6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2023 12:50 AM, Jerry Snitselaar wrote:
> Merge commit e17c6debd4b2 ("Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next")
> added amd_iommu_init_devices, amd_iommu_uninit_devices,
> and amd_iommu_init_notifier back to drivers/iommu/amd/amd_iommu.h.
> The only references to them are here, so clean them up.
> 
> Fixes: e17c6debd4b2 ("Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next")
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks for the fix.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

