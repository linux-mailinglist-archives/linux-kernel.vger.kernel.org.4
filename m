Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026461ED76
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKGIv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKGIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:51:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2313DC3;
        Mon,  7 Nov 2022 00:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM7kAwv+3p3i74fjhc1AtKtVYn6qi04ZKYAUx84iKQS07jS3ePh0hWVzCZmSWJdnxeh1jSpq1X09RlRBfHBVNE4EBgyFaQGVri3ryFEcZUXIeedPr9T17nDFwS2AqHsRpNFPNqR6gcYOyFW3jrzBLSRwUI4xGIGRtud0WyS/14IXvt7XXwgpnIgnCJU62f0sEM9VpHBW+pjGIaT/kwMR/T/lziMygpMdJh1P+VDsnxSvOtseMcUPB2Msa/VuaWySuF4IYZ7tH3SXxaflOUsSFJPmRrCknBeB2Jyww7fggfQlUdMvlDXrJQ1G/hbFizJrjgdT2yLCIN1m+0mcBEn1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBKiSQJ/y//AUJz3hdMxr1MwtQqGee+1U0YYW65d5bE=;
 b=DAW0UocSlq4bjzCyGitP0BG39XiWPr5NFoV1kTwhhuZZOhB5nQ/EQnAgUiJuyk/D6NNR66h4CW+SfAzyfBQOwA37qUlNaUeC1oKnCHGEANQDuqMv49b29xVJ5Giacl94B0ZUXKJKz0RP67njnVMnUKD1rpXnKuPV7BbLixgWBiTkHf+AO6z9S1iJ+U1dNi4xmHW3f/3m+kiMmyIXzt+0tKCi6SLjzoc2UOjLmEY62TI79aEvr6rwLMzwQDFwuF1vVcurAb3jgo+9Llbg9ksc01fVXJs0Xd9neSC3YWaUNw4X89r3j0r6Gq6nwnQ1nCECsiW0xPqLnyKEBsnHWWdzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBKiSQJ/y//AUJz3hdMxr1MwtQqGee+1U0YYW65d5bE=;
 b=vppmyd98jpAW+idB6rPhyQCLbEwSehIC+p0sIbS0zp+kXTuVKVOApBsTuruuOhS825dVabQEIMYDaBPlt4U5D+hQfPPPmKoQWaHjgwE2socwUD6jonhn2CftPNzO3VJFD4Sr/ZyzDaJLk4tXWYVALLDgFqPgquR+o0VHR6yIZRY=
