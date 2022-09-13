Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62D5B6B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIMKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIMKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:16:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53B4D835;
        Tue, 13 Sep 2022 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663064187; x=1694600187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vekk3bBBJBNCGXMNSsfTGqCRkSHG/ASUNNoxPQuWsO4=;
  b=S+Ez4B8CTaaDull1+yN3LUCIQFuauIRtXLphiciDDh1nOM1+vufBL11F
   +EIEjO344qfc/svy3sU3cV+j4xbtbI4m5S0bX1K2LX6jRXU9IvkhD2Tbe
   rphFeONcTlWXQAioJYsbxLIw7H1uzuPNQVL/kl6/xjqZ/5xgAZtd7UrmX
   qK8hnkXHYQVMBzwAuVQ/OZlddC9ln2SVc50N7WKgNoSPrN8k++BvKqWSG
   iw+OuzNGoPt1ANVVGuKUsPzUaMPu1XRqUj1q6myyd49KaGCdzPRzeXPKr
   CDofyfFeNZuP9V+5JMZXQBMwo2dTJmBVSTqb+5D8Jjs/ksA6RZ3Lt+YUS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="176891809"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 03:16:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 03:16:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 13 Sep 2022 03:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms8m3/weI3ZXVCJCxkAnIKLobAjwCUJh4tRF2Vks7dvQvCov+k/og/2nP50RDbB4pJA/+5Soq/TzW+ciU+vd9eoTlwWoanRRxxVwzQ4qbUmusw1klUbAtqcDX6cvn562tEMIgu+xam7hgMqbDeMUkkhfrnDrpAnuqUczMUkOfHWFA/01AO+jO9RFXdD5zTdQ/IrsyhT776oQIhTSKgPYh5i5bwkKKqLpIlZ/YV6HkMQH8AfUPzypninrQkeBUSMGTMqPdsXL/vwoDi8fbZSyQRSUo7IxLtuUw7SnMsZVNG5ExRW4tlVKhAdM0lAI6GAQSMPIj0AqBdaDt1yHhtK3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vekk3bBBJBNCGXMNSsfTGqCRkSHG/ASUNNoxPQuWsO4=;
 b=URc7Ib51sBHcBL63BOCp25AVHKRJOOTYHxQuV6aM6oeKpiSWo3KxZWVDwEH3j6k8lbl70jKosctSFizu4uIFWfOCJ7MiZPwViCkBuaowGFQqjz1I30oENmqX2fbCvafdrcZqGu4GT3lUkQazi3Fcj53/Q1/DUFtjElhA5EoQuCLFAWQm8dSPcznG+VLZvpEvhJjPp+ei81ye2xj6mxS4f4SfzP7grLBnHl2UVpwS1AhQ88pkufblKXg9F+zquHGetvnWPaxHaNy7zUkMhDkovIl/luLZjztqcvDJFBDmgfMGygOYGTBD06BkBEUxwggeOTpB4jYgFSCfKhsUQiNISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vekk3bBBJBNCGXMNSsfTGqCRkSHG/ASUNNoxPQuWsO4=;
 b=b0jq71xw7OiBSdirA8TcMcDwEcgerOSVCjYUmFV4YLUqFzApwNLnkrpWac7bDSlJ5qwHAHtebgirxZETbh7H2VL8mBfk9a+FKJWvzVWaeaS/47clviGg9FOintrAiq3fe48LCKEIBCvispIPmnZIBIqoqtvrQOSiCD8NAfuguKI=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 10:16:19 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:16:18 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>, <Sergiu.Moga@microchip.com>
Subject: RE: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYw5S351ZiP2+bvEqYZuXgNIsbDK3WCUwAgACWniCABNh4sIAALv0AgAAK+ACAAWkcgIAAEInA
Date:   Tue, 13 Sep 2022 10:16:18 +0000
Message-ID: <CO1PR11MB4865D623FA957BE718C7A75292479@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
 <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
 <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
 <eea8e746-6561-71ca-12f0-d010a0672edf@linaro.org>
 <CO1PR11MB48650B395FB6A4D94B51CE0792479@CO1PR11MB4865.namprd11.prod.outlook.com>
 <98ab5118-aa32-af20-a732-dcb5e362717b@linaro.org>
