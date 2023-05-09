Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB816FCA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjEIPdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjEIPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:33:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877318D;
        Tue,  9 May 2023 08:33:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso2558964b3a.1;
        Tue, 09 May 2023 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646385; x=1686238385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7WJkpzGGE6V0xVNeJVOJY0t5blLhcdTlZlbB7BS+gc=;
        b=FMLxTBr+wd5rAK2nIKeykMToZJkUULXyulEWPfS6JYiK1UgR5o2h3w26z+Yp5/E1dr
         bDqh6NUr1VibilmFjm0izLQlHS7O3u2QFaPLG8TDdue+dxViTl4cFiDPcodggspN4syC
         0Jm5BWCsqs8t8xiPv8URVb3gGxjyDJE1h8qhQgkRNUUk5CFvN/6jMHeYjjnf+R5yfbCy
         v1/v7D3FsFSTef9YGbO+6gzivSoPl9Osoj5hd77kSs5lZbAUkusRsi+f3KewpSPOUIWl
         54LKKqInJG5+r4xX4y4CRd2skQp449TLmyTxz3UyHCpou2UndeaOOtJ1PVDJuQ/b9ImG
         H1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646385; x=1686238385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7WJkpzGGE6V0xVNeJVOJY0t5blLhcdTlZlbB7BS+gc=;
        b=gMg7NPmwWztfcJT5aTYC/En783mitl9xnA42u8zj8M89aBTfeC67yZfs8vFIeHEI3P
         6RkOfFO7Vc6x+2a5SDaIaCObYgZbG+09FNEu5yFPrgHQlvf5XurH9GnZL1VmvA3TVgP+
         NFXi8YUJAGNq/EvtxGxCUjssAEQdPuc7jK74/Si/WY9O6lnQflT9A94JhJ3n5TvTyA8C
         pHQj6PueklhNSba3n/mkOK7+61PiaGYlqydC6bKhkSujRF+UJHfUtmgy4otnS6lml6ab
         1RwpuofActfmN+ZnetaquFy8PqgZ1v+7c0dtAYZ9fndgx90SdMIyQsWHB8IBCPpQ8R3O
         /lNg==
X-Gm-Message-State: AC+VfDxJqGX/escsP68235p2l+hF7vBaQ7W4M5GVed2L/Z/1qibrbrZu
        XIOUK5feX8R7nl+3rEFJT9k=
X-Google-Smtp-Source: ACHHUZ74rXgHLVMBYI8vEBAiCwf0n8BlFeTay98rF3Y8zTkmdIFPU6Z4y3sKE+ysJMc+3elFYvlBmA==
X-Received: by 2002:a05:6a00:9a7:b0:638:7c22:6fd with SMTP id u39-20020a056a0009a700b006387c2206fdmr21606404pfg.1.1683646384720;
        Tue, 09 May 2023 08:33:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p24-20020a62ab18000000b0063b5776b073sm1908446pff.117.2023.05.09.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:33:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 05:33:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot warning
Message-ID: <ZFpnroBw-tJnyDbF@slm.duckdns.org>
References: <20230509122440.418068cb@canb.auug.org.au>
 <87mt2ex9oo.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt2ex9oo.fsf@mail.lhotse>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:09:43PM +1000, Michael Ellerman wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Hi all,
> >
> > Today's qemu test boot (powerpc pseries_le_defconfig) produced this
> > warning:
> >
> > [    2.048588][    T1] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
> > [    2.051560][    T1] ------------[ cut here ]------------
> > [    2.052297][    T1] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:5925 workqueue_sysfs_register+0x20/0x1f0
> 
> Caused by 59709bb84c22 scsi: Use alloc_ordered_workqueue() to create ordered workqueues.

The patch is already dropped. It was applied only for a short window
yesterday. Should be okay now.

Thanks.

-- 
tejun
