Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CA5BA23E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIOVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:13:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5257B79A;
        Thu, 15 Sep 2022 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663276405; x=1694812405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p8uUSaKkZQtyTfZW12hqOFY2v4Nwm09OmOLh9kL71n8=;
  b=0O0gUgl8XXhlKDAj34to8F9HIHfQaEUe+oTEDU+nW88Vp+WDTqZhzsav
   AZWPAcD0mgjVPZVjIJfAbCLhs06KnNVuhAu/3jQX0KPqgYHAaHcEXMQ+d
   o/NYzERVU/eTDEf142wDStqDyJBSXi4plKJ5SI3ANGD5vWabxXcMGDL3L
   HYjs1g4CBcibnIg12BBDhWJIuHrNeCqm+oKkTmgEZ80y6Qd6tzlqjXILy
   EZYeRa8+b28gJMeSIGK3PuhbuphFb3yi1akyU9B0G11nZCwp17iBRj8+u
   pGm9PTWBk5C2DwtUg+dVkRJZVxs8r04g/vEn7yyxZKRVCR/8QeJR+MCbG
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="180603788"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 14:13:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 14:13:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 14:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmKCh9NXEMPeUWO2MJ/dcYLMFqZWbuvXWRFs4/iC/pY6W8u4vJa+SFEJHQu3NE/vQL8cXHyTcMpsKPotvb1K7DEw8WpQ0QVqQ/bQyz+Ff9aknSSuASLQ/eyYLbQNLXtyMwOZJWSDFBIW3jYFFn/xZBPBiXwB324UiObzJCP1qFrSRRmg7gAF1urxOmq6jF9vD1CrzIyV7e+2jIwUxR8hdgY2qRu3Bj5p5GqC7Bybxc0K8QWgEv097fOB4zpZydW9ng2s+58gVYZqT40hroRKv+srjAbdWMqdCrxxpxUElRP/D4DHRCKiu3IxrEu6ujeTgeNsFzDuL/qRCXhy+hffgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8uUSaKkZQtyTfZW12hqOFY2v4Nwm09OmOLh9kL71n8=;
 b=VpkqxY01OOK3Or2Qw5eWF698GRuZnt3sRHBiKSloJF50JVcidGoPI9AShPSOVTPlc7TOTswNaW13kU8D0MQhuH6JXdWJm4N8rBiF9vHPOkDgecdp1SzEZJMsTPs93LAiPDDwoaLDplfeboohDO7JHm+hiFagjPIOcuKRq9sPXRbYfDCTzKznbU+llX2jHjQY3JLkrvyFL37nq6b4hLgY230Qs1WGEcBLSKh067X6mvI0t0Aneua6jy6W+xPe4Mtp73k486lJeSdGaPTPjicuWZly/8xIDfrV1MiwEwmrxrPavhMMm4Lw/SqhjTsns94nqeV5EybEHczZgAMTBlLE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8uUSaKkZQtyTfZW12hqOFY2v4Nwm09OmOLh9kL71n8=;
 b=KMvyQS/O65YFP+dXfZu1oVIBBFguKgHSyr+y9KX5L3ztsMznmFFjss/vO5863IRvp2tempuMnGkeQJCKHbNMjsghEbJdzglQ2qji2pfE/CSQE0vM8NDPgjRk1YN4g0VJfZKr9JVcx3j5+hR3UwXDkz/pT2h9c0Vmq9kMtIGZEjs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 21:13:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 21:13:10 +0000
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
Subject: Re: [PATCH v3 01/10] dt-bindings: soc: renesas: Move renesas.yaml
 from arm to soc
Thread-Topic: [PATCH v3 01/10] dt-bindings: soc: renesas: Move renesas.yaml
 from arm to soc
