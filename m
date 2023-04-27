Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D1B6F00CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjD0G3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbjD0G3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:29:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD01988;
        Wed, 26 Apr 2023 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682576984; x=1714112984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BRx2GxHEYygbYy5biTXLZv8GykpbQSS+JK/eiUrDfHI=;
  b=MsuhSm2YyNCXC+euO1pq/5+OZQ/vV9IhVM7CzDlzgvgbTrreb3aMy/H2
   vcuI2oNPq/xpKOtE57rakjC4Y1en6BLtSIGNU0th5s+mxnKtEJ8W1Ra/0
   rNoBIqFgYkiFpNZdD9lwSKrJBj/7/k4+xA5UsxWN4f9AzZOfRgf+DQvD3
   bx9NZ/JRdGXa5nVA1d0Q9eCChM2Xx48/wchYKwGXUVXePlolw+8SFUmhT
   pwYhlUloRgEyytznLDUcduVyiQfJ8SynSjCl/ufhVhzgbQ4LPjEOFUQWL
   bL6MGaAR79Z3NYw0J3aUEkWOI7/DrQmSAPqqzXPjL0GmwfF6Xsi/0ywwW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="326951279"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="326951279"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="671653459"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="671653459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2023 23:29:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 23:29:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 23:29:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 23:29:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 23:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhPPH/CMXn5spciv7Gb0yHYMnuJMkx6QOBADnrdTg5kzvLyV40Aai8zLydB+zsR85qFis1CibxWQK4KuxSY/rOk7k0Jxd75CBOEyVI3n/myzB+r2DXBglcz1CxlavPcL1zVCWIlFnIbPbGvfFPS9H9glJ3dXZ+ex9m8xVW0NZVlBlrVB7/lhKfp6VPWDu4w3c76H2y0PicdkpW2art88iQwPNFWJedE5olvvruc+AbYiFzLRG6wkHg8t1Rew721WEJz5Ny/y0I1LpZMxAt73OO1XNqU8SI5hZPd429n+IA2bbbGcQjDUgvf7Pb/K5moTEpmIkjvmV930RmVxUleVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwcg+nGEFI13tDVh0F1gqDeTc4e9KrYTDXdHd/Qdok4=;
 b=UOEmBGm+EvH5Z2jfAxE/DqKJf0BJNhtoUnMbcFlZI303Z8m1CN8oufpa39Zh9QVE9mXjgSTDGQ9TZv7RFR83meQR1MYcns775JOlNuXbhs3MIKKTDQMw/X97Tpc/73Qy/4fvw2j4fpONJ9LRFq3F0c7CPP9+QpzzfZrWw+FwtSytjQFRPA89ZkD6tF6nidGGnVg9nhvgXc6rBrgCxADExmD/lkGM+x3MLYITmqN3wispT+FHLB9SchQ4ugchp0x+HlM5ET4jIE2jX2WqpTH1e/+xBwYcQ2DYyAs3A41sH1hLiaVLmkEqh2kut78fiIU1VDisRNQWgVw0pnvU3lOYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 06:29:40 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 06:29:40 +0000
