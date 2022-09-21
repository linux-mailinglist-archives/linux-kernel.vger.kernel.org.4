Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D85BF86E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiIUH7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIUH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:59:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62DA832C5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663747152; x=1695283152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7X3Gr6RbCiJntsYcZZMYRqGnouvNT7lnPt/HPiW3BTg=;
  b=Q3XWlrj+XVOq4ZyKLcAljXaG2lXZQ/XwfR0vZCvEQGJhGjkmwjsEEwY+
   AuiRMgOLOtopb0AIpcmNWXe/7OhNxP7gkOUUBRHe4TggAIIbHyZHnLqOr
   N7spXs1MgpG+aVwsI7GfEg77drk3CEvWTz9PLIeAfwS13K2T1qZaiXVF2
   S8bBPhtmKp9WeBHuHeBy7vQ0rmwuSpoof7Q66qTvBcsOx/jdPlR+PJX6Z
   zcN+Ar3xxtCNR9rpG4nALIH8omN1LSBGFHnN/Mys1R/DQ1jNNqo6pUbvI
   BZ3+aHegIH+4Wq4V7+iiwF9RR/0ypH+IuDGW7vl0MelGVpz2Kxya3T1/b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="326245123"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="326245123"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 00:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="794580729"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2022 00:59:12 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 00:59:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 00:59:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 00:59:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 00:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4hy/UE815xdK948UMx8YpWhvcqdkUzpczHQP9V8XBusu0SPNAGAQATC5j6R2/8esVXHGA8AO0DK/5zHH94iAtAS0K76/K4+TuiPTwUK9gRP1yAin71ZIhoqwN5ojxw+L3utUVand4MYvfquBcwsCKi2oNQb/U4Z9QzwXj345CFkrtXt94IzMcah8azir7Jffa3hq0gkHMDn21pYyKFFp72OXB4r1WazsonO+5qfwtmGy0nreS+vJ0OEsvKYy+ZIB8ntWpae9B+x2CvnbPBRfAD5mR1dIP0oYsekQ9ARyeVRdtl5uKlVEh//hrRvOX4Lk86C/TbLEFXbk0i9flhgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X3Gr6RbCiJntsYcZZMYRqGnouvNT7lnPt/HPiW3BTg=;
 b=HQKAyl4hW6NK7G8V0X2zSG8t+pzb1YAY9j/gOV2jTUHSm5D0tAWCyS2kZZr27ZCPSZ7vqzrSaat/nCVclo6O6AQs+qLOqA0M8o/Tg/rysWmR0xmEQ0A3u4QDWY72B11YbuZ0Vc+JE1dY9dx0cArLP8+dTN/0dwXOk2OU4d1s7FUe7T56BjCdmjgzpicXNdIOZuI8MQrUkNTwNM0/02j7EFiTYAsAw4IxaSYisUcSj2WC3waYy/crfVjRFBrO7ZTcTjZX+DL1FtvXA+g7bTiCAs1LpJPLDvHAUp8Xzk6YVLlc4PhC2TJKhyQKQ8/OjBNJjI73w4e8/KjNe0WkfA7VOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 07:59:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 07:59:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Thread-Index: AQHYzYhPY5V8ScHrbUyr9KsFPziy+63phNtA
