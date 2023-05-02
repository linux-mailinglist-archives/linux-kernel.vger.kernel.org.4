Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437B6F3E55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjEBHUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:20:00 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51D199C;
        Tue,  2 May 2023 00:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBoUnBeYeKHu/GQogB40Sp9V2MWgM5U1Mo16VHH+d2ctLvVyhLXmvJatTPZGa85J74j+A5WTMilTO6L1nIUOfzxZ0J8VcDc/4NJ82oVBfEzwo/A/wlir7o/hLGmxIr9aSJ21hXYU2OFy34cEElMDdRKs4agXFxL5b9xRG5WE0oTkHvcRigl4GrhyZf5RE3OwqhLfvJMjmObFOMqoMWmgU5e0bno00kDec1OJrqDYow+Kp37ecCrv5GGVzlcJbZZlzh9LOcrKn5P340ZfgWJG2QR4YQSo4Cor8PLkexyEndTWFQQY/WLJLGZn8slzA4SwTk8v144Bce8YSittGycs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9RBC7U9mJswlAGuLQQQMldR13pwTTXsJfzN+DyrdxU=;
 b=VNxjRMht+E9hE18Rdb6Dg73ABizdHjy2svFp3Q6KWHJfbk6K6sW2/Dylhx+jhSl+HGMrWi8S/Z860C6xpguTb2xgccxdD5fA66xVQekngZudrBfBz3Qln0VAORE229soGff7peNlJB3UjlPlgyzcvAcKr3TPB325h+kU3FzWLM/nmprx8I8CdynFE71haKdm9a2EgePkYtaiCVVrVyd2EBFZfJk/YjXRihpA3nPc9FOAPwUZDwDwOhKko3H9UOo53B/gAaCWExJGsyPGUFRsJS5zsjag9TCMtfNfyZNatgNIn2bltTzLgBMXH8pUQjF7Iai3Hr+Vn9oCoihh7L18LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9RBC7U9mJswlAGuLQQQMldR13pwTTXsJfzN+DyrdxU=;
 b=BSTi/5cFDiZ2MS/fYHbdoE6ccqDM4dXAeaP35jukf0qowBYyI44CDM6kuA6/u1N7pxv+zmP0LvydwupskLvod/xtducE5Sl7ER5IDVc4yQQHrRuV7RE4slcmI7FKOJCEe+8BOsVUYTctOnBFiiV0MEGEu0t22NgV41kz28tzENo=
Received: from DUZPR04MB9899.eurprd04.prod.outlook.com (2603:10a6:10:4de::14)
 by PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 07:19:54 +0000
