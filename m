Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E0A5BA21D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIOU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIOU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:59:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8806745D;
        Thu, 15 Sep 2022 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663275552; x=1694811552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5/XO/S5i2cWauhIqYQa81VxAFCIRu0R7WRhloSaKrxQ=;
  b=SeDf2qAaekMv2aKTnjAIi5NKQXKkmfpzCfALsq8SxOcCb6V2HPVt0ttx
   EDa4vlreqo2deMjtouiHJnbF46I4CxdJiyu3y4krw6LcqXcoppM2ubMMV
   2rm8D5+qOUcTXkQJu/xOBxxo9rwJxKtm23Syj+fTyf9ZjYMb+VG6HrftB
   lzDN1Cc4w2gm13hHoOPqgKevFSPNkzueAxtgmiTm3UQExXRFmmTgYSrrB
   UM+nCEy7bSObSM669H6VNhPwyhRGSHeTvHmHIYNH78+fIfuWpf8CZoQli
   pQAJaVdsU8/qUmVZauuWyYkEpcvZ0IR9/UfWeSnSikGh7SO39aM1P3vZf
   A==;
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="191067270"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 13:59:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 13:59:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 13:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz6G79IF+899goIJpNQxhKEDD1OHn+F0mhlBXgWAte5fpswtEmf2xTxiBPW7+cB/QIjylTTNaFSElVUTakx6V2Pi+BiVCDJ8qhWvm8DZsFI+aENI67eN3gsFlruKhJ7jLG+QRBxBcu4bD2UiXpuA3Re9INE2Cwtm+d7t6p29QOlt003lG6bla6HV8NxSfNic+/lwHxgkaSCoLzr7voieSBQMVJ/Rui4P17/1qg/E5JanqatlhtzkovFEc1fHZr/9bOi9a51MTrPdsTnWGqFlQwloTE+biRAfB4OzwlfwsSBzWevVDdZZQF0px710n69i33v/ZE1mt9D4jUCNPYqE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/XO/S5i2cWauhIqYQa81VxAFCIRu0R7WRhloSaKrxQ=;
 b=VCpmskesIkjse/xxfd0c9p8VkubIx4B59NYl4Upb2Vmap4zoyEAepN9ui3y61QA9IqtcduKEiwHcNxOsvMWm5HIipeT9HLs1Q+q2b5AIwP4F3UVHNljutEeKBfHbOhu8XQBg7d5U3g/OWZwK6odSMo0HgaQW+/IOZ3PhZY0nnDt+e4r+jmk6IYU4gXe9/t8pHg9DCLzVM+H7vRkYhW50F4VQgta2Re3oOFiLktN5HdCB0MdKKJAjdi1vUuqedZup1KeZUnlYwOk3W5Lvn+vQfhtH9jXGUsycvwTQXZFnmZ/kjoH7ffkkIlBV9+y68hiGfzzBzZr69qDCIGp38fs70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/XO/S5i2cWauhIqYQa81VxAFCIRu0R7WRhloSaKrxQ=;
 b=OR09RLsgi+2ZAPcAuKIekTJnqjvaVMdwDM3zBRnPdeZDm9/xj7UWNNa//zUw+mXhGTVd2VdZs/hs6Vtx3XBXPcYv80aiLLbFNYOyDydvuiam3jkZ56HV1z2YUtmXqavL8zog7MgzjawT8159VvQuIjXuaCC1DhmXKUhFD+T9hzk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 20:58:58 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 20:58:58 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <geert+renesas@glider.be>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <heiko@sntech.de>, <atishp@rivosinc.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 05/10] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Topic: [PATCH v3 05/10] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYyS+BB7don9LvSkGu+r2oTiU5/63g+ZKA
