Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5E693CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBMC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjBMC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:56:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A410431
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 18:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676256961; x=1707792961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hCThvEYc5lLKtKjISX1LTLgy4WE8z0KDQJ0AfOjv1xo=;
  b=aoVPoDvojUgB4f1PG4JfHUiumq0TaIOQXT5an2Q0+ijvhdQcWBYclq2j
   t+f0QVaV1T5aipgVVqcNW/ti3FcN6eF51JliDCb4jZ8JoR9xjKr3DvgSN
   9SE4ZsnsjtwCoVg+h2XZkOzg3JEmd6YYvbd5zXGHPPKJg0vD62P/TSZwu
   Z4iz2Bd6vwGRRkRzSOGA0u0AeRB0sGEDC3OqIdfW2tVFatNZ9JlpXCV94
   mMkVNBrFeOeGueuOu08UGHaEZ3Oij0ykdbvEIgbSnBnbSalGj/Xmb16GD
   mPYBBrl0vfBDJPvEerK4ni280DzFC+3JoENMvl00BesfFo+IW44MdR/f8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="395404846"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="395404846"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="997538418"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="997538418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Feb 2023 18:54:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:54:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:54:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 18:54:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 18:54:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iexi2FhX33cVHRblDzWac9Iom1XjkSHDol5cCxngsvpb9aKi3+ruoZmiSrHbI4E7nhNcB91Bni9tUzHIfFY5TzzgPnLhEzjdzEchGOBLZfvIaY1w0fXD+zvxA8u+rMTkGYkI2L2rkNMqZiKT+FF5iFYqztcf7f6L8zCoxr6ap+4PE8Q10gYwL4o4unOtTPoWPsH/Xg53X3vpRwLgzomP7UBpK7YHcalfrQmv2nFgXWTw5kYdwPjFDNxzjc08pyNQHGAZx7iQouqH7oYdtoj/6S6+p+ucshUY8UGj0pUDlZNwX+Sgj4TvYBSYEhOnivaBrhpsEwVn0QCp6BWETnE51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCThvEYc5lLKtKjISX1LTLgy4WE8z0KDQJ0AfOjv1xo=;
 b=TNQpHqeBzgOkmxwibyUocdb1we1bsJ1khwJ+ZW9p0vVdyCRo1TyuFD+VGkvcRL1AQTELd/elYNTS2klt49pbZAuw3SalL/7ixohChh1U67TC4ws7+/lAKpsQIgSnTHuobTtben6LWZd9Uje7lbWrWWtSCt2L8lA7Q6DWXMpD2uYmKyFvUhCoe5CvaQgzMVXqmVn1XrLxRniVBb0+xxBo8c4nM3YZWanivWGY9ZKb59tvM2CgCVSh7sg5Ya9/TiOQlNz2hxUjqNSsVeFfceQklljA0keHb/FMKSgDITYMjnOaMWqSu9u+vugE2k+TCVmAXElDgpOliFXdCr3VnuqgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 02:54:01 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f%8]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:54:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 1/2] iommu/vt-d: Remove virtual command interface
