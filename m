Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7832A5B5574
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiILHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiILHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:41:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A97313D2B;
        Mon, 12 Sep 2022 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662968463; x=1694504463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TxX/R5vp+n0VJwX6549FSmxOJ5AKy+X4bc53JGFnNzo=;
  b=dfFViXkAYDiscAn12LtExQnmQOdNjCInM14E5pgXChWpESLCuVR/4NRt
   eYbhzWp2xweotvComMVZxMO8NSBsAdrTiAJgYC3C+uLF2mPMyrZLMz5uD
   NcAQk7Su7Ymk21ciKrxMJeSIoCsNPIWnBjyl/W0z0xwd7yoTMNTLFEObv
   WZBzuyUdR9XDJxtFJ2s798fZlHqJs/cxUavWE+wodjsXq7gsNXdhSi2RE
   lP18XGfKcbIwrED1D0Esd5pdRC5RclD3ZJC1P2zUUImWXhNYn/Fx/mcWU
   iWTiDM82WTCkHSvViGl/DFtRlZJaPYldMqb+DnrRQM74qhuU7UDpl2LT7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="179983799"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 00:41:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 00:41:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 12 Sep 2022 00:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik6nVLAbFeM9VTQfEkGjVu5f3LzRsLWajpjTvKfKIg/G9CoF1b/qa5SsmojVm0kfroD80Bl/MEqZEuPqFPOk6F+GXB5/J1M8Z3bLaSYWzCHKvxeEQwvVN6pP/iLl94KJrn2ZAwJG1NoWFa/cSpWqZNlb+oWJ0zfN5EidZA2GADw77WGC0suLX7qeakHPtbKPvlQK3qNOV776Ssnd9khc28f/hueh15kkyqaUuojrGYH2SZvBG4ymvNOcVYUOr82qcLgvdPS8o+wUp3dKGh1thJArVYVpe/DdSxfM9M2t7/Q+/eL7S4oeOHTjO0kG4OODeC9QtezYzkT6D2u8IV4iwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxX/R5vp+n0VJwX6549FSmxOJ5AKy+X4bc53JGFnNzo=;
 b=ifqgWFMRImk/q/6OEiOsJmd5hanhhA+nQer0D+y0awRTSlDbPa5J645hiVEZdq+A3CBAttSDsYyTkHEnMag/r4VRmew3Q3K5VqOoxb8uMvOGPtHeDWWLZhpUsRLySfmMO6M0RRamr6XtIfVx159Utuj1pIqx5dZUoM479Fju9oJrV81okub2EVdl81hDGEuvtMepgpxNgXI1SxtUfa/4gRlc3bCnb9rVyLoSKAvfUzjgGFvqUE21izknmH4WNGq0+BHv73CWr/n4TdEqBRBZzjqzuHhXGM0d9Aqv8CM+Vqb4b8EMm+CK9KikkopJ57XztWMmZoprXgMEcH9Ovba7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxX/R5vp+n0VJwX6549FSmxOJ5AKy+X4bc53JGFnNzo=;
 b=Q32G12Q0p4yKZP7K0XOyBqzl5Tem/KJWDGQ7t1Xv3PSHrPXiQrku8nVN396W97QHuySOp9xGww9zZcE3YIMem15w7TdO0M4fn3ezjH0WnPs2SleO3jh81IjEzPY4xzdMtdQTinR731PjC8GzCYAooA2W1va5i3ccizAwHU/VtCU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 07:40:56 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5612.022; Mon, 12 Sep
 2022 07:40:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <nathan@kernel.org>
Subject: Re: [PATCH v5 01/14] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Topic: [PATCH v5 01/14] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Index: AQHYxnr+LkYxG+U/bEmm+KoIuS7Thg==
Date:   Mon, 12 Sep 2022 07:40:55 +0000
Message-ID: <6399e437-37ed-eaac-22fc-34087ea14083@microchip.com>
References: <20220909123123.2699583-1-conor.dooley@microchip.com>
 <20220909123123.2699583-2-conor.dooley@microchip.com>
