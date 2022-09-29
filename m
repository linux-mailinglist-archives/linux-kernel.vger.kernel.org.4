Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62315EED4A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiI2FhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI2FhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:37:19 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9312AEFC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664429838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jKhQDPMAcCg5cqseUG58mX+XHF9xlkNY1m6fjQYiBnE=;
        b=byNnOHVwVC8i7orMS7JN17874dQITtmyEpQmK7l5/fApmJZ7mjgw6tWbYV7i+akMxEHBUx
        zdZCuxOTG6qPGIixhn/G2bdj3378YdHRYQfdXiMBxrIZize+TeG/ZkCFw8fVJPD67kGX9J
        OkmMXWQ6MkqLu8LMq+bYJyI7IwQgiYPEVFtBvwowc131HxK158j2PDwCYW4TuAXO//DMWf
        1zPRn7L0MF8kYveyrNvkBk033fog68G4GEjCmJIpoIofixcj8XPjh8TqWI4uNNXHJkDMD5
        qr24+qk78ErOujsTADpLIWjaDKpSWIQGTz8cxXF5MtvwnWKJzZubZZBeS2nLuw==
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-FMu2VKa-PEa0mPUEuurXhA-1; Thu, 29 Sep 2022 01:37:15 -0400
X-MC-Unique: FMu2VKa-PEa0mPUEuurXhA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DS7PR19MB4440.namprd19.prod.outlook.com (2603:10b6:5:2c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 05:37:12 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c%7]) with mapi id 15.20.5676.015; Thu, 29 Sep 2022
 05:37:12 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        Yi xin Zhu <yzhu@maxlinear.com>
Subject: Re: [PATCH RESEND v2 2/5] clk: mxl: Remove unnecessary spinlocks
Thread-Topic: [PATCH RESEND v2 2/5] clk: mxl: Remove unnecessary spinlocks
Thread-Index: AQHYzkwE27uHBIRl/k+jM2EqBGGnfg==
Date:   Thu, 29 Sep 2022 05:37:12 +0000
Message-ID: <MN2PR19MB3693F52C3C40843C9D11667AB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <be8772d962788a3d8a37c1f02abaa9821606a6bb.1663827071.git.rtanwar@maxlinear.com>
 <20220929001606.02029C433B5@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DS7PR19MB4440:EE_
