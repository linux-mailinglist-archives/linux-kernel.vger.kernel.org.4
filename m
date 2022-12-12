Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8930464A2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiLLN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiLLN7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:59:46 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2127.outbound.protection.outlook.com [40.107.212.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64918D76
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D13Zc+e+kXGh9aVvrpDLiF43Z5/B7qbx0864n/PlByTnxjrfVS7zEfeuX4sFcAsdVZz963NkVoYvcy+k109n6bDHrvJc8luL3ACnwF27qDy28nP3kZhMdizgxmwe8BwCmKNrHpNbFEfezwi+wMQkq10w+T/HqgtJ+93EtJ/N1/ncMlz6wizSZHlmOTyKlcev4zK/z2SHEuFlCs0LrlI3MTmbWat9tkLc+MoALzJj/D7R1zMVIjc7DNUCzwGVhOVKla2myjU0c2/miJQiFTJESPHGU3C4Fwy0CUEDRp1nTJplHWr0Nq0RdxFWKGEKHQIrvh0SjoVtckLSME+DiAlqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBXY6I7S0dmVTsHZ4S1xWU60MwhFiHt7mBQAOX+BdDs=;
 b=K7TlEVELbHV/BkaxhxJ/+M5x5oGGH9zYrHabwQrr4JDbs5g7y5MCcB4I4txB7ipdFMmDvmLCCBFTJgxn31F21zw+XgFTYTCeHQ3SByj3UVLSfHqmYdPC/C9qURN/1E203pSRmJnALMmCLNuHBD5WwcxbLraqGF/dHL3wreHv9jtHouD8mZtivN94EhPBdrxZVUYR/teKfkba/aX5Dy3TSmlVLsZhbwwxL0QcI+LtCBfpSumgl/yOo6w0eXLfJjJ0aR1mP77jhH5B6lyFuGcXVKVyNDoDA7mCUUOuyayxywHdK/hmGhGHSOX9NVvWDgbU0GvGGrnoVpC6+h4mQFgrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=designlinxhs.com; dmarc=pass action=none
 header.from=designlinxhs.com; dkim=pass header.d=designlinxhs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=designlinxhs.onmicrosoft.com; s=selector2-designlinxhs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBXY6I7S0dmVTsHZ4S1xWU60MwhFiHt7mBQAOX+BdDs=;
 b=ZsSwP0nH5l8YCrs7M1r5u0ES3VztvDCSAwaQocNVZWZisWgn0TutfnbHBPAAF7N92TCu19V6qWwaYBmEJYEzOp6X3CSy4vR3kOUfE/drqpn6Pheh1NktlI2e5vAs16gtcbGNvtFbYERumygSDPHv9CuXGMsH4S9pIY6y4BHzRmU=
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:a03:3f3::10)
 by PH0P222MB0190.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:59:41 +0000
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731]) by SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:59:41 +0000
From:   Kenneth Sloat <ksloat@designlinxhs.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kenneth Sloat <ksloat@designlinxhs.com>
Subject: [PATCH] pwm: xilinx: Fix overflow issue in 32-bit width PWM mode.
Thread-Topic: [PATCH] pwm: xilinx: Fix overflow issue in 32-bit width PWM
 mode.
