Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0170B584
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjEVG4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjEVGzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:55:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7F268B;
        Sun, 21 May 2023 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684738405; x=1716274405;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iY5WTy1wK5W3m3YTF/EpoGnEG0FrvQnoK2oM01QKM9M=;
  b=jYaB5AdWjJHxV6z7lrrOrdz/XYqVXYf4bfD7E2Fxfcj8mKaXhmD+KQIv
   llGXWjbUPsylOy8D+cgMumG5CfNOFOOlxI0fn7Mr8P2MOH+eDuvED8Asf
   Br2c+JzgJ5PVp4+hkhtqNUTWvQjF2crglDDHn41+q9GCU3Gc4RGMcvL50
   +mCyhAegXG2ktqZaK+fTHWhY95ho0/prMz2n1m1OiKMNT5ma5RaMc2F2Y
   YhGhxsW9mD+TgjQh77vDpYlDeSoTqmUx88csrZ0tElICJTl33ghDwbjqa
   /LI/dA7N1joDXJ5qXPfBl1UvDfX0yHR/QhMiaENQGMGcvYwfBwEUhtogy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="342295270"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="342295270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 23:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="680850441"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="680850441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2023 23:53:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 23:53:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 23:53:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 21 May 2023 23:53:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 21 May 2023 23:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFZSkqrTD/8BVxfG7swUDhrA0y5VoWSYehaWmDuUK59pKwa0IYCBdEOVaTX4lnmoVJAf/r8VF2fMuTlJ4etSMf5l2EBcl9k7Vw0MHbvbSviY9V4vqRjc1w2XiRz3bHoRDsXQvQMSGBMIdVXlqlbezaebejPt5RNJ6jNKv8OPlEnM2fq2WzZetEChPXCb9pkyKRRPPDTFOkAjzUKaAgfNOvwN32Q2qu+GgfWV+xITYal2WKpfxjZLzF3jfA/Hn9Va6laJSONKkxWGsu6h3PBrt70d0Bvcww0uYO72iV7CYs376U5+CifB3lH4pnZSLwEdfJZge/xCKoNSXoGoi2MN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxVIO94zQv2N/gaB0wITD5vFDeXjv8dA1TXrUyuoGqs=;
 b=mBqu4ac6qwpc0BulH5nUSzIqVGqVjhiJ7vSlbRNOo6K+Y7qtTQq3uJ1snSGECSCERZHiuvNFKlwXD4SXY3giTUPO8dN8F9JnLdePTcb7nFCwe0KMW0Ox4U+MrM+FHaCol/i2nwI5eGougb3AkMaIn0no7UdON5KKLmOX6ee5e/eMaGldMjUF0dgXByLMjGiL77vJwkos9g0141dyGB8CnO4GC3XjtDzrFxoNMUwtTQv3+ZpXRdrwT8HQFuJ3oYM3R1WkCtpZRKjjNBigfugtLeumIQcMwYi4Dma1BAAsHa0R3T5zw8MQlzCIuqjSrAopVU6L8RCSuhxsvto25LQOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 06:53:21 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2dbc:e5ec:2032:55b5]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2dbc:e5ec:2032:55b5%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 06:53:21 +0000
Date:   Mon, 22 May 2023 14:53:10 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     <oe-kbuild-all@lists.linux.dev>, Ard Biesheuvel <ardb@kernel.org>,
        Guo Ren <guoren@kernel.org>, <linux-csky@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] certs: buffer stderr from openssl unless error
