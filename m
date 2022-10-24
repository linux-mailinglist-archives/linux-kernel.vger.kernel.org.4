Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACC560B581
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJXSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJXS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:29:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEDFFFB5;
        Mon, 24 Oct 2022 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666631497; x=1698167497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bXsCbhjTZZYLk0y1k/filSDU9Wy5dHE0VAMdtNjvbqg=;
  b=C6fLhrpvct4wCFVH9iasuGsWE/VsylaOAtk1nedqs/Z82aebwhMSADvr
   JDqJJa4ODrq5TNMTING/1LIOr2BquFxiiGyEdT1c9i8mvdlsEEhP8xNHZ
   lgU2V7+J5CIhDED4VAV9fKINcE7Ik/2OQWDmTBAZpwiYRGsRwUsBW1aUD
   3Y/EYi4tgxZ74ojpXsu4t1I4r9Nzzjm6/Gc7BwJqX8nsQZJasJ+00XyOL
   BcXFbOgqNfmkRGa5fO1HDIVKlkWRnQ3jZBO+ZL40rDopbHhoFlULxbWUy
   POFeQ0t3wL7eGGoSIDL/bSsv9ypUf73LFM6BYIS+1KoHeJUgKY04XQ17O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393792765"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="393792765"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 10:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="664615436"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="664615436"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2022 10:11:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 10:11:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 10:11:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 10:11:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 10:11:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDFH6aUPerQdaqoU97AXRJN7f+OaDrAzWeo9fvwxvJnIez1W3TPOZbmWbP7Q3w1sGuYOx3mUUJtoPleuYJTl5sCyB+DuJb7xEbMHNnKNjZ4wWJcwXtcicMV7Kn/G+01g44tncjgTgjcLOZN7T+DMutsqFhWm6ZN1oiMJswYJbM/KpsNF99XUO16tkdzCk3w6n9+UivO7HNxQHc8mUZ8ySYbKCcZiOrLKCuIQ2Qma1l74FswV0jD9VOzQV4rFPFfeTlPrMsNdC2Nx1tLz0Xpa+iZX8LDQ7Ych+ABfwk/ZcPuaGYlOc9C+BGteUkd3gAjCMV3fPWULHWS7XAPvGopRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HD2vuvJLHX5JpelKfm9OZvkaJlA7V/u/HB/TlPSTJo=;
 b=T9c664vadWptmNj+24fcaxapbj4quyzMxANIMbIIiFGE4+VgPVa71z6lPpUsrvS4zLt3pnow65gblyuPVUeilxoX2op7CkIuAVAyEq2d3pwMcImdMt65BuXXjnQGhCJl3xabs6kFBq/OWtfRX/MplDm4nVc/9jvy9QBQ3uViHoG23AeNysLHlyAQxrSPyAvl6PY08iWovwfkyORB53SqfxU6XXYh8xU+uIc5fiT8r6B0Hp1yeglL/I/ak7N2KgICQ8mW8UfSCFG/erHTx1H0W9rsD5R/DgPrnXIdAoPCnKrcqXoF2TW3Odor24Cw80ZhRU7kXnKDjsf4N0Ni1cdw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by BL1PR11MB5221.namprd11.prod.outlook.com (2603:10b6:208:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 17:11:17 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::ce74:6470:a65c:5d7a]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::ce74:6470:a65c:5d7a%5]) with mapi id 15.20.5723.035; Mon, 24 Oct 2022
 17:11:17 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v5] iio: temperature: Add driver support for Maxim
 MAX30208
Thread-Topic: [PATCH v5] iio: temperature: Add driver support for Maxim
 MAX30208
Thread-Index: AQHY5wB5eeSLMfTGpUiIiT3lfgy+Ua4daXmAgABabxA=
Date:   Mon, 24 Oct 2022 17:11:17 +0000
Message-ID: <CO1PR11MB483509CDD93AFA3176C42080962E9@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221024165658.181340-1-rajat.khandelwal@linux.intel.com>
 <20221024112829.GA2807876@roeck-us.net>
