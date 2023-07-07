Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BE74A9C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGGELH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjGGEKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:10:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE530C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688702923; x=1720238923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AMhW09oi+iN596sMTf1R2H2qkPNcvCplJHFg/o5p0aQ=;
  b=RfFrLV169hFfqR+AWshsOOLSvOlPcWp5p9DYh1wF1E3jOxwUIn6pbUea
   YDADbO0jJE3J/BQb06Qc6Gvt+syMGEACm8TGl7lvS6EnUH/dCxOhc4BuU
   WolxtE7c6PU9WhFlY5Ux77M4nUjfISNJLGCE2Hmcb0EJmBGj8GJ/92+iH
   RLoHFR1jxKDKVSM4SOBqw4MUumatcaAaYBmR9tXlkQdB299XsRpGCm5R3
   aVPXkGgGsVboO0rV5vfyqxcVqmyy6AfZbz6G6qMZfJW7b2O5Ds0Edp/Zo
   XMDRhV6cpPtQPq0zOwDeez8rU2USqEthtGfKbIX/2P/zZzfbeAhn2u/Hy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="450152635"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="450152635"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 21:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="843960277"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="843960277"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2023 21:07:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 21:07:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 21:07:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 21:07:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 21:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwub7NtORucE1/thuGkOB5X0Aib/lyeLsQ4ohaX8LyIgrCfOy6qtNV64E1Ipd+atLrUvurrIo6gZwADBvSCTYHaXdOr4t6YNSUeQY6rp3QleX13vHaiOgO7EzZ97gby31B8FrWzo53KCoXVvebeYad7ew/qGAqw95ppKLaxgKzIosRX/YTyw1Xvh+M56pctSoB6FIhcRdgKRF/8kWC1jN2F2znRe5wdiWloH44CxExbGjd15q9pZTB7XW//AQFq0Ub2pWEuHjXVhqryEzK+82g3bZwg4cuAfktgO6Z1xKxpq4hn+6SDONrVt0p00qAcusOt3wU/XcNcTGYWtrx9+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OX95u+27ryduJm9LsXInnZpdrN1ZgQMSkRr2rmEpwM=;
 b=WWJjC+95v45wgsEI9FDbojZps0ew9Tf8Mkl+K795p3qdvXAFNy+z/cvl9DQqec3iTlVA0E0kRzER6Dr48URVWKLDJOHpWQgLSGcjv6swlxsu1tdQ37TnNoB2lCyyG3neSJ6o/A7sd2G6i6jforkLRkW1LQtNHuD5EM5PhIfwMcIZ7Acij0ruCvSj0YLZ8I+YN+Qqs6kO78+petwMgKQkcNfV46m4w81jgr13G6L0tdv7y0Wt3EBvudO0LvGD6SIZmodP+p5/hmI4oLgeCF4cLTEigenbIJNd0bcQMjoy/YuZnKrg0AyhNfNdBL5UGsxiFQVt66iXpclSGbX7Zfr8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 04:07:31 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 04:07:30 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
Subject: RE: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Topic: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Index: AQHZr83AFvT4TTcrIkq3d3Abr5XF0q+sxk7ngAC/myA=
Date:   Fri, 7 Jul 2023 04:07:30 +0000
Message-ID: <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
 <87v8exgmot.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87v8exgmot.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA1PR11MB6122:EE_
