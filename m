Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C868DE7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjBGRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjBGRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:06:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FFC3BDB8;
        Tue,  7 Feb 2023 09:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHnCphjPH29KX8iYC/xjvueppCYmbIYfQYzrajH0t3bBjMW6FJ7H45HbTiR7DzmimgUTF05/qcr+olImmCneqVeAMqvJg5Hm6VzneP6vUJ+/XDvKYm4eHgf/tfmX3WE1cyBv+YPlgaFl547sVwOYwGG05dTs7hTjrZK3C0RioE2Dk/Objf6SW9LIzOdC6CmSXUAltGnTdWBIAVBlR3R3aLUpMq/8tIZgb/e2mZjUhtuR/ceGZeEL79Rr72w8omFZkdbR7iOUdGVlfCvMO6MPCDsOndbDbEQ4S//3ATFLueWrx/Qoy2E+HKv4jYtCtoMTiBxE3rDVcbJ4u0nHX6Zg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46bg7lcpAJAeUYKMWGM4hrhrwU71/Ejlonfkknk5RiU=;
 b=Elwbi6Yrm89rSx+YKmbQMj9SU3ZQF4T8DW5RgaBjWEbCtgJafDH+mhCSguf4S7+sMk2Wqjvz538FBg8YBgx6XYO/D9oZuHn2e/hEjOXtP4sqJx7zn/CMhE6ERtlvEtHHL77UA8VJ/jNKrnS+7fkff8ebOlJZ2Yqp7ixdbtK/DyfVLRjiI5zSFYxca3EWOB6hC77VrsGo18ZdyIJcG9nL4LPaGwijVf5btEicGmiwQO1h/wDK+PACBTV7YSalKIV4TbO/ELUP2qUIbaH9BhCBTbly+aYYk/ofiEZ+90kFVJ/fMbB88E88LCvH+TuDGUfkovsbsMTjDtrg+ZtF4wLO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46bg7lcpAJAeUYKMWGM4hrhrwU71/Ejlonfkknk5RiU=;
 b=AB2ImALCJmd5FX2sUDZGPU5TwUZhDO0qKFnVjmB36dMGfwSiLxQ+qxGz11mRmvVNi6f2jz12NYEMxRoB1le2QzFZK/LiXrXBfx8gIET8n760erJV/5bh+JZv95UJrPypLcVxEs+kDS3vhE3sBPogwTCaEmNsBcLM1/BRZOSAnTU=
