Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C25FFB94
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJOR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJOR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:57:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D144558;
        Sat, 15 Oct 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665856649; x=1697392649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xZGPYhbuoclDcnFrrolE7Gb/DgeZYh/aMkNlB5vFu6o=;
  b=ZRCmQ2F2RGbqT/Q6FpvOjlGUWHxRNLcAvigja4Ko3ujYjwgRlAdbaLKI
   gi1Nw0j9kxks1LElZOrUTOb/aSAfmQqPoG2FzfGuIfNLjpMBJjZVr8aZ6
   CZWp/+Lcxt5XXuqMQX12ClYNLEMJD7O9M9sDn58N0u4bgdGQWph3Z00zh
   igjuIIL0Zp1MfjQyrO3Nl/AWgj1i5YSbz6hKilLrIk7C6Xs/RCQSq6mMG
   KfPvtihZyocNxP3R5vFouAY6p8JXaIogG84cfDnvfSh7KWwQ77BVrOewr
   fFrsja0VsYgyvrqCVBJ+d4/VgOp0aYt0crCd/Q56eAnDS9S1XKjnN4slK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="391869355"
X-IronPort-AV: E=Sophos;i="5.95,187,1661842800"; 
   d="scan'208";a="391869355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 10:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="605691395"
X-IronPort-AV: E=Sophos;i="5.95,187,1661842800"; 
   d="scan'208";a="605691395"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2022 10:57:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 10:57:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 10:57:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 15 Oct 2022 10:57:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 15 Oct 2022 10:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMEm+CpJd2gNdU3k/76H8n+pZI8LIsr/+OKZTywKqRZksVH2B7L5Nv/H/aVU+AQGDBf+edSVyb054C8b37ooKPbSX53QZcx+LAYNxqApVxHaY1Wz21XLKMXonJvFC0eSneoFjGjzcLQlgcUAYaE96GunSvrDiVy6LjCH1inovxh9xm9q56tVksl3ymOs1tqoLRSWrMK5pp01b2xda/BFG/UEilkyzLnwTN0bZZXyy5SmsZajJTjjd8SwHyo8nqregrRMKyLhq0V0o0Qnkqzm11A7f7oCYa0RYlD5J3HEeoj7n8NAQeKiquNij+fyljq1qIjoiFOL5Owf5Dm1BpEevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF9072oBY5tIsMI2nBM7V35ID0X1BoRpVReifFhgn0w=;
 b=GgEsAiPyhBOqSG0qV+INBMyBXsQYr69nAXQAxP1UCm+pJRasGvd0E863tqO5+e3qAoasECKYJo7Wzet7FTZlxyOiZvRkPsFTealitqwIbevbDS56EKw1Q1AkUN+iWuXeycsgNdrbFHExsH4vDKWc4ZRdSZ4n7GjDtcRIrSUgLxtrOA3LjTd4QJ7a5pPlZOJt0mjLYi2w/XmCHR/JRehvmwJfgmLMhcqPOrkdE0ad3hh68xJmvaVCYCSN3EvQgcwqG5lzswzSCxPk4zVh6AEKvEqsc3DyQ3dn/FL+ik0TXtc7o24i8SW77jfqzOg+tYT5DlO3SDqOIvuarZcAb9xlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 17:57:20 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9ee7:3ca:b4ab:59c0]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9ee7:3ca:b4ab:59c0%6]) with mapi id 15.20.5723.030; Sat, 15 Oct 2022
 17:57:20 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: temperature: Add driver support for Maxim MAX30208
Thread-Topic: [PATCH] iio: temperature: Add driver support for Maxim MAX30208
Thread-Index: AQHY3k0KPuUdaeImKk+o/Dj/8gLSwa4N4A2AgAHYkZA=
Date:   Sat, 15 Oct 2022 17:57:19 +0000
Message-ID: <CO1PR11MB4835A5C17C3D72395C45850B96279@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221013151203.406113-1-rajat.khandelwal@linux.intel.com>
 <20221014141027.00004905@huawei.com>