In-Reply-To: <20221024112829.GA2807876@roeck-us.net>
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
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: 05d76308-ca25-4666-31e1-08dab5e2c38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YM0ASi5TA07yQbi8IYEP5mmT2fK27F8ZQgYhSDbY74ogc6rT5xTkPBFJdoX5PvPeT5lUPY17q3NAOzXFfccm5+0V+5c1CyM3mP7fXUwUbmkF0yu1TEM+BA4tC4lxN/d8DBfn2By1xOKiX1FJSDCYmuqMIj/4QfTEoP7kpm3QqxRvQZRfZYS6UNalBBPi6CnCbDf7dFyQjfHqdccqA8B+sTwfTQkUb8ttGaUKpsYsnhB+wgNDUBluAdU7LNo5zq8XhTlSjUIxtEGKqzb8HE/eRIExCd8nlPtAmLfYXopDxHRVqVdIFWr/WlUdwnbXx608GLmCia4usyPl/F5u7rXrPIPpP7eLJ3ReW1Wgd5BZb6yGo4jq3Cl0CcJgGtIuw9zZJaAiISS2LmgudeUy4+PFvJ2ys+LNaJbo04wZGcs2NuStBAS++tGad1QsxnaUBt1H9ZEzOd0o58yl1J03ZkXikhEKBsi7GDv6bGF5wwH5HXRMCrwPnFkROKOS6fsdZQoY+0bqpVr1BRx3xcfLQUxEKdSgfQZUAHWIkynmPfkzxvo/ugoDQKf1p9xJWE8BAYgfPbaUK0FSHN0g5vTPDexZgcO2VxW/EzdqlRfTS8txCtkGX7kZWlhcFh+NfDMrC4SATi1h9ZdeqIC3TntJayr+UNzccEsxg/ane7ScsQ4umYwCiQKHAgGLmIKZSfTe0iuysiPl1oqHysNhjgprD2rS/2fXQXfKV0hx6+g5idCj123Qd3nK3PLGZgtsys1XDtinb62ycEIXQUKF2Goc/aaZa6mrJNrC12C3WTxzjiKBNT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66899015)(478600001)(966005)(83380400001)(82960400001)(86362001)(7696005)(110136005)(55016003)(64756008)(66446008)(66476007)(122000001)(5660300002)(54906003)(53546011)(66556008)(76116006)(30864003)(8676002)(316002)(38070700005)(2906002)(186003)(71200400001)(9686003)(6506007)(26005)(33656002)(52536014)(4326008)(66946007)(8936002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fkYhht1bmvMiXqTxKVH8HILhgTbGTOh8Df8VInhyWpa00e9FXrBeF29Q5u?=
 =?iso-8859-1?Q?Gc7tUrja+vchmvaNU2WV4ak6rihrvsX3MEytGsqG79zpAWUOUXgcTU4XvF?=
 =?iso-8859-1?Q?7vKAykxswrjE1uTSDJKmQmn5aThChZk3hhsErPBPjk4symdHyBxvRgTysc?=
 =?iso-8859-1?Q?VnRuUiVmChzDAeXel0pwfznzBRWp+1IewnG0aADb1etqkf2LQWlDe7Qosc?=
 =?iso-8859-1?Q?GgOrXCoa/e+7rMV+X69A3afo+QzA5daU5IqfYiimjmzgArHS1Sg0+IoWHv?=
 =?iso-8859-1?Q?C5gNb7NQvk5OAqh02tNm2WdnrDzaLt9n9aZBfT3n4UTt5Ai7Uxg5qU50ge?=
 =?iso-8859-1?Q?7FWDgpDHCYfBRZU81635f1vXJzvUVadNU4Ccjv/fpHcEAki7zpO0p0QR0B?=
 =?iso-8859-1?Q?aLvf46RyfizbN62No/fGYa62enMLCFOPMJd+TBSPgeWeAPvquqF/qc4Mak?=
 =?iso-8859-1?Q?c6Zhf7FSTrj1zj3bd5Z3hs/GZY7xOxaR/5KG2HvA7yihfLfixARAM8MZNM?=
 =?iso-8859-1?Q?fgo0FgoffrCCc7d9mXKfAdG7clUpbTjKKushG9V8nQ8qiNkJndC8EUrO+q?=
 =?iso-8859-1?Q?hD8iEYYF0VB4UP34unzRZIICPmOBlLeSzjLKK1GWDjL/rzB7rk2L8DIZYO?=
 =?iso-8859-1?Q?BlUwv4vr0Qrn7pKNFbSZ9TVFAY6V46LJA8+smBNZI7r7cTci1Oz+bB2TcX?=
 =?iso-8859-1?Q?S+crrSiew6OkfriLkI/RNic1pG0kfY+wkmAtHKozFD5lJfnjdZDJr80+s8?=
 =?iso-8859-1?Q?HznjIirv1Eu6ZJzgRCkAUpz8UAxFK6iRtPpb45fftvRuHNDW+pkJ7pwelq?=
 =?iso-8859-1?Q?/j0fcddIht5kMk65MU5oVSgu2ghqZeZ0AsVV2flggeCdpGb80pZLb1QgQ+?=
 =?iso-8859-1?Q?scSu/ed1o9REw02hd4yqj6MRAYYqUZ7aiOeUL7ss0idyi+p43TrS7l3OR+?=
 =?iso-8859-1?Q?UmJ2bEKSxBdhAcCvAnxxXreTk9jh4ihQDC+HvM4wJI3z0SqqcB5X65Ta7A?=
 =?iso-8859-1?Q?gGrBYvURe48Fw+Wv1VLxU+Qxq5A3kqIizVwEGmT8PdiH9+kLTNjhkRSDrE?=
 =?iso-8859-1?Q?NPdZhunGhokQVO2PtbljAekYhSNDQ5oaJ9gi4IYNnEtFH/OydcnDjLnFtv?=
 =?iso-8859-1?Q?Sve88QAfFXTIVVJuwHULJmd288fX9AAnqge7XGKEXN+t1hs3S6yB2abg6I?=
 =?iso-8859-1?Q?XmQF8oWyzGHBI4MST2Pw2aP78cSHRJi6aaNsQCJxnAHAd1yduf92wpfRT0?=
 =?iso-8859-1?Q?Hm0vpr+HC68nrlT1l4YYQS8Ufe0xdA/b/4arfuIDv1sX6DP1LXtth+4Hi5?=
 =?iso-8859-1?Q?ytxsmTccJm3+GYO/kD+++Tz/DxhlJe3BzZjsk353BfJQ/1Dgn0dKfG3P0S?=
 =?iso-8859-1?Q?r8BrXPh5fyGGth4nyxBTY5uI+6v7RFl9n4qClLuK4Ks1Tmx/+rDw6DOPzO?=
 =?iso-8859-1?Q?oHA2rX/PzOZEFS1SU6EBcara0QYWnzDOFT8cASgn8clk9vhnaJd8+Ep/cm?=
 =?iso-8859-1?Q?1D9GWAbjZw7O8UV4ZXfS7nEpUWL38LEuNz/f6GhnZEIo77UoIbKNJ8RV4j?=
 =?iso-8859-1?Q?j7JQlhMv4IavyLaj4EZYrFV6B612mbmA2IfdalbR0sF3Gpbxb5nB+2SqAQ?=
 =?iso-8859-1?Q?bhPMZsa+XaNtBCKee4AhYWOMcDNhFoJr37yVq6AtS7afVGcwo1gmexhg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d76308-ca25-4666-31e1-08dab5e2c38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:11:17.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y882wqeFntHiSKqHcNEiPFEOoYOpVS5oTp40v4BDGh1AffFh6JwR/SUCIzc2A3HjhOK2vugA1uC0BnWMWqt4JHCcAq/jE3M5WIb1QsWZrTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,
Thanks for the acknowledgement.

>Agreed; the sensor doesn't seem to be very useful for traditional hardware
>monitoring. The driver better resides in IIO.
Cool! I didn't know the categorical reasoning behind this but since this is=
=20
accepted in IIO, I don't have to do anything more.=20

>I don't understand why readings are discarded. Why trigger multiple
>readings just to discard all but the last one ? I thought iio would
>be expected to return all values.
Ok. The plan is to trigger temperature conversion on the GPIO input also.
The user can trigger as many times the temperature conversion he wants (I a=
ccept unnecessary),
which will keep the FIFO increasing (without reading converted values) but =
the driver should be
resilient to all the erroneous zones. Also, when the user does really make =
a syscall to read the
temperature, it definitely should be the last converted reading.=20

>This is really pointless. The register has only one bit to set.
>Just write that bit; reading the register before that is pointless.
I think the register also has some bits which are reserved. Hence, rather t=
han to make a number
for specifically the value keeping those bits the same, I read whatever is =
there and only store the
required one.=20

>Also, the code assumes that one of the gpio input registers would be used
>to trigger temperature readings. Why trigger another one if this is indeed
>the case ? Triggering a temperature reading should only be necessary if
>there is no data in the fifo.
GPIO input triggering is yet not implemented as I would have to work on ACP=
I interrupts and I have
written the driver for now to get it included in Linux.=20
There are 2 ways - via GPIO and making a syscall. I agree that temperature =
reading should be
necessary only when there is no data in FIFO but since we intend to keep GP=
IO as a trigger point,
user can keep triggering conversions and not reading them out. (As pointed =
above, driver should be
resilient to all erroneous zones).

>The datasheet says that it can take up to 50 ms to report a result.
>10 retries with 50ms wait each time seems overkill.
That's correct. But, the response time can be up to 500 ms. Also, while deb=
ugging I had put timestamps
which when analyzed, indicated that time may go beyond 50 ms.=20

>And why use usleep_range() here
>but msleep() above ?
I am sorry about that. I have converted usleep_range into msleep (2 places)=
.=20

>This is wrong. It uses the overflow counter as data counter if it
>is !=3D 0. The overflow counter counts the number of overflows, not
>the number of entries in the fifo.
So there is no such thing as 'overflow counter'. The point is if the overfl=
ow counter has
even one word, I use the data count equal to the overflow counter value. Ho=
wever, if it
has zero, then use the number of words in actual FIFO.=20
This logic is just used to count how many values to pop to get the most rec=
ent reading.

> data_count is declared as u8 and will never be < 0.
Data count can never be <0 as only first few bits of the 8 bits are used in=
 the register.=20

I have further pushed v6 for your perusal.

Thanks
Rajat

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Monday, October 24, 2022 4:58 PM
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc: jic23@kernel.org; lars@metafoo.de; linux-kernel@vger.kernel.org; linux-=
iio@vger.kernel.org; jdelvare@suse.com; linux-hwmon@vger.kernel.org; Khande=
lwal, Rajat <rajat.khandelwal@intel.com>
Subject: Re: [PATCH v5] iio: temperature: Add driver support for Maxim MAX3=
0208

On Mon, Oct 24, 2022 at 10:26:58PM +0530, Rajat Khandelwal wrote:
> Maxim MAX30208 is a digital temperature sensor with 0.1=B0C accuracy.
>=20
> Add support for max30208 driver in iio subsystem.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Question was:

> with the open question on whether they consider it acceptable for this dr=
iver
> to be in IIO. Main argument in favour is it's an expensive clinical grade=
 sensor
> so fairly unlikely to be used in classic hardware monitoring circumstance=
s.

Agreed; the sensor doesn't seem to be very useful for traditional hardware
monitoring. The driver better resides in IIO.

I don't understand why readings are discarded. Why trigger multiple
readings just to discard all but the last one ? I thought iio would
be expected to return all values.

Additional comment inline.

> ---
>=20
> v5:
> 1. Fixed comment position in max30208_request
> 2. Use of local u8 variable to build register values
> 3. Using u8 instead of s8 in data_count
> 4. Removed global MAX30208_RES_MILLICELCIUS
> 5. Removed 'comma' on NULL terminators
>=20
> v4: Version comments go below line separator of signed-off-by
>=20
> v3: Release the mutex lock after error gets returned
>=20
> v2:
> 1. Removed TODO
> 2. Removed unnecessary blank spaces
> 3. Corrected MC->MILLICELCIUS
> 4. Comments added wherever required
> 5. dev_err on i2c fails
> 6. Rearranged some flows
> 7. Removed PROCESSED
> 8. int error return on gpio setup
> 9. device_register at the end of probe
> 10. Return on unsuccessful reset
> 11. acpi_match_table and of_match_table added
> 12. Minor quirks
>=20
>  MAINTAINERS                        |   6 +
>  drivers/iio/temperature/Kconfig    |  10 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30208.c | 323 +++++++++++++++++++++++++++++
>  4 files changed, 340 insertions(+)
>  create mode 100644 drivers/iio/temperature/max30208.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1390b8270b2..7f1fd2e31b94 100644
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
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kc=
onfig
> index e8ed849e3b76..ed384f33e0c7 100644
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
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/M=
akefile
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
> diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature=
/max30208.c
> new file mode 100644
> index 000000000000..4f78337c78fe
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,323 @@
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
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock; /* Lock to prevent concurrent reads */
> +};
> +
> +static const struct iio_chan_spec max30208_channels[] =3D {
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCA=
LE),
> +	},
> +};
> +
> +/**
> + * max30208_request() - Request a reading
> + * @data: Struct comprising member elements of the device
> + *
> + * Requests a reading from the device and waits until the conversion is =
ready.
> + */
> +static int max30208_request(struct max30208_data *data)
> +{
> +	/*
> +	 * Sensor can take up to 500 ms to respond so execute a total of
> +	 * 10 retries to give the device sufficient time.
> +	 */
> +	int retries =3D 10;
> +	u8 regval;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SET=
UP);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg temperature setup\n");
> +		return ret;
> +	}
> +
> +	regval =3D ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> +

