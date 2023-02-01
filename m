Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF027686C14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBAQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBAQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:50:51 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F05CFF2;
        Wed,  1 Feb 2023 08:50:50 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311EEQxR001796;
        Wed, 1 Feb 2023 08:50:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=wGAGEIjifVazRuzzG6XJEY197hofKNytYPSZB/kep/U=;
 b=S8SJJFAImxQvdrVmIpaJGpnKXobrApdRQKy16nj5QoLKoS4S4qJUiXjAI82FKl6SbYK2
 vPuoRC8tq19QSLfTdkecp5ZzstmMOapgqemQFGHYgpxAqeEyAbpDW+cEKy9ua96THuwT
 VK//mTilNlMlQQWxXbaPmpeeilVKU34wQt/6C3lDhDOAsuyhoeZqu3Kpmoo+uS5awGOs
 9YmE3wPdBsUoR3ByOf4uamKGdC/kibpjJAE4T5b7bZ9nlimfKdNYMWD2zyTZFSxQFXRB
 oXx1qpEIbk+NbfhOUIhIraSm+RET7WnuxDEW80V1HEIIrOZB56ZXGoIt7F92YdH2unKQ 3w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nfq39a2t9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 08:50:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/iOK01wo5pX64LhWEn+RKuTAQK98zGNmpK4MpBMa0O/AcKwj9BrFzwDwUfoPoOKxTM0ov+IO0+jt0JL8gdpnkXTJiOgcFGnXOHmrQkleBlVNuXYJ4vywLIpDxDBjjb/+Vbfs2WIab4+WCFfMkI11cUOeNLObVsAGc/AfNAjxNF8PrLnOHxI5/Qyq0KjWWV7RN086kO6REgO/alclFQo8apysnbUbXMiG5nRBbkyFpZnU8gtC8mHpyuQpyVLacpprwJ8ht+HMWpQAjfnuiv6K6snCFpyVHLMKJjv+SUCIeTkf2jwqM1hQcHYLpT34yd+k7/FKoKTs7G9fBAvZ66ENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGAGEIjifVazRuzzG6XJEY197hofKNytYPSZB/kep/U=;
 b=Jow9GNmNP0jvWBviqzsfR2keO8WmzHkWlJ/qixQsh+DiyCXXYXZpaXy/bRLLayElayzWLsLBjbD+kNNGEZ4p7b+KtmupCHbPF0FMnlhT43hhBL9DzcbqR56lzL3Vp31UVlicc3/sGt0XMvr/RUkZfLcy9/04I09jpTcXcWtM9NMtMCHW0GT6G26dWkC/QhNous1PEHbwjJiIqaCeOpkqZ0ZVW9SCbMUOOkb9MqRteynFjALbfyiP18i0QGX69ZoGl9mTkN4fZn2cWvcg5+WR79K7c2kFLqrET9Jr89EHc9xHQ4T9H/2KW3g6Eyc9j9M+z82eFtcU/1t8X/g5G4wVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB4237.namprd15.prod.outlook.com (2603:10b6:806:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 16:50:47 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 16:50:47 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5] module: replace module_layout with module_memory
Thread-Topic: [PATCH v5] module: replace module_layout with module_memory
Thread-Index: AQHZNgkbMNiiPNNmR0Sa/FwZeHqHYq653d+AgABwqwA=
Date:   Wed, 1 Feb 2023 16:50:47 +0000
Message-ID: <8F559BD9-D7D4-4669-9C87-0582F06E730F@fb.com>
References: <20230201064720.1949224-1-song@kernel.org>
 <Y9o52aAC33YlRueI@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9o52aAC33YlRueI@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB4237:EE_
