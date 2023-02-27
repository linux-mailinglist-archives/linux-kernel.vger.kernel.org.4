Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD46A4BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjB0Tzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB0Tzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:55:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC021FC9;
        Mon, 27 Feb 2023 11:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677527719; x=1709063719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SzBiohh+b52nBQnU+O8YcHWCadRMP/11BzykarLSQbI=;
  b=s2aAkIasX3DI4uWRFaA3ioA3WpF4Ocw1NvTv9ZJvfIZex7/yb5e5MBTb
   Ng8/Zk4Ewolt34+Qi6Hk5fmS0RcKnjXdV9Jn+s5MgZ54zx9n8L1UzEc6W
   jGicoTyNrvEuIQNbtqYhDgl3LaORMBKngPFJuj/EuSXkHL9DIjdJZEMyU
   46UbV/a3vHynqS0W5otBIKApFNjFI64kO10wFubRtkSCPOced6C0zwUfP
   nd7+F4DVq4qZF6FHyNot0PM56abBUEQnBlw7s1QefKKcOlhVWY1EDZRO+
   Gri/l+Mwt2/kQuIbTFTrivKtqAYlmKuc3OMc3Eq+SH2tJZ2nlqtEmOzoV
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673938800"; 
   d="scan'208";a="139308575"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 12:54:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 12:54:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 12:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIJmtkYRNo2FL0RshpVk9ZxCAcV6KNCSmxlh8vYCxWIuwLQSnReGwIdJwVZQ0/H7m1RwRVD7fcU+W5/C6k+e0wGJErVNSic/F4RVE2OEFtMy7NLRbN15AzPgXQuV5ZgkNp+CMrXqM4r3IAcafm4SWzHKLmmMWZCFjhxrPfdWckPTR+dMlayaoKJPyVNXG6Ocy8dU4Gj9aK6lUdI12z7KLqLahGKzrPbD0pFDb7Yv43Z/EmBeATcAlJIy3L/VPeN78A427cdr0WpGcKnVEOxYU7NqPcCihLGG7Kxt5jelzx1AXLK4OTLwAn93jdbe5rZPCi8XzMfOiNpVV2zD0HCvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzBiohh+b52nBQnU+O8YcHWCadRMP/11BzykarLSQbI=;
 b=fG6LAebJ9aKCOZu78/OWxw8nkBlPeNqcHWpEkDVSjI2NFoJHR5m1URkbhraid7IQX4cvvuOHUnIr2ARVsG1GALVuUjfbMmj8wZ9G4FRnXLB9g4mbxZz0YQaJJol4ry8qE7ORvcjtA3ddA9MJl8fODePMk71WNc89hW0YaOZL1D0pH93blTtckbUsk/qcXsfyXw71C4WHe4tS733xhrTg+OcpQXTs1QPWjvGSAzG2212A/JweeHmIgnnlf6aKNUZxZGw6NwMF/IBtQP+oJ8y3jvhmLCUCqaM0bxQ3HsHUyQzJTfSSF5+lmAn9f8K7HhtVCtzZDPQQeB1XAT/F6L0tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzBiohh+b52nBQnU+O8YcHWCadRMP/11BzykarLSQbI=;
 b=uVAHO5sf8TogaJD1ySGZ8/ZZzEyqB15Kmc1/nxAaZaNRjI8lceIz6F7kHJb3yZuBKmELx1+YG5FbU62eODuxgljGNxDAvMKzy0BOZJDUI8Sy36ZExctS1mprM8fe3w3HsLKdrfvt2Eu2nL0QVFtCxbkL2mh2GJOqsLLlKRqoUto=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:54:54 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:54:54 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>, <torvalds@linux-foundation.org>
CC:     <tytso@mit.edu>, <Kumaravel.Thiagarajan@microchip.com>,
        <andriy.shevchenko@linux.intel.com>, <jslaby@suse.cz>,
        <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: RE: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Thread-Topic: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Thread-Index: AQHZSJZliouLfywRZUGIK4FSKCcCSK7enWQAgAG2cACAACsGgIAATRGAgAJrk2A=
Date:   Mon, 27 Feb 2023 19:54:53 +0000
Message-ID: <PH7PR11MB59586BD780F9427EEFEC3F499BAF9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu>
 <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
 <Y/sBGesMZSd188OQ@kroah.com>
