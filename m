Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493FB663F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbjAJLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjAJLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:48:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FC56886;
        Tue, 10 Jan 2023 03:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuB3WO3HQ4qbjAL9s4MWcrd0eP7qfpvCUbTZ0FuuQ+7g6BkJJsMUEMC7kz9iIjm9wWCEk304UXTrz/o/tXc+4mFgXoQ5v0KWARChDNCPuveuPPXdCAeJqnXEqzjQdCS4M5vR3TH8d7JoIZpsuECww9x+iZ+DUNwMFWrL5hd2uROUHGgZ25hkTAXwvNJizpRnsvvBVtLJfDMFtowVzjXaJI5T8aouw+eTensXU/oVcPWvtZnXL130FrlbTj5aamvOvJQP9Oz1hPwXYoiES80DyimMnaJ8ZsI7siIIrkbrRNWYu6tVNDxwu8LGME5vTCiiFRRQ/mW93epHsZV8bbp/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1FY9QfXzPtA3fzb8X/oXli48iMyPOHEBZuoEBUtrt4=;
 b=N8QWWNU6fuNYaWFTIKNwhRQnona5v18NKJtpNfuM+UYdHyEQLdsw6hWgUZuvCgbBSbHt4wwiakdTzsP9plE4kwxIXJNc3diJ+i5688h7vokL0KepILiXQKtjv6zq1HXgHrknr4tTHcGgzRlI5dB508uBllgiAuV16u3B8Ti6DSd6etmHsJPCy7K6f+Ummq8XLiqkxk7XYW8XsCmM55nj77Qwwvujsd9lWDxd1zi5H+itAVl4YWYm9WJh4EmdFd7mcnkQsSswtpwC4+rk+HqhCq2189SJzja+Mvj/e1ySMgqM7XXaEU7zB+wOwHRY9jEcSMG6vcIg5vSbRgINOTDxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1FY9QfXzPtA3fzb8X/oXli48iMyPOHEBZuoEBUtrt4=;
 b=H4JW72u4k21SZdJPsQP956oioYmQJsQlUJbl2l33+HODwrK8rIe55VyQai8e7faYJtkj90/mVWZV8je9VGJ/wee+o//xRXnTdkSDRJEMvNLJIQzYew23SW64ZDXyk5EAJLVY+HlGeQ+ter2mZumeZkQqlshm6fuYuNf0UvwlpCwpPIsjTR3thLuzdXU7NyXdBbAnlsZmw+EdOauzm/LeRQKo4eIgU1iQCKyU7hoIK2stXsaJyZo6hFMUvy3CKWuJSczoEhxCTClG7ihO82tGssKwvjW171PXpipgj8QvPbOM5PSSTL0Clu1zBY1fGGhJLxvVUyv1abxK1HnPhz6txQ==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 11:48:10 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::ab92:c843:744d:1363]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::ab92:c843:744d:1363%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 11:48:10 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Wayne Chang <waynec@nvidia.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ucsi_ccg: Refine the UCSI Interrupt handling
Thread-Topic: [PATCH v3] ucsi_ccg: Refine the UCSI Interrupt handling
Thread-Index: AQHZH0uaxHEnso5S902rUVzbM3XOUq6RDgkAgAaGMYA=
Date:   Tue, 10 Jan 2023 11:48:10 +0000
Message-ID: <9fe65be9-d0d8-0201-0dcf-8dd940991d92@nvidia.com>
References: <20230103081531.423017-1-haotienh@nvidia.com>
 <Y7fXapwb5yJNbM3G@kroah.com>
