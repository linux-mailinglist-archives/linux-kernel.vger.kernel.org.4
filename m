Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5489B688D69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjBCCxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBCCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:53:41 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012000.outbound.protection.outlook.com [52.101.63.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55EED503;
        Thu,  2 Feb 2023 18:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxhpFTIhDN6ueyjpzFb72yML8YpLcwa0b0CRHjhcVw+W3Rezt0sLiQF74nR6vM3mI2gnAEH46AEvMTo87+2GNiMmBl/s59YVa91wFzd6VmI46/vbAVvm1j/vorl6e6/hDc2zkR7YHKNiEV2o7DUJiAYN/2kc2OBxHZZuCMZh46kHV6bKYev+eYBmJ2jF+AD/PAldzmTaBdJsz44uR4kKJDL+/m8j9eK8HAX7mV5+6TQ+oXuQakRxs1fsgfCqFy9L5TJ/Fldv7px0QiwZEOinsuGHCwxWpcEIqWMAiJ9q4PgZAQH7OgOzvnjpIuX71E+99N2tnRQAe5lu4hqd7DEuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouxAhazGc9TgvmHRi3OxesFxBgmFAwr0dk6z9AwW4xo=;
 b=E6GeQQbPHHFnyY0S+5No223xfjAtWF5QgpbIn534nW4gGEclvMziatapvw+sjVciY6v+ObhWqkr1qotEjZBUpeJYbiyNIlDMU3y3GdX2EF6eDQ0suI7NeEFBqcvbUEAICAjRfbUxfnl021LFu7aYq10ZU+VuHp/pWoQZyNKfCfeEmh2D/MsGckltoyS+JJpO8W8QrcVZWtTSeXBk5Up3MU1z9of2/b/lJUAzalqUdf3Q4GmmoQ3hVsA0o0bJVljoWvnBiIH7mX5VuC3r9upATf0h2rpVc3gYJZzrSyqvC5/C2Sls3alOgEvSvC+gQy9KkiTsKg1z92dWzLqgXcVoYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouxAhazGc9TgvmHRi3OxesFxBgmFAwr0dk6z9AwW4xo=;
 b=FmPADDNc+6wJoE2Ubrj38tQ+1dNo97Vh9XsMDbO24Q4NcJXFrOAMu25Rdl9kJqcCxR3Cf3RDYDY+s+TTJ23t0IFABLCXq+O/6XYUd5b4oEYfJLNiwhZoKFXIGZl9Oemw1HhWDoLqxmZaZGni38zfTA3eXVUR2Wv0grPfMqo742I=
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 (2603:10b6:610:155::10) by SJ2PR05MB9757.namprd05.prod.outlook.com
 (2603:10b6:a03:4c8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 02:53:25 +0000
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::ad2d:cb08:253b:26e7]) by CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::ad2d:cb08:253b:26e7%7]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 02:53:24 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Banack <banackm@vmware.com>
Subject: Re: Suspend with ps2 keyboard/mice
Thread-Topic: Suspend with ps2 keyboard/mice
Thread-Index: AQHZNrW7KJ5vtr9de0a88QyEj+Za8q67LSgAgAFayQA=
Date:   Fri, 3 Feb 2023 02:53:24 +0000
Message-ID: <9748c70b1e506f17ad986e4fe6b20a291a980205.camel@vmware.com>
References: <6d7b3cda248c7ca14d6fb3c8fbd49345306ae46e.camel@vmware.com>
         <Y9tUPM/UV1quMebq@google.com>
