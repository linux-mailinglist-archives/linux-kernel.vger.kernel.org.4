Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEF5F7CA2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJGSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJGSBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:01:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83187C06BE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665165670; x=1696701670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+v1I4sW9Bc1ESZJuj+hzdplkQwZKGj1mRcyQv7Ifts0=;
  b=GpbfPHHnPB7/i5keDZS1O0xRiXRshZ1Oz+ZcnQNC8+fmDbISdtfIVM9A
   7Bmz5iNQKK7FI43AXp84ouMJJnhEY5sYX1cbhlAhk/gfpfmtep2Uz50zz
   pwa6S6Q34n9IodWXy5Bv7EC6gll8m3Z8eBKPrtke3kwMJv2594HXb57kr
   OVMSE1H9a3/QezPAPScVYJgtwoQ/34m78Jb//Bi+CsouscQZLZvuJaU1B
   Pn9w+jT9NTsDQo2Isxh1bDGSQBR6YYpF3pwglU5uq/Os/anEny/nTisdH
   kNN1xqizjvPc5QDybdju1mK8Gozw1oUI2TtNhK86w9bg8oUgcr8OobVQh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="390091754"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="390091754"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 11:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="870375862"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="870375862"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 07 Oct 2022 11:01:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 11:01:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 11:01:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 11:01:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 11:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm3XiWkFkI/Qlh3j46Y2zhI18YTjm+BKBNw7lsBMSyXiCO/guHTjxdOnK0e+TMHznGuAx9MBz8OzyxP18zxrHezBe7jE6kGB5QoJb3+aBseLu5eOHaq0LSOMnTQ+v/ra8f4TkBKnyuigrVZHA919Y81DYCuoN0Lj7HG5ROl2DHG1nCejRvxsNUxO+oPQpFStnpikXgizUaQXY3fhD5ZSX03F2gc2uIyOzIrr8b3XzK2Il2NAaEyANb1XS9XbsMPe2ou1KBYOxbiNOzArq2T7ifh1h6uOdtz+8p06BwYWMKBTlKh/7yKeRu4GUqiUkvZDcjEkYJi/XAy+md5gDTfJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDdRK+9ROfivFOTSBxONf7spFBKhcbLthutQHxRPgxs=;
 b=f8YHaciy+qYR0VD9HXY/1c6rYJHNho40/B82YNmA0ZqOvy3CBqo1FA9rFUVeCdALZMGwWGS9Yuh5ddlVcoI98xNWINOh+Yr9/9z72bTA8YpyebiyH4DmGlb1TQZiCu1J4EcEUXS8vx03NaaPN65gABWBZK+CdWn1YorPkKeblkmTPEXKLjxhkkDlEPQx+AaETDqz2Aca6gGbfPKQTRSCd3E/v4GP3a/Ox8hscNg/gW20yUzh5y1ruqFZWAfBoQpxBPhVoZitb0ITONzOY2MY/+2Ed7tNW6Q0NSS/0C6J+bxpyQI63k0vUHcSNNH580dnISkwr3fnL/8pFuZ7+bjuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DS0PR11MB6421.namprd11.prod.outlook.com
 (2603:10b6:8:c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 7 Oct
 2022 18:01:07 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 18:01:07 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DBB+AgAA15gA=
Date:   Fri, 7 Oct 2022 18:01:06 +0000
Message-ID: <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DS0PR11MB6421:EE_
x-ms-office365-filtering-correlation-id: 30295938-e9fe-4378-be79-08daa88de86f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t7a1erz3PCpDmoit0rostq1QL+/FS1CYPO8lI3wnKOz3jSP8VxU5mKgznQxkFvoYCTi8IrOeuIJgF/Wp2z5gyBgwl4vlPvHszf6JSXKo+EPrehVBoX+sOCh2kSmKTDN5Fu5sexJ3TX910RlK20p4/9HK/jYMB9RcpQCn7NjTmKiPIt0pfEjTmKvklgXS61a3N3KjSecxAbYYKA6BXwIGBOKBqlKhAFsjgzXY4x6c5iz+jQXwLX/3U8Sj2gyCwGaRZzwHowcLhBIywJtGBSwOpgoxBZ+v/YhPyfF2DhZigMiltsS+FG0mdjdxMpgQO193f/3Wq1k+hu+U4bGlze+x8/zEiQ9SchnYssdcr7xF1nIb65YCPUDkrU6DIL7oabKLjVGrZa5/nQeaDOk2lXlS3slB6vhxpsJI9tw9aO3CDWHoEriMl6SE0pS0ksr8nHWhbd3Y7T9sjZLphVjOCZx7/E7ZTG6bXKKjEVumoef03sgNm4IsRsUEn+tL9IjHd+cfepI7+0uk3e2SXtvVw0QXXXk+iPig7zkECAkx2MSIAmUvuJxUdQAZD0bcREHc542FNwYvjo1xwzy/u/XCcXsHCNCC9nf57TK++Tke/LJtyJ+dPnGordQmIisXbwFXGv5y74EVsPKGU6E10e5CaetL1PBZMMP0s/0Qqk/H3TIw2v6jiYGBFLi3joxYDY1qYUjWfcxNAbEb0XKDVrnNxGB/Grqr212BcXLHVFarBmUl3beNfFlumibTkO7sJGYNaxfAHwXxmGlf6tWtiHsJZGC6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(2906002)(66446008)(33656002)(478600001)(38100700002)(38070700005)(8936002)(6506007)(5660300002)(316002)(7696005)(66556008)(76116006)(4326008)(55016003)(66946007)(54906003)(41300700001)(64756008)(86362001)(4744005)(122000001)(8676002)(82960400001)(52536014)(9686003)(71200400001)(66476007)(186003)(6916009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xi1zEYCzTSqJk910dfhEe60kmpTnglC4OD1gLzUqGfoaBGNsYuqhlh9ECKoY?=
 =?us-ascii?Q?xeiNYuvvBeB1MSwHlXhnpIJiw4RkzYrQBWh+sFXDo2lc0MG/Gxc5ekCe3oai?=
 =?us-ascii?Q?IbBCazmW0ITlfdp47ffj7x5azixlplvaFOZTSXqRj6EZlSPTmthXt5xnQ8rw?=
 =?us-ascii?Q?osvqexycLk+pRWf4BPreTCo+r+pxllwO64uQVGTJCy0lXK1aL2cJYAaufkOL?=
 =?us-ascii?Q?iKe0GO/ToQXNYx3CM8VIjuFs1aQez8SKylnYpf+Y8BTX3NjYgHo0W44hTkDZ?=
 =?us-ascii?Q?KKnS1poHV0wHGY0igRotPVgkygJPZCHw6OnNlKlTQ1Q5KphA6PjMDFx6UHD0?=
 =?us-ascii?Q?fYQZ1wAuL7bSVIH1dbH37KbZn+0TCxJ0HezaysEhqVCBjSykxC0Dz7wvsdtO?=
 =?us-ascii?Q?bRVo7bz4jH7oY+4Toq494888cKvQRy+UsFP2QnNK4BAnpBfTSkcjDTqvhGTZ?=
 =?us-ascii?Q?jx9nbpGSzt7uHMgXcvnuwcGu4Ha8vrVgmE0JjcWrisEjH7C0bV7nymb04oqL?=
 =?us-ascii?Q?7tWbVeadOuedmGBhU16PIGzHRXBghykTafNz0JhF5wpR49Mbw3Kxd/LzHMvF?=
 =?us-ascii?Q?ZDHDpWqGynHuzvTws7i+kdQOi0tHbrkmlgTQjvTkDTl8i9gcXoAs8tFr5YOc?=
 =?us-ascii?Q?QLO44cz+w6P3apizcaHLYQBB6hseicxvvjDAqAbPHxGBmcE2dj/NggpUFnCy?=
 =?us-ascii?Q?Xn1pXKbYJep0BRxX7Tp06HSjvaKVMFy6hcHSzcnje6KdSI+Z5yt96DHwCl4D?=
 =?us-ascii?Q?TJyfIHo2ogszgj76Rlvzkq3BRIAyAo3MMDIJBYELgZKJLwFVl+gfeEX3p6JR?=
 =?us-ascii?Q?nnJA/WUpo9e1IAaU5l7pQbCOQ0bPWhveB0zlhGyP8KufpedWBECquIAqphLF?=
 =?us-ascii?Q?i+W3xns1+ORQuwbzA5+DIOPR6Dd40d9V7hTaDf33fAVtgo8IBRmCgarirEEw?=
 =?us-ascii?Q?42VGFCKu69iWlx+56/HyOFenAa2Vmy0iouRfzrjqCDC3yZg50vhsyQbvUObN?=
 =?us-ascii?Q?dsUwmhqBj0JkmcldNswOQUfDNvS2SGSw7AebBgFCITX8AechgyKRv/ebQV82?=
 =?us-ascii?Q?fR7n+BUQnPabSFhjWNc3we/p1Tk1FZZAeu+BW0sc32Jchk6F7fcTgyCl4cMV?=
 =?us-ascii?Q?S3QyhNQ2aV/F8Xssr6auT/LHtuL/4BUuPmqKSQqYupS2e1TL785JayifIJrF?=
 =?us-ascii?Q?MsAf93c68uBINl4yNwoyrcULU1B0JdZTbWjrR3iAx1l5yctclDaVzYAUWSEC?=
 =?us-ascii?Q?mv5sRvgA7ptJEo23FnagG3Td/HIuFinKFGXusaVet7bOGM76b5+bw4euT8r7?=
 =?us-ascii?Q?bavIYUio+as6xGNR30vDSDacmxoOn/k3DQI32oFj+i7Cgeb9pw6Sr35GNS0i?=
 =?us-ascii?Q?UUbGKdZKQJRI3I7uv7uqCcii/GaxdgCIgv5Pm1mpUsOyyCA2tsnPNqs9O3KW?=
 =?us-ascii?Q?DMx7h1UKffcLTpdItMBLF1HMP9sbqjNTo+KPV8sSGoaVQVf5P/85+O2sPIEo?=
 =?us-ascii?Q?v09SilUg+yCaQCFVvczwzkgSNkoHo2j14kyaaY7MJ0cJDXXW23WrMqKum0Y+?=
 =?us-ascii?Q?nnkf766sdSdZkR/A6fQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30295938-e9fe-4378-be79-08daa88de86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 18:01:06.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVAVv47LLs8y+TJANqPHzSLeWM6Oj4Yw0BAoEhGGnRt+F3qw9eYDzag7Z+8Xm7rmq3dogSYgIolshoDqnv67gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	alternative_io("1: call asm_load_gs_index\n"
> > +		       ".pushsection \".fixup\",\"ax\"\n"
> > +		       "2:	xorl %k[sel], %k[sel]\n"
> > +		       "	jmp 1b\n"
> > +		       ".popsection\n"
> > +		       _ASM_EXTABLE(1b, 2b),
> > +		       _ASM_BYTES(0x3e) LKGS_DI,
> > +		       X86_FEATURE_LKGS,
> > +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
> > +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
> >  }
>=20
> I'm very sure none of this was tested... the .fixup section hasn't existe=
d for
> almost a year now.

Weird, did you ever check a kernel dump?

>=20
>   e5eefda5aa51 ("x86: Remove .fixup section")
