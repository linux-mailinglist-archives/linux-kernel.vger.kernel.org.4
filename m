Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBA6B17D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCIA1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCIA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:27:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC72917F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5nvZ0rTywMANsozrCbyjZnOF97a025SDuX19f4HjDKuBt6XA39EhyVyl8wcGOERGtQzVvEFAPSczDT0G+ooI8uB9yVOvfJnijdNWGoC6Zfl+HyERayr7yHMdFIRaN5ZkNkSHby9N2vJblhrhmf+4QdChe9qmvnhPZMeKVNhlszpQDwzuMk95feN/G9bSPWkL1TaX9yAThSiCFkMzn5MLo+e9cRT5SZ966WUhn2oBLdZvlQC12t60NWtP0wQo/IRNHfoCIuzHS4wDx9xnCEFXxMry6sIFL8kruzYESGMyt8rQMtZK7TNm49at5/A2NjTmdtiSyFMHfutvZtSUMkisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMFF5jaCkjeVyQ+qsDlH1MUaF4iQ+ND67FSMzHL1yvs=;
 b=VGycZEdH7b14KgtblzOenJv2Ap2XzgAgYwXyeAeWhfkoRDMfFcYWB4K9Iajyku3BnrVI0dvranxocCRJh0aw10bsviEMC0qOmW/mRYdei9gFd/QVM8vugRDUfNHKppvoUBTDRXN2RROF6dxI1mASFuw4Yb5O1NqNT80V1OnDiLUgQn6+Cnd5BANCS5RogkmW0+Y2OX8qdjlwCoDZDL+kD0dj3hhO1pZCaqMd8kessNldy3IyvSVYvX9iQXrE4EXY0BeX7e5yO7BTFV1gZvZ0ij2nc1k9cO4+zSrxk8sTkw/LjhgULIYSrsvggS1DfGASTk1NATbU3Eh0yaFi8rM53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMFF5jaCkjeVyQ+qsDlH1MUaF4iQ+ND67FSMzHL1yvs=;
 b=Pr0FKID4cbNIay4QoXEWfka2ewQ8rz7rrx7f1Rb/WNqi/rW93l+nz9bRMPzhYpAEQ0LWwD0nGYX4QgIVFrTNIKiMKKHjtit070JFzQ5HecPePkw0bF7PcyVZXSNDSKlys5QOls0VpT8b4LtBpJ7qtHLP2Z1zawn+tZRZoNbfr6jr4mfONCYcIG5+RrMFYZjrTA/MnD76rkeAFsT3AcrAhfVI9etDI+2unCTfk5RN9bfZZdqnMSiZj2eFT4k3Gbn7NG0nwss7+UEAdxKMspASwA56Yu8igJkN/eR0Oq+tlQRI3TpssR2SRzbZv251/WnpSvXJizdu3qsXiS3Jv2pgkQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 00:27:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 00:27:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme-pci: drop redundant
 pci_enable_pcie_error_reporting()
Thread-Topic: [PATCH] nvme-pci: drop redundant
 pci_enable_pcie_error_reporting()
