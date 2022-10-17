Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB2600CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJQKp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:45:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D118E1E;
        Mon, 17 Oct 2022 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666003553; x=1697539553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HRUjRV6KJeOeYsD10koUTyUJPIWJN8mzBKnH+IoZDbA=;
  b=LLHgXtPJaIyTf6MUoEWYL9xA5PfoXsurNoimXOolJRZRpP3nqRZ2AOo2
   QK5fOcZf090MKcFXPn5CRNBfkIc/A8RzbWjfwW0cqf3bfSqNTUBReQ3SB
   0028UGGnG2laj2p+Frrckmwuh2lI3cXJ8l6phCWfmzkfqCl5J3feZjG8x
   4QzVVGihci+eYRl8Yb9J3XTXtismshHFpwRiJG5YbOETlqgVbcvPxZY6p
   6X3BPwM6zGeBJQ5E/JkGZ3xlyXqieAREHNpIe8Ucjw0RJybFN1F2B9fzF
   u1Vy0imnvNlnptJ16UjhzzhNttw19meruF1BjIg8eu0HcnCDD5redYvhy
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="326116039"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 18:45:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHyT+n6xcxXhYOMVjX7BV4/q+aWuKoqXTo48zBZ0fkgnIy1uZ4F+KwsMStEadwLrYr5bQWns8JCTAKEJUHGxlcf+EooPIZcNjvmoMMxdeEaQI/pjzQhpECgf5cVGEhrPcs0SQn4vHD6H4QCW0QRJIOElmVjhqVVzsWMhYczxaZxv1lMv+292XDEbS3nFJwL1pkkZa5oMMYrpREMEcD/xf/d1189QL5Y7o1KYGe/Gnx+zNjfTxsVDGNhZOH1laqZPl1Z07An6x81UlOflqhn6r56+q0hGwddMFFxWZnxX92QVsEBooktxOia+alwFQK9C4JBu9CVML3mApvIYn7lJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf78xzkdRPvGz1vFLvJzVgbnJMvaw5VvxHCBO+DryUQ=;
 b=kB75Y7LZc+GguilHQ2TCOuNFHE+RBYSyrDyAA4mo9QGi+4fA1TgnmHHgWlscTi+gca6Tx+tFM0Ectplal9uqrvGaKDlmCRlMy4O3YzwQ3NRTcvLr+PXfb94YqX+kVYEaAXxaOT+PhXmqlqMixje7SJI8QMKhzwXszamwop4eXpjEtVgGpQZ0llFSc30tt1A6lkjd2zoM5tiqAkBFJ4iMFkJ8j8Cxeox4g0SJ9GyF46AUp9mNIUDa1yOd8bZSlbyz1g1KZ2NujX1xAOI9XgHtYOqYam/NW2w7fUXXXqf8XYBknHy/KRU9lK/AcjMjijiCggRQfSwlnIEC4RqsK18sTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf78xzkdRPvGz1vFLvJzVgbnJMvaw5VvxHCBO+DryUQ=;
 b=E7GL+05BKFJ6eWQygjuEG59SIUG0kGtCSyDbETZ4ZXti+W+Kogs2D0XaTur2RWLZOPKqLzbyVyqt6lfasbRYJQVRMRA/zVW3sx8O2s/HG1x33vmIlwd205fJiWCXJm4OIor6ackbjHzq1Y4DU+WtZSiIk79FsREHJX1rRQyIOV8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM5PR04MB1243.namprd04.prod.outlook.com (2603:10b6:4:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Mon, 17 Oct
 2022 10:45:49 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5709.015; Mon, 17 Oct 2022
 10:45:49 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangxingui@huawei.com" <yangxingui@huawei.com>
Subject: Re: [PATCH v6 4/8] scsi: hisi_sas: Modify v3 HW SATA disk error state
 completion processing
Thread-Topic: [PATCH v6 4/8] scsi: hisi_sas: Modify v3 HW SATA disk error
 state completion processing
Thread-Index: AQHY4gWEwLjx/FFUO0uVVNc+tkO6264SZy+A
Date:   Mon, 17 Oct 2022 10:45:48 +0000
Message-ID: <Y00yW9PhSJWjobVC@x1-carbon>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
 <1665998435-199946-5-git-send-email-john.garry@huawei.com>
In-Reply-To: <1665998435-199946-5-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM5PR04MB1243:EE_
x-ms-office365-filtering-correlation-id: 94b89c43-c870-45b7-ef11-08dab02cc105
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7O1+CrpKOabpv4l1QocSPcbQpHHT2xi+vxHSEEeDpwmplFIv+VMDOEjipwA04qS1Y/efokQdqjgFwKCXpHxmoWeO91kNxNaa8w08PWETcy0nSmp+qiF6elF+uXCoKMc9GlBlM5TTuLq8tqkJSHiFCpR0opUOFJDYL/TYZcnrbpPRDPf0kGM6oiWbhiUdkdIkOpN5J6kAm6Obvy+Kw5L8n+iwo1iZuNQa1BWkFAff91MwYBX5GeEm0wxUf+4sjuujFm9pFjBgOtR5G7dZ0xdK/Wl+hlIob/jjzZYRdoBuLx7Lak9ar5a2gRpjxkvuER7u8LC+HYjE//lltCd0FPVZfEUsODn9BS0H1ubE5u88J+mSRJGv3IMwmqKiZjeCDLFutodkZsqUkXGHjhcA7yyzml4sdQAWNHHyki9iYf2sA/4wuW7n8wt8vL8ahk/q/jntAiDk0ui9WrBv7g6JlJ5xDdoj0rRMJ+UL4fpehirdaRNPHzEsiYutp/tFpnwmCnlRDER4s4pyNRK1KAt9g7CwkfUOZgPLXNgeDDm3M6uBCwsMltyYjKEKbiC9bud4m/1qK1sKiYVANQGKSPIoi87nMh2yC93mBNeBY3g1clYFEcS1+SsbE5bA/FIiWiqP/9ydSylLBXf6pZ+cYC+XRY9qxKJA+A0EPubxZ3h+8aCSeRxFg/n+MfITioZvSTZKj/inNpwxiecLVHn1I4wyTBimbZdI9TRjrBHJWv/B+JP/ZftEkOfvAo4bqq4w+kvRMBvOquQxtBtOLV9G+Xxjk3q9kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(71200400001)(186003)(82960400001)(9686003)(5660300002)(2906002)(122000001)(38100700002)(8936002)(4326008)(6512007)(6486002)(6506007)(54906003)(83380400001)(33716001)(66946007)(91956017)(478600001)(26005)(6916009)(66446008)(8676002)(41300700001)(66556008)(64756008)(76116006)(66476007)(316002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qg/5zpHqcXq+UFTmbrHnStqFP35R1yI/WbQ/PEL7XNytwvUSeEUQ+xqT1eCb?=
 =?us-ascii?Q?Bk9/2EAIZX6u0MRovVXKz7qxttXyPUvdrbYdmeBd3ppELsoILjH1gGJP4jp8?=
 =?us-ascii?Q?RV1I4nMZSHPk5y0DOmhdxAKDZplW7X68Q8a/hnwjHNptaknrj8/BJ9fEfd4i?=
 =?us-ascii?Q?jmb0/knuM8IX4Lm+UXzKRl1y0ZDX+1VUgWtQ7s1jfxs8dm/1MIOsQ7opoO/i?=
 =?us-ascii?Q?VTpKRrGaubN7OfI2Nj9aphuPopLjy7bdLF0TVhn3UkbB+KmM7PlaZoJxRSbc?=
 =?us-ascii?Q?4passsz3McAjThlchi5jyuVOTL0vL9ex+Qfai8fzf6xTa8M1cqzO4bSo8xg4?=
 =?us-ascii?Q?/ngkp4PH8e0NEHcGzFGnHIQz6cq1XsbFJVGFmO7rFfDmcCQs8FB8q0lMmT5S?=
 =?us-ascii?Q?ARrc3ajaEP8KJVztVg5a/BjYNyvl9zjoxQtFR5qgTlkwBWm+koWUy8GGic4z?=
 =?us-ascii?Q?zHgZvmjWv2pXktL1miefkjE9IXh5mC5a1VGiFJ6IGLFFxzhT2OWjBK0dC5AX?=
 =?us-ascii?Q?2oU87e2WmLdcLPn5dMuAbx7QHuX+Ae2b/DqtNKUc6B4v46Sdzq51eJ6grKhS?=
 =?us-ascii?Q?9Jekg0bWBnuxeTUBHVAhUtcKID3xqvW1h2FhKwfvu4f1uxVf+z38UDveKgV8?=
 =?us-ascii?Q?H79kf1lMP7gz4UQsSh6dpdpyrslcI8rzYg0DfO26xjOeNYT3cWGpyNIruvTL?=
 =?us-ascii?Q?X7d8T6OiiBu8XjkPTv3GO/cvrcymJJS8yTT73HTIocnY5pDg07+cbAPJYgsj?=
 =?us-ascii?Q?GGcEJdv1m9P10F7/HdkNOItTLuUKW3v9uVHuUuavD+gLdcMW1X0r5q7GbB6P?=
 =?us-ascii?Q?n96sTRuzvpoeVNwcK5UEK+VzLaKeyGOng2owTyqe8kMkoxqpJM/s76AZyIO1?=
 =?us-ascii?Q?stesKwbYkihkuGV2VXqVPHRYP2nu5AWqhL4dwGzjFWE3/9GL8kDUEZJEQ6uO?=
 =?us-ascii?Q?5rtUfwqbOMRBln2U5/UKhP40vsWyH/IyAfy73XOXuUy/jD/djjSz3Zke+moS?=
 =?us-ascii?Q?XuwasSTso++gJdRjiuPRctXiQZEro77OQSrz03cQnFUhW/dMn+HZ3bwjEUmx?=
 =?us-ascii?Q?TyqC8ZkuL6IOZCKvj/d5zu9xXOZlfsu+Zh3b1tT9yxFghrX/NtN4efZlS58S?=
 =?us-ascii?Q?AwIzEgbUBolzXCZlG3TNA/wJ9AeaTDiBdMeNL2aSihkNOoJ+kVAIDV2dGTNS?=
 =?us-ascii?Q?lEEYr6rS7Obqme1N0hNMJNG4AcaqGlaKrqhaGyqY2ia3zcRrX5AgpGvmpSG2?=
 =?us-ascii?Q?Ip39u8hwhlxMQjQ7vtGuEPuRG4Fl7uePnhqnDw45vNdDPkI4lZLN/KSZ0m7o?=
 =?us-ascii?Q?stHX8yOCYrJGIrH6zwuicTOpDAeD9CeUUOi+1wvE7//wB4l43MVdfKnGDpu8?=
 =?us-ascii?Q?zeD0V3rdDUQVrDciUz3L3GI/isAFluktB4TqpY02dfb/caljwm4rBbUQKyZc?=
 =?us-ascii?Q?pqPVAMBo9aCuPhuqbRuiKndGmd0smbuy2iWOtXOtjZwt2+58eAZ55zR02YbP?=
 =?us-ascii?Q?KLxt6KKavUoEveDlpDegCgQrhKZk8W7cU1P7hBNC+tii3LFt5TnRQtYl3Cmo?=
 =?us-ascii?Q?AHcorHmSDT5tyt8p7yde5TZroRGbva4KixzACg4HxBJ4RRp5asbYGkwlXYGJ?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAC68C5CE4790A43ABFFE1F3E28225E9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b89c43-c870-45b7-ef11-08dab02cc105
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:45:48.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2KsIzUt5ejrLJFQsbd2MtV8Pm3VlEcgi91twsTlkQ4jpckKkfP/fFqIeDfwrgQUBBxGxRjyIrG2/J+qqThLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1243
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:20:31PM +0800, John Garry wrote:
> From: Xingui Yang <yangxingui@huawei.com>
>=20
> When an NCQ error occurs, the  controller will abnormally complete the I/=
Os
> that are newly delivered to disk, and bit8 in CQ dw3 will be set which
> indicates that the SATA disk is in error state. The current processing fl=
ow
> is to set ts->stat to SAS_OPEN_REJECT and then sas_ata_task_done() will
> set FIS stat to ATA_ERR. After analyzing the IO by ata_eh_analyze_tf(),
> err_mask will set to AC_ERR_HSM. If media error occurs for four times
> within 10 minutes and the chip rejects new I/Os for four times, NCQ will
> be disabled due to excessive errors, which is undesirable.

With patch 8/8 in this series, will it still set err_mask to AC_ERR_HSM?
If not, is this patch still needed with patch 8/8?


Kind regards,
Niklas

>=20
> Therefore, use sas_task_abort() to handle abnormally completed I/Os when
> SATA disk is in error state, as these abnormally completed I/Os are alrea=
dy
> processed by sas_ata_device_link_abort() and qc->flag are set to
> ATA_QCFLAG_FAILED. If sas_task_abort() is used, qc->err_mask will not be
> modified in EH. Unlike the current process flow, it will not increase
> the count of ECAT_TOUT_HSM and not turn off NCQ. Like other I/Os on the
> disk that do not have an error but do not return after the NCQ error, the=
y
> are retried after the EH.
>=20
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_s=
as/hisi_sas_v3_hw.c
> index 0ae8a60aaf93..0c3fcb807806 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -428,6 +428,8 @@
>  #define CMPLT_HDR_DEV_ID_OFF		16
>  #define CMPLT_HDR_DEV_ID_MSK		(0xffff << CMPLT_HDR_DEV_ID_OFF)
>  /* dw3 */
> +#define SATA_DISK_IN_ERROR_STATUS_OFF	8
> +#define SATA_DISK_IN_ERROR_STATUS_MSK	(0x1 << SATA_DISK_IN_ERROR_STATUS_=
OFF)
>  #define CMPLT_HDR_SATA_DISK_ERR_OFF	16
>  #define CMPLT_HDR_SATA_DISK_ERR_MSK	(0x1 << CMPLT_HDR_SATA_DISK_ERR_OFF)
>  #define CMPLT_HDR_IO_IN_TARGET_OFF	17
> @@ -2219,7 +2221,8 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sa=
s_task *task,
>  		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
>  			ts->residual =3D trans_tx_fail_type;
>  			ts->stat =3D SAS_DATA_UNDERRUN;
> -		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
> +		} else if ((dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) ||
> +			   (dw3 & SATA_DISK_IN_ERROR_STATUS_MSK)) {
>  			ts->stat =3D SAS_PHY_DOWN;
>  			slot->abort =3D 1;
>  		} else {
> --=20
> 2.35.3
> =
