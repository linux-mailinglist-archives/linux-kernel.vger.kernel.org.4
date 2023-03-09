Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBC6B26D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCIOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjCIOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:23:42 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F485ADFE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:23:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah6Y56B/WjQD8AyqPe7SRf8JqIB2+41WxgOOLKrJagiWSOeheOqNTqSYgf6ijn9xfybDErR5KrVX0KgPUAT52GqxhlvP16PFXPPVNgk3k1W2QmctxMFCW41Nz1PnDEnZQkpG7iD6GcNVJx2Zq05aVn9w86ak7sww2ZrEbWNix3dIMMymHdJDnWJ3OhVWxDF4WSQ2+3XWVlWsQa4Mmf7pXzNq2TE63hbgYVdbS8Zn5Hom53EOwcfhFC8+No0g6H6xzvpF4UcUn9E8vTW4FNnZQWDDDd/lwq0y3b9qomSTok5ZwRO5AjkDmNcKj/zwNqzDL990NglKzKxGOYg4XLdrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m62Y+eysyJNiUrn5SxwPowtrHvHdLTNQRVHsOW+KXqw=;
 b=aiudDyHJ0GN+mSbiih5PhP39CkLwNkVO1HCIJAb4/dGpmKpGHbab2E9mE/QfKv0BQIE63P7ZD/p3vxKM3L8T97CF5zEwEyEoeCeEZTTggudTYk9NkyVGtxrzoKsdZVRWkOtXiK0V/AxHi7S1zeSssZH/OySZyNSl00nmE51MPsmWhvHjMR0ohIzR+LJYa8q77t3zpwhzqFWIyj0MNH1HFoex1iF6OVBCAT1kqOhvAM7JutydARfYHYem16UUXz0XnZynFnHsXWO6/6Tc9Um2N0SL2L99ZIGJ/y17CHAD7nz12QrnMwhxAp7/rFx1HHZdcy5KxZ2/nbDzFkAbGyYD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m62Y+eysyJNiUrn5SxwPowtrHvHdLTNQRVHsOW+KXqw=;
 b=Rhx5UeeaHS4uQsRQdXMXumG4H2ayQWALcrNFXFWqzL+xBl3akzm8uOnFXTWcb2vXPiTVFc+wUFisa+JR8X/uqytY7zTnZnI34TNN1IRIln7drXQAHdfPjz9W57Q9nghyrBEBt9ooCH4bFnQPI4hYgBKfBn8TOOlXhz/FKED3drw=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 14:23:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 14:23:30 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "elvis.angelaccio@kde.org" <elvis.angelaccio@kde.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] nvme: Add a module parameter for users to force simple
 suspend
Thread-Topic: [PATCH v2] nvme: Add a module parameter for users to force
 simple suspend
Thread-Index: AQHZTH0Tsp4t6Xp13UCd8cI/Q8PRaK7yPGeAgABOs4A=
Date:   Thu, 9 Mar 2023 14:23:30 +0000
Message-ID: <MN0PR12MB6101A9B8917BF29458D8C89AE2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230301203302.28889-1-mario.limonciello@amd.com>
 <20230309093657.GA24373@lst.de>
