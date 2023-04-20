Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4DF6E89B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjDTFtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDTFtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:49:41 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7393AAC;
        Wed, 19 Apr 2023 22:49:40 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K5maaM012000;
        Wed, 19 Apr 2023 22:49:34 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3q2917xf04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 22:49:33 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33K5m5pE010356;
        Wed, 19 Apr 2023 22:49:33 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3q2917xeyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 22:49:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1mlt6P0b9oPLgUef1MzC1iQS+99Y/Z+f9ViGOxJCp6ojpzgYOyknJ8B9Dt+UlWpeGSjcoi8Jk4j/Ehl+eKTFOfk5QCqrgMqIRm1qytrAnixHceWjJkh7TBZYT+mVkZsm8SIcJ08d/WHQDvD1XSVj7eLeAZB9nYzg95lfZ5wPIPCjk44MZ+TuXISrMO7oTsN3QhW6I5fDGey1Bcbq05iwvYws5SXc1jLLVskcRNUyAub/p4EF8m1htTokxBir+tyfPbriRAC0WH5X8IDcvEavcQs1dsfwnACRBFA0i7Ssx1GcASCRQsri9k3xm9j4313cyZ7P+KIKjPe9XAoW65tNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MR8CWfnR38z00Eoqyu4cpAYRrErqiOkZqOU3CWJg3o=;
 b=GpGef2lVAT6BrwjMuxCgPfQ0cn1r9ceY/fQQ+fVxO2kIoOoBVib4j1tjlGdqUN2rQg2PRIs/F2ebhgH4lmmnWKGxSQ1qNQz3dq7EogUTFrUr3ZGKx+WDQHAiJWCmVjxiGabm0qjikbAhqANNManofpiobDqEosr5xzm/S37AP1Csw2qsL/uECk3jQgw64t5mJrCJ37u4jW2ZH4KecOf9FrM78MPq85bYSt96195+h/z7xTFPMaW9Ipeh6elRK9fOC8sAGsWY0OCb7hZcaGpQWmRmA7QmpXefKgMYZbOBghHQr75Aa7dQfWakwXpUTjP2wCslyEsdSORF2jKpWImymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MR8CWfnR38z00Eoqyu4cpAYRrErqiOkZqOU3CWJg3o=;
 b=GISJKQgZvlhCdPZywN9qsnx181Rz8l9TkdpJx8gDP49t9piTs1sMMnUuUpyh5oR2Gu+6s4ETRNoZZ+qAh8IPliY6ZLedTrWZ2Yegfh31pedStK2OD3mpjJDFKCfC/5xa/witoEXmQk8cpnwj6EQVIvIx36VsKtMf24mUKx0KUjY=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by DM5PR18MB1595.namprd18.prod.outlook.com (2603:10b6:3:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 05:49:30 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::8f16:bff7:799d:e8d0]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::8f16:bff7:799d:e8d0%4]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 05:49:29 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Zheng Wang <zyytlz.wz@163.com>, Nilesh Javali <njavali@marvell.com>
CC:     GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [EXT] [PATCH v2] scsi: qedi: Fix use after free bug in
 qedi_remove due to race  condition
Thread-Topic: [EXT] [PATCH v2] scsi: qedi: Fix use after free bug in
 qedi_remove due to race  condition
