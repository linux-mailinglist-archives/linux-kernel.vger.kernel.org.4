Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333D602F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJRPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJRPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:18:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A152D2CD9;
        Tue, 18 Oct 2022 08:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZLLjYLFHCwDB0xA9zy0n1nbAb0lTPmA6SjXNau5GIaKHd09nzHl69c/q8VLoO7HOfkweGBwC1q8h2x0SbFzeka9ed+gTzS8pP3AuVMlxRnRHPjVVqMXZ/b0jHHo9AN+F46cvbIir5qYnBk+T9JCu17rB5mPhGPlk6/aHsbT2SHM51BOqu3NQqqQt0ug+q6JvzoYLdVuGynf5dnQPsOP7g6sJDe/7napQ8z1vzeFm5wNHom0PdlZN29J1A06IzoqqYsg3XC3ZF+SWBMese7S5FAUV6DwPXsfwvOwsGoh/N7eLWf92FQDuu+CRN7p5YkIchH5oa9tyDKDiRMtQ6oMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M079KbIgMtwzk1lUKCMI+cVMRFG+OCn42gfH97QNhhY=;
 b=E1Q3LI7heEqIFrz44/EA5SHh2dSRYN6f7/wgRUDQQSiz7PR6g7iH+tobbRtfEeaLio5H/tcpUdPNuVvT3dEYrFLRBAm0jPuX20HYRQUGb88TA5PvF5Rb6oo8oY6Kdn0T6lQ/VNCHjOacsLs7wLrSUJAqnjF6IuOnpoPCz+a9OxnUzfbCTPO4ZkkrfHF5WfQh0rFNdezbl0PkhhmGxIocNlwyaT3Tzfxd7vQhPx6fElHjbCu3u4PFVgbevPogEH39Q/7YmGG76JNGldvRL5L44/4TMGK9GZZMimL/PAcdIole5IavrsjL6L5BFrD33aqdj1H9zw25SUvT3aRUdrxA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M079KbIgMtwzk1lUKCMI+cVMRFG+OCn42gfH97QNhhY=;
 b=EVBXML2x/PKZGUHF2CuemWp+W3KeiLYTW8XokjrDmJ017D3CNLaMdkPo2VDLVNd3IgzlMG5Ysx0LcbO2bdEbHLRwZLEOPbgGbK5BjFd+A5n8+BXCx4mOhj6eww/J6GdTG5MA4t6di2shrJ4DL49GiLJFbMzlOaQr1QRj65vtpuIm9z5vA6wI5F4Qf2DovouBNZUEuNkeH4rYLQaS1N+ikw/dBXsw78uVGfBMrziwr6MfssltCxqPclVYxStz2hYxgAbqhGco03ZJ/igOach300sgiQzkM+IcLp4A+BeIsPJpNzTRAMOkPULrOqbZ7OBblmiZeTrW3k8Tf03dObNlbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 15:18:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 15:18:40 +0000
