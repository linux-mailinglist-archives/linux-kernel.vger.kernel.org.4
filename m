Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F736A56C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjB1KbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjB1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:31:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D1B40CC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677580253; x=1709116253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VmT7XEpDBFZlRFjOxza423jQWekFVM/pQp50EUoglQU=;
  b=0d+otIWtZbE/mFGG/1BpSzsJXimkCo9q+u3qPXYoinYY/UhKtDI7OUuc
   JL1jkA1Ld1toEFJZfPg6V2TWpttBOvF3p8qf3bKPVgrbpRXDmraYjsuqi
   2m/H084r4uP9xTzf7tTHeBeUD8WEFsxgCrlDXZQTrbw6WAir5iagVxCQ2
   a/p5UZuGI2tpM1AdDdg8AUVW7SU+5YoX1BVSq8uTUXRkUesZZ0t8zArcr
   tU/0S1MDf4uRLtBDBpQYUqJm7T3Davsa/RLi3ggex6FDjt1RpZ5kSAyLO
   dWAst7gxDcLyHPAHu7dadD8F16r6XdZrLOz8eoMvkIDEXXBtZeKI0JuAG
   w==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673938800"; 
   d="scan'208";a="139415665"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2023 03:30:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 03:30:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 03:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPBsYJSAy3ARuVBVHCOb7sg6jPe7cTXYSty3y64d+kjjm0atu7vDiydRDkK3qBRX6qMV/IqQyThzwagC0qZbxSTmAYzSzae/VPmhfJ8WF1L6R0l8L+qRMDzIoWTiWx1SRsRqNGYkTZlxIV5xJF6miK404wUcl/NQ2NRmrwVt7wOHGIvXQoqK0vA13kGTfPf4TnOisxjVNKiD4wYaHorsRMVasd10OmsgxnpNKDXpKi4Bb8dyF7WuOMvbIH5HneM9GKvTImuWBbFZZy3HNp/cC2ihfzerbh5Nt+8I+4PRh+GFzaj5/yx9NWVoCee0TEw5LJiIXE9ZV1d7Nec2zHAprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmT7XEpDBFZlRFjOxza423jQWekFVM/pQp50EUoglQU=;
 b=cHB8SoAXu122IZbaSIkabKw+/01Wg5tngHC/7zFVKp9FNTrjTU+KvRkFsWeMXkO/7Rn7kxAxzCaunS9SYPo/mr+PfU5CqiSuotP6/JWlkaVzhgBsNRG0RQn5tSblOHP1u01pFsdxIwV16n5hpKFdA53nccFCXuOUiWXbFdzsEkw4y9xGu3UVtAgknWhy38MPkDYq425XDWHnHH9LjMI+zPV694aGAHoM/sGjC7WTMubUQApKiu3/lyTWitHNKJ5fnvYR0YplqFh1LcHpTsZsYj+1tQFgrdDsFGy8iF3WH6YfY7S1z2wt3AGIMs9fTIZlUZtnykTWChFzS+2nVp5mCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmT7XEpDBFZlRFjOxza423jQWekFVM/pQp50EUoglQU=;
 b=JgGYCaZLyjoj87cHS+juvOmBsludxDEnBfiXj3g5Qeu+UJdugFrWRQd7GGljXuaACCBSIpQVRcGTMzHxlNrX6SCIOiscZnTS1AJn0XK8tHzrPZsSnnzhfQe1nel0M7Yrd9c9beeTHZTxRqLYk39/+LQRhee8veBci2eQnGmZ58o=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 10:30:51 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 10:30:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Vijendar.Mukunda@amd.com>, <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 6/8] soundwire: amd: add runtime pm ops for AMD
 SoundWire manager driver
Thread-Topic: [PATCH V4 6/8] soundwire: amd: add runtime pm ops for AMD
 SoundWire manager driver
