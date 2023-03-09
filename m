Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB26B28E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCIPbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjCIPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:31:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433FEFF58;
        Thu,  9 Mar 2023 07:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678375866; x=1709911866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MiXH7diDABReGYt87xc0AiNkUesYiGMS9ub01+NxzTI=;
  b=NY6ZDFOjLRUncy4Thnnh8P9GPqMbBXfe3sFHSD4eD/5KfPlFllXxUAsJ
   XnA8O/yR0NonMsDhcZxq6Pa2cca+5hRvTWLm+quN22XiZjft++Wkdo12G
   JMolw7oC5o37T0Ux9v4qfJ9c975k1se1m6qOZB2llpRQ6KhD/5e12yVB4
   72sZTMg+ZcUUpRru1texqIx3dkP2evmEWHIDg9UVGw+3SSF5SVfrzMJkK
   3rMMhb9p6Tc0XsNbEumpLRwV+30p7RZZ/aDeztHhr640rM9SWh5aVtxkY
   PqMDkAXJSsrF6l7NwDCfoMPBgkIK5Q8tTiWTrQkVmLvMGq1t1sM8cW5PC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338827516"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="338827516"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 07:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="923289757"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="923289757"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2023 07:17:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 07:17:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 07:17:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 07:17:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 07:17:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLviD+kejtueQR1tpy5jAYwTj/Vye0JCVWdDV5/mJVFmwzCK8XeG6YBtt+WRF3+32QdNLVBDpaCPi0xFDzcXzxLAiqbfZs3aPykSHaCX5AaeutIo2RkrB6DvBVvoChf7iMR9eXgFtNqkTLP8NKMKL977wGdTAUL6RuhqltnFVRoAWz/Xcjx0apA0SetRqbwXyLmS0SahKw6OhDzMxitjHbQ4Ac5cunmmd1ntwvM45BlTkfPGL8SpFjQpWRYd4bOKwiheGFoNcFFca7WsX/Vo3Zm4JQOLQE1MzDD0e8OcKr0K1PDkMRW22nk61prTru0DYhpg2+W1Uohh7F6Dgz56gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkUrkVbXp+ck7JUFWS/+i/Ks4chTUajdAbn7oMO+X7A=;
 b=kJzNZG2/XoSQC2pHlyTUpapt+H850dCkAo0mOHzSY3+hCabdB71/nM10x+AUETONuEhSwR9PX+bAkacigKe89gx6Ryv1Mwe36cHLW58BtE6BNP52bQVPBdKuJ6sF2a93cMx3trH8Bq5D03IfYGJnMNHJuxTH6kPmZHGjhUj19ckKhwPUi+yVhYs+txmkKRc4ukIF9SXM7UW3I8NtCAFiqhn6lzfedsfFLMZ4bdFT/aV4dbHJoQV4NixfPr8+ZoHjUVJf2CrEadZwM1nQP9+Zk2LOiIWsb0HZfOIVqLPFJXipnWWLohn3WB/hfW+PWMiJV9ttf2W+v9uacr0DkZczGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 15:17:10 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:17:10 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: RE: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Topic: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Index: AQHZThiYp3MlrzfqvEWnd0vYLxlOHa7pzeSAgAOQlXCAAHskAIABB5EggACT3wCAAxGoYA==
