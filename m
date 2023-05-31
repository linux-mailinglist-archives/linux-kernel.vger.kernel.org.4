Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA7718AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjEaUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEaUA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:00:27 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A55C0;
        Wed, 31 May 2023 13:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le8fLt6dM8H/5ujWSBhK9NTWNygnQNYtKAbu4Vk/I0emyVGGuUMfWkfTxX+zhteRQuBNrYHhlkBDCqu+R2UPVHplVKred9iD4YjAaMh3n1PqGCv7BiGXRhQQEeVsqY3mNYvWhmX7qmEGkqNXgm07fP4jqIHyHY6ltZtcp+oxzwvGyKZkNkrZgUxQGWMX97IVjVGgKKNEkXxy3EA629VrFoc1ooGy4d8Bb/OVJzDdpHAFL/L9n6plPaJl8Se0RaaPCQdPVQ8benMGqAunRlSlyrSBp5fJsEWQ5Jt/9j8SNpVjCVWsJk4FOVgTcKWaeyAM9u5MpPWSGC7nxg6/gJAzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW9X0q2qsdMQvkOhwNCgrISTWHcMKwNhXtCHNgw3tyg=;
 b=RCQm0ttszSsIuMg0luWnfqwmcCj0YJOhj9L8WS0iu4ExrJFchv+0z2fNNlUwZSmIWlXbXlr8FU86YSNxnnHJkNOaxUuuc+RZQ33rpJBZ270cUyw/xP9ZGxKn1LTD4NDhRvTnkkEU39V+sZ7jEl+SHgc0y1kfxrRrX9g7fs1EW4SrBIh9x8uqLi/GqpMjMgMRI6XHpawmULxx43Oc6vGa9iM7ZVApVPpdHLd3MLVPP1xeBSD+cu37BITqNBCMgcKYeUqNrTf+l7jpAVczcallXJkDY0MSAvXZrO0oKFmG9WPkerVMVtE9avoZed7RkNlHC52bEfS4U6x/ZMXFeVzhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW9X0q2qsdMQvkOhwNCgrISTWHcMKwNhXtCHNgw3tyg=;
 b=ICWZu5uQfQ7Y5DOaH5FCtLAcRvDABpKfNqwM9j3NI74MusxzjW8ofyhnzAfXNg5Hsxd4ieXBIdzOR8ovyOH4bIH+S7WizWCfe3Ed5Fzd6MPHWJ36uVZGGNoZgWvnT19GQgSoa4k6Q+T4WyLtqdlAqJUIACkTRCBJcHya51XBWZQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY1PR21MB3967.namprd21.prod.outlook.com (2603:10b6:a03:529::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.5; Wed, 31 May
 2023 20:00:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9%4]) with mapi id 15.20.6477.004; Wed, 31 May 2023
 20:00:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Thread-Topic: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Thread-Index: AQHZj8oTFjnlsJ7BHk+B/hII3JAaOq9tHk4AgATlkACAAMkCAIAABw6AgAHJXiA=
Date:   Wed, 31 May 2023 20:00:23 +0000
Message-ID: <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
 <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
