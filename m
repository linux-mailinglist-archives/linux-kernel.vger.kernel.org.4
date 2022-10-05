Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1771A5F52EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJEKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJEKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:52:32 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486445AA38
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664967150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cocJeKQ/JBBWRheWXPA0r5UfM37A0LKBsDlyCE3nnZQ=;
        b=KtOWHDk0S9ZPT88+v9ROo7ctyppxOzMeVG8lmBfO+8Cngmjsfz3PWAVhwGqFQf+p6XnM87
        a3xDivM+AK+LripuXVG1y6ImDM+7F5dsmJkZSVLzaaDH0t43+grB1Y480sfQ7V3DUCw651
        FcXJpXrMZf72akEX35e2heVwFBTpFGfL/pMhYU8GTXnOHjUb8Jy2IWb4Tj58xb4GOq3pRy
        IeOaNE8bu86t4t03YbV4081rQmzlQtgj5LgRppveb4nsY7J1sq53PlsBiNNL3nd2qUMaYp
        TjI9W+hy4JSuf+85ZKzrLkMYyufxzhmj12tSBsaSW32TVp6YsT7dh0pKzL2lpw==
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-Mks1x5IbN9iz2dnQqsOCsw-1; Wed, 05 Oct 2022 06:52:28 -0400
X-MC-Unique: Mks1x5IbN9iz2dnQqsOCsw-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM6PR19MB4247.namprd19.prod.outlook.com (2603:10b6:5:2b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 10:52:24 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c%6]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 10:52:24 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        Yi xin Zhu <yzhu@maxlinear.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 3/5] clk: mxl: Avoid disabling gate clocks from
 clk driver
Thread-Topic: [PATCH RESEND v2 3/5] clk: mxl: Avoid disabling gate clocks from
 clk driver
Thread-Index: AQHYzkwFrQSJjUImDUOzXbBrfYxegA==
Date:   Wed, 5 Oct 2022 10:52:24 +0000
Message-ID: <MN2PR19MB3693559FBE8E207A11316312B15D9@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <5a88bd5a9e93cc6e794080e5cac821ae0c27ec56.1663827071.git.rtanwar@maxlinear.com>
 <20220929001745.A4F9FC433B5@smtp.kernel.org>
 <MN2PR19MB3693EEC08EAC5370F1D195FBB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
 <20220930010123.38984C4347C@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM6PR19MB4247:EE_
