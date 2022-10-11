Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB105FB91F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJKRXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJKRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:23:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F35AA0A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:23:29 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id de14so9375611qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5c3GaIFAJ3ThsYjOgMQ5PeBEv2Rk81PZ4kNMxgrIlU=;
        b=Kyyhsa2weHle/mcPVTK5CBy7ViWi8hcWuFfiu/1wZ0PcwWoe5PwlsAbnemKHmmEBUm
         LuM4gsL9XFq/0pJdQfqTNkW7urhYhalmt0ueqhuU1Gb4Epm8mmt0ehBu/DqHDxDwxDRu
         CTPyuam97iJIEd4xenjQ6SHOTbPcolJM9PU9UR+2T0uoSqQq9Qb44qS7oYijkGqlk3Wd
         6Wfg3+A9GMffeZb5gLmKogn/ecGQEZTRty9bS1wQOoxK51pYe8Bui41ximTBL5HhWoHQ
         r8SSFAg6NBBpY3QHlud+2kJToh2VemI0MsMEoEg39zwk/T553WH+v9HkUqiwenWrQmiT
         VKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5c3GaIFAJ3ThsYjOgMQ5PeBEv2Rk81PZ4kNMxgrIlU=;
        b=nj34zlsLn+WkMm0zGCh0t/JZ1iapHM1EztrRTh1ex3HAUhLg+TeiC7Ci7X2rWt8Xr9
         M4VsVKyVycRiVvB6/Md8BsGmmct0ajqJUAL0EloggBZvdgvspEtUcfIdLfi5nUkgxAzE
         QpdBLk2s2qmgv3WMgAnzbf5rvJOACbduSnnlM7wd7uDmrtlZopV6G59gl2LMNgZwL7pZ
         TeylWzfRjimFlo8fIIzL3/YSbylCsYi3c2plH+4dRjHkmzLx/+w/ZBVLDzcKjnZYsw8s
         JFpIRse9YUDfonp1q3zUr3Puk7401bR07TwRAdOTcjynYST9RIHupe6OYa7JpLkCeoD4
         wbRQ==
X-Gm-Message-State: ACrzQf1KAkkrYMzr28PK/G7pPHcSqGmRtQQ9pvJIJv3B1NjXOL6DEjmq
        O3Izmt8mbo6CEe3PI8qdIKw=
X-Google-Smtp-Source: AMsMyM4FKyle0DhP/MvxKNqJiW9g+ccx1kXt2IX5Ng7IZkRFEtEGJ/1KGdmL9xPtdXPU9FXJYQEouA==
X-Received: by 2002:a0c:a90d:0:b0:4b3:f322:1280 with SMTP id y13-20020a0ca90d000000b004b3f3221280mr11185401qva.83.1665509008068;
        Tue, 11 Oct 2022 10:23:28 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:6051:2739:340:f252])
        by smtp.gmail.com with ESMTPSA id fd6-20020a05622a4d0600b00342f8984348sm10495156qtb.87.2022.10.11.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:23:27 -0700 (PDT)
Date:   Tue, 11 Oct 2022 10:23:27 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, lkp@lists.01.org,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [oliver.sang@intel.com: [cpumask] b9a7ecc71f:
 WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
Message-ID: <Y0Wmj+XnyD/c6XM3@yury-laptop>
References: <YzeclACdH9JmaRza@yury-laptop>
 <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
 <Yzh19JhBMzkMr4+L@yury-laptop>
 <20221011170949.upxk3tcfcwnkytwm@kamzik>
 <Y0Wk0WD6CL4aFEIi@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Wk0WD6CL4aFEIi@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:16:03AM -0700, Yury Norov wrote:
> > Hi Yury,
> > 
> > I just wanted to report that the warning fires when doing
> > 'cat /proc/cpuinfo' on at least x86 and riscv. I don't think
> > those are false positives. I'm guessing a patch should be
> > something like the following diff. If you haven't already
> > addressed this and I'm not off in left field, then I guess
> > we should integrate it into your series.
> > 
> > Thanks,
> > drew
>  
> Hi Andrew,
> 
> Can you please send it as a patch with a description?

Also, can you describe why we'd silence the warning this way?
If the cpu number greater than nr_cpu_ids comes from upper layer,
we quite probably should investigate what happens there...

Thanks,
Yury
