Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1376DB647
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjDGWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDGWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:01:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2114.outbound.protection.outlook.com [40.107.220.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7435FF0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltMacFhTtKvWatG/fh6NiC16l92zOeLuuqNs6jXX+FHdGRPUaMoczysX+Q1d0aH75K6V30hvINxfdwK6pMgXpAxot1BBF22W6md5B4gHhyuExGp5KQmahFWGOXyx3qrRUMmbvIDv1GVL5d/buQHdbSBfEinorbFAQPHletDwITpKYIJ5xgiadT2cBsAEQHX3FWJ/MUzvRwso6D6NEpfSW838yWXM+rJFFMw0uGcqEc8Pzut/ovdbZicP7wPIwiisMSOqWAH55bSlnot4yjfA/i8Z2VbawIDA0kvM13r1GoFF6EW+HaQx4JG52uUAZjQwsJMXtbxOBWfxbDogjUY+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5QGQDncpDArdzOPS2+EMVz2Z0yvDZKvCn6K60j0PNI=;
 b=azOdEV+d7zm5+pGEcDJImrvqJklSC1dqmATwlB00192xCrYQNY2vgDp8bBtdJa3/lZ0WvJpaY4iPCYrwI/tgdS6Vd4u/8aqwtmKuHb/5ZgCh02BDd/mni1/7py8RsbweQG2sJtC9JetPjE0qcEqPNikVPmJYv3gb6VA02Y8STIHygmjwyF242kHbegRH8y95/WzZwZDyvvrHB2qknU2J5IJrD8lbyFPKJD4PWSZKdjuQeHXackAnmNE4vGcWUeIMl+bzCvGqqCJE4VME4khdwlQcYvSPKzW9yWnkwrzjJGg4E8VGfKw0paO8oHlIlxKumZNb82p9q0mv+6TaFBIiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5QGQDncpDArdzOPS2+EMVz2Z0yvDZKvCn6K60j0PNI=;
 b=PW/Jx+GRUTMvOOut+UJUrVVMtrx/8zuxTIMT6PqDb1+1kCqUKMQSOpUQtZA3aJDuB/Hgn7Rg7YpT1Sxz+dz5xVl9UguBH1z6ZynElFdP4XTXIknlK6SL5Xvfl2IWLqwHJaWgWyzyiFEeISifLWbRRkQZ3yFkW7Bn5OYz8p+x9U4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3057.namprd21.prod.outlook.com (2603:10b6:8:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.18; Fri, 7 Apr
 2023 22:01:14 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 22:01:13 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZZFTgGkCO6sw65k+irtwUSCAKHq8fYP4AgAENH9A=
Date:   Fri, 7 Apr 2023 22:01:13 +0000
Message-ID: <BYAPR21MB1688CCCC4CFC597A3C12E370D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
 <20230407055016.GA6803@lst.de>
In-Reply-To: <20230407055016.GA6803@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49336081-26d3-4a3f-bf75-807d2b920de1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T21:53:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3057:EE_
x-ms-office365-filtering-correlation-id: 16efda05-8c53-44fb-5f68-08db37b39ac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VW8h1wWpy9MMeevgMiIsxXQ1eMD+xi1qmF3xJKdEG9x4RFa4DPdqghJuNKXSM28YbBa1IRs28TXW9wzK5xAh4xR0OP4f08B45KFD+QUhWqwq+JiGXsyCPeyr6FgXwn8+E6/GCO031eMcGPh4+VGE9RNqrT6e82N9OCsff40C67r4Kwg0PDWKLkABackW75deH1EEbmtCoBpc+D6uPD3rXLKey9jot69s9adyqAjtN2Fza3s0m5mFDjIDS8sIvoKWAk1sKBaFR86vWkPGWrzQNuPj6WUHC2MTx2CNOAYfUa/AshjRJ7jU2/HJj7FFG2db7XUPJkPluj+qrDy2uKU2avCWZjflrT++Umjzi3NCgeq1XIbNJxEOT9BxQGpzyu0eg9bAf84+lJO9sSCCVerBYARtvgQ3QoTUJykZS7OzIOeJCyHe1CMtAAPDd8Z8afEwD5mSvZvFd8DzyaE7087zxBHBMq+SkK93/MoSQxPkxEkA2SogfGca/0LepUWoF+phHtkKTqZU3OoulvIgXACeaM8S/s8qdYMeV4aqjQMONnHSWdda6NIP99QlmQps1fE/QUhvGYqYrie3gOfr9J1CJDf3JFSX/a+uZKXtoVL1WIzo/JvxSuyoTikEQiYE2hRqbUgpMO6T9BKD5RjJl7ioyY5jEQa15+EQ4jwKzYrZ/1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(38070700005)(5660300002)(2906002)(52536014)(38100700002)(82950400001)(82960400001)(55016003)(122000001)(33656002)(86362001)(8990500004)(186003)(54906003)(316002)(71200400001)(76116006)(66946007)(66556008)(66446008)(6916009)(4326008)(64756008)(66476007)(7696005)(26005)(478600001)(9686003)(6506007)(41300700001)(10290500003)(786003)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yzgjaBpsYw43dyui98JtCwRwCzn+r8hhsh0y0cXxoYsSHAyfeZ1GkMZE2U89?=
 =?us-ascii?Q?uABzcjF8R0EsblKATFfAWhKYGDDGeLc7e5nZ9F/8LtvegkXhQlXwwrDKIDO6?=
 =?us-ascii?Q?hKhPn3pwIgI4Xd/hymh2GtVJQHRJk4eBA5XqQQ2nvtTIgemqiHworHEDRVK3?=
 =?us-ascii?Q?QBoWj9yjWnJ6tz0p1hhDATi1noPdXK+iPPSa4e7v7V0+vuDn0rTkMOgKJlmG?=
 =?us-ascii?Q?0FyIU9GdhFgeAqhdWyu56fSukLQX2xAmUwOUBtAJnJJUyH4xhypys13RoGFv?=
 =?us-ascii?Q?CFwciMlEJ+R5Yo5TYJpkpTiUfURrtv3dktYLuGnCfuc4OMHoY8ZXzchsKE4r?=
 =?us-ascii?Q?bGXoajoyd66nzfORWcqhF5XTLw97D4MOZP9n9R5Ngd1HlIMclICoyO80zZtr?=
 =?us-ascii?Q?U9R1MbJtN0FtEiUgBPr7F6yQwdS2+8CeVSFedSgwxYcD2tldiIoiywDqNY8H?=
 =?us-ascii?Q?cfxT8gqMAalMfv+pj9MYbzUXTfdoi7BIBtC9MSC1u0uCzpp7r6JjDjbJ4C2u?=
 =?us-ascii?Q?s6MsJcMS6/mcJpm8B36w6RJouLO3AzYlyhOvG93Ib23L1c77/kz+7do8frS3?=
 =?us-ascii?Q?32rYS5PvjnzH2aXUyKV30W4s/3y2K64OGRT3Rk5dYQhCqyq17YKLMUY7A6Ib?=
 =?us-ascii?Q?m6BzMFnaqfgX9PWpg3w5svxpGOKRs4nsaTO0MXZwQAvLMM6GoVvSu5pchEv5?=
 =?us-ascii?Q?8uBusH5MH++Vcjnxqg1kcOlL8orvUIxoe2+tmmilLCrzrGZUdF6oKQOgXUz1?=
 =?us-ascii?Q?JsqTdD7F0pk1U7YyyVc6tVOBQ28jbnTidC2v9ThsFFyzv1Lr0DHOzOzi5tVT?=
 =?us-ascii?Q?dg3uQq0YPHnfWVq90ifo5qkmQ8li5385HjIAzjsHDbq7xrnbSchhMMJHgjLj?=
 =?us-ascii?Q?yJjEL9zKWDWy/NcqUboCYBVOGTI6DooGKmk1k3ElQY9cXYFtpXIvRmRlnbQP?=
 =?us-ascii?Q?cLmgex4ZOo3AStaXWvZSf21JOmFoSaDx3h77nCEhpSlH+L/pYgdh/AZgcfce?=
 =?us-ascii?Q?LNX97sGQWwMyDLQJ07BAU97diNiqMpBQ66b2CKtJULDeteJ58SHuP2xcltdt?=
 =?us-ascii?Q?HJOmOOlHMXyV/suj7YjEnEXwUIo2NV8UbN2PwyQwHd1Xye03xj5EMaxF4ZuC?=
 =?us-ascii?Q?8OR8uNN7hCVkgmGhi9TcwAepHXQThFVJHKJh6PASBqj0wViksWpA/4c8DGti?=
 =?us-ascii?Q?dZUlqgd7x7xx4tDqrl6CVTEfdax9dSb0SIYMe4mdom1UipHTfN/UiBYazPQ/?=
 =?us-ascii?Q?JFlfWtzxPQrdSpKo9W1mA+YcZFl4iTS3WkEDq4k+P9ukAH9BmacKMLeCRuDE?=
 =?us-ascii?Q?L9g9+bZ5hL73V/bSE2q2a8eLyPXKX5uR0jBvQsGCZZpcWqUL2v7kt9CebelZ?=
 =?us-ascii?Q?A111bvVPJ08DaKVaci+Nn+7gea3Q1/hc/6KovFv7Kvbtu1AfMtlo2Pk8pF+k?=
 =?us-ascii?Q?LMgZwxfAt2sE/+3zgrkNZ6RRodSIymrlGdheqMDBTeIk/mDbde0l3cIINyWl?=
 =?us-ascii?Q?f976HlE5lQZ0QFS6SmABz5HkHp0X2PtABkFd1QKAQ+MWRWaYKzXYnXCWand0?=
 =?us-ascii?Q?f3uyJK1ZkURLGzyEMHTdy6wIARz3hDcGWFAUeOJ2vM2Y4YpIjQ6NTPumilva?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16efda05-8c53-44fb-5f68-08db37b39ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 22:01:13.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ9+/YU5KT+PUn5sIXO9LGc0FkFkVEC+Bs2FyYsOvMpzdw/uVTbJzttcvljfZRPh43KcKBnhRdkAIDbEqW7PkPjEkx5Y0imH/i3gYLhVSvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3057
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de> Sent: Thursday, April 6, 2023 10:50 PM
>=20
> On Fri, Mar 31, 2023 at 09:45:00PM -0700, Michael Kelley wrote:
> > Changes in v3:
> > * Do high water mark accounting only when CONFIG_DEBUG_FS=3Dy. As
> >   as a result, add back the mem_used() function for the "swiotlb
> >   buffer is full" error message. [Christoph -- I didn't hear back
> >   whether this approach addresses your concern about one additional
> >   atomic operation when slots are allocated and again when freed. I've
> >   gone ahead with this new version, and we can obviously have further
> >   discussion.]
>=20
> Still not too happy, but at least debugfs is an interfact we could
> remove at any time.
>=20
> But can you please factor the used_hiwater accounting into two
> separate helpers that are udner CONFIG_DEBUG_FS and otherwise
> stubbed out, instead of adding the logic directly into
> swiotlb_do_find_slots and swiotlb_release_slots?

I coded the way I did to follow the kernel coding style guidance
that prefers converting a Kconfig symbol into a C boolean
expression, and using it in a normal C conditional instead of
using #ifdef.  If CONFIG_DEBUG_FS=3Dn, the compiler will constant
fold the conditional away so there's no runtime overhead.  I
like the way that approached worked out in this case, but if you prefer
separate functions with #ifdef and stubs, I don't feel strongly either way.

Michael
