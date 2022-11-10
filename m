Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025B624AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiKJTvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKJTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:51:11 -0500
X-Greylist: delayed 131 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 11:51:09 PST
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1247336
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:51:08 -0800 (PST)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AAJTjqs024883;
        Thu, 10 Nov 2022 19:48:28 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2170.outbound.protection.outlook.com [104.47.11.170])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3knh6jc235-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 19:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO7mwMz9Uud6jNwPWZo/zk7/FLxTMRovcOu+YoaIVt2fmNi+DWKTbK79NWv3d52Oh5cQj0sRewMe+/ZnEXtioQWV/2GT4Ry9fIkml8ma94CwOAO8yYhfay2uoU6GtcCQZTY2CioLIT3dPvqJzUDUBpsKzBzvBOYOfXk+9T/erm+T2L/DIOTywve+tcvFhqBpVUqoShs7n0i3zyo8GYw/8CrxTyu/cUygkusmU2kgE8P0uTD+BbAoxVHl1EXmUE+f9KALvUKq4XIgIzzKQ/fS9YahRlXvJgIvcfaQDl9bn+zvlLK2jtINYQuoDnzFEv1o7os2zHoFRD5iTO+CTlmbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui0XZ/jduibtyK60IkXfVB1qcXY/SQuUexHyZJPBt9o=;
 b=VbVOiU5ISyTNxGU0FgwQoec2YD+GyIJtVGq6smfhUAJSvIHEU04d3UGkOylUCj1c+nRh8QtxJB0V7Ltq/qr90lm4gna6Io4+98nTJPdDk3rgOYaWYdlRVO9SkwIBCktKykSJN+zXfnFl9C5IBpC9AVGxbgzFCER3qrIIQwgQV+lcIxfx4N7bfoalgcfkcZHD+F0benwkQJwX/35RoC/tOUgNb/oFjYA0vHkBXtftkpNgXeGGiku+p+lQDqMh+BwpE9SWvG20mK6P857VA5iTKJjznmKUHk8o7m38e9AGqSdA6iEKANncL/Iq3840R+tuLBQQd2dylVyjket3t3xrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui0XZ/jduibtyK60IkXfVB1qcXY/SQuUexHyZJPBt9o=;
 b=iI94hu60tiSN+yuJQXNnXA0CxOHS+gYBfxWQJfqSTXAcI5pIpkFkFD0HjOPCc4L72yUrAQaIT+KESQeHZytS/vG384YiRlgc8DBrBwKfPvmcvxNFT0ClnJDgkG/mXDjQtcscnt8UMF2Xz/BjmzWlkgHctXSdb/e6KRgaZIAbjWffLUIXcuCVugkUYEmxOKHhe/E+DjCYJmxhexci7gnmpzbSauFC+Z1/UwaAJD7WfzuFsOeozRzz/vdf2bIcrzpdYnKV+AruzHHZ0APkBdashIBR8P7hOE+MeGzWvIuHacCoj6Qb78RVx3fMaQ2pMWfsORawMjoYScP/oFnr0t0vtA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB1656.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 19:48:25 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5fdb:b2bf:a02d:80c9]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5fdb:b2bf:a02d:80c9%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 19:48:25 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jay Greco <grecojay@amazon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jorcrous@amazon.com" <jorcrous@amazon.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: imu: Add inv_icm42600
 documentation
Thread-Topic: [PATCH v2 2/2] dt-bindings: iio: imu: Add inv_icm42600
 documentation
Thread-Index: AQHY9Treyxjp1S6st06wH/svlXJ+xa44kEGI
Date:   Thu, 10 Nov 2022 19:48:25 +0000
Message-ID: <FR3P281MB1757E2DF0F68E9CEF61F2449CE019@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20221110192933.13616-1-grecojay@amazon.com>
 <20221110192933.13616-3-grecojay@amazon.com>
