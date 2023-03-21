Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DDE6C3397
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCUODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCUODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:03:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E18A5F;
        Tue, 21 Mar 2023 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679407425; x=1710943425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cZ8vfQwLfBIpxUYgCVAZ0Z41LponaSPn0JMG/AMW9A0=;
  b=Omrbt4jj2eQXsv+riOvfgFZTyY7uVya1FlyQZFDp60OjYqHtCxwF0nFN
   xOXyrlqr8RQOIoYIyAhnaywhBT6Ep+cpKge9kOfhDuCQ6uUFxbM+Pg3/W
   BC9Nb6BgojoPXo6pq5JiJssIoKSDwMFpzUQlFeVXq8Cb3SPsYyLQ3qUU0
   mI7G3qzhsWASC9LAQeyAcpvJCITgns95z/0atIyuAK8b5aOl57C0DJ4+j
   TQRR7wKsF5v5b74OqTfTp5gtX47tU0CXDWVNfNtDStCNXzB3VAALyai1p
   Wxcl4K6EHYMhnY5WgCoRW8Ai8WzAGeZ9hhmYCmHgVryJpIUMHV3TyWLYl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="366677427"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="366677427"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 07:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792099470"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="792099470"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2023 07:03:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 07:03:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 07:03:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 07:03:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 07:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCXuphKb5/rBFv0o9/ZixNqPY6nhYCSkcxgwHy1occb8OULt23qmabJTU4TxjcNswFmxYcjYX1ERpAo0W7L5C5B/uRv0rjB1Jac62y9LB/NLvhRVafyK1tzyN3gysnFJcwIWz/Nw/OYwIEDZXD/Gz52GAv//SCmiDtYQzGECRI6rjeU2ZP+nJPw28nJRBqzLa2mpDf2BMBhL3F9WgvQaWUW7r5nRZLQziZ8hMIcXv8X+QCTDgZubyWjGSeOYW7yCTFrN6oqh/IZvIOs+kTs1smfev0HgU38xM9ys+eBQPqhZMkfS/3jetidA/denc3gnOv6xWzbOaGOhSSAmaRiEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJYk0pELr633fJ0QJ5gSDawGsWa5Ip8pmU+ud8aFUeE=;
 b=H9wdMb/EHtJIfWz0J3PUvayI/rdfTs4pDgBXgVu6qzbRZRC0aqYEksFJaeBi3PqYsC4XiP2Ce8jqlJmI7PnbkV4569IZ3NB77xqkvYeInNSEvUgH9/VDcxgATQOy7dLtQ8lLmAWUOdqzozbJnAQIuOVQHugE6eLHsMTYvRi3yTcBs8Tr1/f4Zqi6CKSzRjrtetTkul9q7mI3OVMUD3iwiVhgiTWMB3I5cj26NM8uY0ywq8TyaEJ3yO9yuDJO30mNoIRjPlzgELZWhxjxvZfz5Rjq/dSUWzEHiH+GVStP8qPjkaE/+KDcvZKCLbo/UNYrOmHrRMnhWY0JqgmhCzQNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:03:19 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:03:19 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cgEn1/2PZAki4vZrvu1Ahi68FQZQw
