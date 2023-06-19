Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609AD735620
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFSLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFSLtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:49:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336A9D1;
        Mon, 19 Jun 2023 04:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu85ieOFtQfV/8UbQe5/xoKKqmSmSi62cehMrIiOchfSCeLd5MAmNluF8OPLC4Xl7Svq608B7NLSMYpKb44k5D7T1yI6dSMjS58TbZWNpO0LQ68vctC1pfazZG9CfPGtMyK9YNbr9EiRsEDwbxlPyuqiUmK1eDbFmzwz+886M+N4m6iUTzhxBkbpgOYnW4UmT29GVCaCq/zjGeawq6NmoijnyIRWsuCGjHB0CYabSSLw15s6562nZNLxyOztD7IAILRl4EVwltO+2I7MWrB5bk7AP+AcXvTafyC07w3waxKC0S0JBii+83aPhdU0f5nd1ZnYN+ilTUrm/oMSHOrr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsqN57bWN7gsZgwc19RiUP4V91KrUyZBvrTBSHf+Mh8=;
 b=AsQepSJJwHkWjc0YfFXBmew4JbNq61sSz9X48V75WwrECzuSq5mSoOiW4ABR2U1J97Qwy4xmvdQrxMRF0bg1Im89edoEP0hNVhVsqpwveenhAlDgWdN2Ituxm7Eof/4hXXeDmSyvpJdkG374NsoWi0VVNKGpvbocvhul7eXBVQPzM0NOGsJqo0RdNMxfRiXOnjHX0CgjEfohQGd8iIfFup2RdWMLYRT8dLiVsKC4V5JkPHfW2qvSVbIoQUUYrYEhB4nlhKgcab2MWyP8CftTHA+2+gEJgoPigKg5EmiOjlZZ82NKKc229xlu8Hk3WiizWdbDXf5Ls/XqunCGX6jBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsqN57bWN7gsZgwc19RiUP4V91KrUyZBvrTBSHf+Mh8=;
 b=gw84W0F8+pryqtxKTayGhFPKHKDv7zpN6i75xHOqiEMI1qMlecmStRFGeQeHElFDIq8M5MU1lsiHt5SAxXwLs64zJh9WCns8M7UyL9mgS+AKcL0VZ/YWg1QDLS87GVZlRUieciDklmg08lIKqVlsUXL6B+F6XOvks+qGTGWUHBI=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 11:49:06 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::3087:7db7:f0eb:cb8f]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::3087:7db7:f0eb:cb8f%2]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 11:49:06 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
