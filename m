Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1674A3BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGFS1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGFS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:27:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2105.outbound.protection.outlook.com [40.107.93.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B24E72;
        Thu,  6 Jul 2023 11:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBJuQNs9i418IOxohcCs854cPHLx+AU7V0/p1l30UVtFdp0WVkRoeoaym+VuE0sQOxD7QmzDmHHkCfPdSgMGhQYHzzw1zWjQls/uc9TcPzrSuaUMDDYuRM6jsf1NbUZuDBvfDS+pndIyfa9R0JKWYuKBRYkt+lb2poh0YYU6rGc8jMaWiIEupC3VcQGw0tuTA929I8osLtXzA24A997A1WAUWVRt5YaPmvWUUG0EBKPiF1cLlHM6voWHwog/pYzafrfIUa5XdGjS9i3Nx2zHTwrcLPcaFapiwZZXL8YDlyBCAolg7zDmqtVFKohoFc3zFua24yP5SiaZjyMZRZZVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VGUkh9V2RBh8p9Fvl8AuR+AKz4DLRkvBnUODdJ8zrQ=;
 b=VUEfpPCkJ+fU+dzelg8ZVuzNi2aShgVQ101aclH8opUE4CNtxfEEvrwnMjSjwUktbEfPdRWJjsvRVDmCNBiWCOAUyd2J6Wml/9xjPSYixwFfCzr4hLG++D9fTBBxJ05uEjxs9HuXCOiXVHSfazP8cQY3mAqo8JkYvm0Embqgska4RA8gmxTDcgLYo+J+8FHcsQNQFV1s3rMezMonHlUKgqYUnIqeSe1YR7qLZiD30aHimQAjYVc5PWemNcfaoUUdz796kukU68FHMdmBafCkzN18e2uvnQLopo14Cl4dxrNu9tos+HY3VOXtEOIWcssmk9XKp7N8Y4fJHX83qFuuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VGUkh9V2RBh8p9Fvl8AuR+AKz4DLRkvBnUODdJ8zrQ=;
 b=TJQRyAN5X0WASj5T3q2f2yae+R8shvzR5dE5LlBFcaK0d080RmP8WQZqPNldZtM/tJd3gC6f1xPakLUK/b8zLNRDUcDEbKqo/PvhUZG6LSUbOefstg/l0fKZxGePI8uWtB8gy9h7ETImisZkMrbXy5bFMyiQ7o1GNRgP6jLztXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 SA1PR01MB6589.prod.exchangelabs.com (2603:10b6:806:186::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 18:27:12 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::54e5:4e1d:aaf6:7c87]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::54e5:4e1d:aaf6:7c87%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 18:27:12 +0000
Date:   Thu, 6 Jul 2023 11:27:06 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Julian Pidancet <julian.pidancet@oracle.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
In-Reply-To: <ZKbKcMehHbo+7cPU@infradead.org>
Message-ID: <fa76dfe5-c9b8-d24b-89a7-2f906e2b1caa@os.amperecomputing.com>
References: <20230627132131.214475-1-julian.pidancet@oracle.com> <ZKbKcMehHbo+7cPU@infradead.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:76::18) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|SA1PR01MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a95de36-b5f4-4d8a-3f68-08db7e4e9dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G21oyD5HYtJakldwyYQiABJ81agRjeibN2Hlz5et/KzHQor47vpNkRPu6Q1T2LB7045qiABBM74WtmpVDPhjJic9FcIVMzQczPHz1jqaUOIGpQXFvc1OCowCYMSxlkYbI4jKcgc+3YvkiW2Kv8SsWx5z3zHbOKwVCgk0cynnE0fkHtTIs5T5jovD11FH8NXNtwKvG3BnvOcL/v/wW1NPpeaHHtA2KA63grDA8YKVy7Z5T2Y7XA3zV5qkuQrxkGTQSID9hYWe8v3VKQmwpiNrM+NZr9/D8uzeOyGQiTrwfXPOmHrKuRc0jpJ76a5mO21U58UeUQjfXdmDlFDzhPkis/f0h356tqUigb+youSjH69d+tOGK1NP4vr++zuVrLQ63c8bCV0b+3JhHBvrOwZgt6PVTcBaEDIGE0Io3GvlWGc2LoEsRjDTUugB/ZcLtRfmPPbUFkhPih4x/0tp2Gxg3n+RkrdOskbcydLtk7zmh+74hs9ErZDFeDu/+Tlu2UCBucNAHdtQrjlx+rqY5nf2zLnTh0FufAT/M1v91zBNU8b/kXRVYaIE4G+2hlrdJNVu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39850400004)(451199021)(41300700001)(4744005)(6666004)(478600001)(6512007)(38100700002)(54906003)(86362001)(31696002)(6486002)(4326008)(83380400001)(6916009)(316002)(66476007)(66946007)(66556008)(2906002)(2616005)(6506007)(26005)(7416002)(5660300002)(186003)(8676002)(8936002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uI77/zVFjA7dIFNav3Bw94cfd+QP9hsoMWpCVifXtQfFM/xt/bDURMaV33n1?=
 =?us-ascii?Q?mkPuoq70vpk51napcBZQvT2aGT9yu9F3HSigC0ESnCCjUdbrp0aNTT1B2QUy?=
 =?us-ascii?Q?sjqRg0RwAVyZYoWpi5WRD5Vzhmb5bFd6zidwu0FpYTcP2ECELk3SDFxT7pe2?=
 =?us-ascii?Q?NfFgdKU+j5Nd7y5a8QJ3t2FN2mVbsCYPw/O0FsS5kb2XPq7QeWpu/UnRVYMH?=
 =?us-ascii?Q?OTMNc1cLK9rZWivp0EtTqr3gBtrvbIyyfL8PSu3DhlARBHDqQRFt+edd2V1l?=
 =?us-ascii?Q?QBDVIImGvJVIPHuQS7fFmEmAtF1bjjEuJS8dWEWYsDlRTHPerPOjZc74bjvq?=
 =?us-ascii?Q?SaH+Ptl+oKmhAbe/w18FLHoyXc1oivmInruFfSEoDQPuDUQUyBe4Z3VsBACn?=
 =?us-ascii?Q?J8ACaGRAzJODBLhMIMoYTYYju3orYcCmQEuaLqFnSj2QV8qn8rdLVivBlAas?=
 =?us-ascii?Q?Raj12uArDCAevnx0unuLNC/KMNkD+ug4L2fbh98uJCtu9/pv/tuzLac9IJ0h?=
 =?us-ascii?Q?HHllksjMICCJGVFkTTIT2+i8Ubr4ULrSdXMiU5fjALFr3orRWH1it2uiaCxl?=
 =?us-ascii?Q?D573lP8FULXY8l1wGFmaOLwzsJhCDhZfRAyXVDf9GSMMGcp+mXFbWD6sxUev?=
 =?us-ascii?Q?6Pkigr+gaT8vwCTe4XH612I8ffZs8B1RnlXJrjuQULjLafxZ7RXaGqRS7B1A?=
 =?us-ascii?Q?kLkxOjbtKaEDpJi/uzr6dvyxQakCmi9wmFVD0zwAXY0yBifj1H4WunUGgIyn?=
 =?us-ascii?Q?6bYupRzorsKIY7oyFAgOIH2WFKv378wGeW8WedCbqQMJD8KIpyBW91aup0JI?=
 =?us-ascii?Q?7zAjm+xvvNslNlutclCZRQHNYJLPA7tMEFoNAwV8y80qXNnGaG2kHbt5Sfz6?=
 =?us-ascii?Q?l+TPMKENf7aqsJVUnO/L4InWyr4ZJdgO0jOOkjmBOTPOykibFbL4FKcRteIN?=
 =?us-ascii?Q?scjZH1g5X6AErmpGK767YVPTgWiN65E+OmQmL3f2cZJIw3C8jTDQ+W+huW5E?=
 =?us-ascii?Q?kec7zeB68rqbbYtQwjvBLQVvJ7JYOtzoOwZTzUGoUCjuTkxJJ/Wgs2UlhZ4f?=
 =?us-ascii?Q?Y1aaStY7zFvdXoP0OtBSf3WyVmid2ClzUb3q8Cnev1b3YRexTegIvS3nQptb?=
 =?us-ascii?Q?M24hHXdTtBeI+prmIykl0wJTOyPFOoffK4KSKnbj4iKbsp2IWf8HbrC/EVJI?=
 =?us-ascii?Q?D8RKYQ4Eggwghl+LUH59z4HI9ZY+kd6XtwqytvyOa98l117LYsCSvgmhJ+xF?=
 =?us-ascii?Q?8bxdNkq+ZrfHm57OSn61VKnoYupN4Qs/9LXSKrIrpzqf5S26bFm9bO/aWG/I?=
 =?us-ascii?Q?TxKcwe4m0grG8bMkmNQgaM3UWqPjgjExM6SApAIdeGSbmLDi7J4bpZf3I9iy?=
 =?us-ascii?Q?L8YWyT1q1zMeBryHOYv/G3prFV8hYnmMAojo1Re3VlfTzwIwuzd9sB0kJhLN?=
 =?us-ascii?Q?UxruvR/SFTe+NZppWm67V8KV1octYskIs8ldqm4V3qq/exRjatqkMG/qZY2U?=
 =?us-ascii?Q?q8x+edKlkz5u9quPx+PG9WKuTgHanqYT0OkDksJGgIVUuKloepK1e7H+GY2S?=
 =?us-ascii?Q?tqrJRAwltB1vjDr4qR+lB3gjVxaYrpggZ8oFr0IsphzYXtgPJxdNPk07CflV?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a95de36-b5f4-4d8a-3f68-08db7e4e9dee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:27:12.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZTITHUY+R5le2Ok4dqzQI9Mf3KGi5CWa4/sR0kCtFi9NdglETWkMSWKm656YsJzuZ4PU7ufesp9Hv8Zs+9gStepm0rowqsQgg142oH+8jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6589
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023, Christoph Hellwig wrote:

> The slab merging has always been bothering me as it makes debugging
> things really hard.  I agree with the other comments on improving
> the commit log, but with that:

Debugging is enabled by specifying "slub_debug" on the kernel command line 
which disables merging and also enables checks so that data corruption 
does trigger meaningful messages for debugging.

Without that you may see errors coming from the slab subsystem that are 
due to data corruption by various subsystems. Without that it will be 
difficult to properly attribute errors anyways.

