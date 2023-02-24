Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A006A1D99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBXOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBXOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:43:00 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C23AD0E;
        Fri, 24 Feb 2023 06:42:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsLH843prO2xYejehYMxF56yJqTJEKuzx+OHAdOfqbd3ibXQA2mL0853j448OVH4MO1sBmOVbirtI0BkPeqhwkNK3UhLXajyWplQvIYRVZVwaw6AIgwbCYMc8nUsiauVMK8ALhBkyG3rsWVGuVkdKB1WKV612jvq7uOQTglqli3qooipqZxETvudVdlM5R7xcvQZP+eRBmyh0muHnYuo1UOhtPw2NMIjxoLgm76839Ds05SEtMNWP5XaBgDSIMDvQPEIr/iIny9c/MWNSEy9G0UyZ0sy/DcL/uYKhsnpOpBjfR6i169vc85oyIQLRJL/4cjg9S9rHrklbhTlxY+4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TGQ1gNXJZHTcWAqkAfCakaXwrTyIX5rXwXUquMZ2iU=;
 b=TMh2s86kO1trk16E1UUk2VAvVuLaI4v5eoC6GPD3nKSnI/YYF02oqqHal5Ru6WFMqrVlGsCmYsnA4eCZ1V6Pk7TQq64zlAAjT13kctgeuqAikDWZiwNo7zkeSIgdTIMiH+1ySA4aXemXmnhjtPzYpVBDFdEPORN7/Kc71QjATQ9996EvDZELYOyDWzEXyssyaPT8lMyGyJvIIs9FOKqc3SNXQECTtgZCuZqyawbw0sg9elx4T2lLQ9W1RafzDH5bOSV2wotcvj34U/sIFjiswZImytraW8LFh44m9+ZCEVQeaij9CmreLvtlIhnVWVEw3C02e+WyPQeRo0ASXCDiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TGQ1gNXJZHTcWAqkAfCakaXwrTyIX5rXwXUquMZ2iU=;
 b=ucMmsEqknRyG4jfZ+YFEXweP3R9A2/cMpApNJPXYYoDUy1YibsdlqjH1aUkKPXMVmhrQb23CMyhr2+rHfHHVYNzB4uv9qWQfzKKl02D12m1/AUdC9Flz/e1zq6xcD5ioWyUlhVY/+PCiWzJNPY/kHjTaZsJqicIth2Kyu9ksVxUdg7WpfeFhSxyGJbMerUGbH8a7ZLafIOFCUkj8zB2CbinSvzkQOPRKH/FRFEk1F6XkxCncbnG2jlXNwqq4IZoYpglWN8MNuvH3x1mNM+YzHuO7AFYEMbaPKzj2DszMDyeXgXiXdEVEe0n6pR/L5syBcqd4kLjIm4ZftSXl7IiEdw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 14:42:56 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 14:42:56 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Topic: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Index: AQHZQxaSlkLDlqQj4USzupFOvdT5/67TwvwAgAeH+DCAARyQgIAAhNPAgAAP7gCAAC3a0IAAuciAgABPpIA=
Date:   Fri, 24 Feb 2023 14:42:56 +0000
Message-ID: <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
 <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com>
