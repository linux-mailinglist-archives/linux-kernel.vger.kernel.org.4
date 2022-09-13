Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660B5B6786
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIMFxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIMFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:53:36 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B7564C1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:53:30 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D5jv16008492;
        Mon, 12 Sep 2022 22:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=fJ693nI4YbDQnxuiliylkGwfeT8YsOETYZiQ7Gnk9O0=;
 b=QKUcbPtrd79NtaxYzE9ZvTTFt5lFnyugFh/jjPFF1mIlx5IbDzMxKeMBjdrDBLqqPA1+
 Cmk9cD0WrOnQHmfJLDpgS8k73+LYbQxw0P/iQ0SDdgxkHt5NpVRpd4lffttAkn1jUKWq
 WhIEdoaVYD7kp0kX9cbWtoPBq/KIxuo06I/ULe53+erRfTgwSHw+kHidVs29teMRiFNi
 Gfv6caL1oP9omifOSPqEZfN4kBy985cW4MhJTnue5+9g+I+IY2jGtHwT333WcjuoZWz/
 eeGdPbx5fj+lUGOGl99kiKChy59iIWIy/IvvsxXT+vgEgocs0aCDnHjBe3IzzifunGqI xw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jgnv6ap1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 22:53:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZdckEi5CRStNwEGZyf02fLY1rGoiqvUwq8LwtTFd5w7qE9S50zAgtHC39pzToMETlyKSvedt/rAfbcOmz4Z3c6uTZczT6Z7423USi7WZCR41aw0A0Fo64ll6kx8OdkOAI1syXhpWiVfzpsvXLSFoJnjtNFfshB3oufDUscWvwtnBF+qJYgv9t965XghyyrQdpyeLRlUnVRHzmnIuyBiRb+WaNhYQZjHWXCIbdfF2WA6gbQD2fPx1NSYvKqXCWRdFnlxyf9Pm1eHPwLhpdIp7oMvByWV60zWgjFpm/rdzaSSHbduZsgIzaQoRhtusfmfwR4mYL5CbDb77WwVVwHiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ693nI4YbDQnxuiliylkGwfeT8YsOETYZiQ7Gnk9O0=;
 b=aTC0E3iAwYoMpU8/i4pIU/F932poLPm7chDc3mGnf5yNCzhuHmKXOUK2AKvYcYpb62OvKNFefzaxuvnPI54n1/n2VCx5fwfXzX3JzrdbaAnW8d1zxndQ4EmsebIrkV3P2YXk4S0BdE8heLf8cZeDDCjqqIL6Ks3rYcrdzLeXIrovw1PPadMzwyaoyIejNjdnh1xCkeORqN3RAZ4OijrT9cz5a1yCqBK+0oFQs/b4Rw30/pCXhKbQDnUaCz8vlt9us8U559x7ffnFcQXCH6163S6+TU5MNqczROf5yqTztzYUUAue/G2kCS80kE7wFI5xM2Xa1HBbB93b8ywpo1kC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 05:53:01 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::1432:3513:f388:e431]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::1432:3513:f388:e431%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 05:53:01 +0000
Subject: Re: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to
 blktrans_{open, release} to avoid race condition
To:     ChristophHellwig <hch@lst.de>
Cc:     MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220809075753.21950-1-liwei.song@windriver.com>
 <20220809080809.GB14727@lst.de>
 <7f925359-69b0-49b1-cdbb-337912da4f9c@windriver.com>
 <4910c707-ad97-362f-911a-79e438e6e8ff@windriver.com>
 <cf66e306-f216-5247-7cff-36ce08eb4512@windriver.com>
 <20220909143620.GA9978@lst.de>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <963931f5-88da-a3f0-a963-3291636fe624@windriver.com>
