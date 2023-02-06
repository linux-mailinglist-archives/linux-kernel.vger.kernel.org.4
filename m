Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4456D68B4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBFEnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFEns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:43:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC53415543;
        Sun,  5 Feb 2023 20:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675658626; x=1707194626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6gzUlZNI31hfH9icyXp2cAjjStvYAV9zyFhmHYgyHfM=;
  b=kLww3NTuTArOL2PMVX05Pj2nrXVDYycCbcQ1RvFgSjLueiteIILokpYF
   Plww2zlvlCv/iznacvhI1uZqbfYZmkrvDtNwVBV41/REDVwQzgIUrzS5+
   jnuHpeUmWbCKsUAgBX2RUZX++eAGF2HN6TKm+ulcfbpahKBu6UgxGu9+b
   GbSU4AEe9GQBnv34e8xW7gVgreFg9/LgjNX+6jUvovCTvOlbuu48aoeWQ
   8zv9JwsEUEMc+HvHXBwzgydYwafr0ea2u8RlS8cVzmLoI1PdVDDFAIgyk
   PFntJVWwP+00Gbd/8sqs5fn9/ZWXfGhdeC9NaojOJW0To1f3+zukaRi27
   w==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669100400"; 
   d="scan'208";a="195465916"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2023 21:43:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 21:43:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Sun, 5 Feb 2023 21:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuaqyEF2HiLd6aaNEBUYJ34671RLRzEEXf6vD3oh1kvTrlEvK8nLfbjBaIYErJRGv7N+YIu5xrS5gd9XUIm8VcYY4nbIFZgNyXnhmMPHRgTQKdBnk6+FfWEJuqbIwFZEJDZNPgODbfDCkqx8sIqcbpvhTzOXrvgNnpNhqyRuukcVk9QjJli/GToIUDXMTQHVYRbRBkslRfkgisMAvHPkIpEFr8hp06HWq10Vj/uh6qCCMLp8fxfpzWNqp5AhPxhVcuXz3Jj2jyNe/9YOi1qHyRUe1R0kcxVFH7FYJgJ4AwwkzJWaKVTotvH1R03fr/s1+2Exng3hAygGMoAsdaRYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5HiMefttE6h7u8anJVPAopmJxZEO2B1clT5BXTVtKY=;
 b=AGzpJuQvizE6wLP3j9vk1KjgfxCIKlMBSs/6Wls5ILNV8vObJvQ+uoxB/EDgGNNHsCs4ko0X+99tAoZjvs9M7V2j+Cag5iA5a56CsVzbmPXNxuanpPEJoPMQXbjrCIdUtEzZdlydD2NPdNBsw5hirOoHM7iZyDUyzFx51V4KFi/taHJsvsR6IfJTmo6a/2VnyQOhO3kk7wYunR3eV2WZscqZ80tk+HcN18kbPaOsaGjIUn+YJfnITPuWrG5xivJHxzdbYyY8m8pb2YoVjBajk9TJZLR1TBZe3N+F1vjWaPBNvP2eATryUIP5Cn0+plw17xGUn6lt15GDvkAD9GOctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5HiMefttE6h7u8anJVPAopmJxZEO2B1clT5BXTVtKY=;
 b=WQj5rCvsnfvk1IWmtCo301OB3qg1Rxb8N5ZFcvg6B1bYJmgVtHOAmHVIOG87QsQqev6DQwLegen7T7jhc3zX1OrLa4qitI3rwoIzAsiwJqmX+RvdvrK0uccS74BBG37YRnhbpa6EsbVQpFaVbdvAAcL/wwbtwGkpXvdEr2MkNkY=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 04:43:42 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%6]) with mapi id 15.20.6064.028; Mon, 6 Feb 2023
 04:43:42 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <festevam@gmail.com>, <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and link
 frequency
Thread-Topic: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and link
 frequency
