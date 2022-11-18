Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062B62FFDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKRWOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKRWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:13:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B37A82236
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668809632; x=1700345632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TFwIxofDBwYLEn3/kq2DLfw78FbE7ZXhOr5ZmHKtGcM=;
  b=lWSwerzt9uN11ig0a9iJFQTtrr2dvXlbd4pihGthi4p8SrWLXSYIiZ8g
   BCIKwaGa43M/zKz+hc0q9edBtKsDqenEOXFBPxDqb1/BeM7E3rJ7qIw2z
   /b5m0u642DojCf1H9GpyDANnicg2GqZffBXIHLSEpBZyuqU4OSa3YpZrX
   PExiUv9dJq/07jKCRkH7X1J4iA7ROWoHoaHwLH6FaNrV09Q2MAj6MRUdg
   E3bVtpO566FPV3ybX1I5+dFUfTEfRqkGfaFIZWy313Kv0Wg4mwAkYCPVM
   2quAlhJshA+OFx9+RmIJZ22X+CXlsQXgdmbQeuWnrArT4MWb4x607wIks
   A==;
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="200460562"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2022 15:13:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 18 Nov 2022 15:13:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 18 Nov 2022 15:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBwpe/t5kWxGjGP29ngz5g6CT5OLREx6NH7pItw5YXQNCv6RqQaSmDuIidXdyNDHYKz5lFJk5+cbhwi+5y7CRv6xNeFqfyYBbX4UzFAu7FbvQuLehZSzCbQqD8DzDvnNTKAeh1mdkH3p8BkQYMG7s85dHSv1XCStGe3BncOQ/hdg33OrSqI9TBq0Voh8zo49HS6jjEd7EjPrvOXthVL+OgJQchbsJmgN1LBO1j2P07QymdwhbumIgh31woFXRE0aEgFEio1PLCODpPrhECy+tzNn0adGulut2Pi+mSSI5IxgiSdwkphSQchEbE1pGLEuOu9K/QJTNrV7UIIq6PFOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFwIxofDBwYLEn3/kq2DLfw78FbE7ZXhOr5ZmHKtGcM=;
 b=gW3ChsHN/qVFSWMz+QDsqVqgEjzJpBKTSv+s3jhSTjBrJLElWYxPnb5XSUSu0QsVIN9nI1rPPl7eI4etPC8BahpF9hsNSeQe/95HGcc/Jo3zeHVzo+k1iNLeWXiF2C7UqI5tKR64TpyZH8WTof/zPqbJlChIEDwDdgoG8ov9XE89hVY+pSYFumWTOyxUNSCD2VxFHSJ5qG7YmlPdHLdyWpet1LyhGa4YpQO8Nq0HwotMERaMlRgV1IoKVM/3HC0sx8l56uc3L/0zCM5PfeeitP8wyJIoMIzk2gvBrMg8EfS7hiQ0sxeZiWF9J9u/gstbkduStYndXbLYJoh3uMUiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFwIxofDBwYLEn3/kq2DLfw78FbE7ZXhOr5ZmHKtGcM=;
 b=YHuQA59r+D1O0kH9b3xT1rY3PcEsHzAfMOQ/DZ/Yr52jDYsMSJpqDhLQq/xnIL5E3u/0W/a9pwAYqy7uVafZ4Mez9//f6nRZsAh3FfUUc9DVJ5vMhzklz6EPCQG3W0cx52lW1Tmw9BethiE5tW1r8x18dSvK/R0uaVAei5Jl+d4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 22:13:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%5]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 22:13:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <conor@kernel.org>, <Conor.Dooley@microchip.com>,
        <jassisinghbrar@gmail.com>
CC:     <Daire.McNamara@microchip.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mailbox: mpfs: read the system controller's status
Thread-Topic: [PATCH 2/2] mailbox: mpfs: read the system controller's status
Thread-Index: AQHY+5pfxK0ZrzivHkK/qEzXxPk+hq5FPtgA
Date:   Fri, 18 Nov 2022 22:13:46 +0000
Message-ID: <274e2b0e-f22e-c4e4-f9ba-72eb13218d3e@microchip.com>
References: <20221118220758.1101409-1-conor@kernel.org>
 <20221118220758.1101409-3-conor@kernel.org>
