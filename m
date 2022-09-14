Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2F5B7ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiINCMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiINCMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:12:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7A558C0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663121560; x=1694657560;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3mAX76vaC4p5fxRBp20qaRSHi2VVnzVGVr69W76eGGY=;
  b=JCiPC8Bwv0vJhjYMRMS2nuanFlAsa8NYpKWWR0TihVnhIYFIi0f+vCRH
   rJOhh2I2JWznYnirNle+yw0Tcqj4JF9kWIe8dwEOhcsVaQUHp1ir/lAZm
   VVnPeQq39kj+41o5uPadErZQgN7L6WhSBY3cV3tDcHcOf3zdKeMBuKuaq
   EOLV0tVu9OJFuQAkB5ddxcBI57ljKNBDXuMzU1mvTlqDn/pJfsk8v6g7H
   EMlCThj7tWj0E8TUgyosrLzGtVFXPaaNAM7LJrCc0bf0ooYXbwC6MOXPg
   qG1C9nA+TT7R4a5jdl7B8fl42j6iX0IqtX3LsE1bnFyMC4eGAHBHEpYAI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278697460"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="xz'?scan'208";a="278697460"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 19:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="xz'?scan'208";a="742386837"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2022 19:12:37 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 19:12:37 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 19:12:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 13 Sep 2022 19:12:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 13 Sep 2022 19:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVRzTnFDPE3h2rMzjpdrw4P3bJIlRw7pF+PKWTK1N9NLh+SqFFVtAXhP6pfgDwoV7qQfvWg375/lHiLLE2pZ8tvISSmXaD0IJJNri3zZc2OGO6WERBs6bPcobae/C86yrQFF1kujpoPW7JvsVjKqt0AkZoTEHi5apOIulqHceaHYjI+7rbnhUdLARMCBzbRKohtmzhD2RIdkNkpcVsKp92tOQwZ4SPjVQiPaeLmX8624HKW7BKhJzHCoucQrnNSVheVcQcqd/KRx6U6YW6gJBGGUu8tQgAFZ5MMDSPgpf7bGmhi0aGTGbrl3H5OIx8gUnX0HcbNhMg3mE915pv+24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds7zOZI436ABWg8fytSSq1Sugx17uF5CgtqKdIlbtZw=;
 b=TDUpk8YeTovz/dBmWeogwWR/rd0pLtUtOcc5gv3owf5QasHox3IuR/LvnrBHBA3NpzfbNfxflmhLQvEEWEwIYw3yzuaCQ7wJdrLcgEGR8mGxgbbTZP2gCg4ZguP1/DSR6lKFSlK50GaMxYnehsfbV5SDbB6B9AcmINChlbtFgHTytbrB7tg99C2ZwaP76fLbnlsUHc/repa0UXqQAR/oZ1koztaUNukF6OiPP4KReD/Fumzc5Fjnhg+J6ZKiB5tC6A1v71sY1fxjE2OwA2QmuwTjN1MUuE8y98wy/bo8bJy1ffYZ3SdqRNxecEG6S2Pda1CKOUnLbUaFuwN69bSRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA0PR11MB7331.namprd11.prod.outlook.com (2603:10b6:208:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 02:12:28 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 02:12:28 +0000
Date:   Wed, 14 Sep 2022 10:11:14 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Ben Luo <luoben@linux.alibaba.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>, <linux-kernel@vger.kernel.org>,
        <luoben@linux.alibaba.com>
Subject: [mm/slub] fb670abe87:
 BUG_kmem_cache_node(Not_tainted):Freechain_corrupt
Message-ID: <202209140949.45a9520d-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="nx16jrpURDKAO4N8"
Content-Disposition: inline
In-Reply-To: <1662962379-16174-1-git-send-email-luoben@linux.alibaba.com>
X-ClientProxiedBy: SG2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:3:17::30) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA0PR11MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 021c8884-2736-4814-6894-08da95f691fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5ZBQPPF8yBF9LahP7mhrafWSATZ6u7Hz4XEcLqxUl369KFRJu0abHKgg+2GiMd+AQdcwTaCFEooEezil9SOW2ZkNGVJo3CVL7v0OX2jpnMG98AYTVojJ+GUfC/jDJ76D2ndggibSs0z15cZclHNi/J7qPgjvR0atTu5r6maU9yuN2+sJEIsnlsQFbbgrNAgvwkWlF9Bmk1/cPhGAsG73sUwcSsRTHu7c1eI7AJ5yuXJ9zNWNcDiGEH+z5oWaVqniY895eVk/pNmAwpjJqPMG/e9yFvMej3Bq6Ho/5zVQL/Xo0hlU77n74X6qJ6AhMggH34l15RjN6pAP2gloaNunl8aNzi3ilmQAovgE1j89x+csjRrJDP8uk3QGWSOO3okMXOKPLBfcBnh5FUuZ9FW11cKIWh8c+4whTSyTuwqVT92UbGXZm5NuXJizVIbE1HJtffHHQmO1SYaWR37CXxQ4iSJ52sCJx0aOdklDteTmrP6YdgOTstzo7kLJvkifZpN8z+9oyyzwwU2ftqqmBRY050nrxXnh41+VH6W11hnezRCZoHnqoiRrH63hvYzk8FOOyfNrzD7sR6xr/7Ppe/0iKgBk05RwqjZ/013Y5MsYTMkhKgRlZh3yIzUc1/AEODmhhIhkWWykGZG/SwpKDwcTNMofQ837X2P2XuWGZp5a5+LNm2onE0Z4X9WraPVhsRI+19YqukteMfWkltmhWrKlECQ5YXaETbjujoV95D8w+myH26R7W+D7UxwqIriuHbRy5DLRPpu4wYoPhb3eiGnwTgnlGZLmCJo4IbX5nYWN/Ka0gNOaMxT6z0vxE+G39VxL4+ayj49kLz+dSlRxUVsbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(6916009)(2906002)(4326008)(66556008)(316002)(26005)(6486002)(41300700001)(2616005)(86362001)(186003)(66476007)(6506007)(6512007)(966005)(6666004)(44144004)(38100700002)(235185007)(7416002)(83380400001)(478600001)(8936002)(8676002)(36756003)(5660300002)(82960400001)(1076003)(66946007)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zi7PQXJo2N4SgFmw+B3L9T9bN63kKtUl1uyQu6yXdqL5KKye/wCJjTo7Ks2V?=
 =?us-ascii?Q?lTGInApv0xcZFn9bi6n+weCZSBz9O4MiolKXlnRrW2sFjuuJAuhEmAt5BpQz?=
 =?us-ascii?Q?J+dEIZLTTI74lC3wKudB6ugI3WVYulx5g88k5j+ductnT21hGmhhq//hwTHl?=
 =?us-ascii?Q?kTwFFacwyHQc9UgC6HdXdvoIuX8cy2DZy01433l6/YnrUq7bRqHbJpiaW1e8?=
 =?us-ascii?Q?8yJq6nALLzHgLqssUuqMmXR/3hdp6f7FeR61xnMDz2gEBRpAJvayIorkNW5b?=
 =?us-ascii?Q?zzlYulz0yBRTMpPDxXWbber16GtlOTptKoCt7hQ3rVmRDeqSK8nuvf6FidsM?=
 =?us-ascii?Q?3DS8bbnb7XSESlTUatQJjVU9ylQMBYz4+jII/ecCoEJj9G2/twumLpupjYpQ?=
 =?us-ascii?Q?iLUWmhGE8pV+TjnUBJoUISFTRSaj8WWpAQGUOoJitsN4SSx9rVJH1q+k5NBd?=
 =?us-ascii?Q?u3Gwj+PNoiFl+HTi+I2J0hn9T9gVdKMUe4TSEO2R1vObsf5+B7iGFyBM5CV0?=
 =?us-ascii?Q?Pfkc8t0kku6T2axmmdcGZeZvlqYBqJKXPkhz4lwfY1AQo0lIkU4GN0ui1K82?=
 =?us-ascii?Q?lCmevUpMTVkTdxZ6tItr5W3wYv/A39z6H1AuoikvyjOJY5jEjcvPjuyQaaW/?=
 =?us-ascii?Q?/sammvGfo37Hxk3d48UBUTOKb1v3wGL3Vyq3eg7x/nn5nLszwECzEfj5dpk1?=
 =?us-ascii?Q?kgZJaDtbtFb7tSl1L2+YCsF2YD8N/YbvU0lDFseDJg8EqxT8VKOO1NhcySey?=
 =?us-ascii?Q?1c3+/BU6pVvQZrvTJxyUBW41olXzwMjz0OHha5oN7cpLKwFTPWvHusPumMWK?=
 =?us-ascii?Q?eoi7hqcvP81ZAb2i9Ino89xOqbuxgNQEk8pk4uniBDzF8XWA6mBhr8Nn2DbM?=
 =?us-ascii?Q?au0QpV0frJg6DlaIdQI+UEsxdNXknHBnpd75N1C1yJmZEcbuZShKudO3CHwG?=
 =?us-ascii?Q?UuM/Ow41vHCX2gRdCiMyxglAFBvRrKN5bikr+tmhusgBb7KGMl3x2z4N/EtT?=
 =?us-ascii?Q?POP0T7YH6rVQ0RasvPFxTMCe6k3PPHcdHbMyBuvQ/ysf8IYwVOauw0K6I7Ks?=
 =?us-ascii?Q?VMtwI2ZHlujOmCMM2PsXG5VF63+EQa8Bs4rPA3grfxiKYMRzOY/B3HM14EFk?=
 =?us-ascii?Q?0J7Z6zkIrgtKuv0J5qy8K8GrS8uRAauJPN0eqavzLyZSsSFnKbD9sXS1phzy?=
 =?us-ascii?Q?eZcaEqS13MDJEdQ4Of8aqmI6RGAKb2x/RQkA9btkt7L221UkU0aoMo0tcTT6?=
 =?us-ascii?Q?/iirvfNzRynu46vXFB6b5Da35rQjwtcBs927OXOmcTsjT0jtJSvjdx7Jh2Zh?=
 =?us-ascii?Q?2lFi1VHFy5usAjAySiFq8oN02SkbQ55Tj4yOeub38w/Zi9cby1mqqpdK6aVV?=
 =?us-ascii?Q?bkYpJSv+n8Sj/J/3Uhqgw6c+U00WM/Wv4vPCQn3G6Yb0FY1ffhwpgW/j1cUu?=
 =?us-ascii?Q?deySYaxiFTh5UwaFjYj8aS7x1M2W92MoRrfaVD9W+PnwOspKUlTiXDsxc1/4?=
 =?us-ascii?Q?9sPKJ9gQs2W1J7k9r6w4qDuzH7+945XZwA8bN4Gz1P+6f2OXCKw3tRtOtyyn?=
 =?us-ascii?Q?qxI0pJJHfUaz9aQs1LQIdORPpiGlldcLiTAdELnw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 021c8884-2736-4814-6894-08da95f691fd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 02:12:27.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lA0CGV/muu1EYgh+Kl4zB0fsGmZCjE6e5m3iKplEZyonZakXSHsnZrXx/y29rs1XCIDaRuH7aVj+aHG0HknBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nx16jrpURDKAO4N8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: fb670abe87296c7b214b6d9f29e9c7380d8d621c ("[PATCH] mm/slub: return 0 when object pointer is NULL")
