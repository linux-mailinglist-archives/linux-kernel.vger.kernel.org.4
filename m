Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76B741848
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjF1SvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:51:07 -0400
Received: from mail-bn8nam12on2121.outbound.protection.outlook.com ([40.107.237.121]:32769
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232006AbjF1Sur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaQIK5dL5djFbOL/RQc/cjELDCF6kPTXA8dCh+mN2ZMb02CLd++7HLx0scThsV/irgCv5PmSYcII5p+cP/jxhmLVf4tVf5C9wsGqOrx0K2ezo7GfXBsOiFTjupA16jXxgEmSZIZvViDb4n7FC0YGRI+v/S1kWYuASbIcomFqZPr6BbEN42MMZJ09WMIBCKeuygzObuizYoD639cQxHb+RxkFpNiJDRvlkSORXGmb9YXVLZXc6G0nyMdn8udPnYjF8pXv+P29AL3jqMOoO6QjVFWzrRI+5AtreI0i51TUysbCEuXOfbLXWcE8TzU4PQg8pnFvjY0w+tfjQbtD9HiICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK3p0WnfOi+GXDgJuW19dgP0J9qpuP5UEY7RQ9+K2CY=;
 b=SWuIIIYTfkM4VO8zkcgAoNFGrnUzYYy7YI+2XdayNz+i938e/iWNktJuJBrnV7+3almKs5ZhNMWyQdCH73md9/RKsBoP+RVEE/r35QzmNKZQDG28t+fvjCZ9y4lJfC+tDcXY0yaU34/fx2PvKMKxSB/rnLBEcPQ5UUHMCRKoH7DW2a1wO2URNyHe+X+8JGhDnx1AQgo7B/3fF3l6odW/QiM8ayvIXbi0Uw7gn3uQxknycrt4dn7hITgrUgUlebF4qsXaQoKgZgC+cR+4Fdh6+gybdWGwlTk/NyKYM+97vRPfjOougoSBB45gWJXDdy9R7XK6TMZO0vqen9iJpvaTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK3p0WnfOi+GXDgJuW19dgP0J9qpuP5UEY7RQ9+K2CY=;
 b=vI1CaqqSoJREje/6Ergj4kM7/u9S+nLfxUIQCbW21xw9LJ9iRhwEoDCtBMzKT9SN7AFDEEChpXHcZ2m0xPp2Jh4uN/BPzOPaOkEK2zrVddGQOb48YslDxfE5AReuFW2qLm4YqzMngCjLqYo+KFKsDkQxU56pAlc+0zw/CkB34O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 BL3PR01MB6914.prod.exchangelabs.com (2603:10b6:208:355::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 18:50:43 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::54e5:4e1d:aaf6:7c87]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::54e5:4e1d:aaf6:7c87%4]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 18:50:42 +0000
