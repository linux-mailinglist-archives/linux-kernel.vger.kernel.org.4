Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D672EC43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFMTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFMTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:47:30 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75269B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:47:28 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-55b3b3e2928so4161481eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686685648; x=1689277648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WhOeElaMsiD9GyeVbS/Kz/uOr4hArVsc6evONFkFnM=;
        b=aeMNEMT7mnAhLHospPJ5V6vIYNCAcophNZar1VJgpYHxyFURQMMgUNDfiKxbq31qUx
         /ntMLDU6dIgcpzP5jt5szoYlfgJOQ930p726r6qPC78stOnaYjfEWHjjMU58XMpu3dyx
         I1eRXxTLecm0sTZY+o9wNW2LEqaDO5EnnyJcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685648; x=1689277648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WhOeElaMsiD9GyeVbS/Kz/uOr4hArVsc6evONFkFnM=;
        b=EzroUAuwdgua7gxYknp5HCFdewT77sqwuaZWsjpEwAzyLvyEUMHfmHYdDjF3ZiKSGO
         k7SF/R7ap35Bc2fm6AzdARr2rQgk7QdwNP2GXOSADGG8FdHN3M2xyJy/swJYO4WxK5lu
         Mq42WECDsg6NuXkrThA1dWEoGF9XBFsoyvkFjOocU1TzaH0PxJ7jZHTKpaciYmjXQLgw
         Sans9eJ7XCoESXGBJEpcwySS6CLF9TK9v1Bb8zq6YltU48wPNwZbpzjQw15675p1eh71
         ZFbmC7DEiFHWVX3GsMmQ8cNDX+Ca7TnclAcPlmwImg8UVhHCSEuwKX6Ped4cunBXYTCB
         5Bsg==
X-Gm-Message-State: AC+VfDzzB/SbozHlqi5Tbw4AwjRGubD5QLsexfvvaBHzn12ilCgiMZnH
        YRyJ/fzEY9AoAWCdRBhIZrySBA==
X-Google-Smtp-Source: ACHHUZ4U6UYeRfCrOKo1DH+SSAGfrV+G9PiakEqQJES8KDmPF0FcGGIFWyujt3k8m3pdnsxYnXqlng==
X-Received: by 2002:aca:d0c:0:b0:398:c4ec:63bc with SMTP id 12-20020aca0d0c000000b00398c4ec63bcmr7585125oin.43.1686685647840;
        Tue, 13 Jun 2023 12:47:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k67-20020a632446000000b005439aaf0301sm9683107pgk.64.2023.06.13.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:47:27 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:47:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v3 45/57] perf: Simplify perf_event_parse_addr_filter()
Message-ID: <202306131247.3E617931@keescook>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.779825032@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093540.779825032@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:58AM +0200, Peter Zijlstra wrote:
> XXX this code needs a cleanup

:)

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   56 ++++++++++++++++++++-------------------------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10495,6 +10495,8 @@ static void free_filters_list(struct lis
>  	}
>  }
>  
> +DEFINE_FREE(filter_list, struct list_head *, if (_T) free_filters_list(_T))
> +
>  /*
>   * Free existing address filters and optionally install new ones
>   */
> @@ -10658,13 +10660,15 @@ perf_event_parse_addr_filter(struct perf
>  			     struct list_head *filters)
>  {
>  	struct perf_addr_filter *filter = NULL;
> -	char *start, *orig, *filename = NULL;
>  	substring_t args[MAX_OPT_ARGS];
>  	int state = IF_STATE_ACTION, token;
>  	unsigned int kernel = 0;
> -	int ret = -EINVAL;
> +	char *start;
> +	int ret;
>  
> -	orig = fstr = kstrdup(fstr, GFP_KERNEL);
> +	struct list_head *fguard __free(filter_list) = filters;
> +	char *filename __free(kfree) = NULL;
> +	char *orig __free(kfree) = fstr = kstrdup(fstr, GFP_KERNEL);

Ah! I see a kfree users. Sorry for the noise. :)

-- 
Kees Cook
