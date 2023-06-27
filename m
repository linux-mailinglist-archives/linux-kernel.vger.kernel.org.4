Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC1740142
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjF0Qcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjF0QcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:32:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE0130EE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:32:07 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R3aCiW019407;
        Tue, 27 Jun 2023 09:31:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=nUud2Xvtlt2NVi5H7GCfjx4uKZp0SjrZsCdVlWWiZik=;
 b=lJTN7jpsZ61gESlrFj0cMbyHD2EJyClvWVjZdKxfnoCShpAO2LtMnhOw05lbHHQCHdxt
 l12ItUWqFUjchYWlxWE6XMLMMRWJiVN/bbF4eSzSn8be9Zn+uiBA0vgbLu65TtoxwASQ
 KPySxIzeYDgLKQ8VcqPPuUKlaPgvXtDdmM26V4mrIPKT7JPC83c/tnzjDqTZ+sDWAyIf
 j8xwYdyD0g9KAHWNhfILuGSjJGo6ZG9O3OX+rmqC71vY1DvjQM9X2xzfoR/MN2bXg3g7
 HeuR01pjpC+bWzJdd1TVWd53VTuQqKxfAYH1xl0LnbjES6rsLa+hd4DNEzmiRz+CP6k/ 8w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfpagwmqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRbdpd8n+zcojY6ROYB6Up+wYgEw+VQt0aBeWkHWsQ1cql5jAV4OO46KrrblIctxdKAMWU/b2WbnNrUxZZ0SoIkmOQ/1rTp6IC9MoLbOrjRFkqF4XqVZSg/iYZ1xpG5tYmUFHoxX6Qp2iKz4e1Oq0OCQDrYhRtph6lr/ElK3PeC6RZrKhgmhmo47SieMzq6CESAl5js+KvPH4pRvmSVHcLaj+fpCUvarkpIw6Ptu/zzvl9Xh2aAvFL4JY8KXQ+ihNF9Fsmkc45yD8mLif0hD10d0srRQ3NFZyloccSM7hraHaZakRqt6Ip7lMtv9/j2CDJ9ll9B32Ff/LwETWP+7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUud2Xvtlt2NVi5H7GCfjx4uKZp0SjrZsCdVlWWiZik=;
 b=f78GM747DU4rGoNiu+/z0fC6ReCIL4JFJtsZq2EqFAxlEcZ+B1QtuDefriERpzJK/gd4q1QbS4Owa7Qndrp56Lny5qf3vohojK0OGvaUlRl7krXspsWv0Pn+QUZkeagOxVOScf4T1lSVmKs4SI17FLd50bo8qbMsrVAraA1Yd1ezK0eXYh8i/6Z2UYjaYeikOxWi7xCZ2E9JayPs6K4w4sFthnrUIUpQO+0pQFf2H+l91vZTfqLGj+gQMtNJYPCGS4pjFhchVUTqgIIABDuje8MWCuHT6qiqjwIQCjMhqxhFR8CKusa8QcmvolQ46amtkG6khEILWQFEilujRxSseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by SJ0PR15MB5226.namprd15.prod.outlook.com (2603:10b6:a03:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 16:31:32 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::1f5:8d6b:3b9a:77ee]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::1f5:8d6b:3b9a:77ee%3]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 16:31:32 +0000
