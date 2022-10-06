Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90685F60C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJFFuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJFFt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:49:58 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120058.outbound.protection.outlook.com [40.107.12.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4714D24;
        Wed,  5 Oct 2022 22:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1fY9EDZmSVXu2ZzgSESz/jQhfTxwk8Sy6382622fuYx/R0EQ69bYBIBkV7bUF3n2r60gbgPbpcCbtozPEIa9V8vFThNTtbXflLM+lyBXncPG4EceUASs1UB9sAr9Lex4ohsC9gzSfXIGhv0+jMP+uamtV4CjeJfpfEIluRc54CwaxeNMH4/K1tOkCkdFGKQjdu7V8uNYwXLtYCPvNVRwWJCacX4M9T9jT5hp58X3PIsCdgCYY2SSb+aHJ212xpLUdU9wdrExnkOJIiJ3KT2wyLcwZk8OJJXfe9hSwW6f6vopOzcYbHVrOsUtPg4w4rYX0IN2jc4Vhr1C2Az6k6Fqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1dLB0YNVbWbEC7wHvzFVcB7gVwyIjSnJBfhYaArZT8=;
 b=mm0yMYgUMyrXtGaERw2CpSkM9FUTNiqr7llSbdfR2QYFV4gKwGg+9I91Eim5fwiSM8WkDQsiHw6Q/lCFr0Pem2/QtqBwiU0FjdJfNHKjWKBBrV3v1RJRMJ5+Yglfk5unHpgPsYFj5fA1cUScrkcENOvvc+2rbiJvpTigOOP3wsXBPqoOmw28kWFdA5ATpvX2WC3IA6EWjtQv+1fV4ePBHvLdrfo08YgRjvS3MoNYRbPS7XW5ryur2TvMoMzqyTzuK1ontGXsHr/X8jVb6mmgkugWXFG0y84MExhH1AwqGNL1/6mZbZPX4KdDntg2twrHNTJrKy0WH2SFs1eGSIJTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1dLB0YNVbWbEC7wHvzFVcB7gVwyIjSnJBfhYaArZT8=;
 b=e6TBFZA430RYEK3SOA8nb0QQ5eo6MOzF7RAfqj4tOfZRreypXtmLdLxOuuH2Sds3oFDCeisfUxVK7MiRbAx80OEItfAtwkDDvetE8ymbeC9S0Zdrcd5Zf6YcbeMmggYyJOtx4kEaUaBTN1Wf+VNuTTExB93sA4XFaNYxKHG9cHoBazO4QeU3V21oHx5K7XSBmBsxHoPiLsNGAIVnnw8wlTzkYwgcTOX8XH9MSIcJ0Iu50Vp6KuIrnpYSNL3UPQf7Snd9AkP6hKxdrcCOIhaOhpNxhjFZs1bieLcTuu84dDOCAUnG/4bmOb+VnK4vUBFWSsuOmHsa32DTc2HrXmLymA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3115.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33; Thu, 6 Oct
 2022 05:49:53 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 05:49:53 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Thread-Topic: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Thread-Index: AQHY2ULwo13q7okCIE6Pi+qP7CnouK4A20yAgAABFgA=
Date:   Thu, 6 Oct 2022 05:49:53 +0000
Message-ID: <14fa0e63-1a43-6c80-5ffe-1c7100ed88ba@csgroup.eu>
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
 <60557988-a5e5-8c81-72f9-c0f3ab9ed573@opensource.wdc.com>
In-Reply-To: <60557988-a5e5-8c81-72f9-c0f3ab9ed573@opensource.wdc.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3115:EE_
x-ms-office365-filtering-correlation-id: 06d63034-f0e7-4d52-731e-08daa75e9771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHoqRATPC2Flk1IahrrFZjL8WXJTd2fLRP8Qlc+HpV2v4a8/riDEL8nR0LmCHUwkDZ/xAl4P1EnAC7dfexQXP+nC6waamjuClTZRjRt9gyMP6Rgjtu2Uxa3VCag6VV+oixbEDwPxN6MYxtayoIPktO3H9WFuT/ubUJsH58fje/5kyhItNOe1armVou+aQkLNA/ibDesinBou2knU4t3WV5hyDbSoxyGWCOhD9rJpIUqVFCbWNsfEsApYoK6xvH/27lUDockFRBXg+t6kyt/X2WtmKj6QE1Zfw/4997Pva9IW9/QPKjGKtjraXHi194kRa5RfFPzSJsyd1KlAw6mqHUuuMVayY+VrCCMDKS+E8Az0GIxRsrThHFmkU1d/FNTQXB5IpCMcBWKMs1DRg9jEVBBfo0/ik1NhC5yTgFDQWxns9F1ABqIdvQBfAQTMjTukAFemXbdlOe2+LcIFjJpuYvmpRDRJIhfX6PlIzjJUMwDdXiIWhHHQgt95JeAJru3tqB7vDXTomf3foCxfNXxpuxh+CUjGPxmYK6+z1dT0uV4TgN2IHjg2cqKVB/1+DUKT6+WX/OuhQkXV8eJCgrRL76agFdjpzPDz+toFFSarHIVENpZ3zgdTiEIf5oi4wOFAZocAW6u84DppC4/aNujerXd2IT80WkJPRvvFODllOCudI4+N2+4hDZ7ENCvOYgJr2Kt1FNkDLcTq+h45VxpOzy8EI9AywaIUFiFhbUsy+U2PN0Nw1CVZXFrDzEmzXCB2hlMucTe1SO+jHZj01oBfGv0Bxlja1ZSqrtx2qUjFmMgolRDZ/y+XVAT18ddjuJ5pbk+nddL3nlKo57/jR9Ofqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(36756003)(38070700005)(186003)(2616005)(66574015)(122000001)(83380400001)(38100700002)(31696002)(86362001)(31686004)(8936002)(66446008)(66556008)(41300700001)(66946007)(66476007)(5660300002)(44832011)(64756008)(2906002)(91956017)(26005)(76116006)(6506007)(6486002)(478600001)(53546011)(6512007)(54906003)(71200400001)(316002)(110136005)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUROOVRFcHdwUHh5REZhdG9pZ0RBN3NxOGNGcUFEbW40RW15d0hlTTlDb0Nl?=
 =?utf-8?B?N1VBOXpJYzFsdkdCVnREMkdCbHFNOHQvMGxkZEZTcG85UUgwcGUzdnQxN083?=
 =?utf-8?B?KzhTMkxqbzJoOTRaUmR0Q3lnbUNMWVp6OVZkVTNBZGZNNkZ3UXJxWm1YczNi?=
 =?utf-8?B?enJKOGhuNVgzYkd3RzdWdXAxT1lwWS9QekNibGlMM1kxTzhPYzlRVnpBbUxX?=
 =?utf-8?B?TUJQNCtGdGoxRHpwYnpTSmNRUHRpWE5BK1VhUk10MDF0TlZVdG5LUlp6Q0ox?=
 =?utf-8?B?V3lZV3dMaUFDMzFWMlorM3JvUWRxcnpwYXduaW9lNmF3enZ1OFNMOVp0THly?=
 =?utf-8?B?SWRVVTZRNVdLNXBqZjRNVUdydjBHM094TE91UjAyWE5GdTNTYS9JWHIvYlVC?=
 =?utf-8?B?REdSRnliL3NKRSt2djR6ZW8xTVhXRDNsamZqbXZxQWNwNE1UcjdoTVVlM1lh?=
 =?utf-8?B?RjVPVFhsRlE4NGtQb0w0UDZyUVVNZXV0NGVDejZuOXZmdHhiQUJxN2RVVnNa?=
 =?utf-8?B?aHNZdnJFbldZWFd3NWlpZTR4bWxjdjBFcmNaOEpsV1NFYndPR2dDeWtic2VO?=
 =?utf-8?B?L1MvUTBwMEJJUXRvK2ZDYnRja2VpOVE1ZXVTMzJ5OEl1czZkSm1aT0UwVlo5?=
 =?utf-8?B?OW9xcE44RDV6SElub3Y2NEdaclpudWl1ZTZiUzN0SmhDa3FxZ2JFcG9tOUxw?=
 =?utf-8?B?WldycDFnZGpyNUZoZkg4YkY1cXhGOXhHTkNDTkhKcldGSmgxSThyRzdHa3do?=
 =?utf-8?B?ZDdLMThwU3EwUW5QN3NPRTFnbWxsZS9iZzJFQnFlQXpGTUFUdk5XbEY5K1NS?=
 =?utf-8?B?OGZycjFOTkFKNjBzcUloNDdzdVQzVklmUE9tcC9vWnpOalZMWHVUVTJSTnNu?=
 =?utf-8?B?TFp1elo3dVR3VE1FWk9USlVMWU1KOWR5Q2VXWmY4ZUpEbUlTSVk0OXhNS1BB?=
 =?utf-8?B?TU4yYmd2c1JNM2pMMXdXSHVVK2VRcUkvK0dmZW1iMW12VHFCT0dVZUk4S3pH?=
 =?utf-8?B?TEI5KzVhY3V1eHBESUVJekJ2VUxoUlE0Szl3MW5CdFc2QkUzSXBYckFNWHRY?=
 =?utf-8?B?NU9SVGZzY1laWURISU1IS2RUdk5kOWNrbHJKSXMvVWY2U0xOcXdRVHhya05W?=
 =?utf-8?B?TnZBVHZDZDZSVHZKSHprWktqVzZhZTNndUQ1a3ZRWmxoTDN0SjlaVGFGY2dH?=
 =?utf-8?B?YUtla2pWZEhuR21ZMm5LTkwyVUhaZWIwdWNRS3Z4U0FUSXB6Q0hnVk94TFJR?=
 =?utf-8?B?bVVrN1p6SnIvSE9TMFE0TGZlRHZ1YmUzTFQ2OTN3M3BaOC9lM0YzcWRQNzdO?=
 =?utf-8?B?VG93alBjcHl1RzR4dk1jSThscXE5ektPdThsOXJZeWdoYVZpZjJycXZ4dEp4?=
 =?utf-8?B?RFErWlJrNnE5R0hUaW5obEhvc2o4NTlaNXExWjFGbDNpQnhKZElaMFNnM3hW?=
 =?utf-8?B?S1FqVEc0a0ptTWRuK2NoanRIZDU5VWpQeDhlTGJXazFmRFQyUk9sOCtzdkho?=
 =?utf-8?B?YWdsZVltRUtiYmJWOXJ0SnEwdkRFVS9NVmtXNEhoaVZQT0NiWkd2cmM5Q21u?=
 =?utf-8?B?NnI0Y1plMXhNZVNJeEpodlI4dU5tanRta24yV1FIaFFZcG9lWlhoNTJMVUdB?=
 =?utf-8?B?Z085U2ZZMmFGZmVYalRLYksvd3hSQ3JzZGZiR2wyKzV1K0RnZ2ZRcHlYb0hJ?=
 =?utf-8?B?a3FwNjY4S2tOWStLS0FwbGNqbTVSclZaMFYvNTEyblJ3dFlHVmNKVUFvVjI3?=
 =?utf-8?B?K0x3RDlIVkFMbmREOGFHZ2lYZWxjRHAyL3Y0WFVmN1ZnQTV3cWU5ZmhPdUZq?=
 =?utf-8?B?djhFOFdCUFRmNGwrRERrNEVBUDVod3RPTFVGZW9haTQ4Snc2K1UxMEE0QUVI?=
 =?utf-8?B?K0V5SFh6TTR2Y2pmeExsblhnL2hTblRzWVl3REhEeXNuSEV6VTNOZENPOEpj?=
 =?utf-8?B?L1BBUXI2M1p4aGVRSzJyTVlZNXA4WHF6ZzFyZm83ZGNud2hXcFBDTW9aWDNW?=
 =?utf-8?B?M3k5ZHFOZGM4RHlPSnJOQUhidnU2S3FBWTFnUWloTlZ0dHAyWkt4T0dlcVpQ?=
 =?utf-8?B?NVBqOTlRVndEZ0dQM2FTb3hiQlo1UmtHTGg2dTBKRTEvM28vcDRUc3Rsclh0?=
 =?utf-8?B?N1dHWE1QN3ZqYUhtc1lud1BiN0NlNnhTbVB5d2R5QlV1cTdxTXFZZ2RlU0sz?=
 =?utf-8?Q?V5v06IwXAVkYR6sQsJukE8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E70B75857EECCF44AC61430AE71FE431@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d63034-f0e7-4d52-731e-08daa75e9771
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 05:49:53.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EF86mYJ22PKHPyM9TK0J3sRYOA/TxeB76kVvxx0/8kaGc8WeSfDwByghGYY+V9ZrSeyZngrGeDoBuJm6I7dENQul26cBCrSTafSACMK9l+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3115
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMDc6NDUsIERhbWllbiBMZSBNb2FsIGEgw6ljcml0wqA6DQo+
IE9uIDEwLzYvMjIgMTQ6MTcsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+PiBOT19JUlEgaXMg
dXNlZCB0byBjaGVjayB0aGUgcmV0dXJuIG9mIGlycV9vZl9wYXJzZV9hbmRfbWFwKCkuDQo+Pg0K
Pj4gT24gc29tZSBhcmNoaXRlY3R1cmUgTk9fSVJRIGlzIDAsIG9uIG90aGVyIGFyY2hpdGVjdHVy
ZXMgaXQgaXMgLTEuDQo+Pg0KPj4gaXJxX29mX3BhcnNlX2FuZF9tYXAoKSByZXR1cm5zIDAgb24g
ZXJyb3IsIGluZGVwZW5kZW50IG9mIE5PX0lSUS4NCj4+DQo+PiBTbyB1c2UgMCBpbnN0ZWFkIG9m
IHVzaW5nIE5PX0lSUS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxj
aHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+IA0KPiBEb2Vzbid0IHRoaXMgbmVlZCBmaXhl
cyBhbmQgY2M6c3RhYmxlIHRhZ3MgPw0KDQpJIGRvbid0IHRoaW5rIHNvLCBiZWNhdXNlIHRoZSBv
bmx5IHVzZXIgb2YgdGhpcyBkcml2ZXIgaXMgcG93ZXJwYyBhbmQgDQpwb3dlcnBjIGhhcyBOT19J
UlEgc2V0IHRvIDAuDQoNCkknbSBzZW5kaW5nIHRoaXMgYmVjYXVzZSBJIHdhcyB0byByZW1vdmUg
Tk9fSVJRIGluIHBvd2VycGMgaW4gYSBzZWNvbmQgc3RlcC4NCg0KPiANCj4+IC0tLQ0KPj4gICBk
cml2ZXJzL2F0YS9wYXRhX21wYzUyeHguYyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YXRhL3BhdGFfbXBjNTJ4eC5jIGIvZHJpdmVycy9hdGEvcGF0YV9tcGM1Mnh4LmMNCj4+IGluZGV4
IDY1NTliNjA2NzM2ZC4uM2ViZDY1MjJhMWZkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9hdGEv
cGF0YV9tcGM1Mnh4LmMNCj4+ICsrKyBiL2RyaXZlcnMvYXRhL3BhdGFfbXBjNTJ4eC5jDQo+PiBA
QCAtNzMxLDcgKzczMSw3IEBAIHN0YXRpYyBpbnQgbXBjNTJ4eF9hdGFfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqb3ApDQo+PiAgIAkJdWRtYV9tYXNrID0gQVRBX1VETUEyICYgKCgxIDw8
ICgqcHJvcCArIDEpKSAtIDEpOw0KPj4gICANCj4+ICAgCWF0YV9pcnEgPSBpcnFfb2ZfcGFyc2Vf
YW5kX21hcChvcC0+ZGV2Lm9mX25vZGUsIDApOw0KPj4gLQlpZiAoYXRhX2lycSA9PSBOT19JUlEp
IHsNCj4+ICsJaWYgKCFhdGFfaXJxKSB7DQo+PiAgIAkJZGV2X2Vycigmb3AtPmRldiwgImVycm9y
IG1hcHBpbmcgaXJxXG4iKTsNCj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICAgCX0NCj4g
