Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704F6F2F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjEAHyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEAHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:53:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4931B9;
        Mon,  1 May 2023 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682927637; x=1714463637;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iPrh+h3ieEEj/Kn4eNuhKvBtUF/6U4d13Vs5pMGXZkc=;
  b=qyvo9jVoZFDL24+cD8YMTRNjCnOELs1Kzwv4MNZsCiscPbxg6VGSKfWs
   rBgTa5IrM6FEfhFyufnUhA+zFr2OrKgsq6bQOzeU586No2jnoNbltZMFz
   DGJ7tGLCq6wDwI9C5S7EXUu5IvJmcSd8CH04icDe7mednUi62sx+Ez1J4
   BBBBGttUNa0u8KBKE6W2EMwVzKy6AXRwecn1Oc31GYzNkxXCaBKG8rzlY
   4OhYNPVm42qS56Sbv14aIcQH0k60EBKRzuzxQKDxG75jrgXtULesz69nS
   rwBS+sf2XrGAaHn/r5v/9O7BNBuB509RDkeoRYK15a77rIWUMAginv9im
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="229519959"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2023 15:53:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exu07B/eGjJFYqZaXRkM6K3GqHUNKMgsFWbgS4pDC49Sh8d+ZCPl0/g6sVyseeN/CtteD+IeqLXrQjkd40zLG2zjCnOLxJhiIzIgLNlhC/oZ1JlQlQCVoYBbR8obMroTxdwTOdbzZsu6Gmyv721CLYl8ApNTVoR4fUxEp2tfSoV722Yj92V/jXPdXAHC4vDlU8V2pe1vewl35Lmf3iDAKtOMSG5ibMf2t0VlMY+egEy5pQHZWJGtL73epYAsJtd6j+UlA+2NemW3l7UaowlQdrnzHkZXiPSfuTAS7mfrlm7JC3eZRd8DGBDTZ/XwZrwlGpsymTBt+sOa3AIuKTGCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPrh+h3ieEEj/Kn4eNuhKvBtUF/6U4d13Vs5pMGXZkc=;
 b=av1JKApB8fQ7NcoAO+Lt2j0R+Eyt3LuDBG23BK1PG5jK/5WM1MzcilhcsIvV98eG+NPlI1+N2yAt4HwsoDEt4G7mUqkurgL1sGq1Ex1og1hB3JGHc9JrPDfHdrQJHax4NkGwAgkEL6v70ECd/HEyVeewQiG2y+7UwQh7sDMwa3dgJgg6ZoAhZdizD5zMAuOOB1Rk45tQETaxT8jdyE2eXWw9HWabTmfm7paXAG8mzcmhpE9sokj8v8tRzMzafF5MkL3pPYHdcgiFZi1p+ZOW9vy8KZ8fupBIm2ipftYM2cgsaxF4MQXkfCiV7sMM5QX4eUIjh5emY4GYfFP1Ukn92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPrh+h3ieEEj/Kn4eNuhKvBtUF/6U4d13Vs5pMGXZkc=;
 b=qKN0bWAHQRHDJuFYflWoR1A/Uz/JLH0a4Ejma0zQkGw0x6ENnJaMdDTssKaqM2zmvZM1DVt0hjrsCTVSa2Rs4nxo6l2sy3B3FQDrRqDOluuky5VHmp36atCu0M6aeJ5bCvlxDwTNEpfrcMjwdVyt9Adj5FKsJAG9oyPh94dtYEM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DS0PR04MB8598.namprd04.prod.outlook.com (2603:10b6:8:126::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Mon, 1 May 2023 07:53:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 07:53:53 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "keosung.park@samsung.com" <keosung.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: core: Fix IO hang that occurs when BKOPS fails
 in W-LUN suspend
Thread-Topic: [PATCH] scsi: ufs: core: Fix IO hang that occurs when BKOPS
 fails in W-LUN suspend
Thread-Index: AQHZdyR4uWupI4e2VE+ZLqjHWNrDO69FEwkg
Date:   Mon, 1 May 2023 07:53:52 +0000
Message-ID: <DM6PR04MB6575A579B58313D1F0BF046CFC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
 <20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
In-Reply-To: <20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DS0PR04MB8598:EE_
x-ms-office365-filtering-correlation-id: 5e2dd44e-ad33-4533-928c-08db4a193528
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh/mhJUgrq932ga1XEhvgOixiw7eheuPyvV/ycGPitFcirv5k2LsuUm2B+FD2LubGpj5dtnIAil+JUrWEK8Fm/MvkaAUN400PI0jnBw9E12txQDNCUb3u2kDbKfGebox4lJM1Udd0ulBUDHmD9ff/M5C+P8fwMjBHpl/THVj0zq0anQS8MOZCENVCc1lMkpX9RvBhGw7Rnt1Nay/YFoVy8e4QLv8BeF5jIQV3CB0auXGTnHrMxsCRjqX/cYJbeeNFda2YDW7HvcYaNKZ8p1nmkmSrmAowyew6rXd2qJTPASq0LfwkZwo3ygLgAXFZhWYXl4Yh13jnvp3eb7GmT9tcjAuN/XnR043vvDFR1X8d8h7+06Csa9XzUfA1D6dk7ru3BQIFfUKtqKbNFQ5tAqw7s/2BRFD9TV1Kck32vTFCgNcMkRSpSUq7r8tTjml2/sUekWZ4PJ8UYKAl+3FQUd781l+BzLJIVwKE907zWpkWtaFsKVg8Tmy3kSIMvOsq9hS3wa6xdHnEkjMSEnkn9BX8kng/fmqOd0k/e7TWsS0V3U65hDjrskX6/ZhnesaxWyJzOWV+dU9cvG5dzjNjl4fI+q7WL5N2XC/hboJHuDOSKWtzSLW9GDnbRMzrpcuOZYVrZpz2qzdo9jOPcFGZiEkBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(83380400001)(186003)(38100700002)(86362001)(33656002)(38070700005)(921005)(122000001)(82960400001)(55016003)(52536014)(5660300002)(8936002)(8676002)(7416002)(478600001)(66946007)(76116006)(66446008)(66556008)(66476007)(64756008)(7696005)(71200400001)(41300700001)(316002)(110136005)(26005)(6506007)(2906002)(9686003)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWthVmVMbkMrNmcwcmFMalBTL1RmUDhUS25RdmNhVE13MHdSMVVmV1Q4disz?=
 =?utf-8?B?YkhudGppZjZuOG14czdQOFBkOEpZNStLTkZEOFVwTTRxLzJhb1p1RDNsZmpI?=
 =?utf-8?B?TDVYV0dSM1k3K2x5cWhyTXMyS05VREYyckxBT2lYdUxncDM4TVI3ZFV0d2ZV?=
 =?utf-8?B?Z1k5V3MzNzRMajJqNFlvRkhQUXFueFdZRFdVanlvdnJ1UkxrRDFTYityU1hQ?=
 =?utf-8?B?S3VaM1psNmRkMXQ4aXJGK0pLOG5zRHhVcGZvb2IzN3Byd2V2UzBibWxBSnlO?=
 =?utf-8?B?KytoZXVWVTNTRVFUbkcwMUtDV0tHRWJweTgwU3pKMW1ackJ4bTZBMzdJMkNX?=
 =?utf-8?B?MU50RUREbml6eHd6WXRnTGMzMXBydFhwRElKU2tzODFCZlhGV1h1QmpZOVU4?=
 =?utf-8?B?Nkxtdkk1UVNPY2RmL1hrU1JISndVZXdUdVJKT2I4NzVaQjlUd0UzcVlDNUlu?=
 =?utf-8?B?L3lzTlVZSDRvdjdOM3ZUQmJsaEM0T214ckFud28wZVpMWk9CY2IyUnNQSHlw?=
 =?utf-8?B?V2V3MHlSUHNUZDJ5RERXdkJVaU80MjNhVnR6dDhxOGpkd2hxNENNNnRnL0RY?=
 =?utf-8?B?UDB6dEJUMzB3VUhNc1pSRlRhSDY0TGZzWUFMY3VzUUVVRmF1enRTT1Z2aW5V?=
 =?utf-8?B?WFZOcUdlUVV2d1E5aGJ2ZzJPRG5FZ3lHdFA4dGNkUVhKcWdHVGVEeFFNanI5?=
 =?utf-8?B?ZWM0SGNHOFBRcFpsWTZKUzc3MkpuTGNhRjZleXVyZ2VQOEl4NGRCWkNuZFpj?=
 =?utf-8?B?NHVhdGRPZmN6MW04Nm1zT1VhY2xkQVdURU8zZmpxTDFZcDZGbWEzYVFEbXp6?=
 =?utf-8?B?WDJUT0hDVTNrN1A3WlNrOHQ0Unk5T3ByOG5ocGU0Qzl2a3B5SzdNWVdxY3ZD?=
 =?utf-8?B?ZkV0YTZCMUhZVU9LejltZDdwT3FjTEZMSHpGTUpWVFlsMWxxbU1xZ3Y4Z0hZ?=
 =?utf-8?B?Ym95dzNkb0V5c3gvSWVVa1VHbUhsVkxteUFEWVRjelBFbm1jNXljTGJVQmtF?=
 =?utf-8?B?cnQxQnBZTHdhMkdhMVVYQ2hxVXF5c0RQVlRKQ0JGSkJPc1ZmRnpwMkNxTVBV?=
 =?utf-8?B?TE0yRDMwaUwrUXZYYVZhNVd6T1g2eitvTHBBVVNXa1M2RFJ0cUhBNHhwRldi?=
 =?utf-8?B?cndTZTZhOUE2ZlUzQmNFU3p4dWpxUDEvK0g5ckpGZm55WllKakZtaXhsWjhD?=
 =?utf-8?B?TnM0UTJMbXVBalVTRndyaWsvR041Q0wzZVEvSWZROVJHQkw4RGVnc0tuZDVl?=
 =?utf-8?B?aUgzc1ptWXhXWlRnelhZendTTmJTbnBLNUJkTis5OGF4amx6Wks4Ym9neHlS?=
 =?utf-8?B?YjYxZm1QcjJERm1VZEErSFRWaGFacFdVd2lBN2Z6T2g3dmV4WGpCK2NjMDNH?=
 =?utf-8?B?dE42dmo1L0tjTzFSM0NjZ1lTN2RCNThkWmJjM0ljczFtYXpJd1BsM1duemR3?=
 =?utf-8?B?SnZ6Q1lpOC9MZ1VTMmFTVkVEVG42dURJamhGSUtUYUppMDNjajVhUlNoQ055?=
 =?utf-8?B?VXA3NUhJSmxjVHFFdkQ1ck9kZVFuOWtIeTdrSWtFNXdrSDNIbHFmallvOVlJ?=
 =?utf-8?B?VTFDOWVjZjg3ZzZZcXJHbVZyWFRFRTJwNzg0dHl2M3NOZk1Jc2ZIdUovQzdI?=
 =?utf-8?B?KzlRd0I2cUlKRmxrTmtQekdDSUtaK2tRbXF4LzJMcmpEYVBuK0t2cUZkamtS?=
 =?utf-8?B?NkNabGdTVUdDbHFZdnU1NGQvOFU5MXppVGFVUmV0cFRrN0hXM0xQNHdMVEFS?=
 =?utf-8?B?d0ZHdmxxWmk2S0RnZFE1aUdyc1piYmNvcUp0VUpQRVo4aU5yVnpZUnZoYUpn?=
 =?utf-8?B?UUZ4SUhCVHR1QVBFRlRFMW5uSGcwT0kyeDJpb1BXY0M0aW5BRGxGQ0Z5MmR6?=
 =?utf-8?B?bkNFZ3hyWExQYmpjSFgyYjFLVWplN091TWkydFBubDREWkFpbXZzN0l4cEN2?=
 =?utf-8?B?dkM1emhGRWg0TWY1VkNybEg1ZHp3c1hBb0xLN0toRlVOTE90S2RQY3VuNWtC?=
 =?utf-8?B?Nkd3WDlQd0lpMHhOUVhjdy9ueFhidFBHTjBhcU1OK0p1QnpNQmJuenIyVGNU?=
 =?utf-8?B?M1ExWkdYZi8zQUxwdE0zaklQeTcwZUhrc3JTbHRlajUwd1dLQ28zWURBU3Ax?=
 =?utf-8?Q?L5xe/J7A9rYtqtR/d6mT8pxnZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZjI2T1hkTkg5bWxmYWFIaDd5YkNPU2NmejJFYmNadktWVTdZMHJGQy9nNmVX?=
 =?utf-8?B?R2svbWJUUFJpY0JJczNGL2VYbFFKd2VTelhtRTRlVGY4cDgwcU1CRHNoWkhH?=
 =?utf-8?B?YTBtN2x3cnBQSXZ1OWlGb1RrZG5XZmtzV0VvMjlROHZXUW5GTUJsb08yQmZp?=
 =?utf-8?B?K0RINEx3dEZkQTRpTDE2NWMreTZPSGRZRGFxMEJMR2NaaUJZS2FwNUF2LzNw?=
 =?utf-8?B?R21XU202aGNmWnBweUtPSkF6b2R2a2pleHZ3ckcwNVdXRzI2NysrdkRrUzYy?=
 =?utf-8?B?RXpmTTFDZjR1ZWFSWHJDZGY5eWZaMTB5YTRqOFVZZlBhdG9YUG91Sk1jSHJz?=
 =?utf-8?B?eVZaMUtDVHVWRW12VVdCWlJuNmhWQ2g0S2N6dUJVRGFCZUVlTGhGazJtVkFO?=
 =?utf-8?B?dklja0VUZlFqOElkNk1tdDcxTzI4YStYdTUyMDZkeVg3WUg4bEVkTWEyeHNn?=
 =?utf-8?B?Q0FVbTlMR3QrNWY5MVNFa1hQYkpQSWxudFhMNlU0aXFPaWFqbWdGSjhYYVVh?=
 =?utf-8?B?aWlncklQK1MraVNuRldtbFRtNGNnTUJlcjJySy9zd0gxdzVCdGkySnBqYnFM?=
 =?utf-8?B?NUdlWnhPV0JqWkp3N2NUT0JNTGYxM3ZKR3RRYnh3MHdnRVowY05yU3pHWlVs?=
 =?utf-8?B?TnRFZllVbk02RTVqWVlaaEFvMHQxbzdTZUMwbCtmTFRkQ09hNHhzVlVpNVFa?=
 =?utf-8?B?TDFDWGNMRFc0Unl0MjVkMDlXRmJkQjdtMXRVT01rSUR0V01yTjhkditQU2Zx?=
 =?utf-8?B?WXVId1V4S2F1ckVWdXBaeVAvMXNkdHl3ODJkdU9HT1puaDB2bGc4T0FieDVJ?=
 =?utf-8?B?Uys3dHA3UHJNK01tR05URk44Y1Y3VGR2VElZMyt3U1Q1ei95UjJJb2ZuU1Zn?=
 =?utf-8?B?SjRWUHFySEI2ZFlrbU5wNjVER0haUTV6K1B4d3Y4SENXaVMxcXV6RkVxa1I5?=
 =?utf-8?B?SzdOSE93Tjhrb1dMb3YwNVRRanA5aEw2cnhsTUZ4aDRWUlZxRVJOREhBaGM0?=
 =?utf-8?B?eWhNZXBmcHIxTUNRcGU2ZE5UZWQ1VTJyYitxWFlNNytqbW8xbnFtVURNdGdH?=
 =?utf-8?B?Mk9IMSttUTdIdGV3cTVnditTMnlkNk1LRGRsTVhsczVqNUNiYkJKa2YwTGFp?=
 =?utf-8?B?dUltOXhObklSaDl5YXJsekEzQWV4T0F1QmJjaXdVMjY1UWlaUGVCYlgxM2dR?=
 =?utf-8?B?aTlUdGViVi9NVmExQmJQS2krQ3hOSHVFY1F5b3NBZXlFYlp6WUZicGJkUjJx?=
 =?utf-8?B?dzlBSjhYVVpCdnYvTjVDZFZPOVFsK2pPdyswYmNQZmZWMlQ2RFlHeXFrVUFM?=
 =?utf-8?B?K0phVTR4WTdBRnpoT0M1c2Z5UkZSN3Fxa3J3eUNvSGRWTmE0b0k5RmxpQk4w?=
 =?utf-8?B?bHo0OHcwTTZvWkE9PQ==?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2dd44e-ad33-4533-928c-08db4a193528
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 07:53:52.9003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVNfQKyBNLb5uA6ui8pUdsjz+1HcyOomC//GvsCig7y1UbP+eG0YxWPips1cmeyFqK1C8tVQoVixAEMgw3TJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8598
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBFdmVuIHdoZW4gdXJnZW50IEJLT1BTIGZhaWxzLCB0aGUgY29uc3VtZXIgd2lsbCBnZXQg
c3R1Y2sgaW4gcnVudGltZQ0KPiBzdXNwZW5kIHN0YXR1cy4gTGlrZSBjb21taXQgMWE1NjY1ZmM4
ZDdhICgic2NzaTogdWZzOiBjb3JlOiBXTFVOIHN1c3BlbmQNCj4gU1NVL2VudGVyIGhpYmVybjgg
ZmFpbCByZWNvdmVyeSIpLCB0cmlnZ2VyIHRoZSBlcnJvciBoYW5kbGVyIGFuZCByZXR1cm4NCj4g
LUVCVVNZIHRvIGJyZWFrIHRoZSBzdXNwZW5kLg0KPiANCj4gRml4ZXM6IGIyOTRmZjNlMzQ0OSAo
InNjc2k6IHVmczogY29yZTogRW5hYmxlIHBvd2VyIG1hbmFnZW1lbnQgZm9yIHdsdW4iKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBLZW9zZW9uZyBQYXJrIDxrZW9zdW5nLnBhcmtAc2Ftc3VuZy5jb20+DQpS
ZXZpZXdlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQoNClRoYW5rcywN
CkF2cmkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgfCAxMCArKysrKysr
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyBiL2RyaXZlcnMvdWZz
L2NvcmUvdWZzaGNkLmMNCj4gaW5kZXggOTQzNDMyOGJhMzIzLi4yNDk2NmU5YWY3MjAgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gKysrIGIvZHJpdmVycy91ZnMv
Y29yZS91ZnNoY2QuYw0KPiBAQCAtOTQ1Nyw4ICs5NDU3LDE2IEBAIHN0YXRpYyBpbnQgX191ZnNo
Y2Rfd2xfc3VzcGVuZChzdHJ1Y3QgdWZzX2hiYQ0KPiAqaGJhLCBlbnVtIHVmc19wbV9vcCBwbV9v
cCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICogdGhhdCBwZXJmb3JtYW5jZSBtaWdodCBi
ZSBpbXBhY3RlZC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IHVmc2hjZF91cmdlbnRfYmtvcHMoaGJhKTsNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJl
dCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICogSWYgcmV0dXJuIGVyciBpbiBzdXNwZW5kIGZsb3csIElP
IHdpbGwgaGFuZy4NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBUcmlnZ2Vy
IGVycm9yIGhhbmRsZXIgYW5kIGJyZWFrIHN1c3BlbmQgZm9yDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICogZXJyb3IgcmVjb3ZlcnkuDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWZzaGNk
X2ZvcmNlX2Vycm9yX3JlY292ZXJ5KGhiYSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0ID0gLUVCVVNZOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZW5hYmxlX3NjYWxpbmc7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIG1ha2Ugc3Vy
ZSB0aGF0IGF1dG8gYmtvcHMgaXMgZGlzYWJsZWQgKi8NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgdWZzaGNkX2Rpc2FibGVfYXV0b19ia29wcyhoYmEpOw0KPiAtLQ0KPiAyLjE3LjENCg0K
