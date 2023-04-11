Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227F6DE512
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDKTnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:43:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C611BCE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdFopS78qykQt7R4EhZhzAog446JNRVe00aTRV2I/YZsteM39E7pk4unktwQXVoM054G+F3MUK/KnA74JS/V90FuHVIx7F45gSuCHwYBLOz+6NFQP1zV9jVr3tgrRV1w+YmOW7SpnYJITAEeRR7woEJ3qEkIaeykHUVaDN5h8COmR0frT2A3Sw6Esm8rr+G3sRxU5Ts90Q4j+P/P7GhhaSPrdvMPjS9nXsIsfFc+2Nsb7qFImDWlTZtsqKXolTAnDPxVFPs+SBRIwvxG0io5V1bg5BY7Zt2SmgVdQ2LwHrC+MsotQzCps2WQZ4jeoHAf5VXqaIJpibdL2zN+cCsrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehUYmwMvgF5PtnCzYBvN8IVuC7qMM1p/VQtrjbmYCgg=;
 b=YwHdFaA60kaUHdwJSwTAeTNXRUntJJWADmRlZjXGOHz0Bip4W0ZQlmQF4P3EvjZ1PNRLGZOeajsqBnfocoTIZIkw/0HrVYc2hWl/S8UpNY/cZjHQPn936XsuSJRTqoj1dU63M8MDOzXyk99LwUJ4MMD6o5Ui1woOIPN5P+YQ1fBoPBz+/uPXOhQil2NQHAlBow/CRXZwYOqTP2U2l+DJ019C7ARoLr6sDZ04SotUpCIibpR5K1dQY4iiAtLpP/3KDryu3g4wOt5aN6QCQo8yd9aARARvvGn5YhcSqtoZnPp3Hes9Zl0etdNLxBEEY4CBZNXPe9q1p4piPuZMiz92EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehUYmwMvgF5PtnCzYBvN8IVuC7qMM1p/VQtrjbmYCgg=;
 b=4gT/NJvmyt07mI56wf1InphyUT9Z1yjQImurxvOlhvCvJkH8OZ60+MlnGjFJLrQIH2AVyzHeOTT8kLJj64UqHroEz9wfY7obE+q9FnPn85mFlUSLNlBXczKTimL8W805f7DAfQ4h8kFOn4AEGh/nNJBDyLFpMWZznCaNZu3GPHQ=