x-ms-office365-filtering-correlation-id: d4bb4083-b9bc-481d-7e0b-08db0474779e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: purQjCJbqdHjuL9wxgu75aRkTXe7ETqQxHMUhr4OS1z2PJ7/7QNX8jmj1L0XsTBaGVjQknxKXfdzs8OR9g3hM7wXgvCz1clN/FWrRIj0IEi2GTiIeeqk+jHgJHZ9TvLfitawxg1okqCJjYdbBSw3xHmXKQ8qzInaPm/fdZD1Nm3u6wQvKyYTCSKmN9VzY6bewgIBWj+CVDqp/gsXLa+0J9cn/v/tEhl8rkv8XKnyFohor2aXjiUYlkMXiUkLqXW2Kjs9v9kjWe2kQrwRyI30nNPgqdFUikyoJorcajUmNPTvMuHAv4s8Z+RP2rbumFvXA947mkYW3OyCZl5vRAGOlXO55wNc3gHEa9ilvhJ/2mLWvHv1mIsXK/NgDmcnWkVgB5EJIYwBsk8TLlHRxX6gFnBexrsGvlboGwXzanVSAw4r3SKYrQkJWgxJ3y4qWmbQUMSX8QI/cJFzCv6u/jFLDkry4M8d97a6sRKiqQjxmIcqGvmOAKn1STx22rUosnnhinJJLuyI9kp99DL5f4V7t6/gs2ZPgKc7Mw62kiR9u/n39D6gQ1dgBKdTspTLnxq9Ly0qs6hB3GXwmTo2yvxzxKvmbX0x05KMZcUOWiIKyzXVGsZXjjHynI57HOezHoYLyQfex+XV8ZBkwPe/Z0Pxosa6FbWw6E/1KIJwbxcjSqwMfJ+r5Fiaoh31zrOC5wk7xSSJh3TlRpz8sxDACGHx8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(4326008)(91956017)(76116006)(66946007)(6916009)(66476007)(66556008)(66446008)(64756008)(41300700001)(8676002)(8936002)(6486002)(316002)(54906003)(5660300002)(2906002)(4744005)(33656002)(36756003)(71200400001)(38100700002)(478600001)(86362001)(122000001)(38070700005)(9686003)(186003)(6506007)(53546011)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xAftoRL8hEKG+EFDPrFImvEkFxr1rBHjyyVZ+UE995Y2TqJ9VWZppro2hY35?=
 =?us-ascii?Q?BpjZrBY/UTg32sUwXUZT9GFJkpAuCzww6Ibi+kyP3RGFvf6b+pe9LFR1Bwhn?=
 =?us-ascii?Q?Ldb+y5LMdNLa/jTdKscTuVqM88cmmbOPzRycOr+0VUpoj+xuQSb+6RoOCB62?=
 =?us-ascii?Q?35FZ7t5TJaumi8iHQv6C66gxolABe1Lg5F2REz4fN9jcyb+5rTfO56re58R/?=
 =?us-ascii?Q?k23nRZvFSJyX83/Lxlu5go/a2d6iHG63l5422DjtS2LwSm2+mx6fpLQGo3F7?=
 =?us-ascii?Q?EoVAZSGpQghZzbQDizjvfkEblL7unWsfFVuGMnc5TWe8kbrWMrxQeoxKJq/L?=
 =?us-ascii?Q?382vEdx1J1iGGw+FyNal40hkAC3RU7dylz8ayYnsXlu4WDAxE67CtOS1c8PR?=
 =?us-ascii?Q?mzfPnW0NNimavlpiYTz2uRX248igOh/03PMzV/csjy/MfMJvkXI0vblBZHv0?=
 =?us-ascii?Q?iLLvaNcJ5otR6aQkEarbm2rVYP2IpANYGxwSOLJ8TISdyMCxWHtnmkWuMmcf?=
 =?us-ascii?Q?1f5rRO/l0F65YN9ZC7c8ablj4lc4gqGTK/dyr1hEg1uGAUuionWVp3LyjbsZ?=
 =?us-ascii?Q?exADaUnLBSIpBqBD2MIiweJMirefyCuRpgh10CXPcPudqR6JjSN+SKuSOv98?=
 =?us-ascii?Q?DPGXp5qDMDs6gJAysBp9xFfwcnSE6axtPBMRG+XJ19HEUALI+oIMBldl0mkS?=
 =?us-ascii?Q?HRXQApnIBln+Eh573lhWwYY9RpTq1bG6V4hOSAq80t6OdUz9O6v8yw6bF3Co?=
 =?us-ascii?Q?ZWVT0gy5Ec0asFsl2RG/c/JZuueZ0E9DFU5XDYxdK7o3diX9ET9lmceOUkMl?=
 =?us-ascii?Q?zkskzvM24UsFJ6DLOwT/LCRJ6lvYhtPtaH0XqeXQ1Voo64uHzT+V4aE5MM92?=
 =?us-ascii?Q?grEapPFkl0nDIgWWNeYsiQyXXy1BN5ixf0MiW4UtWPQGoUr10wgYKEFB++n+?=
 =?us-ascii?Q?vGR7g/IKifeT1AxbWMUIV9EUykFaVThWfaSmuN8aiMONgJtE9EWlxlqh25oq?=
 =?us-ascii?Q?2p1BJuYWNGXRJQb7YtLeiy7fg1r5Pi1fZ2h4Vdlk6VqCDUFYPWckzW6eVAR6?=
 =?us-ascii?Q?TvaCt3cCrJmt1398H1J9ybUrvxRyzEhpwIctKWV6BCIdK5OrVGLvTGzhqpIY?=
 =?us-ascii?Q?HJaynOg0ArGlgrszvcw3RQXIvZmeOO198vlqg2anzULeJ0gH7i3Jqw0434wx?=
 =?us-ascii?Q?c76WhPhtBlCavnGTzVia93S7BNelPCtTw7fTNlrStBFPskS0aZXxc0qBXWt5?=
 =?us-ascii?Q?IJttQXk8cn9Gr2cgM0C/Gt3DRW3f1HD4H0YC55PrOh3dm8z8+HE5WJTEqzTR?=
 =?us-ascii?Q?pQ+zimcQLJETWdCqHXaPb0PjR+77YyBARMBmZMwbc2M8xIS/VcYo7vNAGOoC?=
 =?us-ascii?Q?aXaBcI3otTh6WnnvsmPuWIfoKUkSnDS6eRLUjOJZMf/t5PYmw3iVRrE72daE?=
 =?us-ascii?Q?AxtfF+AOMP5val5KkH6SxCtsxB1c6yqwj81l8R1ml5B/PRivOp4vxwkz63Y/?=
 =?us-ascii?Q?VIs2NUbwY9dPUITav3l7HO68XkZQsu0bRNZND3Uie1YcBrOmOd/p19EHpqpF?=
 =?us-ascii?Q?l43XLuhzUtjx1hEOmmzwdzbxP3DVcXKXg2Iqq2xMs8VisjHpJThvt2eeYHhM?=
 =?us-ascii?Q?+ZE/F/XakI7eJbi+4O4/3+brjnXGuPAcpgbTB4/ilcpo?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B56A8A3F2C4BF409675286CFF500959@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bb4083-b9bc-481d-7e0b-08db0474779e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 16:50:47.2181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIIPsWSiyCW1Ahdx1W37GK1Z+6C46fBSH74YZFpnPmcNywvENcpZ3RPs+3M+fR6XCiwn+KX00q7/45eUTipDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4237
X-Proofpoint-GUID: H2z2WLq2zrTs2rWRCCjGFqnDG45QLko2
X-Proofpoint-ORIG-GUID: H2z2WLq2zrTs2rWRCCjGFqnDG45QLko2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 1, 2023, at 2:07 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
[...]

> 
> ... you write something like:
> 
> #define for_class_mod_mem_type(type, class) \
> for_each_mod_mem_type(type) \
> if (mod_mem_type_is_##class(type))
> 
> Then we can write things like:
> 
> for_class_mod_mem_type(type, init)
> for_class_mod_mem_type(type, data)
> 
> and
> 
> for_class_mod_mem_type(type, core_data)
> 
> (this last could be used in show_datasize() for example).
> 
> Does that make sense?

It sure does. Let me give it a try. 

Thanks,
Song
