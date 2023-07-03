Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74E74550B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGCFnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGCFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:43:08 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D074283;
        Sun,  2 Jul 2023 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688362987; x=1719898987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ID22IncpBC1IFQmZ9dePQbltHKjJk1Ya5nVzSiqQZDw=;
  b=p91RIF71wKk4i+RQ/s1LikretDqz9g9xcUkmJrhanaiS+h/dbHN7zfPY
   mXssVd01rwgwqa57QMSJiV7OmZpQFdCJ6UmC2sKWMhKbyU7ehJ1FzZtSW
   +nhBK0TzRxeCsWr7PN9bHNtm3U4G3AYXj+NJUYP5gwoI48qNiNWib4WsC
   2j+3e4ja0AbfOLAl9wH/J9B2RR+qtRpjzUVf0arfFfUsAeIV3/eAaAi+a
   FR0FtPP+5pUNc63ki/vj0fO6aphRcPIEhIEfkBZt+G9jaLZWooH3n0qjR
   YAcSapEfWNPJjg2yOM2yZxprFtNzjXBKiWmoNHHWpa1fYyo849mkRpY/q
   g==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684771200"; 
   d="scan'208";a="237388677"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2023 13:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh5aUTc5mJl5IoE9obwba1Dy5473cPgFUZ8iGgrMlRKofI4OTE/3RcMjm0tzt0FuZ033Xw5H8tMiHqurgXeozCIaAq550g1KbDqrg8WqfH8iP6cBqtKxmc07Rhspsdtf70+ci1c2oxQGcuNMHluxnQoidqGJYGXouz6Ev7a3usQ/6C1mPZKNyRqnfIfysJUw1WYiQgD2LhIyp5CdGKANdVLKfqORfXH7Lx7/4HrIgyX9q7tABYZJ7XyiboMfatt/i97S4LmeWi2eUd12LKLkc4jyeFXZ4COnV79lE6IIuvM9zLUvfSO4XkxymiAKAj0fa6lC5y2+6JvujZmNJRMy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID22IncpBC1IFQmZ9dePQbltHKjJk1Ya5nVzSiqQZDw=;
 b=kOIacGZ7TJOoqLRYIogCNgD8XT6oA1h/8YkaVNTxOCKFI2rwC4dGnMFs9jHiTbVhuGtfLE7NHCbc3r6rDDwYv50faW8CUEMqIhOIURagpFed5kkRsmA9VddG64hcdp9qRHJgJXg/14Z01O0v67WVumreJqHiI1j0Cg7EKDTwXroY7fHVxTihaf6wSBvFe7uYcWMeHg6eGfEJInAv0w3kK7+TqExu1zlQS9GXzW+R72kbu15s2Nc8LZaO75VRI6pf5K2KVrE7VDJlPz/NDqa5Qqc3TDwz3IXlT+Q40kd5B6vU5bT6Wgg11bR1lMjd7lFVN6bX5K4RmaeCrn2G+UnjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID22IncpBC1IFQmZ9dePQbltHKjJk1Ya5nVzSiqQZDw=;
 b=E24Y3GZl2G7PHu+oeDP84wQJ+A30UIKZsVoKqFNFNBmRwDVmoLbU3E/oeRUnjCdkT/u97Hm3AL0o0hYCcZKhLYxHuc7KnOAJY1c+O6GvkGtQ2Fl5NG6wrQN+t5OldmVU6RNIub3WF+Grk2UZeyu2ZwMo01VAKE9ztMg9Ei0xoh0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6508.namprd04.prod.outlook.com (2603:10b6:610:6a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 05:43:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 05:43:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v2 0/3] More fixes for FC enabling
