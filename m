Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3996D1B04
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCaI7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCaI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:59:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DC71C1E7;
        Fri, 31 Mar 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680253162; x=1711789162;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7JeLUm1flPE29zZTeWAh5WTrOZSNdN6D01crlJZuAl0=;
  b=CuqWI2MLWPSsLm6d5mFesjOmp2GTIE4Psv3fuUESdwpbX7DvdZtgLq3u
   SyB3rYTsiw0Rfgs8/8eE9QyFpcLifIO2/HH93O0WtvvDZDQRzg+NBKpHu
   I87EKxGm0t8vzleS4O4o6ShSGLPcEgg1uY3CPDUPXHZ9czhRuY/2FqxCa
   jVI7ptHi2c9pcalr8Ag59SGNEL4CxOz39SlGUUyk8OuJumTljcW8pT301
   1HSGvMWAgdoF/lpv9OTPlDwzwqd+BGqwQPCDHHIijztLNvtXO/Wv6W8eR
   m3wgMPT95UJtwcmFXt4ekPlucYSCJrEwvgrHPGHo+gGQN/dAFKH0fMkkr
   A==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="144853886"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 01:59:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 01:59:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 01:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4h1e4PMX5aGIcYqFO7HZq3wWNXEX4cRYVBjw0+ZJJq81IsqBObPS0OhpJM2nWsTOGuNacnkUTJfigOUIc50OmpHiHmx1iXH3p7QrEDaENUYThmbR97hw98GYOzdK2bANRPGX/7wfMZPwG7iKKwWJZ8UF8IZhZpvq2TXkzgWuqBA14tW1gbpJq6bKhm0hDvf/k6LUodyTNRyUQURpjIkwRBdGemru3Tn1pmOeuMMDHMVjowtGiIXJwd+27ph+X0kIBuYnM71rbxgMG7vL69i5VrkJRVCczveJfhjuSdWOCioITJUbJDxIUMJZV57DbNZjzx6vjojUruzZYIQoNZW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhy5zW5gD8C9N0iamZ8G9HnN9LDbx/ik07QFLp2hcGY=;
 b=ftJGyoNNOP6yQquXiMG9NCOjwZTU9e6/H+yujKRVWbNXu4b6DHdLK2dQSYMVvI45mHJVV+e4p+NvhJN8y74ApexbAhqDcGkWjDK5velYxe2xL6giu4VvH24ygV7clQ2Yimbxi+63BxIDsx7YRTMNTaTUJ5I9hzxHZByf85pcGEANjmAB8JbRi/yQ4o1Cs+7uYbfY6GcN4HvV3ZM/CcxLymtxeky13L2DFDgSm03d5uLEUGcb/5UX0CaJNKeAM8gAluOXCjz3a/k01SIVyDvp0oaS80NL0iptaqfatEGNv8f1S9F0U6ZO688B0DBme4djSzjiwD590eW0cw2oe3Ysww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhy5zW5gD8C9N0iamZ8G9HnN9LDbx/ik07QFLp2hcGY=;
 b=sAJakceB1Rz0l2tIYd8LLo+2m6HivH5k8fLmbhMO/O1VtkgPS6RZs3+xSbhpWvvjH2kUidttfnZL+nNdyCin8ZXf+U9MD5/HOY4TyN0Q6Z6SxvK29qkWerV5cx3J3JDHPQQG27GDdcpUll+rcxaXoc8HuwTy6b5xR1gzN4VKkXw=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 08:59:16 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::3955:3a7f:9826:3670]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::3955:3a7f:9826:3670%5]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:59:15 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH SPI for-next] spi: microchip: pci1xxxx: Fix minor bugs in
 spi-pci1xxxx driver
Thread-Topic: [PATCH SPI for-next] spi: microchip: pci1xxxx: Fix minor bugs in
 spi-pci1xxxx driver
