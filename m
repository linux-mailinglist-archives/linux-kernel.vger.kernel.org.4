Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638DD700D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjELRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjELRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:06:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6AE50
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhojvMbaXYC/GwMr2PelorM0flGF9GVTTL2QgDX1dD7xdpqrSJ7/O2zY+Vp3Od7KlXVSzePZfht1VpdGepo5LBD0BtySMfc9VRn+G+yno6BKy1oNGsWVp4vnjS7QfXCmc/c7l6EQJ7cHzxy//G0jRb4/+Qnh61ROFq9muyS9GHVvk05qr3TlN0Pc/+glQYJ3wM43K92Hs8t30J2FTQ1bDBZdH62hv08tcJN7OmgawJXH6DXK7QnSZHEa6r40UrSdngKmSxONnuWeMzbnA7+0Aj3+st7VnItOfHXUzrM8p1hM8twj6R6iNyH5M2YoBEy83Wo96/U2V0ffKnUWiJ3Avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o76Y+eO7z+00ukKNdRV7fXABofAudxnBIvLOwFisq5M=;
 b=E7pMxwjwI3aj4hkEzF1wwL5djWf7RSYfe1I07+yRWLPYJOX35fpVoJzHCllgBb8iKTupurC7mWdl4MjhpElzKjYxATpXU/anXmYrWZPapCXWfMWUJe2+XPfAFIQ54rjc3k1/4vg2cXhQBxSfdDaDldL7qdNHyW8Qpmq/5KeYvHn8FDVKGBJDik9VlEIBpzKvTKlT6qB3mYPDv4KL1vCCwQnTX8TqbXZx2tEYxZXxZIu4BC30pWMgbXK7LziCFuwYp3UL6+TJ4oQU+2PMKn0vfEyd0BXJU8XA/zOsS8mI+HjV834nxE3ktQ7Rx+Vf2hCI2miuixBz8799aPaUcV9aQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o76Y+eO7z+00ukKNdRV7fXABofAudxnBIvLOwFisq5M=;
 b=nwUfodivGEepRG9WAUKhuugXrKDIoOdCLhZbXtDmtZgynBHRpxcg8ux8DURb7WKF0wDYxMPzJCbUSkU+jf4BLz0TCd8Lh8k69l9JcEQiX+hwQdnaFskgfpPny3A0XQr6lcP80JgEOljtvOqY0pJrFJxu8d+nhGVexSi8P9IE8m/9CT3UCLyQlqUW0VcxgMMga0Wm7AVuYRqqN8DDVY7ORU6ICf+UlwjaMUHy63fXigjTNiu5s49519udsO7GAA0+ea6cOEuR3G+VkyAHC7isupumypcx48qmtYkom7RAmfMbpk10GWpazwdRrtQqrxTJ3a8glJ4SAH/T0rHM6KeTwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 17:06:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 17:06:39 +0000
