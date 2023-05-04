Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D626F68E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjEDKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEDKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:12:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F43586
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683195172; x=1714731172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GnMpqvqRImXKjlhB/jQwRfMf65HNJp/uPKHMZhyrctw=;
  b=IDRrnKhqLrvzThG1v075axCBfea6o4MEGwBZmIV+klIC64fLKlYBgiTz
   DoRglC7uv4Mo7nogveGF9r8DZRVTbQpjBMwGZzHOEvFPGPy9IqM0/ogJX
   ONUebziBlkdJh45ODUjdjA4yi9RN6PQNoCcBi0TpQVaTL9fpGAXcbyej0
   LePjbSu0drKZaRILOQi+pj29lC8nOqLHnA8O6gt2X2AbF+EpxpdiwtbCu
   l9+B4z0AcUCPzq+n5uYQvcAjh5lqhEerbh3QmT0tB3kO2JtmukeLtFfkX
   +yIqqJa3Gp0+Es/kvIvmQ5xl0+b9nwAH1qSDB/557vzT7+Zkid8AF/A7E
   A==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677513600"; 
   d="scan'208";a="334307337"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2023 18:12:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEUAk8m6yawk8IfxdO3y6w281ejuLGzH9DRgiQpblXxAPLFod+Cy9CZkgbf9xsxCUMW22K+H5yUwOF50GzBRfm4+dbfd7IK18LxIFZQ6/BNJkpEEQGFkhv6tYzq5Tubz+yX/zXkBlTFcTovkcfHfVtiV0AeaXF6RmKSYVRa9qTP6jzXojC75Q9xTeNrF5M/QfYsHaxJ0j3E5y6rEAC4YyWCHfiO2QnAMeUrgxtdvIxx0QJjIV0fhlSE14jWDP9yJGJxsEDtl5yR0lmBLlnvk76WoNhxggLoAGn8RSdaGjnKaJNdPAaiw3/tttbg9kuS2/1BEGaxWzK3fygW0GBb0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnMpqvqRImXKjlhB/jQwRfMf65HNJp/uPKHMZhyrctw=;
 b=Q4NcpncBtSuBvXyBMd9pRi0zuU0jJtvMN9KEb/zM+chzrn+kS3kLyVpSQe7RnFOAmQ3L4iuc+DYPF32HcCkeeXnofLqRByzS+d+kmFX4MKfWT9hnTQM25Bh+WYzeVDX3/wt3oOyYn7+5qqsl8BmN1gpps8KFEO4MlVxoKny9Q0ubW2U4JwBdsQ+drLk5UnDwsC9Wg0kWq8CEQU599Ne9REl+S63PAT6zxrc747AAE8YCZp9IlZRVaAcZYnxWG5bMYsT/u942bP0jTiu6BKkjv218IHeE7Gy38u6lOppaiEggX3KlQv2T8XwlD8v/baQGe1semX1os8RPz0O8oW9uYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnMpqvqRImXKjlhB/jQwRfMf65HNJp/uPKHMZhyrctw=;
 b=c9BKtOU3LXB7KoL93iExBH6mgobC3kZSL9bOwwiGnbG/b6ozq6G94S0ZifX0em9zJNccZhPVOXRlrgZebT7GgsxLv/zelNQHFIfEWBm6wZAFjdqwsll4QJmBapdEG5D3+d0FPUucQkDBb9M5z/rcQfs15kp02cWGP/R2bvzyKoI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7247.namprd04.prod.outlook.com (2603:10b6:a03:29e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 10:12:48 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 10:12:47 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "jiweisun126@126.com" <jiweisun126@126.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "ahuang12@lenovo.com" <ahuang12@lenovo.com>,
        "sunjw10@lenovo.com" <sunjw10@lenovo.com>
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Thread-Topic: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Thread-Index: AQHZfmxhAnBWBykOJUOdfcgNJU7LAa9J5RgA
Date:   Thu, 4 May 2023 10:12:46 +0000
Message-ID: <ZFOFHv8Kh/7KLuBa@x1-carbon>
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
 <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
 <ZFN9aWYCxJW/HdHi@x1-carbon>
In-Reply-To: <ZFN9aWYCxJW/HdHi@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7247:EE_
x-ms-office365-filtering-correlation-id: 5f8f0247-e43d-450a-6ece-08db4c881bea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZod7mR8UqsMWQv0xdiUDrOYP1kjAIdGiC220foJWN57WzMz4T+fsaSJRM0Qp5VpQlq4v9G13XzMK3pEY+s8lT6S17R1ebM253fInk+UH3L6JXK2BcTvaZgd2i8DWXzuqB50P7usO+V5/dfzHDf4dFMhtyTM0AbJJEJHbDe/ybugJPMG3BXtC6DgV1xL+eYNM8YEacbyFFVXbdI63zDp6bFhLzB3nrjEbkAX99Y0isF3J0sB3TfvgrGavpt2ziQRfDJEkSjK6riOs/8FT9QB8BykfN23Fwv1b3Ouk/CfxGC2NFvednapQvnb5ftkwPVaRDAMDtHB3lT3eP+MOFJhe0Ed3aeAnCAug5zXIAh82feoFqnTvru/nYwGjdiuRLo6TOyS60VsGb5aRr2mBOEJ0RHMEeu+5jjh9+rhLdzyqITlQqnMPq9xTOnHwYzekL4qJmel8Z000A5kfJ5tjVhOuOIxUML0mFYFL0A8GAGf74I4t/0NnMi26df0uIFwMCergOo6e3jb9SJbAIGUgr5YoR94oWRVmh4DqAIjiDNeb0cVydQ+RJDy2bUL8wiaGOyeqfLmTSxo7jTL5kLK7kkCtjj0lNSTDAQTR6QUFNscoTTmq/ifU1Y1PG+wWQ3dcpH0EG+bWox8shTq2igkwl9mLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(33716001)(2906002)(66556008)(38100700002)(122000001)(38070700005)(82960400001)(9686003)(6506007)(26005)(6512007)(186003)(83380400001)(8936002)(8676002)(5660300002)(7416002)(966005)(316002)(71200400001)(478600001)(86362001)(110136005)(6486002)(64756008)(4326008)(66446008)(41300700001)(54906003)(66476007)(76116006)(91956017)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WWxs8J8MLTsmrPJXa9PrRJIB9TXz/WHka5xgm9jc7KBIntdhs3Y6juLgm/Sk?=
 =?us-ascii?Q?KtaIiA/chYYj+PKFeZys8yUbZpHJoFl9dZbqJIMU9cu9RwlfjGa4mmknKSrp?=
 =?us-ascii?Q?FkyrTv5bfxaUCrkoMa2mPEC8UIrzRf02MC07hhoQws3j5IiM6h7beX5kcs4K?=
 =?us-ascii?Q?O2O5FoEB8OtvSArJcJpErE8u+r4VXkVVD8ocC4gqB+jR72/abIr9NIuWU1q6?=
 =?us-ascii?Q?68onzSHq9hAHZZFFHjwTOpf+EYgogZwXwdYRyTWeI59XDOK/wrCgev7uzC9N?=
 =?us-ascii?Q?5D3yjFarzc90XtXz7gINjRzAbhHJJT6WuKzikZQzAnUQkBxW7egbeuBDgeVV?=
 =?us-ascii?Q?Ao3A4y1S1hWxPNpZRbHUGcpZAlrGrdDBt9SKlNO47VShGhXjxTPRXS1OIrpg?=
 =?us-ascii?Q?1xcq0T6QhFJeXHP8klii/kAPCm/TGRh8RQK1PjT2o0kUIeXwFZEShhtUH+4T?=
 =?us-ascii?Q?yriz2055/c2NBqsVnecPjPTrCX/8EWe1ba9j4navgUfAUfvgjC/CfdTo5nMh?=
 =?us-ascii?Q?lFL9wt4KDeCVI4H8h4MaVsrSG0xhlcJOgaS8Rm9VRMpY187jvE1RGicsW6SH?=
 =?us-ascii?Q?khn74n6DT6LNuCFbYD2L4aKxtgo+mfHKw9PZtpB6MPDQG/eYI2gMNXPA0S+U?=
 =?us-ascii?Q?Y3veZj5LpjLONQ54khPj7NZIJVODThPjtyUqtZioScP7PVxSZV5MIHuWGLo2?=
 =?us-ascii?Q?wpBxMhiF43RkCG3kD3BfyTCY/0Gx/UvcmokbRnUC2aVEZzzkIiNy7gz6VjqW?=
 =?us-ascii?Q?kgUzgW1m53QNNBh03a+dtBjHDSYzcNJyPbzWjNln3HpYxftwPbGYEogvsABC?=
 =?us-ascii?Q?cOmzKqpe5T3Z7/KVdlCohCXVFpC7T+tskHW8uLCk9SEMavIBMV2Rq82U5wyM?=
 =?us-ascii?Q?wlcs9KhYRi+SzK1JNnJHDl0iYnulN1qMQFxZZHezq94SGoim/xBUVmDhl19U?=
 =?us-ascii?Q?Wx48kwHo4BtIlrOq70BB4Vd42/BAi7gt5vIEGu6nmsr4GNJMeywDap0/mU4z?=
 =?us-ascii?Q?X8a1Cqflr/fvvq36udSsKE4I02qTBJyA8LHTqrwlJlIAE/lbZaPXZR/HzWiz?=
 =?us-ascii?Q?jemtkyOfbyEEskUSBvzU5jILFnPMvAOcVxIIGsGwn4Ee/5H0EGtHCdCD8ahV?=
 =?us-ascii?Q?BpO7wTEidTe1stv3Su1kDNtctqs4y0wvWsEHA6NtW/24Q5uV640dOvM1wBri?=
 =?us-ascii?Q?fkYUoAf7O13mF0XIsQe4QT/bpHlgKnlL9OzNC3c3AdDkNoHKDQDAa6cr6TNy?=
 =?us-ascii?Q?GMOFV8aH8lDN7O/a1UNtFo0wTDg3C3EO6HGUUcEGduantZO3Duefvxej/XmZ?=
 =?us-ascii?Q?b+0yvwMnrAl/CbOyhSsoQnZ9QTVnHP3fT4tom581fotkI3LhIgpth3DjFdEm?=
 =?us-ascii?Q?P6COlIVlqY/aSa5yl73ZpMrIFC580izI5kY6b6tK3DD2+ZLqB+VoUifULF3e?=
 =?us-ascii?Q?kk+Hm9S4OeiMfMIZCxoUhXKXaGRDgpSOSx+KVkgLEG8Omb9DFnr9n74Ct8Ox?=
 =?us-ascii?Q?mjQ8hOiMXTm4T5vZw4q6CL1tOlii04JO0jCnLaBUmd4UV+Z7gEL28BWgcV1c?=
 =?us-ascii?Q?rnLjJjn2mldlnvGmPq+QYT8RPQupZZSrTd6Y4vlExW7LS/aP2AGBDLba9gDn?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A849DC46C37A3645924C50AEA9550C2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0oS/9ruimkJYj5MtQorGthY+U40O4qk0ysLU+zTU6ygxJJGjkJCTLuRhn9jP?=
 =?us-ascii?Q?FsXjicppNUO4Xhhi7WEamatmYA27CcOQMKsqCe2C5kAzzPRcX1QfWsDFEtUp?=
 =?us-ascii?Q?3+Van6ampfPScyLgffnRfr8KI720fvRkhDQm9NZwCs+NH+f8jMuAu7ZK2jvC?=
 =?us-ascii?Q?3sWC69MsI0wWehBacDwaAUYk8XAxafmSNUte3lBBZTzs5Y/soPBvai07pNHv?=
 =?us-ascii?Q?b+TwsolTWwYDRbSsiklwyYjjOeKDfzQ2iOPS/vW7ryt8z37xtHwzDoAytFOo?=
 =?us-ascii?Q?oXPkm749WyxCcBL4iyNouAFIAv96I9fC8mrSjxgUvKLUtktW0KyqeX7rWk/f?=
 =?us-ascii?Q?hMBO9frWv2Z/tqdKVct1efasqjpZChImcZ24VASq0M5vs1cz2060zijPFbPY?=
 =?us-ascii?Q?JkmQHSkD1ADWw2gzs9vBTwByu6q+mwbqNBJ9f/oHIeldkZ7WiSTxbAZHNzY2?=
 =?us-ascii?Q?9LKnBK7uhn5L3/+C4+2gp8BpZxM062YveU+7Gd03Wv2HafLTvYQQ2B4Ubpg8?=
 =?us-ascii?Q?sVwEfgM+nD6SHU+UTvSuthFwxxHj7stIp7gcYoYRzZBbI+Qpa5RtF0A+OkcJ?=
 =?us-ascii?Q?3KJpefIUMdHtTadWCBrnm3ylTFlBpX4hskIVKCjEh1gU5peVeapdlorTvr5n?=
 =?us-ascii?Q?NtvmFY3A46rEdIcTCdmDnn4FN1XGToZasbiKGwm1oQrfwj7F2GTQYftivOXn?=
 =?us-ascii?Q?7IJ2ycOw4HGR8YsMXJIyNexpgu/Y7azAcR5qEMrSmvkCCVaoQssj/yiLZJTY?=
 =?us-ascii?Q?Kid0HGD6V6zSgLxq6oTY5liiVP1VoAYcjCCZvverHYUXWMdocG3jfi6cWKYu?=
 =?us-ascii?Q?O572Ap4O9QQU7CdXbeA3fIcgw6/sAT/wxp607cahDC7dwJSolUcki/I5yTfH?=
 =?us-ascii?Q?zQt4MJ4h8R6tPnMPJNX1+/W641zkskuaUlE9IwzJ+fBF0iWtlG+Xs5Lu1rSk?=
 =?us-ascii?Q?5j5Y4RRpyTKRdgLuDsj40mdlOcOo8AqmsiZWs662iRvwhxU6WH9tXbslFBE0?=
 =?us-ascii?Q?8dJ1GUv6VxhTk+FxPn4W8Q2TEEaD7xuofrOG+Fp6N9GjxQg=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8f0247-e43d-450a-6ece-08db4c881bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 10:12:47.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvwdVv/6uj8XFnJf58F8Bm7Y92hEz3UYXh4gVU1fx1ZRFFcazVkYvildRCG7elS2soCWOoajrKe6dTKL/st1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7247
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:39:53AM +0200, Niklas Cassel wrote:
> On Wed, May 03, 2023 at 05:42:22PM -0600, Keith Busch wrote:
> > On Wed, May 03, 2023 at 10:28:53AM -0600, Keith Busch wrote:
> > > On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> > > > According to the above two logs, we can know the nvme_irq() cost to=
o much
> > > > time, in the above case, about 4.8 second. And we can also know tha=
t the
> > > > main bottlenecks is in the competition for the spin lock pool->lock=
.
> > >=20
> > > I have a fix that makes pool->lock critical section much shorter and =
constant
> > > time. It was staged in mm tree for months, but mysteriously it's miss=
ing...
> >=20
> > Well this is certainly odd: the commit I'm referring to is in Linus' lo=
g, but
> > the file it modified is not updated. What kind of 'git' madness is this=
??
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Da4de12a032fa6d0670aa0bb43a2bf9f812680d0f
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/=
mm/dmapool.c
> >=20
>=20
> Hmm, this is very interesting indeed.
>=20
> It looks like:
> a4de12a032fa ("dmapool: link blocks across pages") matches
> https://patchwork.kernel.org/project/linux-mm/patch/20230126215125.406975=
1-12-kbusch@meta.com/
> so everything good.
>=20
> However, the following commit:
> 2d55c16c0c54 ("dmapool: create/destroy cleanup")
> does not match what was on the list:
> https://patchwork.kernel.org/project/linux-mm/patch/20230126215125.406975=
1-13-kbusch@meta.com/
>=20
>=20
>=20
> It kind of looks like
> 2d55c16c0c54 ("dmapool: create/destroy cleanup") is actually
> a revert of a4de12a032fa ("dmapool: link blocks across pages"),
> plus some additional changes. Scary.
>=20
>=20
>=20
> Additionally, it seems like the fix:
> https://patchwork.kernel.org/project/linux-mm/patch/20230221165400.159524=
7-1-kbusch@meta.com/
> was never merged.
>=20
>=20
> Something is fishy here...
>=20
> (Perhaps the maintainer did a git revert instead of applying the fix...
> and accidentally squashed the revert with a proper commit...
> But even that does not make sense, as there simply seems to be too many
> lines changed in 2d55c16c0c54 ("dmapool: create/destroy cleanup") for tha=
t
> to be the case...)

It seems like the additional lines in
2d55c16c0c54 ("dmapool: create/destroy cleanup") is explained by the
maintainer (probably accidentally) reverting additional patches in that
very same commit.

It seems like that commit reverted all changes to mm/dmapool.c since v6.3:

$ git log --oneline 2d55c16c0c54325bf15286cfa6ba6c268036b9e4 --not v6.3 mm/=
dmapool.c=20
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


$ git diff v6.3 2d55c16c0c54325bf15286cfa6ba6c268036b9e4 mm/dmapool.c
<nothing>


Should probably tell Andrew so that he has time to send out a new PR
before the merge window closes. (I added him in To: .)

He should probably pick up this fix too:
https://patchwork.kernel.org/project/linux-mm/patch/20230221165400.1595247-=
1-kbusch@meta.com/


Kind regards,
Niklas
