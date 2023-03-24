Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF26C7792
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCXGDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCXGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:03:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2847D94
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:03:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O18dSk007504
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:03:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=AzunmSD2em/j02FRpGJR+9IyQdIrbkbUmvXq+T34XQ4=;
 b=dUz8SvAz0oTU2kpuektapYEhTDBK1WjZIGZYUEkMoSJGbossJa141Um5Ol4oiohhQ5hX
 gbs2l4OzVq7dbRd0Wj1mQEjs1ftXTM0oN58oIEHcUCIqVWGWghMcnjpRNRPSGSAHnU3a
 vu20f+2Qv4RODpSD9JvmScYYdPOm7MRwrBlqAb8UabeKWp7q21yJYY4oAFjIumAXm1yU
 DsXI+oYMc069BnovksBMKz98PAotPtwfK9KXoc316VpWsFk9kYxNtztGIxfBOZF35kfI
 NbSrFtu5ODKB/6dzuAmMxNSVj72YfBdlaF4RWqE6GBMmRA79ak5yI266hzMiynOSfvZq EQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pgxkej2tj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsVIoN1fhZkaTiFGWubvPFjZGSix8gsik7OcXfDN2KFZ/tvbl3knDHdqK/Djrk9MVgvqibVf02rAqxr2hr0SGFZRSR0wCdstg0bAlM7urDjXMmpJvhhyhIif7cxQghBZY62j2GIP/L8sr1xjvzdEB56MxdKIUASJ1OxDqpQtu1h343T8FpNJQWrS2y3A2Npyv0NGx4owp8nDBSZo/YLktNHzwyMNiro0jcjN3rp7PAk35tkD2eVqBbfsS5DkvmfFY4OMv8LsDVatkK9srDBeWbFO5n4AmWK1PKOy6lK/J4yKgnOjz1nYOFwtj9hODnPsXwvExROvbPZpUuFUZuD+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzunmSD2em/j02FRpGJR+9IyQdIrbkbUmvXq+T34XQ4=;
 b=S3vmlXuzbNQADbS2Hhmb7kn10lSnwmuXjsCEyWJ82TuhDx0aOIyyR4NWAcRoLcnQBP1o1cQqlc9OfoFYypUQeIcb6r2cVkKkqN8euUtxVpgGjbSU9P3wPQtoJOP3OuKcMsjKn76I+coLGuqL/kDbPvuJG5K43MJzp1EZVAcQAcNf8G+IL/Fl2E8cFI6nPwqZcwf21SMdZU/Oy7eno6KYeg3w5rVGepx6GSvEUkicfTRXSfGAo9y7ZkJr7SYo3f7XMlbiWdbZajwTuS7GhxHw2EfS1Rvz92KHfCEgyR6795s8QYGnlo8gCf3b5dk88wJSUTVFVMEo6Wwkw/50kvJRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB4899.namprd15.prod.outlook.com (2603:10b6:a03:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:03:38 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::95a1:140b:9c44:f86d]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::95a1:140b:9c44:f86d%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 06:03:38 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Thread-Topic: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Thread-Index: AQHZXdJKRWUpBJV49U+GL8Q6io5iaa8I8egAgAA6LACAABowAIAAKsqA
Date:   Fri, 24 Mar 2023 06:03:37 +0000
Message-ID: <6F9B0A6A-B7F1-4E25-AB15-8F3782D2EF83@fb.com>
References: <20230307052036.1520708-1-stevensd@google.com>
 <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
 <ZBzK99dSmbPB7vjA@casper.infradead.org>
 <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
 <b49b118d-893c-c749-61f6-9441539418a5@google.com>
 <ZB0ZSqw1TTp3/ec3@casper.infradead.org>
