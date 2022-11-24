Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1348263777D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKXLTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiKXLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:19:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18A6F803;
        Thu, 24 Nov 2022 03:19:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODXu5FUt0MP1cdLMMxvT36MRYQGXALn3rNzu78j/3sJKNYQIjPRxFhOMNnuhi3h30OOSj3hFzNwAZJ4VMqlGu1fr8eulb8sBhdqvI5ECSrRYJnraUCsmS4IVVeyptIH/eRqx+8WZ14M2u4OyjOyFfXUDcJ4rxM9yjmNyNtT/NLPnpw1kEnK2G1BLjripJfK9sOfYX7/mid38GxGxC67S3qHbim9668TF52wHpRJjRaev+Bozu5yc4hnDqEfGBQtu5Tv/gD2KImzKN6qfhCaGPMKfmSrzrLp7l2V4ebZHPKmFRlAjN/H3fW4g/aSQl7fk31FwYuE1zcBy6oduopJBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCRQA48zjUdxVVYolsTAAzngoVbA1SN9JL7opgOmIRw=;
 b=D5AsJuzqdJ9G9Nx87tSlG0NpK3hXLur6qB1FOZ+uSLudIFz3fQgcOXxdjcP4rTnFG+c0mEhjizRH08q8raJAnnV2V8n3tPhyghbJ3ptOCXdZ1xE55jAbxi7OKOVK6NfkrwD1sgXoAnBhAez5P2vTT1nk/Q6yR4F9DigOq7Wrx1tSbtN8VJ/tNupo040Hxja42X0KgA6gTH+6BdNLtGLyBXJOfr9dUG+ms6K6hN8lRezTX6ph9FhaeSoD+kQci28fOurqyfDMTEqeGMFkojTIToQk9y5xsbnfQ65cFJQ/Gz/yWdxsJU8dgu1fxguuJ/N79vfFOhxwSOEj4DL4216ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCRQA48zjUdxVVYolsTAAzngoVbA1SN9JL7opgOmIRw=;
 b=Fx8H+MyLfTlT72ThvxMOeEQA/x9F68bc7whBUb5WPkY/fcENpZz4f0xgpAYlSu32qqM8BxzHknJ2uXYA4CHF74kKriSJh1gTYiqElgyRbdyCbICyEIhwQzlU8HFjaGC/96nkdurlBXRZbqBj2IJbF37gjULrMWdIyfS3EOKsvAU=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 11:19:37 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8728:282c:9d7f:6a9f]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8728:282c:9d7f:6a9f%9]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 11:19:37 +0000
From:   Varun Prakash <varun@chelsio.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Denis Arefev <arefev@swemel.ru>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
Subject: RE: [PATCH v2] cxgbi: cxgb4i: Added pointer check
Thread-Topic: [PATCH v2] cxgbi: cxgb4i: Added pointer check
Thread-Index: AQHY+5mOaY/YPPQGGUqf76YgVH0UrK5N9NXQ
Date:   Thu, 24 Nov 2022 11:19:37 +0000
Message-ID: <BN9PR12MB5324F515DEBD4813246FCF8EBC0F9@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20221118121740.128877-1-arefev@swemel.ru>
 <bb060ac3-b413-6db7-9738-0774764a9457@oracle.com>
