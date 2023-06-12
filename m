Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802B772BB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjFLIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjFLIwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:52:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4F183;
        Mon, 12 Jun 2023 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686559924; x=1718095924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sv8jPudsYYuoyUnFeDU1qpcbJT0NJCPylpgsN7IGqK4=;
  b=C6TixzzPA5fQ3qkvMpsPrJ04LfDNZteltNTlfDAXJDqPyJ/IdfLtNND5
   2oIiFdMPGmBKtg2K3N25YumInAKHkB8jsJRGHl81FogvxpUIDcn/DpigC
   Gq6HpCdcZdV+N1XJZyr8Z9O9yLBqbu49IKGvEOKioBoB9y8GgJvXaKr4d
   tWsvzHzWiZEfMSqogxPZgT0IGk8NNy+5rVr/MKvBnq8hcD7zTXT3nw5qZ
   MHUsXOLXjaYojpqdynbcS3f+eRs2ZF56tZdqF9ZBNj75M8HlKikeL5gQw
   LZ0AC9wG7/Nondv7eTiIz5cWSUQdoP4+26R02zQ7COWRs+ZKl8o8kH5jC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347616690"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347616690"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 00:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835371658"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835371658"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2023 00:16:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 00:16:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 00:16:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 00:16:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 00:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQlYfroRAGJELq9G0njbArL+B5gbqrvWFJTTp7ZzRzchdWk7gQ7QuZSQQzIQquY4q7uVX37R4ieICfV77sOxJX5DJXZTMOdiQb1uVfDaCMdMA4f+bGJ0QlSNciG9VD7jiktKpHN7lMlht3WWuYiKQoD/u9GG9mtvo/82XD2hyZbM4okDQmVkKSvVqjcW8UK4eh2FHCQBIbpfQyfwFyDidhXE2Vdymyb7ucM16vl0atnhA9d7K83oB+gSlmL0N9Mte445VVPnaJcHU+45L37B2me1AsXZPoaCIPHITSBWBBVHj+hWMC23eQfrCklX5+UD1jUTG3bNNXk0qlRF7pGDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv8jPudsYYuoyUnFeDU1qpcbJT0NJCPylpgsN7IGqK4=;
 b=UFBuztpAulGadY84oHHBxma0z3AnrtpkCGzegOhn8J+BnuEQKsxIUUUXUkA32mTaTrJomhE4AY4GwcS9xLDXV4pjiFlxZgjuHsAsu/UL15mL/QF3XHwF47ciGXjbqFkyuwtQJX0G1zroNqbVU1P6OkxnXWOxcNnMZwISKO6EhjWQVskVyZKhN4x4ufJ0N/7dp/EFwsTeiAozd/NhU2+mpCnShGRYk+PeDpirdmwGC3c8TuYs4bOJZNlyGDGXknYSOozIYyVL68sZAjHPgRDa4bdTDevBph54xwCcST0NGNikGf5T70shA/cqco0KzasDo/hHrAnjjiG1FOWM225bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Mon, 12 Jun 2023 07:15:59 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:15:59 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v2 1/4] pinctrl: intel: refine set_mux hook
Thread-Topic: [PATCH v2 1/4] pinctrl: intel: refine set_mux hook
Thread-Index: AQHZmqwQk81x1AfkEUm0gPLuEgZK3K+CrSKAgAQYSqA=
Date:   Mon, 12 Jun 2023 07:15:59 +0000
Message-ID: <DM6PR11MB2779679A4AF6023180B942248C54A@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
 <20230609082539.24311-2-raag.jadav@intel.com>
 <ZINWOWLjyZk2Gj3j@smile.fi.intel.com>
