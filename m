Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3406CB323
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjC1B2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1B2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:28:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F01997;
        Mon, 27 Mar 2023 18:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679966885; x=1711502885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=79nSoohHIK2XRM3gwgIAPJ9WTTJHRUWr0/i3w0IfkpU=;
  b=NPeKwfxO8PhYUyYInAUJQEErgBqPUiqqOWcJ9v8YN5cMlKq5O2Vfzfku
   ByHXJFryffaVHRZ7sOn/7gn6ZC00cTSSfEThgzRmkUS7F1+92MhbcLUAF
   W4ZLT0l7seCoPUxSKaqC3NgAR9+hlGfefjFdpttjHEMo5wcG8Pgw6WZZE
   JiY9alu4UK+0V/fyQiMpmoTm22/6QJY4kwTZbe7H0NBmlwvCo764joRED
   zaf64m2sQru71C2zIyXm6Nqbh7AIvBK5vEWXqU6ttGboN/AxGSGk5HZW3
   ggmXdvp2EMlQh5hT3RnN1xzIKigor7vW2/at2g2qNZg1gwlXOCFRDLodh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="426702511"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="426702511"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 18:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827261846"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="827261846"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 18:28:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 18:28:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 18:28:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 18:28:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 18:28:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZal5uYYVjkpwFXHPFv1lYXF/y7b/uw+fvzEwru23p+JhsqbdF+o82CpEndocPmuazDFwAnZ+0OQwfB+3ww06xeFuqqnNx/8DVExfcspgmQZYh2aDZEM7/+J4YAdzjL/auWcR5Mdvif+pFOaoNVUt8aMDRsNXcylqtUTVEdTDVrg/X6HGNC/of/BeT86uCfj40Jclpk95ssA/SMI5yihoHz9N7SuS8Icz/bfw6eBVruxq3YzVPScLiyg2cmh199V4DZgxnCddGSzPyOIB6qHo9DyO59+1zG5eLHgwqp2JGBR4x2XDjECo8xSXeAytHjB3okxnRAqWDy4yuzLAaMLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NQK6UWCahLQc4L/1/1nvyEJwpeRGVVle/kSeqjIJpY=;
 b=GnEPFQLfUOHK6VA/5/9QmoDTgkH6eKadBitD8ky9PcPlLEk/kSM7jl1/y1DQTCRFw67Gp1WQ9RZpMSIesnu6VxyCsXQPCZbV14XMLz0QdaEqnFXB7dBrv943Zca21WdBPqyVVvrcxtQxMEdOZNkvy3MxkHrin99mhOxuwe41UM+ghGOvdPg2It+JuAeZz8Z42loIKyojlapctzpaWhZafCM+MrQyebAR7JdCO8RYlx4MtDLrAO+tq4s5k/Mn1lZxLU55BO4i/twI8o5js2jJjPe5yQse5KIDbo3uIHZJqOGdqsAf/hUtRcjppQPt5JGkGUPn6o1kRKM/mQsSVw1l3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 01:28:01 +0000
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53]) by SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 01:28:01 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cgEn1/2PZAki4vZrvu1Ahi68FQZQwgAAWuoCACdu/AIAAAKGAgAA3iiA=
Date:   Tue, 28 Mar 2023 01:28:01 +0000
Message-ID: <SJ1PR11MB61792EA18F7F2BFD1E70916489889@SJ1PR11MB6179.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
        <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
        <ZBnKKZsSpI8aAk9W@pc636>        <20230327174844.15305988@gandalf.local.home>
 <20230327175059.1e8584cc@gandalf.local.home>
