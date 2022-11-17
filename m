Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04B62E4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiKQSrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:47:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6A1057C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668710862; x=1700246862;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nWXvrZSfyVdu9W5QCIkn/m8qViGt3jCCG4Uc1OiZyxI=;
  b=g9tP2EFkk8vKfZiIh4KFfBJG2FES+rt9z3rkYkUNNMGQ7TwhSSe+V0vZ
   2ODvrCGy8teICaX7mW0U38zpvXdW01JkP/J3nCM9EVJmPu5iCKhSziDPn
   ho5mUgIOokDE1xGmJclJ8+nyT7Leg/n/qgRjo2CoJVlI+Z0T1H3fPJ5e6
   3E0bUlzhGI4jUnR0GlfmA6CSATn8vEQu/Z7M2U8C0/6TKmKPxsUFJxSFj
   35oXuIHLpM5Ru9tpWTgzgKhpbsoqZDQyWIQ7CvTCEMiEe1a7fZIIFiE92
   Lc8yjq7GNNTaJzEifGkjjILrkFudMB332sXAqdBJA/QFugI+R6NCwWD+H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311646725"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="311646725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 10:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="745662642"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="745662642"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2022 10:47:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 10:47:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 10:47:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 10:47:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 10:47:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkR/Pb2HaC6EM9S/NzHRZwSFBZ693q8tbL+al+TfmAMpPFOPgWp4Of4yrjmtpTTS4qFZDytfgyFI08EZ+yACetbInPN7hOqXFYILlCRc7Dfvy4I/PnjdvQJXlDOaehhmmjme19R08Ic4McDprbSKVKvyztTJBKRWWsqlroE9Tv/1ZUCVEdm7MSpaYuTb4hdZ40bWFfXBmJICrjiWfrJDU/GdHaSdCrn6cyCnKN2DG6lBruMj+GfurWe7EmAH5dvDuaEpd51GDl0KXbXNd9JMzktlIhwa4NXvbriQxMt4tcf3GjTu/kztpNRJIvlmowejnqNh+zmxf74367nwKqDJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4uY5oqtYCwhG3lVrdh+asaP5tWpYub6lz9g9k6RAgA=;
 b=AiDQK6S620QgbRYb1NEtnACTxyctRmCjUbdqPs+p7yGZ3cgLb6dhjnZqEbmiKXBxqmyEvGG6giU330eo5Y65cUOAZd0Hn6avXom7adjnuFZzUOrC/jNw92NAKXAZyOXzxMxdwYzzIhJGzpoin+se7ATeW4iZWDoLn2F2MDJdeFmLnZfzHF3Ut/h5oi8PSQv6HjZbu5tK74rZM2F7Ze9lD+uF4I2SX5V6FQgMzP/G77AUjZDeuspccQqI8LGR/BXeHiZze0BhmkMYyinNg4mTjUVZTWPPW5NAHsS+kPZ+cdidaYPP87acsGGujlLu66jwrQeZlFRpNTGxKiQCmngShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by CH0PR11MB5362.namprd11.prod.outlook.com (2603:10b6:610:b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 18:47:39 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::a2b6:70ab:aa5a:9340]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::a2b6:70ab:aa5a:9340%7]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:47:39 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Dipen Patel <dipenp@nvidia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Intel timed i/o driver in HTE
