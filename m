Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5264C6BE57D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCQJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCQJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:24:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6BA4A1F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679045068; x=1710581068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lco9Tsl7Ffe0Qju+bjmxUmPyhrhScRhHXEH0VrH4MQw=;
  b=ZPgDBnFdUXAw7Lv5l8g6wCPcgWvsuoMRN28VmVmYQrylpzbWF9tL7J7L
   o60reVrPf4/HdVjWTMlzUzlFJdwZD/LZZNaobgQhljy8zmswr+cGsy+D7
   /ts6V6NE/JtudUbecBsIpfyAqMZ/b9dAgI5EumuT+iPD1DagNq2DBr4Fi
   9+cE1K39BZ7z3cSjQC8HBQvkd4XsxDYUbNEaI8k0YGg77r0EAsIbnMJKK
   vTv2TBDzRgbOHtoyirKJypvcmRCcY9rAqm/C4nj3qUMgd7WCu4AeQlA4o
   ABqlfFIW3yyprxwbK9dHuKHMk1fpsxxnxUh3TXtcT+CHgB4PUMZ0gbSBL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="338239908"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="338239908"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 02:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712686238"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712686238"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2023 02:24:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 02:24:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 02:24:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 02:24:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 02:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnJDoROTNXH5ZWChykLsfg2CEWxEZgbH5nnd7+xKqiU8fCyOE+lmUc0ZLyi/6i06A2wduGmbil4XnVJFm4Ncl6ijujkfi7Yg/sWVai/jrMA+11gbHk2GpYhq9A+Cll1umcOZiR1x5lnSg3kZPZ9gOY08ei38KC3XR01EsQdNRB8roa2DJlo79+xMUkLLMdmlpG4BVPaUb1cjPOcIRrOB6eCOexAcMV5N6nwYYZL6Zw6qtN18ZOrXz3m8MXXy++1N6HfL8ryn4YkngDQYpyYtTML4HJZr7LhZTaQJtcIthyXkI5arH17YtuXMhxwRQGSaPNfJPGHWoSBgTIEVLcyWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lco9Tsl7Ffe0Qju+bjmxUmPyhrhScRhHXEH0VrH4MQw=;
 b=eEucgHUokoQf+32zySrvIl+I0pY4GYdMvx19fZAL6BG5HdK+RJJLNQkW2vcZl4dSaUJsrensvxJGSIrL37mLI1/HywUubSaqzFCV3Qs1O9kWqotH9Kr3u1cMtF5O7KUAFxJOlDgC+i1dRS6JEE63BiIiVijVeLoC3I5M313cBJB4vTlde1nDdW9fuThlvWu1Kjz0WQin5gBt5gjMVzTcK6BlwCtzR9X99xEDpAOneJZiKGSRD6vP+QPKlgAyzjYG+V0CPIeIBv4htDXEY60YiiRbVwOm7gKhPHeOKLJL76hwaJ18PSjEpHXBw/xFSOLN9faTxwGjcG/DbD6tFKq1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 09:24:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 09:24:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACADCcbEA==
