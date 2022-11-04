Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA5618E04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKDCL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDCLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:11:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5CAB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667527884; x=1699063884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CRx/JTa41rgFZ0GG0/ygcrxWbcak7z1kGChzn5RQTZo=;
  b=mrGJD+48SeJB6Zo4tJ+ijD29s2j7amWNJAo115YuXttugNPVcOG7p0BZ
   HgHDmsNZbOSXfnnwcwJ2xjWLbkq1ehfqnqRlAGtYafB0Vhfaw4Tz6WxEQ
   XjdwSk/QV5XeISAlTrrYLLI1y0p5rpH7dNf/SLiNTQFBjxEQrF+VsJQXU
   OnA7PK+E42PKXSB1acpz1uG80eNFPB2MHFUXMA8C+jp9hZbCYFg0Vdhpi
   cT6CPxhDsux2qXOkA5niZy3Y5v3ejQtHAhQFUxyQOc+Cfk/ghClpcZBIX
   VVBuvLIPgayvqm7b+cWll2TzCtPVqO+zkLdqswWAsGeO2htsszONJYV2h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297320596"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="297320596"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964175159"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="964175159"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2022 19:11:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:11:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:11:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:11:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMUvbSycADDkxUjiCFYLaxU2WPxpfkxymXzYWmIFK5OEi0/FjGl0mJTf23IGroLFxKzzUI6+Q7qBTXitRNY/zw4IK0SZ2U7OCSdbhv/X1Z0AepOY/eRBIl2XXnAGKpkvtjbWvYqyoIQP2eJ1AV7hMGvL5FJNsBdOIJJ751IHVi4Bl4HIMmQOq4cpWSglznMRxzLr3S/h+OzjrRtOt6GkP5SyjWWi6PoVw8oPJhaROmuunvNsnJfEUIEbvIu1w9GfhxMvuVCbLm+AGizRygAOCvJ/xRbPchHf/ggUBKMc/jHVwwChKxndLqXFIONPJQyfGYsqoh7d+5Sf0lBu1A1gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56EtyS+BgsHjuRhzz0eLhxkpAlN3AgnBZt6Qe+mS1WM=;
 b=b8Br0cDUMlxyqyMjanLwjSjYRiwaXz6wG9aUBC9jdjhaUhUM87dPzpfySMlvIFkdvulHqZilBp5uLNp43A2txJRYe1fEphCXUj4y5gRkvOurgkwygLu8TbZTUCjx0/xoosSO7hN2PBTX7RalLDa+pbgp+zo0oNgYFPbiXq35DURwNaV6K4OL5R/rE6ylGNzAwsas+QcaDKWoAnzvH81NdwcgTP5y3hn/oGuraZXJ4tEFiGt3SvLnmmkmxh7DJE7Ys4C47HqyY5rebQku9im/BSSBa7ZCiR0+FsnCE6IIoB/qOpZWKssBS1OM2M2U9bIAbU8fipOVROpg32nCPLL3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 02:11:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:11:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] iommu/vt-d: Add blocking domain support
