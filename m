Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE16D07AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjC3OHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjC3OGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:06:51 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60894868D;
        Thu, 30 Mar 2023 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680185210; x=1711721210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rb4O9m+BoxcxM7H/IhLNPkKFgYfv7zgiRrMFFO/fR7I=;
  b=S9tAt/o8t1rZB7h0V4oRXu5yg041jEmvIdv6Ko7FxlUh5+ZUkxuk/w+r
   pqb+frbFb5Yb7yG3E6ky+zPtUwvQtcm9M2nQz3fXJsWOobFHqGmLw4/YR
   u7p8UyK/b3YXNX/6v1gZ3PzWyaLqpS6JIrM4mUVUjXzdq3GHDa0xW2d5Z
   yli1BluM5cVta56CAgmw/67PnlVDi3KtMypVEXLt8pnS4eHyrEDR980Ce
   MeQ7znvL/hgchlnZ+Fph0FdoGRIbLafJm2zMebjIHA1r8yBGhF/QfnCml
   ZDPEoCEUr/7QpMT34OfQHg5pfzRTwTttDY4AF3/BYbJEpVFcf5XSx3rTE
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="226885471"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 22:06:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzlPXV6FmxZHk8frOkkKmWwE0tHR6ujYeK2ptH7pGNyyOQXwIz1aSCwzsfWdOziweilBFACjQtGnhf8x+wOrI4sK7u9pwXwbhhnedo2SLm/LNr7Bl9rvvRFoLWBhytKPSCzA7tP9sT814bgM2D5VvaetCNz+NREU4V09XaEUzG3OSlWw+XiQzFTqCtT5Qv+f6blxARO4xmxuxiKsWyV5FmiryRfTswChogr604qeikaUQ3PRU8QJqQf3oYJCuHHXIEOj6l/osYNixo+xIrMjc8B4BqtWs97kuPJDpq8zK/dxdIOs2ES3NwA2KMl59QGz3USUXvurnMF9UqIJF5iitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb4O9m+BoxcxM7H/IhLNPkKFgYfv7zgiRrMFFO/fR7I=;
 b=cZbKUu2nNAMu/3AfhxWwTLgyI4OQkeKwOxAHYvM7gwF2y5D1Yo9jclLU3fxH/IXopsPtp711Z1gnMkscMVMoEK9OlkmVRQlctw6Pw+DVo99XEp77/IzHuLjISEQyJwg99k5c5m6cB3dX4HwNgIqLeijdzN+rnGxE2gST8UlAB2SwD99xL5rFp0JXBTY7CdhUsHyJIFwk5ONfYifj5XSFOWIxCz8vcA0CV6dax9vjg8iIiQ/99QnlMxE6ePHuWLSH9dPYyalu3l1WaJ0VjRQiVpWEzshYvNrZAaKYKhFVZQJHUuBM10pbiDzH0mu3z1d+pTZkrINcvy+jIyeWvDYPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb4O9m+BoxcxM7H/IhLNPkKFgYfv7zgiRrMFFO/fR7I=;
 b=BP9eWPVc9YHiBeXn6bSmkDp6cHyCePEL5V6mbXU/ey5lCFo06LePH+VCyD7JYmwuIB7tDU5arvTf5b5CM++mJwcW3CqinZ2TmYIt+SzBCztYhX8ZI346qQdUA9/iXNzZ1Oz3dQ/f3ZVfkx00FVOOSaCgd3JFvxTnyYMaMx1HDXk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CYYPR04MB8839.namprd04.prod.outlook.com (2603:10b6:930:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 14:06:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%6]) with mapi id 15.20.6254.020; Thu, 30 Mar 2023
 14:06:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZYwkm/zKpvaKgSEm32+um6tdFCK8TW6GA