Date:   Thu, 27 Apr 2023 14:26:39 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <kan.liang@linux.intel.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <eranian@google.com>, <ak@linux.intel.com>, <ying.huang@intel.com>
Subject: Re: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
Message-ID: <ZEoVn1ZfYGCTAiZL@yujie-X299>
References: <20230421184529.3320912-2-kan.liang@linux.intel.com>
 <202304251457.d108dbb3-yujie.liu@intel.com>
 <20230425111955.GB1335080@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230425111955.GB1335080@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f419fca-9f0c-428c-11e4-08db46e8c798
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJv13rQlOKS/bX0tbfSxZUWQObfvvewsZDS+vziKLD3ZJLaFPZSKMY4IztH6TPWeWdX8ypFLIGXYz8iW9ro44ih/wC2GDr3jEqvWpy3keoVJXrKDhexL4NSAuo+2cIy7AqL4wmw6blFmceja64DGWuXWLZlfsmGwObMvI4QTEiNxfHu7+gz7mkDAto6obnlij5BRheLxZlRcFhx2k2HDSUSyOOd6LQtZCbgKvrnKpKyZMTHEt9gCg74PthVRG9L0Tb0p3Dy+1dM8donE58psLmZLvr+a/LmhfF7Lo7m6jaF69MQ4P8JjBPX7XfYW9GCnx87QPNPWeg6HqTPl5bhGUOo5JWDDSWnEH3sXrQ6gaXdp9TYNNMUp+Sh7iHT3ad4ylYs9GqH8a5gK9r+Fw9UW7ACn8tBMlWf6AUvtd+kOkL8Rfvl6vwYx93Czxml/NOl/3OIyDt5MtneZ6nxPJXFrPaRiw78ayvHTpxBGRFJG2icnpO2UFAikTYv6kl/CYTLESRUUIBQNpX0pjAzum69ZlTUhcmj/+mJ2gKvgIDKMe3de3R224DftEjOvJH2zjkt2dQx5KK9u48/Q56B0g3qtKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(82960400001)(45080400002)(478600001)(33716001)(83380400001)(6486002)(186003)(38100700002)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(41300700001)(6512007)(6506007)(30864003)(26005)(9686003)(86362001)(8676002)(8936002)(44832011)(2906002)(5660300002)(966005)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQQ+tf96A1AO731ZjEXr4o2GVSPmLij5aTcNll/vJ5rteOYPiAtBI1MjwipJ?=
 =?us-ascii?Q?5TzijM64ujscJrFwMO9d22XexCtRLD4PP6V0FWQcRaFveazilxxIXXrhfahc?=
 =?us-ascii?Q?6Njnppd2mvOW6PjPL06ewQqGGXkfpj3IPdkQDmnSScrQ4EfDxQHOGBHpMr0P?=
 =?us-ascii?Q?TUgU9POaxW4LQ+7tO48Y6HK6AQXYTnKWUOvw5jWIF170txQQHcIF132LG/uV?=
 =?us-ascii?Q?qD2AxyGNdAHL9SbHw/uRjrVc3qcsjsA68QXN37dEwWoeNMMVwszC3E3jkApQ?=
 =?us-ascii?Q?Gt3X3PYNzmf9h7ENFF1akNNZp7abn359OnlidWE0B1zYOqfW+7b36RsIqX6o?=
 =?us-ascii?Q?rpLKWT1MoGk5pQQ74aoDv8Mb1GbjH5bCieqP5V6XQq6ApCVrDJ/iEQIIoZWO?=
 =?us-ascii?Q?/P3j+Xe/i3kf3jaUxRsp8vhgyTamKENFFpddBc4L2xNYlkXCFXb8ddN80hhi?=
 =?us-ascii?Q?AdlM8b+3EMd85x+JnHTrJet8l9PiuTG8iNAIZ/YmiiSLr27lJUoVyDJAmTZz?=
 =?us-ascii?Q?qP1i5rDRZ/aD/LJImiGb2zCAchgAC3YKQAkdUesgCeyDSGUk8g4bJ3QuJenV?=
 =?us-ascii?Q?tTxjNmBnV9IaOPVkvaxF33VVhSR8XAVv0w4HeqWA1lfTI3A267EdlO6ccC6u?=
 =?us-ascii?Q?YlzLX45Ay8q9sAvjbhZSxUT4iwrr/S/zY2vHn9Dfc4N7YpJ+LKTnPiPS23+Z?=
 =?us-ascii?Q?CiN1Ee6DCRQb3Tc2yLfNlBfP3lTkjpoYLzdHbkqR/Iphr1geFdfeScvpQi83?=
 =?us-ascii?Q?+4x4CwEiH4Cg5eQDUHmG/9f2jJKeCPJApCSfO5LyEeKocSIMPqWfgpUJm3cS?=
 =?us-ascii?Q?ScgP9Hwb5G8ZktLzGDie1Uoy0OMs4o5G+Ayc0iyD3j4h5BKJmhRIHPId0knN?=
 =?us-ascii?Q?Mx5ySBMGx00dPWgWEsjCLSL3QaupEqXzp/S90xFw7gG/iIRGJp+O+kQroxaT?=
 =?us-ascii?Q?e0w6hFhej7r+IJn6nXukezUNA4e1pnkj5g7GwWAI+EnDSrF+WEWvC0+XTLvm?=
 =?us-ascii?Q?7y45jEwDuPcn/JuajlasefusZFZOAtGXfQms2ZeULQAaFKjQwUc65q82vPkj?=
 =?us-ascii?Q?nUZqe3tmbrMTedh4sPp1urvhv8e/k+3W0ELnkQY/9nb7UPeapNaj9S88+8mK?=
 =?us-ascii?Q?MM5yREx8fLLu7mXljeeiLHhJNXI3eXDWRyInojgSs5IUNN691fJ0egEAQBWn?=
 =?us-ascii?Q?SQs/jdsoD32GtXXYLQtHa2daJ9WvqfPSAkmo1B+bqfSjVYF/zQZ0qbHF5JIf?=
 =?us-ascii?Q?HPAARbsDUxfqPGN5XUfhg15MVzLFA4MuRwGeddbOJWHU1LQ1zpQnWZpkiVLA?=
 =?us-ascii?Q?1GVC7LDnoZsIeLhJ1tmtM5GAaAkTtiLxynUPhkmQLosmWbiwGUIYvKfmC3K3?=
 =?us-ascii?Q?zsS3UTI5UUSnJIIEZF2GK/OY2ZdlazaNYdpImltCUSvF8igoQEaV+2aOgTWo?=
 =?us-ascii?Q?7A2EyEn0+Fs+AA9jxWmHuJDoex1HyZ/AbNwhQxCTHnPBya74w4rTv++YHQaf?=
 =?us-ascii?Q?8l32QMVfBmyNoixyT6c3h3QVl4B69lGtGm9sqGamyAYQlNOLD/N3E0ERqhl4?=
 =?us-ascii?Q?mZJ6mOrXgp5Bt+lQ9ttT/fuix+38xEoKOVxrYrsT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f419fca-9f0c-428c-11e4-08db46e8c798
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:29:40.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fauCLHpu/wxsLLa+Wg2rXz9iJhHI5YqiykRpWbXjwO9grgqQr4r1a1pinKcofJWYAPXYXeeItHC4+Rb3c0e8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Apr 25, 2023 at 01:19:55PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 03:16:29PM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed "Kernel_panic-not_syncing:Timeout:Not_all_CPUs_entered_broadcast_exception_handler" on:
> > 
> > commit: a17c97370d1fb9b2eac75c85136a1f70ec44eded ("[PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update")
> > url: https://github.com/intel-lab-lkp/linux/commits/kan-liang-linux-intel-com/perf-x86-intel-ds-Delay-the-threshold-update/20230422-024743
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 15def34e2635ab7e0e96f1bc32e1b69609f14942
> > patch link: https://lore.kernel.org/all/20230421184529.3320912-2-kan.liang@linux.intel.com/
> > patch subject: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
> > 
> 
> > [  224.064675][   C84] mce: CPUs not responding to MCE broadcast (may include false positives): 0-83,85-223
> > [  224.064681][   C84] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> > [  225.089881][   C84] Shutting down cpus with NMI
> > [  225.129381][   C84] Kernel Offset: disabled
> 
> That seems very unrelated to the patch at hand; was this bisect double
> checked?

