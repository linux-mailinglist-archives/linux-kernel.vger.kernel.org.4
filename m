Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191A68C14A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBFP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjBFP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:26:31 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A0298E5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txz3adbUUb89R4CEdzxoaUCcE1M6r04/AtmNCZVxGOBOTd3hx80G03wtGqRkMC/oFmBWMK9gk0py+wYNymFxeX6X7PPt/9E4f0QXsy5yYY1dhJ+4ccEhxFg4ltLWfm21UH/UlX7eMwjlgJcjlqEtU1KrEaHVazU1tZLnx0zb8pZZ8U9PS7F5rYTmdus8m/jfwRG6gocWoOatdVu2emE6cf+OpNBglsjSuxDAuTsu+WaX/QP73XyE1JmApg5c/8vhJvSWceCR1XYPlaePtA+YW7nJ9fYg9Gdn//8W/XRIi8/PDwFqFvnU32FmwbKnATAVkCddwrZoj1wwdMwZH7QOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfwb/XZUwTVLPy4kOHhV+twCdqkOi8X0TQEogmOiXdM=;
 b=oPbjLPQ+5YVPxE0RpJXl2oBadG8tcgsqrcLLY3z+tg/Tcnt1U+EPaoGUCJXNElNreMFYUCNl/IgHZuobdtwrupcKAMoyRB2U9Y1DeDZc5e7SqQOb9GplBm1+cbQagdZCcWIjj6McGxzDDGm49tq4a8GMwxjZSPafKUfg6wrxJoevMKfmzZ0CI6RUkGv18XktBCR0wxEe2wIx8dJusXwcB5rHm6ONZj8iJGOCLhH8Zg+JpbFe3VTfK2J5HvZaJvXf468BOlrv+osKASEQ7zmdsAUxUJwom/O66CLP8C4noPZkoxBjhP0wfYVTK69x9rbtERo22/aEdahzLE/moN1cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfwb/XZUwTVLPy4kOHhV+twCdqkOi8X0TQEogmOiXdM=;
 b=NJ6ynro0p6yJozy9+et95RC8kxSvwlAe7vFoYY/lDRmZtptn2k6HtGKDM+p4G5CwEhBAUvmBitltTkAzzbV3XJP3WNqgY79NwqrCvi54DHVdg/QEmR+KIEsEjKE/pso1VV6ZTcSNu7+hzZVy8MzxJt617sTokkdBzOJ8DdYwLaJUlTNE4puqtDzV67EPiFXOH0/6wYArOWonvCt3zLn3dYgR+sumUsxdIa8iJ7Bq2VPty7oWg2DK2Cw+376PVyeSCZ/q2JRIo8uTgZDk03q/g54cxZl0gG3hqiBm1VZJsRA4LiCOgFTG4C2YiiqtJZ4ziYC6x3cjlvoX7Bp8veVlaQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 15:26:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 15:26:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of
 noderef expression
Thread-Topic: drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of
 noderef expression
