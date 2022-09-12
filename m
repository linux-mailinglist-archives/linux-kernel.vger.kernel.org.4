Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA05B633F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiILWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiILWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:02:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D9474EB;
        Mon, 12 Sep 2022 15:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1ylmfgxs6Z8fQT/yPMYAL4RLf90bESc4pa5AzldSgwjM/G4l2OS/eIzSrYWtDAAB4WYU9trHkl4LQ+EJr8TEIyi0ZNKgMdwa7g/4qZv2kBZLmS7mlJceQwCQ4TvBVZMOVm1CHSnAmOVGln4ze3iqTb06pnm4G4xVDZdCFarOvSdTcUc0qVR09rsvLu07fxD+FCJeVFHWFoyvVtiGjUUZfJ09fNAP+nAVkP4IDCz0m9D67q9i6CfCB00fAS+64cI22OKqWXXl45KQ46bbkq/g2XN+u6CHHfCW6Ixv65DcDjaWgxkIsiegjNejwicpiW+k4iNAi0hgr6TgMfC4ARt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaZy6SjM3i0we06uBmjcmd/AQjjxDWIqZpZrISZOXf8=;
 b=Of1NXWu2Lz1jiPmE1D2YXG8+tEfQVCYjcY0E3H6UvPEb3KZDwr+CExZ0M6oqTTQ/TKxxftEPImKvDdJbsMXa0S+6a8/2ueLy6duOziUYfR8NbcF93mkc9CTasvJLido/YAkXo3MmfTKwgseYa7PGK0bjbXQimgUBC0VaEDVicBLJi8MBd1YswgxrmKMeHgb7mVx36fsVuuooyenL/JLGtF/mSQIrWcFgBQhLjyL9nnAZWlSribjdXTSPPOTjUDnauLkhrPBv6jOoWPXrcYnRJZnhCbu71xwMsBn9jSMIiL8mNskuxiOffAMLWY6x/yBv5ar05qgGzwshtU/W2xIuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaZy6SjM3i0we06uBmjcmd/AQjjxDWIqZpZrISZOXf8=;
 b=fy+iMPxuiwckMaVDQZrP19QfRIHTV69RVdc45t0Ar+ChbLm7OYs18iQPRFywDBO+6yznR6JLxn87uqBlV7p6f1zPTmCVrH8biiMqsBuyamVvpu89wWuR4t0KFw55S+d83phShn7dslSMKMVmqIWMGAqsY1bRfISh0TIjxYvg3Bs=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CH2PR21MB1510.namprd21.prod.outlook.com (2603:10b6:610:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.7; Mon, 12 Sep
 2022 22:02:03 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b113:4857:420a:80e]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b113:4857:420a:80e%4]) with mapi id 15.20.5654.003; Mon, 12 Sep 2022
 22:02:03 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH] drm/hyperv: Don't overwrite dirt_needed value set by host
Thread-Topic: [PATCH] drm/hyperv: Don't overwrite dirt_needed value set by
 host
