Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2203E6BD7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCPSLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCPSLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:11:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2FDCA66;
        Thu, 16 Mar 2023 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678990288; x=1710526288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6g4uKQlD4SAioLnHZj4SMQC9jtSat21P7K1ov+e0uI=;
  b=kfwL1h735QoSuWGDeWxJvg0kbqStBux9fb6+69cDHHnuNqR0aS/oj0DF
   kknH4jUzSzNAmbJ4aMM2Ok5h6rL15LA76h+JI+2rnMkRONlOTeQgZGBaI
   I/p7obJixMsjG0xSBxbQy21B7Hwu8hSC2rJe1P7Ad9oMMgeE5CpMwRwOb
   fSzME0c+NNm40NPUw6y3HboDo5wAGXcvyK5Mi2miMlr/K3K2PKd8Qg3CB
   +8jAQmb7l1779Hq+oyxhXgYOZXpDtSWPNRrFPvMGGCwiXWZRFOWlibWi2
   9A1vcD38TM+xbTuOeReIjcAN78sf3WAcZ68CnnFgxPE5wWxz4+DdZ6j4P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321930461"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321930461"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657273588"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657273588"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2023 11:11:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 11:11:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 11:11:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 11:11:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 11:11:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr0+GlCxMrs4LCLc2B78Mg+yKi/p5Pr5Qr1G9Y3gv2OCSShROwdTTBkfivyUIK/mk8x/gSEWXwW92tJq/mumtrFqicT6wjmkxpU7lq1wlNl9wjLDLriMoOGLJ3VhbBErsIfEj+Uyyok6cC8ZIRs0c6ReZRB2OgxZW3XThx6c6J95EQd5L+/gSwo3zg5sEz65wfJjFJ8hsUmqxZQ/3DgBDAzY1F1YAbL3L5hm9qXm4NxDWvw4ypst7evjU39ys0Z+c5yRYSuLDGpb6+skpVgJycpmN4AbGjmaaA0jLMOAcg2auoFtUv8lrUd3mZzZ6aMoAtYUxCDVmQGGO6nC0mlWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk51eO4wqQuJwVbCSXy0Hw1cKbYuMBxtwUu3GFC+f1c=;
 b=hBzCO4X86oN8/hQEAN0WV+tdzDUIr7zx9L3BAME7pvsylEHUHtGgprkDPVWEh7MvSGtwdaIxMRhyGUgjW17oG5SxyErPsfn6MZYfoKtXGDDNjp0jYivGIZoyxotWaWX/TwIts7pgSSmXu7o7/BntB8gcQyv6V+SrTjnDgh8v5CFmypmnSBMonLd1n+Mo6Sb+NEA8IgPf4sya9+uisGHyeAXWCw/ueMdLvMmQO5BS0vBamGRos3oupzbb+qCxYfi9wJnBgwi1zH8eUaaZBd6RyIVTGFbsTJrZhhuS+ZnpEgPcJvMyDbaGHfkrd7IWMVS4dCMPjlh8ih7OCczIRhlk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 18:11:24 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211%3]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 18:11:24 +0000
