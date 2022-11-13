Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5F626DFA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 08:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKMHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 02:05:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51613CF9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 23:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668323113; x=1699859113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zRo1qSuBSfig79cqNgidC7KLzN43yhuZxxbdurNbX6M=;
  b=eO8u26EvMQnP+IvpAoLR8xJt4H++SJFZSJ6frvs5LARaroeQhzSeByLf
   5nlzBMKTq9NddUW/JKRMdOLWfuahnV8UNCpk2Y0/BMvpSLgthiqu9AZI/
   64jKtO5ttMKPyVYO9zS8BLgvCTCNHfHm+J0AwaLFdQUKKa5imCqwn+kC7
   76Y1+hrljlkeB5dFl3jjEifMxp9DSKuWDeVmbqXTzo2Kgat0crrGIdaKU
   gMdSUDVkQk4CXM3lxNsb4vY6xDUxRNn9FNJcvIcyh1ks3g28ECroWKoON
   YipLyi7pZQKWoicODuHhG/7XAzkBHotHtWiVfpn4n4uX5acBbEvGw5MCK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="311794288"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311794288"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 23:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="640399695"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="640399695"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 12 Nov 2022 23:05:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 23:05:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 23:05:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 12 Nov 2022 23:05:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 12 Nov 2022 23:05:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgsakffzlwYlMHQhkdw948s66N64KzMxnighgEgGoZ9CNm29P8QWJbSEFczpz60RZJ/Olo6RfiBxSeg1LSeHTOxXMdj592nRXtm80J4hV9b1LWUmR+141NiVKskAUW9UxhaQxRg1g4wYpqF82Hl6d42NuICd8jfzchWNfCWNSSg15Zm31NBzm3Lmf8dTyH1ztzoPrnP6xA3sLibzHbI1klXymxasqyRdKpNLj9BmMN2wmUeTVat+yDW586hl2h6JAP4IhAoqENTAtrmoVdigccbkaLi1IPtfL+nuWvjjDJdv/5F5Sa3QOHpXdwB2N92sE7MvXYWlk65A/g89SPlDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZW/ly8mo27y9dc5nuWvkzkb1BRqbfzyJ8kEh8DbTqI=;
 b=GMx7eGRMGleTHkJ6U0zJxo33Orh5LecEYPR7Hx7/GruY71kNTdG9zb20kqbw1kC6I4aTvZRDaqQHXjpjNr2E9ivpI9EfD/Wit+arIKVViXN4ZrUSA8hq5NpBVMFZd5XFOLNSGEMGFPCfLv9w2zIOfssOv2OAyp6cnxfZQivCH/xERnzIELBbamt5aPa/HfozzTciBFgYNrsN23GKF3k9gMXENo25dDXH0R3Ga7gKn1nTBeKBGxxT0G388YsiIsRbv8dWQcXkQeD3cWwBk0h4A6xmABpCBA3dd8loza4VPZfFzlQbThkJzagRzH7QqyGQf4Pau726vrVirM0dzcYvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 07:05:10 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6ea8:4558:aa7c:3814]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6ea8:4558:aa7c:3814%8]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 07:05:10 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: add timeout to send
Thread-Topic: [PATCH] mei: add timeout to send
Thread-Index: AQHY75zCmrcWaXhqJEW1+xvdOvftn64zIxCAgAlYx7A=
Date:   Sun, 13 Nov 2022 07:05:10 +0000
Message-ID: <CY5PR11MB6366C939F72EC1D38372612DED029@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20221103155534.1966589-1-alexander.usyskin@intel.com>
 <Y2i+tY2tZzQnUFKC@kroah.com>
