Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0137F62DCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiKQNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiKQNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:30:42 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2120.outbound.protection.outlook.com [40.107.220.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222D716E5;
        Thu, 17 Nov 2022 05:30:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBcRpTdv7bluES9xoJTgjj+v/YhFeaRqYydzUk66XpROejSsEKyBEoo03GcGnSPlxnPpO/PA2lb/m6msNuCqTXtJPNjAEeU9Pv90G+UbqVKA4msIPIkyQhwOBLp1IZYMZWt/4CAhpqNsAgm6zPZTxKkK+uEW2jpPdr8fjuG0Tt9bLw0tXNB8vL4fq394yjsavFHjCsoQq7j9ZOTGF9togDj/9mCRX4EpKDdCGGYtK74rOOoIUk89AZpeNeMeUA7yZvJhcLmpH81RK8CBIkyy9U+iBaurTzLf6ZVTnIuydYzU61qfcr1l1WNsCxsPzTNIH/tU0wT2SScqkgFUzJaZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwWchmefgFMf6E9WtFUWZOMDtkLs62ZuDeqW4c6vJ9c=;
 b=cuVc7CJW6r7WUlIUWRppXUDEgxkgLhY7sD8FKF64+CBhsw1RTzI1IxySCwsl4wNyczmsX9N9l/U8/ynfk/XJJT0BFbvPn4MZrUE9HshmxtCyPibHhzPRYG3xwZK8x76DKgLTa9+rmsUSI3Ij5iJ6JYbWgY2iWhfqREOSHQCO7WIXQ+f/IeuWAk7XVhi2yJLF7AZKE+j0j5mxw1B6uAHTx/dq8McGIlyMGQjYhC1MSdSaoNJ2NiYT0fo96CT4TnYz4z4D9sVh6ys+Zv+tAhjfLeIYNlTd2cWI3OwsXQYXYqQLBlE8f55huRIkIE9laP6l/+vbmgZrxPrM3pD28Cpwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwWchmefgFMf6E9WtFUWZOMDtkLs62ZuDeqW4c6vJ9c=;
 b=nDOvPUxNzAGkowm/ZjEIcd2nTb/JfWln3SZBJzHAnrcV2yHOqlJMzQilKaZ5TNJAB8+Xso3CXXelgFKQyQ71XeoMRMOneci5qDqsuL88WXzdCzO1ZFSthlB0bweAxbJqbPSw6EmxK8bZA0elexKq5lz56THS7w2jaDxF9nGL5Xc=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 13:30:38 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d1f8:ade6:e35a:e841]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d1f8:ade6:e35a:e841%3]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 13:30:38 +0000
From:   Varun Prakash <varun@chelsio.com>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        Nilesh Javali <njavali@marvell.com>, Wu Bo <wubo40@huawei.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: RE: [PATCH v2] scsi/cxgbi/libcxgbi: make sure sg is present before
 calling sg_next()
Thread-Topic: [PATCH v2] scsi/cxgbi/libcxgbi: make sure sg is present before
 calling sg_next()
Thread-Index: AQHY+ROvrIvBtWiJwUynJR7tk4IZx65AcDEAgAKt1DA=
Date:   Thu, 17 Nov 2022 13:30:38 +0000
Message-ID: <BN9PR12MB53242BC46AB8B4A5D67BF657BC069@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20221114150923.3544796-1-d-tatianin@yandex-team.ru>
 <ca3a88b8-da56-d78d-1c01-6d4b4ea6f8d7@oracle.com>
 <84a02b26-392e-994d-bd1f-ecc28231fbfc@yandex-team.ru>
 <9eed00ba-42b7-081e-cfb1-e61a413ccb3a@oracle.com>
 <20075199-1e6c-28ad-1440-4dc61985d8f4@yandex-team.ru>
