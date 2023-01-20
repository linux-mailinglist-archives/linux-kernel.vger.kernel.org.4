Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFDF6751E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjATJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjATJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:59:19 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346C9028;
        Fri, 20 Jan 2023 01:59:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHndhSlGTJBNON4aJMpldXJDWiz/KuBZZFCjfOa0q7AiVbP8J7BEQ+j9l4OlFBfhEFEO2aQz5/VaPL6Xyt8VkmNCI/PykNhiE+pAUTzy2RDQsFVQYMiNdbFX7Y7DltbUlE41x+sdMyQVYeDLIrzLap5psyMAOqiOK1HbwWwQBVnoW4L5fA1uxkPqGw15bwg9BBNmMWTO1zAoU+0CzeNBBdmVTf8Iy5VEOtZzm4sgM3EPwTt8gzQqMbu3KCiWwl8U2Uu4rWhGx7SL7wXDdYVXjV5/L7kAPqKwwKl5NDydbw1DzyslLoF4zy5Zw+2lXOXwiUUaF085L4oh7mcvMMnNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwWcaQQ6b/SGTFSEAvZoOcaDj590dUxiSFWltyz2gX4=;
 b=Jd8PyiwXBJG8W/3Z5WlibsOdh7ZgliyXAwVLIkYdkghuCQhode0yo18sfvzCri3o9jCKsakVwJK1uPXwFLrxb7EAGZ9njQAdd3MBapPUUaZSkA0yuwtKBv8li29E18i8zbXTfHW6IQs5QVaXM51U/nTfHRIJrSoG7TCFUW7WXli7b7sMaVAU7CNeqWoSb74ToMkGGoPIuFZ3M28oCdJ5z7SInS3KgPi1xDPuMKDzQACdWT6FNvuiBHEVdc0/lFchpGWqSRezFc8Kx4RHGZDAw3xxirNm9Y8kGufEwz6mxq9U+lvcKfxXwAdW2mGXoV8J8PDN1HqYunemgCFtOVbBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwWcaQQ6b/SGTFSEAvZoOcaDj590dUxiSFWltyz2gX4=;
 b=fcriUdKY74TIr5qxS25jI2Fq+aNyPdQKAT896ry0ULUmmhU45+E1D2t7hVcW2myweUFEWJKuvEoxYKQ8qNF0+FB/9axmVJFUjtMyZt3PaA9UFElkGs9ChajsWxKhuh6Rkh2dOEa+D0Qt1SW/4pzUg2gCQeKlwHvuhtvF6TY1a84=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8901.eurprd04.prod.outlook.com (2603:10a6:10:2e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:59:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 09:59:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 2/2] media: amphion: support to decode
 sorenson spark video
Thread-Topic: [EXT] Re: [PATCH v2 2/2] media: amphion: support to decode
 sorenson spark video
Thread-Index: AQHZJmSV3h0YtCs1Nkqb7Lx5ToA0K66mP/uAgADdmBA=
Date:   Fri, 20 Jan 2023 09:59:08 +0000
Message-ID: <AM6PR04MB6341EEFACA1BAD7DC4E82B71E7C59@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1673513975.git.ming.qian@nxp.com>
         <ab85e597c37aad849480bfe912d5e06aebc51726.1673513975.git.ming.qian@nxp.com>
 <bb9fb55bf81b978041e44e04d619adf43488f467.camel@ndufresne.ca>
