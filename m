Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F12734B84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjFSGFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFSGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:05:14 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A558D9;
        Sun, 18 Jun 2023 23:05:13 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J50s00030401;
        Mon, 19 Jun 2023 02:05:12 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3r99f6fhax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 02:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=denYIsLJLESVkptt67hdXc7wCPPHb18iiI1HrTSHoRL3nTHiuuWQ/aJJVe1mXGbJUptUv95XsF9IAgtbrxllmzMlgYL/75Qp+hlaNgJMyCUYjBDp+CNMZv/wvZo+a89afV4gmDp8wHpBrEtYOw7QNRqikoQa89dqdaBNChWc4HkJ9moTNC6NHJ8h5Bdb2upRNRgNXTuKNxUN9z+5FB7QdO+g3bpsms3caKFk9QbZPS1JWZ1gOovHasCKm5VmJdOUK1erOyo++6hzxMgd2HI8BSwN+mgzkAGCFcxhRQsfJMqFPoevNjJ0EoRawzxig0ITXtevJ/fCMExtEG48h8ITQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkHcqscbEIr4FEhc6yPXggrOoR3W/YQreQEiJvjXaug=;
 b=X0oIHgX3MDrCPMZmuTNpABPRhx8hhkkbcPX4mTxs8I/9xm6vrt1gUnUjDJeFNf1NnsZtzIq/kdDc1gp9UtvVVQvNafE7DtRDglZ7Le33RzBnA3eL3D7e01izxCeCcQaoyh9uyV0WkdsI+DzYScYeF5xF8IG2u8ZLHN6oSuKyj/CZr5GZFi8Bqky4FFol5bAioex8sHMPgYCcroPR0+g29oxWQ1+sjN9MRmQdu4y1TNuMe81IqFE0j/dBcz7sPRDVxLEXgmoBegs+7hYDuDnuH7zTaZ17HeZ9W9wyK442FBeFvLb7n+uqiJO2ykuhYvHWZgTyRLGtdNSomrD6xaCdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkHcqscbEIr4FEhc6yPXggrOoR3W/YQreQEiJvjXaug=;
 b=BXyiRZgT5Xnt/FNzznD1G41liw5oI1PF7v/cxtinudTkKJThyqQjblJDO02ykSBO+VA7lzoYt7LZ/gFBa7vZmuPkPN+Rc3MsjYNJ7MHme8TFKV4pQPeZA/dQjRjmCeWHiwXYlJhsIXE+hfcvULQAUMDdmzF+KCcgR2UBGptyBrs=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by PH8PR03MB7270.namprd03.prod.outlook.com (2603:10b6:510:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 06:05:06 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::2c99:6920:3f0:612a]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::2c99:6920:3f0:612a%4]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 06:05:06 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH] Input: adp5588-keys - Use devm_regulator_get_enable()
Thread-Topic: [PATCH] Input: adp5588-keys - Use devm_regulator_get_enable()
Thread-Index: AQHZoOsKoEunsN+aiU2H1tZ+fhc5Dq+Rphbw
Date:   Mon, 19 Jun 2023 06:05:06 +0000
Message-ID: <SN7PR03MB7132B49CE99BBB1CFB53E7F38E5FA@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <af343b5b0d740cc9f8863264c30e3da4215721d7.1686985911.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <af343b5b0d740cc9f8863264c30e3da4215721d7.1686985911.git.christophe.jaillet@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0zYjRhOTgxNy0wZTY3LTExZWUtYjdjYy00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcM2I0YTk4MTktMGU2Ny0xMWVlLWI3Y2MtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSI0MjE4IiB0PSIxMzMzMTYyODMwNDQy?=
 =?us-ascii?Q?NzkyNTkiIGg9IlY1enNXa2JtTGMvTHdpNVRCMkRpZ2p6TU5NZz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RGJNNkg5YzZMWkFVNnBYdkQrc2tCaFRxbGU4UDZ5UUdFREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBUjZsVExBQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|PH8PR03MB7270:EE_
