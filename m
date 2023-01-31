Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD8D6825E8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjAaHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAaHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:53:05 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C62196A;
        Mon, 30 Jan 2023 23:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2FXntYUpkLNng/fUOVAHNM9X92koMM3wVAEBTCNOoKwfBxEjwx9+s7kC7agcywSTjck1AhPWmDml5S/Dbmp23oWdF+4isAGN0BI/O+QmJt7aJFhsLO4muwNGQpjl5hNl3tGF9HbumIFQCwXWL/qMwj+uyrvD/jNN4bm1DxlPqZWTzIzEwAb6AiURV5Du2o4xIrhvefnYrE6MJaa9uJJBu9fSSBEPAORA9AiHdmGmfuJT+g9aVG+ho9YHotTQ4dOV1GUhcYSPOuJRC4ORS9dudXhrNM/pfzz4g7anUQICAzSobW58p3BTHb6NjtZvOY6OJBPsrfGFwDiLPkqVbzW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rARa7gLtZZ52KMuUE2/RZkYq2wzXJTGiADT7AISoN/Q=;
 b=UbjSlaeFBP39CcOHVfTdPV15HpZS2UMHa1R2jtLdmgc9GGs8b134pLTmqTXepm1HosQ8H9RVsREDK6YwiUNX1HZL9KqP1I3/SMU/TuJ1tKdB/wvRGjEXznDboE9Ov6BkRnntOpGWN1J3cEJe6McOG6drzB8EM5OANa07xlFyDX5YY8aiQ4BtsLpgEe3vbY0ckRn0pYdLoP/y50RSWpF7+gq9JXKHjTBUjLl/tjC7/y0dFwlsK+j6Tk0bdY9cfDHILN2ItBU8NxnAx6Pu+pBW8hc8CCjUJFU8hjmUo+qvgiMFUlAfBuM14L9pZWvQHFIGu8o+F2iE9JjLHvlclemOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rARa7gLtZZ52KMuUE2/RZkYq2wzXJTGiADT7AISoN/Q=;
 b=Cxf9exM1SdwzlquGrfvQ7i7MCegiUQbEBspQd7AGz4+MpkMWpZJHk2vHndjqHfuDsHFLTssrO/Oc80ZTz7RrljDKqqe+aGU3wKKtrYzqzDN0M93N9WYVqfu9KhHiXTjDWdJtk/K8VKtRd7ufhb8lfWPDM70r2REMGEJrQx2j9Q8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Tue, 31 Jan
 2023 07:53:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 07:53:01 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Peng Fan <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Frank Li <frank.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 1/5] dt-bindings: imx6q-pcie: Prepare to separate the
 Endpoint binding document
Thread-Topic: [PATCH v7 1/5] dt-bindings: imx6q-pcie: Prepare to separate the
 Endpoint binding document
Thread-Index: AQHZNF78C9BPud8bZkSy2liT9jIY/663jFoAgACUmuA=
Date:   Tue, 31 Jan 2023 07:53:01 +0000
Message-ID: <AS8PR04MB8676776A8D900D080D1876FF8CD09@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1675049539-14976-1-git-send-email-hongxing.zhu@nxp.com>
 <1675049539-14976-2-git-send-email-hongxing.zhu@nxp.com>
 <20230130223108.GA3642291-robh@kernel.org>