In-Reply-To: <20220909123123.2699583-2-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB7303:EE_
x-ms-office365-filtering-correlation-id: 3a99d213-cef2-438f-f96f-08da94922091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiuHUaLMepwl5v/S5UBfcd258hj3i1RBVectut5EjDYT3/uokqQCPIJ6lvcL9mUjOnXlKsYeVEXfErCCej4oJtZOm8um1ObzFtmMJxl3vN8yhvDB+oQXTSDaZ1KUR9nl8rtZDtaXu4bHp1KcBkgXZkQ2yrru2oUp7Fc9AgTE+EkMVpqeQhFflA7YqZ2TMYS87YT4/PMRJ0fa8ar0wRtByIkrHhd0Lwhu+00fsBCewy8MJJ7kOqjllTTdfFbuPNsnlbivUhvnmhPL6ycGowwgC5IPGjvbmD6V8pletKkm2dbgEtZanLx4Nhq7R3xp58n43d1tDU1gdekUtK+LWct7sBiM1ChUDJ+HJAN1pUSbkDbb0Iv/Ni/f+IwH0WftABPuvHMIYjsaGyYgnjLSmFsj5E0jihwnYv3qJBhhcQ/fzr5Mytcwnb+H8k8UiRvasC+AlZO0QujtnJIcqgIQJ7NF4wGfMLcHfiKGPDlbzOQo306p12UaTB3qEK7T7uducvAyBtPRtoYWEAKrj59pXv4ZsoAVyPAxBWolPUj/xdZdDKUK/IGA6Z+Wl09w21f8HGEWWM5kxGD5dL4Ixjy+TUMs8oUBfpDbDkYqhWu1fWcJvsAqKf0PA4/8oOTIjD5/T8tDbal94ks/B954ojORwgsAf5UvVeW8H0Gm+RrqDwxdvCkEe0dmMjEqMVd2yi676XxlDhrqiVQvksFmjteLfzfhrjnxFe8PKd49L4C3llBl1zvtWR9WFx3NFLmzPMKx5V8Ccs8UUOC5T8rftTmjtlcUZ1jlktNAxbNqyaaIY7sxu+K52QeseqRqgzLFmXq6uKy3EaYEME3G+S33knbeL+cx/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(376002)(366004)(39860400002)(2616005)(36756003)(31686004)(186003)(41300700001)(6512007)(2906002)(5660300002)(7416002)(26005)(6506007)(83380400001)(53546011)(8936002)(38100700002)(6486002)(66946007)(8676002)(64756008)(66446008)(66476007)(478600001)(86362001)(76116006)(71200400001)(31696002)(91956017)(122000001)(66556008)(4326008)(38070700005)(45080400002)(54906003)(316002)(6636002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk1wcVU3SFlkbXFLY0NVNlVnMWZBajlMNkVNa0JvM3c1dXlMc1RKNkJiUlRx?=
 =?utf-8?B?QXZwVWFBaFI5NEpRTkNscFZOUEJKb1JqMTR5R1BMT0tmSDNpSDRKYzFITlJS?=
 =?utf-8?B?TzhldG04b1VUWWw0aXk4Y3VyRG5qUnBpVXBMRlhkY3FDV2t5aVFZWWprZzVn?=
 =?utf-8?B?SWYxak9jdjZ2dURDTVYwSHJiVkdJU1doYU5iNzBLamRPUFovbDVpNXpVZlU5?=
 =?utf-8?B?QlU3MTRFaWZhOTdzZHpPdms1N0R5VmFZV3dBWUJVY0RrejFLbXpKQmVBV0pY?=
 =?utf-8?B?WG14U2o0ODM1bFZFR25xdnVBSFJOVEVpQ1hoQWE0bGp0Z2doTzJJOHJ3Misx?=
 =?utf-8?B?STJXU0d3SW5rTXpUU0w1ZSs0RmJpNUIvUDVXRXNZcVAwUVpacHdDaUZiRDdF?=
 =?utf-8?B?bTMyQmREL2VjRGFZdWZmTVhtVFNoOVA3VVdqN2JGc1JNQTBNMEtOUm40UmVl?=
 =?utf-8?B?OEUwTHdjRFRDOXRnT2VCVFYzaHE2WXp3RmlVbU11STZvV01DcUhqSGpiU0Vr?=
 =?utf-8?B?bkRGWWFMRVlMaGNUMVQ2RFh1Rms1L01kbFBhMTNKUm03eDFzTThCUDRXM2Uw?=
 =?utf-8?B?Q0MweWExZitxV3dsdUFjallCV29idU0zb3EyOGthTHF0SGJoVjdvN29GOFU2?=
 =?utf-8?B?U3BRc0N0M2xqMDZUOFY4TS80T09pZWRBZEJVRXRaL3ozdGhQV0tQRGthN0N2?=
 =?utf-8?B?WlA4UmRaU283TzgyVnNkaDNNWlRKSmtvR3B2THBqWllEZTFYVW9IVnZmam9p?=
 =?utf-8?B?RGVsc21ENzEzUFdjRFd4OTFaeGpCYjNVNjJVZ2ZTY3R4OW1pbDN2N3ZTNWg4?=
 =?utf-8?B?OFRhTy9nU0lYbEd2U0xBcDNVYXU5OHVGTExSNExKMjJCS0xZRExqdVBmdzZP?=
 =?utf-8?B?SjUxYVlDOVFheDlPZlZBeDdNK292ZGtOOThBRTFqZmduQjJSSHhlcVZEMEJr?=
 =?utf-8?B?WVJheFJXNHhzd2cvRU5CenZNbk9DRUxZc0l6YzY3REE1Znd0RllXQ2R5N3NK?=
 =?utf-8?B?c2VRQW1XN09DbVVFSGtaN0ZKSjVzcDMxVHpNWUVybWM0WWVTZVVtZU9pU1Az?=
 =?utf-8?B?L2dvL25iaVJQUUljeTdrT2lOZGxqa3VyRzJOU1Q0dXNoT1MvVFN2Nkt2MHVt?=
 =?utf-8?B?Smlpc3E3SjlvQ1Z2RlF0ZUxremswVWdnd1k3WGluR1ZSTHBMbUhKanM2V2FB?=
 =?utf-8?B?RGJzaUdCOGZ6RW4vUm5xQkpyRkl6MTJLV3E0UHJJcitGdGZLS1UyQ3VWbXdu?=
 =?utf-8?B?QklQWGJxQ3NJT2RPK3dMK1lsOE5sWlFzcDY5bHc2WElObmI0Tlp5bGJVeXpY?=
 =?utf-8?B?NUtoS0VTNDh6UmZSbkJ1c29EYnFLcVZJVGlXdFdjSitxMzNvTERuRkRJZTNL?=
 =?utf-8?B?cDBZMnhObmM4OGxFKzVSdWhtR1p6MWFSbEZSOUhQU2JkSW5aZDlrMFYwa2hv?=
 =?utf-8?B?RmV1UEo2dytiMllJVlhPRk9adXNpSko0SFAzcWl1WTNzU0RhU0FFSkJWQ0o5?=
 =?utf-8?B?T0RWY0pFUzAxVHRHL2FPL0w0SW94R2pXcmwreWEvZ3hpK2ZUSFpkajFFQWlv?=
 =?utf-8?B?dGdGNEtYSE9QTUJWK3Z0Uk4vUzhiOUIvZXVZNlpXaFZzV2dIZVJqNmNsWWhZ?=
 =?utf-8?B?SHdjSENxTUUyUTBUSngyZkJBcnBucitkNjZNSEJ3dXdQdGpvSkFaYzlsMkQz?=
 =?utf-8?B?eVR2K1Zqb2ZBZEJNQWZOaFFVLy9NZlVKWURVTTg4NnhMZDNoZ0l1N1I0bFdi?=
 =?utf-8?B?SDJlQzlrRVBlNFhZSkVCWThmMHA0MlE2V1NqREI3VXE5UmthVkdGcXhTZysy?=
 =?utf-8?B?TmY4RXpUZVdNRE1kcDJoeExjSVM2SkhLN2IzbjhRdi90RkduaUgzRE9CNjB1?=
 =?utf-8?B?NGp3eEVGRlduUkpUbjkyQ0pvWFd5aWJnRzkxSVpqRExXcEV1anZmWW9ORmxC?=
 =?utf-8?B?c01mbHlpSmxVNGd4UDROODNrZ084YlJxamcxK3Y3YURadlhBaW53SXZzUGZV?=
 =?utf-8?B?S0hFSjJiMnhucytLalpQUWhqKzRGRlFhOCtWbUJNdWlpOUFJWkh1R1U3ZmN5?=
 =?utf-8?B?YlhvTDVZYitNY011eXd5QTkwb3h1TUlwa1FoZ2YrYVBBV25XYlJCaytZcmJB?=
 =?utf-8?Q?Grrf0ea/2OVg3ZNH40wjtF5lr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CDA6FC939FF9B4FAEA8A69518704630@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a99d213-cef2-438f-f96f-08da94922091
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:40:55.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vieaTbJhsAT1sEswDlekewA4QxxEoGW8Hll6rRzUXQIkvd02C7D+qcPjJPCs9c6tmCA5GRFl3DriZPweVW//Le/7SLVV9mj7A0IzuKUBgdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDkuMjAyMiAxNTozMSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGVyZSBpcyBhbiBh
cnJheSBib3VuZHMgdmlvbGF0aW9uIHByZXNlbnQgZHVyaW5nIGNsb2NrIHJlZ2lzdHJhdGlvbiwN
Cj4gdHJpZ2dlcmVkIGJ5IGN1cnJlbnQgY29kZSBieSBvbmx5IHNwZWNpZmljIHRvb2xjaGFpbnMu
IFRoaXMgc2VlbXMgdG8NCj4gZmFpbCBncmFjZWZ1bGx5IGluIHY2LjAtcmMxLCB1c2luZyBhIHRv
b2xjaGFpbiBidWlsZCBmcm9tIHRoZSByaXNjdi0NCj4gZ251LXRvb2xjaGFpbiByZXBvIGFuZCB3
aXRoIGNsYW5nLTE1LCBhbmQgbGlmZSBjYXJyaWVzIG9uLiBXaGlsZQ0KPiBjb252ZXJ0aW5nIHRo
ZSBkcml2ZXIgdG8gdXNlIHN0YW5kYXJkIGNsb2NrIHN0cnVjdHMvb3BzLCBrZXJuZWwgcGFuaWNz
DQo+IHdlcmUgc2VlbiBkdXJpbmcgYm9vdCB3aGVuIGJ1aWx0IHdpdGggY2xhbmctMTU6DQo+IA0K
PiBbICAgIDAuNTgxNzU0XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwYjENCj4gWyAgICAwLjU5
MTUyMF0gT29wcyBbIzFdDQo+IFsgICAgMC41OTQwNDVdIE1vZHVsZXMgbGlua2VkIGluOg0KPiBb
ICAgIDAuNTk3NDM1XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2
LjAuMC1yYzEtMDAwMTEtZzhlMTQ1OWNmNGVjYSAjMQ0KPiBbICAgIDAuNjA2MTg4XSBIYXJkd2Fy
ZSBuYW1lOiBNaWNyb2NoaXAgUG9sYXJGaXJlLVNvQyBJY2ljbGUgS2l0IChEVCkNCj4gWyAgICAw
LjYxMzAxMl0gZXBjIDogX19jbGtfcmVnaXN0ZXIrMHg0YTYvMHg4NWMNCj4gWyAgICAwLjYxNzc1
OV0gIHJhIDogX19jbGtfcmVnaXN0ZXIrMHg0OWUvMHg4NWMNCj4gWyAgICAwLjYyMjQ4OV0gZXBj
IDogZmZmZmZmZmY4MDNmYWY3YyByYSA6IGZmZmZmZmZmODAzZmFmNzQgc3AgOiBmZmZmZmZjODA0
MDBiNzIwDQo+IFsgICAgMC42MzA0NjZdICBncCA6IGZmZmZmZmZmODEwZTkzZjggdHAgOiBmZmZm
ZmZlNzdmZTYwMDAwIHQwIDogZmZmZmZmZTc3ZmZiMzgwMA0KPiBbICAgIDAuNjM4NDQzXSAgdDEg
OiAwMDAwMDAwMDAwMDAwMDBhIHQyIDogZmZmZmZmZmZmZmZmZmZmZiBzMCA6IGZmZmZmZmM4MDQw
MGI3YzANCj4gWyAgICAwLjY0NjQyMF0gIHMxIDogMDAwMDAwMDAwMDAwMDAwMSBhMCA6IDAwMDAw
MDAwMDAwMDAwMDEgYTEgOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMC42NTQzOTZdICBhMiA6
IDAwMDAwMDAwMDAwMDAwMDEgYTMgOiAwMDAwMDAwMDAwMDAwMDAwIGE0IDogMDAwMDAwMDAwMDAw
MDAwMA0KPiBbICAgIDAuNjYyMzczXSAgYTUgOiBmZmZmZmZmZjgwM2E1ODEwIGE2IDogMDAwMDAw
MDIwMDAwMDAyMiBhNyA6IDAwMDAwMDAwMDAwMDAwMDYNCj4gWyAgICAwLjY3MDM1MF0gIHMyIDog
ZmZmZmZmZmY4MTA5OWQ0OCBzMyA6IGZmZmZmZmZmODBkNmUyOGUgczQgOiAwMDAwMDAwMDAwMDAw
MDI4DQo+IFsgICAgMC42NzgzMjddICBzNSA6IGZmZmZmZmZmODEwZWQzYzggczYgOiBmZmZmZmZm
ZjgxMGVkM2QwIHM3IDogZmZmZmZmZTc3ZmZiYzEwMA0KPiBbICAgIDAuNjg2MzA0XSAgczggOiBm
ZmZmZmZlNzdmZmIxNTQwIHM5IDogZmZmZmZmZTc3ZmZiMTU0MCBzMTA6IDAwMDAwMDAwMDAwMDAw
MDgNCj4gWyAgICAwLjY5NDI4MV0gIHMxMTogMDAwMDAwMDAwMDAwMDAwMCB0MyA6IDAwMDAwMDAw
MDAwMDAwYzYgdDQgOiAwMDAwMDAwMDAwMDAwMDA3DQo+IFsgICAgMC43MDIyNThdICB0NSA6IGZm
ZmZmZmZmODEwYzc4YzAgdDYgOiBmZmZmZmZlNzdmZjg4Y2QwDQo+IFsgICAgMC43MDgxMjVdIHN0
YXR1czogMDAwMDAwMDIwMDAwMDEyMCBiYWRhZGRyOiAwMDAwMDAwMDAwMDAwMGIxIGNhdXNlOiAw
MDAwMDAwMDAwMDAwMDBkDQo+IFsgICAgMC43MTY4NjldIFs8ZmZmZmZmZmY4MDNmYjg5Mj5dIGRl
dm1fY2xrX2h3X3JlZ2lzdGVyKzB4NjIvMHhhYQ0KPiBbICAgIDAuNzIzNDIwXSBbPGZmZmZmZmZm
ODA0MDM0MTI+XSBtcGZzX2Nsa19wcm9iZSsweDFlMC8weDI0NA0KPiANCj4gSW4gdjYuMC1yYzEg
YW5kIGxhdGVyLCB0aGlzIGlzc3VlIGlzIHZpc2libGUgd2l0aG91dCB0aGUgZm9sbG93IG9uDQo+
IHBhdGNoZXMgZG9pbmcgdGhlIGNvbnZlcnNpb24gdXNpbmcgdG9vbGNoYWlucyBwcm92aWRlZCBi
eSBvdXIgWW9jdG8NCj4gbWV0YSBsYXllciB0b28uDQo+IA0KPiBJdCBmYWlscyBvbiAiY2xrX3Bl
cmlwaF90aW1lciIgLSB3aGljaCB1c2VzIGEgZGlmZmVyZW50IHBhcmVudCwgdGhhdCBpdA0KPiB0
cmllcyB0byBmaW5kIHVzaW5nIHRoZSBtYWNybzoNCj4gXCNkZWZpbmUgUEFSRU5UX0NMSyhQQVJF
TlQpICgmbXBmc19jZmdfY2xrc1tDTEtfIyNQQVJFTlRdLmNmZy5odykNCj4gDQo+IElmIHBhcmVu
dCBpcyBSVENSRUYsIHNvIHRoZSBtYWNybyBiZWNvbWVzOiAmbXBmc19jZmdfY2xrc1szM10uY2Zn
Lmh3DQo+IHdoaWNoIGlzIHdlbGwgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGFycmF5LiBBbWF6aW5n
bHksIGJ1aWxkcyB3aXRoIEdDQw0KPiAxMS4xIHNlZSBubyBwcm9ibGVtIGhlcmUsIGJvb3Rpbmcg
Y29ycmVjdGx5IGFuZCBob29raW5nIHRoZSBwYXJlbnQgdXANCj4gZXRjLiBCdWlsZHMgd2l0aCBj
bGFuZy0xNSBkbyBub3QsIHdpdGggdGhlIGFib3ZlIHBhbmljLg0KPiANCj4gQ2hhbmdlIHRoZSBt
YWNybyB0byB1c2Ugc3BlY2lmaWMgb2Zmc2V0cyBkZXBlbmRpbmcgb24gdGhlIHBhcmVudCByYXRo
ZXINCj4gdGhhbiB0aGUgZHQtYmluZGluZydzIGNsb2NrIElEcy4NCj4gDQo+IEZpeGVzOiAxYzZh
N2VhMzJiOGMgKCJjbGs6IG1pY3JvY2hpcDogbXBmczogYWRkIFJUQ1JFRiBjbG9jayBjb250cm9s
IikNCj4gQ0M6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0K
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYyB8IDcgKysrKysr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jIGIvZHJpdmVy
cy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMNCj4gaW5kZXggMDcwYzNiODk2NTU5Li5mMGY5Yzlh
MWNjNDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+
ICsrKyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+IEBAIC0yMzksNiArMjM5
LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX29wcyBtcGZzX2Nsa19jZmdfb3BzID0gew0K
PiAgCS5ody5pbml0ID0gQ0xLX0hXX0lOSVQoX25hbWUsIF9wYXJlbnQsICZtcGZzX2Nsa19jZmdf
b3BzLCAwKSwJCQlcDQo+ICB9DQo+ICANCj4gKyNkZWZpbmUgQ0xLX0NQVV9PRkZTRVQJCTB1DQo+
ICsjZGVmaW5lIENMS19BWElfT0ZGU0VUCQkxdQ0KPiArI2RlZmluZSBDTEtfQUhCX09GRlNFVAkJ
MnUNCj4gKyNkZWZpbmUgQ0xLX1JUQ1JFRl9PRkZTRVQJM3UNCj4gKw0KPiAgc3RhdGljIHN0cnVj
dCBtcGZzX2NmZ19od19jbG9jayBtcGZzX2NmZ19jbGtzW10gPSB7DQo+ICAJQ0xLX0NGRyhDTEtf
Q1BVLCAiY2xrX2NwdSIsICJjbGtfbXNzcGxsIiwgMCwgMiwgbXBmc19kaXZfY3B1X2F4aV90YWJs
ZSwgMCwNCj4gIAkJUkVHX0NMT0NLX0NPTkZJR19DUiksDQo+IEBAIC0zNjIsNyArMzY3LDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIG1wZnNfcGVyaXBoX2Nsa19vcHMgPSB7DQo+ICAJ
CQkJICBfZmxhZ3MpLAkJCQkJXA0KPiAgfQ0KPiAgDQo+IC0jZGVmaW5lIFBBUkVOVF9DTEsoUEFS
RU5UKSAoJm1wZnNfY2ZnX2Nsa3NbQ0xLXyMjUEFSRU5UXS5odykNCj4gKyNkZWZpbmUgUEFSRU5U
X0NMSyhQQVJFTlQpICgmbXBmc19jZmdfY2xrc1tDTEtfIyNQQVJFTlQjI19PRkZTRVRdLmh3KQ0K
PiAgDQo+ICAvKg0KPiAgICogQ3JpdGljYWwgY2xvY2tzOg0KDQo=
