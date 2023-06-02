Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9772072D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbjFBQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjFBQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:13:19 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54BAE5D;
        Fri,  2 Jun 2023 09:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmeYgvTfjOByOEPSp2ijMGazjERL2SeGUejUCAR/E5AyCPuXy90rtDN05Gde+1/v2XJfk7VbDz5YEBF9sHXZ2xR4o84sMA1wH/l9Te7OX7Zwurw5p7VY2fjbaOpqBsQHoSG1uER0Z5S47ndjdBwiTtp3OrjuZkJ98Am+H0rVXMk0bQy76K9Ig6LuE3VPtntpY6im5kuR/d6ss9YghMQRqcAU+EtZbRNhv3vENMEwa1CO4NJ5xtks4M/YMmzTCsjBXrPFSzfLnxxpM4v6vZzWaDxoe9Cj1BQ1SVrQ8ZOgA01cEL9goddQJTEifRLzHJPLahD2wNefPodoFJ4x2ax54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6WI+q8rX8CbNZksZGrApt4PE2oRCz/7sw75A7Xuewk=;
 b=eMunujDtokJ3JHE2meL0dlgZ2Jk3yrGNcUlP9dAyR+6cMoGRDmBladuQzFw+2YAyws7HeK23xFHtpML7FzLnMt9+DkU21a95ogJXPw+udSu7YB6HKV/BjiL4lYsa+KUK+i2mbVuyPs245qhsuKuUAL0QWTjlaHHptlEhMr8oPxn3y/32sjX1diRlOz4LzAUrwsiKqDUTOg3KHZQU8207U+80wiuFBJ2J03H7PottDv506gDcFMFoCgZvzWW25twRYz+JQ6LD3zCn8i3aSBJMuH1dgaInfN1PMVgtTdfraURgYPISz2B/h79hWCP5mIqp2RhqS2KH5HX+XMknKRwM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6WI+q8rX8CbNZksZGrApt4PE2oRCz/7sw75A7Xuewk=;
 b=T1WEvMJOzmtnDfplQoio1220Q14D3lOymFGAzoZTYXLfEXgsbO4z3s9+0yLNuMj10QirhaogxG1We7cT/rez4CQWU328/DH5ZBrUwTZxx/4m4McZdpRQvB0ooCeSi/KGhQLcYy25K0YBGJP3zPOUHEwne3tehAvRJqUbd/3AB60=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA0PR21MB1994.namprd21.prod.outlook.com (2603:10b6:806:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.6; Fri, 2 Jun
 2023 16:11:40 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9%4]) with mapi id 15.20.6477.012; Fri, 2 Jun 2023
 16:11:40 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Thread-Index: AQHZj8oTFjnlsJ7BHk+B/hII3JAaOq9tHk4AgATlkACAAMkCAIAABw6AgAHJXiCAAa5QgIABaKXw
Date:   Fri, 2 Jun 2023 16:11:40 +0000
Message-ID: <BYAPR21MB168826D6C870542E5BD3372BD74EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
 <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
 <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <9fbc3760-7239-2323-ed90-210a0de9e286@amd.com>
