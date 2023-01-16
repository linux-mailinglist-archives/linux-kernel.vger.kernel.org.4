Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BE66B575
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjAPCCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjAPCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:02:46 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD94C26;
        Sun, 15 Jan 2023 18:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfawLjfCqcdUOOQf8cGtFUAs7++4Cs8pEHmRldZamezlnD+eHzaMdVJ8QKvWu4vYRE3ou/SNyWghvNDH+nFZlaSnXKcpVH6AOUSpMZWPjyRJJaUmsY1pvW7pE0LgdmQsb1SG2k5Oz0/eaek5DmDpwQf48EyX+QTrHWk2Q256TpmXhm3P1HQCCojD0DHpkTZS1++6v9810fNhl6UO1wArWwOiA5h24yTHcuQCoLGnkvJwYkD+nhZZUTgbRzAPsXdrb06Bks7JoOD9yTOl5rsRrOwhdkpeDYkLga75nKct0mwiJLSX/EnZ2bTXRwsBDIfmb30A/ae448YXItsJWrnKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEt25ARmVm8Bt4NxljggH1/hiQCWGmy/FFwH4cR4RNY=;
 b=Yip1kxZ9Z6/KwIFxNM41KIg7XitFOarpOgeE38sYwHVv7X+UmiEWO5FBN02Ooe6PiqVmZ3OhZZPvNGafUHlJGfw6v3f2SOXpZJIqZjjPIk4rBzTKsZkt7aCD2A9662VMSWr1fCLhT6/sf10CsVFCrvQMfFQmareF9tc7ABKhaHknhHSXtuBujiLcDG4/CzzmlCXdiPatG3mJn5bCPoVQbCEayDfVSMvbl7TXazN8yPxbHcK+CHuspo1OJYIIMt8yZLBGo8sLLBE3bdFhIr4Okht1L2W/0z7jl/T6jOb4V+48vtow7lV976anGM0/Xiuw8eDBt4trjuSDMKgTubFtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEt25ARmVm8Bt4NxljggH1/hiQCWGmy/FFwH4cR4RNY=;
 b=mwLqjY3ukBundLh/CSY7L9orHyP0/DZ2YKVf0KHU9bSshCLPCg8QE0hHNalHQ5kPOI/6Oq71w+YZwianLMO37qLYW1HHnYGNAC96hp6YYNNKU4JMapd76DbXBJ0mlS5KZCGiXj/m1WeKaCLrUF9JlLpVJlCTYS69Y+5RpKj3n6s=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Mon, 16 Jan
 2023 02:02:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::49b8:a7b4:676b:2f8d]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::49b8:a7b4:676b:2f8d%3]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 02:02:38 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Thread-Topic: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Thread-Index: AQHY54JopHT5ExQx9k2dh6kI/soZba4/iW4wgF18iQCAA8GIgA==
Date:   Mon, 16 Jan 2023 02:02:38 +0000
Message-ID: <AS8PR04MB86761435C520BDD64C88F2508CC19@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
 <AS8PR04MB86761655C5F12142BA183B998C049@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <Y8GECJPWt126G8am@lpieralisi>
