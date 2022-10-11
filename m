Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F435FAD92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJKHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJKHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:34:03 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E576E89AF8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1665473639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=z/mwqS1MoxoBP3x8iPrtpxDYB/qR+eamgCZm0YWR5FE=;
        b=dcsL0mon03YgJkmTZs/+xyH4Y95brBLYSViGZbn1GF+nlk6jfe1bdq0la7sOR08rCqTDjE
        raD4YNU55WKaxfpPbCBZuRVTfKLS30xXzeqzsjxgdGMv0KacDqYbLrBGvr96UpSod5Lc5P
        8Qcrmg4/gisrsaTzRs440LoOwby0YmKWdvuayD57YnriJvCZiOTpEHirJ3nd7opv8moHSC
        IztFL0pKJuvzGwcO+KkmZDMH8D6cwE/1GUgRAVBzez38cUZDeyiEFBcR2AH3/m7gnCFi8Y
        wLIAiKWb+ASW+4DkBpvoaEF37Qfj/ftb2ztfz4cIa/036+hWBCJFRrfWR1JQFA==
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-bd3nhTolOdCmM8T0XJ2KYg-2; Tue, 11 Oct 2022 03:33:58 -0400
X-MC-Unique: bd3nhTolOdCmM8T0XJ2KYg-2
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM4PR19MB6176.namprd19.prod.outlook.com (2603:10b6:8:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40; Tue, 11 Oct
 2022 07:33:57 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 07:33:57 +0000
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
Date:   Tue, 11 Oct 2022 07:33:56 +0000
Message-ID: <MN2PR19MB369398DE5E919BBFB38D7EAEB1239@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <5a88bd5a9e93cc6e794080e5cac821ae0c27ec56.1663827071.git.rtanwar@maxlinear.com>
 <20220929001745.A4F9FC433B5@smtp.kernel.org>
 <MN2PR19MB3693EEC08EAC5370F1D195FBB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
 <20220930010123.38984C4347C@smtp.kernel.org>
 <MN2PR19MB369301BFE8DFB56C348CD6C0B15D9@MN2PR19MB3693.namprd19.prod.outlook.com>
 <20221005202037.E7B43C433C1@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM4PR19MB6176:EE_
x-ms-office365-filtering-correlation-id: 8fcda426-b700-4ae3-fd8e-08daab5af4dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ULGFG7xjkib1EvXm7H9OFr5ngIke8r4chkk6S6zdF7bdaad4nfcwLkpk5FZw+yZituI9kthtCBIOpeo81hXwALUwn0j+3Culg/iL9Vt7DyL3UCDlaCCJ3gR6XA8mq/Td29P+IebR7naS8s+eprY4AWFRQEburdMSsW8zwmMOp/nuQ1ybCwXir1IRl6C49FsWqkLcuAcy93OtylOMUENHBWFhISFToE1GBkPJb7L7g1u8cOkG8cLS3+W5tah/5Rh0DBwudjL087/BivhERf+H7lno8Jw5JHGFga0RaYB2QVBOBdLl3otGiZoDUIJ2CIHOKFj/RMRW3Hvy2dX70dokiSCgg51ElRTWRuJEhqeiqyZdXLUSbGW4HBmnlFPkZWQU3oZCVsAuqkAqovA5CRmhqn/67GHDlWeNOT515l5smBtSJydXuQFYbSbdXK4Qi+GizuykCAa4xN9AUl7ihQjIXomMb7QWGfEtZYhk/es80Gr71iOePMQ39UcgqDChruGS1Dcb2I5qVVHy2qt0wVek61ondwMjvof/gTJDr8G4KcqDL/l6aRDwqylgCGhrI2W2bRaRHejwcluE/3bLGLcyVU+9v+1bAqKjIcfaWzBJNgQT6/HgG3P8bAdpPxs1pzaMRNOUpzp2ZXhGL1ibS6eRnXEsMHjKXTx6pSEr/bUp2tiSegD7fAqNQLZxDKQYHAqjcLNQxrzO6+8sphTPOPD08jzIOfkIbIZYtvYSnF3gRAOuiNvehooLVMum0sqcKOBapMKLdly2KHoXVHaaEE74Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(451199015)(66946007)(66476007)(9686003)(66556008)(7696005)(54906003)(55016003)(110136005)(64756008)(8676002)(2906002)(478600001)(52536014)(8936002)(38100700002)(4326008)(5660300002)(66446008)(71200400001)(53546011)(6506007)(33656002)(26005)(122000001)(86362001)(41300700001)(38070700005)(83380400001)(91956017)(66899015)(316002)(186003)(76116006);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mxiZqd7sLe5Uvk4JRSv4lnlGp/EJUWpp5nXONLwohUTGz6t5sQF1LWYKfhUO?=
 =?us-ascii?Q?bFgqY+tG8nHa3yTFHqXqm3cEWbZ+hUSA+Ze6avuzgTEEW2iEGvSM2jLDmhVI?=
 =?us-ascii?Q?d+qo2zg+wqfOiZpQsZ3cfbIMn+zE/UQWm0wfFb3PpwTZt+uvwokH5bEoTVbg?=
 =?us-ascii?Q?8ZUhavvTJQO/9wcLcygg5ae9cTsIaFDaLX2kKrWPob8Zvp608TrTfqr8WPiv?=
 =?us-ascii?Q?RQYoz95Px4Pif4JMPUTgTlTematZOliq2Aph4nyoKZ4qQUWo5MWOMMBGA91h?=
 =?us-ascii?Q?ik/+MBusQh9XXwsM+6Hkc94RBS1B2t3QL0hncWhOONp4RI/43cNdTYUBc0Rz?=
 =?us-ascii?Q?qJJ1lpfExBqycofoG0FWlAUD9nqpL/5toc/G/LVd+SEmcPgtKAMxvsbLap6f?=
 =?us-ascii?Q?MXxNYYV62bOZFKB3ZRzOFcV/GbPF+d8PUUO366eJjtHhxhPXYlwBi6+4NgBD?=
 =?us-ascii?Q?dMjYoHDi9etQ40nH0FmM8yq5I1jb2L85szZ8Gia9xm1NQ7reivxZ93/k8OS/?=
 =?us-ascii?Q?4u0a7fGb89Chn3zC6DdZ6gwvd8UBKReHiWwOakJWJ6sZRWF1ew+3UEZd/VLt?=
 =?us-ascii?Q?hA3+OxR8caSbc3u9LHIDX7P0P8muIRHzDrXUl6dzXXbC+T/lv+pHkPIV42+L?=
 =?us-ascii?Q?uAxZ+Au3ZFAHz3oecQTTGDrU5VM6sXzRB9VlnIriF0K+CCU1exPRdm9hEsKl?=
 =?us-ascii?Q?C8rtz+Qvgeqcg3YknHVV9vBSpifaWijri19uLgOiXsHdcDopFRL0lZnl/k2E?=
 =?us-ascii?Q?ob2DZ0t41/mGYhk+GkDhrf0Wpk4o0GAIeLvSN5OVktzfOlAFOQOqv03DxLxV?=
 =?us-ascii?Q?xZIlyo0/vQMU/CJEKwxR80f6Q2CT6Q1bna5tOGuZKScRUG9Rh3ht6GI0eEfY?=
 =?us-ascii?Q?IDkWZQUh5mP8aygqtnwo5TqE8IkBfoXpO0wkMS9jAHmqY5RFHAg4AwDoPJUt?=
 =?us-ascii?Q?nA+qGo9DAogNucyvOoDlmPtq8erlWS2o54CcdnLHuFxEwm9Xo5cN4V7efoA1?=
 =?us-ascii?Q?AsKJWf5YBwOACtDNPWT/zFvszO8u3EJbsHZPOQ1vH2vn66peRu0kHdvHY3HP?=
 =?us-ascii?Q?YD0Sby4oZsJk4CvhY/Q9albcqQHnS7F1zzgTSc6kD2rgyIsYiwzFVbdNkakB?=
 =?us-ascii?Q?wjNhpIcGhyzbTSu59IZPXoZHvFAfpSQCOXvSUdCk+Ebq+t/s5oSixxqiegLq?=
 =?us-ascii?Q?fMe4n23fIfiIQhTX5VzAvvrQHdMFmvumqmcJ0qSHVbxxbT8e3nB4uNSPUbRS?=
 =?us-ascii?Q?46CG5xWwUqSM6NL4gaGScqidXlQHQGMx2YfZ87E1mwpopC2bPjl3Flr3nOyg?=
 =?us-ascii?Q?Kxk30RYSjFhdpK8QW+rwP3I36j2HIKF8PBa68M4KVdTDwvOTAJLyx8zreTvC?=
 =?us-ascii?Q?5TXB5whemfPth6Cx4cn5NJJ01jhx8ATp84Ha1KiUZ4qw6Ox2X0vormaiBnxH?=
 =?us-ascii?Q?NlM6FqisOGltHP0hIe4w/FoGsckD6NUrGy7HhzDwvX8I9JeSAONWCqH4wZe2?=
 =?us-ascii?Q?1kJezMwKGon4SXHBd6hioy24MSIzUieC/xX71P8Ex3ZlnFjDMiHMe4GPpe37?=
 =?us-ascii?Q?trTxn7YHR9aWxBIwCwl92SCQUGoLBjmbgxhR2d6jpBueShtl87H3FkQDTRq2?=
 =?us-ascii?Q?0Q=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcda426-b700-4ae3-fd8e-08daab5af4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 07:33:56.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0i93SnVyYzG0nFcJxddPCaw8iMiJ5KrIgCSeRUShHjjxbGrMVUS5SNxeO0EIeFJ3pE2pwz+CCnfTBq7BjiBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6176
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

Hi Stephen,=0A=0AOn 6/10/2022 4:20 am, Stephen Boyd wrote:=0A> This email w=
as sent from outside of MaxLinear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (=
2022-10-05 02:36:00)=0A>>>>=0A>>>=0A>>> Why is the clk driver probing on th=
e new SoCs? Is it providing=0A>>> something? Can we detect that the power m=
anagement IP exists and not=0A>>> register these clks?=0A>>>=0A>>=0A>> We d=
iscussed in the team about not registering gate clks at all as you=0A>> men=
tioned. But if we do that, all peripheral drivers that use these clks=0A>> =
would need modifications so their probe does not fail due to failure=0A>> r=
eturns of clk related standard calls for e.g devm_clk_get(),=0A>> clk_prepa=
re_enable(). These are standard calls in probe for all the=0A>> drivers and=
 a lot of them use gate clks. So this would need a lot of=0A>> changes with=
 possibility of breaking working functionalities.=0A>=20=0A> Why? We can ha=
ve clk_get() return NULL when these clks can't be used.=0A> This is how we =
implement "dummy" clks on systems where the clk provider=0A> can provide th=
e clk but there's nothing to do for the clk operations.=0A> The clk API tre=
ats NULL as a valid clk but bails out early when calling=0A> any consumer A=
PIs.=0A>=20=0A=0A=0AI agree that what you are suggesting is the ideal way t=
o handle such=0Aclks. If i understand you correctly, you are suggesting bel=
ow (please=0Acorrect me if i am mistaken):=0A=0A1. Disable/remove such cloc=
ks from corresponding driver's devicetree=0Anodes. This will make devm_clk_=
get() or clk_get() return failure.=0A=0A2. Modify all drivers which use suc=
h clks=0A=0Afrom:=0A=0A     clk =3D devm_clk_get(...);=0A     if (IS_ERR(cl=
k))=0A         return -ERROR;=0A     clk_prepare_enable(clk);=0A     clk_ge=
t/set_rate();=0A     ...=0A=0Ato:=0A     clk =3D devm_clk_get(...);=0A     =
if (!(IS_ERR(clk)) {=0A         clk_prepare_enable(clk);=0A         clk_get=
/set_rate();=0A         ...=0A     } else {=0A        // print error info -=
 do nothing, no clk_ops calls=0A     }=0A=0ABut the problem that we have is=
 that 80% of the clks that we use fall=0Aunder this category (around 65 clk=
s). And if we follow this approach,=0Athen we will have to make above chang=
es in all of the drivers which use=0Athese clks & retest them again. That s=
eems like a overhaul. We already=0Akeep a internal driver flag in each clk =
entry data structure and we=0Aalready use it in the driver for other types =
of clks for e.g MUX_CLKs.=0ASo using the internal flag to handle this becom=
es a preferable &=0Aexisting driver design aligned approach for us.=0A=0ATh=
anks,=0ARahul=0A=0A=0A>>=0A>> Also, i incorrectly mentioned about the reaso=
n being backward=0A>> compatibility with older SoCs. Main reason is to supp=
ort different power=0A>> profiles use cases as per end product requirements=
 some of which might=0A>> control it from clk framework i.e. this driver. W=
e keep a internal=0A>> driver flag just for this purpose to provide this fl=
exibility depending=0A>> on the use case which is what we have used here.=
=0A>>=0A>> I am sending v3 with more clear & correct description about it t=
o=0A>> justify the need for these changes.=0A>>=0A>=20=0A> Ok=0A>=20=0A>=20=
=0A=0A