Thread-Index: AQHZY68RSielozKbPUWWNAGKJZFtSg==
Date:   Fri, 31 Mar 2023 08:59:15 +0000
Message-ID: <754b57849925e48401e6ebb3d206c966a8a08800.camel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|BL1PR11MB5955:EE_
x-ms-office365-filtering-correlation-id: aa8aa00a-d751-4431-9e50-08db31c6345c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfOWGKptqnbMNDhLJLztxjdvDVSCnTXKS3yDDujv/7UrrhDVjIIn16OvSjVWXkyCDzH+2YQ8mHkv26H+rOIXuvJ4zlox/M7G8/tw56To0mUIXKJ1FLhyXauItBit7/6ub+UM8Xhyrl0vBRoA4bQW+dvc0oXgni2uLntc1T1lf/kul+4VGdQt/2q7QNNjkkqwkI6RuLJpxAFl+YXef2h6sr/xbGjj0/raVocE2IBFTcYnLDyf2f42ORN9omY8XTrEJX1ekbe9Z5DjifhiVCcIeosv9H6Up/3Wr9GqoXqRZpf99ENCFlweNfWFeqlQYNHHSIQkd+DWCCNlilqL+GJmXWIPO5dHnusZTkbn7bp+Th3eXgGLQATH2JfEhbV/8FfESsETdwvfLKsOU0GgMlH35KCz7Y7PB7Y/jbEAT2JNL7UpfTEBOPdQRs9fxgqdCO0ukyBa39pX32eJjRZ+chIsOSM4ESuQZK2diKo410/c43aFO+2QqpmV7M4JehGhO2qI1+rxSDSEkJGwRcqAEGL4F20kF94eG+aPvSHIAXGbdCeCAD9Mlw8cEvQXCQHU38dpa2a239eEN2PD9yVFHF+m+1ZgpNKsgCtQ2alwbeO1ktBYedW5xi/YkDx9pgfqaqd0ZVsZf5a53CLt4LV72AUICIymaKzy8lGzak6e3nxVN7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(64756008)(36756003)(186003)(76116006)(6512007)(26005)(6506007)(91956017)(41300700001)(5660300002)(4744005)(99936003)(8936002)(4326008)(66476007)(38100700002)(6486002)(54906003)(71200400001)(478600001)(316002)(66946007)(122000001)(66446008)(8676002)(6916009)(66556008)(86362001)(2616005)(2906002)(38070700005)(32563001)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FPc0FZY1cxZkVPZFNRWkc0RE1ZRzNJaWhxNExhenk4WHVnZTBuY25WOFU1?=
 =?utf-8?B?UDJzV0IrRlhkODVKRnZSZW4xNUluWFZoNzVHUkhlUXdzN3hTTFNlVkFES3Fo?=
 =?utf-8?B?cGNUR2JIVHpHb1kreDdnSHM4UVord295dkd1OFFWK3lIK1o0WnZENXhKeEhv?=
 =?utf-8?B?RWtNS083T2JWQ0E5dWttRGh3ZGFFTUtIdG9mbUhLd3NBQVg0NzFQYmd3eTB0?=
 =?utf-8?B?ZE5GME8xc3FrejNsQ2dIVVZyNDk1bXZud2tyb285YzlUamJubkFRSWg1dUc2?=
 =?utf-8?B?L0kyMWJlaVBFeGZEcEJVTFpLSVlkU29zVE5EZGVVbnRoUWZCNllnN3pOZmh5?=
 =?utf-8?B?MGhXaTMyRnhSRmtxQzg3NlFuTU9OdHZjTjZYUjc3WkllTzRLN3djWFFwNVpU?=
 =?utf-8?B?bmRMMUNvdFNVUkRiSTVMQmhoMm03TXBISzlJTUJCMGZydzVmUkNQcU41OERv?=
 =?utf-8?B?MHpNMzF3WmdJSUxKZmJBakVNLytzRWhZaCtITlZjN1ZnS0R2b1FOUUJKWGhI?=
 =?utf-8?B?d1ovR2NHRmRqMXVPR0k4aDFlMHlGT1g3WmRsc1AyYU1jbEo3b1hSV1Yvb0Zl?=
 =?utf-8?B?L1JmUnBQRnNIVjdnVXBqUHkrWnI4WVFackFXRjJWZnJLWGRuMmpYTm91VmNY?=
 =?utf-8?B?ME15VnE3TGlKckhiaE9XTGVkSzI5RGo4azQ4TFpsNDYxQmxUZUg1WW9zRGtm?=
 =?utf-8?B?bUJNTXV6a0pmQmpqUnpIUHBuRTR3enc0NEppeEQ5MGRnTXo3VjhlYjZiOG1p?=
 =?utf-8?B?TVlvZDdaVXhPdUxESnRnbk1hN1N0SVhCQ0Z3MmZMbHQ0L1VhUVE5WW5iWFRS?=
 =?utf-8?B?M21mN2h0NzNTM3RXUmNMWXFZRVVjR0h5T2NtaVQyR2lYOEh1Z0dhMXVVZlhh?=
 =?utf-8?B?WkJlbERWY3ZyYzRPOU1sNnBWUXJJRnJXeUxPZFNzeEJwUU0yZ2R5MGZQMGJK?=
 =?utf-8?B?YlVaNldFbkNML3p4NlJGTmpvK0ZaRUd2akhZdndUL2JyMDVFMjU0bUsxN20r?=
 =?utf-8?B?WGp5N3J0MURwUDZiYWllemNQMmU0WmVIYWorRVZpQWVwaWNwSHNGMnZGL1FU?=
 =?utf-8?B?VStKVkhUMXZKbmVhSStXOWhCMnNObXZkSGRNRkRCR0QwUko3bTVQaGVLLzNz?=
 =?utf-8?B?azZ3NHBoaEZWeVF4azV4ZzB2QU41d1RjelUzMHF0WCtvNEs5TzRsblFVTURr?=
 =?utf-8?B?cjNFNDJ6QzhVM25LL2JPZVF2ZEpWT0NWaG5lbEw5N2xYR0I3MGVtSnBaUzNj?=
 =?utf-8?B?MThjbWNtVlhxL1ZKVlJXakJhbE53SC9sZThKK0tkaGYyMCtIUnRpWE9KOStl?=
 =?utf-8?B?b2luVEJWSGcrcmhGTlFoajhUWjFMSVllYllSbW1YUG5rTTZoalI4eEQxMTkz?=
 =?utf-8?B?VDlsS0RRTytkMkVDWk91VDhUK01QbTMxUy9hSG1EZmJIMmFwNGl5enUrczlS?=
 =?utf-8?B?UUR2WDZFRzIwWVZZQjBac2JwTHpVWDN2c2Rnb21mR3l6SjFWQm9IVEtIaWVP?=
 =?utf-8?B?NmdhSTQ0Unk0NFZVL0E2VzNZQTlwZ2RmZ2tCVEdyV0tIcGFsS3VaNml5eFpC?=
 =?utf-8?B?WFIvbGI1TVRTZ3VYOGhEemw4ZXlCNDEyOTlUdERsa1VBU090M2d0VUJvNnlw?=
 =?utf-8?B?YW83L29DTDlSVFBxNGl1SFZtR2d1VU9keWR3TThPcGMzc3BOM2FXSWY4b0N6?=
 =?utf-8?B?R2ZrQXlmcUZFWVJGam9tQWo5OFBFQWg2QXUwblNIay9jdnozVUlLSmhubDgv?=
 =?utf-8?B?MWdUSUxaN0F5UWJtZmp6cHlTd2ZtMlprU2FkbmdGUXJodTZHRzlBZ3dyaDN5?=
 =?utf-8?B?c2VVYzlrbTlXYkQrVmtISUVaOHpQMmswaEorZnpYc1JKNVlCeWFiOExYdmJW?=
 =?utf-8?B?Vi9ma3lIMTNFZmJRTVVDWUQyeTBtNmtRTkJ1QVVFRXFVK3ZuZ1E4TDc4M1lV?=
 =?utf-8?B?bHI0bExjaDV2YlhjN3NETGdQOWZwSFU1ajN3bW5GRE4wYTJGVVQ5Vm9ibzFK?=
 =?utf-8?B?cVM0WTFJQ1dWVWN2Q0xxeVI5MEVRYTgzYmtzdmJlTzRWVUttUEk0NjNzSU85?=
 =?utf-8?B?SllzZWJJNFdaUFA3bnl1MG1PVkRrcjhtRGcybnA4OVlBeHVMbWwxK3NrUjlL?=
 =?utf-8?B?NzdiNEZHR0RCb3cxckRCQlFXSHBIeGk3UTJvV3pWekZadVdpTjZ1Z1VONEFm?=
 =?utf-8?Q?SmCAMI4+n2RyX/1bqEG71KQ=3D?=
