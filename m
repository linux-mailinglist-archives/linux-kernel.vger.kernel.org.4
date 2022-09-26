Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6371D5E9D89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiIZJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiIZJYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:24:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAAA101D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzK+W7k4MJJyOrtLEDtijW1ns0iy1FW6bCWqqWEw1HMo9ToDeergh+/X9p/TxpRsJ48bU/Thv2LEW0QCM8V4cvTcYg1MZO967dUBgerXbQA0UHO2lL/h/Gt5f9KYqiib14Sj2jR9kCYSNuPH3FH7tLiNq/FVnPLvB4JxyKxveKhKEZQOQW3NL6n3bi0wfmFRiq0nymjhnIVWkDxBNuspeDV0SoK4J3fxC38yOjwv3aUD3YSsi+1MHlRoWZv8tSJGghHQSp8z87Esns9TABp8O5NAb8PxcvlbK/d/6BUtFyqHnSGZ9gZkSetOLYApOUvbwH37qul3Vq1unm/eUWuIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6ksDM2PowsFSwcBURstAZDQlIrTQTEUyFvatXFpk2k=;
 b=JLSBF5e2/IPQc3In4139xuqx9asMaUchSKG6ZAbJME7Vs0E2m/yFu0V9spPwmfmMVK5GfB/U5NbmC9/o03Nv1vq3SKtdrE1J7Em8k3cU4gPZurNsVbPGqkICkaU1qle3yXB+udmL7dgASHUrfsH9YwSIEOb7BV/wXem1LWXeIqu7xWAV76MzueL59YV0FN/gmxQ+K8zrCTKV49NCjo9A1Ls/L4/Bqr6V7cZpbCTSXwSUj4C+DU5SfIC+XXOyUOpEIL/eTTVbVzQ3oHqsSWadrqIJVwyUKeb1VgWSCshnLhLYRYkReC+NCs/bNIGpW4OkPz8R6NwtFSrk5oJrWiigtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6ksDM2PowsFSwcBURstAZDQlIrTQTEUyFvatXFpk2k=;
 b=ok0RA0LMEsRiUoELl8gLn/ELtwf9X6d3KxMBzh53wY7ALKkW1jvsUAZmfMufdKjXxz5w1NXy9Hpol1TsOtcsV0EYG2QYsrQRnBHR6Oji2tF/qT0E59ZKl9BIhniV177oD94otVckq/29WQEPh24rOuvvhhuoI4awGy3bYfmxs30QUxkWBXmQRAeg6lC3+EyJRvIXZfCMLWfZuwswysmFiCcY3TitaDN/EoxymE/gjlgKtLEQB5zDaF+b/Ztaw7AFeS52YcTFpxAcVsHnyl5TOMd5Y9HL6sRsWG44QZV0lG+Fnpenx5RuDmSIBWj8ZhWqV2tRMAxFstOOZODNxlIhZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:24:33 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ed0:a520:ac8e:9966]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ed0:a520:ac8e:9966%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:24:33 +0000