In-Reply-To: <Y2i+tY2tZzQnUFKC@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA2PR11MB4843:EE_
x-ms-office365-filtering-correlation-id: 23d2a83f-0a21-4f63-21d5-08dac545675b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6H9cwHod9hChhTFu3o2d7h/fV6geOwmQ98EZcyg+pdFjHqtm7MPvF9HsWF9MaG8uaYG9bBBhvOxPhLPsThsQpjvqonahHZkBa7jR+dUrdiMf+5fDvXOdocnk9yvAQ5GkwthhJvcslnfrXTHPjcRXylE9B8EXThvn1SzH6ZG7Fh9VapMw9mhAn2nDskCGhN9Lw+7HBPLG5Hhuhzei66Es2zzO/6aJZgIicBlHZH4Z3a2bFyvwFT759HUAmuXnWZ2mARjh+FyzQ0BRXxMoHxwMUQ3KtyRGRifTpDeqtt3DZg0KUpAEZ6/Jy+B13wamBd/qg8J33aXDrzkkvBwm0Bdg1hR17T/BU9j6Frxy2mbLOrWCen1/Ja9mmL/OyVl8VWoIhtUJ7IYPd2Nz+o+fQlWbJNx3XQKB87eJDA5Oimk6ue0kw5TWmD/CK05BXtbnc02pPjZm0VjIufsGALzDIfo+T0UIQ+V4TeQFtPDEhjYjlOfgGlw3/gt5byJMqRbS9Wlunw4xPy76oraD+tAIQP5ShiDhy92VhtIeuX+DlXmWbDRnLv64R0U11jrgReVGSxBSI622XbK1FG2Ul4IzehFz15NEFlQrWxNeqCiOg+dLXYyRdfzjGPUKnkTxg1NtF7nU1UPqMRpaO0bpj9Bbit+0zYRqXsa8fN7O6qKjV9pNOb83CxaEK6/fxhLZyUyB900LogTQmG1pwNZKsJ9saR+2efODE5ciuzBLIUbH8S8WzGzUhCGEBaRqtZU4AyatWh9WxkPpVq3cuZIm4d3PPPetFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(26005)(122000001)(9686003)(4326008)(71200400001)(316002)(6916009)(86362001)(54906003)(55016003)(82960400001)(66446008)(66946007)(64756008)(66556008)(66476007)(2906002)(6506007)(76116006)(8676002)(7696005)(38100700002)(478600001)(33656002)(38070700005)(83380400001)(5660300002)(186003)(52536014)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TZ9UEAuJy/3mZGnmL4vu+1k6SG+lIV8FIesOLD3Ehu8rkpbPihyGDYw7+pM5?=
 =?us-ascii?Q?IxmBy6bICNWUiGLbttwodyjUSeuqfI502OT//EO3Mr2CZC9XXT4WdcKrEM7i?=
 =?us-ascii?Q?cDyTUow38yRBB/uU8zR9+/Ml88HVEhPnW61o06I++mO+yGRxQITy0FH4UQHu?=
 =?us-ascii?Q?AOTWMGAfzazIUti8d3FGSkaS1VXU/ad9nSJpVZ1oGPlHRiA8iTyev5YiwrZj?=
 =?us-ascii?Q?yBJXf3m9MCDxdH038anoQBNCeFyr/JMomql/SfJJdhBTq8B2QyGUD4rHkn1N?=
 =?us-ascii?Q?i6XpcmdO/cvRrxHZzNcDuhNC2hlMWwxIEUwM9szFk0l5cIxwiyDOg48LL5OC?=
 =?us-ascii?Q?c8785NXuyyoOrkYil0VwN60d3AnQrUMTYMvTykMjtFKNuBm7Bzr8FRgP9eFR?=
 =?us-ascii?Q?fP47eJf5dBXBLdXzw4A0gou+jLPmYZdEzL36LYuABMgWOXHjEY37qYc7zXFr?=
 =?us-ascii?Q?sQT5nMWe2/LkPiUla96t7VYEpp4Tt4jF3XIlgR1gHg1nuytqlLQdIYbKK6V0?=
 =?us-ascii?Q?Uaa2JjDRQJM/hdhTaoiceQQa0UbOcMuP7IkEbxlzFKZ+MuGY27JOfZ/WABGj?=
 =?us-ascii?Q?IGjBAM0+22NCcPU8Xs1KhV89QSOCLJw1OnYb8uIJ1LxzRtcHaHDF34O9SDGL?=
 =?us-ascii?Q?zHADE8NFqEKAhtm0UZEp69idcCfSDdgSLziOcncSEB5eLcZhNLFdyybabXAu?=
 =?us-ascii?Q?PI4NXaGMHKy72sGE3UZ//4UdtrsAOruBL/RscPBd63wizEdWzhYYScLFMMnu?=
 =?us-ascii?Q?zCYIXs+BY/Uy3XXIS20rV7+Edou3G8XDPteJdCcrNFcPmsZ56L1k5iBbWoQ1?=
 =?us-ascii?Q?U/vnua3robONnyUTzkqOqpMDI/I+L61Ju39X86hdIskjYDbJtLLb3vw6UZJn?=
 =?us-ascii?Q?so/6+ZhbOQ5nPoSydXgm98PltBEZrw2pU73sz4IFZI6shz6dv7EcbSe9kpEW?=
 =?us-ascii?Q?UvtKfuK3lT27O4xsvBS2gIt+llJxfxziu8iqo+FYFMJ/WIXKHv5rYHXuttA5?=
 =?us-ascii?Q?rFjVeAAgaVtKvdl0gOw8JN7JeCST8qv6wSjFQ03Xe5cPnlTHnw56by2VLL4e?=
 =?us-ascii?Q?vWzSHNeUU4yY1QcibgA8w5iWeQaAAQZIXkqdWP3WncPSBzeAHDOP3OdQaDfo?=
 =?us-ascii?Q?a7X01Ihfxg0IeyKGneIZ2ZIFYwC3soDPQUlEim7mdGrneP7Diq+PADQ//JhE?=
 =?us-ascii?Q?lPt8QoHdai9cGqou6QnNTbxBM4RdeHa12TmRV7fH/TMlKCeigyHb3EAcOrv0?=
 =?us-ascii?Q?6A+iSM/kAuAE7y4gtZpbgSiJiL0x3YzahN6zMXwJOsAPud2nB61YRfhtCit3?=
 =?us-ascii?Q?pf1IcIf3KZuRrlErt0t1jjFD69PT2HkMAIp4zZsYvQKP/skVp7jSqSAoW6Jx?=
 =?us-ascii?Q?Rv4mho7APsp6DEdYI5eoDUdZGcqeZM5D62bOzo3Y5N5K8fKEvQzfbJT0beKL?=
 =?us-ascii?Q?FkO/euG5I0gQciJkGcuH99gXoqF6cBqxOKsQL7zPAjxmK1TBUkcbnyHi55op?=
 =?us-ascii?Q?Y8bbHTEHVpSfGA9h93mufaCGfUiCmAkQcuXP3QcIIrSMR/jNZRxu5igUJMLy?=
 =?us-ascii?Q?dq37KhShcN66uPZiEo394jFUqTMjQMC1/8CRwshM2JT+8yxRqH+rY3gtEtGK?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d2a83f-0a21-4f63-21d5-08dac545675b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 07:05:10.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBQiDiKZjxoni5BoaQv+cTXBTfLT2vqnnZbcWicel36aUKLoeU0RdBC0C8BiEJyLktS/gMrs2gviT+4e0hYeasRfhmmUWvbUebjnBeVildE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.=