Date:   Tue, 18 Oct 2022 12:18:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
Message-ID: <Y07Dz/NROAMI0Hku@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145132.998866-4-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL0PR02CA0101.namprd02.prod.outlook.com
 (2603:10b6:208:51::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af3f5f0-9c4e-4120-7326-08dab11c096c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5cCjubmecIi61OeJ0/ZwRaKhhTsl2jHLHF5q7DkTgpXh/xAV+EjouVciZkdigXbqSMfVmal9LQLurdEIZpNkRuVs9z6F9Y3bcad9+Y9//k9YAh9UNQ2LDFBfK1yP0cvApMX3g8ZkRhboK3URmhWMEBtH8toTM60SZkbsri2/iJsOXWu7Sgy5iDkSznYk4Y0HOo3QTHL0Gwq7vsq7TteCp2fRYXJaQL6s/xlHvQugGKNBA8FGOIiyP4ocua3ymQgKVf7JLK2AuRueJdjSA9Oo3SPdqVKtio4xgLjav2XSTZLmkeqdV0U7VCIhWwiauuCbxTjnCJqQjXU/ulAQ4iFVVmK0Sk6WKWRzexAHlN2fzf9BTgOCK2DWAlWO3SJTPG81FoDhsXthDHJQA2WslQhA3z/xO2uNZZMoclzXhaiuJIxBT1ZNNNf8CbFpZXWcA16fAW3G283QUXkobGO89F81xrJdvOutXy9c2NdVnkrKo8nUARFISHWwG4eWhBB51TUz5hiy6BvFA049I8A7tJyMcCgit5m5nCzij5EjHYAxBvnMPli2ARup42Wubkg5FIuPrMRfltQgUVRvHrzZcXk+yE1ayu3D+RT5GY6+RCpr5xfHseix0Q6yX9kBlDCjFjw1hIoi+nuMOkB3mX19jZSdORrSyjQipFjD8CyK2RKwPYROBDbPrE9QFz5T3eLBMgs1FH2ckepagTNe29+M2SW2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(38100700002)(6486002)(478600001)(186003)(2906002)(41300700001)(36756003)(2616005)(6506007)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(86362001)(4326008)(8676002)(83380400001)(7416002)(5660300002)(8936002)(6512007)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aECK12L+c5f14O4Jm7A6fRn9ZdOZnn81RUD+0VbnSGOCFLH1SyBG/BSv0HGV?=
 =?us-ascii?Q?vzwn94xCyKgu7hekwQNSWITOk47rY7Ixgri6asOe6WWOkBb2oqEK7o8lNxA8?=
 =?us-ascii?Q?Lb0ceWMnZIw00V3O9LjHkBTKo1tIar3cV5Vdnj6foYN3wp10uFoDheGdbqe4?=
 =?us-ascii?Q?DgQ9ysphQddeSmkYA+faDy3Z4Q2ophfhLzcGQz7Jxvnd1X3RBE7/q9/lvVYm?=
 =?us-ascii?Q?+Xz0N07AvwRvlSAgG9nlOe/Z7MQaEnneO1F63Q2XkByblq0ahbR4c79y794B?=
 =?us-ascii?Q?mQoQhRCgnLMwQ1Q0tGXijMB1T0DVwGTn/bQuMqaCMN0h1SFtVfo2VDvmmVio?=
 =?us-ascii?Q?wG7XZEQJSekSiWUOd8k/M8gHc2TzVD+kSsOYpZYX8VO7zoJ56bkdXbmXmhVB?=
 =?us-ascii?Q?TZ+cjV2yFporLFUm0IRnBl6ye7hnJlkeDA+l0KMwjvcpANYJk1C/0Ukdhb7J?=
 =?us-ascii?Q?neFJjly0kdTQsdLDf3XdmxEvW9KL6MOMwzGfUBpdLZwSksirF5kSnfzTeWof?=
 =?us-ascii?Q?UP3yqfJTAg4s5Mz4Kl8sImXMB9Cjn0lMiDVP6UCcExWCVZFy6zGp75iwmexU?=
 =?us-ascii?Q?ctIjuHsZdCUcSOnHgVirpGwg/TXkK010N/XBOFm57s/nSnVtwpnzjXdggZHC?=
 =?us-ascii?Q?NTSw72GIYiDVjFG69/u9TmRFX6MV3sSXKrRmdssZqdNdGVqPk4pdsSwq40tL?=
 =?us-ascii?Q?VpAiiuzsSW8vIA98vU6KN70YeYoc81vt+coH1/C9sE1/kF6AwcUGnWWGoZYK?=
 =?us-ascii?Q?WiUtnKqE6uUtXPvX1NXR8Jg1ElIZXtjL09rYR36lVeYStyLNUoG4zG28LOtX?=
 =?us-ascii?Q?D8vPvLMdkO+3t84hrEaQPDQ4GgwQTT7OoUjCNJaKDDbjpu0bFRs/rFWezAup?=
 =?us-ascii?Q?Ifpu5/3t56BSH7okOaGI5IN5Tj7LMKxYpaRAMAIlUt04D2j/2Grq73bq1e8y?=
 =?us-ascii?Q?9YmFSkaBGwuXxGu1IS+/oIYmo3Tcpfr11zJ92FmZaAxyoK8lxZVmAAnH0DMZ?=
 =?us-ascii?Q?i7d2GFMWmdGZ32kK6XV3rM1jKyEp+guwBb4obLLF3j6KDhv5pAvix+FBDkya?=
 =?us-ascii?Q?UKCIyfkFDQ30DOBz4huY+vt/z6Bp8SXK+PUu/x/1eSJOV8v0w/l0ObunatOC?=
 =?us-ascii?Q?SDqmqgAO0t8GZcvVJlx7iRNQDaIhCsHpgwI9R40X32mVwxP4aTiXZFGegIe9?=
 =?us-ascii?Q?bABBWHozNCfcjgsnFfk54xnlAry/cVxwxVtXqQbLhjpD2511lU9wnMUFr21h?=
 =?us-ascii?Q?BSl2Q6rxgI1hsqRu0Xlgj1XY2D16gnX1ZjYYq98SK4/uMrfH5kCehAmaHPbK?=
 =?us-ascii?Q?ulmJ0jVuASa+ylicKxrv3qTBm+FmuzeBrnM2wzoJKQ+P5Xui7VIC6Fb1FLYp?=
 =?us-ascii?Q?soz8RR/9Ob487wAntq1ZoFWBc/7SKtXcu2oRxK6UISZanzzB1BL1LYLMPqtN?=
 =?us-ascii?Q?qzuQlpi6e6q0E4jcVnXABLCtHDjBo6tX0lvQn16Q8Q6iJwFdu3Pcn42bR3sm?=
 =?us-ascii?Q?AnnMNNbeiWxZXT6U/wGgfWlsPUyzJKwq5FuiEPO3tJNnjENgHmRHgyixpSas?=
 =?us-ascii?Q?VHBzlLJTIqqFQrKbHSg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af3f5f0-9c4e-4120-7326-08dab11c096c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 15:18:40.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2X5uDXBL2hxUM54/8cNoYXpEEonqJmHvIaFDT8UI5wqq72tJAbui8gHXlRED5DlL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:51:30PM +0200, Niklas Schnelle wrote:

> @@ -84,7 +88,7 @@ static void __s390_iommu_detach_device(struct zpci_dev *zdev)
>  		return;
>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> -	list_del_init(&zdev->iommu_list);
> +	list_del_rcu(&zdev->iommu_list);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);

This doesn't seem obviously OK, the next steps remove the translation
while we can still have concurrent RCU protected flushes going on.

Is it OK to call the flushes when after the zpci_dma_exit_device()/etc?

Jason
