Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23377621EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKHVlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKHVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:41:34 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584D61B9E;
        Tue,  8 Nov 2022 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667943691; x=1699479691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gR1aI7hCedeOJlfxGR2BXVYxBWVuSYchUxINrF477eE=;
  b=Rr9cHTQrUln/EsEEXJe0E9rgIc7oRctcRAl6ktt4xZIeOt99EDKsLQhq
   5D6laz2sUNyFWrdelhlXiK9yu7zW1qfMM8nMBLj9GEG2/Fxhfo8Xn4NUH
   bcA26P5XsRjatiY+02YQxa5YOTnnUPYisWuq0g+uxnIoUD+N2LquUM8kl
   IFqkPIUTx+ieSk2+7ym/w0fH2y5Z73uz3ZhpL1LD65ByuSg2Um1Q0NFHv
   ptiuoZ2IXQRE7vS/9fDVWJr2XtN5zI/xxwPaa+ZCVmXWg4r6trEIP17W5
   8MjCBG0M95mjL2HuWlp2CpPyFl9xsHOlPOzh3LEpWFQMVr3IdhliF3C6s
   w==;
X-IronPort-AV: E=Sophos;i="5.96,148,1665417600"; 
   d="scan'208";a="214078872"
Received: from mail-dm3nam02lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 05:41:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXXOBMgJiLJet+lR6TScQC5Y1T3FprDNi98e23STmV8DYV0LqHiDqG7NeMmPemnpVBIHqyLND7/mP1T+FmvHg/J/nhkkhjKotu3U4FNHeAZ5HCqP2ra+i4qMpViqfRHjZ10J+GuG5YV4Do5SDIb2hHh3yRIC/GBTjflmXK/j8J3a5qqYM/OWQNUHkk1Qii3mtf6PjdYnBu98tou94NbhFCGxUcmQGLiVVNAJcLfbiJ1UXjBsA+j+YwFKRHObd5haInyMHLxaHUzYBarlWYBYMRaGAasmP609HqG8AJMnbawuwyMUAlyQ+1CkIqPkoS9+j6Cnywcc1IOvTMbiY3nbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR1aI7hCedeOJlfxGR2BXVYxBWVuSYchUxINrF477eE=;
 b=GEm0SCNIu5H8N4iInK019d0O1RAGsPNsO3/z7jbqjoA5WGMVp5nSKfbIanecjq6oTa1g4jieNupiuS1d6ofBs97lAXN0V1NH+JdFzrEX0463tyklm4pwGY+y8nRofAm0hRuLMfJOcTIKEbMyqCrzJg185HvlWMa93ImGstRis26CkK9Ba+Hl6cTzBulFitYrfQBLBR+eihemsLyvoPJ20U/9G/D76BpRQn2Msao0G22xPFwWuT/AYontBmAbgIoeF66GLSDDlg/pAM3syi9qh0RzlGvMwYR1pk5Y73G62DzF2Z1YCE9yUG+EpXUwT/V1VGd6ZHeIN3iUDJ58JnNycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR1aI7hCedeOJlfxGR2BXVYxBWVuSYchUxINrF477eE=;
 b=CIRM31oQhO6fvyhOSRd1bbNAjdnCMKb5dbhZwjH4HkZ3zKBYxZDED3PTEJUBrYPJ/QE5VaoStNeSV9qoA4C2d+/b/LiDkKdSJJe9r25AzRojQIuKS6sowLuJ4b/ORCFuem40c4TICdkbrN132DUX4gvETR23qVOdKyoVo/LPk+A=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN6PR04MB3854.namprd04.prod.outlook.com (2603:10b6:805:48::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 21:41:27 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 21:41:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 1/2] ufs: core: Advanced RPMB detection
Thread-Topic: [RFC PATCH v1 1/2] ufs: core: Advanced RPMB detection
Thread-Index: AQHY8qptSXvFlqlwnEWjfKOYjvP9p641BisggAA4zwCAAE/ugA==
Date:   Tue, 8 Nov 2022 21:41:27 +0000
Message-ID: <DM6PR04MB6575CEC34FE02E79873E3196FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <20221107131038.201724-2-beanhuo@iokpp.de>
         <DM6PR04MB6575145B168BB80F3D2910A7FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1eda1c55fdf8292c2912c6d0adb741d8dd7f0a20.camel@iokpp.de>