Received: from PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 19:43:17 +0000
Received: from PH0PR12MB5606.namprd12.prod.outlook.com
 ([fe80::2aa9:44d8:ff48:164a]) by PH0PR12MB5606.namprd12.prod.outlook.com
 ([fe80::2aa9:44d8:ff48:164a%4]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 19:43:16 +0000
From:   "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: find_get_page() VS pin_user_pages()
Thread-Topic: find_get_page() VS pin_user_pages()
Thread-Index: AdlsqyEC2Ib370amRP6esQRt2dSqSw==
Date:   Tue, 11 Apr 2023 19:43:16 +0000
Message-ID: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5606:EE_|MW6PR12MB8664:EE_
x-ms-office365-filtering-correlation-id: fcfd9e41-946f-49cd-adb8-08db3ac4fefc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tT+92W31jHXD57BLUehzfktZLHDaY4oNVfqzyZdb44Z8eAi+EpkOOCR7z0zDwzBhHcDNNn5uFYg7T64AKNfL6JjswDdw554iyVJ01Kdfn2mkX1djk7eOyY6qq0H5T5QXZZc5a75u/UaJhkQ76yr6iXUr8oBkA51Y/2VXnPTwUpMNL4uK2YjwQ2xm5k8Z1we1/n1ROC6Vs/7TMUeIVVH04YsTs7hxd7Eu2eMngZaHPCEa1wvxI1yH1g4tVtrOT49+3xiZIBbaQsrcAuKhxkhsOMAJqZ/NGUHRqgz8x47YXEtCnTcSYGKCqO8afzNu1DxuJ7RnBAk7rbAw7bfkRl56aN/sFKKnIN1qxMY7Q39qArG4HYnfACnLCAcfuSWhOX9dEaFEIbX/9u+MVTMJrm9fC8D4gTFvZFdXQ7XgsjBOibQau5uZlnNI6iKdAJUVEHT1b6yU04bMWEYgodAVrXiw3LvBT8yBVJKj5Em6x5sQWksSA0+WS6Sqn8cOxhkw+Rc4TJjyH64I3rOeJzUWb1TmtskOQFfVKPPTd0qxCUFe3ULL8bn6jDWxtT0HyyDIdSn5GGLwCL0j4tCWh0jStyOQj1KKvi3RFarW+XMww1eXOjU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(478600001)(7696005)(71200400001)(6506007)(316002)(110136005)(26005)(9686003)(186003)(5660300002)(966005)(2906002)(66556008)(76116006)(66946007)(52536014)(64756008)(41300700001)(66446008)(8676002)(8936002)(66476007)(38100700002)(122000001)(55016003)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2i+Jkgzbq0ITEcE+XxFSzeUwcEFewJl4Ieh67ys6vwlqw1GQH0Ck0fmOikk?=
 =?us-ascii?Q?OYstwTheix7bgG5koMn2ss3MuP5bSL3YESQRO6Zh5eU3GVy3Hpop4/glwrvw?=
 =?us-ascii?Q?eOQ3J82Ii0eO7sPJLMKpnFRBWq+0rgbgP6WgJlsaZDKtUFLgs8rExi5Zzf5R?=
 =?us-ascii?Q?mxGwxl6Q1wR3Jn/Kd2nFMxBlaIM1SMBTeeoDLjQohnv0ssQmHwPmHf267eJG?=
 =?us-ascii?Q?1FMoa8etFtNnmobETDcSptjWrzrXgf7gx3HYSYlzNjYleRC5eJ979p55weWo?=
 =?us-ascii?Q?V4NsE+67ES+qLVEdGf5ITZQT/HrwVxDp7gVGVRx2oAQDB3AYvZMY7UcsYBSw?=
 =?us-ascii?Q?VeiVUtHDRoFoYR5hFKadSF7+vUN9zE2c6NSoQiYQ5EgH/tatTIAKJvgJodwv?=
 =?us-ascii?Q?/ZiN1FYHVzg8rUbDJrhlvbdX392dFzEMTGTdX81TtcY6nvSgfDyWTDR0RTZi?=
 =?us-ascii?Q?x2otKAMV800E/8/ItGNN6gTldZXCLMkz3cmeXYaekYxMGSAePT0f8GslK6Xc?=
 =?us-ascii?Q?QGeaw2j+j71oZHWwSccriWwl/r005577PKNjwqNvkdYqEPIPIXSILuAEDkfI?=
 =?us-ascii?Q?gMpD5aTQisU8WIUURH9QRl+gB0Hdy7y9prFB7eEhBFbPKlhOQAGWGFdCW6ef?=
 =?us-ascii?Q?WEHurPEo6Uaab43alN6yqjYzWEi5BAEurSu1QYqrMgrvvtYibnI4QTJvkLuy?=
 =?us-ascii?Q?LiqB6zDM0gawlj0i7raR2p3pMWkn2iv2kRN33jytAOx0WvXLaWKoilQfkpZC?=
 =?us-ascii?Q?zv+B3XqliSInyKankWVyHvDsoEutj3UE4WlogTKwVrzZCK9Hsj4KUkQXVR8X?=
 =?us-ascii?Q?EQZZ0Dh4zBKM+m85n0VgJxxp8cbBzYPnE10Sdg43cDnafdDrTjqkpmJys6ok?=
 =?us-ascii?Q?r4kZkdu2EHuuHXrPQdwrbuPj7ZAOQhmPEROoYhrGzhtgMMFag7gYf6MfYVmD?=
 =?us-ascii?Q?gvaKG7zlBBbERWm9ejmTi+kevNwAWpLz3CM91PF5uDwfCIzgFLnLsBCPdKD4?=
 =?us-ascii?Q?ZJ91gjawiWSlZY/dYaAxKdOUGtvQKeKSlFev+AAb2aDB5mZNPXbKh6tPfu8+?=
 =?us-ascii?Q?/z6tRoRzNKu8/uXTdKitin6DWoz/PmAGtbLHVwp2U10oXNLYcAQJ7E15imNN?=
 =?us-ascii?Q?/C/8drRXKQDPYLxuU2yYqjlmKG8LxP8TiJ5XAIf5Rx8ONjcB6fC3NRt2nj+O?=
 =?us-ascii?Q?KTOPGXpryBmygUOCbnWU0/Tq70frAfNDSq/uM8ZofkJ5WPLkaQqC9bYcKZOj?=
 =?us-ascii?Q?yjus6WUiSVTvIL3+YThJPcBE9k0hR046fdHzAbFRAxyN6ly/22ac2VYJNJUY?=
 =?us-ascii?Q?IDsg1W2rV7Sp5l82fJAL2am7E1y4KHa6Vm2Am3TR7XR15qzemrNsUTJSnWxk?=
 =?us-ascii?Q?Jn6pjjQMKDWNhUKY1jrh3uEqd+p/HxvTwgjL6pg0l+V3DyNZ2E73wq87imXg?=
 =?us-ascii?Q?tdf77Vw72BTapLbQpGcUCREPaItT0AePzpf/7iNvX7xwuu8cknYP+JwmaKZx?=
 =?us-ascii?Q?O59+bHcyi3tqTLwobhfRfvm0/H4nG4MsfSkZi1qpHVCNJjGT5zTebp9rpkaS?=
 =?us-ascii?Q?xvqMBBEiKIN/aYUFs7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfd9e41-946f-49cd-adb8-08db3ac4fefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 19:43:16.8807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kaWX3TK3QKBkKmBotMDHo679IsG6hg3sJ6/J6ebBqT2wkZwacJqoYaQhX4VwwGRk+Eyk2LhulUN7OYlBfeprw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I work with an application which aims to share memory in the userspace and
interact with the NIC DMA. The memory allocation workflow begins in the
userspace, which creates a new file backed by 2MiB hugepages with
memfd_create(MFD_HUGETLB, MFD_HUGE_2MB) and fallocate(). Then the userspace
makes an IOCTL to the kernel module with the file descriptor and size so th=
at
the kernel module can get the struct page with find_get_page(). Then the ke=
rnel
module calls dma_map_single(page_address(page)) for NIC, which concludes th=
e
datapath. The allocated memory may (significantly) outlive the originating
userspace application. The hugepages stay mapped with NIC, and the kernel
module wants to continue using them and map to other applications that come=
 and
go with vm_mmap().

I am studying the pin_user_pages*() family of functions, and I wonder if th=
e
outlined workflow requires it. The hugepages do not page out, but they can =
move
as they may be allocated with GFP_HIGHUSER_MOVABLE. However, find_get_page(=
)
must increment the page reference counter without mapping and prevent it fr=
om
moving. In particular, https://docs.kernel.org/mm/page_migration.html:

> How migrate_pages() works
> ...
> Steps:
> ...
> 4. All the page table references to the page are converted to migration
>    entries. This decreases the mapcount of a page. If the resulting mapco=
unt
>    is not zero then we do not migrate the page.

Does find_get_page() achieve that condition or does the outlined workflow
still requires pin_user_pages*() for safe DMA?

Thanks in advance,
Ivan
