Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB93A6C2992
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCUFE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCUFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:04:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4A73527B;
        Mon, 20 Mar 2023 22:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+lRQTPgNmqLgL7Gbzz5zrCFp057Ts4EfQP4npozXmfQ1XQH3Bc2VDWfL+oB7XyTm2mycQes91QP/9OpZ/gAm0xSj0L6IMiucQSG+uwr2llaG95eULhg7k0NedPSKN8PZ6p12NFdsQxCi4YEgfpm4RYk9EOM+mpoQc15vF4cd/JPt8mFgKbmJTdlh8rfz63zvO3s8wCst/+l3sNyITWlsgNTF1p45lzykJe3wFYD8LLoZkd6REaE5O9S52+5xY8bZLk7pythXwp5Ow67ASedpQeEzwoHNnpfEyTEIgizmS23o2zj+KaW4eZBW4Ey22++J+g+EgRyhSBQiSXhOkB0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGC+copg4egHFpZT52qjmQ6g47R/gQoCbeDVUBd22pc=;
 b=BWoxgCuf3MLIhacpRluYbp9zf/ypc16E+h8KqH8E/dnmrLzKo1ojgO+/KASBN3WnhkEvfvfAV65kymrO65IbLUq1DjhHt31xHVAUt+7rWz5QqRMiniqrLDwTIXbR4e5V3Pipqd5GcbOlvYJYOi34Vyt/YWWCNF+dzTuJmtuf9We78SCkmwkEPd3olyvGa626nRBO7laQmn4Evrp1d0Jw7tpaRJYAz+PaIrd0O5IC01v8yYhdK/LGkdQ411/zQ7lEzdKR/qdgpN8GATlScaHW/J03wKXaNz3s7RWj5j5hRTq3J6gSvibTXDMeOmvv6CZb9Z1aR0HXaB9kB5lVag6XHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGC+copg4egHFpZT52qjmQ6g47R/gQoCbeDVUBd22pc=;
 b=c3lWjPkXMWPLuQh1PM0fc3HaBsGURtJ8RdFM1o/27mC2QnWG4lkp/TmXbVDloNmQLYg4M7sv42znjd1Jw2rnlJiSvZsd6EUge5be6OiNL01irI36z+nNyM36iEeovEkpx9q/CvBW5i7NSs7LQdSn/5oVNIEZ3Bx3Mn4GJLig+n4=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM0PR04MB6961.eurprd04.prod.outlook.com (2603:10a6:208:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:03:25 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:03:24 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] crypto: caam: Clear some memory in
 instantiate_rng()
Thread-Topic: [EXT] Re: [PATCH] crypto: caam: Clear some memory in
 instantiate_rng()
Thread-Index: AQHZW6T8qM2pEJHQqE6oUcuL8PwIJ68ErEqQ
Date:   Tue, 21 Mar 2023 05:03:24 +0000
Message-ID: <AM0PR04MB6004F6DC17B8CB859D13EF1EE7819@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <16d6bf3bd7a6e96a8262fcd4680e3ccbb5a50478.1679355849.git.christophe.jaillet@wanadoo.fr>
 <ZBkj9tUFl8OJeoic@gondor.apana.org.au>
