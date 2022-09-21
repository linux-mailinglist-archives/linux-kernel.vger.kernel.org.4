Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA85BF8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIUITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiIUISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:18:50 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC7AB849;
        Wed, 21 Sep 2022 01:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD2q36hQYtwNHtrj/U0DX8W/JamMzisf0dOtA48/FimIPLeMN7MBy/FJS60WNh+xv1gQQLkUbj/jtM8fmcOhp0yEKVq28h/4m5eNOOS9YzqGY1Hfr4/U264KnEDoEMWTwKFGcC4Oqtqes16BNHgICLLeBFNFJ6MONcSQ/TRIxcWmwDx2bHcYBFD43v5/Gd8YPZILcA4bLjMl2eOJfhWOOldlkKI1RW1f5gU9MA6y/m13ITpVWuPaWZamnejTVaB77zVqB1pXjfG6BKMwHmwNsiAm4TzLvWCYcwv+STfBbMBtZQ9EQFuPjsX5AJ/i9I2KO0susdyRYyTtxy3H/9Darg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAeeo4tczhbsH0MurPmUUWvOhPNFpEPtlwb0qy0N0tc=;
 b=cVwJdWuFMby9w9qP3QpdwkH5cAa57ioYLQcFSzVD7+VulJL9EucfwoC3jbrfMtGXHf6qF5rn3l46oq/dIqRAlA5NllY6J2Gj5JqGFxIrinOAymKbHJdEari+EVXIpzXpTBexcKvcfO0KzQjfCU6y2VdJADkouc7OiGn6O9gM3zJQFD81UP9sxc0WA/b1alWlvkFUYb9m0pk9GIpRyssFZqtkzKwc2RG22psZ7t8ZCIkHzY0qhVXCa5Ik6gHLX1IKshlcggY0zKm4qo6EurlyoGn8Kz1Bfa2CIkLBl6qTgRcbz1M4hmiDvW4zd00GGfjehydpVfZ2SAagbdCTl1xtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAeeo4tczhbsH0MurPmUUWvOhPNFpEPtlwb0qy0N0tc=;
 b=S5MnWIBwEkFB0Q2muReXyYDoJ/OCP8ozzWuAreUIh6sC/LOkNh5mTx2y3oveFxOTCiYGsNcmNYv6c+pMjwH1P613w6h6tN5SizmvDrMeemjo3FQEmttfcrq+TzDyxtcuI/HBdAa/losuD2joQ2QMAF/ijSmuggdaGWN/BESaJk0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 08:18:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Wed, 21 Sep 2022
 08:18:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: RE: [PATCH v2] rpmsg: char: Avoid double destroy of default endpoint
