Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685645F62BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJFId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJFIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:33:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B292F6B;
        Thu,  6 Oct 2022 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665045203; x=1696581203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EGvIpnxSE4/YSbYynQYsKtp2/lZTuFXBJmtuDhEF2V0=;
  b=USEQxhjxof1SFnjNTZPtSKuLTHAu1zOt+PC/P3dyhowmhJgGq1pSgSg7
   OzZuA6SL9b3VjLx+rk1G1fXCBEppeZg4UMQyiMCYBsIDUBnAJiiAeMXIO
   CMlfHGYwcp1VIA2yoJ2d7QQoJTJioO0uKYVlhAzj8E9hUuNMqLlQcnFdn
   rKAVZNm9oq21WEMqvz81VZK3FjsaMhSwp+jMHk7MgCLyWoSY2grlHGvkd
   ZCfv09xzjZGeGW+weqFh3A4H05OFpTIlNk9FhWC+YywEEaYfbK5Q+gq4a
   7HqRpg5711pgkfFfAKgKTEPwE+bqweyg+tJAyCUXt/EGVY9lCZv8cH/X9
   A==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="183533551"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2022 01:33:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 6 Oct 2022 01:33:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 6 Oct 2022 01:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRiBJ3C79pqUlQYVLPT7EG/0WbZ2T3iLf6crA/zpXwCL4KF7ZCtIRQAmXA71ASguzy8xE2JivMbunHzpYO8Tm3f1+z7Rj90Z+4RukRpvB0Bd72tQRU5W73HP+rpl4MDZXzljFdnwluX6pA51qRkG2EHMKzhHixN9c5UBHAvyimpSvU5MzOesSmhIiQpqdvTTkb7hd3tHB1uZNLz88O2dkG+E45NLf8fzhuhGoFunYP/2JpYzEJ9GgU6gdSOgw6eVKLXd+m72VVuOBHZSLK6tLNxzuLVO/ztZmq32vHsjQAqVryH1T2ck8gRKd/3/AVEM85oGk13Ie4mlEddHWNaaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGvIpnxSE4/YSbYynQYsKtp2/lZTuFXBJmtuDhEF2V0=;
 b=aaXSC9qhaB3Vi1kUXXTHi4KegSOVfH+VgcHeuOguLOX9U+VVwehxI/Ka8E6g4fV0JKpRuAnuXk9CrmNLT3kiv7SnQKo09t2hDlTXBhE/8IP0SFVSwapGRthuYDYKuD75wjZqs8szL6xZMvgaECQWkArrIbrkEFc0tanFdU80dGSEzwAo2+E3f1ppG2jDTxtabNNAMdp/bVVY5tH27a94uF74Sx4gBEPEBvkE3xWs1gXRcToJpbUweI1PAFImHqpavr+F2PnPLNViAhQ5lWAqi/FvgeHWgf41JgXgE1WxzUuxW4WCKIs0BBnUwssqEa35uK0D5mVvNDlqZs5KloPw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGvIpnxSE4/YSbYynQYsKtp2/lZTuFXBJmtuDhEF2V0=;
 b=vILpTl5W1o1YFnc9K+eMte3OUevWE67CLzPo8NcRFuC3/UFJKu77Klp4gVBN95e6VW4b18Q8XDeTL0m17VHJ2H40Sp/bj26l3eLqcebN4ll16g1sxs5981Mr4iOBUPfYp9IVQQlbOh7wAYMqoArZP7Qm7Khwe1NY2f3ocpiNjvg=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 08:33:20 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 08:33:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Matti.Vaittinen@fi.rohmeurope.com>,
        <alexandru.ardelean@analog.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <stefan.popa@analog.com>,
        <Jonathan.Cameron@huawei.com>, <michael.hennerich@analog.com>,
        <lars@metafoo.de>, <miquel.raynal@bootlin.com>,
        <Eugen.Hristev@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Thread-Topic: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Thread-Index: AQHY2V5JisJrGgRG1kSKurIrC2v8mA==