Received: from BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 08:51:48 +0000
Received: from BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::2a08:67ab:536e:c9b9]) by BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::2a08:67ab:536e:c9b9%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 08:51:48 +0000
From:   "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "appana.durga.rao@xilinx.com" <appana.durga.rao@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 4/4] drivers: misc: Add Support for TMR Inject IP
Thread-Topic: [PATCH v6 4/4] drivers: misc: Add Support for TMR Inject IP
Thread-Index: AQHY72TxAHWGTNltH0aJyxKYflIDUq4tNFyAgAZU4QA=
Date:   Mon, 7 Nov 2022 08:51:48 +0000
Message-ID: <665d54dd-0c48-413c-d5b1-437c9b9596c6@amd.com>
References: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
 <20221103091500.3022212-5-appana.durga.kedareswara.rao@amd.com>
 <Y2PEXawGI/JhyaGK@kroah.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.50.21061301
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3527:EE_|BL3PR12MB6427:EE_
x-ms-office365-filtering-correlation-id: ae9e1f86-a117-4e0a-7664-08dac09d4e53
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7nzM5kBejFeBgiivoyfLlZswfq5d1upkFf/R/pChqfAZfEFLF0iXTAJaUlSoBT2ajylSvCZaDUGuBUwn6RaA1T305dj3EJJtN7wTLI+fJlaoWX29JSZ+nIrxVtEydCiLry+XVObnWT6DsvfWJqNWdGT50DjeNponcGvZcn6VW71d5D2Te32pzh5tLbUtfS/leRqNCCkeYFz0zC9trAHlaBiztcJKxkDYDAU33Ii4rGnBuh+hYU8MolfdxFLiHQX79lRQy/l2FPAtPh+LerjsRskHsLPj+Kf5U2JN7KxsFiQzFg678PVJSysGnkWLroJXzcwBO7KdxqgBEVVEOizCW2lcDwo1pN7hWoqb9Ri5pR0lF84upXMUsGJDAvqjWLvA35DiiB7KT3om3Z9Kg/UkJoFm0rIuB5k7B98Cua+cxuPEy5IZ+tXDKOaGBGG2F6rjBtXopVSZLsKH7A7kpQVRzTLdh5+GHezlUkDI6tuiu5SRDTpdJI/ElQbNwLTp9FaN+iiLBEkl+iwF61ypK7WaXqmB/IQNUfUlsK9MzyjaoyqRgg6lNwgasdtRT3KcUKztVSFxduXWR/GoGVb/nNcv7y19Y3c6sRt+virrW2XshouWHLpRzoYYCqvZn7qJp56ttU+CqpwESv3Wkopp2QUOqGqNub/YDFOvNCVgNhBIwU6k1ud/ulZlbNWOhB1nPFw2C4HiqYTxNU5f5ghVpOpfCEZwiGh8KzK8ils47fJ5nYv3gbHDdz2uWeTSjGnyWss39XEyo06TV8GaEASChyxJ+Z7x2wOvco8nSy5idlq4v0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3527.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36756003)(31686004)(86362001)(31696002)(38070700005)(83380400001)(4744005)(2906002)(186003)(38100700002)(2616005)(26005)(53546011)(6506007)(6512007)(122000001)(66446008)(66476007)(66556008)(64756008)(66946007)(316002)(54906003)(478600001)(8676002)(110136005)(91956017)(8936002)(76116006)(4326008)(6486002)(71200400001)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFMrZ0NOOEE0SnA5VDVtOVBmOVErRlFkdnJOUVNaR1VjMFhlOEszMDM5N1l6?=
 =?utf-8?B?Y1Zlc202M0Y0TjhER2l0dWdNMWRnaDYzRjNzRWtZVGxNUGgxS01UUTNYNGUr?=
 =?utf-8?B?US9EVGZQQW9HQmQ0TjVkUXdqRG9pMzQ0Z3BYL0RIRnNTM3kyRjROR3cvSytp?=
 =?utf-8?B?eFpYdjYrYU9RQ3dDazNvL3NJUXdqWFBRbEVPQWtiNzBndXAwcGh2MjJnTEgz?=
 =?utf-8?B?UE5QODFMVmJ2R0tKWEVMcDZQWVZuM2JjbmRKa2VNMWlvSjNPS3VVMDZFVXVz?=
 =?utf-8?B?WXBzTDdwTFpHd1ZjakR5SFpRVnZ2RUxvaTVON2Z3WWRsWVByNytZT2djMmtD?=
 =?utf-8?B?QTc0MjNsY2gxUGZ4dC8rLzBCKzVGQzIrdllyYjlmMWNjcjVkd3RJVGJNNUpx?=
 =?utf-8?B?TFM4VmlhcnpFVnV1TmdrNE9iVmJxYzNtbmdxSi9maGxQTUNwMHJRZ3o1VVE2?=
 =?utf-8?B?OHZhbDJLRFdHOURHMVdKL2ovdlhDYXo4YUJkMTc5Q3p3bW5JZ05yVzJVbzF0?=
 =?utf-8?B?S0JMWWZNcUNIUTNPbVF3d3F6TXJmUUY0OXc3ZnN5eVBNNG9MSmVHZHhlUXNS?=
 =?utf-8?B?NXpIcFZONHRaZW9FcVpEOXY0MmN0dHk5bGZ6RXVpOHJKQnQ2Rm1TN05abC9R?=
 =?utf-8?B?RkcwRjlkLzFYbno3N3E5eFQwWVhRS0NpWkFvR1F5bklaRURNZmxkMUJMM0N6?=
 =?utf-8?B?RXVWRzAwUVBXZFhrZndqRnJ6T1NiQW5PbG5oSnJFSVg4M0dZVy8wWkd1ZHgy?=
 =?utf-8?B?WktiYnk4TitucEtlL2xaTXlEMUwrVytxWDU5WHB2Z084ZG0vL1VnaGJOcklp?=
 =?utf-8?B?a0Q3aSsvZVNOQWRIOUpickYxYnZLdHhKLy9QWGZMK1Q1c3ZGVjdhWDJQS3lN?=
 =?utf-8?B?UWUyYUVtYW5rbGh2TGxVUFcxUU1wZHBMQTlJSUQ2aTRpdlMrSm9PWVp6T25E?=
 =?utf-8?B?ZS9pUWtDWkpCYUVrU3ZnclhadGxNbUtWWjhodXpiQmJQYWRWNnlWNUJValR5?=
 =?utf-8?B?WTB2NmRtY3pJWjZra0c0VjNTZDBaNnBGREZnTUlMYmdrWk8xV2Vray9NeVFJ?=
 =?utf-8?B?M1ZneVNDaWp5dGIzS3JyMkt5MWt0VVVHeUFmMUd5QUp2VGFIa3BjWFJTL2Ux?=
 =?utf-8?B?VHBpdkpzSzJBbTN2a3k2ZW5VZTdwV2tSaS9TblMzMHFHZnFyZllOR1JBNWJI?=
 =?utf-8?B?UXdJcWVCcU5lZDVtdklHZmppZytkVEQyNmw4ZnlvdjVvZk1HYW1yNWJZVzNm?=
 =?utf-8?B?akVhQTd1akZWWWgxNE9OSXB2SE9vQUJDRVQ3S3FnZFNJNWUvbzJNTHpiSU1S?=
 =?utf-8?B?K25hTGl5aElZUk9tMkxmaW9QWlNaeUMvN3loVXIveUN6VFViSEE4WHl6SWow?=
 =?utf-8?B?czBScG9oamNJcDZBRUxUUXZTY0ZUMERXQllGM1JaZ2Fjcm1KVEZyNDdDRkN5?=
 =?utf-8?B?Z1BHZUxFRytZV3l0Q3VSZDFOTmZqR1N0YkVlcFcrZUZDWTlaVGcvWEx4d21U?=
 =?utf-8?B?UENDd3VIaU84aUxrdkplSjFxS2JWZUhDeUM0dGJheTZnVzNTMnlSU0NUcGo2?=
 =?utf-8?B?NWkrSnZnZFNIaXUzRDMxSjNTS1hIZEhZdSs0anJ6YjFqckNKL05pSGZWS080?=
 =?utf-8?B?OEFYVlpQYjFGNldaQjBIM2FDUVR5TWdlSUhwclh1aDNBdXdTazZiSU1zM0tw?=
 =?utf-8?B?dWpYL3cyU1BVd3pwd2tLaVhGamtjU3d5TkFWQ1MxTjBaL3hTa1N1ZEhmaUJv?=
 =?utf-8?B?WFN1aE94czNvZ1dydFVtVlJrNE5pMFdVa0hqbVROUHZTb0NvMThBWm5vME1m?=
 =?utf-8?B?RmZMeHNxYXo1cFFDZWQrRnkzcHk2UGl4OUxzWlNPcUZCL1hCSGNOYm14bHBP?=
 =?utf-8?B?eWxQMVhha2J5NlRWY2NVbE9EODlseWZaSWtRNFhGajJzTzkrMWo4a2VScE9Q?=
 =?utf-8?B?NmIyYjBGQmhKUjdPT3FHM3FxK3VKM2hyeWJJWUo2dTc0Mlk1dWp2MlVGZDVn?=
 =?utf-8?B?bFdYb1NTbmlFRGN2ZWtydnhMZWRYNkI5SldMMzdKUHZXaVNXeUxCOVZBSTlY?=
 =?utf-8?B?azQvR0V3ZGRxNzBFV0VzQmp3aEpXbHJQRitJYndQUWZkSXpsNkQzdkxjdlhv?=
 =?utf-8?Q?RI67/tuZ/kmEj4vp2LmGpOHwl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B3C7FBE6FA79F42815237C5F2723840@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9e1f86-a117-4e0a-7664-08dac09d4e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 08:51:48.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdbdgZxajyV1h7sSaZXMTCcQTEPxg3kDAwFjVRlrAZ49LeZaKwTARZIEG45MU9z+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KT24gMDMvMTEvMjIgNzowOCBwbSwgR3JlZyBLSCB3cm90ZToNCj4gT24gVGh1