Thread-Topic: Intel timed i/o driver in HTE
Thread-Index: Adj6qih2Gsi7knz7SkKtEKSdboc8Iw==
Date:   Thu, 17 Nov 2022 18:47:39 +0000
Message-ID: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|CH0PR11MB5362:EE_
x-ms-office365-filtering-correlation-id: 071df650-0d0b-4feb-2e72-08dac8cc33d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzHiRR/J6ATC5DKuls7YPJlQj5Zwc/w2I/Bwn8/3vuYEzv9j0XEPsTTrXr90ZFtMxnCAls12LVtzvOqJ9pBpnvUA7E8GvgA8aGHnFBWBPyXfhEZ5NreOZDogRf3o4XGT3I9y5tn4Iw+gso2wv2tWvOE+44FqZkDDBoya7oHoxWEhCKxC92qqFqzlsaVJEOTrD3AAm/+nax3pKSGw6/F0cK0RyNgOZvtv+yWt67o4Md176CG9kxUGuwne0GCl5ujHb0/XUTZGQUpPgZe2Wwxn+gl3eB+ziDP4OuOEIRD3Xe0ucxLlkMhlXq3Q/0zM+Fm6To8C6vrCsmwlfRQk96SqRBn9mcxDEFueiyTvUHm7iFiDbSiiItAHJRmeyoKBObvdXBIfrwNgxCc5aNGUd8SqSOQaooaTkZvxz2mO/clkJiGTfH+kXdskfjlOvINP+U+kUhMGiqIddM4udSvnZYK5AxXJAi8QQpw4GVsbkeEbnVEM8lASze0gKi7bguKBbAOQDXvgoCU9Rnv5fYKumvhLQF+bsfakpDq1u0Igpdcs3ZdJIwcz0ZiZ8ii+sMebE0S9cMsrCMHEdOEKg9XZE0nKEOWO1uOOszReXRUBqmdQQk0gm8uVxEfTuIyjx3wG2jubHvCNSBJPGCGFATZSAi4hDapoC4sL91hI3UaExuvf0qtHa1KAAfAogzOiIrZInbvGdc5GbENq5jiDdob5Y1Htcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(186003)(33656002)(5660300002)(54906003)(6916009)(64756008)(6506007)(7696005)(316002)(41300700001)(8936002)(9686003)(26005)(4326008)(66946007)(52536014)(66446008)(8676002)(76116006)(66556008)(66476007)(122000001)(38100700002)(38070700005)(82960400001)(83380400001)(2906002)(55016003)(86362001)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OkVJZFIQQeQADIQw/qlQrQqaqw1zxZdmE9H6GSxhUVPPRYle/3yRUKs6E2mU?=
 =?us-ascii?Q?0KtjCWIeIWy2hw4wvvmQfyjKAbYOq+RrmiXDQ5OYH9/zU5JXUSY85ju0v9mh?=
 =?us-ascii?Q?FpzcT16e84YwYqSftLSOJBKL+caHvJw3WkZoXkbbCCUtPv47YqKID3YKGJdM?=
 =?us-ascii?Q?COlAmRptDCqN7Y5aZpCCnc2y+SOWOaSEhBU17uUMpnlcJ31JJWUKeUb0a2J/?=
 =?us-ascii?Q?XxfrfPQQSsJsoe1s7wQy/sppezK8TMZH3dVql85GQ/E5AAb3sql5k1jI92cz?=
 =?us-ascii?Q?Iw9XdmjCxDyFMD+NMjhOg4znrROUT1e475esRHys2wEBws8e/LhluT5RoM4E?=
 =?us-ascii?Q?iOpvCXTHIcqMfuXa2R7M/rDoSYdkVXs32RpI1bv9R+5dvO7Ny14ya9fzS/SX?=
 =?us-ascii?Q?rTltNHS7szL2T3JnQwHsmqvu9DTgTmQw5lsfYWFJVU6O4eUlqnjMeLhJENUE?=
 =?us-ascii?Q?/Xwk2UOYIk7i/uD6D+aDzngkLxmyeNXbpdn9TacOB2fTZVNyIs7OeokZSoyy?=
 =?us-ascii?Q?LNoOHjkhN5uip1FjPaE/W47c7L9aVMYipO45wgmBIUT+CKfId+C/o3Ygl28g?=
 =?us-ascii?Q?ihQmdzKELLWJcXQhUOykvT761chNzYc3xXXnoQsjwFaA8xNPDIFWvPIrKn87?=
 =?us-ascii?Q?Lf2ZsQ42qWyc/MvvXuP18iSkSWsLHewotZIDRURoP6c7Si3bz8i6bimmF+pv?=
 =?us-ascii?Q?kl4CYWKxbxevuSvF64gB+DKVIZ7Hp2LgR7EEWnCxPXUDDQjgVB6Niu4QfPt6?=
 =?us-ascii?Q?+CQRtLWldb3b0j1NYJcH4HZyYPUUQQqbbnYG2PH1PzXlPuL/Iei48t4DGQHc?=
 =?us-ascii?Q?XOFq4D+W7kQeQzbRrylLiwqZfBugkfykdPR54IBWjJn1atDIx1sd0g5Z1Y4p?=
 =?us-ascii?Q?ghculBxwMw2vI3GYR/UkOqYjq2GXZ2OdGhmO5sp2xUsaIFMuSTfINUcjw+5Y?=
 =?us-ascii?Q?ENE9Pz5gjQUplW6JVyQh9HQBIB/RZWRUUduK6VVhAgOg4ndqPl81yyv2DeES?=
 =?us-ascii?Q?28dp0CyhSrUQKfiJaCIUXex2+06dc1nvP7KPBXvyP9x2Wgz476EpvGdXTCAU?=
 =?us-ascii?Q?Kvo8Xct++70QrOmF6czvwGnPTBG8mQdEQJZkxHG3OpVaOzCnGCfaL3NjIiz9?=
 =?us-ascii?Q?5R4jnA78Kl6I24t29of2fY3ctRbccL0x4MO8PgtaXpD/0UDVVbVM2M82Sr0L?=
 =?us-ascii?Q?CcuRwW2r/fpDD+WJEfypqyetonYAEKhYE8KxaeFe/tYmWTKB3A4RvBYVD8Fh?=
 =?us-ascii?Q?8Srt9Xlhl8gJUYKhDr6YQGueOAwhsKQs0MnLXDkh43y2CjWHgsn1n107MQL7?=
 =?us-ascii?Q?sZ7tphcbSkBDjzm2vySuNg3gPa+xR7KTJcbW4amPwjWC+iKgOPDPWr4PFkgH?=
 =?us-ascii?Q?JFyd76NCOmNYcH5cy9xlfzmP06k2j2x68gOhXFnLFaPBNpEytVuU6O1jFgZn?=
 =?us-ascii?Q?6Y9YQB83OFUWwN8V72Ph+HGj6YsuMSFU31/18LGnWlXDQs56tTRDGr+wJbqZ?=
 =?us-ascii?Q?PUyEfqqt081M1O9SOnlr8ayuQVynl0liODXGMuPoYeWYdOVd+xteTaOZBD1Y?=
 =?us-ascii?Q?BhCsjRaMON13FjCUrRc8PQPUAnpEU2Ey1Zp4CVYV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071df650-0d0b-4feb-2e72-08dac8cc33d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 18:47:39.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //+DOCbj+en2VypNoF/FyNfUpmHcVkYmfFZ0o8kjjFEXgzjyBMma9CY68GOMHyKvtQrFjGNXb4KRPYC0RADcgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dipen,

