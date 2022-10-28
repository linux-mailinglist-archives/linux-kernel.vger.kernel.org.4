Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB179610FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJ1L2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJ1L2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:28:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856F1D1038;
        Fri, 28 Oct 2022 04:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKWbGijD/IeFDIeR0rVwi/jaWZuC8EfZijfY7sJ3XJjl5ris06G8XYrvT8ZG9hKiDLWV2m8/ogwaW739nAxPms73HKzpwwNUfkQNTzJ6Fd0nnYO2Ob8MY5g5UBfMNHMMgR85m6inmY9CGnXQSyujLDHs6SKNmXpkzoVqNCnBiAmyqiWwDF5hcUhNXtWzFh35AfIPjL8STCaLrUQyJhWux8HFdYFsHTLjtRHZ5OfW2tmSakn+Tb9v+o4fSxhhhu54I72pdywGUMRXecfUSznsQZoaIomO2TM3/hde20gpraUdYamczlZWoJRX8nWYHaSnuanca9588XbgSW4SAnj8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOLgK1rWXwgJeZS/Z+dF2H95Dhvy+wmRuA6C5ZNDQTA=;
 b=P+jm5Em6304VxuFzx5sPba9RKXMwN5bUCGRuqb2Nd4QmlpAqYJUlNaC1Kh7Md6+yg/FDwUhKbXoVtoJGbjfg0yw4KwzrageD2IGLisGcAVBsXHMze1Yl7ZLqT0WOXJ41T1aqCLgqz9rcfy2f9vx5WpMxqGWVlNsX84z2zC1wyc4Nh3i3N3V20klyQ0xtx/4D2OKxORGYT76Pf3zCjQzTvbJbt1Rj9lZqg198dgi0YPEHg2xW2WeWvP+EoSIvy69GJtwJyD2BT1BevGHjI4GcBi+zSveZn1LxRIt6OI/CJcPSDtYMmB3cg4XxnH1MyWqpq7lb5G/g2D8xV4WlhvRGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOLgK1rWXwgJeZS/Z+dF2H95Dhvy+wmRuA6C5ZNDQTA=;
 b=bibp61tLW+Nr3Yvu3hZVMWo4hlnyEeIARHRBHf7JnXF0uT5RdRFONV3kGI/mYpekAwnUC7op2LUiYJPpNMiwLtlmJXGSj9++X7glCNYWj5vfSBWPCAtH9TMCqvJWAGFrsKgLKWWx2GlD1HOgEgKtwdEN7LlaFw9LbWMwZduwJrY6aOgQlhmmbRx9NqyvVSyrlrixlCjfc0KwE6V9wL0UydAAa++WiajBRpEmXU4U8mcmkRd+/Vcrm0bzaE36mdqflotfk7dGyKILRQ3yERPhK07EWc7sCSA6ozZRfGIsQPCmAk8mVu1weWe3ufBNA/+r23OeuGlgeb22zFPMYE3KVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 11:28:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 11:28:15 +0000