Thread-Topic: [PATCH blktests v2 0/3] More fixes for FC enabling
Thread-Index: AQHZrXE75p0D0BqGR0iZH+llokuVXg==
Date:   Mon, 3 Jul 2023 05:43:01 +0000
Message-ID: <aji2laz4lypl4lspduoeef4uviuoysl5rweu25zmzplj3psg7f@ryxrnjorfsr2>
References: <20230628151623.11340-1-dwagner@suse.de>
In-Reply-To: <20230628151623.11340-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6508:EE_
x-ms-office365-filtering-correlation-id: 9b77ada1-4d4c-4449-61da-08db7b885da3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53y5rG03iCvPaZaJJ917pekOiKaMYVI/np8INeyd/cANnYxSTrW4oRjhZsa5Pj61EgEghoxxBBr1Rk4+kV2B8R2cOjFKVqiZ0/AcdWs+EjQu7sR5qE8Psg1H//ul3+xsy5Mmbb/fTqx1us/+CO+L5ZhRTIkbHNbg+Id4lhAuxzLdW6Tk8d6tCgcRuQn2BzCMTBBdYYdoxbqq8wjqUP4cUcyS1OZSuhSZRm6axPI2ORF1RdOW6gdU5S8Gbo2e5FH9HD0eiisDbiPKA51PomtVMZXcQO9/K6w5+E0xky5K9UC82lPXh2+zMjEZvJrW+peVz1Fmq7xFKGzL0M0oISldTdVfvBJ9bxSSPjUy/yqzbO8LCunbsdKizXtWuHYsMgSjvECSMgC7zeao4XIcYuUuVXqqsQU8xBqIG1u+V+58shbSj6sKOrOMZSgpD4Btz+smmekwbqprm6BUvo5K9Kg1zMQnwulWujInZ2qteWgmo/FZbkSDN6R+NLYHatggg/IeYjHZh8KvSjTX3WQmudYqsX/CoGOci2qJpWWvb7pUsuQWY5l7UKu0XtZMi+UgtkJE9oI5X+HFSvwgB3yFp9/NDCJ3SeST007eQIXYcUGWv1E4114Zs0xr1uJWJ+0dmVSr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(8676002)(8936002)(54906003)(478600001)(26005)(9686003)(41300700001)(86362001)(4744005)(6486002)(71200400001)(5660300002)(2906002)(44832011)(316002)(66556008)(66476007)(66446008)(64756008)(76116006)(6916009)(4326008)(38100700002)(122000001)(66946007)(38070700005)(91956017)(82960400001)(6506007)(6512007)(33716001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i8VoTBMC0pDr1VOHhQFUlXj49lViSGEuJY5uaR5Y4h8g8vhOzMzLg+wnZdhb?=
 =?us-ascii?Q?KYF6G4IEk/k3BXg7RKjvmL0b/boeBCh5xH73fjxrcCC/rPzch01zlOpTVERH?=
 =?us-ascii?Q?JUPFElaqu3FpQK1H5TqZApMF1en+dqlKRT9Xioi0LOX/MjAlPOzcAfa/1R0y?=
 =?us-ascii?Q?9Ft1p31EcSL77PIw6mDI/tjzMR0ks5GARm5qnKCzHQBUgdOR8mMO+PHXetVG?=
 =?us-ascii?Q?/PyXgMqSmiKf2zFfAtN6DxscOnry6+YH+G8LZav46xoEPu1tXNB1wPjUJWJv?=
 =?us-ascii?Q?PzK8nP8+W8QrwjVs9J/Da+XAth5d05hMt82216N9+SKcQTxjCq7LyTLthTaw?=
 =?us-ascii?Q?8VryM+wLNhBDuVTuOOK2xgZIM9xJ+VB4Tv9BwKCP/tnBA8P1RHO/JJLHrPyL?=
 =?us-ascii?Q?7f3WsE5j13lzM1D5ZA76erOClFacIrykjU61+iUYDlKvko3kCTwW71SHYUGf?=
 =?us-ascii?Q?RcNGI09hKvojVjPZTmpwlru4lRDZ7ON+gMbJ2R9MH/7c40x+LJwg9Ffz2hzK?=
 =?us-ascii?Q?6tk8akiCHvmA2AVixPI+et5Z9SkKoRd2Wuzi7sDdK4EweuIdDD9/W0CsH663?=
 =?us-ascii?Q?4DK6vfp6RhCGUbdWKX1a51wYI1ti8gjeZhlF0Kp+l/NroGG1uc2x1XkPBkvU?=
 =?us-ascii?Q?bbwGFsXFT10jtcyK7hdTp+5MuddaRpJbOBHPJhnGytCnVaiAK8jXhxLToFZz?=
 =?us-ascii?Q?KrqwFRZY2IbtPnsSqT9iCloPF9IUBfiA3c7BqKRtbNQkWsVT4oDLft+4wyEZ?=
 =?us-ascii?Q?tXdZdyI/c8RQGCPFzZI2Zj/W0nfYxoQryGhkq5/JT14/9z+iMtTfmWs132pO?=
 =?us-ascii?Q?2D5nNC3NBDt+qpz2DdvVI6ZJg5jsBzPPwN5LpG84ZGAhFXWTO2bcTO1ZTgbg?=
 =?us-ascii?Q?VH2CzyMek9g3GqXYd0aoyiOWDajoJeyoGKpF/39uGBAnzibyQAwvyVUZOolv?=
 =?us-ascii?Q?fDUg3L5XQFKN6tSQskKDW6Taji+/9NXXpcvt1BulJaHYulqQgbCSSgeanru3?=
 =?us-ascii?Q?o2rMfBnmb+CmSkWo2Da4sdhorUrjKaW/Bkv+rEYR3Aw0tUHWymUHWIp8C6hj?=
 =?us-ascii?Q?hrCCam5NeGSxI+tTO7mdplTf/6MloW3EMJkEmLN4tmU6la/N+mZL+8CZRrCY?=
 =?us-ascii?Q?trDJJPsRiJnnHAiwNWjrleS8g/0/iPEPYoQZz4AkdbD5DwLSgodg3wBO9vdb?=
 =?us-ascii?Q?KQJ53H1QfQpa1C5+u0f/q4uAxZmpXh29SrBR/XauBIRjB/N5JQGriF5YtA0j?=
 =?us-ascii?Q?n9c49WpMxWVd9pT8dNN77IF3ZhpO1p69prFfTH9Lgyq9TC4UGxOgroXERFXI?=
 =?us-ascii?Q?rS3A9HYYyhIG2q8TbbsnqUszgMoumJYaAO1qQ0lPC76ueBEXS5nN4h2HfsYr?=
 =?us-ascii?Q?rP6+4Uy2bCWsllGhikUtl8wP01eb9b6E9YvDT1VmPMiphLNt9TUCqqWNXJ8K?=
 =?us-ascii?Q?JXp3MPnz3zdplZsYv4s1UcfMpv4cobwuoK9nrPfEzNkc/0vkgVlzs6imEB7l?=
 =?us-ascii?Q?Z87UBOTz1AX5Nit8X7XFepsNkgTC2W7DYNLG7IfIh4OzXlVbt8IXpV7SN9zd?=
 =?us-ascii?Q?DUGMaB1Y7N1gUa0D1PLGizvpMIJeyCs7B/76OWbvmQNALlZXptlCXGzRaTqL?=
 =?us-ascii?Q?3ByVWmmRgNlrzBQyZKdi5HQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D23FB7B6588844E89260FD0B9421607@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Iw+NfWvacdY5aEttyoAJ4lDdv7Uf8M1S4l2Lo/Z9JS3+x06rjyV2/zO49mon?=
 =?us-ascii?Q?HXOnVHHEbwx/pdIco0mEVIdB8CNWmkk6DCEoh+DHioTsbdMYNZSqdO9Rizy+?=
 =?us-ascii?Q?twFrJq0ryX8zHLo+8LYXZt8K5nZh0dH6wcfkRYa9hh11qu73GraSZPX1V9Cp?=
 =?us-ascii?Q?QqIjg+4NmAo1EcaQXeiVVIRPzocVU7vwkFKLXeAv13CkrbbMV6ZoSkeVIsJE?=
 =?us-ascii?Q?eNnA/f9tZytKoTQMjKUB5PGdBSyxe0PtKpDElrR2vdKt4C6V4SJITtUTKYyn?=
 =?us-ascii?Q?5F+eZ4DDzDVmI1S2niMMk9qXHn4chTVqaEWbh8xuWaddHyH3NbkA99h8kIGC?=
 =?us-ascii?Q?OLYWUA/KjPXGI5qwK1RrGcNRSPwRJ12O8BQVjgsZWnN+P4VYB9n4N7zcNIt6?=
 =?us-ascii?Q?DA8XNvZttCehAWEIqw14D9pTXRj9+8KlvjmE9ccdQzfzQgl0FnYHIfPr3jWL?=
 =?us-ascii?Q?L23xwnROFKuCFy+X9mki+szf9m049OcySfP8X42NMUKf8lxr8To/wEeiPMtU?=
 =?us-ascii?Q?5MDWqghCytIWQGg5BYbEg5wr/j5+jnfMFTb8Zk+Ju84CkscrtBSJwxZ65wLB?=
 =?us-ascii?Q?+COjVJebLC3wLAg1viHdyrGC0cXbPvWDAblG6uQD8quGRZKQnuI4nv+F3TvF?=
 =?us-ascii?Q?AJjNSGbwjKYasfs9vnYt4vDvE3Kh1GXPTLSTpi27yPNhCw2OyOQRZ5MFcyuv?=
 =?us-ascii?Q?vyyeD7GMlv/8y20K0RRvWu59CiIjq0YCSvixMc45cpOs1tznGQlexCPopi5M?=
 =?us-ascii?Q?k39WEy8yiNHMivy25zO3xHZbVkaoiw+8ZFQ+o0WlPxlMjYhCdiEEwCSKx/Ye?=
 =?us-ascii?Q?8sXG/Zc446+C/C3wnG/mgIHmhBXFnPsxJch3pWYOcTVIJDuVU9BUBZULtlxZ?=
 =?us-ascii?Q?2RV2OsqQ2wVcoG0bz/8WQVZIRSCgvWWF94enqp1524eTLasnjnJCnMre/Pql?=
 =?us-ascii?Q?GaerbF/zs0r0JSFpPHD2x3OCDK5+yv7AErbbyyMLRBg=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77ada1-4d4c-4449-61da-08db7b885da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 05:43:01.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeYTK4F3EshZhmC2YvNLq3Tkss+/G2jruQB6HBTpwdQ4kv8Ma+kwPkgLz4QR9wnMDb4YfuK6FySL54SoL236bZ/fZulVl9LwQevMyKg0KiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6508
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2023 / 17:16, Daniel Wagner wrote:
> I (think) address all the feedback I got from Sagi and Shinichiro except =
one.
> The _have_nvme_cli_context() (previously _nvme_cli_support_context()) fun=
ction
> is still there. I didn't find any other good way to achieve this and I fo=
und in
> blktests another function doing the same: _have_fio_zbd_zonemode().

I found that the latest blktests fix for the hostnqn/hostid issue created
conflict with the 2nd patch in this series. Sorry about that. (Actually, I =
guess
this series could be enough for the issue...)

Daniel, I can fix the conflict and repost the series to the list. Or you ca=
n fix
the conflict by yourself. Please let me know your preference.

Other than that, I think the three patches are good enough to apply.
