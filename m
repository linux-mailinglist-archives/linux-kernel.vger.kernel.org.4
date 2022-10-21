Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445DC607457
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJUJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJUJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:42:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED42582C5;
        Fri, 21 Oct 2022 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666345329; x=1697881329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pLBHDodTC7QFTPVmF9yzHViII2UepZpmjrOMylF4aeg=;
  b=ISCbBOyrx85dALewvYuIFMOOpT5hgdmMZysJtaZxA4sfcX6jRKXRtxRR
   c4LRQN83elO4Wdgy6nP/AVxFuXuj3bF181MTYGC9HzLBPdLcO8aSb9646
   3tXtFFnhJ7kL//C2GWSJxR5xLkkshrimmGMqiTC+HMrB7zchHIIqkh+pg
   wm5aWDSs7AVouXGbNMaiQZq2DNZfm8vibzGiVa1Azr6lfqO3UfnXPJKPE
   ug0J5cgtsdmVCkD9HxuTuetwB+NbUEiv9+UzvdE5a1oafCfsYLKRhto/1
   yKAx72BLked14ULwWjhMX8NBWMQpeFQCfgMhcsJB7W6/d2M6gjGpGO2BJ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326534612"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 17:42:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLDndd4+GR6aheusSHYoQtUw4EDNhxu14TEVE+Mo3V4T1VII9Bi+QdsmzmE5E5LsNZCLzabEK9LrsNiuNIi1jD+NOl6bKYA+oB/oMDTFSffhJAg21CC4/uVaFxIHscKvlpvd8+0htzOjWyxdnMgyA/y4j7pKFgyWfh/oKzX/ha6Jz8T8QeHdv6xP0hJryRvkyYd9leDvDX3TOQeGdArBwW6b1E9WkmDPd0pFhvzO8qZMSp/cM68u7gzG5xWBmpZ3Oj3f9o2sT3p/NxYNLwdxZADRk709XBK3tjYDim79t12wPLAWOawLdbCnADaM3W6RsHNVz8LtPwQVXom/RUOQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLBHDodTC7QFTPVmF9yzHViII2UepZpmjrOMylF4aeg=;
 b=fKLkZ+A2bNW/kjHMurp6yCrjBSEAbz7EW2TVaem7NsjURlhSGE981X5RPYYPIYALN1hvFXtuAypdW+vKmugnRgJgYHOw9kL3IENK91BpppCsyJEJims2Ry/ubByGJMFGOkorzfPgVOmeYEO8NUyGeec5S83TkWHDjqUVsjtXP+QyfdP9aok5ZzRjs3uinLBiRMib11jBks/j/IGd1c3yDe4yuzmqy1kldBg8o/D9LuInzRNH3MBmk8EUEwhLbjMuUi80exQHL64DPe319U7jUb5emleq473y8PRa2IeI9SfXAZb+5HlFQYr0unpFPYhFVco1pwli31ffQB6Xi8zOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLBHDodTC7QFTPVmF9yzHViII2UepZpmjrOMylF4aeg=;
 b=rd8QZVAsPBUtqj1Nu5aph3yv6UIs5o4tTY8xn3byWmTUe0G2vCi5bnYFIVrL+li7J+3Dc3bwjm7WrPnJeBDm7DdBLknUqJKCawXQTZVu16tdHkMlq8iSRecLJNjlXGDyxG/t7rmkYCyPOQ7qpxF6ReBfju4BFSe9f29DiakmFFE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7357.namprd04.prod.outlook.com (2603:10b6:a03:29c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Fri, 21 Oct 2022 09:42:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 09:42:05 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kch@nvidia.com" <kch@nvidia.com>
CC:     "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: RE: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Thread-Topic: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Thread-Index: AQHY5R8LjAfzINe2RUKeCleP0ytrqq4YmBig
Date:   Fri, 21 Oct 2022 09:42:05 +0000
Message-ID: <DM6PR04MB6575BC905136BF3483DE3304FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
In-Reply-To: <20221021073025.18831-1-wenchao.chen666@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7357:EE_
x-ms-office365-filtering-correlation-id: c445ef99-ca28-47a8-621f-08dab34883ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mca+JiTbODDgRmPlhgQIp+a00ogEftqT5/TldzfV54cO1M5wsf2R+2pm4EvCROp6KCWKrMUYNdV9PfLUeBDZbSwFUuiC8jgKdOb3h+kZW9aP6HEt0szD7GF+IxFea14Dg/nN2yOiF2jOCnPfF6j3kaXSyW1oymL2rQ0Vm+hLej2SjvdQLEqHbctTh5CgpyKp7+h55gz3Q9JptdjM3t2jpExOcRUk/8K3+YJ/MBIRuSFRk4UEpdks9/TfltdSsWcEgcWR+qk9OZ9YvNTX6PMJPxhWUghf+J737ePZzvMWGuGatqHw6dngaHl/xs6xHeGw6nk373olHzN34hs7Ff1gUF7hJql+hQ5Lg/9OBJ8T9Tq013MteXcd79JevVvcw9Q77YXtUHhNUauQbBO+4BrP7tnaXp7+8at1+w6cPSz4KoNgrvtxhZRnUiZJVo66K0zE3pruVE80t4NsSbn+USz8v1hdH4tPo4HnqUA5UHAtv+QjGHXdu3QwTgqh4cq4ck9zMWufcXy9GDIMtkqH3vMP+6s6VgmSX/I1qnNJldOhfSYaphIIT0zsi3PQnSgL5LORCBn39WCxTg1GHFPw0VcP2Jn+UeMteba0y70SN94juwjyFdSn6jb2w4IDswjXPcdrFCdS2IbOsfbu3NzMX290tjcvvVONGWfX16ag+XgKYyGWvgAnxC/PXmcbefqqKn6qAsS73F9uEgdoWscpVGvCTV0UCPE+797L8o3b5TJ+d5QLRMT3UTJ3deYkhdp+8pm2VtehJuyrt6/b7jpL2KGRddva1O/ojT9i/kqtIjHLNk0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(71200400001)(66899015)(83380400001)(55016003)(41300700001)(966005)(86362001)(76116006)(52536014)(66446008)(66556008)(66476007)(8676002)(478600001)(64756008)(4326008)(82960400001)(38100700002)(9686003)(122000001)(54906003)(316002)(33656002)(7696005)(8936002)(2906002)(38070700005)(66946007)(186003)(6506007)(7416002)(26005)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cExpZHlJdFovVlRuVnVYT2cvbFV5TnZvbFBUdE8rWUJWUURIT0lobndHb0Qz?=
 =?utf-8?B?SGErcVBhMUkyWFVtdDZOUkVzUzl4ODVSRVNhbWE1UURYbzRNMUd1VE1tV0lI?=
 =?utf-8?B?RkJHYXZyMmJYVFR5cytUOW9qVlJleG0wUHQyQUNNY0Z1SmxBT2Erei9kSDBm?=
 =?utf-8?B?bkloYjVoazVvaVpIUStMK2cwSVBkYk5SZG94ZlJqVmtPVjNackJmaGw3R1dK?=
 =?utf-8?B?TGowaDJXTWdoYUZSLzJ2Sm5ZMWJ3Nm1TREVvWkZKS3didk55VWoyWHlHejZK?=
 =?utf-8?B?TGtsc1hyQS9hUFdSSWQydnZOMWZKangyZUlYQ2JCOERVRklrT09xRllvN0Nn?=
 =?utf-8?B?OGhpN0haUUU1K016WjNMTVQ4Y3c2ZDNkM0VqZjJnZXZQU3VjbUNHUGZtbzNN?=
 =?utf-8?B?UzZLZmowd004L2JkOTN4NW5wNzZXc2FCOTVjME45WDUvMjVha284d1UrM3pu?=
 =?utf-8?B?NFRhanlXYTdRSmRwbzV0V2dKT096WitKSENzcENhdi9LUzdZUFo4dldIcWY3?=
 =?utf-8?B?SWhvdlNud20yNzRnc0RZalpXQzhGQ1U4QjR4MkFaTnZsY2ZpR0FrSEN0NlFm?=
 =?utf-8?B?YUozNmNPYjUrSjlrd0xJc3k1b09WOTJIeTJMWk9VSGthMnZqUDlyamNJK08w?=
 =?utf-8?B?bnRucytaL0p0Yi9SNXA3NEN6Vm42UmVReEQ1aFVILzgyKzJ0bCs2aWJPYk5j?=
 =?utf-8?B?VmVOU05rWDY5WGVGVUdFSWUxS0h6Z1FJRmdYdkxyTjFKMUdkVW9KaHdZbkx5?=
 =?utf-8?B?N2ZOdmsyaDU4Y2lDcjc2MEZYTVQ3SVFEUzN2bVphWjAvejByRDdnOWxsTnVq?=
 =?utf-8?B?OER3c1RLQXNpa1dVV3I1UkkzRTRubU1qaGVoSjY0N1MrMnQyRzBJcnZpNWZi?=
 =?utf-8?B?SUptKy9vb0ZnSENWaGY4MEQzdUh0V1drU3FFbHZPVGRWbzlJdWNxTVRFdWlI?=
 =?utf-8?B?L0FvU0Y4R3lSaHBUU1k3dXh1eHltMExETUMvT1NTSWtwRHhXcGgrdDQ1RnB3?=
 =?utf-8?B?SEhlUHVLdU9RMUpCWGxOQnFJczE2eFM1OW1kUUtJcTBRUWRaaCtqY3J3T1ZB?=
 =?utf-8?B?MTN1RWE1UU5RcG1XVDJtK0R6d1ljRFYyK3JxVVNSZ1NBeW9aZzB2TnpVamVT?=
 =?utf-8?B?cDdMV0x2ZU1FbkcwVzUzM1JZMEpEMFFkNlBJY0FQOUM5UHhZNjRKckhBRFF5?=
 =?utf-8?B?ZTk1Ym15dFFGSXVYUGVxTTFUZ3h3N1U0RStGbGxBdUtCNVlqUlZaajZzdVF1?=
 =?utf-8?B?QlB6N1FoQmhNaFRzY3RMQzFFWW92WGhaWTBTM094K1BFUlZ6a3NaZzZYYWll?=
 =?utf-8?B?VlFsNUlKY0ZpSnJ3NHZDU0NpN0p6bWg1YTN0RHZDd1orNTM4MnZWdit2QUUv?=
 =?utf-8?B?QkRyMFVyelViaHpJdU5QZkFRY2dYMW9wWGZZK0p5NjF3eU8vTElITDhLZHFF?=
 =?utf-8?B?bHNHcjZmV1plK1lpMEFnYWt3TmZRYk5QUzZvMWFyYzdjem5DRlMvb3RBM3dD?=
 =?utf-8?B?ZldlUUVwYlRTbEtpdnllaVdORTlNUlIrQVVNY1JwaXZDMzFJc2hDc2t4Zmtz?=
 =?utf-8?B?V3V0eXd4NmtVTW9STHRrdnBzS3FzcmhCaUJHeDhnMTU1VzBvNWtra1dKV3RU?=
 =?utf-8?B?cm4xdUI0c1IzdTNrT3A4RHpPMnNqcnRsVkhkVU5VNnNuN21LTk1JZlFZSEty?=
 =?utf-8?B?aElDak5KRzBvS1BWbXpBVjF6b2lUZy90YXU3YXNVdjdhWWZVSWVla056Qllv?=
 =?utf-8?B?RmRQZzEyTVJQNno3Q2lES2pJelpKYmhkc1NZZ3pqekZBT003bHJHaVBLd0Y5?=
 =?utf-8?B?VUZZdVN1cUY4QTQ1QTJLNjZvd0xaVEoxak83d0ZYMW1DeW5wVDV5eUpIY3BE?=
 =?utf-8?B?TFViaFJIR1NUUHdYNVcwMXFPSnQzaVhQVmRZMDR2UzhwZ2R1aEVZMEtDK2Mr?=
 =?utf-8?B?K1UxbTE1ekpWRlZCelRCSGNhZi9WY0g5SkE4M0dNYStsWGxVclJSY1Z0MEZ0?=
 =?utf-8?B?Nys5TTJKY2VKRCt4dVN4YjFhSGJsSmdqZGZHOEtOb04wdjhOcUhGb3kvTm9w?=
 =?utf-8?B?SlB1dFA5QnczTHU0TTZOQW5acmlnZmJVVjV6a2k3NGNpQlgybzdRVWVHMWJY?=
 =?utf-8?Q?sPZ01RGoAKgK5JBlm/Xy/ix87?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c445ef99-ca28-47a8-621f-08dab34883ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 09:42:05.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sc24o5nEVf+c86rY5D0vD7YGhof0NDtThX5V9vya8rCQyP0uMLN0Z0a17smOtmBpeNeGIlpsmOm9L03uQGVNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7357
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gRnJvbTogV2VuY2hhbyBDaGVuIDx3ZW5jaGFvLmNoZW5AdW5pc29jLmNvbT4NCj4gDQo+
IFN1bW1hcnkNCj4gPT09PT09PQ0KPiBUaGVzZSBwYXRjaGVzWzFdIHN1cHBvcnRzIHRoZSBob3N0
IHRvIHR1cm4gb2ZmIEZVQS4NCj4gDQo+IEFib3V0IEZVQSwgcm91Z2hseSBkZWFsIHdpdGggdGhl
IGZvbGxvd2luZyB0d28gcGFydHM6DQo+IDEpIEZVQShGb3JjZWQgVW5pdCBBY2Nlc3MpOg0KPiAt
IFRoZSBSRVFfRlVBIGZsYWcgY2FuIGJlIE9SIGVkIGludG8gdGhlIHIvdyBmbGFncyBvZiBhIGJp
byBzdWJtaXR0ZWQgZnJvbSB0aGUNCj4gICBmaWxlc3lzdGVtIGFuZCB3aWxsIG1ha2Ugc3VyZSB0
aGF0IEkvTyBjb21wbGV0aW9uIGZvciB0aGlzIHJlcXVlc3QgaXMgb25seQ0KPiAgIHNpZ25hbGVk
IGFmdGVyIHRoZSBkYXRhIGhhcyBiZWVuIGNvbW1pdHRlZCB0byBub24tdm9sYXRpbGUgc3RvcmFn
ZS4NCj4gDQo+IDIpIEluIGVtbWMsIEZVQSBpcyByZXByZXNlbnRlZCBhcyBSZWxpYWJsZSB3cml0
ZS4gY29kZSBzaG93IGFzIGJlbG93Og0KPiBzdGF0aWMgdm9pZCBtbWNfYmxrX2RhdGFfcHJlcChz
dHJ1Y3QgbW1jX3F1ZXVlICptcSwgc3RydWN0IG1tY19xdWV1ZV9yZXENCj4gKm1xcnEsDQo+ICAg
ICAgICAgICAgICAgICBpbnQgcmVjb3ZlcnlfbW9kZSwgYm9vbCAqZG9fcmVsX3dyX3AsIGJvb2wg
KmRvX2RhdGFfdGFnX3ApIHsNCj4gICAgICAgICAuLi4NCj4gICAgICAgICAvKg0KPiAgICAgICAg
ICAqIFJlbGlhYmxlIHdyaXRlcyBhcmUgdXNlZCB0byBpbXBsZW1lbnQgRm9yY2VkIFVuaXQgQWNj
ZXNzIGFuZA0KPiAgICAgICAgICAqIGFyZSBzdXBwb3J0ZWQgb25seSBvbiBNTUNzLg0KPiAgICAg
ICAgICAqLw0KPiAgICAgICAgIGRvX3JlbF93ciA9IChyZXEtPmNtZF9mbGFncyAmIFJFUV9GVUEp
ICYmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJxX2RhdGFfZGlyKHJlcSkgPT0gV1JJVEUg
JiYNCj4gICAgICAgICAgICAgICAgICAgICAgICAgKG1kLT5mbGFncyAmIE1NQ19CTEtfUkVMX1dS
KTsNCj4gICAgICAgICAuLi4NCj4gfQ0KPiANCj4gUGF0Y2ggc3RydWN0dXJlDQo+ID09PT09PT09
PT09PT09PQ0KPiBwYXRjaCMxOiAgZm9yIGJsb2NrDQo+IHBhdGNoIzI6ICBmb3Igc2RoY2ktc3By
ZA0KPiANCj4gVGVzdHMNCj4gPT09PT0NCj4gUmFuICdBbmRyb0JlbmNoJyB0byBldmFsdWF0ZSB0
aGUgcGVyZm9ybWFuY2U6DQo+IDEuIGZ1YV9kaXNhYmxlID0gMQ0KPiAvc3lzL2Jsb2NrL21tY2Js
azAvcXVldWUgIyBjYXQgZnVhIDANCj4gSSB0ZXN0ZWQgNSB0aW1lcyBmb3IgZWFjaCBjYXNlIGFu
ZCBvdXRwdXQgYSBhdmVyYWdlIHNwZWVkLg0KPiANCj4gMSkgU2VxdWVudGlhbCByZWFkOg0KPiBT
cGVlZDogMjY2LjhNaUIvcywgMjY1LjFNaUIvcywgMjYyLjlNaUIvcywgMjY4LjdNaUIvcywgMjY1
LjJNaUIvcyBBdmVyYWdlDQo+IHNwZWVkOiAyNjUuNzRNaUIvcw0KPiANCj4gMikgUmFuZG9tIHJl
YWQ6DQo+IFNwZWVkOiA5OC43NU1pQi9zLCA5OC43TWlCL3MsIDk4LjVNaUIvcywgOTkuNE1pQi9z
LCA5OC43TWlCL3MgQXZlcmFnZQ0KPiBzcGVlZDogOTguODFNaUIvcw0KPiANCj4gMykgU2VxdWVu
dGlhbCB3cml0ZToNCj4gU3BlZWQ6IDE5OS45NE1pQi9zLCAxOTkuMU1pQi9zLCAyMDUuNU1pQi9z
LCAyMDYuNU1pQi9zLCAxOTEuNU1pQi9zIEF2ZXJhZ2UNCj4gc3BlZWQ6IDIwMC41TWlCL3MNCj4g
DQo+IDQpIFJhbmRvbSB3cml0ZToNCj4gU3BlZWQ6IDY4LjZNaUIvcywgNzEuOE1pQi9zLCA3Ny4x
TWlCL3MsIDY0LjhNaUIvcywgNjkuM01pQi9zIEF2ZXJhZ2Ugc3BlZWQ6DQo+IDcwLjMyTWlCL3MN
Cj4gDQo+IDIuIGZ1YV9kaXNhYmxlID0gMCAoZGVmYXVsdCAwKQ0KPiAvc3lzL2Jsb2NrL21tY2Js
azAvcXVldWUgIyBjYXQgZnVhIDENCj4gSSB0ZXN0ZWQgNSB0aW1lcyBmb3IgZWFjaCBjYXNlIGFu
ZCBvdXRwdXQgYSBhdmVyYWdlIHNwZWVkLg0KPiANCj4gMSkgU2VxdWVudGlhbCByZWFkOg0KPiBT
cGVlZDogMjU5LjNNaUIvcywgMjU4LjhNaUIvcywgMjU4LjJNaUIvcywgMjU5LjVNaUIvcywgMjUz
LjVNaUIvcyBBdmVyYWdlDQo+IHNwZWVkOiAyNTcuODZNaUIvcw0KPiANCj4gMikgUmFuZG9tIHJl
YWQ6DQo+IFNwZWVkOiA5OC45TWlCL3MsIDEwMU1pQi9zLCAxMDFNaUIvcywgOTlNaUIvcywgMTAx
LjFNaUIvcyBBdmVyYWdlIHNwZWVkOg0KPiAxMDAuMk1pQi9zDQo+IA0KPiAzKSBTZXF1ZW50aWFs
IHdyaXRlOg0KPiBTcGVlZDogMTUzLjdNaUIvcywgMTQ2LjJNaUIvcywgMTUxLjJNaUIvcywgMTQ4
LjhNaUIvcywgMTQ3LjVNaUIvcyBBdmVyYWdlDQo+IHNwZWVkOiAxNDkuNDhNaUIvcw0KPiANCj4g
NCkgUmFuZG9tIHdyaXRlOg0KPiBTcGVlZDogMTIuOU1pQi9zLCAxMi4zTWlCL3MsIDEyLjZNaUIv
cywgMTIuOE1pQi9zLCAxMi44TWlCL3MgQXZlcmFnZSBzcGVlZDoNCj4gMTIuNjhNaUIvcw0KPiAN
Cj4gQWNjb3JkaW5nIHRvIHRoZSBhYm92ZSBkYXRhLCBkaXNhYmxlIEZVQSAoZnVhX2Rpc2FibGUg
PSAxKSBpbXByb3ZlcyB0aGUNCj4gcGVyZm9ybWFuY2U6DQo+IDEpU2VxdWVudGlhbCByZWFkIGlt
cHJvdmVkIGJ5IDMlLg0KPiAyKVJhbmRvbSByZWFkIHdlcmUgZG93biAxJS4NCj4gMylTZXF1ZW50
aWFsIHdyaXRlIGltcHJvdmVkIGJ5IDM0JS4NCj4gNClSYW5kb20gd3JpdGUgaW1wcm92ZWQgYnkg
NDU0JS4NCj4gVGhlcmVmb3JlLCBpdCBpcyByZWNvbW1lbmRlZCB0byBzdXBwb3J0IHRoZSBob3N0
IHRvIGNvbnRyb2wgRlVBLg0KPiANCj4gUmVmZXJlbmNlDQo+ID09PT09PT09PQ0KPiBbMV0NCj4g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXguZ2l0L3RyZWUvRG9jdW1lDQo+IG50YXRpb24vYmxvY2svd3JpdGViYWNrX2NhY2hlX2Nv
bnRyb2wucnN0DQo+IFsyXSBFbWJlZGRlZCBNdWx0aS1NZWRpYSBDYXJkIChl4oCiTU1DKSBFbGVj
dHJpY2FsIFN0YW5kYXJkICg1LjEpJycNCj4gDQo+IFdlbmNoYW8gQ2hlbiAoMik6DQo+ICAgbW1j
OiBibG9jazogU3VwcG9ydCBIb3N0IHRvIGNvbnRyb2wgRlVBDQo+ICAgbW1jOiBzZGhjaS1zcHJk
OiBlbmFibGUgZnVhX2Rpc2FibGUgZm9yIFNQUkRTREhDSQ0KDQpSZXZpZXdlZC1ieTogQXZyaSBB
bHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQoNCj4gDQo+ICBkcml2ZXJzL21tYy9jb3JlL2Js
b2NrLmMgICAgICB8IDMgKystDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXNwcmQuYyB8IDIg
KysNCj4gIGluY2x1ZGUvbGludXgvbW1jL2hvc3QuaCAgICAgIHwgMyArKysNCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiAtLQ0KPiAyLjE3
LjENCg0K
