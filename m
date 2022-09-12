Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475E25B5AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiILNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiILNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:06:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B02715F;
        Mon, 12 Sep 2022 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662987967; x=1694523967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hj8C6bLMSEplmBe1I9ZKnZ913MaX54Y44fRUU4BayQs=;
  b=hmdRNtlU2LjmV9y9VUFmtK+cupuO5A3JsIz1E09Ze0nR7wj0t73kVpQB
   g9KJgFoPvcwIMtnbdXoF1tLxDbGzlzKcLD5H8XPTXBo42T/sMoJz1Imgp
   YminGVqWWwSMOpaPtM8fjMy4oSUP+KXIunQrTjrns3ERZFPX8sKAhDr0y
   5Xsxs7MuPpSgV56fSCGoOB+zgYoPYgEq2JtHs2Ov4fqcNIfUuSlAq8ZLN
   DhDwSORgBH2Vvka9IqFQW8h7/nogjqYMsKjIm+R008cpZE7QjDu7QehW0
   ys4R9gjHiZA5k1Yzf4ZWxA4LDDUk//Uz2NMe+G5buzRW+z27bzwmCKJZK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="295444202"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="295444202"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 06:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="741770100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2022 06:05:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 06:05:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 06:05:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 06:05:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 06:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA0ZnXZWGZXUEJj9h4NMS22F+sDjlhi+fgJRDnoBZRkJG4aXo14eUp9aIV+4+Wg1XDFwWo06wMd8J3CFbZQHqKSXjwvmu6n8/D4oE4Sqh2K5aFGmW36P1hDFA26U+J4C3R8lhLMJE6RsC5WOOxCpeV3+ZgWiLT4lf1W4rCHoCST/LITBMUGanF7ZXhUP1bweLB9vDygb/XJqLv9N6jjQZbodAZjUKURtKuZSc/IBhG4yoNLrsxuxpstluvc4ZPyzeasqJLaswRWHihJ9m3AAz51+NBOBXPQTpQBQPu0+hSvyag7APOgTTn9gUoqO8wvqLSMK+gJlnKXGzfmGlkba5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4OrGSmPDUQIG/pnVLhY7ocIDxvzvLLiZNjcBZ5B29g=;
 b=gYMGoattw8A7vmmo/0P2QRkLsKgps83zsao2fgmz6kO2RrFkbR9nVkMbJ16p0KwB+N/PDm2mn60eFIqcFrVpS0Jujw8TdVNNNdwYDNdvOCq2stvAxCqnFLbjCBr4j8T0yGc7eFOY2uSL3E3VqQEcCE0Cq7Bvr/N/3Xcq+GO9hLKnhj+aejXT25/1vA51uit6KBSQkKV+am42IkceTmcMOyxr77BKvkSYvfjSEch/hDj+iEbKRvRzY1m5L6a6i4Sj6OXFhFOHJQxvW8DMFH9u1peh8Rb6btF8UOUcr1msfvXkWQkLiKCo+kosDIkACgg4ZhXRHHbMlUxIDOs29tKqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by SN7PR11MB6558.namprd11.prod.outlook.com (2603:10b6:806:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 13:05:37 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::371a:ed4f:12f3:f478]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::371a:ed4f:12f3:f478%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:05:37 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the mm-stable tree