In-Reply-To: <20230130223108.GA3642291-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM7PR04MB6806:EE_
x-ms-office365-filtering-correlation-id: 649679e6-ca14-4465-f682-08db03602d33
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: td3Rk+PdUF1e5UakiBHi+b/EP6tVDr95aecieuM2FCpIYdTVe8bB4mueIvtx1B84FB+HgXCPpVaQjXKKKU3i0J/NHbRA0+qqC3OIiUQ+QOKMUPaeNzQPbvmcxpwDMcIphoP/djzrlvcRCfsB4/0SMKebPuA4yTxgER+GULPWg3d4VgQCPMNM2s/mmmDGCHz60NrzL2uAAG2vTh2PHguDsF5/yvokKw5Wq+dzFwEYCPqdoR+Cz+fjgOiIcvZCZ5g3281Uu74MM0Bd6DkOfomsyDY7sC2Zk8i1NFRd3uV0FLa2zAwOpwkTGRVIK24I7F7o7563Sp7+XUuCscoN+pzNjqsnbb82g/Snj8RKKqPi5ljMJK0Z8+1usxXE34Owg0S042I7+f3IaWhC0jRBfBl6kxKCaIi0o1Q7iPNvLMlNyEvnyTO3cHnESRSBVCMSorj+rfgEeIQZSUcB+aMlHQp3/0I1N3z1JhxGvP0o86lRYB0EXzz2nspTmyRdju6ldXzFt0iqwWq7ziclrQVMVwBU/qNMgNVktoIig+xlPLFYvux5FViLy2eD+g21qtmnSwOq9bn1eEWQqbG1x0YvWS1zUBlBSBxntCKnEtqSGNkI8+rk2Pc16g/HbashD2841uuEnEMqXcqphwDbb7OVglGTzk7fmTPK6+EdUcI3JCTrKzjUuw0CSEz5FEIQ4Ztf2N4rjJ9tDIJL7YRb9LBtFliGrwcVIk6cfK/IOGycuIp8wXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(7696005)(186003)(9686003)(478600001)(71200400001)(83380400001)(26005)(54906003)(38100700002)(8676002)(41300700001)(316002)(64756008)(122000001)(33656002)(6506007)(66446008)(53546011)(7416002)(66556008)(8936002)(44832011)(66946007)(52536014)(2906002)(4744005)(38070700005)(66476007)(5660300002)(76116006)(6916009)(86362001)(4326008)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bEJVZVlocThIOXo0OXl6Q1pOZUpwYjEyZDJvVnVLQWw3Y3ZxdUhlZTgzSXJO?=
 =?gb2312?B?djlkcmpjOHhFUU5QUjNzZTd1dXlPNjFLRW1NOFYzUGdRTEwvczN5Zjg1M1JV?=
 =?gb2312?B?bDBhY2ZMc1RqYkhLeGI2L1JETmNqK1poR0xnNFN3OWEvN1JrVTNBUU8xeG1U?=
 =?gb2312?B?Tlhramd5YVlFWThYZHkrYy9MRXNsc3BuWlRVeXU0WGg4QU03UlI5NHpqVHpm?=
 =?gb2312?B?cTd6cGthZlFTN0JWMm9rRStQSW1hekVGODFmdUxvVDB2V1VxT2xQQjY0VjA2?=
 =?gb2312?B?V0NIRWdENHNsYVZvaG0raUN5Sjc2RGlYOSt6eEZHcWtJSENUTVVUcmNlWHBi?=
 =?gb2312?B?eWppaDMxQ0t0V3pzOUZtS24vMklJM0RLcld6ZHM2SHA1ak4zWUo4ODR3bWR1?=
 =?gb2312?B?Vis5UWZZQUFtM0R0Mk1Vck15QzZJY0M1Mk9EVlVQV3U3bW5lTTdFZnBmZHAv?=
 =?gb2312?B?b1ZLakc5SDNLdUY0MW5HcUNGWTlVb1daRDV1OHp4YlRWbHA4cG5lRXlrU3JF?=
 =?gb2312?B?L1p5Q0c4RXIxQVZBNnc1K2liZjZndkdXdkJnZWx5cEh5SWtNa3Z4S2dKcURs?=
 =?gb2312?B?YTBBVG5vZXE2d2hteWFyWC9FQmk3eEVabVNiZ1JFWEt0TUdRelNKSmhXeHRi?=
 =?gb2312?B?aXAwQ2JEeXk0bzBqem5HRm94OThreGNZbDN6d0doYjh2QXZxREc5cjBOUkhN?=
 =?gb2312?B?b3NNMGd3NzRJTXc3amYvYUlQWG91ODd1L1Q1MnhGWTJlSmphRjZNRzV4RXNs?=
 =?gb2312?B?MnlkV0N3K0FOU09oZEI2NmR5Zm02UWRWNmlJaFFhZVk5b1FiL2lUQ2xFUU54?=
 =?gb2312?B?djdDaFdtakJMT2JOM0JZRndRVHE1bWV3VW4rbzdycWhDOGQwbHFGZllwdFQ5?=
 =?gb2312?B?aVl5Rk9aMmhlZmxhVjlEMS9WbnlXQk9tVjNsRlhwK0U1eEc5bmh6SmVreUh6?=
 =?gb2312?B?Rk1SN3dUTG1WWUZ5dnI3Y2FveGZldDlUaWxkNHhlQU9TK2dpaVVHWGFKU00y?=
 =?gb2312?B?dmEwdXZ5TUNRYjF2UkpmZXhhOEdtd05ZR282SVZOYzZGSkl0MjZUK1hMWUVQ?=
 =?gb2312?B?ZTdKUHZHNmRjNVcxZjQwWG9wZFJPaVJFejJhRmNPbTRWL1I0dXFnYzhyRXhr?=
 =?gb2312?B?QW1ubDBtQ2NSVFdjY1RLdUJZRWQ1NFJkZC95cjZxWXA1cmJET1E0MXV5elc5?=
 =?gb2312?B?NGhtenY4eDZBUGJOS05nUmlIb21ZMnZveWlNMnBIczFNOFVWaE9SaFBkM0tm?=
 =?gb2312?B?N2pQZGdnNUthMUJuSjZ4TDZtWnl3c3dKanlzTjFwUVQ0Z2xReGJBWkZMS3Jz?=
 =?gb2312?B?NUFWRWFyb2xpd25SMVdTMVB0R3ZhaUN6SHY4MGNXTFlSdmR1TEJPVWxDRHBl?=
 =?gb2312?B?Q2ZnTHRuWDZLVlBLM1UwUWU5WDExL0JsZXB2ODFNNGFPaVdheDlESERkZWFY?=
 =?gb2312?B?bG5TS2NaUnRVSThhcUwxU1VPTUxqT09uOTZQUmtRVk01M3NYeDB5YUluMlNS?=
 =?gb2312?B?bEhTMngzYWtyK2dwM3A0TWxITUVxYTVPNUZaN2pXU0N6ZkV6Q1JvSW1DNWox?=
 =?gb2312?B?VHppdlIwN1hwTk1UVEhCY3hWSGczczJKamFjalBGVGorWFQxa1UrL0YxalNy?=
 =?gb2312?B?Nndta1M5cDFuN3p6cXFXSnYxck96aUdTU0hoMDQxT3ZQUEZwbmYrSDZ6MXNJ?=
 =?gb2312?B?aXZGQ3kvVWh6Y1AzNTg0Wk5zZlF6Y3B2cFBER3hUZm5wbEw1VjVBTi9KTEpH?=
 =?gb2312?B?c2lRRjJab2s5M2VMbzBtTHhLYXNkZlBqYlFWaWlqb2Y3RmdXQ09NdjEyUnFu?=
 =?gb2312?B?R1k3VkpPRnAzeWFXbmtnUEZxdExEWHVhaWFoNWlrN0VMSTJ0VjF1alN6OTBM?=
 =?gb2312?B?MC9rblEyK2w0OVpVbzkvYnNsMGNFc0M4cXl2enBnZjg2SU8xdkM0cmpkckZM?=
 =?gb2312?B?NmZxYXRyT0diRjZsQ05ud3UyWXR1VVI5S0ZtWjhGQkRNTHpLSSs2TW9IclVX?=
 =?gb2312?B?OW9jdytLYTBDQ1JVRWpTUGJZWW5wRVJZY2lnSlN2TEU2aHBRdzM2Sm51WDB0?=
 =?gb2312?B?dmR0a0R4QU5aQWl4bW56YTFpSitJaHZtamUwZ1FCcXErZ2ZiNDhESDFCRlUw?=
 =?gb2312?Q?uSR/xHgFC4SqjA6eVPf/Y11Ej?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649679e6-ca14-4465-f682-08db03602d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 07:53:01.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exG6bEhgwF/VZhJxQXwukIcLZcokKENvnNfXinyCHHTAMcx1D3jeUKNSc/4k4Ul5t4bfyenHboAYkNn3kSsGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOox1MIzMcjVIDY6MzENCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29t
