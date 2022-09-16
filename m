Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F35BA7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiIPIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:14:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F165838;
        Fri, 16 Sep 2022 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663316042; x=1694852042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d2xfpADX5IJA0NM8YH2RRq/YHXJmlOrZp7b4lRemt9s=;
  b=nLk6n9ARhWjpGtf+fqdBqymykXrYKfN6Hi0WAyxuVUwsSUgeLM0kqTX3
   YnORBmQ5BnAbdPJJs+1BadvfFp3w1buNGEjgXFXQXtkXZrGqGiU6Kh+nw
   gZHbmYuOLC/UFkzSJAPqs1OWI3G0Tg5lJIxWZzD3yNMDY5GXhFK/SBMkR
   oJ2GnltWwjeWEAbKzAtxo1b5v6vXKXprCXGabcMQW5CeTbDbt5Lm/69WE
   39IwkY/EqEN0kzqUfvP1XeFc6akdrtXyARByYXWpJYaaVeCIEyX3B99Op
   P2Qwq/jWylXb/LCjkK620PeDOGCAUB6kmW+5ExgRhBuVNTc+8NZpfr8Wv
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="180772329"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 01:14:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 01:14:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 01:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE6meWO2ZLhpBw+IomWZzIHTC7nNbo9RcvexVwWFVWI+iORqNEwC6wnFRATXgBYl0dFlaZ1KuCU6T7Io6hJmvZ5zKEP7hzS0X+1b2q5Cuyqx5YY0DfT+Pyvqktuho+1sVCE/ZN5yb4KAxtOSacY1dgW8WBegWRMCwj14xRH5S4A2EaK8JdpUHoMQ93wO3QXnr+I+veMl/PAU3yZGiwWaj0abNqIzjrarurGWp1fxrq4oEgqL2QveEIiUbqSGuYSc5eMMeSsm0kV6Ue6oJ2OFs82Wm7TZr3oc1cafIZyjc3rc5IEe8Ixnztz+wmOVPzW46IxF3cb92n785tztujyfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2xfpADX5IJA0NM8YH2RRq/YHXJmlOrZp7b4lRemt9s=;
 b=QSm2QxvczWtZtJZfAkdbjVAxbSsKxzATpFrSKv33sHHsU/C7BQ0FQ1ZTj0qSWKYL3SC2+Nu11ALoVTxqp33nQYLdh8HzME1NIXDSHeO3/6BHfVrKfCDMatowAgvdW90ZCJsobpYSjGc/h00+1e9vTwXYD5MVanlDzzbEA726Ka1SdXKhl3ddTcU5J8OMPW0FTM46Z9nLkeHf6cPMs8BD8IKBmsiqrI0kXswlVlt4/So1cOXmEiFBTab5i3E3gx59WznStgeNsTlhc1+HHpFt10t5CE2KBEdXW+gn2gSwL4un+OmQH7q2CRW95bjerF3x/UUkMvYnxoJQcKHd3Y50jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2xfpADX5IJA0NM8YH2RRq/YHXJmlOrZp7b4lRemt9s=;
 b=mneaCqOs061IOJ5iIz1hwqEThdnpx92rDwutmURr5hQKu1Nanu7HKrj3Azh1c5egOV/bcrZmj+H4uecxXq0I7XBSkGnMnfKOKq9ofXj1omMnNk7BUpEMy0dJgZQL0jOphIJVJZ6kFPV3Gnsu+cqK2tUYY98wo1TIJ4fbxREeC8I=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 08:13:56 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::25b7:6f88:f38c:a675]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::25b7:6f88:f38c:a675%4]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 08:13:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 01/14] ARM: dts: at91: sama7g5: Swap rx and tx for
 spi11
Thread-Topic: [PATCH v3 01/14] ARM: dts: at91: sama7g5: Swap rx and tx for
 spi11
Thread-Index: AQHYyaREnjOanbrhB0uo6LM3SKc+eQ==
Date:   Fri, 16 Sep 2022 08:13:56 +0000
Message-ID: <b537bbcf-cb0f-551d-6dd0-cf50864bafa3@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
 <20220913142205.162399-2-sergiu.moga@microchip.com>
