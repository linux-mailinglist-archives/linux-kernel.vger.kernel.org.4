Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150C95F4F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJEFs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEFsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:48:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF872B4B;
        Tue,  4 Oct 2022 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664948932; x=1696484932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0+AXWJO+VI6ZKP3pkBTckFt3P+jYUsNXIvMj2g4Pgc8=;
  b=X2K8ZiiWghgR11mxGpv81YmvVSKn45na0LaAUADo/HQYO2msoTcmMH1y
   YagVEGRSK7UDgBwTwNaCZOGsmabJefnb07r8CEsZ9kFf1aLK9NVzsnHyS
   5nL5HYWfTpetOtb3jVFvOEQNjTvZ8pmc4Z7AbF0SSKNJUVdlqua8S3dv/
   fv45iKpQiRukdKY7MlsZpOxEt9XaSScX/g4gfho3cHYmmy5mm8jl3Zfls
   81l6Rvf9R4snq4C2LugECzSvVqsWgp51FX6i5Lt6tYbjzHpBuuqyMlTNg
   WW9pL5P/dW+xYfHCjmXwUkiWEnZF6azV8I4zCQp60bpQfQk7XbU9bmBv4
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="193863403"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 22:48:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 22:48:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 4 Oct 2022 22:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmtGt5qUMvKwv7YayAGqXZ/YwUC2wc7PmjZeHPOzJpr1IoTgGgnKMYSs+Z9aK3z4Abn5fj+U3CwvyBirREIlVkpPAtAlmjC7q8sClQuZroAsXfhTQsYgcvwqCsfjNBTUVeIr4Fwh/++TDefXDOrsVEMG4DFJicp3ExPDlUVK/apJ1lybjV/wvEMedTjbp9hub0Oxn/kds7q1kASkHG2BiVl/tfMeJ5As1fMNuUnSq7S4Rs9RU8DeHHU76Z0WuWCGOucm9bhUiCy3Z2GdnNREHATDxZ4reLJ6VYyEQzWqvW76GSe9NGk2dhiHDEA5QVjsiAQenq0MpFu0TQ1a1WtynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+AXWJO+VI6ZKP3pkBTckFt3P+jYUsNXIvMj2g4Pgc8=;
 b=l3VCXfqB2QK5qhJk56GLcF91yMU2ioiNeavIPUrL/bdNaZkktyurgkFKPh+PJxtudUJpS/PKjkpBReoxszUnTFBNnWjpISqrNA8X6MT8I8+ASYQWHjBPTlJfERT13XUqcCsgcI1Eko0BTGYsTxPYAoniagEn/MudrYeqUoZz+XmgNFeWnlWUazoFgEGqCyonlT5qFaQW56uQKDs8xt8+QwCWb+Ev8FZcS9GCj4MvqrG36V6X9ErlUhuiDUU+co7T+U6XexpmZ1K5sM9rmvxtT9miVTzB+ZbrBxTz44+D/+7RexSjM+cfO8ha42AODVcmQFNeuzqFpTn4Xf0NAIZT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+AXWJO+VI6ZKP3pkBTckFt3P+jYUsNXIvMj2g4Pgc8=;
 b=Pdlu8XQAhhT+nyEHJvWyQY/b8EFgxJyDddhZ5vOidDgB+8o+7hrJw7AkE/yyrOsDknesOFPF6Cf5bc5erT76FUZ6DB9jBZOO/KDgf1AN40qgoDWMYALzyKW7p7wrbVMEvO8qN4FoSAlxeSU2XIF6MizYxvZ/46TaL8W0v08WfFQ=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CO6PR11MB5572.namprd11.prod.outlook.com (2603:10b6:303:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 05:48:46 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::94df:cb94:4d1:3490]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::94df:cb94:4d1:3490%5]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 05:48:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sai.krishna.potthuri@amd.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: Add support for flash reset
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: Add support for flash reset
Thread-Index: AQHY1wyOMVqeK6UYGEuIaAC9FCmatg==
Date:   Wed, 5 Oct 2022 05:48:45 +0000
Message-ID: <53b7f736-1f5f-7b89-671b-536bb4e02d77@microchip.com>
References: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
 <20220908064428.2962-3-sai.krishna.potthuri@amd.com>
 <7777b2fc-8c22-22dd-1ffd-dfe8a21ea0d4@microchip.com>
 <BY5PR12MB4258E91B51E4F7836828744EDB5B9@BY5PR12MB4258.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4258E91B51E4F7836828744EDB5B9@BY5PR12MB4258.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|CO6PR11MB5572:EE_
