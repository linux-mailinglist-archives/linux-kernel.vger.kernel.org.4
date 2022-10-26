Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546E560DC37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiJZHhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZHhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:37:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F76687086;
        Wed, 26 Oct 2022 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666769840; x=1698305840;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=SpAmZenejyJ4RQ1HtEUXLebuT8Il4uk96dxOyzGN1UQ=;
  b=YnvOyclQKabar+tcWd3SUtOxkWcGBfaLPjt7LRi9xysdbp4GpSxK6Ny6
   tfw0pqlOmYuplOVccLJrfTC7fEnkkeNml7HedvS/bY5q9cq7idA8nxzWf
   ySLwtdh8Z9qDzKhnJaU3diEVf2mNO7YapcZlG0GBGnfJaOuivlVkMkfu1
   Fe0Sk1d6QWk9zk3RLmU+6bNP5fvVkBtT7kbMGkWyecewtAnvF13fVkRNx
   +Ry/3i7iGMe01bA1IXd50SFUMycR9AB3+BIvaju+34RX9Bo4gB+rkNDYz
   IiMj+yPf55mAtyE3i+qqCTkLNSIa8GmfQRE7TK/2Xh6qnIvAqXBUjsKX1
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="186325139"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 00:37:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 00:37:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 00:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9JZMutoH5yf+5DfmG0ORezmvlQW72Sg26PamxIMZgXGGiHLGRKBaeTiADX+609pO0zS6jeHywd9XLqnzli61zsq1DsR8SZpu+MMf7eAMpfv84146XqbTHg0hUE6P2CapR/HwfLlbgNc+zBeY5dvVWnDd8YUg1UZ5kP4SVldtNVc1+ntpH5IwvPmCygM7Wl6/BA8b282EbqGeChqdH4jn0+6CIDZh/gm1TSnIRymXrEegpKcqf+71PO2WHFghsod0YUpzcUs3ZCTMAc0jkcSAbCuDeOkmmJFwgeDD5c8kr3xbg9WrJuBcT/IM8iENhGI3wfEOIdAhTkUylllZQ/12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpAmZenejyJ4RQ1HtEUXLebuT8Il4uk96dxOyzGN1UQ=;
 b=Py3m5FnvhBmLDz655UACVS/H1XrVAFJsqvCqH1hgAVuXs7ZYJBWMlApWqn1TudJ/rpJFjC4jZnSUhR+oiNdYHVBi/p8t2gU32LQJaoNZqxliooYaYZhyvqL4EaMhsiYoBtvxxU0JY3a83pDgoAuDDPeS549O9Gw2MQ/lFD8xKKRI7gNkpvKEowKdowFp2Ku/on9+/ZipcUR4MaJh/J8d/qsEvB5rLEc0elWmObQ06qZ6bztdPGKJ4sXvGmXYPPhbBHTkR1/jfqwS1t3S+vW4G0cWV9nWmYXQOHM950VlKgv9nQfg3Cdru4em40/Gmuq7sZReO33TnnHWFi1++8op5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpAmZenejyJ4RQ1HtEUXLebuT8Il4uk96dxOyzGN1UQ=;
 b=PzfZMNz1EvEuXrzbmwfYwfXxqGQL8BZ2Tz8vlvqU/zdo83FddmNA2y8ivQokZ2gMNSdUEZryINl9Rfc9K4puMpme7w2JnS+exXPNtTDmgSWTSGSN7wMbLPEOXr+GZ+hPpeR6M5M3dsDmMZJbvxTXSg3C8/mW03zsFw3IhUOyQkA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:37:13 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:37:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Mihai.Sain@microchip.com>, <robh+dt@kernel.org>,
        <Eugen.Hristev@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PB2
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PB2
Thread-Index: AQHY6Q3DlvUuz/Un00y63pEeLeRs+A==
Date:   Wed, 26 Oct 2022 07:37:13 +0000
Message-ID: <93f43ba4-fd03-a1cc-d4c1-9b924dd50758@microchip.com>
References: <20221017083119.1643-1-mihai.sain@microchip.com>
In-Reply-To: <20221017083119.1643-1-mihai.sain@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB6574:EE_
x-ms-office365-filtering-correlation-id: c2196754-cca9-4e5c-5a92-08dab724e655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7eZDE7t5Y6NCPpX+812gMikiJgUtxAepi1/u25uN9yy9YX+bgUmb4Vx0aX9DPXoKcpaTs8jqQ0nL94y8AW8ZkX82VXv5rPBGdotA+ta6ZRfaaTViwQ7mF0KvI7q7GDRf0tvD2qhZsEjN/Rx4c6CzEHknwKbfaPx+XrhvbKgSD23ZJqwU87hkjNgwfCFA9UQrA9rH6bhd4p0C6jvamLMR8g0UIRfN9eOTxjfFl0Qm2ry/FA5pnFKW4KCNxeejJU22xjjndc7T5dKbeLDKZTHUuSjYr+Gjp6AunBUF96X+iYcPBg3s7KYd/XwHaIT8grvuGoKKLLwHxYsRCqrQQN9Ym2Osk37Dka0GLD63dYkMwBVfUDc22AzVpEvnWfuZBZyU3dmqQuLJYq+MSklbP5TR6TJGu1IxPSxN+uEuBwTR7qnR+i45pMCnHTk8sn50g0SWFuutaIaqKd0r1LT2gNo7f0MEQGX/p4h8n0zE4tXFhG1Zxv3eNukliCAwA629nrGM2rQpZSbaZxVeb9p2CqAeTHMey5clSNFZJJTS9TdoMgeLtRkMLam0WfLl1aGGwLzgtzdUQ6WHZ60H67n5YKLu7qUzJRpPz//vm1vvpRoFVMfoxrJqpH86DjgdFOUu67/2GxnrDBnPLrHEm7JieVsyQca3TQSfJjNBH5G731GDTAh3SsFA6Ti44QAQN9UmDBKsODuA2cp0DCQx9yMykg9Ykja6JYGHtcYn+VXQ6wIDcwlVjy+JtygzV5UsIuYK9c2ZqfQc94kI0tKsa9IhrNBZdCpinpd0GS1TahcDIuwyxbO7LzSDm2SPqXuqO8tp1rCeRBUKpIQg/a0HgGeYfGtOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(71200400001)(6486002)(31686004)(76116006)(478600001)(31696002)(86362001)(53546011)(64756008)(122000001)(66446008)(66556008)(66476007)(5660300002)(110136005)(91956017)(2616005)(186003)(41300700001)(8676002)(316002)(38070700005)(2906002)(558084003)(26005)(6506007)(8936002)(36756003)(38100700002)(66946007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU03d3puV0xuNTUxSTNBbmhtZ0gvTmwwL0JhRUpoOU5YRlhSNmU3SEpFSExU?=
 =?utf-8?B?TzB0Y3JMNnZkYmlVVndkQnhub1Q3blBGZU5BZWRRSDZwL0lwNldWSWRIZEh1?=
 =?utf-8?B?K2gvWjNiRmNYamVpb2tpc0w5R2FDNTk1WDRvdTJxYzJOczFLeG1DU1BUUitz?=
 =?utf-8?B?TEIzMWdBdkhnMy9FMjRBK3JMaWpRRXV3ZGU5eVBzY3MwRWVUVkVzcnR6bHFi?=
 =?utf-8?B?d2YvUS9zZE1wdEY3ZFVLZjhqd09yMStEaWkxT3hJWkFkS1pjNjE2OTI4Rzlo?=
 =?utf-8?B?QWZNNDFDYUhEZWs1S253K3EzT2VZODZVM0tzVHVyVUNvaEp0ekVqbk9YeFIw?=
 =?utf-8?B?WW8xOVJMMHhqOEFINEE0bXJoeTVpeDlpNFZrYXF5UEdDVmhQU1p5bXJoRUcv?=
 =?utf-8?B?UjVKa0Vna2VDbHRNQmJ3UDhMRkpBMHprM012SmR4Q0dnd2Z2NzdOL29zSkd6?=
 =?utf-8?B?REVCMXhkT1lseWx0VENKMWxmZ0s3dVYzVklKM3RhanNhSWlXUDlhaWtOSHhY?=
 =?utf-8?B?R1U1YmN3b3g3Vk41cklIYTBLZkQwb2hsL3VsN2UycXdIanVXczVQZkkrdTJM?=
 =?utf-8?B?Ky9rT3prRnF5OWwrTkVSTis3S3hjeSswdEVwcVllcTNENWZlbVlqUHV2UEVU?=
 =?utf-8?B?U0dqVkwwdGhTcXM4am9DZGNxYUlrM1lTTDczaDRZM1hFandQTm5VcVNKSk5z?=
 =?utf-8?B?eVB3NEs0TU1kbUtpWm1aTDhxSlJrN3RXbVpqcXFIWnRhRDA5eVRFbWFYMGt2?=
 =?utf-8?B?azZZcndDZUNLZng1ZENLdXlCeU9SSDNYYkc1cThmUVloU09KVUlJaWFjYytu?=
 =?utf-8?B?L1VzWC9ZRGg3aEJ4NnVOWVRkUmZ4VEFmb2g5MVA2MnJjbGtIeXZMa3hQZ2Fz?=
 =?utf-8?B?NWNYMFhLQmRnSnU3OU9SaHlKZWdEeUVZYjY4STF2WnZUaXVtRHUyYUZtSEo0?=
 =?utf-8?B?VmNkVTM1aFNheFlVNWErYXBZM2d6Mkp0bCtKWUIwcG4xTFYxdW43elIwcGpF?=
 =?utf-8?B?SksxbHZONmRJcWFJaVA1OGd4MjJaUDRLNUI4Tzd6WFduUXdjam1vTUViazJN?=
 =?utf-8?B?U2xkNXdvNXc3eTZXcGlWelhPRzFweURFQ052R3lWeG9yTkxrdThpODU2blJx?=
 =?utf-8?B?blFmWGRiekRHZVBoUXAxUDZIeHRzQTFIY0daZTJUUTRpMGlnbGc2NXlnbWdT?=
 =?utf-8?B?Ky9VWmxIWmNkZHBkYmZQVGZoZWlLamJsM1VzVjBZSDVWZlErNHBDYWNBanZv?=
 =?utf-8?B?NUgwVHpSV1JsRzhHTG5NdFpGanFIdWZ2STExZ1dxbHVaWUhnbFR5bUJFU2FD?=
 =?utf-8?B?cmtoOWVtM1VLR1RlViszSmVmazFHOVExZVY4R0cxRXUzeVpjZkhGM3poMzhH?=
 =?utf-8?B?amxoZjFlcHNFVFl1WHY4RFFmOHR3QVlIaVNQUmRORlUxcittQU9CS3ZzdGN6?=
 =?utf-8?B?MDJ4ZGJUMmUvWjQxbXlPWFZZSG0vQ3hXbTlHbEIwUmtyWkhwYXVxUG1VNFdm?=
 =?utf-8?B?SEtGcXozT0dvL3BHcWRydUQyTUx5TlJGNDBibUZ1NytLTU40bE9qMGkvc2Rj?=
 =?utf-8?B?c0FjaEhLYm1nM0h3cTJHeG5ETy9IbElzZFlJU014MVV0QVErN1JndnpPT0gz?=
 =?utf-8?B?a3lrb3NpbmV5aTN6dE5IeFBXbUdoQVFSL0l3TWRma3BidlNGcHNEY0RzWnB0?=
 =?utf-8?B?eHNDL2tTOFd3Vmg4dFNncy9IaVFBejhMd0xRK05WOUMzVVJPTG9YRXZoUHBm?=
 =?utf-8?B?ZTFZL29uVnBkcjc1RHVhZUhsR2FDZ05STHdKbEo3RWZzVFZDTmQ0ZFVQa0x4?=
 =?utf-8?B?emtqRGp4d2V4dTVwTHNPWXVzZEpPTFVPWm9hQnlpN1dDeWQ5VjF5TEU3eFcx?=
 =?utf-8?B?cEV6eVRocjFGNGg3eno3U05VODJLVDRuRUtUcUdlTUlKMW5Wc1pZZmJCZklL?=
 =?utf-8?B?YThvK2tsQ1BsbUtxWTJRS2xTNFBNWlROdlMwMW94UXhqNWhTak90bCtHUUFI?=
 =?utf-8?B?YTFHLzZLL0d6YmNjbEFINnpqMXpVZVNUcVhNYlZvMVB2b2x3dVFsZm9RckpJ?=
 =?utf-8?B?VEtEeG8rT3AxcG9qNEpxVnN5dnFDT3F0d3VCUmxUZWxDbjd1UFFmQ2oveWRO?=
 =?utf-8?B?WTgrQkRZVHZTMnVnNGdnd0M2ZlN0L0ZKbnFGZzBBeStqR3Z5bGQwWFNuZHVH?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E65C68BC16C40F4385F1D4414AE6227D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2196754-cca9-4e5c-5a92-08dab724e655
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:37:13.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkT/4Ka78e0ezQQomYingpYbg/7EZxEE0GuLIZB+LT0Ojz+OG4WRo2RIvPmmUyjthrefwGPQVl2UmLcCeIG7tf8rMSrmBOpjsJ5EwD5Uj4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMTAuMjAyMiAxMTozMSwgTWloYWkgU2FpbiB3cm90ZToNCj4gVGhlIHNpZ25hbCBuYW1l
IG9mIHBpbiBQQjIgd2l0aCBmdW5jdGlvbiBGIGlzIEZMRVhDT00xMV9JTzENCj4gYXMgaXQgaXMg
ZGVmaW5lZCBpbiB0aGUgZGF0YXNoZWV0Lg0KPiANCj4gRml4ZXM6IDc1NDA2MjllMmZjNyAoIkFS
TTogZHRzOiBhdDkxOiBhZGQgc2FtYTdnNSBTb0MgRFQgYW5kIHNhbWE3ZzUtZWsiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+DQoNCkFwcGxp
ZWQgdG8gYXQ5MS1maXhlcywgdGhhbmtzIQ0K