Thread-Topic: [PATCH v2] rpmsg: char: Avoid double destroy of default endpoint
Thread-Index: AQHYzWBVgQ3cpYwrCEyw4uFZoIRr1a3pipYQ
Date:   Wed, 21 Sep 2022 08:18:45 +0000
Message-ID: <DU0PR04MB941748A5EF06062B66547D8B884F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1663725523-6514-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1663725523-6514-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7617:EE_
x-ms-office365-filtering-correlation-id: bff85cb8-30c1-49c1-cd63-08da9ba9e6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjoVXVmuWr/q5NKolD5CAoa7hsYvI4XW/5mDqwC1+o3DSbdl2n054z4Hmc+u8MkGHvj/sGyBJC1Wu/yEn6TuX5ad/BTwadG79H5siHhL9iCu21N7UUyjlG1Wge2TDZtfxLImEF2NBOzQxlIUVBBetjbNBThoAFwd8KR5x7E7VUr4qAKYOCMDUBgTALGZ93nfaIKD19/weTPIPUpoQF1CzYANU2RqCo9sIgEa9+AS16sZVr4DBwdCVL+6x9xkgkrEoQZA9olXXaa11mRnjHSW/ut/vrcXddEJ28gj5FXsZGSHOIDR3bfMh639aaYgoXb3W6Yoc7lVlkhHrlmv3xImKUQa3WhSJNdRxLlKv6kLZFezrSl58xeXcs7Kfdl3y+TiG4wMsYkRqnEehGfS0iTHhevslNUMv/UgN4B0S33fj9NUpofNtEcrWUO6IKSIvYS3H/cAY78pUCeFYCICahvRfD+OlYseDfMGYaTVXE/oH6kgfZpkAe3lGfaM1Nz7TWHqWKRQ4M6e5sRh9JqewwgqAiq3MXRcyT8+afXpHD1oivh/9gMLe2ZU7Jnut/DtHHupf+X6HQ0CYafiweKPik5fK8knQGvkpR1sPmnyiEErPxaApfIgXDQJ//SQbu66NxeHWBLGVtYEq0ShVPXmsnH+utb7gw/MHgnpDk2fIHCG8+UiLWjWl86Od/nEeU9SPMKocGyH1a0M+jVUjgDZmgrb0/vfgYTDESjvow8QhJrDhslFt53ahtMYXlfnqoLUrm/lMdqnS5xk6/VpE+ztKlE5Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(6506007)(7696005)(4326008)(86362001)(41300700001)(8936002)(26005)(66476007)(38070700005)(66556008)(478600001)(66446008)(54906003)(71200400001)(33656002)(64756008)(110136005)(66946007)(76116006)(8676002)(186003)(44832011)(2906002)(316002)(5660300002)(122000001)(9686003)(38100700002)(55016003)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kOHFt4EGrC7gD511KETxEfilq3Au68VqSAYJiS0i7t7Wi8zgjqA2sQ6WyPG/?=
 =?us-ascii?Q?ZwwmuNK2YEwdiV7kZPIoxqbTCwzEHl0w6UvA7PPCPP1iIVmwfGiXVvO17UvI?=
 =?us-ascii?Q?92tjuPXFt8GAfAK4294z6Ok9XytWeg1RPibPEF1DsQ3F8pmTf0rymgI4t2tN?=
 =?us-ascii?Q?7AlOEUBMMK6Lw88QnbeFut7iVV18AqOjskOlU6pqlnlVZ3FYJTW2jkfJ45FO?=
 =?us-ascii?Q?ZnsMpR/XC9bMzSzvM4e92Cv+t8Nn8EN2ogQdZ44GJqCUbsu+bhT7MkoDWymx?=
 =?us-ascii?Q?IAM+0+ItXbKRBeEQ/UcKLeHXNoUQJy+XQPWcChUGTQ6E/459wHqV0BYuQ1WN?=
 =?us-ascii?Q?DSu9c5evjs7bn0b2n+avDf7l/7T59oHEdtLVtNNXqI9Mz5vvuoHmRDBi7+4t?=
 =?us-ascii?Q?Eteb8V+Rmw+/46K0VcNrcNUjh19HV/og6acyk+D5xBT9lKFkAhKjVNwDjaYl?=
 =?us-ascii?Q?KEznWjiHxEVfw/ZnK5gMznPU5RCpShPpQhxb7yW2enavjI0spUsvOWVnbyId?=
 =?us-ascii?Q?Of1k1zSuZ82XMFzAM6EF1iit0ISzUSNpQ2D69YN5rjKoWqQrWKmcuVoeb11v?=
 =?us-ascii?Q?yuPdwH2qM2sIT5HFOXBILhmC4XW5Ao/pB8tBNhq3G7DGI5oPV8xLjxD2Aap/?=
 =?us-ascii?Q?HTHyZzwwnhqFZdKEB0GtACk8USDJUndNsIW833GAsIEqo37coifzyT9gev7P?=
 =?us-ascii?Q?Dk7fOvqJkQppuIJwb5T3jOsTzI/7oNSXyItGsarXRBjP57pNn9XZi3UgT55L?=
 =?us-ascii?Q?jxY76sctXPf3YiRu4W6K4rVGnQpU46EMoksc5PCz6GqpdWnWbeX++t9J0ZDL?=
 =?us-ascii?Q?WQJ8be4ql5FNfwJrPy+RonEeL5m4BU61tniB7wYprjrsLs4mYpgRsvtRkqPA?=
 =?us-ascii?Q?B4L7WB8kZfQ0xjyRcgQRYNLCQvmzXqYKosSkpz7ZYbKrK6js9Y5yUmAejMei?=
 =?us-ascii?Q?XS1KpgGOGE+Pt8XlQtNcEhzXInKpNjvNGcuGRhP1aqqhCwjpW03m4WupARHG?=
 =?us-ascii?Q?y34Snt8tLs6Bavedjb7XsoECZjiIaj43P+lQJ6svAAwoC+d05Rw71yFzAqFo?=
 =?us-ascii?Q?yAC6IcesYzzm26pcmkS1LcLflxUiQIycfzoFUdTvhLpIf199rccq9wSRseuA?=
 =?us-ascii?Q?rVDNFGf3IcrMzGzwLhXT5QaRGcDcpGwXob489j6km/kX9xe6r8uv12LcZZdU?=
 =?us-ascii?Q?f/g1qnmualyG9jIexQm7+zafwoefJpodVsDCr14BE9gLFd0FWa9lAIrD511W?=
 =?us-ascii?Q?PNU/eQb/FFIjuGrXTcUm4HCvpWp4LkXOvWX9UiWbeToUD0dwQTRnCZpMiAz+?=
 =?us-ascii?Q?0hkhcVQZ91+GGoGqRNfUIxpr+IlK14TGT+PFHsyCPl7cTc3/72aADwAGRFbq?=
 =?us-ascii?Q?+a/MpdeT7j0qm0sqd0g4ILOmYnhiMe6+mvJYMvU4TjnL7FK94MvTJ2raPsUm?=
 =?us-ascii?Q?wUTk4s1yasa4BdBhgHHUes6uQAQ3bMQStTltkalc9Y64qFIpk8PQR+K3MCM+?=
 =?us-ascii?Q?CQp7zbD2apGxR4LwZeGPVS4+TzjSCEL/WetdSzPjLSft3aGPZJg104l6Q8QA?=
 =?us-ascii?Q?RcJ+XZuOkHjjglQtIv0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff85cb8-30c1-49c1-cd63-08da9ba9e6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 08:18:45.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzOctORcuw+X+qOJ9awYm4H5RbTGXz201Z5hqsPO5GvCMKIgwSDT9o5i3jJAEX/EkzYW1lVstFgL4lP38pOl4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2] rpmsg: char: Avoid double destroy of default endpoint
