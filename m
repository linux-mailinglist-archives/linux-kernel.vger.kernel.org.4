Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC95E8AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiIXJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiIXJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:31:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0AE6DCC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:31:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2353558pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ap8HLLGn4DzoVPJQkiP9TLAFfA/XSqaqZJCMd1CXIUY=;
        b=EN4DIZ0VBUazYKX6uD/RpmQ6koSVqAbwc17Xe1qpx38st2H0qNoGKoaLUlTRC2Hh/5
         +l6BAuV+4E9BWrbUyb830iH8xTaPWiWvyzBZI2Jsw3YpKBqG1AbLCzScYcPCf3vwOOhV
         DBB9IjYyC8XAtI74riFLsKBfZEBOS1RBn+fqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ap8HLLGn4DzoVPJQkiP9TLAFfA/XSqaqZJCMd1CXIUY=;
        b=RGvTJjYXarA8pziVDIj4bI19TL3HugYrfoPS709a4D23cXjypdNDEMMzCvcLZpTWKz
         r6+mV/dU/cj1r0RXjNQUaSoU6eBCzBJ8fzyMolSYw4oW51VtKv2/KNqBIrQgPVjNuB3i
         NO0e2HAddPfsVxsZ5TdGEYn8cyn/otwlTiO6VW3DwxexIXN9eyAmeYEB1qApmNjcottm
         ibbiGN0jsuQ/NhD2BMVhgOhJoftmM5j7Cy7lRcN8AZQtUOU3mXH1VHeRE3JdHBbJVAUj
         F8YP/JhQeTT/cmEKnDjfo2f8qy7a6vyr48coC8Hw+Vbqf62Su0ktqxjm/CjRKAXFzilv
         xxJQ==
X-Gm-Message-State: ACrzQf2kDDCrnlNTtf4jEjUWK4aEXGCUCeTCTpogKKxBdxCkCtcwEqPW
        Hj9JzMKK1jsgOe2Nmft/NsCYnyossz/Tag==
X-Google-Smtp-Source: AMsMyM6rY0XFdck/BlXnACF5pLvQCTA9V726PYXfF/UGz5iMR17bGyW1RyAh5J5PUDWP7g7zfLBWZg==
X-Received: by 2002:a17:90a:bf18:b0:200:8a12:d7ad with SMTP id c24-20020a17090abf1800b002008a12d7admr13787822pjs.243.1664011909480;
        Sat, 24 Sep 2022 02:31:49 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c20900b00174f7d10a03sm7505874pll.86.2022.09.24.02.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:31:48 -0700 (PDT)
Date:   Sat, 24 Sep 2022 18:31:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <Yy7OfxGA//d8QYpe@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Unprotected list walks are a brilliant idea. Especially in the context of
> hotpluggable consoles.
> 
> The new list lock provides not only synchronization for console list
> manipulation, but also for manipulation of console->flags:
> 
>     console_list_lock();
>     console_lock();
> 
>     /* may now manipulate the console list and/or console->flags */
> 
>     console_unlock();
>     console_list_unlock();
> 
> Therefore it is safe to iterate the console list and read console->flags
> if holding either the console lock or the console list lock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
