Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8F70BE63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjEVMb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjEVMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:31:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C7272E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YArsnv6a4Vs4sxTtO8CF6XgpSQ1gas20phyvSxwL7GLIhxqIXGk1jVXeP7YgnCuQNaef4TIbl7XsU38EW2Qh7lB8Okt6rXL3dBetc9RMUVA0YSc47M6pwg+4HowDaQ92Ggb6UAEx054IYWiEHoaSvsnNBOSuvQlAUttcJvnNrBCYGJONIvfBScXyKNYo/Bae6jYAyKwCAVBuClObkbL8FyOYieZ2t/u7nOwCBL3624S2VX4Bip0se28t1T3DTTXnYWXscQzjCg0/I2mqtgChcBTJLIguUVZob7nWFug3HuEisC+9q5DRoxGpphI5AIRDrCN1cz3mSbPNbX/2jdyyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=firQXLWtCLD5XuHzW0TiiwojH4oE52HkGVOG17isscw=;
 b=OJnt/b5ePo1fKi05EcYmHGLNpdspqUry8mtHoz82oTedU6q27WibXMLE7hbyyqpd1M5pu5t1Lls/B+cKie9kw1/MR9zv8o03JcuYPN51MbOZAQsrbmnIiQAPWYQMOUxCu7ge/MLR71O5xHM6qz7qdQSvKmC4OYq2MOekocTCFPAysiRb2y3o8855uSTXZbRiBKcCbIsAuIa10OV0BWE3dPOsqhERkcgZuBq5oo/91W/gmtzVbdfFNCVmUwFI+sy7UhIXqoSJEGtSEOSGznWns2lTdt4y+30a4tbfbGgMiJf+l/Xm06Uq7IbpUjQ+E+ayNKJuMdk/gofGgJ17jSaaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=firQXLWtCLD5XuHzW0TiiwojH4oE52HkGVOG17isscw=;
 b=A0pGFhvNVE5WgtQfQT1rtw6Is4Gh2c16hg1huU5xotBIoA5GGlJhPf1nc7RkiRLoUpOx8Ub4/4Vf4+jMUR3xx/91jMgl7JqzAS37ZdO/AfvyotrfllKM+gxFVNHfynEqLPaCkTmIZn7MfnS+C02TGyv1PtvArVkMS/QLnWvUMWL83k+i6bmVy33IEY6ft69eU//qZ7ba4emdVzn4w0CCEW11d7DwPzqqlUVFBAVaHJpEkaN7OFDrR6VEPsTFMOGiJjkJtYBFYQyYuT6MCw9cvS7uxyAOxM02y5hWjXaysJm2UPOpMxAB5mheUybov6JZOnF5mMr1nWNS8RtD3/1E5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 DM6PR01MB4777.prod.exchangelabs.com (2603:10b6:5:69::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 12:27:57 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 12:27:56 +0000
