Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB46F7F29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjEEIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEEIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:34:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A22191D6;
        Fri,  5 May 2023 01:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8v2blOuiblTQSBE7EZGy1BxS7WaxtIZxlxnSEKGtcJGvbnCLNq5SglaiDR2ai7FJnARssIkUAl+ef+y+eJ9tWPIUfyyoW1n6iK85mDDAQZJuDvchKE1t/EviTz7PXTVEdw16PQKNo7ttyreI7uwHjs91xDvABHmEpZkFAm+3pER4FrJgZH1T6dCIsEb3wPs5m/6brkWM5I6kpDyqOpVEAWk9caSBJG4mLXScE4oMkhZIMdhjYC0+z4LcKg/bhiSEWJCk+XrZUOzaZ+2bRwxsY/+9ys6NwX46+0bY5YZNjfQbnX+jtW7u5b79ccH9sK79Rs1KVPFjuV6SyO9FgZXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/sQCP/A0ew6R3DRQegcIb0Loebv4TtRM2XCZWNSetE=;
 b=WQiQX/ROxUkThwnlfluMjmnYmJb5tkLoc6gpFtFEN+CmqRIynQ+yOG5dre3FXHxRjdzlgGq6NhHnmUyg4MNbHeRIx5V9X43ihNF3z/Ox2Hko2U8y9xYjAreZGAteYyRkeO8EsQlWUY8rXeZ3QJL6voCkmaRQpJZ0Jm2fQuvsj3fNZEYR5c+6X5aEL/CpW9t1EylPSTXaer04QasUHAHAPK2i12WxgrYQqMMeoNKKr3jrlX6CF1L4kcT24l/EiytoUnQKbpFCaDuuBhkKjxmPCnuSmXVVI3XWUAdYTX33BAtGUsx1U5eHs6zJxFNl7Seqtc1XLqB3Fpo9+tn5jmxCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/sQCP/A0ew6R3DRQegcIb0Loebv4TtRM2XCZWNSetE=;
 b=CyTN2cdfhMl6RzYUU2cAFMBqSmuPSODi1Uc4trzQVG29SEDE5FiLNcGD5Yvx8lCFNqzFjgg/nKfq7/tWQXnOCOMTfB8Q2/Vb6In+XyrDMgdn3mimfeqFdLU2RiL4Q6+OVf2Tjcjw/3RGQO16y0KF3CRA/u4Zkv/58N8ioFgd0HyRQ3WT51sA/OitGILDHGU7Ske9KZaTFTZJ0lVgCNSR06MDalp0mfiKrCEgL0tibXea9GVWE5J4doZ6Q82QFyK6xl4tusONZqFjzi50scyx6A0+UUxGN/3JgZUeNtF96m+2fuBtXR1QNSmDDEaEtNu5L92CWi/PtdhAUmymb/NIsQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:33:39 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::887d:c939:b45d:baea]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::887d:c939:b45d:baea%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:33:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 01/11] rust: add radix tree abstraction
Thread-Topic: [RFC PATCH 01/11] rust: add radix tree abstraction
Thread-Index: AQHZfZ6x5elb0Yvsv0+OuxQ9tBEn0q9LEiIAgAAMq4CAAAqwAIAAC6GAgAAoOAA=
Date:   Fri, 5 May 2023 08:33:39 +0000
Message-ID: <d9503657-921a-e89a-9dc4-28458fa6a661@nvidia.com>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-2-nmi@metaspace.dk>
 <ZFSATHV0gY8raccj@casper.infradead.org> <87wn1ns7kt.fsf@metaspace.dk>
 <ZFST5HAr6IQAhpjx@casper.infradead.org> <20230505060941.GA12147@lst.de>
