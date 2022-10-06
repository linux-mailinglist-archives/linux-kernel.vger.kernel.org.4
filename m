Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E345F6CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJFRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiJFRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:24:17 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10487FF209
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:24:03 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296G3XYw010824;
        Thu, 6 Oct 2022 17:23:47 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3k1wfhsyfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 17:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LK2VwOCh0z6iOu7rRZ7wpTM8Y1AiAf7kgeyr7FjkDYJHkFCESyD62I09Fxu2eg4plzB/YnG9epyhQNMYzpzOe9TE2FDtY1J3DlnCjWYx+h0DOJvvcYX18+ImZPk3NYldhS1Zj/2Fd6fdlcUm1jCNP+KwsrEs8GVQmugy6wRu//1ztkpPKGyFcf0jLNRC59Pt0zDUWpIbjVpE/1Y245AddAX4gkrl7fqpIJyCAKtxpf/+HadSvXtsHmeo85gD+zIBC1oDxi/abmPTYCSQ4Z4kLVoYWHfiL2hP4aGfUo/MxobryW9I/1Eai1FWhRZcrtAi4X7Yyq3WXrMt9foeuX4vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8m1sKTh6VL5hm0H1sMOzX6k5cFfjhU+L4lTgUPJKlU=;
 b=EyYjQjKx/lNiJ9+9OgzT9gRXehKp/QTHQqeG3aMSFWJq8onNK3+5ee24eMJf1QC9zOlmnxocBrm0OMrgIxVEZ3NR2IqjRDcpGBuav/aIOvoaAeiidQZNcTn71FgL2Di2oJ5TO/uj9sEs4erT7X2Ph/Logj9cX/5TlDKwc8ODFnuJBXxuS6nLuANpNJtMGPphpWlIZo3nhPixl53WAf0DZhToKpkUzC2a8owMMs5owP4Ut3Giv2LgPWDBcYsy64vqU9i0QSSROsrbltBwPsWEaB6rQS+e80fYIYs7U9baJOYD5xOxfpHxTqUztvsyeK9f8qCnCFIwShSaBxaJTcQSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8m1sKTh6VL5hm0H1sMOzX6k5cFfjhU+L4lTgUPJKlU=;
 b=o/LNcORAaI8wHJ2+SDMV0VopffGAt8TQB5UxUZ7sVHOv/kw+TMrdvU482saMhWGor27IpHN3SZjxySg7OweN8+p87ArKjI7pN5p0BaVbmk3/Vyo2KX2pMvgd0CeSI/zqVWRcWzIWZdQcLDFaXr5dOT5Z8RDRKY/YDtltKYWl3MrGm5TrkiUkJhHUo/57zNHUa1d7ue+6F5meoflgr0Stwx8qv+jIef/AhWNfCTaCUumJrOXDDRcIdqHKZd36KwylKrSwsJsDEoHpRJq+mAnQ+ba8gBy8x26fRq0Z+EpFsKMQ4U3yeZg4hw9AFTzBShNelcVuwmupPdmK5s+EzDiIIw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by DB3PR0302MB8968.eurprd03.prod.outlook.com (2603:10a6:10:433::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 17:23:45 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 17:23:44 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/3] xen/virtio: use dom0 as default backend for
 CONFIG_XEN_VIRTIO_FORCE_GRANT
Thread-Topic: [PATCH 2/3] xen/virtio: use dom0 as default backend for
 CONFIG_XEN_VIRTIO_FORCE_GRANT
