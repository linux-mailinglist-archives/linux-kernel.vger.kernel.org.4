Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6076960F832
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiJ0M4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiJ0M4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:56:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4153D1D;
        Thu, 27 Oct 2022 05:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnB6Hsj1EB59ckHv3v2vUs798SXVvj3uKcCKMXNR6KFP7I5F0QDwbS8CgzaFkbe70TwjqpeFDpsIbZgn6D0ZCd0FFIyKxwVxRshEd+6tndOUsziSF5oTjRkXzOjrkU8QulhqPbOaZPryaqHozn/u6PW6nO13Iu25V0W/kQfDfy/k+FYIrXITALEYcr825KxOPJ5XigvX0rle1hfDZXUJR1uq4FEBlH/8cJc31osM0JsxTvMqPSb4fDYCMTqcglQnXA+WD0khhyBn4OQvN0Jg6Nq48OSYysEB1yA3IrhC9Lwe9kQjJKUHHBIFHsm69OLX8XO6NHrdJUKwJvAaxXz5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKR/TI7rB1OcdiGg7rdalDedqldoShXaUvEJf2bDhIQ=;
 b=cjC9n5YUs+QjAk/PHQHttSlpsO/ZjcXbeR9AmNRmK/1+UdSdrV4fdXftyyie95CoIjPWrbwCTEAvhRWjqNRXxF5ZHtKLRzdpwf2z07rorvuW2xWmQgRWKwuH1VDsAy1AW1UbRTbg/BcY02pBb0KOimfOkBuP9yUytP+5Sb3VZRz0Y8Q0QZjkZI3CMBFRcV82mLWdj5rZFPKnKQ2/nJAq/GtPmb9fNFxIL6hI86pNV37VL/F7UWEE8iAmgwMvbmyZltr/gWKE7u/CNoMNnwOKy9OAG7rggWOD4TmoIF8eFuLgU7ZCrpykbmMgrT3XoaeHu3o2qMSYEHpvxyIAtylqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKR/TI7rB1OcdiGg7rdalDedqldoShXaUvEJf2bDhIQ=;
 b=VeZsW2B8hKVF0ziCB7Suz6ioAaLjkj+yfvAkr/jnUaaLeFpqV3y1PbrJdqDr/to0XdFvVq6C/uaMpu4919FV3ShfObf4GuxMR5Eef9D1Wf7SQhEHRui5vTBx82EoOyMXCq1Z/0QH/iFoyZPX214Uy1u1gBHNOAuMqL9sV/UFVJCGxFWzEQXg6+pJnPAtrySDm/7Pdn2bELNDfT5ctg7RHGqSkv6JNCXgnxmRF2YRDuQqC7XoOKU7QexVOjeGWj8ZRHYt0p8jbFVtU4iytuW8+N2S3ppV8ItCEIVGJzj6lMb0DDi7keVP4m1hfYNBIgd9Jd6GE0364q7hdeFJ/zZG+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 12:56:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 12:56:14 +0000