Received: from DUZPR04MB9899.eurprd04.prod.outlook.com
 ([fe80::6d30:4035:f458:6946]) by DUZPR04MB9899.eurprd04.prod.outlook.com
 ([fe80::6d30:4035:f458:6946%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 07:19:54 +0000
From:   Kshitiz Varshney <kshitiz.varshney@nxp.com>
To:     Olivier Bacon <obacon@genetec.com>,
        Sylvain Ouellet <souellet@genetec.com>
CC:     Varun Sethi <V.Sethi@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: RE: [EXT] [PATCH] crypto: engine - fix crypto_queue backlog handling
Thread-Topic: [EXT] [PATCH] crypto: engine - fix crypto_queue backlog handling
Thread-Index: AQHZc5jo+N579ZqYvUeASMHVBWalUa86W3uQgAxH25A=
Date:   Tue, 2 May 2023 07:19:54 +0000
Message-ID: <DUZPR04MB989911E3FEDFF1F6BF28A3438F6F9@DUZPR04MB9899.eurprd04.prod.outlook.com>
References: <20230420150035.19369-1-obacon@genetec.com>
 <AM9PR04MB82116818BF48EFE951BB1276E8679@AM9PR04MB8211.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB82116818BF48EFE951BB1276E8679@AM9PR04MB8211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DUZPR04MB9899:EE_|PA4PR04MB9416:EE_
x-ms-office365-filtering-correlation-id: cc88273d-bcd0-4467-bf08-08db4adda0be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbKG6p6Ub6vVdw0xaJW6Q8z3psv2OMEoWs9eMJCjsiq8SLXO3GrIplgKuT3CmVhoG3qV0N6I89vICmphP11A/HGd4ZuNufILGEs/dUrLD/6boI8keJmZDhz+65pRmDUiOoXA797WRAyx+g425GTj2BQ66XBAX17sxnMjfT8p7PNh758nZYf7lyw3esEKMuqqRJEfq1lDqGzduhp9/0TJ/TBEgP043gHLQ2/ey5T3OV59w+xIhAudMYg1i2xW0jSAX/mpjy1VS0ULXUlCxs+dze2STFFV5gN5Y5aiWySJCF5Fy+OEWS2LSJvV6dub8N/CN56/jCB7aZSolsWmwyMl5UuxqXKEOcjwbwnxD38/WPZhNgv+Y/0c4LoHo+8mk+I6ujB4pNbKmYQHtYuMrII2KcbEBGo6BUT1ewmhISeAgPZ+/96OJD/S8mVA8kAILMf6snyo2hfFONeMmj3rs/TeC8ueVQvLi8nAd6Dxu0qWuzZj4Js1E6hEm6K55KK9korsvPOh0zoopDzd0SaSu7lAXbUDGn2Rz6AlBVZwXp7vBUcS2OF1NAXY7papA/WeIzOYXgLj4MUe7Dq8ln49PVKieWJASvwL8wAa2AS4hwYdcA1YpCyzMKFsDElw3ZveaXua
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DUZPR04MB9899.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(83380400001)(53546011)(186003)(478600001)(71200400001)(9686003)(55236004)(6506007)(2906002)(7696005)(26005)(44832011)(54906003)(86362001)(8676002)(8936002)(52536014)(5660300002)(33656002)(38100700002)(66476007)(76116006)(66446008)(55016003)(122000001)(66556008)(38070700005)(66946007)(41300700001)(64756008)(316002)(4326008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FEiPbzYVobtWxAFMFcq6+mR+6rm6SeKdLNWrx2s9kGalURTFBkOrDza33f8M?=
 =?us-ascii?Q?A0wxGQ5zXlzdLb+jEPVl/Y+wEY14OTEFQLTPz4+R3a1jUkNljL+OfJYtiUpd?=
 =?us-ascii?Q?/j7hSQD+sls52OTpBQFtcE5V0loYMuoEldGdIBrIxACVGHFmPNT6Vte4FNeL?=
 =?us-ascii?Q?egcn3r8TT/0o0RpY6GMqNiN3u6+y3jBy60O7ndiNZoTFxn3niSadld/+o3BZ?=
 =?us-ascii?Q?e9/45DqPh+QeLu5VYPc6ab0WiROsnGRgv2cWlH+HQT9dyf+uz7Bs5JgKJrDE?=
 =?us-ascii?Q?WklB3P+OrKnQz/SCkotcvq5k+xrfpV+DvdL+JPSu9iVrgzHkTbJWcGWS4A73?=
 =?us-ascii?Q?2U4BdcjaGiM7U4+5K3pRFjYQ5aTkWhnWP8VW5YHsiU1JnVbttXW9edIDA4Nt?=
 =?us-ascii?Q?Ap23qLA56LytNyXNUUmRVswXnoIclWexRV1qkfOTPR9YjmboFajfwWlF3uZy?=
 =?us-ascii?Q?ocpFfX2YuqLj1YkwCoSyy2Homut2Adv5OT/iDEZNLiU26fziQ8zFSsx7s11M?=
 =?us-ascii?Q?OX5qtxdPMBPCn/lo4iRs0lpjcFvJaXGPXw1iQQULFfySyLF3b/CEEUUUNkcS?=
 =?us-ascii?Q?m/WtnogCrDyc9OtnEFlx2BoIG0CuzKV1xWeOCCl+g15fah0TT3Jbdf4fBCXj?=
 =?us-ascii?Q?MuxHG9XpC9xwwxQ4aY7nT24IT6zTctxUUyzxjt9zkfS5klUHP9dJZp4MBJVz?=
 =?us-ascii?Q?V1xbl5gjd7YOxGV3OedzNdNHtmV3+W5uWleK2fNDsGVi5uEgrC0wauExGSVm?=
 =?us-ascii?Q?P0Yh6uJaKLbvl3j/FntkAH2Rgykc75c3vtR6lKMQIY5WnqoZdgM4DchwgGWd?=
 =?us-ascii?Q?2a5W6vzvg/RDhcmGNUGQ+ag48RaDkXZkwkhE6QcpL5ExXugLlMj95kPSQblA?=
 =?us-ascii?Q?coFw61/6TJZzg/6Gb0Fa/HNZT+Hq7Bal6v3Uoyzatc/57ItgqrwYvFPx42+K?=
 =?us-ascii?Q?LMEXti0chXDrTeDUsB24uEbN1/knUl8Fdc5IpcB9TBBwY5f1re4fe2b9f4do?=
 =?us-ascii?Q?SLn1+UL1KFUt7WW8XiGcz3puOJyHQFjMdsnISLvwALLg9hOX/4BfzI5UV60B?=
 =?us-ascii?Q?xRABZ6fOMISVKoxiq2/yQ4FMLp6NytaPEmSNKLJLEsot4bMYMvWxsrOCEOk0?=
 =?us-ascii?Q?cVp4meajPH9wAGVVeyecw1xk32O3I6RFrPE4TDYsRY29NOFS9E/bq0mQfX20?=
 =?us-ascii?Q?hKIGFSa+zMb98wIOg+oIV45FhrPYqPsIgBA6wzKRmuBag9e/0NFutq+pxeCE?=
 =?us-ascii?Q?SzgvpZkGqTkcb3E6n3zRdAMT1kicr2RKtDEWw2ZfOOoGnXbeiS2LsrtHfDfl?=
 =?us-ascii?Q?p71YYTnzeTG4pd9xhrvaGdAm4pg05JNED6bAtNhFYbbrI0TTyT/TFiTfR6iL?=
 =?us-ascii?Q?Jpnb4tRqqv/Nwgkw1gvMvTR0hXnEZfWkp846PcxtiG76Do1fZi7Z3E0ifDcH?=
 =?us-ascii?Q?krWKL98BAaPiC89/v7Q8Ei/4q7vJAGeFJcyuHHFj45PJSPD2sQVQiLHYJ9/l?=
 =?us-ascii?Q?gl0i1vLoa+4EZDlnzD2kgH7r++xctnM+Sq3TsNJprYocYGZUJsueJxneAw/B?=
 =?us-ascii?Q?bjpJqbEyyz5IL0gAwfOlAdsbzYg1s9039vhbpWW7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DUZPR04MB9899.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc88273d-bcd0-4467-bf08-08db4adda0be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 07:19:54.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEZxMt/9zW2wqGHt5eZsfgOHEuGeucNVL4KpPdMwKcxCfgVZo/VCJZvg8VWQNZmexlp3KuzKRPz82fc1lW1PKarkcjgNycyCpkKbxei5tGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
Tested-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>

Thanks & Regards,
Kshitiz

=20
> -----Original Message-----
> From: Olivier Bacon <olivierb89@gmail.com>
> Sent: Thursday, April 20, 2023 8:31 PM
> To: herbert@gondor.apana.org.au
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Olivier B=
acon
> <obacon@genetec.com>; Sylvain Ouellet <souellet@genetec.com>=20
> Subject: [EXT] [PATCH] crypto: engine - fix crypto_queue backlog handling
>=20
> Caution: EXT Email
>=20
> CRYPTO_TFM_REQ_MAY_BACKLOG tells the crypto driver that it should
> internally backlog requests until the crypto hw's queue becomes full. At =
that
> point, crypto_engine backlogs the request and returns -EBUSY. Calling dri=
ver
> such as dm-crypt then waits until the
> complete() function is called with a status of -EINPROGRESS before sendin=
g a
> new request.
>=20
> The problem lies in the call to complete() with a value of -EINPROGRESS t=
hat is
> made when a backlog item is present on the queue. The call is done before=
 the
> successful execution of the crypto request. In the case that do_one_reque=
st()
> returns < 0 and the retry support is available, the request is put back i=
n the queue.
> This leads upper drivers to send a new request even if the queue is still=
 full.
>=20
> The problem can be reproduced by doing a large dd into a crypto dm-crypt
> device. This is pretty easy to see when using Freescale CAAM crypto drive=
r and
> SWIOTLB dma. Since the actual amount of requests that can be hold in the
> queue is unlimited we get IOs error and dma allocation.
>=20
> The fix is to call complete with a value of -EINPROGRESS only if the requ=
est is
> not enqueued back in crypto_queue. This is done by calling complete() lat=
er in
> the code. In order to delay the decision, crypto_queue is modified to cor=
rectly
> set the backlog pointer when a request is enqueued back.
>=20
> Fixes: 6a89f492f8e5 ("crypto: engine - support for parallel requests base=
d on
> retry mechanism")
> Co-developed-by: Sylvain Ouellet <souellet@genetec.com>
> Signed-off-by: Sylvain Ouellet <souellet@genetec.com>
> Signed-off-by: Olivier Bacon <obacon@genetec.com>
> ---
>  crypto/algapi.c        | 3 +++
>  crypto/crypto_engine.c | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/crypto/algapi.c b/crypto/algapi.c index d08f864f08be..18a8ca=
9cafbc
> 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -961,6 +961,9 @@ EXPORT_SYMBOL_GPL(crypto_enqueue_request);
>  void crypto_enqueue_request_head(struct crypto_queue *queue,
>                                  struct crypto_async_request *request)  {
> +       if (unlikely(queue->qlen >=3D queue->max_qlen))
> +               queue->backlog =3D queue->backlog->prev;
> +
>         queue->qlen++;
>         list_add(&request->list, &queue->list);  } diff --git a/crypto/cr=
ypto_engine.c
> b/crypto/crypto_engine.c index 21f791615114..74fcc0897041 100644
> --- a/crypto/crypto_engine.c
> +++ b/crypto/crypto_engine.c
> @@ -129,9 +129,6 @@ static void crypto_pump_requests(struct crypto_engine
> *engine,
>         if (!engine->retry_support)
>                 engine->cur_req =3D async_req;
>=20
> -       if (backlog)
> -               crypto_request_complete(backlog, -EINPROGRESS);
> -
>         if (engine->busy)
>                 was_busy =3D true;
>         else
> @@ -217,6 +214,9 @@ static void crypto_pump_requests(struct crypto_engine
> *engine,
>         crypto_request_complete(async_req, ret);
>=20
>  retry:
> +       if (backlog)
> +               crypto_request_complete(backlog, -EINPROGRESS);
> +
>         /* If retry mechanism is supported, send new requests to engine *=
/
>         if (engine->retry_support) {
>                 spin_lock_irqsave(&engine->queue_lock, flags);
> --
> 2.40.0

