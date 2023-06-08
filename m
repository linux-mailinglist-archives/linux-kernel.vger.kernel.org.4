Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1195728328
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjFHO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjFHO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:58:31 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8311FFE;
        Thu,  8 Jun 2023 07:58:29 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358CVwVJ020111;
        Thu, 8 Jun 2023 14:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=CSdJqRzkwvUN/dWeuzuakDkkkkKKJSvDDPRXEaiwR6Q=;
 b=hxtU+pm6nM9PfedVv/FGviwZIrjFlXj8A09Fna3HtkkDOQWpykvmW7z4I6bxialRBD2V
 rRfnKCTG0bJl0r5+AwQJmUeJAO8Tr/bjx2urvO7heM7+PhL5Tpz2fHXVU1maYll/19ip
 FosHP4R1WjufWS6BoNQmPQQlezbotzcUqcjMyKE3eXjnH42auD6ktHUgE0xx/mVXvxrM
 EBNiZQPm6acekEe1BiGAjMxcNcJBfYwQ4l7HtH1OFA/HiDcZPscK7vEO//BQgAV4DoLj
 Uhx6JvcCFvHbunbIxTEWmmJFVD2U6FwfDoqlEjNZg9i6d0qevU9UP0zqPbBrifQCh2Hk fQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r3ass3vcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:58:05 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 12E0D130CA;
        Thu,  8 Jun 2023 14:58:03 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 02:58:02 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 02:58:02 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 8 Jun 2023 02:58:02 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 02:58:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG76CtuN/r+FUhCb1IMg39sIHgpzMwNARj58IyACiDkrmfasCTvgptNO4vpZxVta+xBhNKznCeCZLgy8e9p08TCNuw8x0M90eZTJqOWRsNcdx+FzcuU5odDkyuRM1pzXp1C+OLTcT8FSR4hka/sPwlxjKXmJnNOSbrQLfplvB7zkgJJzzd8RjqrSScs4AXoDm0LRbc/epkwWPKFLEcXw9nSpd2pTXhE3ZWs6AdAU2MdEnd+TOMOEw3k6rs5N+tyFTfTRNLRRy53Bh9K2iD4a0QG7AygYRh4cpUm2Cn/RP4MsA9CXblwOZQeTh89zf/kbENogBymyIJDNXKeZejaqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSdJqRzkwvUN/dWeuzuakDkkkkKKJSvDDPRXEaiwR6Q=;
 b=k5DExoa/hI2go0ob2zbYlCDzOGQgKt0Zaudp8vwvZclqQ8k/6SsyoIBCaOBwp2T0HLNM/mA5xZalWsocivK51Vn0nHuSwfgcUFqgs90ShE8xVKLVfWkrs+IwvxIhdGNM0vrpHf8iw2H4Hi3+cZPqESSOGRkfX90Gx+lajIkibe65rdOeNXUEdYOW+HcW/bPraiN5wnaJEJWFBo3aBF32d0FQgmBUud8/QgEaySTkCtw4Wu26WHaXtrKJBRCnaa3hSn46OlONvpGLlXeeQfUw4bDcOyhylxvLoVK0ABRZhwCu/l4idXLsGZTzSGt+599aKnk8SWSp7v0Xh+R1IW9Xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH7PR84MB1413.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 14:58:00 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%6]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 14:58:00 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZmBjF4JEt/zYBEESMQ0szz/IlCK99gJKAgABZOsCAAG30gIAA6I8AgABaYAD///NGgIABOCoA///5GIA=
Date:   Thu, 8 Jun 2023 14:58:00 +0000
Message-ID: <B5D811E0-714D-45E5-818A-8AD18905AC29@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-3-nick.hawkins@hpe.com> <ZH76x6E9cbfrJHeu@surfacebook>
 <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
 <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com>
 <CAHp75VeZkLSTw8OFmDMYb+im0qK0NQRHpndzBM7fMHm=HZCzeA@mail.gmail.com>
 <7FEECBB4-482E-4719-94CA-6D10E4C08078@hpe.com>
 <CAHp75VfQguYENE0EtZ-ou=CXo0mAmeDT9byTu6hffT6w_cgM=Q@mail.gmail.com>
