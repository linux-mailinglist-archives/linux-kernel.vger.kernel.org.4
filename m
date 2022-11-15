Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE67862A407
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiKOVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbiKOVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:24:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2AE13FA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668547421; x=1700083421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fXYksg1xJ+LQF+3s2LpR1mBIe5mdUBR83iPA28pWCfY=;
  b=jpSRS0yWLR1pJlikVIlG++hkZkkj8XSLRKbWaI7FRx+dv66cJMt6kkoT
   UM5qVSCpBkgJTfQDbRBAZ1y5KWqebD28xZGXMhUiuUTKvWzzjVxQ2uf9K
   QqGla9u7Q5jHl3WGpH7bDHDDJumjBAHctDHGy37MtptfzWkXVn3kOz7hg
   Q5TVpHEJ2dw1nDExhBgbxU288ysojd598ryyb+nOgeUsVwn6UJbQ4m9ua
   0TNayCR3wjwH8ZINztsnUVWHLnWWzTmMlfqaz02qDl5egu1t/X26m7plW
   HuwIs9IFpOf7xstDqa0QBpOJLeTypqUWGREotIuAjjF+HQI2XQJQI/P1m
   w==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="187142906"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 14:23:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 14:23:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 14:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2vHy2ovO8gzpHXmgIHFV5C+qYekqBwYpRTzkRwOzyh3h5r07eSNUTehG2YscDBhXCn3KJ4R4DzuNL0nnV31tKsiiruksTJ5kM43c/u/J1L7uSudK2G6aWH1onsFWaNKXT//l4gdd2F7AHPbhSxWIzuCpSSGwmNMB02E8YnSPjcV0q+r1zCyhZNCP/Xn1c9A+8sJkq3kXTokr+vW/HYC9vOQ45bKj9pVeApymnz2GdJnhprtKZZYX9O6WDuhcOSS9d2TQ6kpdrw7UYomoKaAgv+nrTcHhmqExsRuuqyyPEwvWvC/9OU5egKA2/uoYOx1arMc/egCGzvhYL2YuzLA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXYksg1xJ+LQF+3s2LpR1mBIe5mdUBR83iPA28pWCfY=;
 b=DEcQ76cVIWjOvn3XCrZ21wSuu1o9nr+euqJ85fKjX1x/S6uFCS5lvMx3JHgqLWZfkZQkpeGQeBeKEyfvd9VSIlRALZA5EDdSz0rd+WD/c76lIj6MrbNAipT1BmER50agx/t3B66eDJ8DufLULSxJ+4RjHNHRooXoyZYF67e0V3Qb+RiMNGNfwzEHMLVsbVrRqulxCRNlsbrRcop6c8QnlFAlWeLZ7JR7OSmowPyUPN0QD8D+ljW1Z4QEfsudbacKNZPzEq7ZwKChUVDdo+PeloVylrizief8ZB5L/nm20TgI1C4fxosrsSWpMW30akq3VlQZcC9mF5VfyGXXUixxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXYksg1xJ+LQF+3s2LpR1mBIe5mdUBR83iPA28pWCfY=;
 b=j7sUQVUC/Y/PVAgRoYaWAoIKjwTloQX7MW+8u3TqTJ0iIuSNPPwSfPRl2hSvirKytgn5TKm44OkRer+ODdRJraaP26UAL+PYQ2wFlF+OPphOelftNn9dfSUkWBU8oxMGFF3kya3V/MCqxJoG5msE8HnB3CSFKvDnpl/XiTOBNQY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 21:23:29 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 21:23:29 +0000
From:   <Conor.Dooley@microchip.com>
To:     <debug@rivosinc.com>
CC:     <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <jan.kiszka@siemens.com>, <kbingham@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>
Subject: Re: [PATCH v4] scripts/gdb: add lx_current support for riscv
Thread-Topic: [PATCH v4] scripts/gdb: add lx_current support for riscv
Thread-Index: AQHY+TKNawU2t7nJ1kOZ2kOkrH/RQK5AfpwA
Date:   Tue, 15 Nov 2022 21:23:29 +0000
Message-ID: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
References: <Y3OkY6myfea00BaK@wendy>
 <20221115204003.1866421-1-debug@rivosinc.com>
