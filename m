Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC67381EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjFUJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFUJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:33:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE22965;
        Wed, 21 Jun 2023 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687339922; x=1718875922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jpd0RvBtQ7noMVEcclT2FLo2S3sv1wEwr99Iqq3OfLc=;
  b=pF1+ge2pL+D4rk26gzyPhB+2Z7Bx7cnPlWW1b+p6pzVoXo4aX6BbgbU7
   rrqw9lBO1zaS5mh4gFrxmkXPsLu0ZL1llPM4VSS5N3pvQga4klf6I8z1J
   GWjadkGH/tOYMPBRP2INe5ag7w/QwjspQKWYI3U6U04TIEXxjhVrn6TGj
   mw8QN3/CpLkyw9Ft5DHdMxYkuOjfvv0AfWNqV6aEInw9+xcc5AwyEasN2
   Q0/gJtcGGRkb3YALrcSzsptk1xYK2X2wYkSTptCl1QotFDzMLuQYOExR9
   ckVy+Siy/uulSVaJgnvyvbdAPRGlDrO+eC9cHKfQQWnnjOZb2Sk/pEx9T
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="219023626"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 02:32:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 02:32:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 21 Jun 2023 02:32:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD40znh9OBuN+bx/OI19eHCqNKlaID30Kf9Uc8HfMQAvimEZ/SzOL01HUvK1boP81cpfSkZ1SdTUonwnxAzCq+Dgxff4iXh+YNopHwD4r4WlcPYhPW1i0AMujteUyYLecw5U8PjP9XrJYwPEmtUMdv37D4ia1tzlkwI6sBzjdrtCnI5CcFZ0yU0MRuwh/uURcJzhlRAz1WOFGKCCDSprxtreHLG2r/j2dcYL/+yLLvQmHF7o+IwJX2kpD/0lFIOLRYuHvUe5H3eZvvc2FZfmkt8TfsrzgoWX/jWrsyeJ0RRAlChEQZgjl17X3MN+lGYXuGufn/O+VeFKdRg3fuMHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpd0RvBtQ7noMVEcclT2FLo2S3sv1wEwr99Iqq3OfLc=;
 b=nyiiIItu+p1GM4gzkMYyxgHB9cesWW80kI9OT6hgFrOhgsZcgmoJDveU0F0PGe5Kx3COumPWZPhWmuKn11TZNN2TL4xXEyvvlsGty1XDDjSpwwfSQ0hlvjvVMkPXdm45ddd31SHL+gCh0k2BOxMcbeB3Q8LR+3RBV/86D+u/vxgtlGDuYMbGyN2kLrBX7TecrpmBFNtGkv2ylJ9SGabVh226mPARR/JW8Qz65DA3xyt0QGIH5UKaJ0GCPxyXA37Vs+L6kmBf4XdkCzkpF/c1+Th/d8UKnbPEWkoKjxsnLSF6FBks1JH8U1AXl3AgQxvEgxNB67N156SxPxAxRZWBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpd0RvBtQ7noMVEcclT2FLo2S3sv1wEwr99Iqq3OfLc=;
 b=S556iHGJRkT4iUwX0byjbPK/L7beNV9ogOlo/SXr5crVdknJh7CRlNxQQIf4nLfXz/sWCe/yrKjL3/ykXJOtuxJ/cyl57+3REJYTO0L/wSAy2WpRbdqARfe9s0NiLS9VktqGcPYXDiF3I29etoKHi3c/Dd1ag8Lj8WzzdGAlNjw=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 09:31:58 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 09:31:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Cristian.Birsan@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: Enable device-tree overlay support for AT91
 boards
Thread-Topic: [PATCH] arm: dts: Enable device-tree overlay support for AT91
 boards
