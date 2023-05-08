Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BC6F9EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEHFRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjEHFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:17:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260D86B4
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:17:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30626f4d74aso2486482f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683523038; x=1686115038;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KYglp3kw7swqe4P9gBCkBVoMI7DDROvV1rnisE0mxc=;
        b=zbK76cthw6CpCDBJzpd77slGZkZq3JjiRcPjRULAAL8HgCYthR8xC2M33ADWM1HN5H
         bErWByPxkfRelooRQKPzfWcyKDPwfPJKTmDjapz9+h91VraBDGhWv/YBnw+ETp5gyhhE
         0XWP0VE+gOXav1vDlHELm4Q1jg3xALGjhzZvKhsWAkGIec24aOuTg3DMCw9kBoFjen8p
         TSdMMMtDsRr4w+4ivjNeqd9dLHSy7YdgzWzBsL3w/S+AQonkflh9WUE3S7Oy7EIojggH
         rfdrTZDlKfnqsmnHVcLhJUisni+8t5Ab3tdD6ZLVzhX+bFLx3cKYlTyoH4ggrpO2Tmj5
         xtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683523038; x=1686115038;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KYglp3kw7swqe4P9gBCkBVoMI7DDROvV1rnisE0mxc=;
        b=cB147MuodzPWAxMncsjbmSkVv6uizLsZnX7wrHjuiAGCw0aOxxiyAORNsda+ckEyHa
         u9P2RI05rFv0/Uqm2v4pUf2Ne+k7qkZaqZRDMynDT1D6XFQ2Ed1YEOyLsFxUlJA5eH0C
         R8VRzxy6WMzXtL/lZnFLcRRsl9QRq9bBw4q0wWrHYYgixmoD3FawDT5taPxRIXVt4KdV
         Gu8zW6yKCJLLn5KNQ5vrQ4bMR9QHtBrRnjRxy9S/N1OJO7Gv+JaKwqPCn8t7DcxVtvkA
         PnRgBJxRCa9kuCQKZ6eCMk7d7A1dxaFKRDe4r3Fnie35MufS5NneRxKZJPptryvF6fB0
         kiVQ==
X-Gm-Message-State: AC+VfDzW1g0ZiTSxvMX+ILCxhpLWq+y5WbNWH8it7aFYoYFYsnyz2bia
        dl31Nv/WHFO8Ld5RJ6a2V3bX3GWe/C5iNfp8qIs=
X-Google-Smtp-Source: ACHHUZ5imPXkgCHamZWK6HDTNjnpkkYezN5qeMQCNrna9YvUZ7mATrotlYjZfOei6vh6ZMcqPcPpmg==
X-Received: by 2002:adf:db0c:0:b0:307:9d2a:fd35 with SMTP id s12-20020adfdb0c000000b003079d2afd35mr86070wri.53.1683523038026;
        Sun, 07 May 2023 22:17:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b00306415ac69asm10047173wrw.15.2023.05.07.22.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 22:17:15 -0700 (PDT)
Date:   Mon, 8 May 2023 08:17:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/fprobe.c:59 fprobe_handler() error: uninitialized
 symbol 'ret'.
Message-ID: <d3467332-3d5f-488a-b156-064cbd3d7873@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2e1e1337881b0e9844d687982aa54b31b1269b11
commit: 39d954200bf6ad503c722e44d0be80c7b826fa42 fprobe: Skip exit_handler if entry_handler returns !0
config: i386-randconfig-m041-20230501 (https://download.01.org/0day-ci/archive/20230506/202305061702.6h3JzCPA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305061702.6h3JzCPA-lkp@intel.com/

smatch warnings:
kernel/trace/fprobe.c:59 fprobe_handler() error: uninitialized symbol 'ret'.

vim +/ret +59 kernel/trace/fprobe.c

cad9931f64dc7f Masami Hiramatsu          2022-03-15  23  static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
cad9931f64dc7f Masami Hiramatsu          2022-03-15  24  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
cad9931f64dc7f Masami Hiramatsu          2022-03-15  25  {
5b0ab78998e325 Masami Hiramatsu          2022-03-15  26  	struct fprobe_rethook_node *fpr;
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  27) 	struct rethook_node *rh = NULL;
cad9931f64dc7f Masami Hiramatsu          2022-03-15  28  	struct fprobe *fp;
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  29) 	void *entry_data = NULL;
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  30) 	int bit, ret;
cad9931f64dc7f Masami Hiramatsu          2022-03-15  31  
cad9931f64dc7f Masami Hiramatsu          2022-03-15  32  	fp = container_of(ops, struct fprobe, ops);
cad9931f64dc7f Masami Hiramatsu          2022-03-15  33  	if (fprobe_disabled(fp))
cad9931f64dc7f Masami Hiramatsu          2022-03-15  34  		return;
cad9931f64dc7f Masami Hiramatsu          2022-03-15  35  
cad9931f64dc7f Masami Hiramatsu          2022-03-15  36  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
cad9931f64dc7f Masami Hiramatsu          2022-03-15  37  	if (bit < 0) {
cad9931f64dc7f Masami Hiramatsu          2022-03-15  38  		fp->nmissed++;
cad9931f64dc7f Masami Hiramatsu          2022-03-15  39  		return;
cad9931f64dc7f Masami Hiramatsu          2022-03-15  40  	}
cad9931f64dc7f Masami Hiramatsu          2022-03-15  41  
5b0ab78998e325 Masami Hiramatsu          2022-03-15  42  	if (fp->exit_handler) {
5b0ab78998e325 Masami Hiramatsu          2022-03-15  43  		rh = rethook_try_get(fp->rethook);
5b0ab78998e325 Masami Hiramatsu          2022-03-15  44  		if (!rh) {
5b0ab78998e325 Masami Hiramatsu          2022-03-15  45  			fp->nmissed++;
5b0ab78998e325 Masami Hiramatsu          2022-03-15  46  			goto out;
5b0ab78998e325 Masami Hiramatsu          2022-03-15  47  		}
5b0ab78998e325 Masami Hiramatsu          2022-03-15  48  		fpr = container_of(rh, struct fprobe_rethook_node, node);
5b0ab78998e325 Masami Hiramatsu          2022-03-15  49  		fpr->entry_ip = ip;
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  50) 		if (fp->entry_data_size)
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  51) 			entry_data = fpr->data;
5b0ab78998e325 Masami Hiramatsu          2022-03-15  52  	}
5b0ab78998e325 Masami Hiramatsu          2022-03-15  53  
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  54) 	if (fp->entry_handler)
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  55) 		ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  56) 
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  57) 	/* If entry_handler returns !0, nmissed is not counted. */
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  58) 	if (rh) {
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02 @59) 		if (ret)

I reported this one earlier.  The code assumes that if there is an
-exit_handler there is also an ->entry_handler().  You had said you
would just initialized ret = 0;

39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  60) 			rethook_recycle(rh);
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  61) 		else
76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  62) 			rethook_hook(rh, ftrace_get_regs(fregs), true);
39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  63) 	}
5b0ab78998e325 Masami Hiramatsu          2022-03-15  64  out:
cad9931f64dc7f Masami Hiramatsu          2022-03-15  65  	ftrace_test_recursion_unlock(bit);
cad9931f64dc7f Masami Hiramatsu          2022-03-15  66  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

