Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C378D6FC21C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjEIIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjEIIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:54:22 -0400
X-Greylist: delayed 3023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 01:54:20 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E013D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:54:20 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348N7iIp020366;
        Tue, 9 May 2023 08:02:02 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2171.outbound.protection.outlook.com [104.47.7.171])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qf7b50gwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 08:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeYKd9Rg+JslZihLKclV01VEdPc+micbrv+QPvKuz4pI1EH4Kxpnvzr/HfSbTWWiP9lEur4x8F9nz4hkhKH4GDhEIOIcJE0t9b6h0sJGUdIs0atXKeNJzAMAQ/LfcQfzCP0B7hGTCjbp5Neh4p9xVAnXk5TPju9OIo4oL+PHWG7HATiNTLnnf64MJPfGK5BHXCASYU2zwVgodwvNk+Ubovo2seSaZ2ucHB2A2Mw6rrZmvqlTU7dQnlV9xKOGE69eS1XwG7az7YnHW6mg+eFDRSSjG0ErN4SW9EEldukoKol7sQBhnuodLyQKoWwbqo8y64LCv10nGIzNTmhWBn9YuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtoCMrVKScwjFbNzrDlDwzRk0KIWw+TwNGP/JU47cm4=;
 b=obcet6NBUxQEcsdGA2L7eAqo0qcbauougv+lMLgmIm590lQnmFmfZkYilbswXWsM7euN4dPJioJ+V4Y9gNkfdKOJKBv8V27LhpnOnN62m9pwSv9LduskrOaimxDQmJ2Zgor/4kUO5sJFzwyhIJQCVADQpOsXZL0niootx7PW76MmYHcI3QwB5SeJNI2YtOHjaW0Ks3Vvc6Lxw4C8r8ISQNrDsYn5gjKuynA8pLpfjp2lRY9tYKXpAR4I6XtvrvlqCPtAnevmWsJ2W6KWw97kq45KtmG+0eKrGJI5JEzcs67VIWgLKFAKA7jQv06guYLl18O9lLKtTPJxbYR8fKdsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtoCMrVKScwjFbNzrDlDwzRk0KIWw+TwNGP/JU47cm4=;
 b=Ta6doyuG31KbX1hxgZqv+N2u+jLdFcwp6Mx2LLO3xAfonlThRaGYm3pwF7ZBl+q74uIPcMCyXowUofmlexGJxWOEcpzIs4Z4ww6GmLgr1NCWRJwSBUzvIZX36BEsVTh3nIMwnTJhaWXEEw0P/NEOlQ8dHXhN/WCPYbEauCVWRnGPDCYfyrCUqzmkFITFEm04Ijq1qNy8WDUsw8uVgYv5kaRF+RcfSZ+y5HMnvgD0rZNKxf1q//Ydd+d0GL4pBKYTmVaPcWJI8P0vqVEx7BVyCQ6yawH3WyuNhsylT5PgyoMhzyIll2lanL+6cFBX4fN7s4GEViAAHSyx1AkSzdKOkA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB1629.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 08:01:56 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 08:01:56 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Hermes Zhang <chenhuiz@axis.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/2] iio: imu: mpu6050: Add support for the ICM 20600
 IMU
Thread-Topic: [PATCH v3 2/2] iio: imu: mpu6050: Add support for the ICM 20600
 IMU
Thread-Index: AQHZfxVjj3l+RwrC8EmWQggUyfbDe69Rlijf
Date:   Tue, 9 May 2023 08:01:56 +0000
Message-ID: <FR3P281MB17571B12A5E24362A113A424CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230505054853.2155326-1-chenhuiz@axis.com>
 <20230505054853.2155326-3-chenhuiz@axis.com>