Date:   Tue, 21 Mar 2023 14:03:19 +0000
Message-ID: <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
In-Reply-To: <20230321102748.127923-1-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH8PR11MB8040:EE_
x-ms-office365-filtering-correlation-id: 67d7f77f-22b2-4a0a-9f44-08db2a150683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tX42Oyx+a9sOCeB0g4fPsO7MefrXWQY5/6eZ8eQoW3qmrPQNmd6V7jzSrfFLQmfsdsKWw2DSgEM1XrZw/4ANAlKIAdPZjIKoffuDKubYnw4LBTBHh+71QfK8NnkIE9eYYOkO5R0ZqB3FKItg0DzWZNI4+e11h/hp+v+JlxCwf/Ta/VsPKdIL4M2JOe229yDSubSqxQdkBm/F3YykiXoYUzWjYjfSp5G3XJDr+sG1S2OEvhBeoCwzqSsiJ4e0U3dhdve/TSqgTRLmM+dWJv30LoVbSulnP7Aw/ruX3HlXplrFrM8fCovtp8bFrsAIqWB+TeGSh3JjoGPtPmPDBwYetU7rv5bM/JBPYh6riwBPisrGwobRGI6UGWff3vR3kKTdXRfFH64YlNjlF3Zqp4m+WkJDaoyZHkKXk0WMXF2Lv4qBizu5ZfH+8QHyKcje64uKq+EKblv+F71TM5rIcHToWJqZGEIIRnQuzDidal8wf9IP6ZOVV31yYDn9MXGq9/me7P66Dp18w0qp6lsI23kqFBdahrU+i8nfb/6KXepdwvSt1yBsTfLHmy1klMVWJtHaKqlK4lsLJSf8LGqx2yR7HTIxAfVeX4tWRn6wPBxjkX9frzl5D27gyhXfJq6T7TXjOSosgEVH3oJv5lmoX1UNPunMBm8Uep4cTfRlC70WNznHICNoSK/zJ9eJFHRX8zwbVrpiSmB75iHDzGNZeT46EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(478600001)(41300700001)(55016003)(66946007)(64756008)(66476007)(66446008)(76116006)(316002)(66556008)(4326008)(8676002)(110136005)(54906003)(186003)(6506007)(33656002)(26005)(53546011)(9686003)(38070700005)(86362001)(82960400001)(122000001)(2906002)(52536014)(8936002)(5660300002)(7696005)(71200400001)(7416002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MNCy1N/BAKjziHCSo5TxX3t/oh0p0y29J2sWMymE+5y59cLXs3QRvMmeaoIt?=
 =?us-ascii?Q?hXvZSk3fJcFbrA/RgRT9VT/hqw7OMos3S1S6QXgOedr9jGtAjhmW9RmFzOGe?=
 =?us-ascii?Q?Ftbdkla0KWgkV1UgDRA3YDo4OGL8AJRAEvizzkuVlm4yiNIwB6UoIsongybT?=
 =?us-ascii?Q?qPCDdYI41Ajv4N1maTMPrkeYQgGp4NYycglsNRt2jyC1rJdw6SoMAK2MaHxZ?=
 =?us-ascii?Q?WHaIX7S/WdrXKK8ThdhBzg8kPPI0RPV15U7zyca/BC7yJTaJDHaRI5NHh4Go?=
 =?us-ascii?Q?OjP4ITVkGkX3lpojQ3SGmCGWP24t7MEg/g4nPiNdikm4oXVKUY5CnWXpDM9t?=
 =?us-ascii?Q?/W4yQsSr5eVl9kizREpbh1/eS9W3ZdS0qcbuUaZpjTn6+92tZB7lkYIOOhwd?=
 =?us-ascii?Q?TFBYC8bY2uELWlELN7zgH8Rhy/t393pUUpC4kVtn/+VOjdN6VTltm9uGx6yM?=
 =?us-ascii?Q?DIXEL1xj3RzemQG4SfgzQK+hj14B1RNv+oG7uFde2bFTZkNcr0PabYaXMJdg?=
 =?us-ascii?Q?0aE6UWUtQ4fPmnEyByZOUUrsxxJzVONWcDldLYsNnR9VofGirmysuLZdNUpU?=
 =?us-ascii?Q?zR3mHKjowkTGyXU/ihfe10B/IM6pvWDkaxiuI0gAw8RMZtHvB9zFyPPKzrYJ?=
 =?us-ascii?Q?ePLclVGETcULxlaZ0SSkUG7KqII4udpYOpK0g+kMkyqNljzLQb8OfMcK7oIY?=
 =?us-ascii?Q?WjDT+W8XyEUfk3WWQqP8QDnP8cq9cAfTRhNvABqXOo6wr3PwpVJeBMOjni0J?=
 =?us-ascii?Q?aBc42Fcoa2N+t044bMfnT6tfd/vnstNkbET2nc4a3S0ilFHpJRNTeeF8Qviu?=
 =?us-ascii?Q?JqV8d9TxhBXcl6UvrOg8PIcjaNt7RNFLg4LqBGbw4U7bTfhllS5rDqWcn3/g?=
 =?us-ascii?Q?thFLBdXtcfVZ5wS/xo3kq3rl/cTACwFM4O3ilRNcUmxC0Y288ZtCKkd/aOMY?=
 =?us-ascii?Q?vf15WYOAHvASXALpnHuGRuTZsXVGamNiNYX8ESZcFTn8aFwmfhELycS5mBsQ?=
 =?us-ascii?Q?7LjmjMLrCHk6hsizMckRR8NZp5EjqxWfyjBfXwae6vBKrPXFaNDuF4wgDBUT?=
 =?us-ascii?Q?/08FVcWes9pVlwEc4qp101GAQVy1ol50q89+vXsD4S6ue6l9o+wQIRIiunrj?=
 =?us-ascii?Q?yBpQWr37DgVz/KIW1dw2+wx2Zm4GIAiZQzAbL/Nv/0l+NA18q6vEfZHQCXez?=
 =?us-ascii?Q?wVpf2QaFEjOO2Estp58GmPJVQmX/F7UP4Q3461oFKnvLaFoSWljMMuV5+QA1?=
 =?us-ascii?Q?R0OJHuYiK2TnZx5kEFQ5nfztQJyonRu05VA3P1J7ku1STZ0LUU/TQVokmTmh?=
 =?us-ascii?Q?YuVbKJkmcMuv6yHQvVU4NoTw9nI5JR76Y1ygaoDlD9dBfN/y6s0zhMWitlME?=
 =?us-ascii?Q?4gD8okmuBXphV6zeUl4aiFFqBLX9YXhT2vtXeiPRr1vbtDAGU9vNOafD8GRN?=
 =?us-ascii?Q?4+9NYCiXvHTJppoG8Sezhg3CSWDGotJEutiVO/OtgEhX3T2WQb6dgpIBLoxw?=
 =?us-ascii?Q?Dlyrl+aZr0wTqFadl3lY6IWfW+xOi4P5XO5b6nC0FlmnNyi6VvHwUCFHa9EF?=
 =?us-ascii?Q?fjol0JzpM4qAMJlqz9AyNnQsUIe4+qPEsaM+CwJJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d7f77f-22b2-4a0a-9f44-08db2a150683
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 14:03:19.4870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoIH8WadbuX8tuJEab1rcW5mBACnCKQ+8sGMxW7dH5mkk6jCX6fb8pNCeBs9+tIyPRO3Q1xoqV9jBTi9jN3H9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Sent: Tuesday, March 21, 2023 6:28 PM
> [...]
> Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
>=20
> A call to a synchronize_rcu() can be expensive from time point of view.
> Different workloads can be affected by this especially the ones which use=
 this
> API in its time critical sections.
>=20

This is interesting and meaningful research. ;-)

> For example in case of NOCB scenario the wakeme_after_rcu() callback
> invocation depends on where in a nocb-list it is located. Below is an exa=
mple
> when it was the last out of ~3600 callbacks:
>=20
> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> CBs=3D3613 bl=3D28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preemp=
t
> rhp=3D00000000b2d6dee8 func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preemp=
t
> rhp=3D00000000a446f607 func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preemp=
t
> rhp=3D00000000a5cab03b func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preemp=
t
> rhp=3D0000000013b7e5ee func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preemp=
t
> rhp=3D000000000a8ca6f9 func=3D__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preemp=
t
> rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-
> invoked=3D3612 idle=3D....
> <snip>
>

Did the results above tell us that CBs-invoked=3D3612 during the time 21950=
.145313 ~ 21950.152625?

If possible, may I know the steps, commands, and related parameters to prod=
uce the results above?
Thank you!

- Qiuxu
=20
> As performance results, i will provide it once we are ready with a patch.
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 104
> +++++++++++++++++++++++++++++++++++++++++++++-
[...]
