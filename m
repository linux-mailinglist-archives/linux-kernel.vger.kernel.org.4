Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7964D813
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLOIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLOIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:54:22 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8340448;
        Thu, 15 Dec 2022 00:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671094454; x=1702630454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wKuchehxD1NZr0QB2if/Of45yDNMYehDTyjOVpiEMGU=;
  b=r2NWMl0Xsa7FIyqj8L80Ya2Y0CZ0flIkNoZIrk4wBKks2dnpmfMOtdgQ
   n3Rv6kcGQSD83lLlBZnxAtGY807v/BAorBzA2i12jmJo+bztg5aRUhLMz
   M+EoyH/WhUga0LJXFWIZLx23kFLhf8/8at1hH/O3rbdXoqX98evFnxKZz
   LTJXZYUSYHZyg3+LpaCChqRkJ5fpEEuYJgH1NnSXjaEDHlVKfx3MfyxsP
   7cMYWLy7wSWSkN081CmkluRyurofBc3gyUzLlIttydZ5vodbn+0vxjXOq
   iAHb8++alU63G0z8Q/v5MaQQ3sJRuxF8wDo5q8zkTOFzwb3nMock8oBxB
   w==;
X-IronPort-AV: E=Sophos;i="5.96,246,1665417600"; 
   d="scan'208";a="216909468"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2022 16:54:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzhB+oDRgbfPTK4RZg25jBJ2xthVtRYe3rE881tq+XKtEWagmsDNyeD+NmD3eY3X17uWdKQAE8Hb3e44/s5N6ERRnXhUxnzlWtg2v9QpRanvH+dLv7OXAzVjsq/ZSj3wxNxuMOuCgtWdNoXA/VnZRpu1cX8UwwyCG/y1c58pBu9Uxxr6Mp+iQS1e1lK5r16s2mtGUkImoH38JDjAFiIVhBkgg6SE5MSRBacNhp+XXWIBjLx3e7moa76rygR7U1HdIAz66/Ojg8QFZmvoQFC0e3rP98J4HNULUGDZ9e92//vxr0DyM8VT5gERF00ZGhtVE2tZ5xg7NwFWwM2vCUjDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCv0s/0PzmcRKtLxpRlGtLx/OM8FideWd7WIGb8Hvyo=;
 b=g8Qxpm0kHnfl8LQKLnJrBVRUU3vZQMJDipU6PkiI2tUjye4fN8ZgDSqJmji9SvuzlgKrnkP286c1fNnTDfHzJe3a+hFyTtqqUuNb6IivKw6wBSEt+5WxYA3kd2gjpdeFnsvqpHLgkj3MHDOazSpJc7DgtWMs4jQCe0yl5143relSU9UcwzBgNkqB3D+k9BeZUE1nHUnimq1++j1oGVBBaeUwVhOLbZfbLvgJIqNpK+iw4kLKxcr8u6bgaGLR373cIz98TEyjXsovSRh/1fhQRdsyy+3SG2+zK8olYUvwKywIYV21eZf4Hs9jrXYN0hxhvhuIZTgVHPPTu0uMW2Onfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCv0s/0PzmcRKtLxpRlGtLx/OM8FideWd7WIGb8Hvyo=;
 b=zGAnDlA7fwwm/WKwabdrpVVDt/vk9vAYaQHTt6BQuIkHuX/RBP8U/F8UsHr4tqiPEvnU8RXGpTzuwRrVo9i0oSQ8oyk5dJtF00Yz5UEXzkQX2bY4qeAT6hjil2+6/8VnW7FgdMtzU3Wh0K1tso7cCZ79GDSUmBpmeX4dWqFAlxo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB5848.namprd04.prod.outlook.com (2603:10b6:a03:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 08:54:07 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 08:54:07 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Wenchao Hao <haowenchao@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Thread-Topic: [PATCH] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Thread-Index: AQHZEGLKxzwmAL362kO3nq+8VWbQAA==
Date:   Thu, 15 Dec 2022 08:54:07 +0000
Message-ID: <Y5rgrhJuX6xCDEa3@x1-carbon>
References: <20221215050416.1891113-1-haowenchao@huawei.com>
In-Reply-To: <20221215050416.1891113-1-haowenchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB5848:EE_
x-ms-office365-filtering-correlation-id: 18b836fd-a919-4a1d-c78c-08dade79ed10
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrgrKxwTJVB9LwREeI93ATK8nrV6fjXnSXmUfCFpR/580hFCHEHUIcLBKoblSGmANr/8lOMi93l8xYBgxkqWI79MunGqz/ZJZH1SJyy8CbF31Gyiv5FJh2KvSeSGt0EkZqr2dB6n5UAGByUIjluzxCafT+wCN2qC7xq+4rc1tb76Q411VDsLKK/OAmt5JB41n+3XCE4Mw3Kb6ptV3ZR55g6qcllowu1+OrAYUiyurm3n5FsLAzpMbdPczmpIVJKH4UDklqxijNjkJEV/dvR3bHlMpUUNaXbWna3KFFNJcX9JF+pi2C6593cUMJNYiiRRb4zpdxYsuEc/PUEx4D8mWNqj/NR+rJ5/TAfjWimnCRw/DhuUVzscZNv7EYSi7ZuVfIh8zfrQCgHNYJJUbPRgesRegz6HoZ/XT0rBCD6+ezl1sUNkvTw4+s68bSI7n1TyP6/kOtCqlaZXRsRRkFRBquQqEegCIG+jdK1KBrIX371dPyJZUwOfXWhvgXqQWVLzt1sWW22OWOR190URpiRSCltrSRLuV62AUQBF519g0XkTsmOylBweVRHLmmtXRJIdNET7/oM3tk+mE3kDqAupq2MzKeivrINCAzJhdv23Mse2fnkYmAN1y3EkjvBfJ/m3x7reYUvt3ciFTlohnVUT1GEEU1Wu5QFP7RpfstFcUTmC3AqunChB8RCRvY5j2k5oDeIEm2bVuE9sjew6tBLhGNyFhvd1ikbMI5Q2tsi2NE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(82960400001)(86362001)(38070700005)(9686003)(122000001)(38100700002)(91956017)(316002)(8676002)(66556008)(33716001)(76116006)(4326008)(66946007)(6916009)(71200400001)(8936002)(478600001)(2906002)(41300700001)(66446008)(64756008)(66476007)(5660300002)(6512007)(6486002)(6506007)(966005)(54906003)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fnj7CQVSjljsVUDdfJnSO6z0ejgH9ZAfkK1L96ZYck5DERuvfRGV0Ar/+ROK?=
 =?us-ascii?Q?lLA6RhaYCEhP7fBzqhX/CMZVggQtgWyVjj4izFAU7YwV66aQhYhY0ovfxHAy?=
 =?us-ascii?Q?sj88svYuLNbAr+E/71haatuZknqdvVewmTvXN4nnFCy3O/woI0d61qp47Wll?=
 =?us-ascii?Q?PDseN63mXuTDdyaVvlAO1s4QxUoHQKK2cCLzFIJquHV5IANpDt3H87eEwA0U?=
 =?us-ascii?Q?DoZ1JjqQWOsOoTVBOnkAwUQ32vitt+jcbTAKYz//5ildTPLDByEQWXpTjTDm?=
 =?us-ascii?Q?ZNOiDqp3rTwKlAP+7IFA8yI+IdnKRrg8KpIgbOVOHqT0jCxHd6qJgiTakEFV?=
 =?us-ascii?Q?22QAdXwwvEJVrR9yHqN2vzkRCSec2ZyAVKwDwKRZJ+fZosBmSCrFJ8ul5mCd?=
 =?us-ascii?Q?d8Q6Jd61piMRtNmkaJNdul5ojg00J9VF6f5a1mToXghUiQGTJ/L+nZQb1ELH?=
 =?us-ascii?Q?NfL5DtOWpLcWR2kr/IJab0QictVUWHOZPJcLggqjQt2wSgN8Bum1SnvcBK0C?=
 =?us-ascii?Q?1DZ6MMcHySrpiTsEgt2wsw6qQ/cfftKE6o5XXTctX40Ka9Q6+GKkT+zGAvyA?=
 =?us-ascii?Q?VGuNGXauRYwYB4ZKLJXhw0ayQdtbVz9DzwPLibXKxzybEKnQhMhKxP61Ia34?=
 =?us-ascii?Q?XLjlp8BInWt/fyJrMw7DQ4qZfpYEeyjLP3aBUnuzwXD8gt8QvojX5olMDSsC?=
 =?us-ascii?Q?qCIoZmsqQ+RL4sk71bU1+oe9N9RoxSWlOLtX3uJxl8K3DX03gNj4bL++UHFY?=
 =?us-ascii?Q?YM4VAJe54aC8IA49kqyY2iGxR6ZTM/WchFAVe6B8O6Ajq7USfzqozhW2sdrE?=
 =?us-ascii?Q?UOg1nIxcEOtFF6hG7v3Jv8ihMymogdHrDoTr9SYPauWFUlRrl86cPvVNzeAQ?=
 =?us-ascii?Q?xDTWncbSrYzxEeAJt/HIKLrmfDyvZ2hG1pueXnqsuVPR8zFjRgy0lzLR+PzF?=
 =?us-ascii?Q?4hmcpOUmZKZLCfwCU+54S1zLKG0z5PyhAmC8pPnOA10Q5PoAgz4+cBd/SgN+?=
 =?us-ascii?Q?21qkx9fLNidUzqIq2Qm397UJb+OwQMEKpJAUH1X0uyrJmQgFFGoIqq0hboEO?=
 =?us-ascii?Q?8gXS0xLb3rw0CAEvNBOSB6S4x0oqbKaw1wu5hMhh4pDz5j1CpSUSHk6aUc3H?=
 =?us-ascii?Q?eC0hxf6ps97xXR1a5wT4dqyWmIAXIeg/sFtDAkg/BhAc+rnnAL3OROkhyFa1?=
 =?us-ascii?Q?gbDM/DjZ3PC/ninA5mA8PEF0nWfskU9GS4Zjt2lUgUsuqs7I1qCKw4tQ04t/?=
 =?us-ascii?Q?b0Ge/tyrX7vTkNHn1/vBkGC/Qs+a43lpLlukKolXxbTVxLoTwQZHjrlyBh2T?=
 =?us-ascii?Q?8dmjdCrKM/ErKtKORO8qIangT2F4relCIbghKF7sF8cIxENCP/q+GBakPss5?=
 =?us-ascii?Q?geB8hYLZqhqwlD6CO/58g75Zgu300JlPQJ2OeYgP8eTfrIA7ydzpJeSZJGSe?=
 =?us-ascii?Q?tLlvSzxk/bgNJHeBInbk9VKhcJrOL84h9wq58cV7/mVp54xnhIEjo0jEDajz?=
 =?us-ascii?Q?9loQvkLA84CaSgQy86H0Et7gEusRsbUB7xaEC2TRzngFky7PXSXmDE74C89y?=
 =?us-ascii?Q?dKhsMLlWagyzxFJE4I/t269ai+Upj0q3ETm0Cvei284ZPOTpDi/AYVCZ7/oT?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFCB4A0900E0E042945B5546A62B6588@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b836fd-a919-4a1d-c78c-08dade79ed10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 08:54:07.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wifEh/kGRHC98rRumHUl89WQf6uksP2XAXl80VGu9pUJRPKbgVyltxp28V9j0yaEn5pVH+fK8oj0dZz8zx9LUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5848
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 01:04:16PM +0800, Wenchao Hao wrote:
> If ap->ops->error_handler is NULL, just go out and release the
> spinlock. This patch is just a cleanup, which would not change
> the origin error handle logic.
>=20
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce67c14..66ca3ac7cd58 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -565,6 +565,8 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *hos=
t, struct ata_port *ap,
>  {
>  	int i;
>  	unsigned long flags;
> +	struct scsi_cmnd *scmd, *tmp;
> +	int nr_timedout =3D 0;
> =20
>  	/* make sure sff pio task is not running */
>  	ata_sff_flush_pio_task(ap);
> @@ -584,62 +586,60 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *h=
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
> -
> -		   We then fall into the error recovery code which will treat
> -		   this as if normal completion won the race */
> +	if (!ap->ops->error_handler)
> +		goto out;

Nice cleanup!

However, I don't think there is any point in taking the spin lock if there =
is
no error_handler.

So I think that you can do similar to the skip_eh label in ata_port_detach(=
):
https://github.com/torvalds/linux/blob/master/drivers/ata/libata-core.c#L59=
04


Kind regards,
Niklas

> =20
> -		if (ap->ops->lost_interrupt)
> -			ap->ops->lost_interrupt(ap);
> +	/* This must occur under the ap->lock as we don't want
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
> +	/* If we have timed out qcs.  They belong to EH from
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
> +out:
>  	spin_unlock_irqrestore(ap->lock, flags);
> =20
>  }
> --=20
> 2.32.0
> =
