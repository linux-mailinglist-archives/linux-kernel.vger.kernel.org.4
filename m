Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF2D5FA331
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJJSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJJSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:13:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2F7821F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665425622; x=1696961622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gYUWsmyyC42gVO4ImS9SssfrfuB+ars9sdYfT/1lpc4=;
  b=e3w6b+JA92qugSzKaQlnYBOd04DsDOQ2j9KjoOXegrNZZ8bRflNP8Zdh
   q2QX7A6VP0d99YOHgXSZQ1WqFL44EojHwnXbwGvC5axNzRahPCJ28ANBq
   GwWfYB6cQvAX1VFXLFhFAMo4oMO0JlxH/auQbHT9L5NWlwG9UIncy5p26
   q3YmpB28VZ5Eu5Yi0U9bBAwQd9oCD9lZczxVJnaudkmN1rarS+D4/084k
   10BfF+RL2axMK7lJM8dTKk1ZUbEpG/11Hyujb5jltaKTF6bjvx30NSpqM
   +pokuLy95KmL/kYJrGeHNOi7zgAh7ZA1qt6IDgPRQ9G0h42gF2KI9DaWy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="304287662"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="304287662"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 11:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="955011292"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="955011292"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2022 11:13:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 11:13:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 11:13:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 11:13:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 11:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJHYc15iYLh8Sjj/5gCAIft+pIWIjV7XHiCHXnT70avPCCpDC2p38PgdG3GTPnDCFuX0hyeWXOzNdemtuLhPa9QkT7Ir8SmzP9yGKDCjkHkJLoT/tLBrWbr7eopc8j/UfPviOY0Hs/3eTIdq1tQe4pJ6PPnCOxzIPWRIJLqy5OBkriKh6c7EViTKw8PzmMGHlqwZf47Z9RouClG2+DCWOfyQn5EM+/gURDZMWRPrzap3bSVaUzZiqSO1g3yJIlc2wSp4Y92sfZyepanJSYFj6RiKxSPaojie1uGlsYf0ygKJlFzCeuEHeJ6Fk9Fw1apWGHFWSWrMRyFoKmhQgBAQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYUWsmyyC42gVO4ImS9SssfrfuB+ars9sdYfT/1lpc4=;
 b=Rl3KkqMSPiioeYCVg5G8aogVcCyQqOS/UZpF/S4K8EAj/JyJvTk+xntaEAk5xUGQ1z62CTWDfxNO7i1Cr1T553DOpugLZCj6ZgQ+MczNOUDRuPkRaHdbrDkUOqYJlLsITTBe4n1K7avwcXCuJ8NTbIcCbQLngmBKv5phTCpNNByDOM5/CC2uCizhAPL8sYHizAK1uKbgojOqDeTvPUIXu4wbZiRQjLnNMZdCRkkb5pywzv1LNXLM3bS45fkyFEHvGZGhBw1QdY8YgRYvkoEIMh5YaK0Kuqxg2xgiiRzaYJZ7las4iFbK/efGR34GskjomHVU6Rxg04YaiHJrzQZ1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Mon, 10 Oct
 2022 18:13:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 18:13:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [RFC v2 1/4] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Topic: [RFC v2 1/4] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Index: AQHY2qcFG8hSD9xDFk6RFr9wUYNvpK4H8qoA
