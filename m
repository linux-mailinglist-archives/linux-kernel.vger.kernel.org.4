Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983595EEDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiI2GK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiI2GKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:10:18 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE54BD3C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664431813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PTtWzRgW3VqZaOhXccFFDFwzCsNI/rmpwNeNH2P3fwc=;
        b=nKUAsWRsN9BGGrGwQrLB0kv0wlVSnoAnzswh13wj7EGIwqOrksI9z37KgLsux3h4UKLTs7
        hvX9pKjerg6TKVFVHViunM2h8wD/x9DKXOqail3+x67Q7k4uGBZs3/w/8LPnivDSw0C5Pg
        s2IRPy+eKSeHY/zI04QFv1iGxF8sFXxA/n+gd0EcjglOPkgZG4fxvX91Tj6hyAc2tm6AUg
        D9rhxRPO0sQ98TxDe82Pb2Vacph56ZjvfH8pv6FiZBJgxNmXe7a1YQ/mkONPF05wSrp5gm
        shOzrYQLLxFcfKezWHTk32pzKtEqZv3ZB5W1PcsLbcCNqSDmd0xcGaBsQsawvw==
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-WxNgkFgwN32dxXwxLM9O9g-1; Thu, 29 Sep 2022 02:10:12 -0400
X-MC-Unique: WxNgkFgwN32dxXwxLM9O9g-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM6PR19MB4279.namprd19.prod.outlook.com (2603:10b6:5:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 06:10:10 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c%7]) with mapi id 15.20.5676.015; Thu, 29 Sep 2022
 06:10:10 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        Yi xin Zhu <yzhu@maxlinear.com>
Subject: Re: [PATCH RESEND v2 4/5] clk: mxl: Add validation for register
 reads/writes
Thread-Topic: [PATCH RESEND v2 4/5] clk: mxl: Add validation for register
 reads/writes
Thread-Index: AQHYzkwHcZxL62Wq60mV6jLfqKCvSQ==
Date:   Thu, 29 Sep 2022 06:10:10 +0000
Message-ID: <MN2PR19MB36932AE7D8804943B14CE74BB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <3bcdfdf0f66dd2fdcffbdeabb5e3ab0bfb2e3489.1663827071.git.rtanwar@maxlinear.com>
 <20220929002032.7061EC433D7@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM6PR19MB4279:EE_