In-Reply-To: <20075199-1e6c-28ad-1440-4dc61985d8f4@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|CO6PR12MB5425:EE_
x-ms-office365-filtering-correlation-id: cb2e89d1-59d2-4be0-69f1-08dac89fea5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HV2HAYDTaRD+tL6gRlnuYagCKMIuZiBRLdlfS/lU/E8iXWAA5JiwDGYc1J1JJ1WPF50+BtpOoMY6nHef+8dHpq3VEmQvbppCMztePZVbS7P5tz0cty6pwTgLAQvyN7NQJF7VZJYY6rffCKMCyzZQjgFU4erdbXJPlu2SRFZB4GHPFYmhVSfnSQUXArorenqnwE5vPqGuJmGiQsMUuxVy1V9o1EpZWV1qrsqB+cAsVpzBOAsmayxK7ZVkVEzgmjPzU/V2NQVJmM3jCJ6bWDFPWD9ZD43N23Qps9Iv7Q2JnsV7MNfzSGy93LQJK1w9fKVZxStTIeGYKpbVtrpsmN8IUJPldW/1osDYYdapBmNJyLOSRCbLX9ZnaBAgfoz9n3AI3MwqVC7vnYP19K3OBiRJIvunJnCylrzHM/YydtLJY3gWrVtRnHTCRClgsbg+gn449vErd654zHkd/FmVcC0YBK0eCyhGdgJeavraZveJ8BcmH8HOBUBMenbdoOiN8OJy8QEH/Ooe1HNAeRf8Uaq3Cq1fMvyggT4rBWPdfCuD+47NEvepXSuQM6gE/A1B2VMbq9w74hCKljN1XcsFpzMJ/Hjj4Vo/Y3TOeJ3mVYxENuNtyfMg+qktLudtC74VPG2/heNcnea3wFeweYzaDci3YsanjsFX/DklawJeKYtWfC5BARWlpJvq9AxgDduU7ka/uWKP6fVAAJPRYlvzRW8pYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39830400003)(396003)(376002)(346002)(451199015)(38100700002)(122000001)(86362001)(66476007)(38070700005)(7416002)(2906002)(8936002)(4326008)(64756008)(66446008)(8676002)(66946007)(52536014)(5660300002)(41300700001)(71200400001)(55016003)(9686003)(6506007)(7696005)(186003)(110136005)(66556008)(54906003)(478600001)(316002)(26005)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlY1ZkxjSDVZMUdLSWVMeWxtYUhhRmR6eUlIb21FelNtcVEwdElUZFVXQUU4?=
 =?utf-8?B?NU5PZDVqNk5VYW1rVEhWRVdLcm10dVNjRnJRa3hyVXMyYk9adE5kVGw5VnBO?=
 =?utf-8?B?dnpvNTE5TE1TL1pxZWpWL21IM0JxSjBlN0xtWERPWlgrMUNkajVVRDZYbkF5?=
 =?utf-8?B?anA1M0dSSTdVQk1tUWY5dndaWWwzRnFPNFJobjFieWFaOWFmM3JyK25odXBI?=
 =?utf-8?B?UXBtRWQ5RktQZHJkVUVENDIyRi9BWTM5d3BZRHdVTVlQSlNuSWJlY0VwQTlr?=
 =?utf-8?B?L2dRZUpzbTVGR1BoZmVPeUJxby82VEUvUllPL3I2ZDBtLzFvb1hhNFE5Myt4?=
 =?utf-8?B?U1cyOXhZMXpzUmFrYWp5eEdFMzE0WHVVU21DT1JMNmNWV2RDaWdnZjdIcnNy?=
 =?utf-8?B?VTRpYitESTEzMlpjMEpOamM2U0MrWFdjb2hJeTFqS2t3Rlp4bUJHRzRPcDRw?=
 =?utf-8?B?ZnJzbkIyUmRQemsxd0xxU2ZUeFlvZWN6Zm1LcGlISDcxazBxN0JMNnI5cDZY?=
 =?utf-8?B?clhCc1pkZ1ZHbDFEOFBmRWU3bzZnMG45SWhrRUpLZUJVK01lNkZGcS96T2lS?=
 =?utf-8?B?bUJHSFhoZFF1dnF1U1FScTJnV3NjbkF3ZGR4Q204V0cwTFV4ZU9iQ29xKzRS?=
 =?utf-8?B?OHY5dE1ibW1LVFI3Z0kwM085K2luMCtKUEpaTzROVnRSZ0hOdjRLK0h1eUtL?=
 =?utf-8?B?QldxZlZmVHFCT0Vqcmw2SFcrb1k4b3dMdmEwbHc1elIrRmVPVzJGdTFsbEVT?=
 =?utf-8?B?Zi9MVEVFQ09XK0tjQ0tKZ3FkbXVJOG9GQ2o4SmZ2QWppSUxNc0lXbVo3bjln?=
 =?utf-8?B?QS9JRjQ2ZG1ySTVqc1lWOUZuNkpLN1FzTFFJcWNRekdQVWtaem5MdDJ1SERU?=
 =?utf-8?B?M0g0RVR1eFBxL2I2V0RyaXQ2MllZMktnYm1iRGd4bGJ2U2FLaUlYc04xTlhF?=
 =?utf-8?B?c3F6QmlMcS9VKzJZVm1RV3Zsd0tucUFXYUkvQ3g0dUxPTjBaMllkMjlndFZy?=
 =?utf-8?B?RGpJdUtDU3h3cWtiVVk1b3NHUm5STFR6MXczQlFabDhQWU9NUW9YRDhMMVJD?=
 =?utf-8?B?Q3h6NkZnMTF3YlgyWE5XQk5zcmg3RlRxNXhiRlpuSWdEOC9xNXp1cG1mR3lN?=
 =?utf-8?B?RmRHZCtwbFpENkZIOGRyTW0xSUN4VlJQUFVSbnkydnZocjJXMUk4b3JIdkZJ?=
 =?utf-8?B?TytjaTJ6TzFFa0JtSmE5R1drU2RVSlpoVVNKb1FITUZFdjlGaDFzN1UwQmJo?=
 =?utf-8?B?eTBjendpTmJzTWdka2FVQ1Q5L3hpZ21rZ1pIWFE0M0hIbTBQcGdJSHJDYlA5?=
 =?utf-8?B?UmhnNGdTZ0ZtZzFXNkYvZWpWOUpKMllUWVBjdXpNaEVaN0VCRFQ3SzNDS1lx?=
 =?utf-8?B?QnR3NVhBb3RBK2hEbHo0bTB1d0ROdlJuNEphZGFseDhYd1hCa0ZtNTJFV0Rr?=
 =?utf-8?B?ZHJmVFh1RUdMUkgxbXN2bFUxZ0wzRzc2eHQ1TGhUZm1VcjF1cmRKZUxPNFFz?=
 =?utf-8?B?b1lpNlBobVN2bXFlWUFTa3doeDB5bEpOTGEzWkUyOUpBeXZmZnpQRGkzYzNG?=
 =?utf-8?B?NzZ4MkVDK2NhdXdaUkIrZFNzMVdwcUZyYnVQV2o0RXVRcG4wbVMzNytsWE5p?=
 =?utf-8?B?aVh1aCtPU0tHQjlmU3MvNndFMW0rS0QreWJ4eHBrNW04amFKZnNCRHRYMytN?=
 =?utf-8?B?UE01MTVDQmhva2R5V0RRMXV1Q0lHTloyeGJnVU1NWEp6QnpGV3IrRGZ1UGpS?=
 =?utf-8?B?dTMwY2RiTTdESldQc3M1SHhhU25mY2dTV3VvRjZCcDlhbERCaDhvZzdNN3lF?=
 =?utf-8?B?SUI2Y3hrWjdtck9IZmVlcE5oWWc4VDBIOFRqdGtsbjRoNlpxaDJTc1NGY1VM?=
 =?utf-8?B?N09ZU3luK3B1Mldla3Fnd0dtMkpTb3NTK0c3WEdXSFNqM09vbVdVQVNlZDR6?=
 =?utf-8?B?UWtuUWtIR0I5b1dKRVZVMGxpM3dwSk9FWDA0dE9DQkh3LzRVcklLK05qUkNK?=
 =?utf-8?B?YlM5RkUvcUdlbW1BUmZULzErQVlHWnZQMXdHaVhHVnZ6ZzhVTGFMTTcweDRm?=
 =?utf-8?B?NkRZZTlqVDRXQUhxak45WElhanNkbWV2aGRlREZUVVY3RGo2dzNlMWEwMSs0?=
 =?utf-8?Q?7eFuqEvk9MC6fbQNSa/r6jqYb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2e89d1-59d2-4be0-69f1-08dac89fea5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 13:30:38.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HH0zlKbuJ+1spsSa8ayhQn2TyMX9W2rBSe2YVslcHLQHDJRtSEoVsu+ylQXZounBDLt2+K9NktVP6vC30amaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9jeGdiaS9saWJjeGdiaS5jIA0KPj4+Pj4g