We rechecked this case and the bisect should be valid.

We also ran this test on different platforms. The issue can be
reproduced on Sapphire Rapids and Ice Lake. The same thing is they
have a similar "split lock detection" warning when the test started,
but with different dmesg after that. The issue cannot be reproduced
on Cascade Lake.

Another thing to note is that the patchset was applied on commit
15def34e2635 of tip tree (the head of perf/core branch then). Not sure
if this is the correct base to test it.

Please check the details as below:

== Sapphire Rapids ==

# tail of dmesg

[  217.823350][T24250] x86/split lock detection: #AC: qemu-system-x86/24250 took a split_lock trap at address: 0x1e3
[  222.633517][  C218] mce: CPUs not responding to MCE broadcast (may include false positives): 0-217,219-223
[  222.633523][  C218] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
[  223.663277][  C218] Shutting down cpus with NMI
[  223.704639][  C218] Kernel Offset: disabled
[  232.753628][  C218] pstore: backend (erst) writing error (-28)

# result comparison

tbox_group/testcase/rootfs/kconfig/compiler:
  lkp-spr-2sp1/kvm-unit-tests-qemu/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kvm/gcc-11

commit: 
  1283dc16325e3 ("perf/x86/intel/ds: Flush the PEBS buffer in PEBS enable")
  a17c97370d1fb ("perf/x86/intel/ds: Delay the threshold update")

