Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA066E0314
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDMARK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDMARI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:17:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5C5FC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:17:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a23so17448926lfk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681345026; x=1683937026;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMGa8zXKBezx3fBG3W9X+LnnaX3zNOMeCplWNdI1ZxY=;
        b=l7R0bLwjv4xry7DasczjBsMk4U0iWw+XKZK7NAwUoySaI0Zt+zDr03pAq57KClKxIH
         XWaFocHDaTAPkUW48DHoPo6+G/35jANvHFZPClICSyV/eSF0leU18CKHVeqmV7CxlsnT
         Tp8BzcsASBrMKjLLMRt8n/MEMpxbkhqzz9xVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345026; x=1683937026;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMGa8zXKBezx3fBG3W9X+LnnaX3zNOMeCplWNdI1ZxY=;
        b=RnELvPhOXRWQMineWAnXfLwDfJt4MYayD5dDmyb2egZo5mYbM/D7X5WXBeOsD2HbXU
         cofDPU3hOpUP/2Af0HrCX5w1Uh/35Em+xpfn6B84allxBsDQsLoBRVtULJPu7k7AXurt
         zR4xuYA5a1l6NVRPOjeJPScPTVUtKiYvyet1Jqy5NUvFMLwzSLbJHJm4DWrFzCk1/yEs
         zypjh3KWtAsrnmKASasEzMV4FSV65UbLZnadtdQNmnAurTZbyuVZQXXmyk1F+TznRqRo
         VXeUhdnUs2nNZLKW92uHcJ4rNewNe+bKoAT2OScHnZOD4NFxFhkuk+mPI8HyecIvJZKN
         unwg==
X-Gm-Message-State: AAQBX9d40OsCrcvyX8OvnvIuETTxjEdUKU3gqNU89051ZP4f9ltB61Hv
        iQwIvWZn5W1RG7onbJ4gFu8nMHwRBqWOYzX5VpTkdg==
X-Google-Smtp-Source: AKy350ZtYasfPWSv+t0AeQE/UXKOz2ar8HNBS5S45Joc+cwliVFb85YHCsQM6TSXYmfFOOis6xLzydCyB0tdTr5oYFw=
X-Received: by 2002:ac2:485b:0:b0:4eb:982:ad5 with SMTP id 27-20020ac2485b000000b004eb09820ad5mr224616lfy.4.1681345025692;
 Wed, 12 Apr 2023 17:17:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Apr 2023 17:17:05 -0700
MIME-Version: 1.0
In-Reply-To: <87zg7dzgao.ffs@tglx>
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx> <87pm908xvu.ffs@tglx> <87zg7dzgao.ffs@tglx>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 12 Apr 2023 17:17:05 -0700
Message-ID: <CAE-0n53hCtzhFN+XdYVqXVzhpciLBubYhDu7-wXEZLVu3xmXNQ@mail.gmail.com>
Subject: Re: [PATCH] debugobject: Prevent init race with static objects
To:     Schspa Shi <schspa@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc:     longman@redhat.com, linux@roeck-us.net, wuchi.zero@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2023-04-12 00:54:39)
> Statically initialized objects are usually not initialized via the init()
> function of the subsystem. They are special cased and the subsystem
[...]
>
> Rework the code so that the lookup, the static object check and the
> tracking object association happens atomically under the hash bucket
> lock. This prevents the issue completely as all callers are serialized on
> the hash bucket lock and therefore cannot observe inconsistent state.
>
> Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
> Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
> Debugged-by: Schspa Shi <schspa@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://syzkaller.appspot.com/bug?id=22c8a5938eab640d1c6bcc0e3dc7be519d878462
> Link: https://lore.kernel.org/lkml/20230303161906.831686-1-schspa@gmail.com
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Tiny nitpick below

>
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -698,24 +723,16 @@ int debug_object_activate(void *addr, co
>
>         raw_spin_unlock_irqrestore(&db->lock, flags);
>
> -       /*
> -        * We are here when a static object is activated. We
> -        * let the type specific code confirm whether this is
> -        * true or not. if true, we just make sure that the
> -        * static object is tracked in the object tracker. If
> -        * not, this must be a bug, so we try to fix it up.
> -        */
> -       if (descr->is_static_object && descr->is_static_object(addr)) {
> -               /* track this static object */
> -               debug_object_init(addr, descr);
> -               debug_object_activate(addr, descr);
> -       } else {
> -               debug_print_object(&o, "activate");
> -               ret = debug_object_fixup(descr->fixup_activate, addr,
> -                                       ODEBUG_STATE_NOTAVAILABLE);
> -               return ret ? 0 : -EINVAL;
> +       /* If NULL the allocaction has hit OOM */

s/allocaction/allocation/

Or is this "alloc action"? Or should it be "lookup_object_or_alloc() has
hit OOM"?

> +       if (!obj) {
> +               debug_objects_oom();
> +               return 0;
>         }
> -       return 0;
> +
> +       /* Object is neither static nor tracked. It's not initialized */
> +       debug_print_object(&o, "activate");
> +       ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
> +       return ret ? 0 : -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(debug_object_activate);
>
> @@ -879,31 +897,20 @@ void debug_object_assert_init(void *addr
>         db = get_bucket((unsigned long) addr);
>
>         raw_spin_lock_irqsave(&db->lock, flags);
> +       obj = lookup_object_or_alloc(addr, db, descr, false, true);
> +       raw_spin_unlock_irqrestore(&db->lock, flags);
> +       if (likely(!IS_ERR_OR_NULL(obj)))
> +               return;
>
> -       obj = lookup_object(addr, db);
> +       /* If NULL the allocaction has hit OOM */

Same comment.
