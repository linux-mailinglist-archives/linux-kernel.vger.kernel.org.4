Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3B6A2E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBZGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBZGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:47:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCCF10A93
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 22:47:32 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d7so3609486qtr.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 22:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBZFZq3Oq5B/sjhHm5mCKbT3pc099zsCp9+1MZ3rYBU=;
        b=51gUnH1IcQLgB4jswn/INIDwy8MekCPZJGi7Hc7nhRKZFzaKfj+KIOEnexlgnzbFqC
         oDxaQPPXaAMQpr4Utk1O/uOelsusibXzZ28VMwUgARpYCKoxGknIHFo3JDu051GEHCrL
         yJO1hehKIYqI8zddScpccT18ZY8HX0qqqJw7SlEVar/Z0VoDl13MRYKNIjSC3lH6VifY
         5gl4kj0wPGTB5XDc2KVbtZrGtVrcIjleFeHYmd9p8RrhVoiMGe4gNgDKZCBgHc08Rt3W
         sJTzoU4rg+l9GDMGnlsfDT+kJm+gRt96Ft5P4RHNpHqj0ldZFB0mZ7Jk+Y6jbM+aBmI1
         fYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBZFZq3Oq5B/sjhHm5mCKbT3pc099zsCp9+1MZ3rYBU=;
        b=Sh771sY1JM4M+apIix+rsfZhWTGM4RF20YBjkxK2fW6aSSk2JIul/S6xNq8kDeFVxB
         w9gDTSbP03qXz4gCKsof6kctkq3ddAOUWFsQpbeuedXJLp3f+ZzpiNBDRDJIrb3JdM9k
         ZI/BwqXR0kp+yMA/pFZg/GUvRdyPvzM2X0YBGN8aHpUUPmuf+S4hXowiKU21zRK0J519
         foiWoOdFvCayTInj+tBpv/+wY6sfA2TvIq37MjsMMhHBiF7UHjfNrnZNGdZRRcskQ4cM
         0hn6RYJN77zfdat+UGDQiW5brv1lDFjYwAjwPeAPBYNZKVjvE5QldUH/oLR10ojqo7Xs
         cKOw==
X-Gm-Message-State: AO0yUKWuIl5WL7NDxgfBR5xqixzTtZ3NbyI1Wu/3Zudc6rsePCF6XpJq
        cJh1dcyvZPJpKSIXNG3caK3zQw==
X-Google-Smtp-Source: AK7set9ZnqIcTa/5lFOP+RzYXWYgihu0hptVh8t4jfuyqWdqzt53cKDAn3x5W9oZtg7ok7vI44OlNg==
X-Received: by 2002:a05:622a:491:b0:3b9:bb27:e116 with SMTP id p17-20020a05622a049100b003b9bb27e116mr31100037qtx.1.1677394051483;
        Sat, 25 Feb 2023 22:47:31 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id e10-20020ac8130a000000b003b63a734434sm2518639qtj.52.2023.02.25.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 22:47:30 -0800 (PST)
Date:   Sun, 26 Feb 2023 00:47:19 -0600
From:   Glenn Washburn <development@efficientek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-ID: <20230226004503.1856e58d@crass-HP-ZBook-15-G2>
In-Reply-To: <20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
References: <cover.1676532759.git.development@efficientek.com>
        <20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
Reply-To: development@efficientek.com
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 13:14:02 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 17 Feb 2023 19:11:52 -0600 Glenn Washburn
> <development@efficientek.com> wrote:
> 
> > Added suggestions from Jan.
> > 
> > Glenn
> > 
> > Glenn Washburn (2):
> >   scripts/gdb: Correct indentation in get_current_task
> >   scripts/gdb: Support getting current task struct in UML
> > 
> 
> For some reason I get a bunch of rejects when applying these on top of
> the latest patchpile.  Please check my end result:

It looks like there was a change from v6.2-rc8 to v6.2 that caused a
conflict.

> 
> def get_current_task(cpu):
>     task_ptr_type = task_type.get_type().pointer()
> 
>     if utils.is_target_arch("x86"):
>         if gdb.lookup_global_symbol("cpu_tasks"):
>             # This is a UML kernel, which stores the current task
>             # differently than other x86 sub architectures
>             var_ptr = gdb.parse_and_eval("(struct task_struct
> *)cpu_tasks[0].task") return var_ptr.dereference()

This is missing the return statement in the second patch.

>         else:
>             var_ptr = gdb.parse_and_eval("&current_task")

It looks like "current_task" has now been changed to
"pcpu_hot.current_task" in v6.2.

Would you like me to resent the series rebased onto v6.2?

Glenn

>             return per_cpu(var_ptr, cpu).dereference()
>     elif utils.is_target_arch("aarch64"):
>         current_task_addr = gdb.parse_and_eval("$SP_EL0")
>         if((current_task_addr >> 63) != 0):
>             current_task = current_task_addr.cast(task_ptr_type)
>             return current_task.dereference()
>         else:
>             raise gdb.GdbError("Sorry, obtaining the current task is
> not allowed " "while running in userspace(EL0)")
>     else:
>         raise gdb.GdbError("Sorry, obtaining the current task is not
> yet " "supported with this arch")
> 
> 
> 
