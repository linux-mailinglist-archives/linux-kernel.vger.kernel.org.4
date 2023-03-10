Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436E6B3C77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCJKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCJKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:39:38 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1b::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273845AB65;
        Fri, 10 Mar 2023 02:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTMi966BTN17IV+wObmeQIK/dlQyfJIZ23ZAxsMwpbJMo3VhxaE+p/XFKuUI/kMAqU+z/U4Rw8q1l2Pnk2men4c2Jhe48kZxmzsBRyKylh7mMNUMFHyKIVXy1zkBoDPxFVsVZe08F6ClEr/L3MzPl93LleUC2+QB6s7U+GmOeShnLdrsgRoZf6EORkJUoPW0xn/YBwUacVdVc0R2mN+RAgiAyipg73pE/ka+jWvIIgFghcJE/k8d36OIdKBIcpP13hj8eeetM+RL2WzfA6ENs6I1fT+LoV6t2dod9OBd1nsu47+y4qw/kl41tSdwLqm8p3FNA/6oElgq2IXnlHYOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSZyfSZhEPBmoJuBSHfr19B3hefEKFlfO1XCMMqOj2U=;
 b=kD59qwVMt/W5Jvz5PKqup1ctmm47NK5A26JDpFPkUvdsSR+L8hmznKzFNQ/MMv9cihq9LtFCxQIx2AcDQmgtnYO8pPV3nNYdDgBz9GpinmkrV50SMs9MjNkScJvdSthmHoJWPAZWSgsSrk8huiJ+LlsgsUUa+ivi3ADa6kSYsgy3VXcuw+8pjGQWdqGYfxCKev/JBJZNMrhYluh/LeICnpPDcmbFfKlaRx1aIJeBN0QhZhAiExQPCq9Wvd5yaZxDzhhCdxo4ux2APIpmh+B8TocJwG0+0lYEl7TTRVeDl9jiJShCql8K+n8YUV+FlhOTC7un6KfEWZlvF8Dvz2ghDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSZyfSZhEPBmoJuBSHfr19B3hefEKFlfO1XCMMqOj2U=;
 b=N/VB95Nt50Rk72nsKPZrmEHKLgqFL85ws+T1v5OqSw4fmSjmUpjACjQ9M2GzrJVdF1yI9rpS81/w5evvJBt1dyUzm87jV51RLVYMdAwMkXYCelEyJO0kzBWGC3YbFOs3liDHdEzJ4/kUvk6RGu8bSfNBRihqGEo6+7Hctz0ug3A=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DB9PR04MB9991.eurprd04.prod.outlook.com (2603:10a6:10:4c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 10:33:10 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6156.027; Fri, 10 Mar 2023
 10:33:10 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Franck Lenormand <franck.lenormand@nxp.com>
CC:     "code@tyhicks.com" <code@tyhicks.com>
Subject: RE: [EXT] Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Thread-Topic: [EXT] Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Thread-Index: AQHZRbcdZwi0NNJ1FU2rf8OJ6oegUK7ZqW+AgAjGiwCAAwSxoIAOdx0A
Date:   Fri, 10 Mar 2023 10:33:10 +0000
Message-ID: <DU0PR04MB9563EF763930B710A7A34F608EBA9@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
 <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
 <d253d5ba-8e57-dc20-dfb4-08aac9e92a4c@linux.microsoft.com>
 <DU2PR04MB8630B140D8B546864FBA016095AF9@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <DU0PR04MB9563816236B13CBB7F398D528EAD9@DU0PR04MB9563.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9563816236B13CBB7F398D528EAD9@DU0PR04MB9563.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|DB9PR04MB9991:EE_
x-ms-office365-filtering-correlation-id: 80dd356c-6531-429f-9590-08db2152d876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSrgptumVwBSO2+WEijGo7ycJTSawWqrc8z5lGExosER1lbHtCUROF3gBsRa4L+LRWsTfBCVUdlHryyNcaVKuUNRVykZePjeEhTcHbT6mVA2OhWkL7JiMKVT0DG0/Wy6YwjSUPvPsNWOwoqChfiU81a11jYKj0/orDyPUIoduTVXAqnHgjPCKUBlqcuDsKTGzOAq/uGhn/SxReTyR0W9gvK0UZrj4dOKw5wfNgAw8vO24jSZo7dORIAy2N/w+MX9lrXmvRJFehAo3y9TjrXrqIPAT06FJJadZJhUamON0EaeFI3pV5WwZ8HBLvh3u3zk0p8So0vFfDZydnNlaefU42PpwCTkPugneHRHfHWS4T2f/rCpLeb7NfdZuX4DLzfO3f2FZ4Nk2kNpcBF9Hpf6pRG8o5W11r28r8H5/WZBm6TAIdUa0KWcGF9xQhwyoZe7JBKfi6IB8VoTNWKb03rCkqCX8MrRgkZ5wywTfBhqtRWGIMNZSM/FSOPVn8wYDs4+wMNzWlqOqYC0XjHqXtVZEuNIwi4ZT21v28yecE9GJwgUntqmybUP9LsrAfGB066WDKlSnvjq5Tmls4POK/82Goz+dvRnwjsrzC63H9/k+OfrN0R/BL7JvZaAJTRMqwo3DTlblxfkPtZy+GicDY41cuZw4JIDFgQfupZVhDtDprBLVAVETbH2W/XDAtf60YUzhiBh3Vw+fcOd82dSrzig7fWOLV7xR+tPSqAEQC/vFlc2KX2pk8EbPg3EMiofxwL8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(110136005)(6636002)(316002)(33656002)(55016003)(38070700005)(921005)(86362001)(38100700002)(7696005)(122000001)(6506007)(83380400001)(9686003)(53546011)(26005)(186003)(8936002)(71200400001)(52536014)(5660300002)(478600001)(41300700001)(44832011)(66556008)(64756008)(2906002)(66476007)(66446008)(8676002)(66946007)(76116006)(4326008)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXFOQkNZQWk0NitJMDNYMG5Ld2dEcUg3b3VBL1ovUFdRTjFuVEsxQmltVEhQ?=
 =?utf-8?B?SENaWTc4VlZUREVQTk9iNnlpall2Q2pZWUxMUEJyR2l1Y3ZXVkF1RTN4OU5w?=
 =?utf-8?B?QjRSU3JKTFFRdDNaSTV3cUxpWFNid2EvSGY5L053V3JxNS9vK2p6OHhJbld5?=
 =?utf-8?B?Rmc5N3RlMXlmZVd4MHFGak5USG9UYTBvKzdkdml6Y2FaNkRlTk1HS2E0UlhV?=
 =?utf-8?B?NHROVlZmd3dNZko3Qy8vZnNjNVZzTzZHenRLSU9TSEt3QS9SMVNoYmtoS3Za?=
 =?utf-8?B?eTZueGhGU0IweDBOUi9ZaW83cDdZQm93Y1F0TUc1TElGbDlUdStnZEJ0QUox?=
 =?utf-8?B?ZktpV1liNmtFcDA4bnl2RU5wOXVoWG1UM296eUVyOWJVbXNrenppdTM0OW9z?=
 =?utf-8?B?SjlMeXhSSEhtclZoVDNKVWhyWHZlVzZTbC9rUFFjbDU0VkhNYWh4eUtXNXRz?=
 =?utf-8?B?TkNlMDV0ZVJiTmVmUkVGMTQxZHpXOTR6MHI3Z1EyckJpMzVxcVdNV3pFdzdv?=
 =?utf-8?B?aXNlUVJjUkxtYXVhSVBqN1VUait2TFV0UkVsaTRCUUFhZEFjQWFLQVNqejhZ?=
 =?utf-8?B?dGdyQ2x6N1lpSzNlVE94dWNrdmNITk9RTGRyRUJGa0Q3ZGVadmJ2ak5nRkpl?=
 =?utf-8?B?YU1PYU5tZThrNkNMUEwrb25YNUNhRjB4Uzg3a3ArMXE3L0Q1Sk1YTTJEMjh0?=
 =?utf-8?B?RG5rRWN6R2NUVHhQZ2crdEtqd2w1bmgxNnhrZWlnSVJsdG8wK0RVTUFYRUxE?=
 =?utf-8?B?blBzT2UzS2g4bXRybm5iYkhaTVg2QVNKQzBHeTRENVBTdjRpVnJTM0NQZGFT?=
 =?utf-8?B?MnkrMG9HOW16NHltTkszbHA4MmxWdVZFczdid2FoUTZ4ZzBVblVDN1RiNE52?=
 =?utf-8?B?K3VIVUpHYjllWHBIWVN2R0pSNnIyTHFzeWk3NXBGdVZHTkNrMHJqNjJ4ckwz?=
 =?utf-8?B?bW9qZVV6QmFEZEo2bk9Fd3d1QWxXc2M1end3MVpNRWF2TENYY0ptUHFVbU55?=
 =?utf-8?B?S0FML2Q0eTExUDFKSDY5Zm81aURxSUdPbmVSK0hJY2UwSjNvNUJDeHZMamJV?=
 =?utf-8?B?TVg1VFlWUFhYQTBlVURmZTlEaE14Ly9ublFHYVRYN2VSYXlLWWFTN0twaTMx?=
 =?utf-8?B?US9lbDdZS25Ldzd1RUZGVHluRzZLNXFlb1lXdUMram8xM0RGMkdnWHd4REF6?=
 =?utf-8?B?dm4zdlNGdlduUi83VHg1eXZrNFZmTVUyREV2SVNJWVZuQVZRcW5STThsSG1n?=
 =?utf-8?B?OE5yYVdIQzhvbXdmSGNDaGw0MWNGU3ZZNXl4Z3JGQ3ZMTTJpTHMxTk8rTEFQ?=
 =?utf-8?B?L25ZS3ZQTjZQaWhZODlVRGtjb0wvMWZuTmxwNkRITHM5UVFGajBUdzB4NmVi?=
 =?utf-8?B?d3BnTnBaNkJubERCRkQ2YVBnSzduQ3l4SXM1V3EvQWFLamZvVTNaODZ6ME1C?=
 =?utf-8?B?U3lCWFZDcW5DTlQzZ0hrdEVVREZQUFh1WG92YXFPV1hnK0ZnNXRXbUFLZVVx?=
 =?utf-8?B?YUxpaGN1VnFqTU9CeFJtbG9yTWRZVVBJRGNjQmlzT3BseG1teERYOGpUcVdl?=
 =?utf-8?B?Mi9TcGF2TVBiUkJ2RDFzcFFJMFFMVHdkVlNGRnNzTDVXTVNkMUVaT2dYRURl?=
 =?utf-8?B?RkNHNkJOSkw5bkk2VUUxeVZrVEVRbm1qdERGenl4d0U2M3FqNHJsZXFjWmpN?=
 =?utf-8?B?MGY4Uy9qTHVtbXdSYzlkVlAzTWMveHF3THIzdWhaSFhrZkVPcTZ1UnBkTEZE?=
 =?utf-8?B?eWtST2JWbG1CZ1BVeWRnMkVSNjBlMGRoRXIzWHZ4VnpLM3lMM04rTU91aCsv?=
 =?utf-8?B?UzNGc29kY3pHY2NTTUI2NFUzM0ZOOExWdlVFbDFQRXlOVHA2ci9TVmtmNEhH?=
 =?utf-8?B?M2VmUXgwWS9BZGwxUm1SdlpJZ0tJVm9RVk9EMEwzekdIVTdpUlhIMk9LREpk?=
 =?utf-8?B?NjlZYXZOUSt3TUV0dG5naFNhd3hWUTlVc3p1bStJMndGaDFzSGxnRWxEWDR0?=
 =?utf-8?B?blZZUFBiVjAzeTFxTEp5VnhyaklSRlhaTTIwbVJQRDRTU0ZEeGptY2cyZGRD?=
 =?utf-8?B?N05qbThPZVdUMGFtMXVEdzJYcExTWGFGcWNXcktuc1hiQ1JlNldDYkx3UzBm?=
 =?utf-8?B?WHdGZXM5WmozRWxQWnZoTEhDT0Q1RGM1dWJkNFZyY1hFL0JZTUpRdXErU0ho?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dd356c-6531-429f-9590-08db2152d876
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:33:10.5117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33oKtX9qQljIFR0Os3AwFGDaubFjGqZY3wyRzl3cNNFXjgiM0b46xJYhju4WRYTc3v5rxqVCv1xOD/hLUYwV9Ofq6orYB3e+TZr6EtGI2mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGVyYmVydCwNCg0KSWYgeW91IGhhdmUgbm8gY29tbWVudHMgdGhlbiBwbGVhc2UgYXBwbHkg
dGhlIHBhdGNoDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWVlbmFr
c2hpIEFnZ2Fyd2FsIDxtZWVuYWtzaGkuYWdnYXJ3YWxAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAxLCAyMDIzIDExOjA5IEFNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5n
dXB0YUBueHAuY29tPjsgVmlqYXkgQmFsYWtyaXNobmENCj4gPHZpamF5YkBsaW51eC5taWNyb3Nv
ZnQuY29tPjsgSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFZhcnVuDQo+IFNl
dGhpIDxWLlNldGhpQG54cC5jb20+OyBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47
DQo+IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbGlu
dXgtDQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEZyYW5jayBMZW5vcm1hbmQNCj4gPGZyYW5jay5sZW5vcm1hbmRAbnhwLmNvbT4NCj4gQ2M6
IGNvZGVAdHloaWNrcy5jb20NCj4gU3ViamVjdDogUkU6IFtFWFRdIFJlOiBbUEFUQ0hdIGRyaXZl
cnM6IGNyeXB0bzogY2FhbToganI6IGFkZCAuc2h1dGRvd24gaG9vaw0KPiANCj4gQ29weXJpZ2h0
IHVwZGF0ZWQgaW4gYW5vdGhlciBwYXRjaCBhbmQgc2VudCB2MiwgYm90aCBwYXRjaGVzIGFyZSBt
b2RpZnlpbmcNCj4gc2FtZSBmaWxlIHNvIG5vIG5lZWQgdG8gbWFrZSBhbnkgY2hhbmdlcyBpbiB0
aGlzIHBhdGNoLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBG
ZWJydWFyeSAyNywgMjAyMyAxOjAzIFBNDQo+ID4gVG86IFZpamF5IEJhbGFrcmlzaG5hIDx2aWph
eWJAbGludXgubWljcm9zb2Z0LmNvbT47IE1lZW5ha3NoaSBBZ2dhcndhbA0KPiA+IDxtZWVuYWtz
aGkuYWdnYXJ3YWxAbnhwLmNvbT47IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+
Ow0KPiA+IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+OyBHYXVyYXYgSmFpbiA8Z2F1cmF2
LmphaW5AbnhwLmNvbT47DQo+ID4gaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1OyBkYXZlbUBk
YXZlbWxvZnQubmV0OyBsaW51eC0NCj4gPiBjcnlwdG9Admdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGcmFuY2sgTGVub3JtYW5kDQo+ID4gPGZyYW5jay5sZW5v
cm1hbmRAbnhwLmNvbT4NCj4gPiBDYzogY29kZUB0eWhpY2tzLmNvbQ0KPiA+IFN1YmplY3Q6IFJF
OiBbRVhUXSBSZTogW1BBVENIXSBkcml2ZXJzOiBjcnlwdG86IGNhYW06IGpyOiBhZGQNCj4gPiAu
c2h1dGRvd24gaG9vaw0KPiA+DQo+ID4gQ2hhbmdlIHRoZSB5ZWFyIGluIHRoZSBMaWNlbnNlIGhl
YWRlci4NCj4gPg0KPiA+IEFmdGVyIGNoYW5naW5nLCB5b3UgY2FuIGFkZCB0aGUgcmV2aWV3ZWQg
YnkgbWUuDQo+ID4gUmV2aWV3ZWQtQnk6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5j
b20+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBW
aWpheSBCYWxha3Jpc2huYSA8dmlqYXliQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4gPiBTZW50
OiBUdWVzZGF5LCBGZWJydWFyeSAyMSwgMjAyMyAxMTowMiBQTQ0KPiA+ID4gVG86IE1lZW5ha3No
aSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54cC5jb20+OyBIb3JpYSBHZWFudGENCj4g
PiA+IDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+
OyBQYW5rYWogR3VwdGENCj4gPiA+IDxwYW5rYWouZ3VwdGFAbnhwLmNvbT47IEdhdXJhdiBKYWlu
IDxnYXVyYXYuamFpbkBueHAuY29tPjsNCj4gPiA+IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5h
dTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbGludXgtDQo+ID4gPiBjcnlwdG9Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGcmFuY2sNCj4gPiA+IExlbm9ybWFu
ZCA8ZnJhbmNrLmxlbm9ybWFuZEBueHAuY29tPg0KPiA+ID4gQ2M6IGNvZGVAdHloaWNrcy5jb20N
Cj4gPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIGRyaXZlcnM6IGNyeXB0bzogY2FhbTog
anI6IGFkZCAuc2h1dGRvd24NCj4gPiA+IGhvb2sNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gPiA+DQo+ID4gPiBPbiAyLzIwLzIwMjMgOTo0MCBQTSwgbWVlbmFrc2hpLmFnZ2Fy
d2FsQG54cC5jb20gd3JvdGU6DQo+ID4gPiA+IEZyb206IEdhdXJhdiBKYWluIDxnYXVyYXYuamFp
bkBueHAuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBhZGQgLnNodXRkb3duIGhvb2sgaW4gY2FhbV9q
ciBkcml2ZXIgdG8gc3VwcG9ydCBrZXhlYyBib290DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KPiA+ID4NCj4gPiA+IFRl
c3RlZC1ieTogVmlqYXkgQmFsYWtyaXNobmEgPHZpamF5YkBsaW51eC5taWNyb3NvZnQuY29tPg0K
PiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IFZpamF5DQo+ID4gPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gICBkcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMgfCA2ICsrKysrKw0KPiA+ID4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3J5cHRvL2NhYW0vanIuYyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vanIuYw0K
PiA+ID4gPiBpbmRleCA4NzQ1ZmUzY2I1NzUuLmEyYTk5ZDA5YjRhZCAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY3J5
cHRvL2NhYW0vanIuYw0KPiA+ID4gPiBAQCAtMTk4LDYgKzE5OCwxMSBAQCBzdGF0aWMgaW50IGNh
YW1fanJfcmVtb3ZlKHN0cnVjdA0KPiA+ID4gPiBwbGF0Zm9ybV9kZXZpY2UNCj4gPiA+ICpwZGV2
KQ0KPiA+ID4gPiAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiAgIH0NCj4gPiA+ID4NCj4gPiA+
ID4gK3N0YXRpYyB2b2lkIGNhYW1fanJfcGxhdGZvcm1fc2h1dGRvd24oc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikgew0KPiA+ID4gPiArICAgICBjYWFtX2pyX3JlbW92ZShwZGV2KTsNCj4g
PiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAgIC8qIE1haW4gcGVyLXJpbmcgaW50ZXJydXB0
IGhhbmRsZXIgKi8NCj4gPiA+ID4gICBzdGF0aWMgaXJxcmV0dXJuX3QgY2FhbV9qcl9pbnRlcnJ1
cHQoaW50IGlycSwgdm9pZCAqc3RfZGV2KQ0KPiA+ID4gPiAgIHsNCj4gPiA+ID4gQEAgLTY1Myw2
ICs2NTgsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjYWFtX2pyX2RyaXZlciA9
IHsNCj4gPiA+ID4gICAgICAgfSwNCj4gPiA+ID4gICAgICAgLnByb2JlICAgICAgID0gY2FhbV9q
cl9wcm9iZSwNCj4gPiA+ID4gICAgICAgLnJlbW92ZSAgICAgID0gY2FhbV9qcl9yZW1vdmUsDQo+
ID4gPiA+ICsgICAgIC5zaHV0ZG93biA9IGNhYW1fanJfcGxhdGZvcm1fc2h1dGRvd24sDQo+ID4g
PiA+ICAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gICBzdGF0aWMgaW50IF9faW5pdCBqcl9kcml2ZXJf
aW5pdCh2b2lkKQ0K
