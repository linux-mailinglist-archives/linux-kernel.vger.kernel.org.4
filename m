Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359D7481A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjGEKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGEKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:02:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA11B2;
        Wed,  5 Jul 2023 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688551340; x=1720087340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ABre9itWkr7HR5boON2ywHdJ+eEVfHulSifCMmrnWFk=;
  b=B3Gj8glmOM47FvmQ+YYQDRvs979D9/mZAnAmKoXklB+9TvkcNA3G1F/g
   IcSF4o9A6q0+CxS06BPcLJG9INocLA/oZXRT6x9eddgicOJ/nUxtOkVp7
   Dm+rMFyR26eJx+nfgaTPjIcLcKgg1QaWjP62frEiJj1lEc82s5DaNwwgQ
   CxkkVsg1a6XmEAmBoeGw4hwRTKgFwelpZtk2uE6Ph5IrdEQmwbKLgAOIC
   5aklEOWaGdb8fUxEDrI7Qwlwv89jQ4nQPFhF/kVu7hz9vr/9QlTWsx70Q
   GVfnxQGIYo0Kbv69OheHdnFD7bLwQOX/mUjcpHq28MRcbvO5+G8Wvpi8K
   A==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="235626732"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2023 18:02:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ksze8p+BCPZjhuKiNvqkkuJfpyLlHfB6JxnpYVl0fJ3CUK0/hrFUfIp6uBQT3ZKtEr2HbFdQYXSXCkR0hCVDgO2Ig6BzauLAGjrWPaIzzC0VKokqPPfku5cf87nwXkphvbaIU6lo24tuqylKyJffCN6lgMZHtcyX4uhwvhz39yFCcNTY8a1bB1NgCNV5W1p1ugrgjPJmrJuKJRrdf/b3+txrUquLvNjOc2Eup0c1DwyQaA68AEcMC5AoZTh6JvDjpPb0Jbi3uarAMBa91JyBTujuJt64on33oO81FXWQLZmsEzJb3+G6ocuyoPUBWKBgM0+tBrtTU9wtG1PsrvhEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABre9itWkr7HR5boON2ywHdJ+eEVfHulSifCMmrnWFk=;
 b=IjlbrtSAmHGIBbh8guIRWtcXtnQDP4LiFocL0QUnFdnvT9lUY/arRDnuTP7gxpZonatAYQS1ShG12GrcbfQ67OrblcfryYJ4BkvjLd9acP9chzV6N7qbtg/krCaixUtZxgWtIOZBmQ0f/76P0PI1QwuGUw3zHZHAu380yMFjDcihN5wA9Pnxwnd6ji124dzKbbUPLLOOBcO0JBo0JBL3+6QXZNOWruWmLaJvBzahZlwp+lGkxGklCcQLzU/FZChEdZCUVqZdr1NUJEWhV1WFms72XPrvcEdaV6YbMGw9DDXcNz4HfJfOTWLpucdGpNodoX7UM463MU9btFWMJKGg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABre9itWkr7HR5boON2ywHdJ+eEVfHulSifCMmrnWFk=;
 b=d7PrVrkq/DiH38mus4doxpx+fTue6D1Z9ORoB2clj3eFJcVGyUG2eb0IwHhxj9hww9RV1KsbnZ/LJXXup5oPMYzwIOn5+KlRKee2IokUlVRqBspsZKnbLDYSVSqulL/FBIK1JDW69GUBfzzlLiOxGc7uQbJFIDII84cxKrFzyiE=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by CO6PR04MB7620.namprd04.prod.outlook.com (2603:10b6:303:ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:02:15 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::23d8:739:4578:cbc7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::23d8:739:4578:cbc7%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:02:15 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Thread-Topic: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Thread-Index: AQHZqBmraa5SJIbjX0SShq6Lycf7Lq+g1b0AgAD7knCACS3VEA==
Date:   Wed, 5 Jul 2023 10:02:14 +0000
Message-ID: <BY5PR04MB632757ADF169C46BF22435BBED2FA@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
 <896abe03-4fcd-003f-1273-209daafc5635@acm.org>
 <BY5PR04MB6327520D05FDC13A6BA3894CED25A@BY5PR04MB6327.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6327520D05FDC13A6BA3894CED25A@BY5PR04MB6327.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|CO6PR04MB7620:EE_
x-ms-office365-filtering-correlation-id: 636c3c9d-31a6-4366-804f-08db7d3ee8b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zt48YarROnx3CGJ/3pK2rA/VyNyPyQOCgzH+SEoh3OIDo+6oMFyJ1gyHPOP8bl7k/SKx4ZO4zUfkQiWIFnbUAZseBpSCLjXP56obl6cE2w6uxXDfFkdm+j8+U04iKjgsN0SCpJ/CatSWFux2R3I9/Zi2mMPGW/HdgHViBeAj55HYFn8zNX1z4EC4UYRSxV+KOEo9wAsY+624nJKtoiukVMvmsgwIXtUq0zqwtOLu1OcRpKcQoFbP90ZivKyc0lm6s4fMZSV+HGK2vGf3sDFh+UMKNRj2hpiaSoHoUcbFxr3X7/nVzQBdlSHoPSte5iwD69Iue9+cyKcFh3qk8quYXCFF0slxsQIH7DhigSB/QkS7QZQ2IT5Yd5dkhBIb9fLE60ivHun6Dt7D9UTKS1k0dqzdp0CxdtwxCviVHVPotcHzTzmAmF7v81KJlavQML7tWsiPRERkHoGocw4pJGQECVdmWgvmFFOmZelcfsqxtYd5xYSfGIJsRBZGvuf+SZ6Ht6r83O4om607S7YagMZtpYyQeWYaL9uEcUsU9FVJuK7ThkxPI78KxQfH7eWXTYaoA9p/cGzx0VY8scyQc/1tOHO6qQXPlxbbMU2hgPL147dBkEpOXMJwX9XoXLm4dC2G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(76116006)(38100700002)(66476007)(66446008)(66556008)(4326008)(64756008)(66946007)(82960400001)(122000001)(55016003)(186003)(86362001)(33656002)(71200400001)(38070700005)(7696005)(6506007)(9686003)(26005)(53546011)(110136005)(54906003)(478600001)(8936002)(8676002)(4744005)(5660300002)(52536014)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTNlRkFEbGd6WDlRQmNTKzJSekVGcXRPQWMzYXJiS1N0RkxwYmZWcFNRV2ha?=
 =?utf-8?B?V3pVcEg1U3FJK1hiU29GNEhtcXZQQ2xtWEkzVVhGUVFQay9Ea1IrcHY3RUNC?=
 =?utf-8?B?UU5wYVdZYURqNmcwcDZHa1J1TDJtblRkOWtvOW4vcmxxdWpoSUV1azdoWGRR?=
 =?utf-8?B?YVRRTFI2WHdHb1Q1RVNsNHErb2t0YU9qb0tRTGpCeXh0K3FsSzh1aW5KbHpY?=
 =?utf-8?B?RHoyZ1MyUXZOZmh0ZFFQcG1ESzV6SHVTR0t5UTdiUGdXa3lqdWxuRFYvVXZW?=
 =?utf-8?B?Y3c5aDBlcmtvNVB2Q2NJdnBnMzh6OTQ4ZmVQdC9jUG1TK2FCek9GaWZmZytF?=
 =?utf-8?B?SU43QWVzbUF5QThZOTVPaTVFbDYzR29vQUZJWjlxZE13SkR3elpYTjU5Mldp?=
 =?utf-8?B?VWVZc21MY3lJeWJtYlR0S2JEZWxVc2tqQTlxY1FGdGxHQ2tHVjlPMXJaVS9t?=
 =?utf-8?B?S0dvbkRDZWxibkprS3NJUVgrVHpJNXMvTW5oc2VGY28rVktCTWNmYjRUNzdI?=
 =?utf-8?B?ekhLSmNFd09pc3M2V0ZFYjNReUFHVXVsekVWREkyNDJJbk9KQzhiT3RtYXMy?=
 =?utf-8?B?czN3K1REQ0xJT1Z5TUg0ZFZnQit5Q2JpWXFVK0RrZG91UU5IS3ZTeFpRS2hP?=
 =?utf-8?B?RWd5bkZyYSttcU0va1M0YjE2dUhkZnNyb3hDU1ZxOVpFM2dHMnprSmJmTUJF?=
 =?utf-8?B?dmNVc1RVb0ZTNVExVlQ3ZkVheWErSWpKQW9KN0FwL00wS3N1NVl0QnlRU3pq?=
 =?utf-8?B?bmhNeHZHL3l0OEpQQlpRYU52aktWM0hNS012Tnl0TjU4bldYVEMvYVZRZTVF?=
 =?utf-8?B?OTdZaWtpckd3RUNOQkRlZ3dYYmZrQmwvVjFWZmsxM3VYTGNWamhGMWlLZU5p?=
 =?utf-8?B?bmJrelZTYXJJdUY5TEhLV25hNm1FTWhMaVc4NGFTUWdNdXNUMGZBQWpqS3E4?=
 =?utf-8?B?RXlDVXRPckt2cUMxeDJOQkliTFJsTDE0ajlHT0gzaEJHUW9XUTBzSlIwSWJG?=
 =?utf-8?B?cHE2VXkrc29OWUNxQ3hWdEVtMmNtSHdNSkVqQWlMaUcyRUcxM1Z0Rm0waDlm?=
 =?utf-8?B?UGJNUitYOUdaSklYTXlJRDBFb1FEMmhzeHpkNjRPaFQwN2tJSDJpcSthVU8z?=
 =?utf-8?B?dy9tdmNsSDlvR3dRcHo2d0pBZmRPT0dLUEQyMEUvODlmWE53ektPOWxkYTl3?=
 =?utf-8?B?V29YQlRnNmpvcFJ1MEJDdFhzaXJQSXB2MzBMVk02a0phZjBySittb1ZYMk96?=
 =?utf-8?B?MFp4azlaYUU4SmU5THc5MGZiNG1LRGFwYnpJQWt0NTFyNEx6L01lbGtNZG1W?=
 =?utf-8?B?S1FBdWUvMlRKYjFRemgxM3RoL2hpUzBkeXJlYlNqOEttMVdZQWM3NEZISVVp?=
 =?utf-8?B?UUluK0dkb3JaaHRDbnNxdHVPYThGUWsxL1ZuTHVycXQ2VXRMc0Q4eXMyUjJa?=
 =?utf-8?B?d2RyNlFnNTlTTmlCaXZUeHhURjZlaVQxZmQ5enY3cUx2TXdMWGVhcEdtNTlp?=
 =?utf-8?B?WWd2ekc0MHZJMTNnWFZUdHZJVEtiSVBsVVVJajV4TW42QjZ3aWJtTU5YTkQx?=
 =?utf-8?B?RmtHaC8xamg3Y3JkVWpma05LMkZPMFN1MTduZE16ZU5RQkFPZW95dklDb1Jt?=
 =?utf-8?B?eStjVk16N28zRHdIdXhSTFIzbnM4dzZQV1dNTk8xQjB0SlBPTVpXcDBhSE5o?=
 =?utf-8?B?WDFPd09LNWE4UnlHSnhQT3VMWlJrZDlQTDFHbTNBMkZvWDlKYzJ4TnR1bmZB?=
 =?utf-8?B?M1RNOWdNSnFBZ0MvdWpXbkxYUzNxQlJybjJpWjFkaTZEUThVMktUVks1QjFU?=
 =?utf-8?B?M2E4ZWQ3VWdPMExGbzA0RzM4MkVmYnlsQkdjWmpRMjViYzVieUx3TU1DWWhZ?=
 =?utf-8?B?by9oVzF2b1pzMUQ5NmU0ays5dGlReWZaT05Nc011NjFpRzFkdStydHlzbjBW?=
 =?utf-8?B?WXgzVlN6OFl6S3dnYXM1eTJpbzhBZUhTNFo4eUd1cjhsRFlLMzFST282Z0ht?=
 =?utf-8?B?U29NOWFvR1hKQ2FlY2hFMGYrMmNTOER5YkFKby9QNFFPU1UwcGFIUDl5ajBH?=
 =?utf-8?B?cVpNOUtJWm5vQWhod2p5S29GTkZzK0lCaTdsVC9mV3c1TXRCUUJ4YjJLY0M0?=
 =?utf-8?Q?C78Pp0adwFIaJE1ULg60rjdwu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZNJIbhI2VoOFHPquxG3KIIUzSZJQzlT4DhEh62JkXRsvJuJaRN5wFwGIWUtovIT7pCQlm5HhLLBUe3Fj4hVVX29IqmhfOnFYpmnzlisrXeUMmZCZPKf6a9C4163CxIqvlKqRuzS2916ZwBdtsvbEzeEGfl/SiD+dC914Or8F3rDmnHATH9g1D47fOUw13Hro2aKcsqSGc6mIfTmATgS0r4j5Sq8GSyqiyG1ZbGb+3whEboixvS2Qm1fKHg/jMmOVaXEwegcIRklJCPI7FAzhfbjQ3x7brE0GuikEiORPZYC/+7macmctV4vGUI0hLrRJGKjWmjYZUpa3XAirhYc7vUpLlqiPOUtnicyCUYtg6Ly+2/OoVur1e9DE4mUKziAdcYDi2ZN83rVvH0ZWJzAD6jtbcBkTvr4I61sy3+CgtvRUPm1XUc3Z86oHx46LPzxtWqu/FIUfiNZcMa87QIPkArroQD/Z+/sU0cETY0jxtICGKRN94k2lNXIFwXg2UUy4U31UIrLL6pnau88JKfEu6ekaw83TBudYMJPLf1tQzdxwL88k+xejnD9gTTShsGpA1ND9gLGGgzznV4jMb6C8CwN7drcfXA5R1tYahybBA9VHcY3UbV45ZUoecYlhC0lyvAyZYuRXGm7hJr7yemM9UxH9HUdpJOX+/JxshhD3R207O1GZKDap3ecStOl1jOeGWD7zXMFHOW+RgWBmWy5bUEIiPdX/M58X78IpzO0kPLlAXkFapFCaoRqb/FKamosMHVmfhUOGqc+bk+ri7nNjruER6LbmZGPo6EX8Rt4jt8GcE9qrEo2tJ1flhrNlHPBBvD9FO0gsmLVBLUpqrkdRMsKcqsozJTdT6nnR0qY6bLs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636c3c9d-31a6-4366-804f-08db7d3ee8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 10:02:14.8337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIX8IVE2kCZpZiLfJf0mZ+vtzavdbewHtL94BJaSIyNMvf4SClrhrHh2wV5NPFXrJpYSCV6PoKIVIbQrUHnZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7620
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydA0KDQpJcyB0aGUgcGF0Y2gsIE9LPw0KT3IgZG8geW91IGhhdmUgYWRkaXRpb25hbCBj
b21tZW50cz8NCg0KUmVnYXJkcw0KQXJ0aHVyDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQXJ0aHVyIFNpbWNoYWV2IDxBcnRodXIuU2ltY2hhZXZAd2RjLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIEp1bmUgMjksIDIwMjMgNDo1OSBQTQ0KPiBUbzogQmFydCBWYW4gQXNz
Y2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+OyBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbQ0KPiBD
YzogQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+OyBBdmkgU2hjaGlzbG93c2tpDQo+
IDxBdmkuU2hjaGlzbG93c2tpQHdkYy5jb20+OyBiZWFuaHVvQG1pY3Jvbi5jb207IGxpbnV4LQ0K
PiBzY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSRTogW1JFU0VORCB2Ml0gdWZzOiBjb3JlOiBBZGQgc3VwcG9ydCBmb3IgcVRpbWVz
dGFtcCBhdHRyaWJ1dGUNCj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9t
IG91dHNpZGUgb2YgV2VzdGVybiBEaWdpdGFsLiBEbyBub3QgY2xpY2sNCj4gb24gbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93
IHRoYXQNCj4gdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiA+IElzIHRoaXMgc3RydWN0
dXJlIHVzZWZ1bCBmb3IgdXNlciBzcGFjZSBzb2Z0d2FyZT8gSWYgbm90LCBwbGVhc2UgbW92ZSBp
dA0KPiA+IGludG8gYW5vdGhlciBoZWFkZXIgZmlsZS4NCj4gSGkgQmFydA0KPiANCj4gVGhlIHN0
cnVjdCBpcyB1c2VmdWwgZm9yIHVzZXIgc3BhY2Ugc29mdHdhcmUuDQo+IEZvciBleGFtcGxlLCB0
aGUgc3BlY2lmaWMgdGltZXN0YW1wIGNhbiBiZSBzZW50IGJ5IHVmcy11dGlscyB1dGlsaXR5IHRv
IHRoZQ0KPiBkZXZpY2UuDQo+IA0KPiBSZWdhcmRzDQo+IEFydGh1cg0KDQo=
