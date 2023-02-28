Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72656A53A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjB1H2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1H2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:28:40 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F386BF;
        Mon, 27 Feb 2023 23:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677569319; x=1709105319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P6pNk1EkL8uvHNoLiZGgafIfSjYSW4tDJqA+r2DsbwA=;
  b=azyL7LnaLVrDaisyo74jS+U3Itjc2AE4k+Ev2c4utoxHSQlwq5GvlA9n
   iqakjrpM92iCdIIE4w4t3jX2ZvPdzafVM0/dgPnexTb/GS/TyZ4vjNIv8
   7WJuJN7oDntY73WO5P5EBjAnxh7LkbmibSU4PGn+TkTaLL7yioyQsZMp9
   S/8FCsB9emhfSdyk5LS6p+6W+JBhxuTw4ZVbmLvJsxvoJb8jLKzIFRZ+2
   FcsLcIvJZNzi745kDQojWButNcb5b1GQOgGG060KSxZmZoKREu4JRD1xA
   6W60stznLa6jxddpgoJp6K+45NB94suJtro1R99YFAwXDoAiA8WDv3BBf
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673884800"; 
   d="scan'208";a="229356979"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 15:28:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzGF3AoQ7ANCvLnZgcqJSw+99IxC47BXIJXamh/zcJnLzPpd/TMYUiUoAE9Op0OF5jOXQ2saKYUEorZeOdH4cOc6QMOpIqWUw6OCRESg8EguxpWIYTAGOQOgdrQo3qCyMqZUdV8HWxazYPsDFsTzYfUG1ERwml85099GVjXkVW48BTeArjtywT63cjf9VJRzfa7MPID6uRf7sbe0klP4dfOQZP1nBHdtXYJ4s+LM1dd7WIE3f7Kgw/V+ElcWeAyvonPFo3T0aHWbBw54llSfe8+btSua7Q7e8ipRV1I4+62ankzxzQ/DD/P5WgCgxwoTTUpRxILg3o+iwnDwmeO6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZw0LgdC6tyro/6pKlsgldbeJpwmMkkthAZSfzkIE20=;
 b=JRFJBpxQXtCZfMZ0j+YitqyBBhCAuu2s6wQs0H+acmZG+/AzP7zTuasjVMTG6sZDeSjxRmY0V98glvXt902IqNi/9AK4qDEldYhE1R5/NpH7mBomleaD3FTfzLAkaF3/qXJ7/xeUx6q9LGqRWSnYLcL6TwjY6o6rBlSmHR0hbyOHZePiIrnXuwx+HHE1Fg5iK+LvL/sXh0lROAzhxnpKB/ji1kSwLgGhQcZl93fxU1G/a05/atUfJerA63Xp5W2iXyywzV6UrwFTuIFzNooazKAFzh27IcxMoeYdMJelucrE7AVrKNOyo7Eu9o+eX19kDRyHeFY8bsq0fKjrlRtq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZw0LgdC6tyro/6pKlsgldbeJpwmMkkthAZSfzkIE20=;
 b=NoJQPQduS4SBL7yrhsA0RXXOHPnXVY3TER60dQkf4osn+QVA18eNL9tBnvsrsQW1j6Aw++W4BN3mf9kzON/xDx2fTQF4cB0h+6RxFox78xR7SASatPUqNY+oIpePpu5H/6AVjsi3jJXA5DgjEMas8fYRcNSQGum7n4golHhSMoc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7845.namprd04.prod.outlook.com (2603:10b6:8:33::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Tue, 28 Feb 2023 07:28:35 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%5]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 07:28:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: RE: [PATCH] scsi: ufs: support IO traces for zoned block device
