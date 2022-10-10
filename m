Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2A5F96BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiJJCLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJJCK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:10:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FA2C109;
        Sun,  9 Oct 2022 19:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665367851; x=1696903851;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IGrmKbqeeSxrWZpjhyLEawdJ5CL1ZzvMCBZuyN8ihuQ=;
  b=ZpJS6zlnGMreR0BqqVPHNlWEkAkFwDMV5s19XzLj5k0QmdJt9Ra+4JvZ
   2NheNfTlQZrj48l2xcmNsv2BIfmB2T9V0GjdM0ua6NViUfE0QwkwhlH2e
   3VI+3x22EbK3FM1mN8ZGuVZLcc/9RIWviDXfSAEM83TmqLb4mN53aLKui
   cnGt949+P0x/OiEX/f1NooFPMvaY/LY0sWUqglS+JjjOEcvNpp7+pFTec
   wcuKbZaHsNsr9Vuft4K8uMD/8oBja99iUqRQ2vH1gAd6cbEco4yPCkW+N
   bEQSPhZQBYJc8fOmwPuVq2cT+Q0taNtMkRULZWb7CJR/gYdOwo/taF/ip
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="287360430"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="xz'?yaml'?scan'208";a="287360430"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 19:10:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="628117277"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="xz'?yaml'?scan'208";a="628117277"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 09 Oct 2022 19:10:49 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 19:10:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 19:10:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 9 Oct 2022 19:10:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 9 Oct 2022 19:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFTWj2JT6EnjsK48KggPH5kj1DIF5UtHRQRjyz26yETG8tDPvBKhpvOvbqMktTlUWQwYkFUrMJpa6JLF4JTKCbSZXpO7bnqDokeL5n0rYHf8xadoqdcFUrvWau4UQr/gYH3nGGWmaLpapdocIWJ9LDgjxaC79imE//TSqfCzrZDM7EGSGwXwaR8X+4ZdSbKCnK1TKmwlW4vFrOcle1DvMAsWNqGkEA1GkMBnc/YnkYkTFUbqkkJRX+dbfDZGJWNtfZC0ebRmiBfPwgyPTVNP+p8BQt1LfnRN57pkP2kYJIgaMHzOmwipyRWMv6QfUojCVh2tZT/SJBAWaqzFe3ZMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU8qX/WGNFfOxuMRnfgADadana96KipYid9k6vx15Es=;
 b=IP44i7BndW2AdRV5DLF2jc5GY38a6Zu+Nk2hVlftB8J0Mjh0mMPzTPWLTgCaxJbLQUwh7R/xYhnv9KKksc1w7pOAeHWTbeXPSfY3mrdgpltTRrOkUZ2VadPSuFUU+/aLF/62AkqKNZ0Ynki6t8ROfvRMM7sa1BN9w6VAT4+bBtZcT0Gc/srJq+SA4udQk43T36O83FCJxVXBbtFNVO08XU3ArcfRUiLZPzk0xB1BcAwu5pEM5S3pKMEZfnJ8/sBd4/omW/IR7vuzsNgRbXGzG865btXcaU2Mk8woWr+Z2Cag3dtgYf1v2gMF9HMjR1eY2YxDAfB4obYxVfgKPS8XhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Mon, 10 Oct 2022 02:10:43 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc%5]) with mapi id 15.20.5654.025; Mon, 10 Oct 2022
 02:10:43 +0000
Date:   Mon, 10 Oct 2022 10:09:10 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [perf record] 63817398b9:
 perf-sanity-tests.Setup_struct_perf_event_attr.fail