Date:   Thu, 30 Mar 2023 14:06:41 +0000
Message-ID: <075597d5-86df-84df-039a-50d1c6b8ebd4@wdc.com>
References: <20230330131109.5722-1-avri.altman@wdc.com>
In-Reply-To: <20230330131109.5722-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CYYPR04MB8839:EE_
x-ms-office365-filtering-correlation-id: 3f216f59-2379-43a5-d44c-08db3127fcea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLkv6B5alWm9zKMebP6hqs8+/Vy35tPdnComz5V5MpEYcavqUEKpVdwPkCK6DlktZuKkiPNgaEnmqJLCWBBfYfYcUBaUhIawj5YS9S9gFaaqSjzbbrm2NusLb+3fOqg5ZHgYl/pRUo5/9TT76tuZFnMjVGAyy4EEGaKcigkQ1AjGfAq4XMOw2nQKMY9OSWhw4W+c5qvNIy2DGPsXYCCAT/WLQ+CBorW9UEZ6JVU+nyafv4dCuYyttU3EImRYtRyC2fzV2UFgIVjHovFGHbCMFtPVopJILCOx6J6zvdSTy5j/pSzSMxf7YT3TIN+iFwaEZCXw/PB7+VbA0dylJKkvdPcxAqpwdedLF9V10d1HER+Cpno8dWF0OnIF95I1lrN4dXZlmqDSBW6SeOFgYuYtW1Ez7/pC24qh3VPCLHIVqUJ2I8UqwTOAt9kYGOGk7FO7uxspK4MeVFc2Sw8jNDBDcBsE+g5FnlE/jfw9Kv5FHyxeMRoMz/Ju8RQSCOqnxFuAi36ENA3RTGcDq4Z3lIyd6EnAufQhImK6LXOMaKcfERl4Fmc5w97X5uxdTb9rCrB3edKtpKgegwxVYvTU5/T3goq2SZOKaYwHDzJ6wU/POpG39GAhn8KQrNJcyhW8rCegmIK+kFiDCD+3g9K5P7Gk3Qy+7SO7iiANCqV4ne8AsowdRBFZo1n5Lbct3MOjEDkL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6486002)(31686004)(54906003)(53546011)(478600001)(2616005)(316002)(6506007)(26005)(110136005)(6512007)(71200400001)(66446008)(66476007)(8676002)(4326008)(66946007)(66556008)(8936002)(186003)(91956017)(76116006)(41300700001)(82960400001)(38070700005)(122000001)(64756008)(5660300002)(558084003)(2906002)(36756003)(83380400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlVGSzk2VGl0Tk5TVG1oRC9taTE4akdjTGwwa1V5TFlRd3V1SEJNTFVOMnVZ?=
 =?utf-8?B?dTM1Znp6RFlsMlNlL3d4Z1R0QXhVUVdwUEg0TWs1RzJ4VGc2U092YjZwK1Vr?=
 =?utf-8?B?Q0FHd1VEUGl5QjE2S1JEUkZFakxnNXp3N2xSa0JlTlcxWldvMG42NzBLTkpB?=
 =?utf-8?B?N3JNRkJpeEhJajZ5d1h2bndGQXRtUlFPaEpkWm9YeE81QVdjN1Zlb0hValBN?=
 =?utf-8?B?RlN3cHBYRjN3YzFvT3NwNW9HdHNHYm4rMUZHeHJudWZJVjJYN0FiN09Sa0Iz?=
 =?utf-8?B?THBpTW9DaUQ1dVNmSnhnYm9tSk5DTzdRSDVEalNpTS9SOEtYTE9OM253YXpY?=
 =?utf-8?B?WlNCKzVWUFl5c1hmeXBnOGJwdWhpY0Z5UXp3eUpKWWdsa0V3TSt5K3c3V05W?=
 =?utf-8?B?VEwrd1hVUGtWVFZHV2pmV1hqM2hVMHU5MkFVeXhLd3A0RW9TUGcrRzVuSElO?=
 =?utf-8?B?SGx2ZkNvR3NuZFVTd2kyUkRTY2ZVaUQwYmJUUWZIZG42Uzlwbk95RmoyNk1V?=
 =?utf-8?B?cmJNVnUrSjdKc2RhZkhBRjNtYWpXaFJIVDFRanVPTGtzeDBYWmZLMmZLSlZt?=
 =?utf-8?B?U2Njb1c4Z0lldlNHNWMraTRmMXZHWlJzam16Y2g4blFQc1hhODQrVUNtdTM4?=
 =?utf-8?B?YnRuaFNyYm80WlN6bEtwdUh2SEZaRWE2R3V1aGJ6REFUSkFyVnY2dEtCMzNs?=
 =?utf-8?B?clF5SERoOGFXRG1CRzRaL01oRHIrWUlWbUF2VVovaW1QNkhVc2JGL3ZtRG55?=
 =?utf-8?B?cThQRDd1cEZLcDYxUHhJb3NvZk5QQWxyNjZaYmRkK0FGTmpGUys4UjBGcGxQ?=
 =?utf-8?B?MXJnaFV3Yjk2eVVmLzFCM3YzVHRsdkdiNlk0a201Sy9BbzZhajcxZ3I4dHg4?=
 =?utf-8?B?anJoMWFpMkFQMHQ0UkZIbmlTWVo3Nm9GN0R5MWtmOERZbEJHKzlzY2l2dml2?=
 =?utf-8?B?azFOcXl2blAxTDZpaW9OUXpRb1R1SDFEWWZaMzVOUVBsdENWWTMvR0pLRVJi?=
 =?utf-8?B?NDhlRHJXQ2dEZE82Z3JMeFc4TVcvTnk0emFSdDFTbGVuYWJWR1dtWEV1NnAr?=
 =?utf-8?B?Yi9UdjRoUlJDSVcyYU41a2JJZXpUVSt1bEozT2swQjJyalBEM3BGMTFwczZr?=
 =?utf-8?B?cWEvaDNoKy9iMGw3OW0wZVE1OXlQbUp1dlVldllHRmFYUFVrK2hMZ0svY29x?=
 =?utf-8?B?a2hMMENHc2wzQi9MYkVVTWV6UmxIRmt6ampSakFFWExqdloybWxhWFFtY0xk?=
 =?utf-8?B?Zlpud0VvN2VTUWY2TFhISWswKzROTlBTMUpXUWJ6WXROVW9MWVpjVHJ1a3Qx?=
 =?utf-8?B?WmRQTGd1WHJQd2dwckJkSytWMkxYbjZ3cHp4d0lKdGxOMFlCSUR6WnpLT0lO?=
 =?utf-8?B?RnFKZmc0anF4WFhSQWZGRzlvckZMMmVoU09EN1FBRDZSa01Uby9ZM0srVmJ4?=
 =?utf-8?B?d0xXTlpGRGUzeERUeTdTMzkxVzY4MWxma0VqUjRoK3ZNdzdVM1Z5ZjlCamF6?=
 =?utf-8?B?MXNUTTdKazdPVHRaYzVZaHJwNGYyTVNxVE5nbkpzVGJDdi9vSko5Vm5pWXRq?=
 =?utf-8?B?akRBVzFUOGcvMkVMa1A4R1oxQkNCNnRvaEoxV2M3MGxQOXdqNHZIRTJZZ3Rl?=
 =?utf-8?B?TlRiOUsyemNkNW1WY0hPK0hqd2E3YXV3U3ZqdFZndzdEclVKQ1R0cGpPLzBH?=
 =?utf-8?B?OW4xMk5nc0NjZFJlTTAxbUZnNnArWkExaGZMWkN4aHBxa1poL1ZCK1NlUmFM?=
 =?utf-8?B?bEVGSEhzYzhlNU9VZkowcmU2dEl6VlROYUJDUHRlTWkxOHVjMGx4ejRKU0tC?=
 =?utf-8?B?SnR3VzZMVVI0c2Z3cjdkM25WVkZSeUo0NjBaZiszYmlIYk44WjRnai8zaWxo?=
 =?utf-8?B?R20xdml6eHRjSWp6aHZWVVNVMmpKUHo3TW5KSEVuVzA1alYwVlN2WFBvTW13?=
 =?utf-8?B?ZEl5RFNhalBKSzZNaHI2anVqRG9QZlMrVkxRTHlneE5pWFNIMUI1cGpmemgx?=
 =?utf-8?B?YXJUSmlnMWdXTkhJb2ErTDdHQlcrSUk5b0cyVFgvOERFbmRtWmlOT3RmNk81?=
 =?utf-8?B?bGxpWkcyWHR3WVRmZ3NaVjFsRXdIVHlQdTRvV0NFU2puMkxzd2plaGZBREdF?=
 =?utf-8?B?czY1Nm5PTEJCcjA2Ny9lazJjdFFjSURuRzR0RDNhdTVNOE9YZDJqeVUxMzJs?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FDD006DF3CF54439EDE68397ADBDFF1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v05fBhyqM2maFkjQoUWYOMDINJmbRAEDObEHKGLHKvOmWTDFflHyryDNQsdI0rqKGD8N0bvVZorYAFripbq3LTkJsjP6ucyRloBHy0DAZCoRhiDB0rANsOpDw50ZvP8HupfolxMGZPhpzMrsQOwYFX2O+dCyqMpOLwMi0vxHbcD5maOBli86sTYnl3e76gz9pe2IDKegZwLyDL6RGlkHr8ZKUBtY/q60l+pRIiE/HH9UvQIGT7SbRX0ZXATr6G0WHToqIKHI1IyBeTYomY54Gr3hBAnYJIMEl317Qml4CXfEn30P2vuIFVQ7XjkiSVYX2Y7uvyCZhmce9hvE/JKS+fVjUo9DTqnMRITXCNaM/2RMYfoWGZSae4ktnjAppW+NitLCIKblt1EJlXE3Z7fbTuaBUkiSbPGk2WoIW9ljwKXC90Owlswv6lbYR1QgwadNNQ88TflCUlysq6bcXEYbJKGKQeoKC4sHfu1cstVluNtYUMNjDwA7UE4Sta0/KEqWk2bmttWQUsOR/qk5IBerfpyGshIyy4kQTKPKucUmlpjmu4CkqnqCF8InJPIfv/iweig2An2rSK9OYGpTe2qerkTPptKDTxZVyILcMCUYOQy3bulLEKC3QtzuxeHQdeNf/l2Cy2MN/SThx+TA1kL5FNmUfOL9X90Xg56DWdnjAHlSPgHh1lWXGG5Q7oZbL1J1bt/aDAtkQooFp8RxjJwi/9cJKYYww0n1UQYGU7L2kCBMozwIWLqt80FH5tzESAzLwSmTJ5qswKwjUcSIcU23KrNRhe4pSOG5ex5KUHdSYQNw2/az1W4rGzrKNv9p7s0IRpPrCu1xL34BtijVrKjiBnQ6ESKginmpMKzWhMH2v/IM6rqhU3QJ1L+RE8TY2pKAcpq3EMaDD1vaiqItMu1zRQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f216f59-2379-43a5-d44c-08db3127fcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 14:06:41.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6pC+TG3//GMehmcDHYI1/dDVqBXMlxUmm4FhglovEI+3Mu0z+l4fsTTaT/XL8VKwZTVlujLYbKAkwaBMFAmMv6yfSXYEAKwdWM3etAgTFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8839
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDMuMjMgMTU6MTEsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiArCWlmIChXQVJOX09OQ0Uo
aGJhLT5udXRycyAqIGhiYS0+bnJfaHdfcXVldWVzID4gKDEgPDwgMTYpIC0gMSwNCj4gKwkJICAg
ICAidGhlcmUgY2FuIGJlIGF0IG1vc3QgMTw8MTYgaW5mbGlnaHQgcmVxdWVzdHNcbiIpKQ0KPiAr
CQlnb3RvIGVycjsNCg0KSG1tIHdoeSBub3QgU1pfNjRLIC0gMT8NCg==