x-ms-office365-filtering-correlation-id: 8bb2ba66-49d9-414e-61f6-08daa1e143b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: EbSzpwxpxKimb8/KB9YCyPmghfrOCgsEFoA+thK4byG5jUAr8njREJphNhZX6UQJxg1qOPxIdAZ9gkOUvSLvmkP+F3p5Rl5jPM94oF1iDXJukNqVsqTWnaorQbkL8b0y1imdFL9k91cHQlGdPRSn/xGn7njFCXXirggBe1qNL4KpGHPElNy4hkPG2UPLUoj71fBwL2N7vtT7ygJiaYE5yQwxYjeNgcPe7yZhNRRzncJEmQBIcckAMU0KazQXh0SgkrUM3HJPS+6uhbuAslrf++SLCLArga7NSMpG3xgdEiU4Jf7t+MZDC8Ol94RBjhrEMZIawtUGGC8od2iutXVWuWGUURjWWCQ3761jD8XKe6Wu0nCoZDWB0r0Ser6Ah87JcP3HGbRVxeKj/b1OIM3bP/mFK9rFj2VS3alwEoj54Om02BgtHx/v2VEYaqZ2Dr+BuYz0Afpnjh1nenZ9+nCQ/OOZIUcup0Rol/cE3IB57sZn7RVRV3fPIvJiyGobWVotWCYYEgSsfWfykbNx236nzg6nVb3b5TfMzMadgR/T/SRATROZV1jDq+fOFSJ/iuocyvs8hQ2vhuMd7FH+GWph1+cDodVoVFqYzglaYFR4aLthr854antnhyHaID1toSpLZr4wlxxrnXHS6YEYAkKyrcrdLTwplA8ZIQA66wmQGPk+14YBrbZ0fpITGlObcEf/b53gBebudWsWfEjDqb3XKt1Dx3hZh2pZYjMY/PIlWoICiNIW774tL50hubD6Vvrmid9mjvkx1mRkBroBHKsxjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(376002)(136003)(346002)(366004)(451199015)(316002)(54906003)(110136005)(107886003)(86362001)(7696005)(8936002)(52536014)(41300700001)(33656002)(186003)(5660300002)(66946007)(66476007)(66556008)(64756008)(4326008)(91956017)(76116006)(8676002)(53546011)(66446008)(6506007)(2906002)(83380400001)(26005)(9686003)(55016003)(38070700005)(478600001)(71200400001)(122000001)(38100700002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8uvdGihD+sUvLZPFBbZGg2NtLJv9ZF6bP1dFszjOsR20KsJXaQuABx5YQjfA?=
 =?us-ascii?Q?yNnUynnhxwIdrxl2mohsJ633p6IYKiIpSBXWlQe8p0PNOPqzHGgHLyfFi87A?=
 =?us-ascii?Q?UDnPh96Wc2kWXmzqaTiAHGGKLcC6esUaRZU1TdX6zpU9bOSwMo4716e/ulkj?=
 =?us-ascii?Q?qBE2UwS5AwCMlBW/31N2vt6EsXbM4wQXlfIvQmOsT3w6b80wJrsSUjt/IAFr?=
 =?us-ascii?Q?TeHt2MhO752jO6pALPmrzNUxUtUiKkQeS78Eo2ET9Am7vOa/uOZ9rfhkkB0K?=
 =?us-ascii?Q?uZXWuDcygIYswdNNsDrWorYkD+fMtQjr+55JDJqfLAEhjVJ9VTYbHD9DewU5?=
 =?us-ascii?Q?ytLiDp7uY6AfG+z/YfUF6aaoKjrMR2K/pjcZnsZ2IBVGH0TkZU6aquNF2gDZ?=
 =?us-ascii?Q?nNWY3slKwHD+JUmrgfLO9rLEokBiEOQnqs0zShTmqRCmwOUvbL65VhytmCF7?=
 =?us-ascii?Q?XqE/xBGg3O6mp6asKfi3Ps0ZGqZLHRXjO7poPy1CWAe3vVcFzG3Qn/97B6Np?=
 =?us-ascii?Q?ae5l/DkMZkI3oVpmrTF7qrwk5eFInlntKCvh2E8pTJ2XtwuXu2m3BFVeVgvp?=
 =?us-ascii?Q?ey1Uugjtm1kLHpGiCVBHHZhAqx1gZKfM0mvR0tSKtT9pSvjWNRycienBjlfW?=
 =?us-ascii?Q?Ia5ltaJerhiAGNdCpLDZlQB7s1GL4YRzSnEatgOkdc3kPplZneMe5VZ31HKy?=
 =?us-ascii?Q?BleteQpfDkDFjtq5cprZ3yFytjB4JomJJdroPENAlry316fwdXgaVnHir9Z8?=
 =?us-ascii?Q?q30JUGF9jBuJehppBmbiZrJ4WpRUXfTWBgiJfZMLzMSVgWX78RGBpQLDIPt6?=
 =?us-ascii?Q?n/g+p0xpeuX7hvREbv7M+bAp0SQwVxfWKE8b9HbsQBdwW5mujZpvOWaTS165?=
 =?us-ascii?Q?Au4Yj4TKJlZ/Duwzh6RAisTrW70H+F4rx8liXujnzn4XvLvnIx2jK1qmz9RJ?=
 =?us-ascii?Q?YGOGGE9uicFcuA02bxUpoolRoCDaJtzs6DdUa2/pIDf1OechiO43QEdcPgUj?=
 =?us-ascii?Q?bYh7LxLgtfUIkN0DDaFPVL/cgi4u139B+IW3vLl7TaADrqsHU89c+ayjuJyy?=
 =?us-ascii?Q?8jVWZOlCCIwv3n6gRCdpmLbQ305D83KdMVI7R87UHfPS7aPKNj7OgZY8//+1?=
 =?us-ascii?Q?vDQ17p5FXO8zzNA52Gaq0CuW4XHtcKof4Dkc01ImWkjVJw37S3AqsTk4QMyH?=
 =?us-ascii?Q?SzIrt2qZSagQAv3x0PWq4gchdfYi9WUHBU8r538X93MPJDXS0S4mV5TsWjRe?=
 =?us-ascii?Q?P0vr2yFBDovc7q8qz5TX5SzOZddXCxWmDvzl18PskyQ1WB1BhfScHL5FxGKf?=
 =?us-ascii?Q?NVKbOFoMwnc25qA1+KgzV6LH7sE2BSH3068mCaq4mqhxO+uRURosMhjFqbC+?=
 =?us-ascii?Q?CJQB5eYBV5wUSUCG7VBk6HojyxUOwf8YCdffavunDfskqQBepOMOr4Qh+uyS?=
 =?us-ascii?Q?HFmt6X9leTQEdWwRnSFCUkKxvk7CYbB/e6hRFMgJKKTtynznex4tlu/3Jk9z?=
 =?us-ascii?Q?m3AfKkYZLUtFcaFedvX0+65AUDw33Y84yuua8g3JHsxeiyrKgl6gepPaER7G?=
 =?us-ascii?Q?H9jd8uhuqLpTlPUImrnH1zVC3qIB8/MD2nkEmERoREG4AuO3geT0nzouT3r3?=
 =?us-ascii?Q?oA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb2ba66-49d9-414e-61f6-08daa1e143b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 06:10:10.1667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MG2ZlNRjjR8I9hqk/WprdricDCh4cQwhiyEkcN3ZniMvEeuULRLrjRqGFk+qR7bHgElVl2KH7Rd96O7cF2WhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4279
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/9/2022 8:20 am, Stephen Boyd wrote:=0A> This email was sent from outs=
ide of MaxLinear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-21 23:24:=
27)=0A>> Some clocks support parent clock dividers but they do not=0A>> sup=
port clock gating (clk enable/disable). Such types of=0A>> clocks might cal=
l API's for get/set_reg_val routines with=0A>> width as 0 during clk_prepar=
e_enable() call. Handle such=0A>> cases by first validating width during cl=
k_prepare_enable()=0A>> while still supporting clk_set_rate() correctly.=0A=
>>=0A>> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>=0A>> ---=0A>>  =
 drivers/clk/x86/clk-cgu.h | 30 ++++++++++++++++++++++++++----=0A>>   1 fil=