Date:   Thu, 27 Oct 2022 09:56:13 -0300
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
Message-ID: <Y1p/7YS338ghykGz@nvidia.com>
References: <Y0/lMCQ8oeXJ2HTg@nvidia.com>
 <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
 <Y1ErcEe82yjJI+ET@nvidia.com>
 <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
 <Y1KgX8EwH8T+FgWC@nvidia.com>
 <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
 <Y1K1AqVWEyY0/Uqy@nvidia.com>
 <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
 <Y1a8qM4c2ZAM9glJ@nvidia.com>
 <3c2249fc7abf481b15d4988c2bd6456c48154c44.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c2249fc7abf481b15d4988c2bd6456c48154c44.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: ca63570e-12cb-4bac-c3bd-08dab81aa15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOKVM1PIJSwtzuCFsUI0J+ZX/4C9QHRQC4naDEOtrEdUSH0uPAcr42Pb3IcZvSecjQU2N6xvkVhHCzoli+J+MYjVFg/sFdqgYX4nLfrKe8+Wq6wmE2o8SRArpWRV20utoC+QAhCUzEso8+pgb64n2tdtBjeJK3uXZPbhIESk4jDe/Wu1A2HAnmP1qvJRIDD2Avvs/Wt1AjPoRivLTzT44C9fLstcH3QUTvCHpkca0AJOGvi0Rk8t28P8bLM9rSf8gLD8E3Ow+JQ8bNpItIGwjBGlxmuZ4WqtO5tDe4rREbpp2q+UsgLPISfnsT5pznpgKB0u+xNAUhAqq2nx0XkAPgksdXu2UC6VxCZrdk6jfwUyZUEP3+mACBzlX1LXcdXdiiFh6beR3HQ8jeqtjtRYbDJ3vG6aLYMvEAlu+Ss2lkL6bX3pxMD7LRP0CrzjG0qs/YZh0+lUdbHOBeUAQ5NHO7Nh06HmibhULhNnCkNeCQweU40WmUm0urjKucsCRakZJIv+hvkRxi42IXL+mEYii/mCSKfEbbixaj0YmSup7KVZEot7SVEJ49V3jPD3pRq9r3ydS1KXNvMZxDek4d2JWo8LYjEsC7gPVrxQueQwET7tIYCrWOkPR1Q5Z9mGOHwfiYzAOQAopvWLGBarWMt/3fqnThWw8PyhKTEP27tJ2lIQCw2ievFVsyrUFh0aIx1dvwKimpoEuMD3bxotIWHReQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(6486002)(478600001)(6512007)(86362001)(6916009)(83380400001)(316002)(38100700002)(54906003)(66556008)(4326008)(8676002)(66946007)(186003)(6506007)(2906002)(36756003)(8936002)(2616005)(7416002)(66476007)(26005)(41300700001)(4001150100001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eySSPujH9ace8qpISQC5aQR0dY/HzRM41vyG5FkLwTJ6dTu1RWmqU8leXyh3?=
 =?us-ascii?Q?w/4r5Vv8/ZWIhly3ChlmcISJUVWGFhUN/MVpZIsbo5qkLM6kIaMS1RvYAtVI?=
 =?us-ascii?Q?gBNIR9Vhz5Sj88M5El6CAuVQ1Rhinm+GwL3G6AgQFggCgTReOOjv460YURhK?=
 =?us-ascii?Q?UusCxeJcyMCZcqdfe39Wze1UPkSbocdsEA41+E0CCkZDRprpHq3jjYY49U7g?=
 =?us-ascii?Q?XQgniYG1pSFKIF9a9n1KZcBZIbtoEUDpMl9u5H6ihr1DsxvgnFmhtwgoshrO?=
 =?us-ascii?Q?jUs/TeIAprrRxZ50YDcf/LXjQ0P1UvfxhvMxbY+5IFQ2rrtgPg11SEyrbTc5?=
 =?us-ascii?Q?sWwzPw1Y2qze8V6okXzy1y3wNE9Hp20d9bSQmHnFeqrI1+oyYPAKXjhBvjF1?=
 =?us-ascii?Q?BLXL3BAkXX9M6znC5eOz8LAH+X4VCT1MyHE7Ruo1Xm6BZ1cD+g1uzd+9deiZ?=
 =?us-ascii?Q?PX2AtuJCNrjQGMhPnjaB7SqW1sZ0BgGS/8MXoDWgNdsFwltS9Q5bAIBRmZFN?=
 =?us-ascii?Q?rZOqyLtSRNn6celDZmAoenZpMM5bf9Lr1lkBMNLY0C5ZbMsznWImAeRYcapW?=
 =?us-ascii?Q?JlAKxBc/Vo135G9KZNlxWCvWEFYAosaytNg9ILzMQ+PXa30vg6S38Qy8sTff?=
 =?us-ascii?Q?/3MaUOnMn8bpn0PNfVFz0AkZFX/OHzbLj+2lxbSe64+ijfDn0a7qIPxv58lT?=
 =?us-ascii?Q?r3maOMyvn0q0eFDHOyFd+NJJ5uWRHZP01QzC/30dkIRMwzUHHd7JrlEwwcHS?=
 =?us-ascii?Q?3aESxocU5OIiRJY/Hy9ZmdDHQ36TLTq9f5A1J/AA9pCWXQGoIyiD0a4pCc5H?=
 =?us-ascii?Q?+r6g7cdjwIK8+OI6M399CGSQMKuucTUJ4N5tmp9PlbYkRSbLl5741VAwJgRH?=
 =?us-ascii?Q?QhLrqLmbfgkJtsXou6CR4zO2tj+O2CVC0B89K/Z6DHKLfVfkeorIE0a6GyRj?=
 =?us-ascii?Q?RIEzUAKKYuG7EBNJMTaI/MgQK3Iby1m80cJYPTiJ/mQZSQoGvR2ByGub+syk?=
 =?us-ascii?Q?ZaOonNHCoXZG81taXkrssSOg09fWdtBY/OZ5bOFEUei+1U5px/ThOGs0dtW4?=
 =?us-ascii?Q?TxBrZ88mxoOK1jn2fTq0jNEfrvXSxsy2Rul6RvEiZ5eiVN0ax8obd9Q3A72K?=
 =?us-ascii?Q?VIG7bcCCwHGnipaOelavBKs7UqMqkJmeyPLVFFnXZ1Iv7LBeHqK8vquvenNt?=
 =?us-ascii?Q?yhXRAFzfp9L8C0hPcvFCAybjkVVKanfUEKYL8Q+KhaSPZDGdklPW6aGNKGgy?=
 =?us-ascii?Q?/VUiFBJq5ZEW/z7T9GRrJdpSM2OEfj8F722zAbdQeTgjr7hEwfJDa+QvtwWR?=
 =?us-ascii?Q?y/OtRUteyf2181+bKJhhe/K0ghuOXhVYiyEALESk+6ftHoRMtENdv9uKvIyV?=
 =?us-ascii?Q?inkycf9s5CW9hIsQO9wl+/5Guapl6pkf1fl1YnkYDn14WSNr52syLkro+vYR?=
 =?us-ascii?Q?PZAJLaXkd5hBydMwvRPMqhnEgFSpQ7CWvcTaGHYLon22aRh2grPgC4AXBxls?=
 =?us-ascii?Q?YUHnY+avwuK7fuSorg6xQ+4dHujj1NctW3htnqt3F0QnWYFetp6XF3i3QOsL?=
 =?us-ascii?Q?VRlG6k4hRPizzhLpRfA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca63570e-12cb-4bac-c3bd-08dab81aa15e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 12:56:14.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztfJVINeqTkP4qCaOG/h5ygHS/rGJpeMD/3ay6bjc+Msu4cu5gL9/6Zwl/+6ldan
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:44:49PM +0200, Niklas Schnelle wrote:
> On Mon, 2022-10-24 at 13:26 -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 24, 2022 at 05:22:24PM +0200, Niklas Schnelle wrote:
> > 
> > > Thanks for the explanation, still would like to grok this a bit more if
> > > you don't mind. If I do read things correctly synchronize_rcu() should
> > > run in the conext of the VFIO ioctl in this case and shouldn't block
> > > anything else in the kernel, correct? At least that's how I understand
> > > the synchronize_rcu() comments and the fact that e.g.
> > > net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() also does a
> > > synchronize_rcu() and can be triggered from user-space too.
> > 
> > Yes, but I wouldn't look in the kernel to understand if things are OK
> >  
> > > So we're
> > > more worried about user-space getting slowed down rather than a Denial-
> > > of-Service against other kernel tasks.
> > 
> > Yes, functionally it is OK, but for something like vfio with vIOMMU
> > you could be looking at several domains that have to be detached
> > sequentially and with grace periods > 1s you can reach multiple
> > seconds to complete something like a close() system call. Generally it
> > should be weighed carefully
> > 
> > Jason
> 
> Thanks for the detailed explanation. Then let's not put a
> synchronize_rcu() in detach, as I said as long as the I/O translation
> tables are there an IOTLB flush after zpci_unregister_ioat() should
> result in an ignorable error. That said, I think if we don't have the
> synchronize_rcu() in detach we need it in s390_domain_free() before
> freeing the I/O translation tables.

Yes, it would be appropriate to free those using one of the rcu
free'rs, (eg kfree_rcu) not synchronize_rcu()

Jason
