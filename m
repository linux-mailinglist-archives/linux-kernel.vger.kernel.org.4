Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0872870D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjFHSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjFHSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:18:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ED91993
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:18:26 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358GmFek031350
        for <linux-kernel@vger.kernel.org>; Thu, 8 Jun 2023 11:18:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=XJ3O36WKe89PN+ww4Yoks3VYMpuI7UFURmD9m8mefsw=;
 b=QUDNVyKmdBstJJoUkkL6l27knzM0Z4cyQn7+H/dGZYOVWUa7lZAIHSB3ro5g+P28sBC0
 WvkHRf/wS43O3UnDXuhlpdf5bpEUf0FEdJOs6+fbbHxiJ9EMCTbyoFamej9JP003ofVO
 rsrP3v4bhYPDW0gXbNqd8rCYCBPF0RTRXliZbwwl2ERvjnUYuQT52NGn7XFUKBG042ca
 JMZ4VRKRmcqb9FJlC7znAH1BpLrgnZB5eVeae7ToMKHABVaDR4Moun950RqRMtaBTNpV
 52DRtKgWlJmQt7zxdst5lyRnjVHnz0sSBQC24XfBpHWXYtd/APTH3V2aI85sjxidmMFt 5A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r3fd6afh7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geKjxSJ25zQjo23cTHtg37CupWkRgRYaMcJFVZoEJ3wAUptu/t96uvoSB0oQA/Xlm03R8Ouch9DgEiqL7+0jdlJGHyKVBTyP5V306pyXOwfyzrfSvewVtQAsFdtPSSFKxqfpsp/FsiNbpj7OcKRCTxz0laXo1muf1hUiJOadM6tfsT3LuP1dKUKvIbhHCwYS8+dT4Vn65iRyLBJ6kOzYoP2jeJ0kSSd86zcEqeaxTFNtWs+LfJAfUXO4l3WCPKzWsWEbVV9sGKe2LnochsAvycU0ye7hLmBEB1ieUjoMXmxJubv7lsAZuzlTr3iQREndVCJ9PlGe+j3C0m1YKImb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ3O36WKe89PN+ww4Yoks3VYMpuI7UFURmD9m8mefsw=;
 b=XPXGqsp/k6jsaSQOkWZwELNE23sGdRQ5aaHsosTxEvwvS9/ltJLybcnQP6Gz+AX0306Wmghm/12dvIXiAYCyGpWTQGr/kh23/lqhqZ2JIShXBYfp0eWdNlTSAf2IAbwEAtUBJCy/OPAppFJm0IpucuC/plxcvt12I/vF0tZm/w62Uy1QJzB61j+Zz4lmkyqRFhItNMB9WJDbH1oFd2+2ZUCZpE3MC3EEGsEwG6wl0D1P+44bkdL0Ndpwv6SlJEBkkRpa0TS5DvgrnD8DD9jaeD/lfj9OpcCQJNdOhZMDEtFwvYBpwY7tlY/VER7lTkd2f8yUJ1bjOYwHxZWBftrLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB6140.namprd15.prod.outlook.com (2603:10b6:806:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 18:18:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::a353:7e78:2a58:dac1]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::a353:7e78:2a58:dac1%6]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 18:18:23 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Thread-Topic: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles"
 event
Thread-Index: AQHZiR9WEaR3xoFFfEGCLaxGjWAWL694Nj4AgAAHooCACRsMAA==
Date:   Thu, 8 Jun 2023 18:18:23 +0000
Message-ID: <04ADB93E-3EC3-4D7C-8477-D9D4DD8A3122@fb.com>
References: <20230518002555.1114189-1-song@kernel.org>
 <20230602224744.GC695361@hirez.programming.kicks-ass.net>
 <DCF269A8-4C64-4FDE-AFAC-92B6029EA3BA@fb.com>
