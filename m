Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42E76B86B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNAQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:16:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997679008D;
        Mon, 13 Mar 2023 17:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4FxbILFSClYRXtX6eo//5huqhN0LYCspOy/bn+HYkqfZT/i2xoPkav38mPOan58rn3KXfqCJuHURn6+MUR3/mLZDIvCoJso5jOKD+maS9f6+akO7v5WWtcu4PsVbAEWN+1rDsKAt4Pr+3RY4PI5/qwoIQBfDfbEX3wcEHdNamoJzug1S/+oR//FDXuyqYIDRT5q1tV/TYKurnWl5KaNFtRNgmiIMRCtHiEY1h5xnt2anwVZY4iar+G/Q4C7m5TfBI24imOMKAyhCYTTvyaTweAeXcDok7gkzHOmoH9n5pYOEsKeH5wCK6XkQp7waIU31osIUo6mSZ//hbfGNM5ZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXxjCNgNvMnOfTIk1VBgXniuIViFzGDngzNYJWhcwFA=;
 b=Jo9ZzCG0KL5F4aHQSfxGsqkzDK+7E6KdQnvH7vGxlEzy0Hxn1melhy5bM/0s38rqHHe29TLJ8d1G5yvNmIE00D6hgdHqYipRchW8cJvp57yAPxIr2OIDyaJx0oc2702mIVeMAhqh2fzjRhTGVo+/1lBZA23FPKiwywzNXQ7R9HGUCbp+J71G209ZpysjeFoMjGBdguTxyoDfTn7yYYZ6T91sl61Ui4u7kD3a8NDcZ4zhnT4y5vt70Z0rzPjguNS5LnKbVWG6B8KUOsoV+aOmvonkwzaRDZtokwCFHSCMOWIeU49JoFWvd0/p6O4N88mVh/7ytU5GG4cUCWe5id3ghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXxjCNgNvMnOfTIk1VBgXniuIViFzGDngzNYJWhcwFA=;
 b=laAX8++ZFUOBj88t7xzP8SeUg5MYuM1EQ69TM8FAgYn5qc+ayYESdm6m9fPJbpbyu9ZLTvtNa9glHOGU5ucurGzTOM4+0qKGCZhhsJOMCEhGhAnRDCAOvxU5Z+tj8mYdCmMYU6G6RJ65HzWsYMLkwk6VHx9TehGTwJ5pWKX5WBE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB5863.jpnprd01.prod.outlook.com
 (2603:1096:604:c6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 00:16:39 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 00:16:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in  renesas_usb3_remove due to race condition
Thread-Topic: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Thread-Index: AQHZVcww9t3IRw1AV0GeqHn/tYrYE675Zu2g
Date:   Tue, 14 Mar 2023 00:16:39 +0000
Message-ID: <TYBPR01MB5341E0C84FA76CBA8A534B6DD8BE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230313165128.3763626-1-zyytlz.wz@163.com>
In-Reply-To: <20230313165128.3763626-1-zyytlz.wz@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB5863:EE_
x-ms-office365-filtering-correlation-id: f9ddf3df-d0f0-4bb5-8218-08db24216190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KnW3S3XpD55Es+5Tco8U/lwCgDl/HUUBPrDzcuw4rSzoFoDoxAmEmlQepsfklZsm5toAK9fAQp2OXSdn4P4MgcXouXkZNkAg7telCmwlrtzKbljHdb4ErhpxnT2x019hG8yQopgP0wDJ/gVqbdv+0yIPjg7u2cWaJBzkyE5HpmvGHsDBHH/zwDltwAMEAhHiooTSpAmyIS3Njx3/gqRw2U0XeuveVbbFr+RpUPUeKa4GzDyt6v8qYmVY4gvzIRRY+RZfVGpaCDCH30tgtPic1HtCLPXOSzuIrzxarc9CDN0Kn3dPY+Om2TUr9S2EZVqwFC0QrzCEgAGGjAginRFLIsdGApjwNQo/+SQwtJKbCBnYYl3g1Fz2meCypmFikF5NVb2UcPzVNQQqcDHYUo75l80yc2LRBuYssjjvEfKsMov88xijWI1seYp556+W0G9uLSP05RcVkqKh1cEfkun8TC866WzEmi/DFaF+blD7fyGyUWS4j1ziTzdrsDRW2j4fTyWS38a2C3eL64hBP1RvvQuqttUsg+y+jFAl3Kpk3QChLSOXx4uY6FTx+yKVGdH7euiu4/Z3HPFrs8qBjuG4k2+kuC+TvkWBLPKOgjS9Gd+FCk4uYcV1w2+UYyXt2tN9dZpzjvqmS318+r1J3FdmCbg2+60mk84r3McpBX36UQp2r458mJoK7bPCmsF0kiA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199018)(52536014)(5660300002)(2906002)(41300700001)(122000001)(38070700005)(86362001)(33656002)(38100700002)(8936002)(7696005)(71200400001)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8676002)(966005)(55016003)(4326008)(83380400001)(110136005)(54906003)(316002)(9686003)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f9HbIM3sj7mjNaTtt7YtsebFdAQjOkD+3W87mbvmZlK8WMBsvMt7X4PvCTvb?=
 =?us-ascii?Q?zXF7PVi5ESgSQm2d6wA5UxPGqhk/5BoNKh/90lsXhnb/1df7JC0xUNUOTkPK?=
 =?us-ascii?Q?Ozc3VPEJHUxm5y3FT8uIc/JTB31Wuy99Vur7qyGjh8kLWJhdyGsAVr1enS5a?=
 =?us-ascii?Q?FEIzL59Y5ZscLclYP817V6tVXc6vrfgacdhFv2OndbFnES9xer4VfCuphjF/?=
 =?us-ascii?Q?p0tYrT4qBqdq+5m2Ega27Iko3tz4KjRcvNLmNZI6H/QGH/nbtVJuYTBBXsJc?=
 =?us-ascii?Q?pIQHd2X6FoWFll9eCEvtshJ0bUp16M4jfwKqr5elb5exuLoS5yG6sjXn19qE?=
 =?us-ascii?Q?AG19lwH8UinGklhIu4iPEDKCzcKdbQ/QZe6mRYpNHmFFz5wB4fZRHHbQPlq+?=
 =?us-ascii?Q?FhpCUeq0CVdmXk582npbgNd/VRqgjZ55QIx5eNjHE45jyJ/pZkGWbo3cW+TI?=
 =?us-ascii?Q?yQEnJzBTpunv+PeggRuXaf6wpgBxgwNe7XB78xqjmn2N9VYB8NZpk64im1f2?=
 =?us-ascii?Q?SjMZl3xE0LioeAWjZHnsjWgjG9CoU/3+nc9T5Nl5FroaraPAfXmwbcESIAje?=
 =?us-ascii?Q?QmQpAE7KUyxKUJG4mUWlTBl+ExA9Kz3P8UIAt1EYprhM3/hR8Ol9vnORRzat?=
 =?us-ascii?Q?ARrQZ4cbSOGv5fgPilV3pZE7MgBWLtDNCg11Tpr8P0pTuLCtGEONmAfPWzqy?=
 =?us-ascii?Q?gwg0LYv5LIWPPGsBApcKT5X4dJXM0fO8kV1da9aokMtc/nM4yo5RTORQZ1BQ?=
 =?us-ascii?Q?eGGYa9q4CJPWqstPEgwAWFDhrSco5qzsiMvITsN4/swk3QPvcTdoeO6O4BlJ?=
 =?us-ascii?Q?ACuOjNBX7W13L+0G6Na6yDiNDWFVv8cgwYpVgjv2Vo8C4Wq509EF76EaAWR8?=
 =?us-ascii?Q?hYqx6qwivfKomNFrdTwgHlqGamiPSwNm+rIPbJaCsr5UtlhPqOkQ3qpbSYrC?=
 =?us-ascii?Q?JemQglFlccqkwmNQaKxM7W4hQSbaquJBDOq2EYtnYyjQzYGvhf5lk9ow3G+I?=
 =?us-ascii?Q?6w+bD0YJMT8LOsipv/CDiEe6eOjmXzGNdzJBayhH/CwwAEgvhXrx16p6dDFg?=
 =?us-ascii?Q?4V2Vt76WuFAKA2Gg6wW3V9jODZ5JA19xmQbyzCQXgJCBzorLAQC+PnXtm6br?=
 =?us-ascii?Q?AjxlQhSDiylOWiKDkvy52mGem1jrGpoJU+QD79yuK5SD2sLiq9ev7BlKCBm0?=
 =?us-ascii?Q?3pPU/cyGndXgVhstScEl4SgnjcRc9UVjczee3JqZvzRjfnrnwiQxZlE3Nf6p?=
 =?us-ascii?Q?scP3tjV4NtMH+DfF6z5fuRTbYsuhCgSJJhRk5GxCaVmiE3JLlaHLoW9LMEuW?=
 =?us-ascii?Q?a3AOOQ65EtunmJ6gQVLUQkl50noV+Avq2WpzN4gxkX0iCotZKYh8G+E6k1p4?=
 =?us-ascii?Q?J4S/5KMt5BOS752ui+oQfktEUP/z6YYqI+rNghWyXXFvAs4w4O+GCfnsdU3g?=
 =?us-ascii?Q?HbDhWGuerea0tdokELYw0Vl+OXAU3NwEH0Ms75yZ6b8NMhMGaCOsxMor2evI?=
 =?us-ascii?Q?xCYC04YMoc6cKGl9GuzZHaEjXdejtLjvEEfieBth836B37CFFZ759l8sQxth?=
 =?us-ascii?Q?qlzS3zkmBNcN/HvyCNBD+NM9FSNbKCKYtV+5NmFeoKtuEX2IdpkTXPVfczmt?=
 =?us-ascii?Q?0/pzXIvpHWzUcV4i3BOV3EYRpPgobK39Fom7F4Y3BOcFCRRxeKxaM2jOb09g?=
 =?us-ascii?Q?1s9cyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ddf3df-d0f0-4bb5-8218-08db24216190
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 00:16:39.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVYUL5VBbcdcais6WkGELElINc0gq7sLjaWy62A4coeC+uDdXSixgbGCNcPnVl4rXr+cwXpvHtab4wZkSHXUK7tWj5hFEuZzTbQErtOwdF4x/MmvFGYxNNEKKEw0HY+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

