Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707266C0DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCTJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCTJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:54:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F25B84;
        Mon, 20 Mar 2023 02:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou5kMqyZubf9OwKc80iww2gDikOsz3BXlqPZB4bGEVHxpqo/fPy31aGG4WftR4V0n9sGbkGOmcGLN3MhrNSBc2jeTUXxBKsstKtE+7ZrM8wP0A/1/wHKKgaGg/Zo88WsBQfQtNzrLxhA9biDdno9INxmfMPHThEGO98L1eJDMLkEEThVJeHrb5MisTCcL99cPtgSO9GMgeh6lXB8Zz8Ioaxr2/gESyu2VzAqT2Js10qN9Z5Y3PviswEvA+LGZd/Van1MDxfgr8UfmIPMVkInHv6ZcUCYNNtizWYNXk206bDztB+ZaWxr5d3zgrnYJY6/+gSfg8HJtkiqQD4a2T8OTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6b+KMyEH+dUC4a2+IG0FGkSq/ZPlkCwdN925njludI=;
 b=eotpKGdX/xiNTFpwpVTPRKugCnfoabLqFD+MYN/zOSmK6jKZCXMO6EF40VsZmlXnbl7OZN8HcuQJ7VWkdSplowjhz/5bmlsBvxLHM8h5pNgRoL+IM18we2QJFSIIs99RIwZmDqUz9fsQ8LKJX/CoOqnpVjAacICR/D3qZ/C4w2DVxsjkG/okxfV6hf1nEpKnX8ZxgQpqBAQ5lvkNxLqzEuiw8kQ7A2yV7z17DyCXUZHrmtNNim7FSR+PYqHaUYrdR6CPDGKd/fFSLAUMrzBgptzN2WsHoagban2FY6KwOySJcJUsD2Ht6VOY4/P7Sp9bqlazLEV2vaKM26aJFsrcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6b+KMyEH+dUC4a2+IG0FGkSq/ZPlkCwdN925njludI=;
 b=cJuEHcC6XU1B/qfcVrGL6qz+lfxx3yrsNMyOg+NMufTXr5pzqcXqp7Pw75kAeV/SDlktiYbYljX0tcWqeGdnXiVHEH7V/oyaASIVoX5lHEua/yy5TCK5icshJKGhnmLg5eGgaaIXuzQAK6tMMF8wbcY6p8AH7YB8mMTGH6BA77fLpiGSOYJsJID3514+4j54vwWRnUksCxv3NtWJOLQsehg2BnIdhklvwh1KUFcSIfqY2cvlFvGN1YbdZjuBFHbgWhFrUO+1PYLgiMC8tCRLDkZTroIVWlgrqf+qVJAGysSj9pDi27Zl7H0DxwoI2pT+3V4gB9KXUSS6BSugA7WkpA==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 09:54:29 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::3949:5699:fc26:a8dd]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::3949:5699:fc26:a8dd%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 09:54:29 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Jui Chang Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH] usb: xhci: tegra: fix sleep in atomic call
Thread-Topic: [PATCH] usb: xhci: tegra: fix sleep in atomic call
Thread-Index: AQHZWv9PD/YqLuaTdEaz9MNUvrZZG68DULMAgAAdOQA=
Date:   Mon, 20 Mar 2023 09:54:28 +0000
Message-ID: <1ba86b0d74344459188a85c46bdcfbcb8cb3e8f2.camel@nvidia.com>
References: <20230320074028.186282-1-haotienh@nvidia.com>
         <ZBgU0GtLAVdaBQQ1@kroah.com>