In-Reply-To: <20221014141027.00004905@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 335da497-4cad-45b6-7caa-08daaed6b474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rwE7n5F80/kA1b5k4TdoJlIPYPJDsjccWucuwwPRq8QVQ68KhPHz5ihHAq8y0Kb1V7odNgKq7LDzAC+CezMuzjdhY/av72zLID3HXNNunEjDvS8HuBi/K3mq2pT8sPj/fyAVbSjUTFlPNF901yC+aUDFQiv58cqyQyu6e72ykYD20pHJ3xTPTIbEMDV3NlDRRyFQ0KkBU2wB+wuhm+Loixz65ox2qRU8rL7PlV0SbfcgnimXZDwie+3XfNkvp8vM8KylIYfFNdx9lZsIfluzegWvvhC6J5qFVrHFGbV2owR2bjcjbeBhTK3nZoigMiVKLXjNoxe+lQNUoRpq1zd64E9Vo5uHraMGm6ETMWcMKx018oyCi9SX3uxTb7D1eOK1YDa6PxmWVhrmQcaPVBr7ZJjjY6bcifmLKDwcO96w2FxM4IM+416VbW5skE7124m0IWX7QWCqZ8COENlssXGXjKLFbIYR6UjFF4ihsJRnq16TK2uIn3bTVfAfmScIjm8/jqtezwUmYveHhRGjdAQoStdwN8ivYab7O89Ewi0eQGXoIqSi5dWGP6vyn84xgHr+aBH3FWsmaeP1Vim4R0lEnT4g9EC4NlX7B004/Oi+0FTpbpfBfgwXnUWQCpllqCwOkPonDZF7uxRyVlkmnPuO9rPYgDlhfFPoQ/06W3IW0ZkLpcn8sehRr/ICRcIayxBhKBRpFxPFv19TNhhXPd2/fg7ELy9WhLRBpR4vcdAwHoav6HTV7oewzdgJTNb5daEEKkBf9SbepFAmdb/RN+Cmk4isNOsOYf9THdot6D3WuYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(86362001)(33656002)(38070700005)(38100700002)(122000001)(82960400001)(110136005)(83380400001)(55016003)(5660300002)(30864003)(7696005)(53546011)(26005)(9686003)(186003)(6506007)(966005)(478600001)(2906002)(316002)(54906003)(4326008)(76116006)(64756008)(66556008)(66476007)(66446008)(8676002)(41300700001)(71200400001)(66946007)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MBo9bNXYJts2DXMSnTARfxxc09pSPxRCvXRKUOlYqMCMZbJzJW7SXCJ1mY?=
 =?iso-8859-1?Q?D+TR4G0pDZfAP2jgSjD+lSUV92fR4MwQAEy3jJHHzH1ASG7icnMYbUL99C?=
 =?iso-8859-1?Q?74dTp9IlW8Z+SKzymRfZbIS50IMK2IW3K4Rdyw8ffwA27gII/E0sKTiEbt?=
 =?iso-8859-1?Q?d6UwYtwFZFMkNi0JQGFYDhRQ4AKQrgJly43pHqSzc+X3S3GP2vBbQbNZOJ?=
 =?iso-8859-1?Q?VqK4SNTdW9BuHGj57WjCCJzR9AV86wtuhe8OPajUy0bLr/L9v6uNvP7fcK?=
 =?iso-8859-1?Q?ADvN9NwTFuzXqbqy958o3xM7OLxjlyK8YA8XDCKcsZVwmTyrgwtj5S9D4D?=
 =?iso-8859-1?Q?lZdy8y7WKP1qHhcuzk7tHuMQJZ4bDyLq19lRrCnFQS3re6Mix1SsEMMQX9?=
 =?iso-8859-1?Q?EKhpypUnlFt7Qt3bhnWsbqQe7bw7zHp8/Wn/jqNBLnQCOBKT6xLB7pmrnW?=
 =?iso-8859-1?Q?o78jkjF3L+imyonRn9jVmAMVhNg/2XS9DJ9sB2LlInlro6a7HZidXNbl7z?=
 =?iso-8859-1?Q?uiOpPS2B51aBX6O4ZWylMxoLMM+0gCSAV2aBjCDK0UkAFWXWNpyQiNgoE/?=
 =?iso-8859-1?Q?qWksyThnn15xt6McnznqhEPdfpM4xmh5l6K/Vy8ruYiz1bYepKGJkk/INJ?=
 =?iso-8859-1?Q?cZZV4P0/6n8KJT56DE9GgDOhNzFZG/K9zi59SyR+ZFoErVxdWUpmreYLM4?=
 =?iso-8859-1?Q?QVNLsXe6Tkx4i1pHH+7Dpg35AuBDdlzBB8qQd7uuwUb+WZl3CuXU/zClNA?=
 =?iso-8859-1?Q?LI9KSz72LdDJuj610CRJhoMWdYywwr6KqxVs0gR4PQ9Q5LIn8dVbOLnIuQ?=
 =?iso-8859-1?Q?GupI6T81eiBOuTe4cjB/ZtdRLFsqATUboH9r7gAt7+0XTPUEGdSS/7OUaJ?=
 =?iso-8859-1?Q?0OAgelniW/GkqClYWlb/dFSHBxJnvHMxa47BOvVE5hX1KeeTTzGXCnYjyo?=
 =?iso-8859-1?Q?FF9Lv8y/NpaBxJOcDdp3ZVT8KC8gfc0Qc/goqq1FKZw8zk6nUier2lYkeF?=
 =?iso-8859-1?Q?aDsO+Gk6Pi0rwz5bI4rSoQCl/SWe6UZvcCd0AF9bejrWzSTO0OgLYKFRD6?=
 =?iso-8859-1?Q?4KyGYmQntEATy5Yp3aTOVIBq+sQQFC8ac+FbliL4Z4iz3n1A+WW9g6/y85?=
 =?iso-8859-1?Q?hxfYVNtCvh9uVOPDDpI/LF0JMnDmPiNFtMFIvyanYdnOpCAF1yQK4mczOu?=
 =?iso-8859-1?Q?8XgJFViljDzDGDuxKhbyA9WSEq9Nwv/QlXJ3iiNmukRKDq8jcHbhjIVORq?=
 =?iso-8859-1?Q?x8nHIjes63LXhlnHtg3Ds4sgjrThIsfF/aj5vcTGXTlJSKpn5nwsVADG7v?=
 =?iso-8859-1?Q?tMLjVj1IeOvQQ36DbyDkkZfU7e7NVTpcEpbotxBpPngEbkcCWk0Kwczx2O?=
 =?iso-8859-1?Q?UAKQlJC3Qew1JM1WzDfWDKnM9OQnoOzXsSXmbeVRNS6TfxhBJGoQY/um6x?=
 =?iso-8859-1?Q?KiqXXWGkMh8i1wSbET0rc+JaLvmTW/woJNwLijKIXBNKURuKI1Hp9469/d?=
 =?iso-8859-1?Q?yRN/Bx7QCiEEfazwkqDQVcnX9qeGKHJiKwkiLxjn9DuzdlrZ9vz3sIqN3s?=
 =?iso-8859-1?Q?6eHYr0BWFQYw5uw5UTCScxm76CoBEBeflMBbCnecCNhMTBwdPssXqHr+FT?=
 =?iso-8859-1?Q?a9UHgOUCFZ/VP/rKroyAVgOLeibsfs+U+ffZu/iPdKbdhflaJ8G/9jcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335da497-4cad-45b6-7caa-08daaed6b474
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 17:57:19.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWPuV881me85vdAti1bM3e3V2YBZhKqyfEB12hs/sKEmK1pqwtvIkdB/efuzZuvZTsHmLWATegm+ryz9qrEKtuh5i77aUIsz0H6GhoS52RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,
Thanks for the suggestions and remarks.=20
Couple of things before I send out v2.=20

