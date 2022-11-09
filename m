Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAAE6231F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiKISA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiKIR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:58:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50951F9D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668016634; x=1699552634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3hFJQHgcK5eLL9MaDP1FO9DBADXRzbnrbBwH+0Seju0=;
  b=mmTEFeImoPe8uD6q9GInnvVRpzSRTyM5hZJwS8ETWLADSIFqbKon27Yg
   VcRhWR9xeM+uqs14ymOJhI1k/Evo8eiZnTTVM+LE2wufl29JHHoGH1Is4
   my7raoseX2UEoMTOp1V16VKieKcfJUuO8x84+tcf6oWDCgDVP8YUE7IXU
   WbO2W3R64Cv9fmnML4+2Yvexwo7ZOhG3zK5vo0/ispjRTDQwCt2faDI46
   RHdafZN1Jtj4oJ33AdGlfFiTux3V0BPqeQVwmt+hx1l7pEpSCxFmauSbo
   J722yLiDqdQHGGR+a7F8Xnc3g+EOEzzF0Djc304TrpkpbrGMzVBxqDt+8
   g==;
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="199106805"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Nov 2022 10:57:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 9 Nov 2022 10:57:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 9 Nov 2022 10:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWegNryI4dwIy8Meh89i4ePkbgEUJaIGu8fB5Z7vFbcHxQe33tjKb+MUhUqcgimDlzc5ayqcYznmRHAjT3fZeZRPMq15hi+UxQu+3mSVxp3X62QBoPScbQJD5UJCIn+DTGGYNQx9f0323NZBmERXnX9OIOfOSQAHNFVOfK6D371SsQCb9FG31OzEJ59hbTbn1M89686qtku5d4FgrJ1Xl/EZAnKexMIAMTkErHwgbnh+xeiD6T0E03JQbXDA5sZz1+MLJcQZ2BZV6GcwDdhEn5N0qvPTh1P6eLdNMdBAM9qB1aAb28wLCWi9WONMXiE6uNXtB9lCAtcoUfUvzvbCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hFJQHgcK5eLL9MaDP1FO9DBADXRzbnrbBwH+0Seju0=;
 b=cfmbYz7d+z/xM9YxNJdWjTws0AJ7u/Xs6XJb3O1zWVrmBh0Jd02/fl+AcMUKh4bu2HkoksfPjYbevsAwZwuPtuBDwDFggyXbdzl7sRVCoO5vdyLkLyqu68iy9/Hg6vTO7H4t1BigT5phBUJ8iCa0/BxX4/MNGdxkLTYhaGesxAwmPfSvlfU7qNa4hyW3QYJadx1d7DAFHxt2YiV1Lhf0Isb+OHfTPnqSLgJyMVSaHcEyjYIQS/w39MWb1kXCpOuFndgk5bZrzr0TQBE3f2jtAYyl3cPilSTscg0ORBrEw73i13JowANeH2dwFy5IdEv7UQEN/6IGksktzPUhqjXQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hFJQHgcK5eLL9MaDP1FO9DBADXRzbnrbBwH+0Seju0=;
 b=j8eVX0qFvgsT+JDEzYaEPMCet3rE0a4X2TFokleX05jhM8I8gqWNAnI5Kqkh/+kykS0nreLTwhONbO3xAy09vrznBLzYmHeZXu5hVjDfXNI1Q9Np76jsUELvOtfcySS7oFnOMKAay3U/zHyYsk8vrj7BFAOlNhac1azx8W7EwtA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 17:57:08 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3baf:7e8:c8c6:c070]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3baf:7e8:c8c6:c070%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 17:57:08 +0000
From:   <Conor.Dooley@microchip.com>
To:     <damien.lemoal@opensource.wdc.com>
CC:     <cl@linux.com>, <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <penberg@kernel.org>, <42.hyeyoo@gmail.com>, <willy@infradead.org>,
        <roman.gushchin@linux.dev>, <pasha.tatashin@soleen.com>,
        <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
        <vbabka@suse.cz>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <rkovhaev@gmail.com>,
        <akpm@linux-foundation.org>
