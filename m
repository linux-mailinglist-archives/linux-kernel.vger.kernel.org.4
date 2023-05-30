Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4D7170A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjE3WVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjE3WVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:21:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811F93;
        Tue, 30 May 2023 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685485295; x=1717021295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i7R1/hsq6+c2YuBhP6dqTvhP7OmSa3UQWfm7qbsfAi8=;
  b=Q1Ps103nqfMunKs01Uh4haZHCuF2msz1PD4uHna4ziv0s7Q41U52M5D9
   gXNM+fyaG6lspLYJYA5/Ley8e4WCpTtwv09eUZheGA3i5+f+JHzA1kztC
   BcAjiiKKroaUasrWUF+51h8XUZZ4yvw8QgjFsCOSsTBc8krQnJ2B/loy4
   eASRZYZ4dtIQZSftlFCQGhFIGuOpaHFnQuQf5Cme3GfNlsjfry3bn3F24
   DRTSaG7hhIy+ShzETg/8tcPzP+4L9lVEZxE/pMJ9LN6fkVjFhBemm4ZoQ
   n2bHCOkp5uv1Dkvv/MrW0+JgHfd/l47WpTgTSC6hXwB99lv1w2EXSNBtS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418549439"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="418549439"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 15:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036772240"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036772240"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2023 15:21:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:21:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:21:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 15:21:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 15:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5ZqTHy7x9gfTa7YP5uMcWTP80BETU317EreBrdtCCyhStGV+YgGg78PA+8j8PQ9GZ66IY+w9OpG5Cp9kyLhAhDEKW/lS42Mor3qtntGIk2pWbcxXADr5rHPy2F4aU7K48pW5rrice7EIfepGQRtL3lhtqhO9amndPgL79VTIF3DP1nkFIkqWrX/gyMHSTeS0V+oCGcCgavVYQX6iNzeOfhEggpmToAZPHyA3ayCwZ5GuTvFyr28b5RrgjNcTCuLoqOoYdb08nZk0UuRaqZwwpxYZ3mGdNbDCN4nyO8+BXeJ6znd60WNeoYylHggC++senyam/kaszJ+9kCNNk8N/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8t4Rg0e/3qeq+PMBV842P44Soa4DTNhU0iQj3p7Ips=;
 b=hE7Jgv7PviU/MnBTjLpmgsb4T2iZBZXkeZomvLmPuw93BxPPfvH+f44fXNEQk+pFD39/37HL0NclOvxAOOCRmrnyhhEhJihUBAGKWFE4LH2Zz9L8a6ehyBzOOUO79PfO+fy1laLnPE8mgcj9kNnNKU3gUkhBoN17zT2zXBm6luMHo+FrLyTbU1TnYZseexh4bLAJ10T94Ip9w0l3R/0B2Qm4oMpdk9Hfyod5Qy1BYMgw5wG9+LHv4mqQZtst09oJGgvJ6c0Nk9ga0CmD6VQqDYLFIM22efDL9mXCorM6g8Wx2/utlJoFTe8iY5xAwZce2iB7SUf6goeLGXQWx8cKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:21:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:21:24 +0000