Thread-Index: AQHZUTQbRxB9kRb98UWh4zmfXrS7SK7xmVeA
Date:   Thu, 9 Mar 2023 00:27:05 +0000
Message-ID: <274e8458-a1a3-815e-73bf-e2bb50ff9f44@nvidia.com>
References: <20230307203243.882202-1-helgaas@kernel.org>
In-Reply-To: <20230307203243.882202-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7732:EE_
x-ms-office365-filtering-correlation-id: ad0ceb17-225b-4a41-ba1b-08db203502f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xq9yGbrGrLSKj1ZzgyXGSSkbnHiJJAMZaU+fR5q+FEVcY6B+is+uwEs8pCRC2SX/6regNqlgELVDZvBaH2R3uiBGiXCSUF4LBIjfCm7+Sta72sg5eEgQeBD8kU73uMNWp0SiiOxrKgKngHehyS5+5KqOsMor09pp4WH9bV3nHnFNLM9f/zQNtY/XjGH0StBx9e81hLFyVW9BK707yM/mO1uKkDp15CuuGwwKccsf545EuyrrAkgwDwD04UY0EHITgNG4UrHZ7htnTbpQ76UZiEA6lTKUuSYZLbjaK1Ho8Nc2xaFbGJazwBMF72HurH/Gh3uBDygybDDmkhLE5dnXdHzAFyJOclR5WycWM3o5dyOtz4ed4sLXQlaHRkkB3vFOgOLACDLnykiFtNsJx0Drk9jjvuMmgfwoYI0Q0xB83SKfctvpOFbjdkInx0Fet4xoe1jnqAOfCZF3bnYrMxq/6zDzMDwZ1dpgM3lou/Pgh2ePm9EqMQ5lp+im/jPZTwyzWo1xcXEzma31XTgk2GWLh5zuVF0Kd8VdgG3+/I8+sb8n8YJoBYFFYmjg3FD3hJ2CyZWWUWlVeHkzmcuOstfkfLOw9rjJ1xXoiNxnn+dPxlL36e7AhOObnJG+Mc4gzQeCfgeAAvyCeGs7Fvk0XJNlRqeNnbT+q7MBtao//Aeo2IiDKTy/4zG3xrUx1dRzSoPVEZ8Euqs9SOoitCKOAb1KWaF4ObKXmkhDBUtvTX0qvsvNgvxCNMzU74g8Mo6IJol8W/hxPz8F4zFqg7LZC6Gr/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199018)(36756003)(2616005)(110136005)(54906003)(316002)(478600001)(71200400001)(6486002)(2906002)(66446008)(4744005)(76116006)(66476007)(91956017)(8676002)(66556008)(64756008)(4326008)(66946007)(5660300002)(41300700001)(8936002)(122000001)(26005)(38070700005)(86362001)(38100700002)(186003)(53546011)(6512007)(6506007)(83380400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWVMbHVMMXAweFp6aDlxNVBOamdqTXI5N3VBMUg0N3ZGQlRRMGF6YTRJVTBK?=
 =?utf-8?B?NGhMb014VEZjZVNMckRNNCtKMzBTQVJ1VXVmS08xcXBpa09MMzB6Z0JrcldQ?=
 =?utf-8?B?NTdJcjNMbFg0TTM3UHU5UnNQZFYwNFBOZUN0NjBtZzdYY05vWVVRQkpXaFBP?=
 =?utf-8?B?bHgrQTlURm9vN2FQSXRDZDhEQ3d0Vm9GZEoyT1ljL1hGVHZSZEZzU0hYZUE0?=
 =?utf-8?B?aDZYcUpsM3dkek9uNlVVQnd5SWtwMjFYaHptZWZvTGpjcWlCR0pja2NvODVv?=
 =?utf-8?B?SkFKTTh4VjVjaitKb3pvZnJiZjJyTlY2TUV2RDdUb1c0Um4xeGt0VmEvMGRr?=
 =?utf-8?B?OGdqcnFUSGJGeE9sKzByeW5RQmF2b3Q0Um1lT0pJQkZrVTRneFJ2KzN4aUZZ?=
 =?utf-8?B?dTlwa1Vzc25ZcURuaEt3YzB4RUxOVmQ3bWw2d1VYdGxReG85N2JuNkxMeTc3?=
 =?utf-8?B?RmtLamNYNUptOEpWeEVleWZnL1Y2NHZHMWJ6MDRwc0sxU0h1QU8rK1dxSXhw?=
 =?utf-8?B?NTZ5dVcwaDZsdjd4Tnk0N01kN1BxK2NjR0pGUSsvREIzaGJ3ZTB4YS9xQVJS?=
 =?utf-8?B?RHFvSXRNOTBXaFdxSEhGbFEwQUFTazFMRU0ya2h2MEhBUHBjdXFMTnU0dllV?=
 =?utf-8?B?UHVOKzI1Q1hYbmlWWllUdzNuMVBZV1NYd0VCWnE3eG1PMEVjSHlUcTZHdFFq?=
 =?utf-8?B?VlVUVTA4TkI2WlJNdnQxMWpKZytkRGJlaVF2cmp3aXIyZ0ovRnFzRzZrdkx6?=
 =?utf-8?B?M0l3ZkZaSUVnZ3Y1WWpoSmpxZDdDdW5QeDB4a1YyTkRwNVJqSzNKbVlydk1k?=
 =?utf-8?B?Y1RTQ24zR3Q5RFdjUUQrUHVBcWlFWmZKMisvY3V1eFQwM0J4NWlxbkFkVEFS?=
 =?utf-8?B?cUxaMTZEWkx2QWxzam1JTlppQkVtYkNCUjBHS1hQM3lNcXlwQjB3Ry83Nmly?=
 =?utf-8?B?VWVBM3lGZHVYRlFWSzRQdk5DZjI3QVJISEVLY1ZFcHFwL2F0eW5iNC9WZWgx?=
 =?utf-8?B?Y3REZy93UEIyOEhwNXZVbkttZEQzWHNPSnpwUm5qMHlTQmdMQkRndEpaSm00?=
 =?utf-8?B?NlEwWUpLcXZMeC9QTjZxb2VWenlLUlp2akU4N2luaHl0a0VYV1BaOEsvMnkr?=
 =?utf-8?B?OXFGeGxKSGZqTkR6alF5OGI0S0c0aldLZlNCRC9TZEYvQjVDNThONWxZbDE4?=
 =?utf-8?B?S2xKOGtKUGdzWmd6dnh4MWZ1bmdMNlhFVUt6dEdha3pxKzZla2NKK2NzMzRU?=
 =?utf-8?B?L2FzT1Zwc1V1QlFaS25jMWtvbndsU29JUGdXUVZBTjZ6aTRtZWVRNjBDQXNS?=
 =?utf-8?B?SytycmZVdkkzTVNicDI4aWg3a0o1dElGbW1LWnVJVk1paUt6aWlyL0Vlb2J6?=
 =?utf-8?B?NHlyVVhPTi9OY09jM2I4WDMxVkF0R3crQ01PQ294cUlYK2REQmdTNGszSnox?=
 =?utf-8?B?eVdwcUtIOWFackJoTFM3b25mMzlOTWtKYlo3YXpMajNlYzM0WSsxS1hSNDg0?=
 =?utf-8?B?Qk90MmhHK0ZWNzBkUGRsWUR3WDlRY1UyazlrcVZSRVFaRGRHTHQ3SUVCSm5G?=
 =?utf-8?B?WHUxMzNmUHZXY3NmMitjNTRDNjZIbEEvTXRaOVhBMGdLd0hJd1VOSDU0ZFFw?=
 =?utf-8?B?TzBLUmhZdStBYTBmSjA2eG5IcHFtS0RQSHc4clFUNnREbDJJRGtPOXJQLzhv?=
 =?utf-8?B?dEs3dTZjaTlkeC9GcWdNSVdISXNVc2owTmNCcFdpczQ3WEhCMXhxZTRyaERC?=
 =?utf-8?B?MFdUbDhrR2FzUWE2c3hWN3NSdlRWN1hyMHFpU2ExNHJ4VWZiL2tQOTVLTmRR?=
 =?utf-8?B?M1VVZUFOY0tKK1l3dTY4cDdEcFFIUVd4cWtXcUx3WFNKaHZ2aldPNFdOWVF0?=
 =?utf-8?B?blFMVlJyTjdSbzR6Z2ZONWRXOG1PdkhiMGFZZXB2WkV4YWlqSGh5d0NNZ1ZK?=
 =?utf-8?B?RWJacS92VW44WnlwazZBMGRCaDB0QWcweGlkS0tPOTNPWmxqancrVk9RSlhr?=
 =?utf-8?B?ZjJ6ZVZGRjlQaFI4UEVFeW1KRmd3RmZmai9JTDlVa2NMb09IVzNKRkJzTmJt?=
 =?utf-8?B?Ylh2Q01WUktoZXJrS1hyZGk3VlplVlVjWTFNN3BvbUw0NFFMR3pNQ2JURTh5?=
 =?utf-8?Q?an7VQZtjvYnj7uCzChFMpywtr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41F9EBA2CFC2145BC6A2BBA876457EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0ceb17-225b-4a41-ba1b-08db203502f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 00:27:05.7587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEV2oNYa+u/eDh5MeUxEK6K4itIvsT5fY0mGLwSag5ta9dA0biaaOt7m3hSSsC7Wmpdpv/UByOYmgQv2tmBSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy83LzIzIDEyOjMyLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KDQo+IEZyb206IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+DQo+IHBjaV9lbmFibGVfcGNpZV9lcnJvcl9y