Thread-Index: AQHZS1+6zUAkvAEt10e5bJaR24xWIA==
Date:   Tue, 28 Feb 2023 10:30:50 +0000
Message-ID: <cc6ab93b-c964-8bf8-db60-ac20aa0a3006@microchip.com>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-7-Vijendar.Mukunda@amd.com>
In-Reply-To: <20230227154801.50319-7-Vijendar.Mukunda@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB5941:EE_
x-ms-office365-filtering-correlation-id: ea9af9c5-3759-42f4-4089-08db1976dccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FG71+vWsU/FEC4hqbKUHXemikR7Cl4x86eqC/rS/a+y+pVJuble91T1tu1dBDwBSRGVSCxElbGxpOXE/HajBJS9xjBhzWALAdAflBcnTIC8f3q5NB/4Al4Ul2tOqlAPwiokc81LEGX4XxQYGQkdW59u3VJMTblJP5YhdacUDPV0okODPneGT3v6FEC0iBmeg2Zqb7J6P6ObPTOzkdED4rFmr1RMOM15qr/HkP+FIrfGwbl3f408Vcu9UPd7Egssc6JDR6lwZ2HnWCjLdVJsP657DVtBUTuWaD11xG9qBslrevwCOUqI3PDwwhdVWj1Q4RqnUo34A2LrzyOsO3J2M4Uj8NWawPcaoqYHwXhp5m2QkJSB+0Tx9FryTOXtHwiJXGlqUcpSOWQT8B6yVvBXHPc7W+huon0iwy/yfiXVfhLZpjLo9BvbVvG6rS1hptamW1TuSrEivs1P6mjooQMnfLKtDnbaW8VwEovS/2GQbEaEfySJztzMGLVIEF46GffK5oLU8O1MXYSfgArYBhRa4OJeNgOgJt4k30EyL4vDP9LgoGhLpssR0NKqMO6b/HjlLIWa0E7yvY43+Fqn7si5uo7ICsKdgYrHqBGiU1aOz0BrtYsoEzZulxqi9PZlhXCfPzjf5Kz1x8PDlEMVf2PG6Gm5d9O0Ib3Ws+CffpjrguNMv+ThdQCNQTJFfaLt87GPX0ho5CgvLBYd4H/9GhDJ4HykO/6x1D/+Zj6Hylxpnh9WcTHEOjQkZ8TEoT/X7w1zjpO1Je7AQ00+q1peiJE3oPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199018)(31686004)(38070700005)(86362001)(36756003)(66556008)(66476007)(66446008)(64756008)(66946007)(31696002)(7416002)(41300700001)(8676002)(5660300002)(8936002)(4326008)(2906002)(122000001)(38100700002)(71200400001)(6486002)(478600001)(54906003)(91956017)(316002)(76116006)(83380400001)(110136005)(186003)(2616005)(6512007)(26005)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzhvSWhLT3lxOHh3dUFCdUFxT2VneTRWaHZTTFZkdENFQm1lbTU3bXRwc1Fp?=
 =?utf-8?B?SGlCd2lpVVJEZVNGSmVUS0h0aVpHM2p0dHMwRzR5OFAzRUZ6SHRYRHVqVTVF?=
 =?utf-8?B?OW9JNmJuaERRdXdDTlNuZUNwQ1FsTG9nM3Q4MER6YjhBcVJrRDBDRWI4RE9J?=
 =?utf-8?B?MEhoUXp0ZU9IWVBqR3A0MUpMZllOdUluVU54S0lSTm1HbHZ4VHVPdWNHSnFK?=
 =?utf-8?B?cnFQZTJqUFRLcjIweWJObGNSMUU5WnA5dTJybTVEUUxlazNPWTVwd1Y1V1BJ?=
 =?utf-8?B?UU1VT3NlQWp3VmxSdFJZSjJIK3FNTFZ3UnlEZ3pFd1dEZXNWeXpHa2p3SXNH?=
 =?utf-8?B?U0cwZXJHdnZQRjlRUXZIOUpHYzBlZVVWbWI3MzBTMUp3RU9uS0srQm9WSjVY?=
 =?utf-8?B?dDN1bEFUUUVISUs5VDVxbHNIai9xMGk0ZnluU0JNdG5RQVhOUEp5YzJGdXdp?=
 =?utf-8?B?cXMybllrSzFsWU13ektkVmhrc2hFRG5aUzBNTmY5TWUvenZ3SlVhaURLUWs5?=
 =?utf-8?B?MDVZV3ZISnZxN3pkNVNmWnpIL0Y3bXRsSzU4TlIyWWNwS1BvQzVJUkpzTmp6?=
 =?utf-8?B?NGczS0REM2crZU42S1JjSDh6Y2NJWjZMaGtqOE94QmFyZVhhZjdBT3g0ajlt?=
 =?utf-8?B?OXNLNSt5THQ1Tnk5VWVpb3cvSURKajBYdW1lYTkyRWllU1BiY2thbDEraUE1?=
 =?utf-8?B?Zi9Xdm9zWDFTRzJoUUVJTTUzaTNFYXBSemhadjZXNzM1am9QTG9hUUl1OTJY?=
 =?utf-8?B?VXFCbUo1Sk5odzZEdE9kUXUweDZHTE84VERtYkdmRlMvdUFJV3UzSEcyVFZU?=
 =?utf-8?B?VDNwQm16UGFVRlpXY1lJelJJN0hlQkpDc3hFQjJaaGE1Ym1EOUZnblhrQ0h4?=
 =?utf-8?B?blE1RjNrbzJ4cjloVGlhMWp1OG4yNWhKd1U5ZHk0TjlqSkVKeEZ5UENvVkdl?=
 =?utf-8?B?YTVCNFZTOWFMZm8vNjFHRWE5MFAyVkhDcHVTaittRjNmdHp2Z2lkNi9EbGFJ?=
 =?utf-8?B?djVGU3V2Z2RYNzhsQ2czT1NYMCs5MCtNMGhlNUU5M0VvYXUyUGxBUzNBbkFa?=
 =?utf-8?B?em04Y2RKL0l0MW5HZHZmVjA2K3BFYWZRdDZvb1Zla2pMTDh2cGI0eEM4VGhw?=
 =?utf-8?B?RjJ0bzhtWlZnMDFUTndkK1V4QW5GUkVla2I5RGFBbVJhbE5oU0xTWXg5dlky?=
 =?utf-8?B?MXVqNWEwMytWUUYvNHZYa3BYVmtJL0VWdHNlbEhYY0dmd0FPckdla1lTWCsw?=
 =?utf-8?B?aHZhd1N5bVRjZFUxRnZEc0wzT2xTdXlkU1FGb0JwRmlnS2V2RXR1ZjZsTVY4?=
 =?utf-8?B?QVNNeVVPS0FYbUtSK3Q0WGZwOHZNalJLeWZCaDExTW53RWZBVmZEYU81anE4?=
 =?utf-8?B?NFZhR1dhbDl1V2JWcUp6NlZTd2hDVVZhRHpQZG5HekZNSGdzZnNtWk5nNUNm?=
 =?utf-8?B?MlZlWnhuS1dmZFJla3NpTmFkb2FMcWh0LzlwTDNaS3lYWGFwQ1BrRGZZalQx?=
 =?utf-8?B?WElMdkpaNU5PZVI3bC9VRXkyQy9vL1dOMG5GdGk2TVhHeWVuaTM0UDdpMW1Y?=
 =?utf-8?B?eVVyMTh5LzNiS1NJSHRJdGZtZno5VGgzZHhJT2tIMUJMTEZRU3ZrZ1dEOEhD?=
 =?utf-8?B?dWRpNU41UmJOdDBhUzRiMkpWcFp6cDFVbjVZblJKVFVBUW80S0ZUZjZXckFz?=
 =?utf-8?B?b1lSaDlHNzFvUlk3MkhESFNRMHRVbmpZajh1OGlTS2RYL1k2UmxHOWNaWGlo?=
 =?utf-8?B?SnA1aC8vc0FaV3ZsOEUvQ2t3anpUZWpJekFEZ3J0dDZ5c3JybnBmZ2ZEWnFk?=
 =?utf-8?B?RDZlcWJIRk5yY1Z6cXJhV3lkVUdDM0xLbTc1TFlOSUVaY3ZYR3BFQ1p2UTRw?=
 =?utf-8?B?bzFSWE94M1dxWjNrUkYvYjNmWUVyYVRtSE1meHNOOFd0ZVBML1Z6aFRpV1Ni?=
 =?utf-8?B?aVpOZENiU3IzR2JveFVoTnJvSzE3WUpZNGFSV25uMXVFN2drNUpDNUQyeG1U?=
 =?utf-8?B?V2t4NDJGbnFvd09DblEvYU5wVmxyUmpHZE9WeU9GK2tZQUlKdjNDMm1zeDFN?=
 =?utf-8?B?V0VnNHBYT0xLaEp3cEYvdGZUeW5yakZkU2U5R01xQjVBN0pwdUgwaVlyNTNa?=
 =?utf-8?B?TEFqRHBmVW04dFM2UktFS25TcVVkeEtjTVNYMFAyTExDQjM1S3lhd3JUNW9P?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <456FA67277EA2A45B6E2B41E7C956E95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9af9c5-3759-42f4-4089-08db1976dccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 10:30:50.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3+628WUowpIE4qU6Ow2/U3uJdAwmcNrEca1q6c/Rmh951pnnZodl3XbtuCZMJy7VkoaJNiNbfQxLETBHzrybYq8ma25OMEt9zo4Tpvf7fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcuMDIuMjAyMyAxNzo0NywgVmlqZW5kYXIgTXVrdW5kYSB3cm90ZToNCj4gQWRkIHN1cHBv
