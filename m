Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB46111EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJ1MxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1MxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:53:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F81D5876;
        Fri, 28 Oct 2022 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666961597; x=1698497597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oe/jS7ouKQKaa6A1RZRenSNkXTq+MV3SWzHXcAFW9nA=;
  b=cLRkYoVTZelE8LO7KhhwEd0jJ1tuJox44hVAySJ0/ELyF79rfUVlVpOU
   PA+nAbqKk8Ch3TH+Kg8KKz/wjbOnv+sS4Y5/BuU9120HqlVAuuIHWGQ6h
   ZE7N2mJb43XjW8xPPnCmFOBiNL9vBx3uagdHkEjG66gpVaUJDvq+n0AEC
   /r6SZsyoH5WQRvc4jw5pF/jb2f0l2t+qzCFqzbxZLY5gRHgDMQuydqX4X
   AeXcBO6ow3dZ8O0uLU44qNjmst/5z2U/NE9W04chJkEsREkH8CRifD/a0
   ELw+cZAYfJPTK1n7c1bGxqSLiunVHlfRWU6nA2JLa6tk8M9kmlFlGfR4S
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="120797913"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2022 05:53:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 28 Oct 2022 05:53:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 28 Oct 2022 05:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr/5+v8ajddJbG8G955AnraXoHr4URS90kxgan1oNVUqBO98uKlWU2EZ2B1jqzWxeJeXIXW79wrcljsPGx04T2w2WnR8T3D1Me4/2PIMYFxoRT+x3/SoSNmUoVJOKb59/DC5dwb5Y//ON0plI+X69Ft0zGJauQrTIq5Bnp063iuKvjbenkmKb4megJvOVHm217WXqwM5X68hLM0s0UZ6U92SsYl14fXR7Fs+XOjnAs3jvTEZo/H0AFGG7XmoZke2S0DVVXic/bRK2G7gcz1yU1ubL1MUw7xBRphEWbkgvToQ/oscMlARqvHvHUPwQCx4wdCh6reiE2VWB9dYtbgECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe/jS7ouKQKaa6A1RZRenSNkXTq+MV3SWzHXcAFW9nA=;
 b=T52afE0x6H/Q/hmrJwTPwgGobVqfYg2wIHB9sC9Qkz9cucM8nHwrTpLmwP9qddK8o/aF2JhbJTaTu9ALx/YAR8E5Endoc0DgQHP54QX1+A5nNEP4tBwNnS6GIJ2loL8ZCnCchYkSIzH+9b5iTl2XOD85yrD1Thy44y1mI2knmaopPaPGG0w7gS13j5vpjRWSNX5wEZ7qo3WAX+XcbB+kwt2XF+Fx4t0DTUCBNAcSENVaL5RlQNhal0htfhcmLGg+So3Mxcu9LnuJnFU2CSfISRhzPba3FUvYsO9EEDQJuHokD4nkRAT85jxRRNmN2YYXzpHRQRMEwJH8wJxiDQI3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe/jS7ouKQKaa6A1RZRenSNkXTq+MV3SWzHXcAFW9nA=;
 b=Lsxrl36H2mzLdlDfjlZ2wU3NhL2ZTsx1Mi6ngGEoRR3XVAOHsd8kbPZFp+cQqxEIYbcgXSh5rpqiy8hnbEHb0nuSzDp/vlXuZqov6N7C8fp3B9I9xkHkTB9rj6RHy5LSY5q0KWiHVqw5YdM9V877o8wvyJ4N4BxzVvA80oCNDLM=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 28 Oct
 2022 12:53:11 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::1b9f:d534:5b73:892f]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::1b9f:d534:5b73:892f%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 12:53:10 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: RE: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Thread-Topic: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Thread-Index: AQHY5X9QrOvD8uEMkkeiD8LOnJjBUK4jy0+Q
