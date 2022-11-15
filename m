Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99C5629C27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiKOOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiKOOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:31:57 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE383BF;
        Tue, 15 Nov 2022 06:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WssYNMIQOH9Ksykuz+QDcZ8vFIu33RDGg+FHrGlNbgscAW9UDarkOIegr8OW+iz2v5xjbtyaxWiCoqDVHXLrmoIUOH9zmy75uwELWDxWgzlUGcB8y1DfKex7Ck0Pk+6cHi2ErUaYje36BOqHrCXYT2mT3PgxnYcj5S4IRSTWT0Djxu0zFj6KSWtWsPja1Daeq5n0H2fO5S2jaqYrvMmPu4u4cqSSTCAfqx6IuhJ7elbUFS2pAabDmWVFdd+4qdIt9gTA0StCQ+vEn+PeRc8vhHkYMik3nSlH3TZysLOF28nxykXV+UEy1Bh7Dr+UeAMPsIJCaW5Ym+joUYeCeJpPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOTOPxblDjyBpy+N9Sn27yZWzEjj+h43fOS19mW8X6I=;
 b=MyXZ8C3qJ92X/JT41v3wC0I+RGomAx+nwGTQSBOEheW8Gg9HXLrLFUNFRNYPfUfTPx6tiP2G3XKOxRule9zoSi4a5EbxV24Hjsiofewb0TYHr9dYbcokisxpocTYrwxUrbeE6p6L6TkrymJBuQE7T4hok6bEGOAf2JTldvWEX8uo/rAMamHxg09C/RNuP6b8FZb3d0pPExkO1LJ7YaWCcbU4138pY7FeJQGeU7X+cWwUZ6RmeynYEFlRmMyOzTzQPSDrcmp4fpMxsnekXv6dITszioxPQi/LL4nStmJIQX/7QIiQ9gqLBLKn2wjXedQWceIHUJ4rsPWmV1mrGydhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOTOPxblDjyBpy+N9Sn27yZWzEjj+h43fOS19mW8X6I=;
 b=qgfJcxukoBj4ip2XdyQv4Uira9xHFqL0XhlAuGlGE3SWggno8vhCL90iRXRO8DKUl6VTVk7TYwmu2x0Uj2NNqUPyUmLsSQf0BJU+WP4BOkk/mAA7iuyTVtulQJfyPoiKJsTDsiIIwmmURbqPABiz1oF3kaWm5Ki2Xb5GqBjtwVc=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 14:31:53 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 14:31:53 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Thread-Topic: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Thread-Index: AQHY9h+FTOIdILG+UESwpW9mF9x8Sq5ABQqAgAADlwCAAAKigIAAAusAgAAB/YCAAAGXAA==
Date:   Tue, 15 Nov 2022 14:31:53 +0000
Message-ID: <20221115143152.xjfr7v333rhjhd3m@skbuf>
References: <20221111224651.577729-1-vladimir.oltean@nxp.com>
 <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
 <20221115135912.ksjk7zxqsyazqhtf@skbuf>
 <c9b82051-a9f5-883f-5455-1cb06aa6521b@linaro.org>
 <20221115141904.26lyetiforkgoqaf@skbuf>
 <0b4d2bc0-0f45-4bff-dee9-825efa5b5a2e@linaro.org>
