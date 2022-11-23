Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88AC634BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiKWAdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiKWAdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:33:15 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A297AF47;
        Tue, 22 Nov 2022 16:33:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VVU6y22_1669163586;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVU6y22_1669163586)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 08:33:09 +0800
Date:   Wed, 23 Nov 2022 08:33:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Zirong Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <Y31qPk6+h80cFGXn@B-P7TQMD6M-0146.local>
Mail-Followup-To: Oliver Sang <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Zirong Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <202211220854.48dad6fd-oliver.sang@intel.com>
 <Y3wm8hwPMXcFNjiO@B-P7TQMD6M-0146.local>
 <Y3yeVzzt5WIIHfhm@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3yeVzzt5WIIHfhm@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 06:03:03PM +0800, Oliver Sang wrote:
> hi Gao Xiang,
> 
> On Tue, Nov 22, 2022 at 09:33:38AM +0800, Gao Xiang wrote:
> > On Tue, Nov 22, 2022 at 09:09:34AM +0800, kernel test robot wrote:
> > > 
> > > please be noted we noticed Gao Xiang and Dave Chinner have already had lots of
> > > discussion around this patch, which seems there is maybe new version later.
> > > we just sent out this report FYI the possible performance impact of this patch.
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -15.1% regression of fxmark.ssd_xfs_MWCM_72_directio.works/sec due to commit:
> > 
> > Thanks for your report!
> > 
> > At a glance, I have no idea why this commit can have performance
> > impacts.  Is the result stable?
> 
> in our tests, the result is quite stable.
>      45589           -15.1%      38687 ±  2%  fxmark.ssd_xfs_MWCM_72_directio.works/sec
> 
> and detail data is as below:
> for this commit:
>   "fxmark.ssd_xfs_MWCM_72_directio.works/sec": [
>     39192.224368,
>     39665.690567,
>     38980.680601,
>     37298.99538,
>     37483.256377,
>     39504.606569
>   ],
> 
> for parent:
>   "fxmark.ssd_xfs_MWCM_72_directio.works/sec": [
>     45381.458009,
>     45314.376204,
>     45724.688965,
>     45751.955937,
>     45614.323267,
>     45747.216475
>   ],
> 
> 
> if you still have concern, we could rerun tests. Thanks!

According to the report, I can see:
	67262           -29.6%      47384 ±  7%  fxmark.ssd_xfs_MWCM_18_directio.works/sec
	52786           -15.6%      44567 ±  4%  fxmark.ssd_xfs_MWCM_1_directio.works/sec
	63189           -23.3%      48486 ±  5%  fxmark.ssd_xfs_MWCM_2_directio.works/sec