Content-Type: multipart/mixed;
        boundary="_002_754b57849925e48401e6ebb3d206c966a8a08800camelmicrochipc_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8aa00a-d751-4431-9e50-08db31c6345c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 08:59:15.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4Vdgolj0VdLtrCMD5u+Q/VCIXjMI4Ehnn0mRQ+jsmoEQZvcMMv4RAb1gGHRn+VhuwcWNqiQnOEx5FVsXHMkhtrJg0/bKmHpLuNuHbnbSJu4XhgROKNW24zsYXiiU53U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_754b57849925e48401e6ebb3d206c966a8a08800camelmicrochipc_
Content-Type: text/plain; charset="utf-8"
Content-ID: <01292FE03006E84D8B424D2191F46D73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

SGkgTWFyaywNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIFBsZWFzZSBmaW5kIG15IGlubGlu
ZSByZXBsaWVzIGJlbG93Og0KDQo+IEFzIGNvdmVyZWQgaW4gc3VibWl0dGluZy1wYXRjaGVzLnJz
dCB5b3Ugc2hvdWxkIHNlbmQgb25lIHBhdGNoIHBlcg0KPiBjaGFuZ2UsIHRoaXMgbWFrZXMgdGhp
bmdzIG11Y2ggZWFzaWVyIHRvIHJldmlldy4NCg0KT2theS4gSSB3aWxsIHN1Ym1pdCB0aGVzZSBm
aXhlcyBhcyBhIG5ldyBwYXRjaHNldC4NCg0KPiBJIGFtIHVuY2xlYXIgaG93IGNoaXAgc2VsZWN0
IHdpbGwgZXZlciBiZSBhc3NlcnRlZCB3aXRoIHRoaXMgY2hhbmdlPw0KPiBOb3cgdGhlIHZhbHVl
IGlzIG9ubHkgd3JpdHRlbiBpZiB3ZSBhcmUgZGlzYWJsaW5nLg0KDQpJbiBQQ0kxeHh4eCwgdGhl
cmUgaXMgYSBjb21tb24gYml0IGluIGhhcmR3YXJlIHRvIGVuYWJsZSAvIGRpc2FibGUgY2hpcA0K
c2VsZWN0IGxpbmVzLiBJIHdpbGwgdXNlIHRoaXMgYml0IGluIHBjaTF4eHh4X3NwaV9zZXRfY3Mg
QVBJIGluIA0KdGhlIHVwY29taW5nIHZlcnNpb24gb2YgcGF0Y2guIEN1cnJlbnRseSwgdGhpcyBi
aXQgaXMgdXNlZCB3aXRoaW4gDQpwY2kxeHh4eF9zcGlfdHJhbnNmZXJfb25lIEFQSS4NCg0KDQpU
aGFua3MsDQpUaGFydW4gS3VtYXIgUA0K