In-Reply-To: <ZBgU0GtLAVdaBQQ1@kroah.com>
Reply-To: Haotien Hsu <haotienh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|PH7PR12MB6418:EE_
x-ms-office365-filtering-correlation-id: 571f4f57-a3b7-4554-ef51-08db292918c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPBT/5n9ar2x2/9tPh3DtASJwjtgF74IJodbyGH1ihOcG/YpH7/N0XiwMgku3qyEg0GBHUt6aaIb603pCSk7twGwLHD9UBAc4tMOJaUOZfTrkb2cYzkgxllPDoHKkDvZ8pC5162VN7V5tMaZoe1cuFvk/51Kn+NO1eWQFuOsp1TEqESZRQiZVXh50HYTmTbmzbDVq7ynMQgaQuPYbTfpRZhqSzsyed3XONImYBi9gjHqks7mFOOBP0qjV90lU2eIFTznsUqgtsJThHTsi2YnLWNlj12gTELTDk/1Kq2AbNsAWPYH6XXscWQSUbhz8zt3E9jUkyhlHVCMGdurIliHWwwnYcFYrOpnqGs6vUFfLBueYimSGN7hHaME48PHS71aNIWmfSXHeRRJIQPFr4rVqSIhEPb5M4esWFST2EKxDlV5nAQtmoCyB8A59ccShsqB7eVNGtAKAjgjISsQ53eb3EFAi4+t0LpNbre2xJgaqngrwNLi81LjJcaUwZpT9iqnO4TIlG5CZJaXkzjTQ7BvnSpmIwzqp9P9RGhsPQvAP+yyuAiIz4S1exV9OJAy2T+YYlgDcf/+ZEzcI9RP8qaKr1kT7nb1BLUvakkqLDrIaW0jL3q+Oxz1UJYG83aVh4UH5v12Ht1QN4u/zXMmU+IuNYETakek8U2k6IOb/ywMcYZdh3JKz/CC3DwzVTrOKH9D3iTj8jre7yZcaWSxBCgHPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(54906003)(83380400001)(2616005)(86362001)(38070700005)(3450700001)(38100700002)(36756003)(4326008)(122000001)(41300700001)(64756008)(8676002)(66556008)(66446008)(66476007)(91956017)(66946007)(2906002)(76116006)(6916009)(8936002)(107886003)(316002)(5660300002)(26005)(186003)(6512007)(6506007)(478600001)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHh2bjN2MndMZDFiYXhXenFaekY4Q2c5ck92NFo5TTZBRVlOUEdQNFhFS3hm?=
 =?utf-8?B?ZEpRbWNsckZZSTdaNDJGbTZlM1NUcng2Q3UyU0l2OHA0K0hvdmdtOTk4Qi9P?=
 =?utf-8?B?aExiNFBYbU05VEVac3pPYThwNC9qMDAzRTVTMVpHblAxRGRSazVpRmFVeDUx?=
 =?utf-8?B?REdOTElIWVBzOUZEa2VZSXZxeFNLWDN5aW5HL3ZsWnNXWk5JOFI2QlUwYXlz?=
 =?utf-8?B?WGN4cEZBTEFYTllqejVQUkJPSEpwZ0hKdDkrM3FkM2xUcEs5TjlxczVTekZx?=
 =?utf-8?B?bC9tVC81RE1qS0YyYWs4TGRuSnFZcThNa0ppZ0poUFlqSnpRdW5NRXRxYUxD?=
 =?utf-8?B?OWR0TkFwWU44dHIwUER3Uk5vTHZWNThnc25telY3MTRPN3hENUs1OU83eGRz?=
 =?utf-8?B?NjJNWlhEMlcrMGNBaXZOdzF4KzFNMXh5S2h3bWxoSmgrYlRUVks4VmREZ2pU?=
 =?utf-8?B?YTB1QnlUU1RpSnJWdTVqSkVRaVlmUUVMaFF3eTJQT3JtdnJ1VWtJTks0RmIz?=
 =?utf-8?B?c1BHSnBMYWIxUjNxSU1lRVRpdm1IYS9XUzljbE1qR1hYMVRreFIrTGNBc1V4?=
 =?utf-8?B?WHZpTjJyZWMxZXJxbGNnMXJRajdUTWxpcXNJelNpQjZlc09OQTVOYmtHeEI4?=
 =?utf-8?B?UzRkQ1lNdWkrZklva2JKR1A5ZTh6VFVReVZSQ3k2N20yNFhsOG9BUGgxckpJ?=
 =?utf-8?B?TkZlbmhCREN4TEhIaEFtZi85clM2Z1ZMZzBUZHlteWhTQXAxVCtMcE5BYVdB?=
 =?utf-8?B?RU5Wb1l0RFVGU1hMZkd2clpHMUM4ZXNKKzdwZWJaanJkQUVybGF0VE9RRm1k?=
 =?utf-8?B?aU93RXBlVm9YaHlucFYramZ1MGsrZTVIM3U3T0NCaUhtdUh5dFRHMXg5U29T?=
 =?utf-8?B?cno1MU1xUWJrVlJPcXRoTGNWZ1NWeUsxeGUrU1ZpZEg2OFZmYXRIdm5RaFdF?=
 =?utf-8?B?ZVdSOHo0OVNtVjhFZFF2aHlQUmZkdm9CU0h6OWoySHNtMjBRekNOT2JBSStu?=
 =?utf-8?B?dnQ0ZnRGc0haSzUxVG44Q1VBSXNXQ0ZveHRsWEsvZWZKWTBJdmxiTXd6Vmxu?=
 =?utf-8?B?bXQzSWRsZ2RSZVgrTHNjM0NnYTdqY0MxT0J4K2I1MUJsYkJ6Z2VnWkJYZVQ5?=
 =?utf-8?B?NHlzaC9ER3dNa3V1SkhrMjQ5eWcyL2JwSjREMHRNZ04xZUFKNWpWc2psWnBP?=
 =?utf-8?B?NjRlSEdZSlZ2R1FmalUyVmlOS3hjdmFIWkU0eU44bWFZNkowTDV5KzFybTd3?=
 =?utf-8?B?YmtaeXBTSnVXYXgvWnd6Qi9CV2YzZ3NaYUFvQkhuQ3loMjgzTkFuaHFEZUM5?=
 =?utf-8?B?Z2FQcHIwRGgrd2FBcUdGdER6VGp1b2U2RVJUK2xjc0hkQWpyVjNmTDZEd21a?=
 =?utf-8?B?MFozdExEaUJwbWpGSWZJaUE3UXI4WVN1ZTBsZ1A0RkZuaFN1VmJ5WlBRVUdO?=
 =?utf-8?B?a2doVGM5ZHZ0c3QrRmdHYVlHYnhlSkxiUU5GS3lyMEJtdVBtT1F6bWEyMzlC?=
 =?utf-8?B?MUJqa2JrN1lmN1g4eEpIc0Ztc2krSjljMW5WclEzSUtNSnpxSmZVYWw5MVQv?=
 =?utf-8?B?b2tocE0yNWJMZ090K2dqQlpocTlLWFNoNVBJdnh0Nm92Z0NtVnM0ZzVRcklR?=
 =?utf-8?B?aU9OdzJNZ1B1QjhGRmZXSlhNK3RlVmlTbHdrUS9IbXY4Z0xUSm9rR0FQSVdu?=
 =?utf-8?B?VDExaEtBSnNTK3hLWi9Rb2tPMUxUSGhzbk5YQmhpaFpUL25JUTBmbGVXZ3VJ?=
 =?utf-8?B?K1NRd1RzallWd2d2NSs5QUZKcm1tVXVPbFZMc014T1RxMHBWNTFnSmo3T2JG?=
 =?utf-8?B?YmFXNjhDNXNGTTk5NVNEYkx3VE1XN3piNm1OQW9UM3VVQnNocEZwTkMrQ3Az?=
 =?utf-8?B?TVRDVzFIeWhaV0hUdG5iZ2I1TE54bWRKSGRrSWR0dUxmbHFMYjVENncvRGdW?=
 =?utf-8?B?TUoxRVBtaUMwclFiZnhtSzdUcmdhTFFwV3hxQ0xadnBUU0FldGJHbXhtMm8x?=
 =?utf-8?B?SmdzN0lub0duMllIU3FUQmFGay9oSEFCSVd4aEFkVytuNCtEQTVYVy9pbmg2?=
 =?utf-8?B?UWJiT21aQVYyazRyTmFobjlmcWtzMXZCb05PdU9FTGNITXhVRkpIbjk5S1Q2?=
 =?utf-8?Q?ONNqWNcvLOIxLiASyKre+FQzv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D249E2C540AD4B42B7AF3689379FDCD4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f4f57-a3b7-4554-ef51-08db292918c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 09:54:28.9120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aM0Xs7rreUU8hlJB8/fxyOJnZvfVMipXMaREIvUKvTTwUAfz15vwMm7wryi07Wj4vOyzDnwVhc7ItJ4sLVRBdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTIwIGF0IDA5OjA5ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+IA0KPiANCj4gT24gTW9uLCBNYXIgMjAsIDIwMjMgYXQgMDM6NDA6MjhQTSArMDgw