Yes, I agree that hwmon could also be a receptacle for this. AFAIK,
IIO is directed towards devices which are ADC/DAC converters in some sense,=
 which
makes the driver I wrote also fall in the category.=20
I am not a better judge but personally, I would choose iio over hwmon anyti=
me since
the interface is something which has fancied me and enamored me to it. :)

FYI, I am also writing another driver in parallel (a temperature sensor aga=
in) in IIO
subsystem, so will ask you in this thread itself if it is considerable?

Nevertheless, I genuinely would be grateful if you consider this driver to =
be a part of IIO
subsystem. As a maintainer for this, I would be happy to shift this to a be=
tter subsystem
if something comes in the future or even hwmon.=20

Switching to another topic, I have answered your comments and have some dou=
bts which
I would like you to answer before I send out v2.=20

>> That's a large todo.  Why set it up if the support to actually use it
isn't there?  Is there no mode where these GPIOs are disabled that would
be more suitable until you add support (optionally as gpios may well
not be wired up).
	There is no specific mode to "disable" the GPIOs. I wanted to trigger
temperature conversion having GPIO1 as a trigger interrupt so I put this as
TODO. Yes, its possible that GPIOs are not wired up but this would provide =
a
feature for this sensor for the GPIO to use.=20
Also, I don't intend to keep the TODO for long. The device tables and kerne=
l code
are already in process to remove the TODO.=20

