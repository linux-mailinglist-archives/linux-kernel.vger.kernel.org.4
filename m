Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B79E742789
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF2NjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjF2NjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:39:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24CE72;
        Thu, 29 Jun 2023 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688045938; x=1719581938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PxjZA+MX8njClpip9OQvKmeMWHv4e6NKGrvhp778O78=;
  b=OGEYaMZmr77nR01arroFN4+/HZxYAG9U55x5jLbhAdFTgu0vIiFRRFen
   CUIcTQPFsG7FUVIkA2CAh9p5gQIQtTY6Ct+NLyYFHLuYIn9vrC1f3AwBS
   b0ltsaTWAsAgBFHQ0faegNXQ6m4kmnBXOkOFaa9sPCbR8UsRaTzdRZwFt
   nvFkqjL/wOLLrcUJ4Sxs0DSJlj7n5bAaT8y1IJd0xYgDOx8dvMn8y3nel
   lts+eah4RzpwgfdatMPnLJ0LAYA2Ds7/I8p3c1uP1RcUdlx6IlPk5yO0f
   SbY9YQXAb5BCa9azV6b/WN4qDPPdLcjwOc6eih9Nk62iJELqV5bnDDFEi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="362143757"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362143757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="667520530"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="667520530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2023 06:38:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 06:38:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 06:38:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 06:38:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 06:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdEsXb4ox/ta5y2XHoFgHp2MAtGmD0cOeGWaR1mw+eSC4fvmWFkH84SLzCFQbWB01cdYIgvSNGiHRDyi3eD4h0cbmjEYrzVx2skDKrfCIPyGVt/dco7qeJERi0DuFJgwmHlp9TBSSTNIovYHzfvJ+BNXkKmRLKtE8ApTDiMKP1kLtehKNzOo++sI03VHEF21bEbpqp/vSZ8nERQ09nufRSffeMJBy2Wma6m4OVW0lbiLpsSUw2Hy56GkbFGP+ef6gTUV+9QHr95s9OccOhSSyPCLivDbjqZWjDPmggYdFjUIXizT5uoLiremw4uzU1xQGE1gGqkC4gDYuYGBe5alMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxjZA+MX8njClpip9OQvKmeMWHv4e6NKGrvhp778O78=;
 b=Dm40ZsqXLy3zkhWxsVsjxRZkPqsI1uKu9HzZJ258yy8yp0kEleC7kmTwlzrQgoHcSPIa1qmjYMYjrza5OxBrKASqpJ0TToOV7S5jFQYKqtQC9h/KsIJBW4CEklBXH5a5Om4BNdrFrgVzFje281HmgXPgn/PdQJCt2ByopYpfDTisSI5jjgSmrLCWYWBsZ6UCvihdGA+9xZeKrHGWAEw6E2tey7scjC8jPDqwKJDvtVQ5Ntm4juvXgA/Hiybe6NCYtZG4aEfWnhRxJuUmnlnsKRLK6bxBleFPxli4H+3K0UXPo2d5OSozrtqU7j/KHzKhyZ1U4x5/WPPxVsV9aBtWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SN7PR11MB7665.namprd11.prod.outlook.com (2603:10b6:806:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 13:38:47 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2134:60a2:3968:7298]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2134:60a2:3968:7298%2]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:38:47 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     Simon Horman <simon.horman@corigine.com>,
        ivecera <ivecera@redhat.com>
CC:     Ma Yuying <yuma@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next 1/2] i40e: Add helper for VF
 inited state check with timeout
Thread-Topic: [Intel-wired-lan] [PATCH net-next 1/2] i40e: Add helper for VF
 inited state check with timeout
Thread-Index: AQHZnfDqW77qZiYSJU2MiRP99p5Z1q+J99UAgBfqPyA=
Date:   Thu, 29 Jun 2023 13:38:46 +0000
Message-ID: <BL0PR11MB3521138C37EF50D657065CDF8F25A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230613121610.137654-1-ivecera@redhat.com>
 <ZIl5nM7sl1lJn0F5@corigine.com>
In-Reply-To: <ZIl5nM7sl1lJn0F5@corigine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SN7PR11MB7665:EE_
x-ms-office365-filtering-correlation-id: 4d558890-1493-4f14-1f9f-08db78a62a23
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYMcn4GMSN2ahvku4y+nSPTbilKfilpmLG0z517bG1phvjTBQx7uMNpnhhLrs8X+etKUz9+I79Z8G7pK1iPGjSF9dlVRzDC+UM78Fh9hYpiYrTX+/GsKsGPpMwkaO2ejoCkws/rgFTV/1SlqH6Vx8taKx+zJ5/sblPJs4xEqINo7EE4k42lCjMSyfl1Ce070HGiubdxLKPAzMucA+S4WquxpqpMY66EHUBto9op6QUeic7/M74YLOhQytaN5ZR/rXq/abprkyGqym2s81gTIiY6FVQEhkLR/3mFG/TgJdRjJsdula3cCdEciZ6xnT5k+Kt9Q8SZIb869Xzx7/dk+fC1V9L6TVCHRI/X8JulyxNT1sF3pKd9I5SrquE1PQvxmmsa1f5IjFpasV4WUAGpkP3373io0Xuufm0mgc/FkTV7fIchxPxTLQK8i19cT5GU9p5nX/y21zFM3m5mlMel5lfMzazMI7uYZvB9DnDjkgEeVPW51Cqu9sA/NPT+5B1GqITGazjjksYgsHFInryyvmDEFvMV4XLO0Dr7oAPLINK7MDk2jP48E1wmtpLIwjGVhrE/1nX8xtKfGr22RCRUVK68QUXWNnp5L3fQrpHn2lW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(41300700001)(966005)(316002)(83380400001)(86362001)(38070700005)(53546011)(186003)(52536014)(9686003)(6506007)(26005)(7416002)(4744005)(2906002)(33656002)(82960400001)(122000001)(38100700002)(55016003)(5660300002)(8676002)(8936002)(478600001)(71200400001)(110136005)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ADEMWqU4hXW12tGi5eZploT4lXxkw0+oYJBZBl8TEE83caxBoXAlCPMOQf?=
 =?iso-8859-2?Q?8JNwV4n5V9kOhUOMYBgrQenoQBCqEXw0bXJp27UPkU5fJph0i4Z9YzbQH7?=
 =?iso-8859-2?Q?ofvgdHQOD54S0kmhL9h9awHPbT6V3KmrtfmDd+q19PjpPGaJIPLvm8VnAc?=
 =?iso-8859-2?Q?8yqADLwtXTuWumIcOhX2ZrYYVs2vCr4KYttAMmpUv4WIyOKkZA11F03Fnm?=
 =?iso-8859-2?Q?vTrLCGJRpoHu97TUfAFf5CJOxUQ9Wx6qunZ+HBGzwa2rcmjQY1L3/+njWu?=
 =?iso-8859-2?Q?wqkV+vlMZ3fMM9LlnXoU6dW9a16HJ48Ik/wmnCYX54sR/KeslGBwl2ECI+?=
 =?iso-8859-2?Q?T+wRZ4naBmfG/UfURJPfeeb60Hu2QYjkrvlitsS6fnsq2bxUCe0LriCwUu?=
 =?iso-8859-2?Q?20koxzJLwnMLB4lCecid2kkL6rNiFCRUkCabrK3xRZIgTdOtHwYdjIcTgb?=
 =?iso-8859-2?Q?QGMdmbZmJExdkbotJRXKP+sdzkx5D5KPHR+SZz2leK8Bw0YRsic/VZELKf?=
 =?iso-8859-2?Q?wBjukPuZTMKB+OHHCoUCuTZdHmfWQpZOKiYmHK5vEnACk9gi9ALrVzdmdN?=
 =?iso-8859-2?Q?fVgyhDH3NwIsEFEPR+JOaKGIRol50VnD10P/LKJWOGiF2dgLUStgnzLVCm?=
 =?iso-8859-2?Q?ZUqDEMfPmYv1QzWMILG1goEFHqfn0DPrMm9tjABBUN8Wznjly8gMbgvHZ5?=
 =?iso-8859-2?Q?JpEphw1qr87JMj+9w5i+O5iovOiYBe4++d4/IFamJOMEB8B094oKT6KOo8?=
 =?iso-8859-2?Q?3xtmwv9hM3VL9ftVH2kR1ILzYyIxEUTdrLlcQWQG+gRayCGSq6APWKX5GW?=
 =?iso-8859-2?Q?JGLshg3WkwvwfjzKOn3QCOyc6+PyZeM8+QESiLhNdyHoCTW1iPUJooVgj/?=
 =?iso-8859-2?Q?lJ51qFSS55rPazrqyKmgZzU8Vz512Tg40Y1R0sA20MdrnhtV66cT/1IR5u?=
 =?iso-8859-2?Q?aNWt18Ue+wvl4PiZ9NT8wkUvuEChXiG1lgoqh24B+uDmf2aUXMXZ045iZW?=
 =?iso-8859-2?Q?zDvd9q1k55DPZBJs/heOFS44OiPcUIafc2unkRKhH1AsOIIh9hWG8Ompze?=
 =?iso-8859-2?Q?5Gk059jgi4QMy6qh8Q5YMW3C37eHM9OMdoTHgv0pccWGopI1bcjeSYPntU?=
 =?iso-8859-2?Q?M9EO86Mz12yHcDOpzAFtOCb8AhI1tiSAMRQe0NMONpswJzb29Aut8Far6P?=
 =?iso-8859-2?Q?ir1FHFwwM8kEte6h6zQL0JE+X5yJtN1SVpOU/wVenvFmKAbY81gUk7LDZ4?=
 =?iso-8859-2?Q?wDlRRYK3Dlaz37t5xTCf6AiuI/A/BNPyBy9lYZ2203VEBPPNX+53A3d+8/?=
 =?iso-8859-2?Q?BRKUF26AC3gMsZMAlBLTRITsIBJPa3m2YrSzeJ0dWwbLBtV8gW3y4tf6tK?=
 =?iso-8859-2?Q?MAjQJ9WVGjSTaCiXa2xwApsI5frYKQWrOgsKq8pQ+fpN8KFsmUMMypj/3E?=
 =?iso-8859-2?Q?vqoEb0ztgAFJibPMs6GndU93uM8fLi7LNelGCBFn5/SuwFASrtlDmMKtR4?=
 =?iso-8859-2?Q?eAUikoaUF5WUByRM4bPVNdIO8WPxS2idk/+mZ11RdzoPIWmkqh44YzKL1s?=
 =?iso-8859-2?Q?IXZqVl2T8A0YnVmRQjEWgQxxYCytSO3W1yIJlewFriCK+RdmuxgNHu+1MM?=
 =?iso-8859-2?Q?RFDLQeVekMbDUjkkgo9eDq/uGl5NNx2lmPR6WzpbvzOHl4qzwl4eXhlw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d558890-1493-4f14-1f9f-08db78a62a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 13:38:46.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ifS/DhSgE3PR1/1bIlxT7sxLnh0AsAA1Bs8O6oao4D0k5lwU96yLSRROx6VD4ja2NgSvJcqdvwsWPl5RjVaYQI/PGssVriq3jnbUk3ujRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7665
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: =B6roda, 14 czerwca 2023 10:26
> To: ivecera <ivecera@redhat.com>
> Cc: Ma Yuying <yuma@redhat.com>; netdev@vger.kernel.org; Brandeburg,
> Jesse <jesse.brandeburg@intel.com>; open list <linux-
> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; moderated list:INTEL ETHERNET
> DRIVERS <intel-wired-lan@lists.osuosl.org>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] i40e: Add helper for =
VF
> inited state check with timeout
>=20
> On Tue, Jun 13, 2023 at 02:16:09PM +0200, Ivan Vecera wrote:
> > Move the check for VF inited state (with optional up-to 300ms timeout
> > to separate helper i40e_check_vf_init_timeout() that will be used in
> > the following commit.
> >
> > Tested-by: Ma Yuying <yuma@redhat.com>
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>=20
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>=20
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



