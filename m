Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30966210EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKHMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiKHMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:37:36 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC450F24;
        Tue,  8 Nov 2022 04:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667911055; x=1699447055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9qRbp1iGT2x1Nt6KNYR5tuKauk+CJClfo9ECPQFXtSw=;
  b=MaSpkBG923n31J2+MFSV3SKvmn9sxF5estzBxhHmHWTsWaUXIUOuESR+
   +EujzeNcnyTXMN3tZhwvQve+XV2RbdBsPTbws1ZyRhBS86qhWTa7FDHci
   SH9/5BXTm2OM7Ew6aJv1CkuQUvXSPL8XMR9HDvfGwlJFlOzXH/6CKRWf4
   HxfkJmONwINIaHwfyBgyXXPXXocM36dU8mBpFaaDrxauMWew7HJeuaVtU
   pBLeJAu2T0/KLu7nyxNw2MhSrRX1SQZ5HcvKzTct/jhrNAad/lqLgdqJR
   y7pdv+d0vYFwwAtGvgIdlqij/H8OJsuUFDbQMwrU5TOICTc4b2g6UfGf8
   w==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="215757204"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 20:37:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf3ucXGfPGc+2SdFH8QnOySNW5pVY1hKxAU20OQJPF232ROIu6cvYVLEvqqA9WegAx7zp7DOzmmm6wPC9lOwBGO6KdTc9CSDyQQ4Ct8FkSN6lmcKmSP7Zykd/KmZnv8+twC9IBWC0KOLtrlqh4n5POqQwfNtaTL4uJlAv/u85kGvJWCjHEYeWe84hfaTMOWNhgdgtQLD03KjlxjDDm8OX/URv0Au1RVFJh6ohsviai6DgMWcQ2nndJsEiQFWJjGTnYZPn68iv/v+ty/+0+I+vGGV8PRL2myAu+Zo+aud1VAyIjIUwozTYqxFa7zRurMPeo4tZhydsBsNUG4+Xx+/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT3ndxGikKgbCdB08+QU9cC8xzjbEDb6TJL0BUZiik0=;
 b=HPIL/Gx8FbP+OQFGSjcNQQbwh8RIwtRV5CO+eqGXtAfFvWqmqfDodN0bAvTXvlySAaiANmBQdu2FrkOI7C5vEqOAjG/dSl2zien3OEd4GjIzWZ5TPF9z6nsYDcLs1BWfy0s9sWvOHThvPB2dFiG2/eBvwKSRlCk0uA8Q9LkudiA8iid1H9VxAxaCvedG3l6c73C+wBz+VZ/72hfdAu6SgSv/NxArztI9mTHQpCyMIhPwHRLDAr6GrrAvi4HKxqlopn/HcJpWf2dy8nrqHKThfld4ySyEfJswdG0KgBZ2PK0D2NL+6Qnv3jsotIY8ZrMs1BGP+OPKBK78RT035kQ/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT3ndxGikKgbCdB08+QU9cC8xzjbEDb6TJL0BUZiik0=;
 b=XpTn1QVLRTWmvxjY9AW8iUp/zH5BbxK+ftq0lXWmsf+Sub0e5l2/zw3xqaFuEjYIZFFbfolGPZ4eOCBqPLE+QMM+ASacFd7JSMlbFkb7TWYVrd19nZEDouyxKq03g45PYJQgdAykoA6noO73H2+gD8yiHrBf1Cf45dfY/Gf2YvE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB5906.namprd04.prod.outlook.com (2603:10b6:408:a7::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.24; Tue, 8 Nov 2022 12:37:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 12:37:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 0/2] UFS Advanced RPMB