Message-ID: <202210100952.823def7b-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="FbvI2xqxR74DaVf1"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|DM4PR11MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ed3dc8-4b52-431a-3945-08daaa64a263
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnJtrkAhOC4YF6bYxkY6EyeaKGQY1j+kMVKPfI3JLOpfgfxdpzuN/nAjp3Sy+4x218DTI3Th/nl/6BWLTeRP1G/o6uKdirIfTuJvsg3twVnTe3+JSAJb3Tf+07/phLcRAANkxZKqw+sJ4P72//GMyHCtTxVR8h2j06+vfGWVXxWXL5UoCihICFrlDZP0aCosEPFLwOV0DvtAXsJTrddzBjIk1QHYlUY4rCOO4ZOZvWnIB779R2YEoqJoN4/3B5JxmCpn7APJU1ga2a8xDybacGitg5s8tuvuuA+T8/UADzr+hTh939dl+zchdYv7FpdBpnwma4uUgKzInvpP/GUXOJ4On4EOuwAK0OAc4/MnCeBSUHiu2479lM02w28a/xMkABpzN0YbXTY3Ta9kwsLf0aIqPKwk7Q9FDQKqRe+/rWDvsxBHROiuBzDnZx96Ndt4FXE3QcrOn0bEypI8tRbp+HRh7TZqhzSaOCPWZ+ObGn+NmGxISOKlEQ4aLyGSJdl/dgfmtppQnaLid+flx2fB5nmtyDIdEt/zVS4e5UYUztDrNXnL6D125AgitemmD6Jr3dbve1VoSDvuPYfvvBDTk/MvjUHmnNTFqKgINsncrLuoySHwffeh+DuJibFfqbi7Shfam5JWJtNESOLMbzzzSyt/ux0a39tT3Gvd/u9IDTVjOmyzwnaHD0nBo9ocJIjD0EO9b0kwg+xsNcJYYs0tgYTr7oC3HQkZyY4cY52V16QBwKnAuTtEqe1B8rU8VzC3D1jtXVm0pmSa9JrlV53YQRnT8rGnS6i+PXc2l+7yYGrbK89t79X7go/k35LCIQpPu0CoN5kvGCA+vNA9XhHUZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(1076003)(83380400001)(186003)(2906002)(38100700002)(6512007)(8936002)(41300700001)(82960400001)(2616005)(6506007)(44144004)(26005)(316002)(36756003)(5660300002)(4326008)(6486002)(966005)(66946007)(478600001)(21490400003)(30864003)(86362001)(6916009)(66476007)(66556008)(8676002)(235185007)(6666004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6APAPov2ub2CSxYKne5Lnr+MxfKnJgd7Scpxz+pfddTePDMs0R32Swa7wgm7?=
 =?us-ascii?Q?bc4iToWJo3eozgqhdh9/CpexEjKmeKrSrw3ylWTosAZaFLs4a0ApEk44gm65?=
 =?us-ascii?Q?eEvGy8YABf+ot+G5wz/nGK35I+beqgoqHOuk/j8dYWEwbSQLuN23mjRj0A+M?=
 =?us-ascii?Q?Mhw2twFH+ksZxI1DjnlXocDj4qERaXLf2lkH0N0u0astdgrZuIMpTX0urL90?=
 =?us-ascii?Q?Yrr6BHEe6WF/mZvtmrwY/s3LDz4qdvD4v9UkwcSwJj8EQKFkMC+1St4NJxPy?=
 =?us-ascii?Q?w0K/g7hIMwMiO4iGG+n7Dmo6/aZrbSYrY3RsGpTgC+YK85q5T40tRk+ZpwRQ?=
 =?us-ascii?Q?fcj2fXf70gxyXEs2OGsfwOY8G/uNFN7FXpCXu/vJFeR+vjRlIGCg1q/1PC3S?=
 =?us-ascii?Q?MTykR0hvPh5fcm86x9H0i7QIJ5+is2LE2qv+gZcZ37NcJi4fEVNMGxl24SBt?=
 =?us-ascii?Q?wNU3QSDQh2TyVnS7259dVqxTtEKQLQ/gYZuqWPN5kfnvoujujfBajhrjWkUB?=
 =?us-ascii?Q?TgqogPED9qYIAt2Zicqi7wCOg7UEIfMn5nX7Xr8qh9MH3WzSEEHh7uLdCq5X?=
 =?us-ascii?Q?OP1LH6n93ULFsdk/bqW14wdBYPLC+rMyy06+tEAOwccb+feT6Ej7CxgIQvmC?=
 =?us-ascii?Q?L4c/rSAJ/pqQiNv8YYN87fVUHA7Ij4WK+SoCLC6tR/P7Vl0CoLB+B6MEz9/Y?=
 =?us-ascii?Q?DJqi/PfDXB5XVrSISTW3mB6EMyEwfVrH1zXo4+SbkKzNmvVRPxokVdZ3ADRl?=
 =?us-ascii?Q?Za7e6R9Y5duBbibMSTMdWFf5MdmKBm4Hm1uydFehqYyrOoHqKxvwLIVz11Gm?=
 =?us-ascii?Q?3FrUrjXip9SjPf4WqoHxr9oVldephe6PeMKkD59icrpmIWG2xCM4D5+Ay6mj?=
 =?us-ascii?Q?BOKBvd0mOd2apr/NtDfnw9C1FglXmuDRkj5u+tB6lp75RayHAL2be5jShD9L?=
 =?us-ascii?Q?FmdF09GO3SouIKVas0RtPwza1PBBFRhm9kJCoU+8DTlhkttYR8IC95Mjc7kJ?=
 =?us-ascii?Q?bW1zk32tOo9P8qzfit4zNiDfdqwnh8vqQaGhMbiJO3j/fx3GPi3sXK0713aw?=
 =?us-ascii?Q?JOwgUYRNRkfsVR/7LeY4ZOKGlyRMwPlQsLetH2JYAN7yUJ+5+SCjniwB+8KP?=
 =?us-ascii?Q?bWykZLsvAMRi7DBQJ7fNDBmTkAhsBlgHCF4JT6yedfF4eHLp8ylx5QUgsrgL?=
 =?us-ascii?Q?2pE0nAAkv9UCxNKV9mUaW1kqNnT8wG+uLXpi1t/SfHNUEohMakDe5sns2ARv?=
 =?us-ascii?Q?mGW92yYT6+fcujJt54oNjQabpfqQ6GX7OB2sShFyPDXlMTr1V9uwpFlye7GR?=
 =?us-ascii?Q?OVv6a287jaBNSfxM7xSrioe4BpPxy4pahXnp035TxPdCAgtwpqi3hhn/O3Eg?=
 =?us-ascii?Q?L3fNAYg1dLvEY/G/IgySJ2c5k/N/nrDnna1+SRNlbRjB4g3mwd40P1wVucYu?=
 =?us-ascii?Q?73V0pbxjiWorwUKLa/Uao+qKjGLDyT24MW4Q1YM/ry8LO4pbI6T208z3RH7M?=
 =?us-ascii?Q?lbvs6va75pMwP3Z1X7mLmNnICnHmulg83K4ueVPt7H4vOcW/atHbA6zUzSxl?=
 =?us-ascii?Q?wSkMk/mAEJ9JRo6+5387N3nnDF03I56ILBZvPSlD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ed3dc8-4b52-431a-3945-08daaa64a263
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 02:10:43.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwYamXAOiCSGDOjZWIocxBLA2jN9bDZrfnWLT9UptXykPjwhb2/ldCPLKq4tFVdpnVbFbXD86BzfEcmiTgKPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--FbvI2xqxR74DaVf1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 63817398b945c74929af2b95dba4548a188c1671 ("perf record: Set PERF_FORMAT_LOST by default")
https://git.kernel.org/cgit/linux/kernel/git/namhyung/linux-perf.git perf/report-lost-v1

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc

on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


2022-10-05 19:46:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 1
  1: vmlinux symtab matches kallsyms                                 : Ok
2022-10-05 19:46:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 2
  2: Detect openat syscall event                                     : Ok
2022-10-05 19:46:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 3
  3: Detect openat syscall event on all cpus                         : Ok
2022-10-05 19:46:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 4
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
2022-10-05 19:46:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 5
  5: Test data source output                                         : Ok
