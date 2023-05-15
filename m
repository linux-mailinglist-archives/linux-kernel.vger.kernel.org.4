Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA070271F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjEOI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjEOIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:24:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40E1725;
        Mon, 15 May 2023 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684138900; x=1715674900;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Se9nIaCiEFPopEV5zYh2yiv2/5YaAXHopj0Bt5mekAs=;
  b=P0/4kiZVatV556lrtTH9ZzcX3pQ+W5IIq/aR3gV7xBziqwy1XlCjA9X7
   kUPTG7Y7zRfAzLKZsxQeRfkH1RVpt1PACeyhGrc+DXZmCrZYn+HA6iQAw
   pKYLtQJqHWn3uZWjeULMHjTbwCUfAFu1dOZzf8Idb/FVAVUDQppnFHntZ
   kgqa6R54V+GubKapofXubIzW8DbYF4On6eOEZ8GNh/xc8rf88x6KJt0ze
   gW8sDrx+4CdgWeptG3MfsKbu7MWYeMH6F+JmYvrFquuaeeV2dj14EfB0B
   stk1nWHawdGlMF9KmaxO39knU/NXcG5u6GqNElHo5ETGJ7yVs97HV/4ld
   g==;
X-IronPort-AV: E=Sophos;i="5.99,276,1677567600"; 
   d="scan'208";a="211257208"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 01:21:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 01:21:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 15 May 2023 01:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5XgxT7s9XiGQEos8M5wXzX09JqWeoeDntXT4y4/zA85qeLoIlaA0+/HLsCLjM90SLoROvHcR82TdjF0HgAPG+DldkY9sNzRxwnMeZpRJN/drk+BvOtZGDNcHAMdaw3ZdX3ATGMwySTz0qaqOpBWZNCW4hnYfW9eyLhnxc/Mlkp7Z1DsZkfosGnOPLXZDarC4HUmg/DF8y+rOHgut2S8nvcmT32PiDi0ctWlpFku463W+Y4dTxRHrblnx2ftIL55N4qham2EZPdZqxrbuPuzSJWfLnjN02EOaIfzBGNV3deqfnbB2yichz11OwyaYlI9YzCKVi9E8O4pVhyfO5wiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se9nIaCiEFPopEV5zYh2yiv2/5YaAXHopj0Bt5mekAs=;
 b=YG8EVKCkiOsjo982+kU7X8mE6fJpPUD4dxsa/2QDHtC/pyHDXvyjkZTDq8+NWLPBsxLK9U0dDBzq9Wgp937nHyzGVWx1GxDSci15UtcpcrP4rIzPsGccwa4AW06QeHSGcohPbb0Z5GUoYinTFH8Bwz4CPCVHSnTdw+RvdpT1tyWIwjSdNxZD4xwIt/C59cuyzzgiCmaMS4wbiMdYUOt2MP/kbPaItWA9X1o+1RpByIKfb67E2+aiM8TdtVXk7667z9JhY9cr71n8xpNPA3td+MxaO6/0ytKdab4WryqYlMWYypfYeO8zUp2QjSQQtnu8DGfg12KlE7hocxyM/Ne1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se9nIaCiEFPopEV5zYh2yiv2/5YaAXHopj0Bt5mekAs=;
 b=Pkyo4el5lBP7b7wFzezv/0Y+4HBxoyt2Ny2tdLqqPAaUjhoDNr45xuGQztDR15c92bQwU9oMp1dDGyZ7oFXgBenDJCxVKPJ/eLrgnm9U68jjIev+VTkzxDyi+K02CDzROl+mMDc+NlDuqmsXlSDvVFPE/4ZmZOVFWjF17ni4XIU=