In-Reply-To: <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d5bb49e-d4fb-400b-bb26-195452256870;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-31T16:39:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY1PR21MB3967:EE_
x-ms-office365-filtering-correlation-id: a52c876e-bba0-488c-718b-08db6211ab91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAPPGOljhFLD3FYIshFFfHsFOgq/6+//rL7A6YX5IPAUSw/dy8G/rUrRe9XIH/hl/9acR61i7Zi/DNq5hI1IFz2U+5FBEaX4grtDFw5XLs9ZsNyvvwEBiKLzgsrOS5gvYkPEM3mc1fB/4OGDHowhT3mAjnWbK/9JbBj58wj88vV6mt6ZGfdF1O8zTX/RX1P6W0sMSlembi70TwDoCC0cnfeLdVN/aRLZnfBBVA6ye2PqvSuqOeclZ724SEnx6ag9aZA9AtNFGH5/8LKz2kKBGbJOSK82P3FNZhi0RCNpcmq5SSUBgWJf3XtF3no+hIWeCNl/KYA501FVASet02cWBoosm+54ObRIGmcjaqhtmx2reDgDbJJ4zYRYNJ9xie96BQT06W4L/yCrX6bF3MkjH92Icl6CNEU/nTEzSYulAlBUVcKHNVBSdNxF9ilATjH5cvR8AfLBj9wosaEcgzHLnfOhXhoKuRP/2KVfdIQl6zRk/PlkqsOWCOeH0JFw92KnnBIgZuNlHXW6zdhjAEaK3Rm/3NfnL7dKrjK47vd2xBo/QZZQO7Euz3lKa/X7p3G7GoTZl078YQoVqYse2ZEf2oZ5uFxJX0f7CoWIgLwjn4LMW9f4xbMYNw0JUqiYKhOo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(8990500004)(83380400001)(2906002)(186003)(38070700005)(38100700002)(82960400001)(82950400001)(122000001)(55016003)(54906003)(8676002)(41300700001)(71200400001)(316002)(786003)(86362001)(7696005)(5660300002)(8936002)(478600001)(10290500003)(33656002)(52536014)(4326008)(110136005)(9686003)(76116006)(66476007)(64756008)(66556008)(66446008)(26005)(53546011)(6506007)(66946007)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1pwcWM5d1BlWWkrWGRFaXBoQnpXQzdXY0Z5aG1Od2R3Zi9CL295bk53Mkc0?=
 =?utf-8?B?Tk0wY1hIb3EwdG5OalpRU0NVQmJEYmNaa1lXWGRvbmNyYUVMVjhRdklGNzVn?=
 =?utf-8?B?RVhobXdrVmlXeDdtZTJCcjZENVFoUkE3ZlcreDRlc0ZyWTM1UVMrSmI2b1lE?=
 =?utf-8?B?YkMwWVBNSmhLQytkM1ErQURocmxXNkVqdUhuUEEzT0ZTMGR3UDVVcHMyeFov?=
 =?utf-8?B?VmV2RmJqeDFsMG9iaFRKdDlmdVZZeWk5Vm5JWlRKRHE2SzVGTi9GRGcrem1B?=
 =?utf-8?B?dXA3amJ3dEVYREdpL0JUbUJYSTlGcXM0OStFZWFQcWFsak16NjBIbmgxcHpL?=
 =?utf-8?B?c0xoQlh2UWRHKzdEUnJBUlZ5cGcxZVJBTmtsRDFyb1ZucTErakxLUHhEdk55?=
 =?utf-8?B?dW1mS01kcDhVZ1V5Vy9qODNGZUFnL2FUSVhOR2lmUnBSd2xhanBXVHNjbTRQ?=
 =?utf-8?B?OGcrYjdQUkQ1blh6TjlMZFYwWTZCcXVxREdBRHJhT3g2RlBiY2UzNTY2ZVI3?=
 =?utf-8?B?dHVaYjNBOEtTd2tGckR3enJSOEN1VS95QjE3WTRYZXRESTdBbDRkQlYveElR?=
 =?utf-8?B?a21KdFRvWURZa1d3OEZKQnhhdHViSmxZaWFBekVXUWVCeXhUL0N6eGMwcXRL?=
 =?utf-8?B?VkNHcU5lTElmQjliY1Z0ZW9YUjZHQllvSm1zdUwyOE16ZThiOVllNnVEN0dt?=
 =?utf-8?B?empuL1pweGNRWkNIYWpqaUVlTlpEakdCTHplZC9EMzN1bDVTVWNlVm1XK0pJ?=
 =?utf-8?B?OWFjdC9RV3pwZTR4K3RxQUJ5d2gyU1NlNHl6V2MvbGE0WmxPQ1k0ck1aYmxX?=
 =?utf-8?B?UEc5Z3hsT0VLWnNJdEZSNHllOFZQdmRObGlaQ3JtODdUck8vSTJvRy9EUXJi?=
 =?utf-8?B?UHZtUzZpYTVCZEo3bkNXMFBZdjhOdzVNSWtsQ1puMG1TVTFkZXB2eTljUVBk?=
 =?utf-8?B?cVZ4NUkvdmlncTR6dEd0YVEwNG81anNFTnUwL2FTQnJrVVMzYU5neHIvcVBL?=
 =?utf-8?B?bGhLdnJHZnR3WFBVN1QxZ1h2dGhIcGVaQ3hVKzgyTjZ3QkpPRTQwQU9Zd3V1?=
 =?utf-8?B?LzF1cE1XUnpjQ083MXdEdmwreGRtVk5jdEI4akR0R2doOURkVnR5d2VpeHBu?=
 =?utf-8?B?OUVubTlrNm9rREE3SHZaeEtzbEIzR0F0VU9SMlczcVA3WnRXSU1VNlFRR2x2?=
 =?utf-8?B?ZE9teTVKeVJYVGlqTXQ4bFdDYTJXTU1SSTJoUmxpRCtXRlJ0RmJjaXVSM25P?=
 =?utf-8?B?Sk82VUJUTXJWOTVaY3hRNlJvMDd3OVNuUDZSdU42M2FxaHNJdUhHTmxtRWI3?=
 =?utf-8?B?cVh5L2EvQ1RhaE8reUl5dXB3QU1OS1g5eS9zUG9tb1RWalc0ajBRL09tWndC?=
 =?utf-8?B?Sm9TVFZNV0RleWFsbFBmNlVsUmsyazdBZk9mUktpSkVqcGJTS2NnL2gzeE1i?=
 =?utf-8?B?RlF5NmV2UGpFWVNmYUQvUjFrWUhFaWdLcjhOeU9TdGg5ZkxGSzlJY0lteHd6?=
 =?utf-8?B?NWhBV1BZTGlXd0NtSEZZd3FJQXNIZE81dXFxMFhURFF5TDM5aXFtM2FnSUpX?=
 =?utf-8?B?bDN2YzdHMTVDZVMwSU1SeTVkQzJMV1A0U21OeTZJK2o0TGdrTG43WEd1bEZN?=
 =?utf-8?B?blcreU5BT1NObXZYT29Fa3NYSHdDWUlDczI3RHpybStZb3FNSUo3elg3c0Iy?=
 =?utf-8?B?cHloOGNPNkUzaEZqeGZlK1BFeFpySHovY0hUdEpSVklUa2V4a1lKdVZKdGJI?=
 =?utf-8?B?eGd6Sk9CSlhWYnJ3T2szRm1yTmh0dXcyRVZVY2Y5VzM5aXVmdTlaK3dwZFR4?=
 =?utf-8?B?djJ6RHIxY3k2a0dGMjhCU1Ryb056Vm9SaDM2N0hCNXhVSWVvV2pzMVg3Vlgw?=
 =?utf-8?B?dnlkQ2tMZGw5NUVRQzB6VlhXZTVTNnJiZG14NXNtVGh5SzFFSzhhTlNxbmFN?=
 =?utf-8?B?dkFud3huOVhCZ3V6djAxbFB4bEl3WG9pTUpSNVdUNDFkYTh1SW1mUzhoOXJp?=
 =?utf-8?B?ajlaaWszOEVtYUdKNW8ydDF0bWw5VDNrcWIwTHlpSFEraVZEdmg1b0tyN3Zi?=
 =?utf-8?B?cnJ4emI3NjJOelZTV0RMZW5yNEVQVjQyQlU5OFFXS0JtWnJzL1JIaGh4VXBR?=
 =?utf-8?B?M0FsaEpKck1USU1nVWNaVzBkYmhwTVc3dVVsUy9uSEwvME5iNDhyRis5M3gv?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c876e-bba0-488c-718b-08db6211ab91
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 20:00:23.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opiLD8tSOglci0fN05utTV5cfACbyp+UOH//FFuxUl5qfe3H63ZJRUdbO6rSLjxM9PXiG1l5n2XYDlGkD5jUscblnXQQ53hK+7K5sc/IVog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3967
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2F0aHlhbmFyYXlhbmFuIEt1cHB1c3dhbXkgPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3
YW15QGxpbnV4LmludGVsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE1heSAzMCwgMjAyMyA2OjIyIEFN
DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDUvMzAvMjMgNTo1NyBBTSwgVG9tIExlbmRhY2t5IHdyb3Rl
Og0KPiA+IE9uIDUvMjkvMjMgMTk6NTcsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPj4g
T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMDM6MTA6NTZQTSAtMDcwMCwgU2F0aHlhbmFyYXlhbmFu
IEt1cHB1c3dhbXkgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IE9uIDUvMjYvMjMgNTowMiBB
TSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+Pj4+IFRvdWNoaW5nIHByaXZhdGVseSBt
YXBwZWQgR1BBIHRoYXQgaXMgbm90IHByb3Blcmx5IGNvbnZlcnRlZCB0byBwcml2YXRlDQo+ID4+
Pj4gd2l0aCBNYXBHUEEgYW5kIGFjY2VwdGVkIGxlYWRzIHRvIHVucmVjb3ZlcmFibGUgZXhpdCB0
byBWTU0uDQo+ID4+Pj4NCj4gPj4+PiBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgY2FuIHRvdWNo
IG1lbW9yeSB0aGF0IGlzIG5vdCBvd25lZCBieSB0aGUNCj4gPj4+PiBjYWxsZXIsIGJ1dCBqdXN0
IGhhcHBlbmVkIHRvIG5leHQgYWZ0ZXIgdGhlIG93bmVkIG1lbW9yeS4NCj4gPj4+DQo+ID4+PiAv
cy90by90byBiZSA/DQo+ID4+DQo+ID4+IFllcCwgbXkgYmFkLg0KPiA+Pg0KPiA+Pj4+IFRoaXMg
bG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGJlaGF2aW91ciBtYWtlcyBpdCBpbXBvcnRhbnQgd2hl
biBrZXJuZWwNCj4gPj4+PiBhc2tzIFZNTSB0byBjb252ZXJ0IGEgR1BBIGZyb20gc2hhcmVkIHRv
IHByaXZhdGUgb3IgYmFjay4gS2VybmVsIG11c3QNCj4gPj4+PiBuZXZlciBoYXZlIGEgcGFnZSBt
YXBwZWQgaW50byBkaXJlY3QgbWFwcGluZyAoYW5kIGFsaWFzZXMpIGFzIHByaXZhdGUNCj4gPj4+
PiB3aGVuIHRoZSBHUEEgaXMgYWxyZWFkeSBjb252ZXJ0ZWQgdG8gc2hhcmVkIG9yIHdoZW4gR1BB
IGlzIG5vdCB5ZXQNCj4gPj4+PiBjb252ZXJ0ZWQgdG8gcHJpdmF0ZS4NCj4gPj4+DQo+ID4+PiBJ
IGFtIHdvbmRlcmluZyB3aGV0aGVyIHRoaXMgaXNzdWUgZXhpc3QgaW4gdGhlIEFNRCBjb2RlPw0K
PiA+Pj4NCj4gPj4+IElNTywgeW91IGNhbiBhZGQgc29tZSBpbmZvIG9uIHRoZSB3aW5kb3cgaW4g
c2V0X21lbW9yeV9lbmNyeXB0ZWQoKQ0KPiA+Pj4gd2hlcmUgdGhpcyByYWNlIGV4aXN0cy4NCj4g
Pj4NCj4gPj4gSSBkb24ndCB0aGluayBBTUQgYWZmZWN0ZWQgYnkgbG9hZF91bmFsaWduZWRfemVy
b3BhZCgpIHRoZSBzYW1lIHdheSBhcw0KPiA+PiBJbnRlbCBkb2VzLiBCdXQgSSdtIG5vdCBzdXJl
Lg0KPiA+Pg0KPiA+PiBUb20sIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cz8NCj4gPg0KPiA+IFJp
Z2h0LCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUgZm9yIFNOUC4NCj4gDQo+IFRoYW5rcyBmb3IgY29u
ZmlybWluZy4NCj4gDQoNClRvbSAtLSBGb3IgbXkgZWR1Y2F0aW9uLCBjb3VsZCB5b3UgZWxhYm9y
YXRlIG9uIHdoeSB0aGlzIHByb2JsZW0gY2FuJ3QNCm9jY3VyIGluIGFuIFNFVi1TTlAgZ3Vlc3Q/
ICBUaGVyZSdzIHN0aWxsIGEgd2luZG93IHdoZXJlIHRoZSBkaXJlY3QgbWFwDQpQVEUgYW5kIHRo
ZSBSTVAgYXMgbWFpbnRhaW5lZCBieSB0aGUgaHlwZXJ2aXNvciBhcmUgb3V0LW9mLXN5bmMuICBJ
Zg0KbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGRvZXMgYSByZWFkIHVzaW5nIHRoZSBkaXJlY3Qg
bWFwIFBURSBkdXJpbmcNCnRoaXMgb3V0LW9mLXN5bmMgd2luZG93LCBpc24ndCB0aGF0IGdvaW5n
IHRvIHRyYXAgdG8gdGhlIGh5cGVydmlzb3I/ICBIb3cNCmlzIHRoZSBzY2VuYXJpbyBpcyBoYW5k
bGVkIGZyb20gdGhlcmUgdG8gcHJvdmlkZSB0aGUgemVyb3MgdG8NCmxvYWRfdW5hbGlnbmVkX3pl
cm9wYWQoKT8gIEkgbmVlZCB0byBtYWtlIHN1cmUgSHlwZXItViBpcyBkb2luZyB3aGF0ZXZlcg0K
aXMgbmVlZGVkLiA6LSkgIA0KDQpUaGFua3MsDQoNCk1pY2hhZWwNCg0KDQo=