LCBOb3YgMDMsIDIwMjIgYXQgMDI6NDU6MDBQTSArMDUzMCwgQXBwYW5hIER1cmdhIEtlZGFyZXN3
YXJhIHJhbyB3cm90ZToNCj4+IFRoZSBUcmlwbGUgTW9kdWxhciBSZWR1bmRhbmN5KFRNUikgcHJv
dmlkZXMgZnVuY3Rpb25hbCBmYXVsdCBpbmplY3Rpb24gYnkNCj4+IGNoYW5naW5nIHNlbGVjdGVk
IE1pY3JvQmxhemUgaW5zdHJ1Y3Rpb25zLCB3aGljaCBwcm92aWRlcyB0aGUgcG9zc2liaWxpdHkN
Cj4+IHRvIHZlcmlmeSB0aGF0IHRoZSBUTVIgc3Vic3lzdGVtIGVycm9yIGRldGVjdGlvbiBhbmQg
ZmF1bHQgcmVjb3ZlcnkgbG9naWMNCj4+IGlzIHdvcmtpbmcgcHJvcGVybHkuDQo+Pg0KPj4gVXNh
Z2U6DQo+PiBlY2hvIDEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy94dG1yX2luamVjdC9pbmplY3RfZmF1
bHQvaW5qZWN0X2ZhdWx0DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQXBwYW5hIER1cmdhIEtlZGFy
ZXN3YXJhIHJhbyA8YXBwYW5hLmR1cmdhLmtlZGFyZXN3YXJhLnJhb0BhbWQuY29tPg0KPj4gUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gVGhlIHRl
c3Qgcm9ib3QgZGlkIG5vdCByZXBvcnQgdGhlIGxhY2sgb2YgdGhpcyBkcml2ZXIgaW4gdGhlIGtl
cm5lbCBhbmQNCj4gbmVlZCB0byBiZSBtZW50aW9uZWQgaGVyZSwgc29ycnkuDQoNClN1cmUgd2ls
bCB1cGRhdGUsIHNtYWxsIGNsYXJpZmljYXRpb24sIG5lZWQgdG8gdXBkYXRlIGl0IG9uIHRoZSBj
b21taXQgDQptZXNzYWdlIG9yIGluIHRoZSBjaGFuZ2UgaGlzdG9yeSBvciBhZnRlciByZXBvcnRl
ZCBieSBsaW5lPw0KDQpSZWdhcmRzLA0KS2VkYXIuDQo+IA0KDQo=