In-Reply-To: <20230505054853.2155326-3-chenhuiz@axis.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB1629:EE_
x-ms-office365-filtering-correlation-id: bd63695b-f5a9-4d91-fd2b-08db5063a88c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvIc4w/L1TIKgsXZOjCI3mPaluRzb0JN5AVEX3L81akh+0utzPT/sPBVvM7qiYA9oUIJiL3K1oKCaPgNHd0/lEjONWlGCHLjuv1I22VvKWHYuRwXDSjPaBBk5WsxsOV1S9wVoQzeou3OC7lr9fcs2voH9vkBh9QLGaoN9UWygsMpVoSLMyFRDfs9iryOekGEmGLD54ybSqMq9XVRClznugqJpNNjHXHrDoPX9jMBE0Eeyldc2U9bvLV6qqdZ3OmfZ4SAbKdPLZvJMCoH6V7rxZF2W+QTBX6TaKt/Gws2f3R154QIXdrlxSqC4gASq17G2aXw7jjD3frSh+ddJziZ5iwm78gMGg2r0p6G7XzduFNzaYdPHxT455wuVuEsfgI3W5iXW8gm+QoTI8rDVlcv1Cy8P3CvJnwHc+CxOQXLhzQyZkzszkt69N1ubIm1f70U9lCIstXsWTAfmTJRKFcFAuYX7DFp9Xr+oGVueUE1ZU3FAzm74KUBlIsmNXP7YfrDmJ4Q08x2IrYk9t7UPPYqXQWgQS+9MEttOy9EHgmEbQ9ZLebeR13jvPsEW6DGwbtXLekeP85SrH2ohwiLjksHXOm59iW0Oio6aeS3DY587Iq34LEYGFvRRnYm6ZgT7zjo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(91956017)(54906003)(86362001)(110136005)(38070700005)(316002)(8676002)(7696005)(66446008)(66476007)(41300700001)(64756008)(76116006)(66946007)(4326008)(71200400001)(66556008)(8936002)(5660300002)(478600001)(52536014)(9686003)(53546011)(33656002)(6506007)(2906002)(186003)(122000001)(38100700002)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KZ7F70PMD5E7YYLBSQaFQieZ8QtVVIwrVJxEWHWTVfOeeII+/80Zeur8Tj?=
 =?iso-8859-1?Q?1AgivfP5m/s/QCQiEgyGwc/HaRDJ8PHyqBNsXrdCbdmfb8rV+4a7u+5EdY?=
 =?iso-8859-1?Q?jIYxiaeoH+ZuqTFoGQ+2ExhyA097XPNSD31B3G4uVhnfAIq5xrFOWYhjG6?=
 =?iso-8859-1?Q?QCaoFhMJpfCWF8EzQ3kpwTmxzRto6KVwts03qEd6JPYy0woWf8L5H4zOmE?=
 =?iso-8859-1?Q?4FIgmNcG6o9EEDSHToVqvcpL4JxJSvnpmWy3ZL08xlKYlHxj/hsaqn4a9O?=
 =?iso-8859-1?Q?CuBWGpITlBTfCSZoUuggSgxuCENpgugKOxzxMbLQcTS4a58wn0clEPo8Sz?=
 =?iso-8859-1?Q?Rk/74xrFm8NK+2wJ+p9wKrTOoMNaedDyBfaTDeqGg/dOazrl8Ybfqjhn32?=
 =?iso-8859-1?Q?AFzTK/RS0+w6og6gzHYm2Nwl2YrLUyLd2mFnz9DrkIq9LV24QkBd9Hmt9H?=
 =?iso-8859-1?Q?I8ZDAKdQmhdwtEReYckaGcTrP8svJKu0EvmSijoEuSLw9kydentupZrNR4?=
 =?iso-8859-1?Q?PQLGKAKbBLs3INYMYUr2GooRpYyunZJJ+xyurCXF1cgcvI6spsJIk9BLoN?=
 =?iso-8859-1?Q?0GmHOrfq+jeugZjOkGAKHkyPpnUQ4mceQQJeE6Mh7rqbtXbnq+hGtpnYSV?=
 =?iso-8859-1?Q?EMEbkE+ibOQFhcuA9l60w7k+xleijJeaX7bzWAA6gZEMxOiUTIGUZC3b2m?=
 =?iso-8859-1?Q?N63QiwiDjEai/OkJGiZLKuJsRWpqU34ft4Iic7khCE63M3n2b8DxioH2kI?=
 =?iso-8859-1?Q?DOPEdLSwDuVwbiTh29z5mT0wufv3ZAU+9zY5cFhsHg7bOpMtNiIEcgvfLE?=
 =?iso-8859-1?Q?Js3n5/uw36yLJL0qT0+DWTG/Y5FjZ9IdC6032ZJChljdqit5ukPcXcpwL8?=
 =?iso-8859-1?Q?qJmz6+QAKOrZFXkveVTzYheCH4HQDQ55kB9RYdvXHuv3i46u0PM3H09hUd?=
 =?iso-8859-1?Q?wTXMD6vAIVgWp5pIususWBiI8CgeQVbHQjbat4yXFwd6v4t7IovwLJU9XN?=
 =?iso-8859-1?Q?arvhAO8XfZ54QUBG94vvhBdzvBFbLUqXPFO/jQij51Rv/S31H6TDRPuc/2?=
 =?iso-8859-1?Q?BjFhoxtI+7ndw9lgPRYibINt35+BwTNapjgxwTBwB+eKTqKQKjFO6XUjWb?=
 =?iso-8859-1?Q?c4iNWHcNaiJMXXV1agoEfNn/lx3hHZRramCBoWMVK82//whTlcsFCF0MZ/?=
 =?iso-8859-1?Q?/ZULVrh/NPslC3/VUfOEfmoBIlds3HhxfhPmc+Jf4Ts0/8EuV3GjXZ5pdo?=
 =?iso-8859-1?Q?V7JhkoxZiGYPFW/uH1JVT/EWAz+9Yg3vjzNXTO8c9kMAHj1F4TeTa42yeg?=
 =?iso-8859-1?Q?I5WCsZrGxsKF1ov9a31FHJb0nFtvEEAREtAQjhkEMbCgBb9M4JZW2CEpvn?=
 =?iso-8859-1?Q?p77y6C6usUJ3vtpOv43MFbBuQeJm89ciorVh3KI7FIL0TnOdX6n38Z+2zs?=
 =?iso-8859-1?Q?h5ZBxEA0qDPPl1YyEj60lxlm+AhoGddD30SqMpU+79wGCP3HVXizjvfOh9?=
 =?iso-8859-1?Q?D11ajKbQUsYdOaOum9HZ8b2fYKeROxpSRWHBfmtbJJxo1ua+i/E5RHJxDW?=
 =?iso-8859-1?Q?ObT+x2OwKcSe61ns4YpOvX3yMUm4MZYKO8/xC+3fm6TqggzqIta/lkKYYe?=
 =?iso-8859-1?Q?cuKyaqr5Sb/S/Slg6poyNSgbNaR1HX+AxY/uE9A22oP7rwofHJqy8qXw/T?=
 =?iso-8859-1?Q?5xCUhAwLNydzisoPOemQKJQKCt7YBr03CX5cgl5BXyGLQ1mJOOFM98vu4m?=
 =?iso-8859-1?Q?W08w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bd63695b-f5a9-4d91-fd2b-08db5063a88c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 08:01:56.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KC4lz6HEaSxUGzqO/d1xLmsiklBYPel4PM00tmUoS/mDU25VHmSWd5fv8QRS0h8MDF9IKx5cPA/67S7Ki5nj9187U+CPyDOjY0hZRbJPsl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
