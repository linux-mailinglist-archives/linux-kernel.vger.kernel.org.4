Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0976C3C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCUVQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUVQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:16:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE056153;
        Tue, 21 Mar 2023 14:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcuqeBrFb1G5KI/8wc6EQigm2hsErTtvFNKxvYeh4mN1ikf+fYqe/cKYZXK8+vlF7J10xb1lGIS0iiLVqhP98LxfwY3yckS/xRpzK9HJL5WZyxajbILuxzh7snwbZpxLVtkPEC61HpjJtnwv0bQWuy3HO6jIiHnCqsTQYXCkA7TJ+KGr7uPdMmKoWDeyUP5KkIImglxsV8rvFx29FbjV2VrMpWzZGFBCJqs9GZQsjytuNF/akhuqn7Ipin8C+w3ct4Em3S9newfyTDNzkH8Ub6SQqYgPDocCzrh1YTqMmxD3z6SlOMb5Ck5WIYHvR6U6IaDjLJ4an4zgXf/sI7ri0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phWKwR1ej/qVaATPFcfAx+tXecBgMESmbH+IVZbDt78=;
 b=Wbmwo9CLlvqI3SM5lucjdrrvX772gp9tOLqBDfccwoPzhh/EfLrjFH0dykp+2QjlZfL8Jn6iqaPzRTl+nD5eXSvRA+skihfAFi+taaQEkYHfPJF1O5jh3k8u0G62WZx6Bka5Wzp6iHqnKCld+/kRP0FIevNM3Gwdt0pgkV0Br6xShjlVNLxqxpIjR6t/u+Glgd1/FfYAimqY3E4OAX58KKAL4yzh0vaOoOP8TB0wFft6g6i7l2YbNSdMrGQow1yJ6UAyhdbpfDTtXcXOTPRMhIFHHGZYv4dBV0/Pzw+mxWvVTTwuMKhJ2sCuJuNlvs4AxJNaSii9JGDESYy3KhpAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phWKwR1ej/qVaATPFcfAx+tXecBgMESmbH+IVZbDt78=;
 b=HCrYucP6ugQcqYfbVRtj+KhVxWDrnEb/s4m86auv5Ke+sA/g9eQkTSfWlFplBlC/e2V3jXayc00JwW4Dn/vAjkPPl98Bl4iSzR3/tMjxgL8qzlaoN25jPaWdtTYcAiYogCXwbEj34czCERu5TNxUD5zO4TVFd2QhmtWPyefDjL0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 21:16:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 21:16:11 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Grzegorz Bernacki <gjb@semihalf.com>
CC:     =?utf-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "Allen, John" <John.Allen@amd.com>,
        "Held, Felix" <Felix.Held@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 7/8] crypto: ccp: Add support for ringing a platform
 doorbell
Thread-Topic: [PATCH v4 7/8] crypto: ccp: Add support for ringing a platform
 doorbell
Thread-Index: AQHZU5ZvtSFTc1cVEkWM7GNwTi1VX677tWWAgAoXS1A=
Date:   Tue, 21 Mar 2023 21:16:10 +0000
Message-ID: <MN0PR12MB6101A10A0EC4EF7CA48C4FC5E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230310211954.2490-1-mario.limonciello@amd.com>
 <20230310211954.2490-8-mario.limonciello@amd.com>
 <CAA2Cew7p7iu=J_4pFjWCHFZuGva0tkdmmdy2QmBdK_fXVxm07g@mail.gmail.com>