Message-ID: <74058e98-2bbc-3f36-7e3d-538fc2323264@intel.com>
Date:   Thu, 16 Mar 2023 11:11:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/8] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-7-jithu.joseph@intel.com>
 <628e092c-793e-96ce-71f5-80392ad69569@redhat.com>
 <9dde72aa-a28d-2b0e-7b90-6b1996dbf202@intel.com>
 <f45c26ae-865b-b7b6-0f2a-5906d9c0a349@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <f45c26ae-865b-b7b6-0f2a-5906d9c0a349@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: a87b09c9-ef54-4a0f-784a-08db2649da22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiIaOWdq7W/IuqXEsKQLVF8z9NeDLhWboEoDjp7BQFJ9F2aXryDWq1KBqzPxeF/a0DMb6dn/hcSEe14jlzMQFNPUEo1SnNFo9emVIzGAlEnmAS4ji9t+s5RXJlh4d174q6OIGcszInvkCw9RXIX1PYhy5Rlid9TCzeexL2/8p835OzfFYVb05pL8bi5tcDA3car/Ds8tN1P4rEK77+Z0PDZPWjSYQUwVR9btTQkdNN9wSimmpPYFgCU+zniqahl5J0KLGKQZOwpBQy8YDgaebG1SyGfSOH3Jsl59uTgd1Zbzpt8eoewiENbCYH3omEP+y2oiMEhhQ3AFw+KcFw4uADb40BeO/nX5vs9iHmc7iCUTIWRsJMQC5iqyH2lTmlBxzn8gio5ock+WHa9klBYBbMVG00KLaRbNklRB96t1OrmLju9OsXaNzYPaA7PEWSQPn+YfR14bFXKBSYnZSr0nNCmGQCLGSMBDT4d9VFS5XDBDT0LIBwyvjxmi2/OFsRN3fR23c5TjPYNgWTZ3FdiL/lgpo9jH8KB79ky5i35vot/bG5yePspaWG+jdXHLGKvnoGAXLCk8NGVE30jGuAYfNX7r2MTvO04UA3GUZ7pllOwpBb5T9XRa1kA0dX1y7kBC28L34x4v6kZpeh5GtSsa7LMzDYqSH3vdB40MNFn8aFcZqJCfWNDorRQVh5miHKsJ/yw+qZIz0hr3LGEIQHDlNZWnn6xMOpNi0hGWbN7GXtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(36756003)(86362001)(186003)(26005)(31696002)(6512007)(6506007)(6486002)(53546011)(2616005)(2906002)(7416002)(4744005)(38100700002)(8936002)(82960400001)(316002)(66946007)(66476007)(4326008)(66556008)(8676002)(5660300002)(31686004)(41300700001)(83380400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk52VEsydzRhME02bytaTFRvUEhreEw0dTJXWm1QK29DNW5KOHVveDVUZzlT?=
 =?utf-8?B?eGtBVVdzQThQenpidXlzWS9PRnNPL1JvblZIWklhRVNSYU1wZlQ5MlB1WFI4?=
 =?utf-8?B?MnpxMFcwM1VkakRLLzltMHhITGhlUEJqa0d1M0NNUStrT2RkQ2NDU1JlQ2Jv?=
 =?utf-8?B?THkxMnl2ZTdoUVFGQmtSUlA0eCszdXFobFBDRlY1TGtwNGYrZk1Zd2V0K3NL?=
 =?utf-8?B?UGN1WWZRRGJNK2p5Yi9IOUxXNWNhcDF0YzNQc1ZFbDVWRFAxYm45Y0l5N3ZG?=
 =?utf-8?B?c2pKcHRBMXl0TzQ2VDRzK0VBSlJMV211VytvQTZsSlFnVU5TUkc0MnVmNDkz?=
 =?utf-8?B?TG41QnlKOUJTYlFqMmZ2eFRET011RGl5MEk3SjJKVWIrT3RkVnBkQTd0bU10?=
 =?utf-8?B?SEJCbmFtdXorbEpxVytlUmFRbDVubXNNWllla3IvSXR2a2lmWTJjcGxqNDU1?=
 =?utf-8?B?TEdSTGVBYWF6Vi95WDVsRm96VWhxNTdhMyt4N1BvTW42cFhlMGN1WE5TVWR3?=
 =?utf-8?B?TVk5ZVNycy9mczdmYzNPR2ozZWpNbkFvUThnUC81UERZNExrRDJBWjdPeHlw?=
 =?utf-8?B?TC9jWGdrUHRsMEM2M2I0bDBJQTdnU0E3cU1tUXhtcUlZWk94cUp0OEdnWnAy?=
 =?utf-8?B?Y0FDUmFVZWo0L1ZQV3V0Z0dwNFNXajBWREdHM21hK1RDTzYrRm43YUpKZG4z?=
 =?utf-8?B?M1JkS1pJcFZFUU9td1FtcGpkSnNhSjlSNGpOMVhSeUsvL1NSMnJtcVVIby92?=
 =?utf-8?B?WnNpNzlFbUVFbk93cUJoNnB4Skx3Q1lTVjBRd1dQek43b3h6WXRpTlNPQ0RL?=
 =?utf-8?B?VlJKcTYzTXg3Y0dPZFdPemVkak1PWkhZSzdHOE9PbVlONGxiMkQvMGJBbTc3?=
 =?utf-8?B?alpuL2toK2l3NVlnRXlNYWRCZU9xaDBnNUVGWUdHM3Zka3FabjdLMGtSMXkr?=
 =?utf-8?B?dEpQMTQ3Y0EvRFE4OG5xZ3ZnQXZQejBrRHJqTlVJUkhjcmhQVkFGTENZbXFs?=
 =?utf-8?B?cGVmTkEzbDUwTnFHQW9MTUF1eGhLVHYydjdOK2NXWHdHWGduNDIzZDFieENa?=
 =?utf-8?B?a0dFV1A1REczbGI4Ym52NjNIRHczakFEaWNIK25hRXlrWGRYc1lETFpCS3BC?=
 =?utf-8?B?SUxDbGcvaVhkNGlxSUNVc2RSZ3ZkNHM0SGVXckV2M3VJV3ZmMHQxSjhZeW9H?=
 =?utf-8?B?R1UzM1lLYmNSbFB1ZFR2bk9BOHZwNXg5NkZTQ3A1RG9aTGlaS0syZzVxQUJt?=
 =?utf-8?B?TkF3bjVtaVNSN1BnclZFWmVWT0s2dE9MbGtBSENjVElYWWpmOEF2d0dSanR2?=
 =?utf-8?B?MVVkQlVyOFdhdFdtM20xVzZSTlBnenZSQzA3Tlg2TGN3a3g4L2Z2Tmt2OGg4?=
 =?utf-8?B?bmk4VWJKVGFDYW5abG5aSjErOG9QMDlOUGFKTjRnSVM1d0thWWdVcDFJNlU2?=
 =?utf-8?B?cDZFdVpjeTBNd01Gd0w1TkVHVHgyNjIrZldtbldqb0FOWFhNNnpWdlJYUDlr?=
 =?utf-8?B?MTMzeVdCN2xwMDhCOE9kVEQxZFNrQ3JNaFc1WW02Y2dDMEx0ZkFwSm9SRW9h?=
 =?utf-8?B?a2NlU25oVjRKS3A2d3NrSDNnNDZiRHJqSll1Z25tRGJDZVlrbzhZQXdHQURn?=
 =?utf-8?B?ZlUrZU5PT0E0dGV3ZXMxMHhkU0x5bXk3a3lSMVI1MDNZbmNsQmJXV0d6dmFK?=
 =?utf-8?B?TmF3OThneWhNSHhiS0xVVUlZc2dxRHBtTS8vT1J1OHA3M0RYMy96N3E2Ymcy?=
 =?utf-8?B?L3V4bDlnNnRzRDRRWHEvUlR0VG1zSEtuSTlSaGFFSnNJN1FLL3VOSzdueFVQ?=
 =?utf-8?B?RnRUM1BjZ1Fib2NXdDRtMUxEVEZoUmhjbVFSOXZWWTVRRWx6UEt4L2x6TG13?=
 =?utf-8?B?WUM3VExjTlFRTFFzTWhIbGxham8zY0Y3aWFSaGtvSkVZNk9JNEppSm5JZDdC?=
 =?utf-8?B?cHV6K3pGdElnQXNody8yUUg1RFdvVkw5VHJ3eitQaW5TZnkxcEY1MG9qRzFj?=
 =?utf-8?B?VFoycFdyTDdzc09RbkczQzZBRmhGT1ZVMldKazJ3OUE3c0dFRnBRSnhwNU81?=
 =?utf-8?B?blluMERraHNLVEtZQmIwMFJYNGdWUmdTemRLQW5TdGVDNkZuc1pKSloxSG5i?=
 =?utf-8?B?cHIwVHg0eU1Nb2dVVTZWc3V0b1MzeERWWnlZcG95Q216OTloUUlLK1dyMTZQ?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a87b09c9-ef54-4a0f-784a-08db2649da22
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 18:11:23.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKcYJdZUm/jzT4rvtq3xrN1mzAQNEy1ZvKHR331WiwBHBM4oQECYAtyACntgq+98hh2uzaC+kMkekAIvcQtIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 2:59 AM, Hans de Goede wrote:

> 
> After taking a closer look I do see one unrelated issue with this patch
> sysfs.c: run_test_store() does:
> 
>         if (!ifsd->loaded)
>                 rc = -EPERM;
>         else
>                 rc = do_core_test(cpu, dev);
> 
> But AFAICT the loaded check really only applies to the first (intel_ifs_0 device) test type and the 
> Array BIST test should work fine when loaded is false.
> 
> So I think that the if (!ifsd->loaded) error check should be moved to 
> ifs_test_core() ?
> 

It is possible that I misinterpreted your comment in my earlier reply. (Thanks Tony for pointing it out)
Yes I think moving the load check into ifs_test_core() is better than doing it in run_test_store()

Jithu