x-ms-office365-filtering-correlation-id: 6c9c89d8-86e8-4f43-2731-08daa1dca8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 8WcvCh5sFAxjbAap1vOGvSjDn1g+PyP38VnfZKgaLByOjzg3jGbN8wUwWDRo3iniHGSfO0CXSAM99vIippYT8L29KnFw4k6W0W/87QeDYYTBiITPpULsyeB3ZC6vr9MGAdCCsYVTX08OLU/nN0Lgav52XYJ6MlnnlV4hfGCk4py++NfbPpywYByQ42A+adNbU52dYs1N0X+rXu7MDSm5mO/7Ba64pEyYyl0MepTIEfy0j1L2umXhOf+2LZXYEWOxhYvAQNYop791fhqQQf4x2xzSstxQxpfJmZbpR/Mv6O9goLJZUQcw+Pab8KGxlYR3WFt05Ne2h0UCEvvDVkntPhRi7SYE019F20gc/q5U/B24eFr7w9nVrHTq5o7H4ccGTbGSF+HyNU1vaMtWTQi7/NNGc1Z+2JVnz/+xMbIV/h3IFqKiclDk3fWbYV3oDr1LYVA7Vv583I6szT4ekcpVCoXuYqiwaHZ0Y7Zy6gylBvptxgr5qmsKKHDwWJ2TP5kD9A1cwDBuAn9cvrDLXLorm9bgQJkAYNh9ElipjEneHyyLTFRIl0fBPGkXl+1QTblWa+d6UY6TD/0FtAUaNBoe8+DQdkVjRopAL2NVHYN4IebzlnHovkYDK/zjLO8xjHCzpOgPHoQe2ZvQOZNtFnQ1z6LPBQPrVthAqlfTD9V9Gq1lRDtSwPfnWOzpumNj34hgmgJSj0pYczWYfh61c3xTgMNFawOVoF7gdSadJFSG1FQ99gO5wFbPJ7PRtdWwOc1HyK/lTZyNrbynYhH9Rj2iDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39850400004)(376002)(136003)(451199015)(2906002)(8936002)(41300700001)(107886003)(52536014)(7696005)(53546011)(6506007)(9686003)(4744005)(26005)(5660300002)(4326008)(122000001)(91956017)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(186003)(83380400001)(38100700002)(33656002)(38070700005)(55016003)(86362001)(71200400001)(478600001)(316002)(110136005)(54906003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxxNf5Nsz2DujY1LtgTzJnoCgMYI1b9GcE1NG9FQyW7jgdmakonsHd2S40q0?=
 =?us-ascii?Q?tNinYizr0IjRSrc+J6zhzoT6Y0KeIw5LhnjZhT7C6lWntBEssmWYGYvO3otJ?=
 =?us-ascii?Q?zNfdBbNJ9C5Bm8CbGCS8uvQACtgJ1DN+8SvRfLxaWhCLsajrQNoY9xHw7iAA?=
 =?us-ascii?Q?lFIe70oKd6zeorIwW+/ydt48ELwRXuu4VuPWg44q7kXGgq37+zf5naWyS36J?=
 =?us-ascii?Q?VEw5mwiU0m4Z3iCGvzEGTS2TywGb51cIYsxD2m11llPm2fWeg9du07K0LHzr?=
 =?us-ascii?Q?bLM/L8DEvu14Ftxc6hp/VoMNeqlrWlo5kCNrDdA4ZTR4awllXq8fME/wwrcI?=
 =?us-ascii?Q?TA0B3KqE/Z5Luq92QwlwL+O+9z077w8Yxy01ShekKoVNrltUiElm5lli8/iv?=
 =?us-ascii?Q?wrDfzeTwhBwoErFYs6eu5duTG3cXwvJ9mImfRoC9PQcOdkPgTzDwoo+5Qw0J?=
 =?us-ascii?Q?Jg1GO28RIsYziyxYGLkTu7BqVWBW43NMVLadAtA2/zcJN2jBOWwWbeWnq+lx?=
 =?us-ascii?Q?eud4DjJh2XC3Pq8c2a3g1LtDvdVNh7kNycKQJsYjkRweKoXesb4PNGTrx9Be?=
 =?us-ascii?Q?vRVLG+twu2EXGTenhTOD+WDYIowhgwHRt3J+6LPVDosIpZwQRELg2kpeRsRb?=
 =?us-ascii?Q?e3gVcxK5FddMMfvh9HYGm0y+hYSlVfUVHKDwE9OKqvXU17DSzAeJo99gijbc?=
 =?us-ascii?Q?5EYMR7K52XWJUZkyTHkSZDVpUvmVDueFH/KiVff0clqWel6HRzwXFlo7C+6l?=
 =?us-ascii?Q?wuaAVpk6+HnSq34NDM6pf7t3f5qGyJLef8tUSU15lnEUbLiUgxqf5gl6fJno?=
 =?us-ascii?Q?s5R/hdsApPu7or11BjWwssHIwg/Y74piiIDNBVuP0BFfQ42haDBcjjwac8y2?=
 =?us-ascii?Q?qYMwJGudDo453gqRL9UdQvmPjLraN/7q3zV+10HblL4LZRHkM7lWyBDKgq3i?=
 =?us-ascii?Q?c2A5rIxdNFgBy1iCD7sjdrDY7736DmnWIzu1VuAs6AV+BY3w2W8kXkaNYjKo?=
 =?us-ascii?Q?9t51QEzLhlVk/Ea8cnRish7XP3CEQUABHYbYElLzU5kl3vlZ2uarN5HXqtvz?=
 =?us-ascii?Q?5JDTGKvLIlSzs9L6o1R2+pC0wS129fG59R5so1st+o4ShtHItSazXvPERG5K?=
 =?us-ascii?Q?LqjRuJmAbpR6H14V2r16HO7TFHfDDcE731JhZE5flNNMds/AQZcRwFBQh+Op?=
 =?us-ascii?Q?zWdCTUFpihgTY1DDQXUAc4ujHxzl88vK8S0wmatYTflXER9u03j4LV5MReU+?=
 =?us-ascii?Q?UvNdGi7osWpnYzhHCeGJixqQKd3kmGW2tJFwiC0r7szvM0IFLSKsO4w5AYVM?=
 =?us-ascii?Q?T8qMb1DIvvbfco/BuOtT6rtMVkaAsF+MxjlLrKWlEQ1E/y/NCv8R5Ni5FdQt?=
 =?us-ascii?Q?pGluONukp5y4Xw7oM+DwDlIVYx8m2C/32bXP2w8xiDEC+q0sRITq7OSK7pJo?=
 =?us-ascii?Q?UBja3UcWOjtdQGWt+IfTOK9jpWdiFxkRBz4/u0DAAac6yTccQClyKDjkPa/d?=
 =?us-ascii?Q?IDijNesG2NyhHR+JuP4hadQ0Sh78oZ+syMn6MCSQA2a394JClRMesLSPRlLU?=
 =?us-ascii?Q?w8VJzwCkZOJi0uL1dbgaRZojTFN1xUW7YVVWmDtCh/Gkxk2YJia1bCIQareA?=
 =?us-ascii?Q?iA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9c89d8-86e8-4f43-2731-08daa1dca8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 05:37:12.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UkvTB83JFAhBg84o6mWYeuY0Fjy9c3VhYVB0SW0uzImHszQhJK8DDB55Mb9Zc8Z/ar84hliErZPehq/9RB6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4440
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/9/2022 8:16 am, Stephen Boyd wrote:=0A> This email was sent from outs=
ide of MaxLinear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-21 23:24:=
25)=0A>> This driver is now switched from direct readl/writel based registe=
r=0A>> access to regmap based register acceess. Regmap already has its own=
=0A>> lock to serialize the register accesses across multiple cores.=0A>>=
=0A>> Hence, there is no need for additional spinlocks in the driver.=0A>> =
Remove all spinlocks which are no longer required.=0A>=20=0A> Can you confi=
rm that the driver doesn't do a read, modify, write (rmw)=0A> sequence wher=
e during the modification another CPU can rmw and corrupt=0A> the previous =
"read"?=0A=0A=0AFor rmw, driver uses regmap_update_bits() API. All regmap A=
PI's use=20=0Atheir own spinlocks before doing any read or write or rmw.=0A=
=0APatch 1/5 switches from direct readl/writel to regmap based API's for=0A=
register read/write/rmw in which case additional driver spinlock becomes=0A=
redundant. So this patch 2/5 removes redundant driver spin locks.=0A=0AThan=
ks,=0ARahul=0A=0A=0A>=20=0A>=20=0A=0A