In-Reply-To: <20221115204003.1866421-1-debug@rivosinc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB5984:EE_
x-ms-office365-filtering-correlation-id: 6ba6a7d5-3f8e-4280-0feb-08dac74fa3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: unBZbOYqTfT1cte9ZvmRQouZ7q2jMba3ARNjmkvgKCL6kXAjD9ZrExqM0hI6+hqyfOe2Nv7C5uwhymKuOPbyDNZh2Lm6An+weJPVYge2/DxFfbLfAnN474LA6qnluLFcBCaCncYwVeS+XGKhqkUpiv4aNMugWuLDhXlxgMDO8l0jzr0Y0A6SlXg9gYhMxvTqFOxdft5LMGg6QI0Wc5kAd1YUT1xrqM/Zg4zOC/Cgrb8NjU7/jBsEKGOz+2dy7XAeu51WEee8JzC9q8GXA3YCKdAHdzAunNJHZWMxKeafxzdtdVJKprm+cuMGnrtKHXe5nb8Fw7e8NLkRiU0V2ulxQ2wd2WJ8nceIgxxSsECspvkuySNzzXSHvil/0Nu1xnucFK+lEgSIdYHeq9xhG7lrwiN77uIl/GcR91LpHF8JyiAlVQ7wwY0xSOn9BlirWFnJ0lJKkrBVAHbNOvltinp+tPvtFH0DG/gLjhitI1+HzR9HvpwOAiQRIBw9fyPfFChNE3sW1kKLSULkHWKn5GhYr//HlSTdVv1Oqezc/nvONSZhW/WiVsZzYfEpTMNuzs7KGuc7lI5HOtwrnTy6OP9gz19pLDDvXXHtUm04VVRqBA62pKGvRdPUb1PdjaMlaZusGXjcMF6L4UfWdegyo0jd92fsSp+eeEJ+pUwJvjsDx1/fyuH0IIem/sqELoaNzCN+4AT41nEnJphyC5Ns+hJQ5rhR4R3EbKj1pSRPx5RyVSfb5lKZy9K/9c7eyRGEj2VtopNOSCFUw005IYU9sH0OiiP6Kd3ZwO1aTAhW9xYZfQsv7djMnRf74EDgqShNm4ZzTuzVz1oBeHIeKjNFpf3tP7Zx8HZ9cblP1CdyNOA7VmONPHTaJj6raPmNDMjuiK0KTlM82F9UcitEpgv/bfS+fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(38100700002)(122000001)(83380400001)(38070700005)(31696002)(86362001)(41300700001)(76116006)(478600001)(5660300002)(8936002)(6486002)(66476007)(54906003)(966005)(66556008)(4326008)(8676002)(316002)(66446008)(66946007)(64756008)(91956017)(71200400001)(6916009)(2616005)(186003)(6506007)(2906002)(6512007)(26005)(84970400001)(31686004)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkFmZzJteTBUZmxzTTBhakdEVHlxODAwQ1hzRnZCTlNLWHQ2Y0xxOWlXaXpT?=
 =?utf-8?B?WUVUaCs2VGpFWXJQamZ6MlFkR0hKNjUreUxsdzBYMFNaNlA3QWpzVXdYWmRQ?=
 =?utf-8?B?NktJS3NsMnVLbHVvbS9rbE90YVdHVTJXOFFjZDQ4a2tCeW5HMjhvWHRMZjJG?=
 =?utf-8?B?bnNTd3Y1b3JJRGMzVXk0dzlyVTA4ZHVoSkhGS3kzQmlvQUtjTHJwSnQrWkRG?=
 =?utf-8?B?b0tQNmZsbDlLSm5OcGhSR0lsd2U4YmFzUC8rZFh6bUg0UUttcDEwL0lQNzFD?=
 =?utf-8?B?bVhjREl1bmIrNysxVHg4R1Fmeml1bmdaenJUTjZFWjA3bmNvVHhDc0JzS3Q4?=
 =?utf-8?B?eHlJWDQxYi9TZnNtSm9wb1FwUy9uaTFJbkF2TTFmUzcrVWdjOElzaDl6UHdR?=
 =?utf-8?B?OWhGMlozNFgrTWF0Z09jY0tqdS9pUHFJTEt6TU1BdUJTZWZGTnBHT21TVW1J?=
 =?utf-8?B?OGJER3EzWmRFVnpUU0FVU0dRcmFMaURWVytRMTkxL3dxbFlIQ2FVc05LbWtj?=
 =?utf-8?B?UGFPaklvRXFhSFZsQ0hyUjFhek41bkV0RG5sSkp4bGIzdDcyNEFzYXM5UXZr?=
 =?utf-8?B?Y0YxQS8yK2JLN094SGNvdkZiWmJNU3EwZGZIYTA5SGRFNFpER3ZwWTZGZm1M?=
 =?utf-8?B?N2xIRCtWZGZONHY3N1JFNzhwZ05GQ1grYWMxSXFjaDZZTTluLy9BNlNGeUhC?=
 =?utf-8?B?TEZ1MjVvTktQR1ZFRUNmS21oSXhuK3ZjS3kySDdobWw4UDNCVFdSZnZkd3RV?=
 =?utf-8?B?S1JDUm1NR2dHdU5pT2kyQVpJQVFZWUNkeFRhTjlLcm1XQXd1SGpBUlgrcXN4?=
 =?utf-8?B?Mnp3cEt0bU5oWWRvdTU5STd0SzZjaG91RFJOWndtcFA2ZkdXRURXS3Bwdnp2?=
 =?utf-8?B?clNuZVQwSXdIOVZWTk9TTGx6OTd3OGZRMXcvZHVQNDQ0OEduRGFtOUMvNUxi?=
 =?utf-8?B?UDFGaGloaDhTNWdkQXFvZGUrYjdIRHZiNlcvSUNWRWxvYXp3SGpRaTdvZFF4?=
 =?utf-8?B?RjhabmsyamMzY0NIeWxva1o2MnhYTnJnVFMzZGVKRzJsYkJuMVBJYWViZUZQ?=
 =?utf-8?B?YlRaR1lsZ24xREpJQzFkQ2FEeWlXSlVyQXFLNElvWC9qcUN6YWpCOUVsWEdH?=
 =?utf-8?B?TEZSYm82K3lLajllVzFNUy9SNys3bTIyd3orSU1FMU1pVmNKUUVHT3F0VHFB?=
 =?utf-8?B?OWVzT01NY1V4YVdDei80akFDRy9nTXZXZWx5RllrU2Rja1ZzZ3YzT2lCTWhN?=
 =?utf-8?B?V0NXeUxRbzFIRy9Ua1lrTmJXM09TRzFFbmw5YkRPeGZsekdyOEI4Rzl6TkI4?=
 =?utf-8?B?RTFsSFMxdmF3U0JDb2x6L0tMV3E3Y1h5R3lVWlhTNkF3ZEN1Rm0wYklIbStr?=
 =?utf-8?B?S0ZFbWZSeFJoajltK0RSdjd5TUdYTGwvYjdkRVJoc2YrUmlyajA4ZFdjTHZl?=
 =?utf-8?B?cHlBUlBmQmxYcFRJVnFuUmVSV3J6VVNJWUkxVU0xRmpLNkZITDUwa1VDajBJ?=
 =?utf-8?B?MkV1MTJCOWJFNFFVT3QvMXRLOWQxR0xGL2ptS3UwMkM2MnBqaStBL2FrS1NZ?=
 =?utf-8?B?aHZVcTNsZFc0dmh4dzYvY25JZVNjWFlUeHI5QmlsdmdIQ0JRSDhIcHAwVGd2?=
 =?utf-8?B?Umh0c0JYdkVhRWllRnliZHEwbGIwOXo5ZWJZdjVrcWs5TnNTbVhyUzVML0ZI?=
 =?utf-8?B?Smdta1lac0luOUVBL2FOSWR4MmJqUGRqVlkrbWxLOFlyN0pXSCtuK2xVYTJu?=
 =?utf-8?B?NEdxNksvZjJLRnJpVXVZS29IelBTdUFlR3BIUkVpWVozTnBEbkg3OEpGaGZJ?=
 =?utf-8?B?TVlIcDZFTVhTcWVKK083dmJUUDhQK09MZnpHR1Jtc3FSb2FoUVJYd2ppQUR5?=
 =?utf-8?B?aFdmZFBxclRxakU1dTFWUG5vd0lzNjNtSVJyOWszMHNVV3oySHkzREJNeXRT?=
 =?utf-8?B?ajIrZExQaEo0cXRnVXBwd3BTZjRhQmt3cDlZUUVIRHBQcUJLclJjVjN1MUYr?=
 =?utf-8?B?S3N3SGhlR0xkajNyNktXL1o5cTU4cXdxQTJENjViTk40MjllY2xTUmZUTHBr?=
 =?utf-8?B?cUs4Q2YyM2J4eGVhRjA1UFY3Tk9IY3ljcmFpT1NjMW05NHE5SjZxY1BockVr?=
 =?utf-8?Q?eQtLzHwsVCxkKSaWQojdK/oP7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4979B2FF6BB44B44A2D22CE360D1FBD5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba6a7d5-3f8e-4280-0feb-08dac74fa3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 21:23:29.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDzLhCBXo+opYWCsfkmBSA6zqoLkOuoCB22krVVRp6eSIo8CGSNgFnh8zZGNIixWZOwECMq6EOsxj6FKzuXC5nhu2vvu4a/DYStajjQYYX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URI_HEX,URI_NOVOWEL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IERlZXBhaywNCg0KT24gMTUvMTEvMjAyMiAyMDo0MCwgRGVlcGFrIEd1cHRhIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGNzcl9zc2NyYXRjaCBD
