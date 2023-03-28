Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAB6CBFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjC1Mti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjC1MtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:49:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2852AF19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAJ5b6pzGv4q5PfmRr/M+WqRnJP4U+l6w0V++6+QylJrEb4Ntujexd6ztccrgXYGI37XFLfH8BK6fDeuYH5SjLvJU62/bnGBUFiIxG7Y2VxecXTXW8YgqXQfRT5QDwpoFnEFUZuqtbQbg3vU3vmaAuaFO0FxS73mPXS8EejvvFabs4UbnBG6MP7I2/9zAyn8qTzrNZ9F8GWv3qEVtm1ws6Mum/HqB6Pw/ZQPyeYEccbW/SPOuoUUcU5UxMKXzv8qe82IEBuBbHX8vgqdAWLjOnsPXsJ4rsyPUZrUYEtYBlfPtJzf3UdVATIAYSfr5xYx3oFLsKLQ6n3VGF7xLgQFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CETlJoIwMSRRQ6csaoKhHkHSTQP5vxaTamqrxUbLL1s=;
 b=b8wAukR1YI7haXD/KTrjE/hyiqq58+FVpkaYCz/QyME7gc/JvTI45i6dd2Ahf68AnvfQHHsBulCaIKqrsZETj+Cls+650qSdG1cPZ1n0qCYNsp6SBHNPWRX+e2F6fBOfDWpLTYcStlk9HVl3QlSAZ+udsL9ULjkwtPF5Xj+90xqp01hP9sPAEa/q3MPw6MEz0djOr08WLAtwEGtYnpkaAK8w/rsF1SyaYGPI8UMzjJRN5SB0UlEE7lHVr77d6x5bltbKAHQiEoGO1mXxcFMZYvuHFNjbGYEi9T0MpJvYD4B+PjRjrCYIOnDh/pD8v9Klhu9sfb/WP0GruF0PfECcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CETlJoIwMSRRQ6csaoKhHkHSTQP5vxaTamqrxUbLL1s=;
 b=Td1dD/8t4YnE/e/j9VfVPq9zeQRAcMOPD0cQ+x6mk6YJYph/WgIQo+UveoiWegiRORALsoh3ovhmsQEuCWENP/wyhKkXzWEk+8igOO0zQcjRvwR7fzYEQd8YXjggFyDdfARMvJ1ImWLZ3JSp03Ns/5Hbae1APjLvk4UZwG+MB5Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9477.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 12:48:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 12:48:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: gic700 shareability question