In-Reply-To: <9fbc3760-7239-2323-ed90-210a0de9e286@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4be6cfcb-5381-4371-b899-0167b70fcf6a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-02T15:50:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA0PR21MB1994:EE_
x-ms-office365-filtering-correlation-id: eabfeb73-dd2d-401f-c684-08db63840cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejpUGOa/bdQUjEm8ro2gDYdTqzRZPdkCEahf8nShhUv+/JUEHsgQYXOJtJvz32DJDVXcdOSDLQDEQOAEnYicFIh8KzDLyAM98KlrcbYZjTNPwNoHolDCk0f2XW+yFBpvOHyHtq0TZ5/uQ6j9FSUdD1X894CA4idFXyWPoAvloagYL237+boVBHgXY+asrfDLmyBg+wCsO0gnnXuJr3PseCuPKHoPzjmYORbQdUyQLLKi2V1+nxDtg7risBusQFntpktTSu44TiCaN6trOyYSlDO2JO14GWzumXUPzgJBJKnbO/3FFe7pgBvrQRvWO9+bGYdPsGyFJBZimshqYYvvjdVIg7TxxCo/BLZpNy8FRMjXCh/0Y5IzYZVTTXCoabTEZI+7fIfv+7+wT4lUpLIf0Am6CBVNWr2BoO0XmzsmGSGUWFRKjxQ5ECG51hR3fIm39TzgQ5K8LK8ZKL8fTie8R2mZb9sqwzTqY1+ApaLyN6G+sMkfMH0QO5dzK+9LupTX/vKK89NCIhE7PwmfwThO8rj/7L5UJHCtdniudWovWWD4ONwzehTeGebfUzjoGGUT2vbhaJIeRq7iRSBtPYL5vPfvJzQ3mPRN+Q1rLl8+0vkQ+maV1h1RoI7skkn0YBWQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(83380400001)(2906002)(186003)(38070700005)(82960400001)(82950400001)(38100700002)(122000001)(8990500004)(55016003)(41300700001)(786003)(7696005)(316002)(71200400001)(5660300002)(86362001)(478600001)(8936002)(8676002)(52536014)(54906003)(110136005)(33656002)(10290500003)(53546011)(76116006)(66476007)(64756008)(4326008)(66946007)(26005)(66446008)(9686003)(6506007)(66556008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUhhS1JicVRub1VreUx0aWhhOGtSL1pCY3g0WGNIcE9rTHVlU09aVTJnaVMr?=
 =?utf-8?B?MWZINDh3SllNYzNFTFlYMFEzb29YbFVkb1ZDNzhDZER1NTFvRzk3blJTUTV2?=
 =?utf-8?B?UW9LQXZ1bGJLVHlwcUFQZ0pHblplaWlXRU9zdXJtUDVDMlRJK2hIbVZiZ1dH?=
 =?utf-8?B?dGRIcTZyaDdVY2JoR0Z2SEdJbGxobDlvSGQ5RkMzWkJqUXFlN0JVMXZBbitE?=
 =?utf-8?B?cUZQbEZrR3I0dFp6VEhYYUQ3Y2pSNXUzaWc2VkNRN3FFeDE2TjRFcnMxQW95?=
 =?utf-8?B?UXAvdmIxa21KYXhIb2N3dGw3UStKQlNPbDZsTUFraWFvZy95SHRBSmNXTWhu?=
 =?utf-8?B?dUR3STFQaURJODU2NmNCalRPVm1EcjJuQmh1K2NpY1RaTTFLY25iRW9ZRjEz?=
 =?utf-8?B?dUJLQkN6ZGhkWTRQYVhVeDZRM2hZaWMrRjA3SnVpamdKTDRTMXBSdVRHTVNi?=
 =?utf-8?B?MG1ocGRwNUNIb3FoVjcxbXJVN1l1WGgwdlAxNjZRb1l1WUpYeXpUN1BHaHNZ?=
 =?utf-8?B?elZ5WlZIS25MeFJ0OGtIU3pOSDJHTzB2TmVybDQvZlE0NnluZy9UUFZTb25X?=
 =?utf-8?B?dUErOXhqRGxTTUxjSE9ma3AvYTJOdzVHeFVYV2xuaC9meXFwOElwYkdIOEpV?=
 =?utf-8?B?T1RnbGYwaFRmc2YyajMwb2N1b3V0U0pvRTVrRk1RRFpRL2k0N2tpVTVYMDNP?=
 =?utf-8?B?bUdBUjF4MXZDaU1VbCtrVkhLZ0lkblhCTkw5WlM3M1paWW1OOFg2ZVhsQnhB?=
 =?utf-8?B?RkQ0dzJ4SENrY2dqUldFWUUydUlqYzh2MjVOU1RnNUJlWVo5ZHNnOVhPdjRt?=
 =?utf-8?B?d0tkWUN4aXZqM3A2czhkMGdlQkI2dy81MjlSd21oWjlLc2c0RWFVa1hEY3U3?=
 =?utf-8?B?NkprUnVJQ3V1U0pFWXZ4NTVXK2VjcWpRa3lvOEQwU1djaEdTTkdkcUdaV0R5?=
 =?utf-8?B?Qng5bHFCdmtaL1NmMmM4TmFXV3dTeFF0L0VMTWQ5NjVKZEhQWHU0OUZWSHRq?=
 =?utf-8?B?djNqaisxbTNkUU9zaWt0ZmxSeWRrOUhnalg4dWpsZVNwbWZvUGpDMG55dGxR?=
 =?utf-8?B?ZXBDTEwyQnVtWW1CSVkwUXRsUEY3SlJtc1FiSTl3RldmMzQydXVXQVZNNWMv?=
 =?utf-8?B?aTVlWFlpK2hWb2VLZXB6SmQ4LzQvNDIvMWZsZHZ1aFFQRlJ6enRINVJ5MUF2?=
 =?utf-8?B?QlpwbzZrYmxCSk1hZFgwSkZhckJrUFprL2ZuZ0JBd1BsaW44dmcvMjVXdUd6?=
 =?utf-8?B?NUQ0OGdGcEk5bEQ0YjV6RStWSGFjdVZIUUZOeU5VYW5VZ1k4a0hLWnZQbnBS?=
 =?utf-8?B?Tzc3VTVCWWIvNUxhWG4vV1czS3lqcXNNWFJLQk5IVXBNN3BtQVpLK04vMEhD?=
 =?utf-8?B?OEJpeTRRVlhtbkw5RGJGYkVpbDZoZTg1YzZybTVGTXdsa1JCMUZsWHNOdjJp?=
 =?utf-8?B?S0pQSWxVYTJ2S0Q5VzhFaW9JU2Y0b082bkgrc3FCQzR5VEs2d1ZWUG9OeDdp?=
 =?utf-8?B?Q2VQOUx4aFdhM3VSYWhPU1R1TmVpbEVLclNETzBqaHVCRXhLaXdSbmNlSFdZ?=
 =?utf-8?B?WjZDTTQ4MERRRnd5ckpTL0lMNThBUUFtTGFyZVdHUWxVb1lsUVI1c25Qd1F6?=
 =?utf-8?B?aVJqdmpsV1dDQWhEOW1tYkZ1VWR6bEJQS2ZERFo1QWkvem9aYWpZN1hQU0kz?=
 =?utf-8?B?b1ZiQUd0eXlKc2RrTkdONi9iei9xTXdqQ3NZUzI5V3o3WTV3eHJzOUwreFpI?=
 =?utf-8?B?MWx6eTZHUlh4S2d5TXpBVkZ3endkbHRicFNTaDR6ZHZlOEFzelFydVRvMUM0?=
 =?utf-8?B?VDZ0TFQreGQ0VldhOHVtOFNiV2ZlV1IveW5kOFh2UGVHaXJtaFUzd05RL2Vx?=
 =?utf-8?B?TGlqVS9aRTF3ZjdYU0J4NDU3dk0ySExBY25MNG5PZVd0QVJYZG42YXNPNUxK?=
 =?utf-8?B?Q2pNYk9iQkpDZ0FwbTlPektLNmxUUmVZZTJrcHR0QXFkU2I3cjRnYkZTVDUz?=
 =?utf-8?B?ZDAxTmxTa2h6WlQ1SHA2dE00NUpiQ2kzSjdVVVhTeUpvbDBneS84MzNocTJQ?=
 =?utf-8?B?alJQdTlYLzNXK1hYb2dCLzFZVnNaaHdjaWlHNVdqS0ZXSkZqRHEzWHQ1U1I3?=
 =?utf-8?B?Z1BiZzBOYUpPc1ZhTURpQUJnS3FQR1ZHbTFNTmd4MDljUTU5SGM4amJaMGh1?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabfeb73-dd2d-401f-c684-08db63840cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 16:11:40.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7FRPC95BMgC/neua/I0+DPjyRGccWWD2NimpCBhtZugEd4u0cNZQElATd90ts01SHFTf1MaSEO7BVKPx2phb46A4x0Tca0IuW5jlqmdiqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1994
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4gU2VudDogVGh1cnNk
YXksIEp1bmUgMSwgMjAyMyAxMToxOSBBTQ0KPiANCj4gT24gNS8zMS8yMyAxNTowMCwgTWljaGFl
bCBLZWxsZXkgKExJTlVYKSB3cm90ZToNCj4gPiBGcm9tOiBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteQ0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPiA+
IFNlbnQ6IFR1ZXNkYXksIE1heSAzMCwgMjAyMyA2OjIyIEFNDQo+ID4+DQo+ID4+IEhpLA0KPiA+
Pg0KPiA+PiBPbiA1LzMwLzIzIDU6NTcgQU0sIFRvbSBMZW5kYWNreSB3cm90ZToNCj4gPj4+IE9u
IDUvMjkvMjMgMTk6NTcsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPj4+PiBPbiBGcmks
IE1heSAyNiwgMjAyMyBhdCAwMzoxMDo1NlBNIC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteQ0KPiB3cm90ZToNCj4gPj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gT24gNS8yNi8yMyA1OjAy
IEFNLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4+Pj4+PiBUb3VjaGluZyBwcml2YXRl
bHkgbWFwcGVkIEdQQSB0aGF0IGlzIG5vdCBwcm9wZXJseSBjb252ZXJ0ZWQgdG8gcHJpdmF0ZQ0K
PiA+Pj4+Pj4gd2l0aCBNYXBHUEEgYW5kIGFjY2VwdGVkIGxlYWRzIHRvIHVucmVjb3ZlcmFibGUg
ZXhpdCB0byBWTU0uDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gbG9hZF91bmFsaWduZWRfemVyb3BhZCgp
IGNhbiB0b3VjaCBtZW1vcnkgdGhhdCBpcyBub3Qgb3duZWQgYnkgdGhlDQo+ID4+Pj4+PiBjYWxs
ZXIsIGJ1dCBqdXN0IGhhcHBlbmVkIHRvIG5leHQgYWZ0ZXIgdGhlIG93bmVkIG1lbW9yeS4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gL3MvdG8vdG8gYmUgPw0KPiA+Pj4+DQo+ID4+Pj4gWWVwLCBteSBiYWQu
DQo+ID4+Pj4NCj4gPj4+Pj4+IFRoaXMgbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGJlaGF2aW91
ciBtYWtlcyBpdCBpbXBvcnRhbnQgd2hlbiBrZXJuZWwNCj4gPj4+Pj4+IGFza3MgVk1NIHRvIGNv
bnZlcnQgYSBHUEEgZnJvbSBzaGFyZWQgdG8gcHJpdmF0ZSBvciBiYWNrLiBLZXJuZWwgbXVzdA0K
PiA+Pj4+Pj4gbmV2ZXIgaGF2ZSBhIHBhZ2UgbWFwcGVkIGludG8gZGlyZWN0IG1hcHBpbmcgKGFu
ZCBhbGlhc2VzKSBhcyBwcml2YXRlDQo+ID4+Pj4+PiB3aGVuIHRoZSBHUEEgaXMgYWxyZWFkeSBj
b252ZXJ0ZWQgdG8gc2hhcmVkIG9yIHdoZW4gR1BBIGlzIG5vdCB5ZXQNCj4gPj4+Pj4+IGNvbnZl
cnRlZCB0byBwcml2YXRlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGFtIHdvbmRlcmluZyB3aGV0aGVy
IHRoaXMgaXNzdWUgZXhpc3QgaW4gdGhlIEFNRCBjb2RlPw0KPiA+Pj4+Pg0KPiA+Pj4+PiBJTU8s
IHlvdSBjYW4gYWRkIHNvbWUgaW5mbyBvbiB0aGUgd2luZG93IGluIHNldF9tZW1vcnlfZW5jcnlw
dGVkKCkNCj4gPj4+Pj4gd2hlcmUgdGhpcyByYWNlIGV4aXN0cy4NCj4gPj4+Pg0KPiA+Pj4+IEkg
ZG9uJ3QgdGhpbmsgQU1EIGFmZmVjdGVkIGJ5IGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSB0aGUg
c2FtZSB3YXkgYXMNCj4gPj4+PiBJbnRlbCBkb2VzLiBCdXQgSSdtIG5vdCBzdXJlLg0KPiA+Pj4+
DQo+ID4+Pj4gVG9tLCBkbyB5b3UgaGF2ZSBhbnkgY29tbWVudHM/DQo+ID4+Pg0KPiA+Pj4gUmln
aHQsIHNob3VsZG4ndCBiZSBhbiBpc3N1ZSBmb3IgU05QLg0KPiA+Pg0KPiA+PiBUaGFua3MgZm9y
IGNvbmZpcm1pbmcuDQo+ID4+DQo+ID4NCj4gPiBUb20gLS0gRm9yIG15IGVkdWNhdGlvbiwgY291
bGQgeW91IGVsYWJvcmF0ZSBvbiB3aHkgdGhpcyBwcm9ibGVtIGNhbid0DQo+ID4gb2NjdXIgaW4g
YW4gU0VWLVNOUCBndWVzdD8gIFRoZXJlJ3Mgc3RpbGwgYSB3aW5kb3cgd2hlcmUgdGhlIGRpcmVj
dCBtYXANCj4gPiBQVEUgYW5kIHRoZSBSTVAgYXMgbWFpbnRhaW5lZCBieSB0aGUgaHlwZXJ2aXNv
ciBhcmUgb3V0LW9mLXN5bmMuICBJZg0KPiA+IGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBkb2Vz
IGEgcmVhZCB1c2luZyB0aGUgZGlyZWN0IG1hcCBQVEUgZHVyaW5nDQo+ID4gdGhpcyBvdXQtb2Yt
c3luYyB3aW5kb3csIGlzbid0IHRoYXQgZ29pbmcgdG8gdHJhcCB0byB0aGUgaHlwZXJ2aXNvcj8g
IEhvdw0KPiA+IGlzIHRoZSBzY2VuYXJpbyBpcyBoYW5kbGVkIGZyb20gdGhlcmUgdG8gcHJvdmlk
ZSB0aGUgemVyb3MgdG8NCj4gPiBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCk/ICBJIG5lZWQgdG8g
bWFrZSBzdXJlIEh5cGVyLVYgaXMgZG9pbmcgd2hhdGV2ZXINCj4gPiBpcyBuZWVkZWQuIDotKQ0K
PiANCj4gQWgsIEkgdGhpbmsgSSBtaXN1bmRlcnN0b29kIHRoaXMgd2hlbiBpdCB3YXMgYmVpbmcg
dGFsa2VkIGFib3V0LiBUaGUgaXNzdWUNCj4gU05QIHdvdWxkIGhhdmUgd291bGQgYmUgYmV0d2Vl
biBzZXR0aW5nIHRoZSBjLWJpdCBidXQgYmVmb3JlIHRoZSBQVkFMSURBVEUNCj4gaXMgaXNzdWVk
LiBQcmlvciB0byB0aGUgUk1QIGJlaW5nIHVwZGF0ZWQsIHJlZmVyZW5jaW5nIHRoZSBwYWdlIHdp
bGwNCj4gZ2VuZXJhdGUgYW4gI05QRiBhbmQgYXV0b21hdGljYWxseSBjaGFuZ2UgdGhlIFJNUCBv
dmVyIHRvIHByaXZhdGUgKGluDQo+IEtWTSkuIEhvd2V2ZXIsIGFmdGVyIHRoZSBndWVzdCBpcyBy
ZXN1bWVkLCB0aGUgcGFnZSB3aWxsIG5vdCBoYXZlIGJlZW4NCj4gdmFsaWRhdGVkIHJlc3VsdGlu
ZyBpbiBhICNWQyB3aXRoIGVycm9yIGNvZGUgMHg0MDQgYmVpbmcgZ2VuZXJhdGVkLA0KPiBjYXVz
aW5nIHRoZSBndWVzdCB0byB0ZXJtaW5hdGUgaXRzZWxmLg0KPiANCj4gSSBzdXBwb3NlLCB3aGVu
IGEgMHg0MDQgZXJyb3IgY29kZSBpcyBlbmNvdW50ZXJlZCBieSB0aGUgI1ZDIGhhbmRsZXIsIGl0
DQo+IGNvdWxkIGNhbGwgc2VhcmNoX2V4Y2VwdGlvbl90YWJsZXMoKSBhbmQgY2FsbCBleF9oYW5k
bGVyX3plcm9wYWQoKSBmb3IgdGhlDQo+IEVYX1RZUEVfWkVST1BBRCB0eXBlIChleF9oYW5kbGVy
X3plcm9wYWQgaXMgY3VycmVudGx5IHN0YXRpYywgdGhvdWdoKS4NCj4gDQoNClRvbSAtLSBEb2Vz
IHRoZSBhYm92ZSBzZXF1ZW5jZSAqZGVwZW5kKiBvbiB0aGUgaHlwZXJ2aXNvciBkb2luZyBhbnl0
aGluZw0KdG8gbWFrZSBpdCB3b3JrPyAgSSdtIG5vdCBjbGVhciBvbiB3aHkgS1ZNIHdvdWxkIGF1
dG9tYXRpY2FsbHkgY2hhbmdlIHRoZQ0KcGFnZSBvdmVyIHRvIHByaXZhdGUuICBJZiB0aGVyZSdz
IGEgZGVwZW5kZW5jeSBvbiB0aGUgaHlwZXJ2aXNvciBkb2luZw0Kc29tZXRoaW5nLCB0aGVuIGl0
IHNlZW1zIGxpa2Ugd2UnbGwgbmVlZCB0byBzdGFuZGFyZGl6ZSB0aGF0ICJzb21ldGhpbmciDQph
Y3Jvc3MgaHlwZXJ2aXNvcnMsIGxlc3Qgd2UgZW5kIHVwIHdpdGggcGVyLWh5cGVydmlzb3IgY29k
ZSBpbiBMaW51eCB0byBoYW5kbGUNCnRoaXMgc2NlbmFyaW8uICBBbmQgcnVubmluZyBTRVYtU05Q
IHdpdGggbXVsdGlwbGUgVk1QTHMgcHJvYmFibHkgbWFrZXMgaXQNCmV2ZW4gbW9yZSBjb21wbGlj
YXRlZC4NCg0KS2lyaWxsIC0tIFNhbWUgcXVlc3Rpb24gYWJvdXQgVERYLiAgRG9lcyBtYWtpbmcg
bG9hZF91bmFsaWduZWRfemVyb3BhZCgpDQp3b3JrIGluIGEgVERYIFZNIGRlcGVuZCBvbiB0aGUg
aHlwZXJ2aXNvciBkb2luZyBhbnl0aGluZz8gIE9yIGlzIHRoZQ0KYmVoYXZpb3Igc2VlbiBieSB0
aGUgZ3Vlc3QgZGVwZW5kZW50IG9ubHkgb24gYXJjaGl0ZWN0ZWQgYmVoYXZpb3Igb2YNCnRoZSBU
RFggcHJvY2Vzc29yPw0KDQpMb29raW5nIGF0IHRoaXMgcHJvYmxlbSBmcm9tIGEgc2xpZ2h0bHkg
aGlnaGVyIGxldmVsLCBhbmQgdGhpbmtpbmcgb3V0IGxvdWQNCmEgYml0LCBsb2FkX3VuYWxpZ25l
ZF96ZXJvcGFkKCkgZnVuY3Rpb25hbGl0eSBpcyBwcm92aWRlZCBvbmx5IGZvciBjZXJ0YWluDQph
cmNoaXRlY3R1cmVzOiAgeDg2LzY0LCBhcm0sIGFybTY0LCBhbmQgUG93ZXJQQyA2NCAobGl0dGxl
IGVuZGlhbikuICBUaGVyZSBhcmUNCmZhbGxiYWNrcyBmb3IgYXJjaGl0ZWN0dXJlcyB0aGF0IGRv
bid0IHN1cHBvcnQgaXQuICBXaXRoIHR3byBtaW5vciB0d2Vha3MgdG8NCktjb25maWcgZmlsZXMs
IEkndmUgYnVpbHQgeDg2IHdpdGggbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGRpc2FibGVkLiBN
YXliZQ0Kd2l0aCB0b2RheSdzIHByb2Nlc3NvcnMgdGhlIHBlcmZvcm1hbmNlIGJlbmVmaXRzIGFy
ZSBwYXN0IHRoZWlyIHByaW1lLA0KYW5kIHJ1bm5pbmcgd2l0aCBpdCBkaXNhYmxlZCBpbiBDb0Nv
IFZNcyBpcyB0aGUgYmV0dGVyIHNvbHV0aW9uLiAgRG9lcw0KYW55b25lIGhhdmUgYSBzZW5zZSBv
ZiB3aGV0aGVyIHRoZSBwZXJmIGltcGFjdCB3b3VsZCBiZSBtZWFzdXJlYWJsZT8NCg0KSWYgZG9p
bmcgdGhlIGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBlbmFibGUvZGlzYWJsZSBhdCBidWlsZCB0
aW1lIGlzIHRvbw0KbGltaXRpbmcsIG1heWJlIGl0IGNvdWxkIGJlIHJ1bnRpbWUgYmFzZWQgb24g
d2hldGhlciBwYWdlIHByaXZhdGUvc2hhcmVkDQpzdGF0ZSBpcyBiZWluZyBlbmZvcmNlZC4gIEkg
aGF2ZW4ndCBsb29rZWQgYXQgdGhlIGRldGFpbHMuDQoNClRob3VnaHRzPw0KDQpNaWNoYWVsDQo=