In-Reply-To: <20230327175059.1e8584cc@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6179:EE_|PH7PR11MB6858:EE_
x-ms-office365-filtering-correlation-id: 121a0576-d4bc-4987-b1cf-08db2f2babc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZm8OyTb+5LPFgnYQ3FrXZS5+DqSaLnTSytRrt64dhqXAMRy3NyJfKf16NnGhaLaTzzaj9+dlQdeQHAr2+3SGUC9jiPSd4nXxloxHORuvuwC9DtIfZv4P8qD7ol15JmvLq3KpKf4D2hjk22eump9636dGfTNzs8YKDPi7kGk+AeWHsF6FLA7r6kzVxxQqnlpYD1/VQm3V9hVqO0bsytFoAZj0vw2qzF2frxn5QNSrXxbkeYlKlWJ/96kGU0j46PPi/NOszlK2sxEKT5s4my4LJZ46PcWbRDStVR/fdNl0O+Ef26B4VqWFIXTBLkyFFkHEr73/OssN7qU/BGhjsrWyM5SMCQKoGBcZQ8KvBhVgxJN5Iz8miUBvBzImDXMSpbYOVASfDlVmsbVpMMsPVK3M9tJ4ltLPxi/I176kuvNTf/9JFaYQFBa2KULQFnn8aPkF1Z9o4ZtWoGZMQ7sIZEgvpTrMV2bHHvfoyRlFM+YA6KJvN0WPUrJA/xsjWTQUENV2QzXHUG+/P03Ruh6fDZj7r08GmM73RzIU/k6NNftuFJZsp/dI9gu2Iurztue6pnHUErJ12vV2b+eLCAcRANR7GD+TAXGXUEI/deGoI6VgIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(54906003)(4326008)(8676002)(9686003)(186003)(316002)(41300700001)(110136005)(478600001)(2906002)(8936002)(122000001)(7416002)(5660300002)(82960400001)(52536014)(38100700002)(55016003)(71200400001)(53546011)(7696005)(38070700005)(33656002)(83380400001)(6506007)(26005)(64756008)(66946007)(66446008)(66476007)(76116006)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DmRYOgXmCf5nv9DhcrviyZkwRzseIKeIVb7pUSr04eUEH8pnVZvV+HPkLQ25?=
 =?us-ascii?Q?sUcl+fu4jUi9YfJRRhuTi1GYktbOzNablRqewdyWQVbX3WEc20hGV7K+7gdm?=
 =?us-ascii?Q?sMAT8zC6QPqrER0q4F7YJe74SvBTDN65WufWKl5flC620FK20U6QlRVUv79D?=
 =?us-ascii?Q?NWP9Aa78TRhOD8h9u7UZlAE8CCvryMzLUB73KUifWreGigcDKmpt0+Myi1PD?=
 =?us-ascii?Q?TOaECZ6g5NtpuFXsS15CAPr67+AF9yiFM6Q87F+lyo8QdaeyfJBlmKywskm7?=
 =?us-ascii?Q?RChxl6eLZI6PDEhMnqYSTxyPW4qczJrN/uJycQtwV1+ZxUPbCswk4esJRyPK?=
 =?us-ascii?Q?cOqWdx0wqo4iiWTT3G1Vs4vOivS93S+VHOz4+fsrJHkjo6XiBVhPWH8Fuzal?=
 =?us-ascii?Q?ma4GXnja94A2keQinMgnRKd+gwkzRdCc9h+7LKypOdec9JCgEmF5hqqeE2Yn?=
 =?us-ascii?Q?yMnfv/4NU6EgXPmjk0DdtkVB0He61/jEJhVi6hKztZlxCOgjG/Xd7as1SXJa?=
 =?us-ascii?Q?1kP0sNdssfpOhKsj1giaOeDZXqCLq/mFvy7GorhffY8yANiqx6kJDE4zk9/+?=
 =?us-ascii?Q?rSALVY3JeVQqV0hpPLditsbnAmCxLAQQ/XGZ1CPBnoowdDr0edGRLR16x7fs?=
 =?us-ascii?Q?d6NXYk4aYYaX8p3F5V6sFFGD8uIMh5XUSjOc5LpQUsduyUgpqn0iz4rKBVdh?=
 =?us-ascii?Q?G4ovsKh4ddey+xyZmlPm4FGTd21xXtURl6sCpRhA1P3MYWNKYwaW0woQ9QHE?=
 =?us-ascii?Q?Gp1cIt053TUs97q545/IDrs+74monymLiwYrzQQ4qnWuD2nYTbR1bk2XVd2y?=
 =?us-ascii?Q?A3iN55gzrLhftDfiVaRhItEsVkfx5pBzf1NurIoco0sjzMMoJ7ixEL4U6R88?=
 =?us-ascii?Q?LK20ZkeWpytNtIA0+Fa0gLNx8Jxu8bKQeHcEKNz6VaXmkf0OkmhnEJkgeBFR?=
 =?us-ascii?Q?ZbHmBzafXbGXGH8cQU72tWhZ4W44JePLSNMMEuYS2H+V8emBVx4ThWipr4Pw?=
 =?us-ascii?Q?Av75JxDlTd9Ypgmbn900vrpWFe5AXC2U78zA0xfYFRpxVJKq67EvZ4fMJ4WE?=
 =?us-ascii?Q?lOeJRdc6qiHr+WAbi/r39QrNxqyjpvCnp/n/4IMyLOHuZq9Lhu1JSr1f1heG?=
 =?us-ascii?Q?zGAleyiWKFtJWPRxgeRv/tMGjt1PFHZJvIGe8uJRZ/Nq88fxAucDsDaIXJ/9?=
 =?us-ascii?Q?nf6IhcHqWTXC3J3Bvx/lVg/bBxS59L9R9sw+H80UiDti/ERRJ28XUvzRK2oT?=
 =?us-ascii?Q?DrZIn+Ii0/2KlSdWy5VG//HLAK24UXWII4K8WKrr8MQ8E4iXQjh+lBorOjU3?=
 =?us-ascii?Q?o0yjmp/3wWj2QhAYbrxRdR6JQ+D5f+tmiTzwbgJF3WUxu8EA//B8AKJKPExB?=
 =?us-ascii?Q?bK4og2Qt/qdM70kmpppcY4v4uxXNZkcNVsp4EsD3efeV8lnqbqJKIMpkiDYK?=
 =?us-ascii?Q?eQQDQHwbKaNRp/PgMRvsPLZ8R2MMA+kuvIXxbc2AbveoPGX8nSBHn3geFqcr?=
 =?us-ascii?Q?y3EuY1nwy7Bed7NavFw15rRwcumZ1LPturVtYu+0WeQmdN+cEzksP8XxTC97?=
 =?us-ascii?Q?huaRnVxJAhC3dv9oeE3JzRkL0cugoOMKSg5ZFv/C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121a0576-d4bc-4987-b1cf-08db2f2babc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 01:28:01.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UczV5Nj45ld8tviRJwhifYUs9vAGzd/ZeYmOX+KT4I0zI2nqkDutOlS9FAwVi2vYMTDlO7EW+Zhr66dDI6gXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Steven Rostedt <rostedt@goodmis.org>