This is really pointless. The register has only one bit to set.
Just write that bit; reading the register before that is pointless.=20

Also, the code assumes that one of the gpio input registers would be used
to trigger temperature readings. Why trigger another one if this is indeed
the case ? Triggering a temperature reading should only be necessary if
there is no data in the fifo.

> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SE=
TUP, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg temperature setup\n");

Not my call to make, but this driver is really noisy.

> +		return ret;
> +	}
> +
> +	while (retries--) {
> +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg status\n");
> +			goto sleep;
> +		}
> +
> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> +			return 0;
> +
> +		msleep(50);
> +	}

The datasheet says that it can take up to 50 ms to report a result.
10 retries with 50ms wait each time seems overkill.

> +	dev_warn(&data->client->dev, "Temperature conversion failed\n");
> +
> +	return 0;
> +
> +sleep:
> +	usleep_range(50000, 60000);
> +	return 0;

Odd error handling. And why use usleep_range() here
but msleep() above ?

> +}
> +
> +static int max30208_update_temp(struct max30208_data *data)
> +{
> +	u8 data_count;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D max30208_request(data);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n=
");
> +		goto unlock;
> +	} else if (!ret) {
> +		ret =3D i2c_smbus_read_byte_data(data->client,
> +					       MAX30208_FIFO_DATA_CNTR);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +			goto unlock;
> +		}
> +	}
> +
> +	data_count =3D ret;

