Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3153719FF2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjFAO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjFAO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:28:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63445189;
        Thu,  1 Jun 2023 07:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6k+JODIpEnPwBnjev+1Gs4rjXvuGBeF7a6A+hE95DzkrR+wH+DjgwHwod/H6MwwiZ7idba1zlwqaorNjouD2YIx9H6+3kFH16mCFf1/wgQofYL+3f9dFGFjpm7BtxRRzRk9Kn9LhEXbi3TkZBv4pkxGjkZtrdXrrCbVim0Jvp8dkBgJRYT6EkwCxNRDGtzDbb1BVLa4ebiQ3/+2U7vSYUdlqQ8ESvZjmJyYe9l4sm3H2ZsajAM6KuIvbf3h25DAi22vn5FTxyHxuL0Wln9IflWbdCQnnfFgPzXUzb8W9bZ71EPdMvHp0Z3p9S77FFWEK5vGXVqi3zbrfWi3aq0usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSCq8PHvcWRXeuKYSQaTjuluATQLsLYEUggCXbJj3PY=;
 b=afgTMRX1/D+jTa0IppJOuRL2Vo4ypqWAYJKp0Xrfxpn2hf8t9g0FaG2eUdXOF9qbkmAH1477yWLJ6UQETDZks/4ATctLpiYndwCVeK4wdk5zHps7Rsw/x1VqfZ4co9kBJReoTm9pAUN9xT48I6Wzi49WyuduDEFUKNwsOXueADoeK62tp89Xj+TIJZSzZqgC4yMVLe+fY/jmC272GUQybFSeGVxnMLowE+eSfSdK3zg2UhHXx9244uZTITTS/KxXxTaJMMuvDW9/RuuQfSZUK7pDNyBO+nNt2gTZBBdjJl5FnY3kjjZ4ZoH644jvNx626tPUH+DPSxXLoLXTEjk94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSCq8PHvcWRXeuKYSQaTjuluATQLsLYEUggCXbJj3PY=;
 b=B+UJeuB0pBiCZnLdfVj17OcH/ewARnHni7hZ4JOVOy85TO+6q5gCj/lwIUt9Vv/H11nRQ+7WwB05y+2pXVccj4E+Yq8eJ6Xum+yblyDpTAC9WFke3noV4oW0eJUbSPcYYOWjeMD+uLJElI67oQyRi+iRO2cl8MpY21JpXDpvmuIXvA9rzgUBJThnEFx4H72WQYLGremgHbBohzLliH3+mUqS10esbW8GC7MAkifIGo3x+NuA6JjyA9WnJTHFfddTXQH8OoT2stqOKp7ODx1Ne6iXGx/7NKHMNcHwYUKBCxnnc7HPZY5f5W/yyoSMY92Z3097iNsWJEkLG4lf03ggzw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by IA1PR10MB7538.namprd10.prod.outlook.com (2603:10b6:208:44b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 14:28:06 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 14:28:05 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "michael@ralston.id.au" <michael@ralston.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix "cannot set freq 48000 to ep 0x3"
 msgs
Thread-Topic: [PATCH] ALSA: usb-audio: Fix "cannot set freq 48000 to ep 0x3"
 msgs
Thread-Index: AQHZlIqVywGBgPuStUSeT/ugy2IRmK92AXUA
Date:   Thu, 1 Jun 2023 14:28:05 +0000
Message-ID: <202bbbc0f51522e8545783c4c5577d12a8e2d56d.camel@infinera.com>
References: <20230601131116.1014250-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20230601131116.1014250-1-joakim.tjernlund@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|IA1PR10MB7538:EE_
x-ms-office365-filtering-correlation-id: 1112e550-d6a9-49e8-40d9-08db62ac6a2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWAXPoVX1PWY0bRzgxY8br82xVJ/+TnATo3wVnPjVyHUHPEb2whP++L7Y2REi9qaSDs0BsAw7AJ8gCTZnrXOsmpStzmBB5BoJL5tguleb4thCyjF4iCI2YX0k1dgvwYIBQN5lIhUUojWj+Oyh8MKUvGxsgHESI5anUOQ9lamhJGPCc+fxSWyvUaq8U5Q2xOgI7FPe/QB8a/6sOu1uyvWdsafpvn9J625G7PwKB3E+D/TOKRQ+Le+Pir/887/dY1dHK1eUQZwc0gieRGpUTrgiITIUO44/66ikuwYffRbTDw/Q7/dAKeIpIPKUME7ml/oy0t7qd5TcGZmKE1on0clRYEiVciDj3luH93JNrWgVT5mntI0QXX+0X7LDgcJumJnf3QH4GIO76QKdDzM9zvOMFbIPu+5euBMOqnVY6whZ26zwJh/RwryjUJ8aauAKjOXwaUSbAP8lWwqH4WirkK+tRyFGbWoz1epdF8qL3p64Z6JinojFXB7efo67bnGyUF4bIIq8UUnTKHzmDuAAcQFi1qJ5NT+RwtJDejazVEiDFXZ598mdQxsGKCebyL1GeLKF0z4VaDpxZVUPai9rQ8F8Z+pfPVMRmmMTikQelsS28dJpnofaCmFAxUlNPvATa1Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(186003)(38070700005)(66946007)(66476007)(66446008)(91956017)(64756008)(76116006)(66556008)(4326008)(36756003)(2616005)(6512007)(83380400001)(86362001)(2906002)(6506007)(8936002)(8676002)(5660300002)(38100700002)(6486002)(478600001)(41300700001)(122000001)(71200400001)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmRWb3gzTFJBRGFEVThnMkNacjJtbTVnTjYzMmxKRUQ4NGR1aVN4RnEwMFVh?=
 =?utf-8?B?SXJqVXp4STl3M2x4NGpkM0grNi9qRXE3L0NoMytPbERuZUZNNlRQVWNqL2VP?=
 =?utf-8?B?WEptMUd3QkJ2bS9HRXZxbjJUQU54TWdXaTRZeXpubW5IbnVzUkdoU3dFM2RV?=
 =?utf-8?B?eklOK1BxOHFHVGZJaWFuTHhjaXUxQXhuWUQxRS9seDNaREpvaE8xNk9RbGVG?=
 =?utf-8?B?dUxtNVI4Z0EyN0tBSEVEZzQxUCs5VitzbUlCT1VnQjJwTitoMVc1WjlUU0d2?=
 =?utf-8?B?eEZGNDdKbXBncHBmL3Zab3NPckpEc3ZIL2dtTTdTVXFBK3dGanBTY040OEtP?=
 =?utf-8?B?V25qUGtBc1RSUitQbzZ4cmhKQ2hjU29oZlc5QWxsV1ZXUEF1YmdTOGZXVGRr?=
 =?utf-8?B?ZUZrMSt4RG94R0p3MDhMQzlpZWd0TzVsQmltMjV3NUpnZnFoVmtOTFVWZm5m?=
 =?utf-8?B?dUNIUWs3cGFJdU54bk1PbXdmODlQUWxTdWxLYXc1VXNQb1l6NVp1UVQvWEhC?=
 =?utf-8?B?ZlVuNXFzcDNHblZaOFVTUmJITTN0NDVWTTE1K2JiMmNlME5YVSt6VGJpK3JY?=
 =?utf-8?B?dDBjRVZvRExocWNyRTM2elh3YzlJT1ZUelVENWxjWTNNTEJNRWh5eURWZkwz?=
 =?utf-8?B?NDBlN3VCQWlnekRQK1AzZmZpeUE2MFlGMW15V0VGYThZUE9TK3BXUHJBWnBO?=
 =?utf-8?B?MGZoMTBsR3g0aDNLakh0d25ORXZRYnN0ZXdPVzQ5T0s0d0toakh3V1NZNllO?=
 =?utf-8?B?RExyZWlWSk85a25TdFFqNktUeWtHeWFYRDRzem9kZXVnMDNrNEtQQnBRcjNG?=
 =?utf-8?B?S01kRDcxWmoreE90elRDV0h1czBveXFYTVhRREtQS3ZxUG4reHhsZjJ4SDh0?=
 =?utf-8?B?Zk8xakJCNkxBKzdWcFZnZTFQdlBNVFFaY0hqMGJSaXpBYkI4dXB4QnB4aWpl?=
 =?utf-8?B?T1JpWVl2K2d6V0ZOYS9TUmc4TGxnb01KUUo5bUNQT0NaN0hJZXZLZHViSjJw?=
 =?utf-8?B?Y0pvR1RzQkV2VURsQmI4VmdZcXFORDliRm9MS2k2WVJxV0hOOElKaDhxeWdG?=
 =?utf-8?B?a05NTGYvKzVIajlZWDFrSG9wZ3BkSUo1RkdZK1dvRmlrdlp0blhGcjZOMkRo?=
 =?utf-8?B?OExMaElDNVhJcGFQUUVES1pZQjllWjhoM0JpOC9HaERmNTd1a3h3ckY4b01y?=
 =?utf-8?B?dXpqNjJNNE9wVmxaVTI1cGZGaVdXNHFSMTFnVmFKaUM0aFpINllmdndubkUv?=
 =?utf-8?B?b3l5M24vZFFOUkhCckxNakZlS1prOXZERWlkT2xBN2FvNmE5aGQ1V0tjUWJn?=
 =?utf-8?B?QUFOdytZVkp4WFZiNHlmd2NUb1lodTk3disrWEpzcHp5QkZKTk9ZdHM2aVRn?=
 =?utf-8?B?T1oxSG9PT0lzRDRZcW9PTTFTUEV0WVd3czlGc1k1ZUQ2ejV6N0o3dVlCUDY1?=
 =?utf-8?B?Q2FFT1QvdEQ4bitaQytVQVByU0xNaXoxTnZIWVNRN0ZhUUFQSUE5Z1E2Y0xQ?=
 =?utf-8?B?YzQxdHB4SHRKaHJQUmdWR2tlVHZGcEFhSXh6bCtZUzJycFJ4Wk8yNWIyblAz?=
 =?utf-8?B?dnZuTjV4ZVZOSS81eTNUOFNqdjVMRUJlMlFKZzRrWERSdG5XWm9meVpqWkdI?=
 =?utf-8?B?WmE3YThZVXRlWUI4Q0V3a0lUVC85T0d3UnpIUFdHNmRuQnN2bnpONTBYdUlj?=
 =?utf-8?B?S2tFZ0FNMUw3ZS9CeEFlSDFEY3BuUXZWZmQ4T01xWnhBN1phRjlhelMrOVBh?=
 =?utf-8?B?djhUaUR1Q1ZzZ05TSDFZd3pEMmRkRk9CSDlYY2NhNitjUlliWGVzOVRueU9Q?=
 =?utf-8?B?TkNHTG9FamZRWWorc1lkNThWVlp4aHBuZTJlR2hLSkVIMnRrdzhkYWg2VDgr?=
 =?utf-8?B?ZkQ1M3ViaUtPeThYZTVRZTFhZ0YzWTFnZ0NYQ3VGeExuQkVBVjBYQVREZHVL?=
 =?utf-8?B?dSswUDNmZmRmbjBhMVhpOFBlTExUR0l0M3NWbVB2c3BjekwzQXROamlNdFkx?=
 =?utf-8?B?NDZwMXZScVNjSDNGcnplL2FRU0lsaHl1eW5nNnkyOWJjVVM0NnlVRTNPYUFK?=
 =?utf-8?B?dWExN2owajNON1prc1dSU1R1dlRTL050WG16c0NPd00wR0tobW9sbUhjNmoz?=
 =?utf-8?B?UDUxZ2prYkI1UHpkWHN6YUkwUzlPTVBBdmZ3eFNkbVhRTDhFNGRwS0wvN1hz?=
 =?utf-8?Q?b9dGHr6YN8VLmIcu6qONzm5GsSwGL0+JQPGtreQH966X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04BF16871710AB4792CDAFB6D0B339B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1112e550-d6a9-49e8-40d9-08db62ac6a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 14:28:05.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3P+uqPzoMPca8iAyz0OEmyI4cwe9f7DiGCfnEq+wVrn/+ZhG+FwhjHY8Lakg3VWseXCyovRUhYYcij6MigWkTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIE1pY2hhZWwgUmFsc3RvbiA8bWljaGFlbEByYWxzdG9uLmlkLmF1Pg0KDQpIZSBkaWQg
aGF2ZSBwcm9ibGVtcyB3aXRoIGhpcyBiZWhyaW5nZXIgVU1DNDA0SEQgZGV2aWNlIHdoZW4gdGhp
cyB3aG9sZSBzZXEuIHdhcyByZW1vdmVkLg0KUmFsc3RvbiwgY2FuIHlvdSB0cnkgaWYgdGhlIGJl
bG93IGNoYW5nZSBhZmZlY3RzIHlvdXIgZGV2aWNlPw0KDQogSm9ja2UNCg0KT24gVGh1LCAyMDIz
LTA2LTAxIGF0IDE1OjExICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOg0KPiBPbiBzb21l
IFVTQiBzcGVha2VyIGRldmljZXMoSmFicmEvTG9naXRlY2gpIHdlIHNlZSBhYm92ZSBlcnJvcg0K
PiBtc2cgd2hlbiBjb25uZWN0aW5nIGRldmljZSB0byBjb21wdXRlciBhbmQga2VybmVsIGlzIHBy
b2JpbmcgdGhlIGRldmljZS4NCj4gDQo+IE1vdmluZyB0aGUgc25kX3VzYl9pbml0X3NhbXBsZV9y
YXRlKCkgdG8gYWZ0ZXIgdXNiX3NldF9pbnRlcmZhY2UoKSBtYWtlcw0KPiB0aGUgZXJyb3IgZ28g
YXdheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVy
bmx1bmRAaW5maW5lcmEuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0N
Cj4gIHNvdW5kL3VzYi9zdHJlYW0uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9zdHJl
YW0uYyBiL3NvdW5kL3VzYi9zdHJlYW0uYw0KPiBpbmRleCBmMTBmNGU2ZDNmYjguLmQ5YWM4NjYz
YTQ4YiAxMDA2NDQNCj4gLS0tIGEvc291bmQvdXNiL3N0cmVhbS5jDQo+ICsrKyBiL3NvdW5kL3Vz
Yi9zdHJlYW0uYw0KPiBAQCAtMTIyNiw4ICsxMjI2LDggQEAgc3RhdGljIGludCBfX3NuZF91c2Jf
cGFyc2VfYXVkaW9faW50ZXJmYWNlKHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLA0KPiAgCQkv
KiB0cnkgdG8gc2V0IHRoZSBpbnRlcmZhY2UuLi4gKi8NCj4gIAkJdXNiX3NldF9pbnRlcmZhY2Uo
Y2hpcC0+ZGV2LCBpZmFjZV9ubywgMCk7DQo+ICAJCXNuZF91c2JfaW5pdF9waXRjaChjaGlwLCBm
cCk7DQo+IC0JCXNuZF91c2JfaW5pdF9zYW1wbGVfcmF0ZShjaGlwLCBmcCwgZnAtPnJhdGVfbWF4
KTsNCj4gIAkJdXNiX3NldF9pbnRlcmZhY2UoY2hpcC0+ZGV2LCBpZmFjZV9ubywgYWx0bm8pOw0K
PiArCQlzbmRfdXNiX2luaXRfc2FtcGxlX3JhdGUoY2hpcCwgZnAsIGZwLT5yYXRlX21heCk7DQo+
ICAJfQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KDQo=
