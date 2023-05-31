Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442337175FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjEaFFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjEaFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:05:39 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9CEC;
        Tue, 30 May 2023 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685509539; x=1717045539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nXrwP3cRs+q7OrmWAmCwFKW/6OjJEwMDhg4Z6OjfQAY=;
  b=O9boNTZoD06JTbt1H2MmYqj/4h0APPzfqawahDbr0RsWX0eZgP45XCme
   SiLWegIRAFR5UD0Iuvm0wT7v+0oY5k7sH3zvyzrPQAtENIkO2opeM/m0i
   hfhjHQds54Pyepdb+v09Zu+3xF6jcMZiD98yquht7L0q0U0ZTp5fOTr2I
   pd2FX1+VB1ovMUa/k/I+O9omiOxGYpNf1CXKE5l8GUDwNJbqCYdIKR+KE
   kF2CcMp1ZDRlCdy0RVJQvm0qgvUrM1/E28XlD7t7Kbc4Vs9c51sBtVibP
   Si7EUKxyx52Th+eYOJn8GuC+Dy1xmx6a75EBGX0WtoqtndfB5dInKGcAe
   w==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="231960164"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 13:05:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAHQpqA7HPJ0H6m/2OhkAbj8K2NYFPeigH2Kt2EHmhRczV0XUdhVUaKeeSf2fmX6B7Y9fdlrNOVGMsfBDgTAeOkPRNVyWqbsbjr8q5TNsJ27l6ee7VzC+T+Gw0kkcxUO+8NuQ+gs3yH2EzCB+d45x51GEaEWQAfSawoj89TFmosFKR3jqD65t239ESFv0KcvtI4msH3pJOGhOfYrtmrWdqlPnukJLU+k8gnRBUX7Ouxzl/+MhhXtEsxW+wNVaIq6zQ91gi6VmxNmq+GnGXsbZm+PYbSMQcyAt0O+vA8fw24SctckFpb7H/uijc6k82K+60BGwYD9+U1zFULaUO+fWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXrwP3cRs+q7OrmWAmCwFKW/6OjJEwMDhg4Z6OjfQAY=;
 b=XhSw8sXA+thVfPy/1UBA6II1mZIGCEKIzFJvPFzMGN+aKXvKBpnQADgUDf2wpCXTGlocFxvkPwR/LDlxZXT6uHIy+cXsgZmcrMZ/nqR/0YUsTOP26w6w+6qjXLVaQjVtZSl1Y7HNG1PoiHow3U6I4oRwkClwUrXZJLFBBEbHhDhWFc2yBi6LlbJJLeCeKBBUnWu0NVx1aDcXnj+nQxFgz6Fn0LCk8hKy3FtcptcBSYkJz7x3n5aEwLHDxnkxxldLV///FzcDb5iCJXXldTLw+RPgzjeq7W5aEwL8M1B801XRsM+mBp/NjWW034ml8On2Zpnrvasa2eUhYSVzvQijeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXrwP3cRs+q7OrmWAmCwFKW/6OjJEwMDhg4Z6OjfQAY=;
 b=KdaytoOQQ/RR8Vo6IZ/vslX3wWoKcz3emKOpLoybdDl21GsfnYvvsP7EOD0d+ZApFCyC35m4J4p3hgkHImkd8I6E62w+2oZIbGrDHNBEu8RAGOHWI1y420BWhVN3oJUi0JXxNUzgGcUqIzn5Q1P97ssg6rZlmMGGxOK/LarDw2g=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by PH0PR04MB8525.namprd04.prod.outlook.com (2603:10b6:510:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:05:35 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::dc4e:29e0:7689:e1ce]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::dc4e:29e0:7689:e1ce%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 05:05:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: core: Do not open code SZ_x
Thread-Topic: [PATCH] scsi: ufs: core: Do not open code SZ_x
Thread-Index: AQHZkst29nazAYNZCUKw+VPGcuNRqK9y2ryAgAD6foA=
Date:   Wed, 31 May 2023 05:05:35 +0000
Message-ID: <BL0PR04MB6564EDDD9F558026951BCA4FFC489@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20230530075033.11006-1-avri.altman@wdc.com>
        <CGME20230530075120epcas2p10917546a2e01da2a17c34b7460f85eef@epcms2p3>
 <20230530140809epcms2p3aff4826012218b0e937e02aa3e30bec2@epcms2p3>
