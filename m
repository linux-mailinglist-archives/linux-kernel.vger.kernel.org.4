Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD046C0D53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCTJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:31:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C117126F2;
        Mon, 20 Mar 2023 02:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBjyrK/Hxo1+LG+VOGp4dFUm28bcaYN7bmk5/dpLizRCyBuGMChoB5laJ/bZ+dgiTvZ/NgawtmBnbh3fowyC8sa0s89RxiwmJX0zxPdOCwEQpQFS0ev+DjMuLLiMy63FRNgjOXtxQ1P+I4boVH1HMC3VpPfNeRXo8HRJbqzfx0fkwPDttxo9yUFZe7gg2wXD14YG4iCipnzzk2s9yb5OcvI57PZhFrRrNfzdfskw+kShStsXN1fpiKsvAbNz470YcqZGHQo/xWS1HBhsDXofNoyLHfILMT9KXlkLW+0FCBuJ72ktERJuvLHUIINC5j3VYFlAuu4Xd1lt8DRTMFD7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvlGAbCRl8Lrr5cO5zhmeFe9/ypxS28cV24o1Shc38g=;
 b=UMyncatFtTaWEUn0AfQXTpp31wp/IaVG4b2YFtD+NlpZk003JCZ10TlBReJzVL9BdAEfNjTeLIAGDh4mQjfWzK3E9L5hZp+RjkLkAhlqYxGZDAWo8zE6FQMA/YE37kSRdTxw2YsdBdCs2MJeCmgj49t3lZm5hgDFbN9Y/LAYw3i1pKxgsyVmjRpHW3hF/hGva5tFvV+k4tybA0I8LBTRqqnUaiQYPhSW6UuQyYrnF5Iu9tsz98wQwigfynmWmrIUsNMShV0bn5mtAVZgDLnhLgM0usuLx6gycVQkRLzy1jVITj03MB2Bnc+GCjbO68mQMBc0jI3zGmY15Ts1DzCFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvlGAbCRl8Lrr5cO5zhmeFe9/ypxS28cV24o1Shc38g=;
 b=fd71Ns+43hRHl8hFLEcdQXlt1WFf0W0XEWewE1Qd53CYRgR00pqvqs3X93STOyic7RvPJt5tYl+dlR0DstdCiK6kE/Ps8+/wGiKkvg5Gm9LCdDGlG/y1uLvKaUTH4nUl1gG8ELQwJGQblwVwXj75UoXfoWKoNJBiTnQwkQtMBvY=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by VI1PR04MB6832.eurprd04.prod.outlook.com (2603:10a6:803:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 09:31:10 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 09:31:10 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Yu Zhe <yuzhe@nfschina.com>, Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "liqiong@nfschina.com" <liqiong@nfschina.com>
Subject: RE: [EXT] [PATCH] crypto: caam - remove unnecessary (void*)
 conversions
Thread-Topic: [EXT] [PATCH] crypto: caam - remove unnecessary (void*)
 conversions
Thread-Index: AQHZWJr2GFYKyb+ilkyJEsC+bgKkFK8Da/qw
Date:   Mon, 20 Mar 2023 09:31:10 +0000
Message-ID: <AM0PR04MB600425038BDAE435B44E60A3E7809@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230317063643.27075-1-yuzhe@nfschina.com>
In-Reply-To: <20230317063643.27075-1-yuzhe@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|VI1PR04MB6832:EE_
x-ms-office365-filtering-correlation-id: b0fe6c42-2be3-4911-4ead-08db2925d70e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f30rG2CDzuI81aPHoIwdz/oVuwCJ580/N1WdSgub5QA4FcI06DJBiS04pqUxMr7KvroBoqgkTPGoWvrjK+97+8V9nKdJSC5K1NWOSXIhpFQuTxGhbqywvarzoVgX/BrexgvD6rP7/bhNcX5PCiXWdwKOcc3KwvDh7rSjlslokkwSY9boLAx889zREpchF91JOAqt2LNV+7cp6+EkoGqOv0Ii5RjxmPNkCdF3drAMmrcnHOiWfmIsFuu3Ijj2JROBiq/Vw5GXD2/BlHLMqBwjNpT/2sTjZv6+bYBJlExZvLLdEIHQzKtcMCTLjC5+7zCSDBrUrBA5lwZAUeEJUMHZhe2HclB2Ei3Z94nTC+LsbWkOlNo8kAR0DUMoCYPSIOAjdONbXz8dw+6w7f+simirrtNrDymyoUmcbHpbZEK1w6jylpjCV6kS0IRylrMyVpO4c8lmMvpJZidKKYMgBWBIHaFTcb3fFWJvF3GxIQWp5RSXG2nZKge+Rui1caz4sQL/ze6Ugqr2qmUkFcJ2nV3/ckjobIxmPN0S5Ue9SPBZzNDyRX59PkLRlpRJAAg+1jYzRMp282xczWhEC6E75uTrSo+8G5oirqvuse0Ctxmlq8I1WAlLWNTYL7Rr3WVz4H/vzafOwwCWwo4M+ssdFyceb9G4swE9sA4TeJj1juGm5YdfayXXsdab/vhBdd28Yj/nOKo2FPbD4Y2Nv3M5aK2StQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199018)(8936002)(5660300002)(44832011)(52536014)(41300700001)(55016003)(86362001)(33656002)(38070700005)(38100700002)(2906002)(122000001)(4326008)(83380400001)(478600001)(71200400001)(7696005)(186003)(26005)(6506007)(53546011)(55236004)(9686003)(54906003)(110136005)(316002)(66476007)(8676002)(66556008)(66946007)(64756008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4cSZR0FN5BNt8ddEjABAtcvmIGw8TEJK8eZdqRBCeQlCHFf9+AoOK5PGO6Tm?=
 =?us-ascii?Q?3EQBsDWdVcLIAVSC89JwPLepbP/SgNWe/QNVy9zhjCij9OFyGbqQllzi+F1L?=
 =?us-ascii?Q?TNj25q4mcqkWi7Qnpm5phHIqpQrP0maCmtRF60Sv3q6af0hG8wHWyKVLVbRk?=
 =?us-ascii?Q?7nxXr+og+JaYqC9z+KuVkSEzl88E0nl/TDlQgyrsGkCb+Ivd9Ulmc+ii/sKk?=
 =?us-ascii?Q?md1WHhRJN7nZVXeukhf14TgBGH6ObNv4rQ5mOLE4wNjB4Wt/pMD+ixbGQD5k?=
 =?us-ascii?Q?Qaag7YjsfRYA6KZM+DPHV4Am9DV1bDXd/ISwPuVZ45X342pF0YmH8TQYk5cM?=
 =?us-ascii?Q?dKYACTJzpyK1sU9v+6UGxx8KRNg2bwkvP/xoOeX5XB9ZgVvOJalvXnHwkm3Z?=
 =?us-ascii?Q?T8NuqUp2vuP4W8FslMscxQTFwPVJwVKfLWdjSNaVEuaPA3KsCp0PB4g9iEWr?=
 =?us-ascii?Q?Ttzeu0UlGGR7NNY230Lmk/idKxaEq2K+zk7/v5NhWkO84TMjiYpEvmMu3Ifb?=
 =?us-ascii?Q?jeOGzBzzu7SeVxwlAcisQgFa9L1/ZFnf2faFrUvc6bDiGiEqLDxACvvPSbAX?=
 =?us-ascii?Q?od4uK/DXyDKg0oYE+j69Qo/TYs6SB0QJmbnZxrC0dwk/9JKg+28Webgg/ZIm?=
 =?us-ascii?Q?DnwIMrLPwkjsp8kR6qmltLx/OaEq/Znj3VnFnGsHbxx95aPqhjtOX2kp2WPe?=
 =?us-ascii?Q?FL7tmtYpMAgxCntVp+UbHwqS6xExz3XhAxIMRxMySbPVJwyjQGf1Lsu8f/W6?=
 =?us-ascii?Q?DfPoSX1L8sfaIchQMGAIPsX53HiIzua2j3i2A9Xzypufl3XDTfQZg8/XcLPT?=
 =?us-ascii?Q?dI4KLwyB0e9JojrGcK3qHh7i5zVwGvzRoMElLd7RutW4GD+VtrGnYp8c+7fx?=
 =?us-ascii?Q?HDPpoBW3PyCxsFQg9dZEilAOdJHZlb5FYlRVu+LdzrdipnZefgoRPEQILLcJ?=
 =?us-ascii?Q?LeRBC9qU3KZ8EqAjlvDKEbBRUHFGF+txjI4E45xweqmGuwLEKWr/pljoDmPR?=
 =?us-ascii?Q?gOPOmVqgjMwATvJ1r1SacOn+4J5Aps+vrq7FBAqOBSv/8frmV30K4LTA3g3n?=
 =?us-ascii?Q?+J12MyBJ8mpFx9pYtdAMaJXF5ttzY2HYTSyS81qXPcNh79NYyfLp+A1MpIOZ?=
 =?us-ascii?Q?2H673A8NTroH0GOcIxAsdKk95f4p/YnYTj4ullIqKApDCEHqbEQnysDXDUvw?=
 =?us-ascii?Q?F2FqdVF9GPHsAZYXheDI1fdB7nUCQWDqv5R1wqX8YfxMyka24uQ/J/doIxwd?=
 =?us-ascii?Q?6mEcqgkJioBiRL9kY5HH6bYPHyGHI5TnECEf4AZgIMDzthIPrN8+DcJ/90cI?=
 =?us-ascii?Q?sH2mvtg5eZb77fTu8c4Nx7JBAzvg94fHZnym88ax4ocYEL2NqMkLM7mMJIr0?=
 =?us-ascii?Q?jArlZzTnx6WMGLmUdNv4e9V2qd3V6M5WpBoSa3b9WaQDy+ucQeX5fiQhB2KQ?=
 =?us-ascii?Q?4z6r7zxMaarVkB5HrwqYS/Y80e9K5qVh6JcORU6JrIsS0unxlyyeAjWWjvx5?=
 =?us-ascii?Q?Ae0ym9KRu4QWUZeLScwZXE5o14wrloajrcpplCAUpgloAqOZnap2n7a18Opv?=
 =?us-ascii?Q?dlsHNuSlRr0IWrpWVqJ1CW0XXBxeU5Zs0wBN1Tdd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fe6c42-2be3-4911-4ead-08db2925d70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 09:31:10.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpKkBkH7Sh9UCh08WP9k5/DJhTQZF+ZuoJgYP1CBdJWqe6zxgEfjo5kmFrWa1soA8kvUQewEoYJavvGoLm49wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <Gaurav.jain@nxp.com>

> -----Original Message-----
> From: Yu Zhe <yuzhe@nfschina.com>
> Sent: Friday, March 17, 2023 12:07 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org; liqiong@nfschina.com; Yu Zhe <yuzhe@nfschina.co=
m>
> Subject: [EXT] [PATCH] crypto: caam - remove unnecessary (void*) conversi=
ons
>=20
> Caution: EXT Email
>=20
> Pointer variables of void * type do not require type cast.
>=20
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/crypto/caam/dpseci-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/caam/dpseci-debugfs.c
> b/drivers/crypto/caam/dpseci-debugfs.c
> index 0eca8c2fd916..020a9d8a8a07 100644
> --- a/drivers/crypto/caam/dpseci-debugfs.c
> +++ b/drivers/crypto/caam/dpseci-debugfs.c
> @@ -8,7 +8,7 @@
>=20
>  static int dpseci_dbg_fqs_show(struct seq_file *file, void *offset)  {
> -       struct dpaa2_caam_priv *priv =3D (struct dpaa2_caam_priv *)file->=
private;
> +       struct dpaa2_caam_priv *priv =3D file->private;
>         u32 fqid, fcnt, bcnt;
>         int i, err;
>=20
> --
> 2.11.0

