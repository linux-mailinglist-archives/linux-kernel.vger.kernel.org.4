Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D2E727936
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjFHHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjFHHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:52:55 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF062128
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686210774; x=1717746774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rI8dHRmx5ejybi8nbMSyTqNMNf7FLZE1JR3oGTRnSy0=;
  b=ofgsucGQIx8fHQUMedfki+dE0PBV0xBkwf9UPs6oUD7yFPV/+mjPppvx
   fb5XpN47mNrNloK8sOCgy0oEKe58a6XDpbl1L40zX8pOH82BlVK2aEj75
   9HTLgr8ch+orNiAoeyw40LOIw5JW6pNohyGDA8syhWPC/RDwQib9qUKo+
   M7E182hVDWxgJvf64/mJg9KlSv9YnF99jjk3xDkQTJ6jLy2JaYUJsmP6x
   apNiu7noEbfW2ZB9lLOO7l7sJ4IlYepcNZNRaHeo7aCABLDO62DLr2UpK
   MoR6+oqcb8yL5b8noJHq4DlZEoZG+nlW7bVHwx8FdAuSMYyXLVvpjcg1B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="94383999"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; 
   d="scan'208";a="94383999"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 16:52:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFMgey3svAvil+nrjNqhdd0p0uniIvJkDktZhFLbgMRuFB5sDuU4too6W/PwJRI0ZK23rjTLTI3xZTZxn6lLISaWvzfGF0Ml5paCm0s+SZtlVwCLRU5uo4KjhdDkouELdilSkCN4XyluqPAcUWZPwY/8wV51lPOBxkXQIWZ+JvGH13X7GlipZdVjE4hmgACKk2bH7ZeHl8HDK+r/r3EDZxoDFgAgzfPCN3ETwN4WUR1lBLdjo/BP1lAFfXyEPlST3QxvQgZxlfI+1p2ralK1nr30A8W4kL3Yg2X0DMfG1yrEAstgMJze1BkQlxi5zflCaVZxbVd/Y3kC1IbtuxEHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpBlx7Kch5Aq6dRerOJICf4r9uo0SeUlpL0xQAyjQ70=;
 b=gzd38ro7Q0x8Z/c/mCPcdfYQIA49kjFE9dZrI7pQdY8VC6psXhxnIKf+lvm7HKSGapJekl8mdKg2RjscAIdwGyzm7NxssJul8NfCxpTxr8O/nOTURMskAwcwNHrZIL2XCvZv+WbmbnT2jd+E3yk7nAxJTtPF2QorNIioEloo3FZrJ4cKEdwjvRwVmuEdR/BXIRTj2UNSeOtHSMS/quByr0UhTzT5sFgrm3Ue8DG2udVzt8/SKuSfFtSmUWhdWeQS8fL0KMxi6M837rCF75DadFB0eItOV+822hB49zXh+TdRHwxoYhF1JCsVHGLfi0oM5OElz6AcUbuvNyKNfT9tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYWPR01MB10488.jpnprd01.prod.outlook.com (2603:1096:400:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 07:52:42 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:52:43 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>
Subject: RE: [PATCH v4 02/24] x86/resctrl: Access per-rmid structures by index
Thread-Topic: [PATCH v4 02/24] x86/resctrl: Access per-rmid structures by
 index
Thread-Index: AQHZjzMZC0okdWU3lESiSZ3crkg8s6+Am77g
Date:   Thu, 8 Jun 2023 07:52:43 +0000
Message-ID: <TYAPR01MB6330514612396E190106A8CF8B50A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-3-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-3-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-08T07:44:36Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=800fdf5a-cc1b-491d-8686-9d3c793ca3e2;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 50771628366e4c91a2912bcb223866c3
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYWPR01MB10488:EE_
x-ms-office365-filtering-correlation-id: 981a1dff-2e93-4786-2d6c-08db67f55767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkDN3vM6NGdauLNRN/7q9eTAHcrszDaW/h0o/IZaIWLwE5H5R7iO3xEwH4AjPhr2ZQjhPcCMeV61LRDW/UzkksSnowZJBUk/3sVWywB/RnFqYhTPwF0BrnFjJVay3Urr7iwzibnKpCz4QD6uXofzM7DHIy0KqcCrUtz6B/0jtGKvv2KQyP8NVkkH9ibmFIWhxM/rsE7flIiw7nmePfWmGnuYTVTvN/OPln04x7DTwv6cWfHWiIBFs1ydIlyk1MzFaD8UACEz+6taSn1s86GZX+UlNhB4uI0wCRoxdbHq7zinfpW24srM2LXGtL7QuJ91PR4OxLOHv6mtHA2bUiflHSh6RnXsmJTx6vVNcFayps/rxhxcL0qFJB4pNhFdmmKiCXSCecPbC+gLqXDKS9Bvbonl3ec+pnZ+w8acoiE1SjuE2f0iPLCYwr2d0khkpORR4TsEZQA+OTfRp+DDaDHN82TKQ1Xa7Lv99+9UcmD5VzQDAocs8KyLwz9fk2J+8/G5oEXVLFPR2QJ8F9QVSzESDbtgk9nmmQCy7Wtx57rcx6YB7ZYvlxIKu9buLRxNtaTNksMs7SQI797Yu7weH6IJC4Sgv00y4Eg1L3h2F1/hBE6APwI6hdLfua2vDD+zxFDEsQuwYL3kXl8Cr7G5RbCpJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(1590799018)(451199021)(110136005)(54906003)(2906002)(1580799015)(478600001)(66446008)(8676002)(8936002)(5660300002)(7416002)(52536014)(4326008)(85182001)(38070700005)(33656002)(86362001)(76116006)(66556008)(66476007)(122000001)(316002)(66946007)(71200400001)(64756008)(82960400001)(55016003)(38100700002)(83380400001)(41300700001)(6506007)(26005)(9686003)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OHhxdGJ2S2hNVmNvVVNzNklCUU5Ob3RQNHZPZWQyalFtWURaNURQWFFY?=
 =?iso-2022-jp?B?eTl0VnZ2eWl1SndORzlnMzA3UTNmaVhiZllodWJNbEMzK2NQU2djeDhU?=
 =?iso-2022-jp?B?ZUE4blBlMFJRMkEvM2JOQlpJK2xUZXFkb3c4VGsvS2RsMkZWS29rTEh4?=
 =?iso-2022-jp?B?bDRvUytlNkw3aUlwK1YzbFVjbGtGblB6QUR2WEZFaGJRcmlhTWJYVnpR?=
 =?iso-2022-jp?B?eDgvN1VsOVBLcHRFL25acEZxSStZcU5JSDVJd0pXMzIvWUJqUlNPMmlY?=
 =?iso-2022-jp?B?dmZLMVVYT2Nxb2tpT0lqK0U0Mm40UkJINk1HVFZMVElWbTFKOHRtcm42?=
 =?iso-2022-jp?B?NHRwMWUxQklhenJQSjVxRUp2MUw3UGhBTThKMG5pS3haaUUydzZ3dU01?=
 =?iso-2022-jp?B?aDlVZTBLZlBnckFCM21HbnNYMkNzWGdtbHlON3FTOWNqNS9PUEpidktK?=
 =?iso-2022-jp?B?anZVRS9qSmNoYkxPSjc2ekNMU1JlbW5aUWxGanBhVjl3aXQ5bTFOclVT?=
 =?iso-2022-jp?B?VklMazYzOUVLSjJKemZ5cDJ6b0FlNmhPSHlDUWZWZ1N1UHQwMG1TNWNh?=
 =?iso-2022-jp?B?RU9hUlJLWEkrU2ZPeDVjMXpuaEtrcitWV3VOU091bDF3d3ZtSmx0VWZw?=
 =?iso-2022-jp?B?RU9mRXBzU0JnMTRDZzMxTHFXUzhITEJreFB0SFBiaDNaQlFBbDhpUzhG?=
 =?iso-2022-jp?B?bGV1UzdXclcwaEpIRjVoM3dwTExnaGhaUXpTUDRSWnNyQlNMbmVtNFYv?=
 =?iso-2022-jp?B?YVIvTXpTSzhYcCs3SE52MmdvSzRsTmtmc1ZNdEtsa05UMUt5VmtPeEQr?=
 =?iso-2022-jp?B?UlFTcVlONzFOMVZRN2xUdmk3T2oveDlsUE9JbmRNREFyZVdYKy9QcHVn?=
 =?iso-2022-jp?B?bk1lSlBCSXJUanAvVUFnRFVuRS8ybS9sMEhZcmFxU3ZnWkpUdVJFeXVk?=
 =?iso-2022-jp?B?MlFlL3lpU1h1RXFoUVlhdEtKZWxOdW9peEEyYmUwYnZzUERQOE85RytM?=
 =?iso-2022-jp?B?YmFqT1pkb3VFM0IxQm0rS3lMS2l0TnNmMEZxMmpydXZTZTUwK2xNeHJC?=
 =?iso-2022-jp?B?R1lVbHpkV0tKUW5MMjMxeVIzT1RORC8zT2Jid1VSVlRNVEJPeTRuY2lG?=
 =?iso-2022-jp?B?R1RseStTTFBOWHQ4c0ZJSktqTUdyVGJzWmJUU0xnbzZnQjg3S2Vvb0pz?=
 =?iso-2022-jp?B?M1NNbW80OUxIRldzK0JWLyt5cWZnemdKdkloYjVPOUtMM3RSOVNJcGl2?=
 =?iso-2022-jp?B?WlpiREkyUUdnZjVZdHZjQzkzVG5tOW1jZUtnQkRzYXpWVGo4QWtudjNU?=
 =?iso-2022-jp?B?bW1ITnBVRStiT29SR0FBbGdjYmxmcUdxUlFCazkxR3BUSWJ4UXFWVVcz?=
 =?iso-2022-jp?B?UFE1bVFvcGhyNzFwSURsYVptNE5rcUFEY3laRXdCdld1YjE0MXBpd3lC?=
 =?iso-2022-jp?B?MnBqTlcrcGptajBrNUIvMTRVbEE3VHU2UkFyQ2IxbWg1YW9EeWliN2ZL?=
 =?iso-2022-jp?B?dFBXY0t1S09uSnF6WnllR2kyVmdBT3NndnF3Q2dGQXFKNmlRaUNGUWNB?=
 =?iso-2022-jp?B?aWtrK0g0SWhsOGtJMXlpdVFVNFNvbDZCYkVGbk1mVGlnNnlDVTNhbzM3?=
 =?iso-2022-jp?B?Yjh4VlZWbTF0T1lQeWNNaE1WczhjYlIvRVkzaVlHS2EzNXU2QmJ1K0ZT?=
 =?iso-2022-jp?B?K2liakJEK01iS0x4d2dCTm5Lem01SHVoeXR0czZ2M1UvT081bDhpRGNQ?=
 =?iso-2022-jp?B?UTd1N29wQkoremM1Vzd1bk9xbTZtc2RTOWdRRUZvZnlyNkw4UUwrUzBw?=
 =?iso-2022-jp?B?NmhJa3NnUnh4NDY5dTNseHFUUHpNZW9Za3BRaDl2dXI2UUIrQ3R4cUhO?=
 =?iso-2022-jp?B?eUxSTFhrL0x6dExMZWFra0tZV004WnZCWitPbnBNM3NyRXdLU0lUVmw0?=
 =?iso-2022-jp?B?Z1J5YktjaUNaZDhmSU1lcGM4c0ZqZUF0MnAwVWx3TDJjL010TjZpZXdl?=
 =?iso-2022-jp?B?akpubnVjbjFwYTRnYWFvV20zazJyeWlWWW52RkZkQTN6L3pvVzNHTU1U?=
 =?iso-2022-jp?B?QVJEZXpiOXRTcUI4VXZjSm5Ra0dkQkNTdkdVVVlmbzd5b3J4cktzUlMx?=
 =?iso-2022-jp?B?dzdLNXE0cUloRUZtVXp0WDNoSU54Z3pxVU5QQndBSFZwT2dieUtNanFG?=
 =?iso-2022-jp?B?SlFuRlVXSVFKSVUrS1lGbnVsR0RtOU9YclA4a3dlWU1XdndGZzF0QWhO?=
 =?iso-2022-jp?B?VTkwa1lobWxRcFlXQ2dWV2xINmVwRTBrTEpZRVJiU29SbnlrQTFidm1W?=
 =?iso-2022-jp?B?dHN6dUt4bVpDOURKV3Z2Q0dBZHUzN0FVbGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?YmR3NEJxMjFmakRrRHZzT29rbXdLQ2I3eUtFZ3o3ZnJxbWVsdS82S3Yz?=
 =?iso-2022-jp?B?SXVjZmcvdW1wYXR5MUl0YWw2cldzSEJKemQyeS9Vc0grblFUVDdPWWxk?=
 =?iso-2022-jp?B?cHRHVGhtd3psQUJSaTVHb2liTi92ZXVZMHUzeE5yWkg5ZXVyRFlRVVcr?=
 =?iso-2022-jp?B?MndveHFXSTdhSm54cDlxOFBmTUFTUXpDa1BGWCtoaFFUZ0xmYW5tVDYy?=
 =?iso-2022-jp?B?cUZvbUFzSE1seCtTMURpZzBFTHNjcFN6b3o1ZjM1UGxjSE83QzkxRDFO?=
 =?iso-2022-jp?B?bVdVZU5iK1IwM25KbkJLUFRCaVJwdVBJMG50TjhsRkdTdVFNR3RXYW9t?=
 =?iso-2022-jp?B?bCtvV0c1SUFScWM2UlFTYXF6QlEvYmI1dTlXcXprOXJlckdBWURnaXhs?=
 =?iso-2022-jp?B?cE41SjJyRWhoeGJENVV5MmxIME9XTkxneTc2OTMzOWttQWthb0hoTTlC?=
 =?iso-2022-jp?B?dHJ0YzVqVHVTeHZ0K3FCRUhLdjlhUHdDNkF5cnU2cjNxL0s4d1hFQk5p?=
 =?iso-2022-jp?B?eXIrWmNTaXFDb0ovZE9pRUQ5QzF4OEV2eW9YQ1d0QW5wcWJBdjVUMHlz?=
 =?iso-2022-jp?B?TUlYV2Vjc09kNm9IeWovaXVONDVIQTdPTkgvS3VNK2NKRnJPSmhETlll?=
 =?iso-2022-jp?B?eWNFN0k2WEdIMi9hZjBmTGdHQk1jakduN3ZIeXNlTkFBZEtiV0g1UmdB?=
 =?iso-2022-jp?B?NzJncy9DZ2dlbnNsU0VpWmZ3VDVjN0J0RzhUTGlsSmlhTFJIZ0Y0dE9y?=
 =?iso-2022-jp?B?YWVVN1ZqRlg5c215anRZQ01YK2VzakN2Z1lUN011aGhFVFRuK1M5T1RC?=
 =?iso-2022-jp?B?VFpNVWNZYzZJZ0g2STBQam5SWWZWT2plcEJ2cUhobFlPTnVSYlViaEhN?=
 =?iso-2022-jp?B?bllOQjh4QUlQdS9CYjVqUDFpcjFoUFkvYkgrYmw0enE5eWc4aHNCcWc4?=
 =?iso-2022-jp?B?b0hTaU5DTnVSS0p3eEpQekNYcXVQR1ZGTDVPUFhLMHRpRzVPUnlpbWJU?=
 =?iso-2022-jp?B?S0tLZUlaZDdOU3g2ZVB2b0FGSHpsNUtOVTNJa0xSekthWURJK0RSUUNY?=
 =?iso-2022-jp?B?azBSTngwelF1RlZjenhaYzQvdXEwdE5idmNOR3lRYkcrdVZrb3JhTnhy?=
 =?iso-2022-jp?B?bUpRaTFqWFB3M05DbWltbnEwMFpMMklwbTV6cDNlT1FML3lJS3Bidy9k?=
 =?iso-2022-jp?B?ZHlGdDF4MzZJRmhaUnQ2d1FZd0ZCZlFVYlRGMm1TczhsQVN0M0hCWTlK?=
 =?iso-2022-jp?B?bnVFd3ViUVVPRXZZQ0RzSDVVREozcmZWcEduTnZqSlpranduUEh6azI2?=
 =?iso-2022-jp?B?dm5oNHVSdGU3dGJVT0d0TDBHQVU5UUhib1N2NEVFV3Y0THNKNGpvaiti?=
 =?iso-2022-jp?B?ZjZBMWphZDkxTHhxOWVTVFE2aE94T0tHeVZVc1hrZlp3UzVnSW5rSGQz?=
 =?iso-2022-jp?B?bFJ5bUZ4b0JjNzgzb0VXUW9CaWZlOVR1MTNhbHA0Z1dwYmlRaG5wRUJq?=
 =?iso-2022-jp?B?Tjc1YmY0ZThKRklkWnFiakpUVkJ3Ujd2K205UkZCd2dZSjRKSlVQUHlY?=
 =?iso-2022-jp?B?M2xTQnNNdkFXRFliUnRCZnBuNDRlbWZuazhpYTdaaDNIWnZ4OXJrR3FU?=
 =?iso-2022-jp?B?MWZ1RXk5bkUxNTBmWXRnUTVXTzJndkVZV3p2Qkl3TGJJZjRxaldrQndE?=
 =?iso-2022-jp?B?Ui9qZ0xIT0RjdVphNU1OdU55MXEwVTdSQzVhQk5ERjh6Q3dtVWNrTnlW?=
 =?iso-2022-jp?B?VlhBWVl4eTh2UjVxNnhibjN2ZVFXOXMzemdxaThFRkRkNUUvSXN5TVpF?=
 =?iso-2022-jp?B?WXlOL0p3dm1FTFdDV2NCMFNoMktrb0l5SXAyVWN0MjAzaDNOai82M1hK?=
 =?iso-2022-jp?B?dUExaDVXM1haOTU0MVlGUGJFRDM0PQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981a1dff-2e93-4786-2d6c-08db67f55767
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:52:43.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTUSznk9h9TWS9RmcLEsmPXXu71Gi0wygEhWeVHyqiAZNZntsQvlZf9yUz6Y3RcSpZ2KSLQ2G34crkaBAs+JG4IoAqxcOaLGg61yXgyMLC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10488
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is also
> included. Bitmaps like rmid_busy_llc need to be sized by the number of un=
ique
> entries for this resource.
>=20
> Add helpers to encode/decode the CLOSID and RMID to an index. The
> domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as are th=
e
> domain mbm_local and mbm_total arrays.
> On x86, the index is always just the RMID, so all these structures remain=
 the
> same size.
>=20
> The index gives resctrl a unique value it can use to store monitor values=
, and
> allows MPAM to decode the CLOSID when reading the hardware counters.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
>=20
> Changes since v2:
>  * Added RESCTRL_RESERVED_CLOSID
>  * Removed a newline
>  * Repharsed some comments
>  * Renamed a variable 'ignore'd
>  * Moved X86_RESCTRL_BAD_CLOSID to a previous patch
>=20
> Changes since v3:
>  * Changed a variable name
>  * Fixed various typos
> ---
>  arch/x86/include/asm/resctrl.h         | 17 ++++++
>  arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
> arch/x86/kernel/cpu/resctrl/monitor.c  | 84
> +++++++++++++++++---------
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
>  include/linux/resctrl.h                |  3 +
>  6 files changed, 83 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index e906070285fb..dd9b638d43c8 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -101,6 +101,23 @@ static inline void resctrl_sched_in(struct task_stru=
ct
> *tsk)
>  		__resctrl_sched_in(tsk);
>  }
>=20
> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	/* RMID are independent numbers for x86. num_rmid_idx =3D=3D
> num_rmid */
> +	return boot_cpu_data.x86_cache_max_rmid + 1; }
> +
> +static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid,
> +u32 *rmid) {
> +	*rmid =3D idx;
> +	*closid =3D X86_RESCTRL_BAD_CLOSID;
> +}
> +
> +static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid) {
> +	return rmid;
> +}
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>=20
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..4bea032d072e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -600,7 +600,7 @@ static void clear_closid_rmid(int cpu)
>  	state->default_rmid =3D 0;
>  	state->cur_closid =3D 0;
>  	state->cur_rmid =3D 0;
> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +	wrmsr(MSR_IA32_PQR_ASSOC, 0, RESCTRL_RESERVED_CLOSID);
>  }
>=20
>  static int resctrl_online_cpu(unsigned int cpu) diff --git
> a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index f2da908bb079..d571da4848a4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <asm/resctrl.h>
>=20
>  #define L3_QOS_CDP_ENABLE		0x01ULL
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 86574adedd64..bcc25f5339c0 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -142,12 +142,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid,
> unsigned long val)
>  	return val;
>  }
>=20
> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are an independent number, there is only one source of
> +traffic
> + * with an RMID value of '1'.
> + * arm64's PMG extend the PARTID/CLOSID space, there are multiple
> +sources of
> + * traffic with a PMG value of '1', one for each CLOSID, meaning the
> +RMID
> + * value is no longer unique.
> + * To account for this, resctrl uses an index. On x86 this is just the
> +RMID,
> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> + *
> + * The domain's rmid_busy_llc and rmid_ptrs are sized by index. The
> +arch code
> + * must accept an attempt to read every index.
> + */
> +static inline struct rmid_entry *__rmid_entry(u32 idx)
>  {
>  	struct rmid_entry *entry;
> +	u32 closid, rmid;
>=20
> -	entry =3D &rmid_ptrs[rmid];
> -	WARN_ON(entry->rmid !=3D rmid);
> +	entry =3D &rmid_ptrs[idx];
> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> +
> +	WARN_ON_ONCE(entry->closid !=3D closid);
> +	WARN_ON_ONCE(entry->rmid !=3D rmid);
>=20
>  	return entry;
>  }
> @@ -277,8 +294,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, st=
ruct
> rdt_domain *d,  void __check_limbo(struct rdt_domain *d, bool force_free)=
  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