In-Reply-To: <CAA2Cew7p7iu=J_4pFjWCHFZuGva0tkdmmdy2QmBdK_fXVxm07g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-21T21:16:09Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d70293a9-383c-4477-b080-2ed7b577ef06;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-21T21:16:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 38b8fedc-d21d-4995-aa73-7788ff4a4423
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BL1PR12MB5080:EE_
x-ms-office365-filtering-correlation-id: 8f7b7105-7b4e-4e56-8975-08db2a517eb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0Zs/IkZyDF6a1YzjBd2JpGfW1UCxBj07mF/Hieg0bibluD52JWGcoRdkGonMuF9srF2kCxBGUx1rEOZqRHvRpPfKI1tz7u6eEhjSKlis4K36KLjoLi2ajOJnbMyqhx/PO9apNYLQMmDycvupij3kx7imbWVLxcVN5TretyZgmdNe45Kwok5SfVktGTOSlANjn/4kwM4JqrS26L9dAYLtuD8J1EnuWxZHYRzp050Ee3m5qg3Vm3qIs6wQbXy3cywpnFv6Pr7eX1O2CTIya/cz/yk0Owhb4jDe44WJfuDDcotFjV1BOpFZ309s2o4zM3+PEsnQx1OxCQqP3C20v8/SScZRmPTOwkyquLXWd7fSf4wa59gQvIchKfAuDlnFfHg4WyGY/15MQSXVwCkM+W1d2RANrWZ9dUOa0ptzQGfUvbXlhdEQOQTAtLiSf4kQNuXiqWADRWnYCdN1E1vOm0reOYIdSoXruBJ3/NZmvDataf2w+8cziKW9jOS0QMOr4mkjKVu0zS9FsZQjG/xx5qrlmWHTNHKOICe4ynaKfV+e3vsYL1ncWfOVX4lat1EJ6UuVOUMQHIRGi1tN/lZfAUkN39NWtysmnDVv8aXPWyZCdobFNaxhGnfHdD50kWWoD+ZAqtpBf6pfJYoZkB2KEbQwr5mhgrBx6Zh4cmDem/4o73JIXgQRYX3GuwLgQZw0X2shmTWnwuj8hHNYNJ6s8P4Gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(316002)(33656002)(83380400001)(86362001)(9686003)(2906002)(8936002)(55016003)(26005)(186003)(6506007)(41300700001)(52536014)(6916009)(64756008)(4326008)(76116006)(66446008)(8676002)(66946007)(66476007)(38070700005)(66556008)(38100700002)(7696005)(71200400001)(122000001)(54906003)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGN0MVNVQmdrQ0pXei9FZWxld0tqZ0NSV2dyQkI1OEFqYm1PbysyMWptUHFl?=
 =?utf-8?B?YjNXbjF0MmErT2RCNENQL3JJYkszZDFNMXREZ01SZC9nWHoyTzZDK001TE9Y?=
 =?utf-8?B?b1E0ZFc5K2kyVURTY20xdEZhUnFzSnVOQTN6LzdXVnl3dS9vL0pmUVRJR08v?=
 =?utf-8?B?WHJWSEZMRG5JYnAvSXM5Q3VKYkIvdXVxTFpiaHYwL3BJcVZYRzlYYXg0b3E3?=
 =?utf-8?B?Nk4xVlB0V2l0alUxZXZWNE4yTDZ1dUJIVnVFZmVJWERXWDZ5SkRVamUrUGRQ?=
 =?utf-8?B?ODVUL2NCTy8xakRXNWQveXZ6djNXTGZaL0poVC83eWduT0duWEhmM2R3VkxP?=
 =?utf-8?B?ZlV4NDlYeXQ2SkpuT04wZlU1KzVnb1JUZ214NGRaYm96OWxOOUs4R1RZeWxh?=
 =?utf-8?B?cjY2RkJscS9xTWFoOXpPZEtRb3dTK2x3YXRYSjNPekVBNUQ4WnVmdjUyWDFX?=
 =?utf-8?B?TnBtMzBjemFvbnJveW8yM0ZNZzE3ZGJZYzdiUjdubXBLN1lrUDh0QXF6NnZD?=
 =?utf-8?B?QnlSN0E4OUg0aTV0WWFya3BaTENuUWZLcUdydWlpWG5yeDBWWDFtYWNLZ1RP?=
 =?utf-8?B?czZwZ3VIS1RSaytGbDVnSVEwSStTQ0w3SkNieldWQUpiM0VaOG5BdlA2RXdu?=
 =?utf-8?B?a09Fa0lySXBlY3ZhUjg2Wk95UzdSSHRnSkdHVlFhMi9iWm1yN1FURVpUZ24v?=
 =?utf-8?B?dGhDRVdrb211MGxaTkx6UnA2Y3BWVWxuS3NkOS9rVk4rVXN0UWdrdXRua3JP?=
 =?utf-8?B?elduaGlRSzlkUlJ4N3dTeHFCeVNGVmk2ejgvdlZQbGVYY0FSN0FpT0R3c0E4?=
 =?utf-8?B?dlZlTkdiWU51d0JKa3ZibUlYS3B2VHRWNW1SVkI0ajVWU0dweDl6azRsQ0Rx?=
 =?utf-8?B?SkhjZlZROWsvNjl4SGo5bkJYMkxIOFJ3SmhwYmd4RUxhalk5UUNHTTlvL3U3?=
 =?utf-8?B?NHZScEdHUlF1c2I4N1Q1cjJWSHQ3V2NVeHQyU1RxdzByU3ZHZTFqMWlZMEs1?=
 =?utf-8?B?eUhrbThOTStFeTNxdW1Fd1F4OVBFVkFJNllCNTl1VlB5MTV5NFdYVTh0SlRJ?=
 =?utf-8?B?cEpjU1RtbmFMS3FPcURCN3RCOUhhSHoyaHFzSm1ZaGdvajNXUXFYa0FJNHh4?=
 =?utf-8?B?TmhheStjSDNnYkd2ZjI0NlJPRVp4VlpCVTgwZVgvYUhSQUpnU2lGcmhpZDdj?=
 =?utf-8?B?VGpWMHpJSWphZk1TYkpQVzlpMkRobUd4czNJbG9TMk14RnEzY2toVVJ6a3RS?=
 =?utf-8?B?bXY3VU1FNXhDcXpqdkhsRWtHVnR0Uy9QNjRKWVZWa1lsMlVIWGh4QmJkTXA1?=
 =?utf-8?B?SmZ1QXhXQTZ6TDByL1NzMHFmUnhWWU92amRRUUlIc1pIRExTUExtRUsvNW1y?=
 =?utf-8?B?NmRvcDZrZW1DKzlmbm50WFdySkNwVDNnRjZGcU5XNGJteiswblpiVDAvTU9O?=
 =?utf-8?B?bmlnbW8wdzNQQnZvcGxZVTUrcGZOaG42VS9DYjF5RUVOZGIra2hTd1ZYV1RY?=
 =?utf-8?B?cWcrcnpFMlN0VzU2dzdFNUt5bEJMZ1Q0bWVEdktpZVdFMXNDSWx0emJ1MFVv?=
 =?utf-8?B?ZTdMdTh0SUJQM0JzSDF1NFo4ZDFIblp4UzZhVWEyZkFoOXMyOXJIMktvNXZE?=
 =?utf-8?B?R0QxOUo4NW9TL0hHaC9vbTl5bEthVGRPZ0FpR1JvTlNlZVdsa2ZVK1puQms4?=
 =?utf-8?B?b2RvVDN0T1dUcFNhRW4zSllxajU1RE9NdWVPb05UeWtEWGgxMmtSMVJGZEQz?=
 =?utf-8?B?em9Wb0wvODZqaWpCSlAzem9wM3BHMEZCRDVrYis5YnBHUmgxKzlyN3RzeVZB?=
 =?utf-8?B?RDUwb2JqeUV3UXJIUVcxSzRSZmpINDMrOGdQODZuQUlPK1NxbUV2V1c0M1hq?=
 =?utf-8?B?VWxqOHVyZ3htaFZxeUdjTC9KOHgwVVA4NnRwRy9jdy91OGFsR254OEF5YlV3?=
 =?utf-8?B?bC9KYzg1aHR6ZWhnUHMvbWRrOHFqTmlZR3FNcG9xc3FadmVtMll3NXd3Nk9G?=
 =?utf-8?B?eG54VW9TTkNWSXJhTmhBVm1NUWhMNXBnazMrL1FycXhQU1lGcHpmMytoU1Ir?=
 =?utf-8?B?NkRnMlZuOTZZRU1YOTZFNUdCZ0t6N3FlSW0ybHA4WGpaN2hwMk1VVWRMdXZw?=
 =?utf-8?Q?tMZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7b7105-7b4e-4e56-8975-08db2a517eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 21:16:10.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULgNBSmSUkn9n0RBms9KVm8kgpMHMxgnH9xcA9/XSb6Y9QXZp5jwg3CfeTzAXZ0RJbnNbVv8BRNtTThHJFJbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiBIaSBNYXJpbywNCj4gWy4uLl0NCj4gPiAraW50IHBzcF9yaW5nX3BsYXRm
