Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636D613389
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJaKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJaKZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:25:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F79DF89;
        Mon, 31 Oct 2022 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667211925; x=1698747925;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VdLDKS/zxLtrEFkFyAGkbd6Es7+hqT/PfOh60LTEJ9M=;
  b=H9ayLJQ20QNpH2XragGwwWHdFbOaZDDiUQgslPsCyGPGQwPN8YcQXWDP
   7wfAH1j2I6k3xRdzcEEEUbGk/N53HFtOr4wl/1Z3iBBK0WBGBlRjuEbLJ
   WpLwzz8I6/FdJAHutlVJ4f3e3w37Xp1CGuUKgMkoOxWe40J5F8DzinA3J
   bm7s/v8wr2lZcNqwvEt7VYUUBc+MffA2HHXlVLuEDZzrxDcHTeN4Si4pM
   v1GGyD7f99odbkUI4gGyJaQg27gUn14iTOQ306gFCcJp09bcwa0FIiGyy
   qppullZydyIqSMfC45vr/a+Xu2WypBtpiDIVwzZ51lR3B86zBBn+ZdciK
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="181208911"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 03:25:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 03:25:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 31 Oct 2022 03:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gixr/KBflzHVGcvDnNuWNGvJbW140xMq4HGpkm2ArcSoF97H0KteoGnJibDaw0x7Bx2DD8L0mOCjp6segNk3MMqdg/iiiwMdi95w3YXfY9+1CJlNDgSyP224okfuTMklK9KGLiTKLZeHjGYvdtclPrrEpEYamEGgBobspQwRK1CzV472I/4YN2ZUPt6FuHsySy6s1qoYoBqUSPBB0pWdGhzoBhnqOSSSOflPViVuthWWyzfmhbroqsOnIImNQrtrMPEXgXmo7XWaK8e1LF+D7E42wPoqn2cRLFD+R3xC9qvWkFOW1w9POFt5eKfCmWtYdg96rghPJ0yiKe78P0/KgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdLDKS/zxLtrEFkFyAGkbd6Es7+hqT/PfOh60LTEJ9M=;
 b=W1YgB2KDstnvtbZI9nT26MXkJpqrufahtXdR9cqNL2+GNr9PuoFZKLh6/RtNpJz+fobhc1iQ+tO2J/RgLjH+vi5xMGS9BcO3+YtmRyxjQPGmMdJD6y6vKvWZrQf69O9695LydO3OONbHKme3cJulUczIhYPR2ICa9/wPomJJ0olgMGW8OX+4FZ9A4/bEx1O3TByh9iXYlaUK0cM7HUlW5RO2sxPa7dRXg0uccECHJEcCpjFshV+Ix1Z5QQn42wSQqlWHj4wR3717td7w9HkCYusyMKBd83jyA2bEWs2VD6s+Uj0vRJn9yzmhIExVvN0CvEIBLEof1eJsLtLa2UY20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdLDKS/zxLtrEFkFyAGkbd6Es7+hqT/PfOh60LTEJ9M=;
 b=ReUXOA0GO2TaRyupwjbzqK7jQgdaL8pfsQmt7MDy0rgcF2oNIvG0qDaJgEKlbnY96nNcYtC/8AcUXkNBFwxLiMwkF4UXKpZ/xBbukk5hs5GzjzTZp+A82qyTDDXKZSlTtHEx6Jq1q+UroMCrrm6V15ngUavvz5I8MX8orD2Rmlw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 10:25:18 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:25:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manikandan.M@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCHv1 1/8] ARM: dts: at91: sam9x60: Fix the label numbering
 for the flexcom functions
Thread-Topic: [PATCHv1 1/8] ARM: dts: at91: sam9x60: Fix the label numbering
 for the flexcom functions
