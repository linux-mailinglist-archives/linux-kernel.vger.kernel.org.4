Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22285F6BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiJFQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJFQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:35:30 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66058E0EB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:35:28 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EHK0K028344;
        Thu, 6 Oct 2022 16:35:20 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3k20nb0qn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 16:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdqaUOt7j9t1OMiGMsOjymfIDZM4elwyhKrSTbzquVcd0wG3vsxY4LY9GVN4bvLYUEH4821w6ZtGnze8Wy5j023LFMkSITMu9dsElBrtjt6SDI8b4oBuadOh0V8o5NNMkMs2aEL30FVAzzQ7AfDlSAUUvm8G3eHJ8h7Duk1UMe7A3OK1uf+655rdgieWfg894STVqmebo1jG5dngUXBooF8UzWe09toEtXi+kfTgnB4AhvB2NohHYHBuBG4+eDPMlwtdMd3snH45LLwagT7TA2PFPDo9YlyBo2OLzcrJI4JL95qKWv6l8L8Vn0xJ2XitscQM1Xu6/nyl9WxT4QR6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA1xtS36+VdJSve6maCXgMPYvcCIt8LNfV0VwO7phAs=;
 b=OV3Mz3FQunDL50XfmzXr0yINHuGyYE0t/Ht49lZ3WWe5co4NJ3pyiHX6n3wsJE1LIfcsuvHOkYV0uwvfIxUJuYRpi/19M/XZg0QAdVR8mkCVUlDybsIvJRDTv4EPCPmCe/u7QjFGEuoA0Wx326KlhPDC7nU0Ozsye0DZzGG19R/G9mnBW6H5NFoIceUiyojc03AuMp+Ct4LqD9xmtTGQDYEGMbOEiJ+y/bZ849arcFEm1411v7lUdDRGLgA0CKHTA6HqByrO0c04GkwERluDUtQnk1Q/upsRQJbaLrYscArqpOgQTHSjDDvMYchpbFjPzhrzJE0AV2ciIxGnYFzgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA1xtS36+VdJSve6maCXgMPYvcCIt8LNfV0VwO7phAs=;
 b=fBOYkzlraN/lIxN3o+W5A6vKRBJ0S6Lcn2s1LWqCTEdUY7TBXg2gLEV+SRqtya0/4RFHmzLDwhBL1YXgyIrFTC1MSV01mef0X2+6CuRUrV+4xLRh+65KnmJcMw/BxfeD85KS7DxAVPnOMQrIjiwCKEd6zEnl+1GsHi85e/sjKx27nL8ddQAt90Qb4uRobW0MLb9bQg4E6p75AbQPy2SxVc1Asnk9E+WsdJ+aRvmEwpXTtf2KjH3JlTnJlevwnDzaccssFMr2KWf5WRzZgEQ5ZObtTyGVRqnoYNaAK7x40x/0vVhMMac/4zfdggWgfMs6Ro9NX2T48zxSgxWu/aLUDA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB7679.eurprd03.prod.outlook.com (2603:10a6:20b:41c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 16:35:17 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 16:35:17 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 1/3] xen/virtio: restructure xen grant dma setup