In-Reply-To: <Y8GECJPWt126G8am@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBBPR04MB7609:EE_
x-ms-office365-filtering-correlation-id: 6f16f2cd-8cbc-4c59-ef12-08daf765be87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dHBQnEAp1uuS4qniM3YCkX4XdH8WhYC8bSNnbUFmTQAn6igfRxy0oh3r3MUjQAF/aqbJfi8S+qbxnyqNNFMQTQGYCn1cLSiom4XBx1p2m3iTosu7RBtBKk8vMx+A6+YfEfoq+RZvq3bxN6iE9plAVjRNw49pRmVqGPVCo//IdSkRo+MapvYp5w3915Ipo3W1RX2x+H4b+UhrRtP2ZF1jSVoNGH7f4Am4e2dlZMK0FtExm4Ouf/2+pC6ulbKTrxp4SlCN73QYifbgO6LT5jL7YPEakxoiXfI4Wm/qKnHUrcBWEKIdV69yuWKFZS5qhCUW5oF+3wgCXnmlp0b/+2XuDcXGKYxIDaeNpbGGBS0L2MQhS3ZCRC1u/hIOYOt3TlIEmdor+F9sSivhT/HMTr8CxRzEy1ZlGUFEP8SrD3/IJYC8xqF2hCWbyTHB7Y/F5KIs6ib2f4B4862fG1Klx6M+C8lj6Z4CAKA3wYNo95EimJzhFQwTeuE65V7tm9QfybRutl3NTOVEACTuLIBN0piVi5vdV4f0VHjXKMxSUe09ljPsuglj/RMv/DPa1TBR2y3gaZEJvcQT47noDyQJQEgEZCdh2YccGrz2RmY8kG6D3KbIBow9DxAMWLLapyew0k2AN4Mvc/bhiG1+04lTQ5B2jdATsN8tJ7AYsURLRe26aZ2AMyOND7/vHwHwnIW9ATLWwECtz7mYOPKCkH0FYN7Emg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(54906003)(71200400001)(45080400002)(33656002)(41300700001)(4326008)(6916009)(316002)(66946007)(76116006)(66446008)(66476007)(66556008)(64756008)(83380400001)(86362001)(38100700002)(38070700005)(55016003)(122000001)(478600001)(966005)(8676002)(7696005)(9686003)(6506007)(186003)(53546011)(26005)(2906002)(44832011)(8936002)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a2VTOVUzaXBVMm5XTW9QNzdRRUJGei9LTUoySHhKYTE1aFAwVDJ6NDRIVzdL?=
 =?gb2312?B?M1dFVSszNDVXWktlZEI1VFJibzJkc0NYam9GSnVTMHQ4N1NWeFRHYTJiREg1?=
 =?gb2312?B?OWswR0VYNDJwZ0oxa0FsT3FHbHlPa3JldGJzR3JXN2x3M1liY290MGZ6VUVu?=
 =?gb2312?B?UE1tNzFJclZ1SGkzWFg5OTFNWHVKUE0rbCsxczhWR3RZVzBoZEtiVzV2Y2tw?=
 =?gb2312?B?cXFQODZCUlNwdjhHRkZIZjZmRXg4U1FHdmxxY1R5RURlS3EwYU9rNTIzbER3?=
 =?gb2312?B?Q3NoNlJDbndBdllnTUthQk9DbURWUUJzRS9hbUxmN3JMaUp3dWVjSmhJa2Zh?=
 =?gb2312?B?TjQySS92MUwwTnRjVnZQNmZxcU9UNGhhUVdmM3RrVG52c09KT05JejBrMEVF?=
 =?gb2312?B?VjRJVDczRldGTm92M1Z1N0RCMHRWV0FmMU56VGxPWlRwVVE5YUNwL3d1UU02?=
 =?gb2312?B?bG9JZ0tUbWllSURETVllODNrU2pYcFM4RDRxU0xiOFJPSkI3Nlh5QUVmZHlC?=
 =?gb2312?B?TndLZzUvaTBFUDlWbjE0SGk5d2taN05vR2F4VjFEekkreXdMdlJzaWQvNlUr?=
 =?gb2312?B?bzRwQldkZHJKRTdGZkg5SGx6QWNCbGZZa0tMZkY2dm1LWll5L3lSVkhqekNl?=
 =?gb2312?B?cEphaVdiZHdDWlhrSnRTelV1N2R5TkxyRHE2MCtJaUh6aGFYR1I5ZGd0TW9Q?=
 =?gb2312?B?WG03OUw4VGYrNFlRSGN2NjhZaFFIN0gvbzdub2dSWUVsOUtFNldCVE1ySzFX?=
 =?gb2312?B?cS9uQTRmWGhqakV0QVU2cDJjV3VUM1VNL2hFMC9YazJmZ2d2TmswMEVQa3lw?=
 =?gb2312?B?V0lhM1ZQUHRwaTlHNE5sejgydzZBYWtMTjNZQnRkRVorbFh3S2dCRlV0eVkx?=
 =?gb2312?B?WjBkMHc3U3g4a3NwTGFxMVVaQnhBVFFNVFZlVTBSVTJZeGxuY2ZVU0ZVSVRL?=
 =?gb2312?B?cWsvNEVVditkcXhVZWc5NW5ncTJhRjltTkYwWjZJOEhpMERTOFBrNGd1U1Uy?=
 =?gb2312?B?cVg2SjM3RXhLWGFxS21zUURxdGZhcFpBOFFzK1JkMml5VXBkV1VJamdUR0p6?=
 =?gb2312?B?NkprVmZxMWhQUm13dk5XTGk3dEJCVTVjdnZBK1hvWXNSbkx5cGFyUDFJRmE3?=
 =?gb2312?B?bWxDTjFqU2pkYnVNUDNCMmNzbm9ZWHBRZXhwTFdBVml2N3BPUmlXUVU4dkRG?=
 =?gb2312?B?THFmV2dGS1BBRjEzYSs3dXpQU1VmWVlTUEhHYjhpMFQrSEdrbHYxNDNxc1pj?=
 =?gb2312?B?ZDNiODFyZFNkUnhybURWditqN3hSM0lRQVFnNXpabWQ2ZXBQS0FMZHVRbllK?=
 =?gb2312?B?Z0wrb3RXTnkvaWt5YTZkSUJObTMwa0tKMVZobThGb2o4Y2pSNFRwa1dkSldH?=
 =?gb2312?B?Y0NQTTZiVDc2dGIrK0lMR1AxTTAwUHh2Ty9kRXZMczFNWUVOY1dYeG81UlMr?=
 =?gb2312?B?NzVjYkZ1QStDdTZpWldycG04cTVDWTVyaTVURksvdUNmcUJwekR0TWdETUY3?=
 =?gb2312?B?ZnAzL3R1Z0pvL3JmTGRJVjczMCtDWEJyREhRbDkvcGZQanpvKzNKOFdkVGov?=
 =?gb2312?B?UnltUFlMUXF1Qk53ckduMloyNG5PdDZjSk94a2VReG1jR0h5UUwrcGtxYlR5?=
 =?gb2312?B?V0JUMXoweTJvWmVuay9oMlIwazRoWTFFWFY3VWJMNzJSQ3pwTEg2WlYrSUV0?=
 =?gb2312?B?dFVUNXREVnlhVFA2bEkwMjh4K3BKRWpFOU13Y0trT21RdTc5OWlEZUlCSHYz?=
 =?gb2312?B?c25ROU1TVHh2YW5uSm42d2xFQTRkRFNaNWJlSDFPcnB0TzNKN004QlFzQ2Q5?=
 =?gb2312?B?Yk9ucEhLc0ptaXlpMUFOSWtHSlBOeDVPcXdmNW5ML203U09LZ2pMZzA4eDlz?=
 =?gb2312?B?d3BmVDhDMlpYQWc5SFlBYVBoUThsTGREcDBacDhGTVJ3Q2NNcS9qTnR3Rmgy?=
 =?gb2312?B?dkVUOTUya0VUaDdkMVZqNUhMb0FLa3l3U28zN201RW5WRHdTUjhXS2xMZFd1?=
 =?gb2312?B?MFJCODBiSnVQcnA2VW1RbERvY0pRK1N3L2ZQaEtETmM1ZnhHUGFZVHlualh4?=
 =?gb2312?B?cWRDVVhoNEJaOXY1dFRBOVlENzNWSktjL1ozTTFaWFVVb3E3akNXNUxBMk5r?=
 =?gb2312?Q?FHYcVTKnASUd5Xex5SrTLuv01?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f16f2cd-8cbc-4c59-ef12-08daf765be87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 02:02:38.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcydQZVTpp3oHnsT/oDsv9HYIfGIlvM09bnsQIyHh/dyND7OEvFHHuIb9QBM+S8LpQR6nU43f+YqTUdGPJ1YEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG9yZW56bzoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOox1MIx