Date:   Fri, 12 May 2023 14:06:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/gup: Fixes FOLL_UNLOCKABLE against FOLL_NOWAIT
Message-ID: <ZF5yHLMDCLq4IBqC@nvidia.com>
References: <20230512003102.3149737-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512003102.3149737-1-peterx@redhat.com>
X-ClientProxiedBy: YQZPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b55660b-085b-443e-fc87-08db530b4052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUSjn2y6SIoQx4J5ek/1vMaNdIxH15y7O/jiMHVcbn4iSaVYZZxnNTmx3cYKKSIjTGRlONEQ0TaOIynvhWOyFYg3pTQ/4U+vUUswVM2tQjK393ltt1m0goKwiRRnbbxTF9FiAczGvvbidIjw9Bprj9i+wPndqmgcUTPgyiUnnOqQ4L0DuyE5FST+jJCUtalk72oKdscLIJgaeDpCbv6EBNLhi+q+xbhSsoNZocdw1wHLO5VdaIfDINRn+g64hIyPxDG+moL3qAVGew1wM128olOhN/dkY71qtNpLFeXHjzzLVHzXkIuRU6pXcF+8RbO3lKl/IzjGv6hH8RakJEImRUlt27jk7QpUIY48Z3dzUThNRAX/ptWbD2C+xNlintQP+zs8NqdEWrF0XBsTKs5pYhDMJ4D25ET31i8rTqvPC/D60+Kv+96V+Fqzvr7G6shDIBkXwkcqJcOGAOLIogiFh2ZRhcb3y8iOF/AJXi2aJTiTBUxV8o2Dqpnlig7pHrlT1KAbLRNn0lfEJZa4uhjjwZQuaa5AdBRi81jVnQUsyhe4Db+oAXaiEUmYJwP9At/o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(186003)(2616005)(2906002)(83380400001)(38100700002)(86362001)(36756003)(6486002)(8936002)(41300700001)(316002)(8676002)(6666004)(5660300002)(478600001)(54906003)(6916009)(66556008)(66476007)(4326008)(66946007)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IML6g+CLYyKRgJbTEwEMZbTMgHYNG0jjCJv9rB9r0V0iacT/W6k8sJaeJ280?=
 =?us-ascii?Q?CTgwODVMLgQ/EJJyTWw+RyLpSX/ZjC+YiwLMi2Q+ILfhcypQUIvfNIV9VYYq?=
 =?us-ascii?Q?n5HSsVycn5AJfDaZoB4BOPULII+0kvtCIOH1I57qc71sz28GjuNkfXq3cj+2?=
 =?us-ascii?Q?Gzo9rLilxTrjsgv3yZLyd3WNmmEKXtri8HhEJ0OE4mkWGNAFid7y85kD+ypP?=
 =?us-ascii?Q?aYar6CAe2140EHzgtlYiHLv4D66vhI57l/7hIP/Ki1UJRn4zyjNpMPPlxU1E?=
 =?us-ascii?Q?hnZZr9p3oMiJzrxlDkjDldkD8Ox80mtYrPXcJcJMLCHgCfFbVDBLrjziSwAA?=
 =?us-ascii?Q?Qa5Gxd8w2Bh4osgaWMZGv1xnISCwf3/31KQ1WqnOdI9cLYN6ivHhTQiI4TRL?=
 =?us-ascii?Q?Nkl/frBlDUKnGoNO9nC+Q9tjGjXMzM1OMaf7ES9uttmCJ7RIfHFppTDBILq2?=
 =?us-ascii?Q?Klg97ZV7E+uvYUP5L+U+feMpQQ9qSVifhHZPskwUWBmu9tpB7BjNSJDZkzxf?=
 =?us-ascii?Q?kGD3b453nmuieIy6YZ6QR8xuEp/endhemMYfTy5gRrBWj3szwVcv1LNEcQVf?=
 =?us-ascii?Q?kUmBnk/zHLQOTWbpumAuaoOXmqUYe8APuEZxqeD8MYjLk6HJeM+nZ3BZOUBe?=
 =?us-ascii?Q?U706tzX9NUnzcxLUSdAp+xIOjfFdym9QmsRWzWJqTrghhgaTzKWm65aukZ6R?=
 =?us-ascii?Q?rm485POq5Le+cvM9YWXS6sQf+NV2qW03JlLWpyMm7eYrtueJq5o/pg75cOGt?=
 =?us-ascii?Q?2kx8LwYu3JEqGDbQl5lmH71DMKsukrTLuDAuECmL6ZnvV5y1MnFtDrrPXrEe?=
 =?us-ascii?Q?RLbabsZ7Ce6Z2WMtwW4sROFHh4QluggCKfUrS3hccOQpcy3Uu/Obj8UgwIMF?=
 =?us-ascii?Q?bU1PYBqERPabEzRlyBrjcllU3GrEsouCqGIb0xJZy7bUnYQyFCcpk1I0QTIF?=
 =?us-ascii?Q?gyGD3FZDOU4kWLm/Zw/MB4PQL/pK52NNFQnJRL7ly/RNS7f9wXk7yI6jfdZz?=
 =?us-ascii?Q?2WfP0S+9UcnC4hfAqZEQb4wNfvVd4JOr1nY2Tmzek+q6/seo9Nl4CeLuTbLg?=
 =?us-ascii?Q?987/86DAek9SvkEUxo6na/aQeKlZs5ZCrSwZShUnULdiUPdXaCgUixigGeZh?=
 =?us-ascii?Q?BmJX7dEDjLnCkV1i6xXLJP4WQhUVIFnSsIOjdbNKBhgd9inGWdEKRpztDzju?=
 =?us-ascii?Q?Rysuc0HQYRf8vWyQAMaZIDbkkmlKBx51UjgJ9yj2wAyWjK5WAkOocggIYoO6?=
 =?us-ascii?Q?o+khyIaRBFJJNCl6fTdg5MOzfsyzZQdII+c1PIIfHp9pWiMbG90ex//nvoxc?=
 =?us-ascii?Q?mBNKXNE+KBxYwNMWyKo4gJ32YATI5mpYqoimPOKQ5d0pZfgaBoaXU9iboRxH?=
 =?us-ascii?Q?H5CoB7LA1kRRJgsjHX35hjFI1Z4SNVFHAqfGJHYzdhWYddTtUnMw5irro0/h?=
 =?us-ascii?Q?7KT51KZxsFqBuHWpRhf4q5S6QOP36pv9HBkfXUZpKEEvAu+fP4Y1UYhGtkin?=
 =?us-ascii?Q?3MgHMbHJ6bku5z9GdqbutS4To3a3V5cS3L8xoiAujxwsJAlo3jpLh6UL86rI?=
 =?us-ascii?Q?d5trtpxymXnntR9AlAY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b55660b-085b-443e-fc87-08db530b4052
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:06:39.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nv+gxzC1pjHnpX7CVmAgxhbotw9uXXVFKK6xZqZe5i47NcNdHi9kdav6ZcX439Vp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
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