Date:   Fri, 28 Oct 2022 08:28:14 -0300
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
Message-ID: <Y1u8zrKUh2S/J6LM@nvidia.com>
References: <Y1KgX8EwH8T+FgWC@nvidia.com>
 <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
 <Y1K1AqVWEyY0/Uqy@nvidia.com>
 <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
 <Y1a8qM4c2ZAM9glJ@nvidia.com>
 <3c2249fc7abf481b15d4988c2bd6456c48154c44.camel@linux.ibm.com>
 <Y1p/7YS338ghykGz@nvidia.com>
 <c98fa11d4efa86ca676a9d164893db8af8ab3693.camel@linux.ibm.com>
 <Y1qPvg+g6EEaayF6@nvidia.com>
 <1e10c0605e65f43acf6d2b5e71c7c74d6ff980b5.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e10c0605e65f43acf6d2b5e71c7c74d6ff980b5.camel@linux.ibm.com>
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d44c71d-7cc4-4db4-27aa-08dab8d78100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRNiH3BDYNX3UdZeKL0+VUDTj2CzApekCAkY+1T6apIFtY2Urc66M3SHmtK/0bCBG+CObg7jsFCBArGi0zw35DW3XPF1iYSaEgSTBrc0bXHio37m3pauicydCtlo7d5caueZM47vXbcsTVy8xrTZe21k/21m4UrvG8E943hTGJS1gB394DELLXbQYPhkn+I1AKrxbP72638gIqavnn7Ow2q6Pn5u4oSlkilH0a/LKvnSDTCLIql2xRIDplLMwcsgQL6fw2N8SiMd94wTluBeNnDQ6mBJCO3ZIokoiQrOfjmFqTP8pzehL9YQBoUcTvtVh8Jtq3x9IykUDZ7S7jVVxSfb8O/1pzTCQr7p6dnyk4qogQJHdMj3HNubrsQ3cprw7Yhk17Ww/yDaB2m66FloQn2wuY27WXT9/91fyk7N7yXKx4zWe+68FJHI6/DkxKLOWkhilf51Zw86ICENQ3+K40yQ/+aPEuMkTuFzpinx1hxTdwMylZlseiaRQAd9VQSfrJaDRqgDbR7l4+RP0IPG7d60JOG7ixJjzqmupC7Ttfink10iVSW0AGnm5N8VOSjApRsMD9VL0JxC8/qv/5jr9VgOOQ6eItRC0enpM1Fj4D74nXwNWN73ON91zU7m+OzxfuFDo2Ik7dnQiVHMIW93FL+Gc/Hg8oZq7mOzq9crXcdC/OOtl9uympsopT8jelPlHySwsUahxElK5E3YRlah4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(7416002)(6512007)(26005)(478600001)(6916009)(54906003)(36756003)(86362001)(6506007)(8936002)(2616005)(5660300002)(186003)(2906002)(66476007)(66556008)(4326008)(8676002)(66946007)(38100700002)(83380400001)(41300700001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/39K09IAs4t3xOhKq/5V4xHs9jpVnJtdDSn2QBGF1/jqpb7nx7Z/HgkIpwPr?=
 =?us-ascii?Q?krISGAqBSDHH7GLqezB97T6hjIt9U+qIPE3sgoQfxAvNtArdPyESxSFtKESH?=
 =?us-ascii?Q?WTY+D4lEALyahgOga7+oQzm5+7x0n/zodOA1nxoP03ebLy+knbYMVl2cCdcD?=
 =?us-ascii?Q?1EFWmsM9mZP7fmDkxpPcWBTSkBB6vJ8Nhy6cQq2jdpYezQl45jo18xgCoXVo?=
 =?us-ascii?Q?GG0h/XuYVfVB6cUAZ0EjjtzlFsYNZZUi5wsCZRrj74skdGZ9FDDpY5/hUoPU?=
 =?us-ascii?Q?XKej6sxsaM5BENmXmu1AybZvLOx90LcE60KzicKq4+97o8z0TGzdDzOPqox/?=
 =?us-ascii?Q?4o5V2ROAXqEPjDfpB9v1egGqOLI2glMRYq91t8mW4MsD5i4lCjfUTCnbI6af?=
 =?us-ascii?Q?Ld6O2JXQEFesTub4jfkEgcuKajH3GDEPnxlC2ZH4lQ/U1IbflR9BBdE/Vlmq?=
 =?us-ascii?Q?Re77Cp0MCNwTxXUHctvYHjzltgmgH2oToHMvikHQrLPu9NBD04n8zd0g0lmT?=
 =?us-ascii?Q?5CznUab0pSlgdXa9KvqQTSOUTLcithAOX/lKIiCdzNnl7X62ekynwPhZDV7Q?=
 =?us-ascii?Q?WfJlQq8l3Pnp6VkBLdud/LFYzV4DWdInttAPKAiJ47PThL61n0d8lVPp8Fu0?=
 =?us-ascii?Q?FV8++dH9zzkaZfGlsSgAN9gRo7K/i9CPiH98i5f2bZv48bWYlirDhKL10/mQ?=
 =?us-ascii?Q?bWo+qjUwI9bDdV7PtUuelhyMj2T2P29zZB/9Zj84ZMai5NVASP7o7+MOGxRY?=
 =?us-ascii?Q?e5g2WTN7UJv5E81l7tYgIj0h7pdnJX4E/4lM5/SdvUvOHPrNAAFhiBdeiE2W?=
 =?us-ascii?Q?Q0p9vRD8IIZdIINenaD8qL9rQHFazXCD3NZ5+pKRNKQbSCb873CiG5P6Hlp/?=
 =?us-ascii?Q?fJc+EyxL5h88WrzLzV2wieH9H5e5l4arAHwuiiLV2wk39GCN+yhjYjEzRSG4?=
 =?us-ascii?Q?dvQ6uH04MPr/0IFuoIe5T+XCLld/SBIOmFHM3giEaOArExirxFlEgGW3XYEN?=
 =?us-ascii?Q?tukq3ovjaGKHDhzJRdLKHHfkwvDd9WNnycERB+Bp+CNjsai40o4OZi80DRPl?=
 =?us-ascii?Q?gtY14aLs1MexCwsudErr/mlth1Jl4J8AGVE3PBkjrhofnOWYUBe5jNKFn2D8?=
 =?us-ascii?Q?f4Zr/QKGYJi9L3ZWm3nJovoCAOynS0zFdo2Z1cY1CXr5aod6F4UENxynaG97?=
 =?us-ascii?Q?ZCcZsAQM69NKuUwS4cXzW3RCh3dpFU/pWhpSohN+2OWDnTTYgxTcBroppBoS?=
 =?us-ascii?Q?dmDqtn/LeoyepTaV/9gagn///l55cQdIG1B2MCKrHdOtxgD4PEBAvHuFBQY2?=
 =?us-ascii?Q?O8+sDYe/TeMScsl2VcnKs5dhuUorQpxqDTL67UU6armOPAIG20x1O2H06t7b?=
 =?us-ascii?Q?S8W8rQrtPQNA3IRfLd9BBOaBUExYrH/VdXEKGhWI+UhM4RUy/wrYuuIzMYhW?=
 =?us-ascii?Q?UNg1YA3xS7KRi4sf6lZ/E27xTzVO3gSjpHecdg+kk5+w7b6KADKxzgaWAF23?=
 =?us-ascii?Q?lzeJJk39R2YGH7akzi72rbImcTCaC6PLroViyeL7CWGxqMrJyYjiu58qg/y5?=
 =?us-ascii?Q?tChY7r4XnQnv/it2rHI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d44c71d-7cc4-4db4-27aa-08dab8d78100
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:28:15.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaGw7sY5/695b96I3pJ6TW6ANNtGGVQV6paYoGL1bmL11Yo81M40V1dJmsrqS16m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:29:00AM +0200, Niklas Schnelle wrote:

> > rcu_head = kzalloc(rcu_head, GFP_NOWAIT, GFP_NOWARN)
> > if (!rcu_head)
> >    synchronize_rcu()
> > else
> >    call_rcu(rcu_head)
> > 
> > And then call kmem_cache_free() from the rcu callback
> 
> Hmm, maybe a stupid question but why can't I just put the rcu_head in
> struct s390_domain and then do a call_rcu() on that with a callback
> that does:
> 
> 	dma_cleanup_tables(s390_domain->dma_table);
> 	kfree(s390_domain);
> 
> I.e. the rest of the current s390_domain_free().
> Then I don't have to worry about failing to allocate the rcu_head and
> it's simple enough. Basically just do the actual freeing of the
> s390_domain via call_rcu().

Oh, if you never reallocate the dma_table then yes that is a good idea

> Or do you mean to use a kref that is taken by RCU readers together with
> rcu_read_lock() and dropped at rcu_read_unlock() such that during the
> RCU read critical sections the refcount can't fall below 1 and the
> domain is actually freed once we have a) put the initial reference
> during s390_domain_free() and b) put all temporary references on
> exiting the RCU read critical sections?

Yes, this is a common pattern. Usually you want to optimize away the
global lock that protects, say, a linked list and then accept a local
lock/refcount inside the object

Jason
