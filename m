Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36E46D0DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjC3S3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3S27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:28:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB52133;
        Thu, 30 Mar 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680200938; x=1711736938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lwHGOQDy+ssStVlYR+/uyYaRae3ZOGhKeqibOtr2gCw=;
  b=m2lRvUxwmJBKHM749niLmZBxHW8B3pdKTKCUcAPpVww3gGt7DPdgddDA
   QA1GnXi3pbE5hXEtamAHiPWBDfLrlC2dh6PW4CsQgUItastUdh6Hr6zZS
   217ZHhN7TfMYhhp8djkMSVilINZAnrgQPeeG7co0kzi/0H81XgAx1OKOf
   bRjSSUHw4YAY/3pm2OgR+cC1/OLm+0LRHzJFBW/WxWDREOE/IV4TRrd7p
   zvMPaSqRPuuYKtM1k7TGA9DFUjw34rfEY0ZkumnW/cMvyCvYK8w2sbu6n
   Wc1LlRaVh8+p6yZvu1SOnRbi6uitYFpacC3AH9VHGhLqRb+UVj9Uv+uZt
   A==;
X-IronPort-AV: E=Sophos;i="5.98,305,1673884800"; 
   d="scan'208";a="226912453"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 02:28:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRuby+YDDurghNwrF9DDjahXOI7N6X0owiS096J5i/inmVYB4ItQFiaZfXVXD9k1HC4dpw7k4VUhlPppJcqpvdtiR18vJM3cS8erJfSaBTmZa9DZCPLgv52/eVPMiAVLVsMTqOIEeqU5FQsp4+gK1MjiI4fRBKInW6hu8A5KVvwQo+sN9oChkefF+JaGnZIkHRR5nlaOZgVew1RDLOBse3tsJXYug3cRuNRMCCiFzZ8vFJu1fOODVOwfXyULYGSMHQ6NZPutKcgW4wBBkyZxxSMbbK+ioH2LvyFm58y7I90LCXLOrYRWreDRfESNbDWcwqA2hNWyjx9s3AufJg5GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwHGOQDy+ssStVlYR+/uyYaRae3ZOGhKeqibOtr2gCw=;
 b=lBNHpVkRDfY/pgVdbCJEo8qMrmHuJAP8D7lvvHbCCZaRofIRZoE3tx+2cCsPOrPVR4N/WU8uJAas4bORPbCIgkkEpmUr8q1TShXfxv+qQeMMy86vEmc4faIWRFN1JJgeEVCkNMqjlXO9m6kgjslXfdrMRhh3RdEB/4SMPx2Vp+oH6eyVVlOBVU5FzzqpbIBfxp/TMMnZ054zOhX4tDgWBSQ5ZNKY06KeIqOatXngEq0dR0sTgln7LVoo0kkEBaNdYFWT+JCfpnIoD0Ce6XxTOT57mMnn27py0DlG/dobsvhmo8TuVvXo06PFLZZ4KgktucF73s9U9BRmY6leqQGh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwHGOQDy+ssStVlYR+/uyYaRae3ZOGhKeqibOtr2gCw=;
 b=O7sXfxArteO6PpQwh+A3YkVIB4+uFdXBE1xf405DilCOUGYWmGEdESdQegeeKHss3aUhSgoVn997ES6/eeKC7CCAxrcvvMWeEXqck5GQ5Z8cBel8acKLLC8O7Psx84p77M72vBn9z6/lpTRlnIakc7s+gXsvNiz8p9qb7eqRbF0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7793.namprd04.prod.outlook.com (2603:10b6:303:13c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 18:28:54 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5ae5:f53c:812b:5ff1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5ae5:f53c:812b:5ff1%7]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 18:28:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZYwkhPGeWI9qHCkmsk3QDzbHul68TW6GAgABJBGA=
Date:   Thu, 30 Mar 2023 18:28:53 +0000
Message-ID: <DM6PR04MB657535DD81906D7E4E4FD1DCFC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230330131109.5722-1-avri.altman@wdc.com>
 <075597d5-86df-84df-039a-50d1c6b8ebd4@wdc.com>
