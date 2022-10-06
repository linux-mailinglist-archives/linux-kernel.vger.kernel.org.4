Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF35F62D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJFIfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiJFIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:35:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDBA52DF0;
        Thu,  6 Oct 2022 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665045323; x=1696581323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KkbRLlZv12/vtYPb2P236CXFsULtyaNj1BODVPnazJE=;
  b=WI/qUOpPb64rysy8hzQzk28gPUBCMapDDu+WnhEBKXfKWOcZbBsjqiP1
   HvaJ1S2OkxElYZCZkcv1FO7Z/y7VqWmu2DDHcN+rHei3GiDZAsNaBg35i
   C40wIXZ/pkywx6glwFQbpKEq34wFPMrCnDgzZAkIvTTXzAaMKL0/ZaxE2
   fRoCnjZpniL5JM4sTCyK/enI9Ib1t8NwmR+a/sVwlPmvsAYB5u8OKsibv
   3Zfxc9E5McZh0fPqm7LYGh1Nmq7K0liqVMe2l4btZC89nCfRG0Lza9ill
   j3PxwZmCzLzTUnpKHFQAxfaDZfhpV6GgoRlyIMaDVrplFqHfuMJ3x0aK9
   w==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="183533933"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2022 01:35:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 6 Oct 2022 01:35:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 6 Oct 2022 01:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVgLw7XKosnORnH305h81qZKtamzlRq97+HkWA7Tk5CiGJEBNjrTzNhfVWrxamC4ehO2t+mixLDgAfpDZOzBzl19oMpCb1OvlyPU8M+yBr5goHBdgP6zkX6Eip2HNYvtZ6xrR4iBVNQk7ecy1UDrkxjSMfqpQStm2ix5kdPTMBtPS+LAwS9AEgowWNxbt44dQXi8dAIqsG/0cbVEVip+DaiowKZIKaxJT4iRy1e8CF+v4Vmy8IjJGYfJDDYMndb1WzYRe9fA3yLasCKAwzECamAAL1Wrmwc6zgX/2+4ZXYgwZrTWT2loKDlSPHXUAT3WiGzNSiONIn+7brhy/ZpOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkbRLlZv12/vtYPb2P236CXFsULtyaNj1BODVPnazJE=;
 b=DDOQAAxTQmj1ZDf5DHLwKAnbqlU1QwaE8Gi84Cz/RPhXxVK95u/ct8+ScM4yOlCjWOppc5+DH3zDADuCnCrqyI0PgPZQlY1zLfWH/LJxRKJs6LA3BC4JDXHF6tqZ9b7TfOepcBUUPXyGNK8ZE/2YIkyVoO6ATzywh82ISR2JXbaAUXqSAxn/jNgmsq5qW/m+rFitGSu75xK653OOa4SarwLB8lkSDeiNIjgeMdhPBVpgDcUoyBQwd/zkSvOAGBzaDUK9WWQI/ZA+46fdxuoW/Atm99LXsR69QwGieGZWRiUAHtdJMy8Fcv5meYD/040cXNtvdBgNbKmyj37MsUyoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkbRLlZv12/vtYPb2P236CXFsULtyaNj1BODVPnazJE=;
 b=d9V9XCRZUyAr1UMl+50mT1dDTUK/tHt9yg1Y9xrKbYONuknvbGHu+odyCdhv1Cy1GOUvKNcmzb3RvT95GRIoIjjkRyv6qIeJb1YfPrYrQVic92ewAwyDJBGa+TKvXcDh+fDx+if0QoDtE+khMokvMFvrDvKrgkHo+OWohDjkOwA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 08:35:19 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 08:35:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mazziesaccount@gmail.com>, <matti.vaittinen@fi.rohmeurope.com>
CC:     <Eugen.Hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] iio: at91-sama5d2_adc: Use
 IIO_STATIC_CONST_DEVICE_ATTR()
Thread-Topic: [PATCH v3 09/10] iio: at91-sama5d2_adc: Use
 IIO_STATIC_CONST_DEVICE_ATTR()
