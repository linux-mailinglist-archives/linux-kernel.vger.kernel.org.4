Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F6606ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUETN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJUETL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:19:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F71AF25;
        Thu, 20 Oct 2022 21:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666325950; x=1697861950;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eNwtbQuLfIMYQiXxscX8dcxOc97aoBsfAU7eUlAgdPE=;
  b=L2QVdFyd811jqO8SSVwzEf+Tz80bJUbu4sO2U4XXIilbKN3nIkXMUoea
   CaazYKrf+n1ctCImEi6dcaQn4FAedXLs+Gz0DcqhMEcGmh7wYnoDBru4T
   FZhdGmv5GuAYzKQPlDi13TSYwZqc6VOOIxb+F8iiE4RzkvE2lHvmn9/j2
   7NPcWEI5PAP1x8qHkeuQ0MPIEqUyRrj+YJW6VUeQXw0wFPHK52jNVrgZD
   eDPQSmorWCUuVeUIPm23CddJ0/jWMVKMUTnxUrNkoQtmymBUqVjf0TKaF
   BY3XPnCaKvqVRJTGN3uQ7EnBFxm6nTVctX93th6lBcyuGAuw3UYuAPEnl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333478586"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="333478586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 21:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="699104727"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="699104727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2022 21:19:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:19:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:19:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 21:19:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 21:19:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSftBNO0EyxLFjFyxXI7z01MgUF35/98c3Hl/Vh7kwQIuJ+EsOf7wU5gCM+367mr/N/od4UiGItzW37Qmn8l1k1TLXR2ta5Q0rjdJVZoz76tRs1NYsY/oFCV/nd2A6FxbsdHXDXeXTHCoX+PmCY3I5DgDpv6ntnRJ6JqNm4euN19sbvrafko+AW+Xfr5OZPTtQmD08tyJusjuo1No1dY4D4Qx7JuhWIJ7xs+EDcFsiywitOkL01k/nf6JXIp4AdSKooKx5LBUoUfYLQdhV/0DWXpXom9i63tIt7o8yHjMdrp8JOOr4TxAd3fn+c2oZ71Q3vz6hMZKGVldCA20f0gzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSCDyIMq2ttdRq7QDPBzdSAk9KzObJQdadSe3wFLuYA=;
 b=K4jZG8wQN+7bbhAT+tAVWx359UQpsoh72pa1UisTDojJwz2POuKV3bmGeC08t+6lh+BiOr8vwTHKXvA37dAnL+dIcWEQofWX2Bk9bbrxgicDFroHokpLxgVW+TKkWxbAUAE+ICQnKY8nobC2U1fzFHXKZEBtPHe0VC+3OzWZqvZz1fTwMzlvbfgbwI8QwBs8jAeWyw6RLQ2Q5iB7b/p62pkmRN5lM+XcqkhRSjpoEhqwIH8FY+bCGN937RerOmi1bMPtilNSjprqykJCP1NXDV+E08iFQzniHbjrafJumUmw98sEPLHzTqQpm2Ta3ICDODcX+YkTmDgm7x48qn2xaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5361.namprd11.prod.outlook.com (2603:10b6:610:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 04:19:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 04:19:02 +0000
Date:   Thu, 20 Oct 2022 21:18:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <bwidawsk@kernel.org>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y1Idsv0Nuu+V9aMj@iweiny-desk3>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
 <20221020223125.hyrfpt2noiicisxa@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221020223125.hyrfpt2noiicisxa@offworld>
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c241109-d543-4d87-d01c-08dab31b628d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bmv/UwkOEY/ioX37uah5dwP7Obhcj1QJ2RCUZuwBQNv6/EJ1VIRSi8UtGQ64bfHD8TH3EKXr3CTG9Ec2LMkbPGGX/uXybbW57wv1Ge7bkWFVvj8xhSesNSgyqcVzW1uokrJZwufnwZdKxgahYdFTM7ztIr30wwCiEQw3wiiZKBzARP4I2tPub2qyAqxckvv/2I+kD5047HzsCjZ7pHPy0q/Rq+QCRf2P633qtEEG0G2b3GDMcICcBa3vrHpCLbmj9ZxLpcsRAKqccw/uKaP8flr7mCYERyzNruDl8IQZiupaNi1RXXuoUhs0gtRf0v/kk9FtpAJ86+2ktwhUqEHK3nOX+zKvh2A5vYJhktA/bL2lKhFocgzf4DX+damozYhyfHb1beX1avVyMAzM1cL4PW85de7UxLLgLwvkSrF3F+oV5di45jzjuiHB2u0QgFAGqlE5n24wiu1DSSXHKtio2Ce7N3v2GbSNrsu+j9I3WOCRKYvjBqZ06btPsdQON2z+DTHMGvA3CQiwzTS/u4IaooyNDClKrTfn65F7MC8qmeGo88kktSNlEvbfXFbT3Uj02em1L64Uum7Q0mb3Q4Cz/tatsCMb4b7J2Jiuf+u2JzFKp6vnr51SDTgd12QCTTpOJ7fs29glD9F+4ERrmMR4WtvoulxrxEa4eWWxMJns+syvLShKsdCzONz7BlQdQerwzEArqMGqUJNOLkdb7XiUzV2FKZ4XUaJmvLpKzX+FwmlTYDYEaGWKcf7O9NWW32WXicZPc7SX6EiCHPGhEYmQbKiDf4xME52YYYn+cfrjGQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(366004)(39850400004)(136003)(376002)(451199015)(186003)(6512007)(9686003)(6666004)(26005)(6506007)(6916009)(5660300002)(44832011)(8936002)(4326008)(6486002)(33716001)(478600001)(316002)(66556008)(66476007)(8676002)(41300700001)(66946007)(2906002)(38100700002)(86362001)(82960400001)(41533002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjV0OqFTL2XW37YGWl1rtF13ZRM/V2BFY/n/AQBJB7acyJLZkR6SRi1f68s1?=
 =?us-ascii?Q?oR682xPLAS+Gw33NekJMO/KTOtHpoeb3fIN2T1wMUgdA4hb0khktbvJa0nVv?=
 =?us-ascii?Q?i+dsLRJ9SzPn9jFqAlLQIWfAm1rjXiRDP4SO5cK00wtAdKLdNySPdOSoYJDO?=
 =?us-ascii?Q?Xm+eVVZ4IbNXpECNMNFuvt6lndZ0FuCaOC4fHg3p831HWlCQeHrjO3LqooIe?=
 =?us-ascii?Q?1J9K7QELu4Z//j0Cdpnh8CMza3WxoOTcIodcawh1ZBswlCo9htDXxtog7i/F?=
 =?us-ascii?Q?9uRMZllxBgN6TBPNH9RAzCyzs9GErDbUnx9m4A7MphDP9hQz8ifyI1vufDBd?=
 =?us-ascii?Q?3ypvKKMX8GE5pb2juGlFa3hRdIayTPnKI2yux8Zaadf4p/Chh6mWPGvyez+a?=
 =?us-ascii?Q?NTzQvP9+OsvFKL0iOJ6OhddHQWgg9ZlN6kSg2DLZ/be6Azqfr/y7p6ZkK7nC?=
 =?us-ascii?Q?xtl12YyJ/+ZzfEnTAYXqtfmbRTXzi5bV7Brle0wG+l8OLmCK0YDGstGMHJEs?=
 =?us-ascii?Q?LKOZgV4ns88T5r5beUeSGCjn4H2gXg2WC00IZ9AZQFfxXs3BpdrvkBtXWpDt?=
 =?us-ascii?Q?WFv+Z/kGsKGll6YxpkZgy0lVaEAnV56kojiKJ/ke7qz8go5acDcuguCCF8UD?=
 =?us-ascii?Q?3271nRn96NBV634LUjdsbtS2jx3HQkz5CZw/MEfjF5qptZ2vqQkFHp/EcWBY?=
 =?us-ascii?Q?qSlI0IDoZrSvWv072Jd1LayHdct9iby9XsD5ugQ6CFCu+KvQiy+dLap7fuVr?=
 =?us-ascii?Q?4Bd9pQFMsjdKeRy3NzdMZW8QkBd6OikZp5EhgcXaYtVJEhBX5vUrXMyD7zoA?=
 =?us-ascii?Q?omY1H+fKFVCYWMSkYZoZ6qaoBHI/Y9TngW5vKIB6h+KA2NU7MQLLAA1Dv5yz?=
 =?us-ascii?Q?HvGWtoameWnn5Txqswv5dVWXkcO8exoOkCaiPw57CPGOUbCExSFz9Tjrf145?=
 =?us-ascii?Q?G64VaSi9Y7QP7oQVrYiGC2I2L8cZ41FwHK70j/1ZQ+sv9NLbpQ0SNdT6eSjg?=
 =?us-ascii?Q?2LO9pNdCdSaJFRIhITVo6rZRDjsOExcpk6oM002T8FVLvmcrYgP85G2lEpKm?=
 =?us-ascii?Q?j28gBrJ4baga0WxDb6ZjI3oRIJhj2q+7Zz6R7olKBB5Xot9JdeajP1nTxfdv?=
 =?us-ascii?Q?e99iFx8lKSEXG8UhGI/G/IMWMDNUe0CfzK2vwML1GuN2bFVamuxxgEV84Mo0?=
 =?us-ascii?Q?byK0eignTiQVpnJ7E/ihg0O/rzFkbKkBXsH3+e1kWZ4201ZYY6FcVcILlvUP?=
 =?us-ascii?Q?Hm8E1uI9G98pu1XG3zsGK5INkvKG0s41jSf3Uru92AEXScr75MxwVbqNrRm2?=
 =?us-ascii?Q?Q69Iif5l9jAuQ9oD6MPyOjb1jopRXDxVHHkbY9/dQlaZj0pRZHXcS24t4ZwN?=
 =?us-ascii?Q?6OEpmhrbaCdOjS9TdEF3sirtXCde+6U8QFc4uYP9pdwCnKj75vNaFzvvcby+?=
 =?us-ascii?Q?eHQvj3YDe/mBIO1nwMacqowKafZ21KgUwxOu8s5gUA/URVPKlg5qs130dnS8?=
 =?us-ascii?Q?tI6pRjEbcb7pXeiMQ08hEYof+B2q4LgAcqApDoveu8wpG3Hk5yqW5A+fokDV?=
 =?us-ascii?Q?peZiBcxk5RuU+GatvHkDSLoudw5ovXj1Uc3Y5eWe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c241109-d543-4d87-d01c-08dab31b628d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:19:02.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvD+fu1m8RL6Q38LN/yaCFR9XfoxyRsWbVqj4KWOfHNqqCgwKi5Rs4hxmwAf48vdGxtHsX1+FA5lSRgaP+Kiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:31:25PM -0700, Davidlohr Bueso wrote:
> On Tue, 18 Oct 2022, Jonathan Cameron wrote:
> 
> > Reality is that it is cleaner to more or less ignore the infrastructure
> > proposed in this patch.
> > 
> > 1. Query how many CPMU devices there are. Whilst there stash the maximim
> >   cpmu vector number in the cxlds.
> > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
> > 3. Carry on as before.
> > 
> > Thus destroying the point of this infrastructure for that usecase at least
> > and leaving an extra bit of state in the cxl_dev_state that is just
> > to squirt a value into the callback...
> 
> If it doesn't fit, then it doesn't fit.
> 
> However, while I was expecting pass one to be in the callback, I wasn't
> expecting that both pass 1 and 2 shared the cpmu_regs_array. If the array
> could be reconstructed during pass 2, then it would fit a bit better;
> albeit the extra allocation, cycles etc., but this is probing phase, so
> overhead isn't that important (and cpmu_count isn't big enough to matter).
> 
> But if we're going to go with a free-for-all approach, can we establish
> who goes for the initial pci_alloc_irq_vectors()? I think perhaps mbox
> since it's the most straightforward and with least requirements, I'm
> also unsure of the status yet to merge events and pmu, but regardless
> they are still larger patchsets. If folks agree I can send a new mbox-only
> patch.

I think there needs to be some mechanism for all of the sub-device-functions to
report their max required vectors.

I don't think that the mbox code is necessarily the code which should need to
know about all those other sub-device-thingys.  But it could certainly take
some 'max vectors' value that probe passed to it.

I'm still not sure how dropping this infrastructure makes Jonathan's code
cleaner.  I still think there will need to be 2 passes over the number of
CPMU's.

Ira

> 
> Thanks,
> Davidlohr