In-Reply-To: <ZB0ZSqw1TTp3/ec3@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY3PR15MB4899:EE_
x-ms-office365-filtering-correlation-id: ea1b15a5-1829-4205-1032-08db2c2d82a6
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6EPret9m4KpDLit4FWvj+Py0Hq5pZ5H2u0DzSku8jOs4Oa7IqezJBA+saBgk6NokvSlyGUlVpR3W+ZJJfWZzHbs9++zIAvZgCL/7xNlURme2/c0wq78gVX4D/Hf1P2Wgw6bvnBM88tyzd5HumAxIwqJgJeRbyoAxvXk0crNMoTYX23Rw8DWaNPbuTGYj1wPkgpTvg6MNToQ7RZINtDq5NBpc8WEu4kyuUnQHYyGTPw/NOLJj81dQ43JPR8yElUyVRP9SWqzbPg5tvs/Je8Pro7k86+aDyspKpa9wLAgOBbprh7e8dLROgMBmQTyF5Xzs+jqEDO4MxR8azLakH0jACFzmMznLLGXC7X4OOCalGwM7Zw+fe4xbQ1k7XE6wK5Cvr9TAYkVTlLFkJ8O/M26WEyrIKLHTauzXNEp/1vjiWTinHGZXJ9nvicSy9r/bfS7liQyBuFaPk5WVvtPLRUH++4L9J7yf6+JvlTpMl1qquZ2G/NWlsHLRan3dcrpvo+QBQdxiP40PlRuV/RRmU3JgHX9nKhk8VhAhk0Wna9upJBf7dGrliUSG05nmWSvyGyjIxIfoyHIOu6Gw5BaLxDFUFxNt2hNLAGYx+ki02DSgxS3UrR08xoBU5mYtyaZtKID8joGw3NiS6g8rtM/Ivc6N4BotFTW9ss8zlWMTBQpOKZePWDgpjkgkgYAH34KnYIy/Ggu2LTSxrkYGNBYf6n6qGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199018)(33656002)(36756003)(38100700002)(8936002)(76116006)(4326008)(6916009)(86362001)(8676002)(41300700001)(66476007)(66446008)(66946007)(66556008)(64756008)(91956017)(54906003)(71200400001)(478600001)(316002)(6486002)(7416002)(5660300002)(2906002)(6506007)(38070700005)(9686003)(6512007)(53546011)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dgU/QO1dOoL8L9P10FiDtogO48iBmdSFOfVjbHtKXNBabp+c5VSk/15YHQNM?=
 =?us-ascii?Q?TtBu12nKO9ogJHJuyEaaUVhWeSNlwUYsmvLH1rdBXfsZEPqDuH4KCIlGVvn+?=
 =?us-ascii?Q?fyIHEsQSwwcwzFgaQvogeX2B4lK76GY9Ms2NtdQTWJ2FoWTtygmjTMnjFNzZ?=
 =?us-ascii?Q?ofHUO4gpR8e3ChpJaOQ8NskGNL2uFThDMsGyOkkCjUyjyJ7rOAoto7b0fNWG?=
 =?us-ascii?Q?ll1wWApUfkfwK32oePYZFPCXwxUprp39dQ+pUOoj5QBhGCs9pnDZVZCg8/yk?=
 =?us-ascii?Q?s6JzVI9PDwe/9y+lotxYlaNdKEboPIBEVNuNwVX9Sg1lgselasWI+t3Owi0I?=
 =?us-ascii?Q?hj/aC6TCnkQePtEyc4Se3UrU2gU2ChyJJHKH+NLRtDZjBK8hc8mHdQHbDirm?=
 =?us-ascii?Q?2v/iHMGSqO6Iw+axj2RyHy28FDgXaUUG+CDhPdZvXWuZdIHskUGtYfmEpA0W?=
 =?us-ascii?Q?FR70KZgzOuuYSsGs3csymISIZ85Qz9pUWmOCWjgJeEKHzLtGIbheZH6j0lnB?=
 =?us-ascii?Q?u1MgoYHjhcTRhWUD3y5DxTX8As62BU5WM2naOtmhRZK3NOFFKNAEI4yNdSQg?=
 =?us-ascii?Q?6X2iAC2oLI6xislZ/ItWKJf/OJlo+vgEoYSoAd47Z688h1qhxkRcD1nSIp1U?=
 =?us-ascii?Q?shr5eALLkA2BeH+G5K3VrX97CYKM46tbKMV3JEkFanUmKOGsETGDwaYHCFMS?=
 =?us-ascii?Q?+3oC/mRnfHJ6MXK8mMbqcWdPojBUcxPmt1xdn1MBNWwmAQB5ks5xAKxE+b4+?=
 =?us-ascii?Q?CAyM/orppgn43ZxA9LvaBoqt6/kdmFqE0ArSKshyJoyIfRkp/T9/mqVdGl2t?=
 =?us-ascii?Q?JC5db+skQXWQQjlGwdm0vBqogOLIiDVNz7RcYRW0h1FX6aDU38LfztCIT8Na?=
 =?us-ascii?Q?csWS7Ux2UuRvOGE14yASKCSp6O5mQ+/n4rszBdxrMWFarrkZdPyqaC6bkf9H?=
 =?us-ascii?Q?DVPaK2795oiaWSRveAcV0JjN9fo2NQK6zgeBCg8i0uHC8C1/xRb9z9TGf79f?=
 =?us-ascii?Q?HSx+PsfC9Q7cwA1WPLwPEETwnzGnY4ontPNe7jVU/VB3khgDKwfmrGA8Ynf2?=
 =?us-ascii?Q?MA0sg95/aSwDo8p8xHC9+NVRPEvaARSvUizqPGGgDvX1yvcpvuwInfAX46r6?=
 =?us-ascii?Q?9ebraMsKE7mVakzr6tCEd6M4cqzLygVLfkIbvDss1xVxbIakk4OAZRivXsmq?=
 =?us-ascii?Q?Rfxvim+T2B1Z7atx6MedRgoD7syQu2ndgGy4QuHxmOZM2xB1FKnFnNq6ztrO?=
 =?us-ascii?Q?XHsM3yvf2ecIC5r2dJpyoOdsRmH7zia3G6650TSQws3JjCrW13CaOAn32lmU?=
 =?us-ascii?Q?e0NWHH+E48Yyz9neQ4AC6Ui4OZ0FeypLY4WD1C/2o7sMqpWJ11LfYFIkmIOy?=
 =?us-ascii?Q?+kuiIstLp6VA/F1bdyDlcN0v8mfx74YEiI5aZhinPZBiXhgX/aQS2+YEVbuV?=
 =?us-ascii?Q?tkWHz2CcIjS6u5OVwGGJAk2fREp4adJKqJs23aDXO8ur+4kvgeXGhUmf3ZHa?=
 =?us-ascii?Q?LDzAQaftTqmWf1G+uBX2EW85dt4VNcLOi7aljpphlyskAVgx88RRwnFIc1xi?=
 =?us-ascii?Q?WvTXoa5f6UH8oM1hkPo6BNOnOayYprBCxWlG9uSJY9nFc7wCEdM/gyprK+oC?=
 =?us-ascii?Q?f0uEM3deqBYVgtnimuDyUJhdj2ATCTqQvT1mEFVq4UKy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5801088FEB3030489DD8A68FD9F23FF9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1b15a5-1829-4205-1032-08db2c2d82a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 06:03:38.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3EpvN7z8iUm6Wz6xbq5xo+xlQaI5D7VbO+6hJwo9ZkE4yhB3XeI6Eo3za9d9+5e+LYURzQ83EoinGP+X465sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4899