NMjVIDA6MTcNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENj
OiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IGtpc2hvbkB0aS5jb207DQo+IGt3QGxpbnV4LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54
cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlt
eA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC8xNF0g
QWRkIGkuTVggUENJZSBFUCBtb2RlIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgTm92IDE1LCAyMDIy
IGF0IDA0OjQyOjMwQU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiBQaW5nLg0KPiA+
IEFsbW9zdCBvbmUgbW9udGggcGFzcyBhd2F5IGFmdGVyIHRoaXMgcmUtc2VuZCBvZiB2NCBzZXJp
ZXMuDQo+ID4gQW55IGNvbW1lbnRzPw0KPiANCj4gQ2FuIHlvdSByZWJhc2Ugb24gdG9wIG9mIHY2
LjItcmMxIGFuZCByZXNlbmQgaXQgcGxlYXNlID8gSSB3aWxsIG1lcmdlIHRoZSBkdA0KPiBiaW5k
aW5ncyBhbmQgUENJIGNoYW5nZXMgdGhlbi4NCj4gDQpTdXJlLCBJIHdvdWxkIHNlbmQgbmV4dCB2
ZXJzaW9uIGFmdGVyIHJlYmFzZSB0byB2Ni4yLXJjMS4NClRoYW5rcyBhIGxvdCBmb3IgeW91ciBr
aW5kbHkgaGVscC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IFRoYW5rcywNCj4g
TG9yZW56bw0KPiANCj4gPiBUaGFua3MuDQo+ID4gQmVzdCBSZWdhcmRzDQo+ID4gUmljaGFyZCBa
aHUNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjLE6jEw1MIy
NMjVIDE2OjA2DQo+ID4gPiBUbzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+ID4gbG9yZW56by5waWVyYWxpc2lAYXJt
LmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsga2lzaG9uQHRpLmNvbTsNCj4gPiA+IGt3QGxpbnV4
LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+ID4gPiBDYzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
PiA+IFN1YmplY3Q6IFtQQVRDSCB2NCAwLzE0XSBBZGQgaS5NWCBQQ0llIEVQIG1vZGUgc3VwcG9y
dA0KPiA+ID4NCj4gPiA+IGkuTVggUENJZSBjb250cm9sbGVyIGlzIG9uZSBkdWFsIG1vZGUgUENJ
ZSBjb250cm9sbGVyLCBhbmQgY2FuIHdvcmsNCj4gPiA+IGVpdGhlciBhcyBSQyBvciBFUC4NCj4g
PiA+DQo+ID4gPiBUaGlzIHNlcmllcyBhZGQgdGhlIGkuTVggUENJZSBFUCBtb2RlIHN1cHBvcnQu
IEFuZCBoYWQgYmVlbiB2ZXJpZmllZA0KPiA+ID4gb24gaS5NWDhNUSwgaS5NWDhNTSBFVksgYW5k
IGkuTVg4TVAgRVZLIGJvYXJkcy4NCj4gPiA+DQo+ID4gPiBJbiB0aGUgdmVyaWZpY2F0aW9uLCBv
bmUgRVZLIGJvYXJkIHVzZWQgYXMgUkMsIHRoZSBvdGhlciBvbmUgdXNlZCBhcyBFUC4NCj4gPiA+
IFVzZSB0aGUgY3Jvc3MgVFgvUlggZGlmZmVyZW50aWFsIGNhYmxlIGNvbm5lY3QgdGhlIHR3byBQ
Q0llIHBvcnRzIG9mDQo+ID4gPiB0aGVzZSB0d28gRVZLIGJvYXJkcy4NCj4gPiA+DQo+ID4gPiAr
LS0tLS0tLS0tLS0rICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0rDQo+ID4gPiB8ICAgUENJ
ZSBUWCB8PC0tLS0tLS0tLS0tLS0tPnxQQ0llIFJYICAgICB8DQo+ID4gPiB8ICAgICAgICAgICB8
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICB8DQo+ID4gPiB8RVZLIEJvYXJkICB8ICAgICAg
ICAgICAgICAgIHxFVksgQm9hcmQgICB8DQo+ID4gPiB8ICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICB8DQo+ID4gPiB8ICAgUENJZSBSWCB8PC0tLS0tLS0tLS0tLS0tPnxQ
Q0llIFRYICAgICB8DQo+ID4gPiArLS0tLS0tLS0tLS0rICAgICAgICAgICAgICAgICstLS0tLS0t
LS0tLS0rDQo+ID4gPg0KPiA+ID4gTk9URToNCj4gPiA+IFJlLWJhc2UgdG8gNi4xLXJjMSwgYW5k
IHJlLXNlbmQgdGhlIHY0IHNlcmllcy4NCj4gPiA+IEJUVywgdGhlIGZvbGxvd2luZyBQSFkgY2hh
bmdlcyBbMV0gaXMgcmVxdWlyZWQgd2hlbiBhcHBseSB0aGlzIHNlcmllcy4NCj4gPiA+DQo+ID4g
PiBbMV0NCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnBhDQo+ID4gPg0KPiB0Y2h3JTJGJmRhdGE9MDUlN0MwMSU3
Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1Y2NiMjhlMzkyMDQ0MQ0KPiAwYzNlNzYNCj4gPiA+
DQo+IDA4ZGFmNTgxYTc3YyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzgwDQo+IDkyMjM0NA0KPiA+ID4NCj4gNTUyODY4NDIlN0NVbmtub3duJTdDVFdGcGJH
WnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaQ0KPiBWMmx1TXpJDQo+ID4gPg0KPiBp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT03RjAw
dTFVVQ0KPiA3UGZ4THcNCj4gPiA+IGZCcklNUHZMdkxRVDhaSjZIT3drQUxpTnNCSmNJJTNEJnJl
c2VydmVkPTANCj4gPiA+DQo+IG9yay5rZXJuZWwub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBjaSUy
RmNvdmVyJTJGMTY2NTYyNTYyMi0yMDU1MS0xLWdpDQo+ID4gPiB0LXMNCj4gPiA+DQo+IGVuZC1l
bWFpbC1ob25neGluZy56aHUlNDBueHAuY29tJTJGJmFtcDtkYXRhPTA1JTdDMDElN0Nob25neGlu
Zy56DQo+ID4gPg0KPiBodSU0MG54cC5jb20lN0M4MGI1MGIzNzg5Zjk0MzNmNjJlMDA4ZGFiNTk5
OGEwOSU3QzY4NmVhMWQzYmMyYg0KPiA+ID4NCj4gNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzODAyMTk2ODI5ODI2NTA2NyU3Q1Vua25vd24lDQo+ID4gPg0KPiA3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2kNCj4g
PiA+DQo+IExDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9ajcwT1JOS0J2
VENqV3RKelMzNzUNCj4gPiA+IFR2dVFmQ0dyVlJRTmJ4UyUyQmhyR0kwWkElM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPiA+DQo+ID4gPiBNYWluIGNoYW5nZXMgZnJvbSB2MyAtPiB2NDoNCj4gPiA+IC0g
QWRkIHRoZSBSb2IncyBBQ0sgaW4gdGhlIGR0LWJpbmRpbmcgcGF0Y2guDQo+ID4gPiAtIFVzZSAi
aS5NWCIgdG8ga2VlcCBzcGVsbCBjb25zaXN0ZW50Lg0KPiA+ID4gLSBTcXVhc2ggZ2VuZXJpYyBl
bmRwb2ludCBpbmZyYXN0cnVjdHVyZSBjaGFuZ2VzIG9mDQo+ID4gPiAgICJbMTIvMTRdIFBDSTog
aW14NjogQWRkIGlNWDhNTSBQQ0llIEVQIG1vZGUiIGludG8gS2NvbmZpZyBjaGFuZ2VzLg0KPiA+
ID4NCj4gPiA+IE1haW4gY2hhbmdlcyBmcm9tIHYyIC0+IHYzOg0KPiA+ID4gLSBBZGQgdGhlIGku
TVg4TVAgUENJZSBFUCBzdXBwb3J0LCBhbmQgdmVyaWZpZWQgb24gaS5NWDhNUCBFVksgYm9hcmQu
DQo+ID4gPiAtIFJlYmFzZSB0byBsYXRlc3QgcGNpL25leHQgYnJhbmNoKHRhZzogdjYuMC1yYzEg
cGx1cyBzb21lIFBDSWUgY2hhbmdlcykuDQo+ID4gPg0KPiA+ID4gTWFpbiBjaGFuZ2VzIGZyb20g
djEgLT4gdjI6DQo+ID4gPiAtIEFkZCBSb2IncyBBQ0sgaW50byBmaXJzdCB0d28gY29tbWl0cy4N
Cj4gPiA+IC0gUmViYXNlIHRvIHRoZSB0YWc6IHBjaS12NS4yMC1jaGFuZ2VzIG9mIHRoZSBwY2kv
bmV4dCBicmFuY2guDQo+ID4gPg0KPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgICAzICsrDQo+ID4gPiBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kgICAgICAgICAgICAgfCAgMTQNCj4gKysr
KysrDQo+ID4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSAgICAg
ICAgICAgICAgICAgfCAgMjANCj4gPiA+ICsrKysrKysrKw0KPiA+ID4gYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMgICAgICAgICAgICAgIHwgIDEzDQo+ICsrKysr
Kw0KPiA+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgICAgICAg
ICAgICAgICAgIHwgIDE5DQo+ID4gPiArKysrKysrKw0KPiA+ID4gYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1xLWV2ay5kdHMgICAgICAgICAgICAgIHwgIDEyDQo+ICsrKysrKw0K
PiA+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgICAgICAgICAg
ICAgICAgIHwgIDI3DQo+ID4gPiArKysrKysrKysrKysNCj4gPiA+IGRyaXZlcnMvbWlzYy9wY2lf
ZW5kcG9pbnRfdGVzdC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gPiBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMjMNCj4gPiA+ICsrKysrKysrKy0NCj4gPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMgICAgICAgICAgICAgICAgICAgICB8IDIwMA0KPiA+ID4NCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ID4gKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gPiAxMCBmaWxlcyBjaGFuZ2VkLCAzMTQg
aW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gW1JFU0VORCB2NCAw
MS8xNF0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IEFkZCBpLk1YOE1NIFBDSWUgRVAgbW9kZQ0K
PiA+ID4gW1JFU0VORCB2NCAwMi8xNF0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IEFkZCBpLk1Y
OE1RIFBDSWUgRVAgbW9kZQ0KPiA+ID4gW1JFU0VORCB2NCAwMy8xNF0gZHQtYmluZGluZ3M6IGlt
eDZxLXBjaWU6IEFkZCBpLk1YOE1QIFBDSWUgRVAgbW9kZQ0KPiA+ID4gW1JFU0VORCB2NCAwNC8x
NF0gYXJtNjQ6IGR0czogQWRkIGkuTVg4TU0gUENJZSBFUCBzdXBwb3J0IFtSRVNFTkQgdjQNCj4g
PiA+IDA1LzE0XSBhcm02NDogZHRzOiBBZGQgaS5NWDhNTSBQQ0llIEVQIHN1cHBvcnQgb24gRVZL
IFtSRVNFTkQgdjQNCj4gPiA+IDA2LzE0XQ0KPiA+ID4gYXJtNjQ6IGR0czogQWRkIGkuTVg4TVEg
UENJZSBFUCBzdXBwb3J0IFtSRVNFTkQgdjQgMDcvMTRdIGFybTY0OiBkdHM6DQo+ID4gPiBBZGQg
aS5NWDhNUSBQQ0llIEVQIHN1cHBvcnQgb24gRVZLIFtSRVNFTkQgdjQgMDgvMTRdIGFybTY0OiBk
dHM6IEFkZA0KPiA+ID4gaS5NWDhNUCBQQ0llIEVQIHN1cHBvcnQgW1JFU0VORCB2NCAwOS8xNF0g
YXJtNjQ6IGR0czogQWRkIGkuTVg4TVANCj4gPiA+IFBDSWUgRVAgc3VwcG9ydCBvbiBFVksgW1JF
U0VORCB2NCAxMC8xNF0gbWlzYzogcGNpX2VuZHBvaW50X3Rlc3Q6DQo+ID4gPiBBZGQgaS5NWDgg
UENJZSBFUCBkZXZpY2UgW1JFU0VORCB2NCAxMS8xNF0gUENJOiBpbXg2OiBBZGQgaS5NWCBQQ0ll
DQo+ID4gPiBFUCBtb2RlIHN1cHBvcnQgW1JFU0VORCB2NCAxMi8xNF0gUENJOiBpbXg2OiBBZGQg
aS5NWDhNUSBQQ0llIEVQDQo+ID4gPiBzdXBwb3J0IFtSRVNFTkQgdjQgMTMvMTRdIFBDSTogaW14
NjogQWRkIGkuTVg4TU0gUENJZSBFUCBzdXBwb3J0DQo+IFtSRVNFTkQgdjQgMTQvMTRdIFBDSTog
aW14NjoNCj4gPiA+IEFkZCBpLk1YOE1QIFBDSWUgRVAgc3VwcG9ydA0K
