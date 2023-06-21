Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E3738953
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjFUPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjFUPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:33:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8AC2;
        Wed, 21 Jun 2023 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687361621; x=1718897621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gV6PtmK82pRwVQZJ+gutzLK2RDhk22zBWBz2KiYPHCw=;
  b=D43lxiyXyAmdhpZqY08KlqpVStv7XTxwlnxtsH7Ccek4gtuUhzKU6itM
   Jm5QeeaToE7w6jg7QPs8xJP/PGfL5wHzHDwgvUTbLuKhN+6pkBqUugl14
   rvcxXxi1oBiSxLdCS73BlM0D9LCLWydhGhlh0FCBCEUH3VseTHxtrsFdk
   vcuFtZRq9dJXuoB1zR8h9540CyeCgev67GW6gsn8Vo7du3N9F2eGSCL19
   FZxFWaUFweKctqNk+lb4UhfQTNF/7qh9pFrb4enddAD7qjgqn7OhKMX/0
   nNYXVZAbbvMHqLQrxUINdqBV4KieJi9cAf6IFUV7TzoHzkxvo4bU9eZbQ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,260,1681142400"; 
   d="scan'208";a="234623277"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2023 23:33:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4ImzKEuMPfUgM6DGjFTIiGP0EwA8S3a62DGA5buDUwOjgmJsJVqZVVE+F3AaHPZVB9Myvfu8ukDkQ80wdlNcoUPq2K7HqtSvaH5QDIcW4obPwnRoNRTSBXk+tYjSH3hO50+8EE15hl/Hftrx3cnskgpLbDJuR1n36OIkYFcv1RnqAcBvCRXVpYC/PuBHHoVtvID3w1RVuW3yJsXNdqLvdeEANP98ekyGyUFdQUKhSsuhuFALQUKJ9nsRWjy7fBDu8O4uzxfrKti0qWWjexxpxfF8aCphAhEpLXI39DET6e4W9Q73MpVn9jOMuMgo4wIQte9c98WtAfv1A89DAkDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4PCrD06tgjV+A0iWOAOBR+AEohTCQ06pes/rFm/WXU=;
 b=fI+OQKPa4R8waQS3JpIIkgIZeVDgG3tHRgAGnQAtySPuk1TbSaLNXByFeNOFMAd7kz2fbOMYg1jXmFwPHdQQrQ0nAzGLVv1MVDIsfNgk1fnK3gkKSI1JpPeOIzrfB7JQIWtz+Up0V2UC9j99yYNJUuC3fjDAfHrowZdNcMv04Gnhx9cd88/6QmHJs2cA6dSsNC6S4lS+yrg1ZFm679WGqX5XocEQkXSeIqr6zmnEhEmPf44dMRUXPQEmkz7l/mLVlbJRjymX8KgV+byHs7BgaJmLWyodaHlQRQ+wSk1rCOGWh0jci3DuvRA0W3IxZyPeTIdVLUUwYteHBuD6DbP8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4PCrD06tgjV+A0iWOAOBR+AEohTCQ06pes/rFm/WXU=;
 b=m3IOOHRQsBhIenrPUPlDU0YgciUFtdMKRD0qpAGChwWgilwzbGLajeLTEAmxaU0Co4/pSar5RWeyOjGicAP6rVUnrHIYSiAT9mngAXIzZUiABh5JElk2GBzPLnso7lqIsUmVcNmORq8fKRtbY83EFCyUuGitO3ufTSBdwbXgY7A=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:33:22 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:33:22 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Cyril Hrubis <chrubis@suse.cz>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
Thread-Topic: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
Thread-Index: AQHZo0rVSYCnsI/WrEamCoCQtkxA3a+VNo6AgAAuRYA=
Date:   Wed, 21 Jun 2023 15:33:22 +0000
Message-ID: <ZJMYP/CCVviG6IMq@x1-carbon>
References: <202306192248.1ece4c29-oliver.sang@intel.com>
 <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org> <ZJLxbwCno-it2xBB@yuki>
In-Reply-To: <ZJLxbwCno-it2xBB@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB6575:EE_
x-ms-office365-filtering-correlation-id: 29b72973-d9ff-402c-f9e9-08db726cd8dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSLd3d62OnShZZoFPUZFF/9GH+lt5Z1R45RH4YfaKKmecLYXJM7IqgNIsyk2a0UHjW6Sl7SzfU0UDTVP9hO9Thls9bHbc5TWky4PZt2L2WPKuxcvesPVd0QX49quIZuznOe+QyleDZUmPM8xRuSCHf5ziETHRVVlS/7wW8+BBRyxxpLut7qIs5U2R8olWRrlYbydZGJenrXOi5tWaptS+o7HGhhh8prYbqOFurgZjFJN57CpL37DvjfyeoBdeh9ICrgz/eYEnf2ohuTIB7fYgtmucwiBFdc60k8Lc3sZnxR06spZh9v/uJhEBeJqnRTBglfd47giw6Eb39IDdyBNHfUPABmO8fSeb/k4PeqIxXDvyK4fd6GDzZ/RwAg1l4qmOlXMsXi/E+C/T8M46UM7QsC4ujIrJaXn8XWCPkv5twQnHaKYpF/RxX40JcwjmCtRrbNQ9YBivak4tjIkTAeRSHahBoSyw9OL+1CDqcr8m93KOY6wHEYwC0QfXP/A/G+Ms7ZLXfZKOX+Rg1qHuoJ//hnUn7sNrj27O2Q9OIeqeWOuhXq7osemEiglJowKHyBSfI1vB1wAzgLUSb95RCCW32ZBC61oCuCiM59iUDgY5vJc7HN/1JjgCsgduczGPPn7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(6486002)(33716001)(8936002)(8676002)(41300700001)(316002)(66446008)(64756008)(66556008)(66476007)(6916009)(2906002)(7416002)(38100700002)(82960400001)(83380400001)(6512007)(26005)(478600001)(71200400001)(54906003)(4326008)(76116006)(91956017)(38070700005)(86362001)(66946007)(5660300002)(122000001)(9686003)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tjlZ5HRlXMe/8JXTA4LupjSrLA5ajRgsMlW25vzNWeG+rPljLaFdCZB6WVle?=
 =?us-ascii?Q?piVUA6bcpXYnGZ1gle4B4GW/NxVIukh+wL9E/d2Pd4p/6h/icriXReJHb/FT?=
 =?us-ascii?Q?XNq+noywjFAJsvS/ksoBdMOEqOwfXWI3m8B6FfPNmFM2q/y1FXN7AGWTlceS?=
 =?us-ascii?Q?qLpNdHCijctywGAhfYRfM3AWiryeEXi94SIEe1m6taBB7artt1D7M+jWXqsH?=
 =?us-ascii?Q?xo0qiknmd7EeewbJYZUAGY4Vt5RKfcZzVRCQxJA5P38AjgpTnLFHlh+v7kKm?=
 =?us-ascii?Q?AivomDmOYsZhtQ6coBtT9Uy/2NQ4vJEy2aAyp5FXq+2GwFEhkQnizlD3tdiF?=
 =?us-ascii?Q?VaxY1YxfD9MGN5U/YgvWhBtuvqzVQjABN0aOslSjDXmJhmjAAcd2Vdz7NWYl?=
 =?us-ascii?Q?FkUZ/WnH5GWQOcPuzMboA5eQUnXPspZZsHNiMCxf5/YYkzwI9zki3wHBQqbb?=
 =?us-ascii?Q?4X0UCosydW+7UYA4LdTXWoLeytR57rJYWXDgIhwRituQHq32PQPGWrx3Sk95?=
 =?us-ascii?Q?Uz4hsvPOWkYzGUpQEIn2VG3oWE/6RRrovg4n8fYSIqsU3//2cJVXlsJb6FR7?=
 =?us-ascii?Q?V3whRW/FzNEoCEw4Dodak0iQ/02JPxJCsg7X79l64dA0wO7qiWrjdZK5eq88?=
 =?us-ascii?Q?rxEGapSfX7W4hJkHW0hW9QB88gkCWlxO80cB0dO1hO3xpD2qZ2fS8pFPb1Z8?=
 =?us-ascii?Q?G5FhEmjOKFGO2Wy/pcUDXNLLgMK5yRift/NCpw7owx/dgEx3cMKwWxZSUKBN?=
 =?us-ascii?Q?7V785uJdcEyvAyx85S+Sl1lr+NTZF34rnst/mE1OkkQbBYcqgPbc4xTFnfWo?=
 =?us-ascii?Q?BLbyP08fnHAs8x+mkU1jkqSRlBnPzKZhYnZVCKzhj+mXE8dkiUM5bEyLosIz?=
 =?us-ascii?Q?x7IlLVwcTMJrGZvcwxdwnExsCsWoqfghETnTNEJ7RTd8FuXHxlH+Ua9La8ue?=
 =?us-ascii?Q?pbA1hW0ZfJTzAw9IlLgEUWrONXn0+ZcPXsmEJmyTrms+QYBTN/Dgv/tugLC4?=
 =?us-ascii?Q?lzRhRwm6/UD9gHPv1k72PPfaRKlRLM7bSGMkiMqbegbChqECGtwAPTep1CJd?=
 =?us-ascii?Q?tUfzMxclNZlFPigISVZ5C+cxb8MTgQzkgtyeFRwT/lvRr4xaN2x6a2UQnxcp?=
 =?us-ascii?Q?b/dY0V72ncnkhgfAu2ARzG8+McuLnLsLyCVes2WY3RRQoTrMAXEWY9ViQcg5?=
 =?us-ascii?Q?WGGP5oO795SCKX1d+4ZF6lyDF18POCjfyoWQK4fuy0j+b6iNotnamiHJ3K54?=
 =?us-ascii?Q?Ms3334RPaa+FsOOLqKI+E4SDPg6YOs/OTADPM1y0QIP+lpOrvhIm8lx8ULvd?=
 =?us-ascii?Q?jwi4IDsNMvYIjUJPwCzYnZtOl6zw5hoLPyY7ZBVN0NJqSi66OtaSnDilHya1?=
 =?us-ascii?Q?JsVnOFtEdUBcD/8sVSz53dtihOdtfsVr97wXzxYloW0pIP/bXJyprAEazkKp?=
 =?us-ascii?Q?HtLLTCWSXQMjq8V+bfQqitWrUgOrbD54wGHmYIOXyt+xUAIK0yuCYQlNmaUJ?=
 =?us-ascii?Q?DZ/Qk+faaYuqUbBfHSH9KugaSmZ8v0DBK5xt1oneyP/bLS3ysXowsmslyDyD?=
 =?us-ascii?Q?5P8WCz1jzTpEAvjAAc4mnEwG8XmGGXbSn7jG+dp+g7bAvj6afT3IoQAWRySc?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2200FC3DDAEBA40B83F1C6B6392D27B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1QTrbmwGnngZmr/Hj3OnkX41+s6xfoCJCLt41PMNj4xjM2eagR62Jdk2quSr?=
 =?us-ascii?Q?KR5DEra3XY1jaXRdXVGLSATQSWcFETwFaxieJ0lvW22vyjAJgnbAUR1tbAmM?=
 =?us-ascii?Q?HEHB8dGAe5cVawzEeTRLBDpWfRVIvezimE2U7EacySLpTapfJRawgFkLYVlA?=
 =?us-ascii?Q?HaABRGvmKasM5xn2RHuWYFun3R8LkIjvXBR9xZDGDKPoYprlg7MUNSmWcGRr?=
 =?us-ascii?Q?h+1KHIp5PPdq8LqMQFI1IIAQDnSBpGlkrE21AZ9mlL1GzaN9GCEo5pPmtmQ8?=
 =?us-ascii?Q?Nqc3LvQ/V8fO6tSAXM3fvZIzByxSP/e1UFwanLd4OPguXv3Nt33+WNE5mczy?=
 =?us-ascii?Q?U63bDcjKSq235TZ5f53q+FFqrMj5xpQ+YXB8DgWD0b6P3e8mDWCU8Ur/L3o7?=
 =?us-ascii?Q?3WLQq51ptMh28OP30t6HGYOG7QHH0DMmRw9qT3f4cYttYTNFK+Fn5DVwSahI?=
 =?us-ascii?Q?/cTiNcjbAUoDP9+eQBxtID7CyDh2PiIVTclix4r18eE6tiqdjZyf6cnNjBsT?=
 =?us-ascii?Q?AGFPueKvSpftpXzQlpnpgKL0y6ZAtleZDI89bavxi1DlQYZ3g48rYG8YM4BF?=
 =?us-ascii?Q?z1HgrQtRq/AaHuwMLVUm/xIZPK1VDMRT5lSASMmJYKL0pdVHi+OPzd58g3bA?=
 =?us-ascii?Q?B+ejxXZXJyvdp0+sCu5Nkm1PKPCplRzLh/Ztw+a0YkqsQVwFMOrAZ9QfzUGJ?=
 =?us-ascii?Q?hZcmX5bkXgJRHYE0cDbCALgq+JxLugt/sLvKPshL2owjM3lIMTeery5oJgv/?=
 =?us-ascii?Q?kdmbBpkR7896VghO2K14zfPK0VW3WcqPryC7hGJI3Yr+yirP01aTqOb+AY0n?=
 =?us-ascii?Q?foKzlCdL3kH/VRBfCSj7xFgjQ3SagbRjTvaBys5fieIambpe3EIqNAFfxi2+?=
 =?us-ascii?Q?CV2H/JY8zbFDCjbCW1vupJnxc9Vj8pMNZ/wSXkYucF7z66SGeKpv0t82bocR?=
 =?us-ascii?Q?v8GM/8gyrot3sTBdEXQ22V6cx09t2texoWlp3p8cYMd+5hZFq3pmn6Yh5SrV?=
 =?us-ascii?Q?c379NdfDwwS+3RwYapufc1iLAnRBTgpEDtF+lRxvqmAj0xw=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b72973-d9ff-402c-f9e9-08db726cd8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 15:33:22.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMBuOluAnBww2tUUvJT1kKC14izAk604N3RCiQMfsWXbOOHOub1T7KaXWv+ee8RztWmitg4dVWHHkkoK00MItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6575
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:47:43PM +0200, Cyril Hrubis wrote:
> Hi!
> > > kernel test robot noticed "ltp.ioprio_set03.fail" on:
> >=20
> > LTP maintainers,
> >=20
> > Patches have been submitted to fix this issue. Were these patches appli=
ed ?
>=20
> Looks like they are in, at least these two:
>=20
>     ioprio: use ioprio.h kernel header if it exists
>     ioprio: Use IOPRIO_PRIO_NUM to check prio range
>=20
> And there does not seem to be anything ioprio related haning in the LTP
> patchwork.

Hello Cyril, Petr, Damien,


I just ran LTP master + linux-next and the test case passes for me.


Although, note that even if you are using LTP master,
the way that the LTP header:
testcases/kernel/syscalls/ioprio/ioprio.h
is written, you will need to run

make headers_install
with linux-next kernel source,

before running
make autotools && ./configure
in LTP.

Otherwise LTP will use the kernel uapi headers from your distro,
which does not perform the new checks for the IOPRIO_PRIO_VALUE()
macro. (It requires linux uapi headers from linux-next.)



Does the linux kernel test robot not run
make headers_install
before running
make autotools && ./configure
in LTP?

One option, although I'm not sure if we want this,
is to change
testcases/kernel/syscalls/ioprio/ioprio.h
to do something like:

#ifndef IOPRIO_BAD_VALUE
# define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >=3D (max))
#endif

such that LTP does not need to be compiled against the kernel uapi
headers that match the running kernel.

But... shouldn't the installed uapi headers match the running kernel?


Kind regards,
Niklas=
