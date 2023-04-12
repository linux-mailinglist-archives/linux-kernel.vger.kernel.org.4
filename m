Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA86DF4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDLMNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLMNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:13:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFFA30C8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQh68MQGAIBBMLxLArZ/MYGyR/7jV2ahWklfU8buF7fdbiDmxCc+2bVubskbnBFOJK7GXd7QP7nwv+01FZe8aaCALcvQgPK66Up/FS/cA1SHj55S8gkYH3s0RPvucN5r/cJs/iqiDpUq3YTiK/x//X7OVTGhx7/eEiUo5GEKPEZrT2C7kFzvmym16na7xkg7LYhwcpb+bC/SWIgS1WGSk1UkKoBUNpgUiobWhywNdtkKOa54sww9cacNTXVCz0g7LgsdexVkS9j1REz84LxTmjQxjeaim+GWiYY6Og4u6aZvvFHnnWKPWSmjxqbFX8E6e0pBe1yP0KxO3KarRRk9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzoBGlPyz/0C5YDqIrsoGmTxY3u6xzR1KsHab1lvDnQ=;
 b=a9qTgYhMImnmNmLdB1uXt9AIthzsSbGRUFySzxiKe6vWZkfHlmuOFJl0tpDEm+VIBFPnuZ7K6px/BvISJudYN90Ljc3kemhJpq5zz7dP6xtcHDU6X2BDKamjlOEXbYdzPrkAMTsKnJ5rJAk62CvsWkWTobaZ1W+FdFkkhhSnNwNDj5PEcxR2jwxSiIHAkvhYvUNrqYyp1PRnMnp0lzVJBF4eoFLGfVgMAbqTin797IbY893DO6IUNMMp5+bmJkW/gxPgSsllNDsXPonJ42on9mClKlmdeBn+Egu/7n4bfYq8XaFVPgw8ZpCEO/GjTEMcBU+WQ1Bl/v57fVwba2WSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzoBGlPyz/0C5YDqIrsoGmTxY3u6xzR1KsHab1lvDnQ=;
 b=dd31rVThoj1FBohtSSdhX/x3LARm/zbFJQwmBfOHV4ClNzq3dtN1ckrF0+UfCdXAw0WSS3i3i4tGEgnq3f6vUhHDFdywW1oFYpKYFMKfxRFum/x2RJcZbPhzraIZsj8swCcR6jatJi+oo5SwF6GsehLkeFBCyA1OdUltWGhoBp4=