In-Reply-To: <bb060ac3-b413-6db7-9738-0774764a9457@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|SJ0PR12MB7006:EE_
x-ms-office365-filtering-correlation-id: 555b3d9a-0f72-4655-a67d-08dace0dc5ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BS9ScuinJs47ETsnoaHHeHpl42EDiL2LJ1QGXF2N9NPch5uOocjT3Il0OkvZ2LiAHOJGPjIuSYIssw9wJI6SiIX0LvojgmV2o0ZgFQw8FUe+c3vnHAeeJofujrWDBrU5EWL2LV5NN4MnZmpFKUSldVThQCZ6TlSz8bfn9iE8ykI1WdH8C05G0D32jJDe18vbroUxIKa6TEK+kZOU7LeSFWfx46uAQRjUjQmWnf8Sf6hIxMZTJ481BSoPflg0Iks9nHnwuzhSKJOnlryHdozhPEFaTyiptRvTKCYFs0om76Kx+Fuijxeo1msfFScDGR1SlU3VqRdBlWBdgi74M5nG82LvK47JIiXkf3mF07UvwtOFzzSEUQgdVHwKoFqBSRXKd/0A2Ru+bli5Vb5AVTN/IDCXPs2COAMdO+zDGWo/7+gagLCUVsImZtWToPADhW4NBQnjAWppudqyx3qPaC67N8U3OAuvS8UA1fo1zFPeX83+wuKaBW0UiIMAOfxwywyrBACQ/58cw5VyGXJISYyRvw7FBLh+a1y4sD/OdMhlqPe7v7zTgSEoLgf3Kn/MprZm4SK9EGqsOb2xFFrvtZoIv74PM3ZMlZhCyR3ZmdRJ+ixl72nD34rsKa8W/s2DzGMSuZzFDbCzrVUBywhuljKs+JxfFpSUG1WNH7nRxftaoNmRx9A4FKpC/jH1Jokfum3hT6tiDt8oBxN9y4WPXb8OMr4L5B5woVo86wpM0I0PTXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(376002)(346002)(136003)(366004)(396003)(451199015)(83380400001)(86362001)(54906003)(6506007)(110136005)(7696005)(71200400001)(38070700005)(55016003)(33656002)(38100700002)(122000001)(186003)(52536014)(5660300002)(66446008)(9686003)(26005)(478600001)(64756008)(66946007)(66476007)(66556008)(76116006)(8676002)(316002)(2906002)(4326008)(41300700001)(8936002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpBYnFSWEc1VGRIVEt4Y1JQazdjY0Z0TjJha0VCRUF2S29ucEFmY1F2ZXd2?=
 =?utf-8?B?UDhXcmFhT2paV2ZZc3VBOWRodGxQRkVPSjRUUTE5YWMrcmVvNHVaaVRCTi9I?=
 =?utf-8?B?QU9ZYkVVcmRRWEhqczlNL0N1ZW8wc2RBd2U0V01sdWpkcTl0U0FBZHZ4ZGxD?=
 =?utf-8?B?dmR4THRZQlVPWjV0alhaL0lZRnJYRFdMS05zS3dOSjJuOTRNTnRraUZ4NUtv?=
 =?utf-8?B?M3NubTRjQWdCWi9EUFdpU3RiVjBtWUJFb1ZvOHNRcVZWejFwUkR6RjhVam53?=
 =?utf-8?B?T095eDdNWkRob0QyRzB5aXFtaGN1azQ4a0tWRWR3Tm1UVTFCQWFnOHhjRkUz?=
 =?utf-8?B?UDZFbnhGZldrZ0hEZlorUHhpZjhLQXJOQ1RaVFRDUGMwcHpDTWZSUjZNNzRK?=
 =?utf-8?B?OEE5K3kyRW4rU1VsRnd4Vzd2eWJ0NGlQY1hlSFh4bUFPNXRFUWh3Tklyd0dJ?=
 =?utf-8?B?ZVJqYnRJNTNPMTZ4WVZxTUFjTVZMZm9lM0hFZ245MllOejZxZFRsWE11angx?=
 =?utf-8?B?V1d6UDZvVWxSSUlHdzM4MTQxSnV5U1lHaUVLTVZFbjJCM0ttS3lIc3FmbVlG?=
 =?utf-8?B?Vk5kNTJIelBKMEJla0N0Rjg4Uk9zSk5haUl4VitaMTFWMUliQmRaNUwxcDJL?=
 =?utf-8?B?VkdxK0s4OWx3YUVZbVpGNVYySi80eDZmY2JCMU9ydE11Ukx6MHJ5dDladXV3?=
 =?utf-8?B?dXVmcEViQ2xGUmFaaTlKMlhsUlNNMmZZYmJmSERtd1lZVmJQWTZGaDQ2b09z?=
 =?utf-8?B?UHpOanZCdE9peWd0VEY2UDEyc1o3WUJSbHNBaUZNZDBmWldtbWFBcUluOTQ2?=
 =?utf-8?B?Wi9GcjV3Z3ZkaEo5UktiaTY5UFpmNk1kU3JWTkJyeFVoa1pHOWM4R20rK0ZP?=
 =?utf-8?B?QkVQcENuNUNkNnV6Rkl6d2grYVZaVTlkMUUybHJxV092T1N6cXZIOXo1dzJQ?=
 =?utf-8?B?SzZBb2V3dk1Eei83cm1KMnpmV2liMDNkTHZuQjBEbUp0bEhHZXRFak9VUGwv?=
 =?utf-8?B?MlN3enBQcTk5UFNjRDlIbVNCNlRkZ2tSUENzd0U5Y3FNRktPaVBKYnRZbjU2?=
 =?utf-8?B?d1owd3V2TERCM1VWUHdNVHlYMUQrSU93dXRXck9WMjA5SVplajNMbTB3RGN4?=
 =?utf-8?B?WWpEWTdvWHN6UGxpa1RhWFFYMVE1aHA5VGZsSVVjTmJyUjBLV1BUYmdRZHRX?=
 =?utf-8?B?TzB1ZEh6Q0JXMWdNNWRkL3U4WmJ4TTBJSnJGeTN0Y3FBdm82L2lQUXcrTWNV?=
 =?utf-8?B?MHhoTnNOR2pTQ0c4VXMrVjFoTTZnS3pNbU1ZRjhWa3o3OXpQNkhrcXpZV2Q0?=
 =?utf-8?B?REZaVndKcWcrZlBIRU14djJqV0dMV215RFhMYWIzWXdCeENhSFM2c0MyQ0t1?=
 =?utf-8?B?SmczSUh4OWZmL3hqby80RFl5SUswbTN1bW5NSjM1OHFRREk0em8yNzd5eU5U?=
 =?utf-8?B?UzlqeVRDb1VHbG5Uc0NsNzQ2MHFPak9uRnFiblFTbGRoLzZRM1hVSzFtYVQv?=
 =?utf-8?B?SlZpNWZJUys3aU1SSlVlb1hzNTY4ZlhpSkZ6MDlsVzRjN081dlNIS2ErenNG?=
 =?utf-8?B?eFlBRERSeWJiaGZ6NEMySjJDS2VrR0w5NWd6eVR1N3YrSmV3RmhGcFpSaXZa?=
 =?utf-8?B?Z25YR2tUQ0QyMlRWUFlidWdlNVRYRjVMditsQTlzODg3R2NhalBoU0V4Q01z?=
 =?utf-8?B?RHZLYnZuaTJhSkxnQlQzK0JPb1JRemJoYzhoWk9Nb2FQVzBVdW9pcThZK1VG?=
 =?utf-8?B?SldRempmaGNYbDNJODdlZG4vSytZSEFvVnU1M3lqWWJCVll1Z2NCZTdCejM0?=
 =?utf-8?B?Z0lnMzZzZFA1dXhqYnl5ZFBTYjJ3VDFvRFdDMklocGlWZ0o5UlJMR3VCalgy?=
 =?utf-8?B?TXRNYllnaGNGSDRRNHBlZWFjZkQrQjZ0SFJNamZaTFk3N2NMWXlHNVR6NHgv?=
 =?utf-8?B?UFBVamEvOWhGY0xHejFkV2RQa2VJUFdtSUE5NCtocVBrZ2pZMnFFZFFNYmRy?=
 =?utf-8?B?OFVCM1VzVUFFS01mY0J3VVVQN0d0dU9iVGVRc294azVLMy9qVUpWYlpoN1RY?=
 =?utf-8?B?NUFVN1hGK09FVGFSd1U5SGJmd3Q4Z3BQRmd5NS91N2xkT3BYV2pHWkpwMWpU?=
 =?utf-8?Q?kPMbNS2hBu6WIXK2LWL0M7oB7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555b3d9a-0f72-4655-a67d-08dace0dc5ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 11:19:37.7484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlGV11HyAhAueaq9d+5NWpvNqiKZNqX0wi5+UGFyBjXWrYFoE4pU2Q57CXaEjAJcHLeKf1XWwVdJ81ltyF7nJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBSZXR1cm4gdmFsdWUgb2YgYSBmdW5jdGlvbiAnYWxsb2Nfd3InIGlzIGRlcmVmZXJlbmNl
ZCBhdCBjeGdiNGkuYzo2MjQNCj4+IHdpdGhvdXQgY2hlY2tpbmcgZm9yIG51bGwsIGJ1dCBpdCBp
cyB1c3VhbGx5IGNoZWNrZWQgZm9yIHRoaXMgZnVuY3Rpb24NCj4+IA0KPj4gRm91bmQgYnkgTGlu
dXggVmVyaWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgQXJlZmV2IDxhcmVmZXZAc3dlbWVsLnJ1Pg0KPj4g
LS0tDQo+PiAgZHJpdmVycy9zY3NpL2N4Z2JpL2N4Z2I0aS9jeGdiNGkuYyB8IDIgKysNCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Njc2kvY3hnYmkvY3hnYjRpL2N4Z2I0aS5jIGIvZHJpdmVycy9zY3NpL2N4Z2JpL2N4Z2I0
aS9jeGdiNGkuYw0KPj4gaW5kZXggMmMzNDkxNTI4ZDQyLi5iOTNiZDM2ZGNiMmQgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3Njc2kvY3hnYmkvY3hnYjRpL2N4Z2I0aS5jDQo+PiArKysgYi9kcml2
ZXJzL3Njc2kvY3hnYmkvY3hnYjRpL2N4Z2I0aS5jDQo+PiBAQCAtNjIwLDYgKzYyMCw4IEBAIHN0
YXRpYyBpbmxpbmUgaW50IHNlbmRfdHhfZmxvd2Nfd3Ioc3RydWN0IGN4Z2JpX3NvY2sgKmNzaykN
Cj4+ICAjZW5kaWYNCj4+ICAJZmxvd2NsZW4xNiA9IHR4X2Zsb3djX3dyX2NyZWRpdHMoJm5wYXJh
bXMsICZmbG93Y2xlbik7DQo+PiAgCXNrYiA9IGFsbG9jX3dyKGZsb3djbGVuLCAwLCBHRlBfQVRP
TUlDKTsNCj4+ICsJaWYgKCFza2IpDQo+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4NCj5JZiB0aGlz
IHJldHVybnMgYSBuZWdhdGl2ZSB2YWx1ZSBwdXNoX3R4X2ZyYW1lcyBpcyBnb2luZyB0byBtaXNo
YW5kbGUgaXQuDQo+SSdtIG5vdCBzdXJlIGhvdyB0byBiZXN0IGhhbmRsZSB0aGUgZmFpbHVyZSB0
aGVyZSwgYnV0IEkgY2MnZCB0aGUgY29ycmVjdA0KPm1haW50YWluZXIsIFZhcnVuLg0KDQpwdXNo
X3R4X2ZyYW1lcygpIGNhbiBub3QgaGFuZGxlIG5lZ2F0aXZlIHJldHVybiB2YWx1ZSBmcm9tIHNl
bmRfdHhfZmxvd2Nfd3IoKSwNCnRvIGZpeCB0aGlzIGlzc3VlIHdlIGNhbiBwcmVhbGxvY2F0ZSBh
IHNrYiBpbiBhbGxvY19jcGxzKCkgYW5kIHVzZSB0aGlzIHNrYiBpbiBzZW5kX3R4X2Zsb3djX3dy
KCkuDQo=
