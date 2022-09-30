Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE825F05AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiI3HX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiI3HXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:23:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E921D73E3;
        Fri, 30 Sep 2022 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664522596; x=1696058596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9ZKbd9rAErE9tp2bkUcRC2Gjx8sf0UyZZ8L7uKALFJQ=;
  b=DBhQkkm4vosfpla0557xgEtj9WbThXZBLn15ZlMbWCkyRZPTRJ0Ibdbj
   ywqXHuOUz6xGaQqVwpaoCXt1guMsr8zohJG8rdOqL4AWid2TB6LClOZ7n
   hz6yfu4udzhCfooX0HUEm9WvKqzRxvBnPXss8acgQSSZ7yWE1C5Ccux6v
   bsmTbK18kzrScMdZHzHK700BMoWoRhgRmOqhgiheCcNEQRh1aZHGEpxYP
   cJE2yoFkJUok14GnvgG1hDHovxcM9idxb6ccbo/kEmYbww3MdlBaMDFFO
   pURernFihAE398E7kfG6ds5wAZIGhSRzEKbLQ9ZrQenlVVBNuuXCUPCXA
   g==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="182752126"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 00:23:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 00:23:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 30 Sep 2022 00:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw+7Wd4Y7DZxUgCfumJgU9Opd0xn6IPMPCuQEUrCrnn9jppt3tEV0hnAGX+7TEXxUWh/inL26wQQYtnKH3mIUYLt3myberb8iE4qRoFBlOSPfpN5C3O+6f5JrTYlOI8+QnKFYeGJaU9ebfGbkMT3McPk8U9X4F4uN4TQH6nOCvcc6EThiTm1LFW2HHZGbC08YFLE0a4t+nrnG+OnCDjBHp2+XPQ1ocB9KHJ9E4QFhSmDJWGQsplL2IUTjoff1z1bNTaxY64l5crgbmnbFgEyvOVAtF6omxdZ28jn3QQ6ETuA/3RsKYXwFnELVkAQR7jEpJpjWzoLwPSap9daXlguWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZKbd9rAErE9tp2bkUcRC2Gjx8sf0UyZZ8L7uKALFJQ=;
 b=FiLeYNMEkiZcy8e79EQ2H4dh0kZLdqZ5XGTVCWIeG+ZbtWr2Hvg8Nlp6u7GxNL7K+T4eZOfktA63+68M3L+zGnxsuulRSknQ9Y8wJeD0N/fTwYWTUfLeJNZ50yDSu1Cb82src0ZJ0tTKmpWBoxdFdHPpj8r7JfBIEZhbXJJXDMYFWIyTRPFEofXfE6hHMZiYbbRd9IKWv6S37dfnqf8Kih4hfAhTPeJHqCnMj/pU0a2/4Qss3ZV8fPm3DoVtmJiVXFNc2V9YPrDoglK69O59Gt6p1oP92NQS3fqVRop6zdzpaPddnK8RqGpeJv7jEI3t5vJSejHYRcU0Pn8XpPtRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZKbd9rAErE9tp2bkUcRC2Gjx8sf0UyZZ8L7uKALFJQ=;
 b=luhElFGgPxtTjFAn/YwDayxMq3F0avUnyCvefvleW9oL/V8dyoofHsAsBCTfcP99G7z2lx/BTbFsJCwRWS9uauwX9AJhgtSYNaCxobX8edzlfpZS9Sl4AcKAJ6HGzK5t+DvI4i4+EltbRflo8xiCRxYooIChgDU9M2gnmLgiWhw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 07:23:00 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 07:23:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 8/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH v5 8/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Index: AQHY1J142VTvAKHQ/0qroezu+7Ci1w==
