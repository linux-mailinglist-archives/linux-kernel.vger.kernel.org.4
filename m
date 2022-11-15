Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD3629933
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiKOMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKOMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:49:45 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD21E723;
        Tue, 15 Nov 2022 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668516584; x=1700052584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zzYNay27brpzuqgQ1v0zGry8P+XKulfjqMxO62GlhQk=;
  b=OkSGc4Hnyn+C5woEPAT6amF4mgGW67KpiFU3tgVGFSVlCvM6Qf0octHj
   uJIOTYRJ4h/fA2mPu6ukoqhVp8QMhRdOe+z+9f2sAZgyDGlUUXuB2i1Rq
   Io/9LzTiJGZOc4LWAZDZD0u32M9aNT9qnD/Y6CEj67l+9VaQp6QmD0O7R
   Jv4MSKaenTFHHjZfn8awTqTtE522Fuyqr0IW9tR4ybd+qUHaY6Isw0Unq
   4d4HVtbzREM6KrHmnEWX53cTxgawZIch2KEaRCcymFCG5abbqpLSPgcUw
   e4sS7QpFoUsq5ODAX+OKnsjF5nMKQBkU/9XDeenzONjOmXropjqRcRCJr
   A==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665417600"; 
   d="scan'208";a="216640469"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 20:49:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwKloRiQwqwQZ2Ie4O9iTx1Oi3XIAXUFN3h2WOXpxsQDhz1KegxVZtLS8pQEozlV2c/k3+nlL7a9jxR+/urg1tCnBsITePutKCmn9h/lVROS2tyuU0z+YUhdSdQwQtGWClKCcWbZwOgD4yu7cRlW04fjc8jOU2o8r2wVPjkoJC0qxpHz/VwUTVviO43nHhLfccVss61mhx7FEBu7M9FhB0AhPP3ZQ1VojdFUG0cdwECTSyBfdZY+VK6KEyKmDNKfX9GDOXikd/QXo1tFq2YQvykPCjIKJrBDXYHzkEQYjzxSSrDpKQRFcYUhwAFRT0jcCklf/wY7xzLls5B7dNmH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzYNay27brpzuqgQ1v0zGry8P+XKulfjqMxO62GlhQk=;
 b=gYUP8kL/a8tzIA1oZ/25YcLL9MRacy/bkhNVVoR1ZR6D4HnPycei9q6ZYIryey9dNV5IjpyGqYYGDHvlFaNqxbP4m6NqiNPP4uM6Dn9/hHhglA7jSP4O9urJ71nUa02LFiL9CMKl2z8+ywwkP6nB1PGppsNGVHeSd1NgQpK2SUd/1Zki0Gt3qTbKNJ1bm7csnTnKYZ1yuny0NyMEOzpz6KUxcAbslhBZAfAdcJcfsjwTYT6kbNIaeBFSfSoAw3Fnighgle9Q94WSV/QIjj3mwZRDcDp0aniV3Mpzjab8wHA25BJLFWO6+6Fga4PxqZJHgUyU/vLYGwmqT0Hv4cfujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzYNay27brpzuqgQ1v0zGry8P+XKulfjqMxO62GlhQk=;
 b=kLKyTXuDPCncw2gEbcLTcx2cZwUo/KOkJigH4MUo2gQ1AdmvIE/uOhKCun2toC+1f3632FRdYcg94JbNrM7Ai2Agt9RKV82ajLx61mgNTgrGxRlJz7K//zKgtvGcqVOQ5/7aozRina2HcgAwMUQtkRZsbTdXvrnlbEgpq8rcjow=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by MN2PR04MB6846.namprd04.prod.outlook.com (2603:10b6:208:1e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 12:49:40 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::5819:f0e0:8608:aa8c]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::5819:f0e0:8608:aa8c%7]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 12:49:40 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] ufs: core: Remove len parameter from
 ufshcd_set_active_icc_lvl
Thread-Topic: [PATCH v2 3/4] ufs: core: Remove len parameter from
 ufshcd_set_active_icc_lvl
