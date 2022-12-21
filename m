Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD46530CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLUM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiLUM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:29:02 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CFDF2E;
        Wed, 21 Dec 2022 04:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9/tbN9x1746HtXURGqbXnmqbqiIHkFwxbpm4EiPDHi13+tN+p11nOuCPeSCRi2Q9/Mj0XZ2WBfsRUYPIdmZ5XhBEj4GhuFxIm2+CMXYpIhyXeZ8WN57UwNTf/0YIW6prP4bDQ2Wj0ZBGYuPudj9kbL/A5J+PV8jyDSoHilMWlqyjYiaNVLi31EU1QIflTFO0SxiYshVjxUNRum1v7nKgIuxfcFbi0E8JbljxIrr0u7YT8sGAF6fXkdP4oeZkGMo6mccahhx52K2iDsWVzhMkJt/CQkVzaNP/WaUKKjjpcc1YpgpDKQFOr/YT74csm89rQ3h2y8pOERn988/amq8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA3VpNLTRWOH1XPLJlqgicx5IylMzjBn8u9BROmpCYQ=;
 b=kmrViUf9fMHJHK/mSQ0UAock0lwT8gFyPr7DNVwXz8lmNf/K0nMBNAioQnMgWUkn/+X6+1moJZ0Zqe6CaB1t84OV318o9aRejJJdj/fdhH4Ba+y87/Nvqdbpk5tWZXLYqk5K2K+0g1xGpa9k8t+DnlZww8WSY87bwrxWCam4vZ9lGnPMUPF5tO58rRksVBdoAfjrkcu9OaWIWbPzaeuZHXaveV10BsKJ59wpksJJnFy9puiGISIMf2gTW42kBPch9SETZ0m+9KwxJLoYEIYDB2GY9bRre14bdXdoN5jKBdSCyeO8uviFgjQP0E5sJzT1WUqFSkXiVI7RYzOcmvnGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA3VpNLTRWOH1XPLJlqgicx5IylMzjBn8u9BROmpCYQ=;
 b=i80UASsPqXUkGFqEz8L1t0AEg+CZRiuV0FsUn2Hon/2vbSEGzgPVTnPITFq+G57tlT6otE8Ym90ePWCMXmR6pqHuSf3HZ7ZHeQc4FoI/zUhoLtqzWHMif0oWqyNW/Umjazd+Gyzv5bRT9FoWrxG2ewfWrnpKWJaQDhhcFC6iELM=
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 12:28:58 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a3d:11eb:b670:ba9a]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a3d:11eb:b670:ba9a%9]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 12:28:58 +0000
From:   Andrei Stefanescu <andrei.stefanescu@nxp.com>
To:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
CC:     dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Thread-Topic: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Thread-Index: AQHZFTfMLUem16ljnEKkWnL32ZzgrA==
Date:   Wed, 21 Dec 2022 12:28:58 +0000
Message-ID: <AM9PR04MB8487286EC9EE4AE3F2FD382CE3EB9@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20221221073232.21888-1-clin@suse.com>
 <20221221073232.21888-2-clin@suse.com>
