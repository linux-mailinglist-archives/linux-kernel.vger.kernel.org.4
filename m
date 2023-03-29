Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F76CDA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjC2NRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjC2NRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427F423F;
        Wed, 29 Mar 2023 06:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FA861D0C;
        Wed, 29 Mar 2023 13:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7BAC433D2;
        Wed, 29 Mar 2023 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680095861;
        bh=eYMlXTpAv3olNUNbQddTkVLZaNagBLnt987Vfa/sIaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzAv00Qhx+TEYtb67jXxO4A81EZu6uBfCC5KfVhCORCn1vOpzlFeNWrZaHykhZbwl
         gBGsCdQNT8ZwuY8TYpiTB713rnt9GGNgc7vJ6HhRMy7DNYB8u4RG7qoOH7RtctjdsR
         tco5hicYoZ1WpZzQUz+HvfLBDJ1FfIB5ukuQWUqYidySv9eUMuLcDhz+tcuDhj53o8
         LJzTsstwlddPu+/mfkBOYVNt8yZMeTGWspj77TU7J0v7kAFxFuV3b8d7V9yVeg+saE
         2Z0i/MrQYKmf2bgKtis8Q6+yvPhTlPiM+ozRHBstGx8Ij7WutW4LCOtuXeod6pq/O3
         YWO2oMrH1//0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93BAA4052D; Wed, 29 Mar 2023 10:17:38 -0300 (-03)
Date:   Wed, 29 Mar 2023 10:17:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v1 4/6] perf annotate: Own objdump_path and
 disassembler_style strings
Message-ID: <ZCQ6cqJsKPQPbHnZ@kernel.org>
References: <20230328235543.1082207-1-irogers@google.com>
 <20230328235543.1082207-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328235543.1082207-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 28, 2023 at 04:55:41PM -0700, Ian Rogers escreveu:
> @@ -3231,8 +3235,10 @@ void annotation_options__init(struct annotation_options *opt)
>  }
>  
>  
> -void annotation_options__exit(struct annotation_options *opt __maybe_unused)
> +void annotation_options__exit(struct annotation_options *opt)
>  {
> +	free(opt->disassembler_style);
> +	free(opt->objdump_path);
>  }


Changed this:

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7338249dfdd94390..08e041a9b9cc279e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3237,8 +3237,8 @@ void annotation_options__init(struct annotation_options *opt)
 
 void annotation_options__exit(struct annotation_options *opt)
 {
-	free(opt->disassembler_style);
-	free(opt->objdump_path);
+	zfree(&opt->disassembler_style);
+	zfree(&opt->objdump_path);
 }
 
 void annotation_config__init(struct annotation_options *opt)
