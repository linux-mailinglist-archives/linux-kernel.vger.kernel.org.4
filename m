Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502EB6E9017
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjDTKZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjDTKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:24:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CC1B9;
        Thu, 20 Apr 2023 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1681986223; x=1713522223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+m0vlMzaiHIRp9HZPTgA7dctUoZ6ZK+31QJVxyyWEX8=;
  b=qBoeani1TyUarMS3FvQKM6mZ7npvmM7sm+KEgAArbr9/P1ztmWAfcKxJ
   HA/1Y/PwquJzIEwEe/WGHbm0UAKU4bLvNar6NnxTE+tX4yUdHwxQ+TT56
   271Zthg2z6LWAWiT3MgLDyoiALHCMGD8virNUXMkHqagN1k7AsKssFDEC
   K0tDl9qBwHlU3eomVb8HJ62P2xt4o/6fU6fyII0yf7ZWgwHx0dpC3bqHz
   3tkblAECpIXZo1I3oYUm9atsdXcogv55Q1nG9hZdKWsjpWVSnxnzNftvH
   ZZSQo6IQ6xNs5aOD4hgKblfyiHcf9nq78WuvcSUd+B4GRldbDhVtFfT4C
   w==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677513600"; 
   d="scan'208";a="229002301"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2023 18:23:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZaiJ2q8hWvPRovF9sH9gEuk33Dx4nwEUdQ+rIrfne7CNAIJKzm68Aor/uzzI1jezuWnr1hV0Lbi4/E/Vlv6xist+j0nTaoQ0bhVBW5yp4G7TEzg4ZZr4WMmfBKtz6SWlNeGW45r6AcFJSXSLPby5aKWSGCqdmoxxPi/OscxXEZpl1XAR6T/cAfA/0GYbxB2cNfEgD6O6FSVqGIqVTWyDbhEkuxz64PnaB1+b3boAo45/X1uw7RHdBxQ0KKb1YPV118bI8mtyEaYG2yBNaOOwkhUExUiLq54QdBmR0a9bRfXCepU2sMtWqn+WgihRO1D4KlDMbW2jFBAmyPXLuUfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m0vlMzaiHIRp9HZPTgA7dctUoZ6ZK+31QJVxyyWEX8=;
 b=HzybtS4GBdokh/G8Af46n6waxb+SCM+n1WYZZnygbf/KyPtyrZoGsPevhaFcZpmF5lwzgtYO2i1331CQN1KWv9QyX+onkmkId4nmHjFb/ApJZaBtEtF6uHF2GPevRjJvLVhsbdXqsEBzsyL99/lZfsUFsIcnIiozuqmbmsvqUtCxjLcNid7ibssrs+1KXWUqee5Q1yFmaAl0nHYsC1Gfx8TKKZI0s7iEICSGXQx72omzDaUR9mMhzfwFVEr6ZY3ATzhm7vPDO+idfpQpooFW2pWbYsf+jmU5Tj0jdq2KihBd2euki4K5hzxq+Z+JaXhkW+/RCVpiZwqUfvsX6tpmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m0vlMzaiHIRp9HZPTgA7dctUoZ6ZK+31QJVxyyWEX8=;
 b=JISrJtScY2/LM/7s8dwK/Enk+9YVPHKY8FyA0s923qUxwdRHLEOHicJnaNzSuJVgo5jF90WCbeNuxQ9e7mbOS8WZEbUsqwM5pkHnrclWpoBwZD5GFvZfY/dDgFhNuqQbX61yU1jIKIDbcu0vIhnkZQy4wpor0PVT/nPNQrm1Hzk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8389.namprd04.prod.outlook.com (2603:10b6:a03:3d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 10:23:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 10:23:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: RE: [PATCH v3] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH v3] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZc3CF5Gg3B5/BOUqgHkzjlXPpmK8z/JCAgAAAuTA=
Date:   Thu, 20 Apr 2023 10:23:40 +0000
Message-ID: <DM6PR04MB6575720218D06C3EF9721BF2FC639@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230420101116.173-1-avri.altman@wdc.com>
 <aa86ac49-ffb4-7a4d-8333-bcf3a9b99140@oracle.com>
