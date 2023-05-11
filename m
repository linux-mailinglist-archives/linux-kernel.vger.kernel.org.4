Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9A6FF059
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjEKLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbjEKLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:02:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D3211F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:02:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so40126445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683802952; x=1686394952;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6wHelDtK2nIDObvAlBqtnzBhHlFB/jv/mjLnemnkJU=;
        b=yenykVmXmqxKntVc14UQ1cCjejaidb6VnoSD/Hsld4uTIF1yO061mr2c8Df6t6T2iU
         W/2C1Ph9b6NTBoIanGBa8NcdEyC8SzMDya+r1sW5MhVEXivqJgXRv61Tn9AbjI2ei/wo
         jrfZi5fXADaCwpTxfkp/hPOui8wloVbpM62a8gxiqPb9g0u74K7nTL8ucZQzm7nEZlMm
         vcdi7GbpRO9HBtXY6J9MI1VPvprdnmb6wol2smMxpU79W/47/8t0wNuL34fFhMSFMzm0
         Tzm9uUeP0+yhddW8DyUnC1l18chJ0MHtGbuIrBtQh2+VFSZwp5tFW4uu4Le//l17aY1Q
         gIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802952; x=1686394952;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6wHelDtK2nIDObvAlBqtnzBhHlFB/jv/mjLnemnkJU=;
        b=GmiWNBpuRGTpGpRHInU3uCYql7ts7VzvCYeY4pCFGpAwsM0sAQwCF56G44+xM2Ogsy
         blFbOQ5iPt6zHT2NnPeI/iln0DTzKOTxdm5KYSKqB6wgPAlxNSy4qFcJgci8mfnAz08O
         iE3cbAtwxHtt6DsbA7IQL41eMx0wBbi3bemp89DjMltBq5uVayXg0yTL83BvLZR/SkcX
         +f9ycX+PivrbBbOe5J2jg8aRHTWNagsGffZN2vwIJAc/uj8vO9fkg9esG21AFg/GiVuj
         xUkneyMbzOqgEDC3bKbGzqickDhTyCBfV9wul/h6KMfzlvE7TArbTa3u6gYm6S0geh/N
         4OhQ==
X-Gm-Message-State: AC+VfDxcn+IXaVCDy3rkW0lft98q7BkfgFnUkLSD14ZI4jxf1muJUkHy
        MXgFpVFul6IoOJ7Pmnt1NbPdog==
X-Google-Smtp-Source: ACHHUZ6D4jefzQLsYunWhAl+2cf9RSsn9Y9TWRug7Tm623bfFTdQ/3Ft6budj35cfNKIMk4KsSEOEQ==
X-Received: by 2002:a1c:f408:0:b0:3f1:7372:f98f with SMTP id z8-20020a1cf408000000b003f17372f98fmr12462958wma.41.1683802951924;
        Thu, 11 May 2023 04:02:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c229200b003f17a00c214sm24947041wmf.16.2023.05.11.04.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:02:30 -0700 (PDT)
Date:   Thu, 11 May 2023 14:02:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linfeilong@huawei.com, louhongxiang@huawei.com,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH v2 6/6] scsi:scsi_debug: set command's result and sense
 data if the error is injected
Message-ID: <ea5ec1a0-7f4c-426a-86a0-03ce2a6233ed@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428013320.347050-7-haowenchao2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-scsi_debug-create-scsi_debug-directory-in-the-debugfs-filesystem/20230427-201534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230428013320.347050-7-haowenchao2%40huawei.com
patch subject: [PATCH v2 6/6] scsi:scsi_debug: set command's result and sense data if the error is injected
config: mips-randconfig-m041-20230509 (https://download.01.org/0day-ci/archive/20230511/202305111419.HegopAw8-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305111419.HegopAw8-lkp@intel.com/

New smatch warnings:
drivers/scsi/scsi_debug.c:7880 scsi_debug_queuecommand() warn: missing error code? 'ret'

Old smatch warnings:
drivers/scsi/scsi_debug.c:5389 scsi_debug_slave_destroy() warn: variable dereferenced before check 'devip' (see line 5388)

vim +/ret +7880 drivers/scsi/scsi_debug.c

70abb3e2434633 Wenchao Hao     2023-04-28  7861  	if (sdebug_timeout_cmd(scp)) {
70abb3e2434633 Wenchao Hao     2023-04-28  7862  		scmd_printk(KERN_INFO, scp, "timeout command 0x%x\n", opcode);
70abb3e2434633 Wenchao Hao     2023-04-28  7863  		return 0;
70abb3e2434633 Wenchao Hao     2023-04-28  7864  	}
70abb3e2434633 Wenchao Hao     2023-04-28  7865  
b3f5d28c11bee2 Wenchao Hao     2023-04-28  7866  	ret = sdebug_fail_queue_cmd(scp);
b3f5d28c11bee2 Wenchao Hao     2023-04-28  7867  	if (ret) {
                                                            ^^^

b3f5d28c11bee2 Wenchao Hao     2023-04-28  7868  		scmd_printk(KERN_INFO, scp, "fail queue command 0x%x with 0x%x\n",
b3f5d28c11bee2 Wenchao Hao     2023-04-28  7869  				opcode, ret);
b3f5d28c11bee2 Wenchao Hao     2023-04-28  7870  		return ret;
b3f5d28c11bee2 Wenchao Hao     2023-04-28  7871  	}
b3f5d28c11bee2 Wenchao Hao     2023-04-28  7872  
ef1cd466d439a1 Wenchao Hao     2023-04-28  7873  	if (sdebug_fail_cmd(scp, &ret, &err)) {
ef1cd466d439a1 Wenchao Hao     2023-04-28  7874  		scmd_printk(KERN_INFO, scp,
ef1cd466d439a1 Wenchao Hao     2023-04-28  7875  			"fail command 0x%x with hostbyte=0x%x, "
ef1cd466d439a1 Wenchao Hao     2023-04-28  7876  			"driverbyte=0x%x, statusbyte=0x%x, "
ef1cd466d439a1 Wenchao Hao     2023-04-28  7877  			"sense_key=0x%x, asc=0x%x, asq=0x%x\n",
ef1cd466d439a1 Wenchao Hao     2023-04-28  7878  			opcode, err.host_byte, err.driver_byte,
ef1cd466d439a1 Wenchao Hao     2023-04-28  7879  			err.status_byte, err.sense_key, err.asc, err.asq);
ef1cd466d439a1 Wenchao Hao     2023-04-28 @7880  		return ret;

ret is success.

ef1cd466d439a1 Wenchao Hao     2023-04-28  7881  	}
ef1cd466d439a1 Wenchao Hao     2023-04-28  7882  
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7883  	if (unlikely(inject_now && !atomic_read(&sdeb_inject_pending)))
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7884  		atomic_set(&sdeb_inject_pending, 1);
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7885  
c2248fc974df7b Douglas Gilbert 2014-11-24  7886  	na = oip->num_attached;
c2248fc974df7b Douglas Gilbert 2014-11-24  7887  	r_pfp = oip->pfp;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

