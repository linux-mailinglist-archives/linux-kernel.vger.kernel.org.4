Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EFC665C95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbjAKNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjAKNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B93883;
        Wed, 11 Jan 2023 05:28:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZNkzHjrUMypc0iTJSwZt4Boqdut0FjFxkvBCs5N/1ERjIfX9NAyMSwJlEYtGf1eGDztUmqvMDWiMd/RhDYhMBlbw3wCulhUnC2mjs06DZnlrljpd+nJKp0XXjKgPpgx5EpNxPTzHnIMfCwRwROx+wd1f1t9UNDggflXkZ19j8u7ai7U1lcQgtc8yLjNnSaAA2tJ2ld0MoDvdEzF/Aati7y+fjKEGbGCQVWAIhEQRIZbvuIRGijIFsdIxZrKrZTV9LllStXBDRqs2lv+BlzUgy6GSAnQQ9UNa06BvBhqFJcMrw4zTXgaL+CEq9pP5p5196QTZRrZvnnmtMEYoFXBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XJ4j1a9jRi2BJDR7R7ZVzdVf51YEvhGhkUrgYg1pQA=;
 b=iEZfj6izAbfeqD6QWylCe8MvfyB7EV+kAZ1yebfE9vsf89XF2ur+N7EKNSCBhrlfeG7T3R4PddjuExltzV7pm7BBaPrPLkTYruCSJgK5vU1q3oHOfSOjHGoQyNQ2o/IjhNwFUOdLgVgydzbG6lElycr1sCtfqeJsWMzII/qiqvHjMh1J7HTEowZU1r5WsGFADVsBkvduMfIx/UpANMn9eXmSW3OgBiYnZLqbwINtHWZaKv/3Bs364r5YObOwX525NJWUOMibUjF85YinUMz0K7HX+9yvn4BHVkLn8sOZFndp/auoaTCdUn7BYB+TbetRoCeCVOSYtpDPZ0y+trpX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XJ4j1a9jRi2BJDR7R7ZVzdVf51YEvhGhkUrgYg1pQA=;
 b=jgqjjSsB2Eev5sCvKSK5nBS3pbaEDdXe5ZmG1c1wz31W3dH3hQW8KqA/DnHge2Va9PW5LcOBZCJu2EXtzZm2RgPSNZMVRDMr4qQmXbTmZCDs9xdGkhNhn8rpsrX9SOzhb5EgkLbN68h8xDUfsJl/rWs8Sd84K+prSFT9pZqfd+h9FQ08vxMNXfQplDb7Rpu4Q7cqXz3MRxALBr/gE0FALWjRRuow8Vm501KuKyLD4SUwehMi6y2A/x71DFXxJuQ7RZGH8X47FqyPyzI3SfyjsBcZJN5dPl7oNWnLxle1To9Xhh/2GZ+467syTz1esik8KUPgTXizpAWl7AmYIaUaIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 13:28:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 13:28:30 +0000
Date:   Wed, 11 Jan 2023 09:28:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Yishai Hadas <yishaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, logang@deltatee.com, hch@lst.de,
        alex.williamson@redhat.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Message-ID: <Y765fYGiH+ilPmSP@nvidia.com>
References: <20230109144701.83021-1-yishaih@nvidia.com>
 <f37f8e60-d580-0b7c-0fa5-a26ab49c9781@kernel.dk>
 <20230110160347.c1d771e4ea21e4b95bfa8477@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110160347.c1d771e4ea21e4b95bfa8477@linux-foundation.org>
