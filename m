Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0860D6FE1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbjEJPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjEJPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BA19B4;
        Wed, 10 May 2023 08:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF2B6349F;
        Wed, 10 May 2023 15:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07336C433EF;
        Wed, 10 May 2023 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683733241;
        bh=suHZgHXOnhG+Y0EFAZh64AmTpplHYWDqeWTt0Ihyy88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ad9KCxfE8ESkuSqBrrG4ePhVwIU5ALLDNXUNIFoD23t9ppM3dDkA7kwy61c1cCP3Y
         8uT6T0wlcWGQ6lDHqdgsOf1DwmGh4efj+/HdG1C0pZNCY72nsE2HPiryeFQflUqg1T
         t1O45+r0sbGFWXH7sQHtQ5VbX6zLNilU2zhv+lPEPX82CWfY/1zHTk02sMdUz1pyEa
         uG/SOPDA6K1LcAcI1WL+OOK9jumodP9d9I+fVSSdUEjwgRXkzbfl3eaF6pqYjzogX1
         IanWFsuOLhkiIG0cxM8XW5fwgshQagvaOm5VySGZtBiYAFb8XVl4x7TVAZFrE3PEiQ
         K8U7kwGkn5uig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4692C403B5; Wed, 10 May 2023 12:40:38 -0300 (-03)
Date:   Wed, 10 May 2023 12:40:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf bpf skels: Make vmlinux.h use bpf.h and
 perf_event.h in source directory
Message-ID: <ZFu69puLXBetozhT@kernel.org>
References: <20230510064401.225051-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510064401.225051-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 10, 2023 at 06:44:01AM +0000, Yang Jihong escreveu:
> Currently, vmlinux.h uses the bpf.h and perf_event.h header files in the
> system path. If the header files in compilation environment are old,
> compilation may fail. For example:
> 
>   /home/yangjihong/linux/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:151:27: error: field has incomplete type 'union perf_sample_weight'
>           union perf_sample_weight weight;
> 
> Use the bpf.h and perf_event.h files in the source code directory to
> avoid compilation compatibility problems.

Applied, will test it in my build containers.

- Arnaldo
 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>  - Use Makefile to specify that header files in tools/include/uapi directory are preferentially used.
> 
>  tools/perf/Makefile.perf           | 3 ++-
>  tools/perf/util/bpf_skel/vmlinux.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a42a6a99c2bc..9b92749280b2 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1058,13 +1058,14 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_
>  ifdef BUILD_BPF_SKEL
>  BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
>  BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> +TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
>  
>  $(BPFTOOL): | $(SKEL_TMP_OUT)
>  	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
>  		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
>  
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
> -	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
> +	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>  	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
>  
>  $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux.h
> index 449b1ea91fc4..c7ed51b0c1ef 100644
> --- a/tools/perf/util/bpf_skel/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux.h
> @@ -1,6 +1,7 @@
>  #ifndef __VMLINUX_H
>  #define __VMLINUX_H
>  
> +#include <linux/stddef.h> // for define __always_inline
>  #include <linux/bpf.h>
>  #include <linux/types.h>
>  #include <linux/perf_event.h>
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
