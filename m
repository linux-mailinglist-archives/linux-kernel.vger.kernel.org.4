Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D09865231B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiLTOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLTOuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:50:54 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582461CFC7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:50:31 -0800 (PST)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKAMe3i024058;
        Tue, 20 Dec 2022 14:50:16 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3mk8mjsht0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 14:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1rFNfqMHNClCKocS0cWyJHfNU4NxA5eMdDZpl0wtw/YhN7KHyQuFl2vaUXsUdPE3Pax1vTiZmykdMNuDEu6YL+pH7/krsbj8yYD5Qbt6sSLUYy8gAsLCEVsopormSHZwe3tclpwDH+amVlFbJcNqYnQjNjXWKPY2rVWGzzbigyaT9ZBvm+SNPCwKpZmzDmuc8/rADxYbwF3GzRTgW2UqX9D7rpagX0isjjYqyDO5OGBQ6s6tLs0gGdAo6s9xySDDmaQJPRq2W9rO8Pp07XfvtWzio9rbAI0+PqrIAw70UGBJFSqq9iYunJMriNnr3a5AMh3irvNMoZNaHwUxuKDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2ylN4NGfD1l/hT+56W7bcB6Q60E4babfEvcJ1KWBGE=;
 b=Xf9TGwEIpeBiOTJ8qfBCeIQFnnxrshYh0Q3Pv8IOAGPfZRPA3DsnGgtwtU2f6Gs1vTtHN1/uvNN5xgVcyGj4P6FTaauUznuFIH26TKHkEW+p2Dyu8Fwa0+QYHBiDnq5Qnt7ajBKEKn6poCc43UTwz+JttX0USUMNPyPfymkYLgi6xrQO49C1I3wpxfYtzXO9biit8lPQtzkOZ6ua+GPehsEYz3a4PEK9Li4iLvbwxsgYcczmGafkCVWnvlz4BKeT8M6K1dqW8ZlvW7+b9h2p+YcvzlWzsQjGtoH+ZFkKwe6+d7zsYX8s8po3U6GnKv/vJfW9VZUkA1+aQiNpJ+9MZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ylN4NGfD1l/hT+56W7bcB6Q60E4babfEvcJ1KWBGE=;
 b=EljSXG6gGvuzkdOg+iizz3Pve5cxwIctMgiJ8SuoLVYLA4AKtTkdJwPAyfUFq+7EEtq1kzXxQHxKArj6G3p7jI9cIise5dHH3q1F9+41fycDDYloVj1Svro7RD+5ju0uKbQmM/03rJoGstNjfCBVUBmoN75lHc6CpLw6+/7AkKiHzJRxk9BIHlw4DsHYPSaOI3tRp1RFL+G6b7wl5rJDwy9pGqlAAQ6w0YM6bMvLxYRh60OL/7iVBmZWcjWvuxnUMtNI7L3JHYwDEh3+Fp6ij+EFpj6Ke8quwguh/oKXTBl9pySd20rEFmjEc4BhGXzsQ+XmdowGaQpd0eTPaA1TIg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DU0PR03MB10115.eurprd03.prod.outlook.com (2603:10a6:10:416::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:50:13 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2da6:6d63:389b:3552]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2da6:6d63:389b:3552%8]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:50:13 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sstabellini@kernel.org" <sstabellini@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] xen/pvcalls: free active map buffer on
 pvcalls_front_free_map
Thread-Topic: [PATCH v1] xen/pvcalls: free active map buffer on
 pvcalls_front_free_map
