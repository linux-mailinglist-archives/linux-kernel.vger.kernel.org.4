Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8D618E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKDCTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKDCTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:19:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2520D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667528388; x=1699064388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c6tHscOzxSMQB+/rQ+NVNZFDekg19c2iyjuvl0PjAMY=;
  b=OurYUBkkrCQREoy4uSlusSX/KqbpMGnutF6C6fDB48KyooGjk3DcgqnP
   INZAvYz82FNHvLAxr4uTugxhNJ7wu2JyxNS8uNq601LIOVWjWhcd0YClU
   0BUAVQHP2QnI/pgry88iMcqpExd+LD+J0eB0uHXuDdDZ+s5XYZwrBoE6y
   dh2TNJ0y5ZQcOHL26720Sk4BAC1MPal2i2UfeOptVU0Iaah+k02HRWtTx
   gPlIju8t204rVbUNMD4N3dCRaZMV1QjMM8LMhaFJWH0+2mloSBeCoKOSv
   YQrKfbUNviw4dSSk+Ot/VLL5kzGZHd4D4T/3LyKf+9XTMVd+7bZxHG9oW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="371963514"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="371963514"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="637416614"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="637416614"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2022 19:19:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:19:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:19:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:19:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW+jIdQ8h8jEfA6TAtlQcEl0G23/92gPZjUv5I/e8rHHt/OtbNbMcOwson6NRXEOv4oYkRSfxGUsQ1y4eXQ9gwHcghkbb/afWr4LroFdkqeKO3MW3+LskYYKEMycJT4EAuVw9lRe2LLyrE/8Jd8cNRB05pp6eKpC8elcudPfM8HEBxFGazzSy/h9Rni3eWowb/lR2VDnC3d6NQu2QxY48I+uPWXN3GZtn3unVdW1j1pHBQSlkaN4inWfmJXiVyuC3rxTBIsAasCjW9Vgs9PGtcAi4goGP+vIhOBZkLpU7k0EjyAkp9yw9/6dGn15L0Ck9suqpW9OxwQ888R+Xar95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6tHscOzxSMQB+/rQ+NVNZFDekg19c2iyjuvl0PjAMY=;
 b=K2orD8nHtXkYwiNqh16wtPYi06e0bXEFPYuxX4M98XSSydXOKgVxp/saHnr8tBUlP/VCFKkscvN5+x/ygXB89JP+2rORwy2+9NpKmslEB4+KHXAp6rRKiINTcXYjJgWpqny4x0+Ab/yV7jLV0bp32v/+39RGEqsaVksOlKFkNMYYLRP8qXep3K99rwwYKysGx+dP/VRt2+VAuZrEnBSEDIcnN8E1XC5QJm1XWDXCxrFRq6Azt3iz0YKAz7YqzNoC4v6QxTP9kR20Cr/gU/ocv3plH2Dd4B6X7t9KnaZs4s6i472SPCMMhoGMImWcGLUdlzb9W0XJPeU7qGJ/1vR04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 02:19:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:19:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/7] iommu/vt-d: Remove unnecessary
 domain_context_mapped()
Thread-Topic: [PATCH 6/7] iommu/vt-d: Remove unnecessary
 domain_context_mapped()
