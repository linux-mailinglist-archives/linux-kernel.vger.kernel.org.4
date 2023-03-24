Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7506C8480
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjCXSHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXSHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:07:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895D1F5F1;
        Fri, 24 Mar 2023 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679681163; x=1711217163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xlh62Ws0DMgNTXYULvoxSxg2RIT4t6PaZXhSEl6kRNU=;
  b=ifCPkEhOMcvqcKLLthSGVHFWe+pypTcpoVxY8JuO5xtsOfNA6doq27Zb
   CsORXyS75aZzay0Tzbna61TLdRiVI5GWWz6JCxKYM7THJdbe/yc/5ECwL
   qi5ZaFmqu4lP9fZJIVVzw/IYYFr2DWKnaeVytpPFAbeNHZ4Yyu0c0PviR
   qQB0+Q3rmBV9Fr/cgxBfN3TPH/D5MNVU+bhWnIHqULA2iQBhmYApaC/db
   ItptdYFrvnBEroP43V0ni//g+wu3Kd+qpw2ILZAQXLZGi6hEfwRAhEG5Y
   4IRS9osQx/OQDAMlgMlodzToWwh/bscrR6h1zALjkA33IyvEJWMEI7fP5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341417568"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="341417568"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 11:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="660137636"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="660137636"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2023 11:05:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 11:05:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 11:05:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 11:05:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 11:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9Pk1dbPzVvUEys85Yn7rezyj5foAvxtOJPNC1K9Y1RRklWlZx+a2ejpGMFOXrkFJLRhCVrLv6zr5UsjZIR/bmbEoz/BhMaYL0fBUffoe/x04q2HItNcW4Z0u6zesg09Bz47DXLlPZorHoS9y1hK23XKuC1lT2QfcCPf3ED77+kHToErVoq/OZ8VkG5tue92lLI1oqr1d0CpoTH7s/WjKUGMMEuNY/9hf3RDzQMKJh0Z5HT4QKZ8ruBj3BRO5dAOgEZDkCRwkTQ/spS5C9j0iwdvt44SqhKRd6y6+88+hEOBl7ExTWMhN39mptZ7O85u9q/pLIdcZswVP9OOB2RrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB6T8fg0uqlnOmamvLtxOE1gkXARzFHZpGUDPO9xaMM=;
 b=nGzBtyR+0JQhPTw0bAl+tu12GmRy2FfT+0hoLY6kX585Dt0vhqfQqtL1fbXdFoc0CmwZgC4/NhqkYv+NVcH0rp/OhU40g33+7lDyxYOl1yDYuZB2sBj96zkvZxR8qT4JOxVy26EDzoWyp18i/B/phLbYL6cJCOS5mFc+RD9iXAIfUdBreUZ5n/mmnkghaKHqPJVdRRUiqDEgnIog3hGVhnnZkNKs3sCdbUa/+p1W2KFz6XAs0oDM7Hn7wy4JNPjt9uRjOCXhJt0YsEkUnmxulZIMS9V0gt7CskmhRvtk6TU+c1A/LJOYDUtQl46NDIU08KjoYR3GHv6K0cGHgCNcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4107.namprd11.prod.outlook.com (2603:10b6:5:198::24)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 18:05:51 +0000
