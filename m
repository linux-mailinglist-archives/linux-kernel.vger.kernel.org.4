Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413656A8EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCCBoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCCBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:44:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485A8A4B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:44:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so4720721pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z4Izmtpe6A+FGHNDtYVCOvZY6ttPq+HHyaZSIEyjLo=;
        b=QDru2ShGrea6ivFoLgZOKi1RJNIuylB/St40a2BcpngvqQA+l/eLrSftj0tYuShEdu
         mE+3s9/mSLT2HYcnv/lecH32NOIDEaldbZU2AVqICf7W3F1eocuU5j+RFpUwehukLYur
         KPMhIyA6BzCrb5+tTrqYz5F0vNW5OybEMBo00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z4Izmtpe6A+FGHNDtYVCOvZY6ttPq+HHyaZSIEyjLo=;
        b=bZTI+IgTy0Z2ZAiEXSIb0Vf0FYq84lbLK6bu9ErwE/l3dCzfQfVtg/yuqi3tgoxfvp
         H7g5hhV75UlQdvTLapX2qzJvnllAQgprzGaVQSswhMgYHuWtKhA8eAT+pjXp0vmTlUOf
         fsA1QOTqERyOBM0R0mYZRwsYJr6QnjLHswsHp/u50M3dguiSwb0I8BwLhYlIJ2F2MjZk
         CyAnDVWBmnnnv+eVn6Yv+m6hBcZpeT75keo3G4lo6NT6lXkVRki6kFtXlWjbohiuAjvx
         ZST3Bi1vMZyfmoxqxu5tWYONdIWmPvLl1jOabs/98Pyns/NzLqfkoc5iVEpBehKQ44jD
         J5uQ==
X-Gm-Message-State: AO0yUKVhNhO/ivUJDPVqBAeCuYlbG9ySj822oxUHFHueTLddKEsSViLN
        BjAhqdOlLPv3TO4AJPFyrDpOhA==
X-Google-Smtp-Source: AK7set+LPAioHoytU7+vjU+ulqwj/OLfubh8KprN1MMUfBqzKhgW1xyr77d2yrv458tVX97CEFChEQ==
X-Received: by 2002:a17:90b:1b4c:b0:23a:333c:6bab with SMTP id nv12-20020a17090b1b4c00b0023a333c6babmr5336237pjb.23.1677807843699;
        Thu, 02 Mar 2023 17:44:03 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id bt9-20020a17090af00900b00230dc295651sm395624pjb.8.2023.03.02.17.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:44:03 -0800 (PST)
Date:   Fri, 3 Mar 2023 10:43:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <20230303014359.GB4022757@google.com>
References: <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/8TENp78WSQ0UW3@google.com>
 <Y//tqFQgsCeMimg5@google.com>
 <Y//zbxEmAmoA69ed@google.com>
 <ZAE9W5xQmQecUzhj@google.com>
 <20230303010643.GA4022757@google.com>
 <ZAFPf9pv1CTmIgtL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAFPf9pv1CTmIgtL@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/02 17:38), Minchan Kim wrote:
> > Otherwise I can create two big enums for fullness and stats.
> 
> Let's go with two enums at this moment since your great work is not
> tied into the problem. If that becomes really maintaince hole,
> we could tidy it up at that time.

OK.

> 
> > What's your preference on inuse_0 and inuse_100 naming? Do we
> > keep unified naming or should it be INUSE_MIN/INUSE_MAX or
> > EMPTY/FULL?
> 
> I don't have strong opinion about it. I will follow your choice. ;-)

OK :)

> prologue - seq_printf
> for (ratio = min, ratio < max; ratio++ )
>     seq_printf(s, "%lu", get_stat(ratio)
> epilogue - seq_printf
> seq_puts(s, "\n");

Let me try a loop.
