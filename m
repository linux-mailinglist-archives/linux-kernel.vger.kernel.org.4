Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695E66C7CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCXKdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:33:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F8D421F;
        Fri, 24 Mar 2023 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679654016; x=1711190016;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O3rANOWX/Zr+HAeNL7MEo6+uxI43NXqOn6POCCIleow=;
  b=GlUr4UB2bo+MRQcD8/hPUDqryHOQnmdPWLOF5iQgcizGVA3BJLLaxV0z
   U8/uvalN8yllYEHoMl1WfwdPfObQ7XoXzdYDrwo7dJhrttLFpoYX+W7tx
   FmR5+N4wXD7DRbFdEdiXeGLsUNDEl7VVCA6QeC501UGKOpLs2mF6K3LCK
   oM5e9GEfr4YB8PWl93S6CVpXPMqjAq+g8lMzPfqhkJPlKITTI9OLFoOWQ
   BYZo4I3cdPRfmKlOScRbc/kngIlBJ6Ri+HBNmQcqk67CYF1TVorAw68mR
   eGErdptIoNwrFGOeu7KMw56R+KlPyNWrANq7+3CdVh9npTIGVxFMWc+JU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="320140773"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="320140773"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 03:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="826220615"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="826220615"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 03:33:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 03:33:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 03:33:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 03:33:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 03:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1YYE4SCTu8QAMV+KlZfgoMSpXBaF76tB/8ZcurLK0tLqWZnk96foycxyoBr3JiZAu0Tx1SEE/xGzovuiqIjlUyD5VQJxwQ0jsMbEWN3I2gV3lzVfG4+Toj3j3SRodhPu+x0wKRg8Fc6IpoPETv+GOfKYcvQ1EgyRA0WBeW5A8QaEfcKfOV9SB6kO8g396ZPGk0KANZGDq3TSrTB3tliJ7WyNlU/PSnXNIfTeAvAZp4MA/+jHVv12d9EXk2h4v0aYinxkMnsPtJqeCDNo8EzSYGBqqdk3mDARv6SYQ/CUN8RZk0jNO2Sdtsc4cPgHqpBA2eEjQkd7olgBf0HKWmoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybga5h1e8fwANnXUINjiz7owHt3Sw/PTG6AvF27IPg8=;
 b=lHuUkQITvnGKkfryy1lctowHCRNWTfxtEGafdETwRIENBs/x/wzHlLkkBmhOIax2FHsxlIBrtmJ3B1YIBZqOXdxocWIb0zdFwagEPVlozzL2KH7I0HB4m6vk3GFnN9r418CWshcAM6xxJdqlEcXaM/5Cld6e0IGbdQhw2Mp4cwVLCo5ELCZIU+guwKiMEqzvJnmg1oFESPx59uqimOB6jQBAhrs7dWNsYD2EK/ppDPi0nRCopBZCx4pS0HdWW/MsTPRufjINY0ef6ibu+pk6pWYvnVVm870YQt6JwyIbM/SczCjMv7dy8mLzhTK9qnVxkkM7UbydTNJI18NMpJ7gJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 10:33:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 10:33:16 +0000
