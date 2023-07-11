Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFF74F35D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjGKP05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGKP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:26:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CBB0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:26:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8a462e0b0so29453095ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689089211; x=1691681211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vs4qA8EHKpWrrs724/r+Ntyl1sy3Sa4BdLzmqxrmols=;
        b=Oe9lje1D0rqWFzPwSnelUVe3EulKewL6USIFHlyNLpVDRm03xIy3x5kVvmDrE3awyN
         En1wldO5rRyYJU9mL82ylS4fMvP0JSGytZig6o3rBSd43cVCYgE9tX3E0+L1laMHZ4Ed
         n8w3HrMXHzp01JhuuOaNk8a/c9sCxDZ+E+hOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089211; x=1691681211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs4qA8EHKpWrrs724/r+Ntyl1sy3Sa4BdLzmqxrmols=;
        b=ia0XUr6afAvL+YgvByzie+LoTUxPNqI6U9VsA2y1Cl1jfNl9QqnjcHx3T8S+sO0VUN
         JTIUzfA3FdtMIBJ2MWDk4pm5RjMfKS5zBOt0TskYKjS204qYjp1UemNfspgUg0ql+4b2
         t45m/isxid/4nb8QlLNTAImvD599KJSZ/y1Nsbigxry+hnLgK/g55HH/KvF5QI1/1z6m
         XnLS4t7ODYt2xDS/x2KZr6NXNsu3eaqDLQhpq64Ze9LxoaA5jpg5c0uxYdL+Y6tWh6G3
         qwT4011yL3acGSlE1E+wBwG4dWD5fQlzITt/DjpSPxbnYAF2dgRyTH0Dv9tUh082NiCi
         EQrQ==
X-Gm-Message-State: ABy/qLZ3f/ryKny3LqjXVTQ01XnvBGpA5JIw/9hT+QkIW4LIK70h3qbP
        if6vD3DAVyBhOWaKYY//A3K16grFGuXek2oG2N2AGA==
X-Google-Smtp-Source: APBJJlF9Bn3YNONWVUnPV20vseWsS69TIT86ItagXDgIoRXJWAFxixwuI8gN1sZQSR/23UTuo+mb3w==
X-Received: by 2002:a17:903:110d:b0:1b3:d6c8:7008 with SMTP id n13-20020a170903110d00b001b3d6c87008mr15600700plh.57.1689089211394;
        Tue, 11 Jul 2023 08:26:51 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001b8062c1db3sm2064950pll.82.2023.07.11.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:26:51 -0700 (PDT)
Date:   Wed, 12 Jul 2023 00:26:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/5] printk: Add per-console suspended state
Message-ID: <20230711152646.GE12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-5-john.ogness@linutronix.de>
 <20230711150819.GC12154@google.com>
 <877cr6pj40.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cr6pj40.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/11 17:29), John Ogness wrote:
[..]
> > Interesting. console_locked previously would not be set if
> > console is suspended, but now it's always set, which in theory
> > changes the way WARN_CONSOLE_UNLOCKED() macro works in some
> > cases?
> 
> Yes, Petr mentioned [0] this during the v1 review. His direct comment:
> 
>   "console_locked" seems to be used only in WARN_CONSOLE_UNLOCKED().
>   I could imagine a corner case where, for example, "vt" code does
>   not print the warning because it works as it works. But it does
>   not make much sense. IMHO, such a code should get fixed. And it
>   is just a warning after all.
> 
> And his final comment in that thread:
> 
>   I believe that @console_suspended is not longer needed.
>   Let's replace it with the per-console flag and do not worry
>   about races.

Oh, thanks for the pointers!

> [0] https://lore.kernel.org/lkml/ZAieQtcs7YEuCCDa@alley
