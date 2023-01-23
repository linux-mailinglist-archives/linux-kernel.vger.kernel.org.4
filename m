Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C8677A57
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjAWLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAWLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:48:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13B15C84
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674474525; x=1706010525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MqK+k1al8CIzRI41by3oaXUn/9kDU4MqvAJ4vBrzrvM=;
  b=IxqT05q2rDDGmWlAEZjq5uS/ftkQvZ5RBkKcYe9R4LFgb0lpUl1ThsFr
   3ODRQFRVLGsCElIoLMh1OlnssHG7nWE0qrXDAk5rik8OeArHvPsUOAsMy
   wVF9nGD1rrdIMUuUdvzKW0yJvF1H66/fwh6vk/n87e2GR9c3C9pkvABXA
   XR65YH3WF68NP40lEgSh7hnU0yzKrSjhznYgtuksWzzN2PdTwcV5Hlrkq
   9Clv5a1KLXDPMC0xnbvHtyTkv2N9fLuvoUVW24dmCgSs9xIU6b2oDbXxg
   kogkYdK+5EH0sgDJLdF24zyYY/bNeabFOgFB6F34DLVEZnurYi7BAujaG
   A==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669100400"; 
   d="scan'208";a="133562808"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2023 04:48:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 04:48:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 04:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfUWO3GKrTR8pjAY7H2SN0vDs2K47tDr9Z09iopL1HhmUH39iFe6CWP8SF1YDmgpE2UbxRkPEIbbG/fRdtaOccQyVKtCg7nsjOY14nqocBbsH2WVU0okCcMc00qqs7kh1/qt36vFDH8TnxC71Aw905ugRDXEHy5bL9R7H4FAUsxhk33TAm9+aQPameRI6LCrqCi3PNf2pZSZ/2ZEpByzKU++dqjSiiGHSAcHt8gW5yyxnGDhr5clBRrdfiwtHkpd1AXKt1PVat+oxcei4JbJzwJbQ/uiujLG519TCsqUCFspAvSWPI8eF93aJmYmK4vBIFd4gCJh3enppa6NPdTpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqK+k1al8CIzRI41by3oaXUn/9kDU4MqvAJ4vBrzrvM=;
 b=EqEYz6FWGCP1O/106GwV1c/zPl9AUP2dfKV8y7NMwiZ+i/KINSnYllDEDY07BrF1YOy7bdoIeb2EjS4s9+pmTM+oZCYFG/TaC6FOTTcLnILSSyuUDBtJaP6xJQshPsujpTdgzkSOra00d87fQO4FMO9EgSemfqImBaICIbFYyyTOw0ZSND4tY/vcJ2BwGCOc2Yjvdu9O/GyGbDMRMOEHuY5t6xbOvp/nc4Dvdg/iIUfy2kamaQIcdLNb4SCz6qYMKqFTRHITpAMCRN0b/kmSiusy34vyvwqPCBRm4M7si1fP1ZG9w8Qs7w609+icYqAU+lqJl+CL5S9XWwbyE2f1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqK+k1al8CIzRI41by3oaXUn/9kDU4MqvAJ4vBrzrvM=;
 b=pQ+ROBNZ3FATkxU4rQjmuzmiM9uW4RCvqhlInuLUpTPc9ZboNDdJHg8WXa1GZT81dc/unfYMyhGRrurG6+rQ5AO03ILFRKvc9kOHR6Lm6bEvn+TOswTA8rsPBwQcfleOzZn8Nj+fHXfNnmOWw+FYeNy2gqLeKpzfEw9wVU9/0g0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 11:48:43 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3758:fd2d:5bd1:9758]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3758:fd2d:5bd1:9758%7]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 11:48:43 +0000
From:   <Conor.Dooley@microchip.com>
To:     <lchen@ambarella.com>, <me@linux.beauty>
CC:     <arnd@arndb.de>, <heiko@sntech.de>, <lkundrak@v3.sk>,
        <robert.jarzmik@free.fr>, <sven@svenpeter.dev>,
        <zhuyinbo@loongson.cn>, <briannorris@chromium.org>,
        <hasegawa-hitomi@fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/15] soc: add Ambarella driver