looks good for me, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
=0A=
From: Hermes Zhang <chenhuiz@axis.com>=0A=
Sent: Friday, May 5, 2023 07:48=0A=
To: jic23@kernel.org <jic23@kernel.org>; krzysztof.kozlowski+dt@linaro.org =
<krzysztof.kozlowski+dt@linaro.org>; robh+dt@kernel.org <robh+dt@kernel.org=
>=0A=
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-iio@vger=
.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linu=
x-kernel@vger.kernel.org>; kernel@axis.com <kernel@axis.com>; Hermes Zhang =
<chenhuiz@axis.com>; Lars-Peter Clausen <lars@metafoo.de>=0A=
Subject: [PATCH v3 2/2] iio: imu: mpu6050: Add support for the ICM 20600 IM=
U =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
The Invensense ICM-20600 is a 6-axis MotionTracking device that combines a=
=0A=
3-axis gyroscope and an 3-axis accelerometer. It is very similar to the=0A=
ICM20602 imu which is already supported by the mpu6050 driver. The main=0A=
difference is that the ICM-20600 has a different WHOAMI value.=0A=
=0A=
Signed-off-by: Hermes Zhang <chenhuiz@axis.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/Kconfig=A0=A0=A0=A0=A0=A0=A0 |=A0 4 ++--=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 10 ++++++++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0 |=A0 6 ++++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 |=A0 2 ++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=A0 |=A0 5 +++++=0A=
=A05 files changed, 25 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6=
050/Kconfig=0A=
index 3636b1bc90f1..64dd73dcc4ba 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
@@ -16,7 +16,7 @@ config INV_MPU6050_I2C=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_I2C=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver supports the Invensense MPU6050/=
9150,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20=
689, ICM20602/ICM20690=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20=
689, ICM20600/20602/20690=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and IAM20680 motion tracking devices over I2=
C.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can be built as a module. The mo=
dule will be called=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv-mpu6050-i2c.=0A=
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_SPI=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver supports the Invensense MPU6000,=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20=
689, ICM20602/ICM20690=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20=
689, ICM20600/20602/20690=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and IAM20680 motion tracking devices over SP=
I.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can be built as a module. The mo=
dule will be called=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv-mpu6050-spi.=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 8a129120b73d..592a6e60b413 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -244,6 +244,15 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU=
6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20600_WHOAMI=
_VALUE,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "ICM20600",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .reg =3D &reg_set_icm20602,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6500,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1008,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TEMP_OF=
FSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_ICM20602=
_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_STARTUP_TIME},=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20602_W=
HOAMI_VALUE,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "ICM20602",=0A=
@@ -1597,6 +1606,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =
=3D ARRAY_SIZE(inv_mpu9250_channels);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_=
masks =3D inv_mpu9x50_scan_masks;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 case INV_ICM20600:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D in=
v_mpu_channels;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =
=3D ARRAY_SIZE(inv_mpu_channels);=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index 2f2da4cb7321..0e39877678df 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -32,6 +32,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20608D:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20609:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20689:=0A=
+=A0=A0=A0=A0=A0=A0 case INV_ICM20600:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_IAM20680:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* no i2c auxiliary bus on=
 the chip */=0A=
