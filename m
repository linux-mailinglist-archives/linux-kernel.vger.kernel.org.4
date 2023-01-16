Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16B666BAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAPJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjAPJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:52:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44E193E3;
        Mon, 16 Jan 2023 01:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673862766; x=1705398766;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dNmY9WyxQLUenOKwccZR/yjWUOWjv41Gr73cfvLN7FE=;
  b=Qs+OncA2pWGn2ki4ePqD/sXZQRBvUij6jU3u6Vb/9P4rvZFo97sTCkcY
   EE1xqryBJNVxuku6T1iiHyyjNVZjwu2QdRLadG38qDhez1Z/hM45f0Atx
   1Ptnv+1L1sm9iEYARRr/gP8KY8qMugvy9x+QiTsfua964Xbwk4ThmAP0F
   04xJypdDzWcAER/ejQUlhU0PkgJjQLXrC7LnguGy7c3+y/LwpGB0NPJ+O
   tm9UsEG9Ezb+1dM/C2lSMOZ+R03BU5EeELfH42pAmpxJD0ICYBHb1ADJ3
   9SfmbV4n4KG9UkWPVCYTiNfCaTPJH62kLa0mJbHD78BCP5wK5LKtaDFXm
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669100400"; 
   d="scan'208";a="192408001"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 02:52:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 02:52:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 16 Jan 2023 02:52:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj00gKBldNDDkv7srT2X0mSPAwp91x8JOO1EWGMW+JJsEcfTkE7GmPCco/9bvDbbZ+51A+DFU7iEsMHFNxt3eauStMrI+3aXaGrUtrs5ZavRSxd3Xydbqu9FOUi1BOqY0tixgxkT+s1VzhJOkuKLPGaxtJ06/IxKFLckBYP1oEUdReYBQF+0QXrYK4prLi+8o/nulrsWRDeDbShpS6Egigi7N9QuK3fcbmJgdgwdjQzWrbAofOnTmFqbfSd8WHXYHBrAA5YgFx0NW/Nz+ZOsbkS6ZyPNEPYWY5CZ7ysJjychCgZHHzIhNFBzX6q4gPIm0yAKaFslkHBTB2h8mBoiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNmY9WyxQLUenOKwccZR/yjWUOWjv41Gr73cfvLN7FE=;
 b=cN4hvh4SQNqrxW2d6JVc/u1+dbSAnLHjfXHs0B6tO70AZGkSsmI3ABLwb6mizgYvFHRcCWeKqf0vW+dMk9ZI7SvfD51/wy5NeqyGOzG0Uri7OofnMLu4w2eY+vK5tIxZbFN8ypnNVay7ALQhdGw8bWeaxM0FIL8YeeEdOUrO9DNm5Z0Nvo5UNr9TCnC4huAIQmJ8Kqqlctc/7363amnUu7hb5McHH9c4397+tl5YFtZXEWROKPgcTOedlfSjDF9kQX/fmy97z4hg5s04E1oJ+rH86Ehe4B3W1szujoR1Glo+XWIgYDf9TGa68U4RhqQc7p7/FVmuA1Xf0LLDlkjm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNmY9WyxQLUenOKwccZR/yjWUOWjv41Gr73cfvLN7FE=;
 b=gbTAqnBXLxgMdAwH86wywPCw8pKh6plkAVuVPOECMaZBd7/IukUUHt3gdPqH8Pzs+t0UtgibGg3NE+hxMnVdQGKJh1qNsO8J5NWmtg2CxNCGXFRa2zuvqz1H9bP50xBt+qzNM1oytqzlQ/ZwD43cXu58gg+SKSH0t57CCWc29k0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:52:42 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 09:52:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v4 3/8] ARM: dts: at91: sam9x60: fix spi4 node
Thread-Topic: [PATCH v4 3/8] ARM: dts: at91: sam9x60: fix spi4 node
Thread-Index: AQHZKZBGst9sNyjCp0uEG/ofSN1OWg==
Date:   Mon, 16 Jan 2023 09:52:41 +0000
Message-ID: <4f74fd5a-144f-ca3b-ab68-d9a14fb84860@microchip.com>
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
 <20230112110208.97946-4-durai.manickamkr@microchip.com>
