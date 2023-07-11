Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFC74E287
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGKAZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKAZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:25:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01DFB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:25:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3669197a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689035143; x=1691627143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phtS90SFWoSB2M/4/0tBAboFQka70onYYgDuF8Bnzxc=;
        b=H2lFKBB4nwZykWf0S6hXoh87mX9BBwJym1C/L2D29S/MCmY0+k5ss2gWud7lsrybyE
         92SMnd4c0fCXGYKHvgla6sUD2I02yhzxAQvmTYC1hdddf+f0Bd517tq8mWCf14elW2RR
         S+vgMUHkpRTtel8PwB6cQfvwWpK8+tkhTcn1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689035143; x=1691627143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phtS90SFWoSB2M/4/0tBAboFQka70onYYgDuF8Bnzxc=;
        b=BaomTKVcXl11T4/Bw5FSHAk6Xprn4HxyW8NRssxyb2GbHD5oCDybdwCpcHzPVt41wp
         RVSh3cqhyYt/kF2gXWVYxLE9KzZQpDooR0O0uc8PdKsTv7ukIriEZDqUff5YNf1OSW05
         RwN2cnJxUGPkGbkRhbMWZR5G3cinMjQWY4fME0F5YO+4rJjTRH68iegg6jHtlJesMHCA
         qDDBOZAQg3HaBx+BSUx04sLDMXChImel7GZn1iWCkWlMt6CnI8zdJYOmv9+i8Ucydpvb
         QaqsL3dlxFKsScLvcjXFtC8FvPydZQptyO9pIwn0MkaZ8pFuBrphdnYjmtvJ6Lfez1gO
         FZtA==
X-Gm-Message-State: ABy/qLbfmbB61putUG2P7x9jXeg3+eEKo5ccbXvtmFbgFuuquvlETxE0
        0LAy3FstTU2s4cnlyprZrKwwxA==
X-Google-Smtp-Source: APBJJlGnxY+Ezvu3CVg1U9VOEkXTc8+APWIirtT10F0f2AlwlxWArmvh7pZuOsXVcyePjoA6TVrVuQ==
X-Received: by 2002:a17:903:48a:b0:1b8:72e2:9c4 with SMTP id jj10-20020a170903048a00b001b872e209c4mr13853651plb.60.1689035143415;
        Mon, 10 Jul 2023 17:25:43 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001b88af04175sm480789plz.41.2023.07.10.17.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:25:43 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:25:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v2 1/5] kdb: do not assume write() callback
 available
Message-ID: <20230711002536.GB12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/10 15:51), John Ogness wrote:
> It is allowed for consoles to provide no write() callback. For
> example ttynull does this.
> 
> Check if a write() callback is available before using it.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