In-Reply-To: <20221110192933.13616-3-grecojay@amazon.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB1656:EE_
x-ms-office365-filtering-correlation-id: 7155ed2e-59de-4b6e-74b6-08dac3548814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axS5GaV+AE27u4PPnQCQk71f2amQ2X4PSBrnLZIE4rg7zmZggACQbBdk+PSbP1CebJgBcGTcs8Yc4UhrolSRhIIXY9Gsb5pYOOvE9iuW+h3NAeaqzJN7fzH+ECeIxVI27FiN0fCXzqo/wyOhK2GrY8LKM9l63IO4rkcUtLKXnS76IiK+4qL4L3d+b5T8M3gR4M3GP4Uva71+O1BECrTBP1JvyIPxjTqZ5acGAw7iSFOJ3lMsh9OV/1AMfZDd2RVCChDljNUPowzgyeXOA9VvfbsqTylQDos/6puhBWJWGaCLsNOb8Up2Bld3qBF1svVu/+Rd1OarBWq+mDdz05t1L54DbkB5YvB4vwmSaAbRBebEZJbw9C/V7hTMx/ksGHWX5DmcOqxKg41DqCElah6g5IPabupTpyZNAP/5OTDmmvcKYn/T97uNHJIkZ2+kf3E8p+8Ssy/tiHbdh7yYOLi/zqMkZ+XMj9Xx5RlSoNAyUEfvo16c8N0Bbib5cJwfj8GbV1bxTysvQ9+P4r2g8soLYXhE6fKAvhW+euQxc9ULVB1RYwBJYNM+e++5JJaNd6kL0fS5JQut/7UP7OLCvEgZDz5krFGfiPks6lhVhl2RKQ5RO5cKvPLTvoQkRCcpRPVwl0LLUNskHwDolZE9XQEJoJ/Xym42Xg+6OOhSbQg8z1ZF5I9oADVzJMRsd8RugHVbAKlEKvSNDnUL3Qc7pCIBBKW56ah6Wiosp1V2Q91qeFJcVXH6W7U01++GvViuOL69rsNBjbvfsSk5ewmD3vCVdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(451199015)(52536014)(5660300002)(8936002)(38070700005)(66556008)(4326008)(2906002)(64756008)(76116006)(66476007)(66446008)(8676002)(91956017)(41300700001)(66946007)(122000001)(38100700002)(186003)(53546011)(86362001)(9686003)(71200400001)(110136005)(316002)(55016003)(54906003)(83380400001)(33656002)(6506007)(7696005)(7416002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o4xvCPt9kbkwD8UfebejKsfVOThXhkeQQ/ClSYDYzzBnDdIZSuVIKlMUqu?=
 =?iso-8859-1?Q?mSxxWZkvoBkNS1yA+2LiIQZolKoD8cdc4xIBR6/okENsdlzDuv/UPmOit8?=
 =?iso-8859-1?Q?Q7CbJd+1InfqADqzQTK71VJ0WMMBkz5UIzQjZK93z+fma7FrmmCHwRH5wV?=
 =?iso-8859-1?Q?XLDe1TvNWdvFmKt3oCD58Bt+4ZmBKF7UTBe+fPwvsrgwhrn71qi7m/sThf?=
 =?iso-8859-1?Q?BOabALOcQH0wLOknSlcNPPtOFYB6bLNAeykT3fuZGHkVu6sYoBLFRIhVI6?=
 =?iso-8859-1?Q?ITheMAtgOQXJDgNZ3jmcM9E84cBlrPb7yQrb6msOBIDSFJ6FHoQjHTjp+A?=
 =?iso-8859-1?Q?5DwkU0XKzEMPOOS8G5ZcPb6z2iZUGmoufglsQ7ed2qTMrmq/+tc8fQbUNY?=
 =?iso-8859-1?Q?QOfY0tXbJ9yMM2y6lGJRuypP7bNdSw8weUPotDCA2lw9VGcYxaijOdq5WB?=
 =?iso-8859-1?Q?gGXFkvxCsiDMJjXdc1EzySjrYCgJIWD2wY2yyVVHwIUUatzZaRn0mOInpb?=
 =?iso-8859-1?Q?hJiwA0d2ztLBJphcXDsTIAwzGb/bhggVC03MOMYDypgKdIAlZkcXgABORK?=
 =?iso-8859-1?Q?IpFdfOxbups4Bvk6mbOlus95Shey8AEkDld8lSxhnDAmBQBQHrJidyATKE?=
 =?iso-8859-1?Q?ylvvaHNxuGOfo1zdWLItgDcdiMRguevM4dfGQfxPtfNFi2wv/KxjKMleM8?=
 =?iso-8859-1?Q?J45Gx1Uq7idwGqp3XR89HY88h5ncqHzZFN3qcZ+D+4dL0ST+SRVqCfNk62?=
 =?iso-8859-1?Q?tzbx25QmDuf+MIYnpMCpuHbfpmfqMt6samiA1We185ff9iygLuoE2v4lJ3?=
 =?iso-8859-1?Q?McmdBeeFHtQW2qToo54b7zyjERZPy92aNkjEipDtqfaW3CZBQViY6SoUki?=
 =?iso-8859-1?Q?h4m7BKDZe7flAhaEaECF2vidfEViLwrcW83792gEFgKi2paZwk/uUy6Wtk?=
 =?iso-8859-1?Q?A4Oc5QoaSqYewXv/uAoHJF8jNLMqkXarVD1SgkFMW5Skh7ivfoxJJdK9Uw?=
 =?iso-8859-1?Q?PBP+9burzQvlUpNXCVxDLT9KT9SgQsaaILXIS3QNOCb6XJzD860PYTLBah?=
 =?iso-8859-1?Q?ni/fzoqV4JdiqwGA8bJvA8ovn42LcgT5AVlD6Yhqc5K672BlrTOdWGZaUH?=
 =?iso-8859-1?Q?7YNUxnycS6kLV3GGpbtOIsR6CBh8joCQBhm5ib5TlAfPS/GbHdG8n9RdAq?=
 =?iso-8859-1?Q?1disEkUFBa1E6L2WWbjbBmQzpn12lIbzT9zXS+ca2FqlARieJqZiiD9n2z?=
 =?iso-8859-1?Q?zCt1ZnBq3CoCLwYNliv2lV940RYcJ4Jwj8ZN8eEP7uE88FZG90MN87+XlK?=
 =?iso-8859-1?Q?vpbPRZ6G3shWT6mAJ3q6csX9krtLIeop0yVyB9DULr7a+bsni62uTJG0SD?=
 =?iso-8859-1?Q?THOJULaIRaZK3gxet63IXBdkGx0dDi5JcAYkK3AlT1JkH2gUaAcal9GVHX?=
 =?iso-8859-1?Q?2WMv2kBdeHZ+uG1JRxer5J6p7hSsqMlZnosuD/Pwy+nCfRIENFrvM1Hcn8?=
 =?iso-8859-1?Q?M5xNnAQ8kSh+YtAhcyU0On/soW7UOgfyA+JIXFKioWHh4aLP32Bp/cguH/?=
 =?iso-8859-1?Q?4Q+uCeEH+J0cYNXgtS8/v0R45689SCz6Qx3oTOmP4zpWYnfAZ0uMvp7VVI?=
 =?iso-8859-1?Q?66o11CwMsrmMDTeKed0Go+gJzmi/oYk98ZXdGDEdDzgLTb1ZuRb0j6gXSv?=
 =?iso-8859-1?Q?Rj1IGdTg61t4LmvXwFMzdHaSOoAJSrU8yGLYGrvRsv/ns1QMqvIvJbQG3M?=
 =?iso-8859-1?Q?OWBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7155ed2e-59de-4b6e-74b6-08dac3548814
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 19:48:25.3901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GX+kBcHPKJTKF61gl3sXBCcqkiRdQ5InNLO3X1iEyN+lYVaShVTv/fPQ/5EPZdv4rx72lmKJfGfNfNVyLrgmSwbx5cJVZnrKrFYpomZp7l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jay,=0A=
=0A=
looks good, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jay Greco <grecojay@amazon.com>=0A=
Sent: Thursday, November 10, 2022 20:29=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: jorcrous@amazon.com <jorcrous@amazon.com>; Jay Greco <grecojay@amazon.c=
om>; Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>; Jonathan Cameron <j=
ic23@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; =
Lars-Peter Clausen <lars@metafoo.de>; Rob Herring <robh+dt@kernel.org>; dev=
icetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.ker=
nel.org <linux-kernel@vger.kernel.org>=0A=
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: Add inv_icm42600 documentati=
on =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
Update the required documentation for the icm42631.=0A=
=0A=
Signed-off-by: Jay Greco <grecojay@amazon.com>=0A=
---=0A=
=0A=
(no changes since v1)=0A=
=0A=
=A0.../devicetree/bindings/iio/imu/invensense,icm42600.yaml=A0=A0=A0=A0=A0=
=A0=A0=A0 | 1 +=0A=
=A01 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.=
yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
index 488349755c99..13c9abdd3131 100644=0A=
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=0A=
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=0A=
@@ -31,6 +31,7 @@ properties:=0A=
=A0=A0=A0=A0=A0=A0 - invensense,icm42602=0A=
=A0=A0=A0=A0=A0=A0 - invensense,icm42605=0A=
=A0=A0=A0=A0=A0=A0 - invensense,icm42622=0A=
+=A0=A0=A0=A0=A0 - invensense,icm42631=0A=
=A0=0A=
=A0=A0 reg:=0A=
=A0=A0=A0=A0 maxItems: 1=0A=
-- =0A=
2.37.1=0A=
