Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E020711828
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbjEYUdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:33:13 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A118BB;
        Thu, 25 May 2023 13:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cm5a1xJNWl7CRZpDxXFMi2hus/62wFHnkuDLdYJzZ9s3P9YCxHx/EMO3qhUWsAS+GM29Zg20MMX7v/HpA0Fpsl2fs/p4NGd20CATHY0iBYCxAf/Az5e9ZrE8SpLk9VI3nwP8pNuqa7TNvy8OWiH061CTxDRaK+sTCf7Sc6VV8jW+HzwDlCSMqFwLXJJdptcXaNFT9oJhnpgSy3CNTXrusKADvhWutSYB1Us5omQSsEX1a539tcZcocikbX3Ybm0A7rmZUfKBKSzoHhau2NSNMFIzTzj6gxHPFIOFOoCTwk5rRQMeP9rwfCJpj/TQPXza3DJn9rUX8HQyMd165TF2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncpHNXk8UVcv7tvJJuDdeArgA2U/Dg9B2QNkjNcsnKI=;
 b=fIO1AhvbybY1ZnfDj9Wk0ad10IFzQcjmfdz/A2dmHNwuvT9tc/g+O2fEWJ+9SZ6WmBUi6B3/YlTSZw+yo39+viESWrZp4zPGLTPHSywEAzeaHQIJTZllGoeKWjXm4MZ7mT2/jsaBovvdVnCHFBnngcoJF3cC3vDyaS9GLq2hcAuLB6kF8YbGhOL1xBirk8wyeKk3z8tuRiInt/wQfx1dfxB33MzfDCFdl53AgVxSUSLOdkSrjze1Vj4o7MEAeXq6iY4Q2aSPy9/DBrgBK59328EYyoSrCqXrB8LHhbVmhM3nEkMsF+mIrJCozB8KZhqycWrxrEBfZhkAVnJKD6v+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncpHNXk8UVcv7tvJJuDdeArgA2U/Dg9B2QNkjNcsnKI=;
 b=Bc08h7J9bHNruFiZkZA5wXZnzue6MCeS7vhYgnx6FykJvxKmob56kRfkAh+81grrXznU5NHpPUq9WDtIh9EkRNkuDVE+OnMebcckg2okFhgF40BFxRpujpAyOJxkCTBe6zEb2EBEuC894giRQ3EacHBiccV5eSfgT0mGLsOWiKQ=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 20:33:07 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::2afc:49d2:3e66:75b9]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::2afc:49d2:3e66:75b9%5]) with mapi id 15.20.6433.018; Thu, 25 May 2023
 20:33:07 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Justin He <Justin.He@arm.com>, Toshi Kani <toshi.kani@hpe.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] apei/ghes: correctly return NULL for
 ghes_get_devices()
Thread-Topic: [PATCH v2] apei/ghes: correctly return NULL for
 ghes_get_devices()
Thread-Index: AQHZio5emEQw3LYlzkiJVNVJUUKJyq9rIvMAgABSPwA=
Date:   Thu, 25 May 2023 20:33:07 +0000
Message-ID: <AM0PR04MB62894F2D0B9BA5512086FB9E8F469@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20230519201249.31147-1-leoyang.li@nxp.com>
 <DBBPR08MB45386D3C1E4958A36FDA781BF7469@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB45386D3C1E4958A36FDA781BF7469@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|AM8PR04MB7441:EE_