Thread-Topic: [PATCH] scsi: ufs: support IO traces for zoned block device
Thread-Index: AQHZQXBsGby1i9hcaku76rZBxiJwZa7RFW+AgBJqjYCAAIlRUA==
Date:   Tue, 28 Feb 2023 07:28:35 +0000
Message-ID: <DM6PR04MB65751899638206110D3D8FC2FCAC9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230215190448.1687786-1-jaegeuk@kernel.org>
 <Y+3GzX6yMOKUFTh3@infradead.org> <Y/05p0jYrg2wfXw6@google.com>
In-Reply-To: <Y/05p0jYrg2wfXw6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7845:EE_
x-ms-office365-filtering-correlation-id: 454a75a3-db2c-46fe-68d8-08db195d673e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOIvo9fQJJDgoCnbn4r4HEIvObZ4d4k2bodrv4uXfxAWUtA0DTe23AA+4LiHtc0XMbjsxgfl6EqCetTVXD/dm2Mx0yN8PwyuIeuYoSe1csPwlse7VqGm+eXpKrDtBgMX1wyVP7KB6mkCIvffRmfujRA6BbjQQnX34MIGT9ft+++9SxxfTtZPZzlw5mrD16VVht9UNbJeefr4hmhPuqNgQXzWw/J1qXE87p/LruWCH0yRZNv7/EdQGghwm2fPgl9HIaNs8ThRqFbBc+qQp2bIstfDd32QB91jwRr6BSv9vIHvtHHhzWJt6BaMh3M9CnD5QC/KUGKuEMCIDEYcIUQLaxIxtE9X403sni9CfkR/qLKSgX56Gr2MSddHBfDZrZ/qexU8TzMDTpN3E+h7BXCrT3Pjnz9PpPS7fPfp6DBxVFRMyqlPOgEMd3TLreBxjyNcLPx+OHZ9AdVRRtfU46MsjGSfiGFowwmuiu462M1ipetc7uLkk99PBKiYDh4guMTVHCVeg8p9QPB/lNWj0h9WLCFnAjjLOu7gIQWsR7mIaE1DJ7TpT7qcjhnxKm9Mes8/E1nqKjlouoROZWwKhYNwHOLU8vQW+MGCg/ToBZQEEGTLe2MeA9hYq/0wnKhWcsVVB49xQmMeSHHoheGuas+udZNwrxFPw96WvMfcI6wthFFPAXM6RccFZx6QG/gJkXV0M2Aurl6BkwwrgSsECn8liA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199018)(33656002)(54906003)(316002)(110136005)(82960400001)(7696005)(71200400001)(26005)(9686003)(186003)(41300700001)(52536014)(2906002)(5660300002)(86362001)(478600001)(38070700005)(76116006)(7416002)(66476007)(4744005)(66556008)(66946007)(8936002)(66446008)(55016003)(38100700002)(8676002)(64756008)(4326008)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Tlq29gPFHd3zu9XsRagK9I/F0QpU1RgC9qaaeinhnS8GHJ5KD8vbaKUSZD3?=
 =?us-ascii?Q?Gc7XnNrOAIarYkqsddmBFfx8gJaYe3f9Ra4ucFg17r0LW6TETtp9T1EuqyBg?=
 =?us-ascii?Q?IwPTmhkg9aBabQiO2BNg7uBT2BgwjP3ujwgKPgTPQvhHcfx6KE9gzSueBETO?=
 =?us-ascii?Q?gxxS8KT1N5jbbRDUnmOK5t0nDm69Aj+kyPjQ6MwQmm/A4pW9hJpi6qpWqnLi?=
 =?us-ascii?Q?xpJNA84O/iAkn1x+aP2Wr7+hTRFeytlhj2qg55CoiDv0esCggcZHbMkxMZKH?=
 =?us-ascii?Q?l/akQOWkrBkd9i2Yc7jgEBGDrzKOH4Mp7yk1MRHZQ/Z7Jn4mBy5FKN3Jx3oh?=
 =?us-ascii?Q?UZk2hmb4zjyRdIS56+i7YVKpeh6isgFvMKhkDR47VuDppn+PYgWnd7GRfpDQ?=
 =?us-ascii?Q?TTUvGxtfElAq2E9+FJY8UAvO35nRiTj4TGynmO0NhLZodXSYzm0wh8JalKqI?=
 =?us-ascii?Q?HPxEeqF71UlJj6/J/EcAYue8Y4gy7LaK43HsUd3XLjOXao+apJtexkZnNYde?=
 =?us-ascii?Q?JqToZmPe6G7RUwqpMxRbwt6E+eKELN+UBy1sfgow+FdZE2BPBdk0BfYuQtew?=
 =?us-ascii?Q?2nK5Q1cfIffK8zdVussiJUGMUkBp391IYq14320gDuDbvnWp16XhYlz0jwKw?=
 =?us-ascii?Q?h67hcCowEsoV4DwvyLmpMXOC7C/J/C7Rwy3/t73oyqUDs9B4CXRFYxvXsXA5?=
 =?us-ascii?Q?ETo9vg0JmDyCQnLZdHDqMhsoJ1rVlSL4jBF/2J/3Nvj7iJU26HVlj5/+nJLX?=
 =?us-ascii?Q?GZTubkRCleHfgzKHro3+Og84ew2lJa3WVTypy0kwzb/6w5+nUMYr3pmANzfu?=
 =?us-ascii?Q?AbcUsLI67iQDTUy2HP0aAhwD7ML62Dcibt8cqexLbJdN0GyO5+5IZGA3PDfJ?=
 =?us-ascii?Q?kLeJYJUYvv/bv4HMgw8FdYh6GZpa75S+c/UWRXRuFNVqJd63QM+wK0FyvnzQ?=
 =?us-ascii?Q?ynkWnIGJ+fWdj8INbg8G1S3p7TE7TiNpdzrlS++JvTXYdA2pzYWn1atDKrK+?=
 =?us-ascii?Q?A0zflXE+LuF4FmbG7Laux9eP0inZ3Av/UmGKqV4Fk5M5rS4V4SEiLlC8c2Ga?=
 =?us-ascii?Q?Js9uqSf9N61vkLTrlylsGSofkPPn7hpz/szzM210PIFz1hwd2P6D5/Tml+xw?=
 =?us-ascii?Q?WijSdWpEna3FFtj6xr2kGV4tYTUzg6G6L2n4O7bHYS40OC55SHe09hSYOoEA?=
 =?us-ascii?Q?p9mMh6mEMerR/a+GtJ8ibQxAO2nszUhY0n20Di6+yj+ThdWv5t6R0tfs005J?=
 =?us-ascii?Q?f1BOhFuTiUcJVviJWVpWq3t5vTJI2ujwvEOgdYrDpJ7NLYUkZPPiIy62zK3h?=
 =?us-ascii?Q?yuxKYd/akJ/p6Mktzx/3aj/8hTXMTNt8OrIKGjmyc71t+IFApkdhTuQ7lxIf?=
 =?us-ascii?Q?sieXXElwW+35ui9p8wjjhEh5/Lptp7K5oK9QRBOhfVTTSHVCqVFouNjHODBB?=
 =?us-ascii?Q?cOqoSi/2RZIX38T/DfsYXSFbQWgf3COqym0ChKQO2Ho11i0UjvY6vqljWsp7?=
 =?us-ascii?Q?uJcbhTYhxKCAaUWHxnwVjZqyppsIZHvZdSUvoXvy2VRt1ubQmnMEQw+MmzUl?=
 =?us-ascii?Q?/MDefqxssKetNxgPxWuCMyqiA1QAz16gGsGsnYPR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KOX25gkx8a6aOtDVmOJ9806m2AeT2/ZKu+wUcxd/ndtV9VBb9aBsvFoXniTW?=
 =?us-ascii?Q?MZWLoy18FjdW0OqppURZvkgk5yU1EE+F3+yRmkZFl7Cq9h0TP/7/hRnvBdAf?=
 =?us-ascii?Q?08vpjiwdsBz9uTBkAnHyvIQLrq3EcN5HAVvQVmsUEskXZ+kMfFqp/x8OhsPr?=
 =?us-ascii?Q?YXHQO6uyAcwjGdb3qgURNTt0PPd/66wNg4hQpHeAOOag0bqwb0UMLrf/Zgfw?=
 =?us-ascii?Q?vP2g2Pmo3RvzrVH1u2JfHBdO1Tqb8xgPdnklu//Dks6sCAM85xyWaaROrVrG?=
 =?us-ascii?Q?H/2WWSa01VKBRddXju2id/1eWTPDaP4FxKfVo+/ZUapE5ey4vrTeuY/9szvJ?=
 =?us-ascii?Q?c7SiVgPjkh1LsZ9WD63utUEiFtbWq8Uxgh3a5uct5nmDD13v+HH9gzR0BbSW?=
 =?us-ascii?Q?qRbhWaJkT02KuiaKwz/gpWs1FBXTMfqloNEOkw/Yt64D+uIaPLJmzxUSiCL8?=
 =?us-ascii?Q?iN8q/CRnye6eD7vr3/AcEk7C0oX+Bc0NVCHYz4eoJML71pFqZ3TmvPqbcg0V?=
 =?us-ascii?Q?AUqm5o7x8ObPiM3NEmMEfbl8hHDaU5I0yUmQMxZ79WdXMloAuH1e++mANn2Z?=
 =?us-ascii?Q?hcTylRQLA1I65M1otsGDfvLs2LcPHLFm97Pn921JcP458tzeTvScJVa4+Cxx?=
 =?us-ascii?Q?9ny4IDaNHgceJmvAxwMjgjlc/bTup3Ys3XU5W7I/grwtUeGMWnuX/FC6yPz5?=
 =?us-ascii?Q?haItFGS0wSkWR4OGkrwKI5bmwBYA9/l5w6I5VF5llaMTxHvFr/Ej1+91ZTBt?=
 =?us-ascii?Q?7nLNudyTM26niD9QgPOAW/HMRR2kZMZc4vuVTbZSZtmMVYNAdhvYmhQqqZiO?=
 =?us-ascii?Q?f/Y6zWAT/zy1TvYFCM7JHP9dH5j0ZflkNbE64YpNHKhgRLbKpbrGyJC0FKWr?=
 =?us-ascii?Q?j2HqZhAzvQIrh7/bm6yklx/Jwbxa+hxREmnziZixUjRqYxhiTRe0g9AKQeA+?=
 =?us-ascii?Q?HqO+Azjjkh2Ic0nQhrohSr4lUQBiJ8pgaT9ExKsBog8tle3mJrQ264VUstFx?=
 =?us-ascii?Q?9t1oh6OSJKgpdcfcZMr1yWmV1A=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454a75a3-db2c-46fe-68d8-08db195d673e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 07:28:35.7697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rbygri/MCIMq9I589HHQM7pXW3tN7UQ/pM/uxo6cPMEwR5/O6pG9oRhkWcmgKVZb+exkCa+yZoUtaVthlf9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7845
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> On 02/15, Christoph Hellwig wrote:
> > Why does UFS even have it's own common tracing instad of just relying
> > on the core SCSI one, and even worse pokes into command set specifics
> > which is a no-go for LLDDs.  This code simply needs to go away instead
> > of beeing "enhanced".
>=20
> I'm not sure how all the other vendors use the trace tho, at least to me,=
 it's
> quite useful when debugging any UFS-specific information such as group_id=
 and
> doorbell status along with the attached scsi command, in addition to the
> accurate latency measurements.
For us as well.
Moreover, we are mainly using upiu tracing which is not available at scsi M=
L.

Thanks,
Avri
