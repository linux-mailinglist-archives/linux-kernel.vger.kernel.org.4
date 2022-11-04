Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8A61A613
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKDXo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiKDXox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:44:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087730560
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:44:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so5628303pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbYMQSTlWErMi0dlfZfN+APvyvfPo1NmalRHcGJBJUA=;
        b=nN8SwqwOtFpxlzE+LhE/SLk4Y235L1jNgh/mYuDBAyGQUbHBjmj/5f3PMTChIEcWXy
         fHyNc4fh3LyM3g0S+Bz93toRGeFIQ1FWbGf37ecVDJz70mjuUUKsMBKJxmIFRSMrRajA
         2kASL1HnS3KE/ANbacU6GwpRtl6W+kMHrfVAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbYMQSTlWErMi0dlfZfN+APvyvfPo1NmalRHcGJBJUA=;
        b=qLAAAS1Y5WCL2GhaUFwsJ+Y2ek1NeAPkqqiBeUpz/70hyNOXzo1HdiCt+e7aJ2/xu7
         e8nthLkSPxboz/NdM9njcuoIh66oMQXmOExvGg4iRgbevJOu6VFKrIAAZQ9dJi+e2dI/
         zLpGXYtj67Z/PB0Ci37z8r/pMIt+xhcqgfvJ2rxBhko1CQsTGKe4DFhYkw1MIkWcMVVn
         4BiOK/SinQLYN5LT/6RNlQCnIU1+R6ct0DjUqA6UutFZ4VvLngHWRwo6xHbcM3mz8RCF
         7ewfAnI/YKVDvbczE0bPEjs9WVuhdEFf/Yio6bWxUCFT3vh65FEVUYr3A9wARjhuTYNX
         WJcQ==
X-Gm-Message-State: ACrzQf2m+dyeWYpfjEx60IhMHVIGqTAepLXWEAT4hqMYRALJmn30JSov
        qEuGxElnVI36o8CA+VmRPlP94w==
X-Google-Smtp-Source: AMsMyM5gvQlFVPQtzvXPQ8bWwfYGPbcB3uOukJyB9L2y6dujo2uc13V+TqDBifAvayTpcdLq/CffHQ==
X-Received: by 2002:a63:ea58:0:b0:45f:ffa9:60a0 with SMTP id l24-20020a63ea58000000b0045fffa960a0mr32834833pgk.433.1667605491154;
        Fri, 04 Nov 2022 16:44:51 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id p3-20020a622903000000b005636326fdbfsm163832pfp.78.2022.11.04.16.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:44:50 -0700 (PDT)
Date:   Sat, 5 Nov 2022 08:44:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2Wj7o9nibDr2X0C@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2U+/xQBwR3MPygL@google.com>
 <Y2WfeLNwkwQZkEi8@google.com>
 <Y2WjCsYrGfUENegL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WjCsYrGfUENegL@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 16:40), Minchan Kim wrote:
> > > > Configure 2 alternative algos, with priority 1 and 2
> > > > 
> > > > 	echo "name=lz4 priority=1" > recomp_algo
> > > > 	echo "name=lz5 priority=2" > recomp_algo
> > > > 
> > > > Recompress pages using algo 1 and algo 2
> > > > 
> > > > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > > > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > > > 
> > > > Maybe we can even pass algo name instead of idx.
> > > 
> > > Let's use name rather than index.
> > 
> > OK. Any preference on the keyword? "name="? "algo="? "algorithm="?
> > "compressor="? "comp="?
> > 
> > I want use the same keyword for recomp_algo. I sort of like "algo=",
> > but not sure.
> 
> +1 with algo

Minchan, I'm sorry I'm getting a bit confused (didn't sleep last night).
I just saw your other email and you suggested there that we don't need
any idx or name in recompress. Or did I misunderstand it?
