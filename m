Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4472D6A5F00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjB1SuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB1SuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:50:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897A206A7;
        Tue, 28 Feb 2023 10:50:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOOWYOyQu6cyHTCukGg9c2tum/Y22w9dyo0FfESenhU/f92V7E8Yvbez4W0cWM2cfeBFdQmx/Qd6OYO8DPT41xOEkweSRPCWRNwrbJ76H8dF0P6rb8keYkvMpTS0+PXK5srWUL2EBuTXXewObEvRAkvAK8gXtmB8vSuUJ4zbDN6kMyBLyAMgujJ6UxG65+GR5HmezRVeG2Z5ipRl/kAxdY+zU9zRqrPIeZL+W4lIfVkw/sVzNNMtJOw2GtgtVzL7JND07ne5PJRyNNY8tmqd9RMuKvUz2AbaaIaRfCp6uWPj2uY41N8Va0ADifwzDtw55DFfnZ2odj4mmULbT7mM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeZPPSLZPCUH8rMYuQuaquKqYuvnhohOGHLQJ9H4oo8=;
 b=Qh1gn5W7oAZUeYjd5EpUrA4CVL82ispMEb+EsX+RGmGy69JEn2vmQ8t2YEMXNj2dhTxk0jtyWSRGMhsQXnqnfHlA+ChLPwpyQNOX/kEUKagnjVpFgf06IF4EnF8qGrZDzS0KOg4xjZiU586XsJV0IVE/hdvhnO0Ratl208dJcdgDoIEoMGk2hLn97HpmDg2G4CUnuQd5U7JHDquhycIfmD1YR4J3M1HnztJI2123+wtiu+d0H8ThxANCh6j9v44fw2HGYaN9Oi7yQUA725ztjPzxXl4+XRVL1od5Wv2i1h9PyyXIy6mVcORWzgsK8SLm+UiafKIb6ba8+JFhRhiMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeZPPSLZPCUH8rMYuQuaquKqYuvnhohOGHLQJ9H4oo8=;
 b=z++2xjZpW/Qxqjwz/zT6/SamvtJmgwNF2vZDGtgHTlWvmQoZZfmyFC3aCLlVTvl9EyzEKspywf5MKwVm6s07/D3mkHyRniefFz0CuZ8GDtB7LWywwR7kHhMM9jmDu7hzzK1Zjf8te5jFeOfnoArxn+BlB2YIU8BOMsIQhzMNcJk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Tue, 28 Feb
 2023 18:50:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 18:50:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Wu <michael@allwinnertech.com>
CC:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: RE: [PATCH] HID: usbhid: enable remote wakeup for mice
Thread-Topic: [PATCH] HID: usbhid: enable remote wakeup for mice
Thread-Index: AQHZR3iDazov67zqf0SmSMvJFyQb2a7cY4mAgAAKwwCAAHzogIAHLN8AgACeEAA=
Date:   Tue, 28 Feb 2023 18:50:18 +0000
Message-ID: <MN0PR12MB61017A45BEF80013FD7B77D5E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com> <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
 <MN0PR12MB6101B1BF9748F0602684FED5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <f2142d88-259f-302d-da61-e0fc39d1f041@suse.com>
