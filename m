Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98E66251DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKKDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKKDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:45:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034D60C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668138309; x=1699674309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pmvpOexLfuvwHGaZ9sbnjPqaTjS+E9WoVQrKagbUDu4=;
  b=PPAIXE4tZyqmg7I6oN0abAb0aCtfCu+5lcnpWOPscBXP8gA1Uab4aK7t
   t1/jEWl2qLrYmSzpH72MxJksHkG6zb7bCmZauFeGn9GhF+7Faay7cUF9A
   YI6KEaOtP5hsEgmzZLr9K8C5qIYKIgd5Jmb8YI6gykutcdwUHuNEbeBn+
   Ma22cICsVZOX4H4RyLLSTK3UwEGutdxy0o1FJAOxbZryYid87LNcNNQj7
   5X/+9Bescjivsl4u7WKy3+IIXUJOxa7x+Fl54+QEwa9/oP3fEWxEc01v0
   7+wagBo3TzHvxXFrPNDbRdpZFZAqGtnVPC+lQs2I8ZGtep+YAkEu9xdwV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313297798"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="313297798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615357342"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="615357342"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2022 19:45:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 19:45:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 19:45:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 19:45:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 19:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXf3RAWatF+0EQIPY/5VAflnqXInnqHKlZswkHDcQAelvx4LqQQLiVDh9aq95YFSgjbPr/7lu60vQ0oH+S78C0ZUcdfh8CAohza7+c/cdHB/UeHIEJY0JRS+GlPhazGTJudLW33dKCGleo4pY5FPAsAEixSPkXfZOnkwjdBxhc6OGPc3KxSIZ5k6SS7SuXXtpZIqjVLpMtTv5rMqtmYPtrEeyo+6A1LbW1fth8t3WwfMxcHLm6A4drcCO2zn1joEwEEKlGyB9wqlKnu8yS9DOWcNr7DsqQbJ0/PO5PlQrUX9QD9eo+bdM4EDjFMtFrbSuHGWIrVFJKpP80fScB2lsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmvpOexLfuvwHGaZ9sbnjPqaTjS+E9WoVQrKagbUDu4=;
 b=FgXwkIBQ57I32FY2tkD1OtRNKD/4qttH2tA5X3YHcXL1D97lHFI5HgGQlAJPdBZEf+JSCg/2t2r2Y55ZDSVlxp2baGJcU458VSAkrEL4gQJaL409CkvVcfSbNbOALxAhXbCgfKkVZo+IM+YsfMqniRzetzuHnFGGt15GXJw85jD7nCsDR6T6yp77DRLj1bTMmszFo9Wg9BFoy0uy4RPpQUxCHKmen6eMpT1A42+aQgTlFEG1y8wwd+AuFL4OllU0Yes9QT3CuDuhRNVwtwdkMCzLaQB4W/+WXP6q/IiCABoXkbHf5Uc6i0iE6s+MYvYYfYC+s1vIjPkJPbMMZqW99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:45:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%6]) with mapi id 15.20.5813.012; Fri, 11 Nov 2022
 03:45:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
Thread-Topic: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
Thread-Index: AQHY80V7dgdiF0sR3UOD9Dq2McMNxa45F8Ug
Date:   Fri, 11 Nov 2022 03:45:05 +0000
Message-ID: <BN9PR11MB52766AB454992F154C301CB28C009@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
 <20221108073408.1005721-3-baolu.lu@linux.intel.com>
