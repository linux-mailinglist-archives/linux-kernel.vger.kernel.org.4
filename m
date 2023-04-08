Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721F86DB810
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDHB4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:56:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31761AD1B;
        Fri,  7 Apr 2023 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680919003; x=1712455003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fXmo5d9/oeDsDDOjTC92fHlK2q4yCjYT9A98MleLA38=;
  b=AQwB9+IWagGnA9Id0QU+UAcENrTx80zE/TLEYsiQgWUXzJy9f2wI1Lu+
   9pIUyFkyN5j8xnmF/bADlt7fsIk46AmkA7XYbsurJpp+4J2xxyvWzc5A8
   wrX+Cg6eAwZv1CP4xegWciDLOXIERVhc+nrbfhL0BnJdqEZ2Otm7jAjg4
   uNNv6+KRulBU9KhMWc9He7r+Sxw5kQEqg4DHBAxAFNkLi+EY1VUzFANc3
   TnoRyAjCGw+0LIYfWi7k0ha1YhXzO3kXoLJbQ9gdTTll2frwZWGw2G+jF
   xS9nrYcCU3EaAIJ1xaIVMjxzo9ClNkK2UF3vlgT3A7O9rY4EKDeTOL5Nl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="429385469"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="429385469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 18:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="831351741"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="831351741"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2023 18:56:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 18:56:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 18:56:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 7 Apr 2023 18:56:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 7 Apr 2023 18:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW8SNNjZKLWRtfI+mBbgVkZCjBPpj+Q1lKz6LPW/J2+jeYT3IWG6l0tqluU3Hha+MWdx7FEN24BVimvEXXUZHDfMq8GL0t4+QVavVNFVbEJwWkysRzdES6hwBjvYq0kthoyKBqJSZ1M5Zf4dnsCMoq9RfxM0yYk13vF2K30mzcSJhkPWg0k3OdBbQBiSBWDuE/yJPZr5gUd3EhaDXMTQFKFYFhvhO6FD/zV4YpfhCgmzWXhvbvmkH6yvbd/5tYRF5NPGCXhPUCbON8hpfRFHnxVr4fbnGv6VYavPa6A4XBXxyZWoo+Z2D6F7ADLUCa+rma1RdXKXN3F2ifsjJg1Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9weyCj8jJ29SN+/MZ8N/IkA5O+IXrE9EdZnDTLJGHMQ=;
 b=QA2xTDj2hDkXGPbcmmdja0iVsVUbI6C8leMALg67OdLZj64EnhnMHL+gNyjVop9qpABmh/R2qgHTa3PrUiiI7HN0ngi44SsK3lDyf8yPz7K88k3rm+5COxBE9qAyY3F/iZ5oW/VPFxCoJPzlUwxz45NzdyGUo1H7ROJ2LjS71R4uXpi6KYwgeg4wHg/tyzj4jfuk9KS6+H72zdoRvFPR+S9SoRSXSfb6mdg2cOekevJoE2fc6KJHLtos8tBf+qF2RKP9LNluHBzW4IKenvYZf+MeURS5ZCj4kQRf4aCSC5lii884jTbwCxWRr7frOpF4gvv+ZWx4uWn/SKNDRPALCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Sat, 8 Apr
 2023 01:56:40 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 01:56:40 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaBxqLyldFWH+MUeQ1f1h2hb9AK8dsuCAgADdb4CAAFfuMIAAEHaAgAATPzCAAPB4AIAArT7A
Date:   Sat, 8 Apr 2023 01:56:40 +0000
Message-ID: <PH0PR11MB5880D0D946C20C4DEE3AEF99DA979@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
 <MW5PR11MB5858999E104C21754DEB40F3DA969@MW5PR11MB5858.namprd11.prod.outlook.com>
 <c0fed568-db45-4302-b204-b4f707bba140@paulmck-laptop>