In-Reply-To: <bb9fb55bf81b978041e44e04d619adf43488f467.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DU2PR04MB8901:EE_
x-ms-office365-filtering-correlation-id: 753c0201-9c90-49ce-b44e-08dafaccf93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5dyzXHyNB/+Fo7+YW4pb5hlefGdInT98MVmrSFhDnZLKS/nBknjx3g+IiC1CBYKYZDBrf2dkHb7kRsWtDbq8RjYQ6kweeNuy0QdbNBwuX7C1bk4mCPQGX0H7906ph8C4BZW208edTvylJMDRZRupmy1P6F6aXoEOaTailPcvowUnlx3Sc/NcBHldCZk2S4MLnxhn8RoNTT3E8ldvpWOOhWD4NbqmcChMSETk0iQ7x2sVDHVN0XFEJ2iOfXX+CvLRcVQka9VACwuLT1zBOafWQcF+Y/WjTkGrREF4b/d7ZhPHRV/tJlIZVXV5+IRli0susgY00jjX7C+ryJPneI7IfjcLpAX6xyTcEP9o+qXO6Q1+SwOqTGSXl8GH0speKqtMaYRW+ydhDfXsm0uY/oatoC+bjzQTAqs9MEYonZ5fSDsdCCbhQNjLVtaBukbtpmj6JPk/wMmdjRudMhTLxHQ1Afc+M/2J4NoSZ4cK5R8A47lD/8aR3vokw7X9IWGZhV+jLIk498BQXbyPZUqDQEGQZw5drj0iiBec86+nRLCZQXUWKRXOoLMhQRWQnsiSBUi7ewX8tuf26uYiFSEkg45QdbXiwbtVoNE/DkI7VU2xvQkKQ59L5Bbo8PwxMn9SNq2yrB+0+eX5Rdc1uym3ANg7sEoo4wZK8n25jHXo/ilgb/NnxokdUvVmXwjSNWKJu4YIdhgeAfjnD2DdZt6KVf7aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(66446008)(66476007)(64756008)(4326008)(76116006)(66556008)(66946007)(8676002)(33656002)(478600001)(9686003)(26005)(186003)(6506007)(54906003)(316002)(110136005)(7696005)(71200400001)(38100700002)(44832011)(2906002)(38070700005)(41300700001)(86362001)(5660300002)(7416002)(122000001)(55016003)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0dqZGVIY3NrUUhBTXJCc0Fpak51QXhLYi8rU1Z0V3ZnNUw3d1dYQjF5bjNH?=
 =?utf-8?B?VUxKdzdVc0EyTU1TdCtUNmV6QmFiWkorcmRNM3NTOVRjZ1dsNzFDeWx4UWlN?=
 =?utf-8?B?dEtiSGNJZ0JKUUZhQ2hMMHppd0xsNWdNemdyVlRPUVM4NHQ3VXRyeEJsdnBz?=
 =?utf-8?B?K0JCMVZDeGxxelBYQlJPOS9rVGlRTmVHRkQ5SHRmb2QzcFdSTUJ6VG5JQlhU?=
 =?utf-8?B?NzBseG0zb0N1Z0ZGeDQ3dE5tcVVValV0WHV1NnNQVGpNSXRETkptUnliMEtx?=
 =?utf-8?B?czFnYm05WUVSLzkyczNFem1tYkFHMXM1VGd5NG8zZUNRVE9Id2RPUU96R1NF?=
 =?utf-8?B?cFA0UlZ4SHcyZUNlVmp1R2N6NFRialFiaFNKOE9jZlFkM2Rob2J6MG5sUlZH?=
 =?utf-8?B?Y0RIbWFZM2xZTnhZeWVuODBoNzV3Qk1wb2hqU3hzWjcyNkFMUWVIMVpIWnJy?=
 =?utf-8?B?eVJSTDk2cWcwV1RJWEFDbzcxaTl6SjdLVVJqQ0hNMnBvYU9iTE5TaXhKMExq?=
 =?utf-8?B?L042Z0JGU1JyVHE5WmJnMW56UVF3VG50cEV0ejR6anoza1hPYkl1K3hqU2dP?=
 =?utf-8?B?K3ZxWS9pTmRSU3c5Ky80bXFuWkJlajUvbGZseW5nUE9NdERSYmd2NC9xUEZ0?=
 =?utf-8?B?aXUzZU9CTE0rSE5GNFpvNmRrekJjbXdKVk82N1dDTHlkTGVYUnh6V3YrMlQ1?=
 =?utf-8?B?aWJNdG9yS2k5SXZraXd3aGNyRkRWTDZhRWt5dExMdElqYTVaZUYvcTBLc0Y2?=
 =?utf-8?B?eFJSR2pvMzlSQ2FVWHpqVWhWSE9jQ2w0VFkzK25PQjBQZWg1aktOWXdVOVZa?=
 =?utf-8?B?Yzd1Tnp1SWNSVFBNYitNUi9KMm02ZkptVjV4d0k4cUVCQi9RRHNKUlBXMHp3?=
 =?utf-8?B?YzFZTlM5UHlMdlJBS2pHcW43SzR1ZEE3T2tsVElKWjZYOE13RXVOaTJKUjli?=
 =?utf-8?B?QjZYMFdrZHJTeFRzVG5tU0xnOTFTVkNPTWF4Z1pMcDJhRktGRGFGS1pJTzg3?=
 =?utf-8?B?bmdWcTFDdHRUWkxzL0J1TzhMTUdOdlN1N2FjUHJzdWZKbm1pbThNVmhZSUEy?=
 =?utf-8?B?YkhDS01JNVFGQnhjcEZsNEowaGlUZkdtZVp5QUFpaUY0ZThKMysxNk80dW1B?=
 =?utf-8?B?dEQ0WDFrZU1ja0JpeCtNd0ZkNlJ4THRWN2VTa2h1cHpGVzF2R0Y2TjQ2bmIr?=
 =?utf-8?B?Q2Z2N21BazZ0ekhzOFFETU5GaitwWWpkamdnVHdyTVFuTVh0VjdHQU4ySE9y?=
 =?utf-8?B?RytHMUtUWjYyNUtDcmhiSEZtbm1QaWpaNUorc3orVi83UzcybGczcGI2WUhk?=
 =?utf-8?B?YjE5dTJFdFBIQXVrRnlVQUIwaTl5R0ZxcGlBV2N1cUlaSUpaRE5kT2dPYUJx?=
 =?utf-8?B?Vi9sRng0dzJRQjFERi9Fd2syY0dEZm56d0k5aG5RT3hTaU9wVk96bnorL2hU?=
 =?utf-8?B?K0lWdTl1WEN2M1Vad0xaYnErNWZtMVJPa2FYMzEwRnIzV1AvSkRrU2lsZ2Ez?=
 =?utf-8?B?RW9nQmVMU3UvcTBtUElpTnBCY0JGRDY0NUdzUEwwNWozczdueXVTbkExd0J2?=
 =?utf-8?B?QWk4eWxDK1I3ZkpPVHF6N3Q4dkhLOFhNYlp1cHloSjFJS21sNEtNb0RNOHQ2?=
 =?utf-8?B?QTB6bFZienJqczBQTng3TUFIT0xScHhwOC9uT25zNXVSakhra2xObHBKQlNv?=
 =?utf-8?B?d2tsaUtpSTREWDVZcjdtdld4UjVhbFRYcmxMM25GbWI4dlpxbE9BSThGWXg3?=
 =?utf-8?B?VmczNHRNN05BKzZaYjRyWlIrL3NpTCtLVmUyVHRvQUdlNFdTdTRaK2VMMWND?=
 =?utf-8?B?cDl5SGNIN3ZFaWcwNWZieU5KZUV1M3U4dElZcWhwUDRwNHpRak84cjQxQnVD?=
 =?utf-8?B?WGp4T1A5ZzRCL1l6WExuUUZnSWx2dU1BajVvNmtxTDkzRE9UajlKYjl2MkRl?=
 =?utf-8?B?VTMybElybmptYlBpd1pMV3N0OUZTYVVnaGFhbjJiemJML1NEREdYaUFXSjZk?=
 =?utf-8?B?TFI4azc5Q1AzQmlORThCS3ZCNFJTRW8wYmpZeGhaMmJib3ppTDhENm1oa0Qv?=
 =?utf-8?B?MkNITnF6cnBBVWE4QkZSVXZRQTdDWGVnRE9Gcno3WTBLSENnQW5odFZ2cW5V?=
 =?utf-8?Q?ampI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753c0201-9c90-49ce-b44e-08dafaccf93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 09:59:08.7680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zINblzAsgZaL6vsNmhOF0ZNOs5UlveDniGi9TTC+zswj6TxeexgVVZNaP1y2elPvehQN3evh44NUgNikhKkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPlNlbnQ6IDIw
