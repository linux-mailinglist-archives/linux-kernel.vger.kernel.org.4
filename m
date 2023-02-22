Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1269ECC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjBVCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVCWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:22:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C806A48
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677032574; x=1708568574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IAfw1PLhGD+EW3mZL0j7h92FJkwz7I8Z0Uc7RUg3Glo=;
  b=TSdUVcgENuMn+Z9qLwMBhV3ddSgTusgTgk5f8zIfRlUl+jN2+OA7Nl7C
   6Rc5ogJlqsXpi2Qk/PAT8sm7h2bIIOzEPeIqcz8t/+Ut3rE3HxYQCh1jm
   k7NRKaY0EbZipRiA3vwsQwPN0t6uIp/a2WFD7BELUs3yg66Q8bUV9G5UL
   MJ0V/64C3MMQSerr2vjmjticcG1g9ZOqzh9UlePSyr/KK4TOETmyEsD84
   dQ4OEx75PlCwLF5dB7DmDn+J/vAe6PHcCnaYofXPPZ800c9UkJCbkNkIX
   KqVgp+JiSCokAf/9iS8eybwsYrkdLPOBL6Is5CqLP/4XXGqShyJhl/1Sm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="312439014"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="312439014"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 18:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="671903023"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="671903023"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2023 18:22:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 18:22:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 18:22:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 18:22:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 18:22:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUEKj9HxD5qA74NGFTzVYGPjD2gV26vywXMnORv3RA285TGqMyHgyqByRSBUrYrXWf8AFjlyNxGMt/u6WONPf0cibtdVsKkmlkRIr2/LSUZZGwdQhbGiBJt7Vdbrdf06tNFvuvRGZuPV1qz7f/bWOhZEH8x9SfieiST632bVCNNv9oo5Ey5Ay/z7/1lzIUxyaRsJcrVa62icR62ma0HI1UdqDBKhHm85RyisTgdl6eRXjvEKC1bqtjvi2XpefHVWtI/c3jByqZlhFnVFJ+5o+CsPthgxLainSELQYOV3eGZ6ROmAFA4JW+hNIVl7CiZLi11S0T4c/rP0jACI0zp97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXPc2i6PvCWty6/QiApeU2UE/HHsYBNhfGCCns1iBYI=;
 b=AT6Z6YigO7KD7u4fg1TvRAzmvrLM3abgeimgnADda+81k0Hc8hSwnv5XYSCioACg6wHA8pF/o/1wYeTMxIXNfklFRRRePEuptW82e/Fd2r+ZXXgejcdyAqenDzTbNYQUHHTqJC7pp2khspcNzgjB5DGAciP1ZY3bvRBDML3FapGPQ1yOqktvaOLxi9KwZkEQ1BEER8en6tGtK62HBFP7MKRoiM/45CkMSuxMGMUtcN8+OFQLB+3cqgx3k2NrvanY9ZAUh4Z14aq0cSR6LorQajc4M/3LoS0HJVP5f2qCXxnj8vMTDAkiIqUukD3+G71cSFo7SRua6qyiTdbFTJt2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5797.namprd11.prod.outlook.com (2603:10b6:303:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 02:22:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 02:22:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "X86 Kernel" <x86@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH v3 3/5] iommu/sva: Stop using ioasid_set for SVA
Thread-Topic: [PATCH v3 3/5] iommu/sva: Stop using ioasid_set for SVA
Thread-Index: AQHZQmJEeru+grKOY0SemYkaViFtG67aQ+hA
Date:   Wed, 22 Feb 2023 02:22:48 +0000
Message-ID: <BN9PR11MB5276EC1F0926256D0E8F05F58CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
 <20230216235951.3573059-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230216235951.3573059-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5797:EE_