url: https://github.com/intel-lab-lkp/linux/commits/Ben-Luo/mm-slub-return-0-when-object-pointer-is-NULL/20220912-140234
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/linux-mm/1662962379-16174-1-git-send-email-luoben@linux.alibaba.com

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+----------------------------------------------------------+------------+------------+
|                                                          | 2558c2ced7 | fb670abe87 |
+----------------------------------------------------------+------------+------------+
| BUG_kmem_cache_node(Not_tainted):Freechain_corrupt       | 0          | 24         |
| BUG_kmem_cache(Tainted:G_B):Freechain_corrupt            | 0          | 24         |
| BUG_kmem_cache_node(Tainted:G_B):Freechain_corrupt       | 0          | 24         |
| BUG_kmem_cache_node(Tainted:G_B):Freepointer_corrupt     | 0          | 24         |
| BUG_debug_objects_cache(Tainted:G_B):Freechain_corrupt   | 0          | 24         |
| BUG_debug_objects_cache(Tainted:G_B):Freepointer_corrupt | 0          | 24         |
| BUG_vmap_area(Tainted:G_B):Freechain_corrupt             | 0          | 20         |
| BUG_kmalloc-#(Tainted:G_B):Freechain_corrupt             | 0          | 20         |
| BUG_kmalloc-#k(Tainted:G_B):Freechain_corrupt            | 0          | 20         |
| BUG_kmalloc-#(Tainted:G_B):Freepointer_corrupt           | 0          | 20         |
| BUG_radix_tree_node(Tainted:G_B):Freechain_corrupt       | 0          | 14         |
| BUG_pool_workqueue(Tainted:G_B):Freechain_corrupt        | 0          | 14         |
| BUG_trace_event_file(Tainted:G_B):Freechain_corrupt      | 0          | 13         |
| BUG_ftrace_event_field(Tainted:G_B):Freechain_corrupt    | 0          | 13         |
+----------------------------------------------------------+------------+------------+


