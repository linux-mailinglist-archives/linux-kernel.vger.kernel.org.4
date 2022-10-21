Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA506070DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJUHVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:21:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D76561;
        Fri, 21 Oct 2022 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666336891; x=1697872891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D0YBvuTUr4QEHgoCi1cXcMCu2Po/KESMR6q6Vt9qss8=;
  b=dvcdFCyYqtoqMf9Uzj1Doj1Nm2QeR0fSDa53wkJibX/VVun9d+/EeHdB
   hFaOIqoPFS0PB0+PzG2S2YmR5D+fQgvlqGDUvbdrJCdlIQ4wgUFKcB592
   /rGl5CZwgZIxwIy5SlwX99Q/q0HOOffQ9JFztf4OWvRZ5e5HbZTjL0fxt
   t4bYxEkI+JV/4id2qrK4Z/iJ4fJE/14YAZdmlXyvx13AzqPbN1RVsFEar
   MWzgD2NIc6GO6cKVHVPKhL7XCvKKABw6kWrKZBlvEiMo6RBNuV99PZ4Uo
   XWzE8G6bSvhMS8UUKotvUHt+le7ifD2jaW4rhlCPKOVRHdYDPmBDcIGFo
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="179894932"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Oct 2022 00:21:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 21 Oct 2022 00:21:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 21 Oct 2022 00:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjy+5Zju1Pf+riauIB2AHl8gRp9HbK2BnK2I8+c1UbTNuC6gA3dfY4vOCi88M0iIQWLVN7IczOAdQGtjmaZzWH9ERrHkgrT1IESRSVK+HE/NvVNcqzgzlsxbZjamcuxuQxW2A8f4M1nDwd9SsutBAYG+3GaQAnuvS4FSXDI+Z4uClM9Io58n4OQfJhuAi29i9mlhfn3yP+OueZ0AcVxhXfhePdUE3eetG1KYnky0evjVEl5MirYSgGu2CnYH0j+byuzFeN9zrnZ4FLwdYPwcI5VzOi21Cu7hXeE30uGwEDaylMgv66XnFvB++CiblBCBDavnO8m7IFadNBKJRKYDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0YBvuTUr4QEHgoCi1cXcMCu2Po/KESMR6q6Vt9qss8=;
 b=BLjRMQsqwb7xNAqSWEHgc01TDoBVybJ9f/+nS3NMBfDYBjdqc1jUuQmdYvMoZcBcIAZUN/vC7i1qbjleIjgrEBp0IGR2OO7g2r0bL0W0LkQiP6Ra50OIUPAlq20T0bikOcFvHQq0kvgo3bTQwlKIvmhHimXH33aKPIDYzYepE9GOJ2P5OiOe4nFTXN8JLTIruoFavXCecaCYHseQzUYGn1kuQiCGn+2sWssZj3ziNlMQcEocnHQrcWXNi4JHguT6bWIN3N86QH/0u4ddgxVUCZLg1rVLqTjEo5LisEwgZodlmKG+fEnR7hM7QCiX0X461hzo3uCWST5RF1Y7XZ4D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0YBvuTUr4QEHgoCi1cXcMCu2Po/KESMR6q6Vt9qss8=;
 b=CkVGgiMs8u3CFhacS2XAGm9AXKGVrFRUJbY/btlBP9fmerKFpbNntq1s6fd1gi2m6nnF28Ar4kgcsU/aoOYi8bvP69T0jK2aPwuuBF2NxXX+cYxKZ1ka63UyOXBhTZa9qr/01l66rejP5Nw1UhvZPzL3LSahH0OYmmZ/32b26zk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 07:21:26 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 07:21:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <paul@crapouillou.net>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] watchdog: at91rm9200: Remove #ifdef guards for PM
 related functions
Thread-Topic: [PATCH 1/4] watchdog: at91rm9200: Remove #ifdef guards for PM
 related functions
Thread-Index: AQHY5R26KR0YaIUJKUSj9+OCDSjriA==
Date:   Fri, 21 Oct 2022 07:21:25 +0000
Message-ID: <cb79fe4e-1d01-4eb4-5aa8-c2e692a0c129@microchip.com>
References: <20221020185047.1001522-1-paul@crapouillou.net>
 <20221020185047.1001522-2-paul@crapouillou.net>
