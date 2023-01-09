Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6522661F60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAIHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjAIHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:42:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC66543;
        Sun,  8 Jan 2023 23:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0oTya9YSUwS1IRcHO2TmgLzFH2oMqVmrfkT78uESIxB11CrV5X2mkXV/MCSBNawvUvqPlpI0faLTE/IeuhctymjW9//Gmi6kZk0lTUwMBIa2Z5MkLXbmhmpoQhfAhxtKQpHs9ymlZU/iS3zKp6XuarOGgnCz1BLGv1t9dZ1A+zWPfnhYSdmAqDO0q02gZklsSSJrHHV5z2eCV3kkM7nft98XNlqN+qyuOPBqXThIUQwkyANFwyBO7MzYut6iszfb4hwg4XUZCbFs5NOQD3LAIxgnha1qLhvVQk6jtkH9yYpFyG/aylz1Xohv9nV5tzuCg0/gFxCVdEFpp+D6YBqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVsKNBHw1Fw5lVBLDKj9lp1E9t7NnUdNfol8rNMQki0=;
 b=a1xn/F5Tivr+oaX5/fBKkHGQPNpe4liEucB460zRXqLeaPNLjqXXUeG97d44mAVWNGjHrVgocTDVRAOeQeCIuiS5SKU/bVc1E3hBIQd/gNkmtGAXEgK+NUY4wP9H5/ifI4NNuAm4DqUNuXUvQqLEmjjfLJ/knO+vm2uFOVPl4C+vVjLWsXohpGifGkmafO1ZV2E1Xt2JIS0YM94u3ug4Lek5MZTzVg1svOr4qks8/4maieSK8u82FXIVj2icfOEmNJ8Au1wtWOlmH1QyGk3UnyO04NJP1pTH8HFoVDSYH0t1WTy7lhAHu5aD/GulBCpi1USJhCqzXt+UugKVfxrrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVsKNBHw1Fw5lVBLDKj9lp1E9t7NnUdNfol8rNMQki0=;
 b=XDXAH/2dTLqjPEtmZaeBYqIB0Q84AG343wbuJlst+X6S5CrOJ83UNjs4tRJzf1lm0rjNeD3bpbCBtOmSm9+paRHbUC2SDl379XL1m6jGYp7ldGHDXT60PUebM+4BpT5gJFoWJfkE7pw06XPzUCtzTGJBooR9exA/CLawXLBTBh5ycW2nQJcx9uzU1RE2Vcg3O8ZUt0NWbJmRp0Od6mLmjpYtfORvGRkESPy/8GbeRwQayhqv4OrUFiIKqUyl2kN0/hpdkd/P+kFwT6oNbU6U1A+RJG6DNX4YH4LF8a6N4RH03+CqHbQcl6MZcTCTwaaiZJfETcY8s02y4jPOD4VA5g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:42:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:42:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kernel@pankajraghav.com" <kernel@pankajraghav.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Thread-Topic: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Thread-Index: AQHZIammHlUuXw16qk6y2urp6p07Jq6VuHYA
