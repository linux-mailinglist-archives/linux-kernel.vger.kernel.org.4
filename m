Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA8729342
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbjFIIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbjFIIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:31:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F24218;
        Fri,  9 Jun 2023 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686299464; x=1717835464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rKbyDbKDXGeKWb1tGtvBKlGOzJ+bo8UzNps9k5QyQ5g=;
  b=rQG7DJbe+RkwhPXTl6FzJPDOj5nxFYrEANcKKbkRoQx1hCdvXyK8emfy
   /vhQtfaI32qe5jQwecGcZYeY6gxjnx9YhW95zDUGXI8VBbXjnzt2lLOkG
   symUqYed8qAgzT5hb6b4692R6LKZ0/LNXAF2F8G25DH+xLRsyU4o23sJC
   mls9nPs1DuLIkj9vMS6gVs1pnUmjaa6CBPl0L6jHjgjxQ8mQFtaLegmej
   WgcRXWPgqXn97UKDen73ql/UnTlXqOI94icPYNRticzwrA2pOQeBfolyV
   zNA1ejmhEpHNoQaKwSZ8z31IddZLG+JvW8n3y3usJ8P1DlQwa76okp8PX
   A==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="232611526"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 16:29:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3SH/fIwc/8Fqbc+I1L41/VrY03GaU4CpTvBeEIwz0ABRbgicmtP4aXLQcfdSdl/wJHSV+wwsvvhXv6CAWqEEuDLyKQQp2dkLEvrtU5Zp4GiFq+bn/1L5DFUW1Id9HqiNiYeTbXlO1o8KjNUN1HQjPgOwi3GSXQcAEmK8hkjnKaJMH4sffskpgqR7eYAkDbd1W6Jkg5/qzEbeln0fSEfXRaOxZ3cZLw3LinAxZXpzA2oGFL2v5+7X8KoZUiEmqrNOZAA2WgUjzHG97cdMKzCT6s/h0GyIxFb8iQiKYX9M1o/W9pT9OLIDpYyMpA8k4q5tuxpNg0izup2YXCJSNV+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar8VSaRKq6kiJ3l1FpdDOUpIJQS6GX43GrSDLcD51ag=;
 b=Kp8YgeSUUybKWB+UdkxOL81CRo9xQWZ5NoecuNtIvo/fw1bmesehpeDwZYrhSdPeV4hYQ3CRiNLzoLfBsvldh13/AxTvt9ECgsB4Nm9+Ck2vFHXMS0zN/j7TgiUPB/dXdnkADiya1VxXRr7oNvU8FAtdkbPuTvhV8J3s3+2JDXCvpaWxSbjkhilDXL2F6Jn2/zI6hJIPnHTTyvYuh4m1H98jLWHVVf87o56KSJVO7p4vNMTqCoesesE7C8S1wBUNXwQRvW3VOfAYgJ2QxRWNzYXka4pJ8BnSEPewRRSiGeaZnuv0Y7mCSPkMWY7M7k+rCfq8DMiY/gGHk7/0M+++YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar8VSaRKq6kiJ3l1FpdDOUpIJQS6GX43GrSDLcD51ag=;
 b=yc2WT0YrTfpIQpKRBFenCCkMWqMlcPPUam3NGMjWX2WtIuVE7klKfXXY4POuupQj8dU1V5ZAGV/ou9SWwaVEKO2NUcz0Ov9aucN/6lPDdqd8uBnILNqBIRXBJ/0jVh14UQwi6AJRJWC9auMHduHeLJY5Q3lXjL6SsdqT1c7lqZw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8062.namprd04.prod.outlook.com (2603:10b6:408:15d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Fri, 9 Jun 2023 08:29:30 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a%4]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 08:29:30 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>, Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Peter Wang <peter.wang@mediatek.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v3] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Thread-Topic: [PATCH v3] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Thread-Index: AQHZmn8WXHATsQGzxEGzwCQ9x4MRgK+CE/6wgAAPqZA=
Date:   Fri, 9 Jun 2023 08:29:30 +0000
Message-ID: <DM6PR04MB657509E3C4F9E9727F020ABEFC51A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230609030357.64360-1-luhongfei@vivo.com>
 <DM6PR04MB65753B9E63B07D53A82EB8DDFC51A@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65753B9E63B07D53A82EB8DDFC51A@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB8062:EE_