In-Reply-To: <20230309093657.GA24373@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-09T14:23:28Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cbbe1a7c-e1b5-4230-94fc-6703095fbb19;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-09T14:23:28Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e419b22c-a3bd-43e2-ab56-d056ce1a79e3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH0PR12MB7908:EE_
x-ms-office365-filtering-correlation-id: 81e2ba49-5644-4218-228d-08db20a9db23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6MLhBB5Uu3KCgwzooTVfule6975hc4dLGJkSwHTODwlvVjvYCwVhceuKZCt0T8iAmO8rfulKMujv0gfJfTXLMmJIcBuCunZxJVgcoSm5T4FtBFsK76dzIaz0NmTXPNjTysT2cnnZf2zr/UfrXk3m6Vkpx480/wQL3IBxC+1DhIGjy+vLtI0BxpvDKYvvvgcldLINBChveUdQLjXeIgR2Aejq2QkkzoMxQRpx7GNguUpEYiLZVVU9t/no71xGqjbpbRn6wz+sovAyuGJRpSWx52RAi03jiK+ktX3YEobW/ZxPUbZTfalHVcisjCdluuroboIDvdyvtUpKJOtJwvSG8ez1mMcY5nBnhAGTQVWZ7rWJdwWtbBUpl8hlkKbHcS4/+PrbpgJrZSYluwxm1B+eRiRHfBCqZ36eQLgQbJh+PGe6l9kaACFWmALtmELKAC+6GfG0+WFJrB+GaxDHYxvxO9x6TEPLg/dZ+ui8z4sLnuD8+9joPAdAoyfBuTqEtU5kvhZZr61+8w7ZAA4ZUGZQEXpaQnjpUj61hxAcv8KCxg7/2FE0Kh5LGlcOqAt+N665iD7YPNFmvxEKbQd1n8Geyqe9yMtyRqR9vTA09FLPTjvFTRXsd/1DL3+lEBizYq+dJ6PDD7hnwrUa+o5nps5XNEI+wPh0rbUVPAtu7/dIQoIRW2/VRum81BPZBY7iDulYCpTpQJ/x29lACmG4mQlpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199018)(9686003)(2906002)(186003)(5660300002)(38100700002)(122000001)(4326008)(38070700005)(52536014)(76116006)(66446008)(41300700001)(6916009)(66946007)(7696005)(8676002)(66476007)(45080400002)(71200400001)(15650500001)(8936002)(66556008)(478600001)(26005)(53546011)(64756008)(86362001)(316002)(54906003)(83380400001)(33656002)(55016003)(66899018)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKux70wbjrcIwl+wNJlZcYs+M42J1DzFqwcOEpUpx2Dn55EST0s9MvS9K2jc?=
 =?us-ascii?Q?iNQTfTkjLBNAzIcAoLo/5TV0OLH308aA033LQITX2KCEA6STRYB8jwWzkOkg?=
 =?us-ascii?Q?6gUVh8Ct5XOg8QzWSGY73Z5TPW7vuWIsFLz2tDwo9bVD6/s3St9igpO6CxmC?=
 =?us-ascii?Q?FA/2jBFo24gjNPOC1Jo4zA3moNXmGUXm/9T4QSyB7q6upqk3UTayndPNgJhH?=
 =?us-ascii?Q?5U1+IQKUNyy6YBY6KwM0VbAPjiksxzbOaN8zKMtbIrcxdq7g0KAeAoxjgZbt?=
 =?us-ascii?Q?jUT62ak+W/ZM8qp/6SCu9RtM24/hJgYzPrTfca9BgTp1gUlQEytEPuorPIsy?=
 =?us-ascii?Q?GMOjmvRndvtgYQpaAgNuAjJSXWEpmrItPjy/8ZOW/2pldpszEY/hJg8kf+j5?=
 =?us-ascii?Q?1Ug4qPAd0/yBlNYrR+TOils3T6BYsy34qtiMPCOq/u+MUJDIQD/iPMn99Rp/?=
 =?us-ascii?Q?b+7M7IIEgwbz/c4KgaeRvJfG9YiKMD6FY7OX+1fdaxf9AL8VSsLBCzRVA7DV?=
 =?us-ascii?Q?in1nuVIhuCi6pkP3YhRmQ1SKsiAy/Nb96xVtXA8k7Dv6mZT6v7KKuN6AKA9f?=
 =?us-ascii?Q?fOimJmdiMTtQJsNhZfIktZwai/8WcZNtumUrcKhvv4E+Vyu5VFLxDyFFH+Lh?=
 =?us-ascii?Q?5JjfM8HvRmo9EBlhgUCzMbuN1h2HSfB+nAN/LolSLxIcFTyegg0c7BEMQnOx?=
 =?us-ascii?Q?PplobF2ttwP6WMop1PxdCThX0co7IZMKNjo3A2GUZQV2/9tHU0z7gI+wU8H8?=
 =?us-ascii?Q?e0cBPt30JXyVvp5V0o+N1HQ/nRy7ZW5/B9ScW98Onc4G/iSPeoYwtQtmVSGx?=
 =?us-ascii?Q?zVPsF1xQX/D6IKmbXD6I3eHN5q8CQssNVZcqyC9T44w0QhESKZs/cGx6s4i3?=
 =?us-ascii?Q?2T0ph6cfZ/EzQJauy14vGTCmMtYRgi/NayFOY3Cz8KXEHQYr33ZP5LcbLlg8?=
 =?us-ascii?Q?kV7FFwJ0fzCxBZEJN1fiWwipjz/dHn1tAewL9GCxVHpa7SiyJlumIURGGvYZ?=
 =?us-ascii?Q?UgbXFNvbSfPE9zeMpbolw5yCkG58+SoK+puxU8zSzPDgwEyoT2ILzgfDRvpC?=
 =?us-ascii?Q?P3g/UGCaoUTidX6i7aPGhqnMjsT5dO1e4wNaUD4OWu9FRpgTc8OfN1QuqK0C?=
 =?us-ascii?Q?sqU0PnA6K+fYJ3ePMaSNlC4syoRdIYu6/d0OxH8umTlvUv+oCeUkknXaoN3s?=
 =?us-ascii?Q?ilJNSuJr4QLa45F494RRGWtJiepMpV0fou7Dm3HQJBQjiAZWN+4at0tqkhtn?=
 =?us-ascii?Q?aw5mCpUV1xxua1FOlrjC4NkMVS2+DJAMH04dfJbFdrZa8qhOmaFGVZQl1nx8?=
 =?us-ascii?Q?4VzHK2NF41P28e4xyqIVZrVDDHqmc1tLFlKln2mLnube+lctHJqKhKc688/H?=
 =?us-ascii?Q?G52EmCh2VwDvE38WFRjKI8qq1/I0/qv56INWrjI3m3C1TNRyOlfXbgryYyWq?=
 =?us-ascii?Q?4S5UGAEPF/QijQB89870joVO3bMwG2EnKH0eK9lnn5/DE3FueJYGbAKjKVvO?=
 =?us-ascii?Q?Rje/zIdEekWDDkc/r29ipdBF7bDTaph4Hqsd11I/KGLAo/Xvlk44C3Uo7UQf?=
 =?us-ascii?Q?wTQM62hFv1f4wGbiL1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e2ba49-5644-4218-228d-08db20a9db23
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:23:30.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw5u71Jb7kZAdgLrt86BHL7Ka5oMQe2Fj9HX97SShgrRjhuzuGxSInIpbuo5+S6q73vLtoGhdC8bncx7P3vO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Thursday, March 9, 2023 03:37
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>;
> elvis.angelaccio@kde.org; linux-nvme@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] nvme: Add a module parameter for users to force
> simple suspend
>=20
> On Wed, Mar 01, 2023 at 02:33:01PM -0600, Mario Limonciello wrote:
> > Elvis Angelaccio reports that his HP laptop that has two SSDs takes
> > a long time to resume from suspend to idle and has low hardware sleep
> > residency.  In analyzing the logs and acpidump from the BIOS it's clear
> > that BIOS does set the StorageD3Enable _DSD property but it's only
> > set on one of the SSDs.
>=20
> Please quirk the platform in the PCIe core instead of requiring the
> user to override manually in the nvme drivers that is not relevant.
>=20

OK for this situation reported I'll quirk it another way.

> And as a representative for a CPU/platform vendor that is all behind
> this stupid crap please work with Microsoft and Intel to sort it out
> properly the firmware level.  It's a never ending pain caused on us
> that you guys caused for absolutely no reason.

The primary way to do this is via the _DSD, but for whatever reason
Microsoft also offers:
1) An allow list of old parts without the _DSD
2) A knob in the OS users can touch
3) A setting that OEMs can set in the factory

Any OEM that works with us on enabling Linux on their hardware I'll make
sure they have the _DSD for all the ports they use SSDs.
