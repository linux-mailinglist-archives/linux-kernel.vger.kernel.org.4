Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3E67A48F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAXVF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAXVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:05:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93D2685
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674594326; x=1706130326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w5xykuEQmVZ6L4fGKPaJN3832BTsMkOMpGaFxJrUcPA=;
  b=W4fKlAb9ZuImp7e3hBd0RTaKvy+I1Cfq+WFhGG8pLLuHTNBceqSQKN17
   DUl1QWlaeQsUJZI5IkRh4maRhHxu3wWK02JYfQN++dzC5KlpQNJu5YLjx
   7d2DM9N+iu+GFoGTm62RcHTsAap37bAmpnrT/2xFjQ1AEFQ5YJ7r+jPX1
   vditu1heJhJJsceq3MtxPQzIOrgFwuIP/+9BE63DuslyMP/AoFYN1gF2Q
   78URiEYgj6ddtX7+9WFSOyrrpBaEZMmRODtcMAmp4pVXeT3mhKnmiOGZA
   73CbzkkVMTMJXxgoU8vzzgcgSuRixPjqhV1V97mb/PVdFsq5cvnVAdw+5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="326438348"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="326438348"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 13:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="655561648"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="655561648"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2023 13:05:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 13:05:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 13:05:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 13:05:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 13:05:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRcRvbWyEexx0Q+g3fFh7v2l/zHHStng0LMMXJqt5JGI4d6rHNhfDxsuOTRc4HH5/ojEsl6V2nInq935sRTYa4RRgdy+zqJeCi5w1pTvSoOr6KlB+nGI9/B4S7O4r6BosfTJgMx4wy7Olsg66m6kRR7ggeizxqii755lfD8Hnp4ZMIkMj9qKxZXpaNrkOv1/EVg85YT2GuDy0e137k3k7gXD/wF7DqWG8OCyjbDODW6CYrdYjwaa/0InVuplwvsg1beUtODncINmBEHHKVKEZ6It3BtGgYqkDvH5vNsCTfvHSyHlJ9fpCwNc+QriCz7w034sq6WrCjcoOsFievSSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7RBs00p7kBB2VzljoaJj4Q7Gf0W028OlEH7ogCbAos=;
 b=XDSO/s/soP6tZZea7Oxiv6ZYfL5Affrf/Hnrq0bI3GqNX5Fat9INaRPRxNZUBklny16Wm4awSXS59XCUohiDE53/xitTKVQt1R95e517UEboKqTzHiM5Fa3VnRk9vBwqigM0CHQ1YXQ+ql63CyrryomAcEEAVEFGbWWC3jWnkysMyotpIFraCzW+uKcECDw7JQdHSJmJSsIRDjGtaUQ7iB28Asq66/qSsFZZH9NoPOMxXVd8ST/35TIZ7IRz96SolxPXSt11RVCzmf/giy724UAQ4W77JuFhMkTrrInTNUIkykJfNHRn9S9fAgsxCc7B3C65OK8Ri1BoBqGo+4JJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 21:05:20 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::96fe:3ace:6917:1dd6]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::96fe:3ace:6917:1dd6%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 21:05:20 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
CC:     "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Thread-Topic: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Thread-Index: AQHZFlEZJH6tjCVKFEmIILQgXlE1nK57EG6AgAgnAwCAIt/bAIAIJZ1w
Date:   Tue, 24 Jan 2023 21:05:19 +0000
Message-ID: <MN2PR11MB409305204A36872FEDAD2B82E5C99@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20221222220214.3688774-1-tomas.winkler@intel.com>
 <Y6VV5d/V4MKDz2Te@kroah.com>
 <CY5PR11MB6366515D2A965EEDEC77AF63EDF29@CY5PR11MB6366.namprd11.prod.outlook.com>
 <Y8lt1gmo9smOMXD7@kroah.com>
