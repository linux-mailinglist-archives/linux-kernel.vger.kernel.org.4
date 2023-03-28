Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743376CC8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjC1RMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC1RL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:11:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A564694;
        Tue, 28 Mar 2023 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680023517; x=1711559517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JAwonjw06QIWC8+gEYwUhiPYiTvL66Vf/7FiKNG5dRI=;
  b=MGBP3hMFDr7Prmj2DlcQhXLKucah8SOdlQSPZGEAeLfMir2jURukgcx+
   GoTnb2izZaqEIXsED8BmPy0xxLO2JfbV/HHQwkoul0acrqqn4vk7xzOSq
   yxltMbjSshnK9Zj1s4QbuRlIrKYvSeUyDrNDSP4gjel7QDlQeQeHeWU2Z
   FOZ2bkXHnURB4ygdlSiYqCcg+u5/9njbdtM0OvJTE2x2lARBNNvVv0Pym
   GZxam42lHiGlZRVYfy49hiP9S3AwqiLn+eEURVCPrLu9O+pBZdMGnKhUh
   IFc1/NajApdoSGaaqYQlwM/uA9s8aw86wL2YUnp2t4e+S0fEnwd+qHpst
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="368397554"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="368397554"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773210987"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773210987"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:11:39 -0700
Message-ID: <cf2bd4c9-c895-2533-cce2-28e9d6b89f1f@intel.com>
Date:   Tue, 28 Mar 2023 20:11:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/6] Simplify linking against tools/perf code
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230328014058.870413-1-irogers@google.com>
 <fe36e38f-d42f-efe5-bb3c-cf802f8001a9@intel.com>
 <CAP-5=fV749yr+wMMYjm87ThnM7ESd+i4Ko=+6H+cuCNdKJM50A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fV749yr+wMMYjm87ThnM7ESd+i4Ko=+6H+cuCNdKJM50A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/23 19:14, Ian Rogers wrote:
> On Tue, Mar 28, 2023 at 6:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 28/03/23 04:40, Ian Rogers wrote:
>>> When fuzzing something like parse-events, having the main function in
>>> perf.c alongside global variables like input_name means that
>>> input_name must be redeclared with the fuzzer function's
>>> main. However, as the fuzzer is using the tools/perf code as a library
>>> this causes backward linking reference that the linker may warn
>>> about. Reorganize perf.c and perf.h to avoid potential backward
>>> references, or so that the declaration/definition locations are more
>>> consistent.
>>>
>>
>> Seems like it could be a pain to maintain.
>>
>> Did you consider just adding:
>>
>> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
>> index 82bbe0ca858b..a75dd47d68ee 100644
>> --- a/tools/perf/perf.c
>> +++ b/tools/perf/perf.c
>> @@ -456,6 +456,7 @@ static int libperf_print(enum libperf_print_level level,
>>         return veprintf(level, verbose, fmt, ap);
>>  }
>>
>> +#ifndef CUSTOM_MAIN
>>  int main(int argc, const char **argv)
>>  {
>>         int err;
>> @@ -576,3 +577,4 @@ int main(int argc, const char **argv)
>>  out:
>>         return 1;
>>  }
>> +#endif
>>
> 
> It's possible. Would need to make the static functions not warn about
> being declared and not used. I still think that just aligning
> definitions and declarations yields the most expected code and will
> lead to fewer problems in the long run.

Making perf source dependent on an unknown derivative makes
things more complicated.

If you are not going to contribute it to perf, then a
suggestion is along the lines of the following:

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 82bbe0ca858b..6a7fe1534664 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -456,7 +456,18 @@ static int libperf_print(enum libperf_print_level level,
 	return veprintf(level, verbose, fmt, ap);
 }
 
$ git diff
+#ifdef CUSTOM_MAIN
+int main(void)
+{
+	printf("This is not perf\n");
+	return 0;
+}
+
+int perf_main(int argc, const char **argv);
+int perf_main(int argc, const char **argv)
+#else
 int main(int argc, const char **argv)
+#endif
 {
 	int err;
 	const char *cmd;
$ make EXTRA_CFLAGS="-DCUSTOM_MAIN" NO_BPF_SKEL=1 -C tools/perf >/dev/null
Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
Makefile.config:587: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:805: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:1046: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1075: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
Makefile.config:1137: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
$ tools/perf/perf version
This is not perf