Thread-Index: AQHZLUnPWr0eVsa9dkWYdFRaw/UsYa6sow+AgABq7FCAAdoPAIACfu1wgBAIoiA=
Date:   Mon, 6 Feb 2023 04:43:42 +0000
Message-ID: <PH0PR11MB561174CA61F9C858577F726781DA9@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-6-shravan.chippa@microchip.com>
 <Y88SG5ndXjQ9AjZg@valkosipuli.retiisi.eu>
 <PH0PR11MB56119C93EB4A19FEFC03778F81C99@PH0PR11MB5611.namprd11.prod.outlook.com>
 <Y9D5eG8PP/qYPk40@valkosipuli.retiisi.eu>
 <PH0PR11MB5611880BB2141A73B2D67D7181CC9@PH0PR11MB5611.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5611880BB2141A73B2D67D7181CC9@PH0PR11MB5611.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|MW5PR11MB5908:EE_
x-ms-office365-filtering-correlation-id: 8f23ab27-cbae-418e-e635-08db07fcb934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SR7UIvo3GZe8NEw4j1nTULCLy/qF1htBJ0ifisEDUQ0rOmr865wtyeGMODAViJEfm7MeNkNXT+wA0ZSSDHtjfycI0OxTwg/zteeKLOSaj+j5i9FeGpcQTJmEulpuLIEFcTbqdlQDFfRQA0rPwfbAov3k6VEH0O755KLaYNZ2F6eGelAKrAzRmXMYT0UXbzYA1ie0K43m4cbq8TA1BS34X1ForpVco2zD6hwC/fHk8zya6X99gk5YEVXpNFDJbtJnF5ZOxT6TtpomHYOd3eLhnLNaBnUhSKHNiroouDgoNNzGFPkDIb+ZLlZ+YM0sbtBK6wgSZR96ipO9CUF5/o86IuQHzTA1NuFq3GFpZyUdECJgDwUQOSUFZj3eLrMhwz8xB+6eqINm5b5YT/QU7drusTdfLqy9Rwn/BaMzirkGlHcUBJtYSfkHAfG2/2zIwCkPS3Q5kftPcis2MUM0VxCD0dbQyrfRJ7lMSYzVw8XDPrj095nIHe6nYaBGgDhgsEbVmk1K/hnAJV9bRse4Jo4wum1UsBWD0P6fYLxEIokdH3G16cTc8M6BfFHp4YOxtEMfSLrHcn0uzOaD3nnEFzuoNonfzOJKtrS4NjX6n41tyndZecJzgMlwGayRbLM2dHxgowhOwBi5jcgK9iRXWNhDttLSa1mIsL+27HpB3WVO6dXOHMkOlg9sb2NQUGZYMzOuK5mprJm3wPSuPOuVH5jdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199018)(478600001)(6916009)(122000001)(2906002)(7696005)(66556008)(26005)(9686003)(186003)(6506007)(8936002)(53546011)(8676002)(66946007)(64756008)(66476007)(66446008)(4326008)(41300700001)(71200400001)(316002)(7416002)(52536014)(5660300002)(54906003)(15650500001)(38100700002)(76116006)(86362001)(55016003)(33656002)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N7y6agNp0ziLg3uZJyHFs/E9L7tp6vWx2d1OBOec6HVh2CpxFzuY7NNW/Fzz?=
 =?us-ascii?Q?FQ3OqiY1eme4czGkGVF/9J5o49BIAwZjFBoeXJuI9ZzRyKPg0Usiad1snx7N?=
 =?us-ascii?Q?BznncKWUQOK4BV2xiTNdOL32QVnANLSCTAa+BNsygLQgqcDJf4sPLHZHkLXX?=
 =?us-ascii?Q?uD+fJF5SEL+94SRQmgDjc8/RDQpIHXUE8I1VTz/2HF8SvwmfMzU3sImxE8FB?=
 =?us-ascii?Q?OldPAnEDvsLMRSjRNzJPvWcJw2HJwNolrXnlXQZHFILn91NSfX6M7XnlUghq?=
 =?us-ascii?Q?2KuKSeaREXB0uFymuapLwLtPf3pQBbdqrm8RRt8uzk2SQbWW3C/QVy3WlfgW?=
 =?us-ascii?Q?7c8a5nnwkltXDyaBxKJ9B5BNW/okD89saYLhg5PrTNS+egAt7PqxWbxaxFw7?=
 =?us-ascii?Q?Cw7HUm6RrREoidXnukH6io5bpUu8lpZqD5UoEofWYaIORH/iDXHHu717cfGQ?=
 =?us-ascii?Q?d9kGK+lgntYPVM99a6x1cr6ByMU1vEK7DsMHdJbG8o51rAylZYl+S6PuwrAe?=
 =?us-ascii?Q?NNPZepfre/00O8/CZwX5NfK/W8V+wziMpaZwe3sWovX0/lJLv37wpYvOcKsD?=
 =?us-ascii?Q?vzxk5tSdF26f5D+oGXnmh/jYgM0b+kNTAgiiJ4+JCK48plmIU5M2X8GwBfS/?=
 =?us-ascii?Q?wPLp+niRGCGQKnqIK4LNWKB6hgGoKnRgvQpX9x8NJCTGGqm7KmPKs+bAdL6G?=
 =?us-ascii?Q?kZs9J6EhwdSeBUPJaBGadaJ0W19Ou5ovaoGsgahwZ+lAnymvDyxlcbvPLgca?=
 =?us-ascii?Q?qoIuA3Two61yEUQ+iYGkISOFDKjRi5JbPm4JRMQNqzvFkz6os1HDofHYdLLz?=
 =?us-ascii?Q?1WI1PMZUqoqBjPHl8jRTOKuZJiZ3d56t1z09hEyX9XvfMboIrDdT9h/kzSzs?=
 =?us-ascii?Q?SaKJ1ZhjPqPgJnkW4OH7ca8h46dk3kf9s3ITl2QmtopLCRJlDw4f6tBqkAhC?=
 =?us-ascii?Q?Hkb2WJZ/no9FAOo1TIJrMNMWZkbTTCOpboBp6JvNnLnJ+TsD/A37muFjs8/w?=
 =?us-ascii?Q?qtB2xJtf4U/VzDuWrvLnwbvddlPx24XbOCgmb2rT/t9j7HPpSwX1BjN1fNBj?=
 =?us-ascii?Q?G5vGKkEiORyZQTUlbbrABxXj272BfBAB2mStSQTXa+8Z+K33vP55QbuX30Un?=
 =?us-ascii?Q?A4KFguwcsfVkW12BgoM6EO6VemDyC6EckeKDXQHGqH5ByvaaHoR/KaNkuU6O?=
 =?us-ascii?Q?5cdhl42mVzNWrwT37/ZIqN3nBEN7YtU8KIHwq/8Z71RM8zuwSBg4ZvjT3e4y?=
 =?us-ascii?Q?9NnxprStucxMTsx5xY2c0GeO1ZzrsWXp3RAuUqiURRCZhA/BTd53NKyKCqR5?=
 =?us-ascii?Q?69gkS+ARr+ya6zXOrd2fF5hLNBdg3Koc5YwmkyC9EBztM+VLG6pxhrkOYS2O?=
 =?us-ascii?Q?Ry4PNH7otFRjorMmQ/q+26RWZVuqqevSjls58zjYTadsNL+2ttpgS7gatbRR?=
 =?us-ascii?Q?5sH7IKM2LRvWdlDx+MQDgDvTxb6A0ZtJkanqGYI11FwNYGBv0v+c9blCeLIH?=
 =?us-ascii?Q?5QmZx2PX3c7BlhKp9ZqpDe2zR+zyHX8pMk33q54RwryJhEIIFz5vQ/iHWejw?=
 =?us-ascii?Q?LAB9g8SRXB3x3Z6PazsAg4+iqBZjlNQBqA0y+4/wE4nNXKiTllu1pHWYwQAf?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23ab27-cbae-418e-e635-08db07fcb934
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 04:43:42.2992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we+oyS+vlpz4tCrene6e7G2xgTxjUXm5VM/79QtA4/Ozyi4yRLRqmxHJ51kbI7ADDJr5HcrQvAmqe5k8fnv8ubSD0Xii/IdRRK+XbaeQSrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,