This is wrong. It uses the overflow counter as data counter if it
is !=3D 0. The overflow counter counts the number of overflows, not
the number of entries in the fifo.

> +
> +	/*
> +	 * Ideally, counter should decrease by 1 each time a word is read from =
FIFO.
> +	 * However, practically, the device behaves erroneously and counter som=
etimes
> +	 * decreases by more than 1. Hence, do not loop the counter until it be=
comes 0
> +	 * rather, use the exact counter value after each FIFO word is read.
> +	 * Return the last reading from FIFO as the most recently triggered one=
.
> +	 */
> +	while (data_count) {
> +		ret =3D i2c_smbus_read_word_swapped(data->client,
> +						  MAX30208_FIFO_DATA);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
> +			goto unlock;
> +		}
> +
> +		data_count =3D i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);
> +		if (data_count < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +			ret =3D data_count;
> +			goto unlock;
> +		}

data_count is declared as u8 and will never be < 0.

> +	}
> +
> +unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
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
> +		*val =3D 5;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30208_gpio_setup(struct max30208_data *data)
> +{
> +	u8 regval;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_GPIO_SETUP);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg GPIO setup\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Setting GPIO1 to trigger temperature conversion
> +	 * when driven low.
> +	 * Setting GPIO0 to trigger interrupt when temperature
> +	 * conversion gets completed.
> +	 */
> +	regval =3D ret | MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
> +	ret =3D i2c_smbus_write_byte_data(data->client,
> +					MAX30208_GPIO_SETUP, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg GPIO setup\n");
> +		return ret;
> +	}
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_INT_ENABLE);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg interrupt enable\n");
> +		return ret;
> +	}
> +
> +	/* Enabling GPIO0 interrupt */
> +	regval =3D ret | MAX30208_INT_ENABLE_TEMP_RDY;
> +	ret =3D i2c_smbus_write_byte_data(data->client,
> +					MAX30208_INT_ENABLE, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg interrupt enable\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info max30208_info =3D {
> +	.read_raw =3D max30208_read,
> +};
> +
> +static int max30208_probe(struct i2c_client *i2c)
> +{
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
> +	/* Reset the device initially */
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> +					MAX30208_SYSTEM_CTRL_RESET);
> +	if (ret) {
> +		dev_err(dev, "Failure in performing reset\n");
> +		return ret;
> +	}
> +
> +	usleep_range(50000, 60000);
> +
> +	ret =3D max30208_gpio_setup(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max30208_id_table[] =3D {
> +	{ "max30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> +
> +static const struct acpi_device_id max30208_acpi_match[] =3D {
> +	{ "MAX30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
> +
> +static const struct of_device_id max30208_of_match[] =3D {
> +	{ .compatible =3D "maxim,max30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max30208_of_match);
> +
> +static struct i2c_driver max30208_driver =3D {
> +	.driver =3D {
> +		.name =3D MAX30208_DRV_NAME,
> +		.of_match_table =3D max30208_of_match,
> +		.acpi_match_table =3D ACPI_PTR(max30208_acpi_match),
> +	},
> +	.probe_new =3D max30208_probe,
> +	.id_table =3D max30208_id_table,
> +};
> +
> +static int __init max30208_init(void)
> +{
> +	return i2c_add_driver(&max30208_driver);
> +}
> +module_init(max30208_init);
> +
> +static void __exit max30208_exit(void)
> +{
> +	i2c_del_driver(&max30208_driver);
> +}
> +module_exit(max30208_exit);
> +
> +MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
> +MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");
> +MODULE_LICENSE("GPL");
