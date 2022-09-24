Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE225E8880
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiIXFVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiIXFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:21:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F0139F6E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:21:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so581351pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PPRXlLTYZ3zKwK3ad/AozhJnwUlEmFf37ZAwcK6Vux0=;
        b=bRJXy8HIQ7D6BUQDEqhfdStJXXZPFcATdYsA3rCgRlPoLjgYgY5pIsXL1oREfpTrlq
         r+HKkeru+wwduG9JSy6j462a31Q+ODUAvGRE0Nzs/yT/tmihFFPGrSRBuAng65iiMuzv
         Ys9IftdSKHBvGu0i0NGbCSw0nd2mCLt5qQj5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PPRXlLTYZ3zKwK3ad/AozhJnwUlEmFf37ZAwcK6Vux0=;
        b=zzMh4b8eqmjp4NfGe0iZQ1YtXA9ZEmhLWatukWb9yqSr2sLC3ZZJYjR3oD8GM3lSS8
         ShrvRuD7a8RWzx4NguWx7hsaf8/AP337PEPUWE4bEXgf1f2yueFKr0dsHro++0CUwOWk
         vqW6vVTlt3LI6aXZoORdkosAJPzK5qO2Pb45DyUxW4onzUfbu4ChGLwLcOI2IBhZ1A0D
         uxKWo/nJPiFLSX7naDIoxwDh8sbaOFQc1PcIviJKjmWsXREElC2U34Sa+DRx8mSU0Kck
         wQAByuOn8/hs7pYPzFGMX+p5wcEgneI7HtuYlw07Yh3g6Y/f8F8r+pRhLDQ/OeBbcPMp
         UTcw==
X-Gm-Message-State: ACrzQf3CxIIPtnEtcDoVZIlLUCrl2YPkY6BmC7d1kT8c92dR3Mkt51uW
        rQCUtO6cbuyMY/XqHOMHqROigw==
X-Google-Smtp-Source: AMsMyM4XsIuTS/5fCoS42BuVeEKj1MdwRkTAi8gz+gbjVvEbLwrI//toZFaRVR1w62R1BSjWFLQd9w==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr12611930pfh.70.1663996895927;
        Fri, 23 Sep 2022 22:21:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902e89000b00176d8e33601sm6937804plg.203.2022.09.23.22.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:21:35 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:21:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: pm8001: Replace one-element array with
 flexible-array member
Message-ID: <202209232203.2F77ADD1CA@keescook>
References: <Yyy31OuBza1FJCXP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyy31OuBza1FJCXP@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:30:28PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct fw_control_info.

I think this changelog should include some explanation of why this change
is safe. As far as I can see, it would be:

This is the only change needed; struct fw_control_info is only ever used
for casting to existing allocations. No sizeof() is used on any of the
resulting variables.

> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/207
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Another one down! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
