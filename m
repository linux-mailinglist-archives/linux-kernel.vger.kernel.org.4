Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3160318A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJRR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:25:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E7AB80A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666113956; x=1697649956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vQVF8hpyd389ySGH7TAX3OaoYHKBOlbvvIQyS6MAwjM=;
  b=TYk4SO23mVC/lyaQGAw3CmsNN2r4IPkUQJ9STubH5vE/ke5AgoqvN4RC
   Kt5jyCf0I2+mkp37ApbQoAzTcNh38Pi+GOyy9E4RlN5/Xx3Ir0diUq3cG
   Du5J0xwyAGkzKRq+PIqHLWSqQNCsroXQr5qsI/tfsFKhGGqaDF5zcWBd4
   6ckJVZMe9Fq0IM1cGNUL7Jo4dHXuGhg1+fSuMYMUmVqIwJ9IfdYKTUxf6
   +JjQuwBl5/skaIeMSpXRcP0i6d4k4G+OlDgVnRDIFuYCRGC7YIrzQFzum
   DvCmxdsCO6igdXWMBV59r/4+URb6I+1aUGv0Hg7A2H2FvdKN4nHKeHY7R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370372811"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="370372811"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 10:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="874003000"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="874003000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2022 10:25:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:25:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:25:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 10:25:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 10:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZZvT+4Gi1Kx4cEzFGHmcO+7Hu0QhJrgcANmy6oQiDDFNvRntE7SYobIQ+QxrAgG44Gsb2jTX4SUSank6AHcWsfHGmcSe1vF3/7Pbk9Sg6e5GdF3CkyjSSdu1mhk2vjQ1twVFfEv+BHVmQhJpxqB2lIP6OFsS0/2PhHhqLY+doEeviTPzcVOxesM7wcNm50IomJAM41HsfUYFQ9441IRTeW4EzC8Xi3LxjNE8u+niC8/fm1Y6UtqvgXA6XrGHOEktfE+qTD7F+c7IskltxnhrihwuRTNDuG0Cyt9rwxD/mpCqA6Bu+3jDAEQCZLvA3bHGzUOye3n+QNyp+ylurAF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqd2hnNN7q8lptLVi1pmuc4YL2hTvpc3XhPDt3EMff4=;
 b=kqZVJvgXZO0OSyeydHmmEXzg4lM7YB2/yd8c1ozhx5a2uixgOZghccxP47HB45SGrvaE0L5SQIRB6EIUBlHqpf3RTCKg/FgP9ugcJsEvBQs1W8/O+yQ2nR0pAHjXK3GIIiV3LVc3Ta/aTbTRPEEXYaL/txRil7m6J+WXkLLaHuhTe4mAlEAx3D/496pJONyRQgZKPMQlkciif09EwHUkyeJvpwVBMSaEHwWX3f6DCTDfNQ1BRHXFXDO3nkJcjGecJqpYtrRZNK/aHqffy4dGKgF9TkbHJDFljdSg2vwgjocAqky/75NqikvUPYsXPCgxystyDN11DOXl3IBJJMHIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by PH7PR11MB6029.namprd11.prod.outlook.com
 (2603:10b6:510:1d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 17:25:31 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 17:25:31 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v3 4/6] x86/gsseg: move local_irq_save/restore() into
 asm_load_gs_index()
Thread-Topic: [PATCH v3 4/6] x86/gsseg: move local_irq_save/restore() into
 asm_load_gs_index()
Thread-Index: AQHY30Hw1PW2GkL5M0i2Gd7SJLBFf64PKDsAgAVE4dA=
Date:   Tue, 18 Oct 2022 17:25:31 +0000
Message-ID: <BN6PR1101MB2161B983B1A85CE3803A3EF8A8289@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
 <20221013200134.1487-5-xin3.li@intel.com> <8735bpbhat.ffs@tglx>
In-Reply-To: <8735bpbhat.ffs@tglx>
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
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|PH7PR11MB6029:EE_
x-ms-office365-filtering-correlation-id: d8d6b992-25e0-49be-a5b4-08dab12dc21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeVva7OIiI9Ck9B7N8d0vulgCI8JEUd/Yd5nXkgKINJ8UfuELuoVD8QlYCBd4R+HrEHQV/DZF/2Zp81GDRJqtw8Dtnyn1D83LGFoKH2MlgJA6uTefuBz8FztkyVG2d44sd3UyDchq9Qcrv3QzvucQ5dRLX2HqDyYthi4DA9YX8pdGOwEGx3r/jzWQuBuLlc+ZGiupMOVUqSXC+5HuOBdCvsPtQcZ8iTqKtSI7wHtFJfENXQxfoXXROUN+kmH+CADe28scDeFOAFBDg6GklP95rFYOWwbgEUANlEtoUj+pCWb0/SD0WGBnKteWUWUzCB0+LRH4Uv+6sDgeRl+U0BI/JWewWCZjALPQZEvZTfptAAPUW5HHP527e6MlvgTvV+x9oQHC5WqZmJtmcS/QIBVKnAOfSyfTSqZv+EZwxNCVkIsWf9JB/R5Qd3midE3tS+tvnxWEljAfph1FppqhD+bZjJkbduEmLKBXMTh1UH2fn5Upzo2r1irbV+LU60AvYm6H1p0pa0aX+QktdPggnxTZmpXBpung/hUAPSYZUde+fumkcFm0Jr3MfzATfS4+vOt7Fmjix+WwOfcsmc2uTPhPdPrHzCO5IchvlKCYY9Jvj0XJN8P3ypem2iP8EjBmDijqSfooNCA9MkJbPlZYbzFF/e3ndSYZ17+SjXUBdJPiy+oHGf+oe1/p2dCs+X4tBa8hMqszM3HyLTL0yuTtneN958yPRPwwMCDBeuOJp6gjhhOqdgHTdbai32+sfMqldJ/nEQ+b9BMIFrB2yyY13Y+fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(38100700002)(71200400001)(122000001)(38070700005)(82960400001)(478600001)(6506007)(186003)(52536014)(2906002)(41300700001)(33656002)(7696005)(316002)(110136005)(54906003)(64756008)(66946007)(66556008)(66446008)(66476007)(86362001)(76116006)(8676002)(4326008)(26005)(5660300002)(4744005)(55016003)(8936002)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VNQjn2EyubpnmVKn4XFLH/rJcGZlU92EZqP8SMrxoLWquxuZ15hN7dygPqAG?=
 =?us-ascii?Q?BFL9yP9jgcuXKumzGATf5ofnqb674uAmSWxMX47URpkbGVAv73r1IZRW8pE8?=
 =?us-ascii?Q?UkXyfQju3cvhV4ov5y0gegmxa0QQvTiIgVfaxsza1UOSqbL9E6ZLqLIGSgwp?=
 =?us-ascii?Q?w0FBlgSAAHpsZkGXcu++b2eEmwWDhhyZzvj9UgSHNdkeMj57u3Ke78xsB0UE?=
 =?us-ascii?Q?orRIlZ7t3Q3kZ6wZkHq9mH0dWHv10fEuMCgzIkbZirSOZJ3YzMVXUoZAfDIR?=
 =?us-ascii?Q?ZJ6OHcLjjc4C476XcmGhcbG7Wy/39QSExppNWt/54MH5ALXxNz/QurqxB9lJ?=
 =?us-ascii?Q?EpThZtfoXc7QUSkli+MbQNakm1qMClEwij19kJ3xpbrccwzNVsONPFYHplic?=
 =?us-ascii?Q?PtudvKZnByrzsBHNwwRHX4jrO04eJ86NiG634SgvzQoJGkweWvhiwi8URmo2?=
 =?us-ascii?Q?YEXzRBw9vCoI9/OCUAudYxW2pOliITud/BU5hap1QQZCaeC1/ORd+uyGiDXN?=
 =?us-ascii?Q?ne9D/aUcM//mOcH0C8IYYgE+BSb7AztWpL3eMQWLGHz3QWaTQHCmmcjZQLvI?=
 =?us-ascii?Q?Md85W1fLevehyoMXM7KrYKdEx8HDzuhakMzYidZ9hWZAPDkwfdB55R4opSSs?=
 =?us-ascii?Q?pi1ow2Ly3OKH5KoKGA9For31Meb2NoM7m0QbdOtQqqHpo7MNpkKf43RGIgtq?=
 =?us-ascii?Q?WkgWlMC6VZvBwvyki54RfpiunmERg0+fJOLrlH3iOCo7W2y11HVugwD/XhtJ?=
 =?us-ascii?Q?yT0vAS2PhFD/WmMNjYVxxaEyYYG/RsJAFgiGKHjZDxdF0q8Cnn2biIrLXP8O?=
 =?us-ascii?Q?pRe4Y0jbrofgIdxCt4A/J2bZlhAjmQ8SU2hVn3mZeBfaoE+NhaFncCA+EVON?=
 =?us-ascii?Q?ixmxrSpDxfksNHhBMzHWSfMFaR2Gg+oycWsqdo5QHvoz5W3V2oPSLIpgzvKA?=
 =?us-ascii?Q?yidSa7IlvfkoZUvShCV7r0rhQDMK2VDa/FEq85wrR0afeRfgVrSjAC6NOESL?=
 =?us-ascii?Q?w3qAmbeu5xVaPEFcLY8+u+luOmm8nKQckpezCivDFJQwVHBSEs4+b29jqvfw?=
 =?us-ascii?Q?8oieY+Kh7qbGk5RXHPFA2Qrh9rVZV5ltAL1CZic5XWKuMBtNvUj9bSQY/V+B?=
 =?us-ascii?Q?ERqyjOM/BWlVjy6LzXHxeX/nhVn7UBczd5yj84GfaNz2uF/z7hVybtyJ6q3q?=
 =?us-ascii?Q?3dBWuWCpiDVS7IWJ8ztOUT4XGO9pBN2svVwP+25p+YUZFJfKvW9+Ew0Jayp+?=
 =?us-ascii?Q?64P5ri7/pjm3+NmEQOu+p4IwQ9+rkysIZkzAei7jzf1Jo/MbO+3Q1SHnI9Da?=
 =?us-ascii?Q?yyWhqKS/6kEjOM+WUGGi51Zd/X693ove92VgXqf4Ge3IcfFDt6HRAHUi3+Kt?=
 =?us-ascii?Q?q2nghHfs8aBST3TSSLPc6lNmNcVqAyBQtMCfU/7ThlmFNhL5WksHNaHyoLJv?=
 =?us-ascii?Q?fp3r/h5PFOySy8RwJGNNunCX2X8Hsi9807Sx8M5hpIr/5wqJfVD88ZAVQSk6?=
 =?us-ascii?Q?aYV6qd9vgVU9P0krITHVofWgu5Q/So+ZE9s9Nh6VBQmXd7ZaWVtdDjq/91zx?=
 =?us-ascii?Q?Fwdv1VwUUto2BTsIRXg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d6b992-25e0-49be-a5b4-08dab12dc21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 17:25:31.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2f6p1RLw8xLwCS0el57ZhwSDHBCEpCIMuKvGHQY8Tbsh2SdM86Nwd7D/ZfjHtflwIamwdENgoRl4EFgDQks2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  static inline void native_load_gs_index(unsigned int selector)  {
> > -	unsigned long flags;
> > -
> > -	local_irq_save(flags);
> >  	asm_load_gs_index(selector);
> > -	local_irq_restore(flags);
> >  }
>=20
> static inline void native_load_gs_index(unsigned int selector) {
> 	unsigned long flags;
>=20
>         if (cpu_feature_enabled(LKGS)) {
>               native_lkgs(selector);
>         } else {
> 	      local_irq_save(flags);
>               asm_load_gs_index(selector);
> 	      local_irq_restore(flags);
>        }
> }
>=20
> For paravirt enabled kernels we want during feature detection:
>=20
>         if (cpu_feature_enabled(LKGS)))
>         	pv_ops.cpu.load_gs_index =3D native_lkgs;

If we use static_cpu_has in native_load_gs_index
       if (static_cpu_has(X86_FEATURE_LKGS)) {
               native_lkgs(selector);
       }

We don't have to change pv_ops.cpu.load_gs_index, right?

Thanks!
Xin

>=20
> No?
>=20
> Thanks,
>=20
>         tglx