In-Reply-To: <20221221073232.21888-2-clin@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|DU0PR04MB9249:EE_
x-ms-office365-filtering-correlation-id: 9258cd5b-8203-4bf2-e9ed-08dae34eeef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSPTIJEl0lwCbCaBqsKTIYx0exsgrrq8SL61F7mIXgbD30xO8EMIRYCMtRIqyVp50bepORhZoWldsBIQtcUrsWPgUIhwNLIhiZ/OhTs5jBDjcHZmI5rd78rzgWuBm7+nUPL6EB+Cgytmaa8oW8pOwVJsSUkPbWSMdYAVK9/D1udvu6VXfCY11SbvakvEgEqX9QabnBwCGFUsReEBoSo+vECgmpe3GqkIYSG9lrqTcvD1NBncfZSIc27x4D4DXiT/7xtXIiV1byfj6tuRWXhLHdaMICyWBbUZQyOayXhMytVXkFzo8yQhm0nlc8W8icUeUhyJ9enqs6nzLL3w2gVGC+PEaMcFCktgap1BDwT6/2Vo3USqHKVxvAm+FMatenCFsvx7d2ogn6RZZvgHKfOoKTpLCQfhk/HxswTI1lb6aXJ3RZ3fjj7iakwKYTxrA/i6bJduANBV0S2E17+yAgMj2Kux+A0DDP3WjJCKPVk9vzavgUK8JF7nCGrSCBCYYYQ9705MqPfVbl48Wqu+JGiLd6WFCg3UEBgZsyvmIPH0W4ndX9UAZu05MiHqlBjdquolu7+B//8fxYyWSsiyfJCIum8D8uqmHSYrLHh5Kk73wkEZIJuBG885ZL2ejvEsgwjhUCEdJtSUxbLZkeNshxUCZg3RJ85iSdNj6WXGCfTnvHcnofxGrZcDUokli6G9CYX9Swav4uT2p6ini8JuY0l5AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(33656002)(7416002)(316002)(9686003)(54906003)(478600001)(38070700005)(55016003)(110136005)(86362001)(38100700002)(52536014)(26005)(55236004)(122000001)(186003)(7696005)(6506007)(5660300002)(44832011)(41300700001)(71200400001)(66476007)(2906002)(4744005)(66556008)(8936002)(4326008)(76116006)(66446008)(66946007)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BBNkuxiWEzIcQiyB7xlkJiye/02+acoDs7C6U3eC27d6v6XSqyPzDONj/j?=
 =?iso-8859-1?Q?roY6A1gcaPISoW7VVzfM93/DIFPWKkAt4Sg0lRCtPzE8st7ph8wwmYO0Jo?=
 =?iso-8859-1?Q?eqCT2hBxVrK09IcLNi6Qc/my6WYaAwuLrPdSWfW2B33G2c2SUK+jpkydRI?=
 =?iso-8859-1?Q?fQUI32W0bBPEW+KjfbaGfLahDDueeK23Xa7NMQHCPo6tBQjCwX2AvIXTL/?=
 =?iso-8859-1?Q?wRm4i/O8JybE3NgcJkmyhu12cNVZtopb/nKGQQlH+qcBLPy5pzTLp1/jso?=
 =?iso-8859-1?Q?zp0C1MJ9M0E/kKkS3MDrlq4OUiC7fj37ju32JB+PtoZ1VRDTJj27a/zMk2?=
 =?iso-8859-1?Q?RT2M1W5XS3M1efhA9AVvladrdkihRWlqTcLUxhB6SgDYyyMVoIMj1pUNAg?=
 =?iso-8859-1?Q?ITelQRchbwWum6zm+OtCiNWozRsi1yH1rbj9LmpaLdF4eiY8d5U4zCt+6d?=
 =?iso-8859-1?Q?kNgE6GFPw5EWCIfWIHKHHNjnucbhe3xChaEq16gbzWXL/8vqWWmLTlzma+?=
 =?iso-8859-1?Q?/ovm0Sz/J8yPgW7IA8E4RTU4mhQ2W+gBZLGbw85G21UI+sawDndXsfa3O3?=
 =?iso-8859-1?Q?G9kgmkkET01ZonTGJWRo86tZfkNhZwFAWbX70dcEfeoslC8P7lu7hIWgv+?=
 =?iso-8859-1?Q?sau4i9xszL+2iyaqpAADy6eXGUh6YJ6RztyJdAaxJQ4A9k1sZxa4cJj+Rd?=
 =?iso-8859-1?Q?LNeZUCGls9MRPqm7qt8Ob9kLFfKJ9WrS1YTCIiuKGty9Tc+fLT89KF7fBm?=
 =?iso-8859-1?Q?3+TwMB7vpuL/VireHA045UL4ne/3X1eBZY5PPDlIMDPRajK8X82HVpui/5?=
 =?iso-8859-1?Q?2QFDgSJdbmTJI/yIHAYFHGub2lTjYS/vRWFXxa/h+HFQA+N3D2TFFU9qjf?=
 =?iso-8859-1?Q?sf1JDLr+4G0i+zy1J557WSnN+AhKaI26YtqYXJxztHnPfoHLWtxUyFIT2z?=
 =?iso-8859-1?Q?4Hic7gX0Lu5L/3z/O1BRJpF70y9oR6QcQqHIYnTrF9SnQSkfzDG1DZ/meD?=
 =?iso-8859-1?Q?Iz3Zx8031Q/KN+P0QApCeJvwybqHOKhbUvGIKxMe6B9OHiflxQID2b5vLy?=
 =?iso-8859-1?Q?gTh13eCRsH1dBvp6LPoWeDYoJ+wwqGgQ2pttVH8K9XRX/qb/FlABEh/ZLV?=
 =?iso-8859-1?Q?2//rK57e9sqJqikNg1uoH4pYYmR4ZZuMpBk6uZp3iqadGK4kPh8MWAr2dw?=
 =?iso-8859-1?Q?JecRs0IK11PwS3mthAstY/9UmnDXdE/I8UBNZUedyDknfi77q34AiK6RzN?=
 =?iso-8859-1?Q?rPUodMhrd5sVbmGo09RY8QsX5PnzAYQVT5cuFAa1JncHc0sWt1ufVTXhjq?=
 =?iso-8859-1?Q?si7AdpkVEa5ALQcjruI4/QkieWJE6PgV2vGfv3agqZ2TpT3bBMdOevDqHC?=
 =?iso-8859-1?Q?kDU/iWRrKAkgp04Gji08tMu6d3f580wYoEXN51OClZqrr7sR0fC7ugrcZp?=
 =?iso-8859-1?Q?O1d2xZX+g+OD9iCObgvluGU+MIh2Dx3E1XPdJVOnh/IytLCoyOGk0J9nO+?=
 =?iso-8859-1?Q?SMmfrpwNvVdhR4zYXUF0f2cUVutPtRVOg+0yrMza53vlJ8tldGmOxd4Cbv?=
 =?iso-8859-1?Q?609ZOqvvHZVE6THTcqkS15Pf/lEfVUssHwqyz03Zvz3kxMhksVhh14GbXx?=
 =?iso-8859-1?Q?R7hDh62z/WfXZkl7X82YfhFWB841GvKdPMT4EwEkUZkTr4F3SLvOHRQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9258cd5b-8203-4bf2-e9ed-08dae34eeef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 12:28:58.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12Z37XBw1f34Di8TacdA7MmyXjt39LvKPQAgGxPUepMS7MgVKt/c3AIFkoMyVBd/YaAPj0RUiqlHuWokJgWEwQy7o39I7olexgvYxyFHqZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

> +patternProperties:
> +  '-pins$':

Sorry, I missed this in the previous versions. Could you change it to '_pin=
s' (underscore)? In our .dts files we use underscore in the names for pinct=
rl configuration nodes e.g. i2c4_pins, usbotg_pins.

> +    patternProperties:
> +      '-grp[0-9]$':

The same comment also applies here.

> +        llce-can0-pins {
> +            llce-can0-grp0 {

This should also change to something like:
llce_can0_pins {
  llce_can0_grp0 {
    ...
  }
}

Otherwise, this and PATCH 2/2 look good to me.

Best regards,
Andrei