1283dc16325e3b9d a17c97370d1fb9b2eac75c85136 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6           83%           5:6     dmesg.Kernel_panic-not_syncing:Timeout:Not_all_CPUs_entered_broadcast_exception_handler


== Ice Lake ==

# tail of dmesg

[  234.463750][T23542] x86/split lock detection: #AC: qemu-system-x86/23542 took a split_lock trap at address: 0x1e3
[  261.554115][   C48] watchdog: BUG: soft lockup - CPU#48 stuck for 26s! [kworker/48:1:933]
[  261.563287][   C48] Modules linked in: kvm_intel kvm irqbypass btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ipmi_ssif sha512_ssse3 rapl ast ahci drm_shmem_helper libahci drm_kms_helper intel_cstate acpi_ipmi mei_me ipmi_si syscopyarea ioatdma sysfillrect ipmi_devintf libata sysimgblt mei intel_uncore wmi dca joydev ipmi_msghandler acpi_pad acpi_power_meter drm fuse ip_tables [last unloaded: irqbypass]
[  261.622458][   C48] CPU: 48 PID: 933 Comm: kworker/48:1 Not tainted 6.3.0-rc3-00006-ga17c97370d1f #1
[  261.632557][   C48] Workqueue: events jump_label_update_timeout
[ 261.639444][ C48] RIP: 0010:smp_call_function_many_cond (kernel/smp.c:442 kernel/smp.c:987)
[ 261.646846][ C48] Code: 38 c8 7c 08 84 c9 0f 85 16 05 00 00 8b 45 08 a8 01 74 2e 48 89 f1 49 89 f7 48 c1 e9 03 41 83 e7 07 4c 01 f1 41 83 c7 03 f3 90 <0f> b6 01 41 38 c7 7c 08 84 c0 0f 85 20 04 00 00 8b 45 08 a8 01 75
All code
========
   0:   38 c8                   cmp    %cl,%al
   2:   7c 08                   jl     0xc
   4:   84 c9                   test   %cl,%cl
   6:   0f 85 16 05 00 00       jne    0x522
   c:   8b 45 08                mov    0x8(%rbp),%eax
   f:   a8 01                   test   $0x1,%al
  11:   74 2e                   je     0x41
  13:   48 89 f1                mov    %rsi,%rcx
  16:   49 89 f7                mov    %rsi,%r15
  19:   48 c1 e9 03             shr    $0x3,%rcx
  1d:   41 83 e7 07             and    $0x7,%r15d
  21:   4c 01 f1                add    %r14,%rcx
  24:   41 83 c7 03             add    $0x3,%r15d
  28:   f3 90                   pause
  2a:*  0f b6 01                movzbl (%rcx),%eax              <-- trapping instruction
  2d:   41 38 c7                cmp    %al,%r15b
  30:   7c 08                   jl     0x3a
  32:   84 c0                   test   %al,%al
  34:   0f 85 20 04 00 00       jne    0x45a
  3a:   8b 45 08                mov    0x8(%rbp),%eax
  3d:   a8 01                   test   $0x1,%al
  3f:   75                      .byte 0x75

