Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C05BF0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiITWzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:55:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E20432A8E;
        Tue, 20 Sep 2022 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663714544; x=1695250544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDaZwQvhrLcZty30HCaUZOChsBbF/aIAtWxb+gQt+Cg=;
  b=SrIg9Q8YtLD/6K1GTSAOe04kT7kCU8K//TwV5v9Oow5sHXipt8bfy9rn
   39Z47rYZIvyp3eAVQgZcmB+3VsdtFvs83OFFAFW6Qz7eRPQzuKVDChtbe
   S5sII+NsmO6HPgQLUfou8J7Z4bkFO5Nuxq/H03OqeJM/GSb/P7EYDHCM6
   ReNsrOQARqk1eYt86jiuVjnrDL/C6d1X4VcgoWcdKRXmxtF1l8vXbsG3C
   7SJFlHB4fLhxSdR2U3cxxr1XAZSIiqiAyegdRZluAY86VhFM55pTgP3b/
   gfpehX+rfgpBkfxlW16r0hi3Yf2P8YpLrBq/obiMmMiIWDngjlTMXGhpw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="300675613"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="300675613"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="619099700"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2022 15:55:43 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:55:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:55:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 15:55:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 15:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dApnoGvtQ7rMNKzKvJCxPMYsPEZjkHy1bLfg7Af6W3wffz/rnKgmytynGZMe/L3UJ38Sga4wVVxvghXDmRAC2OBeqUvjI3zFqDgRZe+DSt/8ogYrEw1Y49YtsVCkuHad8exEEmURRlXbwMqAeygw0EZKvnLfBOKRMKY9Z6cC/yLRh/jvM2AXmnHdvDS45lCukIpzDQvt9Tzm0YfATFtSUkMYjRNvaPz79VIp2zGi/NhQEv3hAiD+oPHNg97mKxmCcAQ8+dmyfZqBu3iGOdiDViiGgTk6zolrhCPjLQzp8Mx4hhhqbFkyfWWaddMyRe+mUojssvliJxv1MlLbw9vK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbr1JG6LkqrNgQAA8bNeCBoJQAqbKZIZF2ci6+gNGtM=;
 b=g9CZBpGGQt19i+5Lx5bpHvru3RiZ2nL/+SGWToIVnBoDKbQOcWx4CP2krGQJIydWD4ghL45iVR1jq8q9SDGtCUYnKZx4csQF3zG9KL9I8R3vYhwRh783mkUaiTP44snOLwGUWMGWF2IjtsLBV7OroykQqUztqBPEvTKXuTifvbfx5gT3GJMbBDiNqfhBWaLGwK2zk6w5XWJwPAswTwnfFbwtLhtK8P9nvwUfoMnYQA7OPoDKQQht6Tl8+tGyAyiZ5qysuv26xcyc5gaH3TBfxmzkykG0NoOCLTe/XXvuSAHf4kHfG2/e5u/d8dFwo3sCPygXOzFsjFuxgjQ+0yhF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Tue, 20 Sep
 2022 22:55:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 22:55:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        "Peter Oberparleiter" <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        "Cornelia Huck" <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 15/15] vfio: Add struct device to vfio_device
Thread-Topic: [PATCH v3 15/15] vfio: Add struct device to vfio_device
Thread-Index: AQHYw/kWx/ZcHkFOHU+t8x4U9WUM+a3o1qGAgAAo6+A=
Date:   Tue, 20 Sep 2022 22:55:40 +0000
Message-ID: <BN9PR11MB5276484952784F5E336814BD8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
        <20220909102247.67324-16-kevin.tian@intel.com>
 <20220920142639.29b1bdc2.alex.williamson@redhat.com>
