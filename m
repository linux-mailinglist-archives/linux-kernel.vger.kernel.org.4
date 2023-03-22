Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35316C485A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCVK4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCVK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:56:29 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03235D76E;
        Wed, 22 Mar 2023 03:56:26 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M9DWrh005391;
        Wed, 22 Mar 2023 03:56:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=35cvHfJ4sfS/9H25K2q0u+zdxRekBD8tQYlzSIZUHbU=;
 b=PCnpdL7nu4up3X33X48S4pGHnSr76HQlrBg1Fn3ZLHMa+2K9UB1NGYccIT6iJUBBG2ty
 j4UqtSVIEugrniZ98muDZLIW30uJYDVjX1KoPyla0xpzxa/ypvrW5w/2Zwm3/F1xX6nP
 xR5ir7QqzofA+Q+h6XOBa7EIA2fxytL07xr7B1P2Xn+jQRTPbF/WyxG2DxY7Q2kGIdfW
 8sTKW6HMP+FZPqV9/6vL9BL49KJ0Ss9RyYSlVRyopwfRqJ5xaX0w55ywtO+hhu9N9sw+
 IPRHt+8ub8vtSiw8qLqkDvevoJAmXkYEV88DAP4S+691xGzvzMAeYgsJIRuezuKlj7G+ 6Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3pd9v0y8dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 03:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpSSqozCcfiNfUSCMEzH86owefVeyqAShFFqlojyhhitXYO/N8x6Vpc6R6UtXSIIfCDOKjgmjQDWEPClKOTQJfccpi1ndNLuE2kNatIkNE4lv0IkIj8LAatsaMi6YfMP5AyagrP6xMAnH4Cn4TKO5eIpuJy4Dj5zsjCNwO3EMwoHJ6FAfO8OWMlFawDqiixAG2i2rGvB/67F5GNytWNPtz0gpM1fK5cu0DGwVqgX8lpCsJkYxKY5UVER/JY6QU0ydF0cUDJtext9D1Jqw1/1lOSA5mpxuCblnDTRxGaI8lVOIFRJLiK2CYplnzB5LxroTyEZrBdnOC2WLZ/VOuxiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35cvHfJ4sfS/9H25K2q0u+zdxRekBD8tQYlzSIZUHbU=;
 b=LcULbiUO6s5pISiuCKvtRvfz12pd70s4zv/o1hSwBxLjT7aL1PJMSyNfr16CsBAVeAXNauKztVdkiXJLnM1AMRPLyQhilgRKBPle11n49iHZ15Fct3deT4rhsTNylFk+/JxyaaFN1B37cfhj2S9AFtodSLyfNcOvLnrXXcPV2WLmBhP2LmLwn8b9WohQtZPWwpBMgReCbKUhEgTbDK1CNkuj+C9bkunBuRGjL2hUaX0heHWeUc0Tacf8VW7qM0YeIDppDDMQ3S4a9wdEFq2ks8Zd6n6In2INM/szEbmfHOs/aOUEeiqFsyiLjC7n6aGKKdZn+cKowA4HNkeFH0YuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35cvHfJ4sfS/9H25K2q0u+zdxRekBD8tQYlzSIZUHbU=;
 b=r+MnWyzWHZSUk53O1JMUhaFnaF0BbCSRhgDXLliXBjfz6kEks/iA5nhPXzgfShMGrdsC6VSmZkOovDQxf4qwwpbRDDeEcExA2rbm35Luwd9hvJrY99KjvPrq1bToHKLs0pXFvO41K4JWjdJmK7dZQMCs2grbcXzaOPG+5l4PCLA=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by MN2PR07MB8064.namprd07.prod.outlook.com (2603:10b6:208:1b6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 10:55:59 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::7a9f:f44:4172:5bb8]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::7a9f:f44:4172:5bb8%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 10:55:59 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/1] usb: cdns3: fix super speed mass storage gadget
 device failure at imx8qm
