Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63B56CFAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC3FjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC3FjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:39:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601506188;
        Wed, 29 Mar 2023 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680154732; x=1711690732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QnSJRxItnH7+uMbVYIs8NrAdL+CtossigqsCS2smsFs=;
  b=QWnrNLB40wkBdeLQ276RSxAOGrYL/7G0JrPg70R2W6dtCky5inmH9fXi
   VO8q5SlSpR8CQEpV3C7mqNBZUS4QkkvKtvFeof+8Xld6Fe24ABOr0Oi1y
   fr3ldHOj6wDhHep49+OIvrwzeVSX/iThKjPLar/Hwc53ThRn2DVw6HdHV
   weEL+Y6xb0PKidEnsjL7GOfyc/H4R/JQDrfaMc7cBsYy40o8bpb3S6JSm
   tqkJR54B6ueJws2o4rSu9l/zSoejt9xtKiLq+d0pwXKWcJfdWMn4TwSMS
   ld7lW6cCNLV/jZTNaxFY3Zo+/DYokcx+SqFoOg6uIwIxr5fF+1bxULS4g
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="207988398"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 22:38:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 22:38:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 22:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD8cKJxPaT8JoAEMR+EHJFNQ5Ow0XX9z/9XdPniqjzBI5/cnahW0xM/GKj1KoOpY9yytLN0lpnKfy6kmXCf+leTAdlyQN+xdHG7apvcWKKiMICJ1YkuhTIjxh9bNlwUz1AT5di7PH71uU3i0QHCs9MhX0sGWSMqMg5W2ie6Z5S4Vq0LZt7KdJhIyjfrCCPH8JEm08KZzYnS7s1/WoN91zGSNIW1nBGcAxYfi30kyqmzAEjkpFQlTZFYZR6oNHNTGB+ypCix7a2Yu/KTnTS/IS7oh2dWYtobsgdi6AGGLch6vZ+ecVnvxMafvwojxyLcJdokSVqqCiBb6+vR+VcYIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnSJRxItnH7+uMbVYIs8NrAdL+CtossigqsCS2smsFs=;
 b=FsWPsPDDaLbqDuhvZo3Kyqi2Gu5jJ/kiwiATIC3olL8Q+NCHPCSBMQwbGlWGw+BrLV/AGy66gq+9znB7ret7cteH6dS8IkdFT0fgXfdv8Z4HC7ZqF5JNIun7TrzHf0SfHuOoy7ZLH0wEk1JxYMZUak/Vf38MDMFD3YUipOGNElXkk/coFdZbMJkjSMndf76O3R7x8m0krsNYgfkP6Iz+ewWqVt0TjNMr50e9Xgb0ki3VQeEARPCqYQJo7jvU9XVXqBDYfYhC3ku3u9bHh+sruz3EuH0qQd9qkcWsePzI2oqW+fP6ypfNq5rCPCnnLFM0kvdEzp4UMU8vZ5anHPkJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnSJRxItnH7+uMbVYIs8NrAdL+CtossigqsCS2smsFs=;
 b=jU/ycZc1hT7jTGFegOaaKUd/reB6/aT58DbkZCDpycmQlESmjXmWLVanNFCZu7zGn693GkZeWh4tWmGfBbZSJSXGlm+mM7CcT6ExdbTYRaGtA8Tlfor4VFK5hS2STF6ncjvVlzP1Vd55kHUTT55wWPHj6yZ61QpTZ2n01VgI454=
Received: from MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 05:38:47 +0000
Received: from MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c]) by MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 05:38:47 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v8 char-misc-next 0/5] Fix error handling in probe
Thread-Topic: [PATCH v8 char-misc-next 0/5] Fix error handling in probe
Thread-Index: AQHZYYNCHA8X0N3AtkuEDTooEx8aEq8RiGsAgAFIb4A=
Date:   Thu, 30 Mar 2023 05:38:47 +0000
Message-ID: <a3c435812f69da942520e982ea41a9f08b2ec948.camel@microchip.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
         <ZCQM9t5v2Dcet3gP@kroah.com>
