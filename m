Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966005BDED6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiITHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiITHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:51:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B7DFF8;
        Tue, 20 Sep 2022 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663660280; x=1695196280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g773xQPj3XwdCCCny/fpYEhGkcmc9ggETKsDjd6iIc0=;
  b=QBZjKqZuP1t16G1FZWfGeHU8ein7voGkH+zDAkoeg1s6Vi5fwCrLMqcH
   tSGK2j5x92uTbDxJEIob9AMqCL/RxtQ+c0P8qfpY1KrBkPRUQYh6NGIDL
   UnbQAfcl3DDCHRKnFaCmwIyR3h7Nc6HyuAhWyy0QJhE0V6Nd5jI83ED4t
   Jy73cjR+lc6ayp9Nl9QWKh7LmVET6da5z3fryw/CSuQS0Svuq8pJRSRe2
   Guor0bFJ+nUth6SKVEL1OJZq6znmkKOJRUxlldOuzoDbHKkcapHfH2GtK
   XZKuRIBIWzigVvz2/ZDcnj+LGxnjeHI5Lo6tYa7IdIhxx4vXpuVgo3R9s
   w==;
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="181206604"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2022 00:51:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 00:51:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 20 Sep 2022 00:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMswo2MuIhI04oQjepuukxrH84z6+9DP0h/+F5FaSR7LsAYHHt9LXtulYc0Y0qQr+PCG22PWUW5L920ScdDVj+k2Vtg6EU6sxTUJsppAC0sschwYnhuwbBPlfZjj0XeFJ0q3pKuc4unT5k1+TVqKCB61X93MLMd79a9gpkq0s2ZaIN/+j4swscDGBzad1ohYPyZc30B+aaGeXFAeeAlz2Stf9Cc9oWKlVe6NsfTf0AKRAU+2OYvciDlviH53Ol5QN2h0pFfG3ysuvC24iU/Y0eMuZUASHEezeib8/t1PDBWFvEU9fZTKuVaUcvwrd8TscfQEdm+yHBbNJ9LLDq01HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g773xQPj3XwdCCCny/fpYEhGkcmc9ggETKsDjd6iIc0=;
 b=dccz6LJtU/GropDct23UpX89G8RNbx5p4N0lewjFxylTCV2rXYLb2Iow4rHdn5hC0/uzmm6st0M8OSHqa3EpPZraPuLBBROrGgQ7QQ1uu4emp/pBW2NrMctLpQx5KhLgDhdzKUdINqN2whEZQb43p5HC2E3v+B2Uf2gQgG+AkF9kB2zgokzOaF3HxMxOvRfDLoLfxcxSMEuBrz3b89miaSLaPDtWc0ydEzYskmubh1w5WAGUZxHvzh9jDFzUvZBy3nIMgvDu7K6hM1obX2H9jBJ9gRLPfvbfNBBApvj/M1rwpBpM7HLWJjbj/jDOHqEGrE64PkkxtuztmA8T0W3ZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g773xQPj3XwdCCCny/fpYEhGkcmc9ggETKsDjd6iIc0=;
 b=Ko1h6bN2mu6XpfLhDlK54tOT1bsgxwwLRo4LxgTjwR46gvilSFe+uFe2b2V2RSnJUaZx+3ywKCjgPYIs64Z/tjE6uSzttZslEf8EwM1e6gXTnk31rmMtJCgsF23qUCzfTWOddKN2m6xgGPFEsm6m6STyNWVZnXSc2tL/0lolMYM=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 07:51:13 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 07:51:13 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <richard.genoud@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jirislaby@kernel.org>, <devicetree@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <lee@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <radu_nicolae.pirea@upb.ro>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 2/9] dt-bindings: serial: atmel,at91-usart: convert to
 json-schema
Thread-Topic: [PATCH v4 2/9] dt-bindings: serial: atmel,at91-usart: convert to
 json-schema