In-Reply-To: <20230112110208.97946-4-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH0PR11MB5808:EE_
x-ms-office365-filtering-correlation-id: 0bfabea7-9c9e-48b0-55bb-08daf7a768e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIAdjgGMkGupk7UO8iB/6fO/NMDaXnFBLJ+J04p7PGuuBumUACmBq5Hp0JQMzGoLbwo5XGd2lXVLJeQxue72ATPuzoYcVL3BURMXs8CFftedPoWF38TQ9tBVdKoBb/El6dOvznn2ncg47YgTQBcl0DxMepfdiFIJsWzd82WTV7yHnWdnq8+1M3ePWuWZR6vFW5ajVAajYJ5HEsTB91XGLJmNGCjzTr0JWBu2YeT+Tw0o8gtkItSbgDG6NHrpD3o3EX446Hysj0bFMp+GVRIgbA4RJtvK/Rfi66WjpJ+ZlOtDDhJz21XBRWEhXAN7TShI6rSK7bO+ZSrjKX+G1NVvwoJgLJEaysX8fDi+YAJPhQSFfgG3dnw3hs5uoXzYgIbImQ+i9wRRcmZJcIhdRgR1uJ09wLkEsmLUg2CnXL3zkRD1boMZaIJc7s+US88uBWrgaeMTxuHC8tZvG/4GkvWKNFFVZp6SgIdW/+xntsuLkcHS7JftfRFlTC67thcOd7dFePCce1WbylduBCb4LFOUSwigStVbeYn0bt7dxBudxlvd4AdvN4dCdtEH+V2ByJhYOMfpucoEP+OT9eDf70puv0Dbi/fIeWEw61cnWukEUWQbYkxEPxHTA6TjMrKtq9PpT4ayqZDXMYy0Wt3j/cznskZkuhqR0k2uA9ydlwGJneOwsvq72R5krggimfDCGi3b6+XaleuDguJiUmQkwJaA2uKqiE4XoaNAd8Jh6A6X/DuNtPm7LKktMWaM/eQ81MgI0E8fqOLpIrfMZuB0Z+IUB32pXoW6z38aJ/lE58MhDuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(36756003)(53546011)(86362001)(6512007)(186003)(26005)(8676002)(64756008)(91956017)(66556008)(41300700001)(76116006)(2616005)(66476007)(66446008)(66946007)(316002)(71200400001)(6506007)(110136005)(31696002)(478600001)(6636002)(7416002)(122000001)(6486002)(38100700002)(4744005)(38070700005)(921005)(2906002)(83380400001)(5660300002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1h6U3VwQUVud1pqeVJ3Rk11YTE1cHJSZjB3UVhYWXZOZ1BJV3MvdmxRYlJB?=
 =?utf-8?B?cEZzWGRqcUlKb2JrNzhDUUh4cGRuemwvWWVEallCODBGVTlJRDM5UkJFNlpq?=
 =?utf-8?B?TU8xdkZQbDdSWlh2M2ZXMlRtb0Q5Y2M3UU53ZEFKeHdDdnZxMHZyNTBHQmda?=
 =?utf-8?B?ejkzNnkrTldVVVBjUnZNWkZsdkF1RXpJTjZvSzhVQzBKU3lHdEExK01hMGpv?=
 =?utf-8?B?ZWMxcjJsREFFVkJaMW5HZDc1Uktjb1RPKzdqRG42TjFVemk1LzBpWm5MVzBt?=
 =?utf-8?B?aERhTWN6S2JwSWhyWUdqSmRHUFpWdE5GNW1YV0NzMGhYQmM0YWN6ZGNSNEM2?=
 =?utf-8?B?WSs5S0VROHJhWnA3Nyt4ZHh1YzRmVnk2cmhPWDRGZXN6YVF6bG55bllIQ2xP?=
 =?utf-8?B?aFBvR2UrZDBYNGJpTEVFVllETUlweHRiaU9DZjl3TFdkaWxaTGU0SXNGV2ha?=
 =?utf-8?B?VXZ6Wm1iVDVDNUI4dmw2UU50YzVYWWFOSHUxMVo3TjV4VkNOR0o0aDB2THFO?=
 =?utf-8?B?U2p6RmYxTkltYWUweUZWZ1lKY01QNHpOZUd2dFRVOE5sa3pQREN1WlVQaFN3?=
 =?utf-8?B?Tm1MME0rQUZYaEN5OUV0NkJEbERCcUFWYXVTMGVzRi9oeVBubE9uT3A4dyt6?=
 =?utf-8?B?eXN4MmpmdUpOcVhHWVVWUGo5ZS90TExrSGdVU1h1Q01xU3cvQy9ZL3B1c0Nl?=
 =?utf-8?B?dlVMMDBKcUlUVjVua3NKd1Qrb0RFblBvcHpUMUNrRmdiMnZLREJseTlsRUkr?=
 =?utf-8?B?QTR5aWlaT09iRHlXSEZGUTNRaDZHOHNhbXB3bDVOY2FJTjJSRkgwU2NpMEVr?=
 =?utf-8?B?d3E1NjYyQXpUTWhoK1BGdUJPNEYycnE5dFVWeHdkQlpXbUIrcDhwMmpwajVn?=
 =?utf-8?B?Ykw0aklwM2RhSmVCajR4SVVpTDNUTjJ6VHVQSklGQVRMUCtpMGpsd3gyTW50?=
 =?utf-8?B?cUhBMnRDeEtMSnNUNm9rWlR5TjN2K3R2ODdIY3ZISXAyOW15VWxsMTRZZmFN?=
 =?utf-8?B?bG8zdk04N21hVVJQc2tPYkpvSllBUTdWZ3ZybU5mbjNGaytEZjJzVjFPZU1O?=
 =?utf-8?B?REFLa0tTMHBPanQwUVJrdWlHNDFqMkxndUVQNDFleUV5bmQ0OXlhTld5TmpR?=
 =?utf-8?B?c1o4eFZJcTBPS0hWdlFNNGRjS3BTWFQvTmcwQjJRTGovV05WV00veGxDa0xZ?=
 =?utf-8?B?UVNZd2ZTNVZaUWU3Q2ZyMG1xR2tWSVp4TmpGYWVzbVdMaXNLQlZOWnJRQXZi?=
 =?utf-8?B?ZWVDVFYxekphaDZvbzVCSXd0WXRYNDlEczFhZW5jeHRTWXpJUHVXRjlhZzRL?=
 =?utf-8?B?QnBwazYrd2FPMy9YUGplM3d1NXlDdDB3akQxL1JNUi9sT1N3Y1c0VGtCazdr?=
 =?utf-8?B?a0FHd2E1dzhHWFpxTmVveEFZelNkQ29nOHdRWkxoOGhpQThUMGI4YytLbkhu?=
 =?utf-8?B?RzdIUTdPV2pMV3BtZnFDOUNueDVhSnordEFLdkV0bFBLWjNEdHVWVmdnV1Jn?=
 =?utf-8?B?QXIwMzdGRE9DS0lCQjNtK2lqMU9pVVlCRnNpU3gvYlZGdXZSMGI5TjdNL1RQ?=
 =?utf-8?B?cFMxRTZnU2lIOTdDTHRXTERWSjkzejhOaXBCNlpvMHVlWm5Za3dJRFp5Z0sw?=
 =?utf-8?B?NmtieXZuaTJrZ2JZVWpjdytTNWQ3dnZnaWdCaGhmbWdvZEFDM0dzVDlYTXR2?=
 =?utf-8?B?WHZUOWZXeHpaSUJOYXg2WmE3eVRkcDBoTEFiZ2lYVm5DcHJxczRGTWtkQlFX?=
 =?utf-8?B?RHUwTUgybGpoNndDalZVTHRrSGZpK2NSaURkTURnRC9iSlFKa0ZGYlZjUWNv?=
 =?utf-8?B?RDhCamJLQ0NNTG9oVC8zdzNPR3hxSlMwd1E4YUk0V0cxZ0twRFhDNkdRNGlO?=
 =?utf-8?B?SmRySEl4WWtRaktKaDd4Y0VXVXk3T1liVmxpU0hrMmlacXl6Umt1SWhpZ3dC?=
 =?utf-8?B?M3h4UThRc01Eem10RnlkQzZ1bnRNV0NGOGwwcldwMXBGOWFYeFJYQzZBckVF?=
 =?utf-8?B?K0lRdERPM09DYWNuTG9WbVBhTUtVSWVkelpKK20yU0d0MzRka0pZc05nZzdP?=
 =?utf-8?B?OTBqdys1SVBvWWpjclRiZUVRTUt6M2w3RWw1QzYzTWhIM1BxZ2YvMnlDOTRW?=
 =?utf-8?B?UmhzYjZ0TGZ6L2FDekY4czlva2dCczhEblB1VkhyY2x4RTRod25mUkEzQXJF?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D176D79898EEE43B5531A8310019E00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfabea7-9c9e-48b0-55bb-08daf7a768e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:52:41.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZVaypjMOaAxfEj+ddinJUIEm5JgBxcYcOzi+7xwJa8zSEOhaP7PIj2EZfsDEJct3oxaPwAlHzDxKC7tmyZ8MnI6qpTWvInDFfwaD5QVutY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDEuMjAyMyAxMzowMiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IFRoZSByYW5n
ZXMsICNhZGRyZXNzLWNlbGxzIGFuZCAjc2l6ZS1jZWxscyBwcm9wZXJ0aWVzIGFyZSBub3QgcmVx
dWlyZWQsDQo+IHJlbW92ZSB0aGVtIGZyb20gdGhlIHNwaTQgbm9kZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IER1cmFpIE1hbmlja2FtIEtSIDxkdXJhaS5tYW5pY2thbWtyQG1pY3JvY2hpcC5jb20+
DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRz
IHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IGluZGV4IDRmZjg0NjMzZGQ0My4uNmI2MzkxZDUw
NDFlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMzIs
OCArMjMyLDYgQEAgJmZseDQgew0KPiAgCXNwaTQ6IHNwaUA0MDAgew0KPiAgCQlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4NF9kZWZhdWx0
PjsNCj4gLQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IC0JCSNzaXplLWNlbGxzID0gPDA+Ow0K
PiAgCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCX07DQo+ICB9Ow0KDQo=