--_002_754b57849925e48401e6ebb3d206c966a8a08800camelmicrochipc_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Fri, 31 Mar 2023 08:59:15 GMT";
	modification-date="Fri, 31 Mar 2023 08:59:15 GMT"
Content-ID: <5C6CC5E83827204580A74120B2D52E82@namprd11.prod.outlook.com>

Received: from DS7PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::16) by CH3PR11MB8381.namprd11.prod.outlook.com
 (2603:10b6:610:17b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 13:44:22 +0000
Received: from DM6NAM10FT084.eop-nam10.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::ef) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 13:44:22 +0000
Received: from email.microchip.com (170.129.1.10) by
 DM6NAM10FT084.mail.protection.outlook.com (10.13.153.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256)
 id 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 13:44:21 +0000
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 06:43:57 -0700
Received: from esa.microchip.iphmx.com (10.10.215.10) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 06:43:57 -0700
Received: from dfw.source.kernel.org ([139.178.84.217]) by
 esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar
 2023 06:43:56 -0700
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140]) (using
 TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client
 certificate requested) by dfw.source.kernel.org (Postfix) with ESMTPS id
 018AF61537 for <tharunkumar.pasumarthi@microchip.com>; Tue, 28 Mar 2023
 13:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C1BC433D2;
	Tue, 28 Mar 2023 13:43:54 +0000 (UTC)