Date:   Thu, 9 Mar 2023 15:17:09 +0000
Message-ID: <IA1PR11MB61714CDAF82F337B0A384BAA89B59@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230306144950.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB61710CDB2B6B47118832770E89B79@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230307152226.GG1301832@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230307152226.GG1301832@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SJ2PR11MB7646:EE_
x-ms-office365-filtering-correlation-id: c182a681-4191-47a5-eae8-08db20b15a23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afd9qsDiPFHJEaOSm3CC4Z1+/tTRvhsbvxFRlWN9KXZ8fIJLJpVCC4xy+WFvm0SRLOVc7D039hdwNRnD0eL7s0xynXMjyAwHLHb+8BQVc5mmIiQj+dyEIsYr3S/Qt9U5ifk0tJrxW2cbp+mmNwboN5WEIQBOeRiALSs2JS/TzE+huyWewXEEi2mCcv6QQ/YJ9jCcULrxBRDG8o8+NerVabMFaeisMW/F07y8lxSaRAMkFL1Q7LE21Ip6rkVwmwy8zYhI9OsOXJI8UIzxxpDf6y6Xa+H0xA/iWkqP2V6AAfz7ss1iDUTcwyRJ26Cqxdp20sbBotppRWD2PD++WOvRLp7IUdDir/pDKCiCJq6FHeB+XcwYTDRwMJzsZrITitn3VO+lNatIWifus2GEaMXYlhNt0t5L0UIGQR8dkpwnAbRBZLzbH9LvWkbno4AmxT6V6WHMxYJ/gDdGjjWcNT0NPDWL8iTCH3xWE++FqSrIDGZQSdoKa7Saiuf/Zb5PKBMjTwA7oh0XVmtgaOpuxipvirYmTcO9mYBmg2ajW2zrgMD2xP0dozzEhMJqmJYE1aeWmKuI+oNGXZwMVImobOtmXGawEEqaI9RARvP96vQnmCpj9abchfWQEKMsF0QQh6zdfneesk6jG1piB/DjV9HoLCCZJPf0EInrCbEeBMx7CuFwZU8yytBOqi0vYi8V2H1XkDBUEDT7XydYLiMJhdktkueRkwtQPORzW+5qDc2K3ts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199018)(16799955002)(122000001)(26005)(38100700002)(82960400001)(186003)(6506007)(41300700001)(9686003)(83380400001)(66476007)(8936002)(66946007)(66556008)(8676002)(6916009)(4326008)(52536014)(2906002)(33656002)(64756008)(66446008)(76116006)(5660300002)(7696005)(966005)(71200400001)(55016003)(316002)(86362001)(54906003)(478600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5dPi7bXSrryd1Pm7u3/aGrJyAXqubH3Rh4rJvVjc4B+xAaTVIn8PH6y79+J+?=
 =?us-ascii?Q?1+K3ofchtuWPoEpiL7jFBFf9Ltq92G689ZZFEOF+mCYeYP6KazVRfsFapS6D?=
 =?us-ascii?Q?LhIPsgcRjWcF3dxuvCdnZmHhCfbI/WVq3sK0VcMSvzVauUDhz/V9CpaMj2ay?=
 =?us-ascii?Q?LULoIowQpnu2qSCkFQVlBX6X+McuAJ+DwmW9EFrGTHOsFrugzx/0RUHndtog?=
 =?us-ascii?Q?WtLtzbHvmcc7iPhlfQFxl5N7PUvsk3gieqBys2m5XLv4LUpOoi3UQPKrJRwt?=
 =?us-ascii?Q?HemIp4bDck9axB28WifzcoHAki9FYJk6wvfWC26jYlBqie34F4uQz3kroYhe?=
 =?us-ascii?Q?FocurxLhe9l6/eTVsIx7sH4k4RnXCy8QeApyoRUId4DaygZ3jlGIRxtaQyEY?=
 =?us-ascii?Q?jhtv1VerLiAFgYgb5ohT93cp7Powd/2bntStwF+Q0Zpc6Tg0gDm+v/Vkt8Ua?=
 =?us-ascii?Q?TUYyvWKjuV/06QYCKLqrXl8EcuF4+ASmopJVI7txPuIxGLlk1SKhnaj0tr+K?=
 =?us-ascii?Q?e46nw5/+2wlxYOd2kcUzwNjQuuIXomXzx9Kv0MvPYK7DE+5INrioC3fCWYro?=
 =?us-ascii?Q?GBPhotEXCYOi3WGqxKlyRUke3g6KO0xT83HqxcPfPBO5yQmo7nwdjQCusqIN?=
 =?us-ascii?Q?/b6jmwFoWWXQ3BxAtvVILd7yEALjz+wjSRLI1hlckr0aOmpzZKoTECf7HTyf?=
 =?us-ascii?Q?qPYC74600Ze7RBuf2fgkQEWqXmLRNELmUoGBdK9SGtYyVhIt0okJwsqG8C+z?=
 =?us-ascii?Q?Ot11rvdG8z3X7lMYWGQ3N6zKLMWUOwyD2eti2AVLDBWhULJSXPgXJVuvztbe?=
 =?us-ascii?Q?+9RTcN86uArOEcTwNmferruFozVuipICccQYfqM8QFFumV0gbzN9Jba3N4Tp?=
 =?us-ascii?Q?gKTwhzThHH+o7GdtnmvG/Usb3PDK+HpoFruk3wNbLRW499MxNqtQgYkia0u+?=
 =?us-ascii?Q?9H9o1E9OnShu/gXMs93seRPT3neQt0mYl3BsXiyAhXRuOyFfV/6l/1NjB7bG?=
 =?us-ascii?Q?ypDiTfULTwBR7/8kdImoBstyosodfW+EhMJDuUB+UpvJrfL1Bdd5eOxpQgnh?=
 =?us-ascii?Q?9t74nMN20mODKnK24xkHwd/K2MA8Yn0BhhRwOJFr16Q9BL4AEO3+vzTDDGwx?=
 =?us-ascii?Q?WPSJ0ewqV1khIRR+Zhpj7hsEzKwZZz2kks9KhAXPTPM/GylCuqKlg2eGRmQc?=
 =?us-ascii?Q?tUznjHPo1EfimXzGGqb3bBuSguNTj1mpZEqz06GNYx6vGxEhPHAOcBfgiIB0?=
 =?us-ascii?Q?pKyQfZcRjpGY4mWLxY0zvYXfa9mhbfWgLjzplPv4vWXT7rGjrUu1aY8eaNq4?=
 =?us-ascii?Q?FShBu+zfG/6a+SxwPlSxu9LlmP3QJ8bHgrnv9X2LDq3QmNKQx0vuPMg2C9Aj?=
 =?us-ascii?Q?mYdc9NGFt2gUe5VXp7PnDex8YuvEd9C2HUARCcIoVIHrRwqthfVnS7xCqr92?=
 =?us-ascii?Q?rLuSaGP9smw+vsAoysSESrliiIPLWBjuRRDEIJEfM43gzkT47brE4+AUdzmQ?=
 =?us-ascii?Q?8eQgpuXMwWTuIhTqPrcEQxNHng2q9MEKThfa08mvMJ0CXLqTPohrmW0psWSx?=
 =?us-ascii?Q?XlQ9ksLGHZeyaW1i6vTfVblz6AVgCyH+wuISxT6Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c182a681-4191-47a5-eae8-08db20b15a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 15:17:09.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fag8ZJNfHEyR5oGY63JizfSJpXSO9m5KJjgJjutz3a9AXgAlgDjmbvZuZXYws2WGjEcd2Qe6oQCH0e/OkvPy+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> [...]
> >
> > a's standard deviation is ~0.4.
> > b's standard deviation is ~0.5.
> >
> > a's average 9.0 is at the upbound of the standard deviation of b's [8.0=
, 9].
> > So, the measurements should be statistically significant to some degree=
.
>=20
> That single standard deviation means that you have 68% confidence that th=
e
> difference is real.  This is not far above the 50% leval of random noise.
> 95% is the lowest level that is normally considered to be statistically
> significant.

95% means there is no overlap between two standard deviations of a
and two standard deviations of b.

This relies on either much less noise during testing or a big enough=20
difference between a and b.=20

> > The calculated standard deviations are via:
> > https://www.gigacalculator.com/calculators/standard-deviation-calculat
> > or.php
>=20
> Fair enough.  Formulas are readily available as well, and most spreadshee=
ts
> support standard deviation.
>=20
> [...]
>
> > > Why don't you try applying this approach to the new data?  You will
> > > need the general binomial formula.
> >
> >    Thank you Paul for the suggestion.
> >    I just tried it, but not sure whether my analysis was correct ...
> >
> >    Analysis 1:
> >    a's median is 8.9.
>=20
> I get 8.95, which is the average of the 24th and 25th members of a in
> numerical order.

Yes, it should be 8.95. Thanks for correcting me.=20

> >    35/48 b's data points are less than 0.1 less than a's median.
> >    For a's binomial distribution P(X >=3D 35) =3D 0.1%, where p=3D0.5.
> >    So, we have strong confidence that b is 100ms faster than a.
>=20
> I of course get quite a bit stronger confidence, but your 99.9% is good
> enough.  And I get even stronger confidence going in the other direction.
> However, the fact that a's median varies from 8.7 in the old experiment t=
o
> 8.95 in this experiment does give some pause.  These are after all suppos=
edly
> drawn from the same distribution.  Or did you use a different machine or
> different OS version or some such in the two sets of measurements?
> Different time of day and thus different ambient temperature, thus differ=
ent
> CPU clock frequency?

All the testing setups were identical except for the testing time.=20

      Old a median   : 8.7
      New a median : 8.95

      Old b median   : 8.2
      New b median : 8.45

I'm a bit surprised that both new medians are exactly greater 0.25 more tha=
n=20
the old medians.  Coincidence?

> Assuming identical test setups, let's try the old value of 8.7 from old a=
 to new
> b.  There are 14 elements in new b greater than 8.6, for a probability of
> 0.17%, or about 98.3% significance.  This is still OK.
>=20
> In contrast, the median of the old b is 8.2, which gives extreme confiden=
ce.
> So let's be conservative and use the large-set median.
>=20
> In real life, additional procedures would be needed to estimate the
> confidence in the median, which turns oout to be nontrivial.  When I appl=
y

Luckily, I could just simply pick up the medians in numerical order in this=
 case. ;-)

