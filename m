Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C100963ADE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiK1QgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiK1QgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:36:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE520F6B;
        Mon, 28 Nov 2022 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669653359; x=1701189359;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bpv9EcCzKKYgtgd8XPPXyhjlOvzzWCv3x/6Nbovu2o0=;
  b=mWN9X+RINOieKi3WCpncPRBOniC7dM/Lq4jrGpdlzpcd/vw5cVjbuMOV
   OAQnk5zzUzXJlYaohd1H3MzNKP71Eut58Zg41L+MiYPFZ0l/41Igm2acM
   2uS4sCwSEp5PeWAYTvHvD/MftvSkPy89uyCj52xUM0KIKc6tSIkOZpgEQ
   jKRsXY1XmqPMIpHTTOrBlWLCFaTb+/FUJQe9sj/YAB8UQeK72uiAu99Xq
   Gs/35iukN91dU/mIIGdly/bGQE8ofS6h3yKG1ynDqkTvO3XlCxgDwcll7
   edy2yujxvaRTNehy4jigH+vpJuAo3/6MLtfSWJRmPOrgTa8mNY+svTT2n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341794100"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="341794100"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 08:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="674280975"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="674280975"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2022 08:35:53 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 7/8] perf: Add perf_event_attr::config3
In-Reply-To: <CAL_JsqJMxEWhqZV=yqG15zvEHrBTwRVfHA6zptu2TswxRMSR0A@mail.gmail.com>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-7-87682f78caac@kernel.org>
 <20221118164943.GA4872@willie-the-truck>
 <CAL_JsqJMxEWhqZV=yqG15zvEHrBTwRVfHA6zptu2TswxRMSR0A@mail.gmail.com>
Date:   Mon, 28 Nov 2022 18:35:52 +0200
Message-ID: <877czfujdj.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Fri, Nov 18, 2022 at 10:49 AM Will Deacon <will@kernel.org> wrote:
>>
>> On Fri, Nov 04, 2022 at 10:55:07AM -0500, Rob Herring wrote:
>> > @@ -515,6 +516,8 @@ struct perf_event_attr {
>> >        * truncated accordingly on 32 bit architectures.
>> >        */
>> >       __u64   sig_data;
>> > +
>> > +     __u64   config3; /* extension of config2 */
>>
>> I need an ack from the perf core maintainers before I can take this.
>
> Peter, Arnaldo, Ingo,
>
> Can I get an ack on this please.

It appears that PMUs that don't use config{1,2} and now config3 allow
them to be whatever without any validation, whereas in reality we should
probably -EINVAL in those cases. Should something be done about that?

Regards,
--
Alex