> 
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > 
> > > commit: ada76f94c5b32c1828955d70f692b111a9ec2d33 ("[PATCH] xfs: account extra freespace btree splits for multiple allocations")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Gao-Xiang/xfs-account-extra-freespace-btree-splits-for-multiple-allocations/20221109-114953
> > > base: https://git.kernel.org/cgit/fs/xfs/xfs-linux.git for-next
> > > patch link: https://lore.kernel.org/all/20221109034802.40322-1-hsiangkao@linux.alibaba.com/
> > > patch subject: [PATCH] xfs: account extra freespace btree splits for multiple allocations
> > > 
> > > in testcase: fxmark
> > > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > > with following parameters:
> > > 
> > > 	disk: 1SSD
> > > 	media: ssd
> > > 	test: MWCM
> > > 	fstype: xfs
> > > 	directio: directio
> > > 	cpufreq_governor: performance
> > > 
> > > test-description: FxMark is a filesystem benchmark that test multicore scalability.
> > > test-url: https://github.com/sslab-gatech/fxmark
> > > 
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Link: https://lore.kernel.org/oe-lkp/202211220854.48dad6fd-oliver.sang@intel.com
> > > 
> > > 
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > > 
> > > 
> > > To reproduce:
> > > 
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         sudo bin/lkp install job.yaml           # job file is attached in this email
> > >         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> > >         sudo bin/lkp run generated-yaml-file
> > > 
> > >         # if come across any failure that blocks the test,
> > >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> > > 
> > > =========================================================================================
> > > compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
> > >   gcc-11/performance/directio/1SSD/xfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWCM/fxmark
> > > 
> > > commit: 
> > >   4eb559dd15 ("Merge tag 'refcount-cow-domain-6.1_2022-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.1-fixesA")
> > >   ada76f94c5 ("xfs: account extra freespace btree splits for multiple allocations")
> > > 
> > > 4eb559dd15671cca ada76f94c5b32c1828955d70f69 
> > > ---------------- --------------------------- 
> > >          %stddev     %change         %stddev
> > >              \          |                \  
> > >     260.92           +90.8%     497.93 ± 13%  fxmark.ssd_xfs_MWCM_18_directio.idle_sec
> > >      29.10           +91.5%      55.74 ± 14%  fxmark.ssd_xfs_MWCM_18_directio.idle_util
> > >       9.11 ±  2%     -17.6%       7.51 ±  8%  fxmark.ssd_xfs_MWCM_18_directio.iowait_sec
> > >       1.02 ±  2%     -17.3%       0.84 ±  8%  fxmark.ssd_xfs_MWCM_18_directio.iowait_util
> > >     617.96           -38.8%     378.15 ± 19%  fxmark.ssd_xfs_MWCM_18_directio.sys_sec
> > >      68.93           -38.6%      42.31 ± 18%  fxmark.ssd_xfs_MWCM_18_directio.sys_util
> > >       1.80 ±  4%     -18.5%       1.47 ±  5%  fxmark.ssd_xfs_MWCM_18_directio.user_sec
> > >       0.20 ±  4%     -18.2%       0.16 ±  4%  fxmark.ssd_xfs_MWCM_18_directio.user_util
> > >    3363535           -29.6%    2369575 ±  7%  fxmark.ssd_xfs_MWCM_18_directio.works
> > >      67262           -29.6%      47384 ±  7%  fxmark.ssd_xfs_MWCM_18_directio.works/sec
> > >       0.01 ±111%  +51925.0%       3.47 ±  9%  fxmark.ssd_xfs_MWCM_1_directio.idle_sec
> > >       0.01 ±111%  +52382.0%       6.99 ±  9%  fxmark.ssd_xfs_MWCM_1_directio.idle_util
> > >       0.23 ± 14%   +1481.9%       3.64 ± 14%  fxmark.ssd_xfs_MWCM_1_directio.iowait_sec
> > >       0.46 ± 14%   +1496.0%       7.33 ± 14%  fxmark.ssd_xfs_MWCM_1_directio.iowait_util
> > >       0.58           +20.9%       0.70 ±  2%  fxmark.ssd_xfs_MWCM_1_directio.irq_sec
> > >       1.15           +21.9%       1.40 ±  2%  fxmark.ssd_xfs_MWCM_1_directio.irq_util
> > >       0.37 ±  2%     +18.9%       0.44 ±  5%  fxmark.ssd_xfs_MWCM_1_directio.softirq_sec
> > >       0.74 ±  2%     +20.0%       0.89 ±  5%  fxmark.ssd_xfs_MWCM_1_directio.softirq_util
> > >      47.70           -15.4%      40.33 ±  2%  fxmark.ssd_xfs_MWCM_1_directio.sys_sec
> > >      95.24           -14.7%      81.24 ±  2%  fxmark.ssd_xfs_MWCM_1_directio.sys_util
> > >       1.20 ±  5%     -11.0%       1.07 ±  4%  fxmark.ssd_xfs_MWCM_1_directio.user_sec
> > >       2.40 ±  6%     -10.2%       2.15 ±  4%  fxmark.ssd_xfs_MWCM_1_directio.user_util
> > >    2639345           -15.6%    2228369 ±  4%  fxmark.ssd_xfs_MWCM_1_directio.works
> > >      52786           -15.6%      44567 ±  4%  fxmark.ssd_xfs_MWCM_1_directio.works/sec
> > >       4.11 ±  3%    +254.5%      14.56 ± 18%  fxmark.ssd_xfs_MWCM_2_directio.idle_sec
> > >       4.10 ±  3%    +255.9%      14.60 ± 18%  fxmark.ssd_xfs_MWCM_2_directio.idle_util
> > >       1.42 ±  6%    +435.2%       7.57 ±  6%  fxmark.ssd_xfs_MWCM_2_directio.iowait_sec
> > >       1.41 ±  6%    +437.2%       7.59 ±  6%  fxmark.ssd_xfs_MWCM_2_directio.iowait_util
> > >       0.82           +20.2%       0.99 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.irq_sec
> > >       0.82           +20.7%       0.99 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.irq_util
> > >       0.52 ±  4%     +30.0%       0.67 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.softirq_sec
> > >       0.52 ±  4%     +30.5%       0.67 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.softirq_util
> > >      91.86           -18.6%      74.82 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.sys_sec
> > >      91.73           -18.3%      74.99 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.sys_util
> > >       1.42 ±  4%     -18.7%       1.15 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.user_sec
> > >       1.42 ±  4%     -18.4%       1.16 ±  4%  fxmark.ssd_xfs_MWCM_2_directio.user_util
> > >    3159498           -23.2%    2425056 ±  5%  fxmark.ssd_xfs_MWCM_2_directio.works
> > >      63189           -23.3%      48486 ±  5%  fxmark.ssd_xfs_MWCM_2_directio.works/sec
> > >     413.60 ±  4%    +103.5%     841.63 ± 20%  fxmark.ssd_xfs_MWCM_36_directio.idle_sec
> > >      22.94 ±  4%    +103.9%      46.78 ± 20%  fxmark.ssd_xfs_MWCM_36_directio.idle_util
> > >       1364           -31.6%     933.33 ± 19%  fxmark.ssd_xfs_MWCM_36_directio.sys_sec
> > >      75.70           -31.5%      51.85 ± 18%  fxmark.ssd_xfs_MWCM_36_directio.sys_util
> > >       1.82 ±  4%     -11.7%       1.60 ±  5%  fxmark.ssd_xfs_MWCM_36_directio.user_sec
> > >       0.10 ±  4%     -11.5%       0.09 ±  5%  fxmark.ssd_xfs_MWCM_36_directio.user_util
> > >    2850816           -22.9%    2197955 ±  7%  fxmark.ssd_xfs_MWCM_36_directio.works
> > >      57006           -22.9%      43943 ±  7%  fxmark.ssd_xfs_MWCM_36_directio.works/sec
> > >      54.22           +63.5%      88.65 ±  2%  fxmark.ssd_xfs_MWCM_4_directio.idle_sec
> > >      27.33           +64.7%      45.02 ±  2%  fxmark.ssd_xfs_MWCM_4_directio.idle_util
> > >       6.53           +36.1%       8.89 ±  8%  fxmark.ssd_xfs_MWCM_4_directio.iowait_sec
> > >       3.29           +37.1%       4.51 ±  8%  fxmark.ssd_xfs_MWCM_4_directio.iowait_util
> > >       1.37           +21.7%       1.67 ±  3%  fxmark.ssd_xfs_MWCM_4_directio.irq_sec
> > >       0.69           +22.6%       0.85 ±  3%  fxmark.ssd_xfs_MWCM_4_directio.irq_util
> > >       0.64           +20.3%       0.77 ±  3%  fxmark.ssd_xfs_MWCM_4_directio.softirq_sec
> > >       0.32           +21.2%       0.39 ±  3%  fxmark.ssd_xfs_MWCM_4_directio.softirq_util
> > >     134.06           -28.6%      95.67 ±  2%  fxmark.ssd_xfs_MWCM_4_directio.sys_sec
> > >      67.58           -28.1%      48.59 ±  2%  fxmark.ssd_xfs_MWCM_4_directio.sys_util
> > >       1.55 ±  2%     -18.4%       1.26 ±  5%  fxmark.ssd_xfs_MWCM_4_directio.user_sec
> > >       0.78 ±  2%     -17.8%       0.64 ±  5%  fxmark.ssd_xfs_MWCM_4_directio.user_util
> > >    3262962           -26.9%    2383952        fxmark.ssd_xfs_MWCM_4_directio.works
> > >      65256           -26.9%      47670        fxmark.ssd_xfs_MWCM_4_directio.works/sec
> > >     489.98 ±  3%    +160.6%       1277 ± 24%  fxmark.ssd_xfs_MWCM_54_directio.idle_sec
> > >      18.11 ±  3%    +161.0%      47.27 ± 24%  fxmark.ssd_xfs_MWCM_54_directio.idle_util
> > >       2185           -36.3%       1391 ± 22%  fxmark.ssd_xfs_MWCM_54_directio.sys_sec
> > >      80.77           -36.2%      51.49 ± 22%  fxmark.ssd_xfs_MWCM_54_directio.sys_util
> > >    2448443           -24.0%    1859708 ±  9%  fxmark.ssd_xfs_MWCM_54_directio.works
> > >      48963           -24.1%      37175 ±  9%  fxmark.ssd_xfs_MWCM_54_directio.works/sec
> > >     614.60 ±  2%     +88.5%       1158 ±  9%  fxmark.ssd_xfs_MWCM_72_directio.idle_sec
> > >      17.04 ±  2%     +88.6%      32.13 ±  9%  fxmark.ssd_xfs_MWCM_72_directio.idle_util
> > >       6.44 ±  4%     -14.8%       5.48 ±  9%  fxmark.ssd_xfs_MWCM_72_directio.iowait_sec
> > >       0.18 ±  4%     -14.8%       0.15 ± 10%  fxmark.ssd_xfs_MWCM_72_directio.iowait_util
> > >       2953           -18.5%       2407 ±  4%  fxmark.ssd_xfs_MWCM_72_directio.sys_sec
> > >      81.89           -18.5%      66.77 ±  4%  fxmark.ssd_xfs_MWCM_72_directio.sys_util
> > >    2279692           -15.1%    1935171 ±  2%  fxmark.ssd_xfs_MWCM_72_directio.works
> > >      45589           -15.1%      38687 ±  2%  fxmark.ssd_xfs_MWCM_72_directio.works/sec
> > >     934.32           -10.3%     838.20        fxmark.time.elapsed_time
> > >     934.32           -10.3%     838.20        fxmark.time.elapsed_time.max
> > >   43490089           -20.8%   34446960 ±  3%  fxmark.time.file_system_outputs
> > >     128601 ±  3%     -31.6%      87922 ±  4%  fxmark.time.involuntary_context_switches
> > >      31.83           -17.8%      26.17 ±  5%  fxmark.time.percent_of_cpu_this_job_got
> > >     301.24           -26.5%     221.43 ±  5%  fxmark.time.system_time
> > >     841264 ±  3%     -11.2%     747133 ±  5%  fxmark.time.voluntary_context_switches
> > >     989.01            -9.6%     893.57        uptime.boot
> > >      54.77           +10.7%      60.61        iostat.cpu.idle
> > >       5.31 ±  4%     +21.4%       6.45 ±  4%  iostat.cpu.iowait
> > >      38.42           -18.0%      31.51 ±  2%  iostat.cpu.system
> > >      55.66            +5.8       61.45        mpstat.cpu.all.idle%
> > >       5.31 ±  5%      +1.2        6.46 ±  4%  mpstat.cpu.all.iowait%
> > >       0.60 ±  2%      -0.1        0.53        mpstat.cpu.all.soft%
> > >      36.50            -6.6       29.87 ±  3%  mpstat.cpu.all.sys%
> > >   26496967           -20.9%   20947493 ±  2%  numa-numastat.node0.local_node
> > >   26548700           -20.8%   21022864 ±  2%  numa-numastat.node0.numa_hit
> > >    3332141 ±  6%     -22.1%    2595871 ±  4%  numa-numastat.node1.local_node
> > >    3400117 ±  5%     -22.4%    2638708 ±  5%  numa-numastat.node1.numa_hit
> > >       2211            +1.0%       2233        perf-stat.i.minor-faults
> > >       0.39 ±  9%      +0.1        0.44 ±  3%  perf-stat.i.node-load-miss-rate%
> > >       2211            +1.0%       2233        perf-stat.i.page-faults
> > >       2209            +1.0%       2230        perf-stat.ps.minor-faults
> > >       2209            +1.0%       2230        perf-stat.ps.page-faults
> > >      53.83           +11.5%      60.00        vmstat.cpu.id
> > >       5430 ±  2%     -14.0%       4668 ±  3%  vmstat.io.bi
> > >     123556            -8.3%     113294 ±  2%  vmstat.io.bo
> > >   11181852           -16.7%    9318758 ±  2%  vmstat.memory.cache
> > >       7.67 ±  6%     -19.6%       6.17 ± 11%  vmstat.procs.r
> > >    9247281           -15.1%    7847381        meminfo.Cached
> > >    3299044 ±  2%     -21.5%    2591082 ±  2%  meminfo.Dirty
> > >    5715841 ±  2%     -24.4%    4320653 ±  3%  meminfo.Inactive
> > >    5389224 ±  2%     -25.9%    3991807 ±  3%  meminfo.Inactive(file)
> > >    1914390           -24.3%    1449759 ±  3%  meminfo.KReclaimable
> > >      31406 ± 13%     -22.0%      24510 ±  7%  meminfo.KernelStack
> > >   14111361           -16.6%   11775228 ±  2%  meminfo.Memused
> > >    1914390           -24.3%    1449759 ±  3%  meminfo.SReclaimable
> > >    1427015           -25.6%    1061962 ±  4%  meminfo.SUnreclaim
> > >      18397 ±  2%      -8.4%      16846        meminfo.Shmem
> > >    3341406           -24.8%    2511722 ±  3%  meminfo.Slab
> > >   24035030           -18.6%   19557858 ±  2%  meminfo.max_used_kB
> > >       1.23 ± 22%      +0.4        1.58 ± 18%  perf-profile.calltrace.cycles-pp.xlog_cil_push_work.process_one_work.worker_thread.kthread.ret_from_fork
> > >       0.76 ± 44%      -0.4        0.38 ± 74%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
> > >       0.09 ± 10%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.mod_find
> > >       0.10 ± 47%      +0.1        0.18 ± 26%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
> > >       0.17 ± 26%      +0.1        0.25 ± 16%  perf-profile.children.cycles-pp.s_show
> > >       0.05 ± 82%      +0.1        0.13 ± 46%  perf-profile.children.cycles-pp.timekeeping_advance
> > >       0.05 ± 82%      +0.1        0.13 ± 46%  perf-profile.children.cycles-pp.update_wall_time
> > >       0.21 ± 21%      +0.1        0.31 ± 20%  perf-profile.children.cycles-pp.vsnprintf
> > >       0.20 ± 26%      +0.1        0.30 ± 17%  perf-profile.children.cycles-pp.seq_printf
> > >       1.23 ± 22%      +0.4        1.58 ± 18%  perf-profile.children.cycles-pp.xlog_cil_push_work
> > >       0.08 ± 14%      -0.0        0.04 ± 72%  perf-profile.self.cycles-pp.mod_find
> > >       0.14 ± 26%      +0.1        0.22 ± 16%  perf-profile.self.cycles-pp.xlog_cil_push_work
> > >       0.13 ± 37%      +0.1        0.21 ± 22%  perf-profile.self.cycles-pp.__folio_end_writeback
> > >       1339 ±  6%     -12.1%       1177 ±  6%  numa-meminfo.node0.Active
> > >       1317 ±  4%     -10.6%       1177 ±  6%  numa-meminfo.node0.Active(anon)
> > >    2938921 ±  2%     -22.3%    2284083 ±  2%  numa-meminfo.node0.Dirty
> > >    4950896 ±  2%     -25.3%    3699254 ±  2%  numa-meminfo.node0.Inactive
> > >    4806022 ±  2%     -27.0%    3510366 ±  3%  numa-meminfo.node0.Inactive(file)
> > >    1663428 ±  2%     -25.0%    1246833 ±  3%  numa-meminfo.node0.KReclaimable
> > >      15585 ±  4%     -12.4%      13655 ±  4%  numa-meminfo.node0.KernelStack
> > >    1663428 ±  2%     -25.0%    1246833 ±  3%  numa-meminfo.node0.SReclaimable
> > >    1224137 ±  2%     -25.5%     912586 ±  4%  numa-meminfo.node0.SUnreclaim
> > >      15785 ±  5%     -12.5%      13811 ±  4%  numa-meminfo.node0.Shmem
> > >    2887566           -25.2%    2159421 ±  3%  numa-meminfo.node0.Slab
> > >     358435 ±  3%     -14.3%     307335 ±  6%  numa-meminfo.node1.Dirty
> > >     764404 ±  6%     -18.6%     622071 ± 10%  numa-meminfo.node1.Inactive
> > >     582651 ±  2%     -17.3%     482089 ±  9%  numa-meminfo.node1.Inactive(file)
> > >     250653 ± 10%     -18.9%     203397 ± 13%  numa-meminfo.node1.KReclaimable
> > >    3410163 ± 54%     -26.4%    2508459 ± 68%  numa-meminfo.node1.MemUsed
> > >     250653 ± 10%     -18.9%     203397 ± 13%  numa-meminfo.node1.SReclaimable
> > >     202812 ± 17%     -26.2%     149763 ±  5%  numa-meminfo.node1.SUnreclaim
> > >     453467 ±  9%     -22.1%     353161 ±  8%  numa-meminfo.node1.Slab
> > >       0.71 ± 14%     -21.5%       0.56 ± 14%  sched_debug.cfs_rq:/.h_nr_running.avg
> > >       1405 ± 55%     -68.3%     445.08 ± 27%  sched_debug.cfs_rq:/.load_avg.avg
> > >    5023746           -33.8%    3324248 ± 13%  sched_debug.cfs_rq:/.min_vruntime.avg
> > >    5080937           -33.2%    3395209 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
> > >    4683128           -31.3%    3217873 ± 13%  sched_debug.cfs_rq:/.min_vruntime.min
> > >       0.59 ±  9%     -17.4%       0.49 ± 18%  sched_debug.cfs_rq:/.nr_running.avg
> > >     650.51 ± 13%     -32.3%     440.38 ±  9%  sched_debug.cfs_rq:/.runnable_avg.avg
> > >       1007 ±  8%     -18.5%     821.27 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
> > >     476.07 ± 17%     -38.7%     291.80 ± 16%  sched_debug.cfs_rq:/.runnable_avg.min
> > >     517.96 ±  5%     -20.3%     412.57 ±  9%  sched_debug.cfs_rq:/.util_avg.avg
> > >     352.69 ±  5%     -26.1%     260.66 ± 14%  sched_debug.cfs_rq:/.util_avg.min
> > >     113.13 ±  9%     -26.8%      82.85 ± 15%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
> > >      18547 ±  4%      -9.5%      16791 ±  3%  sched_debug.cpu.curr->pid.max
> > >       1549 ± 11%   +1106.2%      18692 ±123%  sched_debug.cpu.max_idle_balance_cost.stddev
> > >       0.70 ± 16%     -25.1%       0.52 ± 18%  sched_debug.cpu.nr_running.avg
> > >     862357 ±  4%     -16.3%     722142 ±  3%  sched_debug.cpu.nr_switches.avg
> > >    1440368 ±  6%     -22.2%    1120203 ±  6%  sched_debug.cpu.nr_switches.max
> > >     756963 ±  4%     -14.6%     646359 ±  5%  sched_debug.cpu.nr_switches.min
> > >     150642 ± 10%     -33.8%      99651 ± 18%  sched_debug.cpu.nr_switches.stddev
> > >   17687949           -23.3%   13563229 ±  2%  numa-vmstat.node0.nr_dirtied
> > >     734675 ±  2%     -22.3%     570784 ±  2%  numa-vmstat.node0.nr_dirty
> > >    1201580 ±  2%     -27.0%     877113 ±  3%  numa-vmstat.node0.nr_inactive_file
> > >      15586 ±  4%     -12.4%      13655 ±  4%  numa-vmstat.node0.nr_kernel_stack
> > >       3945 ±  5%     -12.5%       3453 ±  4%  numa-vmstat.node0.nr_shmem
> > >     415866 ±  2%     -25.1%     311497 ±  3%  numa-vmstat.node0.nr_slab_reclaimable
> > >     306030 ±  2%     -25.5%     228011 ±  4%  numa-vmstat.node0.nr_slab_unreclaimable
> > >   17687949           -23.3%   13563229 ±  2%  numa-vmstat.node0.nr_written
> > >    1201580 ±  2%     -27.0%     877113 ±  3%  numa-vmstat.node0.nr_zone_inactive_file
> > >     734697 ±  2%     -22.3%     570821 ±  2%  numa-vmstat.node0.nr_zone_write_pending
> > >   26548703           -20.8%   21023488 ±  2%  numa-vmstat.node0.numa_hit
> > >   26496970           -20.9%   20948116 ±  2%  numa-vmstat.node0.numa_local
> > >    2316618           -20.7%    1836559 ±  5%  numa-vmstat.node1.nr_dirtied
> > >      89623 ±  3%     -14.3%      76800 ±  6%  numa-vmstat.node1.nr_dirty
> > >     145701 ±  2%     -17.3%     120486 ±  9%  numa-vmstat.node1.nr_inactive_file
> > >      62668 ± 10%     -18.9%      50828 ± 13%  numa-vmstat.node1.nr_slab_reclaimable
> > >      50710 ± 17%     -26.2%      37434 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
> > >    2316618           -20.7%    1836559 ±  5%  numa-vmstat.node1.nr_written
> > >     145701 ±  2%     -17.3%     120486 ±  9%  numa-vmstat.node1.nr_zone_inactive_file
> > >      89584 ±  3%     -14.3%      76792 ±  6%  numa-vmstat.node1.nr_zone_write_pending
> > >    3400024 ±  5%     -22.4%    2639087 ±  5%  numa-vmstat.node1.numa_hit
> > >    3332048 ±  6%     -22.1%    2596249 ±  4%  numa-vmstat.node1.numa_local
> > >      77508            +1.2%      78432        proc-vmstat.nr_anon_pages
> > >   20004568           -23.0%   15399788 ±  2%  proc-vmstat.nr_dirtied
> > >     825597 ±  2%     -21.4%     648654 ±  2%  proc-vmstat.nr_dirty
> > >    2311462           -15.1%    1961741        proc-vmstat.nr_file_pages
> > >   29390035            +2.0%   29973527        proc-vmstat.nr_free_pages
> > >    1346949 ±  2%     -25.9%     997847 ±  3%  proc-vmstat.nr_inactive_file
> > >      31402 ± 13%     -21.9%      24514 ±  7%  proc-vmstat.nr_kernel_stack
> > >       4599 ±  2%      -8.4%       4211        proc-vmstat.nr_shmem
> > >     478540           -24.3%     362476 ±  3%  proc-vmstat.nr_slab_reclaimable
> > >     356646           -25.6%     265413 ±  4%  proc-vmstat.nr_slab_unreclaimable
> > >   20004568           -23.0%   15399788 ±  2%  proc-vmstat.nr_written
> > >    1346949 ±  2%     -25.9%     997847 ±  3%  proc-vmstat.nr_zone_inactive_file
> > >     825584 ±  2%     -21.4%     648681 ±  2%  proc-vmstat.nr_zone_write_pending
> > >   29951284           -21.0%   23664558 ±  2%  proc-vmstat.numa_hit
> > >   29831574           -21.1%   23546349 ±  2%  proc-vmstat.numa_local
> > >   51777954           -21.0%   40906350 ±  2%  proc-vmstat.pgalloc_normal
> > >       5920 ±  2%      -7.6%       5472 ±  2%  proc-vmstat.pgdeactivate
> > >    2342027            -8.5%    2142047        proc-vmstat.pgfault
> > >   51819442           -21.0%   40950599 ±  2%  proc-vmstat.pgfree
> > >    5071045 ±  3%     -22.9%    3908046 ±  4%  proc-vmstat.pgpgin
> > >  1.153e+08           -17.9%   94738236        proc-vmstat.pgpgout
> > >     141611            -6.3%     132656        proc-vmstat.pgreuse
> > >   10386182 ±  3%     -24.2%    7877205 ±  4%  proc-vmstat.pgrotated
> > >   36803772           -24.1%   27916664 ±  2%  proc-vmstat.slabs_scanned
> > > 
> > > 
> > > 
> > > 
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are provided
> > > for informational purposes only. Any difference in system hardware or software
> > > design or configuration may affect actual performance.
> > > 
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://01.org/lkp
> > > 
> > > 
