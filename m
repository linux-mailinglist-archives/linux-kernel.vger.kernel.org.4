Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5A633ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiKVLFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKVLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:05:21 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395D17061;
        Tue, 22 Nov 2022 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669115120; x=1700651120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=exa9LK9ew4ZSUhx1PPeyfnOWuLVIpg7K1fiyGk0J8Tc=;
  b=flf7QxwTfa+JrcBJscA06jyRNPFeke2tW/Q2WZoYXtO+/8isX3e1iVLr
   cMOghSGy916oZ9pf6W4iQncOl+IElaLGWV9Jfq/7F3zeF97GE5oZgP2XX
   4+O4q5yNBjlaNJohigOhWRRel8t9Ifgkzop/RsumJ2cXY+q92SgamBTnd
   Di4ng99Me7bjEsLXq7/+tbB/+y8eDc+ntRD/zbaRs4nLF+whhsgJja+QD
   hKUEAOrESrhmE6+J7cq0M0r/k79pTUC2rmwdfdav4mFTHLIT/G5W7+nrd
   TwNPNVFfKgKfrqMIiIsDrGDXdbv32AwcO00XIHUuAqTEUH9EDmqC6U6Il
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="321230817"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 19:05:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC6wzaPW7TYUW962zML3rFIP+y158mSugWwWnahDf0zedjUMzSFZY+q/kIGwzWkap7csPrujRXKn6hYnctbwb+COh9qMc+o8cyAQcdUS2NOGunuBMJCg3Um5eqgub9MEBfWeODm0CLFISRae2TXhEvnzSUWF1bTIo+mo3esj8moOref/u9H819jnRV4C3KG5hiGsxwv2gpl99SqtJb4+tbSLRxxeI9s0iQjdbVD6txVrQwoO1e5HmPtuZla9mJqz/Sxs8/K2qQX9Hklh7TdEb5QiRK9DzCsjzWYKhmNhmiJN6PrY4HZSIsMs6L4/NtYNkmQNlRQ6p0mfEFdBMMY5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6BLCfiHg/RfoBlPqOxNg6tHkU+PlmTE7EwcREL4/XM=;
 b=kUWK/kjRqgQg0vnUIevTWO227BAJUB1P8Z/T6E/bb7CKzE+9FkMw4mvK0SNICUJnjPUQ8eB98AXaQz0diYeCbetmH0bp6bc/4Ofh/xj9do6icIrKS12MJPznMGwQmbHNPazu/7kmfrx8bpvSAdXawtXKhdjUUeW1mZkUUwsTuQrH28uHc5OBpoDW/oncc8e3deDesZDrLeKSKPdyc/6k63Z/WHPHqJnthUxTL3eaf0V2RSJOUcL0AE1MNyiALBYHiMHNbkTeilQ2wtwwb8/0CqIF0zspuRWWcdU9iUlkOK8gMxrKvWbC2rYy7t3fNMI5atnd5Sbf+cTbqbQpvto8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6BLCfiHg/RfoBlPqOxNg6tHkU+PlmTE7EwcREL4/XM=;
 b=W6k+KonnTrGe5a3nvoPSwMK2v4TVrGLpUVaq25TtayWlt5LPRDqIuriZjpfife3CocmjYaLt4K5gYfekPxaFFlcUSdssEypcazCd42Yke0Ab/o+pA3ZvC8AMrwJtmYIHZGCAPT9OAM4SXpuP7Iq5DHFwbtWczjAZTcjH9fR835M=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB5602.namprd04.prod.outlook.com (2603:10b6:408:75::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 11:05:16 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:05:15 +0000
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
Subject: RE: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Topic: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Index: AQHY/S6fGNUnGplQxEOfi3uFlr5Rnq5KyPtw
Date:   Tue, 22 Nov 2022 11:05:15 +0000
Message-ID: <DM6PR04MB6575FE2AEA80828348604AF0FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-7-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-7-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB5602:EE_
x-ms-office365-filtering-correlation-id: 5f9fd6a4-65e1-439a-daee-08dacc796f78
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GsZH3V6eRa1Fs9F7USnRHJ9CSTSUxC/c4ejbhZ1OdCegimsaQrNCd6IhKbdOs6/UkHTM4qnSHsaaFIswZ1u9QgULWpV9oswcxJZt0J6sOar+Y4HtFd9LUOo72aKL8yAuFvOHW95CFFTbgooBsM6RwnJsUMFiqmEhyG6SR9TLZn/f8lw/pb0hTDER+CsbIm6Y0TskZ1r54URWxu73UfJ8OctDo5CYQs8Fxlfd3wpAoWaxzNlcNmo9sU3VJTuWnD33OwfMnhleBHnk/u9TNCEIs/N6zXhGy0EZqc7J0t0pkCDPg4S7IVwRmd9WHWikHewhN7Erz/2HBi6qfpKtnPC0WbDRIH097EbRtzXvoLHmAaCBocSM4Mw2xDdi4kwQRwfRzQqBBQgp0D4K7zaUoCUuIaTArU4Q+jux/+vz+VjheoRIwZNGGRRwV9VXAxwPu9OXuWvm2f6KwNHvfqJI/e7e0xjah2aYlh0QftMsnWdNMmg12y7CuuuEFyfZw8Ng5A6/OQ7fpzus64ZNt6UiI6iLId9t4vspm/phDvati/hAfgrhMoTKtR6BjuiHakuPgqnLlu+lUDaNWyewlO07X6xz8I9KP5Swt5vsopOjIOtvzu4ObM/1iWJVGv36prLxXCZO6QoOg/NZ4a3Gcbu7f+LNuxi25kS/LAO5UOS9fz0Nn71G28fAtxLHvG9mfYDUg9aolIozp51G0HgI53GOh9A0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199015)(9686003)(186003)(83380400001)(122000001)(82960400001)(76116006)(55016003)(64756008)(7696005)(38100700002)(2906002)(7416002)(26005)(5660300002)(6506007)(71200400001)(52536014)(66556008)(54906003)(8676002)(478600001)(66946007)(316002)(66446008)(8936002)(41300700001)(66476007)(4326008)(110136005)(921005)(33656002)(558084003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MFXABLtR1a4oRNRGmO9YGuQCXCVKhfetbC/uVOMVnYMcba/+zSwYV2CM6HMG?=
 =?us-ascii?Q?Ad4jNULDTO8eBkQSvg7jXBqFfHsOnmtxJpKzYhTgM/gmjrv/TNBi2c2Fo4UP?=
 =?us-ascii?Q?6RlrSeuptdY2Bd+s62kexVRZdwgbgtG3CTMCjF4X5Br9QB+Z1dV0E5rsVvZo?=
 =?us-ascii?Q?DgqVQByP4ayy9l6KPe0XZGbx9b3rgeVK3V9LIWexW56RBueqc5YxkqwzVhYk?=
 =?us-ascii?Q?AM6Nc5Tv+jHQlyfZbbNJzcFxuaQI7IB4w46wiUTqc4qyMmfaOi3s+wwnM0NK?=
 =?us-ascii?Q?feH3DpmvRKFXwF1u1LqOYKk8BCtsMlo/vGcy/mOEQoCtjBxcEdGP9OtGyx8L?=
 =?us-ascii?Q?Jo6GeBB/J/ZLLUJ0AtRBUlO1C+gRRJDlMSZHcrckkmGipYIl4wjVuimAHWF0?=
 =?us-ascii?Q?+lz8GkxNfwJCQ8KgzvzZOjuKf2PEHT5flXI3mTzLI/fq36Ppvae6cIy2zKhU?=
 =?us-ascii?Q?ny2qeM3+djNMTxqz9giGUr1f6rQxrvEBsi9wkH2xvz+zGzUf6AaRREb5Ynx0?=
 =?us-ascii?Q?jJzqXvaX6cBIxIlb9CJmAU4/VZk6sNI+j3Hr1wD1C+TJdGY0VZaJnX+u7ZkR?=
 =?us-ascii?Q?3TuMnm8NFQQ6l932IG5vj9mPhDKTzqOaj3evt4R8/gOJkObNZ4T1cfMrtPuD?=
 =?us-ascii?Q?oKsgp1k+4xN6jltbDlQVtklwfj7blVzUQ1GKcRHXFHvQI6+jVdRbCOssMtmF?=
 =?us-ascii?Q?lz0j9CoHKg9zob56Y+KWDyVd97Qpa7mDiTVfcga/JWNGmJs9ww3OAwicNbg7?=
 =?us-ascii?Q?/rgI4vItyJTfDwGCYS1vQWc0PnC8zySx6hS3LD0yECmSCiNVoA6FiVNCqczO?=
 =?us-ascii?Q?3nCIN5OZIBOdISbS8bUD1CSO0ruLaPPQ+xXUD11360pZXmS1ScKnFVLkDuvk?=
 =?us-ascii?Q?0+kVuU1WAFBvzJmEX2zuHeuv6Fb08MgQcozSkpZpoB/6HhiRdLuRM2S/PF7W?=
 =?us-ascii?Q?gl2of3ZDESUED1eVsHfr39mf/JT3kWgvpQuBR7xyn+ULveuMWHg1XwxVyc5P?=
 =?us-ascii?Q?Ykb3d5x5rCkCG22pr//xFYzHBQ+fxitg+RmXjySw6ospsNZgbG+N7ThwNRbv?=
 =?us-ascii?Q?Qh/nYi/lx1OasDqGpWYN85Nn1ElUaWuP/LEJm4Oa/MzGlGV639sZ3xmW2Ct+?=
 =?us-ascii?Q?H/5y+y8g7mDZnifQKKvAXnKNkO0YdhUSpsMy2WbDp7X5BgCxE0fSse+tcB0u?=
 =?us-ascii?Q?dEwPHc9ouoz9mryxQw6MS9d9Kd59F0eteJ1x65B4x+/CWuPJguRUuFDK/q04?=
 =?us-ascii?Q?MtpYdFemF//06RsTiPh6+Ojw6mR0JZEmMj5B7hlIiyP9Z6FTlNGyOaFpY0H7?=
 =?us-ascii?Q?QOJHSgU8+BtZX6F1XE8Z585cnqL8/F7NVIK5neFQ8IqYEW85tIzme7rR6u4Y?=
 =?us-ascii?Q?2CXTJU7HBHz7d0PFmgd4E4RNeUud6uTW8M4uOjHc5JXcUytRj9j7fE4vD7lq?=
 =?us-ascii?Q?gdt3HANm+pFMvf0nhEz/3coQr7y2XZ81tcEVvGLL0jJLNOk0QdDmjM4HJVD1?=
 =?us-ascii?Q?NhGV7q52/SqQCxJlDoWar5XODOzj5igUpek6zQye9r8NxuAT+sA1nOkKnCq0?=
 =?us-ascii?Q?R3clPqI8xTpv1E9sLjb+bVb1+DeTNUo5Gft1/8o9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OBtaObcD8+A4NFvkDdC2qpdFlrS2sLg5A4OV7g0oUv2sTqx3PHsGpDnr+p0G?=
 =?us-ascii?Q?GQsbAqPpifWndcDEpACK0uzIpCbDNppoRlWLt+wXb3iT0r7Iq4g6kw+Yf5Kc?=
 =?us-ascii?Q?LQcs5xzie8gGAAcICtx2OS9hXhkLHLorrPaApSSQ53Xew7uzRveIZmxeruyO?=
 =?us-ascii?Q?TXWQoS+xMZ3P1W4DDa41iuOkR+G9I6hyWh4A2aHZaBPNrxY+Lg5s9DfBX70U?=
 =?us-ascii?Q?Bccm8HsOiBuLzbt+gox7nwg3BpZn3zfFwXMicXdvoIrFYy3q9YM/nJ1EfGl2?=
 =?us-ascii?Q?5dCGjlU+wMhnucWBJ+qvqVykE5xzjhIjAbD1DgNKHjxfEyZxe61bJUfPiRfF?=
 =?us-ascii?Q?wf23aKI1vldRepbOgKABcjVISULYY472qAxGMQUrQPs1AEF5WWefpYHh/R6t?=
 =?us-ascii?Q?i4g1BzUG3iSJYmhT83zaixzRhW7h245JtMqDonVr5w4ZpENHFPRy7H1muCUf?=
 =?us-ascii?Q?yIj185cNV+WxvvYyvvv6zcWpWUXAmBTJjhnA8qyhhmkOaH8t4MaBf8E2k0Gj?=
 =?us-ascii?Q?/kkuFVTQGsi9Ug2hytZlz5ihZS8vvv6S/WJZSTYdWahy7KClKh4uLXa7eMOi?=
 =?us-ascii?Q?Ybd5IjtSqogL9mGOxoONyRuVYdgvSuoSBmFR4CCq1ti9xp+CJlGLMLeOqN9/?=
 =?us-ascii?Q?ulaSqPxirGuLK2rS1AuY+IQ4+i/GMN1OPaILRthGUeaqEyKgp+iZ7gel6/+9?=
 =?us-ascii?Q?IYQRVBwi80AVcVZE0keF5oq2wAOQWOj9KmDTvUFb5VLAsZi4446NyxdMhd5g?=
 =?us-ascii?Q?HqufhqoAxe1cgWgo0dMCNqkh2fjM3Pv7Q0uZciH+wUfSFKQVk/c8JhBq7d2e?=
 =?us-ascii?Q?dCPjPrvLXGcVKkYnOFP2iga6SWECacbKawQA+TuhVsKjdVlB1GoivkRk942m?=
 =?us-ascii?Q?GYRhGtWzxuJp8rabM2FrirJaXMAuL9Lfz1fqpLilVSgP/vZbQWpEriqIr/yV?=
 =?us-ascii?Q?7Rfj26cTYDkwZbTPRM5J9bSbf+fe7qBeCmISuDf07IgIH98VFRL3ZDUdFAGm?=
 =?us-ascii?Q?0qcVR9wojviin1BKB6I6tqni+Wc3BS/uMIOw8XgL/0za2tYlwXU4sRpQz4Z1?=
 =?us-ascii?Q?mK8Rxt+21P2rq61KzrbVM8dYowm+oLndO8hHk7Al3sUbiTE1xm0rMqkQ4PVu?=
 =?us-ascii?Q?KiqPtGNI+1qmmuVc1GdE+zC5P8YfUuoIgR6vfv1t8loLNd6o1FNgvsdrfk1D?=
 =?us-ascii?Q?+KRUmkrGOb23+5ENeyKWgqAUyEazuLmJ0UbCsUjbD+d04c37oSjnl4VHM5XP?=
 =?us-ascii?Q?eXTTjLBVwG6ypadz9TmEJS718PCtKeuEygKKTIM9tA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9fd6a4-65e1-439a-daee-08dacc796f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 11:05:15.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXeLqR+gWyaAJHluBw8tB+N69mH8HlFAnfEytM28DvCYE3WRN5SxDq5Ts/lzsJV8lYmXh3Elhn0di0GXa2xCKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5602
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +               sg_cnt =3D dma_map_sg(hba->host->dma_dev, payload->sg_lis=
t,
> payload->sg_cnt, dir);
> +               if (unlikely(!sg_cnt))
> +                       return -ENOMEM;
> +               sg_list =3D payload->sg_list;
> +               data_len =3D payload->payload_len;
> +       }
Isn't bsg_map_buffer does that for you already?
For both request & reply?

Thanks,
Avri