Thread-Topic: [RFC PATCH v1 0/2] UFS Advanced RPMB
Thread-Index: AQHY8qpuI/QP6FW+6keQsjCzPOix+q4099XQ
Date:   Tue, 8 Nov 2022 12:37:31 +0000
Message-ID: <DM6PR04MB6575D9DA640DE6BD0313758DFC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
In-Reply-To: <20221107131038.201724-1-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB5906:EE_
x-ms-office365-filtering-correlation-id: 032db309-a53e-4c8e-8577-08dac186014e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ec4bHS5QGyqnRu+z9z+9AKSa02/dNPQGHnQelAhSDogcLY58zQX2f8a0c6eCZMXwTtvE889Nj85LZFHdpgz6nTOE/hG+SvieVpiTAmpCoa9PGoJOlOz8b+l+vxGGsUp4l4qLfpsghPjFNVpAmiQZqisaRqg/HIo39XqG6ktOGXhTP/esmKVXtU5NTLGMtMlQSsUzfM/xQfzi6j8IgBaBTQ2NBagXwokm7TTkkuisUWFtQDYtNTkJzfUYla4yD5YoN1ipZbgspX3aIQ6btrVQq4LNr1UgkJCiPUuqCfDOf2bnATINGCHmZy5Bd5QoiTUlbrP3WJmfqrD7m+UYVPtNr3DxCwAETmHT0Jvgch7MBrPFIdlZMcvXwfEKgB2uTfaaIkL7H5shfF2qMLWO/mdJZ11uyb0jQPNEqiL6XKFH6GuvebG8tDVcP/j7owDTLYsLUPlPyGZE2udv5yXiE7bEtIZRhahS3lroZQ3F0OR40lg1UQzMWyeoRT1FsQVbw457qHxVVnme+lmx8+z483neERYK+lP7oOIkjj7Qf5T+D078c/3kxTBooBRUTHcalIcPuc3e6xFnyYNCjng5FiFOyKN4Hnyroh5ZpsXvzC75bTG0HjQqn6UbYb9c4fsV3J2Ce2IcMzsU6OmSfdkQ8ZUL5GfrJCfz9/CjCMx5md9Q0OqPwtdfP5pgJDrszDpJvjUvKmSgfVzMnslBSOmeevtuK3If873qYoiyushLb4kKcsGwBkVgcfGhJMpHs2Ij8zhdEEnruowsCY/HK4CHowDCwK+cutRmGE970dMk4GOypio=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(110136005)(54906003)(8676002)(41300700001)(66946007)(52536014)(4326008)(316002)(8936002)(5660300002)(64756008)(66446008)(7416002)(66476007)(66899015)(76116006)(55016003)(82960400001)(38100700002)(478600001)(2906002)(86362001)(6506007)(7696005)(26005)(71200400001)(9686003)(83380400001)(186003)(33656002)(122000001)(38070700005)(921005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5gEkmQxZXyrxYA1XvIQ7AuD+2yINejSvgfOcSmxYSAwVNHnZQuLAOESTXjd?=
 =?us-ascii?Q?yIi/OQ/GNRBiI4ahZ5UUUWa+prj+PCOM29oO1hZ+uGqphWlduihsbXyk6wOr?=
 =?us-ascii?Q?vCEo23dK2bVV3mVvvovQ3757ZpqfO7gRUntck7KAwFhxKOPKualXSy7InOq1?=
 =?us-ascii?Q?PVJhVIYA7gKRd1t2Rp546NBXCYtVYQphmpIaxCyy9tB1jFu7rX6RofE0XTBj?=
 =?us-ascii?Q?ZnOkqgUW9WTSlC51f5XnMqGDnE5glcFHjuasR+07a95z6JXLSUvc7Gf4+H0A?=
 =?us-ascii?Q?cedvWIWQErP9g0ahMXhXlbrhOOolkK0GAr8VPuuNv+U6CdmGqvEST+j7E9F6?=
 =?us-ascii?Q?RlCOtVpyI5mfV+tnC5p/7KgCUurMZAn+8n/gG3FlANuLqPiJM8iBy2QP97Ip?=
 =?us-ascii?Q?xladHeduPkrkz4d7BW12Yr2hoWno3AOUJqQICtlKdlGxmSVORaKTxq0IuSRy?=
 =?us-ascii?Q?gHZhQ2hZgdb7vkqp3Olbz9oSFJgU9bDlPh7J7tWS1VWwjbWeBOi3+DjV8pBX?=
 =?us-ascii?Q?qcGni4PNYe3wVutDMH+hcBrm6H79VgmW/zSo2YpXiUWvzeJW2N3Fl0T0NjNO?=
 =?us-ascii?Q?YNEGyArvwTPqIe7pP69O3rGMhEhvswkGwHnLKnM+Jk8VOKmcKZYMcgmy5Qab?=
 =?us-ascii?Q?vYKJ6/b3qorx7+12kmYBFTNuu9ssr94Bk2sREuWGbC1jo8OFerZd0DazvSSA?=
 =?us-ascii?Q?rb/eJQO1CKOrgoPQinlhaCqywbVrPWzGvddL6nHSXhbWac9tj2cW4O/+9Sdf?=
 =?us-ascii?Q?FgpHUvpoIi7rSpgN1Rldtay2l6jQqWF4/GnxoHgRjYC6xe/znzlpVZnHeT54?=
 =?us-ascii?Q?ydEg+BIuRrUBf5yY6UUDrE9Wn2Izun6nC9w8TSPhzC6vurICFDVykuVYX/VD?=
 =?us-ascii?Q?qcWaCn8E2DIDlvU4y3AY2ZsT4SNLs55G6jtBrzRby5YTmH0OXiDzAbTFXB+L?=
 =?us-ascii?Q?xfPjY5Xhx3El8ss3IOxIXH4ZpYP/B1SuW98JTN8tzdvJTCQ3CltVrIP5BCx8?=
 =?us-ascii?Q?FEPvC5Ef6iuqlVekmCQtT0KaaquFeqv38KS+EAdWP3n8LKL41xaUQtHajX8j?=
 =?us-ascii?Q?O1jj5WbZXDqKpEm6L6zI6yJBNjj7eBU/8znVNZdBk/NineoEqJf1SPP0CnNL?=
 =?us-ascii?Q?A0aJhNlqfAL/9b9QwviqAORGBZjICQ2gBO0ZsBDJRcus+4Icc2VJfT1wJmi+?=
 =?us-ascii?Q?rNNgy7+f+oLo9eMi8jjz0mqz2rDVeTXjJhjtL6nsGjElqE7+ue7TOfsLLJO+?=
 =?us-ascii?Q?WWsqCnLpg+mPEaK8S+y+07wjtEvOW5uzaSkgqkCpNG+AnchoGz+HUxwVh6/y?=
 =?us-ascii?Q?gEOwPSvFuf695Zji1wJRfhBCW2ocs/EkEdndmqBevSDK7fzO1dVzL3MKVvoB?=
 =?us-ascii?Q?z4V/wkwCgNth+dknqjQf7AA6wdPutIZt1H9+SEJOWDdcmPkDBf3wyNwy8YwI?=
 =?us-ascii?Q?PFM2Dg8T962+0E+Kw9VWtnHU9ISLolRPhyysKCKepTs28wfmX1hnGMnSHALu?=
 =?us-ascii?Q?WuwEyiWHolxfaa1A27ptYBAb7/d+HyYFoB8KTXa5q026oCBpduByrL5r8o/K?=
 =?us-ascii?Q?ydvzd2S/Y1I1hQeyEHcOvWnadXHhnvCFm74SVRjq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032db309-a53e-4c8e-8577-08dac186014e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 12:37:31.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IH7ssQzPV5KaevfOx5+ixMvMuxr2PEuCYZWxqepTVTU7kVdgp8MoVXts6JqyKsHsbC1HHCEPeYm2Eg6MSHS+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5906
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> In UFS 4.0, it introduced advanced RPMB, which can significantly improve
> RPMB's command performance, enhancing its atomic operation. We don't
> know which implementation will please everyone, mark this advanced RPMB
> patch as RFC. Any suggestions to make the patch a master patch are welcom=
e.
>=20
> Based on suggestions and feedback from Hannes Reinecke and Bart, we can
> use job_bsg->request and job_bsg->reply to pass EHS packets without chang=
ing
> the BSG V4 structure and BSG core.
Can you share the reference to this mail thread, or was it a privet discuss=
ion?

Thanks,
Avri

>So we push RFC patch just to start
> Advanced RPMB mainlining
>=20
> Bean Huo (2):
>   ufs: core: Advanced RPMB detection
>   ufs: core: Add advanced RPMB support in ufs_bsg
>=20
>  drivers/ufs/core/ufs_bsg.c       | 115 +++++++++++++---------
>  drivers/ufs/core/ufshcd.c        | 161 ++++++++++++++++++++++++-------
>  include/uapi/scsi/scsi_bsg_ufs.h |  30 +++++-
>  include/ufs/ufs.h                |   3 +
>  include/ufs/ufshcd.h             |   5 +
>  5 files changed, 233 insertions(+), 81 deletions(-)
>=20
> --
> 2.25.1