Thread-Index: AQHZbbjd2eaWF3ZdnUqFhm7W7Lj1qq8zvBYw
Date:   Thu, 20 Apr 2023 05:49:29 +0000
Message-ID: <CO6PR18MB44192610DCB3FB2975FDF253D8639@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20230413033422.28003-1-zyytlz.wz@163.com>
In-Reply-To: <20230413033422.28003-1-zyytlz.wz@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4419:EE_|DM5PR18MB1595:EE_
x-ms-office365-filtering-correlation-id: 62003d16-be0c-4917-3e43-08db41630229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJcDJc0I2T2HcN1kdEj9tRe26+Dgv4jzqG+N9Bxs5XKrpzGUkxEKVPdMgWVrMKD7I+ydIKaWIlC0ZDFGT0yo+hfdCIa+0dGBTBkfkJ72yX8S8N4hFcW2x3jN7uYfMHgyuAfD5RWUYYaheyv2MkxsFUh4EkiPvyXylsAZRqHcUoiWJJrNYp2Gfx8fwW95WJSU5IJa6+xGhKuU2I+58x2eopqYxAXpTujobXcKE9oB200JycUh53GDsKNvJ/AlPKIWnk0YXIXz7g/PDUJX7qZX2eBufgOoF2+AiBttcoBiCQ1rwT1jDyizHRHBlAcT7Z2AoqABgkTPM7I/T6GKE3VZXq+Gq7XNIaVNxweAMG16Q/Il26OdG9R8tl07o6DQDX5hZpXriA47/QE8KuTmZKlirO0C0Fq1wNcrK5k9FCyagEaUzWEt0IMJqFXxP5kgfjaKqzipNgNwHFhGJFiv+ICiIdSKRgZz5WZ7eezfujyJVNjW8tPDZOhJnD/ANGzsfcLV5C/muMQV6h00uQjgrDetEMo7bfR1c4ltQmrWcj5iEx+RTqqJJ8Y2JzSwndzWH2GqtWyh8y8vKd+ZwL2WSvhXkql6l09B03zIKiXRPTt8s99H5mzUTVWvyxtA+e291qAS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(6506007)(26005)(186003)(9686003)(316002)(53546011)(55016003)(8676002)(8936002)(38070700005)(86362001)(52536014)(5660300002)(478600001)(66946007)(54906003)(110136005)(76116006)(83380400001)(41300700001)(2906002)(33656002)(122000001)(6636002)(7696005)(4326008)(38100700002)(66556008)(64756008)(71200400001)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1dq3D3xlHrWfRM6vsud42qqMpOZEdWgpxwOywGVXyS+sVp2VcYgK/bYRLhYA?=
 =?us-ascii?Q?w++uNZ9J3n7bxy+aGXzDWgJinKq+EPh9FcxilcfcVGU5EUHOnWCeBJxGeGOu?=
 =?us-ascii?Q?2gcZjTCioPsom4YJEcqGkn4ClmbcMRR5aqCPNG43pBMEvLfynaY1ciOHbF0K?=
 =?us-ascii?Q?6/H8GaecnOvP71IAK78qzDhJchSIcMi9uQX+kj4IlRzPRwBT/R2ZLULbDiwY?=
 =?us-ascii?Q?5bIOj1KVK47TW7Pq7GX2DZ64QYfWibMMaom9WnQU1KyGNxPWmPLbwXmYWjUX?=
 =?us-ascii?Q?TH2dfts+JAOMsFjkoQdm8V2w/NvSYYnANRdY6mjVazxs1NcAZEIezPy7HsoN?=
 =?us-ascii?Q?hYyUB19YfDDXVyR38Y4h7qat2vbZQOfrBOIf99u3PI1aUWseZUC3LIKTqSXF?=
 =?us-ascii?Q?e07T52edW2Gfz7jBQFxnx5KZLStRJPuzF4f4eMdRttp1a4znUKGkYBNm4cmm?=
 =?us-ascii?Q?PwV5tdnNEWEqMfducT+qdPODPrlQhDhbmd1F4MNpH1YQ2nHbi9pzKaVFlIk7?=
 =?us-ascii?Q?EvIfPj2F8QBQsfE/nAspqlE/4keLp7xax3SFlZg/Hp3L86uUAEon3kAhavlm?=
 =?us-ascii?Q?6SxZkS/Kieq1UPlcmVS9GlBIHSvjMGjquV9y7IKv6/LIrztls0jrWoIsX1/X?=
 =?us-ascii?Q?K9+PKkiZHY9QXKp2ehfkLtkBSYGf8vsJAYlm0sJffF2px2CAVnn1AeuSWNIL?=
 =?us-ascii?Q?GXBnZi0rr1FaD94VIYZgD+q0c4zlvfeup6BCL+TavSYBwZ1o8B8S6eU68SKm?=
 =?us-ascii?Q?EyzzgXtm7QJ7VW2F2B0RR2m2PFw7NqUqLF8ba9TDniUR2dSvZ9xec0cEbw3d?=
 =?us-ascii?Q?vLclWmQpj9S09piHeKdL3hiBjO/V0SkkRt/qo+0MCaa5X0XQQZTrLjyd+Xer?=
 =?us-ascii?Q?kcUjv+Vw/gixO1AWiRyB3Pral/r4DUrtsWE1TcUOaRdP9G1vrpZ5mkUqHxgU?=
 =?us-ascii?Q?01Gw4H140c0SCQPcWdWD/K8lqmPXMiNnXbSohJ4bGohZRGnlxogJkgvZlUPb?=
 =?us-ascii?Q?0mx3zjRLa8BDtPGkrBQO8rj4P1RHE9bxD/7ieR/9Fwt5auS9BaeBr6HPxu6E?=
 =?us-ascii?Q?CkgWASR44pPUDI1/1N/UEzJ+slLlBuEJ/85b3cRQkheCIhq4K6WRh2iB1Pl9?=
 =?us-ascii?Q?gLZPsRpLumxaPmo2u5TDwRLuPMJ1eOiiH5h9MnKznnxfIGt5xfheBatW1/Mq?=
 =?us-ascii?Q?HQQvLm/ayMjC61VpA4UPDJNMCilOUcEAM93ouBCT4YScuBLYWuEO9vkNoun6?=
 =?us-ascii?Q?G9v38XFWEBzi45mIHclhCd890u74siBi1B0NtdFlp5phcuRZEpYnJpNGcWnd?=
 =?us-ascii?Q?9yL8hJoM7236wRnL7ejTWNdUBvDg9J3SFo4Pv9LOsj8Iw7YWwujsWeU05HZo?=
 =?us-ascii?Q?uZa3aWvMQ9HEwAvGS2y6k+kv4y5YB9lOulh5TT4emV2tpqfv0Kuuz5RXeepq?=
 =?us-ascii?Q?cUqc/hUVKZKFmg/ZZBAp/fwEO4q9EzrXU0dhUmYIWHzIj84qmh1DzEZKQzcM?=
 =?us-ascii?Q?uAc2xzrHyPKLpo3rTFhF/KRcezYZdobMMOmtqP2OlUUO209aaTSK9e5QC7Q+?=
 =?us-ascii?Q?j21y8TZFNQhoG61S2LA2GDSSO7AG8Xiws5ZJvPUD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62003d16-be0c-4917-3e43-08db41630229
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 05:49:29.6556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9J4DENbqTRksiSf5x58fcjxsl7Dqzp9bzbiM59GEJJZtZ1MUAmD3wkt9GPYl/PCvD1YZuzEhAHbd8eU46ytaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1595
X-Proofpoint-GUID: IpAYdaDP35cwwLZuN3Vd5QsJfokocYzk
X-Proofpoint-ORIG-GUID: L6_1AiHUrDWyQ6WDR9uQacA0jkm_6cuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_02,2023-04-18_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zheng Wang <zyytlz.wz@163.com>
> Sent: Thursday, April 13, 2023 9:04 AM
> To: Nilesh Javali <njavali@marvell.com>
> Cc: Manish Rangankar <mrangankar@marvell.com>; GR-QLogic-Storage-
> Upstream <GR-QLogic-Storage-Upstream@marvell.com>;
> jejb@linux.ibm.com; martin.petersen@oracle.com; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> hackerzheng666@gmail.com; 1395428693sheep@gmail.com;
> alex000young@gmail.com; Zheng Wang <zyytlz.wz@163.com>
> Subject: [EXT] [PATCH v2] scsi: qedi: Fix use after free bug in qedi_remo=
ve
> due to race condition
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> with qedi_recovery_handler and bound &qedi->board_disable_work with
> qedi_board_disable_work.
>=20
> When it calls qedi_schedule_recovery_handler, it will finally call
> schedule_delayed_work to start the work.
>=20
> When we call qedi_remove to remove the driver, there may be a sequence
> as follows:
>=20
> Fix it by finishing the work before cleanup in qedi_remove.
>=20
> CPU0                  CPU1
>=20
>                      |qedi_recovery_handler
> qedi_remove          |
>   __qedi_remove      |
> iscsi_host_free      |
> scsi_host_put        |
> //free shost         |
>                      |iscsi_host_for_each_session
>                      |//use qedi->shost
>=20
> Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - remove unnecessary comment suggested by Mike Christie and cancel the
> work after qedi_ops->stop and qedi_ops->ll2->stop which ensure there is n=
o
> more work suggested by Manish Rangankar
> ---
>  drivers/scsi/qedi/qedi_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.=
c
> index f2ee49756df8..45d359554182 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -2450,6 +2450,9 @@ static void __qedi_remove(struct pci_dev *pdev,
> int mode)
>  		qedi_ops->ll2->stop(qedi->cdev);
>  	}
>=20
> +	cancel_delayed_work_sync(&qedi->recovery_work);
> +	cancel_delayed_work_sync(&qedi->board_disable_work);
> +
>  	qedi_free_iscsi_pf_param(qedi);
>=20
>  	rval =3D qedi_ops->common->update_drv_state(qedi->cdev, false);
> --
> 2.25.1

Thanks,

Acked-by: Manish Rangankar <mrangankar@marvell.com>