Code starting with the faulting instruction
===========================================
   0:   0f b6 01                movzbl (%rcx),%eax
   3:   41 38 c7                cmp    %al,%r15b
   6:   7c 08                   jl     0x10
   8:   84 c0                   test   %al,%al
   a:   0f 85 20 04 00 00       jne    0x430
  10:   8b 45 08                mov    0x8(%rbp),%eax
  13:   a8 01                   test   $0x1,%al
  15:   75                      .byte 0x75
[  261.668227][   C48] RSP: 0018:ffa000000af07be8 EFLAGS: 00000202
[  261.675122][   C48] RAX: 0000000000000011 RBX: ff1100202043aa40 RCX: ffe21c04041980ed
[  261.683923][   C48] RDX: 0000000000000061 RSI: ff11002020cc0768 RDI: ffffffff841ecbc8
[  261.692703][   C48] RBP: ff11002020cc0760 R08: 0000000000000000 R09: ff11001083a9b867
[  261.701490][   C48] R10: ffe21c021075370c R11: 0000000000000001 R12: ffe21c0404087549
[  261.710264][   C48] R13: ffe21c0404087548 R14: dffffc0000000000 R15: 0000000000000003
[  261.719023][   C48] FS:  0000000000000000(0000) GS:ff11002020400000(0000) knlGS:0000000000000000
[  261.728751][   C48] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  261.736129][   C48] CR2: 00007f41400060a8 CR3: 000000207e246002 CR4: 0000000000773ee0
[  261.744887][   C48] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  261.753644][   C48] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  261.762385][   C48] PKRU: 55555554
[  261.766683][   C48] Call Trace:
[  261.770714][   C48]  <TASK>
[ 261.774389][ C48] ? optimize_nops (arch/x86/kernel/alternative.c:1764)
[ 261.779882][ C48] on_each_cpu_cond_mask (arch/x86/include/asm/preempt.h:85 kernel/smp.c:1156)
[ 261.785707][ C48] text_poke_bp_batch (include/linux/smp.h:71 arch/x86/kernel/alternative.c:1770 arch/x86/kernel/alternative.c:1970)
[ 261.791446][ C48] ? do_sync_core (arch/x86/kernel/alternative.c:1940)
WARNING! Modules path isn't set, but is needed to parse this symbol
[ 261.796644][ C48] ? kvm_irq_delivery_to_apic+0x31c/0x890 kvm
[ 261.803629][ C48] ? __cond_resched (kernel/sched/core.c:8486)
[ 261.808993][ C48] ? mutex_lock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:443 include/linux/atomic/atomic-instrumented.h:1781 kernel/locking/mutex.c:171 kernel/locking/mutex.c:285)
[ 261.813986][ C48] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282)
[ 261.819917][ C48] ? kernel_text_address (kernel/extable.c:119 kernel/extable.c:94)
[ 261.825681][ C48] text_poke_finish (arch/x86/kernel/alternative.c:2162 arch/x86/kernel/alternative.c:2158 arch/x86/kernel/alternative.c:2168)
[ 261.830991][ C48] arch_jump_label_transform_apply (arch/x86/kernel/jump_label.c:147)
[ 261.837598][ C48] __static_key_slow_dec_cpuslocked+0x3d/0x50
[ 261.844899][ C48] jump_label_update_timeout (kernel/jump_label.c:292)
[ 261.850966][ C48] process_one_work (kernel/workqueue.c:2395)
[ 261.856506][ C48] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2538)
[ 261.861697][ C48] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) arch/x86/include/asm/bitops.h:239 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 4) kernel/kthread.c:270 (discriminator 4))
[ 261.867219][ C48] ? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6699 (discriminator 1))
[ 261.872116][ C48] ? process_one_work (kernel/workqueue.c:2480)
[ 261.877879][ C48] ? process_one_work (kernel/workqueue.c:2480)
[ 261.883622][ C48] kthread (kernel/kthread.c:376)
[ 261.888220][ C48] ? kthread_complete_and_exit (kernel/kthread.c:331)
[ 261.894381][ C48] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  261.899315][   C48]  </TASK>
[  261.902834][   C48] Kernel panic - not syncing: softlockup: hung tasks
[  261.909991][   C48] CPU: 48 PID: 933 Comm: kworker/48:1 Tainted: G             L     6.3.0-rc3-00006-ga17c97370d1f #1
[  261.921226][   C48] Workqueue: events jump_label_update_timeout
[  261.927764][   C48] Call Trace:
[  261.931505][   C48]  <IRQ>
[ 261.934778][ C48] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
[ 261.939688][ C48] panic (kernel/panic.c:340)
[ 261.943981][ C48] ? panic_smp_self_stop+0x70/0x70
[ 261.949482][ C48] ? add_taint (arch/x86/include/asm/bitops.h:60 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/panic.c:539)
[ 261.954103][ C48] watchdog_timer_fn (kernel/watchdog.c:435)
[ 261.959397][ C48] ? lockup_detector_update_enable (kernel/watchdog.c:355)
[ 261.965721][ C48] __hrtimer_run_queues (kernel/time/hrtimer.c:1685 kernel/time/hrtimer.c:1749)
[ 261.971263][ C48] ? sched_clock_cpu (kernel/sched/clock.c:384)
[ 261.976454][ C48] ? enqueue_hrtimer (kernel/time/hrtimer.c:1719)
[ 261.981725][ C48] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161)
[ 261.987864][ C48] ? ktime_get_update_offsets_now (kernel/time/timekeeping.c:292 (discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3) kernel/time/timekeeping.c:2320 (discriminator 3))
[ 261.994181][ C48] hrtimer_interrupt (kernel/time/hrtimer.c:1814)
[ 261.999450][ C48] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1114)
[ 262.005670][ C48] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1107 (discriminator 14))
[  262.011616][   C48]  </IRQ>
[  262.014869][   C48]  <TASK>
[ 262.018126][ C48] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645)
[ 262.024418][ C48] RIP: 0010:smp_call_function_many_cond (kernel/smp.c:442 kernel/smp.c:987)
[ 262.031329][ C48] Code: 38 c8 7c 08 84 c9 0f 85 16 05 00 00 8b 45 08 a8 01 74 2e 48 89 f1 49 89 f7 48 c1 e9 03 41 83 e7 07 4c 01 f1 41 83 c7 03 f3 90 <0f> b6 01 41 38 c7 7c 08 84 c0 0f 85 20 04 00 00 8b 45 08 a8 01 75
All code
========
   0:   38 c8                   cmp    %cl,%al
   2:   7c 08                   jl     0xc
   4:   84 c9                   test   %cl,%cl
   6:   0f 85 16 05 00 00       jne    0x522
   c:   8b 45 08                mov    0x8(%rbp),%eax
   f:   a8 01                   test   $0x1,%al
  11:   74 2e                   je     0x41
  13:   48 89 f1                mov    %rsi,%rcx
  16:   49 89 f7                mov    %rsi,%r15
  19:   48 c1 e9 03             shr    $0x3,%rcx
  1d:   41 83 e7 07             and    $0x7,%r15d
  21:   4c 01 f1                add    %r14,%rcx
  24:   41 83 c7 03             add    $0x3,%r15d
  28:   f3 90                   pause
  2a:*  0f b6 01                movzbl (%rcx),%eax              <-- trapping instruction
  2d:   41 38 c7                cmp    %al,%r15b
  30:   7c 08                   jl     0x3a
  32:   84 c0                   test   %al,%al
  34:   0f 85 20 04 00 00       jne    0x45a
  3a:   8b 45 08                mov    0x8(%rbp),%eax
  3d:   a8 01                   test   $0x1,%al
  3f:   75                      .byte 0x75