In-Reply-To: <1eda1c55fdf8292c2912c6d0adb741d8dd7f0a20.camel@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN6PR04MB3854:EE_
x-ms-office365-filtering-correlation-id: 1cddf0c1-b337-44cf-347d-08dac1d1fd96
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pS0lCcNjOUL/CdBNi6grVRZKVgpKaiPocdLlut79LZh+kuCBbVGxwzQCntGYTxr539DFQ8DKjwSkqPoxe8wc9DWE1W0SZ/lWozfXTNNchT2FUzrZMNONLE2r6hXP4oXVszoGMtxIiV5Tmj75X1Pc6UyaGLOz65V6K382NORaE1Bou2LT21FO89KhUPvEo9fy1MT6eyiPX/DbSzv9mRph7VHMDAGSDi59xjWRFF0Re8mGMTz1wygiPVm1i8vExV+sRpLaNUFIaYolDFDcwv6T2FMqD/XlJzs4KF+gqjTxInh3eLcGUTE6TcDcqdFmj04exvo0BaKudA11Nusn8jsVQY0GbKbx2xiX/jPXizWVcSFq4oLRO2Q0n9ln9i/fo7QPXXpaVbeEuExTjVeRNBeuYM0VOq+QJCyU0cIeYqVSsbWuPTnvmGE3Mpac4pP4n8JKQaIpBpOwHJrKS/4YwYomBezUHcvTUYSQ/qO6WNN64oyKVEZDaJyMMyc6r2MH5/eoWxSdsIV3cHverw0Uv2RdpivBoWtJjI2QuWRyQSsHxUd4Le+Q+4N+RO+hXEoR8DtiZw4WoX0m1cRyH0UfvLif8+i2LLdfkky5ewkbsyyYEmAvUq4yB0/Bx4RfEZGucacKezvfHdNaFQMqNCmoHRgMHtYtwc1r8ZAxeLXPE3/+wra6sGyl0VZbHiks/Q/NR0Dnvn5KkEevBC4Tv7iBx1I01B349DfW4Eym7+ldp0fcYEIwnKeorh3hlzBpNK6fOCsSxbeuUDgIK+G8sTEAKQoN+WSYRnwmviv3lyyOPI93PcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(316002)(8676002)(64756008)(66556008)(66476007)(66946007)(66446008)(86362001)(4326008)(54906003)(41300700001)(110136005)(7416002)(5660300002)(55016003)(52536014)(76116006)(8936002)(71200400001)(33656002)(186003)(2906002)(478600001)(6506007)(7696005)(122000001)(9686003)(38070700005)(921005)(26005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJSU3RackZsMXBKcXBDaHllSjA1dG4zbjFWekYyRnRIaC90SVhNSlUrUnlM?=
 =?utf-8?B?bjVlMVBFS1NtUWtUS1RwVEpKUUt1eEEveWlTbk1teW93aFlsWjRVUWZNeEY0?=
 =?utf-8?B?amtUVklXemxES3gxdlptdXIxRHYySXZ0Z3JyYkpuZ05jWkJ3RkFmZ0lLR2xl?=
 =?utf-8?B?OHJiQ2hiN3lOZFFEUUphdVI3N2I4NEowdVNjNUFsVWJMQ0pRK3NUek56Z2JP?=
 =?utf-8?B?OStSeDNFOVFyMmZOZEh5UjhUaTR3cVRIVm5xUWxwQVBoQnd3enV5TGlERXJX?=
 =?utf-8?B?SUFDanpNU3c0N3dpRGxiNDQvVnBUUWt3eTBTbUVVUzZKTzQrbURYYXI0c2tZ?=
 =?utf-8?B?WmFSZFRudlJZOTJ4eHI1OXhrSTlEV0RybG80bHJCZVhUeXpoTGRuTGhWSGlL?=
 =?utf-8?B?Q056Zys1T0NLS1NZUWh5YlkvMDBlMXNDOCtna1c4NDNhK2JSeThzR0JOcXpP?=
 =?utf-8?B?OWplOGpYYVp4eFJkNk1XSCs3OEd1dlZtMVZJbWZHalJjbG1XWEdZWHJkM0FK?=
 =?utf-8?B?SXN6VnpsNW5IMHJUM2RZV1JXVktuSUpaOE5mbFNTSEY5Snp0NnljeUE1K09X?=
 =?utf-8?B?b3dkcllHVUQ3N0laMUlDQTllSCszL1p3SjBBb3V1NTB6OTA0VW5pMm53MXpz?=
 =?utf-8?B?ZDVmdFdHU2FYbkM3ZS8zNithNVRrUFhkQUxyOUVCbkZNYzBpT2p5by93MXhM?=
 =?utf-8?B?dWlrM3BTT3NncDdERWlzZ2l4YmM1cTdQc2VlQ3MvemtVTUdDUC9MOURGY0Za?=
 =?utf-8?B?QXRidjViYzR3NlRXL3oyOGlVUEZDMmVzL1g0WkJnUm1VT0F3V2Q5ajZ0Rmxq?=
 =?utf-8?B?cEtQZlBLdjBLZHZLODBkVXJoWFh1T1pjVFU5bk9BN1k4dUZFOW1LbTdndlk2?=
 =?utf-8?B?TDR3SnN1L3JjdTBOOUFCc3VIWUFZYjhsL2JYNm81YUh2bU14amlhcUI2NGdJ?=
 =?utf-8?B?bUNDeis1WXdKbTlKUGJrbWJxNGdtSUlFd3l4ZWNWSW1YWmU3M0xtQzBINXJR?=
 =?utf-8?B?a2pNM1ptMkV5SjBFR09YS0YvQW8xRVl4K0tETTNuWEVWOXF5TXpxTGFhMGV0?=
 =?utf-8?B?VUFObHcveXBxaHZVVUk0dXVwcDU5T0hTUlB0REJ4QXBXN3VJRmJCSk11U25h?=
 =?utf-8?B?YnRvYkgyNEZEdDB2d0U3YnRjUlZ2T1hwUXZLVW5pb0xhNk04bHFidmFWNEF2?=
 =?utf-8?B?eWFwUXNwOWZ1WlRUQVQxTkFwd2lXSndaY25NeWs4bmdEQlZLbGhzNGJhckFz?=
 =?utf-8?B?RElCN3BPU0tiWTZpSlRyNDlUU0Z1SGRhcVcxam9BWkZZaDFlMzZ1THQ1aFRF?=
 =?utf-8?B?U1VXMTdnZkt1TmZlWkFTUG1kNkxyaWN2Uk10RFBNa254b2VPenNxOVpPZHRG?=
 =?utf-8?B?bEV5dDN0dUd0L0dPOVRWbEx5RGVvN0JPQjQyZlhUM0VLMTB2VjBSeWhGelFk?=
 =?utf-8?B?dEwrZGNlN0JFNml2Ymk4NzlLWXBlV29EZU9qRHBCbUwrVUEyaW5LK0lJMnFR?=
 =?utf-8?B?NjlsODlCNmc3UHdLaU9sYlpqendUdFdiWkpYRjRmU2ZTWVRSb3pHbDEzeWl2?=
 =?utf-8?B?S05TUHVUOEVuWlVpdlJwM2k2UzJTNU1vYzFQa29GQVRaQ003TVBnY0lTanhH?=
 =?utf-8?B?M1J4V1ZpcHFNeUlnU0JXbVJ1enQ1STd5L0NLMUQ1Z0V1RnFpcFRxYm5Ya0lt?=
 =?utf-8?B?NTZVWHFvbC9aOUlVMWNxcVo3VzJTVERrUXkvVFQyUllndVJ0bFNPZDFVUXRX?=
 =?utf-8?B?OXcwRVJSckdmRW1hYkc1K3M1aFpIT3c4R20yT3hKN0dKbFdrOUVYUC94YVk2?=
 =?utf-8?B?NysvWERGOWlUOEFIdkxrUnF5V3k5Rnc3NTFtN3pBQ3owenhBZ2crSGd5SFM4?=
 =?utf-8?B?OHVoOCtGQlBNdUdjVmIxcEhteXR2cCszTU0wZlF1UFBSNTlGRVJBeWNXSENt?=
 =?utf-8?B?Yzk1bmFkNVJiR0RpdHp3dGgwQ0tQWXozbDhrUlRtNk5BVDQwaVFISnNsT1ZH?=
 =?utf-8?B?T1RvMFdTL3M2cktmR0VYM2FIZFN2TkVLQnJrRWlQZWV3UEhYbGt6eEJrYmZh?=
 =?utf-8?B?YUxLczZBMENCcllWTjJ2bkJZcmRHOGpheVJ3MFg3eFpXSWcybTBUZkdkdDIv?=
 =?utf-8?Q?g96k5eFbJhPeW8LleA2zhjL65?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cddf0c1-b337-44cf-347d-08dac1d1fd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 21:41:27.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mp1zSg797+olZd9wggjUE8xcs8bxvoh/nfMIqY6pimlzinat0bgyS1APbzpnQC0g9+QR/bHDUzLZ15w3nOo9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3854
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBdnJpLA0KPiANCj4gdGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gDQo+IE9uIFR1ZSwgMjAy
Mi0xMS0wOCBhdCAxMzo0MCArMDAwMCwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBC
ZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiA+ID4NCj4gPiA+IENoZWNrIFVGUyBBZHZh
bmNlZCBSUE1CIExVIGVuYWJsZW1lbnQgZHVyaW5nIHVmc2hjZF9sdV9pbml0KCkuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgfCA0ICsrKysNCj4gPiA+ICBp
bmNsdWRlL3Vmcy91ZnMuaCAgICAgICAgIHwgMyArKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9j
b3JlL3Vmc2hjZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiA+ID4gaW5kZXggZWU3
M2Q3MDM2MTMzLi5kNDllN2EwYjgyY2EgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3Vmcy9j
b3JlL3Vmc2hjZC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ID4g
PiBAQCAtNDk0MCw2ICs0OTQwLDEwIEBAIHN0YXRpYyB2b2lkIHVmc2hjZF9sdV9pbml0KHN0cnVj
dCB1ZnNfaGJhDQo+ID4gPiAqaGJhLCBzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYpDQo+ID4gPiAg
ICAgICAgICAgICBkZXNjX2J1ZltVTklUX0RFU0NfUEFSQU1fTFVfV1JfUFJPVEVDVF0gPT0NCj4g
PiA+IFVGU19MVV9QT1dFUl9PTl9XUCkNCj4gPiA+ICAgICAgICAgICAgICAgICBoYmEtPmRldl9p
bmZvLmlzX2x1X3Bvd2VyX29uX3dwID0gdHJ1ZTsNCj4gPiA+DQo+ID4gPiArICAgICAgIGlmIChk
ZXNjX2J1ZltVTklUX0RFU0NfUEFSQU1fVU5JVF9JTkRFWF0gPT0gVUZTX1JQTUJfVU5JVA0KPiA+
ID4gJiYNCj4gPiBQbGVhc2UgcmVtaW5kIG1lIHdoeSBkbyB3ZSBuZWVkIGJvdGggVUZTX1JQTUJf
VU5JVCBhbmQNCj4gPiBVRlNfVVBJVV9SUE1CX1dMVU4gPw0KPiANCj4gSSBzZWUuIHRoZXkgYXJl
IHRoZSBzYW1lIHZhbHVlLCB3ZSBzaG91bGQgcmVtb3ZlIG9uZSwgd2lsbCBjaGFuZ2UgaXQgaW4g
bmV4dA0KPiB2ZXJzaW9uLg0KPiA+DQo+ID4gPiArICAgICAgICAgICBkZXNjX2J1ZltVTklUX0RF
U0NfUEFSQU1fUlBNQl9SRUdJT05fRU5dICYgMSA8PCA0KQ0KPiA+ICgxIDw8IDQpIG9yIEJJVCg0
KSA/DQpOb3Qgc2F5aW5nIHRoYXQgdGVzdGluZyBiaXQgNCBvZiBiUlBNQlJlZ2lvbkVuYWJsZSBp
cyB3cm9uZywNCkhhdmUgeW91IGNvbnNpZGVyZWQgdXNpbmcgYml0IDEwIG9mIGRFeHRlbmRlZFVG
U0ZlYXR1cmVzU3VwcG9ydCBhbmQgZGVjaWRlZCBvdGhlcndpc2U/DQoNClRoYW5rcywNCkF2cmkN
Cg==