2022-10-05 19:46:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : FAILED!
  6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
  6.3: Parsing of all PMU events from sysfs                          : Ok
  6.4: Parsing of given PMU events from sysfs                        : Ok
  6.5: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.6: Parsing of aliased events                                     : Ok
  6.7: Parsing of terms (event modifiers)                            : Ok
2022-10-05 19:47:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 7
  7: Simple expression parser                                        : Ok
2022-10-05 19:47:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 8
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
2022-10-05 19:47:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 9
  9: Parse perf pmu format                                           : Ok
2022-10-05 19:47:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 11
 11: DSO data read                                                   : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 12
 12: DSO data cache                                                  : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 13
 13: DSO data reopen                                                 : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 14
 14: Roundtrip evsel->name                                           : Ok
2022-10-05 19:47:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 15
 15: Parse sched tracepoints fields                                  : Ok
2022-10-05 19:47:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 16
 16: syscalls:sys_enter_openat event fields                          : Ok
2022-10-05 19:47:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 17
 17: Setup struct perf_event_attr                                    : FAILED!
2022-10-05 19:47:15 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 18
 18: Match and link multiple hists                                   : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 19
 19: 'import perf' in python                                         : FAILED!
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 20
 20: Breakpoint overflow signal handler                              : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 21
 21: Breakpoint overflow sampling                                    : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 22
 22: Breakpoint accounting                                           : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 23
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 24
 24: Number of exit events of a simple workload                      : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 25
 25: Software clock events period values                             : Ok
2022-10-05 19:47:17 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 26
 26: Object code reading                                             : Ok
2022-10-05 19:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 27
 27: Sample parsing                                                  : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 28
 28: Use a dummy software event to keep tracking                     : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 29
 29: Parse with no sample_id_all bit set                             : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 30
 30: Filter hist entries                                             : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 31
 31: Lookup mmap thread                                              : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 32
 32: Share thread maps                                               : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 33
 33: Sort output of hist entries                                     : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 34
 34: Cumulate child hist entries                                     : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 35
 35: Track with sched_switch                                         : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 36
 36: Filter fds with revents mask in a fdarray                       : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 37
 37: Add fd to a fdarray, making it autogrow                         : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 38
 38: kmod_path__parse                                                : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 39
 39: Thread map                                                      : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 41
 41: Session topology                                                : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 43
 43: Synthesize thread map                                           : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 44
 44: Remove thread map                                               : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 45
 45: Synthesize cpu map                                              : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 46
 46: Synthesize stat config                                          : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 47
 47: Synthesize stat                                                 : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 48
 48: Synthesize stat round                                           : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 49
 49: Synthesize attr update                                          : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 50
 50: Event times                                                     : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 51
 51: Read backward ring buffer                                       : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 52
 52: Print cpu map                                                   : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 53
 53: Merge cpu map                                                   : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 54
 54: Probe SDT events                                                : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 55
 55: is_printable_array                                              : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 56
 56: Print bitmap                                                    : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 57
 57: perf hooks                                                      : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 59
 59: unit_number__scnprintf                                          : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 60
 60: mem2node                                                        : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 61
 61: time utils                                                      : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 62
 62: Test jit_write_elf                                              : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               : Skip (not compiled in)
 63.2: test groups of --pfm-events                                   : Skip (not compiled in)
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 64
 64: Test api io                                                     : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 65
 65: maps__merge_in                                                  : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 66
 66: Demangle Java                                                   : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 67
 67: Demangle OCaml                                                  : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 68
 68: Parse and process metrics                                       : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 69
 69: PE file support                                                 : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 70
 70: Event expansion for cgroups                                     : Ok
2022-10-05 19:47:31 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 71
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
2022-10-05 19:47:31 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 72
 72: dlfilter C API                                                  : FAILED!
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 73
 73: Sigtrap                                                         : Ok
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 74
 74: Test dwarf unwind                                               : Ok
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 75
 75: x86 instruction decoder - new instructions                      : Ok
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 76
 76: Intel PT packet decoder                                         : Ok
2022-10-05 19:47:33 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 77
 77: x86 bp modify                                                   : Ok
2022-10-05 19:47:33 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 78
 78: x86 Sample parsing                                              : Ok
2022-10-05 19:47:33 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 79
 79: build id cache operations                                       : FAILED!
2022-10-05 19:47:34 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 80
 80: daemon operations                                               : Ok
2022-10-05 19:47:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 81
 81: perf pipe recording and injection test                          : Ok
2022-10-05 19:47:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 83
 83: probe libc's inet_pton & backtrace it with ping                 : Ok
2022-10-05 19:48:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 85
 85: Zstd perf.data compression/decompression                        : Ok
2022-10-05 19:48:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 86
 86: perf record tests                                               : Ok
2022-10-05 19:48:08 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 87
 87: perf record offcpu profiling tests                              : Skip
2022-10-05 19:48:09 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 88
 88: perf stat CSV output linter                                     : Ok
2022-10-05 19:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 89
 89: perf stat csv summary test                                      : Ok
2022-10-05 19:48:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 90
 90: perf stat JSON output linter                                    : Ok
2022-10-05 19:48:17 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 91
 91: perf stat metrics (shadow stat) test                            : Ok
2022-10-05 19:48:21 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 92
 92: perf stat tests                                                 : Ok
2022-10-05 19:48:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 93
 93: perf all metricgroups test                                      : Ok
2022-10-05 19:48:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 94
 94: perf all metrics test                                           : Skip
2022-10-05 19:50:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 95
 95: perf all PMU test                                               : Ok
2022-10-05 19:52:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 96
 96: perf stat --bpf-counters test                                   : Skip
2022-10-05 19:52:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 97
 97: Check Arm64 callgraphs are complete in fp mode                  : Skip
2022-10-05 19:52:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 98
 98: Check Arm CoreSight trace data recording and synthesized samples: Skip
2022-10-05 19:52:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 99
 99: Check Arm SPE trace data recording and synthesized samples      : Skip