Thread-Index: AQHY70mieOIDiqDdbUiajlikf8CBP64uCSKQ
Date:   Fri, 4 Nov 2022 02:19:40 +0000
Message-ID: <BN9PR11MB5276932B9BD5AAC340502B188C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-7-baolu.lu@linux.intel.com>
In-Reply-To: <20221103055329.633052-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6468:EE_
x-ms-office365-filtering-correlation-id: 1de5d691-2369-444c-5af1-08dabe0b0753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GJIDSN0ywg4IJ9ZNMbuz6ZpFZ9j5D/sHgi8A0zcPfDGrN1fEDpa1tYj6MVmZSiy16bWKfJexIP3cSkp1q7dre2ajWyOWn8Vzfqzv281QOO1TIzGEhBcbfoTX2+UabL1H9MuCjwNz2m7CXOCeWZlRV5g6DOLsssDv0BHfz6u5p356QIkTkKh6D0qvuDdqXnYOOc8gZr2XuM3PNoKAuBjv4gd9od7o2K/3MPuHVxyzpQ9zNSdbBHu9D5Es7gcJe8Urn8iMDli4LxATu7eZy3j6XrZ0yf9js6jvCCac4AxqddhYQcuTDyrl8JcdDjOxJRVvEzF4BuMxD6uz32v7CJMRfoNKXZ+no7SE4R5Qv+F4WyvNXIyDWaVvPtVavCk4kPyWWQSZlc3jlwxe61Fi4kHBiEMBo5NaPANudimo/RLqUxWYYzxs/+Z5wZFK5+PwI+aWWs5o55smNsCdDtr1AWhoXA6HtzxIWB39hNE3/Tf6uIp0NVjAZ7zRYxzsybf6tqYOs6SY0XUhfMbgkIq9ob50KjSzcUPLHx0EWGRAmDsfXEvpYkh+JN+/Y4OMfstlM8zrmN1qTgSDWU6nDBZll732uRa+8MbfQXX+NLUDNpPDcTsmZw7vK41XXjdmV57JjcH1vhDcscXlV1DKGeHdlWrF160x/P4QhGgn5N0yJuF4uvQoZuDLr/yLH+I48nuUTaWyZBt20Aq6OdvAg6hC8XZrOfxpkp63CFWibIWTUrQOPR9jCsrK+djtD1YD/XcVejq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(33656002)(38070700005)(86362001)(82960400001)(38100700002)(66476007)(122000001)(41300700001)(2906002)(5660300002)(4744005)(76116006)(6506007)(52536014)(66946007)(66556008)(4326008)(8676002)(7696005)(64756008)(110136005)(55016003)(316002)(9686003)(26005)(54906003)(66446008)(478600001)(186003)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dwzuH3XMoUA0mPUvy2I7rOEC8xX93XzaQG3b6gNpTRPdmxh8gMBZDIWPJH1i?=
 =?us-ascii?Q?rreQg2w80FisS/8JznV1f62nwos7g5ZFm8pEXzRfOAI+p3Hxa9Vo8HlbLLlN?=
 =?us-ascii?Q?rvuJqm+lOID6iCtAg8fVlY993Km+uF8Ob/jX+yAn3OvxSIoOcP8AnHlpodzd?=
 =?us-ascii?Q?GmalIot1aQHulmq6OVpz0EGdRa0b41WT3JhtmzrlVTvCZqetnN12yrXcp7I5?=
 =?us-ascii?Q?44Cdgy7xqFIw6IzjvnkfqH5+5DeCoMpg4DpT7UsZ/Q4mOD9knRHpCv+WzF8I?=
 =?us-ascii?Q?G9iJKIyLNHqJdN5pnLDXix7M/tHGrWJ4SfwbAG4QpQMiEh+zDoL+tRqY5ZMx?=
 =?us-ascii?Q?jvEm4iEDb4Wuv0/q5bqLlOzU2qFlghR2CCki5UCUIdjZvnN2v4wBFxnXJo9h?=
 =?us-ascii?Q?0qOYRTPWrK+Tp2iAvJ4Kdd8kgy2EW6a36ixEGbdcMSP3RPzn2phVi9BQhxFr?=
 =?us-ascii?Q?wNW0QfmfsPd5ZlcKio3ZomhBKBYZ7JJHN+pOHdP/69C41zUOkINHS+g2AdQ2?=
 =?us-ascii?Q?9oziC6En6uY3Zrc/uQ8DgISgvRDdSq8x992PkspZZLoE156gHBTvf4R/tedP?=
 =?us-ascii?Q?GsvIBDGzqh8apUGlPvoJR7XsiQOGfQam6382Q68iRO8q0ItamIiZl5NSpr56?=
 =?us-ascii?Q?MdaR4/RzmrAqE3rF33ibFvUmPQL+ju+Jxu2InHgwcdYEGqGq4Te/2CbQ1Set?=
 =?us-ascii?Q?NwKskinGKVRc9/twtLMdD8ev0VXDvfLM4F47uuIMSDwNpK5VecaqFUq7dKna?=
 =?us-ascii?Q?sBFTWT6qtYiR5N5rzTx2kdNln12cOXXvaBR+olKqm8+PMGJgir/7CSgRz4IZ?=
 =?us-ascii?Q?X7itHxCbrtvx4OTpgVG2n5RIS7MgOiCoiN1Fh9qiP9Nq6ql2X8g8ZWXdpWr4?=
 =?us-ascii?Q?TFvzSRlIB9aLuBrvl+XQnx+CwwZaIFdxoJG2cw8xVjmvan/b0C2LR/1AeD4W?=
 =?us-ascii?Q?PA2PWC5JlXWYS0xcJ+GOdHgAT8zkSVlD4q5M6LNb27zVasIuLSzGCAT1u86s?=
 =?us-ascii?Q?3tCRyvBrJbLdX5iTtcC35hE+7rYtzo+zVNAB4Oukkt6/ILKa1RkdWQTJ/zUP?=
 =?us-ascii?Q?4XzYMs+0yipxcl+ModA6NBDI0+7ibDZvIY/IWkthWIYNTtHmeiMQ+hdmTGkj?=
 =?us-ascii?Q?Z3jVB1eFQX5eS7I0Kqm2bPtpwKYDcA/9RYC1v1wBl9xW0/auRDcblb9Q2By2?=
 =?us-ascii?Q?NxcngHMRztmWM8C83Ewic0+tg8gNzRabocN4kffNwbJCymZBdJcc2k0dGePF?=
 =?us-ascii?Q?8avHBNiT4u3/XImKGqgumA6BbXj8cxyfwPchFAmL8kjWuxSsqk0BMW9eTUzQ?=
 =?us-ascii?Q?p22BnbTOXCRG78hpM1IbtP2lgs5o2wD+9726S9D9BzNg7EJBk/uwmhvvg/3R?=
 =?us-ascii?Q?zO8UVuha9I7BkE5x0F5V0E/1ww7AYjpmBwokVr9SplVVaib+LtqZMhEcG1gu?=
 =?us-ascii?Q?hb4Lg5M019p/tltQEMuT3bydKEbIauRac/MoJOL9gm3G2qSy2YE7V3pskKZB?=
 =?us-ascii?Q?OUJ3ZAz9FLkGTTz45yVWMH4ODpl/rMcJH4TAjlyp/HqNNMy0gk87aslxE2DA?=
 =?us-ascii?Q?Jd4wMLi5OEaPdj2ih5lHY3YvS04C45Im8JyZad1p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de5d691-2369-444c-5af1-08dabe0b0753
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:19:40.2855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIiB7VxTsVLhWrhPP+tqmdkYiAfjlgvm0aIlTATPLxa+ThxSt1cuLOW2sQdFtA0zZQ0bA8qKQGtS4y1P64rqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 3, 2022 1:53 PM
>=20
> The device_domain_info::domain accurately records the domain attached to
> the device. It is unnecessary to check whether the context is present in
> the attach_dev path. Remove it to make the code neat.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