> -	u32 crmid =3D 1, nrmid;
> +	u32 idx, cur_idx =3D 1;
>  	bool rmid_dirty;
>  	u64 val =3D 0;
>=20
> @@ -289,12 +307,11 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  	 * RMID and move it to the free list when the counter reaches 0.
>  	 */
>  	for (;;) {
> -		nrmid =3D find_next_bit(d->rmid_busy_llc, r->num_rmid,
> crmid);
> -		if (nrmid >=3D r->num_rmid)
> +		idx =3D find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> +		if (idx >=3D idx_limit)
>  			break;
>=20
> -		entry =3D __rmid_entry(X86_RESCTRL_BAD_CLOSID, nrmid);//
> temporary
> -
> +		entry =3D __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>  					   QOS_L3_OCCUP_EVENT_ID,
> &val)) {
>  			rmid_dirty =3D true;
> @@ -303,19 +320,21 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  		}
>=20
>  		if (force_free || !rmid_dirty) {
> -			clear_bit(entry->rmid, d->rmid_busy_llc);
> +			clear_bit(idx, d->rmid_busy_llc);
>  			if (!--entry->busy) {
>  				rmid_limbo_count--;
>  				list_add_tail(&entry->list, &rmid_free_lru);
>  			}
>  		}
> -		crmid =3D nrmid + 1;
> +		cur_idx =3D idx + 1;
>  	}
>  }
>=20
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)  {
> -	return find_first_bit(d->rmid_busy_llc, r->num_rmid) !=3D
> r->num_rmid;
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
> +
> +	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;
>  }

"struct rdt_resource *r" is not used in this function.


Best regards,
Shaopeng TAN

