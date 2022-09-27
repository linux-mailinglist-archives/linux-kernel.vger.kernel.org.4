Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB9D5ECE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiI0Ue5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiI0Uev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:34:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11AC5FC7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664310889; x=1695846889;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9DgS0gGQSuQKmSKBOa2Jl0ndB4FE0eAJ/yfQ63x4ugU=;
  b=f3oUKa1/pPcIeM4CdapTyx9ACaN9Po0KDpTFE3vh+VQesV9p5Jan+G3E
   ifRxVhLsu5alvIcPx7GisGCjkyUEAqZzEmNTFrBjcKffwJAsQZgKKjuyE
   AfJJQsOQRoxWv6Cxv0fO/pM6fRqSxVG+GvGoIbJCtT+H/0CZCJ2w9poyc
   U5DlyVnUnjLu+6mAtdZ59uejKNejF8LRzPlrrt2+4aPTQTwdscQw5YlQM
   mlVOcy2gRmD+fWc0x4YSCKAo5heUO7Ct7b8tOVwzgaxvBT8wjlU1rfdK8
   XXivSEHLNmM6jhaG0JD1vmyvx0+PKrQx8zwHyKD3PvMSB1EFW8D3uyGnp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363265031"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="363265031"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 13:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621657314"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="621657314"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 13:34:48 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 13:34:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 13:34:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 13:34:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 13:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k426hrCyrgEFqrNaH95B71e1848XGk5jZWDszuCuo+uWbLw6cJOGNiAVisbW9QgfxdEIGGJVvd7eMJZdkToQs71fsAg7IWeKnlfVf2oEMn95RieBtb781MInglG2SKFsIOXGgqvxeGF4JocEpcWtNEhYBPVHhrSG4t/jELDwPc4Jc9rUJ3xKcHTKSrnuuspN6kGvuUFLdbF7ATm6HPeLKpMH8iZTHsB+Mx4SKilBGkR2YpxyUd+FXdQCjQW+ODSlkG0C43kyb+ZFMlFA3/DWSrRX59b2kt2O79BdL9xiPSOdOZU6xkhb/QHDUQwmGe/vrY/2kbaC06AiwUxsVv8DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DgS0gGQSuQKmSKBOa2Jl0ndB4FE0eAJ/yfQ63x4ugU=;
 b=jdc+8sEj3ChStnDN2MVjxCuShWlFzs4N7sTkh9eOTgaJB8l0VhCk6wfWztl7DkNLtxr8aspmyatolvOCkdiSPqtqqd6uLUIcuAdwx7cEOury+joUH/M/nKwOZLO3ARMnsTLCoJainZZ8HifN5lMtinrbxZpWF6BX34DAxnwNGNxnE452w0u6jEs7Eq6HQsuE7sJQOM3U3MY2+slR85fLYsVcDf3799nB7dy+pIKBVKD7H6KCj36Pu4OTy1A/0+YNkvIXivvej11GXUqksl6CpRjVxkt3asU26Po+9QKL5q6oS11Rg3Oe8cZA+pEM8/Z7eDu6kP0UfMUsG3E9omH/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 20:34:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Tue, 27 Sep 2022
 20:34:45 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Tai, Thomas" <thomas.tai@oracle.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tai, Thomas" <thomas.tai@oracle.com>