Thread-Topic: [PATCH 1/1] usb: cdns3: fix super speed mass storage gadget
 device failure at imx8qm
Thread-Index: AQHZXDjqj8OQUmrUl0+OaTIEnBRe268GYozQgAA8uRA=
Date:   Wed, 22 Mar 2023 10:55:59 +0000
Message-ID: <BYAPR07MB53812A0F803FB8185D63F077DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230321210521.2806486-1-Frank.Li@nxp.com>
 <BYAPR07MB538127FB75FE24832DC1BBD6DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB538127FB75FE24832DC1BBD6DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWY3YzVjNTUtYzhhMC0xMWVkLWE4NjItNjBhNWUyNWI5NmEzXGFtZS10ZXN0XDFmN2M1YzU3LWM4YTAtMTFlZC1hODYyLTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iMjcyNCIgdD0iMTMzMjM5NTYxNTc3MDAzMDIzIiBoPSJML1NFck9vdC9vTGxCQkd3YVVHeWxNc3RTWDg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|MN2PR07MB8064:EE_
x-ms-office365-filtering-correlation-id: 7b81118d-7174-4cb4-e36d-08db2ac4052b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Om7Q/NBYHTTUNc4tSKNETTakGpFnd4pVo57DvgE6TThQQ7XPD4oOBukqvCY+Z3b7fOI0Yam25/Yx34rHA9ffK/gn77wO7w6sbbqmuOsnD58sOpLP6hN8/XkSLGuaP7E1fOGXtrtmomv7Mmjsrkdd1kfx5TDooO99WnHMqVcrnzPXDW2jvTFZbBL0WCr0LY7SAJ3U1F1d5gbqLmHmWfkpVOtIS393tiQJJGmWfav0kTOJD0S9qNNQxiKHuSmkCfHGDfc76IHSoNk6bdrGJ9PMXFnouQ9wRMHBGlP1+82Es1VLVj7UvneJ4r9Jl4bAXEnf5CQlshb2EhWimozz4Ble5qZC/CkmbXgOheCJWHG1l9wjciW0O0+2w6k3iwL1yEId0CmUtfjrK9T1DQLMBPu74q74vlmz7mYx3DmhjUgNkCm2nWGj1lWnizuS/ispvAoYI211atiyW3wsUoEQdUco6mCmXWr2yvVdlpXl5tfXveQ4culHEfpMgizAjdZLRBOWoP2iT3BmWn3su7KzeUlbVrmh7kqy/O/sIV4eiMu+Ov3UunoflAuobFRWDKYQiCi6qApfS73NyKkhZkOzP0mvSfEfkov7cIKG+0OTu0digzLx6ZY41gmXvUlM2m8pwdajCpek2zjaTEY5RqN0jfi609iktgW2JmRhlLH/t9/YwklgDCrBKwJOwDHJEdjyrYwx44XzCJyPmICn1fE8xhqIZn+gELB0SgflKCWmDsQxL3SLWKgbwL8vQJEFqkU93G5s0j9LmOOOdvd3RElhjq4jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(36092001)(451199018)(86362001)(33656002)(55016003)(478600001)(83380400001)(71200400001)(66556008)(316002)(64756008)(76116006)(4326008)(52536014)(66446008)(8676002)(66476007)(66946007)(9686003)(186003)(26005)(2940100002)(110136005)(6506007)(38100700002)(7696005)(38070700005)(8936002)(5660300002)(41300700001)(122000001)(2906002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pQ6ftrVY7j9wAf9jHLtpK1GYnaOfPJUftfrr51DycqpZ1eaaNHUBLSM6cObW?=
 =?us-ascii?Q?GqxRI4+bzB3Bx1wP/jQTsHe4TcCkbZeCCACJqM4j/46KVgr74NBcDJLqQ8A2?=
 =?us-ascii?Q?ph6omAqPE81KuZjF+f7L6g7VWye8JqMlUOGsJlV+xL98OT18hQhDAMMORryy?=
 =?us-ascii?Q?4vHRqqcPAShSWhc76xCokm3btZZ0NgJmU+DbXG3xnxZ0zLjqJWFj7o+nTszV?=
 =?us-ascii?Q?GZJNlvIZCy+O2sr0ZkJNn9Q3/Y70TRLOPySD88rzVDNVfVbNUtakT+x9iWjx?=
 =?us-ascii?Q?ROoyV1yfcLpTTFr4YVuYIFI+tvVzL424sFGJxriay8IICpqvuc6n0Dx5lsAZ?=
 =?us-ascii?Q?yHdi2GHdovcC5VL2OTQE1z8zNg60VBaKaIISnX0gRiyoJZvHIykSmR9YvyZM?=
 =?us-ascii?Q?OepoijRDsBgWrdTWYe7ROj5Ltgl025DyZcX3vZ5M5zw80iN8HwfPXj+DqIfD?=
 =?us-ascii?Q?HA+UcmOKuDXTJ27fuzb9ZQI2qDt7WYSsuqzm6U5sWQOVQU8SWKeYbvOsuc5t?=
 =?us-ascii?Q?eUlfU76Sb6uwm7Tx+ylUmgMITkGsfyUU6XRbnjFIF4HwlRwo715RUy4gNynV?=
 =?us-ascii?Q?uqsnRogI3rvWgLjIHj4RwQXFc6YghZ4RZSiUFXJSeov2zrPXUAof0T1tJWjR?=
 =?us-ascii?Q?t+mJRRkTgDjRZAm8wCaAZOhzcupbmmsWkfHaJnPoxSJIOu55cjiiDjFZA6kq?=
 =?us-ascii?Q?rOf95QCPOWR9Fi09444cCGRXSavOW/wFRA8+bjJc1Ts4A8sLGOupIOrBu6C1?=
 =?us-ascii?Q?K1JqhMNi0ro/qdD3oUXupBzeA/ZvqLeiYfg/69teG5gO7YTSifhGAyrLi1T1?=
 =?us-ascii?Q?0hW2IFuEZLnVxDA1fbk3PYeCthO2g43MWYdcfpwCxJbRpUgsTr/M2khMQEAy?=
 =?us-ascii?Q?pBnSNYQf1dX1mmeNqVhz54/kuinwPFNScOVebWJmSdOV3/86AOtTgCDgrjX8?=
 =?us-ascii?Q?nekpgKzwOiU2goszz1P84YU/orADgvVQfIHPTvtneL4q+VnWBw9eUeyonrDi?=
 =?us-ascii?Q?Jp6ukrWdVdRAFd2ZHSO0zLH0DUirx1yBXPOgrZcgF7HiOhQo1oZ3RI9FKOEC?=
 =?us-ascii?Q?UhCQWxr9JBIPH1WNJERZZWeWkQnU/Px1A0uwooicNzLK1qkVMuoLChlWg7Ce?=
 =?us-ascii?Q?IBb/bMWUlOQisz8ioMra5hVA8XVsIoryYnI7wAz8M07XxQ2CJCu2gsTXxHv+?=
 =?us-ascii?Q?nTccDyufx2nwxsyYXYLMyCiizm2MZ6nc0JrUDT/ysDQNCtaIxnzs0+A+5MFP?=
 =?us-ascii?Q?pDF1voDSosowVo6MK914TqY84x4l0POE02ADM0RZC3JDHV3UsgsUpHxhZ0SD?=
 =?us-ascii?Q?zWWbZPIF/sDv2Rf+UTwW5aPnX42gdG0yZQ0nxlo6YvRrFmRYzNckqxEcDDNT?=
 =?us-ascii?Q?x7Z7DgotbmukVHCs0AfLBS+MwwNT6gUOHzd8FiT7NX4t5hMuO5dDYJH2BLeh?=
 =?us-ascii?Q?VLmwlevKLd1KRn+ZkqHTU6aY4/eLm0vzoDpIpQeO73gaLLZrIx24u1ogFYWR?=
 =?us-ascii?Q?IKQh8nn93XB3+VEmc067WQIOGPFSrwIYZY2FK/F425rN71G2qekSsVlzx9a1?=
 =?us-ascii?Q?pFPLQSotoPK+/5b9ozlAS3VbS8eiczdOPB+g8buE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b81118d-7174-4cb4-e36d-08db2ac4052b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 10:55:59.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYJTa3XRvM45DHsuwJN6rv/JeOTolYpFkWqd2K25GepsBKPyzpc3Uv+klamziGbpl7nCfiTiHo7yhFAlwqLjQu/t3gM3ehGIF+SRnQNqkW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB8064
X-Proofpoint-ORIG-GUID: kNZycGMM5VRNxkQBMf3VMzBcrazrCFrA
X-Proofpoint-GUID: kNZycGMM5VRNxkQBMf3VMzBcrazrCFrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_08,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303220078
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>The mass storage gadget has one IN and one OUT endpoint. The below
>>(Fixes) commit aimed to utilize all hardware FIFO to support composited
>>gadget devices. This resulted in an ep_buf_size of 15 when a single
>>gadget was enabled, such as the mass storage gadget.
>>
>>However, it was found that there are unknown limitations on the imx8qm
>>and imx8qxp B0 platforms. The device would fail to work if ep_buf_size
>>exceeded 9.
>>
>>To resolve this issue, this patch reverts to the old settings used
>>before the below commit for the imx8qm and imx8qxp B0 platforms.
>>
>>Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to
>>composite EP number")
>>
>>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>---
>>
>>I hope cdns engineer, such as pawell@cadence.com help identfy the root
>>cause.
>>Look like old version ip use more memory then what ep_cfg show.
>>
>> drivers/usb/cdns3/cdns3-gadget.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>
>>diff --git a/drivers/usb/cdns3/cdns3-gadget.c
>>b/drivers/usb/cdns3/cdns3- gadget.c index 5adcb349718c..497c8e87dabf
>>100644
>>--- a/drivers/usb/cdns3/cdns3-gadget.c
>>+++ b/drivers/usb/cdns3/cdns3-gadget.c
>>@@ -3005,6 +3005,17 @@ static int cdns3_gadget_check_config(struct
>>usb_gadget *gadget)
>> 	priv_dev->ep_buf_size =3D priv_dev->ep_iso_burst =3D
>> 			(priv_dev->onchip_buffers - 2) / (n_in + 1);
>>
>>+	/*
>>+	 * There are unknown hardware limition: when work at super speed
>>mode,
>>+	 * ep_buffer_size can't bigger than 9 for one IN and OUT case at
>>i.MX8QM
>>+	 * and i.MX8QXP B0, which report there are 32k memory.
>>+	 * Rollback to original settings for the these chipes.
>>+	 */
>>+	if (priv_dev->dev_ver < DEV_VER_V2) {
>>+		priv_dev->ep_buf_size =3D min_t(u8, priv_dev->ep_buf_size, 4);
>>+		priv_dev->ep_iso_burst =3D min_t(u8, priv_dev->ep_iso_burst,
>>3);
>>+	}
>>+
>> 	return 0;
>> }
>
>I'm not sure whether you have 32KB. I remember that you had a Soc which
>have only 18KB on-chip memory and value in usb_cap2 was incorrect.
>It was the reason why the on-chip-buff-size property has been added to
>driver.
>
>Please confirm that you have 32KB, then I will recreate such test on my te=
sting
>board.
>

I've made the MSC test with the following endpoint configuration;
[ 6732.999537] cdns-usb3 cdns-usb3.1: Configure ep1in: with val 74000e05
[ 6732.999565] cdns-usb3 cdns-usb3.1: Configure ep1out: with val 74000e15

So, I used the 14 buffers per endpoint and run bonnie++ as tester.
I didn't find any issue. =20

Regards,
Pawel
>>
>>--
>>2.34.1