> this sort of technique, I usually have all data from each sample being on=
 one
> side of the median of the other, which simplifies things.  ;-)

I like all data points are on one side of the median of the other ;-)

But this also relies on either much less noise during testing or a big enou=
gh=20
difference between a and b, right?

> The easiest way to estimate bounds on the median is to "bootstrap", but t=
hat
> works best if you have 1000 samples and can randomly draw 1000 sub-
> samples each of size 10 from the larger sample and compute the median of
> each.  You can sort these medians and obtain a cumulative distribution.

Good to know "bootstap".

> But you have to have an extremely good reason to collect data from 1000
> boots, and I don't believe we have that good of a reason.
>

1000 boots, Oh my ...
No. No. I don't have a good reason for that ;-)

> >    Analysis 2:
> >    a's median - 0.4 =3D 8.9 - 0.4 =3D 8.5.
> >    24/48 b's data points are less than 0.4 less than a's median.
> >    The probability that a's data points are less than 8.5 is p =3D 7/48
> > =3D 0.1458
> This is only 85.4% significant, so...
>=20
> >    For a's binomial distribution P(X >=3D 24) =3D 0.0%, where p=3D0.145=
8.
> >    So, looks like we have confidence that b is 400ms faster than a.
>=20
> ...we really cannot say anything about 400ms faster.  Again, you need 95%
> and preferably 99% to really make any sort of claim.  You probably need
> quite a few more samples to say much about 200ms, let alone 400ms.

OK. Thanks for correcting me.=20

>=20
> Plus, you really should select the speedup and only then take the
> measurements.  Otherwise, you end up fitting noise.
>=20
> However, assuming identical tests setups, you really can calculate the me=
dian
> from the full data set.
>=20
> >    The calculated cumulative binomial distributions P(X) is via:
> >
> > https://www.gigacalculator.com/calculators/binomial-probability-calcul
> > ator.php
>=20
> The maxima program's binomial() function agrees with it, so good.  ;-)
>=20
> >    I apologize if this analysis/discussion bored some of you. ;-)
>=20
> Let's just say that it is a lot simpler when you are measuring larger
> differences in data with tighter distributions.  Me, I usually just say "=
no" to
> drawing any sort of conclusion from data sets that overlap this much.
> Instead, I might check to see if there is some random events adding noise=
 to
> the boot duration, eliminate that, and hopefully get data that is easier =
to
> analyze.

Agree.=20

> But I am good with the 98.3% confidence in a 100ms improvement.
>=20
> So if Joel wishes to make this point, he should feel free to take both of=
 your
> datasets and use the computation with the worse mean.

Thank you so much Paul for your patience and detailed comments.=20

-Qiuxu