Date:   Mon, 10 Oct 2022 18:13:25 +0000
Message-ID: <53f0f3feebceead8a40185a5fe59ab15f8bcdcb6.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-2-song@kernel.org>
In-Reply-To: <20221007234315.2877365-2-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: 93614403-0ca8-4bd6-cfa7-08daaaeb2000
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRLEettVp+e0Pv9+HmJNWvcytnnQeYuitsdhVCmyDAuUsulXHAFy7WQIwtKdvNYUNXs+4NtGr9/wepJp+4/Yw7VJm4Z+rV4i7h2ebHPyAObhPXwXg7FFxR0U/8IfXwnOzomv8CXG9afXBZzGdFAXD4qEMxiZ8UVNA1xfFsqQoy9ysbQ7vKZQ0G46j/N5hoHFTMA1TWvdNSvWffp/+QaA881RFuSvR3SPRyPj+FP25mNB6KZp0Dqhoeg+r5W2F3ozzrX5IueDdicvqkC7EL0gSYNZAmFCf5o/8v7MOuZnJteX5eid4posN4rzSLYHW/xqYiPYheil9lvM0E0nsWlSJzBFWs0aikIvUV0XpnGwX8JFawP/HT0oXKrbN06Us9DVA79vAglLxne2O9YguWzLKeydNsNrJCXNd0R+7u0osV/crdwPjRiRCls7A6qvqts+rh1UK6fsQfUH1+ysoN2QpEifPKy55HQSj0EcEEspubzotPbIJFO5h6tCXO2oXi7LqqLeAdJ61P1qfPXEOhqY2PLVvz29COMTxGs9ChHqpXUinnvLuucDNlV1QMeeRKWmMNw4eWZ+GwDLY/p3rOZTjlFQZD73L7qM2WvClZYW31N8ldTaW3r+7kvVAMbFEJs643AOnOMHBNp49bKuCemkM151qZAkQw57c2zXjs8qx2WvHRlGgL3kAGIg2WvvFhA4gKr0adaivpKRyXvXokUaFYIb6xCYNcufkSfm6v8xkq4jyWYuYur0Z2ng3ujvvpJP74bQ8IEEwgscL82CYdhQRFZBriMO3WVL1GIynWL7USk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(38100700002)(5660300002)(107886003)(54906003)(316002)(41300700001)(8936002)(64756008)(66446008)(66556008)(2906002)(66476007)(558084003)(82960400001)(66946007)(8676002)(4326008)(86362001)(122000001)(6512007)(76116006)(4270600006)(110136005)(6506007)(478600001)(6486002)(186003)(38070700005)(26005)(2616005)(71200400001)(36756003)(19618925003)(91956017)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KukKmZ8dIuvRocUw33PHfUQrcQ4YiE/ox14IH/dLxMrz9X0HNXVvF/h6Cu?=
 =?iso-8859-1?Q?TyxTPU+pneNCa9JJITX6kR+JkUYXdwuts5MuRGQg+xiQucEdlyn1IsMvug?=
 =?iso-8859-1?Q?PqXDnR9XDU66L2k+rHAT6L1VFuOW9MCrWEgKxy4n1GGk1D996UdgjIRNEO?=
 =?iso-8859-1?Q?5iKc1QTY5s9SvPliNVlf2kufYliAVVwFB3Kysr5a93xeP1saAzy9DdEHWW?=
 =?iso-8859-1?Q?5TcrbA3WWjhllcQdTsKrLU2IwMSS8W+dy8q8PZWihpuZU6bHI/c+WwKqRW?=
 =?iso-8859-1?Q?b0VvOt4yLxoWB4y+gerCPglhtMj4EYbT3jbzSdg4QJrPAbqTJtFGRrGZwB?=
 =?iso-8859-1?Q?jFXGlnNataezYBG9amGP0jD+dAXfG4Ga713115UPmrvHbG2lrh61wBcAVz?=
 =?iso-8859-1?Q?xoe3X0/CXXW9zhxgNoAUPbJdN0eGOD7CWLuVOtNf64Neyi5B8RUx1a7tSX?=
 =?iso-8859-1?Q?pzg54lumSSvtjuJfPt+cGquQqfDa9D5+m+84t2UW+HFmnmwsJnZFRTsXuP?=
 =?iso-8859-1?Q?v4JMAEvdMVTfaPiM9/iq9RM95E4aAOI4RovTPu/CVKtXJyDCh2Expg0oZt?=
 =?iso-8859-1?Q?VMezeV5ubHDR6YixfKpqhWJ+cou+mkirzCH3yv32HRPxH8iQQhrrao8JcU?=
 =?iso-8859-1?Q?1xWD80Iq4165vgSNt6RmEcnbU92fYwstUoOJ/EOLQbRlCU291S/fl1DlMK?=
 =?iso-8859-1?Q?JCwICe7j1m3QOK+pcnRr+3nc7zzRRiKqVbmuY7WIY8AXIBMuXxC2NYRRPG?=
 =?iso-8859-1?Q?tCzGnaBwJsSb7EXCERz4b++odCq6EM3aB60LwkIMLYsBLYqP0irucGO4++?=
 =?iso-8859-1?Q?Ce3H0tuTrqI9RH350CzPGsTn7wxg0G9DcQ3uTHO9jWkxYYqNpSYmzb+vF3?=
 =?iso-8859-1?Q?CfQmwIpsMs3anaJO/Ej8YR7frvEZxlmnK9Ne/BBlhnP7djg0D7xuPI39dM?=
 =?iso-8859-1?Q?M5hnvFGavhM/r6msVjC86+Vlbm+6KUxBZQVC/ft+/ux1uSed2bspSYadJH?=
 =?iso-8859-1?Q?NHW9KMHAcnXmYOxAeST8CrfqAl9UdLXhDv0zpoeQNdItdy1D7RNeprWXvM?=
 =?iso-8859-1?Q?F51nZ3cC/S6PGRzYmhlXDKeHixp04NCn9kAhfj3709F4+F546H0aF3UL5g?=
 =?iso-8859-1?Q?XtxR7lbs4UjJy84k2R/bJLm4yg3uKU45T07vngY9qFap+wF6LKMCzKd/U1?=
 =?iso-8859-1?Q?hXQkVyHuGw4xISH0+7Oh2P4dRZlOusANuit+eY0m1P/BcFQiQp04HClwNY?=
 =?iso-8859-1?Q?l6o1TEC8+ViqEcGiT9sX+isFLxCJnRzqwX7z/+KXtLZmAq7yak5akzR6Jx?=
 =?iso-8859-1?Q?/5nfThHXvj+xZvb3LFhtor+I0rk4i79X+iGwb2VFP9P9NXw2XIC9Qs9w5B?=
 =?iso-8859-1?Q?YrKg8pIoVZhXeXf6cHWPtqQ7OhZeUpd8IrYYYnp6mIUb76FlrWWhvY/Ho/?=
 =?iso-8859-1?Q?TNWL80U1fhcV4EJGivtrFEt7ffBI7hYmoXJKv5SPTIrMCZBxLNHdC7DEnV?=
 =?iso-8859-1?Q?ZfKCvJe+SToUfoWqR8FKETD/R8jG/EFEqgx+7y/lWSZppE+zVG6OiKYmGF?=
 =?iso-8859-1?Q?YcBjLmKrgzidUcAFr092jzl/dn5z4XyNSapgpuqxJuq/T6z87BCTFOcLZ/?=
 =?iso-8859-1?Q?mp6SXxC/TIv939NgkZOHnO0Oh/oeRnMNTit1mB+oU9oaNHga4wRP5HUpwW?=
 =?iso-8859-1?Q?XfGSOLe70xRzD3yKg4E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93614403-0ca8-4bd6-cfa7-08daaaeb2000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 18:13:25.6994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1dM9breTV3tzR70fF6Ph22Sg6uvNWQDdhXmfidXnvTkyiHMZcH7THBbbfDF9y6TjrQ26Utx+9kAwEqrkZIdurUnL7cjXKLFWTfPuiBMQvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How does this work with kasan?
