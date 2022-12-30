Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D6659586
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiL3Gyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiL3Gyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:54:50 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C585C1A;
        Thu, 29 Dec 2022 22:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672383289; x=1703919289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LmZ6qUPPI2on84bhTlY3GzG069PqUmdQBlkPV23ZFV8=;
  b=I95A1m/Yu9qfwCzAXJ8uBTowugmmJrfQh3PK7R7aQmiI5HpaH3lDuelL
   zeDtNxPuJciLzGSgmuKDMyixtqwz4siC+Gro7sxGrGXO6ajBjiJTWonYW
   Y4N+g9dxt8YMboxidhVRn54HUhdxtT6D7p0h3/vHwnGZJ1QNZHsq1b8X3
   xjfzbE4TNRtjBMnSwW1VPdfXu1CXsqx7NMO9xf2leiKST4Ixr7Qw0IM/p
   r+falIPX+S2FU80OVqYXrxh8f1WavAC7mAJkILDVelIV9xFEw2g8spB/d
   xTNABYkkNfbANhXNhkHAY2Y9KUnaB2LxZYvRErH5THpqLwFApCr/4kZvY
   g==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="324021850"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 14:54:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9pxkxLXTzOFyuDIhrRmDGxSL+hilwDtFTKLxEKlHVINnjTgay1NWdFx1iH0QvJZElsCB4wo1rplM7jfSNAv9euh1EWfaz2L9gfEmpYuP4yNhei4ezFv+92KHaaAFJssk/obHsug73l9GE7pGgqJaU7fEFTIY2jmliAzBCp/ODK2qQt/ST5vVgv2FQy/6TmEIuPCOfogMBFWnOrh8dUgtezOFNBXxj7LflN2EBL4emO5DsTqxTsbQgcvLjMC/HXxFBIQz5hCiKOzgd2dZifbb0XjPENV+8MfOM5uh0w2CgCIc4EiXpgxq8lMiuwfohwp8dRM9b9K/Lws06pew5sdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX/qMCSs+foxIysksHD7mwCc4L1NRItPQaXGsptBs3g=;
 b=kg6yRYyclY7H7pu3L8LyGxIJZEGUILHpf1LF1Mby0A2BixgWDa1TXkOnKoehN2TRJAIDMHil+KQRlWEPtI/PZ36Ritp0fbb7b5vHeHR9Gdbg4wJ9HH58YsxjXje+Xjc0K6eHKAsR7AulP4suaS8Ckccunk5N6dYfND/fkKfB2SnQvFMfxJaZ/yr09bPUzgv2vYG3PhN6annrT1DDpkdBRgIktiBrtow8zZngMBJlJnfNtcUsxBjTSzfD0DunceuJa6qBj1tq7ExClBS3IIESf2v83cAbYFT6o/EOqdPnqTfbmRNY7rVELtcxzV00aFAGECy7G5fNNXKzkYad38o+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX/qMCSs+foxIysksHD7mwCc4L1NRItPQaXGsptBs3g=;
 b=UoFFYDJEvtbaGvx/iMxvrbK9RB9fVDG0vCkhDRiRQUr6QFAPkokMV/3ddtSeAqXrAbkbnCNwpZkkY6/Ll/5rHDuXW3mMhwoaNMB7Q1CRaJC10O7TWvB4LhtFaadj/6pATD/9FynT9fdJdHE/9wbmlJPTrRUhgYXgNXXTv2JekMs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB7704.namprd04.prod.outlook.com (2603:10b6:510:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 06:54:44 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 06:54:42 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Wenchao Hao <haowenchao@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
Thread-Topic: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
Thread-Index: AQHZHBuXdr32pQ38V0SEMJIDkYJ+Iw==
Date:   Fri, 30 Dec 2022 06:54:42 +0000
Message-ID: <Y66LMf2O/QFkRtkW@x1-carbon>
References: <20221215153749.1947570-1-haowenchao@huawei.com>
In-Reply-To: <20221215153749.1947570-1-haowenchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB7704:EE_
x-ms-office365-filtering-correlation-id: c84f673a-55fd-4483-b5f4-08daea32ba7f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JarU6MjdkLiZRxMiNvXbdzKX/H6xUez5jP/DkmPBCGZbi46hKVcCrORnDl3/A610mW5hZ3POn/ZaWWbxAjKgj5zKL4Ojqz15SmQlCGhPOaiK6g9XzW8O54ZqJQxIlhOqgRxLEWFFaNior/NQaRdpLyepdQ8PpImWi+Y4mgE7G4v3KkzoK9GTlschN+WRVR3tBsJ42dsQukzzLqoTvAuyDkTcXcyMHjqHKtwzYz1j5VOiXfpzWI5bhz8AsAlUSgmeuZ33X0Dy1M1oJED3wrDON2Wa5vC/ye+7hlBTg1FnZKH6JMr5WWSsKdUXNGQ722n/p/+Jgp0siJ2wBuZx/VU2meG90ZXIVomxUoHC3vEkYh3m34Op+4cGrGir7sBmFRoQ36kW+K1WzDqlYLqCLuO9oOwhO6zuXvvrUqGR7o/XVr5Q6VlPTad6+qiITJuLthqvEkrwyfrMWg2YiENLBpZw5ircQZbxZRlClqr5LvInkGDLFTvIhYkj1oFcdsbThaIALQyi5HrSMzn/sSqFVI92yPuotexbh1INrapdwC9HFtTp4t4/V0v5GhhjOqfNDIhO63Q/3/Y8asLGAI3YX1jaw+HSDkw03K/aiQEBkPPFdRxgc21vnx+/f7hKqiGuoD0bd7pntEnFoCDs+BaxU+YqlvCIld2LJB4+YefhnQGFKleMQYcIXHDQ3VG1oMGekxLspyoClNzK5j1id4WQyGufDkFKVp/gwf8m+zrKBumpbSUPgcInCM4HtTDQXae+o0Q2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(66476007)(5660300002)(41300700001)(8936002)(64756008)(76116006)(66446008)(4326008)(66556008)(8676002)(66946007)(91956017)(316002)(33716001)(478600001)(6486002)(54906003)(6916009)(2906002)(186003)(6506007)(26005)(86362001)(9686003)(71200400001)(38100700002)(6512007)(122000001)(82960400001)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6fkMH/YBwYRYtzH3JXe8+tPegf/LVaiYA6dbbaWO+q0qEOUGl/QnE9J4ufM5?=
 =?us-ascii?Q?6F67gjCmjweEzwby3XyqBbiACHbJfbaxfgTiTf+8GT3k4FpF/sOsB0QqEUgg?=
 =?us-ascii?Q?e9hL2CTL3vcmxBbAbTV+5nXPXU6Y89ji4eN7EQufVONPsTSq4cm06KnpzK2k?=
 =?us-ascii?Q?viDlPPZ2r+66Zw7IIICm3oV6jTRcPyBnvjGgqUFCH4vtbJWgHLqhd4Dx3BPW?=
 =?us-ascii?Q?zwYZBZhBeMHbpvDyPxALBIr+dUcKTitmFJopLHMPZXgcrupcGCGgMmj3FyJL?=
 =?us-ascii?Q?ztghpVrc4Mtb6wwc9xASsx+RDWaVQJkt2l+eb/Q1/zBurVw7XJ+GMOqM5KfN?=
 =?us-ascii?Q?ylLbdVhO5FFfkmn7O1zdTdeBm8npQjAWlWq67WXY5OkDvy0crT+ydCAcNujz?=
 =?us-ascii?Q?c7xfdxb9NuDFehHEciFoeaGhQCzM0m4HZIhhZpy34nm396pXdLbeNeZ7bS+x?=
 =?us-ascii?Q?Yv0fdrueIp0Zd8gMEba1u1qk33WGbpfnF0k2nSzTuQIRqkh8trnQW3rTUImx?=
 =?us-ascii?Q?KCS6czAkeMqsVftlpD/KLwhnYCxgEyIrdae7+Il7VbrKPw6IzDFn12HPs1IL?=
 =?us-ascii?Q?qH5gIEItb1+1vEhAkKvAtUGU0nc4+UWGgjQo1HfUbppHKnJjpigKHw/wbk6T?=
 =?us-ascii?Q?7u86ThD/7maBKxDxboDes7ixTkMZgU7BhDFA+4+ZgGIEY9gDcZr35fwlmHhj?=
 =?us-ascii?Q?53rcGrDibdcpEBYQ3YsqCJdpb/iqqX7/GsQD/igYE6YmOUVeHxfPsDVh73ED?=
 =?us-ascii?Q?+taycjjtEW986IW7AajBD+AkjlaoSbhzUCDTjaOLOiFZW+I/IezyY3QqE303?=
 =?us-ascii?Q?pLZCo/SUcmiukbh1LLVishTgOCPnPNeE0Mzrwk8L1WiOwFOmxMiKRpFbR02g?=
 =?us-ascii?Q?5JqLxysMfgFYKR9zse6rIizxrPWbzRqcPZJyDPNQ0v+QnuDXPQpZjEdNeqvR?=
 =?us-ascii?Q?RH4U5PXYd+cHEWFjJdmVnwmduxBMIC19CbGVyEVK2nb0mIAxFsFyLzCiwlV7?=
 =?us-ascii?Q?MzPxKyVfpk/57WsPgHW5wZGtNxBDCDEQmB1nUpMzotVd0dqirKAIqm4fwDke?=
 =?us-ascii?Q?KOtmhmmFpCqDIFdJasVwiPubGsZpJwlP+LA8LqRbQxOTGpABLqHczKlp/vGi?=
 =?us-ascii?Q?Qzm6WSAHYIcGObg/ahm9vfmJGiOhleIJRoxENbHvoYr4HBSZBgWGqg/ikeyb?=
 =?us-ascii?Q?RTfeHR4vz/brQaOvedpWAdAUT2VpvYrCtPBdHNC69ydRfBwbYtBb1WdWjvzA?=
 =?us-ascii?Q?lYRzHLMIXduOQw6ePY8ZVFlYr0VRFDLXdALlBqzmfDUl7ySgI9dHa5GQ7g08?=
 =?us-ascii?Q?Z6FGpg7t+T45zruhp57FiNTgtKqjz3gTeYrr+DCGbJOKpzOBO63LtANeBenZ?=
 =?us-ascii?Q?nokKR1sN+fWv0wFWiFyoXyYntNkSEDWKmcw2Ml8DInVY8aQm6j4vkbRxq5xO?=
 =?us-ascii?Q?ztSc9HCtTiUQaumRh8NexMDDIEg7fgNbfnS/UXdErAEOAYBjfQblZDqi3Uer?=
 =?us-ascii?Q?dLQhFwUJq37t+iwwlo48QdMUYAsdVg0+LF+4TgLSqt1sSuwXtB3u4evauUq3?=
 =?us-ascii?Q?nuwzoXaAQwkg6qU5VTXTKy8sDc2HhxKtVrcoOJlvqDGFQEc6Knifopn8rRIU?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <248B5DA427BB584D89F0A04ED7E4F0B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84f673a-55fd-4483-b5f4-08daea32ba7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 06:54:42.4230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iaYVv56DocdsyOp1gVohdlht/swWNhV5P/53GfmpEnCRwlO7NeY75pPSsCuImuQwDMq9jV/IwJSzP96pn6CBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7704
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:37:49PM +0800, Wenchao Hao wrote:
> If ap->ops->error_handler is NULL just return. This patch also
> fixes some comment style issue.
>=20
> ---
> v3:
> - Start with a "/*" empty line for multi-line comments.
> - Correct the commit subject
>=20
> v2:
> - Check ap->ops->error_handler without taking the spin lock
>=20
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 101 +++++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce67c14..56820b8e953a 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -565,13 +565,19 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *h=
ost, struct ata_port *ap,
>  {
>  	int i;
>  	unsigned long flags;
> +	struct scsi_cmnd *scmd, *tmp;
> +	int nr_timedout =3D 0;
> =20
>  	/* make sure sff pio task is not running */
>  	ata_sff_flush_pio_task(ap);
> =20
> +	if (!ap->ops->error_handler)
> +		return;
> +
>  	/* synchronize with host lock and sort out timeouts */
> =20
> -	/* For new EH, all qcs are finished in one of three ways -
> +	/*
> +	 * For new EH, all qcs are finished in one of three ways -
>  	 * normal completion, error completion, and SCSI timeout.
>  	 * Both completions can race against SCSI timeout.  When normal
>  	 * completion wins, the qc never reaches EH.  When error
> @@ -584,62 +590,59 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *h=
ost, struct ata_port *ap,
>  	 * timed out iff its associated qc is active and not failed.
>  	 */
>  	spin_lock_irqsave(ap->lock, flags);
> -	if (ap->ops->error_handler) {
> -		struct scsi_cmnd *scmd, *tmp;
> -		int nr_timedout =3D 0;
> -
> -		/* This must occur under the ap->lock as we don't want
> -		   a polled recovery to race the real interrupt handler
> -
> -		   The lost_interrupt handler checks for any completed but
> -		   non-notified command and completes much like an IRQ handler.
> =20
> -		   We then fall into the error recovery code which will treat
> -		   this as if normal completion won the race */
> -
> -		if (ap->ops->lost_interrupt)
> -			ap->ops->lost_interrupt(ap);
> +	/*
> +	 * This must occur under the ap->lock as we don't want
> +	 * a polled recovery to race the real interrupt handler
> +	 *
> +	 * The lost_interrupt handler checks for any completed but
> +	 * non-notified command and completes much like an IRQ handler.
> +	 *
> +	 * We then fall into the error recovery code which will treat
> +	 * this as if normal completion won the race
> +	 */
> +	if (ap->ops->lost_interrupt)
> +		ap->ops->lost_interrupt(ap);
> =20
> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> -			struct ata_queued_cmd *qc;
> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> +		struct ata_queued_cmd *qc;
> =20
> -			ata_qc_for_each_raw(ap, qc, i) {
> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
> -				    qc->scsicmd =3D=3D scmd)
> -					break;
> -			}
> +		ata_qc_for_each_raw(ap, qc, i) {
> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> +			    qc->scsicmd =3D=3D scmd)
> +				break;
> +		}
> =20
> -			if (i < ATA_MAX_QUEUE) {
> -				/* the scmd has an associated qc */
> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> -					/* which hasn't failed yet, timeout */
> -					qc->err_mask |=3D AC_ERR_TIMEOUT;
> -					qc->flags |=3D ATA_QCFLAG_FAILED;
> -					nr_timedout++;
> -				}
> -			} else {
> -				/* Normal completion occurred after
> -				 * SCSI timeout but before this point.
> -				 * Successfully complete it.
> -				 */
> -				scmd->retries =3D scmd->allowed;
> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> +		if (i < ATA_MAX_QUEUE) {
> +			/* the scmd has an associated qc */
> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> +				/* which hasn't failed yet, timeout */
> +				qc->err_mask |=3D AC_ERR_TIMEOUT;
> +				qc->flags |=3D ATA_QCFLAG_FAILED;
> +				nr_timedout++;
>  			}
> +		} else {
> +			/* Normal completion occurred after
> +			 * SCSI timeout but before this point.
> +			 * Successfully complete it.
> +			 */
> +			scmd->retries =3D scmd->allowed;
> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>  		}
> +	}
> =20
> -		/* If we have timed out qcs.  They belong to EH from
> -		 * this point but the state of the controller is
> -		 * unknown.  Freeze the port to make sure the IRQ
> -		 * handler doesn't diddle with those qcs.  This must
> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
> -		 */
> -		if (nr_timedout)
> -			__ata_port_freeze(ap);
> -
> +	/*
> +	 * If we have timed out qcs.  They belong to EH from
> +	 * this point but the state of the controller is
> +	 * unknown.  Freeze the port to make sure the IRQ
> +	 * handler doesn't diddle with those qcs.  This must
> +	 * be done atomically w.r.t. setting QCFLAG_FAILED.
> +	 */
> +	if (nr_timedout)
> +		__ata_port_freeze(ap);
> =20
> -		/* initialize eh_tries */
> -		ap->eh_tries =3D ATA_EH_MAX_TRIES;
> -	}
> +	/* initialize eh_tries */
> +	ap->eh_tries =3D ATA_EH_MAX_TRIES;

Personally, I would prefer a newline between the spin_unlock_irqrestore()
and ap->eh_tries =3D ATA_EH_MAX_TRIES;

>  	spin_unlock_irqrestore(ap->lock, flags);
> =20

You could also drop this superfluous newline.

>  }
> --=20
> 2.32.0
>=20

With or without the above nits fixed:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