Date:   Fri, 30 Sep 2022 07:23:00 +0000
Message-ID: <8f5f340d-9833-7f98-af73-be0f32a550cd@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-9-sergiu.moga@microchip.com>
In-Reply-To: <20220922113347.144383-9-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB6860:EE_
x-ms-office365-filtering-correlation-id: 500c3392-277d-4562-4f67-08daa2b49b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIAl9bCNsDdSdziPUhWGQu0PX1D05Fp8bcBPYzgDOygCO8++OhweR7pb7fo2SZGWGlqhwjo78Z4a+52ju99B+EC5JHnUeGlXWIckS6pcMNo0PDddF2SVLgQ0Lcv+8Yu5/9q+xSkxRYeuadCPcZ+WCEJIXb/C8xem0/JlSoUBX7USOxDPpbbKLMfTn/1dF1/GUhQbXi/LJoop3eCs458ARLhZqVloKTfltmtGLjlfJ+VsTtSTE0xjlL+PGgbcQ3qBQBtqbkDlXvn9QWaHDH0nby0+2DO8o8R7jHCh161fWDGBlj8V7z+ByfXoDS0UtDA7TbpNDhx+ViYyhdUlRuIUu2e96ehtWjhN7fPs0z5o3kxy0QM8digLDn+u3NrK2PvucsF0rmgfRLUzo32rHtRtYGUrj7k6rR3esFuTX53/4fcxcqAlCuy4S4QB+d5j05gzMAU/ewYF/BfDI2MI8yykdNZTuiNnqUsuZU0cqEdgV4AlI+Qc+JFkrokDQnpkLHrNYfyMnvrHaJMmlMEz2pHHusJxiZdvG8dyxH1qJRES3wruoQEvOP5yu/ffWwnghyeNgRiipQotOo7o0rhh+mA6A4Nc5NXViVJanxTbmhqqCTtd54kkDYkHjKY/lDnWAsvrw9w9Dyu0TWMDau61dABYY2MoUF99G6WHm2QU+rM+/lC4uCJUPe0oMaxdI82x0Q67WLxeRqD9ktFX8IYKDuxBtk98Pl5UulhpLtjEyOU7pytQEJrjbpfCUcQjzvpZc5ZHPoT2VlNxYEI+udmX6GkjNYhI9e+Vk3tmVW4IT3tJFt4qApePpK5Q3m/1J7MiLWIWqTVKdO7KauxFAPNSPP/1umIgh9mRupQLa8nZs21d9+Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(66946007)(66476007)(316002)(6636002)(76116006)(91956017)(478600001)(66446008)(6486002)(66556008)(54906003)(110136005)(31696002)(122000001)(86362001)(36756003)(921005)(2906002)(38070700005)(64756008)(4326008)(8676002)(38100700002)(41300700001)(8936002)(7416002)(83380400001)(53546011)(186003)(2616005)(71200400001)(26005)(5660300002)(31686004)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXBaQjZlWnhkYVQrS1V4YjY2VnB6TGZhV2MwaFNtSGtFQllYWjhHNFkwR3VY?=
 =?utf-8?B?YjlaNDFXUmd5TjRzcjkyVExYWXp6b2MvdThCdjNJbzAvL2oxZCt1RnlYZUJr?=
 =?utf-8?B?QUx4dWZGak95WWRzOVIxeDl2WFVOOGwxbFNCSkhtTEJ6TGRUUFdXUEVzZzR4?=
 =?utf-8?B?ZTl4NjJrU0IxOHprYitPUkRvdFVua2s1RnUrMVJqRjJuN3A2VllYNWNiT1Zw?=
 =?utf-8?B?QWZuSDgxMkR2bGNxOUJjMytQRkZxYjEydkhUNDBZdmxKeEJiT3ZweGFxZjRI?=
 =?utf-8?B?eE1WM3hYT0EwWGJGa0dKck5ac0RHa1ZJdG1TSXJiUUE0WVZKZENzdEo4citG?=
 =?utf-8?B?ZHNJekZBS0tQbFZUcFBEZmpuYlcyMmV6TzNYUnYvdlZYZnBmbnN4Z04wbm1V?=
 =?utf-8?B?VndlTzBXazhrdjhrQjVCZDZUNks1TG5tZGdhckxVVVJGdDlORnEyWEp5UkN5?=
 =?utf-8?B?M1VELzduR3BaRGRTN0Y2bk1lbm1weXhrZ0JoNTdSUnNzWEYxM242OVhwcjdB?=
 =?utf-8?B?N0ZZTEhDdlFpMUR5SnNXYnN6elhIallWUWhidldoeVhWUjByVVUzQWs3OGZC?=
 =?utf-8?B?SkZqN2ZVaDNmT215K0cvamlEeUJ0Y3drdHlSMHk1djBxTlYwK1VyQXlCZVdl?=
 =?utf-8?B?WTNDMGdZS3ljQmh5N3Uxb25RVlNZYVlvSVp6c2NUN290d3hTZk52Z0IybStS?=
 =?utf-8?B?SDQyNVVoQ0RHUXgvTWYyLzR0blA4QzNxVlhQWGEyckkxMjZkOHJDUEQ4cjhJ?=
 =?utf-8?B?VldLd0pzUmRob1JGUnZvbzRUTWdKWktYMzVtY2NncFRzL2tTd1J4ajMvUUlS?=
 =?utf-8?B?NjZTRDJQQS9MTlBzeUVXMGgvS01KNVhWZ2xFWjl2c0plSHRhcVlyb0V6c1Ft?=
 =?utf-8?B?aFBaLzRDUWRwOG9iZE1IMTR6M253S2tveGw3NEd4SStTTDBlN2hHZjZRS0lo?=
 =?utf-8?B?ZHd3WWQ0b00rK3cyZDN6a1ZXVUJwb2FoVDdsUjNzaDB0YVVKeXFIVC81K0pl?=
 =?utf-8?B?WERzeVZGbUsyQmdoN1NZdVZBQUZZUzFqd0Y0SEVnRlFyYjN6REpRMWNKazcw?=
 =?utf-8?B?dWplVUkxekJ1aUxQRzM2MDYzZngyZGlyeVg3OHRoelJNNnI5d3dYK21tR0pt?=
 =?utf-8?B?MVJuSk1Ya1I0aG1DWkIxeWdycGFDMHNoVDZCQWZza0h2SkphTmxvbjduUklJ?=
 =?utf-8?B?Y3VnWHRBRXRMR3dTK1RvcENqZjgydHpBdlUvNENmaFFMVjhvMUJtaXhRUk5J?=
 =?utf-8?B?UUNPVDBxZHF4em56aTRodWlKcWRmenBrV1Q1cXorcjhkak9PMFNYVG95TVps?=
 =?utf-8?B?dWpLSStDTXljK2J6WG15NmFUUUVpbVNabEF3TTEzM1FLK1VDclp5YVdNcGJa?=
 =?utf-8?B?L21VRWtHbG5UNW5MNzBZSFdlNURqN25mYTRTa1NPTkUyWWFySitadE80eVpk?=
 =?utf-8?B?aEZrMy9xdi8zcTdyNmR3MUQwRUd1WGtBUWEyNmZid0s1TTEyM0dGM2ZiQXJl?=
 =?utf-8?B?U3Bwekt5WVJTa05GY3A1eHJWN0dXTUdoTFFoTDdmT2tpUSttc0ZpN0FkUVp0?=
 =?utf-8?B?U3AzVy9YU2EvSTZwVVkwN3A2NUxjWmdoVmU1UjRBeHJ3YnowVlU1MXdHRm9B?=
 =?utf-8?B?SGI1TDA5SXNXVlFCc0ZMNUVyT0N3Vkh0QjhLdU5Zb3lWS3VSNG9BWklhM2lU?=
 =?utf-8?B?MCtUblk1U3VCNGo3dXVaU2g2TW9jM01aQ3E5N0EyVU1neXhlOUova0hsSVd3?=
 =?utf-8?B?UHY2czVkVlBYQmo4YkNOS29pMStWUmZFYUxJRU0xRWRDVW1uTER6aGdMTkVN?=
 =?utf-8?B?cTUvb0R5UlU0aVRIYnNjL3l2YWRLM3F5R0JNT28xdTIxY1RIbnQ3Mkl0YmpE?=
 =?utf-8?B?R3N0dEpWZG84ZmVrQ0NKM0tRUE9vclBycHJmcXpnVm1VNFN5ZTlNeEJPWmJv?=
 =?utf-8?B?TVhGT1BUZHZjNERETUQwLzUxcmx5aW1MZ1J2STVydWxXM0JSczBrNGlZMW9N?=
 =?utf-8?B?R1E4Q2hTWmEydlA1SitySSt5OFZaMERwZEM4Wk03TU5kUE0xZVFuUFZ1NTBu?=
 =?utf-8?B?VlN5ejlyNGFwN014eUsyS2lPZmtQT21pcXl4STNLL0hkWTJCZDlpeUZmd28r?=
 =?utf-8?B?QTB1VTB1YXJsZTNCYlJ1T1RVeDI5VytibjQwTXVUNTlaSXNSam1Da2RmYXdl?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97CB91FF180FE542B31894ED5978266B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500c3392-277d-4562-4f67-08daa2b49b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 07:23:00.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63HV6bFVviqpxNMhpx3nCehd4dhv7zTKWojm5VFvUkaIEUMkGnjDwmnvN6yhEcfj2kT/8uIXxUUTfjYPTCMzDw/RbU2/SWKVmLLsjHh2bvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDkuMjAyMiAxNDozMywgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFByZXZpb3VzbHksIHRo
