Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02DE6A737C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCASdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCASc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:32:58 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CEA1705;
        Wed,  1 Mar 2023 10:32:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgwKI4oq4q1sQ+pT8/rYXT+gumSYhvHyM8x7U/spmYeogblWGWWOmcIxB8AMrRBARQggQcWKqEFvcrqV60xWz5CcTfsQ3svkDqv0xHuDYZiCsbLvYFeC+aQa2uFYZbRrCV19zx2+vek30mgnvdrHY1weH4pLncagkdjA2y17PF1wdKLR0PHBTOdQCpl2ocBWIFle2dYSFRxOuwF+1ItvGv79ERC0BKmkxs/AkH36igO81R1UO1MlHZDj+UcNYJpDtViYLHQ217li2KNTVHXM1ZEab9T0hNUavttQp5pO6Hygc0BiqHb7pgL5YBjkT5eWHEPaqmqCO8aQorldDlYOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S/uaDYqg9dQez7rPVdwINmSUSj4Kio8JdM64fDkEIA=;
 b=FGu7cXD+QhaYnzjQp9f2b1dAWkRcaeHalmCavoHBtBov8gOxHsN3Aba7cowwbodfkdZJmXC1UurVHBynj0ymqgJygUXVAUCbaNb7LMwhMMHDIGqZu3ZF1bz4TJBrhNIRE5aACw34VoP6FvcG91LCHe7RPCxskU3R09PSEs//TC0waw622LkLMmi/Y9Hmo74NWvDkYMjnm526iXQqg3KofFGRtVIeqmIugYaysaQlVt6Z/8OVG3SNXbZkEcBh7EEOx28cyqSROeSaFCzHn/C6TXiT+KoBVNO8Cg83dtiSqHr+eIJx9Gw4wJQqjEK00O5S6CroGOMAKHwekHxDLZVQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S/uaDYqg9dQez7rPVdwINmSUSj4Kio8JdM64fDkEIA=;
 b=D+kcJvhVNpPoqR7CPyoZVtWw0GU8Rs6nHVuxhNLDlFP45pOq20fympejWb2IVHp61xx+6o3dnRXlzCrjxwSXA2tM31Jpl5NubAX/cRwVpJEMXWCCw6FfFilpKMUV/0jg1is3d2GemZRGVTVTHZC5FGJGvCANIMDGTLfQUwHjDdc=
Received: from DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) by
 BY5PR21MB1425.namprd21.prod.outlook.com (2603:10b6:a03:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Wed, 1 Mar
 2023 18:32:48 +0000
Received: from DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::1995:2d08:c794:69c2]) by DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::1995:2d08:c794:69c2%4]) with mapi id 15.20.6178.001; Wed, 1 Mar 2023
 18:32:48 +0000
From:   Steven French <Steven.French@microsoft.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, pc <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Subject: RE: [EXTERNAL] Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
Thread-Topic: [EXTERNAL] Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
Thread-Index: AQHZSGn8WfVj9/uepkaTNnWH9IUOCK7eV3eAgAAbvoCAAAHyAIAH0TYA
Date:   Wed, 1 Mar 2023 18:32:48 +0000
Message-ID: <DM4PR21MB3441EAB1A9F4CB0528545DC4E4AD9@DM4PR21MB3441.namprd21.prod.outlook.com>
References: <2009825.1677229488@warthog.procyon.org.uk>
 <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2134430.1677240738@warthog.procyon.org.uk>
 <2213409.1677249075@warthog.procyon.org.uk>
 <CAHk-=whFKL4VuFBWvenG8fAgfvbf36PDgouUSx47rZDWr9BkJw@mail.gmail.com>
 <2385284.1677259167@warthog.procyon.org.uk>
 <CAHk-=wiAQZUZCEH1OxFb3Oa_mqz69tagdXHnKuYd_rwRHba5Cw@mail.gmail.com>
 <CAHk-=wizKeB-EAsFgvUUfL2OaO3+W2OHr2L8Y4cGBBheYeJdtw@mail.gmail.com>