Thread-Index: AQHY2V6RlfuypgrNCUW9z/WCBPTe4Q==
Date:   Thu, 6 Oct 2022 08:35:19 +0000
Message-ID: <7c31ee5b-b385-4966-8b52-65d8606fb057@microchip.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <4476a4ce852febb3eb863878e66751c787195b18.1664782676.git.mazziesaccount@gmail.com>
In-Reply-To: <4476a4ce852febb3eb863878e66751c787195b18.1664782676.git.mazziesaccount@gmail.com>
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
x-ms-office365-filtering-correlation-id: 7974d000-e350-4ed3-f8a8-08daa775b3dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X22oWsTyfSQyBKIJqzV7IlrI6/9OhO6JA6hX+Je+Vyh3TZvpNxXgTbO0XOiNuK+b39OAXxNppIZUrp66Ep01Asuj/IO/gP6zVQZjkniTlJlm580tjZKrRCBZoITG8zkA4EokKXgrYpdlo6cZkrkK0CUzKCEYzKanJnUbYlUl5PTZ6GWT5ju3efG0DHcWikvpp3qKA2Hgmr4F9omEIafXRiHGAD/6xUj3bROUx3MAVJFProQAwoEHPk9050BYPA/Qqf2qYv+Baq08C3moRhGqBPurUuPBgoTt9y2LGEN/7kVYbxM17AHjjs1xtW69CbP3bKSfHbKokyqj8TRWoMnTv8m2kqZKjslePx0zrMB3tRmDPPRJFYNRZ3SihQlqKi+bt5ei39tjsGVa7DmKZnD2V1NSVCE5IMG4vptrmNkMhI9rup337PgxF1bOq67k9B0rbJZmEy46pRr6xueuoqtXSoM4DKHVykpPHNhx7ws6uOpmx9xd0LhPsr6/JsgRl81cU6obsGNDRnMXzzJybxcd6fPf2mkJNZiaB4FcTuaf6p8/u/MuG2F4IlvcPIAV28s9hcliaxFhnAZck5TsuxMA/av6Suj00hmQ97zK5dD0+BrGn0yEOIcgo3Jfv6AXLrp2G+zMKTTdBkjLTBPQfI+vGGMh/STzS4wJyCdo7vXS49Tq4mmFtitHiseIiAWOeP3EjqhVrdO7gUJ8U/1ipB7IrKr3XbN2Mb5VsGynU5a9yiMhj594eRFFZH7U3PyvIjaaimIq9HdblRG4VSfUA9eZBy/cyjO7LlYFYFh4128BI44rEyFq5eyFydcgjiTsYNc/XKTLywrRvibJq24DmckdXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(31686004)(122000001)(36756003)(38100700002)(558084003)(2616005)(186003)(26005)(38070700005)(6512007)(86362001)(6506007)(31696002)(53546011)(6486002)(478600001)(5660300002)(2906002)(71200400001)(8676002)(8936002)(41300700001)(91956017)(316002)(110136005)(54906003)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3dZZTVrdnR1N0NodGd6dWtzNkxXWURzdjZNam9ublNyNU45eFdBWGY2Y0xO?=
 =?utf-8?B?VzIxVXhadVNrT1ZsUGtyQTQ4dnpZcXk2aVl5N2hsMzlRbnNBOXcyUjhnbXlE?=
 =?utf-8?B?MTRhcC9WMTh6NXBaZ0QveE15RWhrV0swOHZhRmszVXUvNC81bHVoUnpuK1E1?=
 =?utf-8?B?bHdPdGhKSlgxbWVnZGxxRG1xN2VqQTBtRkFIWVZqSlgzdi9CMk9CZ3dVb2ky?=
 =?utf-8?B?RnVIZzVNbCtpdXllNlBqbnkvZ1NXTmRmdGRuQ3NlNUNaRlh3U1RJNHduemJl?=
 =?utf-8?B?MVk3RW1OemsxaFZac2JNRWdEdUdFRm9kKy9hQWV3MzJvL21uWG9MekdJOUNN?=
 =?utf-8?B?RE5LRFUwQ0JVZndhbmRjTUdOdnplbnpXZVM2YXljTnlOYWZXUnBEQ01jYzNV?=
 =?utf-8?B?ZE0zMkpybzFBMzh5aVdTa1JZcENYMGgzcVkzUkpscDBTTFNaV0haKzNFayt6?=
 =?utf-8?B?NnFGSGN6ZUZpLzV2VmY0SE82NkFhREluaDRZZXQ2dWo0TmdqeVVuc0p2emta?=
 =?utf-8?B?RDhXU1lWenZkb3Z1UzMwN0RyM2NFTW9NbUlCU29Zc3dGeGxIUE1nRTlERTQv?=
 =?utf-8?B?TkJya1ZOaW9nRmVrNm9iQkQwK2gwRDVGMEdXK0xwMGZvRnB6a0IyekJmYjNN?=
 =?utf-8?B?ZGp3U0RHQ3N6K1duN2J5c1RZWDlJRlplN0w3Sk4zQ0RDbHZ3WWhxZjV0UStH?=
 =?utf-8?B?ZmZiajBvMWYvOGVnbENUNUdZWHpKYkRCVGhIK0djbVlrTHJnQ2dENGViSGVz?=
 =?utf-8?B?OThNdU9Nc3VLZ2FPY2hlQW1kQjV2K2R6OENRamZzVVU2UXlyOWdwblA2ajlQ?=
 =?utf-8?B?OW91elRQRVd6THkyMzVTajRCVXVnQ2taQXpFN1N2UDhUWURtbDBIWHU1amsv?=
 =?utf-8?B?bE53L0Z3STgvVlBLcTB4MDVPQU83emJOcW5YQ3p6aFk4U1JxRlRKOFN5SzFl?=
 =?utf-8?B?cEQ4ZnJqN01OM1NMR1FpMksvSWNHdHN5cy83ZVdKRU5IWEs1UTJrUnVBS0FR?=
 =?utf-8?B?clRiQnZwa1pDdHBCYVNkUVpMYmRUMGhpWHlQdUszRXB6RnFGSUZZVUJ2NnpY?=
 =?utf-8?B?RHJrdEVaSktvZDkxcUNkT1VQWHRBZWU5ZWhONGlsT2pGR3NGYVhsSkpyMVNr?=
 =?utf-8?B?eWYxWld0ZGQyN2xxSUR0T0pNUUZ2ZEo2OVpzNzUzL1NNQjNXWHZrWVFFQ1dR?=
 =?utf-8?B?RWIrN3Q3bE1iSGllRFdsbVhHbFROVVNkVmVrSTZlQ29lampyMmo0clZaalJx?=
 =?utf-8?B?NmJyd3J0NFl3YklPdk01aUZKcERLYXVmbFhuRDNUZUYxTzQ1MVFuNWhoZ0JL?=
 =?utf-8?B?ZjBaWUE3VUliaVhiMGxBUldyOEhlU0I4cnB3cUoyajhZd0dMQjh5Y2VQU2lk?=
 =?utf-8?B?bTNQZ2RaNU5CWmNwRFFCbW5jTU00WWdZVndsTnlRck13bXdjaGl4b3JYbXky?=
 =?utf-8?B?MU4vdVJNRzJhVkNMcVVia3k1VUhZaUNud1EwYzhTWmV4L3g2bCtLKzZydzRN?=
 =?utf-8?B?TEpQaGtwbktqWU5JdklpTDBMaVNvVmtjaU9TT0o0VUhBQXRqekFlVmVrbzE3?=
 =?utf-8?B?cnMzZ1QreGZlbFo2L0pJajNYdXFQd0t4OVZVdU5OblpDcnd6V1BnUExjUEtt?=
 =?utf-8?B?YlFoMmVGejBrejhtVVcveXRuTS9DK2t6VUsxVFZBWXY4ZUpJbmFVM3RzUUZz?=
 =?utf-8?B?NDRxMkRlcVljMW1CUlcvWUlpK09PQXBBYjNWMnM5c2p4bm9HcmJXa2hOaUw0?=
 =?utf-8?B?Z0d2NzZoNG5vaFJYR1pKS3lXRDhnd2ZNL0xVeCt0NWxkOVNFUnAzUmZkb3lT?=
 =?utf-8?B?TTBFUzhFR1RPR1ZkM2s3Nkd6ZWNwZkVmWnk1YzhOLzZhN1gvd3FRQU9pdmJ2?=
 =?utf-8?B?VFZkeU9ZZkJUdU1qcmY1RTI1ZjFnem5hNkpCZGkydjNSZ3diRGFOYWdXQy93?=
 =?utf-8?B?cHZ3ZGx4Y3Z2ZzQ2aTJ1WDVCUUxsN3dFK1cvNjZobGgrdTU5VW1OaHlNY1JE?=
 =?utf-8?B?ZUE2aGp3ejJTZkFXK1pqdnBadHZ3eVZ1UzhBNHNuR2VrZU8zUURUWkltMnRa?=
 =?utf-8?B?VFlwck8waVRoWTdhWkFZZzBEOGJDZ2V1bTBkWUQzYTF0K1htai9rajliUjZk?=
 =?utf-8?B?MmdnRzQrelg2VGIzMmo2eld6aEdaWmtId2dUYzBkS0ZvZzBzT2lBaFZQUkdw?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6B7600EB53824E82D6BB6C4D160439@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7974d000-e350-4ed3-f8a8-08daa775b3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:35:19.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqvK608yKjRnCrOl77eYU9awbrAselJE1tXEJ3ZKsZvkfnjXX2tN/WUzkEKIZeB8r0PTyzt1lZQosrMi31DV+/l8/nu9NrF9b7Ko+v6EJco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMTAuMjAyMiAxMToxMywgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiBTbGlnaHRseSBz
aW1wbGlmeSBieSBkcm9wcGluZyBvcGVuLWNvZGVkIGNvbnN0YW50IGRhdGEgaWlvX2Rldl9hdHRy
DQo+IGZ1bmN0aW9ucyBhbmQgdXNpbmcgdGhlIElJT19TVEFUSUNfQ09OU1RfREVWSUNFX0FUVFIo
KSBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVz
YWNjb3VudEBnbWFpbC5jb20+DQoNClRlc3RlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCm9uIFNBTUE1RDINCg0KDQo=
