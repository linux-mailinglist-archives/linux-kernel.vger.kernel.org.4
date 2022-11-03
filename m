Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03778617941
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCI7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKCI71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:59:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F12DECD;
        Thu,  3 Nov 2022 01:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kww80LaQT/7nw3sWZcXpjPQL2P6lSqku8DHlNg8M5vwKSzF2G5HLibKVl1kGnN8i/Fj6/igLV7JymGK6hxepJHK5v+MLgMGSs6Ps5OF7gBe+DKnv6L2awgRWe/bIkY2VZif0fA+hr8VtQSn75VdHUvT9qWgR1z3CF2WsBR9d9to+WE0FAIJmFfeHUzlsKeumce+xGkr1WxjpiglWWvai+ZJQ0Y3nWS/Fix6Cr3qdJ/SEma5D36THo43oPy/VdGPwHvkcdgJGYi7f2irXoGuYTBKwdz7klqJ1cnv8L0fvCIAoE118fesIDlSKB6zkujlnWWHqIZQk9OCG63TY6c6RjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf8Y2lWRRF+T2TGKmeOZlqdMgC7IDLC/CEA5pqLAF00=;
 b=jgXFcW5Rzpb1QAi+/zeFM4B6bfxbq7429k0bOyRy2SB9Vpj8hZMUf+enCaO/iaRDepmhRHApGozB8xXMR3kyIU9Sy6dPxAnTcZs5XgbHk/0lXUMyyt0OU5uzVnG3RREBZT9vPqVZLhX+8ev0DPj538Eoe+LKkk1J/b4w558DlgkJ7qeogtGEHbmXu7f7Hth9Fsw3H9vh/2a8kkZgD/CRDzmkGvO3Zn5ckWCwsvpMxN2ZBde2sK39zantplUg2wBnog/BOGVqRrMGMo3dHf73/adLA2vWOdun4aaJ9l/TJNlKX29NrEdeEoaCAISoSIut/bn4caQILWnU6qiQCmZcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf8Y2lWRRF+T2TGKmeOZlqdMgC7IDLC/CEA5pqLAF00=;
 b=qnZJCUfqKDG4YwMtCmn+eNkH442+deG97QhGvoIzASMsfGw11mpIn4DshSS/Je+0tDrzWROJcWZSSmnCECWMorDEUa6TZSKYjslHDzNFG0rcVR2xQXVXN5E369hDy9elM1GjsVbAhmDN1JleWjkBO3TzlP5xIM4z/gxt16Io9X4=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 08:59:16 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578%12]) with mapi id 15.20.5769.024; Thu, 3 Nov 2022
 08:59:13 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Thread-Topic: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Thread-Index: AQHY7bHIoNpmBC8xCE6+Irf4+WDxP64rwpeAgAEkZvA=
Date:   Thu, 3 Nov 2022 08:59:13 +0000
Message-ID: <CY4PR1201MB01353B0CE46F22DFF55DFFAB8B389@CY4PR1201MB0135.namprd12.prod.outlook.com>
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
 <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
 <9f2a50db-0cfe-b9ce-11f4-be406cb9888e@linaro.org>