Thread-Index: AQHY2VNlob0BWl5FK0K3rZia87E8oK4Bnh4A
Date:   Thu, 6 Oct 2022 17:23:44 +0000
Message-ID: <36b69e76-a26e-f7e5-998a-8345034cec20@epam.com>
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-3-jgross@suse.com>
In-Reply-To: <20221006071500.15689-3-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|DB3PR0302MB8968:EE_
x-ms-office365-filtering-correlation-id: f7ae7e71-9dd3-45c9-957b-08daa7bf85a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RQvg92xO2KCzDYg5aGMazPN8zXTHEEyaWm00O+BRj0O1I2w6wuhUmJhzKrwyr0KSyKmeMrbeyNWYmRqtoqpl/XrAid1Zs2fv/6FA7z+MZRmnGxyU/j9k3jGz6vE0eVP5sWZcdWEL8/S+zIbJp+gUN0x1RNR96KswhFSmw+Eg5rIcCm8pd9lMzlxppW+Xy/vHmO/SQQVvGYwQ/IkKPMLrsYwWDhjB6MJ348vtCRs3VX2nMghZETMH4fGr4P4oYSPXhAbfUUgw7VgB2f8OUQCqkezijIozGDSyJQJ/jn2MfrxeUrnFVzt7xowB065BJ9K3lOg6G0RQBch6pNZzd24dQswwznyOeIS0ur7/fk86YAuFghgWxuDCGCygwdF/ciqEYpjPMkS4JdN/iDCntH2v2UfIvoTfxqlnAWALpRBDsr8J9OK4R5CN7nGi0j9VTbJ/A/jZCgmkOM2pJPO62tMCe+nU3FaI3BsVrTONb/szRjrha87BcsLaOzj0qVNqEGx4V+VyISNZpWC0xJj74jbMCMQF/bBUjI7K0dK22xLzUw30P27Mb76YTVePoyLdVEnqlPPI+Tf00U+OP/QsWmwd2j1WKTCevdTQu4u2HN+cvbU1+sR22YSGMYAyqtczKSk4Y/vrcl/+y7sA6w9OSbX3qDCRRaGR4iKgRy10FmvBJKxyW6Pgnd2ApZ6LvX8NwDupdyS8Hj5DZNGL8kNiYkFx6CL+uU8v6l1mknDo4QZv5jrQtgQutAPXKYi10iCnkkElXkUiIxTX2xNiOcHXiE4e85kcIbcV3VGGZ8etwp/I+TvMdmIIosYwUTtAkbiX4h9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(71200400001)(6512007)(26005)(8676002)(76116006)(91956017)(4326008)(4744005)(6506007)(122000001)(38100700002)(53546011)(31686004)(55236004)(110136005)(186003)(54906003)(316002)(86362001)(31696002)(2616005)(41300700001)(66476007)(2906002)(478600001)(66946007)(36756003)(66446008)(5660300002)(64756008)(38070700005)(66556008)(6486002)(8936002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny8wV3dBYUY4cERkeGpuaWdrU2kwNis0eCtFSjNLTVNtNVdld3ZZTTE2RHY0?=
 =?utf-8?B?NGFtVDVMT2djRWFOejhYaDFnSVZDWlEvUlMxMDJ6b1Zvb2sxR2x5ZytsL2d3?=
 =?utf-8?B?MVVrUjgwemxMSTBYajEwMzgwb1dUQnpJSElsTXVlR1o3d1dZQXp5VVQ0cUV5?=
 =?utf-8?B?Kzd1akRUcTNjT0ZyQW9kWXlZZU9uYnpLUllDcWxWVVJGRnFhK1JQaGY4Z3ZL?=
 =?utf-8?B?UVhmenlEY2FOZjJhNFJCNWFiYVlWY2hGSFIwWVlUdXlVNjRiMi9pd3Fnalp0?=
 =?utf-8?B?Y0JHbEE1NHZRZHJwa2JJZG8wemJSZ0xJTTJld2QvNWZmYm9paEZYOEx1WDRK?=
 =?utf-8?B?aGZ6RkZWR082QWlJOWswRlloMHlOVndtclI0MHlhVlpPdkhYbTY5UGoxMjNN?=
 =?utf-8?B?ZXFacEhud25pMEpvWG8vd01NeFQrMEJFMmhNV20wYkwrVW8yb0kzMFZERzc1?=
 =?utf-8?B?WEVxQUxyU1FvcFN1clMyR0NjZTZKQTVzUTRTRjJkc1hJOUNQOGk0a1pJajY0?=
 =?utf-8?B?VXJDaU1SZ2R0ZXE4c3pCNEZVdktVcmtrR3JjMThiem0vRE45NkVqakpLWUdu?=
 =?utf-8?B?QjlSaEcyRnVGZXpzaHl1VVVVRkMwVCtyNmdQR2pVViszTHFnR0NtQS9TbmNB?=
 =?utf-8?B?eTh6RmJsc1h2V1hZeEJGY1VLTWM4Y2FFZ2ZIeEVuRGtxSXE5cHZJZ290MFpn?=
 =?utf-8?B?Nm8yQWxNWFhKZk9sZTJzMmZTRjhtcHJObkg4TkRzNzd2QWo0QzFjWklya09I?=
 =?utf-8?B?SHBOODd5RWpJYml0TE8zM25jNnhJSDlqYkNETXdIclZaOElJdjdManNSSEps?=
 =?utf-8?B?cG9mWlpaZ1cxajFxZjJ3UEVLMTl3UUxPQ2FZS0R6emhJaXptT2E4d0NEaith?=
 =?utf-8?B?aUliYnUzSXY3djl2WmNTK0NFWDAxMGRnaVNUM01PelE4a0ZNQmlSRjZ2UXh2?=
 =?utf-8?B?Tng2RE10ZTV4ZXRmbkdsUStNOU1zM2piWWhqbld0SmtDc09nYzdXM09kb0NM?=
 =?utf-8?B?QkVldWR1SHJXckowVFc4WTMxVVk5SnBtU2RoWk9yS2FtTVhuY3JtZWV3cTF5?=
 =?utf-8?B?R1NmZE5qeDBOUUhYWlI4VTBEcTM2cUVDWjJVVXorRExrMFo0MDRCUE16T3ZY?=
 =?utf-8?B?cUQvb0Zla2sydS96WkpSaU1FbmtqMTE5Ui9JQWErUXFvUkE0WkM3Y0VnZzQx?=
 =?utf-8?B?eE5vaExKYVowWWdpc0w1RjRKcWkrelRscVM3bndmbkxVRHNmdXhzQlgrVFMy?=
 =?utf-8?B?WGh0NEpIRmhOMHYyTFVRRTMyZHJXamc1dDZzQWZuQnUvTFhBWC85OXpVbWVV?=
 =?utf-8?B?Y1I2TmZMTGZnNWFsYmlYdzRvRnlOK0I5QmFGWTVYcHBNbm1TVTVia0diZVNX?=
 =?utf-8?B?SUNqZmNqWitpNVUzYWZrN0xIa0tCMnRpWGZLa1g4SmZldHJIei9XaGorTksr?=
 =?utf-8?B?UTZ3aG52MFl5Sjg3bnZQczgxbVVDaFZOMzR1aDJWZTBKU0c0YzNVdDJWSG8v?=
 =?utf-8?B?YzlCcHNyR1ljVmx4U0h2d2RCVDFDMEZoME5rb3NOWVF6Skp2WGxsSVBhb0lP?=
 =?utf-8?B?OGlqV2pTRkswenNOVHY2Uy8raVhRb2VITFpLT3N3bnY3RlpFT1VLMTI1NzNl?=
 =?utf-8?B?RlVsNkgxRGxKUVJnR1lDMDlGUjA1M09jbmhGRmU0NkpMQUdFdXg2MnZ6Q1hk?=
 =?utf-8?B?dUE0ZzhJU3FIRE9US1F0S242S010RGlJc3ZQcDIvUW5tQm9kaldwRDRtT2N2?=
 =?utf-8?B?Mng5eXZ5MjVjUmRCM29QeFExYWNCZEoxdExQcFlIanRITVFkNEVnVEp1NFdu?=
 =?utf-8?B?Mk43VUZHaURONDh1d3JVQXlnbE5HMkhOSlNJQzV2T0cyR3h0Zm9DMksxV0s1?=
 =?utf-8?B?UXNvdXpXZWZkUFhCeEFmeU55U3Eva1g0QzZ4czVKV3ZLend2NGJqQTJpV2dy?=
 =?utf-8?B?WTdlWmNRRVFqc3pyMWk3NXVuVWZaanI0Rll5bWRVUGNsdkdoSG5jeFczSUor?=
 =?utf-8?B?WGFqdzAvSWJaMkR4eGR5SUN5bVNBK2JaS1hxcWVRM1JDS29zSmRCZHpzUUVR?=
 =?utf-8?B?YnJsS1B5cHhBN2ovaFo0YmtJNFg0NVFuUzdSSFFscEt5NDhzaVY5R0VuZk9n?=
 =?utf-8?B?c1lxS0VOQ2N1RnZoZ2FQTEtBY3JnaklMaUFjSlNicll3aXdwazdUZFVLb0Nx?=
 =?utf-8?Q?893K2uO3ee3sujmpjisDO4w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E076B011851849A5578A56BC301E9C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ae7e71-9dd3-45c9-957b-08daa7bf85a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 17:23:44.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwwjcQvbmk71R7jer6BpHqrs7qHGGpDBHJiuRU7X+Fg2HWyUQIYV1NoM1s6mcQYCsIykWeCdEJMWEAUDJuyylg7FA4gbqtddid1e974YEx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB8968
X-Proofpoint-GUID: DCzsmJJu0f1O__zN9nutnUUONdBU_m7C
X-Proofpoint-ORIG-GUID: DCzsmJJu0f1O__zN9nutnUUONdBU_m7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210060101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNi4xMC4yMiAxMDoxNCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCg0KSGVsbG8gSnVlcmdl
bg0KDQo+IFdpdGggQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQgc2V0IHRoZSBkZWZhdWx0
IGJhY2tlbmQgZG9taWQgdG8gMCwNCj4gZW5hYmxpbmcgdG8gdXNlIHhlbl9ncmFudF9kbWFfb3Bz
IGZvciB0aG9zZSBkZXZpY2VzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyB8
IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQoNClJldmlld2Vk
LWJ5OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+
DQoNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyBiL2RyaXZl
cnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiBpbmRleCBmMjk3NTlkNTMwMWYuLmEwMDExMjIzNTg3
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+ICsrKyBiL2Ry
aXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiBAQCAtMzQ5LDYgKzM0OSw5IEBAIHZvaWQgeGVu
X2dyYW50X3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIAlpZiAoZGV2LT5v
Zl9ub2RlKSB7DQo+ICAgCQlpZiAoeGVuX2R0X2dyYW50X3NldHVwX2RtYV9vcHMoZGV2LCBkYXRh
KSkNCj4gICAJCQlnb3RvIGVycjsNCj4gKwl9IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX1hF
Tl9WSVJUSU9fRk9SQ0VfR1JBTlQpKSB7DQo+ICsJCWRldl9pbmZvKGRldiwgIlVzaW5nIGRvbTAg
YXMgYmFja2VuZFxuIik7DQo+ICsJCWRhdGEtPmJhY2tlbmRfZG9taWQgPSAwOw0KPiAgIAl9IGVs
c2Ugew0KPiAgIAkJLyogWFhYIEFDUEkgZGV2aWNlIHVuc3VwcG9ydGVkIGZvciBub3cgKi8NCj4g
ICAJCWdvdG8gZXJyOw0KDQotLSANClJlZ2FyZHMsDQoNCk9sZWtzYW5kciBUeXNoY2hlbmtvDQo=