x-ms-office365-filtering-correlation-id: e9fc3009-2acd-4cf2-8c99-08db7e9faed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BtiuIuVK7YKxx4zaXT31Ao5MJ1BIjUVz5t6+WwvI6u/N1TGH3HLQWKZfqfmYGHY8Xc9HaJSC5D/dr1dQT/pcRw/hZsB4H/bMv3Ga8YX2+BF2FOdVQ3QT4OLAXkAy3aavPzdjw2V5BynkN/K5kt6iHIZSQAu1xCfBxTz3EqZ5jhy0uaOwJ3bFp5s2O64Q7IE6YdF0ycQz497/IREfwS0JjuM3CXvEPihbtROR11Vc2FHz8Z6jr/76Z1ofNjAO5pAibDnJTBcfTd0v8Yj4ULIwdsF/S/iYP+HO8lklbcIQkq+UmWKAsXYRpyuWD20SFkH1xv8B3BTDOrehzPtA/oIJ8DtLG+8//XC1yTuc4iJF7cF0JTbn4jPPDPQBDC0RYE3Xr4p+NZ8tm/WNJHh6Rw1AMH577L24ezMinWQaK9i/wMZW/NR7aMaql7pdbkMSCh59tz4zp60OyLmTmRovKv2BgXpUER8Nv2Ph9d4L4xOqFChNG+6GR5MLlCBpqneAGLn/r78KvX1gKCqMdW0VdidT/VbQd1HXWQ4go8hMY1K2VvE5uUYeC9gJnPy+k9zDY4DYnk0xd1VYfCo6/Ka2F/iInH3zXz/5kEEpdm6cXH+6CcXTzZgGnZkmm7ngqPSDDqqT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(82960400001)(478600001)(71200400001)(7696005)(54906003)(76116006)(186003)(26005)(33656002)(9686003)(66946007)(2906002)(8936002)(8676002)(6916009)(41300700001)(66446008)(64756008)(66556008)(52536014)(316002)(5660300002)(66476007)(122000001)(4326008)(38100700002)(38070700005)(6506007)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kisK+eh5v+Sxtv0ugFa4reNMo5rVIvE2c6qlOW20f3ePDuE1JnWMVOaGj4V0?=
 =?us-ascii?Q?09j6+/H/UPQxXfbifzMqT5lqf/1WqUDRIGwUb/HukoEXGGghODl5AX++GB8T?=
 =?us-ascii?Q?lu4r05LDe+dkpekTjzgFdaXkHMEbb78N1XGeE3MnAyk5lDcWRf8/KHQAmYyE?=
 =?us-ascii?Q?VVTa5hLMYv1V02bPkNt4mnqQAvUrsf9Kb9j1SaKQTbvsqVkQPs4gDtweKVW3?=
 =?us-ascii?Q?WpA8kriJXDWRP9zUG+2eksOIsE7CdQ8n8uYt168MgfqshhdHT41ltoc9rmME?=
 =?us-ascii?Q?MLB6i4+B/DsfJVGofyVzeANYQZ5puFWucFZtt6r6MGCf4uYsB4bfKPdQYHn3?=
 =?us-ascii?Q?yfF2+8yVNceHkqA56By+64ho+6R1Gn9Wud/mMx2kJVKojLixMjQTHNFhEPNZ?=
 =?us-ascii?Q?OOMqoS0GP6kwEuxlKICoFkuCfu7WlJNdPwpKuAXFktm17c1PHNBBP72fpyiG?=
 =?us-ascii?Q?VKwYnmYSXMyQBvoFHLmeMPSE7Jbq4Xm4U2kQ/GND8O53L+7Q0DcMLOFXJy0g?=
 =?us-ascii?Q?Su0TrQO5BTexw5f9WXSJDupBKIg40jbbnmOMpsaMO+1/5YukiakaNeYkkGwt?=
 =?us-ascii?Q?oKnLdot5W02zumqUU4PzLg5YtpoqgWCx4AxRUiATC3VsKOYku5yMg2IqpDDd?=
 =?us-ascii?Q?sUDQ97qg727P73OwfiqH1O051J7EMbs28yfqTCfVKb3KI4VuUXZfdxHQ7x4M?=
 =?us-ascii?Q?hjpC25bsftpvYZlnamOTbcHFY1Y2XGOeGYQ+gsj6MhPRUpT+vrPgALD3ptFW?=
 =?us-ascii?Q?wt7uNuT2A6eSQSCJqm24QdBabHTQzImoK473EMHhY3TOjRlUMjF3gmTpJadW?=
 =?us-ascii?Q?WcSE0QLrAzCHMUChM4hOJdhKLUnQAI6eGKsYi5+uKqx43ZgOIbB0Iv5h67ec?=
 =?us-ascii?Q?F2fPMoheo/iHRG8LUj3k4JFeOs89gZqpH7t584243si92blh3hrWQ8soqj/Y?=
 =?us-ascii?Q?6kjV16uH2gbAM07gsSrjV+T4xSNZs9CLe5PXsEBT1hRvM+CXOAhhh3ybvNgi?=
 =?us-ascii?Q?ShF+NweM++EXj0ZZx2fELZykKhRDI6NR8xdvDLPp2yoQR72AlER1g3ZGW1W+?=
 =?us-ascii?Q?M0P2RUBtarOEKtqiQghNnSnni0NKRCJLRHYvhT0LqLieoagfYRYySPx+cR03?=
 =?us-ascii?Q?N01ZYPBUXlAopGcdtYQ/yCH8Bn01LjYejQY/8eFlUAvXo3iWcMsPY2ZOTKwM?=
 =?us-ascii?Q?8NEJ8oo5gkQPMdA+3aOMmV8OSK4Jce4i8uYBFVLvn6LXY/JgPTqIdF+R3ZJc?=
 =?us-ascii?Q?//fIVkU/ery81ghEbSnkYoCr7zp98hB7AltFhOcV+Fv+OqyAUmKwCMPAOU6f?=
 =?us-ascii?Q?IBGUq8nNLoS/1jqlOt//v4WO3ByjmCtGJetp+T4RVa7mSuKu/WhVjLxVF22C?=
 =?us-ascii?Q?IXVxGD1mfKsIQ26fXd+ZOyEENTMmRmbKIqP/y+pK48kqUIhTyBVGCn+12rxe?=
 =?us-ascii?Q?VTMadzGcZBi4zPmaMQVARpaPK4rbnoOKrJnaHVD2NxsMRMUcdRt3hM2IniSU?=
 =?us-ascii?Q?BfzbgKiv7274ClvfCKArirY8MSLkZEjhNhgM6egLrF3L8FbJdhjhinKczMkZ?=
 =?us-ascii?Q?r1iM9oJCrcSn8se6f4k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fc3009-2acd-4cf2-8c99-08db7e9faed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 04:07:30.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8i4xZ8UjECx8WaBhuuEi9xcZ+04AgEOxjx+dXLSYfAyAUsSzbkzoEYdzitlQqz3OynYQGg0ZMRdlSPo7sjd7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > When a null selector is to be loaded into a segment register,