In-Reply-To: <9f2a50db-0cfe-b9ce-11f4-be406cb9888e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1201MB0135:EE_|BL0PR12MB4881:EE_
x-ms-office365-filtering-correlation-id: e6ea5154-c98b-4db6-037b-08dabd79aded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULNEqKPGK0x+LKUDOb0Chmm4ST1gqFiudTrS4I7xW9RWwhOfewnxrNN30bUWB4T7h94DfiFhA3o11QcleC8vV9fH3Mj0Bzrf5YVXkD4RMLBQCredj/qvpXON+pKBbxzKTo9cjN32TrznGTpqlAYC/f0FK9b11HGIFcPJiqAkfCwbY/zKSIc6Vp9hx5PxvXN+JL7bKNQgl16eWP3HD+rHmjSJhgPXpKS0/7JGInH1jHGoohFeNIa6hvLVSt7lexeMRKPFGmlCrD45g87YYeuvIbaF3xjDjm40GeuNX3dCwrd0lHpVbn2wC7GBKuIymKbQWJk8UX09492KSZlRDMPkI03NzYcY+zQmwULx6QhUwmDgSSqnnVfNr4eIc8uLUR+O9GETVa6IP9UGyL6o1Ff4lRgDCAvFxy8ieRUl3+tdxcX0vIGdPc8qvZaWWEq4SiM29R1d6d16ZZkSIbt7KgrMVKy2PuzmIEM8x2vy2dcMex1YeQbwCT8jKC/ZKp1iiNAjzjDm8oUNLx/OOXApu+Wr5yIUopH3B3WJMf1aK5K4ocsi5sbLdxFZuOXRUueDgAM5c3LdmZCusGTwTjmyO4gtO3oQ6mcXTWxXlFaI9Df7PditadmADv9nicfp+B51pwvEAbQGmdBqHSf9lCa6qnpvEy4wwYYeZbWgRQo2WHV17WwbK8VA871fQMt16NkFu2KD1vF9WRNavg1ULlevgkVPmoKWhmNTaOcT8NrtOutow8JL15CPQ1ZJRdkzNf4GsoXfpTFhRmqcay80n0vWi3F0Q6fP7X0lCEs6ckakHkHsxMOID2DEL6RG9Yfe3TVW8z2f/5GqIjKrePBVWqdn69pN1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(186003)(38100700002)(66446008)(64756008)(8676002)(66476007)(66556008)(66946007)(4326008)(2906002)(76116006)(55016003)(478600001)(71200400001)(86362001)(966005)(54906003)(110136005)(26005)(38070700005)(9686003)(316002)(33656002)(6506007)(7696005)(53546011)(5660300002)(8936002)(122000001)(83380400001)(52536014)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1BpTEllemgva0dBQUFQMWRkQ2tHN2hLQmtxTHRKQVVmWUxxQ01YNk5WK2dM?=
 =?utf-8?B?QThMSFZVS3NOYTdZZjdNK1VockpmN3h1VU1wYXcrL1V4V2tzNlIxY0NIK1Zq?=
 =?utf-8?B?ZFhhRDdoMkpNekRXVFlzbjJid0xxdWRoSzMvYysrRjUzdFh3WURBcnZFL2l4?=
 =?utf-8?B?U0VldmE3TElmT2diVFZNT3ZvYkhhK2ZROXJRd1ZEa0V3UEJXZEk4S3pVQlQr?=
 =?utf-8?B?YThyQ0dWYU84UUQ3TmVYWkozNFR2ZFRTc1NveVRncGRBL3dRNkU5UHJFTjlh?=
 =?utf-8?B?bHNkUUZhK2hhZ3pyT2VOUWJIb09qaG5lNjB6ZkV6enJKTTFXUTM2Ti9haFBV?=
 =?utf-8?B?QTAxS2Jtb1ZodjlXOEpKRGo0QmUyd0c5cXRlWHdvb3ZsU2xMaTBxeWcxUjUy?=
 =?utf-8?B?T0JtSGtveEFxSGhYdm45RE1FendYT0N5OUI2dTlHbUQ4cjNsRUR3aDMxc3pX?=
 =?utf-8?B?QzhQUmgzV3NSTDZoZ1dWRnEwdlVYYjd1cXV4SExhRmJNdWhxT3BXRDl2KzE0?=
 =?utf-8?B?d3BmdkNac0Z5RGNidGZ3dy9GNUE2STJUa2Vwd3BnVERnNkV3bnpzVS9NTE5R?=
 =?utf-8?B?eC83RUNyTnQ2MEZDOHZRTVVhZmtWZlg0MWMxRGtudnJiM1BsbkM4T3g5YUFx?=
 =?utf-8?B?TGowTHllSSt5Z2hFQTZnTHpzdk9yaEF1SmhMeUpQSFFHcE41RjhUWG9UNU5w?=
 =?utf-8?B?SjREQ25IeHdMOTEzcG4yMGg2TDVlNjUzUW14bTNSN1dQdGlrN2FrNU1VTTlE?=
 =?utf-8?B?dVpMV2hORFRKM1E0dWd1dVN4YzdhSHVBaDNjZzFxSmJHSTlJQ2VPcWs1UTlq?=
 =?utf-8?B?eWZRV0VtWktzMGhBUmo4UjlLMTZOSXphYUgvT0kxSDFFZ3BRd1pUY1J3UWh5?=
 =?utf-8?B?bTU3UjJQQXpmSGhTZlJQK3FXQ1RkLzNqNFp1Ui9qaC9sdVdYTWtsQmpJdTdP?=
 =?utf-8?B?cHRnMmhyZUhnSzBOMjdjRkcraC9LVDlZQ21lYm5zeFdoZ3REYjNqMERwaWxC?=
 =?utf-8?B?Rit6ZE1RQlF2Qk1tb1A5VDdtTDhwZGR6MS9SMFpWazdYWnpFbXc3R3Ixbzli?=
 =?utf-8?B?TnhQK2oxK0J6Y0NvVFcxbmFHVDFXclc2UkhTN1pFN2JLanJxU0c2USt1Qm5i?=
 =?utf-8?B?ekZ5ZG5JdHk3SDVRc3p6M3pTWnBaUGxrajF5NHlyRWlrQmprVzN2WE03WDVZ?=
 =?utf-8?B?UGd6Ui9jalk1QXBFR3lqR0svTDFDL0oxN1kwWHFheStlQ2FQdjZZZnBBMnhW?=
 =?utf-8?B?cUhEMm0yL0wzdE9EVHZsVVB6L1JQZGg1WGhKK0dMYmRhRUdaMWFuQnR3K09i?=
 =?utf-8?B?MWFaV0RLTVBXaGpOZGMwSi9RTWxPSmZRb0FBQ0VJdEl1ci9PWDJJZTFPSGti?=
 =?utf-8?B?WTBmWjN3K0diRlRMU3FoZ2RtdVk1VGxtZG91M1E2cTBzRDFrYXNiU2RSRlpU?=
 =?utf-8?B?dGdnN1VlUnJpWGRJMlR1Nk9hbUVKM2g2cks4aVY3NlZpWkplUVdWNFhZMVJv?=
 =?utf-8?B?S00xZ0c0S3I4MmtCSU0vL3VPY2pDM0NOVGFKU1JOY3o3dTdpaHpLem5GSFBu?=
 =?utf-8?B?THQrNTRiOFAvY2N3MUdEOW8renBXa3hSVGxVVnoxbHJkK3RCQjJMRWhYVVNn?=
 =?utf-8?B?dEJiaks2ejhqRXo3aEpTa1VhVUQwSU1XMDIvYVA2UGNIM2lrY05qMGtJWWVo?=
 =?utf-8?B?VHI5TFJMYzN2SUo0Q2x3N1lIUHJIVGxIUUZqc0NOT2lLSFYrMStKTlhYTllR?=
 =?utf-8?B?aTdLQWFVejhIemQ1YU5QaHR3UkFiWnM2WUMyYjhXRjM0V3JuR2FST3FERTAy?=
 =?utf-8?B?MkYxQjVOWk0yVGZJbENCVy9PQjNXM2Z2Q1hiTlpwSjgyMzAycVFkZUhuWTdX?=
 =?utf-8?B?WVNwZEFWdDZiMW5sYWtTeVc4ME01MjFvQlgwRnNHZUF2dTFzZzQzZk5wVWdm?=
 =?utf-8?B?VGkyMmI5WkE0Y1lHcFZ1Ulc0cy9MdURDWE9KdkNxbHZSaHRMeFQ3TFBTVVNR?=
 =?utf-8?B?YzJqSmtsSUNLdWYzZElaK2NxVGViZFNBYkIvcjdLTkw4Uy9YREVJdnVVVzJN?=
 =?utf-8?B?cEVYaHN5ekVUd2pDbHdlRURvbWJHVmpVUDB5UFRRM0UzN3IyaUVIZkE3UVh3?=
 =?utf-8?Q?aESQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea5154-c98b-4db6-037b-08dabd79aded
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 08:59:13.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqZ/MAFh1dhkzu56VhoQBo00RM0Gs2zw5bFIyp3mmkH+nWv+IRGU0MP2XZUzLPp8TXa4Z3btBUZCbjyfOZEl3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92
ZW1iZXIgMiwgMjAyMiA4OjUzIFBNDQo+IFRvOiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBw
ZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+OyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IG1pY2hhbHNAeGlsaW54LmNvbTsgcm9iaCtk
dEBrZXJuZWwub3JnOw0KPiBZZWxlc3dhcmFwdSwgTmFnYXJhZGhlc2ggPG5hZ2FyYWRoZXNoLnll
bGVzd2FyYXB1QGFtZC5jb20+Ow0KPiBHb2dhZGEsIEJoYXJhdCBLdW1hciA8YmhhcmF0Lmt1bWFy
LmdvZ2FkYUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gZHQtYmluZGlu
Z3M6IFBDSTogeGlsaW54LW53bDogQ29udmVydCB0byBZQU1MDQo+IHNjaGVtYXMgb2YgWGlsaW54
IE5XTCBQQ0llIFJvb3QgUG9ydCBCcmlkZ2UNCj4gDQo+IE9uIDAxLzExLzIwMjIgMDE6MjAsIFRo
aXBwZXN3YW15IEhhdmFsaWdlIHdyb3RlOg0KPiA+IENvbnZlcnQgdG8gWUFNTCBzY2hlbWFzIGZv
ciBYaWxpbnggTldMIFBDSWUgUm9vdCBQb3J0IEJyaWRnZSBkdA0KPiA+IGJpbmRpbmcuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGlwcGVzd2FteSBIYXZhbGlnZSA8dGhpcHBlc3dhbXkuaGF2
YWxpZ2VAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BjaS94aWxpbngtbnds
LXBjaWUudHh0ICAgICAgICAgIHwgIDczIC0tLS0tLS0tLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3Bj
aS94bG54LG53bC1wY2llLnlhbWwgICAgICAgICAgIHwgMTM3ICsrKysrKysrKysrKysrKysrKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzNyBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlvbnMoLSkg
IGRlbGV0ZSBtb2RlDQo+ID4gMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kveGlsaW54LW53bC1wY2llLnR4dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hsbngsbndsLXBjaWUueWFtbA0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kveGlsaW54LW53bC1wY2llLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS94aWxpbngtbndsLXBjaWUudHh0DQo+ID4gZGVsZXRlZCBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4gaW5kZXggZjU2ZjhjNThjNWQ5Li4wMDAwMDAwMDAwMDANCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC1ud2wtcGNpZS50eHQNCj4g
PiArKysgL2Rldi9udWxsDQo+ID4gQEAgLTEsNzMgKzAsMCBAQA0KPiA+IC0qIFhpbGlueCBOV0wg
UENJZSBSb290IFBvcnQgQnJpZGdlIERUIGRlc2NyaXB0aW9uDQo+ID4gLQ0KPiA+IC1SZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KPiA+IC0tIGNvbXBhdGlibGU6IFNob3VsZCBjb250YWluICJ4bG54LG53
bC1wY2llLTIuMTEiDQo+ID4gLS0gI2FkZHJlc3MtY2VsbHM6IEFkZHJlc3MgcmVwcmVzZW50YXRp
b24gZm9yIHJvb3QgcG9ydHMsIHNldCB0byA8Mz4NCj4gPiAtLSAjc2l6ZS1jZWxsczogU2l6ZSBy
ZXByZXNlbnRhdGlvbiBmb3Igcm9vdCBwb3J0cywgc2V0IHRvIDwyPg0KPiA+IC0tICNpbnRlcnJ1
cHQtY2VsbHM6IHNwZWNpZmllcyB0aGUgbnVtYmVyIG9mIGNlbGxzIG5lZWRlZCB0byBlbmNvZGUg
YW4NCj4gPiAtCWludGVycnVwdCBzb3VyY2UuIFRoZSB2YWx1ZSBtdXN0IGJlIDEuDQo+ID4gLS0g
cmVnOiBTaG91bGQgY29udGFpbiBCcmlkZ2UsIFBDSWUgQ29udHJvbGxlciByZWdpc3RlcnMgbG9j
YXRpb24sDQo+ID4gLQljb25maWd1cmF0aW9uIHNwYWNlLCBhbmQgbGVuZ3RoDQo+ID4gLS0gcmVn
LW5hbWVzOiBNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2luZyBlbnRyaWVzOg0KPiA+IC0JImJyZWci
OiBicmlkZ2UgcmVnaXN0ZXJzDQo+ID4gLQkicGNpcmVnIjogUENJZSBjb250cm9sbGVyIHJlZ2lz
dGVycw0KPiA+IC0JImNmZyI6IGNvbmZpZ3VyYXRpb24gc3BhY2UgcmVnaW9uDQo+ID4gLS0gZGV2
aWNlX3R5cGU6IG11c3QgYmUgInBjaSINCj4gPiAtLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFp
biBOV0wgUENJZSBpbnRlcnJ1cHQNCj4gPiAtLSBpbnRlcnJ1cHQtbmFtZXM6IE11c3QgaW5jbHVk
ZSB0aGUgZm9sbG93aW5nIGVudHJpZXM6DQo+ID4gLQkibXNpMSwgbXNpMCI6IGludGVycnVwdCBh
c3NlcnRlZCB3aGVuIGFuIE1TSSBpcyByZWNlaXZlZA0KPiA+IC0JImludHgiOiBpbnRlcnJ1cHQg
YXNzZXJ0ZWQgd2hlbiBhIGxlZ2FjeSBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQNCj4gPiAtCSJtaXNj
IjogaW50ZXJydXB0IGFzc2VydGVkIHdoZW4gbWlzY2VsbGFuZW91cyBpbnRlcnJ1cHQgaXMgcmVj
ZWl2ZWQNCj4gPiAtLSBpbnRlcnJ1cHQtbWFwLW1hc2sgYW5kIGludGVycnVwdC1tYXA6IHN0YW5k
YXJkIFBDSSBwcm9wZXJ0aWVzIHRvDQo+IGRlZmluZSB0aGUNCj4gPiAtCW1hcHBpbmcgb2YgdGhl
IFBDSSBpbnRlcmZhY2UgdG8gaW50ZXJydXB0IG51bWJlcnMuDQo+ID4gLS0gcmFuZ2VzOiByYW5n
ZXMgZm9yIHRoZSBQQ0kgbWVtb3J5IHJlZ2lvbnMgKEkvTyBzcGFjZSByZWdpb24gaXMgbm90DQo+
ID4gLQlzdXBwb3J0ZWQgYnkgaGFyZHdhcmUpDQo+ID4gLQlQbGVhc2UgcmVmZXIgdG8gdGhlIHN0
YW5kYXJkIFBDSSBidXMgYmluZGluZyBkb2N1bWVudCBmb3IgYSBtb3JlDQo+ID4gLQlkZXRhaWxl
ZCBleHBsYW5hdGlvbg0KPiA+IC0tIG1zaS1jb250cm9sbGVyOiBpbmRpY2F0ZXMgdGhhdCB0aGlz
IGlzIE1TSSBjb250cm9sbGVyIG5vZGUNCj4gPiAtLSBtc2ktcGFyZW50OiAgTVNJIHBhcmVudCBv
ZiB0aGUgcm9vdCBjb21wbGV4IGl0c2VsZg0KPiA+IC0tIGxlZ2FjeS1pbnRlcnJ1cHQtY29udHJv
bGxlcjogSW50ZXJydXB0IGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUgZm9yIExlZ2FjeQ0KPiA+IC0J
aW50ZXJydXB0cw0KPiA+IC0JLSBpbnRlcnJ1cHQtY29udHJvbGxlcjogaWRlbnRpZmllcyB0aGUg
bm9kZSBhcyBhbiBpbnRlcnJ1cHQgY29udHJvbGxlcg0KPiA+IC0JLSAjaW50ZXJydXB0LWNlbGxz
OiBzaG91bGQgYmUgc2V0IHRvIDENCj4gPiAtCS0gI2FkZHJlc3MtY2VsbHM6IHNwZWNpZmllcyB0
aGUgbnVtYmVyIG9mIGNlbGxzIG5lZWRlZCB0byBlbmNvZGUgYW4NCj4gPiAtCQlhZGRyZXNzLiBU
aGUgdmFsdWUgbXVzdCBiZSAwLg0KPiA+IC0NCj4gPiAtT3B0aW9uYWwgcHJvcGVydGllczoNCj4g
PiAtLSBkbWEtY29oZXJlbnQ6IHByZXNlbnQgaWYgRE1BIG9wZXJhdGlvbnMgYXJlIGNvaGVyZW50
DQo+ID4gLS0gY2xvY2tzOiBJbnB1dCBjbG9jayBzcGVjaWZpZXIuIFJlZmVyIHRvIGNvbW1vbiBj
bG9jayBiaW5kaW5ncw0KPiA+IC0NCj4gPiAtRXhhbXBsZToNCj4gPiAtKysrKysrKysNCj4gPiAt
DQo+ID4gLW53bF9wY2llOiBwY2llQGZkMGUwMDAwIHsNCj4gPiAtCSNhZGRyZXNzLWNlbGxzID0g
PDM+Ow0KPiA+IC0JI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gLQljb21wYXRpYmxlID0gInhsbngs
bndsLXBjaWUtMi4xMSI7DQo+ID4gLQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+IC0JbXNp
LWNvbnRyb2xsZXI7DQo+ID4gLQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+IC0JaW50ZXJydXB0
LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiAtCWludGVycnVwdHMgPSA8MCAxMTQgND4sIDwwIDExNSA0
PiwgPDAgMTE2IDQ+LCA8MCAxMTcgND4sIDwwIDExOCA0PjsNCj4gPiAtCWludGVycnVwdC1uYW1l
cyA9ICJtc2kwIiwgIm1zaTEiLCAiaW50eCIsICJkdW1teSIsICJtaXNjIjsNCj4gPiAtCWludGVy
cnVwdC1tYXAtbWFzayA9IDwweDAgMHgwIDB4MCAweDc+Ow0KPiA+IC0JaW50ZXJydXB0LW1hcCA9
IDwweDAgMHgwIDB4MCAweDEgJnBjaWVfaW50YyAweDE+LA0KPiA+IC0JCQk8MHgwIDB4MCAweDAg
MHgyICZwY2llX2ludGMgMHgyPiwNCj4gPiAtCQkJPDB4MCAweDAgMHgwIDB4MyAmcGNpZV9pbnRj
IDB4Mz4sDQo+ID4gLQkJCTwweDAgMHgwIDB4MCAweDQgJnBjaWVfaW50YyAweDQ+Ow0KPiA+IC0N
Cj4gPiAtCW1zaS1wYXJlbnQgPSA8Jm53bF9wY2llPjsNCj4gPiAtCXJlZyA9IDwweDAgMHhmZDBl
MDAwMCAweDAgMHgxMDAwPiwNCj4gPiAtCSAgICAgIDwweDAgMHhmZDQ4MDAwMCAweDAgMHgxMDAw
PiwNCj4gPiAtCSAgICAgIDwweDgwIDB4MDAwMDAwMDAgMHgwIDB4MTAwMDAwMD47DQo+ID4gLQly
ZWctbmFtZXMgPSAiYnJlZyIsICJwY2lyZWciLCAiY2ZnIjsNCj4gPiAtCXJhbmdlcyA9IDwweDAy
MDAwMDAwIDB4MDAwMDAwMDAgMHhlMDAwMDAwMCAweDAwMDAwMDAwDQo+IDB4ZTAwMDAwMDAgMHgw
MDAwMDAwMCAweDEwMDAwMDAwICAvKiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSAqLw0KPiA+IC0J
CSAgMHg0MzAwMDAwMCAweDAwMDAwMDA2IDB4MDAwMDAwMDAgMHgwMDAwMDAwNg0KPiAweDAwMDAw
MDAwIDB4MDAwMDAwMDIgMHgwMDAwMDAwMD47LyogcHJlZmV0Y2hhYmxlIG1lbW9yeSAqLw0KPiA+
IC0NCj4gPiAtCXBjaWVfaW50YzogbGVnYWN5LWludGVycnVwdC1jb250cm9sbGVyIHsNCj4gPiAt
CQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gPiAtCQkjYWRkcmVzcy1jZWxscyA9IDwwPjsNCj4g
PiAtCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+IC0JfTsNCj4gPiAtDQo+ID4gLX07DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGxu
eCxud2wtcGNpZS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL3hsbngsbndsLXBjaWUueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5mNjYzNGJlNjE4YTINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94bG54LG53bC1wY2llLnlh
bWwNCj4gPiBAQCAtMCwwICsxLDEzNyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+
ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3BjaS94bG54LG53bC1wY2llLnlh
bWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFhpbGlueCBOV0wgUENJZSBSb290IFBvcnQgQnJp
ZGdlDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFRoaXBwZXN3YW15IEhhdmFs
aWdlIDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiA+ICsNCj4gPiArYWxsT2Y6DQo+
ID4gKyAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvcGNpLWJ1cy55YW1sIw0KPiA+ICsgIC0gJHJlZjog
L3NjaGVtYXMvaW50ZXJydXB0LWNvbnRyb2xsZXIvbXNpLWNvbnRyb2xsZXIueWFtbCMNCj4gPiAr
DQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiB4
bG54LG53bC1wY2llLTIuMTENCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgaXRlbXM6DQo+
ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgYnJpZGdlIHJlZ2lzdGVycyBsb2NhdGlvbi4N
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBDb250cm9sbGVyIHJlZ2lzdGVycyBsb2Nh
dGlvbi4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBDb25maWd1cmF0aW9uIHNwYWNl
IHJlZ2lvbi4NCj4gPiArDQo+ID4gKyAgcmVnLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4g
KyAgICAgIC0gY29uc3Q6IGJyZWcNCj4gDQo+IGNvbnN0OiBicmlkZ2UNCj4gDQo+ID4gKyAgICAg
IC0gY29uc3Q6IHBjaXJlZw0KPiANCj4gY29uc3Q6IHBjaQ0KDQpUaGVzZSByZWctbmFtZXMgYXJl
IHVzZWQgaW4gZHJpdmVyIGFuZCBleGlzdGluZyBjdXN0b21lcnMgYXJlIHVzaW5nIHRoZXNlIHJl
Zy1uYW1lcy4gDQpQbGVhc2UgbGV0IG1lIGtub3cgd2h5IHJlZy1uYW1lcyBuZWVkIHRvIGJlIGNo
YW5nZWQgPw0KIA0KPiA+ICsgICAgICAtIGNvbnN0OiBjZmcNCj4gPiArDQo+ID4gKyAgaW50ZXJy
dXB0czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBtc2kwIGlu
dGVycnVwdCBhc3NlcnRlZCB3aGVuIGFuIE1TSSBpcyByZWNlaXZlZA0KPiA+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBtc2kxIGludGVycnVwdCBhc3NlcnRlZCB3aGVuIGFuIE1TSSBpcyByZWNlaXZl
ZA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBpbnRlcnJ1cHQgYXNzZXJ0ZWQgd2hlbiBhIGxl
Z2FjeSBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogdW51
c2VkIGludGVycnVwdChkdW1teSkNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogaW50ZXJydXB0
IGFzc2VydGVkIHdoZW4gbWlzY2VsbGFuZW91cyBpbnRlcnJ1cHQNCj4gPiArIGlzIHJlY2VpdmVk
DQo+ID4gKw0KPiA+ICsgIGludGVycnVwdC1uYW1lczoNCj4gPiArICAgIG1heEl0ZW1zOiA1DQo+
IA0KPiBJIGRpZG4ndCBub3RpY2UgbGFzdCB0aW1lIC0gd2hhdCBhcmUgdGhlIG5hbWVzPyBUaGV5
IG5lZWQgdG8gYmUgZGVmaW5lZC4NCj4gDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdC1tYXAtbWFz
azoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiAwDQo+ID4gKyAgICAgIC0g
Y29uc3Q6IDANCj4gPiArICAgICAgLSBjb25zdDogMA0KPiA+ICsgICAgICAtIGNvbnN0OiA3DQo+
ID4gKw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
