Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB486BE0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCQFjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCQFi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:38:58 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 22:38:56 PDT
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD327460BB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679031537; x=1710567537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AXbSmALrRFNjpVWAJW61aUbg+wRIgHKHoco4M9EUFvM=;
  b=w/UXfzxSQk+yfkOE6iP9yyDjwiUQTZ8qDRyKTm/SBtQMvAnYbM4EOBbu
   sQQoNvleJ9jyl/4RBTytbatH7N7cBZI1d1qyVxMOan3iHYMqZitrt3hBi
   V4GjJxZ8Bw3PEVma76hIohb7mWYs0KO4RYJXBPWlRuS6YPHb2mGqdThc4
   ZA+GERVOp/5tCJm4atXPrV/OCn4Hn3XBs4kO1ZWCCdPAFVGPN86iCxwJd
   84Uxji1v9+u+aF7eUa+z3KSXV68PXDrf8Prc7OTQDTCSQpouZwR+a+uHw
   22griYrYCw2i3Y6JIIsPoVXrU74TtVGqrOEVWvSxiJlYhMQHCe/6/5Af7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="79574712"
X-IronPort-AV: E=Sophos;i="5.98,268,1673881200"; 
   d="scan'208";a="79574712"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 14:37:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp46JOXkYhYnNbMG6+FXiyKWOEGQGOBY0TpQ7Io2PSz0dEXKPYu4tqqXJmiHpk+pp2SIfbZY8UGXSfPZ4jg5xWSlOYNzo0MT6az2oh+QV1DF780hG/2qSOXEkO8mxE7XF5e6JslNAbMy6/19w7Ke3PMlictSTqXwWtuRkqe4OW5GbxuzP71aQwecRHiEvqFL6GezAtbU3a0PpOt27UkS+Ds8CMSK9fkzYhOzlFW9bBHANt4QNMGUc32fCXfQEA2IhybgzXqe/rQiFi8xgHq4RWle2teXTULprD3myJLojYYqcNOKzH/HLLxWUIrSDT5Ixao8JtjZv7MPJiwnoO/8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXbSmALrRFNjpVWAJW61aUbg+wRIgHKHoco4M9EUFvM=;
 b=CWfEYU1T4FXxlXzZc/TnQygCdxGGG/x13bXWoyedVqgq4dZi56yb8jmeAN8TUjKYze47S/lUPx7IclhzkWe8PtcTlQaan9BKYcV5sQNcL26v8sb68zNyWfCu6Ra7mPUtqKxh6MyxlhWqM+KqI1ZspUcQga/QsZbykQtcCX7xMxYIEzZg+B7DACb3Jwi+SBr8WcwFhlt7EtgGjyP85tAI3GAnkRKTWQEmPFPbNPFZFeMBhUtk/h5ooD2T2L9NiOX8o21a7IvdaIlhIUxY5VJ8Hn+f3CdUm61KXKc50Y9PGiNFmQoGwObxUZXcMvduWypmRVamGhPD5WgvrMO3ehdvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10399.jpnprd01.prod.outlook.com (2603:1096:400:244::9)
 by TYCPR01MB5805.jpnprd01.prod.outlook.com (2603:1096:400:44::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 05:37:47 +0000
Received: from TYCPR01MB10399.jpnprd01.prod.outlook.com
 ([fe80::7532:1424:bac5:7688]) by TYCPR01MB10399.jpnprd01.prod.outlook.com
 ([fe80::7532:1424:bac5:7688%3]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 05:37:47 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Topic: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Index: AQHZV+LVN1DLpX/+y0yTP+b0+z/XPa79j4OAgACkEICAAAyFAIAANVYA
Date:   Fri, 17 Mar 2023 05:37:46 +0000
Message-ID: <097e4c57-1556-e93a-49d8-2b14b7ce7cb9@fujitsu.com>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
 <6413cfec1b2ed_26992949b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6413cfec1b2ed_26992949b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10399:EE_|TYCPR01MB5805:EE_
x-ms-office365-filtering-correlation-id: 25e01a75-d559-45ab-2bee-08db26a9bd52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fN5ozovUWcFngeh3f64TEa0VDxuUoBlu3p/YIQyybHeEEgP6Dcot23Q02fEnbaC8stqUTWD4kFTxGd6lzGiiNMSBZYrI1b2xunrr3SZ+LGDfULgHzBILEV0qDS4o2Y60tSa4jT8HilttkI4Beyp6Icg3We6txbsweTPtTWBwsZ9DTJ1BoRx097hcCwE111/YX/lLTshm3uN5OElNC+vL7SzbhaGAcQNIJwwXHd216l0dqwME8ndA512p8V4TcyEjr+g1H3+nUuq2kR82roWZnlB8qXRtmiltsg6hOk28hTGf6U8zexmcf1jrgvB+V3FuqpKehMYP9DFRIANrmNylqcsmfQgA0khdCW06lV+gpn/G8jXDNmnclmYBVr3ZLlygkilCJytoGlyWbRwPlBV0/BpD5D5hwhUyU3o2lZpNolZJ1IOXaa2/MVRNqOpdn0OW3T2u1shDJEIJXx3jCgl9WpJXryWM1r9lJOx7U0U6omYWxjCRC+mIdAlNZtCUkpD5hprVZJG+1qS2lHQ2JlH6ZA3OE94MoypDYRV1DxoBTbuu9w06otA4l1y9/0lLTghcWPvQiggT/SpGv9dYLdXm2MrlPPrnUInlwteMnc3vS+JWL7zx+80yQna+RscNXrcwl9v4vlsV0ZzFWtdBbNcKXu7UVkGi+kQotqFUKd+D9MaWWeS5gVYRx5We8bZEkDbq1Wa8g4UTXbwksVe0OHl1clVymibk/Ae2k7ZfC4t2uhwHEAwfu178dzIoD+j1c+2Q9tuE5ebvo+LsjrLN69CvBeYvskkMQYNnKcy7rkV+X64aZjdNqcVvdGudy7mfdTZO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10399.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(1590799015)(451199018)(86362001)(31696002)(85182001)(38070700005)(38100700002)(36756003)(82960400001)(122000001)(8936002)(2906002)(41300700001)(5660300002)(4326008)(26005)(6512007)(6506007)(2616005)(186003)(53546011)(83380400001)(316002)(110136005)(66476007)(66556008)(64756008)(91956017)(66946007)(6486002)(966005)(71200400001)(478600001)(8676002)(66446008)(76116006)(1580799012)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZhMUwybFp3UlRIMEgrOVM2MEg4VlRSay9JOU8wKy91V0FzR3ZvdDBsNlNy?=
 =?utf-8?B?ZVVtUVE5emlpSHV2YlhlMzZ4blJOSEd3L3lCaHErSTdXclUxK2RlazMwNHZY?=
 =?utf-8?B?QTVBWWZQNXhsbEpDcTN5blBPUjZvK0FXOURyNDdsL1JKcld0OWdlcjA3b2g0?=
 =?utf-8?B?dWV1VWU5M0Q4cFhZMFp3YW1DellyTlNOQ1hLQ2JzZVRaTFF4RXVtMldrY1BG?=
 =?utf-8?B?cDkzNTJlQU51VW1MRXRQdHhHU0hzRlp3bG54RGF6MWhRTitpYnFTdjFsRVhE?=
 =?utf-8?B?YzI5M1JoMGEwNmRuZWxmNGV2SWNTKzZLREVXSmg3Nk9nOVQ0bjVNeGE5WUla?=
 =?utf-8?B?MHRYOHJSNU5rTE9SWnNuVEg3VDdhcmxWUE51VGgvZGVGSUY4bkwrV3pzS3Fx?=
 =?utf-8?B?QjcveGRialFrVnNmU04wc29zM1h0NXNiN0JBejE0NnJqVnFDRU00Rzd4Q054?=
 =?utf-8?B?Rkl3Tnk4Y0tOOTlvSWJyKzdZTlJSNFZEUFY3K2hwaHhpWGR1d1J0TTlBbG1l?=
 =?utf-8?B?bVUzVVNUVFRoK2JUa2JwN1VNZk16K3ZsZTFmR2FNZWdQME5SM2w3ZWRiYWxw?=
 =?utf-8?B?OUswK1dkMjZKVldtZ2FlMXZvL2RvTDhKMm1QbTVqR29XdmQrb3ZPSlgzQUZv?=
 =?utf-8?B?dWtNZUdYdXgvMVZnRk5YVStpN2ZlTTFIbFVYdUxCTUZrVmMvbkk2SGhnT081?=
 =?utf-8?B?YXo4cGFVd3R5ZlFXem15Tzl1cUxYRy9DWFFWK1RPR2gxdjM3Z0pYMlhKWDFq?=
 =?utf-8?B?ckRsWTgrVy9rK0hWTUdoeEdwUjlHNmhBOVhQbGxIZ0JraDFqNjNaU2JUR0NN?=
 =?utf-8?B?cWVIUWorUExiYVZnTUhXcUxFRG9BSzRFNWQrR2kwWUdSdW9FS21CNlAxOG0w?=
 =?utf-8?B?azlLWE9seXRWYVJoWDRCNW5DMmUxYUQxczBudnROYnhleU5PVUxVOFI0T1Z1?=
 =?utf-8?B?N0s1MHRKOVRKeHYvVnRVcnlXUU1mUU16Z2c5RGhaMnRkM2JSS3VtVUU5MDJF?=
 =?utf-8?B?KzBKaTBNODV4SURIM0tlb3ZGQk13ako4VEdxaWtreWRvWjg0Qzd1N3FTOGxv?=
 =?utf-8?B?THU3NGlrWDhUdERzTnBIV1ozelJzNXZJQkV3Y3RqYmNJSitvZGZjbzA2cExs?=
 =?utf-8?B?Z2E3ek9vbTNCOERCY2ZJeCtSQktYQ2pkOS9RdXRyaEFKVlZFZVY3MEFFa00r?=
 =?utf-8?B?OGYvV0I3OUt5aVFKN3ZEdnA2Z0h4VkNGQlJzNTQrZEhNclpQOEFWWXV0VHIy?=
 =?utf-8?B?cG5ncUE1em4vd213UjZqTm1YcVRrZEVSVUlCSENSRWo3a2lQSWtBUHpPZ0c2?=
 =?utf-8?B?Q0tKWWdQdlBKaGFPbHhxcGxMNjhyTSsySEluTk9rL041OGFucnRHNTJLa1l5?=
 =?utf-8?B?SEZJeXBYc0FVNC91NFJNM21RTkJ3SThzYVVpUHRrajIrUklTMkJsODBrSDc3?=
 =?utf-8?B?cVJzTmxyUXFvM2xjSGNUbnJmdk5BMk54YURQeEVlT1ptM2x4L1d6aHF4WVkr?=
 =?utf-8?B?SEZoREFxcFRJNWxFeTBHU20yZzd0bndkVmY2b0tJOUNWTzg3ZDFOT01Rdy9G?=
 =?utf-8?B?VkNkMWtnNXBrUHBSbUk5TE9sQTRoaFlud1VLOXIwSHdiTi9vL2ZmYzc0WTRj?=
 =?utf-8?B?WW1HYWlETG03SDhjMVZtekd0NVFFcHA5NUZYc1dXS241T2twQTVFRVBzd05k?=
 =?utf-8?B?MzJUdm56QzRvL0R6U0R2blBKZEZPY29XY29NaE9FdFdlYzZLY2VBV3g3Nnp2?=
 =?utf-8?B?ZlZHeEtCQUIrakV6R3FWTGIzclJvZVR5ODd2czVzYmErTWtkYUU2Z2YwMnpn?=
 =?utf-8?B?T2x4VXphMUg4Qzhkajc2czZtN0pVOHBiS3NhQnZGQllVbFFkakxwcm9iYjR2?=
 =?utf-8?B?Y3puRi9NekFCYkVZWk0xZ1p4U0E0MW83TFkrQkdPdjdvdzRHRHYrTWFnbUdr?=
 =?utf-8?B?SFFnM3NsZ3QrTy9NMVdyR2hEM3djMmJTYW03bUtmUFNBVkJaSWdTWU5La3RH?=
 =?utf-8?B?YjYvanNHb2U5L0ZLcml0aGc0ZzNPcHd6RmZzSXRPNENyYzgyRW1USWNJTGNM?=
 =?utf-8?B?TjhtcDcxTVMzK3hxRXBTelo1MTcxeDZvYjdkUEprSU5Scjhab2JIMjhOLzMr?=
 =?utf-8?B?WjJlRDdKSkpEbm1mWXdTUEhmeW9QUnpJZ3NjbUszVVQ1c0wwWGpXa0xheG10?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9321E85235B7F4FA55B3458111537A7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Ye1pUki2I8u0P1v1R4HfzSmn15vi1Yb90vfnqGjLgurwpSYxiX2uSlhagFoExzJHgNGuxtmP2Xrd/RTRk+Z9VF5xk4IvJBsFpKIyM/X3jmDVEXHRZKLCQRdrlPg1H0/l0rj2bzQH0p6NSxZeyTxI/QbH30gCzzeFpSMqP+/4mx5IRbP4YEfDulcepsu1BPyMekdDPVQLdUzwIf2xQv3TgwFdmzabxr91/9VtI3sTOziIj97PRL026dWJjqZyJps/Ua3NX8vupA8ShHHfvakPSHc8NgmNcQtsMmDkGAGFlI67Fh3VSafrh9APkQjL0kjWri0MkTydLN/ww/jV36kMcHA6JjH2d7y6YxQlBnENcwlRmYKaZ6ccLElo/ewrbwzAlryb7z6DYhOUqEkTxxAd0erMeyBehs/KD3Je/lrLlMztuSIvRrPuXaqI3QR4wEs5h1KnQ7tGDMruBkH0Ph2FVHrD8LRlfjsU8fzKokJBcafKX9XHJVZHfqrAy521kh1JMj7A05AV1FUct8gVKleSM+NbgkWBrKF1E6HPdhWAfO1XiT1PYdZzrXEFwmH2qbVn7MJTxMdddOamLDE/zfF1oFQKx6QGAApzRinIjwaA3Rk138nmypKHVjOq92yo0XUQGQeyTJI19FMm6Hl3GgUOsrZVlmvRgK+nv6puw/un6jAv2sSqqeiiSiPi19DOY/TV0njE+DefANBDyUKyKQyDV0WK4HdZqCsP9RKQA/FQv6mLpiALIS7zfj16OBpW1HVf4N7oh2gGXW82pxUqI4UPj7ty5RN7sTz5QP7MCqB3MarlHBsUDHFFhmEz3nMZHuOEqegOgQ7nJtyTeqL3AMttw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10399.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e01a75-d559-45ab-2bee-08db26a9bd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 05:37:47.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0NEUa5OiqFHa/FQfTwoXSUpb/bbNejU48yDYFRV0xEhveje8hgiRluD+SKF9UTZAoPCQFI1b0+oozzYeVmzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5805
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE3LzAzLzIwMjMgMTA6MjYsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gbGl6aGlqaWFu
QGZ1aml0c3UuY29tIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxNi8wMy8yMDIzIDIzOjU0LCBEYW4g
V2lsbGlhbXMgd3JvdGU6DQo+Pj4gTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4gbnZkaW1tX2J1c19y
ZWdpc3RlcigpIGNvdWxkIGJlIGNhbGxlZCBmcm9tIG90aGVyIG1vZHVsZXMsIHN1Y2ggYXMgbmZp
dCwNCj4+Pj4gYnV0IGl0IGNhbiBvbmx5IGJlIGNhbGxlZCBhZnRlciB0aGUgbnZkaW1tX2J1c190
eXBlIGlzIHJlZ2lzdGVyZWQuDQo+Pj4+DQo+Pj4+ICAgIEJVRzoga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDA5OA0KPj4+PiAgICAjUEY6IHN1
cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4+Pj4gICAgI1BGOiBlcnJvcl9j
b2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlDQo+Pj4+ICAgIFBHRCAwIFA0RCAwDQo+Pj4+
ICAgIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4+Pj4gICAgQ1BVOiAwIFBJRDog
MTE3IENvbW06IHN5c3RlbWQtdWRldmQgTm90IHRhaW50ZWQgNi4yLjAtcmM2LXBtZW0rICM5Nw0K
Pj4+PiAgICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAx
OTk2KSwgQklPUyByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjZTcyMi1wcmVidWlsdC5xZW11Lm9yZyAw
NC8wMS8yMDE0DQo+Pj4+ICAgIFJJUDogMDAxMDpidXNfYWRkX2RldmljZSsweDU4LzB4MTUwDQo+
Pj4+ICAgIENhbGwgVHJhY2U6DQo+Pj4+ICAgICA8VEFTSz4NCj4+Pj4gICAgIGRldmljZV9hZGQr
MHgzYWMvMHg5ODANCj4+Pj4gICAgIG52ZGltbV9idXNfcmVnaXN0ZXIrMHgxNmQvMHgxZDANCj4+
Pj4gICAgIGFjcGlfbmZpdF9pbml0KzB4YjcyLzB4MWY5MCBbbmZpdF0NCj4+Pj4gICAgIGFjcGlf
bmZpdF9hZGQrMHgxZDUvMHgyMDAgW25maXRdDQo+Pj4+ICAgICBhY3BpX2RldmljZV9wcm9iZSsw
eDQ1LzB4MTYwDQo+Pj4NCj4+PiBDYW4geW91IGV4cGxhaW4gYSBiaXQgbW9yZSBob3cgdG8gaGl0
IHRoaXMgY3Jhc2g/IFRoaXMgaGFzIG5vdCBiZWVuIGENCj4+PiBwcm9ibGVtIGhpc3RvcmljYWxs
eSBhbmQgdGhlIGV4cGxhbmF0aW9uIGFib3ZlIG1ha2VzIGl0IHNvdW5kIGxpa2UgdGhpcw0KPj4+
IGlzIGEgdGhlb3JldGljYWwgaXNzdWUuDQo+Pj4NCj4+DQo+PiBEYW4sDQo+Pg0KPj4gQ29uZmln
dXJlIHRoZSBrY29uZmlnIHdpdGggQUNQSV9ORklUIFs9bV0gJiYgTElCTlZESU1NIFs9eV0sIGFu
ZCBhZGQgZXh0cmEga2VybmVsIGJvb3RpbmcgcGFyYW1ldGVyDQo+PiAnaW5pdGNhbGxfYmxhY2ts
aXN0PWxpYm52ZGltbV9pbml0Jy4gVGhlbiBrZXJuZWwgcGFuaWMhDQo+PiBUaGVvcmV0aWNhbGx5
LCBpdCB3aWxsIGFsc28gaGFwcGVuIGlmIG52ZGltbV9idXNfcmVnaXN0ZXIoKSBmYWlsZWQuDQo+
Pg0KPj4NCj4+IEZvciBrZHVtcCBwdXJwb3NlWzFdLCB3ZSBuZWVkIHRvIGRpc2FibGUgbGlibnZk
aW1tIGRyaXZlciB0byBlbnN1cmUgbWV0YWRhdGEgaW4gcG1lbSB3aWxsIG5vdCBiZSB1cGRhdGVk
IGFnYWluIGluIGtkdW1wIGtlcm5lbA0KPj4gWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbW0vM2M3NTJmYzItYjZhMC0yOTc1LWZmZWMtZGJhM2VkY2Y0MTU1QGZ1aml0c3UuY29tL1Qv
DQo+IA0KPiBBaCwgZ3JlYXQgd3JpdGUgdXAhIExldCBtZSBnaXZlIHRoYXQgc29tZSB0aG91Z2h0
LiANCg0KVGhhdCB3b3VsZCBiZSBncmVhdC4NCg0KDQo+IEFwb2xvZ2llcyBmb3IgbWlzc2luZyBp
dCBlYXJsaWVyLg0KDQpOZXZlciBtaW5kIDopDQoNCg0KDQo+IA0KPiBUaGlzIHdvdWxkIGhhdmUg
YmVlbiBhIGdvb2QgdXNlIGZvcjoNCj4gDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW1tLzNjNzUyZmMyLWI2YTAtMjk3NS1mZmVjLWRiYTNlZGNmNDE1NUBmdWppdHN1LmNv
bQ0KPiANCj4gLi4uaW4gdGhlIGFib3ZlIGNoYW5nZWxvZy4NCg0KDQpzb3VuZHMgZ29vZCwgaSB3
aWxsIHVwZGF0ZSBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQo=