In-Reply-To: <c0fed568-db45-4302-b204-b4f707bba140@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5117:EE_
x-ms-office365-filtering-correlation-id: 04dce5d7-642c-4d19-c7c3-08db37d47eac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kw7JnsIZDkwYi/Ik4BOKcbJmD/H4gy2CLKC3DN8Ud1t0GuBW+oujNmC2/P/fa1EYeIJEmdB1T8VDuCfJI4MW6Mwe83f34ElwihknJMZc3bJfpV1Q1I5cjCvsmlb37KF3fVa6MXhDsAftHyyCw7OAFZZA61jxtne9MqRoHP9J66UGdzHifLbhij6PYEiIXoO2057K1nokav5D+wWwf6CPEmyH0kGsKpJ8a15byTU3bF3nss7mPcGSbT32GRIa90vXuQmiJXkHicVP13uExTPCfNIhMyGWiV9VvrlRM3Y0Ng5IiC8aDBrWILklbsd2sOZbzi7tMlbxa4wCuxZfv6aBgS3NwHDKfzPd3VFJgNqYgu0xjxPGN7x6EiBHKYgLuVmY+vx6HoZ98Kr/ClASYOCE7anzegFMkDXgKUtR0lTAk/W487ihcgO+HUnEcNyn1D5Mf+D5Gjt2E+Hzg4mNe8InC8fKSspk1KiHCxOVqOzD35FxdURONnpjwaWQVZrhNf9tIWrJ2/hTr6IHRZE3DaQm1HxK4G++V+625juos1Wy6XRt7uMYKWX0CUSoE3MCiwmKgt0byMp9pQAunm5DUzaIEMCW1saf6kss3yT2dg1ruOtItnZ0nUyMW1wR7PY5y5TX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(7696005)(71200400001)(9686003)(86362001)(83380400001)(55016003)(38100700002)(38070700005)(82960400001)(33656002)(122000001)(6506007)(26005)(186003)(66946007)(6916009)(66476007)(8676002)(66446008)(66556008)(64756008)(8936002)(5660300002)(41300700001)(54906003)(4326008)(2906002)(316002)(52536014)(76116006)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xBjpUFHAYklgrB06L6Gk73GcLMFOGz/OZfJP/J7Kk0eiS36XGD8Ycy9ZC3p5?=
 =?us-ascii?Q?ohKm2lZG06l1DaAPszPxZMT69e6fRxvWtZITfukc9hmq4oM5RLf8q6myzF3e?=
 =?us-ascii?Q?p+0hyCcFZHsp0EOr1S3AbQbdZSmXIToSjzdS3EGjw/ZsiL5TUNHcuSlc68y8?=
 =?us-ascii?Q?TJFXUaYcNOUzX15CXfkUHwr7Q19q9QpUS3md7RRvPYTVXM/UfM69gZ8BhN9u?=
 =?us-ascii?Q?ulDLBeyVtTMHAlB8JVnAePxNM/AVU61uJ53BYl1hNNSg90T5cZIdndi09O/B?=
 =?us-ascii?Q?PucHD1KBBAnqAJQQOKwv0FLIAb5SaxjZiQnujwfdhtJkyfmkeNJJAU1tIT3R?=
 =?us-ascii?Q?gtSP3I1Q3a73dIxJnMLzxh0X24TROZAiC38RdWzHgpEM1Sc+0bbn/WO1n92j?=
 =?us-ascii?Q?TFBueqbtDxnCU4BmhlR2g3uyunC3YCeAhwZHugCfxwZ1jACveheqvscbQ9I0?=
 =?us-ascii?Q?+sF5MOXdVX3COttQlWbttvlx7KCBRgJCAB6ixuCDQv2VrPVbY/4MLtjBq8by?=
 =?us-ascii?Q?XJKLLjqwn5yMPWOCOP2n73dmwkBaTbCb7Q6GwSDGF+U8UvyYB17P/Jxi1Kyp?=
 =?us-ascii?Q?UOcQZ39u1w8nit3DKqkCdqs0Up/NJfGsTj0+lKlZSWVII8V5ItPyc1CFNGe1?=
 =?us-ascii?Q?NZV0UgpU/1mEmPyjED/v7YwO8O8UjKcFU7ql/+kxy52i8nyAdQtOCO8X/+UK?=
 =?us-ascii?Q?d3P4l9fCXpYRULkw2Ah5nbJb1/c0rZ3DNQeaar5HuFZi7uwSfMJuoAXqszc4?=
 =?us-ascii?Q?MW22MQ2gFC6XxlSRdXueZjR8rLzF15QroYwgyrttz4WMJoDUxA4Ca9GjOMSl?=
 =?us-ascii?Q?0TZshlKmKJ7tiNSSfJ8NGmpdh6Mh7IyUu7+CGMZzhncdDFE0hGAA+sqIBWs7?=
 =?us-ascii?Q?dVMbpNDyO8SjExtFc3hS9S5shfHDCyGjEijS3+YAfq6bf+xGF6B4KYe7Yd2l?=
 =?us-ascii?Q?kl9a6IyHhkekw7OlGM3c0oF7x8LT4GPEbr4l/lB8H5fmIjgYkCCJSf22BITf?=
 =?us-ascii?Q?eXv0Xu7REfbhmPr+FETO/v9MxKvT5sfSE3bTRuYWsElYbkH4hJ2W033Bux8e?=
 =?us-ascii?Q?Ja1h6SKMrrEuy9xUM4qWCpAJN/K2FRrJBMM3bIkiVFZhHK/wGgB+eonepmqG?=
 =?us-ascii?Q?xgqLPfkWFjb/p+/Fm49PD8NKL3IsB/xyoJhSUBs/5UyNb5IVta44uaGgKj5Q?=
 =?us-ascii?Q?nF6idmqgY45zVmu91DVSpxATluJn3swbx9khyFZ4Fgly6hMzhm/cT8qkIDwi?=
 =?us-ascii?Q?1QX/aw6Jxdoa0mOQmxCJwK5+J3rPU6h1XPkBps7rX7argRlmqwlXk8ttUuJh?=
 =?us-ascii?Q?aYDRs1imF0HFTXgJdTjxXbS95/BslkwPq5m+u6skcRJ3T+Ltvg30mAeiexpe?=
 =?us-ascii?Q?hgLqJ0zg8zPUwQKEwG0kJIEFnQlNHzbMp7OIEA1W4cOHo9aIndG/+g8gkXCr?=
 =?us-ascii?Q?Xc21lMcD3g9+1i75nVhiM0Cz8w+dpoS+JyxlpOV7A+yjXof/upuEEVgCjsv9?=
 =?us-ascii?Q?dINizkkRua5eiLRHyqh6bIruMOGs0xhoSHgEULF5nHAnwVN/Xg076iuylz0p?=
 =?us-ascii?Q?SXgHfjoPXxqC1puG7MZrXBQLOgsDtkKN9JHjjBqp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dce5d7-642c-4d19-c7c3-08db37d47eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 01:56:40.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Pd8PHVj8ahI37oZIqSGpz5XjW4Wf8exsRhqcnNcVae5YkXq1rB3tAD123G42j6elO3Stvy+D+9kwSNjfX9Tew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 01:26:39AM +0000, Zhang, Qiang1 wrote:
