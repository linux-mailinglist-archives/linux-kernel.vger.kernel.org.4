Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A253624B20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKJUDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:03:16 -0500
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 12:03:15 PST
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1BA1B4;
        Thu, 10 Nov 2022 12:03:15 -0800 (PST)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AAHVMAX004646;
        Thu, 10 Nov 2022 19:47:45 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3kne7043h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 19:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/hMXy13z+lFfRhRaAARWnf7TbNhgtQ3zs9zFXN9dQK8jgOfZ88wOqmscPcU+hyCKTatEdcMW2lFzp6/iSjd0boV7G8Aqz+2/fv89YNoRqamwehUem7uVqQOv91zLs2WMfZIwYUCXCTdSGsPAw5jhoJu6u2pWxFNKeP/nfr4YPtGOt1UFRjcm0gTvw2yT6ftJBLRlTUwN4++4LtIqnhXW8ZWYZvkytytUcEbRA2QKwXYtchKIjLekrSxmIo56SGvIJ2yvCpfR4x+71FzjWsxlxfWB10N6pCkw0UHl+Xjz4/70OZZ16sBf4ZqnU6lLOALAptNm0fOU/5nPHtMo8LwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrSi1uGslc27bpNjSrMMOk9Vi8/hQFgr+2M/MT9cnWc=;
 b=BCWjHs1der6C/S95s3WvhbSKOvBCcE3EuKWohb4jPhyGRUteZdStty8M+cgmH0/gSeB6DTGHi6d3YWiFXC+Pr8UXCozadmsG/togSJp0j4zHWb3YRrubbqy2bksO6Ia2UO/4UaVEALmn383akvseI/9kYuHVmQFjijmEsc+pQAADaITydILq2S5iyZfLmOb3vd+rnUL4djtExcbEwMEK8pV2JNb3FHtqh3ByLoMrWa2wOCGn5zOFgjB8Y0ELQfoGjbsUk0i+ym2EfI3yGRpMsHCZVxCTCOlpOYxrIhkosSy29UPgVjADTj/iWs09nR6b5OmlVeaO32QFajQCYYZZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrSi1uGslc27bpNjSrMMOk9Vi8/hQFgr+2M/MT9cnWc=;
 b=VQeozCiTCo6lXJwVx6EIyTD7dCS4kimqdKwW1mo0h6GQpPnTSk2Svv7AH7gqRGYhHh6EHE4/SpWYdsJx0saDsGxhNg50pTCu1TOpAWh177sy3RvEhZrOZDzojpjNo1G8/ZIvCaYYNfWL2s+KzSOH29OiMRYqW7MgOtG5NLV7ziSHe6xzFpBsoa1t+LXvbZavccdG0LXAaa1JQRfCSgknOVapzb0WLwTTwIEJ8Pd9ddOZyG6xZU7GFRPubwFsVHhJhnkgT+HleRzfavNmhucLHeFsFN6Xy4vC6P/ul6NJOLejv69dLpKrMPUdrHpvcw3r4RGHg1YLLwChkEVpyRZ32A==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB1656.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 19:47:39 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5fdb:b2bf:a02d:80c9]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5fdb:b2bf:a02d:80c9%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 19:47:38 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jay Greco <grecojay@amazon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jorcrous@amazon.com" <jorcrous@amazon.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: imu: inv_icm42600: Add support for icm42631
Thread-Topic: [PATCH v2 1/2] iio: imu: inv_icm42600: Add support for icm42631
Thread-Index: AQHY9TraxZjpu3IPL0+tmgyYldpOsq44j38A
Date:   Thu, 10 Nov 2022 19:47:38 +0000
Message-ID: <FR3P281MB1757D6533D9544FB0B1717FDCE019@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20221110192933.13616-1-grecojay@amazon.com>
 <20221110192933.13616-2-grecojay@amazon.com>
