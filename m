Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0470663D9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiK3Pnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiK3Pnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:43:33 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D7F52156;
        Wed, 30 Nov 2022 07:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6zgraC/A5vXlYlsOKgVXgGWBlx3e13vGjphlRzUHUBR8P4XzH6QGNWFIxMftr9R/yWoj1xSYDi0FCtwCKE++nC9kwkcpgu+8ogitfZ3ElMmtYiwtT078Ax23xi+jwy3FV/9oqdscshonL6l8EKtP6/Va3W1/vfRZ9t+3KGMJsawo1vaH/crm7AQ1YQS7CpflLCMAXN7J9QF8b5MGsbloUwGvs41F4gGGh+9tD/xy5w7y/apIHXcn2Cdl23QfrzmvfM+x+r3JQ9AZzjAWgCCGzawFOBsEvOAt62eJaj0oZs7bB/x9rhra83vBJVn5VnDHDEOLhzB9F6uPxfTJb6mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNJES3q2LBUuZZozwIML+C2MnG1fZpcN9KDhkCQZObQ=;
 b=Rt0mCII3OaBK3+UBCoLLsxypULf4sVbnSzWD5/1r+kafc+fhyAejM05NYjLglED1S3xoxg3GE5ol5NwpRBn0mDC3vaRgD9aespmXLBz37fzi7MfSAULdGquKZ9CSXI6hLXhljDgyy/kEjYbxRwkXwMgGJEnSA3t/d2H7YDLjQ/NSpl1trayP6sVA4CkO7CqT+8/diVM1tVwkRnMxmMnVs3EX1hELBWWmFa15JSlMMCp9A8LLmOCytHU4AclHFIK6fgfFOYBr8my3SwQhQheOWibQetr/mxjRVpCuBK2MvOYRUe+HRlY1MZNLSiT1y+0bPb6dphufuR8VsEEcHbdieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNJES3q2LBUuZZozwIML+C2MnG1fZpcN9KDhkCQZObQ=;
 b=cwOlUv2nC5NZMSW6fobCFXH7ADaZyiG2M2/y6c/cMo0FKNRhLvIUh9uqjMeoz3T4NeXLeNDXXgo4itd3Tagnf1AWvZUesGTiwJcbKSEY7HqwlonsRtupi5rscAfSJaL7N1E3kkSuSP9jw6PZozsTfDVmT1q6kpdGipFiKZiYXmctPhuxIJA718t/JvTilJEIKSxXtsWyiGN4lw99NKRJKaEj91Vxm6vXilZM54MSG23RFVi1SKxibUDi6Cmdx91CgCPTd29pP9nLidbxPZV4bTZAKIN+vwI+lZE1pQkJD8n6ENkAEn2ojM/sdXaishdLR9CN9BdU/5BVvPoki666CA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3540.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Wed, 30 Nov
 2022 15:43:28 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9%2]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 15:43:28 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Thread-Topic: [PATCH] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Thread-Index: AQHZBMmes372uMfD1kSR31OOvJey8a5XjrKAgAAMswA=
Date:   Wed, 30 Nov 2022 15:43:27 +0000
Message-ID: <ae71f8d6acac42f7e85fd111259e578305e938ed.camel@siemens.com>
References: <20221130143948.426640-1-alexander.sverdlin@siemens.com>
         <Y4dvdzVQZDEt09+p@sirena.org.uk>