PjsgbWFyZXhAZGVueC5kZTsgTWFyY2VsIFppc3dpbGVyDQo+IDxtYXJjZWwuemlzd2lsZXJAdG9y
YWRleC5jb20+OyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IEZyYW5rIExpDQo+IDxmcmFuay5saUBu
eHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY3IDEvNV0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IFByZXBh
cmUgdG8gc2VwYXJhdGUgdGhlDQo+IEVuZHBvaW50IGJpbmRpbmcgZG9jdW1lbnQNCj4gDQo+IE9u
IE1vbiwgSmFuIDMwLCAyMDIzIGF0IDExOjMyOjE1QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3Rl
Og0KPiA+IFByZXBhcmUgdG8gY3JlYXRlIG9uZSBzZXBhcmF0ZSBEVC1zY2hlbWEgZm9yIGkuTVgg
UENJZSBFbmRwb2ludA0KPiA+IGNvbnRyb2xsZXJzIGluIGFub3RoZXIgY29tbWl0Lg0KPiANCj4g
VGhpcyBhbmQgcGF0Y2ggMiBzaG91bGQgYmUgMSBjb21taXQuIEl0IGlzIDEgbG9naWNhbCBjaGFu
Z2UuIFdpdGggb25seSB0aGlzDQo+IGNvbW1pdCwgZnNsLGlteDhtKi1wY2llLWVwIGJlY29tZXMg
dW5kb2N1bWVudGVkLg0KDQpPa2F5LCB3b3VsZCBtZXJnZSB0aGVzZSB0d28gY29tbWl0cyBpbnRv
IG9uZS4NClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gUm9iDQo=
