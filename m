Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A9680E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjA3M4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjA3M4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:56:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E29763
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675083370; x=1706619370;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=t5loCL9HebcGt8PNdk7kOkclJpjZJOHpDWVmFBmg638=;
  b=Z/IkaCdGP23Nr3rHfm6vW9y1f0zWdoTAqmcNrwWv33CmTNrLt9iQrVwa
   mt1hShkudnXrPqcodMZbU7iS+c/bEVeOWSvnBzWqhzspXTChKjNCBWxmD
   AD+1mLy+8RJRvafxqRXFjQgUqDDE3H7ru7N84HfEtDqkYAzfsyxFywSjk
   JQJ01YWtfo5nJcfkANUqe/w0v3F+QYdLsAJ1KFs20azwN2YyRYSt0QqGn
   H5oqljp50lqhL2t6nxjNCtLUrT8waTiy+3202rb6/4r7q5PFK92Y8Y/iN
   bltq1+PILsXLEBUJsZ45IdvD5ermhpiakiZ1/ZQ16ZFgdetTgF+PGv8Dn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="325246450"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="325246450"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:56:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="788018744"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="788018744"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2023 04:56:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 04:56:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 04:56:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 04:56:08 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 04:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7a1mkjfq+NeEx12o+A7MpHuFXpay9jOFlyId/4zwPC+KWv0qNuqGAkcRXmuNTB2iwt19Bqgp+W0HIePFYxbzTyC1VkzvUeeKD+o9WDewmcHyGdirfQT6WDkzzypqvTNEkt7CzYqFChUImGmZlophBJ1/v33aeJrnznmbIVu/Jl0uTeB9koh26hJBdLSjqL3DsvL1uDBj0MHLiFn3uiykf9U8PoG5X7Vi3LzihceDBW/ESpnsz+kbwwj/ipWAohswIrWkOHjzSekXEmyzMEpYcDUpvSXUOItSSsswL4wyH2Ja/eF2eMhZfWGhnAgv071tLcTbz07DBHWQ0DmwrYhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkk2p0nrg5I1FPbFOr1jV6vkmI3Xh6nrUvF8H0F3/Ms=;
 b=aLa5W7rISseDxrHLe2MdxfCDSL4BTI67Fl5EJLK6J7kb4ZoQkbNIDK/G81zBaHcXIpUuiOCaeIja7dpeoNq2O29ZP9YzWaI73m5PpsFeOW6cMfwX9qt/U96hJ9+hnEnuokphy8qx19mCpPwhR6sPQ3NdFEHIraR7TUwQnynQ/k+gFxs72mffulFeLZwpefc2LMBX5aaLo9hpQwZp4j4QZ7D2RrT8cl7+kxjPY8OSH/Dk07q3bnC9lq6KarKPC2pQC8ris7nz90vjmP8X9G0Wwf10htjHuvfDZn/ES1CvobTjGFHv7xvbAE3E8MGFnn8/prYUWeQBwI5oFmJk8f8Z6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:55:46 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59%7]) with mapi id 15.20.6043.021; Mon, 30 Jan 2023
 12:55:46 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     "giometti@enneenne.com" <giometti@enneenne.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>