Received: from BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 08:21:36 +0000
Received: from BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::757c:ccb5:849b:d2ef]) by BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::757c:ccb5:849b:d2ef%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:21:36 +0000
From:   <Ryan.Wanner@microchip.com>
To:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: GPIO set config argument value difference in pinconf and gpiolib
Thread-Topic: GPIO set config argument value difference in pinconf and gpiolib
Thread-Index: AQHZhwZD75zKccfm/UWi9E6gLwyI6Q==
Date:   Mon, 15 May 2023 08:21:35 +0000
Message-ID: <120117b6-feda-e7aa-4f09-a126a0747388@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2657:EE_|MW3PR11MB4729:EE_
x-ms-office365-filtering-correlation-id: 4321437a-399a-4ebe-97bc-08db551d6622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EPEEwfvcV5LDrcdekDI9RxVFXaZo2+C7JOjNP3aX6pnuUmfo5z3g/6Pmku/dd3+JkERD86zSVi+CkEZWCnY37kaMFP8ji03YHDwMRARwh9sFsavmSvlIc2nuMocxtIIbbgHf/ccScXCK39AZoQKTZL7SjWB7CDdK4sgECCNAXMyPzcMiGCtyiBE63H83hlqTROMd5hsUS227XF5CLnZzuRcJ6FNMyukK4zQ8okkE0LiNnzstI5k/pf1v1Ywimgd5gHjqZzaX+KjD4+IrKiKEfAqE7eu3HfhgpOIYfp7mJdCu3ew0B4Ft61Zt5SSqUhlVhps3GUmaVfxguZrZ3aGYnv+kxeGWzCsv2A4P0pygLqLOQ3xO0Z3wDCToIO9c1E+w7ciZai9o65ArdbEWWfjP+OI3ATTIIAWCSGZFVijIVOjw3cxGcJXOHMYqG0WxFcV2F23OlBHiR7YVFyOKhbK/5Pa+wy6zaO0u7oRHKT9tGpu4m09drqM6FG9qlV25tVIMjY8q3hJ8tuEzEv3yAaCTNrDZjgxm0Fb38vgg1Fnb5XrgnYboCh1LgBvFxCz9vcyXAwqHFYv3kh7sSBMdiZPiQUrAeCnL6j4YRDgCb4cMNV1YnU43G4OmvtPoPoqPVmx9eWL0o340w9rlhLDhjFpeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(31686004)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(478600001)(6486002)(76116006)(86362001)(91956017)(316002)(54906003)(110136005)(36756003)(83380400001)(107886003)(186003)(26005)(6512007)(2616005)(6506007)(71200400001)(41300700001)(8936002)(8676002)(5660300002)(4744005)(2906002)(31696002)(122000001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVk5Tko4TmJSWU4yRzl1YmVxNzlSUkg3QTFWYlVUV3lDbXMwQU9WS0NHOHVD?=
 =?utf-8?B?QzdIejEwNFBQTGg3aFg5a21Kd2E2dU13UG5ieUpLZUcwQnpKbjRYNCt0MUJT?=
 =?utf-8?B?Ykd5Zmx1QUdIUHZ0a2NIUlNPUEwycFJ6bGhlTW9ieS9JZFRyb2ZnRUp2RkY3?=
 =?utf-8?B?VDZFYXpSYldjUVBsYjFOYmsvdlE5Z3l2c0xZTlEvNEJaczgzWFhsRVczcG9t?=
 =?utf-8?B?QlZZK0Y0ZG9SbzRWMkVNemVTTlpIR05LZitzc08wQjhHRGQvcU8yNUVRcjB3?=
 =?utf-8?B?WXZQQzNXeC9BcXI1WjVsdkZaaFBqdUY1aUFLNHdDbmZlVzlFem9UWnU3VEhS?=
 =?utf-8?B?dXlFZGw2VmQrelUwQlQ1UXc3UitYSitQSkVLREFQaDVqcXUxd1Z6aXZ1R1RL?=
 =?utf-8?B?c3M4M0RqVkhFOUdKenpUZlZXbHBkZjZ4UEJzcVZ0d1Z4K1dhZUVoSmxtTFNl?=
 =?utf-8?B?TWkyZk9FaDBOVGJXRmYxbjhmZkxrR0s5L29rQzNDMzdGeVVHcER1MkE3a3My?=
 =?utf-8?B?U3Z4TXFFbzFYMVFBMzRRcDUrWUU1d2pOUVNRSVdyblR1N1VpdVp3TExMd1I5?=
 =?utf-8?B?VTF2blpodW9QNG82UEVwMDJZaGNRQlllL2toQkNJOWdXR1RUR2NlL20xNnF0?=
 =?utf-8?B?aVdQUVgyN3ZMQVRXNU5lRUhPak1mb29WM2xLK1p3VDlsRktOZUUrOHRWSHk0?=
 =?utf-8?B?R2hPcjN6SkRId0kwT3JndlZxSUt1WG9vSXFZN1dtam1zQXVTcWVwZEh0djlE?=
 =?utf-8?B?VU5YTS9VS2xGazdoUXl2V0cvK1dCK3l1eUJac00ram1ETlU3TjB6aEt4d3pQ?=
 =?utf-8?B?a0doUTk3TmllalVrYjNQT0NNYk4yaFhtMzRhRlRRaHgvSCt1YUxlbEU1azJC?=
 =?utf-8?B?NCtZZWg0MWh3WjI5Ym93V2JHZFFsaWEySnZsSzVRNHVpVjhjSlJqYTdpWmEy?=
 =?utf-8?B?VVhoV1pwMEFueHEzTmw5blpoUUd1ZGI2YjQ1ZU1ZL1krTEQ4ZlZPd3kzYlB3?=
 =?utf-8?B?aTVXVnJ1dkFPM0UzRHNlcXNPTjZ6YXByRkVHNWRobWhNSzFkTnhlL211bkUx?=
 =?utf-8?B?b1VLdXlzVEpsMkRIdzZyQWJjQ0YxbzUxeVZRdEFOWndreHRaSDFtSElLZ3pP?=
 =?utf-8?B?QjExeC8vQjZzQzJZbll4UnFTNDIzL0xkZGZndmo3Z0Z2K2NPdVYxc0h3SytI?=
 =?utf-8?B?b1YxRUpCeUp6QzEzb1VONDBUcHRxZFZVaVZ6WFlETC9QekV4Ulhia0g5TzBV?=
 =?utf-8?B?V2pMOFM0S0FVMXFlY2tTcmQyWEtISytlN2c2cko5L0NnL1ZZTDl4UmRmSDJQ?=
 =?utf-8?B?eUdrMnNwTVNIeHh2bDdYMW5TZEo1Zis2bHFKQVY4bHdoNGpKcDhKUkltNnpZ?=
 =?utf-8?B?ZVoyTGp4WFhXalN4azJFdTh3aFpZMmZyWW1xK1kzN1RkckxjQk15YXNBYWo0?=
 =?utf-8?B?dlFZd1p5R0xwYXhwVHNJOWZXTnFla0xWRGZpemFKUHB4eU5ieTJoTHJzWVhI?=
 =?utf-8?B?MCtRd1dkdUFoTnpGWDA3TlNvemw0TzZPTDhib1ZXTnZPcURGYWQyVUhNbjVF?=
 =?utf-8?B?MjVGZWVjQmtHRFdrM3hmN0E2ckZUWC9RQTAwR0NOMXFpZTlZd1kwdmFWSlZE?=
 =?utf-8?B?S2k2U2RBZWNoMVlSdmlaRnFsNVkrZndYVWFOYmlMTlFyUElxV1pMY2cxS3I0?=
 =?utf-8?B?NzdsTEtQV1JNR3k2QTRtdkFaTWYrYjgxOEowN0dRRjJnWVpYREgyejNTZEdr?=
 =?utf-8?B?SXI5VlYvam9jdCtjcG1oc21wK25DajZ3aWlEZHl3S3FzUHY3Qi81RzhSOE1u?=
 =?utf-8?B?SmExVVd6elo3MzR3Q0UrdzBuVW90SFZ4K280QVMzU25TWmVaQ0svQnlDSnAy?=
 =?utf-8?B?V0xnTVVET0RNYndJcmhlQjRYYVl5dDFCei9UNmplczRsSHhBWVJYU1NGWXRR?=
 =?utf-8?B?a3IzUGFUd3doTkllK3M0N2M2SlNscWdqZ05GbzdybyswR0tlZWNQVTBTZ29E?=
 =?utf-8?B?OW1HamhIbU5hQ3BZWEJ4R052d3EraGlYaGUxY1ZmT1dtczhuckIzV2lkcG0r?=
 =?utf-8?B?SUp0S3hpUlhzVnBCWkFScWZPM2pkTlNqSjJyb0cxY2JhNTFFZHk5ZWkwNTY3?=
 =?utf-8?Q?7XOI7kRux/GUALQcoIPmwRng1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <382D0F3BC1D74B4E9E5F427838413546@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4321437a-399a-4ebe-97bc-08db551d6622
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 08:21:35.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2qx1r2KXbuXpEcnpfO3YvszbzZqbPFHSoJfR+vIkIsM1n/tVjLT4W9AMniOpp/2IkyuT148tvIFQw2AlDnT+AWBV+NQGrPlHI+pk/SUeO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0IGdwaW9jaGlwX2dlbmVyaWNfY29uZmln
IGZ1bmN0aW9uLiBJIG5vdGljZWQgd2hlbg0KY2FsbGluZyB0aGlzIGZ1bmN0aW9uIHRoZSBwaW4g
Y29uZmlndXJhdGlvbiBpcyBpbmNvcnJlY3QgZm9yDQpwdXNoLXB1bGwvb3Blbi1kcmFpbiBpbiBw
aW5jdHJsLWF0OTEtcGlvNC4gSSB0cmFjZWQgdGhpcyBkb3duIHRvIGENCmFyZ3VtZW50IHZhbHVl
IHRoYXQgaXMgaW5jb3JyZWN0LCB0aGlzIGlzIGV4dHJhY3RlZCBmcm9tIHRoZSBjb25maWcNCnVz
aW5nIHBpbmNvbmZfdG9fY29uZmlnX2FyZ3VtZW50LiBUaGUgcGluY3RybCBkcml2ZXIgcHJvY2Vz
c2VzIHRoaXMNCmNvbmZpZyBhcmd1bWVudCB2YWx1ZSBjb3JyZWN0bHkgYnV0IHdoZW4gZ3Bpb2xp
YiBjYWxscyB0aGlzIGZ1bmN0aW9uDQp0aGF0IHZhbHVlIGlzIG5vdCBwYXNzZWQgY2F1c2luZyB0
aGUgYXJndW1lbnQgdG8gYmUgMCBpbiB0aGUgZnVuY3Rpb24NCmF0bWVsX2NvbmZfcGluX2NvbmZp
Z19ncm91cF9zZXQuIEkgc2VlIHRoaXMgc2FtZSBzdHJ1Y3R1cmUgaW4gb3RoZXINCnBpbmN0cmwg
ZHJpdmVycyBhcyB3ZWxsLg0KDQpJdCBzZWVtcyB0aGF0IGdwaW9fc2V0X2NvbmZpZyBpcyBjYWxs
ZWQgd2hpY2ggaGFyZCBjb2RlcyAwIGludG8NCmdwaW9fc2V0X2NvbmZpZ193aXRoX2FydWdtZW50
IGZ1bmN0aW9uIGNhbGwgbWFraW5nIHRoZSBhcmd1bWVudCAwIHdoZW4NCnBhc3NlZCBpbnRvIHRo
ZSBwaW5jdHJsIHNldCBjb25maWcgZnVuY3Rpb24uIEl0IHNlZW1zIHRoYXQgdGhlIGNvcnJlY3QN
CndheSB3b3VsZCB0byBtaW1pYyB0aGUgZ3Bpb19zZXRfYmlhcyBmdW5jdGlvbiBoYW5kbGluZyBv
ZiB0aGlzIGFyZ3VtZW50DQp2YWx1ZS4gRG9pbmcgYSBzbWFsbCBsb2NhbCB0ZXN0IHNlZW1zIHRv
IGNvbmZpcm0gbXkgc3VnZ2VzdGlvbi4NCg0KQmVzdCwNClJ5YW4gV2FubmVyDQoNCg==
