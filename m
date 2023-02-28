Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8ED6A5089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjB1BNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjB1BNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:13:22 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB52DBF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:13:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu0GW3pxD/AksiImdTCYaHh24eMBuq1gg333gaAzshGGJFppBg/ig1ixt8LeHAiHy2+GgIKSXNcxDr3a+g2ERsK3MBifWhSyYkuZ5lWGRlAJ+lM3lPceKUOINUayxUiTb702A5n9KJG6C/BMst++45GMVdyX4y3knH2rDOU8g9aVpk8IzgaPzfLlAdTB/lWZkdQXKVGL8UFG21c4f9iFYLb8QRyWKlPM2BugJrfvEX01l+CKSyj+RjORDv3aRMUfDzmsDmYMM+8qe7rOLeTICPYeIU7ym51mzXTtB7LEuSWQWx561kxbqbYfGNIge5NU8mIFR308ezmtrVEDis/MBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeXKU4dE4sc77rONQriNHZ/FUiYUO5Ou5UAe+gTVk2A=;
 b=mVLT226Kp6XHdfx9SvaMmy9zFFahafbZgON9p73rZ0UIQB6l9bRtd+BDcdHH9nL/IkK32lsFVZiDK4PW2C2oNFul6ViViK2CUcgtFfGT4VYgyHjIOci/dcngTOFjHxSgkKlPavO10xgho/xWIrK9vruaq46I3fDtwcCMBY65a1/YSoMbU3hT0RKudUQnpxxOtdRNUg7+kDp+idGwGXt2AAJiCFPT8S8b2CcA1/8yhQmEPfzLIBiIrelF/2o52cBIMkQwL7cCjsvkoBeT8FVszLu5dMDWv7c606VdBie0V58g+qpaT3fahQU0NHnVqaFCSkRksSpFXykUUYHym5qERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeXKU4dE4sc77rONQriNHZ/FUiYUO5Ou5UAe+gTVk2A=;
 b=d65iJp7sTM92fOpB68nAnRcNwpObIyplFxZY2O1FVahDgv0b2WNDthGGq6DFl01iBBXWnYX+u/iASQqyaiViZHbyDHcftej7yA7ndrv8xOXynSEmjnZmiat4StXm/xjKdl05NEkdhw1UyYsFi1Hd60HPv0rvUzWaiOQ/quQWUJk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9224.eurprd04.prod.outlook.com (2603:10a6:102:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 01:13:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Tue, 28 Feb 2023
 01:13:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Phil Auld <pauld@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] sched: show cpu number when sched_show_task
Thread-Topic: [RFC] sched: show cpu number when sched_show_task
Thread-Index: AQHZO7s+76LPJFi54U+Q8EU41v2YLq7FELgAgB6bI3A=
Date:   Tue, 28 Feb 2023 01:13:17 +0000
Message-ID: <DU0PR04MB94175D2112D1398CFCF7714D88AC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230208124655.2592560-1-peng.fan@oss.nxp.com>
 <Y+OoSsB27e2LDc3E@lorien.usersys.redhat.com>
