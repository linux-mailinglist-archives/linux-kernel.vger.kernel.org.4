Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF76F0C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbjD0TCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbjD0TCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:02:10 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCBB421B;
        Thu, 27 Apr 2023 12:02:08 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RGR6Eu001242;
        Thu, 27 Apr 2023 19:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=81FU7ajNN8OjA/3NI2d9uAMeIn8dFdLMjKJRaAjqK+Y=;
 b=Yg6DObzM7ll+aUoBt5iT4BsKjwSx1Ie/e5xG83wjizSWQQe6KAlaLsoWTpPo4bMjix59
 IkVH7ocoKRgFkTWcLMxT1ODYMZDnUF0elkFsPxHur019CmZmpcsjNDVz7A8qkC8xER3A
 lgtGBtofERcME/uGQ3aa9gkD4F/b7uzejp+Wplm4brr5sfnnaBC4tpUMwjGStBIthO77
 wxYSzK7nnDPuLJLs2cecJlT1KEirz20g4NAhRi+qcB7mO3cXKmWj81+J9+LsYG8OaccS
 i1wW476oMML02C4kVN3DzYPOuAOJQ7Qcbvda9UOaUFqVBFdDn3FQbOJIOoEnD61Fk0Hr Yw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q7v89hj7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:01:38 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DD6FA803726;
        Thu, 27 Apr 2023 19:01:36 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 07:01:35 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 07:01:34 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 27 Apr 2023 07:01:34 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 07:01:19 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9YRsu4SbStBv5GkW6GrycOWTiPiU65JO0X54GZ2PJ6g8q8BGc5euu06pXSgsJvRWJRc8WShLZnAstNeys/DRRIxMftH1cdHMUaRTvFsgDLIGtv9/yvmLFmXEw4R92Q8ASM6yo8n+7fTBia/5KCE3uMeh/vlZHYA7KGKmRl5RIGJS/2i3+OaQyYYf2DPCpKNOH4GARNAWa0sBXKTTXIOO2vNR6zY4Lghv6Y537ZIeiIGIBH+q2zcc2ptluyzcbOoibQy8wVozRaDhpXPxZ66F2NgNb2fCC7OtySkTWrm5G0Rx2O9HeZnE3T5RqfFEvbkxaEFFOaNfpSom/Q/LBkKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81FU7ajNN8OjA/3NI2d9uAMeIn8dFdLMjKJRaAjqK+Y=;
 b=cY2lS+CeKa/bM1SABzRMaAvaH8J7gDeJr6gxcGIAkA3khNaPgD+HCqDgbnth631ULQVDS7DwhT7K4pRb88ldT3HMpV3sAtUX2ybYnTPYHlhlLseZJzS51bx+0Bp3woGGBijx14kw3Ku8XCEArBPSAcPywnYjtdeXpxYAeGIwrHowN6qyNt+dHts7foxfyu36Rz+RJSJQQUnuMf7N55vIDu0G49vKPPNSs3tphEwHXSGQiF4DITa0r5jLXSOyCI0Q0boTQzPGigtHNr6+hTVthlspfmfNqN64mpljiLgdqTUK4Yj5uGzrOqM3C11N6fCDeZQwJWwDLpFRZ7R2nfNpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1807.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 19:01:17 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%7]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 19:01:17 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZcgrpODxMvy9ha06K9TX/iHoHda8/ZmMAgAAkIQA=
