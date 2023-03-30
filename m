Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E176D0E19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC3Svj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjC3Sv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:51:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C5DBD1;
        Thu, 30 Mar 2023 11:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a30Vq1pgFQDoX+0lf4K3zJanhMIUBZc/8UuzhWslOJYRMXymrXt7oNZrLO2g71iFtTqtl3qxBE9HqK/DOrB2RXdPXF7WT2xOfxlkWnXFBp5/dXSC6BsmBzYNgdJ8XSaeuk7oFX3JtNHIPssoB8kMIsITtr15NcMzu1oKWxtRMAb+AYu18IY207dvseK0vcRGpYwdVIq+FywJj4WfYuI5NI5QRm/jbgPvPDqtIslSeNQdUehI3JCAqgdjZ/RwFFy40+Po7Bsbnf/Ac1dlghxflFVdf5xeuDk8NzVxx21B8O4MNcUESiyLrCv9uzTTqVxIrpaIZbYNon2H0E48wjx0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgFw9CEWKaPwHxRUuzJNBhBqt9lfvEWjJYZRbJgsEpQ=;
 b=hSjBkdo4odlAdTXqNh4XW3etk2YAf7zy3GRm2Gb8DGWdpTHLqkmXFc+P7vT10YudvAjEx8TZ7xHEhkM6z5dT/FH4ltDO89m/Qmtsr0Yk+ELPip5+SEW7u34EJFqoa3Ql7OS5eQ/6oqtLfdmhdL0Ef8oDr/x9VOyzviyGRcKN0xrVofjSkAeVozTDmEq7ioBWpN5OgAiUxDnoo+IUcLhg0QLmLQpe7G7ncacPV7wM/an6zPKpP6U1X2/+DPNB4sqYvx3zEXFxRcYKaCKFtK5YCIPdSqRnC8gCHgULeflevIO5AcsD9vjL8p5H9bxXJpCpJ5XPaiUIzycO59RatMvOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgFw9CEWKaPwHxRUuzJNBhBqt9lfvEWjJYZRbJgsEpQ=;
 b=N6cZaqbOGjA+XGLCAQ89yqWk85j4jPVcEtObSBtwJ8mFUi3qSfmQwCqr0ul/RnLkmL1OalJIVG1IRUeruZcQX0xzZ/4PEVuYkaiyM4BTf6lC371xFkCWII7tTWDbTgWRakNBL30zcUPwC5miTHGZs66BXQ6oh4nknZHbGxsHNZ0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 18:51:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 18:51:25 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Thread-Topic: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Thread-Index: AQHZYmZY/0yVqMaPn0qd2e94YHaeuK8TpLEAgAAEiICAAACD4A==
Date:   Thu, 30 Mar 2023 18:51:25 +0000
Message-ID: <MN0PR12MB6101543F3A6189A152B6D17AE28E9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230329174536.6931-1-mario.limonciello@amd.com>
 <CAJZ5v0i-ypLb9oPO8RqdQ6Vm3yD1ohP1sFei_BPNgiHZibdoQg@mail.gmail.com>
 <D72D9855-2264-466C-8705-B8E8BF398B10@alien8.de>