Thread-Index: AQHYxrzvcw8ZA8kTyUqhzpRLgwf6Z63cWQIQ
Date:   Mon, 12 Sep 2022 22:02:03 +0000
Message-ID: <SA1PR21MB1335144A06F05D73A19827DABF449@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1662996766-19304-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1662996766-19304-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=731ebe43-897c-4b9d-96c1-24bb478be115;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-12T22:01:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CH2PR21MB1510:EE_
x-ms-office365-filtering-correlation-id: 2614d00e-63ba-4cc7-e014-08da950a6cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQn+AVgyYthAPF+xc2FPc/6j/t4RsqLgbbzSOwXTt3/Yv+RGLEhYdIl6TdH/5ipbtRuMfP9vM6RDMLXTK/ecy92KOa72ZUJoYuIma1todt4cmpYh9nek584mMZLjjHe6gchcAwyDPfqC/boRl4IxsiUf8sAnpY0rIKSx5pLbm8hzZ6KxSFY7v9BKzgoqMI9Zx5YR/prY3vCHW6JeI2Br9F28bk++Zjj0Z0d2WRNuxM3K1VMi90YMCdGx7iaJnMcvv6x6zM3QPygqdg68ZUjzGgsDyT+6ltxDwC9BXfhWZz0gydHiqoBvuR3yailCdhkRLUkNIqDUf5juNJqLr1gwmmw8vhN5jcIIrrReWkKt/9nK2LesRUM5xw19/7kSiLiOGZ4BSVpW50FzO7Z+IkiE7OKJacHpjcwttWMQ+c3F+damn4vYeaCuj8sJ4BRCBHaRCi6XgMi5/xpKkH6yxFjYX5VCsoFAAMgGxYLrn+4q/ec6HTGzZObrgI6IF73zuPyYKySWvulRQ7620DEULHoi8+/2rintZb3Lhx8qCA0gdfSSujTjdF0VEseVaKnNhorIRtClLuR4/FIrbz3xUw+yE5iHsX6h1vJvilPFonqTPx5R5C3PkLrUDhJeDMv5dlyTtwTIE2MG6xSDgZ3KYxkSD/IPZSblK9OeUxIyeq+l7eH3sHuPhM8qQPFRO7NekGZgw8aafhh4qP4XdAP2N1dbO2elYyAgrkyNfU4IC6+Mx6As+BSFYPo1nSnZ/F9juN3zJXqGZCT9++yPgL/3O+NGX9fwo/BVtTt35d7QtEkYXyAiC9OykYIL6oNMA660pwAe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(64756008)(76116006)(26005)(66946007)(38070700005)(2906002)(66556008)(82950400001)(122000001)(86362001)(55016003)(316002)(8676002)(66446008)(82960400001)(110136005)(52536014)(41300700001)(71200400001)(5660300002)(10290500003)(66476007)(6636002)(38100700002)(478600001)(4744005)(186003)(8936002)(33656002)(9686003)(6506007)(8990500004)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vizCP4ea33FTF53/eEvR/4c76g1i6DHoqJvqkUQ++F5tQf7XCM8FJHJ6wkdr?=
 =?us-ascii?Q?aHhSYc58X8F/dZg1/mckXkXCjAnfra/sbN5VltpoCiZCIVenkY0eC/bv9gjY?=
 =?us-ascii?Q?ufN2w9XasnO5owWjQbJhMqeNzNrDq3CG+Bf4eRccTQLVf6Z6oc5fP/Y2uV8T?=
 =?us-ascii?Q?ecQiBaBgZtM13x5tThnApRDoBJRofXXc69AsQdxBpCgBHXP83LRPLeGhWsOu?=
 =?us-ascii?Q?+ap7VcMzn5APWUfEO76XFMXrycgDDjugUbtRoL/fy2105l7EncGgyRFqKPwi?=
 =?us-ascii?Q?/OCqLgwVSvIbV7lCNbYU6rNlgbdgovjg/t7WyspIUEnrWVXPiillXjTW/r55?=
 =?us-ascii?Q?aLBIm7f27k0Ymg+SRIbCbacS6H9CCGHGHTCeuqa58/qmXYut1rADbZAAaWgB?=
 =?us-ascii?Q?lZ90WjZJe8rwy4FH09F6nW5YOFL95c3tGM31DWEo5QmXUPQ0odQbeBey3pHe?=
 =?us-ascii?Q?IqeIOX1gt1e3d0+we/lHgH7Cmu3SLiVY9VwxTHdq+24AGTvK7lcnnlrH4SV5?=
 =?us-ascii?Q?2K0gS6++9EHLg2OBCjv2jqmw3rxyX29j8z2pQuK4Viix62VF3qrs5zrZjA44?=
 =?us-ascii?Q?TDhQUJH5g0Pmcie1D+xALZis822TSKDJe57LiEk1iPSRlI2QFhwoGH/FZCie?=
 =?us-ascii?Q?EJTCXuYIaSvqvHUdSgs7MZsqVaNpBQtcE9d6bC3itwsGGfUhHjJ0Dj0mp+zq?=
 =?us-ascii?Q?6lllutAtiNgKAffggUuJEWm27m/sc4Oz8Jjw36Rwpu1klW08E3O1tfdo6Cph?=
 =?us-ascii?Q?TlC/YE2kRDr/L9B+GEVl+hIgThxQRE7Tnl+hfBQ0zL8GGp5T+nw/ggHRZKDv?=
 =?us-ascii?Q?FVUbVeBKhUp/AVPgRmHPifMHKm0LE/rF4+kN3j2IgQW17vEaX5jOHcB84Vw6?=
 =?us-ascii?Q?4zP3w69DfWNFfCSKk081Nx/cWE3/nIfLXHpG/41EyaX5HhyCd/Q2k+Mmg7G2?=
 =?us-ascii?Q?XN0z+Ryl5DymCDqFhqn29Nyl39y4P1TZNRGplX8dX9jP/I1kkiWVWZQEV9JM?=
 =?us-ascii?Q?zRcJ0x0pG9JEZX5uXh99Cw6PCTtOvk0G9R121lbN0B3zS81jh+oU33SbDoF7?=
 =?us-ascii?Q?+Yhh8roKndu8V5b780kf1eRKojjM9e8Jy44zE7KK8Q7DAO5oj7MtFF0tusmP?=
 =?us-ascii?Q?q1V5AH10FEESTsbm43t7CoUPhbLB0SadP/9lC4C4vQsxPC8KzF/uAO0DzK6n?=
 =?us-ascii?Q?KZfOM1M0Lu6m7c3uXW3XjHgf8CtGAmWba7nBjDilmdl/4nAeLOcGaBMtllm1?=
 =?us-ascii?Q?EUh78CPA5JpZh6gpyqQCoeid24EdkbJItAepV4BbV0COjglVxQtAlnZPQPEB?=
 =?us-ascii?Q?5CVa2dBQDqoWaxW+et0oT8uvxcw0I3cyKLngTT8xznLHmLeZZ1EZ4KpOR4bs?=
 =?us-ascii?Q?o9HALO/JkiA2xDQiGTPDlZbnhBZCcd3Z2JVtoKJZgt6neFTZXJZMSchOELUW?=
 =?us-ascii?Q?kLTR2AG+I6TSeSJMenw0cxztmjNBsyoyPsESsaPN8aeFkUCMgIv+K5WO11fZ?=
 =?us-ascii?Q?yZoAjljSeTPJkbKZ0H2Ik0zKp50TlhJGNzOK2THRDML+pYhW+aoIM9vXlvmX?=
 =?us-ascii?Q?dgFWHZ1QmszgjcqM64BKVFi3wAHmbeKPgeljZ+mw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: Monday, September 12, 2022 8:33 AM
>  ...
> Existing code is causing a race condition where dirt_needed value is
> already set by the host and gets overwritten with default value. Remove
> this default setting of dirt_needed, to avoid overwriting the value
> received in the channel callback set by vmbus_open. Removing this
> setting also means the default value for dirt_needed is changed to false
> as it's allocated by kzalloc which is similar to legacy hyperv_fb driver.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