In-Reply-To: <20230505060941.GA12147@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|BL1PR12MB5239:EE_
x-ms-office365-filtering-correlation-id: 8dec2c74-d05c-4b82-233b-08db4d436d42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y42X6ypD42XYcQ7eGyh8ZikGI3nk6MrUMi+wfHYKG1yiH0bhw7vT7IZzMbPuS4aNPzyv6IZqTvr16qVA13EWJFk0HsI6EModGQ2W0xAJG167MX4MmS400YlMth6gk6lN5Ea1E3DB/xLnEUtzdvSSWGSNfkXINmn0aO5IMcfUGla+YzcOR5UGlG1oXzZNQhJc/ldAffMxtwmwXrcMC7ucQMn3XB+5dbYXTJ22ExpyVHzV8viXzAoHhubT0hd2FOwXrIdh0MoaDAiE6iCDRZLeqd3CRQ+qMVUZStM54L21xMqj7c5ryXMW9XbUynIYzM0E0LgmO5utPirlO+K1OPHJPhM7RVKCdOzOOa7evbbVrSeoYSMVlJzyFnMMMX4CAJLMcKVWBoBTWiBfM4MSTpoZzeVzQI2ueNl9O7UdE09rItH+Lm2xacURJb/QrlMGaBe/RzUJe9iGdM608nu642q+FZT1NLyhDoeNeHMCUc20X0aRiOeyVmwVtEQpb+uNbisxnOOu5WCM+ks7iGpOYoIuArsodmMyyCXaJp93VTNlktx7e9a6XKVyOXRIj+XmH5Y+6dUoFHo3cgaSHdsOZgJQthrE4l3IXX3MUcWDzWhIIUwkri5TPMnKox3qeYkvRMf+qJNqllaZx+d4Uaqn5pmySCZqCLPLpiJf/FAzjRzoU9VsjztZykZuFl9YxnmhYSKG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(31696002)(86362001)(36756003)(91956017)(54906003)(110136005)(316002)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(66946007)(6486002)(71200400001)(478600001)(41300700001)(5660300002)(8676002)(8936002)(4744005)(2906002)(7416002)(38070700005)(38100700002)(122000001)(186003)(2616005)(53546011)(6506007)(6512007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGRQeWxQWmJocllJTWlDZTJ6V1pXaVVLeFVJY0ZhbkI2NlFGRitTYjNRcUVj?=
 =?utf-8?B?OG12eU9nUXU0TjlnN2YxaHFNUGxJUUo3UDlSWklFb1h5QkMzSGpkWFNzdzh5?=
 =?utf-8?B?Y09IYVh5bjY4SHBBYllhN2FycGJOT1BJem1objJaY21kQzlrSmhKU3ZKZHla?=
 =?utf-8?B?R25WN1lONGdSY1FsRldpRzhvTkpKdDlVb0VMSERWSGZTV1dXQlNMTFdDY1Jy?=
 =?utf-8?B?emt4SUtXdFg0cW83b255TWFyRGlTU3ltZk9QUklveGlhd0FKWUMza3BLQk1a?=
 =?utf-8?B?RXhiSDJ4TXgvQkR6eUkzUzRkWnBOeFE1dWV3YXZobzJpbnN6K1hNbUlFMlJU?=
 =?utf-8?B?alVJRlY0ZW1MNFZKaWswN2g5SitQRTQxZm1vOXJGczFnSFU0dE04cC9UTEJt?=
 =?utf-8?B?ZWdjZXkyNWcwelpPQlI5VmpjekJ1eldONVhQQ21rMWQ5U05HeHhtT1ZKUVow?=
 =?utf-8?B?WGFDMU05c1RaNmpHNTBJSHlwN0VrNTZlTEtCNmYwT2FvdEVvL050Zm5nbEdu?=
 =?utf-8?B?bTV3Yk5mR2FzMkZpOHRELzQ0T2g1TjJ6K1QvcTF2WTBoWjJZWEk3dE56VGgw?=
 =?utf-8?B?ZllrZGR4T09hejRVQnNVSzFuMDl5dmxGMGN5c3R4UWFjdXoxSEI4ODMrb1N0?=
 =?utf-8?B?VDU5eTFzSytHZlVlN1hYaWRaUWZhNWdMUFlwdms3NnYyMm8xNWxlVC9XZUNS?=
 =?utf-8?B?a09VcnMzRW1xMUZLVnJmcUFZU2NBK0JGQm5ZdWRwdm9qa25KR2Z2TGN3SDVT?=
 =?utf-8?B?VHVWYnlXQTBId0h1NzJhVTZSYUloS04yeERTUTdZUmgxbTB6clpCSERla2NE?=
 =?utf-8?B?cXFrTG9WdVZDc2JPNUZSc1NSbDJndGZ1S2xmUXNyWlpzSHQrTWlkM1pSbVZa?=
 =?utf-8?B?MDdCQXFpWDFDODFmcTFkSzEzblVLN2crQ1ByUkk5SWhEMU9TemZZV3c2VHZX?=
 =?utf-8?B?T2s5WVhKVWNWUUR1bmg1dU9rV1BBbGlQV25TbUdXa2E2RlJnc21ldkdIWU9I?=
 =?utf-8?B?M3NhdDYvanMxWWJnRWI2RXVvRi9Eck5EKy9wQ2ViRDl6U0d4K2pldlJ6dXhl?=
 =?utf-8?B?cWV4dm8wR0M0WUhBcGNLbHdEdERYajlFYWRGMXZBbDhrMFQxMERxRTNLb3Va?=
 =?utf-8?B?ZEJ4aFZKd2FBb3FqelY4SG0wVUFDaUVJemtMYUY3Z0ZIZXdhRk9nSkpHelFF?=
 =?utf-8?B?NmFFQ3IrdURRM0JVZlV3Y2JGQmtETjc2TmxDV2NyMlQ4Rk1zK3pZTHNQbFMr?=
 =?utf-8?B?cThKZ2NMZitJNG9KN3VkdXVoZmlKV3piQ1RWUFVhc2Yvd1lITjRxdUJKS1RC?=
 =?utf-8?B?ZU8zZWVLUUl0KzBPUGVzcjBWa2lnd2RMU1B6ZkhpTlhGMlpUZ1A0OENhdW9h?=
 =?utf-8?B?UVB1ZjlhbS9yMTJnNU5PT3RGRnpTT0RkTkhRc00yTDQ4S1BpbVI3STJWdGJn?=
 =?utf-8?B?TFRURkV6SDVDaHk1VjVNMjltbGRTcEd6RllOczhwQ2xsK0xHb28zN0kxTW9R?=
 =?utf-8?B?T1V5Q0dteHU3NTIzbzI0ay94Y0FTcUNva3dUR2d6UUYrc0RPZWpPQU1YTk9p?=
 =?utf-8?B?L3hWcitwRlhKeDhZZVBqaW1jdnNkdFNydjc0UGVTTGZCTm9wZ3dlbEVLMDR1?=
 =?utf-8?B?bFNibW1HL2UzUVJkTTFKeDVWaXEvV2dodXNMUmJuOVgxSExJcWpNQVZSang4?=
 =?utf-8?B?VW1SSUVMZHR4UmFoUmlFN09Sd3ZuRSs4a2lPNVBNRmNFdTZUTTVuS2dJWjRB?=
 =?utf-8?B?OGowZDVaMnVLZGh0dmJsWGxIVjdJV011eHBqVnMrSXJlT2d5SDA4dHVRc2VR?=
 =?utf-8?B?OGh1Q0ZJRWxBQW1KN1YzcnUwREoyZzJGa1ljYzZCRWl5ZzRnQlc5K3QyUjFS?=
 =?utf-8?B?YmZjNkxBSVNZdmhZY1dDS0ZUNFMwVTB2Zm1RSFo4a2hPYlpBMWhpODZNZ2NR?=
 =?utf-8?B?RVJXN0JnbFVyL0VuWWdxbTFSSFpHa2JpN3FCVjFvMC8vMFlJTDkydC9yMUU5?=
 =?utf-8?B?TFBoeGRxTDZGYkZONEhKN05qaFJQNDg2WHd5bmZDTk42MlVtOWd4c0ZoZ25E?=
 =?utf-8?B?dzg2QjRRNzMrVEJQTFBTc1lOUWxyTEhjbUhnSEFCUEJKS05PNjVyT29CTUdQ?=
 =?utf-8?B?S2NjNERUVW1UVytxbkpQeHhDSHhoamNVb0VNelpyQjFDdmFEOS9QcUpBNDZC?=
 =?utf-8?Q?t26u4KIuVJyY7EYBAj++RPB1t9cu4nQ/SWENfdVXZGU0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D68875AD20A7B4D955B170F49E20AE3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dec2c74-d05c-4b82-233b-08db4d436d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 08:33:39.4151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2N4n6WRvNor+6y2nj1cEIP1IXRUjuHAk1j1UzqncGy1Ywf2ylUfD3me520R1PZTZZul8NMNO+9WIrzpXQ7Axw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS80LzIzIDIzOjA5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gRnJpLCBNYXkg
MDUsIDIwMjMgYXQgMDY6Mjg6MDRBTSArMDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+PiBC
dXQgdGhlIHJhZGl4IHRyZWUgQVBJIGlzIHNpbXBseSBhIGRpZmZlcmVudCAoYW5kIHdvcnNlKSBB
UEkgdG8gdGhlDQo+PiBleGFjdCBzYW1lIGRhdGEgc3RydWN0dXJlIGFzIHRoZSBYQXJyYXkuICBV
c2luZyB0aGUgWEFycmF5IGluc3RlYWQgb2YNCj4+IHRoZSByYWRpeCB0cmVlIGlzIHN0aWxsIGFu
IGFwcGxlcy10by1hcHBsZXMgY29tcGFyaXNvbi4NCj4gQW5kIGlmIGhlIHdhbnRzIHRvIGRvIGEg
MToxIGNvbXBhcmlzbSwganVzdCBjb252ZXJ0IG51bGxfYmxrIHRvDQo+IHhhcnJheSwgd2hpY2gg
d291bGQgYWN0dWFsbHkgYmUgbW9yZSB1c2VmdWwgd29yayB0aGFuIHRoaXMgd2hvbGUNCj4gdGhy
ZWFkLi4NCg0KcGxlYXNlIGRvbid0IHN1Ym1pdCBwYXRjaGVzIGluIHRoaXMgYXJlYSBhcyBJJ20g
YWxyZWFkeSB3b3JraW5nIHRoYXQgd2FpdGluZw0KZm9yIGZldyB0aGluZ3MgdG8gZ28gdXBzdHJl
YW0gZmlyc3QsIGdvdCBidXN5IHdpdGggdGVzdGluZyBhbmQgYnVnIGZpeGluZw0KbWVtbGVha3Mg
Zm9yIG5leHQgcHVsbCByZXF1ZXN0IC4uDQoNCi1jaw0KDQoNCg==
