Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349C5EFD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiI2Skp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiI2Skl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:40:41 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013003.outbound.protection.outlook.com [52.101.64.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B645FB30B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK7uu1aQ/FIJpbhuv2Nl/dtOoA/vf1fpi2n9TmRQQ5R/HgQ1AYZGfqqHgvJyhxz1Hmn00H6V1slpxksq8bofa39mGP+L66MB++QHmromqxxvLzva861354mxmwTubS7xMKaftQOWpYGlMQe8pYhamRvUNtujyymNFOyTRXIwASi1t7KUzBH/6WW9bZn+vWXusKTMESFJEBiGxMrYhWCVz6OluGVpwV9YTRLZamDXCUXD9tjNcahsofXgGBnorDkPV/ILp5cD/V6pfK68lcKch5RpczZUN0IFiZOVUUMoO8X//saAIICFxGR9noLt32oCDqewMvP5qVekIqm1OQ9LLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD8oE+u64k78vjM/TOju7+2Rdwyk5rFW1bPyqA2iduY=;
 b=nqBOS53LIGA4DRuhTwSGgixIrx6Y3/HOrdWLgORnd8UK5j7LcFqaP3PcB2SLKgNgxJCor8lxRG8rBJQapQNaSd9ujDcL2QJbVnfbTVWz56MqI0TpW8lDLPPPt1MhwJAMOdQhiJAGrhShcQkTwydWJPlhmI60BD0FMxjYz1XNLf95CG5Y95MFpY9uHMfl7YJJBF+f4CgxpRy8zjI1h+TWZvAhTSpY023QpJvl2zEDfGiBlL5x+dKVBq34yxQNiogFy2soDWB5o3Bng3wSMkN2iM07P2vdxwtCyZ01mH9pjk61/DsOGesfK/q8cEdIz4PG/tz8b7Y/GU45UYMMcsmcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD8oE+u64k78vjM/TOju7+2Rdwyk5rFW1bPyqA2iduY=;
 b=sbhgHeFsUrO7Dle2ebQ4FHiVdwKPq1Bq8K6kxlNWSAlrY61pWFx3EmtSYFtwaDlkZAIViDcmqPoO9IQ0Zr0QvfxNa96FjMOxgje1f+6m2MkSrtqVuimM+PKhYmG8aGjASGC/2RD8lIUVBnhD/e0xFoSI5yEnAUc+2r5MKrjsSB0=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4582.namprd05.prod.outlook.com (2603:10b6:a02:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.13; Thu, 29 Sep
 2022 18:40:36 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 18:40:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Chih-En Lin <shiyn.lin@gmail.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Thread-Topic: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Thread-Index: AQHY0o4wEIMbrk5BdEK3BIHQI3SfK63zm3IAgAAVHoCAATBzgIABi4GAgAA/C4CAABIqAIAAAxgA
Date:   Thu, 29 Sep 2022 18:40:36 +0000
Message-ID: <C4CA4A1E-5553-422E-B8C0-8A5FF17DFCED@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
 <YzWf7V5qzMjzMAk4@strix-laptop>
 <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
 <YzXkDKr6plbJZgG4@strix-laptop>
In-Reply-To: <YzXkDKr6plbJZgG4@strix-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BYAPR05MB4582:EE_
x-ms-office365-filtering-correlation-id: 0c1337da-af4d-4de8-b01f-08daa24a19a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8CXET6bQ/OJOmoNyYhTDQn1iT6knPt26JEEvbSK3S/d6yWrlPLkg/5N4EVRcGzq4f+G03obmS8RW4iSmv/1l9Zf/bhbQtZVoubyT1cTtrzkX5pVsK+TEB1wJplpVnovNw1IMvHoAbIMxAd2Y6AcJVARLtori5vXR0L6WB9Kt+mX2NdN1Xkbf1uSkibY8hh4RnvxFeWo6njbRZsN9EhLDKiM3MOX9ebn10ENtNnHDFoJVjh+gDwzyHV6kyOBcH/LTGkbz+PjIknag8Q6oJHKw8kiQSPU/2Q1RtUjj0ecn7VD1694+ytwX00zGQ4LEofv3iSEQkQr+mV44SGCS23UZhAtNyIZCU4G2RPP8iw/ZcTeyOv2kEQCNtrA0RbqCiM2sPv/++RSa8al/85S9D269Afg+pFGBjw0ceRl7Mi/mc6Ijuzt/W/T9U7ELaGpM2j9Q742O8M5vNaI86pdaBoJYF9qYamJs8133zLwj6bO6Sa+wP0UJB0G5EsjW9B1BRDEpdFH5XTmm58TpXxi8qVO3uINUPlBX+ZE9nycKiW1B/Fp7A2vCewaF2pGqAORmEyEiDRydDHmyth7a3fcuulc79/pMZwFmh/0lne+/dGJgluXDH2YswZO6+8oXi9YcXsSDSeSJgQsU7iU83eCLUt1k2rRM6/lnV+rHnrHfxtrT9Juq35v5sLw9G8F6/THbRe3yVv/jOG+PXeIZjsHjA78kpvWvUKdgXnfJRaSV3uxGGDrNU/LTEtZCkpLcKC0F1LGy1vTGgr66VhW8UR4uSFieKrriLgiteqsb62z5FZ+s0+zeV9t9kRJRJVNtUL5AMXoUuCfAVagBBhd5PXmCrVBiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(66446008)(4326008)(8676002)(41300700001)(76116006)(66556008)(5660300002)(66946007)(54906003)(66476007)(316002)(8936002)(36756003)(86362001)(4744005)(7416002)(33656002)(7406005)(2906002)(6916009)(38070700005)(64756008)(6486002)(122000001)(26005)(38100700002)(6506007)(6512007)(53546011)(2616005)(71200400001)(186003)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZalbVp2gGY2zmFe6+/PNUIuFzuPbrIZ8tF8DuPRsbhVoLhx52xJDjxB3HDH?=
 =?us-ascii?Q?pu5Hn9bmYNYvuBQirQ5OlH/h6Uh+oIhoYY8V6xqDVCCMJAm2epiTavurBc1Z?=
 =?us-ascii?Q?T+ZZluUQSChvbYwGtaZuWkCopN8tTGTHnK0ejkiVkTYnOClLFxDUEJAbphnM?=
 =?us-ascii?Q?gNEpFThqWQ16RdmzjyWPMYexsAMg2cgwjejc7Zs2J6klqBRtem050A/rXDtu?=
 =?us-ascii?Q?T/B/5CMJaSwbBiUrU48dAdIRZAv2u9Su2/Lw+IyJvaMoLJkT7C0diiGG21FB?=
 =?us-ascii?Q?3VK4OaW5BHILMNWUA46dYXI6JfyZTZWkYK/tP2g7eWTPGBJCcITWCjYEtITM?=
 =?us-ascii?Q?2DnmWEkTFZnQM3kfR85Boqkva48b5TGw4oA4VOiUYq09HfW6YKfqawkYa4c6?=
 =?us-ascii?Q?ctXGTmtGgRHgvvVo3Do3TcmyExKmIowAbpqisCGj8SoNHmpPo5B2UIggnLwg?=
 =?us-ascii?Q?oUX5FpjiCtfH6Cqxz2wwGP4z/DzTxXqvPMjzryVa59toI8NhyTed3EEQy8KL?=
 =?us-ascii?Q?2u8PwR+/jj1GgAlI4g/iLg6hydFLFAQyZSdnl0PY1rDkKxR96as/K5c2D6Vv?=
 =?us-ascii?Q?+764Z7bwP0dI83xRSf/ZJHUG+itvE0cfZ8suGcTCqGGso2wP4H9eLuHLgpdQ?=
 =?us-ascii?Q?S2Sh4EU5ACCOIjtzzn4GlYPtbDK5Kj09iQgc4QzsbheSxF4hv3frYAQGjhx4?=
 =?us-ascii?Q?rqnkLg+97dgTr9fGUMYcCnW43YlCCROZYhKvomtLpx62XU93T2OQNpKHu+OF?=
 =?us-ascii?Q?mZ82yebkfuFkwPCr862V520T+UoUeoQySoMD5phMM5U8TEJ4YCJbrcKMFPTH?=
 =?us-ascii?Q?6K45BLM1LeMV3JptT3NeRr95kBnTAmfaT2UgxSTWgJ9jLRqHCxzi7Ck4q9iz?=
 =?us-ascii?Q?V2pO3cJ+eVvQwzCIKmhuXfegB8gpXA9Uq0dtgM6dTwAS/tkDaUcr2vT0sVfh?=
 =?us-ascii?Q?cKVUko9banhnK3hxKjDB8WTApdVIhR37wjIUYnCJ4tZNKZJY0OAFLepZtdt/?=
 =?us-ascii?Q?fuiLqLreqOIrf9xopIGXo0K5qafVvlkjhn4HBIIQl9eBKJl7xQiAlCrvL5sa?=
 =?us-ascii?Q?9PEgvxlTyMHeaBkrDmWFlq7pQKj6dWBxRTt2dkKD327O3a9cn/XOFdbc40+Z?=
 =?us-ascii?Q?0kbK+QP+aqR2g4ToBof/cJyaAfUDy8gB1HQewafQB4oMsLOBcZofQ/6oxDab?=
 =?us-ascii?Q?v15KqiJA31IdumM9wrU+DxyxuC7l9ZIPz3cLJhtK60dRPP0lZIdiUSxURS+3?=
 =?us-ascii?Q?2InzYZPFmA4Q5GQhPPY5CMq4L242VeQVTsGdfrFUMlAlCQrXFaf29EdN8+D+?=
 =?us-ascii?Q?JsyAirjNCpzucpY/Sb7Ol74BH2KomWQggEAzAu5KcwFiJAkXe3zSu2p97zAs?=
 =?us-ascii?Q?cm96VCIwfTH/f8JXKgaMs1nQfrTIb/a+ZeX4+1KNlEmRTxRTkJvFiwpcXokW?=
 =?us-ascii?Q?B0eUKixeAnwPUeHKTBoqQcTaO0L99/lVJ536nrhYJD/9yZ5IxosDesjxavK+?=
 =?us-ascii?Q?WGmQs5LiZ6wN0eBMzgruqwJ4NTRkNuqUzPoAgAgx83Tzimu1/Z8H/kgyYnms?=
 =?us-ascii?Q?0HJea2wP8jMmv/sF7rJZF88mMtWzQKVhoRlhJGRw?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FABDF726EC98D4A8686934A91D5C61A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1337da-af4d-4de8-b01f-08daa24a19a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 18:40:36.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BU956YFgRa1QlnQ7xT3Lxxplvf9sNfwGizsr9zM9P0RUli9a9xa/Fv8rkyfY7l2IdCxBFG4SnGlWu2534czWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4582
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 29, 2022, at 11:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:

> That case could be caught in copy_pte_range(): in case we'd have to alloc=
ate
>> a page via page_copy_prealloc(), we'd have to fall back to the ordinary
>> "separate page table for the child" way of doing things.
>>=20
>> But that looks doable to me.
>=20
> Sounds good. :)

Chih-En, I admit I did not fully read the entire correspondence and got dee=
p
into all the details.

I would note, however, that there are several additional components that I
did not see (and perhaps missed) in your patches. Basically, there are many
page-table manipulations that are done not through the page-fault handler o=
r
reclamation mechanisms. I did not see any of them being addressed.

So if/when you send a new version, please have a look at mprotect(),
madvise(), soft-dirty, userfaultfd and THP. In these cases, I presume, you
would have to COW-break (aka COW-unshare) the page-tables.