Thread-Topic: [PATCH v2 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
Thread-Index: AQHZoDBTwnyTNgO+qkCGryL+tAH4MK+NjU8AgAR2XwA=
Date:   Mon, 19 Jun 2023 11:49:05 +0000
Message-ID: <BN7PR12MB28020F62E196B98047E63FD8DC5FA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
 <20230616085513.17632-2-amit.kumar-mahapatra@amd.com>
 <20230616152556.GA440257-robh@kernel.org>
In-Reply-To: <20230616152556.GA440257-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|IA1PR12MB6186:EE_
x-ms-office365-filtering-correlation-id: fd7ce7be-b494-461d-523f-08db70bb2f5b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YqrluP7RKatQSz8tfbjPfm4YqNNRAKEirBDVpMhgmJvEbXldBnj1FGXuIJE2JgV0gfmqndsdHB7LI5QEnxCa8SLy6OhQxlFlb8SdpITmy+59pwy4PF7q62/XQ1kj94JASgyE/Tk7lOI3ZlT9TuCAT6O9mmeUFcEMJyvGriinuX2fWkIY/noyyn/qQhgtnhcxantVIk78BUJwwYEWqFSWIIkmHKO29PPsN5tAn17SpkMNO+qlpEvPC8JRouOhrvWa66N7hpB5Q7p+NCHW8dDGnAgz61hVAQ59GM1kFRD4qtpDc0T4EkDKa3YSbJOmLlsYB511NJ5DaOnWAFVad7PqpOSGEKGds0wRV48o8unru5VghkrWTILvd2ltQCyyG6v4eVpVQjzkexT8M5t+rc9QZ1CYshNsc9Wlxscg8AVbaNUJC46Pt7VOGt/uIHT3DGwN3+uPQKbe/rFKw5CyZEHn6UnpIJgba6/wwndasLF/G1UUYokoK3G/JVBGUDQ5ZcSX0Lug6zDkgXkdOYGdoT/h5HElrKd+jyoWCjV7ZQ1Xpsj1dVQqW0FgFKS9SHlQ311CmFnH44CPmVrCKTuFb9rufY/xuwluQAVen+ThLBXRJBALeuN/ArpmWp5ZwLZLgbWv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(71200400001)(478600001)(83380400001)(86362001)(7696005)(122000001)(66476007)(66556008)(76116006)(54906003)(64756008)(66446008)(66946007)(316002)(38100700002)(26005)(53546011)(9686003)(6506007)(186003)(4326008)(6916009)(8676002)(8936002)(5660300002)(2906002)(52536014)(7416002)(38070700005)(41300700001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rkefeO1OxRyZnA88G6dlm8sOXt8MsaA787kcns+zzLptTSFINoxXVT+8Bq+m?=
 =?us-ascii?Q?biFO/cMdn9JctDy5rtwxaoeUUvT2WMElUchXk85riP6T6ITEtRYm3O99tvSR?=
 =?us-ascii?Q?GeNnKNzp1YufnnQTFsxfqB/HynhRqjFDuss2GyJwwtxgm9X/tDjtoBHl395i?=
 =?us-ascii?Q?HNGW7vt/dB1ihZvdO0uBHMsgfzqZnxeWcATzF/Ss2ri4a9w0iQwsrGioL9NJ?=
 =?us-ascii?Q?dp2BIZRnGX8TLHFT4nN2Skg040sgRIEt3SYQoXTrzpYUYRGtNgOgiTOzC6q9?=
 =?us-ascii?Q?srwBsg04ATu8+fT7vfqr4kAaiapa3tXMb0VOb0buUynIZUzq9N2VWuVID+26?=
 =?us-ascii?Q?noP7wPxNbfOPUKtCpnhdrVPxkib7wJ3C3aoOlkswH1WD2SfnClkvBuFbMSuj?=
 =?us-ascii?Q?CCPaYSxu7SZED0wYUQZJwwKPGONYXGOQBZ3nn/tjdDL8QGTVgnA5sys6YOG5?=
 =?us-ascii?Q?Yb7WPwPNxpo7o6N/l4Theu+AcpUT5bZPQIfL++CMjkFaTuT5PjBck4A9GrvI?=
 =?us-ascii?Q?qlzFjrpWeErO5m2nGBcwpGXAIc+/NcfvBVJQroZwcKsW0RXilIzYZc9bAO1r?=
 =?us-ascii?Q?uxo/r0LYzIzLWkeM4kLSj/aDUSOk3DFh7felWRg1dv9/bSR/4TNsmrMYyXsG?=
 =?us-ascii?Q?WGuYt8FutfH2zpo0PR/FXKuBrBeEUQ+qnyPVqKB4Cc4BrYPWW+8p99y6mMky?=
 =?us-ascii?Q?/YpyXmNnoO8tFM/cx1gv8dkvXVubpizzPflPlVmVLTMkQQex/umSeXWK8PPm?=
 =?us-ascii?Q?t/iEbLKEoTSEfhrPWJe5NwFH6pjnf3Q4k+NLt6fJ4rxCyzzI1mFrmJlZQcyp?=
 =?us-ascii?Q?GC9ocYKTnngI9+k5L3i4S0zY1+5xNmfhgDy4yUD8cboAaUoZumoGuvP1QY5q?=
 =?us-ascii?Q?mIZW8RaiUApX/L3FWMqdpwFhZOZZGmb2gX8OXA8q6YdZX0QyG6tcpVsRmkOe?=
 =?us-ascii?Q?Ux0xEzBEDCwv92N6H8UrW7PSMnAIOL+fiYR1Vt7Z0C9PIzJP7vPdapevMqOm?=
 =?us-ascii?Q?tPPoueNcjPt6L2S9L90iKPj6+jqRlTbk3Qe1dF1vHaj6m5UU7SKF4P0g6yxw?=
 =?us-ascii?Q?exHhp3X6EH4eTdLNWJnu6gQRR+G4H2PSGHZk24tpB8HAFs3LYDSl7jeoZpPx?=
 =?us-ascii?Q?2z+fhM+84Hq9Ubl18JEJ2eDz9Nt9hUC7fer7cPBvP2cLtlFKEMC5qEb8iHrl?=
 =?us-ascii?Q?Sleth7Q7WNTwZXEx/vwCSGk5qbBhlxti6LvMN6G1AZi8NRMWO0mkV+dhvALY?=
 =?us-ascii?Q?x2ufqfWp5xFfWfanMCjZyXoHSk8W5/an8Wc71v9Grq7WlZnJEUyEMk0YkFZ9?=
 =?us-ascii?Q?Fl1t4ey6AHsjDR78ceuXO5TpaJqMGxelqGWSC64hKXFdMLcusVRlSpQ+zwgo?=
 =?us-ascii?Q?txl2QLU3MkjAc0aPrkkK2sxUpJ4qpzjr396TT5oVCLPwdgiCA8YJX8mEgcUj?=
 =?us-ascii?Q?7bDR0BtdvL5MmveNdqTIQ4CQM2mhtQRB043RNhCDyyfN7wDWVuitb+MFSkoJ?=
 =?us-ascii?Q?gB8EAVuQZcKqCji9BF/3tFERDb4hz7+MaL3GY8gfPyqtLNLilfcLHse/BBpu?=
 =?us-ascii?Q?ziz19QIzgKwsS48POZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7ce7be-b494-461d-523f-08db70bb2f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 11:49:05.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kg3j4W4f1fzYIo16yKuGX5L9h8kv0Ja25p8ejgiPy5J5wPnDAJGN3qWF5bFFdiuZYKcgIUgYGE6IoeMbfLkcGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, June 16, 2023 8:56 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: tudor.ambarus@linaro.org; pratyush@kernel.org;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; git (AMD-Xilinx)
> <git@amd.com>; michael@walle.cc; linux-mtd@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> amitrkcian2002@gmail.com
> Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT prop=
erty
> to avoid setting SRWD bit in status register
>=20
> On Fri, Jun 16, 2023 at 02:25:12PM +0530, Amit Kumar Mahapatra wrote:
> > If the WP signal of the flash device is not connected and the software
> > sets the status register write disable (SRWD) bit in the status
> > register then thestatus register permanently becomes read-only. To
> > avoid this added a new boolean DT property "broken-wp". If WP signal
> > is not connected, then this property should be set in the DT to avoid
> > setting the SRWD during status register write operation.
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > index 89959e5c47ba..10a6df752f6f 100644
> > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > @@ -70,6 +70,21 @@ properties:
> >        be used on such systems, to denote the absence of a reliable res=
et
> >        mechanism.
> >
> > +  broken-wp:
>=20
> In the tied low case, that's designed behavior rather than broken. The na=
me
> should reflect that.

In that case will it be ok to change it to "no-wp". Please let me know if
you have any other suitable name.

Regards,
Amit
>=20
> > +    type: boolean
> > +    description:
> > +      The status register write disable (SRWD) bit in status register,=
 combined
> > +      with the WP signal, provides hardware data protection for the de=
vice.
> When
> > +      the SRWD bit is set to 1, and the WP signal is either driven LOW=
 or hard
> > +      strapped to LOW, the status register nonvolatile bits become rea=
d-only
> and
> > +      the WRITE STATUS REGISTER operation will not execute. The only w=
ay
> to exit
> > +      this hardware-protected mode is to drive WP HIGH. If the WP sign=
al of
> the
> > +      flash device is not connected then status register permanently b=
ecomes
> > +      read-only as the SRWD bit cannot be reset. This boolean flag can=
 be
> used
> > +      on systems in which WP signal is not connected, to avoid setting=
 the
> SRWD
> > +      bit while writing the status register. If the WP signal is hard =
strapped
> > +      to LOW then it is not broken as it can be a valid use case.
> > +
> >    reset-gpios:
> >      description:
> >        A GPIO line connected to the RESET (active low) signal of the de=
vice.
> > --
> > 2.17.1
> >
