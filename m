Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C4609851
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJXCqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJXCqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:46:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E0A6BD42
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfKCKGT3z3RWoqk7c03drALdfj2YNUnQcfcNMdLXCepOcOiiQ+hwlqWThvFEZQgxcbbBmUwEQ9WUQg38uUSNLCVAaKIVlqNfwa9409Vlk2yZjQ8XLATgHEjYsV+9X907DMpLVCMUz17eWUKfosT499ZqReZr1EJU0UkYjld+slE+1VhGzsDNo0p/gDQamiUb/07k2W68A5Ufo2e1rNvksvLqeEGyKwgFgTwCbScfUd0GEfJYzbY1XyD3c7Mp0FrizBcj9EwbdzMEgmnb9+fpo8GYzGJEyRyMCmBFTd/WFoJctGpUJi4Zd5dmVY8YlrvRMNB7Qx4lUKIGuucHskqHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2PR4G46XbjxCuQiqGL6vo1lfns4rMEWlOM8oM0DlKo=;
 b=JNGUw8TWOUThnwGmWL+91YKs/hG3j8D37yxKa1Xqfzavv40GhhMr7xc1ALTjlWbgRgDLlBzW1mQb9zNIEL0G6waewhjo7ISPFeSEv03affwA1obVrA2c29mkAsNr4bw1b+KzLdzenM+/t4fN+9KDwipv3aS7dthVx6f8lAS/LYjUK7JR1BJk+MyHxLZwDO13llGdTZ/PYa+3THlGI3u/MWUwmjxZ98sjDiNjMwRGxcEmVPSMzhYCOkwWN1ieRlCdkFKcg7wXvPiy9Y1ysqt/ka+/OHgFpficumUqouryLQ/LxB33qwoSFIwNmzEXyKJ+V9tD54DtInkQuhSAritNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2PR4G46XbjxCuQiqGL6vo1lfns4rMEWlOM8oM0DlKo=;
 b=oJv5prhNMneVeIIUEs1XD973r6Va8wwqYGaPENLs6Eetg+dall3E7vE3hTEV0dSBGSVmwAG7N3Y0bubDPHOeAaD2ntCcqNSWQw9K08Ylyfyc8pG87RCdA6WSzNRdCE1+WF4bVvysyK29Bjz2zQ++9RTovb7Ebg05UdmyhflC3+5vA8euWJKRYmLx/kswuEsAkDQ1G6PRMd1ig7Co8WOvMlGmcMA4JjAkL5g5+t3UhiQiyDwRZy2/cr9uYiY8/QU3KD8kBHmz8yHwgR+fOy8wt9bPR/xUEp++nNLdHlMkmYgZxYVZrYhUs65b1Gclw8NZD0hOVWQ7fP+EkDhUNj2UJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 02:46:09 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.034; Mon, 24 Oct 2022
 02:46:08 +0000
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        ziy@nvidia.com, shy828301@gmail.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
Date:   Mon, 24 Oct 2022 13:36:20 +1100
In-reply-to: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
Message-ID: <87pmeiq6qc.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0016.ausprd01.prod.outlook.com (2603:10c6:10::28)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5883800e-933c-4ecb-74b7-08dab569e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lppDaraYG+gkFVJ8YeJNzEp0Ya0JF+PPlz3o5aYx7k5GOTh4yRLJSk9B4PGSkSCUDl2n1oAuPBhbGGU+1fXDcPot+oJoWVwTPOULAyPJjJ3J+eltYtq2AlNQEIzfnVkIUQVucrrhLE2YXwrPMQA+i3Sif+PnngGclkFXn5iAkMKvulVjWbPFz0rm+5vkLRGLuvrb285jtuq85bWo6SOIBdQfLk+injtyHPDzeuAGmijRmtwg7iBzyKUD7uPYcx/ab/09vYrZUCKNHYruF0HmdprnNPVY9PK2cD6aPO6HnokFH+JR57d5fl84ieC5gIEVrFubFErs7fi8WY2UCOWuuNOEyZMwemWGep8FiOeQ302NZu2mW7CSn5H9m20mrotg3aLkwv+6oueQvob2IT/zfemkVmbnOAoq2Fk/VCRkDW0lGCbqx7cgcn7WSR0MBFPxvttAW0dtm4mqEiH9wDcsTgV1uZqv2Uh02cQ6jOkqp+ISfE193WodcHfzevoaZZay7HEbyT9eKj/b+p1/RIpoHywXER034jCK2KudqRiHOlui/rh9ruuRWPQCwAHFMTIx9pDuOsWqKc8FkP2hdCopWOk2VOSpZ+f18LwSul3Pix3cRbgOzhfEo0xlVSFyEiLlgDyv0NGFz70wbAJnFzkP/34Hsq38/nYR6EpnjYgB39UBCRD4cskh++ekqOwY4pYMkdEwjWGMPMqDh439qnIKeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(66476007)(4326008)(478600001)(6666004)(41300700001)(66556008)(66946007)(316002)(5660300002)(8676002)(26005)(6486002)(6512007)(2906002)(6506007)(86362001)(186003)(38100700002)(36756003)(2616005)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnPiTjYxjpHDgUtwieteHmjAFgr0ZUjjmir2ryJY42DZyqHBhNrBnh/Khk8Z?=
 =?us-ascii?Q?GFnJbNXiuk6FwC/Js+PG1QiSC5Kx5yfTEgfs5eArPr6j81N7dzIbOewovf8b?=
 =?us-ascii?Q?d0G2kkpm8IXqWuE6TP6xiLsRUgpCybvxvOzOcYKCc0QoPeSI+Cx0UOvr99y/?=
 =?us-ascii?Q?FbZmgBPAHx6JgafzSnVuYc/w5uFPd5YYVJH9oQG8b0rI365X4ND2nWXQDoK6?=
 =?us-ascii?Q?ipgLkmEh92i1nWCLNwnYNRHOkdmNQDntz2pA41Sprx90mT5ZYu4Nb6P3WjyM?=
 =?us-ascii?Q?O4OOPpmhf1raQl8t3FtqsohY8ytGDN8Fg14DCO6ryApCmG+Zj2UC71gMFoGY?=
 =?us-ascii?Q?RUe0zGI32uqTaQfDsYzKs4Dei2jEpSKWu6T8H0z0ghRldunOt+jRSLkdMMK9?=
 =?us-ascii?Q?taoypd37e+A50Hp+pbGCRALEyC+3xtCyZK+AhogZ7oQyZzbeDAbzokp0X/4w?=
 =?us-ascii?Q?8+ORolJmyBZVpBd+OLBY10FA2OvTikBxefoihJq4ToGaL995bqWqEVvwxPJh?=
 =?us-ascii?Q?zyPnvQ77e67r9UBf1KRiENhnTt8mWLFatq6eeDmDt12nbpVU1akWooqlhik7?=
 =?us-ascii?Q?gWTGKD2Ib8SJFSapiALlbTkI6/EE71Xye97YEn0mdhgSPX7ANS20D84nYW8O?=
 =?us-ascii?Q?GpxggJSocbEa/2TtYpD1JEiLpfcRc8cELPZ/S4RvyTRJAOMLYVqxUQ/t6wKW?=
 =?us-ascii?Q?PvdyX7rwNbaTBF5a3E3UTrhedDIeEFUYcja/xB1YVxuPyhzfxx2xPfZ0WwQM?=
 =?us-ascii?Q?AeGFdwQQBR1iqxqHpf/ISIYp+kEKRoO9CY+McD5qk5lbK/Brm1b88AuL/CPX?=
 =?us-ascii?Q?ZUG/aVpWT+bo05kb2jvXmZUHgcUkdPu489K/ubsOrTYwBNH4QC6BaAhWtmYV?=
 =?us-ascii?Q?visQRNd+HGDKiGNEcR7H68JmXYykaA3bf3le6R4oDvTRw3Dcr9EWqQFGr7tN?=
 =?us-ascii?Q?MEW/RTicm/LScHHeAmUYg5v3lUPX7wYuQZ7swCuAVDNw/oel2y/FfXv5GFd+?=
 =?us-ascii?Q?fKvy7s7HWx94fLZneHi9pK+NkPlX0HWcF9T6lDODdWiks7cz+7q9FeJmqxD0?=
 =?us-ascii?Q?HdUktcbhPqLhV0eevgjIQKruuwWTP39wDeNvJxyQMX71peWr6JhcjcCz5yMD?=
 =?us-ascii?Q?JTEk8bDG1TWQi+3Owe42bxyCtPH1I2TwEOK2giDwcM81qMsTYco1yNqg4z5I?=
 =?us-ascii?Q?rf1Zb+7RKLn9e3Fuj5Su1V8bJDDqZieCfRlHwtpOtQD1wSRu9YZ+KzjRZgPu?=
 =?us-ascii?Q?CfHFzHxzj7KM2zOBJumUkDl5mrhPn1FkB3TpjRYqRAjrbGuNKGIHFhJoD8aS?=
 =?us-ascii?Q?s53wavnTaOH6uqd/SLCe7QeFEzuYnhKzXnIZd8kyJ4X7Xc6ipQTVceTHeDkT?=
 =?us-ascii?Q?sjllb9EPpNODjPpakNx96BV7/kMiSzFOt51uMKTexW9q853zEmR7q/OIJxpZ?=
 =?us-ascii?Q?v1TwzHSR8psivx+yk4zB9C97KaCRTTxIeNZUcpr0LPMQpZB4TCXTUjdBJ88V?=
 =?us-ascii?Q?soSP5I8CiZefvMvfFoiCNAIeLzsissI7InXub19WQYs7U0EipqKsAVvO38aq?=
 =?us-ascii?Q?vg3Dwatuz54nqEbZnkjYNGMY9EtKM2+BYiPnKSl6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5883800e-933c-4ecb-74b7-08dab569e741
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 02:46:08.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bulmRrtIGKXTRDbPuJ3F38vJe4jdwIscqOqhknTCE12zOLcjS9hq/KvjAMsmSd7QEmYsL+4Ujggm9K3RuYYFMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> When THP migration, if THPs are split and all subpages are migrated successfully
> , the migrate_pages() will still return the number of THP that were not migrated.
> That will confuse the callers of migrate_pages(), for example, which will make
> the longterm pinning failed though all pages are migrated successfully.
>
> Thus we should return 0 to indicate all pages are migrated in this case.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v1:
> - Fix the return value of migrate_pages() instead of fixing the
>   callers' validation.
> ---
>  mm/migrate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8e5eb6e..1da0dbc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1582,6 +1582,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	 */
>  	list_splice(&ret_pages, from);
>
> +	/*
> +	 * Return 0 in case all subpages of fail-to-migrate THPs are
> +	 * migrated successfully.
> +	 */
> +	if (nr_thp_split && list_empty(from))
> +		rc = 0;

Why do you need to check nr_thp_split? Wouldn't list_empty(from) == True
imply success? And if it doesn't imply success wouldn't it be possible
to end up with nr_thp_split && list_empty(from) whilst still having
pages that failed to migrate?

The list management and return code logic from unmap_and_move() has
gotten pretty difficult to follow and could do with some rework IMHO.

>  	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>  	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>  	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
