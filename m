Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028915BDD64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiITGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiITGgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:36:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2E45F20B;
        Mon, 19 Sep 2022 23:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXqIbKatc9Q3a6fgVevZ+FdRcbMmSXlD6ZVQsa1X5e/VT5Mj5AXg19fVlspjyGReB+EaIKJNB6pZZ5qmsHhXdN8gvCkyoYlGRJ/LebgJlQbqtGobDkZT2qfiCqB2pCmctaZAw2F+t5qCYrWhbO2wipiYDqz1FTQ+JOkYlMA/+IghvTVi4PiRzkl6ZRfiaZ77lu/d5Z09Xss9egUD2oAhp8t+SvFux18EoGx6FStm7ZlPo4bpiKihnIYh9l5H6PscLl+aX9AffTUihEvxE6pDn6uKFV7gJNytuebt3TcEfyL1Ud73Gpdb6s8ouKY5K0SG1ZZaPxpg0lAbPWNsyRXorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYHxXYnesIg8JEG7C4y/f4c9P+pPAgpBhGOPWg4Fe48=;
 b=TU+5KoIxKyql2k+DivywOkqZFKCgaviUU0UIPRAYQxMfuca3KLstU4thDFcfwbwV+XoC7RJgnJwRef1Bhrou+PYd+n6koai9DesOluCTwMGnIkCeH87FmvPJroQHqY43oBgTll27MJMQ8bQrwnoIP8miYqvE2oT+gFrQUVvEojO5mukFNoJ5nmdWsSSRvl1FtYprrV0qR+NCG8NM5+wRry6iw27tugSnjFKv1Bm+Bs/E6AOaxKExmCPgDzjElu6xbY1gKNaL3uuWgHsoK8HIUfnaDis2NreykUPZgvnUmK77REFrD47UnBfeBF8iONWX0QJKgn5DpSYmTXvrO8kiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYHxXYnesIg8JEG7C4y/f4c9P+pPAgpBhGOPWg4Fe48=;
 b=NY/zwcRrlwBMM7Q8hkB9aEFwhzftNyqM04oHtKR7WV2jsuTGZIAABNs/yNlIDruRhLN4rfzi98wy06B0R3ATjJkNMwUjNO84845demwZ2VLD4wxPpILz6H+OpV8xnd4cVf1q43WNIhQ98yfHT+oCzkut/Bq2jiMflZoiqYE8R9c=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 06:34:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Tue, 20 Sep 2022
 06:34:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 0/2] remoteproc: support self recovery