Received: from DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::2e80:5035:d458:bace]) by DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::2e80:5035:d458:bace%4]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 18:05:50 +0000
From:   "Chen, Tim C" <tim.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "shenyang39@huawei.com" <shenyang39@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>
Subject: RE: [PATCH] perf stat: Support per-cluster aggregation
Thread-Topic: [PATCH] perf stat: Support per-cluster aggregation
Thread-Index: AQHZVYo31QoKPHK0wkSS3lkNmYeNka8KPe7Q
Date:   Fri, 24 Mar 2023 18:05:50 +0000
Message-ID: <DM6PR11MB4107255E167D98A000DC49FBDC849@DM6PR11MB4107.namprd11.prod.outlook.com>
References: <20230313085911.61359-1-yangyicong@huawei.com>
In-Reply-To: <20230313085911.61359-1-yangyicong@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4107:EE_|DS0PR11MB7213:EE_
x-ms-office365-filtering-correlation-id: 83f806b1-ac80-49cc-39e8-08db2c926700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+0aGZ2j6+cWxT+Lz5Zg0V4fyUx/+az2HBzgzJN0OXH9Ok2Z/kFHSnM75yrkOsryZ1Q6FgLauA5GE1oeqzuTKEPe6eNqFD/fCcQvq/qmuWXfaREIIMz8aWS+Br7k62ZBXzLNuTaXloSTwTqBFiOGl0zq/Ok37skecYhjvgUycfOjw2hjgGhULSHgsAN5w0ksV3FD1K1ojKfqPTyo7cGzutIJ2eGTGLhohr+uUoAOLyqXzLrHw3K/a++S8q//lg5Z8Q/THiFBtPhmxufc7hX9z8cmPm+1a2AcNV+NQr5PnBt1OmeQAPW6gSRtaKchaaWk2g2hjBK/YSPazgVTiuKTe0AEfwND/NW+cFLV7Jih8sV3BwLokqAXbaNDdPs+u2LuerWNatNcnkUS3AsInrpBOKdoOlGQcBFjY6NVYSPZq3i8cbunujCCM8B5XKXnOSn9GAjSQE3riBjJuiSW15WX5VcyB151MvyQk2bknRtyeXu6ADYcEcLo31TgOaRFX3lNGyLDTBE2hBNgy/L9loGfRRtSUSrqfWwhRQUA6NM31sTikcjtf3Alf6HIvmBtEt9vnUHBURFUxshJ+rik1Bm8eg+fYbottlFiNk5YjGQOHsqnXzxNHYOUlbbxR+MZaYt8GgLlUmKVA0aa6QpPALrq0/FSgcj1Bj3hUUWRgI8hYI25BFvhE3rsSyL1saFcTT+wvU63NdkXyBrdD0isgcoEvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(71200400001)(41300700001)(122000001)(186003)(83380400001)(82960400001)(38070700005)(86362001)(55016003)(316002)(7696005)(76116006)(4326008)(64756008)(33656002)(478600001)(8676002)(8936002)(66476007)(66946007)(38100700002)(66556008)(5660300002)(26005)(7416002)(2906002)(66446008)(6506007)(52536014)(110136005)(54906003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+AGxiIpfvqA/qenSLkyxcjUnGxuUoAwez8DySvMVgp0QwisbcJ1MHtuscle?=
 =?us-ascii?Q?ZBPqDNbW5DVOb5gcN1sDalk2tMaTZBFLdLVVBCbTU4KAuH4WEMQ5fS6gwSOM?=
 =?us-ascii?Q?oaCElFtXGsq+uTkjcgR6pcCsagthA6nqJPfn1m6Z/2oLY7a5+JwelVoOM/ak?=
 =?us-ascii?Q?SAPvA4lEH3YFOt933UtmwaqWT027IpStG2224fYJcihXCf8eyyt/qZUBMmGP?=
 =?us-ascii?Q?Wv9krWQbhscAXsSFtTunNm6GoLKSYUwNfXEhTyVgZDlXoZYKS9dI6yWRWANA?=
 =?us-ascii?Q?wqoltfp76iIJTAFqYXffCASxxWOwS7qfVxzDfrA0b5bKeq7lxQQR2o3rHZXy?=
 =?us-ascii?Q?aXNL+bEUKXUWbpoAhNjqLPCsqAyZYai3NGqRNvRysJ3GuRp+CX4P/rFljsu1?=
 =?us-ascii?Q?41QbjIeCvWuZtUHdQbxG7A4f8r72wqO8zC7DE4SuCEM06SlwE7KqoYmjAsAa?=
 =?us-ascii?Q?AZ1kGu3xKenPNB+M+NN911m5c6LdsQOYAS24xsDWQp7D4npCY9YshnRIe+ka?=
 =?us-ascii?Q?KCVOGlZ+G1r+HIMYf4+7SuOygIrXrtRym95leJWg5+0FkPrk9x1OeJVGYP2+?=
 =?us-ascii?Q?oPz7wDLkXKSxpymbhOrguR4K6BfkXzDEXoSwFRQdKfqI30/x/9Pe8U+bwtfP?=
 =?us-ascii?Q?eB5Ec6nqGw6o6EMzdHT2L4cVkfCFgYV2Q69jsAmSso8PJenieDcJDU0Auu3a?=
 =?us-ascii?Q?C9HcsbCyKDY/GX8EdTfcGZHbO0fJEFkLoEOKLgIVDnkOvO/zJd+H9DHfRKca?=
 =?us-ascii?Q?8IYsgvRmP5NJDbaeuF1e4lpJki/sb6iOGExDUzqzq8Wcxfmg+IKRF5Wy6Dc1?=
 =?us-ascii?Q?Es616Ib6Hma6UbRASmJxhymCmaOi9c8NqvuxPYEght/b6R+5MJOkLsWXoAcz?=
 =?us-ascii?Q?h+aEyIzTSnaa9bbOd1QX/j3SS3jm00kLstP04NG7VNgEEg2w3zWmNd9USkhY?=
 =?us-ascii?Q?048ZLVOFgcGLc0p8V1u4dLeFBoJw4TC6KwvjIo+NbSMMqg5v/8IIYVLqc0HE?=
 =?us-ascii?Q?LbAHkPe8dcapDkysaTlaVHko1E4zbkJiIKpiT4kh616U3UK7wPwUEMq2xUsK?=
 =?us-ascii?Q?NgWGzajd1lfycpLrZqp76uJFSfZHsVs/phmJkVTn2m4C87sJGf0L+n0dBWiN?=
 =?us-ascii?Q?EgR0Acp5s/oUHPPHKTDNMXT5BUqb4sTquFqG9hGrl1PNyWbbioEbNoXWaK5a?=
 =?us-ascii?Q?CZSAL1X9WqEPjJeEuFImwvEI///MY1AAlIa8F9fFnM2x0Q51CvFWdvqymktu?=
 =?us-ascii?Q?0XuGV5jP7PuHQ5t6fpkNYeT9IJ2UVnxZX/l0fHzaIRO99MWNcdffPqJaKNsx?=
 =?us-ascii?Q?yLSqXJdlFf8OLGLB0o4jCBXUBKL8AUxPFBuGCHCbeRfg1e5KwYsQVzEbUNSt?=
 =?us-ascii?Q?MttSTcmCTqUVBH6XUfsP2rCQufWRjgSr4LvRspao6ROWUvEVqhTLdB7t68Xv?=
 =?us-ascii?Q?9UN4sGMpEiSKikiVdLT2QYPuxVPf0YN7r1c8Cg1Qs/I44AuQm3yYpAMjR+xO?=
 =?us-ascii?Q?4HkcNMTvp5tSDGpmNbZD39EhlRUd+lAQ4oqaUOdE2gnjIAhcEKV/hvCEP6WV?=
 =?us-ascii?Q?B6O8RaDZ0Fm4OHyHl15sJim0vnmPa4YvHO/W2Pgq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f806b1-ac80-49cc-39e8-08db2c926700
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 18:05:50.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVcA1EpU90blXqDeDm16Zc/4I9DnSi4MKYMah4+Y2y6jahxV0yDVfFX+xD/ylxaIHvp7OUn44zl1UkRDS9FijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>From: Yicong Yang <yangyicong@hisilicon.com>
>
>Some platforms have 'cluster' topology and CPUs in the cluster will share
>resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2 cache (for I=
ntel
>Jacobsville). Currently parsing and building cluster topology have been
>supported since [1].
>
>perf stat has already supported aggregation for other topologies like die =
or
>socket, etc. It'll be useful to aggregate per-cluster to find problems lik=
e L3T
>bandwidth contention or imbalance.
>
>This patch adds support for "--per-cluster" option for per-cluster aggrega=
tion.
>Also update the docs and related test. The output will be like:
>
>[root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>
> Performance counter stats for 'system wide':
>
>S56-D0-CLS158    4      1,321,521,570      LLC-load
>S56-D0-CLS594    4        794,211,453      LLC-load
>S56-D0-CLS1030    4             41,623      LLC-load
>S56-D0-CLS1466    4             41,646      LLC-load
>S56-D0-CLS1902    4             16,863      LLC-load
>S56-D0-CLS2338    4             15,721      LLC-load
>S56-D0-CLS2774    4             22,671      LLC-load
>[...]

Overall it looks good.  You can add my reviewed-by.

I wonder if we could enhance the help message=20
in perf stat to tell user to refer to=20
/sys/devices/system/cpu/cpuX/topology/*_id
to map relevant ids back to overall cpu topology.

For example the above example, cluster S56-D0-CLS158  has
really heavy load. It took me  a while
going through the code to figure out how to find
the info that maps cluster id to cpu.

Tim
