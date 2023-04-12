Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B946DF003
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjDLJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDLJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:04:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1204206
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErEc2qjHAf1AHJ/RJp5Yy/9nZjzdi2MtusYBw8X24f6Xgqmb11DoGzeuU94cnL0gd6dOgcmdg/C1X4dKDWe2xWojJdxQ1G/wgeiEeLRVeZKseMfsNa6VEaiGcrxWWxsKEd2XExEyJT8S6yh0gWMSDl0T4d6iucjRXQCSuGWXkc9wUaWOTGGKqNPsYxfqWy1tMcMkrC9+rIbCjQhaoFsJyI6/uFW1W+zquLkvb6zFnQRsmb2x5QgEyK525/r9L32wlmlW3VVk2j8oWF3I+puipuHSJghsymvZZ9F1tcpPHpygP0uchFZyr8LpzKUNFi28PveGpcjjRG5Hg4wkV42ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnwamTCzNCoosmOSuUut08YNflJ0msr3BDZkjlTd9JU=;
 b=OaZXLbEv26qObBHwIOmxcUTWs5fFW6CFSmf+o+y57fFUhXxpUVlVW/DRsACsO+1L23Xg5X9MEfC7tJ0dR4FsQUl/W8dIeoCWzOjtIuP0mZJ0D/plHhkAaDxD0WfPmn5zCokF3S/WxjZJAWbu6RE6YroxBtrQB1G/1kIVcPXrPHJ1/ZKrVdymB8DJYNUyxaZoxU2ocseib+eZpVNTai1vwHaVrpWVj+NmG1Nt2aGAOJnCGr7f06b/bemG6oCV9pSzEeyh5MOR+G55jZu7QokXMw71uXMEpqOuulK6GjtautRRMIlvk75LXJKW4a3AD3gTAIV4NkK0NnrEacXjHgFseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnwamTCzNCoosmOSuUut08YNflJ0msr3BDZkjlTd9JU=;
 b=jOdx87L8eP7b4RZHc2r54kt4T5Q6AkTmWhPUpsjKVXzcRIOZySsQtms1Mgk13LG2iCQIyb3fzgBhkHLxXxCLZ1bGFsAP3/uaOch58pkDRs8ML6xH56AkNzjn65ncH8+p3waQzbZ4Ok1kfHdsg8xAKi8Ye/nKFYdI7OVNwl9p8f0=
Received: from MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 09:04:33 +0000
Received: from MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::8a8d:1887:c17e:4e0c]) by MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::8a8d:1887:c17e:4e0c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 09:04:33 +0000
From:   "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: find_get_page() VS pin_user_pages()
Thread-Topic: find_get_page() VS pin_user_pages()
Thread-Index: AdlsqyEC2Ib370amRP6esQRt2dSqSwAI4d6AABNzQCA=
Date:   Wed, 12 Apr 2023 09:04:33 +0000
Message-ID: <MW5PR12MB55984F39C8CECADDFE7548F2F09B9@MW5PR12MB5598.namprd12.prod.outlook.com>
References: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
 <87mt3ehti4.fsf@nvidia.com>