b3JtX2Rvb3JiZWxsKGludCBtc2cpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBwc3BfZGV2
aWNlICpwc3AgPSBwc3BfZ2V0X21hc3Rlcl9kZXZpY2UoKTsNCj4gPiArICAgICAgIHN0cnVjdCBw
c3BfcGxhdGZvcm1fYWNjZXNzX2RldmljZSAqcGFfZGV2Ow0KPiA+ICsgICAgICAgdTMyIF9faW9t
ZW0gKmJ1dHRvbiwgKmNtZDsNCj4gPiArICAgICAgIGludCByZXQsIHZhbDsNCj4gPiArDQo+ID4g
KyAgICAgICBpZiAoIXBzcCB8fCAhcHNwLT5wbGF0Zm9ybV9hY2Nlc3NfZGF0YSkNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICsgICAgICAgcGFfZGV2ID0g
cHNwLT5wbGF0Zm9ybV9hY2Nlc3NfZGF0YTsNCj4gPiArICAgICAgIGJ1dHRvbiA9IHBzcC0+aW9f
cmVncyArIHBhX2Rldi0+dmRhdGEtPmRvb3JiZWxsX2J1dHRvbl9yZWc7DQo+ID4gKyAgICAgICBj
bWQgPSBwc3AtPmlvX3JlZ3MgKyBwYV9kZXYtPnZkYXRhLT5kb29yYmVsbF9jbWRfcmVnOw0KPiA+
ICsNCj4gPiArICAgICAgIG11dGV4X2xvY2soJnBhX2Rldi0+ZG9vcmJlbGxfbXV0ZXgpOw0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChjaGVja19kb29yYmVsbChidXR0b24pKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGRldl9kYmcocHNwLT5kZXYsICJkb29yYmVsbCBpcyBub3QgcmVhZHlcbiIpOw0K
PiANCj4gQ2FuIHlvdSBjaGFuZ2UgZGV2X2RiZygpICB0byBkZXZfZXJyKCkgd2hlbiB0aGVyZSBp
cyBhbiBlcnJvciBpbiBhbGwNCj4gY2FzZXMgaW4gdGhhdCBmdW5jdGlvbj8NCg0KU3VyZSwgSSds
bCBhZGp1c3QgdGhpcy4NCg0KPiBbLi4uXQ0KPiANCj4gPiArDQo+ID4gKyAgICAgICB2YWwgPSBG
SUVMRF9HRVQoUFNQX0NNRFJFU1BfU1RTLCBpb3JlYWQzMihjbWQpKTsNCj4gPiArICAgICAgIGlm
ICh2YWwpIHsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gLUVJTzsNCj4gPiArICAgICAgICAg
ICAgICAgZ290byB1bmxvY2s7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBBcmUgeW91IHN1cmUgdGhh
dCBQU1BfQ01EUkVTUF9TVFMgc2hvdWxkIGJlIHplcm8/IE15IHRlc3RzIGZhaWxlZCBkdWUNCj4g
dG8gdGhlIGZhY3QgdGhlIHZhbCBpcyAxIGFuZCBtb3Jlb3ZlciBJIGRvbid0IHNlZSB0aGF0IGNo
ZWNrIGluIHRoZQ0KPiBvcmlnaW5hbCBKYW4ncyBwYXRjaC4NCj4gQ2FuIHlvdSBhbHNvIGFkZCBo
ZXJlIGRldl9lcnIoKT8NCg0KSSBnb3QgYSBsaW5rIHRvIHRoZSBzcGVjIGZvciB0aGlzIHN0dWZm
IGFuZCB0aGF0IHdhcyBob3cgSSB1bmRlcnN0b29kIGl0IHRvIHdvcmsuDQoNCkFzIGl0J3MgYSBj
b21tYW5kL3Jlc3BvbnNlIHJlZ2lzdGVyIHRob3NlIGxvd2VyIDE1IGJpdHMgc2hvdWxkIGJlIDAg
dG8gaW5kaWNhdGUNCml0IHdvcmtlZCBhbmQgYW55dGhpbmcgZWxzZSBpcyBzb21lIGtpbmQgb2Yg
ZmFpbHVyZS4NCg0KQXMgc29tZSBvZiB0aGVzZSBwYXRjaGVzIGFyZSBtZXJnZWQsIEknbGwgcmVi
YXNlIG9uIGNyeXB0b2Rldi0yLjYgYW5kIHNlbmQNCm91dCBhbiB1cGRhdGVkIHBhdGNoIHNlcmll
cy4NCg==