Thread-Index: AQHY7RMSmUV2XrJbskG2lyT+useHSQ==
Date:   Mon, 31 Oct 2022 10:25:18 +0000
Message-ID: <52ed373d-24a6-fb8f-a70e-4345188e7739@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <20221031033653.43269-2-durai.manickamkr@microchip.com>
In-Reply-To: <20221031033653.43269-2-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5506:EE_
x-ms-office365-filtering-correlation-id: 948efebc-a442-4818-3809-08dabb2a354c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FZ1628MIm1HS3qziMnxivrm4KtF/lWpjqHBMKKfSSSLc+pF3852guV8XtY9hiqo5cCesqV+1l3Tlky0D/0KZYSeLD0nEGi04E4NPk7M3NaMZtr6wbaLm3y5kFb7RlQBR4dwUiZA+nmflILzWOJBIS70ERCgP62jRUgI9GBNKJpDUe7NSdosjrT6nC/kXNKGglWVMrknLoUuZBtaH4umm/dFc1LwG4G+A/+UP63ASW8f/LZqx9RxHai1LmVjyDLYwCi7NKh98hbFsUPmPewCG3g9o36INsjTzctTLfCuhJue9Ckrad4qh9LERigs1LL8Msk7kdWslkROzs/sHoeR9epRpfC2nTwAj6Uw9k063/Am/ANqMbeuPE6H9FSEZ5k1zyco1bjkmNhEKthamuTa+CY4vYfVVADXz5NKVq5Lngef2QQShrgVRzfiH9UhNsWHnafXfS6dykQ5T0yKD2vveZ1mAnZnMcUDHRwqmmy/NI6ixzojLRdEcLkuRknjG57Mf44PRljubR/897DBrNei4ZQVdfN1RG33nKveCRMUF3aoqMcJBWgB9sf67Qb9rZie65Q0m4K1sRcVxS1Pz0bu1/45E/C6K9qU9kirCsbS7NuzGYKYtQH2YRPQo7ExsUHpqJ4vdfpWrLA2iKcg0RVEFwQulESZYEG3A7pLogsVLKvaXKFLSi6qHCgUAwVFM8XQ6D80M2DlsrgXn+HhfYpl9epmIjBx8/KUNo72H9o3Ijxs34B1qb28X9TGjZYH2v4vIX9/naW/+2qC7Ns8Gv3bLcL3ENmSnaHWgv7cHZSi0UdV7th+z/ZREIaxF3iVIu2Ly+1IDAcY5kSIhL+Uo9skkn6rHhgvxyfSARIYzotWuOEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(921005)(38070700005)(31696002)(86362001)(36756003)(41300700001)(6512007)(26005)(53546011)(8676002)(6506007)(64756008)(2616005)(8936002)(5660300002)(66556008)(66476007)(66446008)(6486002)(186003)(71200400001)(478600001)(66946007)(6636002)(91956017)(76116006)(316002)(110136005)(122000001)(38100700002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzVTNDFRRDZKa1loUXdIQTNKYUxRS2RIcGJObkZMYjMzaHZsVEl5czBsUEUv?=
 =?utf-8?B?OHdKMWF3VW14dG5nbEM2bXM3eHRMNTNTd2RJSGk3S3ZML3BiaHNVK3NSL3dP?=
 =?utf-8?B?a21yYWlGOGVOVUhyczFvYTJFS25XbmpzMnJyeHgvYk5OMU45Y015OGVkM1Za?=
 =?utf-8?B?aUFZMkgrejBmQzh6MFR5RDlmMCtNSWNWYnJiOC9vWURnaFdBWlY5VUZFOFRE?=
 =?utf-8?B?RDRxY21lM2MwVnppOFRKS0R2MFhuaHdoVGdBeFlZMHBoSFJsSzNDb2ZvbWx5?=
 =?utf-8?B?OW9vTEJoVmIxQmhjclo5YUV5ZjZMbEtDdG1tamdEeFV6My9DRUJnc1BZSkI0?=
 =?utf-8?B?cXpjUkNSU2I3cVNVVCtNZTlJZWsvSUFrQzl2QWlKRFQ2eThhZU95a1hkSjBZ?=
 =?utf-8?B?Y2ttSzhMeEtXM3J1aXp1MlB0N2dQRkN4aTZWOWhnUnNES3NoQ0V6Mlo2dW04?=
 =?utf-8?B?cEYvS2hDaXkyTEZHVDhzbmlNcGl4YnZyczhsWDhsQmQwT1hqRDVENlZCcjE3?=
 =?utf-8?B?OFYxaXBqUjU3elM3Z3YxaWtDcUtCcDFXY3BIRnI5K0s4TnhmSXdBR1IvbkpJ?=
 =?utf-8?B?Wm54a3ZkQVQxNFF1SzNhQXF0bWpsQlBZUHY2S1lKQkFXRk1VUnZXTEdOank3?=
 =?utf-8?B?Z0RjcnVUU1o2cy9mam9lWGlqbE1tVmk5cWdHTHZnU3BXNVJWbGdoenc5dWo5?=
 =?utf-8?B?TWM3a0RoN3JydzRMT2s4bWZEUFBrYU92dXNWRXNBKy8rcGNNd2EvZkhvbVVn?=
 =?utf-8?B?dW1JcXFhRWl2MVFFQ2lES3lWeElUTFM2YVpHQ1poeVFzNHBBb2J6NmlFV0Ny?=
 =?utf-8?B?L0tFUVNTR2kweTA4M3h6VlVnTzNZZWluUGFZOGlCRG9VM3J2ZGcxcWdOaUhP?=
 =?utf-8?B?UzZBek5Ec1E3azdBcm1GL0RmL2Q2anFtSmM5NzRBeVRYS25JWVVON2t2QVhD?=
 =?utf-8?B?QmNmaE54TlhVVzhXaVpYMjc3YU4zM250UXdua0ppVHU4dTgwWWdyN0tzaWt5?=
 =?utf-8?B?MWF3NjJUckhicWpveGlSOFBGc091MHBuZ0VzMlRnYjhrUndsVjFnUVZSRzR6?=
 =?utf-8?B?MkdkS0Frb1lpeEY5LytLcGJ5TkpPek5haEJYSTA3c1pRa0J2ajlhRlZKRTFk?=
 =?utf-8?B?ajc2MDdsb3c2bUNzQm9uSVRJRHUxeEZBdXVJdVM5SmdQK0RBNXByWVd5NTJD?=
 =?utf-8?B?TzB0VnBuWjZCRmtlL1lGRklrN2ExcUZ1K09UQmdEZ2VudHREbWc0ejlyMlNh?=
 =?utf-8?B?NE5qUHp3a01PVUhtdENFZVdReTZxeUZPVHdHWUdpaisyUlI3ei9YRFRKQnla?=
 =?utf-8?B?eXNxMzVjWXNUSWEzbFhIdXB1djVrUGN5MlUrZ01jaCtVekF3ZFcwdGMzNWoz?=
 =?utf-8?B?QnhsS01NbDc1dzBrcXdSL2c0bjFMd0N3dm02QnpSRU5QdzlzR05ScjJ6V0ZO?=
 =?utf-8?B?T0pCajdaV1BWRG5YelgrODFBUEVKc0hiK3h6ZTdrTkhiWW9NK3RMYkI4ZGRt?=
 =?utf-8?B?dHFOdndHRktIMmFrdTdxOG9xa2RzZXlrSHkzU1lKSHVJL1hNY2o1WXRUeURB?=
 =?utf-8?B?TDVmUkN0d3crM2lQMlhwbC9Dc3lCRjJ5ZGVoNWVTcGJERkVkTDBLWDlvcXVm?=
 =?utf-8?B?ZW0rZkRUYTZ2Z0szL3pseThGZDNBMDJ0YmlIa25FeXhtOGliREsxRkpMM3Nt?=
 =?utf-8?B?U0NpQVdNMmNsOEx0WjZsUlR2alVBZEo5NGdrTjJ0bWZrb052RVdIT2NBc0JZ?=
 =?utf-8?B?MVYrc29YVHRGSjVnSjhMK3VUR0JOdFJGSG9COE9CTE5RM2VqMlFLMUpWaXRO?=
 =?utf-8?B?TG5pczY3SlVUa1NiRFRlU0g0MTdWZW9qcWk4YlFCSnZjbjl2d0pyeTZWMU9T?=
 =?utf-8?B?MkN4NzNGRXdrSzlmSWhmWUN2TUcrMENWdW1lQS92UUZkVkZtU3Q4VStuR245?=
 =?utf-8?B?WUV5WW9GNkkrNmdpc1gvQW0xZ3dzUXk4KzNvb0hqNCtNYWU4dDZ2eXdiQU54?=
 =?utf-8?B?VDVqRjllaUhWc3VZcDhYYVRnTDF2Q2dvbE9ZZ01jMUJNdTlmbWJHZUN1YUVq?=
 =?utf-8?B?VFhHN0ZETnZxUUZZd2Z5eUxhTDhFMDYreDZ6MmtJRmFQNHdPOUt5NXA3aWd5?=
 =?utf-8?B?V3JrN1RiMHh6UnUrMi9TRmxWQ1RFaWFWS2tqWExlblVXTlZCVDRWS3ZWdjYz?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E97A45C8BF6171418497FEDD49DEA51B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948efebc-a442-4818-3809-08dabb2a354c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 10:25:18.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdXnptI8urgaLnSr5iZVqnez/l+jCsTCkqMi/VgYTJjqD+EbGSJ/CPmWZM178MjxSCboEhQO3eQW4a96jTAND8QUv+sY9orChlS8/V4hp4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMTAuMjAyMiAwNTozNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTSA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBGaXhlZCB0aGUg
bGFiZWwgbnVtYmVyaW5nIG9mIHRoZSBmbGV4Y29tIGZ1bmN0aW9ucyBzbyB0aGF0IGFsbA0KPiAx
MyBmbGV4Y29tIGZ1bmN0aW9ucyBvZiBzYW05eDYwIGFyZSBpbiB0aGUgZm9sbG93aW5nIG9yZGVy
IHdoZW4gdGhlIG1pc3NpbmcNCj4gZmxleGNvbSBmdW5jdGlvbnMgYXJlIGFkZGVkOg0KPiANCj4g
Zmx4MDogdWFydDAsIHNwaTAsIGkyYzANCj4gZmx4MTogdWFydDEsIHNwaTEsIGkyYzENCj4gZmx4
MjogdWFydDIsIHNwaTIsIGkyYzINCj4gZmx4MzogdWFydDMsIHNwaTMsIGkyYzMNCj4gZmx4NDog
dWFydDQsIHNwaTQsIGkyYzQNCj4gZmx4NTogdWFydDUsIHNwaTUsIGkyYzUNCj4gZmx4NjogdWFy
dDYsIGkyYzYNCj4gZmx4NzogdWFydDcsIGkyYzcNCj4gZmx4ODogdWFydDgsIGkyYzgNCj4gZmx4
OTogdWFydDksIGkyYzkNCj4gZmx4MTA6IHVhcnQxMCwgaTJjMTANCj4gZmx4MTE6IHVhcnQxMSwg
aTJjMTENCj4gZmx4MTI6IHVhcnQxMiwgaTJjMTINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlr
YW5kYW4gTSA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQoNCkFsc28geW91IFNvQiBzaG91
bGQgZ28gaGVyZS4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVr
LmR0cyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
dDkxLXNhbTl4NjBlay5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMN
Cj4gaW5kZXggNGJhNTJiYTExZGM2Li4yNjU5Nzg1MTRkY2YgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gQEAgLTE2LDggKzE2LDggQEAgLyB7DQo+ICANCj4gIAlh
bGlhc2VzIHsNCj4gIAkJaTJjMCA9ICZpMmMwOw0KPiAtCQlpMmMxID0gJmkyYzE7DQo+IC0JCXNl
cmlhbDEgPSAmdWFydDE7DQo+ICsJCWkyYzEgPSAmaTJjNjsNCj4gKwkJc2VyaWFsMSA9ICZ1YXJ0
NTsNCj4gIAl9Ow0KPiAgDQo+ICAJY2hvc2VuIHsNCj4gQEAgLTIzOCw3ICsyMzgsNyBAQCAmZmx4
NCB7DQo+ICAJYXRtZWwsZmxleGNvbS1tb2RlID0gPEFUTUVMX0ZMRVhDT01fTU9ERV9TUEk+Ow0K
PiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICANCj4gLQlzcGkwOiBzcGlANDAwIHsNCj4gKwlz
cGk0OiBzcGlANDAwIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zcGki
LCAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPiAgCQlyZWcgPSA8MHg0MDAgMHgyMDA+Ow0KPiAg
CQlpbnRlcnJ1cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+IEBAIC0yNTcsNyAr
MjU3LDcgQEAgJmZseDUgew0KPiAgCWF0bWVsLGZsZXhjb20tbW9kZSA9IDxBVE1FTF9GTEVYQ09N
X01PREVfVVNBUlQ+Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAtCXVhcnQxOiBzZXJp
YWxAMjAwIHsNCj4gKwl1YXJ0NTogc2VyaWFsQDIwMCB7DQo+ICAJCWNvbXBhdGlibGUgPSAibWlj
cm9jaGlwLHNhbTl4NjAtZGJndSIsICJtaWNyb2NoaXAsc2FtOXg2MC11c2FydCIsICJhdG1lbCxh
dDkxc2FtOTI2MC1kYmd1IiwgImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4gIAkJcmVnID0g
PDB4MjAwIDB4MjAwPjsNCj4gIAkJYXRtZWwsdXNhcnQtbW9kZSA9IDxBVDkxX1VTQVJUX01PREVf
U0VSSUFMPjsNCj4gQEAgLTI4Myw3ICsyODMsNyBAQCAmZmx4NiB7DQo+ICAJYXRtZWwsZmxleGNv
bS1tb2RlID0gPEFUTUVMX0ZMRVhDT01fTU9ERV9UV0k+Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsN
Cj4gIA0KPiAtCWkyYzE6IGkyY0A2MDAgew0KPiArCWkyYzY6IGkyY0A2MDAgew0KPiAgCQljb21w
YXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWkyYyI7DQo+ICAJCXJlZyA9IDwweDYwMCAweDIw
MD47DQo+ICAJCWludGVycnVwdHMgPSA8OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiBAQCAt
NDQzLDcgKzQ0Myw3IEBAIEFUOTFfUElPQSAxMyBBVDkxX1BFUklQSF9BIEFUOTFfUElOQ1RSTF9O
T05FDQo+ICAJCQkJIEFUOTFfUElPQSAxNCBBVDkxX1BFUklQSF9BIEFUOTFfUElOQ1RSTF9OT05F
PjsNCj4gIAkJfTsNCj4gIA0KPiAtCQlwaW5jdHJsX2ZseDVfZGVmYXVsdDogZmx4X3VhcnQgew0K
PiArCQlwaW5jdHJsX2ZseDVfZGVmYXVsdDogZmx4NV91YXJ0IHsNCj4gIAkJCWF0bWVsLHBpbnMg
PQ0KPiAgCQkJCTxBVDkxX1BJT0EgNyBBVDkxX1BFUklQSF9DIEFUOTFfUElOQ1RSTF9OT05FDQo+
ICAJCQkJIEFUOTFfUElPQSA4IEFUOTFfUEVSSVBIX0IgQVQ5MV9QSU5DVFJMX05PTkUNCg0K