Thread-Index: AQHZFIJdWCkKZGBL2Uu+Qwu1QSrhlA==
Date:   Tue, 20 Dec 2022 14:50:13 +0000
Message-ID: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DU0PR03MB10115:EE_
x-ms-office365-filtering-correlation-id: 9c9eda5f-a438-4203-6c58-08dae2998010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRF87nhwTw9BPrD5OaufHn4DpZKUmLFtquK3I8E7a8rUIiUVqGjo8g4tmKqweMGTLCNERjk54cuu1gTcVHFl3AQouQIg5g9WXr9LIvCvWqdqaDDncHBgsUrzrbbPIQmOxKoD3jQ4kKfAd7KjhnB220cxn3EOpW9ugNiwYG43bcixQCN/JlJolinQSv4xyJSLXi06R00dN2yrPRZnrJrjCwO/uPqVS6C5MiCKn9z9MdqBst4u6PCzoOOnhBHJmkq1DckKrMj+tcVaFGu1qbpiZ3EHR1ZFfEcosu9AbFPGIkcvhRQF5ault0S99krMVt3zUM0OFRUGqTdtc+m5u7yHlj/3Cs7zLKRKrIh+aVIZLZHIrRNsUW/Qtw/9S4pCUs/TJYpdkFSAXA5gwP9Z+oH93L2p5thzxW+evJjt+HTrHWclStyhtoMtWGXUfktD+jCOIrd2nqIlpkc39nJ0yHCxViTP1rlDqi8oJZWPG7j1Fl2ngkAoD4GmfXJMB4UmMFl14wx5u6+XxA8LUQ6hqINaVPT1FdZ0bZntOhig/mr0/RgZ7mDtELPRRWn761+G8ocYYsTYe6QshRR8RwW+yb+dLOlr4+KjhWz6TdKZxEO9AeS15UyUfIhr4AujKN/8wfwipiCeTdv2cXaEqb5QICzUf9mVEgMq7Vx/VsmstFUnbDAy5RM8GAR0eWZ99ZlcJHcakPti7yLp3ISCCT99pfRBTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(5660300002)(91956017)(4326008)(54906003)(8676002)(66556008)(66476007)(6916009)(66946007)(64756008)(66446008)(2906002)(76116006)(6486002)(71200400001)(478600001)(6512007)(26005)(41300700001)(186003)(6506007)(55236004)(86362001)(83380400001)(2616005)(36756003)(8936002)(316002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SY4aJPa8dYaxGFf08E+JVkUkf1qNvhA7HF24/AskLjt1pHPEv7UGsHgu6P?=
 =?iso-8859-1?Q?jTmRPrN+gZ8c6hsLpIWxwjrBgSOo6SDPyyjvYuzpuhArETV26ap4xVQ5l5?=
 =?iso-8859-1?Q?6Say/0zM6TrQSnMn5GGDmfsbrIfu5q+3UDLTXYXxEDXf9fWPJWruhyRJFe?=
 =?iso-8859-1?Q?Tx5BcKRWQEDe6JAwFddhYlCduVN76yjhhhSUtlpTD9zCid85UojD9B/JGd?=
 =?iso-8859-1?Q?jfk/dNN+W3O5vDgtY1kdmNJfc/2V/Vs9cNSbk4yVbXV1koqRzuBMOholmU?=
 =?iso-8859-1?Q?UopC/0cInFbDNkuMe19cT1U8ALCRTHtcQglrEasvjqH00pSacIrMk1YuT1?=
 =?iso-8859-1?Q?jWccRxkYbvxTW6ay93n1aKU+p+StpXJ799BU0EvPk8YdzJW1+Nx9XSUSy3?=
 =?iso-8859-1?Q?n3xtx1GvE0SgZd/UuyxtGQx82xL8ZkcBM7VwomPuuqk20JG51j8AGKUycY?=
 =?iso-8859-1?Q?JNH2qyFBleEMuaXXwgiDSEupnAXuMJ04XiZgEiOP6VXlf7WO5odYijybmV?=
 =?iso-8859-1?Q?Ui7zXOPk1UnAbFodOm8wNrPQloU0H3zILLXTS377zSGLG0e6CFo8SeOpnI?=
 =?iso-8859-1?Q?5tSyrTszjl9I1pe7hVkurv/OJthKdncMoyd3fkGdQtA55b9FdizyYVPUjh?=
 =?iso-8859-1?Q?g4rhU7ntLtB+5sthkHXFw4pmPC1DJcRZc8TsqTFYzE9iAuo6zIHgc6TCrv?=
 =?iso-8859-1?Q?RST/3yc5fnPLiaSpMZnXKyJVK8UlUT9pqC3aTkGF/3QnGphHgJhxgL8vRc?=
 =?iso-8859-1?Q?7oq5lQY0WiDlDN4MqicCUny9zywXUoBW8wSuLpLZflfTGTxzlmDX/BckwZ?=
 =?iso-8859-1?Q?i4PmhOzXTXk5YV8p+8iBfnOEQkFxz7gSyI6fjg+RXoKcdEn04AjzCEbTqp?=
 =?iso-8859-1?Q?/6uBFjSoySy4SCc87P/aJoirhQCNB6/ModBcFSKkCh9gZvW79/qiKIaibF?=
 =?iso-8859-1?Q?DnL7dqSVAtiNJo/ubN9VN135RM7J3JfUx1kdhR/bgQXp3Emq1A2kM6w9HR?=
 =?iso-8859-1?Q?+DMF3WaOJZEOWewWaE5W7arqSftHSy7pWdiY5Zy5Q6Jc5hQXun2Ko1+/fC?=
 =?iso-8859-1?Q?Wqh+ZauueLSH2wKtTX1TJ46zuEGVsyz77x7reGJs+EoqdFGuvmV/pU5QBv?=
 =?iso-8859-1?Q?g0RXoI6QheNzDZu705R3UwXvCCuJVAZTXSdxaN70yt8pcXylMAWXJ+y9VP?=
 =?iso-8859-1?Q?XPap0jWTF7iNjRQtwb7ZU9eR32Ce+YrI11zH9ZKaVsLV0lZEUJ8bVpBSrX?=
 =?iso-8859-1?Q?NxBx6t+1DnEFWkJbcD/SVlhs/USPEpjKyh19UjhXmFb0C/09D3vZB0uxUC?=
 =?iso-8859-1?Q?hsya4pwtppPJ+vjrg3A+6pgTfZ54Q1kefLl2OIpj5qWql4heBUmjMdz6rJ?=
 =?iso-8859-1?Q?joduPEFn9KlrI5vp+9WL7SmTGenmNcJj5y9+skHDh754TnGMzuTEDNDEf6?=
 =?iso-8859-1?Q?BFcY4/wJgBF1r7nSC4+esnLOOuZmbLe2IS/i01gBH13hI3vEzUPCq32vy4?=
 =?iso-8859-1?Q?Yk4DVwtWB6HA62IRg/qcrV9CpkqrWwn/hMHVL/a7PbbiDlZ3Ta77AN0pxh?=
 =?iso-8859-1?Q?rKUkikbRODQqJKZcRqTj28X+U4aoO6koPeQHhlo3rQymU0xj/LfqZTqpv8?=
 =?iso-8859-1?Q?o0hPLo0gs+uLT6riTW0IlfeaPgYkmZ7+hGzHcAokUamjDHhLnqeRKpcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9eda5f-a438-4203-6c58-08dae2998010
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 14:50:13.2623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PS9ocrx2nL1XQyOOS3rjyxk4dcHx+BE0+pvFXu3zA/kIhm3m6CdE4CHpywhDwQ5JBmrfNqVftNtDMt9rnQwzRcwaJq3IeiXZ2Ytem6XyEG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB10115
X-Proofpoint-GUID: w7Q0RQVzua-Rx8zOadUQG9YAYbk4Fq-P
X-Proofpoint-ORIG-GUID: w7Q0RQVzua-Rx8zOadUQG9YAYbk4Fq-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=973
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data buffer for active map is allocated in alloc_active_ring and freed
in free_active_ring function, which is used only for the error
cleanup. pvcalls_front_release is calling pvcalls_front_free_map which
ends foreign access for this buffer, but doesn't free allocated pages.
Call free_active_ring to clean all allocated resources.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 drivers/xen/pvcalls-front.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 1826e8e67125..9b569278788a 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -225,6 +225,8 @@ static irqreturn_t pvcalls_front_event_handler(int irq,=
 void *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static void free_active_ring(struct sock_mapping *map);
+
 static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
 				   struct sock_mapping *map)
 {
@@ -240,7 +242,7 @@ static void pvcalls_front_free_map(struct pvcalls_bedat=
a *bedata,
 	for (i =3D 0; i < (1 << PVCALLS_RING_ORDER); i++)
 		gnttab_end_foreign_access(map->active.ring->ref[i], NULL);
 	gnttab_end_foreign_access(map->active.ref, NULL);
-	free_page((unsigned long)map->active.ring);
+	free_active_ring(map);
=20
 	kfree(map);
 }
--=20
2.25.1