Thread-Index: AQHZpCM5eiQHORn+n0Sf3aZynHfliA==
Date:   Wed, 21 Jun 2023 09:31:58 +0000
Message-ID: <415fc114-bab2-07c4-5938-e20756b1d11b@microchip.com>
References: <20230616152932.1484154-1-cristian.birsan@microchip.com>
In-Reply-To: <20230616152932.1484154-1-cristian.birsan@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM8PR11MB5702:EE_
x-ms-office365-filtering-correlation-id: 3e1706e3-6659-4b47-2f5f-08db723a5c74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8p1w9SCSAKr4otCHtDCYl1tlYh8JrqQCEQEvD9J7WbubcrqC6h9r55xDjrkQmxp8xMX7DDNaKh4Oc4mAZnm1a3aelu7MImdHF0G/z+Wt9Y2mJRDlFJL2ga0IdPFRMBAZMktIvS2aXssxRPK+incRzRdCKYkwKuWNtndPkxqKsVuXtrnwWJBl3sW312YiBcdommYfVCKRQ8VtwLN9FZ9xnRU4eeO/PYi16DCH6Z/HxFaVIYzBxly01aJu5tnxTWrtmP5cPmDvZzIv77GRHLu9z9ZZMwv0L4d/uDfrsr/FguQAJUP7KBTgVmqmY6tnj/xesfZsdyjvUtlEzvu+T3+J46VgTGgVCDRXr5FyzUxCk2ujSKKlrfp+Bu/0xE6chF7ulTSNlJWcWrYGID6LWkR27M+U3B4BlVQG4AYZexBP5BLv4N8B3UbTzEovkBQjQbpXZxj9RKh3/KsSS30glAYof/xbnYnd8t4BTzQrbxNweJH96qEBVxlKOvDlja4EaOLGfmihL8UEKpC1TSqWZTXRXJnfKGAJZutR4Q7c0zScqx42FnXgmeZcfzRovbiFwaUkxkaofiwJkPI+idfwlZSsGnxvYFF6zqa3HVfTn0E4KRTWZuvSXLquCDw2br3gailv7Iqr2SpZchuLj+4BH+LtPbHp22ZHhVYxDA9IRgaT4Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(122000001)(38100700002)(53546011)(6506007)(6512007)(26005)(186003)(2616005)(6486002)(966005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(38070700005)(36756003)(71200400001)(478600001)(76116006)(66446008)(64756008)(66556008)(66476007)(91956017)(66946007)(110136005)(54906003)(316002)(31696002)(86362001)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTM3TGdmYVM1S1RnRXY0T2ZMd1p5cXNjMUZwb2V1VlcybjRrUFFYQlNKSEpN?=
 =?utf-8?B?OFJhRElsUXY1UnlPQmU4dGI5SlhEampNS2t1TWpnOVJLZTBvMDQ5enVMNFhO?=
 =?utf-8?B?L2kxZzVLSTFONFp2Uk9xL2ZLSnhrT1NQb2Z1OTNPcGVMUXFpbVBBaERFb0hD?=
 =?utf-8?B?WEpmeEp2WUNLUFNEaFAxekZPWkJBaGYzNFkrS0lwdmJiVjVaamt2S1M1Qlc3?=
 =?utf-8?B?VndleDVXK05SQTZINGxXeEh2TEFDSmIwVUlnaU82UXZESEE4NWtqdy8rZ2VJ?=
 =?utf-8?B?NG5mZE1ZOXczeXBuNU4xaEJZcm81c1NJUjJYcDZEV2RSZFpZQURmYlVIcENB?=
 =?utf-8?B?UHZqT2IzUEY1elVteFVKVit2Y0R6emk3TVJXMUs1dnlGYW5URjJ5NS9KR0Zm?=
 =?utf-8?B?VUZIMlRUcXRmcU9RWENBLzRualpLdzNNMGdmN1NQOHpQMk00b3I0WDNWWHow?=
 =?utf-8?B?VGhRRk1WZUFQa0N2RjJOV0ZaYlVKZThvOHhYeVYxcHJKWUFqWFA2OXlvS3cv?=
 =?utf-8?B?N1M3d2NqTjN2ODhrRlhhdk82a2tnWjk5QnA1Vlpsak9GNVF2ci9nL0hVZG5E?=
 =?utf-8?B?eTkwTjkzWmFqSFRYN3BSb2VLRDI2OCt3QTVTYTAwVWt1TERUaFRadVJIbnR6?=
 =?utf-8?B?TytvWkdBOWluNTJOdDhXNUkrTG1uTmwrOEhMZTZZRHZFTUg0YzJZcVRHSmNL?=
 =?utf-8?B?SlVIeWxLZnI4Y1Q3QXUzWGdYWjJucE9nMFJackxpS3JSMHh0bEtVQms4RUNo?=
 =?utf-8?B?aWNjejNoRlFwb3lrZ0ZRK1RiVndEMnF6V3F0MkJkc1gvNVpDRDVkc1dLWVdp?=
 =?utf-8?B?Wm0zYk9ITnlUUGdYMlE0cHpwMHdnYVlaNTNBZFJYTm5INnBNd2VQdzRhMHZm?=
 =?utf-8?B?Ty83VW5qdnQzMVlGRDEyNzk0NTFlc2NQb21INTBQclc1ZWE2c2xBVW9QMmNW?=
 =?utf-8?B?SWZpdWtFQjFkdUtreWpBeGlpQWdCUUNjQm1qYnUxVzZFWlg0alVFbGhkSDFR?=
 =?utf-8?B?Q3pXM0V0RmxCSG9rTXpZRGwyQTZpcXhxVnFGWWxJckZlZzhKbzB6ZXpTeG1Y?=
 =?utf-8?B?elV1OFBzYUhoeTlwU3Bma2c5UE54Ky91dGJqMDlFUGFjY0d0b0dldDNYV3l2?=
 =?utf-8?B?bVJaeWh1aVRqSnQ3ZmdwSURLODBmSTM2MkcxREtmNFp2SUlnWVNXeFpoUjZD?=
 =?utf-8?B?T1ZmVXJTR0xsUGUvVk93OW80STlZUWJsOTBPWlRGNTVxVVNHT1FETkphdzdU?=
 =?utf-8?B?eFRocHNRVzNwTlZaaHZkRnAxRTZuVDJOUXJTMUt6SDQxZCtlTlJEQnJUVDN2?=
 =?utf-8?B?KzNFdGJLd015UmpJa3ArbWRQUjNaSld2anJ4QzFCemorMERaYTU0QjhvUWtH?=
 =?utf-8?B?ZnRhbHpSSTJuT042WWxVVHJ2TWMxdXJxSkZIT3VUVVoyMDZpMW5jNUplT3JC?=
 =?utf-8?B?WmM4VGdlb3Jwbmk2Y3BuYkVKQ1lmRmVBZmRSRnhEVUtkazViVjlFdW1EWndj?=
 =?utf-8?B?QmZ1ajhJaC8zQWZxalpzdUZmWnZHdE45T3ZsZFRQRWR6SGswQ0wzSy83QXh6?=
 =?utf-8?B?a1Vtbkpub2ZOcEM2bUdtZTF5ZGxpYXErb1AyWEt5aXJrUUQvOUVHTDhiZlVZ?=
 =?utf-8?B?VEM5dG13RkZoaHdYSHdkelJvaHlqMVptK2JsSEUxWTlBbVJUU2l1dUxNcG1i?=
 =?utf-8?B?L2pnL2w4eUxoaG5sekQ4VDlNY1ExWW01NldJTHBKRXVVK0l2VWppdnN2ZktE?=
 =?utf-8?B?K2VrR1kyY2dqcTZKNkR0NU13K253MGtzQTdUQUprUFFEcWJEVlcrTmVtbUlX?=
 =?utf-8?B?QVh3REp2aEVZM3pJamd0SmxtWUgzcFpkeE5rRVdadkV1Q2R6TWN5Q3ZMRmVT?=
 =?utf-8?B?ek4xNXlicjhrNGV0blR5M3BpUnRxUEpaQlhEZ1EvODd5RzRiemFOM042d2hW?=
 =?utf-8?B?TjQreElFYVMyYldIZTN0OUQ3cUhpQnhWd0N4bThYbS9IR3FFdlNkcEZoM1Fl?=
 =?utf-8?B?YWd5OUVYSUtJWDY0dDZwRlU4eGNEODl6dTFPQXM0c1AxeERrMmZaY3QwZmgy?=
 =?utf-8?B?dXU4bURCaUFFQTZtcHNiMzVWcWhkZElUOG9tT0RWTWh2RzN3WnJZSmhTbkgy?=
 =?utf-8?B?aEVHdHAwZ1FWTUQ1YmI1U0ptNG9vKzJHZWFXbk03djc4ZkhHZXFSWVlCTjM3?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4440E1CC1704149BA3FF421ACE78B2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1706e3-6659-4b47-2f5f-08db723a5c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 09:31:58.7448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbxsJ/CaiBtNUxGcKy7XM6iRIYiDbBz58IKhqm8j/yB464pWLAYOQWzCqdaIilDvyFsUTzP+RDL6q8TYiG3DlV7ao4hpVmGiUme3K3rIYzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5702
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDYuMjAyMyAxODoyOSwgY3Jpc3RpYW4uYmlyc2FuQG1pY3JvY2hpcC5jb20gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogQ3Jpc3Rp
YW4gQmlyc2FuIDxjcmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbT4NCj4gDQo+IEFkZCB0aGUg
Jy1AJyBEVEMgb3B0aW9uIGZvciBBVDkxIGJvYXJkcyB0aGF0IGhhdmUgZGV2aWNlLXRyZWUgb3Zl
cmxheXMuDQo+IFRoaXMgb3B0aW9uIHBvcHVsYXRlcyB0aGUgJ19fc3ltYm9sc19fJyBub2RlIHRo
YXQgY29udGFpbnMgYWxsIHRoZQ0KPiBuZWNlc3Nhcnkgc3ltYm9scyBmb3Igc3VwcG9ydGluZyBk
ZXZpY2UtdHJlZSBvdmVybGF5cyAoZnJvbSBib290bG9hZGVyKQ0KPiBvbiB0aGVzZSBkZXZpY2Vz
Lg0KPiANCj4gVGhpcyBjaGFuZ2UgaW5jcmVhc2VzIHRoZSBzaXplIG9mIHRoZSByZXN1bHRpbmcg
RFRCIHdpdGggfjMwJS00MCUuIEJlbG93DQo+IGFyZSB0aGUgbWVhc3VyZW1lbnRzIHBlcmZvcm1l
ZCB2Ni40LXJjNjoNCj4gDQo+IGF0OTEtc2FtOXg2MF9jdXJpb3NpdHkuZHRiICAgICAgMjg0OTkg
LT4gMzY2NDEgYnl0ZXMNCj4gYXQ5MS1zYW05eDYwZWsuZHRiICAgICAgICAgICAgICAzMDg2NyAt
PiAzOTYwOSBieXRlcw0KPiBhdDkxLXNhbWE1ZDI3X3NvbTFfZWsuZHRiICAgICAgIDI2MDg2IC0+
IDM0MTY2IGJ5dGVzDQo+IGF0OTEtc2FtYTVkMjdfd2xzb20xX2VrLmR0YiAgICAgMjYwNDUgLT4g
MzMxODQgYnl0ZXMNCj4gYXQ5MS1zYW1hNWQyX2ljcC5kdGIgICAgICAgICAgICAyNzUyMSAtPiAz
NjE1NSBieXRlcw0KPiBhdDkxLXNhbWE1ZDJfcHRjX2VrLmR0YiAgICAgICAgIDIzMjM3IC0+IDI5
NjEyIGJ5dGVzDQo+IGF0OTEtc2FtYTVkMl94cGxhaW5lZC5kdGIgICAgICAgMjcyNjIgLT4gMzUz
MjYgYnl0ZXMNCj4gYXQ5MS1zYW1hNWQzX2Vkcy5kdGIgICAgICAgICAgICAyNzkyNCAtPiAzOTkz
OSBieXRlcw0KPiBhdDkxLXNhbWE1ZDNfeHBsYWluZWQuZHRiICAgICAgIDI4NDAwIC0+IDQwNjUw
IGJ5dGVzDQo+IGF0OTEtc2FtYTVkNF94cGxhaW5lZC5kdGIgICAgICAgMjY0NTYgLT4gMzYxMDcg
Ynl0ZXMNCj4gYXQ5MS1zYW1hN2c1ZWsuZHRiICAgICAgICAgICAgICAyOTIxMiAtPiAzNzI4OSBi
eXRlcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ3Jpc3RpYW4gQmlyc2FuIDxjcmlzdGlhbi5iaXJz
YW5AbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0aGFua3MhDQoNCj4gLS0t
DQo+ICBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSB8IDE0ICsrKysrKysrKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gaW5k
ZXggNTk4MjlmYzkwMzE1Li4zOGI4MmFmMmJmNjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+IEBA
IC01MCw5ICs1MCwyMSBAQCBkdGItJChDT05GSUdfU09DX0FUOTFTQU05KSArPSBcDQo+ICAgICAg
ICAgYXQ5MXNhbTlnMzVlay5kdGIgXA0KPiAgICAgICAgIGF0OTFzYW05eDI1ZWsuZHRiIFwNCj4g
ICAgICAgICBhdDkxc2FtOXgzNWVrLmR0Yg0KPiArIyBFbmFibGVzIHN1cHBvcnQgZm9yIGRldmlj
ZS10cmVlIG92ZXJsYXlzDQo+ICtEVENfRkxBR1NfYXQ5MS1zYW05eDYwX2N1cmlvc2l0eSA6PSAt
QA0KPiArRFRDX0ZMQUdTX2F0OTEtc2FtOXg2MGVrIDo9IC1ADQo+ICBkdGItJChDT05GSUdfU09D
X1NBTTlYNjApICs9IFwNCj4gICAgICAgICBhdDkxLXNhbTl4NjBfY3VyaW9zaXR5LmR0YiBcDQo+
ICAgICAgICAgYXQ5MS1zYW05eDYwZWsuZHRiDQo+ICsjIEVuYWJsZXMgc3VwcG9ydCBmb3IgZGV2
aWNlLXRyZWUgb3ZlcmxheXMNCj4gK0RUQ19GTEFHU19hdDkxLXNhbWE1ZDI3X3NvbTFfZWsgOj0g
LUANCj4gK0RUQ19GTEFHU19hdDkxLXNhbWE1ZDI3X3dsc29tMV9layA6PSAtQA0KPiArRFRDX0ZM
QUdTX2F0OTEtc2FtYTVkMl9pY3AgOj0gLUANCj4gK0RUQ19GTEFHU19hdDkxLXNhbWE1ZDJfcHRj
X2VrIDo9IC1ADQo+ICtEVENfRkxBR1NfYXQ5MS1zYW1hNWQyX3hwbGFpbmVkIDo9IC1ADQo+ICtE
VENfRkxBR1NfYXQ5MS1zYW1hNWQzX2VkcyA6PSAtQA0KPiArRFRDX0ZMQUdTX2F0OTEtc2FtYTVk
M194cGxhaW5lZCA6PSAtQA0KPiArRFRDX0ZMQUdTX2F0OTEtc2FtYTVkNF94cGxhaW5lZCA6PSAt
QA0KPiAgZHRiLSQoQ09ORklHX1NPQ19TQU1fVjcpICs9IFwNCj4gICAgICAgICBhdDkxLWtpemJv
eDItMi5kdGIgXA0KPiAgICAgICAgIGF0OTEta2l6Ym94My1ocy5kdGIgXA0KPiBAQCAtNzksNiAr
OTEsOCBAQCBkdGItJChDT05GSUdfU09DX1NBTV9WNykgKz0gXA0KPiAgICAgICAgIGF0OTEtc2Ft
YTVkNF94cGxhaW5lZC5kdGIgXA0KPiAgICAgICAgIGF0OTEtc2FtYTVkNGVrLmR0YiBcDQo+ICAg
ICAgICAgYXQ5MS12aW5jby5kdGINCj4gKyMgRW5hYmxlcyBzdXBwb3J0IGZvciBkZXZpY2UtdHJl
ZSBvdmVybGF5cw0KPiArRFRDX0ZMQUdTX2F0OTEtc2FtYTdnNWVrIDo9IC1ADQo+ICBkdGItJChD
T05GSUdfU09DX1NBTUE3RzUpICs9IFwNCj4gICAgICAgICBhdDkxLXNhbWE3ZzVlay5kdGINCj4g
IGR0Yi0kKENPTkZJR19TT0NfU1A3MDIxKSArPSBcDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwNCg0K