2022-10-05 19:52:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 100
100: Check Arm SPE doesn't hang when there are forks                 : Skip
2022-10-05 19:52:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 101
101: Check branch stack sampling                                     : Ok
2022-10-05 19:53:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 102
102: Miscellaneous Intel PT testing                                  : Skip


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/r/202210100952.823def7b-yujie.liu@intel.com


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

--FbvI2xqxR74DaVf1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.0.0-rc3-00037-g63817398b945"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc3 Kernel Configuration
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
# CONFIG_BPF_SYSCALL is not set
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_DEFAULT_ON=y
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
CONFIG_MEMCG_SWAP=y
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
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
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
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K8=m
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
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

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
# CONFIG_DECNET is not set
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
# CONFIG_PATA_PLATFORM is not set
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
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
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
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

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
# CONFIG_IWLMEI is not set
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
# CONFIG_GPIO_ADP5588 is not set
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
# CONFIG_SENSORS_ASPEED is not set
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
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
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
# CONFIG_SENSORS_ASUS_WMI_EC is not set
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
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
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
# CONFIG_DRM_DEBUG_SELFTEST is not set
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
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
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
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
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
CONFIG_CMA_SIZE_MBYTES=0
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
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
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
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
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
# end of Kernel hacking

--FbvI2xqxR74DaVf1
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
commit
kbuild_queue_analysis
bm_initrd_keep'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='633ddc9b5bb321e6af90fa2f'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-63817398b945c74929af2b95dba4548a188c1671-20221006-59055-562qzw-3.yaml'
	export id='ace113da2d09213ac065c9ea8136b2ea58d30683'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export initrds='linux_perf'
	export commit='63817398b945c74929af2b95dba4548a188c1671'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-10-06 03:35:55 +0800'
	export _id='633ddc9b5bb321e6af90fa2f'
	export _rt='/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='d3e2e4231f05d65af74d9aa3b1b1f12edaf5ca3b'
	export base_commit='b90cb1053190353cc30f0fef0ef1f378ccc063c5'
	export branch='namhyung-perf/perf/report-lost-v1'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/vmlinuz-6.0.0-rc3-00037-g63817398b945
branch=namhyung-perf/perf/report-lost-v1
job=/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-63817398b945c74929af2b95dba4548a188c1671-20221006-59055-562qzw-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=63817398b945c74929af2b95dba4548a188c1671
max_uptime=2100
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/modules.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/linux-perf.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20221001.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-ffb4d94b4314-1_20221001.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.0.0-rc7-wt-09880-g12e39642c18f'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='perf-sanity-tests.Zstd_perf.data_compression/decompression.fail'
	export kbuild_queue_analysis=1
	export bm_initrd_keep=true
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/vmlinuz-6.0.0-rc3-00037-g63817398b945'
	export dequeue_time='2022-10-06 03:43:10 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-63817398b945c74929af2b95dba4548a188c1671-20221006-59055-562qzw-3.cgz'

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

	run_test perf_compiler='gcc' $LKP_SRC/tests/wrapper perf-sanity-tests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env perf_compiler='gcc' $LKP_SRC/stats/wrapper perf-sanity-tests
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

--FbvI2xqxR74DaVf1
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAAAARZWg==

--FbvI2xqxR74DaVf1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="perf-sanity-tests"
Content-Transfer-Encoding: quoted-printable

2022-10-05 19:45:14 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-frame-pointer -fs=
anitize=3Dundefined -fsanitize=3Daddress -Wno-array-bounds -C /usr/src/perf=
_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/to=
ols/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-func-6381=
7398b945c74929af2b95dba4548a188c1671/tools/perf'
  BUILD:   Doing 'make =1B[33m-j4=1B[m' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event=
.h
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufe=
atures.h

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

  CC      exec-cmd.o
  CC      fd/array.o
  CC      core.o
  CC      event-parse.o
  LD      fd/libapi-in.o
  CC      fs/fs.o
  CC      cpumap.o
  CC      help.o
  CC      fs/tracing_path.o
  CC      fs/cgroup.o
  LD      fs/libapi-in.o
  CC      cpu.o
  CC      debug.o
  CC      str_error_r.o
  LD      libapi-in.o
  AR      libapi.a
  CC      event-plugin.o
  CC      pager.o
  CC      threadmap.o
  CC      parse-options.o
  CC      trace-seq.o
  CC      parse-filter.o
  CC      evsel.o
  CC      parse-utils.o
  CC      kbuffer-parse.o
  CC      tep_strerror.o
  CC      event-parse-api.o
  CC      evlist.o
  LD      libtraceevent-in.o
  LINK    libtraceevent.a
  GEN     common-cmds.h
  CC      mmap.o
  CC      run-command.o
  CC      zalloc.o
  CC      xyarray.o
  CC      lib.o
  CC      sigchain.o
  CC      subcmd-config.o
  LD      libsubcmd-in.o
  AR      libsubcmd.a
  GEN     pmu-events/pmu-events.c
  CC      plugin_jbd2.o
  LD      libperf-in.o
  AR      libperf.a
  CC      jvmti/libjvmti.o
  LD      plugin_jbd2-in.o
  CC      plugin_hrtimer.o
  LD      plugin_hrtimer-in.o
  CC      plugin_kmem.o
  LD      plugin_kmem-in.o
  GEN     perf-archive
  CC      plugin_kvm.o
  CC      jvmti/jvmti_agent.o
  LD      plugin_kvm-in.o
  CC      plugin_mac80211.o
  LD      plugin_mac80211-in.o
  CC      plugin_sched_switch.o
  LD      plugin_sched_switch-in.o
  CC      plugin_function.o
  CC      jvmti/libstring.o
  LD      plugin_function-in.o
  CC      plugin_futex.o
  LD      plugin_futex-in.o
  CC      plugin_xen.o
  CC      jvmti/libctype.o
  CC      plugin_scsi.o
  LD      jvmti/jvmti-in.o
  LD      plugin_xen-in.o
  GEN     perf-iostat
  CC      plugin_cfg80211.o
  CC      dlfilters/dlfilter-test-api-v0.o
  LD      plugin_cfg80211-in.o
  LD      plugin_scsi-in.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      plugin_tlb.o
  LD      plugin_tlb-in.o
  CC      builtin-bench.o
  LINK    plugin_jbd2.so
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/bpf_helper_defs.h
  LINK    plugin_hrtimer.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/bpf.h
  CC      pmu-events/pmu-events.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/libbpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/btf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/libbpf_common.h
  LINK    plugin_kmem.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/libbpf_version.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/usdt.bpf.h
  LINK    plugin_kvm.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/libbpf.o
  LINK    plugin_mac80211.so
  LINK    plugin_sched_switch.so
  LINK    plugin_function.so
  CC      builtin-annotate.o
  LINK    plugin_futex.so
  LINK    plugin_xen.so
  LINK    plugin_scsi.so
  LINK    plugin_cfg80211.so
  LINK    plugin_tlb.so
  GEN     libtraceevent-dynamic-list
  LINK    libperf-jvmti.so
  LINK    dlfilters/dlfilter-test-api-v0.so
  LINK    dlfilters/dlfilter-show-cycles.so
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/bpf.o
  LD      pmu-events/pmu-events-in.o
  CC      builtin-config.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/nlattr.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/btf.o
  CC      builtin-diff.o
  GEN     python/perf.so
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/str_error.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/netlink.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/strset.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/linker.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/usdt.o
  CC      builtin-evlist.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af=
