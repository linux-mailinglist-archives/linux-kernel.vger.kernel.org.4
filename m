Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372AF718EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjEaXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjEaXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:02:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA511F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685574145; x=1717110145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X/2hceEDeCufVGuGhKWrYDFQVqhrD0tC9A5w5hdGHKQ=;
  b=Q8LP5GTdMYtieceMjKEtxhvaE7YNGZ83wbIT9Zr/YsUfBum4Amc+DKct
   rXdZpytloQ2lyBsDAPeT070KVBGaUzjFkdNlsFGKpUEs+629H7PwHPe0W
   8SeW3W4Ev5aAK5+UtOYCYTgSXLkNN0khfKvGGRCxGhCYplclKQwRD8lIe
   mpLf3gPVWn13SLsCBs8s0OrexZ7j4CVkHpAW0ksm1XQmYMQ6ymonuM27c
   HGEArRjj+V7OegRFgoxxL2fk+RZhriSqd0/bqHOraORUh2Oz/bIMo82pF
   k3X6C6cco+o5zbE7Z3osrzWgoM0KHFHZC6e68wyM0oxxq/vDm34V+aZYh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="357786050"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="357786050"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 16:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="881382801"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="881382801"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2023 16:02:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 16:02:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 16:02:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 16:02:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 16:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRxnHpPvm+yttlnwyo8q+Q0xCufcmKKF405nGDWW6CE1F5BRmgeagHmSM5UzO6rca7dqSgXVGbqcKmEpS/7kJaNAvn3E1Ho9SChjvCW7FH/Ajgm5UXxT6CVWkGYRaDQY4PtnRwpx1S0gvbmAonwPNRd+tLby0ICPJgGIyEtR4w/9Mu07KcrXZQrEFsWTorsI4aSjpZLLM2n+n3aF8aDJM3tIFSLq0HJ7VQW0tsVOUJuQ3SPdKEjL1tSrExuzEQoEU+yhgRREDEgyV0UCqBzFDOAP7ZnCElOpVGRynqmWvcUbdYWMPP3FDemWFvPxscVgBeIJTXR4Z71uxFpxnagkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSZKuiJqsOUBpOhxBg2TJEDRgsJUh9EPUzcaP4gFj5Y=;
 b=jgb7BR2TZXQgbj5Utg81zFD/fGZLlwZuXhOprwWmBL1GWNVCRd98wbGeXzhsztC4W3UHtToo+mfXGJVzc52keoB+Zpf+we77VxRx7Mx9pw3mWw+2/8oOQSHPcFbuO3l5wTE3R6uo1zMsmdgeqchKuMY5+6d0AxKO69vEi6QdJiP6/lVilrmE72JZvgUDzIq8S48xQd/wWiObNtfnxlTKCeYMh5bsqq2Q72pz1WtgXJRdti26Yh1vskhGD4hcqU9sOk2vxCvtPzjlTFGwQ5n5Eqc4cVXa1jk2Cgm36QCzSilRqdPBjUWR5LxVzWTCo2le/FHl1qnPAOGGklFRaLfVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 23:02:21 +0000
