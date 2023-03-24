Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5786C85AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXTPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCXTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:15:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B91BAFE;
        Fri, 24 Mar 2023 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679685332; x=1711221332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Piw8fUKIBl6wWWHDkEa4I66Nf4qC62l/9K5sK6gSsyo=;
  b=QZdQ48tnRlcvyD5ja/QXjaJC4ahW/TKeZE+SX0jG2/Um3s87HP8CpgQ6
   3SdhJe+i+eQdFhEtqkzWnV039AmEf57MdMiPcuJvwjM6ZxuEnj1GKPuCB
   5yV90vcvZFZF36tm7moNolImw7TNsFaYAZ2NFgtFKaaFtHTZgLxmS31B3
   G+goSBf6S7JEtSPmaqV5u+AjgtYHALk5AGti+VyzzA/HK1eXWEERflhCe
   zSTgmJL/9GsyOZDGvvYV/UO6aNYHnQ+9aHH/Hfg95wJOHRrD1MV1UIu4n
   UD0u0VBcy0dW4JdTRkFhs3q/9aGa8o06U7sY1GwKcqsRddEpls8r1xNZ/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339889059"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="339889059"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 12:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="715350264"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="715350264"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 12:10:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 12:10:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 12:10:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 12:10:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 12:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb0F5wLLYvXWjH16UQyPnqglo60HUNHg9VCTfOFj40YAeN3on8Jo+djwq/5VYRjqBDEWNpThsSJly0jILPk2FZpAyIZn3woQgOIBKUSg6Tkii0lPzWGE+S67ErfxRzgu7FODWchxsr+stxUb5VrXTx1nS1INShXb5dH8tH1IhTwsuKkl4VAiGjX1yGY9qVY1/V5Kpd0vNCnr1UXBH1DlCz0rsVi50kNGNSoECDdJ0LqwPZb2cxhyMPVCe+IWqcJ5xyBEa84vZ1Jb+uEiTULu6l+PtU062Se9WHQCWBcwnHiMjJXwyBsYiEWuQyRkLAhuHY/Sjj0FFXy2YZY8P8Zw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Eb7skCqVS6h2nz/C4ImwsyzWOK7VzpKIIMB5LeTZb0=;
 b=YsHzkDLO37QemM7Ej4S8K/fhU1z5rJo4e30V9j5hznN75AregzXxyn+lWBtJk+U1TcK4iF6xHcEfkk3BCASfTh47W3N0J7zY65KhxF11lwwwEeHK78DNbXWMDVchJL+I6H5A+2t65QZ4lOULsQZ16HL7not/I+8y6VdOWrT9ufExsunTfPrFxe52vJkvr3wuI4RQiVylq5NspseF18FdR3yRPj7mU8jG393DLuXKB0g80b37MSkkOUSk5ZolvQjp4HIQSwX450tPiAgw1T+4GHSa2bFiHF7Ml2r9loOopJhIUyZdbaaocsgFVQtMRVJqqMZwn32i6Z1RJyVzh39k2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40; Fri, 24 Mar
 2023 19:10:39 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 19:10:39 +0000