In-Reply-To: <CAHp75VfQguYENE0EtZ-ou=CXo0mAmeDT9byTu6hffT6w_cgM=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.73.23052700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH7PR84MB1413:EE_
x-ms-office365-filtering-correlation-id: 22cfd63c-3ccf-472b-f25c-08db6830c0a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9ny9CSsTABsdnxeoUyIjHGvEqhId6dLPUMBQ73nPPnUU6aA9SxsHaWzV7iWFXH0Eii+yqwntmdytYhljnU2NiqMu0i+2L16TI79CQq1eVgtyistSCNrwHg5b2/x3lMP3+3M45MoFw1xbja2lTnYYiviZPgdPJYkJXbtR8mhFIjOoRX7hciR4upBPLyivx1X4H+gvtCXK15Q2HWTYLNb93YonXM4dnpf2+6fy80q6U4t22ildwsaEWPgn21JuWgMxhHY6+xi4H03wzrZ8RraeDGSbamNYRjZEbXyd/o9yH/th5gxEaoXqKf5ZSxK93RD/X9S8ILD1oTGJge6YzB4PeZJiAc76TF2rTDGI8Gk6HdN5i9rBeUjrQTRiAaH7ghzEw0OsaUCHxrlRfOypxj0OztgGlKyJ4ykGpXvCIgbV7TJX14ZiuDqcTuAActZZO4qQtR4oKcFI4dorv74F4rIvruE3BWx0c96j3Zk5tJwG8/r3gEXuRgOKNdGWXXLnAZBPa6Dmdj2RoImAWrqd8+QBc6MSZgpYZzRyl4i9U976sDc1YgdEDaRrqAJGeQR0u0uzDrBIihhbhXi8KK2G9uYNg/6Jb33zhaoNetGV6EoV6XVWS4WytgxOPibA9GnH13SEBadgv2Uu5J6EAN2aCsiTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(71200400001)(91956017)(64756008)(82960400001)(54906003)(316002)(478600001)(6916009)(8936002)(8676002)(41300700001)(66446008)(76116006)(66946007)(38100700002)(4326008)(66556008)(66476007)(2616005)(186003)(122000001)(6486002)(83380400001)(6512007)(6506007)(86362001)(7416002)(38070700005)(2906002)(4744005)(33656002)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHhjb1AwVzRROE9BaUIvVHZoaUdrL3dvNHpWNjhlcXE5WEVESE91SXVZeGNN?=
 =?utf-8?B?TjY3SklJYTJ0c3N5TXlyT3hieVVIaXExWG04UVZrdDJqNitLOEF2UEkyeGtn?=
 =?utf-8?B?VzFsRWIxd3hNZVcwb2laODdEYW5kV3A1WHBENm1SRk1PQzZFcFVlajBRYVlY?=
 =?utf-8?B?TmlZSWtCQkU1N0FYZjVVcjZuZlBzd0xCNHd0MzJ1elVpVzZlZ3NBcllid00y?=
 =?utf-8?B?Z05hOUFneGQvQWVweGdpUU5FcnNQYUNlMXVFUHFqMlVNdlRvc0NVZUJWWlk1?=
 =?utf-8?B?TnExUGhuVEZ6b0JOa05KcnRTS090cE1YOEwxeU1TelpteTRXWGlOU0Vsdzl5?=
 =?utf-8?B?NVhmeFMwWXh1OEcwMVdxYm5UM29BQ1UxbkNXM2E1bklCUjJUa2IrZVBTQ3Bk?=
 =?utf-8?B?OW85RkMrSDVMUGJRbXZPVVo4UWNGRlJaZVFOYWNMcURJZzdmdVVaMzExeGUy?=
 =?utf-8?B?anhCMHNRNys1OHp0bFZKcUNGN05Xa2FkOHRxREhqTTUxbzFFaGhtbnZYMDAr?=
 =?utf-8?B?T2JLUnpNc1d6NUo4c2tNWFJmd0dKaHJkRDJEYkNQVFBSNGh4R3pScW96SzBE?=
 =?utf-8?B?Q0o5aEp3Tlg2MG1vT0ROWE9ES1FaT2x1R2pJWU1hcHluM0ZqamN3VmZUWlcx?=
 =?utf-8?B?Y211RDIxRHhFcEpGSExSVTlicFVEUTNPMVdyYlk2V0tqUEtyZzFack5lWlkv?=
 =?utf-8?B?Ykd6ajZtMStjR0ZJTUF0N0lFQUcyZzJweUliQlduaHdMRExuMDNORk45NWxx?=
 =?utf-8?B?Q1dJMlVtclo0dWdaOWdCbVRKUDBmWVZwUU9LcFducDFvNUpMODZkaXVOaFc2?=
 =?utf-8?B?a1FMR1o0N3FSMTArdEI2WnhJNFRwK0hiK3pTSXorTXN2MUhRQzNMNGhHeEtB?=
 =?utf-8?B?OFl0RmhXM1BMOHd3aW5PYW5xRjBSYjhFRFBkRDF1ZkkyR25McyswNDlTaFRx?=
 =?utf-8?B?QkFsVU1Va2hYQnhFemtEcXRTYkJsRmJVWDVFQ1YvUzZhZW9TTGtRd3hwdFFw?=
 =?utf-8?B?MXNWTkxWbFlQNEJVQW05QndUQy9NUS9BdjI4Q05IOFRENmptV2tFcFdoRkpo?=
 =?utf-8?B?OWkrZmd6UUxyUFZaZW5LODgvc1JjQU9qVDY2R0dYY0RpaXFaVDBMSGtOWHlu?=
 =?utf-8?B?Vm9SM0VDWmEwalNHZ2ptdnZKQmFqU1RoOTVIV0c3MVFKeFAxSjJaS3ljVklp?=
 =?utf-8?B?WlFPYkFoZlliVXpNRmlZSElJR2dWSURtOTkwMWZhZDVpWGI4cFBMMm1LNEdQ?=
 =?utf-8?B?QWFaNE1oUTY0aG52ODhpS3Zrcis1TkdBSTRkVEFzdEJiM2NJNWFxTVNCMWpn?=
 =?utf-8?B?OXpXRmZzNEk1bXh6b2xod0VsdHNiSDBkTUFYVVBMV0o5MG9qYnNzc3ZGUmZl?=
 =?utf-8?B?UVpQSDJrQmZYcDVkRWpLdHhVNXZzZ1pXeUNzU3puc055VXFTTlh4RW1GM1R5?=
 =?utf-8?B?VnNXOUlxbEI2LzNXa1hlSUIyU1VlTXRyN1ZNY2JCakoxWG03R0xITDJVVkdm?=
 =?utf-8?B?V1MxUkM4RFVBd2x4bGxrMEwvTDNVcnovSGNyMzFlNFFjckU1clVkNFVMUlgv?=
 =?utf-8?B?OEh2SlJncVpmbE41SExZQmJoc052YzJqMGdDRVJVSW5HSVl3dldvQnp1S01E?=
 =?utf-8?B?ZktoUTRrK1lEVmN0RDY5TEI4MlJSSW9jZGxqb05HQ25JV0VQc3ZTRm5IOVRo?=
 =?utf-8?B?Mk4rWGFzWGhVTzJIL0oxZy9iakhnays3YkFTazhNaVZRRlFsVlZSNWtSMnF3?=
 =?utf-8?B?MWZBclNCZzVFODdQMG9RUGNNQXM2end2N2J3dDFXUGlSZFd1S2ZyUkh0bHFZ?=
 =?utf-8?B?UWRLYkRpT2RhMExuU3R2NUJqOHZjanVXTEdnTUhQRXNvWnpUYSt2UkxhTXZK?=
 =?utf-8?B?TkRXbkVRNndORnVhbm51NzlPWXFHQkF3QVY4VTZGY1hVWFdTR3VuODFyNkZK?=
 =?utf-8?B?RnVoSVdmMWZrZHlDS1Uyb0lkVXRTUzgwZ0h4c2R1Yll4VFg4UVFqdERYbzhp?=
 =?utf-8?B?R01sZUMvNjVNS2RxWVpEb1g5dXJDUmtLcUdXc2NGNzZiRHhXU3dtRVZnYy9I?=
 =?utf-8?B?ZC9CTllkRmJqUHdZdE45SjE4QzFRUlRZZEpmb3Q5bXV4UmRDSHJEU2xZa29B?=
 =?utf-8?B?TTE5aVQ2V3picm5YMkxnK1U2Q1NucklGWlRneVpSVHNyMTQxUndyU3hJVGl6?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8212D94529EE5E499ECB145212D3F0C4@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cfd63c-3ccf-472b-f25c-08db6830c0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:58:00.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0x3nsUi97NOF4XpqsIA3Rztf7hvGXvXzzYQMw/yXNZ1G+d+c0HsjpvIgczk0cj6R3N4hTBZ5MSQszuXli/QPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1413
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: c7Rl2zaMpH7FLx4QsbYo7WzUl1BiowXg
X-Proofpoint-ORIG-GUID: c7Rl2zaMpH7FLx4QsbYo7WzUl1BiowXg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_10,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=518 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gSXMgdGhlcmUgYW55IGRvY3VtZW50cyBhdmFpbGFibGUgZGVzY3JpYmluZyBob3cgcmVn
bWFwX2dwaW8NCj4gPiBwb3B1bGF0ZXMgdGhlIEdQSU8gbGluZXM/IERvZXMgaXQgYXV0b21hdGlj
YWxseSBnbyB0aHJvdWdoIGFuZCBhZGQgbGluZXMNCj4gPiBmb3IgZWFjaCBzdWNjZXNzZnVsIHJl
Z21hcF9yZWFkIGFuZCBiaXRzIHBlciBieXRlPw0KDQoNCj4gTm9wZSwgaXQgYXNzdW1lcyBvbmUg
Yml0IHBlciByZWdpc3RlciBvciBzb21ldGhpbmcgZGlmZmVyZW50IGlmIHhsYXRlDQo+IGNhbGxi
YWNrIGlzIGRlZmluZWQuIFRoaXMgaXMgbXkgdW5kZXJzdGFuZGluZy4gVGhhdCBzYWlkLCBpdCBt
aWdodCBiZQ0KPiB0aGF0IHRoaXMgaXMgYSBsaW1pdGF0aW9uIHdoaWNoIGRvZXMgbm90IGFsbG93
IHlvdSB0byBzd2l0Y2ggdG8gdGhhdA0KPiBsaWJyYXJ5Lg0KDQoNCkdyZWV0aW5ncyBBbmR5LA0K
DQpUaGFuayB5b3UgZm9yIHRoaXMgZmVlZGJhY2suIEFmdGVyIGV4cGxvcmluZyB0aGUgZ3Bpb19y
ZWdtYXAgaXQgc2VlbXMNCml0IGRvZXMgbm90IGZpdCBteSBuZWVkcy4gU29tZSBvZiB0aGUgR1BJ
T3MgYXJlIGEgY29tYmluYXRpb24gb2YNCnNldmVyYWwgYml0cyBpbiBhIGJ5dGUuIEZvciBpbnN0
YW5jZSB0aGUgSGVhbHRoIExFRCBvciBJZGVudGlmeSBMRUQgaGF2ZQ0KbW9yZSB0aGFuIDIgc3Rh
dGVzLiBJZiBhY2NlcHRhYmxlIEkgYmVsaWV2ZSB0aGUgZ3hwLWdwaW8tcGwuYyBmaWxlIHNob3Vs
ZA0Kbm90IHVzZSB0aGUgZ3Bpb19yZWdtYXAuDQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lucw0K
DQo=