In-Reply-To: <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB8053:EE_
x-ms-office365-filtering-correlation-id: 22ca9da6-8fb3-492c-7b56-08db16756ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFdv1crX7y3y+jPakAOqIgbyXRinzziNYnk4aP8prDHEXg/DVxYq5Gku4Xk1ABD+vVD8UO82KOXGzW+q5fo84ztw422fH0gzYawVEE3j5mz/TfPNb+7JP7lW0KIrkgQgkz+DT+gtiEscJlUNDaHXDznNr91jD4vRHHa5fLkv0MPBX+olPEtZ3TKBtFVJhUhhkmWQCdxkb2ikmbReswi1r1J+aFf0+6dExIJrxI2WaPHSyPSCiRf3FY6ceCOCWjvNCHiN6QvvghEPjwRXxVkJ3GMSZTTvlNJFTVSm/6p51Esu3JkrjyJw3LkcB6VOLUUqzmbiO/AuP28I5NwM04lZ+ovETagGu3TENGKUJ4uv53XMLAqOipR3NUnZ/gStsf9fMWMy+fDbZM1J9QcwgiYr9T2RnpuBmYDYJ9EYsw8tklYPrpIZSnQO1ZtdFVlRHUtxU02G6Exvg4X8Y1lnZIf0JwDQhVl+rZi0WDrWrMcYuvAF5jUfdRZBZyFQCweHQzezCxUzPVAEtBYRGuv0A9nw5zxfXKBvGuvkkqQYwtjo0w4H1iey3f5As0+7rVgBYihsNavCH23+7toVL/9EdSASXStfFZ5IW3XE+CmR4Ku44renx9mvCkAQpVZoOEcHGV9pVZOhpJavpvqG+tjAluEGAgVqVAhYYZp0VmHr0rcfU+62LQ+5Tas30ckPObacawHHFyjbr9F62WgDChnKi5oQGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(2906002)(83380400001)(9686003)(38070700005)(26005)(186003)(122000001)(38100700002)(8676002)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(6916009)(316002)(4326008)(52536014)(5660300002)(8936002)(41300700001)(33656002)(6506007)(55016003)(478600001)(86362001)(54906003)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b01HZVlnYjJNYjFlendjUDBYdHJoNEtkVisxV3JtZFBQU1YwdWpLbElNaHZE?=
 =?utf-8?B?Z2p1Vy9GczdhNVh1MDRiNzFmZDJCNWhZT1g0dHhWbnRJZXUzTkxVbjJuK3Uy?=
 =?utf-8?B?L2FtdTlOWi9FTlNJWHU0Wi9jYnRTOEV1ajNsMnBZNnhzSjFKN1M0eGIxc3Iw?=
 =?utf-8?B?QkF6ZHRWVjFTWC9INmJlR00ydDlxeVBuUGdDc2hDaEtUNDYzZlc1RVVEMWdO?=
 =?utf-8?B?akVzTnRERVZ2RkpTZWs1L3dJWjV1ZUIwRVNSTWNRTnNhK0lQSko0VEFpZTRa?=
 =?utf-8?B?Rm1wK2Q2b2VYaGFGM3FEOE4zb1p6djVtZWcwUjFpZEFGQ0g0Z1N2TEM5dXpa?=
 =?utf-8?B?VmJQRU0xZHJzZ3NwWDhpYlY2MVY2SnFKdXZVZ2xEZW55Q1JiNndQTXZuYVFE?=
 =?utf-8?B?Q2MwLys5Z2k3MDM4WDJua0pDLzQ3NElaTFZKVFBJM2s4QkE1ck9yVmdjdGs4?=
 =?utf-8?B?RG0ydGoxVUIySWttWXVYVnN2ZDROemJ4amhROFdjb0pNSFZHWVlrUDVGbldi?=
 =?utf-8?B?dk1nL0l3YzdpNDB5aFdLWXp4bnlxcnBZQTNPSVRSOTlEYmREN1M2OFZlWnh0?=
 =?utf-8?B?emJaN2JVYnFWazJvZzRybXVjZ3RURDAxV21uWXFtcnJNVDVtKzdqeGRJWHVO?=
 =?utf-8?B?MVpBaStoRjBISHZ6WXJpTUFrWGlpdTNkRnNkSUVMZDFNK3QxZ05kajNMdXIv?=
 =?utf-8?B?U2VUM2krYmhWQ0N2VldWZWMvN29nbXUxTTN5a1l1dW9DL21hTUNpUGgzMUV1?=
 =?utf-8?B?QUdHY2dtaXhTWGFlYjkvKy9idDRoU0x4YnpPWlNRcGtwdytuL3hzUFIvUSsr?=
 =?utf-8?B?d1JjOEgyWEMxVlUrK3hvVGE3UWFDTk10ODN3WWxiemhTVFBscFBQN21RQTNX?=
 =?utf-8?B?eW5XOW9wWnlTaDBkWG1XSmJtVVVhbWczNlVpbm0yV3ltbmpYbjZXazJHT3J5?=
 =?utf-8?B?Q1VaQktWaEhZcXpYaWtESW5ocGVTVUI0azRyZ0E2ZEIreEZJampUMDJnYmJw?=
 =?utf-8?B?UE5jc1BuQ2llYXIyRFJaemJvVzBEZVJHbkxaNmJ1VVBVNTJteXl0V05YK2I5?=
 =?utf-8?B?b2tHZTM4dHRRSlNYdDhsSmRxR0wvajBzdzIxd1VnR1drM3J4SnFKaXUxMXhG?=
 =?utf-8?B?aEZBZnFVc1lLLzNiVnpTUjJqWW5PbGRrOEJTMXRWUHJaYkdFRmJGR1d0VDFD?=
 =?utf-8?B?RFFXd2d5WTZaL2hZcHlUNEJENnVxa3dueWtnVWdEQWZ3R0lOYU9PTjJoUm1F?=
 =?utf-8?B?OWcvZGgxRzIzRnBmODNSSkVZVFQ0Ump5L2ozeXJlaTVwbTNRNzZnTDN6NnZr?=
 =?utf-8?B?UWRuYU1RRXo1SCtOdG4yaWJWNFgwajRlQnNhWWhBcGliOU1MMXRxVDBOUG5v?=
 =?utf-8?B?WVVKQUZYbXQ2U0J4MndMVWdlNXFGTlFpNEpKYTlRTGJjTDQyYmtCVkFwRXVh?=
 =?utf-8?B?YXBEbUs1WFJmaFpSK3pTeUk0ZTRPaE9HZC9OUUdZMmRVbmp3eHhOTE9PcEtU?=
 =?utf-8?B?a0pYLytSSnJlOGJqSzBwWE5IQW1UZnI3Vkdsb3BndnRGQWZqSzd0T2hyckIw?=
 =?utf-8?B?eWE2T1FQWTlZN09ITFdYamJSYlBjOThMRzkyU0hEeUR2aktzOFRTekQ5Rk5m?=
 =?utf-8?B?dU1MSmMya1RzRlBhdXU3Y0kwYUd0b24wYzZCYjBRSWRheHFNUTZNam1wbUho?=
 =?utf-8?B?K3FoZG1zbnlYOUt2dWJ1dkFpamw2WjI5dVFJRW9RVS9zdGhBbndaYWdDbk9w?=
 =?utf-8?B?a3o3TU5VMmZXZDZYYjNPQ2FEV2FIbno1SkVRT3VHZnBrY2hjZW4yOEswallY?=
 =?utf-8?B?dk9pWEFMcTNlaGRYckpCZWs5R0srSE9GeVFRcXcxeEc5Q1ZPbitoUExaLzhC?=
 =?utf-8?B?UlBQdS9rOVpJakUwWDUrc1JaMFoybE5McFVyWk0zZVJOay8yb1F3cnhjMXZQ?=
 =?utf-8?B?YWQ2K3V4dyt4U3BxUWI3N3NUdzFIemJNWjRpbnEzKzBHVXBnRHdZWk1LeVc1?=
 =?utf-8?B?Q3JYRk8wcXpXN2l2SmVLZ0crSGY3cG1uQjRidTYxejRqMEZrTFpaMDBwU1VX?=
 =?utf-8?B?WDVPSUlnN3RuY3F4MTBudnVCOUlTTjUxYjIxODNtWndoNlRvVlRrSFQycHdi?=
 =?utf-8?Q?RCNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ca9da6-8fb3-492c-7b56-08db16756ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 14:42:56.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FggUGL5413Hbn79aEYaB2up/1p+iwhNVmVSlW+d+8HMu4Yqeyn0VY4SNBNXWulnjMu8Y9iNV71Rzbls5NCbqQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiA+ID4gQWggdGhhdOKAmXMgbXkgYmFkLiBUaGUgcHJvcGVydHkgc2hvdWxkIGJlIGNh
