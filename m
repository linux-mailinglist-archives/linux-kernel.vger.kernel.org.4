Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5271B5EEBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiI2CbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiI2CbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:31:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127C11C165;
        Wed, 28 Sep 2022 19:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0MMkusCtuij1d7WD5k8Tx3z7/Oaxngp7yUXrRtbTeGkx2nWz3eOI/pEBIbz0P/G2koCk2ZWauyoQbQqLNnHzsqcUp2IV9Nr/t2cAo9Om/jyJjjjscuf1prxZhe8V9Bli0sveVDrw5ACDFDBz/KazndiLz5M7uQVKeBfMxBAqBJIrjiAoLicTPcbWKO7hOv9y2x9phG8xp1zC0/CtkUKLICEhdrQLVzYaCRBu+cTblRtt5/xqNSpNUMYfOXc/TLXlNEH73MN0JYmhnw8dR2z56DONzReRM0BfJo6wpFA7YP31mZUJSjBKG1aWFaNw7tNmUTK5BGoMGM9reS5C+1ltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93JHWeXWpMVlwwvVyEvNMjQbfSVMBMJ3hIMpc8Oc5nM=;
 b=MPbdW0f/a3g8ntlXG1wIy+fIZxmFMyJGOcLb/8bd5HEpHa0mGSEKByEX78QdTdRFY0sKsDxIicSI+Ez9YtG5PsCzciJj8IIXrWw1Yg3O2+YqvdeK+kGh5ru7JSM9C8+AE3DX9rHK+qedEfvQRnvWAxTwUw+4ldKe6Dwu1dv5/o6sAcFGpjv7HMyPuCCbvkPvH9SqsL6Xntbid4iFlYzTnqGWdbQXjmC11DxuYclA7ajN6cSpnxwdxJ8n3ggdDnRW9lkpRVX12OWDgy0lR7uerrZDpbqQKny+JZ5A5s3954HyUYQ/xsVQfeaq3H09c+jP+94w/tb4H48SeIPrBfJRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93JHWeXWpMVlwwvVyEvNMjQbfSVMBMJ3hIMpc8Oc5nM=;
 b=NVSr58o4JCkjaRqf8mXu22Eak4cZ3uolLn/jITIDjNBTrGAOXoGrRx0cjGtopiqlq7HGTSXfFN3YsfBerx/J1XRazANeN9S2afYacFoRrdeHGh4GOLDcMpvwFZEWhmFBIODjUXcsdMGU5xaPA+CcRgQlin2A2iRjqIN1CLoOJ+Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 02:30:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 02:30:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: RE: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Topic: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Index: AQHYt1YYYWV783i6iEKFTZ1KuPZo+K3yjrqAgAA2iDCAAQEZgIAA5feAgAAno4CAAH1+AIAAlimw
Date:   Thu, 29 Sep 2022 02:30:57 +0000
Message-ID: <DU0PR04MB94177A86ABF40CED54FFB2CA88579@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
 <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220927175649.GB2883698@p14s>
 <64c6bdc2-583d-a2d0-f8b8-c4487f8a4d97@oss.nxp.com>
 <65b7224d-d3eb-4513-d733-ec781864fb7b@oss.nxp.com>
 <20220928173054.GC2990524@p14s>