In-Reply-To: <87mt3ehti4.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5598:EE_|MW4PR12MB7288:EE_
x-ms-office365-filtering-correlation-id: bd301e30-1e6a-4bcf-aa74-08db3b34eede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDcLdwWbFdpNc+lzTU3sXrfG1AVK1bvOnsWGqL1w5lkRZX6iehldOLcavsdMNCnQXUeUGucUZRHX8c4OFnMuidz7JnEDpzzrylLxueyRKpcmuoSB+wb84D/r5oI2GtcrwZFySN9skYPadk2TA9GZzfxIB7xbcxVsr9ODTzgMQaHgpb7P5XfSWVqjR9JDRPSuMviklYYjnOvUcKr3693HhEvVFy6g4Izr4Hh1vieG9uZfaDzH1I5rIJ668hCj7IkEwSfw5gFKl95HCyRDeNQ1G/QruAv4cYW3NWnh1o4LCiNntzGdogvxycxJ4F8hjSIPqglCjjcvwydxwIljNwwMj9I2COe6jZrNLU6PuXTa3gNEkZ28H273E0K78ophqbuTXQEy4AhugYIHnLCBYz4W9iFiSaFcpu9KCHXQCsjh5sCDOxSE7fPOhWFbuVNYG8K/OzdlzOpERlM/hbbKgKTFrcAjIDSz95nVbJ1DUA1hjt4frHcXWFjvcXI4DCxIqpNmGJr4JfkLRfknyoTaLm+VoGrLdXAcExWQh/1po/VZ9lTAO7czby0CR6e/KPH2G1X68GmvWMlRxJkpENrQhV05BYwiSeeJxNn1y16+6Y83K1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR12MB5598.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(71200400001)(478600001)(7696005)(86362001)(83380400001)(33656002)(55016003)(122000001)(38070700005)(38100700002)(966005)(2906002)(6506007)(316002)(26005)(54906003)(9686003)(186003)(5660300002)(64756008)(66476007)(6916009)(66556008)(52536014)(8936002)(41300700001)(8676002)(4326008)(66446008)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SvAQV/4cADdk2kWL+JB2eWMGHArXnaqXY4EejCFzf4sTZ/ro2JTNLlPg61Vv?=
 =?us-ascii?Q?l6fY/AyK9o84OkJmJtHb4dcADAFjgXPcPXVc0AkVyp9PJ9/hFN6tvRAFqpPM?=
 =?us-ascii?Q?Sl1TqbM5lr9jUrrkhUGlQJl88ntJUQNURazWz6QA3cwXDgcfR0TQIMFgWZZ9?=
 =?us-ascii?Q?Ph2J28ay683/oegAY68FI5LKXVPsGGgVPjklUXcB+Vn+J5M8aOtcEVTlbheS?=
 =?us-ascii?Q?CpuXQdICJIBkoqVDT5nRjRKQyoMXWjW5d6CAAwYvqd7h26ixkXqzcTitk3cf?=
 =?us-ascii?Q?a5eq5iMghJFAzegpMqaXdtkTzdbMgX3JMtE1J1k0eYDH/YZiTNwgci4Ry3R8?=
 =?us-ascii?Q?/4prmDtx3LizHp5xemMP/TrYpglEgMvbdocNvwKf0c1DGKkJV0Ah82pQ0+A/?=
 =?us-ascii?Q?x5oUSvSuCl/RPR1RK1gD99QDj5IJacqpescbEGehfS/0PukXIQOqasdQiSrx?=
 =?us-ascii?Q?F77ThiT/OkG3s1UQ4LEq/zE9HsFw+UfMw7MuTtBMIRe0ONsinEASLB2t1wj2?=
 =?us-ascii?Q?iH3AsbmhWNv/OR8yvObvRoCRsQN0tNvzG28pBqY4rLNiuSrYTsMJqIBqzWgn?=
 =?us-ascii?Q?KkUDed6NPjAAPQEFlMxpYof0/OZ6ZF/85zIKAbhQ28AwSJUnlYPPjUQalU9E?=
 =?us-ascii?Q?GWzEj4m1ySM9Lbx2eKGNKbxnUep8A7ZYn+mfrkL8JpkwqlOCrnpDaQ2x5eFV?=
 =?us-ascii?Q?9eG118Yy1b8kmy3oGU1v6LOD0Xi258JEFbUu35oaRx7BH9jxT+YOQXWC05Uk?=
 =?us-ascii?Q?jzRq0HAOswBgV3NT/8YvB3FinPlqg5ahn9WWA/f6/ziaHs8nYeK52N61tmd0?=
 =?us-ascii?Q?NXo5WE4h368d2o+rSvny+eEmcEqZt/OKOS6hrMdSHaaA+eJSEnh5gAIlGH0o?=
 =?us-ascii?Q?Q3rl5d2L4Deyqxl696m145ntioyi9KVTTOXmKDo6VcZ91rI2ioCVO39eCeTG?=
 =?us-ascii?Q?s1S443H5Imf/2rB1HWWLAjyPZjaX05fMeNO3Pf23QydrY4v6IHPdEzAzozSX?=
 =?us-ascii?Q?cN+oUlvJ8z1S3J/Z3mkxTt2BcuozklmJQG2cgywPTmru92qZKGwA8LIWcHdi?=
 =?us-ascii?Q?Xf4l83aLHnJmH0Y/AZ5U5d73C8NFPwmAzJpcyZmOaE42Pl5rxEwX1/sgctxM?=
 =?us-ascii?Q?X6jvkgyilsPU9bgQEwv/2RuqMyRiTdW3dajWixCcRMRc8UiMVe5WF6LwvSZn?=
 =?us-ascii?Q?V3xfMEg2zYX3fbvjl2HATrZ6LRjftxLkbgu2N0DWakX5xKWKvsWMuzQXDpBv?=
 =?us-ascii?Q?ofasGxWW/gclwLGHXIFGxSy8eWMqvhHdB820vjxLDXj9wQtkFSULv7Nrk3BB?=
 =?us-ascii?Q?IzqC3FpxRECkZyQ38Dm2hIrwt1Q9M7EGB9MxPywV2QdLSnVA/ylAYGNTNXxi?=
 =?us-ascii?Q?cH/vpFkwaT40T82s+ZPBD/huuS8pxVlyb3CsVsOvyti29Cnmu4O5jQPoxNiX?=
 =?us-ascii?Q?gv+9KDKKfNvIaDB5zO/7HmMUwuU1KdmXcPyL1P+Jm9Bd92wPPR3bJZUkKOrm?=
 =?us-ascii?Q?mgOhNNFrKmpq08IYQ3udkVq3rhzVsGorAaiW0QK+cD+TQSLncQEE8oQ+o9DB?=
 =?us-ascii?Q?oh5OW2awrlDgwNBIT6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd301e30-1e6a-4bcf-aa74-08db3b34eede
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 09:04:33.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tL2L6xKulJj1iGSUiE5PpIYWTfrfLUZiMmX9LD/AfCpJ6WuxDBCIWaYllx9Ytj86offALJ62BsAj7jIhMFhhPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Popple <apopple@nvidia.com>=20

