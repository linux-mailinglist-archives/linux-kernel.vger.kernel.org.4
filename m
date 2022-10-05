Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33275F52F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJEKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJEKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:52:47 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E25E54F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664967166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Jd9WMiebhTPsT7z/MbzF90uafBMHgpG6wGy64g9fuwc=;
        b=nCB0OAiayk5iFEsXGSJZzv0TadLvHJacF2Xs+OhdEuN7dsQqxEFpBvkO4bHXejT8sIaM/b
        TG8S9F6yFXfd7ALrltovwUPgQxw+cOt906hQTKF/go/APnmvgjhUMhsVAP4OkAUZCIfVzK
        Skan4KelO5ky6i+MweFA6NcOqax685OUtKsUbT6oIdrZlK3INnattlQtv2qJO8DpsYXfp7
        V3KEegHfznJHpmoLfhv89gAOqUtVVb5zpZZH1HZNpEuZ1CKxlYi/undIid1yV2BzGtqZn/
        hybs88J0qrJ21rtGmQL/4ra10vrBjFg9J+BPO48qwZND/h5hMaUQQIW5DKp8rw==
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-JSk0b7rwNn-Wdb9lkMyqrg-1; Wed, 05 Oct 2022 06:52:43 -0400
X-MC-Unique: JSk0b7rwNn-Wdb9lkMyqrg-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM6PR19MB4247.namprd19.prod.outlook.com (2603:10b6:5:2b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 10:52:41 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c%6]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 10:52:41 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        Yi xin Zhu <yzhu@maxlinear.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 4/5] clk: mxl: Add validation for register
 reads/writes
Thread-Topic: [PATCH RESEND v2 4/5] clk: mxl: Add validation for register
 reads/writes
Thread-Index: AQHYzkwHcZxL62Wq60mV6jLfqKCvSQ==
Date:   Wed, 5 Oct 2022 10:52:41 +0000
Message-ID: <MN2PR19MB369322D272DF711D2185BBF0B15D9@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <3bcdfdf0f66dd2fdcffbdeabb5e3ab0bfb2e3489.1663827071.git.rtanwar@maxlinear.com>
 <20220929002032.7061EC433D7@smtp.kernel.org>
 <MN2PR19MB36932AE7D8804943B14CE74BB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
 <20220930010212.7860DC433C1@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM6PR19MB4247:EE_