x-ms-office365-filtering-correlation-id: 00139839-a21c-4adf-7693-08db708b2155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMqiY8rKyz5NxGEYibpoZX0eCeFsrXrvck9pQ/EJa8y9oQasVvr3Sm3A4o6iYZQ7x+4d9hBjlFEengqfD2g9ld/CHAm2HNnAipEGmEuVlgRvylPlA4BjpsmvfAXOk84b+9eECOBiAWuODwFknz/WX3++0t26GfhQb28d+5cqKmzm7WwElfqEaVptCdi8YJPHhHaPvrJIUnG5J+YuKWeH61z+j1fSoIl07Ez5IvJySEq2IqCHFiNg6rGI50vGYnmW4Ce94DmOMVSNc2nkwMoz7L/azpZiXD27UQNgjnJCmJ5y/nzW/Pp8pi9lzhhIMiWDRXkgDxAGopWF+e3WflB9H5fgJfIwN7RVidgLAO4m5BXmTA2tXvBevGVDVgW2fFsJwx7RVL+OQVwy87mQNc8+SIOije4gdL28rU4v4NXI8QPH7UdfVAJBPDq7y9VmoGZ9zdK26l/eAvfhXXpMhqAgP60oFqTUCcUoH/wqhSg1bwPmkIXLwkUq7LzJX8VHu+iTjlHI1K0nTb5TrQvVPuznq7r7P1okse1YuHQeXn0BdZH/ZV1hODJOQlrD/4Je2mazO5Wtca+CPV4Ts+tuxIbDb6Jyy9JEwAuRRpQvVriSnCa2Yacmx42/rnTVuN12dG62
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(122000001)(38100700002)(86362001)(55016003)(54906003)(110136005)(8676002)(9686003)(26005)(41300700001)(186003)(52536014)(66946007)(76116006)(4326008)(66476007)(66556008)(64756008)(66446008)(83380400001)(316002)(38070700005)(5660300002)(7696005)(71200400001)(53546011)(6506007)(2906002)(33656002)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yIfZDjb/WAiDx7JGmsgpZzBM2Oz2YLUkXTvD3bTGHNB06+VaVlmyeFOBR7px?=
 =?us-ascii?Q?z5RJbG56q/a23jGLV2KqRFoc3Ci5rgof8w6TOM6/gqHjsbe4T6FYVlGN6P51?=
 =?us-ascii?Q?0TdlmHShtzRFw4v0focAhfZLflgd4Jh3Qk9GjOhaYnP32C2yhM/k0SQwOO1i?=
 =?us-ascii?Q?L+RwhEFHsAQivyDkWMzQWSpdKusvvRxg3VhzvK60gAc2SoOwsjbBN1xSGQ6c?=
 =?us-ascii?Q?xJrrNMAxfwP/eW5FWCvZK/FJepSWOyRs7yFBTi6QT6J3sdSYvInNwYsC/g6A?=
 =?us-ascii?Q?oDWl4T+m1R+72PjQum30xLJLH26nc4gvBfXOKC7gdpptu5Pd6jA617ujQb2o?=
 =?us-ascii?Q?YE4lXHjufhQYF9I0WGZxOhY8yxSV+qd2QCxTrqKHgURnjCJ6NafrbxC/6fNU?=
 =?us-ascii?Q?SffevbMjJH1OiXtPLI9zwg14WW7wNfzmJPP72CvH/N1yC6RNOZ59A7icyvDi?=
 =?us-ascii?Q?5K0B2pWzzSPCzBKMCbS+7RjKRdlxzG87f1VR7t8itESYtAliuz/5QwOAr6s2?=
 =?us-ascii?Q?vRyedMcwf2MKyD098A2KOk71y3PqoWXn/HogTQrTYryLAEwvXK1eDjL4Dso2?=
 =?us-ascii?Q?hWoZIa8lqj46w5ue8AZVOVrw4av3r9siPKfod2qtCLqOkH+TabIsvWVi39UY?=
 =?us-ascii?Q?7FqUa/qqhR20Oj03bcrC1yX+Gms+PLG4al0zwxTXzU3bgia/v/5ECLIbv5Wm?=
 =?us-ascii?Q?3XqR8XEpxJs6HXlUMy3VoS22X6OAzFABQBH4Ml6Jp+4Nb6KEPGk9XHcBEyPt?=
 =?us-ascii?Q?399bBolaxhXolZyfwcn3hbgl2MJiGxPspHvcNp3h4h8O8lDgLMrVdyiL6C74?=
 =?us-ascii?Q?YI8EUn25KZMlLLfxWnAenuGTclN2crzFddbfUzhQQtwSjnTwET20YnoPYdv2?=
 =?us-ascii?Q?n6rf1dIhnv1yVuuBbGJrlUisSH/0A0b5ltpv4TudaqDgKBHh3sHYylxqQw2+?=
 =?us-ascii?Q?OoZcyoIYjUHrPidZ7uImflCu2QzpvGAQjGRMiQ/qs1qoWhZgVzUl2so/FOxs?=
 =?us-ascii?Q?dW1HvqYB2rt0AOyrhadcwRnEAA9e/XB6m8dQzDMebeTxTNWzgZ6QFy/ygYV0?=
 =?us-ascii?Q?sEJTQ6BESmrd6YayXev5BR3/O+UQz0R9M91vFIL1oOyBGlkoniXVvTtn6fFI?=
 =?us-ascii?Q?DvYhxdj2Nvjq8CyHz+ELjG5oOkMUuJ0dwNe/j0KvJWou2TnNNXe3KtUZKvnh?=
 =?us-ascii?Q?HfUF4QC6Y9jlExdW8TaSPD1qg1+s32fxWIN3zy8cVMQpetyhi7sKuaX01aPo?=
 =?us-ascii?Q?KSWs2odnFDbyTmHouu4+kJELDuKUO3zLpHFXL5Q5Uz3zLTiSq0eQ9fCWIzAl?=
 =?us-ascii?Q?yjaqt/6Px1wfUY0JEANOm216LUJfT2A40UMD+rfhZ0SPPtMBg/kXTvRz9xrN?=
 =?us-ascii?Q?IYqoYn/Wtlc3GfI0bf1A6QJZQ/4q0X0B1aBPMrtHWuH/uYYcFLT7rYEVxwmU?=
 =?us-ascii?Q?Avk1W3xnXAY2F/RV703pRGxJ1fX/AYA4bJ1oJukhxMcB1zLY5KEpHZ/FnRoC?=
 =?us-ascii?Q?C1XyQuZKPCjyrKl2DiTXYrSKewgBEKjM5LbLd5tuenqrodklgGwzhCCVlpR0?=
 =?us-ascii?Q?PRfD8yxNE/B7SE0H/rXIM/ECu6V/lLciQ9ThzxHssZQ2GRdVIUTsuHOsmvVD?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00139839-a21c-4adf-7693-08db708b2155
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 06:05:06.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+bupwBjnM1/4Khy8uk18ECpOb6jgh8r8XegOX4mgetIHNv9Wvc9VM6wmw67vSnBshg1xpefhviBb6NaHcrk2XbCDYMn3N21O/FwzP51vcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7270
X-Proofpoint-ORIG-GUID: A93hOAO90UBMvIvItQKzPIPn6c5EJlcO
X-Proofpoint-GUID: A93hOAO90UBMvIvItQKzPIPn6c5EJlcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306190055
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Samstag, 17. Juni 2023 09:12
> To: Hennerich, Michael <Michael.Hennerich@analog.com>; Dmitry Torokhov
> <dmitry.torokhov@gmail.com>
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christ=
ophe
> JAILLET <christophe.jaillet@wanadoo.fr>; linux-input@vger.kernel.org
> Subject: [PATCH] Input: adp5588-keys - Use devm_regulator_get_enable()
>=20
> Use devm_regulator_get_enable() instead of hand writing it. It saves some=
 line