Message-ID: <55ce0c78-16d4-6e73-87ae-0a88ceca1b28@meta.com>
Date:   Tue, 27 Jun 2023 12:31:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com, K Prateek Nayak <kprateek.nayak@amd.com>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com> <20230622014329.GD15990@maniforge>
 <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
 <20230622102935.GG4253@hirez.programming.kicks-ass.net>
 <ZJVq1+dSkMAsOIKw@BLR-5CG11610CF.amd.com>
 <ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com> <20230627031732.GD6750@maniforge>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230627031732.GD6750@maniforge>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL0PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:207:3c::49) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|SJ0PR15MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c65f63-1494-42c4-e323-08db772bf761
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9REJ/DMawjJtvAMKudEIT2b7NRDEwnXSMrqp4oDeG9uys68zikDTBLf4QgM00+MPqcUt3JFZYsnBLrbKFYXrxItvddIBpC/Gph0VqW0mV6Ie3vhe/kz2Fc6H9lzx0O+6BEeaELjqBXFhgC2KIe7/XcFdA2S1C3bFXvb0AN6BQi/yMVge0eFQ28Lj22DrZR7PbrFB3hI6PZZwCI5c3u3+UYCUnE3igGQwN31H1qj/GfUt7zeeDIgwmDcT9FxlpAJHmWCPwiNjNpVmRLrbDNu+s44i/pa+Kq/Iw+3Q/M3d9ymMNGa1SMiOnxtxxzme5jOEFUcNUhGfApM8rLierd5GwzviNYkrTVAZr8EvOfgJ2JKSyyDZCui4jYhW+SVzWpB2de8T6xbJ7iIdzJVV1GECUohroTVAglrJl2b0BquIYDuqNM+/j19uRegxz9AuCOVcq3QUCYhENU72ilSohQXceJ+YZI6PmY1/hPo6uabSDt3DXZsuY7MKw3FSYOgy/Cj5M2LExucXULUdK2wFymb5viuoM9yyszBt7/gHpsbA3e9HJSyJYTDXmo4z6hKFvWl3MonxOHAADrwvx3V8JIyNXoWGYJVt+98FBNnkJwGUye7Nz39yfC5y6bRWfNI9Zif
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(4744005)(2906002)(966005)(53546011)(6486002)(83380400001)(38100700002)(2616005)(186003)(6506007)(6512007)(6666004)(41300700001)(54906003)(110136005)(31696002)(86362001)(4326008)(478600001)(316002)(66556008)(66946007)(66476007)(8936002)(8676002)(5660300002)(36756003)(31686004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpsRExWRjVwZTJWS0QxbzJFbEZXTEgvSStDNVVRa2NYUXFUSVEwZzEyUEx6?=
 =?utf-8?B?a0FKeVQrMktNNHVhVnBmVEFqQWJCTTY3MDc5YU1CQUNPSHR3Y0R5a1VFM2NO?=
 =?utf-8?B?QUtFZjI3N2FiQzRlNFdSelhWc0tYd1hyRnJYekVXbUEzNXI0bTl1WTVoU21s?=
 =?utf-8?B?ajUwb2x4dXhSanJqaDQ5RGt1aEV5SVpVcDJ1SVlRdlZKVVpLdmVHSW8zczRo?=
 =?utf-8?B?b05oMkJhWUNNalJzWG93NnAyTGxKVWgyNVlxbG1GOUZmMHJ4NXVhRW1xenFJ?=
 =?utf-8?B?Nlc0U1lqdm8rUFZhMUxmS0hXYTJ1KzFzdDVCMEdBemZkeGYzeExEcEJtdWls?=
 =?utf-8?B?VzBKSUNDNmUvWTRvTW54QUZGekpuMFVDRUxwTXhkb0x6T0RGemI0YTRXUDkx?=
 =?utf-8?B?YWtrRDFmNkxJdjUyclZML3dId2VuSUMwVUNRQjNuc0ZGNE9hL0Rjdk8ybFh1?=
 =?utf-8?B?V2M5YVUvZU41eXc0Wm14a3I2WmM1MXVzS0xwRHZzSnBPRnpybW5YWExaWTRs?=
 =?utf-8?B?NSt5YXIvQ2NGYnJpOERCYTZ5UTBaNjc5Sm9SaEFSdWZLa0FXeXRpMnZCZEtm?=
 =?utf-8?B?eHBPblBybzFJaWNwOTJISHJKMlNqa0hrTTJuRmVTbmkyaWYzTGs2WEpHMVI3?=
 =?utf-8?B?NHJiekpuSW1TUllSaGNHTXZqSmdCVkJJZEFVT0hSNlpkNGFXOWFhOGJRb3Vu?=
 =?utf-8?B?VFVIVE9TK0ttRjN2U0VidkU4SWFkZWg4RnpVTFZzRVpSbEgrL2ZZOWlrZkE4?=
 =?utf-8?B?NWYxTUg4czBvYmNTeU43VHdSYXN0V3JMWVdaUTVaUTM1V3FjSmszdDA0ZEM3?=
 =?utf-8?B?U3ZQUXJ2QUhHN0YyZXd2d2g5Nm0rZTlpaVVvSkh4STFuZWc0eTUwTUFnc2FT?=
 =?utf-8?B?SndQTG1nd1VOMWt2b3FkUVkzT21NRGxhYzQ2R3RVaE9LazhiRys4VWwyQWp3?=
 =?utf-8?B?TnBnekNmWW5sYWJ6K055WjEvdmdybXM0VVlHbmNKTjI2NXk3QVY5OTNjU1dw?=
 =?utf-8?B?SGRBRTREUVlpLzJuSXFVNDY0MS9MeWJxSW9PNk9UNUk5TXJVSjA0KzhKNDk4?=
 =?utf-8?B?NDRHWThxV0kvd3RnTHpFanhKdHFVTVpuMU9NSVhRU1FyYmRLcVpUWTExVFVa?=
 =?utf-8?B?UnkrSERWaXBxSkNSVS81NTdRNU1JVVY2QWxkbVVyaTg2WEJnVnEwc2UxLzJh?=
 =?utf-8?B?bWZoV1IyVXc3M3FhS205bSsyd3hHL1I1aFZteFdGMlI5cEVpRXhKY0U4ejZC?=
 =?utf-8?B?ZGJNcnBwam1vQjBEWFpkOHBZRG53ejFMYVNUWkdOQ1IrY0hRY1lxZWplY0g2?=
 =?utf-8?B?Rzd4MHhVZGxLS291cTJZYmVEbjY0Rnh3V3Q0UHh6dlJmdzJmWmMxSVZ4N2xt?=
 =?utf-8?B?R0UreHh6Sm1SU3g1cTV5MlI1RVZHckFPYmxWeGNCOTdrOXg3cnJPRExtSlJo?=
 =?utf-8?B?aDZhQVZ1TFVsR1pmTmlwV05LdmdTcldFNko0WjY5WnM1QXM4NnpOR0JGRG56?=
 =?utf-8?B?N1NEQUFPK05YRURHVGM5dnB4VDF4ZEwxWENmZnpCTnE2RHV6U29vKzhwUklJ?=
 =?utf-8?B?R2pndDlGNSswRVJKanRJK1VhaFB3elRvNHdacFVqMldKUHpBck5WekpBUmIv?=
 =?utf-8?B?UWw2bnBuUUFHRTFUVVg1VCtlWVlaVFB0UDRGVmM5aUdvLzk5Ukg0SG1NWGxa?=
 =?utf-8?B?ejZHcW52M1ZNUVdBbjdHOXBSb2lqSFZpUEhTVlN3clVMMjlOcFN0dURtZDZo?=
 =?utf-8?B?YnF6NmczaEcwMHhRcm5Ia3cvL1Vub3Nyb1FPanBMLzR5TWRwVWpXUDhuMU5B?=
 =?utf-8?B?MFcxYTBoY0d1ZGs4cndPMVF4NFkwVGhBS2YvZkc0eElsTUhrbkRMcW5CNmV6?=
 =?utf-8?B?TmRXWWI5WldpYlowNkw4bVJPcFJTcVlNNVM4Q25FNCtuaXpZZ2FtOWxJTCs5?=
 =?utf-8?B?OGVZQnNNQlNtTmN1dTdtS2gyaTFnTmRqQklxc241KzZncG1IS28rMWNDMytZ?=
 =?utf-8?B?dWRTNC9xSStqY1BydzNFSkc4T1dlcWM5WWdDRVQvTjJaRE9rRk1FNmRvSVdG?=
 =?utf-8?B?R2RvMUJXdzlyK1ZUbXcvRGI0MXRIUXZNUlF6THVuM3hZWGFPamJkSmpndDBZ?=
 =?utf-8?B?MVZHVXdZMGYwS29ZeHNmZkQ4ZGlXM0piNjJxbWxxL0l1RFU3NGJHemdMYnp3?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c65f63-1494-42c4-e323-08db772bf761
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:31:32.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT3a/Dc5kQGhx4AdlXcXWEUnhFGv8tnb5soS29JQ/CTShn3R6UCXPt49BSdkZ9Kw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5226
X-Proofpoint-GUID: HPqOfXeAUXWlrhqMhjqM7dFbnGchpx45
X-Proofpoint-ORIG-GUID: HPqOfXeAUXWlrhqMhjqM7dFbnGchpx45
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_11,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 11:17 PM, David Vernet wrote:
> On Mon, Jun 26, 2023 at 11:34:41AM +0530, Gautham R. Shenoy wrote:

>>
>> observations: there are run-to-run variations with this benchmark. i
>> will try with the newer schbench later this week. 
> 
> +cc Chris. He showed how you can use schbench to cause painful
> contention with swqueue in [0]. Chris -- any other schbench incantations
> that you'd recommend we try with Gautham's patches?
> 
> [0]: https://lore.kernel.org/lkml/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/

Hopefully my command line from this other email will be consistent with
the new schbench, please let me know if you're still seeing variations.

In terms of other things to try, I was creating one worker per messenger
to maximize runqueue lock contention, but variations on -t may be
interesting.

Basically I did -t 1 -m <increasing> until all the idle time on
unpatched Linus was soaked up, and then I compared Linus and swqueue.

-chris

