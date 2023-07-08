Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499C74BCE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGHIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:44:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7B1FEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688805864; x=1720341864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dx1tbRPUIjJlCPxTxjUZdbQuZ2dMFZowaDQEGN0e924=;
  b=cnFQVn7jAs4wYvU/65AvEq1ZNniDpZied1I+T5r38D17PnWcduBhYRiw
   toOd5KeXo9IgjzGd97F6AZ2rTHHLf83HEH+1nGPHkbqEuPyxyWa+qnKmV
   vDHFttsHBwqlIOt23dDjlyJ2QFGgjurQjBgHnXciO7jNzqwz+v0NS+MSq
   iE86BYhugaitB3Wp2pEJHmKwbhwQYjF8RowxbeIrLv0HkMWRxv8Ob8t+K
   qxBL9vIg98lNjtKZEqiQs4lxSipBmAvYe8eTCKAx/Qa4ypifafe87cRVr
   vtn2w9f+veQC1Q9fbVyg+yUTzhsMl8cAEM7KuTEvXlpP45m4uzE7gD35x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="394819214"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="394819214"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 01:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="670395707"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="670395707"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2023 01:44:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 01:44:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 01:44:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 8 Jul 2023 01:44:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 8 Jul 2023 01:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGu4Kz2XnCWhDQ2FjwuJUlhhVSDJkifWQ4wLS9LhhY0EIqyH7+wSLGC8tMfiuOtMySP2L+sEFHBrH17gWWyLcEhPvEyp+fI1QlFBGqe9iTsU4slD5Wd47rJA4dvOB14ZXeGqRLf/+fv0Ck8f93sz5K2a9vXcyByJLBWk3bAnbxVhBjjqisLT2dYz2cgxczUTrtT87A4J01q/WEhd9yY+xaVJleb0qBKOlmbZghk6DIzu3tzCc+ikx/hJ3RFsNEVXPb2MjQh1Hz0jyXBfpOyjGQD8BlIHuDMvWTx61jX31Yz+g2IGYtIvhQevQK53WYmlu2rHI3VbCUGVFzndF5wamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUX+cuiKpOStjk3Yv8Ah0XX4TTx2x6OepbrrN8LMK7w=;
 b=ia7vwIDsScXoX7sKjVbjgJwielQ5yZNC0OO8jOPC/HzOvyXhBvjOp+c/elTFwclBxYLL7qYpLdDDCBgkgL5fLRQhBj7J+buvf0L0YdTWvELCK+K3+gEyH65AeBNpLTjpzvyOdX4pYvJGF0EJtUJgDXuBBCBozEUcbN/ZBq37mmBjxv6qllCUqR3vosjDdF96/1PnB+5uoEp2mMgRmfAGFXNTZ+24NSnMIROEkJtlhKUWDIUMuTWXpzBbBIYreZMkwLboXzaxiDD3mGv+MP2ZCdWUgnPNQb1RboWrjivYvtCscT7bguv5n780UIDd3cRUqyBB0G/45M3xmSXr0T6LxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 08:44:15 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6544.024; Sat, 8 Jul 2023
 08:44:15 +0000
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
Thread-Index: AQHZr83AFvT4TTcrIkq3d3Abr5XF0q+sxk7ngAC/myCAAC0zwIAA3mCQgABOVsCAAAwbN4AAax4A
Date:   Sat, 8 Jul 2023 08:44:14 +0000
Message-ID: <SA1PR11MB6734547F70FAFC9297D89F7BA832A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
        <87v8exgmot.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <87sf9zfx76.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB6734577080AC6734E305D735A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
 <87pm53e3ne.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87pm53e3ne.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA1PR11MB6712:EE_
