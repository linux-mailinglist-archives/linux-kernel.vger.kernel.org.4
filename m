Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353E609213
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJWJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:47:25 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D34558148;
        Sun, 23 Oct 2022 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666518444; x=1698054444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=om/31s1extGnPDiEJuCFSM/2SqyrtRPFTAqtHUyANdI=;
  b=DiiVUIDckgRUy/PjZ0rUoQdJbLXSthHWWv6Lpkh30n/7EJqEhNAyDWl1
   7V08hLU8tMjvK6g8uPnlv3lD5WkejCaNGwbeZ4boMdC87Zryd+bt9V9Pn
   87UCgMMUkxe486PPbYQngv46Es5BF41HjcpaMkKg8YBjeyPHitxPDFIXe
   cale3gw0ahDBCX/dGM90LHdcWAVVLNv0dGGpoeB1vHlQ5BtZs7b7Sqmse
   bhxXLTyY321uSCdnb1aNNUOxg4D60bszj6u7Bp490iOGJEF6KKOW/0wlC
   lOuyA8k9y83Ef34OpjBmmOdlAZOVGpb6xByHpod0KhqHYblY/kn5Lg56O
   A==;
X-IronPort-AV: E=Sophos;i="5.95,206,1661788800"; 
   d="scan'208";a="214527384"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2022 17:47:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJTrnJbrWzoCeF8VRTFS63h7KL/vlNhNjgPkaiJJem4srHlsmBW+dBXnwfySTp4waLO1IInwFGU3ISeHj3BtfhHZnL6sWZYfvjosvK/tKoipmk48eUCQa5Ee9wTGfUR0PLmHCsiB7gpjGZPkp7+eap07Wk7aQrhPjMuZ1787SOUKAtvy53hUUliIUYcPCyeR39fInnGVqNn2MWVVxs2Z+udWAJdqxdt9AO3i0xLDQCqQz20MbIRoGCntnpSY965864TkdHoFxn3YmbetJc89BATlo2eK4syNiJPKTC6JhyC8pNpyHO3tJO1B/N4h+QQ3jKrcTGSRIXSHAFtnf2a7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om/31s1extGnPDiEJuCFSM/2SqyrtRPFTAqtHUyANdI=;
 b=brr3Zpezdryrgf7RWgIVtVMkHnVeGM6NgjDXJs396C76kK36nmH5skScEu8Ugo6G2M9j98RQVgx6igO0O9aOnmcsIXvXqOFz7uizpY5dlWwyZNjs0f70C1koV2GADBHi+pmBEsroEjTE6fjnyOguRU2FleWM+729Bi444gCyzvNgr2dFOGyeKV+NMI4noYoccsRPqhIte+fdDWuXGQ9Da2/PF14SguABYeD5lXT34wi1WA+H0vjrr367mIeiLigGXKvVW6vpLbGIpeuwCfRTT4uOSG/haw0tQWgpipa5HNMBwewGYuJizhcyudxGqc+m69IRVcDPh7Jt+2kWsxAjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om/31s1extGnPDiEJuCFSM/2SqyrtRPFTAqtHUyANdI=;
 b=RtXQBcMJN+/k7SvSWIC7H9JkeDt3dLA5mUJMTjLhytAPGgl7m+LpTAPZExid5mpgNpZ/oAovioA4nTTiCDGVIlPuENQHv1CrddWCA/SpbFRgqTHxqh7zEtH3DZ3E6iP4AUYfOapXavStviyPSUbIOsrUPv7E/WuTnvDMnNL6PPM=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SN4PR0401MB3584.namprd04.prod.outlook.com (2603:10b6:803:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 09:47:20 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::49aa:c6bb:bd87:e26]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::49aa:c6bb:bd87:e26%5]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 09:47:20 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Thread-Topic: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Thread-Index: AQHY5l579ucTv2WpCEeIOOZJmZmlsK4bu8yQ
Date:   Sun, 23 Oct 2022 09:47:20 +0000
Message-ID: <BY5PR04MB6327DAF12202CC5D5F1335FEED2F9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
 <20221022213650.626766-3-beanhuo@iokpp.de>