x-ms-office365-filtering-correlation-id: 0247c3a1-217c-4cb5-6a19-08daa6bfafbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: OtHK3ZeEk50EY2XciqG89mnkV0XCQEr9aPfu0b1kRIA9X6CJBZ9VbwJZHP1sOrlWHOEXOl9r+dwmXsiDNCpUZjLhqP74iLd29g/bjhnkdxxXhEa6qsgFtpGVqZmwiKosvmn5qo/nS+bgCQILMb203WhmZmIXVPkJ5Ix8anMMF1SXZbnWtgxcz3bF2ogd6oCdT67e19vZjCiyEV4l76/LWxnaLM9GXVa1jv0s+snjLLl6xOz9OR8nViM2+uQytAkDhNbA8+fb4J3pL9U20nrOZtTlpSPkgT6YPVr02o+4HKCvnqVF99pQMwVqthBgDOEKOrBgqZ+BwEOH/WijaOR5wd+rHm6ZX2jK/0Fl5gOmRPxhjbvaYEH8cOScDaJQTmlg8aYtPP2dpoK5ErXpdmjqhgxLGxEU7i4lkw0U6FfdReXl9OONXb1CDpupAopEsotSeVAeXgdJHC8P9gmqrNOS/llUk2RdBt+JBjWT5tMovy3rvl1zZN3uj5uCIBUw5FBkzMjBb5voitzGoXEynUuJsKMI04326EoUkbG10GAlf7FSQCB031sJMILlQeZXaOdzaxjluRneEbjRgW7JRQHtE7U9qnx63EVzyxF+qhQiXDi8lA1nI9sowIG/n1qb35qH3TB5aZ/yFGaHl5LhWON5956B5+H7KzjkCjidmu4bP31r1+UgsSvhgJ+52XjVZnfFE1rQ05UHkdtRgmOxb5vkBnLy5sbwd5ePptiwTRgaa3sre+qTmfC4ky47Hyw83GIc6Z1P+KGFSTYUFkHQvRF7kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39850400004)(136003)(376002)(451199015)(83380400001)(186003)(5660300002)(316002)(52536014)(9686003)(26005)(8936002)(54906003)(110136005)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6506007)(7696005)(53546011)(4326008)(8676002)(2906002)(122000001)(38100700002)(41300700001)(478600001)(71200400001)(86362001)(38070700005)(55016003)(33656002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?usPp1yH0jIIIxffqcRKcYH3AuBAp2v/S03V6eDpQKIYFlaBSWbE30F9leicE?=
 =?us-ascii?Q?S1X4Vmxnlke57/i2AJqfyJHsk0reo0QHizpgDZrdM/zLm63DqEqTZ9Lg3mvG?=
 =?us-ascii?Q?mktIHhuX290twUnT8pfpZwKXpLHDEvu6F3dHgjLMtQMjNsTKszzFyIUbf26R?=
 =?us-ascii?Q?+69f27OdvJLo+OYMs0DSzOxGgANs/R4zynqQ3TWM4WmbxWBVvbfPN2UUKTgM?=
 =?us-ascii?Q?wh6IQuSD+Viy5LqaR/h+AZgh1mv1bx6zfegU99be89m6C+6xRIWw8bfL4ccT?=
 =?us-ascii?Q?qDxxJSUxUBf4IHkHJ1vtqiloo7JKIRn/8HR1mCa0QWH0r6YTEwE/8Gk9VJLM?=
 =?us-ascii?Q?0jH+y9BRXpUgHFYbWBioHhQt80zB7zmmZjVzThOSFC+e/LK/cM3tQcnVNFW4?=
 =?us-ascii?Q?z/2QTYcAg9KbfrHV/0KnmGU6N9Qj4uIxEPd/EzfRCR7xXd/mspLpQDIHloqA?=
 =?us-ascii?Q?DUKFUtFdUqt2rFKPw6+nV4CK2km6N8yMtze3A4Pel7wx1dloz9RG9JqDyNbr?=
 =?us-ascii?Q?twFgy2qE2dwDXA3r9hT8lnAhx7N2ng5pCS0dpkS3uU1xsovTa2XcMxZhpWNx?=
 =?us-ascii?Q?sNJdGBGY5yG2LnnPYWHoFXSnO8SQiKTFxZfXVBQ/MvYpkGzO6KBch5Hwj/NZ?=
 =?us-ascii?Q?CrRpGBi/NwoVyriI5AF4sqysTpqmcfEOYaqdzb8yEMYpcxk6cFbgP9VnODwn?=
 =?us-ascii?Q?p6kfsp2G4M06FZFQckQyriNkQo+2u0CJrBSwiqSF04KCsZXFDeHXxTZ9o+BY?=
 =?us-ascii?Q?qOq+FVUAKfdKDTH1NqUovFGiitDVVZCvPjJW32hmLyH1uAGDcoGufwyQoo8Z?=
 =?us-ascii?Q?CPqBkkf9gDoypkbSKdLNVHjNwm8gg2TIVi1biKxKX2GU9nR2UnhgpR/+pTGW?=
 =?us-ascii?Q?Fcs8jHNPzrwM4WCt0dGCuN6wfewx7DYp8yVej9FvpukHjqVIXH8rYfNSxadi?=
 =?us-ascii?Q?+97BI0nZc/SJBnz3IZAEFDNa9d5QpND1EMJgb07uRydiaFgAcFsmSuiJfg8H?=
 =?us-ascii?Q?h6FAjqBldLwN9Ui7kKtjkAXiN8nZEdhyIKqqhloKaJ/OUXAf7ZRhfpwenxe1?=
 =?us-ascii?Q?mrAJ+4ineGquSVT8Pl7+IndDFxCM1kPjKTYVPGXMxqXWqn30BcRh+lcR3Svp?=
 =?us-ascii?Q?OLqO84qt1mATmtkR+uFv5z8VUFLPSqsqrKnazsdXjbnNd9BIsD7ih6QqWZFO?=
 =?us-ascii?Q?j/bm0BQBhdjoBAxr+mxiM9MfNfd1yRz18hnlnVuvD/0OIc4ljgGJzqYkD+lz?=
 =?us-ascii?Q?I/ZA+F3oEt0tbhrOcltoe4x8FqHHSsZ4uMKz/AavjMXF+MNPuD7tx4wHRLA4?=
 =?us-ascii?Q?dQyKMBCD+Yov9ZDLmo+TQDqbChIDUhZWrZ9imaqLDcD8/ODk08q6lbpjkHD4?=
 =?us-ascii?Q?c1kNH7BmXJ5ThO6UYFBvxfGbJqXHQ1doHf6mnUIQCHgK1nA1sB3u2mC9QVWO?=
 =?us-ascii?Q?sX1Z+oiWE8gat77cxtE0G70FgR+GKGPVLcIxJ5ExszlnfhtOGAjhwiCoX3MF?=
 =?us-ascii?Q?32S8YxblFUOfWFbRX6ZVHVyOdcw6yum92/bsFCOFbX2MSe77azKrz0XojdJi?=
 =?us-ascii?Q?EnEJcMNUgqgRdOj3B4P0X8b07i6cNSie2TIW0Su3EJa6QnoYz/7+qo33+1bk?=
 =?us-ascii?Q?uQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0247c3a1-217c-4cb5-6a19-08daa6bfafbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 10:52:24.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbOy63rv2H08ug7i/3jJSAJflEpaKxfoaoN9GzLFtLRXkRe4xSwt97zQcXRFRfkQOEmIFz9iP/TeILiuXmqoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4247
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

[Resend due to mail delivery failure in earlier reply - one email id got=20=
=0Acorrupted somehow in earlier reply]=0A=0AHi Stephen,=0A=0A=0AOn 30/9/202=
2 9:01 am, Stephen Boyd wrote:=0A> This email was sent from outside of MaxL=
inear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-28 22:45:59)=0A>> On=
 29/9/2022 8:17 am, Stephen Boyd wrote:=0A>>> This email was sent from outs=
