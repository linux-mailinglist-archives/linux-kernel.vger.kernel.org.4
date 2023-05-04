Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20746F68CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEDKFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEDKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:05:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879E2D66
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:05:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so2859935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683194734; x=1685786734;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xbNUCXTFmuO4bgPcVjNLJriAa4LuyNfoTYVdWGdUqA=;
        b=yx7/y/zls2IzaFe+nQ4JoEJY1J7hqhRHtG/rvPmTfGesBZ2wAMoaiTZpvEIjsvlSja
         xfweaimOArKstUG/1Jeaw2Uwdv4jnxRVANO0d6oEXNKGLI4P5OipAPodHTEZoykVSpl8
         Ts4+QTtQ7PtnnVwR2FngEhrbhOFSK3Cc/qsrOvlOAHXt3T5mGbmq1zMWGo521ha7jVO1
         O0pA56SwxrmhP1AQlLSXP2lNM+TFGPfpJzG2Xs2sI2n+tDTZIVgtdl+4wAcf450bjV21
         DChXkzGZLAW20byIxdOudvVR1PqSiOmPhnOZmR/7Ljzt5idGPSZfu6w2mB03TP/45PLn
         AC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683194734; x=1685786734;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xbNUCXTFmuO4bgPcVjNLJriAa4LuyNfoTYVdWGdUqA=;
        b=Wm9YabI3QdVVosl7lQBe3ArSegjzWNuQ0ivVdA8dmASj6+C9ukfxzQw9Fg/HTj0/W5
         dLOP7yip/Sf5zEzyFpU/rl8M0l/VzUFhpeAfQAGoUA7kuitbUQDhtB0bTwArYGZ1F44j
         leZF14xVCMnyWP9xH/BrLNAcTpZYFcNR4jlkSIxRqJyCyo1pV7OV7KXEOvXYG7fDI5Dj
         JAPxz7oDZ/eR7eu2ORBKw4vYFyNyjr4A2CIYLwG5kNloMRR/dsvwPqqq6rzGz5H5qNAs
         y7fsfRwT2Hz1IvfXY9MKqI+g7tOF1DaVqjU/rBZpgKjKILA8KYyUKeEk5NLWvToEfygF
         af2g==
X-Gm-Message-State: AC+VfDyk7vRW4CnuoTlmV6A0BzSZhoVXDdOZuq+hqMFopVkONUXSD/qd
        cQ4M2KeGT/Ssa25UW/U9Xcg4bw==
X-Google-Smtp-Source: ACHHUZ4I3XWBZ6xDc0rMZ5N5hF2d6jo5B1vgShIXREqb3XAjoPlDvR0ZpPT7OIFpIOtyGJTX78OChA==
X-Received: by 2002:a7b:cbcb:0:b0:3ee:19b4:a2e6 with SMTP id n11-20020a7bcbcb000000b003ee19b4a2e6mr17364983wmi.19.1683194734566;
        Thu, 04 May 2023 03:05:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003f24f245f57sm4339221wmc.42.2023.05.04.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:05:32 -0700 (PDT)
Date:   Thu, 4 May 2023 13:05:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: drivers/bus/sunxi-rsb.c:286 _sunxi_rsb_run_xfer() warn: assigning
 (-110) to unsigned variable 'timeout'
Message-ID: <b661ceb5-f6d1-470b-aa32-9005a87802bb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1a5304fecee523060f26e2778d9d8e33c0562df3
commit: 077686da0e2162c4ea5ae0df205849c2a7a84479 bus: sunxi-rsb: Support atomic transfers
config: arm64-randconfig-m041-20230428 (https://download.01.org/0day-ci/archive/20230504/202305041714.yy6fC4eJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305041714.yy6fC4eJ-lkp@intel.com/

smatch warnings:
drivers/bus/sunxi-rsb.c:286 _sunxi_rsb_run_xfer() warn: assigning (-110) to unsigned variable 'timeout'

vim +/timeout +286 drivers/bus/sunxi-rsb.c

d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  268  static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  269  {
077686da0e2162 Samuel Holland 2022-11-13  270  	u32 int_mask, status;
077686da0e2162 Samuel Holland 2022-11-13  271  	bool timeout;
077686da0e2162 Samuel Holland 2022-11-13  272  
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  273  	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  274  		dev_dbg(rsb->dev, "RSB transfer still in progress\n");
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  275  		return -EBUSY;
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  276  	}
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  277  
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  278  	reinit_completion(&rsb->complete);
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  279  
077686da0e2162 Samuel Holland 2022-11-13  280  	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER;
077686da0e2162 Samuel Holland 2022-11-13  281  	writel(int_mask, rsb->regs + RSB_INTE);
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  282  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  283  	       rsb->regs + RSB_CTRL);
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  284  
077686da0e2162 Samuel Holland 2022-11-13  285  	if (irqs_disabled()) {
077686da0e2162 Samuel Holland 2022-11-13 @286  		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
077686da0e2162 Samuel Holland 2022-11-13  287  						    status, (status & int_mask),
077686da0e2162 Samuel Holland 2022-11-13  288  						    10, 100000);

This works, but Smatch doesn't like it when people save negatives to
a bool.

077686da0e2162 Samuel Holland 2022-11-13  289  		writel(status, rsb->regs + RSB_INTS);
077686da0e2162 Samuel Holland 2022-11-13  290  	} else {
077686da0e2162 Samuel Holland 2022-11-13  291  		timeout = !wait_for_completion_io_timeout(&rsb->complete,
077686da0e2162 Samuel Holland 2022-11-13  292  							  msecs_to_jiffies(100));
077686da0e2162 Samuel Holland 2022-11-13  293  		status = rsb->status;
077686da0e2162 Samuel Holland 2022-11-13  294  	}
077686da0e2162 Samuel Holland 2022-11-13  295  
077686da0e2162 Samuel Holland 2022-11-13  296  	if (timeout) {
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  297  		dev_dbg(rsb->dev, "RSB timeout\n");
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  298  
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  299  		/* abort the transfer */
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  300  		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  301  
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  302  		/* clear any interrupt flags */
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  303  		writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  304  
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  305  		return -ETIMEDOUT;
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  306  	}
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  307  
077686da0e2162 Samuel Holland 2022-11-13  308  	if (status & RSB_INTS_LOAD_BSY) {
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  309  		dev_dbg(rsb->dev, "RSB busy\n");
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  310  		return -EBUSY;
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  311  	}
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  312  
077686da0e2162 Samuel Holland 2022-11-13  313  	if (status & RSB_INTS_TRANS_ERR) {
077686da0e2162 Samuel Holland 2022-11-13  314  		if (status & RSB_INTS_TRANS_ERR_ACK) {
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  315  			dev_dbg(rsb->dev, "RSB slave nack\n");
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  316  			return -EINVAL;
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  317  		}
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  318  
077686da0e2162 Samuel Holland 2022-11-13  319  		if (status & RSB_INTS_TRANS_ERR_DATA) {
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  320  			dev_dbg(rsb->dev, "RSB transfer data error\n");
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  321  			return -EIO;
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  322  		}
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  323  	}
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  324  
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  325  	return 0;
d787dcdb9c8f41 Chen-Yu Tsai   2015-10-23  326  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