In-Reply-To: <ZCQM9t5v2Dcet3gP@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6232:EE_|DM4PR11MB5437:EE_
x-ms-office365-filtering-correlation-id: ff681e4a-1b7a-488a-5847-08db30e108db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GG4W124O3jyp7vbq+S7zdDLeY7AORumMIZ0tZgNGW7C2fm3l2SLoS4zjhrK6FZLSzkaB/HgtSYs5MKEGJWMGVFd1v3YiXXvuGDa49hXZwDRKayI1lbfFdIrzITSEn/tQKrbRgbpEIiTFM2Cz17ejfMPH7Yl3AbkaF+LAtZbx4+ugmmoROidtLC7KN+6jLylIJa05phU8FScPBcmh/L2H/mbcIs+AnN6h98yoIbkNUR3AIUIpzc+tzCfeuqokQS7gwvAGTH7ayGjttQCbN0ab5afDwZjcuS1h3PKDth5XMcPcI19XvbNdT3drgNUN6zvgDcVppqkCrXi+IH9mIe9gJqQ+X3D+InLxV+ek36PZJwYE0fj/WoSQeFcMVJ6BZKNIperssW6gS0Svq7I3My0y/JoaJNSsTH40HYNORZ4KNCDssLI2V+ML7K3P51j0nZESKe7FpyOrZGCg03POTzKU40KJ4jYdWxFA+amMYT4h1SXeyEt0x/4kUMHSK9hX7ho4qFcclqBJ+9+ZZH5YIfKv2P+VeHLZmCBix/Gs4GH27Brp7tJ8xHqmJpipuT+WOe4pwdg5Apm7yDUzAIR1uezj6J9uIctKorg4yN+IDnDRQplMzxXj6l3gPhbQbrjxjgYM8hIz499FLkFFZpvtubhlABNBU/UpM/DQpq3JJZJ1kY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6232.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(8936002)(26005)(54906003)(5660300002)(4744005)(2616005)(66446008)(64756008)(186003)(122000001)(66476007)(86362001)(38100700002)(66556008)(6916009)(8676002)(4326008)(76116006)(41300700001)(66946007)(36756003)(6486002)(316002)(107886003)(6506007)(91956017)(478600001)(38070700005)(6512007)(71200400001)(2906002)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzVTMy9JZ0hzc2prWVlSYUpJaVQ1emZFbnZCU0NqVFptSDl5cDh4Yi9BdUZa?=
 =?utf-8?B?OW56eENQSzlJam13OVZ2NDJ5KzBLb1h1S0x4QkIxWGdoc2NNQjlQQlhOdWxt?=
 =?utf-8?B?cGNOakd1UlZ0OVdnWTA2SzAwRDQrNU5KWXRva2dBaXc2RzRTN0NaOGoxQWE2?=
 =?utf-8?B?bTZMUy8zUWpINDYrWkJKNzJwdVdPVlplUGh0b0J3TGEyT3cwUGpBWXJOcTZK?=
 =?utf-8?B?Tyt3N21kaHdTdkhmZ3owbDNUelJMNExsaHRUajg0bjRERHlTTXRsdDNrbE1a?=
 =?utf-8?B?MDczaGVpQXl4bEFkbUJVbGdyOHlWUFF5V1JqL083SCtYU2lBMkM0TTcxTUNv?=
 =?utf-8?B?WkNnKzUvMFE4MHk4OVh3WmU1dkhuSUF1WDRKYURkOFFnSHpYakFuSWhaWm1h?=
 =?utf-8?B?SkJ2TnRtY2F3djI1OWlYYnBZQVdWOVdscGkxa3FmVnpBRVhydFlpL3QzWmpr?=
 =?utf-8?B?b1lSelA1MUxDVCt0U3dOV2FOVk0yWkFmVmttMTRVRVRjWjErTjBkZTdEeWw2?=
 =?utf-8?B?TFNmS2pzdHZtWVZKaXgwbXRvMjRqenhkYzN3YWpFVW5qQWE0UGRYM3pQNVc0?=
 =?utf-8?B?dGt0VE10R0F1Y0ZNYVBCeE1KdVlmTlp5US9SMUJqZEFrbjNaekxVQXZoVUlL?=
 =?utf-8?B?Ty9MWklMTzk1MzRGQVBFcWo2dzUxOSs2RjQ4OTYxbkZlb1ZPNmljNWNrK3ZT?=
 =?utf-8?B?UEhDZlNEaFR5bkNMTHdWRkZLR0xMdVk2dkEwM0ZNQzZHTVk3TmUwb1Y3MmFs?=
 =?utf-8?B?YU5rSGxWWENrZU81TkhEVHBPSWY2NE5CdnBuYnlKejRJT3NvSFQ2RG9JSzgz?=
 =?utf-8?B?OGNlWEtLU3QzcXIwVHRNR1dZYnhXZ1YxTGtUOTlFMGgxeTVROVJZWUIwRkNz?=
 =?utf-8?B?N1pTUEdLc2NNeVJjcTJsSVV2MU9xTExidFJBZmp1ZElPNjl5Z01WS2RZZmxj?=
 =?utf-8?B?UjZ5L3dDUVg5ZWVOdVJSN1FFZGNUUGg1dG5xZStPUjVvajNsekRsT09HZnZw?=
 =?utf-8?B?RFFTUTlDN0NGa2NzMnptanFpc3NCTUYzNGNvOWdhWFFVRGw3a1BCRDlFSVph?=
 =?utf-8?B?QTJ4UEF1RndDYlFHUFozMzliVkNCVkJBTlJwWHpua093ZHJ5dGVMVmg2dXpK?=
 =?utf-8?B?VC8vdkxPZm5WMXZERzcxNGFTT1o1RlRxcGhXdmliaXlJR1ZJbHI2WHFxKy9t?=
 =?utf-8?B?cjRPeVVOUGdWQnRwMy9SMlFjc0ZLR1J1RGNMQ1FFWkNUUzBxa0dpVU5OM0Rl?=
 =?utf-8?B?aHhwRk5OOTZ3SW15UUEvenRyQTZFV0pRRXB6Y0hlZytMelRWVWN0NTBNNVoz?=
 =?utf-8?B?c3NwRU5DTDhBTDhCUEtrbDI2QVJtQjlxY0dWcm5RQ1oxOTJZb0ZidWZOZENW?=
 =?utf-8?B?cUtSMzR6ZXpScXNDSlJWdXJtMVNFZjU2MTFUL2djc0krNWkwN2xOL3A0SnZ1?=
 =?utf-8?B?cWhENHZ4cHdiUEVLMktkdmtoYW0wbGVxUi9sdTZkdWZrMUxlOGtWazJZZDJE?=
 =?utf-8?B?YzFUOUhsZDFVQTl4ZWNRUi9vR0EzMit6QlpDUnJoTEUvSHdrNm5XYVVmVHFG?=
 =?utf-8?B?UlRqNVZ1cXdhZlQ1K3NGbjdVaForVkZFL0RrRmFSU2VScEVQRTNnaDQxOEpH?=
 =?utf-8?B?VGQ0YWZzZ2oyM1czZTN0bE9scUFsN2hscG4yRVZiT2xySFRCbE5tY2RKWXQ3?=
 =?utf-8?B?TUtETCtYenpEdm9lcWNJdnZDUWZsL292bU9SNGVQQzB3Ujlpbm9QNXJuVkp3?=
 =?utf-8?B?UmNuR20zcUlHZ2VtVndSSzErNmZicXlLUHU1Uit4VzU1dmRFUWNyb1NZZ2s4?=
 =?utf-8?B?ZmxPSytIZmJ2RldYYzdzeGI2S3JRa2F3aHFQRVNvc1N5cy9lOVJ5UEl4ZTZs?=
 =?utf-8?B?cDVtQXRMUUUxNWp4WW91MTNqUThyWnByS0lOVjkva1k3b05vdnpwQ1d2NkdN?=
 =?utf-8?B?UTl5Nk40NEtBcVozdm9FSFNtVnZGczBPcjRjajdORSszRzRrWDUwL3QyMjdJ?=
 =?utf-8?B?b0NGT2NLSkhNU25qWG1HV2VmQTVuTGc1dmlraVljdktQU2NGdTg3VXROTGlo?=
 =?utf-8?B?K2dOdW1xS1R4MlV3emVjM0poODdydWRpcmJTZFV5RVdST0VuTFFxa3hPdG9Z?=
 =?utf-8?B?eWc3NkZiRUtFWHVEOGVZK3RicldlUEVLMG1qeEFOWnRNV3B0aWNPeVQ2R3Rv?=
 =?utf-8?Q?X/gYENmYWEjnf39Ys9B6S5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F936E002DDE542A441B7E42D8CE8FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff681e4a-1b7a-488a-5847-08db30e108db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 05:38:47.6942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLesw/7Ht06FQiI2TDPTZwno/OO2ElftDusizD2+a5pSbchS91tulP9LA+kR4uWGM34n5w4511Qhc9jtgXA0cmHk7roND1MceHsBrm1hJ2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDEyOjAzICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgTWFyIDI4LCAy
