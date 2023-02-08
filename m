Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2F68EC1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBHJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjBHJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:49:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC491167C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675849779; x=1707385779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ss0Mhuw0MiCI+IASdRKp4dZ0yD7HNLlaltZOthmeQP4=;
  b=sGrUKvwHCS0DGCsyieIBuqFjdD7WaYecXkRY7XqegU3EhLtlaYZokIXG
   SRHjtTy24D+vMaypGUCFDda5y8T8nUjXMsU+dI22H1CA6Md+6URy4hViT
   c+t6O9Hhis2uiPd+PFvW3Dm5rMfQYB4f/4k+reJ1jTynah7XnWVQzBUIb
   wX8Y+JezUSLTeRY34VdV/3lkmKUeFNdgmBEYMyZbd1SebGuH7O9qVv1lp
   LQ6MnZZMm58pDd9QNiLxDTX21LIia3eLTpPbB/tXEcvQM0EpaAyisqHNg
   AJTFY/o7xKeeCWrAnRA874N5Bo2f4nH1cb5Hr/dFdLV0BSVGbcIL5SLNN
   A==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669100400"; 
   d="scan'208";a="136117336"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2023 02:49:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 02:49:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 8 Feb 2023 02:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEgKnz5bnjvVF2jZ9wfDvmGsG0ycja4hBomGg/oAsIxvHbQnec4YU5A9kN0I0fG3LBvGNBuuZNTl0v9MQ6TZI0Cm1wMNa77dhkL9kTAuXxuXG3muJpnubZZDXH5PgvhrZ2ZzCAwJtb0OlPPITovgbDpkrZV/3/4zbcs13wKFJmWcrth9Wd8dKqMwSY8qVundQgJFQsGDJXwTMsr7LeFDLxJW0kjgI+YC3C5N7ojN56WqPiEJqN5tWdROfyP483d4X2Kep/TuBP3a/a34xuQvVZuaoDVWdAOH3UHUUKQ+G/MhUjuGHU3DK2nXuhn0pkHQu/nfCi6bW/Or+Lu4GIwJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss0Mhuw0MiCI+IASdRKp4dZ0yD7HNLlaltZOthmeQP4=;
 b=j9JyO4TJWJDI7OOI/o1bR8uLrM2zpzj+ucsiB236Ouv4E7z7FyfvtEJCvmX0cqiidvJzgAGJhwD2nzLYcvUm4Bkq2h75Me4wWOjOqc34ftip5UTjh9egjIMvRchBtTMDP4GtzuqlHXAGwZWLeoehrNWFhTTiXKtYa0195SuxC972p4vfctEhcqHlnaLtyiETxxKfHuXZTFpele64QwQPcPN9BjD4zE7OIRzy1YnJqdk0bSIe7tlo/8boH1FCgDp7vf+stsFDNQKBJUJe3SDm6HncTyV3/dU/z+EzVbcUHCInEdGBD05FF/UN2uOBkW5Znq97zYkXhASDaayhhgqbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss0Mhuw0MiCI+IASdRKp4dZ0yD7HNLlaltZOthmeQP4=;
 b=PG8kubb6EllMs+JAsTDxTmXID/mmM3M0yIgBuZbeSVRGve40Ti481VIDv095aj+WrCFsCuZVcaz1sl0k6OpmEt6C1fj4FUJqvO/A0OPcefc6CKDJ6LQQm0lBw4wKxZWDOywfQ0+5TYsGtuESJFhEfUcal0fzT4YBRMvPBnl1QSw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:49:33 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 09:49:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <ye.xingchen@zte.com.cn>, <lee@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gbWZkOiBhdG1lbC1mbGV4Y29tOiB1c2XCoGRldm1fcGxh?=
 =?utf-8?B?dGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBtZmQ6IGF0bWVsLWZsZXhjb206IHVzZcKgZGV2bV9wbGF0Zm9y?=
 =?utf-8?B?bV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Thread-Index: AQHZO6Kla0dUvEfUvk6K/ExEooY+1Q==
