Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D186A1AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBXKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjBXKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:55:11 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10E45848F;
        Fri, 24 Feb 2023 02:54:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfmmCJaksmx8znpLm5uO/KvyMwb47hlLP8tk2BJ9kDtx/2T/lsLLbItPYPzfyUsh7hp7PvwIQDyeBWNSkz0sTkvAbevzwWINEQ3sO40U6usLilUEyC+cppskWmp3J+VLW4L8LQCsrjO+7JpY0gV208CDwt96uGFpbMriD+QXvvNz+tKJBAkv6XLaQxkO0P/Mtscw2a9kux5xDp2qIZRRPe/MIMRMrko7F5f1Z7nRa4SfCVNEChncE9iR9/ouRYJQ73kf7dpC7Q2B5I9NZDxtSBstHflyU7Su+zQi4YE2sZY3oCwcQFQnc2LWX6d3YEo0yPdSLqPMbBJlHkdjKkpGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8XmVxurwKCUdM0vIemCM+Z22mR4h9VbuTCpm5Igb/8=;
 b=PoOHLwMDZz3K55gpzQ3xv+7zulcKh1Hi/gb4S8rQe8lipmKYkTrpDqgJ6crtb2kKKYEgBdQgna0xFN8pb/xWaHEIXvSuCkMnEzCFGEuS9MaRvscu8E6iAo55tH5NJ8/iWOrrl5zC1JZWbJ+4dAag0iTjwqQkJjxJes5SQ+7i1roZwfO8marsNqlYlv9MY/ExuIXSQPjMDIAzdRQ87PnKbSzvLETzkKhna4bo877Z7eLFwgsLXOh4xRSQwpmFAl3VfNHSTSmZV2/yWASIK7obFVOqCzEiP4j3EcqQu8k0e18LGlyZycXisRmkJ1eSPGIUjxAmz7RzOBb+2ikJAiB+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8XmVxurwKCUdM0vIemCM+Z22mR4h9VbuTCpm5Igb/8=;
 b=iPp93AZk754kWF+QuGOdLcgHn5FRlOcpvOnMAi81RjMZQ6TS6LHfQDLW1hIPRlzaiezHiFwBQ8QD6PQsIxRHm3N2mWfW9ox5eIzFWRB/l+qZA2lgjJFNa+7GHE/gRKEvbZmApVUJYSVcnNtC55Qktm5+fC6l4WiaAcTjIP3P1Ag=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 10:54:35 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 10:54:35 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Thread-Topic: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Thread-Index: AQHZSD5h4i88ZjQ6SECLRgRO4tCkLw==
Date:   Fri, 24 Feb 2023 10:54:35 +0000
Message-ID: <VI1PR04MB42221B1708BA02B1FA2149D9E3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-2-chancel.liu@nxp.com>
 <506f92cd-7cf5-4fd5-a930-9af086732f84@linaro.org>