Thread-Topic: [PATCH V7 0/2] remoteproc: support self recovery
Thread-Index: AQHYkAx5W4uJ0cTEEUqsuvaJeDSHw63oHMyAgAA4t7A=
Date:   Tue, 20 Sep 2022 06:34:18 +0000
Message-ID: <DU0PR04MB94171E5A5D7EFD79E3C2D950884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94177A3658A8B5E57D0C5DAC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94177A3658A8B5E57D0C5DAC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8716:EE_
x-ms-office365-filtering-correlation-id: 47cf8bd6-49cf-4464-bffd-08da9ad22522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBuaIiIbb705nI7kRlgxSWD0657py+ReTfo2zVBpiG0nwZ9ymLtNZLjbmp+AIME7b9dFL+0ORhjCE1nOnFH2wvfVzWYrvD6z9Zjicey2J0ryeWQUSn+c69fdpK7mlFjR3H4zC/SlQJuyyAyktjP4bnBci+B7jdF7OyvILEfds/Q98f4RoX6MkTYmzZLQ3CnJytmkvvppFh8CZsO+feURkHezvu7j6oV9gHsfDLgRoeAcI+1quYJFHQvlNAKzey5HCFipwoRU719GvcvNXik2BCid47+uvCcpALNptkN9pcjufOciH+gnsURAX9AsNbhPRHJ5/aahQbE8K+PDM8vJnnIXXBVEEYHrgdD4qyxCvlQbfE3yXGxFx5cC5lBCpbSWaV+JkEHfEXvXzt4eyyq0QxgcBgq0Zdm1DdZ5uCO1A/obCFacrqmVmw4E8+1ZCqLVtA5a34mvo/1VLQu7Cy+V3SEO0dlsETmQ3CfRpO/lXmx5tQbZWEW5akuxZNWs1sO48t2QxWAvYKHfstONmo22AipcluLey8Emwp0VwvUhWLhm2UWWlVcK72wQFeY561neDhPJHdZxXqPWy5Fu4TnK0RkOgA6gvFunPZj/nZ93DL9sM77pFBCq1dVz4Joiv2e19smjt9mIzi1LHUcRe7ajK/YNzelsnSXAUGUN5M7wI9GLPk1t/1ZpCBFTfVi/wcE24EU95KMWtmskn90n/yQkH6/quYeJtHxD3nI5mzLDUCS5Wr4t+Ta24wEagvv7+fKAH411rWnU/THck8tVZO+FO8K2V2Ps8K+QgJMsg6efpl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(66446008)(64756008)(2906002)(4326008)(38100700002)(76116006)(66476007)(66946007)(186003)(66556008)(83380400001)(8936002)(41300700001)(122000001)(54906003)(110136005)(7696005)(478600001)(966005)(71200400001)(86362001)(8676002)(9686003)(33656002)(26005)(2940100002)(45080400002)(38070700005)(316002)(6506007)(55016003)(5660300002)(44832011)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ngu9yH5c9xllT3T2uANcONHP8u+mzzyiyGwb0hoV3hI9bqp+4gmlJBKVg9Cf?=
 =?us-ascii?Q?9ykzum+KGTLa+ZNMeqShRpIzA01gMu4skjOPBtnuGz1m5xx9sMmIB9d6oARL?=
 =?us-ascii?Q?t5HWYiU+3hyskNtZRKMsh/ba1/cv4W4SGd1ZKvlEprFVWoKhLz6z9/H7TxBj?=
 =?us-ascii?Q?mU3BWghClOqqiesnfm7RBq0P+3FHOHowS6fWSq3XR0PJzCixuVvCjZtwnpqx?=
 =?us-ascii?Q?/p91jGSLlGn4rzpW6fOS2H4Ocjrqr6WHwP740OVyIaY7FZOm9EEu7cMIuyL9?=
 =?us-ascii?Q?33HDSSdL5j4DBh2WtKjpCwrXAZ1pO8lDj81TkZ2ESkFFFuBfUOmtaD/tH6P3?=
 =?us-ascii?Q?MxXQXnx6BptcQ9xroeAdpcimbpHDhwx5npMi5htPTsQnbT2AO/ZgdLxOtdQk?=
 =?us-ascii?Q?z8xLiWXl/r5Citv+XUVW3chNb/kdaLTU2OINONqoT/RxHMa0xE5NH3XF2u8r?=
 =?us-ascii?Q?gRBKNR13G+gHOo4Zu6283gB6UMb3OzHjC3fx1ZfVPUcJEi698UPRs6PJsMKn?=
 =?us-ascii?Q?dlbtuDfXM/xAaCBTV6abnoV/qeiaEnPWFk3NPor2MVlTs+CzJr4gadrHyh4Q?=
 =?us-ascii?Q?GKFad5bqTvTc0rbgsJlFd226NW6wtnOZ++ku+PFHutujHSG9MOEtcJGpLZ8o?=
 =?us-ascii?Q?Vj/yBUkCyoiICO2tejiLYrXCl38bdg1fxjfXxem+poUcxPVf7MIZEXg9iNTE?=
 =?us-ascii?Q?+PO60XNMDFkddOrFUlAoN2cSy3q+TjE/vaB50a2DV1g/+NmsmzUj/19V0Uxg?=
 =?us-ascii?Q?sVh4+FD/yKrGHgtF16C/cqc+Wt3svdtJ2EfYneHtMePqGUJtPOg9Qk/wkqXf?=
 =?us-ascii?Q?T8riug+zho94UN/3SWj3apCMBa1Fw52zSPITbsIE1+SKEP//Fj2W1yBnUYaV?=
 =?us-ascii?Q?wPiIuzdkGUiXuwFGh3KMJ1QBIbOG5HGcjxh+kJCNp4xCwWTEBBbykNQeGc0o?=
 =?us-ascii?Q?kAlQ9xazTB4sDOuV9mrLD8TE5VBM+pwRhzLzk1puBBsexJNv05ArqHhi3uMe?=
 =?us-ascii?Q?mWV3lwP4MomEAt5qn9XDUrS/P68KGlLBJXlC9jTg3RgDCm6XMrldbM/oUeXx?=
 =?us-ascii?Q?V8vSiQnN2T9KlKD2khBrrWbr4pcme8Z4XzxaEI+lvTGBNPNF6nXKjJGCKokQ?=
 =?us-ascii?Q?GCYwoocW5uMMR9mfv7f6mTfBJm+gZGKgQvn5vUpR0RhmOBrji6hYET0028f2?=
 =?us-ascii?Q?AkuaHUFjjfP6K8phhjh/sVfHmQd5HMMiSUKWNy3hPllXCcy/jvEaUFUzZeyE?=
 =?us-ascii?Q?l4inw231qAVFjgyJWw5hHfJ46j/94WHb4WdSVvWZtuAp8UoRxnrOxbEl4AbQ?=
 =?us-ascii?Q?JnNjfZOJJMPEn3vxtohPqmjQlDmKymQ1N4qEepQh1W+U3E/WHZt8vKjpPyoM?=
 =?us-ascii?Q?utdAuB7M4fP2TkFvIGRRdAs9rASidVIVpA09Xw+/sXmofbWp8C6GC8MPv8Bm?=
 =?us-ascii?Q?X6p7ESNZsvNW34cZrQ3VHoaHPeAXYVECVo/M8lcTt1eoOen94KQOKAnZxg39?=
 =?us-ascii?Q?sNPVDlfOUD10lj1qqgBOfj288mM8GKL+AZrhnZW9YNa6nCVN0drwGTaNmywu?=
 =?us-ascii?Q?89SrfmsD0ZS2jY+UF32mjU3jPQ36ouU19LmModcf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cf8bd6-49cf-4464-bffd-08da9ad22522
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:34:18.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xG8/kJeSPsmeID5ooVpKrHgpso5ggNnYHNlMZvTgCitRD7C3rsQ38f8Aj7n6EIpaNW9pBSQobSssVhNo8FpcKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct Bjorn's mail address.

