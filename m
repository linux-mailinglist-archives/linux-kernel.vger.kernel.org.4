Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47496862AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBAJRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:17:35 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC18CC34;
        Wed,  1 Feb 2023 01:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coIv1yUSIisYcbH6/V7QjXoLabWZVf658NaLscRgLkyEq8T3MwyZF/5QbNBfMQgEgJExshOK+40Z9/zUu1HWJYvUwyACk3PcAGNSgUnjc19HePavT0ITNyYyRd0Dksn/s2btsg7uEg+44os8xF6USPXJxIVBGueeHdu7inA5dXWg5BVHUU+0ZJ5NuJwgFoQbdY/osonEeuASQTBhujhH3NZaBcAtsUwtzO4a7ngOZf9Tflpl4BbvgfEBwzZh1IyqjX26tIJvyU4WSmsciWUT8bjhH/Fmbqw5CkaY7ykTYCiAhxPB1X0W8ErlH5e5dp08Kqyk0gbK/gh8mbMBtyp9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aElBcsg6rdldNUa9ZvXxAwMIeTqSgDFDEcOXk9rgQMc=;
 b=kpA0O7MU2GDQaW5Sev6HsK0P8Skrajhusw16ywmNjVzu5aT4LtauZjqMQAB8EgOuGpE+GByH+8PRF8xg+Cca+Kb7TKqU9+bp9lvntsndsDpcw0uX/6qUYI8pS983dPDv1QJvK1L8uLZgSOXc9+HwsdMLwggHTKEitBFDRSWUdS/c0C9jlTxozKYxM0fz+fcGBuomZHTfN7Kh3AAcZN5Dw0m2pga5JXQU8fdPoWilPG3waGL7KeWXhTvbCBsq1h/o8VRmmLkFMCpjJGMVvWHd+j957AwrmVl/Gkazxl2LslCaIcPf7LHEwCPGglOl0Ks6OrvdITNmBHciTZnHiG1Aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aElBcsg6rdldNUa9ZvXxAwMIeTqSgDFDEcOXk9rgQMc=;
 b=rYpM3visVEWJZLK+GHsL2bSbsaGivPa2AkS8ITatbL+dg8yeqqdlZB1g+YZpNEcgOsRU19jgSQt+FVcgfyvlMq/fOII7mZDTlimJsjuCrfCEwj7lOR/iTNKxhOwptssLQsuTGHkGawgGm5bZNdlekKL9wGgm1jl8km7EgGJUqPxAsinBspj8QLt8+QRq1JoZY4Xh7AorAJ2i+AWTsCZLKSM6Eo0JcMxeTchHuWnNkWfW4jUpD90y6LwtySRorbGLkM+aD8hh/tQEKRf8jikjaxe57CMwDNl+4G3zOf2cRBAv8Fi4Txwhj1akbB9sjqpryvn32tRqltO4UruBGpwyww==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS4PR10MB5768.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 09:17:32 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 09:17:31 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] tty: n_gsm: add keep alive support