In-Reply-To: <98ab5118-aa32-af20-a732-dcb5e362717b@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4865:EE_|PH8PR11MB6829:EE_
x-ms-office365-filtering-correlation-id: 6d674b43-8520-4b50-28eb-08da9570ffe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfzXo+YHvJzBceE1D8ZewSLBz7C0Mbcm7FQrpyPPhnctp+63/qKMaql6R62rsvcmrwO6UfyfQ5/ft/BEwElwK9UtECqxmqyho86C55rLoPU4FnGfxTqNLAoyJ2+YtXvP5By8kh9eykrSUQDNe/j65ws7ymEOlhk+zyGqMjJdSeq5KMzvct2svrjTVconJ7zgN79kWAzd+FIxiDAtmc6SvmvE1w11wZNpi+TFfZaYdR8EdY33sRgpoOz05mNTOoAu0bDaLAt5rIleEf8KQ+uoN700FyZEQoo/AjU5vBK1O/e6s/IJa33mOtKFgztPzDxrtg74JoFRn6OuiEUftn1a1vHlSvCLF1k0554dt03Gm0nQf9LLUSyxitcKQKWyOi2VJlr53y+zs6XImLZ70LARZeGNgDGEljvfaIYyueUtggciL+huV4rq3YR0WUa/0+MRPuHyP+RzDte1RYmb+n1VY7fV1bM85UfgXOOLJegztzCgKgdfIOA5zd1Bc9GO0rR3hlu6ymRKYP831VptDBFY1ocDFF2b37/ijJPQlthAgMJfFKFg0Dj2Mlr4nNmL/qBQxtgpxo6LK7gzJGXkTpi9t+8MLbxOBIW8TvkGKjsXSQLICLk+7TYocYfX+h1UWNjO5AcMwklsAWCkiKes+FCIBtZfW76o38Xt6WN0pgXxrc0IFeBUPPV7keDsN+8UMHWXrr/Ix4LoVPiCV25izFgmvVTGmwkTIgrU4L65A03kt8sF/on0kn3N5m4sa+sL9NuQRwnV3z9tZMqYSC7CCQNqy7F34Lgn8HFhStd1aeu3UxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(71200400001)(478600001)(966005)(110136005)(54906003)(66476007)(316002)(66446008)(64756008)(76116006)(8676002)(66556008)(66946007)(8936002)(52536014)(26005)(53546011)(9686003)(33656002)(107886003)(122000001)(2906002)(41300700001)(5660300002)(6506007)(7696005)(86362001)(38070700005)(4326008)(83380400001)(55016003)(38100700002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE5ZNmpUVDNFMDRLMmJtQWk2TjVPK1Fza3AyT0xCc0dtcUVjeVlNSGo1bVY0?=
 =?utf-8?B?amE2elBWbnBOaVNlMktwOVFsbFp0cUNLTmxGbWIrZzExL0VVTll1ZWtvcVZS?=
 =?utf-8?B?VS9TbWRzS1JxK1N5UUF2bDYyUlRlZHlqZUcreklmMkg4dmZNQ2x4cjEycytJ?=
 =?utf-8?B?M1Q2Wld2VWNQN2RkL2RVS3VPUURURWIzT09CTGpVRnI1RFFmT012SHl1cU9N?=
 =?utf-8?B?aTI1RkFZRW1KTTVxRlpXV1gyT2FCQWlYQWxhS01yck5sQmk0WS9XT0dGc2pq?=
 =?utf-8?B?cXFGZ1pZZzFBQjQ2SHA1NEM5c1BRRVF6dUVzTmgyMFkxL3Z3d0x5K3VSS1dC?=
 =?utf-8?B?MitsZzFlTHVFcXI0NHVRSk5jV2VHTE1Wem5lNmhZUk1wMGtsaytFL1hTRWR4?=
 =?utf-8?B?SDhIVWcra3JUdVJkRFVFRUtNK1ZVclczT0dtbGdZT240emg0Y1BObjRXM00w?=
 =?utf-8?B?OUh2K1ZWSUFTRDRHWGhoZWhNOUtBdTVjSGlGbmVaMmJlSmFsVUtHY0JSSGZn?=
 =?utf-8?B?bUw2Y2ZDUlpjZ1BXZDI4YlJTM1pVNVB2ZTNCKy81SVZyc2hMdUEvb3hqNEta?=
 =?utf-8?B?bjBuTU5wb2l2Z3ZzQVE0N1MwNHFzb2RucmhIRG0yaGFNVEU4M2JjM3lXS1VS?=
 =?utf-8?B?Q2g2ZU1EVWhJanZHcFI2d0pwRlFGd1dGYjJhckpIYVN3eDJCcXhSR1RzSndI?=
 =?utf-8?B?Zmd2eCtDaWhQT0V2VDNNUURqZHFqWnphL2ovUlAwS1RKRkpIRDdaUjl1RStR?=
 =?utf-8?B?UUE3MlBYNTJJVG1QTHRFT1VkRDhiMDBzUTlUNVJ6djJkZEhmejdUeWNhT0hG?=
 =?utf-8?B?VHExbDhVWGlQb3NrQmF5cE1SOVdKSWp1MXA0WnJ0WW1LblV5c0lpVWEvU2Y0?=
 =?utf-8?B?dUpDSVJnb3p6alFJTWgzOE5DS1RDTHJpWW9LdmtVZm5YaERMREdVYU9kREt6?=
 =?utf-8?B?SGtkZG5oRDhrbGVYQXc5aDNVWitjajRWeFIrK082ZjMxeDdTcm1oR1FUckNF?=
 =?utf-8?B?VFFTaGg5aDdRMERmR0lOcXgzZUw5UXU4K1JBL3hXVm42MjJEQUhDcTFyVnZO?=
 =?utf-8?B?djAwZTJ5TE1ndUEzL3ZEUTFiNUZnODIrM1p6NlJaS1hDK0xscDFWdmNxSDBn?=
 =?utf-8?B?VmYxTXI3UTFOdzV4N2NHZHo1VHpmcUdwSS92YU9qYk1rSjdYbzlxUXdXTC9C?=
 =?utf-8?B?UW5ySk9hQlFDKzVxZ2xmUmRXQ2JPeWowd3VORHViZ1YrdTdPbVQwS3Vwb29M?=
 =?utf-8?B?N1c3U1o3VlBWK09Yalk5MGkzY0pabkd1b3ZVTmxnalFXdXF0WUJPT3JtQ2VW?=
 =?utf-8?B?aGpsQ0V3SGpqOFlUanI1VFpjMVhCSlhwSnFFUnRISW9FdXFaTHB1RE9wK1dE?=
 =?utf-8?B?eDNGOW5xR3VjVzJDeU5WR2xKYUJHUnZTNVo1cTk3TE5WbjJjOXJ4dmJuQkFp?=
 =?utf-8?B?bFppS21EMXErVnVZeEx2eDhldUYzM1V4dnNkbmhzVDZIVEM5YkxLOWp6THA3?=
 =?utf-8?B?MCtUSUdkaktYWWxKa0hEbnEyZWlwdXpEMlllSEpDRE1PNXRzemcwTDMvNU1v?=
 =?utf-8?B?L3FwYnZVRkFmcWpFc2dKM0RoOWdqRm5ZNmJUYmxqalplRkVpc1poNHZuby9F?=
 =?utf-8?B?b0dPRkJzendvL2QvU2ExeDVTWWVHUW4xRWhnMHdLRFNOaE1ydWt5MDN5a09P?=
 =?utf-8?B?QSs2Nm1BZlNKS1kyQndGc0dZa052SWpvY0dWazFQazVCMllPK0JPNWlSTEFI?=
 =?utf-8?B?TFV3ZS9IOENTS1NmYzBsUUF6Q0poczVmeGZwdlU2SDIvK1kwZ3hQME5VSWxS?=
 =?utf-8?B?S1I3ajd4QlF6UlR0b0VZTXI2NHdNQmU3QzZwR0dhT3pNYWFHNERZYzFXYnVW?=
 =?utf-8?B?MlZBUDFtbHBCRTh0RThOWFVMUG1PeHk1aTlWNm5lU3NGb1g4VWdud0dGNVZB?=
 =?utf-8?B?ZUJkazl0dGhrWDg0TlNWcEhza1UyWE52cGZ4bWVPS2d1THY0Q2VIM055V0c0?=
 =?utf-8?B?bmhrdzRsLzFqdHAyMTB4OEtLNktPRTJJOTRqdUUxajNWdXdqdXJKZGp3ZXda?=
 =?utf-8?B?dStKN2hMbWdUOE5UQ3BISDU0MGorWmEyalFTSDNmbGRLSnJoVTRBdUdWNFhy?=
 =?utf-8?B?cUQwaXJEMGZsYlB4cWRUYm5hTnBZaW53UHVpTVBQR2NnODlPNW93Z2tCdzVw?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d674b43-8520-4b50-28eb-08da9570ffe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 10:16:18.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfVUqd4C5GALk+CF9WAOaAFKbTjTZPhb+EE+t8XyBnJ+RSE32O0aMg+zJ/6XqEpW+D/rWtWqh3GLCdsf6x9H++9ZVkN4NlEHasV9SeThZF1EmfFp5WdAc5w+myn6CP3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMy8wOS8yMDIyIDA3OjI5LCBLYXZ5YXNyZWUuS290YWdpcmlAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4gPj4+Pj4gZmxleGNvbUBmYzAxODAwMDogc3BpQDQwMDogVW5ldmFsdWF0ZWQgcHJv
cGVydGllcyBhcmUgbm90IGFsbG93ZWQNCj4gPj4+PiAoJ2RtYS0NCj4gPj4+Pj4gbmFtZXMnLCAn
ZG1hcycgd2VyZSB1bmV4cGVjdGVkKQ0KPiA+Pj4+PiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEta2l6Ym94My1ocy5kdGINCj4gPj4+Pj4gICAgICAgICBhcmNoL2FybS9ib290L2R0cy9h
dDkxLXNhbWE1ZDI3X3NvbTFfZWsuZHRiDQo+ID4+Pj4+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MS1zYW1hNWQyN193bHNvbTFfZWsuZHRiDQo+ID4+Pj4+ICAgICAgICAgYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW1hNWQyX2ljcC5kdGINCj4gPj4+Pj4gICAgICAgICBhcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbWE1ZDJfcHRjX2VrLmR0Yg0KPiA+Pj4+PiAgICAgICAgIGFyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdGINCj4gPj4+Pg0KPiA+Pj4+IGRtYSBw
cm9wZXJ0aWVzIGZvciBzcGkgbm9kZSBpcyBhbHJlYWR5IGJlaW5nIGNvdmVyZWQgYnkgU2VyZ2l1
IGluIGJlbG93DQo+ID4+Pj4gcGF0Y2g6DQo+ID4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9iNDYyNTUyNi04ZjliLWFkYTgtZjg1NC0NCj4gPj4+PiA3NTFhNDg1NDU1NzZAbGluYXJv
Lm9yZy8NCj4gPj4+Pg0KPiA+Pj4gSGkgUm9iLCBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBjb21t
ZW50cy4NCj4gPj4NCj4gPj4gdGhpcyBtZWFucyBpdCBjYW5ub3QgYmUgY3VycmVudGx5IHRlc3Rl
ZC4gQXJlIHlvdSBzdXJlIHRoYXQgdGhlcmUgYXJlIG5vDQo+ID4+IHdhcm5pbmdzIGluIGFsbCBE
VEJzIHdpdGggeW91ciBwYXRjaGVzPw0KPiA+Pg0KPiA+IFllcywgSSByYW4gZHRic19jaGVjay4g
SSBkb27igJl0IHNlZSBhbnkgd2FybmluZ3MuDQo+IA0KPiBUaGVuIHRoZSB3YXJuaW5nIGNvdWxk
IGJlIHByb2JhYmx5IGlnbm9yZWQgKEkgYXNzdW1lIGl0IGlzIHJlYWxseSBmaXhlZA0KPiB3aGVu
IGJvdGggcGF0Y2hzZXRzIGxhbmQpLg0KPiANClllcy4gWW91IGFyZSByaWdodC4NCg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