Date:   Fri, 17 Mar 2023 09:24:16 +0000
Message-ID: <BN9PR11MB527665B62EFF58F07DA214338CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com> <ZAn7uC9UweiNdGkJ@nvidia.com>
In-Reply-To: <ZAn7uC9UweiNdGkJ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6775:EE_
x-ms-office365-filtering-correlation-id: f894f262-c3eb-462b-f5b4-08db26c96177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qbKhygFo6nRmlBPYGEpYkP+ayvogoLjs85Ttby0iYS1HERK+nZ68C4BxRUhOwlVznV23oWCLjVnuzDPpNQpteqlHTUlOYBX4zp0bsjYGGiiYCe+mpEXkh4o+RlOselimWJ2a6hJvqOGmMVqlBbTztE0PoNIbbkht3uATVJ1KD8z7l4LP0lBPo2UZlTkGiklSwlDxMZuUWVodV8pzAgrbOXJHauNrWVJELUaipJstoace3t7RlcO72huTXjx8SnhvRTZ4a00As08dM6hxkWl0XHrrE1wzKzhdJZFCYRfvZamxT+thmMi8Bb0nU1tSd5Zrkxy4XorTtYjflVHIlmWB+b4Ddy7dMHFta9SLrbZCYhp/uCkyUEOkPmeUcNEuP3SBivw4PSVepwEBvDniADExal/tRbjTFjXZl9oG/f8ZlV/tGpWx/DglrC5jNspJ6iEKXJcu1UEYV5VkEZ0bO1diA9udy/VuFgW2K0jErGSFwAC4Rx+mhs5eWAtjsQAE/JExG35g6/LKiXvWgd/vE6w6vkOnlpkryZ/ikDwdsmQyEUy1DO3tYRaBoh/TL43TygI3kGk249rn9Dz1hOJQdijrm0Dw1JO0l/cCHu2D8sd2vp+5j/kaGYH6k4B48Fm8cKhfnmV1gUKfh4qbHJcBOfpCkzdRBxYsViS/IXwnSkp25ELLRAN50bkvDP359dthsNojolw44d1QahWn1L9+C7OYvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(186003)(71200400001)(82960400001)(2906002)(83380400001)(9686003)(478600001)(26005)(6506007)(7696005)(54906003)(316002)(110136005)(76116006)(8676002)(66556008)(64756008)(66476007)(66446008)(66946007)(4326008)(8936002)(52536014)(41300700001)(7416002)(122000001)(5660300002)(38070700005)(55016003)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lHu8Bo3mJNUkrJmnPyn3v0MfeHm9aw2pGjkqxfe1zLo2AGEan5M85jF0NJXR?=
 =?us-ascii?Q?Ug6eI1LtQBD+El5eUDptsfkfnbeMVQB7En9OxSib6wUvPYR1kk+pc5n1JPbm?=
 =?us-ascii?Q?cskFuJgd1Dh6wwG/OlItTcaBp8BHe1KUvRrEAEbbmH6PUPwGWdMlUH3HlBr8?=
 =?us-ascii?Q?9jQTVb6DTVaR7nZ47DMqyrO0ku9iK8eh4zJu00azD6Jok76Az4/sbDehhZQ9?=
 =?us-ascii?Q?irfDg1hmr9sdNcMn2KF1vyn7KrwupY8bG8J3B55okUvGXdbaczS6OMqUiDRC?=
 =?us-ascii?Q?fGoXVEpcJui/Kp+h6fMe1AoWBwdjY5KYochjgExEXEK0zVbh1qMpch930/az?=
 =?us-ascii?Q?W6mt1KjPVhCI+9gJvDwgEf1DnA6cnBNMGv4VQiaD2meafmiObMBQRL0zdz64?=
 =?us-ascii?Q?myrqxySm8/tO2eBJdAGqhtR3rJGpImjPPCbgm/MDmwTnCva0s5rtIqrhwYXZ?=
 =?us-ascii?Q?TZhASd7iv5S4ZrUWSgu+lcUFD3m4nWD8HoPmlQWFDjmMQKTBpx04hqhj2i4C?=
 =?us-ascii?Q?5LgieAotUmKEBo3kCxotU0bSBzSG6tKNxJf0rdpyaV/+v6LBubn2uUfYwsdW?=
 =?us-ascii?Q?VA5teOAsBBpTYTsbrDNglgEoTlPcprqGDqebvcW21gGPOBqqW5EAxgsGjl1n?=
 =?us-ascii?Q?rzygnP7+c6ZkUu6lLVmQiSq3LQkf9u5soQ2NwkaEmAl1Eh1LeYXMFfcLSQMj?=
 =?us-ascii?Q?AHCdAIoieSEl8QX3CwphzayGInMORMHWfVzaZ787J+EICtJ0ZSRSXOKUVb5q?=
 =?us-ascii?Q?WAK10cf4aZAG0BamyZI1SrphAITLbp4zrBNj10SK9iPg7z4tf1LK0feGDOPT?=
 =?us-ascii?Q?CqOWT97RwagzJEJtBSuWWH0IroymGpv4x1zDgSIaj0nZGB/ZGBInt+mSPsLn?=
 =?us-ascii?Q?1amsO9h86MA2jElpybO+v5RPSd6ekS9brkH05FEZrEdAgdCDeSRE9hD+D7sW?=
 =?us-ascii?Q?caPW+vleFSlvDjBJ6pHJbisC/jn2k7zeszY/UPxQOVhSM6XqufHsQjXOfwbR?=
 =?us-ascii?Q?3U5jiVIO4JqZUfTprm5HkrvigNfCKeDkFSsBNxIwO9JcmH4SIiq7/lbxwLLG?=
 =?us-ascii?Q?QpGy6MNSDgwMGrMhGcxC1d2LQyz+KSx1QP902Ugv56bRG40IL/1Q+g+Ll26Q?=
 =?us-ascii?Q?y4PLblWTPNWZLxdqwsyVIjoxwWfWXXEI4v7/doh4ZoWb/9N+jTmgrmU8kryP?=
 =?us-ascii?Q?m1KzZ8zG8ecOXsij9P1Q0YU2LE0JCFZca/HtTVjI76504nbq0ddNtpRxtgHg?=
 =?us-ascii?Q?od6vcegsEDHWiVtjXhEki1wb/xuuqIG5OZm/uAa+C0gXB7tTYju+InAcLshY?=
 =?us-ascii?Q?5beCPXrBnF7uNYXjoFHJHqjLllMH/5fxXwzR693ZE3+n03j0swi5TnYpxf0n?=
 =?us-ascii?Q?n2rKWdpMQM3X82aEQaa/BSJOZumAobKLRhZezXL6tBV3pbDjcDdQd4jwH3YZ?=
 =?us-ascii?Q?fgRUjm4nmBOMd4b7ORCKz/FiQ7G1iBA7qYqHD8Q6hKHRV8TMHpS6ANqEZowK?=
 =?us-ascii?Q?I8FkXxgGgkT9/elOTjSNYgRri5qKHiVrsU4zJ6Y0YwD9kPwEmbCNaHYu4nk4?=
 =?us-ascii?Q?lJyBOCJZlXdXabpF+CfZhG/5VW6/3sldS8YjJIS7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f894f262-c3eb-462b-f5b4-08db26c96177
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 09:24:16.7965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/s43VlZrrevhtILss8Tty3Om694bLdR2e40b4w5WTltBjib3yFeKBNK7Vm4Wvgwp5UfAnoeZKorKNNkd0ZXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 9, 2023 11:31 PM
>=20
> > Also, perhaps I've overlooked something obvious, but what's the
> procedure
> > for reflecting illegal commands back to userspace? Some of the things w=
e're
> > silently ignoring here would be expected to raise CERROR_ILL. Same goes
> for
> > all the other fault events which may occur due to invalid S1 config, co=
me to
> > think of it.
>=20
> Perhaps the ioctl should fail and the userpace viommu should inject
> this CERROR_ILL?
>=20
> But I'm also wondering if we are making a mistake to not just have the
> kernel driver to expose a SW work queue in its native format and the
> ioctl is only just 'read the queue'. Then it could (asynchronously!)
> push back answers, real or emulated, as well, including all error
> indications.
>=20
> I think we got down this synchronous one-ioctl-per-invalidation path
> because that was what the original generic stuff wanted to do. Is it
> what we really want? Kevin what is your perspective?
>=20

That's an interesting idea. I think the original synchronous model
also matches how intel-iommu driver works today. In most time
it does synchronous one-invalidation at one time.=20

Another problem is how to map invalidation scope in native descriptor
format to affected devices.

VT-d allows per-DID invalidation. This needs extra information to map
vDID to affected devices in the kernel.

It also allows a global invalidation type which invalidate all vDIDs. This
might be easy by simply looping every device bound to the iommufd_ctx.