Thread-Topic: [PATCH 06/15] soc: add Ambarella driver
Thread-Index: AQHZLv3IyzxhA+fjH0GH7s70/n+1xK6r4zOA
Date:   Mon, 23 Jan 2023 11:48:42 +0000
Message-ID: <bc50c6c2-bdfb-0b6c-0f89-dc8cfe845202@microchip.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-7-lchen@ambarella.com>
In-Reply-To: <20230123073305.149940-7-lchen@ambarella.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SA0PR11MB4718:EE_
x-ms-office365-filtering-correlation-id: d54f3fb5-c7bb-43e8-e653-08dafd37c6dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsE2Zqd2kv0fMsX68y9XKNf6yBzocdyLgLa8NI7WZHyVek4s+c/eMhYDwdkg0GEnSfJ2K4O7v4k8nZskY0Rq9qSBJSl30ifmTCgTPcntCGGaUeN+a3k1jTLDo0fnnItsD/wWg5jB8uysEpH9Q6KbAMblLoQ4yUzB1mVYAkJuVFDi3BI71CtwjffyvFt3mfY0JCpUG/T266CJHM+AYJKaoL5Kc4X+ermUd/QX7LonFMLAE+d2ZLq8UClB/T2PymNFhDzDtryDvC4NMomVZglRxxLMRb+edRhjKDOjTY3GRaJ0Lcj9bcpqZQ8QSte81hnNjjJloOTKD+xCd7YumwXvouxNPceYIqsvfb0M4wHUr4NciV3g/5IQkub+OF2pIDI44QoqpZtzE3VXdoDj9aVozxfJQDVdJr5P/uI1e87y2oCqgBSYHpufE64sVrcwLUS2/jKAMcSgv2fRoyhxxoz18f73PuRzW81mpl8aHxh/A/VUjmH1F+PSZy7BBKvmDgbZh5Vv3k9rnDHWu9r93XufF+Ds8d1ZOvB9p8w+TMTjiwMtHC0dicEj3ej+Ix4ITrPEIvlBA0kU4x01m9hibPi/MfMV22JsncLLfLOuA+G4d2ulRupOXlZ7NW0atX28LXw8sTxHZHUsVnhM5V9bWnIw0Pj83LGUGYcQ+dqCSxO7eifFIMvCKHjTdoznDzg/p8agXUKu9rq9I0GbKJ1ztihwQkU5y3tD4rIzwHw3ItE3LJz6TuoPtfW/EKdbNB3xbu7GgtRP7QO0RxYbgXo+mqOW1ht71SE5sTHXkEUwGKmkxEo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36756003)(38070700005)(2906002)(5660300002)(7416002)(38100700002)(8936002)(4326008)(41300700001)(122000001)(83380400001)(86362001)(31696002)(66446008)(71200400001)(478600001)(110136005)(6486002)(91956017)(31686004)(66476007)(8676002)(6512007)(53546011)(26005)(186003)(6506007)(316002)(54906003)(2616005)(66946007)(76116006)(64756008)(66556008)(41080700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1BFaUlnYUVvaUp4M24yUW9ZcGp4TS95T01WWmM1dUY1YURVYWxUWllWQU9l?=
 =?utf-8?B?UWd2KzFDVGxPN09ZVVRBeGNneGhza1pMR1p6MU5iTXFZaWt1bDNacGRmblRL?=
 =?utf-8?B?ZlBOdkpxV2h5dGU4N2VtTXY2aVU0NVdnZnNRNkwvL1VJdE9Mbk8yL3VyaXRF?=
 =?utf-8?B?eFJHQ2g2WkNxQklmZ2xzeHcrWUtXd3FvVnh2Ni9PZFhURVZQNkQ0QWw4cE9u?=
 =?utf-8?B?Z1ZrVUdhWGpmZzh5WVF3VHA2THJnd1pjb1lNdjVSbXdTVktwRW1OWmU4UGR1?=
 =?utf-8?B?ejFBMGRTeTNVSWhIdm53VU9TVHk3eHpZWHZkbWVVelo4QnpYU3c2WDR2Smo0?=
 =?utf-8?B?cVpRUjBHQkF0Mm5JaEVRVjVTM2dBMkNUTkF1ME9sVmgvRnFtTFdYTTY0N0hZ?=
 =?utf-8?B?RVRJZE9iQlNpb0ZhbXlMTFBnYXBNVFhRODNMUVM2b2RQcHhnYWN5ZlNHRXVG?=
 =?utf-8?B?clgzZFk4VSsrMi9TSE1VOW1hK1lreXdsVFVMSWRjekNPK3ROamkxSytEZU1x?=
 =?utf-8?B?R2lPYnByakxJWXgrVWdwQ0Q5ditpeVNhL0RKMFQ0S1MzTVR0a3g0RHBPekxy?=
 =?utf-8?B?cXJUWDRYbGlCSzJUUHhtTlpUcXR6VlN2QXUweGJxK2RWeDN2eGlYUXovcWxv?=
 =?utf-8?B?SkEzZXdHem1HMVRFdzc1RU1wRHdpOENmS3lZU1g0aEZ1RE96dUs4SWdQVklO?=
 =?utf-8?B?TmgwUDhQaVpXY2JmeGx4Qlk4cmw0WE1Ka2xRNDVsYngrdU05dnJNTmdEOHow?=
 =?utf-8?B?RlRsaUw0aHBDSFFNUTFVcHdENkl3bUwya3lGWHJESmk1bmczNlVqbWFMcnpY?=
 =?utf-8?B?RmRMSkZBMWdkUFZuTXdxbVk5Wk1VZlh5R3dySURpY0ZOeHBGd2h2SkVkMDBI?=
 =?utf-8?B?YU0xUlpRZ1BvZTd2eC96elhVOUxzdk14bEpMUVFIT1dDRnllRHZYcUZNS2Rz?=
 =?utf-8?B?bjVTZ2lUNmZ5RGg3M3A4QzhUSStkZjcwdzZLZFlmbkxjTk9VTXdmN2RDZ2dX?=
 =?utf-8?B?RDhqMTN5ZzNVVWpkQyt4bkd2TFY0ZGcwV0VJT0phOEJ1dUFnc1Z0WHJmU2w5?=
 =?utf-8?B?UDFvdmthNVpnR1dwYTVjSHNNa3VFTFhQdDhQWXBqaGJYaGhBc0N1UnRXV1VN?=
 =?utf-8?B?dGZSN2xIOTF1N0pHL0lVRitDL0RXTmYybUV5RmwwZTZ5Y29qYXpNMUZDMGta?=
 =?utf-8?B?Q01ZQnNZdlFyb0NOMnliQ0ZQN1plalpmSHJmSlFkaEM2VXBXOUwwdmRlUElB?=
 =?utf-8?B?ZE9jcGNvUHZ3bnByY1NDT3V2SEtlOFhrYjh0bkRSRVV5eG1Na0VYQndHM2dk?=
 =?utf-8?B?SEpqT3A2SFNGNmZadVdRR0xtWVBPbFl2V0NrSXJnQ2RGWmttZnBSeFdUWUkw?=
 =?utf-8?B?YWVRVG9mZEtHTWRUWGFRQndRMy9CT0pXaVE5cjVYc1ZEWjczTHlOdjM5MHRs?=
 =?utf-8?B?RFptTTZUU1d3SmFFNENpUW9lcFF6VitTMlFVVGNwOW9PNU1ZWlkvQkdaSzVt?=
 =?utf-8?B?WVg0Zk4rNnpMYkJLY2dOUjIzcHRmenFmeTdURitLN1NLMmFET1VtdlV4c1VO?=
 =?utf-8?B?bkIraU0wUlpvWGp1R21jN05ZWW1BdTV1TXFMeW1FTmhVZW1kTVV1akRyZktl?=
 =?utf-8?B?VXhkOVhKSHJEdERIM2Rmd2xDYTMwemxQZlVzWlZobzRFOWhpdEd5S2RkQ3d1?=
 =?utf-8?B?TEkvL3RneTlzalNTWjFuT1ZiTEZpMDlnYVRQaCtOUHRSa2ozRUlHenZ2UnJM?=
 =?utf-8?B?Wkh4R2RQQ3JxMDZ4VVFpbXN3eDU4eGJKaUV0QU80dUtGOHp6c1lGTmpqSEEv?=
 =?utf-8?B?bFhUUnFLeE56UDUrSXl6eU40K3daZ01VWDN0S2dLbVdrdHQ1WlBkRThwUUJG?=
 =?utf-8?B?d0IwS25QeDBLVXh5ZlJDVmQ5VnZZRTQwV2g5ODVHSTl0a3dVcTZYN2MxWS8y?=
 =?utf-8?B?MytOYTRlamJGVTlNWGRDQUZwcWlYYWo5dFFIZVJ3VmhsY2x4bnJWVU1SWUlV?=
 =?utf-8?B?Z2hLSzc0MisydnZidWJweE91RWc5Ui9kd0JEMllQdjd1Q3NoZXI0VElVWTR0?=
 =?utf-8?B?VlVsdjNSV0FtZHhPQ0gvTCtHOXdWZ0t2UVh5MysvUzJHNUs2OWE3akZjWFBL?=
 =?utf-8?Q?zNn1sfXCCrOOflweWVdp/TEhX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75407D7E8B0A064AAABFFD64E26133F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54f3fb5-c7bb-43e8-e653-08dafd37c6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 11:48:42.7649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxIaEWc7n1ai+IQicA4d6yIoTTn/DBiV9XO6KczypcOT8mNVyBmbgjpYR8MCiMHwB2J0bsxGl3NyKTxsIMQiWMUglxXwd9dBEToA7Sxp9og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IExpIENoZW4sDQoNClNpbmNlIHlvdSd2ZSBhbHJlYWR5IGdvdCBhIGJ1bmNoIG9mIG90aGVy
IGNvbW1lbnRzLCBJIGhhdmUNCnR3byBtaW5vciBvbmVzIGZvciB5b3UuDQoNCk9uIDIzLzAxLzIw
MjMgMDc6MzIsIExpIENoZW4gd3JvdGU6DQo+IA0KPiBUaGlzIGRyaXZlciBhZGQgc29jX2lkIHN1
cHBvcnQgZm9yIEFtYmFyZWxsYSwNCj4gd2hpY2ggaXMgc3RvcmVkIGluc2lkZSAiY3B1aWQiIEFY
SSBhZGRyZXNzIG1hcHBpbmcuDQo+IA0KPiBBbHNvIHByb3ZpZGUgc3lzX2NvbmZpZyhQT0MsIGFr
YSBwb3dlciBvbiBjb25maWd1cmF0aW9uKQ0KPiBmb3Igb3RoZXIgZHJpdmVycy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IExpIENoZW4gPGxjaGVuQGFtYmFyZWxsYS5jb20+DQo+IENoYW5nZS1JZDog
STQ4NjlhMzQ5NzM2NmFjNzc3OWU3OTI4MzVmOGUwMzA5MjM5MDM2YTgNCj4gLS0tDQoNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL01ha2VmaWxlIGIvZHJpdmVycy9zb2MvTWFrZWZpbGUNCj4g
aW5kZXggZmZmNTEzYmQ1MjJkLi5lM2UyNzBhYTMyYTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
c29jL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvc29jL01ha2VmaWxlDQo+IEBAIC04LDYgKzgs
NyBAQCBvYmoteSAgICAgICAgICAgICAgICAgICAgICAgICAgICs9IGFwcGxlLw0KPiAgIG9iai15
ICAgICAgICAgICAgICAgICAgICAgICAgICArPSBhc3BlZWQvDQo+ICAgb2JqLSQoQ09ORklHX0FS
Q0hfQVQ5MSkgICAgICAgICAgICAgICAgKz0gYXRtZWwvDQo+ICAgb2JqLXkgICAgICAgICAgICAg
ICAgICAgICAgICAgICs9IGJjbS8NCj4gK29iai0kKENPTkZJR19BUkNIX0FNQkFSRUxMQSkgICAr
PSBhbWJhcmVsbGEvDQo+ICAgb2JqLSQoQ09ORklHX1NPQ19DQU5BQU4pICAgICAgICs9IGNhbmFh
bi8NCg0KSWYgeW91IGNvdWxkIGZvbGxvdyB0aGUgZXhpc3RpbmcgKGJ5IGRpcmVjdG9yeSkgYWxw
aGFiZXRpY2FsDQpvcmRlciB0aGF0J2QgYmUgZ3JlYXQuDQoNCj4gICBvYmotJChDT05GSUdfQVJD
SF9ET1ZFKSAgICAgICAgICAgICAgICArPSBkb3ZlLw0KPiAgIG9iai0kKENPTkZJR19NQUNIX0RP
VkUpICAgICAgICAgICAgICAgICs9IGRvdmUvDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9h
bWJhcmVsbGEvTWFrZWZpbGUgYi9kcml2ZXJzL3NvYy9hbWJhcmVsbGEvTWFrZWZpbGUNCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4zODQyNzZjMDQ2Y2ENCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3NvYy9hbWJhcmVsbGEvTWFrZWZpbGUNCj4g
QEAgLTAsMCArMSwzIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkNCj4gKw0KPiArb2JqLSQoQ09ORklHX0FSQ0hfQU1CQVJFTExBKSArPSBzb2Mubw0KDQpUaGUg
c3ViZGlyZWN0b3J5IGlzIGFscmVhZHkgZ2F0ZWQgYnkgdGhpcyBzeW1ib2wsIHNvIGlzIHRoZXJl
IG11Y2ggcG9pbnQNCmdhdGluZyBpdCBvbiB0aGUgc2FtZSBvbmUgYWdhaW4/DQoNCg0K
