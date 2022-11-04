Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5D618FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKDEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKDEyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:54:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316727DC3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:53:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y4so3894402plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4I9Ji6tAVDHDLrwylf39oWxVLIphdPF1Bu4Q4pbq9AQ=;
        b=OA3XeghixmpcAh6FrsrhEfDl1v68dCm84uVLp2ArnIlXI1vR0Pi/keyugLU80o1PpK
         wxnt2M8cQAWeonEAhpDFxZxofb5vN9fWAffaNZ0w7a4ODfBxfV5O63+loRSYW7i7mk9L
         mBnzvWUehb/d706ayW3hsUPOYy3v2xw9HyQig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I9Ji6tAVDHDLrwylf39oWxVLIphdPF1Bu4Q4pbq9AQ=;
        b=2tBki17ao+rZDeziAuih5gUcclIK7hRdQesMNYFeVgzwndMvMylVDc8AZtjwd1+/JR
         oJMT2QWhSmsaXVX7Z3TtmYblAbcBoY0q6lbsQuD21Ho9z30BfmiflP4AjLogT5ZAs244
         yBM5z3sR5DR2M8Kyly9/zWs6xjteNjq38fvcFs3n1qu1JPGLju7ODNgEqnKjrL7pyiUR
         tzYpPVmv1CncIdDApqKqu8sKBQthrUJH2Bfl/v/8hG1FwKZEcwmMeTQVR9L4udcKuQTx
         EZbpfilqo6nt0QtEh51ysdJ1ZzxvUBmIkeYxO+vd7uIxIdDHGhXPga4L4SjS30ebRr+T
         9w0Q==
X-Gm-Message-State: ACrzQf3lojoRYj7r/7qna7Ez9cRxuCRoz5KVZNr4otvHgDLoGpJSg+kK
        aG/5UvTvrmx/vBocaz22+0wo9g==
X-Google-Smtp-Source: AMsMyM5QyTSm0c9TBvu/siTDATAl5JKUTlEG61Jiwk8uw0TimeNmzqp3m98ZHrakvj3zIBYgg8/pEA==
X-Received: by 2002:a17:902:d4c3:b0:187:2b8:a4fa with SMTP id o3-20020a170902d4c300b0018702b8a4famr34754030plg.134.1667537596277;
        Thu, 03 Nov 2022 21:53:16 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id az4-20020a056a02004400b00439f027789asm1543486pgb.59.2022.11.03.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 21:53:15 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:53:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2Sat1/FCCT0Lia/@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2SEkzKSWx2iQzLl@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 12:18), Sergey Senozhatsky wrote:
> On (22/11/03 09:34), Minchan Kim wrote:
> > Yeah, I like the name and priority format.
> > 
> > Only question is how we could support algorithm selection change
> > under considering multiple secondary algorithms.
> 
> So what I was thinking about, and I'm still in the mental model that
> re-compression is a user-space event, just like writeback, extension
> of recompress sysfs knob with "algo_index" (or something similar) which
> will mirror algorithm priority.
> 
> Example:
> 
> Configure 2 alternative algos, with priority 1 and 2
> 
> 	echo "name=lz4 priority=1" > recomp_algo
> 	echo "name=lz5 priority=2" > recomp_algo
> 
> Recompress pages using algo 1 and algo 2
> 
> 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> 
> Maybe we can even pass algo name instead of idx.

Or pass priority= so that interface that uses algorithms has the
same keyword that the interface that configures those algorithms.

I still don't see many use-cases for "delete algorithm", to be honest.
ZRAM is configured by scripts in 99.99999% of cases and it is
quite static once it has been configured. So we probably can use
the "don't setup algorithms that you don't need" approach, to keep
things simpler.