Date:   Tue, 30 May 2023 15:21:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"'
Message-ID: <647676e1e5973_168e29477@dwillia2-xfh.jf.intel.com.notmuch>
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
 <ZHZxdz6TSkf7aBJD@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHZxdz6TSkf7aBJD@bombadil.infradead.org>
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: a36a1395-c087-4221-4da9-08db615c3411
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36YLDYTlZe/odpizb2ZiWLv2NNCM/P0Og3bV8167yjX+ziGcKuJUjbHENOUpmzgoL6nDQOTmVykpIeQV7UzGS6+sSH8d8LMLcfcMfwXn4sZ3wQm/tVg8lvxLjsR+6UMsplRnvkPCYYDuS7eRM3VNdVJSdO1Cv8IsLxQ1QsID0Sn3QoFvIkhkOFLzGOK/R17ovBe9McEUYoMFFPwaBLlVF9z56UotuEWIv6nLUU1EV7MhVMXf9kHHuI+bQvgZYxqhEiPe1bIP3vKqnF2gcSnD6+W04owmvDa1ZW9idggi76563z7wKdR4ett0qisCyVuWId/LNOc+NGwJXu3+14Oj4Mf6pvp+F6OBPExuaUzw32UsCJw9IsqMZK24FGqvxhuoYFqS7k1vkLMxMN8EPSQYxALc1pzmmQm9Q397HbtyxfJuY/ylhF783FUWzT18GOzLOsCaCjd6fdqgNc2rIKVcLuZ2Nvrhyv2e80AlbDSbufN9EwD+uwYKNKctrAJvIkWorpSnEHh/WOiyY2u6zkv5uB/fepayct0JZTe2I6SHNpNmHc+iOiSJ0PQS+AyB+Aaf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(186003)(38100700002)(41300700001)(9686003)(6512007)(26005)(6506007)(6486002)(6666004)(478600001)(8676002)(54906003)(110136005)(66946007)(66476007)(4326008)(82960400001)(316002)(8936002)(66556008)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ONx22zXcnavd4u1ShNTSC0moM2pncuUKDZfGjtZxl8pCHBGRhaqctoYmmw4C?=
 =?us-ascii?Q?PLlbY0ZBWBdTcTtwYJFXsJQUql/bSZ9BZNJimbNBq4zBZywQr04/cyMicrff?=
 =?us-ascii?Q?M0R1if6tGIgDuZD1zyCZqG2/aAvUKcJQdLBgRDInJqMZEtoZ+18V720MUMZg?=
 =?us-ascii?Q?3i4F4fM+6ZpTfoY9in9EeGltuXdpzqAkpOfMYmp8AwVq9Hpu0rKhLgJ0B9ZJ?=
 =?us-ascii?Q?T/zf30gcwDuQRZEKMEDC75ScV14lM1pNQ+tLQtjEr0dz7QTClXZBuaSD205u?=
 =?us-ascii?Q?yhoI5gfXNMVPSDuzgte6FTyQ1udwRI6kcccGexH6wjrkf9DpbJeBjJkIBMmU?=
 =?us-ascii?Q?7mPBS+P64ATAY7Y8WyFGKxBbAtBMTx7/mY2gGmgsM5ZTrW3qZlsAUMZ1c71u?=
 =?us-ascii?Q?dayqmns4J2piKQBgqzLtirXl/Vx5b8/h/JQ/pNPS/JG5Mt0tsLAyniNQpvyt?=
 =?us-ascii?Q?uoAE320Tmh+X/znCYxGmyj1oAw+G8fSYc/vJK532WetdJPED3tE9u2BoeWUo?=
 =?us-ascii?Q?gNLhvGBsNFi1LNTaCQdvqc+xHzobiqJxnn1cPYcFKWc8r5P+r1smgjgLMj35?=
 =?us-ascii?Q?cuA0wnweWm0tyq/zrrVIQe4jQDliN49tT+b13YulAZJGdOtbhHh78Te178X4?=
 =?us-ascii?Q?0jxRI+fAwzFLSfF7H4nwaLZ9h7Evndi5FFOfCXpc+yYWgbKHDjO9x9hZdfKR?=
 =?us-ascii?Q?06c5HEhbB3WcDeatIavW+SlkyNsCgB54RdThHzkjR8WNBjCsY2H8mGaD8w1i?=
 =?us-ascii?Q?Wq6ZuFyD88iYkHbw+uhM2jBNiJs17OvPGDbzMRVbcHqvrriObSfJunSj41cn?=
 =?us-ascii?Q?yS2CHFqNQFHQzMw7PaomMX2a2jYC1h6coTq8PShFiHQcRfrW1NJ4Zc374eGz?=
 =?us-ascii?Q?AhkJVg/oGvsgHrWMv9m3ZB49MUp4BrMG352u1HTB2CBZVqGO4jFn1GrFLoEn?=
 =?us-ascii?Q?xr539cqalWd+JgYo2/hlOImERXD8HktlX6qAs0L1ficKVma85q1roHk6UrCr?=
 =?us-ascii?Q?MfBH6UIIKdRyJCnTXZlUnhxADH/9zD8OTxovP4k46dVikjBDBI1GirNjS7qD?=
 =?us-ascii?Q?RtwuMHTRy1AR+rS9p3DDU1/QZlY56HYIbax0kHSc9QjhaffCl3Oj05Agplef?=
 =?us-ascii?Q?eSa7U2IgbNTiRYpr1uyjr8u1AsHADKCiGgZbGNtaC5J0E8He3vmFXmdN9xpK?=
 =?us-ascii?Q?9T4OtXp0Gam7Rf8EX2OOgfTcwmirOjQHWcprUI/DKqdoryxn7bHiT9LYa3l3?=
 =?us-ascii?Q?JRXUk1U9kYpHXIrLp281k2MO1jIv8492y7slx59OYYJ4LDeddb7JFXpzg4UZ?=
 =?us-ascii?Q?UJIgOG3Sw7HZSl5ImatbgFjCBQDakY8eoPr8jfiz9O73zrUVi7OaY8GMlgyV?=
 =?us-ascii?Q?q4NrIwM8DDwzmODYnRjRcrwB3vuGKx2WMn+PggIHG03KuilDtdrWZ0Dl36Go?=
 =?us-ascii?Q?3YKkB1OX/Y+lt1JsWAy9myUYs6ksnYsYTSlmRBT9+114Agtf05AUfA99iqeP?=
 =?us-ascii?Q?LE1Wb795agPBWnkC7uOHax2DtZzelb1YNakwS6C8LGAdGxfDPiK3XOQMdjeH?=
 =?us-ascii?Q?YgXSDUpb/O4kdNilegkXO3N8/Q8S90LVkTxXW046zIMJy085Cj6xMpuoNSej?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a36a1395-c087-4221-4da9-08db615c3411
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:21:24.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IsZ7qpXKoEt4A1nVuh/qGnHRHAIMB3XV/VWqUVLg+k+Sma2SdGwbjUcqP4t6uGdQYxuJGswUyc+EipvjynGXMZ4T7KTtcyg97gIjKYQZJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> On Tue, May 30, 2023 at 02:43:12PM -0700, Dan Williams wrote:
> > [ add linux-cxl ]
> > 
> > Sedat Dilek wrote:
> > > Hi,
> > > 
> > > after building Linux v6.4-rc4 I can NOT boot into my Debian GNU/Linux
> > > AMD64 system with root-ext4 (/dev/sdc2 - of course using UUID in
> > > /etc/fstab).
> > 
> > I did not find a mailing-list thread for "9828ed3f695a module: error out early
> > on concurrent load of the same module file", so replying here. This
> > commit breaks the basic CXL smoke test of loading the combination of
> > cxl_acpi, cxl_pci, and cxl_mem modules.
> > 
> > Just wanted to highlight this a test case for the next attempt at this
> > fix.
> 
> The revert has already been done:

Yup, found that shortly after.

> 
> commit ac2263b588dffd3a1efd7ed0b156ea6c5aea200d
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon May 29 06:40:33 2023 -0400
> 
>     Revert "module: error out early on concurrent load of the same
>     module file"
> 
> The smoke test, is this the ndctl cxl tests with the mock driver? If so
> then I could use it to test future efforts for alternatives for this
> work before any new changes get merged.

In this case this was even before running those. I typically just run
"cxl list" on my base QEMU config, and if it comes up empty then
something regressed.