In-Reply-To: <20220920142639.29b1bdc2.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7083:EE_
x-ms-office365-filtering-correlation-id: 68d86d6b-9cab-423c-23d9-08da9b5b3db3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTLEsayllH0Knhk0863MBmdlM+GLwHJkwb+U4VNNwM2IPlens1oBTYmFiNoQbzG6hIlDDyGVHWzYMz0P7O75GMGplqAK8kHKw+e3vLCiFpK7/iM4rPngbrQHmtV3X6c6hD9nmNECsb4PsO85bQNcSoaNDrNCVW4wVSqGhpUVN/HHqtCOIiRnWO3Ytg7tF9hmBk9rv2o4R73REC7p6t5oAWvKC/Ub3IM0yxk9pI3Bozaorsy24mFbJZlo53uKN+rt2RZ1RCRr8zFsljdkh5iwm2oh0kdkEjzBShBiZ8vXYBXMaBfTg2L8ylcoGQPZxuAkfA/MXeORWZxPkiadTPTn7pWeW6XesLMMUmM8KODAF8VS7eHbel5yx8B0u2ErjbykewU+tG/u/RJYmeX/HGSqE1dNq8GxCSO2SQ8t43qeFH8zGEaze35ezcojoDO/KjqzIrzg201lp1l8MPluvflFKLS6iy0EN/HIuJz+wxC097lVqUugEfcnIXdOS7AmUWoPErPCtbs5425WaNMkWIHd6WCEP5JOzCmCMQp9/FGp2pQkT49ZuJkVePCie69D+dmRpWjnAIoncpVyYUqGM3sBfDagYVA1bkVAc83n/VoTFL6a9YaS4TXqdNl0y2bO1XUvS3eiyO2XUPxQzGKL5OuZ3uW8BqEbTURB1sJzMbxUVon3kZoubhX5kNyRogws1RxlcUkKtuewGIzAuUfJDBN9oZ0p6za1tsKQTWpWYBQHjuqs6JdOrxsPBV73ZgShGbFYvWvEWtBiknPJd9cdpwPxUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(316002)(6916009)(54906003)(478600001)(26005)(83380400001)(186003)(6506007)(9686003)(7696005)(71200400001)(38070700005)(41300700001)(33656002)(5660300002)(52536014)(55016003)(7406005)(66556008)(66476007)(66446008)(86362001)(76116006)(82960400001)(4326008)(66946007)(8676002)(7416002)(2906002)(122000001)(64756008)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7eiVBslI2P6UyONwoMbV23Hq1tbKy/ExSP2zWdwwJAl7TlPc52iN3jm+cja?=
 =?us-ascii?Q?/dEz2G5QpIxbtBgmX8lJ+M5W5cCUb/tQP56dis28bAvqRE7FvkNHujtuFCPw?=
 =?us-ascii?Q?P3egLm7tFycFX5Q3MDzT90fuMtesqInLRgcqCSTcwM9ndEVqX3Ylq5Kmx/Ci?=
 =?us-ascii?Q?GsPWPB/QElS6I+u4mszPeLg8m0SY3ivwX3rgvsVnnKaCBQu9YRu1F6LXcLWn?=
 =?us-ascii?Q?KI2jnO0hJyd7CEkmy0azfks2Uo+0pwKDV+lKvTJHGw8HMJzKfJBxFaUq7Uws?=
 =?us-ascii?Q?AuzrPY/LhNk3PIjtmkNO0qIuP4e1VNw96YwIteap3aIv5eN8WFRJJzQ3sJEZ?=
 =?us-ascii?Q?lpRSHVmT6XbRGJ32SNAj7lkQrkqOPMy6HskEg+gMYFqxPqPWFRJFY53ReHrI?=
 =?us-ascii?Q?3N87qoAlaZS6rNWtWZyUpYFLAyouAvoD2ofcv6lQVzm28yXt1eH7PtLI7muQ?=
 =?us-ascii?Q?l0D/s0XyZ46VAmWNw/lRmyrlESNwjudq60Xj8D5rAwzr3o8erCDdHjBtBZ6m?=
 =?us-ascii?Q?X/8jQMEzNHBYCmJ40BukKsgDtZbvVgULgqNFS6zDxG7oDZLBJuF7EcjUeFxS?=
 =?us-ascii?Q?kliX0yYngBPUL01pGSRPa6FCt6//w3HxFJlZP94AHPI/W0tVKD+oM72IggYe?=
 =?us-ascii?Q?A/eaNNlCKH+b+SAZxB1szYW+TI3vNdukknzBkXEKQPPlrQlQdaToQnbEW01I?=
 =?us-ascii?Q?sScd5ACxJ1GM90/pB1bnCWR5sAm/k2WqVLJruMFO2JpQw6T6mgNCqxxY+oED?=
 =?us-ascii?Q?n9O3Fe5zydavFp/Hmzl3JT7g2DK+gqn9NMp8E4igJHlXaOukU0Eh594+IJZ0?=
 =?us-ascii?Q?tyNZUjr8azRXq6Jy7HUZqLjvMYbHdmbh/bufeEBEVdcdy3TtYaqbnAGUyl/M?=
 =?us-ascii?Q?vbpjKH4uCbys1kOB0Wg8csSbvtwozVzoE1nAm9hpEZI4wYED8BiFK2UMbopQ?=
 =?us-ascii?Q?HxofFprSozj6p1GS5LAYkfK19ExG3KcS4i7O1LYf8h6FEypMIxWG/TX0EiV4?=
 =?us-ascii?Q?uaZVeKcgGXAy+ZNYA5NfoS9zwkJoYnkwtRwiwPhHl+n9J3l/b62QvYknRcUO?=
 =?us-ascii?Q?SsfH6AYYx0MRKB9PvzPbe6nKBjunhvwuAuF5jY+4IKW1X3Fo9sHHc6N6FhMR?=
 =?us-ascii?Q?BHdvy19Jh/C/M/Jae95xnJ7ZxX4dlucVY3rRxQgYJrzDNuTl4ncm7o87GJoF?=
 =?us-ascii?Q?k1rGXBdW31/sqylrdvlGEqgNjd3ZGqZDcAMvER9/WDwf/z/hH2IKWyg5nD/Z?=
 =?us-ascii?Q?Ma3+TpnV+/QSVE1gXYaqt4piWuJPN+FM6s+FSg19NDruEnncU2iTM7/XsvpR?=
 =?us-ascii?Q?kMAF9hWUkc4VH+SOZ3xwdiDD7NYccIbU1XXn61u39idSmImvDpcUuR5kxCw/?=
 =?us-ascii?Q?3tg2zGcKceTuKkoZl2d8SxQKgOuqRpnxrBFKYw6qUQDpGZ4g93TB06A4nZrn?=
 =?us-ascii?Q?hYNE7kiwch4f4sPW9YyfzxA0/qTkK1gWB6vLl9PoK/yVTC2+ZQGb2eAsbECB?=
 =?us-ascii?Q?xqKs8Wg/Jo6E/yK7+WNQYe94WmEz9ezfXm4zJLbSl0tFf4TQWHYSqRhX6UCN?=
 =?us-ascii?Q?8ca9nMnOMKT9xr+8UzPFFjWZZQ6satmyeC3znqE9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d86d6b-9cab-423c-23d9-08da9b5b3db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 22:55:40.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHh5WzOxS/siTbfUn+VyMljdg3L3rEclpV/ybGS3cy4FeeV+E1e2sUO9pdR03rTicyrOvr/YQhD6uBDeXhQdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, September 21, 2022 4:27 AM
>=20
> On Fri,  9 Sep 2022 18:22:47 +0800
> Kevin Tian <kevin.tian@intel.com> wrote:
>=20
> > From: Yi Liu <yi.l.liu@intel.com>
> >
> > and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> > sysfs path of the parent, indicating the device is bound to a vfio
> > driver, e.g.:
> >
> > /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> >
> > It is also a preparatory step toward adding cdev for supporting future
> > device-oriented uAPI.
> >
> > Add Documentation/ABI/testing/sysfs-devices-vfio-dev.
> >
> > Also take this chance to rename chardev 'vfio' to 'vfio-group' in
> > /proc/devices.
>=20
> What's the risk/reward here, is this just more aesthetically pleasing
> symmetry vs 'vfio-dev'?  The char major number to name association in
> /proc/devices seems pretty obscure, but what due diligence have we done
> to make sure this doesn't break anyone?  Thanks,
>=20

I'm not sure whether the content of /proc/devices is considered as ABI.

@Jason?

But to be safe I can remove this change in next version. If it's the right
thing to do such change after discussion then it can be done in a separate
patch after.