In-Reply-To: <Y8lt1gmo9smOMXD7@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|CO1PR11MB4996:EE_
x-ms-office365-filtering-correlation-id: afaae480-b178-4385-5629-08dafe4eb36f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8relr+dCun4ESqaj1m9zT1/qKzts4Q/ASHHtT+R+T6yf3fS2HD2eICYzoq8vVfrtEyWdpsv7gMWQYYN/nggA1NvegDjvKGw7mliKHSqPgClROekVMJ1dTn5HcZU7WpLA2aVAjjrHDLNFbwLqLE398d83tqY7hdx/n9y3pWO4OKVCnzCt1A3rK4zcn2gg7ZFuDME6fO3raiJ0wqCMeenCuOPGt457y3OIGTHuWMvLyI0cFNKG+CVtPFCuwhmhif3CvjtsOhUuU0H7AMelXSDkMCKzzeV87iTaspcdXiNdR/smN6QUgCS3mB2DXofTX6c7aCyd4YKS/2hlwdZ81LkG28pZhBuLFuGQ3buGUEIRnHgzm+QENxhqxHjm+sPgK3otDWnwsUp3RatFJ/WVmHRNQi8o98MJtOwVSlz8G1K3CLIkksa57Ba1KdcC5Chfgoh2cmLBlcXqHFe5JysIgdOXrat/45vkYTdeuedZx9S0K2K3dyUN4Hv8ZYxb7TpGUapFrSz8kbUO7vpTKLrnE5t/XrqZhej7Iq0TvdG1wIkmObHeedIvZghXyacXer50r8Dv8bs7V/PK1YNDqwQ8wBkJYJgpJ1whKnRT7+Yrd6xbb/40jAHRJP9R8Y8o0cJsVdD97qo11QelKSWr66seuD3VUEiV3f6Gej8//zetpIRHay6dauAKOfr+ayZ2oha5jdGn2rd6WgWve2qYdUuXjXpvAN81A148xtId6YrTLCuUVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(110136005)(66446008)(66476007)(9686003)(55016003)(66556008)(66946007)(86362001)(76116006)(8676002)(316002)(83380400001)(4326008)(7696005)(53546011)(6636002)(186003)(26005)(966005)(54906003)(478600001)(33656002)(8936002)(38070700005)(122000001)(52536014)(5660300002)(71200400001)(64756008)(2906002)(41300700001)(82960400001)(6506007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s4DvKll5NE0TFnmuOAstvIeVSBVygwaedKaAF44v2csaqHBJlkuxXmEbwxFH?=
 =?us-ascii?Q?vMo+pvvV6r/uk1oQAz6Zn17KJ+4FfFGK9xNm5TtiHdlRH14+mnwfp2motgcv?=
 =?us-ascii?Q?XX+mS61IfI6e0s4dXvOeSU+88rFXNQxvelhpYCwQtAoeBFIsyokmqVW1CWqv?=
 =?us-ascii?Q?KveQWxNEDqH5XrPjj/ej7o5kuHAooc548O4Y9O80RHbEHezIH8Rd5T+tjQSD?=
 =?us-ascii?Q?eIP1GnayP1yQ6cmPvmSfKDAe6rAdi+mnJmRU+X0+LHvGNONZFXqfvH2vjjh/?=
 =?us-ascii?Q?dMJ/cYX+k+Lw9PE+Qgn2MzGTCFswayNNOlDNSC5Pjk4G+tTUs55LDwt9/xx3?=
 =?us-ascii?Q?ZBHJg/+PnqdWD2boIHvyONWjs3z1BYmoWhmtXfaUHYxDS/LLkC4dgmSsUp2X?=
 =?us-ascii?Q?CS8HTKxn7djKElGpzcbrgOibSRKeg7MQa8gSx5qWbPm790Km5rB5SzG2TuE0?=
 =?us-ascii?Q?s8AWNczKzj5o5EJBKDoRGN/RkWg6egA3VcsD7J3daGq392xQicdKjB39iNHG?=
 =?us-ascii?Q?8irowjBSzNpb37SDEqtmyks/z0Mkc6gO+ItCzb/XUYVDssQ5Gk6iqvJEromR?=
 =?us-ascii?Q?lilMI7jyGmIwgUQuT/1Eb6mC/tpqkz/qGbf+2bvYu1iDXVO3U25I9RK5eIGP?=
 =?us-ascii?Q?kguaYyWp27Vl1NdHbKFAHUOwvrW0BzT5b1myESAppdyOzb9uyIo7PcqeAho5?=
 =?us-ascii?Q?+NHgTtCq2QEmgeY+J9ybs759i4HqAoVnIWDpq3Ob47ooHyiYTr6TmBPdYuyA?=
 =?us-ascii?Q?Cf2Gnm/Vasxt9h0CcdA6HBUrxaq8ab48h/Lt1dZKmxbBlVopJmLh9k5LL/dP?=
 =?us-ascii?Q?vdOzYdu17TRocSEVxcIo4ccOUTfvYQOI8lydTwvctYTT1NGtkzmVFjFJf6JJ?=
 =?us-ascii?Q?Fa6WbJU9iSitAZhriEIUggq57bkyXcBWVwiUeAo3MRl8+Cq/cQ+c9rEUvbZN?=
 =?us-ascii?Q?3DAreMXLQNBQhI8mlzfQmcuYUQxbWQUBaJY+B3j1ydTzZZNf/0XI2pzwdlv+?=
 =?us-ascii?Q?Wnc73mB6+f29Pochc3YNLECq/MHBi4YezvNembrRzYeaIY/Gp0cPvVB7PuHp?=
 =?us-ascii?Q?vzuUZhRg77C5ltEsOFaCGujOHk2sK65CoIJVDSpjoT2hpUcp8OWFbbN1DUI6?=
 =?us-ascii?Q?gGjzUc/SJ+dFL3sb5/tIOzDFXSZeDplwIMznnB4EyKARSQPEzdNOuN4k7eTg?=
 =?us-ascii?Q?h0liKt9utVcAvmqv/+D2q9HgLLB03hKHj9AlXMpXq+a/2anzh5YTFgUhh7yd?=
 =?us-ascii?Q?oWPNL7UBwJg6SPeRFNaHxz8+7SFBd4FCqOL712l5kKwxu9//oE5JufM6oXxi?=
 =?us-ascii?Q?OL0DtPdEaAtx+oXjkPn8dXHH0v9boi8BJ3LQRdnxedAd/CUkDLfR+4ZNBxkM?=
 =?us-ascii?Q?QnqyE7b57nQ6XAPwox1ShvFVXVtitsoebeTQjp+Q7YRekcwKt5M2jcZ5LVXr?=
 =?us-ascii?Q?LzSEhwSsnQnoN/J0PWeD3TibsxMGcg9exKRkCUGIOli2opkzf+P1xtCUL4tz?=
 =?us-ascii?Q?zLFU12A9Hd8Re5D88/DpP1muesiFES0kb3xV7ywZ0LYI1p7dQ54hNmU3a0qD?=
 =?us-ascii?Q?G+q0WcyjS4uGD14pqm+Izm6S23kAUO/nXNLfz2ZQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaae480-b178-4385-5629-08dafe4eb36f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 21:05:19.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UodvT8CObg+VOoIWgZOX0NlLFRYBdEV/klMK89rh/6HwH7yaYmo4lK25ym0YMjPhzIuzGkSIljgdWl7/u4ttCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, January 19, 2023 18:21