MjPlubQx5pyIMjDml6UgNDo0MQ0KPlRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsg
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC0NCj5jaXNjb0B4czRhbGwubmwNCj5DYzogc2hh
d25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOw0KPmtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51
eC1pbXggPGxpbnV4LQ0KPmlteEBueHAuY29tPjsgWC5ILiBCYW8gPHhpYWhvbmcuYmFvQG54cC5j
b20+OyBFYWdsZSBaaG91DQo+PGVhZ2xlLnpob3VAbnhwLmNvbT47IFRhbyBKaWFuZyA8dGFvLmpp
YW5nXzJAbnhwLmNvbT47IGxpbnV4LQ0KPm1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAyLzJdIG1lZGlhOiBhbXBoaW9uOiBz
dXBwb3J0IHRvIGRlY29kZQ0KPnNvcmVuc29uIHNwYXJrIHZpZGVvDQo+DQo+Q2F1dGlvbjogRVhU
IEVtYWlsDQo+DQo+TGUgamV1ZGkgMTIgamFudmllciAyMDIzIMOgIDE3OjA0ICswODAwLCBNaW5n
IFFpYW4gYSDDqWNyaXQgOg0KPj4gU29yZW5zb24gU3BhcmsgaXMgYW4gaW1wbGVtZW50YXRpb24g
b2YgSC4yNjMgZm9yIHVzZSBpbiBGbGFzaCBWaWRlbw0KPj4gYW5kIEFkb2JlIEZsYXNoIGZpbGVz
Lg0KPj4gYW1waGlvbiBkZWNvZGVyIGNhbiBzdXBwb3J0IGl0IGJ5IGluc2VydCBzb21lIHN0YXJ0
Y29kZSBiZWZvcmUNCj4+IHNlcXVlbmNlIGFuZCBwaWN0dXJlLg0KPg0KPkl0cyBoaXN0b3JpY2Fs
IGNvZGVjLCBidXQgSSdtIHN1cnByaXNlIGl0IGRvZXMgbm90IGFsc28gc3VwcG9ydCBIMjYzIChh
bmQNCj5wb3NzaWJseSBIMjYzKykuIE5vdGUgYSByZXZpZXcgY29tbWVudCBvZiBjb3Vyc2UsIGp1
c3QgYSBjdXJpb3NpdHkuDQo+DQoNCkhpIE5pY29sYXMsDQogICAgVGhlIGRlY29kZXIgZG9lcyBz
dXBwb3J0IEgyNjMsIGJ1dCBmb3Igc29yZW5zb24gc3BhcmssIHRoZSB2cHUgcmVxdWlyZXMgZXh0
cmEgc3RhcnRjb2RlLCBidXQgSDI2MyBkb2Vzbid0Lg0KU28gZHJpdmVyIGNhbid0IHJldXNlIEgy
NjMgZm9yIGZvcm1hdCBzcGFyaywgYXMgZHJpdmVyIG5lZWQgdG8gaW5zZXJ0IHRoZSBzdGFydGNv
ZGUgZm9yIGZvcm1hdCBzcGFyay4NCg0KTWluZw0KDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWlu
ZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYW1waGlvbi92ZGVjLmMgICAgICAgfCAgNyArKysrKysrDQo+PiAgZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0K
Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+PiBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMNCj4+IGluZGV4IDg3ZjlmOGU5MGFiMS4uMDkzMDRi
OTZmNDBkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zk
ZWMuYw0KPj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPj4g
QEAgLTE2NSw2ICsxNjUsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2cHVfZm9ybWF0IHZkZWNf
Zm9ybWF0c1tdID0gew0KPj4gICAgICAgICAgICAgICAudHlwZSA9IFY0TDJfQlVGX1RZUEVfVklE
RU9fT1VUUFVUX01QTEFORSwNCj4+ICAgICAgICAgICAgICAgLmZsYWdzID0gVjRMMl9GTVRfRkxB
R19EWU5fUkVTT0xVVElPTiB8DQo+VjRMMl9GTVRfRkxBR19DT01QUkVTU0VEDQo+PiAgICAgICB9
LA0KPj4gKyAgICAgew0KPj4gKyAgICAgICAgICAgICAucGl4Zm10ID0gVjRMMl9QSVhfRk1UX1NQ
SywNCj4+ICsgICAgICAgICAgICAgLm1lbV9wbGFuZXMgPSAxLA0KPj4gKyAgICAgICAgICAgICAu
Y29tcF9wbGFuZXMgPSAxLA0KPj4gKyAgICAgICAgICAgICAudHlwZSA9IFY0TDJfQlVGX1RZUEVf
VklERU9fT1VUUFVUX01QTEFORSwNCj4+ICsgICAgICAgICAgICAgLmZsYWdzID0gVjRMMl9GTVRf
RkxBR19EWU5fUkVTT0xVVElPTiB8DQo+VjRMMl9GTVRfRkxBR19DT01QUkVTU0VEDQo+PiArICAg
ICB9LA0KPj4gICAgICAgezAsIDAsIDAsIDB9LA0KPj4gIH07DQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMNCj4+IGIvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPj4gaW5kZXggMmM5YmZjNmE1
YTcyLi42N2JhNjM3YzRjN2YgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1X21hbG9uZS5jDQo+PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Ft
cGhpb24vdnB1X21hbG9uZS5jDQo+PiBAQCAtNTYyLDYgKzU2Miw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
bWFsb25lX2ZtdF9tYXBwaW5nIGZtdF9tYXBwaW5nc1tdID0NCj57DQo+PiAgICAgICB7VjRMMl9Q
SVhfRk1UX0gyNjMsICAgICAgICBNQUxPTkVfRk1UX0FTUH0sDQo+PiAgICAgICB7VjRMMl9QSVhf
Rk1UX0pQRUcsICAgICAgICBNQUxPTkVfRk1UX0pQR30sDQo+PiAgICAgICB7VjRMMl9QSVhfRk1U
X1ZQOCwgICAgICAgICBNQUxPTkVfRk1UX1ZQOH0sDQo+PiArICAgICB7VjRMMl9QSVhfRk1UX1NQ
SywgICAgICAgICBNQUxPTkVfRk1UX1NQS30sDQo+PiAgfTsNCj4+DQo+PiAgc3RhdGljIGVudW0g
dnB1X21hbG9uZV9mb3JtYXQgdnB1X21hbG9uZV9mb3JtYXRfcmVtYXAodTMyDQo+PiBwaXhlbGZv
cm1hdCkgQEAgLTk4Nyw2ICs5ODgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0DQo+bWFsb25lX3Bh
ZGRpbmdfc2NvZGUgcGFkZGluZ19zY29kZXNbXSA9IHsNCj4+ICAgICAgIHtTQ09ERV9QQURESU5H
X0VPUywgICAgICBWNEwyX1BJWF9GTVRfWFZJRCwgICAgICAgIHsweGIxMDEwMDAwLCAweDB9fSwN
Cj4+ICAgICAgIHtTQ09ERV9QQURESU5HX0VPUywgICAgICBWNEwyX1BJWF9GTVRfSDI2MywgICAg
ICAgIHsweGIxMDEwMDAwLCAweDB9fSwNCj4+ICAgICAgIHtTQ09ERV9QQURESU5HX0VPUywgICAg
ICBWNEwyX1BJWF9GTVRfVlA4LCAgICAgICAgIHsweDM0MDEwMDAwLCAweDB9fSwNCj4+ICsgICAg
IHtTQ09ERV9QQURESU5HX0VPUywgICAgICBWNEwyX1BJWF9GTVRfU1BLLCAgICAgICAgIHsweDM0
MDEwMDAwLCAweDB9fSwNCj4+ICAgICAgIHtTQ09ERV9QQURESU5HX0VPUywgICAgICBWNEwyX1BJ
WF9GTVRfSlBFRywgICAgICAgIHsweGVmZmYwMDAwLCAweDB9fSwNCj4+ICAgICAgIHtTQ09ERV9Q
QURESU5HX0FCT1JULCAgICBWNEwyX1BJWF9GTVRfSDI2NCwgICAgICAgIHsweDBCMDEwMDAwLCAw
fX0sDQo+PiAgICAgICB7U0NPREVfUEFERElOR19BQk9SVCwgICAgVjRMMl9QSVhfRk1UX0gyNjRf
TVZDLCAgICB7MHgwQjAxMDAwMCwNCj4wfX0sDQo+PiBAQCAtOTk4LDYgKzEwMDAsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG1hbG9uZV9wYWRkaW5nX3Njb2RlDQo+cGFkZGluZ19zY29kZXNbXSA9
IHsNCj4+ICAgICAgIHtTQ09ERV9QQURESU5HX0FCT1JULCAgICBWNEwyX1BJWF9GTVRfWFZJRCwg
ICAgICAgIHsweGIxMDEwMDAwLA0KPjB4MH19LA0KPj4gICAgICAge1NDT0RFX1BBRERJTkdfQUJP
UlQsICAgIFY0TDJfUElYX0ZNVF9IMjYzLCAgICAgICAgezB4YjEwMTAwMDAsDQo+MHgwfX0sDQo+
PiAgICAgICB7U0NPREVfUEFERElOR19BQk9SVCwgICAgVjRMMl9QSVhfRk1UX1ZQOCwgICAgICAg
ICB7MHgzNDAxMDAwMCwNCj4weDB9fSwNCj4+ICsgICAgIHtTQ09ERV9QQURESU5HX0FCT1JULCAg
ICBWNEwyX1BJWF9GTVRfU1BLLCAgICAgICAgIHsweDM0MDEwMDAwLA0KPjB4MH19LA0KPj4gICAg
ICAge1NDT0RFX1BBRERJTkdfRU9TLCAgICAgIFY0TDJfUElYX0ZNVF9KUEVHLCAgICAgICAgezB4
MCwgMHgwfX0sDQo+PiAgICAgICB7U0NPREVfUEFERElOR19CVUZGTFVTSCwgVjRMMl9QSVhfRk1U
X0gyNjQsICAgICAgICB7MHgxNTAxMDAwMCwNCj4weDB9fSwNCj4+ICAgICAgIHtTQ09ERV9QQURE
SU5HX0JVRkZMVVNILCBWNEwyX1BJWF9GTVRfSDI2NF9NVkMsDQo+ezB4MTUwMTAwMDAsIDB4MH19
LA0KPj4gQEAgLTE0MTEsNiArMTQxNCwxNiBAQCBzdGF0aWMgaW50DQo+dnB1X21hbG9uZV9pbnNl
cnRfc2NvZGVfdnA4X3BpYyhzdHJ1Y3QgbWFsb25lX3Njb2RlX3QgKnNjb2RlKQ0KPj4gICAgICAg
cmV0dXJuIHNpemU7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZwdV9tYWxvbmVfaW5zZXJ0
X3Njb2RlX3Nwa19zZXEoc3RydWN0IG1hbG9uZV9zY29kZV90DQo+PiArKnNjb2RlKSB7DQo+PiAr
ICAgICByZXR1cm4gdnB1X21hbG9uZV9pbnNlcnRfc2NvZGVfc2VxKHNjb2RlLCBNQUxPTkVfQ09E
RUNfSURfU1BLLA0KPj4gKzApOyB9DQo+PiArDQo+PiArc3RhdGljIGludCB2cHVfbWFsb25lX2lu
c2VydF9zY29kZV9zcGtfcGljKHN0cnVjdCBtYWxvbmVfc2NvZGVfdA0KPj4gKypzY29kZSkgew0K
Pj4gKyAgICAgcmV0dXJuIHZwdV9tYWxvbmVfaW5zZXJ0X3Njb2RlX3BpYyhzY29kZSwgTUFMT05F
X0NPREVDX0lEX1NQSywNCj4+ICswKTsgfQ0KPj4gKw0KPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bWFsb25lX3Njb2RlX2hhbmRsZXIgc2NvZGVfaGFuZGxlcnNbXSA9IHsNCj4+ICAgICAgIHsNCj4+
ICAgICAgICAgICAgICAgLyogZml4IG1lLCBuZWVkIHRvIHN3YXAgcmV0dXJuIG9wZXJhdGlvbiBh
ZnRlciBnc3RyZWFtZXINCj4+IHN3YXAgKi8gQEAgLTE0MjcsNiArMTQ0MCwxMSBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0DQo+bWFsb25lX3Njb2RlX2hhbmRsZXIgc2NvZGVfaGFuZGxlcnNbXSA9IHsN
Cj4+ICAgICAgICAgICAgICAgLmluc2VydF9zY29kZV9zZXEgPSB2cHVfbWFsb25lX2luc2VydF9z
Y29kZV92cDhfc2VxLA0KPj4gICAgICAgICAgICAgICAuaW5zZXJ0X3Njb2RlX3BpYyA9IHZwdV9t
YWxvbmVfaW5zZXJ0X3Njb2RlX3ZwOF9waWMsDQo+PiAgICAgICB9LA0KPj4gKyAgICAgew0KPj4g
KyAgICAgICAgICAgICAucGl4ZWxmb3JtYXQgPSBWNEwyX1BJWF9GTVRfU1BLLA0KPj4gKyAgICAg
ICAgICAgICAuaW5zZXJ0X3Njb2RlX3NlcSA9IHZwdV9tYWxvbmVfaW5zZXJ0X3Njb2RlX3Nwa19z
ZXEsDQo+PiArICAgICAgICAgICAgIC5pbnNlcnRfc2NvZGVfcGljID0gdnB1X21hbG9uZV9pbnNl
cnRfc2NvZGVfc3BrX3BpYywNCj4+ICsgICAgIH0sDQo+PiAgfTsNCj4+DQo+PiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtYWxvbmVfc2NvZGVfaGFuZGxlciAqZ2V0X3Njb2RlX2hhbmRsZXIodTMyDQo+
PiBwaXhlbGZvcm1hdCkNCg0K
