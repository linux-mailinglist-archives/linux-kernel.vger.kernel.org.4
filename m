Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1A707AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjERHXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjERHXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:23:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08B252113;
        Thu, 18 May 2023 00:23:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17BF81FB;
        Thu, 18 May 2023 00:23:55 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF24A3F73F;
        Thu, 18 May 2023 00:23:08 -0700 (PDT)
Message-ID: <8d6b615e-0999-59d2-e123-5a2570f12cf5@arm.com>
Date:   Thu, 18 May 2023 08:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/2] perf test attr: Fix deprecation warning
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
References: <20230517225707.2682235-1-irogers@google.com>
 <20230517225707.2682235-2-irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230517225707.2682235-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2023 23:57, Ian Rogers wrote:
> Address the warning:
> ```
> tests/attr.py:155: DeprecationWarning: The SafeConfigParser class has
>   been renamed to ConfigParser in Python 3.2. This alias will be
>   removed in Python 3.12. Use ConfigParser directly instead.
> parser = configparser.SafeConfigParser()
> ```
> by removing the word 'Safe'.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/attr.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
> index ccfef861e931..e890c261ad26 100644
> --- a/tools/perf/tests/attr.py
> +++ b/tools/perf/tests/attr.py
> @@ -152,7 +152,7 @@ def parse_version(version):
>  #   - expected values assignments
>  class Test(object):
>      def __init__(self, path, options):
> -        parser = configparser.SafeConfigParser()
> +        parser = configparser.ConfigParser()
>          parser.read(path)
>  
>          log.warning("running '%s'" % path)
> @@ -247,7 +247,7 @@ class Test(object):
>          return True
>  
>      def load_events(self, path, events):
> -        parser_event = configparser.SafeConfigParser()
> +        parser_event = configparser.ConfigParser()
>          parser_event.read(path)
>  
>          # The event record section header contains 'event' word,
> @@ -261,7 +261,7 @@ class Test(object):
>              # Read parent event if there's any
>              if (':' in section):
>                  base = section[section.index(':') + 1:]
> -                parser_base = configparser.SafeConfigParser()
> +                parser_base = configparser.ConfigParser()
>                  parser_base.read(self.test_dir + '/' + base)
>                  base_items = parser_base.items('event')
>  

Reviewed-by: James Clark <james.clark@arm.com>

I thought I also did this a while ago but it must have gotten lost or I
didn't send it.