Thread-Topic: gic700 shareability question
Thread-Index: Adlhc42Zc4r7rB9RSWC6TTy/JzkMQA==
Date:   Tue, 28 Mar 2023 12:48:19 +0000
Message-ID: <DU0PR04MB9417388F9BDD73080294FA8E88889@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9477:EE_
x-ms-office365-filtering-correlation-id: 20c85ae1-7470-4664-03c8-08db2f8ab54a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 781dXj72a0lXzahokgP4JVtNJXrnqqbkxi2WNHO9vWavfZt1jFFDHKJUOEqqJc5kzUtqoS/qINu8d60j7j2f+1hpQqG9XvrybWdqely5wTFskh8gbKN3NzxzpaD+lkz0MHAv2U9BlgO/wT5akSMunVYAk7V2x1bregNYJg+CHwgbzfdRjGe2PZBDaNcEU6FDreUCL2tqqpBF6lhe6LxdaUUCUggFpyc19xQHxPkH++vkExHyFl+S5GDDVmN5Ii1JJpdbzbc66DhADUnqWnc8D/RGIZDuNP9X9f9rp5Wcuu34I2Fc7nGqbu8AMyOgbVf7k5DbL2WrCdPbK3Wk/Tsp/9/v4shUdPzaAXFTFDdkLXGVAnsJTEj945Qf2UY73ASNEp06B3QEYjH/I8AbJVYT/jYydPPOPdJnUQnrLuAwwqtBM1utFzp9nxIQHDdgYwHjSApcYZ4BIyEkIXgvnUhAhHU5WLDxQMTuOuKYLQSXFDuU7u+QyTMS+p8pl+rLslswppu8QCrioKBv2v9XJmHt9HdaHQcjoSdDYackJgtyP5TSn+6zSLynUnw5fVQjM5zvLLsIqg3W3L4/72xiT5U28Hkq2F+ifHSR33cZXBMxSBYsQGdPopo/4jZ8btVNeEbs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(41300700001)(44832011)(52536014)(86362001)(38100700002)(33656002)(5660300002)(122000001)(66446008)(8936002)(7116003)(478600001)(71200400001)(7696005)(76116006)(66946007)(66556008)(64756008)(2906002)(8676002)(6916009)(66476007)(4326008)(55016003)(6506007)(186003)(316002)(9686003)(38070700005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZuJjeaSxJXkMr/S8V8hHxgal9HYCto6astN7UBXHD4yoll5FLRvwcsJcEwJ?=
 =?us-ascii?Q?GOmsdGIz8KCrZNQIYcusJmtKjvYOEHkFUZQCY4uzZ9An2UYaBV46CMzDnFQf?=
 =?us-ascii?Q?Zj6Ssj4eHZmTqIxN9Zxpe/5K40GB4Pp5FnpqJtY1EnZ2HPj/PGSInJyt9HGD?=
 =?us-ascii?Q?BwUgW+p/22S5jDhhZWIWcUX6bmYGHWlOM0gzS/aBbyqFBLJyTTf7xb4gnABp?=
 =?us-ascii?Q?HcWFzXMgerqgOjhjcDv9RSwFsaBn7TWyCQVIepkynaYdBuBqQcji5MCPUFFZ?=
 =?us-ascii?Q?SNLkJ5t26sVwKKD5cX8KpY6Ubts/2fi2RoYD119q1sQsBFBLfiEYVs/RAtQp?=
 =?us-ascii?Q?rPN5NtQGz/sOUpI2ddy3NUKtX1yQwoWXu5Wdm17rqzEQxIyVNdSJibnnd/Nm?=
 =?us-ascii?Q?l8o0xpwta+K8RASAhApPnkkueb015omPIB16gqsK3EmeOnwuaVbZCEZCjJPQ?=
 =?us-ascii?Q?l/O83egLzP3o5GiXuHz+4/jLX34N6zHCJDrTvGRi5AESk4Lf8B/hYsRBRxvb?=
 =?us-ascii?Q?fDy40PntUfNZywSeIuf6XIGEWaRMHDfIrIHM0tVz9LAvdBa7Qb8IK4jh8EGl?=
 =?us-ascii?Q?LSyaYEC2VQYaw/33UOe8xqF17HVP8r6dSlCS/z10KB5vQkJT+rHVQ/AW1FOQ?=
 =?us-ascii?Q?KAVu5jyVxISvBBlT65z7UcVVKUiHC618PgZdzhtLQkgAjGxF0YQ43HZXS7AB?=
 =?us-ascii?Q?cGG1zVQVDmexvfB8YhL6Jz0l1zURdrF5aK4/GWscS2nhrPUNf1dTiHXCBkL5?=
 =?us-ascii?Q?vPcqbX92RbJ28VrRZkf/WVBmaCPkPSOZF/gHlSMLXgU2NGsYCppLR6z9opry?=
 =?us-ascii?Q?xOf5QTxOvly8Z4WudOR0U0XwDqFvqQQRexk9T/hGggPXNVurocNAfU2aths2?=
 =?us-ascii?Q?Td3Zodc2pDPx7fshPUC/lxmqdK9hveO4G1xmjxiDjc0eC5mlE2AroOHexIoK?=
 =?us-ascii?Q?DeeHZb4XNqTDqtc54gPUNFk+tR6/pOBe3CUKMIhXlFgDWn5SaOs+MUNZs7HV?=
 =?us-ascii?Q?CjmUgQraCg/U5mZd2dnssUVID5OhAYdJD6PLdq04/85ewA1ykOs6R/DRk/on?=
 =?us-ascii?Q?mYq18+9AOlZ0xdMFpqEiYP+CzL39dd4pwrkPamHFI/qLPu+oUiJTr483y6OP?=
 =?us-ascii?Q?gMGL8p7FAjebYUdK5fj0Xej32Y8WltAidpDxz3joQaoUgisE7J9IZ7E60S5Q?=
 =?us-ascii?Q?ng7PrrNTxPURlmpqlPFnqN3tbET1i18UmRfcIalPJ9b7RPZ17H/hPQT07TvU?=
 =?us-ascii?Q?maGu9I+/b+0IzkG5QI3ulRB++k3pQNGuKL0O/v37wRYp0xQfGNDREpdbkxbl?=
 =?us-ascii?Q?+NEnMP79+L9hNx8qgYZ4fKxzwjTEZ1sokX1KGFtVK6dQlNI8WMX+zGftiCf8?=
 =?us-ascii?Q?9ZP/DZCJFMqUj71BnPCZG7gRciDlAp0mIpIYYhhFqBZLMsO7rlZIGgpD5RK/?=
 =?us-ascii?Q?9yr+OEqEKnqpDKbEdsAI9kWzC+RuxkIPRijxYPQ1DH/KqqZfgS86O7HQ1sqm?=
 =?us-ascii?Q?bYt5Goj1RJyQ2wFBE2KoMedjYmd6tLFDHFm7FkBqnPi5WsRo41C76ICn17jS?=
 =?us-ascii?Q?mX1IQq8ZLfq5I4iWWVE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c85ae1-7470-4664-03c8-08db2f8ab54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 12:48:19.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hP+k1v3OnVwEffUlwcwg68Ian0Njw63czBimfy480ydU7ledkST5GTU5LdeSW04poztH9OEpe8jml7rdhxk3nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9477
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

We have an SoC that use GIC-700, but not support shareability,
Currently I just hack the code as below. Do you think it is feasible
to add firmware bindings such that these can be used to define=20
the correct shareability/cacheability instead of relying on the
programmability of the CBASER register?

Saying with "broken-shareability", we just clear all the shareability
settings.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index 973ede0197e3..56c4eaf20029 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2359,6 +2359,9 @@ static int its_setup_baser(struct its_node *its, stru=
ct its_baser *baser,
        its_write_baser(its, baser, val);
        tmp =3D baser->val;

+       if (tmp & GITS_BASER_SHAREABILITY_MASK)
+                       tmp &=3D ~GITS_BASER_SHAREABILITY_MASK;
+
        if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
                /*
                 * Shareability didn't stick. Just use
@@ -3096,6 +3099,8 @@ static void its_cpu_init_lpis(void)
        gicr_write_propbaser(val, rbase + GICR_PROPBASER);
        tmp =3D gicr_read_propbaser(rbase + GICR_PROPBASER);

+       tmp &=3D ~GICR_PROPBASER_SHAREABILITY_MASK;
+
        if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
                if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
                        /*
@@ -3120,6 +3125,7 @@ static void its_cpu_init_lpis(void)
        gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
        tmp =3D gicr_read_pendbaser(rbase + GICR_PENDBASER);

+       tmp &=3D ~GICR_PENDBASER_SHAREABILITY_MASK;
        if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
                /*
                 * The HW reports non-shareable, we must remove the
@@ -5094,6 +5100,7 @@ static int __init its_probe_one(struct resource *res,

        gits_write_cbaser(baser, its->base + GITS_CBASER);
        tmp =3D gits_read_cbaser(its->base + GITS_CBASER);
+       tmp &=3D ~GITS_CBASER_SHAREABILITY_MASK;

        if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
                if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {

Thanks,
Peng.