In-Reply-To: <506f92cd-7cf5-4fd5-a930-9af086732f84@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4222:EE_|PA4PR04MB9687:EE_
x-ms-office365-filtering-correlation-id: 5483e13b-bd62-457a-8ecd-08db16558469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kzlAJPzGhoLqcZAuz+6ZUG9TFLaoJP4tv9kEZe1RYyOAf/9fQHsnz3MGQEVTgWFnhO6dV8PXjk3YHrbG8ZNgDoj/GFKEVOfL3IsmgIxmlSMSz47R7SmZrFKoOYUgiDWFMatfP1FahSSfutFYX6Ysu7OodoWDuOhiBEJ2POQ9L2qucBjuQN044u84fzUSG/rPsEwlWbGjb/UT4Prbgx4a9zebwZdk5tAF+kAkJfHiHyp5y3dnDm4VZ3FJmI8NX6o8xOg8qLaDI+uIQ0VV8n1juVO0oW+JHm1Bnuf/OKGksTShN1G26HW9GcHMdhT8PVXunv1W/qPPzs403IYy9qTZUGXPCx1UHwbG9kBQc+2BozgwbNHVzKYlJs5fHcZ/QxcIdXj2GuitLzrxu0/dw9QaB4LD4wii7EJ68aY31ZpHK8SLh3S0LrQ5dyq23CqJIMmfbdEIZQYdd4mjWkyi0rtW7K4xdLCuQujUnUCvRq9SYFLlkqz4g0pDuorVPBc8aQLN16//r1ZoIrtkQB5LMC5AJTR2bE0MPLrcHdQVREgwLRHsJtuahnhh8rftQcI6TO4+P83sRqIfwX/e79LBhtiIOhZEu6BwiFnwYc7jgOqbRmrMLN/hKCLevEf9pDObYUnvjYwPFkhxdbnnmE+7iA8jdDFkme6EP7Fca1BbHbZSdMOHFxZiZg47DvSy/pLGhlbda5SlfqjasnKs6/+LR/URTST5uMlj0tlkPXXPIhATBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(921005)(71200400001)(110136005)(316002)(478600001)(86362001)(7696005)(33656002)(122000001)(38070700005)(38100700002)(53546011)(6506007)(2906002)(66946007)(55016003)(66476007)(8676002)(66556008)(64756008)(76116006)(44832011)(41300700001)(52536014)(26005)(66446008)(7416002)(8936002)(5660300002)(9686003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-7?Q?CbwbJZQr6rJ6rEnMRjdLIVaVHyuGs8SEgND4EFU9iu+X/Ra73D5X9AE1M8?=
 =?iso-8859-7?Q?+E6/VNEbyiw408OzICxiJcEEp+eQ4wBhidDiWtnT41f5XTfIfsFoQGhMFU?=
 =?iso-8859-7?Q?S5a23FJS86DOnXi0E9KlmqaAyG1GxCkABcdgUyI2xYQuHLoCKb/4zxecOm?=
 =?iso-8859-7?Q?CKyIyUt4mOZjMfhB0YFmFeQKb24DgfTk03doXt0Z2V5P/KQX0O198B/X/W?=
 =?iso-8859-7?Q?w+ZCCmKLIT9cW0f/idlUiSk5yGLswmBTvT5kIN2hTTZXhw+p9S3f2YtFW2?=
 =?iso-8859-7?Q?0gSgI7OEjfFFojHne+sKJrBSs+cZgIwcfQk86GtjzuOMYq7szqm3KTmBI/?=
 =?iso-8859-7?Q?kWJxEC3UmeCPiq8xMHTayl6JHFoNUFauN5osMip1bBWHqc1zuQvMI2cVmi?=
 =?iso-8859-7?Q?f+4jR98r5I9eaNtHSvtxPQhR9fnOhlbevVFuZiUl5I1bhIu1HR2U4kj/SJ?=
 =?iso-8859-7?Q?Ceyc4mvrBSOneYaTthfKlsJBhws7leiZIRZzF4J4V2Qg20cpLEMRLPMcfg?=
 =?iso-8859-7?Q?fXsEG4CGh7SvgvdKvCzFN08zhcO0PUxwq8Skfy9jQimdStiJkNBetKFACE?=
 =?iso-8859-7?Q?IpRCIIgZJUo1ati0N+eMwJP3mTXgBJBEjoO9W1b+vSPf3akjdjAiBFwIOX?=
 =?iso-8859-7?Q?2M066sjgcXDcEPXjDJ59KeveWMPPl4LrUSWurv8FjlTbjN2XWzCI6TPM4M?=
 =?iso-8859-7?Q?Bg6XIneqZ91SRVDK78dBf9aOkaw9yqcVWUdH9lO1D4bh51SQZhtWqQORTW?=
 =?iso-8859-7?Q?FJFdFqcTS+QT4OJ0AY7LECbrdUl+pgbNuNTPpO+5jcunYyA972WXM5KUd9?=
 =?iso-8859-7?Q?bpA5+vuohTRCL5JtbHuqBwrT5eic4RjfuROdT86grVw2Zv1Xm8qFE+AGSs?=
 =?iso-8859-7?Q?2VRUpuK6txFosu3pNRDIBq3xhDlJ2b2A4uqlyFNDJqRnzMukOCZx9ysJF9?=
 =?iso-8859-7?Q?+PgBCP7CuZ4cN2DZ0OAXOieCFWUtle+zzVXXE+UN6hseHBYlPDTp3vQ9xC?=
 =?iso-8859-7?Q?ImLo/H6NvmAGMhDPvyFvzip9wM6gDSBWJYYJ2F5cQSzMaxwy6pN7Fx5345?=
 =?iso-8859-7?Q?DKfKKj9vn8oA8tAOOH7Oc0Am+eGFRlSoxuqCEmJZLBvIPJhgXbP7Xtt3Gi?=
 =?iso-8859-7?Q?qlplnQEIG5x4mn+TZt2Mdf9EgykO0TrIbxjVi1UwsW1IOb6E/E06Mfi926?=
 =?iso-8859-7?Q?zFqdmt1FiSvFDwtdrjR4yjcsBe5mJGvhpRUGn+1lK5STh/aI8gKWD/yWBH?=
 =?iso-8859-7?Q?6B3mn1IhPfS7RjU6zFDdYWC1nPHs6ANTTbnbTsB96CLhPZZJ6z1GgnVYy/?=
 =?iso-8859-7?Q?0aVvESiMQ5Wjkk6pqoCUEWZ8+R+5HfzgMoPp2PW+wLGKZy3dO8fTxM4jDm?=
 =?iso-8859-7?Q?wL0r0bbA4GKO66UHChJmMuHJOwmfS99fjZPMO9K+8W3v/U8Ol7FmyMWDw8?=
 =?iso-8859-7?Q?Ck+BUYuJWlUyDkf/QOBu+l43mi1TezF+oeJuPgsOSKRBQBty16IyIgxOoY?=
 =?iso-8859-7?Q?ZAd9mtjjyxTrFF2GFo/1mI/XYRerZqAo89/hVKRG7LOpoSlHXUu3enm2Ny?=
 =?iso-8859-7?Q?BflIXzrp/o5KMtfEYRSD5jIjSyNd+ZQyiAk9gKQ5FfeZgSu57Cz/78ijBk?=
 =?iso-8859-7?Q?PcTE/B9ylnvSAe7b9y5D3bLL7RlinILSEc?=
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5483e13b-bd62-457a-8ecd-08db16558469
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 10:54:35.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vys+1+b+cmV2FSIl1H8fz3iGsEyNrArcEIxxqzeZtBuhgfBFfBd6J/Ow6J9o/ciy43Gk9hNNlLpS86y/yS/AeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 22/02/2023 12:39, Chancel Liu wrote:
> > This property specifies power up to audio out time. It's necessary
> > beacause this device has to wait some time before ready to output audio
>=20
> typo... run spellcheck, also on the subject
>=20
> > after MCLK, BCLK and MUTE=3D1 are enabled. For more details about the
> > timing constraints, please refer to WTN0302 on
> >
> >
> > Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/wlf,wm8524.yaml          | 10
> ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> > index 09c54cc7de95..54b4da5470e4 100644
> > --- a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> > +++ b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> > @@ -21,6 +21,15 @@ properties:
> >      description:
> >        a GPIO spec for the MUTE pin.
> >
> > +  wlf,power-up-delay-ms:
> > +    maximum: 1500
>=20
> maximum is 1003. Where do you see 1500?
>=20
> minimum: 82
>=20

