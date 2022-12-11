Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF56494C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 16:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLKPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 10:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 10:24:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE9DFDF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670772277; x=1702308277;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=bcZXsOR4f6PKplr7MDgmxlCd60SwYKg71WW6L5Jkr0A=;
  b=nM7XbrKEY2oGqWugCQeyX32zpiPrrrYZp85ItB2sXnHKKH27utvDxkuP
   MEzvBYQsYyMdwrcnWU9X6LXKOLo8d3c4yNoEXcC8nj2OmqHvLlqTuKdCr
   mqb6QbCKi5s7sCbPOG1LPf/QmHoTghKaqQwFaem6U6zaOq0NgwEBeCdVC
   n3sU2lKv2FKU13BQVWlSSLgIeGqya9CnpB64PBJteeucrG16decmM/uSD
   27taiu2j891Yw1kCNwHh7utjtY4GlCye5K3Z0BFO9PyT/329ownvc5wVu
   IDzIOXdISgArEwrGgY3qJdw/wqw9AXkIM9o8UwtBQC7/IgBAmldhClB41
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="382013828"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="xz'?yaml'?scan'208";a="382013828"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 07:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="736692548"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="xz'?yaml'?scan'208";a="736692548"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2022 07:24:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 07:24:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 07:24:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 07:24:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 07:24:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt1yPKI1tJXTOB6/P6etT/KmA2lDjV2VyIA4ciJvI0zE7P9ApbhLcyTNSp1X+D7qyiTvb5iXVa60tSA0Jg39hsBCzspvxI0lgiWMl6EhP1ZoPeaUCNM8b7tIXEaeD1ZqYpcjk9vwxlsvDypAPitdbxNcEXUTL0gfQFeruQJvDF+D63thUhexGYyCHkfzKUL5kr0cSW1ic9xZojkuQBgh9s01ZGsisMviqylx0pTqDQf0UTVpSo+CxPe9ejrSmC11rtJhUUyWDHrgw6B/irPSVuFtUfZrELjBlGjIhfWhYoKPznnU9HfDG+CDEU1tM87IAAyFtItMBmemVoAqILRXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5oIePhdTettlpmymhKIr+XjDijEjl/WfCzQZlTis3Q=;
 b=JtXvxoMD7rIjKy0TE6EqH91ysxFRMPcq6C56OibOvvLjAPcS0c+sXLnNZ27GdWXwwUFGXlQaSZRv47mmOhP1nlVg7SM84ttmjtMnG96xe6ZWeY5hHZeQm2JEShUhWR8AT/PK2u4Ptf0/Wa/QW3Pogq98Xbhl/E8JKF5WJJaK5R92SxDtQogxQuol8lcIZ92rn8Efyp1cNL1E8/DxTOlJsfAdgJkbB+g+6TVOQl4DYXZ5CSg0blJX+Q8tQIJuUPQ0hwczH23wtBzGtkZPngC9dnMTefNSFUuivo/deDs/T6iVGmLazszXWiDih2CVI8fYShu86RraxH3PFprWGmWPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW4PR11MB6812.namprd11.prod.outlook.com (2603:10b6:303:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 15:24:29 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%7]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 15:24:29 +0000
Date:   Sun, 11 Dec 2022 23:24:18 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Keith Busch <kbusch@meta.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 11/11] dmapool: link blocks across pages
Message-ID: <202212112301.ad0819f7-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="JKjdV7AouEqRPVaE"
Content-Disposition: inline
In-Reply-To: <20221205145937.54367-12-kbusch@meta.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW4PR11MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4e7a54-34e5-4ff2-68c9-08dadb8bca6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrdRQ143ej98ay4hF/ZtKgW5KzHrrhTTcMfSDbk6civbQb5/ScdmdIZ+q8sYh6pGWdHAiG4YV1XQx2H+ngsuKRAqV3IXiKRs5TVv036gLU4Vq2fQbXxfg0ngEqiAIhSEhxw8h2niZ+QyALDi0kPVit/Yv+MLR/ftai5U8ztaBNVETvWSnoU8XMNwRL4pZkD/+Yo+Gtq4eRHRFsLuDBug5ekhIRN27tWOMsJEy2MY/hKYwFgDxJvXJEfeHaTZLM5Vdrl3UEWSBq3mJrYJH2Z9oCiW5P5ibAy+pNmhJitv0ZgwOESoKZXhnJrDXNxBjyZuUa62p9c7gPM9KmwejDpsQJ+kONjwv294GkJKGWqD6ffdsLilNWiuXJ6xGndXKlJviUKnZRmCQt1Qq7dVV2QQHJZH5c6NYgQyYRv0rv1xoakxGnXc5QS47nNrg+Suwk3g1zBK9GPxNsHuAZd627TY2vO0NEM4B00MmdoK+ouASBIEy+RCS8lfCEqXqHaNNWPGPweVPpzHtL0aO00Q6SKUDaaAoYFGZNZOJlohK9E9oMia7jBazNYM1aIBxvc4GdGWjdy0UdbUsfI3VYTq9tdpsAnv1VxlQESLPYW8BzEbCOtlqyzwkQ90khlZVXmYP9P0SAPsAL3ZYLBEVTdBjrlgE1YY6j2ziEAqbI4hizPfZnVZZA6JD7xRqM/gBEY9sLplfpZqhgsIHpemFFZhKiMqPHOxj9WmMmIckwS/hHiXHPHH4DVEtJkV8W1PwnpMHE18TCS3OqYhHtStnq3W/RsMHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38100700002)(82960400001)(966005)(86362001)(6486002)(478600001)(41300700001)(8936002)(6666004)(8676002)(66476007)(4326008)(66946007)(66556008)(45080400002)(6916009)(316002)(2906002)(54906003)(6506007)(83380400001)(235185007)(186003)(44144004)(6512007)(26005)(21490400003)(1076003)(2616005)(5660300002)(36756003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wGBlrv8D4yWBG6jWHf/ydmYXbI4ORLIkQ3k2YfA/ob83tssOpwB7j9Dc0Rzu?=
 =?us-ascii?Q?jOj8g1tuWqVKKZcVQE3m/F9sPyYdCr+3WVaZCdH90JREgt3XGXTJrbtF8ZtY?=
 =?us-ascii?Q?McYnYgsFTau8n1uxxjxHAQNPQrmn8BZ10NwWThT/IJhFcN42kO+XGK3HExPb?=
 =?us-ascii?Q?tg8KNoSRxm11knsHvhhwAOlAi1Q1fmsF3AirrxfOKv4GqGiSGVMjwk7YZen5?=
 =?us-ascii?Q?iiMfZQdPq+V0WIfTYjvilEM2yFnGVZLN9RSkWxCxGyvu7iyZZ3+PatMBT8XK?=
 =?us-ascii?Q?Jnvfxw399dgKnQDfrliQks7gv++V2FjX/YHsk+usxft3Ra7Zt8pCVYoYNOSU?=
 =?us-ascii?Q?fzJ8Ejh2utEgddkJ9ypAnEYlApn7+gbNtfky5oUpqZx9nSbUJz8tJzOiAD0P?=
 =?us-ascii?Q?VD5V/odIgqGV3YfAglMJJpfq2S4Xw7SLQDkLlkJ2QvWSM02QhnLGY4qStuB3?=
 =?us-ascii?Q?HnVMvQP03/7f/Nvj7+4DE1hB8rVcYlTjXbQLSv3W0fIn4isf1mHd+aEmMkso?=
 =?us-ascii?Q?isxp9XA7RG+4bjRe6cUkMK/RaShP9eY9X8iVbImLUFHeVXGr+SQr8qdTA99A?=
 =?us-ascii?Q?84CREwB39ZHCvJKjDcHLAmY90S75J0KusrmlVj1r+w7eV8/hWWZgivzIdMi9?=
 =?us-ascii?Q?D6Ly7VOfqEns+U1SwzNb6zlAedPKECbE4vyjDsZ/v4gLjtZ2eKth09JLGZL3?=
 =?us-ascii?Q?yDxVMYJY5x6FgOepI0nt+MFERE+aXUF00FtWrnSQosUj52pe5HMMI/MbeRsp?=
 =?us-ascii?Q?crNv9ItGWOlZ9jb2BgTls9j9UKNx0BgdI+Tz4je8jWZdjyDMS58lU/Ba7WTm?=
 =?us-ascii?Q?tUxY9ptNJjhgs695iQkZKvzj/JoJkg3AAgmP+OMHDX+8lflbI1hZDayPrErN?=
 =?us-ascii?Q?YDw9YnS3CZUhvJUSGcA9CnCTKhVwOemcmBsQKgsJaD1KER7WBo3DmcRd1VkG?=
 =?us-ascii?Q?w7VXpiisud5lhRcdjh8OdX8Z8VeeY9gTsxuK2ip/5WVhRBBqeiuaSPAGeYXL?=
 =?us-ascii?Q?/4DdmYVWx8w2G9fuw4PPjoHjSRhIJuReqbGzIqDN2WB0V5f3rcqg+fW4FTMh?=
 =?us-ascii?Q?oMbb1dzmxnjnrM3l51npTC1cLErvYyC/uk95Mi5TuHOiYMmUm4sqStNyXq+G?=
 =?us-ascii?Q?xWHm9y3cEOqKH+82Y6lYOdlcZF5vOT6wmuW4agi/NKV79jTO6ha3VL0Wlg2q?=
 =?us-ascii?Q?kHg+Tpe6UIMEa5RLIb6vRNGuP2XZY2nj2iDdiM+Lq9H46oUpowgBay3oMXK5?=
 =?us-ascii?Q?GxhPuomO580R4mVNL0ksRvh9dc/Rmgt4MqN3V88okADBuspNRddxyBUywfCc?=
 =?us-ascii?Q?wfSlT2eKiFBePqFN6tpsgnArD/q8MPzM6MjvscB/QqMrDP7q1CA3VthJfPZI?=
 =?us-ascii?Q?cfKRnsLzRlx2WMQ54Y++0p56oWj7h3jYk2jlr9f4pjrwBY6aHAEGLU6GSrWU?=
 =?us-ascii?Q?k3Ik9JyJbVNYrwHUsnj3LoIEg4JYrj4eUms8Y33mOx8fVS/d0vA27O5HRa1D?=
 =?us-ascii?Q?bQGExbFBBC2VA/27arSgigStWjRhv7tb9E9xrkBUUJueSqK/ocV1Q2vPnh/1?=
 =?us-ascii?Q?uCtLVew7y+X1dsZ7QzaaudmoO2XRU3ym7/VoJqbgKIVDgxmG54ZCkJk21Rk6?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e7a54-34e5-4ff2-68c9-08dadb8bca6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 15:24:28.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HSyCjAiG0VtF0DWZE2R5fB/rTW6OwqO5sBv+JOnlgTzTNKaiYj7lmhfQQeviPgjF4uX8PRY8h852W0aVPzeZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6812
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--JKjdV7AouEqRPVaE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:unable_to_handle_page_fault_for_address due to commit (built with gcc-11):

commit: 3717500cb5479136121a65d22d48f4b5e940bba4 ("[PATCH 11/11] dmapool: link blocks across pages")
url: https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/dmapool-enhancements/20221205-232116
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 76dcd734eca23168cb008912c0f69ff408905235
patch link: https://lore.kernel.org/all/20221205145937.54367-12-kbusch@meta.com/
patch subject: [PATCH 11/11] dmapool: link blocks across pages

in testcase: nvml
version: nvml-x86_64-ec9fc0404-1_20221026
with following parameters:

	test: pmem
	group: libpmempool
	nr_pmem: 1
	fs: ext4
	mount_option: dax
	bp_memmap: 32G!4G



on test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202212112301.ad0819f7-oliver.sang@intel.com


[   25.268833][    T1] BUG: unable to handle page fault for address: ffff88807bdb6000
[   25.269731][    T1] #PF: supervisor write access in kernel mode
[   25.269731][    T1] #PF: error_code(0x0002) - not-present page
[   25.269731][    T1] PGD c7fe01067 P4D c7fe01067 PUD c7fe04067 PMD c7fe07067 PTE 0
[   25.269731][    T1] Oops: 0002 [#1] SMP KASAN PTI
[   25.269731][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc8-00011-g3717500cb547 #1
[   25.269731][    T1] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
[ 25.269731][ T1] RIP: 0010:memset_erms (arch/x86/lib/memset_64.S:64) 
[ 25.269731][ T1] Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
All code
========
   0:	c1 e9 03             	shr    $0x3,%ecx
   3:	40 0f b6 f6          	movzbl %sil,%esi
   7:	48 b8 01 01 01 01 01 	movabs $0x101010101010101,%rax
   e:	01 01 01 
  11:	48 0f af c6          	imul   %rsi,%rax
  15:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  18:	89 d1                	mov    %edx,%ecx
  1a:	f3 aa                	rep stos %al,%es:(%rdi)
  1c:	4c 89 c8             	mov    %r9,%rax
  1f:	c3                   	retq   
  20:	90                   	nop
  21:	49 89 f9             	mov    %rdi,%r9
  24:	40 88 f0             	mov    %sil,%al
  27:	48 89 d1             	mov    %rdx,%rcx
  2a:*	f3 aa                	rep stos %al,%es:(%rdi)		<-- trapping instruction
  2c:	4c 89 c8             	mov    %r9,%rax
  2f:	c3                   	retq   
  30:	90                   	nop
  31:	49 89 fa             	mov    %rdi,%r10
  34:	40 0f b6 ce          	movzbl %sil,%ecx
  38:	48                   	rex.W
  39:	b8 01 01 01 01       	mov    $0x1010101,%eax
  3e:	01 01                	add    %eax,(%rcx)

Code starting with the faulting instruction
===========================================
   0:	f3 aa                	rep stos %al,%es:(%rdi)
   2:	4c 89 c8             	mov    %r9,%rax
   5:	c3                   	retq   
   6:	90                   	nop
   7:	49 89 fa             	mov    %rdi,%r10
   a:	40 0f b6 ce          	movzbl %sil,%ecx
   e:	48                   	rex.W
   f:	b8 01 01 01 01       	mov    $0x1010101,%eax
  14:	01 01                	add    %eax,(%rcx)
[   25.269731][    T1] RSP: 0000:ffffc90000057630 EFLAGS: 00010202
[   25.269731][    T1] RAX: 0000000000000000 RBX: ffff888952c8e400 RCX: 0000000000000020
[   25.269731][    T1] RDX: 0000000000000060 RSI: 0000000000000000 RDI: ffff88807bdb6000
[   25.269731][    T1] RBP: 000000007bdb5fc0 R08: 0000000000000001 R09: ffff88807bdb5fc0
[   25.269731][    T1] R10: ffffed100f7b6c03 R11: 0000000000000001 R12: ffff88807bdb5fc0
[   25.269731][    T1] R13: ffff88807bdb5fc0 R14: 0000000000000100 R15: ffff888952c8e410
[   25.269731][    T1] FS:  0000000000000000(0000) GS:ffff888b9fa80000(0000) knlGS:0000000000000000
[   25.269731][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.269731][    T1] CR2: ffff88807bdb6000 CR3: 0000000c7e20e001 CR4: 00000000003706e0
[   25.269731][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   25.269731][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   25.269731][    T1] Call Trace:
[   25.269731][    T1]  <TASK>
[ 25.269731][ T1] dma_pool_alloc (mm/dmapool.c:370) 
[ 25.269731][ T1] ? kasan_set_track (mm/kasan/common.c:52) 
[ 25.269731][ T1] ehci_qh_alloc (drivers/usb/host/ehci-mem.c:75) 
[ 25.269731][ T1] ? ehci_qtd_alloc (drivers/usb/host/ehci-mem.c:68) 
[ 25.269731][ T1] ? dma_pool_create (mm/dmapool.c:215) 
[ 25.269731][ T1] ehci_mem_init+0x10a/0x780 
[ 25.269731][ T1] ? __hrtimer_init (kernel/time/hrtimer.c:1559) 
[ 25.269731][ T1] ehci_init (drivers/usb/host/ehci-hcd.c:504) 
[ 25.269731][ T1] ehci_setup (drivers/usb/early/ehci-dbgp.c:811 (discriminator 3)) 
[ 25.269731][ T1] ehci_pci_setup (drivers/usb/host/ehci-pci.c:261) 
[ 25.269731][ T1] ? ehci_pci_resume (drivers/usb/host/ehci-pci.c:91) 
[ 25.269731][ T1] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:449 include/linux/atomic/atomic-instrumented.h:1790 kernel/locking/mutex.c:181 kernel/locking/mutex.c:540) 
[ 25.269731][ T1] ? __mutex_unlock_slowpath+0x2a0/0x2a0 
[ 25.269731][ T1] ? usb_alloc_dev (drivers/usb/core/usb.c:670) 
[ 25.269731][ T1] usb_add_hcd.cold (drivers/usb/core/hcd.c:2939) 
[ 25.269731][ T1] usb_hcd_pci_probe (drivers/usb/core/hcd-pci.c:259) 
[ 25.269731][ T1] ? ehci_pci_remove (drivers/usb/host/ehci-pci.c:382) 
[ 25.269731][ T1] local_pci_probe (drivers/pci/pci-driver.c:324) 
[ 25.269731][ T1] pci_call_probe (drivers/pci/pci-driver.c:392) 
[ 25.269731][ T1] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 25.269731][ T1] ? pci_pm_suspend_noirq (drivers/pci/pci-driver.c:352) 
[ 25.269731][ T1] ? pci_assign_irq (drivers/pci/setup-irq.c:25) 
[ 25.269731][ T1] ? pci_match_device (drivers/pci/pci-driver.c:108 drivers/pci/pci-driver.c:159) 
[ 25.269731][ T1] ? kernfs_put (arch/x86/include/asm/atomic.h:123 (discriminator 1) include/linux/atomic/atomic-instrumented.h:576 (discriminator 1) fs/kernfs/dir.c:536 (discriminator 1)) 
[ 25.269731][ T1] pci_device_probe (drivers/pci/pci-driver.c:461) 
[ 25.269731][ T1] really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639) 
[ 25.269731][ T1] __driver_probe_device (drivers/base/dd.c:719 drivers/base/dd.c:776) 
[ 25.269731][ T1] driver_probe_device (drivers/base/dd.c:808) 
[ 25.269731][ T1] __driver_attach (drivers/base/dd.c:1191) 
[ 25.269731][ T1] ? __device_attach_driver (drivers/base/dd.c:1135) 
[ 25.269731][ T1] bus_for_each_dev (drivers/base/bus.c:301) 
[ 25.269731][ T1] ? subsys_dev_iter_exit (drivers/base/bus.c:290) 
[ 25.269731][ T1] ? __kmem_cache_alloc_node (mm/slub.c:3400 mm/slub.c:3437) 
[ 25.269731][ T1] ? klist_add_tail (include/linux/list.h:69 include/linux/list.h:102 lib/klist.c:104 lib/klist.c:137) 
[ 25.269731][ T1] bus_add_driver (drivers/base/bus.c:618) 
[ 25.269731][ T1] driver_register (drivers/base/driver.c:246) 
[ 25.269731][ T1] ? ehci_hcd_init (drivers/usb/host/ehci-pci.c:422) 
[ 25.269731][ T1] do_one_initcall (init/main.c:1303) 
[ 25.269731][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1294) 
[ 25.269731][ T1] ? parse_one (kernel/params.c:170) 
[ 25.269731][ T1] ? do_initcalls (init/main.c:1386) 
[ 25.269731][ T1] ? kasan_set_track (mm/kasan/common.c:52) 
[ 25.269731][ T1] ? __kasan_kmalloc (mm/kasan/common.c:381) 
[ 25.269731][ T1] do_initcalls (init/main.c:1375 init/main.c:1392) 
[ 25.269731][ T1] kernel_init_freeable (init/main.c:1635) 
[ 25.269731][ T1] ? console_on_rootfs (init/main.c:1601) 
[ 25.269731][ T1] ? usleep_range_state (kernel/time/timer.c:1897) 
[ 25.269731][ T1] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
[ 25.269731][ T1] ? rest_init (init/main.c:1511) 
[ 25.269731][ T1] ? rest_init (init/main.c:1511) 
[ 25.269731][ T1] kernel_init (init/main.c:1521) 
[ 25.269731][ T1] ret_from_fork (arch/x86/entry/entry_64.S:312) 
[   25.269731][    T1]  </TASK>
[   25.269731][    T1] Modules linked in:
[   25.269731][    T1] CR2: ffff88807bdb6000
[   25.269731][    T1] ---[ end trace 0000000000000000 ]---
[ 25.269731][ T1] RIP: 0010:memset_erms (arch/x86/lib/memset_64.S:64) 
[ 25.269731][ T1] Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
All code
========
   0:	c1 e9 03             	shr    $0x3,%ecx
   3:	40 0f b6 f6          	movzbl %sil,%esi
   7:	48 b8 01 01 01 01 01 	movabs $0x101010101010101,%rax
   e:	01 01 01 
  11:	48 0f af c6          	imul   %rsi,%rax
  15:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  18:	89 d1                	mov    %edx,%ecx
  1a:	f3 aa                	rep stos %al,%es:(%rdi)
  1c:	4c 89 c8             	mov    %r9,%rax
  1f:	c3                   	retq   
  20:	90                   	nop
  21:	49 89 f9             	mov    %rdi,%r9
  24:	40 88 f0             	mov    %sil,%al
  27:	48 89 d1             	mov    %rdx,%rcx
  2a:*	f3 aa                	rep stos %al,%es:(%rdi)		<-- trapping instruction
  2c:	4c 89 c8             	mov    %r9,%rax
  2f:	c3                   	retq   
  30:	90                   	nop
  31:	49 89 fa             	mov    %rdi,%r10
  34:	40 0f b6 ce          	movzbl %sil,%ecx
  38:	48                   	rex.W
  39:	b8 01 01 01 01       	mov    $0x1010101,%eax
  3e:	01 01                	add    %eax,(%rcx)

