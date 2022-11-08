Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC3621E67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKHVRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKHVRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:17:32 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B157B5C;
        Tue,  8 Nov 2022 13:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667942251; x=1699478251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Js1/y/XrtYNaReUCwz0f9VdTwA9HEVGLgs7nP3xo6s4=;
  b=GX9Q2yidGnT2lFqGs8BtFhcDc8I8ce1CFgpG1Qxy1MkZAzDo9u2RHOhX
   o2GxZVU5nxJo561AIATZJk0/MlnouZUBA92gE6kSP3mdqNF7ixyHufl7A
   7k6VgMeUhmjiLeiZn8udIvOh9Th+llK+0xLFFdgMox9twWdnOoqU/y9ex
   5ufsEx2VI+PH7YHUMsaw/vkhOoUctOb4svYWY40N9jA3XSL+s5v3bPtNG
   J9y8PKWcwYoB9ZhhOXEJ0AE+094YRlKPOOZoUUUdRKXvpyqBq9gZObndg
   S9Q21/x/OSNe6ihm8E7VwNUieTbZcGtfDZtFAhP0sC6XiYMb9pC0+wl8F
   A==;
X-IronPort-AV: E=Sophos;i="5.96,148,1665417600"; 
   d="scan'208";a="327897345"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 05:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vokjrjd+ajpecJpNSNMnLqEGq8VNUF4qAKApLlaK1d0mVHmQtcLE+67h9kw4cRt7ZDbU4wpXNnkxj/NYfvYiiJ5ohMaIX6cOnGFN4TQON+U7rFzKs84ZOlnXr82CLy0r7p6xwTtXnrhxQM0maVYEcn9k5ZDXgE0UJ3TUJKuuM/Vtag9j5nWf0DFZJ8m8VVLJAqj0AnrslEG6V5zCHIWxymT5fn6gWI+lb4n70ozYoSFktu/SsLd0VmaSEsxvkLlvFe30B9CPjyB7BR4J35nBRRMCTDi2ZvKKpJHMwssCD2f+ONHJtNt1TxvltE73mSAdZy7Ujil3YcrdgfFMuU8qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js1/y/XrtYNaReUCwz0f9VdTwA9HEVGLgs7nP3xo6s4=;
 b=D+3JmF53fp+wa5xtcOP+SINalkAQWwHzRBpuB0usmV/3MxQIYuI8l5qJ8PA2QJ/lyuvhLPMm4Nztp6DhvAqsnAuowuVzlY27AegWkz4z4cn4IZW8IoOsKvYbxkfbGpzKr/Ltr6YmXQcgDcSUIyiQIWolywFP7aHcGx7uGxmKj+uAix8gII65laT9N8//Bf0MeqO0ZogKny9HU9dcwrEPkl50Dur8EUiBirGITMgHnD5KI/WcKUv92b+Zil/g5OaSsJdoenszSdDkjPf6ZA44HoyROM4YSFk1puxOlOBGRNh+MxyLKvmUjYlTCZiso1ZsvoPuCJWxnYNWlevLb0Tu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js1/y/XrtYNaReUCwz0f9VdTwA9HEVGLgs7nP3xo6s4=;
 b=t6oK7kseHvDEGs2paLLjh4kui7IwU+xxwyRt1DAOLKzJDG0ubLggt7xklgXWivjZ7SYgqCVl2Nd6ddl/pPJLimu7zAtoulNPfb8GJIalnsR8un15Hvuxb0mIA1RpGV5cXg6PdXZBytD3USoINq/sH8uoG/N5nfRMUj1WUIdtJ90=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO2PR04MB2312.namprd04.prod.outlook.com (2603:10b6:102:6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 21:17:28 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 21:17:28 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>, Bean Huo <beanhuo@iokpp.de>,
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
Thread-Index: AQHY8qptmsmbt7vqGEOmo5IvpfPIBq41YHnAgAAKwYCAABaRYIAABvXg
Date:   Tue, 8 Nov 2022 21:17:28 +0000
Message-ID: <DM6PR04MB65754A37298BE58A8D678BE9FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <20221107131038.201724-3-beanhuo@iokpp.de>
         <DM6PR04MB657518129522996B2B5C9640FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <fa3905bff8ba47b0ed45f9221dd1d033ca553179.camel@iokpp.de>
 <DM6PR04MB657570B147A1D3B6FE5F8797FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657570B147A1D3B6FE5F8797FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO2PR04MB2312:EE_
x-ms-office365-filtering-correlation-id: 3664c029-b412-456f-cd91-08dac1cea421
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NYtZAK6GBhghwoe0ocYFpXIkkb5oUG5dZTFxozS5qdUCKXa0Uf25YB6ZzKBjpE1mJyqT+PfPsFkc6VEcWlTNQLViiofC6rrBFws+qmz0djAC2byeLMpAFw9bJVeuSsx9s5dLDKaPPGfIWfXgG9U0p2RpFFBUXcAvY7yrU04OedMSEMlA2h+4GmkgCwPGKq1+BfHVZX1hb9tnOjq55JyOByjxFiz7a0mtUyeHUaTbiBXHWbtthP7bvLWPV7p5PdywfGHhtS6p3p8ujjo0kiqBprct0f45QX1CUH6tcaktzCi7Ik7nPJMSeUtw9moWplahWBnMQF/ExIznyfI8b32dBH69OMy4dA/y2KG2lS2pQeNJBYIopfLv2s2iNfwjog+Z4jWNXnMjpusAbeeqy+2tRlCdqw3mYzY9JIPD/vKsC2O6ywz0kjpRmdrJbRJCF+Gux6sAdno0HdQuWIae9cyvtqDTDkI5ogHT9of4ysSJ0GIAFdlcEUFDYrAyooZ/RbRv4boQ/GSX215gB4fc0RRXVdlbbPNCmXx+2RkrIdS7T4uL+/KAcKLDUu5DxfFrJZc/jVRH/Sdzog4e3aiih0Ti04ykHCHKfAaugIL7YqQTiBehGMN24V7wjSm9ombFrKtlS+TZ+MWZiug21JwlzMjIYvWCPvmZL8mFvR2f6yesdzWquzjAnJ/AagkDhCIIrDvfdQWSc1wfb8mad3lV6isSqBcQ0EI4UTKuZk9l9VHkUR9DcXAsHa9QrzxbrHUFe2svXHzAW7E4cxFByMFcvnpJ3zKohHT8S1nip5PC9bFjmO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(83380400001)(86362001)(33656002)(82960400001)(122000001)(38100700002)(38070700005)(921005)(55016003)(478600001)(71200400001)(8936002)(7416002)(5660300002)(52536014)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(41300700001)(316002)(54906003)(110136005)(186003)(26005)(2940100002)(9686003)(2906002)(4744005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUxUakdTSE0zaUViVk5Qd1F4NEpPUm1vcXNudVBmZmpsMlZBZEJ2alh1RDRV?=
 =?utf-8?B?RlFpK0c1MkllZjZKM1RialpCN1M1enFTR0p2QUFJZStwRkRMU1hZME9DSjhK?=
 =?utf-8?B?NEtUMUFkNi9QOVJIM3BGWWxvQWF5NERibG15MWlQbDFrS0YyK0tVZURQMWNC?=
 =?utf-8?B?a2dmTE13MnhWQllvdVNZYXQvRUF5TGI2U25yQXZzZjdkV0ZyNHBlNkJaZ1N0?=
 =?utf-8?B?TzlhZHdyOWgvQWQ3bEQ3MUtqN0FZNDYwSTgzQVM1bTRSb2NSM3ZiSlNjVXM4?=
 =?utf-8?B?VXA0d1UxSFhEOGhRNUNpNmlhKzdYZFFZZ1hvNTMxcVREeENNQ2V5ZXdzTWhY?=
 =?utf-8?B?YVJiVHJ0d3phZkxmUWRoNXppaUc3STNja0lqT2tZNHVIa3d6LzdZVEhxdFky?=
 =?utf-8?B?MXhxWWxQdTNwbFZ0N1BjV085SUJDc3l6U2lZbVRPYjJWL1NLOUl2blZSZktu?=
 =?utf-8?B?MisxY2JMalROdDJvNUFkVTBqRDBGSFNJV08wSlZsYXJZQXprVk41TmpDdXRk?=
 =?utf-8?B?YjRYK3JacmkzbWFaNzBYL2dxckE2MVljWTVRMWF5OEtUWU5VQ3lhYUNrYjN0?=
 =?utf-8?B?Z1ZTSk1XdkJvRXNiRXpvQkk3L0ZGZExmV2RxZldVUGR1b2RUdlJCS1FTcmE3?=
 =?utf-8?B?U09wOEM0aC9uaUNRUVZ2dExDWnJHYlFoSDBWY2h1Sk53ZEVUUFNDNHZWdWhp?=
 =?utf-8?B?R0NsZE82K2ZQdFBWQTJqNGxEdWVVNHA4ZU51eENSTnA1NTMydkZwdWYzMWFi?=
 =?utf-8?B?Vm9VRlhMTlVOM0NtVitxbEFVeVlqVStFcURSTngzK1BtY3paR1JIcnAxeHEr?=
 =?utf-8?B?dlhVQ3BLUXExVys3MmJndU4vbUVJTkIvVzBEbi9zb1JocGRiK3JQcWxiSjlM?=
 =?utf-8?B?VDA5NDZ5Tkg4aUUra3FjNkI4N0JtcGk5RHNaTXBvbFlwZUFZUkVWSFhYbTIy?=
 =?utf-8?B?Q1l0SUJyb2RCZE5XeUFrVUtBazBuNG5WekE5cEpFNE9UbkRNZXpQQ3NZZjYr?=
 =?utf-8?B?Y1pZa2dHeUFiVjhnemhUSVlLZUVidjJNYld2TmRLUXJtdDBJMmJTcUJDRUdr?=
 =?utf-8?B?WEtwVzlwQkdNamFjbEFJOHJKdlN0S29jRi9XRW40OHN1ZGNvYm9BTkFXdTlY?=
 =?utf-8?B?eWE4QjNsdU42a29UdWpHaDRDYjlwV3EvaFJiTEdVWGc3eXdnTmUwb2xMN2cr?=
 =?utf-8?B?ejl5ZXB5WmNpOTVwQW9Xdnp6bExDWDFlMlE0TlZucFdOV0Q1Ky9veVF0WWU3?=
 =?utf-8?B?RFZ3eFpWcFhuT2NMdkI5Ykd6RHM3bGJJQ1V3UjRVb25aMlQ1dk5XZ0VnTFl4?=
 =?utf-8?B?RmVSU3hNSEhPK1c4Q0RUWlB1cE5FU25YZm5UQ05iaHROTmNLR3NSRUV2amlQ?=
 =?utf-8?B?Y01KQUNLUTNMR2hrUW9tSWZpRVl6dStNWmFiaXdkM3IvTGIwR3d3ZkZUWWc3?=
 =?utf-8?B?dzRlMExhTG5oNDFxVi9CSHpHbUJqQWxTZmNwOGdHS0dZbE1hQm1PSUF4WHRR?=
 =?utf-8?B?cy9PL0gwMW44bU10SmtWRDRnUHIzRFY0K0hHMys4cmVvZnAvdnFJdkxsUFk0?=
 =?utf-8?B?TkUvdDY2ZXZmbEFPSmRpZC9iekFrR2h4ZWEyRXh0VEdQQzZsMTN1U096UWM4?=
 =?utf-8?B?REJPdi9MZG9PZUJvZlovQ2U1c0QySWUvZjRjUnRZUmJ3ajcvcnZnTWVnelJi?=
 =?utf-8?B?MFBRT2NnV3FZbmxNd05FUDFmT0pTRDhEaHpHWWZwYXh0LzNGZ0l0OGNVeE80?=
 =?utf-8?B?Q3YzV1MyRXNSbjNLK2ZSUGxQUk5lbDdDMmNiRE02TXBLNnhNcnpzNG0yWW80?=
 =?utf-8?B?OGkrOGF3OXhVOVdwSXRSanRHdmlFY0lyY3c5cUpSNXE5Z3BhQ2JtcW1BVDZG?=
 =?utf-8?B?dXZjOXlHbFVpTmlubWt6TkczOTBsOWNoWFdWVHYwZkliZm1hWmFMaUE3TXJQ?=
 =?utf-8?B?WXJIT1hYck9IR240YVlDekFZdVd2YkNGMWVmMWozMkhRMHNGczE0VnNuM1JD?=
 =?utf-8?B?R09zNkRDbURSM1MyUVVFT1UwZ0hPVW1zYW03M0g3L256OU50eC9vaktBemU0?=
 =?utf-8?B?aGlkT05nNzBRL2hvWkh5TFhGNkNUYXJMM1kyc1kwdzkrVk50T3ZxWXV3QXdK?=
 =?utf-8?Q?mBSAbOlQyW+xdnka6GXkg1HRL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3664c029-b412-456f-cd91-08dac1cea421
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 21:17:28.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HO8bLaPDqKoXZhwDb50mPkWBuuhHNhSFND6M+j3v0Sz/K8uzG0bTKWSrtz0uvMf8eFqVV66Qhv9ksxS2Qrtvlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2312
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IG5vLCBJIGRpZG4ndCB3cmFwIFJQTUIgcGFja2V0IGluIHF1ZXJ5LXJlcXVlc3QvcmVzcG9u
c2UsIGl0IGlzDQo+ID4gaW51cGl1X3JlcSBhbmQgdXBpdV9yc3AsIGl0IGlzIHVwaXUgY29tbWFu
ZC4NCj4gSSB3YXMgdGhpbmtpbmcgeW91IGFyZSB1c2luZyBhIHF1ZXJ5IHJlcXVlc3QgdXBpdSBi
ZWNhdXNlIHlvdSBhcmUgdXNpbmcNCj4gZGV2aWNlIG1hbmFnZW1lbnQgY29tbWFuZHMgZmxvdywg
QW5kIHNwZWNpZmljYWxseSwgSSBkaWRuJ3Qgc2VlIHdoZXJlIHlvdQ0KPiBhcmUgc2V0dGluZyB1
Y2RfcmVxX3B0ci0+c2MuY2RiLCBXaGljaCBzaG91bGQgaG9sZCB0aGUgc2VjdXJpdHkgcHJvdG9j
b2wNCj4gY2RiLg0KQWhoYSwgb2suICBJIHNlZSB0aGlzIG5vdyAtIHlvdSBhcmUganVzdCBjb3B5
aW5nIHRoZSBwcmVwYXJlZCByZXFfdXBpdSBhcyBhIHdob2xlLg0KQW5kIEkgZ3Vlc3MgdGhhdCB0
aGlzIHJlcV91cGl1IGluZGVlZCBjb250YWlucyB0aGUgc2VjdXJpdHkgcHJvdG9jb2wgY2RiLCBl
dGMuDQpPayB0aGVuLiAgU28gcGxlYXNlIGlnbm9yZSBhbGwgdGhlIGFib3ZlLiAgbGV0IG1lIHJl
dmlldyB0aGlzIHBhdGNoIGZyb20gc2NyYXRjaC4NCg0KVGhhbmtzLA0KQXZyaQ0K
