Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73275666D10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjALIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjALIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:53:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE913E1E;
        Thu, 12 Jan 2023 00:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673513558; x=1705049558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e7I3uF8DItndbWbsWodbFDjMrCXT5TMgpQOJmRu8kMA=;
  b=a9/3Fk3XKCHL6jptfIYKgkUfFMdHWVYqnZDqnvfOCa0Z7lQbOWSIB2eD
   RJCB7nhvNIxSVdIgktnNhrzDAzIkmrZoEAj9xGuOFZkmE3YsGxi4ibFWC
   OsO/1EIZ37kR9Q4hiRLTJjFNGdORoIRiZ3STQC/oYATH+9V5XHCuxrcwO
   C4ox5gsRffm1+pIumLscJ2dydclE+t0SOEWLgIYFxDlhikbauAGewEQwR
   P52qk76RcU0r4kWf1rTClc4f9uQHrzVhX9Ced2+QgnfUgvgPPseLjDLGo
   3l+GQF3BlZsdIq92Ui4WnpSQt0VaGWUHyVNxJgzC2Qs7pc8FI2EfZG+Nz
   A==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="207451672"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 01:52:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 01:52:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 12 Jan 2023 01:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlYS3QdmcA+usP0snY7ZDNoBGhBP/pSAAMYg8n+TCGKnzUA+XUPeZvyOPRhqXABnq+C7fRke8K+UR6KApGy6TE7N6/WoyHpmR9w8U/JzrCP2aemYMO30jdr02faotiU0OGBUBBPmMEpeOYnkyUbjSJoQpQW/bQnMZt0Ir9hbFbaI9ULSeixLicA8V3Y3eYZrnDlppX3mMbdcX2fR1AeOFPRnevWQvY4pR+HJNIbqbLDuLe0atxGZFHwJ1dIA3S1g3DbwTBn6WjlsC5ym5eExWRiQrLze8QnQyaFPbsgj9Hqmm/Ytj8AjkP+Yo83NfwneN6K4La0gOZUqI1Lp3hjCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7I3uF8DItndbWbsWodbFDjMrCXT5TMgpQOJmRu8kMA=;
 b=P9VkQ6BMcoWL0W/5Xozn6XKskEfGTvHh/LVebA9n0qVFexxDU0A4mvjoAqQYG4pbmBzLjJOiiVeNTEWUDteiMVqVwesxKOn0eE2v9boAxTTftP+GkVg6R7G0zW6zF2W0/zZjPstxktiTsidW6Kp854VzskzuWE9XDrUj//JHFlwugMRzTuXvXuuDVBebOkb9yawhL4PtA7Hf/dD4ABO1lrFby1QSkPVrZJR7Lgjx/L3uFQnF+85WxxBN2TjpOAybVkPga0qRJRlvcvfVcHeGLXVV2kZb52ycbQ19e/LUTmJNoBYUFO3IoM9XEfCSzk7aODWueqaVAXb/pMUqPHmnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7I3uF8DItndbWbsWodbFDjMrCXT5TMgpQOJmRu8kMA=;
 b=XowWIxbteCFoXtgxbm+UBRze3DsSjAHUwQXImlJEv4UC1QdKzrtR7oirXv+H7HyCseLMM9fvK9JoQaiwOqLaTyp1dRatwkL6glOlANsTTmvTmXpGCCt+We0vB3dFDye3CW/bVg1p4jV0qjqtYZye0jjOfK9DAL5w61I4ncO73yQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 08:52:35 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 08:52:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <conor@kernel.org>, <geert+renesas@glider.be>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Conor.Dooley@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Thread-Topic: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Thread-Index: AQHZJmM3OXPF8zKjJk2Fr/zn2GTuQQ==
Date:   Thu, 12 Jan 2023 08:52:35 +0000
Message-ID: <fca5a05c-fc22-ac2c-8a04-819268a29f4b@microchip.com>
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
 <Y78NWDc8b9YDqHdq@spud>