ZXBvcnRpbmcoKSBlbmFibGVzIHRoZSBkZXZpY2UgdG8gc2VuZCBFUlJfKg0KPiBNZXNzYWdlcy4g
IFNpbmNlIGYyNmU1OGJmNmY1NCAoIlBDSS9BRVI6IEVuYWJsZSBlcnJvciByZXBvcnRpbmcgd2hl
biBBRVIgaXMNCj4gbmF0aXZlIiksIHRoZSBQQ0kgY29yZSBkb2VzIHRoaXMgZm9yIGFsbCBkZXZp
Y2VzIGR1cmluZyBlbnVtZXJhdGlvbiwgc28gdGhlDQo+IGRyaXZlciBkb2Vzbid0IG5lZWQgdG8g
ZG8gaXQgaXRzZWxmLg0KPg0KPiBSZW1vdmUgdGhlIHJlZHVuZGFudCBwY2lfZW5hYmxlX3BjaWVf
ZXJyb3JfcmVwb3J0aW5nKCkgY2FsbCBmcm9tIHRoZQ0KPiBkcml2ZXIuICBBbHNvIHJlbW92ZSB0
aGUgY29ycmVzcG9uZGluZyBwY2lfZGlzYWJsZV9wY2llX2Vycm9yX3JlcG9ydGluZygpDQo+IGZy
b20gdGhlIGRyaXZlciAucmVtb3ZlKCkgcGF0aC4NCj4NCj4gTm90ZSB0aGF0IHRoaXMgb25seSBj
b250cm9scyBFUlJfKiBNZXNzYWdlcyBmcm9tIHRoZSBkZXZpY2UuICBBbiBFUlJfKg0KPiBNZXNz
YWdlIG1heSBjYXVzZSB0aGUgUm9vdCBQb3J0IHRvIGdlbmVyYXRlIGFuIGludGVycnVwdCwgZGVw
ZW5kaW5nIG9uIHRoZQ0KPiBBRVIgUm9vdCBFcnJvciBDb21tYW5kIHJlZ2lzdGVyIG1hbmFnZWQg
YnkgdGhlIEFFUiBzZXJ2aWNlIGRyaXZlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gLS0tDQoNCkluZGVlZCBpdCBpcyBtb3ZlZCB0
byBwY2lfYWVyX2luaXQoKSwgYW5kIHdpbGwgZ2V0IGNhbGxlZA0KZnJvbSA6LQ0KcGNpX3NjYW5f
c2luZ2xlX2RldmljZSgpDQogIHBjaV9kZXZpY2VfYWRkKCkNCiAgIHBjaV9pbml0X2NhcGFiYWxp
dGllcygpDQogICAgcGNpX2Flcl9pbml0KCkNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
