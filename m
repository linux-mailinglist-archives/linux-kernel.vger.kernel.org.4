Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360F5F045B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiI3F4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiI3F4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:56:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90A1FCCA1;
        Thu, 29 Sep 2022 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664517394; x=1696053394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D9Mz/T1tH7rQKxhPJ5H1t5ONFHbWAuCjAvYwlIh1BCI=;
  b=u7w3Tqx5GOmz931cv6SStStPbTiQYJgAYaVqPzwvuXfq/mQB591eZFGh
   zHWUieUCHdn/Xyo86NmQbhjNKnDJY3q1uVf8g/SDw+akXXJrJ+Gr1mmoT
   zBYlJ1w3tpmnV2altqBIG41tpVECYQCWAqsbVhhuTSnrM4InvT3NCMh4w
   csccc156IgOfCOLfjPMi+F1XxUMc1lAAk/KhalHdqIRa6jJt3r9LOvfSv
   fMPcV0P5VLigFk3QHvJYG1OzPlO4GJpI5v319P/YZE5GIKq9qGLx5ZiI0
   Vxgdrn2KswOxyk5F0m2Zl8hNlD/jSQ+j47CfjkAtTH+Ny1F2y78wmYnC3
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="193191925"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2022 22:56:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 29 Sep 2022 22:56:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 29 Sep 2022 22:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho6WHnzAUHCQIXDB9BkRZ3bsbc6/F+pjx1yinmTTG1cTxADKGQ1yLcdHgONWrkBfKmmdDOJT6Naj6ZtfBOgMW1bMnX7t7ddZzqUWwb2ju+VmosziIwHOYxJa/dXBdev4dxTbF5Ix6hACf4CIhUMUqA4EgQgT6n8hpaGbTy7ymGwzLdlRen/rlEVFnmq4N0ZDLX08HylMofCrL+EruhjUnSxoBuZ58mENh4B6rKWnOtmEb7+vm0EGDpFqFqdRrBUaSIwHcrGI2q87dpwR+TKqk5dP4C+2VezS9HmTCahw0Rg3xB449UxGrQZV64veJ0oVWzvnAkYgOKPKxocFRhnftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Mz/T1tH7rQKxhPJ5H1t5ONFHbWAuCjAvYwlIh1BCI=;
 b=SGTvOntaLr2iBbP9S01l1X+4FDr6ri1JuZuDufhu9cTeAORNUeO1ijaeFMpttOHa961xY0URex20Gq8caqyX65+KQ6tsmFVTzLYtU1llVlZewdsac8EfgbtMnXFNaWMhI4aJz4mPFnDa5Nd6NQn7iPH8cIZYeFlxJHZ1zORhgtdlHm2YZ/g5eVm1OOcJi2wi0DofbTS8HZiOpT13sVnReY080XASI0f5c6zMRPSY+5N7EqRmE3bE9dK6R7o8woWlCKkhrYbPC/HM5NVgGr0Isl6BpnlHvhGZDKfuFh6MWfaO5vK813xi7jjkDZC7d58LWO74P3tfLUE2AgEBzcRiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Mz/T1tH7rQKxhPJ5H1t5ONFHbWAuCjAvYwlIh1BCI=;
 b=ijGBjm1odGzxwi1olNOhvG0WJuHF1Qn0Vxz2W7tiEc+9FVUjSQ05her0coiDygUJhWhxz6At0QET4K0SRrHD3HMMYOZ4OoZLgNQaO7ug7zuoKcSpIA5W9re1wYkQQejiKDnPr38DP89J355u8svMGD4sHQlA2sMSBQKPx53+xic=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 05:56:14 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac%7]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 05:56:14 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH RFC SPI for-next 2/2] spi: microchip: pci1xxxx: Add
 suspend and resume support for PCI1XXXX SPI driver
Thread-Topic: [PATCH RFC SPI for-next 2/2] spi: microchip: pci1xxxx: Add
 suspend and resume support for PCI1XXXX SPI driver
Thread-Index: AQHY0uyCTuOi8M5bxkeEzC3yAsUeuK30tX2AgALHzAA=
Date:   Fri, 30 Sep 2022 05:56:14 +0000
Message-ID: <693f4cf8fae393ed67f4335a2e1b81ff490c92b3.camel@microchip.com>
References: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
         <20220928034336.2939265-3-tharunkumar.pasumarthi@microchip.com>
         <YzQwQwL4NOTMMe18@sirena.org.uk>