ide of MaxLinear.=0A>>>=0A>>>=0A>>> Quoting Rahul Tanwar (2022-09-21 23:24:=
26)=0A>>>> In MxL's LGM SoC, gate clocks are supposed to be enabled or disa=
bled=0A>>>> from EPU (power management IP) in certain power saving modes. I=
f gate=0A>>>> clocks are allowed to be enabled/disabled from CGU clk driver=
, then=0A>>>> there arises a conflict where in case clk driver disables a g=
ate clk,=0A>>>> and then EPU tries to disable the same gate clk, then it wi=
ll hang=0A>>>> polling for the clk gated successful status.=0A>>>=0A>>> Is =
there any point in registering these clks when they're not supposed=0A>>> t=
o be controlled from Linux?=0A>>=0A>>=0A>> As mentioned in the full commit =
log, only reason to register these clks=0A>> is to be backward compatible w=
ith older versions of similar SoC's which=0A>> reuse the same clk CGU IP bu=
t do not use same power management IP. Such=0A>> older SoCs also use the sa=
me clk driver and for them these clks are=0A>> required to be controlled by=
 clk ops from Linux.=0A>>=0A>=20=0A> Why is the clk driver probing on the n=
ew SoCs? Is it providing=0A> something? Can we detect that the power manage=
ment IP exists and not=0A> register these clks?=0A>=20=0A=0AWe discussed in=
 the team about not registering gate clks at all as you=0Amentioned. But if=
 we do that, all peripheral drivers that use these clks=0Awould need modifi=
cations so their probe does not fail due to failure=0Areturns of clk relate=
d standard calls for e.g devm_clk_get(),=0Aclk_prepare_enable(). These are =
standard calls in probe for all the=0Adrivers and a lot of them use gate cl=
ks. So this would need a lot of=0Achanges with possibility of breaking work=
ing functionalities.=0A=0AAlso, i incorrectly mentioned about the reason be=
ing backward=0Acompatibility with older SoCs. Main reason is to support dif=
ferent power=0Aprofiles use cases as per end product requirements some of w=
hich might=0Acontrol it from clk framework i.e. this driver. We keep a inte=
rnal=0Adriver flag just for this purpose to provide this flexibility depend=
ing=0Aon the use case which is what we have used here.=0A=0AI am sending v3=
 with more clear & correct description about it to=0Ajustify the need for t=
hese changes.=0A=0AThanks,=0ARahul=0A=0A=0A>=20=0A

