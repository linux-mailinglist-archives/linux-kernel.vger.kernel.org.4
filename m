Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FD721EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjFEHIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFEHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:08:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3797E54;
        Mon,  5 Jun 2023 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685948855; x=1717484855;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RmPqBMTGnDxp5yVp5nbvx+lacuWw6nTQUv7QyXCETlE=;
  b=a/UBBY8zGdHF1oazYlXBiv7bSW1SWsNOyUo0eTae9LGS/yMUkF13cQY+
   pRjMdXoXwXLdNosX9b13nVl4oODhWqx8yvrYLfX5l1FezsHJYs169LehO
   b6M2Se8mijbnppSrB2WHp7484knWd6hJTMTMM53TtSbinCra5sz24bs3o
   QFluchoGCHJhRVno9ZOSvXhQlsC+ysslLNmNf9t2cHZktqKYs+S5/XadS
   v1bZFtEiFIyxY5z7YSuzX8tRwDEDT/tnDQvbemJPQfFnOM9tcSnAv9a6t
   KbkUe1Td9NjwKklQn4K717dVUiU0mqEkwDpwfVUQV7xI1+KuEk/r8Lwtu
   w==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="230626558"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 15:06:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtGOmG7VroQkc8PeW5msiwBLRINE41Q7ROSus0abgplIjS9EiRdPRiK4mc1xS2M1YrbfD6s3CWUymgHkw6R4lYX3uRSbK9QOwbYsvihBcFNHBbFBrhIHFBFC0srllGAJWc6AjzeHHSgVKAi2AopUSsCw2llkU5RRe2C7MzJIYV/guomdZPS4nneRdQZ7ZkBXH8W2rfURmSYt8Vy5v536igdloWaVZYp6Ah5xKY2mdXRlLftAgRaXrdnZV7xUWp6DXf9yXMXOh33SL+WLyPCqThRRhjm5H5dRJJ1yi3W6yZpGDEXtFXB8fM7uAVHWZgovInZsug8rJqtIdozZ6anlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmPqBMTGnDxp5yVp5nbvx+lacuWw6nTQUv7QyXCETlE=;
 b=f7epO+m2xcfNzni0i/3VrBqt8fGeqJNBV/gUZr+HJWJzIvvGsgQCaJVYvjmRSUs0Z2wDS2q4BXjAnrEJSpqKpbdy3u1Ls+gOtmRGYbDPQ4/2UxKvdKKQCG20yEly8+XSw8TX4WD3ybFROK3fx2/Rir1RVj9yTP1cwoVZtFY+U8FvxO4TxWvn5IZR3zt51Yb2Xis0UGnF917KpAkO0zdvHxC8FNGCjj6w2+/PAQkcKh5SGDbaMGWv0KSGhfrdkRZTSOhy5uhsI/0H1MMI5LPjrZe+YK6wkLutv0e25C8Ijt8kOD/xacLoEomMlQLhoJ4X5e/x0+blDei5fzMo60EWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmPqBMTGnDxp5yVp5nbvx+lacuWw6nTQUv7QyXCETlE=;
 b=A2kjWr7Bw6AKZOCc3NJoD9zC1TacVf+aa3402eBTofRCVb22ClADacQQKVwPeEmRCDaJwBzek/wziCIymo3+Nzxe5SS+WCbfY3kUDVt42YEgkH9GUFrDM/2lWbp+ipECl1LoDQPzBwZTT7X6m79cNxKyrw7nFrvlUYI9bcV69NA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6441.namprd04.prod.outlook.com (2603:10b6:5:1ea::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 07:05:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ede1:ce1f:d515:7650]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ede1:ce1f:d515:7650%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 07:05:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "sc.suh@samsung.com" <sc.suh@samsung.com>,
        "hy50.seo@samsung.com" <hy50.seo@samsung.com>,
        "sh425.lee@samsung.com" <sh425.lee@samsung.com>,
        "kwangwon.min@samsung.com" <kwangwon.min@samsung.com>,
        "junwoo80.lee@samsung.com" <junwoo80.lee@samsung.com>
Subject: RE: [PATCH v2 2/3] ufs: poll HCS.UCRDY before issuing a UIC command
Thread-Topic: [PATCH v2 2/3] ufs: poll HCS.UCRDY before issuing a UIC command
Thread-Index: AQHZl0yXoNPQjQvB7kGw5VVsHthT6a97yKiA
Date:   Mon, 5 Jun 2023 07:05:58 +0000
Message-ID: <DM6PR04MB6575F26AC01FD6C9D4D5ED3DFC4DA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1685927620.git.kwmad.kim@samsung.com>
        <CGME20230605012507epcas2p3ecc0a358b558fe09d74a56b67b6477d2@epcas2p3.samsung.com>
 <40006660eaece22f76b9532c70479d719655b33f.1685927620.git.kwmad.kim@samsung.com>