x-ms-office365-filtering-correlation-id: 5004e54e-c668-4649-4d86-08db7f8f828b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hN+ZNBI6NINAD1ix1V/YJ2uD992lOOe10ZLIxcED4EizWtwBdW/e+nMwIXfOwp/n9yipJ1cympjNbCVIr+nVugtqTelFhWQ/hEYAx2n5SO0MYDkutxFK1FaP/7hQsJzEQAmxZ7sNDt6YYba8/RKdGovLWdx3qOo7Lqt8gc1+je+rk5dnHVMUlylSyxHAXX3fSau0q7NX0Aas7+G+Bo7J2WxpGuyuHPT34B7bFcqVrQeL1lXpNTU4yuzbJS6m2OmYyYaPxlPCj2e2mcN2aEFcIiFpwcfjfps8Fbal28nsv16tmyD3jGz4Nua1Vti2Z0G+K+7HITG+m3F3m0ruv4HssUL+U/K9DL3QnEZdAc6F9BWa99lGfYmOlfGcr1tw6fYOiskg+dZwjRq2D2/lGKc9XdqRZocULGUe3aEcz19MDoqg8bP6KJISRjQDD0G6QWss81NavbhMsMAckGnRqTOU+zlNMFdW2fmOYQA6503gEcPZRcKvgcPhlZzdFdRzmmHN0yvfcCaBNeK6RHrj6X3ZKGq7xf5x1IyQEZp1Su0h1FTrou3CMo2CU93TB5MBmbT7XYzuTjMlFagFwjOxd1deImbhUvROt0/he4RXEjDmN7t7Kq3/rtCAanGwb7W1Llsa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(4326008)(33656002)(316002)(66556008)(76116006)(66946007)(66446008)(64756008)(6916009)(66476007)(38070700005)(52536014)(5660300002)(8936002)(2906002)(8676002)(55016003)(86362001)(54906003)(122000001)(478600001)(38100700002)(41300700001)(7696005)(6506007)(26005)(186003)(9686003)(82960400001)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZcJg6PO2RfqIeq9Tlb9/uxH1tqg1BIvg76yhAuXzmBfaStzd1ChXNxvgP3x?=
 =?us-ascii?Q?EBXl31uzuhXpz6ShgPR+QXzovTq/sCNn+NyEPkKwhbBQWssS9LVxzptqw9DC?=
 =?us-ascii?Q?+YjIEw/9BFQmpMYXDVOaq+jeQaJ2+rEX7VGmPWAZy/TJhwJpBJb1D7IL425O?=
 =?us-ascii?Q?V+x1vZe7UVETMdEF7lcjstlLo4NrvxR9vWzW7Iq3cErnaEVP+vRExJ3GUsav?=
 =?us-ascii?Q?UwEC/1Zi7CgDpNu7Ww9fQOb89vMR4GsvYavPNs0Qr1oedGu88MC5GgippnnT?=
 =?us-ascii?Q?ip4QklQwrxAJJ/yWfzAIa1KeU19NtvdyruvCaNY4VdNzAlFUeSo/oRR7Fjtf?=
 =?us-ascii?Q?I3vXBmDt/hZfxvJ31EXJ6PUZonCLQ7FWkLg41IMiBirt8JTTxt0UYCWww8hG?=
 =?us-ascii?Q?z3ns4bb5V0ZNgKFZCCaE2vX2/HlSHY4u76SzSHZbGdqMLGpVUC/rD4CmgKEL?=
 =?us-ascii?Q?rekfdIqzgAxIeuEIKErNMfwzoa09cw34c1JxkS5fFmHZJbyZmHDdb0IsvBSV?=
 =?us-ascii?Q?q5F+IKu28J7KHggXK40o5da8fnpDws6NopwmIc6fmFTUcIcfiL1c7waWTaJt?=
 =?us-ascii?Q?bhTTrUyoDtG7Avs6F1IL5Hpcp/xwoBfZ3Iupbdt/cLw0pAsXMMXXfQBP1ltw?=
 =?us-ascii?Q?PoBBm24E0B/ZpBChfDRSzf9FHAgEDTElZZfviSTfgQ5gyCzh51vwPHQRhmYn?=
 =?us-ascii?Q?aDnbqA7YAQkSn9aURYJK71oidAp1DQTc2T8xDIj4UYGnkAwDi2AmMapxYbEr?=
 =?us-ascii?Q?dZ+Er76LSXtqsNGrq/pJhGzxOP3931BFMORBAkjAZJLsNZVD0rJT068k2Ylm?=
 =?us-ascii?Q?HTGmazbNbd0qpHgpZASoqt21oQRNugmDqs2T7hFyAbBpG13J1p5Cqi73bFwl?=
 =?us-ascii?Q?dxoxE4RLXfiwLQNYyw6A82B5Uic4zIPMr5dXjtpJt8gPUHBzPytG2l2jUqef?=
 =?us-ascii?Q?ovaKHOmaIFNq/+T++LbDMz4nDI1PJV5v7UMaPJ5dcjqpfVmSkHBMAbmKKsX6?=
 =?us-ascii?Q?rQEll8Q86MB2WTTdnMC6eEMN9gM/jweEQJ8qOAQiIuN+l2vfkI3AiwUptrN1?=
 =?us-ascii?Q?kXKNnMYsoKGBTpjD9xXZXRJMdIbF2QGDphLmTIHHO/W5t1EcX/HP/zQYtRv5?=
 =?us-ascii?Q?hTcV8IDh8g7epzchhi5LrpRilH4LLyv6rlMODlEBxwNfzEeT3/c+z+fmikSx?=
 =?us-ascii?Q?V36jA1pF+taEjMzlfvv90YEsfrslY710wW1LwO7RD8cf133qSdUT3YMtlMW0?=
 =?us-ascii?Q?vktJOSmDFAL7mAsKsoJ5QHMikGzGSeuu3xWrUnaN3zwPgMZ952Ov3vKmFl/V?=
 =?us-ascii?Q?p5gOgitbAjq/0UdR6O7/TsU+mAcmTpl/+3M0jQe7hmIlexnwtwz8coDr5WBV?=
 =?us-ascii?Q?BgYv4K9kUYRLVks+tDORjZTmnJruup53Pvt+pc5j74Kj1iLRr+7jPk4TCWgi?=
 =?us-ascii?Q?IbP2WUb1l5Lav/14xATWh6FnZqn7vVhFimqOO4Yw6MVaHV+tii6NOOsJqg3C?=
 =?us-ascii?Q?8GEzfkuIg4tMgGEr5DKLMGnVUEf2NKK0YRTW8pBSE2pjm7pyHa2x0DXr5f8j?=
 =?us-ascii?Q?0Rof1Bo6wvA2tXZ17A0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5004e54e-c668-4649-4d86-08db7f8f828b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 08:44:14.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXrEW7wvMvoECcBlKhgLqRWqfX81WbO8CQdHGzc/GIr7swOGjLaMIrxsUNB9YwYJyDy641zXD9f7Mwr9HKVZGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > normalize_usrseg_index?
