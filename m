Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3019266A2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjAMTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjAMTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:17:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4078785C9C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:17:32 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 78so15632544pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRWgiNaMeltHmAJV2kQfFQoDr9nejBLQN7r/YHxTLXQ=;
        b=f4mlUPkNMkV8yyeis/tp4tanXbbBbphxH5u5awFaBQkCNZPs781Z8Rmm8SEciy9bha
         U+2Uo9kW0vTitntuwJLnPlO7OC9Hpfdz4e+VtGVuWqainYJaJ8SCnJ2Vs8RESLoWiCL5
         nPrbE0c+Zwf0uRVawGpgw7DfFk29nAz7R3QzHnc/dMmQXpqyTx8WL+4W0NEW7c7m5sxM
         mydt42TcOk4ejqD7lyR5+HKrcrnYlk2kCSXgGkXx0LK+J+vV0CUJNOODKdQ533mbi+Lx
         XkHOw/iKiqXaNzvRlLGKFJqaLR1PImDhgYFY//qLc6UCdSlC/93jTn3+S5qY9dN3X6si
         llPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRWgiNaMeltHmAJV2kQfFQoDr9nejBLQN7r/YHxTLXQ=;
        b=Sl0aWPO4yuMkkzL9jOrdWIKxylGXw0VhU7PWYszgZioi1FaZAbRTZTNM8XheVWrNQh
         N7exK943R/A9wCUnqFXhnjong5Uye7hct+aim3wAgMRzmN5kdMwz/DnUT7HhU1PgPn/n
         GtBwSxRYoE82ny69dnE/656TGku8JbMAyCyaay35aomdhjLHmLw4tgiDyHlxRNqnzghv
         TccSMFG88pZrtFT6hxXCrh35derBBBWtY+8xacurs1f3sv5eas/Wc5WHX7b7KZ4fBK+4
         AgSOE4ShQXkWVZ4KYM279zOG27gM4ObCpXd3Jj76VAk/Ha/oScXPbZPAtChtKo/g5UHg
         fWLw==
X-Gm-Message-State: AFqh2koJ/QBjVd7OQZUKocG+iiCTZbKz150tvHxZuIVHlfze99IO3Xib
        tLwSTQypX2D5rsVypPZYvcQ=
X-Google-Smtp-Source: AMrXdXux2dKgvfdKyAlACg2fuxZU7NB4oCMFIUjO6vqyDzfw2pS73Jedr7PZN1XKb/5kPu1fXzMmxA==
X-Received: by 2002:a62:58c1:0:b0:573:f869:2115 with SMTP id m184-20020a6258c1000000b00573f8692115mr77389361pfb.9.1673637451702;
        Fri, 13 Jan 2023 11:17:31 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2e4e:fba:501b:3a8c])
        by smtp.gmail.com with ESMTPSA id g27-20020aa796bb000000b005815837164fsm13960468pfk.59.2023.01.13.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:17:31 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 13 Jan 2023 11:17:29 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, Vitaly Wool <vitaly.wool@konsulko.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove PageMovable export
Message-ID: <Y8GuSf5LXVm46tUz@google.com>
References: <20230106135900.3763622-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106135900.3763622-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:59:00PM +0100, Greg Kroah-Hartman wrote:
> The only in-kernel users that need PageMovable() to be exported are
> z3fold and zsmalloc and they are only using it for dubious debugging
> functionality.  So remove those usages and the export so that no driver
> code accidentally thinks that they are allowed to use this symbol.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Minchan Kim <minchan@kernel.org>