In-Reply-To: <ZBkj9tUFl8OJeoic@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM0PR04MB6961:EE_
x-ms-office365-filtering-correlation-id: 2a6cd18b-84ac-433a-90e9-08db29c999cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUVPePUD0jzWbLrPQW9kYN3efqQDrdf4urZ2SqrUW3Qbj2hFBcmZz4FtQ0/1ms4KXYVraZgK0cuwd/B0XL1U6ZwlvDvOaf+2pHtj7+TfX3yrHYWrB/YevKq3P6yxPJpgPAGkNdnQMv+uaSLtN2iEISZB2XdIzr8RLTzlx/Kf/p43Yqk8wSoUaI672Ho+tGslpMOaDm5m3RhqN/lb2vxJcJAO/6t00Y//iSD7nuSbhoFK7F9D2BXQd1S+BrLIwI643C/DBP9YtNobX1vovWdwtLU5tB1X4tBc0a+E//+sGjGHr9pGuMEXYsCnMgG8ajU14QZW+egab8wZQV+AMMPwVObYaFoFfBJ9vSGTiHqjTDbECqkeIkFwOHJofZBSR/rO+CEdSDHMb2ILHYYw6X1XSpPHDHK1XZkYX6+3yZTg5Up0yYg0p70kSdvadpOem9k3ly9OlcEVNiYclUqbVdLmYzOkddDIDjwe4TSpBXyUzLQp4JPMapTg+0fqyJ1wk1ZLeo5nbUAS71JNPPkotmU6mL9X6tZ6Hlcxl+PWuFJ3+rJqiZqyfITWz7n4i02aRhRUZ6CywU4SPbzDs3NoOT0m01W+jk0FmxgfKgRzHyG+A6DMK0/ZTJz2AQi6e8rMC2yDYKb54hDojfWOjgrqQd0pvTchGabvkEl+EEj0bdUUSdH82/Ur7ineKmuGqGxn4OqLXFirzocKdLojiylQaTRARw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199018)(8936002)(44832011)(5660300002)(52536014)(55016003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(2906002)(4326008)(966005)(45080400002)(478600001)(83380400001)(71200400001)(41300700001)(7696005)(186003)(53546011)(26005)(6506007)(9686003)(54906003)(110136005)(316002)(8676002)(66446008)(66556008)(76116006)(66476007)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CoRzClo8P3+XHE/mLOuwnmGi7lZ8/d+qkxZP4OLGWV0FBQKxJblgJf2rsJJI?=
 =?us-ascii?Q?pxOwsWBtZZTKi9eicyOhbE5jl7O0xUMDL/e4So7bmuLAvA2YcBvvLFdFxhDh?=
 =?us-ascii?Q?i7F2p1HagaNH6CCTZfGUC5EcpibKzxcgf4YYIVXhgK9PgiHrqMrwaTvjfhq6?=
 =?us-ascii?Q?BaEBzY0Kqg7IzwAOmmFDbaVegw4MCpRnHNmUghINmaIXnVPiJf/5orx8Upbs?=
 =?us-ascii?Q?Dzo/Dm3osBoULUGLQ4Nm4gpmgq/XzzarnhdxvRkgs5mdlKyIf9L8TFLtbFHH?=
 =?us-ascii?Q?6r6aue9LC/6i8bgKOSfmQuWNbfkcRJXufRoO7S1bKdHMmzQNS9hf836uxBCH?=
 =?us-ascii?Q?h4ZV0lkpi9C8Z7OBZ1ID4KdYo0bPgAV1DIV+fNikxksCX+u2V3067tThagH5?=
 =?us-ascii?Q?YclNbLSyCeNHxRjTlfeaEOcLcoXAKR/6g1sU3oKayBLqK+I3/AWB11/YpkXS?=
 =?us-ascii?Q?y4aPripaA3x10Oit0b/3qIseWWKvepuiCMGGISXCdDxFI3UWoR04ejIigIre?=
 =?us-ascii?Q?m9uET1OjQecba3K2f71Q68KwCIcgx6Gz/87ntZPbIQLED2FwrMhNo7h4UUrJ?=
 =?us-ascii?Q?KHvwD5shVroD2mNVbfRK5cNsHEbtTSgMDaLU7YV/TyE1dWTQbW5xOwyS/Z9a?=
 =?us-ascii?Q?rEZ1SG6pbWSFZC9+iKO6SAPIcDs1jQbq/HXGKILrOHQUwDG5MXUXDTfCjUni?=
 =?us-ascii?Q?BScEfe9OvOyYk4NxblhXyp/FVBZ7AxAGPlCPfKq83tYi14u4XDN/TjFr/n3e?=
 =?us-ascii?Q?KQd/cSMVeezsqlR21JSH92igMYS4pz2+U9Q5wOrOrkFvtfCYaOX7L0zHFs7i?=
 =?us-ascii?Q?iTvysOc4Tbyxxi5fla7sLc8IGWQii3tXfE104ZQXLIHa18oT+VNENjdAy6lv?=
 =?us-ascii?Q?Hfk4iMtR5OpsIjR36q26ZcyEPOtKBos63RGmJTua82qGiif73pRv8O/34TSu?=
 =?us-ascii?Q?HCQ3Rng5gDShe+SQBvLwZJS0VbFtRSR+s1ybLISmQ2p7bIqYAIE6Fwfv1sj0?=
 =?us-ascii?Q?fDW8XmlloRP8Y41PQXx9Nt+DsPHFtVpP27pft5+jckPOz6ROw1ATbjbOf1Wf?=
 =?us-ascii?Q?WaU2W+h8U5UPgJonoqCZ17SCGir9HCvDZNz0y4KZitK6l9mA/N+rlmHBf4kA?=
 =?us-ascii?Q?im9WlTEBmeVIcHtiDnuGMBD5Vce5sJB8tMpsPh+B/Dr8Zi07ZNThLW/sB54Z?=
 =?us-ascii?Q?bGlaKANFwXJor2mCgGv5Ea3EBSjSGJE/oITE3gMp9YIIHh1H3+0VpCni5JhU?=
 =?us-ascii?Q?Ns3z9c5itsUxb3df4AeDNFDHy1ip7IV6XxGn7y1mR05URrAd7vqx0FCLqYSw?=
 =?us-ascii?Q?g4RBvJPVD8zospic2XBqn5lPOWkdqBFiLanqSAvG2om4PpcN6c4JUOdQPe6Q?=
 =?us-ascii?Q?aMHU76cEagkSk6RHlppVLTizm5Ycn33Jty53SVbQAmMLtrB41AuOQLqDHuTX?=
 =?us-ascii?Q?aiflTtRm9ELV7nUD1v0UigLAXbMIxe3MxVuxl7VKbVhnE6hgJykE++3Q+A89?=
 =?us-ascii?Q?yNwGuNEqZ4RuotuVTmCCLBEo5B1tQSCO8zDS1MLKeAJyvedWEt6g/7f9sXvO?=
 =?us-ascii?Q?hFmAq2QhrxSJR7dfHKyVCm/cAHevxnq9pG3eWiDO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6cd18b-84ac-433a-90e9-08db29c999cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 05:03:24.7852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbZDR+CxbIW4VONeGjYgJiZS3j3pmGHRy9Y82HkdBignCQdEoxEUsoR4YnEP1yjq0fl/hirQi7ZCqzDA86Qykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, March 21, 2023 8:57 AM
