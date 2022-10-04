Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDA5F43E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJDNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJDNFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:05:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199C165B8;
        Tue,  4 Oct 2022 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664888752; x=1696424752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F0q0Kc886hlSSCXmA6cmiFYYo37ZvKjl+QUWImHxJX8=;
  b=XyIX0y1q+z/ik/wVFqK3rRLRnQfHNqOJjABszr1/Cht6EPZsfFOGEX8O
   7SJhaF4rwSv7x5z8Vw2z/nYV5WZJjisSHTXRMMmnbRL3K/rvITL6RKi5X
   Nh75ds14zt3f1pAvl4Nv14c2fi+yfLLqfD8lMm0FBpq0PaR7HGUVh2Xib
   dj0DoojPyvAuilsUckeghOWhvWSlmEfJLlFe1IAW/kVlEWjorCDd7NgF9
   q7Pyy+PelA/xuxqBMSna7ntE+I2rYymgbwkGirezYU2moZ1ii5K6sTbrJ
   iCG6udxmmMqZzeMVkFl+IWCZfxSwDWses1vWGipIbhqdjODLSzgSi9Jk2
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,157,1661788800"; 
   d="scan'208";a="212951865"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 21:05:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6NkcthtHii6DUgCVP/4kjBs/4aFbmlCweuOWv28VQNbwPNzhXUGaQC+tVg6Jh5vy16r7Hl9t2HWU3gSMTfm4wDFlgqNl78FrY7mR8Q9EbCx7F8Nh33QMd8ah4cBNYxRlQJCMTR+/6UTUHf8bUK4uv7DbtJDbIt/PlaiQFgEX5oAaIXG5uoCkqcrs+2GxWeEyPDxrVQ06NbYkQAA+HHZBg2ZjjeUHkw0JSSb3uBeEnK4pWK5XAQRmUNgBWvAl0h25Zvlly6DMbtQ/A65SSpzOAKnG5dDVJBB/MWhwDRbYAfuxaQw6DjG9+veRT43sEMeBqnofHW4w7aVVYP0hVdkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a76/f4GMzvXzDCaEiA+MLPY7jRM7Q4i0nh4NXOdEFsQ=;
 b=b09WfHco9wUU+zUmcko3NNvfFdrDioSiZnD/QUvyX4ktFIs+6h9JrGuRWkbUXTPyUueRHlgc9pJHbtURpna2IviTLgHKTrnhyDCy0g5mhHr3CZS0EkZT8QB160p3yIYlvwoi4rHQpP5GKdI9l/wBEmfBo4I1a7LbB5E08xOy3qpalSkg0409jPnvFTzf3m4bx1O8+9pTjEtvtgSfBX0Suog5Qf9yEUToPmg2XPPBA0HF0j5JcNeD85CR2xjphZKZfVWPxTbQ4vLpjfSA2BOMKuvfV5ddISIZpK0Bw37naoMOjwPE3LdJKsrPrytQ30wb+H9zuLO2TGIRq66UMlJTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a76/f4GMzvXzDCaEiA+MLPY7jRM7Q4i0nh4NXOdEFsQ=;
 b=Z1dW+6j6O8WVUStXJxVNO/R6iTL8MmYdfaUuhEnh3tafCesh+1nwsUNVQJBYsGTGbiJVD3E0ptUVu8XX1AodD+Om7Cg3VJiQUh1v0keEllbVIo7V1Po3RZqjSpcL2l5nYW0bo5zKZ6tFnL7InyLlgC8Z3Pgcq9qAi+Jjsh861Jo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7073.namprd04.prod.outlook.com (2603:10b6:a03:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 13:05:45 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 13:05:44 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangxingui@huawei.com" <yangxingui@huawei.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Topic: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Index: AQHY1/ID0O3xyFitDU+9c+6EHqQqRQ==
Date:   Tue, 4 Oct 2022 13:05:44 +0000
Message-ID: <YzwvpUUftX6Ziurt@x1-carbon>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7073:EE_
x-ms-office365-filtering-correlation-id: 0c6556d3-1eff-460b-2ab0-08daa60925af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bpdzrz++14xqvXCnd4j4n6TIC0nJQxE9/6nvmmreOXIAoeCWx8GmyOZVwHkOppRBA9MQ8QJ52jD0gST9D/f4wBWYk405ilyWT8x6jIUTOzAQDpWVxLVrtAsqc1PM1q9SxNFnpK6WEajRD7ATZ71kG/yG6ceaq1bE3wCQorbpvxhr3Y8fFIWRPx36o3PLr6DNpTMlLdg96zLrU99WS4PgXQAiLZ+13GPZdVmPbGAuJlBfekHbARv9z+CoBbo8Q/FWkVJH/WWMu/1y02ad6BTMu8ZD1OKi8ikQZ3mqzORtpFsmGCYWyEKf8AP4a63hOlg3ObWdAUZOAU6DyDy9UEJ4EnEOX7/HqC6ZU63MyMVmlIW2TdeM1c23Yf3THTHD4Ih4W+uEt+6T8yYpftcEq1jUni2GyyETqUHYzddoWgRH6x0iBDU5YXqAcqvsntgh8K5CuwgcN8XhXsH4JI0E/9GB/KXBdcKu7CVFdjW7FbDyAumekrpjZZq7Lu9d+Mqn4GAYMzzUlCFHWIjG1hMcqv/HvjwmLaRkBGFQhRnPZBVGTPf5ijtRBx+ilrMeQlae0P0fGhCBnOQe0gB6ddn5VDm9YVRr2GKzSdViMvutLsDSGPB4vSFB3agJxyjrnjTKIAebYQ5nRRzFzRaWnMy+HS5HXwdvDWwtm+lL5hX9fACTUc8+Q+KdxozyOpWeJZqVdNdB3M7a0yhMVlTOj+fqSJtxyLliu3/jfHMLvsY9auKQDmIXXJcxt1lOoe1np7ZVIO8g1ZzYifXfIRAHqxg2ABNZGi8w6MsnTd+NDyobPQ1dK5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(6506007)(33716001)(316002)(76116006)(66946007)(4326008)(186003)(54906003)(64756008)(6916009)(6512007)(66446008)(26005)(66556008)(122000001)(38070700005)(2906002)(8936002)(5660300002)(82960400001)(38100700002)(91956017)(83380400001)(86362001)(41300700001)(66476007)(9686003)(8676002)(71200400001)(6486002)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VebapubFEOj/gwrviE9RIBBZHfjVIzoiz7CXiu2kl+vD/IkD4kexn2SN1Rt2?=
 =?us-ascii?Q?MHUBKri0KVJ79qdzFWSsZmU8MQtj1LZdJNGENg0qG4maygXzpGF1niR+dWRB?=
 =?us-ascii?Q?W3UJrW5vpC2xSJ5eirVEZqhHIp3WewGeHdHAFRTbGZfC+/q7X9iDI5BXKmht?=
 =?us-ascii?Q?+y7S1sR7haK3glcIYEMuLUGzOZ6vi/EmVLBWvKzrPqC51FbFNVdFPje6h2GE?=
 =?us-ascii?Q?7CIDGVX8Mb+DIBxqt5ji7ank0Aoz4LmQmnuu9K5z0QfDv1iSTXvR/cb0o758?=
 =?us-ascii?Q?jLx62fWREcJVpbhTg7V0kSdUBHpw+R1IeNCGEr9EsoCXd9zN8FiIInVhBR6o?=
 =?us-ascii?Q?AT6wxeegPf1PL+NekCfF6iLBdJXDkftoSgz792GC8WF3AP7pPZqnNZBXtd7O?=
 =?us-ascii?Q?pEs0xTGuaVKu0Bf4GkaUtH+6VQi8dJjaENS3MbRMffHlE1BwuYHtt1Eh0QXt?=
 =?us-ascii?Q?KGMJn2J5m0Yp+gERkJYNEmeh/VocBESP7mm6NFYgO8LxDXw7hL26RmgUx4DR?=
 =?us-ascii?Q?itp98S4Y1ndXf/eBBcVObVWoMeoT1yNhfVsxlpRx/GXn0GtWr26lY8F0I5VW?=
 =?us-ascii?Q?Q9uJKl+NfZmS5ysQ1SBMC6vg5ToSVvEDu+Xn+21x0k7P+4o3TIPsxodSLIGA?=
 =?us-ascii?Q?FCWWkiqzHjpgemKG8fwuGT3Yn15QY5onc8EQ05SEWpD4Uru5rNW/MYe2mP/K?=
 =?us-ascii?Q?W/H9f3TsUrGIjWXkC2Ry3+J9XvSgZByi8NltioF24y6Sss8xVZSOULeFfdYV?=
 =?us-ascii?Q?v9dR0ZJswlZmbvTS5zBUIgLBxdPF2LRT009mCLYJyLPD39azcF6mwTItBmUq?=
 =?us-ascii?Q?l0Z5bcHhsNPJWkr7mUW0EpoLlWyilDB4qCIpeOXlMslDPIpwc2Hsgf3IGHrp?=
 =?us-ascii?Q?w8DwTgSlyl//Bp49hAu4O6ZL+n56kROxmmapvQOwbSIE7IS05mo+8gpb4ojS?=
 =?us-ascii?Q?SL1fSZOrsjtfijPfh9GkTFqiyTxQv7Y3H1z87cS6VpJQ/kxhfAN6NVTx2bAe?=
 =?us-ascii?Q?14ZtbObwMkb50EK9J8u/amR7RvOCYnjd6ENrap7vpFosbLjK6Ag5kaMegVcK?=
 =?us-ascii?Q?vwkOxq5lWIBMumaby/FK/1oAvdSvTNG7hM7/atI3bPIgUDDNiZP3/1WrpEIx?=
 =?us-ascii?Q?OLVeyCuvd5CjEyAQrbo3AXBsztz3Krhaw0ss0s2d69xkNGtFdw0JwR+9sU0K?=
 =?us-ascii?Q?uRSOHCCfodryjgNhIUkCEAR7M1KvTXWG3uTyt+ERg9AtHjWyPF3oslKNik5R?=
 =?us-ascii?Q?Oj+CQY1HP01XRQixbvai33C7LbQtG+LL+OVOj8IFjSnNBYrkF9URqK7XvH7u?=
 =?us-ascii?Q?dxpHiBX1zouPh0lGsloo4IRvIDMkGiZ5vdfAdn718N3DafA3GuvL1k+AGEM3?=
 =?us-ascii?Q?W4I4DjQXqaztRaGH3JW7l9Wb+gOXEmvEGzlCfank1RRkSWplnmzV/eMPWclq?=
 =?us-ascii?Q?gLeazCAssOHEfaVLmcZRaDczheRwcCaBTkwqY5g6Dn3uHYVNABdMR9yXjc95?=
 =?us-ascii?Q?/X2LIgV36BFBbntutaYW2isVl2ZxmtewszholoHtsiae7Ez6ImNcPrJ1DsEI?=
 =?us-ascii?Q?HyqIjRTrs+mHOvtd9GjVdprLuiggKD92zwj4rLhXvFGRHAuPmocwIabLoq9M?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <234804A5BE7E324E9B1F34E69E78B32A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6556d3-1eff-460b-2ab0-08daa60925af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 13:05:44.3030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TpnO9b06Q1r0dEMIsyhTLwccOf4tOqtpd8p+jwoQrz3DCu51ReiU366BazCmdvw1+TKUpqbiyd3AFVZgkJSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7073
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:04:51PM +0800, John Garry wrote:
> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover, if necessary
>=20
> Indeed for the hisi_sas driver we want to add similar handling for NCQ
> errors.
>=20
> This series add a new libsas API - sas_ata_device_link_abort() - to handl=
e
> host NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it.
>=20
> A difference in the pm8001 driver NCQ error handling is that we send
> SATA_ABORT per-task prior to read log ext10, but I feel that this should
> not make a difference to the error handling.
>=20
> Damien kindly tested previous the series for pm8001, but any further pm80=
01
> testing would be appreciated as I have since tweaked pm8001 handling agai=
n.
> This is because the pm8001 driver hangs on my arm64 machine read log ext1=
0
> command.
>=20
> Finally with these changes we can make the libsas task alloc/free APIs
> private, which they should always have been.
>=20
> Based on mkp-scsi @ 6.1/scsi-staging 57569c37f0ad ("scsi: iscsi:
> iscsi_tcp: Fix null-ptr-deref while calling getpeername()")
>=20
> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a9=
78@huawei.com/
>=20
> Changes since v4:
> - Add Jason's tags (thanks)
> - Rebase
>=20
> Changes since v3:
> - Add Damien's tags (thanks)
> - Modify hisi_sas processing as follows:
>   - use sas_task_abort() for rejected IO
>   - Modify abort task processing to issue softreset in certain circumstan=
ces
> - rebase
>=20
> Changes since v2:
> - Stop sending SATA_ABORT all for pm8001 handling
> - Make "reset" optional in sas_ata_device_link_abort()
> - Drop Jack's ACK
>=20
> John Garry (5):
>   scsi: libsas: Add sas_ata_device_link_abort()
>   scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()
>   scsi: pm8001: Modify task abort handling for SATA task
>   scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
>   scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
>=20
> Xingui Yang (2):
>   scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
>   scsi: hisi_sas: Modify v3 HW SATA disk error state completion
>     processing
>=20
>  drivers/scsi/hisi_sas/hisi_sas.h       |   1 +
>  drivers/scsi/hisi_sas/hisi_sas_main.c  |  26 +++-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  53 ++++++-
>  drivers/scsi/libsas/sas_ata.c          |  12 ++
>  drivers/scsi/libsas/sas_init.c         |   3 -
>  drivers/scsi/libsas/sas_internal.h     |   4 +
>  drivers/scsi/pm8001/pm8001_hwi.c       | 186 ++++---------------------
>  drivers/scsi/pm8001/pm8001_sas.c       |   8 ++
>  drivers/scsi/pm8001/pm8001_sas.h       |   4 -
>  drivers/scsi/pm8001/pm80xx_hwi.c       | 177 +++--------------------
>  include/scsi/libsas.h                  |   4 -
>  include/scsi/sas_ata.h                 |   6 +
>  12 files changed, 143 insertions(+), 341 deletions(-)
>=20
> --=20
> 2.35.3
>=20

For pm80xx (pm8001 changes untested):
Tested-by: Niklas Cassel <niklas.cassel@wdc.com>



Notes unrelated to this patch:

Both before and after this series, this driver prints:
[  215.845053] ata21.00: exception Emask 0x0 SAct 0xfc0000 SErr 0x0 action =
0x6
[  215.852308] ata21.00: failed command: WRITE FPDMA QUEUED
[  215.857801] ata21.00: cmd 61/00:00:00:3a:d3/01:00:b3:04:00/40 tag 18 ncq=
 dma 131072 out
                        res 43/04:00:ff:3a:d3/00:00:b3:04:00/40 Emask 0x400=
 (NCQ error) <F>
[  215.874396] ata21.00: status: { DRDY SENSE ERR }
[  215.879192] ata21.00: error: { ABRT }
[  215.882997] ata21.00: failed command: WRITE FPDMA QUEUED
[  215.888479] ata21.00: cmd 61/00:00:00:3b:d3/01:00:b3:04:00/40 tag 19 ncq=
 dma 131072 out
                        res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (=
HSM violation)
[  215.904814] ata21.00: failed command: WRITE FPDMA QUEUED
[  215.910311] ata21.00: cmd 61/00:00:00:3c:d3/01:00:b3:04:00/40 tag 20 ncq=
 dma 131072 out
                        res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (=
HSM violation)
[  215.932679] ata21.00: failed command: WRITE FPDMA QUEUED
[  215.941203] ata21.00: cmd 61/00:00:00:3d:d3/01:00:b3:04:00/40 tag 21 ncq=
 dma 131072 out
                        res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (=
HSM violation)
[  215.963616] ata21.00: failed command: WRITE FPDMA QUEUED
[  215.972150] ata21.00: cmd 61/00:00:00:3e:d3/01:00:b3:04:00/40 tag 22 ncq=
 dma 131072 out
                        res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (=
HSM violation)
[  215.994532] ata21.00: failed command: WRITE FPDMA QUEUED
[  216.003124] ata21.00: cmd 61/00:00:00:3f:d3/01:00:b3:04:00/40 tag 23 ncq=
 dma 131072 out
                        res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (=
HSM violation)

HSM (Host State Machine) violation errors.

For the same SATA drive connected via AHCI this will instead give:

[ 3796.944923] ata14.00: exception Emask 0x0 SAct 0x80800003 SErr 0xc0000 a=
ction 0x0
[ 3796.959375] ata14.00: irq_stat 0x40000008
[ 3796.970140] ata14: SError: { CommWake 10B8B }
[ 3796.981231] ata14.00: failed command: WRITE FPDMA QUEUED
[ 3796.993237] ata14.00: cmd 61/00:08:00:7e:73/02:00:8e:08:00/40 tag 1 ncq =
dma 262144 out
                        res 43/04:01:00:00:00/00:00:00:00:00/40 Emask 0x1 (=
device error)
[ 3797.017984] ata14.00: status: { DRDY SENSE ERR }
[ 3797.026833] ata14.00: error: { ABRT }
[ 3797.034664] ata14.00: failed command: WRITE FPDMA QUEUED
[ 3797.043015] ata14.00: cmd 61/00:b8:00:60:73/0a:00:8e:08:00/40 tag 23 ncq=
 dma 1310720 out
                        res 43/04:00:df:67:73/00:00:8e:08:00/40 Emask 0x400=
 (NCQ error) <F>
[ 3797.065224] ata14.00: status: { DRDY SENSE ERR }
[ 3797.072914] ata14.00: error: { ABRT }
[ 3797.079598] ata14.00: failed command: WRITE FPDMA QUEUED
[ 3797.087920] ata14.00: cmd 61/00:f8:00:6a:73/0a:00:8e:08:00/40 tag 31 ncq=
 dma 1310720 out
                        res 43/04:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (=
device error)
[ 3797.109800] ata14.00: status: { DRDY SENSE ERR }
[ 3797.117451] ata14.00: error: { ABRT }

device error errors.


Except for the I/O that caused the NCQ error, the remaining outstanding I/O=
s,
regardless if they were aborted by the drive, as a side-effect of reading t=
he
NCQ error log (see 13.7.4 Queued Error Log (10h) in SATA 3.5a spec),
or if they were aborted by the host (by sas_ata_device_link_abort()),
I don't think it is correct to report these as HSM violation errors.

HSM violation errors are e.g. when you try to issue a command to a drive
that has ATA_BUSY bit set.


Kind regards,
Niklas=
