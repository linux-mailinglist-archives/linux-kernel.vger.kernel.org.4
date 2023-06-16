Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6E7329C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbjFPI3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245574AbjFPI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:29:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A54E30EF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfIhNr7xtFGT3GjuRPeOPbJCAAWrIhqSNQ2eA0lt7avNu1QvdSsGBAxHl4GXOZqppVYBwCVZxZ8YxApBV4n9DXbLeNoPtuCV351OIuT9U0vqFz7fCLaGIJmxBGc5zFwOphBi5fghDZ5KbQxRInkPSwZHNPm6ipfEXstx4UYVm1CmlkLdzdxOnktLjDVh0mR51vf+8l+AJGU2MaUqiI6Cl4sfSPaNkctjilCoVpVvGzOa8iB0/zsWbfKVCPPD0EcxvC0dntSSx1OAh+1LYtF48fhtxLwWmmojSJpSa1MmVTM1XMCpMfDQ16xbK4y51+OAFM80HDz6QsMMzMunKloZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOugPHAyWb+gGXc4uBY9jbDPLrLtH6iyQx+GuXkp2fk=;
 b=LXB+gtB2MAMblw386D8wclP6QEt8MZ1+0Tg1VbwSP77WAcio+9fYRhVqzvEi7xqboXzCaWj3i8bZzMBySkajfGbreBYlS425sGdGOw1JwVueth+Ngwnml3lw2EUx+eVO1RwCNVYemTd2uUCCsci0/iBy83Le+ecnxmOnFjAN2nci+RMJ6xgtEN/HPvEhXFI6g1O2Y50k4BVOkuB1ATdgyoFHQXq+qve6eS1mt73EYAUzsHZBui4woPwrX7YMybD7QTOCaGx6hIh6dyk4isgTIdkeRzpCowxU4wk+kuuhCtrz3xvijnqlcR0bV70FG8XvjTrUEtonjuBkkqyhQyqalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOugPHAyWb+gGXc4uBY9jbDPLrLtH6iyQx+GuXkp2fk=;
 b=Dx54v8E1gbH63s7+pl+bvCdklmu9/oYJL9+2HyzuC1G7MUtg6pm6/CMxwVeusKeCpW/H2btEFnrPyHgB3lr2INsHrPD9v/eTW7JQNEokTewtzja2+SNjqGH+hn4E0VS6oiXuSMUi4yafv6839goO76TYQ1WuWyCdP3FqU2XUbdQ=
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 08:28:59 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 08:28:59 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Thread-Topic: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Thread-Index: AQHZoBVsg6habxYIbEmfvjjh7HkyA6+M9tUAgAAaD2A=
Date:   Fri, 16 Jun 2023 08:28:59 +0000
Message-ID: <AM9PR04MB890708494C6FBC3FC0DE63CFF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
 <2023061638-lushness-jeeringly-314d@gregkh>
