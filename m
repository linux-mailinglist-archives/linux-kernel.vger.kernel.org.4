Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA05BC597
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiISJjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiISJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:38:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7681D326;
        Mon, 19 Sep 2022 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663580334; x=1695116334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R1MYk/RS+n6sVXOzJchwTA3Il/9YNlT42pXH67QWPx8=;
  b=A1iF1LUa6lBFMuHyoNPY5DHKQ8FTfntfi0yUF8GcnkV2fbTyNQFfLl9+
   rR+fLYXCKwTekJcKyPKCsqbqWV2s8L7u5PNZ3hENQyESt6cC7/jMx6Pgr
   XHRqwt39DU29G10nxsPnF23m9COV2n6EtCWSqtWmy2EnI6Vyh2rW4i562
   5OMaCg8B8DDMrStGE+Wgysf5/pkZulUChNteG5oJs73HI6KFWg5nfHKeR
   zGWociRnvhCUF7yMTyW6uCvTv+l2SeJr9g/+C6FGSx2GV5FO9bfMzxhUt
   hgvrwr5NtqP9fjJuUJBdWQ+yTqf8fGYrASzD6QT5DHk45dtVbiBXSpZiS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="300727065"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="300727065"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="620790946"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2022 02:38:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 02:38:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 02:38:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 02:38:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 02:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecEtSdN8+AkvqgV5HBUZtCyvAwZQGn6niLXXCyTG0lEVKrnEFUnScwvDIWWQZJpo5xxvCbWuIEwL5a+kB6dIRj2I3Y6YId/P2C0b2iZFhmI5PIIsgGTs9qeZ8D8kUPYaBdNm0zlLGKz2Qjj9eeR+P0DC7ZL8rU0VEHjlsRbCoZalv0rSUEyxhg9JlI6P9DNuNeKuarFgIOGqdJ3iuhm1QtZOB8Wlvbl/laeTSlUIAWboBQ4PbGII6ovTCpk/BKcjpC5kRfsgNmoLl/YrCPI+m+lSoNpfT5SNCfXBdhhR3fP3Tu5k8oeO4utQO2/Y8jyMgJVACy91OzuQRMl2o0vEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8DCEeAlmvTOUFGiNKUW3kquElmKTSb0BdytTm0evoI=;
 b=cwzxcLC1Nhg2AHlgcU2gIREb5HnX3dAAiT/5aO3Gfa5RxXXQaQkKLN3WO+RD52mYqcOSj677aggHLwwPFzPGhMgpYNVAWNjHHgFWw6d2qJj+6SEaHIwFJQvcth+o/k/eb/HtCDkZjkTKYHPr4hGKsqd9xA0yJB4DIn4xVpYx8okh9L6nsF6R78V4FzG32BFmle+bRi3HtuAzIbjHJhecqP6Xt6AaJOYMI19RfLP3dsl0KeB8jaNFl4De6arWhHa96bV9d5FSvEQwZtLPoWOcATKVIQ3P70WmzAlLySPlpZMeaXUcqaK+WYw0trOLLjEeoZi6OfYrvoKwdOY8igjqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 09:38:44 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::c431:f74d:4292:f2e0]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::c431:f74d:4292:f2e0%5]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 09:38:44 +0000