In-Reply-To: <CAHk-=wizKeB-EAsFgvUUfL2OaO3+W2OHr2L8Y4cGBBheYeJdtw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe99c797-087d-4301-9864-763dbc74fb26;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-01T18:28:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3441:EE_|BY5PR21MB1425:EE_
x-ms-office365-filtering-correlation-id: 17522fbc-40c4-49f6-baeb-08db1a835bc3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkhHCIKf4RdCr3Qq4g5LLu3BqPOblFhidUCvo69z5ztRY9EGtKuoHW1vCkwYAmACOughmILHOVLVj0KlTKFwvHLtlt5E1v8zw2IYGzsqmq7Blj4PUgMj3zOL8xI2LskJkJK0THMnIkG2hY2Cepd8npwKSE5eeoaP91sOGdPBqR6Eh4/YcUl6fQoMs7Rf2KiUrXlH8k3tnsOt29dk/nceQzfPHfXS0DoegmADsppSN8/RlOotFXZy5XV1pnSXQgljQuPPRaV8o9+NTb9U/ELKnrRWf6ogOwtUgdCvrwlNtf0Mf9DWFo2Ccj9LOKZtOs7Ruv79nl4Vyc7H/NnugEcWGUfiJlOPZApT96KOd7j+ID8T3IAZH7I6eYE7v0nNuqCIROhz9iS4+rYzLI1R9qK/bCus5V1Mawh+drrkiRjG5dZnL2kaf6kqGX8W52QMvOxWVI7cBlV3VcigS8YvZcZI9KLn9Ip1utIlUr1XuUUkIcsmzs6MqaPXSYuuoo+zvziNyZ9WvvZyaD21Eyzrse85gDjqA261hWDecjl9uycxJXaW9ZsQAh30GUBb1kxb/xpmUsSK05oelw8ezDBTxp2sHEX+/nxqzp8rfMvubxjV5DY7odF9Vu4Zj66czc5Y0miItgc2WABvEqcin1eJHe4KfPaUi1ktfDX958peOSc5qCnBNk345CfsG/MZJN9Agp9JIqskRE8Num9E3a4Ku7o/i/OF1YH6lXeIDo7AoNK17vn0LI8mTg32VMccYErk+f59
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3441.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(33656002)(52536014)(66556008)(55016003)(86362001)(66446008)(66946007)(41300700001)(8936002)(8676002)(66476007)(7416002)(4326008)(64756008)(5660300002)(2906002)(8990500004)(122000001)(82960400001)(7696005)(38100700002)(38070700005)(82950400001)(71200400001)(966005)(54906003)(478600001)(316002)(10290500003)(76116006)(83380400001)(110136005)(9686003)(26005)(6506007)(53546011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l4cvPCVENQB368aXdwk+2UxWlvCDXypK+cLDQF4vRm0vi3s3k7rO9nYIfJ1x?=
 =?us-ascii?Q?iDOmRxpgi68aI9TRHcB3SxGddyCQ1USi8TlvyrBv3p4xOzdayWtIhmCSdkQD?=
 =?us-ascii?Q?3dWpsTTzdwMccjIMT18tbjufMG7GXuOM02Gx4N/Y7cUMeuIUuRK6QwC1EFZa?=
 =?us-ascii?Q?jDD6xv1RwLOVnRwYj461l7L+ciSZk6VBCpGHRRbGV0UbBtcds4/sjDXrlrQh?=
 =?us-ascii?Q?59zT7sqZSY+Xg0mdAvttvkL7E2JEJqa0guSVoClBbqwzNhVQags9G88AkfZu?=
 =?us-ascii?Q?rMkarQJNgj93zeJY0jrUCrYcTgzOiQCvgF/MREsHuzDWjBI3YMydpfF0zHnO?=
 =?us-ascii?Q?5a/OKfnPDn7v4PVni/dOPTvGWmyRatz8oY9f0+8gUym9klXcNtZSqTR489CU?=
 =?us-ascii?Q?5nKYIPSrfrh2p/kqO+vtIFTypbPIzZcAieiW6yf0fIWJL/mZS5iJnq4dHI7x?=
 =?us-ascii?Q?Qb33b76Gxix5UyFTZiWiw8OxZoVEfMtrW4AeAPBCco3jxXXE6yBUPv0aGkQ/?=
 =?us-ascii?Q?fCzJuYIyS9XZtl8uChgyrOhN81f9lLcnxfzDDDLeGONeCL/7eKJdQ1khqt/M?=
 =?us-ascii?Q?FtxdR1qHz6LUnaX35DyR/63DdaqxOTNu9AOhJNldCNiuji6354x4P12JsBPD?=
 =?us-ascii?Q?5ONexLYwePgiIpCQnGBI+m86lvKCTEK9De1nLqvpK2OM1uiMSVl+m96zbZYR?=
 =?us-ascii?Q?bTfVM3XcsEZTUhWm8lSB5vK5aiD3JRejd1jLS4lC1S1t/NaEgzBqQaHkZq7V?=
 =?us-ascii?Q?gIShmIWnIcpMBKcUKXbgAWYqeX0S72iCCBVahvIaSYAndM7fxIikD4iLJMyt?=
 =?us-ascii?Q?TYR3mEmHS7EkJsTiOPdVDyKtz7dL0q9mHTuU9AmvPxqj64KyS9fv6vCPVE4r?=
 =?us-ascii?Q?HPMAP7KS9SXEEjTsBjb+t3W02P4IqmaLYU7zpfSkJFzoAoGzYPXH0E2c+C0E?=
 =?us-ascii?Q?e2t8HGRNl4oK4K0CLmH2tpyQWqrk8iaozQJdtDLphOq3iAEIfHit/MdyyJwf?=
 =?us-ascii?Q?7Hd8vD6MA6WcVmAKJTDC7EtJvHsaoz+UVJGrIcY7XMBxfA1UtvRyFpq0hvoD?=
 =?us-ascii?Q?nn47FR3Up38zE4U++z/+pFmF7sThQ78zon5saYaRPclCx+qyKeEy5z62IQrq?=
 =?us-ascii?Q?nhzw8hAbT1Pppat0FYTxa8GkFEHYfKr4mPpCBswahA39zHJXIubhE3m9tHAX?=
 =?us-ascii?Q?oyJTl05A2XdS8PdIhICp0yLvpN29tSxI4VdpuzRDw1eG+fZ7TKJ5UlZUx2sj?=
 =?us-ascii?Q?KLbvj8OtmumFDFmu2LQfqh3edH+HwMUboeh5fmaVGn0dbmd1FC0GYSunhEgq?=
 =?us-ascii?Q?NCdBP5su42tNw68Rd+CqQCjqIbdy4AcQcCNTVtW7NjjQnCYkXkggBk7h6Tho?=
 =?us-ascii?Q?bTdBmppp5XDYM/n4gZRjSfXC9XYT7X4X49JV5T0iKckNnX2lJVQf8Rt0B34z?=
 =?us-ascii?Q?NC+rHnSTYcFrLtpi2vhrZGX0y7d/UyeeRON18jp9xfseNrV19UobHLDBbsPi?=
 =?us-ascii?Q?80qYSKcSuFusQOTo5H9+5RPlxvDOpgZajZowUUXSN9pXEX4NKnM8+lxnuafh?=
 =?us-ascii?Q?jXxl61YlbBTSsdFiAOQ9T8bTthQwLDUGvF9deSkZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3441.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17522fbc-40c4-49f6-baeb-08db1a835bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 18:32:48.5492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+oIaeIz+rjcBggGPHAgoch1trwf8Q32qLr3g+vTc2P8bpYyWl56xpp5fL2ALYFu5oKhZC+vi3v4C54L9eckAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have been doing additional testing of these - and also verified that David'=
s most recent patch, now in my for-next branch ("cifs: Fix memory leak in d=
irect I/O") fixes the remaining problem (the issue with xfstest 208 that Mu=
rphy pointed out).  Will send the three small cifs fixes from David later t=
his week, along with some unrelated fixes from Paulo and Shyam.


-----Original Message-----
From: Linus Torvalds <torvalds@linux-foundation.org>=20
Sent: Friday, February 24, 2023 1:06 PM
To: David Howells <dhowells@redhat.com>
Cc: Steven French <Steven.French@microsoft.com>; Vishal Moola <vishal.moola=
@gmail.com>; Andrew Morton <akpm@linux-foundation.org>; Jan Kara <jack@suse=
.cz>; pc <pc@cjr.nz>; Matthew Wilcox <willy@infradead.org>; Huang Ying <yin=
g.huang@intel.com>; Baolin Wang <baolin.wang@linux.alibaba.com>; Xin Hao <x=
hao@linux.alibaba.com>; linux-mm@kvack.org; mm-commits@vger.kernel.org; lin=
ux-kernel@vger.kernel.org
Subject: [EXTERNAL] Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()

[You don't often get email from torvalds@linux-foundation.org. Learn why th=
is is important at https://aka.ms/LearnAboutSenderIdentification ]

On Fri, Feb 24, 2023 at 10:58 AM Linus Torvalds <torvalds@linux-foundation.=
org> wrote:
>
> I'll apply that minimal fix for now - I think the right thing to do is=20
> your bigger patch, but that needs more thinking (or at least splitting=20
> up).

Minimal fix applied - that way I can drop this for now, and we can discuss =
the whole "maybe we can just use write_cache_pages()" instead.

Because that _would_ be lovely, even if it's possible that the generic help=
er might need some extra love to work better for cifs/afs.

             Linus
