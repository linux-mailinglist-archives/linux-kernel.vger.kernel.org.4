Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04B6A8EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCCBV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCCBVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:21:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C95550C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:21:54 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3231AxQw031679
        for <linux-kernel@vger.kernel.org>; Thu, 2 Mar 2023 17:21:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=HCRkqtt3CSBswRJu0dfeO14xZ8GrCbd3GM1qkoHw/5o=;
 b=jKq5X2L+GhxQA3FoWy0ZgUsgo08K7TTkRcF7S9OkYSViTh7Ypv14duQ/UORBCTh0IG75
 rKlHwOhuKlPBMW5/tzBU1SGd20Av37K1Sxsnezn5NI+dC71y6FYm46gRdNoF3UO8L+Uk
 C+/7C+T6HBZtfWCmqYZnSliGVapIm99c0uBnM40S9nHCaWVW6D8wmG1Cqmaw9yqLPdK+
 7cUKTsFdmISzMPrdronrcUe5lW0Nwh1v7xG3GRcVN8zrADWnH2AoO8D2uGKomA0onDBc
 1zWpwJzsu9q1y2i9TDDgm5hwNqWLeUSmJFvOUHmSbLpcYPHaVD88qjU9SEWgBi2kUo/N nw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p33d09974-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:21:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epKVBG7B5SLZYmRDTSgXdJVjZFBU8STgh7Z7iaxvoERua0kRV25+2U9NQtmqHi6AWoGRAUN93HfFGBQtFuXThHvDDr6JQ/wETsNovVVNJAc7MNH+d9LqMCloes6SFFU4CFoeVeil19Prq2NTjaIAUFnCpylaGQG8RnnkZsulfe798DAYk6FLeeiQJK2D6d6NFufa/jN0cDeIK52ucFcU3KbX4nawovbxMFb6UAopiQrRSeqZt9jbmdPGK+KXTBMfWbABjeCMegsb8s9MwbD0uKO8FdfedY1aCY924htKfpsEdxMSQ1TVVzzrwGXVF8vrTdB1y/cmGV+pCF+77AY30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCRkqtt3CSBswRJu0dfeO14xZ8GrCbd3GM1qkoHw/5o=;
 b=BCsFmJ+JMZYW1D9dMU+d02/L3N+vxFOzrfWLgST/fAAnrgNdbQk8MqsMsMM9whMJQr3nVNdJ/Nefo8Wew3+jGtdKuHYpOMbdjNAh6uwE7RqPztt9ECZxKnAW01FASRD6dR4LPqMhdi53q9nMo6WfsjMdY8TKLRJtgMT33u7m5091Q3KWvggQ33eoB1Oef0DZKTJbh1elvKUKi/nMI1R/RJp0Jt0GkROUdltVoxqqD5EF5A7B0p4CbEvXbsvxrKBUdDcVoGAXDQAQitplsPz/AXrFKMaPxcKM2Iv2xkmkf+l09H81Ea+6op0axpe37Sy7cGu8MiA3/g5FFUzUSA8OMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB5584.namprd15.prod.outlook.com (2603:10b6:208:428::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 01:21:51 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 01:21:51 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH] perf: fix perf_event_context->time
Thread-Topic: [PATCH] perf: fix perf_event_context->time
Thread-Index: AQHZS6nzbIJnibMzeEap6dRInzeNaK7mg0cAgAANEICAAXCkAIAARLQA
Date:   Fri, 3 Mar 2023 01:21:51 +0000
Message-ID: <CEA56FAA-01F1-4FDB-8956-2311DD0CBCB3@fb.com>
References: <20230228192145.2120675-1-song@kernel.org>
 <CAM9d7chLaXDU4mMkD1U6YuOGZXcu7PFWGOuEkFKSkbrCLS+zWg@mail.gmail.com>
 <BBB1A458-25CA-4C0F-AF04-18534D092142@fb.com>
 <CAM9d7chCcz=o+XX_ruZ3+zfp2Z2sPDG43dpTZH_mf6zXYjTJ7w@mail.gmail.com>
