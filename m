Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB46706FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEQRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEQRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:47:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688FDA27F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:47:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3078fa679a7so1069022f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684345629; x=1686937629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzzapYtH6nLuFSlwiVq46jwlISu/Zw3SqEI/c5f2wJk=;
        b=GtxMCvxiNLrDVHbtmRDW0HBBqzx0MXTTg68mJ332rUIjsPxiyYoXc6H2Dt+/deV2m0
         XJdaviIyHgV4CuCH5RbIY/ehyNCLZ6doYR0gOQD5kNFm+2M2PH0ZMrrnQFUrxPSs0gBy
         U06RB2NEh5dB68vkg1Kx19vWLoTlXgBkcXZSPfhmVIW4Fa6TMmN480pmlj5G9vlJ9GbB
         qjh1UoHIu9+WDcPkIPHmSOjTKpvaq5+Bmsk5NsAepcwHWRGH4vXXIOBzyyfd1XknxToO
         R4HBseCtKI7finOsbhVdeGcIkxpywtCZoypWWk/a76ytYO1cXJaPNH/X9hdaIAocb0I2
         Xl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345629; x=1686937629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzzapYtH6nLuFSlwiVq46jwlISu/Zw3SqEI/c5f2wJk=;
        b=jzUP9KUL+h+d39WzvwsnT2UyaD6OVl/bXXPaUWHYKmsoaohrnYLeb6hNkItT/1JSzu
         3pFUwJMGvl7ufJkz4Qb6rKpRcT0xxkCQoA0SKAws72rVJgsKIGGOALnMGhYKJmS5KrZ0
         Zi+WpyqPuuEZsGNR9Kz6FLfIVAV9Z8bs54XSKh/yzOoG8sdnQSAQdG9fzUdKjARYm/rr
         IaF1jjAwfrwFkbfr9/ceSLeSit9vXlvWasv9574EX+GKzyG1CzLxim7/JZwyXgbCqh2U
         XVzhervv5XqkZk7dzIZ1REIzwXERRcwZ+bqmiXB+YyjXp8q/lugI79jZs/XpVmFXoeT5
         3Mpw==
X-Gm-Message-State: AC+VfDxckmrmE+SA60K2IkPnexakDbmq+XqBHNzmt4z9KhhjollHSVlv
        jmiVYBMQ04WXS8v7368mcUU/tw==
X-Google-Smtp-Source: ACHHUZ4nQSxJpVx4M61WWdLp+Ym0zQb6hNW4foaQXMIogHR4N2y0oDVNbJxilbrN7yH2IIlQIEtzRw==
X-Received: by 2002:a5d:4577:0:b0:307:a4ee:4a25 with SMTP id a23-20020a5d4577000000b00307a4ee4a25mr1325344wrc.28.1684345629404;
        Wed, 17 May 2023 10:47:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x7-20020a1c7c07000000b003f182a10106sm2949960wmc.8.2023.05.17.10.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:47:07 -0700 (PDT)
Date:   Wed, 17 May 2023 20:47:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: kernel/trace/fprobe.c:59 fprobe_handler() error: uninitialized
 symbol 'ret'.
Message-ID: <3cf28006-42f0-434f-8962-7403190a33e9@kili.mountain>
References: <d3467332-3d5f-488a-b156-064cbd3d7873@kili.mountain>
 <20230517204505.f6411ff8ed3f782ae23e1af9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517204505.f6411ff8ed3f782ae23e1af9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 08:45:05PM +0900, Masami Hiramatsu wrote:
> Hi Dan,
> 
> Sorry, I missed my fix :(
> 
> https://lore.kernel.org/all/168100731160.79534.374827110083836722.stgit@devnote2/
> 
> That will fix the problem, could you test it?
> 

It's awkward for me to test it right now...  :(  The fix looks good
to me though and will obviously silence the static checker warning.

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


> Thanks,
> 
> On Mon, 8 May 2023 08:17:09 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2e1e1337881b0e9844d687982aa54b31b1269b11
> > commit: 39d954200bf6ad503c722e44d0be80c7b826fa42 fprobe: Skip exit_handler if entry_handler returns !0
> > config: i386-randconfig-m041-20230501 (https://download.01.org/0day-ci/archive/20230506/202305061702.6h3JzCPA-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Link: https://lore.kernel.org/r/202305061702.6h3JzCPA-lkp@intel.com/
> > 
> > smatch warnings:
> > kernel/trace/fprobe.c:59 fprobe_handler() error: uninitialized symbol 'ret'.
> > 
> > vim +/ret +59 kernel/trace/fprobe.c
> > 
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  23  static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  24  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  25  {
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  26  	struct fprobe_rethook_node *fpr;
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  27) 	struct rethook_node *rh = NULL;
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  28  	struct fprobe *fp;
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  29) 	void *entry_data = NULL;
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  30) 	int bit, ret;
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  31  
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  32  	fp = container_of(ops, struct fprobe, ops);
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  33  	if (fprobe_disabled(fp))
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  34  		return;
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  35  
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  36  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  37  	if (bit < 0) {
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  38  		fp->nmissed++;
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  39  		return;
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  40  	}
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  41  
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  42  	if (fp->exit_handler) {
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  43  		rh = rethook_try_get(fp->rethook);
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  44  		if (!rh) {
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  45  			fp->nmissed++;
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  46  			goto out;
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  47  		}
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  48  		fpr = container_of(rh, struct fprobe_rethook_node, node);
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  49  		fpr->entry_ip = ip;
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  50) 		if (fp->entry_data_size)
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  51) 			entry_data = fpr->data;
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  52  	}
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  53  
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  54) 	if (fp->entry_handler)
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  55) 		ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  56) 
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  57) 	/* If entry_handler returns !0, nmissed is not counted. */
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  58) 	if (rh) {
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02 @59) 		if (ret)
> > 
> > I reported this one earlier.  The code assumes that if there is an
> > -exit_handler there is also an ->entry_handler().  You had said you
> > would just initialized ret = 0;
> > 
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  60) 			rethook_recycle(rh);
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  61) 		else
> > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  62) 			rethook_hook(rh, ftrace_get_regs(fregs), true);
> > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  63) 	}
> > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  64  out:
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  65  	ftrace_test_recursion_unlock(bit);
> > cad9931f64dc7f Masami Hiramatsu          2022-03-15  66  }
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
