Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B855635B55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiKWLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiKWLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:11:31 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C784100B16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpB5a0Uqw87R3PGNxdv0LxOpVWUiCBcBZRDEdg3rQwyRNdMuUM0Jei4aa1ftTFzk4uYQ0J9lo7pne16s9pMd+k3fZYzjNCC1ToSlAhjMlHe5R6OS8NWwrlsW0WXcx67lb3J3RcMaxC+o3soD0wZmMkLj5DHGnS3yCjcyssdRl+acxekRVdVOP3elUqrXFOWs8LTxdKdMQ2akhOQSGcByv1tHRIrcSjTZUmpSTa1vhjA7jp/14xxN1GAPtnN3XYnN/k2LYhIOvBQ1FgdiU+E4BMjmQFRlWHQfV1SYSo0dJnYoNJAYwQoq+pYUJHKyrc5orLWCdL0tJ/8wYkCLRivyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c04yjazcdYZhijZdFxbyLhQrJOYFHrBCTFm604Efk0=;
 b=cxOuZsQwLTD+JmzrbaR/kALbEaNlcB4//hHqp/gQbHRGrHOG8V0BviwjGzyXXLUavARDX8wen7vz3WZVAgALHm6RGWQzrfXVA4arh6Tjc3DX7YDWhyhZHSyQj4fteVnJGsewLb58ecX+EM6OxxEexPi3K1cgoZubRsG9coUMyintvGMGHqQhXpjeftHYpZR1AM4lc96gi+ecmLDZCBFWliuEIz44dM+EFwzLtxvHvOV47Ux0C5fGN2jz9nJP3SXCQ/g2yIMXDZakPR6z/zhT4VotTsgJKqt0m4UkJXAqMr24QzZxlTpHqfeSuvQmISRTR4Sgt5aqrYsAjpKZMg/GdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c04yjazcdYZhijZdFxbyLhQrJOYFHrBCTFm604Efk0=;
 b=kePe1aHL8BiguycNQpnSGU8ueysDAsLqWMqQUU8QAJEIk8oGfMAhIaoJJ3WKPAwMaAhdiV6sKlq7ASZmuKthTvO9oJyO3naKAWHpjGFTiznuuwvewC3BhmbKUrjFuTGUvO3A99dd0kW7sNV+Zx9laN4s3zVpxk60acb89FegYkk=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYWPR01MB10273.jpnprd01.prod.outlook.com (2603:1096:400:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 11:09:21 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::6a29:a975:7fcf:6afc]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::6a29:a975:7fcf:6afc%5]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 11:09:21 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHY/l+MaQe0BDEeFkinwbdpBmr+Ra5MTMIw
Date:   Wed, 23 Nov 2022 11:09:21 +0000
Message-ID: <OS3PR01MB8460AAA98EFCDD2F3C707A17C20C9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
 <20221122095833.3957-4-cniedermaier@dh-electronics.com>