In-Reply-To: <Y+OoSsB27e2LDc3E@lorien.usersys.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9224:EE_
x-ms-office365-filtering-correlation-id: 0220d21c-e767-4643-adeb-08db1928f965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chytb/wVU89toKt5lWRuu1MRclNj45ckspRpP8B3BJqM/BuKM68PYcV+yKCPIqhEGvwMufHMyULt2YgYEDyGNdTfHEAjHpt4mtaKEuDAP7KidFkCcejsPQ7sNt1ESDcSa33wsH7GJHkG3H7vZ9uN9wzi8SiW1HJEF+Nh7N7nVOk3prrzq19Joe1f39NR93oZKiwmbU+7p9ECj8bB83Dw8JEBinCuop6T6EBmdSSZbxaJLswgi/8E8UDzkk/uJUgkfG70GUE/ot5gaRYYPlnuvsT5fzFWmuV1al86djeJi7hcltLd7Gac2Vh9Ae9RYSCnNJbT9oqCPFFkYTyO0w33ep6lmMVnniK7Lf0EEjaMKVqY9+46OmPi840fMGmlE5kf3FNajXCdnJAe04ULjB+Xy69YRWTSPQT64ijuEikOUPyDsFGeM3HH7ZC+SqKyA0C+AEiTmh7ZmQwTNxGUcstF8NtNbxJTTui1OLP51YvL2h18OKUVgdsYNx2XVoomEbOixQV1DgyJBLWf3dp7xBa3iWusDHzkfQh+PIJZEkR5R8Xu0S4yJULDCxJW45ba0b01OxM8vzuETzVOHikR/TlbzOeSlxNjKbcN+rZ6Uxx1AsDHwvIXr9LhYSvKcFv7U0WMicK41jO/HHYvzAOU2s2n5Xzl7NK8RFVsCYSo3ks3mqR60AzyO0opFazX+RLJmR6MKxSSjq7+n21M+F5gTqjBHQDt5pxCTFDjwH+bVYrmfMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(8936002)(5660300002)(7416002)(44832011)(52536014)(41300700001)(33656002)(86362001)(55016003)(38070700005)(122000001)(2906002)(38100700002)(921005)(478600001)(26005)(71200400001)(7696005)(186003)(9686003)(6506007)(110136005)(8676002)(76116006)(66946007)(66556008)(66446008)(4326008)(66476007)(316002)(64756008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VYwx/jk2vVokGUodRoj8THhIO0pdqgZqdeFammDGXH/b1anetbq8DT1oZBVw?=
 =?us-ascii?Q?zOErxDea7jp0MA6rabidb4qwCnDNjqHtFx/Yh6trf2abH6Z9v9wN9h5ItP5K?=
 =?us-ascii?Q?FSTkrsWiqwnlAk608dh4SGXSAF0c3toOTKby8kP2poORNXzkmaTXm/ghuG2N?=
 =?us-ascii?Q?ABrcCPxfcd0+zUOt7r8aC9uPcArfJ58N1MWvqhRDNRwLz5NJzXghYk37Hjn/?=
 =?us-ascii?Q?oUfA0RORXsntPe9+h/sD8kNQ28q+Jd6OsrmPipZjkMh8qbuurgEqAvaqBQIa?=
 =?us-ascii?Q?uMmLuDBgoJi2/AyZxhuEDDfpXncK+1NWf/qUtrWadNvfAgk0Jo+3VxLh8aAY?=
 =?us-ascii?Q?TGbFHUkzhoY7krBrTz7yoSqleMB4EOgT0wNisbwM7d5ULEn9hzEv032KppQx?=
 =?us-ascii?Q?gj+2ZL/sXU7pdw204secH5pMJXkQleW+j0X5gOiNxkFbmEE1TT2QD40UJt8i?=
 =?us-ascii?Q?mr7raG8/w7v5XsmgxRAI2flvoHDPwQijOPHgbGBovM4/ZMNZ7+Gk2PkNH/1U?=
 =?us-ascii?Q?PxDPDX2TEdWktd+RSM113gnyem5xyQ/0O673SQCP62O+2LnTxJOvr0UqQsyT?=
 =?us-ascii?Q?HeIGtoH0oVJxIMbe9E8pn/z4Fjvcy5tMyXqmBS8X4bYRRi0gOdNAuYBi7yDx?=
 =?us-ascii?Q?poyPIhykCH3HWQVNT6xpN3rzv16MrGaaoM+ggkjX03cRZo5/tx5MIrAV8QhA?=
 =?us-ascii?Q?2lQblO52+9WdDyG9KJeg6gu+YRjhdhoH1VEvalluHm3juJXkW9H1xqa0wZq8?=
 =?us-ascii?Q?ky9rznuwyexiYsgq6/tOIlMWovDy7WHz+X0cLHCbT+d8X+UyFE7kHBKbey4c?=
 =?us-ascii?Q?EGUnzRIYnKOcROS1SqySdlcbW/QVNmmHTsaSoyBAbpkWv5rmkKBbZOKcPF/l?=
 =?us-ascii?Q?+C6/4DAmaNN2nxK8rQ+XQboHA/kESu+jCqj0THbCRuJQUgLHgieMOHnzP58d?=
 =?us-ascii?Q?EBbrMaPkumpiE3rF+kQLXfNlywjhYPyPrHbcNzyH4l81btJCWpzf87oxX475?=
 =?us-ascii?Q?K2B6Sts+NpYc1ZBBLf8FZRT4XJ1EJnAj0Y6dKmfqN+peLCrjGE0RlWnSE3BU?=
 =?us-ascii?Q?1VHnCr28zk30o/9NTjwZLH0sCNxqb9kRzphn99grHeYy0uqYzhia1BO5qtvy?=
 =?us-ascii?Q?bkagpPR15tePGh0NX/mZRjx5dNeAAo5EFAsKu0w1uJy4jKMnHkIC/RVj10u8?=
 =?us-ascii?Q?ORTm6ranyFGrE4usvPhKA9wErfNhXw4jw4P5vFsibbSdPjCf7MIjW2Tv32R1?=
 =?us-ascii?Q?b6rixND35dZrpYIyD/nxuJ0fZJeiQosv+Ee6+571MHhsvDyXbLKHg/P8XJ6J?=
 =?us-ascii?Q?bNLaEfB75+5b4hNULNh+1vudz6/wsAruITAbf+y6owbOlWD6RI7xOGc73dHQ?=
 =?us-ascii?Q?ZS6D9MvsFs2zS9t4GQhoupc8dO4qbPQKGa7LluFfwPOmIciTFgaH9ojOqI92?=
 =?us-ascii?Q?fHDBw39LY175q09N/tR0C4a7zb6g0/z+Xti0dOKStVM8/uT3RrEiNXyLmMzq?=
 =?us-ascii?Q?eIzcdhBz4VjiBHbVOVKZNeYW+rhTTpZ9M4t/Me9duM8lEb+kGJKV5aMPspL6?=
 =?us-ascii?Q?zl9CD9FbSnGESTByNrc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0220d21c-e767-4643-adeb-08db1928f965
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 01:13:17.6165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6F8XgxRZ48NxzSiClsyHrB9A67fbmtSdx07t1ov9jz7wxvIevaP7qFkohoY4OHfkpf60p9Q0YQtvKppz1tXBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC] sched: show cpu number when sched_show_task

Should I send a formal patch with Phil's R-b or this is fine since no more =
comments?

Thanks,
Peng.

>=20
> On Wed, Feb 08, 2023 at 08:46:55PM +0800 Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > It would be helpful to show cpu number when dump task. Such as when
> > doing system suspend, we could know the failed freezing process run on
> > which cpu.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c index
> > daff72f00385..0c7a1b2f7baf 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8876,7 +8876,7 @@ void sched_show_task(struct task_struct *p)
> >  	if (!try_get_task_stack(p))
> >  		return;
> >
> > -	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
> > +	pr_info("task:%-15.15s state:%c cpu:0x%x", p->comm,
> > +task_state_to_char(p), task_cpu(p));
> >
> >  	if (task_is_running(p))
> >  		pr_cont("  running task    ");
> > --
> > 2.37.1
> >
>=20
> Looks useful, thanks.
>=20
> Reviewed-by: Phil Auld <pauld@redhat.com>
>=20
>=20
> --