> From: Zheng Wang, Sent: Tuesday, March 14, 2023 1:51 AM
> Subject: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free bu=
g in renesas_usb3_remove due to race condition
>=20
> In renesas_usb3_probe, &usb3->role_work is bound with
> renesas_usb3_role_work. renesas_usb3_start will be called
> to start the work.
>=20
> If we remove the driver which will call usbhs_remove, there may be
> an unfinished work. The possible sequence is as follows:
>=20
> Fix it by canceling the work before cleanup in the renesas_usb3_remove
>=20
> CPU0                  CPU1
>=20
>                     |renesas_usb3_role_work
> renesas_usb3_remove |
> usb_role_switch_unregister  |
> device_unregister   |
> kfree(sw)  	     |
> free usb3->role_sw  |
>                     |   usb_role_switch_set_role
>                     |   //use usb3->role_sw
>=20
> Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb=
 role switch")
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

JFYI, but IIUC,
- In general, my Reviewed-by is described here, not top of your Signed-off-=
by.
- Also, you don't need to submit such this patch. If you would like to subm=
it
  such a patch for some reason (ping or so on), incrementing patch version =
is
  better because original v3 [1] doesn't have my Reviewed-by tag.

[1]
https://lore.kernel.org/all/20230313094852.3344288-1-zyytlz.wz@163.com/

Best regards,
Yoshihiro Shimoda

> ---
> v3:
> - modify the commit message to make it clearer suggested by Yoshihiro Shi=
moda
> v2:
> - fix typo, use clearer commit message and only cancel the UAF-related wo=
rk suggested by Yoshihiro Shimoda
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index bee6bceafc4f..a301af66bd91 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2661,6 +2661,7 @@ static int renesas_usb3_remove(struct platform_devi=
ce *pdev)
>  	debugfs_remove_recursive(usb3->dentry);
>  	device_remove_file(&pdev->dev, &dev_attr_role);
>=20
> +	cancel_work_sync(&usb3->role_work);
>  	usb_role_switch_unregister(usb3->role_sw);
>=20
>  	usb_del_gadget_udc(&usb3->gadget);
> --
> 2.25.1