From:   "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
CC:     "Muszynski, Damian" <damian.muszynski@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Subject: RE: linux-next: Fixes tag needs some work in the crypto tree
Thread-Topic: linux-next: Fixes tag needs some work in the crypto tree
Thread-Index: AQHYy6vb/RWvImBQ1kGnd9Z6lSNu263mf11g
Date:   Mon, 19 Sep 2022 09:38:44 +0000
Message-ID: <CY5PR11MB6366B542EEDCEFCC97F00D2C824D9@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20220919081259.714b81f8@canb.auug.org.au>
In-Reply-To: <20220919081259.714b81f8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH0PR11MB5095:EE_
x-ms-office365-filtering-correlation-id: 591df070-4f19-45d0-fbf8-08da9a22bed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VW76HhfZ94seaKvckora/AO0DtjHdYias+5Vh9Bw0OdZtOBU0XXSspw3uEViyWCbM75vNONoJQz0QC3xKwHlYstWx2kPT0V1V0ikT4vcgLbAtPqjskn0nwHyYg4xugLPoY4VLc4ORZisKUVL1i3iBZSDUsOaag3n5/p3eO/SpBuebhsRgGnPENQtkQIzD9HCbu3rKv/NuNtQ2IrTLUKXDKmstSl+uGB08a3KoGlOrYiH7nZU4cIbpGVz+L3RqEY+/AAErqPKjpo4D4zuZRZmWynkNjvgTeWHloCHubkvkyxzPzr3VTYoW4bS7Gu0CsD63ps6rDu5ZmSDZnmAsyR/AvkXd1GrYOueLpIyXIJqvjWvxQiqPlqhCbPTKS2wF3AZW4tAvX64H1M2zJE39XM5GbI7XNQ5mMNapKZgU8F4o3yvBrQ6rgXSJstFRa3iuwVA7nFqGjN9CnUVk5bCb37AbJrnum5ZqzLDRjTl2ZKG8h9JrV0t0uc2/BZfgegGxvlhIeMPMExOvVpGXhYZRCAR4CYQxFxsjyX30QdwWtH2ItnfTyhZHIjDlZEOy7HzptmJUJq8mj6BQn71fXBOKaEWO5PoU/pcYaDedrEOA/P5YLh0P4Z3ZKvMaNVdnEyilE1CVwfrPzGZ2aAxyZdM82+sPbWzlsgnwDbFzdPTJG1+21jxgvhWO+648gmfuOdtF/CSWnt9kLKvm2NxRhOT8zUonK/AJImZHgpBFkVECNvBj57AWkKMHZKmkTaZdTgVxqYwNp8AoGGALKGt+u9pw6d65A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39850400004)(366004)(396003)(376002)(451199015)(122000001)(66446008)(86362001)(33656002)(38100700002)(38070700005)(82960400001)(55016003)(2906002)(5660300002)(4744005)(478600001)(66946007)(66556008)(4326008)(64756008)(66476007)(110136005)(52536014)(8676002)(8936002)(76116006)(316002)(54906003)(186003)(83380400001)(41300700001)(71200400001)(107886003)(7696005)(53546011)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BusX/JLFqz9s2PzwfeuhjDYIkWKLtcVAaqViydqW8lRAEg9xvrXeqTFTvPOj?=
 =?us-ascii?Q?1uPSu9rQUjmVIondwdQmWyFSgLIsfhj+ajZlyWmXwFYJsO2hRbj6trKu8yKj?=
 =?us-ascii?Q?8C93wNjfR77Kb8s1Q6KKYt1uP3vFB/YdfgpC3Lq7j7qwqEooLGZXi6Tsmjg5?=
 =?us-ascii?Q?uVJ5gSYvz29cuq4K1do9mPTmJDh9F8/N5QaaKwNn+tGv+5l+3xGfU9qrXXYB?=
 =?us-ascii?Q?syk3FwQYr+YPzwV/njxCRreAZSOZtJDJpGgFACO4zjuLkh1a5RNQn9QzqLs+?=
 =?us-ascii?Q?LLEr553EDUhRHfM7wvO5jMBdq6X5mlp3KhNdJIxaGWqgxH+L74MrnCCSCYwD?=
 =?us-ascii?Q?ZsJpOx74QrMrZtYd1gE44Lfjc4tKdysqgWUqTQTDcIG14yRTVRwvkI3bUE2d?=
 =?us-ascii?Q?lkKPwhAW0WTt0WmgH8YLpflNGCFTMYobzmoY9JL7RcjTuhLebyPwUrSooBpQ?=
 =?us-ascii?Q?vOyM6rraM4p7ngeRcmGnUGA1kNvyrRS5/qmM2FB5d+JBf9POhDWGDWIu4c8/?=
 =?us-ascii?Q?Edfb/wVNdH2030L8nI78+roAYstxl0SqoZX4ozrGykOqSd7wo8SEO/Jp/dVi?=
 =?us-ascii?Q?3661augzqoo20urk6IRe7T813zT+ovdpXw+VnkiHpHvpjQdNtVjAvjidajoa?=
 =?us-ascii?Q?HkkkXtIkM9JrCJvHErwqnyh0LAAJl4QmYb+e+KcAopJl/kXjp6sTs9pYThmA?=
 =?us-ascii?Q?Nd3HoN6t/5JxYQ6Y0d629+ex3wbHb5csR8Ra/4NhYU2o56342W13fOC1ThT2?=
 =?us-ascii?Q?MhNNLGoGKWy87t+15tAkQwsQybp/MJ7OCpIY2iihKpqjhL689bMwp+TZX+1T?=
 =?us-ascii?Q?4IauzP6v9FgFbvRC6ppC/eK0RQsIItiaHjh5GcFlc6usUbPRYGzUXOJ+tarb?=
 =?us-ascii?Q?uGTwWIYqkGfCSjF70i2xFWWqFhABWLAudHo51GPgYgTK3prq7EOdM/IuEhFP?=
 =?us-ascii?Q?MrOvrSL+yQ8Ynxu8fv62B/skxRVzbjJBooLA2YUmFgDuD5LeRT6PixxsfVDK?=
 =?us-ascii?Q?Tmy7n0ttT7dnfOqm4KqUBcxxhAGDShvKaQNIGOrvek53SaPZk2fOJvFsVv0r?=
 =?us-ascii?Q?vhGKP/BjGeGlf6YpjCNKVKJKbtaku9mLdpMZ/vzvgg7O7ayro3XJfZ9AdV1p?=
 =?us-ascii?Q?AeQ2+CfVY+wBtrE8l51TO6DzoNAF9O3dQK3NhKUtYsdovHReTH0CLHodjL33?=
 =?us-ascii?Q?01jxEOl8RcZFLwLipEd7RRC5dhuJh7vpIzaDYJHV4S7RpwDAH9Ovxqzp9UG0?=
 =?us-ascii?Q?44KHLJ9ss1kEvEJdD/WnndCEEawipIMB8s9Xd2z4fzhzp0mFXwAtqls0eX0u?=
 =?us-ascii?Q?xEo9Y7lwdNzknkvkUYjKkBW3vpOl8PTUsrYj0wpPLjpWSXwJz+izf9Bof0Hk?=
 =?us-ascii?Q?MGbLksVtHDpASVfVMwYEB69pp4YNI0qBjCFOh34xfAgG74sAQyzuKNx9YlIw?=
 =?us-ascii?Q?+vf9iPOSufYB07DMFUGg4qweLGgJZiIwPJYRqjhDjDGHXPydY8ma4jiawHLU?=
 =?us-ascii?Q?LAicHBpWbaI9Tsb5C4NL8QIPKVQwMDFuyitV1v39V4t2okfSz4+27mtTMM+l?=
 =?us-ascii?Q?NLVWfEdQsnYuZiZ/xIufoxSF8Quvh1LE6sOVr/+tEGZKJa3sQj63JtxgtpkZ?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591df070-4f19-45d0-fbf8-08da9a22bed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 09:38:44.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNu88NOXBZhZIgAK1IAPXGKoKKSz3FhbLM9MYjiFWIz0wIZCZkX7JhOD5n4EisEeay2rWKfJRukSexpAT3atl2rRNamL5Y5duBUBVuoswbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad. Apologies.

@Herbert, can this be replaced in your history? The correct tag is
    Fixes: d370cec32194 ("crypto: qat - Intel(R) QAT crypto interface")

Thanks,

--=20
Giovanni

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Sunday, September 18, 2022 11:13 PM
To: Herbert Xu <herbert@gondor.apana.org.au>; Linux Crypto List <linux-cryp=
to@vger.kernel.org>
Cc: Muszynski, Damian <damian.muszynski@intel.com>; Cabiddu, Giovanni <giov=
anni.cabiddu@intel.com>; Linux Kernel Mailing List <linux-kernel@vger.kerne=
l.org>; Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the crypto tree

Hi all,

In commit

  cf5bb835b7c8 ("crypto: qat - fix DMA transfer direction")

Fixes tag

  Fixes: d370cec ("crypto: qat - Intel(R) QAT crypto interface")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell
