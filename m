Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2D6F6932
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjEDKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDKj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:39:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B387113;
        Thu,  4 May 2023 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683196796; x=1714732796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m1ExNh40i1I70WRU27P6jlMOEygGrsany3x/xE/Sz8Q=;
  b=SP0q8UNbotgsrk/c0iCviuYndro8tK2tWkFJw9AjqpMD/ls/gRg969KE
   MUmX/AVVzcja+EnJrY5XzxSTarwsdbEQ0RvNAUc4kv3360wqOa0wUom6j
   XCmnXTMSIX1ruNtvNYmeiwOpCFAYM4naNdisoIh1X0VoyORe67IgphIAN
   5UKU+FgA1xL5t7jVXEZ6hyxNjoBJJxxlV5iusbCcq2LrWRyjcAmaIeN63
   g9X5fgzXup4HhYO3wXMygjzoAYIBkg/oRiElFO51Usih1zpOVv1vfw8MJ
   Ko3R1VX/Z/K8ocZflchPU7xkWQ/X4hPU4F+u1WtG5jf+2/6HjSM4yQ1iD
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677513600"; 
   d="scan'208";a="228077183"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2023 18:39:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0ZsayyBgQTp02IzGh4AYFbSbtY0Y85fPC6wlAj9gpFfWbD+sWcKiqWtyce2OeCtvqc6uJMXNrdsBXAln8K1zQ654yixdpeSiSrTtk/+yTmQToak1wR+AGIAnNIJ66/hFCy3JzuoNFzz5LUX7qEXP1K6HDXo7Io9aCH9c0BSF2nkB02/pFpYdneSr6Pi6syZh0Oor3hIzjN2mQFi41JnIMqn9ySCt2Ik64InRsBZZF6pYjNA8WG1t14oPasfYLjcQ2mPJ8iCcl+fcJtpPm46/Ar/kxZG7chU7ZO+qvCcfFej/3e9/kENXacPE8pcjh8pB/BOjOPGLH57vgwljij1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlYF2gpvSzLWHrIzvpzGWln9XPQxPYAXPuiHT3dD654=;
 b=KH72L7KVutnIBMtchJOpg9Pn5Erz+Ac1bfod8EogJB3cX/lvyIGXjB7v+hTYCapawpfSgf4IWOQph5uFSFNVb5e2q96SEthEhv3O8koOilW2lH/Lj5OlpA06cqrHIVstwbe20Fug79fEmLB4nfyK4zSG1JYk3cnaGxX0/ULiQSWY2oSczUZ9S9DhPMj7TCwUKzbC4aXLLNWL3sLPzg/ITPZTqhTJ4qXVKxS6o4L9s+xd8szHCURpXvhe1OBEYH5wxOKm/b/CqtGBmse2aDzuOLciygazofTlf2uLGrhF8U1rnNzLfbnuKsNwYE6sMAaJpLZjHNFk66yzaP+bIoTTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlYF2gpvSzLWHrIzvpzGWln9XPQxPYAXPuiHT3dD654=;
 b=jRXyqAVVwPunr2uzH2cH5C4dXAMIA3Qp9P/c1SKURhLkqBPwa9F3fTHjsbly+lhltKIEOZaSebcLDKa/Ox1UUlWFdDxzYM6w7/tvEqR+TNruHj0fC+TCR+1x5OJ7i0OKjdp5qOwviiTEvj+gjhdfKKxLX49X+xqc4n+UtwC4rpk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB8450.namprd04.prod.outlook.com (2603:10b6:510:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Thu, 4 May
 2023 10:39:52 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 10:39:52 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
Thread-Topic: [GIT PULL] MM updates for 6.4-rc1
Thread-Index: AQHZfnTBccJ3T/frOUK9que0Q5zaGA==
Date:   Thu, 4 May 2023 10:39:51 +0000
Message-ID: <ZFOLdr2CssE4O7+L@x1-carbon>
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
In-Reply-To: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB8450:EE_
x-ms-office365-filtering-correlation-id: 7e59a0ce-20dc-45df-b6e0-08db4c8be477
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9U1fgdfYk6nKeOjk9zmDoKdASjifIhRHZVpReP3HQajsgFSb01ReQ52Gkv4OuuvJ3k/RrWyd00xEVIuEkTzWego9Aqqh5pTNMGoW9GgBpUJx5mKLRxSGBC5pNhVE4grxfPJqGQxTp19rpunVu1jwx46fSBtCDJOF0XZL1iHf6cl0WWmZ7YigKeMhDTH1sLzGzA/hExJpDMg26uzTpGhf47p9zOFfNuhHxD1mFTTUoZY8FSDeMG0RtRBIVSZAP1p8Yv3OEDynD0TRDuAGupthcNo4mpPBkx41IH82PWqCaoEQCTukhUPash+6y2x0+sn07jmLORpehbFDzhAcH5eH+joVhbNHF5ZuahbmnCHCndArMCnsA0VH4fods4F1fbAxPpeXZoTG67XSMiX5D9amjwFVA/KnrnZDlAeFClyYc1lHwK8q9ky8AUjXgF37wG4kV+CceNCJ8fW9uDsVsFzO2hOxzLwYsOU8TkvqoowIHoud3LJoBBCntLx0b8c4NctBx0PRhdiJzk3vLki8XU3yJ9kY9hX5STc8uaQpq2YRL+HOeQ1iIvBYAK4PmdIi6uPWHaqfD0jurrZ1bS3hm6B2kxOxLYgyvW1WHexzzR6WskJWGhA1jnl+1qGHdIHqrJG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(6512007)(82960400001)(9686003)(6506007)(122000001)(26005)(38100700002)(38070700005)(71200400001)(6486002)(966005)(83380400001)(33716001)(2906002)(64756008)(91956017)(8936002)(76116006)(86362001)(66446008)(5660300002)(54906003)(6916009)(41300700001)(478600001)(4326008)(66476007)(66556008)(66946007)(316002)(8676002)(186003)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o4zTcHw+tlSV9KMdA5SxPmfNSitybcmRndRjVCTSvVjF0IATYIJcSUpnCZN+?=
 =?us-ascii?Q?JVS5KCVd6SSiz66F1gSF71WH0Lm3shkXBWXia4BTWXvSHKSNEPDGVv7YeSZt?=
 =?us-ascii?Q?eCVcljhlLCpIOjH4hoAOcbpRsOub3W2486DweDLZtHTgTW5OVDgKkel0d/mQ?=
 =?us-ascii?Q?SXEncP3ccrF/mTcgElCOBJnzPqYgN+ofYSEMoH5YEpjnRRXtR7XSK4UlRJ1U?=
 =?us-ascii?Q?BLueQDUvLs9dSLnLc4b6qPT9CaB3D7fodBQLiS+F+G5zcZtjhssICL2FyU0X?=
 =?us-ascii?Q?017FFy7sw6CKSLPSUbwLKV0ZtQ3xM5TKB1Yl6oXb8rKYby/Nz52hHWSSSdd8?=
 =?us-ascii?Q?XhMaGRT1/n+P2pBZrJAuQZLn3RF+IF+oNyQorpuEdMgFw98G469J3E0aY5V+?=
 =?us-ascii?Q?wq1URvpJAFhhFhvIFyHbs155jm6C9cAQSQLgKwS0xR/VUG8bqbD/Il8/YvNC?=
 =?us-ascii?Q?OrKlhfyQYwmeKtALP4kOvJnuLjpsDCd+4QcBnYsBKS5Lwinv3s/vliIlJ/Bp?=
 =?us-ascii?Q?n/2cLMPeJjuGTeheBLsGCbMWBjQQKdEN3DQRo2Mbac5H+e4lroM2HPGogff7?=
 =?us-ascii?Q?Wdp+gBkq5uqnsTEuBSTGL6WzLEvAtnVD5SEYA5ET1G7ZiRGZAmJ3rUkIS8wd?=
 =?us-ascii?Q?yNc2um7wCDUVbs7wBLD0ZQaEst50AwhW97Va8T8wDnp999NYwZdj0D8Ji3pU?=
 =?us-ascii?Q?vDYjYjRL2ILPFr1NopoTAfpDa7AkQT/uX8S0pYJbRoZn6AhJN5YR2T34ZVCv?=
 =?us-ascii?Q?SvRX/5QYoo1SiJIiFoWXoxJDQsXPWJu6SRqWfMYCuY8eU+6Nwl0CU112oTYv?=
 =?us-ascii?Q?iBc9oCF6lKsT6SZzi/wJWC+0/zFoEA7XLaPu/xXd3lYQVChYCA7U/m1geueJ?=
 =?us-ascii?Q?hVKBgVYh9xrcFUHc9ydBfOiz5/0svH8QOPpV+s+B8oD04zrQ1157/F9NXGZi?=
 =?us-ascii?Q?zdKQySe9rD1Gpa6vbQ68LArMlaFVLxjymqJqySPB4l341Tp+073q69OgfMSr?=
 =?us-ascii?Q?bVhDDhGI8C1VqCQqEPe46bJedjOjKXX4KEawyGa98qLevwJBlmclGN3uYJKv?=
 =?us-ascii?Q?1q33FP/wnpHJN66mDC4F7EnQ5mhP1vrKUpZJyjssKCz02Y2zjqx5G55nCpNF?=
 =?us-ascii?Q?OfCRvAwRaJz2cPNNfaylk+d/9YN3QjdHrZ0gvjFqzGrAkqBNOxshYyBLeeF8?=
 =?us-ascii?Q?x/Yz6Ucqvegq0hCa/PnMMlpzlQqAl91+9AeeIXRmVBIS2JVB7q2PVFfxhjmJ?=
 =?us-ascii?Q?O8k8drE9ZXPKrGjOOjzbXLDs8P4LHN0g4DXqDwtz4Jz3pCF/Y57rYz5DRW0V?=
 =?us-ascii?Q?/e5bD4/TNzZsrnx5ibLji6GXUIxIk2mTHS4drpCCY6fyxcoF+ag3JHt0mXUo?=
 =?us-ascii?Q?L/Uq8kdwlbKHESSYOzAB4kYFwPGqYRFOMA3Tgq3VnKLuuEX81D5m9HUAk74S?=
 =?us-ascii?Q?JkWRDuxDkMQ+QFXZNjDQmcU9m3SHHkpkhbf6UKXUR3l1zNaE4ssx3nyn/Iuc?=
 =?us-ascii?Q?pnRQWydaMMNzWABf95yJ79onhqugvHdUdJaqAFeT+gPvcKLGsNrHLPJhBa4j?=
 =?us-ascii?Q?m8injDGKKlIspDxeEnB+3QRwnIZsS+iAcuJfMfganw3btDUXKr7iLi8d4/uC?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9BE9F45239A904E8DB128D415F3CC3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mXm0UZIMmxKatJws/H6pakM5UgYGRIqVFQm1Gk5zJw9n9MprY+qPveSnlIis?=
 =?us-ascii?Q?SV9Ov9xRy+1KPP3pxU/YMftR+8GxOv80Iee07mnSEjeMolzoUfRg2BoGqtm6?=
 =?us-ascii?Q?caqdlp1aodijOkHmjkfSWTpn7r8N9Ss4hVT5Gn1xtuPEZ90PZVMFK1gqHVRE?=
 =?us-ascii?Q?0fU8DXPnXTTfzJtoHTgyYxFTpidlmNkRb+e1tqnTZYPdhD3dTvGl/wZ9cjh5?=
 =?us-ascii?Q?DKd2bEhrUFmmMkJr+nOpsU5hJgzCAjJ+q/aY0javXH+qaPkV46bN33Yuant0?=
 =?us-ascii?Q?Qo4YFIVt8fXRqvPw8uoChIWH1QpJMF4vghwS/f8/spGKYjOcvWcQbUj6jyAS?=
 =?us-ascii?Q?wAoK/KbWdI8emQ+R6ZCiplSoTGTsMlgp6Ahy6Ygab+bsD/CJhOSLPM63QLlU?=
 =?us-ascii?Q?1zopDPhVpTnNWm6JUXNvNVDjibW8vodfTjNDC7Jx5YxsvlspQiBj/0k8yp8R?=
 =?us-ascii?Q?n4uKrsFgAq1Asq23G/aMMpO5j2lIZXyMMVBvKGJjzLDhgywEVTx8Iikqd+PH?=
 =?us-ascii?Q?w7TvhYhB3igMx3lXWR020unfO4dhYWwwFVjANusiXf8Vh/n/dg62r46X6Z99?=
 =?us-ascii?Q?tZuQzweWGN+BalWluMtkbVt6SLC//gYBRQOP8xuwwLEGk7Ya75Wi2szEZ9ek?=
 =?us-ascii?Q?yCKUJS4+BJFy3PCkUZEOzzxkwwfjG8JCuEMx0xZ0cqHd/hH6d1yPGtAOQeiG?=
 =?us-ascii?Q?/RSnpwTR/baswV9OCAQy0Fd4Jsw9cjAE+VL9hM1VzqfJOSAUrAdgFU4DeOqd?=
 =?us-ascii?Q?zEebQ3bnlmRWiu3AIDBR9s8okiUkXEYJIE0qHi79shy+MQvYKAX7o3RZevMS?=
 =?us-ascii?Q?CBV/bLlNX4iBA2vr0EXpTyNwRoqSTO67OJMCzfD7JLRXxqA1FjYB4/4OZZjK?=
 =?us-ascii?Q?DHVEExhMh/YXWMrL8TqpA3lB7KE10fSNzYCH4tzajMp/QTPCcC7+yYXksMnA?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e59a0ce-20dc-45df-b6e0-08db4c8be477
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 10:39:52.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wes7PRWNJYTgKy4NB1tHxumEiUGjxS4xg8/lXaVOU2lRUI/ubGJWU6VqTf6kEm0SuLjWB4grm1S3Kdu4eScCpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8450
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 03:33:45PM -0700, Andrew Morton wrote:
>=20
> Linus, please merge this cycles's batch of MM changes.  This is almost
> everything - I'll have another 5-10 patches next week.

(cut)

> The following changes since commit ef832747a82dfbc22a3702219cc716f449b24e=
4a:
>=20
>   nilfs2: initialize unused bytes in segment summary blocks (2023-04-18 1=
4:22:14 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-20=
23-04-27-15-30
>=20
> for you to fetch changes up to 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1:
>=20
>   mm,unmap: avoid flushing TLB in batch if PTE is inaccessible (2023-04-2=
7 13:42:16 -0700)
>=20
> ----------------------------------------------------------------

Hello Andrew,

It seems like the changes in mm/dmapool.c somehow got omitted in this PR.

$ git log --oneline 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1 --not v6.3 mm/=
dmapool.c
2d55c16c0c54 dmapool: create/destroy cleanup
a4de12a032fa dmapool: link blocks across pages
9d062a8a4c6d dmapool: don't memset on free twice
887aef615818 dmapool: simplify freeing
2591b516533b dmapool: consolidate page initialization
36d1a28921a4 dmapool: rearrange page alloc failure handling
52e7d5653979 dmapool: move debug code to own functions
19f504584038 dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
347e4e44c0a9 dmapool: cleanup integer types
65216545436b dmapool: use sysfs_emit() instead of scnprintf()
7f796d141c07 dmapool: remove checks for dev =3D=3D NULL

$ git diff 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1 v6.3 mm/dmapool.c
<empty>

It seems like the final commit, 2d55c16c0c54 ("dmapool: create/destroy
cleanup") somehow reverted all the previous changes to this file.


Looking at how that patch looked like on the list:
https://patchwork.kernel.org/project/linux-mm/patch/20230126215125.4069751-=
13-kbusch@meta.com/
the diff is way smaller than what can be seen in 2d55c16c0c54.

Additionally, you might want to pick up:
https://patchwork.kernel.org/project/linux-mm/patch/20230221165400.1595247-=
1-kbusch@meta.com/
as it has a Fixes tag that references one of the commits above.


Kind regards,
Niklas=