x-ms-office365-filtering-correlation-id: dbe36b40-2cf7-48a5-b24e-08db68c3a51a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdjUaF9QwAzlLkRQ4sJOlbMO7/igWVrZOBxjE3LGB1yfjELzV/Dt/zYj1dcjfZtnupq7HEt2N/OzUfaii4smrxqqdNQkXJ5wS6N8qoxU9c5uOlyNglIRsqoVCt9vHzlcmOaPAcumJ0dJnimNsUJSWKt5LkOP8MM7eYhtXIoAw4ra0BLMRe1o+3nSxjo1C8Lx9C0Al1D7wRXwMbEZSFAubFr8zhZf+pdhicEUjZqnyvGStfO11IZ5zY+G7xkbBzMic4cMlvNTmmhZfNODHjwxo9AXJwCW8NERlh3Jr6lgps5DcjGGAwA4r9fTYM5dlzk6eSScVsgxFVr/ZrlYxduK/v4rw2OwZ2riUODx9y5XUyOqOxzusaJ+hf1gSFgj5MQXNdufi0a/qQbaI488w7t+aQqQh8cjrRpKqJdOmuaxa8r0ZePga1r+FgPV3on6N8xNfdxYQl/QpG8qEzaXwEFqrQ76LwhzPQ/AXxr7qCPecGAKZ1GjM9JdQjme/Lgbscv1RyWove8M3sdCnuDoJOyX6pbCi8aA6tIoBhRib0xfoLiO4Qw4GyGGdw+nORlmsXIVGiCx/K2YqCCOKF03DPAFDrwH516jngMwYwWUuUdSQiHXG+lw6kCuY60OH3XiYVmiCS9kZ9+AHhjmDSpg2Gsogw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(82960400001)(71200400001)(478600001)(110136005)(5660300002)(52536014)(7416002)(8676002)(8936002)(2906002)(38070700005)(86362001)(33656002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(122000001)(55016003)(921005)(38100700002)(41300700001)(2940100002)(6506007)(9686003)(26005)(186003)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irMuvqk+5QvO1dItsxh7bCy3DKYrdrthZarmMhrL8O3VIdOAtaOCBX0g3kqt?=
 =?us-ascii?Q?dPA5L/A4AgjvZJMGRyIdV9HPdKNvazfZMMs1MyPx/q4N4lpbmpU1VjW0/U1Z?=
 =?us-ascii?Q?JnsF3wD5q0+VfPeAKMakW88Fos2tpPNIjSnO3Z4ZV3xOEyQOCJG54enBZvn2?=
 =?us-ascii?Q?kBtn9wxagesNQ8zXgzNbOxCB75TDH2PbLhHB7vGVkvuIa1QDDRsbYzLJu8Ax?=
 =?us-ascii?Q?e8BjFAF+COwyi4u2SpGpeYjsp124va2TX/a0fzvBdxRf7eb7yv3JiexNvFvH?=
 =?us-ascii?Q?F+UhHHDSfNeMGHFJZTNHYjezYkigwBIJb3nUhpWqvVZbgb5SjtkrnHuxr3sI?=
 =?us-ascii?Q?AfG7qD/iQKXuThG9XF8POHo2VQKAAMHvf1/ujLTcm74x+5QSKR33RMmBVtkV?=
 =?us-ascii?Q?f09ZNwOxIhBQNF4QGHh7K7vJd2SOjHkSyB18uX8u7s8nyZnHSbUmENR528F9?=
 =?us-ascii?Q?KToebMqIjRIH2hgsLDXp6Scz34lRQ66urqP+k5aCNEUgpTtKEo97ZzHsVcRM?=
 =?us-ascii?Q?cDsWvkdwL3ocOdlecM+H1zIeW/0c5wlPVvNDPXC/LYzSJShD4z1Pzrilmdtt?=
 =?us-ascii?Q?duixYILev/sZLFb+TfZIwb0F4beawT0KhW0nrnlyezqfusK3WyKYfUux4p+u?=
 =?us-ascii?Q?2lE+JfDwX/89SzdMSf+tTWflkoKc+5+O7EocTi6IPvKjmiZJ9hdDdvy8GEV8?=
 =?us-ascii?Q?tsdPT7CutRof4zgnjPDbC1sV5mfy7dnuhErhh4Q9uz6Ho+mCDZSbKzNF7dca?=
 =?us-ascii?Q?Y7W04aQDg+pH+vvzAu0Q0cOjo698PDV1bzr6kanhxomIzKgC+iBhh0iTMKT1?=
 =?us-ascii?Q?9BH80Ku08bbRM+2ibJbQSHRUXDMtF+MoHvaVeqyxqXKTsCUx9fF7kVsbBY5/?=
 =?us-ascii?Q?Rd1VF5cdyZinLYM/JIOq+L9WK29JIo8lpv5o4KFAwQIE5fxYMmKDuY0JuybQ?=
 =?us-ascii?Q?gSrzDeMJovDa5VNwm4SzZi715vNit5uN2A3+LFJz+t6nFmEe/yCaKJ6vH7pZ?=
 =?us-ascii?Q?s1Tj2OPcpbeyGoQcEO7s8JR9s5fBinwH//Kl9/4ZkTn20vEvWkIcOOlQfIQJ?=
 =?us-ascii?Q?9/wBaz/z6xAVOZPOQOoqTt2oyDIUFTMJL/4UO7eOkuCD8o/riJk8nb06nzl4?=
 =?us-ascii?Q?jYsa5/8j+aI2k+DHiKk3qH98uvWMz9xM6z/83oC2lKLuUUrH1fC4BS0V+xKM?=
 =?us-ascii?Q?teioTnedf4N55UrNiCiFfsKYRMsxCA6T+5LL6s9zMcLKRn5r6dlNffyG0MnV?=
 =?us-ascii?Q?VA1BzPaIl3KRcIjKB4wKRalB/gAxScNiLCR/asIaorDttl9uxE1omG9ReT4V?=
 =?us-ascii?Q?lxL4aBIkcpMuRJaIYNK5aagNlKoQAbElpFdXDDe4pEhDZUwBJlwIOB4vrbR3?=
 =?us-ascii?Q?NCJ55j0gBOaxoUaOVFcZsTYnM1MNaPApYZW9Oo/RqPWWGgSzannpxImmUJ1t?=
 =?us-ascii?Q?sJCHHJNVJjFRFtHeOklcajr7pp0yyXVn9qfDKhlAvpPxaKcmYm6UfNh7CK6R?=
 =?us-ascii?Q?rhCtZ6Zix0FZ2yN9gTsIS1LSC4h79Qp/GPONyWGtAaFYbFKdLIEI3TWl+33j?=
 =?us-ascii?Q?gKwNMToYe0gA0W5vOS7qok5ppmbm8onebJ15zRXI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DviX++xoITSsZIyo6A/OM+1/SFHkawGAeT643BMhj6BE/evmEP3FO7o3VioW?=
 =?us-ascii?Q?svqprFDUAE84wLH5e9Iq03A1rmWJYcH7OzzOflbcL+u8Vp1xz2At+XPBA3Bu?=
 =?us-ascii?Q?JLADcuIdQkNYmIKAs4ORI6i/bkNUfsiVqGHkw4RXcSctW3PCU8iKbqclgUiA?=
 =?us-ascii?Q?199PoghMiNENpkY0tjwbtUgI4/oeo+DMnHATbON/2v/rRt96v+sSKexyn64X?=
 =?us-ascii?Q?+0lCdKOKVVq9qzG6Wb8PNz1ZUiGsmu1qbUvajStwVk0fSjtNQKRMQ+rrl1SS?=
 =?us-ascii?Q?0CzddEtFJiQ1gxF5iG0x3dpjv5HTR97qfGQfdsb7C0Ct1cITvrIHIBHEn9ef?=
 =?us-ascii?Q?bvZ1NfwpBCT57BSL6KhLPVpAr/wefHl3TIpY1eu135XXZhMl56oRVApnWCDF?=
 =?us-ascii?Q?vRzEgCv8H8J2zJHIOZjQsCCXZOaRehK6Y/vt2HkzjSN9Yaomn/E1U8FYVUIU?=
 =?us-ascii?Q?dFHTRafu4ultvSn8fQ1iLpMC0grR1NtyJlvq+g1LH9uTon2FafF68fSug4Vc?=
 =?us-ascii?Q?aw5QO54M3ZHek9jq10ASqZaSJBeRp1g3QC4ddF//c+5DbVL6rD1VWeG6Eog7?=
 =?us-ascii?Q?4kPC7ojMNa9uPEJJ2L5PEArs4pXPu1f+BCQKIG0WkFd8813c6Yw5pBLtI5Wn?=
 =?us-ascii?Q?C6RvlYcWwFwVr1Y3RGBCp4a6lYetVpTB82g3Lw2DEN3BgVc8pRrsPrh9tmrM?=
 =?us-ascii?Q?4fxQP/YO6KGjqvyWuElXZqBNAWyKxCHRunRjSMG+jKKFN6/2Vd+gxCMc9BD1?=
 =?us-ascii?Q?ZLDkOyvaT1c2hTQ7vAuI9Fxyv/+gYK9Rfjh8sK1qjVryhhecn6E+zJKXBqEt?=
 =?us-ascii?Q?CVvXOJFgvHGyuayGraBvssHU4U9KnUR/HWs1+f3n5Cv5YSOyjM86E8+sfh1t?=
 =?us-ascii?Q?I+b637NrY4lTWEj8bnkwM+Lsv1gsQ3MObLU+9NMdba1JjXpz7N6d3la6Y7Qb?=
 =?us-ascii?Q?h78PDxKoTodWaFQPPgGbXzOddg2ySxBuG0U3X1IwjpYBNQXnO0ISa6wQk0zM?=
 =?us-ascii?Q?PnxEhTGCy2+IgeEUxR2LIQydZg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe36b40-2cf7-48a5-b24e-08db68c3a51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 08:29:30.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhebsEFkUbGYAYNKHC9/uIcZCkO2SvBTuC1SoWYJ66z2qG4+j/WWVwwYkuMongSnWFd7IqvJ1QDOQCgir5YZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8062
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > There are three flags that control Write Booster Feature:
> >
> >     1. WB ON/OFF
> >     2. WB Hibern Flush ON/OFF (implicitly)
> >     3. WB Flush ON/OFF (explicit)
> >
> > In the case of "Hibern Flush", one of the conditions for flush WB
> > buffer is that avail_wb_buff < wb_flush_threshold.
> >
> > As we know, different users have different requirements for power
> > consumption and performance. Therefore, we need the ability to
> > manually set wb_flush_threshold, so that users can easily and flexibly
> > adjust the wb_flush_threshold value, thereby achieving a balance
> > between power consumption and performance.
> >
> > So the sysfs attribute that controls this is necessary.
> >
> > The meaning of wb_flush_threshold is the percentage of WB's total
> > size, such as 1 representing 10%, 2 representing 20%, and so on.
> >
> > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > ---
> > The modifications made compared to the previous version are as follows:
> > 1. Using 'wb_flush_threshold =3D=3D 0' insted of 'wb_flush_threshold <=
=3D 0'.
> >
> >  drivers/ufs/core/ufs-sysfs.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
>=20
> You are missing sysfs documentation.
> >
> > diff --git a/drivers/ufs/core/ufs-sysfs.c
> > b/drivers/ufs/core/ufs-sysfs.c index cdf3d5f2b77b..347207f4e8ee
> > --- a/drivers/ufs/core/ufs-sysfs.c
> > +++ b/drivers/ufs/core/ufs-sysfs.c
> > @@ -298,6 +298,37 @@ static ssize_t enable_wb_buf_flush_store(struct
> > device *dev,
> >         return res < 0 ? res : count;
> >  }
> >
> > +static ssize_t wb_flush_threshold_show(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        char *buf) {
> > +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +
> > +       return sysfs_emit(buf, "%u\n", hba->vps->wb_flush_threshold);
> > + }
> > +
> > +static ssize_t wb_flush_threshold_store(struct device *dev,
> > +                                         struct device_attribute *attr=
,
> > +                                         const char *buf, size_t
> > +count) {
> > +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +       unsigned int wb_flush_threshold;
> > +
> > +       if (kstrtouint(buf, 0, &wb_flush_threshold))
> > +               return -EINVAL;
> Maybe also make note if wb not supported:
> if (!ufshcd_is_wb_allowed(hba)  {
>                dev_info(dev, "It is not allowed to configure WB buf flush=
ing!\n");
>                return -EOPNOTSUPP;
>        }
I just noticed that Bart asked you to leave it out - sorry.  Please ignore.

Thanks,
Avri