Date:   Mon, 9 Jan 2023 07:42:17 +0000
Message-ID: <085ac6a6-201e-92d1-a72f-d34da0315fb9@nvidia.com>
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
 <20230106083317.93938-3-p.raghav@samsung.com>
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 42af7fcc-6840-4e80-b348-08daf2150831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjGWZGISR1EuxSUHEbDnE+3Qkpv+bnYH9Q87rZsz8R4370kmDuPHmhQ4fSz9gB2LXPYtg7SJzGyZIiyVCN4r4eHl0kmtB/b1XRjXEAtOEI46wHVOmDQt44kSzRwMWLJWRjEMMDrl1GvUCbgYA6iri0DlLt+HmCGEcNYDmCAM/9xeVW1dq2rTZnqqvS4Ct16NRMkd1ior/uzn4wduGJGZNtyapG9B2W10wz66rhHXEZ0mgGkwzyZpnyLGB0yb+93SwHIaog8aQfGswDUCvnrOeFA+3BXJC+d1jWIatKofMahVMNXZb5NmzFGPpczkBZ5FvgXD4E8UqXRDGD2jiiVMDvXjol+6Prt5W0r8NVYY3jSD9Ks6x0cS1qzQ0h3HlKshWGj0V4YYlOQ6FTzpG9wavuhUBw7nf0SU+L/HD2pepsl0jZhI8cmOzkLofyx2AyMQIilED0jbIQU5MIQ8a0i67Cqz9ewanR2cYjlxErL8zXdoiVg/DTW+ipHKOq9Qw9z5qVaJMtO6QlLw8vBGPfcKQkh9ekY5oSm9Q1J3zzi/DzlGek2t+6YQkec/JWjif8sw5hbx7FHO+1PHJaGPlS+Sih9NHvGH0k9I/uzhCYygg7lanfl6qxr55PvlIuRomFzZfrDhTWmbNoTX8h4CcLRHMnvdfhGGkAOyt6bbQ3TpF/kHTEAb4hHr6RYw6lbyLj8NZXs/SobQ71nIun9UzXU0i7MM2/Zu8nEcPz55VYZZyrHVen3I47gArDt1Gb1M55YZM+u5/Xwt+DBydKCg7ekHtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(31686004)(2906002)(6486002)(478600001)(2616005)(4744005)(186003)(6512007)(5660300002)(316002)(71200400001)(7416002)(8936002)(36756003)(38070700005)(86362001)(31696002)(41300700001)(110136005)(76116006)(66476007)(8676002)(91956017)(66946007)(64756008)(4326008)(66556008)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hNdHNmN1c1UGNVZ3RHemllSU5pZEVCNmZ4dmluYU9UZ2NHUDB6QWxEczFa?=
 =?utf-8?B?QUJSN0hxT0NneUtDSzMrS2JKZkRxaGFLdmVkTHFvOWNnU2lQMEhDenJ3c3Iw?=
 =?utf-8?B?b1VuS3hvUjcrOTN2SUJVRTdmdmNyalp1YzRiRnhBWjU2TFdJelhhaVFBSGxr?=
 =?utf-8?B?TWFJdmRyMVZBNE5QdEl5OGFIdlVIdTNSdEFMd1pJVlFuKzFuZTV5ekswUWRy?=
 =?utf-8?B?R1ZlY0lySVdLVk43ZEVUdlNWa3BOMmM2WGVyV0pvMjAyQ2REMjFlUWxjZXow?=
 =?utf-8?B?TUYwMzBkMWdLdjNaUXBVMFY1dUhYc1NrcFVJRjMwemFXYjk4Q2ZURFpnV1hz?=
 =?utf-8?B?Q0dUMnd5cUNkcTFWaGJ0ejNDOUh4VExDUi9jSUtNdTV6TnA0WDZJUVk1Ump0?=
 =?utf-8?B?ejNVM2RRYi84cEQrb3N0YmFvUWdxcEwyWjRZdk5CRTFPT3A4ZDlqdXhGZjRn?=
 =?utf-8?B?cWN3c1QvYm02ZGcvaW1xaWdWYjVYZXUzOE5ZSmVwVm05WlpleUhYWUZ1UTVI?=
 =?utf-8?B?bHA0a21NWnlWZEpRdHBpVjRXa285dlFLRWo4ZWZiWmV5dEsvUGNBdkxxYXU5?=
 =?utf-8?B?OHcwWW5iRDl3ZXJLRGZDV1ZZOWJjTXNadW9nbWNrQStlQkdJMU5McUZCMndG?=
 =?utf-8?B?Tk54MGdjOHp4dWg3eEFRUnExdWpDZEF5MElyN3JZaHhPeUNXSzFuSVQ3b1Rr?=
 =?utf-8?B?Y1hOajNaMjBWQ2JDNmRYSFhkUldCZ0FZZW5BOHNHbGtoWXRUdSszYXRGdVJX?=
 =?utf-8?B?MjNEaEVjR2Fpb3pDYkdGekZURHJ5eElZMXdIQ09WakUxVEJSVXZ3Tjl6eFRY?=
 =?utf-8?B?WlpXekh5TU8xYlYxTjVOSFhPM2hvSmV5WVpFUG9KOXhDZjQ1OHhkY3d3bFN4?=
 =?utf-8?B?OE1hazFGZXhvWWJTRFZUc2ZGTkVCMi81VHpTNEQycjNLU09VZFdPRFBnWEVK?=
 =?utf-8?B?U0EvdzFuSDJzZTVDb3BqT0xtamdZS0xUdGFhTjY5R3hveGRjK1VaZEZmd3dz?=
 =?utf-8?B?MklXOUlCRitIY2pSS2Jtd0hzZWRkN0ZFSmZncjFrY0JzSldLRmM3clNrZmVL?=
 =?utf-8?B?SStFNnNhTHhWckYrSU0wNXRsTld1WnNoaVk5bGd3ZVVhbVk2MUg5aVpUV0cw?=
 =?utf-8?B?cTAvc2dBektyNnpjZkpQMlUvVnc1ZDFVdTZ6ZENFaFlDamdTdEdrbTJtOU9Z?=
 =?utf-8?B?bUpOU3FGVGFIeXdTb0lRMFJieDNqMmxXb2RsdGxCZ1FVWVJ4UHNSM0NoaHpQ?=
 =?utf-8?B?UkorNjNVSGR3K1BaK2ErZE4xS3IzdmQvbHFYVm9lUDBNSUFuZVQrckRMSTZp?=
 =?utf-8?B?MTUwdDhWdUZLZktxSTVIZWZTWTQyK3BFYWtkc05wVmt4NFdPb2pnb0xBYWJH?=
 =?utf-8?B?M2llc09aQ0FDQUJXSURORHhkMThDNG9ubHliNU5YeEpXNXNaRk1od1p5VW9J?=
 =?utf-8?B?MWlRM01lcWpnanlBaFR3d3lhN2lIMFBnblc1N0JhZmdDYWFWVm9aN1NlNzM3?=
 =?utf-8?B?QzFLK3lSTHNmN3ZSMkpxYVJaS2FnK2NuUFk2TWV0MGNTMm1qYWZvRGc2d1ps?=
 =?utf-8?B?VXgwSEtQcS9KbkxJT2Zsa1hDMXJad3B3OWRxZituTThKeFhVVzE1V1JBdms2?=
 =?utf-8?B?NTBDZllVM1N2L21tOFBmUW82WG9iZktGVWtPZVozN0tCSCs3WFNFM3lzWTlQ?=
 =?utf-8?B?NFJMa1pKNjhaTFpBdnVaWTVCRGpFUEx3aG9RUXZIOGU0TDQ4bithSG53T1B5?=
 =?utf-8?B?bDM4d2N2aXB0azlTRkNMWDVXdGgrYng4YmpsU1VRbnRYR0xRTGJpZEFpcHh4?=
 =?utf-8?B?NjVTQUcvVnByWUxvUnVhdFIxRUYzcnZ4N0pwZFZBUXhscXllY2pZdHlmOHhp?=
 =?utf-8?B?dEUzOUJZWjl5K29QTXZpbTUrSk14TTNHbG5qSjk3UmViUW9nTnloM0RsWE9u?=
 =?utf-8?B?N0ZIblJtNTl1aWxhdVNUbS8yMEJxUFhDVlVsYnI1UDUxQlk4R1BIRWJ1YWVN?=
 =?utf-8?B?UWFXdjhWa01LbFE4ZTJOZ0VqR1dGUGNiNTIxdDhIMmd3ZTlpMTJEbytyeEFY?=
 =?utf-8?B?OVcxaVA0RXJlM3hELzRNMjRRTU9LbWtoRDZpOFdFS25DUzNqTnMyOVg2TUhr?=
 =?utf-8?B?elpMVWN6OTdNUDNvNGpLWkN0eWNNSWFXOUQ5bGp0Ym9Ubm10dzU2blBXTnpZ?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D18CE73439D8D04A9D6C8EE0623BAF09@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42af7fcc-6840-4e80-b348-08daf2150831
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:42:17.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqxPMiqWsLVNu8/r3Dh1WfXh1ZoiLqY9HEy4XKJnuYkEPuwjPhemw/q/Ipe7NEV6kqGAiIhtpcyvdXGlVTpcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS82LzIzIDAwOjMzLCBQYW5rYWogUmFnaGF2IHdyb3RlOg0KPiBJbnN0ZWFkIG9mIG9wZW4g
Y29kaW5nIHRvIGNoZWNrIGZvciB6b25lIHN0YXJ0LCBhZGQgYSBoZWxwZXIgdG8gaW1wcm92ZQ0K
PiByZWFkYWJpbGl0eSBhbmQgc3RvcmUgdGhlIGxvZ2ljIGluIG9uZSBwbGFjZS4NCj4gDQo+IGJk
ZXZfb2Zmc2V0X2Zyb21fem9uZV9zdGFydCgpIHdpbGwgYmUgdXNlZCBsYXRlciBpbiB0aGUgc2Vy
aWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGFua2FqIFJhZ2hhdiA8cC5yYWdoYXZAc2Ftc3Vu
Zy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
