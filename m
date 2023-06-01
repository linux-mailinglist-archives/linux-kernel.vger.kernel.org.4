Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC15D719585
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjFAI1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjFAI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:27:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486F193;
        Thu,  1 Jun 2023 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685608037; x=1717144037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GGsBDKdeW6O6g37ucrw/W8UPa6fL4BirW+KkoAI34u8=;
  b=CVHx9tB8SM4wzNuU/xi/YUquAd7eAs8x9lyTFfXylJLxFKupXVoZmi6A
   NfyMBWEBjoc193ifOQikx+15Nr81QCJH352hEBcZjVJO20WsQQ7WjvtPy
   sTMeCBWVOhDrL+UcZ8r1h7Y5gGFKSqgMbVliOitqChB7VbfEo46SKB1Fs
   4MrjrRTN0kFAVsKBZD5aTTPBlvuwb5Y71ux83JfHn7OAT8kLpqTptAxtI
   Gwz/xdjyBooGKZnB1h12YEyMloRQj36y+eh1OQoWJ/+mIcFT3filXZvYL
   8n3VMvNDayTkWOlE3h1jnqUXdbS/AAwhesm2f4jM5pPlZh4Pm+gQ6ikrT
   w==;
X-IronPort-AV: E=Sophos;i="6.00,209,1681142400"; 
   d="scan'208";a="230288324"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 16:27:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5zFNSIf4RuYQav9ydRkqzS7iNPQh0n1XUR9DZ2TrlzVbeDg0pm2iKrgIrIpZ2xpv0f15PgGTqA6pgePQOBpHDBGRyszakPWyyC1MWDN1giCRkTXNRmA5LmtepOJICe2HkkSVNaSlHm+8h1LVysHsidyyvnaKsGaLM7QAOoyAKuRmoawnFflphJ0WI1/vUS/wp02Hlx3tRh0IznIlA80hR1O3jFtBUHv9KyJpYaaiF9qK0mJegcCMu7zyLljmdA8934aKGILj9mXhgk8BmTK3YXGrOOB/UBOGM+36xBNnVTt4Hh/HMMzMHTFApX7Czu6SaPBLNg2576pv5DtkQMOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGsBDKdeW6O6g37ucrw/W8UPa6fL4BirW+KkoAI34u8=;
 b=LO9fPYGZr8nJzDlToy8Cu1T4mEhwimwJsLJzCq2PTlenv7epKq+yEX7bkpL+Z+iHktV5obR7dKurnHRlQg3HTu3wS5ZMMGrBVCFwM6oY4AXi50dXdA4ajILAE9oa62iW+Oj6vHfejICS18yrRvoG3t0YtGnAh2hUSDJkqnrCicQyJLHCpcjftGtk3q6zx3sEEqDogEjEEWfNors62E9IzV/GXrnINMzQ37p8uVG4DPhxOEOC6PXh2iMZlFGuE0bnPX4VPd6Ea3iGjBHo4Fjr/lOTE3pLC5n9YvvGnp6lhUXGzIV/OBOUDM3JFrpyANBWJTJi3L6PkrqnazlxVGW+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGsBDKdeW6O6g37ucrw/W8UPa6fL4BirW+KkoAI34u8=;
 b=G0xyTI2QPnvdt1lmhVSt8MK54hw83a0Omvi+vJcQsXuUd0fV29ngIxgAFDbfdPWUpMz/rixLMMSU4aB1++Cp5622aaiWUQ/B40S3gZ1U8LT217uummiaq5ocv8gHCsibvysWeXWRGtCHWoq/68kmMlybecQjgPu6fPz2HNWXuZM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY1PR04MB8749.namprd04.prod.outlook.com (2603:10b6:a03:532::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 08:27:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 08:27:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the block tree
Thread-Topic: linux-next: build failure after merge of the block tree
Thread-Index: AQHZlCMajQjeNxowR0m7582L4M3PgK91nXKA
Date:   Thu, 1 Jun 2023 08:27:12 +0000
Message-ID: <012599f4-61cf-47df-0fda-4294d8573b83@wdc.com>
References: <20230601105006.199a32ee@canb.auug.org.au>
In-Reply-To: <20230601105006.199a32ee@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY1PR04MB8749:EE_
x-ms-office365-filtering-correlation-id: 45f4d6a4-62f5-4c34-5be8-08db6279ffcd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4Z7sRJZ+LWnGDw+7F7tz7cgb+jDteknklrOwOpfB90R68oF9ayZAbBGzYmHcOIneWEz1RPMc3CXpkU+HSUJnPmEl6Acex2iQvvIiyJKMSDQxAfQp2ZsW30+e3JYVhwICJBm+oaozchFC8ExDRbEpB0oBdxJajNjU4+PnRx6ZStHMliheLT5AQ0aHCkthX7bB8JwMjQn/nH4pElcimHtsvIYwImSjvObQyk489fJTdAuTW+ZdK3aUcUMVFnbjygovW0q5Peqx9gjB1NCe/AZHZ6uZmwpveSsx+AzE6lkzYApt7tRSb0zEz4K9Yup5AjBaw0wYn4LhBYxc8OT7zy26aw0vXcwgDmnPJvK956KOh+xUOh4kEog06Q4FbRPzMmQXq2vZa+PL8t0H2tB6p8X+/zImuXttj0e/lccrvMh2jImwCK/CgIJHFntyZbzi6TLaeL1DToe6U6F/wCIpV7EZX1AfgHh2xPIm0K3orr2Fotj/Q6Yc0KZZcUfeldrscGhtwAhzE+hM4n6WmM0eJbwgExZXadJFB7mURJgP+Dz+aTWtaF3UsWJMwZ/JkiilAgUJKXfWLe8r98bR7YsKU5ydr8TGUX6Eaq8wx4HW0JpkkJrjP/OXtJRPv41T2rDWTJtJ9dHpJERYcLa7JyH7o5GTlsBvOvNFsiM0mPed6+h20mQn4n75iDY6dKOMyuSwvQ6nIdloXreyMB2qtbOwpIcUSNenlEW6vBwqj3YevRykFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(83380400001)(66946007)(66556008)(64756008)(76116006)(66446008)(91956017)(71200400001)(6512007)(6506007)(66476007)(110136005)(186003)(2616005)(54906003)(86362001)(2906002)(5660300002)(8676002)(8936002)(478600001)(31696002)(38070700005)(4326008)(122000001)(82960400001)(38100700002)(316002)(36756003)(41300700001)(53546011)(6486002)(31686004)(43740500002)(45980500001)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhoL01LcGFBc2JHTkRaV2RvMVp6TWNoVzdXeklwaTJZRXJqMGpEL1pVMkM2?=
 =?utf-8?B?djVCS1l1T3JKcWtKS1FpbmZTSGRWOG1tVHFiU2FYVEtqZittMzV0dmdSeTdh?=
 =?utf-8?B?VjRWR0tZL0Rpcm5saGhGbEwrUUFoNUpuL1JtMy9pclM4V2EyM0gwRlNKbW0v?=
 =?utf-8?B?RmhZcExZa1RPWmRvaGNPYjRVRDhMd3BmNHlGUE4vaTNrQmVFN3JrMmJVRTBz?=
 =?utf-8?B?OTFScG1ZTVNrZnpBcTdaODVIeVVnangwbERsUmhBb0VVUUlTVXdVSjNqSiti?=
 =?utf-8?B?ay9DT0pxMmdIQ05TYTBZMm5seU1wc1hBaUZLbkh2TXZCL2tRS1NlWXRrK0Uw?=
 =?utf-8?B?dzNWWnl5WWIyeTQyVmJkSkpSMEQ4N2hRYmFGcTdzakwvM1oybUFaVlpRVGU5?=
 =?utf-8?B?ZHB2eGtxUUJmNHE1bjZjN3VYa2tLMFhLc3VMWktQbmRHM2xQM2RCcHgvSXVQ?=
 =?utf-8?B?NC94SHlmWFRHSU0rbGVrcmNWcmRNL0ZnZ3hFdHpPSXVXYzdaZWhKaTVwWGlM?=
 =?utf-8?B?MjRVRHhDMktpZkFjcE9iZUwxLzFDTzhpVTllY2VXaGpIQTlxT2d6TTRqU2lz?=
 =?utf-8?B?ZUNReUJFOTM5RzBtNzQzYTVaUzBDcENPN1NBcTQvTjJHaXBpUnhGZzI3SFVC?=
 =?utf-8?B?M0s1aDc2VUNaSXpNUVNVcjFCb1JEeTFOam1WTnhlRmZMTnpHakNFN0JaWG9H?=
 =?utf-8?B?ZjlRNGR6Ym96UnNEckc3SThESW1XeFVSSzE2VUxITkE0eFZrR2hzR2lRYXJE?=
 =?utf-8?B?c1ZwZXpsNUFydVF1VzJsREptSUFWZzVmQTRmWm5XUmtFU08vSE9QVjBGMnpl?=
 =?utf-8?B?OFZlSWxtWmtUbzZzdjNlRXdrc0xjYTZTKzNCWWNqdHpXcXd5dzdIMDIxYmJU?=
 =?utf-8?B?MHlsOEd6NjNBVEZzQzBMMmhNV0RBL0hGeVErQXFVNG81TlBnUjNVZyszdDBN?=
 =?utf-8?B?NUdObklocmtUVm0zbmlheXl5L0d0ME50aVBueFdmbHJrUW9iejJPNkc3c0k4?=
 =?utf-8?B?Y09wTEQ2TE1GQ1Y5SU1mMFJRaWc1SWZuejRwL0lpMExGYjNITWlNVlArY3B0?=
 =?utf-8?B?T1J4M1NVUE82WnV3TFNpR1BLOFVXS3liVkV5WE1LMWdnb0xMNWlTTzRaNEZj?=
 =?utf-8?B?eVp2SVhzM1JhY1E5YVZDbks2OVF3b2llYlNubSt5S09KbFh5YVpWemYvK2FW?=
 =?utf-8?B?cHhhdmRyMllHRDRMRWpOeEQ4NWRhOEFDdnpZTm9tUUZGWmhYWTVHa2FQSFdk?=
 =?utf-8?B?TXBuSlArVFNVOWdVMXdiNzNGbGIvdEd1YU54MDlHbkIzcHJYaERHa0Uwc25s?=
 =?utf-8?B?QkRKM1oyOWhNZkt3ZkpYenRzN3NIdXhsUTRJd3AxZlFKNTlxUitqRXBtYzVF?=
 =?utf-8?B?UXd1ZlRScTZTWlFVU0FxSGdQc2tka3VCMGhUblZ3dWdlNFR4eTZkUTBSNlV5?=
 =?utf-8?B?RktLdWd6MVZhZ2dEaXNMaXBFcWZCTnNWZmZoSFBtdVZzS0NMeFJzMXhyeVlu?=
 =?utf-8?B?U0V2Y3hWUmh6NThVVDY1N1dRRTZUMWxRZ3lZemtGWkNVLzJ3cDBkOGVvMUNQ?=
 =?utf-8?B?UUFCZmlXOS95dC9ZSWRXcVZESERDaUhMSU9xdjZsUU52c09zZXVZdXRJWWcz?=
 =?utf-8?B?dGhGREt3NXBvaGI0SERSOWFwaVVScGUzRDQ0VngrbW0xY1ZVdDB2cm41c0N2?=
 =?utf-8?B?OWMrZFg4N0J4bmRpYXlSWng3U0FYemRhTzBWUHhwMDB5TVFMTlVGbGZQZU5i?=
 =?utf-8?B?TmdTOFYxRGhwWGxvRldzV1lpNW9qM2Z6OWVqY0pYWGI0elR1UWI0U0Jwbm1h?=
 =?utf-8?B?UmlBemlnZnRSNmNoYVlEelVWM2hKSFRrTFJTU2NpV3hTMy9iSTBKNVBvczBQ?=
 =?utf-8?B?QnNkU0xGblF5UXZIZDFrL2NVeS9RUEJNNkRUeU1xeDNvVWxIRHNzTkhOU25l?=
 =?utf-8?B?dVVVRVJVM2NMNkFkVnRwdTVnR3pFai9YYkladjlQTk9YNklrQnYra3h4NGl0?=
 =?utf-8?B?SEo1U3hlY1NpeTc5cXA4QzRBUTc0cTFya0JlNmVtR28wclRWUFo1bmdOV3R3?=
 =?utf-8?B?QldsNkFnVHhJN0ovUDF2NjVycVRXeTJVWG15U3hLR1BtWUFwR3FYTzNuZEdv?=
 =?utf-8?B?OTZRMXRQT0I5TU9tNjZuVldtOTQyaTAyUXpyeVpLNTlJbEJKa1pHbVlSWCtZ?=
 =?utf-8?B?NkEyOStKNEpqS1RoY3hFVVJ5U2FPaHg4NGNUMkJWbElvUVdZRThSSlpnR3VM?=
 =?utf-8?B?UUx6K2YzdWU5Y05mWStoQzIvRm9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <533B94255DB9B045BABF618DF3E3F702@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KWmee9cE6jM5bsm7vPnEZCPXLjVmhgKgw6FrPt770Ok4ZiTViUdQ2I2PTuqAMpvA6evXAv8D0+vHJe1CSkFbfLdrIrgYeXaixu3GsIeywDmPecC4v4k7UDZvHldLAK0on0e0Efn8acbwXDtxp1aq5xhr4q1mC69uCetYYaBXeCwYrGSyX9Y8DdPpU8M/4mkHTOJCkc2H0LoXbWM6/OCa1beZZVuTpkOnhq9uReWGEQ4pbWim5tRV0TSvdiPWE2BiYIJdxxhI4tefEFIY8n+ARXoy4ovkgXcUgVIh9bcJwYJyRM9KWjxd6so5BbqZ6YmP7+07hzZhb1FDjyhKx9m8Yc//xz4JM21bfnqdDht6oZisxzvOe0Uu3HSLSskj+oF3xVc1OEBYvtSmZgXSqea9GFZkXwq/PNi31YfDkkg+s7V0ocvJUObP+uXGAVovbVK23EQs7Tl7lZrNHGjCs1mmqKb86Y1WeaUFy91qMvYTpHRbyhmKAzYEuYF0+O6UDplGjjfoiwcJgq+VurUxKdy2kZPc/Ir+lygw/Om8Bw/fAUB/JSTWSzzb6o1vveGnvcKya0F1dfxM/4YhZ/om8Jll2tLeIUoNHCjo6Ay5d4pcORb/uIeudXaGiojFGZnoCR2M/4MwvmyuMAK8r5tPMrA/jMckd6BL/eyEJ21wDc9uJoOusck32Rn/NNTzWLpu2HBHF8ucdRclXyyjAc83/WstbevPtSyZz9Iy5IIPVbOGxjZNN6lIo3bfMqqqjvQT0y/AcKL3WGdvs/Wr74t8Bymus2uK60YYKWBlgB0buYLQBstadpSusA3sFMf9q8FvfviF5UYrmCBWrdVGjvmmFvIF39Zl9f/VWMW9zpV7V9RB4N4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f4d6a4-62f5-4c34-5be8-08db6279ffcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 08:27:12.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wftbhG14tp6iJnfivN/x/ibFQa7gzngcGFi8XbZ81KhMjUGojd9mYiPH1mEYGChZdMRe29nRQpWG6Onbq3TqgyN+WZPp5zVQQgE1W2IslJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8749
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDYuMjMgMDI6NTAsIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+IEhpIGFsbCwNCj4g
DQo+IEFmdGVyIG1lcmdpbmcgdGhlIGJsb2NrIHRyZWUsIHRvZGF5J3MgbGludXgtbmV4dCBidWls
ZCAoeDg2XzY0DQo+IGFsbG1vZGNvbmZpZykgZmFpbGVkIGxpa2UgdGhpczoNCj4gDQo+IEluIGZp
bGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L3NsYWIuaDoxNSwNCj4gICAgICAgICAgICAg
ICAgICBmcm9tIGRyaXZlcnMvbWQvcmFpZDEuYzoyNjoNCj4gZHJpdmVycy9tZC9yYWlkMS5jOiBJ
biBmdW5jdGlvbiAnYWxsb2NfYmVoaW5kX21hc3Rlcl9iaW8nOg0KPiBpbmNsdWRlL2xpbnV4L2dm
cC5oOjMyMDozNjogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiAnZnJlZV9wYWdlcycgbWFr
ZXMgaW50ZWdlciBmcm9tIHBvaW50ZXIgd2l0aG91dCBhIGNhc3QgWy1XZXJyb3I9aW50LWNvbnZl
cnNpb25dDQo+ICAgMzIwIHwgI2RlZmluZSBmcmVlX3BhZ2UoYWRkcikgZnJlZV9wYWdlcygoYWRk
ciksIDApDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+
fn4NCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBwYWdlICoNCj4g
ZHJpdmVycy9tZC9yYWlkMS5jOjExNTE6MjU6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAn
ZnJlZV9wYWdlJw0KPiAgMTE1MSB8ICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWVfcGFnZShw
YWdlKTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn4NCj4gaW5j
bHVkZS9saW51eC9nZnAuaDozMDM6Mzg6IG5vdGU6IGV4cGVjdGVkICdsb25nIHVuc2lnbmVkIGlu
dCcgYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUgJ3N0cnVjdCBwYWdlIConDQo+ICAgMzAzIHwgZXh0
ZXJuIHZvaWQgZnJlZV9wYWdlcyh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGludCBvcmRl
cik7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fl5+fn4N
Cj4gDQo+IENhdXNlZCBieSBjb21taXQNCj4gDQo+ICAgNjQ3M2JjMzI1NjQ0ICgibWQ6IGNoZWNr
IGZvciBmYWlsdXJlIHdoZW4gYWRkaW5nIHBhZ2VzIGluIGFsbG9jX2JlaGluZF9tYXN0ZXJfYmlv
IikNCj4gDQo+IEkgaGF2ZSB1c2VkIHRoZSBibG9jayB0cmVlIGZyb20gbmV4dC0yMDIzMDUzMSBm
b3IgdG9kYXkuDQo+IA0KDQpUaGlzIG9idmlvdXNseSBoYXMgdG8gYmU6DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZC9yYWlkMS5jIGIvZHJpdmVycy9tZC9yYWlkMS5jDQppbmRleCBmZjg5ODM5NDU1
ZWMuLjM1NzBkYTYzOTY5YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWQvcmFpZDEuYw0KKysrIGIv
ZHJpdmVycy9tZC9yYWlkMS5jDQpAQCAtMTE0OCw3ICsxMTQ4LDcgQEAgc3RhdGljIHZvaWQgYWxs
b2NfYmVoaW5kX21hc3Rlcl9iaW8oc3RydWN0IHIxYmlvICpyMV9iaW8sDQogICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIGZyZWVfcGFnZXM7DQogDQogICAgICAgICAgICAgICAgaWYgKCFiaW9f
YWRkX3BhZ2UoYmVoaW5kX2JpbywgcGFnZSwgbGVuLCAwKSkgew0KLSAgICAgICAgICAgICAgICAg
ICAgICAgZnJlZV9wYWdlKHBhZ2UpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgcHV0X3BhZ2Uo
cGFnZSk7DQogICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfcGFnZXM7DQogICAgICAg
ICAgICAgICAgfQ0KIA0KDQpCdXQgSSB3b25kZXIgd2h5IEkgZGludCBzZWUgaXQgaW4gbXkgYWxs
bW9kY29uZmlnIGJ1aWxkLiANCg0KSmVucyBjYW4geW91IGZvbGQgdGhhdCBpbiBvciBkbyB5b3Ug
d2FudCBtZSB0byB1cGRhdGUgdGhlIHBhdGNoPw0K
