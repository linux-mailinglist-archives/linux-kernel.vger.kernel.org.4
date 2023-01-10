Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC75664FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjAJXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjAJXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:10:14 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BEFDE4;
        Tue, 10 Jan 2023 15:10:13 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AMemGB019804;
        Tue, 10 Jan 2023 15:10:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=H3NuvXXMrSlBVVXvB0lgbDpCi4ZoSWOnlsnHTgCQgM0=;
 b=cE60er6GIOMPO2b3+ILmLhSr4YWhj0gJXVTjwRBgdzsGEJqcEWI4zjh/LfL0gtBD2bTI
 R7URQipDNvaZsSkk9Az7LUXLfB0VAJKS5zKDonuSxBeXMs7zsdRujjgO9Jxx9KPJN8O/
 kmu0X/MdrRw8cVjg9ruUbAKXNJBnbRF90xr1ZrAINnu76nZ964Ghf5gWGfTdrIx4dzdn
 Utkr6bQKtceM664cI3VH6n55HewsC3vF8FEGpo1A4Ov/bzfdoW0QnevMUvCF+49T5hvX
 Upn33j2jJtfCgKzeOAMiiOf8qqhgri/jGfkIdmQsMKT2PXjsVt71KdGlraD02VyizSLe GQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n17c4v01s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 15:10:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuRV5MSX63ivJBSrUeG6z6U2OUZkkhYhNngu/OJoWhbZwfiSKKC0X+CJJs3lRX9TgFjQg9ikrLCYCIfoPLuwW4lXtGQ2cbnxyZlPh5YnDBL8sPZb8iSWIty8JmMWBuwkjOzeqHSUFf7quSa3QJ8RmbKDppf70A1I2qZa5WmzwAk5IXb5kxNtm9R2i7l+nnJOtVqmXI12Ze+uQRCAJAMsC8gVJOa2YM8PMKcRRcgNdymC1T1QFy3xT6B/uBgeYh7ZDRZDz79yPu1L8ysLLiTMj3GihyPzsNjXDkvqbByM6QnOO6dmPbcimLN9clLmdZ5Lawqv+EvLjYg7OTvIweg/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3NuvXXMrSlBVVXvB0lgbDpCi4ZoSWOnlsnHTgCQgM0=;
 b=ANFEGgNlAY717oQepkuw6WyGievKKN+PZNbh1BcfwwztK/H728PF3BUHrjjLdRdsSBQ7P5A5/CoGADPr9DdrPMAMdhTKFJP+XCDZzVoc0nArwpBnz8HkcW59eYLvzPLMVq4X/g/AXO1widPMXK5HfI+J42mdgWXx3YKFlIEdQPjDpr3d2o2EnmDlAO1g/rIgjGWlSeuyvD8jR2qSnbE0lb3kEa10607YcbvhusZebIhZAxvIXFBsqevOpUvYQLj4TTIkFUwSyffm0OkL4hhIxqXLxOkMipiC8CrL9przJWRZ/pF7jTsPmpZ2bSVnSW/FXax9k5k771OAn9RIp8p3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by IA0PR15MB5617.namprd15.prod.outlook.com (2603:10b6:208:439::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 23:10:09 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 23:10:08 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Thread-Topic: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Thread-Index: AQHZIIJwjTa/eWW290+GMXB1zq6Ba66YUFaA
Date:   Tue, 10 Jan 2023 23:10:08 +0000
Message-ID: <93130521-AF03-4941-8FF1-C97C76027A02@fb.com>
References: <20230104212048.gonna.331-kees@kernel.org>
In-Reply-To: <20230104212048.gonna.331-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|IA0PR15MB5617:EE_
x-ms-office365-filtering-correlation-id: a0ab8b94-c837-4a4b-91e1-08daf35fd12b
x-proofpoint-id: b222f61d-39ce-4c00-bf68-b051945dbb5a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/X4/r6Lr1UKAELAeGjF3XhD0XStp/uacQCHAqHF4iEFNXB4OyCh9NTF+n3q4QT9ZEjzWxChslwIPbHSCaCdA6zDMzaL7hvO/7UX1wbfdT98FpKQjkztz1aJcQdH6TWshCWn2Opmj8uBzGy9DaO6AryY0RFhylMVZnVeVj0zCpPfMlK2CH9kXM/GpkR0moYj/XkaVC3naZI+O0I9KMdixBugtBBK/N2iRW4ncQ68KYR1GYpxgRvc5uK9pHk/zxXNTUNvB+/dU9Q2V311L/l88A+7f6TlfUWBLNo2/K9fx1TQabO63sS2SRZ4SgswgU7qMOBh7Z3pTOivjXDBH0fbNFr0EH+6Yi597pbEzSP7yBt0KeF0u0lDZW7DRRXFldRVUCut6goedrPBFnEy9S2UMulkLvtTsBlXTN+yMN3gdnln8XQBNKAehqCgHY8BrERhuh5XT/VIOf33xQ059lvBBsG0gNPkF96/PdNbhbXdrvVNc8zFc8aWU0ETvJVdEsHpnPv0qgArKaTW07IowfaKZA6rZRGpSxAvVdSTNDgRER6MmPcUS85YOlbLhSX0HtKbgZNv6MwZOwWMnK/+pE1JVKsW5VXDXIOXdbywhKNt61NC0yl++DdfUcM328tEcEjBFmKoPLU7NZgV8pWVPTSfQcXQh8RpfoCcQXbjWRADMkqiED4sW1CSe9DCa1Q5P640Hhpgj7islG5DzsCq+IXeVozP8Dhequem4y/lgRem+c8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(41300700001)(76116006)(64756008)(54906003)(316002)(6916009)(66476007)(66556008)(8676002)(4326008)(36756003)(66946007)(66446008)(86362001)(38070700005)(5660300002)(122000001)(83380400001)(38100700002)(33656002)(8936002)(2906002)(6506007)(71200400001)(53546011)(6486002)(966005)(6512007)(186003)(478600001)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXllVnRzUHFBRlpwdkh2WHh3Nno3MDdkNlJTZm1nZjEwUjdPYmh3Y2I3OUo0?=
 =?utf-8?B?cjB3bnIzVm9MWnZqZE9vY0UzMmYwUzFzVWd2YnUvQjAvWWY1NDdHMFdaQ2Yr?=
 =?utf-8?B?QytJQnZuMHVwc1gvVDZ6UTgxcktBRUNWcUZlTEUrdjV0eGNRUW9VQkhhVDRJ?=
 =?utf-8?B?MlNKMTVhMFc1bUZiMHF1eXV5czByVGtGa0xob2JnVkFPa0dETFRPcWZ6a2Fn?=
 =?utf-8?B?QWdUUXhOcjcwZGlRdSt6OUlCNlptbXJDaWQvV1ppekx5bnRmK1FrbXFxNmxs?=
 =?utf-8?B?eFQ3cVVpMS9lRkE3Q2pQWCtOMnVHN0RkU0V0L0Y1VHFQelM2WHc0ckcwWVI4?=
 =?utf-8?B?SHZCZFVQMDBuNU9VdjNtcFVSR1dkU01temFTaVVWWjNOQ1lGMTRUcDV5c1pO?=
 =?utf-8?B?c0Qwejkya1diVGdtQytBcnFZNjRJaWlpVEluNnNmODgydlk2enpYa3poQyt4?=
 =?utf-8?B?ZS9JYUhZYVdwN2dBWEk3aDB0UE5KMnZ0K0pycUZYU3E0a29WYVZJMXZiS2pY?=
 =?utf-8?B?OFdTZ1ZiREYwRmt1NzFSUnA3V3lRUXRhcFczSHRVZ1p4MlovZVVSamtKeUFi?=
 =?utf-8?B?UWZuN084RTV6dnNHb0VNd3JnUmtObTAycEhRUThZcEtOam1keXIwMGsvZkVv?=
 =?utf-8?B?MjN4ZDdFSS9yNE9uQzkwa292STlyZndKVEhrSlNIQ1RnVnB0RHV0S3hreFU5?=
 =?utf-8?B?ZlVRSGRYQ3BnNUZVODBROFhYMnRKQ1pjc2R5WithS0IrY2FRZE44QXA1RGtl?=
 =?utf-8?B?S0pubnh1bzBNNWRkTUtFaWtsYkhjdngwZW93aitRVTdFTjBJQXBkbFhDMzZV?=
 =?utf-8?B?MGhOTG9NcVNEYnB2QUE3YlErRW1zZGZTSHh3VVhKNGFVOVgxR2xhdm9HbUFK?=
 =?utf-8?B?cGQwYjZmc3ordWpFOTJ1L1FUMThBVUpLNGhMSnNtMS9XUjJhTGkyT0g2WmtY?=
 =?utf-8?B?c1FjQ0NxR3g1Z2t6S1JORDQ2MkpLakl1UE5sU1htUnp5cTdUQkpwaXA3dG16?=
 =?utf-8?B?T3diWXJDbUdZdm94RkRCRlRSOEwzazJiUFBJbnFCeXBFK1VKMXFRZkhQcnRh?=
 =?utf-8?B?aFIwUG1LRU9ocFBhTXcvYnZDOTVWVWdud2RjRTdFVHpxSXdzalg0SXNJbjdU?=
 =?utf-8?B?bi9WK0cwUXFhOC8yT3ZqRFFjTWgwdWJXNC9KQUZINmtLVDRpR0IrTTFHRm9F?=
 =?utf-8?B?YVZSSWxIdElINmRFR2VHbDg4STZZeTcwdGNoS01Yd2Vvc3BJdjZJeFRhTUtE?=
 =?utf-8?B?cG9LL0JLRWk4MUJvWXdjbUxpZEthamNwT2ZNL3E3YUsxMmoweHR0S0ZKaEM1?=
 =?utf-8?B?blB4QkxEcjZ2OFdTZjBYNklXdFVXNGxaZHlXb2ZYZ25mcFdTRCt0QnVUallw?=
 =?utf-8?B?aUttMnFiY3VsRGs2aUkveVIzdy9VSXNiZCtBcDlvaHEvbjBaOFplbHNHOTlu?=
 =?utf-8?B?L3c0S3JIeVlVOTB4UzJvd1NRNE1BbXUrdmFvN05IV1NMb2FiKyt1cTVqRG9Z?=
 =?utf-8?B?Ymc3WDlYelBJY0ltYWNzRnJlU2h2cERRQVhxa2dqdElzalRkaHFjY1Awc09H?=
 =?utf-8?B?Q0o2WHloalhPTTZua3FiUVNaT21CZFlmUTJYWWZDd2V2NjYrVk94NUxidE1M?=
 =?utf-8?B?Z1dRTXRBZWlaV0pNc3RIQnJYdmdWM01sdGltazBTVU03VWdyZDJzVXFhWXJ2?=
 =?utf-8?B?ME44NmJWcnpKUWpTN25rcGRERGdjZGx4d1FhWVVpL3daUkpYbmJMZ2J4NTJs?=
 =?utf-8?B?Nmp3WXdsKzg3M0tOYmpwTTRsSkFOR1hmNndFd2paY2RLY0gzZEZOckpvTXhp?=
 =?utf-8?B?VXJ2dHk0OE5oU3JGeUduTEVMY0FTN0MxSGFFVHZpTnlKWkRZT3RrcTlWTUcx?=
 =?utf-8?B?QXNrNUVjQ2pTMHk2ak5sMlhFMmVlQms3Y3d6S2ZPNzlSZzhydWhYQ3lSSDV2?=
 =?utf-8?B?YjhLOEpUY2VxZ251Q2YxdkQ0VmU0UDIxZjNjRjNUdXJNMkZxbDlyenBMdjdl?=
 =?utf-8?B?OWtXdzZWS2Z0UExIUHBYS0l6YVd2ZjlZRnk3cXpNdGpUMkdobDU2K0x4ZHRO?=
 =?utf-8?B?enN2Tm9wQ1pjdUs5U2k1dmlUUk5wYzk2aUhBSFhhK0s4TWU4MDhyUEhmUzZw?=
 =?utf-8?Q?MnQisIkmn/rV2vcKaHWIqdy7z?=
Content-ID: <F6DAEB4F0620824391F60591D251DF89@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ab8b94-c837-4a4b-91e1-08daf35fd12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 23:10:08.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wR3MpXaM0kHrAtTyoWLNtFR2c+rblqj6RXAqJnAb9DFVBELup68oOd1Oxg+Q8ez/TysHuaCnSM/FC3+9P7Ez8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5617
X-Proofpoint-GUID: RTqLpSNa-cs1XclFfl4PsMbt-u-ytHu9
X-Proofpoint-ORIG-GUID: RTqLpSNa-cs1XclFfl4PsMbt-u-ytHu9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSmFuIDQsIDIwMjMsIGF0IDE6MjAgUE0sIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hy
b21pdW0ub3JnPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgVGhpcyBNZXNzYWdlIElz
IEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEZpeCB0
aGUgZm9sbG93aW5nIC1Xc3RyaW5nb3Atb3ZlcmZsb3cgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdp
dGggR0NDIDExKzoNCj4gDQo+IGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYzog
SW4gZnVuY3Rpb24g4oCYSFVGX3JlYWREVGFibGVYMl93a3Nw4oCZOg0KPiBsaWIvenN0ZC9kZWNv
bXByZXNzL2h1Zl9kZWNvbXByZXNzLmM6NzAwOjU6IHdhcm5pbmc6IOKAmEhVRl9maWxsRFRhYmxl
WDIuY29uc3Rwcm9w4oCZIGFjY2Vzc2luZyA2MjQgYnl0ZXMgaW4gYSByZWdpb24gb2Ygc2l6ZSA1
MiBbLVdzdHJpbmdvcC1vdmVyZmxvdz1dDQo+ICA3MDAgfCAgICAgSFVGX2ZpbGxEVGFibGVYMihk
dCwgbWF4VGFibGVMb2csDQo+ICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+DQo+ICA3MDEgfCAgICAgICAgICAgICAgICAgICAgd2tzcC0+c29ydGVkU3ltYm9sLCBz
aXplT2ZTb3J0LA0KPiAgICAgIHwgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4gIDcwMiB8ICAgICAgICAgICAgICAgICAgICB3a3NwLT5yYW5rU3Rh
cnQwLCB3a3NwLT5yYW5rVmFsLCBtYXhXLA0KPiAgICAgIHwgICAgICAgICAgICAgICAgICAgIH5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICA3MDMgfCAgICAgICAgICAg
ICAgICAgICAgdGFibGVMb2crMSwNCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICB+fn5+fn5+
fn5+fg0KPiAgNzA0IHwgICAgICAgICAgICAgICAgICAgIHdrc3AtPmNhbGxlZVdrc3AsIHNpemVv
Zih3a3NwLT5jYWxsZWVXa3NwKSAvIHNpemVvZihVMzIpKTsNCj4gICAgICB8DQo+IH5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBsaWIv
enN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmM6NzAwOjU6IG5vdGU6IHJlZmVyZW5jaW5n
IGFyZ3VtZW50IDYgb2YgdHlwZSDigJhVMzIgKCopWzEzXeKAmSB7YWthIOKAmHVuc2lnbmVkIGlu
dCAoKilbMTNd4oCZfQ0KPiBsaWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmM6NTcx
OjEzOiBub3RlOiBpbiBhIGNhbGwgdG8gZnVuY3Rpb24g4oCYSFVGX2ZpbGxEVGFibGVYMi5jb25z
dHByb3DigJkNCj4gIDU3MSB8IHN0YXRpYyB2b2lkIEhVRl9maWxsRFRhYmxlWDIoSFVGX0RFbHRY
MiogRFRhYmxlLCBjb25zdCBVMzIgdGFyZ2V0TG9nLA0KPiAgICAgIHwgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fg0KPiANCj4gYnkgdXNpbmcgcG9pbnRlciBub3RhdGlvbiBpbnN0ZWFkIG9m
IGFycmF5IG5vdGF0aW9uLg0KPiANCj4gVGhpcyBpcyBvbmUgb2YgdGhlIGxhc3QgcmVtYWluaW5n
IHdhcm5pbmdzIHRvIGJlIGZpeGVkIGJlZm9yZSBnbG9iYWxseQ0KPiBlbmFibGluZyAtV3N0cmlu
Z29wLW92ZXJmbG93Lg0KDQpUaGUgcGF0Y2ggbG9va3MgY29ycmVjdCB0byBtZSwgdGhhbmtzIGZv
ciByZXZpdmluZyBpdC4gQnV0LCBJIHdhcyBhdHRlbXB0aW5nIHRvIHJlcHJvZHVjZSB0aGUgaXNz
dWUsDQpzbyBJIGNvdWxkIGJldHRlciB1bmRlcnN0YW5kIHdoYXQncyBnb2luZyBvbiwgYW5kIEkg
d2Fzbid0IGFibGUgdG8gcmVwcm9kdWNlIGl0IG15c2VsZi4NCg0KVG8gYXR0ZW1wdCB0byByZXBy
b2R1Y2UsIEkgYXBwbGllZCB0aGlzIHBhdGNoDQoNCi0tLQ0KZGlmZiAtLWdpdCBhL2xpYi96c3Rk
L01ha2VmaWxlIGIvbGliL3pzdGQvTWFrZWZpbGUNCmluZGV4IDIwZjA4YzY0NGI3MS4uMTkwZDNk
NWFiNGJlIDEwMDY0NA0KLS0tIGEvbGliL3pzdGQvTWFrZWZpbGUNCisrKyBiL2xpYi96c3RkL01h
a2VmaWxlDQpAQCAtMTIsNiArMTIsOCBAQCBvYmotJChDT05GSUdfWlNURF9DT01QUkVTUykgKz0g
enN0ZF9jb21wcmVzcy5vDQogb2JqLSQoQ09ORklHX1pTVERfREVDT01QUkVTUykgKz0genN0ZF9k
ZWNvbXByZXNzLm8NCiBvYmotJChDT05GSUdfWlNURF9DT01NT04pICs9IHpzdGRfY29tbW9uLm8N
CiANCitjY2ZsYWdzLXkgOj0gLVdzdHJpbmdvcC1vdmVyZmxvdz00IC1XZXJyb3INCisNCiB6c3Rk
X2NvbXByZXNzLXkgOj0gXA0KICAgICAgICAgICAgICAgIHpzdGRfY29tcHJlc3NfbW9kdWxlLm8g
XA0KICAgICAgICAgICAgICAgIGNvbXByZXNzL2ZzZV9jb21wcmVzcy5vIFwNCi0tLQ0KDQpUaGVu
IGNvbXBpbGVkIG9uIHg4Ni02NCB3aXRoIGdjYyAxMi4yLjAgb24gdGFnIHY2LjItcmMzLiBJIHNh
dyBubyBlcnJvcnMuDQpJIGFsc28gdHJpZWQgd2l0aCBqdXN0IGAtV3N0cmluZ29wLW92ZXJmbG93
YCwgYW5kIG9uIHVwc3RyZWFtIHpzdGQuIEkgdHJpZWQgdG8NCm1ha2UgYSBtaW5pbWFsIHJlcHJv
ZHVjZXIgb24gZ29kYm9sdCwgc28gSSBjb3VsZCBzZWUgaWYgaXQgd2FzIHRoZSBnY2MgdmVyc2lv
biwNCmJ1dCB3YXNuJ3QgYWJsZSB0byBtYWtlIGl0IGZhaWwgd2l0aCBhbnkgb2YgdGhlbSBodHRw
czovL2djYy5nb2Rib2x0Lm9yZy96L0V4enE5YXJNci4NCg0KQ291bGQgeW91IHBsZWFzZSB0ZWxs
IG1lIGhvdyB0byByZXByb2R1Y2UgdGhpcyB3YXJuaW5nPw0KDQpCZXN0LA0KTmljayBUZXJyZWxs
DQoNCj4gQ28tZGV2ZWxvcGVkLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtl
cm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9h
cnNAa2VybmVsLm9yZz4NCj4gQ2M6IE5pY2sgVGVycmVsbCA8dGVycmVsbG5AZmIuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+
IHYyOiB1c2UgInJhbmtWYWxDb2xfdCAqIiBpbnN0ZWFkIG9mIFUzMg0KPiB2MTogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDMzMDE5MzM1Mi5HQTExOTI5NkBlbWJlZGRlZG9yLw0K
PiAtLS0NCj4gbGliL3pzdGQvZGVjb21wcmVzcy9odWZfZGVjb21wcmVzcy5jIHwgMiArLQ0KPiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9saWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMgYi9saWIvenN0ZC9k
ZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4gaW5kZXggODliMjY5YTY0MWM3Li42MDk1OGFm
ZWJjNDEgMTAwNjQ0DQo+IC0tLSBhL2xpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3Mu
Yw0KPiArKysgYi9saWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4gQEAgLTk4
NSw3ICs5ODUsNyBAQCBzdGF0aWMgdm9pZCBIVUZfZmlsbERUYWJsZVgyTGV2ZWwyKEhVRl9ERWx0
WDIqIERUYWJsZSwgVTMyIHRhcmdldExvZywgY29uc3QgVTMyDQo+IA0KPiBzdGF0aWMgdm9pZCBI
VUZfZmlsbERUYWJsZVgyKEhVRl9ERWx0WDIqIERUYWJsZSwgY29uc3QgVTMyIHRhcmdldExvZywN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc29ydGVkU3ltYm9sX3QqIHNvcnRl
ZExpc3QsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBVMzIqIHJhbmtTdGFy
dCwgcmFua1ZhbF90IHJhbmtWYWxPcmlnaW4sIGNvbnN0IFUzMiBtYXhXZWlnaHQsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBVMzIqIHJhbmtTdGFydCwgcmFua1ZhbENvbF90
ICpyYW5rVmFsT3JpZ2luLCBjb25zdCBVMzIgbWF4V2VpZ2h0LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBVMzIgbmJCaXRzQmFzZWxpbmUpDQo+IHsNCj4gICAgIFUzMiogY29u
c3QgcmFua1ZhbCA9IHJhbmtWYWxPcmlnaW5bMF07DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCg==