> > reload_segments() sets its DPL bits to 3. Later when an IRET
> > instruction loads it, it zeros the segment register. The two
> > operations offset each other to actually effect a nop.
> >
> > Fix it by not modifying the DPL bits for a null selector.
>=20
> Maybe this is the right thing but this needs some serious comments about =
what is
> going on.
>=20
> In particular how does sel <=3D 3 equate to a null selector?  Is that def=
ined
> somewhere?

In protected mode, a NULL selector (values 0000 through 0003) can be
loaded into DS, ES, FS, or GS registers without causing a protection
exception.

This can be found at the description of instruction LDS/LES/LFS/LGS/LSS,
in section 3.3 "instructions (A-L)" of Intel SDM Volume 2, Instruction Set
Reference.
=20
>At a minimum you should have static asserts to make certain no
> one redefines the first 4 segment selectors as anything else, if you want=
 to refer to
> them by number instead of testing for specific properties.

Bits 0 and 1 of a selector are NOT used to index the GDT or IDT, thus
selector values 0 ~ 3 all point to the first entry of the GDT, i.e.,
the null selector.

Thus 3 as a selector is the same as 0, and it doesn't matter to change
it or not. But when IRET sees an invalid segment register in ES, FS, GS,
and DS, it sets it to 0, making 0 a preferred null selector value.

The sigreturn selftest sets DS of its signal context to 0 and then checks
if it's still 0 after sigreturn. And it passes. However if it sets DS to
any other null selector value, e.g., 1, it fails. For FRED, if we don't
modify the DPL bits, the test passes, because ERETU doesn't change segment
registers.

> As written this looks like it requires an enormous amount of knowledge ab=
out
> how other parts of the code works, to be comprehensible or to change safe=
ly.
> That level of non-local knowledge should be unnecessary.