In-Reply-To: <Y7fXapwb5yJNbM3G@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|DS7PR12MB8291:EE_
x-ms-office365-filtering-correlation-id: baf8904b-2124-47d6-660a-08daf3008c20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30qZVdsDNL1yYpJ0wzJWvsNf00fhbTTDEhnsvedopiVxOzYAfvTZVLBxF2HhE/ISW9DdPB7qrjZNnApk1CXIiql1xkFX/aZFF9wRiStBM+0Eei3hSfRLGSfitCeIxCeVwDxKn7T6V+K9kRzepERleDMIkrmNeUbn/nVBN0VTwUC6h/Y65ujJUgsvxNo2TX0IBaWj4j8G9+H1LxABtWutvaGu0CiA+0FoSBDPTHJKsnyXKbCIfKWEoAqtyz7ojFQVzOb3OGgAESSMvSAePgdOfRtKLQ+IDV7LpLbf9UdQG4TXJ1I852O6gs8MdxaHF54zTkn3fo6RO1jZrKn7QSVxrv4ix8wA23HB24OSIlLMZwoIFn13wTTaC6sI+yZ/7WeMj/nXtO5XAX7Bc8HbGajs2o1qHQ1Yu6xc+Yu0pP/R0PMmrpZsXBqn4ODPU5X3lQY31L0uYMdJ/15G6Q2HdXEFmbzLchTBV2jy0HEj5UexwxO7ruIPcuyeEiLjF01yk1Pj0J8t7QhFMAdBOXDd55wmelq1eFCLBudKHQq+WPvb8dw7/ZaV7fikBDfId5ga4z9jUls5LZuXght7ihpfqoYOzrqD6h9EH9sIShuGNMy6iiEzzuuwcbA/MMYe/tXQAGPifou3Cbslv5mi2rmF3JjsYVDo+yf8mqN0/SvUSpTzjjtFB/ZJ+iB0VFe0v3+n1gg1P68KTqsRFLMmrxzCQStJhGaT18RtQGEbZXVpEaKPEdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(41300700001)(54906003)(64756008)(316002)(6916009)(76116006)(2616005)(66446008)(36756003)(8676002)(66476007)(4326008)(66556008)(66946007)(86362001)(91956017)(31696002)(38070700005)(5660300002)(122000001)(83380400001)(38100700002)(8936002)(2906002)(6506007)(71200400001)(53546011)(31686004)(6486002)(6512007)(186003)(478600001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnVqdEtMK0Nqa1hHbHBRTHZhaWJoYXdjaEpYcUpOSHJmVU5DZ2M0azMxc2Ra?=
 =?utf-8?B?WWhrZUJyUTdJS2hyOXVPdlF2aERKRzBtQUZ4b3VRMjBpQWpGb3loMlhUT3lZ?=
 =?utf-8?B?cktJZnlzSXlVVUFDSjhMbjlKdk5ZdjhlYXJxNUFRMzZQTGlLaUt4Y3ovUzJW?=
 =?utf-8?B?TEtBV0pQbS8xV3BSL0hqaVU2VWhQSWMvemsxOUlWYVp0ZWxGZHUxaE1LN3Nk?=
 =?utf-8?B?V1lMSWhxRlBJQ2M2Q2FTaWpKUzNWWExDc2xkbHJIOWVGQ0FHV1Q0K0MrR0hC?=
 =?utf-8?B?K3FwOXpJRi9SWFJ4Z1Vsck5na2MwdFZPRkUrdGZTRHczcjZ4bkw3bGNreEtJ?=
 =?utf-8?B?L29vejhmVlNxMXlFQkZhZnVqSEs1V1JheCtRRmR6eDZUVWhEUWR4QThOdi85?=
 =?utf-8?B?ZTE0RGxJaUxpNGFwWlF2b2FvRFBmZzkwU05SZmFTK2I2cFh2cDZhOHpoNFNs?=
 =?utf-8?B?eGhObWdIbnQwQkltcFBvWndvLzFmOHVLRktkYzRRb2Rrc2FUWFYvTGEwY2ZW?=
 =?utf-8?B?dk5hWDgvNW55R21Fa3NSQitGOXgvWTFtMDcxblQ5M0lzTDR1d0RqOG5JdXcv?=
 =?utf-8?B?Qy82NmRSM1RUcE1yMENrakdqWExRL2puSDFKYUd0aUhFczdSSVQraTd3aUlv?=
 =?utf-8?B?VEFFOXhseGk0YXhEaXlSeEFFZFhPYXNueUs1UW5LMHZ0QVlUQmVXYW5nODZM?=
 =?utf-8?B?N2lJaU1WN041Tmd3YU1ia0ZINVMrTzRYcG5SVFVLVDRHR0dRbnpzaG5BL0pZ?=
 =?utf-8?B?ZHlleG5IajZWaTVFRXJOem1GdW80SytQN0JiblNMd0EvRjR6bGRQY29FdTdi?=
 =?utf-8?B?VEZ2WFBsaDh3N1hoUlREZ2hBWWw1ak5kZXVZUVlndTFMc2U4ejR4aGI2cnhN?=
 =?utf-8?B?WlQ2ZEdoU1duNk9ZbTFpVEI3dUt1RHdDWmJ5YjVQckdTN1hFVnZKWXhaZ0Z0?=
 =?utf-8?B?VHB4UDhVNjl0QWZXOFgrYm84ditTWlREMzkrUitoM1FVNjNhRkxCMnJMeHpQ?=
 =?utf-8?B?RWk1RWtFNW9acUpuUEtyTWw3Z3YzcnFHWEJSTnczOUFEODlwUFFrTWREZGlS?=
 =?utf-8?B?Wk1JYk1pajlDREFwL1lLdnJMRlNuKzdJMDh4N2lnVlREOUYxMXEzNjV5Q2lx?=
 =?utf-8?B?bzFLYlpGVzVEUTFmdm5oMXlOOHpiVHo3TEp0dW9OblFISCtEcE1Hd1orbHl3?=
 =?utf-8?B?ZEVPaUwyRDlDamladStXNEdwL05sK3ZLcVhhOEdvNE5DMmI5bjE0ek45MnNx?=
 =?utf-8?B?SjVsQ2QwN2FCa25yeTJhVGpIcDM3ZmNVL000TzEzRjEraDJkNDduRmw3ZUx5?=
 =?utf-8?B?THA1NkVHNlFJVzhoeERIN09PU3NLOVNLVjAyc1hUem1ldEc5ZkdZb2ZLZCsv?=
 =?utf-8?B?bVc0cnR3UXMvL1FZN2JSSUNNYTN3Zk9QbUE4RlVMUFQwOVhaclIvRU10dmVl?=
 =?utf-8?B?Wk40NUwrZ0NwRGkzN1grZDdCeTJlc0J3ZGU2dHViWVFNU0prTTZqUXZMQncx?=
 =?utf-8?B?ejlmZ1MrSWxEeFZiV29JTDc2OFA0L29HSmhrdWdRMjBwaGFOYmU0bXhocEsy?=
 =?utf-8?B?VTNidldPMFBIZjZGQXMyTTJzSThwQW5BRmRBR0MvMEpVbC9TOXloa1VjSG03?=
 =?utf-8?B?TUtVTUZ5WGdJQmlTSWsrdUp4bjJUcjFQM281M1RrN21Yb3lKYUhZUjhkUFZ6?=
 =?utf-8?B?UUhGeXI0K2dGbVVZS09CRXdIcGlvU1N2ZlNQcUM5Y252NVVyelZNdUppcjVK?=
 =?utf-8?B?enlWRHg2UDhNN1RueVJNUUxEeXpzZWVoNkZrTGc2MU44bEs3Uk9MSkcrTGpR?=
 =?utf-8?B?UjI5emVPNlVZQS8xVHdaSXdITXVlYlFFNVduTW04Z0dheVQxdE16WE5wM01G?=
 =?utf-8?B?T3k4Wi92bHAwelNIWER2UjcwODd4NmNzZ1dsRTJZbmNYYnpXSFhERGQzNVlG?=
 =?utf-8?B?TXBDYmZCcXlQMDlNTm9CTWVBY2ZIbUF5ZkN3RkVlREVnelJNdkxpMUh3NEJt?=
 =?utf-8?B?OEpubVM4d3k0L3ZrUGNmc1plM2xVb0JOZVVuOG5wZUFMODVIZW9WZlEwaDZS?=
 =?utf-8?B?TnBSYU1XazBhUjZ5VzhJMjNBdTVVbzBwL2RldllWNXAxSlFBeUNUei9SczFF?=
 =?utf-8?Q?dH8Z7LgWTd6Zk4MYigZgJC3NR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C4BEB9D738F84898F28DD87A35562A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf8904b-2124-47d6-660a-08daf3008c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 11:48:10.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnsxuIhP32sC9jioS/iDvx0r6iOMpskTvqTJl/nWVwB5yVtng4McrVVhQ18MHLW5cZMZpscPNxPunG6I5ZPa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS82LzIzIDE2OjEwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
T24gVHVlLCBKYW4gMDMsIDIwMjMgYXQgMDQ6MTU6MzFQTSArMDgwMCwgSGFvdGllbiBIc3Ugd3Jv
dGU6DQo+PiBGcm9tOiBTaW5nLUhhbiBDaGVuIDxzaW5naGFuY0BudmlkaWEuY29tPg0KPj4NCj4+
IEZvciB0aGUgQ0NHeCwgd2hlbiB0aGUgT1BNIGZpZWxkIGluIHRoZSBJTlRSX1JFRyBpcyBjbGVh
cmVkLCB0aGVuIHRoZQ0KPj4gQ0NJIGRhdGEgaW4gdGhlIFBQTSBpcyByZXNldC4NCj4+DQo+PiBU
byBhbGlnbiB3aXRoIHRoZSBDQ0d4IFVDU0kgaW50ZXJmYWNlIGd1aWRlLCB0aGlzIHBhdGNoIHVw
ZGF0ZXMgdGhlDQo+PiBkcml2ZXIgdG8gY29weSBDQ0kgYW5kIE1FU1NBR0VfSU4gYmVmb3JlIGNs
ZWFyaW5nIFVDU0kgaW50ZXJydXB0Lg0KPj4gV2hlbiBhIG5ldyBjb21tYW5kIGlzIHNlbnQsIHRo
ZSBkcml2ZXIgd2lsbCBjbGVhciB0aGUgb2xkIENDSSBhbmQNCj4+IE1FU1NBR0VfSU4gY29weS4N
Cj4+DQo+PiBGaW5hbGx5LCBjbGVhciBVQ1NJX1JFQURfSU5UIGJlZm9yZSBjYWxsaW5nIGNvbXBs
ZXRlKCkgdG8gZW5zdXJlIHRoYXQNCj4+IHRoZSB1Y3NpX2NjZ19zeW5jX3dyaXRlKCkgd291bGQg
d2FpdCBmb3IgdGhlIGludGVycnVwdCBoYW5kbGluZyB0bw0KPj4gY29tcGxldGUuDQo+PiBJdCBw
cmV2ZW50cyB0aGUgZHJpdmVyIGZyb20gcmVzZXR0aW5nIENDSSBwcmVtYXR1cmVseS4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBTaW5nLUhhbiBDaGVuIDxzaW5naGFuY0BudmlkaWEuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogSGFvdGllbiBIc3UgPGhhb3RpZW5oQG52aWRpYS5jb20+DQo+PiAtLS0N
Cj4+IFYxLT5WMg0KPj4gLSBGaXggdW5pbml0aWFsaXplZCBzeW1ib2wgJ2NjaScNCj4+IHYyLT52
Mw0KPj4gLSBSZW1vdmUgd3JvbmcgUmVwb3J0ZWQtYnkgdGFncw0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvdXNiL3R5cGVjL3Vjc2kvdWNzaV9jY2cuYyB8IDg2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvdWNzaV9j
Y2cuYyBiL2RyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvdWNzaV9jY2cuYw0KPj4gaW5kZXggZWFiMzAx
MmUxYjAxLi5iMzVhM2E5N2M5ZmIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy91
Y3NpL3Vjc2lfY2NnLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvdWNzaV9jY2cu
Yw0KPj4gQEAgLTE5Miw2ICsxOTIsMTIgQEAgc3RydWN0IHVjc2lfY2NnX2FsdG1vZGUgew0KPj4g
ICAgICAgIGJvb2wgY2hlY2tlZDsNCj4+ICAgfSBfX3BhY2tlZDsNCj4+DQo+PiArI2RlZmluZSBD
Q0dYX01FU1NBR0VfSU5fTUFYIDQNCj4+ICtzdHJ1Y3Qgb3BfcmVnaW9uIHsNCj4+ICsgICAgIHUz
MiBjY2k7DQo+PiArICAgICB1MzIgbWVzc2FnZV9pbltDQ0dYX01FU1NBR0VfSU5fTUFYXTsNCj4+
ICt9Ow0KPj4gKw0KPj4gICBzdHJ1Y3QgdWNzaV9jY2cgew0KPj4gICAgICAgIHN0cnVjdCBkZXZp
Y2UgKmRldjsNCj4+ICAgICAgICBzdHJ1Y3QgdWNzaSAqdWNzaTsNCj4+IEBAIC0yMjIsNiArMjI4
LDkgQEAgc3RydWN0IHVjc2lfY2NnIHsNCj4+ICAgICAgICBib29sIGhhc19tdWx0aXBsZV9kcDsN
Cj4+ICAgICAgICBzdHJ1Y3QgdWNzaV9jY2dfYWx0bW9kZSBvcmlnW1VDU0lfTUFYX0FMVE1PREVT
XTsNCj4+ICAgICAgICBzdHJ1Y3QgdWNzaV9jY2dfYWx0bW9kZSB1cGRhdGVkW1VDU0lfTUFYX0FM
VE1PREVTXTsNCj4+ICsNCj4+ICsgICAgIHNwaW5sb2NrX3Qgb3BfbG9jazsNCj4gDQo+IFdoYXQg
ZG9lcyB0aGlzIGxvY2sgcHJvdGVjdD8gIFBsZWFzZSBkb2N1bWVudCB0aGF0IHNvIHRoYXQgd2Ug
Y2FuIHZlcmlmeQ0KPiBpZiB0aGlzIHJlYWxseSBpcyBhIGNvcnJlY3QgY2hhbmdlIF9BTkRfIHNv
IHdlIGtub3cgd2hhdCBmdXR1cmUgY2hhbmdlcw0KPiBuZWVkIHRvIHRha2UgdGhlIGxvY2sgb3Ig
bm90Lg0KPiANCg0KLyogVGhpcyBzcGlubG9jayBwcm90ZWN0cyBvcF9kYXRhIHdoaWNoIGluY2x1
ZGVzIENDSSBhbmQgTUVTU0FHRV9JTiB0aGF0DQogICogd2lsbCBiZSB1cGRhdGVkIGluIElTUiAq
Lw0Kc3BpbmxvY2tfdCBvcF9sb2NrOw0KDQpJIHdpbGwgYWRkIHRoaXMgY29tbWVudCBpbnRvIHY0
Lg0KDQo+PiArICAgICBzdHJ1Y3Qgb3BfcmVnaW9uIG9wX2RhdGE7DQo+PiAgIH07DQo+Pg0KPj4g
ICBzdGF0aWMgaW50IGNjZ19yZWFkKHN0cnVjdCB1Y3NpX2NjZyAqdWMsIHUxNiByYWIsIHU4ICpk
YXRhLCB1MzIgbGVuKQ0KPj4gQEAgLTMwNSwxMiArMzE0LDU3IEBAIHN0YXRpYyBpbnQgY2NnX3dy
aXRlKHN0cnVjdCB1Y3NpX2NjZyAqdWMsIHUxNiByYWIsIGNvbnN0IHU4ICpkYXRhLCB1MzIgbGVu
KQ0KPj4gICAgICAgIHJldHVybiAwOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGNjZ19v
cF9yZWdpb25fcmVhZChzdHJ1Y3QgdWNzaV9jY2cgKnVjLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LA0K
Pj4gKyAgICAgICAgICAgICB2b2lkICp2YWwsIHNpemVfdCB2YWxfbGVuKQ0KPj4gK3sNCj4+ICsg
ICAgIHN0cnVjdCBvcF9yZWdpb24gKmRhdGEgPSAmdWMtPm9wX2RhdGE7DQo+PiArDQo+PiArICAg
ICBzcGluX2xvY2soJnVjLT5vcF9sb2NrKTsNCj4+ICsgICAgIGlmIChvZmZzZXQgPT0gVUNTSV9D
Q0kpDQo+PiArICAgICAgICAgICAgIG1lbWNweSh2YWwsICZkYXRhLT5jY2ksIHZhbF9sZW4pOw0K
Pj4gKyAgICAgZWxzZSBpZiAob2Zmc2V0ID09IFVDU0lfTUVTU0FHRV9JTikNCj4+ICsgICAgICAg
ICAgICAgbWVtY3B5KHZhbCwgJmRhdGEtPm1lc3NhZ2VfaW4sIHZhbF9sZW4pOw0KPj4gKyAgICAg
c3Bpbl91bmxvY2soJnVjLT5vcF9sb2NrKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQg
Y2NnX29wX3JlZ2lvbl91cGRhdGUoc3RydWN0IHVjc2lfY2NnICp1YywgdTMyIGNjaSkNCj4+ICt7
DQo+PiArICAgICB1MTYgcmVnID0gQ0NHWF9SQUJfVUNTSV9EQVRBX0JMT0NLKFVDU0lfTUVTU0FH
RV9JTik7DQo+PiArICAgICBzdHJ1Y3Qgb3BfcmVnaW9uICpkYXRhID0gJnVjLT5vcF9kYXRhOw0K
Pj4gKyAgICAgdTMyIG1lc3NhZ2VfaW5bQ0NHWF9NRVNTQUdFX0lOX01BWF07DQo+PiArDQo+PiAr
ICAgICBpZiAoVUNTSV9DQ0lfTEVOR1RIKGNjaSkpDQo+PiArICAgICAgICAgICAgIGlmIChjY2df
cmVhZCh1YywgcmVnLCAodm9pZCAqKSZtZXNzYWdlX2luLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzaXplb2YobWVzc2FnZV9pbikpKSB7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgZGV2X2Vycih1Yy0+ZGV2LCAiZmFpbGVkIHRvIHJlYWQgTUVTU0FHRV9JTlxu
Iik7DQo+IA0KPiBXaGF0IGNhbiB1c2Vyc3BhY2UgZG8gd2l0aCB0aGlzIGVycm9yPyAgV2lsbCBp
dCBiZSByZXBlYXRlZCBhIGxvdD8NCj4gDQoNCklmIGRyaXZlciBpcyBva2F5IHRvIHJlYWQgQ0NJ
IGJ1dCBmYWlsZWQgdG8gcmVhZCBNRVNTQUdFX0lOLCBpdCdzIGFuDQpjcml0aWNhbCBlcnJvciBp
biBDQ0d4IGFuZCBpbiB0aGlzIHNpdHVhdGlvbiwgdGhpcyBsb2cgY291bGQgcmVwZWF0IGEgbG90
Lg0KV2UgZG9uJ3Qgc2VlbSB0byBoYXZlIGEgZ29vZCB3YXkgdG8gaGVscCB0aGlzIHNpdHVhdGlv
biBmcm9tIHVzZXJzcGFjZS4NCg0KSW4gb3VyIGNhc2UsIHRoZSBmYWlsdXJlIG9uIGNjZ19yZWFk
KCkgaXMgbW9zdGx5IGJlY2F1c2Ugb2YgdGhlIEkyQw0KaXNzdWUuIFdoZW4gdGhlcmUgaXMgYW4g
STJDIGlzc3VlIGJldHdlZW4gQ0NHeCAmIFRlZ3JhLCB0aGUgZmFpbHVyZSBpcw0KbW9yZSBsaWtl
bHkgaGFwcGVuaW5nIGluIHRoZSBlYXJsaWVyIHN0YWdlIChlLmcuLCBJTlRSIHJlYWQgb3IgQ0NJ
IHJlYWQpLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgbW9yZSBxdWVzdGlvbnMg
YW5kIGNvbmNlcm5zLg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo+IA0KDQo=