Received: from LV2PR21MB3397.namprd21.prod.outlook.com (2603:10b6:408:14d::20)
 by BY1PR21MB3892.namprd21.prod.outlook.com (2603:10b6:a03:523::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.2; Tue, 7 Feb
 2023 17:06:03 +0000
Received: from LV2PR21MB3397.namprd21.prod.outlook.com
 ([fe80::869e:3025:120d:4c91]) by LV2PR21MB3397.namprd21.prod.outlook.com
 ([fe80::869e:3025:120d:4c91%4]) with mapi id 15.20.6111.001; Tue, 7 Feb 2023
 17:06:03 +0000
From:   Jim Minter <jimminter@microsoft.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be
 in Direct IRQ mode
Thread-Topic: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be
 in Direct IRQ mode
Thread-Index: AQHZOxZ1hJJ6slA7ckCXoaE1mkjobQ==
Date:   Tue, 7 Feb 2023 17:06:03 +0000
Message-ID: <LV2PR21MB3397C9F4F2D37FA0B7BEE932A6DB9@LV2PR21MB3397.namprd21.prod.outlook.com>
References: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-07T17:06:03.383Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3397:EE_|BY1PR21MB3892:EE_
x-ms-office365-filtering-correlation-id: 5e2ca38a-d39b-4acf-abe7-08db092d986e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOvb91y90UIRXWKY9SVm4P2025JbKWoAjaXw07ZU+CodooqCRqha6Iet8VHr7onfhZgv2JuZ3sQOKQwBcL3Q9C5DrQIpDt8dT2gxUQKbGXEsdQ0SXH7kCWq6SBxC4t9XmbDYSEGSMmk6Ez/4hRhPGdE3oNTg/b54FVrg/dgU1YncS0QXV4pOhYiNOv+3StkGCDzil5YgblibeDFUDspQ/1eZoe2OiO3Gav39XDfRWCDRInsSlRJp+L1RRoaAxABkus9eVj6pGVqbyTSe1HW25mz+pUeW9vJx3grGNSNsIzeOzNqLluvD/DIv4M97iHqf96NE1FDe5MBnC4IAOWSnj4+ScBa6bIA2u3sVjwvUiTMOfhxVOTsNlZrw/X1WeYlWLiloMOJGYjde5UTqke1KqoQ8F47Oj62Mz5sV0NOdF0EA8zK6VCQPYfVocwqxSWxixBHCAzXRoRLeTVciTquicEArciClnzFcAT3JHylDr4d/U+WgQT26jAky8fH65bVovSgFhKbQ326khlbXMTKHzjRK6ZgZ0qC2CHpkb3ZyTb8iw1n7Vs9w/ApTHyejwXGLzA/LG5RGpnGkv4xAeFFFREDpe9szLPor6rPt7n8VgzCeYDBIzE7ajB907nDQmfMKkaTTt/XXVccjauHORfbglLRHGHqCnqu5/Fg3Ro3tmHY/RLq43UhuvUxYTDH8coYYeGQ39mGc5s2t71I1zBYTvcvVvQufJMTfd04HJ1MSukL9IW7PEIsUHZa6UP/M1Qhk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3397.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(8990500004)(38100700002)(82960400001)(82950400001)(91956017)(83380400001)(38070700005)(316002)(122000001)(52536014)(66476007)(66446008)(64756008)(8936002)(41300700001)(66556008)(4326008)(8676002)(2906002)(66946007)(5660300002)(4744005)(6506007)(53546011)(478600001)(76116006)(186003)(26005)(9686003)(86362001)(33656002)(110136005)(54906003)(7696005)(71200400001)(55016003)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZjFXjsWOBIAvqmCr/tPVcYGQJ9fOQy9NSWGjYpnsTatH0dtihichFTvLtw?=
 =?iso-8859-1?Q?JO6LBfTop2oQ5jCqVxEZZVhK7Rzh3JrZE5+xDyk71JxztwoS/1FAegmyMt?=
 =?iso-8859-1?Q?Q4ALaQQ7KpjyEmbHxWasCDdGQ6/50g10ecuCITU/GW08X0h7ZpOzJk/8Po?=
 =?iso-8859-1?Q?YSC+1yjmivvrWvlyd3oK7VQp8j2LQWfCHLY0PJyhshsplJmX2MNwRTilBo?=
 =?iso-8859-1?Q?YbJ8qnq6/bHgSFNmdr5IgDm9gkZ3tzKHkgYCgnCuoSFHenxbLlpTFFvU1j?=
 =?iso-8859-1?Q?J/g5TcM27XrNfJ/wXkCcPIRoeAJ2Izls8UnIQ0CzIbaqPXUkfXrwCmW8YE?=
 =?iso-8859-1?Q?2/gyw8fdepIW5jj871OsBRgxfaekXcFkdZIt8UsL4UdOIB1j5gQTq4/AWf?=
 =?iso-8859-1?Q?5A0mmFlRZ8It1zFCG0+BheBBQKiX2/WAFHGazWhjrliYii+ov+YToqJIgy?=
 =?iso-8859-1?Q?NYLFlfLJyE6esb84gQVVusUrg8fULhpfaeI2iVktVUyEqTDNOrhbiwQPEC?=
 =?iso-8859-1?Q?IXs7/3wycFeWo5/sxT7YW40a521HJQy9mupq2F0Wnb/XXe9vEbxekiZh9q?=
 =?iso-8859-1?Q?8gFjroyyhNY/RXfQbHscwQJEvPHcOFkK5wNBIxLNko3HyEzIjWy3DWQSbo?=
 =?iso-8859-1?Q?InSVpzKGZhldoXUdJ3NcLDSwXaRqpx2TEqNoyLHacfldNP1dr0H5xixOO/?=
 =?iso-8859-1?Q?tmJS0HURQp5JZuVdmHFUnrjvvi1FzXlSn85yUX6tlz2F574RIqz76iQb7E?=
 =?iso-8859-1?Q?mKxUiMwlwfqRTkQbeizJaMt+AYAxOL0fnDPzxgHUQOhJKjRq8y7L++XrH7?=
 =?iso-8859-1?Q?Efr3kDmD+xN8qapxUrBaCMfXWXLiZuC+2fSzdzGTbfHP2NgMHhddnPEdJF?=
 =?iso-8859-1?Q?i3u3uMgyDlneqcu2n8mx+Abe7lqF1EbKwqWZ/WYj/1NXLgdjigChoBVtI5?=
 =?iso-8859-1?Q?l7hcPQXkrBIEFocqJZm3B9qnIWU8ewkmzebHoP1/zOz5dK9Pwcj6cVdVE1?=
 =?iso-8859-1?Q?GaZ5yMySsRNj/WEygenWPD5oUhFDhcI4RS8tWzZas1nJo4QBwwxaM3JF0F?=
 =?iso-8859-1?Q?7mMkPa7sgFpw4alwERLdWShGB41JPbsfsKtKCEe2NXaq7FJX3mHSRAHFpO?=
 =?iso-8859-1?Q?caRhFryh7Qd77BFEfNRTGvnvPhtQvN1wNrg/MJjFPHJavup0Mvx5pzzOrp?=
 =?iso-8859-1?Q?nTFk+odNVhgRr+3fbYyNYv5u8nmtVECif9XU6JOY+XjNIHZogI24pBtlfa?=
 =?iso-8859-1?Q?m/+iJ31QtLf1dQXZeCAIS1QU0MFQ1xYnjv0/TTNQIlE/l69cuBLek5LWR2?=
 =?iso-8859-1?Q?D/IGm42GBEOysH2mmWrXO6h7ORaI0YhUBZZARN0sYwm9g520ReL6hqQaii?=
 =?iso-8859-1?Q?NlYhbP68nX52KniJGeDcNdrBvzVhC2Tv/gPbTcbjl4fH0UF6junREoKMge?=
 =?iso-8859-1?Q?jd0Ey15XG+DFZWp1/C/c1XjkLfANozLBfdmaSqtHVqSjMtHweEcCurlj8g?=
 =?iso-8859-1?Q?NhW2Zfc+vP5oGBmiGqmHHt0d8QwUDnDPchAvUGUfw6GoN/3x0U4femDhz6?=
 =?iso-8859-1?Q?r4jHdlRtBz+YTwAUnRHF69U96N0A?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3397.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2ca38a-d39b-4acf-abe7-08db092d986e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 17:06:03.8000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qruuJIE2BsoteFVoVbJJ/NnNyzFxLdWUTpY7fvkRPdp4V2c+pWlN7xi4kZqbV7ZMzz+c8XJji1aBmASDvHg9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 3:16 PM Andy Shevchenko=0A=
<andriy.shevchenko@xxxxxxxxxxxxxxx> wrote:=0A=
=0A=
> If the firmware mangled the register contents too much,=0A=
> check the saved value for the Direct IRQ mode. If it=0A=
> matches, we will restore the pin state.=0A=
>=0A=
> Reported-by: Jim Minter <jimminter@xxxxxxxxxxxxx>=0A=
> Fixes: 6989ea4881c8 ("pinctrl: intel: Save and restore pins in "direct IR=
Q" mode")=0A=
> Tested-by: Jim Minter <jimminter@xxxxxxxxxxxxx>=0A=
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@xxxxxxxxxxxxxxx>=0A=
> ---=0A=
>=0A=
> Jim, this is a bit simplified version than what you tested. But it should=
n't=0A=
> be a functional changes. Anyway, it would be nice if you have a chance to=
 give=0A=
> this a try.=0A=
=0A=
Andy, I retested this simplified patch and it worked fine for me.=0A=
=0A=
Many thanks,=0A=
=0A=
Jim=