Thread-Topic: [PATCH 1/2] iommu/vt-d: Remove virtual command interface
Thread-Index: AQHZPaM3Vcrh8SEZ5U2vV5OMc6whuq7MMXaA
Date:   Mon, 13 Feb 2023 02:54:01 +0000
Message-ID: <BL1PR11MB5271A71D6AA85028D2C3778C8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-2-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230210230206.3160144-2-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: 40c30703-8bc6-4869-d0ea-08db0d6d8f9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EPwnXnbJz3pUYYa8uUczWujxRYreGlB/YjsdL5xlmnGUarCg3DF9aeNFtzoUeM2n3BIZPDg2vYCs1ZjTk6PKA3FvdCF7WvwbEs7EsERQlCwiXuuOocDVJ1bc7KQAVr3ilVo/+P+0UAK8vkKP/Nop2az0HFFS3VV4iXlPlIVKYgfi4Dww8yn6qKRFxTzdjnjuU+z3u+k5UYSmE8znNob5Clw0sX56CTgnhKPfkrpQha10yjLynuLZIFZcSNxDq1KOX7CDcnqnut/iufUD5ylSXLvmQieD206YVrlaqZW5DkISEQLGEUkd/vUMU0+n0XZ3gdNOMtoOcIzwWHS06UaFxIe5//AENnaeiiJGVNeMnn2UTVbjF6UKL/pIdcjohGQfAfeFotvw3ediAgMEBqCrvvCnflaPJ1eg6mHMFkLJCqGT6W6BG6k1Q0t7aqrlVNbqQUStLbvh+OsFPdwJMiCDjw579Q2Fo4TUcRSmVjUEGuYfRnlkHVTEhZLTzQN1Uj15UH74pKgmnaipkAM5N9NyOCJAFuT4XNpa/omEOtdoDZtavYljsSBn3wMpaJX/KNGi00Rmo7lSK5EyA7SejscxfAqJ8u75NsrtTUW6NPzPQYxYmfpFKrZH94g80mGNv4bXGHu/zjgzNKsMtfEunmERLDI+V1tdgSNAF7LO84jgmY4uFgf3pK8gbZxOFO/ehvaYxVvjp2TfgYeawKvK7uDHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(5660300002)(8936002)(4744005)(52536014)(41300700001)(71200400001)(26005)(186003)(9686003)(6506007)(2906002)(38100700002)(38070700005)(478600001)(110136005)(7696005)(316002)(54906003)(8676002)(4326008)(76116006)(86362001)(66556008)(66446008)(66946007)(66476007)(64756008)(55016003)(33656002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T4bdIeTmV9m/8jXijbQMukuyNJo+DPYSvvdwAmWLdqBjY+pzPL7LvQ0yvp9Y?=
 =?us-ascii?Q?pCiRYNMgsvptUEIDE+9P+ligzwz+XLglPM3+BSynLuJy1XMhs2T+0irVs5hP?=
 =?us-ascii?Q?AMO6WDIbD2nHNa9/HJW6k8wO8X6c3Hqr4yrQU7zWq9nvJZVtzsPz2k1tXSpc?=
 =?us-ascii?Q?RJcr2QbUmXpY57csvPxSstwk0wSJydtsDXifWuVB34oXtUUkvgkxazb58T0T?=
 =?us-ascii?Q?S7JhtsxW1W3Vpdztl47oJo/C7TGNvba4Nm/BEyrEzrFpvFWrxudjRWUroV7B?=
 =?us-ascii?Q?5yeZ1nOql+HbEP9Fjg+D79N0Ph8XwvJlugi1i3o57IqJKvSr90sne+mayJb/?=
 =?us-ascii?Q?wfagLm2K1IUDQQ0AVPRGTKPnIiaT380UflJmdQ6Ae87KdlWRm3kyLNoCkWkG?=
 =?us-ascii?Q?68Pgs+xLbVjc/dp2/eDaEVkT4xIDlhtKTwP93BLwjVJXno0GtfvGeMCB2vMH?=
 =?us-ascii?Q?li3cCn+tvz7pKvJRtusWUARDx1IWa7u+9K36i+SwMUDf57KOjosjenS6RURc?=
 =?us-ascii?Q?G81y1EWBpzJSkl4S2ARPsu8gqD08LV8CFqvkv0RvKhvmWx+UQrZNDwIcPanH?=
 =?us-ascii?Q?6ntByzh+uW5qoV3KV7ed3Gl0uwBXLdok4q1ENwM0zDciZtF/gWqtgE1V7Jh+?=
 =?us-ascii?Q?InuUSh4ueQa5utP5uNeBy57+HQOvOrzRAYz5NuQMCf4FEugL1a3xYn4RhCOJ?=
 =?us-ascii?Q?p9V2/Q2py4k/PZGTl8Vkxi+awnnWOWE8HDAer1hzKJRMKIJbOindTYheYeZz?=
 =?us-ascii?Q?n3LlW/AuwOYTsRhtF7Cn3Bz860IB1KcKawaoq9SQPwvAcUwCyCnB5B9F+NLx?=
 =?us-ascii?Q?ABT630wdELWF25gBxzOHDTWmCAjQmg4WRsJUy0VpzTrAXh+h9K54Mu+3lKEV?=
 =?us-ascii?Q?xtfkY5V/hJ31yNgLxwjU7xsghOQ6avA60AMp17YN4omysYmuvsc6iR3gpVfn?=
 =?us-ascii?Q?XzTt+ZhfJG5Rp/At1ggi/IpnumKeTU7Sh+fsBVDi9+sFAgwNPrQ1Pc/ywCL/?=
 =?us-ascii?Q?24nM2Exy6LcSGvlhdjV/DnUQ1ELHekzEiCijVwdVNnplVh86LhF1fGQUKNdx?=
 =?us-ascii?Q?UPW7NQ5bafNVNIYXvv34aVOa7pP6qBkmgrxeKXjmbs4SvAhoHJTiifM8phbh?=
 =?us-ascii?Q?ejzCJed9QBPbM0Ye7+GOelIJgtNXGsMHt83dJS2Uk8gO4uwXqBpE4PaaOZ5J?=
 =?us-ascii?Q?IGv9IDOJBEVJQGjuLDoR9w+DBopE01AdjsMgt0poZPLN5spTxubJOniEvGBy?=
 =?us-ascii?Q?AjY9fljYAhJd1aYoVjF7R/4sGqF0EvgGcW/00cSBJ5RpZWlsXpGGpGCtNdKU?=
 =?us-ascii?Q?prPIGfK3jsfKsu4znZG0Hp6XXbJdNnv6a5EMpnigscPszyHQ24qO/0q5EpFi?=
 =?us-ascii?Q?8ufnP+RTVXG2L6lY7XcIpbQtqmRod/ed9zxeOC4bhuAEoUdauV2V3rVaU6CV?=
 =?us-ascii?Q?uBt6T1UPANB+NWObWO6yI6xybBuzinaFUZzREL3pC6/x8ZmS4PoOlxYZQ7S1?=
 =?us-ascii?Q?wySocYiGCJE29thVEkiQF0A5QI8DOE+S6ViN8zKjfYj/Fw/r9PB7GtdUeGJ6?=
 =?us-ascii?Q?EwQPUcwThCTvxo9f8rDYBnb5fUDKQzAV9s3NDcZD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c30703-8bc6-4869-d0ea-08db0d6d8f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:54:01.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzusACY2r350Q53qE3Fvaxm2fXIgyQ3T6QUbzkw7qNLiGh4csU3o3EAxAwiOCkSpCg7tv/2j5xGtqSRHXCwA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, February 11, 2023 7:02 AM
>=20
> Virtual command interface was introduced to allow using host PASIDs
> inside VMs. It is unused and abandoned due to architectural change.
>=20
> With this patch, we can safely remove this feature and the related helper=
s.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
