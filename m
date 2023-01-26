Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF44E67D49B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjAZSsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAZSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:48:33 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F25D125A5;
        Thu, 26 Jan 2023 10:48:33 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QIFmmx029109;
        Thu, 26 Jan 2023 18:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=z6iGKlRYLps+jTDyuqxFRkHUyCzp5wRtU7+kuwxUzM4=;
 b=ENHRImyowGOW6abXLUJBgIfv5N5VDWMNu9yJQfmVMdmkBKO9trsiGBVtgfFBahpYG3yb
 5KrYezLajzGileB3qwe9fMQEl9Cj2RIxv48JcZrWnZVqcAANeU4jzOyYJKR4vhNgtwsD
 JNSE2KitgOmlRXx3M6IqJ5HtDB1Pj1uli9C5fE854jjJQ41fq16/DJMnApDX+m2tPaSI
 nThfieZFVCmnrhPIlMVxjiK+RdppiFesxFqqRViLKKgIeatd5YSIboxjxVgga0+7r7Nt
 BhnXIK3JxORNAepYD9Kk5WwhiAVjPWZ3SjlawE2gRZh+devGRR9+Fv5u+VySYP481cj2 zA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nbxn18ase-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 18:47:53 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9D76C802B8B;
        Thu, 26 Jan 2023 18:47:52 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 06:47:52 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 06:47:51 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Thu, 26 Jan 2023 06:47:51 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 06:47:51 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKCvujsVUfKp9qao8K9Ht/hRaVcJHzBIxUe+Ys6f6GOlgwC2JDxT3Jln8PG6o4tgrTrC5YPsRksxNr3W08Mg9jR0Mca79XP4Mde3FAszUFQNmYWxCahq9cv9MuwN6m5s/vr61iy2Gghuxfj2W8vpDA3eDeqSgIoTQq/7L8Gv0Y0bFfLt506dLCxfZZLYNTMHn8zb4FGBJ3/SZOET5XJ81t1DG+OUVVvIupxWye3SVN/jGys1ILCvPQhzxpE6aK/MPYQyx/yvEoK3EXT9HbMd4N9DH/TN4YClePKrakDrG4WqQX5Riq55pJL5vuvvZXVX9J6dEM4TAd6x6y6DFYioHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6iGKlRYLps+jTDyuqxFRkHUyCzp5wRtU7+kuwxUzM4=;
 b=IwUu5XGxKeRN4eHwXXaIR5MK8BwO7TtBa/6biogHReuUW18+tiivHoZy3H2I9lcGvCIkn1geiN34JESEUJh3sc4XKc4+AnxYM/2zLT4gxD3l8sUgoH3WqF5W2N6cSdqFiMRhSuSxx6x6jco7mbn1SB0IYYgFLVVCKWkJfzIO59SU2RPWXpXyd+dwuyzVnUfKkP4wcgtysvkPFMg0J9j7uz5iuLpwtfQI8t+V8aR30uM13uhlJamY371p1Ts2BHR/Lt0SB6sGFwPfYQzdCOKW1gqRK33dfCA8ij+ZQt2+0/5wbPShN98PHuVCLbXEFaQz22BUxJe2Yz3n9nHQBEjTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1693.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 18:47:49 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de12:a5c2:5c71:6b87]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de12:a5c2:5c71:6b87%7]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 18:47:49 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>, "soc@kernel.org" <soc@kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/2] ARM: dts: add GXP Support for fans and SPI
Thread-Topic: [PATCH v5 1/2] ARM: dts: add GXP Support for fans and SPI
Thread-Index: AQHZJ2lfk+jpPufKQEOV0siwBkdGmK6u2XGAgAHghIA=
Date:   Thu, 26 Jan 2023 18:47:48 +0000
Message-ID: <F8471156-B710-4D2A-B9D5-3C022F0B3DA5@hpe.com>
References: <20230113160651.51201-1-nick.hawkins@hpe.com>
 <20230113160651.51201-2-nick.hawkins@hpe.com>
 <e9b0338e-3b2f-4b54-8547-ab8babf7c0e1@app.fastmail.com>
