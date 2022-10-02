Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA975F2600
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJBWdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJBWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:33:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFF357D9;
        Sun,  2 Oct 2022 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664750007; x=1696286007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q2z1WRGhGEuEgG4htCy74HHbwPqYFA1L6hRA/N4lgQ0=;
  b=O0mT86648yWoVnLEBXm9a7aZ29JYApNF5Z701dmpWk+fgbtevxZLBev9
   wjFmMu9akCwfotoa32BEk4TVzLh/ivO9fV50f7zGZuKy+P7RikMiau1U2
   RYnoKa6WH3EIQaqDIMvS4vmUipykSFAjB2yinYaTH5fRtNATtGa7LN3BM
   0+ATm4k56d8+gA6Sv9GGlth0F2u6oswZ5wgLk/Dcsdj0SxhYDTdfAW7J/
   gaTyWZMekfDKS1zkEo/6oBbB/xCM5ig7jGw5YwJDgKOCNYob7RjEBDbEr
   Eps3Jt69hne/+KMVMhSssMUCsy231zmmbeIpuheAcTvm5/2YslQhCUBx/
   A==;
X-IronPort-AV: E=Sophos;i="5.93,363,1654531200"; 
   d="scan'208";a="217976440"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2022 06:33:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHAuyO2ffyouvCJX0qTencn7ZbYHS/9tGZT8iwkKB+eSpTctM+4qfhm/66oOjtWLHG6zNjf21/11TAelQTic4VR+Smyh0V7tqeBimlwg+j5CB4K6ny+ksVyh1wCyn8VWCaMBx20QUtY74c/99zIl88ZYwBnFZV3BBE51IWJYt+xItS6UWZytxCh6LelUDNRcVIrUDem0CvnSbUT6fL3O0zp79eWMRfaZiMVFc1W2rwvrz1MC6ItoOTKUqx1AODKfs0CBd0Z+2LpkgK9Y6+vnAcC6WHvs4GUByS2elp3WQpQBcDTwaCsKbrnmSXKM1ooeqfu+gGyV1PC0KNOCDAe5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2z1WRGhGEuEgG4htCy74HHbwPqYFA1L6hRA/N4lgQ0=;
 b=KBedMRGSvc/hCWfBocYTHQPxDiWW3/TwyxjZu0xV6cajQZD6XksOKuYXaKcvHdAZKKvQJA4yRtIwBu6qbsevV07WoIP3I4MnsmvUQyyXArcL+YO9NBbrg1fRaHJo50X2syFlHshpoKuU7awHe7CrD+SitXAFvm8geJuIjG1g4ECtOzAN3r1pEl57W+pZNMac7+rTsHOfQssDk04+X7I+w4X87vVIH1VLeBhMSA3tFl8NUHu4wDe+d9MA8vp/LYZWJmgYPJmnxebt4SR5IIlGC7sNW6Cx4cycU1TkyzcaKl01sW5FKTcg4ymdlndu8DD0/38c0xW4DpAcoPZ56noCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2z1WRGhGEuEgG4htCy74HHbwPqYFA1L6hRA/N4lgQ0=;
 b=eX0riilpSAa4xBA5l6T5vYdUlX2Pk26IVqFGTVpRgI9UEGZaeSkNnIm+wgcGpx3OIM87ARldKUAYcQibZ/HhcJhBiZs3YA2NpT/LIWvC+obPji88rQgQ+FQ0flaH3oCr/KK1T56T9d16ZJBuswIeXd5Mc3ZZZJRftOhi0lKkABo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by MN2PR04MB6192.namprd04.prod.outlook.com (2603:10b6:208:e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sun, 2 Oct
 2022 22:33:23 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::b968:c64e:27cb:a186]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::b968:c64e:27cb:a186%3]) with mapi id 15.20.5676.028; Sun, 2 Oct 2022
 22:33:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>
Subject: Re: block: wrong return value by bio_end_sector?
Thread-Topic: block: wrong return value by bio_end_sector?
Thread-Index: AQHY1OWjBzzsa117J0OPrDdr/dV82q34tbyAgAKWTYCAAGggAA==
Date:   Sun, 2 Oct 2022 22:33:23 +0000
Message-ID: <7b36f881-1423-c01d-c584-806d1741081d@wdc.com>
References: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
 <8d5ffebe-39dc-b811-ce7c-9df4b5d061c1@opensource.wdc.com>
 <51C3A1EA-A746-4DA2-AFC1-D9C4C1D7B213@linaro.org>
