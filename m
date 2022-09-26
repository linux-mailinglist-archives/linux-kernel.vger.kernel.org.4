Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3DA5EA6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiIZNER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiIZNDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:03:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A4D1B9127;
        Mon, 26 Sep 2022 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664192140; x=1695728140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3tg+xUpgcwiRUNFX9M1K9X+ZEL+kRntI5WAKvauGIJ8=;
  b=VfPJ9Bf77XL51+2oyTdRrUtraJTyB3u+Cxvg0SGWlvjRoZd/02Tnp2h8
   IXEDBDZXBQIJ3Qlg7SyIpYypEd2tyaAQn1vdf/Pb4cQJ/7eS3NnfUpHdQ
   qF+wpfimz5tFxwnJbr9Ywoctgk8Xc4I1CciokRsBlXYvYoK0jY5U66/9g
   CoRnNaxM5dKho3k/WoZQC0tu8hZ27kLhKZ74GT21PNAZSwMMF/037BwVG
   6qTfAt9R7iw5YfBL0zLJlY4E8LELjGlsbIQcJXWGk4whtWGJBNW9Y6o5U
   OoXqcPayCCR7FsDqOf903huPoZcB0oFvahQcEQegwo9KVi1ChAMOkg4oG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="115394664"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2022 04:32:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 26 Sep 2022 04:32:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 26 Sep 2022 04:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsQ3Dyc8JVRDHagAbOemFRza2Yt0iGe1XljiI+JbFjMD7iru0zc3qSyyAzt/SYQazGBXxKsWxXExUlmRcbqsxt8isbaU2abNex0BuOtx06qIouM5bqyBHnEOULsBCB3Gg6XK+oIG0AojCk5Md9jZfRdqt0yoZgI6C2suz3ikN3xFllPsDwwXL+e1n0/yaFWkJvpQh2Q/vqfCysgqftrIAnxHvjaByiIzcKILb6aIKEoS+nclHltibxlm1Sk+1xSbVpl3QSBTV5qomv1sdgs9W1+Q5PzvdAhP7dGogrA3BGjglgkn3lg2V/HYfyGnS2oz2PlqWi41SFdh/A7DJapq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvU5BY8HzmvSSfk7Ug4B8qYzpIZtQKYU0Dc3w5XOEd8=;
 b=eliulOI3BPd7yV/Dg7xzITQvND6Wc6FBBi2I9A6sgxvB4DI1hhnpr1BT8F3b4b/HRzHiSQBQ8At2MacVCtJ+9dNLKiCRv9Uo8TixO7T0d9UpJCal/0ttJkNoRd5Dx7+OXhvVw0acnYCyYka//3uPxaPAecKnRbwDAJnL5q5CAoXeeKneJR3HAvEZoAUVHPZzU1T8/AGWP/bt7kRFC/xs9c+7UNkemtMRoRqAVJdrUSK1jIllKMFHEP2n+6kDDm6Rp4nrMgdIY7AonGyfaMWGk9vl4jDHywjUoJT4aYY8TUa8s1XJqYsy0nq3SmAYWyv6smjccT5dbUk52DZl68+0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvU5BY8HzmvSSfk7Ug4B8qYzpIZtQKYU0Dc3w5XOEd8=;
 b=Nrvf5G1G44QVqlkecQMmHEXPCKUP8Eh+aHH6zFmcgU6f5zb5/T6jVNMt0O5Hz5XvrLpyvEEHAXCg2EHOEr+AMidAV+HEpvtKkF/+xokKfs+fvjaVnfkZv2QwHvBFKCFPp0MJRpgFESVQbBIhRpvoD51iKBHXeirRP4h1ucM6Xa0=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 11:32:32 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::44a1:dd85:8d3b:56fd]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::44a1:dd85:8d3b:56fd%7]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 11:32:31 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
        <Prakash.Battu@microchip.com>