Yes, you are absolutely right. From the power up to audio out timing table =
in
WTN0302, the minimum number is 82 and the maximum is 1003.

Consider the following possibilities:
1. These timings may depend on the system design
2. These timings may be simulated results
3. These timings may be the minimum values

I set a larger value trying to extend the time. The larger value of course
introduces unwanted time delay but it benefits on avoiding beginning audio
lost.

I also did some tests on a board. If I want to work on 48KHZ sample rate an=
d
512FS, the recommended value is 143. But the test result showed 143ms is no=
t
enough. I increased the value to 500ms and could hear the beginning sound.

Maybe it's a better choice to let DT set the suitable value? Is there a sim=
ilar
situation before?

> > +    default: 100
> > +    description:
> > +      Power up sequency delay time in millisecond. It specifies power =
up to
>=20
> typo: sequence?
>=20

Sorry. I must avoid these spelling mistakes.

> > +      audio out time. For more details about the timing constraints of=
 this
> > +      device, please refer to WTN0302 on
> > +
>=20
> According to WTN0302 this might or might not include regulator
> ramp-up-delay. You should clearly indicate which part of it this delay
> is to not mix up with ramp up. IOW, mention exactly from where the value
> comes (e.g. =C4t POWER UP TO AUDIO OUT TIMING table, depending on samplin=
g
> clock rate). Otherwise you introduce quite loose property which will be
> including regulator ramp up in some cases...
>=20
> Best regards,
> Krzysztof

Yes. This property is designed for power up to audio out timing. I need to
clearly point this out.

Thank you very much for your suggestions!

Regards,=20
Chancel Liu