In-Reply-To: <20221022213650.626766-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SN4PR0401MB3584:EE_
x-ms-office365-filtering-correlation-id: eaf0310b-e60b-4edc-4743-08dab4db9431
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh3mFQwIpIkwxG7vCwUWEaQVpyIywMBZG0UlDTi7RiuHlGUpRt6A+t4obXlhaiz1POZpFxSg4sHc7JF96E6TGPko8vS6stAo1aqkQSPJdbrXeudqh8Db7wiC2qtOBVBTGMliYcerr8YY7RhVlKTtKrFlcpAd71+thVPHu68py6tAoOCeWl4GYqu2JfI4JbHRE3FkatBpE53rhrK5AOEf1ERG16e99aWIJB3CAs8uDsut+Znz/4Z0P6pwrTk5kvzfOUrZFH7M6f/LKYHgmT/kukO2mg5cYFPWUYFQdQtuyHX+kz65Z/TKGpJ0ORbDIEPqk1XJAM9LahT8GAOye6inbH4Nk55mEA0BleI0Ulg6XyX6q5cExYPGzPjZeZ64IGTEuNdJS9Pbh1yowva70xJNf/r6KmcclwT0M52/9rJWN18n2m24rntQYIBeIJP1W2IaCboeWOSLwbrTjT2LISW7LPOZAccUH4Aoci9uq5y4+n+k8xWEaY0N9Jy3B9w0bLteF82gJvSULFDn3r4JOKEwE8C7en/d0IK78tTPMoMEQhn/nz8SrlPP8jFm3ZrGkgaWFd1Bw2ww+NjcyUTP+Q7iUK3NRcBbYKsgVHSvuMxREwLQsZSM2QOoX7oGcwk51P1xdCMPlE/7btH8lvg7fCbBTbdKucdFVmV3Lfkl2H1XwSj1k0TX1zt3rkapLx1K2G2RDT/OkyAbluJoBzikHcpM/YkEm4SguPI7KIBP1VTxPyL/F8eRs7A7kisx62LjxDtPfBrp+oU9aLS/0CxtiiMTyX4CcAt8B4z7InQOxGvq/Bc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(66946007)(53546011)(76116006)(8676002)(66446008)(64756008)(66476007)(66556008)(6506007)(4326008)(921005)(186003)(55016003)(7696005)(83380400001)(4744005)(2906002)(110136005)(9686003)(41300700001)(26005)(5660300002)(7416002)(52536014)(8936002)(478600001)(122000001)(38070700005)(86362001)(38100700002)(71200400001)(316002)(54906003)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?clN/FSLoLlKp8z0GH93HbWo53vGecaVEDM90VuzqL78riX5SpvAAnhm1jRtF?=
 =?us-ascii?Q?1UlMtrX784rJCLYveKRG+uZGM8/X6EKmtcChbN8yGHnf6LgjPbkZ1qxmn+3A?=
 =?us-ascii?Q?S65v7cistD8H5qLqfiVezttyLTo3KYjfC7lngGlVnPc12h6zkx6fe2TN0vf8?=
 =?us-ascii?Q?FQi9IjJ0Q+JMASY3Aceg3OH2w/OxPiPc5iawQaNyiNKRdFFP4dB26Sri4OGt?=
 =?us-ascii?Q?VSTF+PkGqfbq3WRae30d20zUQP/EFWZcQWPJlOiekvNbVVhwDShdWX5q0HzP?=
 =?us-ascii?Q?t8uAJ7mr+u3yKQeqYEfeZ3u7o1h5zXxwZGkL46zQaE1Ugb17LTAG25Z+pp6o?=
 =?us-ascii?Q?tzDigmaGUylx4281gT81oHDA9mXhOFY4cFaxf2goFKKxJREGnG2ThGcBPp4k?=
 =?us-ascii?Q?sljWLPu4pA0V4Dgzt5n855i6PQdG6zOdtQmbb7zDKu3mehzbHbv5Hr7p2cGG?=
 =?us-ascii?Q?hsxrf3sYH2Eep7EzhOHMMStykodnt0x9NRkeJdfYX9ZtPQITvNR5dPuGz5MC?=
 =?us-ascii?Q?76BGlZWxTEGJjYmMkaIVRBulUJ4maFuGuLN7vmbX+dV73Zbo3dH/X0lTs1Au?=
 =?us-ascii?Q?bT47n+Py+8/Rj/dl3w9BuCR49LG5qtdvGUMySXm5xgvlVl3ty/aRNQ7d6HZk?=
 =?us-ascii?Q?UloNC8s572jwfUJ20m8A2huxhrEbRr1b7pQJlNDEzBR4yVqHbrd30jlzUePY?=
 =?us-ascii?Q?BUoTL42ukMWEQXBvirue2+Ku+7k2Zj7ZieNEbYQ1GkHgTHxnGQfaB+s8TvQH?=
 =?us-ascii?Q?P7r9s1vRg9vcQViYHUckO/qev0P1OTLZBewxHAzpvu0z0yONDVEKwy591sPk?=
 =?us-ascii?Q?MH8gCiRIaeJMqdSomABmnloK6s8JDu8gIRjuQesgL3sk+FL2otxogngZtbWO?=
 =?us-ascii?Q?LCfGT4TVr+hKrwLR2xX36HHkY6qoJvHYGfhupt5pluKBJN9kc2O/lm7DTjdQ?=
 =?us-ascii?Q?2XXH1OmzNqK+fUzxMC7T0EF6LyxG8PIAZFR2EJtNsS9jxEBmWSrIBX3pVzwW?=
 =?us-ascii?Q?CHCzK0J1Q9bdas8VeK9hKyrVmNKs9HlyO8IS2O3I5/iy9j2jWIVG+dwOfcUl?=
 =?us-ascii?Q?yu+hod7WKi3yCrSDWvFNWexoACmZit//Xnwm4Mx5y6EfgDB5LLZXJFx6j4qX?=
 =?us-ascii?Q?F7SisY4INe6XUojtIGMhnlQ/9GNWUIRDfdyaIVrpW/ZaiZy/2B5nDhmh9Dp5?=
 =?us-ascii?Q?bWI9E31gBzXikTFMz22DTBWFdWhZ8hpQYYdQYKa3hkjarqe8BKQDvzH6vScH?=
 =?us-ascii?Q?qFGbEKGvfvFTbV2S7RxGMmQpF9hV9IDgg1a9fHAlZMqV9LR6CPc7lDb7d2GK?=
 =?us-ascii?Q?U7TPKuQpd5WZO9mBvQNd9urhm3p9/WI4sErYVTxm7ZjTjGg97uz9YJv/F4F+?=
 =?us-ascii?Q?VDw8wI8bpxTQWchgDySMtrr/imFQHHZaR9YX2bvIi1AGKiTewoXfChPexkFN?=
 =?us-ascii?Q?U2tpbEQ8rq5M7HN25k9qb4jNmyCh+6si/Z1VsP3HrvVL+uaA40snRtbJwfRH?=
 =?us-ascii?Q?gi0BZyvT6a6aVUCh3q1VwYlnkvS7DKMc1ldfsvaAT9HE9S9nZZzsu4gx26RA?=
 =?us-ascii?Q?4kLfelx4Mc/Um9CBzJhTUjoqB2GwaPAOAluRyBBX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf0310b-e60b-4edc-4743-08dab4db9431
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 09:47:20.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ePtdQ+LIQ7GqvPKdiairTM7HtMfIcIvioey7ISEWMBvYEna4KTCUf1/snCs5yMRFGACX9Afpu8VWHhZVDw2gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bean Huo <beanhuo@iokpp.de>
> Sent: Sunday, October 23, 2022 12:37 AM
> To: alim.akhtar@samsung.com; Avri Altman <Avri.Altman@wdc.com>;
> asutoshd@codeaurora.org; jejb@linux.ibm.com;
> martin.petersen@oracle.com; stanley.chu@mediatek.com;
> beanhuo@micron.com; bvanassche@acm.org; tomas.winkler@intel.com;
> cang@codeaurora.org; daejun7.park@samsung.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t
> the content is safe.
>=20
>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Combine ufshcd_get_lu_power_on_wp_status() and
> ufshcd_set_queue_depth()
> into one single ufshcd_lu_init(), so that we only need to read the LUN
> descriptor once.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Reviewed-by: Arthur Simchaev <arthur.simchaev@wdc.com>