@@ -183,6 +184,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20608d", INV_ICM20608D},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20609", INV_ICM20609},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20689", INV_ICM20689},=0A=
+=A0=A0=A0=A0=A0=A0 {"icm20600", INV_ICM20600},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20602", INV_ICM20602},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20690", INV_ICM20690},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"iam20680", INV_IAM20680},=0A=
@@ -236,6 +238,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20689",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0689=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm=
20600",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM20600=
=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20602",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0602=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index 94b54c501ec0..b4ab2c397d0f 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -79,6 +79,7 @@ enum inv_devices {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20608D,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20609,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20689,=0A=
+=A0=A0=A0=A0=A0=A0 INV_ICM20600,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20602,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20690,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_IAM20680,=0A=
@@ -398,6 +399,7 @@ struct inv_mpu6050_state {=0A=
=A0#define INV_ICM20608D_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0xAE=0A=
=A0#define INV_ICM20609_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0xA6=0A=
=A0#define INV_ICM20689_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x98=0A=
+#define INV_ICM20600_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
x11=0A=
=A0#define INV_ICM20602_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x12=0A=
=A0#define INV_ICM20690_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x20=0A=
=A0#define INV_IAM20680_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0xA9=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c=0A=
index 89f46c2f213d..05451ca1580b 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
@@ -76,6 +76,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20608d", INV_ICM20608D},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20609", INV_ICM20609},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20689", INV_ICM20689},=0A=
+=A0=A0=A0=A0=A0=A0 {"icm20600", INV_ICM20600},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20602", INV_ICM20602},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20690", INV_ICM20690},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"iam20680", INV_IAM20680},=0A=
@@ -125,6 +126,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20689",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0689=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm=
20600",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM20600=
=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20602",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0602=0A=
-- =0A=
2.30.2=0A=