ZSBhdG1lbCBzZXJpYWwgZHJpdmVyIGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlDQo+IHBv
c3NpYmlsaXR5IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFz
IGl0cw0KPiBiYXVkcmF0ZSBnZW5lcmF0b3IuIFVubGVzcyB0aGVyZSBpcyBhIEZyYWN0aW9uYWwg
UGFydCBhdmFpbGFibGUgdG8NCj4gaW5jcmVhc2UgYWNjdXJhY3ksIHRoZXJlIGlzIGEgaGlnaCBj
aGFuY2UgdGhhdCB3ZSBtYXkgYmUgYWJsZSB0bw0KPiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNsb3Nl
ciB0byB0aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+IGNsb2NrIHNv
dXJjZS4gTm93LCBkZXBlbmRpbmcgb24gdGhlIGVycm9yIHJhdGUgYmV0d2Vlbg0KPiB0aGUgZGVz
aXJlZCBiYXVkcmF0ZSBhbmQgdGhlIGFjdHVhbCBiYXVkcmF0ZSwgdGhlIHNlcmlhbCBkcml2ZXIg
d2lsbA0KPiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMgY2xvY2sg
bXVzdCBiZSBwcm92aWRlZA0KPiBpbiB0aGUgRFQgbm9kZSBvZiB0aGUgc2VyaWFsIHRoYXQgbWF5
IG5lZWQgYSBtb3JlIGZsZXhpYmxlIGNsb2NrIHNvdXJjZS4NCj4gDQo+IEZ1cnRoZXJtb3JlLCBk
ZWZpbmUgdGhlIGJpdCB0aGF0IHJlcHJlc2VudHMgdGhlIGNob2ljZSBvZiBoYXZpbmcgR0NMSw0K
PiBhcyBhIGJhdWRyYXRlIHNvdXJjZSBjbG9jayBpbnNpZGUgdGhlIFVTQ0xLUyBiaXRtYXNrIG9m
IHRoZSBNb2RlIFJlZ2lzdGVyDQo+IG9mIFVTQVJUIElQJ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0t
DQo+IA0KPiANCj4gDQo+IA0KPiB2MSAtPiB2MjoNCj4gLSB0YWtlIGludG8gYWNjb3VudCB0aGUg
ZGlmZmVyZW50IHBsYWNlbWVudCBvZiB0aGUgYmF1ZHJhdGUgY2xvY2sgc291cmNlDQo+IGludG8g
dGhlIElQJ3MgTW9kZSBSZWdpc3RlciAoVVNBUlQgdnMgVUFSVCkNCj4gLSBkb24ndCBjaGVjayBm
b3IgYXRtZWxfcG9ydC0+Z2NsayAhPSBOVUxMDQo+IC0gdXNlIGNsa19yb3VuZF9yYXRlIGluc3Rl
YWQgb2YgY2xrX3NldF9yYXRlICsgY2xrX2dldF9yYXRlDQo+IC0gcmVtb3ZlIGNsa19kaXNhYmxl
X3VucHJlcGFyZSBmcm9tIHRoZSBlbmQgb2YgdGhlIHByb2JlIG1ldGhvZA0KPiANCj4gDQo+IA0K
PiB2MiAtPiB2MzoNCj4gLSBhZGQgdGhlIGVycm9yIHJhdGUgY2FsY3VsYXRpb24gZnVuY3Rpb24g
YXMgYW4gaW5saW5lIGZ1bmN0aW9uIGluc3RlYWQgb2YNCj4gYSBtYWNybyBkZWZpbml0aW9uDQo+
IC0gYWRkIGBnY2xrX2ZhaWxgIGdvdG8NCj4gLSByZXBsYWNlIGBnb3RvIGVycmAgd2l0aCBgZ290
byBlcnJfY2xrX2Rpc2FibGVfdW5wcmVwYXJlO2ANCj4gDQo+IA0KPiANCj4gdjMgLT4gdjQ6DQo+
IC0gTm90aGluZywgdGhpcyB3YXMgcHJldmlvdXNseSBbUEFUQ0ggMTRdDQo+IA0KPiANCj4gDQo+
IHY0IC0+IHY1Og0KPiAtIFNxdWFzaGVkIHRoZSBwcmV2aW91cw0KPiBgW1BBVENIIHY0IDYvOV0g
dHR5OiBzZXJpYWw6IGF0bWVsOiBEZWZpbmUgR0NMSyBhcyBVU0FSVCBiYXVkcmF0ZSBzb3VyY2Ug
Y2xvY2tgDQo+IGludG8gdGhpcyBjdXJyZW50IGNvbW1pdA0KPiAtIE5vIG1vcmUgQlJTUkNDSyBi
aXRtYXNrIGFzIGl0IGlzIG9ubHkgMSBiaXQNCj4gDQo+IA0KPiANCj4gIGRyaXZlcnMvdHR5L3Nl
cmlhbC9hdG1lbF9zZXJpYWwuYyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuaCB8ICAxICsNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC9hdG1lbF9zZXJpYWwuYw0KPiBpbmRleCBhY2JmNmI4MmQ2ODcuLmJkMDdmNzlhMmRmOSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+ICsrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiBAQCAtMTUsNiArMTUsNyBAQA0KPiAg
I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zZXJpYWwuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc3lz
cnEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC90dHlfZmxpcC5oPg0KPiBAQCAtMTEwLDYgKzExMSw3
IEBAIHN0cnVjdCBhdG1lbF91YXJ0X2NoYXIgew0KPiAgc3RydWN0IGF0bWVsX3VhcnRfcG9ydCB7
DQo+ICAJc3RydWN0IHVhcnRfcG9ydAl1YXJ0OwkJLyogdWFydCAqLw0KPiAgCXN0cnVjdCBjbGsJ
CSpjbGs7CQkvKiB1YXJ0IGNsb2NrICovDQo+ICsJc3RydWN0IGNsawkJKmdjbGs7CQkvKiB1YXJ0
IGdlbmVyaWMgY2xvY2sgKi8NCj4gIAlpbnQJCQltYXlfd2FrZXVwOwkvKiBjYWNoZWQgdmFsdWUg
b2YgZGV2aWNlX21heV93YWtldXAgZm9yIHRpbWVzIHdlIG5lZWQgdG8gZGlzYWJsZSBpdCAqLw0K
PiAgCXUzMgkJCWJhY2t1cF9pbXI7CS8qIElNUiBzYXZlZCBkdXJpbmcgc3VzcGVuZCAqLw0KPiAg
CWludAkJCWJyZWFrX2FjdGl2ZTsJLyogYnJlYWsgYmVpbmcgcmVjZWl2ZWQgKi8NCj4gQEAgLTIy
OSw2ICsyMzEsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgYXRtZWxfdWFydF9pc19oYWxmX2R1cGxl
eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiAgCQkocG9ydC0+aXNvNzgxNi5mbGFncyAmIFNF
Ul9JU083ODE2X0VOQUJMRUQpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIGludCBhdG1l
bF9lcnJvcl9yYXRlKGludCBkZXNpcmVkX3ZhbHVlLCBpbnQgYWN0dWFsX3ZhbHVlKQ0KPiArew0K
PiArCXJldHVybiAxMDAgLSAoZGVzaXJlZF92YWx1ZSAqIDEwMCkgLyBhY3R1YWxfdmFsdWU7DQo+
ICt9DQo+ICsNCj4gICNpZmRlZiBDT05GSUdfU0VSSUFMX0FUTUVMX1BEQw0KPiAgc3RhdGljIGJv
b2wgYXRtZWxfdXNlX3BkY19yeChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiAgew0KPiBAQCAt
MjExNyw2ICsyMTI0LDggQEAgc3RhdGljIHZvaWQgYXRtZWxfc2VyaWFsX3BtKHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsIHVuc2lnbmVkIGludCBzdGF0ZSwNCj4gIAkJICogVGhpcyBpcyBjYWxsZWQg
b24gdWFydF9jbG9zZSgpIG9yIGEgc3VzcGVuZCBldmVudC4NCj4gIAkJICovDQo+ICAJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5jbGspOw0KPiArCQlpZiAoX19jbGtfaXNfZW5h
YmxlZChhdG1lbF9wb3J0LT5nY2xrKSkNCj4gKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1l
bF9wb3J0LT5nY2xrKTsNCj4gIAkJYnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gIAkJZGV2X2Vycihw
b3J0LT5kZXYsICJhdG1lbF9zZXJpYWw6IHVua25vd24gcG0gJWRcbiIsIHN0YXRlKTsNCj4gQEAg
LTIxMzIsNyArMjE0MSw5IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3NldF90ZXJtaW9zKHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsDQo+ICB7DQo+ICAJc3RydWN0IGF0bWVsX3VhcnRfcG9ydCAqYXRtZWxf
cG9ydCA9IHRvX2F0bWVsX3VhcnRfcG9ydChwb3J0KTsNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiAtCXVuc2lnbmVkIGludCBvbGRfbW9kZSwgbW9kZSwgaW1yLCBxdW90LCBiYXVkLCBkaXYs
IGNkLCBmcCA9IDA7DQo+ICsJdW5zaWduZWQgaW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1b3Qs
IGRpdiwgY2QsIGZwID0gMDsNCj4gKwl1bnNpZ25lZCBpbnQgYmF1ZCwgYWN0dWFsX2JhdWQsIGdj
bGtfcmF0ZTsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+ICAJLyogc2F2ZSB0aGUgY3VycmVudCBtb2Rl
IHJlZ2lzdGVyICovDQo+ICAJbW9kZSA9IG9sZF9tb2RlID0gYXRtZWxfdWFydF9yZWFkbChwb3J0
LCBBVE1FTF9VU19NUik7DQo+IEBAIC0yMzA1LDYgKzIzMTYsNDUgQEAgc3RhdGljIHZvaWQgYXRt
ZWxfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwNCj4gIAkJY2QgPSBtaW5fdCh1
bnNpZ25lZCBpbnQsIGNkLCBBVE1FTF9VU19DRCk7DQo+ICAJfQ0KPiAgDQo+ICsJLyoNCj4gKwkg
KiBJZiB0aGVyZSBpcyBubyBGcmFjdGlvbmFsIFBhcnQsIHRoZXJlIGlzIGEgaGlnaCBjaGFuY2Ug
dGhhdA0KPiArCSAqIHdlIG1heSBiZSBhYmxlIHRvIGdlbmVyYXRlIGEgYmF1ZHJhdGUgY2xvc2Vy
IHRvIHRoZSBkZXNpcmVkIG9uZQ0KPiArCSAqIGlmIHdlIHVzZSB0aGUgR0NMSyBhcyB0aGUgY2xv
Y2sgc291cmNlIGRyaXZpbmcgdGhlIGJhdWRyYXRlDQo+ICsJICogZ2VuZXJhdG9yLg0KPiArCSAq
Lw0KPiArCWlmICghYXRtZWxfcG9ydC0+aGFzX2ZyYWNfYmF1ZHJhdGUpIHsNCj4gKwkJaWYgKF9f
Y2xrX2lzX2VuYWJsZWQoYXRtZWxfcG9ydC0+Z2NsaykpDQo+ICsJCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoYXRtZWxfcG9ydC0+Z2Nsayk7DQo+ICsJCWdjbGtfcmF0ZSA9IGNsa19yb3VuZF9yYXRl
KGF0bWVsX3BvcnQtPmdjbGssIDE2ICogYmF1ZCk7DQo+ICsJCWFjdHVhbF9iYXVkID0gY2xrX2dl
dF9yYXRlKGF0bWVsX3BvcnQtPmNsaykgLyAoMTYgKiBjZCk7DQo+ICsJCWlmIChnY2xrX3JhdGUg
JiYgYWJzKGF0bWVsX2Vycm9yX3JhdGUoYmF1ZCwgYWN0dWFsX2JhdWQpKSA+DQo+ICsJCSAgICBh
YnMoYXRtZWxfZXJyb3JfcmF0ZShiYXVkLCBnY2xrX3JhdGUgLyAxNikpKSB7DQo+ICsJCQljbGtf
c2V0X3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywgMTYgKiBiYXVkKTsNCj4gKwkJCXJldCA9IGNsa19w
cmVwYXJlX2VuYWJsZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJ
Z290byBnY2xrX2ZhaWw7DQo+ICsNCj4gKwkJCWlmIChhdG1lbF9wb3J0LT5pc191c2FydCkgew0K
PiArCQkJCW1vZGUgJj0gfkFUTUVMX1VTX1VTQ0xLUzsNCj4gKwkJCQltb2RlIHw9IEFUTUVMX1VT
X1VTQ0xLU19HQ0xLOw0KPiArCQkJfSBlbHNlIHsNCj4gKwkJCQltb2RlIHw9IEFUTUVMX1VBX0JS
U1JDQ0s7DQo+ICsJCQl9DQo+ICsNCj4gKwkJCS8qDQo+ICsJCQkgKiBTZXQgdGhlIENsb2NrIERp
dmlzb3IgZm9yIEdDTEsgdG8gMS4NCj4gKwkJCSAqIFNpbmNlIHdlIHdlcmUgYWJsZSB0byBnZW5l
cmF0ZSB0aGUgc21hbGxlc3QNCj4gKwkJCSAqIG11bHRpcGxlIG9mIHRoZSBkZXNpcmVkIGJhdWRy
YXRlIHRpbWVzIDE2LA0KPiArCQkJICogdGhlbiB3ZSBzdXJlbHkgY2FuIGdlbmVyYXRlIGEgYmln
Z2VyIG11bHRpcGxlDQo+ICsJCQkgKiB3aXRoIHRoZSBleGFjdCBlcnJvciByYXRlIGZvciBhbiBl
cXVhbGx5IGluY3JlYXNlZA0KPiArCQkJICogQ0QuIFRodXMgbm8gbmVlZCB0byB0YWtlIGludG8g
YWNjb3VudA0KPiArCQkJICogYSBoaWdoZXIgdmFsdWUgZm9yIENELg0KPiArCQkJICovDQo+ICsJ
CQljZCA9IDE7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gK2djbGtfZmFpbDoNCj4gIAlxdW90ID0g
Y2QgfCBmcCA8PCBBVE1FTF9VU19GUF9PRkZTRVQ7DQo+ICANCj4gIAlpZiAoIShwb3J0LT5pc283
ODE2LmZsYWdzICYgU0VSX0lTTzc4MTZfRU5BQkxFRCkpDQo+IEBAIC0yOTAwLDYgKzI5NTAsMTIg
QEAgc3RhdGljIGludCBhdG1lbF9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycjsNCj4gIA0KPiArCWF0bWVsX3BvcnQt
PmdjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImdjbGsiKTsNCj4gKwlp
ZiAoSVNfRVJSKGF0bWVsX3BvcnQtPmdjbGspKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoYXRtZWxf
cG9ydC0+Z2Nsayk7DQo+ICsJCWdvdG8gZXJyX2Nsa19kaXNhYmxlX3VucHJlcGFyZTsNCj4gKwl9
DQo+ICsNCj4gIAlyZXQgPSBhdG1lbF9pbml0X3BvcnQoYXRtZWxfcG9ydCwgcGRldik7DQo+ICAJ
aWYgKHJldCkNCj4gIAkJZ290byBlcnJfY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5oIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2F0bWVsX3NlcmlhbC5oDQo+IGluZGV4IDJhNTI1YjU4ZTExYS4uMGZjYWRiZWFiYzZjIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmgNCj4gKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5oDQo+IEBAIC00OSw2ICs0OSw3IEBADQo+
ICAjZGVmaW5lCUFUTUVMX1VTX1VTQ0xLUwkJR0VOTUFTSyg1LCA0KQkvKiBDbG9jayBTZWxlY3Rp
b24gKi8NCj4gICNkZWZpbmUJCUFUTUVMX1VTX1VTQ0xLU19NQ0sJCSgwIDw8ICA0KQ0KPiAgI2Rl
ZmluZQkJQVRNRUxfVVNfVVNDTEtTX01DS19ESVY4CSgxIDw8ICA0KQ0KPiArI2RlZmluZQkJQVRN
RUxfVVNfVVNDTEtTX0dDTEsJCSgyIDw8ICA0KQ0KPiAgI2RlZmluZQkJQVRNRUxfVVNfVVNDTEtT
X1NDSwkJKDMgPDwgIDQpDQo+ICAjZGVmaW5lCUFUTUVMX1VBX0ZJTFRFUgkJQklUKDQpDQo+ICAj
ZGVmaW5lCUFUTUVMX1VTX0NIUkwJCUdFTk1BU0soNywgNikJLyogQ2hhcmFjdGVyIExlbmd0aCAq
Lw0KDQo=