In-Reply-To: <Y4dvdzVQZDEt09+p@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3540:EE_
x-ms-office365-filtering-correlation-id: c0db7eeb-e67a-41aa-00e4-08dad2e99ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dKKK5YiB6mKIY30+29iWOCICxmeYSj7h5W0bvOab4p0/Oe9Mb5VQNrMR9Q8nx3bAmZPZzT68hLn8fmw0drvbhED5nXN2on+wP/q/GS8OOh3KGGJoOR2zkI7vnsr0hHDQvTKlH5ZCfXC0uGO3i2q/8hNYfUf34qGR62VmLHYAKMnlkV+4A3ZrWPuFiieJnsGTtaf+KmQsoXpX+ilsxn/NZCKPKgyLwHYXKDxxPAVoh3xQkLFaPez5XlUFHllkYv2xKaWnoV4MdnKipaFDINrDEEfXdJ4kTzlS1YdnGlwZCunbP4G+T7S0IUW/EC826dsg7ZrSQsZuTCWu3joAuRh6FnYsrUn/+1ZWLDqOwbpRw8n+3gNO9PthYso/uOFij4Oox2iqgzYqebh5IzaF4EXf4B5gJrujtdtbH4HqboprSuSymFOiYpO8exHIzIzMT7C+opT2EpVAYkUsddxJvhz47pUKKzjzgohzzem8L4SoZYB/NtIAtzAMdnfnxjvbIWcprpS2ojUB13ejfjW01sPEoFJJPknB0KpuJLdKz4KSzevNj3VHBXKB9paBNVTusw9mvZfkRITC3xTPOkbTrNSWYPR9AycaAKmfIdaPVjTCgA1H0jFVlvoFBxV/dNbjaRniM2Vrw6zYRUSD+t608mIJuPSg3Tu1OrVjSW557rmDQ9FC91UgcHVdS1uKNcXtIMSyOa3HLAxT8o2mxgVVmb4Y8H0UNdMCWMEeqbpEUhGBdDUhJoPd/ehpQE5VxKHAHPfpcEBj37rBFk1QFsGdsrSYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(36756003)(41300700001)(6512007)(66946007)(2616005)(83380400001)(26005)(38100700002)(71200400001)(6506007)(4001150100001)(4744005)(86362001)(8936002)(122000001)(5660300002)(2906002)(6486002)(15974865002)(38070700005)(316002)(54906003)(186003)(66476007)(55236004)(66556008)(91956017)(76116006)(6916009)(64756008)(8676002)(82960400001)(4326008)(66446008)(478600001)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0NuYlJDWko3VjhKbURqakZuK2VDR01GWWZmT3BSelVObGFQM0FDck9nQVdY?=
 =?utf-8?B?Yk5WK056NGRMSnZIMUZETHVXaTUrMlYwK0lVeFVSVkVwOThGazZKWDB4NEpQ?=
 =?utf-8?B?YXN2TEU5Z0J4VHEybTkwc2poR3hpNXM2YTRQUVRjV0pDcGdwUWFMNFYwZGpC?=
 =?utf-8?B?ZkorQlJxUjN0bnk1VlhxdlBGVTU5QW5Sdi81UFZHQlVzRjgyRnZ4RXBveFVy?=
 =?utf-8?B?NzhMa1pmdllpK3NYZHhQTFpwVVBYWXV6N3hxeGhKcjIzb3FmTnVDQm9ZNmNX?=
 =?utf-8?B?WktsVWNneHNCbkY5bEVPTllHdk8rc0V1bmJBdnpUelZLUFFKWDBpakJ2dHlJ?=
 =?utf-8?B?eWM1a0l5VTZPZGEvQ0hab0RTK2NMWVlTYWNLeE5md3pmclp0WlpLdDZQcmJG?=
 =?utf-8?B?Wi9HRnpReUduaDMrR0JveTN3ay83STMwNHN1Y2xSNlFnMHVaNHJ5V2hRcDkz?=
 =?utf-8?B?YlZGdldjSzM5eW1pRjQ4bG9Vc0ZpVmgyM1NLcXQ0WWk0c3BVb3RMUlFEUHZJ?=
 =?utf-8?B?TWlUUlpzdWpyR1Vud3NoaVhEMDNrVGhBSnNtd0FoemJmU0Q1SVVBL1FGSnor?=
 =?utf-8?B?Ry9TNGtya3FWSWV1SldsRGZ0NURjb0dpaE9XWTJ4MnhtMEozZHZxUnhQM0pr?=
 =?utf-8?B?K3ZSRGJLVTdiOGQ5NnNKVTVxTlpiSE1ic1lQMjdNclZkRm1XSW9uZFFYaWdP?=
 =?utf-8?B?Q1dpcGdGd255NTNxSW9MdGV3UnRFMVFKRnBWT0tqKytSRmgxMENzamNCYkdh?=
 =?utf-8?B?Sk5ld0VpRDE1VE5kK2NLb0FHaDhSV0U1R3VFbnVBVW92V0xOcCs0MFJlUllH?=
 =?utf-8?B?MmtoQkkvYU1yWjdyQ3VyOWJHcUk1eFZiWm1QTXB4Y2Zmamc2dExpWnQ5WFdV?=
 =?utf-8?B?c09KS0hoTndPbTR4dlJNU3MwY3lJSzM0eDZMa3B0K0tLck54QWxpbGxLRktZ?=
 =?utf-8?B?YUl1NkE4WG9pRHRES2dRYUJKZkJoZFo5dUJCaEdnRDA0U045WFRGdkpmY1Iv?=
 =?utf-8?B?Nnd2cTJuUzlGcjR2d2hmdmJHZkd4cnMvbkd4U1VJdm95ZVhXQVp4SlBwMVRO?=
 =?utf-8?B?TEZsb3pBQ0hHbHd4Y21Fc1oxaldIQW50cDlDeFNhYTVPZGp2RVlpMHo1bnBK?=
 =?utf-8?B?eHZ5KzZFR2I3WkNrSnlKUHFFOEsrUm1VVGppSWY4Ukd1aFdWSW81aGdJYjlQ?=
 =?utf-8?B?OWhPaHl2cFgvKzJKWERWWGFtNEZzMXFnOWw5ZGlHKytIdjJxeU5BVkYwajdO?=
 =?utf-8?B?NVBFVm9PTUFQK2t0cm9DUFlYUkwzQitJVW9NZ3FiL2JRb3M3S0MzNklxMHVs?=
 =?utf-8?B?R2hLTEFrMW0wQWkyeUhnNjh2REVGSTdxMXRaQVNZbXlXTjdDb3A1a0tzUUda?=
 =?utf-8?B?ZnN5WGQzWHNsWVhodC9LSGJ5WEpVNnFwWXVPSElxaWpRbkFrSU5DT0ppREhy?=
 =?utf-8?B?TXB5Mk1hWWI1WkRLTnRzQ3ZLQzBrL3dWc2lTVHc2MWc1UGdUVTZFWGxJMUVa?=
 =?utf-8?B?ZEZ5T080K3RUd1dyL2thdkRwUkhPSExmbzNRcWtGVVBJWUVPYjk2OXJUaU93?=
 =?utf-8?B?MXRBdlN0SlQ3WW1DZllBVFRsWnBRbkNnUnhoZ0xIblBkMnRKY0R6SEdvdFdN?=
 =?utf-8?B?TVFFYUxsWlppYVJ3WlMrOXJ2OHBGWDJPWGJXeEROL0J4R3FQNXRkT1ByYzdT?=
 =?utf-8?B?eGUrZWM1dDZvcU5Ea1M0UUFTSFBtZXF0WWYvckNFT05HT3lKK0FWRkhDRjJI?=
 =?utf-8?B?cmFLUTR2NXVBQ05PanBHZGkwMGVzalZCU2NmV2lLQUNjdW5TMlBUeGlZaXNr?=
 =?utf-8?B?TUp5QjVDQWVOZkNWYnRBekNuNzNjT1BkSFlvZnZ3dTRkOGZ1MXRvYkVXOVda?=
 =?utf-8?B?b1pmcHFzYU8xVHpxc3luanIybGdSemhaSmNmSGZVVkQ0Yk9URXc2VzJCTWk3?=
 =?utf-8?B?WDlkSU00Wjh6ZDhlQnB6dUcxNnpHTW53QW8zYktBYXc2RjZhNFVoVStwYnJB?=
 =?utf-8?B?UTQ1TTNuOGd6eHdEL1Qrb0pxeURkdUFMS1B0TDA5ampMNTRibkVzbkpCbWFu?=
 =?utf-8?B?RlZWTEV3bXlLRHFETDY3aTBSZmxzOFVRbjdkeTM4WEtuUDkvS3ZZdlFpTGFL?=
 =?utf-8?B?VVR2WS81dzg4elh2UGFWbUhvN041M08ybWR0ek9IWEJVdHVUak9YaU1aOHgw?=
 =?utf-8?Q?OPlIazHZisAY80iv/RfJVsE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF608735CE260E45AA15A233839DFCAA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0db7eeb-e67a-41aa-00e4-08dad2e99ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 15:43:27.9340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/QgKmsWnLkWr0nYyPZSBfD4a5PiMKVj/QJ7R4vA3BiMXcI53RDj7Lf2BC7czcDAoi31ahuDfkzdLveuMlxPQfxuhMv2rkBa3jWiM0QAXXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFyaywNCg0KT24gV2VkLCAyMDIyLTExLTMwIGF0IDE0OjU3ICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiA+IMKgwqAJLyogcmVhZCByZXF1ZXN0cyAqLw0KPiA+IMKgwqAJY2FzZSBT