e changed, 26 insertions(+), 4 deletions(-)=0A>>=0A>> diff --git a/drivers/=
clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h=0A>> index 73ce84345f81..46da=
f9ebd6c9 100644=0A>> --- a/drivers/clk/x86/clk-cgu.h=0A>> +++ b/drivers/clk=
/x86/clk-cgu.h=0A>> @@ -299,29 +299,51 @@ struct lgm_clk_branch {=0A>>   st=
atic inline void lgm_set_clk_val(struct regmap *membase, u32 reg,=0A>>     =
                                u8 shift, u8 width, u32 set_val)=0A>>   {=
=0A>> -       u32 mask =3D (GENMASK(width - 1, 0) << shift);=0A>> +       u=
32 mask;=0A>>=0A>> +       /*=0A>> +        * Some clocks support parent cl=
ock dividers but they do not=0A>> +        * support clock gating (clk enab=
le/disable). Such types of=0A>> +        * clocks might call this function =
with width as 0 during=0A>> +        * clk_prepare_enable() call. Handle su=
ch cases by not doing=0A>> +        * anything during clk_prepare_enable() =
but handle clk_set_rate()=0A>> +        * correctly=0A>> +        */=0A>> +=
       if (!width)=0A>> +               return;=0A>=20=0A> Why are the clk_=
ops assigned in a way that makes the code get here? Why=0A> can't we have d=
ifferent clk_ops, or not register the clks at all, when=0A> the hardware ca=
n't be written?=0A=0A=0AThe hardware can actually be written for such clks =
but only for=20=0Aclk_set_rate() op for setting the clk rate. Just that har=
dware does not=20=0Aprovide any way to enable/disable such clks.=0A=0AAlter=
native way to handle such clks could be that the clk consumer does=0Anot in=
voke clk_prepare_enable() before invoking clk_set_rate(). But we=0Awant to =
avoid making changes in the clk consumer code to keep it=20=0Astandard. And=
 handle it here by just validating the width parameter.=0A=0AThanks,=0ARahu=
l=0A=0A=0A>=20=0A>> +=0A>> +       mask =3D (GENMASK(width - 1, 0) << shift=
);=0A>>          regmap_update_bits(membase, reg, mask, set_val << shift);=
=0A>=20=0A>=20=0A=0A