Message-ID: <245468bb-32fd-c123-1252-8e87cf6df8f9@intel.com>
Date:   Fri, 24 Mar 2023 18:32:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>
CC:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        <linux-kernel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <regressions@lists.linux.dev>
References: <20220826022031.GA76590@inn2.lkp.intel.com>
 <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
 <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
 <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
 <997614df-10d4-af53-9571-edec36b0e2f3@intel.com>
 <CAH2r5mu5zDysHUPgeSK9aEL=cByz9_9vBTxKvkqZ5xOObTXAWA@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAH2r5mu5zDysHUPgeSK9aEL=cByz9_9vBTxKvkqZ5xOObTXAWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0123.apcprd03.prod.outlook.com
 (2603:1096:4:91::27) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac3db82-3cbd-4e4f-625e-08db2c532572
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOEwzWXh0ocOzxW0RQxybQi4Tb1PcezIqqAuP7Mx9x94PsQMONbgtXcESFMIzUQvyb5jCKi4aIqcBarb96RaMuEzkualKsDOqKr7Hn1ygEOR0K0mRCvG/5uKnnkWuypVL8adTClzMc/k93M2JC6Q4FtIpE/pNHzHDgma8FIwozM13nTcli2t3I1Li2iuKIKqZt5y44eJi0ILJrfD02S1t2vbV6PnEvdBH/sHxIoYzWm15xX79jjTpHyAC+I0V5oQj0Dy4Br1QDyzzZw8rpAXVpXmEPgLd5PMvGWTRc1mQ1bksVw98dMXecuYJJ80VZVemFLmewDQP4TUnGw42ZvIJ1heaWqmHuBQV/IB7dGOir/mryC23m9gqkkCyZnN9pXCvhf5NPvLNR77SRRE4D+tV1rnG/YrmHDpZtDNYs5cn0TjiquwWBnG5us7JHy5+407PWVM9wZDo8+tEMd9WLw9IgM+99FjP6gBw5PzP0UA6C5lnecaQpNg0TLBGcCrXrC/4IWEuBPYudWBmyOae2eCAgmF4rTMR9viBd7yzZOjN/ooibxwaHLNGz9NmqN1RCKlUbV05lg8rfNWK/oweXzN9zjOjSS+oAgLrYLwDngqyEC6Ib8dk5u+EbgtGgt3enAG8vh06u/igjuB1Nd09KP1Sgd9MaiiTifegZ6TDYXYiZY5CFufueoSPhUO7jfl3QRb51aHhMFWzow7iGWnBy7h4tLYA7ZC1UpdNS4V7ANm8ti+hPQNVwD08zMuiubD9dRZruYB4PnxwVbyRzlFJjrUdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199018)(316002)(6512007)(83380400001)(186003)(53546011)(2616005)(6506007)(82960400001)(31696002)(38100700002)(86362001)(26005)(478600001)(54906003)(36756003)(6486002)(6666004)(966005)(5660300002)(2906002)(31686004)(41300700001)(8936002)(7416002)(30864003)(6916009)(4326008)(66476007)(66556008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVwdC9hcmxRUXFlVjU0OS94bmhjYUFTRzZEQXJsMCt6VW9LVFdXeVlSSUIx?=
 =?utf-8?B?NEZFZTZjajdQTG5WVDUvMWNpRFBBYTVTS2VYYmluTG50NVErRTBXalpzL2pD?=
 =?utf-8?B?Sm01ZFl2UUxoekxxYVVrMzJSb2x5MlZWZXo4elYwTTB0eTBOSDhWK0pWNjZs?=
 =?utf-8?B?dVY1SUI0MXVkbzd2am1zT1RqZkJkN3ZNd1Y4Wk94enM5cStPUXNyTWRKUlla?=
 =?utf-8?B?eWRFcGRlY1ZRemZSdmIxWmQ5MzRJaHlPbjJ2Wk5SQmxpU0xVWmxnSWVBTW95?=
 =?utf-8?B?aTVRRERnbW55eUZ5MmFUdWM0a0YyYzc0bmUySE5mY01vaTdObVZlNmRrdE9u?=
 =?utf-8?B?dm5TbTNxdkxpWnRhbEhNcmhwSW9ZVCtCa0d1MzJINEZLMjVyc09zSzlsN1l1?=
 =?utf-8?B?MUhNWWRhV2R4aHNYVUNqTytTc2dUNTZuRVBCZUZKYkJDazZvMnpyZjBxS0ti?=
 =?utf-8?B?cjFzVE1aYnNmZmlPdTNWLzlDVkZsSzNYSTBGZk9qZ3lZY04xMHY0Zm1XaERS?=
 =?utf-8?B?K3JYaVJjcTVtZkNQQWQwTXdOZ0dNMkkrVW9OWC9PdEpvWkF6TS9MMkR6V1lj?=
 =?utf-8?B?QVRsNEpPY3YrSnUvVU5EZ2xLUXRYVU5BMFhzNGdFNEpnS1BwelVta2dEVGJw?=
 =?utf-8?B?cDB3UjdtUzVyVWpQeEx0TEFCbVNhSUhETjE4QXlqUUhsbGdUMFg5dThxMTVT?=
 =?utf-8?B?WHRFY05qSjUyNGx2Q3FjN3ZiTW1RdG1ZbmhqNTJnNDhXbFRCMGVYNEh2Mnhp?=
 =?utf-8?B?eHFqRmMrMTM2UVd1RXVkYmFOMWxCcWYyUGJxdzQ0Vk5HeHJuQWIvYlptRGM0?=
 =?utf-8?B?dUc1dVNDcy9aWlh0cDJPbW5VckZ1aFltcy82UDQ4RG56aXJwcjVEOVJvL21Z?=
 =?utf-8?B?NU1wVlJETVJWUHFIZ1dGWndML2ozUkFaUGlVYVBTR3lYdW9xMTZiWWtFb3ls?=
 =?utf-8?B?Q1JxY1VoenNyNjdyTkE2MnFuWDJGTk1Zc010R0VScTNuUVRkUUlObDFlUmR4?=
 =?utf-8?B?aDFkTm8yQWxmb3FsRmhINzNpRXBJSmYxS3o0dFgweTV6YVBsR1AzVjh1Ulhu?=
 =?utf-8?B?c1BKTDNNdi84OFo4NUQzRWdCZ3BLZUw2YThsbERwekpCYjFNYVg2TDYvZXBy?=
 =?utf-8?B?aEVwY2o3ZU1OYlFhL1FINW5nVHhvcGkrUVJKaHBtajBtNVdCdkRhc242NXFj?=
 =?utf-8?B?U1k5aXA5aHlCOWZqamc0TFJ0cmF2cE1JdmQ5Y1hXcC9IUXBVa1ptMEhIYWpl?=
 =?utf-8?B?MVZCWE9MUEFwRTkwSnhyTmtXRytYeG1wTGFtNFdOMUh0T0JUT21Dd2FVNktL?=
 =?utf-8?B?ZzBBa2NXZ3U2Y21kbUV6WmR5ZjQ3dGZ4MmdVZXFtSWsxejE0YUY5eGo4VVJl?=
 =?utf-8?B?bE1SWTdyYXdMdkp2WWdmU3BvRElTUjEwNk0ralYyVUd0ckJPMVp0WXVBYlky?=
 =?utf-8?B?Q1d2VUkrNkY0ek5Ca2w4VHVYTU82c2Nudk1xRkd3OTE4ZFY4VFd2TjNIYklB?=
 =?utf-8?B?TzQweVJ3K1YrRUl6WmxxNW9hd0pjUTdwazd3OFZIMkQ5eFQzNGdpVGlkWmJn?=
 =?utf-8?B?R1FkOTRFUEovOGtNS1ZRNlhQL2pBaVF1djNvWVNSRi9aTE56WFExM0lBVVFC?=
 =?utf-8?B?Z2NsNUlDTjhiemZra05oc0w2cExKVEl5YTBacGZLVGRiZFh6cjFCeGFmZjJX?=
 =?utf-8?B?VVJnV3JZMEZhd1FVQkR3U05TNlNJSjR0NDhSMHpHeFJQU3E5TEZZNEJWdmFs?=
 =?utf-8?B?L2NVKzlhRlZNTjlleG5XQzRuVE8vUEduU3B3bTJCcUtmeDFEOVRxZEptZXVJ?=
 =?utf-8?B?ZU01cTJvWmRFWkVSa2pjVFV2dDZRc1p4SGEvQzl5U0NXcUpGaVJlejlWU0pQ?=
 =?utf-8?B?bUhGWk5vWDN0ODZWUE1UTWR3aG54SWV5YlByUjJYOXljd2xNcVJOTms5Um4z?=
 =?utf-8?B?T2dhMURyVzdqZzRYQ2NSczdtQk1RODdsM2UwcmcxRkc1Wm1XK2dNNFp5NHk2?=
 =?utf-8?B?bTJNaFBka01KRGVISXh1RUFHVmFuUzFVWS9VaXdna0dYS0tsaWlMZEQxTng0?=
 =?utf-8?B?ZGlJTGdsUlJDejlqRitZaVhGVVFxNzY0Y2ZKK2RGQUYzSnBzYUx6aUsySWFy?=
 =?utf-8?B?VHJJOXY4WkIwZHF6eU5yMVdLWXQvNUFhYXNNQjg0K3paY3cvWUJYSkEvVXVh?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac3db82-3cbd-4e4f-625e-08db2c532572
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 10:33:14.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIKawXTY0/bs8hdyQtuBGi6ZB+/IjfAvsDiT1S26cNA/ECyavg2wyToBCOxC4axRfD+acXdt0bGDcuMgQ0SFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2023 4:36 AM, Steve French wrote:
> Patch attached to return default back to 1 second from 5 seconds
> (Bharath's recent closetimeo on lease break patch may also help)
> 
> Let me know if you see any problems with it
With this patch, the regression is gone.

Regards
Yin, Fengwei

> 
> On Thu, Mar 23, 2023 at 2:48 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> On 3/15/23 22:26, Steve French wrote:
>>> Can you verify what this perf looks like with "closetime=0" and "closetime=1"
>>>
>>> Are there differences in /proc/fs/cifs/Stats when you run the same
>>> steps with "closetimeo=1" vs. the more recent default (5 seconds)?
>> The dump of /proc/fs/cifs/Stats are attached. You can tell which
>> closetimeo is used from the file name. Thanks.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> On Wed, Mar 15, 2023 at 2:46 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/26/2022 10:41 AM, kernel test robot wrote:
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due to commit:
>>>>>
>>>>>
>>>>> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred close timeout to be configurable")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>
>>>>> in testcase: filebench
>>>>> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
>>>>> with following parameters:
>>>>>
>>>>>      disk: 1HDD
>>>>>      fs: ext4
>>>>>      fs2: cifs
>>>>>      test: filemicro_delete.f
>>>>>      cpufreq_governor: performance
>>>>>      ucode: 0x5003302
>>>> Please note, we still could see this regresion on v6.3-rc2. And the regression is related with
>>>> the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit changed the default timeout
>>>> value from 1s to 5s. If change the timeout back to 1s as following:
>>>>
>>>> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
>>>> index 6d13f8207e96..6b930fb0c4bd 100644
>>>> --- a/fs/cifs/fs_context.c
>>>> +++ b/fs/cifs/fs_context.c
>>>> @@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)
>>>>
>>>>          ctx->acregmax = CIFS_DEF_ACTIMEO;
>>>>          ctx->acdirmax = CIFS_DEF_ACTIMEO;
>>>> -       ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
>>>> +       ctx->closetimeo = CIFS_DEF_ACTIMEO;
>>>>
>>>>          /* Most clients set timeout to 0, allows server to use its default */
>>>>          ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
>>>>
>>>> The regression is gone:
>>>> dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be08f
>>>> ---------------- --------------------------- ---------------------------
>>>>         fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>>>>             |             |             |             |             |
>>>>             :25           0%            :3           33%           1:3     last_state.booting
>>>>             :25           0%            :3           33%           1:3     last_state.is_incomplete_run
>>>>           %stddev     %change         %stddev     %change         %stddev
>>>>               \          |                \          |                \
>>>>      515.95           -50.0%     257.98            -0.0%     515.92        filebench.sum_operations/s
>>>>        5.04 ±  7%    +833.7%      47.09 ±  2%      -2.9%       4.90 ±  2%  filebench.sum_time_ms/op
>>>>       10438          -100.0%       0.33 ±141%    -100.0%       0.50 ±100%  filebench.time.major_page_faults
>>>>      167575            -4.1%     160660            -4.4%     160140        filebench.time.maximum_resident_set_size
>>>>        7138 ± 11%    +141.4%      17235 ±  3%    +147.6%      17677        filebench.time.minor_page_faults
>>>>       28.68 ±  9%    +199.9%      86.00 ±  7%      -2.4%      28.00        filebench.time.percent_of_cpu_this_job_got
>>>>     2453485 ± 54%     -63.0%     907380           -66.2%     830273 ±  6%  cpuidle..usage
>>>>        0.61 ± 38%      +0.8        1.41 ±  3%      +0.2        0.80 ±  4%  mpstat.cpu.all.sys%
>>>>      142984 ± 13%     -45.6%      77725           -47.5%      75106        vmstat.system.in
>>>>       34.23 ±  7%     +27.9%      43.79           +27.8%      43.74        boot-time.boot
>>>>       17.09 ± 11%     +66.0%      28.38           +65.5%      28.28        boot-time.dhcp
>>>>        2661 ±  7%     +37.5%       3659           +37.2%       3651        boot-time.idle
>>>>      104737 ±185%     -87.8%      12762 ± 10%     -89.8%      10631 ±  4%  turbostat.C1
>>>>
>>>>
>>>> 32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the timeout to 1s. Thanks.
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>
>>>>>
>>>>>
>>>>> =========================================================================================
>>>>> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
>>>>>    gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
>>>>>
>>>>> commit:
>>>>>    dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we get from open_cached_dir")
>>>>>    5efdd9122e ("smb3: allow deferred close timeout to be configurable")
>>>>>
>>>>> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
>>>>> ---------------- ---------------------------
>>>>>           %stddev     %change         %stddev
>>>>>               \          |                \
>>>>>      515.95           -50.0%     257.98        filebench.sum_operations/s
>>>>>        4.81 ±  2%   +1038.4%      54.78 ±  6%  filebench.sum_time_ms/op
>>>>>       29.00 ±  8%    +212.1%      90.50 ±  3%  filebench.time.percent_of_cpu_this_job_got
>>>>>       24629            +2.7%      25297        filebench.time.voluntary_context_switches
>>>>>   7.685e+08           +19.3%  9.169e+08 ±  4%  cpuidle..time
>>>>>        2.53 ±  6%     -20.6%       2.00 ±  3%  iostat.cpu.iowait
>>>>>     1506141 ±  8%     +22.4%    1843256 ±  3%  turbostat.IRQ
>>>>>        2.00           -50.0%       1.00        vmstat.procs.b
>>>>>       21969 ±  2%      -9.5%      19885 ±  2%  vmstat.system.cs
>>>>>        3.06 ±  7%      -0.7        2.35 ±  4%  mpstat.cpu.all.iowait%
>>>>>        0.79 ±  5%      +0.5        1.27 ±  2%  mpstat.cpu.all.sys%
>>>>>        0.89 ±  3%      -0.1        0.79 ±  3%  mpstat.cpu.all.usr%
>>>>>       34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>>>>>      119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>>>>       34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.avg
>>>>>      119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>>>>        5249           +15.8%       6076        meminfo.Active
>>>>>        3866 ±  2%     +17.7%       4552        meminfo.Active(anon)
>>>>>        1382 ±  4%     +10.3%       1524 ±  4%  meminfo.Active(file)
>>>>>       69791 ± 14%     +39.8%      97553 ±  6%  meminfo.AnonHugePages
>>>>>       72709 ±  2%     +12.5%      81779 ±  3%  meminfo.Inactive(file)
>>>>>       23219           +13.5%      26352 ±  3%  meminfo.KernelStack
>>>>>      966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_active_anon
>>>>>       74302            +6.3%      78977 ±  2%  proc-vmstat.nr_anon_pages
>>>>>       81133            +6.0%      85973        proc-vmstat.nr_inactive_anon
>>>>>       18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_inactive_file
>>>>>       23213           +13.5%      26348 ±  3%  proc-vmstat.nr_kernel_stack
>>>>>       17983            +2.3%      18400        proc-vmstat.nr_mapped
>>>>>        7446 ±  2%      +5.5%       7853 ±  3%  proc-vmstat.nr_shmem
>>>>>       26888            +1.6%      27306        proc-vmstat.nr_slab_reclaimable
>>>>>       47220            +3.4%      48803        proc-vmstat.nr_slab_unreclaimable
>>>>>      966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_zone_active_anon
>>>>>       81133            +6.0%      85973        proc-vmstat.nr_zone_inactive_anon
>>>>>       18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_zone_inactive_file
>>>>>      361460            +2.5%     370454        proc-vmstat.numa_hit
>>>>>      946.67           +18.6%       1122        proc-vmstat.pgactivate
>>>>>      361562            +2.5%     370553        proc-vmstat.pgalloc_normal
>>>>>      187906            +4.7%     196761        proc-vmstat.pgfault
>>>>>        8189            +2.5%       8395        proc-vmstat.pgreuse
>>>>>   1.097e+09           +15.5%  1.267e+09 ±  7%  perf-stat.i.branch-instructions
>>>>>    39079265 ±  6%     -20.9%   30915354 ±  4%  perf-stat.i.branch-misses
>>>>>     5093263 ±  4%     -23.7%    3884752 ±  9%  perf-stat.i.cache-misses
>>>>>       29213           -18.7%      23764 ±  5%  perf-stat.i.context-switches
>>>>>   7.666e+09 ±  4%      +5.7%  8.106e+09 ±  2%  perf-stat.i.cpu-cycles
>>>>>        1877 ± 15%     +75.1%       3287 ± 12%  perf-stat.i.cycles-between-cache-misses
>>>>>     1735450 ±  3%     -12.9%    1512060 ±  3%  perf-stat.i.iTLB-load-misses
>>>>>        2898 ±  3%     +34.4%       3895 ±  7%  perf-stat.i.instructions-per-iTLB-miss
>>>>>        1493           -20.3%       1190 ±  7%  perf-stat.i.major-faults
>>>>>        0.09 ±  3%      +5.8%       0.09 ±  2%  perf-stat.i.metric.GHz
>>>>>       48.47 ± 11%      +8.4       56.83 ±  7%  perf-stat.i.node-store-miss-rate%
>>>>>      283426 ±  4%     -21.6%     222190 ± 10%  perf-stat.i.node-stores
>>>>>        3.57 ±  7%      -1.1        2.44 ±  6%  perf-stat.overall.branch-miss-rate%
>>>>>        1508 ±  3%     +39.8%       2108 ±  9%  perf-stat.overall.cycles-between-cache-misses
>>>>>        3022 ±  3%     +23.6%       3736 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
>>>>>   9.585e+08           +18.8%  1.138e+09 ±  6%  perf-stat.ps.branch-instructions
>>>>>    34151514 ±  6%     -18.8%   27725316 ±  4%  perf-stat.ps.branch-misses
>>>>>     4450329 ±  5%     -21.7%    3486409 ±  9%  perf-stat.ps.cache-misses
>>>>>       25524           -16.4%      21333 ±  4%  perf-stat.ps.context-switches
>>>>>       77139            +2.5%      79105        perf-stat.ps.cpu-clock
>>>>>   6.704e+09 ±  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cycles
>>>>>    1.06e+09           +11.3%   1.18e+09 ±  5%  perf-stat.ps.dTLB-loads
>>>>>     1517349 ±  3%     -10.5%    1357716 ±  2%  perf-stat.ps.iTLB-load-misses
>>>>>   4.582e+09           +10.8%  5.075e+09 ±  6%  perf-stat.ps.instructions
>>>>>        1296           -18.1%       1061 ±  6%  perf-stat.ps.major-faults
>>>>>      247613 ±  4%     -19.5%     199283 ±  9%  perf-stat.ps.node-stores
>>>>>       77139            +2.5%      79105        perf-stat.ps.task-clock
>>>>>   3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructions
>>>>>        8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.calltrace.cycles-pp.getdents64
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.open64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>>>        6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>>        6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>>>>>        8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.children.cycles-pp.getdents64
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>>>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>>>>        6.25 ±107%      -6.2        0.00        perf-profile.children.cycles-pp.open64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.__x64_sys_getdents64
>>>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.iterate_dir
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>>>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.get_signal
>>>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.children.cycles-pp.perf_mmap__read_head
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_vmas
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_page_range
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pmd_range
>>>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pte_range
>>>>>        8.54 ± 43%      +8.6       17.19 ± 38%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>>>>
>>>>>
>>>>> If you fix the issue, kindly add following tag
>>>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>>>>
>>>>>
>>>>> To reproduce:
>>>>>
>>>>>          git clone https://github.com/intel/lkp-tests.git
>>>>>          cd lkp-tests
>>>>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>>>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>>>          sudo bin/lkp run generated-yaml-file
>>>>>
>>>>>          # if come across any failure that blocks the test,
>>>>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>>>
>>>>>
>>>>> Disclaimer:
>>>>> Results have been estimated based on internal Intel analysis and are provided
>>>>> for informational purposes only. Any difference in system hardware or software
>>>>> design or configuration may affect actual performance.
>>>>>
>>>>>
>>>>> #regzbot introduced: 5efdd9122e
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 