2b95dba4548a188c1671/tools/perf/libbpf/libbpf.a
  CC      builtin-ftrace.o
  CC      builtin-help.o
  CC      builtin-sched.o
  CC      builtin-buildid-list.o
  CC      builtin-buildid-cache.o
  CC      builtin-kallsyms.o
  CC      builtin-list.o
  CC      builtin-record.o
  CC      builtin-report.o
  CC      builtin-stat.o
  CC      builtin-timechart.o
  CC      builtin-top.o
  CC      builtin-script.o
  CC      builtin-kmem.o
  CC      builtin-lock.o
  CC      builtin-kvm.o
  CC      builtin-inject.o
  CC      builtin-mem.o
  CC      builtin-data.o
  CC      builtin-version.o
  CC      builtin-c2c.o
  CC      builtin-daemon.o
  CC      builtin-kwork.o
  CC      builtin-trace.o
  CC      builtin-probe.o
  CC      bench/sched-messaging.o
  CC      tests/builtin-test.o
  CC      bench/sched-pipe.o
  CC      bench/syscall.o
  CC      tests/builtin-test-list.o
  CC      bench/mem-functions.o
  CC      tests/parse-events.o
  CC      bench/futex-hash.o
  CC      bench/futex-wake.o
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      bench/futex-wake-parallel.o
  CC      util/annotate.o
  CC      bench/futex-requeue.o
  CC      bench/futex-lock-pi.o
  CC      bench/epoll-wait.o
  CC      bench/epoll-ctl.o
  CC      bench/synthesize.o
  CC      bench/kallsyms-parse.o
  CC      bench/find-bit-bench.o
  CC      tests/dso-data.o
  CC      bench/inject-buildid.o
  CC      tests/attr.o
  CC      bench/evlist-open-close.o
  CC      tests/vmlinux-kallsyms.o
  CC      bench/breakpoint.o
  CC      bench/mem-memcpy-x86-64-asm.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      tests/openat-syscall.o
  CC      bench/numa.o
  CC      tests/openat-syscall-all-cpus.o
  CC      tests/openat-syscall-tp-fields.o
  CC      tests/mmap-basic.o
  CC      tests/perf-record.o
  CC      arch/common.o
  CC      util/block-info.o
  CC      tests/evsel-roundtrip-name.o
  CC      arch/x86/util/header.o
  CC      tests/evsel-tp-sched.o
  CC      arch/x86/util/tsc.o
  CC      tests/fdarray.o
  CC      arch/x86/util/pmu.o
  CC      arch/x86/util/kvm-stat.o
  CC      tests/pmu.o
  LD      bench/perf-in.o
  CC      ui/setup.o
  CC      arch/x86/util/perf_regs.o
  CC      util/block-range.o
  CC      tests/pmu-events.o
  CC      ui/helpline.o
  CC      arch/x86/util/topdown.o
  CC      ui/progress.o
  CC      ui/util.o
  CC      arch/x86/util/machine.o
  CC      util/build-id.o
  CC      ui/hist.o
  CC      arch/x86/util/event.o
  CC      tests/hists_common.o
  CC      arch/x86/util/evlist.o
  CC      arch/x86/util/mem-events.o
  CC      tests/hists_link.o
  CC      arch/x86/util/evsel.o
  CC      util/cacheline.o
  CC      arch/x86/util/iostat.o
  CC      util/config.o
  CC      tests/hists_filter.o
  CC      arch/x86/util/dwarf-regs.o
  CC      arch/x86/util/unwind-libunwind.o
  CC      tests/hists_output.o
  CC      arch/x86/util/auxtrace.o
  CC      arch/x86/util/archinsn.o
  CC      util/copyfile.o
  CC      arch/x86/util/intel-pt.o
  CC      util/ctype.o
  CC      util/db-export.o
  CC      tests/hists_cumulate.o
  CC      util/env.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/python-use.o
  CC      tests/bp_signal.o
  CC      tests/bp_signal_overflow.o
  CC      util/event.o
  LD      arch/x86/util/perf-in.o
  CC      arch/x86/tests/regs_load.o
  CC      arch/x86/tests/dwarf-unwind.o
  CC      tests/bp_account.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/tests/sample-parsing.o
  CC      tests/wp.o
  CC      arch/x86/tests/insn-x86.o
  CC      tests/task-exit.o
  CC      arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC      tests/sw-clock.o
  CC      arch/x86/tests/bp-modify.o
  CC      tests/mmap-thread-lookup.o
  CC      util/evlist.o
  LD      arch/x86/tests/perf-in.o
  LD      arch/x86/perf-in.o
  LD      arch/perf-in.o
  CC      ui/stdio/hist.o
  CC      tests/thread-maps-share.o
  CC      ui/browser.o
  CC      tests/switch-tracking.o
  CC      ui/browsers/annotate.o
  CC      tests/keep-tracking.o
  CC      tests/code-reading.o
  CC      ui/browsers/hists.o
  CC      tests/sample-parsing.o
  CC      ui/browsers/map.o
  CC      util/evlist-hybrid.o
  CC      tests/parse-no-sample-id-all.o
  CC      ui/browsers/scripts.o
  CC      tests/kmod-path.o
  CC      util/sideband_evlist.o
  CC      ui/browsers/header.o
  CC      util/evsel.o
  CC      tests/thread-map.o
  CC      ui/browsers/res_sample.o
  CC      tests/llvm.o
  CC      tests/bpf.o
  CC      scripts/perl/Perf-Trace-Util/Context.o
  CC      tests/topology.o
  CC      tests/mem.o
  LD      scripts/perl/Perf-Trace-Util/perf-in.o
  CC      scripts/python/Perf-Trace-Util/Context.o
  CC      tests/cpumap.o
  CC      tests/stat.o
  LD      scripts/python/Perf-Trace-Util/perf-in.o
  LD      scripts/perf-in.o
  CC      trace/beauty/clone.o
  CC      tests/event_update.o
  CC      trace/beauty/fcntl.o
  CC      trace/beauty/flock.o
  CC      tests/event-times.o
  CC      trace/beauty/fsmount.o
  CC      trace/beauty/fspick.o
  CC      trace/beauty/ioctl.o
  CC      tests/expr.o
  CC      trace/beauty/kcmp.o
  CC      trace/beauty/mount_flags.o
  LD      ui/browsers/perf-in.o
  CC      ui/tui/setup.o
  CC      trace/beauty/move_mount.o
  CC      trace/beauty/pkey_alloc.o
  CC      tests/backward-ring-buffer.o
  CC      ui/tui/util.o
  CC      trace/beauty/arch_prctl.o
  CC      trace/beauty/prctl.o
  CC      tests/sdt.o
  CC      ui/tui/helpline.o
  CC      trace/beauty/renameat.o
  CC      trace/beauty/sockaddr.o
  CC      tests/is_printable_array.o
  CC      ui/tui/progress.o
  CC      tests/bitmap.o
  CC      trace/beauty/socket.o
  LD      ui/tui/perf-in.o
  CC      trace/beauty/statx.o
  LD      ui/perf-in.o
  CC      tests/perf-hooks.o
  CC      perf.o
  CC      trace/beauty/sync_file_range.o
  CC      tests/clang.o
  CC      tests/unit_number__scnprintf.o
  CC      trace/beauty/tracepoints/x86_irq_vectors.o
  CC      tests/mem2node.o
  CC      trace/beauty/tracepoints/x86_msr.o
  CC      tests/maps.o
  LD      trace/beauty/tracepoints/perf-in.o
  LD      trace/beauty/perf-in.o
  CC      tests/time-utils-test.o
  CC      tests/genelf.o
  CC      util/evsel_fprintf.o
  CC      tests/api-io.o
  CC      tests/demangle-java-test.o
  CC      tests/demangle-ocaml-test.o
  CC      tests/pfm.o
  CC      util/perf_event_attr_fprintf.o
  CC      tests/parse-metric.o
  CC      tests/pe-file-parsing.o
  CC      tests/expand-cgroup.o
  CC      tests/perf-time-to-tsc.o
  CC      tests/dlfilter-test.o
  CC      tests/sigtrap.o
  CC      util/evswitch.o
  CC      util/find_bit.o
  CC      tests/dwarf-unwind.o
  CC      util/get_current_dir_name.o
  CC      util/kallsyms.o
  CC      util/levenshtein.o
  CC      util/llvm-utils.o
  CC      tests/llvm-src-base.o
  CC      tests/llvm-src-kbuild.o
  CC      util/mmap.o
  CC      tests/llvm-src-prologue.o
  CC      tests/llvm-src-relocation.o
  CC      util/memswap.o
  LD      tests/perf-in.o
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
  CC      util/values.o
  CC      util/debug.o
  CC      util/fncache.o
  CC      util/machine.o
  CC      util/map.o
  CC      util/maps.o
  CC      util/pstack.o
  CC      util/session.o
  CC      util/sample-raw.o
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  CC      util/syscalltbl.o
  CC      util/ordered-events.o
  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/thread_map.o
  CC      util/trace-event-parse.o
  CC      util/parse-events-bison.o
  BISON   util/pmu-bison.c
  CC      util/pmu-hybrid.o
  CC      util/trace-event-read.o
  CC      util/trace-event-info.o
  CC      util/trace-event-scripting.o
  CC      util/trace-event.o
  CC      util/svghelper.o
  CC      util/sort.o
  CC      util/hist.o
  CC      util/util.o
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
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      util/scripting-engines/trace-event-perl.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  LD      util/arm-spe-decoder/perf-in.o
  CC      util/intel-pt.o
  CC      util/scripting-engines/trace-event-python.o
  CC      util/intel-bts.o
  CC      util/arm-spe.o
  LD      util/scripting-engines/perf-in.o
  CC      util/s390-cpumsf.o
  CC      util/parse-branch-options.o
  CC      util/dump-insn.o
  CC      util/parse-regs-options.o
  CC      util/parse-sublevel-options.o
  CC      util/term.o
  CC      util/help-unknown-cmd.o
  CC      util/dlfilter.o
  CC      util/mem-events.o
  CC      util/vsprintf.o
  CC      util/units.o
  CC      util/time-utils.o
  BISON   util/expr-bison.c
  CC      util/branch.o
  CC      util/mem2node.o
  CC      util/clockid.o
  CC      util/list_sort.o
  CC      util/mutex.o
  CC      util/bpf-loader.o
  CC      util/bpf_map.o
  CC      util/bpf-prologue.o
  CC      util/symbol-elf.o
  CC      util/probe-file.o
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC      util/probe-event.o
  CC      util/probe-finder.o
  LD      util/intel-pt-decoder/perf-in.o
  CC      util/dwarf-aux.o
  CC      util/dwarf-regs.o
  CC      util/unwind-libunwind-local.o
  CC      util/unwind-libunwind.o
  CC      util/data-convert-bt.o
  CC      util/data-convert-json.o
  CC      util/zlib.o
  CC      util/lzma.o
  CC      util/zstd.o
  CC      util/cap.o
  CC      util/demangle-ocaml.o
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
  CC      util/pmu-bison.o
  FLEX    util/expr-flex.c
  CC      util/expr-bison.o
  CC      util/parse-events.o
  CC      util/parse-events-flex.o
  CC      util/pmu.o
  CC      util/pmu-flex.o
  CC      util/expr-flex.o
  CC      util/expr.o
  LD      util/perf-in.o
  LD      perf-in.o
  LINK    perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf'