x-ms-office365-filtering-correlation-id: 4fe91c15-c272-42c8-fc56-08db5d5f3f87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3X6s6HgRXbNuU7gHHIEmW+/0VvXMj8aecTD3lMIQl6JDpm3Rb5EuJIAh7DrBaJPqA3pNEp7tGUXczX2m0TPefLSaXXOLkC1EzdYWjQLCm0L/FQtBNtobERNH30HbNCgZ3eTZAg9mfC6Ynwj2mhe5ANmTmqVQzj8q8EqXT7/S9ic/yZGdpGOVStl5i5aO50cB7H7LRVXMAZmUQ8Y2hV1vVQFlZmq6fDvffh/GBGLt9XtzZ0mISuo/UxF2bPiGRjOw1RnUUcSaAR1O1Hr6yjGlMyOrkjODwUNKKtGOWBuPDKa0jGLmsy2iizL4+Vh6y3SBsQQpBzHAZ2WoZwwDD21Ov//Uo3QHVpSoFX8uvrGeEq+1qjiXo3u1Ql/ddhkP7I5Qv+M4jXwnGceHWlGX/x4ZqvAc1y+V/qbAH9/LCMWUyV3X8CfE9vJKOQ5KB84HMkpN/3Shf5vWgX5oAujqFk1Vf1AVJdntIREZAEAq7BNzdTy+Wvz0e8Iwgyv87+NMz32tHyJNPZ9cTyrUBolQWUkerVRBjs40AHVb+6atXoLcldQjZWBGvm1p8Z+QBoumTBCNMgxAdOj6TPDpZg1VvfYn+8vE/ljiHiWLR7TjtLhO3rS9ZonC8gehmQFT0IICmI+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(5660300002)(54906003)(9686003)(8676002)(186003)(33656002)(8936002)(110136005)(52536014)(316002)(4326008)(6506007)(83380400001)(122000001)(26005)(55016003)(76116006)(66446008)(66556008)(66476007)(66946007)(41300700001)(38070700005)(64756008)(53546011)(71200400001)(7696005)(55236004)(86362001)(38100700002)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fwly6+hDT1a3YxIvQk/PEIrk1wuNMA+NdKHIgw+w/OuNKmNnqIsXwCSraX3t?=
 =?us-ascii?Q?L6Fs8kv8HG/eAB/eIt1Z9Ik1pkqdbAU+qWnomQAFGVzsyF8PtIZpOEbQ8o7S?=
 =?us-ascii?Q?b7MOaXzPe2NzTrMkLHnsCOfdQ0cS6QOvLDBucD0EV243nFXN0MG6rHHrktkY?=
 =?us-ascii?Q?dB2sgjnpCRJanCh/9Z3xPlbDKsLWWiLehHOsvImv6LRutY4bHt6MnkOsipoU?=
 =?us-ascii?Q?a4KDLQqUBCIHx/8jGMQWR90tqOgrT1X+3QZT5KU2HYy0CYhPoU3bcz2MtSRD?=
 =?us-ascii?Q?XbVL/v/WzvQb8hZMS95Lw9u5D7Q+Yqj5mrY/wjp/lM9OR0d5AMBS9ZSbFPN1?=
 =?us-ascii?Q?h/9fyPzEpejdSGnS1iuVWyrbeX2mKWJWZtsV3FLfQ4l5nyQqx5jBoeE7EStP?=
 =?us-ascii?Q?fTnGD12PMMMWTabP9L1VoSOt82ZZNg+6srn4iRu/BjtihJ1e6wgRvGEmUTzX?=
 =?us-ascii?Q?9q6P+BAdCmetBsfBMqHS1pynkVlymkbB7DCQ7N93mDgQkGHN2TfkqWBsNQzG?=
 =?us-ascii?Q?EHD1awKNXXlKcATXnt3mQKqN3YKpiVD8HozhJKJVAnaJBxGHm1GhNK6PnwS4?=
 =?us-ascii?Q?sTVbjoacJ/fN9Iv1Jvg9fZKsw+qY6pXBkVhQQ9/dy78po9Sb0OX2R/Q0iMvd?=
 =?us-ascii?Q?CwN63Nqul90GxeYNBgRqzIv4aYpXetracEjeF6G7Was4AW2IUeJH7/ix2SsD?=
 =?us-ascii?Q?zWVJore4GyD+MNBdHm6hIg1Y3dErxmY32FUQzQhDQQpyk3GaVvEXGorb0Z95?=
 =?us-ascii?Q?7ZzK3qUF4mRJ4jkeKqGu5TCFzcsHrCuVaY0WIq7KOMe1cw1LnWwEcVZOo3Eh?=
 =?us-ascii?Q?oZsfBX5pHDb770oINHzMIpvZ+JNHcNuW9Q7gVL/6RdncBpYS4CzpdXuK79WY?=
 =?us-ascii?Q?LIJi2uz8DRgjoXOlaSVNWyvM3h4CLdSk+DNmtHujXbM3S4jyJKmYYsyg1ToF?=
 =?us-ascii?Q?CAvHC6NXBDDT3q3glICvOEHQpTD2YbwIlgCCLjuyU8h56cGss+cyY4xcJ+R4?=
 =?us-ascii?Q?HpY1YGbhoKzZ+bE4WQlHZnLdlTIhJrLEI6LzK2HAWB/eDkQE6sTT8fEo3UeZ?=
 =?us-ascii?Q?dQgi4c3oiTPtK4Q/kMf+kJZBeU1D/wXO77GIJd1KgvhPnM+HXzm4Tl1/iaZ2?=
 =?us-ascii?Q?r/XeIZX+/ZcQNBD4NHI54f4QWglFx7fpcNoxL/VfAzcEnoHxu+vXnIAbXDAG?=
 =?us-ascii?Q?44H7Z4ZlIpByvKQLvE61JGqcbLmuzSBxVVV6jQzkyjL1YsqAwDzfikLc4A6M?=
 =?us-ascii?Q?36oTfFesJTKe8sdpOiWG8DJ1+g7shd4fRm1ltpqPnKEU3Yal2QkFVTEDcnwp?=
 =?us-ascii?Q?vhRz7sXQccdgL4ptYDiFFT06YWmHWU7QDDZOY0m1kjal4xabktZgEwk3kebH?=
 =?us-ascii?Q?XmourUSG5xaRNZdLJFfwEgpOnYHp5aV5nyC7DjKl2iyqGpk/1SkXSYrEHr5c?=
 =?us-ascii?Q?So3jBth1WW9hXhXJongCnk3oEMc84iRsUp8blpUAfnPTd6Ngi+MewnWurSYo?=
 =?us-ascii?Q?KujYh2HQ66da+0t2a4NmjlEKVmMdkCc+OVXuz0KpMrCI83EutrVLsPcNUCCW?=
 =?us-ascii?Q?Gurdb1a7iRHV6658p7nP3ORCISuBx4y64Gz6aFBK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe91c15-c272-42c8-fc56-08db5d5f3f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 20:33:07.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5vRDu3AAKK7PekxSG3S3XNr8VAZWLT5nfGiotAc9ZpVYJipnmj1/LhsFh6KKWp10a2hfmzSa++EIUCDjBSGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Justin He <Justin.He@arm.com>