Thread-Index: AQHYyS90Mq9ZsRyXKkGcPo9UEDEP+a3g/YqA
Date:   Thu, 15 Sep 2022 21:13:10 +0000
Message-ID: <10896a74-5875-a083-846f-eed5f457ba1b@microchip.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915181558.354737-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|MW3PR11MB4554:EE_
x-ms-office365-filtering-correlation-id: 56349e30-c1be-4c76-a689-08da975f17c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvKf97Jgq6oc6KACaQ7yQ3Nwp7wzUN3/LWwlyBpC7gPyWkSMH5B2EfmXD+qsNcPqXPPITcBWJaO6a1vvqZvgZ+7jO6tlR5j32N+QX5ppWA5PKP5RbLpZwMG37d7E3MKclZ+FrV63h2X8vbQuJ7wLbmIPl+zkornvzq6F/pideA4xYaIscG8AwAMc7UNtIqQ/kcOVjy4bjqX3gZasKMCzLDfhGik2s2/szhVRvonG4yHm5yYTe8yYalBPr10kg2s1VcHK+3eQenhyI79k3tjgvilE+0yNQFOveSAPHfeKGLKbmncfq7M3tYIkMjlL8i/JvCXlge2Q3hkCcITQ0Y/s3jfgPsiJODCcxbXUC3nOL8zi02MZiSJ5mZYOInMJInJM/BP7YPYJgVLSb7DW5TfvBZ44SdAfbe0383MFw2S/qmkXBfdz7vsTWdMKxkdrIb0RJhZ2ePF40DA07IFpE1Pzm+fQBt3XYZBNToH+f+pLQ5W6egQs7ujKoHubagL6FhDV90vPqpRNU4chnrWFOBme08GJkxI+/3pa9lEPOQtqwXZoA8Z+h8GAePc0g3in5ToO8avVqk6qwmWO4GvMlbuj2hbleGFDVtm1RdbV0CkF6FKPp9eN//1St3p2lUOwr7iTIrmCPvb+Z+4IFGhGPvIiJxusRWyBms+5nHmuGwLmvjba6hOm5TnfvPctyyGxDXxWMbJP5eHH4mtSVDyvSc8pnENMXysANV6oi9wPbueIyGbj09yhce9Yomc9zSDnWftZb3GBKEyv/nwouTlhxztodmDo+TOJo5d4jmzbcHFTS53ZRzJAPX8cFvpV3g8Tg8bWBmPdzHgRI4aN3Vk08exZmgVkh6O7hRNQCB+gS6Q/85BkJ9UzQFPxV1bIKHUjR/vpWJdhDF1758FauvweFZYaPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(86362001)(41300700001)(5660300002)(8676002)(2616005)(7416002)(38070700005)(66946007)(76116006)(4326008)(8936002)(91956017)(66476007)(26005)(66556008)(66446008)(83380400001)(316002)(110136005)(54906003)(31696002)(6512007)(36756003)(186003)(64756008)(2906002)(6506007)(53546011)(6486002)(122000001)(38100700002)(966005)(478600001)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2cvcHlyc2ZTVlZiN2ptbWVDTkZtV2lXbHBXUzVuVWIwOStXTk9ZQlkwUXRk?=
 =?utf-8?B?U01pTXNHU0dhL1lvMU5BYWpQVENFckdMY2Z0eDFFOGhSV2JnY1JyUnlzY3li?=
 =?utf-8?B?L29uVjRHYjloakpmQjNRaHh4THVHcTB6bWUvVzM5V0FIY1ZqRHFsbU4rbFpu?=
 =?utf-8?B?bXJLYThwby9KbUVIMGJIbDhSRElSQjFWVjE0NWxzbG1COTJNS21wODZxaUkx?=
 =?utf-8?B?a0ZPV29ZYmtvazZabTVRNFBnQUV1c09oYzg0WGE5ZGpCY0U1QlJWREdMaDBi?=
 =?utf-8?B?SFNXck42Q28yYWxNamljZVFNNXhrUE02dE5oYlBiY1hJcnBHWStRNHlEdzZ2?=
 =?utf-8?B?NVJkN1BIMytwUVQxc1UrOHFXeUJJdWdLa29qbDVabDR5S1IvQW16bnpxbm9N?=
 =?utf-8?B?NHQrNzRnRjdTNGNYVndDS2Foa1FJZlI4WGdqdnZiSFlWOXVpckRaU1ZSQlZL?=
 =?utf-8?B?dHdGdWhKcXI0U0Jsc1hwandWNXdSa1FHNEh1VU1tZFMraCtJbXZSK0tRQ0R6?=
 =?utf-8?B?Zk50bTZ5bStCeUJLOXBiVkpHczRiejZFdE5UOWlXOVVzVzdSbitOcTdnWEd2?=
 =?utf-8?B?Y3Q4YU1kbDB6M2w5QUZSS01KM1FEc2NPaFZlUm1wdzgxSDVsTkdOTEZPdGtQ?=
 =?utf-8?B?VTMyekpCTGlkS1lEcWZoUHFDZkVnMHJHTFBiYy9sQm9GcFUyeHA4TGVMMENJ?=
 =?utf-8?B?V3ljdFdvMm5uYlhScmIvWnk1cWRPZE5mcWxaNmdmZEdLMGlJdlVkbmNRSHBx?=
 =?utf-8?B?SUg5Rm91NTBnNkp0SHhhMDVwNU5DbVlJRG1SQWthYVZzTml6ZXROTGJkeDRn?=
 =?utf-8?B?SVk1cGhUTUM0dkdJRmxTcDZqVFFlcHVRQndSQUVOTncrczFQblkvR3U4Qm5J?=
 =?utf-8?B?bjEyZjdpYm1LSXNNTDBnL1hFUDBPcU1tOFkxQmg2TjNXUDRKeHB6VURteU1y?=
 =?utf-8?B?azdvKzVnZUZiUUx5cVhRWlBrcXlabytKWGo2WXpjL0ovVHhXVldrWXN2M2FH?=
 =?utf-8?B?aXVPNFNmV2xyc1dZaGhOUnFzWmNKa2JReXVDZjBQdDZZbnFCVWVUaXV1aHZU?=
 =?utf-8?B?bTVRNHlNMTVrU0pBNjQwVmFtaWwvUDJTMGFnbWhkYzArRmk4cEVWWFB3YXhU?=
 =?utf-8?B?Y3hWL1FKQ3NiMFVHa3diNGZXejlWT2RoK0xnZmc2TWovdGhJMVlQUmhqeE0y?=
 =?utf-8?B?b2I0ZHpFb0F6ODBaRHozNU1ENHBzZU5tbDNQVXhpYnh3SnBsT3NCd1VGdm9J?=
 =?utf-8?B?dEhOTXEyb3k4TWN1S3RpY2pVbzdLSE5uZzlPK3A1Q3N0TFhDdUYwUVZ0S21t?=
 =?utf-8?B?bmpCOGRhbWsyaUlRSkZrU3FUQ0lLaDR6Z2pUcGVRTVpMZDAxZitoU0hINDFt?=
 =?utf-8?B?bmgrMGFxcDBsbDh5SWpCUFplOEhvNTBOUENKSW1oWEEyRkJndG5ZbUZNdVE0?=
 =?utf-8?B?eG5pUVFITEJRUFdsczlKbm1zTk9FWHBhUENSMHVGa2dWOTNNRk9MamxzK09o?=
 =?utf-8?B?ZUdVUy9GUU4ydzJVaDU0T0IvOXc1NHN1cVprV2tvV3BRcUxKU08rU2ZlVlY2?=
 =?utf-8?B?ZUd6K0UzY3oyd2ZVVkx4S1lPa0p1TGhSeUlGZlFCMXZlVUdxQUc1RGh2b1Vu?=
 =?utf-8?B?ZHNiSkd6TlZJclpjNUppOGh2ZEJub1ZPaUpBTFIycENoZExxTDR2a3hXbkth?=
 =?utf-8?B?bjB4T01DUjl0L3Y0RzI4NzdlR3dNL2haNlREMExWR080R1p6dFd1VzBFNVRo?=
 =?utf-8?B?dnJvbDBrOVhkckdCL0w4Zk1FM01KVVVJenFvdHhpRUtoaEltSzkzWUZ4RTZn?=
 =?utf-8?B?YStNYVlEK0QrWXRodXpsNEdwKy9rK1NRNVNhQXVSdXRLYjZEWmpNdzE4Q25u?=
 =?utf-8?B?MllLRGlYOW5JMXFCSURaWW5DKzVMNWluTTRWL1lBMWpWZi9tYkxDbTZTMWxq?=
 =?utf-8?B?MWFSWThjTk4yckE0Q2FNZTMzOHUzdmtmNUNoeGVZUVdMRWhqbmRTdEVIQjhx?=
 =?utf-8?B?WGJYWlM4SHJpTVVwUXk1RExYRFAybmxQTHJUQ3dVT3FvbXpTVmd2dklTRDIv?=
 =?utf-8?B?WVZMSkp5bklKKzQyQlYzV0RrWkVGK1Ywa3E0UXA3OXRpUS8yYnhZU0tMODUy?=
 =?utf-8?B?MnNGdDlKNG5JYU1CNUxDZTNYaElvL3M4OTF3VkdUbGp0OXBPaUluNEJWY2w3?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F701E42FA75F4BB22490856066D2AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56349e30-c1be-4c76-a689-08da975f17c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 21:13:10.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozBHBKoSH/YixVdzyp2pJEy8nB3ileQ00ZDcA6+kWV07Z12JD1XRIJruTcb256f7kZrS7HsCP6C6XuZNwOvOQyEXb/Nv0UWktDitx5GGs1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
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
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IHJlbmVzYXMueWFtbCBsaXN0cyBv
dXQgYWxsIHRoZSBSZW5lc2FzIFNvQydzIGFuZCB0aGUgcGxhdGZvcm1zL0VWSydzIHdoaWNoDQo+
IGlzIGVpdGhlciBBUk0zMi9BUk02NC4gSXQgd291bGQgcmF0aGVyIG1ha2Ugc2Vuc2UgaWYgd2Ug
bW92ZSByZW5lc2FzLnlhbWwNCj4gdG8gdGhlIHNvYy9yZW5lc2FzIGZvbGRlciBpbnN0ZWFkLiBU
aGlzIGlzIGluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcgYSBuZXcNCj4gU29DIChSWi9GaXZlKSBm
cm9tIFJlbmVzYXMgd2hpY2ggaXMgYmFzZWQgb24gUklTQy1WLg0KPiANCj4gV2hpbGUgYXQgaXQg
ZHJvcCB0aGUgb2xkIGVudHJ5IGZvciByZW5lc2FzLnlhbWwgZnJvbSBNQUlOVEFJTkVSUyBmaWxl
IGFuZA0KPiB0aGVyZSBpcyBubyBuZWVkIHRvIHVwZGF0ZSB0aGUgbmV3IGZpbGUgcGF0aCBvZiBy
ZW5lc2FzLnlhbWwgYXMgd2UgYWxyZWFkeQ0KPiBoYXZlIGFuIGVudHJ5IGZvciBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL3JlbmVzYXMvIGZvbGRlci4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5l
c2FzLmNvbT4NCj4gLS0tDQo+IHYzOg0KPiAqIE5ldyBwYXRjaCBhbG9uZyB3aXRoIHRoaXMgc2Vy
aWVzIHByZXZpb3VzbHkgcG9zdGVkIGFzIGEgc3RhbmRhbG9uZQ0KPiBwYXRjaCBbMF0uDQo+IA0K
PiBbMF0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJlbmVzYXMt
c29jL3BhdGNoLzIwMjIwODE1MTExNzA4LjIyMzAyLTEtcHJhYmhha2FyLm1haGFkZXYtbGFkLnJq
QGJwLnJlbmVzYXMuY29tLw0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3thcm0g
PT4gc29jL3JlbmVzYXN9L3JlbmVzYXMueWFtbCAgICAgICAgfCAwDQo+ICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMSAt
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gIHJlbmFtZSBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mve2FybSA9PiBzb2MvcmVuZXNhc30vcmVuZXNhcy55YW1s
ICgxMDAlKQ0KDQpHb3Qgb25lIGVycm9yIGZyb20gdGhlIHJlbmFtZToNCi9zdHVmZi9saW51eC9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL3JlbmVzYXMvcmVuZXNhcy55YW1s
OiAkaWQ6IHJlbGF0aXZlIHBhdGgvZmlsZW5hbWUgZG9lc24ndCBtYXRjaCBhY3R1YWwgcGF0aCBv
ciBmaWxlbmFtZQ0KICAgICAgICBleHBlY3RlZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvc29jL3JlbmVzYXMvcmVuZXNhcy55YW1sIw0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZW5lc2FzLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL3JlbmVzYXMvcmVuZXNhcy55YW1sDQo+IHNpbWls
YXJpdHkgaW5kZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL3JlbmVzYXMueWFtbA0KPiByZW5hbWUgdG8gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvYy9yZW5lc2FzL3JlbmVzYXMueWFtbA0KPiBkaWZmIC0tZ2l0IGEv
TUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBjMjZhNWM1NzNhNWQuLmY1ZjE3YzUw
ZGFjMyAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4g
QEAgLTI2NzMsNyArMjY3Myw2IEBAIFM6ICAgICAgICBTdXBwb3J0ZWQNCj4gIFE6ICAgICBodHRw
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yZW5lc2FzLXNvYy9saXN0Lw0K
PiAgQzogICAgIGlyYzovL2lyYy5saWJlcmEuY2hhdC9yZW5lc2FzLXNvYw0KPiAgVDogICAgIGdp
dCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ2VlcnQvcmVu
ZXNhcy1kZXZlbC5naXQgbmV4dA0KPiAtRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vcmVuZXNhcy55YW1sDQo+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2h3aW5mby9yZW5lc2FzLHByci55YW1sDQo+ICBGOiAgICAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9yZW5lc2FzLw0KPiAgRjogICAgIGFyY2gvYXJt
L2Jvb3QvZHRzL2VtZXYyKg0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==