2022-10-05 19:46:52 cd /usr/src/perf_selftests-x86_64-rhel-8.3-func-6381739=
8b945c74929af2b95dba4548a188c1671/tools/perf
2022-10-05 19:46:52 mkdir -p /pkg
2022-10-05 19:46:52 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3-func
2022-10-05 19:46:53 cp /pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c=
74929af2b95dba4548a188c1671/vmlinux.xz /tmp
2022-10-05 19:46:53 unxz -k /tmp/vmlinux.xz
2022-10-05 19:46:56 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3-fu=
nc
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2022-10-05 19:46:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 1
  1: vmlinux symtab matches kallsyms                                 : Ok
2022-10-05 19:46:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 2
  2: Detect openat syscall event                                     : Ok
2022-10-05 19:46:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 3
  3: Detect openat syscall event on all cpus                         : Ok
2022-10-05 19:46:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 4
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
2022-10-05 19:46:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 5
  5: Test data source output                                         : Ok
2022-10-05 19:46:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 6
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
2022-10-05 19:47:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 7
  7: Simple expression parser                                        : Ok
2022-10-05 19:47:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 8
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
2022-10-05 19:47:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 9
  9: Parse perf pmu format                                           : Ok
2022-10-05 19:47:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 11
 11: DSO data read                                                   : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 12
 12: DSO data cache                                                  : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 13
 13: DSO data reopen                                                 : Ok