In-Reply-To: <D72D9855-2264-466C-8705-B8E8BF398B10@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-30T18:51:23Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=733d59cf-6654-43d0-b5a5-1ae570b954ac;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-30T18:51:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a93bd584-fe35-4289-9269-6cbead5f6bf2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS7PR12MB8082:EE_
x-ms-office365-filtering-correlation-id: 6e65b06e-5e5f-45df-fadc-08db314fc3b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQoPovmGCh3mcDKuCSAUI3i2RoAf16jshCUS9KE+5P8vfFrEYmq1xGykDg5gNhNU5URjYhZMMGO5VhLWXXvyZLc3nTzFcLu8Vr51tNxG5EaPps75Wx/33FuMIx102E/dcoEWfoTo5y4fdyeHXUESHinVoikFaRPkokj/MwBw88HTkca53+OGtYQ5GXgG0VNjG8c3Wf3XL3DSbu3j8FUBv4KNj1NABGjGlBkJ1cM1nchcou4ueHvUrLIu4c2njLPyW+nNF/VveJJ6uej2urW2pxqG9zB8wtrIUQvMN4myjjQKUFveVUMHeUEurvQtsgLegw+DudYCagMa+ASVTYq2vdsV0M0XA5/NWs9jE0iiXPYV+FU1XX7yNWjntreodn5kVw74B3aXaVRZb7oPV6tfl2irCvkYhVcW1IvOxZVMdUSVkwWYKy2eT7z2NFN1FFy0LJB6J0PgfzUC847nixK4z+J7pjHK9HkQ31Ex/Ov9RxiVqRyTVTVugBcmGbiruBMh1V0j/LXi0MJ5AQPs4BYtp7cJwAcbDHccnrXxunf3sdAXBwgusDaJzvj4m22d/nN9ozp2rhh2+ga0X8tCE2PjnhULxa4PeEIvKoZXdjID7sb8Xo6bXushfXNebCjgYxwo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(41300700001)(55016003)(52536014)(6506007)(8936002)(26005)(9686003)(7416002)(2906002)(5660300002)(186003)(110136005)(66556008)(66946007)(478600001)(66476007)(316002)(66446008)(64756008)(76116006)(8676002)(7696005)(38100700002)(71200400001)(122000001)(33656002)(86362001)(4326008)(54906003)(4744005)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1lQeVlLVjk3d053Z3hwbWE5a2p5OFRoWDF3VXFEUHZib2NjcE4rWG1SelRp?=
 =?utf-8?B?d1lqMVdjbDF1R0FwOXpZRyt4cHZSYUsrQ0JjTzlySmorbDJ5a1EwazljdDVq?=
 =?utf-8?B?QTFqeUkwekRTcVgzYW5Ca3ErVDQ4Qkc5d3lrRXdJNExSNlFDTEhVeWlTTE9Q?=
 =?utf-8?B?WFVQV1NMZVFtSCtTSzRYMEVkbzAzMkI0ZVpOOVVhWkc1L0E3YmFyU0NHLzQ0?=
 =?utf-8?B?QjJ2cHJxL2l6M2tlSitNaGZvWjhHd2hjQi9IRm85dlBFaUdYNmV5Y0hiWmpr?=
 =?utf-8?B?OFM4RkJyL1NYamdEUXRpODZHU0hCbnlROUhuMEtjMU8wUUVJa3lYYSt2RnJN?=
 =?utf-8?B?R3NKWExSUGpuNzBvMFo2V1U4dnUyL3FzamFKOXRQMlB2Znpnakw0djFlWG84?=
 =?utf-8?B?ak05T1FTYThQdGhoSXFGRGU0R0ZBK2tmb01XSUhMeEVUZlBiYWgwblFPU1RI?=
 =?utf-8?B?eFJYdWZaeE45QjBhODdnWHFmanIvZjZsdFZ4SEdoSFk1V29FRXlHQ0NYNkkw?=
 =?utf-8?B?TlpBa2tIT1daN24ydDc1TGE0NTl0dWdidHNyWVhMajhDZmVYeXgxR2pmditv?=
 =?utf-8?B?NHJ4TE9PU0FPaXdlclprNkFXeE1jUzIrVmVZbGpaVXpReGV5Z01DeTlRTTMr?=
 =?utf-8?B?aTdqcDhIb1M5WEFpTFRUdENwMFNLRVF3cS9jMFZOVXBqYmhscDJ6MEgyZW5L?=
 =?utf-8?B?QnFVbVpJM3duMHloTENzZ0VKMU5ZODFIZTFnK2JTMlA1dDYxTFdrdHRadGFx?=
 =?utf-8?B?aTgvN05UdWMzUUlxemVUYkFDcmlPYnhQVjJRRzVEcnR2VU1ySlBXbDN6Nzd1?=
 =?utf-8?B?NTJXU0pXbGdvc1gxaEFLRi9zOFlBS1p5MnlzdEJvYWJOMG9kaTJOUDlKVHRs?=
 =?utf-8?B?dU5Fek9kRnhjcGhxRi9WKzhpL29Vd0RscFc5MUREaTRTMlpMbExpeHQzd2Mx?=
 =?utf-8?B?OUl2Yi9zRzJpbTdjekhaSVpjZVl2WG1LeE5vQTNhUVF5QmxXWEpOMXVpMEpS?=
 =?utf-8?B?cVA1WnVOZmlaWmNka2ZWUFRpYWZtckozUlY0TDdBeUgxemtrNEV4T3dIb0dw?=
 =?utf-8?B?Y25yNmZxblBnSFpXVDZqZlk2aFF0RXZtMjI3VjVkTVVxUWdSZHZ6em4vRThU?=
 =?utf-8?B?Ui8rZFpwN01ka2VmN3k3NTBIcko5c1JTR0ZKWDM2UWVQb1dqMmRFMTE2NGNo?=
 =?utf-8?B?QiszNTFUd1dhTlYySExBNFptSmZISzFTT1dudmtpejNFQmh5QzE1SENML2tw?=
 =?utf-8?B?YkoxUjVpSk4wcENvbVJQazRsbktESFRCQXN3ZXNxbHZwdytrdnh4RHk2WXE2?=
 =?utf-8?B?em5HYWJnQzc5b2N0ZFI5T1ZKKzlrWkZHN1B4dGlEVjZFK2JXOU0zMTJsazNG?=
 =?utf-8?B?RWZTaWdHYzI3dXlRVklFdEgwYTdjL0t2aFR1aTJNRWludjZpQS8wa0plMWd5?=
 =?utf-8?B?QjAzYlU5NDhZQm5BdDIzT05pak95QXZ3dlZUUk9TZERIWHViSXJHRWVHb0tE?=
 =?utf-8?B?aEhjSzJvRlNqMEhGSjBQdHRFNG1wVjZPeVJnVTU2N0kzY0MyYzl4WVpUK0xh?=
 =?utf-8?B?SUVHRGVURmhZRTBHZERtZkZjczZoYnpMYlJiazFhQTU1STYrK2d4cFFUbmEw?=
 =?utf-8?B?c0ZlcHF1TWw3ZHhpK1gyeWNFL1dSK0lpZzdzSDZENThUanJqUDBtUkV4TXRP?=
 =?utf-8?B?TE40ek14QTN3c2ZudHVQMnRreTJUblNjZGtxdGIrL2pSelRLa1ZrRXhwQ1Fz?=
 =?utf-8?B?aENDb0hVSFdMRXl6M2RFSis0dG4wMnhvUmdZUHkzQzJiM3Z2c0hjNWIwUndq?=
 =?utf-8?B?S05IRjV2cW5JRzRORFY3eFQ3SlpqaXhTR3p5SVRDOUMxbHpkNmdhWEJ0Zi9P?=
 =?utf-8?B?cjVZYlRJUHJ0SHJCQ2VJTlpsWi9lb1IzLzNwYmxWMUJxRVo3T1IzdlRBQ3F2?=
 =?utf-8?B?N0s1UGI2SVRpc1IvRHU2TkM4MlFKMXY1TStCM2F2RVUvRWVTNVNvM3g1aWFB?=
 =?utf-8?B?alJaYmV6MkpwWFNhNmxqNGUveWtocVNrbXdZaGpsR2FiSTBxTkVvbUxKamJ4?=
 =?utf-8?B?NjFHZUNlUkNxSVU4RkRDNEYzVlN5SkpiTmI1UmUzUlZFd0pRUlROSTBQMW51?=
 =?utf-8?Q?QNo0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e65b06e-5e5f-45df-fadc-08db314fc3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 18:51:25.8442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Awa335UJkWIVHwv6alYHbkJPd7VUkLIGXWJzbdc7QDeoCRa1oKzcY5qMLFVh7/BMMC83TkXl3Gu+sHBYjj/wVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiBPbiBNYXJjaCAzMCwgMjAyMyA4OjIzOjM4IFBNIEdNVCswMjowMCwgIlJh