In-Reply-To: <51C3A1EA-A746-4DA2-AFC1-D9C4C1D7B213@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB7081:EE_|MN2PR04MB6192:EE_
x-ms-office365-filtering-correlation-id: c4e875b8-85b2-485f-a883-08daa4c61da5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQnFr/tIzNvHU1/13uzxq5FLZ2vzFIp/p09biSWyEuNFP1UT3tQVbl6J3+fZXmkHl9qIk+ZXprE0xpMATvl0LSFD51mA71OOvFLneeocowezFwjJBMfxVvYJtkfYqJVi0LW/ed79Csh9Pdg5AZNAYpoR8EuGsvL3VRrq7H2zuqCmU9prpeOa3LyzP/+TDu6/K6Z9SPejBSQxuN70KbJii6ASqjJDeEtTwGLJMTkVciQd2vjKzVkw0xGeA0G8XsfYX/1L5MoXax9RSPPbKVLj3NWLYIwh6ePxEWq/s5fpx46P/t+/dUK3I4atLuz7KDGOO2j7TmTMekIm1PTmDdJuPR/99bxFdMJ8TYRsAV9zsS5igeS5HPXYfkVWFrpAPq0+Tltaql/H0PvoAf2Wg3lP91fpvtXTB/2Rx5Op2C0HEyUPwa2kWTCwUQvpPxJ/tfpnahOvhMJeJ7+giFZF+iN+GUGQSF79jrMCSqA8K7jrSKPBN7Ib+dvYvncth9TQVoZBsB6xsnjx01b7ZKZCsSuqJjfQHF+48M0+4FG1twHiV1YOr3wHEH5uC7bkouYLrGsmd7vI5c5Gg2OZ2VUgKahiXCn05wSHbqf62y4nf1aveePBWCKlOA29Il51cWMWek3N+VKf6c8CHKauoyDPUdDLqpGSmm8eVE1ovcGM8NFWWjgfcQPcWn4SqM5/H82awA882m89kKHRmBfRLYY1iPI0YB+m4VySN2b5xxifdBF5J9XENHZj1cPPcA/310Cch4SBhUv0HiGmD/Mzhq61GdC4/iFa0IjE2fBIEDr3r5RbC9OPN9U+r2SCxFze0pnxrltmgsKNg6x30nbamoW46hf9n7DcAKXGCKKbIRCn5rA7J3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(53546011)(2616005)(26005)(6512007)(54906003)(6506007)(316002)(4326008)(8676002)(91956017)(76116006)(66946007)(66446008)(71200400001)(36756003)(966005)(66556008)(478600001)(110136005)(66476007)(64756008)(82960400001)(122000001)(38100700002)(31696002)(86362001)(38070700005)(6486002)(83380400001)(186003)(31686004)(7416002)(5660300002)(8936002)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHQzb1Q1T1k0RkVUZko4d21idjg2VUZkdndrYXBVZWJlQzNacVNCSzBrSFJS?=
 =?utf-8?B?ekpmRWFSREsraG5YODdwODdLcEVMWm1yL2RIZ2dwdjlzVG1TN2ZFQkpIWGFL?=
 =?utf-8?B?azRYYUhpVEh5a0E2TXpGa0tGaGVPQmJrMzVZcHBrZ2YxRFVwaXpRMWhUUkNV?=
 =?utf-8?B?NjI2UEI0ODUxdDZiRzJxbUp5UVZHYk4xS0xlUHhmSzBudUZyZkpwTmpZeXdm?=
 =?utf-8?B?ek9UaC9ESXlWUVdLTzFMU0w1UlI2Z21IL3ZwSmY3TDJiSm9KVC9yeGp3Q3Rz?=
 =?utf-8?B?YVcyLzZSVDhsZzNDUnNCMHlOaWpoWDhSV1YwVkpsTTBmeGN5MlM3am9oMGxN?=
 =?utf-8?B?WGxxNWFvbWhmWnFUS0ExdnMrODVqVkQ2SWlxbDZ4YmROVFVqZVZGR3BPamNh?=
 =?utf-8?B?bVZmZ013QUlpOG9zNjdVT3IybG43ZGFHNVdydlVXeFM5OGhOVjBRWVJRdTBK?=
 =?utf-8?B?RlBUY3ROZGtTbkZKT3NyRzJ5YUV3N1p3Q0Q0UzdCMVE4ODRIT1A1T1BWTTZt?=
 =?utf-8?B?MTZPdHl4L2F4aWM1aGFyRjg5RTJnR09DL3kzTEY3U1c3TnFpaUV6R21menJ6?=
 =?utf-8?B?ZW1VM09XU3hHZlpOcHFER1RaaFNjTnVXd2VCL09OR01tYzRMcW8ydERwVUpL?=
 =?utf-8?B?N1QwNzh3VDFhNVB5ZEVoOXBnN1ppTi9FdE54a3RjUVd0SHAycVhZRXROcXJT?=
 =?utf-8?B?V1ltOTJHL1V5WWtJMlB3ektMUlhlMGVzUzV2dlhvbUd4ZjI2dGxicXl4UW5t?=
 =?utf-8?B?SkVRRXhRaUlnSmhEOEw0K0VGQm5oQWFVc0ZEc2FnRUc5VWFWYzZjNmp5aWgr?=
 =?utf-8?B?M00xdlJFUUZ6YUkwQXV6UFQyY2hCZ3ZGT01aeU0rQ1N0WStBRDdZUDdRRXJ3?=
 =?utf-8?B?UGFWOHk1aENSdUFvWENjc25kYlpxeTlrbHMyUlpKODR1U1pzTVMxRzgzVEJB?=
 =?utf-8?B?dTJ4V2d6Ylc1QmJtNDc1SWtYU0hMdEo0YjN1MzdEQ2k1YVlSUjNscUpvSzFZ?=
 =?utf-8?B?MWY1Q0psQ0ZvbkJzVStyN1hZZXRzVkxNU1doWThxOVhzUm9JOG13d2ozZVFq?=
 =?utf-8?B?VHdzOVczZ0VWVnFzZDZUZ1FUUmpjTE1HaW4wME5ySnRsMEtPZzRpdFllNlFF?=
 =?utf-8?B?TWNORGFmZVA4bXZ0eTNDRUpnTnZUQkFrMi9Ra3A1QXRCL1NMcGIrQlZ4T1Vq?=
 =?utf-8?B?djJHMHVYUGVCY1pualVkdVZuUXZQa01JL0U3SmtLdEhVT3MxbGpReDVodHZk?=
 =?utf-8?B?TDJUc2RaK09QeGVaeG5sd09UWjIrREZQRFhVZzJWN1BwbXd5M0FXTGxUQXFS?=
 =?utf-8?B?WUZiWkpZKy83UzN4a3VadS9kSHozSUNkWUIxRnNDL1MrUjdNZzg4dHhCT1px?=
 =?utf-8?B?UU50a3JZKytFUUo5WnpHSGNmVDhHZFhFQWJlV3lyRXJ2ZzFBQWUwUXVCSUJm?=
 =?utf-8?B?NVVoOWpsNk9YaWxydmRrZGU4Smh0OGxtUlZzUnlxbk5FckFTWkgyZUUvU29x?=
 =?utf-8?B?OUEzdlFsOEpsblVzUkkzRWxvM0dsY3RpT2RGWnRmWWJnN1pQWjlJVDlab2pG?=
 =?utf-8?B?Smk2UVJKM2ZjQS8xb2NvWTM3ZWhialEwMHFvc1pQM28wRWpqWWxPNFc2VUhN?=
 =?utf-8?B?ak1SQVpZN2JUYmZ2N05aNUFMbXRFOFBCWUxvL2M3QjZ2djMyWDQyTUVHbitQ?=
 =?utf-8?B?SFFQVjhHMng1UnZuOXNHSjR3Z1lYcTFwUVBZVThhL2xZeC94RjFmYVNJUURS?=
 =?utf-8?B?OG5iVC9KZk9CdUU0cWoyRVJJWTJPZ2ZVZ0Rnd3dUK2dqRVBRaUMwRk9IN0dJ?=
 =?utf-8?B?U2dOUld5WmNhTEdmbmpEYUErRFZBSTdnOHJvMU1SVzN0ZGMxMjlNYUtuTXo4?=
 =?utf-8?B?bGFOcWNJbnlsTlQyNDFnNlhCL0pKYjNzNlplQUJJU2pkMmdwejNmN2dQaDVT?=
 =?utf-8?B?dWh0VFRIeEU0K1VmdFhBM21NMUdOeGhiOFV3WEV3OStqMXdIUUlEV1FJcXZH?=
 =?utf-8?B?bExsZW1zaWZ4Y3NGbWJ6R3FCbVEwTTdJMlFpVDdSVWh3OHhtZnhvb0VKeVhz?=
 =?utf-8?B?cXM1dmtJUzlrYjZRQ0FYZjV6WXlFdTBJKzdqK3oraDgyY2NMb0oxY3Erdk5o?=
 =?utf-8?B?cXcyaWpnTmdwUE5CRXJ2SG9iLzcwNURyb2w1TkRtWkg0ODd1SkFOdnFJcXhv?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72012D2C46752C4B853F7AE527D83579@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e875b8-85b2-485f-a883-08daa4c61da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2022 22:33:23.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJskAGQJnkJtmMSCw9p8g4dcuhs8H5UAZ4djm2qv58u5iJjadprteANkxpFPD3gSlI15KoauHGeVZNKQYDK35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6192
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMC8wMyAxOjIwLCBQYW9sbyBWYWxlbnRlIHdyb3RlOg0KPiANCj4gDQo+PiBJbCBn
aW9ybm8gMSBvdHQgMjAyMiwgYWxsZSBvcmUgMDI6NTAsIERhbWllbiBMZSBNb2FsIDxkYW1pZW4u
bGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbT4gaGEgc2NyaXR0bzoNCj4+DQo+PiBPbiAxMC8xLzIy
IDAwOjU5LCBQYW9sbyBWYWxlbnRlIHdyb3RlOg0KPj4+IEhpIEplbnMsIERhbWllbiwgYWxsIG90
aGVyIHBvc3NpYmx5IGludGVyZXN0ZWQgcGVvcGxlLCB0aGlzIGlzIHRvIHJhaXNlDQo+Pj4gYXR0
ZW50aW9uIG9uIGEgbWlzdGFrZSB0aGF0IGhhcyBlbWVyZ2VkIGluIGEgdGhyZWFkIG9uIGEgYmZx
IGV4dGVuc2lvbg0KPj4+IGZvciBtdWx0aS1hY3R1YXJ5IGRyaXZlcyBbMV0uDQo+Pj4NCj4+PiBU
aGUgbWlzdGFrZSBpcyBhcHBhcmVudGx5IGluIHRoZSBtYWNybyBiaW9fZW5kX3NlY3RvciAoZGVm
aW5lZCBpbiANCj4+PiBpbmNsdWRlL2xpbnV4L2Jpby5oKSwgd2hpY2ggc2VlbXMgdG8gYmUgdHJh
bnNsYXRlZCAoaW5jb3JyZWN0bHkpIGFzIA0KPj4+IHNlY3RvcitzaXplLCBhbmQgbm90IGFzIHNl
Y3RvcitzaXplLTEuDQo+Pg0KPj4gVGhpcyBoYXMgYmVlbiBsaWtlIHRoaXMgZm9yIGEgbG9uZyB0
aW1lLCBJIHRoaW5rLg0KPj4NCj4+Pg0KPj4+IEZvciB5b3VyIGNvbnZlbmllbmNlLCBJJ20gcGFz
dGluZyBhIGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHRoZSANCj4+PiBwcm9ibGVtLCBieSBUeWxl
ciAoZGVzY3JpcHRpb24gdGFrZW4gZnJvbSB0aGUgYWJvdmUgdGhyZWFkIFsxXSkuDQo+Pj4NCj4+
PiBUaGUgZHJpdmUgcmVwb3J0cyB0aGUgYWN0dWF0b3IgcmFuZ2VzIGFzIGEgc3RhcnRpbmcgTEJB
IGFuZCBhIGNvdW50IG9mDQo+Pj4gTEJBcyBmb3IgdGhlIHJhbmdlLiBJZiB0aGUgY29kZSByZWFk
aW5nIHRoZSByZXBvcnRlZCB2YWx1ZXMgc2ltcGx5IGRvZXMNCj4+PiBzdGFydGluZ0xCQSArIHJh
bmdlLCB0aGlzIGlzIGFuIGluY29ycmVjdCBlbmRpbmcgTEJBIGZvciB0aGF0IGFjdHVhdG9yLg0K
Pj4NCj4+IFdlbGwsIHllcy4gTEJBIDAgKyBkcml2ZSBjYXBhY2l0eSBpcyBhbHNvIGFuIGluY29y
cmVjdCBMQkEuIElmIHRoZSBjb2RlDQo+PiBhc3N1bWVzIHRoYXQgaXQgaXMsIHlvdSBoYXZlIGEg
Y2xhc3NpYyBvZmYtYnktb25lIGJ1Zy4NCj4+DQo+Pj4gVGhpcyBpcyBiZWNhdXNlIExCQXMgYXJl
IHplcm8gaW5kZXhlZCBhbmQgdGhpcyBzaW1wbGUgYWRkaXRpb24gaXMgbm90DQo+Pj4gdGFraW5n
IHRoYXQgaW50byBhY2NvdW50LiBUaGUgcHJvcGVyIHdheSB0byBnZXQgdGhlIGVuZGluZ0xCQSBp
cw0KPj4+IHN0YXJ0aW5nTEJBICsgcmFuZ2UgLSAxIHRvIGdldCB0aGUgbGFzdCBMQkEgdmFsdWUg
Zm9yIHdoZXJlIHRvIGlzc3VlIGENCj4+PiBmaW5hbCBJTyByZWFkL3dyaXRlIHRvIGFjY291bnQg
Zm9yIExCQSB2YWx1ZXMgc3RhcnRpbmcgYXQgemVybyByYXRoZXINCj4+PiB0aGFuIG9uZS4NCj4+
DQo+PiBZZXMuIEFuZCA/IFdoZXJlIGlzIHRoZSBpc3N1ZSA/DQo+Pg0KPj4+DQo+Pj4gSGVyZSBp
cyBhbiBleGFtcGxlIGZyb20gdGhlIG91dHB1dCBpbiBTZWFDaGVzdC9vcGVuU2VhQ2hlc3Q6IA0K
Pj4+ID09PT1Db25jdXJyZW50IFBvc2l0aW9uaW5nIFJhbmdlcz09PT0NCj4+Pg0KPj4+IFJhbmdl
IyAgICAgI0VsZW1lbnRzICAgICAgICAgICAgTG93ZXN0IExCQSAgICAgICAgICAjIG9mIExCQXMg
MA0KPj4+IDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAN
Cj4+PiAxNzU3ODMyODA2NCAxICAgICAgICAgICAgMSAgICAgICAgICAgICAgICAgICAgICAgICAx
NzU3ODMyODA2NA0KPj4+IDE3NTc4MzI4MDY0DQo+Pj4NCj4+PiBJZiB1c2luZyB0aGUgaW5jb3Jy
ZWN0IGZvcm11bGEgdG8gZ2V0IHRoZSBmaW5hbCBMQkEgZm9yIGFjdHVhdG9yIDAsIHlvdQ0KPj4+
IHdvdWxkIGdldCAxNzU3ODMyODA2NCwgYnV0IHRoaXMgaXMgdGhlIHN0YXJ0aW5nIExCQSByZXBv
cnRlZCBieSB0aGUNCj4+PiBkcml2ZSBmb3IgYWN0dWF0b3IgMS4gU28gdG8gYmUgY29uc2lzdGVu
dCBmb3IgYWxsIHJhbmdlcywgdGhlIGZpbmFsIExCQQ0KPj4+IGZvciBhIGdpdmVuIGFjdHVhdG9y
IHNob3VsZCBiZSBjYWxjdWxhdGVkIGFzIHN0YXJ0aW5nIExCQSArIHJhbmdlIC0gMS4NCj4+Pg0K
Pj4+IEkgaGFkIHJlYWNoZWQgb3V0IHRvIFNlYWdhdGUncyBUMTAgYW5kIFQxMyByZXByZXNlbnRh
dGl2ZXMgZm9yDQo+Pj4gY2xhcmlmaWNhdGlvbiBhbmQgdmVyaWZpY2F0aW9uIGFuZCB0aGlzIGlz
IG1vc3QgbGlrZWx5IHdoYXQgaXMgY2F1c2luZw0KPj4+IHRoZSBlcnJvciBpcyBhIG1pc3Npbmcg
LSAxIHNvbWV3aGVyZSBhZnRlciBnZXR0aW5nIHRoZSBpbmZvcm1hdGlvbg0KPj4+IHJlcG9ydGVk
IGJ5IHRoZSBkZXZpY2UuIFRoZXkgYWdyZWVkIHRoYXQgdGhlIHJlcG9ydGluZyBmcm9tIHRoZSBk
cml2ZQ0KPj4+IGFuZCB0aGUgU0NTSSB0byBBVEEgdHJhbnNsYXRpb24gaXMgY29ycmVjdC4NCj4+
Pg0KPj4+IEknbSBub3Qgc3VyZSB3aGVyZSB0aGlzIGlzIGJlaW5nIHJlYWQgYW5kIGNhbGN1bGF0
ZWQsIGJ1dCBpdCBpcyBub3QgYW4NCj4+PiBlcnJvciBpbiB0aGUgbG93LWxldmVsIGxpYmF0YSBv
ciBzZCBsZXZlbCBvZiB0aGUga2VybmVsLiBJdCBtYXkgYmUgaW4NCj4+PiBiZnEsIG9yIGl0IG1h
eSBiZSBpbiBzb21lIG90aGVyIHBsYWNlIGFmdGVyIHRoZSBzZCBsYXllci4gSSBrbm93IHRoZXJl
DQo+Pj4gd2VyZSBzb21lIGFkZGl0aW9ucyB0byByZWFkIHRoaXMgYW5kIHJlcG9ydCBpdCB1cCB0
aGUgc3RhY2ssIGJ1dCBJIGRpZA0KPj4+IG5vdCB0aGluayB0aG9zZSB3ZXJlIHdyb25nIGFzIHRo
ZXkgc2VlbWVkIHRvIHBhc3MgdGhlIGRyaXZlIHJlcG9ydGVkDQo+Pj4gaW5mb3JtYXRpb24gdXAg
dGhlIHN0YWNrLg0KPj4+DQo+Pj4gSmVucywgRGFtaWVuLCBjYW4geW91IHNoZWQgYSBsaWdodCBv
biB0aGlzPw0KPj4NCj4+IEkgYW0gbm90IGNsZWFyIG9uIHdoYXQgdGhlIHByb2JsZW0gaXMgZXhh
Y3RseS4gVGhpcyBhbGwgc291bmQgbGlrZSBhDQo+PiBzaW1wbGUgb2ZmLWJ5LW9uZSBpc3N1ZSBp
ZiBiZnEgc3VwcG9ydCBjb2RlLiBObyA/DQo+IA0KPiBZZXMsIGl0J3MgKGFsc28pIGluIGJmcSBj
b2RlIG5vdzsgbm8sIGl0J3Mgbm90IG9ubHkgaW4gYmZxIGNvZGUuIA0KPiANCj4gVGhlIGludm9s
dmVkIGJmcSBjb2RlIGlzIGEgcmVwbGljYSBvZiB0aGUgZm9sbG93aW5nIG9yaWdpbmFsIGZ1bmN0
aW9uDQo+IChsaXZpbmcgaW4gYmxvY2svYmxrLWlhcmFuZ2VzLmMpOg0KPiANCj4gc3RhdGljIHN0
cnVjdCBibGtfaW5kZXBlbmRlbnRfYWNjZXNzX3JhbmdlICoNCj4gZGlza19maW5kX2lhX3Jhbmdl
KHN0cnVjdCBibGtfaW5kZXBlbmRlbnRfYWNjZXNzX3JhbmdlcyAqaWFycywNCj4gCQkgIHNlY3Rv
cl90IHNlY3RvcikNCj4gew0KPiAJc3RydWN0IGJsa19pbmRlcGVuZGVudF9hY2Nlc3NfcmFuZ2Ug
KmlhcjsNCj4gCWludCBpOw0KPiANCj4gCWZvciAoaSA9IDA7IGkgPCBpYXJzLT5ucl9pYV9yYW5n
ZXM7IGkrKykgew0KPiAJCWlhciA9ICZpYXJzLT5pYV9yYW5nZVtpXTsNCj4gCQlpZiAoc2VjdG9y
ID49IGlhci0+c2VjdG9yICYmDQo+IAkJICAgIHNlY3RvciA8IGlhci0+c2VjdG9yICsgaWFyLT5u
cl9zZWN0b3JzKQ0KPiAJCQlyZXR1cm4gaWFyOw0KPiAJfQ0KPiANCj4gCXJldHVybiBOVUxMOw0K
PiB9DQo+IA0KPiBiZnEncyByZXBsaWNhIHNpbXBseSBjb250YWlucyBhbHNvIHRoaXMgd2Fybmlu
ZywgcmlnaHQgYmVmb3JlIHRoZSByZXR1cm4gTlVMTDoNCj4gDQo+IAlXQVJOX09OQ0UodHJ1ZSwN
Cj4gCQkgICJiZnFfYWN0dWF0b3JfaW5kZXg6IGJpbyBzZWN0b3Igb3V0IG9mIHJhbmdlczogZW5k
PSVsbHVcbiIsDQo+IAkJICBlbmQpOw0KPiANCj4gU28sIGlmIHRoaXMgd2FybmluZyBpcyB0cmln
Z2VyZWQsIHRoZW4gdGhlIHNlY3RvciBkb2VzIG5vdCBiZWxvbmcgdG8NCj4gYW55IHJhbmdlLg0K
PiANCj4gVGhhdCB3YXJuaW5nIGdldHMgYWN0dWFsbHkgdHJpZ2dlcmVkIFsxXSwgZm9yIGEgc2Vj
dG9yIG51bWJlciB0aGF0IGlzDQo+IGxhcmdlciB0aGFuIHRoZSBsYXJnZXN0IGV4dHJlbWUgKGlh
ci0+c2VjdG9yICsgaWFyLT5ucl9zZWN0b3JzKSBpbiB0aGUNCj4gaWFyIGRhdGEgc3RydWN0dXJl
LiAgVGhlIG9mZmVuZGluZyB2YWx1ZSByZXN1bHRlZCB0byBiZSBzaW1wbHkgZXF1YWwNCj4gdG8g
dGhlIGxhcmdlc3QgcG9zc2libGUgdmFsdWUgYWNjZXB0ZWQgYnkgdGhlIGlhciBkYXRhIHN0cnVj
dHVyZSwgcGx1cw0KPiBvbmUuDQo+IA0KPiBTbywgeWVzLCB0aGlzIGlzIGFuIG9mZi1ieS1vbmUg
ZXJyb3IuICBNb3JlIHByZWNpc2VseSwgdGhlcmUgaXMgYQ0KPiBtaXNtYXRjaCBiZXR3ZWVuIHRo
ZSBhYm92ZSBjb2RlIChvciB0aGUgdmFsdWVzIHN0b3JlZCB0aGUgaWFyIGRhdGENCj4gc3RydWN0
dXJlKSBhbmQgdGhlIHZhbHVlIG9mIGJpb19lbmRfc2VjdG9yICh0aGUgbGF0dGVyIGlzIHBhc3Nl
ZCBhcw0KPiBpbnB1dCB0byB0aGUgYWJvdmUgZnVuY3Rpb24pLiAgYmlvX2VuZF9zZWN0b3IgZG9l
cyBub3Qgc2VlbSB0byBnaXZlDQo+IHRoZSBlbmQgc2VjdG9yIG9mIGEgcmVxdWVzdCAoZXF1YWwg
dG8gYmVnaW4rc2l6ZS0xKSwgYXMgYXBwYXJlbnRseQ0KPiBleHBlY3RlZCBieSB0aGUgYWJvdmUg
Y29kZSwgYnV0IHRoZSBzZWN0b3IgYWZ0ZXIgdGhlIGxhc3Qgb25lIChuYW1lbHksDQo+IGJlZ2lu
K3NpemUpLg0KPiANCj4gU2hvdWxkIEkgZXhwcmVzcyBhbiBvcGluaW9uIG9uIHdoZXJlIHRoZSBl
cnJvciBpcywgSSB3b3VsZCBzYXkgdGhhdA0KPiB0aGUgbWlzdGFrZSBpcyBpbiBiaW9fZW5kX3Nl
Y3Rvci4gIEJ1dCBJIGNvdWxkIGJlIHRvdGFsbHkgd3JvbmcsIGFzDQo+IEknbSBub3QgYSBleHBl
cnQgb2YgZWl0aGVyIG9mIHRoZSBpbnZvbHZlZCBwYXJ0cy4gIEluIGFkZGl0aW9uLA0KPiBiaW9f
ZW5kX3NlY3RvciBpcyBhbHJlYWR5IGluIHVzZSwgd2l0aCBpdHMgY3VycmVudCBmb3JtdWxhLCBi
eSBvdGhlcg0KPiBwYXJ0cyBvZiB0aGUgYmxvY2sgbGF5ZXIuICBJZiB5b3UgZ3V5cyAoRGFtaWVu
LCBKZW5zLCBUeWxlcj8sIC4uLikNCj4gZ2l2ZSB1cyBzb21lIGd1aWRhbmNlIG9uIHdoYXQgdG8g
Zml4IGV4YWN0bHksIHdlIHdpbGwgYmUgaGFwcHkgdG8gbWFrZQ0KPiBhIGZpeC4NCg0KSSBkbyBu
b3QgdGhpbmsgdGhlcmUgaXMgYW55IGVycm9yL3Byb2JsZW0gYW55d2hlcmUgd2l0aCBiaW9fZW5k
X3NlY3RvcigpLiBCdXQNCmluZGVlZCwgdGhlIG5hbWUgaXMgc2xpZ2h0bHkgbWlzbGVhZGluZyBh
cyBpdCBkb2Ugbm90IHJldHVybiB0aGUgbGFzdCBzZWN0b3INCnByb2Nlc3NlZCBieSB0aGUgYmlv
IGJ1dCB0aGUgbmV4dCBvbmUuIFRoZSByZWFzb24gaXMgdGhhdCB3aXRoIHRoaXMNCmltcGxlbWVu
dGF0aW9uLCBiaW9fZW5kX3NlY3RvcigpIGFsd2F5cyBnaXZlcyB5b3UgdGhlIGZpcnN0IHNlY3Rv
ciBmb3IgdGhlIG5leHQNCmJpbyB3aXRoIGEgbXVsdGktYmlvIHJlcXVlc3QuDQoNCldoZW4geW91
IG5lZWQgdGhlIGxhc3Qgc2VjdG9yIHByb2Nlc3NlZCBieSB0aGUgYmlvLCB5b3UgbmVlZCB0byB1
c2UNCmJpb19lbmRfc2VjdG9yKGJpbykgLSAxLg0KDQpTbyB0byBmaW5kIHRoZSBhY2Nlc3MgcmFu
Z2UgdGhhdCBzZXJ2ZWQgYSBjb21wbGV0ZWQgYmlvLCB5b3Ugc2ltcGx5IG5lZWQgdG8gY2FsbDoN
Cg0KZGlza19maW5kX2lhX3JhbmdlKGlhcnMsIGJpb19lbmRfc2VjdG9yKGJpbykgLSAxKTsNCg0K
WW91IHByb2JhYmx5IGNvdWxkIGFkZCBhIGNvdXBsZSBvZiBoZWxwZXIgZnVuY3Rpb25zIGZvciBn
ZXR0aW5nIGFuIGFjY2VzcyByYW5nZQ0KZnJvbSBhIGJpbyBzZWN0b3Igb3IgZW5kIHNlY3Rvci4g
U29tZXRoaW5nIGxpa2U6DQoNCnN0YXRpYyBpbmxpbmUgc3RydWN0IGJsa19pbmRlcGVuZGVudF9h
Y2Nlc3NfcmFuZ2UgKg0KX19iaW9fc2VjdG9yX2FjY2Vzc19yYW5nZShzdHJ1Y3QgYmlvICpiaW8s
IHNlY3Rvcl90IHNlY3RvcikNCnsNCglzdHJ1Y3QgZ2VuZGlzayAqZGlzayA9IGJpby0+YmlfYmRl
di0+YmRfZGlzazsNCg0KCWlmICghZGlzay0+aWFfcmFuZ2VzKQ0KCQlyZXR1cm4gTlVMTDsNCg0K
CWlhciA9IGRpc2tfZmluZF9pYV9yYW5nZShkaXNrLT5pYV9yYW5nZXMsIHNlY3Rvcik7DQoJV0FS
Tl9PTkNFKCFpYXIsDQoJCSAgImJmcV9hY3R1YXRvcl9pbmRleDogYmlvIHNlY3RvciBvdXQgb2Yg
cmFuZ2VzOiBlbmQ9JWxsdVxuIiwNCgkJICBlbmQpOw0KDQoJcmV0dXJuIGlhcjsNCn0NCg0Kc3Rh
dGljIGlubGluZSBzdHJ1Y3QgYmxrX2luZGVwZW5kZW50X2FjY2Vzc19yYW5nZSAqDQpiaW9fc2Vj
dG9yX2FjY2Vzc19yYW5nZShzdHJ1Y3QgYmlvICpiaW8pDQp7DQoJcmV0dXJuIF9fYmlvX3NlY3Rv
cl9hY2Nlc3NfcmFuZ2UoYmlvLCBiaW9fc2VjdG9yKGJpbykpOw0KfQ0KDQpzdGF0aWMgaW5saW5l
IHN0cnVjdCBibGtfaW5kZXBlbmRlbnRfYWNjZXNzX3JhbmdlICoNCmJpb19lbmRfc2VjdG9yX2Fj
Y2Vzc19yYW5nZShzdHJ1Y3QgYmlvICpiaW8pDQp7DQoJcmV0dXJuIF9fYmlvX3NlY3Rvcl9hY2Nl
c3NfcmFuZ2UoYmlvLCBiaW9fZW5kX3NlY3RvcihiaW8pIC0gMSk7DQp9DQoNCm9yIHNpbWlsYXIu
IFRoZW4geW91ciBjb2RlIHdpbGwgYmUgc2ltcGxlciBhbmQgbXVjaCBsZXNzIHdvcnJpZXMgYWJv
dXQgb2YtYnktb25lDQpidWdzLg0KDQo+IA0KPiBUaGFua3MsDQo+IFBhb2xvDQo+IA0KPiANCj4g
DQo+Pg0KPj4+DQo+Pj4gVGhhbmtzLCBQYW9sbw0KPj4+DQo+Pj4gWzFdIGh0dHBzOi8vd3d3LnNw
aW5pY3MubmV0L2xpc3RzL2tlcm5lbC9tc2c0NTA3NDA4Lmh0bWwNCj4+DQo+PiAtLSANCj4+IERh
bWllbiBMZSBNb2FsDQo+PiBXZXN0ZXJuIERpZ2l0YWwgUmVzZWFyY2gNCj4gDQo+IA0KDQotLSAN
CkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0YWwgUmVzZWFyY2gNCg0K
