Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7393966DA63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjAQJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjAQJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:58:16 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC62BEE7;
        Tue, 17 Jan 2023 01:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9cimNKG3ygfrDJq+Us3GKMi2k7bUbrLkjViRGoR1iREi229hJMZYu1g3Dc7iKTGyksZ67UfHd/WFs5rYGznjDGdffZhJqWck0+gqtYlTeJblMBXK5StTixfMjNRcWZd8FJ7h7tLOlW+q7Qou8jY+7UDDuAUa6uBFzwNHzWZ+NCX+Fy65SvFBnQvOk8aSTbYujmo53eAzhuTEuytxczAbeQQKDAN128n8KA3cpHNJum5PM+RCmgzMCIdFa2zLeAhJ8X8jh//QcKdDglw8oKfFWgPUG6OXg6SoIMkYdy5+rJtCC5jGzbKtrZFHfX8zXiQvo/xAzr6IuWk9r+vz+P+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f738JAM65kuFxF5WueJ4LwGIBqreAiAU9cnvNibPZqE=;
 b=L0Upo1tQLp1JXY78C26Jtub0f//dc1m1JAzBPr0D6cNuQadR8zhJWoRsG0P8qyOjZ5FkK3a73w5AgBdNIChP+kce155Wcg8xoE5TmEr/TQ9BKHpKhgTYoQPyNB8DoWiz5NG26YC5dm9UjNYqmE1ouLkJqfGvKSOcIOeHGhpzupJb4YHfhLyAgDleo7UIY6oy/WCmV9eBDKWGalolr/6nse29vAD/HIdyzgDMyNFQObA/ZUrzG1BIeIb/XHRXGVA3gyAi/nk+3CUbhl8q20D5QB1+F2t2JgPedAYXt/7v5LjB3AXG8GJF6TPfBxFaEnqJhzDarnKXfnmlUbrRGU6grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f738JAM65kuFxF5WueJ4LwGIBqreAiAU9cnvNibPZqE=;
 b=XSFvJ9Fzl+O2dvL3Th3kIjR99dPo5cEaUl/+qBYOKd24EjHaZhrKe5Lb8wjwVRvkkSqi3Pqbg/T5B8pC5CO75z+D+9vsKNKFfmWksxceC9IqIwXdG5ee5lTjVlLPFd8U+QExD9PfuDL40kmBxEcOCU/CjtCmpXy4FY9eChuL3bs=
Received: from DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) by
 PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 09:58:11 +0000
Received: from DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::bf0c:610c:35e0:8329]) by DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::bf0c:610c:35e0:8329%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 09:58:10 +0000
From:   "Sayyed, Mubin" <mubin.sayyed@amd.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Thread-Topic: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Thread-Index: AQHZJlXED3cYNVvf4EaskBfinQgz8q6bTAwAgAWLdKA=
Date:   Tue, 17 Jan 2023 09:58:10 +0000
Message-ID: <DM4PR12MB5938E26F6A7DFC9A1875233D9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-4-mubin.sayyed@amd.com>
 <20230112212514.aez6oj4zfcivknk5@pengutronix.de>
