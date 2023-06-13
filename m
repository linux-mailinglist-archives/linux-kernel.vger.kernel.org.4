Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A572DD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjFMI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjFMI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:58:01 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2133.outbound.protection.outlook.com [40.107.105.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8FAA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9QnHRnDYD4N5pHmKkcBv4GM6oDn5Q4v8Y9x/9yVcR3f9Rhpxj2nQCFb1NZMyFvwwW4GdoyW3hWpjwnhx9QHuqg+/M8tOaBMwpOShCLVUEiL0LRCaOXuWTXOksZdLXBUUopUu6LGcr0i2GdSY/32VKE/pIDHLQJDNskJQPhltzhaDPJ45L9LkyXyPVJpm5JZh26kxSxlf4VYcji3jKr758TmHfTIqgn9X+PlVQ1ZzkkDPl8nVo9xIwLgL6nvV5X5Tub6LMURZUYD33GWc7vyWFG9UrlQsT11HpO7BJGlE6pfGJU4WDs1+lirbCaE8vibEvho+/FKYv1P69sOxX6aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTyE9g7iGNaQTF8TMQD8kODx8ca55M8mLWpzfi2pdEA=;
 b=husFDmqEqLHdb/oji3i6Dj+OTZkjJA3qhrIFn6DHJv9Upur2Q5UlHAimKcZUS5p46AS/+teX3MbKOmCUySfObS8BEeYHVl6YjdO3ghmubwHv9v3x0K3Sje0FPCh+K4jiSr+lfqf9SxQnysuEFGH/26dv4OvYwlrdQfY7QpaDQ/n1ENdlQuJ8cWhWqCeKInbm69/WdVwwwtlfvsZHDtKUYX2L63Wx3lj5xIWUi+efvoMuU4ar3N7R7guSVtMb4Ijx8URGmt6+M/FAh6VTZq7feneEofW+Kswxv42/2FxSCYKt8xNxQVkn3hHSZKh99Ah6iro5xzBKzAe6RBU1pDdpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTyE9g7iGNaQTF8TMQD8kODx8ca55M8mLWpzfi2pdEA=;
 b=bK2lM/4656NIWzev1lxqASgMjRbXJLEcwCteSMwdaXkhpaMO8/23B4tr4L0cWGXk6WumqmAHbhSYaMd2TMrfdMy+63VEZm2Nvdty/qJFe1BuXxyODes+YyDi7WNOgULKxqkZJnWR0K3miIa59q70XlqCCh8LWqbtHQPOWHDgP3KFo+8G9Ip9QbhtTFHZGi33IKu6vZotd2T9GADWu1uCm6lkViYv4v0FMFg6PRG7UP56sABEmdhqLGe/87nJb8VPq2ED9UZXgGrAjkqxLLaa3m56GjHOr+w9X+3BIdMmrc7HOH386OStqtegfl7ZBkfqjHpa9pzNUJmqQyFcU7Bh0w==
Received: from AM0PR06MB5203.eurprd06.prod.outlook.com (2603:10a6:208:104::33)
 by AM8PR06MB6962.eurprd06.prod.outlook.com (2603:10a6:20b:1d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 08:57:57 +0000
Received: from AM0PR06MB5203.eurprd06.prod.outlook.com
 ([fe80::8a1b:cf75:a821:cccc]) by AM0PR06MB5203.eurprd06.prod.outlook.com
 ([fe80::8a1b:cf75:a821:cccc%4]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 08:57:57 +0000
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Tuo Li <islituo@gmail.com>
CC:     Namjae Jeon <linkinjeon@kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "baijiaju1990@outlook.com" <baijiaju1990@outlook.com>
Subject: Re: [BUG] ntfs: possible data races in ntfs_clear_extent_inode()
Thread-Topic: [BUG] ntfs: possible data races in ntfs_clear_extent_inode()
Thread-Index: AQHZnbBcskKTKtOEpEGWpA0pT3Z+aa+Ibt0A
Date:   Tue, 13 Jun 2023 08:57:57 +0000
Message-ID: <5073179D-A781-40B4-8866-0288B29AE4D6@tuxera.com>
References: <0c336a41-54fb-2904-42e2-1d9ee3950b21@gmail.com>
In-Reply-To: <0c336a41-54fb-2904-42e2-1d9ee3950b21@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB5203:EE_|AM8PR06MB6962:EE_
x-ms-office365-filtering-correlation-id: 652fc101-94e2-493e-8252-08db6bec486b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kziteQW7vpPHy+uyGv2Qp8TgnIxPxeenvinFhznHpLbsIVLt5Ko8GfMdWBSULnoIk7/aL7JMv+4Gqt2w4N9MmiFI4elqj1A4686pjGk6ul/YhRVg4WRvZ+FovOTkzUFgf4bxUmQfIMIQPf5pEQQ6D5JahvSReHGrpSlIQbYiGq/2leMyV0oVeF8yCFLQ+D4H+a1JFxvJlLkIIMDuVyJhIaTGVGr5VoO6bZ18AH5M1fiqORBLMu8nCIct7786k7+xKey3D0xUqhm/nxDA+3Q4aaShW9cGQ4yeu+JjIWYyK/+rrBUThHtzQC2s4KkD0ZJaKf4YqQdMKKO7PZmHVFqWtcRXuYjF2xe3lpz9YoSs/YOVEWbVt5eGuSiyKqQTla0ApcBFVZSmwqAoCKGoRSY9C3GWxMJxcNqIQLrtDkm0MXZ1jTCe3h2c5CORcOMlI0jmw8KNgBkHOOTLJuSRfnZ4DEy85ctq/KaVbP+qPKqpsXdTLggu1aP2C0KSqVufkS/wONS7S074qK8UuMZmMHHI/N/rgvXeMuSJTl9CtEcounfj8rSVEwRBsLiG/DbAwnrNCvCVCEI3c49HDxtvMjRXzYuy1qKT28vdSjoacTQEABmbLc4Y98A8VVUI8g9Hz0YjJ/V9nG90p1g+K3H2EbfTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB5203.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39840400004)(136003)(451199021)(966005)(6486002)(316002)(41300700001)(2616005)(6506007)(186003)(2906002)(38070700005)(26005)(86362001)(53546011)(33656002)(6512007)(122000001)(38100700002)(83380400001)(8676002)(5660300002)(36756003)(8936002)(76116006)(66476007)(66946007)(66556008)(478600001)(91956017)(54906003)(4326008)(71200400001)(6916009)(66446008)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hP71Jt08rPsNsz9nj/ecDnmz/qNsCavq3GHd7FqXEqqcSFxnZousFIpmClgX?=
 =?us-ascii?Q?JUu9VPUVwUIrsV94cnhH0Qvdpx/iAsQd5xoQr/3eecuIEpb3UKM7Bi7WxWnq?=
 =?us-ascii?Q?rFWm9KVclfwnAluGWX46m0mi6S51bID/FOjrh7AyqeN/DgDP/O5PHoA9v/2E?=
 =?us-ascii?Q?RJrAt5oMJopDELlzyqfhzoski7rT5z5usQh4FuSwuuBrxAqUx1Mn/CnPGzk9?=
 =?us-ascii?Q?3q3ing5XnTw7t4q72w8gOoG/BZYyNd/A6wl+PqbGP93yLiRo5txn1XbpwgWw?=
 =?us-ascii?Q?cE109yZuIXFvpZh2zhXMN0qnshq/kS+hh3jP6fFFFhfLyrxKO7L9Xliv/7Gj?=
 =?us-ascii?Q?HD/stfhtc3Ew0fiTLVb6HsfilSZ8fN7ADYxOr9GPgRVr7SQFUeuM4RUDG+3e?=
 =?us-ascii?Q?EdV5fhV3pE4nXDZomqeHi1twX1RDrghkDh7RX/NdSV5GfCvmyOouszNtj9XD?=
 =?us-ascii?Q?Ngpu4N+cuh6qBLn8S55d+WISkUepTR4Y2qctMzk+LWETZfLmamUHLf9aK5Pe?=
 =?us-ascii?Q?+xgiW0uTgut2ROevEcHzWykLWd6CRjznZEEiUbj+FgR9pMQQVNO+wmAXou9s?=
 =?us-ascii?Q?goJ27LJfwI4E5Yck14j13Q4eGKasOI4+Z0XGqzZnIOjKBMXBmoCkVBH1YRMw?=
 =?us-ascii?Q?zZV3CBQ/HUEN1r7lqVVwZiI/WdI14Fl9x0onTULXckNQKLc8kwlhKjE5gl/5?=
 =?us-ascii?Q?8eTd6bt/tgp7vBjMdZ+bwNRTw6EvCvgymJxngg6JLu7gdkQ24tYnGoLvs/ZM?=
 =?us-ascii?Q?H4+sX14D/Y/ct1lEVcwMJRpAPW2E94NLzNNWBPFmHjz9afi2NYCGmv0MG4Oi?=
 =?us-ascii?Q?unUObtjrVfPrnTv4qpIB5C/2VPADu/NYlIrjfKWYnjGW3UzLDcDK4tCjlHBF?=
 =?us-ascii?Q?kB5TgqV1kaiGaqA8v6rOX0Z0qbTXYE0Td0mpdhSlWhQPCEMWjPwbcuo1mme/?=
 =?us-ascii?Q?AmjVJ/z7v+eE3su3D1sEntoBvGE2VFHI8dnoAX0Dd3S5vaEYJ4fB8zCs340A?=
 =?us-ascii?Q?7TyBx3pjOK7Huc2jG0CqOysXDIEYIUpWvHffLtEdEaEbQPwb3yFnMaK75Np3?=
 =?us-ascii?Q?HUkrazLtv8IsH+Cmb9/fE0dbimbXGWMS8dV3Cizl54U9SkOL5ZBRKpZvNOA5?=
 =?us-ascii?Q?3c4iiIIQfKG9TyDsT6DRnc3MJTy4iLN6kBAuUiS3JvcyI5LHaDw5Fw4zxXkH?=
 =?us-ascii?Q?OLOak50wNw818U2B624vW8DwmsgXgf9pdBpGnLPI8twwy1RyWAS98/P9qV8v?=
 =?us-ascii?Q?05I3hmgcajJ3Mr51zp1ZgzTKzyYuWw0yro0+vtcJyIsx8Qk1m5XGtfb1BAsE?=
 =?us-ascii?Q?bdWx57RXu8pvlP5g0OBJl10901RwKwpBDFn76jyB9Eq5duB+vvr3a78R/S0k?=
 =?us-ascii?Q?5xepVJvLDZoBd2wlHSrC2ZeIzCWAWMaVCsfdiow+kUp7z0r60BNiIveLHeTN?=
 =?us-ascii?Q?VofJ8mJLJXRLG6KfmL/RwisPuXRD56Ec7kQGZ30xnRHYow5YyUu956AIA6X8?=
 =?us-ascii?Q?aWqW1KZarUK8EGC0xeBMD5cbW7zFnvOBEGXt2ghSFsZOzYlOMjzR1FhsVKAW?=
 =?us-ascii?Q?PWBttDWSGVEELdOpGczY1lEhg4HpTom1hI3QvUXn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A892F7F4E0985940A28A15764A50996F@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB5203.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652fc101-94e2-493e-8252-08db6bec486b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 08:57:57.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBn0PoAi34nRK74th+2gnqKUwZv6Ui1wVEP1JIE8sP9oUwzZwBJm003JGQ++uDMZ39XyXxwq3pqDHYktzxukhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are all red herrings.  You do not need to lock something when there i=
s no possibility of another process accessing the data structure.  All the =
functions you are quoting are inode destruction.  By very definition nothin=
g can possibly have a reference on an inode which is in this code path as i=
t only gets called when there are no references left.  The inode is about t=
o be freed so any access to it would be accessing freed memory.

Thus your static analysis tool is giving you false positive because it does=
n't understand the context of what is going on.

Best regards,

	Anton

> On 13 Jun 2023, at 05:34, Tuo Li <islituo@gmail.com> wrote:
>=20
> Hello,
>=20
> Our static analysis tool finds some possible data races in the NTFS file
> system in Linux 6.4.0-rc6.
>=20
> In most calling contexts, the variable ni->ext.base_ntfs_ino is accessed
> with holding the lock ni->extent_lock. Here is an example:
>=20
>   ntfs_extent_mft_record_free() --> Line 2773 in fs/ntfs/mtf.c
>     mutex_lock(&ni->extent_lock); --> Line 2786 in fs/ntfs/mtf.c (Lock ni=
->extent_lock)
>     base_ni =3D ni->ext.base_ntfs_ino; --> Line 2787 in fs/ntfs/mft.c (Ac=
cess ni->ext.base_ntfs_ino)
>=20
> However, in the following calling contexts:
>=20
>   ntfs_evict_big_inode() --> Line 2247 in fs/ntfs/inode.c
>      ntfs_clear_extent_inode() --> Line 2274 in fs/ntfs/inode.c
>         if (!is_bad_inode(VFS_I(ni->ext.base_ntfs_ino))) --> Line 2224 in=
 fs/ntfs/inode.c (Access ni->ext.base_ntfs_ino)
>=20
>   ntfs_evict_big_inode() --> Line 2247 in fs/ntfs/inode.c
>     ni->ext.base_ntfs_ino =3D NULL; --> Line 2285 in fs/ntfs/inode.c (Acc=
ess ni->ext.base_ntfs_ino)
>=20
> the variable ni->ext.base_ntfs_ino is accessed without holding the lock
> ni->extent_lock, and thus data races can occur.
>=20
> I am not quite sure whether these possible data races are real and how to=
 fix them if they are real.
> Any feedback would be appreciated, thanks!
>=20
> Reported-by: BassCheck <bass@buaa.edu.cn>
>=20
> Best wishes,
> Tuo Li

--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

