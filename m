Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F505F62D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJFIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJFIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:36:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1210A2A974;
        Thu,  6 Oct 2022 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665045353; x=1696581353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gl7KlIQqjgvdRgFMNX4UWI4kz36/NzcpP1ZHgatexTM=;
  b=IruL8RRGfLw3r+b9e1lpyCpmM4jVeI09xm11CSLng5xBWEj4WTyuTInR
   9pLItX7b1x2wV+2EfWRBjpcYfzYWpVcA6jmWVRugEhGPVDG4Q+DZROS/a
   b7F+C0/aDoMSCFpNuHeXHpLsvzJ7wjL0DN30SWkXrvKbS7nnUppzWaFu4
   2SdfPPHItz5/xj4TkvWMyyfHFzzVO9Bt/H+YJaTiKCoSUPp7yTQczt1Pn
   BGm57SokhftgoFjR53IpMZM8IYJ8JdTlO2QSRFVw59495uTpcCYhWk8cc
   KPOyaCkizlUNkh2W8oxNyo+oGrNyHhlzkASSl6UwztmCxlEhfZMZRYtmZ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="180657608"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2022 01:35:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 6 Oct 2022 01:35:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 6 Oct 2022 01:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WctZvrNwanVY9OanPjIx1LTtooZ3USM4yXD6tUudd1Lzn7+msHL+drBjAsm444lZDDksd4xQ+5+sjikQy/AlrgWnPuaZfcYneakbZBhQgdRANhD9EW/Xov3tHyTMTGIRsk24FxiPE8WcNsazlEnoT4xjqsvjZmxhdIc73zVBTa2myjNySZRVIrh9oZgjjYKRSsFhkXnX25azngGsEM9bhGFsFtgsHJSRvhOnELFjSJg2Fh1k9J9Zw7FOyIwYK+HV7m7srSIIVeU1ho+TXSD1TGkwamN/+S+4hg6muXH0DOWw8YJvFwcGSxdtdIaRlabTWu3FqCEA8vnKaD4A9cIHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl7KlIQqjgvdRgFMNX4UWI4kz36/NzcpP1ZHgatexTM=;
 b=fsAdBB5Hd7qzhVgkmtwPHWEF/XqDGvezEzb+9Spy5jFqhwjL/R8Vw1kbhx3MiO1dekI5Fxapx2RgV8f3LpFwFBz41k7IltS+C8Ew7+TTpi5sqPWd266s8cVPELm9UPf3X3FKhH0w6znmfS/HNEeZoBWSSI9o01h9f+VZ4Tx86f4Hcjetb5a+LTKOmmlrc+FzSXUUl7oQfWuh/KkQgvu8RFugP5qP6Ysv8+9XNfp9xK5gnoIrRch37I15gcKpIuz2/LLotgbe5G0sz3zAvCcbIXzV/NLBG5uxAgDXmDQvdd29baaYkpqMtVKiyPAvaEFndS11OzGuTWIT4iRILL88zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl7KlIQqjgvdRgFMNX4UWI4kz36/NzcpP1ZHgatexTM=;
 b=HuXBsqeQfHePD34LSy6e/WVqQ2JsdA42uG2MHv3vIkoNYh+WrSOHs6uAlfRSIQbP6wcqgkWC2JXQQgqTl7ckcUStS82x/AxE0TenjM9D7zkvXytEBjGi3Bbc/mWuiLAIoV9kM3019Mdn1q5Mw2CipI0JPPn5zgEzxPmEs7r4nb0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 08:35:45 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 08:35:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mazziesaccount@gmail.com>, <matti.vaittinen@fi.rohmeurope.com>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <cosmin.tanislav@analog.com>, <jic23@kernel.org>,
        <Eugen.Hristev@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <bleung@chromium.org>,
        <groeck@chromium.org>, <alexandru.ardelean@analog.com>,
        <nathan@kernel.org>, <miquel.raynal@bootlin.com>,
        <linmq006@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <paul@crapouillou.net>, <mihail.chindris@analog.com>,
        <gwendal@chromium.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Thread-Topic: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Thread-Index: AQHY2V6gn37PaNyD9E2zQvcCPdFV7w==