In-Reply-To: <20230112212514.aez6oj4zfcivknk5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5938:EE_|PH7PR12MB5654:EE_
x-ms-office365-filtering-correlation-id: 170fad3b-adf0-48ea-3b32-08daf8715765
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+Pb2Sl6rjy+Sijzz2BRBwbWyvu5bLuz9aD2QnxYVqSzq1UEmrqmVY1xWa/jJmENDiyVdPXBaWnr7ex1reuvT/1w2/S3wQ0QgQNnz+51AR+t/t9m+VZ5PRzWoUzm+vLOp//hG4cBimrUbdf35T5wbfgsP1II+K+DzzTMy2I28SWA90dWDnaW+0n0m6CehLboABSn6DmlJP3RcZFhZS8TQKzvWNd9yfwwyjs3WsFqeV6SDVK0rOhO/ze0Zl4ZjxJHJa6p7ojWN/gl4tHg/VvpLLnTJK7FaGZo6UfFCpLOpe9bS2rWHFWfO1rb0KtznHhkMpEoFi8o0bz2LPtFB5q5K3AWZ2BVmMVZmJKR84otcgvQOcWlJJBuLwBIA1wN44fenNFtfa8FLGSfGp6CxB/iHFsU556Ir0p9AENyXHnN2ZSviDbv1qu2d4njYJbXcRIgu1vqhc7joK/J1ixjmvxk/EIFevWvnYAYGegecDrl2I/6J3seQcrmBM+sPlBQIHEe7HwhszdXFKmo3Jv6290vDGpDZC4YzuUaKRlYM+IGGftZJ6VlLlbKKgT5YoG+YTV07A2oy9KLOd61O7w03qo0Ol1FcKH8ikoKkkZ76fn1qe0/fvshUbqJqHfwx0dge/tqjd9ImsalHxEyqt8CQJ8z3cbRiIJHWUoGrMBv94IU83ZLKC+mzw8loar1RO8EoFPdq9Gc7ibYMz7fn+cjUBADYtHAMQfYwUW/ncnW7tnOx+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5938.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(33656002)(41300700001)(38070700005)(7416002)(52536014)(122000001)(86362001)(38100700002)(5660300002)(8936002)(30864003)(2906002)(66574015)(83380400001)(55016003)(54906003)(316002)(478600001)(6916009)(53546011)(8676002)(6506007)(66476007)(76116006)(7696005)(66946007)(4326008)(966005)(66556008)(66446008)(71200400001)(9686003)(26005)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xN9bR16cTF7ahyDwBj/Uz0Wi6JB8UCcG4dhk0ti36edruFvPRLdiL6bknQ?=
 =?iso-8859-1?Q?y3O/ot75hwsG1DPQ6YLnWpq6nuoe/FTTUV8RCX7tmpkHoRj0uQFok9pBGU?=
 =?iso-8859-1?Q?4rvgxcmKjQboB3VJ8eW4oVbrfUYF3P22FlseDnV+rdP4+tvWJdvE8ANWTQ?=
 =?iso-8859-1?Q?LMhGRFShJnuonq4hVPbBsEAN9lnSzDdpdUkcuIjaQ83Gi5r/cVSlaWq5/N?=
 =?iso-8859-1?Q?JbfoLhAt759cGjr6UlLsGNcObdFvFGL/8zika6PyhttC8sjA3cHjshjsUd?=
 =?iso-8859-1?Q?9aHHOHtpMy1OYfe/3O41RgMhbB/utA2ix/SGmR5rnmwPFdngCHQZ5/1Fss?=
 =?iso-8859-1?Q?E11NJl+oVDhcasbTOejZXfRcE/s54ZuAPsGy/rnGOfkXdREb895+tOeWY4?=
 =?iso-8859-1?Q?BTdWu4Z5FmxHJCoM85hHGaVIAtBGw1dGICeLBsNdfUY7SLASyIT1whnueK?=
 =?iso-8859-1?Q?mUDM/Vmuxv1JBOpSMjQhEdWM4S7GnuCfJJEr3zfX3MWxnTLMJbB45tjdhQ?=
 =?iso-8859-1?Q?7RDS2zM9vsacnzu+ISj5FzRFHAxJdw97y+Vz1IzyCv1zHX+s7AeLX0ce8f?=
 =?iso-8859-1?Q?QHKiS5/wEFpIbaJlB9G3LHHvDc4MK+SMqYkDrAffTSFcMAIZ6kIW6qme2W?=
 =?iso-8859-1?Q?87KQnPgn2+rvtfsl+nlt0x5P7BJbDNB1OJO3P7KzRi2qo7hm54FZiqXPAe?=
 =?iso-8859-1?Q?sGZbEpB9Egw/9mm8KK8tw6cXWDXOnsB4o4/zoT6XLcbQR8pM6Se6UCPQMN?=
 =?iso-8859-1?Q?5THApcpGWG3ujLbbXeddUcnXeKaGltDlFkkxqaBm6Sj4hV9y6LaNQzlql6?=
 =?iso-8859-1?Q?2NNEev5QdKRf/UVqZbZ96grlUO0jg2PrLGBikQSxvNoOHMUg3ptJRvatvD?=
 =?iso-8859-1?Q?42v0zQ5JhMpjEa93IP4mCYwPpbTngUikp+B5mRFVquLPVGIgBYX75s8lyQ?=
 =?iso-8859-1?Q?fsnlsDQtPdHof1kKLWPEORdJSK7MzMF0vTq3wC4i0g7JcMIS7nEgCkHdYR?=
 =?iso-8859-1?Q?otyjZPvI2ejwaoQp3AGnLR8jS1buUexfjatttWwkxMJm+SRIXisxcphjQn?=
 =?iso-8859-1?Q?lyeyPhQHo5NebBTcro0i8MZPsWgjxB8BAN7V12XnUUDRqR49abSAg8ibqI?=
 =?iso-8859-1?Q?LWUrkAta0PlG380oHIpYgtLn3Wgkc/wxPOJwxng4YFBHO4qcikoKyJ8EQv?=
 =?iso-8859-1?Q?E6T1Eum3XXPyNtHZ8nz+MMhhLnOxzAVl72/5DMPkLHdOrxNR2WtX5SgnH5?=
 =?iso-8859-1?Q?wKsUGZtYifMx1DnYVrwWdSQFs9AsxN/hJDuq6DFP6wXZmrSupSuIewYNK2?=
 =?iso-8859-1?Q?Pr/+vok1Fy1EVKu2EU1PdZdzkWmCK1Mdr+ER5ZYZSE+g4SAL7U9PPne7vK?=
 =?iso-8859-1?Q?Y/IBZpvi1lRDWEzz95A7ERTaxf8Tb1Yh8ObMyXnSEuvpXQSXVgAILT53Y6?=
 =?iso-8859-1?Q?Do3rHLS2MsmkUKkA1V6QEQH1RRAk2hDLnzrnjJSGoKwP1n3Jm5qSV13TvI?=
 =?iso-8859-1?Q?ZU0eqJUyEjDvYxsWwo4s9RCxndA/O0r2QvGByqVMSFReSSkaTpBykg3W7X?=
 =?iso-8859-1?Q?xD1NsoYksEcQnW5w80cnuROLdcLiNUsTvV71+lVV8laoDDgZle7V2rk2LO?=
 =?iso-8859-1?Q?WYA9lY/Bl80vE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170fad3b-adf0-48ea-3b32-08daf8715765
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 09:58:10.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8VhJkigY/e/lyyDm+WFQaeE3vymHEzh3vZQ4xMHSYHtG0XBmXP7n8ylPIojxA8ShzqL9hWa6z8ZVJ3gq3s0NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, January 13, 2023 2:55 AM
> To: Sayyed, Mubin <mubin.sayyed@amd.com>
> Cc: robh+dt@kernel.org; treding@nvidia.com; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Paladugu, Siva Durga Prasad
> <siva.durga.prasad.paladugu@amd.com>; mubin10@gmail.com
> Subject: Re: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC
> PWM
>=20
> Hello,
>=20
> On Thu, Jan 12, 2023 at 12:45:26PM +0530, Mubin Sayyed wrote:
> > Cadence TTC timer can be configured as clocksource/clockevent or PWM
> > device. Specific TTC device would be configured as PWM device, if
> > pwm-cells property is present in the device tree node.
> >
> > In case of Zynq, ZynqMP and Versal SoC's, each TTC device has 3
> > timers/counters, so maximum 3 PWM channels can be configured for each
> > TTC IP instance. Also, output of 0th PWM channel of each TTC device
> > can be routed to MIO or EMIO, and output of 2nd and 3rd PWM channel
> > can be routed only to EMIO.
> >
> > Period for given PWM channel is configured through interval timer and
> > duty cycle through match counter.
> >
> > Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> > ---
> >  drivers/pwm/Kconfig       |  11 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-cadence.c | 363
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 375 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-cadence.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > dae023d783a2..9e0f1fae4711 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -504,6 +504,17 @@ config PWM_SIFIVE
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-sifive.
> >
> > +config PWM_CADENCE
>=20
> Please keep both Kconfig and Makefile sorted alphabetically.
[Mubin]: OK
>=20
> > +	tristate "Cadence PWM support"
> > +	depends on OF
> > +	depends on COMMON_CLK
> > +	help
> > +	  Generic PWM framework driver for cadence TTC IP found on
> > +	  Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
> > +	  channels. Output of 0th PWM channel of each TTC device can
> > +	  be routed to MIO or EMIO, and output of 1st and 2nd PWM
> > +	  channels can be routed only to EMIO.
> > +
> >  config PWM_SL28CPLD
> >  	tristate "Kontron sl28cpld PWM support"
> >  	depends on MFD_SL28CPLD || COMPILE_TEST [...] diff --git
> > a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c new file
> mode
> > 100644 index 000000000000..de981df3ec5a
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cadence.c
> > @@ -0,0 +1,363 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver to configure cadence TTC timer as PWM
> > + * generator
> > + *
> > + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> > + */
>=20
> Is there a public manual for the hardware? If yes, please mention a link =
here.
[Mubin]: I did not find any public manual from cadence. However, details ca=
n be found in Zynq-7000/ Zynq UltraScale/Versal ACAP TRM available publicly=
.
>=20
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
>=20
> clk-provider looks wronge here, your device is only a consumer, isn't it?
[Mubin]: will remove it
>=20
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/of_address.h>
> > +
> > +#define TTC_CLK_CNTRL_OFFSET		0x00
> > +#define TTC_CNT_CNTRL_OFFSET		0x0C
> > +#define TTC_MATCH_CNT_VAL_OFFSET	0x30
> > +#define TTC_COUNT_VAL_OFFSET		0x18
> > +#define TTC_INTR_VAL_OFFSET		0x24
> > +#define TTC_ISR_OFFSET			0x54
> > +#define TTC_IER_OFFSET			0x60
> > +#define TTC_PWM_CHANNEL_OFFSET		0x4
> > +
> > +#define TTC_CLK_CNTRL_CSRC_MASK		BIT(5)
> > +#define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)
> > +
> > +#define TTC_CNTR_CTRL_DIS_MASK		BIT(0)
> > +#define TTC_CNTR_CTRL_INTR_MODE_EN_MASK	BIT(1)
> > +#define TTC_CNTR_CTRL_MATCH_MODE_EN_MASK	BIT(3)
> > +#define TTC_CNTR_CTRL_RST_MASK		BIT(4)
> > +#define TTC_CNTR_CTRL_WAVE_EN_MASK	BIT(5)
> > +#define TTC_CNTR_CTRL_WAVE_POL_MASK	BIT(6)
>=20
> If you ask me do s/_OFFSET// and s/_MASK// on all these definitions.
[Mubin]: will update them
>=20
> > +#define TTC_CLK_CNTRL_PSV_SHIFT		1
>=20
> This is unused.
[Mubin]: will remove it .
> > +
> > +#define TTC_PWM_MAX_CH			3
> > +
> > +/**
> > + * struct ttc_pwm_priv - Private data for TTC PWM drivers
> > + * @chip:	PWM chip structure representing PWM controller
> > + * @clk:	TTC input clock
> > + * @max:	Maximum value of the counters
> > + * @base:	Base address of TTC instance
> > + */
> > +struct ttc_pwm_priv {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	u32 max;
> > +	void __iomem *base;
> > +};
> > +
> > +static inline u32 ttc_pwm_readl(struct ttc_pwm_priv *priv,
> > +				unsigned long offset)
> > +{
> > +	return readl_relaxed(priv->base + offset); }
> > +
> > +static inline void ttc_pwm_writel(struct ttc_pwm_priv *priv,
> > +				  unsigned long offset,
> > +				  unsigned long val)
> > +{
> > +	writel_relaxed(val, priv->base + offset); }
> > +
> > +static inline u32 ttc_pwm_ch_readl(struct ttc_pwm_priv *priv,
> > +				   struct pwm_device *pwm,
> > +				   unsigned long offset)
> > +{
> > +	unsigned long pwm_ch_offset =3D offset +
> > +				       (TTC_PWM_CHANNEL_OFFSET * pwm-
> >hwpwm);
> > +
> > +	return ttc_pwm_readl(priv, pwm_ch_offset); }
> > +
> > +static inline void ttc_pwm_ch_writel(struct ttc_pwm_priv *priv,
> > +				     struct pwm_device *pwm,
> > +				     unsigned long offset,
> > +				     unsigned long val)
> > +{
> > +	unsigned long pwm_ch_offset =3D offset +
> > +				       (TTC_PWM_CHANNEL_OFFSET * pwm-
> >hwpwm);
> > +
> > +	ttc_pwm_writel(priv, pwm_ch_offset, val); }
> > +
> > +static inline struct ttc_pwm_priv *xilinx_pwm_chip_to_priv(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct ttc_pwm_priv, chip); }
> > +
> > +static void ttc_pwm_enable(struct ttc_pwm_priv *priv, struct
> > +pwm_device *pwm) {
> > +	u32 ctrl_reg;
> > +
> > +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> > +	ctrl_reg |=3D (TTC_CNTR_CTRL_INTR_MODE_EN_MASK
> > +				 |
> TTC_CNTR_CTRL_MATCH_MODE_EN_MASK | TTC_CNTR_CTRL_RST_MASK);
> > +	ctrl_reg &=3D (~(TTC_CNTR_CTRL_DIS_MASK |
> > +TTC_CNTR_CTRL_WAVE_EN_MASK));
>=20
> superflous parenthesis.
[Mubin]: will remove it in v2
>=20
> > +	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg); }
> > +
> > +static void ttc_pwm_disable(struct ttc_pwm_priv *priv, struct
> > +pwm_device *pwm) {
> > +	u32 ctrl_reg;
> > +
> > +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> > +	ctrl_reg |=3D TTC_CNTR_CTRL_DIS_MASK;
> > +
> > +	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg); }
> > +
> > +static void ttc_pwm_rev_polarity(struct ttc_pwm_priv *priv, struct
> > +pwm_device *pwm) {
> > +	u32 ctrl_reg;
> > +
> > +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> > +	ctrl_reg ^=3D TTC_CNTR_CTRL_WAVE_POL_MASK;
> > +	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
>=20
> I prefer to have this more explicit like
>=20
> 	ttc_pwm_set_polarity(..., enum pwm_polarity polarity)
[Mubin]: Agreed
>=20
> > +}
> > +
> > +static void ttc_pwm_set_counters(struct ttc_pwm_priv *priv,
> > +				 struct pwm_device *pwm,
> > +				 u32 div,
> > +				 u32 period_cycles,
> > +				 u32 duty_cycles)
> > +{
> > +	u32 clk_reg;
> > +
> > +	/* Set up prescalar */
> > +	clk_reg =3D ttc_pwm_ch_readl(priv, pwm, TTC_CLK_CNTRL_OFFSET);
> > +	clk_reg &=3D ~TTC_CLK_CNTRL_PSV_MASK;
> > +	clk_reg |=3D div;
>=20
> We have
>=20
> #define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)
>=20
> so the LSB of div sets a bit outside of TTC_CLK_CNTRL_PSV_MASK; that look=
s
> wrong.
[Mubin]: will fix it in v2
>=20
> > +	ttc_pwm_ch_writel(priv, pwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
> > +
> > +	/* Set up period */
> > +	ttc_pwm_ch_writel(priv, pwm, TTC_INTR_VAL_OFFSET,
> period_cycles);
> > +
> > +	/* Set up duty cycle */
> > +	ttc_pwm_ch_writel(priv, pwm, TTC_MATCH_CNT_VAL_OFFSET,
> duty_cycles);
>=20
> how does the output pin behave between the writes in this function (and t=
he
> others in .apply())?
[Mubin]:  ttc_pwm_apply  is disabling counters before calling this function=
, and enabling it back immediately after it.  So, output pin would be low d=
uring configuration.=20
>=20
> > +}
> > +
> > +static int ttc_pwm_apply(struct pwm_chip *chip,
> > +			 struct pwm_device *pwm,
> > +			 const struct pwm_state *state)
> > +{
> > +	u32 div =3D 0;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	unsigned long rate;
> > +	struct pwm_state cstate;
> > +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> > +
> > +	pwm_get_state(pwm, &cstate);
>=20
> Please don't use pwm consumer functions. You can use pwm->state directly.
[Mubin]: will fix in v2
>=20
> > +	if (state->polarity !=3D cstate.polarity) {
> > +		if (cstate.enabled)
> > +			ttc_pwm_disable(priv, pwm);
> > +
> > +		ttc_pwm_rev_polarity(priv, pwm);
> > +
> > +		if (cstate.enabled)
> > +			ttc_pwm_enable(priv, pwm);
>=20
> It would (probably) be nice to delay that enable until you configured
> duty_cycle and period to reduce the amount of wrong signalling.
[Mubin]: Agreed
>=20
> > +	}
> > +
>=20
> You can exit early here if state->enabled =3D=3D false.
>=20
> > +	if (state->period !=3D cstate.period ||
> > +	    state->duty_cycle !=3D cstate.duty_cycle) {
>=20
> (With an early exit above this check becomes wrong, simply drop it.)
[Mubin]: OK
>=20
> > +		rate =3D clk_get_rate(priv->clk);
> > +
> > +		/* Prevent overflow by limiting to the maximum possible
> period */
> > +		period_cycles =3D min_t(u64, state->period, ULONG_MAX *
> NSEC_PER_SEC);
> > +		period_cycles =3D DIV_ROUND_CLOSEST(period_cycles * rate,
> > +NSEC_PER_SEC);
>=20
> DIV_ROUND_CLOSEST isn't suiteable to work with u64. (That's also the
> reason for the build bot report.)
>=20
> The usual alternative trick here is to do:
>=20
> 	if (rate > NSEC_PER_SEC)
> 		return -EINVAL;
>=20
> 	period_cycles =3D mul_u64_u64_div_u64(state->period, rate,
> NSEC_PER_SEC);
[Mubin]: Initially I tried mul_u64_u64_div_u64, it was impacting accuracy w=
hile generating PWM signal of high frequency(output frequency above 5 MHZ, =
 input 100 MHZ ). Usage of DIV_ROUND_CLOSEST improved accuracy. Can you ple=
ase suggest better alternative for improving accuracy.
>=20
> > +		if (period_cycles > priv->max) {
> > +			/* prescale frequency to fit requested period cycles
> within limit */
> > +			div =3D 1;
> > +
> > +			while ((period_cycles  > priv->max) && (div < 65536))
> {
>=20
> s/  / /
[Mubin]: OK
>=20
> Also this can be calculated without a loop. Maybe it's easier to store th=
e
> timer width in priv instead of max =3D BIT(width) - 1.
>=20
> > +				rate =3D DIV_ROUND_CLOSEST(rate, BIT(div));
> > +				period_cycles =3D DIV_ROUND_CLOSEST(state-
> >period * rate,
> > +
> NSEC_PER_SEC);
[Mubin]: Agreed, will implement that logic in v2.
> > +				if (period_cycles < priv->max)
> > +					break;
> > +				div++;
> > +			}
> > +
> > +			if (period_cycles  > priv->max)
> > +				return -ERANGE;
> > +		}
> > +
> > +		duty_cycles =3D DIV_ROUND_CLOSEST(state->duty_cycle * rate,
> > +						NSEC_PER_SEC);
>=20
> Please ensure that you configure a period that is not bigger than
> state->period. Ditto for duty_cycle.
[Mubin]: OK
>=20
> > +		if (cstate.enabled)
> > +			ttc_pwm_disable(priv, pwm);
> > +
> > +		ttc_pwm_set_counters(priv, pwm, div, period_cycles,
> duty_cycles);
> > +
> > +		if (cstate.enabled)
> > +			ttc_pwm_enable(priv, pwm);
>=20
> Another possible glitch here.
[Mubin]: Can you please elaborate.
>=20
> > +	}
> > +
> > +	if (state->enabled !=3D cstate.enabled) {
> > +		if (state->enabled)
> > +			ttc_pwm_enable(priv, pwm);
> > +		else
> > +			ttc_pwm_disable(priv, pwm);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ttc_pwm_get_state(struct pwm_chip *chip,
> > +			     struct pwm_device *pwm,
> > +			     struct pwm_state *state)
> > +{
> > +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> > +	unsigned long rate;
> > +	u32 value;
> > +	u64 tmp;
> > +
> > +	value =3D ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
> > +
> > +	if (value & TTC_CNTR_CTRL_WAVE_POL_MASK)
> > +		state->polarity =3D PWM_POLARITY_INVERSED;
> > +	else
> > +		state->polarity =3D PWM_POLARITY_NORMAL;
> > +
> > +	if (value & TTC_CNTR_CTRL_DIS_MASK)
> > +		state->enabled =3D false;
> > +	else
> > +		state->enabled =3D true;
> > +
> > +	rate =3D clk_get_rate(priv->clk);
> > +
> > +	tmp =3D ttc_pwm_ch_readl(priv, pwm, TTC_INTR_VAL_OFFSET);
> > +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> > +
> > +	tmp =3D ttc_pwm_ch_readl(priv, pwm,
> TTC_MATCH_CNT_VAL_OFFSET);
> > +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
>=20
> This looks wrong for several reasons. Have you tested with PWM_DEBUG
> enabled? What is rate typically?
>=20
> .get_state is supposed to round up in its divisions. Also I miss a factor=
 of
> NSEC_PER_SEC here, and also div doesn't appear here?!
[Mubin]: Did not tested it with PWM_DEBUG. Typical rate is 100 MHZ. I will =
fix it in v2.
>=20
> > +	return 0;
> > +}
> > +
> > +static struct pwm_device *
> > +ttc_pwm_of_xlate(struct pwm_chip *chip, const struct of_phandle_args
> > +*args) {
> > +	struct pwm_device *pwm;
> > +
> > +	if (args->args[0] >=3D TTC_PWM_MAX_CH)
> > +		return NULL;
> > +
> > +	pwm =3D pwm_request_from_chip(chip, args->args[0], NULL);
> > +	if (IS_ERR(pwm))
> > +		return pwm;
> > +
> > +	if (args->args[1])
> > +		pwm->args.period =3D args->args[1];
> > +
> > +	if (args->args[2])
> > +		pwm->args.polarity =3D args->args[2];
> > +
> > +	return pwm;
> > +}
>=20
> I don't see an advantage in this function over the default
> of_pwm_xlate_with_flags(). (There are downsides though I think.)
>=20
> If you drop this function there is only one usage of TTC_PWM_MAX_CH left
> and you can drop this symbol, too. (In favour of
>=20
> 	priv->chip.npwm =3D 3;
>=20
> .)
[Mubin]: Agreed
>=20
> > +static const struct pwm_ops ttc_pwm_ops =3D {
> > +	.apply =3D ttc_pwm_apply,
> > +	.get_state =3D ttc_pwm_get_state,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int ttc_pwm_probe(struct platform_device *pdev) {
> > +	int ret;
> > +	int clksel;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct ttc_pwm_priv *priv;
> > +	u32 pwm_cells;
> > +	u32 timer_width;
> > +	struct clk *clk_cs;
> > +
>=20
> Please add a comment here about coexistence with the timer mode.
[Mubin]: OK
>=20
> > +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> > +	if (ret =3D=3D -EINVAL)
> > +		return -ENODEV;
> > +
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "could not read #pwm-
> cells\n");
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	ret =3D of_property_read_u32(np, "timer-width", &timer_width);
> > +	if (ret)
> > +		timer_width =3D 16;
> > +
> > +	priv->max =3D BIT(timer_width) - 1;
> > +
> > +	clksel =3D ttc_pwm_readl(priv, TTC_CLK_CNTRL_OFFSET);
>=20
> TTC_CLK_CNTRL_OFFSET is as parameter for ttc_pwm_ch_readl and
> ttc_pwm_readl, is this correct?
[Mubin]: Here TTC_CLK_CNTRL_OFFSET is being read only for 0th channel, so u=
sing ttc_pwm_readl does not impact offsets.
>=20
> > +	clksel =3D !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
> > +	clk_cs =3D of_clk_get(np, clksel);
>=20
> Can you use devm_clk_get_enabled here?
[Mubin]: Yes, will switch to devm_clk_get_enabled  in v2.
>=20
> > +	if (IS_ERR(clk_cs))
> > +		return dev_err_probe(dev, PTR_ERR(clk_cs),
> > +				     "ERROR: timer input clock not found\n");
> > +
> > +	priv->clk =3D clk_cs;
> > +	ret =3D clk_prepare_enable(priv->clk);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> > +
> > +	clk_rate_exclusive_get(priv->clk);
> > +
> > +	priv->chip.dev =3D dev;
> > +	priv->chip.ops =3D &ttc_pwm_ops;
> > +	priv->chip.npwm =3D TTC_PWM_MAX_CH;
> > +	priv->chip.of_xlate =3D ttc_pwm_of_xlate;
> > +	ret =3D pwmchip_add(&priv->chip);
> > +	if (ret) {
> > +		clk_rate_exclusive_put(priv->clk);
> > +		clk_disable_unprepare(priv->clk);
> > +		return dev_err_probe(dev, ret, "Could not register PWM
> chip\n");
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ttc_pwm_remove(struct platform_device *pdev) {
> > +	struct ttc_pwm_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	pwmchip_remove(&priv->chip);
> > +	clk_rate_exclusive_put(priv->clk);
> > +	clk_disable_unprepare(priv->clk);
>=20
> missing clk_put() (unless you switch to a devm_clk_get variant as suggest=
ed
> above).
[Mubin] will be switching to devm_clk_get in next version.

Thanks,
Mubin
>=20
> > +
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