x-ms-office365-filtering-correlation-id: 6656aa93-8b20-47fa-2211-08daa6bfba09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: WwGhF6Y5C2rvPUZ2kr0hZ7g/lRa1k7C24/7dfFT1uc9V7AvatzmVfu/lWJpKJyCn+39JxBWrzfsZeCPIdqN3SR4ssvVOnp0gmQxVW7Tk1GllSXEhAjxHEduFmR3Qt876HMNzfSTsb7QXZMLAvWCadgBGyFKtHV1EpnK28h8q2LVjnt/dZbgkq7zXaCj75p58gJCIDGGKcVLeZ0rmQiYBUdMOjjllH8NNjqkgegES31uamMY7ynzYmeWiMqvkvM0n33H8vx2Lfux/PoogwHbHeH3BjYZMi5lrFiWCYZDINEbB2ppBuXZkm39lK0IIpo5J0q4FLtn4+OZSnt+rOy7bEEs3nkqgK5V+Pe35H2asP4qd3FL+EZ62VGr6mZJW6abn2y/N4pRA1rsnDnD4bO/TlkBFkbgNejvHvHl/zeMdj5y5fnpH/FsnFWV00DS3LGs58o/wv6+00sppoTvY7wamhSStPHQfux5wikICSs4naZER8jq3yR4UKWIrtY0cT9SGdZJPdsIuh9Yq1rZCbatg8QYBkKBlCM2WXmMT0PUwcsKFJQ6SFOJsAjoeGiHgleLdfRAkGrS0a6dM9zXGxLzOkVK/B8WWaH6J+oarhw4PMA1piu2sMdbR2MLboHGrZIdTYBYJINMv73eF0ke/wDTd891QzwR3093DfwsH4Z8Re9Rzanu+UIumlFXADaNBB9YcblZdmm4zC6oGiPCJdIRYiXbHfg5WvH1qCmLfZs7mHBQrTHctX/LXmezWOA25pR0pdGYwjvyKYbifwxifQKKSiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39850400004)(136003)(376002)(451199015)(83380400001)(186003)(5660300002)(316002)(52536014)(9686003)(26005)(8936002)(54906003)(110136005)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6506007)(7696005)(53546011)(4326008)(8676002)(2906002)(122000001)(38100700002)(41300700001)(478600001)(71200400001)(86362001)(38070700005)(55016003)(33656002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKV47RviAaxW5S2/vk2O0TDon8n7A3Dj8UKIYHzGGKHFToiQnQvy/cyN3Wek?=
 =?us-ascii?Q?87SlIOYErQnHC0VkNrZP6CXyjqsKhamrP0lsdG9rnaV8aKYKWdahOTK6UbIC?=
 =?us-ascii?Q?MzoIT4MvyUP9fGD/yTyeZ7hFvGNwnldhxrn734dfMTo8x9SoKopkApY0/Gap?=
 =?us-ascii?Q?2kWAs0pLw7F69nQj3tvwWalQFJD3Fx+7rOWN7nsSljBOAC49Y5fq1E4K4kTC?=
 =?us-ascii?Q?CgrIWRk82M54Z5IR0kECH4UipdU83ufAIBhqtHwPCoxE6n89VYaEB13ig2qN?=
 =?us-ascii?Q?5G4p/q0gxtsijq4Na8+vxa7JKs4M/Qx3OeaeGWH6pHt/bq0AHhagGda3jn4R?=
 =?us-ascii?Q?0CAPqQ4uNwH7mEGlH/oSrjxHwtqPXaObF1HyDzSiaHl9r1wmGDcRDceEc11g?=
 =?us-ascii?Q?YOCmuo+58Eo3SPGzmS2HjmdOKVpNJj8Vl0wvHaIqwiQ3pWTqvGeWUjjFIXoI?=
 =?us-ascii?Q?eYJLUBnsnnGnSetZxZutE60hKFDxqBCxaHW9sNFA7cCbN9QsbPNumF8He7O0?=
 =?us-ascii?Q?4u5oj+vqC424Uoui0/Mn4m+iJ7WZ7rcIVzfLVYigtKafJeP0FuwrpWp2yfiY?=
 =?us-ascii?Q?OcsecFyfQCMrR5EKZghnNagxZxAH+s8qdD7YBi3Tm4j/Y1dt6Dyc1wBse82D?=
 =?us-ascii?Q?74iwf7vQswlBfOw1XEBxjkdJ9oyDZ5QHHjACkboANgaKCS0I1i/txrsm6NuT?=
 =?us-ascii?Q?rKhe0WfUnEpr656xQxsMxMSDBebG7oE8IfMIcmk6rAGcC/XMv6i/VSQJIPrD?=
 =?us-ascii?Q?nMMUSfRxEcoJR8+HpeabwjGsK8sLovOSBE13DdXtJ3YMTECKPLSFCvuETsi2?=
 =?us-ascii?Q?G1rruOJqzNl3wRfAC0GFsG0U2O6ufN+6ZtXTZFMFjc/tOMFDKknr/hlp0/i1?=
 =?us-ascii?Q?Pe3dYBjBlD0gna+XfO5y0auoVVWYUbfHk94HerdNYmEZf/O/Rdh7Isa/ROnc?=
 =?us-ascii?Q?qPhsQGGk7+wRh5ouNb0Uu1fuxJxH72i1yMKGprYgZRH2G3x6GX4di/QTeXJj?=
 =?us-ascii?Q?5hbFBzxYSeo2fLd6OnhKE73U4smdUHH1PkIYMJFQU0anFD2HvmesuzWe8S/k?=
 =?us-ascii?Q?sbez8xY3lB2+YQxNae8yjcGuJDC6sGqWrGmO4NFcCjvCfYulGJdpnGIFry01?=
 =?us-ascii?Q?GFACG8mOdCb6ruTK+y7TtKLxVWmmQsIJQ+LBrzYpWnV5Z2i+akDEAkLutRRK?=
 =?us-ascii?Q?ghnIHythdIiEUK+ORLuFo9mwV6IS1gxvrRsqUhRuC1XLfNS4y5w+Y9dcsM0A?=
 =?us-ascii?Q?e5pXN2YtX6BbLOBvH1UIf6g6b4s3MYSBbk9PBSoJCyJH9JJh07A6tAuU03tM?=
 =?us-ascii?Q?ulUHV+mV0ZddDgwdWC94OUU97vcvJGrJFP3CxewYUFhWnyePzMWHIZcAv6zZ?=
 =?us-ascii?Q?aWEF8V0gQEDUThkgjXykqg9bQaQU5I9OsUUCm4f1FoRNU+2gv6TPNq45AMUh?=
 =?us-ascii?Q?EbaE/Q8oU6ZuwKbUzvugp67uHD6lyiFfJgECXR1KUadBQDdyS7Je/UfGuZtI?=
 =?us-ascii?Q?Q+3HIHHunMxK6ModHRAVC9Qal8pOGNElTzZkmPTI5FHEP4g325G3A3F2ttcq?=
 =?us-ascii?Q?Pfb0jSVFrK1t8uK71g2rVQD3mwf8hFno+1cILsvgAK1fngLuiY3OEgshDOd4?=
 =?us-ascii?Q?Tg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6656aa93-8b20-47fa-2211-08daa6bfba09
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 10:52:41.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vtxLQYr5J/Ki5EaiKVdRW1X7TsD+xuWo4ix2NtMJVnDes5PA/Ms++u0kR4AGz+t43u/PZGnV1HZAo2rAYOUEA==
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
2 9:02 am, Stephen Boyd wrote:=0A> This email was sent from outside of MaxL=
inear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-28 23:10:10)=0A>> On=
 29/9/2022 8:20 am, Stephen Boyd wrote:=0A>>>> +       u32 mask;=0A>>>>=0A>=