> -----Original Message-----
> From: shravan Chippa - I35088
> Sent: 27 January 2023 05:40 AM
> To: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> kernel@pengutronix.de; linux-imx@nxp.com; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and
> link frequency
>=20
> Hi Sakari,
>=20
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@iki.fi>
> > Sent: 25 January 2023 03:12 PM
> > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > kernel@pengutronix.de; linux-imx@nxp.com; linux-
> media@vger.kernel.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel
> > and link frequency
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > Hi Shravan,
> >
> > On Tue, Jan 24, 2023 at 05:34:02AM +0000, Shravan.Chippa@microchip.com
> > wrote:
> > > Hi Sakari,
> > >
> > > > -----Original Message-----
> > > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > > Sent: 24 January 2023 04:33 AM
> > > > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > > > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > > mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> festevam@gmail.com;
> > > > kernel@pengutronix.de; linux-imx@nxp.com;
> > > > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-arm- kernel@lists.infradead.org
> > > > Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update
> > > > pixel and link frequency
> > > >
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> > > >
> > > > Hi Shravan,
> > > >
> > > > On Sat, Jan 21, 2023 at 09:07:13AM +0530, shravan kumar wrote:
> > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > > >
> > > > > Update pixel_rate and link frequency for 1920x1080@30 while
> > > > > changing mode.
> > > > >
> > > > > Add dummy ctrl cases for pixel_rate and link frequency to avoid
> > > > > error while changing the modes dynamically.
> > > > >
> > > > > Add support to handle multiple link frequencies.
> > > > >
> > > > > Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > > > ---
> > > > >  drivers/media/i2c/imx334.c | 41
> > > > > ++++++++++++++++++++++++++++----------
> > > > >  1 file changed, 30 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/i2c/imx334.c
> > > > > b/drivers/media/i2c/imx334.c index 309c706114d2..62b104eaa437
> > > > > 100644
> > > > > --- a/drivers/media/i2c/imx334.c
> > > > > +++ b/drivers/media/i2c/imx334.c
> > > > > @@ -49,7 +49,8 @@
> > > > >  #define IMX334_INCLK_RATE    24000000
> > > > >
> > > > >  /* CSI2 HW configuration */
> > > > > -#define IMX334_LINK_FREQ     891000000
> > > > > +#define IMX334_LINK_FREQ_891M        891000000
> > > > > +#define IMX334_LINK_FREQ_445M        445500000
> > > > >  #define IMX334_NUM_DATA_LANES        4
> > > > >
> > > > >  #define IMX334_REG_MIN               0x00
> > > > > @@ -139,12 +140,14 @@ struct imx334 {
> > > > >       u32 vblank;
> > > > >       const struct imx334_mode *cur_mode;
> > > > >       struct mutex mutex;
> > > > > +     unsigned long menu_skip_mask;
> > > > >       u32 cur_code;
> > > > >       bool streaming;
> > > > >  };
> > > > >
> > > > >  static const s64 link_freq[] =3D {
> > > > > -     IMX334_LINK_FREQ,
> > > > > +     IMX334_LINK_FREQ_891M,
> > > > > +     IMX334_LINK_FREQ_445M,
> > > > >  };
> > > > >
> > > > >  /* Sensor mode registers for 1920x1080@30fps */ @@ -468,7
> > > > > +471,7 @@ static const struct imx334_mode supported_modes[] =3D {
> > > > >               .vblank_min =3D 45,
> > > > >               .vblank_max =3D 132840,
> > > > >               .pclk =3D 297000000,
> > > > > -             .link_freq_idx =3D 0,
> > > > > +             .link_freq_idx =3D 1,
> > > > >               .reg_list =3D {
> > > > >                       .num_of_regs =3D ARRAY_SIZE(mode_1920x1080_=
regs),
> > > > >                       .regs =3D mode_1920x1080_regs, @@ -598,6
> > > > > +601,11 @@ static int imx334_update_controls(struct imx334
> > > > > +*imx334,
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > +     ret =3D __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->p=
clk,
> > > > > +                                    mode->pclk, 1, mode->pclk);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > >       ret =3D __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode-
> >hblank,
> > > > >                                      mode->hblank, 1, mode->hblan=
k);
> > > > >       if (ret)
> > > > > @@ -698,6 +706,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *=
ctrl)
> > > > >               pm_runtime_put(imx334->dev);
> > > > >
> > > > >               break;
> > > > > +     case V4L2_CID_PIXEL_RATE:
> > > > > +     case V4L2_CID_LINK_FREQ:
> > > > >       case V4L2_CID_HBLANK:
> > > > >               ret =3D 0;
> > > > >               break;
> > > > > @@ -1047,7 +1057,7 @@ static int imx334_parse_hw_config(struct
> > > > > imx334
> > > > *imx334)
> > > > >       struct fwnode_handle *ep;
> > > > >       unsigned long rate;
> > > > >       int ret;
> > > > > -     int i;
> > > > > +     int i, j;
> > > >
> > > > unsigned int would be nicer.
> > > I will change.
> > > >
> > > > >
> > > > >       if (!fwnode)
> > > > >               return -ENXIO;
> > > > > @@ -1097,11 +1107,20 @@ static int imx334_parse_hw_config(struct
> > > > > imx334
> > > > *imx334)
> > > > >               goto done_endpoint_free;
> > > > >       }
> > > > >
> > > > > -     for (i =3D 0; i < bus_cfg.nr_of_link_frequencies; i++)
> > > > > -             if (bus_cfg.link_frequencies[i] =3D=3D IMX334_LINK_=
FREQ)
> > > > > +     for (i =3D 0; i < bus_cfg.nr_of_link_frequencies; i++) {
> > > > > +             for (j =3D 0; j < ARRAY_SIZE(link_freq); j++) {
> > > > > +                     if (bus_cfg.link_frequencies[i] =3D=3D link=
_freq[j]) {
> > > > > +                             set_bit(j,
> > > > > + &imx334->menu_skip_mask);
> > > >
> > > > Is there a guarantee that you'll only be using the modes with the
> > > > listed frequencies? I don't see one but I might have missed it.
> > >
> > > If I understand it correctly, the question here is, the listed
> > > freqeunceis and modes are one to one mapped? Then yes.
> >
> > I don't see this being checked in imx334_set_pad_format(), for instance=
.
> >
> > If a frequency isn't in DT, the driver isn't supposed to be using it ei=
ther.
>=20
> Yes, there is no check.
>=20
> But, if a frequency is not in DT, the driver will not add in menu items.
> So, the function imx334_set_pad_format() -> imx334_update_controls()
> fails, if we set the frequencies which are not there in the DT or menu it=
ems.
>=20

Are you ok with the above explanation or any changes you are expecting?
Please do let me know if there are any changes needed.
I am planning to send the next version.

Thanks,
Shravan

>=20
> Thanks,
> Shravan
>=20
> >
> > >
> > > Thanks.
> > > shravan
> > > >
> > > > > +                             break;
> > > > > +                     }
> > > > > +             }
> > > > > +
> > > > > +             if (j =3D=3D ARRAY_SIZE(link_freq)) {
> > > > > +                     ret =3D dev_err_probe(imx334->dev, -EINVAL,
> > > > > +                                         "no supported link
> > > > > + freq found\n");
> > > > >                       goto done_endpoint_free;
> > > > > -
> > > > > -     ret =3D -EINVAL;
> > > > > +             }
> > > > > +     }
> > > > >
> > > > >  done_endpoint_free:
> > > > >       v4l2_fwnode_endpoint_free(&bus_cfg);
> > > > > @@ -1232,10 +1251,10 @@ static int imx334_init_controls(struct
> > > > > imx334
> > > > *imx334)
> > > > >       imx334->link_freq_ctrl =3D v4l2_ctrl_new_int_menu(ctrl_hdlr=
,
> > > > >                                                       &imx334_ctr=
l_ops,
> > > > >                                                       V4L2_CID_LI=
NK_FREQ,
> > > > > -                                                     ARRAY_SIZE(=
link_freq) -
> > > > > -                                                     1,
> > > > > -                                                     mode->link_=
freq_idx,
> > > > > +
> > > > > + __fls(imx334->menu_skip_mask),
> > > > > +
> > > > > + __ffs(imx334->menu_skip_mask),
> > > > >
> > > > > link_freq);
> > > > > +
> > > > >       if (imx334->link_freq_ctrl)
> > > > >               imx334->link_freq_ctrl->flags |=3D
> > > > > V4L2_CTRL_FLAG_READ_ONLY;
> >
> > --
> > Kind regards,
> >
> > Sakari Ailus
