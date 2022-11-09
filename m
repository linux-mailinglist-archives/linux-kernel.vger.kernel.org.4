Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E56622F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiKIPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKIPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:46:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F810FD3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:46:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2275999pjc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZ2A0m4TgBzszRDy9z9vcXOFUGK9jfh5OUJcLxvh/h0=;
        b=LDvkCn3rxHci73vfoao/encxzaYvwC+2pzLmEgA/IFDUofNyHB8092Sen50KULTiTA
         dkcRHp+EhqjHTdPFRNtFLyTdeHCH/7sk/QMTMt2X8UlodrGObVqKyOnRBhibjutc20nD
         jsjEQCYlQtnXEWUB2HxkS9BBRVztNTIPcxD6FqAjgTUs8vc5epRGrFQR2u0XdnUtfPJm
         z8eRsHgHIhkztpekuFrxNpkiBpGf13PoYvNcXSGyoyfvvaoYNm4fOEdzNSW3vtM6R+Uw
         g90uu6XQkcCiN15cBJ+kgz/fMk7jISkFLWeNHCDlQWg7DFPZXas/BzLACOEY/HyDWy34
         rYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ2A0m4TgBzszRDy9z9vcXOFUGK9jfh5OUJcLxvh/h0=;
        b=hHpkDgLMsgL3doNgv8CLUOBmE+HzIVz3/hw4qTNKzsDxdInm+CS836JH72RyBsGpKf
         BB9gW1uNbI1N8Ez5EbTLM2VktYtCJd0PyUkNeRxdQ+XHvczjPbYec0UuQSXeNWzf3TsB
         nx2sSbKIHL9n2i4KO/Tg6AfTwX9w2ojweVQXPcnybmP34mVWUeSx/u676XEsaWaxuQvU
         YlVj0bugKagYvOfgeCONbh0fAEOL1n432FVOvt5SnnMCUUM8IwnD7hjUikArsfnT05S1
         7jc3UEHcXaV3d0nPJ2tmYx4D18ZfQdag4dfavPMMqaDSjLAkdc2rP07X0M98+8ozMjiN
         VLOg==
X-Gm-Message-State: ACrzQf2kEK2wbUWf4ooDJofTl7ZZiaeAPTsn7aLWH+Nax85kguVLEFfo
        ZB6N1CAqC0GxhQNoX5zYcii6Ti8p8jGvkA==
X-Google-Smtp-Source: AMsMyM5I67vMBpnvc+5aW9RaOItLwDL+K5Rvx5TdNxohisuykvfikm1Y1KaH1SNTaKXf271XZhPnsw==
X-Received: by 2002:a17:90a:7523:b0:213:8a69:c502 with SMTP id q32-20020a17090a752300b002138a69c502mr63282627pjk.153.1668008799945;
        Wed, 09 Nov 2022 07:46:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm9171714pln.297.2022.11.09.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:46:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 9 Nov 2022 05:46:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Message-ID: <Y2vLXWvZ9uwaVICx@slm.duckdns.org>
References: <0000000000002473fd05eca7540a@google.com>
 <20221109120415.55759-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109120415.55759-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:04:15PM +0800, Chengming Zhou wrote:
> syzbot found a lockdep warning in kernfs_find_and_get_node_by_id(),
> bisected to the commit c25491747b21 ("kernfs: Add KERNFS_REMOVING flags"),
> which didn't hold kernfs_rwsem before call kernfs_active(kn).
> 
> Since kernfs_find_and_get_node_by_id() doesn't have to get active count
> of kn, only need to get a stable refcount of kn, so it should be enough
> to just check kn has been KERNFS_ACTIVATED.
> 
> Reported-by: syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
> Fixes: c25491747b21 ("kernfs: Add KERNFS_REMOVING flags")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