Thread-Topic: [PATCH 1/3] tty: n_gsm: add keep alive support
Thread-Index: AQHZNhjWVUvjeWMSkEi/GfrXE3Mzea65z9OQ
Date:   Wed, 1 Feb 2023 09:17:31 +0000
Message-ID: <DB9PR10MB58814F4711FC3403F7AF089BE0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <Y9olcm0PiSCSikri@kroah.com>
In-Reply-To: <Y9olcm0PiSCSikri@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-01T09:17:30Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1b098c22-dce0-494b-b81b-877d5625808b;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS4PR10MB5768:EE_
x-ms-office365-filtering-correlation-id: 4ca3da9c-b7e8-43ea-dcae-08db043525ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxcJBsGO9SDRuPrrK9KbwCFn9A3du5A+xwf2Y2s28fGPsBCeHEqhCzxg6bulOPIXr8o+GtcINj+czFjDAcpHBVKIfGSFD3yPXTiEfCFArpMWGZbNUMDtBNrm//rt7iMZmQXj2GndbLuUBuCAJeH3xn82FEKGTsrfNvXPE1PcY6AF0MkvsJjV3kmRtFzgut0CCWC8RB/wCsp7PsH8iJ4gqNytlCIYmFgxq/4wloS5O0Jxq0YVuOGfRXQLggFICJPgJnOMNCO47xxZIDhbZ9q+1lavQGJ8tI/IxwLDnC+67gY4kbB+y0L/zsM0soodGrU/PcOd4JoUJv/yR3CUTklnuHyt3DNYPfYhT7rS28mGdf7TOAHr6OBZkKt75kfXZ2wSRW+Om5DEY5/WE3/Gpvya+LMh4xeXgIXU1PVgUtjflSlnSOVLd6uypVVuGq4mj6LKzv3p87SQxZXXLIVOVJQzhWmYBv0nYerfmmioJpPEXKnN9BRl1KjBfzViGuJ3sRQfEmaxbRDFekubQTWyH1QPaV3TGgNCtV7ycAlHsvZa5AMMh7hkGjtR4Ps1tc9UYuyg6GIsvOgi4X8a7I9632LucB7WPY9foW/rd71sYUJOi53CDCADn3uAB7Z3Ntsqbq0+eORITfcaIB/VV8dKUriwx9PWWmN2vLl4tN0ZgEP13ZjBEJiIGW+Hd1iA8WEbQYeXJ54WUdKKx7bgxxHCb224gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(6916009)(76116006)(8676002)(8936002)(54906003)(41300700001)(316002)(4326008)(66946007)(55016003)(66446008)(66476007)(66556008)(38070700005)(82960400001)(86362001)(33656002)(122000001)(38100700002)(64756008)(6506007)(186003)(7696005)(71200400001)(9686003)(26005)(2906002)(52536014)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I+cF4jl+HWQ015D2E19WQ18V6BpPhd9ebnjoB3olw0br4YGMxmXv6JWiEe/r?=
 =?us-ascii?Q?POEqsqKwt0HOj5KZ3H7hTv/lzYOOkdjd4huYkGBUSiH7l2WxcKTZJp35zofz?=
 =?us-ascii?Q?FnzI+iuGvyB2SmsZASOLy1TKo+v5KpFesKWMK9JAF2HjjQASXS6FYGF6aolN?=
 =?us-ascii?Q?utpho+DOiCEBfq/kjem4Lyvio+wV7iNfmm1sTX0p4TZYqCWGeBwvNhuQMFyB?=
 =?us-ascii?Q?pUcJ7Q1qAYpcDSvavVDsLC7tY8JgRKism6HFCVFjCMsWZbyuwFZlUkl60EQe?=
 =?us-ascii?Q?4A/8gKyfImmwLMVC0CAGxcl97gL+/RWdcAI+r1Vffu8BcWrUENaiJk3QAw9/?=
 =?us-ascii?Q?OnwC17vYqx9kwW2CATNcgSA6cyKRg2H6zB6WpUmB0UMN9YTtdej5Ly53YHSK?=
 =?us-ascii?Q?slZzVhqyqJMjxe0TMXXnUs2R23keYA4CaOgSQHyM+d0Mjh49O8nQIP3HX5t1?=
 =?us-ascii?Q?+qTnHUDltYBsgU0nDbnGuNIsBrgTJXTRGYYl/r/EPIiOixpe9ydDUt/I6oxm?=
 =?us-ascii?Q?gg8JvmPaShYuA1kIN8sLzv08I9clgH4aX/NP7CwH7oi6K+JuWgOfNdDc0qJ9?=
 =?us-ascii?Q?l4lVu5Ct5I3JbQwyZVYQx2WGzmGgF1i+mWtjZO2IZmUKNMIPHIvbuiXJNBNK?=
 =?us-ascii?Q?DwK3FySo6mHEe3Td1etWzQWRanYcy+TIaeoIFdJINCWeurA/zDRsz2HM4+07?=
 =?us-ascii?Q?ORgTqSIvWQk9BNN0GX3H4xPf59CW8xyMkNVuNj7dKpFMvxo+cUfsktNc2UxT?=
 =?us-ascii?Q?QaZPrVq7w9FgmoZUc7WTvxXmJYAQ5qJPVOydirLRWuJnL8ynebjD/BnHYMMg?=
 =?us-ascii?Q?kNvZY8ar5zcWZlBH/1AS6NmXBZSPiDS1IMWYyfilMJxwaKl0I2kKVAD2qdeR?=
 =?us-ascii?Q?HCr3D12aBPTiF7g25EN1p2uymbmbCJHbHTsCZlGUgM/0aW0aBK2i3MURrhng?=
 =?us-ascii?Q?9DjqGcHDzCyylVpsuxdpqlTuin8baYf09uk6CtG3E5+Ky0+G/gYtqqKL8aoW?=
 =?us-ascii?Q?NEyzuMnuwKfErmPWVzgNY86RMbI1Pfx6xwEkEAKa7A/QROz86l6h9KrO5l85?=
 =?us-ascii?Q?llC4bWmW0DR8VgCBYNXURGAP5MJmqN8QB/7aGfU3fjHglZ9+syJGcoRxcEFw?=
 =?us-ascii?Q?xqBJjqvqdHIomYNnWG5edMabvCgc7FFQ8IENeDcCTHmyKW6/ENJtS7kHDtY+?=
 =?us-ascii?Q?cFSq/X3gmanP9HU4+yUGe1D5i6EhetH1UNmOjRqF6HUEs18V56wsTGRKIcdD?=
 =?us-ascii?Q?sancaKvqnyUt9VKvsEA/Z4ouDUz7jeXNok3LfFl1Ps3PeZOSzHIY7lrrnHBN?=
 =?us-ascii?Q?wOxDXsJP8DcgsM/g8+qGm9dkI4dbqdKxvdE0S+0CFskDutKfb4ESRkYD80bb?=
 =?us-ascii?Q?4noW3wNfJclxxTuQ8Oh4ohGV01Zshojtrekt8hbhxIyo3U6DFUbOn/H7UQNx?=
 =?us-ascii?Q?I/1j00aWyh9SLeo+jYUvcJNR+32ObQHc4b+O+nsVPPG5Wa2fZLrWKQmHCd02?=
 =?us-ascii?Q?EK9bR/tVwm6OFNQymfusNS8DK6oSgRFO0fkJIDvn3Xmc8VuniVyThM7uPgfc?=
 =?us-ascii?Q?y9w3Zk/j7JBOHlF4Rtl2rw4ev9N+cou4Nt7A9AfCi62XaQSngXom3uP+NK4O?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca3da9c-b7e8-43ea-dcae-08db043525ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:17:31.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBoov09Z8MMHy7cHmxMKt2Y3UzI/UHvAa9QjvADuYk9KV98TVHE27yDQceFOglS5ZkD0B1BxyjleLgJN5YuXSWABxIfxD8OzD4wMXTfohGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > index cb8693b39cb7..b64360aca1f9 100644
> > --- a/include/uapi/linux/gsmmux.h
> > +++ b/include/uapi/linux/gsmmux.h
> > @@ -19,7 +19,8 @@ struct gsm_config
> >  	unsigned int mtu;
> >  	unsigned int k;
> >  	unsigned int i;
> > -	unsigned int unused[8];		/* Padding for expansion without
> > +	unsigned int keep_alive;
> > +	unsigned int unused[7];		/* Padding for expansion without
>=20
> "unsigned int" is not really a valid uapi variable type.
>=20
> Shouldn't this be __u32 instead?

I know but changing it to a fixed size data type may break compatibility
as this may change the overall size of the structure. This is why I
took a field out of the "unused" array for the "keep_alive" parameter.
A value of zero disables keep-alive polling.

> Should you document this field as to what the value is and the units as
> you are creating a new user/kernel api here.

I will add a comment here. Comments for the other fields remain subject to
another patch.

> And finally, "unused" here is being properly checked to be all 0, right?
> If not, then this change can't happen for obvious reasons :(

This was not the case until now. I assumed there was some coding guideline
that unused fields need to be initialized to zero. Obviously, checking it
prevents misuse here. I will add relevant checks for this.

Best regards,
Daniel Starke
