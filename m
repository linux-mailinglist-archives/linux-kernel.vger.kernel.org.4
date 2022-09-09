Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F45B35F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIILC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIILCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:02:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814DB139C19;
        Fri,  9 Sep 2022 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662721335; x=1694257335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Or9r3NCPxFU9DXEw0QbG8VQuLMu5ryWbHAeeObSCJk=;
  b=bi1JUETAv8UoPG25zMJJZeLZ7vOmFdbrHg2vNUZkC5xnnmyF34A0OVxp
   9pF85nB3D06hGqme167B6WxG04tXBvbijiE5CUa3k9p5eR2gWl8jWqupa
   BfWtTiv/lFJ2AtIqRqigEIqs1UKeUqlFJDKkyxAa+HtPrYYhkCGrEr7fN
   g/kDXEKHq7g3ztqsz3NLPbSFMq/FH8BGd6qOArzkx5dmAPwkUZaUn6Cqh
   2CHemhLAiPHWXMQ8ci8fFd58nPdl9F9k7PFMzs6fdaVLBGvUxAaChw5BV
   eArVSiJczZl8D9yVwwVaL/WYH8RQ+6QlNeGrGhAH5Liz84SNacQHJY8Pu
   A==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="112917643"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 04:02:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 04:02:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 9 Sep 2022 04:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFan9zhSzWTVOTxKVOaHEnJ/JwP+OAjBOGTLsZvkVi/hdcyE7SZ8wow+9Ubj4JYnetNe7HDobfIazJ7Va7MN/h7lzV2x4YZdbMNTjAE3sbSc6SD57V88L/h70uQsqhBmrYHjDkbP2Jw19KJxVqWiWf1Y3VdaCrLZZ0B7010MzhZb2RdLalzfRsa8s8aZQhrhBBlJfGNcVCVFNGgN0kUYLGU29mefwfd4MimaSx/GaFkc7zfaTPo7BE++MVfjndWvqx1X6i/8M2tAXwrVkYnAZju/nbkUSTFGABj2P5MJL/Q/DRvdIr+AASYaT8eQd8Vl6jKIDYggEDfBUCFpthdqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Or9r3NCPxFU9DXEw0QbG8VQuLMu5ryWbHAeeObSCJk=;
 b=HFWIAc/caMrGJNlXAmLnT8EEB1ZdmN4oOIFm3jhKZ1ZzTTp7N4U9dgF8h0w8qeTDNCQoQ2zR8MlVjWQ1nbeRh03SBnV69jEx+74i7rQF1j615gR0JH6ECvrL2ApdkaTlHucWe2bYg3DqKBrDh/wYfmv1hikwsVQqtZfO+H4S4xcM4bUKofnetVHNb9GtCPaDTiRxYDdJN/m1kH4iM1MIvsz5dc6qv7D0DJfKp68hXJVI8DCRkzOhN4GQEV4oZYHbF1axrnmHjPYWuVVpgL628+q5/6BiN9R63MrKMAubm+s9r1bN0c22QGREXcHcBDEn4v7Ei7GOwX4zYHObCW0kQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Or9r3NCPxFU9DXEw0QbG8VQuLMu5ryWbHAeeObSCJk=;
 b=GVRzDYUQQEmzOOWpff0CUOn82fMbFtD3mDL3JLT92mVR18jhl3iU3Sz0y69TmVyAL0N+fxF38PDHsEmlbF4DiIais5t41BjMqACvrfrHMTX47wss/v/jCznP2NZK1ZgIkNPCCsUBAx1bL2+1mJCusSYkLi4+iqdy08sX26Fa2Wk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Fri, 9 Sep
 2022 11:01:58 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 11:01:57 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <nathan@kernel.org>
Subject: Re: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Topic: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Index: AQHYvG98o22tTG+7mU6lxnNYP43gca3VJAaAgAABIACAAdkNgA==
Date:   Fri, 9 Sep 2022 11:01:57 +0000
Message-ID: <c2974113-83de-85db-106e-7e3e5437b14d@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-1-conor.dooley@microchip.com>
 <119b58b7-7757-7f76-1472-8047961c9dd1@microchip.com>
 <9ffd5028-6639-9c3c-e09b-c9b7602a2ec1@microchip.com>