x-ms-office365-filtering-correlation-id: 4904263a-1e75-4939-1885-08db147bb0fd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCeNkXFtGpMDaxXcU6kZQfsOvhUMgliW9q6szTXTCqtENuOvAblbZF7LAU5SF1Ig1vIIhTZng4skvroaU+zpTytodMKVu024qerwivfl6VGdrs7hjJ0uGYmyIYa0FbpaXA7azw2Pv6eHmR9Zz7XsllnzfQmmw+mlhLSXUJywYhfPgHmdgCY1z3v60DgxPDyKE+BTvQ7yIeihj4t2lzq1CwFH7VHROw3QwBbnHMkbmq3VWQ6pLcQk9HbrC9faRfPVURgLNLJtYfYJNFXh4J1a7TTCoDAQ4JQ6D7xGTnPlVv1WvVa6goIw1v7jvqDjj++yEmnCdzGh+ZjEj4olUWTWpr59JV4vasr4SY9kj9hjdN9gGN4QftwipeHJ5iZNBdPtxP2PV0veVnsfLm2E4G5b8pvQiXV2tQ9bFP4j8vZ1rzPNn0NKWM2TwxT4zjt83XDX4M0nVKylhGsWcxs0CMbzgtKNNxGUpHlleUKj24Whg1ARjfAhrrkAeZGEKAn1KDUtXfar6toTiYChIwiCi2v68XBNHd/vIAIXEyxiVJP44hWcLltJDkVkN+wVxc+QGRE2wh71gzUl7z+XhJdr5y2PVnSBxKLdmtA9GnmMSicEbKHbL03brmvSfYwEW2RtyrK7U604LEys6YT9cv5BLBP+NvOF/sfnmOPg2IknzwgoJAIDQqwXVU7I9caRF+JC71peQo+n8af/fpHVWmTZR1Z0gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199018)(110136005)(86362001)(71200400001)(54906003)(7696005)(316002)(9686003)(4326008)(55016003)(26005)(6506007)(186003)(38070700005)(7416002)(4744005)(41300700001)(38100700002)(64756008)(66556008)(8676002)(66946007)(66476007)(66446008)(5660300002)(33656002)(2906002)(76116006)(8936002)(52536014)(478600001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tCpuzGtIQJuykmCd3f0QYFybXuNAdLFK3XvD9L2pp73xUfx7+bhuXQvNk/7g?=
 =?us-ascii?Q?ZBUuR6pDuda0n64Q2JcdiJ0cI4pFsxF59r67n6z8x/bLG4rN7XlvP1Hfq5Wo?=
 =?us-ascii?Q?/2ooYUqqEW6nWRYN5vrBz0jHJtM1dlU4fp0It2GeWGkuAHZYGThX04m3s/sK?=
 =?us-ascii?Q?sHskIm1+lIw+IwLJ2oOYhESfvCpIWN6K2gV+y3EH+M/BgpGYLoteVVps9QbA?=
 =?us-ascii?Q?jrlJ+aNS2bf2h5cvSROyQK7OhzEbL5pVmzHp7NhpBMudzAaUCQqDfJtAmyTf?=
 =?us-ascii?Q?F1jl9E3rsFNCDEU1rMP6rutL7nxuhnPlwOKFA2Gd+oK8xWYQEdVwbPkgLYfj?=
 =?us-ascii?Q?lHrm3nHBD/XdyQlM45k5IaQ4zbNiHQv8/T89AQshgYWFI1BUJcaJHDpJr8+t?=
 =?us-ascii?Q?DiWpV36WbJWV1uQcwjPKggfw/tr5mHn/CWH3w4s5GGl0JBoAHL7rfckduC0P?=
 =?us-ascii?Q?CEdLNZBaeOQmM1h+0vRGiJRSyvY6+xrw/W4tqncTFV1Hak+wUla0YkTcD3ld?=
 =?us-ascii?Q?1N9QYy3KtiPOBDRTlLW6saXe98x3z0eAcBxqJ+pnDIws7/isx5FOX1l+Pd29?=
 =?us-ascii?Q?aypet/zna1BVbgYh5l96CYXonV3VrGACcqiJXYtzxgNqENRPXk+wF/oXp9We?=
 =?us-ascii?Q?8GGs07w2/dSQjUlJxV0dnRm+XVdbzVbLgLxkSJP2HUuse73rlBb6t/fDH3N/?=
 =?us-ascii?Q?UITI+P41cUANKcwElYtMwxUFpytcpAC6W7UZzHmqaaDn5XG9FAcklfCmjHj9?=
 =?us-ascii?Q?x6pDjx85VZwSGGBBTN6FISQ4SdpepqhLTigdLuAAJ6LNYzQouGiY6+iO04nU?=
 =?us-ascii?Q?o+0giPLrQv//lmezUyXcVC3GJGzomvLyIWY/+2fi5SzisrSi+dYsau9w+8S+?=
 =?us-ascii?Q?yrj7gdHf5MZyYFRy5UEQ2YGK/eX4mVPm6ozzteD7AHC/lC89vmwPoKtQ9AKS?=
 =?us-ascii?Q?ox+ZBl9YwQbaKSn+EiaSZ/jwupu7pDqgBPplIqoU5mzJ2O9AoyeFOOUbKKkJ?=
 =?us-ascii?Q?JwiDpFHoL8mybm+aIVhROUPkXSmODfAWdaEV6x2CG//1hVsRK8+SPlWFzwrF?=
 =?us-ascii?Q?/78R+EfaNIlfrIUXHcjv+S9kTxJZOXNJOJBxC2ANcN1JK8iF7zDmT0GHTNWq?=
 =?us-ascii?Q?WAyXuAGGTLqGCItQcALRF+0YWDKl/KpaQIfuYt8S5scL+kyVbdluwMqXKPaB?=
 =?us-ascii?Q?bDIgHLPiYtqDTcZdHaOhNXL2eYVYO0Zfso3GXukqzTn2aaTzE5Az37N7myHZ?=
 =?us-ascii?Q?3ZcZ5A4lQPf/C4mNPlEtL/f5UYGFi0v7PvP2LqPII/9TTAo3vUEsAacK1Hml?=
 =?us-ascii?Q?B9mBGrQLy/QRAFNECtpFKpX0elsTgfIUG6ENzxvxYiw75cxP4/IrXHxjkRU8?=
 =?us-ascii?Q?ttUTnLfC4dCtSZLUl2nftC5rsUKS3+3MNWm+BVRN79Kkfu13WbObEOdoA4D+?=
 =?us-ascii?Q?CzP/4rinLrvMzwB3s/KJmk0c+Z6MAJzUhJvx6kTn1kZSMJnxJ+nn/Qxyohkq?=
 =?us-ascii?Q?0wr072in+SNifQV6cJnUwHwx7lOOM36gYnoAn+0lBw/lY3RYfmhkQNIHaUu2?=
 =?us-ascii?Q?vPgyqEjD3/r8SuzElcbEC6HuFbsABfg5cRaIiv98?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4904263a-1e75-4939-1885-08db147bb0fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 02:22:48.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gv1qA3x1dYC3wRk3naiXnUtRjz5RIRBLRQnak0MMk7faVQyP5uX/SmyObrI3mG5Eb77/qEQ8BI1E4Zw5r4CVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, February 17, 2023 8:00 AM
>
> +	ret =3D ida_alloc_range(&iommu_global_pasid_ida, min, max,
> GFP_KERNEL);
> +	if (ret < min)
> +		goto out;

ioasid_alloc() currently uses GFP_ATOMIC.

since this is kind of a replacement w/o functional impact, it'd be cleaner
from bisect p.o.v. to have a separate patch changing GFP_ATOMIC
to GFP_KERNEL in ioasid_alloc() and then this patch.