> Subject: RE: [PATCH V7 0/2] remoteproc: support self recovery
>=20
> Hi Bjorn, Mathieu
>=20
> It almost two and a half month until now, I not got any response.
> You accept or not accept or suggestion?
>=20
> In V6, I got a typo  comment from Arnaud, then Mathieu replied dropped.
>=20
> In V7, I add A-b from Arnaud and no more response.
>=20
> I not understand why ignoring me.
>=20

Regards,
Peng.
> Regards,
> Peng.
>=20
> > Subject: [PATCH V7 0/2] remoteproc: support self recovery
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V7:
> >  Per comments from Arnaud Pouliquen:
> >    Typo fixes
> >    Added A-b tag
> >
> > V6:
> >  Rename rproc_firmware_recovery to rproc_boot_recovery  Drop the
> > unlock/lock when do reproc_attach_recovery
> >
> > V5:
> >  Rename RPROC_FEAT_ATTACH_RECOVERY to
> > RPROC_FEAT_ATTACH_ON_RECOVERY  Add kerneldoc for rproc features
> Change
> > rproc_set_feature to return int type and add a max feature check Use
> > __rproc_detach and __rproc_attach when do attach recovery
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> d99c5c301
> >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&
> >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> mp;reserve
> > d=3D0 remoteproc/cover/20220615032048.465486-1-
> peng.fan@oss.nxp.com/
> >
> > V4:
> >   Based on Bjorn's comments on V2-2
> >   Move the rproc_has_feature/rproc_set_feature to
> > remoteproc_internal.h and  Keep rproc_features still in remoteproc.h,
> > because we use RPROC_MAX_FEATURES to declare bitmap.
> >   Update commit log for patch 2/2, and add comments
> >
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> d99c5c301
> >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&
> >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> mp;reserve
> > d=3D0 remoteproc/cover/20220323034405.976643-1-
> peng.fan@oss.nxp.com/
> >
> > V3:
> >  Resend the wrong labeled patchset
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> d99c5c301
> >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&
> >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> mp;reserve
> > d=3D0
> > remoteproc/list/?series=3D621311
> >
> >  Write a cover-letter
> >  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
> > Linux loading firmware. The self recovery is done by  SCU(System
> > Control Unit). Current remoteproc framework only support Linux  help
> > recovery remote processor(stop, loading firmware, start). This
> > patchset is support remote processor self recovery(attach recovery).
> >
> >  In order to avoid introducing a new variable(bool
> > support_self_recovery), patch 1 introduce a new function,
> > rproc_has_feature to make code easy to extend, cleaner, such as we
> > could move "bool has_iommu" to rproc_has_feature(rproc,
> RPROC_FEAT_IOMMU).
> >
> >  Patch 2 is introduce a new function rproc_attach_recovery for  self
> > recovery, the original logic move to rproc_firmware_recovery meaning
> > needs linux to help recovery.
> >
> >  V2-version 2:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> d99c5c301
> >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&
> >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> mp;reserve
> > d=3D0
> > remoteproc/list/?series=3D621311
> >  Introduce rproc_has_feature
> >
> >  V2-version 1:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> d99c5c301
> >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&
> >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> mp;reserve
> > d=3D0 remoteproc/patch/20220126085120.3397450-1-
> peng.fan@oss.nxp.com/
> >  Nothing change in V2.
> >  Only move this patch out from
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> d99c5c301
> >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&
> >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> mp;reserve
> > d=3D0
> > remoteproc/list/?series=3D604364
> >
> >
> > Peng Fan (2):
> >   remoteproc: introduce rproc features
> >   remoteproc: support attach recovery after rproc crash
> >
> >  drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
> >  drivers/remoteproc/remoteproc_internal.h | 15 ++++++
> >  include/linux/remoteproc.h               | 16 ++++++
> >  3 files changed, 74 insertions(+), 19 deletions(-)
> >
> > --
> > 2.25.1