In-Reply-To: <9ffd5028-6639-9c3c-e09b-c9b7602a2ec1@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH0PR11MB5829:EE_
x-ms-office365-filtering-correlation-id: ffd5f243-62b9-4e3d-6ac4-08da9252b685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsKcaQJV85Lmx7VuEfcY6bRHuUMx4q75QsNldomfP2bMr3AGxdDJZWdPrnZ/2lTGHMWp6Gckj2E+lVjlP22en9DPhwXuA4V8OFIKX2f1PWEFRhs4ti6RoM+2hYOoqF3iVCoqh9f1+n7m90IeApIv29TCPga+MgpgjDoikOCAyUS0OuyyMxYVvxtTHCTuQuDD0COtMauv5mHDsA4m8nLd0LklNpnkvSASWfiyDSTweieIuJlDgEc6EB3r9RVSSP1RAdSEP1VZ3jA3NAJgNCqZO33/UTRRC9uSAkGdjWPBxvRyIYjpvBIiV6bke6PIY0kfLm6EAibeF+r7RpMhsVbPbW5DFwyK0BY+d+E36Bb17ag6X6zYej6zIwO4gYLvHN+3UnK2IKw08rKAPE6ihKz0B/aVxLxD1smuXO/lfjhVXnVfY9rfJrbJFajsaf2Luvbm/JEt8gFFnnMooocda5iLAvPs5No+UQj6q1QJ1QtJExwrWW9RlRFbcNK60fpS6WtrLhRhTauM69CssIlH106v8kHJy2Jm6CNQGL/rgejcuQSddNevuwhfT/dXBdbBYZ8bTQYKTm6KeFidvLLuXfGs8KDnEG4TUM24kXJoH1eEfjC89FS8ObM8A9ru9JiYM6HIjTEP/fgyAV96j7jkgY5ftHmjyWgVTi8WJZ0BZn0dZVjykNNaLtwq84J46IOsr3YoIi8WZvw6tkbxa3vFYAfuWeBeld01uCKQ8EgC8laeBznVqj5tc3DR1O1WPG2iJ0iFCX1xDw/lh57y0JL+U5QTTAyhdnfkZlC5U0kg2BSiVBmKK/T9+tOU1EXkIQwxCE/yqEtwqQenMuLBGBo+n57wdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(136003)(39860400002)(396003)(83380400001)(41300700001)(186003)(8676002)(76116006)(91956017)(4326008)(122000001)(31686004)(7416002)(478600001)(6486002)(71200400001)(36756003)(2616005)(6506007)(53546011)(26005)(45080400002)(6512007)(316002)(86362001)(2906002)(66556008)(38100700002)(54906003)(110136005)(31696002)(5660300002)(66946007)(6636002)(8936002)(64756008)(66446008)(38070700005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNFdm9DeENXVHVsbFdvd3lVcUpjZEpZc2dzS0I3OVZtY3AwbDlDbGRsN2Rp?=
 =?utf-8?B?dnpzRk5vT1ZZekdCdlIxd1RmN3dvY2hTR0JnaXI0T0VJSGZYeTJtc0IvMjQz?=
 =?utf-8?B?WFhwSnpPMXA5K005RmhUMXNhQkdEdHY1azgrazBPOHRxSTVyLzhrYmovcFMr?=
 =?utf-8?B?K0NNdWxJV21UQ2JuSzdndUNTRGhpNytJQmlaSTN6SXZNTmR1WENWRnVZZ3VE?=
 =?utf-8?B?UFBWQmYzQkZKb3Y1K3ljOU41RE80Uk9zQVNjL1BXVHR2VzhPTStVRVhZVWhi?=
 =?utf-8?B?NzkvU2tvcStST21qZ0dvQldESjZZSCt6MkhsZml2TFMvZFRGMjdqMzJaNlJC?=
 =?utf-8?B?ZlJuNUhzd21rc0xtbTlJdm5zYUR2cUw3TGVWSU95ck12UHVhUEJMa2E4Y2dM?=
 =?utf-8?B?TGpxL3V4MDcvVEplK0g4L0RGZjNXR0NvcFlHS0dvZGNnZ3l0RUEwbHpLRFE5?=
 =?utf-8?B?TERwQUttY29JdHZDU1dqajZmTXpucU9qRTZhaE0zZ0NFQjJjUzJhY1QrNEZO?=
 =?utf-8?B?MFN2STd0QlM1aGdRaUpjaG1yb1V4ZkRlWXRqdU9pSjNaYUZkWWsrbjJkMmww?=
 =?utf-8?B?LzR6VURDelFwNUViWE1YVHNzbDFzM2VYSStaeThxRktUYVI5bWNiMkUwYjNo?=
 =?utf-8?B?VEVyZmcrWGdFTk92WnNOQmhXRUNyeDhnOWdLZmd2YjN5N1VDU1ZDaUdjN213?=
 =?utf-8?B?ZjFVMXp3MHhXRWo0dVVUTVdyTjdsYWg1STRPVFdTU1QyTWNhSjhHb012aDZq?=
 =?utf-8?B?VmlBWXF4RVNGTkE1WFdjNzFNOVZXZlF5Q3pvbHdFRFVHOEN3czltUGVTak1U?=
 =?utf-8?B?Q1pzamlYcFp0eUV0c0lMWEZUZHo5VFdTRkRCWHN4c3hiOFc5SStyQU1pQ0Nx?=
 =?utf-8?B?NTdUNDdFVkhyRHloblVCYS9pcm5PaEE0NysrK25tdXFXOWNGK3NvOU5uckNZ?=
 =?utf-8?B?Ky8wRk1qRk03dDVsZHVWc3dlQmp2QnQzZ05tckpaRm55eG9kY3dSaUc0V2pT?=
 =?utf-8?B?MTJWOWhBUGNNZW9seWMzaXVGVHdCZkVyQ1ltRkljOWVoNm5UOVkxRUp0ellr?=
 =?utf-8?B?ajhxWXJJNE5VR09xTnd4NEpmM0JIRGZrNWkwclZjS3NiaENLUzdLK3BCSTYw?=
 =?utf-8?B?RlFjN3VZd01HSEQ4cGJhazNQMG1SSCtWeDc0dFU2b3dlb3E5R2JqU2lsNEho?=
 =?utf-8?B?Qm5rd2J0RkRmdzlMMXNwZFpxaG1nVjdab3hIeElhKy84VnYraVRFVmRDaHZM?=
 =?utf-8?B?Sk9Bb3BWdUxPL1hWYlFBVGVwZXlGRDRTaGxwd3ViWUhZWEpMTFMvYjRTb1Ix?=
 =?utf-8?B?SmRSYW1Sb3RvY1o1azU4cGNOV0R6eEtwaUxkeWpFYzQ1a0xwTkxWVDIza1FH?=
 =?utf-8?B?cnpJTmtxZStOcWF2Y3V1QlNJM0c3U3k3eEh2VkVmRjR3L1Z3aTRYSWhMMFdD?=
 =?utf-8?B?bDVMM0pkRCtjWmIxM1Q0ZjNQR1lta1l5NU1qRmhFR0pQZVNDWjJidWRMOURS?=
 =?utf-8?B?YW03aTRiZU42Qlk3N2xuaG10cHkwTkhQS3ByaGhTM1h4c3N2b1RDQ1NQem1K?=
 =?utf-8?B?VEFXRStVc2lTMk5SWGJyN1ZxR1AvVG9JU3J1RFVjYWtDUlRPaG5IL3BJdzVV?=
 =?utf-8?B?ZCtnSW1Xei9TVmtEcUVlSUhkUTkwcXByWDhoR2x3Mkk5a1RGU08zWWl3ek55?=
 =?utf-8?B?b0d6VUhpTHNlc2I0VENtWi9EVzd6T1dLUDVnWU5aTWgzc083YkVCdTdKbmZJ?=
 =?utf-8?B?ZHdjV2ZLWGNGeXFvWWpxTEdjV0Q4K0EyYTMySDAyZXBZTWFxSXpNQklJTTQ1?=
 =?utf-8?B?NC9EUEdsSVhzZm5aVm1HUTJ1a2N5Q3lRSlZHRW5GL3VsdkhSN01PaE0waDBn?=
 =?utf-8?B?SzdUbjdzRS9nakE0UzFVNXJQV2pmYXRBUU9Dd0EyL2s5SHRzUjl1V0JUMk9Y?=
 =?utf-8?B?ZHd2T1BWWWhIY0w4QzlXQjY4VzZCelJGaDA5S1Y0Q0JFa2dzUlUwdnVSaWVN?=
 =?utf-8?B?RlhDVHhzRTNNVEs1OWZZblJmRnR0NThCeHFzWE5Wbmhoa1c1OXNLYzNvMGoz?=
 =?utf-8?B?VVNiOURmRUFaZk1FRmJUWS9EWG56Tnd3SnZJdXhFYVF2UDE0UDNmeHVYbnhC?=
 =?utf-8?Q?n5I1xJQpcPNghkJmP1hm8Zpem?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A42C23A96AF4E9408B9DA64CDEADE156@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd5f243-62b9-4e3d-6ac4-08da9252b685
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 11:01:57.3047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHXPE3IS/F+LcaO57LnKGU2TmhVnXKkugmdA+85fy4Q9pCtD5o67lq1J1S8tMdfOW2GSc9D+ZEYpiGX4JAraG4W+umQBlOVY4mXb8nCF5E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAwNzo0OCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiAwOC8wOS8yMDIy
IDA3OjQ0LCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToNCj4+IE9uIDMwLjA4LjIwMjIg
MTU6NTIsIENvbm9yIERvb2xleSB3cm90ZToNCj4+PiBVbm5vdGljZWQgaW4gY3VycmVudCBjb2Rl
LCB0aGVyZSBpcyBhbiBhcnJheSBib3VuZHMgdmlvbGF0aW9uIHByZXNlbnQNCj4+PiBkdXJpbmcg
Y2xvY2sgcmVnaXN0cmF0aW9uLiBUaGlzIHNlZW1zIHRvIGZhaWwgZ3JhY2VmdWxseSBpbiB2Ni4w
LXJjMSwNCj4+PiBhbmQgbGlmZSBjYXJyeXMgb24uIFdoaWxlIGNvbnZlcnRpbmcgdGhlIGRyaXZl
ciB0byB1c2Ugc3RhbmRhcmQgY2xvY2sNCj4+PiBzdHJ1Y3RzL29wcywga2VybmVsIHBhbmljcyB3
ZXJlIHNlZW4gZHVyaW5nIGJvb3Qgd2hlbiBidWlsdCB3aXRoIGNsYW5nOg0KPj4+DQo+Pj4gW8Kg
wqDCoCAwLjU4MTc1NF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMGIxDQo+Pj4gW8KgwqDCoCAw
LjU5MTUyMF0gT29wcyBbIzFdDQo+Pj4gW8KgwqDCoCAwLjU5NDA0NV0gTW9kdWxlcyBsaW5rZWQg
aW46DQo+Pj4gW8KgwqDCoCAwLjU5NzQzNV0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAg
Tm90IHRhaW50ZWQgNi4wLjAtcmMxLTAwMDExLWc4ZTE0NTljZjRlY2EgIzENCj4+PiBbwqDCoMKg
IDAuNjA2MTg4XSBIYXJkd2FyZSBuYW1lOiBNaWNyb2NoaXAgUG9sYXJGaXJlLVNvQyBJY2ljbGUg
S2l0IChEVCkNCj4+PiBbwqDCoMKgIDAuNjEzMDEyXSBlcGMgOiBfX2Nsa19yZWdpc3RlcisweDRh
Ni8weDg1Yw0KPj4+IFvCoMKgwqAgMC42MTc3NTldwqAgcmEgOiBfX2Nsa19yZWdpc3RlcisweDQ5
ZS8weDg1Yw0KPj4+IFvCoMKgwqAgMC42MjI0ODldIGVwYyA6IGZmZmZmZmZmODAzZmFmN2MgcmEg
OiBmZmZmZmZmZjgwM2ZhZjc0IHNwIDogZmZmZmZmYzgwNDAwYjcyMA0KPj4+IFvCoMKgwqAgMC42
MzA0NjZdwqAgZ3AgOiBmZmZmZmZmZjgxMGU5M2Y4IHRwIDogZmZmZmZmZTc3ZmU2MDAwMCB0MCA6
IGZmZmZmZmU3N2ZmYjM4MDANCj4+PiBbwqDCoMKgIDAuNjM4NDQzXcKgIHQxIDogMDAwMDAwMDAw
MDAwMDAwYSB0MiA6IGZmZmZmZmZmZmZmZmZmZmYgczAgOiBmZmZmZmZjODA0MDBiN2MwDQo+Pj4g
W8KgwqDCoCAwLjY0NjQyMF3CoCBzMSA6IDAwMDAwMDAwMDAwMDAwMDEgYTAgOiAwMDAwMDAwMDAw
MDAwMDAxIGExIDogMDAwMDAwMDAwMDAwMDAwMA0KPj4+IFvCoMKgwqAgMC42NTQzOTZdwqAgYTIg
OiAwMDAwMDAwMDAwMDAwMDAxIGEzIDogMDAwMDAwMDAwMDAwMDAwMCBhNCA6IDAwMDAwMDAwMDAw
MDAwMDANCj4+PiBbwqDCoMKgIDAuNjYyMzczXcKgIGE1IDogZmZmZmZmZmY4MDNhNTgxMCBhNiA6
IDAwMDAwMDAyMDAwMDAwMjIgYTcgOiAwMDAwMDAwMDAwMDAwMDA2DQo+Pj4gW8KgwqDCoCAwLjY3
MDM1MF3CoCBzMiA6IGZmZmZmZmZmODEwOTlkNDggczMgOiBmZmZmZmZmZjgwZDZlMjhlIHM0IDog
MDAwMDAwMDAwMDAwMDAyOA0KPj4+IFvCoMKgwqAgMC42NzgzMjddwqAgczUgOiBmZmZmZmZmZjgx
MGVkM2M4IHM2IDogZmZmZmZmZmY4MTBlZDNkMCBzNyA6IGZmZmZmZmU3N2ZmYmMxMDANCj4+PiBb
wqDCoMKgIDAuNjg2MzA0XcKgIHM4IDogZmZmZmZmZTc3ZmZiMTU0MCBzOSA6IGZmZmZmZmU3N2Zm
YjE1NDAgczEwOiAwMDAwMDAwMDAwMDAwMDA4DQo+Pj4gW8KgwqDCoCAwLjY5NDI4MV3CoCBzMTE6
IDAwMDAwMDAwMDAwMDAwMDAgdDMgOiAwMDAwMDAwMDAwMDAwMGM2IHQ0IDogMDAwMDAwMDAwMDAw
MDAwNw0KPj4+IFvCoMKgwqAgMC43MDIyNThdwqAgdDUgOiBmZmZmZmZmZjgxMGM3OGMwIHQ2IDog
ZmZmZmZmZTc3ZmY4OGNkMA0KPj4+IFvCoMKgwqAgMC43MDgxMjVdIHN0YXR1czogMDAwMDAwMDIw
MDAwMDEyMCBiYWRhZGRyOiAwMDAwMDAwMDAwMDAwMGIxIGNhdXNlOiAwMDAwMDAwMDAwMDAwMDBk
DQo+Pj4gW8KgwqDCoCAwLjcxNjg2OV0gWzxmZmZmZmZmZjgwM2ZiODkyPl0gZGV2bV9jbGtfaHdf
cmVnaXN0ZXIrMHg2Mi8weGFhDQo+Pj4gW8KgwqDCoCAwLjcyMzQyMF0gWzxmZmZmZmZmZjgwNDAz
NDEyPl0gbXBmc19jbGtfcHJvYmUrMHgxZTAvMHgyNDQNCj4+Pg0KPj4+IEl0IGZhaWxzIG9uICJj
bGtfcGVyaXBoX3RpbWVyIiAtIHdoaWNoIHVzZXMgYSBkaWZmZXJlbnQgcGFyZW50LCB0aGF0IGl0
DQo+Pj4gdHJpZXMgdG8gZmluZCB1c2luZyB0aGUgbWFjcm86DQo+Pj4gXCNkZWZpbmUgUEFSRU5U
X0NMSyhQQVJFTlQpICgmbXBmc19jZmdfY2xrc1tDTEtfIyNQQVJFTlRdLmNmZy5odykNCj4+Pg0K
Pj4+IElmIHBhcmVudCBpcyBSVENSRUYsIHNvIHRoZSBtYWNybyBiZWNvbWVzOiAmbXBmc19jZmdf
Y2xrc1szM10uY2ZnLmh3DQo+Pj4gd2hpY2ggaXMgd2VsbCBiZXlvbmQgdGhlIGVuZCBvZiB0aGUg
YXJyYXkuIEFtYXppbmdseSwgYnVpbGRzIHdpdGggR0NDDQo+Pj4gMTEuMSBzZWUgbm8gcHJvYmxl
bSBoZXJlLCBib290aW5nIGNvcnJlY3RseSBhbmQgaG9va2luZyB0aGUgcGFyZW50IHVwDQo+Pj4g
ZXRjLiBCdWlsZHMgd2l0aCBjbGFuZy0xNSBkbyBub3QsIHdpdGggdGhlIGFib3ZlIHBhbmljLg0K
Pj4+DQo+Pj4gRHJvcCB0aGUgbWFjcm8gZm9yIHRoZSBSVENSRUYgYW5kIHVzZSB0aGUgYXJyYXkg
ZGlyZWN0bHkgdG8gYXZvaWQgdGhlDQo+Pj4gcGFuaWMsIHVzaW5nIGEgbmV3bHkgYWRkZWQgZGVm
aW5lIHRoYXQgYnJpbmdzIHRoZSBpbmRleCBpbnRvIHRoZSB2YWxpZA0KPj4+IHJhbmdlLg0KPj4+
DQo+Pj4gRml4ZXM6IDFjNmE3ZWEzMmI4YyAoImNsazogbWljcm9jaGlwOiBtcGZzOiBhZGQgUlRD
UkVGIGNsb2NrIGNvbnRyb2wiKQ0KPj4+IENDOiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtl
cm5lbC5vcmc+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlA
bWljcm9jaGlwLmNvbT4NCj4+PiAtLS0NCj4+PiDCoCBkcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xr
LW1wZnMuYyB8IDUgKysrKy0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWljcm9j
aGlwL2Nsay1tcGZzLmMgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPj4+IGlu
ZGV4IDA3MGMzYjg5NjU1OS4uOWU0MWYwN2IzZmE2IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMv
Y2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+Pj4gKysrIGIvZHJpdmVycy9jbGsvbWljcm9jaGlw
L2Nsay1tcGZzLmMNCj4+PiBAQCAtMjcsNiArMjcsOCBAQA0KPj4+IMKgICNkZWZpbmUgTVNTUExM
X1BPU1RESVZfV0lEVEjCoMKgwqAgMHgwN3UNCj4+PiDCoCAjZGVmaW5lIE1TU1BMTF9GSVhFRF9E
SVbCoMKgwqAgNHUNCj4+PiArI2RlZmluZSBSVENSRUZfT0ZGU0VUwqDCoMKgwqDCoMKgwqAgKENM
S19SVENSRUYgLSBDTEtfRU5WTSkNCj4+PiArDQo+Pj4gwqAgc3RydWN0IG1wZnNfY2xvY2tfZGF0
YSB7DQo+Pj4gwqDCoMKgwqDCoCB2b2lkIF9faW9tZW0gKmJhc2U7DQo+Pj4gwqDCoMKgwqDCoCB2
b2lkIF9faW9tZW0gKm1zc3BsbF9iYXNlOw0KPj4+IEBAIC0zODEsNyArMzgzLDggQEAgc3RhdGlj
IHN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayBtcGZzX3BlcmlwaF9jbGtzW10gPSB7DQo+Pj4g
wqDCoMKgwqDCoCBDTEtfUEVSSVBIKENMS19NQUMwLCAiY2xrX3BlcmlwaF9tYWMwIiwgUEFSRU5U
X0NMSyhBSEIpLCAxLCAwKSwNCj4+PiDCoMKgwqDCoMKgIENMS19QRVJJUEgoQ0xLX01BQzEsICJj
bGtfcGVyaXBoX21hYzEiLCBQQVJFTlRfQ0xLKEFIQiksIDIsIDApLA0KPj4+IMKgwqDCoMKgwqAg
Q0xLX1BFUklQSChDTEtfTU1DLCAiY2xrX3BlcmlwaF9tbWMiLCBQQVJFTlRfQ0xLKEFIQiksIDMs
IDApLA0KPj4+IC3CoMKgwqAgQ0xLX1BFUklQSChDTEtfVElNRVIsICJjbGtfcGVyaXBoX3RpbWVy
IiwgUEFSRU5UX0NMSyhSVENSRUYpLCA0LCAwKSwNCj4+PiArwqDCoMKgIENMS19QRVJJUEgoQ0xL
X1RJTUVSLCAiY2xrX3BlcmlwaF90aW1lciIsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICZt
cGZzX2NmZ19jbGtzW0NMS19SVENSRUYgLSBSVENSRUZfT0ZGU0VUXS5odywgNCwgMCksDQo+Pg0K
Pj4gQSBwZXJzb25hbCB0YXN0ZTogYXMgY2xrIElEcyBhbmQgY2xrIGluZGV4ZXMgaW4gbXBmc19j
ZmdfY2xrc1tdIGFycmF5IGFyZQ0KPj4gZGlmZmVyZW50IHRoaW5nIChJRCBmb3IgY2xrX3Blcmlw
aF90aW1lciBpcyBhbHJlYWR5IGRpZmZlcmVudCkgYW5kIHRoZQ0KPj4gQ0xLX1JUQ1JFRiAtIFJU
Q1JFRl9PRkZTRVQgaGVyZSBpcyBpbiB0aGUgZW5kIENMS19FTlZNID0gMyBtYXliZSBlYXNpZXIg
dG8NCj4+IGZvbGxvdyB0aGUgY29kZSB3b3VsZCBiZSB0byBhZGQgbmV3IG1hY3JvcyBsaWtlOg0K
Pj4NCj4+ICNkZWZpbmUgQ0xLX0NQVV9PRkYgMA0KPj4gI2RlZmluZSBDTEtfQVhJX09GRiAxDQo+
PiAjZGVmaW5lIENMS19BSEJfT0ZGIDINCj4+ICNkZWZpbmUgQ0xLX1JUQ1JFRl9PRkYgMw0KPj4N
Cj4+IGFuZCBjaGFuZ2UgdGhlIENMS19QQVJFTlQoKSBtYWNybyBzb21ldGhpbmcgYXMgZm9sbG93
czoNCj4+DQo+PiAjZGVmaW5lIFBBUkVOVF9DTEsoUEFSRU5UKSAoJm1wZnNfY2ZnX2Nsa3NbQ0xL
XyMjUEFSRU5UIyNfT0ZGXS5odykNCj4gDQo+IFN1cmUsIGJ1dCB0aGF0IGlzIG91dC1vZi1zY29w
ZSBmb3IgdGhpcyBmaXggd2hpY2ggbmVlZHMgYmFja3BvcnRpbmcuDQoNCkkgdGhpbmsgSSBtaXMt
aW50ZXJwcmV0ZWQgeW91ciBzdWdnZXN0aW9uLiBHb25uYSBnaXZlIGl0IGEgZ28gJiB1bmxlc3MN
CmNsYW5nIHNjcmVhbXMgYW5kIHllbGxzIGF0IG1lIEkgdGhpbmsgSSBsaWtlIGl0IG1vcmUgdGhh
biByZWx5aW5nIG9uDQp0aGUgcmVsYXRpb25zaGlwcyBiZXR3ZWVuIHRoZSBiaW5kaW5nIG51bWJl
cnMuDQoNClRoYW5rcywNCkNvbm9yLg0KDQoNCg==