> > >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > executed before kfree_rcu_monitor() to drain page cache, if the bno=
de
> > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode()=
,
> > > > if the krcp structure's->backoff_page_cache_fill is set, prevent pa=
ge
> > > > cache growing.
> > > >=20
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 9cc0a7766fd2..f25430ae1936 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2907,6 +2907,8 @@ static inline bool
> > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > >  {
> > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > +		return false;
> > > >  	// Check the limit.
> > > >  	if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
> > > >  		return false;
> > > > --=20
> > > > 2.32.0
> > > >
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >
> > >Thank you both!
> > >
> > >One question, though.  Might it be better to instead modify the "for"
> > >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> > >of starting at zero?  That way, we still provide a single page under
> > >low-memory conditions, but provide rcu_min_cached_objs of them if memo=
ry
> > >is plentiful.
> > >
> > >Alternatively, if we really don't want to allow any pages at all under
> > >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pag=
es
> > >to zero (instead of the current 1) when the krcp->backoff_page_cache_f=
ill
> > >flag is set? =20
> >=20
> > Hi, Paul
> >=20
> > If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () r=
eturn false,
> > the allocated single page will also be freed in fill_page_cache_func().
> >=20
> > or it would be better not to allocate under memory pressure.
> >
> >That was my thought.  ;-)
> >
> > How about like this?
> >=20
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9cc0a7766fd2..94aedbc3da36 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2907,6 +2907,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >         struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > +               return false;
> >         // Check the limit.
> >         if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
> >                 return false;
> > @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_stru=
ct *work)
> >         int i;
> >=20
> >         nr_pages =3D atomic_read(&krcp->backoff_page_cache_fill) ?
> > -               1 : rcu_min_cached_objs;
> > +               0 : rcu_min_cached_objs;
> >=20
> >         for (i =3D 0; i < nr_pages; i++) {
> >
> >The other question is why this loop does not allow for any pages
> >that might already be allocated, thus perhaps looking like this:
> >
> >		for (i =3D krcp->nr_bkv_objs; i < nr_pages; i++) {
> >
> >Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am no=
t
> >seeing this, but I do feel the need to ask.)
>=20
>=20
> The fill_page_cache_func() is triggered when we invoke get_cached_bnode()=
 return NULL,
> this also means that krcp->nr_bkv_objs is equal to zero.=20
> But if can_alloc is set,  we will unlock krcp0->lock and allocated single=
 page,  after that
> we will reacquire krcp1 and lock,  but the krcp1 at this time may be diff=
erent from the
> previous krcp0,  if !bnode is true, also trigger work to invoke fill_page=
_cache_func(),  but
> maybe the krcp1-> nr_bkv_objs is not equal to zero.
>
>OK.  Given all of these good points, what would be a good patch for
>this issue?  ;-)

Is it possible to keep the filling of the page always on the correct krcp?

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3303,7 +3303,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
                        // scenarios.
                        bnode =3D (struct kvfree_rcu_bulk_data *)
                                __get_free_page(GFP_KERNEL | __GFP_NORETRY =
| __GFP_NOMEMALLOC | __GFP_NOWARN);
-                       *krcp =3D krc_this_cpu_lock(flags);
+                       raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
                }

                if (!bnode)


thoughts?

Thanks
Zqiang


>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
>=20
> >
> >							Thanx, Paul
> >
> >                 bnode =3D (struct kvfree_rcu_bulk_data *)
> >=20
> > Thanks
> > Zqiang
> >=20
> > >This would likely mean also breaking out of that loop if
> > >krcp->backoff_page_cache_fill was set in the meantime (which happens
> > >implicitly with Zqiang's patch).
> > >
> > >Or am I missing something subtle here?
> > >
> > >							Thanx, Paul
