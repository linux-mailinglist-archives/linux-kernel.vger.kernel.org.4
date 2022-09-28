Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C565EE1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiI1QZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI1QZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:25:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4942CDDA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:25:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SA7REo022080
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YJn8t1srsAzyn7lK2dEPYteP6fqha8wfiwgNVEWt2Wk=;
 b=WPiZ8ai6RZUH4G7K5exLXB/txN90wQ9dAaYYLJg8j20Im+z2+MUn1bYr7oWFGHtHZXVL
 wQUY4z2fggfxiUKGXQcWRIWcl8Z7wOCpAS5430gaDaDEioKTEVSNwe4EmFL1ifV2kA6P
 06NFI6+Bj+f364GwdX1MJfPToB9yIZjHtHg= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3juwhvkck6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5jjMd6w/49ubwOpVX4NuOVmRD0tfeR63NL1Kll4yqoAbIa9ovOuRX4BQk5WpQBtAxIb2Vw4cXPzwS8umo2JUjSRAENPTl1dDxZqX7EYMNywYo8fCariH4ktV7gj5j/ZSk0tbvEoDYkbmMXiU0r+7z6/kFn5KTp0RspBbe77J+cslbNtR5YL3ZLEcbQ+k4/BTeHYUwtbFWXVldCjrlGIb/lZJ0RV6Iuv0+sESv2OrNKvTOTjzyZWotk83RYy+FCO5lw/oPgucj3nqeny2mQYFDuIQ7jGGzz19at2ui/t6YsVniIxtiUNFx12fpeC2+5vsGETlI8ZcFhOZ7Bp59s9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJn8t1srsAzyn7lK2dEPYteP6fqha8wfiwgNVEWt2Wk=;
 b=DZU790NvUbjtgZRWeRVrxl7ESS3jqz8G33q2Y3JF31Mv6Biot02O/7XcxHMdnbLobStoeHDtSZwc1oobxbbreRNmbzxkY1LsLS82lNbBSNQhNc9fH+D+0SMOKBUWrjzzdfSgyJt2G2cbuS+46v0VW82RRjTnQktick5tEWXiB1SghFKa7buvmln2oiQRDBoMmbYA6E/bxAQ397YyLUos+POM/3xx9H1C5fIQwXQ38LXn2431Z3GlmshCyo2WSFmIkI9MTthirREhr4YIm/zTnNjxicHm0si41lwVPk6fqtOBX4plpQgL+iI9+Y9UL0ISE5rDEsr9q/gWhmtcHg8zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1734.namprd15.prod.outlook.com (2603:10b6:910:19::14)
 by DM6PR15MB2956.namprd15.prod.outlook.com (2603:10b6:5:140::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 16:24:57 +0000
Received: from CY4PR15MB1734.namprd15.prod.outlook.com
 ([fe80::fc7c:15c:9a61:e445]) by CY4PR15MB1734.namprd15.prod.outlook.com
 ([fe80::fc7c:15c:9a61:e445%12]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 16:24:57 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "riel@surriel.com" <riel@surriel.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Thread-Topic: [PATCH 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Thread-Index: AQHY0wWgS10OlaMV00O2C0wEiRZxBq30iG6kgAB/NwA=
Date:   Wed, 28 Sep 2022 16:24:57 +0000
Message-ID: <6628C757-C37D-4E62-933C-FC7018AB835E@fb.com>
References: <cover.1664347167.git.alexlzhu@fb.com>
 <94de34378bb748196e7709205a75331569d1d28e.1664347167.git.alexlzhu@fb.com>
 <87v8p728bb.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v8p728bb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR15MB1734:EE_|DM6PR15MB2956:EE_
x-ms-office365-filtering-correlation-id: 1dd1de2f-7df5-4705-894f-08daa16dfbee
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ASfupxk39dw8FZMxngfg1hqTRcGbygWUgh0FLqEHHfLhWZpG7ssxuiznL7AUZLTbAt7Koux1ITXdVhgzF2EYg/IhqNzTTl5KS3IzsovhmHWYYbEnhV5zsHbfuY3WRuPVJ+amc7VmxgPdiFbsT7cLFZaSL3IaiAxJBLB77Nr5meQUHRzYuHX2SUOVPs+6Cjo7M7jE2dzOPKmrgSseyMWEs5aq3SDCFBukQyv4gtqH/ypqpmqSpRATGWAfv8dXy1Ip9hJPyZCW5BiHGUXbaB1blkDk9tUZpkTE+SQ6ac5FYk2EjjY2dfsH8ofQ1NcrKxVvbVq/2JNiGS+5je9DLI8OPKTKIrP1Kiq7b0PnHLOwofewV+mMtK8WRWAgt97yNekvQD1JjPrqGp9iHakZASr5MQYiGZ9GGfkp1WOw3zN0acpB999UDoI3jpGf+lohMEirvRo3PUg/bnckjfAEnj9GU5/MWV3Ydy1Xjj3iUOrcBV1VmdsCcVLdxoX2Z3eGB5sMBW8aLOsjLW2SH40LnkLIvTeuTSgPZz6tcEpFmxZxKINItDmWJIL8lGkabyUIUEyNbLRt5ckGX/xp2EtFy9bPM1Jt8uIGoZz48eSugKvvCOcGGktP5tm2+2CukbQxL1L28PqU4COJqEVVgWl5WsYCkGlGtMkIqrWh2nT7RWvvGEVlxAbaSciRC7kJ82mcRNFy2/2Q9Tj/Y6BCVk1fIJzb4a+uLWGTs2en7q0EjdrxEh02NffTY4xRufdFTgK6U+2jvHLaXqCykTZvS9mmg9NGLN2AKVIp5oRgDhlAB9eshwhVtqmPlsv18FdwpiNdlZCI8Nm7AyF9B4ABMNmESFdRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1734.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(558084003)(33656002)(36756003)(2616005)(186003)(91956017)(8676002)(66556008)(66476007)(38100700002)(4270600006)(86362001)(64756008)(66946007)(76116006)(6916009)(4326008)(38070700005)(316002)(66446008)(2906002)(41300700001)(5660300002)(8936002)(6512007)(71200400001)(6506007)(478600001)(122000001)(6486002)(54906003)(19618925003)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhBNEhFRk1zbCtpRHVOS1liem5pUWV2UVhBMUkwd1B0WStsbkFEOU9MeXVw?=
 =?utf-8?B?c0RZN0FqZjJrcW41Ly9zblcxVW56OUkxYzYrOHJEV1Y5QjhsWGtxSSs5L0R6?=
 =?utf-8?B?b2s1Ryt2Z3dSR3kyUHV6ZXI4dVVLQlFsbWxyazJsUy9kZXp4TU1EeHVZU1g0?=
 =?utf-8?B?a25rNVhoeHkwdlZmbm95Q2pobWFpNS9XYUpLUnF0WVdmOFNIYktxSGF4V2ha?=
 =?utf-8?B?M0lDYy9yVzR6blN4UG1sVzJ1bmtLam1ycEhVbkhBSURzd2x1K0Fjekc0QXNq?=
 =?utf-8?B?cTFrQUxvaUZmWFdmeEtxMUl5Z0FEc3p2WjFyWXIrMHcvb0M3aVV6TTlLa2w0?=
 =?utf-8?B?ekhZaThWc05WekRTOG9RTlNmdmVqRy9OY0oxcGVJUGtLMjlTV1RGbFg3SnhZ?=
 =?utf-8?B?K3JES3EzN0hMNTJXUDhGRkUwT1lZZjFncmYvT1Z2N2lEWFhIVEMvWTl6OHRH?=
 =?utf-8?B?UVVxTk9SMU1EbXJVQ3JtTUJnSkFKdkhMQXhvMU9WeG1mRnFDcys1K2w2cjc1?=
 =?utf-8?B?a3MvVGlScmhGTE5NOTVXNm80Y1JkZHlVMDRwRnhYRmJRNUo3ZCt4cGljNStB?=
 =?utf-8?B?QTVwcnBhY3VDazJ5bURjdnN4YTc3TmhTOTdpWEl5NVhrV2NrODh1Q0JRckRF?=
 =?utf-8?B?NDBoQXN0enMzQ3lQbHAvZEthU2xqUU9aK3VxVFRTeE9wRzZkays2anliS2to?=
 =?utf-8?B?bUFmekNDODFWVFd6b1c5aGtHL3l5SUU1TEkwRUtOdHhXS3dQRmhZVFdlVGxP?=
 =?utf-8?B?ZmlkakdsRmFtbGZ5L1Z1MEVXVXRmQWRGendyRnJwUHlpYXM1eXNoVFpxcmxH?=
 =?utf-8?B?YTVxQmVmZUNDczJmSDB4TzQzb3JJZGRQQzh1TjB3Rm9DWWRZZ08xYUpMd0dk?=
 =?utf-8?B?ejNDckI1d1ptMktaMHB2UTcyVUw4dDFjUzVPVFpSMW8rRDBSNkVzY2U4eDRC?=
 =?utf-8?B?TlZYWk5YZjM4aTk0c3BYTWl2K3J3Mjl3S3p6Tm90emcrZTMyaVU0L2UrVjFt?=
 =?utf-8?B?ZFdBR3hsS2xiZnVyeTlKSjhTOGJyQnFnNUJDSnVoM0FnbUJ5OGRwWkw1cGw3?=
 =?utf-8?B?c2xKbHNtVGlKS2ZsMyszdVZNY21YdjIrcGxOa2IwaGswcldVUmN2a2taNjg4?=
 =?utf-8?B?bWpKMXFIWXUyYXlORnRrZ0VlSDZFOWNHVzhVK0hGL2JFOVc1cXBQUzI4c3p4?=
 =?utf-8?B?TE9QOWhLZGY1R1Q3elJsZ2R2Q2NheVI3aFBvcnljQjJ1UFcrREQ4NEEyYW93?=
 =?utf-8?B?bkFYYzJMQ2ZiMkk0UW1lTWNsc0huajVnVHNCS0NFYk5lTmJDQkEzTy9TLyt6?=
 =?utf-8?B?cm5iZ2pRSWFSMzlIcFpuZERWTmozdUVnZ3R1b2FkT2UxWWtHakQrVjJ0SXdy?=
 =?utf-8?B?NnhqZUdGbGFGNFp0NWlnSmpkdjVjV3E5OVU1VHNtKy9JWEQvZlhaN0pzQWtH?=
 =?utf-8?B?UlB6K2x1MzBmNmZRaW8zQUxISXVValR0QmhkQ3NrMzNMa0M3Uis5UldyR0Ns?=
 =?utf-8?B?eDNDQW5nT1RWeFNVc29oWUtYRTJBRW1NSXFhdVdIOWFJNmpmTTZpajVxMEVZ?=
 =?utf-8?B?REZ4cjlGZnZockt4Z1p0R1BZVXFaRElDdFM3bTA2YUNFMFdPV29tMVozSFky?=
 =?utf-8?B?WkxnNCtGdVg1K2U1eFFNcE4zcnFUdVduQkUyUUp2TlVXYlhKU202K3hOZ1hv?=
 =?utf-8?B?WDNVbFpFYnhjNyt0VTlac3JTL2Vud2Y4TFdyVFV2eUlWSDFmM0l5dzdhVlF4?=
 =?utf-8?B?L0pNTDlTT3ZacE9vaG5qQVBHRGpjODRjdFhyMHBWVW5pYXJSaFlvS3FrejlB?=
 =?utf-8?B?VEtKVldUcDZrSTFhQXdBTGY5N1A3R0F3bUpnRHZTL2dRRmMyR3ZZMGhQd1RV?=
 =?utf-8?B?N1VMTFh4OThaTmRqZXMxcENDVWVpVk5VZ2lES0NGRm5SVzU5ZW9GOER5QlJl?=
 =?utf-8?B?aWcwWG11TWlnYVZkcFNrMEdhQXJqMUxSZ0ZjSjJhd3NFWjlHcTUxR2JLR3Fy?=
 =?utf-8?B?d1hkQlB3VnNlVWJQaVF0QTNLTUJ6bytITHBrdXNHOElYaW16U29DNkhLcjd5?=
 =?utf-8?B?c0wwbmFXSmk2NzBGZmxONnQwcHVwWG5UMEpDNUlDblUzWDgyUitJT0RkdlhT?=
 =?utf-8?B?OEJuQ3pXai9aZ0RsU3pUTS9rNiswQ01OZktmVHhhOHlKMmNMb2V2NTEwTUJ5?=
 =?utf-8?Q?0jACRHFF5QgxQ4onOwU82DY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11CBF602E3073741BC857C1DFDB2014C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1734.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1de2f-7df5-4705-894f-08daa16dfbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 16:24:57.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tu9frpTuDMC9KU7fS2jzDTKDYPSduCvmBFxGZnDei3/twdQ8LfZ9sLyozXo7nE7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2956
X-Proofpoint-GUID: NDDSpNyKpenaGDNzxXsOfVHQLiUIGbs8
X-Proofpoint-ORIG-GUID: NDDSpNyKpenaGDNzxXsOfVHQLiUIGbs8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzISBJ4oCZbGwgdGFrZSBub3RlIG9mIHRoaXMuIA==
