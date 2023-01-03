Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACD65BBA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbjACIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjACIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:12:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB372AE66;
        Tue,  3 Jan 2023 00:12:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah1NjleaRpII6slUYpEtmaEUu2xaUE6+n00P+t87zjEGxURAazhCM5uKo1AQRZkwGXhaTk8IstOM/8XTOkPJbBcQetez9I7j7LGdH4/3lbOknaXlX5fhCEuVoxZeEt6/1cUr+LSnOdfa4wDzuL4pdLifxwsSfQG1h4vgXT7T0CT3RuiIgdIf1zxmqYGY6DVkl4VKEozh6TPAtZDhsWHzU7SBRUB5zY5+G677HNcAULigNSOPCAuPlepXH9+S1x77z2e7H7lPmwfpMQ6QECtBxBfMkAuClUzWgUIGa6CB33NWcRJQYYuMtna+YbhCtgMpR9LgZyCdY8HTggWCMroL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkPrOFLaKSzWii7opxl3VJqOBiYOO86IMIObuzUemM8=;
 b=VHW5l9HjtxXdgZF8XFf2IB61dhIWiM0itcfzqvsukvGW2xJI2kUtAgnRK0ajCpM/aPCGhoh6uJZz91gQ0fHC9SLkd8+0EMb+7Hd7N46TEfwqqZR7f2R0IMErm7aT4OX5YikXunTSL9qwz0/Pjkm4dUwe3lm+KXc5xYErgspdsOpMe9SPRW7ecyKL34KklPq06ShOCHmOVl8C6I3qqfGBndPRVrnq/2bm+gOsGPH0W/wijdJDb5S8Zy5jrHerNzyZwSLbeSZVNRI7jxrkJ0c3WosKWN1RQXeLTa1DAhiV0YobPZQGYIDWtstZQUYYL+zYk/2dYJkzS0eNB/mTjYjZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkPrOFLaKSzWii7opxl3VJqOBiYOO86IMIObuzUemM8=;
 b=oGU5eAznuwXTBGQX7xGEwgGDZYXHsDqNXnrp59cbsEoqlbZdXzXt3L8jutxGl3YhcyTaHHrOM4WgV0OJtZY/HuzQ87kyrqwMz7UljsCY23clfl1mclXy/LF1wATiT2BHo57PgrW/S13hOj7BeJLvsNlKj58IsWoG+SHU+XJQ/qQdrzBatsN4c/0JlHHwl1ijUI172jdZo3F2j/MrX5mk4WO5esBT+CpsikR9d0lYzqFSJT1BxSofgUOnpfJnHAaic+GQ1v/DUMHuLvxMGj+ROd8rQfRc6hRt17iojZNSxFo8sW0ncdZX5k0ngKQ0hFauHNAs0F58mJyUPeMz5oitYA==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 08:12:12 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::ab92:c843:744d:1363]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::ab92:c843:744d:1363%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 08:12:12 +0000
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
Subject: Re: [PATCH v2] ucsi_ccg: Refine the UCSI Interrupt handling
Thread-Topic: [PATCH v2] ucsi_ccg: Refine the UCSI Interrupt handling
Thread-Index: AQHZHxzNnRSsFCPYG0Gr27f1Ip3lFa6MTLiAgAALOAA=
Date:   Tue, 3 Jan 2023 08:12:12 +0000
Message-ID: <6a8b1143-7554-2474-e6b2-ccc4e9a369e6@nvidia.com>
References: <20230103024023.235098-1-haotienh@nvidia.com>
 <Y7PZ81G1LI20eGeq@kroah.com>