From: Mark Brown <broonie@kernel.org>
To: Tharunkumar Pasumarthi - I67821 <Tharunkumar.Pasumarthi@microchip.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH SPI for-next] spi: microchip: pci1xxxx: Fix minor bugs
 in spi-pci1xxxx driver
Thread-Topic: [PATCH SPI for-next] spi: microchip: pci1xxxx: Fix minor bugs
 in spi-pci1xxxx driver
Thread-Index: AQHZYXtoAkmg0Jz2n0m0Uw2JIelspg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 28 Mar 2023 13:43:50 +0000
Message-ID: <97c57e1b-9779-4e36-9eac-754fdcb9c504@sirena.org.uk>
References: <20230328054212.139312-1-tharunkumar.pasumarthi@microchip.com>
In-Reply-To: <20230328054212.139312-1-tharunkumar.pasumarthi@microchip.com>
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: DM6NAM10FT084.eop-nam10.prod.protection.outlook.com
X-MS-Has-Attach: yes
X-MS-Exchange-Organization-Network-Message-Id: 691ea8b3-38a8-46ef-d8b5-08db2f928928
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
received-spf: None (esa1.microchip.iphmx.com: no sender  authenticity
 information available from domain of  postmaster@dfw.source.kernel.org)
 identity=helo;  client-ip=139.178.84.217;
 receiver=esa1.microchip.iphmx.com; envelope-from="broonie@kernel.org";
 x-sender="postmaster@dfw.source.kernel.org";  x-conformance=spf_only
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2PS2/CgMOCO2Hp2O"
MIME-Version: 1.0

--2PS2/CgMOCO2Hp2O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 11:12:12AM +0530, Tharun Kumar P wrote:
> Following bugs are fixed in this patch:
> 1. pci1xxxx_spi_resume API masks SPI interrupt bit which prohibits
> firing of interrupt to the host at the end of the transaction after
> suspend-resume. This patch unmasks this bit at resume.
> 2. In=A0pci1xxxx_spi_transfer_one API, length of SPI transaction gets
> cleared by unmasking length field. Set length of transaction after
> unmasking length field.
> 3. Remove support for disabling chip select as hardware does not support
> the same.

As covered in submitting-patches.rst you should send one patch per
change, this makes things much easier to review.

>  drivers/spi/spi-pci1xxxx.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

The subject says this is a patch for the microchip driver...

>  	/* Set the DEV_SEL bits of the SPI_MST_CTL_REG */
>  	regval =3D readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> -	if (enable) {
> +	if (!enable) {
>  		regval &=3D ~SPI_MST_CTL_DEVSEL_MASK;
>  		regval |=3D (spi_get_chipselect(spi, 0) << 25);
>  		writel(regval,
>  		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> -	} else {
> -		regval &=3D ~(spi_get_chipselect(spi, 0) << 25);
> -		writel(regval,
> -		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> -

I am unclear how chip select will ever be asserted with this change?
Now the value is only written if we are disabling.

--2PS2/CgMOCO2Hp2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQi7xIACgkQJNaLcl1U
h9Ch8gf+O/MluZL0YuDTHhZLLMwc6B5ISaKg7aLC6AxuIXjQ/I04oR+OhSexo/p7
KvgYa4WouYJxeZim7h98p2qWUjMrTTfUltXnbifLd6L1N3g/l/S1jr6DPGaa2SwV
KiFB5DO7cNuc6GVun1Sv2Q/15w39UbMwRUfqioeHluDn2Na1dCjab8t8G2AokU0B
gzWGZ7mSU+aSf+kmNlDHImh6rsQJqDIkD39CxLppbcyTSIB3WBI2kyCY5LbUhxUE
wdGKDtuVwyfHZHBY/EY+ejyb0mccWoxdshAlcyCN6gj5WVo8Y45B5eoZliBEc60b
6epymPQxByl5AL6IX+XyDTxHg12TLA==
=eYBI
-----END PGP SIGNATURE-----

--2PS2/CgMOCO2Hp2O--

--_002_754b57849925e48401e6ebb3d206c966a8a08800camelmicrochipc_--