MDIzIGF0IDA4OjEwOjAzUE0gKzA1MzAsIFZhaWJoYWF2IFJhbSBULkwgd3JvdGU6DQo+ID4gRnJv
bTogS3VtYXJhdmVsIFRoaWFnYXJhamFuIDxrdW1hcmF2ZWwudGhpYWdhcmFqYW5AbWljcm9jaGlw
LmNvbT4NCj4gPiANCj4gPiBNaWNyb2NoaXAncyBwY2kxeHh4eCBpcyBhbiB1bm1hbmFnZWQgUENJ
ZTMuMWEgc3dpdGNoIGZvciBjb25zdW1lciwNCj4gPiBpbmR1c3RyaWFsLCBhbmQgYXV0b21vdGl2
ZSBhcHBsaWNhdGlvbnMuIFRoaXMgc3dpdGNoIGludGVncmF0ZXMgT1RQDQo+ID4gYW5kIEVFUFJP
TSB0byBlbmFibGUgY3VzdG9taXphdGlvbiBvZiB0aGUgcGFydCBpbiB0aGUgZmllbGQuIEZpcnN0
DQo+ID4gcGF0Y2ggcHJvdmlkZXMgZml4IGZvciBlcnJvciBoYW5kbGluZyBpbiB0aGUgcHJvYmUg
ZnVuY3Rpb24gb2YNCj4gPiBtY2hwX3BjaTF4eHh4X2dwIGRyaXZlci4gUmVtYWluaW5nIHBhdGNo
ZXMgYWRkIHRoZSBPVFAvRUVQUk9NDQo+ID4gZHJpdmVyDQo+ID4gZm9yIHRoZSBzd2l0Y2guDQo+
ID4gDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBUaGFydW4gS3VtYXIgUA0KPiA+IDx0aGFydW5rdW1h
ci5wYXN1bWFydGhpQG1pY3JvY2hpcC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGhhcnVuIEt1
bWFyIFANCj4gPiA8dGhhcnVua3VtYXIucGFzdW1hcnRoaUBtaWNyb2NoaXAuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEt1bWFyYXZlbCBUaGlhZ2FyYWphbg0KPiA+IDxrdW1hcmF2ZWwudGhpYWdh
cmFqYW5AbWljcm9jaGlwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYWliaGFhdiBSYW0gVC5M
IDx2YWliaGFhdnJhbS50bEBtaWNyb2NoaXAuY29tPg0KPiANCj4gDQo+IFdoeSBhcmUgdGhlcmUg
c2lnbmVkLW9mZi1ieSBmb3IgdGhlIDAwL1hYIHBhdGNoPw0KT2sgSSB3aWxsIHJlbW92ZSBpbiBu
ZXh0IHZlcnNpb24gb2YgcGF0Y2gNCj4gDQo+IEFuZCB0aGUgc3ViamVjdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgdG8gbWUuDQpTb3JyeS4gSSB3aWxsIGZpeCB0aGlzLg0KDQoNClRoYW5rIFlvdS4NCg0K
UmVnYXJkcywNClZhaWJoYWF2IFJhbQ0K