In-Reply-To: <20220928173054.GC2990524@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8216:EE_
x-ms-office365-filtering-correlation-id: f84beeab-850a-45fb-ae59-08daa1c2a443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKgR4WYxG3W9qYOjOWBNahCas4ClNC7Lcq2a5eLZFatj1SIAcl3P4mq7NykoFYfXmLBOBRxCtcyBVgwLbz4zwZXiIF59KskjN/5Z2ltFobnTl71sveJNt1WNKg8dEK3zPMjuoHKQWMR/YIBovlXthFotl4ODdyFDegu+LkLke2FdANnkbjBKNTWh8oWe/doVQGG7PyEcIrYE12nLhHNL2rZonnNQxJFie+kalq+l1QLk3QwwrEM05PTKTWuHoFCNX9L3zfYPmWtlKZrUZa0WbEt+X6W68xuexoYd3ddUe1+wmmBT5b90cwnVfWsEmPgHNoJYhf/bZRJ1DGcFE4S89gsl+7arN/7cqWXLuoTCyhHyKTF0YzmfgRCGY+zG/JZAoaS0dycRGpjlT6DSFi100Sfpz7TrbltMeUBGd6ytOiNk2IEZAfk//+z8vhN8DhwalaD2aTKIwjM5Je9RkIEPrAApKNpNjXgKnN3U/Q0aC1nxWezXjKMWA2R9+lgN8Xni8Ik6utDHPQmglIKmByip8m95a7sYnLxK+Unzv/6JPVWQdRGseuNuHCRLqQAjz3Pesp7yUSzFwmLXfpQPQUMAvXdSdRMzPe+g38jBQKc+EB7X71DB/s/0FfTuOwzNqFXVYS8KsSsgGPnh0JrxuTlFp8MC4yZG9ybnZIeJToVenoLOrqbjJDDAEQF2n7UMqmDAqsEi/MzHw8AtW5jmzwXQpDgsNLPRb7fsfdRPi5/nbHsLr+Rec5Plk51uNJULkr6p8YIT6xa1uS1hk7aj3hji9hPKSHuADQ6vyIa/6pFa+cI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(122000001)(38100700002)(38070700005)(86362001)(55016003)(33656002)(7696005)(6506007)(41300700001)(4326008)(64756008)(8676002)(7416002)(5660300002)(66446008)(53546011)(52536014)(8936002)(66476007)(66556008)(110136005)(966005)(478600001)(54906003)(26005)(71200400001)(76116006)(45080400002)(66946007)(316002)(30864003)(9686003)(83380400001)(186003)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZgnBNRzQJoTqYW5B33iyMgh/pmFy01HNdL3Dhj1VMYFGsAQIkcaG/KlXDk?=
 =?iso-8859-1?Q?avaz+6W624RFrrJGbpee98NC5awesE0mcI/p1L3KOki7RTpLvk74b1v0Dp?=
 =?iso-8859-1?Q?skQ4fpUVa3UwiW8aAy/wIZDP6wnVPB5ROX1aT413tI0YcipnPSx8tIDa8f?=
 =?iso-8859-1?Q?xGR2aZXLmFY/zuFp97EDSgR6KpqFsSOO+Xvnq5fC7zA96RWdYGI2DPMqdU?=
 =?iso-8859-1?Q?9kRiV54U4Elw9xctykRbxbV5Ir1Zm1rBySywri81WUpt3AtCwEG9peI1zo?=
 =?iso-8859-1?Q?MaCcFwvWAituZF+8filTof1j2PIYa2X87hgFH6MXRy7qUrC4pF7gn3Z/R0?=
 =?iso-8859-1?Q?LzyGVKYHfa4hTj9ifW1v5KRaQs4okWCDR1gOoAXLS0HyhCaAJqGFraJhYB?=
 =?iso-8859-1?Q?cCkqIq6r0KBiFYXDiuEbDx3T1/nhn2Fhfw128aoO6Mm5Jsf1K4cM/7hOIZ?=
 =?iso-8859-1?Q?2wv8gBUsn1vk+hulm8YZHg+qpNtH0NZUkiQ5Brq1nMeldXQM4nA29joJ3Z?=
 =?iso-8859-1?Q?o8qodmdQAM4SHopE63jc7gnSn5jVFJkrQnjj/1t408gCUqVDauBvkQUN3a?=
 =?iso-8859-1?Q?35TSmHGmgVxflqxYR5c9N+mxtSjtERPDjCUadYz7EkT1a71IipsYIBts7U?=
 =?iso-8859-1?Q?fZ9OSOczQLBO/uu2suhdCe6533MyG0vLjD+5IPXrtQVBhIMihPMQa46aww?=
 =?iso-8859-1?Q?IePWiJ/Km+EDvMifn/kTQJB2AXOqnHoREBz4gyd3yAR9hoKzwVX+RAxOin?=
 =?iso-8859-1?Q?bI7uASxKt2app0JvK1oYxsjwDB3riK1O8BLaZ4UDd4+p1HQT4yhEdMBnN9?=
 =?iso-8859-1?Q?vZaM4SQ82pKoZ/9HEhF92aBjnoCLCKwLWoFWD5RoWOBWgKw+rKGrPhDz1f?=
 =?iso-8859-1?Q?Yhn6kAj4qmqVC78D3I7IGA7LKm3SS5KIhZDQhmrXlT80uSCDuIIHPUtXXD?=
 =?iso-8859-1?Q?CS0qvseGGzmeFl25nUOqJ0LlNbIhki6pL4fY9Q/RzK+U727g2y15vpxksY?=
 =?iso-8859-1?Q?VXnQSgXl/ce1UAMWUXM02Z7RDcHBCks2E3uEXu+uvwCuprZLJvgXwlLFcC?=
 =?iso-8859-1?Q?X5SdwiHCxaSIv448KYRVnITN4q447Jq9suzZsypdsDOS/aBDYem00hWbit?=
 =?iso-8859-1?Q?xtMJYeBFO8LELyT+W+q6GR5j2M80E4B9WGZ415s8Ym9iGgzzuDpgY/FQOk?=
 =?iso-8859-1?Q?Wszg4puYMMQxMkxlTFuHYk32765IP81eSis0SWTJ144GLrzJWdKSeOKeJ/?=
 =?iso-8859-1?Q?fHEghx9M+ozp+WoQuRRsMmO08+a6RIgzQ2bQWdCAbuQAbsTftN7lKecb7q?=
 =?iso-8859-1?Q?oONzH09xIWl1u73kOro5yy2uhKSAIFccTyGRv5MmExDGCd2765XtqJ6d8r?=
 =?iso-8859-1?Q?rcnOMwKvgkwNjS2k9WGMRCT6IKPM41wytgoZ0p7MxFNtJoPpadtoJ6MjI/?=
 =?iso-8859-1?Q?PvGa347fmdZ24lMhDjKU2wpRNuJ57h59aqeg5aoXNKlLbkNarDZiogM/Vs?=
 =?iso-8859-1?Q?kjHFcqPJ/lU70U6dM+jR2c6PHKf8+exEMXaqU5Mkpg0mFXjUxvfYUKkudj?=
 =?iso-8859-1?Q?igWnN2p14EVipP23L2x+ZnEmr9wk/t1ZIQHJrP/zUgwre++x5q/yDHkDD3?=
 =?iso-8859-1?Q?zsswKaQnepwnM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84beeab-850a-45fb-ae59-08daa1c2a443
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 02:30:57.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z37n20M9C/p5OY90bo+KTui2INj1rq1fTP07tShjMpGF/YN55tX+zO/M3D5/uoomIuz213S6e50hfeLw8YEFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
> i.MX8QXP M4
>=20
> On Wed, Sep 28, 2022 at 06:01:45PM +0800, Peng Fan wrote:
> > Hi Mathieu,
> >
> > On 9/28/2022 3:39 PM, Peng Fan wrote:
> > >
> > >
> > > On 9/28/2022 1:56 AM, Mathieu Poirier wrote:
> > > > On Tue, Sep 27, 2022 at 02:48:02AM +0000, Peng Fan wrote:
> > > > > Hi Mathieu,
> > > > >
> > > > > Thanks for reviewing this patchset.
> > > > > > Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support
> > > > > > attaching to i.MX8QXP M4
> > > > > >
> > > > > > On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
> > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > >
> > > > > > > When M4 is kicked by SCFW, M4 runs in its own hardware
> > > > > > > partition, Linux could only do IPC with M4, it could not
> > > > > > > start, stop, update image.
> > > > > > >
> > > > > > > We disable recovery reboot when M4 is managed by SCFW,
> > > > > > > because remoteproc core still not support M4 auto-recovery
> > > > > > > without loading image.
> > > > > > >
> > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > ---
> > > > > > > =A0 drivers/remoteproc/imx_rproc.c | 108
> > > > > > > ++++++++++++++++++++++++++++++++-
> > > > > > > =A0 1 file changed, 107 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > > > > > b/drivers/remoteproc/imx_rproc.c index
> > > > > > > 7cc4fd207e2d..bcba74e90020
> > > > > > > 100644
> > > > > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > > > > @@ -6,6 +6,7 @@
> > > > > > > =A0 #include <linux/arm-smccc.h>
> > > > > > > =A0 #include <linux/clk.h>
> > > > > > > =A0 #include <linux/err.h>
> > > > > > > +#include <linux/firmware/imx/sci.h>
> > > > > > > =A0 #include <linux/interrupt.h>
> > > > > > > =A0 #include <linux/kernel.h>
> > > > > > > =A0 #include <linux/mailbox_client.h> @@ -59,6 +60,8 @@
> > > > > > > =A0 #define IMX_SIP_RPROC_STARTED=A0=A0=A0=A0=A0=A0=A0 0x01
> > > > > > > =A0 #define IMX_SIP_RPROC_STOP=A0=A0=A0=A0=A0=A0=A0 0x02
> > > > > > >
> > > > > > > +#define IMX_SC_IRQ_GROUP_REBOOTED=A0=A0=A0 5
> > > > > > > +
> > > > > > > =A0 /**
> > > > > > > =A0=A0 * struct imx_rproc_mem - slim internal memory structur=
e
> > > > > > > =A0=A0 * @cpu_addr: MPU virtual address of the memory region =
@@
> > > > > > > -89,6
> > > > > > > +92,10 @@ struct imx_rproc {
> > > > > > > =A0=A0=A0=A0=A0 struct work_struct=A0=A0=A0=A0=A0=A0=A0 rproc=
_work;
> > > > > > > =A0=A0=A0=A0=A0 struct workqueue_struct=A0=A0=A0=A0=A0=A0=A0 =
*workqueue;
> > > > > > > =A0=A0=A0=A0=A0 void __iomem=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 *rsc_table;
> > > > > > > +=A0=A0=A0 struct imx_sc_ipc=A0=A0=A0=A0=A0=A0=A0 *ipc_handle=
;
> > > > > > > +=A0=A0=A0 struct notifier_block=A0=A0=A0=A0=A0=A0=A0 rproc_n=
b;
> > > > > > > +=A0=A0=A0 u32=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
proc_pt;=A0=A0=A0 /* partition id */
> > > > > > > +=A0=A0=A0 u32=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
src_id;=A0=A0=A0 /* resource id */
> > > > > > > =A0 };
> > > > > > >
> > > > > > > =A0 static const struct imx_rproc_att imx_rproc_att_imx93[] =
=3D
> > > > > > > { @@ -117,6
> > > > > > > +124,18 @@ static const struct imx_rproc_att
> > > > > > > +imx_rproc_att_imx93[] =3D {
> > > > > > > =A0=A0=A0=A0=A0 { 0xD0000000, 0xa0000000, 0x10000000, 0 },=A0=
 };
> > > > > > >
> > > > > > > +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =
=3D
> > > > > > > +{
> > > > > > > +=A0=A0=A0 { 0x08000000, 0x08000000, 0x10000000, 0 },
> > > > > > > +=A0=A0=A0 /* TCML/U */
> > > > > > > +=A0=A0=A0 { 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN |
> > > > > > > +ATT_IOMEM },
> > > > > > > +=A0=A0=A0 /* OCRAM(Low 96KB) */
> > > > > > > +=A0=A0=A0 { 0x21000000, 0x00100000, 0x00018000, 0 },
> > > > > > > +=A0=A0=A0 /* OCRAM */
> > > > > > > +=A0=A0=A0 { 0x21100000, 0x00100000, 0x00040000, 0 },
> > > > > > > +=A0=A0=A0 /* DDR (Data) */
> > > > > > > +=A0=A0=A0 { 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > > > > > > +
> > > > > > > =A0 static const struct imx_rproc_att imx_rproc_att_imx8mn[] =
=3D
> > > > > > > {
> > > > > > > =A0=A0=A0=A0=A0 /* dev addr , sys addr=A0 , size=A0=A0=A0=A0=
=A0=A0=A0 , flags */
> > > > > > > =A0=A0=A0=A0=A0 /* ITCM=A0=A0 */
> > > > > > > @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
> > > > > > imx_rproc_cfg_imx8mq =3D {
> > > > > > > =A0=A0=A0=A0=A0 .method=A0=A0=A0=A0=A0=A0=A0 =3D IMX_RPROC_MM=
IO,
> > > > > > > =A0 };
> > > > > > >
> > > > > > > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =3D
> > > > > > > +{
> > > > > > > +=A0=A0=A0 .att=A0=A0=A0=A0=A0=A0=A0 =3D imx_rproc_att_imx8qx=
p,
> > > > > > > +=A0=A0=A0 .att_size=A0=A0=A0 =3D ARRAY_SIZE(imx_rproc_att_im=
x8qxp),
> > > > > > > +=A0=A0=A0 .method=A0=A0=A0=A0=A0=A0=A0 =3D IMX_RPROC_SCU_API=
, };
> > > > > > > +
> > > > > > > =A0 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp =
=3D
> > > > > > > {
> > > > > > > =A0=A0=A0=A0=A0 .att=A0=A0=A0=A0=A0=A0=A0 =3D imx_rproc_att_i=
mx8ulp,
> > > > > > > =A0=A0=A0=A0=A0 .att_size=A0=A0=A0 =3D ARRAY_SIZE(imx_rproc_a=
tt_imx8ulp),
> > > > > > > @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct
> > > > > > > rproc
> > > > > > *rproc)
> > > > > > > =A0=A0=A0=A0=A0 mbox_free_channel(priv->rx_ch);
> > > > > > > =A0 }
> > > > > > >
> > > > > > > +static void imx_rproc_put_scu(struct rproc *rproc) {
> > > > > > > +=A0=A0=A0 struct imx_rproc *priv =3D rproc->priv;
> > > > > > > +=A0=A0=A0 const struct imx_rproc_dcfg *dcfg =3D priv->dcfg;
> > > > > > > +
> > > > > > > +=A0=A0=A0 if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > > > +
> > > > > > > +=A0=A0=A0 if (!imx_sc_rm_is_resource_owned(priv->ipc_handle,
> > > > > > > priv->rsrc_id))
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > > > +
> > > > > > > +=A0=A0=A0 imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED=
,
> > > > > > BIT(priv->rproc_pt), false);
> > > > > > > +=A0=A0=A0 imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int imx_rproc_partition_notify(struct notifier_block
> > > > > > > +*nb,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 unsigned long event, void *group) {
> > > > > > > +=A0=A0=A0 struct imx_rproc *priv =3D container_of(nb, struct
> > > > > > > +imx_rproc, rproc_nb);
> > > > > > > +
> > > > > > > +=A0=A0=A0 /* Ignore other irqs */
> > > > > > > +=A0=A0=A0 if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)gro=
up =3D=3D
> > > > > > IMX_SC_IRQ_GROUP_REBOOTED)))
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > +
> > > > > > > +=A0=A0=A0 rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> > > > > > > +
> > > > > > > +=A0=A0=A0 pr_info("Partition%d reset!\n", priv->rproc_pt);
> > > > > > > +
> > > > > > > +=A0=A0=A0 return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > =A0 static int imx_rproc_detect_mode(struct imx_rproc *priv)
> > > > > > > {
> > > > > > > =A0=A0=A0=A0=A0 struct regmap_config config =3D { .name =3D "=
imx-rproc" };
> > > > > > > @@ -689,6
> > > > > > > +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc
> > > > > > > +*priv)
> > > > > > > =A0=A0=A0=A0=A0 struct arm_smccc_res res;
> > > > > > > =A0=A0=A0=A0=A0 int ret;
> > > > > > > =A0=A0=A0=A0=A0 u32 val;
> > > > > > > +=A0=A0=A0 u8 pt;
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 switch (dcfg->method) {
> > > > > > > =A0=A0=A0=A0=A0 case IMX_RPROC_NONE:
> > > > > > > @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
> > > > > > imx_rproc *priv)
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (res.a0)
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->rproc->state =
=3D RPROC_DETACHED;
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > +=A0=A0=A0 case IMX_RPROC_SCU_API:
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D imx_scu_get_handle(&priv->ipc_=
handle);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D of_property_read_u32(dev->of_n=
ode,
> > > > > > > +"fsl,resource-id",
> > > > > > &priv->rsrc_id);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "No fsl,resou=
rce-id property\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /*
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * If Mcore resource is not owned by=
 Acore
> > > > > > > +partition, It is
> > > > > > kicked by ROM,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * and Linux could only do IPC with =
Mcore and nothing else.
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (imx_sc_rm_is_resource_owned(priv->=
ipc_handle,
> > > > > > > +priv-
> > > > > > > rsrc_id))
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > >
> > > > > > If imx_sc_rm_is_resource_owned() return '1' than the remote
> > > > > > processor is under Linux's control and what follows below is
> > > > > > not needed.
> > > > > > That is also
> > > > > > coherent with the comment in [1].
> > > > >
> > > > > Case 1: If M4 is owned by Linux, here directly return 0.
> > > > > Case 2: If M4 is not owned by Linux, the following code after
> > > > > this line will set state as RPROC_DETACHED.
> > > >
> > > > I understand that part.
> > > >
> > > > >
> > > > > Patch 3/6(this patch) is only to support case 2.
> > > > > Patch 4/6 is to support case 1.
> > > > >
> > > >
> > > > Let's leave the subsequent patches alone for now.
> > > >
> > > > > >
> > > > > > That is in contrast with what is happening in
> > > > > > imx_rproc_put_scu().  There, if the remote processor is _not_
> > > > > > owned by Linux than the condition returns without calling
> > > > > > imx_scu_irq_group_enable() and
> > > > > > imx_scu_irq_unregister_notifier().=A0 That seems to be a bug.
> > > > >
> > > > > No. The two functions only needed when M4 is in a separate
> > > > > hardware partition.
> > > > >
> > > > > The scu irq is only needed when M4 is out of linux control and
> > > > > need some notification such as M4 is reset by SCU(System Control
> Unit).
> > > > > That linux got
> > > > > notification that M4 is reset by SCU.
> > > >
> > > > I also understand that part.
> > > >
> > > > What I am underlining here is that when the M4 is independent,
> > > > function
> > > > imx_scu_irq_register_notifier() and imx_scu_irq_group_enable() are
> > > > called but their cleanup equivalent are not called in
> > > > imx_rproc_put_scu() because of the '!'
> > > > in the if() statement.
> > >
> > > you are right, this is bug in my side. It should be as below based
> > > on patch 3/6.
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index bcba74e90020..a56aecae00c6
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -713,7 +713,7 @@ static void imx_rproc_put_scu(struct rproc
> > > *rproc)
> > >  =A0=A0=A0=A0=A0=A0=A0 if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >
> > > -=A0=A0=A0=A0=A0=A0 if (!imx_sc_rm_is_resource_owned(priv->ipc_handle=
,
> > > priv->rsrc_id))
> > > +=A0=A0=A0=A0=A0=A0 if (imx_sc_rm_is_resource_owned(priv->ipc_handle,
> > > +priv->rsrc_id))
>=20
> Indeed, which raises questions about how this patchset was tested.  And i=
t
> is not the first time we touch base on that.

Patch 4/6 has such change that fixed the issue you mentioned. I need update
patch 3, 4 to avoid mix together.
-	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-		return;
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return imx_rproc_detach_pd(rproc);

>=20
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >
> > > Thanks for detailed reviewing.
> >
> > If you are fine with this change, I could send out V6. Anyway, I'll
> > wait to see if you have other comments in this patchset.
> >
>=20
> I am out of time for this patchset and as such will not provide more
> comments on this revision.

Sure, thanks for your time.

Thanks,
Peng.
>=20
> > Thanks,
> > Peng.
> >
> > >
> > > Thanks,
> > > Peng.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > There is also a problem in patch 4/6 associated to that.
> > > > >
> > > > > If the upper explanation eliminate your concern, "a problem in
> > > > > patch 4/6" should not be a problem.
> > > > >
> > > > > When M4 is owned by Linux, Linux need handle the power domain.
> > > > > If M4 is not owned
> > > > > by Linux, SCU firmware will handle the power domain, and Linux
> > > > > has no permission to touch that.
> > > > >
> > > > > Thanks
> > > > > Peng
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Mathieu
> > > > > >
> > > > > >
> > > > > > [1].
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2
> > > > > > F%2Felixir
> > > > > > .bootlin.com%2Flinux%2Fv6.0-
> > > > > >
> rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=3D
> > > > > > 0
> > > > > >
> 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
> > > > > >
> c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
> > > > > >
> 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > > > > >
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D
> > > > > >
> JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
> > > > > > =3D0
> > > > > >
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc->state =3D RPROC_DETACHED;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc->recovery_disabled =3D tru=
e;
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /* Get partition id and enable irq in =
SCFW */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D
> > > > > > > +imx_sc_rm_get_resource_owner(priv->ipc_handle,
> > > > > > priv->rsrc_id, &pt);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "not able to =
get resource
> > > > > > > +owner\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc_pt =3D pt;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 priv->rproc_nb.notifier_call =3D
> > > > > > > +imx_rproc_partition_notify;
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D
> > > > > > > +imx_scu_irq_register_notifier(&priv->rproc_nb);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "register sc=
u notifier
> > > > > > > +failed.\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D
> > > > > > imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> BIT(priv-
> > > > > > > rproc_pt),
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 true);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret) {
> > > > > > > +
> > > > > > > +imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "Enable irq =
failed.\n");
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > =A0=A0=A0=A0=A0 default:
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > =A0=A0=A0=A0=A0 }
> > > > > > > @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct
> > > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 ret =3D imx_rproc_clk_enable(priv);
> > > > > > > =A0=A0=A0=A0=A0 if (ret)
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 goto err_put_mbox;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 goto err_put_scu;
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 INIT_WORK(&priv->rproc_work, imx_rproc_vq_wor=
k);
> > > > > > >
> > > > > > > @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct
> > > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >
> > > > > > > =A0 err_put_clk:
> > > > > > > =A0=A0=A0=A0=A0 clk_disable_unprepare(priv->clk);
> > > > > > > +err_put_scu:
> > > > > > > +=A0=A0=A0 imx_rproc_put_scu(rproc);
> > > > > > > =A0 err_put_mbox:
> > > > > > > =A0=A0=A0=A0=A0 imx_rproc_free_mbox(rproc);
> > > > > > > =A0 err_put_wkq:
> > > > > > > @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
> > > > > > platform_device
> > > > > > > *pdev)
> > > > > > >
> > > > > > > =A0=A0=A0=A0=A0 clk_disable_unprepare(priv->clk);
> > > > > > > =A0=A0=A0=A0=A0 rproc_del(rproc);
> > > > > > > +=A0=A0=A0 imx_rproc_put_scu(rproc);
> > > > > > > =A0=A0=A0=A0=A0 imx_rproc_free_mbox(rproc);
> > > > > > > =A0=A0=A0=A0=A0 destroy_workqueue(priv->workqueue);
> > > > > > > =A0=A0=A0=A0=A0 rproc_free(rproc);
> > > > > > > @@ -852,6 +957,7 @@ static const struct of_device_id
> > > > > > imx_rproc_of_match[] =3D {
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8mm-cm4", .data =3D
> > > > > > &imx_rproc_cfg_imx8mq },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8mn-cm7", .data =3D
> > > > > > &imx_rproc_cfg_imx8mn },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8mp-cm7", .data =3D
> > > > > > &imx_rproc_cfg_imx8mn },
> > > > > > > +=A0=A0=A0 { .compatible =3D "fsl,imx8qxp-cm4", .data =3D
> > > > > > &imx_rproc_cfg_imx8qxp },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx8ulp-cm33", .data =
=3D
> > > > > > &imx_rproc_cfg_imx8ulp },
> > > > > > > =A0=A0=A0=A0=A0 { .compatible =3D "fsl,imx93-cm33", .data =3D
> > > > > > > &imx_rproc_cfg_imx93 },
> > > > > > > =A0=A0=A0=A0=A0 {},
> > > > > > > --
> > > > > > > 2.37.1
> > > > > > >