In-Reply-To: <YzQwQwL4NOTMMe18@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: bd20b07f-1d92-473c-fdc0-08daa2a87bc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaeqiqVgMoV+XF2E3Vxyon7rBaEbUajmvKWn4OTb6kza1eLQ9b9ELsYx/9YRG8ub51J+usZ6QP9yl1tN2rEK3LO6FD75GIZg8Xxj1miC5d0yCxDsK5OkhJ+1Dy6GTDDnOh1/GG1G72lDv5whZ6X/6ciBbB2s3YeD1QXe2/KL5rahHnVLEXXPktdpvJcFAKiMKIqt54sNGnxNTBUPfSji/Ag0Qac6W/ZRhYXY4vUeN4kSmaFiIn5N6ktT96MYxDVBbJy+OyOFNhVCcu/00ciC8bW+4zeT6YmwwNs9obGTPtHA4FWmuagAC8231PksaitstbuqBbxrPP58W0W1wBAnTSCm/gKtNxuZlN8WWuC0ivn9FTRFOPwtSFywwdpfwscSXIjq6p7NqQ6r5qSNgV59pWQ5Gwva9KabmQfTVhM4WPOh2WGoRcz4KGzsboWbPwZ9+PNQjcHzav/h+2tF0OX5gqCKMhzByDO6Xx1QypmbK0WzyiHz9YwSPXfAZX9jMZbeUTACJE1Mn4RhdMCkp2RrVCEHiWnQuer16o+kmpF/cpdLJXu8mCO2f1lmzf5uysWD0666SRqyE4XxzNPn5ic0HlCtqYM8f5UZttbNbV85r7ym8hZRDdXkawtDjeVV8xUmSxqFl34dYmEwwUyIzH9bC+lBUwSaBolF0LkJBIPkzWTCqMKbB4ARwi3hrIqy5GQ2t88txf96UeVKVwYMcmc+fx24dfOqrcvPdjl4hL5isJazk5oLvBqU9FIRh3gXWgY4qZqWH7Br7+exKQ5PuQtR35x1AVBdO04chwWDBOmGVKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(38100700002)(54906003)(38070700005)(4744005)(86362001)(8936002)(36756003)(5660300002)(66946007)(91956017)(6916009)(66556008)(66476007)(66446008)(64756008)(316002)(2906002)(76116006)(8676002)(41300700001)(186003)(478600001)(15650500001)(2616005)(6512007)(71200400001)(26005)(4326008)(6506007)(122000001)(107886003)(6486002)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzJhdks0WXVIaFZXc2NpYzBZait6VTFCcGFIbDFSRlZpVGc4aFJBSXZQS2dW?=
 =?utf-8?B?bFJTcnhlRFB2WWNQWWN0bkFLUzdEQzBmaDVJYTN2M2tFRnZVRWZkdDl6TWZR?=
 =?utf-8?B?S2hldGFDdlE3T3RGazErVlFVUysvUVVkL0tKZWZoaTdGSXBaK1JLcHVCWklr?=
 =?utf-8?B?VGVtcTl1MTdHMFJadU9SYm5PSWR3TTVOSDY5N3AwNDJyVEVhMHgxckkweU1v?=
 =?utf-8?B?T2VxK3djVjdHeStCYXo2OU9BZ0FqVHRDQm5iMEZoSWwvTCtvYWEvcEN4Q2VG?=
 =?utf-8?B?YlBrbUFsTmFHOWZ2YVpoTVhWb0lweDZGYnVNcG9CNWFvUmFKaHU4VlBQMTZ3?=
 =?utf-8?B?SlVrQWxQODA4V290NmI2RURMZkt0S1JUZTRBem1ZR2xlN0FvK1NkeG1TekRv?=
 =?utf-8?B?NjdyWDZaOTh2aC9qMjIvQUtuZXFXRmlrT3I3bzhZQTl3RllvRTJHclUySUl2?=
 =?utf-8?B?ODdxZlVHK3FtL0FjampZMlY5MVBVMmh3ZVNnUWRvREt6UFBkT3ladVJpNm8y?=
 =?utf-8?B?M2pQVXYzUVBHeCsxOGRUOG1JdG5IVHo4T3EwN252TVREbEtZZnIyQkFrKzIw?=
 =?utf-8?B?SForS3JLMVVoUXpnS0h0SmVpNDAvY1lMUHBiQkVkbll5Zm1Yb3I3QlhXbHI4?=
 =?utf-8?B?RDUwbnVON29ySGs4MWcyV2V5QmJVT0x2cmY2aGtRRnJZMkVEMkdXWUxjVmQv?=
 =?utf-8?B?WHk2aE1kVWg5cC9NemxlVDUzQnpGcFducjhNZnlGdmQ0cUJ2VTBmRUE4U0sw?=
 =?utf-8?B?NnJxQTdCZ3BEMEEzQXNDR0lHTDRFUXdmMEtmSEpKSWlDUHlEV0t1eFYvZUli?=
 =?utf-8?B?Kzkzd2ZIL0FjTmw0dVdBaE5NOS9kOUJYd1lzdVpMRUkxcVZPeWU3YUhIL3dP?=
 =?utf-8?B?K1hpMlFlamVDR1NseTB3aWFqeEMzSzhLZzhWWVA1NlI1R1RQTnF2eS83SFhy?=
 =?utf-8?B?YXZKTFJTU1U2UHFKbWdSS0l1SjVGWUNkU0VhTDByY2RCYkJQby9LR1Nua0JC?=
 =?utf-8?B?bjZ4N2wyd052WG1reU9oYTFnVlhNa2Z3S1ZqdkNqdjIxMTlRbld0KzdqM2xP?=
 =?utf-8?B?T2dIQ1NUN1NKVlVUa2FUUUN5aWpKbEF5N3d2QnJhVVhjeUovTGo0S0hNbjNY?=
 =?utf-8?B?RW9MbFZUdzdWY2wya0dCSG52UkNHeGl1dXJQMkJXUnptRGsxY00vaGpkMWN0?=
 =?utf-8?B?L2tlazFwMSsyOFRBR3ZwVTYxQUVaR0htNjk2ZjU4VTVINW5PZ3ljVG96ZHhR?=
 =?utf-8?B?SXJTWmc0akJkeU50cll4a3ZGMkJBU0FqWHpQODlLUDBCWSttV0R4WElyV3dx?=
 =?utf-8?B?Zk5HdmtyVmZ6QzU1Sk9kbkEwdSszOFlaK1hydzkvQ1RGdjRUMDhQNk5DbDVK?=
 =?utf-8?B?QXpMV3E2NWp4eDEzeVFVQ3FHdjZwMEZiUkp3SWpvYjU1b1l3T0wreVdmYVFI?=
 =?utf-8?B?Um1UQ0diaXNMTVlDeThjM3libFoyMVMvZXN4anFPRHhOQStORFFkSkJqRUJz?=
 =?utf-8?B?UWExTUV5Y3c2NzBkeU5McU4ycnZIdXlWZHFSdldHd01TeVduYzZSRGdFZSsz?=
 =?utf-8?B?V0NjS0JTbUF5YU54WWNEM1VSRFIrQkxVeHdMYWp0UTdYcTNkem15T0RSZEd5?=
 =?utf-8?B?ZkowYkxpdnU4SWVBbzltaUYrTEVxNlU1OGFjUEluMndKK3l1MTJMZnRyeEpi?=
 =?utf-8?B?ZVJpOWZNSndGSW53cnhKOFJERW5Nd2ErT00rU0R1YkRrSlhiWXlyc2FmLzFw?=
 =?utf-8?B?SHBWREt0TUNxazE2Ym1pV2JBMmRpV3JSVjFCbVJXdThsVytLdndBNUlKNkJo?=
 =?utf-8?B?SGxWSjJ0MEtJRUk4ZTMzdkt3V3d3UVRMcDNTU1EvL1lEYVNGV29qcHNMR1Zj?=
 =?utf-8?B?NW01MGh6Q1ZlR2UwMXNKS01KdWIyYWl4Nk4rcHpycXFhRm1SdnVpcHpKcVJp?=
 =?utf-8?B?T1BUWHd4TjJ1MEJUUE1FbzBSNTZPUVJGUWE5TE5WdHlsNTFmczY1UUlVdFpN?=
 =?utf-8?B?cDlhZFlJcjR3ZUFRVnF5K0l5QlM3UEJwVzNLQ010N2p0ZStvMzV3VjF1WXE2?=
 =?utf-8?B?d1hwQlE4cFBMSzdTclljZGlpaU11MEwvT1h1d0kzT0I3cEhTajZ5SVo4UHF4?=
 =?utf-8?B?K0NaeFFWcWJJc3dyMzNuUGREajZkNlpUYVBCdjBzRTJYYUFlL3FHNldoY1FF?=
 =?utf-8?Q?0T6Op/ceLVniKhPVepf2fQBAgR3D2ibl4+VCDRH588MU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B7072CA2E219F45A56341272EBA2909@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd20b07f-1d92-473c-fdc0-08daa2a87bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 05:56:14.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uy+uSqHut9wMla8dKmxM3ltHj5rKga4qTxMd7eONGfA2xxTtZBYDXIkkrATibYoGXacwI02L4Y90hNw+YPj8hrEfz/LXIWgLyxlQUWJ0Ob1OB+uWQSBGa5v2AnCx90y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTI4IGF0IDEyOjMwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4NCj4gVGhpcyBzYXZlcyB0aGUg
cmVnaXN0ZXIgY29uZmlndXJhdGlvbiBiZWZvcmUgc3VzcGVuZGluZyB0aGUgZGV2aWNlLCBtZWFu
aW5nwqANCj4gdGhlcmUgbWF5IGJlIGluIHByb2dyZXNzIHRyYW5zZmVycyBjaGFuZ2luZyB0aGUg
ZGV2aWNlIHdoaWxlIHRoZSBzYXZlIGlzIGdvaW5nDQo+IG9uDQoNCkkgd2lsbCBhZGQgbG9naWMg
dG8gd2FpdCBmb3IgdGhlIGNvbXBsZXRpb24gb2YgZXhpc3RpbmcgdHJhbnNmZXIgYXQgYmVnaW5u
aW5nIG9mDQpzdXNwZW5kIGNhbGxiYWNrIHRvIGhhbmRsZSB0aGlzLiANCg0KDQpUaGFua3MsDQpU
aGFydW4gS3VtYXIgUA0K