bGxlZCAibmdwaW9zIiBsaWtlDQo+ID4gPiA+ID4gPiBpbiB0aGUgRFQNCj4gPiA+ID4gPiBkb2N1
bWVudGF0aW9uLiBXaWxsIGZpeC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFuZCB3aHkgZG8geW91
IG5lZWQgaXQ/IFdoYXQncyBhIGNvcm5lciBjYXNlIHRoYXQgdGhlIEdQSU8NCj4gPiA+ID4gPiBs
aWJyYXJ5IGRvZXNuJ3QgaGFuZGxlIHlldD8NCj4gPiA+ID4NCj4gPiA+ID4gV2UgaGF2ZSAyIGdw
aW9jaGlwcywgZ3Bpb2NoaXAgMCBzdXBwb3J0cyAzMiBncGlvIHBpbnMgYW5kIGdwaW9jaGlwDQo+
ID4gPiA+IDENCj4gPiA+IHN1cHBvcnRzIG9ubHkgMjQgcGlucy4NCj4gPiA+ID4gSWYgSSByZW1v
dmUgdGhlIGxvZ2ljIGZyb20gZ3Bpby1tbHhiZjMuYywgdGhlIGdwaW9saWIuYyBsb2dpYyB3aWxs
DQo+ID4gPiA+IGNvcnJlY3RseSBzZXQNCj4gPiA+IHRoZSBuZ3Bpb3MgPSAzMiBmb3IgZ3Bpb2No
aXAgMCBidXQgd2lsbCB3cm9uZ2x5IHNldCBuZ3Bpb3M9MzIgZm9yIGdwaW9nY2hpcA0KPiAxOg0K
PiA+ID4NCj4gPiA+IFNvLCBlaXRoZXIgeW91IG5lZWQgdG8gaGF2ZSB0d28gZW50cmllcyBpbiBE
VCBwZXIgY2hpcCBvciBuZ3Bpb3Mgc2hvdWxkIGJlDQo+IDU2Lg0KPiA+ID4NCj4gPiBJIGFscmVh
ZHkgaGF2ZSAyIGVudHJpZXMgaW4gbXkgQUNQSSB0YWJsZSwgaW4gdGhlIGZpcnN0IGVudHJ5LCBu
Z3Bpb3MgPSAzMiBhbmQNCj4gaW4gdGhlIHNlY29uZCBlbnRyeSBuZ3Bpb3MgPSAyNC4NCj4gDQo+
IENhbiB5b3Ugc2hvdyB0aGUgRFNEVCBleGNlcnB0IG9mIHRoaXMgZGV2aWNlPyAoQWxzbyBpbmNs
dWRpbmcgdGhlIHBpZWNlcyBmb3INCj4gcGluIGNvbnRyb2wpDQoNCk91ciBBQ1BJIHRhYmxlcyBh
cmUgaW50ZXJuYWw6DQoNCkRldmljZShHUEkwKSB7DQogICAgICAgIE5hbWUoX0hJRCwgIk1MTlhC
RjMzIikNCiAgICAgICAgTmFtZShfVUlELCBaZXJvKQ0KICAgICAgICBOYW1lKF9DQ0EsIDEpDQog
ICAgICAgIE5hbWUoX0NSUywgUmVzb3VyY2VUZW1wbGF0ZSgpIHsNCiAgICAgICAgICAvLyBmb3Ig
ZndfZ3Bpb1swXSB5dSBibG9jaw0KICAgICAgICAgTWVtb3J5MzJGaXhlZChSZWFkV3JpdGUsIDB4
MTM0MDExMDAsIDB4MDAwMDAwODApDQogICAgICAgICAvLyBmb3IgeXVfZ3Bpb19jYXVzZXJlZzAg
YmxvY2sNCiAgICAgICAgIE1lbW9yeTMyRml4ZWQoUmVhZFdyaXRlLCAweDEzNDAxYzAwLCAweDAw
MDAwMDIwKQ0KICAgICAgICAgSW50ZXJydXB0KFJlc291cmNlQ29uc3VtZXIsIEVkZ2UsIEFjdGl2
ZUhpZ2gsIFNoYXJlZCkNCiAgICAgICAgICAgeyBCRl9SU0gwX1lVIH0NCiAgICAgICB9KQ0KICAg
ICAgIE5hbWUoX0RTRCwgUGFja2FnZSgpIHsNCiAgICAgICAgIFRvVVVJRCgiZGFmZmQ4MTQtNmVi
YS00ZDhjLThhOTEtYmM5YmJmNGFhMzAxIiksDQogICAgICAgICBQYWNrYWdlKCkgew0KICAgICAg
ICAgICBQYWNrYWdlICgpIHsgIm5ncGlvcyIsIDMyIH0sIC8vIE51bWJlciBvZiBHUElPIHBpbnMg
b24gZ3BpbyBibG9jayAwDQogICAgICAgICAgIFBhY2thZ2UgKCkgeyAiZ3Bpby1yZXNlcnZlZC1y
YW5nZXMiLCBQYWNrYWdlICgpIHs1LCAxLCA3LCAzLCAxMSwgMzF9fSwNCiAgICAgICAgIH0NCiAg
ICAgICB9KQ0KICAgICB9DQogRGV2aWNlKEdQSTEpIHsNCiAgICAgICBOYW1lKF9ISUQsICJNTE5Y
QkYzMyIpDQogICAgICAgTmFtZShfVUlELCAxKQ0KICAgICAgIE5hbWUoX0NDQSwgMSkNCiAgICAg
ICBOYW1lKF9DUlMsIFJlc291cmNlVGVtcGxhdGUoKSB7DQogICAgICAgICAvLyBmb3IgZndfZ3Bp
b1sxXSB5dSBibG9jaw0KICAgICAgICAgTWVtb3J5MzJGaXhlZChSZWFkV3JpdGUsIDB4MTM0MDEx
ODAsIDB4MDAwMDAwODApDQogICAgICAgICAvLyBmb3IgeXVfZ3Bpb19jYXVzZXJlZzEgYmxvY2sN
CiAgICAgICAgIE1lbW9yeTMyRml4ZWQoUmVhZFdyaXRlLCAweDEzNDAxYzIwLCAweDAwMDAwMDIw
KQ0KICAgICAgIH0pDQogICAgICAgTmFtZShfRFNELCBQYWNrYWdlKCkgew0KICAgICAgICAgVG9V
VUlEKCJkYWZmZDgxNC02ZWJhLTRkOGMtOGE5MS1iYzliYmY0YWEzMDEiKSwNCiAgICAgICAgIFBh
Y2thZ2UoKSB7DQogICAgICAgICAgIFBhY2thZ2UgKCkgeyAibmdwaW9zIiwgMjQgfSwgLy8gTnVt
YmVyIG9mIEdQSU8gcGlucyBvbiBncGlvIGJsb2NrIDENCiAgICAgICAgICAgUGFja2FnZSAoKSB7
ICJncGlvLXJlc2VydmVkLXJhbmdlcyIsIFBhY2thZ2UgKCkgezAsIDIxfX0sDQogICAgICAgICB9
DQogICAgICAgfSkNCiAgfQ0KDQogICAgRGV2aWNlKFBJTjApIHsNCiAgICAgIE5hbWUoX0hJRCwg
Ik1MTlhCRjM0IikNCiAgICAgIE5hbWUoX1VJRCwgWmVybykNCiAgICAgIE5hbWUoX0NDQSwgMSkN
CiAgICAgIE5hbWUoX0NSUywgUmVzb3VyY2VUZW1wbGF0ZSgpIHsNCiAgICAgICAgLy8gZm9yIGZ3
X2dwaW9bMF0gYW5kIGZ3X2dwaW9bMV0geXUgYmxvY2tzDQogICAgICAgIE1lbW9yeTMyRml4ZWQo
UmVhZFdyaXRlLCAweDEzNDAxMTAwLCAweDAwMDAwMTAwKQ0KICAgICAgfSkNCiAgICAgfQ0KDQo+
IA0KPiA+IEdwaW9jaGlwX2FkZF9kYXRhX3dpdGhfa2V5cyBvbmx5IHJlYWRzIHRoZSBuZ3Bpb3Mg
cHJvcGVydHkgaWYgKG5ncGlvcw0KPiA+ID09IDApIHdoaWNoIGlzIG5vdCB0aGUgY2FzZSB3aGVu
IGJncGlvX2luaXQgaXMgY2FsbGVkLiBiZ3Bpb19pbml0IHVzZXMgInN6Ig0KPiBhcmd1bWVudCB0
byBwb3B1bGF0ZSB0aGUgbmdwaW8gaW4gYmdwaW9faW5pdCwgd2hpY2ggaXMgbm90IHdoYXQgd2Ug
d2FudC4NCj4gDQo+IE1heWJlIGJncGlvX2luaXQoKSBpcyBub3QgYSBnb29kIEFQSSBmb3IgeW91
ciBjYXNlPw0KDQoNCkF0IHRoZSBtb21lbnQsIGJncGlvX2luaXQgaGFuZGxlcyBhbGwgdGhlIGRp
cmVjdGlvbiBpbi9vdXQgZ2V0L3NldCBncGlvIHZhbHVlIGZvciB1cy4NClNvIEkgY2FuIGVpdGhl
ciByZW1vdmUgYmdwaW9faW5pdCBzbyB0aGF0IHdlIGdldCB0aGUgY29ycmVjdCBuZ3Bpb3MgcHJv
cGVydHksIGJ1dCB3aWxsIGhhdmUgdG8gZGVmaW5lIGdldF9ncGlvLCBzZXRfZ3BpbywgZGlyIGlu
IGFuZCBkaXIgb3V0Lg0KT3IgSSBjYW4ga2VlcCBiZ3Bpb19pbml0IGFuZCBkZXZpY2VfcHJvcGVy
dHlfcmVhZF91MzIgaW4gdGhlIGdwaW8tbWx4YmYzLmMgZHJpdmVyLg0KUGxlYXNlIGxldCBtZSBr
bm93IHdoaWNoIGFwcHJvYWNoIHlvdSBwcmVmZXIuDQo=