Subject: Re: Deprecating and removing SLOB
Thread-Topic: Deprecating and removing SLOB
Thread-Index: AQHY84ruZ51nVwfy80WRzF/lbTQNOq41j34AgAFSyYA=
Date:   Wed, 9 Nov 2022 17:57:08 +0000
Message-ID: <efa623fb-686f-072e-df0d-9f5727ae1b1f@microchip.com>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
In-Reply-To: <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DS0PR11MB7286:EE_
x-ms-office365-filtering-correlation-id: 702ff326-a81e-4e3f-2bcd-08dac27bd1d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hV3KXCFDErpODy56SvQTcpcEVU9tgQzSkCCs9eJeAZK6SeFjw5l9BU0KJ4IIWN+ZuudPzFwD6+t5ILbdqGBPn+7cwnNXL9YOIsKUCIfUTEJQU3v8OOI7pOwVbDEDE3GJ7cBdmz1cxVU7MwGMjTu4If+9jhl1HxUmh8ePz9Zi3nkIUjPnGcXMc08FBMg8U5LJ3IqwwuaYd5/OkAqYCbhYxFp8tai4GL2QL/ox6STlHQtZ8xxEyuZbVhLX9qdNTEXdewP+7uog6uPwFGjOcarZNnHI+U7OLw6ysPukdcKoB+pGT/Xurr+6WtdsUmkd7DetBzHHlxDu99+V2sAIK47m2m7LzfNgg5cxAZpJmYRRBL0gneOvGsepNmbW+jdecBLoOz9c//tUdgkaMbKF8vZdot8BTbtLpPguSQJQgIRKoYfu6BjyecFhS7i2ar4ITgGU/4xFWkD0rDtZppEQl7f1veC/J4QPTbUeJDWrXBx7GnS3X8Y58eZcrXf44jyR8fDY+S0U9EqtjcndI9W9oE1ciV5+K4mI4SgjC7tu+7t2stsI7ECEMcDpETvkiiGGoDbgHSRoaaTjCq7K2EBK+x2cC0hRZ7v7QNWAhkf/zOonIzT7ZPiiUrwnuaq4zcnLqo3PC2q2y9Z9Wz5Qfbkoo19ifdpH471tq5yH1pltWPi7S9QZyHCokd9rRbaMLpMQO+lZ6fHrpfnonNNHl1o6a13wj7iLCHHlnhzEK2TfdBT2ruc8n4PkWPO9KA2tEJFX4XjSyoIC/EsZ+4OIyjLxGiC3wyI+JHq16X29JhYuzx/Yrcl2PIQpNkOmdTO5AgEddNdgEzbS1pZCuLYyS9v6OSSA9YSVD5iBXz2E6E+NseDd+Wxjo/2YL2tHAIp0TeLvHxFtu+g+qGneFa/ohqQLXmWgDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(36756003)(31686004)(38070700005)(478600001)(38100700002)(83380400001)(122000001)(86362001)(31696002)(3480700007)(71200400001)(186003)(6512007)(26005)(53546011)(2906002)(6506007)(966005)(91956017)(5660300002)(7416002)(6486002)(316002)(8936002)(66556008)(2616005)(6916009)(66946007)(54906003)(41300700001)(64756008)(66476007)(76116006)(4326008)(66446008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzYzWjZ5YnVQWjlkSkpMQWRGUmdIZHFzSnhPMVhnMS9DaXlBZ0RSUGpVbjJm?=
 =?utf-8?B?V1NhL2pucjk3NXBrRXFIbDZTZ1krZVBMa3hvZlhJdGo4bExraVE2ckhVcU5Q?=
 =?utf-8?B?Ti9JR0NRSE9NVng3TTlHWitCWVM5TWI2My9WTzI5bXlFU1BpQ0oxTm5hUWxO?=
 =?utf-8?B?RnJNalNwQ21hSzZtNDVweUNWYVhxaURNeUJWSjBOdnpKdWNjSnNtdXBTTlMr?=
 =?utf-8?B?c2V5STdNRDZWOU11ZXlERXNMSm9hU0hJOVZuYllwR0FRdE9VUUltY0UxcnZn?=
 =?utf-8?B?b0RGTHdsdjF1M1M1dHZwdjZmWit0aG43RGF1OGxWYTF3d1g2dTNwTU50WWVi?=
 =?utf-8?B?dkFsV0dqL05wWW5XeU1pOU5WZkY2ZWNzMDM3cklrQzF3UnU5S2Y1OTNUSW1n?=
 =?utf-8?B?MkRvNXhQTjdNTjRsR0dQekxsM21EQ2ZZTmdaTlFBNHRwS0NOYUNJQWxjTGFP?=
 =?utf-8?B?YnROVkpYMU9rNncraEtvS3FjN3Rwcnl2TXZPeDRDeEZZRWtFS0RkMi90amdz?=
 =?utf-8?B?b3BQYXFEK2JjVTRMWjY2M0JwOXI0UlF0TW5YNExRVnRlWURkOWgrTkpRWUx1?=
 =?utf-8?B?ZlN0eEFDaFB3bTNvTTdUTDRtZFNCSUp0QXVWTTYzVjE2RllVK3lUNmlVNjJY?=
 =?utf-8?B?ZzNRN3lidHRSMjVnelNBaTBSRlREWnFjcVAxZkV1YksydkhQWjQ0Y0xpVm8y?=
 =?utf-8?B?dWFoSFJBUDI4dHZYQUtQTUlQdWR0aGtoTm1lbjJpaG93ejFwMmpyaWpvL0Ro?=
 =?utf-8?B?bGNwalByblVHcjF4cFlUcmh5Rm1wN2pVTjlHTkpDaC9zSWZvUEVnaDlLeHBk?=
 =?utf-8?B?am90WSsrUVJxMll1WjBxQ0JqUDJ3VzU0WFBVcnlWNmloQ3FZay9sRE53ci9r?=
 =?utf-8?B?ckxBQkpvdTMxSFhsUVhPMnkxWTlCUFhoT3JmekVBNE41OFFYVll3RXJEa2ZP?=
 =?utf-8?B?S2U1TmcyS1dGcVJUeUFWOU8zMHczc0xJa2RWUWgxOXRmTHlZV1JZTE5LWTNq?=
 =?utf-8?B?b0FweC93bmljaWFHWnU3OWZTbGJuUHZSdFRjaE0xMHQ3djhxeHJ0bDdBdXJt?=
 =?utf-8?B?bVVHcUxpcDRpTVV3Z1hsVGIvdk5oU2V1TEgxU1p2a3BkZWUvVW5WQTZiRTd5?=
 =?utf-8?B?VVFQMFcydVpqMGIvYUt6NWJNVzhhZERDZVdMVEtENWx5V1BsWTIxOUZIUzlX?=
 =?utf-8?B?RTdJTVVLNXRoR09uenlocTk0YmRtR1JwQWJSUGQ1a1IxMldZT1JsQ3BSdUR4?=
 =?utf-8?B?SWgxQjhMUVo3bE1XYTBnYmlXTXpkMEdwK0I0cTZIdHVac2x5eC9CTVN3U2l4?=
 =?utf-8?B?aVhlb0pxSHlJbVdSL0xXek9BN2wvQmszRjJURmh5NjBNbEplSUpjQXRDZUlE?=
 =?utf-8?B?OVhIbkI4V0tFV1NuQjFTUlpBVk4zLzNPUHB5dE5rSmJrd0xpSHFIMlk4VHZq?=
 =?utf-8?B?SUZBb1daZHdtQUJGR1hCTyt0S2cwS1BTVTg2TkpyU3lBQzFGOWc1bGRtalpu?=
 =?utf-8?B?R3NsZTZkVDd1c2VGUUNqZzhnclpuWHR5bWp6QUJaK21sbktrdzRiSXpKalB6?=
 =?utf-8?B?aDRWTHNocERBUkdmTFRDelUrb25wd0M5MENFSXM4SVNhd242NFZwWUZPKzVE?=
 =?utf-8?B?QWVybEtEUVJIajBjbXliS3JBTi9tU1A0RUtJSlBmTXg0U21qWldtVml1RDhV?=
 =?utf-8?B?SFBOVmMwK05sa1NNV3c3TzlYMndpWWZwMndra1BHajdwQ0NhaVN2c3NpQ01T?=
 =?utf-8?B?RktUd000RllSaVpwU2h5eWpQY3VsdUx1dXlWZWt1ZmV0L21tUWlRVm9qVEFB?=
 =?utf-8?B?R0VIVTRCWkJEaHFkV1VmRTFLZSt4dVhadm10MTk4RFhVZDhsRnlCTldJOHdR?=
 =?utf-8?B?RVJFdkl6THlDcTM2M3BXaGZvMktGendlamVDWGUzT3Z0ZkJURWlZVHVyMDho?=
 =?utf-8?B?Tm5KT2FwTGkwVml6MENIbFE4STh6andGbEJlZnNobnVtQW5TanI0MkJzbWt5?=
 =?utf-8?B?N3dmb1BxUXZZcmR3eXFEQllLSnp6TUtlaTNBNm12c0dQUXlnd0FGY2RvZnJC?=
 =?utf-8?B?SnNMSjdhTVRCTDRDR2VFVVEvdzBWL0I5UXhkU295MjdoWVRJNnpmOE5TZmlM?=
 =?utf-8?Q?+vb/TeXEkmWBtmsU1WfmHcP7D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F84E18BAA931A468F1E857B83FF58BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ff326-a81e-4e3f-2bcd-08dac27bd1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 17:57:08.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHr0vG/a5H7JU1WC131CLkB8EG5IxgPjv7mtpIL6ZxExtrcqW5zXfdgYt+QYZGdNSgZ2AJz9EvDNOHL4ycXB2JB5vbfiBTTJPtqqx4HyWA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K0NDIERhbWllbg0KDQo+IFRoZXJlIGFyZSBzb21lIGRldmljZXMgd2l0aCBjb25maWdzIHdoZXJl