Date:   Fri, 28 Oct 2022 12:53:10 +0000
Message-ID: <MN2PR11MB3645BDC3B58C198BDB9B7B0888329@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-4-terry.bowman@amd.com>
In-Reply-To: <20221021185615.605233-4-terry.bowman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3645:EE_|MW5PR11MB5908:EE_
x-ms-office365-filtering-correlation-id: 6b570599-3396-446e-8acb-08dab8e35e48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gy8LzGOU7f1Ews+KT6BWnSp+KqaY4Wmeos4FObp8Dt0W5brMM4QocJZ1DyAPJAgDhc9PIJaieRanLPT9qRNPgnNlh454GdTCjnXe8kfgw1NsfgaP9qxyYuhA0OaOJLq5gnUmqxtg0TG5y/ky0zq1po0YZpdin/Bo0ZAYA5tzmzA0+y1F0FKWbziVPDAkPLaENqPAno35CFqPvCTg4USTu31p0retfKNi0JpaXf8k4KzxhXV8YQVu5hlIl+lIqWN0nOPL+/jBwSCNdYN+SuCmpgd+R4J4BfwX3OR2NYPvhCfnMV2fTi70tlaSfaz/+xND8T/44ubEg7ar4k1cgyqRaFvgi4Il1QiJteb7gLUWCAWKMVewZcnwPropcd1qbHIkoj/STOnpOwyPn7Dz/Ktn8L5Lz24GOw/hn2AAw2/z6sedVGTpP7lKdFNWcsA7ddyvI9LFJNE9Itav81DT1U/yqvvk561umhkocsOnhdvrrq+Dtovx2oqbOv0Tajv6E5Hz0Vw0w7okW0lPJgL1KpzlLrRooHlRIRyzmbaGF4P+7JfdNWrKKEmclSVu+IKhwlt+JWcgYdsbvfVLBxhq+eOYJAJ73NMoqVMuwls8zwwfn1iP5HfnRUIQksJ3MVOn7fG50lJdRLWP00zQLkAoc30cGxnyabG3gnJJ8irEs+oxkw+/dy5iVMDx3pRH7HEDroerJmc1tMc7mV/3Y6QgtjiymSLkKmXfbaQspDeUUY1eW7sblwBKJOv7rnjixHNWNRcYX1YR2L0hWRM3tR3JROzoyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(66446008)(33656002)(38070700005)(478600001)(8936002)(122000001)(83380400001)(7416002)(86362001)(186003)(316002)(6506007)(9686003)(110136005)(53546011)(7696005)(4326008)(54906003)(38100700002)(2906002)(66946007)(64756008)(8676002)(66476007)(26005)(76116006)(55016003)(71200400001)(52536014)(5660300002)(66556008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDB6cXpqYzFlcFBXMDFLcytzc2pla0dWRmtMSGI2KzJpNlFKK1k4bnVCNFhS?=
 =?utf-8?B?NVRHaE9BZk12dHNhV1Q2bitqb3NmbjE0eGp3V0ptY2Y0dVcvbVNLVHhtN3I0?=
 =?utf-8?B?OG40ZW9lUkQ5NnFldzlsb0JQcEJremN1ejlINjBRaTdHZXo4RXBXOGZnb3dp?=
 =?utf-8?B?b202WSt0Z2Vsbk15R0ZxQnJ0b0RJdWQrUytFdUhkbSsxYlc5VysvNmhKdi9m?=
 =?utf-8?B?Y0wydEVwSXB1RW10eHF1NGxNbUNBMFJiRk5FTXFvdUFoQVdLU1Jxcm5tQ3JS?=
 =?utf-8?B?dkJuMzRKMG9xcmZkRG9la216VUczc3lINENlM2dHNmlvSGtRVmtobCtCZFdn?=
 =?utf-8?B?Ny9rTVkvNUJ0RVdaTVExVFBDZDA3VklJVlhmbEgrZ0pCQUIzWFpiZkpuMlVa?=
 =?utf-8?B?UlVuZU9wL2l0Rm1qNWQyclRWdlIrZ0o3eDhYWHlHR00rWlJaalBoSVR5N3M1?=
 =?utf-8?B?ekFBQjd3NzRNc3pNSkppaFk5RTd0OElQUnhJTGttT3Q0R3BNNVpmR2NJWnlS?=
 =?utf-8?B?b2RMS2RYakQ2aHZ6NUl2MmtBU3JrNXg1VmppbERTaE1hbExjMTdWWUNab1Bq?=
 =?utf-8?B?U0ord0FEbyt4QkM2WDNZVElQWWtPZEppZ0NtalM5RkJxMTFQblA0UUcxUUlk?=
 =?utf-8?B?empGaTZCN3pjeW95QWRGTkFHbmR2TW1mYWFRRXVMeTFXcXZUYnlXTEYwWi9S?=
 =?utf-8?B?eXV4T1QvN3FQVVFGaXF3YXdFaUV1c0JkanllY3pwK1R2MXAwMkdCZXI0RjZU?=
 =?utf-8?B?VEllRTJWQ25XYm1aNngzN0NaVUEySCs0UkRaUjV0ZDJaTnpTb1V3ZENHYS9r?=
 =?utf-8?B?aERrdUViQzBBbGFHOUFWWW5XYzZveWRNWHRiUllBUFdUUk14NSsvd2dRMVk4?=
 =?utf-8?B?QkFjQ0E4KzBHY2NBTEoxTHNGMjc0TVR2MkZ1SmptNXZtdVZ5U3dHN3gxNEY2?=
 =?utf-8?B?SjdDcFdYSFZOT3F0dk1ScTZZTDhOYSsvVS9WREZRZUMxT3ZKNGVlbnFRSzNJ?=
 =?utf-8?B?TnNsSGJFZ2pSQnJKZ2cyTU5jbmlIalVYRDBWOWtVWGt6U0szTVN1WXJ0T0Iv?=
 =?utf-8?B?cXRCVGJ2N2N0REEwQWtoMm0wdUx2OUdFQmNBeDAzaHRuSnRwR3kzYVJkZGNU?=
 =?utf-8?B?bDJYWWh1SXorTmR5cHFlamFsZzgzaXE4U3JrWEN1TXdHV1JBWTl1eVlLbk4x?=
 =?utf-8?B?VEE2cTV4NkpKVFVSeFpEc1pXTmtmQlY4KzlyL0J3bEF3N0QvMEp1QUd0dVE3?=
 =?utf-8?B?UWFoSVBZQm1HRkpUWWlETUpqeGNHdWdDZWN0Mko4ZmV5N0dCeVhOVyszWmMr?=
 =?utf-8?B?UUFwdHdGOFM5eGxiMTlyWEt1R3c0NDFGVzNGUjdxMEJPZzVaSVNuWlM4OXVv?=
 =?utf-8?B?UXBWNkVSeVBkdHBzb3lHRVZXUzVFUzFHZE5KbkVXeW56Nk8yd042aE1UZm5k?=
 =?utf-8?B?eWZoVnpSMVlleXphOS9DTmdjQjlqNUdxMng1UHY4aUtBNFE5eWRHZlNhZkZQ?=
 =?utf-8?B?Ujk3MHI0eXFlejJRT1NleEh1cWZKQVlCd010Z3RhVmdWRzFJY2xScmJJREh1?=
 =?utf-8?B?UXhjQThwU1B2dTQvNy9oL2p2cjBLdmkwajdCUHN2R3pTcjdlWWhIdkw3ZCs1?=
 =?utf-8?B?c1A0QkRib3U0OUpaUGhRclBQWDdDUml3TkxhMThNZ01oM1dyQjZBR0xrMEpu?=
 =?utf-8?B?Zkg4QlJvU1ZVMnZKeFh3dnYzVEVEeHo2SFJuOExqbG54cWYrOWpXL0wzREpv?=
 =?utf-8?B?ZGRTUGdjQXBBWTVPc2VSeEpHOVEzUFZMeHh4QVdXMCtXQUNRZXVpTXJJQVpQ?=
 =?utf-8?B?NE91b3g5Mmtnd3MwdjQxa2VoVGpUQXkvQmVYcHNJcWdMVUlDS0lWN0x3dkw4?=
 =?utf-8?B?Z1VPRC9ncW5VYVZGTjU3bEtpYlhsNDdrcDJMV0FoLzVyNjdvamQ4WU9xTXRK?=
 =?utf-8?B?dWdncHNpcUFoNGVZcEs3bXZnZXpCQmFILzdmMzRkaTRnemxnakhjRzFnTkNL?=
 =?utf-8?B?QjFzOGFSYUc5V0wwUGpqZXJhOHNLMnU0YTYwU1B1NSt1WnhHbS9Ib3V5N3BP?=
 =?utf-8?B?N0ZFakROUmJmMzRISWdWZU1lQ1pucS8rbktqbDhVYjFLQ2tCLzBmOUcxaS8w?=
 =?utf-8?Q?8BgWtq01uOYI6lpe7FwnZjfmC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b570599-3396-446e-8acb-08dab8e35e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 12:53:10.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qZKDGVsEG4t6sdwVoazGeB/PSYxE1fuHNJRFapb4fe5rhlgSTM7qelBHXM3JzprtLimRADGy7ZmpOdCDdN1Q8gbC5reby25yqJe42SrHNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUZXJyeSBCb3dtYW4gPHRlcnJ5
LmJvd21hbkBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjEsIDIwMjIgMzo1NiBQ
TQ0KPiBUbzogYWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbTsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5jb207DQo+IGJ3aWRh
d3NrQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbQ0KPiBDYzogdGVycnkuYm93
bWFuQGFtZC5jb207IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBs
ZW5iQGtlcm5lbC5vcmc7IEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbTsgZGF2ZUBzdGdvbGFi
cy5uZXQ7IHJyaWNodGVyQGFtZC5jb20NCj4gU3ViamVjdDogW1BBVENIIDMvNV0gY3hsL3BjaTog
RGlzY292ZXIgYW5kIGNhY2hlIHBvaW50ZXIgdG8gUkNEIGRwb3J0J3MgQ1hMIFJBUyByZWdpc3Rl
cnMNCj4gDQo+IENYTCBSQVMgaW5mb3JtYXRpb24gcmVzaWRlcyBpbiBhIFJBUyBjYXBhYmlsaXR5
IHN0cnVjdHVyZSBsb2NhdGVkIGluDQo+IENYTC5jYWNoZSBhbmQgQ1hMLm1lbSByZWdpc3RlcnMu
WzFdIFRoZSBSQVMgY2FwYWJpbGl0eSBwcm92aWRlcyBDWEwNCj4gc3BlY2lmaWMgZXJyb3IgaW5m
b3JtYXRpb24gdGhhdCBjYW4gYmUgaGVscGZ1bCBpbiBkZWJ1Z2dpbmcuIFRoaXMNCj4gaW5mb3Jt
YXRpb24gaXMgbm90IGN1cnJlbnRseSBsb2dnZWQgYnV0IG5lZWRzIHRvIGJlIGxvZ2dlZCBkdXJp
bmcgUENJZSBBRVINCj4gZXJyb3IgaGFuZGxpbmcuDQo+IA0KPiBVcGRhdGUgdGhlIENYTCBkcml2
ZXIgdG8gZmluZCBhbmQgY2FjaGUgYSBwb2ludGVyIHRvIHRoZSBDWEwgUkFTDQo+IGNhcGFiaWxp
dHkuIFRoZSBSQVMgcmVnaXN0ZXJzIHJlc2lkZXMgaW4gdGhlIGRvd25wb3J0J3MgY29tcG9uZW50
IHJlZ2lzdGVyDQo+IGJsb2NrLiBOb3RlOlJBUyByZWdpc3RlcnMgYXJlIG5vdCBpbiB0aGUgdXBw
b3J0LiBUaGUgY29tcG9uZW50IHJlZ2lzdGVycw0KPiBjYW4gYmUgZm91bmQgYnkgZmlyc3QgdXNp
bmcgdGhlIFJDUkIgdG8gZ290byB0aGUgZG93bnBvcnQuIE5leHQsIHRoZQ0KPiBkb3ducG9ydCdz
IDY0LWJpdCBCQVJbMF0gd2lsbCBwb2ludCB0byB0aGUgY29tcG9uZW50IHJlZ2lzdGVyIGJsb2Nr
Lg0KDQpJIHJlYWxpemUgdGhpcyBwYXRjaCBpcyBmb3IgZHBvcnQgb25seSwgYnV0IHJlZ2FyZGlu
ZyAiTm90ZTpSQVMgcmVnaXN0ZXJzDQphcmUgbm90IGluIHRoZSB1cHBvcnQuIiwgdGhlIHVwc3Ry
ZWFtIHBvcnQgYWxzbyBoYXMgUkFTIHJlZ2lzdGVycy4NCg0KUGVyIENYTCAzLjAgU2VjdGlvbiAx
Mi4yLjEuMiBSQ0QgVXBzdHJlYW0gUG9ydC1kZXRlY3RlZCBFcnJvcnM6DQoiMS4gSWYgYSBDWEwu
Y2FjaGUgb3IgQ1hMLm1lbSBsb2dpYyBibG9jayBpbiBVUFogZGV0ZWN0cyBhIHByb3RvY29sIG9y
IGxpbmsNCmVycm9yLCB0aGUgYmxvY2sgc2hhbGwgbG9nIHRoZSBlcnJvciBpbiB0aGUgQ1hMIFJB
UyBDYXBhYmlsaXR5IChzZWUgU2VjdGlvbg0KOC4yLjQuMTYpLiINCg==