Date:   Thu, 27 Apr 2023 19:01:17 +0000
Message-ID: <DM4PR84MB19272617D9E728DC09715A45886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com> <ZEqikkknyRrFTh2t@surfacebook>
In-Reply-To: <ZEqikkknyRrFTh2t@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1807:EE_
x-ms-office365-filtering-correlation-id: d5da3ee9-9c28-4a6b-f02e-08db4751c7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iH3OiiDsnj2IQeYux2cAte+AHLo5BaxAjUk0lgcEu6+QQPheKJ/2vKCcqg3ipijr1BdwoJpwtg4fspkxnGNlQqhaWfa3xFMnW9Zk2NmzDlFOuI5/UNxA1QimP8nDYfEYH4W6IVm/4UgyygnvVYNl4YDp0rlvPnpB4KImrnAffZwunv8LPuuP91WYaxIA+a7BNcjqrBhwsvucTuwE1R4s1GFG85qGbIgcxfcm60Dk1sDzgCbnZZN3p1E18Pu91bYRuAXGEENKVATuELIhZVuqFQl+jICaZRqPd4qPQPFrjjyaqK4VNpq0XIPp9N6xM/zRuKhEp3LVhpl7X+QkiiIrZsT4IFmVBQF/RRlZ6Pd0BrUTPFNRIjemCLg1Bwa48BN2fsrEsQ1hp4ENjUqlfT85kAXiehDWKOCcr+Ih3ZUrEz7UwVsYHg1FWl+eb7X11ldmqbvbGEhFk6v5ub7klV0j2ja5nTTP/NdxqixweFHJrUw+aai5vyudg58wXvFmTsztdkDDHxYpMRuliLq126hfh46bjZJ6H4+DiTjtzzNZ88cHtDttaPDhd9ghIgn94PVv2k/uc7iY7F57pnbEuVd8AIKhwdUTGoETsUpz/BxfKzVudS7mrSmqB8AV+n2fK/9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(76116006)(4744005)(2906002)(66946007)(86362001)(66476007)(5660300002)(52536014)(7416002)(83380400001)(8936002)(8676002)(316002)(64756008)(66446008)(41300700001)(4326008)(6916009)(54906003)(478600001)(33656002)(55016003)(71200400001)(7696005)(26005)(186003)(122000001)(9686003)(82960400001)(6506007)(55236004)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zk2/Ra6bkjTGGBoR0N4WZzeROX/ZVy1p2XS7yUnFSrashD90RwfqfCSnjR3i?=
 =?us-ascii?Q?83LJTSHrkf6/wnely+cOWhvS2f1dJ4457Jy7EqiVsEX3RtL4wzTAbHaTU1T4?=
 =?us-ascii?Q?SbbAV0Y1w2eVq4ueR+Q5exHUJZ86T+c7aH+SiV1W7eKVAraCvMlGcW6twAwA?=
 =?us-ascii?Q?e51EQNsecgv+SIbs6NhHzSLtUy9zKbDjjc2FCoJ99PCFs/OMXTB8v2t7NdcQ?=
 =?us-ascii?Q?K/g1ug6PfjzxbseVJyHuKclqiZyND5n9fD/s96HQufRBiKihTVm+tbVcdfiu?=
 =?us-ascii?Q?r15OaD1Wxb0+HFntsnsdqTbbPbYXmkE7IqVvko8xW8Yu2XaLRVvWjYgBc45W?=
 =?us-ascii?Q?QvKrRYA4XBBeH3G4KIVjmKa+gLAm2y6V/nhkbIQqm3f////plASUJIQ13Lcf?=
 =?us-ascii?Q?+smFGa566OcLlX53ZjG4wcOVx0XALzerObON4Bn9PsuZUCkuZLTXdLx8W9jO?=
 =?us-ascii?Q?KWdVidNxXAVVGAr3TsMD9nuJ67IMfccUMrrUeZOV3XUJ8qFniDC4DljaAZMo?=
 =?us-ascii?Q?Pw8xuvSL8oRXcKuYg9yWxzdYtSgm5cjEefgHlZyTcpG0Wr1lzFJyq7eQVEis?=
 =?us-ascii?Q?sKzC3Ol7KZV9l/+4DbBS6HglY/n3rom0FZqSW2+XtRry1oya12LEH7DreFuY?=
 =?us-ascii?Q?R9cH06wFNQd/K9A1nw4NUQ5c5nFhrCwG7eBTMPRHTewtWtS0/vz6rw4DPsG3?=
 =?us-ascii?Q?B2AjdxQQRG1fRoUOy+2JFfSdGmpxXpct1eAq7PgRle7kyVZYr8AT2yrECVlF?=
 =?us-ascii?Q?W3AXd0t/P8CGCqAjfakDkam112xt9dcNGaiGu+sMaAo01ImGg5VNuBNOKZPY?=
 =?us-ascii?Q?/9jn0NLFTTyYauEABwdw+bDPtzTfF437ONPU2PalcHCu9WU9sOQJpvKzj1Eh?=
 =?us-ascii?Q?KQm+VJepPR19C3eXLYengGvOFCcyb5IKfNBMbAWHrRBsDnJq7CuPSd6szxMD?=
 =?us-ascii?Q?N52cBXloyyrIG6x4zte6d/FGEElBLHIaA6Rm6jK8qqQwJJnnbGE3KFuM4Dzu?=
 =?us-ascii?Q?m8PM2f0Cwl7jtvyQoLQOMjbKm7Q/MKPiIF/tew2xjMVTVRLCjmVr+IfDlIvh?=
 =?us-ascii?Q?if+8FEnBQhGm4I7hBGdxaPXzPc+KbyPJ6mWmNybaIyB4ouaD3kj5EbU8c5nh?=
 =?us-ascii?Q?Ya9dysiH9I8Srdcg/DJrYejnNNZYLMC5941hqji4WB33netRq9SGLLlxlY5y?=
 =?us-ascii?Q?Vv0TBmKfnhq9sbSB4+M9p7tKGhZFS1jXJT8SunFrzJbYoD8BLC6A6GgWP/1F?=
 =?us-ascii?Q?UrmgmTlKyCgZNPXfvn/35jCwysimjt1CaEClcql05Y3d7m+fy6VHtNbhErpR?=
 =?us-ascii?Q?Pto2RyaSQ8EHZHEAzFwMP1V4y0UHFRv9mDGyiMCekJJFMZbKAyCzBGCDBLhT?=
 =?us-ascii?Q?WyiEKpbwwnat9fO5TPIfE9avFA3yPLCs7KvCt2v+hFzHdH0HRFX9o0EtHXw5?=
 =?us-ascii?Q?xUFYBu77/UuJomHq2DWL9mgAJRFHgtT96ndylO1oCdDiJEMJdkQHtUyQrrl0?=
 =?us-ascii?Q?HSpgREb9sHUAuvUO8k31o7Mg2juYOWeZ7JoHULKdxUSq62ocR//JIpLzXp8i?=
 =?us-ascii?Q?jhLSyxKECe53tLLoXSA/ryOgYFH74MTBacE7SNLD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5da3ee9-9c28-4a6b-f02e-08db4751c7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 19:01:17.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqS8pySHJoIjfHwx2Bb/hPEuB6QOecfXOAP+JT/2/E6xw2OwNAryrdHCFgSIQxD2PqJ8/tv2W7Rq5fYHXchK5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1807
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: rQNgkIGfT_GbYMBatIlfm0FLTh5EK9z4
X-Proofpoint-ORIG-GUID: rQNgkIGfT_GbYMBatIlfm0FLTh5EK9z4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=654 suspectscore=0 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270166
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Thank you for your contribution. To begin with, I don't believe a simple =
GPIO
> driver needs 1000+ LoCs. But see more comments below.

Andy,

Thank you for your feedback. I will apply all the input you have provided.

I will need to rewrite this code and I am considering the need to
perhaps create two files instead of one to keep code length down. As
implied by the description I was trying to have one file handle two
different compatible strings.

I believe that one file will need to be the regular IO from the host and
memory mapped IO pins of our SoC. The other will need to be the memory
mapped IO pins coming from our CPLD. Both of these sources are interruptibl=
e
which does cause some complexity.

Please let me know if what I have described above is not a good approach to
take with GPIO drivers. Any guidance would be greatly appreciated.

Best Regards,
-Nick Hawkins