In-Reply-To: <40006660eaece22f76b9532c70479d719655b33f.1685927620.git.kwmad.kim@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6441:EE_
x-ms-office365-filtering-correlation-id: 787ba9cc-bed6-4f5b-a874-08db6593509d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7d7XRxh96nSUdZ8MeSLsXSLfdOfdsJ7Gf1DaZ8uf3mxYIKsyewS1CG7vXi2jWhJ/dtxkxe/VaOPsfNvrHxc3PeIdNgeCiqF1OgLGPNIbQaP/IXpf3d0B9+pU0CruQQY8pF925JLmoEt6BD9ywEb7CK1n57uJPIEjHwiolmnDyxde2D2/t7J6x992ucuNKGHevYTSITbrIHHDB6tLL9NBXtCSmxmLYBt2nDSVjtabn6VIVRFVYvYs8t/vk6vfj8Mm7uB5lcjsylTR/a2FKVuRhnFQ31zkjbRrGAyAQjgix4FjNkcbb5pdZFKXDdT0qjBjmptIOKppBxutilz7p2s9jxq3Hr5iFagGFrx/gL2msDaxUHPtnBE7EyULZjJ+faRCwnqYIPAmHLMTfU70n6SpmEkeWwhC3SbjQk880sdG8g/fTQ5zphIVHXuz97HjnUGrYhSNqb+y/BpBJsn73LwAxHYNkseq0+bvkUsN9Akxf4ZjT13LO2Jq46wabdt/2jIUNxmxsTvOM8mc6rUJlnt0iZEsc139Gek2Z0rU5fRMq+OG8cxeMILKkNxJUN+3tJ6HNdgmQwWCxEEd2SgSTsXgdlxOjwimlx55lyhDPpVKDp76kj+bHIrv1/5Et9vOcqL5mWb4SHDtkoSXU9zjZLoUIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(9686003)(6506007)(26005)(83380400001)(186003)(921005)(82960400001)(2906002)(66446008)(64756008)(66476007)(76116006)(122000001)(66946007)(66556008)(7696005)(71200400001)(38100700002)(52536014)(7416002)(86362001)(38070700005)(8936002)(5660300002)(110136005)(8676002)(55016003)(478600001)(41300700001)(33656002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWUwQnptTTVaaUphZmI1eFcwWFhZenVFelFiMUdrc0RobTJERGNxTVZkdFNa?=
 =?utf-8?B?cEpRRFVmQlJreVJnWVNtb1VNaytLQ2dnVXNtT1RqYjc0WmxublV0S253d2xm?=
 =?utf-8?B?SnlIb3pmeFZ4dlpiWDcxMmJ6N0FaOXFqSXZIb2NybnI1ZXgzSzN4djk1V1BQ?=
 =?utf-8?B?QzUyb3pJMmhmL2ViZHZxb3M3TFNDNkZTajAxYzlPOHEwS0g5VXdvZlgwNG91?=
 =?utf-8?B?Unh6L1JEMXlDdE8xRm9oMWhuTlBveTBHOERmYlJObDBXdVVieUNvc0g3NldP?=
 =?utf-8?B?SnNXdEFva1dKcWt5cnY1T2tseDkrUTEzSWVGcW9GZmRZNHZhc2d4dk9zVTkv?=
 =?utf-8?B?SGoyclJSQ3BBY0xEY0gxNDBrNnF6b2ZXSkR5aEJzVUh0a2E1ZWtoN01kS0Fj?=
 =?utf-8?B?bGpvSWdkV1pLRVJ6bU1hZEtGSnBSMExMalhJQlNHNHc4Z2tZa01TVDdSRmZI?=
 =?utf-8?B?Z0lrNlhxODJYYnpsdlBZRHZLSHdsc1l0UmJkdloyVWVKOWNkc0wrdUZqaG5O?=
 =?utf-8?B?VUtQQ01Gb0NiVFcxU1pvQ3gvY3g4bEgwNDRyUm1wUmppYU9hK0VVeXdvK1JU?=
 =?utf-8?B?cUFHdXBwS05jeFBjM2FTNzk2eHEzOHo2bTBuYUV0WitOdzZjMXpIa2ttc25a?=
 =?utf-8?B?T1lTK0s0SEhLUG5YOWJXRk5nOHBpSURma3ZrRWxBNm0rR1d4NVJmZGRPUjF2?=
 =?utf-8?B?eTBOSCsrdTVoaXp5Vjg2Z2JNWk1BU0lJdWpVSS9kY3Fnc2IvWnlqTys4NE5T?=
 =?utf-8?B?QUhaY2Q2NVBkUjlaZnVTeTVmQjdYK2FQOTRqMmhGK2MvOWxoVnk0Q2dLUlIr?=
 =?utf-8?B?aWJNSEprSFVBa25oZ0pnWjdMQUIvclZoY04weFJ6MFNqWUlUNitneVVFeE1t?=
 =?utf-8?B?WlArc0VNYjloZjRBYlQ5TWVjMDNWQkp3ZXFHU045aFR6SVYyTVl1d25UcUJC?=
 =?utf-8?B?V2d5MDg1RUovbzAvck5WbU5KR0NlbFFPUkYvL1VjR3NhZUxydHk0cjhKQTZa?=
 =?utf-8?B?andlZkR1ZDlsYitlSXZMekJyV3ZhSUM4WVFOVVByV0hwN01JUFZUY0t6V0Zz?=
 =?utf-8?B?RHIvelU1Q20zditoOGdnbExGanJGQk8xeXlCTlhEbGx2dVhDekxhczFXU0NV?=
 =?utf-8?B?UWVVbm1zQ2lUMU9leXUraThuTXlZajhkVHpNQ0l5UnBweml4TWN1RGVzc1B6?=
 =?utf-8?B?SjkyUEROWTZxZEEwaFRyS25CWGN2ZWZSWUVJYXhiNDJPZVpPT0V3RklJWjA0?=
 =?utf-8?B?TjZnYmRVWjZkTkVhbUl2ekorcFBVOEJkblh2SjBjRmhSSDRCS2xKZDk1Z1Bn?=
 =?utf-8?B?UWRDamV4T1hYSFhWamlaRTROQmVwaTAzU1BXNnllTXVpaFJ4TGZrMDlKUWtM?=
 =?utf-8?B?dXd4UTVtSUh4d3JQdkE3YTJ4c0RpTnZ3R01hMVMrNHRNTVZsdFlGazl3ektQ?=
 =?utf-8?B?QUdTZXU4aGlSL2hxdk9maGNwQVBvemJXbUVYbHRjUDJmSTczRFBRMmlsQ3Zm?=
 =?utf-8?B?MktTMHYwRnAwR2Zld3pVTGlmK0t5czB4cGFvbkdUajNON25HdTVVRGZRdFJY?=
 =?utf-8?B?M21aVjJuYm5RKzc2R2M4cllXblQzeWg3d3I2OXVzMGRER2k0aG1LS012bHFW?=
 =?utf-8?B?Njdwdml4Y2gyOUNHOHFDNWVVcjFUbGl5QjM1VUF4Q3RpdVc4RGUwampQY2Rx?=
 =?utf-8?B?SWhBUm9SekpSS0llM1Z0OFpJTTk5aE5ZVStrdzAyNW82TkorSTNXdWJpVkVu?=
 =?utf-8?B?eXhHd0k2S1JUT2owcTVwOXJvRUVjN1lmRFNVVEFUc20zVW9UUThwTXhsU2pS?=
 =?utf-8?B?ZG9DMDQreXhlV3REekRnTGQzZ0kyUktkQVdUWis3ZEY5S2xZRHI3MzFyQVY1?=
 =?utf-8?B?MXNoQTdNWis0cFdveGZ6Z1c0NFpQL0JKY1d1Z0V0VE1wdUVGTldTb2hheDZy?=
 =?utf-8?B?Y01yWjQzSUtEV3BWNExaaTJuc1l1SGxySUo1REdrSGQwQ0JVdm9nVGNyNlEy?=
 =?utf-8?B?YXRza0VqaldBL2JXYmhwNGZxRk5oamxvbVo1b3hnaHF6aTdDdnl3MW1Jc2Ew?=
 =?utf-8?B?SWVMMmorV2lmR3dldnFXRXpTQW1MRE5WNlJxWjY0RHJKT0J6WWtyWHhSWEk0?=
 =?utf-8?Q?Q6oMMdCmm841/jn05w96ZAUa7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b0ZiOVJOdWhJLzFjeUtGSkFObXF3VDZwUFUxUjhNZTZEOWtDZkJBQ2k4eGo2?=
 =?utf-8?B?ODdtVmFMdmtrMThsVXhlYzNJS1Bib01vM2pPWUFtaWhiNWxaYmIvc0kvK0ZM?=
 =?utf-8?B?ck5vOWgxM3EzMTFIRU9VdHkxNGJMT2pmSi9oZCtwTmJUVmNzSWpHclc3bjZE?=
 =?utf-8?B?U3JyOWpIR29FZHVaVHBnZ05sV2VQbVBnb3BvVVQrek94b1NYNVZhWWJQa3k2?=
 =?utf-8?B?OGY3cVFNLzN3QThDcXVra1MxMTdRaDZPNHZIQkw3cDdwN0VRM1FBY0VOeEJ2?=
 =?utf-8?B?c2VzUlhhQlJQVVc1d3hFK0RSMUZobWRLSmh4dC9zbnY5YjUyUXdMYXpTRlB0?=
 =?utf-8?B?WVY2M2toZTdxSllZb1JQd3h5VGkwK2hMcFNLU21rdng1Uk56Sk9VM1EyV0ow?=
 =?utf-8?B?T0ZONGd2MTMyWUZVNzc3dzNHRVdsLzRCR0p6SnV4VFA4cVpLdktrdUtWQkJi?=
 =?utf-8?B?LzB0Z3I3bUxjaEZIMW9Cdm5FRDd0OVNYQkdzd3hJTkJadmd6OGh0SzVaTlB0?=
 =?utf-8?B?T28vOFdWUGd4U2NMQk9kc1hMamYxMUN4UDZSYWJhVm9iNFIrVEdYWERVNk9z?=
 =?utf-8?B?bGJKbTUweWtvNk1qMVc5R0FoSEs4aGFxNWZuQkF4aWNPVXcvSGFRYWdxSmRz?=
 =?utf-8?B?WCtJZ21KK0JvR0N6QmNaNUs3STh0ZVVHSm4vK215Q2ZPRi9TemVtZFpacklt?=
 =?utf-8?B?MTlkczY4RE5kYzR0VENKK3JodHlRdXNmanArVXYzQWovSWNJd25nbEJxcm5u?=
 =?utf-8?B?TWFvM2MwTk0yWi9zZFVoWXJyV0tURFlHTWhtNTZXS3V5SFRPbHhpb1cwT2lY?=
 =?utf-8?B?Rk9kUUxNWkE5R1AvSUEzQVMrSStSYXRVRmJGaWJUZm5OcU9UbVJWTkVVTjhJ?=
 =?utf-8?B?M0crVFY2dTRMamc5WUtLRmpDREJHQ2RCaVJvQzhtWmQzcW1vSGRrV2grZFUx?=
 =?utf-8?B?eDBHaHVFM1JyVnhlQWNyb0lZWkdtdGlaR3I3ZW4yNjBCbjRDWmxYVXhLazhl?=
 =?utf-8?B?RXBsRVVOY1QrQ21xV25uQmNvcXhlZnEwYzR1OUZTN1VKN3IzM2o3dWRqRlVt?=
 =?utf-8?B?Ry9QQ1I5VnQwQTNtQ291b0QwSmFFcUsxOW5pODJzaEJwekhnemE5VG5ORytu?=
 =?utf-8?B?dFkrdFVlb2JtaUwycnUzY1BFVFpjQ0Z3WlRnYzh0TzMrNXMwb2g0WnBHYVdu?=
 =?utf-8?B?UUVwTlZYOGcvaEd3RXVFSDZCMW9aZnhzdnpMbndEVnc0bE52U21vU01kVzB5?=
 =?utf-8?B?VnhXMDc1Y0NLdjBhKzZMcjJ0NWFDeGsvejd5OHNHRm9EczBxZz09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787ba9cc-bed6-4f5b-a874-08db6593509d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 07:05:58.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7tgmoc+hij2Tq7IMotf5VZWSR8nBNvWpLyNtRelgvxo6vEQJ7QaT6N9gqUT8GUQZczn59GdmmDolrdqGn5uXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6441
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiB2MSAtPiB2MjogcmVwbGFjZSB1c2xlZXBfcmFuZ2Ugd2l0aCB1ZGVsYXkgYmVjYXVzZSBp
dCdzIGEgc2xlZXBhYmxlIHBlcmlvZC4NCj4gDQo+IFdpdGggYXV0byBoaWJlcm44IGVuYWJsZWQs
IFVJQyBjb3VsZCBiZSB3b3JraW5nIGZvciBhIHdoaWxlIHRvIHByb2Nlc3MgYQ0KPiBoaWJlcm44
IG9wZXJhdGlvbiBhbmQgSENJIHJlcG9ydHMgVUlDIG5vdCByZWFkeSBmb3IgYSBzaG9ydCB0ZXJt
IHRocm91Z2gNCj4gSENTLlVDUkRZLg0KPiBBbmQgVUZTIGRyaXZlciBjYW4ndCByZWNvZ25pemUg
dGhlIG9wZXJhdGlvbi4NCj4gVUZTSENJIHNwZWMgc3BlY2lmaWVzIFVDUkRZIGxpa2UgdGhpczoN
Cj4gd2hldGhlciB0aGUgaG9zdCBjb250cm9sbGVyIGlzIHJlYWR5IHRvIHByb2Nlc3MgVUlDIENP
TU1BTkQNCj4gDQo+IFRoZSAncmVhZHknIGNvdWxkIGJlIHNlZW4gYXMgbWFueSBkaWZmZXJlbnQg
bWVhbmluZ3MuIElmIHRoZSBtZWFuaW5nIGluY2x1ZGVzDQo+IG5vdCBwcm9jZXNzaW5nIGFueSBy
ZXF1ZXN0IGZyb20gSENJLCBwcm9jZXNzaW5nIGEgaGliZXJuOCBvcGVyYXRpb24gY2FuIGJlDQo+
ICdub3QgcmVhZHknLiBJbiB0aGlzIHNpdHVhdGlvbiwgdGhlIGRyaXZlciBuZWVkcyB0byB3YWl0
IHVudGlsIHRoZSBvcGVyYXRpb25zIGlzDQo+IGNvbXBsZXRlZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEtpd29vbmcgS2ltIDxrd21hZC5raW1Ac2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy91ZnMvY29yZS91ZnNoY2QuYyB8IDEzICsrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91ZnMvY29yZS91ZnNoY2QuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgaW5kZXgN
Cj4gYTg5ZDM5YS4uMWY1OGEyMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvY29yZS91ZnNo
Y2QuYw0KPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+IEBAIC0yMzY1LDcgKzIz
NjUsMTggQEAgc3RhdGljIGlubGluZSBpbnQgdWZzaGNkX2hiYV9jYXBhYmlsaXRpZXMoc3RydWN0
DQo+IHVmc19oYmEgKmhiYSkNCj4gICAqLw0KPiAgc3RhdGljIGlubGluZSBib29sIHVmc2hjZF9y
ZWFkeV9mb3JfdWljX2NtZChzdHJ1Y3QgdWZzX2hiYSAqaGJhKSAgew0KPiAtICAgICAgIHJldHVy
biB1ZnNoY2RfcmVhZGwoaGJhLCBSRUdfQ09OVFJPTExFUl9TVEFUVVMpICYNCj4gVUlDX0NPTU1B
TkRfUkVBRFk7DQo+ICsgICAgICAga3RpbWVfdCB0aW1lb3V0ID0ga3RpbWVfYWRkX21zKGt0aW1l
X2dldCgpLCBVSUNfQ01EX1RJTUVPVVQpOw0KPiArICAgICAgIHUzMiB2YWwgPSAwOw0KPiArDQo+
ICsgICAgICAgZG8gew0KPiArICAgICAgICAgICAgICAgdmFsID0gdWZzaGNkX3JlYWRsKGhiYSwg
UkVHX0NPTlRST0xMRVJfU1RBVFVTKSAmDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIFVJQ19D
T01NQU5EX1JFQURZOw0KPiArICAgICAgICAgICAgICAgaWYgKHZhbCkNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICB1ZGVsYXkoNTAwKTsNCj4gKyAg
ICAgICB9IHdoaWxlIChrdGltZV9iZWZvcmUoa3RpbWVfZ2V0KCksIHRpbWVvdXQpKTsNCj4gKw0K
PiArICAgICAgIHJldHVybiB2YWwgPyB0cnVlIDogZmFsc2U7DQo+ICB9DQpDYW4geW91IHVzZSBy
ZWFkX3BvbGxfdGltZW91dCgpIGluc3RlYWQ/DQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gIC8q
Kg0KPiAtLQ0KPiAyLjcuNA0KDQo=