In-Reply-To: <20221020185047.1001522-2-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA3PR11MB7626:EE_
x-ms-office365-filtering-correlation-id: 5dc4dd66-46d5-415f-bb2e-08dab334dd42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6iDoTxv0Sb3kA60+p7euJi/VjHTRUhBHPidCZoClOxJQ0DGdTYYd0uxNwoVQ2enHrtAegsKUhjza4vW2SEhU2b8Dikfucj10tryW8r5XApqcjm9hIJxkjNPkzXOLcrffFlPVZJ9usXDMUjrHcJHiY34Hafh6QMRnZR4TB+JCwcYSud087jIC18GyeUojo8Dn02w9sBVLM0h6B/2EuJYk59VbdidWs8HGVtap+wng1auKlVp1bZlFeH5o3gFWwWMJJTrPRdd0xn/cJ0ZFy9BfEEyV+EZG1ztcv3MR1b7OFGONDGvc0ZwSkx+lev5fKiSyeGeTJdaycOV7o46uTWpFpVOYc5J/tbhlQmW82zGEnRfDcJQj/4meK5V4q6NNIQZNvx3sClCMoCdTHRUkfA7/GMDYLX/v5zwtY0hydiOUd9LZllYFVFDidzfyKFz40/h2QAsLfLBebv9iz+vOX8u6oKOkRxzb9lckNf0lb6Kc1karo+XbeU2bXvFIZ/wdmU5TXRyNrX9ZjYPcfGTuVOCiaBNtx0qGA/QfHcLFJUzHNoJwY5aEnvKWWkZGHubf7kROsGGFqB4TqiU1NjuIDu+2biGam3AVZt8pEEldeOi8rJ9ePjBwNw+6Tdm920MoQZQqFUBJrfQhsWpv5VtbNi0EFWx09v9QEYNhX6x2z/gmjbt3ANGg1a9S3+cuLgxTdo3fG+bDwhgsY1THzkIJOpgaRapVh8PZegfsziWgT9g7/4DB74pPovtfNJKYsS6z9VEwcNVPVU8FqPmMKQqHBdLuahsWYQ/aFDdT4IXHuE+h3BOPP96aF848w3/QPRb3z0DvFg71UTujSpU0pz7GXC77Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(91956017)(2616005)(83380400001)(38070700005)(6512007)(186003)(31696002)(86362001)(122000001)(38100700002)(5660300002)(8936002)(41300700001)(6486002)(26005)(478600001)(6506007)(71200400001)(53546011)(66946007)(76116006)(8676002)(66446008)(64756008)(4326008)(66556008)(66476007)(316002)(54906003)(110136005)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUw5Rzd5ZHZiQzlWT0VURWlNNDMzK2FtTVlscVBnQW5rQjI1aTdWUzdaTHg2?=
 =?utf-8?B?L09TYlQxNWdzNCs4ajRzVDlaNE9PNlZvWk9wZG84TXppdnBpeG9GemVMRlRL?=
 =?utf-8?B?eEs2OWNQVXFXNDhxcjN6bFVKRjRHNUJpUFVGWjRBOVFwOXZmdjR3ZHorSkpa?=
 =?utf-8?B?a0o2dnBaeStjWTROdStSc0lDZVBvQ2RCN3VjeWlaZTlhVmJhazlTcXRKUHU2?=
 =?utf-8?B?UzFWcFZoR1o4ZDBhYi9RMDVTMDZtZnFCSXVRVlE0TU03MTVnWjN4bG1wNytl?=
 =?utf-8?B?Z3RiTmFEd2F0N0RsY0Uvdmd6cHEyUTliaGRxSnkwaGxGalBGOUJ6Y2l4TDFU?=
 =?utf-8?B?WkZtU1AvWnphc2htSTVMc0d4SWRZajF4ME1STGlqUSs2aWlYZHFsaEpid0M0?=
 =?utf-8?B?cVhRanBTREt5UmM4dlZrV3FIck1yTzJ3elZDclN4RXJ4Qkdpc0pRUUVxdk8w?=
 =?utf-8?B?YThzOG1CcmtPQ1VreTJsaHozeFdwL1lURmFHVmk1dGJMOWsxMzg3dXZSdEJp?=
 =?utf-8?B?dURCOTdYSGRxTWRaU0kveXAvSDVNZGRHQVh1bmtEdkVLM1paS05RdXVCaHVr?=
 =?utf-8?B?amNqK2xaOVVxUTJYSmMrUUN4ZzV3cWZEL1l3Qkt3aDJKWDJYYXFVM3pRanNX?=
 =?utf-8?B?NEYwRit4VFFKRXFNVGNFQUFkWXNIUlZrdnhJTHNpb3hnY2x1a1VhYlU1clZD?=
 =?utf-8?B?UW44VitCUlU0TCtBcWx0dzY0VHlnRHhZY0ZtVmpTbTBhVUFMRDR5OXE2Z1JC?=
 =?utf-8?B?NE9jNWV2dmJ4SUsxbHBzRkV3VGFONDN4TG44bDRtMlBFUHZMTGFjSkNKaCto?=
 =?utf-8?B?dnNiMG0xQVk0b0c1dVB3aEY4YWFZc3pkSS9yVVY2NVMrb0xnVEY5c0NiK3hl?=
 =?utf-8?B?UHRNUWFVNVFnb2YwWkF2cGRUa1dwUzczajE4RXRIdER4c3ZSeHZldXlvQVBr?=
 =?utf-8?B?elZ5YmtURnErdlBEalhocGErM2JOcjNXU2REcnRKUVB0THR3NEhISFRuWmdt?=
 =?utf-8?B?NnYvZGpDaW96ajA1azRMNlVpcU1NL1l1OUZON3FMWXY4ZXJjanc3NkRCSGVF?=
 =?utf-8?B?V1JpNERMSU5UQ3JtY2Q0ODhRdm9waHphMVNQQlRlZ3hpYklRUlFxdWVFazB0?=
 =?utf-8?B?QjlxVXBmRTVvaHV4ZjlDT29ZOWZEd3hYQkxFZzEwdTFUWDZhOHhWWVMrUXZC?=
 =?utf-8?B?TlNNemJkcGNWYVJ2WmNRdUFNZDNrTlJ6MGN5Q0tBQm1hNUxqWE01V1M4YlY5?=
 =?utf-8?B?M1ZSS2VXbEVWd3JTY0FsK1ZkYjB5VFNqSi8xc28rVDRiZWdxaXJnZy9vamRC?=
 =?utf-8?B?OEtxTitxS1RZMDNacTNBVFZXTmhSR3Y0cmJUZVl2aWo3d3lWVEQrREhScXRV?=
 =?utf-8?B?ZGlrMHdycWdHVGVrekdweVorMENSVjZhVytMM2t2aUY4eTZ2K2tya1VWYkpH?=
 =?utf-8?B?ZjRLZ1NJaWpNcHBMenVIU3E0NnV0WXJGYkR2V3haa2tpUjB2bmk4SWdCZGFE?=
 =?utf-8?B?bzdRQzIxU1NPeEoyUUpwbXlHR0dJdTBBajhtZUlyUmVvNjhyK3RJT2FxNjg4?=
 =?utf-8?B?QTdoUURDQlBodXlYVnJNdXJxbjF2SUl2WEMxTGh4TUQ0Z0FkeERGbnhkTjFz?=
 =?utf-8?B?WmhPVE0wSmFYSGZzUksvV1hHSGg0RXlsUTVuSEVaMkJVUS83SUlsNm5kdlVa?=
 =?utf-8?B?cDNUZytjcVdVZG9yd2ZpekNZME90WmRvVEtPWGtXRU4rSDRzV1R5ZUZFR2wv?=
 =?utf-8?B?K281NnBLOFB2ODZQbUhWMnVvaU5VSnpqcU9BeGY5OGNhUmtYUUlwd284aEsx?=
 =?utf-8?B?UXp5Und0blJ3RWJzUlIvY3VCV1p0dWFBVk9COE5qWHpDQ0pzQjdMYnFzZjMy?=
 =?utf-8?B?SUJ3Y25JTXNGNXNZWTVZSi92cENoRzZWdnYvYzk3Y3gybThsUTlJTU1kaThT?=
 =?utf-8?B?VTF6OUF3RlFPM1VWTk9HcnBVc0lnbGpEQjc2Ym4ybjlSd1l5aFRSakZ2VFZQ?=
 =?utf-8?B?ZHV4V2ttMHlkdTA0OGl4eTRjS0Y4b1VreDE0UDZkTWxETGNuYzVhY3N5Qzk3?=
 =?utf-8?B?dGxlcU1TTFVnK1hlYUo0bjc0YnlFcFJNMkordzliS0orc01Pa0hWMHpNQ1dO?=
 =?utf-8?Q?ITBB3zq/VAk2jsOqrceLlFFbD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7D94A9109B9B47AA36C4C191B4B3B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc4dd66-46d5-415f-bb2e-08dab334dd42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:21:25.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrBMSOdQGwWwK+d1I29u91byotL+IfE6cy2gbvi5QGJauBWWRBBQJB/uxofGdL/LsQ5U/+A2potJw4GNUmGL4vMPm6uwiPRQxZCg3T7W+Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMTAuMjAyMiAyMTo1MCwgUGF1bCBDZXJjdWVpbCB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBVc2UgdGhlIHBtX3B0cigpIG1hY3JvIHRvIGhh