Date:   Thu, 6 Oct 2022 08:35:45 +0000
Message-ID: <c163203c-d87b-7e71-f582-964a99e37efb@microchip.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
In-Reply-To: <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|MW3PR11MB4650:EE_
x-ms-office365-filtering-correlation-id: 9d7faf1b-9ba8-4228-6b5b-08daa775c33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9P/anMD5I3n8quDzEJ4bBM/d6Pz8ELHjmgck9YpnFPxkmM12IIbxnXvyTXHBoTBmHj5iCsaRQNNrPZUvjkia42n41Gye5n5+4RjKbjWzgjMDe/lZKGrAYUORaBpDP+67uKy3B4JHc8zutJIzpWOTUcYzpQhmFILcfYK5+yAPl2Fe1yFqOLlzkm7DaYkfY5IjHJ4elzSd00PiSYSuiiAa/iDeK42gMiSAIrlpAygwOZxkhsDZTBkWkWW6K03ecmCbWRCTFBJhn48J6A2ca9p3rHjv948cam/xfl7NFJsLHT/ELXM3RhEw0xoogUWgfY8lqXE4XRzutE5bPR5AXu+hMniZVdM7lyxGXpqfDEquWD3Fbn+ndbgJoQR7aOBEp6Wzel1dbJW84IrRh6d5Tx0V8OSwttK51H/W8jAiQOtI2u5HL0O26L3LZcupiF/AW/S17MGrvFjnpCJcJyoIaLSjpFpEcy2juYxFNFbZaEsrbKQRI6NFptu+MumTqDkQ9RVMbRHHyiobo26zCPrbK7PAf1VV5y/WMO3eYIyaKVrOeGQnOCoGkR5wh0IneqURS1h6453q4HzqB8fyAd1OqW4JpoiBUAoVObGm7+6iQ0RqLmEZdfs0fwRMZIOgheQn4KGE5QsQwJv8jOhSBmEJMg1RddmtCfroVr/ZHBZo9PboCBUbzqKmH+MviVzv6rm00WgOlZcROxlbUBir8TOyPzhozeKlajrLGI+1MAOHrHxFnUkZaDjsGOnnYsAglV9a+oZI+nfqwcFTtRbsnLGTthNI0HajckLw1UwG1qRWoLzR6uq/wns+rhGcXvCNQ8AHfA3uCMOAUcd/26O7+1vIrexRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(31686004)(122000001)(36756003)(38100700002)(2616005)(83380400001)(186003)(26005)(38070700005)(6512007)(86362001)(6506007)(31696002)(53546011)(6486002)(478600001)(5660300002)(7416002)(4744005)(2906002)(71200400001)(8676002)(8936002)(41300700001)(91956017)(316002)(110136005)(54906003)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N24zaTAvY2dZTEtVa0EzZ2s4RFlPOWsvMWNmZXVwTmxyQXBxeHJlV2ZvdjBZ?=
 =?utf-8?B?V1ExNGFKRjZnSkpUUzAxZzE1ZTI3L1pybHdIZUdOS2ZhaW9zNWIzbjNmVnBm?=
 =?utf-8?B?KzdkQmhPYmN0RTBUWFBTWTFMVHJiT0hPc1ExcnNiY0NRRWN4Qk9PMUFXd2tl?=
 =?utf-8?B?MlQxbWVPdmxSd3E4cWZKc3U3ME5UVkphUUZmYUd0bnJBTGVWNHlGdllrR2Zw?=
 =?utf-8?B?bC9wV3ZERndzd3NCbDNLNE84ZEhtREdMN2ZRcXI0NTlCN3BZZG9rY1NXNXk5?=
 =?utf-8?B?NE5OWElmcGdWTmovRC9hTzVxWWdaQlpHb3Q1YUY1Y0EwUC9pOU10SEpqTW5C?=
 =?utf-8?B?THluTTI5MnZNN0V2cWN5VWtMeUYrVWNkbFd0MzFoMSs4cUR3N2xWUTRqN25z?=
 =?utf-8?B?MmZqWHI0aEhUbHRFK2FrMUlESjZQdW1kUWhNTEhBSHpHWUc4elNid0d2RndO?=
 =?utf-8?B?YTQxdEhhNFhqTnlVTVNubExaNS96emJxT1pZSDg0Z3RjbStvSHcwZElnNGt6?=
 =?utf-8?B?dDYzSTdJbTZ0UUVFRFhoZFFMSEMxcEJwbTVCVnNQWHN4MjRRY2JiMnQxZWR6?=
 =?utf-8?B?TVdxamdLM2Z4VTFieU9jd2FpY2NQeXF6MjF6bHF5TTFycnlWVURvNjBlMDhX?=
 =?utf-8?B?ZjB1eUNZcmU0cXNPSDcvSGtkNlBHZ3BGMFc0QllOTUpLbDduaFJnVFpTQlI1?=
 =?utf-8?B?akpHdkRMREo3cGF0cFY0R3RvUTJsdmJFYVBRSFJKaStFMG9yS1dKVW1ONW9j?=
 =?utf-8?B?Y2JhWkFUV0t0WFltNUc4OWs5RTZkMVlFbjZuSlAvS3l1ZlBNMWZwbS9PdUF1?=
 =?utf-8?B?ZWszVTZLbUJPSU51aWlzdkhSYjdFYlhnU2JBYVN0dlVwSUwyajVkMU9TRDh0?=
 =?utf-8?B?ZVI2RnUyMWZSVkdxUUVVWTBacE5kZFVYMWFnVTFNTUtXeFQ2RXlmMVdpSWJk?=
 =?utf-8?B?WmE0bDd4ckJQVnBBK0lWQVlYbW43bDFlRkdDVll5YkpueFRQYms2MXdxcFFu?=
 =?utf-8?B?a3BwOWFiVnV3dGdTQmFxb2xQNlY0c3ZlUTE2OGoxcHNEb2NCUUVnalJFelp5?=
 =?utf-8?B?NjRqd3BrYXRDWGJFWnZUcmN1L05hYUFQeHA5ZksrYzZSa3Fyd0VVcUFYT3pP?=
 =?utf-8?B?UjFydFJUTFVqVXNqWkYyT1gyN2tNYkpCQ0xQS241djdRMytHOW5QUHNhOU9k?=
 =?utf-8?B?U25DZ09RcEJjVHNrQ1ZJa2NQNTNwazBOU2V5eHJDZUtzUVBaS2lMSlFWSmEy?=
 =?utf-8?B?QWFFdnJkTEQ3TDJQckxmRWwwYWpvbWs2QW92SDlJRHpvLzNwalRQTHR2RUxR?=
 =?utf-8?B?RHYvNnBDYTlZR0lHL3MrYlBkazlnVU1vTDdJb040aUV4MWtKd1hlMHd1QnlY?=
 =?utf-8?B?NkQwa3FLZ3hZTmxMZ3hNUjU4VHc1SVVUOVpmeGwyWEY3elF2ZVc5OWR4bHdl?=
 =?utf-8?B?cFVkSXhHYnhzYVpIY1hWRlBDV1k1dWVRZTVmUmxoZTVZQUxmN0llc2hEYzQr?=
 =?utf-8?B?djUvUk1OdkJUdEIrLy9pMlZKcWZVSDlURmZYSmRISSttdjR2V2RrdThvWUhv?=
 =?utf-8?B?WFZkWHBhcml6b1lMLzlla05rQWQ3a2YxVzJJdFF3dUFQckxJanduVTZlSXU5?=
 =?utf-8?B?cjZVQTREdGhoNWg5U2lCWnh2MTRaQXdEWlZTU1FtYzFrTDlSMHFTMXJWTTY1?=
 =?utf-8?B?TnpvL2tDK3pnRE1WcFVkTEVOeGRuRWhiSE5IZGpHa1N3N280b3N4WlpBbWQz?=
 =?utf-8?B?aGpQTUd1QzNubU5NNjRRWmVvVlhwWlV1UDc4VmRHRk91MGZMd2ROYlpOMHhx?=
 =?utf-8?B?ZVNrKzRNVGk1WUhyZVZubHRjOUpTc0xUMGIxOVl2enh5QnA1cDZqaDNsaUQ4?=
 =?utf-8?B?anNkYi9QQlJCdWN2WGMrVzJlRWFkVkxkdUNFQzVZbnUyTmNJRlVDVnNmSVQ0?=
 =?utf-8?B?SjhOUTNHZHVzOFIxNGFYSVZQQjZTRTdrNExkdjdnOEgrT2RicitmTTZ6MjhL?=
 =?utf-8?B?MnhoL05RTXVCYnZ3RnloTkx1SThIWkYwOUg4bUhreHhWbVRheFhlcit3SkN0?=
 =?utf-8?B?TXBuYndYd2ZhNDlheFRHVGc4a01RVTRBL1RFUTlBYzNiR3NiZk0vNlFOQ0VI?=
 =?utf-8?B?R2M5eWhscWw0MmpqaVdjakV6RXdYVUZFK0pSME5BTkwvekpYTzdHaDcxeWxi?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E780A7E69E95A341985A5C825B59DE6A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7faf1b-9ba8-4228-6b5b-08daa775c33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:35:45.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtGqD3QP+40mAKveNjXbiww3KUd1RwmHvDnjJXfMA4cvteB4AaethAGUZK4Vilt7o4IOL9p2A5eZkceDfXJKLi3nydEDQMmurhU4Wk0GUy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMTAuMjAyMiAxMToxMywgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiBUaGUgaWlvX3Ry