Date:   Thu, 15 Sep 2022 20:58:58 +0000
Message-ID: <126c611d-b421-cff9-6384-bc468be7ec73@microchip.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915181558.354737-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SJ0PR11MB6741:EE_
x-ms-office365-filtering-correlation-id: 4f092f70-ee20-4450-a019-08da975d1c26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnfeHDb3Ju2LuU7BYrGXzUmeyAQ8DRkoSCIIHf3aAQRjh6TuS9buPOf5RITdsYd6geuGH1D6dm2hbEh5g6wPXRXVlqjEAez6b4OPE/NolsmJPStuYltcwuQUGDau6y+siq2JlYYg2iN9rc7dv7+gl2bYsQbwta7q6KU48/Dm/CkxbX8mrTvXRXcvfHdz2WLQzG1MO4EDTySybgJ1QQDGoS1KMtxVufpzQrDE/qPid1kovHeyXGI83sIol0mq6z99rBIS0/iHKMvJxkHJBQxiNVzoC7Jbr6qfVMNlZK6EmR/Ojrq9qIRA4ZEoTm9p7nLxYmTMMGwRu4MjgUfnhksHKKohTgzfVj+o7MiAL+pCzW8qQMaW/LzH9QsORm5cZYR+R9khoKKVroCXJj6NH5pG4v9YJ4pGFocCKToLchwNlDCovdktwfW5rzKiQhtSDVoXfQevp8osJEzp2nUJFicoeh2MkQSypEvn4D8xZBqGN4ii0RYSQGxDDFihuRDztBvzLW0vIbLUN19HGYA+x1fQoh/BQCfem/0PvqGsGtOkMhk/z+DoNj48g5wgIjU30ZfMVbGlGhFs792of3ZYkEZF8DEls0NPRcniSHeJWzn/HmA6/D56x2qBN7LwcF3v1XdM6+SzG1pMtum61XVDFHMFYB9DMmmLiVaJ3kS8hVNjE8h31mGq/L/8dHVfS/1AgVdofwZ6N7FQkPdgVpnsrV6xGigN3aQSPHXD7MFbbrCXWr6CXMUgSTtMg8T2iazDpV8s2ODtWdAauPANxILloo2h4IJlJe5HQvtr3pytk9KRnk9iLQt1NyEaWz4gbA58ea+22VzquniakBsPM2MF5TuLmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(122000001)(26005)(6506007)(86362001)(38070700005)(54906003)(110136005)(76116006)(6512007)(6486002)(31696002)(66476007)(91956017)(64756008)(186003)(2906002)(316002)(36756003)(8676002)(31686004)(478600001)(2616005)(66946007)(41300700001)(71200400001)(66446008)(5660300002)(66556008)(7416002)(53546011)(38100700002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEU1MzdIbVFlSUkrNHVZQUxxM3FBeTN3NTBHZmQxRU1wZ0xOVmswSW9NTE9B?=
 =?utf-8?B?ZUJSOGhJb3h2UXFWeCtNdFUwYjFDOUt1UWxiZElLeDQ2UXV1dkFYNURJUFFC?=
 =?utf-8?B?SzhwbzNYdE5pRk9nTUd6THQxcHcxNVRBYmcxbmQ2cWJtdWhibHJyME84Vmwv?=
 =?utf-8?B?c1BPTUFTeGs0SWUwWDl4aUFranJOTCtOODBOUFNwSzNHYXk4ZWlRekh3amsx?=
 =?utf-8?B?bDNGbFIyQWVlc3h0QjlUR3JsSjNpbFdHUCt5U3BkR3BITzdNcEM4WmR6Sm1V?=
 =?utf-8?B?S3g3S2hkdGRwd25wdGRqQkswalFpeHRNOGhINUJsa1lXNjRYMHNaUVI1d0RY?=
 =?utf-8?B?ZnQ4bVZRaUFQUnJqaElNTXJkWTJMNUxUaTM5bnNyYkczcld6WWE5Tm02TnU4?=
 =?utf-8?B?WXpHdGl6RkRXK0p2M09wdG9ERXgvWURiNW0rUURoMlRNTWVKZExRM2RVcTFu?=
 =?utf-8?B?Z3NZMUVhVEpRb0hHRlRxN1lEMUlNV256QUpjQjlTS1puV2Q0aUtKUVZqK25y?=
 =?utf-8?B?UjgzenU3bVhtTnRwWEQ4SXptTkxuem5zWmQrRkIwdmN6bjVkWW80N0NDcisy?=
 =?utf-8?B?eHBDT3lZVkFwRWtpa05QR0dxak5Ka3V2RmdQeUhaZzNBTzVXaDlGTHlxZlVO?=
 =?utf-8?B?SU4rOUR4NTRHa29kUXRUZUdLSXo4NDFnKzEyOXB1ZXIxZGMyUzAwUDJ2THdC?=
 =?utf-8?B?SGY5TUJvbjJvN21xOEUzYkNiWjFtTHQ3b2JjWFV0VTNrTVpFZVZVT3Y0aHlT?=
 =?utf-8?B?MDVkbDRxdSs3WDllUzBYZXMwTlh2U1Q2MG5tRzVDUURBZjN2ZFBYN0s4cFRs?=
 =?utf-8?B?ci8wNCtNbU14eUg3S3BySzNlSFhpaXdwdmFGQXlXZHVoL3dxMTZNWFhUTUxO?=
 =?utf-8?B?Njd5SHBaSEtFa25HbDlHUHhhNE9iWG91a3pMamI2Mm1qUXFYSURnOUxxMnp4?=
 =?utf-8?B?TGQ1M28vVkxwb3ZhNURxblFZM0RWY0YvMEtPMmlJTUE1d2l6U2FIQmI4YWF1?=
 =?utf-8?B?bnZOdlpFbW9mWko5SEZHZlNHVnpFcUZpK1hMdXVTNEdhekswYlFvZ0tlVlVk?=
 =?utf-8?B?dUE0bTJiU0Y4eTk2eGw4WWtvazlRM3pTUmJFM05HM2k5RlpPYzJtdkZZeTBp?=
 =?utf-8?B?SXZITGd2UGFhMUNQc052Wk9PcHdoSmdTUkU1clpVZHZ4RlhMUWNMUlVIeUtT?=
 =?utf-8?B?aW53VWplNENMQUFWKzVuNzFQWGYrRVRvRzQxZVlBQTE1NU1BYlRXOUpIMTFC?=
 =?utf-8?B?WTBWWXZndGFyZHM2YW5selZLendwYkVBc0c0d3NaT3ZhSVdUbmFJWFdmRFFx?=
 =?utf-8?B?MFYwQlliQXZiaWhmYXVCS0swd05YOTNxTWlqRjh3bEI5VUpwLys4MjlZSkJS?=
 =?utf-8?B?N1J5aUVZemNxLzE4NVhqeFNNM0Q1T1paY2ErTWtYc3JJd29lMFpiYndMVHJC?=
 =?utf-8?B?WU9YMVlnQjIwdXQxWnFpVjN2OVY4Vy9VaTc4d1NnMHVTeFBNTE52enNmTzZZ?=
 =?utf-8?B?Z3lXS01NQ1ZQRjhkTlVWT3dmNGt1akpXN0pFbjQzcXVqSkl4aGRKOGpybm8x?=
 =?utf-8?B?Umx4cGF0WGdSZ3RNRnhGU0xYUVlpTkgvcEVaRjRmMkZhcVlMYmxyd3RXVUh6?=
 =?utf-8?B?T0NZSDJOdFBNRlZXREMzbmVXQkYvUDFHTnl0MFdON1VCWjFKSTZWTlZITkl3?=
 =?utf-8?B?RVc1c01HVS9nUlJRSU1QSU1ESExpcWpkRDBoOFp4ZEpxZFNQU0JmQUszY2Fv?=
 =?utf-8?B?MWRlTjdBMzF1SDB3aWNUYk9xaDZvNEtNbzkxSEs3ajQ5RDdEbjFJMDFwdHZt?=
 =?utf-8?B?Mi9aTjY3TWJzT2NHNXZtMlU0eHAxL2RISlZrQk1zV000ekI1S3phNGFxNktR?=
 =?utf-8?B?OTBuWFZITm85V1FoU2NtRXhNbVFUNldkdE5oeitmaHZxWWtZVDBvR3h0clhp?=
 =?utf-8?B?ZTE0WXpoNkY4M2JSa2p2ZndseWx1dmlvbks1UEZCa0Z0dkpVcjNieStzdkpp?=
 =?utf-8?B?SXNIZGxONzRva0dkb0lEYTRTazZJbG9odmxhQ3JGNGZqbzhIcUlIR2FVTWh4?=
 =?utf-8?B?bE53VWUycmI5alF3emxreHpXOWhrMWZDcEVxbW5uZzZ0OGJzSXMwcEsyRUZ3?=
 =?utf-8?B?NlQ2QVFjR1p6b3NvU1hmMlFYVWhpbkxYcjRzZkdyeW5FN2kyeHZFdXJMaXEw?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <158558238AC4EE4BA625027A3BAC2D25@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f092f70-ee20-4450-a019-08da975d1c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 20:58:58.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnIQQ0jdjaxtUpO66BDjl0jrFIDPv5aMPWdno3dFSE/54oEoyCFtF3ccGWOURXA/OzXa7yBL6FQ5gf9HsBzyKB/BAZWTm2CHfeE/uJ/q0Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDkvMjAyMiAxOToxNSwgUHJhYmhha2FyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5t
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEludHJvZHVjZSBTT0NfUkVORVNB
U19SWkZJVkUgY29uZmlnIG9wdGlvbiB0byBlbmFibGUgUmVuZXNhcyBSWi9GaXZlDQo+IChSOUEw
N0cwNDMpIFNvQywgYWxvbmcgc2lkZSBhbHNvIGFkZCBBUkNIX1JFTkVTQVMgY29uZmlnIG9wdGlv
biBhcyBtb3N0DQo+IG9mIHRoZSBSZW5lc2FzIGRyaXZlcnMgZGVwZW5kIG9uIHRoaXMgY29uZmln
IG9wdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5t
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IC0tLQ0KPiB2Mi0+djMNCj4gKiBJ
bmNsdWRlZCBSQiB0YWcgZnJvbSBHZWVydA0KPiANCj4gdjEtPnYyDQo+ICogTm8gQ2hhbmdlDQo+
IC0tLQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MgfCAxNCArKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L0tjb25maWcuc29jcyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+IGluZGV4IDY5
Nzc0YmIzNjJkNi4uOTFiN2YzOGI3N2E4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25m
aWcuc29jcw0KPiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPiBAQCAtODAsNCArODAs
MTggQEAgY29uZmlnIFNPQ19DQU5BQU5fSzIxMF9EVEJfU09VUkNFDQo+IA0KPiAgZW5kaWYgIyBT
T0NfQ0FOQUFODQo+IA0KPiArY29uZmlnIEFSQ0hfUkVORVNBUw0KPiArICAgICAgIGJvb2wNCj4g
KyAgICAgICBzZWxlY3QgR1BJT0xJQg0KPiArICAgICAgIHNlbGVjdCBQSU5DVFJMDQo+ICsgICAg
ICAgc2VsZWN0IFNPQ19CVVMNCg0KRG8geW91IHJlYWxseSBuZWVkIHRvIHNlbGVjdCBTT0NfQlVT
Pw0KTm9vbmUgZWxzZSBkb2VzIG9uIFJJU0MtViwgaGVuY2UgbXkgY3VyaW9zaXR5Lg0KDQo+ICsN
Cj4gK2NvbmZpZyBTT0NfUkVORVNBU19SWkZJVkUNCj4gKyAgICAgICBib29sICJSZW5lc2FzIFJa
L0ZpdmUgU29DIg0KPiArICAgICAgIHNlbGVjdCBBUkNIX1I5QTA3RzA0Mw0KPiArICAgICAgIHNl
bGVjdCBBUkNIX1JFTkVTQVMNCj4gKyAgICAgICBzZWxlY3QgUkVTRVRfQ09OVFJPTExFUg0KPiAr
ICAgICAgIGhlbHANCj4gKyAgICAgICAgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciBSZW5lc2Fz
IFJaL0ZpdmUgU29DLg0KDQo6dGhpbmtpbmc6IGlzbid0IHRoaXMgcHJldHR5IG11Y2ggd2hhdCB3
ZSBkZWNpZGVkIG5vdCB0byBkbz8NCkFuZCBpbnN0ZWFkIHlvdSB3b3VsZCByZWRlZmluZSBBUkNI
X1JFTkVTQVMgaW4gdGhpcyBmaWxlIGFuZA0Kbm90IHVzZSBTT0NfUkVORVNBUyogYXQgYWxsPyBX
aWxsIHNhdmUgbWUgaGF2aW5nIHRvIHB1cmdlIHRoZQ0KdGhlIFNPQyBzeW1ib2wgd2hlbiBJIGRv
IHRoZSBjb252ZXJzaW9uLg0KDQpUaGFua3MsDQpDb25vci4NCg0KPiArDQo+ICBlbmRtZW51ICMg
IlNvQyBzZWxlY3Rpb24iDQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