To support Intel timed i/o driver, it was suggested by Linux community to e=
nhance hte framework.
However, we see some limitations to support complete Intel timed i/o device=
.

1. The current framework supports Nvidia IP, which has two IP blocks (hw ti=
mestamping engine interfaced with GPIO)
Intel timed i/o is a single IP block handling multiple functionalities like=
:

	a. Input timestamping with event counter.
	b. Timed output  - single shot or periodic pulse train.
	Uses TSC(Timestamp counter) for timestamp or generate events, which could =
be translated to system time.
	c. Implement PPS functionality to export time.

This requires new functionality(interface) to be developed in hte framework=
 specific to timed-io device.

2. The current hte framework has a provider and consumer concept.
Consumer is responsible for user space interaction.
Currently Nvidia is using GPIO for input timestamping  (by adding hw timest=
amps in gpiolib-cdev.c)

For Intel timed i/o functionalities, current gpio user interfaces cannot su=
pport event counter
or output modes.
Rather than jigging hte consumer into other subsystems to support timed i/o=
 device.=20
Any possibility of developing a native consumer in hte subsystem, which cou=
ld handle user space interactions for timestamping engines.

I cannot think of an existing subsystem that handles Intel timed i/o functi=
onalities 1a, 1b and 1c (mentioned above).

Regards,
Pandith




