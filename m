Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338B35EEE47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiI2HCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiI2HCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:02:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A413070D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:01:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sd10so869738ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=zmbXriehZST5wK7cmCdFWN0bk9XDgfhPqDEbpKUatxo=;
        b=ZvnRW41heHvp1qflvb4jaTE5Eh8nioSgNqdXM9UsRMpnjyBwWr22BqJUV8vVSnOHZT
         TJOZpIcbcXSQnEYfd4BKEYPMHiiykHi+A+SAItusOcqZmoWyCFLz4/zDmQyb6lZRmSZm
         FDiwt9A/kcS4rIe+ftqEVx+AW13N25NYDX0HDBYCrlvQDqTg/aL/nt4jRVzTO97xFv7U
         3NR20zYi732g0WDuqDhoWQulZ9l9BXpK7bwYeX53hodsvve/7XxaxBv+0pRXMfXt2/gI
         na9RX8IhpMGvOy3w90bQc1uJb9u46ZlomYdy7h/MXzFXkmYX36PDswKgLqAF2siWzncD
         N6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zmbXriehZST5wK7cmCdFWN0bk9XDgfhPqDEbpKUatxo=;
        b=vD6aHlQXX2VL3XopfGlJJp3xoPbv8n47FgYl2OsLzppo0m7SnFL32PW/WXn+fMniAu
         lXIlUI7IE5KY75junw7cTraofKPHqWvj5u/52saNOrh1xI1db1y/nWC62vUVOi/G46j2
         /eN8amC5qpsm6RjqzGk8Aq6hV34u+/hdYe51rIxBDQTvV4fx9zMdT4tGwLP56qs1KjJH
         1/gtWhVJ9B5uKgiS9mxZtzWLZG4CYkvh4xhby0paBpOQa8m0gsHxIDkOXe3amPOnSEcv
         mqQ9laWrtX/G3ZF4cBjEDAxeyCGOISCD0K0EOfR2cJsZjgCER6UNJ3FOOL7afH/bnahp
         9arQ==
X-Gm-Message-State: ACrzQf3AlMAu3r1ykI3QLpVZwJl25tS3xT2+vB4CZqxqt/UawoF3qDem
        S5wsa02iiXa+zGboaMR2iZ8=
X-Google-Smtp-Source: AMsMyM72qWqN0KZKw1TyeWCmIHQCia3M4te2pOb6a0X8GypGreFfLajwwHWvlR/edZ0F1ZG3WVZQ5A==
X-Received: by 2002:a17:906:794f:b0:781:dbee:4256 with SMTP id l15-20020a170906794f00b00781dbee4256mr1497560ejo.404.1664434909897;
        Thu, 29 Sep 2022 00:01:49 -0700 (PDT)
Received: from gmail.com (1F2EF01B.nat.pool.telekom.hu. [31.46.240.27])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906539700b00738795e7d9bsm3443108ejo.2.2022.09.29.00.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:01:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 29 Sep 2022 09:01:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4] x86, mem: move memmove to out of line assembler
Message-ID: <YzVC2p+RLDcnlC3a@gmail.com>
References: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
 <20220928210512.642594-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928210512.642594-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> +	/* Test a backwards overlapping memmove first. 256 and 1024 are
> +	 * important for i386 to use rep movsl.
> +	 */

Nit, please use the customary (multi-line) comment style:

  /*
   * Comment .....
   * ...... goes here.
   */

specified in Documentation/CodingStyle.

Thanks,

        Ingo