> of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/keyboard/adp5588-keys.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index 896a5a989ddc..61e8e43e9c2b 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -713,17 +713,11 @@ static int adp5588_fw_parse(struct adp5588_kpad
> *kpad)
>  	return 0;
>  }
>=20
> -static void adp5588_disable_regulator(void *reg) -{
> -	regulator_disable(reg);
> -}
> -
>  static int adp5588_probe(struct i2c_client *client)  {
>  	struct adp5588_kpad *kpad;
>  	struct input_dev *input;
>  	struct gpio_desc *gpio;
> -	struct regulator *vcc;
>  	unsigned int revid;
>  	int ret;
>  	int error;
> @@ -749,16 +743,7 @@ static int adp5588_probe(struct i2c_client *client)
>  	if (error)
>  		return error;
>=20
> -	vcc =3D devm_regulator_get(&client->dev, "vcc");
> -	if (IS_ERR(vcc))
> -		return PTR_ERR(vcc);
> -
> -	error =3D regulator_enable(vcc);
> -	if (error)
> -		return error;
> -
> -	error =3D devm_add_action_or_reset(&client->dev,
> -					 adp5588_disable_regulator, vcc);
> +	error =3D devm_regulator_get_enable(&client->dev, "vcc");
>  	if (error)
>  		return error;
>=20
> --
> 2.34.1