UElfSU9DX1JEX01PREU6DQo+ID4gLQkJcmV0dmFsID0gcHV0X3VzZXIoc3BpLT5tb2RlICYgU1BJ
X01PREVfTUFTSywNCj4gPiAtCQkJCQkoX191OCBfX3VzZXIgKilhcmcpOw0KPiA+ICsJCXRtcCA9
IHNwaS0+bW9kZTsNCj4gPiArDQo+ID4gKwkJew0KPiA+ICsJCQlzdHJ1Y3Qgc3BpX2NvbnRyb2xs
ZXIgKmN0bHIgPSBzcGktDQo+ID4gPmNvbnRyb2xsZXI7DQo+ID4gKw0KPiA+ICsJCQlpZiAoY3Rs
ci0+dXNlX2dwaW9fZGVzY3JpcHRvcnMgJiYgY3Rsci0NCj4gPiA+Y3NfZ3Bpb2RzICYmDQo+ID4g
KwkJCcKgwqDCoCBjdGxyLT5jc19ncGlvZHNbc3BpLT5jaGlwX3NlbGVjdF0pDQo+ID4gKwkJCQl0
bXAgJj0gflNQSV9DU19ISUdIOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJcmV0dmFsID0gcHV0
X3VzZXIodG1wICYgU1BJX01PREVfTUFTSywgKF9fdTgNCj4gPiBfX3VzZXIgKilhcmcpOw0KPiA+
IMKgwqAJCWJyZWFrOw0KPiA+IMKgwqAJY2FzZSBTUElfSU9DX1JEX01PREUzMjoNCj4gPiDCoMKg
CQlyZXR2YWwgPSBwdXRfdXNlcihzcGktPm1vZGUgJiBTUElfTU9ERV9NQVNLLA0KPiANCj4gV2hh
dCBhYm91dCBTUElfSU9DX1JEX01PREVfMzI/wqAgT24gdGhlIHdyaXRlIHBhdGggdGhlIGNvZGUg
aXMNCj4gc2hhcmVkLi4uDQoNCnlvdSBhcmUgcmlnaHQsIHRoYW5rcyBmb3IgdGhpcyBoaW50IQ0K
SSdsbCByZS1zZW5kIGlmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zIHRvIHRoaXMgYXBwcm9hY2gg
aW4gZ2VuZXJhbC4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5z
aWVtZW5zLmNvbQ0K