Date:   Tue, 13 Sep 2022 13:52:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220909143620.GA9978@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5348:EE_|SJ0PR11MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dce41f-e8a9-486e-c36e-08da954c37b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lwvmj6DQwRNJtcXt/OAEQyiPWj+JO2wteRMZyzPiSLbX8hd6azBVF4+fItn1+36a9Ie1b9vpoA910mLKM57LDu4QDINcoWvmUcXtYOdljpcqIVK968tVaTKmjmjLqTGT4wf0lchFyRors6pqICei/dc4JAW2HxMGTfty6J+fxg66wh6xLsCuA3I6n2RpyoqFkr36FFiAXJRaaToy6z4F6qZVHh9F6XTjCXfKVjg/Dnrc7lULFUDI4qyurFARAprrDIqLFKAOTiEW7/1AQpe6KKDmrZjwP8vgxM2KmvVoPoahE3IAQaLhyEXZSVfKXNo458Ui1yhILMo8srRrrEnyJt9mLrGLbpnVFed9Sfx0I3558fGe2uMMm9DUOfxCYLV+6IZT6M4KSZFLIx4raGh/MRdvOO8HFUas0FnHY3KbEHGKlIGIbPNXFGfRfB2u+5AJOcxGXLG/UdCE12qi2BwhZDKtTeh8NqdntuN8K+tf9Tyo0R9u39ysmpAfaVTGGtgDi2qNQM0AJHjKe/vSXTC2mOpt0gBcTU2zR7k8vce09XsmQrDQdUVaYElecGrlZ7qXzAVWRQ+tIx5NGpgdZ9EjSZjoTW/aTogjG+MvM7JzAVW3pvUzaajoN4T0v+LsoiwwmTpOllV+u/MX2U/vOHY07UfGrZFolD8YcgT+0Ou/v0YizJauncNcv9V9FF5rzUB5s09ulasODt4W1qAV83Ubnnaif0FDurv+g6Z4e6RKIDp2SQKYZD3oXj5c/cZbvsJ1qSCBshBh/FB46wM2Hw3ChwDNZEpbgTweJIxbGhCKu30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39850400004)(376002)(346002)(451199015)(6666004)(31696002)(6486002)(186003)(86362001)(53546011)(316002)(41300700001)(36756003)(478600001)(8936002)(54906003)(83380400001)(6916009)(38100700002)(31686004)(4326008)(66556008)(6506007)(6512007)(5660300002)(44832011)(66946007)(26005)(2616005)(8676002)(66476007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3U3bVdjYXJkR20vcWZLcXprV0g5Q21rakJZYVNDcEFFcm9JRVpjSGFsdytp?=
 =?utf-8?B?Z2NTSkFlWWRPVXVDb1JRSTkwK3ZvdjIxKzJoODQxaStqRXRSSjY1VkxMdzFz?=
 =?utf-8?B?MWJyOEc4Tkh4QjZTUGtBODI5dHBKbC9QVlREMEl4SlhkSjFTTXV6VXM4dGV5?=
 =?utf-8?B?ZzVoUUl6dU5wazZOSzdXWWdEZFB5QVptRU5Tc3Y1VjlTanVMYUZUcnVFU1E0?=
 =?utf-8?B?V1R3RDV6M2ZOeGpmK3YxUGFndEk3ZGE5akdaYzBXY2F2Q0tIeS82cTNnN0JZ?=
 =?utf-8?B?QjdTWEpyMUlxeTI3OEUyM0d5cDhJNXltM0lqanFrb0ZjOUJRQjh1bWpZbGcx?=
 =?utf-8?B?elluN2t6S0JJRGJmeVNZeW5kOVN2czNPSjJiRUNMRTdOaTMrR1B0SmNISnhz?=
 =?utf-8?B?SXE0bVVoTGdqYUY1Z1RFZytrQUMwRGRhSVZjYVpKSzRsb05CdUhIR0JXSm5F?=
 =?utf-8?B?eGo3blRXWk9BVXpXUlVnQWxJV3BndVRra0U0NlRJcGdKSmk5ZkRpbVVTVDVK?=
 =?utf-8?B?QUJ2V3NJL0pqODFvT3Q0VnFKK215a0ZJQVlsdDg0QWkrSWowVFFsOUdUTit1?=
 =?utf-8?B?VFRIWld5V3NqWEZURjdWVEgyT3k0RW5TRmc3RUpNTFdlR3VzYnd2QVFNVTJQ?=
 =?utf-8?B?MDZzN1ZXUm9NTkZLYStGMlRjbzRuY1NEME5WVmVqMXA5WDdVcDJxY0dXRmFO?=
 =?utf-8?B?VmNQRENNbEh0TGNIMDFYeDZRbG1TNFFpT0YvMkU1N1ZmcVN5WkJndTBZSDRs?=
 =?utf-8?B?Z1p1Nk1WQ3kraUZTd1U3bmpIc1Q4emhnYUQ5QXRaakdVK3ViRTRrWkF1ZFUv?=
 =?utf-8?B?M1JPc0dhN3l0TWR6YWZmNVY3ZTZ2aU1vSE83d1NGVEZXS21RWStsd0JMVWFP?=
 =?utf-8?B?b2o4WE8rcE9rbXZYSDNrN1pCQmpYbmd2YVdWZUtwbFdMZTFhUTUxT3cvNXlj?=
 =?utf-8?B?cjBCckR5YjdpcHZqeU8zcEpOdUJhbzlMaHJ0MXQ0a01yeVdTMFN3OCtZaEVM?=
 =?utf-8?B?TDFNd2ZzaCtjdmFUNkNEVWJFNExXNHFrTllSQy9FT3pkTjZFOVpwcWVjSkIy?=
 =?utf-8?B?cHk4V1E1RkpaVk9PVnZGUHFlNUVucFAzTFdtQ0E1dEZRYnBnZFc4SS9Oc3BT?=
 =?utf-8?B?bU9UUnRvalp6Sk9HTGZiZFRxTUZGL0Yza3JlTGZpZDBFMGNMSkw3RDMzMUdY?=
 =?utf-8?B?SWswcTVyem1LcXIzTWlsWXp0Y2RJdWVzY0RDejJMZXhrbjE0TDVncW5FdGMv?=
 =?utf-8?B?akxtWTVqUUJIYzJqYUZQdWtvbWxtSUN5M0VCK24xbHk1ckVpVmhBUUhQeCtK?=
 =?utf-8?B?R1NEMmoxc21yc3pmdGJVRlIxbXdrYU96KzdrQ2tNbVF0UVRwODlqZmVGNDBz?=
 =?utf-8?B?SDVzK2wyQzJqdHdRdkRGMmVtWjd4dFFOR3lmQ1o0Smc1S2cvNWxobkpnaGRJ?=
 =?utf-8?B?QVZjcE5BNFkrRkZRM3pxV21KcmRTc05ock1XOENBeU5uNDhIMUt0ZnB5azFN?=
 =?utf-8?B?djBMSW5UZmliaGVweWhUNHlZWmdTbExzSUZFTUVmaGRzdUx0UHkwRXAvSFBx?=
 =?utf-8?B?bG9LNExhdHhmWVByaWovTDRsV3lqL2NOS2FrUUFrNCtEb2F1NEFCam9MY1pw?=
 =?utf-8?B?OHNIdHJwbWg1aVh4MStRV0VMNGFwcVdLQU84OU1wTDYxWks2K2pkOGI4aVJB?=
 =?utf-8?B?ZXdYS3Y1VXBsYmJIV3R1NTBXd2tESmpJUmtobElsbm1nZm8vUFlqYnQzNkt1?=
 =?utf-8?B?SjNweUVWSjNPcjRRS2Vlc056Vi9na1hSbGVBR2tFSE15UVFqREJvNzNFbUhJ?=
 =?utf-8?B?amtadlM1UWQ3N21ZWnhNZ0pvSTFkbFBsMExWUWxPMFNGVlJGc2J1U3RqZk5r?=
 =?utf-8?B?b1FsQi8vL2FCcG9WejRGTEVtSGY1NFZ6cEtpVE5Sd0syOVVDdGpYQWYwQlpM?=
 =?utf-8?B?U3QxaEltVkwwc2ZPRGQrbkkxL05ZTEFZMUk5SEp6UGM4TUJ5UEJwWHBwaEI5?=
 =?utf-8?B?dTRoazBTb0M4MkROWVhKcnpzTkRVaFpoRDhTM0cvSVNmdUhDYXhTRGJMZitJ?=
 =?utf-8?B?Y1hEZ0l0WnhQN09qb0RBWFhGMElsRXcwZWw5Ym02c2FNRlpaWWI4R2FFdVd3?=
 =?utf-8?B?S1FWYXhLYXRXaCtiSlQ4QS92aVRMdzB1Rm1VaEdhc2hMUUNYZERwZzN5ZjBp?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dce41f-e8a9-486e-c36e-08da954c37b2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 05:53:01.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gTRLoH3BqFWM/vDRyCV5nDzgruKMvQWIu0u8jW9UwzOmOdQ+5QVftEhk8/fJjb0Q79QH/ptkOzf5Mt3d+gavXHYi86PurFMPE48cq2DGqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-Proofpoint-GUID: 4_5-8cfdztlw1w9Q2-U7MhDeo12JgZQD
X-Proofpoint-ORIG-GUID: 4_5-8cfdztlw1w9Q2-U7MhDeo12JgZQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130026
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 22:36, ChristophHellwig wrote:
> Can you try this patch (it'll need to be split up into a few if it
> works):

Hi Christoph,

Thanks for your help,
With this patch, the race condition issue I met can be fixed, but there will be
a deadlock issue as below when boot the board:

[   10.277872] ======================================================
[   10.282765] WARNING: possible circular locking dependency detected
[   10.287661] 5.18.0-yocto-standard+ #4 Not tainted
[   10.291078] ------------------------------------------------------
[   10.295967] systemd-udevd/173 is trying to acquire lock:
[   10.299994] ffff800009999150 (mtd_table_mutex){+.+.}-{3:3}, at: blktrans_open+0x60/0x128
[   10.306854] 
               but task is already holding lock:
[   10.310097] ffff000180832718 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xf8/0x2f8
[   10.317464] 
               which lock already depends on the new lock.

[   10.321749] 
               the existing dependency chain (in reverse order) is:
[   10.326659] 
               -> #1 (&disk->open_mutex){+.+.}-{3:3}:
[   10.330373]        __mutex_lock+0x90/0x8f8
[   10.333202]        mutex_lock_nested+0x54/0x70
[   10.336365]        bd_register_pending_holders+0x30/0x120
[   10.340489]        device_add_disk+0x1f4/0x370
[   10.343669]        add_mtd_blktrans_dev+0x304/0x468
[   10.343691]        mtdblock_add_mtd+0x7c/0xd0
[   10.343702]        blktrans_notify_add+0x50/0x70
[   10.343713]        add_mtd_device+0x40c/0x460
[   10.343724]        add_mtd_partitions+0xa0/0x1a8
[   10.343735]        parse_mtd_partitions+0x1b4/0x400
[   10.343746]        mtd_device_parse_register+0x94/0x2a0
[   10.343757]        spi_nor_probe+0x220/0x2e8
[   10.343767]        spi_mem_probe+0x74/0xb0
[   10.343777]        spi_probe+0x88/0xe0
[   10.343787]        really_probe+0xb0/0x268
[   10.343801]        __driver_probe_device+0x7c/0xe0
[   10.343811]        driver_probe_device+0x50/0x100
[   10.343823]        __device_attach_driver+0x98/0xd0
[   10.343833]        bus_for_each_drv+0x74/0xd8
[   10.343844]        __device_attach+0xf0/0x150
[   10.343854]        device_initial_probe+0x24/0x30
[   10.343865]        bus_probe_device+0xa4/0xb0
[   10.343875]        device_add+0x424/0x8b8
[   10.343884]        __spi_add_device+0x7c/0x120
[   10.343898]        spi_add_device+0x4c/0x80
[   10.343909]        of_register_spi_device+0x228/0x380
[   10.343920]        spi_register_controller+0x3c4/0x718
[   10.343931]        devm_spi_register_controller+0x28/0x80
[   10.343943]        cqspi_probe+0x714/0x9f8
[   10.343952]        platform_probe+0x6c/0xd8
[   10.343962]        really_probe+0xb0/0x268
[   10.343972]        __driver_probe_device+0x7c/0xe0
[   10.343982]        driver_probe_device+0x50/0x100
[   10.343994]        __driver_attach+0xa4/0x100
[   10.344004]        bus_for_each_dev+0x84/0xd8
[   10.344014]        driver_attach+0x30/0x40
[   10.344024]        bus_add_driver+0x160/0x208
[   10.344034]        driver_register+0x64/0x110
[   10.344045]        __platform_driver_register+0x34/0x40
[   10.344054]        cqspi_platform_driver_init+0x20/0x28
[   10.344068]        do_one_initcall+0xa4/0x440
[   10.344080]        kernel_init_freeable+0x320/0x378
[   10.344092]        kernel_init+0x2c/0x138
[   10.344104]        ret_from_fork+0x10/0x20
[   10.344115] 
               -> #0 (mtd_table_mutex){+.+.}-{3:3}:
[   10.344137]        __lock_acquire+0x1118/0x15d8
[   10.344148]        lock_acquire+0x2b8/0x3f8
[   10.344156]        __mutex_lock+0x90/0x8f8
[   10.344166]        mutex_lock_nested+0x54/0x70
[   10.344177]        blktrans_open+0x60/0x128
[   10.344189]        blkdev_get_whole+0x3c/0xb8
[   10.344203]        blkdev_get_by_dev+0x1ac/0x2f8
[   10.344211]        blkdev_open+0x64/0xb8
[   10.344219]        do_dentry_open+0x1b0/0x3b8
[   10.344234]        vfs_open+0x38/0x48
[   10.344243]        path_openat+0x758/0x938
[   10.344255]        do_filp_open+0x94/0x118
[   10.344267]        do_sys_openat2+0x234/0x308
[   10.344278]        do_sys_open+0x84/0xc0
[   10.344286]        __arm64_sys_openat+0x2c/0x38
[   10.344295]        invoke_syscall+0x64/0x138
[   10.344309]        el0_svc_common.constprop.4+0xf8/0x118
[   10.344320]        do_el0_svc+0x80/0xa0
[   10.344330]        el0_svc+0x68/0x1c8
[   10.344339]        el0t_64_sync_handler+0x88/0xb0
[   10.344349]        el0t_64_sync+0x15c/0x160
[   10.344358] 
               other info that might help us debug this:

[   10.344362]  Possible unsafe locking scenario:

[   10.344366]        CPU0                    CPU1
[   10.344370]        ----                    ----
[   10.344373]   lock(&disk->open_mutex);
[   10.344384]                                lock(mtd_table_mutex);
[   10.344395]                                lock(&disk->open_mutex);
[   10.344406]   lock(mtd_table_mutex);
[   10.344416] 
                *** DEADLOCK ***

[   10.344420] 1 lock held by systemd-udevd/173:
[   10.344427]  #0: ffff000180832718 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xf8/0x2f8
[   10.344457] 
               stack backtrace:
[   10.344465] CPU: 3 PID: 173 Comm: systemd-udevd Not tainted 5.18.0-yocto-standard+ #4
[   10.344476] Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
[   10.344483] Call trace:
[   10.344488]  dump_backtrace.part.6+0xf4/0x100
[   10.344498]  show_stack+0x2c/0x48
[   10.344508]  dump_stack_lvl+0x9c/0xcc
[   10.344522]  dump_stack+0x14/0x2c
[   10.344532]  print_circular_bug.isra.49+0x1a8/0x200
[   10.344546]  check_noncircular+0x124/0x138
[   10.344557]  __lock_acquire+0x1118/0x15d8
[   10.344566]  lock_acquire+0x2b8/0x3f8
[   10.344574]  __mutex_lock+0x90/0x8f8
[   10.344585]  mutex_lock_nested+0x54/0x70
[   10.344595]  blktrans_open+0x60/0x128
[   10.344607]  blkdev_get_whole+0x3c/0xb8
[   10.344618]  blkdev_get_by_dev+0x1ac/0x2f8
[   10.344627]  blkdev_open+0x64/0xb8
[   10.344636]  do_dentry_open+0x1b0/0x3b8
[   10.344647]  vfs_open+0x38/0x48
[   10.344656]  path_openat+0x758/0x938
[   10.344666]  do_filp_open+0x94/0x118
[   10.344676]  do_sys_openat2+0x234/0x308
[   10.344687]  do_sys_open+0x84/0xc0
[   10.344695]  __arm64_sys_openat+0x2c/0x38
[   10.344704]  invoke_syscall+0x64/0x138
[   10.344715]  el0_svc_common.constprop.4+0xf8/0x118
[   10.344726]  do_el0_svc+0x80/0xa0
[   10.344736]  el0_svc+0x68/0x1c8
[   10.344745]  el0t_64_sync_handler+0x88/0xb0
[   10.344754]  el0t_64_sync+0x15c/0x160


Thanks,
Liwei.


> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 60b222799871e..9eda1dd98a406 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -24,24 +24,16 @@
>  
>  static LIST_HEAD(blktrans_majors);
>  
> -static void blktrans_dev_release(struct kref *kref)
> +static void blktrans_free_disk(struct gendisk *disk)
>  {
> -	struct mtd_blktrans_dev *dev =
> -		container_of(kref, struct mtd_blktrans_dev, ref);
> +	struct mtd_blktrans_dev *dev = disk->private_data;
>  
> -	put_disk(dev->disk);
>  	blk_mq_free_tag_set(dev->tag_set);
>  	kfree(dev->tag_set);
>  	list_del(&dev->list);
>  	kfree(dev);
>  }
>  
> -static void blktrans_dev_put(struct mtd_blktrans_dev *dev)
> -{
> -	kref_put(&dev->ref, blktrans_dev_release);
> -}
> -
> -
>  static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
>  			       struct mtd_blktrans_dev *dev,
>  			       struct request *req)
> @@ -187,63 +179,58 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>  	struct mtd_blktrans_dev *dev = bdev->bd_disk->private_data;
>  	int ret = 0;
>  
> -	kref_get(&dev->ref);
> +	if (disk_openers(bdev->bd_disk) > 0)
> +		return 0;
>  
> -	mutex_lock(&dev->lock);
> -
> -	if (dev->open)
> -		goto unlock;
> +	mutex_lock(&mtd_table_mutex);
> +	if (!dev->mtd) {
> +		mutex_lock(&mtd_table_mutex);
> +		return -EINVAL;
> +	}
> +	ret = __get_mtd_device(dev->mtd);
> +	mutex_unlock(&mtd_table_mutex);
> +	if (ret)
> +		return ret;
>  
> +	mutex_lock(&dev->lock);
>  	__module_get(dev->tr->owner);
> -
> -	if (!dev->mtd)
> -		goto unlock;
> -
>  	if (dev->tr->open) {
>  		ret = dev->tr->open(dev);
>  		if (ret)
>  			goto error_put;
>  	}
> -
> -	ret = __get_mtd_device(dev->mtd);
> -	if (ret)
> -		goto error_release;
>  	dev->file_mode = mode;
> -
> -unlock:
>  	dev->open++;
>  	mutex_unlock(&dev->lock);
> -	return ret;
>  
> -error_release:
> -	if (dev->tr->release)
> -		dev->tr->release(dev);
> +	return 0;
> +
>  error_put:
>  	module_put(dev->tr->owner);
>  	mutex_unlock(&dev->lock);
> -	blktrans_dev_put(dev);
> +
> +	put_mtd_device(dev->mtd);
>  	return ret;
>  }
>  
>  static void blktrans_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct mtd_blktrans_dev *dev = disk->private_data;
> +	struct mtd_info *mtd = NULL;
>  
> -	mutex_lock(&dev->lock);
> -
> -	if (--dev->open)
> -		goto unlock;
> +	if (disk_openers(disk) > 0)
> +		return;
>  
> +	mutex_lock(&dev->lock);
> +	dev->open--;
>  	module_put(dev->tr->owner);
> -
> -	if (dev->mtd) {
> -		if (dev->tr->release)
> -			dev->tr->release(dev);
> -		__put_mtd_device(dev->mtd);
> -	}
> -unlock:
> +	mtd = dev->mtd;
> +	if (mtd && dev->tr->release)
> +		dev->tr->release(dev);
>  	mutex_unlock(&dev->lock);
> -	blktrans_dev_put(dev);
> +
> +	if (mtd)
> +		put_mtd_device(dev->mtd);
>  }
>  
>  static int blktrans_getgeo(struct block_device *bdev, struct hd_geometry *geo)
> @@ -266,6 +253,7 @@ static const struct block_device_operations mtd_block_ops = {
>  	.owner		= THIS_MODULE,
>  	.open		= blktrans_open,
>  	.release	= blktrans_release,
> +	.free_disk	= blktrans_free_disk,
>  	.getgeo		= blktrans_getgeo,
>  };
>  
> @@ -318,7 +306,6 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>   added:
>  
>  	mutex_init(&new->lock);
> -	kref_init(&new->ref);
>  	if (!tr->writesect)
>  		new->readonly = 1;
>  
> @@ -410,6 +397,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  
>  int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
>  {
> +	struct mtd_info *old_mtd = NULL;
>  	unsigned long flags;
>  
>  	lockdep_assert_held(&mtd_table_mutex);
> @@ -438,13 +426,14 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
>  	if (old->open) {
>  		if (old->tr->release)
>  			old->tr->release(old);
> -		__put_mtd_device(old->mtd);
> +		old_mtd = old->mtd;
>  	}
> -
>  	old->mtd = NULL;
> -
>  	mutex_unlock(&old->lock);
> -	blktrans_dev_put(old);
> +	put_disk(old->disk);
> +
> +	if (old->mtd)
> +		put_mtd_device(old_mtd);
>  	return 0;
>  }
>  
> diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
> index 15cc9b95e32b5..41a81fc9f0462 100644
> --- a/include/linux/mtd/blktrans.h
> +++ b/include/linux/mtd/blktrans.h
> @@ -7,7 +7,6 @@
>  #define __MTD_TRANS_H__
>  
>  #include <linux/mutex.h>
> -#include <linux/kref.h>
>  #include <linux/sysfs.h>
>  
>  struct hd_geometry;
> @@ -26,7 +25,6 @@ struct mtd_blktrans_dev {
>  	unsigned long size;
>  	int readonly;
>  	int open;
> -	struct kref ref;
>  	struct gendisk *disk;
>  	struct attribute_group *disk_attributes;
>  	struct request_queue *rq;
> 
