Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB89600E96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJQMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJQMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:11:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD25140C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbSILpDYf7wZA+3gtFDU5t9j5Od68K1xOjCuq+d1AbEeJbzFOUiRr61HhvquZom2O0OSZWi8U2f/sf7LTg6wpSCk1g363vvK3leFxelYuRWBZGZKHPdtnyMoyKORXwKnqE1Gx5ZXWEJ+VCyskgAwtNn/jApAnCbnjjwncWuJ1NbGIJzHiHWACPfI4AdBe4VC2BmehH4t6rBKNwqUwPADlpKELeTVIOkZvgGzoHMZC0muGp7awrv5HLE22AWXAbpdYVJGOAlMJmpiJqU/kd3SL2z1PQwRWMhV/f1FEe6mvq0GnHxvsdeo+vQRQLl6SA0a0QtxgSpql0hynVudq85OdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tQyYfY2G7Qb1YnSRGOqwh+nnXGTV5LqIOoXDSE73us=;
 b=UOoVPrWcSKu1++XcKIIgnTGKFkdf92Z1xHylwXBDjqTDzJcbt6ZukikIcrJnHR2R4RFB1Wc/DDu/kMaTf0QJNPDrLojKU9ECUhpr7VhKDHNU0S7LYLeiQKU9k/2Si6lT24HeplOt1EpGB4ZJbG7ZsWGkJB2MQNKAEc32RmiwDECD9oxmsYvPZux2lO1tR0Hu59SGxXbZvB4aOCquFOu7/iLw+t7ls8vH598p2+XqaaRsP/QwmQoRRV6APWDqlWHSqYAZkPOeOEpot6rn7iemTIOkBGDIHcPK490kF8RIoGcsyQfK324eKcKNSh61FOw5FR1F1y3UgTSxEtWzOSUXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tQyYfY2G7Qb1YnSRGOqwh+nnXGTV5LqIOoXDSE73us=;
 b=oTqW4gyr9Gl9CnVYZ0KiR9+FRKlJVyRbMOsMPwus/VJ1MdCuQLnVjfyiuENuPUDJkODuqgfb44YXsTHChmBff5ByzYHToTs6jGwRIXkD+Lt1VnlsjePyoGSbsmqRhSGLugcT5oL+Kk/a1JY+RO92qj0P3bNVX46WswXhxNxnFCdI/9OVK49Xrzl+Xvk61PRqQbVNteCfyE84W0dD+DwRvAoDmiW35kp7ttxLty//4h4/yVbZV8pg/RvDs7X+5gUl2uWVhjeL03PNTjuTjNuw+NRFaDStQ2mEf6d4zvmXBUtGAvFFEf9ASDmQ5KtgCExlC+dpe+59LRXGJn7eOIZMpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 12:11:35 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::3a0b:731a:67a1:9af8]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::3a0b:731a:67a1:9af8%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 12:11:35 +0000
Date:   Mon, 17 Oct 2022 09:11:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     John Garry <john.garry@huawei.com>, alex.williamson@redhat.com,
        shameerali.kolothum.thodi@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
Message-ID: <Y01GdiFbt2J9La2Y@nvidia.com>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
 <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
 <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
