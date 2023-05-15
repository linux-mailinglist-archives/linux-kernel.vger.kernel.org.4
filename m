Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6BA7030E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbjEOPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbjEOPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:03:20 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DC26AD;
        Mon, 15 May 2023 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684162982; x=1715698982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zCIG9Xc0UZR4WD3nRoKrT0kB9OVUuF89lobPt6MnzwE=;
  b=MK1CrnWtKALIuk93V/DcQnNgxG5X0FSjFhz2+qlvHzVn2goDIQ5Czcxs
   mKt3jwzvwxLupGnkY3bBz6r9RjPC2Z9/xjgLvPyEdd3cp9rrCv09aO05F
   NdouxQUbPJO/TZBbTBfFne/Sn++MyKEBwadvd5ZmmeAlvMtvyYIbsX9OS
   SZF8IJ4B3WLXtw296c2tF1PBg1XJMFAY5LqoNAnG2bQ22UXtilS0Pg2zV
   TtXP4ngsf9v60Vih7cXTI1jozWa6lCQcIDjv/NLJtK6b872uDfeF12VKY
   0i88Cj0Gzaqywy6MkCcQeK/y9xNh6mtoR/kfsDYFKMtz2eTPMAQCR17np
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,277,1677513600"; 
   d="scan'208";a="229012254"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2023 23:03:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLwkUOam26JcpY9zZBJmp/Lhm+0ARq0LMIXfLr7B4a+DmPttFEx3D5uTlg5kvkIqZ+kHVUGQ9NpoCvg0dmlVeP15u0MM3uKpZ/D+SZZyOvv9xR7C+GOvbu64bnv0oOa2tIJP2FiKFPJm5O2XuQNq1L4Jy1LFx/VsK1sQd2Iokn124nh1gdCECGpF014Yg8FZFZJrZEWrXqUTJVbvILZXw3Qpm/S5iHD2I59CLB2BhE5J6hsWGAk00lFmhfDn48P/nX3X7vvGKHELKAmuvkkBYWtwEfUHOFy6DdHQhJbuHCPQ3Hc/GMJ0R0x58GzHKDnaJXM+L67Q10uvoP4AEJFwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCIG9Xc0UZR4WD3nRoKrT0kB9OVUuF89lobPt6MnzwE=;
 b=IN1J/X1on3zxeXrNKijR8riePju/l/5qJ5xQTxQcClIZgA0yiSIuntQe8aZovUqzVU7dLo00YR9HpCMoMETNpw/us4b4VRfIlg61LmkqlicVr39CzUyiiGOl/qSYrdvF4sWRRrToB326Epj0TQQ5tAdO7zx5L0l90qzO+DEOdiUrxhD76ccY+ipddoSfW6uQSYrTzbooXJ1OnPAlK+tqxm6Vh0te/QY4c/utJzT+26x0nxs7U/EytGwqKkJPhiZv+Tkm+rYFOGG8bLbneMKojjPNGnqOANhwvM6QiqdZypqoLJyI01hPjfONe/SmQ0ip8XizomCVCm/XihKXhMSfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCIG9Xc0UZR4WD3nRoKrT0kB9OVUuF89lobPt6MnzwE=;
 b=r+yN365KGHIMjTqwTStFCYb6JN6/WDNDjE5f5YcZrQZUKD9lFq5ThCsDNyqGrdClK/RuToy6jh7WdgAXHX3Bc6D3criKey7232R6fp2plkrwfpADpuLMZ+JipXNdI/nIRI1fdBmuhAZn+cp6/T4zQESLItV8rGs4BwDfhnqueZo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6641.namprd04.prod.outlook.com (2603:10b6:a03:22b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 15:02:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:02:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
Thread-Topic: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
Thread-Index: AdlntYltCGNgWPv+Tc2Z1o0i39Q1Twff3iIAAAIaOpA=
Date:   Mon, 15 May 2023 15:02:58 +0000
Message-ID: <DM6PR04MB657545C0B7FC82F68CB87D5AFC789@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <043d49e37e254eb8aa8a2c5fc56a028b@hyperstone.com>
 <CAPDyKFp5zi=KEgq7P4E7y5u7owM+C2991sBs+8QVGGCN8C+89A@mail.gmail.com>
In-Reply-To: <CAPDyKFp5zi=KEgq7P4E7y5u7owM+C2991sBs+8QVGGCN8C+89A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6641:EE_
x-ms-office365-filtering-correlation-id: a17f43eb-caf7-40ce-27c1-08db555578cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypaJ1YkIq2H3KBmC8B4HC1sNBTaLnsCl90G/+n63p3Ke+4V4Curg6m+bDhz5XUHSywL33z5VbaWu9SL27WfBeY660CW3D/QEnvzOpnO4kEIu8UkF56Hvzsy38EvgRHCmi5I4zONLRNYljJkLtmf1Isbi+4NufF5tuPyc6XS00S1zx6fI71UufmrfMAYrFCxOrsLOgZrO8RQYFcF35b9NmzyeTzP89ComcdB1dhbGRoFfECn2zmOvMiTtrN5S0CGNriIsSK6/VlR+2RED47M0oLZoTyJYhrTo1Uyhum+pK7MkdaOCpQjanRI6VkK8vI3c82QGjhOHBtG/Q0htiNhqXO3yHmyaWcbkoousuBfNr5gEtvLHNgNAgI7pJVcuLgCs8mUetGdP7gF7OHsMRKVegn19ulQ1f0eATzcXMX9gN3L+Zb5jH7MbZLXRQkNWhQANrO292uA8XVtzwcL8CPspYUUOG3ETLlXTHIyuEZANukpCrw+Aj9lJ4lXMudq+Apn+fi33UBymCC25OShCoUg1q8GrKBQg23LnMBO7OEqSWUaxmkF0ZhVLXtLkbA9a5yhAMBUwP34DyOKpAcwz29eA0MpxB3e5/raf5kWDhoQeSymgyvfj4VLtMZ45Y2ti7u90
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(33656002)(86362001)(54906003)(110136005)(316002)(64756008)(66946007)(66476007)(4326008)(66446008)(66556008)(478600001)(76116006)(7696005)(4744005)(55016003)(5660300002)(52536014)(8676002)(8936002)(2906002)(38070700005)(38100700002)(82960400001)(122000001)(41300700001)(186003)(26005)(6506007)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bms0eXhXdERVVjRDN3REb3ZRSzdLdFRQaCsvNG0vVEd2UTZQRlpCMnJYanBW?=
 =?utf-8?B?dCtFcFV1ZkpIanFJT2I0Ui9WL211c04xWDdvTGdxMkFOL1JVM2hmOGRvRGdl?=
 =?utf-8?B?R1lvNnByZ3RPUEJGU0d6dUhQVjI5OTYybGlXVFNxMFJHSytjZVN2Yjhsamha?=
 =?utf-8?B?dGR4LzJlaHMrYmdFemVOWGZJeHlSNi95TWJmY04vWWt1aGRHQ0xFMGdwMk1U?=
 =?utf-8?B?ai9aMWFPSEJnZXpSZzNvMG42OE1YcmVsQjdXMC9IQnNjb1RxR3dnOVNhN2Mx?=
 =?utf-8?B?WHM5aVk1R0VTejRCYW9hU0V2N0FoUkhKcFNkdE5CeUFwT0I5MUxnSUowN0ll?=
 =?utf-8?B?OU1LZmpDSGFWM0hnN0ZkSFFQOTNtTFM1UWgvcE0xTGlHV3dJR0tQdWpFRmUr?=
 =?utf-8?B?U0lFZXZmMk9CR0cvMlRuMEQxNnFvODhJYTlSRGhuaUIrZ2dKWWJyRCtZbmpw?=
 =?utf-8?B?dzlwdFkwYW1rTnJZL0pBMFV1U0NxbVhuUDRNei9sR29TQTMwWDhVZ09Hb1VR?=
 =?utf-8?B?M1lKbkRqbEl6bjE2RWpHVGIzK25yL1VpdHpmcmlDL2IxYXFuVkVYNWhNd0ZK?=
 =?utf-8?B?bVk5MC9BOWJsdC9vME1lNjJPRGtUV3dUcFc3dG9sV0wzWjZzWElvOVUzRFZ1?=
 =?utf-8?B?TFdlL3FpZjN5QlFvbWtHK2M3bXJ4dmZPaDBtam4xam1oMmdaM29UU0pZVXU2?=
 =?utf-8?B?MW00QmU3MjVCdUQ4ZGpvcmVnaTY3b3Y3ZHNleE1nZjlqM1lLaXNIQ28wNWlM?=
 =?utf-8?B?dTFraWlHeWhieXBpRmNkT04rZ09majRDTFI2dnl5WG5QWXlnOXk2Rkt2d056?=
 =?utf-8?B?YjJxcDhyZGRQNUJFWXU4SUt5cC95a2pobFBrZmgwRlNpRk1nSjJBWFBtcUdS?=
 =?utf-8?B?aXZIbVBsTGVOdVpTMnozYjFCM0tVVlZxNzBDcThielhsNlNTbGF0d040VTlr?=
 =?utf-8?B?WHV3VnRQRjY1VlpSQlhPS0gyT2tXdUlvVTlTaGJqL0x2RC9FWDFTQzc2N1dq?=
 =?utf-8?B?dmZhd2JDWitabkNjdm5XR3FYODd2RGE3dzA0aXViZjhUYU5GTlF4VjU3bG51?=
 =?utf-8?B?M0ExaGFOeUVUUWQ5SjBjbHcrSWhJd2hKdG8zREVVMUhqWDFUQWxiSzhSZkFW?=
 =?utf-8?B?R1pFYjZzVzk5TFA1bkw3K3diaXlxeS9tVFAzWG1XY1NXRGxLMnpNYkZCa2pS?=
 =?utf-8?B?RFRtUUQrZDY1WjJUVjFxeWhMQ0lOd3prRWxQUEs4UStDYWo2Zkt1LzFMV0FQ?=
 =?utf-8?B?em9pL3ZzQ2p1clNxRnFxcDk3NFRWNGlSbE5sNG9sKy9WWnpRekFhMkEzZTBw?=
 =?utf-8?B?VEtDUWorRVNOakx0OUwrbnJBRXMveENCVXVIenlVSWI0Q0NXU2RTUWM5U0Rs?=
 =?utf-8?B?OFc3ZFkxSnpLOEVqWUxKZ2FremlaR1RzQlR1cWMvK3Q4TDFIcGIwNTJHRjlO?=
 =?utf-8?B?RXBCTE52eHI2MncwREdCYXZSSkRKV082K1VPYjNNSXJEbVJOalE5eVNYemlD?=
 =?utf-8?B?bytoMDBpMysxRGRnQ1NSZHhKYnFPZ1p2RWd3ci8ySyt0MEhWdkg0VFpBY29o?=
 =?utf-8?B?dkRwM1FkQ0FrTlY0NEpXTHBXNDhRZGo4VTJ2RVV3Qzd3bHlHZ29WMGNzVkxR?=
 =?utf-8?B?dzJQTk9QQ0J1RWtnNG1wVG5oZFFORk5IeFNlK3lIL21ZQ0d5T1dTRGtnRWhV?=
 =?utf-8?B?QUZKYTllU0xSZ215b29yWUdmY2FRQS8yUm5Jc1AxUFV3TTFiOHNoSU9ocSt6?=
 =?utf-8?B?dTVVdGF2QmNLR0c0ZHdOeHhCV1orMWIwZGpoR3pMZlhnU1M0VzZMazZJUERW?=
 =?utf-8?B?UlJNYVl4Qy9PZHFLeWE2U1A1UVhoYVVUa05tYlBTVDhFeHZJQ1ZGUDNtWldi?=
 =?utf-8?B?d2pJSWVmbTJvc09xK0k2TWlPMmg5VFlWMHZtSXhtMVh2aVBxMGNnNUlmMEtC?=
 =?utf-8?B?Y3AzdnI4U0dDaGc2cXZjTzM2RUFIcWdGMXZ4MFBxL0FGNU8xT2UzTUxndFNF?=
 =?utf-8?B?OUJUKzFhU21XcHNUL1NWRnY5VjhQRU4rTnZQbHhzeTUrQUZoZ3h2Q1V0RnJY?=
 =?utf-8?B?dTlta2JLeGZiR3psa0ZVU1gyTzF3UFIxckswcEZiWTl3SUJiOWpJV0UrVlVD?=
 =?utf-8?Q?DGBOSPVLrxpA5i+ubNYjSHHZc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1WlNmLtrjEJOmHwSjrY/qjPr9aoeI0sFpcSWfCcmRXHSpXQaJMeWB90yVABJpdF9F77pZpkm1wyrC0tELfo2t1VlMeaUSdvLCwLxzvVRQ4FqKE/LbOWfmc0/txlTnL1wdajO7IWjCext4KLFuquWQqlBruLtIlojWy6Qe6hG2hsM0WzvRQg0WtoJAjtHSAS4pMaCm0Ks6RpmZ6W3aUBI60dcvFpx4HefCX5NGoIF7UYNIPZoifUdbWGnk1qYRnrh+sppKU+nDIubY8Ke9SedULpqK0Vsf09AqCWOYukSmgQ6epj8pQ4fKVh5ZQgUuA0OHPlk3alsAts+LnHKLdBE0EwcLnUd2mO/i2LV8rhPbsQUadlpAHJJly/D1JEYElfX+OR7QgD7GD7Kz5jihG4KHc8iC/gAmJKPhNewnTE/A6R/OfYRdHm7s+m7+CvOYfNzCgjIgHHgXj+njNqZwFrZU2Fb6W8zaqrZnlSygDGqe3M4TvTong7gFZvnXshkwA0P+ZFryRLBvRHPzeS+QfAPr7GnGEej243zKRX/LedJyIC1CZPKrmulkmjkk7GuoqcNfGUUclJyTqGnA5rO1Neyp0W0o28rhhdOXj4rEvqnLDJZwsrzvw0Vb2CJZ0L6icD9b/H+oPt59Ijr3dUd/hxIZ6idyXs/oX6ajOQGwuRPy6IRGDCUs/QCROj5x8d5cuDxGLCyzd1YOJxoWj44tuBoRhANR72ewg1pIyijgcs/aIzeGNUEPpmOLApAuQL7XRhzdTCnAEuES2jcIbWqlKvgZ+cuefR+m1bGGjClesoPtPmV7tCkXRPR4NvAmcWfOveHfNLGwzCv71qLi5WXh8KiUhSwzX0fNfwT4lmLnCQTqfJFWSE3SLLTkN38mmH2dPAg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17f43eb-caf7-40ce-27c1-08db555578cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:02:59.0012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do27yFK90ixy1UkSYXAo+wNeTs4JzwCeLdfIuuLeXzfT7rRm8hH15bkkSKi0bb+ES6zYJENytsaSmxOYfcpeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6641
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBlbHNlIGlmIChpZGF0YS0+aWMud3JpdGVfZmxh
ZyAmIE1NQ19BR0dSRUdBVEVfUFJPR19FUlJPUlMpIHsNCj4gPiArICAgICAgICAgICAgICAgdW5z
aWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbXNlY3NfdG9famlmZmllcyhidXN5X3RpbWVvdXRfbXMpOw0KPiA+ICsgICAgICAgICAgICAg
ICBib29sIGRvbmUgPSBmYWxzZTsNCj4gPiArICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBk
ZWxheV9tcyA9IDE7DQo+ID4gKyAgICAgICAgICAgICAgIHUzMiBzdGF0dXM7DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICBkbyB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZG9uZSA9
IHRpbWVfYWZ0ZXIoamlmZmllcywgdGltZW91dCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbXNsZWVwKGRlbGF5X21zKyspOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVyciA9
IF9fbW1jX3NlbmRfc3RhdHVzKGNhcmQsICZzdGF0dXMsIDEpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChlcnIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlkYXRhLT5pYy5yZXNwb25z
ZVsxXSB8PSBzdGF0dXM7DQo+ID4gKyAgICAgICAgICAgICAgIH0gd2hpbGUgKFIxX0NVUlJFTlRf
U1RBVEUoc3RhdHVzKSAhPSBSMV9TVEFURV9UUkFOICYmDQo+ICFkb25lKTsNCj4gPiArICAgICAg
ICAgICAgICAgaWYgKGRvbmUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
VElNRURPVVQ7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBXZSBoYXZlIG1vdmVkIGF3YXkgZnJvbSBv
cGVuLWNvZGluZyBwb2xsaW5nIGxvb3BzLiBMZXQncyBub3QgaW50cm9kdWNlIGENCj4gbmV3IG9u
ZS4gSW4gZmFjdCwgaXQgbG9va3MgYSBiaXQgbGlrZSB3ZSBjb3VsZCByZS11c2UgdGhlDQo+IG1t
Y19ibGtfYnVzeV9jYigpIGZvciB0aGlzLCBhcyBpdCBzZWVtcyB0byBiZSBjb2xsZWN0aW5nIHRo
ZSBlcnJvciBjb2RlcyB0b28uDQo+IA0KPiBJbiBhbnkgY2FzZSwgbGV0J3MgYXQgbGVhc3QgbWFr
ZSB1c2Ugb2YgX19tbWNfcG9sbF9mb3JfYnVzeSgpIHRvIGF2b2lkIHRoZQ0KPiBvcGVuLWNvZGlu
Zy4NCk9yIG1heWJlIHVzZSByZWFkX3BvbGxfdGltZW91dCgpPw0KDQpUaGFua3MsDQpBdnJpDQo=