Message-ID: <ZGsRVrTFzi25fKYQ@rli9-mobl>
References: <20230517-genkey-v1-1-b887424da4a8@google.com>
 <202305181712.xjvv1fbD-lkp@intel.com>
 <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MN2PR11MB4712:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d09bb6a-b37f-4557-53b9-08db5a913acf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30MnUWO8oyRbIqOSTa+fLyuWWbXFCqxVsx2Ae8le/L+tLyR8aPieReRDJLd9l9iGciXWOaWVyFOlukmfNLGwiBEyx8Ifoeo82Pz4vAfl7L9zZePvpqTY27tiTOCF+5pFce816JDLzNkEFwg6mm5a2dFmmfI15rPIlmt3E4PkpkNDQv4dGajFShVZ4oSKwMR/hijgDWzL1J100A0ZdjzYFwD2z9zmTqRTuuIhGkZuleSiqUf4oKQnlYabq9QNtk4nBSBJGA0ElibNNguA79NsWJGTbw2KW8kfJBQxMjjFQLHNEt7dHJOAy1ilsRxe/twNxrmsFGsMybK+VTxxp7G7JpOzX5LCEIRpeo8Ttl+KxHw4E5JMkWk4En1W+5Ub4MIdzbnKggORNvqxhL3wuKAEYgWQMVCEVZGx6DHwXJtMPvM2QECuqp2f0b/aZrf54Xy7htnGS0zKQAhzRx9y99hVldgOr/fR4p/mDTjBsnkGDiXygPNTGl1OCiJHHYB4zbhDZ27SIlPAQl3M7lABUeb3523ZyeA+I6V/b9Bs80ehCB7pplrJ39BGIj12IWKjmKPfDoFjc2W/qwk9vRrmAYCb0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(44832011)(5660300002)(8936002)(8676002)(83380400001)(2906002)(186003)(33716001)(82960400001)(38100700002)(86362001)(107886003)(6512007)(6506007)(26005)(53546011)(9686003)(966005)(54906003)(316002)(6666004)(478600001)(66556008)(66476007)(6916009)(4326008)(66946007)(6486002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGNMTEowYXBtcVExNFFpbEt5MVVhLzJFTmVkY0lWeFVERG5jak83YjcwdlVj?=
 =?utf-8?B?UDQ5U2tocWhDNnd1NTRwb1NyZmt3UVZhS2Q0ajBvMGJYNlNQOUVnWFh4ZXFh?=
 =?utf-8?B?RVBnNncwa04zS2NUNXVKV3BMM1lwOUNiZU5mdUlucjhuQUZubXl4dVZoV2Y4?=
 =?utf-8?B?TndpcVZPeUJDenpvSUpWOXlrbFZpUWxTeDNBVDNkdnZWbndrOHZCbDg3c2JG?=
 =?utf-8?B?Y3I0Q0t5RlhsVUNGdzYzbUlYMEYwUU1uZ1oveEYybTJnTElJTXU4TEhDUDRX?=
 =?utf-8?B?Q0VjRjJwZ1R3aEFRcTRweVJ3M2FsdWNJVjN2NWxmUUd0aGFPN1JjNjhlT1or?=
 =?utf-8?B?MElLZzVsbjZmNi9kQVFJSjZpWGtGcVpPTGs2ZDBWeTNadzFZMjhGZkdkTm1U?=
 =?utf-8?B?WkUwTjR6eXgzWkJLOG1JMG5lYnR1ZDVJdkI5aUpMKzN3YktEalNqbjJOVHdC?=
 =?utf-8?B?UmJ0ZFBBa1JUUnZHUUVZdWZFWUd3cXhPbVR5MVdPbjBrZlNpcjJKN1FuK3BN?=
 =?utf-8?B?ejVwZGNjbWQreUZHU0xVb2xuWXlabWJGWUU1QUpOKy9Bb3ZjS2RlTFZaQ3Ni?=
 =?utf-8?B?Z3ZhSzVhL2g5cC9rVzJmR2FMVWJwK2J0dncrdWNsN3JrTnVSOFljK3l2TnZQ?=
 =?utf-8?B?eElLUmpTWkM1UFo1YmY4bE1relFDUStoMjBTRFJ1aStSWXppYVhLUGt4TkJW?=
 =?utf-8?B?QUVsNk1GUzJZRjZTUk9ydWk0WDY0K1VHVHdTRWg3UkMvTW11em96Y0hzbERE?=
 =?utf-8?B?d3MwV3htWFdiZTNxNGdvYWJadGtJR3pWYi9LbjcxRlpKTmpVbWZSMzJIZUVI?=
 =?utf-8?B?SHNwSzFia2JOTXgzY2EvVkt3eHVkcFFSR0F6L0Jaa1hUczVqMEUzc2RpdHVW?=
 =?utf-8?B?SUtCeCtCcVlpWE9SRGlwNVRWbmxQTWwxY0dDcVFweExGYk1jampicjF5WTJ3?=
 =?utf-8?B?VlVvekhQcVZHSFU1TlhRT3NDNWdjUXBqNzVJbVBUOXd5bkZteG5FVjQyU25r?=
 =?utf-8?B?dVVnUUx6dXB3S0k2RXo1Q25DZDUvdks5R0dDeHFjRGFQWGJsYVNQL1lGS3Zp?=
 =?utf-8?B?dU5LRlZyMVJWU2JqQ2EvZk1ERC96V0VNVjAyTHJKNERIOXowQzAzWmNMK0ZB?=
 =?utf-8?B?Y3NpWTM5cGErdXFOczdjWHYxeUlxQzk2c1dTR3FQSFVVT1ZaZDVDbzdDTFU0?=
 =?utf-8?B?SkNMeFp2YXZETzVNVm5DaU52aDg1YnJtWCtiQ3Rwa1dKOEU5QTZqbW92S3JB?=
 =?utf-8?B?ODJLLzFzbC8yUU8vcllCbnBWYnNGRXAyYk13bWcxZkI4R2hvcllZSnBJSGx1?=
 =?utf-8?B?NjE2SXBhbWRmK2hHb0NVR2hzUmdzaU1BaXFDa3ZIZW9xYWVaWEZlVGM0SFpG?=
 =?utf-8?B?M2gxSVVFMTczSzg2a05odE5zdyt1Z3VFUmxoYllZZytJQnRFSVV1amJ0Q3cz?=
 =?utf-8?B?QXU1aGVqaFhxclZHQ0hYMFJPdmcvWEZ4QTAwTjNVRDJuUE81VXNIOTlUbUU3?=
 =?utf-8?B?QzFhMkVNWllpTXA3THZzMU54eHpUa1VtNG01K21GQmF3T3VtZVpORm9lQUhF?=
 =?utf-8?B?VVJ5cWZUVmVEc3JBZjhaZWRyaG9XdmZNa2VsamlwWm9tOGRLbVlsLy9ERlZn?=
 =?utf-8?B?Tm1hYzRubzlPRXl1Z0NkaUMrWEQzVTdwMDAxSVFSVUJsMzZMZms2ekNlbEl1?=
 =?utf-8?B?dWdLL1pxWGM4Q3dvNjFwL3NyY21FM3oxUGpIRTk4QnVzcXRNU3k2RjJHYnNC?=
 =?utf-8?B?V2xBd2V6RnRPZDl2b2dyL0VuWFN3Mm5qY3hmUFM4NHNJVGgranI0NFBmQlR2?=
 =?utf-8?B?cC8rQ2xVUit0Y3FZK0RKSTlhbmM4UWt0d2M5cnZ1NXVBdncyeWpJOXRGQmVH?=
 =?utf-8?B?c29ZYXVFbnpMbHd2K2JwUi9ONFNDeENyN29sWHV4KzZQeGNGOU5rYnpNcVpm?=
 =?utf-8?B?MTFMTXMxS0VqZk5kKzVTWFVhZVlvNW9makVYdWd0L0Ura2U5Mkd3N3ppcUF6?=
 =?utf-8?B?VE9TTmdnYzI3RmhtQVVjQXlSWmRyWEZnU1dsWGp6YzdCY0U3WWVVN05jL0dM?=
 =?utf-8?B?RmNBZXlhcDRhdWNUVG1oTmVVbWJVTnBrMUhoemlaSzJ0WThMSFVpMmNCa2Vl?=
 =?utf-8?Q?IiFBRn4jetmXwzxIlUwMYu2aU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d09bb6a-b37f-4557-53b9-08db5a913acf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 06:53:21.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bftX48gEiNeFX88StE4VyUlR5wYAc2sFLq13scH130M55JS8qOOK6Vp6xEWncPC9Sm3S/8WvFUnKgwszkA65IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 03:36:53PM -0700, Nick Desaulniers wrote:
> On Thu, May 18, 2023 at 3:23 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/ndesaulniers-google-com/certs-buffer-stderr-from-openssl-unless-error/20230518-004753
> > base:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> > patch link:    https://lore.kernel.org/r/20230517-genkey-v1-1-b887424da4a8%40google.com
> > patch subject: [PATCH] certs: buffer stderr from openssl unless error
> > config: csky-randconfig-m041-20230517
> > compiler: csky-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> 
> ^ should encourage `mkdir ~/bin`; the debian docker container doesn't
> have `~/bin`.
> 
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/0e437a41fdb41c84834de6776bf38951b197792a
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review ndesaulniers-google-com/certs-buffer-stderr-from-openssl-unless-error/20230518-004753
> 
> ^ holy crap that takes forever. maybe recommend `b4 shazam <lore link>`?
> 
> >         git checkout 0e437a41fdb41c84834de6776bf38951b197792a
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
> 
> ^ should use `~/bin/make.cross` since `~/bin` may not exist in $PATH.
> 
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash
> 
> Hi Philip,
> I've run into some issues with make.cross when trying to install the
> csky toolchain. Maybe you can help?

Got it and sorry for late reply that i was in a few days sick leave. We will
go through all your comments and provide update in earliest time.

> 
> ```
> $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
> Compiler will be installed in /root/0day
> make: gcc: No such file or directory
> lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.1.0-nolibc/x86_64-gcc-12.1.0-nolibc_csky-linux.tar.xz
> /linux
> tar Jxf /root/0day/gcc-12.1.0-nolibc/x86_64-gcc-12.1.0-nolibc_csky-linux.tar.xz
> -C /root/0day
> Please update: libc6 or glibc
> ldd /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc
> /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc:
> /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found
> (required by /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc)
> /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc:
> /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found
> (required by /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc)
> setup_crosstool failed
> 
> $ ldd -v /lib/x86_64-linux-gnu/libc.so.6
> /lib64/ld-linux-x86-64.so.2 (0x00007f11f3478000)
> linux-vdso.so.1 (0x00007ffcf45b2000)
> 
> Version information:
> /lib/x86_64-linux-gnu/libc.so.6:
> ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
> ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
> 
> $ cat /etc/debian_version
> 11.6
> ```
> Perhaps I MUST update my debian container to 11.7?
> 
> Are the 0day toolchains not statically linked? Can they use the ones
> from kernel.org which are?
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305181712.xjvv1fbD-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    At main.c:152:
> >    - SSL error:FFFFFFFF80000002:system library::No such file or directory: ../crypto/bio/bss_file.c:67
> >    - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
> > >> extract-cert: certs/signing_key.pem: No such file or directory
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 