Subject: RE: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Thread-Topic: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Thread-Index: AQHYzK9awxPJcnRsMkKQ3xMPRpeBzK3oO6wAgAjvzMA=
Date:   Mon, 26 Sep 2022 11:32:31 +0000
Message-ID: <PH0PR11MB56118BCE8F6B5E045485A71C81529@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20220920051023.12330-1-shravan.chippa@microchip.com>
 <YymuoFhxHBQLAicQ@valkosipuli.retiisi.eu>
In-Reply-To: <YymuoFhxHBQLAicQ@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SA2PR11MB4779:EE_
x-ms-office365-filtering-correlation-id: ae9f9165-8b02-47a7-81dd-08da9fb2cd03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/aAP93ll15XfPe6EKYYUWRSZBiTSkrBF1U5lpVYsug9M/9D+gyIsaQ9Jlrfifn3HvWaEApkn/eoMmTAyrJOAiAq99bm+gHEU/7G60xKa1uPPerHqRN8Qpsou5gAeJSXZR3bTvpE2rgFmSkaJgNNkjD2gTUOLt7AtsuuvV2UIAsf/UC+9oKeOpF96u2u15xkAa9ib1U0MDE+NxxapcejfBGBM1KIqkOypHnBIr7zeJHqSrNhcaB4TmyZIllH/KpCXciXJOYHCWbZZxUUpIhLujF8fXS8CMwt5vWD5Q0D8ole9ilE737d8SNs4SGReB0uUByvnLoijJ25jpNjvbc+C56bSMYwl2K70gOuixykbvFKRz5op4mq0alj4i81IEwKYxu/FXO17X4NO6S7+EBrF3nu9G4IsjqnHpvPwkumv+WK1sVUGEMJK02n8wWkPDXy9/dqOU3NbBK2HqcCrjEpD9aaB3Y0XQPIRJOCjYU0YxbQAJfAwUx5UyXHBwRXo14Le0g8LoPZ3zcdZzfgPuCqqq1S+ftVT9R+Hnz9CEIndSgxf4W+mFj8iTm3gpPUpzoBUMRlGsB5dQ/0dxuGOivMfC2xyxSspT9YoUvMa8HW/8Z6UmzNwUb/mtd/iHbYWSLLqExr6rilrbIFyLRCQSMOEBy8vkhVsxAOq3eiKv7NbRguUf/7w70P7+FqzfmstkTuo90p5iPnGZDtqddaSqv1I7WBgvdGmeeO6yBgdF8/pfW6+dR1d9kcEbzu+kwwlZQDHFhvk45b++hlp3sosjyF3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(5660300002)(6506007)(52536014)(53546011)(7696005)(86362001)(41300700001)(107886003)(66946007)(8936002)(4326008)(76116006)(2906002)(30864003)(316002)(6916009)(54906003)(71200400001)(55016003)(26005)(966005)(33656002)(478600001)(186003)(9686003)(122000001)(83380400001)(38070700005)(38100700002)(66446008)(64756008)(66476007)(66556008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+qZb2cWNrHTDWH0K6DDXI6+2DhvbUHQM9TPujER35mEgP4Lb18qoLvvK9jba?=
 =?us-ascii?Q?YZhfqODEQUVTYTdWGCN/Vcx+YRuDGmAqGphqsaSxWWg71p3t5t9f3M4hsQbm?=
 =?us-ascii?Q?n09u8uTBDCR0/R55diRJ4ZOGlzmShRys2D3qOg40ruPE2Vt3C4dYPlyy7hxC?=
 =?us-ascii?Q?UzfduZYFH2UIJ0iB87NU8GihTJ2lvrVwlV1CcskL5f1/p2Ppkv1IRwHNsk33?=
 =?us-ascii?Q?Bgm2q4ROmgMI9YACJuJV6vZg9hYAX12dSiseahgHLRRzQtX4Z7MPQSpvVF5D?=
 =?us-ascii?Q?2rRdC/7IeocE6l2isIxMeaEf7X6icmoEigoKrPy3dVI7XYYoCjImjDlqoh6F?=
 =?us-ascii?Q?J6EEgauHB9EshNrhFzDbC4tjDuQ3EhH3lh9aRPAW7J2lV+1mS2b8dTYxuJCU?=
 =?us-ascii?Q?IOcyBEDx3xyzGIPxNRFVpchl2Yfr55yWGLRoKp868AiRTU6iaR0BvJQm0Buh?=
 =?us-ascii?Q?Ihrb8ZE80wWcJiyHHPJhajT8yl57IozsPWZjiDYzG14dS5Tuk8rGU12fMxHM?=
 =?us-ascii?Q?YiLg7qmSieqIJ6yQ+2oyoBSnQrnbFAp0lUkn4M04EmVVHS25BBqpprTd5cwG?=
 =?us-ascii?Q?XHCa4ce1tpK2f02NHafVvFrdCz37GcEpH+/y4J061wMagLBpp65pyWPX+0PA?=
 =?us-ascii?Q?XLDMEwzGGNtja43476q5xA/Xst5HtPw7MQXIBZ0HTsxYLrV2X4vQgB4yzLAQ?=
 =?us-ascii?Q?tfaLhHC01m2dB+I/JlBtuRpTzSBejwjNNkgUHcXxjve8im+2MLZa3PuFWaoo?=
 =?us-ascii?Q?i3eKwxfpP3lA8rN92FoJ41psBjzGgpsCypMxocSoI04aj+sqQmIj46NRGH4K?=
 =?us-ascii?Q?rR1SD9mKtXeEYeqZupKVHakIIHO2fJ2ovoE0yOnZBSz+JMaA/Mkj8N+HLej0?=
 =?us-ascii?Q?m73Up72rm4Nat2WZj4enFEVCIoDUjh69LRscJvXN00YAZ1pDUFenT9cfurqj?=
 =?us-ascii?Q?C8+3hXCcGQrDULFhwapkJgW7fQesS2kkxpK5zzeJsddSzfY0XdB6v1CHZ6Ll?=
 =?us-ascii?Q?rBRoP/X6PZ7TdTnLdAGtbdiH/+yd5AiiBdbfHiz9eeEXQE1tNzWW+G8P/9Of?=
 =?us-ascii?Q?gJdIYAlFucDF96lBrIX5MU8VpJgLt2xkJO+iVN8qK4Ve4jP0KZfUv65OjBbG?=
 =?us-ascii?Q?XowVGIEoP5xyH6rdz5jUCtnZDrHYkAS2WyanSnAbyRsWzk650K8X+RaZhVel?=
 =?us-ascii?Q?wo/ZcIuWU5EZh0VkiMacvOakJCSJUL60gKAGPiD3iZ/K/FookmfemgSz4z4E?=
 =?us-ascii?Q?QVDzZy/YcIFxzK2Pi6MQJjcVfwYPor6X0mlcbRKD6lWF7SXe8WS3m3Ww/9cx?=
 =?us-ascii?Q?8T/u3n0VAcaac8nZsdzVjhgeX0t0Cs9OsRD5UcJalvZR+o+he8+LxZ6P/quv?=
 =?us-ascii?Q?kZcWNVG2zRXJfZ1nCioqml/vx3wyHU5qc9WV+kXeDGw6oXQVkOf7KzbYiYPI?=
 =?us-ascii?Q?ILmIUrA3IEDHMVVv9NmeyBdMMsotuoHAHob3o1WykTTIVvK0DVQHkIHXM5Ir?=
 =?us-ascii?Q?b3Q3jSiLdlO14BrcPLjMyUdd3SK0qo1LgomkXTeVolOEj7HQICB5AYJhpTgJ?=
 =?us-ascii?Q?gJeVax9ul6vFA0V9t5dwrO3VMN/fpvNT2KxasVaXUGtMEsAK0PBdok4IgCS+?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9f9165-8b02-47a7-81dd-08da9fb2cd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 11:32:31.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC9eyse7tTHBi6CzxWdzrD9wZtfYZ14PjzKbwH0xH1m6sifVVewbXeWqX9FsEkY2UVVF2WZyLUWD6yuwHCpJIapPWvl5EW/azBwRhzn7FFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: 20 September 2022 05:44 PM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; Conor Dooley - M52691
> <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> <Prakash.Battu@microchip.com>
> Subject: Re: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
>=20
> [Some people who received this message don't often get email from
> sakari.ailus@iki.fi. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Shravan,
>=20
> Thanks for the patch.
>=20
> On Tue, Sep 20, 2022 at 10:40:23AM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > Some platforms may not be capable of supporting the bandwidth required
> > for 12 bit or 3840x2160 resolutions.
> >
> > Add support for dynamically selecting 10 bit and 1920x1080 resolutions
> > while leaving the existing configuration as default
> >
> > CC: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Prakash Battu <Prakash.Battu@microchip.com>
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >
> > V3 -> V4
> > - Make the 12 bit and 3840x2160 as default
> > - Set bus code SRGGB12 if set format fails
> >
> > V2 -> V3
> > - Fixed the warning reported by kernel test robot
> >
> > V1 -> V2
> > - Addressed the review comment given by Jacopo Mondi,
> >   Which has bug in imx334_enum_frame_size() loop function,
> > - Renamed array codes[] to imx334_mbus_codes[]
> > - Modified supported_modes[] to get higher resolution first
> >
> > ---
> >  drivers/media/i2c/imx334.c | 302
> > +++++++++++++++++++++++++++++++++----
> >  1 file changed, 276 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> > index 062125501788..df2f1821569e 100644
> > --- a/drivers/media/i2c/imx334.c
> > +++ b/drivers/media/i2c/imx334.c
> > @@ -79,7 +79,6 @@ struct imx334_reg_list {
> >   * struct imx334_mode - imx334 sensor mode structure
> >   * @width: Frame width
> >   * @height: Frame height
> > - * @code: Format code
> >   * @hblank: Horizontal blanking in lines
> >   * @vblank: Vertical blanking in lines
> >   * @vblank_min: Minimal vertical blanking in lines @@ -91,7 +90,6 @@
> > struct imx334_reg_list {  struct imx334_mode {
> >       u32 width;
> >       u32 height;
> > -     u32 code;
> >       u32 hblank;
> >       u32 vblank;
> >       u32 vblank_min;
> > @@ -119,6 +117,7 @@ struct imx334_mode {
> >   * @vblank: Vertical blanking in lines
> >   * @cur_mode: Pointer to current selected sensor mode
> >   * @mutex: Mutex for serializing sensor controls
> > + * @cur_code: current selected format code
> >   * @streaming: Flag indicating streaming state
> >   */
> >  struct imx334 {
> > @@ -140,6 +139,7 @@ struct imx334 {
> >       u32 vblank;
> >       const struct imx334_mode *cur_mode;
> >       struct mutex mutex;
> > +     u32 cur_code;
> >       bool streaming;
> >  };
> >
> > @@ -147,6 +147,169 @@ static const s64 link_freq[] =3D {
> >       IMX334_LINK_FREQ,
> >  };
> >
> > +/* Sensor mode registers */
> > +static const struct imx334_reg mode_1920x1080_regs[] =3D {
> > +     {0x3000, 0x01},
> > +     {0x3018, 0x04},
> > +     {0x3030, 0xCA},
> > +     {0x3031, 0x08},
> > +     {0x3032, 0x00},
> > +     {0x3034, 0x4C},
> > +     {0x3035, 0x04},
> > +     {0x302C, 0xF0},
> > +     {0x302D, 0x03},
> > +     {0x302E, 0x80},
> > +     {0x302F, 0x07},
> > +     {0x3074, 0xCC},
> > +     {0x3075, 0x02},
> > +     {0x308E, 0xCD},
> > +     {0x308F, 0x02},
> > +     {0x3076, 0x38},
> > +     {0x3077, 0x04},
> > +     {0x3090, 0x38},
> > +     {0x3091, 0x04},
> > +     {0x3308, 0x38},
> > +     {0x3309, 0x04},
> > +     {0x30C6, 0x00},
> > +     {0x30C7, 0x00},
> > +     {0x30CE, 0x00},
> > +     {0x30CF, 0x00},
> > +     {0x30D8, 0x18},
> > +     {0x30D9, 0x0A},
> > +     {0x304C, 0x00},
> > +     {0x304E, 0x00},
> > +     {0x304F, 0x00},
> > +     {0x3050, 0x00},
> > +     {0x30B6, 0x00},
> > +     {0x30B7, 0x00},
> > +     {0x3116, 0x08},
> > +     {0x3117, 0x00},
> > +     {0x31A0, 0x20},
> > +     {0x31A1, 0x0F},
> > +     {0x300C, 0x3B},
> > +     {0x300D, 0x29},
> > +     {0x314C, 0x29},
> > +     {0x314D, 0x01},
> > +     {0x315A, 0x0A},
> > +     {0x3168, 0xA0},
> > +     {0x316A, 0x7E},
> > +     {0x319E, 0x02},
> > +     {0x3199, 0x00},
> > +     {0x319D, 0x00},
> > +     {0x31DD, 0x03},
> > +     {0x3300, 0x00},
> > +     {0x341C, 0xFF},
> > +     {0x341D, 0x01},
> > +     {0x3A01, 0x03},
> > +     {0x3A18, 0x7F},
> > +     {0x3A19, 0x00},
> > +     {0x3A1A, 0x37},
> > +     {0x3A1B, 0x00},
> > +     {0x3A1C, 0x37},
> > +     {0x3A1D, 0x00},
> > +     {0x3A1E, 0xF7},
> > +     {0x3A1F, 0x00},
> > +     {0x3A20, 0x3F},
> > +     {0x3A21, 0x00},
> > +     {0x3A20, 0x6F},
> > +     {0x3A21, 0x00},
> > +     {0x3A20, 0x3F},
> > +     {0x3A21, 0x00},
> > +     {0x3A20, 0x5F},
> > +     {0x3A21, 0x00},
> > +     {0x3A20, 0x2F},
> > +     {0x3A21, 0x00},
> > +     {0x3078, 0x02},
> > +     {0x3079, 0x00},
> > +     {0x307A, 0x00},
> > +     {0x307B, 0x00},
> > +     {0x3080, 0x02},
> > +     {0x3081, 0x00},
> > +     {0x3082, 0x00},
> > +     {0x3083, 0x00},
> > +     {0x3088, 0x02},
> > +     {0x3094, 0x00},
> > +     {0x3095, 0x00},
> > +     {0x3096, 0x00},
> > +     {0x309B, 0x02},
> > +     {0x309C, 0x00},
> > +     {0x309D, 0x00},
> > +     {0x309E, 0x00},
> > +     {0x30A4, 0x00},
> > +     {0x30A5, 0x00},
> > +     {0x3288, 0x21},
> > +     {0x328A, 0x02},
> > +     {0x3414, 0x05},
> > +     {0x3416, 0x18},
> > +     {0x35AC, 0x0E},
> > +     {0x3648, 0x01},
> > +     {0x364A, 0x04},
> > +     {0x364C, 0x04},
> > +     {0x3678, 0x01},
> > +     {0x367C, 0x31},
> > +     {0x367E, 0x31},
> > +     {0x3708, 0x02},
> > +     {0x3714, 0x01},
> > +     {0x3715, 0x02},
> > +     {0x3716, 0x02},
> > +     {0x3717, 0x02},
> > +     {0x371C, 0x3D},
> > +     {0x371D, 0x3F},
> > +     {0x372C, 0x00},
> > +     {0x372D, 0x00},
> > +     {0x372E, 0x46},
> > +     {0x372F, 0x00},
> > +     {0x3730, 0x89},
> > +     {0x3731, 0x00},
> > +     {0x3732, 0x08},
> > +     {0x3733, 0x01},
> > +     {0x3734, 0xFE},
> > +     {0x3735, 0x05},
> > +     {0x375D, 0x00},
> > +     {0x375E, 0x00},
> > +     {0x375F, 0x61},
> > +     {0x3760, 0x06},
> > +     {0x3768, 0x1B},
> > +     {0x3769, 0x1B},
> > +     {0x376A, 0x1A},
> > +     {0x376B, 0x19},
> > +     {0x376C, 0x18},
> > +     {0x376D, 0x14},
> > +     {0x376E, 0x0F},
> > +     {0x3776, 0x00},
> > +     {0x3777, 0x00},
> > +     {0x3778, 0x46},
> > +     {0x3779, 0x00},
> > +     {0x377A, 0x08},
> > +     {0x377B, 0x01},
> > +     {0x377C, 0x45},
> > +     {0x377D, 0x01},
> > +     {0x377E, 0x23},
> > +     {0x377F, 0x02},
> > +     {0x3780, 0xD9},
> > +     {0x3781, 0x03},
> > +     {0x3782, 0xF5},
> > +     {0x3783, 0x06},
> > +     {0x3784, 0xA5},
> > +     {0x3788, 0x0F},
> > +     {0x378A, 0xD9},
> > +     {0x378B, 0x03},
> > +     {0x378C, 0xEB},
> > +     {0x378D, 0x05},
> > +     {0x378E, 0x87},
> > +     {0x378F, 0x06},
> > +     {0x3790, 0xF5},
> > +     {0x3792, 0x43},
> > +     {0x3794, 0x7A},
> > +     {0x3796, 0xA1},
> > +     {0x37B0, 0x37},
> > +     {0x3E04, 0x0E},
> > +     {0x30E8, 0x50},
> > +     {0x30E9, 0x00},
> > +     {0x3E04, 0x0E},
> > +     {0x3002, 0x00},
> > +};
> > +
> >  /* Sensor mode registers */
> >  static const struct imx334_reg mode_3840x2160_regs[] =3D {
> >       {0x3000, 0x01},
> > @@ -243,20 +406,56 @@ static const struct imx334_reg
> mode_3840x2160_regs[] =3D {
> >       {0x3a00, 0x01},
> >  };
> >
> > +static const struct imx334_reg raw10_framefmt_regs[] =3D {
> > +     {0x3050, 0x00},
> > +     {0x319D, 0x00},
> > +     {0x341C, 0xFF},
> > +     {0x341D, 0x01},
> > +};
> > +
> > +static const struct imx334_reg raw12_framefmt_regs[] =3D {
> > +     {0x3050, 0x01},
> > +     {0x319D, 0x01},
> > +     {0x341C, 0x47},
> > +     {0x341D, 0x00},
> > +};
> > +
> > +/*
> > + * The supported BUS formats.
> > + */
> > +static const u32 imx334_mbus_codes[] =3D {
> > +     MEDIA_BUS_FMT_SRGGB12_1X12,
> > +     MEDIA_BUS_FMT_SRGGB10_1X10,
> > +};
> > +
> >  /* Supported sensor mode configurations */ -static const struct
> > imx334_mode supported_mode =3D {
> > -     .width =3D 3840,
> > -     .height =3D 2160,
> > -     .hblank =3D 560,
> > -     .vblank =3D 2340,
> > -     .vblank_min =3D 90,
> > -     .vblank_max =3D 132840,
> > -     .pclk =3D 594000000,
> > -     .link_freq_idx =3D 0,
> > -     .code =3D MEDIA_BUS_FMT_SRGGB12_1X12,
> > -     .reg_list =3D {
> > -             .num_of_regs =3D ARRAY_SIZE(mode_3840x2160_regs),
> > -             .regs =3D mode_3840x2160_regs,
> > +static const struct imx334_mode supported_modes[] =3D {
> > +     {
> > +             .width =3D 3840,
> > +             .height =3D 2160,
> > +             .hblank =3D 560,
> > +             .vblank =3D 2340,
> > +             .vblank_min =3D 90,
> > +             .vblank_max =3D 132840,
> > +             .pclk =3D 594000000,
> > +             .link_freq_idx =3D 0,
> > +             .reg_list =3D {
> > +                     .num_of_regs =3D ARRAY_SIZE(mode_3840x2160_regs),
> > +                     .regs =3D mode_3840x2160_regs,
> > +             },
> > +     }, {
> > +             .width =3D 1920,
> > +             .height =3D 1080,
> > +             .hblank =3D 560,
> > +             .vblank =3D 1170,
> > +             .vblank_min =3D 90,
> > +             .vblank_max =3D 132840,
> > +             .pclk =3D 594000000,
> > +             .link_freq_idx =3D 0,
> > +             .reg_list =3D {
> > +                     .num_of_regs =3D ARRAY_SIZE(mode_1920x1080_regs),
> > +                     .regs =3D mode_1920x1080_regs,
> > +             },
> >       },
> >  };
> >
> > @@ -506,10 +705,10 @@ static int imx334_enum_mbus_code(struct
> v4l2_subdev *sd,
> >                                struct v4l2_subdev_state *sd_state,
> >                                struct v4l2_subdev_mbus_code_enum
> > *code)  {
> > -     if (code->index > 0)
> > +     if (code->index >=3D ARRAY_SIZE(imx334_mbus_codes))
> >               return -EINVAL;
> >
> > -     code->code =3D supported_mode.code;
> > +     code->code =3D imx334_mbus_codes[code->index];
> >
> >       return 0;
> >  }
> > @@ -526,15 +725,22 @@ static int imx334_enum_frame_size(struct
> v4l2_subdev *sd,
> >                                 struct v4l2_subdev_state *sd_state,
> >                                 struct v4l2_subdev_frame_size_enum
> > *fsize)  {
> > -     if (fsize->index > 0)
> > +     unsigned int i;
> > +
> > +     if (fsize->index >=3D ARRAY_SIZE(supported_modes))
> >               return -EINVAL;
> >
> > -     if (fsize->code !=3D supported_mode.code)
> > +     for (i =3D 0; i < ARRAY_SIZE(imx334_mbus_codes); ++i) {
> > +             if (imx334_mbus_codes[i] =3D=3D fsize->code)
> > +                     break;
> > +     }
> > +
> > +     if (i =3D=3D ARRAY_SIZE(imx334_mbus_codes))
> >               return -EINVAL;
> >
> > -     fsize->min_width =3D supported_mode.width;
> > +     fsize->min_width =3D supported_modes[fsize->index].width;
> >       fsize->max_width =3D fsize->min_width;
> > -     fsize->min_height =3D supported_mode.height;
> > +     fsize->min_height =3D supported_modes[fsize->index].height;
> >       fsize->max_height =3D fsize->min_height;
> >
> >       return 0;
> > @@ -553,7 +759,7 @@ static void imx334_fill_pad_format(struct imx334
> > *imx334,  {
> >       fmt->format.width =3D mode->width;
> >       fmt->format.height =3D mode->height;
> > -     fmt->format.code =3D mode->code;
> > +     fmt->format.code =3D imx334->cur_code;
> >       fmt->format.field =3D V4L2_FIELD_NONE;
> >       fmt->format.colorspace =3D V4L2_COLORSPACE_RAW;
> >       fmt->format.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT; @@ -591,6
> > +797,21 @@ static int imx334_get_pad_format(struct v4l2_subdev *sd,
> >       return 0;
> >  }
> >
> > +static int imx334_get_format_code(struct imx334 *imx334, struct
> > +v4l2_subdev_format *fmt) {
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(imx334_mbus_codes); i++) {
> > +             if (imx334_mbus_codes[i] =3D=3D fmt->format.code)
>=20
> If you return here, you can remove the check below.
This function taken ref from imx219 driver.
And suggested by given by Jacopo Mondi
Change in v2
>=20
> > +                     break;
> > +     }
> > +
> > +     if (i >=3D ARRAY_SIZE(imx334_mbus_codes))
> > +             i =3D 0;
> > +
> > +     return imx334_mbus_codes[i];
> > +}
> > +
> >  /**
> >   * imx334_set_pad_format() - Set subdevice pad format
> >   * @sd: pointer to imx334 V4L2 sub-device structure @@ -609,7 +830,13
> > @@ static int imx334_set_pad_format(struct v4l2_subdev *sd,
> >
> >       mutex_lock(&imx334->mutex);
> >
> > -     mode =3D &supported_mode;
> > +     imx334->cur_code =3D imx334_get_format_code(imx334, fmt);
>=20
> This should be done only for the active format.
Are you expecting  if condiftion to check the current bus code with set_pad=
_fromat bus code?
>=20
> > +
> > +     mode =3D v4l2_find_nearest_size(supported_modes,
> > +                                   ARRAY_SIZE(supported_modes),
> > +                                   width, height,
> > +                                   fmt->format.width,
> > + fmt->format.height);
> > +
> >       imx334_fill_pad_format(imx334, mode, fmt);
> >
> >       if (fmt->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) { @@ -617,7 +844,7
> @@
> > static int imx334_set_pad_format(struct v4l2_subdev *sd,
> >
> >               framefmt =3D v4l2_subdev_get_try_format(sd, sd_state, fmt=
->pad);
> >               *framefmt =3D fmt->format;
> > -     } else {
> > +     } else if (imx334->cur_mode !=3D mode) {
> >               ret =3D imx334_update_controls(imx334, mode);
> >               if (!ret)
> >                       imx334->cur_mode =3D mode; @@ -642,11 +869,26 @@
> > static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
> >       struct v4l2_subdev_format fmt =3D { 0 };
> >
> >       fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> V4L2_SUBDEV_FORMAT_ACTIVE;
> > -     imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > +     imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
> >
> >       return imx334_set_pad_format(sd, sd_state, &fmt);  }
> >
> > +static int imx334_set_framefmt(struct imx334 *imx334) {
> > +     switch (imx334->cur_code) {
> > +     case MEDIA_BUS_FMT_SRGGB10_1X10:
> > +             return imx334_write_regs(imx334, raw10_framefmt_regs,
> > +
> > +ARRAY_SIZE(raw10_framefmt_regs));
>=20
> Please align to immediately right of the opening parenthesis. Same below.
>=20
> > +
> > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > +             return imx334_write_regs(imx334, raw12_framefmt_regs,
> > +
> > + ARRAY_SIZE(raw12_framefmt_regs));
>=20
> I think you'll also need changes to the pixel clock calculation.
>=20
In this driver pixel clock read only variable.
Pixel clock change maybe in different series.


Thanks,
Shravan

> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  /**
> >   * imx334_start_streaming() - Start sensor stream
> >   * @imx334: pointer to imx334 device
> > @@ -667,6 +909,13 @@ static int imx334_start_streaming(struct imx334
> *imx334)
> >               return ret;
> >       }
> >
> > +     ret =3D imx334_set_framefmt(imx334);
> > +     if (ret) {
> > +             dev_err(imx334->dev, "%s failed to set frame format: %d\n=
",
> > +                     __func__, ret);
> > +             return ret;
> > +     }
> > +
> >       /* Setup handler will write actual exposure and gain */
> >       ret =3D  __v4l2_ctrl_handler_setup(imx334->sd.ctrl_handler);
> >       if (ret) {
> > @@ -1037,7 +1286,8 @@ static int imx334_probe(struct i2c_client *client=
)
> >       }
> >
> >       /* Set default mode to max resolution */
> > -     imx334->cur_mode =3D &supported_mode;
> > +     imx334->cur_mode =3D &supported_modes[0];
> > +     imx334->cur_code =3D imx334_mbus_codes[0];
> >       imx334->vblank =3D imx334->cur_mode->vblank;
> >
> >       ret =3D imx334_init_controls(imx334);
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
