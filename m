Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4486974D8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjGJORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjGJORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:17:41 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD23184
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUm1Ornf8JQ8KvvWRvTHyDPdA3by7dipmbV7V5X8Cp+Ore5uoa9ku9WMmn0sl5GR+OgPyTwJNH8ck5tPJkdkLu2A3F8XlSCgkGZMnoTvkAuE62SXzl670Y8fvDiL0POdcvFYh/1qZl77n4vp5j0CpMZQISfqTntAc/nAqQY7Am67gz2oWfa+kKwUZHg8Qn3gf93AS7VDe2MnrW5QFgOx/WeN/HOrq0WK1Bx1+yzrc78q5GXPmdMsZUt96e72vzuIaX1qFBQnVUqsm7ed/b9y5GbqBQnZLfrvG5o0aiJw5M56yqBo9L+ahaDg4LJxdULUQk/ORthloWkaTTu1nI1ELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I2pK9ONQtcy5PQ4L34avqLKuq8cVhLXoY/gxeMlNxo=;
 b=TkthU4+rKt53b+mZcKKBncbKnoP601gkAzZWTsUm+PkBLL/amzY7hFT2ryETkxvnP+KKKIBBi6JbCXQOtm5j6omXdhoCMryjSAbIUhyJe9o92WL6fOKwu5CI/gR/06aCPic5P7g6H751/7aGu0IrFpuT/JpdCLOPKeDKPGbyfm3HaWzImI4aisjzm2hfFls/zRlllrzy2l0mhaGxx2mvxIt/CbfWoPCIlpxcAdFRl08CqM/mZRzl3p5+567xAWG5A0Bysxx+4ADSgevMkqGBdIlYcKzknjBP0SS9G9kwCZ4ph6XPwyktJu7OfcylKV5DIWVjPFxL9PJSFr6rM9RMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I2pK9ONQtcy5PQ4L34avqLKuq8cVhLXoY/gxeMlNxo=;
 b=W4zouejMeObRvSWugW2lajrIA4YzaE2kHyT4tve6T+EdIIQdKH9dyc2wZJ+0XpquEy4VcmWOPbNLhniAE8LKbAbS7X8cwTK1XnPgslvj8t8JgICI6m0qnUtRxnnYnS9FvJ9pN/saXPtvpYQ9S6jZhSIQ0JytTng3onoFEzpLqxQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS0PR21MB3929.namprd21.prod.outlook.com (2603:10b6:8:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.1; Mon, 10 Jul
 2023 14:17:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6609.003; Mon, 10 Jul 2023
 14:17:28 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Topic: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Index: AQHZmF1U2k/rcGuWwEuDTjMXS84AEa+qcB1ggAQXoICAAi1GAIAAcfsAgAIVpgCAAARt0A==
Date:   Mon, 10 Jul 2023 14:17:28 +0000
Message-ID: <BYAPR21MB1688F7C6076B3B7233E2BEE3D730A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
 <fa869adb-a873-5f40-d843-73cc7e3a58cf@amd.com>
In-Reply-To: <fa869adb-a873-5f40-d843-73cc7e3a58cf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb55b325-6b51-47c6-adda-050a4f834e77;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-10T14:14:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS0PR21MB3929:EE_
x-ms-office365-filtering-correlation-id: bb0cba12-0b30-43ab-5f5c-08db815064a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgSJrtEymF1MD/Hzy+KYXrgYwg8s+3bAa1cvVvj0MBkSdflfbbjCo83ESpFHf3JHR1GFPsy/cf5xX26Y6RKP+7PjxTFkX7PfDY4SOpp/vTwujYtKWr8CcCrsWuw6zHsDYhtO0rUdyfrOHC1UDlfN1LG5gCIhBegcfIUCwcwpaeBhJNefLB7UxR0IROWlS8LAkfQ1YiUzGwl5eMm4YHb+f9vRTLsxgw1/SZFWHnbEonbanqlhlmYXjIcvY9lYseQZUQx+2/WH8tfckCuABLNnKYMlroZVa1ckyMpB0dnjO7ZeJ1xKSDnXI8eeyYtNe/JL2+weongLjig3kd9J3+lTcbc7nc4EcvmGF9XbvRlvCQiAvOb3lqKltzsp2ruAM0cXV3oPIxvePYguJsVLliGHNkuK54r5UVRvEzpa+MDWtZeITPdFpRpsxbSg0NrATpoyjC5hZi3IV2J6vMMd0IWju8v64xCsj+eZcV1jFJksoXoGZPuv82XNsSfNJqKwYssc3lcNXVkckJTQaH+ilpwjmSu6lDmva3zuXQnoAf0oGQgSxP91lp1ZMg7pqkQ2uwkWj7DQq0AMD+TqkTqEIqgGCtNKjZRg+FxUnqPOUOb8tYbXxqeKBlZhO6ZYCoV+rO7L4EU87b4wwCf4jVYveSh7fqRKdrf7o7U0wiUkXSA2c0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(55016003)(26005)(76116006)(122000001)(8936002)(7696005)(71200400001)(110136005)(82960400001)(54906003)(8676002)(5660300002)(52536014)(66556008)(316002)(38100700002)(41300700001)(4326008)(478600001)(82950400001)(10290500003)(66446008)(66946007)(186003)(66476007)(64756008)(83380400001)(53546011)(9686003)(6506007)(86362001)(8990500004)(33656002)(38070700005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVh2Y2FtZ3ExZ2N1VklxYVVkYmtuYnBtY0VLcG01N1o3TU9jTzJvMTFqcHdO?=
 =?utf-8?B?aTlnMTBEMjJzVHFYbEcxZFYxcFFHSmpsdUhLcGpzMFBkanl3L09aVlhpWHB1?=
 =?utf-8?B?eklPVTFVVzVObFU0SDBKNncwc3NPb0cyTGVNOTV1MHNVRXkrUVJ3T3krSzhp?=
 =?utf-8?B?YWFKS1V3aEU2eWZibFVkSkk1TXAvUkRFTTZSWWNYRG5lWXA0QWRPb0lCdVQy?=
 =?utf-8?B?RU53NkE3MzZVZkhDZTRhd3Y1U09QMTFUV1ZFM1BBRm5GSTMrYm9samw4QkQ0?=
 =?utf-8?B?RTBiM0diTzZManVhNEFKbDRpVG4yYnNGd0QrczB5anJFbkFxZERtV0xBRzJN?=
 =?utf-8?B?a1hqYlA5UkJTaUNiSlVxTEdYMFE3SG5scmN6ZVNQd3ZtbStxWTdWV283eDM3?=
 =?utf-8?B?bU9yWTBhU3BBZWhnN1FEZTZaR29UU1lwQ3prVTBxZTA5djNFK3dMb0VZMDU0?=
 =?utf-8?B?OWtRSTBDNFNKRXZzMURlTXU1WVl6MmlpRHNMNCtRRnB6NytsWG8xNGk5d0dm?=
 =?utf-8?B?d1ZkVzZZaFBOc2ZLUUNaNnhHaGhwM2hIK1RJZmQrQmZaelRaa0w2T25RaEZG?=
 =?utf-8?B?VlQ1TVFCcE9oRXdlZkdNa09qd2Y1b0IzYWxaSWxrOXgyYnJxZVozUTNkS0Y2?=
 =?utf-8?B?NVljMFc2MDVUbk5BOW40M3ZIbWFrdFBhVWlyV0o0Y0dORTdzNFNLNkMyS2tr?=
 =?utf-8?B?UzVab1BGTC9iUk9KUlpJNk5aU0FZYnFHTVVHMW1xbnVOSmZlV1JiKzY1VHRI?=
 =?utf-8?B?NHI3b0xJd1hqOXF4dUR4a0VKMnRaa0pjYkZNR0dTV2JvanhZd0NJbk50ejdH?=
 =?utf-8?B?ZytXYTJibnNZTzlTWFE0OEY3V3dhL1BucDI1alg2b3BmTWVQY3p4dG40NWRY?=
 =?utf-8?B?WGR1U25jbVJsNFdZYkJXZnJQTEVZVktNSFlERENrYTZOS2RwbC9GV01vVnR3?=
 =?utf-8?B?TUhmZ2lLOVd4L1drcDlSNko1UzBCVm45ejV6cXpsWjZ6M2Y5ZTYzeUk0c09E?=
 =?utf-8?B?YU41UjBSR0ttR3JsZjVYVGVuWU0zZnIxbFpDbDFjLzh3d3QvR3BLR1hPbnEw?=
 =?utf-8?B?MXRvNi9iSGdKbFE1K24vTnJXV2NkSm1FakhUOUV1OE5rNlloRXZPYlJkL0lW?=
 =?utf-8?B?aVFBMTA4UUVMazYycDNNbkRDZXVkUkRXUTU3MjFYbFZiT0Z4L01jejdCTXVY?=
 =?utf-8?B?Z0c2cHZ0dUY2VkcxYjU0TGlQTkFFMGlBYTBwMUtvTW9ZSzN1RzR3L0JZNkxF?=
 =?utf-8?B?Uk9KTXE4NStDVlBwbWhYUWNvbU9QYkJaQ1pjTHkxS2JxbjZtM2ZyMFk4TzBB?=
 =?utf-8?B?bkI4TVNVTHJoTXYvcG94QyswREpGOW1idHdOZktnNzV2LzgvUzE2OG12L2oz?=
 =?utf-8?B?THZwcFlxd29uMzVSeEJ5aVdoeFVLYkl1a3hCUXlQaXhucEJNUXdVdGZzdXVT?=
 =?utf-8?B?SFRlS0MrbWtyMXd4bTQ2d0lnQkMyYVM1UHpjck1FSUUvbFRsQTcyNTB3RC9Q?=
 =?utf-8?B?aVNqdStJa2ZvdjR4L1FkeENEYWtSZ1NmYkYvcmw3M05URUNObkFYNW00RnQ0?=
 =?utf-8?B?VER1a2Fkay8wZnJhRlF0R1FmWm1YMjY4eUt6SldrRnRyYUZ3eGFqcWs5Tjg3?=
 =?utf-8?B?RHE3Vk9aRnErcjR4QzIwVXRVaThFWTZYTDFvbzh6TnFZZmlEQkc4dG8xQTc5?=
 =?utf-8?B?LzJoVWVNYUduc3g0OHBMa0g2RXEzTjdOL3l0RlNKNllGUHN3Rm9SRWZiWXN5?=
 =?utf-8?B?NTVEUm96OEgyUm9GTkNxZ1FqQjNOMlE2S2MzZWw4MXBCcnhtekVxWWRjeU1s?=
 =?utf-8?B?YXBTM3NDVkx1QXMrcmJvdysrU01xRWkveHU4YmEyV2htYVBsQmlXeWhXTlpZ?=
 =?utf-8?B?eTdOUnY2eFZlaXNoSmh5K3NCT0J5c0UzNUJ0WFdKVCtCTytNZnlTVzVjNTR4?=
 =?utf-8?B?cFNndlRhWXZJMXNEVUlldDc3UXR5d2hONGdvcWNBWnVwYkVNZkdIYXFuNHRK?=
 =?utf-8?B?WUkvakw4TTdZMlJSUThZdXl3SWJvVU1POVBOSFR2VGJGcTBiemEyd0lsY2o3?=
 =?utf-8?B?ZXhRVXhTMmxUUjFkbHM1eTQwSUZTNU9SZXBmdlQxOWZlS2VTZGhhT2ZqbVhC?=
 =?utf-8?B?QWd1T1ZDcWo5TUlOcHQyR0FPd1NCeVUxY0xVODdzN1pFL251ZWYzSmVqckIx?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0cba12-0b30-43ab-5f5c-08db815064a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 14:17:28.8685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRLzVbqEYtgdx1IDEiRQRYwF1EmU+H80DFiDkex0vudk1wNGaPZQ406V+nLuor+yeOh0LC3j47JNH6t27CDrK6icXAjrSrMKbI/7ZgBQzhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4gU2VudDogTW9uZGF5
LCBKdWx5IDEwLCAyMDIzIDY6NTkgQU0NCj4gDQo+IE9uIDcvOS8yMyAwMTowOSwgS2lyaWxsIEEu
IFNodXRlbW92IHdyb3RlOg0KPiA+IE9uIFNhdCwgSnVsIDA4LCAyMDIzIGF0IDExOjUzOjA4UE0g
KzAwMDAsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+ID4+IEZyb206IEtpcmlsbCBB
LiBTaHV0ZW1vdiA8a2lyaWxsQHNodXRlbW92Lm5hbWU+IFNlbnQ6IEZyaWRheSwgSnVseSA3LCAy
MDIzIDc6MDcgQU0NCj4gPj4+DQo+ID4+PiBPbiBUaHUsIEp1bCAwNiwgMjAyMyBhdCAwNDo0ODoz
MlBNICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+Pj4+IEZyb206IEtp
cmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4gU2VudDog
VHVlc2RheSwgSnVuZSA2LA0KPiAyMDIzIDI6NTYgQU0NCj4gPj4NCj4gPj4gW3NuaXBdDQo+ID4+
DQo+ID4+Pg0KPiA+Pj4gSXQgb25seSBhZGRyZXNzZXMgdGhlIHByb2JsZW0gdGhhdCBoYXBwZW5z
IG9uIHRyYW5zaXRpb24sIGJ1dA0KPiA+Pj4gbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGlzIHN0
aWxsIGEgcHJvYmxlbSBmb3IgdGhlIHNoYXJlZCBtYXBwaW5ncyBpbg0KPiA+Pj4gZ2VuZXJhbCwg
YWZ0ZXIgdHJhbnNpdGlvbiBpcyBjb21wbGV0ZS4gTGlrZSBpZiBsb2FkX3VuYWxpZ25lZF96ZXJv
cGFkKCkNCj4gPj4+IHN0ZXBzIGZyb20gcHJpdmF0ZSB0byBzaGFyZWQgbWFwcGluZyBhbmQgc2hh
cmVkIG1hcHBpbmcgdHJpZ2dlcnMgI1ZFLA0KPiA+Pj4ga2VybmVsIHNob3VsZCBiZSBhYmxlIHRv
IGhhbmRsZSBpdC4NCj4gPj4NCj4gPj4gSSdtIHNob3dpbmcgbXkgaWdub3JhbmNlIG9mIFREWCBh
cmNoaXRlY3R1cmFsIGRldGFpbHMsIGJ1dCB3aGF0J3MgdGhlDQo+ID4+IHNpdHVhdGlvbiB3aGVy
ZSBzaGFyZWQgbWFwcGluZ3MgaW4gZ2VuZXJhbCBjYW4gdHJpZ2dlciBhICNWRT8gIEhvdw0KPiA+
PiBkbyBzdWNoIHNpdHVhdGlvbnMgZ2V0IGhhbmRsZWQgZm9yIHJlZmVyZW5jZXMgdGhhdCBhcmVu
J3QgZnJvbQ0KPiA+PiBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCk/DQo+ID4+DQo+ID4NCj4gPiBT
aGFyZWQgbWFwcGluZ3MgYXJlIHVuZGVyIGhvc3QvVk1NIGNvbnRyb2wuIEl0IGNhbiBqdXN0IG5v
dCBtYXAgdGhlIHBhZ2UNCj4gPiBpbiBzaGFyZWQtZXB0IGFuZCB0cmlnZ2VyIGVwdC12aW9sYXRp
b24gI1ZFLg0KPiA+DQo+ID4+PiBBbnkgY29tbWVudHM/DQo+ID4+DQo+ID4+IFRoaXMgbG9va3Mg
Z29vZCB0byBtZS4gIEkgYXBwbGllZCB0aGUgZGlmZiB0byBhIFREWCBWTSBydW5uaW5nIG9uDQo+
ID4+IEh5cGVyLVYuICBXaGVuIGEgIGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBvY2N1cnMgb24g
YSBwYWdlIHRoYXQgaXMNCj4gPj4gdHJhbnNpdGlvbmluZyBiZXR3ZWVuIHByaXZhdGUgYW5kIHNo
YXJlZCwgdGhlIHplcm9wYWQgZml4dXAgaXMgbm93DQo+ID4+IGRvbmUgY29ycmVjdGx5IHZpYSB0
aGUgI1ZFIGhhbmRsZXIuICAoVGhpcyBpcyAqd2l0aG91dCogbXkgUkZDIHBhdGNoIHRvDQo+ID4+
IG1hcmsgdGhlIHBhZ2VzIGludmFsaWQgZHVyaW5nIGEgdHJhbnNpdGlvbi4pDQo+ID4NCj4gPiBH
cmVhdC4NCj4gPg0KPiA+IEkgYW0gYXQgdmFjYXRpb24gZm9yIHRoZSBuZXh0IHR3byB3ZWVrcy4g
SSB3aWxsIHByZXBhcmUgYSBwcm9wZXIgcGF0Y2gNCj4gPiB3aGVuIEkgYW0gYmFjay4gRmVlbCBm
cmVlIHRvIG1ha2UgcGF0Y2ggeW91cnNlbGYgaWYgeW91IGZlZWwgaXQgaXMgdXJnZW50Lg0KPiA+
DQo+IA0KPiBNaWNoYWVsLA0KPiANCj4gQXJlIHlvdSBzdGlsbCBwdXJzdWluZyB0aGUgUkZDIHBh
dGNoLCB0aGVuPyBKdXN0IHRyeWluZyB0byBkZWNpZGUgd2hldGhlcg0KPiBhIHBhdGNoIHdpbGwg
YmUgbmVlZGVkIGZvciBTTlAuLi4NCj4gDQoNClllcywgSSdtIHN0aWxsIHB1cnN1aW5nIHRoZSBS
RkMgcGF0Y2guICBJbiBhZGRpdGlvbiB0byBzb2x2aW5nIHRoZSBTTlANCnByb2JsZW1zLCBJIHRo
aW5rIHRoZXJlIGFyZSBzb21lIGJlbmVmaXRzIHdpdGggVERYLiAgQnV0IEkgbmVlZCB0byBoYXZl
DQpmdXJ0aGVyIGRpc2N1c3Npb24gd2l0aCBLaXJpbGwsIHdoaWNoIG1heSBiZSBkZWxheWVkIGEg
Yml0IHdoaWxlIGhlJ3Mgb3V0DQpvbiB2YWNhdGlvbi4NCg0KTWljaGFlbA0K
