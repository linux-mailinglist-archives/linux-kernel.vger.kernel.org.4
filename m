Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241963D8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiK3PBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiK3PBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:01:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F314973424
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:01:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2408900pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86zFn/FteF14a6gSqc/t+icne5yM4V97yYntUv+U9gg=;
        b=PPWP3BvbQpN3iUCNm1H2AKNUYUQuX4dJKMgv17FwRD9QWugLlLMtmh5zlSGye+/cHe
         OPgNbjY6MCE5UUjzus3yrxHqQhtOd76vA+QttpE//1wL/XNCl2lbqi2Pw/SNa8340gX2
         gXK9v2vmxn5s0F51M8duApAmMSr4h33lhptEKr3frXpv8xpPpn2pf6PzWX6xPLEl7fUp
         XeCrFfp49JU26np4Ok4HqkjHE9AZEWNETewfiY42+M37JepzPmSV2vUk7jj6rW4ios08
         qDEtl8ZN4iZUvMBzW6hlhk/j68ho1vnFWjXWTj74X00uzexAdUaVTpaSzZbwJsA804rO
         +6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86zFn/FteF14a6gSqc/t+icne5yM4V97yYntUv+U9gg=;
        b=hszJdu6Glj0WzdSTc6L8CHtJ22sRsXlHwWUl25BwM5BpPp4H7Rd9bMJaxMR2Qh9Q28
         Ep2DYolNBXzH6NDQXakRbmvSH06Mqb0f3n7zCmDnonYlKO1c/6KM26/IdiNgfxwkcheO
         u6zydE8lzadtvvTeN/M+khr3l3DvqC9smNapXW+MKmOWRxqGLIWb/AG0ziBgiMbTls5n
         mmrZlX89dtob95KBCzfkyRexVh0OPyiMo7WNAsY9UK4o6gpGWi/qBwXPpXYVnyTIZkPC
         aY3PrcAQpAnbmoS3UJIfg3OjFAUHaUvLtIzPQKv3KRe+G4CCNP43aI5Ry69vuCgoy+No
         xTXg==
X-Gm-Message-State: ANoB5plMc1G+dC5K7yy0FTvRBJJZAGFO3GMWSZZD656+f+3wDzbsZrg0
        osVKvZ86FyvZ/oiLS9kfASqlhw==
X-Google-Smtp-Source: AA0mqf4Ed/vQ7EzkIKYA21VxQnoeXNiBV0MM3xrpLzXmefHYcddvBX8REMo9tVSZ4vDfwwPTLwNfQQ==
X-Received: by 2002:a17:90a:5305:b0:219:2d33:9504 with SMTP id x5-20020a17090a530500b002192d339504mr18323743pjh.171.1669820470913;
        Wed, 30 Nov 2022 07:01:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b0045ff216a0casm1115161pgj.3.2022.11.30.07.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:01:10 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:01:06 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 6.0] binder: validate alloc->mm in ->mmap() handler
Message-ID: <Y4dwMu+iL57XMZ28@google.com>
References: <20221123180809.1501779-1-cmllamas@google.com>
 <Y4dPSFygaaPGKBdK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4dPSFygaaPGKBdK@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:40:40PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2022 at 06:08:09PM +0000, Carlos Llamas wrote:
> > commit 3ce00bb7e91cf57d723905371507af57182c37ef upstream.
> > 
> > Since commit 1da52815d5f1 ("binder: fix alloc->vma_vm_mm null-ptr
> > dereference") binder caches a pointer to the current->mm during open().
> > This fixes a null-ptr dereference reported by syzkaller. Unfortunately,
> > it also opens the door for a process to update its mm after the open(),
> > (e.g. via execve) making the cached alloc->mm pointer invalid.
> > 
> > Things get worse when the process continues to mmap() a vma. From this
> > point forward, binder will attempt to find this vma using an obsolete
> > alloc->mm reference. Such as in binder_update_page_range(), where the
> > wrong vma is obtained via vma_lookup(), yet binder proceeds to happily
> > insert new pages into it.
> > 
> > To avoid this issue fail the ->mmap() callback if we detect a mismatch
> > between the vma->vm_mm and the original alloc->mm pointer. This prevents
> > alloc->vm_addr from getting set, so that any subsequent vma_lookup()
> > calls fail as expected.
> > 
> > Fixes: 1da52815d5f1 ("binder: fix alloc->vma_vm_mm null-ptr dereference")
> > Reported-by: Jann Horn <jannh@google.com>
> > Cc: <stable@vger.kernel.org> # 5.15+
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > Acked-by: Todd Kjos <tkjos@google.com>
> > Link: https://lore.kernel.org/r/20221104231235.348958-1-cmllamas@google.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [cmllamas: renamed alloc->mm since missing e66b77e50522]
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder_alloc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> This is already in the 6.0 queue, is this a different version?
> 
> thanks,
> 
> greg k-h

Oh, please ignore this. It seems Sasha backported the change correctly.