> To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [EXT] Re: [PATCH] crypto: caam: Clear some memory in
> instantiate_rng()
>=20
> Caution: EXT Email
>=20
> On Tue, Mar 21, 2023 at 12:45:43AM +0100, Christophe JAILLET wrote:
> > According to the comment at the end of the 'for' loop just a few lines
> > below, it looks needed to clear 'desc'.
> >
> > So it should also be cleared for the first iteration.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > This patch is speculative, but can't hurt.
> >
> > Maybe the memset() at the end of the 'for' loop could be removed instea=
d.
>=20
> I think the memset can be removed.  Horia?
memset() is needed to clear the desc for each state handle before recreatin=
g descriptor.
So it is required.

Regards
Gaurav Jain
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor
> .apana.org.au%2F~herbert%2F&data=3D05%7C01%7Cgaurav.jain%40nxp.com%
> 7C93eb192d0c734fc5105e08db29bc1da2%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638149660155476281%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&sdata=3DS%2Bh6BA5ka9HoWb%2BHq8Vwb3TwnEu8b
> RZ5scpGvOxg8iw%3D&reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor
> .apana.org.au%2F~herbert%2Fpubkey.txt&data=3D05%7C01%7Cgaurav.jain%4
> 0nxp.com%7C93eb192d0c734fc5105e08db29bc1da2%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638149660155476281%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D7YT4gr8kviqJYFABOcg6UgZL3BceG
> 3oY4HUSUuUwAdg%3D&reserved=3D0