U1IgaG9sZHMgY3VycmVudCB0YXNrX3N0cnVjdCBhZGRyZXNzIHdoZW4gaGFydCBpcyBpbg0KPiB1
c2VyIHNwYWNlLiBUcmFwIGhhbmRsZXIgb24gZW50cnkgc3BpbGxzIGNzcl9zc2NyYXRjaCBpbnRv
ICJ0cCIgKHgyKQ0KPiByZWdpc3RlciBhbmQgemVyb2VzIG91dCBjc3Jfc3NjcmF0Y2ggQ1NSLiBU
cmFwIGhhbmRsZXIgb24gZXhpdCByZWxvYWRzDQo+ICJ0cCIgd2l0aCBleHBlY3RlZCB1c2VyIG1v
ZGUgdmFsdWUgYW5kIHBsYWNlIGN1cnJlbnQgdGFza19zdHJ1Y3QgYWRkcmVzcw0KPiBhZ2FpbiBp
biBjc3Jfc3NjcmF0Y2ggQ1NSLg0KPiANCj4gVGhpcyBwYXRjaCBhc3N1bWVzICJ0cCIgaXMgcG9p
bnRpbmcgdG8gdGFza19zdHJ1Y3QuIElmIHZhbHVlIGluDQo+IGNzcl9zc2NyYXRjaCBpcyBudW1l
cmljYWxseSBncmVhdGVyIHRoYW4gInRwIiB0aGVuIGl0IGFzc3VtZXMgY3NyX3NzY3JhdGNoDQo+
IGlzIGNvcnJlY3QgYWRkcmVzcyBvZiBjdXJyZW50IHRhc2tfc3RydWN0LiBUaGlzIGxvZ2ljIGhv
bGRzIHdoZW4NCj4gICAgLSBoYXJ0IGlzIGluIHVzZXIgc3BhY2UsICJ0cCIgd2lsbCBiZSBsZXNz
IHRoYW4gY3NyX3NzY3JhdGNoLg0KPiAgICAtIGhhcnQgaXMgaW4ga2VybmVsIHNwYWNlIGJ1dCBu
b3QgaW4gdHJhcCBoYW5kbGVyLCAidHAiIHdpbGwgYmUgbW9yZQ0KPiAgICAgIHRoYW4gY3NyX3Nz
Y3JhdGNoIChjc3Jfc3NjcmF0Y2ggYmVpbmcgZXF1YWwgdG8gMCkuDQo+ICAgIC0gaGFydCBpcyBl
eGVjdXRpbmcgdHJhcCBoYW5kbGVyDQo+ICAgICAgICAtICJ0cCIgaXMgc3RpbGwgcG9pbnRpbmcg
dG8gdXNlciBtb2RlIGJ1dCBjc3Jfc3NjcmF0Y2ggY29udGFpbnMNCj4gICAgICAgICAgIHB0ciB0
byB0YXNrX3N0cnVjdC4gVGh1cyBudW1lcmljYWxseSBoaWdoZXIuDQo+ICAgICAgICAtICJ0cCIg
aXMgIHBvaW50aW5nIHRvIHRhc2tfc3RydWN0IGJ1dCBjc3Jfc3NjcmF0Y2ggbm93IGNvbnRhaW5z
DQo+ICAgICAgICAgICBlaXRoZXIgMCBvciBudW1lcmljYWxseSBzbWFsbGVyIHZhbHVlICh0cmFu
c2llbnRseSBob2xkcw0KPiAgICAgICAgICAgdXNlciBtb2RlIHRwKQ0KPiANCj4gUGF0Y2ggYWxz
byBhZGRzIG5ldyBjYWNoZWQgdHlwZSAidWxvbmciIGluIHNjcmlwdHMvZ2RiL2xpbnV4L3V0aWxz
LnB5DQo+IA0KDQo+IFNpbmNlIHBhdGNoIGhhcyBjaGFuZ2VkIGEgbGl0dGxlIGJpdCBmcm9tIHYx
IGFuZCBJIGRpZG4ndCBpbmNsdWRlDQo+IGNoYW5nZWxvZyBlYXJsaWVyLCBoZXJlIGl0IGlzLg0K
DQpUaGlzIGJpdCBoZXJlIG5lZWRzIHRvIGdvIGJlbG93IHRoZSAtLS0gbGluZSBhcyBpdCBzaG91
bGQgbm90IGVuZCB1cA0KaW4gdGhlIGNvbW1pdCBsb2dzIChhcyBldmVyeXRoaW5nIGJlbG93IHRo
ZSAtLS0gaXMgaWdub3JlZC4NCg0KPiANCj4gLS0tDQo+IHYxIC0tPiB2MjoNCj4gIC0gYWRkZWQg
bG9naWMgdG8gbG9jYXRlIHRhc2tfc3RydWN0IGlycmVzcGVjdGl2ZSBvZiBwcml2DQo+ICAtIG1h
ZGUgbG9jYXRpbmcgdGFza19zdHJ1Y3QgYWdub3N0aWMgdG8gYml0bmVzcygzMiB2cyA2NCkuDQo+
ICAtIGFkZGVkIGNhY2hpbmcgb2YgdWxvbmcgdHlwZSBpbiBzY3JpcHRzL2dkYi9saW51eC91dGls
cy5weQ0KPiAgLSBhZGRlZCBtb3JlIGRlc2NyaXB0aXZlIGNvbW1pdCBtZXNzYWdlDQo+IA0KPiB2
MiAtLT4gdjM6DQo+ICAtIGFtZW5kZWQgY29tbWl0IG1lc3NhZ2UgYW5kIHNvdXJjZSBsaW5lIHRv
IGZpdCBjb2x1bW4gd2lkdGgNCj4gDQo+IHYzIC0tPiB2NDoNCj4gIC0gYW1lbmRlZCBjb21taXQg
bWVzc2FnZSBhbmQgcmVtb3ZlIHdoaXRlc3BhY2UgaW4gc291cmNlDQo+ICAtIGFkZGVkIFJldmll
d2VkLWJ5IGZvciByZXZpZXdlcnMNCj4gLS0tDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZWVwYWsg
R3VwdGEgPGRlYnVnQHJpdm9zaW5jLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBKb25lcyA8
YWpvbmVzQHZlbnRhbmFtaWNyby5jb20+DQoNCkFuZCB0aGlzIGJpdCBuZWVkcyB0byBnbyBhYm92
ZSB0aGUgZmlyc3QgLS0tIGxpbmUgYXMgaXQgZG9lcyBuZWVkDQp0byBnbyBpbnRvIHRoZSBjb21t
aXQgbG9ncy4NCg0KVGhlIG9yZGVyIGlzOg0KJHN1YmplY3QNCg0KYm9keQ0KDQp0YWdzDQotLS0N
CmNoYW5nZWxvZyAmIGNvbW1lbnRzDQoNCmRpZmZzDQoNCkZvciBleGFtcGxlLCB0aGlzIGlzIHdo
YXQgSSBzZWUgd2hlbiBJIGFwcGx5IHRoZSBwYXRjaDoNCg0KJCBiNCBzaGF6YW0gMjAyMjExMTUy
MDQwMDMuMTg2NjQyMS0xLWRlYnVnQHJpdm9zaW5jLmNvbQ0KR3JhYmJpbmcgdGhyZWFkIGZyb20g
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMTExNTIwNDAwMy4xODY2NDIxLTEtZGVidWclNDByaXZv
c2luYy5jb20vdC5tYm94Lmd6DQpDaGVja2luZyBmb3IgbmV3ZXIgcmV2aXNpb25zIG9uIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8NCkFuYWx5emluZyAxMyBtZXNzYWdlcyBpbiB0aGUgdGhy
ZWFkDQpXaWxsIHVzZSB0aGUgbGF0ZXN0IHJldmlzaW9uOiB2NA0KWW91IGNhbiBwaWNrIG90aGVy
IHJldmlzaW9ucyB1c2luZyB0aGUgLXZOIGZsYWcNCkNoZWNraW5nIGF0dGVzdGF0aW9uIG9uIGFs
bCBtZXNzYWdlcywgbWF5IHRha2UgYSBtb21lbnQuLi4NCi0tLQ0KICDinJMgW1BBVENIIHY0XSBz
Y3JpcHRzL2dkYjogYWRkIGx4X2N1cnJlbnQgc3VwcG9ydCBmb3IgcmlzY3YNCiAgLS0tDQogIOKc
kyBTaWduZWQ6IERLSU0vcml2b3NpbmMtY29tLjIwMjEwMTEyLmdhcHBzc210cC5jb20gKEZyb206
IGRlYnVnQHJpdm9zaW5jLmNvbSkNCi0tLQ0KVG90YWwgcGF0Y2hlczogMQ0KLS0tDQpBcHBseWlu
Zzogc2NyaXB0cy9nZGI6IGFkZCBseF9jdXJyZW50IHN1cHBvcnQgZm9yIHJpc2N2DQoNCiQgZ2l0
IHNob3cNCmNvbW1pdCA1YzkzNjE3YzY4OTgwZjc2N2UzMTJmYzUxODQ5ZDc4MDkzZjU2ZTcyIChI
RUFEKQ0KQXV0aG9yOiBEZWVwYWsgR3VwdGEgPGRlYnVnQHJpdm9zaW5jLmNvbT4NCkRhdGU6ICAg
VHVlIE5vdiAxNSAxMjo0MDowMyAyMDIyIC0wODAwDQoNCiAgICBzY3JpcHRzL2dkYjogYWRkIGx4
X2N1cnJlbnQgc3VwcG9ydCBmb3IgcmlzY3YNCiAgICANCiAgICBjc3Jfc3NjcmF0Y2ggQ1NSIGhv
bGRzIGN1cnJlbnQgdGFza19zdHJ1Y3QgYWRkcmVzcyB3aGVuIGhhcnQgaXMgaW4NCiAgICB1c2Vy
IHNwYWNlLiBUcmFwIGhhbmRsZXIgb24gZW50cnkgc3BpbGxzIGNzcl9zc2NyYXRjaCBpbnRvICJ0
cCIgKHgyKQ0KICAgIHJlZ2lzdGVyIGFuZCB6ZXJvZXMgb3V0IGNzcl9zc2NyYXRjaCBDU1IuIFRy
YXAgaGFuZGxlciBvbiBleGl0IHJlbG9hZHMNCiAgICAidHAiIHdpdGggZXhwZWN0ZWQgdXNlciBt
b2RlIHZhbHVlIGFuZCBwbGFjZSBjdXJyZW50IHRhc2tfc3RydWN0IGFkZHJlc3MNCiAgICBhZ2Fp
biBpbiBjc3Jfc3NjcmF0Y2ggQ1NSLg0KICAgIA0KICAgIFRoaXMgcGF0Y2ggYXNzdW1lcyAidHAi
IGlzIHBvaW50aW5nIHRvIHRhc2tfc3RydWN0LiBJZiB2YWx1ZSBpbg0KICAgIGNzcl9zc2NyYXRj
aCBpcyBudW1lcmljYWxseSBncmVhdGVyIHRoYW4gInRwIiB0aGVuIGl0IGFzc3VtZXMgY3NyX3Nz
Y3JhdGNoDQogICAgaXMgY29ycmVjdCBhZGRyZXNzIG9mIGN1cnJlbnQgdGFza19zdHJ1Y3QuIFRo
aXMgbG9naWMgaG9sZHMgd2hlbg0KICAgICAgIC0gaGFydCBpcyBpbiB1c2VyIHNwYWNlLCAidHAi
IHdpbGwgYmUgbGVzcyB0aGFuIGNzcl9zc2NyYXRjaC4NCiAgICAgICAtIGhhcnQgaXMgaW4ga2Vy
bmVsIHNwYWNlIGJ1dCBub3QgaW4gdHJhcCBoYW5kbGVyLCAidHAiIHdpbGwgYmUgbW9yZQ0KICAg
ICAgICAgdGhhbiBjc3Jfc3NjcmF0Y2ggKGNzcl9zc2NyYXRjaCBiZWluZyBlcXVhbCB0byAwKS4N
CiAgICAgICAtIGhhcnQgaXMgZXhlY3V0aW5nIHRyYXAgaGFuZGxlcg0KICAgICAgICAgICAtICJ0
cCIgaXMgc3RpbGwgcG9pbnRpbmcgdG8gdXNlciBtb2RlIGJ1dCBjc3Jfc3NjcmF0Y2ggY29udGFp
bnMNCiAgICAgICAgICAgICAgcHRyIHRvIHRhc2tfc3RydWN0LiBUaHVzIG51bWVyaWNhbGx5IGhp
Z2hlci4NCiAgICAgICAgICAgLSAidHAiIGlzICBwb2ludGluZyB0byB0YXNrX3N0cnVjdCBidXQg
Y3NyX3NzY3JhdGNoIG5vdyBjb250YWlucw0KICAgICAgICAgICAgICBlaXRoZXIgMCBvciBudW1l
cmljYWxseSBzbWFsbGVyIHZhbHVlICh0cmFuc2llbnRseSBob2xkcw0KICAgICAgICAgICAgICB1
c2VyIG1vZGUgdHApDQogICAgDQogICAgUGF0Y2ggYWxzbyBhZGRzIG5ldyBjYWNoZWQgdHlwZSAi
dWxvbmciIGluIHNjcmlwdHMvZ2RiL2xpbnV4L3V0aWxzLnB5DQogICAgDQogICAgU2luY2UgcGF0
Y2ggaGFzIGNoYW5nZWQgYSBsaXR0bGUgYml0IGZyb20gdjEgYW5kIEkgZGlkbid0IGluY2x1ZGUN
CiAgICBjaGFuZ2Vsb2cgZWFybGllciwgaGVyZSBpdCBpcy4NCg0KVGFrZW4gYSB3ZWUgYml0IG9m
IHRoZSBiYWNrIGFuZCBmb3J0aCwgTG9va3MgbGlrZSB5b3UncmUgbmVhcmx5DQp0aGVyZSB0aG91
Z2ghDQoNCkNvbm9yLg0KDQo=