>=20
> The rpmsg_dev_remove() in rpmsg_core is the place for releasing this
> default endpoint.
>=20
> So need to avoid destroying the default endpoint in
> rpmsg_chrdev_eptdev_destroy(), this should be the same as
> rpmsg_eptdev_release(). Otherwise there will be double destroy issue that
> ept->refcount report warning:
>=20
> refcount_t: underflow; use-after-free.
>=20
> Call trace:
>  refcount_warn_saturate+0xf8/0x150
>  virtio_rpmsg_destroy_ept+0xd4/0xec
>  rpmsg_dev_remove+0x60/0x70
>=20
> The issue can be reproduced by stopping remoteproc before closing the
> /dev/rpmsgX.
>=20
> Fixes: bea9b79c2d10 ("rpmsg: char: Add possibility to use default endpoin=
t
> of the rpmsg device")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> changes in v2:
> - Add comments
>=20
>  drivers/rpmsg/rpmsg_char.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 0850ae34fb88..3e0b8f3496ed 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -76,7 +76,9 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev,
> void *data)
>=20
>  	mutex_lock(&eptdev->ept_lock);
>  	if (eptdev->ept) {
> -		rpmsg_destroy_ept(eptdev->ept);
> +		/* The default endpoint is released by the rpmsg core */
> +		if (!eptdev->default_ept)
> +			rpmsg_destroy_ept(eptdev->ept);
>  		eptdev->ept =3D NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> --

Reviewed-by: Peng Fan <peng.fan@nxp.com>