Message-ID: <80166ee7-4ee3-bb2d-c715-a8180dddee31@intel.com>
Date:   Fri, 24 Mar 2023 20:10:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC rcu 03/19] srcu: Begin offloading srcu_struct fields
 to srcu_update
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
        <rostedt@goodmis.org>, <hch@lst.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-3-paulmck@kernel.org>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230324001938.3443499-3-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|CH3PR11MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: a15325a6-fdb1-4a1c-ff9d-08db2c9b74ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4jb5vIxJI8Q4u4LIReKXh4/zPpfPcWF+tNVYSlWu9v3dbl16mKz49FcFpBxRmiWwusvrHEHAFWUBFXWbTxbkbpZ2tFCA19KH5CT4L3qaYKZdisIoHDx2YR7TWN5WKU88lSMmrLS0K6u39FSuHDkGVAZINwBW2FBN1T0LcCrIYFjpE4XG1LclB5YDwUse5R36Bjzi7p2oqH948FjjCDpJmKPuIeGcHIScaAizzmJT3UO+grort7LZMuDf2UD/4FaPyXdapbZGqPgGuZ7u8eUNpT3n4V4ulXw/2QuDawaF6xxKXo9VJp+eVj9BCzHjv3jFdar6tMOnH1yHJvVSbU6JGcCy6fOB+ga0jHhOcJEfMa3y5MdOiU5gMD+XgPqOgVpvruYIV9HjoXIF/gvkThuSmdBgHKYqWMxL0lxVPuc2noVdOZ+ODEHpQGeIjHGfvV20F/QDRBV6ovwmW/SqFjgJcDBta+k519ktzoLZGT6XESoOFHHCRfPdwTDeJkbLLaxroR/mvtEbB3978Cx5WM6oij5bIUXm9W9V748NABrwbuo4TIcFdYmmgkl8cVkag/REPX0BvduWTLHYSHG3IXe+0mQ/Uzw9SRz/KLjBWzwIq2c7CVb87zB9KIHzibxqUCOdn+o2n5SoYGzGXFCV2lsa9ScQmp7cvmYQl+J+FzGocjFjbvhrIBVjZBh1KTimxZI9V6Sukj+C/BchtN5ElI9H/uu+IAoFr8mB2sT4eUPnKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(53546011)(5660300002)(31686004)(478600001)(8936002)(66946007)(2906002)(54906003)(2616005)(66574015)(316002)(6486002)(966005)(8676002)(6666004)(36756003)(66556008)(66476007)(4326008)(30864003)(6512007)(82960400001)(86362001)(38100700002)(6506007)(83380400001)(31696002)(26005)(41300700001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRDV01QNjIzRHBya00yYnVZMkF4ejBqOGRyZVRLaHFKakpEU1lOUGVDcHNq?=
 =?utf-8?B?UTJhTHNEeTlGTGZ0My9TRWZaWW9ldlpWUmhVNUdKb2NVSk1pVnRrMiszZFQ5?=
 =?utf-8?B?T3FsL09RcnJnWndFQmlwVTUyMGFpcitUbVg1SW9SNzBqcnVOWGtQVVZXR3kz?=
 =?utf-8?B?S2VFWEJEWmV5WlM1NjVNbFltcUdqUGhIWWFRczJIaWt5S050V2owNDA2ZXY5?=
 =?utf-8?B?SE92OHdua3VmblJwWGVQV2NxbjlZMWtnUzVtc2Z0cmlqRHdLSXFLWks5cUhV?=
 =?utf-8?B?VmI1Sy80Wk5RSVVjaEtnZm1JTWQ2b3JORGMrQlYzdERoRFlqUHd0Z0EzZklt?=
 =?utf-8?B?L1RSaHhBY28wSlNaYXd2T2Z2bkhNS2dYeGVUN2t5Y3d2VXhpRnhtZGFJNXJp?=
 =?utf-8?B?MEs4Qk1JNlI0UEUxb0F0YzhRelhxcjJNbFdId0txR0pVWEZKWGpjK3F5cTBu?=
 =?utf-8?B?WSsyZ1R4bktYWFYwSVNaR0N2SFFYNVFXbmJtRGJyUnBQZ0hNaXE3MWpvT3FJ?=
 =?utf-8?B?VTFyajRQajBPV0VxK0xGdEgyNGVIMSsySVZzbFFudGdTcXVwZnZjeWFIaTN0?=
 =?utf-8?B?OFZWNU5pN1R6Yi9IWTlxZWF1dkNJMHZ0R0FOdVFrL3c5Q2VlaVJQVmFZeTlt?=
 =?utf-8?B?S2lEaVJVUSs0QXJhbGxGdmVsQWFFMDNBTlAyZVpHVXBjT3FNOElXVjNUWjlx?=
 =?utf-8?B?VytraDFmR3hhRVc3RWpWSjdZbUNvRW1sMXdPSzdocEk3aU1xTy93SzBmZU43?=
 =?utf-8?B?Qk9DNFVteGdmK01Ia0FrbG10eXI1MmJNbG9LRlJ0WlM5cSs5aXVGU0pVeVR5?=
 =?utf-8?B?TDZMZkIzSElXQ0Y5TGNzNENpWUJ3SnJNNTVPc3hjZGtlMU4ya05GU0V5UkJ4?=
 =?utf-8?B?bGdNR2RTb1pHSlluV2xOSGJ4Z2IwQ3lzQk9ORHk3aVBIdEpNWUNoNFRaY0tT?=
 =?utf-8?B?RjlibHo4dEJwSjBBZkVlU05CNXowaTRqQk9hZUF0SEkrRXMxaVJpYlZVOEFm?=
 =?utf-8?B?RWdnWW1ZdWRsMGE4aVRuQWZtY0g4T1JnMHVHUjZZMmhaU1VJT1Q3cnkwSzBw?=
 =?utf-8?B?MnI4eXcyVnY4NEN5cUtNZEtCdDRYMC83M0dFenZuSDlnbjVpcTlVeHI3L1p5?=
 =?utf-8?B?emNURE5VcHVGUXRWWmIyNWYyNmtvSThxL1hLT2M4KzQ2blJ1a3VwZDdrYk1q?=
 =?utf-8?B?bkhrd0Z2c3hYK3JtemlCK0thTUtRb0VWRkJiQkh6SWw0dmhFN3psRCt6dlJY?=
 =?utf-8?B?b2x0TUkrMUhsaEQ3aXlvT1cyYUpha0xaWXJJYmhkOU1MQzJCSEd6cnN3eHds?=
 =?utf-8?B?Yit3V0xXbmRqaUV0TXp1bGF4UVVLd2xhaWZRTGxVUGNzSW5ScHFkNUV6eTVO?=
 =?utf-8?B?anE4anA1UjR6NEQxRlVOcGZCbzFDbHBmc2loY2M2VzFZNFNDN3lhTXJLYmt6?=
 =?utf-8?B?MUZhM0tzS2x0ZlN0S3hpMHVrZWFKMWxNbmUrbWZGRjkxMC96cm5QRFM2d3JR?=
 =?utf-8?B?OE92WUxITC82eHBxS1ZMWlBkcEtyZXNtOE83WmprWGl0MXhjODB6OGVPZWhp?=
 =?utf-8?B?L2hZNWVxUnBXWEdJb0pQY1JMbDcyTUpvZWJpSklKNHFPbFY0ZEtIdy9iMWhU?=
 =?utf-8?B?TUJjY21MYmZxWWphL3BCQjg4d01VQjhOa3ljUEhSYXR4cmpKQy9wM2dNcEo4?=
 =?utf-8?B?M1d0bzFLdFJWT2I5VUozOFdrVTZRYjhHY05JUjdFUEd0cktpY3dlcWxvWFRB?=
 =?utf-8?B?RnUwczBWczBzZHdHSURpU2hYSGgvWEozcm9lb1FQZk9INmpra0ExM2tMcTBm?=
 =?utf-8?B?YlI4eWRMeHBrQkhsUnRWZlFid0pPTk9GYm1xZFl6WitBdm1QczJYa1BQbnNW?=
 =?utf-8?B?OURLZWpTN1lzbXRNNHd3cCs5ZEUzOWNUK3lmT3dTTTlwbXFvalVKL0NUOURy?=
 =?utf-8?B?OVVjaDJHL3dJTERzRE9iYkdBQ0VESjB1NHl3WGdneGF2Y1VSQlZTYzA1eVEx?=
 =?utf-8?B?NXI0ZUNVSlpFWFR2dTQ3N0ZrYTBCaUNvbXdjN3ROdkRNejNuYUhBUzZUTVZN?=
 =?utf-8?B?T0xENnlSLzE0SGJrVVJUQUtoTWhFVzBYeGc2Y25TdmgySmpUKzdMWktiUWFk?=
 =?utf-8?B?VzMwS2NaekV6aDVsWmtmZ0pPWHI5L1NpdUk2MUxGaFMzckZzN3NhUWN4amZh?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a15325a6-fdb1-4a1c-ff9d-08db2c9b74ac
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 19:10:39.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScHSoJKbqayzGlx/ff49P2jOB1z0ypQZ06bzKh47lmb6Ud67F2xCqgW6WifO/0AjKcrOH96O5Hlbg74zI/HB6bQkI5+7+INjnrWZ7QO8Bqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/2023 1:19 AM, Paul E. McKenney wrote:
> The current srcu_struct structure is on the order of 200 bytes in size
> (depending on architecture and .config), which is much better than the
> old-style 26K bytes, but still all too inconvenient when one is trying
> to achieve good cache locality on a fastpath involving SRCU readers.
>
> However, only a few fields in srcu_struct are used by SRCU readers.
> The remaining fields could be offloaded to a new srcu_update
> structure, thus shrinking the srcu_struct structure down to a few
> tens of bytes.  This commit begins this noble quest, a quest that is
> complicated by open-coded initialization of the srcu_struct within the
> srcu_notifier_head structure.  This complication is addressed by updating
> the srcu_notifier_head structure's open coding, given that there does
> not appear to be a straightforward way of abstracting that initialization.
>
> This commit moves only the ->node pointer to srcu_update.  Later commits
> will move additional fields.
>
> [ paulmck: Fold in qiang1.zhang@intel.com's memory-leak fix. ]
>
> Link: https://lore.kernel.org/all/20230320055751.4120251-1-qiang1.zhang@intel.com/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Fine with me.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   include/linux/notifier.h |  5 ++++-
>   include/linux/srcutiny.h |  6 +++---
>   include/linux/srcutree.h | 27 ++++++++++++++++++---------
>   kernel/rcu/rcu.h         |  6 ++++--
>   kernel/rcu/srcutree.c    | 28 +++++++++++++++++++---------
>   5 files changed, 48 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index aef88c2d1173..2aba75145144 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -73,6 +73,9 @@ struct raw_notifier_head {
>   
>   struct srcu_notifier_head {
>   	struct mutex mutex;
> +#ifdef CONFIG_TREE_SRCU
> +	struct srcu_usage srcuu;
> +#endif
>   	struct srcu_struct srcu;
>   	struct notifier_block __rcu *head;
>   };
> @@ -107,7 +110,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>   	{							\
>   		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
>   		.head = NULL,					\
> -		.srcu = __SRCU_STRUCT_INIT(name.srcu, pcpu),	\
> +		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
>   	}
>   
>   #define ATOMIC_NOTIFIER_HEAD(name)				\
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 5aa5e0faf6a1..ebd72491af99 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -31,7 +31,7 @@ struct srcu_struct {
>   
>   void srcu_drive_gp(struct work_struct *wp);
>   
> -#define __SRCU_STRUCT_INIT(name, __ignored)				\
> +#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored)			\
>   {									\
>   	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
>   	.srcu_cb_tail = &name.srcu_cb_head,				\
> @@ -44,9 +44,9 @@ void srcu_drive_gp(struct work_struct *wp);
>    * Tree SRCU, which needs some per-CPU data.
>    */
>   #define DEFINE_SRCU(name) \
> -	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
> +	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
>   #define DEFINE_STATIC_SRCU(name) \
> -	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
> +	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
>   
>   void synchronize_srcu(struct srcu_struct *ssp);
>   
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 428480152375..2689e64024bb 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -57,11 +57,17 @@ struct srcu_node {
>   	int grphi;				/* Biggest CPU for node. */
>   };
>   
> +/*
> + * Per-SRCU-domain structure, update-side data linked from srcu_struct.
> + */
> +struct srcu_usage {
> +	struct srcu_node *node;			/* Combining tree. */
> +};
> +
>   /*
>    * Per-SRCU-domain structure, similar in function to rcu_state.
>    */
>   struct srcu_struct {
> -	struct srcu_node *node;			/* Combining tree. */
>   	struct srcu_node *level[RCU_NUM_LVLS + 1];
>   						/* First node at each level. */
>   	int srcu_size_state;			/* Small-to-big transition state. */
> @@ -90,6 +96,7 @@ struct srcu_struct {
>   	unsigned long reschedule_count;
>   	struct delayed_work work;
>   	struct lockdep_map dep_map;
> +	struct srcu_usage *srcu_sup;		/* Update-side data. */
>   };
>   
>   // Values for size state variable (->srcu_size_state).  Once the state
> @@ -121,24 +128,24 @@ struct srcu_struct {
>   #define SRCU_STATE_SCAN1	1
>   #define SRCU_STATE_SCAN2	2
>   
> -#define __SRCU_STRUCT_INIT_COMMON(name)								\
> +#define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
>   	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
>   	.srcu_gp_seq_needed = -1UL,								\
>   	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
> +	.srcu_sup = &usage_name,								\
>   	__SRCU_DEP_MAP_INIT(name)
>   
> -#define __SRCU_STRUCT_INIT_MODULE(name)								\
> +#define __SRCU_STRUCT_INIT_MODULE(name, usage_name)						\
>   {												\
> -	__SRCU_STRUCT_INIT_COMMON(name)								\
> +	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
>   }
>   
> -#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
> +#define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)						\
>   {												\
>   	.sda = &pcpu_name,									\
> -	__SRCU_STRUCT_INIT_COMMON(name)								\
> +	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
>   }
>   
> -
>   /*
>    * Define and initialize a srcu struct at build time.
>    * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
> @@ -160,15 +167,17 @@ struct srcu_struct {
>    */
>   #ifdef MODULE
>   # define __DEFINE_SRCU(name, is_static)								\
> -	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name);			\
> +	static struct srcu_usage name##_srcu_usage;						\
> +	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
>   	extern struct srcu_struct * const __srcu_struct_##name;					\
>   	struct srcu_struct * const __srcu_struct_##name						\
>   		__section("___srcu_struct_ptrs") = &name
>   #else
>   # define __DEFINE_SRCU(name, is_static)								\
>   	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
> +	static struct srcu_usage name##_srcu_usage;						\
>   	is_static struct srcu_struct name =							\
> -		__SRCU_STRUCT_INIT(name, name##_srcu_data)
> +		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
>   #endif
>   #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
>   #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index a3adcf9a9919..4a1b9622598b 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -378,11 +378,13 @@ extern void rcu_init_geometry(void);
>    * specified state structure (for SRCU) or the only rcu_state structure
>    * (for RCU).
>    */
> -#define srcu_for_each_node_breadth_first(sp, rnp) \
> +#define _rcu_for_each_node_breadth_first(sp, rnp) \
>   	for ((rnp) = &(sp)->node[0]; \
>   	     (rnp) < &(sp)->node[rcu_num_nodes]; (rnp)++)
>   #define rcu_for_each_node_breadth_first(rnp) \
> -	srcu_for_each_node_breadth_first(&rcu_state, rnp)
> +	_rcu_for_each_node_breadth_first(&rcu_state, rnp)
> +#define srcu_for_each_node_breadth_first(ssp, rnp) \
> +	_rcu_for_each_node_breadth_first(ssp->srcu_sup, rnp)
>   
>   /*
>    * Scan the leaves of the rcu_node hierarchy for the rcu_state structure.
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7a6d9452a5d0..ad1d5ca42a99 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -173,12 +173,12 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>   
>   	/* Initialize geometry if it has not already been initialized. */
>   	rcu_init_geometry();
> -	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), gfp_flags);
> -	if (!ssp->node)
> +	ssp->srcu_sup->node = kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->node), gfp_flags);
> +	if (!ssp->srcu_sup->node)
>   		return false;
>   
>   	/* Work out the overall tree geometry. */
> -	ssp->level[0] = &ssp->node[0];
> +	ssp->level[0] = &ssp->srcu_sup->node[0];
>   	for (i = 1; i < rcu_num_lvls; i++)
>   		ssp->level[i] = ssp->level[i - 1] + num_rcu_lvl[i - 1];
>   	rcu_init_levelspread(levelspread, num_rcu_lvl);
> @@ -195,7 +195,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>   		snp->srcu_gp_seq_needed_exp = SRCU_SNP_INIT_SEQ;
>   		snp->grplo = -1;
>   		snp->grphi = -1;
> -		if (snp == &ssp->node[0]) {
> +		if (snp == &ssp->srcu_sup->node[0]) {
>   			/* Root node, special case. */
>   			snp->srcu_parent = NULL;
>   			continue;
> @@ -236,8 +236,12 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>    */
>   static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>   {
> +	if (!is_static)
> +		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
> +	if (!ssp->srcu_sup)
> +		return -ENOMEM;
>   	ssp->srcu_size_state = SRCU_SIZE_SMALL;
> -	ssp->node = NULL;
> +	ssp->srcu_sup->node = NULL;
>   	mutex_init(&ssp->srcu_cb_mutex);
>   	mutex_init(&ssp->srcu_gp_mutex);
>   	ssp->srcu_idx = 0;
> @@ -249,8 +253,11 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>   	ssp->sda_is_static = is_static;
>   	if (!is_static)
>   		ssp->sda = alloc_percpu(struct srcu_data);
> -	if (!ssp->sda)
> +	if (!ssp->sda) {
> +		if (!is_static)
> +			kfree(ssp->srcu_sup);
>   		return -ENOMEM;
> +	}
>   	init_srcu_struct_data(ssp);
>   	ssp->srcu_gp_seq_needed_exp = 0;
>   	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
> @@ -259,6 +266,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>   			if (!ssp->sda_is_static) {
>   				free_percpu(ssp->sda);
>   				ssp->sda = NULL;
> +				kfree(ssp->srcu_sup);
>   				return -ENOMEM;
>   			}
>   		} else {
> @@ -656,13 +664,15 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>   			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
>   		return; /* Caller forgot to stop doing call_srcu()? */
>   	}
> +	kfree(ssp->srcu_sup->node);
> +	ssp->srcu_sup->node = NULL;
> +	ssp->srcu_size_state = SRCU_SIZE_SMALL;
>   	if (!ssp->sda_is_static) {
>   		free_percpu(ssp->sda);
>   		ssp->sda = NULL;
> +		kfree(ssp->srcu_sup);
> +		ssp->srcu_sup = NULL;
>   	}
> -	kfree(ssp->node);
> -	ssp->node = NULL;
> -	ssp->srcu_size_state = SRCU_SIZE_SMALL;
>   }
>   EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>   