> "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com> writes:
>=20
> > Hello folks,
> >
> > I work with an application which aims to share memory in the userspace =
and
> > interact with the NIC DMA. The memory allocation workflow begins in the
> > userspace, which creates a new file backed by 2MiB hugepages with
> > memfd_create(MFD_HUGETLB, MFD_HUGE_2MB) and fallocate(). Then the users=
pace
> > makes an IOCTL to the kernel module with the file descriptor and size s=
o that
> > the kernel module can get the struct page with find_get_page(). Then th=
e kernel
> > module calls dma_map_single(page_address(page)) for NIC, which conclude=
s the
> > datapath. The allocated memory may (significantly) outlive the originat=
ing
> > userspace application. The hugepages stay mapped with NIC, and the kern=
el
> > module wants to continue using them and map to other applications that =
come and
> > go with vm_mmap().
> >
> > I am studying the pin_user_pages*() family of functions, and I wonder i=
f the
> > outlined workflow requires it. The hugepages do not page out, but they =
can move
> > as they may be allocated with GFP_HIGHUSER_MOVABLE. However, find_get_p=
age()
> > must increment the page reference counter without mapping and prevent i=
t from
> > moving. In particular, https://docs.kernel.org/mm/page_migration.html:
>=20
> I'm not super familiar with the memfd_create()/find_get_page() workflow
> but is there some reason you're not using pin_user_pages*(FOLL_LONGTERM)
> to get the struct page initially? You're description above sounds
> exactly the use case pin_user_pages() was designed for because it marks
> the page as being writen to by DMA, makes sure it's not in a movable
> zone, etc.
>=20

The biggest obstacle with the application workflow is that the memory
allocation is mostly kernel-driven. The kernel module may want to tell DMA
about the hugepages before the userspace application maps it into its addre=
ss
space, so the kernel module does not have the starting user address at hand=
.
I believe one kernel-side workaround would be to vm_mmap(),
pin_user_pages(FOLL_LONGTERM) and possibly vm_munmap() shortly after if we =
do
not want to keep them mapped in the originating application. This would hav=
e a
side effect, but the pinning would stay in place until the kernel module un=
pins
the pages with unpin_user_page().

The pin_user_pages*() operating on behalf of the userspace application made=
 me
think that the pinning was not designed to outlive the application, but per=
haps
that is what FOLL_LONGTERM for in comparison with FOLL_PIN?

> >> How migrate_pages() works
> >> ...
> >> Steps:
> >> ...
> >> 4. All the page table references to the page are converted to migratio=
n
> >>    entries. This decreases the mapcount of a page. If the resulting ma=
pcount
> >>    is not zero then we do not migrate the page.
> >
> > Does find_get_page() achieve that condition or does the outlined workfl=
ow
> > still requires pin_user_pages*() for safe DMA?
>=20
> Yes. The extra page reference will prevent the migration regardless of
> mapcount being zero or not. See folio_expected_refs() for how the extra
> reference is detected.
>=20

Thank you for pointing out folio_expected_refs(). I see that as soon as the
reference counter exceeds the number returned by folio_expected_refs(), the
page becomes pinned, but it reduces the mobility for the pages coming from
ZONE_MOVABLE making pin_user_pages*() preferable.

Thanks,
Ivan