In-Reply-To: <ZINWOWLjyZk2Gj3j@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: 0af09e44-34ae-46fd-1b75-08db6b14df82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTJp9rLQkjh2smXtrUhq97TxTRWGgbYm6eRRFX2t6qG6Af7foAgYojQMsPCJJm70P/ao8VhIXTQE//zN+bk75w9e29rAUcSgIBnszdSafmSXISWy5RpHk2GsTBzNnv1u2kMmlO/Mq6abwZ9uLAWruASsFtbzriV40rznxW9wPAhqzja8K6sBGcDzXdao2m0IAkDXT5LWiVQo+bjutzus63WC2WeMbznUGGl/VBrCygOr/pNODnu3fmE/8yAK4hKkL/p8g5DahT1XkT5RbPt2I0vPwbtDYzUIGTZ3Kk387jQoH5PUHIVrJbeHzVKKvw7nr18B17mJm+Esgbli5XAvwbcKhbtkqFk41dHf0LXC62otb2vC0R9v99Sj11sLMy3a4PnsvitYIZi3vZK9Fz70JFICEXmlWtbD8TrAlo6YwgFJqFn93lChqGsU3lymhrEBaE7KcOuYZLX9GNxUT0RkQ/4m4NrdpyJHPvZgyltOo47899Rblp1mOC+DehOpdNA/ARmYvtS8chmIFfjESy7SCG0XVEOU14YpmaAbDaCdm9NNWdaIKJRNLT5KRoZgXWpIXVNJXco3d4rb/KxcRVb5bSCVteS6kLNrDr019AnXe8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(41300700001)(71200400001)(8676002)(8936002)(5660300002)(52536014)(54906003)(64756008)(4326008)(66476007)(66556008)(66446008)(66946007)(76116006)(6916009)(316002)(4744005)(86362001)(2906002)(55016003)(38100700002)(7696005)(478600001)(6506007)(26005)(9686003)(33656002)(186003)(83380400001)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tOsf7QEaCqn4IzZ8mKV4uH7HDm7ufFZkIjaqvOL/aogsxzaIyy/GsOrMFhXN?=
 =?us-ascii?Q?ylXKwzb/VuBxlog0PjEBZHjjFgI4gvhY8S7b3ysAX60j+O/8j20ijKYb5hU/?=
 =?us-ascii?Q?OuK7j5nwd6m4cJoHC8UquqVljH9J2XWx4OuQAiKHDQcJKXHynYcPeQEZ1SlR?=
 =?us-ascii?Q?9CzXeV3vNceL+P+V2/5UjUt0wezhmGWv6BrZpQ8ELKaWZqKnZGeRFkfSiu/t?=
 =?us-ascii?Q?4O+7Ubw/1kqF8+jDUkgtxD8qENg3a5K0q9bPPTA7tM3BxGustIlKHeZ4pG3W?=
 =?us-ascii?Q?0x96IDJuG2PX6IW7rz7Q3lTP/HH5urJr2WiK+/lGjI1cVRlx171jk8Y7KShm?=
 =?us-ascii?Q?kP5wv6p50jxmDhRG5Lp2tTNRAWcWRq55QnmpjbVCVoiOyCuL8ag6CtAeiAAA?=
 =?us-ascii?Q?r0J+XZtbKTlfE1YrW2FRC+a00urWWYNvxMmn0Xyawbr+hXIfpm0um8BJeYzS?=
 =?us-ascii?Q?8ikRc3BcRI4uhsO511F0iyCHROfgxp2kQKsL3/TIF59Id8vijoP0vQC4fWg/?=
 =?us-ascii?Q?yVuH1DgiXWYnHLk2smKrvgSvO3I6NvO5mOEBNOWorIc1E9VUHqiorgHlN8qB?=
 =?us-ascii?Q?b9DvtLW397OT1KepNkg85W0a4FKpN8CGZdmWvHnD6u2PCoBeY5XCVEsTRdBp?=
 =?us-ascii?Q?jOoETFdsl4lwlN/H8aCo3pGFFkJEAeGuWR/FIZ0iOzYtZ2T+1g1bHB9ldhFt?=
 =?us-ascii?Q?KV3sNLt9MyETancCXy2cJOq1zl06h0htFzwAAwou7DAO3m0OH7YCbxMQtMcK?=
 =?us-ascii?Q?/XCvc4fcZksbWurdz0Tb3QXdD41ign0G/VDzxf2ffNTInzKok1IygrtUkZUP?=
 =?us-ascii?Q?MqnWFbLSybIMOXhVhJ8M1wrGCSZ622lh7Cy/jjOL9lmwyKS1YCHwZx97JrQ9?=
 =?us-ascii?Q?lylHNItTnY66IlXE4cMqJiD4akO1+F/Dl2Sm/2KaNaW/yam7j8o9ldMaJ35G?=
 =?us-ascii?Q?JcOW6CX/hMYT7OKcZU6ZEwp6HgPKta/xI7y7bPC9dvuC+gkSciuOFXnEtwt3?=
 =?us-ascii?Q?0wiVeyHzoQRPOfoEn8TXUAhjaaYHsoBRgx9c2cmrLmQ3DArWY1JwI5nLx1+U?=
 =?us-ascii?Q?RvJqi0yz51P/fECEYtKshRLm95xEoHw18w54GsNgHgAb4RtIbgj/LxR9yVLt?=
 =?us-ascii?Q?4PbFN4IbEuMnIDFod3hiZpPqawEtAkMFMKn8ySip/JD3qDreaqPiITa4CpdA?=
 =?us-ascii?Q?0gwoQG53X1tfg4T+ucwinwCahmRtG+01EpVHFCEZ9hzsKd2oIVGc6DlQu1Ew?=
 =?us-ascii?Q?LRswyNyxu/2OKH/uhdqmSugR7q5yJe0bZGJXG5YC0rZc7jVKnrt1oPqNfkDD?=
 =?us-ascii?Q?UL86DG8hJK1NWIMZc9B5KyaMBCYMH2OwyLhpu3Hd/xs+/WmG2poR7GVKUau2?=
 =?us-ascii?Q?Ec3wgLZDMb8COaPjcnxd0meRjo044iMXo8NVuvl9SCkZhA/wcu0Nsvp3WEnf?=
 =?us-ascii?Q?JhhMNt67GbP9UJZLbd3eHi4kt++l3GaZDonXZ72OgAoXERdB32oDcSaM+ei7?=
 =?us-ascii?Q?qfHRSNBh97NyS/i5AWL8JiRQpqRlvnJeE7qA/dRPHj7jkWAA9TFzszyNJc1u?=
 =?us-ascii?Q?nlzrEnkqt0GOOk+ryJc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af09e44-34ae-46fd-1b75-08db6b14df82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 07:15:59.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scdwKs/FlR+39F/97Y0fhNA+h9INJlupbmxLGzaZDSQCA9UpeB6uEaDhjQ7SoGq5jshetN9HLOKfHNy6iZE+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 09, 2023 at 01:55:36PM +0530, Raag Jadav wrote:
> > Utilize a temporary variable for common shift operation inside
> > ->set_mux() hook and improve readability.
>=20
> Seems the bloat-o-meter statistics is missing here.

I changed the commit message as pointed out by Mika in v1.
Do I change it back?