Date:   Wed, 28 Jun 2023 11:50:36 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
cc:     David Rientjes <rientjes@google.com>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
In-Reply-To: <ZJxjgy/Mkh20WpXv@P9FQF9L96D.corp.robot.car>
Message-ID: <2df9debe-cbdc-abf7-4db1-1628b29df801@os.amperecomputing.com>
References: <20230627132131.214475-1-julian.pidancet@oracle.com> <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com> <ZJxjgy/Mkh20WpXv@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:610:76::13) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|BL3PR01MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 05865e48-82db-438a-2587-08db7808931c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eITMolkTg2Dcua3e5sGCwJ+REY7+KZzzBRNx/vk+HcXWykuQzKaVtf4J3eARonit76z2ffX/v7NdFtgFf5WBQI9gaK660CrcFa1+0C6LHd6Bz73wsHJVhGNzX5Hf2c2e+5bwsboWnx2mCvQ0NPhMQGiAbaRDNoliNvUlbnwKNTXdiS8Rphh6iUSxBn1x3ptEQjUYKzKBVuukCbgOFqKMbMxM2QhgnvZTXgtGsxfyWjhRQSRqL1Bio3jZA6a5V6AUw+J7hIqea8MXQHRTtWi3Mjdky8bVyiPpxUuDwDrSNUHJoGU7U4CVd2zqxeJOM59f575mbfU4PRov+T9KcFPCDvJEh6QBBzwfAwREz8zkERORLHO1a1Yd8cic1yyPstxe+r/FCVdfmpyjFfdYPRw/Wa4OmTevL0VlvG0uoeSzK7dycpsmKhatCDUqetiFNnZKWRfwC53PYe3tR36tFIE9b0l1Ndggk6N7RO3L9IkTj1/2PvLdBh/6HK/GZu/J8AoCWp1yTLhXw5eZR/WcaJAlny4rsIcE0tSGc4+Qnrpe9jVqHqSQNDJ+v04nNDC1oSRU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199021)(478600001)(6486002)(2906002)(54906003)(26005)(6666004)(2616005)(83380400001)(186003)(6512007)(6506007)(86362001)(41300700001)(7416002)(38100700002)(5660300002)(31696002)(4326008)(66946007)(66556008)(316002)(8936002)(66476007)(6916009)(8676002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILAUI7UOL2zifxdetgjNQqrxVLfX55z/Ye2GRPLwL0+Wzgge1+xdhpbjp3ZE?=
 =?us-ascii?Q?UtvlCNGZV2GhbJPm1JtiFLssMnW4cP3bJPNv/v33+t58CoC89gwpAPp8jmNZ?=
 =?us-ascii?Q?ETyqJnAlsknn7RoHc93fXbOJZfFHABRyDazvYFrYaiPqF3qXfeO328Nosohj?=
 =?us-ascii?Q?n0U9btPBIBb2EBNUN9CuCyLsxO/RFJfHwVeDeDm0CMzHvvYZ2PNHVXetwcVw?=
 =?us-ascii?Q?zyV+HyQ6JRMFWuw29BXlgc7E92qrGIlJO99DgFnOuUSSOXn7LtTs5A693bNE?=
 =?us-ascii?Q?dreHzwx4gla+4+71WY8Vqtml5c5LRaz3+eoANmi+7dpCuec1rFrZLtx2F9Lu?=
 =?us-ascii?Q?pBbcoB2Lqq40j75ghJFzMn8sd7AAeoAMvVlMt8khHgQv52W4kwbUJRBZfvqV?=
 =?us-ascii?Q?XxbNb5SbpTsZ2F2EvkVzYAqWWV0YUrO9Zbq3NIo18jze3BnrpfnHV+Qa0MpN?=
 =?us-ascii?Q?9rFpzHSdTkDrPYbRx6dpbrGv7G9nYnZtyxqVIvQ/GoQ5xQEVniHmQ1JVauWW?=
 =?us-ascii?Q?az5PXcXZ0QJ4uj2quvDcAo5OCkMyJiE/qiEhHwoC19iqQ1Xv8prvGkmVJFbQ?=
 =?us-ascii?Q?j+e7E++20dFeczRqmbXkjFKn+Svi1To6DgdylkNbzIlKlS6mfsBSC4q0MKaP?=
 =?us-ascii?Q?hoRU45BUluwq5c0zYfvx31aXYFTxkpsruV3UoGEr4nv3qHWGToy4/DYfi/Q2?=
 =?us-ascii?Q?S1kRxApeiieyhJhbelDOLllzTjqFqcKHc2dRw1C1sTAb7ABmtthOEXa1M2qa?=
 =?us-ascii?Q?B2d8o1cTQ70gLFJjq2mk5z59GmrZaSfnD+u41YqcTgnYThzdQ24/6dtlgWs3?=
 =?us-ascii?Q?ifWA2U0lXze2V7RvirOm6oe3ddrAvUowOLveHN2yfZzPPT2//XLgqF439fWT?=
 =?us-ascii?Q?4ESc5Sj0GDPVj4e3BSRgIaz4LOS2c7cBcmusofSkJJcJXe4L7BcDfHLU20JJ?=
 =?us-ascii?Q?1N+nLtSlwrlfo1PS3nw8n6H4N/qt2hfGwAi3/HDKXAz0o2JyTWRq258WtUfe?=
 =?us-ascii?Q?Edp8z3l5F09fVaTMd67TV/+NWQgrHP2qY2yXTf3IcS0fKLJlGM1qaRNytolo?=
 =?us-ascii?Q?1exdMf3Qrw1B6Dc44yXfwEFE6aF6laOvDnGsSjW4hKHtk7IqjaDVz+RR/ylh?=
 =?us-ascii?Q?xnGRbED8MUBg0d98a403BQ7vdbPErUWW1bUGvAIo9fUHEshZxbPXxmceR5bI?=
 =?us-ascii?Q?E2pPQL+eG4Wp7S7mnQ4cETT+9E1HpjZW5BjYa/naUCDpjyh3s5ECJ8gfBZbq?=
 =?us-ascii?Q?Lpr60kDWpv272UzRoATPv3hzuoLTE4RLPAV/0vnR0SERCtFM5Tlpfb4XL/xu?=
 =?us-ascii?Q?ZqDrvjGxL4/0B8gdUUmrQxqkb4iZkTXU7nIM9Nh9Mp1zVdwQDSe+ls6FhESe?=
 =?us-ascii?Q?0T67uVAVeKKcBAQB1LUrTEh+DHIALGRP+/SKNnS3GcvctSGOrg0zU0sMh5Vu?=
 =?us-ascii?Q?ScvJcsI9aDMc9yzIw2HQCGKiPKF+Y3y+/NMLRzPF4A4mbOUa2ZlWhg65Seq5?=
 =?us-ascii?Q?HLn0am5VsDQJ+aZ9Fg+IwatDJXqQ3PjXv02wI7j8h5E+qw/W5Zjljms16Uto?=
 =?us-ascii?Q?Vas0zOoGpMpobnOFsOYE7ium9UASl8ak5VgO9yIyOB+EsEVCL0wmAI2gwWsk?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05865e48-82db-438a-2587-08db7808931c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:50:42.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE/1tpSdATXqLcqHWc5Hbqrl+HiKpgpveJOoyxRNBKrJvwD3fLScTie2beWfoMpQwnUEb7xg3IWBa9rpNev6nq7Rh9UGa66q34rq/u8NGcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6914
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023, Roman Gushchin wrote:

> But I wonder if we need a new flag (SLAB_MERGE?) to explicitly force merging
> on per-slab cache basis. I believe there are some cases when slab caches can
> be created in noticeable numbers and in those cases the memory footprint might
> be noticeable.

One of the uses for merging are the kmalloc like slab cache arrays 
created by various subsystem for their allocations. This is particularly 
useful for small frequently used caches that seem to have similar 
configurations. See slabinfo output below.

Also you are doing the tests on a 4k page systems. We prefer 64k page 
sized systems here where the waste due to duplication of structures is 
higher. Also the move on x86 is to go to higher page sizes (see the 
folio approach by Matthew Wilcox) and this approach would increase the 
memory footprint if large folio sizes are used.

Moreover our system here is sensitive to cpu cache pressure given our high 
core count which will  be caused by the increased cache footprint due to 
not merging caches if this patch is accepted.


Here are the aliases on my Ampere Altra system:

root@eng08sys-r113:/home/cl/linux/tools/mm# ./slabinfo -a

:0000024     <- audit_buffer lsm_file_cache
:0000032     <- sd_ext_cdb ext4_io_end_vec fsnotify_mark_connector lsm_inode_cache xfs_refc_intent numa_policy
:0000040     <- xfs_extfree_intent ext4_system_zone
:0000048     <- Acpi-Namespace shared_policy_node xfs_log_ticket xfs_ifork ext4_bio_post_read_ctx ksm_mm_slot
:0000056     <- ftrace_event_field Acpi-Parse xfs_defer_pending file_lock_ctx
:0000064     <- fanotify_path_event ksm_stable_node xfs_rmap_intent jbd2_inode ksm_rmap_item io dmaengine-unmap-2 zswap_entry xfs_bmap_intent iommu_iova vmap_area
:0000072     <- fanotify_perm_event fanotify_fid_event Acpi-Operand
:0000080     <- Acpi-ParseExt Acpi-State audit_tree_mark
:0000088     <- xfs_attr_intent trace_event_file configfs_dir_cache kernfs_iattrs_cache blkdev_ioc
:0000128     <- kernfs_node_cache btree_node
:0000176     <- xfs_iul_item xfs_attrd_item xfs_cud_item xfs_bud_item xfs_rud_item
:0000184     <- xfs_icr ip6-frags
:0000192     <- ip6_mrt_cache ip_dst_cache aio_kiocb uid_cache inet_peer_cache bio_integrity_payload ip_mrt_cache dmaengine-unmap-16 skbuff_ext_cache
:0000200     <- xfs_inobt_cur xfs_refcbt_cur ip4-frags

