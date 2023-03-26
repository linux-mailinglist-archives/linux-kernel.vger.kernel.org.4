Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D26C97A4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCZTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 15:38:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65474696
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:38:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so27641891edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679859521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4UKQ6k6yj5hWcg4z/RhipNHInZBtyGBT7gTdGwQ6ryc=;
        b=qFOYTJgz6vzNJl4fZSOb8yy1eAHwk/MjKRtNfdAAUtFklK1dM9T8pjH1XOQq9yzPAF
         FGHsfz2B/kCybtxOHsSAeJRkQbuPOmyeNv8gLcF2KsFmwfrvM20mIGqn28pgl9TxZs+q
         eNLjyLqKY3+yD/pjYKemHsXVuHSJGOnn4qiDC67ig2bUtrldYKH8Qd/2VDrPCtdFKtWc
         arY6QY2NnSEhM4kyzn1cmML8CDaQ6XciYrdGKUJlY9AEzZQThhtojbCBadPp0QJImUCy
         Pp2fdjumdFRXqwJJujk7JgW/IFmT3QJu94CVSN8uUBGRuG2P2+14c5F//lnPbsFVYvKE
         RbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679859521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UKQ6k6yj5hWcg4z/RhipNHInZBtyGBT7gTdGwQ6ryc=;
        b=bnqV5oXnLvJkA1SiiMW+lpNPBTPXokQMO3PjhT1P7f4vjY00ryBpFJeAK/WCqDUWI9
         BSjkVe7fPqWR2dllpNBZUSikYzP5+RcZRjyWh7Hz38X+kOq130QMpGsNa6GtgiMgFRd+
         hozgMcvB2MW/bqRj+yo8gekWKsqcn97ViPtx9TUDXnXOH11TT/t9bZXILG5OsVmAH2az
         P0shq+qmZTQsYusaCQvFwxVlJvkOGPSQlLfZj4Iq0hRNcMjZgqzKpniOLBW62Ztqpuap
         he8AXvyq+qthEn459r9qyYahtwMCdCep1WXnqs40YpSUbOH6XaSQ6YG/t9WRrrfgZJjr
         rFPg==
X-Gm-Message-State: AAQBX9cWGyRq/Cx2vnldmxDgxsVC5I8K13cPdXN2HLCtcotLMzDNW9gi
        CayAqqx4ucHQeGfksdbM86BFFP8pJg==
X-Google-Smtp-Source: AKy350ZEqBHhJqOEx59+oAVH6/WLAlT03sA1LpzmjkKa7XWuGzOIZrCPe6G/5t7hE53a16IVKXcP4Q==
X-Received: by 2002:a17:906:fe45:b0:944:5e49:a9aa with SMTP id wz5-20020a170906fe4500b009445e49a9aamr2037074ejb.21.1679859521246;
        Sun, 26 Mar 2023 12:38:41 -0700 (PDT)
Received: from p183 ([46.53.253.224])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906198d00b008c16025b318sm13231282ejd.155.2023.03.26.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 12:38:40 -0700 (PDT)
Date:   Sun, 26 Mar 2023 22:38:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
 <ZCCSsFGqTFWknGBL@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCCSsFGqTFWknGBL@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 08:45:04PM +0200, Willy Tarreau wrote:
> On Sun, Mar 26, 2023 at 01:42:35PM -0500, Thomas Weißschuh  wrote:
> > 
> > Mar 26, 2023 13:30:21 Alexey Dobriyan <adobriyan@gmail.com>:
> > 
> > > Willy Tarreau wrote:
> > >> #if defined(__clang__)
> > >> __attribute__((optnone))
> > >> #elif defined(__GNUC__)
> > >> __attribute__((optimize("O0")))
> > >> #endif
> > >> static int smash_stack(void)
> > >> {
> > >>     char buf[100];
> > >>
> > >>     for (size_t i = 0; i < 200; i++)
> > >>         buf[i] = 'P';
> > >>
> > >>     return 1;
> > >> }
> > >
> > > If you want to corrupt the stack, corrupt the stack!
> > 
> > I do!
> > 
> > > asm(
> > > ".globl f\n"
> > > "f:\n"
> > > "movq $0, (%rsp)\n"
> > > "ret\n"
> > > ".type f,@function\n"
> > > ".size f,.-f"
> > > );
> > > > No problems with optimisation levels.
> > 
> > Wouldn't this be architecture-specific?
> 
> Yes it would.

Which is OK. Corrupting return address is very arch-specific.

> I'm not seeing any issue with your approach instead, let's
> keep it as-is for now (also it does what the stack protector is supposed
> to catch anyway).

There are no guarantess about stack layout and dead writes.
The test doesn't corrupt stack reliably, just 99.99% reliably.