Message-ID: <3b8222aa-ac58-6a69-ac36-dfdc66f4d66e@cornelisnetworks.com>
Date:   Mon, 22 May 2023 08:27:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 09/24] workqueue: Make unbound workqueues to use per-cpu
 pool_workqueues
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-10-tj@kernel.org> <20230522064134.GA786644@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230522064134.GA786644@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|DM6PR01MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: f642e61b-d25c-4e7a-c9e6-08db5abff8e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBqj24b2/PhJXLfyYiuYbQba/GYkDUQdMZQ/0LhAevcjb7ORLhcwWmM82sjQWMuRuKdgWiw5fiVDz78VxuDn6XvMopXw9kAsF4OVCcu7FBkxbG8DRKxpkHdqdhx0PHGQwMDYG5hTtUgRoERBuK9ZQmg21i/VGtUc3X1XJZalqqq+HZY/ddflRRDzj0z8fdSuuozK6XY0tY7/HE5p+YeBtybwSutjlmFoRObCGBhqnDt/Da1MP4cIN9FdXEH7plbxqnS94rdjYHt/8YKa2+nToO16nVy4SDznQ+7boGsp7r9pOq5VZuMzXSsa9F5lyrXiBRN2SO+z0NNmaIr5G0It2gCPi0TXKxjKV6mIbNz9Qmfkep1sYO4kWzUoI+n4QNaCavAjEUW/rdAfjyTMZageLV5tj8YnGFl4ye//4fJeFA1YtYixIjSg7V7WLGNEc4JOXzGDH/4J86wc5tUFK2PRInlUnR2+aAtF/p79XZYwH6q/dz+wo5AivhxblN6b4JzxCnAu4uvgeBJuHc787OmOxy6SaZm6+o2q8HMW9nAewmKxb7ZkoYd+2Ba7YYtosF2vesgjA7liOAMcZKZqZzQMHNzek+INf9d6HL/p/suEwVY9D99IblfAtzXq/t3YuwSzP63ehBiJYz6Di5xEHTjItg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39830400003)(136003)(451199021)(110136005)(31686004)(54906003)(38100700002)(38350700002)(478600001)(4326008)(66946007)(66556008)(66476007)(83380400001)(2616005)(2906002)(6666004)(316002)(53546011)(186003)(26005)(86362001)(6512007)(6506007)(31696002)(41300700001)(6486002)(5660300002)(44832011)(52116002)(8676002)(8936002)(7416002)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xBMXY5QTREVDFXVHFlY0tJNkFic0VZUG5sUWlrQUF0K05SMDIzc29mN0NK?=
 =?utf-8?B?TFI3SjlWb3hLZytwRUN2N0xZWTBRQ05DM29kRFRueGJId2xFelBqQzk4NG9u?=
 =?utf-8?B?bmtuU05sWHFRNFZMT09ncW9EVUI3UmE0TTdlQUVnNzdVWitmaVhmZms5YnRZ?=
 =?utf-8?B?VGt1OWpuUnF1ZlZXTlE4KzB4WFpXY2p0M0cxZkNQanZjS0dJcVlGbStuQkVj?=
 =?utf-8?B?OVY5YnFMUXpoRjRhYkNPc2h5M2J6Y1dVdWM5ZUExZmYrL1k4SGtJRGExVGMx?=
 =?utf-8?B?cERUZ2ZsRHhwbmpHZ3lDSVhqb3Y3MU0xckNhcEl1Ly9NRmlpb0NtdWRKc1lj?=
 =?utf-8?B?YzhBZ1R4Y2lwM2JDWmdpa3dGSEhMaEZNK2FLcHBwQ0swUzJyTzNvQ1Q3Z3pJ?=
 =?utf-8?B?cjdWZk5Qb0Rud05jcHZ2M2pzeEMrKzYzMHBBNytuSzZ1UEJVSjV0N2xlZ0Qz?=
 =?utf-8?B?T3dTUHdQMzlhbGthSE5aTHUrdXZDV0ZmYm5TVk90cWxDdlgwT1JvUEJjOWRW?=
 =?utf-8?B?aWR5bk8rZzkxd1dvbXhPV3UwejB4eDhnc2lvaEFKRDRyWEhsbW52eXNVYU9j?=
 =?utf-8?B?cERQQ2h1VFd5V2NjWEQzYVNLbUdNb1BWdXZnMjB2eUk5SXBiYkk5dnV4NzF3?=
 =?utf-8?B?cnFxU2NXUk9LS0hmcVNDUlhGdHRCcnJ2bUl3dlBvRTFhSGJNck40UVVlL3VM?=
 =?utf-8?B?SHhvVVMwcmdOVVFSaDF5Zkgrd1JkcVVTbWloWXNlSWxOQ3I1ZlREV3crWnkx?=
 =?utf-8?B?emFTb1FIbTExWWxTa2VJRW5JTmRRVHpHNHFCcWdWUTZDeTd4S2J0RkM5ZUJ5?=
 =?utf-8?B?VFJtT1IvN1FGOWpyUUxuNTdueGlwWDdhOFdkV21xL1RHYWFGdjA5Tk9CaVRr?=
 =?utf-8?B?a1d2WGxWWGkwcldkYUsrMUtJejA0cWxyM0xRaW45dXpwOGtoM2R3cGNrTzJL?=
 =?utf-8?B?MDNFUUUrWEtjS1VKVXlQenFya2VFQm1sSFNrQ1BJQWRkRFVNMVlPeFUxSXJ4?=
 =?utf-8?B?YlJ5WjZrRWY2Q3F0U216TEFYR2lXT1prRmd0MDVSVW9wTWI2Mnc3SnNpRWJp?=
 =?utf-8?B?Z3lndmlMdjl3Z0ZkUVhaVFA2bmhYTitTN21mdTNTTlNrazhFNXlCNFBzUWp6?=
 =?utf-8?B?bEFQRDFRcVhqY2x2NWdwdjVpZHRKN3ltdS92TGpDeFdDai84WEpYVVFBRlE0?=
 =?utf-8?B?d2Z3R0I5MjFzOG9xYUdOYjlhb0w0ZGk5ckxvaWozcWFjVjVPRTZ0UzVBUGdW?=
 =?utf-8?B?MFd2SU5JZnFlaGw1bHJ3RzdMeDduQUhiT1NFa0h4SHQxQzIzVTJOZGhXOTFN?=
 =?utf-8?B?MWZYYVI2aHZ1cnBZVXNicmdmQUNBZHZtYTVZOHZob3QxQlh1VUdKcm03SEEw?=
 =?utf-8?B?U3FQTTBqVms0cXBxSHpqaWU2Wk5qL0VWang4LzhndTU1MHNnOE51SkFJMGM5?=
 =?utf-8?B?M3R0V2JaU2MwK3hNM1lmK213bGNQYnBPT1BlM3Z0SjZBOWRmanBzVmk1bFNE?=
 =?utf-8?B?cVBZcTJKS0NnODl5NENQb0FXOEZFblRpcXVIWi90WUl5OTdnMmVWR2FqUDFP?=
 =?utf-8?B?aWtoRVBJUTJISHZyQnNTV2pRR3RhVXBqUWU3TkFJS3h4L0ZmR2RRay9NQ0Zk?=
 =?utf-8?B?eXlLUkZsd0Y4WVhyeGRtODFuSDdTT1ZuYlRyZXl3NGd6L0c0MFVLOGhFOHRq?=
 =?utf-8?B?NnVReU5XeHlwdCsvMkFwSWprSmtYdXplbm9EeWdxKzhIT3AxRW1ZS3h0b0hM?=
 =?utf-8?B?NDVoenh3SUJIS3laNUdXakI2NmgxanJXVENTY0ZQblQ1NzBjUENJMUdkVyt0?=
 =?utf-8?B?a1NOZklSb1R1SWV4Skwza3UyTm92QjdCN0NzU3JhOWVJMGlseTVyTytMQnJ5?=
 =?utf-8?B?WGNmNVkxeGJUMGdId0Robm9kZWVKSWY1Wkx5T21nUjVVVlVsNm01MVIzS00v?=
 =?utf-8?B?cFhJRzFMNmgyeVNnd0wzYXJhRWY0SmpzOGN6T2VJOVp1MUxYMW9aeVRlOGlm?=
 =?utf-8?B?YjRHUllGbk92SFZ3TjR6MHZURDNkbTVrRkJwVytwbGo0cFlXM0tjOUJpRVNJ?=
 =?utf-8?B?bUx4R3NqUnRuem9xSlVHNkxaYnp1NVBwVk5JQnVIMGtVaGh1OUhySmNDVVkz?=
 =?utf-8?B?UEdqdWh1K1hWTGxjL0ZxZCt0TmkyR0wrNEdocEtCR1J6WERpQS9sTDZZMDky?=
 =?utf-8?Q?hOGtQeXlZGEb/fl+OKYGjLY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f642e61b-d25c-4e7a-c9e6-08db5abff8e1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 12:27:56.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQeaohdxm+AxmrPgGdCAfQyjdJ86RZOCVhzOPWFfL1unkg4/sjMwD9HQEsowzQY1B9EqBYPB9N2/8isEI1ZRT9izQx+FMk+KINqsh6gyDDc9vV0br2hgriPAeohfXXc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4777
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 2:41 AM, Leon Romanovsky wrote:
> On Thu, May 18, 2023 at 02:16:54PM -1000, Tejun Heo wrote:
>> A pwq (pool_workqueue) represents an association between a workqueue and a
>> worker_pool. When a work item is queued, the workqueue selects the pwq to
>> use, which in turn determines the pool, and queues the work item to the pool
>> through the pwq. pwq is also what implements the maximum concurrency limit -
>> @max_active.
>>
>> As a per-cpu workqueue should be assocaited with a different worker_pool on
>> each CPU, it always had per-cpu pwq's that are accessed through wq->cpu_pwq.
>> However, unbound workqueues were sharing a pwq within each NUMA node by
>> default. The sharing has several downsides:
>>
>> * Because @max_active is per-pwq, the meaning of @max_active changes
>>   depending on the machine configuration and whether workqueue NUMA locality
>>   support is enabled.
>>
>> * Makes per-cpu and unbound code deviate.
>>
>> * Gets in the way of making workqueue CPU locality awareness more flexible.
>>
>> This patch makes unbound workqueues use per-cpu pwq's the same way per-cpu
>> workqueues do by making the following changes:
>>
>> * wq->numa_pwq_tbl[] is removed and unbound workqueues now use wq->cpu_pwq
>>   just like per-cpu workqueues. wq->cpu_pwq is now RCU protected for unbound
>>   workqueues.
>>
>> * numa_pwq_tbl_install() is renamed to install_unbound_pwq() and installs
>>   the specified pwq to the target CPU's wq->cpu_pwq.
>>
>> * apply_wqattrs_prepare() now always allocates a separate pwq for each CPU
>>   unless the workqueue is ordered. If ordered, all CPUs use wq->dfl_pwq.
>>   This makes the return value of wq_calc_node_cpumask() unnecessary. It now
>>   returns void.
>>
>> * @max_active now means the same thing for both per-cpu and unbound
>>   workqueues. WQ_UNBOUND_MAX_ACTIVE now equals WQ_MAX_ACTIVE and
>>   documentation is updated accordingly. WQ_UNBOUND_MAX_ACTIVE is no longer
>>   used in workqueue implementation and will be removed later.
>>
>> * All unbound pwq operations which used to be per-numa-node are now per-cpu.
>>
>> For most unbound workqueue users, this shouldn't cause noticeable changes.
>> Work item issue and completion will be a small bit faster, flush_workqueue()
>> would become a bit more expensive, and the total concurrency limit would
>> likely become higher. All @max_active==1 use cases are currently being
>> audited for conversion into alloc_ordered_workqueue() and they shouldn't be
>> affected once the audit and conversion is complete.
>>
>> One area where the behavior change may be more noticeable is
>> workqueue_congested() as the reported congestion state is now per CPU
>> instead of NUMA node. There are only two users of this interface -
>> drivers/infiniband/hw/hfi1 and net/smc. Maintainers of both subsystems are
>> cc'd. Inputs on the behavior change would be very much appreciated.
> 
> At least for hfi1, it seems like your changes won't cause to any
> differences as NUMA node is expected to be connected to closest CPU
> anyway in setups relevant to hfi1.
> 
> Dennis, am I right?
> 
> Thanks

I can see there being an impact as to when things are considered congested since
it's now CPU based vs NUMA. However, this seems like it's a good thing for hfi1.
The purpose of the code in hfi1 is to decide if QP processing should yield the
CPU and allow other QPs to make progress.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
