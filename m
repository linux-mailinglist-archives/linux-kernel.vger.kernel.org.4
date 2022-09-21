Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591075BF646
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIUG13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUG1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:27:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562C80492;
        Tue, 20 Sep 2022 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663741637; x=1695277637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/38KoVazaiGsUqsD29YeWibjaoBOm2oWuJM65KJMU2o=;
  b=CDIwzQVs6+N5U3ThHudMUi6e6cBycbXcHxzUuI8bUPesN03dLdd/NAvG
   ULpaqdeyErKfPzBcXth9dGourFoT+GFbUJwsHJctAwhxoS+rBfsEamnL3
   7NjHVNNtZujdxQbZNU4RRySvYyqtYBPXKgSpnCcN1dVXuI1ZmQhwPl8CO
   3n+IpFRPZVXlHJi6CoDvAXV/lEoSTKiuei95pgynwCZPLvPPRajzoWuoc
   bp+7dGci5a/wKuFtlcvLFbV94qSLQNPUk7skLx48nFyQuOAv4Gp65Vpf2
   L/aFie/cplP5NT0DHECkVcnf3Z80FkbCZRi8Lt15cmiGxzjWZkFTUCl8j
   A==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="181382347"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2022 23:27:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 23:27:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 20 Sep 2022 23:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0BCuVWe4jIFPyLDTTnoRHdYunpOWtE6PxYySxCS3iscPIqmNpdRgTVefIwM2UVP2o9at1Pm6bFc8rviDHZh2bhuqQUqW/M4qSoaykll5/2Q+zLc6J/wl4e8pyB9Zvhpj7i7GgFX+IiXn1/8yw326dVqQ75ahhyA64lEmJZXEHaVNywM5c771CkaQwqyCIY6rApXSwBKJEVDWzP/KTw6E0qq6cCGfEpmKQGX7Zrubo8zqKc4wzOCWOM26f2rszlgMoZgLZ7V7hCSKYBli3g/frGRIgkV0Ewbj5EfcyPvN+fvKZ9BU8mak/EVlaNaCgdSCafLiPJ0rwCz4Y/vgnwnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/38KoVazaiGsUqsD29YeWibjaoBOm2oWuJM65KJMU2o=;
 b=X2m3A87SxaREEUwjk8wQENRjLCQVqyMAGauawRujhnfNldduaWYOkXrFHg/BrjaiO3P8zvl8mQWoqG9Orvt3bDPaEOgVUT7cYMsku+xo5SzmI7GSbu9WlvhX/tXoW4Skaza2vSiuENpp2XTG3pArcFEx0N2fvPzLA234txOp6VjjehnUebLHs7aOxOybfTtKKWqF2hINJCapK5SJ5Boih9TVnywtT0KY0WlnI3eV2KDA8b82/Jcq0PRp/ebd/jMJn8hqzkAPmSqRnR9B51kB9/nQsi4b0EsdapOBIEfHhIVxCrU4slx0ZUHo+zfGiXwR7IdsYR+Fe7E1ME4pxvQYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/38KoVazaiGsUqsD29YeWibjaoBOm2oWuJM65KJMU2o=;
 b=LsxrEQYGc1DJJb6C8H1ppAYsUd5msRAJfieIFa2cn5VzlXdsyUOzr3+s/rpQJs51/z+OeOhLwgBa3iNFZnbl0/w4noZ9xbp+BA+xe8qnuGL6jIqRRKdTXLHEi2dzqHoT8oCrXQY77HBs1kZT/aIGaUspWEZipokNrNFdmtQejog=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 06:27:10 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5654.016; Wed, 21 Sep
 2022 06:27:10 +0000
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
Subject: Re: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Index: AQHYzX4orIW/D8J/FEGjyCLG2o41r63pa16A
Date:   Wed, 21 Sep 2022 06:27:10 +0000
Message-ID: <2894e7db-78b1-59ee-ad5f-e45c8597e9cf@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
 <20220919150846.1148783-10-sergiu.moga@microchip.com>
 <342f5733-25df-9409-2a15-47b3f801a4a7@microchip.com>
