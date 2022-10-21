Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6407660744F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJUJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJUJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:40:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120EA182C5C;
        Fri, 21 Oct 2022 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666345219; x=1697881219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l+tbRTejqd01AYqV5Hyt2rf7JBNPED586sc9NTzy7CM=;
  b=Qkt/cETUs2bXRSZ7gzmO/duBkWuDQ8k0WNIyTWBH/3zPzHKkp/ZdafgG
   R8GMZVFqcpk40ZzrZsJgTWD8JKAGyf3J40xGfrCBSmlHoTagUa0YNIpCC
   zLQnnt27tMnXK/mq/h89oFTv7GaOjOrg28weSjTxaygDUI4K+OexmcRRr
   yb5wZB8zPAPN7axXQXkSD2vXXRRXM8Tk+OhorGQxKXeEMLptAKr2zmW+P
   9fS5ECu38N+wUEa6D9kwAUqhDBHP2254WX4dL6+4N9BxZaeSH35abaREN
   7cQiCzQLC37zlhYcLj/khHjs25B8AA/GMF3t6Qw/zNsSJGbtziwL7HIA3
   w==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326534358"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 17:38:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx3D0oOpg+acWdqSAtGrxz8Ew3Ok5o6TJkPXARhsdNAr+S7ul9Xx8uiV8k4mSsLkNeII/VLJAILculum/OoFqS94t1sAIvVlS+84H+36bhXWR0iMvVoeNUyRt3RRYwU7fcqfLuOr4kEyIVRJ+HqcBEsTR6K7fTTJcgNr5iekf4Vb3uVy2Poo9twWDwATVWoAcBHwUc2ZZT5kc8Ea1WPXaSIqzaxy3goeUeuIVvsG9FvvX4THLbMUposFu1qEGKZK9lZ26MOY0ksOnmDsDi/Hld14lDQ0b64dHH34MD9IXLm7nz6YcqWguks/Rr/UenGFNmM7VsLEytdE2rD4RdrvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+tbRTejqd01AYqV5Hyt2rf7JBNPED586sc9NTzy7CM=;
 b=IwZEsLkt/x5lDuILDoVHQW39buffCOJCehZIxVwNSv7eFLvYgw1Y/xFcwNxq528kdvjgWq0EcEZOU1FgD+ZT3Db3zUVTssaPTXmgEwkpECTbCTIjRdwCuDND8lYxmkYsDEwK9fRsEzbjTRJ9nik8RzwB5TgnHrFKCZLthvcdQV7+tjH2v1WJd7ffmRC+WUK6YbQtbth89T0znQA/Zzuhiv+bJ6v6RNf/vYCqtxN+P0j+EpAJHNrj0XctaSJigVKL19KojxkrGiLfzx4R2x2dUgGEMzMnNUq0tzjzB+pXyOgg0r0C48qITkyar6pA2sRamJUnhl12U9NOPMISYr/18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+tbRTejqd01AYqV5Hyt2rf7JBNPED586sc9NTzy7CM=;
 b=cMXVubtVB7O3QB85PMDCvGxRVxV1psIn71CQOJ947UK6a1aV5faP8dSeGFZYToytYzz5UwQ7EK80cjd9b2sxzPPPW/zUmXkRz6T4LPED2WVCaJEeaTk4Ca0iSVeFp2FaoZgHHYMfrisAPsFL7FXyvkznlhOx5RRtzxywv2xxdzM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6073.namprd04.prod.outlook.com (2603:10b6:5:12e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Fri, 21 Oct 2022 09:37:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 09:37:32 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Wenchao Chen <wenchao.chen666@gmail.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: RE: [PATCH V2 1/2] mmc: block: Support Host to control FUA
Thread-Topic: [PATCH V2 1/2] mmc: block: Support Host to control FUA
Thread-Index: AQHY5R8OLfuUh6VcvUiWPq6FTK+Zba4YeSHwgAAQMoCAAAqRgA==
Date:   Fri, 21 Oct 2022 09:37:32 +0000
Message-ID: <DM6PR04MB65752E22840E0305ED976391FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <20221021073025.18831-2-wenchao.chen666@gmail.com>
 <DM6PR04MB6575FC4EF5E3CF08A90279F7FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CA+Da2qwei0=0EH57pCC+4StijJ_NxSqHv1SkPj_PS-yzZh6hnw@mail.gmail.com>
In-Reply-To: <CA+Da2qwei0=0EH57pCC+4StijJ_NxSqHv1SkPj_PS-yzZh6hnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6073:EE_
x-ms-office365-filtering-correlation-id: 01942285-745e-4a60-d692-08dab347e0ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jF4fbEJ31tf6/l6gaA/gr2Dmdv5hcA1iJzwQLssNT5+rsZZFB9EmExo4L2cGDxaSzQqGgKOxlz9Xg999s12oF4a/TkEauLo0vpKo2/jiuGcoY9nO5OiJ85iI6lxIjqLW0r0IJCWdcjXDOc20iv68vFagFcg0u/VYfY/bC54Or9/34gsgpHfToi8yAjrofqqslZA4GxNw/HQDu4w3MOY3JVsxivvtSqVtGKJBUVIYaTO+yAg8biXe5nupQ0/FJly2P7KIoBtaTqXY02+hx3mLpnRuv32i0keNMBoe5qOe3nivMFJVqOgGuPeoF0yEcVB5ETJT660iN8VTZIe123MiN9FQZ62iibl5vzKRspknnioJSaTbxD/ChXLnnge7pox3MdmL4JjycNzjk8g0HTE6eR7OafXHi+g7SvpTGHfA2cKEFD0jrH/vhjJoJhAaa0ccAcvfsil4ofB/pI6gPB7WmIbX1ykYk5VJBclYjtvSLYzoJ0X+6rMXIU8qcyfF7p531dQsm8zn+d4Jn2H2aDgEkisD9dCS8ML7fTQeRtWG1FSUoFGQc/VHFdZXiXuGrMOY1/kOUGpFU9LPel6MWSuAnwuHDIlxD+7xCW/JjugtESOTTSOe8D5kZZPs58XNzslSN5UuhKFe1rAZDnGpoqP8GA0Lv0Vk7fGRHedrwxB1VbAOZCXxKqSmdlY4Tu3Kxkiy9veANiVqdV+2g7N0gnlPXhaHBmzi7GVRrtrdrcSChwPgKI0BVY/jNP/1u4u+cGda0p2z2YmfKbVePlgTUbveQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(82960400001)(4326008)(66476007)(66556008)(64756008)(38070700005)(7696005)(66446008)(76116006)(8676002)(66946007)(7416002)(83380400001)(2906002)(86362001)(55016003)(9686003)(26005)(6506007)(186003)(6916009)(54906003)(316002)(5660300002)(33656002)(122000001)(52536014)(8936002)(71200400001)(41300700001)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tys5QVVEN2tpT0FMQ3c0aTVzQjB4eHZSaXJCSm5ISjAwaUU0b2poVkJMQkRa?=
 =?utf-8?B?dVpkYjhlWk5zMEJWZFVMbVRvbEFDRjU2VjdYaXJOS2IxWmNoL3Z6QTdLZzh6?=
 =?utf-8?B?ak9ZOXg2Y1FIYTBFcFJxZ0VnSVdHT3FBdktQUzB3dFpjNEZrcllIS01zR05n?=
 =?utf-8?B?RkRFaE9JckNTSlprd0c2VFd0UC85cW12ZE9pVzBTZUtMaGRjN3AwN05ESW0z?=
 =?utf-8?B?TzlMa0lScE1Od1FqV1dUR21aaktucjJVaXZUUmdYVVRWN3pvbnVSNnBZSG4x?=
 =?utf-8?B?cHJIRVduMnNLcktMSGVhbFZsdXpQZDdZUG5PNDk4WVFHMnB6Y2JQY1I1ZEJY?=
 =?utf-8?B?cUp5NFYrVGgxWDgxTjNFOStYSWl2T2ZpaVdsRGcydVdkMFVQTU1UOWxteERx?=
 =?utf-8?B?TVV2YmZseGVTMVdOMEtJTDZESFNYSzlETmtac3U4bjg1QmVxS2o3bFRSTjBX?=
 =?utf-8?B?UWNrYjJJS04zK1g5VHFYTVJvVjFBaFF6b3N6eGcxcEozT1h1aFdYalVxZXdo?=
 =?utf-8?B?VnhETFV0T0taY1RUSXByTnZHdjgzcFVRREo0dVdGS0R5bVdwNGNnaXVJeXA3?=
 =?utf-8?B?M2J1WkRQQllhQWU3L0cvRUhjWk0yMW9XNkJlMWRwY2g3TktjRDBJTnlNR3JE?=
 =?utf-8?B?aXNuditRckpJbEZmcDZUaXE5VmF6TndkNUxOU3hvWE9pa1g0VEo5RjZDV1Vl?=
 =?utf-8?B?QXM2WmNCOTRPeHNGamxjc3ZZZlpHRkNlazgzbmNLdlozT0NxZDJTM3JqV01l?=
 =?utf-8?B?SkdCMGRQM0NlcHd2NlQ4UWUwOGVhaTZxck5ud1N4RkRqU2Q5eS9teFhzQmxI?=
 =?utf-8?B?cTM0cFMzOHZWK2RRMFZJV3VXbTZYQ2l3TVpHOHN4VEJFTFNLWGR3dXBobTVI?=
 =?utf-8?B?amlQUXQyL3pZdmZWQ2s0akpiU3kwVDZnYVUySW43VWd4cXhPRGZ5bEEyY2lI?=
 =?utf-8?B?aVFsN3h4Z1hNR1ZPN1pvTStjSEdFcUhMSUhBc2x4eW93dVNmN0ZsRmxCdmdv?=
 =?utf-8?B?VFRUQ0pDamE3WUVtSXNtWDZBNm5PMDFMNnQvUlFZeUc3aGxSNGIzZkNzeDBh?=
 =?utf-8?B?RVFkdnRpQ0VYMVdDWW9jQXczT1JaTE0reWUyYmsydEtkcmlLdjBhRGJLcXNC?=
 =?utf-8?B?Vzk2ZlIzWDFIelBIL3VYOUpDRWhJTURWNFR6V2NEVWNqRXkrSGlNamZISml0?=
 =?utf-8?B?V2NjeTlTOS9lQlFvUE5pb1creFkwblFaWmFFbnRNN0t2NzlqdUsyUzQ2OFgr?=
 =?utf-8?B?VlhSRXJ2Vm5lbHR4Qm5lU3pheXhZSi9wYWRkcTVHY1ZEMmdlTjhnaDRCR0FM?=
 =?utf-8?B?cXZ0Q0N0MWtyaS9JRXBtZ3VXVVMzWWlTVnFFRDJTd2c1NEswK0x2UVdBaHpn?=
 =?utf-8?B?OXROa0FwdDhQMDdKZk0vVW03alcvTkczN2xHdmp1MjRYRnRrTHBqS2lQcVZw?=
 =?utf-8?B?QitidjlsaUNpeEQvdUVkMzNKQzFMeFMybnkxUmZ5eDQ5UFRONnUvRitWUkpP?=
 =?utf-8?B?SUhsNUdVcTRWQm4rY3ZGa0E5aUl1QW9FN2tqZS9RQStiZzNjUjRPaUVkSytQ?=
 =?utf-8?B?bHpSS3RZbE56Rmx2L3hxRER1QURJOHpjQVoxSzdjbU5FUkpES2dJWHhEeHB5?=
 =?utf-8?B?eGtOSkFZWnhDc0ViQngwNkloMFhaSFl5eTF1dy9rbXNVd2JLOHJUS2VpMDAy?=
 =?utf-8?B?UjdaTXRvZzlFSTFBOGliL3lXT05NRUh1YkJwSUN0dElmb3hpcThDcTRxZ0sr?=
 =?utf-8?B?WExaRXYzM05hTGZoV094OXBPWS9CVlh2eksxb3FYU3VQN1J1ckpSck1wMXk5?=
 =?utf-8?B?aXpwUXpLTmxaTC9FL0RPR0U3OHFGVTBDekVTVW1Nd1g5aHJESXN1ZUhDaEtF?=
 =?utf-8?B?aXZsQlZzbnV2eW9YU0ppNjVKK3VFdGxHOHl3bjZPSXFIZjU1SXFSMkpaWlVF?=
 =?utf-8?B?MmROMUNsSXl6OHhGckpRckQvbmt6K2NHNC81ajNwMjFkL0t4MzVHVi9aYXIx?=
 =?utf-8?B?WHNNOGpqSGx5R1k3OG9PNk56YXhySDVDeEhva0I4dHF3MnI0ejBOeUN0cHlu?=
 =?utf-8?B?TUVPZUJKYmZpVERKeWxHNGExNlh2MGlYdWRTTDVWRTQrT0YxMGc0WllhY1p4?=
 =?utf-8?Q?mtTSDZki3GsiqGu94NRxwhSQq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01942285-745e-4a60-d692-08dab347e0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 09:37:32.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBq0uQkC1ZHyquOXuFTGgpfs5aM92Y/u6c+6d9QWhQq7PNioy4wKIqdxt586k20SwnzSLnGb0MqqxnvvJny6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6073
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5Ad2RjLmNvbT4g5LqOMjAyMuW5tDEw5pyIMjHml6Xl
kajkupQgMTU6NTPlhpnpgZPvvJoNCj4gPg0KPiA+ID4gRnJvbTogV2VuY2hhbyBDaGVuIDx3ZW5j
aGFvLmNoZW5AdW5pc29jLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMg
aG9zdC0+ZnVhX2Rpc2FibGUgZm9yIE1NQyBob3N0IGNvbnRyb2xsZXIuDQo+ID4gPiBUaGUgaG9z
dCBjYW4gdHVybiBvZmYgRlVBIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UuDQo+ID4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogV2VuY2hhbyBDaGVuIDx3ZW5jaGFvLmNoZW5AdW5pc29jLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gVjEgLT4gVjINCj4gPiA+IEFkZHJlc3MgQ2hhaXRhbnlhaydzIHN1Z2dl
c3Rpb25zDQo+ID4gPiBBZGRyZXNzIEF2cmkncyBzdWdnZXN0aW9ucw0KPiA+ID4gLS0tDQo+ID4g
PiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwgMyArKy0NCj4gPiA+ICBpbmNsdWRlL2xpbnV4
L21tYy9ob3N0LmggfCAzICsrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBpbmRleA0KPiA+ID4gNTRj
ZDAwOWFlZTUwLi4zMzNlODE5ZTA3N2EgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9j
b3JlL2Jsb2NrLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ID4g
QEAgLTI0OTAsNyArMjQ5MCw4IEBAIHN0YXRpYyBzdHJ1Y3QgbW1jX2Jsa19kYXRhDQo+ID4gPiAq
bW1jX2Jsa19hbGxvY19yZXEoc3RydWN0IG1tY19jYXJkICpjYXJkLA0KPiA+ID4gICAgICAgICAg
ICAgKChjYXJkLT5leHRfY3NkLnJlbF9wYXJhbSAmIEVYVF9DU0RfV1JfUkVMX1BBUkFNX0VOKSB8
fA0KPiA+ID4gICAgICAgICAgICAgIGNhcmQtPmV4dF9jc2QucmVsX3NlY3RvcnMpKSB7DQo+ID4g
PiAgICAgICAgICAgICAgICAgbWQtPmZsYWdzIHw9IE1NQ19CTEtfUkVMX1dSOw0KPiA+ID4gLSAg
ICAgICAgICAgICAgIGZ1YV9lbmFibGVkID0gdHJ1ZTsNCj4gPiA+ICsgICAgICAgICAgICAgICBp
ZiAoIWNhcmQtPmhvc3QtPmZ1YV9kaXNhYmxlKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZnVhX2VuYWJsZWQgPSB0cnVlOw0KPiA+ID4gICAgICAgICAgICAgICAgIGNhY2hlX2VuYWJs
ZWQgPSB0cnVlOw0KPiA+ID4gICAgICAgICB9DQo+ID4gPiAgICAgICAgIGlmIChtbWNfY2FjaGVf
ZW5hYmxlZChjYXJkLT5ob3N0KSkgZGlmZiAtLWdpdA0KPiBhL2luY2x1ZGUvbGludXgvbW1jL2hv
c3QuaA0KPiA+ID4gYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggaW5kZXggOGZkZDNjZjk3MWEz
Li4xNmE1YmVlM2VlYWUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0
LmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPiA+ID4gQEAgLTUxNyw2
ICs1MTcsOSBAQCBzdHJ1Y3QgbW1jX2hvc3Qgew0KPiA+ID4gICAgICAgICBzdHJ1Y3QgYmxrX2Ny
eXB0b19wcm9maWxlIGNyeXB0b19wcm9maWxlOyAgI2VuZGlmDQo+ID4gPg0KPiA+ID4gKyAgICAg
ICAvKiBIb3N0IEZVQSBzdXBwb3J0ICovDQo+ID4gPiArICAgICAgIGJvb2wgICAgICAgICAgICAg
ICAgICAgIGZ1YV9kaXNhYmxlOw0KPiA+IFdoeSBkbyB5b3UgbmVlZCB0byBpbnZlbnQgYSBMTEQg
bWVjaGFuaXNtLCB3aGVuIHlvdSBhbHJlYWR5IGhhdmUgYSBibG9jaw0KPiBhcGkgKFFVRVVFX0ZM
QUdfRlVBKSBmb3IgdGhhdD8NCj4gPiBXaGljaCBpcyBhY3R1YWxseSBtaXNsZWFkaW5nLCBzaW5j
ZSAvc3lzL2Jsb2NrL21tY2JsazAvcXVldWUvZnVhIHdpbGwgc3RpbGwNCj4gcmVhZHMgMC4NCj4g
Pg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4gSGkgQXZyaQ0KPiBUaGUgY29kZSBleHBh
bmRzIGFzIGZvbGxvd3M6DQo+IHN0YXRpYyBzdHJ1Y3QgbW1jX2Jsa19kYXRhICptbWNfYmxrX2Fs
bG9jX3JlcShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsDQo+ICAgICAgIHN0cnVjdCBkZXZpY2UgKnBh
cmVudCwNCj4gICAgICAgc2VjdG9yX3Qgc2l6ZSwNCj4gICAgICAgYm9vbCBkZWZhdWx0X3JvLA0K
PiAgICAgICBjb25zdCBjaGFyICpzdWJuYW1lLA0KPiAgICAgICBpbnQgYXJlYV90eXBlLA0KPiAg
ICAgICB1bnNpZ25lZCBpbnQgcGFydF90eXBlKQ0KPiB7DQo+IC4uLg0KPiBpZiAobWQtPmZsYWdz
ICYgTU1DX0JMS19DTUQyMyAmJg0KPiAgICAgKChjYXJkLT5leHRfY3NkLnJlbF9wYXJhbSAmIEVY
VF9DU0RfV1JfUkVMX1BBUkFNX0VOKSB8fA0KPiAgICAgIGNhcmQtPmV4dF9jc2QucmVsX3NlY3Rv
cnMpKSB7DQo+IG1kLT5mbGFncyB8PSBNTUNfQkxLX1JFTF9XUjsNCj4gaWYgKCFjYXJkLT5ob3N0
LT5mdWFfZGlzYWJsZSkgPDw8QWxsb3cgY2hpcCBtYW51ZmFjdHVyZXJzIHdoZXRoZXIgdG8gdXNl
IEZVQS4NCj4gZnVhX2VuYWJsZWQgPSB0cnVlOw0KPiBjYWNoZV9lbmFibGVkID0gdHJ1ZTsNCj4g
fQ0KPiBpZiAobW1jX2NhY2hlX2VuYWJsZWQoY2FyZC0+aG9zdCkpDQo+IGNhY2hlX2VuYWJsZWQg
ID0gdHJ1ZTsNCj4gDQo+IGJsa19xdWV1ZV93cml0ZV9jYWNoZShtZC0+cXVldWUucXVldWUsIGNh
Y2hlX2VuYWJsZWQsIGZ1YV9lbmFibGVkKTsgPDw8DQo+IC4uLg0KPiB9DQo+IA0KPiB2b2lkIGJs
a19xdWV1ZV93cml0ZV9jYWNoZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgYm9vbCB3YywgYm9v
bCBmdWEpDQo+IHsNCj4gaWYgKHdjKQ0KPiBibGtfcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19X
QywgcSk7DQo+IGVsc2UNCj4gYmxrX3F1ZXVlX2ZsYWdfY2xlYXIoUVVFVUVfRkxBR19XQywgcSk7
DQo+IGlmIChmdWEpDQo+IGJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX0ZVQSwgcSk7ICA8
PDwNCj4gZWxzZQ0KPiBibGtfcXVldWVfZmxhZ19jbGVhcihRVUVVRV9GTEFHX0ZVQSwgcSk7DQo+
IA0KPiB3YnRfc2V0X3dyaXRlX2NhY2hlKHEsIHRlc3RfYml0KFFVRVVFX0ZMQUdfV0MsICZxLT5x
dWV1ZV9mbGFncykpOw0KPiB9DQpBaGhhIC0gb2suDQpUaGFua3MgZm9yIGNsYXJpZnlpbmcgdGhp
cy4NCg0KPiANCj4gQWxzbywgZWNobyAwID4gZnVhIGlzIGZvcmJpZGRlbiByZWdhcmRsZXNzIG9m
IHBlcm1pc3Npb25zLg0KPiBEbyB5b3UgaGF2ZSBhbnkgYmV0dGVyIHN1Z2dlc3Rpb25zPw0KTm8g
LSBJIHNlZSB3aGF0IHlvdSBtZWFuIG5vdy4NCkxvb2tzIGdvb2QgdG8gbWUuDQoNClRoYW5rcywN
CkF2cmkNCj4gDQo+ID4gPiArDQo+ID4gPiAgICAgICAgIC8qIEhvc3QgU29mdHdhcmUgUXVldWUg
c3VwcG9ydCAqLw0KPiA+ID4gICAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBoc3FfZW5h
YmxlZDsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4xDQo+ID4NCg==