aWdnZXJlZF9idWZmZXJfc2V0dXBfZXh0KCkgYW5kIHRoZQ0KPiBkZXZtX2lpb19rZmlmb19idWZm
ZXJfc2V0dXBfZXh0KCkgd2VyZSBjaGFuZ2VkIGJ5DQo+IGNvbW1pdCAxNTA5N2M3YTFhZGMgKCJp
aW86IGJ1ZmZlcjogd3JhcCBhbGwgYnVmZmVyIGF0dHJpYnV0ZXMgaW50byBpaW9fZGV2X2F0dHIi
KQ0KPiB0byBzaWxlbnRseSBleHBlY3QgdGhhdCBhbGwgYXR0cmlidXRlcyBnaXZlbiBpbiBidWZm
ZXJfYXR0cnMgYXJyYXkgYXJlDQo+IGRldmljZS1hdHRyaWJ1dGVzLiBUaGlzIGV4cGVjdGF0aW9u
IHdhcyBub3QgZm9yY2VkIGJ5IHRoZSBBUEkgLSBhbmQgc29tZQ0KPiBkcml2ZXJzIGRpZCByZWdp
c3RlciBhdHRyaWJ1dGVzIGNyZWF0ZWQgYnkgSUlPX0NPTlNUX0FUVFIoKS4NCj4gDQo+IFdoZW4g
dXNpbmcgSUlPX0NPTlNUX0FUVFJzIHRoZSBhZGRlZCBhdHRyaWJ1dGUgIndyYXBwaW5nIiBkb2Vz
IG5vdCBjb3B5DQo+IHRoZSBwb2ludGVyIHRvIHN0b3JlZCBzdHJpbmcgY29uc3RhbnQgYW5kIHdo
ZW4gdGhlIHN5c2ZzIGZpbGUgaXMgcmVhZCB0aGUNCj4ga2VybmVsIHdpbGwgYWNjZXNzIHRvIGlu
dmFsaWQgbG9jYXRpb24uDQo+IA0KPiBDaGFuZ2UgdGhlIGZ1bmN0aW9uIHNpZ25hdHVyZXMgdG8g
ZXhwZWN0IGFuIGFycmF5IG9mIGlpb19kZXZfYXR0cnMgdG8NCj4gYXZvaWQgc2ltaWxhciBlcnJv
cnMgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8
bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KDQpUZXN0ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpvbiBTQU1BNUQyDQoNCg0K
