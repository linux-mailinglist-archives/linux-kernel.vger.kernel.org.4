Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC7617729
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKCHIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:08:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219592A2;
        Thu,  3 Nov 2022 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667459318; x=1698995318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LXwetU0S7aYaZDcutvKvsebukj29ZZswoUgMeL94BnU=;
  b=FJTYB8AkFFyFakF8Bb05NrIE8vr9rnka8d9fUUooimQGgfla6Ri/c4LK
   F0ZtniMMN1lYvQx3ApTpHx/s62EGDIP1us/ny/0ijpr+5u8nCdWcrBOo7
   4G553Qy14yUjSMbC7UHdcQeDws+CtrhMtxYCX0osY+y8Qmt3ab9bHtBaK
   UX5dmIxCB6km0ioLIti4i0OZPOU26EVUjEKA0RvbdTV+pwS8icc7TPJua
   xl5YSdSD1G6YSH9M4UVF3WZWmG9M0ZeOO7FOv72tgzu/sDSIoNry6YFK0
   7hZjvit6MrEmXPLSY3xtypr+9amh53wg3PYQxGfrJTKy0t+e+3txd71B/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="373834109"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="373834109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:08:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723835987"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723835987"
Received: from ojoledo-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:08:36 -0700
Message-ID: <ea7fba87-6132-5f05-6c1c-7afc8d576b89@intel.com>
Date:   Thu, 3 Nov 2022 09:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] perf tools: exclude the include/perf/ directory
To:     Donglin Peng <dolinux.peng@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
References: <20221103040321.56233-1-dolinux.peng@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221103040321.56233-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 06:03, Donglin Peng wrote:
> Commit 3af1dfdd51e0 ("perf build: Move perf_dlfilters.h in the
> source tree") moved perf_dlfilters.h to the include/perf/ directory
> without updating the .gitignore file, causing new files in the
> include/perf/ directory will be ignored.

Note:

include/perf is ignored because it has 'perf' in the name

Can check:

 Before:
 $ touch tools/perf/include/perf/junk
 $ git status | grep junk
 $ git check-ignore -v tools/perf/include/perf/junk
 tools/perf/.gitignore:6:perf    tools/perf/include/perf/junk

 After:
 $ git status | grep junk
         tools/perf/include/perf/junk
 $ git check-ignore -v tools/perf/include/perf/junk

> 
> Add !include/perf/ to perf's .gitignore file.
> 
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index a653311d9693..fd7a6ff9e7aa 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -4,6 +4,7 @@ PERF-GUI-VARS
>  PERF-VERSION-FILE
>  FEATURE-DUMP
>  perf
> +!include/perf/
>  perf-read-vdso32
>  perf-read-vdsox32
>  perf-help