c
> > index 71fbf0bc8453..3174cad8a5cc 100644
> > --- a/drivers/misc/mei/bus-fixup.c
> > +++ b/drivers/misc/mei/bus-fixup.c
> > @@ -128,7 +128,7 @@ static int mei_osver(struct mei_cl_device *cldev)
> >  	os_ver =3D (struct mei_os_ver *)fwcaps->data;
> >  	os_ver->os_type =3D OSTYPE_LINUX;
> >
> > -	return __mei_cl_send(cldev->cl, buf, size, 0, mode);
> > +	return __mei_cl_send(cldev->cl, buf, size, 0, mode, 0);
>=20
> Ick, adding another parameter to a function is not helpful here, what
> does 0 mean unless you look it up?
>=20
> > --- a/drivers/misc/mei/bus.c
> > +++ b/drivers/misc/mei/bus.c
> > @@ -29,11 +29,12 @@
> >   * @length: buffer length
> >   * @vtag: virtual tag
> >   * @mode: sending mode
> > + * @timeout: send timeout for blocking writes, 0 for infinite timeout
>=20
> What units are these in?  Jiffies?  seconds?  hours?  Don't make us
> guess :(
>=20

Sure, will add mention of msec here.

> Why not write a function that is mei_cl_send_timeout() that has the new
> option?  That way it's obvious that the other ones are blocking, right?
>=20

Yes, renaming extended __mei_cl_send with __mei_cl_send_timeout and
making __mei_cl_send as wrapper to __mei_cl_send_timeout will make code lot=
 cleaner
and fix the not understandable 0 from the first comment.
Thanks for a good tip!

> thanks,
>=20
> greg k-h


--=20
Thanks,
Sasha


