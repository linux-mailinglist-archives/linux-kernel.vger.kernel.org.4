Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ADA74E240
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGJXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGJXf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:35:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA799
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689032155; x=1720568155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tFbXAaj7P8nAVQ+f9ECcnlO8BUDW6scbPt26NrFxtyo=;
  b=m6fyJLc6fn0KlB43dEajGW/hDmaX8VuFh2ebN0/t/JMAp8ur6cQWIUH+
   jTipdIaYVXz+XbKy0aJR325rSE2ZCkOS3SE4j9EGeC4AI/ojcxGdjxRhA
   SiqFWhRg44e7F/23kaAWGsvevL59mJ6rmpokVS7JY0mtuxqgyJPeYdwFw
   BsL1AywfvHhhnccxByeARcd3NDuqUxFCpDfdergTgWCSJg9hVo45n31ov
   JWLFk9sZWlN4T2JExjqk0LtJNiQS8DmADClHlhvhoxp2Uxy6tDrAUwReg
   lKb7gA23AC4Ja0i0JaNo9dwE4YL1GfzfKZR9xaw8umzNVKZPZEL+x8BwH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="395269312"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="395269312"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 16:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720867161"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="720867161"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 16:35:53 -0700
Date:   Mon, 10 Jul 2023 16:35:52 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
Cc:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH 2/2] resctrl2: Arch x86 modules for most of the
 legacy control/monitor functions
Message-ID: <ZKyV2DWp0FN9sNzS@agluck-desk3>
References: <20230620033702.33344-1-tony.luck@intel.com>
 <20230620033702.33344-3-tony.luck@intel.com>
 <CALPaoChdFLTfA5g=vawTuOLk5T6dEkG79XXqm27shh-VeqNCOw@mail.gmail.com>
 <SJ1PR11MB6083FF68838400D053C884B0FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CALPaoCic3zYLxwUET5WCMUCwN8dk-B9JJvuOeUQ2o3hsgNZdQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCic3zYLxwUET5WCMUCwN8dk-B9JJvuOeUQ2o3hsgNZdQg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 12:22:03PM +0200, Peter Newman wrote:
> Hi Tony,
> 
> On Wed, Jul 5, 2023 at 6:46 AM Luck, Tony <tony.luck@intel.com> wrote:
> > The mbm_poll() code that makes sure that counters don't wrap is
> > doing all the expensive wrmsr(QM_EVTSEL);rdmsr(QM_COUNT)
> > once per second to give you the data you want.
> 
> I was doing that in the soft RMID series I posted earlier because it
> simplified things, but then I had some realizations about how much
> error +/- 1 second on the sampling point could result in[1]. We
> usually measure the bandwidth rate with a 5-second window, so a
> reading that's up to one second old would mean a 20% error in the
> bandwidth calculation.

I just pushed the latest version of the resctrl2 patches to the
resctrl2_v65rc1 branch of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git

As well as locking, bug fixes, and general updates it includes an
experimental feature to provide summary MBM information for each
node. E.g. (both "total" and "local" rates are provided). Note
that you have to load modules rdt_mbm_local_bytes and
rdt_mbm_total_bytes so that the MBM overflow threads are
running. I should fix the code to print "n/a" instead of
"0" if they are not.

$ cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_summary
    3638     3638 /g2
    3087     3087 /g2/m2
    3267     3267 /g2/m1
    3443     3443 /g1
    3629     3629 /g1/m2
    3588     3587 /g1/m1
    3999     3993 /
    3370     3369 /m2
    3432     3432 /m1

The rates are produced once per second by the MBM overflow
code. They compute MBytes/sec as "chunks since last poll"
divided by (now - then). I'm using jiffies for the times
which may be good enough. "now - then" is one second (maybe
more if the kernel thread doing the MBM polling is delayed
from running).

I should fix the summarization code to work the same as the
regular MBM files (i.e. make the parent control directory
report the sum of all its children).

The code also attempts (but fails) to make these mbm_summary
files poll(2)-able. With the wakeup dependent on aggregate
measure bandwidth compared against a configurable threshold:

$ cat /sys/fs/resctrl/info/L3_MON/mbm_poll_threshold
10000000

There's something wrong though. Poll(2) always says there is
data to be read.  I only see one other piece of kernel code
implementing poll on kernfs (in the cgroup code). Perhaps
my problem is inability to write an appliction that uses
poll(2) correctly.

Let me know if this all seems like a useful direction. Maybe
the polling part is overkill and it is sufficient to just
have a cheap way to get all the bandwidths even if the values
seen might be up to one second old.

-Tony