In-Reply-To: <CAM9d7chCcz=o+XX_ruZ3+zfp2Z2sPDG43dpTZH_mf6zXYjTJ7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB5584:EE_
x-ms-office365-filtering-correlation-id: 57a4c2ee-ce5c-4292-049b-08db1b85aaaf
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAvAF/NmqcexM1p2dlWXIeZ0C4F4Ui8BXQnGLQ6DUl6YL99b+OWV5sTfe9EXTF4pN81jyGpA2Qi95wK0sf9c7H1s4xaVXiOwxpvBfH62Awel41S9MHknMgz84HV6+nTciqTftHUaPmhUoTzjTNxj8qi5Vm0hdgNLApMzf5T/hvW48HP97QUwwYFtl8H0L3JK3RlTDLi0mbPXbkI/tshFfMyffAPobCbEl9HL83fKmSFeakUzJ5vVetk2gUz9Ij40qyr4CP9xpTqOAGaBZl/boxgDpVKyAWS+9Ru39WfVJTh61nCfvaoSsi9+ZMD6KjQmN2IEWmPqdLdHwkUBbsuR6favCDtM1GjtWaHkFiyedLJ7fVh6R1IYXsLD/BZtSzUwPq7Vc2Gt3N0vQH/HL+YjV1FtgsYsTgW+Btd4dp+UN/ETF6rJbYCMdp4pO946aA/QAQzMqcxSZC/QJbmPMfnrUFYCHKcm4S/WSgoymU2Awm1DYAbHyVl7sXBSL1alrcGB8MLvMZ0h8HdYsuHt+TGYqQ6fhnZa9s/OHdCXlz1QRZIK5pfuoPGUV+LhX/s7+wlRyM+B8+k3BFXZKLyddnIlQNe2EEvtjhmlhoMDuU75fcyI2hHREecoxFAvv6eK32ORRTBH8droa1diCgUmD5lQJbvszL7I/+Bo7nG4Cne/vZSM+OeX0PI4WMPvCKH9YlS1b1x6bhRBEyOXEhUvW/21og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199018)(36756003)(107886003)(6512007)(53546011)(6486002)(6506007)(186003)(91956017)(9686003)(316002)(41300700001)(110136005)(54906003)(4326008)(66446008)(76116006)(64756008)(8676002)(66476007)(2906002)(66556008)(5660300002)(8936002)(38100700002)(122000001)(71200400001)(33656002)(478600001)(38070700005)(66946007)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C+9BL9hdIGrUaYQ1remvkvjYPCy5+a4ePOWvl6A/bJ5d0IDhgIOQyRnEjL5M?=
 =?us-ascii?Q?HAQPkuVEhBf+nxsT8wieJ8U0hcpJIfPEL8RNtk82GWsk2fWNMGVFFPvYqQzl?=
 =?us-ascii?Q?qs5ctgbUS5UeeCvXdtwGx5Rdx7CYUt42oPGXbfSpUaT2RsKmv6BHomdgduwj?=
 =?us-ascii?Q?8kPN2iHyqDU82RXEyVQX8RBCznxfQRxGBj3AgvtNTYB36Dj2uLp3oaxPb/f+?=
 =?us-ascii?Q?k3C5oSOqwnCQta697UFcAbOzFulaRTGHYtqqpnonSk2D+vfbH9sl8CsMXp4A?=
 =?us-ascii?Q?sgrujWShph2/hbqeQqsQmf8rq/k4KsXSEhMSkzKiQfvk4ZmeKUJOymrSXCLc?=
 =?us-ascii?Q?WDwSMtcGoKluTdSIFreLDh4kXIqMwh9Cwmzeg6SxgonfRrUxf8UYzyjwbJYP?=
 =?us-ascii?Q?lw7S83BXioIKmxM/KplKqxcJ22dAOEebL6/UDtA1XRc3a1GJ7G0Vem4fD1im?=
 =?us-ascii?Q?PQaUUhg3Er9IF4zuISO2bkdsM3uJGKyGUGgbCqJDyAYzuKwXAPx8qYFccYOq?=
 =?us-ascii?Q?cFm0PGP9s2eo8fZu1BkW5f1pAL0HcgjK86YN/iLOEnf0VpHsOWsQTBCU42JQ?=
 =?us-ascii?Q?XXt84B3VWgafMUFeKHbLzksBjArBNTnNFQHa1bMYzxNRF8QGhoz5HHLzFgTT?=
 =?us-ascii?Q?iHLpPv9Pd1pEQini7ibZefJeUwotc4Zhk6TW77JdLYZZSwWOUHgk+a9A2LMJ?=
 =?us-ascii?Q?AwYxyccFGV/PxERiVC0sCElJybnaaZVJBapKdA0pTfwnStasVOnt6hyKvcU0?=
 =?us-ascii?Q?Rqga3kbPW8NSZ5NUmf6OklwhzWZ8Oy8o9WPS5GGrLcFkDLX6sSrn2N70QD31?=
 =?us-ascii?Q?vZ5oFKruYiv7//40Vqb7GKfvJxISFefpnf3Qkch0JzfSfYBLda+QYbpNwNE/?=
 =?us-ascii?Q?Zc75qtnSjQOcQCqbaEj3aA46g3CPS2JqZboUQv93N4neVYN3KrnP55tlIjC1?=
 =?us-ascii?Q?c5EJjI6GzlHMHJ6/ppfZT7uhdCjoRnjU6vOp97gV9DPnBwUk39lQ/xBsMOwn?=
 =?us-ascii?Q?juJprvUxDK9ej5m5JQ5fi2lQ1NM6DKEe6lSht3E8+VdRmQ58ENerKeBQtB7R?=
 =?us-ascii?Q?50mmRr8mqvQ3LKXli0c84t78T2zgUFmEACHoq2E9QDi7XnfJ60rKyfx0YKo2?=
 =?us-ascii?Q?7iybv/dMiVN4ngHFEYo0N9Q5XGroJyMSfPTPqBj+tQHUZn/KHpjvRKOKp1GF?=
 =?us-ascii?Q?9ykdLjYlolR7b2Oxthbmq5ky/T8hoRreh6BjkEqr1+RapU8cYgmimCDm2ZxS?=
 =?us-ascii?Q?eGjO3Qb5c55Fo1DpLd6GezoEu/1s93KWydoAJjgYh5EpYbY5+LDCoOOXK/V6?=
 =?us-ascii?Q?SN19BoGnf3wFN+0QVYGl+iJqsh+PcXmZ+zZ/IBBXkQ7WuMp/sBjDdNTEGVrj?=
 =?us-ascii?Q?RYU1E6LwlXOosmWFv2CamkP4ZZXNXbFlKr0V4w4JxAc0gQXrXg16dvia5Tzn?=
 =?us-ascii?Q?jeB3mSz8gxcTUQ0ByNj9h+UXDGOFnk1/rDu4f420+t4pqnF2zt8TuYC+umbm?=
 =?us-ascii?Q?PPv6Kh7LHQyxfEYKgA7aK7JPS093Yf0xFyQpGz5qL/gy9hwvnKVESV/Vlbie?=
 =?us-ascii?Q?Oxfhzen7YF0XvF17rHiZ45VFAxNbeThUflZY6a23DJmsUCsXj8VZii67dyeG?=
 =?us-ascii?Q?jR74aCFrPm/Ar5XB1UQL8zxcS9RWkHKjL0PvJoU2Jl3S?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18C77FC8537E1F4EB7955179B2B3CB76@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a4c2ee-ce5c-4292-049b-08db1b85aaaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 01:21:51.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwLzvrjtWDLGWZwyRofKiMz5Hs2RMublYjfNEUnKY/oGEljXdJ++OJHIxbrkmrPaCrbGZNOk78sgLVQarcILPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5584