In-Reply-To: <20221122095833.3957-4-cniedermaier@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYWPR01MB10273:EE_
x-ms-office365-filtering-correlation-id: 49462834-77fa-42c5-e303-08dacd432c6e
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DtV2QFtmqi6cUINg0DilwHhwJ4RrvrE/XBB/Lbq5koLxyswQHdQtC/W2qBRy3Ymvq6a9KrNiL/7nX4MRyC30idkC4gekmBOOuJgdcVrBZBExoqY6E1sKhdbvrDSPOdORVCoxG1GBsim6gOq14aHlJbb5rzQKIXVDaEL2+fIrZZCQlLL/13Oyeuqf58ukmQcgVxJkKf9/4FyWfw91jqAt1xMV/uBe12uXC4AjkGW1vEMNdRq0yR6rS/wIyTeO8soD3/7ujwIaDwJ/Eig3wtW7SlkyLgyB2NJCQMaJffrH/kJ8bjrypLMQIv6IUgSQ9/n58ewUE/wgDWMYJqTap6+2UxnB0BBL0i9xnJF/H6+k34P+z96VWAMQoZ6NeLsrbQd1WpDYi6ZtNQKIQ9Yj3u/s/onoGxiSxKy7I9mA1+PR4BxyWKCNCRWs/90tM+9pEiNpj1W3XLfIiCUqcQo4PmDew/jAWPsaF9ooOJzMfrPxpQPxmBre5ei+UbZQ+atxbjmn7NXyVUlFZ77nWYSe/OjFnjcohd3BV0Mcdb49rUxFTqkltrDUhmGjNdO3d1gvOCbIPEOce3MdgnYDvtucq4hgFRXW53L8wy16B6mwpxQ+deDFsmPacXp60qTuQ+CoZVgNlDXtmdjYoezAS84/ZV9Dgm2wfQ7SQf4ka0pylXhvAED6tPjRqO5iTLPnJYHYJrQPyjNDAYTHiBsaV+nF4tD+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(33656002)(558084003)(52536014)(38070700005)(41300700001)(38100700002)(2906002)(86362001)(122000001)(66476007)(9686003)(66556008)(8676002)(66946007)(316002)(71200400001)(66446008)(4326008)(76116006)(186003)(110136005)(64756008)(54906003)(26005)(478600001)(55016003)(8936002)(5660300002)(7696005)(6506007)(55236004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gqUXl8Gg3XKY+0oOi8rpHeyFUhQ+p+R7qJknnG6ovh6uxPp9w9N6mU4Zw4wB?=
 =?us-ascii?Q?/JF/TSEbxzzMqqOVwVjO6TmrbJcyJrBTotomm5Z0B0JSLdcnn7rzTN5gl2oX?=
 =?us-ascii?Q?8/Q6QrBQ7uQjyaa610+k3QX9VDVu6uUJiUa0lAg8mVdyf3yahkWVi3qDRzc2?=
 =?us-ascii?Q?rzDIyEjCayIiKJwNP3SEPjMXQOu84sFzWnqkr8pRUj6xcQZClgn12HD5zU4r?=
 =?us-ascii?Q?UWJsZnwKfUI4gwS+vs2Hlv46jmsRA9oxD1KaTCMW8h4tG2RM4FA/b2nw1Hln?=
 =?us-ascii?Q?3Zy12I+Uqtro9tM51FJ/RoAtT1zlo3+UZdeamnRjdiZO9YWXd6bjT72ue5mY?=
 =?us-ascii?Q?U5zBHB4go9piCLET7rYHGbAkh0CA1WBK4o4wMY9PN96uyYQNNhZqiJYwLUGd?=
 =?us-ascii?Q?+CPooPj4v7E5fTKP54tMugDslNRpCAtLsYzdlmARDM0zxDd79ptTegofUHYf?=
 =?us-ascii?Q?/A1JG06d3i9gVEEdT2Fiqfti7mF7lg9xBW/i3PyFU1s35OfNkHT5rpDUnu8Z?=
 =?us-ascii?Q?sPF/73fj5a3ArCH+LFiSM3iKOcN2LqYyrtlKQjxjozabG2fPKcxplsXMuEhL?=
 =?us-ascii?Q?dHV3zW684SDerrr6SOzrANqQtpnme4Pb0XST+U668++Gnj0K3LniQbUn33Ln?=
 =?us-ascii?Q?B4kclqb+QoDlBy6NDFy6OlaVSVuVkXqSqS2q+HXi36PSQ/N00AdVYtcKIT7n?=
 =?us-ascii?Q?8CZ//3rfprQSe+GqEF7RdzMQlRwPtcsP09CmK/w26nP+Kxtti3M9cU9TUv7D?=
 =?us-ascii?Q?jUtsaH5Tv+Edpm42dLgotbFKP+sfxFfiHqhlelMy9AdSx7wUDOLFHikx+fu6?=
 =?us-ascii?Q?vp6SI8Az3rMSAc5HN2662l9DL4mbqpysr3+HbBLY8Gc/46G8uQW7Yr/n/icE?=
 =?us-ascii?Q?rHP/RRe6AlfLqFzBIjxo5vk0O3oq3zzeanaVwRR1+/U6w6cRxOqG2TNG9GvG?=
 =?us-ascii?Q?QBwI2iR4NrzrUZprCflB31TRvIuXeri6mhQBAPpXa1ssJgaL0UyipM1kONwK?=
 =?us-ascii?Q?3Zpf4xNX6aj7IzzAFrMRTxe3ovcLqQnDRxzwPhNKh0+bTUZQqUswe0/z9y6s?=
 =?us-ascii?Q?UNly67pzh6Hvyl9L049Fxe59M9rcdVRpvacNX9QbjceQBpzYQbE9VLUHdMqm?=
 =?us-ascii?Q?NIbkxP6HASmIKAiTDt1s8Vsw0AfF3enzkCoYkg3vF6Nvl4p2tns2U7YElksV?=
 =?us-ascii?Q?DyNepoRnKQlfYJGwv/8lap+QMiBh8n9JckJvtCjjYJzmNXDG+w8RSkkdF2LC?=
 =?us-ascii?Q?UUBM8ZuN8UlPbyAA4AJ85N59Yz0MeQGdOAuPqfGChwK9bowR5+NaqaTPe5fX?=
 =?us-ascii?Q?iKNfLMU6VAaT7aeWSmoxXBvx5N7bgsBJdCaFaMPNc09GLySA2MOSQekAQyQ9?=
 =?us-ascii?Q?Rxa657PD4U/B9QMBf+MJAIzkvoVr0ZiasfcFy8AppgP7ou2kwupstNlAPuSv?=
 =?us-ascii?Q?qdfrypXmdnbF0NIBTOn90CYalpBQKcaIEiTGJ7DHiyfz8kekDRKKva5srn8g?=
 =?us-ascii?Q?+bn6xxIs7YHmBFhehhPdQUW4oeXH6JDrcJzO7OsRRnUP+OAYFv7O+kwSJIZU?=
 =?us-ascii?Q?82049ifEI/tiSEeTqm5XnLrMNCnaHxmfFSA4tWA/g+NRmReBkrI/1zoMJXxI?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49462834-77fa-42c5-e303-08dacd432c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 11:09:21.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snA73Sk11IRMj303qEX4c63F60Itbqb4HAr4QryeZmk3zeK0SDNoG3TBhhUl3d9BGnKAHwcfoB3qk3ICUF7hAPLK6+GZO0UyivCgMy1m4Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10273
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:58:33AM +0100, Christoph Niedermaier wrote:
> This patch makes the use of IRQ optional to make the DA9061/62 usable=20
> for designs that don't have the IRQ pin connected, because the=20
> regulator is usable without IRQ.

Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

Thanks,
Adam