In-Reply-To: <20221118220758.1101409-3-conor@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|BN9PR11MB5242:EE_
x-ms-office365-filtering-correlation-id: 0ded3d66-2e38-4cd5-73c0-08dac9b22993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OIab8QOSKRpB1aRVSOVtYnlii7ZA6zUbTXBENrMoq8gN5f+UzvPujl7oKOQjTcJgT5tnJnWSoaQFHOBRdLiuZS0bQKXaZ1jOiYMMl17KARXuCYnawvkniobtKcCpBQz9y0KxiljBl35p4b4/6seStYU2LkgelAhL5j+01dvsWtMPobHF0oPg3y1vhjSvUmmVmyI0ID0An8uulbdjA9IIHhmqm8YeHTUZpD3ur37saedgQfqkZqU9zP7ccOMdcTp4AB+f1SijzWFpfANWBQcAIDWpTMaTHtN2mJOr3prLUQ7/6ArDrlHTv2s4MuZTjiI+KM0XqHYVzO0UeNEJ1+aQqpOGwEsQ1dBQtDiu0k1MQiFmlFm38LvGM4d9eccYS6joQdxCgMz40tygRS9NoKDPUkcHWCZfSy7ufF9s3OwF31Cnd3ZIRHy8uGpfM7P1xOrnNwys7lBZiqPpObr5FkRosZWUyN/fS27XFRwVjWLMT/Szw/9HYB3WjMvxs2My4tFY4+42hDZOPWJTpB1oScYMN+Y/Ap9Qz0i5N4FNsOwymCCKXsJ4CYypH1WLf8KpVsIx5EYguNvPNrrIi4yMEU1fycoWszMr5uqv4Rj9MKaQOcVDkOo4U03jH8D3J5nGbkvbkz6fJ2yisfUb0lIXXjTKOQrGozsdUt3YhdpF+vSdt8UmuwfSi7sxA05Ik1ckdGL4TALPOLXVEP1G23/VYMH64dYj7f659pAF1TRw1HrH1XiFVQ+ve2sobhf/JQrgTF5mTt9gKXRWMFS8ZZB3A1qgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(76116006)(6512007)(26005)(8676002)(64756008)(66556008)(66946007)(66476007)(66446008)(4326008)(53546011)(6506007)(91956017)(110136005)(316002)(54906003)(41300700001)(558084003)(36756003)(6486002)(71200400001)(478600001)(2906002)(122000001)(38100700002)(86362001)(2616005)(31696002)(5660300002)(38070700005)(8936002)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdUSVBxbEhBYTJIWDk1Sng3WFVLa2xTQ2t0ZmFCN0trMk43alhmb2JVSEMz?=
 =?utf-8?B?VDJSalFFV08vZXp1aGJpUEFmclA3RjBBb1kzS3FuVjZQNGVWSTlKYzJ5U1JW?=
 =?utf-8?B?VVVLc1U1elEvNGJmRlU4di9ZZVMrRVdKM1E4V291eWJSZkZKSnlwSEhGbzFt?=
 =?utf-8?B?bVJ1OTVMYi9hOStyVE1PQXpzcURKN1lQaCtpU3BhSlg4MVRjZGkzOUk5SGEr?=
 =?utf-8?B?M2tDb3ViS3NNVGFmZDNKYk1nVi9OWDFiaE9aQ0tOZnlOUUJ0eTAvY3ZKSW92?=
 =?utf-8?B?Y3ZyazVCdENTYi9xSGJ2OWRvU3hxa2tWQTRGTWVyV21Mekc4Tnkxc2lLTVpP?=
 =?utf-8?B?ZmVGSUh2NmNub3dyblBZbXZRdTFkTDM1MjN4SkRwOEZ3eU1mNFkxRXFIUUUy?=
 =?utf-8?B?V2d6Z3JFMy9TNWUxRmRQSU0zdEhQb1JzYlRNQmhjTTBxeEM3Q0FOZHB1MEEv?=
 =?utf-8?B?cDlsb1N0VEdYVi83SnJ1cVdPS05QVEU0MTB5UGVNNnVOS2J5VHk0ejNqbm83?=
 =?utf-8?B?enR6QStTcHI1dmtDR1o3RDVDdEdQQnlrRnR1Tit1OFBpVGFKaHFsVitBTTNx?=
 =?utf-8?B?dmc4MVM4bmpCaENHRzFtMWRwemwxcDRxamR2Q1FOSDBHL09pcjcwN0lJYk9r?=
 =?utf-8?B?eWp4Mk5sZkJDV2U2SkF2aWVKNjBhRk9xU2ZTWDg1UUdKaU1zK0NSRTVaWXg0?=
 =?utf-8?B?d0QwaVduM0dITW5obFF5UkwyVzhSR2JIL1VPenYzS1ZLMCs5THpkQ3kwdzFR?=
 =?utf-8?B?YnhoZENkdTlSc0dPaTh6Qlp5OXhzOVNjd2FXRkR0NUdneVh6dS96ZEhydnpt?=
 =?utf-8?B?cGN5cXF3TUhDRGlua2NvZUlGTnVwNS9iT3N5aVlHTFhTL2h6N1p3THJoTDBz?=
 =?utf-8?B?SVIvdG9QQVU0L29BSU9CRXl2bk0vdWg5R0J2WHhvRlhmc0tVVEdESzRLVjk1?=
 =?utf-8?B?NkE4K1VJd3l1Mk82QVFRalB3T2FaSVNNMGk3dUNGNkdyL29VKzN2VGFoZDlo?=
 =?utf-8?B?Qk1lcThXWXRBYzN6bmtMYmtDNEZJQWFxcW5Ud1A4bFA2Q0lNalpUUUdQN2cy?=
 =?utf-8?B?N21QUWp0dlEvTWZoRUFGZmhaL281RjBLYVdNRWJSWm9JeVF6Sndhdnl4cnpL?=
 =?utf-8?B?ck13MG05RDEwWGxRQVVDTXNia1JsWEVvazk5ajdXYVFwZnQ3TVJCdWYzcVA5?=
 =?utf-8?B?ZlV0eDJiVzRxa3FKd0RrSnZ4RTRjVlhFM3J2VFgxQVVvRm9ZSXROTE5aSWRr?=
 =?utf-8?B?RzJqL2JvSy8zQUV6Kyt0ak8zaDl6NGxIWWVuM1p4Ritic3dQNzVPS1lrUlBh?=
 =?utf-8?B?V2Rxakw0MlNsVXljLy9xdlZ4SHJrR1lWZVlza2JMVTM4Y1NNUTV2ZTVsSTh5?=
 =?utf-8?B?VlhPdXp5YXRyNW1ZN1J6Uzd6WllaQXcxWWtleVMxSUVyUEQ4MUpORHJIYTVS?=
 =?utf-8?B?VHFlcjUxRVpWRXhIeEN0dUx0NjNxczdLZHA5UjhEK2k0Zjhvdms3QlJQV0JI?=
 =?utf-8?B?WEdxdGg3cSs2clBXNmlYcGM0b2ZCVm5pWXYxK28wa1N3cmhmSmhLTENhclVI?=
 =?utf-8?B?cUhhcGxDWnQ0OUFVQUc4TXZoeGVIV3kvbmJjRlI3czFnMmNCSndHOC9CV3Iv?=
 =?utf-8?B?ZDRlRkpXdGIydG9iNzdZb0g4Z0V2cGtMZStxajZKMldJMFZKclZSM0svSnJ5?=
 =?utf-8?B?YjlGWkVpZkdhajg2SXlVZDI0cUxsS2p3eFBmay81TnZFOHVXalFlUWQ2SXZm?=
 =?utf-8?B?QktINGZSK1RtK2JvNzJXdnhnUUJhVWVIZEE5WXZJR2xrbHY3RThzVkl0YVUv?=
 =?utf-8?B?dXV5OTlzellINnllWkZaNnM2MkNwVUNuVUFHbndrUEdYM2d6TjRuZ1c3UlBI?=
 =?utf-8?B?Q2pVSVNEKy8yTjArbVpFNHlaVUtnUFZTOTVMTS9tSWRGS21PdXlXallWR0oz?=
 =?utf-8?B?SmxSZlEwb0E2SDBpTjFOcjFHQUpETlNTa0s2a2ptYzVQNlEwa01hZjRTM3JW?=
 =?utf-8?B?S3lrelUvTnJYZ0MrYm8wczFlc2pwdlhFU3BhaTdOd3pzV1ZqbXJqQittYldE?=
 =?utf-8?B?TVJrSUVoU2JDVGo5eGlRU2tERW9Rd3gvcldYeGMrTy96d3pKMHltMjRhZm1z?=
 =?utf-8?Q?xWm0Nm/7Val5YV2SWjKnOevYo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C1DE5A6827B0429E70E20A362E573A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ded3d66-2e38-4cd5-73c0-08dac9b22993
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 22:13:46.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ngqg3IYy+3FdSgE8rcFdwuEaAS1qd43rFX1zl0kiWrxyhbHxz1SQIJZXI9RDd+5+0+52RFgIozyQuWde4ijUwELJolP4atiT2RYkVApdAVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMTEvMjAyMiAyMjowNywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiByZXNwb25zZS0+cmVz
cF9zdGF0dXMgPSAoc3RhdHVzICYgU0NCX1NUQVRVU19NQVNLKTsgPj4gU0NCX1NUQVRVU19TSElG
VDsNCg0KSSBmb3Jnb3QgdG8gZG8gYW4gYXV0b3NxdWFzaCBvZiBhIGZpeHVwISBjb21taXQgJiB0
aGlzIGlzIGNsZWFybHkgZ2FyYmFnZS4NCg0KSSdsbCBzZW5kIGEgdjIuLi4NCg==
