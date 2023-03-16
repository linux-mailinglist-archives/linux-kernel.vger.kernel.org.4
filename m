Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812656BCDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCPLP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCPLPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:15:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817E1AC;
        Thu, 16 Mar 2023 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678965338; x=1710501338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XQVwQqQN+u7pHbmoSMsyFI2uk2sZLWOvcH5tFDKLBFA=;
  b=E3ri/I2QwwT1bW7xET1ZYeoDd1iYd265i0ZJXseb11suIAFSC/bBo4mV
   v0iEbO45agxkrxtNfTDdE0dCh4xAQA7+/uFC6v5u9bLktOPgQI4W5c1ht
   EyHd7F/jDs3IYkIq9cDSh5Kq3JUxDdUwcVXmAGUj4PyZAXHJA+JccaEdU
   /CHAdivKDwRQ+zkewjDUd6PpYhsVevzwBM84T07DkE1l9vZMI0c9M1pfw
   8kLU65Zecyydj64fd1W/a2FJbI5NJvBW4OrKkGcZ71Sm5bscXWC6BhVnO
   eAQjAr5XabnquTMhcD7tw98tSErjHq96hOGs/vve1ubjTP2PK7bWmzkvH
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673938800"; 
   d="scan'208";a="205027460"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2023 04:15:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 04:15:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 04:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+mo8RII7y3pQ21fFEl5oSBu+SWvj497aHTFfaFFxFscaZHU+GW6paziR51bxRJABWpCS8laxElNzEKAXMIl1eoW+YXtbTRBcbtbA10RP2/Z0ZBmJ5kRuToQzhp1i+w5IYmz0u1MtZNRdEbR9EpdZ7zCNBxpiC/NEDucIVoNQPPbm/cRJ6fql8WnHkpNQOKZHlynNyP37j7HA8TiM2Q9G5Gfu7ZcYkfnqT29t0c6iz4i80gYjJ8jLm9RelSoTSYAi5pnQQPnQGSWMqkPWl41SLk++VcGpXPaTmvnA/4xlsM623rpmU7hAumxqK+jcGy45Fba4Ig38RjDrD6M7I6j6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQVwQqQN+u7pHbmoSMsyFI2uk2sZLWOvcH5tFDKLBFA=;
 b=l7Bwzo3Fc44cqz2M42S/fLZCBV15EDtQmSwo39tMfB8hsmhamu1BHf7ckgsc4hCZyDepl8kEYcXvTVaqYTTyfQlSmZwDuEsX611P2P8EQxzoCv5aBZiANyGIojn+jJev6lhSUY9qAS2t7DagiS2uJbTRwLEKYE0xTRvTFnXNwT1AV3tnOAcrmjuF5BZl6EIB359s7bKxOHwRpsOldTI2o41pCVblfPQ6OZ13svFPlD/7ELxyW0rl0rwjHP3O7xAvJM55DWR7FFahuSBkKsI5VVuXlnBKTbUngz7O2jBFAQ3GODBBlG87tNaCgePQLQFcUExZXuLYwKp0/c96aJuAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQVwQqQN+u7pHbmoSMsyFI2uk2sZLWOvcH5tFDKLBFA=;
 b=Ji5RlOkPO4g0a80jjHYwxF9YC89Z/GMAubm23zCt5+eOAROumM0mqsxaVgxE+vtueMhwgCKcx4aEtLrpzXP5rxIYqhMue1015tKtRn3n2/gJ72FJRS7uScFUEB59vL5/0GICB5VjTFhZc59WEed3H8Q328DjM9nQdhhvzaFiKAc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 11:15:35 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 11:15:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <yang.lee@linux.alibaba.com>, <mchehab@kernel.org>
CC:     <eugen.hristev@collabora.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <linux-media@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] media: atmel: atmel-isc: Use
 devm_platform_ioremap_resource()
Thread-Topic: [PATCH -next v2] media: atmel: atmel-isc: Use
 devm_platform_ioremap_resource()
