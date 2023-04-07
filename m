Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C16DA6EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbjDGB0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDGB0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:26:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240583C0;
        Thu,  6 Apr 2023 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680830810; x=1712366810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2CqcYg+9RBkg+3BxRs1Qh7DtQBM/Av8PA0RckfbPzeg=;
  b=nNwHgHRFl+jUzD/7UqXrG0LPcdsbIYzgAl9sylHwlLBOX/y234aB3Qiz
   5huqQvNAc9a+XIg5unnCMF7kWDC3FB7Z8yIwKCRBOxfItwPyQMBAzUucy
   M/S+K5JjV6JUDAJSXDeo+SabQfW3Ddc2yjcbrANfgmE/N/5vFt1HX4q5i
   5zF8lbt8N1EA4FelpHezQFVIwoxPR8Yhvv3Nl0+eAUHfm6BDB7dWAf1qf
   5qnkDiQPatj9Cw0HiW6Vnapy33rSJZufGN9V2OKIwN0KALnFqRbYUfSWR
   b8RVsEiGJFtp5Jk8JOqBd4x/AUm7uNhMWArzgB86m0bEU6ErkU0Ji1RWO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="408012074"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="408012074"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="776684808"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="776684808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2023 18:26:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 18:26:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 18:26:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 18:26:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 18:26:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhzQSUUHZB3OD9tPzzusRt/NKQnGz4jxAJQZAXayTkrWOEQ1D8XoW0w+7c34DamjdTW0zKChj3o/B6DErXYI3b1fDxWjmeqDTr/B4rbUB2Esw1/0002CZBku2XueHvz6pPFSd6P7c6KyklvFjpKhttMVJ2YQrblrVD4iJb+7UJKt65s3B3XAp9TkCp6sBFqNmAgzP0ltJYgj5d/2SOi0hFPOqUnZV7KreNHbUIeTbHMN/Dftz1zMZSj/mZjbPA+msExB1K8BeWrKxrjNACB3JZTBcIrxWHg4KhGnitPDO9AQ05RiCWRlIeFf9UnuaVlBYr51Bs0VRbnFsragium0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIVrM73HvDqG11PC6cXPwP/gmEA2A+pBgyX8PxiTFRk=;
 b=QQHAOPsp8wSPkU9vcu76Bxy6uFUf2VCRFryOcxXUUIy1tetWOwhU+TNN36m51MmMrGv/5aefBh3ZVbIqHbRveBvoDVro9VcqLqbqsrBFSNxhETjO336IQe5sLffyMhrk4WOhQCFkyzZC/fOn9OEgJPhK22q1aKKxZQuvGBjkbH1qsRlF5ZVzzRpM8nzph6QpntYkbghVH+ulgr8oA9W69damY8OiWGVQyiq8+K+zDKq7Ma9GgbzhKhREceS6lgziJT6uELqrOgYl0JWRhps5s3P7Rz6i4eq7Db2hEP38WswT1v0SAqU4F+TzERaXBjHhxbJxdgI/LuK9Ax56KZaI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 01:26:40 +0000