Date:   Wed, 8 Feb 2023 09:49:33 +0000
Message-ID: <7c9af50a-f4b1-ed1a-5655-cc20fd880bf1@microchip.com>
References: <202302081731593374472@zte.com.cn>
In-Reply-To: <202302081731593374472@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB4799:EE_
x-ms-office365-filtering-correlation-id: f0096c39-a707-4f9b-02ef-08db09b9c808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKDmrZFwP/WqHVGdcx7VYjif49shVbjkRU2zYxrvs7iX8Jsokl6atoogPiuWJ+YONBCPyI079fKPAT5HJqG4/8++aLIzna9l/MnGM5zs+bDIsDtx5uVaPdY6ShbO0kGASW5hlBpt1Yb/MaFKPyKNZT65pII/snUGmQ3GwI+r3CXvJAWDc4WPzpeVqoZb2n8EzvLBebvpP2qOCmmxx8Mxn1yyzDKZ9LVIuIXnEvHofD49VjS589p/OJ323Q721UL3VQQdKhjZPev3XpcpWEcx2Xt0pypdn/oStnljmXJRVc5LOj1DSixDmFsz3dSHTZ+CJJdCsUUPyue36kUSSwid44QHCM/2exQh5DYRL9BTyDhQrzakIzFGmHuu5HtfYn8klgGjst8oTqzq5Oiz2/KpXFPz5g4XedfGQxCKr2GwsIKMlYthsbFuL7vZPe7mWHT2GXySZUqUdUEPLeNKQ7aj865oBqh55vnsmdJDUbS5oX+glXlnjyhVTeDQerljQvJ5K3IleTu/SP3G+fr6qcLuRBy1S1ZFulvqbXasuzEu9C1gT3NKXY3oXuekCvJsjgF+flFc4MiZof++ZKrr2/BwpOsNsyoQtnzB5f0pnzoc+QXeyiOQc/Awga39GwvnL4T2fQ3Pq8eyRxcvT5y2q3z+ekT4y6U8Rgcy+KwfRcO/i5PU4XKt8j0RKcBAoBpNOO7hEJt+m8+fXlW6fzY8MxTt7s1j7CTBglCdc1Quxu0stZaF/LK0+gvxvoq80wnKQPqvd+RF9FHGHwR7sMvcnghUEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(31686004)(4326008)(91956017)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(41300700001)(38100700002)(2616005)(122000001)(186003)(26005)(38070700005)(2906002)(71200400001)(6512007)(8936002)(6506007)(53546011)(316002)(478600001)(86362001)(31696002)(6486002)(110136005)(5660300002)(54906003)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnFJU1htbUtSblN3TE51MWs3R0FvMUlwVXNmOXU1Skd0RlNnL1o4ZzNwSmpS?=
 =?utf-8?B?TndQc1dHK0hLNEhFQkJYRm9GTGtBZWNsY0k1dktVMDJvM3pibEJsUCtkZ0xU?=
 =?utf-8?B?djRxbXI3WnAxSGJJdFNHSlRPMTNUdE9Qb1JTWFBRMWw0dEFpVXhpSk5hVnlo?=
 =?utf-8?B?TjdLZHRqdTZuS0FRcU9iR21CMjQ5VDljdlg4SGhmaTMxK25rTndwMG91b1Rr?=
 =?utf-8?B?QzhyRnQ3NmF2WkxYMWx5ZTNTTFJNK2pweGV4UFQrbkxPNmxQdXg0cFZVNWpL?=
 =?utf-8?B?ZDh5T3MzekxiMUhhT2RPdnI2Yk4xVzVzVjNTNllMblBjTHJhS2FtdVlOdkpz?=
 =?utf-8?B?akFCWVRRUDc5QmRXdnRvaXRteVFOSE5Ickc5M0tIczRKSXVkd3RXdndBWndR?=
 =?utf-8?B?K1puY1NVZmY4RGFneG1rcmRCMlN3WWxnYmJ2UkZPR045Z1dZQkdWTUZERmZH?=
 =?utf-8?B?S25jb2RvTGlmSnkyTkhRVFlqeXdWSE8wb2YyQjVZVmlDRi9PaC9Ic0c4TG52?=
 =?utf-8?B?TWhmcmdrSy8zZThKdXBkR0VHY3U4clpJSmhrVkFUamJuNlIwU3g4eElDaHFs?=
 =?utf-8?B?NngxOVdXdVpxUjliM05oZks0N0NUeDdLN1dqNGdTbWR2QmgxdzhKaWpDN3lz?=
 =?utf-8?B?SElObHI1T3FPSURtZklCQ21NVkJXZVU5U2Q5dGNKNGl0RmVTamM2dG1VOStX?=
 =?utf-8?B?NkxNOUFvS25IY0k2SVkxMjlNc2hOUXEyeGZubUdOQkJlYWtZZ0cwd2xpLzlQ?=
 =?utf-8?B?NzY2bHNwQ0FLUXk2Zkt2Mi94bXd3TjQ3Z1hVSzFmQTY2NEFzZVRMUStHeEFL?=
 =?utf-8?B?dk5QNGt5bVJ6K2QwQ3dZMHpQR3lYSnk4dUpDUXRwb3c3QkI1T0sxdzRrRXpX?=
 =?utf-8?B?T29GSlQwbFpKaWczb0VwM3l3d0JBNXNnQUd5QjRBelViQ3M5a2pJaFJWejFV?=
 =?utf-8?B?U0xuVmJENVErRVVWUzc2SElhZ0tCV0pONDlaQW96QXNkQlM3WktjVnZ5YkJv?=
 =?utf-8?B?Q1VyQmdFTE0wRGRjc2NKYnBZU0gxbFdBNTZQMVdaUkdIZEJNTHZlWFVvR0Fj?=
 =?utf-8?B?KzdiRUF3Rk5QVENhZkRHRENPU016NTZ2Qjg2UTQ3L2kxbzFubmhyNG95SjNI?=
 =?utf-8?B?MWdHZWdjR3NZL2FFdkdUYXdSWmRZTGJFQU5xbFpMZkE3VFI0Mk5ZUmM3di8z?=
 =?utf-8?B?dGp0WW5heTJmZzcwenQweTZ1WkI4SElVSUxXOGN6NVVPdWlDWnhYSGlTdzlk?=
 =?utf-8?B?THUxTk40RGprejFyNlhRdStaLy9lN0NoUjVkMk1wTW5JaHRZQUJTb21LbDVR?=
 =?utf-8?B?MDdwSVo2bTlxQzhGdDBVZXZSNkphSVA0NjdranR2VHRHcnpsT2RDajJRQXEw?=
 =?utf-8?B?eGpPU21aUHRLc1ViSkZqL1E4cE85QTM5Z2hTRTZ2MzQ5RFpnci9YUHp2NVRB?=
 =?utf-8?B?UVN6ZCsyYTRSQVRFUEhjVlJGSW8yd3NnM29ETzRTcnJVN2llRU9pOVZxTmtn?=
 =?utf-8?B?Lzh0MVFzcFFlZEhMb3RQLzZUUURpamw4aDJLVGJ3R085VnVHdk96QkcxSUwy?=
 =?utf-8?B?Mkh2MkEyK2w5dEtsMFFwWGNnQjhZbzZQbVhmOEE1S3Bhd1Y3SjR1ZnNQVTQz?=
 =?utf-8?B?Uy9EUGovbDkyUytOUEZyYy91cnJvQVBZekFLcWM0R0h1aGFrdVFhYnB2ZWt4?=
 =?utf-8?B?bVY1WVlRMmtCT0lDYndDeENLN3psZGtKNUpkSlJTaER3KzJkL1U1L2ZjQUdG?=
 =?utf-8?B?MmZqWEQxS1ZIL1NOSWF4N3NvZWl4Unl5Q3ZoNlZYckw5ZHp2OWRRTEIyS1dx?=
 =?utf-8?B?UG9MOStEYjhvSGdLU04wOHN1WHpDc2J4eVZndnVBOGUzT0VRV3UycUZxS29O?=
 =?utf-8?B?S2NXNit4NVVMZXRhN2srR0VqbEZxMHVWUG5MSW9YaC9wd1NQd2p0cFQ1QXRw?=
 =?utf-8?B?WVVjT0RvZFpQd2JscTZXcUdsREVIQjFYMm04SnhkODBzNU0xU3RZQjZPbmt4?=
 =?utf-8?B?QXF0V3Rjbzc2d0hhd01ldEl6Zld6WVBOM2dUSWd3UTl2RzBqc0ZzQzV2R1d4?=
 =?utf-8?B?bkZ1b2FyTWRaR1NQeWRqdEozbHRVZUp0ampkOXROVDFydmlCS1RVR1VyM2dR?=
 =?utf-8?B?KzN4Ulg5NmtKMzA1R1pVaWxuUVVOMDNQbllRSVlmNU1RMy9RR05yTUNvcjdT?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C87E4D4187E1349974719F9A83B0A46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0096c39-a707-4f9b-02ef-08db09b9c808
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 09:49:33.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9khARlfioa5B1NKiC3VNJYLqyGGwftDzEwjLFKKfFGPIG8fJvc0hlSQqjTtYqaq8XFwtwYQ8raSjQZL4TqXVrc7EkZe0Wp0+FHNaSSh1TTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDIuMjAyMyAxMTozMSwgeWUueGluZ2NoZW5AenRlLmNvbS5jbiB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBZZSBYaW5nY2hlbiA8
eWUueGluZ2NoZW5AenRlLmNvbS5jbj4NCj4gDQo+IENvbnZlcnQgcGxhdGZvcm1fZ2V0X3Jlc291
cmNlKCksIGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIHRvIGEgc2luZ2xlDQo+IGNhbGwgdG8gZGV2
bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKSwgYXMgdGhpcyBpcyBleGFjdGx5
DQo+IHdoYXQgdGhpcyBmdW5jdGlvbiBkb2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWUgWGlu
Z2NoZW4gPHllLnhpbmdjaGVuQHp0ZS5jb20uY24+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NClRlc3RlZC1ieTogQ2xhdWRpdSBC
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJz
L21mZC9hdG1lbC1mbGV4Y29tLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9h
dG1lbC1mbGV4Y29tLmMgYi9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMNCj4gaW5kZXggMzNj
YWE0ZmJhNmFmLi5iNTJmN2ZmZGFkMzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWZkL2F0bWVs
LWZsZXhjb20uYw0KPiArKysgYi9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMNCj4gQEAgLTM3
LDcgKzM3LDYgQEAgc3RydWN0IGF0bWVsX2ZsZXhjb20gew0KPiAgc3RhdGljIGludCBhdG1lbF9m
bGV4Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAgICAg
ICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAtICAgICAg
IHN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgICAgICAgIHN0cnVjdCBhdG1lbF9mbGV4Y29tICpk
ZGF0YTsNCj4gICAgICAgICBpbnQgZXJyOw0KPiANCj4gQEAgLTU1LDggKzU0LDcgQEAgc3RhdGlj
IGludCBhdG1lbF9mbGV4Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAgICAgICAgICAgIGRkYXRhLT5vcG1vZGUgPiBBVE1FTF9GTEVYQ09NX01PREVfVFdJKQ0KPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAtICAgICAgIHJlcyA9IHBsYXRm
b3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+IC0gICAgICAgZGRh
dGEtPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gKyAg
ICAgICBkZGF0YS0+YmFzZSA9IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNl
KHBkZXYsIDAsIE5VTEwpOw0KPiAgICAgICAgIGlmIChJU19FUlIoZGRhdGEtPmJhc2UpKQ0KPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZGRhdGEtPmJhc2UpOw0KPiANCj4gLS0NCj4g
Mi4yNS4xDQoNCg==