In-Reply-To: <DCF269A8-4C64-4FDE-AFAC-92B6029EA3BA@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB6140:EE_
x-ms-office365-filtering-correlation-id: 7f6fe210-b9f2-4cec-fb85-08db684cbeee
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IoaRQidbuayu2RaDOTkaec0ez85GuMzxWxa1Y5CJDtBEP/5t3lQ+0jI7abM4qKsCQmnOMQeRIyKzfJFRJTbz4RJWlWjlsTqsHVzxqbf5gy7LVsS/V9zKSVyPXZUoefqtkQJqrY3QTS4oOCEaiXLq2NCWRQwxLS86TIDC0ugvaPNoXLgaMB4AxVeP6/CEvrTlvhGMYKyUbZFsyamv/zuKjPebMjLUvGymlFw2rMs3bP8p5fhBfk55NV4zghf0AgdEWdDH/BNdGm8Se198AhfbjJDhaFHb256K9chrdVfNOYAIyPaBFeSX5NBr6AdtTSCBsRN5DwoqHz9K1Nmr9izJsF+ZnR4Y6HbYxMEUSRh1YCD343PAQXkaPvHi9aPL32Jsa16JCGES3FzLCG1GSMTi/kLE+Y3iRImFcRketu7RTTDE+Pr5QlOoIgCHWJJ4Xzhqp75ubBmKgvVN50lkXEx+HUxwZrvypaszgo9rd8W5nB7YQQhFoUWkW+yCQyYFRGPg9mq4VyePg7ubsgtuhXejpD2hwTfnZybFeAtNz0c2WLHaQ1CN5tYkNPSDA1YtqMKV0at8gtE0TVz5nCFPXlnLlwsXlUqT45achfl/fQxB/zTtk1Ev4aWgH3VWTM8Unh653nQru8J0gaPlWW5bSvd/Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(38070700005)(8936002)(54906003)(8676002)(478600001)(316002)(5660300002)(41300700001)(6486002)(6916009)(186003)(4326008)(66476007)(76116006)(66446008)(66556008)(91956017)(66946007)(71200400001)(64756008)(9686003)(53546011)(6506007)(6512007)(83380400001)(2906002)(38100700002)(122000001)(33656002)(36756003)(86362001)(461764006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ctaT4EPJSaFBzDQGKq3kGPXorEd9G84iHLpYK/bGSBLzSI2VYA/PfcPunJk2?=
 =?us-ascii?Q?ApYPWfpvBKg429me2ZSshtd2JAhWtZzWAplnR/OVCXHJxq3ZHi2IRbczXiw9?=
 =?us-ascii?Q?kkkk3gL046yHMaUSTp90hfVHzL+asnsNvxtrZ8js9yRQrky1gL63OuUTmbn0?=
 =?us-ascii?Q?wlQjNxUGAAHll+HSJz9EPKDJ/EnT7IuS7PWOQ4XnpeDfsilBQAnfHeCXlQ2g?=
 =?us-ascii?Q?Tg8775Es+6AT4wtNMVZpuQN+7EOs8lPa/GUOpSfImuUDxl0Igx+xqKHZM2ax?=
 =?us-ascii?Q?urJNPMsuI0RxAjf8fcn4g+1IeurCouGydopjgF2PhS44J7Kva/+Pyssop58z?=
 =?us-ascii?Q?i4g/kQGl4trlKssoYt6G5MmsZHp+0jG7udcdZNVK9gGnUztbWsRbvO1e5SRa?=
 =?us-ascii?Q?GajL09JDM87oRUz1H71AgWVDKpzvLof1CkuktOPuqObbIO1OqBmHIQYVjU/4?=
 =?us-ascii?Q?4mRNamoetXG6mOcU0BhmZsLhRw3bRsCJCRWdJ5HBfYGmDzJq0briaV2dlcOC?=
 =?us-ascii?Q?vt4T3OL2EtFc8TezQYxZI6colXhGk8+mC3qXA2rYTYk3MXQWKRZQleHmfVpr?=
 =?us-ascii?Q?j9wD8IH2L+iz9c0JoVcxP8SyiwV1OFPGKrOjgiVNQ9+Eyx56WMPTTq9FucvZ?=
 =?us-ascii?Q?FQwSOZ181rjcfDIQ4N67gR0Ptz2jG/1TFSm26fDgyNKILHUqCU0fdvHdfmO8?=
 =?us-ascii?Q?i7oeDU3A/ykUKehgr0pT9PayO7HC5XL8QyrZqIMjWy6R9i+Ds9jDDcct2Za9?=
 =?us-ascii?Q?9zwiOQPCS569MLn8HZCknRZxxRb7SOQWe1ZDZhIKSDt/M6xpr9G7jL5T9AMV?=
 =?us-ascii?Q?rkrSyWMZQeKpYAGgb9p5KxD/FCxUPAuj1LTau+z3pVjrKFrIVprLYkuQIVda?=
 =?us-ascii?Q?eKahLEv5hKwfZDseroDgQPyDOw6nDQhn3OhvNWyG5IoG35LImJTxykWLUc/0?=
 =?us-ascii?Q?bWF7fQl7Ict/8LlqBxkTPu5GNmyR35O2s9nco0v5kEFCPBF1xKUuUlNGaH18?=
 =?us-ascii?Q?IahywdTBQWKwbjVPR0PfgXS62P5X4P2P01PgLPDAZy/pN6TOzdHEmApJ2TPF?=
 =?us-ascii?Q?BFSLHOd+boj9gQFNLYg6ZfEUEDiqq9bK2iZxYKcI5n01zqlrctchbUms5OF7?=
 =?us-ascii?Q?lAZx9oOEVMdI3Jr8y/7nOZ4qePdKFhNJ3VSS9DHywNPF9uEdGp5CeVmBjAem?=
 =?us-ascii?Q?GnWdqDb8uAVLxQqynK5gIB76weU/6tViLPfCsj0hzffNS6XN24lPGoq0cA4K?=
 =?us-ascii?Q?aPqnXYLAb4nHjCp4N/4WX8UxAVUektOirWmmSXJVHH11kpMKVJ0Qxl0QCdac?=
 =?us-ascii?Q?BVjWeENR2JU84i1wTwAdCNueNoFW0m2N4rUZDT1beay+7+VI5sZnRhe8vc3h?=
 =?us-ascii?Q?pnOTb1Hc2V3+7shb/GMvzJMidcfTgvxaepP69CvRXc3GQYLZ4brEJqLg2SJ1?=
 =?us-ascii?Q?4JDpgiv5KKo1V279pxMndnbU3cb/lcwUOeTPZKw7i2YFLOnck1R2eBi2YPgB?=
 =?us-ascii?Q?SJUPxEXMyaHYn6ztmaNwbxV4nO/pjtUQljbpse+lqZoHWWoXYzwOgf1MEW3J?=
 =?us-ascii?Q?rqv1J4T2tYdhzRD8VcMCe/dxEeyaF3jEtnrFpA9AYEssv0C8+Lm0735tdSqO?=
 =?us-ascii?Q?P7DW0OSDewpfvhLYA2OAeqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDB7EB5369102C4E849A4F2CE1C1DE19@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6fe210-b9f2-4cec-fb85-08db684cbeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 18:18:23.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3c3segUBr0iDLnpwi6EHvlsPMse+69hebLaBNv4ffQpHZjF90FbZ3i1/a8gwjQDdVEFX5lDvMaazJzZWuIJMyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6140
X-Proofpoint-GUID: nGGddjGj87LJOPQJEgIZB3d14wEW-ZQ0
X-Proofpoint-ORIG-GUID: nGGddjGj87LJOPQJEgIZB3d14wEW-ZQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_13,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, 

> On Jun 2, 2023, at 4:15 PM, Song Liu <songliubraving@meta.com> wrote:

[...]

>>> nmi_watchdog= [KNL,BUGS=X86] Debugging features for SMP kernels
>>> - Format: [panic,][nopanic,][num]
>>> + Format: [panic,][nopanic,][ref-cycles][num]
>>> Valid num: 0 or 1
>>> 0 - turn hardlockup detector in nmi_watchdog off
>>> 1 - turn hardlockup detector in nmi_watchdog on
>>> + ref-cycles - configure the watchdog with perf event
>>> +             "ref-cycles" instead of "cycles"
>>> When panic is specified, panic when an NMI watchdog
>>> timeout occurs (or 'nopanic' to not panic on an NMI
>>> watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
>> 
>> I still hate the whole ref-cycles thing, at the very least powerpc also
>> has HAVE_HARDLOCKUP_DETECTOR_PERF and they don't have ref-cycles, but
>> perhaps them wants to use a different event when the moon is just so...
>> 
>> What again was wrong with the option of specifying a raw event value and
>> falling back to cpu-cycles if that fails?
> 
> The same raw event number may mean different events on different hardware. 
> So it is more likely to make mistakes in configurations. For example, r300 
> means ref-cycles on Intel CPUs, but it also means something else on AMD 
> CPUs. I need to be very careful which hosts to run with nmi_watchdog=r300, 
> as it may cause surprises. OTOH, nmi_watchdog=ref-cycles won't have this 
> issue. Of course, this won't work for powerpc. 

Does this make sense? Do we have other ideas to configure this?

Thanks,
Song