> Sent: Thursday, May 25, 2023 10:18 AM
> To: Leo Li <leoyang.li@nxp.com>; Toshi Kani <toshi.kani@hpe.com>; Rafael =
J.
> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; James Morse
> <James.Morse@arm.com>; Tony Luck <tony.luck@intel.com>; Borislav
> Petkov <bp@alien8.de>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2] apei/ghes: correctly return NULL for
> ghes_get_devices()
>=20
> Hi Li,
>=20
> > -----Original Message-----
> > From: Li Yang <leoyang.li@nxp.com>
> > Sent: Saturday, May 20, 2023 4:13 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>; Len Brown
> > <lenb@kernel.org>; James Morse <James.Morse@arm.com>; Tony Luck
> > <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Justin He
> > <Justin.He@arm.com>
> > Cc: Li Yang <leoyang.li@nxp.com>; linux-acpi@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v2] apei/ghes: correctly return NULL for
> > ghes_get_devices()
> >
> > Since 315bada690e0 ("EDAC: Check for GHES preference in the
> > chipset-specific EDAC drivers"), vendor specific EDAC driver will not
> > probe correctly when CONFIG_ACPI_APEI_GHES is enabled but no GHES
> > device is present.  Make
> > ghes_get_devices() return NULL when the GHES device list is empty to
> > fix the problem.
> >
> > Fixes: 9057a3f7ac36 ("EDAC/ghes: Prepare to make ghes_edac a proper
> > module")
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > Cc: Jia He <justin.he@arm.com>
> > ---
> >
> > V2: fix the fallthrough case in x86 path
> >
> >  drivers/acpi/apei/ghes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> > 34ad071a64e9..4382fe13ee3e 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1544,6 +1544,8 @@ struct list_head *ghes_get_devices(void)
> >
> >                       pr_warn_once("Force-loading ghes_edac on an
> > unsupported platform. You're on your own!\n");
> >               }
> > +     } else if (list_empty(&ghes_devs)) {
> > +             return NULL;
> >       }
> I have no major objections to the fix. Just curious about the edac driver=
 in
> you platform.
> IIUC, in your case, CONFIG_ACPI_APEI_GHES is enabled and edac_ghes
> driver is either not loaded or fails to load. Is my understanding correct=
?

Right.  ghes_edac is loaded but since ghes_devs is empty due to this platfo=
rm not using ACPI, it bails out with -ENODEV very quickly.  I would expect =
the original platform EDAC driver should continue to work in this scenario.

> I wonder whether ghes_get_devices() can unblock such check condition and
> let other chipset-specific edac drivers continue with the initialization.=
 @Toshi,
> What do u think of it?
>=20
>=20
> --
> Cheers,
> Justin (Jia He)
>=20
>=20
> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended reci=
pient,
> please notify the sender immediately and do not disclose the contents to =
any
> other person, use it for any purpose, or store or copy the information in=
 any
> medium. Thank you.
