Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB061A5F8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKDXlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:41:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B322791A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:41:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q1so5622680pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNzgIEAgfWeeZ+vYlyj7j3dlBGeECygxdNOGMxY6Yqg=;
        b=Kp1TgF1QutdsH1sgEuD8nM/a1JFXpggJoWxJC/HioGIRzpscqHVBcdtH4JVSNgVDN7
         51qwRVlnZK+CF4Zc+vRfa6lLuUWxFhtsTKXifPrsjJpSlgjdudvanpyZ77N1ODeayHY7
         OhVAS2tUNNV3oSQQDYegpABmOHpjIbI8FF0JZ3aME6oGdWpoqqgVXHNn/U3234t5OcRD
         kNJb9Pu08WBJPORqUTB80hn6/I9KQ8QRV0oAOAJBvVFuzW1/yJdf8yvmwT0XeIvmfO5O
         wSuwyW0z0AWyTccbPN7yuPFo2y66Wi3th2oTm4inkrOjM4e6IbTr62n5B1koiJPVgGeB
         n6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNzgIEAgfWeeZ+vYlyj7j3dlBGeECygxdNOGMxY6Yqg=;
        b=Xp9VBo5ViPD+tpB1OJAc22O/sR7NEwWzRaFfMMTBvc6SBgoqhHDl7kvLLHU2cw3CZM
         kO//uvHf55VozWk0b0lDjKqj/ErnP9Dltm+USteqTMQIN7YYLTTknv/TVnnncacsm1Rw
         FhmQvvZOESf28wkOQ+n1ooUPiGlinSvm9OrmLM3DNO4iwL5RuhRTz5qTRG8hrNmUBmEo
         URJBagWLMoZPlJIqPkQEwKLjWe/TcopTwXpS8WELbJaGXiitcdCNuw/QBumFPUrmH5Lb
         AxLWxRLbM0icc65KDLl0d9jz9yVC4U8jbxA+IJ5i93PCkGyDUZ6TLs4LclXjc5aZH1j+
         K0cQ==
X-Gm-Message-State: ACrzQf1OqW2pgGK6UgMRGNGL5uDOGYlGxGyj03P7Mj9IOozktE9wxvw2
        fA43WGZQIntP6PyYeIQM6cvroeiVuxw=
X-Google-Smtp-Source: AMsMyM4vPmVa+nsFujJmUrGtJlX2BmdjFvnTbT0UNeqQSDJK9BseigJIBheq+gPYKLbBXfaxdoVH6g==
X-Received: by 2002:a63:1f0d:0:b0:464:69f8:1cbc with SMTP id f13-20020a631f0d000000b0046469f81cbcmr33077640pgf.574.1667605260459;
        Fri, 04 Nov 2022 16:41:00 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090311d100b00186b5c1a715sm283857plh.182.2022.11.04.16.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:40:59 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 16:40:58 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2WjCsYrGfUENegL@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2U+/xQBwR3MPygL@google.com>
 <Y2WfeLNwkwQZkEi8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WfeLNwkwQZkEi8@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 08:25:44AM +0900, Sergey Senozhatsky wrote:
> On (22/11/04 09:34), Minchan Kim wrote:
> > > > > So, as far as I understand, we don't have reason to add remove_recomp_algo
> > > > > right now. And existing recomp_algo does not enforce any particular format,
> > > > > it can be extended. Right now we accept "$name" but can do something like
> > > > > "$name:$priority". The only thing that we probably need to do is rename
> > > > > recomp_algo to either add_recomp_algo or register_recomp_algo?
> > > > 
> > > > Yeah, I like the name and priority format.
> > > > 
> > > > Only question is how we could support algorithm selection change
> > > > under considering multiple secondary algorithms.
> > > 
> > > So what I was thinking about, and I'm still in the mental model that
> > > re-compression is a user-space event, just like writeback, extension
> > > of recompress sysfs knob with "algo_index" (or something similar) which
> > > will mirror algorithm priority.
> > > 
> > > Example:
> > > 
> > > Configure 2 alternative algos, with priority 1 and 2
> > > 
> > > 	echo "name=lz4 priority=1" > recomp_algo
> > > 	echo "name=lz5 priority=2" > recomp_algo
> > > 
> > > Recompress pages using algo 1 and algo 2
> > > 
> > > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > > 
> > > Maybe we can even pass algo name instead of idx.
> > 
> > Let's use name rather than index.
> 
> OK. Any preference on the keyword? "name="? "algo="? "algorithm="?
> "compressor="? "comp="?
> 
> I want use the same keyword for recomp_algo. I sort of like "algo=",
> but not sure.

+1 with algo