X-ClientProxiedBy: MN2PR19CA0032.namprd19.prod.outlook.com
 (2603:10b6:208:178::45) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5a9258-54e3-415c-b811-08dab038bc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/wdzMXfbAM91sTPm9dcphzDljIXySnP0ftCarSfZP9hZc0IGEuQ9G0z2lk6ZybWdr83Xu4gTCUqsYSWRK8Y1Lu+0gew7ATj//GL2pF2wtvJ2YMktCClWTZofb4SXWQK6iN/sGX10rPKngq/96zbfLh5persBKUJMtmU1U6CK9BF93SJKZf9sLwiH6HUq7CYypw72wuru8apoeN9+1Jzv/2/S9MpCmZlxp24/wU6HvkG6Bk4vHTdEqt+vYYNJO3+OPPvKyA9b1e+hUXJ6vIoTiGTwFoZLVBN6mroyT2MPwytxCew5TK1muogBZjwFcPXmx0hnN/O0jEacJHrnj3b77LvRv4wvFdyGmz4gWk2qaRd5x+Y5ZUNmrZQbKLoWQ5sp1HzqMEC3MfiNIDcf5XNkDORiUBW0z8QTQ9NN+3hPqW6qS5lxCZeAQ9CrOgEHbQGqtXA9yspnCW41TWhldBBUxCQcdxx+eteTE3fC52U8WziX3+rIkxS435dfYQa6O2SY2px5qaQonhDU7DeEfJLrp/8iwgqsPaKemuOHTiEY2ZMtOIjLocnFGab7H7i/iMJIfR2Hgp2t76cXyEiesqIxY1E3CxdXIhgYNYpFDr3U0rBWuRxpQ4Plq+eazHeszMvunah1dtHaBxGFcAdCLdUtrvSnqfA9HGHnhUGrYvCY9E4f3sBN4VkRSSgWgGEFiXiq2BzmiVRHwmYc20N0M66HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(186003)(2616005)(83380400001)(86362001)(38100700002)(4744005)(5660300002)(2906002)(4326008)(41300700001)(8676002)(8936002)(26005)(478600001)(6512007)(6506007)(53546011)(316002)(66556008)(66476007)(66946007)(6916009)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFpdUptdjRWYlhYajNaQjM1ditZTGhVMmU3RnhoYjM4em1wZVV4Z3FUTDRz?=
 =?utf-8?B?NmdDOW5ZQnh6RVNIVGxTb0c1bERkc3pqUGVRQklmOWRObE9hWGNva2JKc2hv?=
 =?utf-8?B?U1BlbERGcEJrNW1EanlXUmdzemsvY2tQREI2Uk5VZmUwVnFlLytQaXBzRDR4?=
 =?utf-8?B?bUdKNzgzSFBGYnZMQkhLWHZ6ZVBZMGtndTFva0lhY2lZdzlVNHpWV0tMUnlv?=
 =?utf-8?B?Q1FZWFIzVUJ2ZzZrOEs4NldrbkxOaEZVYlBaSCtvVEt6VnFmWlR0MFFBK1lz?=
 =?utf-8?B?ZmRSbjdFZ1lUdzU4MDZ1cXcyUVM0ODFvWW53ajVoa3IxVThEZlFSNnIyelVk?=
 =?utf-8?B?VGd4SS9STGttUk5IN1lDRWtjN0NOaFNuZUNJSXhndU1PYSt4YmNVZmQ4bm5r?=
 =?utf-8?B?ZU81blNCaHA5U3plOXRrUXBIUGxTYk5vLzU1TGN2TkVUL1RzZG14OVFQY1NF?=
 =?utf-8?B?ekJiWmgyVjZ3bCswWURSUHNqaysybXJWeFp6N2puaGcvdE5ZU05vamZhbm14?=
 =?utf-8?B?NzNEMGhPREZScjZEOUg0N2dvZ1BCNEpqUHIycnZBMWZaSGhQSDZpQkRWa0tD?=
 =?utf-8?B?dHh2V25JU3hOM01MalJKZHFUNW5UcmF4Q2hvTHo5SDNnbDMyeXgwcmg0UlBG?=
 =?utf-8?B?NEdkc1Nyd1NHNTFFQWo3Sm02TXU1Q0F3V0taTGo0NTI0Y1psNkM3VnNPV21J?=
 =?utf-8?B?OFRBZXdRKzJZdWEzNE93QlJoU1dBWUVUQ0w3UDFjRTRuM2d6RmU4U3psbkxL?=
 =?utf-8?B?S0R3RDQyWkdCV1B3ODJBT2k2c0w1eTNkUHZnVUtVVXZTZlM0VkxFbU1zN2NN?=
 =?utf-8?B?dTR0bTZFdm01K1VhOUFBUUw0eC9JS094bmc0L00vZ2lhb1dxNHBkaFRWMHMv?=
 =?utf-8?B?Q2hIN0x2RFh4RkRXWGwyTmZFczcyeXJZOXJUS1VoR2lWZkNSWDNValVObnIv?=
 =?utf-8?B?aUZTVi8zTDBZY2Fxc0pZNVYySHNVeFVVNlFIMDlxZ2JuaTNTZVIrL2dpeFZY?=
 =?utf-8?B?WmRoczcxenhCOVhBbTVMQWUxQS94WTFYdGJXYnFSZTgxcm80NURqQ2Q4ZFp4?=
 =?utf-8?B?YnhWZUM4T1Y4ZVJ3TzhkaXFjUEJzWmdqL1Frb1JYemg4VzBDWTJJOUJXL05Y?=
 =?utf-8?B?bWQvUDFVb2d5ZFR5cmdBN2dyTFlqVnNjbFZua2R5R1JIT3dDSlRIQVR4ZElt?=
 =?utf-8?B?OTIxbFpOOE96QmVDeU8wMVg0S2VyRFdLcmkwNFdLR0I3N0Vtc0tETEN4Y1Rk?=
 =?utf-8?B?Y3BWMGVYb3RtYlJvVEdZNUdOcmVhNWx6aGYzNHhBVndOWjl5TWtiYURxRDJR?=
 =?utf-8?B?Z050U2t4OXh4U3FEbDc5Z1ZlMHVyNnU2WDhteXdmUGlITGZ4a0FCeHczdHRy?=
 =?utf-8?B?eWFFVWIydlAzMks4WUZ6Q21TeEZkc3lPV3FSN01FYTEzTHNydEhONW1TekNm?=
 =?utf-8?B?ZURuZkFtdlVJcnF6emxWZ1FsWHN1dGlaTmxlV3cxdGwzT00xTHBRaVF1WUU2?=
 =?utf-8?B?a0drU2RORURUSDdjcVZkSUFFczlDWGxKSnRDL2lESk1yVnpuL0oyWStzQWVS?=
 =?utf-8?B?aXVvMjJ0RTVJWDBDVVBLR1JHVjB6ZXhUd241OUFaUXFPdU5zd0pyZmZIOC9Y?=
 =?utf-8?B?VTRYQ3dOL1JYTkNBNE91SmdUUHhnd0VXa09QbFpBTVB1blF5emRJVEs5eXlM?=
 =?utf-8?B?clpVekxjM242ZTBjNm1EWUZuZ2c3WE9XZXZKelhoODMyRVNLSTdKSHg1Rmhh?=
 =?utf-8?B?RlF6bktqWCttZ01OTnpFMGVtOFpoNGV2QzlZQVJUQ1RKQWY5YlgrZEZTOW1l?=
 =?utf-8?B?c1BLaVdyRU5UakFhemNWU1dDY05Tb3NGcUYyTHVtUm9PR2g2VFcvSkllR0JU?=
 =?utf-8?B?bUV6K1V4eFhPL0xlcnQ3TGlPOTBoRG9VMG54WG5MT0dlcjg5dkxvRXRuR29X?=
 =?utf-8?B?MjNOUy8wNHUrMHY5Q3VIQXl6RXViYk1JRkg1dVM4THF2NDlnVVlNNDFmdXZV?=
 =?utf-8?B?Ly9NZTlzM04xTDRhdnUwY3hlalI4RHdSVnVnelQ2c0lnVVVPbGtQSU9JRy9p?=
 =?utf-8?B?SS90d1dlMEtoQWM1MXdBYTVDVU1uUW5HL0lZQjViM2hSdWlRMnNiWFVSRXFE?=
 =?utf-8?Q?mrrqqlRpaqSONtwK3WINRvpiX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5a9258-54e3-415c-b811-08dab038bc5d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 12:11:35.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+1NSvehT+ba9Fd89ol57PexPHM7GEkGkH/6ksF27/S9qx//ocPUFWyutcvj5w5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:20:34PM +0800, liulongfang wrote:
> On 2022/10/14 17:20, John Garry wrote:
> > On 14/10/2022 03:57, Longfang Liu wrote:
> >> +static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> >> +{
> >> +    struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
> >> +    struct device *dev = &vf_pdev->dev;
> >> +    int ret;
> >> +
> >> +    if (!atomic_read(&hisi_acc_root_ref))
> >> +        hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc", NULL);
> >> +    atomic_inc(&hisi_acc_root_ref);
> >> +
> > 
> > This looks totally racy, such that I wonder why even bother using an atomic for hisi_acc_root_ref.
> 
> 
> When enabling VF, it is possible for multiple VMs to enable VF at the same time. The atomic variable
> is used to ensure that only one "hisi_vfio_acc" is created. When other VFs are enabled,
> it will not be created again, but will be used directly.

It is still completely racy. Use a lock

Jason