On Thu, May 11, 2023 at 08:31:02PM -0400, Peter Xu wrote:

> E.g., with current code we could at last have FAULT_FLAG_RETRY_NOWAIT set
> even if with a FOLL_UNLOCKABLE gup which doesn't make a lot of
> sense.

I would say NOWAIT and UNLOCKABLE are different things. UNLOCKABLE
says the mmap sem is allowed to be unlocked, which is true, and NOWAIT
says it shouldn't "wait" (which is something more nebulous than just
sleep). In FOLL_ flag terms it would be fine if the mmap sem was
unlocked while doing NOWAIT - even though the fault hanlder will not
doe this.

The only caller is fine with this too.

!UNLOCKABLE literally means not to ever drop the mmap lock which is
not something KVM needs at all.

So I'd say it is fine as is. A caller should never assume that calling
an unlocked function or passing null locked means that the mmap sem
won't be unlocked while running indirectly because of other GUP
flags. If it wants this behavior it needs to ask for it explicitly
with a locked GUP call and a NULL locked.

> Since at it, the same commit added unconditional FOLL_UNLOCKABLE in
> faultin_vma_page_range(), which is code-wise correct becuase the helper
> only has one user right now and it always has "locked" set.  

Not quite, it is correct because that is the API contract of this
function. The caller must provide a non-NULL locked and non-NULL
locked at the external interfaces always mean it can be unlocked while
running.

> However it can be abused if someone reuse faultin_vma_page_range()
> in other call sites in the future.  Add a sanity check for that,
> also add the missing comment for UNLOCKABLE.

Then we have bigger problems because the API has become confusing if a
non-NULL locked somehow means 'don't ever unlock', but only sometimes.

Jason