In-Reply-To: <f2142d88-259f-302d-da61-e0fc39d1f041@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-28T18:50:17Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=82dc8a28-f4da-4c7b-86d3-04725088d35e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-28T18:50:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 45b33d81-29b8-4949-ba6c-90538465e816
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS7PR12MB5792:EE_
x-ms-office365-filtering-correlation-id: 4212afdb-a0c2-479f-8918-08db19bca377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JNffzWDy3CIlq1n9GhfixIaIjJbwNkhP5ruko8hF/or7tidC8b5sCloS9FXm5gT+1EM+OzSTZma/2LRZ04keDVtMFa21sltVIRMGbEqv8h6F/HBkkoeloJvf50oWqszzBIKJ3AzBzts381Vq/SJdD+MkiyXlPR5NT4KIWHgfaRd4R6mv7TW8smHPWJcnDCoUYNueuUU082pl0P46Bibsg5BdqrYdovPNyy2RRGFZeP7tCg00pb3Jk8/D+INgP904boOGvR8pgdaSuJbYbH8vvGabxARZ+7X84P/RHvJWpUXBo4InWNRFspDkQZuDa132vJ4rVPnObtb3X144gmSwBUAnLsxktc9n6SU3W9UejgaOfLVysxxXe73ISGexSoW0mfDOGYu0/okSwzvXCFerybya2kCYYo0Efq6Ey20hMRQM3q90vlBydw03e//RQrXxGSCxb3rLDjDWsqaoSpwWJo96th65unpzF15pNbW8MzuD43/C44tcNvgUE7thN6sRJHE0S2o7B/CkIl9bsEji9kIeoEpK5EK+D0UHcsokjYHehs7vmU9ogsV57s64LML43og7kEWDAFea6Az03Nbyb2ZzRUOnVmvX/7QVRSPpxhy7zPT6JzzRUzHGF+gr25td95otukOswO6sbgzWKaBd3YKuceqFxbfnh9KFhiy64y6bAQbdw0e8FZprrHe7aKFN2ng4QlBNVORF1jCmypfeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199018)(66899018)(122000001)(4326008)(110136005)(86362001)(478600001)(71200400001)(54906003)(33656002)(66946007)(5660300002)(66556008)(41300700001)(8676002)(38100700002)(66446008)(83380400001)(66476007)(76116006)(2906002)(64756008)(55016003)(38070700005)(53546011)(26005)(316002)(52536014)(9686003)(8936002)(7696005)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MklOL2ExWEFZVm9TQngxWlZpdW5OS1E5RnFyNDNqWVJ6MGgyTDFnVExmTXIv?=
 =?utf-8?B?ZnpIZjlXMDN4V1dGTGRKbEYrTHV1YjM2T1ZPVlJiR2gvNFVYdEw3R05nS2JX?=
 =?utf-8?B?MVFmeHpSSUgveHppQW8veHEvdDF0akxGenR3STFTaFJUL3ExNUt4NFFxOHUr?=
 =?utf-8?B?bVVmRW1ZUXA3dklhcUlGcWpiRVR5T29MQWpkV3l0eFZ2SnQ5T1hOYThXYkNr?=
 =?utf-8?B?QXRpbzl3R2VmZTRvTERHV0tmUGdqbjZiWTFRd2x4ekFDZ1NaS2dVZ1BmcnFl?=
 =?utf-8?B?ZEloQ09IaUw5N01lZEhRNDloeit0VVpPVVhKK0dkRDBjQnEzeEZ0T0wyZnVo?=
 =?utf-8?B?K0VkVU01WW5QempFdFNuSXdWd2NMNS9pbE1jbkhZOXowRkIwWFlvV2RJU0xX?=
 =?utf-8?B?cDl1eUtpTVd2NW5BWGJOaHd6Yjl1RUlEZUovSFZOcWVBQmJJMkpna0UwZ3NH?=
 =?utf-8?B?Rm03OWN0NmpsRkIrenNabzd5dGNBb210bVphS0V0NXVYV2R5TGx3ZUxkU0VZ?=
 =?utf-8?B?Vk5XVkhMeDlPWnVDbS8weUhDSitZZlFxYkp2SVRCaVFNd281RnQza1ZnYlRk?=
 =?utf-8?B?dGtmTXJWZ2JkSUh2SGM4UHMzdEFDVm1DK3lnM0FScis0Sm9Sd0x1MFVSczhK?=
 =?utf-8?B?QlZVc1kzbVYxQk9WQ1dneS82djNnQ3E3aTZBYU9rL1YvQmYveWZhVjQzNlFz?=
 =?utf-8?B?SFk1L2hKQXNiZXlQN3ZVeWJDTWswbUpBRUo0RnhVNnNBK2FkRS9FUFFDblhR?=
 =?utf-8?B?Q3d4ZXpENlYzejNjMDFpcDIyYmxFMTFCWXNkaytzdyt1SEpIYjI5RnV0M0pt?=
 =?utf-8?B?M2Nvc2NNYmJleTEwTmRJQWZBcnhmNDRuYVFNeHVsNENUV2YzdmRHdklHRWtX?=
 =?utf-8?B?Wmptdkt6L2RZRDlGQXZWaXJBZ2NRUnBBdlRKVnoyT05zUGJDdXJHSU8vbHd2?=
 =?utf-8?B?TXFSekE3MVZZbWp1RkRKYTlTUU15K3FpbzFZSHp2eEZ6OGRUVENIb1ZzU2Q4?=
 =?utf-8?B?MC9nUHl2RkJhK3lyV2dQdnZ3TzhyRE9sc1NQTDhxU1BKcjFKL2p3UXpkYVJj?=
 =?utf-8?B?eUhnajNFSXVkdmNIU0xBMlFrNmRPMnI4R1JBZU15VXRHeWVyV1dUY0ZUYUl5?=
 =?utf-8?B?ZVFZejJuTFhrVnpGSmpDVFJFVzhjR0pFUEpGRkJWRU5MM2xINnpGZk1DRVd6?=
 =?utf-8?B?K2NHMmFtY0w3bWZtZVpha2Jpd0VVbHd3SjhWTkhqQWpuMnA1eWd4Mjh5c0JU?=
 =?utf-8?B?NzZVTFY0NkxRR05uZkJzQU9CKy9Hd1l1WDYzWXBDNmp4Rk9wM01zUjhwTEdv?=
 =?utf-8?B?N0dZSXFxLzVSVVZWTlo5a0QwNWx1cmlDTWgzMktOZFR6b1RITmpVS2gzSmFS?=
 =?utf-8?B?cW5UajRkaGFYdEFHRDhDa1BtRDFzYW4yN3dmME9vR1IzWGJuOXhqcWVHd1ZJ?=
 =?utf-8?B?VzhacWhWOCtadlRRbnprcG45OWsrZlhlMUx0ZWRJYzk1eHo5dDlZdXZYNFQv?=
 =?utf-8?B?TFJWaXhFa0ZDc3lkNXJhWGIyTXNjRnZHUWJUUmdsRm9JMHhlTHc1L0d2c1Y0?=
 =?utf-8?B?UWxYVElXS2RvMklGbTlnaURxdlJPUUI0RzgvallZZjQ0bHVkN2c5T3NDRkM0?=
 =?utf-8?B?emduVG9OQmdzSWRVNVkvSzNlc2tlY0k5bTBacEVOYXRnZ0tSWkNBRTg3Nkxv?=
 =?utf-8?B?SnEyQVBCbDV5QSsvSlV5SWd5M0VxdFZ2VjZZS0h2enJvRXU0a25lTXVqTURm?=
 =?utf-8?B?TVdDM2tyWnFiVmh6SHBwbjI1Rk5RZDBiQ0xsQUJKUkl1dHpJaTNKMkxwSlVs?=
 =?utf-8?B?clExQ0lGQUxmSzZBemtvQytrOG9kQkN2QjY3Rk1QQk9jVDBGOEpPSDgvL2w5?=
 =?utf-8?B?c2hsNUVkdGprNFNzTUFVVnFhSVRacWcxOEdhMU9pVUxneVRtNlJ6cXFubWsv?=
 =?utf-8?B?N3JPMWJvbkJWUkFRUjdTR1A2OCtHWnU2QS93amZ6ajdsZldIZklPQXYrSmVH?=
 =?utf-8?B?TUtDT3ducWExQnBTQS9FVEEyV1R1c2ZHYnJ0QzVKSTFHZFNKV1cxQXgycWFs?=
 =?utf-8?B?UTdLVXcxanVrUGhLNGhuY2V4cytkM25JODdWVmk5b3hLNzJpZzA5bjZVeUwr?=
 =?utf-8?Q?RQG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4212afdb-a0c2-479f-8918-08db19bca377
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 18:50:18.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MJtfqnTwHDDqJlNeothVWpkCqMV+YfTDajpJRcDWZ3C8u8Xwg7ukM7+vyrHz92LERpFq4OA1gW3xcnFx8ev3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xp
dmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkg
MjgsIDIwMjMgMDM6MDMNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IE9saXZlciBOZXVrdW0NCj4gPG9uZXVrdW1Ac3VzZS5jb20+OyBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhZWwNCj4gV3UgPG1pY2hhZWxAYWxs
d2lubmVydGVjaC5jb20+DQo+IENjOiBqaWtvc0BrZXJuZWwub3JnOyBiZW5qYW1pbi50aXNzb2ly
ZXNAcmVkaGF0LmNvbTsgbGludXgtDQo+IHVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlucHV0
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdvbmcs
IFJpY2hhcmQgPFJpY2hhcmQuR29uZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBI
SUQ6IHVzYmhpZDogZW5hYmxlIHJlbW90ZSB3YWtldXAgZm9yIG1pY2UNCj4gDQo+IE9uIDIzLjAy
LjIzIDIwOjQxLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+ID4+
IEFzIGEgc3lzdGVtIHdha2V1cCBzb3VyY2UgYSBtb3VzZSB0aGF0IGdlbmVyYXRlcyBldmVudHMg
d2hlbg0KPiA+PiBpdCBpcyBtb3ZlZCwgaG93ZXZlciwgd291bGQgbWFrZSB0aGUgc3lzdGVtIHVu
c3VzcGVuZGFibGUsIHdoZW5ldmVyDQo+ID4+IGV2ZW4NCj4gPj4gYSBiaXQgb2YgdmlicmF0aW9u
IGlzIGFjdGluZyBvbiB0aGUgc3lzdGVtLg0KPiA+PiBBbmQgYXMgUzQgaXMgdXNlZCBpbiBtYW55
IHNldHVwcyB0byBwcmV2ZW50IGFuIHVuY29udHJvbGxlZCBzaHV0ZG93bg0KPiA+PiBhdCBsb3cg
cG93ZXIsIHRoaXMgbXVzdCB3b3JrLg0KPiA+DQo+ID4gQXQgbGVhc3QgaW4gbXkgdmVyc2lvbiBv
ZiB0aGUgc2VyaWVzLCB0aGlzIGlzIHBhcnQgb2YgdGhlIHJlYXNvbiB0aGF0IGl0IHdhcw0KPiA+
IG9ubHkgaW50ZW5kZWQgdG8gYmUgdXNlZCB3aXRoIHMyaWRsZS4NCj4gDQo+IFllcywgdGhhdCBp
cyBzZW5zaWJsZS4gSWYgdGhlc2UgcGF0Y2hlcyBhcmUgdG8gYmUgdGFrZW4gYXQgYWxsLCB0aGF0
IHdpbGwNCj4gYmUgYSBuZWNlc3NhcnkgY29uZGl0aW9uIHRvIG1lZXQuIEJ1dCBpdCBpcyBub3Qg
c3VmZmljaWVudC4NCg0KQWNrLg0KDQo+IA0KPiA+IFRoZSBrZXJuZWwgZHJpdmVyIGlzIHdlbGwg
YXdhcmUgb2Ygd2hhdCBwb3dlciBzdGF0ZSB5b3UncmUgaW4gdGhlIHN1c3BlbmQNCj4gPiBjYWxs
YmFjayAocG1fc3VzcGVuZF90YXJnZXRfc3RhdGUpLg0KPiA+DQo+ID4gV2hhdCBhYm91dCBpZiB3
ZSBhZ3JlZWQgdG8gdHJlYXQgdGhpcyBvbmUgc3BlY2lhbCBieSBleGFtaW5pbmcgdGhhdD8NCj4g
Pg0KPiA+IElmIHRoZSBzeXNmcyBpcyBzZXQgdG8gImVuYWJsZWQiDQo+IA0KPiBJZiB1c2VyIHNw
YWNlIG5lZWRzIHRvIG1hbmlwdWxhdGUgc3lzZnMgYXQgYWxsLCB3ZSBjYW4gaGF2ZSB1c2VyIHNw
YWNlDQo+IHRlbGwga2VybmVsIHNwYWNlIGV4YWN0bHkgd2hhdCB0byBkby4gSGVuY2UgSSBzZWUg
bm8gcG9pbnQgaW4NCj4gY29uZGl0aW9uYWwgaW50ZXJwcmV0YXRpb25zIHZhbHVlcyBpbiBzeXNm
cyBhdCB0aGF0IHBvaW50Lg0KPiANCj4gV2UgYXJlIGRpc2N1c3NpbmcgdGhlIGtlcm5lbCdzIGRl
ZmF1bHQgaGVyZS4NCg0KUmlnaHQsIEkgd2FzIG1lYW5pbmcgaWYgdGhlIGtlcm5lbCBkZWZhdWx0
ZWQgdG8gZW5hYmxlZCBvciBpZiB1c2Vyc3BhY2UNCmNoYW5nZWQgaXQgdG8gZW5hYmxlZCB0byBm
b2xsb3cgdGhpcyBiZWhhdmlvci4NCg0KPiANCj4gPiAqIER1cmluZyBzdXNwZW5kIGlmIHlvdXIg
dGFyZ2V0IGlzIHMyaWRsZSAtPiBwcm9ncmFtIGl0DQo+ID4gKiBEdXJpbmcgc3VzcGVuZCBpZiB5
b3VyIHRhcmdldCBpcyBtZW0gLT4gZGlzYWJsZSBpdA0KPiA+ICogRHVyaW5nIHN1c3BlbmQgaWYg
eW91ciB0YXJnZXQgaXMgaGliZXJuYXRlIC0+IGRpc2FibGUgaXQNCj4gDQo+IFRvIG15IG1pbmQg
dGhlc2UgZGVmYXVsdHMgbWFrZSBzZW5zZS4NCj4gSG93ZXZlciwgZG8gdGhleSBtYWtlIG11Y2gg
bW9yZSBzZW5zZSB0aGFuIHdoYXQgd2UgYXJlIGRvaW5nIG5vdz8NCg0KSWYgeW91J3JlIHRhbGtp
bmcgYWJvdXQgcHVyZWx5ICJwb2xpY3kgZGVmYXVsdCIsIEkgdGhpbmsgaXQgbWFrZXMgbW9yZSBz
ZW5zZS4NCg0KVXNlcnNwYWNlIGNhbiBzdGlsbCBjaGFuZ2UgaXQsIGFuZCBpdCBiZXR0ZXIgYWxp
Z25zIHdpdGggd2hhdCBXaW5kb3dzIGRvZXMNCm91dCBvZiB0aGUgYm94Lg0KDQo+IA0KPiA+IFdp
dGggdGhhdCB0eXBlIG9mIHBvbGljeSBvbiBob3cgdG8gaGFuZGxlIHRoZSBzdXNwZW5kIGNhbGwg
aW4gcGxhY2UNCj4gPiBwZXJoYXBzIHdlIGNvdWxkIHNldCBpdCB0byBlbmFibGVkIGJ5IGRlZmF1
bHQ/DQo+IA0KPiBJdCBwYWlucyBtZSB0byBzYXksIGJ1dCBJIGFtIGFmcmFpZCBpbiB0aGF0IHJl
Z2FyZCB0aGUgb25seQ0KPiBkZWNpc2lvbiB0aGF0IHdpbGwgbm90IGNhdXNlIHVnbHkgc3VycHJp
c2VzIGlzIHRvIGZvbGxvdyBXaW5kb3dzLg0KPiBZZXQsIHdoYXQgaXMgd3JvbmcgYWJvdXQgdGhl
IGN1cnJlbnQgZGVmYXVsdHM/DQoNCkkgc3RpbGwga2VlcCBnZXR0aW5nIGlucXVpcmllcyBhYm91
dCB0aGlzIHdoZXJlIHRlYW1zIHRoYXQgd29yayBvbiB0aGUgc2FtZQ0KaGFyZHdhcmUgZm9yIFdp
bmRvd3MgYW5kIExpbnV4IGNvbXBsYWluIGFib3V0IHRoaXMgZGlmZmVyZW5jZSBkdXJpbmcNCnRo
ZWlyIHRlc3RpbmcuDQoNCkkga2VlcCBlZHVjYXRpbmcgdGhlbSB0byBjaGFuZ2UgaXQgaW4gc3lz
ZnMgKG9yIHRvIHVzZSBhIHVkZXYgcnVsZSksIGJ1dA0KeW91IGhhdmUgdG8gcXVlc3Rpb24gaWYg
eW91IGtlZXAgZ2V0dGluZyBzb21ldGhpbmcgYXNrZWQgYWJvdXQgcG9saWN5DQpvdmVyIGFuZCBv
dmVyIGlmIGl0J3MgYWN0dWFsbHkgdGhlIHJpZ2h0IHBvbGljeS4NCg0K
