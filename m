Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAE60D4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiJYT1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJYT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:27:20 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4CDD18DC;
        Tue, 25 Oct 2022 12:27:15 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PIqcAQ006619;
        Tue, 25 Oct 2022 19:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=DAXj5SU5jzrqaFXsQo9Q9VawkMWFbW/mB8XiWxvydMs=;
 b=nXU8WgGGfniCFrlb2wAuhP0I2Fn/+JhY0tyGACS7BsRjWoyCu8NyPaJ2FgiehkUcHSv5
 TVZq6GteFOd+hyi/XdyWwrHO4X7EqSvI+PG8XL1xsIFlcIbWblqkqaqZ5kpVpLbQanC+
 1JoRBul9tffrbFoWb9dXPuqcw7xcwyUDB2feZRUPw/l2CeepjyuAbejLeIwu5ks+f3cj
 pdALaVm7eAKooGhMpCGY7mVelPrx5tEnqPgUR4OtQcmBVdy9nYNbfKvrrfsEiWfw+gV6
 y0pPZWoWVRDf8nywMYbJq9SW8fgL9SZHjan9Ic+Xo3DeSudJnDy08QhwqXC/3WmicJXS lw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kem54gv7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 19:26:52 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9FF83B0;
        Tue, 25 Oct 2022 19:26:51 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 07:26:51 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 07:26:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 25 Oct 2022 07:26:50 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 07:26:50 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djRe5eiGhujB4BBIUDmXijCXl5LbysR3sdcDu8m2l2sf+ztxiSYMWNRFtxcbvt5IVHoMMJAVyqCVkzOH8CGwig7jW+2LXCeTsS2+USzXgtN4XBte5YlVYBfyTjMF2L72UksU6hKYgzGTkwcETOcYW01cqIaLB9Gg0mx4qXbIKuO7mcUGNp5+PB2RrrZ6SbeG7fLEmG001yb33oYE73Xm/m3xPqdF+Q+Cca6gssx/VPGc1rjmUNm2kbV9QxLoQnxXUW1onP1ChrqAkRE9Fsc+bALE2G/C0rtV5KAbotA+Tp8vuFNWsbXgxjc6QrGKVJ8cOyiwrV9kALUoXmoJtWWnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAXj5SU5jzrqaFXsQo9Q9VawkMWFbW/mB8XiWxvydMs=;
 b=WlSQVSI7ZxCeJ0T/0+fNeQ46rG8fylXoUkHSIXkfRHniDjn1FFe3YRVx+Fm+9qm47Svl9it3mO+BHCiOVS4aViLOVj9ME5BYIdRqhg/VAs5W5skXTnD3U0VD209/1SaMLJsgCorwKusgvylfp2xEQn8xrVw1yBEha1AZnV3TLTDcoAQoRiP2eSybfTG4gGeiuhxqD15EtagiIYvyPz4RDuuZ/Cz7nNYSG71dBN6aKjOQqdymOCuJALC1mppKFTCSLwOQQxmsO67cCWpttuG9ZZ4MxbiGxJPqBL2nI93S8MiDszCTDX8t+MnyP/Oc2HGFiiXZL4Fyqo4B/coC8DTv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1589.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 19:26:49 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c%8]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 19:26:49 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Topic: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Index: AQHY3aMniIVqm01b3kyrrbcxm5Jgf64JpGIAgAGGr3CAD3YZAIADo6MQgAANroCAATMrwIAABbaAgAAFUBA=
Date:   Tue, 25 Oct 2022 19:26:49 +0000
Message-ID: <DM4PR84MB192759035B110DE54EA9B63688319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
 <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
 <DM4PR84MB19275D8DB8B27CE0D1A05AA588319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <7c9e943a-4806-6339-cee1-9156e7792111@linaro.org>