In-Reply-To: <20230530140809epcms2p3aff4826012218b0e937e02aa3e30bec2@epcms2p3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|PH0PR04MB8525:EE_
x-ms-office365-filtering-correlation-id: b9e1638b-85db-4307-b8b5-08db6194ab30
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlM9z9W9jRqelXYRZ/vTmUo37zPSw0hOgYz4IGdAPsF5jNR2piCybmbo3LeJbU9MJ428iYFEHADVOpgr55ng3kynO+5l/KdMEoGpliy0enb0Xo1BlVEW34Ln+D03u4dYFU0uEY5EHfQQDKQ5zCmi4rBrcAgPBZ6OIdhAX+ugBL9gDt8Cle8oXIWf2FiTHcyH2cUyDhbvMTrB/h7jDfNU8xrj//qATzhnot3KlwexYM8riFhdVpfMqSniyvXB3vhNwy09DmPwWppcKwWZUsYXCKshhyZECeu6LCB8X813C3c2uBNtH7FYboDtulJhtsGKQWJeO8CrENYsPmgVm0yxT4srzgwknegjAgGlRB18zGcs79Z3xdNjGcDPeqTBCqBkUdTz6pDbs/aHE9hXP5/bKSUysoVPiGOy1xxRHbn5mm1/LWWWY4Bma4nQBI3Pljeh94zwyhmawjTNRGqa45DdnuQV9RmI/EU8mWNo/rR0ccX1mDoL7fHzFYqd/UlQ43pudw6MTnHL5d3CllBj0I4gDmvFU4rg4yH5Zdsr3/Lc6/rQCd8S7raoZk/TVRg+Bra1b8Bgn0oQV2Wrk4P8DG159B+bPHg2o8RxT+JyXUglEVAE4Z9YO88s+ergYRDSdxU7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(66556008)(66446008)(76116006)(66476007)(66946007)(64756008)(38070700005)(54906003)(110136005)(4326008)(316002)(478600001)(33656002)(86362001)(9686003)(6506007)(186003)(26005)(41300700001)(4744005)(52536014)(8936002)(8676002)(5660300002)(2906002)(7696005)(71200400001)(55016003)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2JDOVBrYWFyRlZYcWpFZEFiNzdockxpWnhCZm9WN3lrakt3bDBvWXduVDRj?=
 =?utf-8?B?aUV0UWoyVll0SXBjaUN1RmpCejZMRW1ZaTNnRW02L0JIdSt0S0FhL1VjMFBl?=
 =?utf-8?B?Y0R4elYyVjQrK3JDTGVQcWhGZS9sTFJ4a2dmTWZYZ1hOZHd2Nm1NUXppdzVR?=
 =?utf-8?B?OUp5YUlYZzdSclRlajRzckFOZWVnM2trdy95c3l3TWlOY3ZBdkw0d1JPTHRt?=
 =?utf-8?B?cnRIRmRGU044bEZFZTV3SWZoUi9RTDE0VnhOMVkzSlJsSGhLazNhei9SNHRq?=
 =?utf-8?B?T2lzMCtRSXJ4cUJ1V1JCNCtEWUcxRkxOMi9GWFFYV2QwNWtGOHpkdTRGOGhM?=
 =?utf-8?B?WWRIbGFGYUh0VllOYkFnYXZ6ZFVUQmJVbHljRWt3MkIzdWZxTVo3cEhxbEZm?=
 =?utf-8?B?ZG9VTWFIYVlWU0U0VFNEZnR1TGFwQVVRUHhmSE9DWlMrd3YwSCtaRDQyN1B3?=
 =?utf-8?B?L3A1eGpHMWpIN0Jtc1FPN3JSMGM5RDVaUzlrZ3hyTnJZOVY1UlUwaElQVC9K?=
 =?utf-8?B?WHkrZ21oOFZ2RnNpN1ZUQ09mVjhGaDNhdFB1Z3JtUVY2RytsOTlxcnF6RTVp?=
 =?utf-8?B?blZFTFppRkNMdUpEY3o2cGI2Zm9LVWRFRXNmb2pGUE5saVExQ2ZLTnp3ZFRU?=
 =?utf-8?B?enlHKzBRWmR5R3F5bnNpNEhTZ0lUVW04b3FSOTNVSWxzVFpLb3ZZSUdaTkxr?=
 =?utf-8?B?eHBxNlhsVzA1S0QzRkxTQkZHMVVZQUtOampmUGU3NGJ2RVFSd2NFclJjZFE4?=
 =?utf-8?B?b0hUS1JjWVNtQkRoOXpsM1hteFVKL011SlFWZUZPQU91YndVTVkrU3MwSDJG?=
 =?utf-8?B?cllmeGhoVzljWU1wNkNIMVBweXJoTHNGM2xEalEzb0FjWDhHRUgxVmVpa0ty?=
 =?utf-8?B?L05kQ3g5R1dOd0NLZlJWS0JMLzJuRVIrU2EwS24wWHYvcDhOR0pTVDJwVk1C?=
 =?utf-8?B?ci9TbXJaemZ1bnJNYjMrYVRtc0hCRERLWElyczNNd2xVQ2hRd3hkZ2ZlaGNE?=
 =?utf-8?B?WDJmYjlBTlFpTUlZWlZjbDlmWWpsLy95MitvZG9JNHV4dnVvMnJUaUN2cHdk?=
 =?utf-8?B?NHN1MU5iZCt3TDZUZyt1d3BjV3JjVEpXL25UaTRGcWV4ZG9qbjVxMkFjVCs2?=
 =?utf-8?B?TTdLRmU0U2tzRTdVNGduZkhPM01OV2NHZ3lFNVV2ZVRZcEQvMFpHTkcvWkdy?=
 =?utf-8?B?aXd4TXgwSXhLWjNnckZxNmNmUHNFWU9mN3hUeW5lQTRwbThkeHQ1OXhSRnpL?=
 =?utf-8?B?cUN2cWs0Sk0xcW92K2dXK0g4dnljWmRYVUJMRTBvOTNZYXg4R0pGNFVsZEJC?=
 =?utf-8?B?UE1Yb0VrSHpVK3ZjWWVnMFZ1VUtZdE1MNTZJbnpPbUVyMlJlajIwVjFtQWs1?=
 =?utf-8?B?TTFMRkJOdGlGS1RJRGFaclFaVWNxZmMzZCsxWmU1Y2FJS2wvWW11MGRGQkdQ?=
 =?utf-8?B?VnlKNUxUWHV4aVZXL1pYWkZRWURYZDU5bkVybW5aQ05zVStYTGtBTHBoUjg1?=
 =?utf-8?B?V2o3Z1FvVTlUbDRIOUZNTnA4SzBDTWRoT2hIT21PdWRwZDVXaEJEWHEvV3or?=
 =?utf-8?B?OWhnZTk4WmI3SU8rckUwb1hVNmExbEVnaUt1R2VuZjRpSkxNQ3JQYUZPZFVt?=
 =?utf-8?B?MkJiQTdnOURSMDlBSE4yY2lXN0ZCT2FDTzVSK2ZHSlZkSWJ2OXdBWnR0ZUVn?=
 =?utf-8?B?NlQ0ZjFYMGVVQUppMExoT2kyRlpkWmlISGliQ2ZMNHMxTWFjMmEzb0ZwbTMy?=
 =?utf-8?B?enBkRE55SjFYUjBOWWY5SmdSNmhoZWJ2dHlIclBCY2dZL043VEdJY0hlRm5I?=
 =?utf-8?B?WEIyYmw1bUJlNHNqL2N6ZjcweXlTTnF6VkpPTXZhc3lNSnZQMEhhZzY1aG5j?=
 =?utf-8?B?blJ5K1BxcnhIRGlsTkdlOHQ4MnNySDZKRVd0NDRra1BROFBneTNlSE5UbU9H?=
 =?utf-8?B?c1hPL0E5aVl1Z0ZMR0tSVVRIcG85cHU2dVZiL1VicDhCVnpRK2haUmxkYXZV?=
 =?utf-8?B?a0tYSGdndmpXTDVDVmJ1OTNBYklNM2Y4aFloSHRzV2NwTi9ZMjA4dElHVVZY?=
 =?utf-8?B?OVQ2VXZ0U3RhRTRERUZzTFhBV21PeUo0K0J5Z3kvYW9xSEVNVnVpajlzWlRk?=
 =?utf-8?Q?AXEpxOxoJkPhBY925wSuTGDcj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qFNGVD7IHQ0ohC+2UsOkCVaEzuzCOJ8bFH0vtgcyPp/SeeRLKuONZ4niGjtcPlIaDw7xZbrHt6Wb1DMZbvLbXmxKjIgmzKqen/CVYQmVyroDbNyVoPNl79U6OdlJ+Wjk8aZpuJBfSQEorwlPVVrjhJ7IIwhoVSvIfRJegTQ9Ghz2Qu9+5LBATM93BeGkfxKriqmD3qqptMEecyox1Dcuseo7Pq0EXwm3x5Fg/EyD5UDlQq8t98GktSe5MA2/Wlsjf0585ntR2NDd9Ha/Pf855mnxM0vzg8FVHN1RoVTNoOD0xnroiCiL+/a1MY4FIGRLx74FLMskIYINU0Ix0yO6M1Md4QbdjZ9VKZYzUkcswrLABYn50ZnG/YdetTREM/wnmaTOIaAb5IgJxeygYLvX+2LWFU4V46v3MDEQ6wOPnd6XCI4sv+QFAKjhOdW0CQxpjhgVoxq3XwguIS8xmwrLzH2TQcEV4xlgmFftrTp1OQdUgtZw9FvQnUf6cmeYjBShCFhL4NvCaRo+kjR974C9ff+ZoOCerSMsVDLrkU55btmak9o934Nt+YmgvUEEyP73qbFVaLXN8M5T9w0R3mK1fSdXSWkdgLdMjX/djLXJXfdrYfsrEBaMa0hIS/HKHwsDQvUUMs2v1skBzDy4snxwS8ojdOedj8KDU0hAqH6QLlREaRqO3mN1EbN1YNVSoy6jZuawVHDYdddNvIqwNGBhjnM3N6VsUH39/BGqCPD0PSdiiFTGzZX21me0+STS1Wac9sUHJRwdY6Atd9tBkymcoOOuz3pMv1b1DJDAB8gyQ/yBIuqiIX4h67Q/iPzei2yHxmRyTC7p1eaGdj5sfYQmzoN25/HLeRRUJiCpMoKqlt1c1/CARdCeY6XN7XRyMoOJkTPyz0h6nRJyoFD05v2fmQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e1638b-85db-4307-b8b5-08db6194ab30
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 05:05:35.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJizBAMevgLEYABtOzd7MMQ/ZYP9YirBRq9GBTQtnuuCvQgyDl1E+Vp874lzjXdF6xymSCVdR1g5MQzRiE8w1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8525
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+aW50IHVmc2hjZF9tZW1vcnlfYWxsb2Moc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gPg0KPiA+
ICAgICAgIC8qDQo+ID4gICAgICAgICogQWxsb2NhdGUgbWVtb3J5IGZvciBVVFAgVHJhbnNmZXIg
ZGVzY3JpcHRvcnMNCj4gPi0gICAgICAgKiBVRlNIQ0kgcmVxdWlyZXMgMTAyNCBieXRlIGFsaWdu
bWVudCBvZiBVVFJEDQo+ID4rICAgICAgICogVUZTSENJIHJlcXVpcmVzIDFLQiBhbGlnbm1lbnQg
b2YgVVRSRA0KPiA+ICAgICAgICAqLw0KPiA+ICAgICAgIHV0cmRsX3NpemUgPSAoc2l6ZW9mKHN0
cnVjdCB1dHBfdHJhbnNmZXJfcmVxX2Rlc2MpICogaGJhLT5udXRycyk7DQo+ID4gICAgICAgaGJh
LT51dHJkbF9iYXNlX2FkZHIgPSBkbWFtX2FsbG9jX2NvaGVyZW50KGhiYS0+ZGV2LCBAQCAtMzc3
Myw3DQo+ID4rMzc3Myw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX21lbW9yeV9hbGxvYyhzdHJ1Y3Qg
dWZzX2hiYSAqaGJhKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmaGJhLT51dHJkbF9kbWFfYWRkciwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgaWYg
KCFoYmEtPnV0cmRsX2Jhc2VfYWRkciB8fA0KPiA+LSAgICAgICAgICBXQVJOX09OKGhiYS0+dXRy
ZGxfZG1hX2FkZHIgJiAoMTAyNCAtIDEpKSkgew0KPiA+KyAgICAgICAgICBXQVJOX09OKGhiYS0+
dXRyZGxfZG1hX2FkZHIgJiAoU1pfMUsgLSAxKSkpIHsNCj4gDQo+IEhvdyBhYm91dCBjaGFuZ2lu
ZyB0aGUgVVRNUkQgcGFydCBpbnNpZGUgdWZzaGNkX21lbW9yeV9hbGxvYygpIGFzIHdlbGw/DQpP
b3BzIC0gbWlzc2VkIHRoYXQuDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEJlc3QgUmVnYXJkcywN
Cj4gS2Vvc2VvbmcNCg==