In-Reply-To: <Y7PZ81G1LI20eGeq@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|MW3PR12MB4538:EE_
x-ms-office365-filtering-correlation-id: 6c6939bb-5d3f-4995-4976-08daed6237e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLG89wKoHXc1qsdN6VG+oxuk1gcf1dMDW+FPIDdP8Th44y0Pueonh/CmcGC2UjnY9iKxgBCJVpS1qFZV2vAZGvB3R4X4iBj6ElZqd8/0oTVL0McWayUNuRoDW+afHnZuqh44dmLbM2iVNyFBpfAlqpO2n/+kc9dDXmElMTccgKqTDz/+kmsoDv01cXheDjTCl/BddsB9tF2vJnsg+c19DzrwSGsQBLsMwyQUoiRPN06D3UgrplQsmp67rRTxMwKFehPCUNoepf3R35fl6ZK3I4V8Q2yeOttW4R5Kb4ECFCoJhKTOiFYhUS1rw8xq59JlVkJYQQlllgmUBCbxQ9H7qYgthNfY8nYo6tZhuW0X0baA9VH+v0m48sh7waziTeyG9IeC30YAe8FnI2BgmH4rLskHQ2hv2w+QtGgKjUuKaTvUWafBx7xpVMAyMJFxWCsN7xhvhQG59Y0f6JMySNDJJJS+5Ltg4oqsyuR+cawQmWH0vW9CQWN6PRcFL8C6LpCQ9eENzKp7yUfjvmCrRB7vZOCiiVsiqDVxmznbT/Htqpq6VNTXAPWpjY9GDJHpfvzArP3xtEXF5K0uSgkFbkPgmHrY6391HboDNyil2KkVfWC6d3OOgET24ag87I67DBbjgWp3qUF7QVHLiaaMqXn2zo5fKrLzM43w8l/yST5++4wGCph/xXlGgPStUdTbO7f+ioDIDi9G/83VkfKQSvp/3l27dOQWWaeZSausxV8YRMVS4zAl2nCE3IBdXC8He+3N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(4744005)(2906002)(8936002)(5660300002)(83380400001)(41300700001)(31696002)(86362001)(122000001)(36756003)(38100700002)(38070700005)(186003)(71200400001)(26005)(54906003)(6916009)(6512007)(316002)(31686004)(6486002)(478600001)(8676002)(6506007)(53546011)(66556008)(2616005)(66446008)(66476007)(64756008)(91956017)(4326008)(76116006)(66946007)(22166006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVRlTjhwSGdyeW9JNTlHc3AvZWE5c1RoUmlsbmV4K3B0c2ZKd2xSWWlpSlJm?=
 =?utf-8?B?K1ovaW9XanU0Y2xIaVF1TTdxTzFlSmRRRWcwd1pvVElJR1NaTEZTTk1lMUJz?=
 =?utf-8?B?U3RsMVlzR0RTaEVmVUR0MCtCK243c3VQdmRHaW9uMndxeDcycnl4b0NQNSs0?=
 =?utf-8?B?N1VQSWNVdFFyYk5aTUNkdGs3ajduNElLS2VtaDhhSlRjZkhZY21tSEhPUHk4?=
 =?utf-8?B?eGZpS0JyWjJIajgxeUt5ZXBrdnh3dXBSMUhGUEZqYlhUVzUwUndBb3gzcVM2?=
 =?utf-8?B?Q2wxNmxEZmlPSTNFQ0pvaVhodGVzemRLWVpUQkxaRk5IVjBNQjJNb2MyNS9r?=
 =?utf-8?B?K1p3NnRYOWRneHVsN3U1Y052d2JObzNtUVdCYjR6RjlhMit4ang2VHBGTFI0?=
 =?utf-8?B?c2wvN1kxMXRZM0hPNG0rK1NuWFRuN3E0eHpJWnZPY2lmbTFkMHBjd0UrRWVC?=
 =?utf-8?B?azJRQlpzdlViZWxVMkkvazFGTXpnV2dWOTgyRnBjcEg1RkJwTlFHM0w5cFdt?=
 =?utf-8?B?NU5Hd1o0bXFnWXg2ajJrL3ZxSTZNa24zQ0prVFdmeWFCTHBCRk51V3pIU2dn?=
 =?utf-8?B?cVhSdGR6V0VKMFgweDJ3QjNBS1JwbmNHRk9SZktrV0J4VHlRSFdMRlBKbXdK?=
 =?utf-8?B?RDlhM2NwSlZTYUtHUCtNVWx5TmI3MDIzQ08zZU1IZ1N0K0ZkNW5aaHVCMjN1?=
 =?utf-8?B?eXNDUDVzYzRzRStCMFR3YSsyYVhuVHZSNnllTWZUTHVuMTE3MEEwK2lYOGZH?=
 =?utf-8?B?eFBCbHM0WGF0UmNjcDNkNjJiYi9VZksvRi91MTNLRUw5aHBVWllseTgrUTVs?=
 =?utf-8?B?NlE5dHBVOWQxVmxuOGZoZEFwMzE3SHhudFJNOWV1bGZHNVNQYXNjSlArcVk5?=
 =?utf-8?B?bE1meTJHMWNrTDRCNjArMjF6WEJ2VGJ6UldVYVNmREZuN1BaVGE3cDFyNWpu?=
 =?utf-8?B?VjVyeVBWZVd2Um83NHlydm1tdFpwVUlRQ04wQndtTG5uK2ZCcFpQVGkySWxz?=
 =?utf-8?B?OXRLUy8rdTB5UjczdDBXQS9qZTZqWFh2b1pkRXRkUlFod20xYVg3ZmdYZVc3?=
 =?utf-8?B?NEpyaG5hK2gvdmVrclA0KzhnL0JFN3RxZUZ1enh3cHJENHBtRTA2Z25TYUU3?=
 =?utf-8?B?aWRsMGI5MHhwelNRaDRCZGFqNmg5Nk9INEVFNlpCYWtkWW92bmlLYURmWVA1?=
 =?utf-8?B?c01wSmRCTHRKSmpES2h0N3o3emlaZFZSNU41REhFd1hYcWtZVDdGL1NHdXZ4?=
 =?utf-8?B?RHJFM2h3S1ZpWnJhaGVrMzlxdndsMGRZeW5HTnZmcWY5WkNwYm56dGlXSVJ3?=
 =?utf-8?B?NWd2TDFDVHh2QjlBNXZUZkVaYUc2UkFuZDZZcHBWN1A5UkVLRjZka2NaRGFI?=
 =?utf-8?B?bW8wVDZGOWt5cUw5bk9jbUt1dUdpT0ZLNmRWV1NMZ2M4WWlCZG5ISCtqd1Rm?=
 =?utf-8?B?eFllaENzNEx2MEdnOWQ1WGZlTWRrazEvbkJ2YkRlcUU2R09BRFdaeS9zR2hJ?=
 =?utf-8?B?NndIRzNBUURjTjdtQW9ZMFJQZTZrLzhlRkMvUlhxUXlDamVXSUhna3hUeGYz?=
 =?utf-8?B?NXd6NzVBdUh6dXV1MlVnaGg0YVU5TzJSd3c3TG5zMFZlWk9OWHI1NXk3cldo?=
 =?utf-8?B?ekdMQjBTanV5RUsyVUJLZTBvSEc3WSsxZ21KTTV2Uy9acWMwTlVydGRiL3Fi?=
 =?utf-8?B?c3hmVGtOYU5BdkRQL1pWdE13MnRzS0pPOGxIVzhCMTQ5YWlXR1NFaVVhN29T?=
 =?utf-8?B?QlB6T3dkRE5XQ0ZmU1JHVnJIL0x0bTFDS3RscEhGeVVLbUEyMUo3bG5TcEZP?=
 =?utf-8?B?S2tMdWF2S1I4cHZUQ3F4ZU9DUlV6QUdld1hnZXA0SGRBMFZia3U5bmpRN1pw?=
 =?utf-8?B?NUZTUWxCNkpyWUc3azE3S1o4ZHJFcDROV2FaN2NISitJcWZ6WjFoL3pENmMr?=
 =?utf-8?B?Z3ZtemczTWFnNStUTDhqNDVCVU5PZTVnSnNBenR4N1hIaGRheUp1dlgxSUJ6?=
 =?utf-8?B?dXN0cm9zU0MxMnA3VEkwU2F4blhrekg4RmVvNVB1SGJCYjk2S3QrQkI1ODJF?=
 =?utf-8?B?VU1wYitKMG41dHNESTVoallmVjl5ckhlQWd4SEhXSXBUb210MFRFeUxwYjFX?=
 =?utf-8?Q?9jywUPrJSP5kQe1Mc2DSeeOq/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F5A7A2CA88C104C81030F2E96BE4673@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6939bb-5d3f-4995-4976-08daed6237e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 08:12:12.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwKI96T6wsiZyuklnFLNojEQLuKsgt6mANDKCjflRMRZLJGEblKLVRT250HpzVSQwDlSuREp+pTJVEwWXtX+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zLzIzIDE1OjMyLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
T24gVHVlLCBKYW4gMDMsIDIwMjMgYXQgMTA6NDA6MjNBTSArMDgwMCwgSGFvdGllbiBIc3Ugd3Jv
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
U2lnbmVkLW9mZi1ieTogSGFvdGllbiBIc3UgPGhhb3RpZW5oQG52aWRpYS5jb20+DQo+PiBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBUaGUgdGVz
dCByb2JvdCByZXBvcnRlZCB0aGlzIHdob2xlIGlzc3VlPyAgSWYgbm90LCBpdCBzaG91bGQgbm90
IGJlDQo+IGhlcmUuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KPiANClNvcnJ5IGZv
ciBtaXN1c2luZyB0YWdzLg0K