In-Reply-To: <075597d5-86df-84df-039a-50d1c6b8ebd4@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7793:EE_
x-ms-office365-filtering-correlation-id: b54f277c-0209-44a9-e62b-08db314c9de7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZWOcCHukdiwZHvHPimcf+drr7zkjpno0PzvKVV648KY1QgCSnW1NORWrCkNqatWc2Zj1QSjB64A4LfxKVCJGPntYqqyJ8QQNsPT7jv8/ugtFv2JOBEVoSKW6h5mAP8hSD/iVdG2p5PiYxEr6gfrDthEJdZkOSse0Njp0wIcH9bf3n49T/M4Th6Gb9owsomlqdcgUjOifyLdv5ThDjTPUDah/Ujum4pG+6Kd3CzoE+whlNJYZQEfJZSz/FRlgUhls6XRr/xfIkULUjE4B2xUnZyaEJh2c0KvmT17Y64CaciGDnMqIpnJ39VsB71Vfii/XWkj5Pe1C839qEhgcrVHkcsuRAVXeph5RbUKKgM3eJINzaACusawbuqBCJyWsVOMWRaZkEp9+wTszNrPzuH67Ohs5Qc+njKU0UkGi/vZ+yPBIZqfxkMrdbxOxEsROFMZDO6zZ8AZx/VjBW6Kym4iA9VxMRt33POMAiUbovKyNwljrigh7dP4ZYuy/WLMDWZDIUoGXE1TQBflMmswJC5QgNoH4YszRYTYYmB6eXzyY5Cka8NQOLnkzzST6HOB3h4jjUt29rRYn6893lgP2eDwDCFvXcw79vz8Us/CVLK4zEYgpCCKQotAj8ZznyUTZl4P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(7696005)(71200400001)(186003)(316002)(110136005)(54906003)(83380400001)(66446008)(8676002)(64756008)(66476007)(66556008)(4326008)(53546011)(6506007)(66946007)(76116006)(9686003)(26005)(478600001)(55016003)(5660300002)(38100700002)(122000001)(8936002)(52536014)(82960400001)(41300700001)(2906002)(38070700005)(86362001)(33656002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE4zQ1FEb0N0R21Qb2U3dUxWbFJYUUg4L0d0cHMvcmpSSHVnbXBZa2lISHFC?=
 =?utf-8?B?VE00UkZNL1kvNlZaK2hsQ1A2QldKMlpraDRtcjFlYS9YaVNURnpBdnFGMjVn?=
 =?utf-8?B?M01IQlBrUmZEZVpsRXAwMFo3cEV6b0k2Z1FxVFc3SHVKblJZa04vU2RXY3N0?=
 =?utf-8?B?NTFTL2FJSFpXaktuSVdsMDhVMU5YZmtvTnY3RXhmcm10TVN5bG1GYTJxa2RM?=
 =?utf-8?B?cGptYXRycmFoSjNvNEpkaGtKOUdpc2VGRnZhekZyaG5URE5SOEtIZG9jOEkx?=
 =?utf-8?B?bVZTWGtVVndhbi9nMUdhSFNxZlZ3ZHlybzN2Tk02dzR1a2Z3SUdDU28rWlc0?=
 =?utf-8?B?NzVFOVR6SjY5MWQ1RDNKWTFmbWpVRTdNUFdMZWE2TVI3L3VGenpjN3UrSDhr?=
 =?utf-8?B?Uk1DU0ZhOURiYVZJN2FEM3NCd21yeGM5OHlDa0dLVEQ2WHZEbFdNM2hCMXpl?=
 =?utf-8?B?Rkh6WktkalIwSng4OFpjdzVVb1FJUHAwNmU1TkJxVWI1V3c4Uk4zY3pxbTJ6?=
 =?utf-8?B?UUVtNHp5Z3NDVnVzM21iRjhpaDdHaVJDYWpmbk5OUWdTeXh3NXFpeHFhL21H?=
 =?utf-8?B?b1dNbXp5Umg3aXk2Tjg3c0xBR1RUdEttdnJTSUw1RFlBM2ZROHFLMlVubWMy?=
 =?utf-8?B?aGt5eWFKNWNWZUQ3SW1GN3haek5ZTWcxL2ZZK3NpRTdwejU0L24xSHJCV1BB?=
 =?utf-8?B?blNOWVNVV01pVFVLSzRMRi9wOCs0TXpiZTN2UThZY2cxK1M0ajlrY3gxbG5P?=
 =?utf-8?B?YmJOWUJNb3FNR0k0YUZyc3BhQ3VZZDdnTFZoVzNLckxyUkdrbEw2aitZeXQx?=
 =?utf-8?B?VzNFZC92Qml0eGMrTElsMG4zNFNQOGhpeTBkTTVSR3BpcEZ0OWxocC9BZTIz?=
 =?utf-8?B?MExFakROL2F0NHl0SjV3cVU0K2dvQjE4NHFPOUxleHRJU2ZQU2pBVnFrSFBk?=
 =?utf-8?B?Tm9qMDBINXYwWktDSCtkQ0liWkFnTFJmQ1g1Zjg1djlHYWhlMStxUmhhKzRN?=
 =?utf-8?B?SW1vQVhZZ1g1TUtIWU1Bcm5rbzZEU1FpMGxUM0twQ29hSzYrVkNCS1E4ZG9Z?=
 =?utf-8?B?dTZ1WG5YaTJRY1VTMkI2cFY2Tk9zMkZ2MG53eDhFdURWVHZ1bStBY3VzTysr?=
 =?utf-8?B?akU0VnpZK3VLZDNNTkNFeUI1QUMzTWRNb2NQMnVvbkxyYm5WRVhvbG5kVEpo?=
 =?utf-8?B?YVV1VTltM0I4M0tmNGxRTFE1bnhsZXg3cDdEY2Z2N2lTbjRlTDB0QUpCSXNC?=
 =?utf-8?B?czBRVzBGZ2gvZmJUK0hiTy95VllNZWtYR3BYU2RnV0Y4RGpqU0UzZ0RGNXZJ?=
 =?utf-8?B?ODRWQWdRMmlOd2l2Y3crbndzNS9abmRRdHlwTUlNL0ZYZU45MlN5UVFVTFM1?=
 =?utf-8?B?NjdmdlloSXlOQklOVGsyOENQUVNtRVlNaTBmVWpFREZudlh2V3JMTjZQRUJZ?=
 =?utf-8?B?dmk4TlZVNFhzV0NFQTBEK3lqNTBVMWp3dTg1Zi9ZdVREZDkyN3BzRE85K2lU?=
 =?utf-8?B?Q3NZOHJpWmc3Ny94SUJIK1JPNks3ZTd2UHVuUmsxMlFSOGlaUml3Vk5PdWU5?=
 =?utf-8?B?djdYRDN1MlkycHZCaTNxdnQ5ZFVpLzBxem9BWFFzeEE1Y1hrajJ6cmY1QVhz?=
 =?utf-8?B?VVVlODIrQTkxMmcvbldTb2pMNnRKVzJueUkxRkMya0xTdGNwaDd0TXNNc0k1?=
 =?utf-8?B?ME1TWEtXV2xVMnhhYm04blBWSEsxaWt6RkRDbHJsRGJnZFdMOVpMeGNqbEdO?=
 =?utf-8?B?b0FqUjNDYnVGbk80OHNPSXNYNUdpeUE4bXNPWnpaSytKekhwRndIbGxDcU4r?=
 =?utf-8?B?TGhaaW9pbExhNXVkaWUxRWNTQi9JYXM5dExhUlFIT052eXM2eTZlUURCZkdq?=
 =?utf-8?B?QjdHODh5T1Y0MFg3WjlmVWZQQjlOc0Y1U0tEWEkvVVJOMG1nNDF4Q3hJd0pJ?=
 =?utf-8?B?Q3hLZHRQanUrVkVRRDU4QisyRnFQT2hzQmY0Z2k4UXNGc3piVVVmQzFZVXB4?=
 =?utf-8?B?MUs4aEpjMi9KOTNkdW5kU3h3MU5Mb2ZYZFgxMDdCcEdaMUwvcmFaUTltcW9a?=
 =?utf-8?B?QWlydU54b0ZTaTVMaXp0cDQ4ZDZNRkh1ZUVmYW12ekt4MlRmM25CaWtzRHJy?=
 =?utf-8?Q?4BD3YJv3Wj2kSU2LOGYOhTEpL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j63Lu9YnkAGEOWH1ezN+qF4KYWvqnO+BC6ilTvdxEEEZGHWhtan9YoHN8lgidYGiaBOcEui4ujcp0YzARYPI7kKzIQMeBEa96wwivs1OjW9jU5CR4c4kpH5ZY548GxkRRwGIV0PjuCe0yUYrJ7ULYYHhdIoavqP0mLbcddcPzBuVOr1nBW5nDcp41LsKJCj94M2WwZckegVczpZ7fGkRaqfhp1+IppMq4ya90aFWR84cD9bt5Kj7X2uWszuDME0dvdL5FxkCYOT3ehandl4Bp4rkCTAfKDHGLS3IMCWtgxIK0wvt5+TIJSdhVhNWJSQEzdsLpvb0Pmf6iLwxVr3S0KdwddrqAZEJ7SJMZQlVVkjwlZSagPzjWmlMuTIyziEsdoTWD9A8Oa2gPiujaW/RpXIX2FUZ7lNX5cLw02XkGL2iuStJk0neKFKEdSJJae/R+VA7kKRhQAUNN+ool0dgZzMUg4tRyRA5Lkj1wWb2D7JaA87oUCrfr+iZEfPrfJA5avUo4TuQh/xjPKOvVoAw3JRVTM0nsuXCUYcn4UREtckJY5u1h/QZJVLNONMNwFX5Jdo5+RJ8qIe+f0KhdDu9BQ/I79f5V3wPW8N/JqswPBKu+9OxmlFigIAispcvMNhFf4gZZs1P25Nr9aQ3SQJSPMjqhnEYlXGhPjb+AXUS0biIkCRcfZ8yt16/a67potzsB4axSPFq0yALpqbO0aiAokseFUOlCyH1VA/Fd9O8e8MB3uFmuGvZT3Yc+nPRQe5evcDVM7KxEN5HSKvOEdxwvQuDdyDJubbbtIiDgJr9SpGH/O8inlEMxKS6KEp2ISauax0VUVsGcIqvZZjhkQnR2mWD+BGzAVVir6UbU9OYLaARGYQ/DAxihj50BR1WgDtBQTskRo6eGENRP0JK9fc8Lw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f277c-0209-44a9-e62b-08db314c9de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 18:28:53.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ISe4bljXbthQ2cMcD/F/QMJ8V8/CAdQ3BkBLjIZdW6JfRi+8Z1insc5DBJCsx3zJ9Y/f8UlAKAx7Kvxfv+jEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7793
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiAzMC4wMy4yMyAxNToxMSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gKwlpZiAoV0FS
Tl9PTkNFKGhiYS0+bnV0cnMgKiBoYmEtPm5yX2h3X3F1ZXVlcyA+ICgxIDw8IDE2KSAtIDEsDQo+
ID4gKwkJICAgICAidGhlcmUgY2FuIGJlIGF0IG1vc3QgMTw8MTYgaW5mbGlnaHQgcmVxdWVzdHNc
biIpKQ0KPiA+ICsJCWdvdG8gZXJyOw0KPiANCj4gSG1tIHdoeSBub3QgU1pfNjRLIC0gMT8NCkJ1
dCBvZiBjb3Vyc2UuDQoNClRoYW5rcywNCkF2cmkNCg==