Thread-Index: AQHY7seWBxtdVlSPEEeBAmb5COtj/K4+aR8AgAGaY7A=
Date:   Tue, 15 Nov 2022 12:49:40 +0000
Message-ID: <BY5PR04MB63271FC7383B9DA15141CB79ED049@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1667399353-10228-4-git-send-email-Arthur.Simchaev@wdc.com>
 <4e205f57-673f-bd7b-1c04-5f3c8db0b054@gmail.com>
In-Reply-To: <4e205f57-673f-bd7b-1c04-5f3c8db0b054@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|MN2PR04MB6846:EE_
x-ms-office365-filtering-correlation-id: 9ee8cafe-bf5e-4dd5-fcf2-08dac707dc65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFJjoKVtNI61tq8JEtri2NHEBsgkgnZm668uJxVMpzyNgmyN0gkCAcgH8DIvyT/auiROqGMxtSbuehnmOFl73RJLydpcA1Mit5t/bjl/MHQn0qc5NgQWW8M09t0IfAdnSl2O03FmY+LJScYI5L8GAcq8VLqUny5vt2V0J/ks9zlnH1ztGS/kX4k7yaPSuSO0F+ctYK3SfUuPhORN4iHrmuz30bmLTHB9HsA7Xh4m5n9RxZqkGbkKB33PllMA2N0yJxPpBXv6q96jbG+gn8k7MQKKyfqtbJoxHrEbGByMLPwAQKXJdlaf8Hi6dtvcEuiUSBqD7xOAeltIWKkE1pmxtz8UXh0nI5ePFh96ckNU/bUfZmoB43r/Ooxiajvp/sklkQTkSlTFUORZc1SYLtbTKaNgv7ktRSoHLM+YUiZGO/34c4VDq4ekYweTYADhvBGrns70LE7xtP0JniUhic7l5QkX8Poohc+Qex0CZJcIoa73gh1U40QnyfD3POEu1z5v6hz0f7RXF2wyrhd85oY4IhClug0SEtPnuG6pT5VN+Ho/BvXde9p1ReBFNmSnm+CkfSdlWa5GXdMpmuO6l3f6C/Kqh4aCmlOQaUo+Z6MHUOUNJZPT5pidXVOdWYWAx6Vjjbq0y+mX9t3fk9NeODcA+yIXMcP+/Z4DAzy9BH5NQSF0gVKVVDTT0annvtwoPvpHoxujtlp6oIO2PnOkCX+GKTgC3BDM2MHJrfof6Mmlmz9HyJVChH+/ETpFr7WEn/nUvvk0adg8bNhJih8o/fN1qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(110136005)(5660300002)(316002)(76116006)(8676002)(4326008)(54906003)(558084003)(52536014)(64756008)(66946007)(66476007)(66556008)(66446008)(41300700001)(55016003)(8936002)(186003)(86362001)(38070700005)(478600001)(33656002)(6506007)(7696005)(26005)(9686003)(71200400001)(38100700002)(122000001)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjE0MlRJRkNUTmhSNFdIL0p2a1QzSWVPc09CMGhrL3QyRjBHMDY3d2trb2hL?=
 =?utf-8?B?TjFBQWc2cUplcTE2cG82ZDZyZW5sREprcnAwZnVYNjlUNUcvcEJIUGxNUmpv?=
 =?utf-8?B?ZU9CMDBzaWZ5Q0lZRjBFUTR0OG9hY21uT3FIOHdKcmloMngzY0lqdkYzSVhF?=
 =?utf-8?B?ZXpKaEtLcEVqNjdPeWRicTVGTE8zcldmU1JhaklPdHQ1ZVd2ZzRGcVpUSE9j?=
 =?utf-8?B?eWdoeGQ1MnZEUFI3RUgrenFDL1dPcjFaejBSSkw3aWNoZ1MvQWR3M1B5TmFL?=
 =?utf-8?B?Y0NheXlYOCtPYUMwQ3Y4WlE0TWQ0aUFSdVd1cVh1Vi9UV0pJeWdTT01lZzkx?=
 =?utf-8?B?S2MyK041d0pxazNkalYxekJSZmtmd3V1Z0hIa0VaZ2w1cktQVUNMdEhGczYy?=
 =?utf-8?B?MGVlNVdlaTBEZDZsODc4SW9iSFd6UEh2aTU2cXdLRUFER3M4aytDM1NvVFVw?=
 =?utf-8?B?dklaTnkwSnhFL2MySm1XRSt3QVdLSGs2YldQM3lQcEl3NklmRTROOXFqellZ?=
 =?utf-8?B?QVRoUGZqdWRmeDRoRkIxN0RTMjFGNHZkMExkcFlDV3ZSWm9kNXdtQlArdUVW?=
 =?utf-8?B?QnN6b1dGTW5MSWxJckRsZmo1Wm1SUU1rdG9aOG1HNnBiMk1PUW1CZENLVk1z?=
 =?utf-8?B?VU1RVDFBaXB1YVNpaThnZ1BNZ285cC9PL25hNnVldWdlK1VVMm9NQmpaSkVm?=
 =?utf-8?B?WDhYT1Fkdi9vd3lKeFk3eVJCTkdEbUJFY2tzd3hOVFZWOWhONXJpK2NYUXVW?=
 =?utf-8?B?RS9DL1RLWWJ2em93SDBBZnlQM2MycHgvUTJyZk9ZOU5jK0tEM1o5Mk5yZUJp?=
 =?utf-8?B?MFhaa2c4OFA0RXI2MkFmcyt0OC9sZnVPZzhHKzhSUVlPV20vUkM4c25WL2lF?=
 =?utf-8?B?amM0bDcwWE1paFN3aWZxUWcvK0VKeFUzNC9EZUtyTXllaGNKZ3BWQThBYzRx?=
 =?utf-8?B?dDd5N0UzR1dTcW5QWnBFeWdXUXVNbTVDOFE2V21yYzByd1cwQ29oN2hJM1Zo?=
 =?utf-8?B?UFo0bzZUUzhidkZmY3g2UEdkcUl0K0ZpdUlKb2paY3h0Smptc1ZWT0NScnpJ?=
 =?utf-8?B?enFtdy9QcG13Slg4TFJvNFh3SlhveEZ0azRMNjFiVnVnaS9LNVl4cjUwcDJT?=
 =?utf-8?B?bHlNdTBOMWNDYkNCUFpLTVp1SmUwbzdIbHFyYmN2c3pVWmJLdHFPQXNFa1F3?=
 =?utf-8?B?TmtnallMYTJ5Qkd0RGpaTnRNQ1FaT3djemJxYmp4ODUxaXFBRCtlUTF2bU56?=
 =?utf-8?B?UW5ERXR3b1lhTit4bnFkQzYxYzg1M3FoUmpobzZBaEtJTGNRYjNZb0M5aE9T?=
 =?utf-8?B?NGdkTjZFRm1Pelp2TFdFdjNySlROUWlRZ1NReWNBMEliUUVIQ0VQVnh5endW?=
 =?utf-8?B?ZW9NcGlIUFYvckhQOTBXcVRnSnVZd0owMGMyYlRkUEUxSWZBYkNMdVJ4bWEw?=
 =?utf-8?B?L3RhQVUzbG5VcjQrUXdQTmJ5Q3dpalZUek5jd05iVUZkSnN0bEl5VGJIcFRF?=
 =?utf-8?B?OFdMaUdjK2lSRG44WUljVWwyT2VTZFc3SXJBTzBoUkt3Tm5iNGRyL3ViVWpH?=
 =?utf-8?B?N0dxM09hd0NXNFRZdkxRbEdBcDYyV0Ribnd5VFhSS2J0Q01KZkplU3grbUwz?=
 =?utf-8?B?YkFiT0lEaUpEbzY5QWFodlNrU0l2TWJFVG4yV01Mc0lXcncrSWw2WGRNUk1k?=
 =?utf-8?B?aXB1MCtYd3BqSng0aEx6Z0g5NHYzZWlTUnlHWDhzWldxY3p3dSszcjQ4T21y?=
 =?utf-8?B?aG9vY2drWmVrRXkxNTgrdmdtUHFKTFZxTXdyUVp1NGlvdlRpSytxQmV2ZkJT?=
 =?utf-8?B?NEg1QXMrQ1hmY2RJSXl6U2VqdEdkdXZ4d1ZuT0g4a0MyRjJ2emZZMlpLVnps?=
 =?utf-8?B?clpxSDVpdzRXSUFmU1BCSHp5NUd4V0dOOXozNHRYNlBnMDZzOTNsTVNDZUFC?=
 =?utf-8?B?N2pwbzFWQ2VhRlBxbzBZTzNOR0c4SXVyYUZ4ZVRrR3JKRThnYnBxck93MkFR?=
 =?utf-8?B?di9HRHVHTnZqZVVUYm84Nk5UQUF4QUpzQndOYlA4dGtCT3VISE5ONmdwbmdz?=
 =?utf-8?B?Zmx3T3BGRDZZQW1pRGgzVDdkTEpjQVVmNnAwckx5eCs0d2dFNTNBSVV5NVpD?=
 =?utf-8?Q?6X2dIWEZqTMfPv7KVzzbTCQ6d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LPSw0Hsw1kLJXWkxqqw72OpPVFqx1/v+HxZw8iW8wPO35+rp1cdmVKGyzhJl8nZAbPq6ngpkbagRSR3mSNIoecASr6ikcd4ty9zrmP5NSjrNC1UP1u4dQE3/TRvvZzv7RD7/XvNuu6tKIDYIRMnSQ7Twxu6MjI1MHCU9tzsW0IXha3v7ean33hooEKkNiIuXM0lX1jFES/c79hsey7roTpHjWUgAVtYJuOH3BC4XtmnO6s/RpRyDlMh9bC9QoPjBey9u0EMau8ai6h0rjCWxZirS+VMK7+Hks4roX8rjFq1ThoCbF7MuAK31jgrrjSM9ZYiKXe1z+vDZekemXcNUw5h+69iy6SRAAARUCQCWXy4+S0B3THQ4mvHyKzZBkw4Aywy9HuTNVqEnvJ02vQxicKw6qmWICRPtPdHPUw0M4sQ9H7zrYu8HNM/T+qjobBy3uxNfgUh9/A47ImZjL5PctkhclxjbKC8vuADqnXqwvsuMxSko2Zigk2PtFGfb9jk2oiIBNAKdZFT/xXAoXrSG5NBOZI2FlKnvFhAjfn+ikdotOlLdVgzVkxWA3vSSbqX1mwN5KCeftPj1cvLhks3xPyIhovZGacxGYCyMo0K/hw+FEN7o85oW9AQp4Qgi+sjTjSIo5/kDng16OZCA9u0Flt/ybkUewcnoRPzxEXMaOEzFLMio9f8F43bcfNqgmbvqV0/btru1A+Arn2L02E6PbqswImwv1mvR0Z2YFFBGtwRbEWOnMAlrIzR7kP2RkA47VhJGlzF2W+acGjuUllgau/b9XozvlmmYr/+twtx+fC8WMQVKILw8DqH8THJbqYKtfez/gjqiWONu3JK+BYBNSbu/XThOokfnqXgIEtg0D8aXcqMnBd7eY2abXz9qn7B/4xL66cSXp4k6Wk0tJ4wKj4SY7/OyNNMO9hQSiTppDSs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee8cafe-bf5e-4dd5-fcf2-08dac707dc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 12:49:40.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bVKgRLp2DyhWrQwvHQqZcal495gCR3cXq/T7Kj70bjNKo6aTwF5rnvM+McZzgQJb9hq1hE90yqotgpBS2pVZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6846
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gDQo+ICdsZW4nIGRlc2NyaXB0aW9uIG9mICd1ZnNoY2RfZmluZF9tYXhfc3VwX2FjdGl2
ZV9pY2NfbGV2ZWwoKScgc2hvdWxkIGJlDQo+IHJlbW92ZWQgYXMgd2VsbC4NCj4gDQo+IEtpbmQg
cmVnYXJkcywNCj4gDQo+IEJlYW4NCkRvbmUuDQoNClJlZ2FyZHMNCkFydGh1cg0K