Thread-Topic: [PATCH 1/3] xen/virtio: restructure xen grant dma setup
Thread-Index: AQHY2VNhekgc4whejkG37lRjhh7+/a4BkJMA
Date:   Thu, 6 Oct 2022 16:35:16 +0000
Message-ID: <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-2-jgross@suse.com>
In-Reply-To: <20221006071500.15689-2-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB7679:EE_
x-ms-office365-filtering-correlation-id: da527780-a0bd-43d2-8a76-08daa7b8c06b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6I+LZJCWwj5pq2PCiNK3ZTmmO7+vkwqkG5WkjwHdKneN5rqFehvdU/jv9xf3srQ3h/8sa58/vja8RJ1cn9H1TDtIEYJzeKNKqbRl9XhaB6KuwySChqXfOZ+Wbbvr58xObzVkyqPvQ4DAaGVmUsOEB43peES+8dMwtq5I+gX4mvEXW/bBroLdNTs9xJ4qYK3L7RX2AblE2D6hI0s7wjBk+EcYsOBaNXd89imkdNTHjJQ9npqf6msC7RqloyKEe04vQWfGz7CGzZjG0f96jiLJgn1nIKPlrVBXPsLUlPNTz8Q15c0tbFwZ5K7tXPPKsBB3K+WDA4HGAzAyesPlnvKmgrJOy33IdRdgSCT19GiLpRehyFFiz8RsoESyW4yv9nNgDjSTxlb8LpGgE0hNxiGK0UQSuvWU+Nu+U9Z/E0ou37k7Wkn3yYmycx1HXNoL2J4LwNk+g8z3EMo2pIYy1hWkcoGLt6Yy3/PL4G4i8/JFZUIFOcrXHCRk6lTWMq1IRchbMX+uBrBti3B4S/KbddV9IQufrw0ewVGfOEZ+428tzklvWp4xJewVIFJf0xW/vg/y0e+9HKb/ix2AUpJPENj7Sr3yhPWKK15Ccb2Sewpgvutvbpt4z2cbwRSopZ0o/90Atb9POiZ2SATxk5GA0nuy7QcGbq+lgr0xA/5Z7g/rdF4k5LxhVl9aG8Jq+1DWVMKnRUl4LM+uwAnrRFKVuxqHlw+qack9upEPS5aG1INgZboPArRacE/UOJlLYaByJz/3rJmOzzlgODMHBsU0s3rp5RclbQnetZSfCDHYGweQNdup/qLqKTnF5ALjIToJD5ocf/ST3pwZc/SbCwWFaG/dlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(83380400001)(186003)(2616005)(38070700005)(110136005)(122000001)(38100700002)(41300700001)(2906002)(5660300002)(8936002)(71200400001)(6486002)(6506007)(478600001)(53546011)(55236004)(26005)(6512007)(76116006)(66556008)(91956017)(4326008)(8676002)(66446008)(66476007)(316002)(64756008)(54906003)(66946007)(31696002)(36756003)(86362001)(31686004)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGtyV0ppcWdxblMxTWQ2UjdlOUxNVEJFVFZ3bGpjZDVZdXFtSG9lNnBNS000?=
 =?utf-8?B?VDFnMTVLRzNsNmEyMTgrU2Rlb29UdmFCSjNkamx5Z0hlWDFNT3NucHhvR1V6?=
 =?utf-8?B?VlNWMmJaSWZVZllhcTAxczluRjg4czZqeFJVaHBDVnJTNU5rVCtPREdMcDAw?=
 =?utf-8?B?ZVJBOU9pMWw4R0VjeXhWQlg2OStjRUZMdEEvdWx4OGNaeHN0aWNscXBlRm5C?=
 =?utf-8?B?UHFiYUZaRXhnblp0dFBtclZrbitJbDF0U0hQNzVkMGVOM3o0cjVnZ29VNmgy?=
 =?utf-8?B?QXMrNWdmdStkeDRlb2lYcXRXMVVBeVZpbnFIWWVvVUtXNEJVc3cvajJBY2RV?=
 =?utf-8?B?QXFCNUM5dFdKb1kxM3ZjSFRiSElvcUo3R01wVlcxajFBelBkQlVsM0kzVkJ6?=
 =?utf-8?B?RDFySnlHaFZlNnUzRXA1aU0zUG1jM2JBdm1NK3RGMjJxclZTZU5URlZpamR1?=
 =?utf-8?B?Y25XL3o5eW00aVpJeDd4cmNSaXZLRGxsV3pJRDZ4dUV2Q0p1WFVHZE5kb1g3?=
 =?utf-8?B?Y1VPV0NMNnUrL21QMUd3SjlaSitobVFqU3M5RnFpNGg5RjlxSUN0TzlXODZD?=
 =?utf-8?B?cm1GeEhmTVVnYmRyU2cvZXpVZnNlMTJsZ0JkSUQzaVpWT2Nrek9TSWNHak1l?=
 =?utf-8?B?aTFNMTRrYnY5bzErYThXcjQ0U2VaNjlXREpuZUg5Y0JVRUxBQXY5RmxrdWI4?=
 =?utf-8?B?anFJbzhJWTgyVG9NVVNQOHQ3VHpZMWMyOFp4N0R5QkdZNkx5VGp3akZCTHhw?=
 =?utf-8?B?SHV6R2Z3eGpqcTcySVdQVHB4ZEdBeHlJM2JGM0d2T0M2R3k3MFVtbUFITnVC?=
 =?utf-8?B?MmsweDM5MUUrMnBZSjl1VkJYaUk1TmdxT0JvVWZZbzZIeEk3ZGh3T0x4ZkI3?=
 =?utf-8?B?NHp3OFZwUnVTYkhvSGE1T1R0eU1uZ0MwMXZlUElSTVFBdlMzcDlWNlRvcEpQ?=
 =?utf-8?B?cE5qYVdzbXArZUVqSXJVRlJDWnpTM2MzaWw3MitOdVZvSUQxdENkWVk5SGYy?=
 =?utf-8?B?VVppV0VleERjcXNaR01jcU5maVVKMG0vY0oraWk1bjZXbzdDTHBnazZlN3pv?=
 =?utf-8?B?NHFYdVhnblRDaXpocmZzVTdxSXhWRzRzOVJpbkpDRVpHMmVPR1NlVDZwVE1V?=
 =?utf-8?B?MytYUGxBbUNOS3dpNEY3ck9PNUQwYi9hOHk2VTQvbVY4NHRmc3VieTdXV0RN?=
 =?utf-8?B?VzJKVEpaS3N4YktPb1FhSUV5ejZlK0xmR0psMVlQNjFJTkZUTEZGeHRNSGdu?=
 =?utf-8?B?d2JnTmxnNXM4aUY3cGdlSjJCY0YweEZqc3lhQlFDQmhGNytubkJKc3lvWXBm?=
 =?utf-8?B?SW5jYWVYaFRVSXNPamRweS9FaHZtMExSNSt3TjVEamRabEN2L0FtdEVacXdD?=
 =?utf-8?B?WnZHbWZLdVY2N2EyWkxWSUpIL1FBWkh4b2djNVhmUGxOV2ZTUHVHdTBEMTM3?=
 =?utf-8?B?SFpjbUo0SVkxUFpRMGFKc2IzTFBDZ3lZVnhHSUFWNjhOb1lQNTRNV0d1c2JE?=
 =?utf-8?B?ejNlT3hWNkhSVFNKOGVaZ1A4MFg5SkY5bkhpYVUxVUp0NUlScUZwa0NCdEFh?=
 =?utf-8?B?UnJzY2hYZ2ozQkxtOHA3WThaU05JZ0FyRHJtbjRqN3J0NVFPNzNHREs0aUZw?=
 =?utf-8?B?a3lhZUtWejB3ZDdSa1U2ZzF5MURKNWlYOVJuSFMxYVFGeWF1SFk3R1ZFRUNK?=
 =?utf-8?B?bVVGMGFRRGZIRVYxdVZ4WEZSODE5am1UcDBSNkpSRWZ1WjFmekRQVGNCd0U3?=
 =?utf-8?B?WHFRcC9FRm9VMVhrVGJzZS83UHhmQzFGYVlxU0kzazZZRjAzVWlhMXQvKzU4?=
 =?utf-8?B?WmRlRDZvcmk1Z0F2VnY5MGNITmZwVEp6emNVVDB0MHJNZTRpSEZSYjhiYzll?=
 =?utf-8?B?dm10NzMxdFhjcVN5R1NvS1BvWUk0enQ4cjJxMlF2KzZYaklVdGltV0Y1aklm?=
 =?utf-8?B?WE1kUEhtVEN5MDhVZGorVXdxM1lkeGhFSlFaRC8rK0xwOWdIaEdzQXRhUitB?=
 =?utf-8?B?YTdpZTJkaGppdTA4SVUrcUtmQU8rQUhwL0NaWkF0NXFsemtIcGVmNThLWitv?=
 =?utf-8?B?RG5tM21XNWJBVitWLzJWeWtXcDZWTlZLc044WnFuWWY1QW14bE9sSWpqSXNv?=
 =?utf-8?B?NHFodTRJOWw3Z3J2VTBRNjZFU3JkWHErSGFxUDh0VHR6ektSL25DMGpIWlVK?=
 =?utf-8?Q?D67CMMEVBs5WzwaJipsVqxc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D8D2623AA610040A37D60A783E219F9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da527780-a0bd-43d2-8a76-08daa7b8c06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 16:35:17.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKPFe4PBFxsiPhIwGLOWraERVHiJG9mU4Xr5pob866wWIKa2Q7g8H/YjEgnC5oIGRziS8sP/SLxnrLV9m9qJp9KwAy3toItA1USMf1lNeaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7679