Thread-Topic: [PATCH 2/7] iommu/vt-d: Add blocking domain support
Thread-Index: AQHY70mh3wsY2GTb/EiJW627Rmoe664uBXPg
Date:   Fri, 4 Nov 2022 02:11:20 +0000
Message-ID: <BN9PR11MB5276C5A49961FA71CC7881428C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-3-baolu.lu@linux.intel.com>
In-Reply-To: <20221103055329.633052-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6419:EE_
x-ms-office365-filtering-correlation-id: ba0ea079-c2b5-4057-107e-08dabe09dd36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWaE+RgpPTiblaW29dDEdMzY5lPLwUJ6TRqPgR1NTHhW/CaRw+4OTeUTHMTDrxtxw7e9R6V89Q1Q+wU7VTGHvSce+30JBebGNcQ7Ci3cS0B+I0KH4WskmmHL0WTY4nIph327rP4AoJNQsnQCIa6fFcCCUkVXJsn8bvTBEH2ULmWvo4k4kJgmUBGHi9JurNG5hcM3hKIGbNaEy8OyNHcg573RKpIa7THtIXnB0/+uyTBkOsPeWu8e5k1pDZeQrZPOQ8g7H38ZeNRNej9cMR6mvld1pTTVHPMYFQivvQz91gk8gdBLyCzzkZZgrOhDbGvX5oDlVKGrbzBCNMaVk2RsjQbRD6rGo0RVkwM6zQkZK6VxQhtAjhSTYXTUxXbDMYHx8WQsCq51k2BqP62rB8eESQQcRCuASb/fiSGKK0I2sfRCOomhDptfBDJRmgQXr4mEsUEGIofWlk1WFLWGWObZcQigsSmOBFvGpVR5dpHpErObSRUOcGuznMPUgpdum+QqZEJTcCZxBvrOrOxdBFkiNVxiTOgJRmpIsQShJRkmkyLyD/uzKxhIkQY+EGnrNy4kBIhRaP4BSUvNS14NToNgFT+o+bEmRFxDM9WBe5oAMHWJ7+IS0Z4Ey+w/OxdQhmmDAg6WreHo+QqcYwwchZ5nV7iul/s3XN0Zy6xMzJRDe6kFWPTsNYewuV1Ws6Yk8tka+FSO6vvkb3XwAr5M8t8q4M7LEEAae0uxGeTzjt929+Cc4NIL0rZjoLsu4jFfaoBRuDeQJuR6MUetuIdXxa+4Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(71200400001)(38070700005)(478600001)(54906003)(110136005)(316002)(66476007)(122000001)(76116006)(83380400001)(33656002)(6506007)(38100700002)(26005)(86362001)(4326008)(64756008)(41300700001)(55016003)(66556008)(8676002)(9686003)(52536014)(66446008)(7696005)(8936002)(66946007)(82960400001)(5660300002)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QE9DjRo3czFWws/B2lqvMoNoKLeULewWhId/MBcVk02TkQB6AkxRKwji9qrb?=
 =?us-ascii?Q?A3Llq9mxFYg+M2YhsjApB7KLRcx5Haiio6u5GJy8ML3NzoCDuqBXjrxniyaS?=
 =?us-ascii?Q?1m0gPcBxSL051UGdDyVb7w9Ut/9JxsoSUmlQa2rc+iP5vsJpaddIURt8LyzC?=
 =?us-ascii?Q?P0m4ijbQaKOl3V8tk/wEFSr7h+MxENlCi3ww/2QFIvxfxeeA52zdDHZFgFrf?=
 =?us-ascii?Q?1hY9u4SQbfj0Vge5YbqJHOvRtfTubcW5alBLC3D7bqnBJTeO1nLh46H2xrqL?=
 =?us-ascii?Q?VLdNImJm06TzTDRE8duS3HQW4w1jqPP2aeBiae4FMBz3gEJH4MBoUHuzKCLf?=
 =?us-ascii?Q?sbavpuzxQv23d/6feXvxhz26CA53w9Cue9Yvapy/0T2BJyYoelYr1PVHjsoB?=
 =?us-ascii?Q?1dYRWBS1J8AnJI8rdSDDNJxj/6jsJlnPya271y81/n8d9esiNVQtzd3HsnZU?=
 =?us-ascii?Q?bcnJUp1/1Kmk9cH9L68YZF8PrNPi6KWeR0jSgTbaR9+AlMB8u65xmJX1ZOoL?=
 =?us-ascii?Q?gkRJk5KklvmA+spxjNkoOajGJQROdLaaX3zArp8dAj4wqpiPkpYHBkkIWB1o?=
 =?us-ascii?Q?O0x19S33mPRNzsJonsm4sOa0PvqYM26s2QHNq/49ykQDkQIadjPSWjI3znz/?=
 =?us-ascii?Q?/hPIglF/rewZTXwyydgmlA2U4352tHQTIu7vxyUv8qhtMH1/Cyy+82klb2Ol?=
 =?us-ascii?Q?hkPNNNiAyVp+qtJE98YqAoCRvzgK5udA3C7aMYZGRmBTEK3b6Rg2xwl23WPC?=
 =?us-ascii?Q?eFdK+6CyWcqs3rigXpSSgXiWRWvY+tOoqVmVovdY5J+O+ec7iSg5qbNlucd5?=
 =?us-ascii?Q?1anTh9Z1aKZC4WOs0A2LBF5gDEsb6z/X2tZBpXboF8lhX+mfhoji46YZDd/H?=
 =?us-ascii?Q?VNRiaW2SN8ZBknDHx9t5wD50MiBQkLBzsOZHVuaSl7AxwkH6WJLKEWBS1PGI?=
 =?us-ascii?Q?S5z1m/JyRwXKKM9Fx3BwQmDW/6mGhCJXAYrYn1Ot+I34bCBBLA/pqxcZsXEz?=
 =?us-ascii?Q?TetZaJpXHTOCFjIHvbu8GUidGC1ZAr6TiEkzMvLoVvJxbeBqofsLW4QE38xA?=
 =?us-ascii?Q?1kH06OxXYq6uSWLvEvhu5ZKMeRV6emL9+Og5cN/7yFsCwwI99M08E6QEmiPh?=
 =?us-ascii?Q?iMF4wzwkw2uimAdxK88fqd2AI9+4I4Oc4Vp8fomxxD8yOHBYnOh3nckx3v/D?=
 =?us-ascii?Q?QOcKXiW7h779RB+YLhgiFfXq4ZjjvQhAZcmrwGxRHwLsZtvDhfFXTURrjg14?=
 =?us-ascii?Q?Z6jzVTgMaL+of3lCgMg3yxi4GXH1QzpGCZswM/SJHm1lOFeCAgAbF3xN4zeG?=
 =?us-ascii?Q?MCAK9+MeuLVN5nW0Q22tfo9aT//RjoBm0+abNsUgWlD7kLWxigp+4QkLMS1S?=
 =?us-ascii?Q?O+MhRCMUkyXHA3WyY1zCfDuGQDqD3RU6/dP2hxhiliqyhXj5ifZfCLMkfPB4?=
 =?us-ascii?Q?f3myMIewN/hJw6DorLULQVSuCfZvAEBnnrtDCM6hGKfkOytezoc8Wu4B+UV+?=
 =?us-ascii?Q?UP1KcFjyR5YHw7hZAWH8RmwxwndKXkfmPqb5F76GwVYtlOjoPXFCVgbDYqKY?=
 =?us-ascii?Q?lWFOmmr4ZMImfRClzdeR9zyoGvau5U5F/Dh+USZ0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0ea079-c2b5-4057-107e-08dabe09dd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:11:20.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icYi+azTCDcNTQKVvofvnnjkKJPJKskjB7GaGUllwptzsGYBkTkCJ0OIeGaqzIb4nfbikjtG0sYrSdjmmGcQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 3, 2022 1:53 PM
>=20
> +/*
> + * Clear the page table pointer in context or pasid table entries so tha=
t
> + * all DMA requests without PASID from the device are blocked. If the pa=
ge
> + * table has been set, clean up the data structures.
> + */
> +static void device_block_translation(struct device *dev)

given this helper will be used both by existing paths and the new block
domain, it makes more sense to have it work with existing paths first
i.e. merging with patch3 and then add block domain after.

> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	unsigned long flags;
> +
> +	if (!dev_is_real_dma_subdevice(dev)) {
> +		if (sm_supported(iommu))
> +			intel_pasid_tear_down_entry(iommu, dev,
> +						    PASID_RID2PASID, false);

Since commit 4140d77a aliases devices don't share pasid table,
which implies that pci_for_each_dma_alias() is required as did
in domain_context_clear().

> +		else
> +			domain_context_clear(info);
> +	}
> +
> +	if (!info->domain)
> +		return;
> +
> +	spin_lock_irqsave(&info->domain->lock, flags);
> +	list_del(&info->link);
> +	spin_unlock_irqrestore(&info->domain->lock, flags);
> +
> +	domain_detach_iommu(info->domain, iommu);
> +	info->domain =3D NULL;
> +}
> +