>>> +static void max30208_gpio_setup(struct max30208_data *data)
int return so you can indicate an error to the caller.
	Here, I am configuring GPIOs to act as interrupt and temperature
conversion events. But if configuration fails, I don't want to fail the dri=
ver probe
as this is secondary and not absolutely necessary. Thus, there is no point =
to even
check the return value.=20
Can we proceed with the function as 'void'? I will give a warning if any of=
 the GPIO fails
to be configured as interrupt/conversion event. That would suffice.  Will t=
hat be ok?

>>That leaves is in nasy unknown state. Error out.  If the device fails
the i2c call because it resets quicker than sending the Ack (quite
a few drivers do this), just drop the error check.
	The failure to perform reset will not considerable affect the device. Some=
 things
like FIFO buffer could be not empty initially but since temperature reading=
s are taken
at the end of the buffer, those shouldn't affect. Hence, I have implemented=
 dev_warn.=20
The warning indicates that if the user thinks that on triggering temperatur=
e conversion 'n'
times, there would be 'n' FIFO readings, then he is wrong as device failed =
to reset.
This is the only motive of giving warning on reset.=20

>>> +	max30208_gpio_setup(data);

As mentioned above, this should return an error if it hits one and
probe should fail if so.  It is very unwise to carry on once we have
a device in known state because an error occurred during setup.
	The GPIO configuration error won't affect the device's usability.=20
Hence, I haven't returned an error on failure. The main objective is to
provide readings. GPIO functionality is secondary. Nevertheless, I will iss=
ue
a warning if GPIO configuration fails to let user know GPIO's won't work.=20
Would that be ok?

>>I'd prefer seeing the of_match_table() as well.
Otherwise we rely on the fallback matching and lose the advantage
of having the vendor name in there.
	Sure Jonathan. The device table is in the process of testings. However,
I am implementing acpi_match_table in the driver. Will that work? Is the
of_match_table necessary?

Thanks
Rajat

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=20
Sent: Friday, October 14, 2022 6:40 PM
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc: jic23@kernel.org; lars@metafoo.de; linux-kernel@vger.kernel.org; linux-=
iio@vger.kernel.org; Khandelwal, Rajat <rajat.khandelwal@intel.com>
Subject: Re: [PATCH] iio: temperature: Add driver support for Maxim MAX3020=
8

On Thu, 13 Oct 2022 20:42:03 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Maxim MAX30208 is a digital temperature sensor with 0.1=B0C accuracy.
> Add support for max30208 driver in iio subsystem.

Hi Rajat,

Opening question for all temperature drivers is why IIO rather than hwmon?

There are a couple of standard reasons why the existing temp sensors are th=
ere.

1) They are weird.  E.g. the infrared sensors.
2) They are very industrially oriented (read expensive).  Usually things li=
ke
   high precision thermocouple front ends.
3) (this one is a bit nasty) they share silicon with more complex sensors.
   This sometimes happens with things like pressure sensors. Same interface
   covers devices with an without the pressure part.

Definitely hwmon if typically used for monitoring temp in a PC etc.
Other cases are somewhat trickier to answer.  We have iio-hwmon bridge for =
the really unclear cases (so it can appear in both ;)

Either way I did a quick review. Comments inline.

Thanks,

Jonathan

>=20
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
No blank line here.  Datasheet is part of the tags block that can be scrape=
d by automated tools so it needs to be in that block, not on it's own.

>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>


