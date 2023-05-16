Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB1704599
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEPGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjEPGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:53:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056085248;
        Mon, 15 May 2023 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684219960; x=1715755960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ThSA81apsiXzPt/TJm93MV3zRTE/BtQ8WferUSqtmrs=;
  b=mBs4+i7e39ldzcSfde11GK4pSInfzVBdTTc6LmTxB9NBiBXyJ2t408lL
   zworW3+Km+OUa3Kva6BSJD4uOZSV4T4RTwGKnvW9QRcQh6ueUla7AnvRE
   T2SFZ32nXSC2O+RUiiHZzBDdOSe8o4NwQ2TTP17wIOCrDxHuZUfLOENq/
   R4s8Vbi7hDvSUCZ0SJLuzuYt/Ug0kDoEeVgwg+QhbXx0xB8nEvliRWvYc
   vSccuxKl2O4F2vvJNcg/LDwzsGHx2jG9blZlhEkahfN7FDp93lesA7OH4
   62UcHIrzNzf6j6GbX61Sf7KWhJJXah85YlyAOYKblkpHqXTK8MF1e//n6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437740264"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="437740264"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 23:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="770922200"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="770922200"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2023 23:52:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 23:52:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 23:52:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 23:52:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 23:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhfDDhRhQB441uL354fbk7M43hTDibuEmyfoiFoNBP3tRXeaXk1XO7uX+SY5p2r5Czo/AwiebuwzCFazrvW7rcMqIHr6SFHHg7YJzko8bK+Hrva5qa4Lt6x2DE55FAV/SkY8lkVDYSKxyvHeJqI1R7y7HVBeQZHEun17C8KGrfm9Wb0UIX6Dt3MHaSVpMrgyQNcJKU9Zuz7soAmhLZVMfED4mRteUJWm+Gi1DwFUM5ml5WI+KXEE+/HD9f+/mcG/VQ6/q8zPhLSslpE8nH1W1UZXFJ2/rFIL/7mm9GPYCEReh2xxQhqX8vWSjAz7w4yrs0hn6WP4mdaLQlK7tFmxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXgmY0Pys0f3cEbwKzCalURnJBfuaxMX85iEZjzaVG4=;
 b=fdR2reYQdi1Dzi8lrlIMO1AT/GQGEwW9RiMBuT+2KeDIYybTzjLTZyoz9pRjeDAxZtGekrZSXAIWIkAiv9ybd8ZtuoRh1TH5vTlaY8g7cIbT4C0vUfR0oQSOd7tg7HoRM2zanhcQQDgpLE7p/3uIp1nU4b8AE7Ocbvbjgva0GSCWeknXKdoDoIt68MZwJnqeK5JPn99vB0AfBfTYPgG5DBJ11TFgVTFcZnmBDJ7ah0J3mN+JC319Zbe03pi98zAx/XwHGIRD9/+PWptavYqeLd650epYdDH+1vbgkCCsMZH6yGpGTDs4ssO3CKYjfi5+6YS8dOskmFtGtkbV5e943w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5494.namprd11.prod.outlook.com (2603:10b6:208:31d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 06:52:08 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 06:52:08 +0000
Date:   Tue, 16 May 2023 14:48:40 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Ian Rogers <irogers@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Athira Rajeev" <atrajeev@linux.vnet.ibm.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "Florian Fischer" <florian.fischer@muhq.space>,
        Ingo Molnar <mingo@redhat.com>,
        "James Clark" <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi Bangoria" <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Stephane Eranian <eranian@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>
Subject: [linus:master] [perf vendor events intel] aa2050030d:
 perf-sanity-tests.perf_all_metricgroups_test.fail
Message-ID: <202305161412.9fb7dc07-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="PSbc1JmETRt9H6EQ"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e247d5-50ac-4dd3-4142-08db55da1080
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zas8mUFlmElbfBJehhBjtzaXBIHgXg/fp4O0eufdoD3dOdo1+DM1Hg+mvkUmkh6pqSJTqRxYcn0QKOgge/tu16vcTp3vYsOnSO0xFlGcYdhIMOgsrmgGut3GCyBd0te562TVipQ/BipTgdFdmPn+EtrfF1ZGAAgcmtxiHlrnlqlWJ8ddJYryMMyVzHZvRqxIUdI6jCniqVq5au8FCzX6cJSgXzTIzOMSD0QgYLElckX5VHYn5GXo6NoIT4ag/3e7wkFpPh8wGnO5QSIeLwh7EWIU0qGs+scBQWMxnXMN9R2a4i67bGmXhHU4oepbuvriusMyiCCxhOygcgULNnQehhMyx0JJy/Mh3ZR0NHyp9DK+LSL2948NSqZlPQiCu0jKrfxNNh4w/1a0j7C13WwLuKPP+MQ83OgtbNdJasWQ+cSmcPUkLp1fjgSk5RFA52CkrxxFrqnAomGu1SDUrxc8UZYbA0VqbGLDS99+njaoJVOpuxsNK1PWz5YCoyIuBPm9cm5L0rXE93qNTfytoD9IuWsqABtVFC+iDCGg4UI2oUhSj/3obLzaJOpaipiSjosSw5ZiSj9+3pbS1eV2ltZOP0gwvyWwP7BiZZtfOie3ADdcPYxvjRo6dLdQ/oVxc4SyE26OMlhdF5xprwc5ZUSF2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(8676002)(235185007)(5660300002)(8936002)(7416002)(21490400003)(2616005)(83380400001)(966005)(1076003)(6506007)(186003)(26005)(82960400001)(6512007)(38100700002)(86362001)(478600001)(54906003)(6486002)(6666004)(44144004)(66946007)(66556008)(66476007)(316002)(41300700001)(6916009)(4326008)(36756003)(30864003)(2906002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QKU2omXLtxcHBswwG066lXvO1A7qxmeUNRno2NCnKydagy7AnmbMEw5aMHD?=
 =?us-ascii?Q?PYcA7tCaVPuS34kVcICEXX+sCKqsKDfO6P19ra+CduTbuoasYJBWknDERVDX?=
 =?us-ascii?Q?LnvPRks41PkoGtRo5fjwfkMQ1DWb23JA2RrBETcWR7vYxSl4qoNkEgQ/9xed?=
 =?us-ascii?Q?NuEE8rUQ2tpeQcMUM48esiWGC5w5EtW3dY4DqMXFwHxQJ6iHkXGOLwsOIu0b?=
 =?us-ascii?Q?fX5eEOQLi5z1/HUHTtyoUSeEqtTiXlSg2li4tZqQvCdayVbH21qskVX7Ac0J?=
 =?us-ascii?Q?eKfPO111XjI96rRkzzy7i8TtF0vvf6oB87is5AGG0NfRFaMcx+MhiGKdRE/b?=
 =?us-ascii?Q?ZTsbg7xhujNsht62+QXIurQOlsdHiu5xtBju+jw8XmDmzKpDCfbtMctJLiZc?=
 =?us-ascii?Q?nxZQbuUa3WOAPCy2vJQL9+StMzf3D4tnx2eA97LAX+OlK9PH/zKbDXi6GXwi?=
 =?us-ascii?Q?YRhp6KGVXOlXETb9Z7JhSsqHzZDHaQv5SF6VBD53dZPV17vgmPbqnvkuzm2R?=
 =?us-ascii?Q?mkZqs107d05HranoFOKtSInCmC/f7SJJK4vMXRCi6M/auXt9LVx4PndYb/O9?=
 =?us-ascii?Q?qktB/QUuDGnSXSaUAM97o8J8YkVYB6OmjuMN27OT6tvZCFdidFY5jEeMl1sy?=
 =?us-ascii?Q?rZ6FrX/2VY0O1edafbxHLQJnq0o+WjEgnyxK9Pskn9cx9Po7+st5TuO+EFDG?=
 =?us-ascii?Q?vdQVisf+aPi4o/Nky9FCoDkfAXjhPNU5cvoq5YGACDKMa2K2qYdQeZ7eM5TF?=
 =?us-ascii?Q?O2MPSBIpoAitOHV8aLdjifjdcqugKila8Dqy+/9XwD5MqiEINtniksCZpnLC?=
 =?us-ascii?Q?vegWPRrigPexjq8kpiNOSgPtaWkzvTqB1VILGX2V33Eyu3tffjd1ftD7W+iz?=
 =?us-ascii?Q?BJA64kEJIf62lXeRmml/IQvHkQ1EsqRYiKE5r+8ZYZVxCOAyLpq13voP/raM?=
 =?us-ascii?Q?r/qcnSsU0SBFo6S0Ap+0RN4CX/7tqbz4OADAmhFjON97YCHHQEMuS1ha4mTW?=
 =?us-ascii?Q?rh87zGlG6SpFo6mPXpqRx9si5YX5T9HdWLCQh4fAhKPVn+w7iqtQDNWNJpos?=
 =?us-ascii?Q?35BN5xy7IVVTPu+Q24fvkk0wPUtYR9myCbSqC6z3Yol3IZuFdY9C1kSA+KMv?=
 =?us-ascii?Q?esbhvGNN7Bkoa7n6yCqGSy9ynupjDhtXPX+6Qnk37ClobO0c+WeqpIpt/SsX?=
 =?us-ascii?Q?lshm0sRYBoapok0oqe1FdMkVeELZJrU1nQ2JnzthHPVhEALjagHLUEKG8zTU?=
 =?us-ascii?Q?ISpR6UDUrKOiHaZjFU8HLpU3aypRKbCxiUjdbrD9KcgtOqVIM+zBdIjGmP4A?=
 =?us-ascii?Q?Owcl3owlAl/21RmlKBH/L0Cjp0XmWu1B8zf1RS3XBH07acne8mM6Pf11d1Xn?=
 =?us-ascii?Q?K4NKTMM5tEZcaqpF4EYXavm6cejIN175UDQXA4pR0ropALX3Fe6+vOYi1kOW?=
 =?us-ascii?Q?91LbmLKMkqzJmYQLwDy1hlzuMS2tqbqQrraxHs/WTXXHEQ3rb7QrhPXUJAGF?=
 =?us-ascii?Q?U4VdAJm5RcVJMvt6D/f7ouFHx9gsczEXy99Nfisq2+9VmC5Cwe1TkfwOX409?=
 =?us-ascii?Q?JKsNFD11zXA+EpaQrpgmU4NTgJ/Ljr6tGv0nS2zl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e247d5-50ac-4dd3-4142-08db55da1080
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 06:52:07.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFjDEeXvEclcxCUmpIWx4YWg9GTjTcbkU7H77xLeGvq/j2MvdQCwJj0uLm5z1uk4HSGK0APTznCEVCMDxSAJWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PSbc1JmETRt9H6EQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello,

kernel test robot noticed "perf-sanity-tests.perf_all_metricgroups_test.fail" on:

commit: aa2050030d65777596498256acd5f1584421e33a ("perf vendor events intel: Refresh sapphirerapids events")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master aabe491169befbe5481144acf575a0260939764a]

in testcase: perf-sanity-tests

test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202305161412.9fb7dc07-yujie.liu@intel.com


2023-05-11 16:00:41 sudo tools/perf/perf test 101
101: perf all metricgroups test                                      : FAILED!

$ make -j224 WERROR=0 LIBCLANGLLVM=1 CXXFLAGS+=-Wno-class-memaccess EXTRA_CXXFLAGS+=-Wno-class-memaccess ARCH= EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address -Wno-array-bounds'

$ ./perf test -v 101
101: perf all metricgroups test
...
=================================================================
==37235==ERROR: LeakSanitizer: detected memory leaks

Indirect leak of 2744 byte(s) in 1 object(s) allocated from:
    #0 0x7f0110d45037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x564efd406cf4 in zalloc (tools/perf/perf+0x221ecf4)
    #2 0x564efcd28894 in evlist__new util/evlist.c:83
    #3 0x564efce2116c in parse_ids util/metricgroup.c:1404
    #4 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #5 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #6 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #7 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #8 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #9 0x564efc985809 in run_argv tools/perf/perf.c:428
    #10 0x564efc985809 in main tools/perf/perf.c:562
    #11 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 2368 byte(s) in 4 object(s) allocated from:
    #0 0x7f0110d45037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x564efd406cf4 in zalloc (tools/perf/perf+0x221ecf4)
    #2 0x564efcd4faad in evsel__new_idx util/evsel.c:296
    #3 0x564efcd8c8ce in __add_event util/parse-events.c:258
    #4 0x564efcdb02e8 in parse_events_add_pmu util/parse-events.c:1551
    #5 0x564efcdb36a3 in parse_events_multi_pmu_add util/parse-events.c:1622
    #6 0x564efcf61ff3 in parse_events_parse util/parse-events.y:368
    #7 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #8 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #9 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #10 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #11 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #12 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #13 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #14 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #15 0x564efc985809 in run_argv tools/perf/perf.c:428
    #16 0x564efc985809 in main tools/perf/perf.c:562
    #17 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 592 byte(s) in 1 object(s) allocated from:
    #0 0x7f0110d45037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x564efd406cf4 in zalloc (tools/perf/perf+0x221ecf4)
    #2 0x564efcd4faad in evsel__new_idx util/evsel.c:296
    #3 0x564efcd97faf in __add_event util/parse-events.c:258
    #4 0x564efcd97faf in add_event_tool util/parse-events.c:313
    #5 0x564efcd97faf in parse_events_add_tool util/parse-events.c:1402
    #6 0x564efcf60c2b in parse_events_parse util/parse-events.y:480
    #7 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #8 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #9 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #10 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #11 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #12 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #13 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #14 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #15 0x564efc985809 in run_argv tools/perf/perf.c:428
    #16 0x564efc985809 in main tools/perf/perf.c:562
    #17 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 160 byte(s) in 4 object(s) allocated from:
    #0 0x7f0110d45037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x564efd406cf4 in zalloc (tools/perf/perf+0x221ecf4)
    #2 0x564efcd8ff51 in get_config_terms util/parse-events.c:1229
    #3 0x564efcdaf91e in parse_events_add_pmu util/parse-events.c:1531
    #4 0x564efcdb36a3 in parse_events_multi_pmu_add util/parse-events.c:1622
    #5 0x564efcf61ff3 in parse_events_parse util/parse-events.y:368
    #6 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #7 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #8 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #9 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #10 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #11 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #12 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #13 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #14 0x564efc985809 in run_argv tools/perf/perf.c:428
    #15 0x564efc985809 in main tools/perf/perf.c:562
    #16 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 110 byte(s) in 4 object(s) allocated from:
    #0 0x7f0110cf2817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x564efce21772 in decode_all_metric_ids util/metricgroup.c:602
    #2 0x564efce21772 in parse_ids util/metricgroup.c:1416
    #3 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #4 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #5 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #6 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #7 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #8 0x564efc985809 in run_argv tools/perf/perf.c:428
    #9 0x564efc985809 in main tools/perf/perf.c:562
    #10 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 110 byte(s) in 4 object(s) allocated from:
    #0 0x7f0110cf2817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x564efce21924 in decode_all_metric_ids util/metricgroup.c:630
    #2 0x564efce21924 in parse_ids util/metricgroup.c:1416
    #3 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #4 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #5 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #6 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #7 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #8 0x564efc985809 in run_argv tools/perf/perf.c:428
    #9 0x564efc985809 in main tools/perf/perf.c:562
    #10 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 16 byte(s) in 4 object(s) allocated from:
    #0 0x7f0110cf2817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x564efcdb0395 in parse_events_add_pmu util/parse-events.c:1561
    #2 0x564efcdb36a3 in parse_events_multi_pmu_add util/parse-events.c:1622
    #3 0x564efcf61ff3 in parse_events_parse util/parse-events.y:368
    #4 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #5 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #6 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #7 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #8 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #9 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #10 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #11 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #12 0x564efc985809 in run_argv tools/perf/perf.c:428
    #13 0x564efc985809 in main tools/perf/perf.c:562
    #14 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 14 byte(s) in 1 object(s) allocated from:
    #0 0x7f0110cf2817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x564efcd9c0a9 in parse_events_name util/parse-events.c:1991
    #2 0x564efcf61307 in parse_events_parse util/parse-events.y:266
    #3 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #4 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #5 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #6 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #7 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #8 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #9 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #10 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #11 0x564efc985809 in run_argv tools/perf/perf.c:428
    #12 0x564efc985809 in main tools/perf/perf.c:562
    #13 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 12 byte(s) in 1 object(s) allocated from:
    #0 0x7f0110d44e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x564efd3eadad in perf_cpu_map__alloc (tools/perf/perf+0x2202dad)
    #2 0x564efd3eb378 in cpu_map__trim_new (tools/perf/perf+0x2203378)
    #3 0x564efd3ecc5e in perf_cpu_map__new (tools/perf/perf+0x2204c5e)
    #4 0x564efcd97f46 in __add_event util/parse-events.c:247
    #5 0x564efcd97f46 in add_event_tool util/parse-events.c:313
    #6 0x564efcd97f46 in parse_events_add_tool util/parse-events.c:1402
    #7 0x564efcf60c2b in parse_events_parse util/parse-events.y:480
    #8 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #9 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #10 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #11 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #12 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #13 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #14 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #15 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #16 0x564efc985809 in run_argv tools/perf/perf.c:428
    #17 0x564efc985809 in main tools/perf/perf.c:562
    #18 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 4 byte(s) in 4 object(s) allocated from:
    #0 0x7f0110cf2817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x564efcdb0688 in parse_events_add_pmu util/parse-events.c:1569
    #2 0x564efcdb36a3 in parse_events_multi_pmu_add util/parse-events.c:1622
    #3 0x564efcf61ff3 in parse_events_parse util/parse-events.y:368
    #4 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #5 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #6 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #7 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #8 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #9 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #10 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #11 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #12 0x564efc985809 in run_argv tools/perf/perf.c:428
    #13 0x564efc985809 in main tools/perf/perf.c:562
    #14 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 3 byte(s) in 1 object(s) allocated from:
    #0 0x7f0110cf2817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x564efcd98377 in add_event_tool util/parse-events.c:324
    #2 0x564efcd98377 in parse_events_add_tool util/parse-events.c:1402
    #3 0x564efcf60c2b in parse_events_parse util/parse-events.y:480
    #4 0x564efcd9f39f in parse_events__scanner util/parse-events.c:2188
    #5 0x564efcd9f39f in __parse_events util/parse-events.c:2260
    #6 0x564efce21254 in parse_ids util/metricgroup.c:1411
    #7 0x564efce26c4a in parse_groups util/metricgroup.c:1463
    #8 0x564efce2b3f4 in metricgroup__parse_groups util/metricgroup.c:1589
    #9 0x564efca11a70 in cmd_stat tools/perf/builtin-stat.c:2519
    #10 0x564efccb1ea7 in run_builtin tools/perf/perf.c:330
    #11 0x564efccb2a89 in handle_internal_command tools/perf/perf.c:384
    #12 0x564efc985809 in run_argv tools/perf/perf.c:428
    #13 0x564efc985809 in main tools/perf/perf.c:562
    #14 0x7f010feecd09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

SUMMARY: AddressSanitizer: 6133 byte(s) leaked in 29 allocation(s).
test child finished with -1
---- end ----
perf all metricgroups test: FAILED!


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--PSbc1JmETRt9H6EQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc7-00145-gaa2050030d65"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc7 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
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
# CONFIG_WATCH_QUEUE is not set
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
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
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
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=y
CONFIG_BPF_LSM=y
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
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
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
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
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
CONFIG_CGROUP_BPF=y
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
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
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
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
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
CONFIG_X86_CPU_RESCTRL=y
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
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_P6_NOP=y
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
CONFIG_X86_MSR=y
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
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
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
CONFIG_PHYSICAL_ALIGN=0x1000000
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
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
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
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
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
CONFIG_CPU_IDLE_GOV_LADDER=y
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
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
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
CONFIG_HAVE_IMA_KEXEC=y
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
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
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
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
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
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
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
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
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
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
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
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
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
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
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
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
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
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
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
# CONFIG_DEFAULT_CUBIC is not set
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_TCP_CONG="reno"
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
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
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
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
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
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
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
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
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
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
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
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
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
CONFIG_BPF_STREAM_PARSER=y
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
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
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
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
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
CONFIG_PCI_HYPERV=m
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
CONFIG_PCI_HYPERV_INTERFACE=m

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
CONFIG_FW_UPLOAD=y
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
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
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
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
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
# CONFIG_ZRAM_MULTI_COMP is not set
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
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
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

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
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
CONFIG_HYPERV_STORAGE=m
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
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
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
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
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
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
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
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
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
# CONFIG_CAN_DEV is not set
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
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
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
# CONFIG_INPUT_MISC is not set
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
CONFIG_HYPERV_KEYBOARD=m
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
CONFIG_LEGACY_TIOCSTI=y
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
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
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
# CONFIG_SERIAL_JSM is not set
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
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
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
# CONFIG_SPI_PCI1XXXX is not set
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
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
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
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
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
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
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
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
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
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
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
CONFIG_IR_SHARP_DECODER=m
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
CONFIG_RC_LOOPBACK=m
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
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=m
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
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
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
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
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
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
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
CONFIG_FB_MODE_HELPERS=y
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
# CONFIG_FB_INTEL is not set
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
CONFIG_FB_HYPERV=m
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

# CONFIG_DRM_ACCEL is not set
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
CONFIG_HID_HYPERV_MOUSE=m
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
CONFIG_ZEROPLUS_FF=y
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
# CONFIG_INTEL_ISH_HID is not set
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
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
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

#
# USB dual-mode controller drivers
#
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
# CONFIG_USB_SERIAL is not set

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
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
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
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
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
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_EFI_SECRET is not set
CONFIG_TDX_GUEST_DRIVER=m
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
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
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
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
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
# CONFIG_HWSPINLOCK is not set

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
CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_TEST=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
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
CONFIG_GENERIC_PHY=y
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
# CONFIG_NVDIMM_SECURITY_TEST is not set
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
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
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
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
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
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
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
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
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
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
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
CONFIG_PROC_CPU_RESCTRL=y
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
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
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
# CONFIG_MINIX_FS is not set
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
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
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
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
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
# CONFIG_CEPH_FS is not set
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
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
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
# CONFIG_DLM is not set
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
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
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
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
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
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
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
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=m
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
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
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
CONFIG_CRYPTO_USER_API_HASH=m
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
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
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
CONFIG_PRIME_NUMBERS=m
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
CONFIG_CRYPTO_LIB_GF128MUL=y
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
CONFIG_INTERVAL_TREE_SPAN_ITER=y
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
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
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
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
CONFIG_FONT_MINI_4x6=y
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_TER16x32 is not set
# CONFIG_FONT_6x8 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
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
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
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
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
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
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_PAGE_OWNER is not set
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
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
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
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
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
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
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
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
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
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
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
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_FPROBE is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
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
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_FUNCTION=y
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
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
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--PSbc1JmETRt9H6EQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='perf-sanity-tests'
	export testcase='perf-sanity-tests'
	export category='functional'
	export need_memory='2G'
	export job_origin='perf-sanity-tests.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='lkp-spr-2sp1'
	export tbox_group='lkp-spr-2sp1'
	export submit_id='645d025866c23265db3a7313'
	export job_file='/lkp/jobs/scheduled/lkp-spr-2sp1/perf-sanity-tests-clang-debian-11.1-x86_64-20220510.cgz-aa2050030d65777596498256acd5f1584421e33a-20230511-26075-1f9ry8g-0.yaml'
	export id='1a854cfd1848f3c668862285d0589ff02f6290db'
	export queuer_version='/zday/lkp'
	export model='Sapphire Rapids'
	export nr_node=2
	export nr_cpu=224
	export memory='256G'
	export nr_ssd_partitions=6
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401J94P0IGN-part*'
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ207201DG1P0FGN-part4'
	export kernel_cmdline_hw='acpi_rsdp=0x777fe014'
	export brand='Intel(R) Xeon(R) Platinum 8480+'
	export initrds='linux_perf'
	export commit='aa2050030d65777596498256acd5f1584421e33a'
	export ucode='0x2b000181'
	export kconfig='x86_64-rhel-8.3-bpf'
	export enqueue_time='2023-05-11 22:57:30 +0800'
	export _id='645d025866c23265db3a7313'
	export _rt='/result/perf-sanity-tests/clang/lkp-spr-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='6242c02bd1883e42ab204b175ea2562d7c646180'
	export base_commit='ac9a78681b921877518763ba0e89202254349d1b'
	export branch='internal-devel/devel-hourly-20230509-140013'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/perf-sanity-tests/clang/lkp-spr-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/0'
	export scheduler_version='/lkp/lkp/.src-20230511-163851'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/perf-sanity-tests/clang/lkp-spr-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/vmlinuz-6.2.0-rc7-00145-gaa2050030d65
branch=internal-devel/devel-hourly-20230509-140013
job=/lkp/jobs/scheduled/lkp-spr-2sp1/perf-sanity-tests-clang-debian-11.1-x86_64-20220510.cgz-aa2050030d65777596498256acd5f1584421e33a-20230511-26075-1f9ry8g-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-bpf
commit=aa2050030d65777596498256acd5f1584421e33a
initcall_debug
nmi_watchdog=0
acpi_rsdp=0x777fe014
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/modules.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/linux-perf.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.4.0-rc1-00668-g6242c02bd188'
	export kernel='/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/vmlinuz-6.2.0-rc7-00145-gaa2050030d65'
	export dequeue_time='2023-05-11 23:55:12 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-spr-2sp1/perf-sanity-tests-clang-debian-11.1-x86_64-20220510.cgz-aa2050030d65777596498256acd5f1584421e33a-20230511-26075-1f9ry8g-0.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test perf_compiler='clang' $LKP_SRC/tests/wrapper perf-sanity-tests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env perf_compiler='clang' $LKP_SRC/stats/wrapper perf-sanity-tests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time perf-sanity-tests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--PSbc1JmETRt9H6EQ
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AbbbAeHxC3u+CnuxxGf7AgAAAAAEWVo=

--PSbc1JmETRt9H6EQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="perf-sanity-tests"
Content-Transfer-Encoding: quoted-printable

2023-05-11 15:57:16 make -j224 WERROR=3D0 LIBCLANGLLVM=3D1 CXXFLAGS+=3D-Wno=
-class-memaccess EXTRA_CXXFLAGS+=3D-Wno-class-memaccess ARCH=3D EXTRA_CFLAG=
S=3D-fno-omit-frame-pointer -fsanitize=3Dundefined -fsanitize=3Daddress -Wn=
o-array-bounds -C /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d657=
77596498256acd5f1584421e33a/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa205=
0030d65777596498256acd5f1584421e33a/tools/perf'
  BUILD:   Doing 'make =1B[33m-j224=1B[m' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-ind=
ex.h
diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm=
.h

Auto-detecting system features:
...                                   dwarf: [ =1B[32mon=1B[m  ]
...                      dwarf_getlocations: [ =1B[32mon=1B[m  ]
...                                   glibc: [ =1B[32mon=1B[m  ]
...                                  libbfd: [ =1B[32mon=1B[m  ]
...                          libbfd-buildid: [ =1B[32mon=1B[m  ]
...                                  libcap: [ =1B[32mon=1B[m  ]
...                                  libelf: [ =1B[32mon=1B[m  ]
...                                 libnuma: [ =1B[32mon=1B[m  ]
...                  numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
...                                 libperl: [ =1B[32mon=1B[m  ]
...                               libpython: [ =1B[32mon=1B[m  ]
...                               libcrypto: [ =1B[32mon=1B[m  ]
...                               libunwind: [ =1B[32mon=1B[m  ]
...                      libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
...                                    zlib: [ =1B[32mon=1B[m  ]
...                                    lzma: [ =1B[32mon=1B[m  ]
...                               get_cpuid: [ =1B[32mon=1B[m  ]
...                                     bpf: [ =1B[32mon=1B[m  ]
...                                  libaio: [ =1B[32mon=1B[m  ]
...                                 libzstd: [ =1B[32mon=1B[m  ]

  GEN     common-cmds.h
  CC      jvmti/libjvmti.o
  CC      jvmti/jvmti_agent.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  GEN     perf-archive
  GEN     perf-iostat
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-show-cycles.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/include/api/cpu.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/include/api/debug.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/include/api/io.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/include/api/fd/array.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/include/api/fs/fs.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/include/api/fs/tracing_path.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/cpu.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/debug.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/str_error_r.o
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fd/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fd/array.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/tracing_path.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/cgroup.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/fs.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/include/subcmd/help.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/include/subcmd/parse-options.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/include/subcmd/run-command.h
  INSTALL libapi_headers
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/exec-cmd.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/help.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/parse-options.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/pager.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/bpf_perf.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/sigchain.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/run-command.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/subcmd-config.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/core.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/cpumap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/threadmap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/evlist.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/mmap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/evsel.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/perf/event.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/core.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/cpumap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/evlist.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/mmap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/evsel.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/threadmap.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/threadmap.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/lib.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/cpumap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/evlist.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/evsel.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/include/internal/xyarray.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/zalloc.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/mmap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/xyarray.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/lib.o
  LINK    dlfilters/dlfilter-test-api-v0.so
  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  LINK    dlfilters/dlfilter-show-cycles.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsymbol/include/symbol/kallsyms.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsymbol/kallsyms.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fd/libapi-in.o
  INSTALL libsymbol_headers
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/fs/libapi-in.o
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/bpf_helper_defs.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/bpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/libbpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/btf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/usdt.bpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/libbpf_version.h
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/libapi-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libapi/libapi.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsymbol/libsymbol-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsymbol/libsymbol.a
  LD      jvmti/jvmti-in.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  INSTALL libbpf_headers
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/bpf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/libbpf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/btf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/nlattr.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/strset.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/str_error.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/linker.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/netlink.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/usdt.o
  LINK    libperf-jvmti.so
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/libperf-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libperf/libperf.a
  GEN     python/perf.cpython-39-x86_64-linux-gnu.so
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/libsubcmd-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libsubcmd/libsubcmd.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498=
256acd5f1584421e33a/tools/perf/libbpf/libbpf.a
  CC      builtin-bench.o
  CC      builtin-annotate.o
  CC      builtin-config.o
  CC      builtin-diff.o
  CC      builtin-evlist.o
  CC      builtin-ftrace.o
  CC      builtin-help.o
  CC      builtin-buildid-list.o
  CC      builtin-buildid-cache.o
  CC      builtin-kallsyms.o
  CC      builtin-list.o
  CC      builtin-record.o
  CC      builtin-report.o
  CC      builtin-stat.o
  CC      builtin-top.o
  CC      builtin-script.o
  CC      builtin-kvm.o
  CC      builtin-inject.o
  CC      builtin-mem.o
  CC      builtin-data.o
  CC      builtin-version.o
  CC      builtin-c2c.o
  CC      builtin-daemon.o
  CC      builtin-kmem.o
  CC      builtin-kwork.o
  CC      builtin-lock.o
  CC      builtin-sched.o
  CC      builtin-timechart.o
  CC      builtin-trace.o
  CC      builtin-probe.o
  CC      trace/beauty/clone.o
  CC      perf.o
  CC      trace/beauty/flock.o
  CC      trace/beauty/fcntl.o
  CC      trace/beauty/fsmount.o
  CC      bench/sched-messaging.o
  CC      arch/common.o
  CC      tests/builtin-test.o
  CC      trace/beauty/fspick.o
  CC      trace/beauty/ioctl.o
  CC      bench/sched-pipe.o
  CC      bench/syscall.o
  CC      ui/setup.o
  CC      tests/parse-events.o
  CC      tests/builtin-test-list.o
  CC      ui/helpline.o
  CC      trace/beauty/kcmp.o
  CC      bench/futex-hash.o
  CC      ui/progress.o
  CC      bench/mem-functions.o
  CC      tests/dso-data.o
  CC      trace/beauty/mount_flags.o
  CC      trace/beauty/move_mount.o
  CC      tests/attr.o
  CC      trace/beauty/pkey_alloc.o
  CC      bench/futex-wake.o
  CC      bench/futex-wake-parallel.o
  CC      ui/hist.o
  CC      ui/util.o
  CC      tests/vmlinux-kallsyms.o
  CC      ui/stdio/hist.o
  CC      bench/futex-requeue.o
  CC      trace/beauty/arch_prctl.o
  CC      ui/browser.o
  CC      tests/openat-syscall.o
  CC      trace/beauty/prctl.o
  CC      tests/openat-syscall-all-cpus.o
  CC      trace/beauty/renameat.o
  CC      tests/openat-syscall-tp-fields.o
  CC      bench/epoll-wait.o
  CC      tests/mmap-basic.o
  CC      trace/beauty/sockaddr.o
  CC      bench/futex-lock-pi.o
  CC      bench/epoll-ctl.o
  CC      tests/perf-record.o
  CC      trace/beauty/socket.o
  CC      bench/synthesize.o
  CC      tests/evsel-roundtrip-name.o
  CC      trace/beauty/statx.o
  CC      bench/kallsyms-parse.o
  CC      bench/find-bit-bench.o
  CC      scripts/perl/Perf-Trace-Util/Context.o
  CC      trace/beauty/sync_file_range.o
  CC      tests/evsel-tp-sched.o
  CC      bench/inject-buildid.o
  CC      trace/beauty/timespec.o
  CC      tests/fdarray.o
  CC      bench/evlist-open-close.o
  CC      bench/breakpoint.o
  CC      tests/pmu.o
  CC      scripts/python/Perf-Trace-Util/Context.o
  CC      tests/pmu-events.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      bench/mem-memcpy-x86-64-asm.o
  CC      tests/hists_common.o
  CC      tests/hists_link.o
  CC      bench/numa.o
  CC      tests/hists_filter.o
  CC      tests/hists_output.o
  CC      tests/hists_cumulate.o
  CC      ui/browsers/annotate.o
  CC      ui/tui/setup.o
  CC      ui/tui/util.o
  CC      tests/python-use.o
  CC      tests/bp_signal.o
  CC      ui/browsers/hists.o
  CC      ui/tui/helpline.o
  CC      tests/wp.o
  CC      ui/browsers/map.o
  CC      tests/bp_signal_overflow.o
  CC      ui/tui/progress.o
  CC      ui/browsers/scripts.o
  CC      tests/bp_account.o
  CC      ui/browsers/header.o
  CC      ui/browsers/res_sample.o
  CC      tests/task-exit.o
  CC      tests/sw-clock.o
  CC      tests/mmap-thread-lookup.o
  CC      trace/beauty/tracepoints/x86_irq_vectors.o
  CC      tests/switch-tracking.o
  CC      tests/thread-maps-share.o
  CC      trace/beauty/tracepoints/x86_msr.o
  CC      tests/keep-tracking.o
  CC      arch/x86/util/tsc.o
  CC      arch/x86/tests/regs_load.o
  CC      arch/x86/util/pmu.o
  CC      tests/code-reading.o
  CC      arch/x86/util/header.o
  CC      arch/x86/tests/dwarf-unwind.o
  TEST    pmu-events/metric_test.log
  CC      tests/sample-parsing.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/util/perf_regs.o
  CC      arch/x86/tests/insn-x86.o
  CC      arch/x86/util/topdown.o
  CC      arch/x86/tests/sample-parsing.o
  CC      tests/kmod-path.o
  CC      arch/x86/util/kvm-stat.o
  CC      tests/thread-map.o
  CC      arch/x86/util/machine.o
  CC      arch/x86/tests/intel-pt-test.o
  CC      tests/parse-no-sample-id-all.o
  CC      arch/x86/tests/bp-modify.o
  CC      tests/llvm.o
  CC      arch/x86/util/event.o
  CC      arch/x86/util/evlist.o
  CC      arch/x86/util/mem-events.o
  CC      arch/x86/util/evsel.o
  CC      arch/x86/util/iostat.o
  CC      tests/bpf.o
  CC      arch/x86/util/dwarf-regs.o
  CC      tests/mem.o
  CC      arch/x86/util/unwind-libunwind.o
  CC      tests/topology.o
  CC      tests/cpumap.o
  CC      arch/x86/util/auxtrace.o
  CC      arch/x86/util/archinsn.o
  CC      tests/stat.o
  CC      tests/event-times.o
  CC      tests/event_update.o
  CC      arch/x86/util/intel-pt.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/expr.o
  CC      tests/backward-ring-buffer.o
  CC      tests/sdt.o
  CC      tests/is_printable_array.o
  CC      tests/bitmap.o
  CC      tests/perf-hooks.o
  CC      tests/clang.o
  CC      tests/unit_number__scnprintf.o
  CC      tests/mem2node.o
  CC      tests/maps.o
  CC      tests/time-utils-test.o
  CC      tests/genelf.o
  CC      tests/api-io.o
  CC      tests/demangle-java-test.o
  CC      tests/demangle-ocaml-test.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  CC      tests/expand-cgroup.o
  CC      tests/perf-time-to-tsc.o
  CC      tests/pe-file-parsing.o
  CC      tests/dlfilter-test.o
  CC      tests/sigtrap.o
  CC      tests/event_groups.o
  CC      tests/symbols.o
  CC      tests/dwarf-unwind.o
  CC      tests/workloads/noploop.o
  CC      tests/workloads/thloop.o
  CC      tests/workloads/leafloop.o
  CC      tests/workloads/sqrtloop.o
  CC      tests/workloads/brstack.o
  CC      tests/workloads/datasym.o
  CC      tests/llvm-src-kbuild.o
  CC      tests/llvm-src-prologue.o
  CC      tests/llvm-src-base.o
  CC      tests/llvm-src-relocation.o
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      util/annotate.o
  CC      util/block-info.o
  CC      util/block-range.o
  CC      util/build-id.o
  GEN     pmu-events/pmu-events.c
  CC      util/cacheline.o
  CC      util/config.o
  CC      util/copyfile.o
  CC      util/ctype.o
  CC      util/db-export.o
  CC      util/env.o
  CC      util/event.o
  CC      util/evlist.o
  CC      util/evlist-hybrid.o
  CC      util/sideband_evlist.o
  CC      util/evsel.o
  CC      util/perf_event_attr_fprintf.o
  CC      util/find_bit.o
  CC      util/evsel_fprintf.o
  CC      util/get_current_dir_name.o
  CC      util/evswitch.o
  CC      util/levenshtein.o
  CC      util/llvm-utils.o
  CC      util/mmap.o
  CC      util/memswap.o
  BISON   util/parse-events-bison.c
  CC      util/parse-events-hybrid.o
  CC      util/print-events.o
  CC      util/tracepoint.o
  CC      util/perf_regs.o
  CC      util/path.o
  CC      util/print_binary.o
  CC      util/rlimit.o
  CC      util/argv_split.o
  CC      util/rbtree.o
  CC      util/libstring.o
  CC      util/bitmap.o
  CC      util/hweight.o
  CC      util/smt.o
  CC      util/strbuf.o
  CC      util/string.o
  CC      util/strlist.o
  CC      util/strfilter.o
  CC      util/top.o
  CC      util/usage.o
  CC      util/dso.o
  CC      util/dsos.o
  CC      util/symbol.o
  CC      util/symbol_fprintf.o
  CC      util/color.o
  CC      util/color_config.o
  CC      util/metricgroup.o
  CC      util/header.o
  CC      util/callchain.o
  CC      util/debug.o
  CC      util/values.o
  CC      util/fncache.o
  CC      util/machine.o
  CC      util/map.o
  CC      util/maps.o
  CC      util/pstack.o
  CC      util/sample-raw.o
  CC      util/session.o
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  LD      trace/beauty/tracepoints/perf-in.o
  CC      util/syscalltbl.o
  CC      util/ordered-events.o
  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/thread_map.o
  CC      util/parse-events-bison.o
  CC      util/pmus.o
  BISON   util/pmu-bison.c
  CC      util/pmu-hybrid.o
  CC      util/svghelper.o
  LD      trace/beauty/perf-in.o
  CC      util/trace-event-info.o
  CC      util/trace-event-scripting.o
  CC      util/trace-event-parse.o
  CC      util/trace-event.o
  CC      util/trace-event-read.o
  CC      util/hist.o
  CC      util/util.o
  CC      util/sort.o
  CC      util/cpumap.o
  CC      util/affinity.o
  CC      util/cputopo.o
  CC      util/cgroup.o
  CC      util/target.o
  CC      util/rblist.o
  CC      util/intlist.o
  CC      util/vdso.o
  CC      util/counts.o
  CC      util/stat.o
  CC      util/stat-shadow.o
  CC      util/stat-display.o
  CC      util/perf_api_probe.o
  CC      util/record.o
  CC      util/srcline.o
  CC      util/srccode.o
  CC      util/synthetic-events.o
  CC      util/data.o
  CC      util/tsc.o
  CC      util/cloexec.o
  CC      util/call-path.o
  CC      util/rwsem.o
  CC      util/thread-stack.o
  CC      util/spark.o
  CC      util/topdown.o
  CC      util/iostat.o
  CC      util/stream.o
  CC      util/auxtrace.o
  LD      tests/workloads/perf-in.o
  CC      util/intel-pt.o
  CC      util/intel-bts.o
  CC      util/arm-spe.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      util/hisi-ptt.o
  CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
  CC      util/s390-cpumsf.o
  CC      util/scripting-engines/trace-event-perl.o
  CXX     util/c++/clang.o
  CC      util/cs-etm-base.o
  CXX     util/c++/clang-test.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      util/scripting-engines/trace-event-python.o
  CC      util/parse-branch-options.o
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  CC      util/dump-insn.o
  CC      util/parse-regs-options.o
  CC      util/parse-sublevel-options.o
  CC      util/term.o
  CC      util/help-unknown-cmd.o
  CC      util/mem-events.o
  CC      util/vsprintf.o
  CC      util/units.o
  CC      util/dlfilter.o
  CC      util/time-utils.o
  BISON   util/expr-bison.c
  CC      util/branch.o
  CC      util/clockid.o
  CC      util/mem2node.o
  LD      ui/tui/perf-in.o
  CC      util/list_sort.o
  LD      arch/x86/tests/perf-in.o
  CC      util/mutex.o
  CC      util/bpf-loader.o
  CC      util/bpf_map.o
  CC      util/symbol-elf.o
  CC      util/probe-file.o
  CC      util/bpf-prologue.o
  CC      util/probe-event.o
  CC      util/probe-finder.o
  CC      util/dwarf-aux.o
  CC      util/dwarf-regs.o
  CC      util/unwind-libunwind-local.o
  CC      util/unwind-libunwind.o
  CC      util/data-convert-bt.o
  CC      util/data-convert-json.o
  CC      util/zlib.o
  CC      util/lzma.o
  CC      util/demangle-ocaml.o
  CC      util/cap.o
  CC      util/zstd.o
  CC      util/demangle-java.o
  CC      util/demangle-rust.o
  CC      util/jitdump.o
  CC      util/genelf.o
  CC      util/genelf_debug.o
  CC      util/perf-hooks.o
  CC      util/bpf-event.o
  CC      util/bpf-utils.o
  FLEX    util/parse-events-flex.c
  FLEX    util/pmu-flex.c
  FLEX    util/expr-flex.c
  CC      util/pmu-bison.o
  CC      util/expr-bison.o
  CC      util/pmu.o
  CC      util/pmu-flex.o
  CC      util/expr-flex.o
  CC      util/expr.o
  CC      util/parse-events.o
  CC      util/parse-events-flex.o
  LD      scripts/python/Perf-Trace-Util/perf-in.o
  LD      util/hisi-ptt-decoder/perf-in.o
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD      util/arm-spe-decoder/perf-in.o
  LD      scripts/perl/Perf-Trace-Util/perf-in.o
  LD      scripts/perf-in.o
  LD      arch/x86/util/perf-in.o
  LD      arch/x86/perf-in.o
  LD      arch/perf-in.o
  CC      pmu-events/pmu-events.o
  LD      bench/perf-in.o
  LD      tests/perf-in.o
  LD      util/scripting-engines/perf-in.o
  LD      pmu-events/pmu-events-in.o
  LD      ui/browsers/perf-in.o
  LD      ui/perf-in.o
  LD      util/c++/perf-in.o
  LD      util/intel-pt-decoder/perf-in.o
  LD      util/perf-in.o
  LD      perf-in.o
  LINK    perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf'
2023-05-11 15:57:36 cd /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa205003=
0d65777596498256acd5f1584421e33a/tools/perf
2023-05-11 15:57:36 mkdir -p /pkg
2023-05-11 15:57:36 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3-bpf
2023-05-11 15:57:37 cp /pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d6577=
7596498256acd5f1584421e33a/vmlinux.xz /tmp
2023-05-11 15:57:39 unxz -k /tmp/vmlinux.xz
2023-05-11 15:57:44 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3-bp=
f
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
2023-05-11 15:57:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 1
  1: vmlinux symtab matches kallsyms                                 : Ok
2023-05-11 15:57:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 2
  2: Detect openat syscall event                                     : Ok
2023-05-11 15:57:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 3
  3: Detect openat syscall event on all cpus                         : Ok
2023-05-11 15:57:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 4
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
2023-05-11 15:57:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 5
  5: Test data source output                                         : Ok
2023-05-11 15:57:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : FAIL=
ED!
  6.2: Test parsing of "hybrid" CPU events                           : Skip=
 (not hybrid)
  6.3: Parsing of all PMU events from sysfs                          : Ok
  6.4: Parsing of given PMU events from sysfs                        : Ok
  6.5: Parsing of aliased events from sysfs                          : Skip=
 (no aliases in sysfs)
  6.6: Parsing of aliased events                                     : Ok
  6.7: Parsing of terms (event modifiers)                            : Ok
2023-05-11 15:57:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 7
  7: Simple expression parser                                        : Ok
2023-05-11 15:57:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 8
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
2023-05-11 15:57:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 9
  9: Parse perf pmu format                                           : Ok
2023-05-11 15:57:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2023-05-11 15:57:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 11
 11: DSO data read                                                   : Ok
2023-05-11 15:57:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 12
 12: DSO data cache                                                  : Ok
2023-05-11 15:57:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 13
 13: DSO data reopen                                                 : Ok
2023-05-11 15:57:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 14
 14: Roundtrip evsel->name                                           : Ok
2023-05-11 15:57:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 15
 15: Parse sched tracepoints fields                                  : Ok
2023-05-11 15:57:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 16
 16: syscalls:sys_enter_openat event fields                          : Ok
2023-05-11 15:57:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 17
 17: Setup struct perf_event_attr                                    : Ok
2023-05-11 15:58:19 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 18
 18: Match and link multiple hists                                   : Ok
2023-05-11 15:58:19 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 19
 19: 'import perf' in python                                         : FAIL=
ED!
2023-05-11 15:58:19 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 20
 20: Breakpoint overflow signal handler                              : Ok
2023-05-11 15:58:19 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 21
 21: Breakpoint overflow sampling                                    : Ok
2023-05-11 15:58:19 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 22
 22: Breakpoint accounting                                           : Ok
2023-05-11 15:58:20 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 23
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip=
 (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
2023-05-11 15:58:20 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 24
 24: Number of exit events of a simple workload                      : Ok
2023-05-11 15:58:20 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 25
 25: Software clock events period values                             : Ok
2023-05-11 15:58:20 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 26
 26: Object code reading                                             : Ok
2023-05-11 15:58:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 27
 27: Sample parsing                                                  : Ok
2023-05-11 15:58:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 28
 28: Use a dummy software event to keep tracking                     : Ok
2023-05-11 15:58:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 29
 29: Parse with no sample_id_all bit set                             : Ok
2023-05-11 15:58:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 30
 30: Filter hist entries                                             : Ok
2023-05-11 15:58:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 31
 31: Lookup mmap thread                                              : Ok
2023-05-11 15:58:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 32
 32: Share thread maps                                               : Ok
2023-05-11 15:58:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 33
 33: Sort output of hist entries                                     : Ok
2023-05-11 15:58:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 34
 34: Cumulate child hist entries                                     : Ok
2023-05-11 15:58:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 35
 35: Track with sched_switch                                         : Ok
2023-05-11 15:58:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 36
 36: Filter fds with revents mask in a fdarray                       : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 37
 37: Add fd to a fdarray, making it autogrow                         : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 38
 38: kmod_path__parse                                                : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 39
 39: Thread map                                                      : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 41
 41: Session topology                                                : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 43
 43: Synthesize thread map                                           : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 44
 44: Remove thread map                                               : Ok
2023-05-11 15:58:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 45
 45: Synthesize cpu map                                              : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 46
 46: Synthesize stat config                                          : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 47
 47: Synthesize stat                                                 : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 48
 48: Synthesize stat round                                           : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 49
 49: Synthesize attr update                                          : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 50
 50: Event times                                                     : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 51
 51: Read backward ring buffer                                       : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 52
 52: Print cpu map                                                   : Ok
2023-05-11 15:58:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 53
 53: Merge cpu map                                                   : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 54
 54: Probe SDT events                                                : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 55
 55: is_printable_array                                              : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 56
 56: Print bitmap                                                    : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 57
 57: perf hooks                                                      : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 58
 58: builtin clang support                                           :
 58.1: builtin clang compile C source to IR                          : Ok
 58.2: builtin clang compile C source to ELF object                  : FAIL=
ED!
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 59
 59: unit_number__scnprintf                                          : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 60
 60: mem2node                                                        : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 61
 61: time utils                                                      : Ok
2023-05-11 15:58:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 62
 62: Test jit_write_elf                                              : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               : Skip=
 (not compiled in)
 63.2: test groups of --pfm-events                                   : Skip=
 (not compiled in)
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 64
 64: Test api io                                                     : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 65
 65: maps__merge_in                                                  : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 66
 66: Demangle Java                                                   : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 67
 67: Demangle OCaml                                                  : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 68
 68: Parse and process metrics                                       : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 69
 69: PE file support                                                 : Ok
2023-05-11 15:58:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 70
 70: Event expansion for cgroups                                     : Ok
2023-05-11 15:58:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 71
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
2023-05-11 15:58:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 72
 72: dlfilter C API                                                  : FAIL=
ED!
2023-05-11 15:58:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 73
 73: Sigtrap                                                         : Ok
2023-05-11 15:58:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 74
 74: Event groups                                                    : Skip
2023-05-11 15:58:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 75
 75: Symbols                                                         : FAIL=
ED!
2023-05-11 15:58:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 76
 76: Test dwarf unwind                                               : Ok
2023-05-11 15:58:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 77
 77: x86 instruction decoder - new instructions                      : Ok
2023-05-11 15:58:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 78
 78: Intel PT                                                        :
 78.1: Intel PT packet decoder                                       : Ok
 78.2: Intel PT hybrid CPU compatibility                             : Skip
2023-05-11 15:58:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 79
 79: x86 bp modify                                                   : Ok
2023-05-11 15:58:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 80
 80: x86 Sample parsing                                              : Ok
2023-05-11 15:58:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 81
 81: build id cache operations                                       : FAIL=
ED!
2023-05-11 15:58:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 82
 82: CoreSight / ASM Pure Loop                                       : Skip
2023-05-11 15:58:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 83
 83: CoreSight / Memcpy 16k 10 Threads                               : Skip
2023-05-11 15:58:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 84
 84: CoreSight / Thread Loop 10 Threads - Check TID                  : Skip
2023-05-11 15:58:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 85
 85: CoreSight / Thread Loop 2 Threads - Check TID                   : Skip
2023-05-11 15:58:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 86
 86: CoreSight / Unroll Loop Thread 10                               : Skip
2023-05-11 15:58:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 87
 87: daemon operations                                               : Ok
2023-05-11 15:59:10 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 88
 88: kernel lock contention analysis test                            : Ok
2023-05-11 16:00:06 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 89
 89: perf pipe recording and injection test                          : FAIL=
ED!
2023-05-11 16:00:08 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 91
 91: probe libc's inet_pton & backtrace it with ping                 : Ok
2023-05-11 16:00:11 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 93
 93: Zstd perf.data compression/decompression                        : Ok
2023-05-11 16:00:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 94
 94: perf record tests                                               : FAIL=
ED!
2023-05-11 16:00:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 95
 95: perf record offcpu profiling tests                              : Skip
2023-05-11 16:00:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 96
 96: perf stat CSV output linter                                     : FAIL=
ED!
2023-05-11 16:00:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 97
 97: perf stat csv summary test                                      : Ok
2023-05-11 16:00:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 98
 98: perf stat JSON output linter                                    : FAIL=
ED!
2023-05-11 16:00:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 99
 99: perf stat metrics (shadow stat) test                            : Ok
2023-05-11 16:00:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 100
100: perf stat tests                                                 : Ok
2023-05-11 16:00:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 101
101: perf all metricgroups test                                      : FAIL=
ED!
2023-05-11 16:00:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 102
102: perf all metrics test                                           : FAIL=
ED!
2023-05-11 16:03:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 103
103: perf all PMU test                                               : Ok
2023-05-11 16:04:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 104
104: perf stat --bpf-counters test                                   : Skip
2023-05-11 16:04:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 105
105: perf stat --bpf-counters --for-each-cgroup test                 : Skip
2023-05-11 16:04:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 106
106: Check Arm64 callgraphs are complete in fp mode                  : Skip
2023-05-11 16:04:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 107
107: Check Arm CoreSight trace data recording and synthesized samples: Skip
2023-05-11 16:04:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 108
108: Check Arm SPE trace data recording and synthesized samples      : Skip
2023-05-11 16:04:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 109
109: Check Arm SPE doesn't hang when there are forks                 : Skip
2023-05-11 16:04:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 110
110: Check branch stack sampling                                     : FAIL=
ED!
2023-05-11 16:04:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 111
111: Test data symbol                                                : FAIL=
ED!
2023-05-11 16:04:50 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 112
112: Miscellaneous Intel PT testing                                  : FAIL=
ED!
2023-05-11 16:05:06 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 113
113: Test java symbol                                                : Skip
2023-05-11 16:05:06 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050=
030d65777596498256acd5f1584421e33a/tools/perf/perf test 114
114: perf script task-analyzer tests                                 : Ok

--PSbc1JmETRt9H6EQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/perf-sanity-tests.yaml
suite: perf-sanity-tests
testcase: perf-sanity-tests
category: functional
need_memory: 2G
perf-sanity-tests:
  perf_compiler: clang
job_origin: perf-sanity-tests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-spr-2sp1
tbox_group: lkp-spr-2sp1
submit_id: 645d025866c23265db3a7313
job_file: "/lkp/jobs/scheduled/lkp-spr-2sp1/perf-sanity-tests-clang-debian-11.1-x86_64-20220510.cgz-aa2050030d65777596498256acd5f1584421e33a-20230511-26075-1f9ry8g-0.yaml"
id: 1a854cfd1848f3c668862285d0589ff02f6290db
queuer_version: "/zday/lkp"

#! /db/releases/20230509145422/lkp-src/hosts/lkp-spr-2sp1
model: Sapphire Rapids
nr_node: 2
nr_cpu: 224
memory: 256G
nr_ssd_partitions: 6
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401J94P0IGN-part*"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ207201DG1P0FGN-part4"
kernel_cmdline_hw: acpi_rsdp=0x777fe014
brand: Intel(R) Xeon(R) Platinum 8480+

#! /db/releases/20230509145422/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:

#! /db/releases/20230509145422/lkp-src/include/perf-sanity-tests
initrds:
- linux_perf

#! /db/releases/20230509145422/lkp-src/include/queue/cyclic
commit: aa2050030d65777596498256acd5f1584421e33a

#! /db/releases/20230509145422/lkp-src/include/testbox/lkp-spr-2sp1
ucode: '0x2b000181'
kconfig: x86_64-rhel-8.3-bpf
enqueue_time: 2023-05-11 22:57:30.034761388 +08:00
_id: 645d025866c23265db3a7313
_rt: "/result/perf-sanity-tests/clang/lkp-spr-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 6242c02bd1883e42ab204b175ea2562d7c646180
base_commit: ac9a78681b921877518763ba0e89202254349d1b
branch: internal-devel/devel-hourly-20230509-140013
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/perf-sanity-tests/clang/lkp-spr-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/0"
scheduler_version: "/lkp/lkp/.src-20230511-163851"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/perf-sanity-tests/clang/lkp-spr-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/vmlinuz-6.2.0-rc7-00145-gaa2050030d65
- branch=internal-devel/devel-hourly-20230509-140013
- job=/lkp/jobs/scheduled/lkp-spr-2sp1/perf-sanity-tests-clang-debian-11.1-x86_64-20220510.cgz-aa2050030d65777596498256acd5f1584421e33a-20230511-26075-1f9ry8g-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-bpf
- commit=aa2050030d65777596498256acd5f1584421e33a
- initcall_debug
- nmi_watchdog=0
- acpi_rsdp=0x777fe014
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/modules.cgz"
linux_perf_initrd: "/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/linux-perf.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230509145422/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 5.9.0-2-amd64

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/vmlinuz-6.2.0-rc7-00145-gaa2050030d65"
dequeue_time: 2023-05-11 23:55:12.387108167 +08:00

#! /cephfs/db/releases/20230511154539/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 1.15 6.42 4.55 1/1674 25164
start_time: '1683820635'
end_time: '1683821110'
version: "/lkp/lkp/.src-20230511-163933:28317e211bd2:0ec390c3f5d2"

--PSbc1JmETRt9H6EQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

make -j224 WERROR=0 LIBCLANGLLVM=1 CXXFLAGS+=-Wno-class-memaccess EXTRA_CXXFLAGS+=-Wno-class-memaccess ARCH= EXTRA_CFLAGS=-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address -Wno-array-bounds -C /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf
cd /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf
mkdir -p /pkg
mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3-bpf
cp /pkg/linux/x86_64-rhel-8.3-bpf/gcc-11/aa2050030d65777596498256acd5f1584421e33a/vmlinux.xz /tmp
unxz -k /tmp/vmlinux.xz
cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3-bpf
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 1
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 2
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 3
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 4
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 5
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 6
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 7
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 8
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 9
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 10
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 11
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 12
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 13
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 14
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 15
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 16
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 17
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 18
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 19
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 20
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 21
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 22
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 23
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 24
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 25
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 26
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 27
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 28
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 29
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 30
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 31
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 32
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 33
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 34
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 35
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 36
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 37
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 38
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 39
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 41
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 43
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 44
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 45
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 46
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 47
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 48
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 49
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 50
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 51
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 52
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 53
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 54
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 55
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 56
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 57
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 58
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 59
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 60
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 61
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 62
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 63
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 64
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 65
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 66
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 67
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 68
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 69
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 70
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 71
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 72
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 73
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 74
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 75
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 76
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 77
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 78
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 79
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 80
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 81
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 82
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 83
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 84
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 85
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 86
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 87
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 88
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 89
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 91
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 93
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 94
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 95
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 96
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 97
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 98
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 99
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 100
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 101
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 102
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 103
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 104
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 105
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 106
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 107
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 108
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 109
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 110
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 111
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 112
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 113
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-aa2050030d65777596498256acd5f1584421e33a/tools/perf/perf test 114

--PSbc1JmETRt9H6EQ--