Thread-Index: AQHZNmM+YFccZjMStEK9o9raBIfe367CEfuA
Date:   Mon, 6 Feb 2023 15:26:27 +0000
Message-ID: <6359dcaa-0817-4819-321c-f786809ff89d@nvidia.com>
References: <202302020153.4eL3mwiK-lkp@intel.com>
In-Reply-To: <202302020153.4eL3mwiK-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB6674:EE_
x-ms-office365-filtering-correlation-id: 1304c3c0-0434-4ad4-7110-08db08568428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FsebWHei+Sc8TJSl0CYc8Oo8WZLwxKWCnbdbWQGlK5ZUeVsofeULRi63feq4ufRC9qmFGIWonucvuE8WoH55tYwmuPlSw8NDHdy/jcdZNbJIUuKpHvrVjigka9mp/DvD9YwH/L5mMYY2vHbciTcXsmBw5fdD/jAOexU45Un7i6hsTVgH6AjKU973w7WefKoO24lPJT2uiVovUEgLHaLfnwBux36DjAuVugYQ7SswJ3oaN1FEa4sE8Nqs009klvy1DZEZ4iVk9H/Xs70TSOzHneqh6z5syIzj326V/5vh3+p5J1Dw3OCXtax+TODn1YGL90TzYg3AgJ1rxc/5x8g6xcZ9iJqoTgOGWn3Nyr4ToWTNtkZ9LnMDOvLg4jYK4WRVpLjrasOC/9MYv3NFA++lNvgnJUwo2OTz7ekENhI7synghy3PwdjdDYfW25F8YSff4YUtX9zH2YBliP6y4ylK9EQ6wIgYyXuLpxygNa5dR/G/oXeaSM5BRQHk6EiF5oVj4RPjuUMBX8OFR3gGwiX8ZxZkaVfQyJnFLKn+wpgaK7+oHX2kTRo7139nIq0adKSkVolKGiugSV2cav8bTkmpSYeC3jw2SM3ub4s/VXHdeCw5yHRtZ/DVsZjzYwgDdbWGbgjO6Oxh1zryKuWASM4rS+J31+tTAuuMtyWNGwtTYjdY4+ONqN32BrPWQq+dOl8zfM+aWcBUgsHbWzn+VU7tt7ArHISv02CxdUdkdkDuvoUjWXodEeDIEjdz6ycKO1loFOncVt3MvjnABt9jnDsTgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(83380400001)(31686004)(36756003)(71200400001)(31696002)(86362001)(66476007)(8676002)(76116006)(66556008)(4326008)(6916009)(66446008)(64756008)(38100700002)(66946007)(122000001)(2616005)(38070700005)(6512007)(6506007)(6486002)(186003)(54906003)(107886003)(478600001)(8936002)(316002)(91956017)(5660300002)(4744005)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTREMDNlcXVhcE96aG9aNGFvb2xGeklSbVdmN0JEWWJ5NW0xWWRzcitIem51?=
 =?utf-8?B?RjA0NXdtTis0dm00Y0Vzdm1uTDVSMktSVmdrZTB3YUROVGkwWlgrT0JhZCty?=
 =?utf-8?B?L0VGZnlienBET2JKOVk0ME5ucVhQUTVMLzJ5R2VnNzJjRnhiSW9qYzF6aVZD?=
 =?utf-8?B?QjFCWUhoWGxkai85R3JMWW1hK24za0VQQjNHQnkvWWF2VGh3TklnMVJ4S0xY?=
 =?utf-8?B?L1ZhTE9zU0xwQkhQZ25nUEN6ODh1WjNkT1M0OG5tOFpFZDhUcGgyL0VSRE1T?=
 =?utf-8?B?ZWtneDF4dmtqL0FMM3JGMkdCSDAvSmF0UWUrb3hZQlZ3bWVDcDd4OEF2M1Nx?=
 =?utf-8?B?enhiWkJxeDJzQms5a0pHNXRwbktwQjhuMi9rRndyU29maVh1MS9MWUdrWUVH?=
 =?utf-8?B?bHVnQTZEZGxwb3ZCRjllc1V0RTl5TFg5S3k0aXB4Qno4Z0pjUm9YcDhtMjFU?=
 =?utf-8?B?Z0MzemJxRGU2YkN1eHVTVE5HVHgwUk84NjN2clhQaXRPRjQ5TGd1eFo5T3lF?=
 =?utf-8?B?ZHBPYjc1dndKMnptQUE4QWtYRjJrTWxDTll3SVVDVUlrcU1XMzNkbk1FNGl4?=
 =?utf-8?B?K3VpcWFIeVJOc1BFNyt2NGpVWHNyd0xReTErRGxPV3F5NWJBNGhlbUhnSTk1?=
 =?utf-8?B?Y0dUWlJSYTFmNFJTbTBnMnFXdGdMbHVva25HNmVzMGJuS1lVNC9tbHhmcjRq?=
 =?utf-8?B?RnJNVFlGc1pIYzV3WGh6NStNdUQyU3p4RkZhMFh6NnNsMWI1aHJuMkVocnpE?=
 =?utf-8?B?OXRXbllHQWdxVkJ0SVN1c2pjSk5WWm9DdmdTK0x3aU95NEU0WVliSjkyb2Yv?=
 =?utf-8?B?NjYxUFcrZkNpeGtHdmZ4SzZ4cmdISDE5Wmcvc1pHdU5aTkFkbXVwMGVabFYy?=
 =?utf-8?B?L0hCb3c5RE9PUEJGUFRITHhBT3A1SEVDUjNScWpxMVZyMEJpSGRURTk1RjFS?=
 =?utf-8?B?cis4UmJLYTdWbXlRU3hNZ3VXZlkzWmtYTDFXbnBFQkZuQysveWc0QStUb2hF?=
 =?utf-8?B?Unl0bXhXQUFSMk1EWmFWbGZGdk1HbEt5VGQ5NUV2b254N0s0aFhNVFpPYnM0?=
 =?utf-8?B?clhkNlk3ZEJYQzJ6cTIrRjlVdEFCLytGTXBLeVV3VUZXVlpyeU9NaEc0cXNv?=
 =?utf-8?B?NFFTV3g4THFPaFhuTHJYbVdMMzVhZzVBSnNCTEUremVQd0FGcllVaC8yMER4?=
 =?utf-8?B?VG13c2lldUg2d0YyMnM4VUpyazB6L2pxT2RoQTFGYnZJQyt6U1BxL2ErV1Ix?=
 =?utf-8?B?MXFTbFpMVXk4UlhWOHY2czYvcjV2RElzSm1vTStrcmQ1SXFJMnN0OEZCaDV2?=
 =?utf-8?B?S3V5NlMvV3E3ZGZBSXJmM04vYW1XaFFBdWcydHNzcEtKQWg4UVRLd0g0MWIr?=
 =?utf-8?B?UUJvL2dKUHFmOXJWZ2t0TWV6cTBwNURkRERtdVdqYXFLczhTSXB0dmJ6LzJL?=
 =?utf-8?B?b2J0TUErUUJmejI2RjhCNy93WlBmbUltVjE4dzl4ODk4ZnFaYmt4RTVIbmth?=
 =?utf-8?B?S214cG5yWWxjN0dKQy82NDgycEM1MG1BTk9zK012czRhMC9PbmNPKzUwejl5?=
 =?utf-8?B?aEoxZHlwd2xvRHZFTWxudWtiZWdpRnAvZ0JRUVlPYVVCUEZmWXpLcytoTTlL?=
 =?utf-8?B?M0ZrZ1IvRG9UWml4Q2YxZnJKK1pucE5nbWIvVFB3SS9QYk5CL2l3bGFUMjY0?=
 =?utf-8?B?WUtmbHhVUDJjbVNSbXhrUEFmRVZSSVZVMDdzTVJaZ3B0cEd3T0ZsWHBINjY0?=
 =?utf-8?B?YURVNE8xWm9qQzJLNDRwYnY1UTJiK1U0RVpSaDExcHFReXptTGU2RE9nbjZ6?=
 =?utf-8?B?Tk0rM3NuK2RqRjdiWERHZ0VNR3kxejY3QnNzaEdyN20wemJodDBNaDZtUmF0?=
 =?utf-8?B?TUdOc3dCMm4vOS9NYkkyMk5FamFFV3VoSFkxOXJka3dYdXZENEdQUFhmUGlH?=
 =?utf-8?B?eExPU21EYUQ4ZGxIVjc1LzArd0kzVkx3cGxnSW1QK09PQ0FXQVhwOWtVdE5j?=
 =?utf-8?B?di9yTG5nQ1ZaMmdCaHlRNWN1SVkwaW00VmxQWnQxTDJlSm1JUlRMdWJLV2ZK?=
 =?utf-8?B?ZlZoTWpJVmdYRi84eWI1QUFJQlR4bGZPRi9EUU00WlBwcE9MWk9iK0F4YmZS?=
 =?utf-8?B?dTArandYT2hzWkZsT2dEblRvRlNDRnRTWlRIZ1FRWi9kUkJ2T3YyQVBhVEFr?=
 =?utf-8?Q?N9PWTF5NUNky97+w0tP3L3SdlzDJwSZin9P7gBXh3wFJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0B0E634B7DD24419C4B649780B50B1D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1304c3c0-0434-4ad4-7110-08db08568428
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 15:26:27.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/YXH3OqcqTr24XwS9TkaaJ71598YkVVN0pcLWGpL3IURtfzdbXfbpkEY1+XxnWshUN0ALiz6QngWxzr5JAq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9nYW4sDQoNCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRh
ZyB3aGVyZSBhcHBsaWNhYmxlDQo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPg0KPiANCj4gc3BhcnNlIHdhcm5pbmdzOiAobmV3IG9uZXMgcHJlZml4ZWQg
YnkgPj4pDQo+Pj4gZHJpdmVycy9wY2kvcDJwZG1hLmM6MTk5OjQ0OiBzcGFyc2U6IHNwYXJzZTog
ZGVyZWZlcmVuY2Ugb2Ygbm9kZXJlZiBleHByZXNzaW9uDQo+IA0KPiB2aW0gKzE5OSBkcml2ZXJz
L3BjaS9wMnBkbWEuYw0KPiANCj4gICAgIDE5MwkNCj4gICAgIDE5NAlzdGF0aWMgdm9pZCBwMnBk
bWFfcGFnZV9mcmVlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAgICAgMTk1CXsNCj4gICAgIDE5NgkJ
c3RydWN0IHBjaV9wMnBkbWFfcGFnZW1hcCAqcGdtYXAgPSB0b19wMnBfcGdtYXAocGFnZS0+cGdt
YXApOw0KPiAgICAgMTk3CQlzdHJ1Y3QgcGVyY3B1X3JlZiAqcmVmOw0KPiAgICAgMTk4CQ0KPiAg
ID4gMTk5CQlnZW5fcG9vbF9mcmVlX293bmVyKHBnbWFwLT5wcm92aWRlci0+cDJwZG1hLT5wb29s
LA0KPiAgICAgMjAwCQkJCSAgICAodWludHB0cl90KXBhZ2VfdG9fdmlydChwYWdlKSwgUEFHRV9T
SVpFLA0KPiAgICAgMjAxCQkJCSAgICAodm9pZCAqKikmcmVmKTsNCj4gICAgIDIwMgkJcGVyY3B1
X3JlZl9wdXQocmVmKTsNCj4gICAgIDIwMwl9DQo+ICAgICAyMDQJDQo+IA0KDQpEaWQgeW91IGdl
dCBhIGNoYW5jZSB0byBsb29rIGludG8gdGhpcyA/DQoNCi1jaw0KDQo=