In-Reply-To: <Y9tUPM/UV1quMebq@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR05MB10206:EE_|SJ2PR05MB9757:EE_
x-ms-office365-filtering-correlation-id: c9aa637b-3d7e-4358-8e58-08db0591d195
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rq0OOR4zEAXvdV5nbwtaxfonFMUGc+F82KeQDQaqYbIBpHEz/JzpgXZkmvxJMv0D5/AJ6vj2PCBzZ5JcnDHImrh7loPCs891yT6jpP1qz1LoTuRYJ1e85Wx7CkuHyH7sHdJZrAG3FAdfAwaQzKk/ubgpHGk7vlzY8MB4vMJ8bEZ50FqyzX4eV87qqV1Ej7nH5LTpb3iQ3WHJGHOyfflysxfDKxjumuw6x0hwzNsD7NtvcsvGdqgbwVrBooHSQll3YIga8NE8LElE0nCcFSnHxw8do/JgdRztHexcMyAHVxaLD7luJAOnXN8/33XCWF2odjSvIjnvUGRBZcmEOhcCQ0a0EGeYnubacvgLaRK8JdWl888xiVWza2TleHSnJJlDcDLO0fysd02fPDuJ+XaU1XjboKcu5T3Mllgbktp7tQQI+ySo3nnY3pf9UJhVgv+tLhPFmGddgj9zim3FilqOD3BKQ6USWZXAuZNGj3aRxGapRDhQx3wagwFb5S9/jamLgp6f1DtTjX54gN8juNnb1dlbOXECl/CblorSWJZZtUeBYvxkELAFWQTOV1Vk3rnEx1Km0M/H+9hmYtKfehrc4Ph4B2stZ/4k3X6gp9ie9JyMJ4uBz+gyLhszaJhChTF2tioMNE8Kwn/Mon2+gIDe6Lj4uPCzs9bWhlD9pbgGZ+pAtKmknersMFkoM9RnV4cM2nEh3FXjUTO+17pBB28VDDV1J7T4+zJVgEmJo8q8Q++IWRuKEdHtegPiGXfECDm8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR05MB10206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199018)(38070700005)(122000001)(38100700002)(76116006)(64756008)(71200400001)(66556008)(66446008)(4326008)(91956017)(41300700001)(66946007)(6916009)(66476007)(8936002)(86362001)(83380400001)(2616005)(186003)(107886003)(6486002)(478600001)(36756003)(316002)(8676002)(54906003)(15650500001)(6512007)(26005)(6506007)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEJYeVArQzZmZkNqbnNYZHZwVXIwelN1bW8ydjNpVDYyL3dCc0tyUE93Y3lP?=
 =?utf-8?B?VXRQeVNwYnVGOWJqV3ExaVRNRnZaN1NWMWpBYjhFYlNNMUpqSlFCdzkvWExN?=
 =?utf-8?B?cHlPakVVYW1TN2pWYjlqNGN1ZlFVM1BrWG50ZHlGMnpyZ1BHamJwWWNic1FK?=
 =?utf-8?B?eXNPY0pNMHB6dE80TWd6dUNBK1ZQZk5OWjlnaGU1ZEljUTZnZTd4bFRYYVp3?=
 =?utf-8?B?T1MwTUZML0svNmJTaU9tQmE2K28vVmg3RjJVdnUvVVRiQ092UXdwaitYNmtn?=
 =?utf-8?B?ZVZZTDg4WG9ldzFiZjExVUYwdy9VUndtekNodWNnSmpROUpncXNuY0ZYVWkv?=
 =?utf-8?B?L25tY2dGV0hWclJUOUdweUlCLzczUG94UE84ci9qQUpiNlpBcU9DdmRZTS8z?=
 =?utf-8?B?OWNwbVczUmo0dFAvbTNjYnBNNkpJN1hNSXdVbHY5RTBFUTJQdU1xUjRDWnhF?=
 =?utf-8?B?VXVEL0ZxY3NBL1NKSWJ6T0JyNU9vSERQVjVwb1lxUWJIZGZxM0tyczRIV3ZE?=
 =?utf-8?B?YllaUUt0MENzRUJQZGluY3Zab3pxWHROQVNZYnNRaUIrOUVRekNadzVOZVRr?=
 =?utf-8?B?SlVmZW55WHpsdGswNDVWUTQvZlZrVjQ0SkdBTVFEbGtmREwzdDhmZHBhZXpv?=
 =?utf-8?B?THRRK3hwNC9ieldVMW9JRy9CZm5XRGozWGMxWU5ja2k5TmNqd0poNGVvRDZW?=
 =?utf-8?B?Y01qR0hjckRQcHlubTIzcHhEeTRSUDBBZGsxWUpXV2hxRGc2Nmk1TFg4anNs?=
 =?utf-8?B?ZVJkcWhlRVp4a2hibHkvSG9hOUNjbWVIWjNZTythSnNGWkUrcStOczE3OEhj?=
 =?utf-8?B?NFFRcGJXb3BJTEV5dURvSVBIaVkwTVdnbGs1ZWk2OGE0WGx3OXZkZHZDQlZO?=
 =?utf-8?B?aENTUzgyazVWY1BBbnV4MzhNTERSV1M0WTdxcmg2Y3NoZ0R2bFV1NmRrWmFC?=
 =?utf-8?B?bjV2cVduNGxSUHE3RnFoUFJyQzdxazJhM0VHL01jRTIvdmpqTk52ZE1rT09B?=
 =?utf-8?B?OTdFUTM1YWVuMmZnL0JpOE4wS0J3eFNNdCtUdHFEVFJaVVpuVTFCdE0xN0x3?=
 =?utf-8?B?SkEvUWlIR2ExdEh6bzZ6RE5QVGpkUWIrVkMrZTVWNUtWRW9tam4yM3l2VUFU?=
 =?utf-8?B?ZVBCTVdMVXdCSmNMa0p2RGJFMHRmazgxZFpGUHFHSHh5ZG9nMUdjaUlyNlc0?=
 =?utf-8?B?VDh4NURtd3pYcDUxbmtleXdmeUVkb29XTWRJeHBRUG1wdDNJaHpmSGtENFBO?=
 =?utf-8?B?cG5BY3N6Yks0cTl3cDVzU1A4OUROZGRZQnllS3A1OEU4UkZrM25kOHF0aTcr?=
 =?utf-8?B?ZWIzQkxDenRqMHJVQ3VaMnJCUXQ5dkhrYjU3b1pKaVNrQU1YbmFROThKWXl2?=
 =?utf-8?B?S2w3OU4yTzhXTmo3S1FKK3lMWWhJcTRhZGhEa1RPU2lOLy93Nm1MbU5qZzJs?=
 =?utf-8?B?Vm43a3RvUGh6TlRBbyszVmlScXgyZ1hoRlJwajZkdkpkMTdlUFZlSGozbTgr?=
 =?utf-8?B?dy90MFU2MktSZENxU1llYk95NTZsdzNmU0lqUXIzTG90WHRJVndSMU04RXpH?=
 =?utf-8?B?aFlNdzU4WGhjRFYzU0k0dWZ6S0JYcSt3T2R0MEo4YlVkbEZtR29wVGVTK0ZZ?=
 =?utf-8?B?c3Mwa1VBSjVnMUdLdlhhdjR2WFRMUEVnRzVHWFBRK1QzZ0J6NkZmMHhQb2ho?=
 =?utf-8?B?SjRpUy9tTHBiNXUyZVpHOUwxVzNrK2gwUzM2ZEc1czdDK2cwVzRZcFF3QlVp?=
 =?utf-8?B?dWFDOWxEd1FLbVZ2a01nYzBEOFNWa2NsSFhKWUdkRkV1WDlQTEVVcXplanRB?=
 =?utf-8?B?TmNVM20rOXRXM2VQUHpUeE5KN1ZYUW85Vzd3TVMwait5ZlpjY0JOV3BML0Nl?=
 =?utf-8?B?UWVSQlhYZjNPK1ZsS1NJekxFSEx3ckc1OXBRUkRkeXNudmFkSHpDQVpWeVpL?=
 =?utf-8?B?eVVGeUpySW1VQmEzZlY3UWFoNlVhV0p4TURMUXF3Rk9CS05xdytiRDJ1WUR5?=
 =?utf-8?B?MlUxNUNpeGlnbi9UNmd3QUthNkhUeHozOWFhZTF1S1RHWWJHY21GQ3NPQm5Q?=
 =?utf-8?B?clNpNS84MmJvVWRuZXZ1VFZab2RxV1lHbVZRMGhDU2dWLzZJQnpNaEVwNTB4?=
 =?utf-8?Q?FxyvUuc1ifF9gO1mR6MuNyxUi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F745EF9BFB4DC4F9F7499FC0D665B98@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR05MB10206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9aa637b-3d7e-4358-8e58-08db0591d195
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 02:53:24.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmj/gPQUVHko/gAr3tyF5dc3dkjlsxvT1MS5+DFz6UgcqJ3ohyj15VDZLuB/E7CkiHl3sZ9MfGJYvz4DKOKq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB9757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTAxIGF0IDIyOjEyIC0wODAwLCBkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAwMiwgMjAyMyBhdCAwMzoyMzozNEFNICswMDAwLCBa
YWNrIFJ1c2luIHdyb3RlOg0KPiA+IFNvIHRoZSBrZXJuZWxzIGk4MDQyIG1vZHVsZSBzcGVjaWZp
Y2FsbHkgY2FsbHMgZGV2aWNlX3NldF93YWtldXBfZW5hYmxlIG9ubHkgb24NCj4gPiB0aGUNCj4g
PiBrZXlib2FyZCBwb3J0LiBUaGVuIGJlY2F1c2Ugb2YgdGhlIGExY2VjMDYxNzczOCBwc2Jhc2Ug
bGVhdmVzIHRoZSBtb3VzZSBlbmFibGVkDQo+ID4gb24NCj4gPiBzdXNwZW5kIHdoaWNoLCBpbiBj
YXNlIG9mIGEgbW91c2UgbW92ZS9jbGljayByaWdodCBiZWZvcmUgdGhlIHN1c3BlbmQgbWFrZXMg
c3VyZQ0KPiA+IExpbnV4IHdpbGwgbmV2ZXIgd2FrZSB1cC4NCj4gPiANCj4gPiBUaGF0J3MgYmVj
YXVzZSB0aGUgZGF0YXBvcnQgd2lsbCBiZSBlZmZlY3RpdmVseSBsYXRjaGVkIHRvIHRoZSBtb3Vz
ZSAobW91c2UgaXJxDQo+ID4gd2Fzbid0IHNlcnZpY2VkIGluIHRoZSBndWVzdCkgYW5kIGl0IHdv
bid0IGJlIHBvc3NpYmxlIHRvIGRlbGl2ZXIgYSBrZXlib2FyZA0KPiA+IGludGVycnVwdCBhbnlt
b3JlLCBhbmQgbW91c2UgaW50ZXJydXB0cyB3b24ndCB3YWtlIExpbnV4Lg0KPiA+IA0KPiA+IE91
ciBzdWdnZXN0aW9uIHdvdWxkIGJlIHRvIHNpbXBseSByZW1vdmUgdGhlOg0KPiA+IHBzMl9jb21t
YW5kKCZwc21vdXNlLT5wczJkZXYsIE5VTEwsIFBTTU9VU0VfQ01EX0VOQUJMRSk7DQo+ID4gYWRk
ZWQgaW4gYTFjZWMwNjE3NzM4IC4gSSBkb24ndCBoYXZlIGFjY2VzcyB0byBIUCBueDc0MDAgZnJv
bSAyMDA3IGJ1dCBpdCBzZWVtcw0KPiA+IGxpa2UNCj4gPiB0aGF0IGNvZGUgYnJlYWtzIGV2ZXJ5
IG90aGVyIHdlbGwgZm9ybWVkIHBzLzIgY29udHJvbGxlciB3aXRoIHN1c3BlbmQvd2FrZXVwLg0K
PiA+IA0KPiA+IEkgdGhpbmsgdGhlIHBzMiBtb3VzZSBoYXMgdG8gYmUgZGlzYWJsZWQgb24gc3Vz
cGVuZCBpbiBvcmRlciB0byBiZSBhYmxlIHRvIGdldA0KPiA+IHRoZQ0KPiA+IGtleWJvYXJkIGlu
dGVycnVwdHMgcmVxdWlyZWQgdG8gd2FrZSB1cC4gT3RoZXJ3aXNlIGlmIHRoZSBtb3VzZSBpcyBz
dXBwb3NlZCB0bw0KPiA+IGJlDQo+ID4gcmVhbGx5IGVuYWJsZWQgKGJ1dCBtb3VzZSBpcnEncyB3
aWxsIGJlIGlnbm9yZWQpLCB0aGVuIGhvdyBkb2VzIHRoZSBQUy8yDQo+ID4gY29udHJvbGxlcg0K
PiA+IGRlY2lkZSB3aGV0aGVyIHRvIHJldHVybiBtb3VzZSBvciBrZXlib2FyZCBkYXRhIHdoZW4g
dGhleSBkbyB0aGUgZGF0YSBwb3J0IHJlYWQ/DQo+IA0KPiBJSVJDIHRoZSByZWFzb24gd2UgbGVh
dmUgbW91c2UgZW5hYmxlZCBpcyBiZWNhdXNlIGZpcm13YXJlIG9uIG11bHRpcGxlDQo+IGRldmlj
ZXMgd2FzIHVuaGFwcHkgaWYgdGhlIG1vdXNlIHdhcyBkaXNhYmxlZCBvbiBzdXNwZW5kLiBJdCB3
YXMgbm90DQo+IG9ubHkgbng3NDAwLCBidXQgb3RoZXJzIGFzIHdlbGwuIEkgYW0gbm90IHN1cmUg
aWYgbmV3ZXIgZ2VuZXJhdGlvbg0KPiBkZXZpY2VzIGV4aGliaXQgdGhlIHNhbWUgcHJvYmxlbSBv
ciBub3QuDQo+IA0KPiBSZWdhcmRpbmcgaW5hYmlsaXR5IHRvIGRlbGl2ZXIga2V5Ym9hcmQgaW50
ZXJydXB0OiBJIGFtIG5vdCBzdXJlIHdoeSB5b3UNCj4gYXJlIHNheWluZyB0aGF0IEVtYmVkZGVk
IENvbnRyb2xsZXIgKEVDKSBjYW4gbm90IHJhaXNlIElSUTEgYW5kIElSUTEyDQo+IHRvZ2V0aGVy
LiBBbHNvLCB0aGV5IGRvIG5vdCBoYXZlIHRvIGJlIHdha2V1cCBzb3VyY2VzLCBJIHRoaW5rIG9u
IHNvbWUNCj4gZGVzaWducyB0aGVzZSBzaWduYWxzIHdlcmUgd2lyZWQgdG8gb3RoZXIgcGlucyBh
cyB3ZWxsLCBhbmQgdGhvc2Ugd2VyZQ0KPiBhY3R1YWxseSBjb25maWd1cmVkIHRvIHdha2UgdXAg
dGhlIEFQLg0KPiANCj4gQm90aCBtb3VzZSBhbmQga2V5Ym9hcmQgZGF0YSBhcmUgY29taW5nIGZy
b20gdGhlIHNhbWUgZGF0YSBwb3J0LCBzbyBpdA0KPiByZWFsbHkgdXAgdG8gdGhlIEVtYmVkZGVk
IENvbnRyb2xsZXIgdG8gZmlndXJlIG91dCB3aGF0IGRhdGEgaXQgd2FudHMgdG8NCj4gc2VuZCBm
aXJzdCwgYW5kIExpbnV4IGlzIHVzaW5nIHRoZSBzYW1lIGludGVycnVwdCBoYW5kbGVyIGZvciBi
b3RoIElSUTENCj4gYW5kIElSUTEyLCBhbmQgY2FuIGRpc3BhdGNoIGRhdGEgYXMgbmVlZGVkLiBC
dXQgeW91IGRvIG5vdCBuZWVkIHRvIHJlYWQNCj4gdGhlIGRhdGEgdG8gd2FrZSB1cCB0aGUgc3lz
dGVtLiBZb3UganVzdCBuZWVkIEVDIHRvIGFjdHVhbGx5IHNpZ25hbA0KPiBpbnRlcnJ1cHQgdGhh
dCBpcyBjb25maWd1cmVkIGFzIGEgd2FrZXVwIHNvdXJjZS4NCj4gDQo+IEkgdGhpbmsgeW91IHNo
b3VsZCBsb29rIGludG8gaG93IHlvdSBpbXBsZW1lbnQgRUMgYW5kIG1ha2Ugc3VyZSBpdCBkb2Vz
DQo+IG5vdCBnZXQgc3R1Y2suDQoNClRoYXQgbWFrZXMgc2Vuc2UuIFRoYW5rcyBhIGxvdCBmb3Ig
Z29pbmcgb3ZlciB0aGlzLiBXZSB3ZXJlIGJlaW5nIG92ZXJseSBjYXV0aW91cw0Kd2l0aCB0aGUg
SVJRIGRlbGl2ZXJ5IGFuZCB3b3VsZCBub3QgZGVsaXZlciBJUlEncyBvbiBQUy8yIHVubGVzcyB0
aGUgZGF0YXBvcnQgaGFkDQpkYXRhIGZyb20gdGhlIHJlc3BlY3RpdmUgZGV2aWNlLiBXZSB3ZW50
IGJhY2sgbm93IGFuZCBjaGVja2VkIFdpbjk4IGFuZCBXaW5YUCB0bw0KbWFrZSBzdXJlIHRoYXQg
dGhleSBhY3R1YWxseSBkb24ndCBkZXBlbmQgb24gdGhlIElSUSBudW1iZXIgdGhhdCdzIGRlbGl2
ZXJlZCB0bw0KZmlndXJlIG91dCB0aGUgcm91dGluZyBhbmQgaXQgbG9va3MgbGlrZSB0aGV5IHBy
b3Blcmx5IGRvIGNoZWNrIHRoZSBzdGF0dXMgcmVnaXN0ZXIuDQpTbyB3ZSB3ZW50IGFoZWFkIGFu
ZCBmaXhlZCBpdCBpbiBvdXIgY29kZS7CoA0KRm9yIHRoZSBrZXJuZWwgSSB3aWxsIHdyaXRlIGEg
c21hbGwgcGF0Y2gganVzdCBmb3Igdm1tb3VzZSB0aGF0IG92ZXJ3cml0ZXMgdGhlIHNlcmlvDQpj
bGVhbnVwIHRvIGF2b2lkIHRoZSBlbmFibGluZyBvZiB0aGUgbW91c2Ugb24gc3VzcGVuZCBqdXN0
IHRvIGZpeCBpdCBmb3IgZm9sa3Mgd2hvDQp3b24ndCBiZSBydW5uaW5nIG91ciBsYXRlc3QgaHlw
ZXJ2aXNvcnMgYW5kIGV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGZpbmUuDQoNCnoNCg==
