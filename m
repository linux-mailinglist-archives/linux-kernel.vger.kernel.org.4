Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B010B7338F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjFPTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFPTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:03:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089493C3E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686942202; x=1718478202;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eRb0XHZch0TOsTWleJgyBw0beQXG1+mC838nqLSZK8Y=;
  b=DObk4YvOXtUrXrttv4JmCUmVIksUeexngnnF+XtpRjjLKZKDa4VN9r3w
   HD09SYFN6d8ECFTGBHefFYhGepDmg528fAcHp0YxZiOnrWdOEWWp2EIUp
   6obVeU7b4xb4qcYnJpkEkn46hNoVz/XETJecK/YfKobc6ZstB14EJVX0i
   yf3dWGbqz9RHCX4Yzqho90iz12Astny6DjcQWRof0nnDz8wB9Ys1oUSxb
   PbX5SYKiXY0QGLYS5v4iu+WBh1T0IA+mhXbRpkxZWzpqW9P24PfD8YhiO
   yEhjkiIotOQHg1GlLkPw7BCGnRkbuIQNoXC4di1NPkRZOsHfRT1YGZGF9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361822995"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="361822995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 12:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="857506950"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="857506950"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2023 12:03:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 12:03:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 12:03:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 12:03:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 12:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1v0JmbVylptge/NH8hSKHwo4LwNQeUFtnTmnw8KUOJUEoAY+oee5yIc9hbWwxLGypeP/0UlKO/Qy6k6QjuygE1m6upaBxDPNXIMshHyzY/44IJxSVimvyD19EBCVLpqI+H3ktdYqhuHASjwnHX85//U0kMBO73kdT8/9BpwDf6tIwkqLPoYA+URpTguuabw9frn5mEQcrOidFotLZWANux/Ny5HenhZPZLZxIey5a8n0rsp3okRKe8lKU2TxZ0NBtw7HY6LYTwOQjdhozqE8phAGgry88/U0Z7uYCUgwW+rOzBSL79Kj/yS0Vi9rZTwIw31H3CZUJInSYPG0bKdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmzPtz8ABcKaeD2gXZO7dUOx2SCyQlbeLtcDDoLm1Zk=;
 b=EV77uNaExHrnH+Wxh15B9AKuVbR/J76WUYwxCY4V5lEG8I8pBNx4xebj1YcZzkwEVF6yxlkGvfk5TE9ogn/+ICl6YwrW6EBOM9XT44DKgdhPmTO/ccJj+EYBWxA7gtGYt9zYAsrfDTgK8RL7s2LAiBLRY9PF4IZ6icPRO8tGxmF9r9egZs5rt4bd8b1+rL18S9GaUQOKpDYVTvA2OcofWe48dWnWy5Ct7Y0Qc9sgf2B+X9Qg4RdVfuYixaX71ed5D0HDc5ZJh0HkGzYxf5h3ZmAVJ0v6h4AXxG17iu/Xg7gvtUcw15mpqCGQ4WE97Fk4bK5NvVsVWTpEZh27BmRtPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 16 Jun
 2023 19:03:16 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 19:03:16 +0000
Date:   Fri, 16 Jun 2023 12:03:13 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Ashok Raj <ashok_raj@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric Biederman" <ebiederm@xmission.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        Andrea Bolognani <abologna@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Message-ID: <ZIyx8XTkLSgvFZX0@a4bf019067fa.jf.intel.com>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx>
 <ZICuhZHCqSYvR4IO@araj-dh-work>
 <ZIC/b+AwvH2wIz/o@google.com>
 <ZIECZMHxtEYnuBAJ@araj-dh-work>
 <ZIFPDvsKGZ7MVSMt@google.com>
 <ZIx6xCgdILbjcw7H@a4bf019067fa.jf.intel.com>
 <ZIyxPbtwwObi0Qkv@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIyxPbtwwObi0Qkv@google.com>
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW4PR11MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: c3182d02-b79a-4047-b2e5-08db6e9c5741
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGGeAX7OLTF0pJ4y7wkcam7YfuJ3dQf7Mvuf+3DMW0xYfBYBC0v78IDj4bSvIVxJm2QP1y0UmtYNsN5Afn3UNxU3Ub2t3+uS9w3ZZaYnSW0nyswS+95C8/79Phl7EDzg7D/br976DJ4eaftlOrX/4RPYrmZIpkn8azm+6Tfsetb4u1755A9Qx/E1OG0P6LCYKF3utoc7d45FM/yLculQ0hCJFd4Rv4oLuJvVOjgCBGRz3PtIZNxli8bBVotto4AhNn9eDvd7QZKVDiqNItQDt0TKmO9Rl/qPghxALWQiPmo5lMvgUqEv/hPnBc46Pgq+s8vnf2hYyTwSi/glU1UZforOp3wt0UlO8vLHD3QEaEh6ZiF13+2Y3HyIc677cJ9OLl0Dq0ahhwe7FU/XBpVVkhq2MuwRxPhdSvxxkgCwOssUhgZXkliRPsxIp8kksmZnkiC8VrMmczepm0zfexxXxfXDJd1M6SC5O+pNx5WIgLexHxfXIXzypZ0LbJikS2D996gEdutI+hFyjI+tEi14jC3HjKkCJoF2ZLTnVsAjItGV4uOKoBMe6FcIE6J1DS8/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(316002)(6486002)(41300700001)(6512007)(86362001)(44832011)(83380400001)(186003)(4744005)(26005)(7416002)(6506007)(2906002)(82960400001)(38100700002)(5660300002)(8936002)(8676002)(66946007)(66476007)(66556008)(54906003)(6666004)(478600001)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2OGlLS4f41F1SF+ZuOzBQBwbjUG8nMpN9FwSBrCRBJl2L5xrNoIVWSh+y3H?=
 =?us-ascii?Q?vGR2JNCke9n9HFhrDMdKCEa3Lm/TJqeEywTYx+/7fAaz9AbPaGoalBQSsAgm?=
 =?us-ascii?Q?4uNDDPAuNeDCwvWJZ6YIJqXHth+FTWS7yI57W8nlRFlmpKzmPmJ5tY1onRid?=
 =?us-ascii?Q?NEraT2OeETXjXHRrXgyvihWca01zxPHD3Ts4v+nQoHZEZmDOP9SA43LFgGbJ?=
 =?us-ascii?Q?e66mR3IFrgrFFb3qtCyRpj+35aRfOGQj8gcQtcAqhCLpQJMa2Gzs4fXwarWJ?=
 =?us-ascii?Q?KcJmY9LlSp0U2PmmysGZxRbagwo8diFbPSZ/rZMvDqdi1vIqNyFckgP0YJbT?=
 =?us-ascii?Q?MOXbfBa2Ea4dh512LeVj6345WQufFqYm9cq6qzl7u4czigOprxh9ql8QMcd+?=
 =?us-ascii?Q?CJHoLbNAIQ/bGM+scT1jrTaLeSLmqJO+Ub+E05lMoQd5YvpyWET1XJ2VuxAR?=
 =?us-ascii?Q?az6hwboR+heTSGJ5dzOhaR7uZzTdRipgau3stwEUkBRcQyNv5S5RhWP87rN2?=
 =?us-ascii?Q?X6/iefBAp0rtMaI+YEAxa5iFQBu1u1545EYmnbXOE35wyTe27EzesltsB9se?=
 =?us-ascii?Q?x+oOLFH95ssg0kLh+StlXFSSVf6OGr5cIp0RxZSBoKkoxCwffPTBJrY5FGYh?=
 =?us-ascii?Q?Z2Y7u78QzqpoTIKNiAuY7O8lLbTFbhnGn2JJcQ7dgKtLnWJDeNedF8DValvD?=
 =?us-ascii?Q?fSI1Khif8GtFTub0jLrSG+B+GV7u9b3JFKBu9bE3l6i5dWJ/LjR3aehh+6yv?=
 =?us-ascii?Q?12iahwVA7sM+qoNdl+ZZ5Hg95yypEIEf7UvzMvH/sfnHExSw9Tjn7ADXO67B?=
 =?us-ascii?Q?zH0p51opInjbLs1+QUbu1GgH6r/dEb7NHbwDaxhHyWo08sgVL9uE/ognsQc2?=
 =?us-ascii?Q?IU9oGnKdbItB/dWW398jCCqiqdgy+iWZ7S6buc/xQfMFemGrhph98Yk17F0e?=
 =?us-ascii?Q?DjI+YDP/G7QFShqe4g9CffwJYCFNpTg/CoReeyVx9BLsiPz/rQs4QE3bN4UF?=
 =?us-ascii?Q?JyrAbMawwOgMR7ihToRYVKtSN0aOK2yIMkPemd/SZgQHcLb9ZQwSF7HvhJuw?=
 =?us-ascii?Q?Kw4iiwhn+5xlZqMqt4TmmeTpqoHMU4l5sZSmq9vcxFl6aR2MqjIJgPiTwqRD?=
 =?us-ascii?Q?b88uqUl2U3O0mZgH0+xu/IbWhj0COyx7N3eJ3xzXqH9zW6lhzvUIY2pYpBmX?=
 =?us-ascii?Q?nXgShqb/Odm/QMGyqZyK5CwQmokSj6zspe5x11qbcq3U32aysXTVrpDS514o?=
 =?us-ascii?Q?Nt2gd+ks7F0893mHgXeTvH+WHdcK2ihgBDzBy2rSMygfUli/9tiJ6hRUN4uI?=
 =?us-ascii?Q?fwhNFLCcaEPQhr7CAYLjZm/WLPsLbp51B2Sj1lnw9XtcxKymOUXhOU8bd9QZ?=
 =?us-ascii?Q?DmV6MF8++p0j1lOTPRSXrgR8zfuVg7CUaVS+qfoeHb0aW0t+pVo3VpXDYpIg?=
 =?us-ascii?Q?HW+GvavtBlXbaNycZwdJIDwcajS4kPxfk3RD/Hd7HQEy3D9hnzz4jBB4h1ae?=
 =?us-ascii?Q?dgO5rccTI4qlhwkfmfNe6cn3ETCDAoYShAHntpQt6fgWLu9rWlpnPXi/gMOl?=
 =?us-ascii?Q?7noaTA9eEwk5Dqw7pdW+Qbd1DUq8X3xw70WtBbOSHRXfzVV39lUiuwdV1wFm?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3182d02-b79a-4047-b2e5-08db6e9c5741
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 19:03:16.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+uyU4XFq7Jni8VJt0PlYVsS7PYWDvYIvNRWs20aeEValVhtUby9qY38wsrk5K6j2IGSERVR2OzGniyZ3+MgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
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

On Fri, Jun 16, 2023 at 12:00:13PM -0700, Sean Christopherson wrote:
> > Would this qualify for the smoke test pass? I'll continue to look for a
> > secure boot install if this doesn't close it, just haven't landed at the
> > right spot yet.
> 
> Good enough for me, thanks much!

Thanks a ton Sean.. if anything you have now scared me there is life for
SMM afterall even in a guest :-)... Completely took me by surprise!

Cheers,
Ashok