In-Reply-To: <342f5733-25df-9409-2a15-47b3f801a4a7@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB6694:EE_
x-ms-office365-filtering-correlation-id: 6975c1b6-ec23-46c3-c95c-08da9b9a5079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQYA+RHLQJtWmyfjy0fbFvlN1r7zRF2ZxDV133tFaz7xtzIZptOVIE7i6mrm7zyDxnniBwhO4YvaWrk5oq7RA1AAMjSL+Flo4pwERIk2ibrMyUoYg9Mw5pXV9t5wmQ3Pjo9VOf1hWyD4td/OaKEmqQZ8BmYdhZPQDJ9ZSMWcKwM9IM22cUAG1jfA96LaBIShx7yJbUj/J5uPLdLiosjkacjTwNJRZbUCmGb0P1QmUk0B596woc1qE19fTw5/6v7lQmCBDHrVH+fpUo35hCbAArF2j1HZhCUQLFAw6cOKvgTjUjPL0RENcCklZju6loYg0jhl6svkQU3IsLd/1nxAQmD6xYNsoShjfLS9mDYeCloDwQnIvxkFCoFIf0Usk8NhkQcoOCsXzNQWJRgMa9EyvwWL4rMVwwgklAFCK+fvVDnTaZF+jodtTJEaaR3/pF/8vAzATPfZcCcS3UvQW8oJ67Q3fUyTD0FlRG7tqkGNLDh8sqJDpdLy0JAInY67aGVU1Hc9KpweysqCe8uZG9NNOJeu3inYDx176sE9a8qevfBF+ikQGIIkDCTiX4jEJsWfFVsCQeRyty65T3YTymMKgWrzDW/eSs38NWzxbzqW9mwSKmj/q4xa1JB4kzfEQhCjniaNYAn0FraKq5c1RnmMluYvo8zMQUMCOz41XqaXBktD2zl8+Vnf657zDBO0XisG0hlLhpIVwwvOh8rfupfFpSNMvM1BtUvuQXrcp4kTLGCU47Qr5gYs8rb9UwugGecoyAGzP/QJYGdZCG4CxG5bmIszVYBGAo5byQxRPE+NpM9UvjlOlOffvz7W8rk/H4riRirVeJzwgImqznyzL6J6Iy9seuGgb9ZBEhqcR8owEBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(76116006)(4326008)(7416002)(66476007)(66946007)(5660300002)(64756008)(54906003)(6636002)(91956017)(31696002)(66446008)(8676002)(316002)(122000001)(66556008)(38100700002)(6506007)(83380400001)(41300700001)(110136005)(53546011)(6486002)(71200400001)(86362001)(478600001)(921005)(186003)(26005)(2616005)(6512007)(38070700005)(8936002)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmVCbEVmY1RNYTg4KzB6ZWNRQTRvaDJJOEtaSTZHaTNmM3lsRFZnazRFU0sy?=
 =?utf-8?B?SEo4YzlVMTJ2aEJ5NmQ1VnZYWGNwUG53U1IrMkxMYXhYeFlqbFgwSWVFQkd2?=
 =?utf-8?B?cVZRTHkrTGtBNHkyRXBWNXhKNzYrcnhUNmhYL2FwNkdlL055K05KR1pHUnNa?=
 =?utf-8?B?TzRsczhGUW1qMjk0Slp1SEZYVmMwSDRmOSt5MmtlVVhWNU9OcDZVZEpPeUNx?=
 =?utf-8?B?MnhERUE2UlRXaU5mS0tvN1BMZWdadHZrQmUvUE9yaHVjYmU0V3FpVGF1L2Fy?=
 =?utf-8?B?NFBlalJiZ2RuZjV3UUg2YUNibjNyejhER3RvbWtwdElmRmRQN0JXME1TR0F5?=
 =?utf-8?B?Y2xzSjl2Wm0yV3pFcUdCQ1FPT3AyT3M4NmowV25sajFZUGNzQkZkOHhjQnl4?=
 =?utf-8?B?WWdLbURma3BlVmY3VDlVeW16eUFtdzUrL0ZJWEJIT2FwOVRoTVIxNWxZbUwr?=
 =?utf-8?B?dk50RzlHR0RIMWtJNHZiWExMTCtWVWdZbW9XYVEvSUZqTVJtWEdkTmRwK1h1?=
 =?utf-8?B?bzdnSUQ0OERjTE13ZVRDUkJweGo3elNWRFhSSHhvSkszbGl1NjNJQlg2cmZx?=
 =?utf-8?B?bWU5ZjRUSUNQeS9TbkY2N1gyZ3JVRHJRK2xTZXYyblpGM28xMENGY0g1dkQr?=
 =?utf-8?B?RHppbnlCK1AzclhQUWdhUGVKTlVlRXRGZXJrU2JuY1JIamZxbDc0T2FDd2Qr?=
 =?utf-8?B?TFg4MzBYMjNPeVRmNU42SlN6MmYzUGQ5OG9ENHM3V1lFSksrajhGajJ4b3pr?=
 =?utf-8?B?dzk0cFdPS3UrYTBTQmhkKzQvTjYzODE0TnRtdzcwMjV1engvY2srWXhBZ2ln?=
 =?utf-8?B?aUZyWE1hdVZQaysxemdkRDNsdEVUdzVjZmZENmU3TmQzTU5lQXdueHlCb2xT?=
 =?utf-8?B?SHlNMHNlM214MjZpYWVCZ2loa3JkRTJHTHNETlFoa1BHaURDZyszVklhUFpY?=
 =?utf-8?B?R1RDaW1IeG1jbFR5UUpZdGM5MHBFOVNRVDNYbm5DR05meWNvTkJvR3FEbW42?=
 =?utf-8?B?cG5GNG91VmdSNHBsd0p2WHRjOFBBNnNNak0yNnNxNTBwWEZYYlBjTGN4ZUhD?=
 =?utf-8?B?WlVqZDF3NXJEdlJWZXo5ZW5ITFhnYjIzRGNVRkFBQ0d1dnlYa0EvazRSOTJE?=
 =?utf-8?B?Q0R1NGtqc2UrOVpvbFM3WjBWblQwTDJwd0ROUmFtbjI2aHA2Y0gwVTVhRjZJ?=
 =?utf-8?B?RHo4MVpsQ1JXSTNwa0dUMkh2SWlPRGIveHNMd0I0OXFxRURESGtqVzBZcS85?=
 =?utf-8?B?U2ZEMElucFVUUW8xVFIyNzZiK3U1TVoyMFlSeTNVQ1A3MUJ4VWFLeWZxbVp3?=
 =?utf-8?B?VXVqaG1ZOWFpV2gwK2R0blhWOFpjOWh3eWZ6ZXJZNkhmZk5Sc2sxcTQvVUc1?=
 =?utf-8?B?eTFiVjVhNzB4NEE5UnFpSmN6ZlJKdXlRRW1DbC9qSEpTQU1MRHo3ejRGNFZM?=
 =?utf-8?B?Tzh2cHlBZ3lOTFBrL2lxMWpCVTI4UTB4c1BvVXY4Z1dOWmZUQWd5Z3EwbjVz?=
 =?utf-8?B?SktpcFA4RGxYbjVQbnp6V3hLb2NQN0RDZXpRYXF5OTBuVC9paHpPZ2plREha?=
 =?utf-8?B?Rm00a2FXODNGNXVVOW5GSTJ3UVg0eGVhMDViVVY0WjcraGVyM09oOXg1Yks1?=
 =?utf-8?B?NkFtbWZLUDZqc3ArZ1llcEdsWHdVdWNUbHRVQUYxUDlBK0M2TXEzSTFKM01s?=
 =?utf-8?B?NzRTd2R4emlEeVp3ZGRvVWp6T0Z6ZGRXbUx5aVZVb0JGcjFJa1JrbnppUVBX?=
 =?utf-8?B?eW4rZ282bUpZRW5UVWVubEg0bjNrT0dSMUJQSGdxV09DQmFMTE9LdEhBVkIy?=
 =?utf-8?B?cy9DQWZsNXZYT1BVdHZGa1ZJRzhYOURJVnprZXZuVkZhcWo5Uk0rWWpmMFRo?=
 =?utf-8?B?VVZKL2srVDg0WFRPUmdhU1d1NEx1QzNxNWw1YVFKajJRbDFKKzN1WkVIWlNV?=
 =?utf-8?B?RXhaV3VrQTBhVEgvT2JvdkYxT3pBYk0rbWhpdVFzSjBIZW9MS1ZINnlIMDdH?=
 =?utf-8?B?V2hMSWhvZFFyQUdOekpxanRQbHNtYjYwWmtta2pMalNQNkQ1VVpNc3FGS3dx?=
 =?utf-8?B?d1orb2xKemJFTG9IOVY5RnhGeG5VWG1jWHlLVUlISk1XSVNhMFp0ZmxnRDJh?=
 =?utf-8?B?N05MT3g1THU0ckNOd0RaaXJWZlBleEZBWUtnNUZ6RGJod3lKdEN3amxPb1FE?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E76C7F6E72CC844B04A69BC9D096B5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6975c1b6-ec23-46c3-c95c-08da9b9a5079
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 06:27:10.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPeNBn9ziqmj2OeRHqRMvKD5AwVX2O/WuCeNJ88qLlXmRUWPtG227/4M51GzXCduMLF9S4Q4prICASgpbvaPZ5NsX6UjadkVjw99BsVMDtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEuMDkuMjAyMiAwODo1MSwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDE5LjA5LjIwMjIgMTg6MDgsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4gUHJldmlvdXNseSwgdGhl
IGF0bWVsIHNlcmlhbCBkcml2ZXIgZGlkIG5vdCB0YWtlIGludG8gYWNjb3VudCB0aGUNCj4+IHBv
c3NpYmlsaXR5IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFz
IGl0cw0KPj4gYmF1ZHJhdGUgZ2VuZXJhdG9yLiBVbmxlc3MgdGhlcmUgaXMgYSBGcmFjdGlvbmFs
IFBhcnQgYXZhaWxhYmxlIHRvDQo+PiBpbmNyZWFzZSBhY2N1cmFjeSwgdGhlcmUgaXMgYSBoaWdo
IGNoYW5jZSB0aGF0IHdlIG1heSBiZSBhYmxlIHRvDQo+PiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNs
b3NlciB0byB0aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+PiBjbG9j
ayBzb3VyY2UuIE5vdywgZGVwZW5kaW5nIG9uIHRoZSBlcnJvciByYXRlIGJldHdlZW4NCj4+IHRo
ZSBkZXNpcmVkIGJhdWRyYXRlIGFuZCB0aGUgYWN0dWFsIGJhdWRyYXRlLCB0aGUgc2VyaWFsIGRy
aXZlciB3aWxsDQo+PiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMg
Y2xvY2sgbXVzdCBiZSBwcm92aWRlZA0KPj4gaW4gdGhlIERUIG5vZGUgb2YgdGhlIHNlcmlhbCB0
aGF0IG1heSBuZWVkIGEgbW9yZSBmbGV4aWJsZSBjbG9jayBzb3VyY2UuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBS
ZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQoNCkFjdHVhbGx5LCBJJ20gdGFraW5nIHRoaXMgYmFjayBhdCB0aGUgbW9tZW50Lg0KDQo+IA0K
PiANCj4+IC0tLQ0KPj4NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0gdGFrZSBpbnRvIGFjY291bnQg
dGhlIGRpZmZlcmVudCBwbGFjZW1lbnQgb2YgdGhlIGJhdWRyYXRlIGNsb2NrIHNvdXJjZQ0KPj4g
aW50byB0aGUgSVAncyBNb2RlIFJlZ2lzdGVyIChVU0FSVCB2cyBVQVJUKQ0KPj4gLSBkb24ndCBj
aGVjayBmb3IgYXRtZWxfcG9ydC0+Z2NsayAhPSBOVUxMDQo+PiAtIHVzZSBjbGtfcm91bmRfcmF0
ZSBpbnN0ZWFkIG9mIGNsa19zZXRfcmF0ZSArIGNsa19nZXRfcmF0ZQ0KPj4gLSByZW1vdmUgY2xr
X2Rpc2FibGVfdW5wcmVwYXJlIGZyb20gdGhlIGVuZCBvZiB0aGUgcHJvYmUgbWV0aG9kDQo+Pg0K
Pj4NCj4+DQo+PiB2MiAtPiB2MzoNCj4+IC0gYWRkIHRoZSBlcnJvciByYXRlIGNhbGN1bGF0aW9u
IGZ1bmN0aW9uIGFzIGFuIGlubGluZSBmdW5jdGlvbiBpbnN0ZWFkIG9mDQo+PiBhIG1hY3JvIGRl
ZmluaXRpb24NCj4+IC0gYWRkIGBnY2xrX2ZhaWxgIGdvdG8NCj4+IC0gcmVwbGFjZSBgZ290byBl
cnJgIHdpdGggYGdvdG8gZXJyX2Nsa19kaXNhYmxlX3VucHJlcGFyZTtgDQo+Pg0KPj4NCj4+DQo+
PiB2MyAtPiB2NDoNCj4+IC0gTm90aGluZywgdGhpcyB3YXMgcHJldmlvdXNseSBbUEFUQ0ggMTRd
DQo+Pg0KPj4NCj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCA1OSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkv
c2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5j
DQo+PiBpbmRleCBjOTgzNzk4YTRhYjIuLjQyNmY5ZDRmOWE1YSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPj4gKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2F0bWVsX3NlcmlhbC5jDQo+PiBAQCAtMTUsNiArMTUsNyBAQA0KPj4gICNpbmNsdWRlIDxs
aW51eC9pbml0Lmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L3NlcmlhbC5oPg0KPj4gICNpbmNsdWRl
IDxsaW51eC9jbGsuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+PiAg
I2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4NCj4+ICAjaW5jbHVkZSA8bGludXgvc3lzcnEuaD4N
Cj4+ICAjaW5jbHVkZSA8bGludXgvdHR5X2ZsaXAuaD4NCj4+IEBAIC0xMTAsNiArMTExLDcgQEAg
c3RydWN0IGF0bWVsX3VhcnRfY2hhciB7DQo+PiAgc3RydWN0IGF0bWVsX3VhcnRfcG9ydCB7DQo+
PiAgCXN0cnVjdCB1YXJ0X3BvcnQJdWFydDsJCS8qIHVhcnQgKi8NCj4+ICAJc3RydWN0IGNsawkJ
KmNsazsJCS8qIHVhcnQgY2xvY2sgKi8NCj4+ICsJc3RydWN0IGNsawkJKmdjbGs7CQkvKiB1YXJ0
IGdlbmVyaWMgY2xvY2sgKi8NCj4+ICAJaW50CQkJbWF5X3dha2V1cDsJLyogY2FjaGVkIHZhbHVl
IG9mIGRldmljZV9tYXlfd2FrZXVwIGZvciB0aW1lcyB3ZSBuZWVkIHRvIGRpc2FibGUgaXQgKi8N
Cj4+ICAJdTMyCQkJYmFja3VwX2ltcjsJLyogSU1SIHNhdmVkIGR1cmluZyBzdXNwZW5kICovDQo+
PiAgCWludAkJCWJyZWFrX2FjdGl2ZTsJLyogYnJlYWsgYmVpbmcgcmVjZWl2ZWQgKi8NCj4+IEBA
IC0yMjksNiArMjMxLDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IGF0bWVsX3VhcnRfaXNfaGFsZl9k
dXBsZXgoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4+ICAJCShwb3J0LT5pc283ODE2LmZsYWdz
ICYgU0VSX0lTTzc4MTZfRU5BQkxFRCk7DQo+PiAgfQ0KPj4gIA0KPj4gK3N0YXRpYyBpbmxpbmUg
aW50IGF0bWVsX2Vycm9yX3JhdGUoaW50IGRlc2lyZWRfdmFsdWUsIGludCBhY3R1YWxfdmFsdWUp
DQo+PiArew0KPj4gKwlyZXR1cm4gMTAwIC0gKGRlc2lyZWRfdmFsdWUgKiAxMDApIC8gYWN0dWFs
X3ZhbHVlOw0KPj4gK30NCj4+ICsNCj4+ICAjaWZkZWYgQ09ORklHX1NFUklBTF9BVE1FTF9QREMN
Cj4+ICBzdGF0aWMgYm9vbCBhdG1lbF91c2VfcGRjX3J4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQp
DQo+PiAgew0KPj4gQEAgLTIxMTcsNiArMjEyNCw4IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3Nlcmlh
bF9wbShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25lZCBpbnQgc3RhdGUsDQo+PiAgCQkg
KiBUaGlzIGlzIGNhbGxlZCBvbiB1YXJ0X2Nsb3NlKCkgb3IgYSBzdXNwZW5kIGV2ZW50Lg0KPj4g
IAkJICovDQo+PiAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoYXRtZWxfcG9ydC0+Y2xrKTsNCj4+
ICsJCWlmIChfX2Nsa19pc19lbmFibGVkKGF0bWVsX3BvcnQtPmdjbGspKQ0KPj4gKwkJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4+ICAJCWJyZWFrOw0KPj4gIAlk
ZWZhdWx0Og0KPj4gIAkJZGV2X2Vycihwb3J0LT5kZXYsICJhdG1lbF9zZXJpYWw6IHVua25vd24g
cG0gJWRcbiIsIHN0YXRlKTsNCj4+IEBAIC0yMTMyLDcgKzIxNDEsOSBAQCBzdGF0aWMgdm9pZCBh
dG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LA0KPj4gIHsNCj4+ICAJc3Ry
dWN0IGF0bWVsX3VhcnRfcG9ydCAqYXRtZWxfcG9ydCA9IHRvX2F0bWVsX3VhcnRfcG9ydChwb3J0
KTsNCj4+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+IC0JdW5zaWduZWQgaW50IG9sZF9tb2Rl
LCBtb2RlLCBpbXIsIHF1b3QsIGJhdWQsIGRpdiwgY2QsIGZwID0gMDsNCj4+ICsJdW5zaWduZWQg
aW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1b3QsIGRpdiwgY2QsIGZwID0gMDsNCj4+ICsJdW5z
aWduZWQgaW50IGJhdWQsIGFjdHVhbF9iYXVkLCBnY2xrX3JhdGU7DQo+PiArCWludCByZXQ7DQo+
PiAgDQo+PiAgCS8qIHNhdmUgdGhlIGN1cnJlbnQgbW9kZSByZWdpc3RlciAqLw0KPj4gIAltb2Rl
ID0gb2xkX21vZGUgPSBhdG1lbF91YXJ0X3JlYWRsKHBvcnQsIEFUTUVMX1VTX01SKTsNCj4+IEBA
IC0yMzAyLDYgKzIzMTMsNDYgQEAgc3RhdGljIHZvaWQgYXRtZWxfc2V0X3Rlcm1pb3Moc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwNCj4+ICAJCWNkID0gbWluX3QodW5zaWduZWQgaW50LCBjZCwgQVRN
RUxfVVNfQ0QpOw0KPj4gIAl9DQo+PiAgDQo+PiArCS8qDQo+PiArCSAqIElmIHRoZXJlIGlzIG5v
IEZyYWN0aW9uYWwgUGFydCwgdGhlcmUgaXMgYSBoaWdoIGNoYW5jZSB0aGF0DQo+PiArCSAqIHdl
IG1heSBiZSBhYmxlIHRvIGdlbmVyYXRlIGEgYmF1ZHJhdGUgY2xvc2VyIHRvIHRoZSBkZXNpcmVk
IG9uZQ0KPj4gKwkgKiBpZiB3ZSB1c2UgdGhlIEdDTEsgYXMgdGhlIGNsb2NrIHNvdXJjZSBkcml2
aW5nIHRoZSBiYXVkcmF0ZQ0KPj4gKwkgKiBnZW5lcmF0b3IuDQo+PiArCSAqLw0KPj4gKwlpZiAo
IWF0bWVsX3BvcnQtPmhhc19mcmFjX2JhdWRyYXRlKSB7DQo+PiArCQlpZiAoX19jbGtfaXNfZW5h
YmxlZChhdG1lbF9wb3J0LT5nY2xrKSkNCj4+ICsJCQljbGtfZGlzYWJsZV91bnByZXBhcmUoYXRt
ZWxfcG9ydC0+Z2Nsayk7DQo+PiArCQlnY2xrX3JhdGUgPSBjbGtfcm91bmRfcmF0ZShhdG1lbF9w
b3J0LT5nY2xrLCAxNiAqIGJhdWQpOw0KPj4gKwkJYWN0dWFsX2JhdWQgPSBjbGtfZ2V0X3JhdGUo
YXRtZWxfcG9ydC0+Y2xrKSAvICgxNiAqIGNkKTsNCj4+ICsJCWlmIChnY2xrX3JhdGUgJiYgYWJz
KGF0bWVsX2Vycm9yX3JhdGUoYmF1ZCwgYWN0dWFsX2JhdWQpKSA+DQo+PiArCQkgICAgYWJzKGF0
bWVsX2Vycm9yX3JhdGUoYmF1ZCwgZ2Nsa19yYXRlIC8gMTYpKSkgew0KDQpJZiB0aGlzIGNvbmRp
dGlvbiBmYWlscyBhbmQgeW91IHByZXZpb3VzbHkgdXNlZCBHQ0xLIGZvciBjbG9jayBnZW5lcmF0
aW9uDQp5b3Ugc2hvdWxkIHJlbW92ZSBiaXRzIEFUTUVMX1VTX1VTQ0xLUyBvciBBVE1FTF9VQV9C
UlNSQ0NLIGZyb20gbW9kZQ0KdmFyaWFibGUsIHRvIGF2b2lkIGNvbmZpZ3VyaW5nIE1SIHdpdGgg
R0NMSyBzdXBwb3J0IGFuZCBjbG9jayBub3QgYmVpbmcNCnByb3Blcmx5IHNldHVwLg0KDQo+PiAr
CQkJY2xrX3NldF9yYXRlKGF0bWVsX3BvcnQtPmdjbGssIDE2ICogYmF1ZCk7DQo+PiArCQkJcmV0
ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGF0bWVsX3BvcnQtPmdjbGspOw0KPj4gKwkJCWlmIChyZXQp
DQo+PiArCQkJCWdvdG8gZ2Nsa19mYWlsOw0KPj4gKw0KPj4gKwkJCWlmIChhdG1lbF9wb3J0LT5p
c191c2FydCkgew0KPj4gKwkJCQltb2RlICY9IH5BVE1FTF9VU19VU0NMS1M7DQo+PiArCQkJCW1v
ZGUgfD0gQVRNRUxfVVNfVVNDTEtTX0dDTEs7DQo+PiArCQkJfSBlbHNlIHsNCj4+ICsJCQkJbW9k
ZSAmPSB+QVRNRUxfVUFfQlJTUkNDSzsNCj4+ICsJCQkJbW9kZSB8PSBBVE1FTF9VQV9CUlNSQ0NL
X0dDTEs7DQo+PiArCQkJfQ0KPj4gKw0KPj4gKwkJCS8qDQo+PiArCQkJICogU2V0IHRoZSBDbG9j
ayBEaXZpc29yIGZvciBHQ0xLIHRvIDEuDQo+PiArCQkJICogU2luY2Ugd2Ugd2VyZSBhYmxlIHRv
IGdlbmVyYXRlIHRoZSBzbWFsbGVzdA0KPj4gKwkJCSAqIG11bHRpcGxlIG9mIHRoZSBkZXNpcmVk
IGJhdWRyYXRlIHRpbWVzIDE2LA0KPj4gKwkJCSAqIHRoZW4gd2Ugc3VyZWx5IGNhbiBnZW5lcmF0
ZSBhIGJpZ2dlciBtdWx0aXBsZQ0KPj4gKwkJCSAqIHdpdGggdGhlIGV4YWN0IGVycm9yIHJhdGUg
Zm9yIGFuIGVxdWFsbHkgaW5jcmVhc2VkDQo+PiArCQkJICogQ0QuIFRodXMgbm8gbmVlZCB0byB0
YWtlIGludG8gYWNjb3VudA0KPj4gKwkJCSAqIGEgaGlnaGVyIHZhbHVlIGZvciBDRC4NCj4+ICsJ
CQkgKi8NCj4+ICsJCQljZCA9IDE7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4+ICtnY2xrX2Zh
aWw6DQo+PiAgCXF1b3QgPSBjZCB8IGZwIDw8IEFUTUVMX1VTX0ZQX09GRlNFVDsNCj4+ICANCj4+
ICAJaWYgKCEocG9ydC0+aXNvNzgxNi5mbGFncyAmIFNFUl9JU083ODE2X0VOQUJMRUQpKQ0KPj4g
QEAgLTI4OTcsNiArMjk0OCwxMiBAQCBzdGF0aWMgaW50IGF0bWVsX3NlcmlhbF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gIAlpZiAocmV0KQ0KPj4gIAkJZ290byBlcnI7
DQo+PiAgDQo+PiArCWF0bWVsX3BvcnQtPmdjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBk
ZXYtPmRldiwgImdjbGsiKTsNCj4+ICsJaWYgKElTX0VSUihhdG1lbF9wb3J0LT5nY2xrKSkgew0K
Pj4gKwkJcmV0ID0gUFRSX0VSUihhdG1lbF9wb3J0LT5nY2xrKTsNCj4+ICsJCWdvdG8gZXJyX2Ns
a19kaXNhYmxlX3VucHJlcGFyZTsNCj4+ICsJfQ0KPj4gKw0KPj4gIAlyZXQgPSBhdG1lbF9pbml0
X3BvcnQoYXRtZWxfcG9ydCwgcGRldik7DQo+PiAgCWlmIChyZXQpDQo+PiAgCQlnb3RvIGVycl9j
bGtfZGlzYWJsZV91bnByZXBhcmU7DQo+IA0KDQo=
