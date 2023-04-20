Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A86E8EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjDTKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjDTKAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:00:21 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB0B268D;
        Thu, 20 Apr 2023 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1681984801; x=1713520801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D6nw+5+KZlazb3ijdZ9U8oT6Xznd+p1DsNbmDO99q8s=;
  b=oDimqFXHBfqry3jQKpXs49gxQM7XCibpgld1K2TLo/8rvmxJw1GqjAZP
   L+XfjU2dqqbKbA3gu6QDCH/BYpjhVizFLX0hv8eisZ7m9V+cUI1zl0AmK
   aCHOT/3s+31wQRDu8AKuMQv1HSRDphqjA65Cn2A89xDmPU5/C1/ZwVC+B
   vR5CjHqm2edCNv65iJgrmYESbOyKjOu964e6Xgya7Bf1sGJeZlk98HBry
   2i99ar/t2V84d9b+ZtRq8FJaE5eDpuYu2zVitdgDO4abC+ks5XpPeQZt7
   WkYVu/LI7P5dM8RV+EHgP21CvcmJ3xMsqEuQo/nFdRPBUOFsZFHuBF6bL
   w==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677513600"; 
   d="scan'208";a="229001470"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2023 17:59:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7ZyGTVxN6Xqocd7gsj72RyHNyF1EygMJu6tdMNbA6cPQlI0ysAPYVvQWqiOcNhHmR/he2Bi0U5cC782+BUS9E8NpvUsizrqXjx6/h/A7Xb0HUmqMIIdUtkRo4vttot3d0fS4qAYwLNC36Yq5T+2TqmreuqE+IwI5kdaTMN+5yuy6cNH0HG+9VNDoVLCZ4zVRYMAdQUb6VC7/CEv5trkCnUPiv92qBFab8C+JFqUxUx2RnW6FCqQB3U1FpkY6GVNrkr6XI8zIr0cGhJ+kJlB+x82icdKtekiUtYfah7Ro696ktdhbnc6NGVTYZxn+MKIZ+YQLDhxOl3MBACHgDmk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVpwYMyIXT5TAB/fZpZTpOIkTLp6e5q1spkJWQ6emTs=;
 b=k9kv8wceu2xhIVeuBSXi6wZwBCtzgFbh45I3oZxI7vdeUx3XAs5nAE/nCIJB67bY29SxVwBtmnMJjlnoB2smgVmWEGsOXEa1hT93WU1guRkIW4dD4bKsn9efyF+Q9Ruvu/y3Yek1cj05xXuSjbjcp2C5XmseNd+Ai2cz9O+GkmCdLCl18zgCnZ4vptyBN9S+XRyzvK0WWLzA7wugSc697mrs30cI04IP/YWW9BgC2kgf5htCLVzH5U57wESYRxmWaCeMirzCrQfmW13yAyDvtbfMbxBO1Nz3Kyj6Q1MKn6oFsRUgebtw/zwoazOxzMrbTAltsFKT+eZMewMCuXg4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVpwYMyIXT5TAB/fZpZTpOIkTLp6e5q1spkJWQ6emTs=;
 b=LTNjv4aTXOCbODYlpmnyxAvjlEkVnz+yhS+U3tgoFTvpGiL6mOfoqEF8zlCYWqNz2A2pMLOawyi17UY0Y1wKGI7H/E/los0byi+XTIV/E0k2Mq+90MgZ7oVvgqJP26opmDLeAOvzZvWz3CYRBzE8B6+DZhIsQCoY/aiW2KTxKuo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8520.namprd04.prod.outlook.com (2603:10b6:806:339::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 09:59:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 09:59:56 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Dan Carpenter <error27@gmail.com>,
        "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: RE: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZY6T/4Blt3rJSVUiRYWFGAGGxLK8ZHuKAgBr3aqA=
Date:   Thu, 20 Apr 2023 09:59:56 +0000
Message-ID: <DM6PR04MB65751D81F92C86E81C1AEE57FC639@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230331074650.75-1-avri.altman@wdc.com>
 <b5c43582-0a73-45ec-83c2-8c1bfd2af2a2@kili.mountain>
In-Reply-To: <b5c43582-0a73-45ec-83c2-8c1bfd2af2a2@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8520:EE_
x-ms-office365-filtering-correlation-id: a4deb78c-1bee-4b9d-23a4-08db4185fefa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25Kk8RDsx6ybybePNv6GiyyC3bWkfQjDvswhkrSX5vj8BlGMmOKq5vfDOOI53D2afefvbq5LZRrNE3dKWiXJcjKyEMD59cZPtHXFXramXu5OwGVRUn8KpjbGUSg7gZjB3Q7rPWnuveg+puF3S/Rzflx+86uXwFqW4aBhEWb8YAlSIfJEp/pzL7yGsnVrG9edJflX+qRNw1H+lxku9MN+zQUtLEFQQSpKebM2ihZYF+1GjHwy6KhSo7uZJvs+4tiGU06T4x8epq4KfPQtpCOt27DRJRnIiIeV8DYJfvnhJGBSMQ5Jsxf7SnnKX8iiqAUryVT2XVW202/qWmwpaFEtCNXWjzgCPemMu60zckQloQ5SRIj5XPV+9Imd5lF686Bj6NHz9fDPm1E8SZcdHBGkBQbjoS1aUx2OrNYCXt07xXxziOVEDM2SEO7ZJachkblKzpP1P4K5ubA0pOiAFLQmuLYUrFvefx04BZ2zgiCWfeE5VDtaRPx4q0iXfYEPJAcin9K9VZEQj6qfJye9MVgG6MC0WDJ36J3wBRNm/Zd9dyXBtlnI64gb7gAO4Q0U6k0lZaEEs0pwkbxTp5VZkyjHbHSQIhbWERSXXpF5xtiS4dOgtUW8Dq0eV3zbLHSghtl/PrTOvQ9pM7NPMQoRLwM+GQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(316002)(54906003)(110136005)(966005)(64756008)(66476007)(66946007)(66446008)(76116006)(4326008)(66556008)(6506007)(9686003)(26005)(38100700002)(83380400001)(122000001)(55016003)(41300700001)(5660300002)(8676002)(8936002)(71200400001)(7696005)(478600001)(38070700005)(33656002)(86362001)(186003)(7416002)(2906002)(52536014)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BVfRFd0xIpPHiEJrzx97yDtKdtU873GvE/ijZgWBrbi0jSs/wrvp2VC0pLG2?=
 =?us-ascii?Q?oKEK/8fzOAw/vkNJ1tPmDOJcgnVOogEcHs98KWeoXAw18M66iH16EekwFP+B?=
 =?us-ascii?Q?YSgF8rF8kqbysHRweiV9mSeQkGFv5U07KG18+RW19vVqRnjsfzn8GD5HYHzt?=
 =?us-ascii?Q?19T6Ww/2NB3Yd6CHsD+fGlpmtUE2UOj3+6I9oW/8/OM80NNJ5ZkilYTAfPSX?=
 =?us-ascii?Q?dnNpq7Aq90g0RH0EmNZt7EM11kqNMaDsS+9QadHt9qqQcIUMXeKAfUlj7/qu?=
 =?us-ascii?Q?aeCroYNBYaJIQZ53ahm8jT50PgQAT3CuU3vq9MxBmzFtCFnQqyXffafnhyRb?=
 =?us-ascii?Q?K3A9ZeeDrKFTrHr6J7RW9nhSkq/168+sSnvG7IEZ3OiVbUQU9BXBH6mQ0T6D?=
 =?us-ascii?Q?/KBc96eM4U8kyH/ByAPdH34pMItGyQXsLO2l2EmvSyxoarw2M2hzMLVswyRE?=
 =?us-ascii?Q?pIvP0lnmXJZrIcNrZNZ7juFZcnBQBRwD7bXXsQksdLFAqzk/s/DkTQo9vnaP?=
 =?us-ascii?Q?L63uUUqp90Htu9VXF6t04jrOjRzZBhDp87YwT0GiOo4JJijuozS9JRddFO2n?=
 =?us-ascii?Q?1MEzc1L85QQEoJN3RpDtxtVwEeg2ElZfLtlXjb8UGSyTqF1VoIlGQQFn75Ot?=
 =?us-ascii?Q?0+1a+/E8iqMH6vE4MjI2D3OY5+0J4K3xSip8NrRvFU7o/2ZwAgnTpFQXp6US?=
 =?us-ascii?Q?LKh+bBzQqU6sAE3+gjH/xwpyWH2CPkTr/uzkeHddrW6etrIxH516g0O1Sgb3?=
 =?us-ascii?Q?eKjPUY+CId2y4KbIvkMKoRpjDY7ISvW/ybImcFuTNM2sHhRZR+CEyTx8UXpz?=
 =?us-ascii?Q?78ANktBU9UzBbHSTJ6RLqQ7JG6o5SsmyBKxBGgHgJk32kGDtKoQCipmypamh?=
 =?us-ascii?Q?7WTXauZNgaGQbow3z9RaO2vz1ii/GuVQI8YR8Ap7Yd+zrUHcqm0Kb8qEI42T?=
 =?us-ascii?Q?oVACHecSWegioLNPCkfaspfpgS59MDG4IgIyk5hGcHc4Nk2OCrTUhv9eaRy9?=
 =?us-ascii?Q?46M3AAxrUctJib00lCoKHvFCjg8GHsNM5HjqNxWOzxNisOZOZKF6cXQJZVlJ?=
 =?us-ascii?Q?qiJHFBleL8plJN65wNw7VHoGgUxCwGLOxkdu+E827Lf2XmejtJYfGqbHLAlB?=
 =?us-ascii?Q?F8GZhIrYSLllit8737M9m99xcu6Okg/rDGwzLze0Fx1nt8o6Qh1UBkAORG86?=
 =?us-ascii?Q?ov7iD3Kqwn78X1ZULeX+8Yl5ErA57Mrebs82Et+yGOHZylKugJnVOPTHFHRJ?=
 =?us-ascii?Q?tjm2OCD+reN2oKy4n5lwrJYwzxmgAHq3YjUd4DwvAzObaYaL9rDbKn6VkHsF?=
 =?us-ascii?Q?zGz6Tdq97V2tprCetPKfH2PNQMhTU3/NRD3OTBy6cUHTwoqXpVC4cFzgMNi1?=
 =?us-ascii?Q?FH1aHPDu2UUUv9KI5T2wlNLdUXOw8TNptU+r+C+WO1SUk0IH7QCP8wMXVFZV?=
 =?us-ascii?Q?QSjIUNr427c4N4GBRT7evxPONG60EecyhU1kHz2rJ7uVx6lSfnpjFAYtE4dz?=
 =?us-ascii?Q?5HUzlGhJS+QPDyoqhzb+wJnRj9G0TzDVvdxlaiqPs5GNOVk0U5t90kX4IWY0?=
 =?us-ascii?Q?wHmGV30qCbcTngdrGR42CPBGrT+PmnDNoyVeUVdz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BiBmka4CYW2cZZglIEl37F+PPl5Nhz9TU7OJ19ON6FC91FGcafcCblwLwwhy?=
 =?us-ascii?Q?WCMgqbGzbG/+ae81nwtTiEfoR+wUWVTiVAitbdJzMJMlEUiWVBFnHOdTWopG?=
 =?us-ascii?Q?WFBe09IX64jAXKQa485kz5QW8LB2nBOlS4zGKnYStAwoYAJ9sC6lTeeErQU/?=
 =?us-ascii?Q?ZlaQxjStmdMizaw2JSqTY0hK0wgj2svKLSIo9z2xVyg7i+QTuoEL5Hn5kc07?=
 =?us-ascii?Q?din24KNvDAJl53oqyE2/LIGZ612oII6/7rw8hwqfWfXG7VuzHYhIFlA32a4h?=
 =?us-ascii?Q?gYzzUf7KpPrEqJNIQ5P1/OkLw0nP03aQSR1G6XzF5BSWzyDMBZA3jw797Wnz?=
 =?us-ascii?Q?py88zgerjFztbKq4m1RZZIWPBEWWkYKeDWAJL6+sSvu034i8M+Lc+A0Ax0kD?=
 =?us-ascii?Q?hvBIiML5aVISGbP8xwxlsCV9cWi8pbj8Jr5jNHEIZ2MSNVonUu9ZV9dPiWyp?=
 =?us-ascii?Q?stLYX4jJTmCV1DjI9reaDwLjep006TEsP3dgI6wXDDiPm5vCeAhtV01CUKBd?=
 =?us-ascii?Q?70Rc2sEHq9eW+QL+mO7xPuzR2/dtt2tmgi9mCcmZnZEq/iPrbW/PROJDVicI?=
 =?us-ascii?Q?kpev84T6otdT/GyjwKilWaHw1fUZRgQ5Sq8BcijKpoXhQV65E6sSaQCL7p6/?=
 =?us-ascii?Q?hnFD3tofcGDj9pS7mCJJZAVRAZBMemw/8DtrqvG4KWQ44tiIyx+wSSWGGgoI?=
 =?us-ascii?Q?cHVEJGyLTfnTesLeRzL3162gwHCXMrRZei6ihIgn/IWVSckWTc2peoXUP4Rj?=
 =?us-ascii?Q?FcFDMTQ9+Vz0efUfX0tC9K9jfBmhMpBjNmJ0SxdtiTMqmGvMrnKcw7rujwKk?=
 =?us-ascii?Q?xR1j3UJrgOfY+sg2mjo2l7X+uytPy2t9mjkF9q1aZsv0+BuWVZ4QxyOlFqGz?=
 =?us-ascii?Q?z0Ix6f49tumD1xQ0t2swf8dvrnDftEb02IAeKAv78gbwccJzmQTCWttMZDlK?=
 =?us-ascii?Q?4WuxgqaRZiLrFv1x02VQjPZdrNzugS8sk6Hl4iWs4FlsPF94hia4Am8li1td?=
 =?us-ascii?Q?lraI?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4deb78c-1bee-4b9d-23a4-08db4185fefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 09:59:56.6800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEJq/oXyoJbPbBti7voiwKH4wRrnPXkVelRaGK+UqgtHx/H52HSZ2FqSgq3pK5+aTjrT3v15pgzqt+MQFBdHZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8520
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Avri,
>=20
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/scsi-u=
fs-
> mcq-Limit-the-amount-of-inflight-requests/20230331-155149
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-=
next
> patch link:    https://lore.kernel.org/r/20230331074650.75-1-
> avri.altman%40wdc.com
> patch subject: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight re=
quests
> config: parisc-randconfig-m031-20230329 (https://download.01.org/0day-
> ci/archive/20230401/202304011340.ltlHYazS-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202304011340.ltlHYazS-lkp@intel.com/
>=20
> New smatch warnings:
> drivers/ufs/core/ufshcd.c:8473 ufshcd_alloc_mcq() warn: missing error cod=
e
> 'ret'
>=20
> Old smatch warnings:
> drivers/ufs/core/ufshcd.c:5412 ufshcd_uic_cmd_compl() error: we previousl=
y
> assumed 'hba->active_uic_cmd' could be null (see line 5400)
> drivers/ufs/core/ufshcd.c:2350 ufshcd_hba_capabilities() warn: missing er=
ror
> code? 'err'
>=20
> vim +/ret +8473 drivers/ufs/core/ufshcd.c
>=20
> 57b1c0ef89ac9d drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8457
> static int ufshcd_alloc_mcq(struct ufs_hba *hba)
> 57b1c0ef89ac9d drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8458  =
{
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8459
> int ret;
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8460
> int old_nutrs =3D hba->nutrs;
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8461
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8462
> ret =3D ufshcd_mcq_decide_queue_depth(hba);
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8463
> if (ret < 0)
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8464
> return ret;
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8465
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8466
> hba->nutrs =3D ret;
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8467
> ret =3D ufshcd_mcq_init(hba);
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8468
> if (ret)
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8469
> goto err;
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8470
> 2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8471
> if (hba->nutrs * hba->nr_hw_queues > SZ_64K - 1) {
> 2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8472
> dev_info(hba->dev, "there can be at most 64K inflight requests\n");
> 2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31 @8473
> goto err;
>=20
> ret =3D -EINVAL;
Thanks.

Avri

>=20
> 2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8474
> }
> 2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8475
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8476
> /*
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8477
> * Previously allocated memory for nutrs may not be enough in MCQ mode.
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8478
> * Number of supported tags in MCQ mode may be larger than SDB mode.
> 6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon 2013-06-26  8479
> */
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8480
> if (hba->nutrs !=3D old_nutrs) {
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8481
> ufshcd_release_sdb_queue(hba, old_nutrs);
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8482
> ret =3D ufshcd_memory_alloc(hba);
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8483
> if (ret)
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8484
> goto err;
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8485
> ufshcd_host_memory_configure(hba);
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8486
> }
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8487
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8488
> ret =3D ufshcd_mcq_memory_alloc(hba);
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8489
> if (ret)
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8490
> goto err;
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8491
> 7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8492
> return 0;
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8493
> err:
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8494
> hba->nutrs =3D old_nutrs;
> 4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8495
> return ret;
> 57b1c0ef89ac9d drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8496  =
}
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