cnQgZm9yIHJ1bnRpbWUgcG0gb3BzIGZvciBBTUQgU291bmRXaXJlIG1hbmFnZXIgZHJpdmVyLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogVmlqZW5kYXIgTXVrdW5kYSA8VmlqZW5kYXIuTXVrdW5kYUBh
bWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXN0YW4gS2F0cmFnYWRkYSA8TWFzdGFuLkthdHJh
Z2FkZGFAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NvdW5kd2lyZS9hbWRfbWFuYWdlci5j
ICAgfCAxNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3NvdW5k
d2lyZS9hbWRfbWFuYWdlci5oICAgfCAgIDMgKw0KPiAgaW5jbHVkZS9saW51eC9zb3VuZHdpcmUv
c2R3X2FtZC5oIHwgIDE3ICsrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTgxIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvdW5kd2lyZS9hbWRfbWFuYWdlci5jIGIv
ZHJpdmVycy9zb3VuZHdpcmUvYW1kX21hbmFnZXIuYw0KPiBpbmRleCA3YmIyMzAwZjE2YjMuLjEy
MzQ1MDc3YzM5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb3VuZHdpcmUvYW1kX21hbmFnZXIu
Yw0KPiArKysgYi9kcml2ZXJzL3NvdW5kd2lyZS9hbWRfbWFuYWdlci5jDQo+IEBAIC0xNCw2ICsx
NCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Nv
dW5kd2lyZS9zZHcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb3VuZHdpcmUvc2R3X3JlZ2lzdGVy
cy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC93YWl0Lmg+DQo+ICAjaW5jbHVkZSA8c291bmQvcGNtX3BhcmFtcy5oPg0KPiAgI2luY2x1ZGUg
PHNvdW5kL3NvYy5oPg0KPiBAQCAtMTc4LDYgKzE3OSwxMiBAQCBzdGF0aWMgdm9pZCBhbWRfZGlz
YWJsZV9zZHdfaW50ZXJydXB0cyhzdHJ1Y3QgYW1kX3Nkd19tYW5hZ2VyICphbWRfbWFuYWdlcikN
Cj4gICAgICAgICBhY3BfcmVnX3dyaXRlbCgweDAwLCBhbWRfbWFuYWdlci0+bW1pbyArIEFDUF9T
V19FUlJPUl9JTlRSX01BU0spOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgYW1kX2RlaW5pdF9z
ZHdfbWFuYWdlcihzdHJ1Y3QgYW1kX3Nkd19tYW5hZ2VyICphbWRfbWFuYWdlcikNCj4gK3sNCj4g
KyAgICAgICBhbWRfZGlzYWJsZV9zZHdfaW50ZXJydXB0cyhhbWRfbWFuYWdlcik7DQo+ICsgICAg
ICAgcmV0dXJuIGFtZF9kaXNhYmxlX3Nkd19tYW5hZ2VyKGFtZF9tYW5hZ2VyKTsNCj4gK30NCj4g
Kw0KPiAgc3RhdGljIHZvaWQgYW1kX3Nkd19zZXRfZnJhbWVzaGFwZShzdHJ1Y3QgYW1kX3Nkd19t
YW5hZ2VyICphbWRfbWFuYWdlcikNCj4gIHsNCj4gICAgICAgICB1MzIgZnJhbWVfc2l6ZTsNCj4g
QEAgLTk1Nyw2ICs5NjQsMTIgQEAgc3RhdGljIHZvaWQgYW1kX3Nkd19wcm9iZV93b3JrKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiAgICAgICAgICAgICAgICAgYW1kX3Nkd19zZXRfZnJhbWVzaGFwZShhbWRfbWFuYWdlcik7DQo+
ICAgICAgICAgfQ0KPiArICAgICAgIC8qIEVuYWJsZSBydW50aW1lIFBNICovDQo+ICsgICAgICAg
cG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoYW1kX21hbmFnZXItPmRldiwgQU1EX1NE
V19NQVNURVJfU1VTUEVORF9ERUxBWV9NUyk7DQo+ICsgICAgICAgcG1fcnVudGltZV91c2VfYXV0
b3N1c3BlbmQoYW1kX21hbmFnZXItPmRldik7DQo+ICsgICAgICAgcG1fcnVudGltZV9tYXJrX2xh
c3RfYnVzeShhbWRfbWFuYWdlci0+ZGV2KTsNCj4gKyAgICAgICBwbV9ydW50aW1lX3NldF9hY3Rp
dmUoYW1kX21hbmFnZXItPmRldik7DQo+ICsgICAgICAgcG1fcnVudGltZV9lbmFibGUoYW1kX21h
bmFnZXItPmRldik7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGludCBhbWRfc2R3X21hbmFnZXJfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gQEAgLTEwNDAsMTcgKzEwNTMsMTY1
IEBAIHN0YXRpYyBpbnQgYW1kX3Nkd19tYW5hZ2VyX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBhbWRfc2R3X21hbmFnZXIgKmFtZF9t
YW5hZ2VyID0gZGV2X2dldF9kcnZkYXRhKCZwZGV2LT5kZXYpOw0KPiANCj4gKyAgICAgICBwbV9y
dW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ICAgICAgICAgY2FuY2VsX3dvcmtfc3luYygm
YW1kX21hbmFnZXItPnByb2JlX3dvcmspOw0KPiAgICAgICAgIGFtZF9kaXNhYmxlX3Nkd19pbnRl
cnJ1cHRzKGFtZF9tYW5hZ2VyKTsNCj4gICAgICAgICBzZHdfYnVzX21hc3Rlcl9kZWxldGUoJmFt
ZF9tYW5hZ2VyLT5idXMpOw0KPiAgICAgICAgIHJldHVybiBhbWRfZGlzYWJsZV9zZHdfbWFuYWdl
cihhbWRfbWFuYWdlcik7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBhbWRfc2R3X2Nsb2NrX3N0
b3Aoc3RydWN0IGFtZF9zZHdfbWFuYWdlciAqYW1kX21hbmFnZXIpDQo+ICt7DQo+ICsgICAgICAg
dTMyIHZhbDsNCj4gKyAgICAgICB1MzIgcmV0cnlfY291bnQgPSAwOw0KPiArICAgICAgIGludCBy
ZXQ7DQo+ICsNCj4gKyAgICAgICByZXQgPSBzZHdfYnVzX3ByZXBfY2xrX3N0b3AoJmFtZF9tYW5h
Z2VyLT5idXMpOw0KPiArICAgICAgIGlmIChyZXQgPCAwICYmIHJldCAhPSAtRU5PREFUQSkgew0K
PiArICAgICAgICAgICAgICAgZGV2X2VycihhbWRfbWFuYWdlci0+ZGV2LCAicHJlcGFyZSBjbG9j
ayBzdG9wIGZhaWxlZCAlZCIsIHJldCk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
KyAgICAgICB9DQo+ICsgICAgICAgcmV0ID0gc2R3X2J1c19jbGtfc3RvcCgmYW1kX21hbmFnZXIt
PmJ1cyk7DQo+ICsgICAgICAgaWYgKHJldCA8IDAgJiYgcmV0ICE9IC1FTk9EQVRBKSB7DQo+ICsg
ICAgICAgICAgICAgICBkZXZfZXJyKGFtZF9tYW5hZ2VyLT5kZXYsICJidXMgY2xvY2sgc3RvcCBm
YWlsZWQgJWQiLCByZXQpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAg
fQ0KPiArDQo+ICsgICAgICAgZG8gew0KPiArICAgICAgICAgICAgICAgdmFsID0gYWNwX3JlZ19y
ZWFkbChhbWRfbWFuYWdlci0+bW1pbyArIEFDUF9TV19DTEtfUkVTVU1FX0NUUkwpOw0KPiArICAg
ICAgICAgICAgICAgaWYgKHZhbCAmIEFNRF9TRFdfQ0xLX1NUT1BfRE9ORSkgew0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBhbWRfbWFuYWdlci0+Y2xrX3N0b3BwZWQgPSB0cnVlOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKyAgICAg
ICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMCwgMjApOw0KPiArICAgICAgIH0gd2hpbGUgKHJldHJ5
X2NvdW50KysgPCBBTURfU0RXX0NMS19TVE9QX01BWF9SRVRSWV9DT1VOVCk7DQoNCkNvdWxkIHRo
ZXNlIGRvIHsgfSB3aGlsZSAoKSBiZSByZXBsYWNlZCBieSByZWFkX3BvbGxfdGltZW91dCgpID8N
Cg==