In-Reply-To: <20221108073408.1005721-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: 96f0607b-951c-4e2e-6c82-08dac3971f53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwhKZNeqcaBQWyFoqFrgA/ytiIUb46xxlyNGmibr7eTJHE6YUS4vuAv4kZLLdq74o9u3mUP80ZuDYL32YDD6LghjRtmjAMnbe2aP/UeX5cKeZpTmuK8AMp/rTYy4b/D44xBTgfQqGQf/tMquktPGfGrgIkg/NJnrpRJ8p4OjbPahYffqqBxZu7uKZbk3hQxL3Wgzf8oOhXKS+kx1RdNC7UQLKUqdxiqVlgHlZNWEXQ3wmyA31Rdeuf7M8WP2o+X3bZBfFG7KZ0ffsrQmxX296F4fhvtGUesu4l8YbQSsPRKecQ9SoyHinOohU622sNHdI1JshTe9mmOHp8g2f5StBAUt6xMrV8bY1AK2ExFmGazbZFL6jm5j5SPeyCWCuekxXwY0engqz1YXRBn4jCsBeTu1bL3rqOUPwJXivpOkUHlQ+VZZx50sUez8einhht8Xhq6vYYBlLma0wJeoj0Q9CCyurG7oI15wmiTFsDCFgf+XnyxuLI7hKSRUe1uT02wxlpvEn5h+UdOEcYfItyeS2zo/nX3WR4FB5yAqVWFOFD2x6+ILFdDOWgtB1nK6z3GPllO0OjFvXYjWsvtjvE6c1WDkzvNXu66VWlQDFu1p0cZrDvzwNa5DTTYhkYLxnDArl/7OjbFh8sej60+Fp/yNFK4aSETT/eDYOmq5XyTRbGDAHCh6NusDLSiN+HFvel/rA/AmIvwdHXhZ1aaSxTwKUp6Cm5KSKjnwxPdreLQJtRqUwQLY0EUPTAuoXRFx5H/J3MyJ5FofYrygX0dR214ylw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(55016003)(316002)(33656002)(86362001)(38070700005)(82960400001)(38100700002)(2906002)(122000001)(76116006)(41300700001)(8676002)(64756008)(66446008)(66556008)(52536014)(66476007)(4326008)(66946007)(6506007)(4744005)(7696005)(54906003)(5660300002)(9686003)(8936002)(186003)(83380400001)(110136005)(26005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c0m7TbeMWBDFBPDJRYfuBpOC9R6bJq8YvlFio+YXFCGNba3lk9AeQnPRBjJS?=
 =?us-ascii?Q?cAovZr38eXelUJXzHuxmrA/XS+li+ClNQqe6S7Khlj7qCrgwiUG4ztDwlLkr?=
 =?us-ascii?Q?X9dWaQtzdIvadXxQhuXpu1N1RUNT9qgmjWFIK7e8s2VEYo1/4kq2pp1+uqjq?=
 =?us-ascii?Q?66zngBx+twwZ3hbwrzmKD8d/n5w1ax7yWym5rwIT81zloFpZgFNucGLkQ/md?=
 =?us-ascii?Q?QHPxb4N5OYv9LLcfxJI1Y3BC1q/yAnMYtzaOSMGVgroJEfebEc3NUR4284q+?=
 =?us-ascii?Q?vOMXq+95smqPn8QiJinKsCmD2dX25Uzm9DN4rpL5lccEHaHWEEBGW4WJWURy?=
 =?us-ascii?Q?XU+scwYnND6VVsijcE10ATjCn8bf/CgzQxIDa7myd0nzXvt2KzdHYlxYLfLl?=
 =?us-ascii?Q?6o0bXbV24P1lJlJ2KrLkQAAVfxIdfNeBAw9CW49fICVdEWiSraawlB+weySD?=
 =?us-ascii?Q?4lNCB+K2O7BC6C1MeMzDATeLr36vfq3ki4rmJnOb3HJRYopyvp1a1y3+c7O3?=
 =?us-ascii?Q?VEhhSV1etXHFnVK38Vmq+OGbxcxK+1djOPHDctlB+J6xjpAH0zCSu2niWLaS?=
 =?us-ascii?Q?rKE9wOe2QWtd2hBqG8phNy678IJL8Lq9X3tOVnJ13e+2Rn1gC6Bis56xwrQq?=
 =?us-ascii?Q?1wXjijRIHLWq+Gs5atIXgYoF8nvj+01I+iN/uLB4kDkbTKQs2ggIcp9VEZJb?=
 =?us-ascii?Q?noMpmdLPsYiJoOPDzCaC/0/9cLryEiB2kXr3B4mfoPL2cBMUWUBf/Wm1hxVV?=
 =?us-ascii?Q?LOjToY19Ec8Naht3Z0lhyJZCcF1wYv7oyLB4eFPaMOfq5eADUE6e7s0qujll?=
 =?us-ascii?Q?bzxD5u1Z/dVj8t3tS/zF19vwC4cyfQkGa4+WTy+L9xUnSRyB1tM1ZycBVb4V?=
 =?us-ascii?Q?s8iN2Sj8IIaDwdd3KPdQEGKawFI6yKCu28nLYEepFdnZOBIyTbpRvEOAQq+y?=
 =?us-ascii?Q?H7OD1Z8HHU8yimfF0glQGo/SVKe47cfer4sziN37079FnzawFdVq2WQc3myu?=
 =?us-ascii?Q?BThqvUrTnyV9u9NARw5lxJS4+DAd09UIBbR4LBFtkrksl97w3eFsjAymsQ9B?=
 =?us-ascii?Q?E7R8yJNG0SibAtBWK1bLs+cUKQeALQ4qRbYKEzbGkyt8vTiQDA8JeLN+lNUA?=
 =?us-ascii?Q?WSofTDrdVq0hR8WQDMff/5n23aOZEDI/04rdkRaVJNuuajb6nqzxu0OiHQ+y?=
 =?us-ascii?Q?N4A5Mw2XGmlU9HeMo0MMJy1FBGffFmGNbvyFXNlR6E29WcgyCDZMkjB2GIYT?=
 =?us-ascii?Q?lDjSI+Cd6Up/9X6ZB0IqrHE+3D4naIKmH0h936CjkxRpAn5BH3QrOWoDloiF?=
 =?us-ascii?Q?6O2gcShwg+2Em2J1CQHtBplCM6KyHW55UpAMI2nBQrUIlhw2ehTAgoT1tIb4?=
 =?us-ascii?Q?X2byS/g8a64XQ8nyYYIV4VBbByY2XOJRY/9+1GA6eqNWk9fQ8R7NdKaluP65?=
 =?us-ascii?Q?A/lRxBnAmJ6RiFc7Onjf1BNYrg5CWtK4s49ctOEEn3BlWXr54IJYAZsSrCzT?=
 =?us-ascii?Q?s5VQmj5cgERL7ejO+7DN+ZrLmzBr98ah/0SUevA8l9LCuypwD75MjJwh0ctR?=
 =?us-ascii?Q?hmaSrR3LuW4+7a4YDfLoKh6HYPRE49n9Ba/DrmEn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f0607b-951c-4e2e-6c82-08dac3971f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 03:45:05.8916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mNw43kQWTt0PlaQOf9QiIDHmWiQ6wGCzuDNujUiQf/CWzxHu2G89QImj2/JVu7ajqvmjGa0g7Hv9ivjxnvUZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, November 8, 2022 3:34 PM
>=20
> The PCI subsystem triggers WARN() if a feature is repeatedly enabled.
> This improves iommu_enable_pci_caps() to avoid unnecessary kernel
> traces through checking and enabling. This also adds kernel messages
> if any feature enabling results in failure. It is worth noting that
> PRI depends on ATS. This adds a check as well.

Cannot we have a helper to check whether this device has been attached
to any domain? If no in the blocking path then disable PCI caps. If no
in the attaching path then enable PCI caps.

I just didn't get the point of leaving them enabled while the device can
not do any DMA at all.