Received: from BL3PR11MB6507.namprd11.prod.outlook.com
 ([fe80::2e87:a6c:9fe:573c]) by BL3PR11MB6507.namprd11.prod.outlook.com
 ([fe80::2e87:a6c:9fe:573c%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 23:02:21 +0000
From:   "Preble, Adam C" <adam.c.preble@intel.com>
To:     Pavel Machek <pavel@ucw.cz>, David Laight <David.Laight@aculab.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How do I force an IBT trap in a demo kernel module?
Thread-Topic: How do I force an IBT trap in a demo kernel module?
Thread-Index: AdmNrJN/HBQNXQy0RfSVuasMlQAruQAaPVaQALWt3oAAybiRcA==
Date:   Wed, 31 May 2023 23:02:21 +0000
Message-ID: <BL3PR11MB6507CA789CD5BD5A7A5EA526A9489@BL3PR11MB6507.namprd11.prod.outlook.com>
References: <PH7PR11MB65237A81D8258BB1E10969A9A9409@PH7PR11MB6523.namprd11.prod.outlook.com>
 <82034ea784e44c5b929f519ceac6c4e0@AcuMS.aculab.com>
 <ZHKG4xQ8vma7lfRQ@localhost>
In-Reply-To: <ZHKG4xQ8vma7lfRQ@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6507:EE_|BN9PR11MB5516:EE_
x-ms-office365-filtering-correlation-id: deecadc0-7271-401f-dd3d-08db622b1711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/spYU8XLVUrJ2t1bmFMcMHjRJQqKvBvhpqU6BPanyVfRQS4qjPpiQLYCSS3E9X5I8pgdHCQNdtinVL+z6s9grg+FB+HYoT0A4tsZDoEIISMuhiSriDTnpvZpiOEnbqf90FKaA9T4X+c1qAPeSKbl1XpnWsTzTPvxFBIXa07Nfmpf9CnjHnRc/t7zpjilUOX1of4V2DXfIr+Cnx+CGyWUXsRyaasdn0Ec9D0+1kegtWzu6xL0//jvOezsHtb0gfVP/KCJLnGOqp/dQWyUxE++c0AcG6XttyCP48kT0d9qp3KgY1Imd0sidAa9RMc8sjc8XN3jrKXGBQoKNiLjqjEfoAdUPk3WNIdFLDrnRxAaZAFthG5GGYOU/gfdy7U8gvXgmCHK4zvLyLhfBEA3ZapWyz42xXRtb6pkuugZ4iLJ7cVWTti5mT2t7k6F62e3el3wDlOPva3h2kUSFQsLfo2jbStV0GxvFUCGFBBvVFWGTXM9b3NmnGuwjHVG7Tjf1OaXaHBlStoCEpG9nF3v8QkgxcexfmVoB5rnd8ek3SZz0WDXlTJYp8MYLFu6qgio70OFsaKqFiuDNvP97M22wHqswKiY9joG6+rxsJHkUa10bvIRzBce0GHPSY+4KmIG7HE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6507.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(2906002)(83380400001)(33656002)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(55016003)(8676002)(8936002)(41300700001)(52536014)(5660300002)(7696005)(110136005)(478600001)(66446008)(66556008)(66476007)(4326008)(66946007)(76116006)(71200400001)(316002)(186003)(53546011)(64756008)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ZcPQFWptD5dd5wvQy0tXLhWlayLitBix1oB0Z5ZaI9DzoWti1h6M9xbTZJG?=
 =?us-ascii?Q?y/f9OiWR6583X1iPob98joYCU5dduGzX8eXDr730BctKnEig5Lkh2gFYOyh4?=
 =?us-ascii?Q?zfE1AJslDI7kJ0kvCwLXx/5/Fm+QEXLqAfN0NdUvCZ9j7UZ4HoI+ii8ojAHP?=
 =?us-ascii?Q?QhY4YsOEBdtRQSsLuOR7jL4hiXs0y9GAaUQ1bOYb8fVwGVB+EDh8bDrdGw4L?=
 =?us-ascii?Q?xDMOqxVcxcEqBvxGJjS7m7NM+nzdnXMzoBqGBWcUPl1qhHn0sPovFoIkJc4E?=
 =?us-ascii?Q?wvhQ0BO5t1iAfJRugO0zeaHT+h52tVDGbF6TM9o4YGLujglIQO8EdfDBlMbz?=
 =?us-ascii?Q?0cjdeSIjUKB6qTrtm4+/TjOkh32jgp+7n8xVZeo12meLktLwHnInEhJ6jqw/?=
 =?us-ascii?Q?uQwrVtT9xnDhc3vJSot59inXM3pCBAGy+6NcaJ204VVs23scN+HL//Nva0dV?=
 =?us-ascii?Q?j3+CjtO/KEo8khHiD0MIyUsUJEn8wcbYeD6M0956W8TT0bRljJerVl77uuYW?=
 =?us-ascii?Q?P2E/qKw4Eeb55jr/O9WA3nNCcs/tERHPb3qItGTQILiRdU5NZzD2SGivG3GD?=
 =?us-ascii?Q?TEdOMJV/fCtHxIghetbIQNvy4I6tf32y2tvzIVNw4+zsvpyg+Rlnkd4kAD1e?=
 =?us-ascii?Q?/kNpg+KQJZW9aOgaIRBve5QNJ55chGRXUqnsKJnrnOGiBwWwCHkPVnHpH5gB?=
 =?us-ascii?Q?4EkMMnxUFQ9dSUqWvL9DLLV5VWkEUuhdPtwAdXl4GyynqvZIaaLimqDekczl?=
 =?us-ascii?Q?4RqH40xyK50k6QA3T5Ib/Yc2PIuVC6aKvRcpF/FZ23cWkbJXna7kfpCmcGij?=
 =?us-ascii?Q?BNNXrjg5CRfD/t/4jrrIaXNwHWYlZdzuQi6m2ke5FA6dndC9/LIjaVObEQK1?=
 =?us-ascii?Q?8j483/uucKuVMUPB5p9YwMxtRUTWuB3qZI2Pj1l8SAKcHk96Y3Gf/Svr0INk?=
 =?us-ascii?Q?FX+uazyE6wA5WTculdIG2iQC3ZuE0BWAaDosYnNUBZrR4Q0o9h7gsdcotUWo?=
 =?us-ascii?Q?z30PLkRazXsLHAkJDi3jjEOYbEIIrML4bwVU69th2/doJNET7q57gLX0Zh39?=
 =?us-ascii?Q?x9kA7yUKPpHv096Io/KHEd+xFEuIU+WZnK4hwsUY9HfQqdSfGePMk2j3MfG6?=
 =?us-ascii?Q?nPbrYbk4Zkik29z8GPX5i0cJfAJPFyO1g9o5qXBZBmtN3mvkIDdco+geVpLX?=
 =?us-ascii?Q?6+EZsVwuQwV0sYqArZauCTfrfcwGwymCMo0uUPysQKs7b10kUX2vFGaQsPry?=
 =?us-ascii?Q?WTr+4EBqi6pNLRDT95Xy/d00L2Qdl/F4Vq56spalrXwx3+HD5ZCHBUJ7HRzK?=
 =?us-ascii?Q?qwE3Sstolx/eJruCJ7FOxv4zy4LPLbggjFoxxtpAIMNDdc85QutgDSzLEB44?=
 =?us-ascii?Q?+dhMtf4mewDTgdUhicOWcIDfSTwR2cu0WD2jywd24QdJ8aiIwCBnH/GXlWd3?=
 =?us-ascii?Q?Nb/7SSBxzkYsNRUQHR5koKNBpcyZaJPtWrLOkgD/TyECuu+X8ncmerbp1MlQ?=
 =?us-ascii?Q?TgRSEV7hm+nxunJh+i4jHg3P7RRhhlvjxldcYrgLVlxH/DAIWSeApxpmR3mi?=
 =?us-ascii?Q?4GMyPW5RxJDHHV/HG8XmWP7b6yl1ogG02uPRWkzI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6507.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deecadc0-7271-401f-dd3d-08db622b1711
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 23:02:21.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47yYrEkIaQzlHyEjCZ7S8v3r9hhV/l2qDAUEwAXLWsqdpdDlHls3IHwQJSgz8rCLX6y64rKGdy3DX6Kxay4Yow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looked to me like I was getting the indirect jump just fine with what I =
already was doing. Sure, I made the instruction pointer volatile and static=
, but nothing changed just from that.

The make command ultimately invoked is:
make -C /lib/modules/6.4.0.headers/build M=3D/root/module KCFLAGS=3D"-mforc=
e-indirect-call -O0" modules

(I'm now messing around with the 6.4.0 kernel; it was 6.3.0 before)

objtool will then puke:
/root/module/ibt_test.o: warning: objtool: init_ibt_test_module+0x11: reloc=
ation to !ENDBR: indirect_jump_to_me+0x0

I think that between those KCFLAGS and my function prototype that I was abl=
e to mark the function to not have an endbr64 landing pad:
__attribute__((nocf_check))
static void indirect_jump_to_me(void)

However, I am assuming that objtool is rejecting the alteration:
/root/ibt_experiments/module/ibt_test.o: warning: objtool: indirect_jmp_ptr=
.0+0x0: data relocation to !ENDBR: indirect_jump_to_me+0x0
  MODPOST /root/ibt_experiments/module/Module.symvers
ERROR: modpost: "__x86_indirect_thunk_nt_rax" [/root/ibt_experiments/module=
/ibt_test.ko] undefined!

I wondered if I could circumvent this check too without, say, just resortin=
g to coding it in assembler.

If there's one thing I'm learning so far, it's how hard it is to actually f=
orce IBT to trigger. This makes the trap I'm hitting in this legacy code wi=
th IBT on particularly galling.

-----Original Message-----
From: Pavel Machek <pavel@ucw.cz>=20
Sent: Saturday, May 27, 2023 5:41 PM
To: David Laight <David.Laight@aculab.com>
Cc: Preble, Adam C <adam.c.preble@intel.com>; linux-kernel@vger.kernel.org
Subject: Re: How do I force an IBT trap in a demo kernel module?

On Wed 2023-05-24 08:00:36, David Laight wrote:
> From: Preble, Adam C
> > Sent: 23 May 2023 20:29
> >=20
> > I am debugging why a kernel module of ours triggers the IBT=20
> > (Indirect Branch Tracking) trap, and while doing that, I was trying=20
> > to write a standalone demo that would forcefully trigger it on=20
> > purpose. This has turned out to be much more difficult than I thought! =
What can I do to get a module to generate an indirect branch without an end=
br64? Creating the indirect branch itself doesn't appear to be hard:
> >=20
> > 1. Set up a function call
> > 2. Assign it to a function pointer
> > 3. Call the function pointer
> > 4. ...maybe add a compiler flag so it doesn't optimize the call to a di=
rect branch.
> >=20
> > I am primarily building in a Debian environment with gcc (Debian=20
> > 10.2.1-6) 10.2.1 20210110. By default, the branch does get optimized=20
> > away. I had to set the -mforce-indirect-call flag. The endbr64 instruct=
ion would still emit so I added a function attribute to suppress it:
> ...
> > So what do I have to do to tell objtool to allow to me deliberately sho=
ot myself in the foot here?
>=20
> You could try adjusting the function pointer by the size of the endbr64 i=
nstrauction.
>=20
> Oh, put the function pointer variable into static data.
> That should stop it all being optimised away.

volatile will help, too.

Or simply write the code in assembly.
								Pavel

--=20