In-Reply-To: <Y/sBGesMZSd188OQ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CH0PR11MB5252:EE_
x-ms-office365-filtering-correlation-id: cce73030-d169-40f6-6b68-08db18fc7ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6lcWHb41Ejwrgh6oxBRQDuW0OSdbOxJBwaGufwtXG2NKq25x7fHoJPW8XjKfHa8v8TC7puWpA6/likJr0riRngqDfAQHr86WZ9hFBZzi+zb0Xd9Aqi2Q4JNc7Xh5DrzsqfFN5DB+M61hqx5k5Utp3rlYF+m83boIn3QZGYBRU2Pq3FlreGzvQNHvms7eSytVUT8DF0OFmjBasj4z4Q3gn+Acq4FmZLXj30Ov68GMZfiZzTQvdKkI1SOSqJITBokf4OCKZjc44YKx4RgZZBAw4d7XaFjhc7FU/qxN38RYO7s3m05JDedMeAjCk6tXDO714CbWvulESjquaXf1Dlu4e8r+k8nUWDOzVHrVNJ8R/dqJRPi/aT3DmRpNaY7wQxqmt83YCdN4pzJdN/iQ8jA6kGqHQQaNBsphfs8vtobtiwWd34lc+8AklT44fWF6Jonv+eUCPOQguF2PLzMjLPREfnV6asJclwOdXB/m6mooam1T2RHDhsUumU9ZyawCY4SD6X3uWl2XZ32PumFl58G7jtK5LdYWX56xoog4bMdzUqI1Urrz0FCWpBLsjZQrJmX154/zFOfO2e53+u/JdBjoBfxBw9+z9SMERxZx1qXyAW3Mtn7UdBu38rz9k4or22egWVLvBVb+PzoxZiwrSEfYU82LiaifI8Nm5FvflBEuN80OLszlDDK8FOHHOusMS4LLVXL5cftwpVK55XrPGqslA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(9686003)(186003)(38100700002)(122000001)(52536014)(38070700005)(8936002)(41300700001)(66556008)(66446008)(66946007)(76116006)(4326008)(5660300002)(2906002)(8676002)(66476007)(71200400001)(7696005)(6506007)(55016003)(478600001)(53546011)(26005)(64756008)(316002)(33656002)(558084003)(110136005)(54906003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEFQNkNVSHpuYzIzS1ZRd0dlOXIzM2xtSnFEYjBWTmNUZDJHQjVsamdmcU5G?=
 =?utf-8?B?MHlGTHFnalVwK0s3dDNzWmFZTXFHc3NQbUVJMDRuKytuZGhEUjRCUFVwYnhU?=
 =?utf-8?B?R0wyeDFNMytBKzlOajE1enlhaXU1N213c2VMYk1wVTRTb0RpaHdQUFZmMEhP?=
 =?utf-8?B?dGVNVDYvcnk4OUpUbldWdlMxRGc0anlZVkZmaUF3cTZHNGdlN2lBQ1JITytB?=
 =?utf-8?B?MEpHcWFqQXJMb3ZuOWh6d29JenB2eCs3ZkF4UEFybWZuMGdRdm96N2hFU3Z6?=
 =?utf-8?B?QVJ1NGpTdkxHaTQ0SHdDeUEyS1NTcVp0S2ZaV05Wa3FWNGplelprUEhoV092?=
 =?utf-8?B?QzlUVGJzTmo1VEZFL29IYjMrUHR6TTdnM05mS0dPY1dUSTV4dUhZSGlyRzVS?=
 =?utf-8?B?UldOc3E1QTFIRFNvV3pWK3ZQZENJNE96Ti93dHZ3eHVVN3YzWEJ6NERocEU4?=
 =?utf-8?B?K3FaZkNSSFV2MEpVODB1NTJDd3hIYjJwQkVUSysyZFM2SVJpRytpQjg1aG9N?=
 =?utf-8?B?WUZ4cURLc2pMOTkrNzQ0eFlOWGVXNDlzR2cyTGdUSkU0VEJaNWFHZ1p1VHNk?=
 =?utf-8?B?U2pQT093QUdVZ0xrNytRK21RNGxFK0NwdjhPaWh3WndVTkxyVzNVU01mb0Qw?=
 =?utf-8?B?WVJoNUhJZWJvcEhGT25yU0pqMm1BcnFlNkJCYnFNUmRWdXMvM3RPSVNQemdK?=
 =?utf-8?B?UlREOEoxT0orbUFoeGRScFJFM25vRmVhODBhTUpZejg4VDQ0MXhYU3FSVWN6?=
 =?utf-8?B?cWhURWFpVCtyaTFXZ2ZUbFo1Ymhld0owZE9WU1NZMjBTK1N0M1daVE1PdDZ5?=
 =?utf-8?B?dGQ0ZC9aTkRaRmFQbUkvUGJueXJvcTZxYW9yMHpiUklZWThXcG5QMEZoUUNs?=
 =?utf-8?B?SXdKTnZ0SEhEdVJLQlJmMkNMa09sSGlBSXlQaXBFMlE5TElRNGR3Z1pRR0lC?=
 =?utf-8?B?ditnazhpN2E2Vk1GZmdtRERlUzdlQTIrOGZxZHg4dThFcTFGTk9BV1FvaEtR?=
 =?utf-8?B?M2V4L21qV2JVdjlSQjN3a093anJ1aktxamtYRDhXbVBLejRGMS9NclRIb3BE?=
 =?utf-8?B?cE4vV3lRc3lPM2drdHhoWE5qTHkxWlM0eWs5b3h0QzVDaWxpWDRpTFhsRi9J?=
 =?utf-8?B?RmUvN1RxNUxXUVhrUGhUcWV0WkZ1R0JPL3Ntbk9aazRSYSs3TUgzdERRVzAw?=
 =?utf-8?B?MnpZcnErZVRMc2Y1WkpPQVZMQ1BLOHlTbFBsbUIzTkZqRjBFU2U3citEMURU?=
 =?utf-8?B?MEVHblIycUdNbDJYSlhTa3c4S3BOWHBTNjZMSDB5S3ZtTm5IZUYxcnhpZUxn?=
 =?utf-8?B?dDJmUlFVUmtvZVo3a0s2cWNIZjAxdWNRMUdOakxjMXE2eE5mcS9Rc2p3cUI5?=
 =?utf-8?B?eFV3WUVsNy9SSnZNNDFKU29rSzhGYjR0bTRCQXVDZEtYRWYyelVNRlUvSlFj?=
 =?utf-8?B?cGU1K1BkWG95eE9JeGIwUlc3Z3BXRHpHRWpRNkhwdWVhUTFsQ3M5VlA4S2dY?=
 =?utf-8?B?SHJCUXh2YklQeUV3MGdSUFB6cG9RWDExb3VLYXM5RkJTV2ZoaWFhcXJFaUNL?=
 =?utf-8?B?V1dyd3J6NjR2eXBjRkFjY05veU12bXB3UzlxdDNXNTZCenU5T3hFSHppNXF0?=
 =?utf-8?B?WFFjZXF1REt2bElLL0Z0SW5rTG43NFRRdUpFQ3FoSlozcGplc2E0OEpFZFlL?=
 =?utf-8?B?OGtCbDQzaVhtWVI0LzRtVzViZVFQM0FaeHJsc21zMDd1L0pyMjhaeGF5bCs0?=
 =?utf-8?B?OUl5RnBIREV6THpmaTFoK0ZJenM2ZklpWmZEUW1WQ1FtRzY3blRwRXNMK0dk?=
 =?utf-8?B?c0kwc1pJc2ozbHM0NjBXTW9lVGVUVU5BbFc0ZXVsc2NDYmMwekVabi94aE9i?=
 =?utf-8?B?K0grMENZQ3dZYmQ5Y1ZWRnBwUFcrOTNWR3I2K0JXR2kzVmJQMUlmRGZOY2sw?=
 =?utf-8?B?a1l0MWx2TG9NQ1lFWUNCaG54YytmSmorWXFYMWxxZWlEQnhCWG9pU214d3FZ?=
 =?utf-8?B?aEJ4Tm5OZWVBeHJXOUMrQ2M4cCtkcUxYRkZVUmZtNVlXWHdZTjhaV0NhRFYv?=
 =?utf-8?B?eEgyYUdZSTBlWlFWMjd4NksxSkxNUXE2S1NERlV6Z01MZ21jSEptVkRBV1Nu?=
 =?utf-8?B?dFVrcHorZ08rTkh3V0tuL0EyZnZUa3MybDlsQTMwclBrUC9ZVFM4amxtek55?=
 =?utf-8?Q?z1u40I+wbrrp1i7sdZ14SRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce73030-d169-40f6-6b68-08db18fc7ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:54:53.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVyKkWCPmKXSRWLVojf0QTqYps9quFOvwwE5ZKyzXcvUiwkl2udxBMlScWEajbisFFoFcVrJd+LrRH61rxu5S9scmuL/SdGgqfnqhq41+EFfYWUIyiGy2DbwoYz3VC9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogU3Vu
ZGF5LCBGZWJydWFyeSAyNiwgMjAyMyAxMjoyMCBQTQ0KPiBUbzogTGludXMgVG9ydmFsZHMgPHRv
cnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiANCj4gSSBhZ3JlZSwgc29ycnkgZm9yIHRo
ZSBkZWxheSwgSSdsbCBmaXggdGhpcyB1cCBiZWZvcmUgLWZpbmFsIGZvciB0aGlzIHJlbGVhc2Uu
DQoNCkhpIEdyZWcsDQpTaGFsbCBJIGZpeCB0aGlzIGZvciBTRVJJQUxfODI1MF9QQ0kxWFhYWCBh
bmQgc3VibWl0IG5ldyBwYXRjaD8NCg0KVGhhbmtzLA0KVGhhcnVuIEt1bWFyIFANCg==