In-Reply-To: <20220913142205.162399-2-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1960:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: a574cbbe-c128-419c-4e59-08da97bb6692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Spln2nbcRxk88Vdbjt69MMHewaEU3aQ/1gu7LZh8EJ4iDwXtrKwsegGWE1LVTBWl6nrNRZ4qlqxpUGPiLknQ31xgRuTrfun82qFDb1C+M0gt95izhbJJeDGZc1zpTk4+t/t5MYExzdcmnLxNZZ0R6935IkNHnjwiwoG25RNEeHRclmVSPOAdfJmfSDi8TO/fyTt7RxvQiAzCVhZhFeklZygw3uZ2RALGBLqq8Tu6xOASsoOUWOVv9dCMVoeHDom2Zo+kCywj/Pg7Os1+43aHpqPrXXAKbESaapf+0WOZZZ8B2k5joTSJ/zsd6fSQOYhuVRSjwoFISQMUgZ8wqkpmwDCuVHqWhmCKNTYuxHB7SsiZBiIF8uRfBp2VYzRR+xOHRdLc/6iKLzFOeISUqtybpGvvxvsOZBym9bdrnYch8Z8SpPBQU551s9ICy0J+/NAvTe8Hrtqio/7+HZE0sDVryxRjwDGdB6tvMsmKCa1gj06Mx9M6Tub7rMXS+yt0eenPU7zvWOwP3fmx3lwwpi+pQR0UinpH8jfhKuW2KSe9ocdfS3XajLrFLCiKWVKvycJQXhRBbtlT5Pqh3oNT9QcDVQ6lXFMZp5f1q7cbHLyz2lbLKp4aA8AYIZtgVMoyHldt2cdC2NmYacpqkSX8epLSN/H6UMOicV2Itsa1+YCUfSLHwzxxKhccR26/YL4dAH95HZegPVIy9iG/G7MNahI9rhxOt4CYPDNAlEmKfLscwpI5t1mkdOKFAt7AaYlYDkjTdrA0QEFIMijhl5xqo5aCjwYMe50iFM9AngQoUpBNPJLkLmLmE89T7ZMzXuiXaCOk1uWGiaU/rMDhjAHAlw1TbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(66476007)(7416002)(71200400001)(66446008)(41300700001)(316002)(66556008)(26005)(122000001)(31686004)(110136005)(66946007)(4326008)(76116006)(91956017)(31696002)(5660300002)(86362001)(8936002)(54906003)(36756003)(8676002)(2906002)(6506007)(478600001)(921005)(186003)(64756008)(38100700002)(2616005)(83380400001)(6636002)(6486002)(38070700005)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnAvaWMvd0pXTmw2V09yY25tT3hwS2NJbnJuNjJFV2UxOXRHdW91Q3A4OTl6?=
 =?utf-8?B?b1RRYnV4OURKdlNDc3JmL25rTWV5N2hNVHZId1lTejJISXdyVXhYZEtZQkEv?=
 =?utf-8?B?TnRBS2JQcHRZM1pMRm9pdXRPYXZzNzg3eGRjcDRTeVc4Z1ZJQ0tmMUVUcGFj?=
 =?utf-8?B?QTlLV3h2allMNmFjUHRFTzd2UllEaS9sUUViSjVLUTc0RUVuTHdEUG1ocWpI?=
 =?utf-8?B?bjRZNTB2NzJtUEJLQ2xCd2kvalRBZWN2cnIzNTdUbzAzdXBhRlBmWXVSY2NN?=
 =?utf-8?B?WWVsK0V2bU1BdGV6SnpKeFF1RzNaTXdaeWZyQzVhVWFHUDlTZE11VzZWK08r?=
 =?utf-8?B?SERHeHBUekh6RVFjb0ljWTJQbVg2eTB4NGsvaVkySHN6MERrTWRlaWxNYVUx?=
 =?utf-8?B?V2E5VXo2RHpxSE5SY1h6R3hxZmI2Rm9OOFZnUzlNZ3RQcHZWYnoyL1VSYmlj?=
 =?utf-8?B?OHNmWS9NdDBURFZZcnNaV2haaUZWWDhHUHpSU2p1RDZ1Y0dpUTNBTm9TQmt0?=
 =?utf-8?B?MmVZSXNQZlN5MlJQWkJobHdZcG9lOVJoVnBxVVBuZVlScSttM3pLNFRtQnYx?=
 =?utf-8?B?bWljYjMzVEM3SHR4ZXI2bHM0eDhzMUhaVnJsVjJ2Z0JtTCszWm1HKytaSlRP?=
 =?utf-8?B?Nlk5U0drV2s3MkRLelpSb0d5MjFGNmk5bEhzVFBaVDlyK1BMREh2TmZmODBz?=
 =?utf-8?B?eVBRcTJ6Sm5QTGVWeldYRzc5VnpXS1FlWGVoRzhvV1krUEpZN3hKK2xwcnkx?=
 =?utf-8?B?NVg4cjRPaWRQeTM4UGJONzhMTmk1R3cwRVZvQTdzRDJpeWlxUFRqWE9yQzhK?=
 =?utf-8?B?c1BJWGljOUFWUWdqOTZsam53VG5zQkNRY0EycytrYTFScndxQ2l0WjFMdVkr?=
 =?utf-8?B?Rm1IS2dSRVl2TWp0c2RUQzFXUXA0Z3pHeStPZGc1U1VvYVJseU1pY25MaGZD?=
 =?utf-8?B?QmQyNUpDNGJxSWZGUWJ5czAyV2J3VmtPNUszM2dwRU9yYnZTRHFiTFREd3VX?=
 =?utf-8?B?LzkxMXFPbERNcEVxVTVSbVpBV1ozUjkvZXFXaTJJTU4vV285RXhaMFA3cTVD?=
 =?utf-8?B?ckRUbGdFclpDK2xJS1htVGthUVR2d2dKTUNHVkxzSzgvOVRYWm52WEo5YzZo?=
 =?utf-8?B?QkY0dU42QUI0OVFRM21NM1VxSXZYMUc2VSs3WG9FSVdCUmlyRnZPSnhibUp4?=
 =?utf-8?B?NlhyRkU0MVR4Ry9JT2V3YmprczJ0NkdMSVpqR0R2Y1FkemxLcEt1ZXhTYVZK?=
 =?utf-8?B?aDVzMlc5VXVkRk5vYkJqM3VFVGRSc2RxVnhXTVE0eEIxSmY0NmFCK3dpbnhJ?=
 =?utf-8?B?THQyTFJOS2oxTDRjN2xuaTRSdm5FdFdhWVVuVVF0aG1uYTdnMkVpQzJFdk1J?=
 =?utf-8?B?SVJzTm1mUHpoSVJmTnRLUUdYbGNtMnU0cXNvVURSSGNuVU9hZU9LeXlqMmR1?=
 =?utf-8?B?ZWw2NHp1WjF4MXREcXRlZlBDcS9Yc3NKQVlDUWVmOExTUDZqelQ1RkJQaUZW?=
 =?utf-8?B?OW5iK0RaUTkyN1V3MHhkUEdPSlFxay9JVnV6ZGdrR0loa3NUQkNvOVBUNE9p?=
 =?utf-8?B?TExhS2R3dHBsQkh5TWlIa2EzeXg2TG5ZR1JBV1FuOGo1NnlIb0NySXVnbGNW?=
 =?utf-8?B?Z1hlZFF5bkJWMlBSUFZEZ0RKYmJVVkU1MnlKNFFiM0lQTDRqMkRBL1F3V3lR?=
 =?utf-8?B?MXBQSmhKQ0NhTE41LzVqY3Z2TzRIS0k0eGhFR1BWNHp2YU9pd3p5Vmcxa1lL?=
 =?utf-8?B?ekw5dXV0WStEVVI1UkFZSUt0WUtlVzFqVTV6bHhoV1FQZm9KdEgwekVBaTNv?=
 =?utf-8?B?Y1lndEdHTURhQ3dzMDh6MGJLMVNlbVBJR0dlNXNVUW9TaGdnTWVkdVo5SjFn?=
 =?utf-8?B?ZjN4Ny9JbjZvSEF1aTZkRGJEUXBLN0l6clQxQVdodjhhT2g5R3pZK2dKOStp?=
 =?utf-8?B?cDI5REJ0bzFjSVEvNWF3dWE5bjh4UlU5eXNxT0hYMlNmaGxZWC9DWDFVVFBZ?=
 =?utf-8?B?OWtEemN2ckg0NnlSTFQ2cXdrUHlqaVZNV2R5alNJZW0vYlhnNmU3cGdmMCt0?=
 =?utf-8?B?Tk5lR0NGbzhmazRzRTQvckFvNnFFc1lPVnpvVXdNUW9rVlpxK2xYdk1LbElU?=
 =?utf-8?B?cUYzSCtJdDdHTVNXcUhnaEpHUWxTa3psNzV4aS8vbjI3RkxnRDVYT1o1L05n?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B14148C00D4D184086D522ACBBDAC795@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a574cbbe-c128-419c-4e59-08da97bb6692
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 08:13:56.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtN1Y1bOPLELRcJI9phQjZdKyQmDWC7lxB9wdIhGtb0j8gUOvJHXVQqrrLSWyrdqLrV3oxgsQpK9kzIT18ILQwBGj4AHN++5o62D7xfEMsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMiAxNzoyMSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFN3YXAgdGhlIHJ4IGFu
ZCB0eCBvZiB0aGUgRE1BIHJlbGF0ZWQgRFQgcHJvcGVydGllcyBvZiB0aGUgc3BpMTEgbm9kZQ0K
PiBpbiBvcmRlciB0byBtYWludGFpbiBjb25zaXN0ZW5jeSBhY3Jvc3MgTWljcm9jaGlwL0F0bWVs
IFNvQyBmaWxlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9n
YUBtaWNyb2NoaXAuY29tPg0KDQpBcHBsaWVkIHRvIGF0OTEtZHQsIHRoYW5rcyENCg0KPiAtLS0N
Cj4gDQo+IA0KPiB2MSAtPiB2MjoNCj4gLSBOb3RoaW5nLCB0aGlzIHBhdGNoIHdhcyBub3QgaGVy
ZSBiZWZvcmUNCj4gDQo+IA0KPiB2MiAtPiB2MzoNCj4gLSBOb3RoaW5nLCB0aGlzIHdhcyBwcmV2
aW91c2x5IFtQQVRDSCAyXQ0KPiANCj4gDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdn
NS5kdHNpIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdn
NS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+IGluZGV4IGJiNmQ3MWU2
ZGZlYi4uMjQ5ZjljNjQwYjZjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW1h
N2c1LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+IEBAIC04
NjYsOSArODY2LDkgQEAgc3BpMTE6IHNwaUA0MDAgew0KPiAgCQkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiAgCQkJCSNzaXplLWNlbGxzID0gPDA+Ow0KPiAgCQkJCWF0bWVsLGZpZm8tc2l6ZSA9
IDwzMj47DQo+IC0JCQkJZG1hcyA9IDwmZG1hMCBBVDkxX1hETUFDX0RUX1BFUklEKDI3KT4sDQo+
IC0JCQkJCSAgICA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgyOCk+Ow0KPiAtCQkJCWRtYS1u
YW1lcyA9ICJyeCIsICJ0eCI7DQo+ICsJCQkJZG1hcyA9IDwmZG1hMCBBVDkxX1hETUFDX0RUX1BF
UklEKDI4KT4sDQo+ICsJCQkJCSAgICA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgyNyk+Ow0K
PiArCQkJCWRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gIAkJCX07DQo+ICAJCX07DQoNCg==
