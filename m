Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C56C4DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjCVOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjCVOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:34:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820465C6A;
        Wed, 22 Mar 2023 07:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPF6YC5R3VCavX3WRf7jswwbjw+bEiZipW8bQyUVRdhgJP/gpwvKisYwrAMJmEGgMFn/X8A0pXjEIPdRgrZYTHq9ZlvRv6VgtfqtOlG4x2Zvq3vLCJVkykE1saMpzrxnKTZU1wpxPipsR/kp5CReCmlSVanLNLi2Nom2KUPU9Yq9J5Cq3Z8VTrbWzhhfXyU3/3jeiVHOtdlCs18HYUnckrWybtjbGV0wbvtFroXnRpkSAfOXD+w1dDOSA9qDaIkj7QvpNU6z0bGfEHqdb9mV1L8LxbcsNj9N8adrbtlCil99kwW136YoCl4zjQP9SxV+lKo2pBXPCImojLCq6PEd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmqjJ3fY6SOHwFgbpu0ludZiHvuO3ttlrZsP2hPEWw4=;
 b=R6R+rsji+OThvN9LqYftO+04kJc+WzSo+9mWyhxF5zeWIRNOF9y+PqzH0fBmaVozF6gt1RlVaacrObmlwoF6EQ3CPTOWM/68nwc/tvu8HE+qw1t2nW9Dkwc6+LdLWsOXQyd1QQ7cyI7rhv64WRtbQ3udsCSJmgEaXgzaqp+nxELgjgxpQeLsUE34BM5uy5UiRWOk27Z33ZXG1T5pu/SS2/ds3MpubxLNNcQNdV/DK36pjN1C7lIRJdabKIubc091spGfP5gNCfh99PV7wBtMOLipyJgMUYSkof2KctOIATVFJy3qeC6e/HAhyOyaqk1haoQL6tcw8q+2uXvG62LQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmqjJ3fY6SOHwFgbpu0ludZiHvuO3ttlrZsP2hPEWw4=;
 b=lWMHGzl5igZJ30fGnwq+igS+2M1rGVI798Roed0leSmZIs+vfmaLbR5/6HAnLgkNhWhhjm6pi7e18f/14ai9YNu/Q/1Z8TJPcKglZ1NilpOW9V8Edvob812NDHgFwxGRk4m+mYnsAG6ELbnsSsQh7CVbYThkM8tdmEVaOTS4dCc=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:34:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:34:03 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZXAih0MCX1q8KWEWxpTpi/nrVFq8GaNGAgAByipA=
Date:   Wed, 22 Mar 2023 14:34:02 +0000
Message-ID: <AM6PR04MB483828FC1083E3C98930DF6488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
 <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