In-Reply-To: <20221110192933.13616-2-grecojay@amazon.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB1656:EE_
x-ms-office365-filtering-correlation-id: 35e70fc2-1852-44a1-28ea-08dac3546c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbVRpop2H+LAoxIB5WDg3nxmBPN+if+/nYQmDtEYcn5SaoLeqGt7nhiBdnAtutjo0/SMPFrunEiEVPwjFRfwnRp7f64jfpY4oMvalYVayFOGfzXFsZtknX2+JytSLHL8gET4u026Re4v4IsHp8bPbqTHSrvSCwgbvGXkW22yL28nBrABtv0dZExkhzWw8n6DtRZuaqLTMAd8HlJSbn/BAnCuXFFSVLrHMrvvptB8/Ho1N6fSJPLWPgT8xQKVJ0xHJlmA41f/iQXB78Mz2jCoo/WOE60/L+GdPb+Txx1h+UoAS47Nb9xOb+9X1HE6ny5TiApctp5DcEXCSyEFL1ZWTyiCnfraTsFO9DJFjJB0c+fpj0ObvSampTL1TZgaFDmPWIMdiBmVsFlhKBo0S4X04QEhH2DMOHCMxPBQ28u4vYQJDvcwbXpbHPGvg7Ia/QgZYakdRxMm8o+FFVt0R5YTEIk3VGWJJYfh52UjgH9Z8N4Zgej2llGJQf7VxjfwjulSGVhu548SF4QZ5VviNnyC2bMyiInleEQO5UKHOhTP+6Nup+0N3JcK29FDauj1A0F+aijAquRpx/+WPJjvE3YS+mbvHr7hXruHnVd9QD1rJFxUF4v9RirqHT5A/0fFx3RgS5SxIU+spbvgpbSg0qGb/kYA1LvopL/G8P0pw/ZEcW98YEEqoTGtiefydu7G/3ATxmYgTPnY+LpyDdcqRlPRtgA4HHtl/hD42JaLDM2Ad9EdL9KFdTh43ORG2SQCsIf08Y/rCb3OxJqxhYD9PPJ2UA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(451199015)(52536014)(5660300002)(8936002)(38070700005)(66556008)(4326008)(2906002)(64756008)(76116006)(66476007)(66446008)(8676002)(91956017)(41300700001)(66946007)(122000001)(38100700002)(186003)(53546011)(86362001)(9686003)(71200400001)(110136005)(316002)(55016003)(54906003)(83380400001)(33656002)(6506007)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9FpVI9/Sa9JppUg3qKzYkMcEFgP9x79EUh7Z9shnv21QBNX38zhccLUsx/?=
 =?iso-8859-1?Q?5WIlUBGRrwyK1ZXpeNCLB/KG7VIrWJ2RxskfhoaHdDioxXfz25n67zdP+G?=
 =?iso-8859-1?Q?JMXPoo5g5tDz9v7Q5GKC/TmbLfDM0RsWT+SZdtYu9OlE1L93YtMm9Ho/ea?=
 =?iso-8859-1?Q?QZPq7t+fDVR8AsjM3IXBP0P9jyoJybBkIgz46p4Yh784QLd2FsQ0/qx3fv?=
 =?iso-8859-1?Q?geudBYMwOKIt1AyYjFCiQxhIYMotcpT4l5geS+X6rN6lBoqfyA3+NpnI4G?=
 =?iso-8859-1?Q?0rLJj+E6e+wTsYPS6sRW+dltaBHcmWzMmv/CUZMyZUOIioapZ7eHChdSt1?=
 =?iso-8859-1?Q?MEAr+biAvV6QQ6TvJOd+oLq9AGbE2Uqob+ARyTrGhqzhJvf+8QX3eiPveE?=
 =?iso-8859-1?Q?SRBESarMJWSZk1FrkvxC+T2qxNlJfAEoElM78J9FBs1CBbaY/WPNeEHTdr?=
 =?iso-8859-1?Q?4FK5ithWkQvF5rncpf9mSDf6/cx5nTmz2R9rX+dscPpbl0qhPLwhxQMzkv?=
 =?iso-8859-1?Q?XzQBAoLQS4mFPMibr1GNC2sH4FKeXO9CNrPWMyvRmwpq24hSk/omNqB8sQ?=
 =?iso-8859-1?Q?bbGibgLmfnW0A9KNb1F3XsgcGsAmxqMhu7KrjVQC4fTxxJR8CeTZWqCanN?=
 =?iso-8859-1?Q?OcRJlKn0inJpAywmTgX7HCrHGTu4jPsMwsHWAJTnK5UjdXVoJ8WEgX5VO/?=
 =?iso-8859-1?Q?k3aTRFm05Ji2cPq9x8D45GF0EwZF6ZtMwN2WO3uMh/1RgNlJxuGdSWVqGE?=
 =?iso-8859-1?Q?i056Bb7OLOIBAvE+7CPf59KzWMiKeEremKBlSWkJUlTqZMREdxBpFnGSpl?=
 =?iso-8859-1?Q?KVXpFAEVFKoakvgEu5PrCvwgwC4Y3BFL/byIxxEkYHpDUWgSbmXNUIJQ+6?=
 =?iso-8859-1?Q?GH0cOOs0+Bwk+qjxhOYaj2dmOjOXy0yOt6+Hx0aCNhQSBdUi0lqaIFmTq5?=
 =?iso-8859-1?Q?CaJx4N7L0Xyd/ZzMxL2/yngu3AGcoC9//62wV/Kdj7p4HewgztUYuzvF3B?=
 =?iso-8859-1?Q?/vNbKxPGPfwpnud782cINSmEuuWmE4oE6HPstgoRNYcW3MEpMNuHyj1jGq?=
 =?iso-8859-1?Q?2RI5ZVCF1OSc32rtEzEKh7JfSfNIIl1pZJU2gUuX2NQUz8+GqTERhNkuLK?=
 =?iso-8859-1?Q?EuxBlt8CbY183vGNOOpd6MevwIEGVY/LoIvJXl2vUxKILUcuh1gG9/X8gU?=
 =?iso-8859-1?Q?QHhp76q6pJSW7UbaKTWegq9xDBy8YJBALj9jIVhJsG0PEIAvoeQkp7KjDI?=
 =?iso-8859-1?Q?8VbK6K0dt0y9S6gG2NTGZYbV+j0NhifFIhm7vx4a+/A3/uB8Ru+ZGwHMlU?=
 =?iso-8859-1?Q?IzUb65GzotXSFTP3OTgK8jTzxmhwzQQ3rSUuXQwW5Yv9gGKTDrbCmKN0CZ?=
 =?iso-8859-1?Q?90HmR1NzvS5B8FW5CBwDsW0nsqrMEKjiZ1OQk/e0rNW/nSolnp1537uOf7?=
 =?iso-8859-1?Q?Ehh9l68Jhw/YFy/UNzWOHNa+YRzvXIGA9JUuPUCKUnYZqZRmGoKUfdkqqf?=
 =?iso-8859-1?Q?kuyIXV3vtqP2AM7TCK/coLPGoK99lto3HomVysYbPW4dzJtpnebQL8p83i?=
 =?iso-8859-1?Q?fy6h2T629FYAsSx/8dB1i9QEvXZpoPBwEc2jlgjLJWMRxJwiK65ZuWCm87?=
 =?iso-8859-1?Q?X7kTtIfHqrh/bv+i26d3b7m72vifGkIYnNItNUw8FB2U1DLLfRwt7jZsdq?=
 =?iso-8859-1?Q?iFDxps5JmAUuPN1RV6VYud65c8YVFnqBkNMLYBV+q5911SgGdIFB5Fb8uE?=
 =?iso-8859-1?Q?w6rw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e70fc2-1852-44a1-28ea-08dac3546c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 19:47:38.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v06Uw0kxpTwUEvf9FhKOK5WPgGCADcNBtVStBgHBHgD8b+awB6lfO0U0mC4AU5W9iM4s8gM9tjUCyy8bVjtK7hzFaqJJl9QlTLi0zzS9QgE=
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
ic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>=0A=
Subject: [PATCH v2 1/2] iio: imu: inv_icm42600: Add support for icm42631 =
=0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
Add the required WHOAMI and device_id definitions to support the=0A=
icm42631.=0A=
=0A=
Signed-off-by: Jay Greco <grecojay@amazon.com>=0A=
---=0A=
=0A=
(no changes since v1)=0A=
=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0=A0=A0=A0 | 2 ++=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=A0 | 3 +++=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=A0 | 3 +++=0A=
=A04 files changed, 13 insertions(+)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/=
inv_icm42600/inv_icm42600.h=0A=
index 3d91469beccb..0e290c807b0f 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
@@ -22,6 +22,7 @@ enum inv_icm42600_chip {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42602,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42605,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42622,=0A=
+=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42631,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_NB,=0A=
=A0};=0A=
=A0=0A=
@@ -303,6 +304,7 @@ struct inv_icm42600_state {=0A=
=A0#define INV_ICM42600_WHOAMI_ICM42602=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x41=0A=
=A0#define INV_ICM42600_WHOAMI_ICM42605=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x42=0A=
=A0#define INV_ICM42600_WHOAMI_ICM42622=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x46=0A=
+#define INV_ICM42600_WHOAMI_ICM42631=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x5C=0A=
=A0=0A=
=A0/* User bank 1 (MSB 0x10) */=0A=
=A0#define INV_ICM42600_REG_SENSOR_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x1003=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index ca85fccc9839..12952739f749 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -87,6 +87,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_=
CHIP_NB] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "icm42622",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .conf =3D &inv_icm42600_de=
fault_conf,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 [INV_CHIP_ICM42631] =3D {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM42600_WHOAMI=
_ICM42631,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "icm42631",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .conf =3D &inv_icm42600_default=
_conf,=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0};=0A=
=A0=0A=
=A0const struct iio_mount_matrix *=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_i2c.c=0A=
index d4a692b838d0..38c36a655167 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
@@ -84,6 +84,9 @@ static const struct of_device_id inv_icm42600_of_matches[=
] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }, {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm42622",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP=
_ICM42622,=0A=
+=A0=A0=A0=A0=A0=A0 }, {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm=
42631",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP_ICM4=
2631,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {}=0A=
=A0};=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_spi.c=0A=
index e6305e5fa975..6a85c12d38bd 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
@@ -80,6 +80,9 @@ static const struct of_device_id inv_icm42600_of_matches[=
] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }, {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm42622",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP=
_ICM42622,=0A=
+=A0=A0=A0=A0=A0=A0 }, {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm=
42631",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP_ICM4=
2631,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {}=0A=
=A0};=0A=
-- =0A=
2.37.1=0A=