Code starting with the faulting instruction
===========================================
   0:   0f b6 01                movzbl (%rcx),%eax
   3:   41 38 c7                cmp    %al,%r15b
   6:   7c 08                   jl     0x10
   8:   84 c0                   test   %al,%al
   a:   0f 85 20 04 00 00       jne    0x430
  10:   8b 45 08                mov    0x8(%rbp),%eax
  13:   a8 01                   test   $0x1,%al
  15:   75                      .byte 0x75
[  262.051777][   C48] RSP: 0018:ffa000000af07be8 EFLAGS: 00000202
[  262.058210][   C48] RAX: 0000000000000011 RBX: ff1100202043aa40 RCX: ffe21c04041980ed
[  262.066559][   C48] RDX: 0000000000000061 RSI: ff11002020cc0768 RDI: ffffffff841ecbc8
[  262.074915][   C48] RBP: ff11002020cc0760 R08: 0000000000000000 R09: ff11001083a9b867
[  262.083270][   C48] R10: ffe21c021075370c R11: 0000000000000001 R12: ffe21c0404087549
[  262.091623][   C48] R13: ffe21c0404087548 R14: dffffc0000000000 R15: 0000000000000003
[ 262.099983][ C48] ? smp_call_function_many_cond (kernel/smp.c:983 (discriminator 1))
[ 262.106355][ C48] ? optimize_nops (arch/x86/kernel/alternative.c:1764)
[ 262.111513][ C48] on_each_cpu_cond_mask (arch/x86/include/asm/preempt.h:85 kernel/smp.c:1156)
[ 262.117014][ C48] text_poke_bp_batch (include/linux/smp.h:71 arch/x86/kernel/alternative.c:1770 arch/x86/kernel/alternative.c:1970)
[ 262.122431][ C48] ? do_sync_core (arch/x86/kernel/alternative.c:1940)
WARNING! Modules path isn't set, but is needed to parse this symbol
[ 262.127320][ C48] ? kvm_irq_delivery_to_apic+0x31c/0x890 kvm
[ 262.133997][ C48] ? __cond_resched (kernel/sched/core.c:8486)
[ 262.139055][ C48] ? mutex_lock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:443 include/linux/atomic/atomic-instrumented.h:1781 kernel/locking/mutex.c:171 kernel/locking/mutex.c:285)
[ 262.143768][ C48] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282)
[ 262.149438][ C48] ? kernel_text_address (kernel/extable.c:119 kernel/extable.c:94)
[ 262.154935][ C48] text_poke_finish (arch/x86/kernel/alternative.c:2162 arch/x86/kernel/alternative.c:2158 arch/x86/kernel/alternative.c:2168)
[ 262.159994][ C48] arch_jump_label_transform_apply (arch/x86/kernel/jump_label.c:147)
[ 262.166369][ C48] __static_key_slow_dec_cpuslocked+0x3d/0x50
[ 262.173444][ C48] jump_label_update_timeout (kernel/jump_label.c:292)
[ 262.179304][ C48] process_one_work (kernel/workqueue.c:2395)
[ 262.184641][ C48] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2538)
[ 262.189631][ C48] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) arch/x86/include/asm/bitops.h:239 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 4) kernel/kthread.c:270 (discriminator 4))
[ 262.194965][ C48] ? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6699 (discriminator 1))
[ 262.199676][ C48] ? process_one_work (kernel/workqueue.c:2480)
[ 262.205247][ C48] ? process_one_work (kernel/workqueue.c:2480)
[ 262.210810][ C48] kthread (kernel/kthread.c:376)
[ 262.215250][ C48] ? kthread_complete_and_exit (kernel/kthread.c:331)
[ 262.221254][ C48] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  262.226045][   C48]  </TASK>

# result comparison

compiler/kconfig/rootfs/tbox_group/testcase:
  gcc-11/x86_64-rhel-8.3-kvm/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/kvm-unit-tests-qemu

commit: 
  1283dc16325e3 ("perf/x86/intel/ds: Flush the PEBS buffer in PEBS enable")
  a17c97370d1fb ("perf/x86/intel/ds: Delay the threshold update")

1283dc16325e3b9d a17c97370d1fb9b2eac75c85136 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     dmesg.BUG:soft_lockup-CPU##stuck_for#s![kworker:#:#]
           :6           83%           5:6     dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
           :6          100%           6:6     dmesg.RIP:smp_call_function_many_cond


--
Best Regards,
Yujie