In-Reply-To: <0b4d2bc0-0f45-4bff-dee9-825efa5b5a2e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|AS8PR04MB8166:EE_
x-ms-office365-filtering-correlation-id: a001c2bd-9ac2-485a-7e7b-08dac7162411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/TvNu1DoPqhmtlr2UCPuLDSdyhHYn+fwDCgB5gcjwaereeB34ZmZ+euaYVCz2LfycsrrfoaPppCKYHG5va8TEEBrH7KGSrDzMX/MMkt97QUcPWOvrqoFUNTZFmqf3DLgfLU7vMzlBNBRZKSxBBHqh3zIYQKIkOPYPRqBXJbLD1AiLa6DyxzN0nDjWCSDYhzy7n1uJEGWgF+FgmPiRqqoETaWtGVGdAr7gkadOuQS8T8eiq6guZGZ4sAEf92nLZCEbJTY3FIkTa393Nrvl73gQvjgila2FrdwGFEFFDOlF/HzQEWlNNhZ4VRy1Uo745QUydDr9qY9DF56TW0mveBGgBYH7syflCeU7VeCdmOUQWf9X2yad9+pFZR/axoCsaL2W2aivNTzeSHVTEoIx92mb44uWZXXGFf7tZXUeMKQJG8w6TfHl+AGHJJmsYxlZN14j7yewOEyre+7/WDrogybuaAehhquKIwnfR4w9imD+RV5YJcG/qiAGXiWsAdfkazHWXfiFVfVKzeSxNZh7w4fc1MnedDtP8q42CwLkqKSoYxpQpIFpBnE+319RGvspuHp4dJliZN0EZOzke4/ruYdxayvUWf3utM8ORyfkVAHvVedfK9OPAGoquE+XIwC5rJ0owEDoMR0JXzzFhFrZo/jXQQBSCJdncLOahDNXoNgxZmfBWwug5Bw1APJvsrCt+PtKplTTJ9j7YKY/z4m5YTGx0yZpXQeT1bTBhVAtYjRa1mio495hZWkIdit0E868nO1otURzxlUgM8Ir9l32r2hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(478600001)(71200400001)(38070700005)(83380400001)(7416002)(5660300002)(8936002)(122000001)(6486002)(86362001)(38100700002)(9686003)(186003)(6512007)(26005)(1076003)(6506007)(6916009)(54906003)(316002)(41300700001)(44832011)(4744005)(66446008)(4326008)(2906002)(76116006)(66946007)(8676002)(66556008)(64756008)(66476007)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u5tgP/VFh0owSgiYo/8WHbTNKL0YOqUVD7feNJO3ZImJYFCmRkPo34NN17mJ?=
 =?us-ascii?Q?+Pw1bCjpHgzqZsp3wXk/TC/uWpj3zQrn9UMt4KuJiPJ4liiZhPIPRw4fFy2X?=
 =?us-ascii?Q?vDVWCQKGGGXgs48RH0yCVFLUUhLnOWzj98yQMZLeEE7YxFWnzpH3aAl1/99G?=
 =?us-ascii?Q?iKH3h5YRXGfMZIcgfT6DBLzGEARcatLKFZEoiwNbA5lwgZitFPC3F0RsTn6a?=
 =?us-ascii?Q?QDEFOsB/W92WBomhUjEDpogA5v3cdPYmYOUrn4xW6svK6a1n4aCYlo0DL3ix?=
 =?us-ascii?Q?cx7juiVYhSRp7XQZ9L2XrAp+Bx0q+VXigrpwHaOJLXn+Ig2ApY+EV4R0CCkR?=
 =?us-ascii?Q?WAZZBSb6pKQe/0Un62SpnweCuGgk6ZMJYmpFqAjTeb55ub+l13Cp2UT/sgDQ?=
 =?us-ascii?Q?hoI3nxfMXT4Mj2m27O79WVcmogwT7Fff2dO2ySi0t4BgkhEtJQYf8nZfCmiD?=
 =?us-ascii?Q?TzwCfVOLI6GPRLcJort8gB5FRMHCcpFX93hbNiiIlM5h3s0eEnaRPQ2nmKz7?=
 =?us-ascii?Q?fIWAmc0zB2Cdb0//KhETk9mXgnrRg/BMqev5CUMQTAXnmcP51BK1WXOLq6kc?=
 =?us-ascii?Q?8dktiNMlp9QEdST7KRGbblvGaUt5WeDD0ZVdQ44GQunc/HHQsU97Ahwd2RcI?=
 =?us-ascii?Q?h9noKUgQgafX6eix7oEHlTpqtLKlLGMqlBlGehI0hPgP3iKeIS/2H6tGDeTh?=
 =?us-ascii?Q?Hq3S3+YhRUb0hn5cKDuG4Li0zCakbE2WosDDbAkCJ2nH8JhJw56C2JFiY8Yc?=
 =?us-ascii?Q?mFSpUZ2oEbSSYSEs/70CyhS87QzCwCa/L1NhtmPs1fG4+auZGEyxch6+w6YP?=
 =?us-ascii?Q?Lrea4aDHd0woDUPYgXtj/j3eEl1zBTPuadp697OHqGPeKIU37bdrVsP3ApiA?=
 =?us-ascii?Q?zH/+aJu2qZh4ojj+YNraCP5ir08wjTfzJAA2k8POCFZ0cnbS/NKFjfmNZuyx?=
 =?us-ascii?Q?n9UE/Kn9ofV0gUytUq18abliUQ+wYclBEoIA/GbDPmIplHwCAzbaZRbmJ4Fh?=
 =?us-ascii?Q?9TN0WS3u0Po05mYEdQFDIXz27USvFfmC63WxpbLpWPGz2P6uj9LhvMKtgCMh?=
 =?us-ascii?Q?HLVcGj5uCOjTcBek7CcdFTpfagCpCrrkun48W1fHeby/2RyEUgjSY+GUrkrz?=
 =?us-ascii?Q?8Z7fKH+/FXK4KKkwrafzessHaA2Lx4TlJPPzVauFV91QaAmZLYBFJPaFQF0f?=
 =?us-ascii?Q?t8kr6M3GBmD0u9lKY2GA/sQ1wf1rEgmrc5eVw+aH9m93PKijuR1TvBEjgNGe?=
 =?us-ascii?Q?40L6Ch4rmIMfQlOOUQTIqPN0qRC08oz4idedonDCntpLZprEmPCFDJwJGtnF?=
 =?us-ascii?Q?YcDC7cRrzGWwh8NzIXa19PfYtn3oQBbGKQYp4oNDgJasmPEmIta8l4E7Jyro?=
 =?us-ascii?Q?42rjK9MepcyvGyUCEIXgfYd5w6+/UrmY9fLXVDARBaNUvghpLGxrSFSjjgo2?=
 =?us-ascii?Q?FBQoCJBQQcZrk/O0dYZrZ7UAGxhSy0YrZ/3vZHGQ9m4TYpSv6SQv0hg8RGUj?=
 =?us-ascii?Q?mQ7cZq3dwIn75QBVdau/8kAA5EKZKQDj8VYx2tqMDqzmUIoL/VHqoLvqNuGI?=
 =?us-ascii?Q?nR0UecYE1UkvrDS+IvmN3omrAR10cFy1isaWUzN+DFBDuq4UN/YNZSudm9xM?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B71382C151025428C892EF356CE1069@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a001c2bd-9ac2-485a-7e7b-08dac7162411
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:31:53.4055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwveGqQWQ7qFrUKvVPDGVr0vpgTyRRpppp6ClVd+2kBjPwgKfmckMjfXriCvvg71tSFiz2/2sbvY92A35c3wlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:26:11PM +0100, Krzysztof Kozlowski wrote:
> To be clear: ls1012a, ls1028a and lx2160a should be either followed by
> compatible or not. Cannot be both.

LS1012A should be followed by fallback compatible for practical reasons
(Linux kernel worked that way up to 5.7, time during which LS1012A was
supported).

LS1028A and LX2160A device trees were both introduced after the Linux
kernel started looking at specific device trees, so I believe that Linux
never relied on the fallback compatible string and it could be removed.
The fallback is present in device trees in circulation, even if the .txt
schema says it isn't required. I don't know what the BSDs do about this,
so I'd be tempted to leave them in the camp with required fallbacks,
just because it's not worth risking a regression.=