Date:   Thu, 6 Oct 2022 08:33:19 +0000
Message-ID: <59f59c2a-3842-e87f-d980-0e97abca34aa@microchip.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-15-alexandru.ardelean@analog.com>
 <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
 <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com>
In-Reply-To: <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com>
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
x-ms-office365-filtering-correlation-id: 17ee29c1-0a04-4c9f-05b0-08daa7756c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5ddErG8EdhUDNsPoOcwX9RJagycQUIjZmMX1T6pKJhBAjA4O2utyEYsUGcNMV0Ti/9h5dDV/lYA+NpD9MZH5wY/tIog9r6788kvWl7rpkq/NlQMBgQ15VsFJVY5RADy0WrBkpKImyKSybnV31NFZUa1pqRdCvWRK39WpAvQywWGvjZ2g1UCXWyJgoBG88VUlPtmwAxVhVw5Ds1pIRAZzkBFf4IwjzXn6jSg4bVUHxNsVIDRXUVQztWT7A27rHLuKirl1dlQh+vNHlcvfwGuksegTEr5405P3ucF0K0ZG8d1udpr0lA2gqWV33zRzT2YGQEH+T78dO+nV9gXMFwrTZDTZmQswdCrDgAzE6CHq1FgwR71c76FbFWJrR6/pB5yq/LCBdgWYN8LI0pM7etH4KhD7lViGXts9pTMAU/iER/a5DE/+S+mapjjikTOIGCKkLpIQ++n+88SuR/uv1tTYMv0eOG4mPdLMj4mhdyuYJ5UhaBXzo0339KieJ8gU5GrdhgT/kIAXRpWtZrrdRmuwE7xU33tPX59r5kQeKKhRio1Zv7sqYahKOjIs4S3YNtN1jZJjHkV1ozlvTugHDS+IRtyDNcitHcmP46I5jvhO8h+yW4+yyO6uQPlyRrEgMZeStcMbS/S+eKHOAxOV55vgKoP61EFcxBdI6Q99bX56Dal7TOroZXaPiGyQv54eRUO0iBEgre3c7b4klEMK+JKsreTTMQIoU6Dh/ZRp85+kcUp40INz6/ACxVEPAugTWUZw+0n1R4vDg9oXwXiyaN/tABl01Q4VmBwPwarShvrIQqb0t+UMmN7XkvZG44ZwSUk8ddY0GLcnlE8D/Rnfq+F6/FldZXxG0wtV30s8UWRazc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(31686004)(122000001)(36756003)(38100700002)(2616005)(83380400001)(186003)(26005)(38070700005)(6512007)(86362001)(6506007)(31696002)(53546011)(966005)(6486002)(478600001)(5660300002)(7416002)(2906002)(71200400001)(8676002)(8936002)(41300700001)(91956017)(316002)(110136005)(54906003)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nnd6TzJoendxVzltdFhaNW9YWGNpUUJ5L2hlSWE4bDBBbTFxV1N4NVpIQjJX?=
 =?utf-8?B?UWQ3U1NUaFZlOFFRMmNUK0gzWHE1bjFtLzVQZi9jN0craFl3NW1BT2puOHdG?=
 =?utf-8?B?OGhVcXBvV0JVL2xtMWxjMFBRSXJ4aU1PUnIzS0tyQVRlb0ljRTVTVkV3Z3FH?=
 =?utf-8?B?eXJ1VFpiVTBGTnhHeUF6T0drOE9UQWF1ZFVLa0RUbHE4dzlVVFBOMUFTN2Vw?=
 =?utf-8?B?K01LSnA3cWtIZnJNYXZZTVJnNmRzdU1lUmR1emJSNm54YjNLbVV4ck00S0pp?=
 =?utf-8?B?dUh3YjBjRlhKMy8vR29lMDJjZFl3RzRGZlI1eFdGZDhuVSt3VU9WdjZBUlJQ?=
 =?utf-8?B?dytpNThPOXdIMUlFOUVDdUtxYWlxMUowMGludDhGMmgxRmxuSTdhdncyNmJy?=
 =?utf-8?B?cE14blMyUFh3L1huR1c4VFZhaUk4V1BFQnk1RjAvREFWaGhuQ1gyZExuU1pm?=
 =?utf-8?B?TFpGTnVCOVZRSVhJZi9OVjQvcGdXSzlFZlJ6L2NMOVd1WW1iR1o5clFiZmhu?=
 =?utf-8?B?Y1dBS3hvb1FodmxFMmFCOWJjREN4UUZVK0RZU0pFZFRZUFZCbDMvaWZYM0Ir?=
 =?utf-8?B?Zmx6QUxGZEdrZFJ0MHZrTTdJaXZDenJJK29DNlE0aFI0OHVFdXdibFp4Zm0x?=
 =?utf-8?B?cjZ1MEF0cEsxTEwzK0VxemdlMlBLQncrWFJjbmtYbEh3b2FMSllTQVJwa08r?=
 =?utf-8?B?amdqM3dVd25HQUlJbmgyY2xLeERWYkJjSDBtZmNDWnBhTVB5MGQ0WG83VjFo?=
 =?utf-8?B?NEI0eDIvRGRVdEJoNk41QzVKVlZaaElxK0x0MTR5MGsyUkRnd0hndXhZRCts?=
 =?utf-8?B?aG5hNERLN3ZHUU84ZVpWdndYRWJmcUdkdk5Nc21Wa3ZiVkxveGRDVWx6VzFv?=
 =?utf-8?B?b1hzYlRQS2VjK1BlTkp6dytaY2JENFdhYm4wSEFGdUF1RUdram9tVHlzYWx5?=
 =?utf-8?B?Tkh5UkZUTmQ3SHgxcGZiUVczck5xMUpTQlBYYUhBSXRXcCtOSXp1VFdkejAv?=
 =?utf-8?B?Ti81cmFGWC9ZQ05iWDBxWEI4bkwxNi9XWWREc0dFVlRRVS9kUklsaUZidEZ1?=
 =?utf-8?B?QlNQVmZUSy93SFhJcGNEVEN2WHdpWkZhdGNrVUdpM1JodFNDK0RjVmk1bUxR?=
 =?utf-8?B?UFdzS21LTlBnOHB5SlV3WldscFNOR2wvWU1CZnEvcFlQNXhEYWtUa0VNcGN4?=
 =?utf-8?B?MnpxdnlFZCtKVStTUWdYT0hUaFRjUDgrR1FYbFE0RHhZWEtnYXhYN1VsVkND?=
 =?utf-8?B?WVJoTjNDNXAyZkxxd01BR2Fsd2EyamRYNVZ4VXJwV3VlNGZwbkczTkxmMURt?=
 =?utf-8?B?S2YybERhUC9jNUVXb3lsSHJzS0FDS1BhRmdsOUhlSWZ4Q2VaRWQwRkNLR09H?=
 =?utf-8?B?SnBoWTN6ZTcrNDJ6TnR2VzdKeENZVTRJNFp5c21MdERTeDlmbnJBZHZURGZK?=
 =?utf-8?B?VHdNdVZCdmtFOTZLWXd0RGo3c2x4NTlVRERqdmVmWDVaTlhGZHZGempuWTdF?=
 =?utf-8?B?eEZZSXN5WHdkeWxWTUMwY3g3YStJZUJEYmx3Lzc5ZHgrL2p3WTlRNm9xN0Vz?=
 =?utf-8?B?ejlGYm1FVEVSUmpwdUdHS3FpazNrZWRIVzUxbEszVi9CejdYdDAxNDZhcEdu?=
 =?utf-8?B?ejNFNUpjcDdnYXhiWlZLRVUyOTVQaWJvUmhDSjRGQ0N4UXE2TE1QM1ZHYzNk?=
 =?utf-8?B?aWp4WWd6d2NmUnUrYmJCcW1JYVNuVHFOVWRJZ1ZpNVQzYnVzeklrUE5venZz?=
 =?utf-8?B?WlBFeWZCRldjMldoZm1HcWZuZkxhem55aW43Q0I4K3orRFlhV256ZTRPcDdS?=
 =?utf-8?B?aVdXd3c2NlA3bFdpK294QXBQSzhTWmhGdzRPTnptVlNvNGtkOGNIL0RiMk1M?=
 =?utf-8?B?YW40aDFyQngrcUFSM2VCZEZzb1pqSUN6ckdEVUdzQzBGK3NwaTVmYU9KcDVP?=
 =?utf-8?B?eFVuOXBDdWVIYktMeHpmYXZNNGZBODhJeC94NHI4V2RGRmF1OVBDMDRXb05y?=
 =?utf-8?B?cHBjMTduV1h3UVkvM053Vnkzek9XNTdHM29lTXlnSXF4UGZ1S0VyY2orSm9l?=
 =?utf-8?B?Z1U5cGJJMHRBcnNtT08xalZ3R0lhWnZveGJ5YjI4MmxMMkV3eCszeFFJSHFN?=
 =?utf-8?B?czVacHBkbkZuMWtteVFZRTFxS0pRSHJzZmRJWmM0a05ibjJqNDN1eGt3RzIx?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBCD0AFD63D9164DA3659CB9BF6178A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ee29c1-0a04-4c9f-05b0-08daa7756c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:33:19.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cngcvl24KIIeNsWnxuQRm9QHjGxahLiHWN2HHk0mWCtJBFj2vI4yli6Ju6Hu4NoXi8XnyOKeY87yc2wAoq1e3SBBj6TY7jwWQ1Z8Ab/X+Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDkuMjAyMiAxMTo1MiwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA5LzkvMjIgMTE6MTIsIFZhaXR0aW5l