MCwgSGFvdGllbiBIc3Ugd3JvdGU6DQo+ID4gRnJvbTogV2F5bmUgQ2hhbmcgPHdheW5lY0Budmlk
aWEuY29tPg0KPiA+IA0KPiA+IFdoZW4gd2Ugc2V0IHRoZSBPVEcgcG9ydCB0byBIb3N0IG1vZGUs
IHdlIG9ic2VydmVkIHRoZSBmb2xsb3dpbmcNCj4gPiBzcGxhdDoNCj4gPiBbICAxNjcuMDU3NzE4
XSBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQgY29udGV4dA0KPiA+
IGF0DQo+ID4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOjIyOQ0KPiA+IFsgIDE2Ny4wNTc4NzJd
IFdvcmtxdWV1ZTogZXZlbnRzIHRlZ3JhX3h1c2JfdXNiX3BoeV93b3JrDQo+ID4gWyAgMTY3LjA1
Nzk1NF0gQ2FsbCB0cmFjZToNCj4gPiBbICAxNjcuMDU3OTYyXSAgZHVtcF9iYWNrdHJhY2UrMHgw
LzB4MjEwDQo+ID4gWyAgMTY3LjA1Nzk5Nl0gIHNob3dfc3RhY2srMHgzMC8weDUwDQo+ID4gWyAg
MTY3LjA1ODAyMF0gIGR1bXBfc3RhY2tfbHZsKzB4NjQvMHg4NA0KPiA+IFsgIDE2Ny4wNTgwNjVd
ICBkdW1wX3N0YWNrKzB4MTQvMHgzNA0KPiA+IFsgIDE2Ny4wNTgxMDBdICBfX21pZ2h0X3Jlc2No
ZWQrMHgxNDQvMHgxODANCj4gPiBbICAxNjcuMDU4MTQwXSAgX19taWdodF9zbGVlcCsweDY0LzB4
ZDANCj4gPiBbICAxNjcuMDU4MTcxXSAgc2xhYl9wcmVfYWxsb2NfaG9vay5jb25zdHByb3AuMCsw
eGE4LzB4MTEwDQo+ID4gWyAgMTY3LjA1ODIwMl0gIF9fa21hbGxvY190cmFja19jYWxsZXIrMHg3
NC8weDJiMA0KPiA+IFsgIDE2Ny4wNTgyMzNdICBrdmFzcHJpbnRmKzB4YTQvMHgxOTANCj4gPiBb
ICAxNjcuMDU4MjYxXSAga2FzcHJpbnRmKzB4NTgvMHg5MA0KPiA+IFsgIDE2Ny4wNTgyODVdICB0
ZWdyYV94dXNiX2ZpbmRfcG9ydF9ub2RlLmlzcmEuMCsweDU4LzB4ZDANCj4gPiBbICAxNjcuMDU4
MzM0XSAgdGVncmFfeHVzYl9maW5kX3BvcnQrMHgzOC8weGEwDQo+ID4gWyAgMTY3LjA1ODM4MF0g
IHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBhbmlvbisweDM4LzB4ZDANCj4gPiBbICAx
NjcuMDU4NDMwXSAgdGVncmFfeGhjaV9pZF9ub3RpZnkrMHg4Yy8weDFlMA0KPiA+IFsgIDE2Ny4w
NTg0NzNdICBub3RpZmllcl9jYWxsX2NoYWluKzB4ODgvMHgxMDANCj4gPiBbICAxNjcuMDU4NTA2
XSAgYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4rMHg0NC8weDcwDQo+ID4gWyAgMTY3LjA1ODUz
N10gIHRlZ3JhX3h1c2JfdXNiX3BoeV93b3JrKzB4NjAvMHhkMA0KPiA+IFsgIDE2Ny4wNTg1ODFd
ICBwcm9jZXNzX29uZV93b3JrKzB4MWRjLzB4NGMwDQo+ID4gWyAgMTY3LjA1ODYxOF0gIHdvcmtl
cl90aHJlYWQrMHg1NC8weDQxMA0KPiA+IFsgIDE2Ny4wNTg2NTBdICBrdGhyZWFkKzB4MTg4LzB4
MWIwDQo+ID4gWyAgMTY3LjA1ODY3Ml0gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+ID4gDQo+
ID4gVGhlIGZ1bmN0aW9uIHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBhbmlvbiBldmVu
dHVhbGx5IGNhbGxzDQo+ID4gdGVncmFfeHVzYl9maW5kX3BvcnQgYW5kIHRoaXMgaW4gdHVybiBj
YWxscyBrYXNwcmludGYgd2hpY2ggbWlnaHQNCj4gPiBzbGVlcA0KPiA+IGFuZCBzbyBjYW5ub3Qg
YmUgY2FsbGVkIGZyb20gYW4gYXRvbWljIGNvbnRleHQuDQo+ID4gDQo+ID4gRml4IHRoaXMgYnkg
bW92aW5nIHRoZSBjYWxsIHRvIHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBhbmlvbg0K
PiA+IHRvDQo+ID4gdGhlIHRlZ3JhX3hoY2lfaWRfd29yayBmdW5jdGlvbiB3aGVyZSBpdCBpcyBy
ZWFsbHkgbmVlZGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdheW5lIENoYW5nIDx3YXlu
ZWNAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYW90aWVuIEhzdSA8aGFvdGllbmhA
bnZpZGlhLmNvbT4NCj4gDQo+IFdoYXQgY29tbWl0IGlkIGRvZXMgdGhpcyBmaXg/ICBBbmQgZG9l
cyBpdCBuZWVkIHRvIGJlIGJhY2twb3J0ZWQgdG8NCj4gb2xkZXIga2VybmVscz8NCj4gDQoNClNv
cnJ5IGZvciBtaXNzaW5nICJGaXhlczoiIGFuZCAiQ2M6IHN0YWJsZSIgbGluZXMuDQoNCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmMgfCA5ICsrKysrLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS0NCj4gPiB0ZWdyYS5jDQo+ID4gaW5kZXggMWZmMjJmNjc1OTMwLi5hZjAx
ODViYWNjNzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYw0KPiA+IEBAIC0yLDcgKzIs
NyBAQA0KPiA+ICAvKg0KPiA+ICAgKiBOVklESUEgVGVncmEgeEhDSSBob3N0IGNvbnRyb2xsZXIg
ZHJpdmVyDQo+ID4gICAqDQo+ID4gLSAqIENvcHlyaWdodCAoYykgMjAxNC0yMDIwLCBOVklESUEg
Q09SUE9SQVRJT04uIEFsbCByaWdodHMNCj4gPiByZXNlcnZlZC4NCj4gPiArICogQ29weXJpZ2h0
IChjKSAyMDE0LTIwMjMsIE5WSURJQSBDT1JQT1JBVElPTi4gQWxsIHJpZ2h0cw0KPiA+IHJlc2Vy
dmVkLg0KPiANCj4gUGxlYXNlIHN1Ym1pdCBjb3B5cmlnaHQgdXBkYXRlcyBzZXBhcmF0ZWx5LCBz
aG93aW5nIHRoYXQgdGhlcmUgcmVhbGx5DQo+IHdhcyBjb3B5cmlnaHQgdXBkYXRlcyBkdXJpbmcg
dGhvc2UgeWVhcnMgYXMgdGhhdCBpcyBpbmRlcGVuZGVudCBvZg0KPiB0aGlzDQo+IGZpeCBhbmQg
ZG9lcyBub3QgbmVlZCB0byBiZSBiYWNrcG9ydGVkIGFueXdoZXJlLg0KPiANCg0KVGhhbmtzIGZv
ciB0aGUgZGV0YWlsZWQgaW5mb3JtYXRpb24hDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgN
Cg==
