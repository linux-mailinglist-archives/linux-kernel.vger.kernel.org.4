Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B596726B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjARSW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjARSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:22:45 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1F4F87F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:22:44 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id v17so8011197oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59HNFzIDSBb35leXub+SzrL269SK5+8B75jUp0cDEoo=;
        b=O+cICE+qLRo9GTuTN9tfppFH6f05hEXNvgAKwh6cCKET3cSGi7OFsZilRz3fERsiIY
         ViBoeC/9d9iad0xj69QFe1ayD+3fM6SyQ1lflk1XEsOasYmDlJFPWQxUgHLYjv4E8Szy
         GBSNVgFyDTEd7tz4M5gOCebw1cWshUxQU3z8s5uh6l/KagD/jonycKN2k+r7pQyCbCTB
         SSsXRK+oHRZ95RNtzDwP8Jmq0MMsms957ppXPlrzHtLaGtwYPEsAPb116Ff5MZQoJqYW
         SL0FqEk0XTMceD1dYSn9iUPeHAMN2PvGVJBLfsEBqR6LO1T1C/i9ukYk8vOcinCvman+
         FmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59HNFzIDSBb35leXub+SzrL269SK5+8B75jUp0cDEoo=;
        b=Y1S81YFhxFBR3tOs/S3gfFtsryaB6AdvtL2lHZYg9Xm+afSYBh2/9ZO28DW8Byfeix
         i2urpSm9oK5hzI98ZJ6nSv+xPawnWu84X2nnfuhgVqtbLzhoERT1anRIAodZxtrpd+ZI
         renrJPYZDiqRdkC7X3dvpyflJTqAXS1urCx9zJ+9VPekcYNZNBbDZH7orxOQiiVKjuhx
         m+m04q+/Ib9p5zqiGTZczSmyTtMVN642Z9FWVepgFfHKrn3YWYmo4JdxoU2wI6pZ9Jpq
         TjeoJyCNp5DM1PmyqcVo4xzIXRev9pZAlZsJOKbkgAOQdi6jcexYooueVCINZiegJ3QJ
         kzxg==
X-Gm-Message-State: AFqh2kopGI9eR61Kr+zh0XdVf+ZCq4NECd03qPsDp6YRhWaKqfO0hiPl
        T65m+YQ8nrBygS6l3sWcXuqPwSe/Z0kY2Ek8VI8FOQ==
X-Google-Smtp-Source: AMrXdXvO1z54tKlvmAxrvMYmhfiKDst+2bjCBUoZVOrIRjGM42UDXNQZUoCV4olfW6Vv73mojTimvknkz+0Jsrc6j/s=
X-Received: by 2002:a54:450c:0:b0:35b:d002:675a with SMTP id
 l12-20020a54450c000000b0035bd002675amr514259oil.44.1674066163692; Wed, 18 Jan
 2023 10:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20230113210703.62107-1-nhuck@google.com> <Y8HI+42TxxlJxT6D@slm.duckdns.org>
 <CAJkfWY7vmvrU8sW3OWpSa9zygY=6e8BTTkktPe-VScdOcLL-sw@mail.gmail.com> <Y8gxu7l8BUWewuMg@slm.duckdns.org>
In-Reply-To: <Y8gxu7l8BUWewuMg@slm.duckdns.org>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Wed, 18 Jan 2023 10:22:32 -0800
Message-ID: <CAB=BE-Q9jtJnqPwGzSTQ6-soZ9STvqAebeONy=Eyo08H+eg-rQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Add WQ_SCHED_FIFO
To:     Tejun Heo <tj@kernel.org>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 9:52 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Sat, Jan 14, 2023 at 01:00:00PM -0800, Nathan Huckleberry wrote:
> > This sounds fine to me. How do you feel about a config flag to change
> > the default WQ_HIGHPRI scheduler policy and a sysfs node to update the
> > policy per workqueue?
>
> Yeah, sounds fine to me.
>
> Thanks.
>
Hi Tejun,
If with the kernel config option, every WQ_HIGHPRI is elevated to
sched_fifo_low, wouldn't that be kind of defeating the purpose? Having
another class for even more urgent work is better in my opinion.

Thanks,
Sandeep.
> --
> tejun