Thread-Index: AQHZDjEU5N5gzAz0bUac4Z7MejjYMQ==
Date:   Mon, 12 Dec 2022 13:59:41 +0000
Message-ID: <SJ0P222MB0107F467DDDFB7392B04056CA1E29@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=designlinxhs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P222MB0107:EE_|PH0P222MB0190:EE_
x-ms-office365-filtering-correlation-id: a05d5c98-32f8-40b4-689e-08dadc491d9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUYCCMKnC7lDtqeOKePUtPXnfuolEJSd0XTSeLL3d1GvKxzef/TMM346LFJsOt87Q8BDOMEjdx7bXas3yCfnVBESR28iFH0A7pwCtTIi2wTeKVmyF79P1Lc1JxqKkplvCdiLjUs2j5cgHzpChATbhx/1HOuMUaGO6SSPRryXFW7ESPX4TBoFO5rvmZB3kdxGUMYk5mSrOGuJCIpS/bdRDh/Mpo3YsXCGlM1zEUpyDGK0VFMvygPvDrWcvPGghs+H1k6ZLq7jjAiXcNNSX1YqkVMov2OckbJlXkSthTBcIe5boBolh0DQpdZx1s6jtZnKqioXjDwaUgN1u8zsbo3Ywo4wsuZ632of3OvliR5wHBN1iMFFAqU9C5Ge3w73sDgcdXpqg17pFcHhEOiwXy8iuJRxjhrP9zPvzGvY72ZtGSolwCckDH2KIugtMjqJOJU8Lf9DwSAQG6FFmBW3pT1g4UZCsPV0fk7rSf1P3C6EJpjdWZxbWJf+cXUdm2xOZP9XxkfDJr997c0DlIeokUfPf4lBr8Cs4cqYYai6sGMW1aRnB8zrjb5teJ01Csa1OTo8K5ghksCSR79P9oAzefJQnkSTxJRiHb8Ck5T6D8iuqrYVuZkwttYroQaJWHpfEy2y01wW+M+3AhsntT+nnRiJeKYju3M2eztcJ7+F5Ngu9x1JYEFfH40NsPDOUuEs+VjQQ6JldjKj+MmP5NOtT+Rmcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199015)(5660300002)(316002)(52536014)(8936002)(110136005)(38070700005)(66476007)(66556008)(76116006)(66446008)(26005)(41300700001)(64756008)(7696005)(9686003)(66946007)(86362001)(8676002)(91956017)(6506007)(186003)(33656002)(83380400001)(478600001)(71200400001)(2906002)(55016003)(122000001)(4744005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ExRPXCDj9kE2s7rpl41ZP7GyHVtseTsw7SXjhEwUE+DZ7Hw+Pgpq7F9CKl?=
 =?iso-8859-1?Q?aU7SEYdPfg/jEfuhNwdoLpgu1H7+u0ZSyvueaOuXqtL15QoOTkSyOcOHf9?=
 =?iso-8859-1?Q?Ijh8l1t6a8ubYVxtu57oWDrkB/8eXd/GRJU/27dGKWJAopFkYF4X9tIMAl?=
 =?iso-8859-1?Q?SR70g31jebtLQ9WU3qgeg2hVejhGg8N62afQ5lYHf7qr/1ACbvJi55xhQR?=
 =?iso-8859-1?Q?sARB06xuOiHwo9iqMfnb5JbZvhiEbdeXUG7mSxDbkd7NvlXNOJ2ELrHd9Z?=
 =?iso-8859-1?Q?fMFZrILgTAdCHzA0b3a4iyKNBW/uFHPCcSsrxYOrQpXd7gnLCU+0jNlZP5?=
 =?iso-8859-1?Q?mmJCR+RXwafuUdTfr5et0YFNE3HYU1zJ+WwEqxbNOY/BIQ98xCkHoGZEdq?=
 =?iso-8859-1?Q?JTM28NN0KvYkRrhOuEUzhnIuDQuPFUEOeiFW8Ap9v22s2HITBJKpMQMTgs?=
 =?iso-8859-1?Q?MvyLrP0fdLso44sAS7/GfpQWHwiVFqEU8qNJh6gXulLftUXKawa16YrEbF?=
 =?iso-8859-1?Q?lTthwo3coEfnjjWUefjIVePSgucuUWv9IfuJpd9GRCZ6IiXFiAVOCN09/0?=
 =?iso-8859-1?Q?JKrD0YqgCFm6QEIFIEa07WTfFSFbu8bEbZB99X63R9suGi0JltTw9sId5X?=
 =?iso-8859-1?Q?F1geZt9h+ZNQDtZX0t+MKAWIrrXwsnNoRbmq2i5HPHAx/J7P4XU/VbXTC1?=
 =?iso-8859-1?Q?OPeFmv9wYDo7ONulqZbodIVywyUN6eB0F6yMIvEHGY1ki9ziftw6zsmo8O?=
 =?iso-8859-1?Q?xou3oiYXedK5fqXFXYyACl3oGjDIMDTB3ablACMrH/TBbVk73vhRBeQEwk?=
 =?iso-8859-1?Q?u354+GHKWuGXqi119ML2m/fVOjqX2PYjq/CrvKHORF07SjWqNAPgYHC3co?=
 =?iso-8859-1?Q?dTChlI4spDiNX4Zfm5r1x1v//gjZdvPFqBDSplic1xXHmp/2JBY5fc+n7/?=
 =?iso-8859-1?Q?bLIcqyrTZd1Waf6FE2EfCaJyvoYjrczaFw8SX5nl/X7StTrgioTeUjCu43?=
 =?iso-8859-1?Q?2F8Paghz5Seytvas5QiFAcgKax4kzbUmzhMu9WweETQV1cd9iHV1Mjr32E?=
 =?iso-8859-1?Q?fmOr1IUEfbUdycZCVLJ9BJH+i8joI9OVYvaF8d5hlntQiGjGfDqiqvqiPp?=
 =?iso-8859-1?Q?ck6Dn/WdKzs+xjrhNWkuvEJvBoHM1u1BFa5rw+oR0qVRJ2pHIHfq43Rki6?=
 =?iso-8859-1?Q?SE0Vrqh2ElYlj0HP44zl3DiNVx2g3HdeT1g2gABFNh9JeLh+QKpl4wijm0?=
 =?iso-8859-1?Q?Jm1WCr26nxErcO2xd2KYbYcKzf1s8umxAsvae4DNL5EVM8Whh9yLqkoTom?=
 =?iso-8859-1?Q?dOeNFmnE1K8Ul8FcPz6noWG4w/88BGLJ4IDL9i4Sc7RcekZFLflyhwjs4H?=
 =?iso-8859-1?Q?zizrBBq5DRyD9sFQhIQ3MEYrZdOJyMb0n1pMINpMzNDZEwVqCtESY7nFaD?=
 =?iso-8859-1?Q?b20p8ztQOflKNcxBNtCq2QuJ1HIGrOxd3V6CN5kfC9V3IfCnDH/7ZdMzfU?=
 =?iso-8859-1?Q?IORy9I4XNPN/9icKRUrSnqVj+84DsPkBjuyoxV3mDPeDxtsKjFTiCT65sJ?=
 =?iso-8859-1?Q?FwABdS7h3d+k/MrvrVcsXDGefvDgtTiZMa7TQDI+MbHMZrk/KRG6h9vt2Y?=
 =?iso-8859-1?Q?Zl28EyQbTYCcQ+jlIQSmC7/SPpuIp0AJP7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: designlinxhs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d5c98-32f8-40b4-689e-08dadc491d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 13:59:41.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 21db78a4-85a8-43a2-9030-593b170ddfa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEJXUpXuQQeIXEfstkeAJhyeVhTUFuiaJ9FoUrvw3hx3cTCfB7Phk0/rK8pgnuZC9SdEtYkGpkh89OqOF+47CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P222MB0190
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This timer HW supports 8, 16 and 32-bit timer widths. This=0A=
driver uses a u32 to store the max value of the timer.=0A=
Because addition is done to this max value, when operating=0A=
in 32-bit mode, this will result in overflow that makes it=0A=
impossible to set the timer period and thus the PWM itself.=0A=
=0A=
To fix this, simply make max a u64. This was tested on a=0A=
Zynq UltraScale+.=0A=
=0A=
Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>=0A=
---=0A=
 include/clocksource/timer-xilinx.h | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer=
-xilinx.h=0A=
index c0f56fe6d22a..d116f18de899 100644=0A=
--- a/include/clocksource/timer-xilinx.h=0A=
+++ b/include/clocksource/timer-xilinx.h=0A=
@@ -41,7 +41,7 @@ struct regmap;=0A=
 struct xilinx_timer_priv {=0A=
 	struct regmap *map;=0A=
 	struct clk *clk;=0A=
-	u32 max;=0A=
+	u64 max;=0A=
 };=0A=
 =0A=
 /**=0A=
-- =0A=
2.17.1=0A=
=0A=
=0A=
=0A=
=0A=