>>> +       /*=0A>>>> +        * Some clocks support parent clock dividers =
but they do not=0A>>>> +        * support clock gating (clk enable/disable)=
. Such types of=0A>>>> +        * clocks might call this function with widt=
h as 0 during=0A>>>> +        * clk_prepare_enable() call. Handle such case=
s by not doing=0A>>>> +        * anything during clk_prepare_enable() but h=
andle clk_set_rate()=0A>>>> +        * correctly=0A>>>> +        */=0A>>>> =
+       if (!width)=0A>>>> +               return;=0A>>>=0A>>> Why are the =
clk_ops assigned in a way that makes the code get here? Why=0A>>> can't we =
have different clk_ops, or not register the clks at all, when=0A>>> the har=
dware can't be written?=0A>>=0A>>=0A>> The hardware can actually be written=
 for such clks but only for=0A>> clk_set_rate() op for setting the clk rate=
. Just that hardware does not=0A>> provide any way to enable/disable such c=
lks.=0A>>=0A>> Alternative way to handle such clks could be that the clk co=
nsumer does=0A>> not invoke clk_prepare_enable() before invoking clk_set_ra=
te(). But we=0A>> want to avoid making changes in the clk consumer code to =
keep it=0A>> standard. And handle it here by just validating the width para=
meter.=0A>=20=0A> Why not have different clk_ops then that doesn't do anyth=
ing for=0A> enable/disable and only does it for set_rate?=0A>=20=0A=0A=0ATh=
ere is only one clk entry which falls in this category. Adding a=0Adifferen=
t clk_ops for just one clk would need many more lines of code=0Aaddition wh=
ich appears to be a overkill.=0A=0AI have removed this change in v3 and use=
d the driver internal flag to=0Ahandle this particular clk. That requires m=
inimal change and looks=0Alogical addition.=0A=0AThanks,=0ARahul=0A=0A=0A>=
=20=0A=0A