bmRsZSB0aGUgLnN1c3BlbmQvLnJlc3VtZSBjYWxsYmFja3MuDQo+IA0KPiBUaGlzIG1hY3JvIGFs
bG93cyB0aGUgc3VzcGVuZCBhbmQgcmVzdW1lIGZ1bmN0aW9ucyB0byBiZSBhdXRvbWF0aWNhbGx5
DQo+IGRyb3BwZWQgYnkgdGhlIGNvbXBpbGVyIHdoZW4gQ09ORklHX1NVU1BFTkQgaXMgZGlzYWJs
ZWQsIHdpdGhvdXQgaGF2aW5nDQo+IHRvIHVzZSAjaWZkZWYgZ3VhcmRzLiBOb3QgdXNpbmcgI2lm
ZGVmIGd1YXJkcyBtZWFucyB0aGF0IHRoZSBjb2RlIGlzDQo+IGFsd2F5cyBjb21waWxlZCBpbmRl
cGVuZGVudGx5IG9mIGFueSBLY29uZmlnIG9wdGlvbiwgYW5kIHRoYW5rcyB0byB0aGF0DQo+IGJ1
Z3MgYW5kIHJlZ3Jlc3Npb25zIGFyZSBlYXNpZXIgdG8gY2F0Y2guDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBQYXVsIENlcmN1ZWlsIDxwYXVsQGNyYXBvdWlsbG91Lm5ldD4NCj4gLS0tDQo+IENjOiBO
aWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IENjOiBBbGV4YW5k
cmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+IENjOiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiANCj4gIGRyaXZlcnMvd2F0Y2hk
b2cvYXQ5MXJtOTIwMF93ZHQuYyB8IDExICsrLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3dhdGNoZG9n
L2RiODUwMF93ZHQuYyAgICAgfCAgOSArKy0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3dhdGNoZG9nL2F0OTFybTkyMDBfd2R0LmMgYi9kcml2ZXJzL3dhdGNoZG9nL2F0OTFybTkyMDBf
d2R0LmMNCj4gaW5kZXggNmQ3NTFlYjgxOTFkLi41MTI2NDU0YmI4NjEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvd2F0Y2hkb2cvYXQ5MXJtOTIwMF93ZHQuYw0KPiArKysgYi9kcml2ZXJzL3dhdGNo
ZG9nL2F0OTFybTkyMDBfd2R0LmMNCj4gQEAgLTI3OCw4ICsyNzgsNiBAQCBzdGF0aWMgdm9pZCBh
dDkxd2R0X3NodXRkb3duKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAg
YXQ5MV93ZHRfc3RvcCgpOw0KPiAgfQ0KPiANCj4gLSNpZmRlZiBDT05GSUdfUE0NCj4gLQ0KPiAg
c3RhdGljIGludCBhdDkxd2R0X3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwg
cG1fbWVzc2FnZV90IG1lc3NhZ2UpDQo+ICB7DQo+ICAgICAgICAgYXQ5MV93ZHRfc3RvcCgpOw0K
PiBAQCAtMjkzLDExICsyOTEsNiBAQCBzdGF0aWMgaW50IGF0OTF3ZHRfcmVzdW1lKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAt
I2Vsc2UNCj4gLSNkZWZpbmUgYXQ5MXdkdF9zdXNwZW5kIE5VTEwNCj4gLSNkZWZpbmUgYXQ5MXdk
dF9yZXN1bWUgTlVMTA0KPiAtI2VuZGlmDQo+IC0NCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGF0OTFfd2R0X2R0X2lkc1tdID0gew0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUg
PSAiYXRtZWwsYXQ5MXJtOTIwMC13ZHQiIH0sDQo+ICAgICAgICAgeyAvKiBzZW50aW5lbCAqLyB9
DQo+IEBAIC0zMDgsOCArMzAxLDggQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXQ5
MXdkdF9kcml2ZXIgPSB7DQo+ICAgICAgICAgLnByb2JlICAgICAgICAgID0gYXQ5MXdkdF9wcm9i
ZSwNCj4gICAgICAgICAucmVtb3ZlICAgICAgICAgPSBhdDkxd2R0X3JlbW92ZSwNCj4gICAgICAg
ICAuc2h1dGRvd24gICAgICAgPSBhdDkxd2R0X3NodXRkb3duLA0KPiAtICAgICAgIC5zdXNwZW5k
ICAgICAgICA9IGF0OTF3ZHRfc3VzcGVuZCwNCj4gLSAgICAgICAucmVzdW1lICAgICAgICAgPSBh
dDkxd2R0X3Jlc3VtZSwNCj4gKyAgICAgICAuc3VzcGVuZCAgICAgICAgPSBwbV9wdHIoYXQ5MXdk
dF9zdXNwZW5kKSwNCj4gKyAgICAgICAucmVzdW1lICAgICAgICAgPSBwbV9wdHIoYXQ5MXdkdF9y
ZXN1bWUpLA0KPiAgICAgICAgIC5kcml2ZXIgICAgICAgICA9IHsNCj4gICAgICAgICAgICAgICAg
IC5uYW1lICAgPSAiYXRtZWxfc3Rfd2F0Y2hkb2ciLA0KPiAgICAgICAgICAgICAgICAgLm9mX21h
dGNoX3RhYmxlID0gYXQ5MV93ZHRfZHRfaWRzLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRj
aGRvZy9kYjg1MDBfd2R0LmMgYi9kcml2ZXJzL3dhdGNoZG9nL2RiODUwMF93ZHQuYw0KPiBpbmRl
eCA2ZWQ4YjYzZDMxMGQuLjk3MTQ4YWMwYWE1NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy93YXRj
aGRvZy9kYjg1MDBfd2R0LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9kYjg1MDBfd2R0LmMN
Cj4gQEAgLTEwNSw3ICsxMDUsNiBAQCBzdGF0aWMgaW50IGRiODUwMF93ZHRfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+
IC0jaWZkZWYgQ09ORklHX1BNDQo+ICBzdGF0aWMgaW50IGRiODUwMF93ZHRfc3VzcGVuZChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBtX21lc3NhZ2VfdCBzdGF0ZSkNCj4gIHsNCj4gQEAgLTEzMCwxNSArMTI5LDExIEBAIHN0YXRp
YyBpbnQgZGI4NTAwX3dkdF9yZXN1bWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
ICAgICAgICB9DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IC0jZWxzZQ0KPiAtI2RlZmlu
ZSBkYjg1MDBfd2R0X3N1c3BlbmQgTlVMTA0KPiAtI2RlZmluZSBkYjg1MDBfd2R0X3Jlc3VtZSBO
VUxMDQo+IC0jZW5kaWYNCj4gDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBkYjg1
MDBfd2R0X2RyaXZlciA9IHsNCj4gICAgICAgICAucHJvYmUgICAgICAgICAgPSBkYjg1MDBfd2R0
X3Byb2JlLA0KPiAtICAgICAgIC5zdXNwZW5kICAgICAgICA9IGRiODUwMF93ZHRfc3VzcGVuZCwN
Cj4gLSAgICAgICAucmVzdW1lICAgICAgICAgPSBkYjg1MDBfd2R0X3Jlc3VtZSwNCj4gKyAgICAg
ICAuc3VzcGVuZCAgICAgICAgPSBwbV9wdHIoZGI4NTAwX3dkdF9zdXNwZW5kKSwNCj4gKyAgICAg
ICAucmVzdW1lICAgICAgICAgPSBwbV9wdHIoZGI4NTAwX3dkdF9yZXN1bWUpLA0KPiAgICAgICAg
IC5kcml2ZXIgICAgICAgICA9IHsNCj4gICAgICAgICAgICAgICAgIC5uYW1lICAgPSAiZGI4NTAw
X3dkdCIsDQo+ICAgICAgICAgfSwNCj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