Thread-Topic: linux-next: Fixes tag needs some work in the mm-stable tree
Thread-Index: AQHYxmrxfs2IchUXdkqrupMsZa47oa3bwvxw
Date:   Mon, 12 Sep 2022 13:05:37 +0000
Message-ID: <BYAPR11MB3495D19731BFDC439E2C1954F7449@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220912154547.312165c5@canb.auug.org.au>
In-Reply-To: <20220912154547.312165c5@canb.auug.org.au>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_|SN7PR11MB6558:EE_
x-ms-office365-filtering-correlation-id: ecda1ed5-e275-4f0f-0c3b-08da94bf7c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/7L4VHAh5t+k1G/S636ij86oIaH1SS8iuxN3QvZCkDQnxsDRhk1TxkL662PHqDCpirgQ336Y56gL2qsqEzYeLyLfkElA36Qqqnki/JgIPBALO3gbdytfibXtIq4LK775QQ+OxnDJ3RdUyhmt5PRt+wW8vaXEWCKi/YIy1d5FNq/vH7niiztumtDSf+9e+5tpaDThGYcs24l/acbhVDO+y01xxJdtMmQLqCckF/lvjKzX0QYrgJS9NEenCpFuv69DaY507NKEprm1C/RhBoPBm8FvXXn1AzgmuSB3f+7EZ9FzuOkLtLWicotVTrD4huk0+R8ZpcG+Rmo9uprbWrK5wT6OOkFCaHkMFsxyG3pntbHsizAFsd30/CqhEED8RumrsTYyBf4LVbz9h+vln39lKAbAxPowl+3E6ahfA946DXIfpD31+mEOtQF9HrT2M32P+kCWvbjQvvwE+h5IvglVU7j1LVDEcP7UYIz5Q23WlouNGnEUiJ0PnNjeFMWfSpjMqpY0vTaIuo9/OH4KLG8XkHCHsFbmsmcHL/BNH8maGekIUCM0Qym+7PAmaFhuA5dNBrrPr/UQWQi+GTYITX+1Wj7o4wPfZqcpay5qkUSL3aD1Buxx0VwkxwXfrTtINZd6OchUvDzh03aiouGi0XNsxwlDHbGA46BFNjtc6H/kO4kwYwhguvgKdGapX7LIcDY3VvKNTfl/wxfgqyjopTRV73sA9BUBY3ESViLxVaQr8tzh5rfdSSr11hjU7PLPAfVE2v/2PNm2dJLEVGatuIYaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(478600001)(66446008)(54906003)(41300700001)(71200400001)(64756008)(316002)(110136005)(186003)(66556008)(66476007)(2906002)(82960400001)(86362001)(66946007)(38070700005)(33656002)(55016003)(8676002)(26005)(53546011)(83380400001)(7696005)(9686003)(6506007)(38100700002)(122000001)(8936002)(52536014)(5660300002)(76116006)(4326008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KG0qzSD50FfAmNNZ9NrAtf8yy1np+gQUTWRC+nNM5xEvFwdCdcud1wqB0tdZ?=
 =?us-ascii?Q?EjKQyF4L5UVhRIsLLoXcAiJ3PHwZDtwOOUIwttwtaYt0U/gcihEP2VucVQT+?=
 =?us-ascii?Q?AErHeLRmdJk/xoqjlRzSoh4SpRkhAVNKW+z0xvUSE92dsWYHmKdoJCy6qvhM?=
 =?us-ascii?Q?Jitul7kvkM8ozEpTshXhj26ZElzS5QM63Yl9zaBlkRY1BcxYsvAeIXHLFu6O?=
 =?us-ascii?Q?NGqkPsQlVsypmz+b+Yf+rsobNLj110D8V0kJkLo2BVAmY8CVT4yhjHTX/r0U?=
 =?us-ascii?Q?o7m1h2fmzlU7Js+jyWohUR/PlSBuuHqqrDDHBSPCvyiCzmW0/IzLbgxcZakN?=
 =?us-ascii?Q?sBEAp99LBCxQ1uMLNEx9crCkd2IoPWyHoC2VsYCeGJcQuq5hJeUQxZaipmDd?=
 =?us-ascii?Q?932usDW/RZKkDztb36YPZF8SM7ftOctoXgl6M8MYCtuygi8ZdkfwBTcq8itU?=
 =?us-ascii?Q?GTXEuHdXfN2R3duHrucMW5fVB2/GILirwS/SeBBcBXxqgQi5PryjOrDoTTFN?=
 =?us-ascii?Q?OK2gEZg0MxE8WYTgrQs2ALJPQOYVx9cn/LvoTFI9Ysfq+JGWubri3CxvVSjT?=
 =?us-ascii?Q?/bURDpw71MtWjKAm6LZHPVLXyWyKP3xSGe9nbtkcCN124r9qwwflKnkcdFPt?=
 =?us-ascii?Q?tBGgSIiRJic9UCcw0Knh83mPMgeY+Kh4nU5OKyIp6Htd9qa+rGAgwdWGMMSu?=
 =?us-ascii?Q?VkG9reBWe+kai4DTfsqDVgp/cmJap/+tqvkvDGD+03fK+FOykvKDVGoMZ07g?=
 =?us-ascii?Q?OkU9XJsCZGc5zmRFjaldaxDm0zoipI1CRNdChhp3hlbhP7TM+ElMOaczLSTW?=
 =?us-ascii?Q?nCwMMxTqtcHAzgiP0/f5LJ0Luz6oMpufGyPq7hsUoqPRL9NICpj0/ZSFJSig?=
 =?us-ascii?Q?9xtgKapBntU2Ma06RBxPqPWfvjIrKa+lNvDDMDXH9S6AwSZcE7TZt5vOuDl9?=
 =?us-ascii?Q?vURU8Rd81liB+umRatPm42aVn3lPI0D0UbeR5G16D+seymo0OjKHCH/MFKrZ?=
 =?us-ascii?Q?itPx17fPG4d7WEbvbPEoqOKN9VsN7l1stKk+7m5mubZWKFAARwDQ5sSZYLd4?=
 =?us-ascii?Q?hkzXCERKhBt296Q2EdVGFDHtDJazo3kweanB9s/DJ3Nlrst0OfT2+LnyRyyX?=
 =?us-ascii?Q?FY+MQsuYuo/gLxs12s9vrpYSGnavKiCRzZjneUhnqlkL6ZZ/eY/ehqCWiLRB?=
 =?us-ascii?Q?MqYSW9aVkbeXh3gwtxsLDcnxe4bCoiIc+eczPw4DK8+2+t2wXA0rYE/QTaS9?=
 =?us-ascii?Q?7Rzg2jgNUQTG7krPOYHAqGjzSkKTOie12wcVzk3xa6U031yaDcTmOHdSvzCY?=
 =?us-ascii?Q?o6K7/K+r+kRrT5hmjOeU2J5uXQkKatJpCfcTny6ReTfS+kX4j9h8V6O0RlJN?=
 =?us-ascii?Q?hF0QUJHQ0+VUmQu6szpe3neuR9aHNyAU/8watX8zXTu0t8PE2l8pyAJL92PL?=
 =?us-ascii?Q?HgJSSgnN/hkGUL9dxwC7HEY5AyzkBlw+pb5so+jKrnJZysjKYjIkVbpqU6xs?=
 =?us-ascii?Q?t/BdaLFy1Z7s2xNYz5N8GCTR7NrhD9rgpsVV6Td3WFv6/+1hzav6AAztngnu?=
 =?us-ascii?Q?CJceGJgD868K1UxxuXMahKpl6paCEBSh/2TtuniL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecda1ed5-e275-4f0f-0c3b-08da94bf7c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 13:05:37.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z2ueV6/xWmPufqq0Fg1VeqHyaqDuca2mfooyF3lzJxYr0Hhw+4t1CaYEAOp5Z6Fte8ZqxEIWaqwA23SKspPfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Monday, September 12, 2022 13:46
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang, Haiyue <haiyue.wang@intel.com>; Linux Kernel Mailing List <linu=
x-kernel@vger.kernel.org>;
> Linux Next Mailing List <linux-next@vger.kernel.org>
> Subject: linux-next: Fixes tag needs some work in the mm-stable tree
>=20
> Hi all,
>=20
> In commit
>=20
>   831568214883 ("mm: migration: fix the FOLL_GET failure on following hug=
e page")
>=20
> Fixes tag
>=20
>   Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array r=
acing with memory offline")
>=20

My fault.

It should be "mm/migration", NOT "mm: migration "

Fixes: 4cd614841c06 ("mm/migration: fix possible do_pages_stat_array racing=
 with memory offline")

Should I send new patch ?

> has these problem(s):
>=20
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format=3D'Fixes: %h ("%s")'
>=20
> --
> Cheers,
> Stephen Rothwell