> Sent: Tuesday, March 28, 2023 5:51 AM
> [...]
> Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
>=20
> On Mon, 27 Mar 2023 17:48:44 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> > struct my_info {
> > 	/* store state info here */
> > };
> >
> > int main(...) {
> > 	struct tracecmd_input *handle;
> > 	struct my_info info;
> > 	char *file =3D argv[1];
> >
> > 	handle =3D tracecmd_open(file);
> >
> > 	tracecmd_follow_event(handle, "rcu", "rcu_batch_start",
> > 			batch_start, &info);
> >
> > 	tracecmd_follow_event(handle, "rcu", "rcu_batch_end",
> > 			batch_end, &info);
> >
> > 	tracecmd_follow_event(handle, "rcu", "rcu_invoke_callback",
> > 			invoke_callback, &info);
> >
> > 	tracecmd_iterate_events(handle, NULL, 0, NULL, NULL);
> >
> > 	tracecmd_close(handle);
> > }
>=20
> BTW, none of this code was actually tested, so I may have some syntax
> errors. I just did this straight from memory, as it's so easy ;-)

Thank you Steven for sharing the libtracecmd-based and libtraceevent-based=
=20
methods for trace parsing. Good to know this. This should simplify the code=
=20
to parse trace logs. Pretty useful for me/us ;-)

- Qiuxu

>=20
> -- Steve