In-Reply-To: <e9b0338e-3b2f-4b54-8547-ab8babf7c0e1@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.69.23011802
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1693:EE_
x-ms-office365-filtering-correlation-id: 31407514-46a0-494b-6bb4-08daffcdd25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0+CoYMPoo7CN+pzcsroSpZ9H2v42gCyrU1FyaMGWsll3SvaKHvuF6+o92/4Zg2ApLS/50gnvpm/YZOOxoxGbbVAGwFIBgyRBrcJfq3JvKTi7znvzo80dChu4/GNkDLncKNs8vK9B+PUyTbPItBHLwCmljBB5qel2y2/S5oXbmSCjTCZcM9+nUrF5X1GcIB0+cGsyD/NMQaP3QMiSU0ZH/JdBwgcCEYBDQwMW+wE32K8HixpPK8LGoqR4du0cVDRwSwSwg/Gs5qTNMcJ7VSkPpSEQYSx5o9qr/KDUohlqQ8arlRJi/YSKkDu6dFP+Jiuy+gB3AglZ3o06uOGjfdeYzDG3bCYF/jAC18+4lp5zpRkxCliCcOj3inLKhU3eDi3pFywYVnK29Wbau4EcmP1D7weChar4JzrYNJ2KCkJ8xgZLu12rrrvikd2i29fBZke05LFLMthQy8ryLiwbMK89EmC0kgW4mdRv9AWvdnYuG8WcwG/FKDZ8Or5c2eTH30nIJ+akmRJ/c+GreHutPXHyPyQq5BH2Fi927vqp9WU4JS+90G12tq5fL3J5pq7DvcUo4PIcKHLm33qiD8uBAKN0P2u+FLeyeFhH8RG+2IcBdsNiYooFlHjNKhpJL+EhgVgWeWsfQbsi0OEI1glXpIwDun3317Q835elX02D4QvzPG8gBcIzr/1ocs3zeO2+4a/MVQae6VXZtzXIH9ezB1moBeLDyhBGfN+nMr3K4E02dE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(66446008)(64756008)(5660300002)(2906002)(66556008)(8676002)(4326008)(91956017)(186003)(66476007)(6512007)(76116006)(8936002)(66946007)(41300700001)(83380400001)(6486002)(478600001)(71200400001)(6506007)(316002)(2616005)(38100700002)(122000001)(82960400001)(110136005)(54906003)(36756003)(38070700005)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWNDTTdtZEVZYUdGQjJ2MTRmTXVMY0VKd1hFL2xsc1A1Q1A3ekNRU2I5bVl5?=
 =?utf-8?B?c1JlZ3VjOVVaRkZhWGhab3plTTd1ZnM2TjdtNWVENFM1bUxHUEF2a1hNN3do?=
 =?utf-8?B?L0lTNnQ0dVlTd2NOSjgrWUZ4SGtaZWRiTTMwdE9SUGFjY2RoVTBYc0tKRUFT?=
 =?utf-8?B?aXc3RCtwb2RIb1lvRUd2OS9PbnZrSUp4ZTVUSVQvMU1OM1pzNHc1YjdLNGRm?=
 =?utf-8?B?b21aYUQ0c0RGbE1rRWJKTDU4MnlPSnRKcTZYaWZTQnBLK2NtM1FRcllSTndO?=
 =?utf-8?B?ZkVtNTgvNDEvSlovRk45WTBZSXB5aktmSEFTNUdFaHRYTXRmR3hwai9CdnRj?=
 =?utf-8?B?dUp2c0EweFF5TXZHZkxUbGtiaE5iN1drVWwxTFh2Z0RLMUs0aXFtNC9RSTEz?=
 =?utf-8?B?MG1uZjlwZ3VUQm1VS1RMVU0zWjgxWEtCUkdNNFdVM2QwZ3FMbUdqUDVRN3V6?=
 =?utf-8?B?RGdLKzZBV0dCTldxTi9QYTZYRnFsdTcxTGFrbkRwbXVsbHRSOFViMkhuSFAy?=
 =?utf-8?B?WFJzTEFPUlkvbEx4cDF3dTNncEN3OVBrUFJmclE4M3BCM29FSDFobjVzZnBx?=
 =?utf-8?B?dTdoT0lCNVY2cUJWKy9OZTlKb1o0bnR0OGh3cHhBdVA4UVA3Tm15WTJSMElO?=
 =?utf-8?B?U0k5Z096TGFENkE1Sm1RQW5wcEo4VkUza3IyenQxZVVQSUVJVUVnNGl3SUoy?=
 =?utf-8?B?QlJyQ3pwSWVOY3ZwTFNNNUtrUFRWQVNDbFB0ZWQ0eFBHcnczNis2SHM0eEhZ?=
 =?utf-8?B?SlFPck5FVlB3M1Nkczl5bnhSSElmRGRNQ3dYOFhnVWJTQnFzS0xubGNlRnNq?=
 =?utf-8?B?eFRSUUtRWWhEK0ZZZ21DR3EzdlJVSnY2ZXhYUTh4cVZINEYvS1h0Mmd5SkJw?=
 =?utf-8?B?cU95REZhMDNGdTZYeitJSEVNNzlsQ1A2U1NJQStqWEFrK2lLWEZhM0lIVGF2?=
 =?utf-8?B?QXJDM0FXL3pWd1RtSGt5UnZtNGlQRzBqdGR3OFJEY3lWRVFwa09qY1crWmdz?=
 =?utf-8?B?VTZldnVoQlkxbFFad3ZHZWhobEFYQ09PSS9JNGV4Mm53cHpUM1lMZENYZU81?=
 =?utf-8?B?UFJPN1Q0NEx0ZklDYkJEM092ZE8zenZMQ0pVSVFiZ2lYR3l0TTE4UmEwaTJh?=
 =?utf-8?B?eXE2TnJZRE5MTW9zc1BYNStwQUkyeDNET3N4dG1KK1EwOUpNNGprVkJFTGZo?=
 =?utf-8?B?WW1ESTVsU2tvclB2bE1xSVVDS3FTR0NPd2FaMFRwekV4aDFSeEY1cnR1Z2hj?=
 =?utf-8?B?ZCs3cGxUZm9UVWFrMTBxYmhucjkxeTlpektNb3p5UHp2T2FRUkpBMG5ETmlP?=
 =?utf-8?B?c1FpRTRRVVJZb0hVYkdUbHFjczd2eWx2T0RrMExoM1BjQlF2T05iYWZqMlU0?=
 =?utf-8?B?MURGRWZmdVJCb3lrRTFmbkp0QXEwbG91Q0VZclpNQkloZEt2aGh1WFdNcnZQ?=
 =?utf-8?B?UkczNEJlWW9TbXNER0RnQWoxNTFoVFBkajh0azdwT1dHUjBYakpTeVV1RFRW?=
 =?utf-8?B?WUx0c0VUcXZ6SWttK0RVYXNlZVorSm5iN3NTRFpmdlFQcnpYdDJVNzRPUWcv?=
 =?utf-8?B?NEZoMUhzRU1xTmxialh6MGJVUlU1cVlYc2k1MkdVcXRibTY3ZUdzVnlVVlNi?=
 =?utf-8?B?TFFyemtrblZTWTJxTmNTVnhaTytwbEVUSHV2M1VkUUJYTnJUbm40QXR0emgy?=
 =?utf-8?B?SXk5OHl3Qy84ekhzYzNGckpmNS9XQ2lXWi9jWG0zalpZeXdPdk9wN0VuMnNN?=
 =?utf-8?B?NDhacEpTNWlvV3BPN1llV2lpdFFGY1IySnViWVMrRkNSQ0I2WFAveVBWcUo2?=
 =?utf-8?B?ZXo4ZWFUWGRLaVpHM0x1MGZaVS9uK0NEcjM4ZmVZZ0FQRUd6bDZhQ3ZKRHBy?=
 =?utf-8?B?bUM5VVRnSEhCazR0NVl2RmVnek5hMFVxWWtVMTVETmZNSnFSamUvTEl1T3hl?=
 =?utf-8?B?ekNIcDU5dmsxbzVlOFhtWmx1MUtaekQzNDBJLzdodGpyV2E3clAzWU1oSFZt?=
 =?utf-8?B?SDRoNjdkUHJBQ25waUxoVGlWRnZMSXFMNEhBYms2WE9lUGFLQ2FNOWRRcGs5?=
 =?utf-8?B?dzhKSmhvbVE1MkNKOFIwdXpkS2NDK1RUSUFIS1FhVkZoRUFxek92MDBtRHph?=
 =?utf-8?B?dit1VFhNMXNzZjU2WVBHWDFZVTgxTGp0V0FOTEE4WHlUb0swc3crWHlFMHk5?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84F7B3DCBA66754DA409F3A264BF7D2D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31407514-46a0-494b-6bb4-08daffcdd25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 18:47:48.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeqqcAV34YXo0D2xqsybEvmzBPYDNJ6ly/0mzLK277tWdbH+wUkuA8oDEqq5srlw2/Yxk3RBs0y5xTV0pd2C2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1693
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: gxGLe2rMP1dSEa4lrjDi6yAr3qkF1ZXS
X-Proofpoint-ORIG-GUID: gxGLe2rMP1dSEa4lrjDi6yAr3qkF1ZXS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260177
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEBAIC01Miw3NiArNTIsMTAyIEBADQo+ID4gY2FjaGUtbGV2ZWwgPSA8Mj47DQo+ID4gfTsN
Cj4gPiANCj4gPiAtIGFoYkBjMDAwMDAwMCB7DQo+ID4gKyBhaGJAODAwMDAwMDAgew0KPiA+IGNv
bXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IGFkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gI3Np
emUtY2VsbHMgPSA8MT47DQo+ID4gLSByYW5nZXMgPSA8MHgwIDB4YzAwMDAwMDAgMHgzMDAwMDAw
MD47DQo+ID4gKyByYW5nZXMgPSA8MHgwIDB4ODAwMDAwMDAgMHhmMDAwMDAwPiwNCj4gPiArIDww
eDQwMDAwMDAwIDB4YzAwMDAwMDAgMHg0MDAwMDAwMD47DQoNCg0KPiBJbiB0aGUgY2hhbmdlbG9n
IHRleHQgZm9yIHRoZSBmaXJzdCBwYXRjaCB0aGF0IG1vdmVzIHRoZQ0KPiByYW5nZXMgZG93biwg
aXQgd291bGQgbWFrZSBzZW5zZSB0byBkZXNjcmliZSB3aHkgdGhpcyBzcGVjaWZpYw0KPiBtb3Zl
IGlzIGRvbmUuICJ0byBhY2NvbW1vZGF0ZSB0aGUgU1BJIGFuZCBmYW4gZHJpdmVyDQo+IHJlZ2lz
dGVyIHJlcXVpcmVtZW50cyIgZG9lcyBub3QgYWN0dWFsbHkgdGVsbCBtZSB3aHkgaXQgd2FzDQo+
IGZpcnN0IHRob3VnaHQgdGhhdCB0aGUgYnVzIHN0YXJ0cyBhdCAweGMwMDAwMDAwIGJ1dCBub3cg
c3RhcnRzDQo+IGF0IDB4ODAwMDAwMDAgYW5kIGhhcyBhIHdlaXJkIGhvbGUuDQoNCg0KPiBQbGVh
c2UgZXhwbGFpbiBob3cgeW91IGRldGVybWluZWQgdGhlIGxvY2F0aW9uIG9mIHRoZSBob2xlIGFu
ZA0KPiB0aGUgMHg4MDAwMDAwMCBvZmZzZXQuIEFyZSB0aGVzZSBmcm9tIHRoZSBkYXRhc2hlZXQs
IGZyb20NCj4gdGhlIGhhcmR3YXJlIGRlc2lnbiBvciBkaWQgeW91IG1ha2UgdGhlbSB1cCBiZWNh
dXNlIHlvdSB0aG91Z2h0DQo+IHRoaXMgaXMgd2hhdCBJIHdhbnQ/DQoNCkdyZWV0aW5ncyBBcm5k
LA0KDQpUaGVzZSBhcmUgZnJvbSBhIHNwZWNpZmljYXRpb247IEkgd2FzIG1hcHBpbmcgYWxsIHRo
ZQ0KcmVnaXN0ZXJzIHRoYXQgd2VyZSBub3QgaG9zdCByZWxhdGVkLCBidXQgd2UgbmVlZCB0bw0K
aW5jbHVkZSB0aG9zZSBub3cuDQoNClRoZSBBSEIgc2VjdGlvbiBvZiByZWdpc3RlcnMgaW5kZWVk
IGRvZXMgc3RhcnQgYXQNCjB4ODAwMDAwMDAuIFRoZSBsYXlvdXQgb2YgQUhCIGlzIGFzIGZvbGxv
d3M6DQoNCjB4ODAwMDAwMDAgLSAweGEwMDAwMDAwIGFyZSBob3N0IHJlZ2lzdGVycw0KDQpUaGVu
IHRoZXJlIGlzIGEgc2VjdGlvbiBvZiByZWdpc3RlcnMgd2UgZG8gbm90IGN1cnJlbnRseSB3YW50
IHRvDQphY2Nlc3MgYXMgaXQgaXMgcmVzZXJ2ZWQgd2hpY2ggaXMgbWFwcGVkIGZyb206DQoNCjB4
YTAwMDAwMDAgLSAweGMwMDAwMDAwDQoNClRoZW4gd2UgaGF2ZSBtb3JlIHJlZ2lzdGVycyByYW5n
aW5nIGZyb20NCjB4YzAwMDAwMDAgLSAweGZmZmYwMDAwIHRoYXQgd2Ugd2lsbCBiZSBhY2Nlc3Np
bmcuDQoNCkhlbmNlLCBJIGJlbGlldmUgdGhlIHByb3BlciByYW5nZXMgZm9yIHRoaXMgd291bGQg
YmU6DQoNCnJhbmdlcyA9IDwweDAgMHg4MDAwMDAwMCAweDIwMDAwMDAwDQogICAgICAgICAgICAg
MHg0MDAwMDAwMCAweGMwMDAwMDAwIDB4M2ZmZjAwMDA+Ow0KDQovKiAweDgwMDAwMDAwIC0gMHhh
MDAwMDAwMCBhbmQgMHhjMDAwMDAwMCAtIDB4ZmZmZjAwMDAgKi8NCg0KPiA+IGRtYS1yYW5nZXM7
DQoNCj4gSGF2aW5nIGEgMToxIHRyYW5zbGF0aW9uIGZvciBETUEgYWRkcmVzc2VzIGlzIGFjdHVh
bGx5IGFuIGluZGljYXRpb24NCj4gdGhhdCB0aGUgTU1JTyBhZGRyZXNzZXMgb24gdGhlIGJ1cyBt
aWdodCBhbHNvIGJlIGRpcmVjdGx5DQo+IG1hcHBlZCwgcmF0aGVyIHRoYW4gb2Zmc2V0OiBJZiBB
SEIgYWRkcmVzc2VzIDB4MC0weDgwMDAwMDAwDQo+IHJlZmVyIHRvIHRoZSBsb2NhbCBNTUlPIHJl
Z2lzdGVycywgdGhlcmUgaXMgbm8gbW9yZSByb29tDQo+IGZvciBhZGRyZXNzaW5nIFJBTSBpbiB0
aGUgc2FtZSBhZGRyZXNzZXMuDQoNCkkgYmVsaWV2ZSB0aGF0IHRoaXMgcHJvcGVydHkgc2hvdWxk
IG5vIGxvbmdlciBiZSBwcmVzZW50IGhlcmUuDQoNCkRNQSBpcyBpbiB0aGUgYXJlYSBiZWZvcmUg
MHg4MDAwMDAwMC4NCg0KVGhhbmtzLA0KDQotTmljayBIYXdraW5zDQoNCg0KDQo=
