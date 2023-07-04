Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0045746A52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGDHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:09:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE18130;
        Tue,  4 Jul 2023 00:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688454541; x=1719990541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gn6l+YTWwpzjn+wgWH/xoEz0O48PPp2LR6x25VCFYNs=;
  b=KxKQC+kh+gk+Y/0qOoDWSb2RJYL+1dpdz4BXja0/5HMf8pAIIZF5bnh+
   ICbjD2KhOo/XDEU4BT4Wj0a/H9C12D+RdY8wXxTSNBUrlhwDKw+J87K0X
   W2PMZRRB3DRoNrTkeYxOgl5lEuM2QUsdkG/bDYDXsble6iGuy7HJJMlOa
   UBSn1ISg8JW32QMjfKaq4lYn5B31SR8jdJZQYWbTBxolOuodedsT599Wl
   YGgTpoYKxl3IGN0M7+my0laEJ2s5kl/dupDEcqlrVmTRACxXap1PWJcbf
   N0VqHwyxM54N6AOW7Rm/EdKQHz0wEnSeNFSahI2BSIzSYWTZcmswuy7Qt
   g==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="241829603"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 15:09:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDtES6mq5TKmsn/czOPxJTo2Hs5o1eU86eCiS1pU6FIoD5MjpspcHOqWvhcsxKF7d1nSSHi/TaWn1mRhbbGILBKU/uu/zXUIPz8onWWmohx265jE5N6tfHLI4J8gzJqsW6pnhFgA4FQbqp5swTSQaDT4cEZbrMk9yNmydG6TwVSrodiVYhTUAv3d4BKU+qbRmkylw5YbYg9WmcTh/duzzJwQsAx7l8PHfKj+FKIqvC1CG4OxZ4/Ep9Bh2UmgfalZOLShIH6XCFBwKA+u0hip/hTOmUoLFIcE/7tEbCja2AmM6fVK10f4yXGEl+AlcAa2ZrErqgHwSh8pdIIjOUF5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn6l+YTWwpzjn+wgWH/xoEz0O48PPp2LR6x25VCFYNs=;
 b=WMQrMenwwAdWD9Jw/8K0wiU5XfM1i5hOrUM/9LHf5xb8XTQoErKU4wozCftLVomhYVpNvyXWHVxbTN9fzDL+jCOoV1cR9v3n7UUqONevnLelFa0fix8zlu5bWHDoqJohvV2OcziGLuwmz4PBCfxeDWp8Aw/FZ3ZseCUlmDPMlMgMbQnBxISUk3+8279mxJ8CU1utMhvtwuFHcg//qilI1qgVnxJIP8ZutTLaTVHpDGO+UkiqUvVl/ClYSGC+2Rtr3K3zayphrBpDnAD9FqooogvKzFJqOiHv8y/JFmFuKv+Lxt7zdlYqxnFHHFbDRUxSTkkDKJKwwpFCK54xRqNcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn6l+YTWwpzjn+wgWH/xoEz0O48PPp2LR6x25VCFYNs=;
 b=jDda9/eM1xWpnaBU3VHHUIIUEW2uIXO9pGd2ackR07IxpxfT8NURaqwAj73KNox2Mxyiqpte8iuhlTi7UOXUs4//oJK0UsuYnsICEe4lSgiBRwzOUGJSfsq9NeT9zTDiv1nYgOKJ1LMDjrsqB8owjqLVs0ar7jQmY6kVV0mfwHc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH8PR04MB8688.namprd04.prod.outlook.com (2603:10b6:510:251::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 4 Jul
 2023 07:08:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:08:57 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3 0/3] More fixes for FC enabling