Date:   Wed, 21 Sep 2022 07:59:04 +0000
Message-ID: <BN9PR11MB5276117899AB724A2F034ACE8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220921065741.3572495-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220921065741.3572495-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6760:EE_
x-ms-office365-filtering-correlation-id: ec46a1cd-30c2-4dcc-4be5-08da9ba72730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISgc5zvdaeLEpQ9BXqkU7YVaaK9HlIZwNS8hirLcBCaa9ZwSP7TP4JBYrvXYdgTbNrtSNJdhJI8WY5yKwtyhkdjjSXMFf5c259omQh8+Tm8i/uyWEXLe1MfEBwrI6wds6bWZ0/7K1ekCka2lmyO85FY0Njf+6CA23WVtKWuUt9Tn/t0pQ3FVG/uqQ+hzI+iut0VNpX5hraa+FB8hDOtdE5jkKpZ3Zc+C2Td/gz+RSxERkOPzkKSPU/5m4kKDMWPUuMch1A4UrdefoBd7Z6SC1ExH/0JYTMcu2GujVkL4MV5JMmRhm2Jqii+oGzRwXXyNQFUdnvzLEutxPiOrmy69LxwhDKaQyjYJDwbBzgA+WvC5Fhqp6wNLmtydJuqlaYRmHKh1GZHTcmJRU154Tkiuhu2enGgcq4EFKJpOjXYrmrUwM0urmp6gQqvLNPGgesvFGq1muuEhUAU4Ugtd644OVbXWtduxysVh/DCFnEh26faDkocla+ewthA/ehZofW2xiO/7fBypz0vryyp5zcF+nadWy5RI6v7pPOZjrfIYVuAtIY/Y/yOHHiuY6kS3L1cwooYuL54HC3a4RmM4HDKMAN/lbaPp+eJzv+gSsNEo5iU21SCA3Co3Wb+8fYoUsEPxxZL9sxNn1ax1hE9kRjButkH78PntJDkMoQM2/VWXaE0bEW91/FbrT5tQ09S27NJFXmwqIkcTlaLsIfWfTj/IpRbkMU4n8LlmUWW901abl5pJJ8sThdc3oGAyMWsns4vFKs+s9LYZA2PKEYrlaPureA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(4744005)(8676002)(478600001)(186003)(66556008)(66946007)(71200400001)(54906003)(33656002)(76116006)(6506007)(64756008)(86362001)(7696005)(41300700001)(8936002)(26005)(66476007)(4326008)(52536014)(38070700005)(66446008)(122000001)(83380400001)(38100700002)(110136005)(9686003)(5660300002)(82960400001)(55016003)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Ey1GIYw7lE04erlqAXvkvi2wsN9cx4QSgqE/YSbx0+kJDAT5dfKAvU4SBj3?=
 =?us-ascii?Q?uLZRzEbLGDFSw6oULrjSDMUlas1BaEZg3jKivopOi9uA1WG148ipDWy4l4qX?=
 =?us-ascii?Q?q5anpywFCfO7GqgA4FXVHvtWvPn2AOjGxYJRObXBmO0Ky9RrBWlq2GVPua5F?=
 =?us-ascii?Q?YhbV3a+IkOpYRRcawUbNSgMMbqEqsWWUyJHa7QKuxdp+cjXiMtPbciN+V6la?=
 =?us-ascii?Q?XK8l/0mw7pzhKkgqFeBsybRxAtWKY/se2ZYrl44IkAFQMxYQTAwNAYDDPFgM?=
 =?us-ascii?Q?Chh7jnd3fvwE6+LkDIn4IQA8rVov0xiyvw5Hl/SxuB3kG7DoG3VWpIamiHu0?=
 =?us-ascii?Q?pLD0OE5PNwHBvmCrs/CyxE4dyepHD9k0pckYtuVgogSJyqzXp5nsjScnLX1O?=
 =?us-ascii?Q?1MPjYwC3J4di3ZocZcFlhHmYMz7ezVP8PFim2LZhXy4kLQ6/ZCWIFByS44uk?=
 =?us-ascii?Q?8Xg/AdPx/DMWkm5gsWYwseYZWiyZi2GXFcr5PhpYx6VE5c0eDM8G3jskgONP?=
 =?us-ascii?Q?qDgt6liOL+ak86EPqlBdG4AJr7DanPvGv1OYO7lHQit8Rb+ZscnQaeolGFCF?=
 =?us-ascii?Q?xOwvj0d6tiJ5E0RYkxTj1lo8iaZvz0ro7B+N5DS3M4DtwXVFg1tgkxdiGLJd?=
 =?us-ascii?Q?7WOtAs+eUOMCol/5DpEMQn9d52zkaN8N4zJ6OOS5EVCj5md7oIvZ8WgLzkXt?=
 =?us-ascii?Q?3n2N9gJGtU7hBi4hiRJfs4zsWy5hk7o01H9ashNF18QOfUZDC9VtDwqf1/u9?=
 =?us-ascii?Q?CZOYIRDgOPbn4UdwU6RxoBZMjey0tcVNdcgeXjC0oA45jvLP9iaiFbIZi7py?=
 =?us-ascii?Q?XC4ZGX371vRwW2yOiGLQ8yldGuVKlzaqD8PxGCbwToFRsCILq71l3BbSqbf0?=
 =?us-ascii?Q?cC2OusKwngXf33ubKYsoO2F8Oh0g5+WadWmv0aviz5gqCMSGE3ArN3XcgW1d?=
 =?us-ascii?Q?zJ8hqSHk5Ioo2fI5g8/Zh60+Hpv/ZkGvY9BxjRbwJ/paj9HumtL1rUWOxsv9?=
 =?us-ascii?Q?puKJxQaVb4IaIsVBgoOMpmTOq+mU1ZGdMo6prnxRJ7UXcrAz52elCst4GdTW?=
 =?us-ascii?Q?ERdrOURpEe8pRxYvJXv3e31tBbU85EMa0+fc9bDe/68uLYcp4M2myxr2Uoyt?=
 =?us-ascii?Q?rPx6kOR1rJBmTgPkfsrCSgu58P/bpbOfmEdl1msPN+ynbRSga15yTaizFmcw?=
 =?us-ascii?Q?H7Lg6H6V39iEmmaiGV3/2DU5JJXED/qKG4cugPfloxBm189QqdGoBTT5O+El?=
 =?us-ascii?Q?pts+AinKff9+iXrzgtrD6L16widi8Aw3eaByj2v3WbR8AgFrlaoDvW52DcuF?=
 =?us-ascii?Q?GmDcwsZDvmA0oyQaPmPuBvxZ309+6tUgn8fnrwtHRsMnOFQTTor4Dmj7dSYH?=
 =?us-ascii?Q?OIWIDrWJ0xR416rXUr8k3q3IgAovoUW5aKBnEZhUiiIak3J681ZaraRGkuCl?=
 =?us-ascii?Q?EXTmG9BzErmAouhyJdXgnqZ/1ynJnbQb8CeLM+PcAMDSrn5eIuGdkk0hjygP?=
 =?us-ascii?Q?jjK63aP1/iZOzeOylZOg92qVHJBfKX1DZ+hddmsIiPYIg2Dlv34OfVLkkThz?=
 =?us-ascii?Q?b3UPTAysAbW5EkWENFWoXr1q0snwPl6kd+hq13mL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46a1cd-30c2-4dcc-4be5-08da9ba72730
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 07:59:04.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOvCC/KM7XJoZtr0LPP5onWo4PexytmBOm4+Q1iY/DPLCp8vc00Lrz4pTYwC6rD5Fa42NXse+Z2XGIiPpFfOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, September 21, 2022 2:58 PM
>=20
> Some VT-d hardware implementations invalidate all interrupt remapping
> hardware translation caches as part of SIRTP flow. The VT-d spec adds
> a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
> 11.4.2 in VT-d spec) capability bit to indicate this.
>=20
> The spec also states in 11.4.4 that hardware also performs global
> invalidation on all interrupt remapping caches as part of Interrupt
> Remapping Disable operation if ESIRTPS capability bit is set.
>=20
> This checks the ESIRTPS capability bit and skip software global cache
> invalidation if it's set.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
