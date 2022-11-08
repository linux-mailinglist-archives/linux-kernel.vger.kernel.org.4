Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27F4621CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKHTJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKHTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:09:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777D6CA18;
        Tue,  8 Nov 2022 11:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667934563; x=1699470563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VMJcIQWZOT1PGcSJCIBJFjYZor/Rlfsjc4FwFg9K6ZY=;
  b=mOVXJA3QiKOAFIcT5WSDwnYpOunLDbe5Vc+9HFd2LwNlLl20PRGpRvXp
   iz16FPj1DCBGUBKnQ/INC1cfrNZmD9kYXzwt+qdfWOUuP1q4akzOpWNU2
   +7tpPmaoRWGyNorkt9RYyYCebwOYPaCAPF8Jz/N7HCV9U7VTX7//PgdVU
   tDmzK8lXY+8EJJvR8kHnKxjCT1B2WAQiYK9MfVqFSL8tgOcwIzLWvHTmE
   CcQT1F7TD4kHUQZp0rubiYylmVqNw/oSxJDc8Ry8lthZjzm1dh6BaRWMV
   BBzUM1vj+aAmIzReB0kQNMOirB4KGR6Sx7qnZ2aO7BciqLNoek+mE0YP4
   g==;
X-IronPort-AV: E=Sophos;i="5.96,148,1665417600"; 
   d="scan'208";a="215789761"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 03:09:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxlOeEvauROfGYZ4Vv18yVyFkEUnNbxzd4JNA5gLf7PRB+nDbNselYZ07WEXIiIKg789KRLW+flMQnn2ePg767ncG/9wvhbW7hKaO9VGijKe5ugHLS8yerm4E9eN2iZrkSFds4oiKDW/ieXm9RdngGK5uoiy8CT6127qks8cW2+evXJDsn4rJuLZT7b1+SewiPCgTQL8bwsfcrPXzQSvOKdUmqJJySV2HRoYF7eD+KVNGOEi9Q70j/IvfTPGZQw5iDOs7PwMWwMt9wOm4yNYQMa+6ZQ2M+UHsv6Rp1xNegrM5cCSOsr1gSTHpMlpTgBWGf97BpvjjQQwe0uE82M5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMJcIQWZOT1PGcSJCIBJFjYZor/Rlfsjc4FwFg9K6ZY=;
 b=RK+Bn6zd5UR3QHMKt5GoduGyAs8brlnJM8tXzUxmPyEA0G24ju2gk5zTTIfBwZJSZisyCu7zp683BoDqCUcuNIfhrXr3XDPGLUVRbbYOfNw8adxH8pCA7f5tpF2wCj0C+S0ElSLRl0pdYbX+SbYKUjj67nBrrdUZWQSkQ3QXAqqloYrgyAdtGSEbSGTU6f6HhOqEx2btHjaxOuZ83o9v4WMq/iGcEpYlIeCZXBC4wDtDZBvUCaoqEtYX2e6PyZECnR5snRtXvnE0l14S5seOMdcVlIHIokTw0B5Uf9NrAwKO5k6YGKXLnLmeynyJMZ1TFaaxE+dbDqoYkEGudTahCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMJcIQWZOT1PGcSJCIBJFjYZor/Rlfsjc4FwFg9K6ZY=;
 b=gM/e5uWwarA4GrRJ1Ifls3Rqwje0lip9Px5qpmkQTHknkDr1pJtgxtEgE7vKWBxYQigBzsFFRI+lV3Akdvi8ESX1NuryDZwHTprO4jVdOs59SeB3WbpTyAiVUA95wzi0+yZgAjYUABGU6QvIK0mojDChYNfA89AFM9WQVxYm9dM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB4056.namprd04.prod.outlook.com (2603:10b6:a02:b4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Tue, 8 Nov 2022 19:09:18 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 19:09:18 +0000
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
Subject: RE: [RFC PATCH v1 2/2] ufs: core: Add advanced RPMB support in
 ufs_bsg
Thread-Topic: [RFC PATCH v1 2/2] ufs: core: Add advanced RPMB support in
 ufs_bsg
Thread-Index: AQHY8qptmsmbt7vqGEOmo5IvpfPIBq41YHnA
Date:   Tue, 8 Nov 2022 19:09:17 +0000
Message-ID: <DM6PR04MB657518129522996B2B5C9640FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
 <20221107131038.201724-3-beanhuo@iokpp.de>
In-Reply-To: <20221107131038.201724-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB4056:EE_
x-ms-office365-filtering-correlation-id: f78310eb-2e9f-4a73-93d2-08dac1bcbc17
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+Drq7K25iIirkfMtmTcVGtkgJRVHva1gT9oIxSLwH9fOpZ2cHpDEZMFfBxqg9OERLqCJfrXAW9QVUiXNxRfQhJWXit7mbbpqm6Xb9+/ZiR3Wivpq8b/uiPhIYKG+sVIcS+USG12r+hgRasMfo9/jYgnW0jZP5+yck+2kM7GbzCZ9imI6w/oocY9CFkb7B+A6ooFVweHHKUty7TJHUyqjSyvuse5/ShzT0oqsyC8CNLtGN9SbjlfAkSmeObZKAnizWQH3C1Aj5ULUbDKC/VtRj882TJnXRloF7TqXGm1eHBbyKhZsa4rA0+mEMtyukmjzOoVXFrOr7BanmS1fstROzIL/Rk2gnF2ouUEKzr6TxHhWqFHhL/RaEqs4uja9l9HfTOeRsGeJcx14CrrNoafNAwrmea8go6AJ4ZE1JBFbflrkVNGBiUb7gyLF6XXKVOV8H3FVGEcAb4g1dkZZu1NIc9xyGiNrdNpxITml/u4UERzXoyV3GzNSBpvkCRMAqq0jNDHXjPY+ENeK7mXXBMmXLVNj1/RDQhyIPH5hKlIJjN3X5CthBFm6RpOw5XJpd/F78FniFj/jAShUFCtb46m5L9OOPym1Tcft46RC1PniZhnGlUEiGDVaiJYJ4emRcxledHEy6VV/5apjLnPTl8nyCBOJ2zSwY9TnJmBCgZWP+4q/FItlSvbBH5C/30mvfV3Ihf5x53XPa9HAhLFhp6iw5KjP/76ot94HeYoXX1JgH24Gafj3xayiaurlltY0PxnDoB+zHr1sHklpFMNVfamqH/M6jGHssJcBGomep9aIWo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(4326008)(41300700001)(8676002)(8936002)(7416002)(5660300002)(52536014)(316002)(9686003)(110136005)(26005)(6506007)(82960400001)(54906003)(186003)(2906002)(7696005)(38100700002)(71200400001)(478600001)(55016003)(66476007)(64756008)(122000001)(66946007)(66446008)(66556008)(76116006)(33656002)(86362001)(38070700005)(921005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0NqMnZORDluSW1uWm1RRjcxU3EzSzFObGFIVGdKeHdXaUVYUEJRV1ZocU9T?=
 =?utf-8?B?WnQ4ajdpTHJjRElFejg5M2RDTmMwUkt2TTVXS3RvSjFoZFBCVmhMc2RqNGw5?=
 =?utf-8?B?RmFNSllTbzFGN041TmhXVldraENObXlEVG50ZVZOb3MwcVBXU1I0MDFPV2l6?=
 =?utf-8?B?NDVIc0V6MTVqZGM5bWozK2R5blRJS1kwOUU1OGJPZW1BS2l0TGFVQ24raCtJ?=
 =?utf-8?B?TzJKT2dFYkJHZFNOVHBWSTkyakNnQzBkUXlxL1h1aGdzQUQrejNNTXBrYzRI?=
 =?utf-8?B?UzBKUjdiSTk2UlkzT3RjWlREWlhlRVhRSlIyMGppYmNMWG4zbElZbG1BMmJC?=
 =?utf-8?B?S0pBb2VVVHlqNVlTSTlhVGx1Y1hEeThLVzlUN1RhYnRMeFNzNGNwcEdqQTB5?=
 =?utf-8?B?TUlMYWdMVnVoNzF3Vm5QaEFvRlFIYnRPSVBlQU9nTDlJMG9vZVVaeERKUWpm?=
 =?utf-8?B?WGhXWGcrZlJVR1JDNVZyenluQVFwN3lIOU44SEVabnVqY25ibC9qRW84SWkx?=
 =?utf-8?B?bUM1L0lRL2ZqVmNROWo1NjRzTlRXUjZHMWZVVG1PNTVPU0EvcDBNU3c2emhq?=
 =?utf-8?B?NHluU0QxejljRFBaNmRJaFJxMXZ5Z3ZxQ1BTUG1sUysvN0hnUFg1R1FiZHA5?=
 =?utf-8?B?Qnpqd0Rya1BLRVVaSENwQkhhckp0NjBKVXZmZWE0ekhiV2lZdTRKRXM0OE5o?=
 =?utf-8?B?VWc5aTdFbStDM3RMeXJlTWR0S3I2Tk5TeFNRQzNKVTJCT3Z0MVBYSVNBZWJQ?=
 =?utf-8?B?ZmdPRmlMSG5nNmQ5N3Y4SG5RdFN2NjVzbmhlNUx6QW1wNzRJd2hYNk9YTEdY?=
 =?utf-8?B?ZkxIc3k4UUx0M2hrSUNWZzU5bE1rRXE5dVVuN2tOK2FIYmFuMXRIcmlxQTRH?=
 =?utf-8?B?RHo1TXYzalBTcXlwRTcrUzBiemluM1dPTzFpdkpQZDdFdWN4Y2dyZDVJak5t?=
 =?utf-8?B?WFdrMFhISVV2M25rRUptTDFOU01MWnN6czgzU1F4YTBjT1YrWVhyR2wvNXZ6?=
 =?utf-8?B?YnM2YWpxNkx6TVhYTnhqcVlWL2tyN2RWTVowWDRMOTBudFpzOU92L2lEbVV6?=
 =?utf-8?B?N0ZWZ0JzTXlURjhmYWp5MDBYVEFQWGtPd0pOTldXckZmem5Tb2JhTStvOXdD?=
 =?utf-8?B?QUIzYzY2WVNiN2FPUGlYT1lickJaOFY2SUZpSTRPdFNiNUlMa2tMaXRhQWhB?=
 =?utf-8?B?MlFPU3ZlZ3gvbFB1Y1ZiMXpwM212YllJcEI4Z293VzdGVjVHWlRFRGRHMncx?=
 =?utf-8?B?SmFzdW54dld2M0FycVpIMm10ejN0bGhOMi9lM1JJN25oK2VYTTdiN1pEbitE?=
 =?utf-8?B?T0VUT1VReFcvdXRQbzhNaU1sKzVObE96MDZSaEFRRGc5WFl0TFFrYW5ibnp6?=
 =?utf-8?B?TGRYWi9yVkg2WE5wMzlCUEhCQVZEUjVjWnBCV3dwNXpnMHp1dzIrTDlvYVlh?=
 =?utf-8?B?V3UvdVloWmN5SGFZcjlHa3BwdlRpNVN6Zmx4N2Znc2FhUmxQTWIyTXBmaE5n?=
 =?utf-8?B?R2xETStjN3lSMW50SjJzTVNhbnBiVzhjUnNKQzl3RlkwdnR6RzNES1k4ZFR1?=
 =?utf-8?B?S0JJdUxwNlE0NFFZcEN6alp0WEt0UlFTZzQ0SlJvNWN1a1czZTROUmtDYU9q?=
 =?utf-8?B?SnR6aWxraW4zMG9scFFZTGM1UWdSWTdsTklkR0lINmxuYlZDYTdSSzFoejFS?=
 =?utf-8?B?VXJGb1pLa21uQUpiYjFzTHFzVVNER2dQZ0VaaFhINW8wMy8yZ1g3bmxVcC9S?=
 =?utf-8?B?MFhsYnJMcVpoTTlyZ3VzKzFYeVhlK1hKRTFZY0R5ZGs1a2dFb09wMUcvRmhO?=
 =?utf-8?B?RW9tQ1UxbWExR0VTc3BVQmpuUmdsc20yT2ZpZDRDVmRFbVZ5d25lQWxHSEg0?=
 =?utf-8?B?Y1dVcDJuYUJrekFOOUhNQ1JoL1lQN29tYmU0bS8zNWpWYzRoeDJPR2duYkI0?=
 =?utf-8?B?Si93VWNvNEZPQjU1ZHdJRDhCRk9iNGtneE9qdnJJM2I1MzFNSkxTZ3ErOHVq?=
 =?utf-8?B?aXh4ZFQ5V2lmMUw0UlZjeHpsaXV0bzNDS0xtRUJlTDZlVUliQzVtaWZtVjdM?=
 =?utf-8?B?ZjR0dXh2a01VSXJhN1ZtelpPSUwwRkdoN0tiRC94UHpieFNiS3dDQnA1QnZB?=
 =?utf-8?Q?cyWZhWcy+/cGOH64e0S2BlIfQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78310eb-2e9f-4a73-93d2-08dac1bcbc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 19:09:17.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biUI3QOe3pz8F9vA8c+N/HwrEcyBkCkM7XHh/kHWCobY1zuRWN0TgaA1eYLYc8bfj66LrIxUqhQoaUIaEhbyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gQWRkIGFkdmFuY2VkIFJQTUIgc3VwcG9ydCBpbiB1ZnNfYnNnLiBGb3IgdGhlc2UgcmVh
c29ucywgd2UgdHJ5IHRvDQo+IGltcGxlbWVudCBBZHZhbmNlZCBSUE1CIGluIHVmc19ic2c6DQo+
IA0KPiAxLiBBY2NvcmRpbmcgdG8gdGhlIFVGUyBzcGVjaWZpY2F0aW9uLCBvbmx5IG9uZSBSUE1C
IG9wZXJhdGlvbiBjYW4gYmUNCj4gcGVyZm9ybWVkIGF0IGFueSB0aW1lLiBXZSBjYW4gZW5zdXJl
IHRoaXMgYnkgdXNpbmcgcmVzZXJ2ZWQgc2xvdCBhbmQgaXRzDQo+IGRldl9jbWQgc3luYyBvcGVy
YXRpb24gcHJvdGVjdGlvbiBtZWNoYW5pc20uDQpSZWdhcmRsZXNzIG9mIGl0cyB0ZWNobmljYWwg
Y29udmVuaWVuY2UsIHRoaXMgYXBwcm9hY2ggdW5mb3J0dW5hdGVseSBicmVha3MgdGhlIHNwZWMu
DQpUaGUgc3BlYyBzYXkgKHBsZWFzZSBub3RlIHRoZSBsaW5lIG51bWJlcnMpOg0KIi4uLi4uDQo1
MTk3IDEyLjQuNS4xIEFkdmFuY2VkIFJQTUIgTWVzc2FnZQ0KNTE5OCBBbiBBZHZhbmNlZCBSUE1C
IE1lc3NhZ2UgaXMgY29tcG9zZWQgb2YgYW4gQWR2YW5jZWQgUlBNQiBNZXRhIEluZm9ybWF0aW9u
IGFuZCBhIE1BQy9LRVkgaW4NCjUxOTkgdGhlIEVIUyBmaWVsZCBpbiAqQ09NTUFORCBVUElVKiBh
bmQgKlJFU1BPTlNFIFVQSVUqLiBBZHZhbmNlZCBSUE1CIERhdGEgaXMgZGVsaXZlcmVkIHRocm91
Z2gNCi4uLi4uIg0KTW9yZW92ZXIsIGluIHRoZSBleGFtcGxlcyB0aGF0IGFyZSBwcm92aWRlZCwg
aXQgaXMgc3RpbGwgZXhwZWN0ZWQgdG8gYmUgY2FycmllZCB2aWEgU0VDVVJJVFkgUFJPVE9DT0wg
SU4gYW5kIFNFQ1VSSVRZIFBST1RPQ09MIE9VVCwNClNlZSBlLmcuIEZpZ3VyZSAxMi4xNSDigJQg
QXV0aGVudGljYXRlZCBEYXRhIFdyaXRlIEZsb3cgKGluIEFkdmFuY2VkIFJQTUIgTW9kZSkuDQoN
ClRoZXJlZm9yZSwgd3JhcHBpbmcgdGhlIHJwbWIgcGFja2V0cyBpbiBhIHF1ZXJ5LXJlcXVlc3Qg
dXBpdSBhbmQgcXVlcnktcmVzcG9uc2UgdXBpdSBpcyBub3QgYWxsb3dlZC4NCg0KU3RpbGwsIEkg
YWdyZWUgdGhhdCB0aGUgYXBwcm9hY2ggeW91IHN1Z2dlc3RlZCwgbmFtZWx5IHRvIHJlbHkgb24g
dGhlIHVmcy1ic2cgZHJpdmVyLCBpcyB0aGUgY2xlYW5lc3Qgd2F5IHRvIGhhbmRsZSB0aGUgYWR2
YW5jZSBycG1iIGFjY2Vzcy4NCkhvd2V2ZXIsIElNSE8sIHlvdSBuZWVkIHRvIGRvIGl0IGlzIGJ5
IGFkZGluZyBjb21tYW5kIFVQSVUgdG8gdGhlIHVmcy1ic2cgZHJpdmVyLg0KDQpUaGFua3MsDQpB
dnJpDQoNCg==