Code starting with the faulting instruction
===========================================
   0:	f3 aa                	rep stos %al,%es:(%rdi)
   2:	4c 89 c8             	mov    %r9,%rax
   5:	c3                   	retq   
   6:	90                   	nop
   7:	49 89 fa             	mov    %rdi,%r10
   a:	40 0f b6 ce          	movzbl %sil,%ecx
   e:	48                   	rex.W
   f:	b8 01 01 01 01       	mov    $0x1010101,%eax
  14:	01 01                	add    %eax,(%rcx)


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--JKjdV7AouEqRPVaE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc8-00011-g3717500cb547"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc8 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_SVM is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--JKjdV7AouEqRPVaE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='nvml'
	export testcase='nvml'
	export category='functional'
	export test='pmem'
	export group='libpmempool'
	export mount_option='dax'
	export job_origin='nvml-dax.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-bdw-de1'
	export tbox_group='lkp-bdw-de1'
	export submit_id='6392b801811c3bc88d1803c6'
	export job_file='/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221209-51341-1w8tyma-3.yaml'
	export id='770049d989b4f068de9f727448e7f54a8122c626'
	export queuer_version='/zday/lkp'
	export model='Broadwell-DE'
	export nr_node=1
	export nr_cpu=16
	export memory='48G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=1
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV410402GY800OGN-part2'
	export hdd_partitions='/dev/disk/by-id/ata-ST9500620NS_9XF26EB5-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV410402GY800OGN-part1'
	export brand='Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz'
	export need_kconfig='{"NVDIMM_PFN"=>"y"}
MMU
{"FS_DAX"=>"y"}
ZONE_DEVICE
LIBNVDIMM
BTT
BLK_DEV_PMEM
X86_PMEM_LEGACY
FS_DAX
EXT4_FS'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export commit='3717500cb5479136121a65d22d48f4b5e940bba4'
	export ucode='0x700001c'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"IGB"=>"y"}
{"NETDEVICES"=>"y"}
{"ETHERNET"=>"y"}
{"NET_VENDOR_INTEL"=>"y"}
{"PCI"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"HAS_DMA"=>"y"}'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-12-09 12:22:25 +0800'
	export _id='6392b801811c3bc88d1803c6'
	export _rt='/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='235b4a3e19d7383c847aa641429cbe336f9f7834'
	export base_commit='76dcd734eca23168cb008912c0f69ff408905235'
	export branch='linux-review/Keith-Busch/dmapool-enhancements/20221205-232116'
	export result_root='/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547