2022-10-05 19:47:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 14
 14: Roundtrip evsel->name                                           : Ok
2022-10-05 19:47:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 15
 15: Parse sched tracepoints fields                                  : Ok
2022-10-05 19:47:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 16
 16: syscalls:sys_enter_openat event fields                          : Ok
2022-10-05 19:47:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 17
 17: Setup struct perf_event_attr                                    : FAIL=
ED!
2022-10-05 19:47:15 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 18
 18: Match and link multiple hists                                   : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 19
 19: 'import perf' in python                                         : FAIL=
ED!
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 20
 20: Breakpoint overflow signal handler                              : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 21
 21: Breakpoint overflow sampling                                    : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 22
 22: Breakpoint accounting                                           : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 23
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip=
 (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 24
 24: Number of exit events of a simple workload                      : Ok
2022-10-05 19:47:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 25
 25: Software clock events period values                             : Ok
2022-10-05 19:47:17 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 26
 26: Object code reading                                             : Ok
2022-10-05 19:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 27
 27: Sample parsing                                                  : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 28
 28: Use a dummy software event to keep tracking                     : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 29
 29: Parse with no sample_id_all bit set                             : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 30
 30: Filter hist entries                                             : Ok
2022-10-05 19:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 31
 31: Lookup mmap thread                                              : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 32
 32: Share thread maps                                               : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 33
 33: Sort output of hist entries                                     : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 34
 34: Cumulate child hist entries                                     : Ok
2022-10-05 19:47:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 35
 35: Track with sched_switch                                         : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 36
 36: Filter fds with revents mask in a fdarray                       : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 37
 37: Add fd to a fdarray, making it autogrow                         : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 38
 38: kmod_path__parse                                                : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 39
 39: Thread map                                                      : Ok
2022-10-05 19:47:26 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 41
 41: Session topology                                                : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 43
 43: Synthesize thread map                                           : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 44
 44: Remove thread map                                               : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 45
 45: Synthesize cpu map                                              : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 46
 46: Synthesize stat config                                          : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 47
 47: Synthesize stat                                                 : Ok
2022-10-05 19:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 48
 48: Synthesize stat round                                           : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 49
 49: Synthesize attr update                                          : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 50
 50: Event times                                                     : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 51
 51: Read backward ring buffer                                       : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 52
 52: Print cpu map                                                   : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 53
 53: Merge cpu map                                                   : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 54
 54: Probe SDT events                                                : Ok
2022-10-05 19:47:28 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 55
 55: is_printable_array                                              : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 56
 56: Print bitmap                                                    : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 57
 57: perf hooks                                                      : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 59
 59: unit_number__scnprintf                                          : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 60
 60: mem2node                                                        : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 61
 61: time utils                                                      : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 62
 62: Test jit_write_elf                                              : Ok
2022-10-05 19:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               : Skip=
 (not compiled in)
 63.2: test groups of --pfm-events                                   : Skip=
 (not compiled in)
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 64
 64: Test api io                                                     : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 65
 65: maps__merge_in                                                  : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 66
 66: Demangle Java                                                   : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 67
 67: Demangle OCaml                                                  : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 68
 68: Parse and process metrics                                       : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 69
 69: PE file support                                                 : Ok
2022-10-05 19:47:30 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 70
 70: Event expansion for cgroups                                     : Ok
2022-10-05 19:47:31 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 71
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
2022-10-05 19:47:31 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 72
 72: dlfilter C API                                                  : FAIL=
ED!
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 73
 73: Sigtrap                                                         : Ok
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 74
 74: Test dwarf unwind                                               : Ok
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 75
 75: x86 instruction decoder - new instructions                      : Ok
2022-10-05 19:47:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 76
 76: Intel PT packet decoder                                         : Ok
2022-10-05 19:47:33 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 77
 77: x86 bp modify                                                   : Ok
2022-10-05 19:47:33 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 78
 78: x86 Sample parsing                                              : Ok
2022-10-05 19:47:33 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 79
 79: build id cache operations                                       : FAIL=
ED!
2022-10-05 19:47:34 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 80
 80: daemon operations                                               : Ok
2022-10-05 19:47:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 81
 81: perf pipe recording and injection test                          : Ok
2022-10-05 19:47:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 83
 83: probe libc's inet_pton & backtrace it with ping                 : Ok
2022-10-05 19:48:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 85
 85: Zstd perf.data compression/decompression                        : Ok
2022-10-05 19:48:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 86
 86: perf record tests                                               : Ok
2022-10-05 19:48:08 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 87
 87: perf record offcpu profiling tests                              : Skip
2022-10-05 19:48:09 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 88
 88: perf stat CSV output linter                                     : Ok
2022-10-05 19:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 89
 89: perf stat csv summary test                                      : Ok
2022-10-05 19:48:14 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 90
 90: perf stat JSON output linter                                    : Ok
2022-10-05 19:48:17 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 91
 91: perf stat metrics (shadow stat) test                            : Ok
2022-10-05 19:48:21 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 92
 92: perf stat tests                                                 : Ok
2022-10-05 19:48:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 93
 93: perf all metricgroups test                                      : Ok
2022-10-05 19:48:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 94
 94: perf all metrics test                                           : Skip
2022-10-05 19:50:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 95
 95: perf all PMU test                                               : Ok
2022-10-05 19:52:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 96
 96: perf stat --bpf-counters test                                   : Skip
2022-10-05 19:52:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 97
 97: Check Arm64 callgraphs are complete in fp mode                  : Skip
2022-10-05 19:52:55 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 98
 98: Check Arm CoreSight trace data recording and synthesized samples: Skip
2022-10-05 19:52:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 99
 99: Check Arm SPE trace data recording and synthesized samples      : Skip
2022-10-05 19:52:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 100
100: Check Arm SPE doesn't hang when there are forks                 : Skip
2022-10-05 19:52:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 101
101: Check branch stack sampling                                     : Ok
2022-10-05 19:53:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817=
398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 102
102: Miscellaneous Intel PT testing                                  : Skip

--FbvI2xqxR74DaVf1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/perf-sanity-tests.yaml
suite: perf-sanity-tests
testcase: perf-sanity-tests
category: functional
need_memory: 2G
perf-sanity-tests:
  perf_compiler: gcc
job_origin: perf-sanity-tests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 633dafa95bb321de4e8c9765
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-63817398b945c74929af2b95dba4548a188c1671-20221006-56910-80a4s9-0.yaml"
id: e225b829b599a9d94d9a4972868cc432b81a03f1
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/perf-sanity-tests
initrds:
- linux_perf

#! include/queue/cyclic
commit: 63817398b945c74929af2b95dba4548a188c1671

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-10-06 00:24:09.940869841 +08:00
_id: 633dafa95bb321de4e8c9765
_rt: "/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: d3e2e4231f05d65af74d9aa3b1b1f12edaf5ca3b
base_commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
branch: linux-devel/devel-hourly-20220904-172230
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/vmlinuz-6.0.0-rc3-00037-g63817398b945
- branch=linux-devel/devel-hourly-20220904-172230
- job=/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-63817398b945c74929af2b95dba4548a188c1671-20221006-56910-80a4s9-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=63817398b945c74929af2b95dba4548a188c1671
- max_uptime=2100
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/modules.cgz"
linux_perf_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/linux-perf.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20221001.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-b357fd1c2afc-1_20221001.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20220902193257/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:

#! runtime status
last_kernel: 6.0.0-wt-ath-13609-gc5b4c66ff832

#! /db/releases/20221001004130/lkp-src/include/site/inn
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/vmlinuz-6.0.0-rc3-00037-g63817398b945"
dequeue_time: 2022-10-06 01:06:51.143523377 +08:00

#! /db/releases/20221005202439/lkp-src/include/site/inn
job_state: finished
loadavg: 0.75 1.03 0.70 1/135 28394
start_time: '1664989733'
end_time: '1664990237'
version: "/lkp/lkp/.src-20221001-230556:450b29f71:37fc623e4"

--FbvI2xqxR74DaVf1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

make ARCH= EXTRA_CFLAGS=-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address -Wno-array-bounds -C /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf
cd /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf
mkdir -p /pkg
mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3-func
cp /pkg/linux/x86_64-rhel-8.3-func/gcc-11/63817398b945c74929af2b95dba4548a188c1671/vmlinux.xz /tmp
unxz -k /tmp/vmlinux.xz
cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3-func
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 1
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 2
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 3
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 4
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 5
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 6
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 7
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 8
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 9
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 10
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 11
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 12
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 13
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 14
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 15
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 16
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 17
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 18
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 19
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 20
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 21
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 22
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 23
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 24
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 25
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 26
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 27
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 28
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 29
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 30
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 31
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 32
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 33
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 34
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 35
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 36
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 37
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 38
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 39
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 41
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 43
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 44
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 45
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 46
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 47
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 48
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 49
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 50
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 51
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 52
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 53
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 54
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 55
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 56
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 57
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 59
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 60
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 61
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 62
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 63
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 64
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 65
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 66
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 67
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 68
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 69
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 70
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 71
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 72
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 73
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 74
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 75
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 76
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 77
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 78
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 79
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 80
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 81
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 83
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 85
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 86
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 87
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 88
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 89
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 90
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 91
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 92
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 93
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 94
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 95
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 96
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 97
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 98
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 99
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 100
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 101
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-63817398b945c74929af2b95dba4548a188c1671/tools/perf/perf test 102

--FbvI2xqxR74DaVf1--