Subject: RE: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Topic: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Index: AQHY0qAEw44vvB4iiUevDJsG5WnUs63zuyEA
Date:   Tue, 27 Sep 2022 20:34:44 +0000
Message-ID: <SJ1PR11MB60836FCA1B8B317003CBF99FFC559@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220927183411.910077-1-thomas.tai@oracle.com>
In-Reply-To: <20220927183411.910077-1-thomas.tai@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4819:EE_
x-ms-office365-filtering-correlation-id: 2a170d16-69c5-43d8-6513-08daa0c7b6a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FyFtwzra+oNx6V+MWAVL4yoMrs7WCHPfinCstvrLhJWfxDRg8wI9OHJuVS4nwaJkiNFyOr7V2sHotKurFgNqGwKvfqHtaTEISssKwZiZG3xJ+ZzfhSlzySOBH2gvHctrHu8yDT8ct9qYfeFfyoFYHr1lCVnSyKCbxbPtWnCbVKwTOafqrFBGz/zWwNH6cZGd8SCUrciPZvREdzHu065beUzdMnDF9O6a7xE9+gfK1uEijkG8dJ2RUSuKE8eHRLA8/NygBiwmjeXr7z5z6hIEwiZWZ2izMnze6kIpqJJjYKPxYI6EloOnJUwVPJv0W7ZF9EDheHZ0zCM/Yd3eyfNqYce7Io4tk1m94EM5Uk1q7yNOp1Gpw3VQnPx7MNTFrnpa8Z6ubCXpbjpCVeXD3lN4Y+HOd31Ch2siM8Vho+EwyX4Lmtr5HX+BtVQf53jTqZGbr01Ec7RYHAbLP1eAL1MfNvfPuTPIQIp+hC2+218EeV0hbwOZIb7+sQaLqKlwl9cZxLJ5yEGDBk6+QztmzoevVp42GMu83sf+eyHaeg3gL/F7tsP1hDmpbZrbBZTLu088qjorIiSqMktLsIyWHTrFpWzhrQYz/ikiDNBXefsSOOxkig59PnCs6lwhVZPLTbPi4Poywsn1dGthIBKYX5rZhnlzl2G5m4Q/GBzQF6pYlWTIhrz2XdQDIjWQjlRQ117lYqY7s3HpajfNHdkYmyE8ilXRkexzVBqhFB6+Z46WWxEeRPwIEShSnpv5FWrfOxTG5nOEey8kmIQovsyivp552ZtYgZ/UmQZTpR3xvDTlJTc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(4744005)(6506007)(41300700001)(7696005)(38070700005)(8936002)(26005)(9686003)(52536014)(5660300002)(83380400001)(921005)(2906002)(33656002)(122000001)(186003)(82960400001)(38100700002)(478600001)(110136005)(316002)(55016003)(86362001)(8676002)(71200400001)(66556008)(66946007)(66446008)(76116006)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CDPyi6S0APEb2z/hWyU+eeWrmWDpWIxEe2iy39GBS+Rtpz5VaGw3B7FEPPkA?=
 =?us-ascii?Q?BYTEUiFCrkJ13OUacs6gje7qBXD0TOfuxdBi9y7W5dBkoCF3aLdZjUuhM3Da?=
 =?us-ascii?Q?7wFJa7oPUltGJEekO9ak6zSYvapWnqiYh4wDlgx+5/wdKJyeC7l9Z6XBZD4z?=
 =?us-ascii?Q?yYUgcC/7HHsF795irWpeoUty2InfR85MaXEF2Ox6zlJvD8KHYepzHDZwTLSP?=
 =?us-ascii?Q?6iKBEjXACY5znRWYsQWLzGxJJMNxNoNZvNhEr412DVrx3JDqSGSditGDTNKR?=
 =?us-ascii?Q?rDUPmCTitBHYyOsetjMJO7HCqVC5Fj8qYMfVIm11ngnIGUV/bD8UlfFHYkaf?=
 =?us-ascii?Q?6HSkXFJSMZRkkl9uXjaCEI93f/xRAG/Aw0p3hUOUJEOoOYV4AsK0pzC0UNB6?=
 =?us-ascii?Q?d5xawMdIOEwsJq2ivJ+H3GnPBdqnF3FigG5au05PfnhcdDWbn4SRpKzrxvT3?=
 =?us-ascii?Q?zTGHEO/xDWbqbOwC6DSo7R1cFd2Y0uZYABvTFAhB23+WW5+dCEyQjmjWRPZK?=
 =?us-ascii?Q?BIeE3k+Q2qDBmQBkkl3DVKEBo+6V0DjwwdFCbAIyQEp7hbyfzstKjFjniXvT?=
 =?us-ascii?Q?dHJrzp5b+fKSN7bqXMpBwXaMgQn/3c4joFtAqz8mT5Tct89+WXPjaPZJkcpP?=
 =?us-ascii?Q?zJWDeCzJJtZqPfkw82mavxur1FIgr3MHXMaCwjfxlxyXS8ZR57ipXlA3f21C?=
 =?us-ascii?Q?ixKFRsILZ/XrNQifFM98RSm9Po4dr9/9No2xF1iXVCOPdXtmt1VaqhDqp1H/?=
 =?us-ascii?Q?b6Qy1iM8qEyW7ljOYJ7v32q3jVHfSU4gT4CVDRSkxmu9E6uS/W5Pj/eDEmXc?=
 =?us-ascii?Q?vqN3LGloFP5mfm4KBhwg/sd55A85TJqyWgef7zCRxnPD/z7lCVIeyiynLxHk?=
 =?us-ascii?Q?3Fmac47GhsmzN7pkAteoIn7zzTBnSCFBHt0laL/fBSeYG5PEtIZ+SHVe4IQ2?=
 =?us-ascii?Q?rAAbGwAgwfZvDnlKhcF/eEQYkHfF8MB/Z7YRNK4a/hPAZEceWifLa+X4VJqE?=
 =?us-ascii?Q?bEey3S5ZYHDCJIunPhTwWxSDtByldWdA7Ls5NAHSTEgsGwnlmrT7lmrsFY48?=
 =?us-ascii?Q?3v7ck3+77FQQDs+4UbrUrSm1K7TLJh4GYFe+YA2MtHIDLtTsHlV9gSaA1703?=
 =?us-ascii?Q?Y+ttHgEYgCgBm1S4g1Svw1wa8yot6NdmmxDF9oJjbHK8Cs2fJymsVFXOlDgc?=
 =?us-ascii?Q?ZOt2Of+IGVaed2n9JdjHX0Y8iQqKYNw9zklq3usKBMNvDcVIxupUUib356Fw?=
 =?us-ascii?Q?Xt/YMinV4wmmCfXl+IF9OAECmUy8ZwMM28Bsuaa4qTe8TcoaVkj/pLSeq5Ls?=
 =?us-ascii?Q?zL2KHseBaKvbH9gZ7gwq+z3QiQ8Cd2jPJFzsAVdLzrF6bQb1XoZjN0HS9m68?=
 =?us-ascii?Q?TVnLX02AM4XAkwuapwel5az4/myOcF6TJ/ZgGmd+QHyLecNu7w6BRop/QB/I?=
 =?us-ascii?Q?Y0qeeGzGfZI18eJYZoyffP+tPUmMzPYlvKJnxmIQzHCOzJmE+SaMh6JQBWnu?=
 =?us-ascii?Q?Eczoyo6ef8UHdvWkikaoo+HvTMkpmwqhDqL2Jz8ijYsKTajrjz0C9DroSDM/?=
 =?us-ascii?Q?HhZG436lPlGb1ogu2g0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a170d16-69c5-43d8-6513-08daa0c7b6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 20:34:44.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joMTOsvBAMzZ2nHLPgQh0tsE6RnD81LqHCjkG43Rl8wqVwwHYkKLIq+yBjn8Dkz/qq/M0wBaM2CMeIeMQcv5sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> address validation), add a similar code in hwpoison_inject function to
> check if the address is located in SGX Memory. The error will then be
> handled by the arch_memory_failure function in the SGX driver.

Looks good to me.

[I wish that Linux hadn't called this "hwpoison_inject()" because there's n=
othing
hardware related about this injection. But you are just an innocent consume=
r of
that poor naming choice]

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