>=20
> Perhaps useg?  I think that is the abbreviation I have seen used
> elsewhere.  I was trying to get things as close as I could to the
> x86 documentation so people could figure out what is going on by
> reading the documentation.

useg seems the right term afaict.

=20
> >> +	return (index < 3) ? 0 : index | 3;
> >
> > s/</<=3D
> >
> > no?
>=20
> Yes.  My typo.
>=20
> The patch was very much a suggestion on how we can perhaps write the
> code to make it clearer what is happening.  Normalizing the segment
> index values seems like what we have been intending to do all along.
>=20
> In fact it might make sense for clarity to simply use the existing
> "index | 3" logic in what I called normal_seg_index, and then just
> update the normalization to add the null pointer case.
>=20
> I was just spending a little time trying to make it so that the code
> is readable.
>=20
> > With this patch it looks that 1,2,3 are no longer valid selector values
> > in Linux, which seems the right thing to do but I don't know if there i=
s
> > any side effect.
>=20
> You have said that IRET always changes 1,2,3 to 0.  So I don't expect
> the selector values of 1,2,3 will last very long.
>=20
> If that is not the case I misunderstood, and we should consider doing
> something else.

Your understanding is correct. And I am NOT opposed to your change,
but want to see if there is any concern from other people.

On the other side, I got to mention that when FRED is enabled, ERETU
doesn't forcibly set non-zero null selector values to 0. Then for the
sigreturn self-test, it can set DS to any of the null selector values,
and expect DS is set to the value after sigreturn.

With your proposal, 1, 2 and 3 are no longer valid selector values in
Linux, and Linux would fociably set non-zero null selector values to 0,
just like what IRET has been doing.

Then the sigreturn self-test should be changed to check any non-zero
null selector value will be set to 0 after sigreturn. And this behavior
is consistent w/ and w/o FRED.

I think we should do it.

> It bothers me that the existing code, and your code as well only
> handles the normalization on x86_64 for ia32 mode.  Shouldn't
> the same normalization logic apply in a 32bit kernel as well?
> Scope creep I know but the fact the code does not match
> seems concerning.

Agreed! We *should* fix it in the same way.

I guess people are just conservative with 32-bit kernel specific changes.

How many OSVs still release 32-bit kernel? What about the testing?