Yi9kcml2ZXJzL3Njc2kvY3hnYmkvbGliY3hnYmkuYyBpbmRleCBhZjI4MWUyNzFmODguLjJmZjk4
MTBmNDJhOSANCj4+Pj4+IDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9zY3NpL2N4Z2JpL2xp
YmN4Z2JpLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvc2NzaS9jeGdiaS9saWJjeGdiaS5jDQo+Pj4+
PiBAQCAtMTE5Niw4ICsxMTk2LDcgQEAgdm9pZCBjeGdiaV9kZHBfc2V0X29uZV9wcG9kKHN0cnVj
dCANCj4+Pj4+IGN4Z2JpX3BhZ2Vwb2QgKnBwb2QsDQo+Pj4+PiAgwqAgwqDCoMKgwqDCoCBpZiAo
b2Zmc2V0ID09IGxlbikgew0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXQgPSAwOw0K
Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHNnID0gc2dfbmV4dChzZyk7DQo+Pj4+PiAtwqDCoMKgwqDC
oMKgwqAgaWYgKHNnKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHNnICYmIChzZyA9IHNn
X25leHQoc2cpKSkgew0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgPSBz
Z19kbWFfYWRkcmVzcyhzZyk7DQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVu
ID0gc2dfZG1hX2xlbihzZyk7DQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4NCj4+
Pj4gSXMgY3hnYml0X3NldF9vbmVfcHBvZCB0aGUgc2FtZSBmdW5jdGlvbiBidXQgaXQgYWxyZWFk
eSBoYXMgdGhlIA0KPj4+PiBleHRyYSBzZyBjaGVjaz8NCj4+Pg0KPj4+IEdvb2QgY2F0Y2ghIENl
cnRhaW5seSBsb29rcyB0aGF0IHdheSwgYWxiZWl0IHdpdGggbWVzc2llciBpbmRlbnRhdGlvbi4N
Cj4+Pg0KPj4+PiBTaG91bGQgaXQgYmUgYSBsaWJjeGdiIGZ1bmN0aW9uIGluIGxpYmN4Z2JfcHBt
LmM/DQo+Pj4NCj4+PiBUaGF0IG1ha2VzIHNlbnNlIHRvIG1lLiBTaG91bGQgSSBqdXN0IG1vdmUg
Ym90aCB0aGVyZT8NCj4+IA0KPj4gSSB0aGluayB5b3UgY2FuIG1vdmUgb25lIGZ1bmN0aW9uIHdp
dGggYSBmaXggdG8gbGliY3hnYiBhbmQga2lsbCB0aGUgc2Vjb25kIG9uZS4NCj4+IE5hbWUgdGhl
IG5ldyBmdW5jdGlvbiB0byBjeGdiX2RkcF9zZXRfb25lX3Bwb2QgdGhlbiBoYXZlIGN4Z2JpIGFu
ZCBjeGdidCB1c2UgaXQuDQo+DQo+WWVhaCwgdGhhaCdzIHByZXR0eSBtdWNoIHdoYXQgSSBtZWFu
dC4gVGhhbmsgeW91IQ0KDQpZZXMsIHlvdSBjYW4gbW92ZSBjeGdiaXRfc2V0X29uZV9wcG9kKCkg
ZnJvbSBjeGdiaXRfZGRwLmMgdG8gbGliY3hnYl9wcG0uYyBhbmQNCnJlbmFtZSBpdCB0byBjeGdi
aV9wcG1fc2V0X29uZV9wcG9kKCkgYW5kIHJlbW92ZSBjeGdiaV9kZHBfc2V0X29uZV9wcG9kKCkN
CmZyb20gbGliY3hnYmkuYy4NCg==
