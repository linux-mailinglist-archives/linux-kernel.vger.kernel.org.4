Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AF6B5978
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCKIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCKIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:23:28 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E758B46;
        Sat, 11 Mar 2023 00:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnzjM7j8tbHolMBklpzwZ5n+Zgjv91znhytJl00YmF4GHzYidy34wjk3ICkCiDVxClEQaK51N6ltVTwpekUqwpmRXlUZ+2kFWApSU6xinXZl8ZseqOR7OUeWVqdBbAt74BCPc8NFu/Fmh18BbfrlmeeqqvXgQvjpUMQV5FMOB5+tb4fnOW9bAy87Fk5b57RbmEbIh/R2sWDW2BV+3oAhS2rJ/zKYznCA8oypWzSmDvqCickOOZwrBmYA8iVALsaAHAzmj/ySclLULGoFaQB0nb/to4oOVcaSz2CUF4qF7u911mePZHmQGFBAbtEYfxezBg6HF59MqXIN3HjGm+wnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDNJ9ykrH21XEAh0aZVDnPysLc3w10jWh/bM/BZEF6M=;
 b=WRpMsuBqiJB7WNzTgannTCe6i79AoUc6PPEb+nPSAWyakCB8pGg8+lp/Ua08Y3jfmZEdPWaYrIDEKxxdn21PeAF1pTVIyZQ7f/JZriLFQcmda54tgrsx9TEIMdeJxudUss1vtm/9hlwrCSbR3gRYnplJOtd+8SuDqzy7AguyeeseHRSTh7xHGUg1zCdJaE75WDbar1lYzOyc7EU2SOTnjyPrmtlyXw4o13Y18v9y1+w2CgzigDmqCG2m8j1hw/+1zH0XOx1VKlu8v1JXMDefLErvVues7CCOLzgwqP0oSI43DC5wQ3VYDiokTl+RPcr7HjS7jYkN3FYmDHAPqhw9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDNJ9ykrH21XEAh0aZVDnPysLc3w10jWh/bM/BZEF6M=;
 b=MJ5Ju1PoegUl8wgCNQol/nOaXy90zPkyGs1OmhEf9dbY3TJH2LbqpTzxWpNwb+RoDjNLxwprR9w3poxb/oeSBrhAh2vvgNbA/M2oOPusTajEYFZu23Mp5STHWDiWc1IymOm+SSTpT/LSL9g3LZGmtpdXyyuxELr0NOqFJE5JE78=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM0PR04MB7121.eurprd04.prod.outlook.com (2603:10a6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 08:23:24 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6156.027; Sat, 11 Mar 2023
 08:23:24 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Varun Sethi <V.Sethi@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Recall: [PATCH] crypto: tls - Use data directly in completion
 function
Thread-Topic: [PATCH] crypto: tls - Use data directly in completion function
Thread-Index: AQHZU/K/SXMQoF6+2k+oN8pdiCaHOA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Sat, 11 Mar 2023 08:23:23 +0000
Message-ID: <DU0PR04MB9563528489757FB125757C5D8EBB9@DU0PR04MB9563.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|AM0PR04MB7121:EE_
x-ms-office365-filtering-correlation-id: c42f4bf3-7c8a-4b83-6ab6-08db2209e1b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQA5Y2U6qo/QbV+de3zyoYRaKT7Jr1d5kRgnvtzNLMYWvzveG1gmHcDX5ATGCJDZUxxNGAiafxmSEJGBoxpCrPDqbHm2HGcrhYmVrzYO9LH9YQ3Lv0DRGKRXZc0cfqZBO+Gys/Pw1/SQqKVapHR9iJ8ll5bE5wzh7ddUs81TcRL4Ji5bMhUCvmC5Dbe2xH8n0Qb/5AdVoU5XJTzlrgQQT3wgVwfGPXKmSgFPbkqO0Foovc4uNC9qMDTVh1CEoFBsYXAFGg3HFNgJ5TwgG5zpPme1+5UV3tRnO2wF2aIRvCxgGQbsefMM35dFklSMEax0HfXoUjsipjl+ZxNPy2G5ZLqrdvZ60LloF0mfEAZi0VgZ7UeostfSfbt2SIwUoxRdCdeZTJ+tVjzU5UXk/9G6qwdJKxrRSQ+gskNIhm/yiwAMQ5oilcz6Q4abWJYImyUabp2h+oPd5945g9B+QPZGWwqmYA9U1q2iP3ldWtz6ECFZ1Nw6QRkBhNSzzJB2EF/jrwqY9w2kCrtaFBSIOuAKNxYwiiKqJNMPolk+Ox4LFSSu9/iqm+MeZgnFq6Mlb9ik0Hx4A+8euGGFYU9OVBiooulT1rFF/m+OVSv13C3a0rQ7edQlJh4X3xWxPBTeh9u56yUEMkVVUo6exYrqZGPn2mBNlJJNz0X9xZo0JvVacCc1GqT6Gu6X8LnLNMWfXGOevlrESK7gn2FfSP0xi3uyLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(186003)(9686003)(38070700005)(38100700002)(2906002)(44832011)(6506007)(26005)(122000001)(8936002)(52536014)(5660300002)(33656002)(558084003)(41300700001)(86362001)(8676002)(64756008)(66446008)(66476007)(4326008)(66946007)(76116006)(66556008)(55016003)(7696005)(478600001)(316002)(71200400001)(83380400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hGS46a+Y0NK2ZlKEkUbMrDeyj0R8OPwJU/1F1Qe+sUuM1fDoVDFWKcL2uMNY?=
 =?us-ascii?Q?dTsBV1CYBa3FlovlS9IB1ltEN7sgHHQAEfO1+0+03uJ/D9ycxddTSaeHbQMj?=
 =?us-ascii?Q?Nfp0noeqoy4E8b5cvXJe76v2aBxQQPJntbPBx8WYe09fwAJlzOr5pg8NCUJ0?=
 =?us-ascii?Q?ds0ZNWD2/JtpqKvv3wqvSP1MjJOoPukpa93c6/UrIB30CA1L7ixmIkhJcSKw?=
 =?us-ascii?Q?OjJhRXxxC57BPBfYksmSn2AZMNK5zxkP9MyalE0HUmAARWhjsIsrFGRl2oE6?=
 =?us-ascii?Q?yy55JvWlmIy4MjF96Yhevi/WpYc0lHnvwCjc8iaU4O6BAf9g2CcVFcAVyj9z?=
 =?us-ascii?Q?0b0VdBsA1TQwYN8xI6WYXmQ7utNbYlG4RlMp0U2M3z6mX9ul6yPtDE157Sbw?=
 =?us-ascii?Q?SqV593015I1I3OJNO78HioxOdLVJ8dJRX8N9Yy1hItbYkAAUui4/pf7T5f8R?=
 =?us-ascii?Q?NknuNzLysjWXOiWj2hGqUJPpm41zD5UJxoUq9vjRGQocR4mcz3gqhizlIpgG?=
 =?us-ascii?Q?ssHi8nmh/DZS+ILGsl/Mx2509//xBDkwLkJBnffD+wy22bB9kdYZl4Nk3STb?=
 =?us-ascii?Q?STK+7uEqLVysd9b4PFJheUx+wbLTpAek3Sx1obM/LKNitdv4tLBho7+WPA7J?=
 =?us-ascii?Q?fOKLjVyn/5sM7YPQue7uZU2AhPrlKbpDRJjeb4q75L0wxYluwetAqqw0NyfZ?=
 =?us-ascii?Q?g/K3PUxxarwnIopOsuOmdTO72jEZkC9TAjxwIxI8fcujdz0O9dQ74S5Eku5q?=
 =?us-ascii?Q?7b/6GxJTkv/9vC4liprK2RnRcu9nCC4a4PmZhSv/G2AD71WBlmT+36MGtwfe?=
 =?us-ascii?Q?/Qp0FJsD6PQwLrdxA2gx6q1tKTsoJk0u5lsN3QA44gPyR06MjvA/SsXTxJHy?=
 =?us-ascii?Q?ixeFie36KZACk8pjQnrmEt/ePw6D2Alr56mRAvx1c8xrFwt5KfE+ZaYzvDGT?=
 =?us-ascii?Q?k0HjtrVeoeNYeqC389wA9NPgUD26efFe8ST6eQFHZk4Pt2ScidKOTTeWlqTa?=
 =?us-ascii?Q?abik9tAnEx+Bcppe3c7Vd+8pAcFRAhX3REldJLWypATq7ikTnRkvPUfdDxYw?=
 =?us-ascii?Q?/YE5ydQa5NJYTc02cnyI9FalBNyMoGOdmmGmTS8/K3ft9ldKK4FvxlL6MaCJ?=
 =?us-ascii?Q?JEDAJIMpk07XzXKs95cZ3CzjqHEzK0iOOHkveC1h1Kd8/BiygQ3Y5l0WPubc?=
 =?us-ascii?Q?2LWLUc3yiBP2uTa3/zA6POnJGM1t1Qvcv5bvSb+i1bNvd9nDU89KZOssSMKR?=
 =?us-ascii?Q?7fic2C9XCrW4nLzGhhPd592vK8pLgF4gvP5bDDHIeTdKEQiEsRAdRZcnere9?=
 =?us-ascii?Q?V4jl3j39e8LuHAsXOHre4TDfv+fRvcRxNrsMdcCyFZE3IagvAi2MkWx9Mu+E?=
 =?us-ascii?Q?t2ExyefuQg6dW3HA1kacCwwt2+0axLbzcKZy8CodCBiWlaFMqtKtf6X6wN1+?=
 =?us-ascii?Q?GiQiwJKYMu18w9FWK7sfDHhIXd6tgzDCA+IdS2BmwfdPN/i8MR44/IIQwoEF?=
 =?us-ascii?Q?ezpSwo+kNTkx6GA3iPgenk0Wp2x7kT/oEXEfVyY8QDt/2Eef6q68ajYtb0yp?=
 =?us-ascii?Q?jMp2uBANhAYvPIn8KTL7QcgnfvUx8a6pv7WBmQOEifWuanTPWeL4n8LVaHMh?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42f4bf3-7c8a-4b83-6ab6-08db2209e1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2023 08:23:23.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ws3JQ1gYrwopZ2UXUKmXg+8Sy6Zri5tReVH2sYZwNzjuVoJsGBztW1GmIPpygBqvlVyQVWKnU7cyGHNI75WG6rG7+5EIYpTrcGBQPANxlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meenakshi Aggarwal would like to recall the message, "[PATCH] crypto: tls -=
 Use data directly in completion function".=