Thread-Index: AQHZV/ihOMQ6NNC5xE+GeyWZertmgA==
Date:   Thu, 16 Mar 2023 11:15:35 +0000
Message-ID: <12764b50-8eaf-dd9d-a9ff-d2f1b9d35063@microchip.com>
References: <20230315003009.123827-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315003009.123827-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA2PR11MB4937:EE_
x-ms-office365-filtering-correlation-id: d4fc624a-6349-4c31-1334-08db260fc3da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyY2H6iKxgd4VGo+y38iNZj4Nak+zfslbar7L3l+viD9qzyzhrKCpAeuwvfCMIXH5fyuuzCIRY4dvFbNqM09XJ9wZVxkp8WjJ1YRDWtKt5PxaFTmOGIFE8I7T9zj3+3EnJTRtAjPdx5L1Zwy9Jl4cLX6bc3dfsgsv6ctFqqHIQ0t4FiJKA39Mv6/mBUU/KX6wDRPOkT5jp1JDs6u60Um+3Ib5y/r1waEIbGlywAZ3qZDxUdwDCUy2uxGCsXRxactaf937xOrGUsljn8k6BTiHAH7SfdqjZlfoy+Nl1sdUpNSsSM44y6k5fn1yL7PjEoiaU1hVZ3jheYp7EKTRBpRAwRC/yj31gxNBwO+yM7vYtl/WV33SgoVDZywb8/nFyHD5saKJiRwWhLVVDs0NwIdtBzSWIpVtz9vbvTUs8RnfnTQfXtpLgVL4xjBwSizk+yIKVJFHjT9SpRyxtt/wbFExCeyloPO5L5o/2xZ/h6Ag7amZMTTezS8I8/bD6yIoFByP0D1CCX2juRHD7siYf0y6d0eISgwcZT/yECibTW3MpMLMenM/6uiPc8khHMVRTfODVsGJySXEAjq6wz8E2yZ+7p1hJbUFl70ylQDslk/b0UXITHwfynbv1q2jNu3YUlSwJLdEq/G12S8Uo0dpmpyPbjgi1QGpm3qhlPvFhzmIKhTHgrsKZ+t9SMzYQOwMhf4Nq1BVT13FRfKFqJDpmL4TgpNYxVdZnuXcvz42mxNCUs8obXZ/3fesZJzhHz9/B2tfpb8ty6NUlYGW902ep18gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(31686004)(86362001)(31696002)(38100700002)(83380400001)(122000001)(38070700005)(2616005)(53546011)(6512007)(6506007)(186003)(71200400001)(6486002)(110136005)(478600001)(26005)(66556008)(66946007)(66476007)(4326008)(5660300002)(76116006)(41300700001)(91956017)(316002)(66446008)(64756008)(8676002)(2906002)(36756003)(8936002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFQ4NDZVNDBwNzFEL09xNlpLVHNzSTI1bXdmenMyVFlUUWt6clhiNjRjcDBT?=
 =?utf-8?B?ekxNU3JqVzNheTVRRTI2bmxId1Q0Nm5XZVpYWFBxcnFXUDRqRkJCZDJJU00x?=
 =?utf-8?B?N3FsRTZNeHZ0R0UyaUZtL1pQVE1EZXdKMzdHSUNxQUtzUXQva0k4TGpNLzlw?=
 =?utf-8?B?STNjTE1aK2YxalowVjhkZTBuN2E2M3B3dlBvS2s1RGdmWU1nWFhpUzFNVjFq?=
 =?utf-8?B?UTlHSFc1NHFLRW5HOGZPYUxXWUVLMi9sR1J5ZnlJakVpamFpYWV3ZEVtaG9X?=
 =?utf-8?B?ZWw4ZGJ0d2FrUWtsWVcvQnpSelVMZFhXWE1UV2JxUzc4TnQvaFREaHloc3py?=
 =?utf-8?B?bU1nbTRWdkczaGJvV1NPdkwrTVZjekRFek9weWRCTzg5d2s2ZWZpOXBKUWxK?=
 =?utf-8?B?OC9hbUZXdXFrTERmWituM0JSQmlkeHFrek9qYXg2YVBSWVd2TFcyVUNOKzlL?=
 =?utf-8?B?RWU1VDg5UjBXemNvS210c0VCZUlsamFxWER6QUVlektyQkZpaVlDOXVkcWph?=
 =?utf-8?B?NzRkMVd4dkZWcTFiQlhDNklZWWhTTjVYSUcyNmZkYUgyQjVWdmRoaFA0TEg2?=
 =?utf-8?B?aVRTTitMRjE2RDlBNHh3dXJKdUV2V0VqQ0hPWFJpdis0elM1cDZsM1dQTEs1?=
 =?utf-8?B?LzJPaWFIbGMybGdqMVlibFRJS096UmFaaXJYVE5FS1hKeWN6ZmxEdy9TUTlB?=
 =?utf-8?B?Rm0wME9tdG9pTmV3eUt4a3JUakJuMXNaQlhrMlRkQzlESHJBcmJoUG9yK0xS?=
 =?utf-8?B?OVpGYU5SNUhsTHBwcDVBeHpLQk1BbHByUzV4MEFqV2dGZkZUZ2oxcXQwUmVt?=
 =?utf-8?B?MklkMllvSjRiUzZXMEZWZnZ3aUNYeHNJLzRxREdCYW9FK2o4SmJFUFlNM1B1?=
 =?utf-8?B?TW4xcUxTWG5JbUZqeEhMRm9hQUJJU0NVUXJSVm5pT2hrZ2dzYWJqQ1FRWnVN?=
 =?utf-8?B?K2QxMGE4SWhPbTdqRmE1Z2VYbVIvR05SbXhwelFaaTBKbThzRlZWTGdWb294?=
 =?utf-8?B?T2oyOVI2Q0tJNWdNRUdDZzlxVWZqRVRGaDIwNEZnbnNMZ1NXeDdGcTV4Qm5q?=
 =?utf-8?B?WVRJWEFYczEya2IvbGM3VnhpT2tXY0h5QjNRWVF4UDhGZnlmdVhIdUYwekZq?=
 =?utf-8?B?dVJUelB3TU4zUVRFV2h4RThyZE1hWThDdlNPTkxjTmIvN1djTEdHQ1VueU1l?=
 =?utf-8?B?T0lDNC9CelQ5WVlHRmwzdUF4VDh1L1UvbjZ3R2pLTWk4eDU2OFhEUjUyREts?=
 =?utf-8?B?RzlkbE03SG85a1BBTFJxOU41Ynl2ZlJFRFIvTEhOODNFbW8rVW5JU25nMWVZ?=
 =?utf-8?B?OVJtWWE2WnRhQUg2SE8wOUltdm93K0ZjUmJYby81T1NOcXBlM0FUdlNvSzM4?=
 =?utf-8?B?UTNSVjJnUzNMMFlsZXdZRXFaaHBsWGdGRVgwV0dsNGt2bXJQUUhmY2tISEw4?=
 =?utf-8?B?TG04bnIvQm9tSGhhMDRPRnZRL21zMGdvSlV3WndnbWFlZ2E5M0NoYVViR3cx?=
 =?utf-8?B?VEF3SjhUaXZNS3JhM1g1RXpSZjZvWlJxYitpbW1WM3dVRmZxN3lycDdvbkZW?=
 =?utf-8?B?dDZxR29GSDY2MFAwbTdKQisrVTlwVFFoOFNDUmw2NWRYMi9TSEZxWHhtck1s?=
 =?utf-8?B?UnpPSXFCdWt4Rk41T21EZmdyTTdBOXUrQWtNaWxKSHNpN0QxRHpHVFpDU2hE?=
 =?utf-8?B?d3Z2MThsanhoN3RHc2Rzd2x6WUR4ajhMbUI5dVVacGFJMUh2SWJTUmo3WDdJ?=
 =?utf-8?B?cThhelVNeXIvQzNVUENVc3FWczlKQnVmVGFHcDFwQzNoZEFLNklPNDZPT2lh?=
 =?utf-8?B?SGRJcGY0ZVRyUHZ0WnowMXRielNLV0NFR1pZeFl4M2pCc2lHUDFFYTc1aUx5?=
 =?utf-8?B?Y09iMnRrYUpmRHM2cS9aZ2NrSHR5dm5FVXk5WCtONmE5R2R4K1RmdmNYVWxX?=
 =?utf-8?B?T2d4SWU2YjNKcU9HZTdycHVUTXBTVXhBZ08vRkMzbWtnOHF2dUp6UDdXUW1s?=
 =?utf-8?B?ZTJGS3RXbTN0bjA0WlBqa2VDSUcwVU1vYlpWY0gvUDhDc0VXK0RaeFVCMm5R?=
 =?utf-8?B?Z1RCa1VmUmRPbzhzQ1c3ZlkyTVgwdXZFL3g3cU5NUjZXVEJjNU5SKzVrMlZn?=
 =?utf-8?B?SVRLcFBZQW91ZStDVkhlTmVBbTNtcWFSK08rclAwT0FXb254dlh2MFRMSEp3?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B714DF06710C4A81B9C0CE279B36CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fc624a-6349-4c31-1334-08db260fc3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 11:15:35.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBA2MWZURbQW027UlbU3IBmAHc+f3la08rekVK8BzTMHuFSr0Yqt18yJGi+CjbIwAz57fC1CQBIse1uZWInKzJulkU42vct5sAT4L7S36K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDMuMjAyMyAwMjozMCwgWWFuZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBY2NvcmRpbmcgdG8gY29tbWl0IDc5NDVmOTI5ZjFhNyAo
ImRyaXZlcnM6IHByb3ZpZGUNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkiKSwg
Y29udmVydCBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSwNCj4gZGV2bV9pb3JlbWFwX3Jlc291cmNl
KCkgdG8gYSBzaW5nbGUgY2FsbCB0byB1c2UNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291
cmNlKCksIGFzIHRoaXMgaXMgZXhhY3RseSB3aGF0IHRoaXMgZnVuY3Rpb24NCj4gZG9lcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgTGkgPHlhbmcubGVlQGxpbnV4LmFsaWJhYmEuY29tPg0K
DQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQoNCg0KPiAtLS0NCj4gDQo+IGNoYW5nZSBpbiB2MjoNCj4gQWNjb3JkaW5nIHRvIENsYXVk
aXUncyBzdWdnZXN0aW9uLCBtYWtlIHRoZSAnVXNlJyB0byAndXNlJ2luICB0aGUgY29tbWl0IGRl
c2NyaXB0aW9uLg0KPiANCj4gIGRyaXZlcnMvc3RhZ2luZy9tZWRpYS9kZXByZWNhdGVkL2F0bWVs
L2F0bWVsLXNhbWE1ZDItaXNjLmMgfCA0ICstLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9tZWRpYS9k
ZXByZWNhdGVkL2F0bWVsL2F0bWVsLXNhbWE3ZzUtaXNjLmMgfCA0ICstLS0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9kZXByZWNhdGVkL2F0bWVsL2F0bWVsLXNhbWE1ZDIt
aXNjLmMgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1h
NWQyLWlzYy5jDQo+IGluZGV4IGJhMDYxNGY5ODFhMi4uZWViYjMzNmVmY2U3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1hNWQy
LWlzYy5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9kZXByZWNhdGVkL2F0bWVsL2F0
bWVsLXNhbWE1ZDItaXNjLmMNCj4gQEAgLTM4OSw3ICszODksNiBAQCBzdGF0aWMgaW50IGF0bWVs
X2lzY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgICAgICAg
IHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAgICAgICAgc3RydWN0IGlzY19k
ZXZpY2UgKmlzYzsNCj4gLSAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gICAgICAgICB2
b2lkIF9faW9tZW0gKmlvX2Jhc2U7DQo+ICAgICAgICAgc3RydWN0IGlzY19zdWJkZXZfZW50aXR5
ICpzdWJkZXZfZW50aXR5Ow0KPiAgICAgICAgIGludCBpcnE7DQo+IEBAIC00MDMsOCArNDAyLDcg
QEAgc3RhdGljIGludCBhdG1lbF9pc2NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gICAgICAgICBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBpc2MpOw0KPiAgICAgICAg
IGlzYy0+ZGV2ID0gZGV2Ow0KPiANCj4gLSAgICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAtICAgICAgIGlvX2Jhc2UgPSBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiArICAgICAgIGlvX2Jhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ICAgICAgICAgaWYgKElTX0VSUihpb19i
YXNlKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGlvX2Jhc2UpOw0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9kZXByZWNhdGVkL2F0bWVsL2F0bWVs
LXNhbWE3ZzUtaXNjLmMgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9h
dG1lbC1zYW1hN2c1LWlzYy5jDQo+IGluZGV4IDAxYWJhYmRmY2JkOS4uYmVlZDQwZmUzZjkxIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1l
bC1zYW1hN2c1LWlzYy5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9kZXByZWNhdGVk
L2F0bWVsL2F0bWVsLXNhbWE3ZzUtaXNjLmMNCj4gQEAgLTM3OCw3ICszNzgsNiBAQCBzdGF0aWMg
aW50IG1pY3JvY2hpcF94aXNjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICB7DQo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gICAgICAg
ICBzdHJ1Y3QgaXNjX2RldmljZSAqaXNjOw0KPiAtICAgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVz
Ow0KPiAgICAgICAgIHZvaWQgX19pb21lbSAqaW9fYmFzZTsNCj4gICAgICAgICBzdHJ1Y3QgaXNj
X3N1YmRldl9lbnRpdHkgKnN1YmRldl9lbnRpdHk7DQo+ICAgICAgICAgaW50IGlycTsNCj4gQEAg
LTM5Miw4ICszOTEsNyBAQCBzdGF0aWMgaW50IG1pY3JvY2hpcF94aXNjX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgaXNjKTsNCj4gICAgICAgICBpc2MtPmRldiA9IGRldjsNCj4gDQo+IC0gICAgICAgcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLSAgICAg
ICBpb19iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gKyAgICAgICBp
b19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgICAg
ICAgIGlmIChJU19FUlIoaW9fYmFzZSkpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VS
Uihpb19iYXNlKTsNCj4gDQo+IC0tDQo+IDIuMjAuMS43LmcxNTMxNDRjDQo+IA0KDQo=