In-Reply-To: <2023061638-lushness-jeeringly-314d@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8907:EE_|VI1PR04MB6813:EE_
x-ms-office365-filtering-correlation-id: 42a178b4-215d-42af-a4d9-08db6e43bbdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjYadveUkYS+/Ai+Mc1XVpa1WUlMT0MWNyKvxsbyq9GiTryLahMd7ygDm9RY7CbJr2SDpvQNlMh/kxb75TngjJ4Osc97QDCMsLs4w6ZioiN4VxA7azjU/UDSgkJ6rbLUKjMFLrbdi3/uxJ+6xQI0y7YZQF4ERIm31p05gFbLCxMzIae4hnu6oC5/9ZiVfaGBdaP5kxgz1rQaH+kbo6ZFs/gWe9foglU6TKbZxA0TpVih+tTi1TvXcM22KpggoA3K2mnI+5CBH3Z9OkINCF9S+p63CZQNNHc1LJlZ79HcYCSLGhGiuL3IaMAWpNcz1m9kJ+9I5M/gNxuh5aXpU6+rLYted8hVg5D1LBKxR6v62wby1CR0HKDlWf6+4C2UbFBCyqXr5dzylfP6Y0JGWxxY/XL4LpgDnLjhCit89KY7lA4Wuvb9hb51iwpOs3JV90f9Fu8pZZMLUd1bckzgZHNWXZjh5Zz9DwVl7XDxBJsX3e/ZEdCsUAP7Km5Svy4oVz9TNL2gsLKpVxGSO8CuxZ96xnXcc/0uoZhofxrdMIQGFj8lMy6WPrzapTKqSJwChNaJma5w6IFl3p/OvqJfFefxiafeugkpTdsAQNbzDNSWwtgOLTYqmpadKlWbpFsMDTdo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(71200400001)(9686003)(6916009)(4326008)(66946007)(66476007)(316002)(66556008)(64756008)(66446008)(76116006)(6506007)(83380400001)(186003)(26005)(122000001)(7696005)(54906003)(478600001)(55016003)(38100700002)(44832011)(52536014)(8936002)(5660300002)(38070700005)(86362001)(8676002)(41300700001)(33656002)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UeR29XgknuwlpX0nZOvkykvpCWwT5ls2wgiFXwvQyPU21JLuoZNog7z//9Yk?=
 =?us-ascii?Q?m/kjsGxVoQPZ8HUds0JWehHBl3VLFk1KSwyAGctPucY/Ehdx5m4LBh9JEbuZ?=
 =?us-ascii?Q?LtA6BYPMLTzWdekr9Gbzf8/RkrbMW5p1ec9AAdGS0k+A/qw+zhJtfW4PjKKj?=
 =?us-ascii?Q?Y/SI15DD3cqamEjnAFBfx68ZA7wiDdA1BW6Z5xlC43TQziYutsJWZPYfX3p5?=
 =?us-ascii?Q?qDQxk3L9cGfy4pEuS8cSJXKVHiDs+228nzhzkop6TlV52qGZrScWZ50jHpcy?=
 =?us-ascii?Q?VE9NBQ1vkXtNwZufaCXQEO7z2OXLivPvG7QglgGas9sNXCmo12NBSg0WfMb2?=
 =?us-ascii?Q?HoGrxVJ0gavFP4mE6N756LxZQgAPQJ8j8f84Ja2cDxU0QVm85ugrafpb9YN6?=
 =?us-ascii?Q?uyoMKMpKs04LE2u4bbIjciqJL7EKzksP2XrhIRSGkp1Y0iO1+HU6BoDXgddk?=
 =?us-ascii?Q?BVXPzmYCsjAE61FKf9zWVQ9PZ0WRgwacrNhlHT+Nbu/kLPmnesKvsh3aBtas?=
 =?us-ascii?Q?/EvSQr92aAy0k2HD+GZJ/kfwXCNzg36ggmtIN6sPct1fTjAfZ7EeRiwEkkvA?=
 =?us-ascii?Q?xjsJ9JhCtGWrH4RrbsX/hmNN0qCOss9dBRDykqAw6htzn/GC0tNKFqtkxlju?=
 =?us-ascii?Q?cnUjKAq6nTymBMyTbYVgMTZmYteQzVlRTmHeMmnuWY2r05J3HYnCIboIl/vN?=
 =?us-ascii?Q?QM1VKcGhsVcfqsdDL0MzkwEKmKHVNcC/tmv7qSdNHiNKw6pQHWOon+kcIhXa?=
 =?us-ascii?Q?g7F0l3T2sUwe+hXpX+IHnQ+jaFblW7A9CrO4RcYFNu3cm9CJ8/EIWIvQq9aF?=
 =?us-ascii?Q?nh2nm2bik8rxP2XDroFVZL4RtgjW6M3zw+ez0r/srVQvrc06MbncuiEZ3Q1s?=
 =?us-ascii?Q?x/G4uOqkwX4xDKfjaacc74fLnqOQAGgP7EP2elpHxDIf8htJZM3RUwYKuNgv?=
 =?us-ascii?Q?w//WMHA+UoLvYpYe9ad2R6XGRupRVp1e4ikL1d4/cPQ8iZ3/vJgXgjmT6sdd?=
 =?us-ascii?Q?wJr994gIv45IhgD3lPZsB9E+HttkhxEkf1MeM6ozhXlbb1MYly7P4Ph152A5?=
 =?us-ascii?Q?/Q9I1WAT8/ZG6WUetm5dVyGZzoU7wsRLpA4AXf2bqVpLnTeV0jdlym+BrmZs?=
 =?us-ascii?Q?aRQsFuKyw3j570b3CjgJTok5/HUiJ70GZXcIwGbErejPRgLL+36xSB4YLV/c?=
 =?us-ascii?Q?Fl9+2q+SNuAQto02ExtN4SbYbJoCmomX3VCllpkknrnkkGNJFpaHyun69l9F?=
 =?us-ascii?Q?SGYWxgdXIS+J0SwBBCt/nxpDOREevYp2hYUUDU+RehrkMr1CAq9qQYOcHCpQ?=
 =?us-ascii?Q?UGTKz/u6LTi+C5k5YOZI4YWQd7ZPkdOctT05pIiOwehgKBjscldXaQLlJf65?=
 =?us-ascii?Q?z+kr6Ep4VQ1cy/PlNw5b7dr3K8R/tN+GRiUOqbGfXRkmu1wDDB4p6mJ2Ss+h?=
 =?us-ascii?Q?Q8dHk0Xzo9pCfSer/CT719/G/SvzimDSWZ9GQPfWbHB14RqdAtqrq8PS+ELH?=
 =?us-ascii?Q?RLjcbXXa9AILL08G4f0Gcqp2C70ZDrtp7jOjk7Xryyxkd+ToozWFQwt4EKdp?=
 =?us-ascii?Q?cZveIIvQN5mJU0kAnpIkdrOsHd252fWHo8jWWAP7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a178b4-215d-42af-a4d9-08db6e43bbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 08:28:59.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yr86tPgrLh1rHNlfmPWU3iAXDkesR3iPl13yDO3Sg/pOGDTUFuAr8UMljlyyUov7UsBa+K5uixhK99KXjAGZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:59:06PM +0800, Alison Wang wrote:
> +static int ethosu_buffer_release(struct inode *inode,
> +                              struct file *file) {
> +     struct ethosu_buffer *buf =3D file->private_data;
> +
> +     dev_info(buf->edev->dev, "Buffer release. handle=3D0x%pK\n", buf);

Oh, and please remove your debugging code that you have here, and all over =
the place in the driver.  When drivers work properly, they are quiet, NOT p=
rinting out to the information log.

Are you sure that all of those people reviewed this thing?
[Alison Wang] These codes are also written by Arm guys. I changed dev_info =
to dev_dbg in the later patches.
Ok, I will remove these code.

Thanks a lot for your review.

greg k-h