> To: Usyskin, Alexander <alexander.usyskin@intel.com>
> Cc: Winkler, Tomas <tomas.winkler@intel.com>; Lubart, Vitaly
> <vitaly.lubart@intel.com>; linux-kernel@vger.kernel.org
> Subject: Re: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
>=20
> On Wed, Dec 28, 2022 at 11:46:36AM +0000, Usyskin, Alexander wrote:
> > >
> > > Why a whole new subdirectory for a tiny 200 line file?
> > >
> > All drivers for devices on mei bus have private subdirectory.
> > This one just modelled on the existing examples.
> > If you say that this is not a good thing - can put it in the main mei d=
irectory.
>=20
> Put it in the main mei directory, no need to split things up for no good
> reason.
>=20

All mei sub drivers are in sperate directories, this driver is indeed tiny,=
 but I do prefer consistency,
In my view it is easier to maintain that way.=20

I believe all the bellow stuff you've already discussed in ths thread,.
https://lore.kernel.org/lkml/YkXdgQH1GWCitf0A@kroah.com/T/
I guess all that was explained there, so no need to repeat.

We'll try to see what can be done to make it more robust and your comments =
are more than valid,
but as the thread concludes probably the component framework needs to be ad=
dressed.=20


> > > > +static int mei_gsc_proxy_component_match(struct device *dev, int
> > > subcomponent, void *data)
> > > > +{
> > > > +	struct device *base =3D data;
> > > > +
> > > > +	if (!dev || !dev->driver ||
> > > > +	    strcmp(dev->driver->name, "i915") ||
> > >
> > > I thought I had objected to this "let's poke around in a driver name
> > > for a magic value" logic in the past.  How do you know this is
> > > always going to work?
> >
> > All components that serve Intel graphics integrated into PCH should
> > check in their match that calling device is graphic card sitting on the=
 same
> PCH.
>=20
> And by looking at the driver name?  That does not work, sorry.  Get acces=
s to
> the driver pointer please, that's the only way you know for sure, right? =
 And
> even then you shouldn't be messing with things in a device you have no
> control over (i.e. a driver pointer or name.)
>=20
> > The code below checks that i915 pci device and mei pci device
> > (grandparent of our device on mei bus) are children of the same
> > parent, but there is no way to know if caller is, indeed, graphic devic=
e.
> Easiest way is to check well-known device river name.
>=20
> Again, that's a big abuse of the driver model, please do not do that.
>=20
> You need to rely on the fact that you will NOT be called unless your pare=
nt is
> of the correct type.  That's all, no fancy layering violations please.
>=20
>=20
> > All i915 components doing this comparison.
> > This is a simplified scheme of relations between devices here:
> >            /--- MEI PCI --- MEI --- GSC_PROXY PCH ---
> >            \--- GRAPHIC PCI --- I915
> > >
> > > > +	    subcomponent !=3D I915_COMPONENT_GSC_PROXY)
> > > > +		return 0;
> > > > +
> > > > +	base =3D base->parent;
> > > > +	if (!base) /* mei device */
> > > > +		return 0;
> > >
> > > How can a device not have a parent?
> >
> > This one should be proxy device on mei bus, so parent should be there
> always, can drop this check.
> >
> > >
> > > > +
> > > > +	base =3D base->parent; /* pci device */
> > >
> > > You don't know this is a pci device :(
> >
> > This is more, like, note to explain on what level in above scheme we ar=
e
> now.
> > It should be mei pci device for match to succeed.
>=20
> Again, you can't know this and you should never poke around like this.
> You don't control the parent of anything (hint, you just saved a referenc=
e
> counted pointer without grabbing a reference count...)
>=20
> Please don't abuse the driver model like this, it will cause long-term pr=
oblems
> for keeping this code alive and working properly.
>=20
> thanks,
>=20
> greg k-h