[    2.980173][    T0] =============================================================================
[    2.981207][    T0] BUG kmem_cache_node (Not tainted): Freechain corrupt
[    2.981954][    T0] -----------------------------------------------------------------------------
[    2.981954][    T0]
[    2.983185][    T0] Slab 0xea3fe800 objects=21 used=21 fp=0x00000000 flags=0x200(slab|zone=0)
[    2.984205][    T0] Object 0xc0100f40 @offset=3904 fp=0x00000000
[    2.984205][    T0]
[    2.985174][    T0] Redzone  c0100f00: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.986268][    T0] Redzone  c0100f10: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.987368][    T0] Redzone  c0100f20: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.988420][    T0] Redzone  c0100f30: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.989412][    T0] Object   c0100f40: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[    2.990420][    T0] Object   c0100f50: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[    2.991436][    T0] Object   c0100f60: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[    2.992505][    T0] Object   c0100f70: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
[    2.993539][    T0] Redzone  c0100f80: bb bb bb bb                                      ....
[    2.994476][    T0] Padding  c0100fb0: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[    2.995639][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc3-00584-gfb670abe8729 #6
[    2.996635][    T0] Call Trace:
[    2.996998][    T0]  ? show_stack+0x35/0x3b
[    2.997511][    T0]  dump_stack_lvl+0x55/0x79
[    2.997986][    T0]  dump_stack+0xd/0x10
[    2.998412][    T0]  print_trailer+0x104/0x10c
[    2.998914][    T0]  object_err+0x2b/0x3f
[    2.999367][    T0]  deactivate_slab.cold+0x13/0x2e
[    2.999925][    T0]  ? __kmem_cache_create+0x16/0xa0
[    3.000519][    T0]  ? kmem_cache_init+0x73/0xe9
[    3.001069][    T0]  ? start_kernel+0x1b8/0x413
[    3.001585][    T0]  ? i386_start_kernel+0x43/0x45
[    3.002122][    T0]  ? alloc_debug_processing+0x41/0x150
[    3.002722][    T0]  ? pcpu_alloc+0x734/0x9d0
[    3.003235][    T0]  ___slab_alloc+0x753/0xc00
[    3.003853][    T0]  ? init_kmem_cache_nodes+0x31/0x210
[    3.004446][    T0]  ? __mutex_unlock_slowpath+0x20/0x290
[    3.005080][    T0]  ? init_kmem_cache_nodes+0x31/0x210
[    3.005676][    T0]  ? rcu_read_lock_sched_held+0xe/0x70
[    3.006282][    T0]  ? pcpu_alloc+0x49f/0x9d0
[    3.006772][    T0]  kmem_cache_alloc+0x3b0/0x480
[    3.007302][    T0]  ? init_kmem_cache_nodes+0x31/0x210
[    3.007874][    T0]  init_kmem_cache_nodes+0x31/0x210
[    3.008436][    T0]  kmem_cache_open+0xf6/0x290
[    3.008933][    T0]  ? kmem_cache_open+0x192/0x290
[    3.009454][    T0]  __kmem_cache_create+0x16/0xa0
[    3.009996][    T0]  create_boot_cache+0x63/0x83
[    3.010526][    T0]  kmem_cache_init+0x73/0xe9
[    3.011186][    T0]  start_kernel+0x1b8/0x413
[    3.011611][    T0]  ? idt_setup_early_handler+0x39/0x4c
[    3.012209][    T0]  i386_start_kernel+0x43/0x45
[    3.012728][    T0]  startup_32_smp+0x161/0x164
[    3.013254][    T0] Disabling lock debugging due to kernel taint
[    3.013911][    T0] FIX kmem_cache_node: Isolate corrupted freechain
...


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202209140949.45a9520d-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-6.0.0-rc3-00584-gfb670abe8729 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--nx16jrpURDKAO4N8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.0.0-rc3-00584-gfb670abe8729"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.0.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23890
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23890
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
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
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
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
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
# CONFIG_STA2X11 is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_IOPL_IOPERM=y
CONFIG_TOSHIBA=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_RETPOLINE=y
# CONFIG_RETHUNK is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PCC is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GOMMCONFIG=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
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
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
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

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_STATS=y
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_SYSFS=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
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
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_PCIE_BUS_TUNE_OFF=y
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
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
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
# CONFIG_CXL_PCI is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_PORT=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
# CONFIG_YENTA_ENE_TUNE is not set
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=y
# CONFIG_I82092 is not set
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
# CONFIG_GOOGLE_VPD is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_RAW_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_HYPERBUS is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HI6421V600_IRQ=y
CONFIG_HP_ILO=y
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
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
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
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
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
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
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5520=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MTK_PMIC=y
CONFIG_KEYBOARD_CYPRESS_SF=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
# CONFIG_MOUSE_PS2_CYPRESS is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=y
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_MAX77650_ONKEY=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_TWL4030_PWRBUTTON=y
# CONFIG_INPUT_TWL4030_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_RK805_PWRKEY=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_IQS626A=y
CONFIG_INPUT_IQS7222=y
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_SOC_BUTTON_ARRAY=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_DTLK=y
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
# CONFIG_NVRAM is not set
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_CHT_WC is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
CONFIG_SCx200_ACB=y
CONFIG_I2C_FSI=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SVC_I3C_MASTER=y
# CONFIG_MIPI_I3C_HCI is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_RK805=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_ELKHARTLAKE is not set
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_SIFIVE=y
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
CONFIG_GPIO_104_DIO_48E=y
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_BD71815=y
CONFIG_GPIO_BD71828=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_JANZ_TTL is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_IP5XXX_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_MR75203=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=y
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_BPA_RS600=y
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_PIM4328=y
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_SENSORS_ASUS_WMI=y
CONFIG_SENSORS_ASUS_WMI_EC=y
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
# CONFIG_CPU_IDLE_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_BD957XMUF_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_MLX_WDT=y
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
# CONFIG_TWL4030_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_SC1200_WDT=y
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_RDC321X_WDT=y
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=y
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD71815=y
CONFIG_REGULATOR_BD71828=y
# CONFIG_REGULATOR_BD718XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_BD957XMUF=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9121=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_HI6421V600 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS68470=y
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
# CONFIG_FB_GEODE_GX is not set
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_CTL_DEBUG=y
CONFIG_SND_JACK_INJECTION_DEBUG=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_MIDI_EMUL=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=y
CONFIG_SND_OPL4_LIB_SEQ=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=y
CONFIG_SND_AD1816A=y
CONFIG_SND_AD1848=y
CONFIG_SND_ALS100=y
CONFIG_SND_AZT1605=y
# CONFIG_SND_AZT2316 is not set
CONFIG_SND_AZT2320=y
# CONFIG_SND_CMI8328 is not set
CONFIG_SND_CMI8330=y
CONFIG_SND_CS4231=y
CONFIG_SND_CS4236=y
CONFIG_SND_ES1688=y
# CONFIG_SND_ES18XX is not set
CONFIG_SND_SC6000=y
CONFIG_SND_GUSCLASSIC=y
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
CONFIG_SND_INTERWAVE=y
# CONFIG_SND_INTERWAVE_STB is not set
CONFIG_SND_JAZZ16=y
CONFIG_SND_OPL3SA2=y
CONFIG_SND_OPTI92X_AD1848=y
CONFIG_SND_OPTI92X_CS4231=y
CONFIG_SND_OPTI93X=y
CONFIG_SND_MIRO=y
CONFIG_SND_SB8=y
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
CONFIG_SND_SSCAPE=y
CONFIG_SND_WAVEFRONT=y
CONFIG_SND_MSND_PINNACLE=y
# CONFIG_SND_MSND_CLASSIC is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_PCMCIA is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_SND_VIRTIO=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_RAZER=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SEMITEK=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
CONFIG_I2C_HID_OF=y
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_RT4505=y
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
CONFIG_LEDS_QCOM_LPG=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82875P=y
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_I5000=y
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=y
CONFIG_STAGING_MEDIA=y
CONFIG_STAGING_BOARD=y
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_NET is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=y
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_TSI148=y
# CONFIG_VME_FAKE is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=y
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=y
CONFIG_MLXREG_LC=y
# CONFIG_NVSW_SN2201 is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_HUAWEI_WMI is not set
CONFIG_MXM_WMI=y
CONFIG_PEAQ_WMI=y
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
CONFIG_XIAOMI_WMI=y
CONFIG_GIGABYTE_WMI=y
CONFIG_YOGABOOK_WMI=y
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=y
# CONFIG_ACER_WMI is not set
CONFIG_ADV_SWBUTTON=y
# CONFIG_APPLE_GMUX is not set
CONFIG_ASUS_LAPTOP=y
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=y
# CONFIG_ASUS_NB_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_EEEPC_LAPTOP is not set
CONFIG_EEEPC_WMI=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=y
CONFIG_WIRELESS_HOTKEY=y
CONFIG_HP_WMI=y
# CONFIG_TC1100_WMI is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
CONFIG_THINKPAD_LMI=y
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
CONFIG_INTEL_SAR_INT1092=y
CONFIG_INTEL_SKL_INT3472=y
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=y
CONFIG_INTEL_PMT_TELEMETRY=y
CONFIG_INTEL_PMT_CRASHLOG=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_INTEL_HID_EVENT=y
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=y
CONFIG_INTEL_MRFLD_PWRBTN=y
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_VSEC=y
CONFIG_MSI_WMI=y
CONFIG_PCENGINES_APU2=y
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_SAMSUNG_Q10=y
CONFIG_ACPI_TOSHIBA=y
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_LG_LAPTOP=y
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_MLX_PLATFORM=y
CONFIG_FW_ATTR_CLASS=y
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=y
CONFIG_INTEL_SCU_IPC_UTIL=y
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_COMMON_CLK_AXI_CLKGEN=y
CONFIG_COMMON_CLK_LOCHNAGAR=y
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
# CONFIG_RPMSG_NS is not set
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_INTEL_CHT_WC is not set
# CONFIG_EXTCON_INTEL_MRFLD is not set
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL367=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD799X=y
CONFIG_ADI_AXI_ADC=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_INTEL_MRFLD_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
# CONFIG_MP2629_ADC is not set
# CONFIG_NAU7802 is not set
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
# CONFIG_RN5T618_ADC is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
# CONFIG_BME680 is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
CONFIG_SCD30_SERIAL=y
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=y
# CONFIG_SPS30_I2C is not set
CONFIG_SPS30_SERIAL=y
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
# CONFIG_CIO_DAC is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
# CONFIG_HID_SENSOR_GYRO_3D is not set
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HDC2010 is not set
CONFIG_HID_SENSOR_HUMIDITY=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP002=y
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=y
CONFIG_NOA1305=y
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
# CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
# CONFIG_SX9310 is not set
CONFIG_SX9324=y
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
CONFIG_PWM_CLK=y
CONFIG_PWM_CRC=y
CONFIG_PWM_DWC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_NTXEC=y
CONFIG_PWM_PCA9685=y
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
CONFIG_XILINX_INTC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
CONFIG_DTPM=y
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=y
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=y
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=y
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
# CONFIG_JFFS2_ZLIB is not set
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
CONFIG_JFFS2_RUBIN=y
CONFIG_JFFS2_CMODE_NONE=y
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
CONFIG_UBIFS_FS_ZLIB=y
# CONFIG_UBIFS_FS_ZSTD is not set
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_MTD=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4hc"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=y
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_SECURITY_LANDLOCK=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_HIFN_795X=y
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
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
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
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
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_REF_TRACKER=y
# end of Library routines

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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_LEVEL=2
# CONFIG_DEBUG_MACRO_DEFINITIONS is not set
CONFIG_DEBUG_INFO_COMPRESSED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
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
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
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
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
CONFIG_NET_NS_REFCNT_TRACKER=y
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
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
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
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
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_FUTEX=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--nx16jrpURDKAO4N8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot-300s.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20220913-031147'
	export commit='fb670abe87296c7b214b6d9f29e9c7380d8d621c'
	export kconfig='i386-randconfig-a001-20220912'
	export nr_vm=160
	export submit_id='63209ec645649813f88bea8e'
	export job_file='/lkp/jobs/scheduled/vm-meta-81/boot-300-quantal-i386-core-20190426.cgz-fb670abe87296c7b214b6d9f29e9c7380d8d621c-20220913-5112-7jy1ac-7.yaml'
	export id='6d5bdc22e94fbf0ad98a94dd43ac2b684bb02e67'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='quantal-i386-core-20190426.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-09-13 23:16:22 +0800'
	export _id='63209ede45649813f88bea95'
	export _rt='/result/boot/300/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-a001-20220912/gcc-11/fb670abe87296c7b214b6d9f29e9c7380d8d621c'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/300/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-a001-20220912/gcc-11/fb670abe87296c7b214b6d9f29e9c7380d8d621c/19'
	export scheduler_version='/lkp/lkp/.src-20220913-142251'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/quantal/quantal-i386-core-20190426.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/300/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-a001-20220912/gcc-11/fb670abe87296c7b214b6d9f29e9c7380d8d621c/19
BOOT_IMAGE=/pkg/linux/i386-randconfig-a001-20220912/gcc-11/fb670abe87296c7b214b6d9f29e9c7380d8d621c/vmlinuz-6.0.0-rc3-00584-gfb670abe8729
branch=linux-devel/devel-hourly-20220913-031147
job=/lkp/jobs/scheduled/vm-meta-81/boot-300-quantal-i386-core-20190426.cgz-fb670abe87296c7b214b6d9f29e9c7380d8d621c-20220913-5112-7jy1ac-7.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a001-20220912
commit=fb670abe87296c7b214b6d9f29e9c7380d8d621c
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
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
	export modules_initrd='/pkg/linux/i386-randconfig-a001-20220912/gcc-11/fb670abe87296c7b214b6d9f29e9c7380d8d621c/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-81'
	export kernel='/pkg/linux/i386-randconfig-a001-20220912/gcc-11/fb670abe87296c7b214b6d9f29e9c7380d8d621c/vmlinuz-6.0.0-rc3-00584-gfb670abe8729'
	export dequeue_time='2022-09-13 23:24:39 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-81/boot-300-quantal-i386-core-20190426.cgz-fb670abe87296c7b214b6d9f29e9c7380d8d621c-20220913-5112-7jy1ac-7.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 300
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--nx16jrpURDKAO4N8
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
0MMBAAAA6Rvf0BQXOzADAAAAAARZWg==

--nx16jrpURDKAO4N8--