IFNMT0IgaXMgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPiBQZXJoYXBzLCB0aGUgb3duZXJzL21haW50
YWluZXJzIG9mIHRob3NlIGRldmljZXMvY29uZmlncyBzaG91bGQgYmUNCj4gaW5jbHVkZWQgaW50
byB0aGlzIHRocmVhZDoNCj4gDQo+IHRhdGFzaGluQHNvbGVlbjp+L3gvbGludXgkIGdpdCBncmVw
IFNMT0I9eQ0KDQo+IGFyY2gvcmlzY3YvY29uZmlncy9ub21tdV9rMjEwX2RlZmNvbmZpZzpDT05G
SUdfU0xPQj15DQo+IGFyY2gvcmlzY3YvY29uZmlncy9ub21tdV9rMjEwX3NkY2FyZF9kZWZjb25m
aWc6Q09ORklHX1NMT0I9eQ0KPiBhcmNoL3Jpc2N2L2NvbmZpZ3Mvbm9tbXVfdmlydF9kZWZjb25m
aWc6Q09ORklHX1NMT0I9eQ0KDQpTYXcgeW91IHdlcmUgbm90IGFkZGVkIHRvIHRoZSBDQyBEYW1p
ZW4gJiBJIGtub3cgeW91IGRvbid0IHdhbnQgeW91cg0KYmFieSBicm9rZW4hDQoNCg0KT24gMDgv
MTEvMjAyMiAyMTo0NCwgUGFzaGEgVGF0YXNoaW4gd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDgsIDIw
MjIgYXQgMTA6NTUgQU0gVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4gd3JvdGU6DQo+
Pg0KPj4gSGksDQo+Pg0KPj4gYXMgd2UgYWxsIGtub3csIHdlIGN1cnJlbnRseSBoYXZlIHRocmVl
IHNsYWIgYWxsb2NhdG9ycy4gQXMgd2UgZGlzY3Vzc2VkDQo+PiBhdCBMUEMgWzFdLCBpdCBpcyBt
eSBob3BlIHRoYXQgb25lIG9mIHRoZXNlIGFsbG9jYXRvcnMgaGFzIGEgZnV0dXJlLCBhbmQNCj4+
IHR3byBvZiB0aGVtIGRvIG5vdC4NCj4+DQo+PiBUaGUgdW5zdXJwcmlzaW5nIHJlYXNvbnMgaW5j
bHVkZSBjb2RlIG1haW50ZW5hbmNlIGJ1cmRlbiwgb3RoZXIgZmVhdHVyZXMNCj4+IGNvbXBhdGli
bGUgd2l0aCBvbmx5IGEgc3Vic2V0IG9mIGFsbG9jYXRvcnMgKG9yIG1vcmUgZWZmb3J0IHNwZW50
IG9uIHRoZQ0KPj4gZmVhdHVyZXMpLCBibG9ja2luZyBBUEkgaW1wcm92ZW1lbnRzIChtb3JlIG9u
IHRoYXQgYmVsb3cpLCBhbmQgbXkNCj4+IGluYWJpbGl0eSB0byBwcm9ub3VuY2UgU0xBQiBhbmQg
U0xVQiBpbiBhIHByb3Blcmx5IGRpc3Rpbmd1aXNoYWJsZSB3YXksDQo+PiB3aXRob3V0IHJlc29y
dGluZyB0byBzcGVsbGluZyBvdXQgdGhlIGxldHRlcnMuDQo+Pg0KPj4gSSB0aGluayAoYnV0IG1h
eSBiZSBwcm92ZW4gd3JvbmcpIHRoYXQgU0xPQiBpcyB0aGUgZWFzaWVyIHRhcmdldCBvZiB0aGUN
Cj4+IHR3byB0byBiZSByZW1vdmVkLCBzbyBJJ2QgbGlrZSB0byBmb2N1cyBvbiBpdCBmaXJzdC4N
Cj4+DQo+PiBJIGJlbGlldmUgU0xPQiBjYW4gYmUgcmVtb3ZlZCBiZWNhdXNlOg0KPj4NCj4+IC0g
QUZBSUsgbm9ib2R5IHJlYWxseSB1c2VzIGl0PyBJdCBzdHJpdmVzIGZvciBtaW5pbWFsIG1lbW9y
eSBmb290cHJpbnQNCj4+IGJ5IHB1dHRpbmcgYWxsIG9iamVjdHMgdG9nZXRoZXIsIHdoaWNoIGhh
cyBpdHMgQ1BVIHBlcmZvcm1hbmNlIGNvc3RzDQo+PiAobG9ja2luZywgbGFjayBvZiBwZXJjcHUg
Y2FjaGluZywgc2VhcmNoaW5nIGZvciBmcmVlIHNwYWNlLi4uKS4gSSdtIG5vdA0KPj4gYXdhcmUg
b2YgYW55ICJ0aW55IGxpbnV4IiBkZXBsb3ltZW50IHRoYXQgb3B0cyBmb3IgdGhpcy4gRm9yIGV4
YW1wbGUsDQo+PiBPcGVuV1JUIHNlZW1zIHRvIHVzZSBTTFVCIGFuZCB0aGUgZGV2aWNlcyB0aGVz
ZSBkYXlzIGhhdmUgZS5nLiAxMjhNQg0KPj4gUkFNLCBub3QgdXAgdG8gMTYgTUIgYW55bW9yZS4g
SSd2ZSBoZWFyZCBhbmVjZG90ZXMgdGhhdCB0aGUgcGVyZm9ybWFuY2UNCj4+IFNMT0IgaW1wYWN0
IGlzIHRvbyBtdWNoIGZvciB0aG9zZSB3aG8gdHJpZWQuIEdvb2dsaW5nIGZvcg0KPj4gIkNPTkZJ
R19TTE9CPXkiIHlpZWxkZWQgbm90aGluZyB1c2VmdWwuDQo+IA0KPiBJIGFtIGFsbCBmb3IgcmVt
b3ZpbmcgU0xPQi4NCj4gDQo+IFRoZXJlIGFyZSBzb21lIGRldmljZXMgd2l0aCBjb25maWdzIHdo
ZXJlIFNMT0IgaXMgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPiBQZXJoYXBzLCB0aGUgb3duZXJzL21h
aW50YWluZXJzIG9mIHRob3NlIGRldmljZXMvY29uZmlncyBzaG91bGQgYmUNCj4gaW5jbHVkZWQg
aW50byB0aGlzIHRocmVhZDoNCj4gDQo+IHRhdGFzaGluQHNvbGVlbjp+L3gvbGludXgkIGdpdCBn
cmVwIFNMT0I9eQ0KPiBhcmNoL2FybS9jb25maWdzL2NscHM3MTF4X2RlZmNvbmZpZzpDT05GSUdf
U0xPQj15DQo+IGFyY2gvYXJtL2NvbmZpZ3MvY29sbGllX2RlZmNvbmZpZzpDT05GSUdfU0xPQj15
DQo+IGFyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjR0X2RlZmNvbmZpZzpDT05GSUdfU0xPQj15DQo+
IGFyY2gvYXJtL2NvbmZpZ3Mvb21hcDFfZGVmY29uZmlnOkNPTkZJR19TTE9CPXkNCj4gYXJjaC9h
cm0vY29uZmlncy9weGFfZGVmY29uZmlnOkNPTkZJR19TTE9CPXkNCj4gYXJjaC9hcm0vY29uZmln
cy90Y3RfaGFtbWVyX2RlZmNvbmZpZzpDT05GSUdfU0xPQj15DQo+IGFyY2gvYXJtL2NvbmZpZ3Mv
eGNlcF9kZWZjb25maWc6Q09ORklHX1NMT0I9eQ0KPiBhcmNoL29wZW5yaXNjL2NvbmZpZ3Mvb3Ix
a3NpbV9kZWZjb25maWc6Q09ORklHX1NMT0I9eQ0KPiBhcmNoL29wZW5yaXNjL2NvbmZpZ3Mvc2lt
cGxlX3NtcF9kZWZjb25maWc6Q09ORklHX1NMT0I9eQ0KPiBhcmNoL3Jpc2N2L2NvbmZpZ3Mvbm9t
bXVfazIxMF9kZWZjb25maWc6Q09ORklHX1NMT0I9eQ0KPiBhcmNoL3Jpc2N2L2NvbmZpZ3Mvbm9t
bXVfazIxMF9zZGNhcmRfZGVmY29uZmlnOkNPTkZJR19TTE9CPXkNCj4gYXJjaC9yaXNjdi9jb25m
aWdzL25vbW11X3ZpcnRfZGVmY29uZmlnOkNPTkZJR19TTE9CPXkNCj4gYXJjaC9zaC9jb25maWdz
L3JzazcyMDFfZGVmY29uZmlnOkNPTkZJR19TTE9CPXkNCj4gYXJjaC9zaC9jb25maWdzL3Jzazcy
MDNfZGVmY29uZmlnOkNPTkZJR19TTE9CPXkNCj4gYXJjaC9zaC9jb25maWdzL3NlNzIwNl9kZWZj
b25maWc6Q09ORklHX1NMT0I9eQ0KPiBhcmNoL3NoL2NvbmZpZ3Mvc2htaW5fZGVmY29uZmlnOkNP
TkZJR19TTE9CPXkNCj4gYXJjaC9zaC9jb25maWdzL3NoeDNfZGVmY29uZmlnOkNPTkZJR19TTE9C
PXkNCj4ga2VybmVsL2NvbmZpZ3MvdGlueS5jb25maWc6Q09ORklHX1NMT0I9eQ0KPiANCj4+DQo+
PiAtIExhc3QgdGltZSB3ZSBkaXNjdXNzZWQgaXQgWzJdLCBpdCBzZWVtZWQgU0xVQiBtZW1vcnkg
cmVxdWlyZW1lbnRzIGNhbg0KPj4gYmUgYnJvdWdodCB2ZXJ5IGNsb3NlIHRvIFNMT0IncyBpZiBu
ZWVkZWQuIE9mIGNvdXJzZSBpdCBjYW4gbmV2ZXIgaGF2ZQ0KPj4gYXMgc21hbGwgZm9vdHByaW50
IGFzIFNMT0IgZHVlIHRvIHNlcGFyYXRlIGttZW1fY2FjaGVzLCBidXQgdGhlDQo+PiBkaWZmZXJl
bmNlIGlzIG5vdCB0aGF0IHNpZ25pZmljYW50LCB1bmxlc3Mgc29tZWJvZHkgc3RpbGwgdHJpZXMg
dG8gdXNlDQo+PiBMaW51eCBvbiB2ZXJ5IHRpbnkgc3lzdGVtcyAoZ29lcyBiYWNrIHRvIHRoZSBw
cmV2aW91cyBwb2ludCkuDQo+Pg0KPj4gQmVzaWRlcyB0aGUgc21hbGxlciBtYWludGVuYW5jZSBi
dXJkZW4sIHJlbW92aW5nIFNMT0Igd291bGQgYWxsb3cgdXMgdG8NCj4+IGRvIGEgdXNlZnVsIEFQ
SSBpbXByb3ZlbWVudCAtIHRoZSBhYmlsaXR5IHRvIHVzZSBrZnJlZSgpIGZvciBib3RoDQo+PiBv
YmplY3RzIGFsbG9jYXRlZCBieSBrbWFsbG9jKCkgYW5kIGttZW1fY2FjaGVfYWxsb2MoKS4gQ3Vy
cmVudGx5IHRoZQ0KPj4gbGF0dGVyIGhhcyB0byBiZSBmcmVlZCBieSBrbWVtX2NhY2hlX2ZyZWUo
KSwgcGFzc2luZyBhIGttZW1fY2FjaGUNCj4+IHBvaW50ZXIgaW4gYWRkaXRpb24gdG8gdGhlIG9i
amVjdCBwb2ludGVyLiBXaXRoIFNMVUIgYW5kIFNMQUIsIGl0IGlzDQo+PiBob3dldmVyIHBvc3Np
YmxlIHRvIHVzZSBrZnJlZSgpIGluc3RlYWQsIGFzIHRoZSBrbWFsbG9jIGNhY2hlcyBhbmQgdGhl
DQo+PiByZXN0IG9mIGttZW1fY2FjaGVzIGFyZSB0aGUgc2FtZSBhbmQga2ZyZWUoKSBjYW4gbG9v
a3VwIHRoZSBrbWVtX2NhY2hlDQo+PiBmcm9tIG9iamVjdCBwb2ludGVyIGVhc2lseSBmb3IgYW55
IG9mIHRob3NlLiBYRlMgaGFzIGFwcGFyZW50bHkgZGlkIHRoYXQNCj4+IGZvciB5ZWFycyB3aXRo
b3V0IGFueW9uZSBub3RpY2luZyBpdCdzIGJyb2tlbiBvbiBTTE9CIFszXSwgYW5kDQo+PiBsZWdp
dGltaXppbmcgYW5kIGV4cGFuZGluZyB0aGlzIHdvdWxkIGhlbHAgc29tZSB1c2UgY2FzZXMgYmVz
aWRlIFhGUw0KPj4gKElJUkMgTWF0dGhldyBtZW50aW9uZWQgcmN1LWJhc2VkIGZyZWVpbmcgZm9y
IGV4YW1wbGUpLg0KPj4NCj4+IEhvd2V2ZXIgZm9yIFNMT0IgdG8gc3VwcG9ydCBrZnJlZSgpIG9u
IGFsbCBhbGxvY2F0aW9ucywgaXQgd291bGQgbmVlZCB0bw0KPj4gc3RvcmUgb2JqZWN0IHNpemUg
b2YgYWxsb2NhdGVkIG9iamVjdHMgKHdoaWNoIGl0IGN1cnJlbnRseSBkb2VzIG9ubHkgZm9yDQo+
PiBrbWFsbG9jKCkgb2JqZWN0cywgcHJlcGVuZGluZyBhIHNpemUgaGVhZGVyIHRvIHRoZSBvYmpl
Y3QpLCBidXQgZm9yDQo+PiBrbWVtX2NhY2hlX2FsbG9jKCkgYWxsb2NhdGlvbnMgYXMgd2VsbC4g
VGhpcyBoYXMgYmVlbiBhdHRlbXB0ZWQgaW4gdGhlDQo+PiB0aHJlYWQgWzNdIGJ1dCBpdCBibG9h
dHMgdGhlIG1lbW9yeSB1c2FnZSwgZXNwZWNpYWxseSBvbiBhcmNoaXRlY3R1cmVzDQo+PiB3aXRo
IGxhcmdlIEFSQ0hfS01BTExPQ19NSU5BTElHTiwgd2hlcmUgdGhlIHByZXBlbmRlZCBoZWFkZXIg
YmFzaWNhbGx5DQo+PiBoYXMgdG8gb2NjdXB5IHRoZSB3aG9sZSBBUkNIX0tNQUxMT0NfTUlOQUxJ
R04gYmxvY2sgdG8gYmUgRE1BIHNhZmUuDQo+PiBUaGVyZSBhcmUgb25nb2luZyBlZmZvcnRzIHRv
IHJlZHVjZSB0aGlzIG1pbmFsaWduLCBidXQgdGhlIG1lbW9yeQ0KPj4gZm9vdHByaW50IHdvdWxk
IHN0aWxsIGluY3JlYXNlLCBnb2luZyBhZ2FpbnN0IHRoZSBwdXJwb3NlIG9mIFNMT0IsIHNvDQo+
PiBhZ2FpbiBpdCB3b3VsZCBiZSBlYXNpZXIgaWYgd2UgY291bGQganVzdCByZW1vdmUgaXQuDQo+
Pg0KPj4gU28gd2l0aCB0aGlzIHRocmVhZCBJJ20gaW50ZXJlc3RlZCBpbiBoZWFyaW5nIGFyZ3Vt
ZW50cy91c2UgY2FzZXMgZm9yDQo+PiBrZWVwaW5nIFNMT0IuIFRoZXJlIG1pZ2h0IGJlIG9idmlv
dXNseSB1c2VycyBvZiBTTE9CIHdob20gdGhpcw0KPj4gY29udmVyc2F0aW9uIHdpbGwgbm90IHJl
YWNoLCBzbyBJIGFzc3VtZSB0aGUgZXZlbnR1YWwgbmV4dCBzdGVwIHdvdWxkIGJlDQo+PiB0byBk
ZXByZWNhdGUgaXQgaW4gYSB3YXkgdGhhdCB0aG9zZSB1c2VycyBhcmUgbm90aWZpZWQgd2hlbiBi
dWlsZGluZyBhDQo+PiBuZXcga2VybmVsIGFuZCBjYW4gcmFpc2UgdGhlaXIgdm9pY2UgdGhlbi4g
SXMgdGhlcmUgYSBnb29kIHByb3ZlbiB3YXkNCj4+IGhvdyB0byBkbyB0aGF0IGZvciBhIGNvbmZp
ZyBvcHRpb24gbGlrZSB0aGlzIG9uZT8NCj4+DQo+PiBUaGFua3MsDQo+PiBWbGFzdGltaWwNCj4+
DQo+PiBbMV0gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzE2L2NvbnRyaWJ1dGlvbnMvMTI3Mi8g
LSBzbGlkZXMgaW4gdGhlDQo+PiBzbGFicy5wZGYgbGlua2VkIHRoZXJlDQo+PiBbMl0NCj4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIxMTAxNzEzNTcwOC5HQTg0NDJAa3ZtLmFzaWEt
bm9ydGhlYXN0My1hLmMub3VyLXJhdGlvLTMxMzkxOS5pbnRlcm5hbC8jdA0KPj4gWzNdDQo+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTA5MzAwNDQyMDIuR1AyMzYxNDU1QGRyZWFk
LmRpc2FzdGVyLmFyZWEvDQo+Pg0KPj4NCj4+DQo=