In-Reply-To: <7c9e943a-4806-6339-cee1-9156e7792111@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1589:EE_
x-ms-office365-filtering-correlation-id: ca24c82a-7f0b-4b38-b429-08dab6bedd06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JB1FfTVRuxoxXBgXFqZCFEmAzP+BGiwwnNPk3E9SkFdnstRdoa3ZXFz2TrOBMz9GMJtjdtARLkM0t5R05FNAPcyzZcc15dDnnWPXqg3MFTjj3AaaT1N6rI3A4nta2NzyL/ZL0+J3/byFbPDufeQPkTNnhw9B9As22sc66iVWm1Xif6VOu8xcfkT6QaFQvCKMHHIAqz2Qp4Yx3Kc5xlVJIPK7Y8Azi8NvWIthAc3fYw3zipx/vCA6iZ4+/oBlOaUozxlBrPk0PGA0ptIWRxc9LFBUlLYA0sciysQ8Cbnn6LkB1Uw0kzvblYPVhtp1ShXRVflEzoDnsZuZ+IUpK9hRVjchBjSsqBjumHTmonsEAxWjW7wvd/xXA7dQ1g1hq+9vB+sUcbVqAp59gxDWKfCSTXBd0kEKexGTCGn4hU638l8bC7JFk6XYzYnYacQsbezGHZCswnXFjzHXi6M0eBlEBsgTR1O/26o3c9x41hdMJ4kLTFNXR8c40iuWO8DjPlyQ0ONrCaCIv+qihB0t2TWo5WJv7Bx+IAFpJj76syS9+yXPcQKESaEbl6JLbyLZshwUfeyAAj0p34Fu8j3BzNYkjqkxxtwUyHK2vdgUrGSxVkCJcVNyzsaheg9EngUd6/u/JvHKwGemcDxVDRLwFmqn2UcSkkD0TiojVL8XsnK8tWqNA+d48BHd2GJJ8LCcwj4HrlApwYuJcbDwsqK4bzZGgk4r7BdwWpjfoiXZPsYC/uQFFY1LnLNP2taNWR8DVuotungT/gsydECQ+PbCjSm7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(186003)(38070700005)(86362001)(38100700002)(82960400001)(2906002)(41300700001)(52536014)(8936002)(54906003)(5660300002)(478600001)(4744005)(26005)(76116006)(55236004)(71200400001)(6506007)(7696005)(4326008)(8676002)(122000001)(66446008)(66556008)(66476007)(64756008)(9686003)(55016003)(316002)(6916009)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXg5MHFvRXRDL0tJZUVSWk84Z2hNNXpDbmVBbTFNTEc3QTJqSjU0dUNlVm9h?=
 =?utf-8?B?OVpyL0FXeUNDaHNsV1V4cjYwVjdmcWpOUG9oNEVzQlpFTHc0ZXJ3cUN5ckov?=
 =?utf-8?B?WEdzUHFZM3RzeDFSVHZZc3BqbG85Y1ZSL3Nsa3JEZTFKd1BGTkUzcDFocGtI?=
 =?utf-8?B?ck1jQWNidE9SRU9XZGdvL3pVZHRtT0I5N3k0bGdEQzRCdjJINmNyTGVVZUMv?=
 =?utf-8?B?S3V3QmdFclhmend1bFM3K0Y2aHpla3M5SE1YTncwWDlTZW81RXdkTndqaU5o?=
 =?utf-8?B?bGJBVFBrRGx3WUVMRjBrd2JBa2lzUXBOV1QxTURLOFNXM2dGTUx2UjdVYUZk?=
 =?utf-8?B?d1JxQlZRQTBiN1QwK3ZVVWhPY3dVeGlhMGpRZ3RvOW9GOW5ra3NwUmVhOW5i?=
 =?utf-8?B?bHVPdjd4NVVIcGRiTWNrc2xqOURHdWJIUldrRytpTTU3VEoxZm8vSVYxVzFk?=
 =?utf-8?B?YnJCcC8reGovL2Fyck0veFlMZ2pvYzF5Rm1JVWI1ZytJUkw3ckNlOUpSdE1N?=
 =?utf-8?B?aFphZ3JHUmo0OWFwbWNJTjZlSjVJcUxDVkVOYVZ0ZkNiR0wwbkhQb1I5QTAw?=
 =?utf-8?B?NnZrcDN6bUFNc3ZjSlBTSTQwd28wSHFOSHN1eVcrblQyVEVRa0VIU3M0ZU4w?=
 =?utf-8?B?eDlPT3Y5Y2J0VXpVbVZGQzNtZjlSLzBXT2lJd3hjRFFFWGJ5VnE0a3JQZjQz?=
 =?utf-8?B?eWdpMnRhN2ZGVFJnTWJMN2Zvc3JLbHNkeDN6clpsbjB6a3hQWFhpTDdiUHBW?=
 =?utf-8?B?aElFb0x0UmI4ekpnYTYwVFdhNGJUclc1YjhiWHc4alpTSEdIeTZhb3B5VVFR?=
 =?utf-8?B?REJjSWlVbjQ5ZW15TE5JK2ZleGNDVlpRclUxM3g0YTFTKzBPeHBMeE82UWdm?=
 =?utf-8?B?STlxeHR5Vms0bDhld2JsUW8xNm8zdGJCS09tRlRldXRGV2R6bWlPaER0THJh?=
 =?utf-8?B?VFhWT3cwZkpSaFdraDNDUmxvWDg1eDdFcE4zbTUzNTB4YnFtcy9WSnVNeDlF?=
 =?utf-8?B?ZnJFYk9yK2hnMllEVVJuOFNxdHI1ZklZaUNvT2JHR3hIczA1ZFI5UUtkQ09H?=
 =?utf-8?B?V1ppK0hDZzN6aVFhd2VZRjdzZTBxd0Vjc2FCb0V1V1JLK2gvOTFncnZDLzZM?=
 =?utf-8?B?d3duVXVYU3ZmblRlaVdTNDcwYkJVdFFKMlBCOHRFTDJ0R2J4dUZ4djFGd1ZU?=
 =?utf-8?B?MC9ONTgxOEhla01NOEV0bHo3bHI0cFlhMmt0Nkc1SHR0YW1nZThoclRFdlQ5?=
 =?utf-8?B?MDhxaHp1dlNzdFVBTGVSbUdQRzFSaDVjUFNaT0VtQTU1YkdBZENUdm85L3Vt?=
 =?utf-8?B?Q0hzcU8rUjlZYW43K0h0SkRrSFhKdWRxUGVzUjFjM2tITERITGh6L1dyUzRQ?=
 =?utf-8?B?bXdaN2dQVWl4cmlVL21sMm9FWHpRMzRvQVZRRjNGTVkzL1Z6eWVzRm9zeXhS?=
 =?utf-8?B?NHc3NmJoUFc2OFlEcStUdXJlTVpRN1ZoWDNLZ1c3amY2SHJWNXR0RWZHOVJo?=
 =?utf-8?B?SjJQUlM3QlQycS9YYkg0eVZlc0FDZUJZeUV6OHQvQVJzd01HOEJWT0w2c3Er?=
 =?utf-8?B?Qkw5MUxaakUwTGRtSU92Tit3dTBEOHJNL2tKeEhZbi91dnpVMTIrN2xrNDZF?=
 =?utf-8?B?QUttOWFJdXRYNFpEOFN5bVB4TGdaL0x1OHZKSVlZcG1zeUlpQmdKTFgwRDRy?=
 =?utf-8?B?bDgxVklQWEJ0SnhZVkM5aXdqU0xJN2lGU21XMHJUc0lmUWN1elRUSGJLdGsz?=
 =?utf-8?B?R2Y0TjBtczEvOEt0bEhsTXB5Q0ZVVWppZXVqMld4QzBzZUVoZTc4bUJLNmF2?=
 =?utf-8?B?emgvUWtZUWs1TUxwN3o5aFl3QVo1eVAxSXVzQjB4aHpuV2Q0MURXTG9CV2xr?=
 =?utf-8?B?UW82MlBheE9rTmxsOHorRmhGUEw5aWZDTG11R0pPV1BNY01paWcvSXEwUXRn?=
 =?utf-8?B?RWFYdXhQNXJ0by9aYVgrL3hxSGorRERpVkdQMlJuOVVwK0I2V2NJZm16eFo4?=
 =?utf-8?B?eWlxTjZUTXlGRTM3ckR5Y3k3clREV1ovZWxZeXo2NUFadnlGK0swdzJMcndC?=
 =?utf-8?B?MlNrZFl4VE16LzMydy9vM01SbGJySWRiTGErR1NvS29FNi9sOFV3dVdUQ0NU?=
 =?utf-8?Q?0kBzak18Nhy70X3pa7kC0uW4Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca24c82a-7f0b-4b38-b429-08dab6bedd06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 19:26:49.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVC/www0vhjA0TuZLe2Y+7lQlhzqcwR9VVgvA18XsMm5sovEi0t6wPTb3WaET3f185dU4gMMhtxLPXeigP4m4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1589
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: eSSNPI5HQp6pejGvBS_wpI2DrUCB4s7W
X-Proofpoint-ORIG-GUID: eSSNPI5HQp6pejGvBS_wpI2DrUCB4s7W
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_12,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=557 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210250109
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEkgZG9uJ3Qga25vdyBleGFjdGx5IHdoYXQgdHlwZSBvZiBkZXZpY2VzIHlvdSByZXByZXNl
bnQgaW4gdGhhdCBwbHJlZywgYnV0IGluIGdlbmVyYWwgdGhlIGZhbiBkZXZpY2Ugd291bGQgYmUg
dGhlIHJlc3BlY3RpdmUgcGxyZWcuIFRoZSBzYW1lIHdpdGggb3RoZXIgcGllY2VzIGxpa2UgaHdt
b24sIHBvd2VyIHN1cHBseS4NCldlIHdlcmUgcHJpbWFyaWx5IHJlcHJlc2VudGluZyB0aGUgcmVn
aXN0ZXJzIHRoYXQgdHJhbnNsYXRlIHRvIHRoZSBDUExEIGlucHV0L291dHB1dHMgZnJvbSBvdXIg
cGxhdGZvcm1zIGFzIHdlbGwgYXMgaGFuZGxpbmcgdGhlIGludGVycnVwdHMgYXNzb2NpYXRlZCB3
aXRoIHRob3NlIGlucHV0cy9vdXRwdXRzLiBXaGVuIHlvdSBzYXkgIndvdWxkIGJlIHRoZSByZXNw
ZWN0aXZlIHBscmVnIiBkbyB5b3UgbWVhbiB0aGF0IGVhY2ggZGV2aWNlL2NvbnRyb2xsZXIgd291
bGQgbmVlZCB0byBwZXJmb3JtIHRoZSBhY3Rpb25zIHBscmVnIGRvZXMgaW5kaXZpZHVhbGx5PyBJ
biB0aGF0IGNhc2UgaG93IHNob3VsZCB3ZSBnZXQgaW5mb3JtYXRpb24gZm9yIHRoYXQgcmVnaXN0
ZXIvbWVtb3J5IHJlZ2lvbiBhbmQgaW50ZXJydXB0cyBmcm9tIHRoZSBkdHM/IENvdWxkIGl0IGJl
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCnBscmVnOiBwbHJlZ0BkMTAwMDAwMCB7DQogICAgICBj
b21wYXRpYmxlID0gImhwZSxneHAtcGxyZWciOw0KICAgICAgcmVnID0gPDB4ZDEwMDAwMDAgMHhG
Rj47DQogICAgICBpbnRlcnJ1cHRzID0gPDI2PjsNCiAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8
JnZpYzA+Ow0KfTsNCg0KZmFuY3RybDogZmFuY3RybEBjMTAwMGMwMCB7DQogICAgICBjb21wYXRp
YmxlID0gImhwZSxneHAtZmFuLWN0cmwiOw0KICAgICAgcmVnID0gPDB4YzEwMDBjMDAgMHgyMDA+
Ow0KICAgICAgcGxyZWdfaGFuZGxlID0gPCZwbHJlZz47DQp9Ow0KDQpUaGFua3MgZm9yIHRoZSBh
c3Npc3RhbmNlLA0KDQotTmljayBIYXdraW5zDQo=