X-ClientProxiedBy: MN2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:fc::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d637810-e25c-43db-c98d-08daf3d7bad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEfUpxJOXjdraRVhb9b8vibj5JHylA1YQZOZ5jvqN7MHtdUizYdu6RPoL52VGR0p/i8M0hXD68BVULnMbMogPuPgSmxYVso0Ugels5j8fF5vxOhk5VqzSg+Hg5DrZ5JEIE05vT6HBdKOaLyxgbs9iwL/A1R2i/zKWthg4jfD5qc17pABi/9Osm8AVKBqxBj+Tx6vdio+FKjvw5xsFQysgruGO62/fmUaur0xG0/Oxv0PyD8UGteEXbiRQ9QvsOcw0clVTqJ4bP0RsCHMPRcrOmPezIV1P3RoBPj2nEJ/K4OaCW0/+4D74FR/ybiT8J0uQ3RRpIWiXXcu3nVwenyGj4y0dUVpvl2WuKK0MBM2Mh+fGsoxOZSD9kVIF7RpRUFKbZnOvHnfCxZCOogxWF427QsBRx4D5g2XrNAJHKRhsp8/fQJLw1uk4n+m/uXqV0s8FqvEzQ/mTIrVKxTcuzdDOdCSzn3nVmYfKHbhlTibUd5nL5at+8ScQ+R1b8xINC04EqOt0oDzKmkR6Al6wRLN0cJNzcjKyu11/JSLSREYOUUa7b+gWdLZEZ3wGK1Y84ImaCVG7R0sx04rYTSfXpbdKwiPzraDdJYlY3lzystCRA1KGDMkmgeENrPJ1ixbZp8NK63A7nGShYv88pUrJ94RYdejjRP26aDyIGOGu4LWHg1uhv/MIcNZH+D/aBsn23rj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(36756003)(86362001)(54906003)(8676002)(66946007)(41300700001)(66476007)(6916009)(4326008)(66556008)(38100700002)(6486002)(107886003)(186003)(26005)(53546011)(6506007)(478600001)(8936002)(316002)(2906002)(5660300002)(6512007)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJ5amdEQ1krWWxPR0xMM1RRWWdDajhwc2hNelZtMnhoeGQ2ckE2dkkxaHVk?=
 =?utf-8?B?ek43K1lhRXl5ZXdxYmRIUmtpSUJ6eTB5Ujlkell4T254VGJSbmFYelpSNHph?=
 =?utf-8?B?ZTNPcC9USENya1lJOEJLUWk5WnY1K0JmZEVjNkpyb0xid3M3WFNxNUFCUGwz?=
 =?utf-8?B?Y2RleXVEV1RuM1hjNkZRYWJMbTNtVlZQN3E1cXpXS1V1a0t0bHc0SjFzcFRN?=
 =?utf-8?B?UmZKSHhRUGV6MHc2VUhrY09OUXVhRzBPYmNyQ2N5R2QxY1Vsakp5b0ZlN0hU?=
 =?utf-8?B?djhISXVIY0MrNVdCUE1MdkhkOWllTTZRRWcxK2s5Vk5NbThvdlpQSkhLTlVw?=
 =?utf-8?B?VkhxWTRzUkFhbFNBaGZERW9YTFJTVlFQVGZYdWpBOXdyc2JOS2lNZkZaSFNG?=
 =?utf-8?B?aUFFTGdPL3JpYktTdEZKakp1czV1MlZXWEZ6Qittc0Uvd0FRVUtLaEJXY3ZZ?=
 =?utf-8?B?WS9jQTZTSlI2cVNqTEdMSDRJMmQ3MTdZZ1ZZL1lXUTlRRU1GeWVFNjB3S25a?=
 =?utf-8?B?dW4zZ0cxL1ZjM2tKV2N1MWxnbW5vekU2ckZEMWJVYlJ6SkNyaTZPaWJUVG9t?=
 =?utf-8?B?ZnJ4L1FIbm44VzUxcXlJUmRDRHo0RXpyZ2diUGVIVHE4b2tYTkhpWndXeStn?=
 =?utf-8?B?WElWMWthUjZNRGZFWTJBN1R3a1ZGbVkyMnU1M1dKUlNhOVJhOG45Q05hMnhJ?=
 =?utf-8?B?VUFybk9kZ3p6WTRmMGxXdUpFSGdYWXNWbUhKLzB5VVlhUUtOSWpVNEJCWlM1?=
 =?utf-8?B?czFZOVlFYWcwWit5SWRiTHM3aE9LV2VMQVVoeERLajhwT04yQ081bzVkVHRG?=
 =?utf-8?B?YStHbHVyaVI1SWsrWlFSRWVzeldwc3U1cEJNeitIVHM0dnFmQ1JqQXRGWkhI?=
 =?utf-8?B?L0NVb1U5UitVdXFFdG9QOWNiSm9udUFWR21yTTZoZ2MvQWJWSTVxelF6LzBq?=
 =?utf-8?B?QWVNcENHaXZBZk9mVUtaS3pZMWhIbnlseDJUb2RVSGw5a1RiYWJIYmZINHJF?=
 =?utf-8?B?cVZBQ3dGVGV3L3FrZE9GUVNZTWRTQ2hSd0s0TGdJSGZ0UmVSaUE0RXFsVnZY?=
 =?utf-8?B?M1Ayd0JNZDR3emw5cmE3eFhqS0tPSm5hN0ZyTmliT3ZqY280WjN5S1QxNlpS?=
 =?utf-8?B?SzBwZVB5aEdaZWoweGZGczcyaGxkNXhkZFFTdGROdFQ1Q091bFozdlltamZl?=
 =?utf-8?B?ZXBQdmpOMjlNVWxwQ2lrR0FjMVpZVDlCRlhZZElBMEVUb3RSVXhzaXhJZEVj?=
 =?utf-8?B?Z2FqOFNjdThML1FUYkFyTjZwbWoydTJXT2pneTNsdDZXc0J3QWlwRGxERWRu?=
 =?utf-8?B?YnBNc0ZXZWhiTlNEWFJ1QmFVMGdNUzVFQzNNWU5nRmpGZXBLaURUWWE4Rzgw?=
 =?utf-8?B?L0xkOUpwWFRGeDdxT2VxRVlOMnJOZG9NaEQzOVlnc1o5TytqS0k1bmt3Qk9z?=
 =?utf-8?B?MEZjMTlWdDVFZXk2SENTNFBxN3RnZk11eUk1RGtGbnNJbmU1TkZzUWVqbHd2?=
 =?utf-8?B?NHR5WVJGZTlGWUtvUmd4RnlGK05mcTk4YWV3dVl5YnF2Vi9QT1RQbmxpcGFx?=
 =?utf-8?B?K3NqVU1ValJVeVVhSUpMNVhxYUZHdVExVjVLWEFuYW5nR0UvcGdJQVlOdndp?=
 =?utf-8?B?RUpKZnIvaVlYeW1ZckppT2xUbGhTaVJjbVJhS0gvKzlSQ0x5Z1dkTVovY2ZI?=
 =?utf-8?B?cCtzSFZFUVZMRXkwV2hoQkxzK0IvNW0ybmNkemkwaW9LTzAxVStMNjZNNHAr?=
 =?utf-8?B?azcxNUczMWJsMitxUjF4SVB3MnR1T2ZETElwZmNpR3M1ZVhDR2hCR1h1MStx?=
 =?utf-8?B?cEFNamdUWmxjRkZ3WGpoSGpjTXVOQ2dodzU3OHlsSjNxVlZib0llZWZHYXBr?=
 =?utf-8?B?aGVjU1hxdVN1bElxTEdqQ2hEclp3Q2tmdjk4amgvQjRsY3Q0WEpEYm1ORVBM?=
 =?utf-8?B?cXRENUZMeGVsKzJzRlRXcmJrNW1nTCtrM2tNK0FpdkovbmdBaExNbFBLUzFj?=
 =?utf-8?B?blp5ZHFBMlhQQTI5UDY3aFlPMFJ4VWVucUV3S2xoUVpyTzUyU2NYZk95aXVC?=
 =?utf-8?B?L216VGoydnREL08xTlFhekQ3emxYVG9GWkNoY1NGbmFTOThkZ1hkNmhWMXNn?=
 =?utf-8?Q?pGe+LR7tDi2Hb6IQ/46dXyD0B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d637810-e25c-43db-c98d-08daf3d7bad3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 13:28:30.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYJgcnBXpBTFNexSw2uhQFoMmJ+X86tgZL60/UiOvokc8wfTpDbSeh1zbVxmyyru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:03:47PM -0800, Andrew Morton wrote:
> On Mon, 9 Jan 2023 20:18:39 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 1/9/23 7:47 AM, Yishai Hadas wrote:
> > > The last_pg is wrong, it is actually the first page of the last
> > > scatterlist element. To get the last page of the last scatterlist
> > > element we have to add prv->length. So it is checking mergability
> > > against the wrong page, Further, a SG element is not guaranteed to end
> > > on a page boundary, so we have to check the sub page location also for
> > > merge eligibility.
> > > 
> > > Fix the above by checking physical contiguity, compute the actual last
> > > page and then call pages_are_mergable().
> > 
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Andrew, can you pick this one up?
> 
> This patch is against Yishai's 
> 
> CommitDate: Thu Jan 5 16:01:05 2023 -0400
> 
>     lib/scatterlist: Fix to merge contiguous pages into the last SG properly
>     
> 
> which is in -next, apparently via a tree of Jason's.  So I'll assume
> that Jason will handleit?

It is in v6.2-rc3 already, but sure I will take this too

Jason
