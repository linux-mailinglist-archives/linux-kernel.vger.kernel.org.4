Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268986F7A37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEEAxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEEAxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:53:39 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3DE11625;
        Thu,  4 May 2023 17:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBjVwp1193ahbuGuYu+wNd4ERFAfk7JWY4k8n652zg3rHy2EDYToABYyYWrdw7WHMckrJcudmTeglWngOrqeSNrz018RXYzerOP3+zAvZfjdXQFcYFqSeKrvW13kd+onYA42dYfGwgV2l8+3IVM6LldbrbPt6toSMNIo+SH9VDQFsNM5vgOCVHOBNI4OW9iDXLPkLucjyrmExj1D/xKjnJc/NGMgd/wu5lTGWKUVFzcX/Dh3Fvwm6liJDoigSzd+3/GqdiS+n3yKHKKTEKnWKeoG7k2y8UGeoDjwoMRpoVB9irdYdCsPcZm1Uj0iGYTPdF/79RNjc2usZ5541W1Cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbysqy1RMqxJqVYIq773OBQ0XCvAucxKsvS+tNM6rYA=;
 b=Kn5PFrKq559DBlNpnP6iI46Hb+8cpVb72R36pPMrVnO3AP5NjTSSAfgDBnYPOIS+wM4WeysfXcPY5fxbRjiVgc2MaJdeSV44Gt6Gwbs0v8kqH3dFRQ1iQHxBWL6f6ukegedMguqoQ65tIXPqAq0PpsYAqlJCAnP3y6madWXNoz997X5BF4PhAiapn8yaotx1sun5PEzTHchH4/1V2iohXEHQwo3nS5m/xrhRwEf2X3ABaTBlRuS2E4+ut4vwj71Sz5OZxGScqGvReRVrbVLo/HEBldkxPzvHgbQ4Lxiij2Ka95P6ZefpdA08SRpsyFPixjKBkEQgtx6RziIxpqBubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbysqy1RMqxJqVYIq773OBQ0XCvAucxKsvS+tNM6rYA=;
 b=LYFr+aVNUQqEYQgHM5Gem/Uv9ZLmo3wb7MQMzft7e6hKcY2e/B2wh0bOJHEQu6hE1jEPnvTnv73ethxdEuG8llH70QyN8lEKGgnzRLW86EQ8EUHebi+CCwXH2gIAFTbBCN7wxrIvYyxDg+JG5UHYJxq17fj69C/0CFTRa4/EZWg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 00:53:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 00:53:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v4][PATCH] pinctrl: freescale: Fix a memory out of bounds when
 num_configs is 1
Thread-Topic: [v4][PATCH] pinctrl: freescale: Fix a memory out of bounds when
 num_configs is 1