branch=linux-review/Keith-Busch/dmapool-enhancements/20221205-232116
job=/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221209-51341-1w8tyma-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=3717500cb5479136121a65d22d48f4b5e940bba4
initcall_debug
memmap=32G!4G
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/nvml_20221021.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/nvml-x86_64-ec9fc0404-1_20221026.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.1.0-rc8-wt-11783-g1c291e00e780'
	export repeat_to=6
	export stop_repeat_if_found='dmesg.BUG:unable_to_handle_page_fault_for_address'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547'
	export dequeue_time='2022-12-09 12:36:59 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221209-51341-1w8tyma-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_pmem=1 $LKP_SRC/setup/disk

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_setup bp_memmap='32G!4G' $LKP_SRC/setup/boot_params

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper nvml
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper nvml
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time nvml.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--JKjdV7AouEqRPVaE
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--JKjdV7AouEqRPVaE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="nvml"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.1.0-rc8-00011-g3717500cb547 (kbuild@1c3d44eda86e) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Thu Dec  8 22:33:09 CST 2022
Command line: ip=::::lkp-bdw-de1::dhcp root=/dev/ram0 RESULT_ROOT=/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547 branch=linux-review/Keith-Busch/dmapool-enhancements/20221205-232116 job=/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221209-51341-1w8tyma-3.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=3717500cb5479136121a65d22d48f4b5e940bba4 initcall_debug memmap=32G!4G max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
signal: max sigframe size: 1776
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000100-0x000000000009abff] usable
BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000796e0fff] usable
BIOS-e820: [mem 0x00000000796e1000-0x00000000798affff] reserved
BIOS-e820: [mem 0x00000000798b0000-0x00000000799adfff] usable
BIOS-e820: [mem 0x00000000799ae000-0x0000000079e5efff] ACPI NVS
BIOS-e820: [mem 0x0000000079e5f000-0x000000007bdb4fff] reserved
BIOS-e820: [mem 0x000000007bdb5000-0x000000007bdb5fff] usable
BIOS-e820: [mem 0x000000007bdb6000-0x000000007be3bfff] reserved
BIOS-e820: [mem 0x000000007be3c000-0x000000007bffffff] usable
BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x0000000c7fffffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
user-defined physical RAM map:
user: [mem 0x0000000000000100-0x000000000009abff] usable
user: [mem 0x000000000009ac00-0x000000000009ffff] reserved
user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
user: [mem 0x0000000000100000-0x00000000796e0fff] usable
user: [mem 0x00000000796e1000-0x00000000798affff] reserved
user: [mem 0x00000000798b0000-0x00000000799adfff] usable
user: [mem 0x00000000799ae000-0x0000000079e5efff] ACPI NVS
user: [mem 0x0000000079e5f000-0x000000007bdb4fff] reserved
user: [mem 0x000000007bdb5000-0x000000007bdb5fff] usable
user: [mem 0x000000007bdb6000-0x000000007be3bfff] reserved
user: [mem 0x000000007be3c000-0x000000007bffffff] usable
user: [mem 0x0000000080000000-0x000000008fffffff] reserved
user: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
user: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
user: [mem 0x0000000100000000-0x00000008ffffffff] persistent (type 12)
user: [mem 0x0000000900000000-0x0000000c7fffffff] usable
SMBIOS 2.8 present.
DMI: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
tsc: Fast TSC calibration using PIT
tsc: Detected 2099.996 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0xc80000 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0x7c000 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000fd970-0x000fd97f]
mpc: fd670-fd8ec
Using GB pages for direct mapping
RAMDISK: [mem 0xc41a56000-0xc7a9fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F0580 000024 (v02 SUPERM)
ACPI: XSDT 0x00000000799FE0A0 0000BC (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
ACPI: FACP 0x0000000079A15CA0 00010C (v05 SUPERM SMCI--MB 01072009 AMI  00010013)
ACPI: DSDT 0x00000000799FE1F0 017AAD (v02 SUPERM SMCI--MB 01072009 INTL 20091013)
ACPI: FACS 0x0000000079E5DF80 000040
ACPI: APIC 0x0000000079A15DB0 000138 (v03 SUPERM SMCI--MB 01072009 AMI  00010013)
ACPI: FPDT 0x0000000079A15EE8 000044 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
ACPI: FIDT 0x0000000079A15F30 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
ACPI: SPMI 0x0000000079A15FD0 000040 (v05 SUPERM SMCI--MB 00000000 AMI. 00000000)
ACPI: MCFG 0x0000000079A16010 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
ACPI: UEFI 0x0000000079A16050 000042 (v01                 00000000      00000000)
ACPI: DBG2 0x0000000079A16098 000072 (v00 SUPERM SMCI--MB 00000000 INTL 20091013)
ACPI: HPET 0x0000000079A16110 000038 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
ACPI: WDDT 0x0000000079A16148 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
ACPI: SSDT 0x0000000079A16188 00ED8B (v01 AMI    PmMgt    00000001 INTL 20120913)
ACPI: SSDT 0x0000000079A24F18 002285 (v02 SUPERM SpsNm    00000002 INTL 20120913)
ACPI: SSDT 0x0000000079A271A0 000064 (v02 SUPERM SpsNvs   00000002 INTL 20120913)
ACPI: PRAD 0x0000000079A27208 000102 (v02 SUPERM SMCI--MB 00000002 INTL 20120913)
ACPI: DMAR 0x0000000079A27310 0000C4 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
ACPI: HEST 0x0000000079A273D8 0000A8 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
ACPI: BERT 0x0000000079A27480 000030 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
ACPI: ERST 0x0000000079A274B0 000230 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
ACPI: EINJ 0x0000000079A276E0 000130 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
ACPI: Reserving FACP table memory at [mem 0x79a15ca0-0x79a15dab]
ACPI: Reserving DSDT table memory at [mem 0x799fe1f0-0x79a15c9c]
ACPI: Reserving FACS table memory at [mem 0x79e5df80-0x79e5dfbf]
ACPI: Reserving APIC table memory at [mem 0x79a15db0-0x79a15ee7]
ACPI: Reserving FPDT table memory at [mem 0x79a15ee8-0x79a15f2b]
ACPI: Reserving FIDT table memory at [mem 0x79a15f30-0x79a15fcb]
ACPI: Reserving SPMI table memory at [mem 0x79a15fd0-0x79a1600f]
ACPI: Reserving MCFG table memory at [mem 0x79a16010-0x79a1604b]
ACPI: Reserving UEFI table memory at [mem 0x79a16050-0x79a16091]
ACPI: Reserving DBG2 table memory at [mem 0x79a16098-0x79a16109]
ACPI: Reserving HPET table memory at [mem 0x79a16110-0x79a16147]
ACPI: Reserving WDDT table memory at [mem 0x79a16148-0x79a16187]
ACPI: Reserving SSDT table memory at [mem 0x79a16188-0x79a24f12]
ACPI: Reserving SSDT table memory at [mem 0x79a24f18-0x79a2719c]
ACPI: Reserving SSDT table memory at [mem 0x79a271a0-0x79a27203]
ACPI: Reserving PRAD table memory at [mem 0x79a27208-0x79a27309]
ACPI: Reserving DMAR table memory at [mem 0x79a27310-0x79a273d3]
ACPI: Reserving HEST table memory at [mem 0x79a273d8-0x79a2747f]
ACPI: Reserving BERT table memory at [mem 0x79a27480-0x79a274af]
ACPI: Reserving ERST table memory at [mem 0x79a274b0-0x79a276df]
ACPI: Reserving EINJ table memory at [mem 0x79a276e0-0x79a2780f]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x0000000c7fffffff]
NODE_DATA(0) allocated [mem 0xc7ffd5000-0xc7fffffff]
cma: Reserved 200 MiB at 0x0000000900000000
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x0000000c7fffffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x0000000000099fff]
node   0: [mem 0x0000000000100000-0x00000000796e0fff]
node   0: [mem 0x00000000798b0000-0x00000000799adfff]
node   0: [mem 0x000000007bdb5000-0x000000007bdb5fff]
node   0: [mem 0x000000007be3c000-0x000000007bffffff]
node   0: [mem 0x0000000900000000-0x0000000c7fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x0000000c7fffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 102 pages in unavailable ranges
On node 0, zone DMA32: 463 pages in unavailable ranges
On node 0, zone DMA32: 9223 pages in unavailable ranges
On node 0, zone DMA32: 134 pages in unavailable ranges
On node 0, zone Normal: 16384 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 8, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 8, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 8, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 8, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 8, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 8, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 8, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 8, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 8, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 8, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 8, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 8, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 8, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 8, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 8, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 16 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
mapped IOAPIC to ffffffffff5fa000 (fec01000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009a000-0x0009afff]
PM: hibernation: Registered nosave memory: [mem 0x0009b000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0x796e1000-0x798affff]
PM: hibernation: Registered nosave memory: [mem 0x799ae000-0x79e5efff]
PM: hibernation: Registered nosave memory: [mem 0x79e5f000-0x7bdb4fff]
PM: hibernation: Registered nosave memory: [mem 0x7bdb6000-0x7be3bfff]
PM: hibernation: Registered nosave memory: [mem 0x7c000000-0x7fffffff]
PM: hibernation: Registered nosave memory: [mem 0x80000000-0x8fffffff]
PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfed1bfff]
PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfeffffff]
PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
PM: hibernation: Registered nosave memory: [mem 0x100000000-0x8ffffffff]
[mem 0x90000000-0xfed1bfff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
percpu: Embedded 66 pages/cpu s233448 r8192 d28696 u524288
pcpu-alloc: s233448 r8192 d28696 u524288 alloc=1*2097152
pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 4102717
Policy zone: Normal
Kernel command line: ip=::::lkp-bdw-de1::dhcp root=/dev/ram0 RESULT_ROOT=/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547 branch=linux-review/Keith-Busch/dmapool-enhancements/20221205-232116 job=/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221209-51341-1w8tyma-3.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=3717500cb5479136121a65d22d48f4b5e940bba4 initcall_debug memmap=32G!4G max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547 branch=linux-review/Keith-Busch/dmapool-enhancements/20221205-232116 job=/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221209-51341-1w8tyma-3.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=3717500cb5479136121a65d22d48f4b5e940bba4 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
random: crng init done
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 16.
Memory: 2113936K/16671988K available (40969K kernel code, 13578K rwdata, 13208K rodata, 3096K init, 4528K bss, 3771644K reserved, 204800K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 46848 entries in 183 pages
ftrace: allocated 183 pages with 6 groups
rcu: Hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
calling  con_init+0x0/0x579 @ 0
Console: colour dummy device 80x25
printk: console [tty0] enabled
initcall con_init+0x0/0x579 returned 0 after 0 usecs
calling  hvc_console_init+0x0/0x14 @ 0
initcall hvc_console_init+0x0/0x14 returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x27 @ 0
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x27 returned 0 after 0 usecs
ACPI: Core revision 20220331
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
APIC: Switch to symmetric I/O mode setup
DMAR: Host address width 46
DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020de
DMAR: RMRR base: 0x0000007bb28000 end: 0x0000007bb36fff
DMAR: ATSR flags: 0x0
DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x0
DMAR-IR: IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 0
DMAR-IR: IOAPIC id 9 under DRHD base  0xfbffc000 IOMMU 0
DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
DMAR-IR: Enabled IRQ remapping in xapic mode
x2apic: IRQ remapping doesn't support X2APIC mode
Switched APIC routing to physical flat.
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 8 pin 0 not connected
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 8 pin 16 not connected
apic 8 pin 17 not connected
apic 8 pin 18 not connected
apic 8 pin 19 not connected
apic 8 pin 20 not connected
apic 8 pin 21 not connected
apic 8 pin 22 not connected
apic 8 pin 23 not connected
apic 9 pin 0 not connected
apic 9 pin 1 not connected
apic 9 pin 2 not connected
apic 9 pin 3 not connected
apic 9 pin 4 not connected
apic 9 pin 5 not connected
apic 9 pin 6 not connected
apic 9 pin 7 not connected
apic 9 pin 8 not connected
apic 9 pin 9 not connected
apic 9 pin 10 not connected
apic 9 pin 11 not connected
apic 9 pin 12 not connected
apic 9 pin 13 not connected
apic 9 pin 14 not connected
apic 9 pin 15 not connected
apic 9 pin 16 not connected
apic 9 pin 17 not connected
apic 9 pin 18 not connected
apic 9 pin 19 not connected
apic 9 pin 20 not connected
apic 9 pin 21 not connected
apic 9 pin 22 not connected
apic 9 pin 23 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e452ca2c89, max_idle_ns: 440795231168 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 4199.99 BogoMIPS (lpj=2099996)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
Spectre V2 : Vulnerable
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Enabling Restricted Speculation for firmware calls
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Spectre V2 : User space: Mitigation: STIBP via prctl
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
TAA: Mitigation: Clear CPU buffers
MMIO Stale Data: Mitigation: Clear CPU buffers
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (family: 0x6, model: 0x56, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 4 and lim to 1.
cblist_init_generic: Setting shift to 4 and lim to 1.
cblist_init_generic: Setting shift to 4 and lim to 1.
calling  init_hw_perf_events+0x0/0x676 @ 1
Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
initcall init_hw_perf_events+0x0/0x676 returned 0 after 8000 usecs
calling  init_real_mode+0x0/0xc1 @ 1
initcall init_real_mode+0x0/0xc1 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0x5a @ 1
Estimated ratio of average max frequency by base frequency (times 1024): 1267
initcall bp_init_aperfmperf+0x0/0x5a returned 0 after 1000 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xdd @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xdd returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x39 @ 1
initcall spawn_ksoftirqd+0x0/0x39 returned 0 after 0 usecs
calling  migration_init+0x0/0xd1 @ 1
initcall migration_init+0x0/0xd1 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x78 @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x78 returned 0 after 2000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x315 @ 1
initcall rcu_spawn_gp_kthread+0x0/0x315 returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x1b @ 1
initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x22 @ 1
initcall rcu_sysrq_init+0x0/0x22 returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0xf @ 1
initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0xf @ 1
initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x164 @ 1
initcall cpu_stop_init+0x0/0x164 returned 0 after 0 usecs
calling  init_kprobes+0x0/0x259 @ 1
initcall init_kprobes+0x0/0x259 returned 0 after 0 usecs
calling  init_events+0x0/0xc2 @ 1
initcall init_events+0x0/0xc2 returned 0 after 0 usecs
calling  init_trace_printk+0x0/0xc @ 1
initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x1f @ 1
initcall event_trace_enable_again+0x0/0x1f returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0x3 @ 1
initcall irq_work_init_threads+0x0/0x3 returned 0 after 0 usecs
calling  static_call_init+0x0/0x81 @ 1
initcall static_call_init+0x0/0x81 returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x11 @ 1
initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0xbb @ 1
initcall init_zero_pfn+0x0/0xbb returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x22 @ 1
initcall init_fs_inode_sysctls+0x0/0x22 returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x22 @ 1
initcall init_fs_locks_sysctls+0x0/0x22 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x3b9 @ 1
initcall dynamic_debug_init+0x0/0x3b9 returned 0 after 0 usecs
calling  efi_memreserve_root_init+0x0/0x26 @ 1
initcall efi_memreserve_root_init+0x0/0x26 returned 0 after 0 usecs
calling  efi_earlycon_remap_fb+0x0/0xe8 @ 1
initcall efi_earlycon_remap_fb+0x0/0xe8 returned 0 after 0 usecs
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:        #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
#4
masked ExtINT on CPU#4
#5
masked ExtINT on CPU#5
#6
masked ExtINT on CPU#6
#7
masked ExtINT on CPU#7
#8
masked ExtINT on CPU#8
MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
#9
masked ExtINT on CPU#9
#10
masked ExtINT on CPU#10
#11
masked ExtINT on CPU#11
#12
masked ExtINT on CPU#12
#13
masked ExtINT on CPU#13
#14
masked ExtINT on CPU#14
#15
masked ExtINT on CPU#15
smp: Brought up 1 node, 16 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 16 processors activated (67199.87 BogoMIPS)
node 0 deferred pages initialised in 30ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
calling  bpf_jit_charge_init+0x0/0x3c @ 1
initcall bpf_jit_charge_init+0x0/0x3c returned 0 after 0 usecs
calling  ipc_ns_init+0x0/0x11a @ 1
initcall ipc_ns_init+0x0/0x11a returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x16 @ 1
initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x41 @ 1
initcall pci_realloc_setup_params+0x0/0x41 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x42 @ 1
initcall inet_frag_wq_init+0x0/0x42 returned 0 after 0 usecs
calling  e820__register_nvs_regions+0x0/0x14c @ 1
ACPI: PM: Registering ACPI NVS region [mem 0x799ae000-0x79e5efff] (4919296 bytes)
initcall e820__register_nvs_regions+0x0/0x14c returned 0 after 3000 usecs
calling  cpufreq_register_tsc_scaling+0x0/0x76 @ 1
initcall cpufreq_register_tsc_scaling+0x0/0x76 returned 0 after 0 usecs
calling  reboot_init+0x0/0xa5 @ 1
initcall reboot_init+0x0/0xa5 returned 0 after 0 usecs
calling  init_lapic_sysfs+0x0/0x47 @ 1
initcall init_lapic_sysfs+0x0/0x47 returned 0 after 0 usecs
calling  alloc_frozen_cpus+0x0/0x21 @ 1
initcall alloc_frozen_cpus+0x0/0x21 returned 0 after 0 usecs
calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x2b @ 1
initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x99 @ 1
initcall ksysfs_init+0x0/0x99 returned 0 after 0 usecs
calling  schedutil_gov_init+0x0/0x11 @ 1
initcall schedutil_gov_init+0x0/0x11 returned 0 after 0 usecs
calling  pm_init+0x0/0xb0 @ 1
initcall pm_init+0x0/0xb0 returned 0 after 0 usecs
calling  pm_disk_init+0x0/0x3e @ 1
initcall pm_disk_init+0x0/0x3e returned 0 after 0 usecs
calling  swsusp_header_init+0x0/0x31 @ 1
initcall swsusp_header_init+0x0/0x31 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x4b @ 1
initcall rcu_set_runtime_mode+0x0/0x4b returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x18 @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 1000 usecs
calling  futex_init+0x0/0x206 @ 1
futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
initcall futex_init+0x0/0x206 returned 0 after 1000 usecs
calling  cgroup_wq_init+0x0/0x29 @ 1
initcall cgroup_wq_init+0x0/0x29 returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x29 @ 1
initcall cgroup1_wq_init+0x0/0x29 returned 0 after 0 usecs
calling  ftrace_mod_cmd_init+0x0/0xc @ 1
initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x2d @ 1
initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
calling  init_graph_trace+0x0/0x91 @ 1
initcall init_graph_trace+0x0/0x91 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x27 @ 1
initcall trace_events_eprobe_init_early+0x0/0x27 returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x27 @ 1
initcall trace_events_synth_init_early+0x0/0x27 returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0x26 @ 1
initcall init_kprobe_trace_early+0x0/0x26 returned 0 after 0 usecs
calling  kasan_memhotplug_init+0x0/0xf @ 1
initcall kasan_memhotplug_init+0x0/0xf returned 0 after 0 usecs
calling  memory_failure_init+0x0/0x253 @ 1
initcall memory_failure_init+0x0/0x253 returned 0 after 0 usecs
calling  cma_init_reserved_areas+0x0/0x42 @ 1
initcall cma_init_reserved_areas+0x0/0x42 returned 0 after 4000 usecs
calling  fsnotify_init+0x0/0x79 @ 1
initcall fsnotify_init+0x0/0x79 returned 0 after 0 usecs
calling  filelock_init+0x0/0x177 @ 1
initcall filelock_init+0x0/0x177 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x16 @ 1
initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x16 @ 1
initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x16 @ 1
initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  configfs_init+0x0/0xea @ 1
initcall configfs_init+0x0/0xea returned 0 after 0 usecs
calling  debugfs_init+0x0/0xb3 @ 1
initcall debugfs_init+0x0/0xb3 returned 0 after 0 usecs
calling  tracefs_init+0x0/0x63 @ 1
initcall tracefs_init+0x0/0x63 returned 0 after 0 usecs
calling  securityfs_init+0x0/0xba @ 1
initcall securityfs_init+0x0/0xba returned 0 after 0 usecs
calling  pinctrl_init+0x0/0xae @ 1
pinctrl core: initialized pinctrl subsystem
initcall pinctrl_init+0x0/0xae returned 0 after 1000 usecs
calling  gpiolib_dev_init+0x0/0x121 @ 1
initcall gpiolib_dev_init+0x0/0x121 returned 0 after 0 usecs
calling  virtio_init+0x0/0x20 @ 1
initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
calling  iommu_init+0x0/0x51 @ 1
initcall iommu_init+0x0/0x51 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x1d @ 1
initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
calling  cpufreq_core_init+0x0/0xca @ 1
initcall cpufreq_core_init+0x0/0xca returned 0 after 0 usecs
calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 0 usecs
calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 @ 1
initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 @ 1
initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x46 @ 1
initcall cpuidle_init+0x0/0x46 returned 0 after 0 usecs
calling  sock_init+0x0/0x9f @ 1
initcall sock_init+0x0/0x9f returned 0 after 0 usecs
calling  net_inuse_init+0x0/0x29 @ 1
initcall net_inuse_init+0x0/0x29 returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x29 @ 1
initcall net_defaults_init+0x0/0x29 returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x50 @ 1
initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
calling  netpoll_init+0x0/0x29 @ 1
initcall netpoll_init+0x0/0x29 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x2c8 @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x2c8 returned 0 after 1000 usecs
calling  genl_init+0x0/0x43 @ 1
initcall genl_init+0x0/0x43 returned 0 after 0 usecs
calling  bsp_pm_check_init+0x0/0x14 @ 1
initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xb8 @ 1
initcall irq_sysfs_init+0x0/0xb8 returned 0 after 0 usecs
calling  audit_init+0x0/0x1c9 @ 1
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1670559646.441:1): state=initialized audit_enabled=0 res=1
initcall audit_init+0x0/0x1c9 returned 0 after 1000 usecs
calling  release_early_probes+0x0/0x59 @ 1
initcall release_early_probes+0x0/0x59 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x6d @ 1
initcall bdi_class_init+0x0/0x6d returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x4f @ 1
initcall mm_sysfs_init+0x0/0x4f returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x26 @ 1
initcall init_per_zone_wmark_min+0x0/0x26 returned 0 after 0 usecs
calling  mpi_init+0x0/0xe6 @ 1
initcall mpi_init+0x0/0xe6 returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x119 @ 1
initcall gpiolib_sysfs_init+0x0/0x119 returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x116 @ 1
initcall acpi_gpio_setup_params+0x0/0x116 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x18 @ 1
initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x22 @ 1
initcall pci_driver_init+0x0/0x22 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0xee @ 1
initcall backlight_class_init+0x0/0xee returned 0 after 0 usecs
calling  tty_class_init+0x0/0x58 @ 1
initcall tty_class_init+0x0/0x58 returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0x1a0 @ 1
initcall vtconsole_class_init+0x0/0x1a0 returned 0 after 0 usecs
calling  iommu_dev_init+0x0/0x18 @ 1
initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x11 @ 1
initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x46 @ 1
initcall devlink_class_init+0x0/0x46 returned 0 after 0 usecs
calling  software_node_init+0x0/0x51 @ 1
initcall software_node_init+0x0/0x51 returned 0 after 0 usecs
calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  wakeup_sources_sysfs_init+0x0/0x2d @ 1
initcall wakeup_sources_sysfs_init+0x0/0x2d returned 0 after 0 usecs
calling  regmap_initcall+0x0/0xd @ 1
initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
calling  spi_init+0x0/0xc7 @ 1
initcall spi_init+0x0/0xc7 returned 0 after 0 usecs
calling  i2c_init+0x0/0xe8 @ 1
initcall i2c_init+0x0/0xe8 returned 0 after 0 usecs
calling  thermal_init+0x0/0x192 @ 1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x192 returned 0 after 3000 usecs
calling  init_menu+0x0/0x11 @ 1
cpuidle: using governor menu
initcall init_menu+0x0/0x11 returned 0 after 1000 usecs
calling  pcc_init+0x0/0xbd @ 1
initcall pcc_init+0x0/0xbd returned -19 after 0 usecs
calling  kobject_uevent_init+0x0/0xc @ 1
initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
calling  bts_init+0x0/0x130 @ 1
initcall bts_init+0x0/0x130 returned -19 after 0 usecs
calling  pt_init+0x0/0x2bd @ 1
initcall pt_init+0x0/0x2bd returned 0 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x92 @ 1
initcall boot_params_ksysfs_init+0x0/0x92 returned 0 after 0 usecs
calling  sbf_init+0x0/0xcf @ 1
initcall sbf_init+0x0/0xcf returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x4d5 @ 1
initcall arch_kdebugfs_init+0x0/0x4d5 returned 0 after 0 usecs
calling  xfd_update_static_branch+0x0/0x44 @ 1
initcall xfd_update_static_branch+0x0/0x44 returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0xa5 @ 1
initcall intel_pconfig_init+0x0/0xa5 returned 0 after 0 usecs
calling  mtrr_if_init+0x0/0xab @ 1
initcall mtrr_if_init+0x0/0xab returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  init_s4_sigcheck+0x0/0x8c @ 1
initcall init_s4_sigcheck+0x0/0x8c returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x62 @ 1
initcall ffh_cstate_init+0x0/0x62 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x1c6 @ 1
initcall kvm_alloc_cpumask+0x0/0x1c6 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x46 @ 1
initcall gigantic_pages_init+0x0/0x46 returned 0 after 0 usecs
calling  uv_rtc_setup_clock+0x0/0x276 @ 1
initcall uv_rtc_setup_clock+0x0/0x276 returned -19 after 0 usecs
calling  kcmp_cookies_init+0x0/0xa2 @ 1
initcall kcmp_cookies_init+0x0/0xa2 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x11 @ 1
initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x149 @ 1
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
initcall acpi_pci_init+0x0/0x149 returned 0 after 2000 usecs
calling  dma_channel_table_init+0x0/0x178 @ 1
initcall dma_channel_table_init+0x0/0x178 returned 0 after 0 usecs
calling  dma_bus_init+0x0/0x20b @ 1
initcall dma_bus_init+0x0/0x20b returned 0 after 0 usecs
calling  iommu_dma_init+0x0/0x50 @ 1
initcall iommu_dma_init+0x0/0x50 returned 0 after 0 usecs
calling  dmi_id_init+0x0/0x168 @ 1
initcall dmi_id_init+0x0/0x168 returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x118 @ 1
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x118 returned 0 after 12000 usecs
calling  init_vdso+0x0/0x14 @ 1
initcall init_vdso+0x0/0x14 returned 0 after 0 usecs
calling  sysenter_setup+0x0/0x14 @ 1
initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
calling  fixup_ht_bug+0x0/0x253 @ 1
initcall fixup_ht_bug+0x0/0x253 returned 0 after 0 usecs
calling  topology_init+0x0/0x9a @ 1
initcall topology_init+0x0/0x9a returned 0 after 2000 usecs
calling  intel_epb_init+0x0/0xd4 @ 1
initcall intel_epb_init+0x0/0xd4 returned 0 after 0 usecs
calling  mtrr_init_finialize+0x0/0x71 @ 1
initcall mtrr_init_finialize+0x0/0x71 returned 0 after 0 usecs
calling  uid_cache_init+0x0/0xff @ 1
initcall uid_cache_init+0x0/0xff returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0xcc @ 1
initcall param_sysfs_init+0x0/0xcc returned 0 after 17000 usecs
calling  user_namespace_sysctl_init+0x0/0x11b @ 1
initcall user_namespace_sysctl_init+0x0/0x11b returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x25 @ 1
initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x19 @ 1
initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
calling  create_proc_profile+0x0/0xe0 @ 1
initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x73e @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x73e returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x39 @ 1
initcall crash_notes_memory_init+0x0/0x39 returned 0 after 0 usecs
calling  cgroup_sysfs_init+0x0/0x3e @ 1
initcall cgroup_sysfs_init+0x0/0x3e returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0x8 @ 1
initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
calling  user_namespaces_init+0x0/0x2d @ 1
initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
calling  init_optprobes+0x0/0x15 @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x15 returned 0 after 1000 usecs
calling  hung_task_init+0x0/0x75 @ 1
initcall hung_task_init+0x0/0x75 returned 0 after 0 usecs
calling  ftrace_check_for_weak_functions+0x0/0x62 @ 1
initcall ftrace_check_for_weak_functions+0x0/0x62 returned 0 after 0 usecs
calling  trace_eval_init+0x0/0x85 @ 1
initcall trace_eval_init+0x0/0x85 returned 0 after 0 usecs
calling  send_signal_irq_work_init+0x0/0x150 @ 1
initcall send_signal_irq_work_init+0x0/0x150 returned 0 after 0 usecs
calling  dev_map_init+0x0/0x11f @ 1
initcall dev_map_init+0x0/0x11f returned 0 after 0 usecs
calling  cpu_map_init+0x0/0x113 @ 1
initcall cpu_map_init+0x0/0x113 returned 0 after 0 usecs
calling  netns_bpf_init+0x0/0x11 @ 1
initcall netns_bpf_init+0x0/0x11 returned 0 after 0 usecs
calling  btf_vmlinux_init+0x0/0x84 @ 1
initcall btf_vmlinux_init+0x0/0x84 returned 0 after 0 usecs
calling  oom_init+0x0/0x4a @ 1
initcall oom_init+0x0/0x4a returned 0 after 0 usecs
calling  default_bdi_init+0x0/0x29 @ 1
initcall default_bdi_init+0x0/0x29 returned 0 after 0 usecs
calling  cgwb_init+0x0/0x29 @ 1
initcall cgwb_init+0x0/0x29 returned 0 after 0 usecs
calling  percpu_enable_async+0x0/0xf @ 1
initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x98 @ 1
initcall kcompactd_init+0x0/0x98 returned 0 after 0 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x1f @ 1
initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
calling  swap_init_sysfs+0x0/0x8e @ 1
initcall swap_init_sysfs+0x0/0x8e returned 0 after 0 usecs
calling  swapfile_init+0x0/0x147 @ 1
initcall swapfile_init+0x0/0x147 returned 0 after 0 usecs
calling  hugetlb_init+0x0/0x40b @ 1
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
initcall hugetlb_init+0x0/0x40b returned 0 after 4000 usecs
calling  ksm_init+0x0/0x242 @ 1
initcall ksm_init+0x0/0x242 returned 0 after 0 usecs
calling  memory_tier_init+0x0/0x146 @ 1
initcall memory_tier_init+0x0/0x146 returned 0 after 0 usecs
calling  numa_init_sysfs+0x0/0x8e @ 1
initcall numa_init_sysfs+0x0/0x8e returned 0 after 0 usecs
calling  hugepage_init+0x0/0x1b0 @ 1
initcall hugepage_init+0x0/0x1b0 returned 0 after 0 usecs
calling  mem_cgroup_init+0x0/0x359 @ 1
initcall mem_cgroup_init+0x0/0x359 returned 0 after 0 usecs
calling  mem_cgroup_swap_init+0x0/0x5c @ 1
initcall mem_cgroup_swap_init+0x0/0x5c returned 0 after 0 usecs
calling  page_idle_init+0x0/0x59 @ 1
initcall page_idle_init+0x0/0x59 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x11 @ 1
initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
calling  rsa_init+0x0/0x3f @ 1
initcall rsa_init+0x0/0x3f returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x11 @ 1
initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x6d @ 1
initcall crypto_null_mod_init+0x0/0x6d returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x11 @ 1
initcall md5_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x11 @ 1
initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x16 @ 1
initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x16 @ 1
initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x11 @ 1
initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x11 @ 1
initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x11 @ 1
initcall crypto_cfb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x16 @ 1
initcall crypto_ctr_module_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x63 @ 1
initcall crypto_gcm_module_init+0x0/0x63 returned 0 after 0 usecs
calling  cryptd_init+0x0/0x1f7 @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x1f7 returned 0 after 1000 usecs
calling  aes_init+0x0/0x11 @ 1
initcall aes_init+0x0/0x11 returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x44 @ 1
initcall deflate_mod_init+0x0/0x44 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x11 @ 1
initcall crc32c_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x11 @ 1
initcall crct10dif_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0x3f @ 1
initcall lzo_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  lzorle_mod_init+0x0/0x3f @ 1
initcall lzorle_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  drbg_init+0x0/0xe4 @ 1
initcall drbg_init+0x0/0xe4 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x11 @ 1
initcall ghash_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  init_bio+0x0/0x111 @ 1
initcall init_bio+0x0/0x111 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x2a @ 1
initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x177 @ 1
initcall blk_mq_init+0x0/0x177 returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x88 @ 1
initcall genhd_device_init+0x0/0x88 returned 0 after 0 usecs
calling  blkcg_init+0x0/0x29 @ 1
initcall blkcg_init+0x0/0x29 returned 0 after 0 usecs
calling  io_wq_init+0x0/0x39 @ 1
initcall io_wq_init+0x0/0x39 returned 0 after 0 usecs
calling  sg_pool_init+0x0/0x1a5 @ 1
initcall sg_pool_init+0x0/0x1a5 returned 0 after 0 usecs
calling  irq_poll_setup+0x0/0x145 @ 1
initcall irq_poll_setup+0x0/0x145 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x24 @ 1
initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x24 @ 1
initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x18 @ 1
initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
calling  fbmem_init+0x0/0xe1 @ 1
initcall fbmem_init+0x0/0xe1 returned 0 after 0 usecs
calling  scan_for_dmi_ipmi+0x0/0x52 @ 1
initcall scan_for_dmi_ipmi+0x0/0x52 returned 0 after 0 usecs
calling  acpi_init+0x0/0x26d @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 4 ACPI AML tables successfully acquired and loaded
ACPI: Dynamic OEM Table Load:
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S4 S5)
ACPI: Using IOAPIC for interrupt routing
HEST: Table parsing has been initialized.
GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 6 GPEs in block 00 to 3F
ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A03:03: _OSC: platform does not support [SHPCHotplug LTR]
acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:ff
pci_bus 0000:ff: root bus resource [bus ff]
pci 0000:ff:0b.0: [8086:6f81] type 00 class 0x088000
pci 0000:ff:0b.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0b.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0b.1: [8086:6f36] type 00 class 0x110100
pci 0000:ff:0b.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0b.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0b.2: [8086:6f37] type 00 class 0x110100
pci 0000:ff:0b.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0b.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0b.3: [8086:6f76] type 00 class 0x088000
pci 0000:ff:0b.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0b.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.0: [8086:6fe0] type 00 class 0x088000
pci 0000:ff:0c.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.1: [8086:6fe1] type 00 class 0x088000
pci 0000:ff:0c.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.2: [8086:6fe2] type 00 class 0x088000
pci 0000:ff:0c.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.3: [8086:6fe3] type 00 class 0x088000
pci 0000:ff:0c.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.4: [8086:6fe4] type 00 class 0x088000
pci 0000:ff:0c.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.5: [8086:6fe5] type 00 class 0x088000
pci 0000:ff:0c.5: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.5: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.6: [8086:6fe6] type 00 class 0x088000
pci 0000:ff:0c.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0c.7: [8086:6fe7] type 00 class 0x088000
pci 0000:ff:0c.7: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0c.7: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0f.0: [8086:6ff8] type 00 class 0x088000
pci 0000:ff:0f.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0f.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0f.4: [8086:6ffc] type 00 class 0x088000
pci 0000:ff:0f.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0f.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0f.5: [8086:6ffd] type 00 class 0x088000
pci 0000:ff:0f.5: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0f.5: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:0f.6: [8086:6ffe] type 00 class 0x088000
pci 0000:ff:0f.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:0f.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:10.0: [8086:6f1d] type 00 class 0x088000
pci 0000:ff:10.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:10.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:10.1: [8086:6f34] type 00 class 0x110100
pci 0000:ff:10.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:10.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:10.5: [8086:6f1e] type 00 class 0x088000
pci 0000:ff:10.5: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:10.5: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:10.6: [8086:6f7d] type 00 class 0x110100
pci 0000:ff:10.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:10.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:10.7: [8086:6f1f] type 00 class 0x088000
pci 0000:ff:10.7: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:10.7: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:12.0: calling  pci_invalid_bar+0x0/0x80 @ 1
pci 0000:ff:12.0: pci_invalid_bar+0x0/0x80 took 0 usecs
pci 0000:ff:12.0: [8086:6fa0] type 00 class 0x088000
pci 0000:ff:12.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:12.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:12.1: [8086:6f30] type 00 class 0x110100
pci 0000:ff:12.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:12.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.0: [8086:6fa8] type 00 class 0x088000
pci 0000:ff:13.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.1: [8086:6f71] type 00 class 0x088000
pci 0000:ff:13.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.2: [8086:6faa] type 00 class 0x088000
pci 0000:ff:13.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.3: [8086:6fab] type 00 class 0x088000
pci 0000:ff:13.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.4: [8086:6fac] type 00 class 0x088000
pci 0000:ff:13.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.5: [8086:6fad] type 00 class 0x088000
pci 0000:ff:13.5: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.5: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.6: [8086:6fae] type 00 class 0x088000
pci 0000:ff:13.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:13.7: [8086:6faf] type 00 class 0x088000
pci 0000:ff:13.7: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:13.7: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.0: [8086:6fb0] type 00 class 0x088000
pci 0000:ff:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.1: [8086:6fb1] type 00 class 0x088000
pci 0000:ff:14.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.2: [8086:6fb2] type 00 class 0x088000
pci 0000:ff:14.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.3: [8086:6fb3] type 00 class 0x088000
pci 0000:ff:14.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.4: [8086:6fbc] type 00 class 0x088000
pci 0000:ff:14.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.5: [8086:6fbd] type 00 class 0x088000
pci 0000:ff:14.5: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.5: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.6: [8086:6fbe] type 00 class 0x088000
pci 0000:ff:14.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:14.7: [8086:6fbf] type 00 class 0x088000
pci 0000:ff:14.7: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:14.7: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:15.0: [8086:6fb4] type 00 class 0x088000
pci 0000:ff:15.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:15.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:15.1: [8086:6fb5] type 00 class 0x088000
pci 0000:ff:15.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:15.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:15.2: [8086:6fb6] type 00 class 0x088000
pci 0000:ff:15.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:15.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:15.3: [8086:6fb7] type 00 class 0x088000
pci 0000:ff:15.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:15.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1e.0: [8086:6f98] type 00 class 0x088000
pci 0000:ff:1e.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1e.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1e.1: [8086:6f99] type 00 class 0x088000
pci 0000:ff:1e.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1e.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1e.2: [8086:6f9a] type 00 class 0x088000
pci 0000:ff:1e.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1e.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1e.3: calling  quirk_intel_brickland_xeon_ras_cap+0x0/0xa0 @ 1
pci 0000:ff:1e.3: quirk_intel_brickland_xeon_ras_cap+0x0/0xa0 took 0 usecs
pci 0000:ff:1e.3: calling  pci_invalid_bar+0x0/0x80 @ 1
pci 0000:ff:1e.3: pci_invalid_bar+0x0/0x80 took 0 usecs
pci 0000:ff:1e.3: [8086:6fc0] type 00 class 0x088000
pci 0000:ff:1e.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1e.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1e.4: [8086:6f9c] type 00 class 0x088000
pci 0000:ff:1e.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1e.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1f.0: [8086:6f88] type 00 class 0x088000
pci 0000:ff:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1f.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:ff:1f.2: [8086:6f8a] type 00 class 0x088000
pci 0000:ff:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:ff:1f.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug PME AER LTR]
acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PCIeCapability]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbffbfff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
pci 0000:00:00.0: [8086:6f00] type 00 class 0x060000
pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:01.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:01.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:01.0: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:01.0: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:01.0: [8086:6f02] type 01 class 0x060400
pci 0000:00:01.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:01.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:01.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:01.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:02.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:02.0: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:02.0: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:02.0: [8086:6f04] type 01 class 0x060400
pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:02.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:02.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.2: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:02.2: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:02.2: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:02.2: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:02.2: [8086:6f06] type 01 class 0x060400
pci 0000:00:02.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:02.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:02.2: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:02.2: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:03.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:03.0: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:03.0: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:03.0: [8086:6f08] type 01 class 0x060400
pci 0000:00:03.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:03.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:03.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:03.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:05.0: [8086:6f28] type 00 class 0x088000
pci 0000:00:05.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:05.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:05.1: [8086:6f29] type 00 class 0x088000
pci 0000:00:05.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:05.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:05.2: [8086:6f2a] type 00 class 0x088000
pci 0000:00:05.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:05.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:05.4: [8086:6f2c] type 00 class 0x080020
pci 0000:00:05.4: reg 0x10: [mem 0xfb418000-0xfb418fff]
pci 0000:00:05.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:05.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xfb400000-0xfb40ffff 64bit]
pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xfb417000-0xfb41700f 64bit]
pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:16.1: [8086:8c3b] type 00 class 0x078000
pci 0000:00:16.1: reg 0x10: [mem 0xfb416000-0xfb41600f 64bit]
pci 0000:00:16.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:16.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
pci 0000:00:1a.0: reg 0x10: [mem 0xfb414000-0xfb4143ff]
pci 0000:00:1a.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1a.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:1c.0: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
pci 0000:00:1c.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1c.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:1c.0: calling  quirk_apple_mbp_poweroff+0x0/0x120 @ 1
pci 0000:00:1c.0: quirk_apple_mbp_poweroff+0x0/0x120 took 0 usecs
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:1c.4: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:1c.4: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:1c.4: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:1c.4: [8086:8c18] type 01 class 0x060400
pci 0000:00:1c.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1c.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1c.4: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:1c.4: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
pci 0000:00:1d.0: reg 0x10: [mem 0xfb413000-0xfb4133ff]
pci 0000:00:1d.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1d.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:8c54] type 00 class 0x060100
pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
pci 0000:00:1f.2: reg 0x10: [io  0xf070-0xf077]
pci 0000:00:1f.2: reg 0x14: [io  0xf060-0xf063]
pci 0000:00:1f.2: reg 0x18: [io  0xf050-0xf057]
pci 0000:00:1f.2: reg 0x1c: [io  0xf040-0xf043]
pci 0000:00:1f.2: reg 0x20: [io  0xf020-0xf03f]
pci 0000:00:1f.2: reg 0x24: [mem 0xfb412000-0xfb4127ff]
pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 0x10: [mem 0xfb411000-0xfb4110ff 64bit]
pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.6: [8086:8c24] type 00 class 0x118000
pci 0000:00:1f.6: reg 0x10: [mem 0xfb410000-0xfb410fff 64bit]
pci 0000:00:1f.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
acpiphp: Slot [1] registered
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: [8086:6f50] type 00 class 0x088000
pci 0000:02:00.0: reg 0x10: [mem 0xfb306000-0xfb307fff 64bit]
pci 0000:02:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:02:00.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:02:00.1: [8086:6f51] type 00 class 0x088000
pci 0000:02:00.1: reg 0x10: [mem 0xfb304000-0xfb305fff 64bit]
pci 0000:02:00.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:02:00.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:02:00.2: [8086:6f52] type 00 class 0x088000
pci 0000:02:00.2: reg 0x10: [mem 0xfb302000-0xfb303fff 64bit]
pci 0000:02:00.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:02:00.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:02:00.3: [8086:6f53] type 00 class 0x088000
pci 0000:02:00.3: reg 0x10: [mem 0xfb300000-0xfb301fff 64bit]
pci 0000:02:00.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:02:00.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:02.0:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:03:00.0: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:03:00.0: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:03:00.0: [8086:15ad] type 00 class 0x020000
pci 0000:03:00.0: reg 0x10: [mem 0xfbc00000-0xfbdfffff 64bit pref]
pci 0000:03:00.0: reg 0x20: [mem 0xfbe04000-0xfbe07fff 64bit pref]
pci 0000:03:00.0: reg 0x30: [mem 0xfb280000-0xfb2fffff pref]
pci 0000:03:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:03:00.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:03:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
pci 0000:03:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
pci 0000:03:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
pci 0000:03:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
pci 0000:03:00.1: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:03:00.1: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:03:00.1: [8086:15ad] type 00 class 0x020000
pci 0000:03:00.1: reg 0x10: [mem 0xfba00000-0xfbbfffff 64bit pref]
pci 0000:03:00.1: reg 0x20: [mem 0xfbe00000-0xfbe03fff 64bit pref]
pci 0000:03:00.1: reg 0x30: [mem 0xfb200000-0xfb27ffff pref]
pci 0000:03:00.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:03:00.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:03:00.1: PME# supported from D0 D3hot D3cold
pci 0000:03:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
pci 0000:03:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
pci 0000:03:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
pci 0000:03:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
pci 0000:00:02.2: PCI bridge to [bus 03]
pci 0000:00:02.2:   bridge window [mem 0xfb200000-0xfb2fffff]
pci 0000:00:02.2:   bridge window [mem 0xfba00000-0xfbefffff 64bit pref]
pci 0000:00:03.0: PCI bridge to [bus 04]
pci 0000:05:00.0: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:05:00.0: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:05:00.0: [8086:1521] type 00 class 0x020000
pci 0000:05:00.0: reg 0x10: [mem 0xfb120000-0xfb13ffff]
pci 0000:05:00.0: reg 0x18: [io  0xe020-0xe03f]
pci 0000:05:00.0: reg 0x1c: [mem 0xfb144000-0xfb147fff]
pci 0000:05:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:05:00.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
pci 0000:05:00.0: reg 0x184: [mem 0x90000000-0x90003fff 64bit pref]
pci 0000:05:00.0: VF(n) BAR0 space: [mem 0x90000000-0x9001ffff 64bit pref] (contains BAR0 for 8 VFs)
pci 0000:05:00.0: reg 0x190: [mem 0x90020000-0x90023fff 64bit pref]
pci 0000:05:00.0: VF(n) BAR3 space: [mem 0x90020000-0x9003ffff 64bit pref] (contains BAR3 for 8 VFs)
pci 0000:05:00.1: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:05:00.1: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:05:00.1: [8086:1521] type 00 class 0x020000
pci 0000:05:00.1: reg 0x10: [mem 0xfb100000-0xfb11ffff]
pci 0000:05:00.1: reg 0x18: [io  0xe000-0xe01f]
pci 0000:05:00.1: reg 0x1c: [mem 0xfb140000-0xfb143fff]
pci 0000:05:00.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:05:00.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:05:00.1: PME# supported from D0 D3hot D3cold
pci 0000:05:00.1: reg 0x184: [mem 0x90040000-0x90043fff 64bit pref]
pci 0000:05:00.1: VF(n) BAR0 space: [mem 0x90040000-0x9005ffff 64bit pref] (contains BAR0 for 8 VFs)
pci 0000:05:00.1: reg 0x190: [mem 0x90060000-0x90063fff 64bit pref]
pci 0000:05:00.1: VF(n) BAR3 space: [mem 0x90060000-0x9007ffff 64bit pref] (contains BAR3 for 8 VFs)
pci 0000:00:1c.0: PCI bridge to [bus 05]
pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.0:   bridge window [mem 0xfb100000-0xfb1fffff]
pci 0000:00:1c.0:   bridge window [mem 0x90000000-0x900fffff 64bit pref]
pci 0000:00:1c.0: bridge has subordinate 05 but max busn 06
pci 0000:06:00.0: [1a03:1150] type 01 class 0x060400
pci 0000:06:00.0: supports D1 D2
pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:1c.4: PCI bridge to [bus 06-07]
pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.4:   bridge window [mem 0xfa000000-0xfb0fffff]
pci_bus 0000:07: extended config space not accessible
pci 0000:07:00.0: [1a03:2000] type 00 class 0x030000
pci 0000:07:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
pci 0000:07:00.0: reg 0x14: [mem 0xfb000000-0xfb01ffff]
pci 0000:07:00.0: reg 0x18: [io  0xd000-0xd07f]
pci 0000:07:00.0: calling  efifb_fixup_resources+0x0/0x490 @ 1
pci 0000:07:00.0: efifb_fixup_resources+0x0/0x490 took 0 usecs
pci 0000:07:00.0: calling  pci_fixup_video+0x0/0x200 @ 1
pci 0000:07:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:07:00.0: pci_fixup_video+0x0/0x200 took 976 usecs
pci 0000:07:00.0: supports D1 D2
pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:06:00.0: PCI bridge to [bus 07]
pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
pci 0000:06:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
ACPI: PCI: Interrupt link LNKA configured for IRQ 11
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 5
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 0
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 0
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 0
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 0
ACPI: PCI: Interrupt link LNKH disabled
initcall acpi_init+0x0/0x26d returned 0 after 3210000 usecs
calling  adxl_init+0x0/0x24c @ 1
initcall adxl_init+0x0/0x24c returned -19 after 0 usecs
calling  pnp_init+0x0/0x11 @ 1
initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
calling  misc_init+0x0/0xe4 @ 1
initcall misc_init+0x0/0xe4 returned 0 after 0 usecs
calling  tpm_init+0x0/0x218 @ 1
initcall tpm_init+0x0/0x218 returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x1a5 @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x1a5 returned 0 after 2000 usecs
calling  cn_init+0x0/0x180 @ 1
initcall cn_init+0x0/0x180 returned 0 after 0 usecs
calling  dax_core_init+0x0/0xe3 @ 1
initcall dax_core_init+0x0/0xe3 returned 0 after 0 usecs
calling  dma_buf_init+0x0/0xc7 @ 1
initcall dma_buf_init+0x0/0xc7 returned 0 after 0 usecs
calling  init_scsi+0x0/0x88 @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x88 returned 0 after 1000 usecs
calling  phy_init+0x0/0x65 @ 1
initcall phy_init+0x0/0x65 returned 0 after 0 usecs
calling  usb_common_init+0x0/0x1d @ 1
initcall usb_common_init+0x0/0x1d returned 0 after 0 usecs
calling  usb_init+0x0/0x150 @ 1
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x150 returned 0 after 4000 usecs
calling  xdbc_init+0x0/0x151 @ 1
initcall xdbc_init+0x0/0x151 returned 0 after 0 usecs
calling  typec_init+0x0/0xae @ 1
initcall typec_init+0x0/0xae returned 0 after 0 usecs
calling  serio_init+0x0/0x2e @ 1
initcall serio_init+0x0/0x2e returned 0 after 0 usecs
calling  input_init+0x0/0x104 @ 1
initcall input_init+0x0/0x104 returned 0 after 0 usecs
calling  rtc_init+0x0/0x71 @ 1
initcall rtc_init+0x0/0x71 returned 0 after 0 usecs
calling  pps_init+0x0/0xd6 @ 1
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
initcall pps_init+0x0/0xd6 returned 0 after 2000 usecs
calling  ptp_init+0x0/0xc0 @ 1
PTP clock support registered
initcall ptp_init+0x0/0xc0 returned 0 after 1000 usecs
calling  power_supply_class_init+0x0/0x64 @ 1
initcall power_supply_class_init+0x0/0x64 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x178 @ 1
initcall hwmon_init+0x0/0x178 returned 0 after 0 usecs
calling  md_init+0x0/0x15c @ 1
initcall md_init+0x0/0x15c returned 0 after 0 usecs
calling  edac_init+0x0/0x76 @ 1
EDAC MC: Ver: 3.0.0
initcall edac_init+0x0/0x76 returned 0 after 1000 usecs
calling  leds_init+0x0/0x7f @ 1
initcall leds_init+0x0/0x7f returned 0 after 0 usecs
calling  dmi_init+0x0/0x142 @ 1
initcall dmi_init+0x0/0x142 returned 0 after 0 usecs
calling  efisubsys_init+0x0/0x272 @ 1
initcall efisubsys_init+0x0/0x272 returned 0 after 0 usecs
calling  ras_init+0x0/0xf @ 1
initcall ras_init+0x0/0xf returned 0 after 0 usecs
calling  nvmem_init+0x0/0x11 @ 1
initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
calling  proto_init+0x0/0x11 @ 1
initcall proto_init+0x0/0x11 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x77d @ 1
initcall net_dev_init+0x0/0x77d returned 0 after 0 usecs
calling  neigh_init+0x0/0x85 @ 1
initcall neigh_init+0x0/0x85 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x11 @ 1
initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
calling  fib_rules_init+0x0/0xb2 @ 1
initcall fib_rules_init+0x0/0xb2 returned 0 after 0 usecs
calling  init_cgroup_netprio+0x0/0x14 @ 1
initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
calling  bpf_lwt_init+0x0/0x16 @ 1
initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
calling  pktsched_init+0x0/0x113 @ 1
initcall pktsched_init+0x0/0x113 returned 0 after 0 usecs
calling  tc_filter_init+0x0/0x100 @ 1
initcall tc_filter_init+0x0/0x100 returned 0 after 0 usecs
calling  tc_action_init+0x0/0x55 @ 1
initcall tc_action_init+0x0/0x55 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x58 @ 1
initcall ethnl_init+0x0/0x58 returned 0 after 0 usecs
calling  nexthop_init+0x0/0xf6 @ 1
initcall nexthop_init+0x0/0xf6 returned 0 after 0 usecs
calling  cipso_v4_init+0x0/0x114 @ 1
initcall cipso_v4_init+0x0/0x114 returned 0 after 0 usecs
calling  wireless_nlevent_init+0x0/0x3f @ 1
initcall wireless_nlevent_init+0x0/0x3f returned 0 after 0 usecs
calling  netlbl_init+0x0/0x88 @ 1
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
initcall netlbl_init+0x0/0x88 returned 0 after 4000 usecs
calling  pci_subsys_init+0x0/0x11e @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009ac00-0x0009ffff]
e820: reserve RAM buffer [mem 0x796e1000-0x7bffffff]
e820: reserve RAM buffer [mem 0x799ae000-0x7bffffff]
e820: reserve RAM buffer [mem 0x7bdb6000-0x7bffffff]
initcall pci_subsys_init+0x0/0x11e returned 0 after 11000 usecs
calling  vsprintf_init_hashval+0x0/0xa @ 1
initcall vsprintf_init_hashval+0x0/0xa returned 0 after 0 usecs
calling  vga_arb_device_init+0x0/0x77 @ 1
pci 0000:07:00.0: vgaarb: setting as boot VGA device
pci 0000:07:00.0: vgaarb: bridge control possible
pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
initcall vga_arb_device_init+0x0/0x77 returned 0 after 2000 usecs
calling  watchdog_init+0x0/0x137 @ 1
initcall watchdog_init+0x0/0x137 returned 0 after 0 usecs
calling  nmi_warning_debugfs+0x0/0x4d @ 1
initcall nmi_warning_debugfs+0x0/0x4d returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0xc3 @ 1
initcall save_microcode_in_initrd+0x0/0xc3 returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x16f @ 1
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
initcall hpet_late_init+0x0/0x16f returned 0 after 4000 usecs
calling  iomem_init_inode+0x0/0xa7 @ 1
initcall iomem_init_inode+0x0/0xa7 returned 0 after 0 usecs
calling  clocksource_done_booting+0x0/0x42 @ 1
clocksource: Switched to clocksource tsc-early
initcall clocksource_done_booting+0x0/0x42 returned 0 after 6205 usecs
calling  tracer_init_tracefs+0x0/0x151 @ 1
initcall tracer_init_tracefs+0x0/0x151 returned 0 after 16 usecs
calling  init_trace_printk_function_export+0x0/0x28 @ 1
initcall init_trace_printk_function_export+0x0/0x28 returned 0 after 19 usecs
calling  init_graph_tracefs+0x0/0x28 @ 1
initcall init_graph_tracefs+0x0/0x28 returned 0 after 14 usecs
calling  trace_events_synth_init+0x0/0x47 @ 1
initcall trace_events_synth_init+0x0/0x47 returned 0 after 14 usecs
calling  bpf_event_init+0x0/0xf @ 1
initcall bpf_event_init+0x0/0xf returned 0 after 1 usecs
calling  init_kprobe_trace+0x0/0x30c @ 1
initcall init_kprobe_trace+0x0/0x30c returned 0 after 46067 usecs
calling  init_dynamic_event+0x0/0x28 @ 1
initcall init_dynamic_event+0x0/0x28 returned 0 after 35 usecs
calling  init_uprobe_trace+0x0/0x5c @ 1
initcall init_uprobe_trace+0x0/0x5c returned 0 after 16 usecs
calling  bpf_init+0x0/0x99 @ 1
initcall bpf_init+0x0/0x99 returned 0 after 10 usecs
calling  btf_module_init+0x0/0x14 @ 1
initcall btf_module_init+0x0/0x14 returned 0 after 0 usecs
calling  secretmem_init+0x0/0x5c @ 1
initcall secretmem_init+0x0/0x5c returned 0 after 0 usecs
calling  init_fs_stat_sysctls+0x0/0x2e @ 1
initcall init_fs_stat_sysctls+0x0/0x2e returned 0 after 25 usecs
calling  init_fs_exec_sysctls+0x0/0x22 @ 1
initcall init_fs_exec_sysctls+0x0/0x22 returned 0 after 6 usecs
calling  init_pipe_fs+0x0/0x64 @ 1
initcall init_pipe_fs+0x0/0x64 returned 0 after 81 usecs
calling  init_fs_namei_sysctls+0x0/0x22 @ 1
initcall init_fs_namei_sysctls+0x0/0x22 returned 0 after 8 usecs
calling  init_fs_dcache_sysctls+0x0/0x22 @ 1
initcall init_fs_dcache_sysctls+0x0/0x22 returned 0 after 4 usecs
calling  init_fs_namespace_sysctls+0x0/0x22 @ 1
initcall init_fs_namespace_sysctls+0x0/0x22 returned 0 after 4 usecs
calling  cgroup_writeback_init+0x0/0x26 @ 1
initcall cgroup_writeback_init+0x0/0x26 returned 0 after 13 usecs
calling  inotify_user_setup+0x0/0x18a @ 1
initcall inotify_user_setup+0x0/0x18a returned 0 after 38 usecs
calling  eventpoll_init+0x0/0x141 @ 1
initcall eventpoll_init+0x0/0x141 returned 0 after 43 usecs
calling  anon_inode_init+0x0/0x8a @ 1
initcall anon_inode_init+0x0/0x8a returned 0 after 56 usecs
calling  init_dax_wait_table+0x0/0x34 @ 1
initcall init_dax_wait_table+0x0/0x34 returned 0 after 24 usecs
calling  proc_locks_init+0x0/0x28 @ 1
initcall proc_locks_init+0x0/0x28 returned 0 after 12 usecs
calling  init_fs_coredump_sysctls+0x0/0x22 @ 1
initcall init_fs_coredump_sysctls+0x0/0x22 returned 0 after 7 usecs
calling  iomap_init+0x0/0x20 @ 1
initcall iomap_init+0x0/0x20 returned 0 after 168 usecs
calling  dquot_init+0x0/0x163 @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x163 returned 0 after 12236 usecs
calling  quota_init+0x0/0x24 @ 1
initcall quota_init+0x0/0x24 returned 0 after 47 usecs
calling  proc_cmdline_init+0x0/0x22 @ 1
initcall proc_cmdline_init+0x0/0x22 returned 0 after 5 usecs
calling  proc_consoles_init+0x0/0x25 @ 1
initcall proc_consoles_init+0x0/0x25 returned 0 after 3 usecs
calling  proc_cpuinfo_init+0x0/0x1f @ 1
initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 3 usecs
calling  proc_devices_init+0x0/0x5e @ 1
initcall proc_devices_init+0x0/0x5e returned 0 after 3 usecs
calling  proc_interrupts_init+0x0/0x25 @ 1
initcall proc_interrupts_init+0x0/0x25 returned 0 after 3 usecs
calling  proc_loadavg_init+0x0/0x5b @ 1
initcall proc_loadavg_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_meminfo_init+0x0/0x5b @ 1
initcall proc_meminfo_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_stat_init+0x0/0x1f @ 1
initcall proc_stat_init+0x0/0x1f returned 0 after 3 usecs
calling  proc_uptime_init+0x0/0x5b @ 1
initcall proc_uptime_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_version_init+0x0/0x5b @ 1
initcall proc_version_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_softirqs_init+0x0/0x5b @ 1
initcall proc_softirqs_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_kcore_init+0x0/0x142 @ 1
initcall proc_kcore_init+0x0/0x142 returned 0 after 38 usecs
calling  vmcore_init+0x0/0x2b9 @ 1
initcall vmcore_init+0x0/0x2b9 returned 0 after 0 usecs
calling  proc_kmsg_init+0x0/0x22 @ 1
initcall proc_kmsg_init+0x0/0x22 returned 0 after 3 usecs
calling  proc_page_init+0x0/0x56 @ 1
initcall proc_page_init+0x0/0x56 returned 0 after 9 usecs
calling  init_ramfs_fs+0x0/0x11 @ 1
initcall init_ramfs_fs+0x0/0x11 returned 0 after 0 usecs
calling  init_hugetlbfs_fs+0x0/0x2a0 @ 1
initcall init_hugetlbfs_fs+0x0/0x2a0 returned 0 after 103 usecs
calling  dynamic_debug_init_control+0x0/0x7c @ 1
initcall dynamic_debug_init_control+0x0/0x7c returned 0 after 25 usecs
calling  acpi_event_init+0x0/0x61 @ 1
initcall acpi_event_init+0x0/0x61 returned 0 after 42 usecs
calling  pnp_system_init+0x0/0x11 @ 1
initcall pnp_system_init+0x0/0x11 returned 0 after 39 usecs
calling  pnpacpi_init+0x0/0xd2 @ 1
pnp: PnP ACPI init
system 00:01: [io  0x0500-0x057f] has been reserved
system 00:01: [io  0x0400-0x047f] has been reserved
system 00:01: [io  0x0580-0x059f] has been reserved
system 00:01: [io  0x0600-0x061f] has been reserved
system 00:01: [io  0x0880-0x0883] has been reserved
system 00:01: [io  0x0800-0x081f] has been reserved
system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
system 00:01: [mem 0xff000000-0xffffffff] has been reserved
system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
system 00:02: [io  0x0a00-0x0a0f] has been reserved
system 00:02: [io  0x0a10-0x0a1f] has been reserved
system 00:02: [io  0x0a20-0x0a2f] has been reserved
system 00:02: [io  0x0a30-0x0a3f] has been reserved
system 00:02: [io  0x0a40-0x0a4f] has been reserved
pnp 00:03: [dma 0 disabled]
pnp 00:04: [dma 0 disabled]
pnp: PnP ACPI: found 5 devices
initcall pnpacpi_init+0x0/0xd2 returned 0 after 167228 usecs
calling  chr_dev_init+0x0/0x131 @ 1
initcall chr_dev_init+0x0/0x131 returned 0 after 8029 usecs
calling  hwrng_modinit+0x0/0xe6 @ 1
initcall hwrng_modinit+0x0/0xe6 returned 0 after 147 usecs
calling  firmware_class_init+0x0/0xfa @ 1
initcall firmware_class_init+0x0/0xfa returned 0 after 67 usecs
calling  init_acpi_pm_clocksource+0x0/0xd2 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xd2 returned 0 after 14077 usecs
calling  powercap_init+0x0/0x22 @ 1
initcall powercap_init+0x0/0x22 returned 0 after 220 usecs
calling  sysctl_core_init+0x0/0x2b @ 1
initcall sysctl_core_init+0x0/0x2b returned 0 after 34 usecs
calling  eth_offload_init+0x0/0x14 @ 1
initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
calling  ipv4_offload_init+0x0/0x74 @ 1
initcall ipv4_offload_init+0x0/0x74 returned 0 after 0 usecs
calling  inet_init+0x0/0x341 @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
initcall inet_init+0x0/0x341 returned 0 after 78938 usecs
calling  af_unix_init+0x0/0x1a3 @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x1a3 returned 0 after 6421 usecs
calling  ipv6_offload_init+0x0/0x7f @ 1
initcall ipv6_offload_init+0x0/0x7f returned 0 after 0 usecs
calling  init_sunrpc+0x0/0x88 @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x88 returned 0 after 25090 usecs
calling  vlan_offload_init+0x0/0x20 @ 1
initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
calling  xsk_init+0x0/0x1b8 @ 1
NET: Registered PF_XDP protocol family
initcall xsk_init+0x0/0x1b8 returned 0 after 5497 usecs
calling  pcibios_assign_resources+0x0/0x236 @ 1
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:02.0:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:03:00.0: BAR 7: no space for [mem size 0x00100000 64bit]
pci 0000:03:00.0: BAR 7: failed to assign [mem size 0x00100000 64bit]
pci 0000:03:00.0: BAR 10: no space for [mem size 0x00100000 64bit]
pci 0000:03:00.0: BAR 10: failed to assign [mem size 0x00100000 64bit]
pci 0000:03:00.1: BAR 7: no space for [mem size 0x00100000 64bit]
pci 0000:03:00.1: BAR 7: failed to assign [mem size 0x00100000 64bit]
pci 0000:03:00.1: BAR 10: no space for [mem size 0x00100000 64bit]
pci 0000:03:00.1: BAR 10: failed to assign [mem size 0x00100000 64bit]
pci 0000:00:02.2: PCI bridge to [bus 03]
pci 0000:00:02.2:   bridge window [mem 0xfb200000-0xfb2fffff]
pci 0000:00:02.2:   bridge window [mem 0xfba00000-0xfbefffff 64bit pref]
pci 0000:00:03.0: PCI bridge to [bus 04]
pci 0000:00:1c.0: PCI bridge to [bus 05]
pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.0:   bridge window [mem 0xfb100000-0xfb1fffff]
pci 0000:00:1c.0:   bridge window [mem 0x90000000-0x900fffff 64bit pref]
pci 0000:06:00.0: PCI bridge to [bus 07]
pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
pci 0000:06:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
pci 0000:00:1c.4: PCI bridge to [bus 06-07]
pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.4:   bridge window [mem 0xfa000000-0xfb0fffff]
pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x90000000-0xfbffbfff window]
pci_bus 0000:02: resource 1 [mem 0xfb300000-0xfb3fffff]
pci_bus 0000:03: resource 1 [mem 0xfb200000-0xfb2fffff]
pci_bus 0000:03: resource 2 [mem 0xfba00000-0xfbefffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
pci_bus 0000:05: resource 1 [mem 0xfb100000-0xfb1fffff]
pci_bus 0000:05: resource 2 [mem 0x90000000-0x900fffff 64bit pref]
pci_bus 0000:06: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:06: resource 1 [mem 0xfa000000-0xfb0fffff]
pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:07: resource 1 [mem 0xfa000000-0xfb0fffff]
initcall pcibios_assign_resources+0x0/0x236 returned 0 after 288376 usecs
calling  pci_apply_final_quirks+0x0/0x32c @ 1
pci 0000:00:05.0: calling  quirk_disable_intel_boot_interrupt+0x0/0x1f0 @ 1
pci 0000:00:05.0: disabled boot interrupts on device [8086:6f28]
pci 0000:00:05.0: quirk_disable_intel_boot_interrupt+0x0/0x1f0 took 7557 usecs
pci 0000:00:14.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:14.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-19 -> IRQ 19 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2d0 took 25217 usecs
pci 0000:00:16.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:16.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:00:1a.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:1a.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-18 -> IRQ 18 Level:1 ActiveLow:1)
pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x2d0 took 25238 usecs
pci 0000:00:1c.4: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:1c.4: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:00:1d.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:1d.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:00:1d.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-18 -> IRQ 18 Level:1 ActiveLow:1)
pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x2d0 took 25280 usecs
pci 0000:00:1f.2: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:1f.2: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:00:1f.3: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
pci 0000:00:1f.3: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
pci 0000:03:00.0: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:03:00.0: quirk_e100_interrupt+0x0/0x290 took 0 usecs
pci 0000:03:00.0: CLS mismatch (64 != 32), using 64 bytes
pci 0000:03:00.1: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:03:00.1: quirk_e100_interrupt+0x0/0x290 took 0 usecs
pci 0000:05:00.0: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:05:00.0: quirk_e100_interrupt+0x0/0x290 took 0 usecs
pci 0000:05:00.1: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:05:00.1: quirk_e100_interrupt+0x0/0x290 took 0 usecs
initcall pci_apply_final_quirks+0x0/0x32c returned 0 after 326188 usecs
calling  acpi_reserve_resources+0x0/0x273 @ 1
initcall acpi_reserve_resources+0x0/0x273 returned 0 after 18 usecs
calling  populate_rootfs+0x0/0x3c @ 1
initcall populate_rootfs+0x0/0x3c returned 0 after 9 usecs
Trying to unpack rootfs image as initramfs...
calling  pci_iommu_init+0x0/0x55 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000756e1000-0x00000000796e1000] (64MB)
initcall pci_iommu_init+0x0/0x55 returned 0 after 27181 usecs
calling  ir_dev_scope_init+0x0/0x6d @ 1
initcall ir_dev_scope_init+0x0/0x6d returned 0 after 10 usecs
calling  ia32_binfmt_init+0x0/0x14 @ 1
initcall ia32_binfmt_init+0x0/0x14 returned 0 after 25 usecs
calling  amd_ibs_init+0x0/0xf6 @ 1
initcall amd_ibs_init+0x0/0xf6 returned -19 after 0 usecs
calling  msr_init+0x0/0x7c @ 1
initcall msr_init+0x0/0x7c returned 0 after 7 usecs
calling  register_kernel_offset_dumper+0x0/0x1b @ 1
initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
calling  i8259A_init_ops+0x0/0x21 @ 1
initcall i8259A_init_ops+0x0/0x21 returned 0 after 0 usecs
calling  init_tsc_clocksource+0x0/0xe2 @ 1
initcall init_tsc_clocksource+0x0/0xe2 returned 0 after 3 usecs
calling  add_rtc_cmos+0x0/0x1f0 @ 1
initcall add_rtc_cmos+0x0/0x1f0 returned 0 after 1 usecs
calling  i8237A_init_ops+0x0/0x37 @ 1
initcall i8237A_init_ops+0x0/0x37 returned 0 after 11 usecs
calling  umwait_init+0x0/0xdd @ 1
initcall umwait_init+0x0/0xdd returned -19 after 0 usecs
calling  cpuid_init+0x0/0xfd @ 1
initcall cpuid_init+0x0/0xfd returned 0 after 2814 usecs
calling  ioapic_init_ops+0x0/0x14 @ 1
initcall ioapic_init_ops+0x0/0x14 returned 0 after 8 usecs
calling  register_e820_pmem+0x0/0x5e @ 1
initcall register_e820_pmem+0x0/0x5e returned 0 after 97 usecs
calling  add_pcspkr+0x0/0xcf @ 1
initcall add_pcspkr+0x0/0xcf returned 0 after 83 usecs
calling  start_periodic_check_for_corruption+0x0/0x30 @ 1
initcall start_periodic_check_for_corruption+0x0/0x30 returned 0 after 0 usecs
calling  audit_classes_init+0x0/0xaf @ 1
initcall audit_classes_init+0x0/0xaf returned 0 after 26 usecs
calling  sha1_ssse3_mod_init+0x0/0xe7 @ 1
initcall sha1_ssse3_mod_init+0x0/0xe7 returned 0 after 22 usecs
calling  sha256_ssse3_mod_init+0x0/0xfb @ 1
initcall sha256_ssse3_mod_init+0x0/0xfb returned 0 after 47 usecs
calling  iosf_mbi_init+0x0/0x29 @ 1
initcall iosf_mbi_init+0x0/0x29 returned 0 after 86 usecs
calling  proc_execdomains_init+0x0/0x22 @ 1
initcall proc_execdomains_init+0x0/0x22 returned 0 after 10 usecs
calling  register_warn_debugfs+0x0/0x24 @ 1
initcall register_warn_debugfs+0x0/0x24 returned 0 after 30 usecs
calling  cpuhp_sysfs_init+0x0/0x140 @ 1
initcall cpuhp_sysfs_init+0x0/0x140 returned 0 after 234 usecs
calling  ioresources_init+0x0/0x4a @ 1
initcall ioresources_init+0x0/0x4a returned 0 after 9 usecs
calling  snapshot_device_init+0x0/0x11 @ 1
initcall snapshot_device_init+0x0/0x11 returned 0 after 119 usecs
calling  irq_pm_init_ops+0x0/0x14 @ 1
initcall irq_pm_init_ops+0x0/0x14 returned 0 after 11 usecs
calling  klp_init+0x0/0x4f @ 1
initcall klp_init+0x0/0x4f returned 0 after 11 usecs
calling  proc_modules_init+0x0/0x1f @ 1
initcall proc_modules_init+0x0/0x1f returned 0 after 7 usecs
calling  timer_sysctl_init+0x0/0x1b @ 1
initcall timer_sysctl_init+0x0/0x1b returned 0 after 8 usecs
calling  timekeeping_init_ops+0x0/0x14 @ 1
initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  init_clocksource_sysfs+0x0/0x24 @ 1
initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 177 usecs
calling  init_timer_list_procfs+0x0/0x32 @ 1
initcall init_timer_list_procfs+0x0/0x32 returned 0 after 17 usecs
calling  alarmtimer_init+0x0/0x105 @ 1
initcall alarmtimer_init+0x0/0x105 returned 0 after 46 usecs
calling  init_posix_timers+0x0/0x2a @ 1
initcall init_posix_timers+0x0/0x2a returned 0 after 39 usecs
calling  clockevents_init_sysfs+0x0/0x19a @ 1
initcall clockevents_init_sysfs+0x0/0x19a returned 0 after 1158 usecs
calling  proc_dma_init+0x0/0x22 @ 1
initcall proc_dma_init+0x0/0x22 returned 0 after 7 usecs
calling  kallsyms_init+0x0/0x22 @ 1
initcall kallsyms_init+0x0/0x22 returned 0 after 16 usecs
calling  pid_namespaces_init+0x0/0x40 @ 1
initcall pid_namespaces_init+0x0/0x40 returned 0 after 42 usecs
calling  ikconfig_init+0x0/0x42 @ 1
initcall ikconfig_init+0x0/0x42 returned 0 after 4 usecs
calling  audit_watch_init+0x0/0x3c @ 1
initcall audit_watch_init+0x0/0x3c returned 0 after 11 usecs
calling  audit_fsnotify_init+0x0/0x3f @ 1
initcall audit_fsnotify_init+0x0/0x3f returned 0 after 3 usecs
calling  audit_tree_init+0x0/0xcb @ 1
initcall audit_tree_init+0x0/0xcb returned 0 after 30 usecs
calling  seccomp_sysctl_init+0x0/0x2c @ 1
initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 19 usecs
calling  utsname_sysctl_init+0x0/0x14 @ 1
initcall utsname_sysctl_init+0x0/0x14 returned 0 after 30 usecs
calling  init_tracepoints+0x0/0x2c @ 1
initcall init_tracepoints+0x0/0x2c returned 0 after 1 usecs
calling  init_lstats_procfs+0x0/0x3c @ 1
initcall init_lstats_procfs+0x0/0x3c returned 0 after 12 usecs
calling  stack_trace_init+0x0/0xa4 @ 1
initcall stack_trace_init+0x0/0xa4 returned 0 after 29 usecs
calling  perf_event_sysfs_init+0x0/0x106 @ 1
initcall perf_event_sysfs_init+0x0/0x106 returned 0 after 950 usecs
calling  system_trusted_keyring_init+0x0/0x8a @ 1
Initialise system trusted keyrings
initcall system_trusted_keyring_init+0x0/0x8a returned 0 after 5156 usecs
calling  blacklist_init+0x0/0x162 @ 1
Key type blacklist registered
initcall blacklist_init+0x0/0x162 returned 0 after 4740 usecs
calling  kswapd_init+0x0/0x60 @ 1
initcall kswapd_init+0x0/0x60 returned 0 after 92 usecs
calling  extfrag_debug_init+0x0/0x57 @ 1
initcall extfrag_debug_init+0x0/0x57 returned 0 after 26 usecs
calling  mm_compute_batch_init+0x0/0x53 @ 1
initcall mm_compute_batch_init+0x0/0x53 returned 0 after 1 usecs
calling  slab_proc_init+0x0/0x22 @ 1
initcall slab_proc_init+0x0/0x22 returned 0 after 8 usecs
calling  workingset_init+0x0/0xd0 @ 1
workingset: timestamp_bits=36 max_order=22 bucket_order=0
initcall workingset_init+0x0/0xd0 returned 0 after 7154 usecs
calling  proc_vmalloc_init+0x0/0x64 @ 1
initcall proc_vmalloc_init+0x0/0x64 returned 0 after 6 usecs
calling  procswaps_init+0x0/0x1f @ 1
initcall procswaps_init+0x0/0x1f returned 0 after 4 usecs
calling  init_frontswap+0x0/0x93 @ 1
initcall init_frontswap+0x0/0x93 returned 0 after 40 usecs
calling  slab_sysfs_init+0x0/0xee @ 1
initcall slab_sysfs_init+0x0/0xee returned 0 after 17331 usecs
calling  slab_debugfs_init+0x0/0x4e @ 1
initcall slab_debugfs_init+0x0/0x4e returned 0 after 16 usecs
calling  init_zbud+0x0/0x20 @ 1
zbud: loaded
initcall init_zbud+0x0/0x20 returned 0 after 3231 usecs
calling  zs_init+0x0/0x73 @ 1
initcall zs_init+0x0/0x73 returned 0 after 70 usecs
calling  fcntl_init+0x0/0x2a @ 1
initcall fcntl_init+0x0/0x2a returned 0 after 166 usecs
calling  proc_filesystems_init+0x0/0x22 @ 1
initcall proc_filesystems_init+0x0/0x22 returned 0 after 7 usecs
calling  start_dirtytime_writeback+0x0/0x17 @ 1
initcall start_dirtytime_writeback+0x0/0x17 returned 0 after 1 usecs
calling  dio_init+0x0/0x2d @ 1
initcall dio_init+0x0/0x2d returned 0 after 142 usecs
calling  dnotify_init+0x0/0x9d @ 1
initcall dnotify_init+0x0/0x9d returned 0 after 270 usecs
calling  fanotify_user_setup+0x0/0x1f7 @ 1
initcall fanotify_user_setup+0x0/0x1f7 returned 0 after 519 usecs
calling  aio_setup+0x0/0x98 @ 1
initcall aio_setup+0x0/0x98 returned 0 after 352 usecs
calling  mbcache_init+0x0/0x31 @ 1
initcall mbcache_init+0x0/0x31 returned 0 after 126 usecs
calling  init_grace+0x0/0x11 @ 1
initcall init_grace+0x0/0x11 returned 0 after 4 usecs
calling  init_v2_quota_format+0x0/0x22 @ 1
initcall init_v2_quota_format+0x0/0x22 returned 0 after 0 usecs
calling  init_devpts_fs+0x0/0x2c @ 1
initcall init_devpts_fs+0x0/0x2c returned 0 after 21 usecs
calling  ext4_init_fs+0x0/0x19f @ 1
initcall ext4_init_fs+0x0/0x19f returned 0 after 1798 usecs
calling  journal_init+0x0/0x12e @ 1
initcall journal_init+0x0/0x12e returned 0 after 806 usecs
calling  init_nfs_fs+0x0/0x191 @ 1
initcall init_nfs_fs+0x0/0x191 returned 0 after 1161 usecs
calling  init_nfs_v3+0x0/0x14 @ 1
initcall init_nfs_v3+0x0/0x14 returned 0 after 0 usecs
calling  init_nlm+0x0/0x62 @ 1
initcall init_nlm+0x0/0x62 returned 0 after 25 usecs
calling  init_nls_cp437+0x0/0x13 @ 1
initcall init_nls_cp437+0x0/0x13 returned 0 after 0 usecs
calling  init_nls_ascii+0x0/0x13 @ 1
initcall init_nls_ascii+0x0/0x13 returned 0 after 0 usecs
calling  init_autofs_fs+0x0/0x2a @ 1
initcall init_autofs_fs+0x0/0x2a returned 0 after 135 usecs
calling  init_v9fs+0x0/0x10f @ 1
9p: Installing v9fs 9p2000 file system support
initcall init_v9fs+0x0/0x10f returned 0 after 6337 usecs
calling  efivarfs_init+0x0/0x21 @ 1
initcall efivarfs_init+0x0/0x21 returned -19 after 0 usecs
calling  ipc_init+0x0/0x25 @ 1
initcall ipc_init+0x0/0x25 returned 0 after 41 usecs
calling  ipc_sysctl_init+0x0/0x2d @ 1
initcall ipc_sysctl_init+0x0/0x2d returned 0 after 37 usecs
calling  init_mqueue_fs+0x0/0xeb @ 1
initcall init_mqueue_fs+0x0/0xeb returned 0 after 235 usecs
calling  key_proc_init+0x0/0x6e @ 1
initcall key_proc_init+0x0/0x6e returned 0 after 25 usecs
calling  jent_mod_init+0x0/0x2e @ 1
tsc: Refined TSC clocksource calibration: 2099.998 MHz
initcall jent_mod_init+0x0/0x2e returned 0 after 13270 usecs
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e452ea631d, max_idle_ns: 440795244572 ns
calling  af_alg_init+0x0/0x41 @ 1
NET: Registered PF_ALG protocol family
clocksource: Switched to clocksource tsc
initcall af_alg_init+0x0/0x41 returned 0 after 11161 usecs
calling  algif_hash_init+0x0/0x11 @ 1
initcall algif_hash_init+0x0/0x11 returned 0 after 12 usecs
calling  algif_skcipher_init+0x0/0x11 @ 1
initcall algif_skcipher_init+0x0/0x11 returned 0 after 2 usecs
calling  rng_init+0x0/0x11 @ 1
initcall rng_init+0x0/0x11 returned 0 after 2 usecs
calling  algif_aead_init+0x0/0x11 @ 1
initcall algif_aead_init+0x0/0x11 returned 0 after 2 usecs
calling  asymmetric_key_init+0x0/0x11 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x11 returned 0 after 5111 usecs
calling  x509_key_init+0x0/0x19 @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x19 returned 0 after 5605 usecs
calling  blkdev_init+0x0/0x20 @ 1
initcall blkdev_init+0x0/0x20 returned 0 after 39 usecs
calling  proc_genhd_init+0x0/0x42 @ 1
initcall proc_genhd_init+0x0/0x42 returned 0 after 13 usecs
calling  bsg_init+0x0/0x117 @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
initcall bsg_init+0x0/0x117 returned 0 after 8152 usecs
calling  throtl_init+0x0/0x41 @ 1
initcall throtl_init+0x0/0x41 returned 0 after 127 usecs
calling  deadline_init+0x0/0x11 @ 1
io scheduler mq-deadline registered
initcall deadline_init+0x0/0x11 returned 0 after 5224 usecs
calling  kyber_init+0x0/0x11 @ 1
io scheduler kyber registered
initcall kyber_init+0x0/0x11 returned 0 after 4705 usecs
calling  bfq_init+0x0/0x8b @ 1
io scheduler bfq registered
initcall bfq_init+0x0/0x8b returned 0 after 4848 usecs
calling  io_uring_init+0x0/0x32 @ 1
initcall io_uring_init+0x0/0x32 returned 0 after 134 usecs
calling  blake2s_mod_init+0x0/0x8 @ 1
initcall blake2s_mod_init+0x0/0x8 returned 0 after 0 usecs
calling  crc_t10dif_mod_init+0x0/0x4c @ 1
initcall crc_t10dif_mod_init+0x0/0x4c returned 0 after 200 usecs
calling  percpu_counter_startup+0x0/0x51 @ 1
initcall percpu_counter_startup+0x0/0x51 returned 0 after 187 usecs
calling  digsig_init+0x0/0x39 @ 1
initcall digsig_init+0x0/0x39 returned 0 after 103 usecs
calling  pcie_portdrv_init+0x0/0x49 @ 1
IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT:1)
IOAPIC[1]: Preconfigured routing entry (9-2 -> IRQ 24 Level:1 ActiveLow:1)
IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT:1)
IOAPIC[1]: Preconfigured routing entry (9-8 -> IRQ 26 Level:1 ActiveLow:1)
IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT:1)
IOAPIC[1]: Preconfigured routing entry (9-16 -> IRQ 27 Level:1 ActiveLow:1)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-16 -> IRQ 16 Level:1 ActiveLow:1)
initcall pcie_portdrv_init+0x0/0x49 returned 0 after 104537 usecs
calling  pci_proc_init+0x0/0x6c @ 1
initcall pci_proc_init+0x0/0x6c returned 0 after 309 usecs
calling  pci_hotplug_init+0x0/0x8 @ 1
initcall pci_hotplug_init+0x0/0x8 returned 0 after 0 usecs
calling  shpcd_init+0x0/0x5d @ 1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
initcall shpcd_init+0x0/0x5d returned 0 after 7574 usecs
calling  pci_stub_init+0x0/0x1fb @ 1
initcall pci_stub_init+0x0/0x1fb returned 0 after 58 usecs
calling  vmd_drv_init+0x0/0x1a @ 1
initcall vmd_drv_init+0x0/0x1a returned 0 after 80 usecs
calling  vesafb_driver_init+0x0/0x13 @ 1
initcall vesafb_driver_init+0x0/0x13 returned 0 after 36 usecs
calling  efifb_driver_init+0x0/0x13 @ 1
initcall efifb_driver_init+0x0/0x13 returned 0 after 31 usecs
calling  intel_idle_init+0x0/0x503 @ 1
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
ACPI: \_SB_.SCK0.CP00: Found 2 idle states
initcall intel_idle_init+0x0/0x503 returned 0 after 24968 usecs
calling  ged_driver_init+0x0/0x13 @ 1
initcall ged_driver_init+0x0/0x13 returned 0 after 56 usecs
calling  acpi_ac_init+0x0/0x78 @ 1
initcall acpi_ac_init+0x0/0x78 returned 0 after 267 usecs
calling  acpi_button_driver_init+0x0/0xaf @ 1
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xaf returned 0 after 28437 usecs
calling  acpi_fan_driver_init+0x0/0x13 @ 1
initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 61 usecs
calling  acpi_processor_driver_init+0x0/0xeb @ 1
initcall acpi_processor_driver_init+0x0/0xeb returned 0 after 23387 usecs
calling  acpi_thermal_init+0x0/0x82 @ 1
initcall acpi_thermal_init+0x0/0x82 returned 0 after 361 usecs
calling  acpi_battery_init+0x0/0x6d @ 1
initcall acpi_battery_init+0x0/0x6d returned 0 after 8 usecs
calling  acpi_hed_driver_init+0x0/0x11 @ 1
initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 134 usecs
calling  bgrt_init+0x0/0x19b @ 1
initcall bgrt_init+0x0/0x19b returned -19 after 0 usecs
calling  erst_init+0x0/0x4c3 @ 1
ERST: Error Record Serialization Table (ERST) support is initialized.
pstore: Registered erst as persistent store backend
initcall erst_init+0x0/0x4c3 returned 0 after 14964 usecs
calling  gpio_clk_driver_init+0x0/0x13 @ 1
initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 43 usecs
calling  plt_clk_driver_init+0x0/0x13 @ 1
initcall plt_clk_driver_init+0x0/0x13 returned 0 after 30 usecs
calling  dw_pci_driver_init+0x0/0x1a @ 1
initcall dw_pci_driver_init+0x0/0x1a returned 0 after 86 usecs
calling  virtio_pci_driver_init+0x0/0x1a @ 1
initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 124 usecs
calling  n_null_init+0x0/0x1a @ 1
initcall n_null_init+0x0/0x1a returned 0 after 0 usecs
calling  pty_init+0x0/0xd @ 1
initcall pty_init+0x0/0xd returned 0 after 221 usecs
calling  sysrq_init+0x0/0x4a @ 1
initcall sysrq_init+0x0/0x4a returned 0 after 17 usecs
calling  serial8250_init+0x0/0x2de @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x2de returned 0 after 24614 usecs
calling  serial_pci_driver_init+0x0/0x1a @ 1
initcall serial_pci_driver_init+0x0/0x1a returned 0 after 145 usecs
calling  exar_pci_driver_init+0x0/0x1a @ 1
initcall exar_pci_driver_init+0x0/0x1a returned 0 after 52 usecs
calling  dw8250_platform_driver_init+0x0/0x13 @ 1
initcall dw8250_platform_driver_init+0x0/0x13 returned 0 after 73 usecs
calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 60 usecs
calling  mid8250_pci_driver_init+0x0/0x1a @ 1
initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 45 usecs
calling  pericom8250_pci_driver_init+0x0/0x1a @ 1
initcall pericom8250_pci_driver_init+0x0/0x1a returned 0 after 55 usecs
calling  random_sysctls_init+0x0/0x22 @ 1
initcall random_sysctls_init+0x0/0x22 returned 0 after 21 usecs
calling  hpet_init+0x0/0x72 @ 1
initcall hpet_init+0x0/0x72 returned 0 after 1000 usecs
calling  nvram_module_init+0x0/0x89 @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x89 returned 0 after 5013 usecs
calling  virtio_rng_driver_init+0x0/0x11 @ 1
initcall virtio_rng_driver_init+0x0/0x11 returned 0 after 38 usecs
calling  init_tis+0x0/0x14a @ 1
initcall init_tis+0x0/0x14a returned 0 after 75 usecs
calling  crb_acpi_driver_init+0x0/0x11 @ 1
initcall crb_acpi_driver_init+0x0/0x11 returned 0 after 119 usecs
calling  cn_proc_init+0x0/0x3a @ 1
initcall cn_proc_init+0x0/0x3a returned 0 after 41 usecs
calling  topology_sysfs_init+0x0/0x2c @ 1
initcall topology_sysfs_init+0x0/0x2c returned 0 after 1022 usecs
calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
initcall cacheinfo_sysfs_init+0x0/0x2c returned 0 after 5124 usecs
calling  intel_lpss_init+0x0/0x1d @ 1
initcall intel_lpss_init+0x0/0x1d returned 0 after 74 usecs
calling  intel_lpss_pci_driver_init+0x0/0x1a @ 1
initcall intel_lpss_pci_driver_init+0x0/0x1a returned 0 after 191 usecs
calling  intel_lpss_acpi_driver_init+0x0/0x13 @ 1
initcall intel_lpss_acpi_driver_init+0x0/0x13 returned 0 after 41 usecs
calling  mac_hid_init+0x0/0x29 @ 1
initcall mac_hid_init+0x0/0x29 returned 0 after 13 usecs
calling  rdac_init+0x0/0x75 @ 1
rdac: device handler registered
initcall rdac_init+0x0/0x75 returned 0 after 5124 usecs
calling  hp_sw_init+0x0/0x11 @ 1
hp_sw: device handler registered
initcall hp_sw_init+0x0/0x11 returned 0 after 4962 usecs
calling  clariion_init+0x0/0x33 @ 1
emc: device handler registered
initcall clariion_init+0x0/0x33 returned 0 after 4792 usecs
calling  alua_init+0x0/0x64 @ 1
alua: device handler registered
initcall alua_init+0x0/0x64 returned 0 after 5054 usecs
calling  blackhole_netdev_init+0x0/0xcb @ 1
initcall blackhole_netdev_init+0x0/0xcb returned 0 after 52 usecs
calling  phylink_init+0x0/0xab @ 1
initcall phylink_init+0x0/0xab returned 0 after 0 usecs
calling  phy_module_init+0x0/0x18 @ 1
initcall phy_module_init+0x0/0x18 returned 0 after 187 usecs
calling  fixed_mdio_bus_init+0x0/0x241 @ 1
initcall fixed_mdio_bus_init+0x0/0x241 returned 0 after 1334 usecs
calling  phy_module_init+0x0/0x18 @ 1
initcall phy_module_init+0x0/0x18 returned 0 after 1114 usecs
calling  cavium_ptp_driver_init+0x0/0x1a @ 1
initcall cavium_ptp_driver_init+0x0/0x1a returned 0 after 98 usecs
calling  e1000_init_module+0x0/0x77 @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
initcall e1000_init_module+0x0/0x77 returned 0 after 12138 usecs
calling  e1000_init_module+0x0/0x32 @ 1
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
initcall e1000_init_module+0x0/0x32 returned 0 after 12390 usecs
calling  igb_init_module+0x0/0x40 @ 1
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
igb 0000:05:00.0: added PHC on eth0
igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:05:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 0c:c4:7a:c4:ab:7a
igb 0000:05:00.0: eth0: PBA No: 010A00-000
igb 0000:05:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-17 -> IRQ 17 Level:1 ActiveLow:1)
igb 0000:05:00.1: added PHC on eth1
igb 0000:05:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:05:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 0c:c4:7a:c4:ab:7b
igb 0000:05:00.1: eth1: PBA No: 010A00-000
igb 0000:05:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
initcall igb_init_module+0x0/0x40 returned 0 after 227665 usecs
calling  igc_init_module+0x0/0x40 @ 1
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
initcall igc_init_module+0x0/0x40 returned 0 after 10625 usecs
calling  ixgbe_init_module+0x0/0xa9 @ 1
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
ACPI Warning: \_SB.PCI0.BR2C._PRT: Return Package has no elements (empty) (20220331/nsprepkg-94)
pmd_set_huge: Cannot satisfy [mem 0xfbc00000-0xfbe00000] with a huge-page mapping due to MTRR override.
ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16 XDP Queue count = 0
ixgbe 0000:03:00.0: MAC: 5, PHY: 7, PBA No: 020C00-000
ixgbe 0000:03:00.0: 0c:c4:7a:c4:ad:e6
ixgbe 0000:03:00.0: Intel(R) 10 Gigabit Network Connection
ACPI Warning: \_SB.PCI0.BR2C._PRT: Return Package has no elements (empty) (20220331/nsprepkg-94)
IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT:1)
IOAPIC[1]: Preconfigured routing entry (9-12 -> IRQ 67 Level:1 ActiveLow:1)
ixgbe 0000:03:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16 XDP Queue count = 0
ixgbe 0000:03:00.1: MAC: 5, PHY: 7, PBA No: 020C00-000
ixgbe 0000:03:00.1: 0c:c4:7a:c4:ad:e7
ixgbe 0000:03:00.1: Intel(R) 10 Gigabit Network Connection
initcall ixgbe_init_module+0x0/0xa9 returned 0 after 3643820 usecs
calling  i40e_init_module+0x0/0xb4 @ 1
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
initcall i40e_init_module+0x0/0xb4 returned 0 after 13802 usecs
calling  rtl8169_pci_driver_init+0x0/0x1a @ 1
initcall rtl8169_pci_driver_init+0x0/0x1a returned 0 after 59 usecs
calling  rtl8152_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver r8152
initcall rtl8152_driver_init+0x0/0x1a returned 0 after 6241 usecs
calling  asix_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver asix
initcall asix_driver_init+0x0/0x1a returned 0 after 6154 usecs
calling  ax88179_178a_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver ax88179_178a
initcall ax88179_178a_driver_init+0x0/0x1a returned 0 after 6860 usecs
calling  usbnet_init+0x0/0x2b @ 1
initcall usbnet_init+0x0/0x2b returned 0 after 2 usecs
calling  usbport_trig_init+0x0/0x11 @ 1
initcall usbport_trig_init+0x0/0x11 returned 0 after 1 usecs
calling  mon_init+0x0/0x194 @ 1
initcall mon_init+0x0/0x194 returned 0 after 276 usecs
calling  ehci_hcd_init+0x0/0x19c @ 1
initcall ehci_hcd_init+0x0/0x19c returned 0 after 9 usecs
calling  ehci_pci_init+0x0/0x52 @ 1
IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (8-18 -> IRQ 18 Level:1 ActiveLow:1)
ehci-pci 0000:00:1a.0: EHCI Host Controller
ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:1a.0: debug port 2
BUG: unable to handle page fault for address: ffff88807bdb6000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD c7fe01067 P4D c7fe01067 PUD c7fe04067 PMD c7fe07067 PTE 0
Oops: 0002 [#1] SMP KASAN PTI
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc8-00011-g3717500cb547 #1
Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
RIP: 0010:memset_erms+0x9/0x10
Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
RSP: 0000:ffffc90000057630 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff888943d7a300 RCX: 0000000000000020
RDX: 0000000000000060 RSI: 0000000000000000 RDI: ffff88807bdb6000
RBP: 000000007bdb5fc0 R08: 0000000000000001 R09: ffff88807bdb5fc0
R10: ffffed100f7b6c03 R11: 0000000000000001 R12: ffff88807bdb5fc0
R13: ffff88807bdb5fc0 R14: 0000000000000100 R15: ffff888943d7a310
FS:  0000000000000000(0000) GS:ffff888b9fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88807bdb6000 CR3: 0000000c7e20e001 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
dma_pool_alloc+0x157/0xa40
? kasan_set_track+0x21/0x30
ehci_qh_alloc+0xda/0x3e0
? ehci_qtd_alloc+0x230/0x230
? dma_pool_create+0x446/0x7e0
ehci_mem_init+0x10a/0x780
? __hrtimer_init+0x41/0x1e0
ehci_init+0x440/0xa70
ehci_setup+0x110/0x1a0
ehci_pci_setup+0x1b1/0xda0
? ehci_pci_resume+0x70/0x70
? mutex_unlock+0x80/0xd0
? __mutex_unlock_slowpath+0x2a0/0x2a0
? usb_alloc_dev+0x666/0xd20
usb_add_hcd.cold+0x5c4/0x1015
usb_hcd_pci_probe+0x661/0xb20
? ehci_pci_remove+0x20/0x20
local_pci_probe+0xdc/0x170
pci_call_probe+0x15f/0x500
? _raw_spin_lock+0x81/0xd0
? pci_pm_suspend_noirq+0x8c0/0x8c0
? pci_assign_irq+0x81/0x280
? pci_match_device+0x351/0x6a0
? kernfs_put+0x18/0x30
pci_device_probe+0xee/0x230
really_probe+0x1da/0xa60
__driver_probe_device+0x2a1/0x460
driver_probe_device+0x49/0x120
__driver_attach+0x178/0x4b0
? __device_attach_driver+0x260/0x260
bus_for_each_dev+0x11b/0x1a0
? subsys_dev_iter_exit+0x10/0x10
? __kmem_cache_alloc_node+0x17e/0x2a0
? klist_add_tail+0x12f/0x270
bus_add_driver+0x423/0x570
driver_register+0x20f/0x390
? ehci_hcd_init+0x19c/0x19c
do_one_initcall+0x87/0x2c0
? trace_event_raw_event_initcall_level+0x190/0x190
? parse_one+0x3f0/0x3f0
? do_initcalls+0x30/0x202
? kasan_set_track+0x21/0x30
? __kasan_kmalloc+0x7a/0x90
do_initcalls+0x1d2/0x202
kernel_init_freeable+0x434/0x4a3
? console_on_rootfs+0x52/0x52
? usleep_range_state+0x180/0x180
? _raw_spin_lock_bh+0xe0/0xe0
? rest_init+0x170/0x170
? rest_init+0x170/0x170
kernel_init+0x19/0x140
ret_from_fork+0x1f/0x30
</TASK>
Modules linked in:
CR2: ffff88807bdb6000
---[ end trace 0000000000000000 ]---
RIP: 0010:memset_erms+0x9/0x10
Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
RSP: 0000:ffffc90000057630 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff888943d7a300 RCX: 0000000000000020
RDX: 0000000000000060 RSI: 0000000000000000 RDI: ffff88807bdb6000
RBP: 000000007bdb5fc0 R08: 0000000000000001 R09: ffff88807bdb5fc0
R10: ffffed100f7b6c03 R11: 0000000000000001 R12: ffff88807bdb5fc0
R13: ffff88807bdb5fc0 R14: 0000000000000100 R15: ffff888943d7a310
FS:  0000000000000000(0000) GS:ffff888b9fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88807bdb6000 CR3: 0000000c7e20e001 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
early console in extract_kernel
input_data: 0x0000000c7f43e40d
input_len: 0x0000000000af6833
output: 0x0000000c7d400000
output_len: 0x0000000002ae89f0
kernel_total_size: 0x0000000002a28000
needed_size: 0x0000000002c00000
trampoline_32bit: 0x0000000000098000


--JKjdV7AouEqRPVaE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/nvml-dax.yaml
suite: nvml
testcase: nvml
category: functional
nvml:
test: pmem
group: libpmempool
disk:
  nr_pmem: 1
fs: ext4
mount_option: dax
boot_params:
  bp_memmap: 32G!4G
job_origin: nvml-dax.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-bdw-de1
tbox_group: lkp-bdw-de1
submit_id: 6391f07ecbd508cd39296eca
job_file: "/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221208-52537-pp3e6p-0.yaml"
id: 349ed8effd491b8031a1bc9e1ed0b8cfcbbf74c6
queuer_version: "/zday/lkp"

#! hosts/lkp-bdw-de1
model: Broadwell-DE
nr_node: 1
nr_cpu: 16
memory: 48G
nr_hdd_partitions: 1
nr_ssd_partitions: 1
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV410402GY800OGN-part2"
hdd_partitions: "/dev/disk/by-id/ata-ST9500620NS_9XF26EB5-part1"
swap_partitions:
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV410402GY800OGN-part1"
brand: Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/nvml
need_kconfig:
- NVDIMM_PFN: y
- MMU
- FS_DAX: y
- ZONE_DEVICE
- LIBNVDIMM
- BTT
- BLK_DEV_PMEM
- X86_PMEM_LEGACY
- FS_DAX
- EXT4_FS
rootfs: debian-10.4-x86_64-20200603.cgz

#! include/disk/nr_pmem

#! include/fs/OTHERS

#! include/queue/cyclic
commit: 3717500cb5479136121a65d22d48f4b5e940bba4

#! include/testbox/lkp-bdw-de1
ucode: '0x700001c'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- IGB: y
- NETDEVICES: y
- ETHERNET: y
- NET_VENDOR_INTEL: y
- PCI: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- HAS_DMA: y
bisect_dmesg: true
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-12-08 22:11:11.084146215 +08:00
_id: 6391f07ecbd508cd39296eca
_rt: "/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 235b4a3e19d7383c847aa641429cbe336f9f7834
base_commit: 76dcd734eca23168cb008912c0f69ff408905235
branch: linux-devel/devel-hourly-20221205-180114
result_root: "/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/nvml/32G_4G-ext4-libpmempool-dax-1-pmem/lkp-bdw-de1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547
- branch=linux-devel/devel-hourly-20221205-180114
- job=/lkp/jobs/scheduled/lkp-bdw-de1/nvml-32G_4G-ext4-libpmempool-dax-1-pmem-debian-10.4-x86_64-20200603.cgz-3717500cb5479136121a65d22d48f4b5e940bba4-20221208-52537-pp3e6p-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=3717500cb5479136121a65d22d48f4b5e940bba4
- initcall_debug
- memmap=32G!4G
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/nvml_20221021.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/nvml-x86_64-ec9fc0404-1_20221026.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20221206134921/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.1.0-rc8-wt-13317-g6bb9c42b787f
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3717500cb5479136121a65d22d48f4b5e940bba4/vmlinuz-6.1.0-rc8-00011-g3717500cb547"
dequeue_time: 2022-12-08 22:51:35.773612269 +08:00

#! /db/releases/20221208144305/lkp-src/include/site/inn
job_state: booting

--JKjdV7AouEqRPVaE--