Received: from MW5PR11MB5858.namprd11.prod.outlook.com
 ([fe80::ae0f:cd9e:90d5:669f]) by MW5PR11MB5858.namprd11.prod.outlook.com
 ([fe80::ae0f:cd9e:90d5:669f%5]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 01:26:39 +0000
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
Thread-Index: AQHZaBxqLyldFWH+MUeQ1f1h2hb9AK8dsuCAgADdb4CAAFfuMIAAEHaAgAATPzA=
Date:   Fri, 7 Apr 2023 01:26:39 +0000
Message-ID: <MW5PR11MB5858999E104C21754DEB40F3DA969@MW5PR11MB5858.namprd11.prod.outlook.com>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
In-Reply-To: <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5858:EE_|PH0PR11MB7616:EE_
x-ms-office365-filtering-correlation-id: 7173f392-d0da-4504-077c-08db3707232b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgCfBDKMZ4sProPbAdqEg0lrSrPH4wId3YmS/OJ3wChd+CfwCECwRtmPIsr1xFhyO6mREvovDbGbyRvT7lcuHvaVH/DfFZ+CwBmcnyzYkSaal16KdYvni0ehBiOoc2AF2aOeseurxMwDamJKt4TgkOhWvcDRwjAFA/w/1FO/4Y7OZHJJ2vko5kMbR369xRTLhiexKVR5f237dlwwJBscMuf5iEe1jmd1mllXlxBo2NL7YjRVpMkXqnRKoLPw1gt0g3T3N8Wwr6iBijNLT26W/xTICM1YSAzCXTx4JdL2wEO4c7+FKdnxAPjs1w5vjoPSZNEvEpHHhWdXsm+gAWZt9aKVI3WZzQYxiBVS7Mum9wSRVylqvmswI5IWETpapB4d/9nezY0zFIW0YgVM3UhfMJyQbkr+WdVC3rgvRT8qrjJQv4hiFXdS7Dx2OQamoBcGSHTJSHgh/eGduhdqWU3ueKheY5ZwbU+f3K5pRxCPYhApCqLL8aQp8YRNbJ0ZGDfjt8F5CSNZHa+LrwYztCQS+Oduep6vpNEeM2weQkEr+7pX6Fb7CQ9SfXcKFkpbgAwlDSrZv1p414xUPLDI8InKc174prdmGRvuSeXc1IgqxFVEY8aR1geEqvcPmHa9ez1U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5858.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(33656002)(82960400001)(83380400001)(478600001)(71200400001)(316002)(7696005)(6506007)(54906003)(26005)(186003)(9686003)(2906002)(38100700002)(41300700001)(4326008)(66556008)(64756008)(66946007)(122000001)(8676002)(86362001)(38070700005)(66476007)(76116006)(66446008)(6916009)(8936002)(52536014)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0tA7fIEzefsdVDTwczVNO3q6JY5Jwae1wkkHKd5H3Wq01vppalTsDFPFDnQ?=
 =?us-ascii?Q?xxE0U9JaHZWH9ZMpqMAhBrbgdNHGNUhx+vd6TnHArKgNz9gQlP3AgpjiTYBG?=
 =?us-ascii?Q?BERxhzjt7fbZeorsLlZguGtX8xuEKZOMy3sfVcAC89M00e+FOIdpR8k0WBYk?=
 =?us-ascii?Q?QdobodmWzY3V9Oh4FZWDP7Xsuu8O5MgJxSLfARWVxDrRUF5BEXo0GjwXJ/ke?=
 =?us-ascii?Q?7hG3yXSmOoo+5RqtsRMzXjCul10LJoi3L5GO9h73jjdPbP09ywxxn5c33PzQ?=
 =?us-ascii?Q?p2gcDZjoZNKJhcNvKx6QtSWhg4jkh6Q30Gsm1PLqrtMg7kzjKEOqQSu/Onpn?=
 =?us-ascii?Q?2s0iGiQwDJC3T+DwnYXMhu0vfwHxz0KgE3pHgNEk7kds3RVsa8kn8Nv7SF/5?=
 =?us-ascii?Q?eWv7pIuPbSAEmxrpmhgQea+PJH1hT1LyduYe4Y3hrDI+pyanv5HfEnQJ217a?=
 =?us-ascii?Q?LChMx8WIhqPj9Y3d5F4ExMaufFefZd/hBNUU7gx3LgBmyV3kWVAo/KK1nnw6?=
 =?us-ascii?Q?gNu+MmkQFMyURzzXkFImCtuMwhO8o3lAm+omm7uRxV7elwgBDM5pJ7u9T5lf?=
 =?us-ascii?Q?JP/CN8LFZff9sggcgjcS13CZv+5OfaPYg55F2IgLc66xCBXz1ClucIoIsMSH?=
 =?us-ascii?Q?VseWjmq8iPffJwLxel7bSL2TvYWUxp4nZDVzaX/h3p79FKd5PRS+MQpPwMI3?=
 =?us-ascii?Q?g7ajfQvygCU4MGws9XZVjMJkvSB0o2PRm94dJfjv/DlRmRGhBG9+4SZjAY9C?=
 =?us-ascii?Q?iAMN8QdKzUS6rqLogSiWhcNTCahj/KMSrZy/uialYFEgkaCQ+Qj5YKmA80DU?=
 =?us-ascii?Q?SQrTu33hByfyo+tlwe/zvLSsK2RiYF83/eIqaRdi5rXHNqidDuHOoy0OxBKm?=
 =?us-ascii?Q?6+C3c3iy6mEI1N7z/AHbws16w5ITHQpVuQ564ukEoRwL7zPvavkHxNmtd10x?=
 =?us-ascii?Q?tFKzq56bl+PRSsSyFlL+1x+DKqQJqNjobn0SS8JeA81ArSPPWpHOB9QHxLAA?=
 =?us-ascii?Q?CsmCHzWZNvw21ZctQ/gdtoik0eNMcNo/V8WcV9GWPJjGTlXKfFhr/of3rXOD?=
 =?us-ascii?Q?uiRbqACFefuqG7hbL7wmPwn2yIOidM0Qh5PgwK/IjNJDbPJab+Bd4Efhvr8S?=
 =?us-ascii?Q?btDyUjLKZvGOAQz73wj0F/sDjAZvbNROFJRFXjbEi7FhfNI5l3nDZ0/ZCNfS?=
 =?us-ascii?Q?kbnthQRXZeub5T2BX0wmseZVd66v7mekmb+rXfipVbY24XlDU1Fw9NIweIlb?=
 =?us-ascii?Q?RWgJleTQZSaYaCSp2mvwPy7+RCVG1xl3f5X3g3YCOSKnFTNLqbAmqp33Tc5g?=
 =?us-ascii?Q?OIu40NZ8IN5p8s9j1OKlU+JPUL16RVFY6RyeYrQsNlk5AElfnynTpKoYB1uW?=
 =?us-ascii?Q?8TT/BBMzgrdBPDMDnUweUQwY5GpgCSXLivzSF+Vmvu+egL3TGDMP1SQrFYFP?=
 =?us-ascii?Q?bFbTg6W2ljl8q+GTLf0DkpUHo2dNEb9Npz4dpV7++Ne291S/7RMhacrpH9cM?=
 =?us-ascii?Q?xlqAiayjF3TVshGAcZHuj7aNymMhpQAoSWv9lRbzIkxchivyj09a2KXR6vHG?=
 =?us-ascii?Q?wKBDm3oAa6XghOuVJSfW1IEFMtleywtBNFK/RIHZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5858.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7173f392-d0da-4504-077c-08db3707232b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 01:26:39.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2K8a43kq8WhwlHo/0WDbnbSKnLlo7riGSBo9jrtN8jmvT/GKh9V67NN11pRs6PytCKR81qrG2xsKZbVz5gYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > cache growing.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  kernel/rcu/tree.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9cc0a7766fd2..f25430ae1936 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2907,6 +2907,8 @@ static inline bool
> > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >  	struct kvfree_rcu_bulk_data *bnode)
> > >  {
> > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +		return false;
> > >  	// Check the limit.
> > >  	if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
> > >  		return false;
> > > --=20
> > > 2.32.0
> > >
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >
> >Thank you both!
> >
> >One question, though.  Might it be better to instead modify the "for"
> >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> >of starting at zero?  That way, we still provide a single page under
> >low-memory conditions, but provide rcu_min_cached_objs of them if memory
> >is plentiful.
> >
> >Alternatively, if we really don't want to allow any pages at all under
> >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
> >to zero (instead of the current 1) when the krcp->backoff_page_cache_fil=
l
> >flag is set? =20
>=20
> Hi, Paul
>=20
> If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () ret=
urn false,
> the allocated single page will also be freed in fill_page_cache_func().
>=20
> or it would be better not to allocate under memory pressure.
>
>That was my thought.  ;-)
>
> How about like this?
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9cc0a7766fd2..94aedbc3da36 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2907,6 +2907,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>         struct kvfree_rcu_bulk_data *bnode)
>  {
> +       if (atomic_read(&krcp->backoff_page_cache_fill))
> +               return false;
>         // Check the limit.
>         if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
>                 return false;
> @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_struct=
 *work)