x-ms-office365-filtering-correlation-id: 23658fa3-77dd-4912-6355-08daa69544a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lu6J3JNoY31B71nKpvYzsV95CKCjjhmI1GSe0JfcZYavKWeErg0ctZecCyHvHzZBApGQuel+Dcb88KNu1w0PoJzEk5P+7WpTX/GeTsMwOF1iMG5NgZkMPv7bQSyIdJze1GdJP2mvfwH3YSJB/qiFtqtkY4UgwRUQ5J8a0eQF5e7DvcMVX5KovzEvv+oYMk7eRfArCv1bxJGrJEsT+gY7KtQ5x1eQV/6fOEiqu9DUxYYNiXwoBZ0ijBxkt9Ck8Aga+2KJlo54LIcuajG522ceLKZqXSvU6TiezKQkY4VtiokMrr3f1C+JDK6I23F/Laf/5Vv0trptCoNTB3vT3WQGJLARkYuCd8dhjkSyGb/yUHXklwbM8ExDWmlagRKcKw1BzQ0uTVv1qjoH2jAGxW/NtAQm9b6Xvn5XQ8za9vEiWi5OK4K49MNCWpwj0riDr1SIbUrZch9ehHI7ENd8JhqH25ddo3b1YncWwZfT8RzIpSQDOYNKALbuS9uiOnIa/Uvq9zOBPtJT0xKov3QaDNashpDn7C5nMdCSY7H+GYWkfq9mjTJZQepPyW8ZkJEQQrqmXWAP/nYArJd7BbEp2zyPPMJqCn1XZWhcgCjLuXKa6o1WE0KqX46yo6eMsWZjPkvcxo1enVcR4axM0mo4zIoydN7xP59QpzXUYuFlTk0ro/bpt/ADRqCUGS7W6qBqziqlJZj1rPaF+3/ZoZ2FZbQowm5djvB9+lM2eUW2XO2EV/ifMSSTOvnMAXvxclwwhg4ndO7KNSgDJevuLZE9NGU8Xja3ZckEFf7J7m2SmGFl78dsXzSsI1SXQfvOgLjofcLgGmPrh5/yAhUfkLPau83l6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(66446008)(76116006)(8676002)(66476007)(4326008)(66946007)(66556008)(64756008)(26005)(53546011)(6512007)(6506007)(54906003)(110136005)(2616005)(186003)(8936002)(38070700005)(36756003)(316002)(91956017)(2906002)(5660300002)(122000001)(38100700002)(41300700001)(31696002)(83380400001)(86362001)(7416002)(71200400001)(6486002)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3lpZkJ5ZnBwczgrZkxrb0NBQllyQVFqaVh6NnBMdWlXUXNPR1dDVmI4WFFy?=
 =?utf-8?B?SzlmRGZCQmZRMTZXMzhXeDVORlpRMHNERVkxSCtIU2N6M01EVkpRNk81YjVw?=
 =?utf-8?B?VlFYVjhnSmlFVExhYkN5bXVxaVV3VXV3M25LY3IrRTcxa2lIQzR2NFVFazdG?=
 =?utf-8?B?c0hLRHU5QXloa2RZTWt3MmI5cWdMYzRMVExFdTBWWnZqbitycTJhbkhOak16?=
 =?utf-8?B?ZFpTYXovbDNJTktlanN5ZWhjUks5a3RsbW5ZVDZhQVF6S2J4OWxIc2RkUDNh?=
 =?utf-8?B?ODh1WFNLQ0dtQ3pIZ0dESzg0dkVVSUNyTlo1NkVPUGJkN3ZseDVNeU4vcDVO?=
 =?utf-8?B?WnVQVFdudzRzZXlPeHdOVTRUSWVDbkw5c0dXTjZNVW45TjNKWkJ6RTlZSTJ3?=
 =?utf-8?B?L0NrUE1jRnhqNll5bjNVeEtwWGlFeVMzMXZxMHVqbEdnaVp1OWZnL1lEQ3dZ?=
 =?utf-8?B?SW16eFAzeWdBanVNYjQ5cjk1bndVZU5LTU1ERHlDTEw0a3FNYUtuU2xHcSt0?=
 =?utf-8?B?WmpMTTZLY08yZW1YVmxyK1hHRVJUVFRETC9XNW43MkRaQ3NqSlBYc1pSUW1E?=
 =?utf-8?B?ZFRpNVZNeFlHeTVXYmI5aEhpdlpZbENpaEpUcEpiNUdKTFF5OWRKTUhhSXVG?=
 =?utf-8?B?a3Nkb200ZmtRaEh5NGlUd2ZHcnRvMHVVczJnaEJEa3c0NDhXcFY3aGwrTGc4?=
 =?utf-8?B?bEZRTVh1WnNkUW9CNWdtUzMwaHRxampRLzJWcWFKNjBJUkhJdlFNZlRjNjZ0?=
 =?utf-8?B?amxhNnlRK0w5b3hTRkhZY29YcEpuRmhsOFh3SnpwSU5ER2R2L21Ub3VHbXgv?=
 =?utf-8?B?TnhmUHRVWmwrdjBlR0YxTDlMQUUwZFM0UGNIdHVyOVJYUnNyNEFrK1A1UDFT?=
 =?utf-8?B?b3BoTGlxQzdKU3dTZzNEZlNjUzJydEpKc0YxNTQ3R050bElJRW0yQjM2cFd4?=
 =?utf-8?B?eCtCeUxUZ0h1ZVFZRXFzcVFnUTJYa3RPWUwrdjBCZWRmQWtxVDVPcGlGQVBm?=
 =?utf-8?B?enJUQmJhU1lIaVQ0dEw5MWp1aVRKMGFweXQyb1YyRzB3RzF4ZEtIN0hSVDNR?=
 =?utf-8?B?dmJkck9QRzNDWGtNaEUwa3dsL0cxRlVqdlF3SVpUWEljRDhEZWIwaVJTdnhW?=
 =?utf-8?B?SEUrOVNLcGs0dmtHcXQxamhsbmtYTzVYRTJXVzlJSG1DOUxaM2JoNUFUUGhW?=
 =?utf-8?B?OFBzdUEyZzU2SXVSdDZSNjFPeGsxSjBZUnRlSGM4UEpoYSsya1N1UmRFQk9U?=
 =?utf-8?B?TWsyTWlQaFNFNExUTW9NSmJnZkFZMkVhOHJRdW0rTEQ3N0Q4eGViS25TTzM5?=
 =?utf-8?B?cHZsRjAreG1ud3RZRUluZS9GUzdhTkk0czZoaDcxbERtVWVCSTh6Zm9sTTE5?=
 =?utf-8?B?eXlSZSsvMmVTVmJHWitZS0RwV1Z6SExBb0g1M21YQTl1TUVZQUZUalhTMWRB?=
 =?utf-8?B?MFhXclpLWnZnY0ZxMU9DcHVrMXZnR3AzL0pSbzd5bVNFM3ArUU5WN1lqYlk1?=
 =?utf-8?B?ditOSC9GTHRMT1hGdGtLY2FCVENJYmtqODM3MjVGekgwQmlpYm9nSDFUbGtG?=
 =?utf-8?B?OTl4anU1eWZaa0JHNnNKK3BqWXNidVYvd3ZMMGFBbXlhVlpZQ3JRWlhva3ZE?=
 =?utf-8?B?ZG9aYUpGUVFvWWJmVC83WnBlcGVjSFozdTkreHk5bENnanlZOFZHL3MzamZs?=
 =?utf-8?B?M1ltWnNxbU5JTWJoS0V1bFBKblJxVkhQWlpEUEtBNGRZNkQ3anlVRWJzV1I1?=
 =?utf-8?B?aWM2TkZSenRZVWZCKytZMVZtYXhXM1Q3VEJhWUJsdDgzUlh5ZXRtamVPOWt2?=
 =?utf-8?B?MEV5NVdaUFp4OFVBQXlkTlFJODVDN3pQTUpyUHRGYjNaSzJzL3o4MGJmNncz?=
 =?utf-8?B?SkpGMFYyUWZBQTJMV2hhL0hJbGw2elVmcTdHZU1VNUxRL3dBSEJwWVA3TnFH?=
 =?utf-8?B?Wi9iVTlUZlF2MitjRWNQL0hUc0l6bGM4Qm4zVC9UUmhOa2QwMU1pZjgwZ3Iy?=
 =?utf-8?B?Z0tBZEFMZHRYNjgvKzJ5YU9BR1oycFA0K1p3dnlXWTZVUjBPdzBmbTQvY3E0?=
 =?utf-8?B?ekVMbTFOanl4ZTVDc0taNGlURnRJZUxETXl4djhCM2pyVTY2SHhNNi9LRER2?=
 =?utf-8?B?QXc4Mk1kZUVnc0pZM3AxQVhtSDBLN1pQMERPZXBDSjZNN1J3NWZVTXFiOVhN?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFF374F7452D3847B2875CC2F7CE4D63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23658fa3-77dd-4912-6355-08daa69544a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 05:48:45.7864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXykggYYUGmBqgRvNz5ZX7DpNaU9Rm84SBWWJP5TVpVEcegVs19NihnI40LtALYwGVihCbLiYkmisQoph0wG3JsjAcB3+mMMT8I/2d8sZx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5572
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMy8yMiAxMzowNiwgUG90dGh1cmksIFNhaSBLcmlzaG5hIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFR1ZG9yIEFtYmFydXMsDQo+IA0K
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFR1ZG9yLkFtYmFydXNAbWlj
cm9jaGlwLmNvbSA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4gU2VudDogTW9uZGF5
LCBPY3RvYmVyIDMsIDIwMjIgMzoxMyBQTQ0KPj4gVG86IFBvdHRodXJpLCBTYWkgS3Jpc2huYSA8
c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT47DQo+PiBwcmF0eXVzaEBrZXJuZWwub3JnOyBt
aWNoYWVsQHdhbGxlLmNjOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0KPj4gcmljaGFyZEBu
b2QuYXQ7IHZpZ25lc2hyQHRpLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPj4ga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnDQo+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHNhaWtyaXNobmExMjQ2OEBnbWFpbC5jb207IGdpdCAoQU1ELVhpbGlueCkN
Cj4+IDxnaXRAYW1kLmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBtdGQ6IHNw
aS1ub3I6IEFkZCBzdXBwb3J0IGZvciBmbGFzaCByZXNldA0KPj4NCj4+IE9uIDkvOC8yMiAwOTo0
NCwgU2FpIEtyaXNobmEgUG90dGh1cmkgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEFkZCBzdXBwb3J0IGZvciBzcGktbm9yIGZsYXNo
IHJlc2V0IHZpYSBHUElPIGNvbnRyb2xsZXIgYnkgcmVhZGluZyB0aGUNCj4+PiByZXNldC1ncGlv
IHByb3BlcnR5LiBJZiB0aGVyZSBpcyBhIHZhbGlkIEdQSU8gc3BlY2lmaWVyIHRoZW4gcmVzZXQN
Cj4+PiB3aWxsIGJlIHBlcmZvcm1lZCBieSBhc3NlcnRpbmcgYW5kIGRlYXNzZXJ0aW5nIHRoZSBH
UElPIHVzaW5nIGdwaW9kDQo+Pj4gQVBJcyBvdGhlcndpc2UgaXQgd2lsbCBub3QgcGVyZm9ybSBh
bnkgb3BlcmF0aW9uLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgUG90dGh1
cmkgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IE1pY2hh
ZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+PiBpbmRl
eCBmMmM2NDAwNmY4ZDcuLmE3OGFiOWJhZTJiZSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+
Pj4gQEAgLTI5MzMsNiArMjkzMywyNyBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX3NldF9tdGRfaW5m
byhzdHJ1Y3Qgc3BpX25vcg0KPj4gKm5vcikNCj4+PiAgICAgICAgIG10ZC0+X3B1dF9kZXZpY2Ug
PSBzcGlfbm9yX3B1dF9kZXZpY2U7ICB9DQo+Pj4NCj4+PiArc3RhdGljIGludCBzcGlfbm9yX2h3
X3Jlc2V0KHN0cnVjdCBzcGlfbm9yICpub3IpIHsNCj4+PiArICAgICAgIHN0cnVjdCBncGlvX2Rl
c2MgKnJlc2V0Ow0KPj4+ICsNCj4+PiArICAgICAgIHJlc2V0ID0gZGV2bV9ncGlvZF9nZXRfb3B0
aW9uYWwobm9yLT5kZXYsICJyZXNldCIsDQo+PiBHUElPRF9PVVRfTE9XKTsNCj4+PiArICAgICAg
IGlmIChJU19FUlJfT1JfTlVMTChyZXNldCkpDQo+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBQ
VFJfRVJSX09SX1pFUk8ocmVzZXQpOw0KPj4+ICsNCj4+PiArICAgICAgIC8qDQo+Pj4gKyAgICAg
ICAgKiBFeHBlcmltZW50YWwgZGVsYXkgdmFsdWVzIGJ5IGxvb2tpbmcgYXQgZGlmZmVyZW50IGZs
YXNoIGRldmljZQ0KPj4+ICsgICAgICAgICogdmVuZG9ycyBkYXRhc2hlZXRzLg0KPj4+ICsgICAg
ICAgICovDQo+Pj4gKyAgICAgICB1c2xlZXBfcmFuZ2UoMSwgNSk7DQo+Pj4gKyAgICAgICBncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmVzZXQsIDEpOw0KPj4+ICsgICAgICAgdXNsZWVwX3Jhbmdl
KDEwMCwgMTUwKTsNCj4+PiArICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChyZXNldCwg
MCk7DQo+Pj4gKyAgICAgICB1c2xlZXBfcmFuZ2UoMTAwMCwgMTIwMCk7DQo+Pj4gKw0KPj4+ICsg
ICAgICAgcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4gIGludCBzcGlfbm9yX3NjYW4oc3Ry
dWN0IHNwaV9ub3IgKm5vciwgY29uc3QgY2hhciAqbmFtZSwNCj4+PiAgICAgICAgICAgICAgICAg
IGNvbnN0IHN0cnVjdCBzcGlfbm9yX2h3Y2FwcyAqaHdjYXBzKSAgeyBAQCAtMjk2NSw2DQo+Pj4g
KzI5ODYsMTAgQEAgaW50IHNwaV9ub3Jfc2NhbihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCBj
aGFyICpuYW1lLA0KPj4+ICAgICAgICAgaWYgKCFub3ItPmJvdW5jZWJ1ZikNCj4+PiAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+Pj4NCj4+PiArICAgICAgIHJldCA9IHNwaV9ub3Jf
aHdfcmVzZXQobm9yKTsNCj4+DQo+PiBTaG91bGQgd2UgY29uZGl0aW9uIHRoZSBjYWxsaW5nIG9m
IHRoaXMgbWV0aG9kIGJ5IHRoZSBhYnNlbmNlIG9mIHRoZQ0KPj4gImJyb2tlbi1mbGFzaC1yZXNl
dCINCj4+IGR0IHByb3A/DQo+IFRoaXMgaXMgdGhlIHN1Z2dlc3Rpb24gZnJvbSBNaWNoYWVsIG9u
IHRvcCBvZiBteSBpbml0aWFsIHNlcmllcyBmb3Igd2hpY2gNCj4gaSBhbHNvIGFncmVlZCB0byBo
YXZlIHRoaXMgY2FsbCB1bmNvbmRpdGlvbmFsbHkuIElmIGRldmljZSB0cmVlIGlzIGhhdmluZyB0
aGlzDQo+IHJlc2V0IHByb3BlcnR5IHRoZW4gd2UgY2FuIGRvIHRoZSByZXNldCBpbiBhbnkgY2Fz
ZS4NCj4gDQoNCk9rYXkuDQoNCi0tIA0KQ2hlZXJzLA0KdGENCg==