> ---
>  MAINTAINERS                        |   6 +
>  drivers/iio/temperature/Kconfig    |  10 ++
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30208.c | 273=20
> +++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 drivers/iio/temperature/max30208.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS index=20
> f1390b8270b2..7f1fd2e31b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12373,6 +12373,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
>  F:	drivers/regulator/max20086-regulator.c
> =20
> +MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> +M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/temperature/max30208.c
> +
>  MAXIM MAX77650 PMIC MFD DRIVER
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig=20
> b/drivers/iio/temperature/Kconfig index e8ed849e3b76..ed384f33e0c7=20
> 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -128,6 +128,16 @@ config TSYS02D
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys02d.
> =20
> +config MAX30208
> +	tristate "Maxim MAX30208 digital temperature sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Maxim MAX30208
> +	  digital temperature sensor connected via I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called max30208.
> +
>  config MAX31856
>  	tristate "MAX31856 thermocouple sensor"
>  	depends on SPI
> diff --git a/drivers/iio/temperature/Makefile=20
> b/drivers/iio/temperature/Makefile
> index dd08e562ffe0..dfec8c6d3019 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) +=3D iqs620at-temp.o
>  obj-$(CONFIG_LTC2983) +=3D ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
> +obj-$(CONFIG_MAX30208) +=3D max30208.o
>  obj-$(CONFIG_MAX31856) +=3D max31856.o
>  obj-$(CONFIG_MAX31865) +=3D max31865.o
>  obj-$(CONFIG_MLX90614) +=3D mlx90614.o
> diff --git a/drivers/iio/temperature/max30208.c=20
> b/drivers/iio/temperature/max30208.c
> new file mode 100644
> index 000000000000..e16c31621065
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> + *
> + * Maxim MAX30208 digital temperature sensor with 0.1=B0C accuracy
> + * (7-bit I2C slave address (0x50 - 0x53))
> + *
> + * Note: This driver sets GPIO1 to behave as input for temperature
> + * conversion and GPIO0 to act as interrupt for temperature conversion.
> + *
> + * TODO: trigger temperature conversion via GPIO1

That's a large todo.  Why set it up if the support to actually use it isn't=
 there?  Is there no mode where these GPIOs are disabled that would be more=
 suitable until you add support (optionally as gpios may well not be wired =
up).

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#define MAX30208_DRV_NAME		"max30208"
> +
> +#define MAX30208_STATUS			0x00
> +#define MAX30208_STATUS_TEMP_RDY	BIT(0)
> +#define MAX30208_INT_ENABLE		0x01
> +#define MAX30208_INT_ENABLE_TEMP_RDY	BIT(0)
> +
> +#define MAX30208_FIFO_OVF_CNTR		0x06
> +#define MAX30208_FIFO_DATA_CNTR		0x07
> +#define MAX30208_FIFO_DATA		0x08
> +
> +#define MAX30208_SYSTEM_CTRL		0x0c
> +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> +
> +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> +
> +#define MAX30208_GPIO_SETUP		0x20
> +#define MAX30208_GPIO1_SETUP		GENMASK(7, 6)
> +#define MAX30208_GPIO0_SETUP		GENMASK(1, 0)
> +#define MAX30208_GPIO_CTRL		0x21
> +#define MAX30208_GPIO1_CTRL		BIT(3)
> +#define MAX30208_GPIO0_CTRL		BIT(0)
> +
> +#define MAX30208_RESOLUTION_MC		5

I would spell out as MILLICELCIUS

MC is not a standard abbreviation.


> +
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock;

All locks need a comment to say what data / device state they are protectin=
g.

> +};
> +
> +static const struct iio_chan_spec max30208_channels[] =3D {
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCA=
LE) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +static int max30208_request(struct max30208_data *data)

I'd like a comment on what exactly this causes to happen.  Single reading o=
r lots of readings?  If lots, how do we turn it off again?