>         int i;
>=20
>         nr_pages =3D atomic_read(&krcp->backoff_page_cache_fill) ?
> -               1 : rcu_min_cached_objs;
> +               0 : rcu_min_cached_objs;
>=20
>         for (i =3D 0; i < nr_pages; i++) {
>
>The other question is why this loop does not allow for any pages
>that might already be allocated, thus perhaps looking like this:
>
>		for (i =3D krcp->nr_bkv_objs; i < nr_pages; i++) {
>
>Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
>seeing this, but I do feel the need to ask.)


The fill_page_cache_func() is triggered when we invoke get_cached_bnode() r=
eturn NULL,
this also means that krcp->nr_bkv_objs is equal to zero.=20
But if can_alloc is set,  we will unlock krcp0->lock and allocated single p=
age,  after that
we will reacquire krcp1 and lock,  but the krcp1 at this time may be differ=
ent from the
previous krcp0,  if !bnode is true, also trigger work to invoke fill_page_c=
ache_func(),  but
maybe the krcp1-> nr_bkv_objs is not equal to zero.


Thanks
Zqiang


>
>							Thanx, Paul
>
>                 bnode =3D (struct kvfree_rcu_bulk_data *)
>=20
> Thanks
> Zqiang
>=20
> >This would likely mean also breaking out of that loop if
> >krcp->backoff_page_cache_fill was set in the meantime (which happens
> >implicitly with Zqiang's patch).
> >
> >Or am I missing something subtle here?
> >
> >							Thanx, Paul