X-Proofpoint-ORIG-GUID: TyorruJR7Jd6hyiFOUiVlm_nlM3rmaiZ
X-Proofpoint-GUID: TyorruJR7Jd6hyiFOUiVlm_nlM3rmaiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_16,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 2, 2023, at 1:15 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Wed, Mar 1, 2023 at 3:16 PM Song Liu <songliubraving@meta.com> wrote:
>> 
>> 
>> 
>>> On Mar 1, 2023, at 2:29 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>>> 
>>> Hi Song,
>>> 
>>> On Tue, Feb 28, 2023 at 11:22 AM Song Liu <song@kernel.org> wrote:
>>>> 
>>>> Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
>>>> accurate time_enabled and time_running for an event. The difference between
>>>> ctx->timestamp and ctx->time is the among of time when the context is not
>>>> enabled. For cpuctx.ctx, time and timestamp should stay the same, however,
>>> 
>>> I'm not sure if it's correct.  The timestamp can go when the context is disabled
>>> for example, in ctx_resched() even if the NMI watchdog is enabled, right?
>> 
>> I think we do not disable EVENT_TIME for per cpu ctx?
> 
> I can see ctx_sched_out(ctx, EVENT_TIME) in some places.
> Also it'd reset EVENT_TIME if both _PINNED and _FLEXIBLE is
> cleared.

Yeah, you are right. I missed this part. 

Hi Peter, 

Does this fix look good do you?

Thanks,
Song