> +{
> +	int retries =3D 10;

Any retry counter needs a comment explaining why it is the particular value=
 chosen..
I'd guess here because sensor can take up to half a second to read?

> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SET=
UP);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret |=3D MAX30208_TEMP_SENSOR_SETUP_CONV;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SE=
TUP, ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	while (retries--) {
> +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> +		if (ret < 0)
> +			goto sleep;

The device fails to respond to i2c reads?  That's nasty.  Add a comment on =
what is going on here.

> +
> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> +			return 0;
> +
> +		msleep(50);
> +	}
> +	dev_warn(&data->client->dev, "Temperature conversion failed\n");
> +
> +	return 0;
> +
> +sleep:
> +	usleep_range(50000, 60000);
> +	return 0;
> +}
> +
> +static int max30208_update_temp(struct max30208_data *data) {
> +	u16 temp_raw =3D 0;

Value isn't used, so don't assign it.

> +	s8 data_count;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D max30208_request(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> +	if (ret < 0)
> +		return ret;
> +	else if (!ret)
> +		data_count =3D i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);

See below, the error check should be here.

> +	else
> +		data_count =3D ret;
I'd like a comment here to explain what this flow is. =20
> +
> +	if (data_count < 0)
Can only happen after the read, so move the error check up there...^^^ Also=
, use ret =3D i2c_smbus ... there and then unconditionally set data_count =
=3D ret after the error check.

> +		return data_count;
> +
> +	while (data_count) {
> +		ret =3D i2c_smbus_read_word_swapped(data->client,
> +						  MAX30208_FIFO_DATA);
> +		if (ret < 0)
> +			return ret;
> +
> +		data_count =3D i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);

I'd guess that the counter never goes down other than due to reads?  If so =
perhaps save on i2c_reads of the fifo count, but first clearing the ones we
know about, then checking the count again.   Arguably, if they are new they
are after we asked for a reading anyway, so perhaps we shouldn't be looking=
 at them - but instead using the most recent one before we starting reading=
?


> +		if (data_count < 0)
> +			return data_count;
> +	}
> +	temp_raw =3D ret;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return temp_raw;
> +}
> +
> +static int max30208_read(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int *val, int *val2, long mask)
> +{
> +	struct max30208_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D max30208_update_temp(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D sign_extend32(ret, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D MAX30208_RESOLUTION_MC;
> +		*val2 =3D 1;
> +
> +		return IIO_VAL_FRACTIONAL;

return IIO_VAL_INT;=20

> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret =3D max30208_update_temp(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D sign_extend32(ret, 15) * MAX30208_RESOLUTION_MC;

Don't have PROCESSED.  Drivers should never provide both raw and processed.
There are a few obscure reasons why they sometimes do, but non are applicab=
le here that I can see.

> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void max30208_gpio_setup(struct max30208_data *data)
int return so you can indicate an error to the caller.

> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_GPIO_SETUP);
> +	if (ret >=3D 0) {

	if (ret < 0)
		return ret;  //An error is an error, if you hit one fail the probe.

> +		/*
> +		 * Setting GPIO1 to trigger temperature conversion
> +		 * when driven low.
> +		 * Setting GPIO0 to trigger interrupt when temperature
> +		 * conversion gets completed.
> +		 */
> +		ret |=3D MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
> +		i2c_smbus_write_byte_data(data->client,
> +					  MAX30208_GPIO_SETUP, ret);
check error on that.
> +	}
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_INT_ENABLE);
> +	if (ret >=3D 0) {
if (ret < 0)
	reutrn ret;

> +		/* Enabling GPIO0 interrupt */
> +		ret |=3D MAX30208_INT_ENABLE_TEMP_RDY;
> +		i2c_smbus_write_byte_data(data->client,
> +					  MAX30208_INT_ENABLE, ret);
check for error on that.
> +	}


> +}
> +
> +static const struct iio_info max30208_info =3D {
> +	.read_raw =3D max30208_read,
> +};
> +
> +static int max30208_probe(struct i2c_client *i2c) {
> +	struct device *dev =3D &i2c->dev;
> +	struct max30208_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->client =3D i2c;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name =3D MAX30208_DRV_NAME;
> +	indio_dev->channels =3D max30208_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(max30208_channels);
> +	indio_dev->info =3D &max30208_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);

This exposes user interfaces of the driver so to avoid races it must be las=
t thing done in probe.

> +	if (ret) {
> +		dev_err(dev, "Failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	/* Reset the device after registering */
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> +					MAX30208_SYSTEM_CTRL_RESET);
> +	if (ret)
> +		dev_warn(dev, "Proceeding without successful reset\n");

That leaves is in nasy unknown state. Error out.  If the device fails the i=
2c call because it resets quicker than sending the Ack (quite a few drivers=
 do this), just drop the error check.

> +
> +	usleep_range(50000, 60000);
> +
> +	max30208_gpio_setup(data);

As mentioned above, this should return an error if it hits one and probe sh=
ould fail if so.  It is very unwise to carry on once we have a device in kn=
own state because an error occurred during setup.

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max30208_id_table[] =3D {
> +	{ "max30208", 0 },

If data is always 0, don't bother setting it.
	{ "max30208" },
is fine.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> +
> +static struct i2c_driver max30208_driver =3D {
> +	.driver =3D {
> +		.name =3D MAX30208_DRV_NAME,
> +	},
> +	.probe_new =3D max30208_probe,
> +	.id_table =3D max30208_id_table,

I'd prefer seeing the of_match_table() as well.
Otherwise we rely on the fallback matching and lose the advantage of having=
 the vendor name in there.


> +};
> +
> +static int __init max30208_init(void) {
> +	return i2c_add_driver(&max30208_driver); }=20
> +module_init(max30208_init);
> +
> +static void __exit max30208_exit(void) {
> +	i2c_del_driver(&max30208_driver);
> +}
> +module_exit(max30208_exit);

module_i2c_driver()

> +
> +MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
> +MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");=20
> +MODULE_LICENSE("GPL");