X-Proofpoint-ORIG-GUID: GIJDoHJxK8k9xNUUy4Wb5H7IcxHkkx0H
X-Proofpoint-GUID: GIJDoHJxK8k9xNUUy4Wb5H7IcxHkkx0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNi4xMC4yMiAxMDoxNCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCg0KSGVsbG8gSnVlcmdl
bg0KDQo+IEluIG9yZGVyIHRvIHByZXBhcmUgc3VwcG9ydGluZyBvdGhlciBtZWFucyB0aGFuIGRl
dmljZSB0cmVlIGZvcg0KPiBzZXR0aW5nIHVwIHZpcnRpbyBkZXZpY2VzIHVuZGVyIFhlbiwgcmVz
dHJ1Y3R1cmUgdGhlIGZ1bmN0aW9ucw0KPiB4ZW5faXNfZ3JhbnRfZG1hX2RldmljZSgpIGFuZCB4
ZW5fZ3JhbnRfc2V0dXBfZG1hX29wcygpIGEgbGl0dGxlIGJpdC4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNClBhdGNoIGxvb2tzIGdvb2Qs
DQoNCm9uZSBOSVQsIHhlbl9kdF9ncmFudF9zZXR1cF9kbWFfb3BzKCkgZG93biB0aGUgY29kZSBk
b2Vzbid0IGFjdHVhbGx5IA0Kc2V0dXAgRE1BIE9QUywgaXQgcmV0cmlldmVzIHRoZSBiYWNrZW5k
IGRvbWlkIHZpYSBkZXZpY2UtdHJlZSBtZWFucyBhbmQgDQpzdG9yZXMgaXQsDQoNCnNvIEkgd291
bGQgcmVuYW1lIHRvIGl0LCBtYXliZSBzb21ldGhpbmcgbGlrZSANCnhlbl9kdF9ncmFudF9zZXR1
cF9iYWNrZW5kX2RvbWlkKCkgb3IgeGVuX2R0X2dyYW50X2luaXRfYmFja2VuZF9kb21pZCgpLCAN
CmJ1dCBJIGFtIG5vdCBzdXJlIGl0IHdvdWxkIGJlIGdvb2QgYWx0ZXJuYXRpdmUuDQoNCg0KU28s
IHcvIG9yIHcvbyByZW5hbWluZzoNCg0KUmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBUeXNoY2hlbmtv
IDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCg0KYWxzbw0KDQpUZXN0ZWQtYnk6IE9s
ZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4gIyBBcm02
NCANCm9ubHkNCg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyB8IDY4
ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNDMgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMN
Cj4gaW5kZXggODk3M2ZjMWU5Y2NjLi5mMjk3NTlkNTMwMWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3Bz
LmMNCj4gQEAgLTI3MywyMiArMjczLDI4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1hX21hcF9v
cHMgeGVuX2dyYW50X2RtYV9vcHMgPSB7DQo+ICAgCS5kbWFfc3VwcG9ydGVkID0geGVuX2dyYW50
X2RtYV9zdXBwb3J0ZWQsDQo+ICAgfTsNCj4gICANCj4gLWJvb2wgeGVuX2lzX2dyYW50X2RtYV9k
ZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArc3RhdGljIGJvb2wgeGVuX2lzX2R0X2dyYW50
X2RtYV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4gICAJc3RydWN0IGRldmlj
ZV9ub2RlICppb21tdV9ucDsNCj4gICAJYm9vbCBoYXNfaW9tbXU7DQo+ICAgDQo+IC0JLyogWFhY
IEhhbmRsZSBvbmx5IERUIGRldmljZXMgZm9yIG5vdyAqLw0KPiAtCWlmICghZGV2LT5vZl9ub2Rl
KQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gICAJaW9tbXVfbnAgPSBvZl9wYXJzZV9waGFu
ZGxlKGRldi0+b2Zfbm9kZSwgImlvbW11cyIsIDApOw0KPiAtCWhhc19pb21tdSA9IGlvbW11X25w
ICYmIG9mX2RldmljZV9pc19jb21wYXRpYmxlKGlvbW11X25wLCAieGVuLGdyYW50LWRtYSIpOw0K
PiArCWhhc19pb21tdSA9IGlvbW11X25wICYmDQo+ICsJCSAgICBvZl9kZXZpY2VfaXNfY29tcGF0
aWJsZShpb21tdV9ucCwgInhlbixncmFudC1kbWEiKTsNCj4gICAJb2Zfbm9kZV9wdXQoaW9tbXVf
bnApOw0KPiAgIA0KPiAgIAlyZXR1cm4gaGFzX2lvbW11Ow0KPiAgIH0NCj4gICANCj4gK2Jvb2wg
eGVuX2lzX2dyYW50X2RtYV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCS8q
IFhYWCBIYW5kbGUgb25seSBEVCBkZXZpY2VzIGZvciBub3cgKi8NCj4gKwlpZiAoZGV2LT5vZl9u
b2RlKQ0KPiArCQlyZXR1cm4geGVuX2lzX2R0X2dyYW50X2RtYV9kZXZpY2UoZGV2KTsNCj4gKw0K
PiArCXJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiAgIGJvb2wgeGVuX3ZpcnRpb19tZW1fYWNj
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpDQo+ICAgew0KPiAgIAlpZiAoSVNfRU5BQkxFRChD
T05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCkpDQo+IEBAIC0yOTcsNDUgKzMwMyw1NiBAQCBi
b29sIHhlbl92aXJ0aW9fbWVtX2FjYyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQ0KPiAgIAly
ZXR1cm4geGVuX2lzX2dyYW50X2RtYV9kZXZpY2UoZGV2LT5kZXYucGFyZW50KTsNCj4gICB9DQo+
ICAgDQo+IC12b2lkIHhlbl9ncmFudF9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gK3N0YXRpYyBpbnQgeGVuX2R0X2dyYW50X3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAq
ZGV2LA0KPiArCQkJCSAgICAgICBzdHJ1Y3QgeGVuX2dyYW50X2RtYV9kYXRhICpkYXRhKQ0KPiAg
IHsNCj4gLQlzdHJ1Y3QgeGVuX2dyYW50X2RtYV9kYXRhICpkYXRhOw0KPiAgIAlzdHJ1Y3Qgb2Zf
cGhhbmRsZV9hcmdzIGlvbW11X3NwZWM7DQo+ICAgDQo+IC0JZGF0YSA9IGZpbmRfeGVuX2dyYW50
X2RtYV9kYXRhKGRldik7DQo+IC0JaWYgKGRhdGEpIHsNCj4gLQkJZGV2X2VycihkZXYsICJYZW4g
Z3JhbnQgRE1BIGRhdGEgaXMgYWxyZWFkeSBjcmVhdGVkXG4iKTsNCj4gLQkJcmV0dXJuOw0KPiAt
CX0NCj4gLQ0KPiAtCS8qIFhYWCBBQ1BJIGRldmljZSB1bnN1cHBvcnRlZCBmb3Igbm93ICovDQo+
IC0JaWYgKCFkZXYtPm9mX25vZGUpDQo+IC0JCWdvdG8gZXJyOw0KPiAtDQo+ICAgCWlmIChvZl9w
YXJzZV9waGFuZGxlX3dpdGhfYXJncyhkZXYtPm9mX25vZGUsICJpb21tdXMiLCAiI2lvbW11LWNl
bGxzIiwNCj4gICAJCQkwLCAmaW9tbXVfc3BlYykpIHsNCj4gICAJCWRldl9lcnIoZGV2LCAiQ2Fu
bm90IHBhcnNlIGlvbW11cyBwcm9wZXJ0eVxuIik7DQo+IC0JCWdvdG8gZXJyOw0KPiArCQlyZXR1
cm4gLUVTUkNIOw0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmICghb2ZfZGV2aWNlX2lzX2NvbXBhdGli
bGUoaW9tbXVfc3BlYy5ucCwgInhlbixncmFudC1kbWEiKSB8fA0KPiAgIAkJCWlvbW11X3NwZWMu
YXJnc19jb3VudCAhPSAxKSB7DQo+ICAgCQlkZXZfZXJyKGRldiwgIkluY29tcGF0aWJsZSBJT01N
VSBub2RlXG4iKTsNCj4gICAJCW9mX25vZGVfcHV0KGlvbW11X3NwZWMubnApOw0KPiAtCQlnb3Rv
IGVycjsNCj4gKwkJcmV0dXJuIC1FU1JDSDsNCj4gICAJfQ0KPiAgIA0KPiAgIAlvZl9ub2RlX3B1
dChpb21tdV9zcGVjLm5wKTsNCj4gICANCj4gKwkvKg0KPiArCSAqIFRoZSBlbmRwb2ludCBJRCBo
ZXJlIG1lYW5zIHRoZSBJRCBvZiB0aGUgZG9tYWluIHdoZXJlIHRoZQ0KPiArCSAqIGNvcnJlc3Bv
bmRpbmcgYmFja2VuZCBpcyBydW5uaW5nDQo+ICsJICovDQo+ICsJZGF0YS0+YmFja2VuZF9kb21p
ZCA9IGlvbW11X3NwZWMuYXJnc1swXTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICt2b2lkIHhlbl9ncmFudF9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sN
Cj4gKwlzdHJ1Y3QgeGVuX2dyYW50X2RtYV9kYXRhICpkYXRhOw0KPiArDQo+ICsJZGF0YSA9IGZp
bmRfeGVuX2dyYW50X2RtYV9kYXRhKGRldik7DQo+ICsJaWYgKGRhdGEpIHsNCj4gKwkJZGV2X2Vy
cihkZXYsICJYZW4gZ3JhbnQgRE1BIGRhdGEgaXMgYWxyZWFkeSBjcmVhdGVkXG4iKTsNCj4gKwkJ
cmV0dXJuOw0KPiArCX0NCj4gKw0KPiAgIAlkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9m
KCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+ICAgCWlmICghZGF0YSkNCj4gICAJCWdvdG8gZXJyOw0K
PiAgIA0KPiAtCS8qDQo+IC0JICogVGhlIGVuZHBvaW50IElEIGhlcmUgbWVhbnMgdGhlIElEIG9m
IHRoZSBkb21haW4gd2hlcmUgdGhlIGNvcnJlc3BvbmRpbmcNCj4gLQkgKiBiYWNrZW5kIGlzIHJ1
bm5pbmcNCj4gLQkgKi8NCj4gLQlkYXRhLT5iYWNrZW5kX2RvbWlkID0gaW9tbXVfc3BlYy5hcmdz
WzBdOw0KPiArCWlmIChkZXYtPm9mX25vZGUpIHsNCj4gKwkJaWYgKHhlbl9kdF9ncmFudF9zZXR1
cF9kbWFfb3BzKGRldiwgZGF0YSkpDQo+ICsJCQlnb3RvIGVycjsNCj4gKwl9IGVsc2Ugew0KPiAr
CQkvKiBYWFggQUNQSSBkZXZpY2UgdW5zdXBwb3J0ZWQgZm9yIG5vdyAqLw0KPiArCQlnb3RvIGVy
cjsNCj4gKwl9DQo+ICAgDQo+ICAgCWlmICh4YV9lcnIoeGFfc3RvcmUoJnhlbl9ncmFudF9kbWFf
ZGV2aWNlcywgKHVuc2lnbmVkIGxvbmcpZGV2LCBkYXRhLA0KPiAgIAkJCUdGUF9LRVJORUwpKSkg
ew0KPiBAQCAtMzQ4LDYgKzM2NSw3IEBAIHZvaWQgeGVuX2dyYW50X3NldHVwX2RtYV9vcHMoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiAgIAlyZXR1cm47DQo+ICAgDQo+ICAgZXJyOg0KPiArCWRldm1f
a2ZyZWUoZGV2LCBkYXRhKTsNCj4gICAJZGV2X2VycihkZXYsICJDYW5ub3Qgc2V0IHVwIFhlbiBn
cmFudCBETUEgb3BzLCByZXRhaW4gcGxhdGZvcm0gRE1BIG9wc1xuIik7DQo+ICAgfQ0KPiAgIA0K
DQotLSANClJlZ2FyZHMsDQoNCk9sZWtzYW5kciBUeXNoY2hlbmtvDQo=
