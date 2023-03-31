Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F86D1637
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCaEMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCaEMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:12:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF611EAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:12:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ja10so20111827plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680235921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fL6uYJqAJu4UWRofGL+uAKGAJCdSLBsLiJ3MZGh5jk=;
        b=e4BTX608wtZj4jZHDmB/1T4Gq8gzXBUP6DMAygN96mFzBhJbH8TFT2/VfRMayOo63G
         lTCJQFkxdohuSxvSyi7wtdj2gzFs7VUaboL5Yk1trxL9GdyiC7tFJelssEv8eqjpqdQG
         YLkdiqsWKS6TtftuVgzjuJki5n6e12uuDQlDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680235921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fL6uYJqAJu4UWRofGL+uAKGAJCdSLBsLiJ3MZGh5jk=;
        b=NwV1xkqA7bATEFiox3hUSIO84fS44OM9icYbiJ+5VwzSYKWlNs5adRd4MGzZqwwWUJ
         acyY59Sxvuk3T+BSGGyyUvXg8leTP327cBo3SA8Gdp2owtHHzLxZMrC4Na5ngwZc/5Gr
         tX3X61zTFRJCYLUodo95KGrHnLXkm+UREx6kD72o5A78ydTQ9GafVOT7eqFUTyowBncD
         5677PeLj15IzYBEjsHt91sO0S1rZ76Ii8Z2qhUN9Rrj4FqBMUSkvRoVIrAtOkAsBHdIi
         66TWN9iXZ4OSiba5Vw7Ccpb4K04Sv8uEinJgkpjm2wmRk8Q4u60ucJnx604cviBPFEv3
         Bqqw==
X-Gm-Message-State: AAQBX9cLx32BXLjojloDs883+zIT54iOI2ptcAFP/J1zI4gTIPmUSK37
        GQUgOyyN7vRsnHzRFk5PyexzHQ==
X-Google-Smtp-Source: AKy350Z3RDbX1XH78O/Mn6Z/g1q+VldEMG0p2DTAFVaet1gIF+cSHwqqrndzG46RRYMeO2Fqm8seLQ==
X-Received: by 2002:a17:90b:3b83:b0:236:a3c2:168a with SMTP id pc3-20020a17090b3b8300b00236a3c2168amr28524828pjb.33.1680235921307;
        Thu, 30 Mar 2023 21:12:01 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902aa4300b0019f2a7f4d16sm506889plr.39.2023.03.30.21.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 21:12:00 -0700 (PDT)
Date:   Fri, 31 Mar 2023 13:11:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, petr.pavlu@suse.com,
        prarit@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, song@kernel.org,
        rppt@kernel.org, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <20230331041154.GC12892@google.com>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
 <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
 <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/30 20:45), Luis Chamberlain wrote:
[..]
> -static DEFINE_SEMAPHORE(console_sem);
> +static DEFINE_MUTEX(console_sem);
>  HLIST_HEAD(console_list);
>  EXPORT_SYMBOL_GPL(console_list);
>  DEFINE_STATIC_SRCU(console_srcu);
> @@ -309,7 +309,7 @@ EXPORT_SYMBOL(console_srcu_read_unlock);
>   * macros instead of functions so that _RET_IP_ contains useful information.
>   */
>  #define down_console_sem() do { \
> -	down(&console_sem);\
> +	mutex_lock(&console_sem);\
>  	mutex_acquire(&console_lock_dep_map, 0, 0, _RET_IP_);\
>  } while (0)
>  
> @@ -324,7 +324,7 @@ static int __down_trylock_console_sem(unsigned long ip)
>  	 * deadlock in printk()->down_trylock_console_sem() otherwise.
>  	 */
>  	printk_safe_enter_irqsave(flags);
> -	lock_failed = down_trylock(&console_sem);
> +	lock_failed = !mutex_trylock(&console_sem);
>  	printk_safe_exit_irqrestore(flags);
>  
>  	if (lock_failed)
> @@ -341,7 +341,7 @@ static void __up_console_sem(unsigned long ip)
>  	mutex_release(&console_lock_dep_map, ip);
>  
>  	printk_safe_enter_irqsave(flags);
> -	up(&console_sem);
> +	mutex_unlock(&console_sem);

mutex_unlock() does not like when its called from IRQ, so this is not
going to work very well.