References: <20220921060616.73086-1-ying.huang@intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
Date:   Mon, 26 Sep 2022 19:11:19 +1000
In-reply-to: <20220921060616.73086-1-ying.huang@intel.com>
Message-ID: <87sfkelc8k.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0156.ausprd01.prod.outlook.com
 (2603:10c6:10:d::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL1PR12MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 081bfcad-ce7e-4501-42e0-08da9fa0ec28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRFOEn7Kgv8Zk1u/rpCcSgUBkNjd2KQ81sIDL1ktDtn32CsAyWP07LA4gQEeP8RTRlYok3y9R9jc+gxF4HgZW6sv680vP+ykaSeC28kmREkV90RvniviJtsbqF+kjqukdMglJWYsQlNcv05rMT6G3Egn8M+xpHbG1HnBz84lWRsi/msz4bZaytSCSamXiubL+kkEupdCxfeN+6YSc/9QnYcv3YL6bxcYLWiC4aWuk1IlL3Os9Y6hqb65+8wzeGz+UJZXNDJVzpm9CT67gABns7ACQZmQen9WC5fNjCUxnpuapBYERgvw30BYn4FAlJ5iyx4sqBM3cpk4mjBjkB3z1LFI/XjSp/G2VAWB/0O+kXcCHLusWJxmkxI29cujX9sC+cuToyVZNZJND790hxlWeknem/goRVmOqj6NS9mbTWB/ZkQI5+8JFoLG7vatQ/4hIJoczaiUaL7kJrhexhF3pPPBwR1hPvNczAq4BaKKBqGEArGq6Ev+6xg8IGOEiaG9MmaeiX16TlFcKixzhIxGCQCiVSsGWaadIO6t2DXoJGqU2VN09To6Y7N/Xu2dysfZHu+9ksMR8nwLjWWUIJdOOvdj9N+HJiDPV+ettr63ZcanmTMZgFHNr+y3NsmMRQrdLEsDvAh/Eq4TJWRiwHhrZ273m3EYmIYzAGQrBtc428Y1Z2Wo7EpW+3XXIzitlikF7ofsNuNGdZi/yrnhDiYfUWpCzwN6PpbeUMSIID+L/pvmv68b91gLBH+FBIm2VVL2beawtOUn/IAb3ZfxrOYUbQ4SDiJmDp/UcRM20diSKXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(66899012)(6916009)(54906003)(316002)(478600001)(966005)(6486002)(83380400001)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(6666004)(6506007)(5660300002)(26005)(6512007)(9686003)(2906002)(8936002)(186003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3G/pLoe6tSZU+eUNKXhMvu4VGSVFcFDPJixxtzhcFLHMoucXnep0P1Jaf0a?=
 =?us-ascii?Q?q00xHfbdxRiRsE7DzeYCo7K0OmjtpRyC3a9xrB5Jnghvjb86juEG24kbCY9B?=
 =?us-ascii?Q?YOiN/IFoS4UjdnxIN1Yp21+WJEh0Dq5MKrObVMffaUjphFNVIw9UflLT/cNu?=
 =?us-ascii?Q?Xgvn1/rYVjH4DgN80I0jzBDbeEo/yIzWZ+ATCC1VppIPWXBEFCwfsqIez0+K?=
 =?us-ascii?Q?Qae0H9P+EYO5GyARHB8XY6kCS0Euy/C1df+HiuD3xmy39VQl29nJGwT8u7n7?=
 =?us-ascii?Q?tVwly5SB4SWc+xKSt10FbVtRUwo6TdXhw4w51qrnDtWcrIgGy1MgxTmA4jtI?=
 =?us-ascii?Q?dOih1++rOFCXgy9V7dj4cI+sO8bTupdlpl0rOy7HaaCRWkFZ2uhl4dSgTVRq?=
 =?us-ascii?Q?tJPwMj+pa2BEkSi+h96mY20JcZWfSo3Hp1Zkx1bGpZKsR8dD36e3udOy4XT6?=
 =?us-ascii?Q?R34rsZhkfQ6BJIqmuGWdtdUsrQPmPxGyrtJ2vEbNq0Y+8eWjIGznb0wR+Duu?=
 =?us-ascii?Q?CU5lp0YiRvEMBsMtSYzYLwwV6eJYMFbLn6pL216xpYs9BxAwmBfCrXzSFK8P?=
 =?us-ascii?Q?NNiPdPwYrEz5q0Xq+tn29wVo7NjkKRUP1YjLvx9WO4OGJjunzlvTLm0T7F8s?=
 =?us-ascii?Q?ud7J8wavzwQ3i9xrwKAxYE6ydgrUpo6qSG+1tE7K254LtiaKSg0oJch0Z056?=
 =?us-ascii?Q?Ce3hznPI+PcSzC7V3vDHvJ9FcQhmtZIs62YjSdUoAG4xlKjyoHJWJL4jpTtn?=
 =?us-ascii?Q?kPI8liXGWqBRb/bR0J9sDboJ0CmFQ7iO6h19Eoc7hiCfW0+DIEeC4D1BnVUK?=
 =?us-ascii?Q?/6jjSu1fRR8Hxw9xok96MQi/tUT7AJ4M/Vfd/+qpm6OVcUiyqXslHKq/+6O8?=
 =?us-ascii?Q?zGdVFjrQlot5dBGuT/WvUvFMyr2qYsp1tHbTTPvjmSX/ho8g49eSIayP95vj?=
 =?us-ascii?Q?gY+p3RItHxan6opfWoLKtVwxDYOU6QKedlHem6IOVUBFDDnStMWuiV0zF9Sr?=
 =?us-ascii?Q?J23jewVokvLGatx1G2Rcm5Dh7Md6Hc5OCQPytsMamo1vuPrIeBOzTwQbZ7LE?=
 =?us-ascii?Q?LNcbo8pnZ9wGMcFe9Elz1UFWPU2u7TAp0OYPXpJEQmDvdNAwkqVCWS9+g7vq?=
 =?us-ascii?Q?c0G9t13IeIW4+lHI1VE6AUnG0F+eutXhMoQT60sTZPwaVNZFcBNxro3CpyPA?=
 =?us-ascii?Q?xnl7DN8oa7i9VBc7aEXl1ogKQwy2Jrxhwg+c7dJlypaYqpmU/3mWCrup3r4c?=
 =?us-ascii?Q?/1rLDLWGoqYJh/wlg+iui9Wgw+TsGOUEqmeSM69UNjlHuDMgfHDiXWF3I2QU?=
 =?us-ascii?Q?e7WVyGznd3siaoJsgJu+qbYYfen8UcZgQqMMR3ZV1Ovz/yRdfTAVt10bmVs4?=
 =?us-ascii?Q?1Z0Irn1moM2E0GQTEDvM/GeqOTcr5NMB8yc9sFScU3wHehvPPluQpXHCUgjJ?=
 =?us-ascii?Q?7+t7Eh2FlNJ7kI0kZicMGOroOsmTM4OkcRtRyAkEcdreAUqI+xBlJ2yH4VGK?=
 =?us-ascii?Q?+HTXxpmgK3byRoBoJqQM8b2bsemcz/GK3F8G5/SOXXrWd8MbqlNjOuek1Lsw?=
 =?us-ascii?Q?xNAtJSNQOx5Aqe/56uwoZEZymhwc3Z3mi8uaUjMO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081bfcad-ce7e-4501-42e0-08da9fa0ec28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:24:33.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+Gs2jDjQeB2MiBzvYbcLBnErTPrU15pG2bWnx2XikuTUYESOuO9/0kQs8MZgNmaFsm8SbcvzJm3T2iIi4OdTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> From: "Huang, Ying" <ying.huang@intel.com>
>
> Now, migrate_pages() migrate pages one by one, like the fake code as
> follows,
>
>   for each page
>     unmap
>     flush TLB
>     copy
>     restore map
>
> If multiple pages are passed to migrate_pages(), there are
> opportunities to batch the TLB flushing and copying.  That is, we can
> change the code to something as follows,
>
>   for each page
>     unmap
>   for each page
>     flush TLB
>   for each page
>     copy
>   for each page
>     restore map

We use a very similar sequence for the migrate_vma_*() set of calls. It
would be good if we could one day consolidate the two. I believe the
biggest hindrance to that is migrate_vma_*() operates on arrays of pfns
rather than a list of pages. The reason for that is it needs to migrate
non-lru pages and hence can't use page->lru to create a list of pages to
migrate.

So from my perspective I think this direction is good as it would help
with that. One thing to watch out for is deadlocking if locking multiple
pages though.

> The total number of TLB flushing IPI can be reduced considerably.  And
> we may use some hardware accelerator such as DSA to accelerate the
> page copying.
>
> So in this patch, we refactor the migrate_pages() implementation and
> implement the TLB flushing batching.  Base on this, hardware
> accelerated page copying can be implemented.
>
> If too many pages are passed to migrate_pages(), in the naive batched
> implementation, we may unmap too many pages at the same time.  The
> possibility for a task to wait for the migrated pages to be mapped
> again increases.  So the latency may be hurt.  To deal with this
> issue, the max number of pages be unmapped in batch is restricted to
> no more than HPAGE_PMD_NR.  That is, the influence is at the same
> level of THP migration.
>
> We use the following test to measure the performance impact of the
> patchset,
>
> On a 2-socket Intel server,
>
>  - Run pmbench memory accessing benchmark
>
>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>    node 1 back and forth.
>
> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> the number of pages migrated successfully per second increases 291.7%.
>
> This patchset is based on v6.0-rc5 and the following patchset,
>
> [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
> https://lore.kernel.org/lkml/20220817081408.513338-1-ying.huang@intel.com/
>
> The migrate_pages() related code is converting to folio now. So this
> patchset cannot apply recent akpm/mm-unstable branch.  This patchset
> is used to check the basic idea.  If it is OK, I will rebase the
> patchset on top of folio changes.
>
> Best Regards,
> Huang, Ying