In-Reply-To: <Y78NWDc8b9YDqHdq@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: 3e9971eb-59aa-4a14-163c-08daf47a59a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bs9qhfCowCwHB+Je8RWrnRM6jMwGFj7aKKM33OouN/t7E7RMmjsBk37+6OLz7eaHbOVLpBlCf4SXmjd5S5S746gMM6Ku49ShWRJu1U4hV4Y7aVhNC9abe1LcMQijj+J9R1DKpqkIoshEObnTJeATefOgZ5vg/5OzSlwZ76qRRNhFbppPiCKgM6kHPoDrmDW0MlFrUPdo7ZkwyzXDg4aUp0ZW6JukEUy9hAJjQWYAMnYicSXy1JjqQ4I53MX0ZpNE3Z2tUuFBs0WwP9AAyFsKoSknQ8ONIPJz17fKQ17Lr57rFLG3VDRVF6WDknc6DFVxkgQag8cSjOjy0q73R5O3U68+Qm94JgcUyTV+e9ioqxk+8PJ/FmQT0DgxFuGaNUI4TQFdaO+cub9pmzSdwb9Jch5wW5dPkKxs1xse2uRP/v4gEvo+CAjT7rVQWiTekxkQitMDiisWUFurKWI4HI/dWbcBIbB1SThKaODko8mYOmUM0gg+tf0HUkBecf27I8pZYx0K7R/m1gl2AXEPQX4gDPYqnzlbyO9GNNPrPY3OjkBrPoN1iX4T17D1dz6cUXUyMG38pvHMr+2zR53mkp1O1LsC3ed+4z6Z29Tm4vYTqFNLSBvrkdqT+tsTtCzu9HuuzfYoTCdlFmd7thmb7rjZmdHiok5xd8s38RE5NmtxJQB7430MKvCr036mWTTkOmxOblfOSAkTYipALCXcsveQ9cGl/qMg/cra9cJreS2SxBaREPep1aY0bpAWYD9ttVjmxW0QySKljO+GH/2vaLA4wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(478600001)(38070700005)(6486002)(41300700001)(6512007)(38100700002)(558084003)(71200400001)(86362001)(31696002)(316002)(110136005)(54906003)(2616005)(66556008)(26005)(66946007)(76116006)(186003)(66476007)(36756003)(122000001)(5660300002)(53546011)(6506007)(2906002)(8936002)(4326008)(66446008)(8676002)(64756008)(91956017)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2YrV3gzVUNoUFNGNURCTmRrek5iOHBhNVE4QytudlV4WFhpSkNCbGlTMUNz?=
 =?utf-8?B?QWZTeEc2T3B4VjZ2RUhFTHNsa1hCeGY0NkpmdWJQRzdnT25VUlYvUlRLTGNW?=
 =?utf-8?B?bXltZjE4TlE5dnkvS052YjZZWmZyenVtQ3BUaUtpWS9yaEhCWkcyRUdKNVc3?=
 =?utf-8?B?Y0I5R055NURSekl2Tyttd1o0S1NVaExUaG9qQ2NHREMzQ0pVdURQKzZtZ0dr?=
 =?utf-8?B?NnhDcC94NFNFSnRCQU5PYkc3bEh0RVhxc245dHNKRWNZSHh4Y0VMTXYrWnpz?=
 =?utf-8?B?aUd2VEVybHVycmh4WlBWbDMvdk5zck1BWFgyZFBPakZtU0xYSFRiSitWK2gy?=
 =?utf-8?B?UFRkZ1R2NmY0WDNuV0xMVkpsUWs1SkwxZTJTS2w0LzZFRnc3TFVGL1ZySzQ3?=
 =?utf-8?B?ZURwUXJsbDJ2dmhWUEJsTmVRTGViVlRGcUd0SHNUNDJrWDIyU0orTUZ3WGxp?=
 =?utf-8?B?TWE3Y0ZlaTV0citOOUhjVmpGTXZ3cXJWemJHT0licUMwTEl0SUIyY2QvaFJW?=
 =?utf-8?B?L1YvMExZT1FsRFdHZVAwWStTUVhFcWRESTNwNm9tbHA1V0VFL2x6SmI3aWxB?=
 =?utf-8?B?K1N5QXV3dHN4eHQyQ0NRUERFcHpmUk00NUd5Mk9WRFVLZkpEZTBTR3JjUDVN?=
 =?utf-8?B?dTd6ZnlKQTBrdEYrUDA4VkJnZWwyQ29Id3ZpUG5mVFlPdUlOajdxV28wWEJW?=
 =?utf-8?B?ZytXYkM5MkFvc3hWS0xSZlNDV05NYXpVOFFZbTdnS1FFaWVOTisyN2NRR0tX?=
 =?utf-8?B?cktOQ2NaWjh6Q3oyOW5ubSt3WDM5NEx3dTQzbXFpVk5abDBnVE1hN09CaWxR?=
 =?utf-8?B?b2REWVQ1OUNMUE9OK0dza3ljYlVjdEJnNFlqZkFkTzlEMC93VUplNkZIRG10?=
 =?utf-8?B?Qjd4REVvQUZscC9henphbXhKRXNrNjM3ZlMyZHNWZ1ZTWUtBYjFSZnlYM0FS?=
 =?utf-8?B?KzE3ekFLQW15OEE4VlpnZ1ZQclNLbXliUzlSQWd2OVNqckxxcUVwaElCaHFz?=
 =?utf-8?B?S3BadjQ0N3QrZzFRVm9JMWt3TDNXZ0dZcHlyd3crZU00dk9yT0gzTGF1QTZ0?=
 =?utf-8?B?dmtPdnRDOEZmOUlacWVkRUxSWi9VN1VZR0hDU0l2bWp2ZFg5bDVjMkF5bnoz?=
 =?utf-8?B?UnRTQ2EwT09Hc2NjcXQwV3FyTGphYlRVdUpIK2wwMyswSmZCb1hCZUNLbkNS?=
 =?utf-8?B?dTZoOHBzRUovakdaNmRtWGJsWVJXSTFUYXBCNkJBQnZxMnpWaUZNU3NpTHBn?=
 =?utf-8?B?YWFMZnI1Y3JIOUVUMFFWRWtRcmhUdkpZcG5tbk5hc1F3SmF5QzEvbktnSWRY?=
 =?utf-8?B?bURtZFpiWnk1MDVUMk5mNzZwZnNHeHliQ3FPNGpMNjM1dEJyc2VwdmlPMEFj?=
 =?utf-8?B?eWRXK0hpcWplRzFhbXdQT0FkdGVTLzlkdGx1Q05rbE5UeG1ZdnFwWFcwZVZl?=
 =?utf-8?B?c21TaFVtQVNXNWR4Z1p1cC9tNGY0Rm1WazZuSG5ZQlpaSGNJS3FkTDJidXNu?=
 =?utf-8?B?NTAzc3JXcWJ1ZXdVOERyZ05WcVlORms2U0NEMkl5TUN4bHlQK1dObXhpci8v?=
 =?utf-8?B?SVBOdE1xb1NuZzZCQW5PNDhPK3J6eFppTzZYZEZXQWRNQlh2V0NQWXhqekFV?=
 =?utf-8?B?VUh0TWl6aG9oaEE3U01oN2R1OCtGUitoZy9uQUNQZ1MwaTRWSmc2ZnBMdldt?=
 =?utf-8?B?ZW4vS0g5QXMxR25ZOHNXek5SbnJDeExEbkV2QmtGOGZtY3Z5aERrVVlTc21j?=
 =?utf-8?B?U05IN0c2MFFUeUhDbnVCaDFVOGpyR1dIMTRiT0QzWkNsRlBNSVlkdERnVFk4?=
 =?utf-8?B?Ymo5WC85dndOQStSWFVRMWl4Tk5mOElMMllVNU8zYXpHSUt4QW4weUtjdFk4?=
 =?utf-8?B?QnE5TmF4OHpFZXFkdDV2RisrSU1qbWE0cCtPaXFXOUhBNDBSZ25ySnBNeFEw?=
 =?utf-8?B?aStrTFd1Q21KMzFrSVFIb1VKRGc5bjcyVVpIQ3JXSzlFM2pFNHBiOFhQZ0tR?=
 =?utf-8?B?QkRCMFZnTWh1dTJySVZ0MEhQTHg2WmZ3YS9uU3Fia2Fnb3BNVG1qeHFsaUFa?=
 =?utf-8?B?QW1VMVRqQWdYSkovVjZOcEVxbVpiMWpmYmNNdXVmUkF6L3NCMHNLWnhOUFVq?=
 =?utf-8?B?V08zYXZnVHBTb0VzZ256UENMdFVuenZiV01KT2QvTTlWb2ZZR3l3d0RzME1Z?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D22C0CFC697D324C8394ED605A881CE4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9971eb-59aa-4a14-163c-08daf47a59a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 08:52:35.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJM5NlRf0XFXu9phK3Nvo89KqUtoWrKwdtLCrlRYavTd2csVRt7MFYILqAeid80AYXOt9T8FExU8MB/UJKNDBBnbjDDiT/Kon4vQ+sw8GHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENvbm9yLA0KDQpPbiAxMS4wMS4yMDIzIDIxOjI2LCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IEhleSBDbGF1ZGl1LA0KPiANCj4gQ291bGQgeW91IHBpY2sgdGhpcyBvbmUgdXAgd2hlbiB5b3Ug
Z2V0IGEgY2hhbmNlIHBsZWFzZT8NCg0KSXQncyBhbHJlYWR5IGluIG15IHRyZWUsIG5vdCBwdXNo
ZWQgeWV0LCB0aG91Z2guIEl0J2xsIGRvIGl0IHNvb24uIEknbGwgbGV0DQp5b3Uga25vdy4NCg0K
Q2xhdWRpdQ0KDQo+IA0KPiBUaGFua3MsDQoNCg==