Subject: PPS functionality for Intel Timed I/O
Thread-Topic: PPS functionality for Intel Timed I/O
Thread-Index: Adk0qfZfZVvAvtJ8SP+qSzpYuQsN4w==
Date:   Mon, 30 Jan 2023 12:55:46 +0000
Message-ID: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|BL3PR11MB6363:EE_
x-ms-office365-filtering-correlation-id: bee9de6a-0012-49c1-f053-08db02c14de2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmJJ/9G6hN8vglf3vDDUr83ZGLx3BW6XjpNAZUQNVpWodGejWHM3bNEJFOhKd27wAij8XeF7OO/1UlLpMqwuSrmTme0yxEuvD43a3X59JVhxZzLukYnA6rt6GPBW5sIWM8I6o+kZkM1OHS/DWA6/j6B47G1/G9saDKMOrRJyoLxX/fhQkrksiT2qS0TQ/ia1FLYd6WCIqomNxTLcV5aqjO6vnHnrTrPl+0+dXBQykkA7mNJzrd9jOaKsGFOpI9rbb3F55hkkE54VKtX14DUZ0kqLPQeYkXTrIKOg5B6ea0Aoy4hjrr2vOAeEE2mNaLxD1koGpJq+6K+9tE8jH2/D9dGvNBid3UEC7KHR+HfRr5nzEcqjxVGgeoajOddtJgWSYfqg0ypUh7JTOszPuj5lIi5fqalTSSQuX2hUXPBTSYMl38xa/zjyaVJ5OL4/TJNwrjOoI5fv0gmmaG9yg+NfPZaJ3U81u3hIoc8UsklWo6sn3K4lJGj0uaF8XeaVcw6aKmvZ9byONf08Vbmb0CGixpXr+l0QtMvTH8U0xpv84y9WWsPaK0qna2U20z5GjsRKADN/oPpDKW9BKcddduE09yLSbfRuhoSkHkFDB3KO0ZKoCwYf9ysv90o2TtxIHuNpaQYocTqOhLaHq2C8CKDhlbgG/8deqo/v10+YgbgZJwEolmy+PJCCF9HMi6aAwgLEiHUiZwxBhup85uJEyAWUaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(66446008)(66556008)(66476007)(64756008)(66946007)(38100700002)(82960400001)(8676002)(6916009)(4326008)(76116006)(122000001)(83380400001)(38070700005)(41300700001)(52536014)(8936002)(86362001)(316002)(5660300002)(54906003)(26005)(9686003)(186003)(107886003)(71200400001)(478600001)(2906002)(7696005)(4744005)(6506007)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mCH/0TXLv6oH9Hg3kpqbEfl0nIVja801OqMeNXdljDaQnN/CCLAUL8Fs8XnV?=
 =?us-ascii?Q?HlwN5ynPS1jCPoKAIBgUumnGpDo8HhtRzjQ7+jvK3XkcXAwHQF2Xh/JGA3aN?=
 =?us-ascii?Q?NWCHyAlDDKA7xsgisVHiaiJ6veB7oispBt35fpYdMixF8JRYNUvcPAW3KvHL?=
 =?us-ascii?Q?He7VfvQ701T5NaxmlfSyzAq3R/WH/UYW4/V6iJMdCkF1HBPba3sUJI/747vS?=
 =?us-ascii?Q?0zZWt3jARTpC8CjmKn1Wkg3Vomd/Uu0FZKvit5WFa0CtssKqL6nCro4A0y5K?=
 =?us-ascii?Q?GTjQrNaUH2+1kwrsKFuQ84YUA08GW7dPT8vkRpyOlKbo+uTe/OnULj171uQR?=
 =?us-ascii?Q?hyLskYCtVmthjQ3Uq/BkjSLHiunRJO3svyA48pOyCDtExP6x2NpsdZ4KBhG+?=
 =?us-ascii?Q?WEZTKQpGB5VphzTMftX2Jy6/Y80eF7CYKpSirvrkoypqOHAOtv0EdCCvKhtv?=
 =?us-ascii?Q?GKF9bHgu0lMGhiru/8Dd9qI7K0/d/aC7XUHYjIs6gNTw0qhPle677489rSfx?=
 =?us-ascii?Q?VlDzdbrg2U61yXi/D9VZZadlFhLPvEAQZxlnbmPQnp6KFfYA1OgjhNhjVIBS?=
 =?us-ascii?Q?Ovx2/ofakeFRKpTVqRQg5kZtQgxEfSENg5ywrMA44CMSpnp7nD34MyQP7wtw?=
 =?us-ascii?Q?xxDjKa00WxBkNJ/OQhpbP941bvFr6e2icefQnkQB0/B23a3+VoReOLYkjk5V?=
 =?us-ascii?Q?vfNRowTEcE5DGQ1C1oqZ9DWPDHTd/v9Dbou5717x03s5PaonTbVKw2PU0QS0?=
 =?us-ascii?Q?tjKbbbUNeUnxIphFu3RuuqaUXNQ5EqaMKWaqSsyOYOwYc2+fLry1oXpo66at?=
 =?us-ascii?Q?lihgxjIl67qxB5t5fLyvy3lgqF8lsS6XLsjan39xud179l6b8QRgKqRA5Fui?=
 =?us-ascii?Q?D+4ACrlY2LCOgsBaPoRdDbFo7FkFxS21OmYPdnDEqt/7YNml6ny/Hi0E6cRO?=
 =?us-ascii?Q?oEoPf6+tnXZrUx5NVdLy75BtDHf3GGUa7/zIyYKuj4F1r86eHyscOmzfQQtw?=
 =?us-ascii?Q?8FX7CwlgK3DiwLG31esZsVlmnGG528RCJrib2oAiQouH/ATeYtJcn9n80Y8+?=
 =?us-ascii?Q?x2NZB1R+bQfUaoC/yzwCAx5X9m1njNagK0zLxVC2AstxVOtX0MutBByCW63v?=
 =?us-ascii?Q?5KhofGKafy5ThK4ziCQfJpCls8LqszDtq55uJeahaCIscgQUzfsAQZTNwgF6?=
 =?us-ascii?Q?qJhwUnWnnuZiUeFtKJUbnnjF0q1meZBRrmfpoCisC/ns1n+k6f9DTuVHrMOk?=
 =?us-ascii?Q?6TV+mhKaSRrpCmw3QRwh+PihLz90PClRcCkvxbP7KAcKLy2YU6OfhKbEJTU4?=
 =?us-ascii?Q?HzfVTOlfwfSNOpp2uGtALjndZQeJbLutXuUXetDeJ77Ng7sQTkZgDOP3SlaJ?=
 =?us-ascii?Q?iwh8Z/jOhtY/0OdSG1Eqf8rF37qssF0vLnw0GqwKH0yO27CbQGA7mPeg3Ksk?=
 =?us-ascii?Q?vAB9orRONcaULDQLHeshg6OMVaC0Z0O+x2xYCEhzBg1D3BOx2gKlDMgY5jw1?=
 =?us-ascii?Q?BrrOCghKvhDFQs6gCWDv3Vclb1VvGrKrLXn3wsKZmtJ7azlwll5GiuQjsvlG?=
 =?us-ascii?Q?iSmhWJiqQ4ZKU4d8vKGb8Nn4iD+9EMMIKss4HRVy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee9de6a-0012-49c1-f053-08db02c14de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 12:55:46.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q32SgttKVIJUf+vQ5iBNsniXCZuZISemk4+xMSbwc9stQRptHRebJ5pkl+w982YuA/yC7Vc+0HN53RpxDn54fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodolfo Giometti,

This is regarding Intel Timed I/O device as PPS.

Intel Timed I/O is a precise device (10s of nanoseconds), that can send out=
 pulses.
This is needed in IoT and server applications to measure offset between sys=
tem clocks on multiple devices

We are planning to implement a driver, for PPS output functionality using T=
imed I/O device.

	1. Is there any support from PPS framework to start/stop pulse generation.
	If yes, can we get the Pin number, offset(start time) from user space ?

	2. Further, this device has the capability to capture the input events (pu=
lses, nanosecond precision).
	The same PIN can work in either input or output mode.
	Can there be an PPS client driver supporting both modes ?

Regards,
Pandith