In-Reply-To: <aa86ac49-ffb4-7a4d-8333-bcf3a9b99140@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB8389:EE_
x-ms-office365-filtering-correlation-id: 8003aeda-aecb-4d47-44ac-08db41894f6a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whc4fXNL/I8ryEMtO7YHQEVfJhb6LILFgYngjLx7ZC30B4ks3bhsK39wLs73pm9pJjDXW/UaQadwnHWli8rw1Fafbc9FxqXzLhtnZ/TUT1epDlvESxUFFRsGh82H0YBfMi1IoAF5gjNPFDsjXw/RGxBOx28YOQ243r5v6cZRzN/5rrv3QDsaX9E2zUFfYaXqol5Kl8ielb5z+V7E4IpTCLW6xStqj+Mt2aXE/XcHSpiqS4jnnc7xes0y2TCp8xJbhiq6J6UrnLsnoUi1CxsjTx9fvoNA+d8n6Ac7vXz7cHlBZrzDDhlhiLrW5e6pEPrBryIP1CTtoRpfvGARbqwwXqSqD1kJJCW3Zlia7ZSnSvINbGPHmRRYIzfOug+96NhMT1F/RNQxCKi6HXQlyN+/8dKA4lSP/Sb9I5mxtOmbU2qmIvn5uwNFCeI7EoPlGUcTKXdIjpOkN/RuNFunZ5wvYDN2TaPMuW4uxMcI8sIILwhDIjSaEFTUcK5TXaLVV+Nzkp47Qk5zz8xn+phBQSQSMIKNvodHM3CcTx/t7yIfrbjRLqskIT4x4ByJ0hLgUa/ursSX9uvo4JsTAh5OVJfeT50jYc/cde0hRIQkb4yTxuDu2S/VdrlGqrVcDOX9raVz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(186003)(6506007)(71200400001)(9686003)(53546011)(26005)(7696005)(41300700001)(5660300002)(2906002)(316002)(4326008)(66556008)(66476007)(76116006)(66446008)(66946007)(8936002)(8676002)(52536014)(110136005)(54906003)(82960400001)(478600001)(38070700005)(38100700002)(64756008)(86362001)(33656002)(83380400001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzVxSk1JWXBINER6NVJ1eGxraDhwdEdMM1gzem53QXphdGNxdmliWnovMVdX?=
 =?utf-8?B?Z0hKTFhZTnV3VGdoS0haQmVlRDdxR3R2dmV5ZDg1OCttWVRsNm01QWNXRmFo?=
 =?utf-8?B?a2JnMXNzeUFtRkxoVitMcTFhL2x1S0lhS09NNFh6Q2VZd3NSTHgxU3ZsSlhV?=
 =?utf-8?B?TmJIcERIMUtkU0xKUFkxMTd5OFBXQXJGRTcwdnRRY2RqTmQ0Y2hXeFpoSCtI?=
 =?utf-8?B?Z3IrRzBCNmdXNzhzNW5hMlFYN29nQVpOcHZ5Nmh0a216SHI0SFFHTXlwc2s1?=
 =?utf-8?B?UmVXZGcyeGk1Q2dtTHFwZVhROG9vT08rZXhIcHUzU0NjNmdKZ2RWc1FQQ25D?=
 =?utf-8?B?VTRQV09QaThsMDFObG91WkNkUXRaait1cnhZcm53QVBMblQwNEdJa1Y3Yktt?=
 =?utf-8?B?aGx6KzNwTDMxK3ZDTVRsczRBMCtaaENqSWo0UmNTTGorTkM0MmhZOHhpKyty?=
 =?utf-8?B?UGVmRDhod3YzdC9NYzRsOGVOdm81OHVJSjFZVm0vMXIyeGlhK01DZjNlTjhS?=
 =?utf-8?B?TGtPNE0ydmJxNjFYWnp6YnZwU3F2Tmh1QWtLTVpqUGlxdG0wRm5nTXRZNWpx?=
 =?utf-8?B?aFNNNjV0bFo1aktpY2V2dXpNaDBGeVh2MXVtSmx1dEhnOGhpTjZaQXJLY2ov?=
 =?utf-8?B?Rm4vcWtZazdNT0VHcHlDck9KWk52aHJBNGQ3T1NhZ3p6aXFEcDFwTklnempk?=
 =?utf-8?B?ZlArYnY5SlFzd1JmWlJBU1ZKQXRLQW44eE55MU1TT3NLazI5NnIvVG9iQ1NM?=
 =?utf-8?B?dlR3U0lFM1lCajRnTmt1SE9TR0I1am1IbGphZlliV3RvZzF2S0VkWVJneno3?=
 =?utf-8?B?c25OblFiR01SS3c2NlhYTDRlNi9XQmhQUVZnZjZVN2kySHVic2VOWHpjcFRZ?=
 =?utf-8?B?N295b2dROUFZZDV4M3FKTGQybEJZVjNTT3dQZ3NnUm5LMHUxVnpGTmE2NmhJ?=
 =?utf-8?B?VE40ZXFiVWJmVndVbktKSEQyTndiYzhoclpkUjFpSkYyMHVmOFlWcVFuRmVZ?=
 =?utf-8?B?d0FMVXhkUklJUzUxbll6eVZMK3RnbEZTb0VhZmVjWXowamVJRUN4dzNSZ294?=
 =?utf-8?B?dldSM2pFK3ZmbG5CbHg5VTVRbzVMVWVQZzRZRVk0NStCYWdmTG1tdWNOOXMw?=
 =?utf-8?B?Y1NKbGFGN3YxZFkzOVdoQm53VjVJSnZ0aHVoeUdia0Z0bkwvcmd6MDBpcFBu?=
 =?utf-8?B?L1ZBUzl2Zmtma0xrRExTN2ZkOGYydHVZK1BzallkcEhJTU5SSzNkNm1FS2My?=
 =?utf-8?B?T0RmeldEK3Z6ZjNJMnY0V1BuWDdWVmFZZTI4MVg5RHhxYXVrK2tQakdSbkVa?=
 =?utf-8?B?aUNzVFN6RHJJVlhqTXoxVHJNaVptSm84djJLWWZxa2hWUkZjQlVXSkE4aEhF?=
 =?utf-8?B?MzZqdmdkWUdEeGt4REY4RUs4MGxrbzZJNVFmeExoMXRFc1RVdjVXMEgvMXQx?=
 =?utf-8?B?emhvckk3L3pWN1hUdnZuUHQ4Z2pTc21zN2YyUC9NU2dNWERseHNkRnkzY2JV?=
 =?utf-8?B?V3FUdFgycE9hOVB0KzRPMEV2R1NvazRiSUtidWU3R2QzajlZWXVkN0Fja29l?=
 =?utf-8?B?cy9BS0Jnd1YrU2xLQkYwKzh2UU1DdkpDZG9oUjN1ckxMS1h1YjNVY3l6MVEz?=
 =?utf-8?B?WldLcy9Ud2xnZ3Z1eHZ5c3puZm9JcmZXT0F0RnNjek90cXF6N3FkSUs5bU5m?=
 =?utf-8?B?Ri8xMmZ1WmRsbTRYV2Q3Z2R2a2FTM2Q5UWlrTHFNVmNzSlRSSlJseFQxSnlT?=
 =?utf-8?B?MWkwVFRlNkpJVlh3bStXbkhtaEY1L3l5Unl3ZWVDUTliTVB3SENqVGVQenVs?=
 =?utf-8?B?ejRVbVhZZ1pER1JpNmlUcW1zWGhSWllybThJNmRwVmthNHNyMkwvSVFub3F6?=
 =?utf-8?B?dUxQZGtJSjlYaEE5ejJwTERZLy9MVm5pOVlNcXRtQWkxVExoQ1pIdWlZTXJW?=
 =?utf-8?B?ZWZhckZCY0JseTFPb0c3WkVkRFkzTy9wYXJRNklRTkk3RUFyMGNTMnVmQ3U1?=
 =?utf-8?B?bThRVkRIUXRoSzVybFluUXFSaWZ3Y3ZIVVQ5bmJEc1ZCVHNqTWEzNklJN1R1?=
 =?utf-8?B?NzhGWGhrNndOTXVGcWF0YWw2eXFsd3lvMEcyZXFCOVRLU1dTdkgxbndGaEIv?=
 =?utf-8?Q?UHhsrNM6a0x8pYB5u/gAqehei?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ERAQGTm8sxBwaVda9oDihC3ffaVDjBCeZkonxcEq0rYq9OT3VC+Ov+LVh9JPIdgAYhRktsm83bgbOjrMNct4Icu1EpyN2DoB6QY2P2t04fvqTAFI04oaKAF4HWObjU7hZKtQ4SfJsgsWU74O+Rt5MwMXhxVIUpOJicHJwdMi2BNtvP/YuDOnacPFC4bMG497O8/180i4UaNyLspZKRlqHu4G5hUhrqnYWZ4Ky2Zjp1hYlTga0u00U1oegLjB8he3t6ihfZaqLWrX28fisArUfx4t7Q6Kkx7XU5texkRACXwC2DxACsuViS0mMhdJYH1Srct1H8l2uKFaphtQYJNiiJskMTtvdgPTqgVFUtx4RmQdqVgIJ9U/hUIC+fUppClqN/RJ2iWBuu7GZQLB3rT/bvBK8z8AklWjxu5bjG/Molt4Gz5NpAbEshoPijOqR/istJDLroJmKbvFPm7KT7D4FBy8YqbJkBxBOjHbyBkvo3mg+tB5sJYK2xGVsGdybH85Ft5PAV4jyiGGY4bReS1SaTuAunC17xqAgqDmtscFD7GixC9PMrVkHQmvgsG0eXqNNiQ9bmBI62z7Kfy49Mw3RQT2FVN+SePYmim70ZjpVdQ11U+EUv9iqfmdgrAoBYlfCJvg38jDfaIePwlfglNi3iECoFnQF5NxJ4KnOhNAtDX0UZeFg3hwwGJrRzVusAd/iSvPZDv4plFtEufUGXfzCK4sBb5vWpKu6/Dyl66YMchxV8NHrxhjbt1isAmc0yVP3/WxKnB2Md/GNh1DqDxdcHP0I7FRW47PtpyQqFT6THvbYnzkk5usVTZFPPNymPKMzXslN3BX4m0HrvfKihlOKJSLDD9ZssPvZFsMaPM+wg4I1bnX525m3/snvfolXsigWAQjniPYrAM/y8uPmYaI4ZT0v8aUjxuvm0fqoObVo0I=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8003aeda-aecb-4d47-44ac-08db41894f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 10:23:40.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh7dqJD8PNV4c7GXpV9rXgoOvjgdBB4r8TlYqDq13GCHkJ1VDU0HUjjkaE4IjpSV/QxjKtBCtE7Igm9k2gaPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8389
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMC8wNC8yMDIzIDExOjExLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBpbiBVRlMsIGVh
Y2ggcmVxdWVzdCBpcyBkZXNpZ25hdGVkIHZpYSB0aGUgdHJpcGxldCA8aWlkLCBsdW4sIHRhc2sg
dGFnPi4NCj4gPg0KPiA+IEluIFVGUzQuMCB0aGUgSW5pdGlhdG9yIElEIGZpZWxkIGlzIDggYml0
cyB3aWRlLCBjb21wcmlzZWQgb2YgdGhlDQo+ID4gRVhUX0lJRCBhbmQgSUlEIGZpZWxkcy4gVG9n
ZXRoZXIgd2l0aCB0aGUgdGFzayB0YWcgKHNpbmdsZSBieXRlKSwgdGhleQ0KPiA+IGxpbWl0IHRo
ZSBkcml2ZXIncyBodyBxdWV1ZXMgY2FwYWNpdHkuDQo+ID4NCj4gPiBUaGUgcHVycG9zZSBvZiB0
aGlzIHBhdGNoIGlzIHRvIGRvY3VtZW50IHRoZSB1ZnMgc3BlYyByZXN0cmljdGlvbnMuDQo+ID4g
cHJhY3RpY2FsbHksIGl0IGltcG9zZSBubyBmdW5jdGlvbmFsIGNoYW5nZSBiZWNhdXNlIGEpIHRo
ZSBjdXJyZW50IGh3DQo+ID4gc3VwcG9ydHMgbXVjaCBsZXNzIChtZXJlbHkgNjQgcmVxdWVzdHMp
LCBhbmQgYikgc2luY2UNCj4gPiBzaG9zdC0+aG9zdF90YWdzZXQgaXMgc2V0IC0gdGhlbiB0aGUg
bnVtYmVyIG9mIGluZmxpZ2h0IElPcyBpcyBsaW1pdGVkDQo+ID4gYnkganVzdCB0aGUgSFcgcXVl
dWUgZGVwdGguDQo+ID4NCj4gDQo+IEkgZG9uJ3Qga25vdyB3aHkgZWZmZWN0aXZlbHkgaXQgaGFz
IG5vIGNoYW5nZSwgYXMgaXQgc2VlbXMgdG8gbWUgdG8gYmUgY2hlY2tpbmcNCj4gYW5kIGZhaWxp
bmcgc29tZXRoaW5nIHZhbGlkIHdoaWNoIGNvdWxkIGhhcHBlbi4NCj4gDQo+IElmIGl0IHJlYWxs
eSBjYW5ub3QgaGFwcGVuLCB0aGVuIHdlIGdlbmVyYWxseSBkb24ndCBhZGQgd2hhdCBpcyBlZmZl
Y3RpdmVseQ0KPiBkZWFkIGNvZGUganVzdCB0byBwcm92aWRlIHByYWN0aWNhbCBpbGx1c3RyYXRp
b25zIG9mIHRoZSBzcGVjLiBBbmQgaXQgaXMNCj4gbWlzbGVhZGluZyB0byBvdGhlcnMgd2hvIG1h
eSB1c2UgeW91ciBkcml2ZXIgYXMgYSByZWZlcmVuY2UuDQpCZXR0ZXIgdG8ganVzdCBkcm9wIGl0
IHRoZW4uDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gQSBjb2RlIGNvbW1lbnQgd291bGQgYmUg
YSBiZXR0ZXIgY2hvaWNlLCBpZiBhbnl0aGluZywgSU1ITy4NCj4gDQo+IFRoYW5rcywNCj4gSm9o
bg0KPiANCj4gPiAtLS0NCj4gPiB2MiAtPiB2MzoNCj4gPiBmaXggc21hdGNoIHdhcm5pbmdzIChE
YW4gQ2FycGVudGVyKQ0KPiA+IGVsYWJvcmF0ZSBjb21taXQgbG9nIChKb2huIEdhcnJ5KQ0KPiA+
DQo+ID4gdjEgLT4gdjI6DQo+ID4gQXR0ZW5kIEpvaGFubmVzJ3MgYW5kIEJhcnQncyBjb21tZW50
cw0KPiANCj4gVGhpcyBpcyB0aGUgd3JvbmcgcGxhY2UgZm9yIHRoZXNlDQo+IA0KPiA+DQo+ID4g
UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIHwgNiArKysrKysNCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0K
PiA+IGluZGV4IDAzYzQ3ZjlhMjc1MC4uOWNlYmVjNmJlMzVjIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hj
ZC5jDQo+ID4gQEAgLTg0NjgsNiArODQ2OCwxMiBAQCBzdGF0aWMgaW50IHVmc2hjZF9hbGxvY19t
Y3Eoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gPiAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAg
ICAgICAgZ290byBlcnI7DQo+ID4NCj4gPiArICAgICBpZiAoaGJhLT5udXRycyAqIGhiYS0+bnJf
aHdfcXVldWVzID4gU1pfNjRLIC0gMSkgew0KPiA+ICsgICAgICAgICAgICAgZGV2X2luZm8oaGJh
LT5kZXYsICJ0aGVyZSBjYW4gYmUgYXQgbW9zdCA2NEsgaW5mbGlnaHQgcmVxdWVzdHNcbiIpOw0K
PiA+ICsgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgIGdvdG8g
ZXJyOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gICAgICAgLyoNCj4gPiAgICAgICAgKiBQcmV2
aW91c2x5IGFsbG9jYXRlZCBtZW1vcnkgZm9yIG51dHJzIG1heSBub3QgYmUgZW5vdWdoIGluIE1D
UQ0KPiBtb2RlLg0KPiA+ICAgICAgICAqIE51bWJlciBvZiBzdXBwb3J0ZWQgdGFncyBpbiBNQ1Eg
bW9kZSBtYXkgYmUgbGFyZ2VyIHRoYW4gU0RCDQo+IG1vZGUuDQoNCg==
