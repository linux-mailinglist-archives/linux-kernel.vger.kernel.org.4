Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C796D5326
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjDCVKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjDCVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:10:41 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D251705
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:10:37 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x17so7697076qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680556236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEedN3bFTKzplQihfI4j8rnbysKd1Yj2PDXKX4P7kwM=;
        b=h7rvXuVkFrIWxst6mbUhJE+VbY1rJ8L65pGKWRq8GoSZpg2yrgLOLQCv55XgjMt9TR
         Ypq+O4BolZT5cd6jNbBstEdaWNZjiT/a+I1TOruXvCFDPwu7kjqbcGvbYTVadTnlxPqc
         63NeASk/DV37iGvmjBLnIIaYXIvy6lKhUgQhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEedN3bFTKzplQihfI4j8rnbysKd1Yj2PDXKX4P7kwM=;
        b=L/4kuHlukDrUO5DZY8CJzyO5+hXcTtbiutvvNG4vTD4CErgo2VjjO9BNbVKq2NCHHM
         LE/Z9+iz1phkl1S9zGVhd8rCY4l2xhj7t4wR2+3bDOseplohdY3owkk4vyxtatp8dcNw
         U2WO/8bJ6M5XbcmT/y3Z/vMCer9RJd9fuaqSCsRtQHQXM9nv60yAi1Ofw6Apaq9dknvd
         /LSi5sW0kvh/EBnAOpU+gznAz2FsIYtGk3LZ4698inMX709DQzdWYQ9l/Y6Z6+P45j/0
         yBOrh3A4EzTNlJPnXuFTL0YmzfJvkl72SV2EmwZDQMXTsN/6bUyZlVALfsMotlskM39+
         nafw==
X-Gm-Message-State: AAQBX9fQe4fDi1PNTRFHmu+XwL15GWCg5svuyzVXQdc51+GXWSxOkV/F
        rQQSiMgbT2lYgLtFE5SGt/DGzfBJ5cs+w65Kh/0=
X-Google-Smtp-Source: AKy350Y6NdhYwxVrVxkuUuzyHSSC6NmaiEYhkuwzo+WXtqbGB8fRbMVe6dS7atcWdSTUYrUZ8bolmA==
X-Received: by 2002:ac8:7d81:0:b0:3e6:469b:85df with SMTP id c1-20020ac87d81000000b003e6469b85dfmr16802971qtd.18.1680556236394;
        Mon, 03 Apr 2023 14:10:36 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id r9-20020ae9d609000000b0074a29c9d8b7sm2301008qkk.134.2023.04.03.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:10:35 -0700 (PDT)
Date:   Mon, 3 Apr 2023 17:10:33 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     jim.cromie@gmail.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <owkyirqlrkdwvlmd4vlivgahd5uycolsdii3kvwbvakj5222mh@nydsfzk7uqtz>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> hi Luis, etal
> 
> kmemleak is reporting 19 leaks during boot

Hi, all:

I'm going to use this thread to test out bugbot. You can just ignore it and
let it do its thing behind the scenes -- if it explodes, I'll take care of it.

It should just send a single follow-up telling us that it's tracking the
thread, but otherwise stay entirely out of everyone's hair.

bugbot on

Sorry for interrupting and thank you for your patience -- this is for a good
cause, I promise. :)

-K