Received: from PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 12:13:38 +0000
Received: from PH0PR12MB5606.namprd12.prod.outlook.com
 ([fe80::2aa9:44d8:ff48:164a]) by PH0PR12MB5606.namprd12.prod.outlook.com
 ([fe80::2aa9:44d8:ff48:164a%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 12:13:38 +0000
From:   "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>
To:     Jan Kara <jack@suse.cz>
CC:     Alistair Popple <apopple@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: find_get_page() VS pin_user_pages()
Thread-Topic: find_get_page() VS pin_user_pages()
Thread-Index: AdlsqyEC2Ib370amRP6esQRt2dSqSwAI4d6AABNzQCAAA7uWgAACkwJA
Date:   Wed, 12 Apr 2023 12:13:38 +0000
Message-ID: <PH0PR12MB56068CA4549ED998188D0623F09B9@PH0PR12MB5606.namprd12.prod.outlook.com>
References: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
 <87mt3ehti4.fsf@nvidia.com>
 <MW5PR12MB55984F39C8CECADDFE7548F2F09B9@MW5PR12MB5598.namprd12.prod.outlook.com>
 <20230412104151.hkl5navnaoc7l7ob@quack3>
In-Reply-To: <20230412104151.hkl5navnaoc7l7ob@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5606:EE_|MN2PR12MB4221:EE_
x-ms-office365-filtering-correlation-id: abeb72f1-6708-438a-e2e4-08db3b4f58d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWV+gixsKpjCSNJ4H/llWfYnPKpgnflVcasq653XLewj3BTLqW0VIma0G4mZD/Y/rZLFezR6NixZ14trfUKnYLuKn23XAM7+V+4v8HcmT1p+oP0Y0mHg7ocn+vKbzkmhPCXUdgIb1igtJpLIpx8crszkpbPRGX0TC9/DTJt6aW/KqmZOaBwISZi2UWahZeis907BadcgvZGq7Gd6hpRgrEN3qGk9w+pbur9PEQGMSeZM4SBtLaz/1m9w0iQL32pU4CBhewF5fSKNdhw12MOfOc9g+ysb/y3RBiG9I52TOkw2ccbHNO8ij/oAKZh/FHd3k5owtG44dZe0qgkCe5WPyAVREMfiWluQz2u5z9w1MojyMnQgTTuzKZdWR8xAvPZaHtz5TCYLn1ccImyXEr2OKpvgNh+3sMe+9UeIFKhzCpr3B88s46bNzJgk7ae+2I5Oo3PGvJoybSx8JgDgC8w7N3DIaWe+nLcc59+rrMbLyNcQcFhF19C94Q6unlt5+HkNKkfJh5XwGcu9XyFn+CEHNiCP63MCbiaNDXIePGIMpOJ15AVW9b/ztLNvmc6NcCdGLCeYlNOEzah6z7Zf7CBkz56G68yvY30y29jhVNup4RXPjM9fcbmoiODAP8UhCogM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(122000001)(83380400001)(41300700001)(5660300002)(2906002)(52536014)(38070700005)(38100700002)(8676002)(8936002)(186003)(9686003)(6506007)(26005)(66899021)(66556008)(4326008)(64756008)(6916009)(71200400001)(7696005)(66446008)(66476007)(54906003)(66946007)(86362001)(76116006)(55016003)(316002)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?swzfvSn2WzVyPGcSazLjlzBCCBK1aMD4OgmP0iUiSEH2O5WeDskSbcNdap1v?=
 =?us-ascii?Q?8kz6hVJRx1g7Ftp8nQBPHmawIOEW7iwcMPutPwhsTCUFqKfi3KlGQv2+TxO9?=
 =?us-ascii?Q?z8ykuHFm4D+sTj2yf7r5i4x9ih69lj+QReHLQTwqxhfP7Ga/BP9asHHteiXa?=
 =?us-ascii?Q?JFod5MAtsJrSeSlrHL1/mOew3nwykucWldfxd2G2KoocB4+OnIe1tFw0y0pN?=
 =?us-ascii?Q?oE/xKQLf3A+hwmaoSM+n9saSCwOGzwuQGcSX9kyTK82EPIfTmwo36CONjTrZ?=
 =?us-ascii?Q?NAjGucF3JXZdUx4eIj3HxtD8Hxi8//ZTPdU+ec2Lu4nY243mFT01qv/e/5CD?=
 =?us-ascii?Q?skw1QDeofNX3E3HLspESikmDvFVaB2pjYYPBBwQ+VR9o3AtQs+U5j4HcUWzg?=
 =?us-ascii?Q?P6SpdyFWj4dVH2QGmJN7MZjB/UJMmOEPQtpb06DBokU6RoliIfYCrNVFpSOD?=
 =?us-ascii?Q?vLAnd8tRsh5yR/5SW3YuyU6lvBsbzpk1/RKp6638rXaC+RXe63gNG5i9drjD?=
 =?us-ascii?Q?IB6oaf/rREIoaS6ZhLINnRiwem/IA+i5EmHoZFo53O0edf4K7ckAGNuZnWFd?=
 =?us-ascii?Q?z3jKkKsj0AMGvfXVtEIpFulJHa8RGrdBbhojUotgF4hbsoOlsXzP4bB11A6o?=
 =?us-ascii?Q?pDZsxHJ1z7sESKSyDMNtMnC4epNMnfbVMhQMPJUjUkxivgckzA2SCV/ez0ZI?=
 =?us-ascii?Q?CwS/QMqrS3nbeOovB56hBOwOVSYPw4026P2mjEvoRdSAsexOcJLXuqG5eSwd?=
 =?us-ascii?Q?9ShPZCCIGPzGUFzXMR6ObZqMAT5QCyDHS60g76Sy11xDGz062NRhm8mwYDT5?=
 =?us-ascii?Q?t97XCqQUWBOWvlnkVpX2IHJX0mXfwdsTpPrbMdoPR4FBTDGu9rJR5rPuStUH?=
 =?us-ascii?Q?peFQi45a9QHlSs3z3uWH6J+BuR/xdLVG0SVzGzbUPuEnHSBl4eABjdnuR/Ci?=
 =?us-ascii?Q?P97ivDzi6YrF8Vd1YZ6f+k0S4L5nlePz7tNjMLr1WZMq+M0J1/MuL5BZwVzK?=
 =?us-ascii?Q?/5ZbzMkHUmrLhnDg94e72jn+PDTM6A8mGnoFrxMP6tHPiwPgmIc0jUkmde4/?=
 =?us-ascii?Q?jHovIpv/aRaLcHwEgxDcN7tQjUfRjML0aVGkT2JppKTJ90RQ5DE1KdBPKF7w?=
 =?us-ascii?Q?/i0l4ylJ7JoYxERW6nR0k+baYqaab2OeCFQjRTilUeWc7GDP84VX8VX4tlzI?=
 =?us-ascii?Q?hJA2J8ebRxR/s6gC7RyMNMwAUeN+Gk7SVPw3N022EXl9fYwGmnx6VEBWWYaQ?=
 =?us-ascii?Q?WR67JvcVYk/wRTA+BgYpWjEjkqz3Zpl1JhgllR27ltJrE62rvrBxfw9eUh5L?=
 =?us-ascii?Q?xz9GkzsY9CQsocnLIjYEw3clMyBL4otwdSgzGxTP+0mMaCiDZVZyTrbXv5M7?=
 =?us-ascii?Q?awXSiR2OKw8o17D+njCq4XtxoRCfGmYABQwrndvpZUbXLjzL/iZaH76zLHML?=
 =?us-ascii?Q?DLx3WB4V3h76Q0Lj55yFR3u9ihslNnVQeP4CrxGJ3nU9LYzU9Gxqao6H80OO?=
 =?us-ascii?Q?x7+SeIpPetQ//XPW9cKUJa0S2vCbw28UlnTTNK3lLN4naD3FHLBdcEH5p8UL?=
 =?us-ascii?Q?ovjlUj1CNq02MuzjOuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeb72f1-6708-438a-e2e4-08db3b4f58d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 12:13:38.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIWiz2BNJBxvAW+d5V+bEugHBdZ2Z2LomfCJsyN5yMLD3iXFXJjBPfBm7q6UTWX/f3vPqEVqMndW4eBeE04DWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>=20
> I'm a bit confused. Above you write that:
>=20
> "The memory allocation workflow begins in the userspace, which creates a =
new
> file backed by 2MiB hugepages with memfd_create(MFD_HUGETLB, MFD_HUGE_2MB=
)
> and fallocate(). Then the userspace makes an IOCTL to the kernel module
> with the file descriptor and size so that the kernel module can get the
> struct page with find_get_page()."
>=20
> So the memory allocation actually does happen from fallocate(2) as far as=
 I
> can tell. What guys are suggesting is that instead of passing the prepare=
d
> 'fd' to ioctl(2), your application should mmap the file and pass the
> address of the mmapped area. That's how things are usually done and it al=
so
> gives userspace more freedom over how it prepares buffers for DMA. Also t=
hen
> pin_user_pages() comes as a natural API to use in the driver.
>=20

I failed to explain that the kernel module might call vfs_fallocate() to
allocate hugepages, then find_get_page() and finally dma_map_single(), all
before the userspace maps it. Sorry for the confusion.

> Now I'm not sure whether changing the ioctl(2) is still an option for you=
.
> If not, then you have to resort to some kind of workaround as you
> mentioned. But still pin_user_pages(FOLL_LONGTERM) is definitely the API
> you should be using for telling the kernel you are going to DMA into thes=
e
> pages and want to hold onto them for a long time.
>=20

Changing the application workflow and then doing ioctl() with the address i=
s
what I ideally want with either find_get_page() alone or vm_mmap() with
pin_user_pages() as a workaround, and the latter is preferred.

Thanks,
Ivan