biwgTWF0dGkgd3JvdGU6DQo+PiBIaSBkZWUgSG8gcGVlcHMhDQo+Pg0KPj4gRGlzY2xhaW1lciAt
IEkgaGF2ZSBubyBIVyB0byB0ZXN0IHRoaXMgdXNpbmcgcmVhbCBpbi10cmVlIGRyaXZlcnMuIElm
DQo+PiBzb21lb25lIGhhcyBhIGRldmljZSB3aXRoIGEgdmFyaWFudCBvZiBibWMxNTAgb3IgYWR4
bDM3MiBvciAgLSBpdCdkIGJlDQo+PiBuaWNlIHRvIHNlZSBpZiByZWFkaW5nIGh3Zmlmb193YXRl
cm1hcmtfbWF4IG9yIGh3Zmlmb193YXRlcm1hcmtfbWluDQo+PiB3b3JrcyB3aXRoIHRoZSB2Ni4w
LXJjNC4NCg0KSSd2ZSBjaGVja2VkIGl0IG9uIHNhbWE1ZDJfeHBsYWluZWQgYm9hcmQgb24gdjYu
MCBhbmQgaXQgcmV0dXJucyAobnVsbCkgZm9yDQpib3RoIGh3Zmlmb193YXRlcm1hcmtfbWF4IGFu
ZCBod2ZpZm9fd2F0ZXJtYXJrX21pbjoNCg0KIyBjYXQgaHdmaWZvX3dhdGVybWFya19tYXgNCihu
dWxsKQ0KIyBjYXQgaHdmaWZvX3dhdGVybWFya19taW4NCihudWxsKQ0KDQoNCldpdGggeW91ciBz
ZXJpZXMgYXQgWzFdIEkgaGF2ZToNCiMgY2F0IGh3Zmlmb193YXRlcm1hcmtfbWF4DQoxMjgNCiMg
Y2F0IGh3Zmlmb193YXRlcm1hcmtfbWluDQoyDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVh
DQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtaWlvL2xp
c3QvP3Nlcmllcz02ODI3MDcNCg0KPiBNYXliZSBJIGFtIG1pc3JlYWRpbmcgY29kZSBhbmQgaGF2
ZSBteSBvd24NCj4+IGlzc3VlcyAtIGluIHdoaWNoIGNhc2UgSSBhcG9sb2dpemUgYWxyZWFkeSBu
b3cgYW5kIGdvIHRvIHRoZSBjb3JuZXINCj4+IHdoaWxlIGJlaW5nIGRlZXBseSBhc2hhbWVkIDop
DQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gYWRkIGF0IGxlYXN0IHRoZSBhdDkxLXNhbWE1ZDJfYWRj
IChjb25kaXRvbmFsbHkNCj4gcmVnaXN0ZXJzIHRoZSBJSU9fQ09OU1RfQVRUUiBmb3IgdHJpZ2dl
cmVkLWJ1ZmZlcikgdG8gdGhlIGxpc3Qgb2YNCj4gZGV2aWNlcyB0aGF0IGNvdWxkIGJlIHBvdGVu
dGlhbGx5IHRlc3RlZC4gSSBob3BlIHNvbWUgb2YgdGhlc2UgZGV2aWNlcw0KPiBoYWQgYSB1c2Vy
IHdobyBjb3VsZCBlaXRoZXIgbWFrZSB1cyB3b3JyaWVkIGFuZCB2ZXJpZnkgbXkgYXNzdW1wdGlv
biAtDQo+IG9yIG1ha2UgbWUgYXNoYW1lZCBidXQgcmVzdCBvZiB1cyByZWxpZXZlZCA6KSBFZyAt
IEkgc2Vjb25kIG15IHJlcXVlc3QNCj4gZm9yIHRlc3RpbmcgdGhpcyAtIGFuZCBhZGQgcG90ZW50
aWFsIG93bmVycyBvZiBhdDkxLXNhbWE1ZDJfYWRjIHRvIHRoZSBsaXN0Lg0KPiANCj4+IE9uIDIv
MTUvMjEgMTI6NDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4+PiBUaGlzIGNoYW5nZSB3
cmFwcyBhbGwgYnVmZmVyIGF0dHJpYnV0ZXMgaW50byBpaW9fZGV2X2F0dHIgb2JqZWN0cywgYW5k
DQo+Pj4gYXNzaWducyBhIHJlZmVyZW5jZSB0byB0aGUgSUlPIGJ1ZmZlciB0aGV5IGJlbG9uZyB0
by4NCj4+Pg0KPj4+IFdpdGggdGhlIGFkZGl0aW9uIG9mIG11bHRpcGxlIElJTyBidWZmZXJzIHBl
ciBvbmUgSUlPIGRldmljZSwgd2UgbmVlZCBhIHdheQ0KPj4+IHRvIGtub3cgd2hpY2ggSUlPIGJ1
ZmZlciBpcyBiZWluZyBlbmFibGVkL2Rpc2FibGVkL2NvbnRyb2xsZWQuDQo+Pj4NCj4+PiBXZSBr
bm93IHRoYXQgYWxsIGJ1ZmZlciBhdHRyaWJ1dGVzIGFyZSBkZXZpY2VfYXR0cmlidXRlcy4NCj4+
DQo+PiBJIHRoaW5rIHRoaXMgYXNzdW1wdGlvbiBpcyBzbGlnaHRseSB1bnNhZmUuIEkgc2VlIGZl
dyBkcml2ZXJzIGFkZGluZw0KPj4gSUlPX0NPTlNUX0FUVFJzIGluIGF0dHJpYnV0ZSBncm91cHMu
IEZvciBleGFtcGxlIHRoZSBibWMxNTAgYW5kIGFkeGwzNzINCj4+IGFkZCB0aGUgaHdmaWZvX3dh
dGVybWFya19taW4gYW5kIGh3Zmlmb193YXRlcm1hcmtfbWF4Lg0KPj4NCj4gDQo+IGFuZCBhdDkx
LXNhbWE1ZDJfYWRjDQo+IA0KPiAvL3NuaXANCj4gDQo+PiBJIG5vdGljZWQgdGhhdCB1c2luZw0K
Pj4gSUlPX0NPTlNUX0FUVFJzIGZvciB0cmlnZ2VyZWQgYnVmZmVycyBzZWVtIHRvIGNhdXNlIGFj
Y2VzcyB0byBzb21ld2hlcmUNCj4+IGl0IHNob3VsZG4ndC4uLiBPb3BzLg0KPj4NCj4+IFJlYWRp
bmcgdGhlIGNvZGUgYWxsb3dzIG1lIHRvIGFzc3VtZSB0aGUgcHJvYmxlbSBpcyB3cmFwcGluZyB0
aGUNCj4+IGF0dHJpYnV0ZXMgdG8gSUlPX0RFVl9BVFRScy4NCj4+DQo+PiBzdGF0aWMgc3RydWN0
IGF0dHJpYnV0ZSAqaWlvX2J1ZmZlcl93cmFwX2F0dHIoc3RydWN0IGlpb19idWZmZXIgKmJ1ZmZl
ciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGF0dHJpYnV0ZSAqYXR0cikNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqZGF0dHIgPSB0b19kZXZfYXR0cihhdHRyKTsNCj4+ICsgICAgIHN0cnVjdCBpaW9fZGV2X2F0
dHIgKmlpb19hdHRyOw0KPj4gKw0KPj4gKyAgICAgaWlvX2F0dHIgPSBremFsbG9jKHNpemVvZigq
aWlvX2F0dHIpLCBHRlBfS0VSTkVMKTsNCj4+ICsgICAgIGlmICghaWlvX2F0dHIpDQo+PiArICAg
ICAgICAgICAgIHJldHVybiBOVUxMOw0KPj4gKw0KPj4gKyAgICAgaWlvX2F0dHItPmJ1ZmZlciA9
IGJ1ZmZlcjsNCj4+ICsgICAgIG1lbWNweSgmaWlvX2F0dHItPmRldl9hdHRyLCBkYXR0ciwgc2l6
ZW9mKGlpb19hdHRyLT5kZXZfYXR0cikpOw0KPj4NCj4+IFRoaXMgY29weSBkb2VzIGFzc3VtZSBh
bGwgYXR0cmlidXRlcyBhcmUgZGV2aWNlX2F0dHJzLCBhbmQgZG9lcyBub3QgdGFrZQ0KPj4gaW50
byBhY2NvdW50IHRoYXQgSUlPX0NPTlNUX0FUVFJTIGhhdmUgdGhlIHN0cmluZyBzdG9yZWQgaW4g
YSBzdHJ1Y3QNCj4+IGlpb19jb25zdF9hdHRyIHdoaWNoIGlzIGNvbnRhaW5pbmcgdGhlIGRldl9h
dHRyLiBFZywgY29weWluZyBpbiB0aGUNCj4+IGlpb19idWZmZXJfd3JhcF9hdHRyKCkgZG9lcyBu
b3QgY29weSB0aGUgc3RyaW5nIC0gYW5kIGxhdGVyIGludm9raW5nIHRoZQ0KPj4gJ3Nob3cnIGNh
bGxiYWNrIGdvZXMgcmVhZGluZyBzb21ldGhpbmcgZWxzZSB0aGFuIHRoZSBtZW50aW9uZWQgc3Ry
aW5nDQo+PiBiZWNhdXNlIHRoZSBwb2ludGVyIGlzIG5vdCBjb3BpZWQuDQo+IA0KPiBZb3VycywN
Cj4gICAgICAgICAtLSBNYXR0aQ0KPiANCj4gLS0NCj4gTWF0dGkgVmFpdHRpbmVuDQo+IExpbnV4
IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KPiBPdWx1IEZpbmxhbmQN
Cj4gDQo+IH5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVzZXJzIGNhbiBhbHdh
eXMgdHlwZSA6aGVscCEgfn4NCg0K