ZmFlbCBKLiBXeXNvY2tpIg0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+cy9QZXRr
b2IvUGV0a292LyBJIHN1cHBvc2U/DQo+IA0KPiBGaXhlZC4NCg0KVGh4Lg0KDQo+IA0KPiA+V291
bGQgaGF2ZSBiZWVuIG5pY2UgdG8gQ0MgdGhpcyB0byBsaW51eC1hY3BpIChkb25lIG5vdykuDQo+
IA0KPiBTb3JyeSBhYm91dCB0aGF0Lg0KDQpTb3JyeSwgSSB1c2VkIC4vc2NyaXB0cy9nZXRfbWFp
bnRhaW5lci5wbCAgYW5kIGl0IGRpZG4ndCBzdWdnZXN0IGxpbnV4LWFjcGkuDQoNCj4gDQo+ID5B
bnl3YXksIHg4NiBndXlzLCBhcmUgeW91IGdvaW5nIHRvIGhhbmRsZSB0aGlzIG9yIGRvIHlvdSB3
YW50IG1lIHRvIGRvDQo+IHRoYXQ/DQo+IA0KPiBZZWFoLCBhbGwgcXVldWVkIGludG8gdGlwOng4
Ni91cmdlbnQuICBIb2xsZXIgaWYgc29tZXRoaW5nJ3Mgc3RpbGwgbWlzc2luZy4gVGhlDQo+IHdo
b2xlIHNpdHVhdGlvbiBnb3Qgb24gbXkgbmVydmVzIHNvIEkgcXVldWVkIGJvdGggZml4ZXMgYW5k
IGFtIGhvcGluZyBhbGwgaXMNCj4gZml4ZWQgbm93LiBVZmZmLg0KPiANCj4gLS0NCj4gU2VudCBm
cm9tIGEgc21hbGwgZGV2aWNlOiBmb3JtYXR0aW5nIHN1Y2tzIGFuZCBicmV2aXR5IGlzIGluZXZp
dGFibGUuDQo=