Thread-Index: AQHYzDqRiKemezkRUk6561ZpPVjdFa3m/FcAgAD2twA=
Date:   Tue, 20 Sep 2022 07:51:13 +0000
Message-ID: <d05e20a6-6c4b-4e72-1abf-8ea5c7dfdaf6@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
 <20220919150846.1148783-3-sergiu.moga@microchip.com>
 <20220919170812.l2sj7vyjks62ej44@krzk-bin>
In-Reply-To: <20220919170812.l2sj7vyjks62ej44@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 5ffa34af-7405-4998-4ad4-08da9adce42a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrP3Bv3UfUMNJvTxk0P0jfJUSZR+SyBl1tL0la7a6r9P6nMN7Ow+9Cxj8cVWafvdaqikss3hBSVLg0YmGpD7aOAtBiFSew5IOcdrI1duUm/Tw70rGPBWwYPkO0GekhoC58kIDDFJP58QtqDyseVhWMGiGDOpfRWrcHpHl3lwSPj2eJWgzBKWLhIfWvBiXH1IB8LXsfYRsmRm7PzQvsrFzR5y7FZT1mGVRU9ijVsIGKbKTa7UDcGh6E9gJN9BivgDeKhhNxJlaEeeP6pxzbC0TE8dt4jzOLJzieMtTnVWiATNInku0Ui2JuTza4imQGzaVaQ5ableOe6u/GNKfqnRNTGNhsuT7cKatHjX4mCfBNQZeU2/DO/dzqrt3VpYkwdCb/LYJ088u+rsbZvn5WvBHCnXb6O1By95lf1vBdeyC/ECxn1uYfpdcZf0wrN95ZQ25JqJDJyNnApD3p3Yv0PeTXmbaOlxX2jAiY9k/eDMVAZyzs1JLfCiMpkJWdXIeN7xe3GQNddUhMTUT31q5FHqNqKSeCIi2toHt5JAwKDbuDaxyOV5m+OFL474KBPUgamNwSITubagm+F4rEVtDjR6Te8fZXvkEbXcFr1XSCpF7gWPUBDKJ3z3kFVFiYoaK4SG79sKrCCUt5142h9J/jdL75PvulhNwRo9SZI4RQnw8nO4sU3ELCdYEiMo8v9GlZmnEMy16aLux8KiafjZy7U3Q3C9Or6TYzo224D8AxbLvBsQuV1uPuSXLBRDcILlermjr1WRdOLU0rWXC9FVceslZu/q9CGhDwkkE8ybkYyDEvoRZarW5q0sXUzHwGMlIrbClrzWdoHkblKwZ8k/nURIbAXEESWNf1OX70GzvRQ4eqSbL35iZquYGmas+Ut+TxDP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(186003)(31686004)(38100700002)(5660300002)(26005)(8936002)(53546011)(6512007)(76116006)(66946007)(91956017)(66556008)(66446008)(64756008)(8676002)(4326008)(41300700001)(66476007)(31696002)(86362001)(122000001)(38070700005)(36756003)(2616005)(7416002)(2906002)(71200400001)(966005)(6486002)(6506007)(478600001)(54906003)(316002)(83380400001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWU2SWJnNWhHZjAzMS9IVWUvZ3VmMVhBK3FhVEtVZklhWjNuSlhtNDhWZDl4?=
 =?utf-8?B?RjFreDJaRXl1T0VGaldRRnduQlJiVGZ4WHFoQStnektTRjBzV2duTDhBZlgx?=
 =?utf-8?B?TXF6SWNvejJDVDFJUTZuNUt1K0p5cGVibHBJVWxmUnppc1hnNkxvRVo0eklW?=
 =?utf-8?B?OU0rVVhyR2RWRTM3YlB2ZVB0RVhUZDh3ODdBdjc1OWtNb1RoMUJJUHJoS3A5?=
 =?utf-8?B?U3pxdlVvK2gxcGpTSmtYUXMxeVlsdmEzWkwwZ1pNa2pXb0xpVUVVMndrODds?=
 =?utf-8?B?Uk0wUldxOW96R1lOK050bGhwYmUzTHoyb0hxeGloYnd4UmtEcmZBcDlUK2dU?=
 =?utf-8?B?a3E0MHh4QUxMQTh6bTdUTENNaXphTDdxdnFvbExLL0dsYWo4WXQ1UjQvZFZE?=
 =?utf-8?B?S1BWZXJlaFR0R0s4NGxxckZKTkM2Y3B1SGNUcnJTeEdFRWZVaVVIRDZlZXhQ?=
 =?utf-8?B?byt0Ui9pYUZDaXBhcVhDL1ZRd3hwcWViUUNXRUlqcHJwVXN1VFl4cjhqaWFD?=
 =?utf-8?B?MFNBWTEzSUhacmM0Q2s1T2Zid2RJbndkYU52cnY4OVc2VVNsd2dYWUJId2k5?=
 =?utf-8?B?ejlKUzJTVkJ6TFBFV28xM1pZN0ZtaU1kSVlMY3dTUmNJa1gxRnJiRE4vQ2Yw?=
 =?utf-8?B?K3JPejFTb1BjMlFHSDNETWFBR2ZFSi9CZGlxRzZ1SitTSmhQdjlQYk1NYmFh?=
 =?utf-8?B?MmxhSzNpZzFTWWRFWkxiOHhzaENxdHBmSnRXalQ5bGlOU0tlZmZWZjNpMlAz?=
 =?utf-8?B?ZDFJM3l0UUdjZzBEZndPa1hRdnZUNTljcnJRNE5vemNqSkJySWs5TXdkTTN4?=
 =?utf-8?B?OXJDVFY5UDhCMXpWTHpHM1Q3OGJjMmR6WnlmMndBQ2FXNmpvSWFoM2ptbFlZ?=
 =?utf-8?B?N2Zlc25GejRtaWF4VURoa29jb1Bvd005WkFIT1duYnpya3dpN3hNUE9jbzIz?=
 =?utf-8?B?ZE44WEo5R3dMLzUrT0s1SzBtNkhHNkg5Y0ZtakFJSUhkdWl1UDFhbXV4V01k?=
 =?utf-8?B?ZDBuQ25ra2xCR2UzbjdBb0N4VkNEeCtCeUYydE1BcXpXTEhGSlowMXp0eWJZ?=
 =?utf-8?B?dGI4QllUMnVYVzRUQUNyZzJRdmdDT08rZDdKYkE2QXgwd1JTTUxuemswNGRw?=
 =?utf-8?B?a01WMzhyWFE4VWt6MmtRaUMzZ0FaMjBBcXJsV1A4U1k5ZXF4eUg2ckRtSU85?=
 =?utf-8?B?Vll1MjVmR3U2bFpCbVdCMWpzVEoxVlFyc1BST2dkZjE3aWZOVExSN1lzZk9S?=
 =?utf-8?B?T0t4VjZ3WkZuZUt3K1l6MmU4bk1VZG0wVWdLejlXU2xtRStnZmZWRWN5MDZq?=
 =?utf-8?B?YUpES2txQjViOTdUY0NXby9uQXZwaUNUcU1PMzJXOElRN1k2M0JVaXdjVHlJ?=
 =?utf-8?B?NXd6b0R1V3g4QTFqdWFERTYwZDdYR0pjM2dFeENPbkt4ZW9VWUpybU5ucE5X?=
 =?utf-8?B?SkFoNS8xYkI5STZMMVJlUnhJVjdTaW9yeFdPUUEvT3BHalJ4Ni9tTGdsbXpx?=
 =?utf-8?B?bnplK3hWdU1sYnRBR0JURTBlRjVtbTNBZGFLS3Azc1ZSdktxZ0dBL2hENThw?=
 =?utf-8?B?SXFiZk5LWUF4WnBsRXlXcGRodndzSWJiN3dpYWVTYklUa3hINC9la0pzbDkr?=
 =?utf-8?B?SzJjVUVuMEhheVdrcFlvOGI1RWRrWlQ2d1pCa2xtTVlyaTRyZUZSWEp3MGtW?=
 =?utf-8?B?b1p1U1dNc0l1a3IraDhWbkZCdlNacDhLQ3pHZk9tcDQ1V2hGT0tOVmRjb2lK?=
 =?utf-8?B?b3BpUHVESDNORXllZGdtK3hCS01lOXU5S0U1M2ViSkR3d3JtU3RUbVNKVXZ0?=
 =?utf-8?B?VVRjeG0wa05xc0VWQ1FZam1peGtCUG5zN2pCUm5iUE9LWUR4cU1COTcybWVU?=
 =?utf-8?B?a3VqRHZoeC9JRU0vaTBWdEtUTE9tMXVUeXIrdEU5RGR2eWcwWTFhWjV5WXh2?=
 =?utf-8?B?U0U4WHpHMHlBWm1CL3FvMXIyV1VNc1I0NzBHdU9CSlFhY0trZ0N1V3pOcnht?=
 =?utf-8?B?MXVONDFsNFB3U25jbWE4bzRRVk04d1doUE5maXpwV0VkLzhWd3A4R0t3cGFn?=
 =?utf-8?B?QmFzcUpLYUQ4a2xUcUpCY1NaWEg3SzI0ajBFUUZ3YWl0bTBVdkU5ckZJRXlB?=
 =?utf-8?Q?P3WWEuZNfaIw3xHAO+vh+vdQS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A0B0FBAEC58234DB4055F417348E21E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa34af-7405-4998-4ad4-08da9adce42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 07:51:13.7181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvvFHsBrYuEF/35ZqmQO0Us3XxJ0DZNeB4ZOsuBfkqPW85jnS3DA7Rr3OpqdcUxCmfeCs3wfcJz8V7JZQHdae13KHb4LrVij1Qsi68nj7+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDkuMjAyMiAyMDowOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gTW9u
LCAxOSBTZXAgMjAyMiAxODowODo0MCArMDMwMCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252
ZXJ0IGF0OTEgVVNBUlQgRFQgQmluZGluZyBmb3IgQXRtZWwvTWljcm9jaGlwIFNvQ3MgdG8NCj4+
IGpzb24tc2NoZW1hIGZvcm1hdC4gRnVydGhlcm1vcmUsIG1vdmUgdGhpcyBiaW5kaW5nIHRvIHRo
ZQ0KPj4gc2VyaWFsIGRpcmVjdG9yeSwgc2luY2UgYmluZGluZyBkaXJlY3RvcmllcyBtYXRjaCBo
YXJkd2FyZSwNCj4+IHVubGlrZSB0aGUgZHJpdmVyIHN1YnN5c3RlbXMgd2hpY2ggbWF0Y2ggTGlu
dXggY29udmVudGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1
Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+DQo+Pg0KPj4gdjEg
LT4gdjI6DQo+PiAtIG9ubHkgZG8gd2hhdCB0aGUgY29tbWl0IHNheXMsIHNwbGl0IHRoZSBhZGRp
dGlvbiBvZiBvdGhlciBjb21wYXRpYmxlcyBhbmQNCj4+IHByb3BlcnRpZXMgaW4gb3RoZXIgcGF0
Y2hlcw0KPj4gLSByZW1vdmUgdW5uZWNlc3NhcnkgInwiJ3MNCj4+IC0gbWVudGlvbiBoZWFkZXIg
aW4gYGF0bWVsLHVzYXJ0LW1vZGVgJ3MgZGVzY3JpcHRpb24NCj4+IC0gcGxhY2UgYGlmOmAgdW5k
ZXIgYGFsbE9mOmANCj4+IC0gcmVzcGVjdCBvcmRlciBvZiBzcGkwJ3MgRFQgcHJvcGVydGllczog
Y29tcGF0aWJsZSwgdGhlbiByZWcgdGhlbiB0aGUgcmVzZXQgb2YgcHJvcGVydGllcw0KPj4NCj4+
IHYyIC0+IHYzOg0KPj4gLSBQcmV2aW91c2x5IFtQQVRDSCA1XQ0KPj4gLSBDaGVjayB2YWx1ZSBv
ZiBgYXRtZWwsdXNhcnQtbW9kZWAgaW5zdGVhZCBvZiB0aGUgbm9kZSByZWdleA0KPj4gLSBEZWZp
bmUgYWxsIHByb3BlcnRpZXMgdG9wIGxldmVsIGFuZCBkaXNhbGxvdyB0aGVtIGV4cGxpY2l0bHkg
Zm9yIG90aGVyIHR5cGUsDQo+PiBzaW5jZSBhZGRpdGlvbmFsUHJvcGVydGllczpmYWxzZSBjb25m
bGljdHMgd2l0aCByZWZlcmVuY2luZyBvdGhlciBzY2hlbWFzDQo+PiAtIFJlbW92ZSB1c2VsZXNz
IGVsc2UgaWY6IGFmdGVyIGVsc2U6DQo+Pg0KPj4NCj4+IHYzIC0+IHY0Og0KPj4gLSBhZGQgUi1i
IHRhZywgdGhpcyB3YXMgcHJldmlvdXNseSBbUEFUQ0ggNl0NCj4+DQo+Pg0KPj4NCj4+DQo+PiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC11c2FydC50eHQgICB8ICA5OCAtLS0t
LS0tLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sICAg
ICB8IDE4MiArKysrKysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxODIgaW5z
ZXJ0aW9ucygrKSwgOTggZGVsZXRpb25zKC0pDQo+PiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLXVzYXJ0LnR4dA0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nlcmlh
bC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+DQo+IA0KPiBSdW5uaW5nICdtYWtlIGR0YnNfY2hl
Y2snIHdpdGggdGhlIHNjaGVtYSBpbiB0aGlzIHBhdGNoIGdpdmVzIHRoZQ0KPiBmb2xsb3dpbmcg
d2FybmluZ3MuIENvbnNpZGVyIGlmIHRoZXkgYXJlIGV4cGVjdGVkIG9yIHRoZSBzY2hlbWEgaXMN
Cj4gaW5jb3JyZWN0LiBUaGVzZSBtYXkgbm90IGJlIG5ldyB3YXJuaW5ncy4NCj4gDQo+IE5vdGUg
dGhhdCBpdCBpcyBub3QgeWV0IGEgcmVxdWlyZW1lbnQgdG8gaGF2ZSAwIHdhcm5pbmdzIGZvciBk
dGJzX2NoZWNrLg0KPiBUaGlzIHdpbGwgY2hhbmdlIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBGdWxs
IGxvZyBpcyBhdmFpbGFibGUgaGVyZTogaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRj
aC8NCj4gDQo+IA0KDQpIZWxsbywgdGhhbmsgeW91IGZvciBjaGVja2luZyA6KS4gVGhlIGFib3Zl
IGxpbmsgaXNzdWVzIGEgNDA0LiANCkV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGZpbmUgdGhvdWdoIG9u
Y2UgYWxsIG9mIHRoZSBiZWxvdyBhcmUgbWVyZ2VkOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYXJtLWtlcm5lbC81M2U3MmU1ZC00N2ZjLTQwM2QtYzk2OS02MWIyNjdhOWZmMTVAbWlj
cm9jaGlwLmNvbS8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMWFl
ODk4NTQtNzRmYS02MTk0LTMwNGYtZGIzMWQ1NmQzNjc0QG1pY3JvY2hpcC5jb20vDQoNCnRvZ2V0
aGVyIHdpdGggdGhlIHBhdGNoIHNlcmllcyB0aGF0IEkgbGlua2VkIGludG8gdGhlIGNvdmVyIGxl
dHRlciBhcyBhIA0KZGVwZW5kZW5jZToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YXJtLWtlcm5lbC8yMDIyMDkxNjA3NTc0NC4xODc5NDI4LTEta2F2eWFzcmVlLmtvdGFnaXJpQG1p
Y3JvY2hpcC5jb20vDQoNCg0KVGhhbmsgeW91LA0KCVNlcmdpdQ0K