In-Reply-To: <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AS8PR04MB7862:EE_
x-ms-office365-filtering-correlation-id: 36e61d16-84c8-4c18-b9da-08db2ae27bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJbCXQe4evXJUMm64rf+Kb9HAZhH6t564h2VjMpmQc9R1mfP3O20S+6Jcy3bvpY727TRzx1mjRKt3BX+Fe/Gjyou4TghOSepyhZPFAiLGT5U3mP46RjXv5fNkOGO1/rPjxHUDYrTvhjotqMQ99LMA7wr5Qm4KSmReuES6UV+MInxutfqXbaMbFuZKGTQLqC7ktroGRnXpxq+VeDHaz5xRYZ8Z3nMDBEduj5H1+C5v4qXxncaYNyYyrehMn0boSmN8FikqW8LCPS7LMiTtO3H7PmOIEoz5t20YDdfr6y3xYDc73LMeafOaT4FrHQr3imNYyKY1iPDamYAIoHu9qxIf0QNoyOZRwA0SehmRvB4WnZZGHnPcSP6nwzCLBwOAD/AI4LTcCufMUFPBWwxiQtSu1YLj0RE4G23lSH5Wyjc2xEf2ZWaJw8O3NZcI6EzJF7YnBZPEYNJrQAMr0jQar/Ymg726tm/cjQ5veDzyKlv6IrHwG51rx8w9DbhgfNBpB1AaVTAEqH+AiOwMhmDvjdNeFkJJbcGb0rLo/Qd/+wa95T7sHcjK36+LnZ9TKsvZ9i1VA8EN4EmlIQClx2XmLzljMgeFxGWp27N5/aCptwpanprWShF2EviBDYaTD/7tYlDOZLzYdCDfN+K/250lSYVsYjxCrtjEAzkFgwUwSAayQEbNPSU4X8iztaBi8nOymOjDWpsBgGRMdHhHC+KzxsvKJx3o4tMyQgC0blW0IhDG/M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199018)(122000001)(38070700005)(55236004)(53546011)(26005)(6506007)(186003)(71200400001)(9686003)(7696005)(38100700002)(44832011)(2906002)(86362001)(83380400001)(478600001)(8936002)(4326008)(8676002)(55016003)(4744005)(66476007)(316002)(54906003)(33656002)(64756008)(52536014)(6916009)(41300700001)(66446008)(76116006)(5660300002)(7416002)(66556008)(66946007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?INkt/ekvOi9tBPusTIjBD4lUOLOUrv/VphE7yTtayQTMqSi6fQGVXJQJs+P3?=
 =?us-ascii?Q?gDBPst+b+j7vQAfxdViSRVbjIG736ZZVkzJgSzgEfZ6e/s5xxtSdLehxs6yj?=
 =?us-ascii?Q?930A7fcaiQc7OQsCb6wO7uJo/zqPLub/JiSTHor+mbydjrEr+0ntNPhEHnCX?=
 =?us-ascii?Q?xIJv1+jMj4bD8FRToFx2Lb8WtMlpJkWqK3QoNC/fLzqdRDTT6xWso1Xar70m?=
 =?us-ascii?Q?bcuwmYTda2f63dH51P1rsY6GB+afwRqUgYOmL6Mpape9HKubwXECJ+3BJDCh?=
 =?us-ascii?Q?Xwpl8QxySXQU8KfSq+w7QcIQBnGmPq9ft5YT1NF6XFqkrfCTXPcGea7kh3vk?=
 =?us-ascii?Q?HZiRHwAQ9fhb72MOdBNBYp9bo0e1xqspuR/W8y4vPbCBR0WlsLQysutMJOHK?=
 =?us-ascii?Q?DqjipaQOix5Gzw+V6KJ5hms/fgWNDL/5atLTio3zAP1+Uoyv6GNeWL9TDXon?=
 =?us-ascii?Q?s8GxQJ+A5w8SYV5MlTRY1gjz0tQKecgJkdY4FNzxkqEL/AmhnLUCugO+oHzJ?=
 =?us-ascii?Q?aUjvUib8yMSbVCIT0J0ALl2wWnEUQ+Fie1/n9xEzXrARvRyghSjduc4xnaT1?=
 =?us-ascii?Q?iwRs1omx40Ikf8NreiPXNmsb6lIchnTP89mgxK1bSEa6qJGYWGrcBoRgzqJk?=
 =?us-ascii?Q?8cPKLzqhceda4doB/yXnnTYxEQZZZ8ugTKAM/sjZuxnvpdLJCqTeBkQNN4QU?=
 =?us-ascii?Q?ObvGpQOio3WTFPgYgfpqhA+LWvWPF1ztp5ZpyBa4djDJTY5IRkbIWtnaN9yn?=
 =?us-ascii?Q?Ymp6fxYvSIlpi/RtyqQymcz9q9Z0NJzYxh0QDtMJdT3T+ZaPYaVDXtJ3MRS9?=
 =?us-ascii?Q?K/7JeXMRVosLwnAoD6nyi0GJFVC1AzSXpUZZG1GBu24U6wuErsA/8vnQ/eas?=
 =?us-ascii?Q?x7IezMI0HRu/8PQmqP8pZ1u/I/ERYD4OQxOavPMWy0BpWZeiqJP4GJE9RgfS?=
 =?us-ascii?Q?Lia/uP4HFlXjA6mUWYst3zPi7nlGmuqWrV3ju3aVAKyVS6aKN3Xle5WFsNGY?=
 =?us-ascii?Q?86GyDJ7LiCSvns96IN/rzvb4YD5BF6tKcVVbSFkvIrZfhMGutBBnbrbSNrfz?=
 =?us-ascii?Q?l6skqR/rXLQlRPVKpHWVStXVUeg/6W5pHNWiny0GkCvhdBa+ebjA2Neex5TR?=
 =?us-ascii?Q?wI+MY/P9N2ifOeo16CQocRDXMNw4iaGnA6b9ppUdxkIUaflLYofKL2rGMgR7?=
 =?us-ascii?Q?9soN5k8IfMHWX400jvx1xJptX4nFkxJj2Pk6Nxs/DzjPArPPI0jddpp+RT8f?=
 =?us-ascii?Q?lC+gNtmo6+TfL8l61xcj3gYMdqnlOStrSwHOZey3FVbZOsIkT7uPntwD8F7R?=
 =?us-ascii?Q?E6J5P2jIv5bwROfYka5BkdHMZ670kixM9lySsWoG3otEWHBeThBhqGROyhBW?=
 =?us-ascii?Q?iSo3CkQAK1sUSpA05veWX1h85DYVuYw2FG+AxCxLjdgBgM7zU80maVAAAPn9?=
 =?us-ascii?Q?IEzG6G2D+vr0XK/avxwxT0tnWgszM1NOk0g9znqpkWG7NVJFTGbT4OnU/VUL?=
 =?us-ascii?Q?Q/tGCIYStSYKWc5HuCL7srJykYsMPsHcLezLnD4MG0xoYcuu30SCUI9WcJiC?=
 =?us-ascii?Q?NkLFQdghiwsUZMpqvjaZPkaOqBiSGCXKngZyRLzU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e61d16-84c8-4c18-b9da-08db2ae27bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 14:34:02.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07lXxAQKVnGXDGnNz0D0ayUeWvyKxTSh7eP+2FD/e1AcGlGfPGFmfFcFCiHPSV2l27uuZpS1KPfCOzbJDb31Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Wednesday, March 22, 2023 2:32 AM
> To: Frank Li <frank.li@nxp.
> > +      - const: usb3_aclk
> > +      - const: usb3_ipg_clk
> > +      - const: usb3_core_pclk
> > +
> > +  assigned-clocks:
> > +    items:
> > +      - description: Phandle and clock specifoer of
> IMX_SC_PM_CLK_MST_BUS.
>=20
> Drop useless pieces so "Phandle and clock specifoer of " and name the
> hardware, not the syntax.
>=20
> > +
> > +  assigned-clock-rates:
> > +    items:
> > +      - description: Should be in Range 100 - 600 Mhz.
>=20
> That's better but I still do not understand why do you need it in the
> bindings. You never actually answered this question.

I am not sure 100% sure the reason.=20
I think difference system target's  axi bus frequency is difference,  =20
And just one time work, needn't software to manage it.
Following other driver's code style may be another reason.=20

>=20
> Best regards,
> Krzysztof

