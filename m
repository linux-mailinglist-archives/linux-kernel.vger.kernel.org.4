Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF046E74ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjDSIXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDSIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:23:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04510C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:23:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso313540pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681892597; x=1684484597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6hFHF3IcTDLVheKKyBUV7C7b09MgZYgxLvM8wBv5qs=;
        b=cRWnlV2fIPKoqXwKFzH+i5PoWuAARW0gW3z1zeni66pW9d+fuG/hOcgAssF7lHI/g/
         /0heBguoLOVl8Apjdr129hJIZkvj73jv95xNstnW0YhleQ21voNagAyPUfQ5vm3cNSWm
         69KnB9X0GmtLOlAbeSNU088VyRu38Dxbiwprw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892597; x=1684484597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6hFHF3IcTDLVheKKyBUV7C7b09MgZYgxLvM8wBv5qs=;
        b=DYPRWsk0VxC98D84V7pld31YY3JLNd4Z1K34CqeHNK0dC3+GPbqri7iM8kdNoVZR1k
         TT8VJur5snuT570ZQxbFw2lX/9doGLnJGzAO5z7LIhtzzHKLM/4lWIF28wqKu9wcJCiS
         CelgSboVrSwwtZvU9l/hKST1HpRCEKO6DvTfoplr/XDiotx/S1DhME0z1aZAbW82LzLT
         UHzU6zcKsRujt6fjickIRC5BJVeTZy4hzYzFJBNNGRV14bFRBY3/a9DIt5BsksS4WoxJ
         00THIH13/O/1y67Sk+uVohwE+lK79LddPe1+97IAZOflzKaS5bm//S/6I83rB2taBGOy
         qU8A==
X-Gm-Message-State: AAQBX9fkQYaC/1QOBJoYoox353rHfT+DwtzHNWxMfMZMccaN/32n8Xrb
        0GQ+BBua/7bAig/EmkI3ZJFfbw==
X-Google-Smtp-Source: AKy350bK+/P9kuFplf+T1KwZ7QkQTpqwK+HMdf8RJ0nK0P2Cb0rsh0U86E8r/rzlofaXE3UiDVHLew==
X-Received: by 2002:a05:6a20:6a1a:b0:c7:5cb6:2ff7 with SMTP id p26-20020a056a206a1a00b000c75cb62ff7mr3021208pzk.22.1681892597086;
        Wed, 19 Apr 2023 01:23:17 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id b33-20020a630c21000000b004fbd91d9716sm9675797pgl.15.2023.04.19.01.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:23:16 -0700 (PDT)
Date:   Wed, 19 Apr 2023 17:23:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
Message-ID: <20230419082311.GA1496740@google.com>
References: <20230419074210.17646-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419074210.17646-1-pmladek@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/19 09:42), Petr Mladek wrote:
> The comment above printk_deferred_enter()/exit() definition claims
> that it can be used only when interrupts are disabled.
> 
> It was required by the original printk_safe_log_store() implementation.
> The code provided lockless synchronization between a single writer and
> a single reader. The interrupt and the normal context shared the same
> buffer.
> 
> The commit 93d102f094be ("printk: remove safe buffers") removed
> these temporary buffers. Instead, the messages are stored directly into
> the new global lockless buffer which supports multiple parallel writers.
> 
> As a result, it is safe to interrupt one writer now. The preemption still
> has to be disabled because the deferred context is CPU specific.
> 
> Fixes: 93d102f094be ("printk: remove safe buffers")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Looks good to me

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