X-Proofpoint-GUID: S96EwjB6L4aVLFzq3ZLZHn2EkmTIvrSZ
X-Proofpoint-ORIG-GUID: S96EwjB6L4aVLFzq3ZLZHn2EkmTIvrSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_02,2023-03-23_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 23, 2023, at 8:30 PM, Matthew Wilcox <willy@infradead.org> wrote:

[...]

> 
> The Uptodate flag check needs to be done by the caller; the
> find_get_page() family return !uptodate pages.
> 
> But find_get_page() does not advertise itself as NMI-safe.  And I
> think it's wrong to try to make it NMI-safe.  Most of the kernel is
> not NMI-safe.  I think it's incumbent on the BPF people to get the
> information they need ahead of taking the NMI.  NMI handlers are not
> supposed to be doing a huge amount of work!  I don't really understand
> why it needs to do work in NMI context; surely it can note the location of
> the fault and queue work to be done later (eg on irq-enable, task-switch
> or return-to-user)

The use case here is a profiler (similar to perf-record). Parsing the 
build id in side the NMI makes the profiler a lot simpler. Otherwise, 
we will need some post processing for each sample. 

OTOH, it is totally fine if build_id_parse() fails some time, say < 5%. 
The profiler output is still useful in such cases. 

I guess the next step is to replace find_get_page() with a NMI-safe
version?

Thanks,
Song

