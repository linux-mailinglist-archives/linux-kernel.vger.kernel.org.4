Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF563B2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiK1UH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiK1UHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:07:24 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898E218385;
        Mon, 28 Nov 2022 12:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669666043; x=1701202043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1bMWEMMTh475m5Gbuv1Xg870tFrrZNpj+9RcZVrx9OQ=;
  b=CjIVemehUSMszxR4YEvHAwQXwJUd4+g3ur/hPks8FmZUeqCIhD3qM0aD
   MDdvZl9KDvE5F/6L7DEE3AbZOVQRTk6Sl82mFttkZB36mQCTpCdV02Hi4
   RNwJeqU02R+3uOZKQ7U/XT+ZPfYi95tldJgTp1rQmxloo+i0d4t3kf/kr
   g1yXMEgiebtsStIKI9IVIQf8ZXn7uf3vfHYPaGbwDT5ZfO3OWxC+0BA09
   erEPRGHc2CzushpuBASSHk4LL+ZfKGx9MX2grws2DVagXG64F98Sfhfhq
   wMkwIjr+HoTlZg4LJRYFagHIAZ2X+SyD4YWCtAt1iiSVxoZj7gLJgfUUW
   w==;
X-IronPort-AV: E=Sophos;i="5.96,201,1665417600"; 
   d="scan'208";a="329483145"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2022 04:07:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1fXkp56jnN315DyrlVALNOTIhI7GVAC4PnEsgde4cSdaT+rRlt0S0215GKcVbzAUuMgnXfmoFzycJPBaOOXBo35uYhMj1bRYpi1JlXF4eo6kiG+/2OU4ysxL4A6bPVRYATeWJHISYrPeUacnZmug3eWzMmUmwihJF3r1JjEMv0gvE0ust8g9ffYwYc4AQjgudEczqT4TmZ7EGKpCz8rq7ZBMiyQP78uw4o0jIuPDjuVGhCUkuJGItQqwSMtJcLsQbL4D7cMu1ZUp2462CpVTPUhmZw4+0nPQd+si4Hv3YCKoXLw3KG45o8SLHr7o+lYOcInmEe5W74v0x5C1TWL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bMWEMMTh475m5Gbuv1Xg870tFrrZNpj+9RcZVrx9OQ=;
 b=eF+5DHFtfPaCjhtRtnsg3JaHvlc1kMqzkq7vQicu04GyTCafI61038F2IB6NUytG7Jo7/AxNjBDZ/ZuSXP/a0I0ybdC9dFcvkmw4Ow600EoISlPClpzldTIxDoHRCP7y1QYA+JLBeacmO6JPZI1FQJF42mwqu2uPg+vt1VjznDYR7ucxrJfHJW2zclcTgIQOY+nb3wWB9gglScHfBoDy9dIbW7TzTY4ZKOLX4IV5zq4H1d8l3MrMfB3pCmIftEaf/GgqrhuUJgtmPf2d8WEZMFGgwiMjR7TGv9TgRcco/c7owWaeBF/psKvbbKZ0o6xM9maKrAytgNHHcMZTHoz8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bMWEMMTh475m5Gbuv1Xg870tFrrZNpj+9RcZVrx9OQ=;
 b=BOGVTibqb879lBN4csstXq+db0zWiZfuJ2V6pvKhFVLMPdgpoNhTypPTYyGGuWI728wG3br851WfXRPbAoZJvGKac6xLj8hv90UnAKuX9vcQailhNlvKBwQ2nl/sbMG9VVSIjb+VhV0Z6BZm04lGlc7zAtUVL49WKodLtwWaABg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB5416.namprd04.prod.outlook.com (2603:10b6:a03:cf::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Mon, 28 Nov 2022 20:07:18 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 20:07:18 +0000
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
Subject: RE: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Topic: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Index: AQHY/S6fGNUnGplQxEOfi3uFlr5Rnq5K1fvQgAnnSoCAABHe4A==
Date:   Mon, 28 Nov 2022 20:07:18 +0000
Message-ID: <DM6PR04MB6575B8A3BD70EAB5DC409EC3FC139@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
         <20221120222217.108492-7-beanhuo@iokpp.de>
         <DM6PR04MB6575750D9C6F84FC3BE06AFBFC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <12c9e417168cdc044b9fd53c30d02ccab29179b2.camel@iokpp.de>
In-Reply-To: <12c9e417168cdc044b9fd53c30d02ccab29179b2.camel@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB5416:EE_
x-ms-office365-filtering-correlation-id: d585d9b0-0882-4018-f49a-08dad17c26c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFL594qcn4vJKuTHZ2XSBc6V5LZpQ8ZCRVaxnlY6qq64aOty6iKw0FW36BYb5IXbLwQ5VMJ/iSjDcUdpcKxjlBwANKoAqwSFF7bK5LQ8kyo/cUsEw3cqSE3GyKUDYUoSEQTv+JFS8jRPNoBAxfEkh0LgNSo6I/nseF8pe2JiQZAE3sISvN4W0GmEkUUYHb+s60na7PdVRlZLgZewry4iH4P26QXWkuyoLlqhLdf+j8BhJB/HuFrj2ACob1y8GRYJ33kZfHiKInHq5Fw1AbyIIo4d0gV342uQ78lNCy1VgX+3NUaGvmUM1u/LyqZUTFct61WHKxzf2+FcN7tSu1eo8oj7xnDCiyx9bROBNY5kmTYyW04WMWwjOOFd1Bvg/lvPrJQwJBH9B9m8bYnmxLjRh72YMKEZPX4dtVCC6cVTw66au7ehHmM8sbRDGSG7Qdk7JmrdnX+t28q10+IXxU+zNXEVCBgsCyiCHlncjXS8WnRHPM6vfwMFrwku0e6uDwb4OV4A8PgdFWdCbxYDKDA2y3TsjcquCxles0GKsYszmc865iC9iQ+y7rk1a2CCOP4GobAYg4BnVzlU+/y+Y1SM89y0hajbAE9zhRx5tMbxV53DQFVU5Y5BMjECeloWP9pJEocKaFE/VKNEq1g6sETun7K8t2hGNWl1xIAnSJAiskkctNsyf+WwEY/JpmIaQyuH0oAsXmiRK1oU/gu6Ta7y0ZuiZtORWdiUxltYN3K9PZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(7696005)(6506007)(83380400001)(86362001)(478600001)(71200400001)(26005)(9686003)(316002)(41300700001)(8936002)(110136005)(76116006)(54906003)(7416002)(5660300002)(55016003)(33656002)(38070700005)(38100700002)(4001150100001)(921005)(2906002)(82960400001)(66946007)(66556008)(8676002)(52536014)(66446008)(66476007)(4326008)(64756008)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmNIYThEbzdnK1RsQkxyc1dKbE5wL3lUTWg3d3RlQURvM1JYTUZNbmd6TERr?=
 =?utf-8?B?OWllR0xFdG5yUStxOWduMi9icjR4a0xRRzB2RGtYai8walduNitRREpqeHBw?=
 =?utf-8?B?MXlYeW9Yd0h5MkNyVWdYNjZ5MUo3dHlZT0J2M01YNTRvYzFwcnhuN1V5Mmd3?=
 =?utf-8?B?UTJBbjNvU28wSzVXZDY1cWlCRzZ5akZPSWtuMDlCM1ZjKzhJTC96YitkNkVu?=
 =?utf-8?B?a3RLRFVHUWRxQytwdUY4Rk9UUzdiR2U1QW9wM0lxZWFWbVlsckNUQjNhU1Qw?=
 =?utf-8?B?SEZJMjhBM0cwWjJCbDFLTGNrQ0t6djhxYjZuTjJvTHRCaTN5dVhSdm02d3ZO?=
 =?utf-8?B?Z2tUUmppU0pIbHJEZjh5VjlmZU1IekdmKzdaeEFUV1VJQ1JrS1AzNUppZHZE?=
 =?utf-8?B?VTcvVFJ6UWhlR0NsZ3A1SEh0WWNKeldPdSttNUJoendFeXJpN0xUYjhsckRV?=
 =?utf-8?B?RjYyRy9vWFpHY1RXZnZWdWpzRzNpYk4zODNBVkxKMU9mVU5IVDF4eEZXRE1u?=
 =?utf-8?B?L2dTcG14b1BLdUNsQTJRblpsMHNOd0JvY2pKRVNVZjc2a3huaDFSaFhsOWRI?=
 =?utf-8?B?MGdoOVMrUkRNeGxzbWVDajBhVEoyT2h2YVNwcWt6bHpJNk5OSW05aEhtb0d1?=
 =?utf-8?B?Qnk4cjRtZG9EZnRwVjhPcFBUOWNNYW41YzBpQk9WUnFmQzJpNXRZM0RvYzRC?=
 =?utf-8?B?d2dGQ3hZb3A4MDhlVHZpY0dhRlNGQnNLbUZ5ZlZOTG9XTjh5WjMweGhFenpU?=
 =?utf-8?B?Vmk1SnFQK3hoWXZ3NHJVbUlLQnZUNlE3SWZtMEEzcCtEK1k1RnFXV0RQN3Av?=
 =?utf-8?B?Y3VQNFQ2NklsaFQrM2s4OHJFQWxGSUMzK0dPSE4rYllFL29CbjQzTzd4WGlz?=
 =?utf-8?B?dVRsQTd2UWZnUnpTS1dVNDAxVG5VZTVRKzlYWXp2Y3BJQ21aOG01eldTMmNG?=
 =?utf-8?B?NzFTZitiWk1kMjkvZ0dhTzNIbXRSVU8xdTJBaWRnMlk5bTkzRkxKcDhCRFdw?=
 =?utf-8?B?bWY4aHJCbzNwaVVVamY4by9ldnZGYlRUazhHeUwvbVZ6dTB6YkswR0RST2VG?=
 =?utf-8?B?aGpRS2ZlZloxSExuWVlUZmlqTHJpQTE4MExObG9OWjQycm9tbE5CcU9ybEJo?=
 =?utf-8?B?UExSbXBoUFU1RERNbnVnSndGL3M4aS9XbTdYRjlpTGxONzRYd2Z5MjhBL1h3?=
 =?utf-8?B?U1YrSTIwdzJLYUFuSmltYWYvTEI3YkZwcU4yanpPRjZLMUl5eUFhc09NQXEz?=
 =?utf-8?B?azNuYW5kVXJBeTRsTnVlNjl6L3NFQ2hoOUs0R2taQWR5aUZQa1Z2ZUZscGtR?=
 =?utf-8?B?K2tSMDVQNFBpZys0VnlHckFwU0o4QnY5L2VIcGI2R0M3dU9XcXloQTFPN01C?=
 =?utf-8?B?RWFhVE1HZ2ZaTGp3dnJoMXFjUXhZMXpkREpVNkcvcERBWU04c1ZmeTNHc3ZD?=
 =?utf-8?B?c3pneklJRmJvQVpWcDNLZUNSdUFPdlhBVUhSQmdMQXJNa0JkWDNSU0hteXJG?=
 =?utf-8?B?N21GdHVVeklobjJNc3Fmak5NSExQY3Q4L3FLRmFrb0g2MHBNUWk3aEVFQmNE?=
 =?utf-8?B?U1FKTHRDWGR4aVhOdWFIaTJhN2dVUHVUUXFHcWZrVE9KTlVEWDRNUlBCMzJR?=
 =?utf-8?B?WWI5Vkt0TWJrTVJNVkFmUzl5OE8yeklHLzBQYWxZU3g5U2Zob09QV3JCL0RU?=
 =?utf-8?B?ajlYb0E4cHBIdGFiczJhOWZHSVNBaEF0blRFZHZwR0FWWUxZR3dFY1BqYzZK?=
 =?utf-8?B?UXdHS1RXS2p0aG1JSjgxYVRZVUkwcVJ4SVBPRG9lQVY0MGExSitSY1gxUWIv?=
 =?utf-8?B?VEZsM2NFTFFwaEY3L0NCSmtMclVpZ1IxTlJVRXFTTmlFVSt6ekQyV1MvUVB6?=
 =?utf-8?B?RXl4eVBpenB2eGkzc0ZyR09DbjIzL3NPd2hVV1lmV3lRaWdlS3FXbFdTSXlD?=
 =?utf-8?B?czIzanlOVklUSTd4Ny9ZVjhFM2o3QUpNS2NlaGpIdEZLeGZGdUVKVUM3dEtk?=
 =?utf-8?B?WTNjMmJZVzErZzY5R1YwL0Z1aUs2em1UTStzOEczNUs1ZFpZSCt5aUcwZkRO?=
 =?utf-8?B?RElybVZSOW9WNUF0cksvMTFEdk1OcGFwTTdGbjVWczRBQkl0VkR2RVo5cURr?=
 =?utf-8?Q?Ups/ScEIl0C/OEvX8JPBOp6nS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cnVzSkUrYUttSXRkdzJVU21USlVPRndVUEVlSzRMSFJhamZvcnN5V3JqQU1m?=
 =?utf-8?B?ZjFrNWdSSlhnWklUSkQ1ZTMzbWNVWmVZeXFjV0FmVzBsZHlTZnNzZFRFc3lq?=
 =?utf-8?B?RmFNZ1ZxZ1BkeTdyeVRobkNTbkVyZm96QUhyMG1TSTluNDh5UEtLZ09Qdjlu?=
 =?utf-8?B?OHY2NzBoL05LNXNRcEZBbGhrVnFYV1JxeFRIL0VOZVd6ZU9IUXNVZFFmVVYz?=
 =?utf-8?B?VDU1WEExbFJwUWc0TnBXMVRVN2dyNzE3V05JRFVkZVEwUVhvTW5EUVlmWXBp?=
 =?utf-8?B?aGMzMFZGVGJJakI0S242MlhCOFJHK3JMRytoeG0ySTY2dzFMYzZPeUZuSW1X?=
 =?utf-8?B?b21ZRVA5K2xUTDJ6eGZsdlBFSlVad1pmMFVIY3pSV21kM3AxbUFFTUxVM0w0?=
 =?utf-8?B?UmVaa3lTbjF3c2pYRWdaN0NMMWdCempFQWNlOVF6cW44U211ZEFockFhQk5M?=
 =?utf-8?B?ZXdOd0hMMnpOYlIxdVdvdXBMWThWUW4wdXZ4Q0ZBRVBseGxORHJ5Mm9mSlAx?=
 =?utf-8?B?RFRHZkZsN3gzUEk1K0VEaklzOFcxN0dlWlIrZkdaUUxJZU9CaVdwQnNMcmE4?=
 =?utf-8?B?aFhKYVZLdHZmdE5YWFlOVldxSFE4czRUbThYdTY5eU5TV3RRNlNQU01qVXpI?=
 =?utf-8?B?V0Frc0VPamdBekJSZEpmWjVnSVp0TEJpNkQrTStCUTZJcmhPYnVNRS9wM2hj?=
 =?utf-8?B?N0JLZk9OU2xzU3krQ0xOQzA5eVdramd0cWc2eUwva1dYbWhVUUt1VVBzdkkz?=
 =?utf-8?B?b0I2emw2NFVNVk05M0JzMzF5QWRJNTIyMHVDLzlyT3d5bytvQy83bitrdk9m?=
 =?utf-8?B?NjBWM0lLeU8wdVUwV2J0VmNMdDllMVdlYVBrSzdzWnNQK3ZlNFJQZWI4QW92?=
 =?utf-8?B?ek5xYXk3ZU5FenlLd0ZjZGxRMkxoNDBZWUZOdjJFMjJJT3R6R2N2cFJXNjB4?=
 =?utf-8?B?WWt4MkxBMGtvTjJLTFI3QWJCMTVkMzNMNDhRZEE5QTg0NU1lMTBMb0J1MmJE?=
 =?utf-8?B?NG5KaHJlT3NpbWFvTjJsd0lvSkVXR0o4ZkVONldGcmR6alVhbWlXWWJPQ2lt?=
 =?utf-8?B?bjR1dUZTUmIzY0liS3cvV09QOTJ6UE8xZi9xK2VIYnNpM1ZWVGtCWVJUTFJO?=
 =?utf-8?B?VmU2Tk5sZmIxVjJkc0ttZnhJcWFYRGV1bWRCMDl3aHc0S3lHb1RSQ05wMHBI?=
 =?utf-8?B?NVR2czVrRmk4VG5XbkhFSk80N2NjU2Y4Wm8zUHRhbkpZaFFxQzNNZHcvanZ4?=
 =?utf-8?B?WU1QR29ZREF0VjZVOU51WHFVVm5RU05uOVBLUkl3NkFCZTBmMU1PYzNxOVU0?=
 =?utf-8?B?R3pnQS85L1lBaXNyM3czTC9jQkd1c0hNK3VmRThnb3FRazdndGdybDQwV0Nm?=
 =?utf-8?B?WWtNbExwalBXdTVYTmhTYzdOa0NKU2FhTCt5UVJPa09WQjIvNEwzWjYrM3Fl?=
 =?utf-8?B?MzREdmZLdGFnUGl1dEhMRmhBdGVxTFF4d2ZyZHk4WFRJc2NlNGhLczEwU0JI?=
 =?utf-8?B?eTZtaDJzYURvZ2p0Z002K2ltUVFnMFVNN3MyYU1wYmlwVnAzQkZYc2pka3NB?=
 =?utf-8?B?Zk5wWEgwbHUvQkhIbldNN2JEN3F0VjVvT0U3YW54T1U1dkZxL1BoMmRaY0VM?=
 =?utf-8?B?K0Y3NGY0MDBNZjU2Tmh3V1hMUVh4NndmQTE0K1laOEhQWGFSalMxckF0Y043?=
 =?utf-8?B?UFJveGNCM25MS2dhOE1uUVJSalhYSEd3aWpad2hld1pXaWIzcy9UZFFRPT0=?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d585d9b0-0882-4018-f49a-08dad17c26c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 20:07:18.2575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25D8VGIftN/R/giZYlcgJPrw5gsXsptU5wWGt9JeCQ1A6J3QX7jA/EZmQj/3JErFvwDTD8dBqE3hTF51AMoN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5416
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIDIwMjItMTEtMjIgYXQgMTE6NTUgKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0K
PiA+ID4gK3N0YXRpYyBpbnQgdWZzX2JzZ19leGVjX2FkdmFuY2VkX3JwbWJfcmVxKHN0cnVjdCB1
ZnNfaGJhICpoYmEsDQo+ID4gPiBzdHJ1Y3QNCj4gPiA+ICtic2dfam9iICpqb2IpIHsNCj4gPiA+
ICsgICAgICAgc3RydWN0IHVmc19ycG1iX3JlcXVlc3QgKnJwbWJfcmVxdWVzdCA9IGpvYi0+cmVx
dWVzdDsNCj4gPiA+ICsgICAgICAgc3RydWN0IHVmc19ycG1iX3JlcGx5ICpycG1iX3JlcGx5ID0g
am9iLT5yZXBseTsNCj4gPiA+ICsgICAgICAgc3RydWN0IGJzZ19idWZmZXIgKnBheWxvYWQgPSBO
VUxMOw0KPiA+ID4gKyAgICAgICBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXI7DQo+ID4gPiAr
ICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dfbGlzdDsNCj4gPiA+ICsgICAgICAgaW50IHJw
bWJfcmVxX3R5cGU7DQo+ID4gPiArICAgICAgIGludCBzZ19jbnQ7DQo+ID4gPiArICAgICAgIGlu
dCByZXQ7DQo+ID4gPiArICAgICAgIGludCBkYXRhX2xlbjsNCj4gPiA+ICsNCj4gPiA+ICsgICAg
ICAgaWYgKGhiYS0+dWZzX3ZlcnNpb24gPCB1ZnNoY2lfdmVyc2lvbig0LCAwKSB8fCAhaGJhLQ0K
PiA+ID4gPiBkZXZfaW5mby5iX2FkdmFuY2VkX3JwbWJfZW4gfHwNCj4gPiA+ICsgICAgICAgICAg
ICEoaGJhLT5jYXBhYmlsaXRpZXMgJiBNQVNLX0VIU0xVVFJEX1NVUFBPUlRFRCkpDQo+ID4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlm
IChycG1iX3JlcXVlc3QtPmVoc19yZXEubGVuZ3RoICE9IDIgfHwgcnBtYl9yZXF1ZXN0LQ0KPiA+
ID4gPiBlaHNfcmVxLmVoc190eXBlICE9IDEpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+ID4gTWF5YmUgeW91IGNvdWxkIGFsc28gY2hlY2s6DQo+ID4gSW4gY2FzZSBv
ZiBycG1iIHdyaXRlLCB0aGUgcmVxdWVzdCBwYXlsb2FkIDQwOTYgw5cgQWR2YW5jZWQgUlBNQiBC
bG9jaw0KPiA+IENvdW50LCBBbmQgc2FtZSBnb2VzIGZvciByZXNwb25zZSBwYXlsb2FkIGZvciBy
cG1iIHJlYWQuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZyaQ0KPiA+DQo+IA0KPiBIaSBBdnJp
LA0KPiANCj4gaW4gU3BlYzoNCj4gDQo+ICJJZiB0aGUgQmxvY2sgQ291bnQgaW5kaWNhdGVzIGEg
dmFsdWUgZ3JlYXRlciB0aGFuIGJSUE1CX1JlYWRXcml0ZVNpemUsDQo+IHRoZW4gdGhlIGF1dGhl
bnRpY2F0ZWQgZGF0YSB3cml0ZS9yZWFkIG9wZXJhdGlvbiBmYWlscyBhbmQgdGhlIFJlc3VsdCBp
cyBzZXQNCj4gdG8g4oCcR2VuZXJhbCBmYWlsdXJl4oCdICgwMDAxaCkuIg0KPiANCj4gDQo+IEkg
dGhpbmsgdGhpcyBzaG91bGQgYmUgY2hlY2tlZCBpbiB0aGUgYXBwbGljYXRpb24gaW4gdXNlcnNw
YWNlIGJlY2F1c2UgaWYgdGhlDQo+IGFwcGxpY2F0aW9uIHBhc3NlcyBhIHdyb25nL2luY29ycmVj
dCBwYXlsb2FkIGxlbmd0aCwgaXQgd2lsbCBlcnJvciBvdXQgYW5kDQo+IGhhdmUgbm8gZWZmZWN0
IG9uIFVGUy4gSW4gb3JkZXIgdG8gYWRkIHRoaXMgY2hlY2sgaW4gYSBkcml2ZXIgaW4gdGhlIGtl
cm5lbCwgd2UNCj4gbmVlZCB0byBtYWludGFpbiBiUlBNQl9SZWFkV3JpdGVTaXplIGluIGtlcm5l
bCBzcGFjZS4gU29tZXRpbWVzIHRoaXMgaXMgYQ0KPiB3YXN0ZSBvZiByZXNvdXJjZXMgYmVjYXVz
ZSB3ZSBkb24ndCBrbm93IGlmIHRoZSBjbGllbnQgd2lsbCBhY2Nlc3MgdGhlIFJQTUIuDQpGYWly
IGVub3VnaC4NClBsZWFzZSBhZGQgbXkgcmV2aWV3ZWQtYnkgdGFnIHRvIHRoaXMgcGF0Y2ggYXMg
d2VsbC4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gSSBoYXZlIGVuYWJsZWQgQWR2YW5jZWQgUlBN
QiBmZWF0dXJlIGluIHRoZSB1ZnMtdXRpbHMgYXMgYW4gZXhhbXBsZSwgd2lsbCBiZQ0KPiByZWZl
cmVkIGluIGNvdmVyLWxldHRlciBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4gS2luZCByZWdh
cmRzLA0KPiBCZWFuDQoNCg==