Thread-Index: AQHZfuF74rzFVHCVREWkPCOsozeZb69K2iMQ
Date:   Fri, 5 May 2023 00:53:35 +0000
Message-ID: <DU0PR04MB94177E959F6A18D4FABE8D8B88729@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230504233736.3766296-1-xiaolei.wang@windriver.com>
In-Reply-To: <20230504233736.3766296-1-xiaolei.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7420:EE_
x-ms-office365-filtering-correlation-id: f82474f5-0e40-4c8f-f273-08db4d0327f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPTKk3jQHulqdn/sotNVrmPxE7JauissGtD53+7wmr+u+qNipU3jBUQOB6JuydYynmDA1xEWiWffOWQOse/YqWdV3wajPFGibr4iM8lDAuIf525mjdCKnKoVmYaixJyJLn0RkW9gJLhmyQa3+uMLjJSYiGDz57ql2iMjtyg0kOGz/+5P65CMWy6CC88mpvJx2ulmp4i6LgzZ8shuDvmWJBCOifMt1D/xB9YYdCtKgJJcBHGwORnVdcI/XzbRf14mA+dr6/935akcs4AZz5qhn77D40gu6G3N080KfUuFKGtFckUDkbUHzzExAWYwTcC/RFnfgVeiLnq3xaZSMgoHwUVuJVZoSmh9HSVhOXGUTPWqtBeOGraUp1J6s71xQuZ5ox6f7vIhFqWVJNPeLVVRR+dZq81dvMOlBWq0SlExZQmF5L4rl0PdxfyDuYSX2WCYE4nXHE98RCm5HVnVFMrP11gDICMfN7h2V1Im0aVs8OMyPAl+eeVnfhvz+syrmr/88oFcgjwzKSv82ouiVafSgHgf/K/O63L9EmmOXXrB4M6ogIDpemekGrkh3Wqk8TPZQr5ewx+J0ZYM5kKbJlGcAnSciHmhZRVvI7dGUJ3ziAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(33656002)(86362001)(54906003)(110136005)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(7696005)(71200400001)(478600001)(41300700001)(55016003)(5660300002)(52536014)(8676002)(8936002)(4744005)(2906002)(44832011)(38070700005)(38100700002)(122000001)(186003)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uS0zfVbeYChRJDqBBBKziK7UUDrzVfmpmLJ4rzlWwxqJlMDmxoOPk9EE6PRY?=
 =?us-ascii?Q?3y1kU+qRVkWL+AZ0l94vquxIJFzTOcwM43l7mcJ72gbfnIroyZj8i51W5hwI?=
 =?us-ascii?Q?umSFQXg1ZMMeV3CRLG2Iwf96sQ2V6WAgi6FxtYHQLtn1LyOidINp+YDp/yP3?=
 =?us-ascii?Q?JH98i+PUMLc5QSHmb2LxBnW5ZSsrjv+C7NKO0vIg1gxWRacBFspSX8gp9K3T?=
 =?us-ascii?Q?/KcjxIyp4CGWEQQCMTKIJ7Sv6jpZ7aMqIqcRNmlLuRcRTaHMgV3fB0IWNTTB?=
 =?us-ascii?Q?YPczTX31k9IKHUq+u21RWIBsV416GrADlHKpSvBdRqlpEyoT2+qXLQA4CzIZ?=
 =?us-ascii?Q?HGsIdlJu3wsMXSsZXV5YJ0MY6mxwl6JK3dJpORLaLE1b7uIT3P//SsRBOsL7?=
 =?us-ascii?Q?5zcpMn36IKp9EF8KLqJDz12HH0UPLsGNrP5e34DljLieT2BxhjZNQr8mOTpJ?=
 =?us-ascii?Q?jGCuZ/956htY5C7mtDu/HZ+vJMwYFZoshwdYmWXybL++0Y0MO01WTxUCChbf?=
 =?us-ascii?Q?guqqwskQhaBDOzADkpCgXMtocLIG/XI+38drYP5p0uqR5wC5EfsZ4K3jT5ul?=
 =?us-ascii?Q?iZiJITnDxQnTN38cCxjb2xTzbkPvayoAhDE8lBr3MryNH71CIgoInYPdL6O5?=
 =?us-ascii?Q?oQ4kH+3+u5z35QXPTaWdFE247jB7HkhHlqtTp0ei9ULMmiAF4doALtAsmCTz?=
 =?us-ascii?Q?4AzsNErggZ3f8yt8x8DaNVxalosebsMI3sjQrwkP//5VseMN6ver0lF+iXPG?=
 =?us-ascii?Q?eY6JFdV8QaSff/DpuOJgohzCqL7gELOYS4xi1Pj/LW8fZ0Eae+xS3P1NitzD?=
 =?us-ascii?Q?kxYkknSXnwBqqSbSq8Rft/qsZmbVlwKq5eBEgCheNS0paJDNAx07JEASajRf?=
 =?us-ascii?Q?cpme5Jh3JAxGy/xi3PuMweZBbRFiZXxJotCE2kjgUPD4GbgYrew4gTRd/hy5?=
 =?us-ascii?Q?y6hpRyhQxMNgCBgHS9hXiGiqZfY/pa/ZkPfGmBwpwSBG/FhyLAtPfrTPGdcE?=
 =?us-ascii?Q?5H2PbD2vQ50jU4KbshTzdgYXcAtsoBDqMKdZ8Jq2OVHtid4WEnq6nnT2Kvy0?=
 =?us-ascii?Q?nD3twmcY9ESYDnajpMrPGBr7u3C75/PP9RUsTBk1QrVt+m7O8Rs5a0JQYgK5?=
 =?us-ascii?Q?7RjGG+Ssiz5DcA+mtRRpADh/eaGGFO+4/QOYpGtaUjAzO6KgbD6THmtjRw9o?=
 =?us-ascii?Q?8HrI3kquKWc47GlFmcpmFGWlZQupfiGuzcm8nQMBEf8gLoKLQsTmpX4/8jPc?=
 =?us-ascii?Q?Nnxm04yHckBnBxfVLGsjl/rljruY9qOUiwjHcTdncLps32h9Cc5E2CXrGlGN?=
 =?us-ascii?Q?cn927kt5L6XOR2hDYqAjN32hb0PZh9FCNVLZ5iw8nDJjVTJvF0pbrJagr7iR?=
 =?us-ascii?Q?G+ImzMPIyfbJC+oj5PLbdoreHhlczL1I/ewuy29EmyYUE0caFllmJTHQKu19?=
 =?us-ascii?Q?h8oaaIpsWeGsABeBbWzgTvRinJ7L1f8Dp8auz6V2Y67cLre8ehHuyGI/U1UZ?=
 =?us-ascii?Q?gA4Ljd0E4huqXGuVa4qlS0EjVvrH0CKqnf3kHGFvgot9v98NdvRztmJMUg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82474f5-0e40-4c8f-f273-08db4d0327f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 00:53:35.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyGSBLASIP00p6WMBkIeOQJfn35q750Y2xILLb6CyyZNNKQuK8WctkKA0rm6nxvvIR8f3Rg2o7GgCtrR6uhhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [v4][PATCH] pinctrl: freescale: Fix a memory out of bounds when
> num_configs is 1
>=20
> The config passed in by pad wakeup is 1, when num_configs is 1,
> Configuration [1] should not be fetched, which will be detected by KASAN =
as
> a memory out of bounds condition. Modify to get configs[1] when
> num_configs is 2.
>=20
> Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