Thread-Topic: [PATCH blktests v3 0/3] More fixes for FC enabling
Thread-Index: AQHZrY8fVxswUZuTK0qCaSHq9WkXZq+pMZkA
Date:   Tue, 4 Jul 2023 07:08:57 +0000
Message-ID: <op7hkwiauywfosn4q4h3cihdzcoy4m4vqthanv4urwxo4trazy@2qtljklkt4ry>
References: <20230703091647.800-1-dwagner@suse.de>
In-Reply-To: <20230703091647.800-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH8PR04MB8688:EE_
x-ms-office365-filtering-correlation-id: 728b56b7-b217-4762-65ef-08db7c5d8923
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHw4juzKvNKxFiGnrWpl32LQzAa/F6rhr2w5RrQqpzGvwTFFsrKzJDFpJKJlebHdvc/eEtHazCmIXPS+9We1e8VbPaQaxjFi7KGiWj84xYdRp5S8L1uZpMSUYV+ElR5ucqkyLkjEhMltRdetjyBREO+avqVUV4S6fnDbLgJEthY+htRqquBznGHBRNawI18JfF46q8nJYcYhejvDXMoRzxV1PBOPPWUELaB8ECf8wkL4Bcpb4HUO6wmI3MHUUni6cpk0OgcrYrxSR++LmpFbgF9FYuXPb+QaY0ICQBOlO/uoQeVLMoamrTZJB2felk6GqQdjN0JpXcp0PQYYHqOMzxwAGWVUUY18/x8cfZSdHhpEc7yq279kxdHFhfHAzZnk2bYJrOH13D2crtnDSTciMgqxt45srgySUGUN6gPTRWQoO46Wz569rQr1SSNpg3a/l/jYl+xoalqA/BnqEgKrUJW3ViHp+rDihjFsO1ucE2ovw12atYUcIWkr7IrSyhCUvVfJcscU23Nb9JVMKoLEPcTXEvk0jSiog5jy92+vtZ9Ed0xFtFuCYwaP+8advw2s3immRPwfch6tGxGG6BRMcAYjDx7XqzX4v1yfhexzHf0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(76116006)(91956017)(71200400001)(478600001)(6486002)(54906003)(2906002)(9686003)(186003)(6512007)(4744005)(66946007)(41300700001)(33716001)(966005)(6506007)(66556008)(8936002)(8676002)(66476007)(316002)(44832011)(26005)(6916009)(4326008)(64756008)(66446008)(5660300002)(38100700002)(122000001)(83380400001)(38070700005)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vlffk9/0P7qbBLCchvVBDqOGmo7Yhf7OrDmusT+WECtty84oc+5bhqR+MUma?=
 =?us-ascii?Q?YhMcdf0ttl2GmqBuN7T8jtBkwvpZ3dM2tUPoKfDsXrXzGJmsrB4pTrDhsw8c?=
 =?us-ascii?Q?NhZHKInxAn41fjCgFoKCF06PoW/kD5IE82Ei5hWwW0DjPzPRmDYuSFXbii0O?=
 =?us-ascii?Q?Qjse73oqMIjVhLu5MH0T1GG8gmG6GJE7C7wbWPdH3acJyurxIulA3vP3qlxF?=
 =?us-ascii?Q?0ctzmJ7FxM3okjK07dCMcHaS95Jfwk455ez2DnooV+EPE5yhqJ1WrvYSOnBQ?=
 =?us-ascii?Q?I9U2aD8r9ebeKqTMkGiIS0QdBB2XoOAAP3KQ5QNojwf9pPHt5gjNeqnwhSVJ?=
 =?us-ascii?Q?enSUYWUJHrOF4ZFjoImEKKAV4C41r9iCgRIG6LfOzpBiSNFB2l78BUdWt6Xc?=
 =?us-ascii?Q?Gdr25usAOFM3a1z7qTa5tbXv8GLGd1ha7g2Y8vGVL5x5BYKKJq6dJqJZ2XjT?=
 =?us-ascii?Q?bpoQKit7kcCRtKwWhts308vWDpPUz4o6cuPTCdqmTATsQ4MhWYm9hDSnyfeY?=
 =?us-ascii?Q?DSAI5j1EJFA/2vW3Rk36XANz0/EqzmjNokk9nyumh2suH8UON/QJ1Z2abYBW?=
 =?us-ascii?Q?HVoY/mWTHZ9wsiTn+mjRzAufT+vSsxSSEETO09fHdZ3Yp1Fb9jOzT+zzgfXn?=
 =?us-ascii?Q?2gSLiZxYnmizYFyJAku32DlV5lc7XYLtoV1LMXYC96acbMfipaU55K/Kl0Wz?=
 =?us-ascii?Q?jhoiAKyWRXiEziKZFsjK9Tr2dsnQ37U8chYmebeXzi8HTh3sCIjfRlmdU26a?=
 =?us-ascii?Q?00lrtTchgwRKUKJyNbeBPzxYHPeoWnQJlDBNeBDLVWxblg0cXfSLq8XldNgg?=
 =?us-ascii?Q?GRQGVmS9lz95cLvtMGRA4fdqxpMgpMN+GjMooDkBULhGOxBBxEwFMqqH+d6A?=
 =?us-ascii?Q?731m83x3G20AbMteMEc/v3ecMBe4aPFktSFxK/Jrk48HIwvQ4x1XviIg3F45?=
 =?us-ascii?Q?5/KpfPv8HYLJNTzlLIo/ABeHJmD5wGSz6G/74Lz3Yxwdu58KVTkL1taL/vWu?=
 =?us-ascii?Q?ZSTa68Cp5iY7peUfu2mgJO/RmjJ8VqszRdqCcE/N4w+AVrvJfHHoaAGEmZVA?=
 =?us-ascii?Q?s5igo/Pn3jUYzKiZPj/JaX1u1teR8YP7BjWohl8PQqRskW2DJrFFd2j0HRwi?=
 =?us-ascii?Q?VoUb+LwBFxj3GvIRHvb1NjipXsSS1JnGaLb4EgU4uTTqgIrD73xbHTIQ6A1m?=
 =?us-ascii?Q?V74GESzLdCzBfi5bfjxUtxpqJX/rt2LOjLhLDXBC55V2hSr/vJWElGDreh0b?=
 =?us-ascii?Q?w4BO75m74cxbxqtORApOMImkpggTbwKKqtW6xFoijVJBWcjgsIBN6fXtdL3r?=
 =?us-ascii?Q?6PYNje5KEnCIblpOTk+8XoeEiNCV8k0vRU+eB/VLgdomnJ2hATUnIbdEg/mY?=
 =?us-ascii?Q?10gakfQKMreueEbcpSmKW2bIwvCqrgSJjzATQl7ZO8gCwmj8HUWOV8z7nhMF?=
 =?us-ascii?Q?72L+OL03uThL0vJO+No6DzN8vW2YZiRv9Yrbw2F747Gqm1OKTWlRXNOH42Kb?=
 =?us-ascii?Q?nmC1BZ5o2cAVDC4fzhnvGW8DfkAephbCZGXphe9x7WHP23bomUlYlIM5wet/?=
 =?us-ascii?Q?5WZyCouGAqgEPzm2qAkUXO0yN/5mMM8v1AsnJE3RCKS/rvhnUQceeL2r3cEt?=
 =?us-ascii?Q?b6uxTU6qQVXjWiGJSwO7zac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B4717D38D2C0848BD732715EC152601@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OxL3NcGcc/2frSg7m7qL2dqb/Pg+DIOXHWCAAeDRX76EfUDsdgqEYZT1QVGN?=
 =?us-ascii?Q?zGM2a469AyTEPtFvxXibu+OL7UTV7SDtHK/19pPA9rzbOSN72+pfVaGmoNWT?=
 =?us-ascii?Q?PRrqMll63q1emuOrEKPV5mHiBM4/a01P7dlqsFEUcXrdwWl7A8pgI2ARwfGK?=
 =?us-ascii?Q?r12NibE79Nzy1tZMLZXWB+I51NO1YImtjm6kCjw/p/E/16BK4hpM6osmFXZR?=
 =?us-ascii?Q?2TgYwJnJNRxbdl4GcWmGkDRcdCUoSOM38Bl2MwVg/lhJHxJI7KT/8eQni9JN?=
 =?us-ascii?Q?/S2FGLk0k+4xO+Swik9pTK6HJYouYbJZoQod2ssjhwYN7TI7tfSQHq/ugOxP?=
 =?us-ascii?Q?8AqlsNJDlbPAzejlSa/gM3bE38D5q/IjjJG8xFdjHk+Kj9tQSqdiGXz+Fb7i?=
 =?us-ascii?Q?x9lsY2CTCGrdwh/d5cTmYsGgpUwcIZeSNRR6tE01QjilUxw+C8fwnn+llvBP?=
 =?us-ascii?Q?Su8vfql6eUTkuNWgjuWNBIQH6wO5sh/9OAw+5crN20yHgMz0IoA/FkTotdIc?=
 =?us-ascii?Q?+s9GTTy/IeZ4/FoHazpLrSR/81NMboyxR15wfzx8dE62QvOuzwmwEE6sScTu?=
 =?us-ascii?Q?qCZqRkawruT57Sem5/2nxXYw1Kbr3eUp4zqeIIBktb24hNf+lHEr/0wSWWt9?=
 =?us-ascii?Q?hkF0Bok/6rh86wReswFx9C5weLmmZQtMVmvw0vaMODO1+2s1fwGdhD1Pchmc?=
 =?us-ascii?Q?rxp/scZJCYuIiVoK3iKM7Ux2D78ZA2sVPfgxrbno3lfIG+9ZidG79DFOwSoo?=
 =?us-ascii?Q?5q0V1N9u3TDFP015TCZ5YSiMV5TGFnRwllJf4MJPhvnoebQb1K5IsFU4fFPg?=
 =?us-ascii?Q?S9i6aGPNZDvZ4VrOjnCNQIs+nR3H1OZUCzJwU9Qe3qxkc7bLHjP2PCXRyWLr?=
 =?us-ascii?Q?eNQstEKcL/5HTqxtXwZZtPTH9WwbgitxOi9PxYGelAKEeyRooGXT5P6+xJ27?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728b56b7-b217-4762-65ef-08db7c5d8923
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:08:57.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0tNYAXalt+2g+vTp2btPJcLVAAv5ArL0vryzPpAJLQfQJsQrnrO5ts8u+BxgnCT6Z/oaACiDMPNxKCokVbeTUvmVCORLpY25XMjkLURu18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8688
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 03, 2023 / 11:16, Daniel Wagner wrote:
> I've rebased the series on the current HEAD and moved the def_hostnqn bit=
s from
> the second patch to the third. This should make it more consistent in com=
mit
> history.
>=20
> Also retested and found a bug in the context matching code in libnvme whi=
ch I
> post a fix too.

Thanks Daniel.

One thing I noticed is that now the 3rd patch removes the references from
nvme/rc to /etc/nvme/hostid and /etc/nvme/hostnqn. I'm ok with this change =
since
I see the motivation discussed here [1]. I will wait for several days to ma=
ke
sure it's ok for others. In case anyone relies on those files to set up blk=
tests
environment, please speak up.

[1] https://lore.kernel.org/linux-nvme/ajcm6yupguickaucansiuzjqatyz5qijnnp4=
topxv64cisbblc@4sgv3bd3jl4q/

Other that, changes in v3 looks good to me. If there is no voice, I'll appl=
y
the patches as they are.=
