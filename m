Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192D76A46AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjB0QE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjB0QEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:04:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE9233D6;
        Mon, 27 Feb 2023 08:04:18 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t22so5539472oiw.12;
        Mon, 27 Feb 2023 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg8vuwxyxMrPQjar45V1HfclOoi0YISeIydy8F+02pg=;
        b=PHZGIMLjEWdWxQXoKvIzrFieKCvHIlMf9WKIVbZyIByHx5nQJcEbDh3SUyS5m58+UY
         +40Getm3YSyn+XENp0PUdjeb1DInKU4iQG9XUoatZWBJa7NGHeOKj23jCImM6/dvyu2g
         V3IXa8v74GCSMj1s2UGawPBcrq1gA87koDsMU/DIN6YPTcx68W/ujkV9nsGpuELGtedH
         EZrbh9EcMYpZkTNj6Aa6X6tt3cs/w6XJmv9EMEijGRhgYhMfDBKoVpA8jFoDZTL+Zncd
         DpUfOdIuE0Wg45+dmnlKw3gWbqJKvst+fkfRqAaachlgAcMG9o83hmIfRnmAhgWIXHMt
         Z6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qg8vuwxyxMrPQjar45V1HfclOoi0YISeIydy8F+02pg=;
        b=MKx5WeCg35THPkxDrZbQvY9Hhy1rPAoJCnhtz0qwhNsCIS7AoEZ0p+S0fZGyN4clM1
         zUv+kUnKp/btnVI2OuXjgnN8msmpWzmeBBmAqchXszpkReulFDmlaOpwZVPJT4TOFFZU
         fTqjQyvy7YraHaYf0vpnT0Je42ZYbEzgu9RWSthLQUBtu0AxdxvPprxVxTViWgwzJjK5
         1jlkMkHCB64nd2RTyT6yyDCkpeaGG7aEKEZAkGQX1kphxswdVVlu2w2W6/wcE1hDfLWQ
         S7WOUhiNfo4uUaiWgcJKHaJ9JMVxgNGKudsT15aUVYkD+U9QKz7/IILPY2TY1+e/hUSP
         P2IQ==
X-Gm-Message-State: AO0yUKXZxZoxrQ6rFVL/VaM5cEmBx70ToNk0xWBpQ3r711vNvfDVOMxN
        ZEV/pBMGie7aGNEoCCNXBoZIvJtgedCO9Kwv+xM=
X-Google-Smtp-Source: AK7set802gM1M5X29uiBUkLSilay5VZBp6Sj5f6yDBgCgaQqNEdzU7nNPqzUNkbZTxsxNQAc++SQeTd7wmNR/upbkKc=
X-Received: by 2002:a05:6808:30b:b0:384:2fd0:e1cc with SMTP id
 i11-20020a056808030b00b003842fd0e1ccmr1037408oie.5.1677513857756; Mon, 27 Feb
 2023 08:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20230224233126.1936-1-gregory.price@memverge.com>
 <20230224233126.1936-3-gregory.price@memverge.com> <CAJwJo6YnELNhU8RmR-z37vDZ=xb0CmUUBgrPGgHP2dqjVm=O2g@mail.gmail.com>
In-Reply-To: <CAJwJo6YnELNhU8RmR-z37vDZ=xb0CmUUBgrPGgHP2dqjVm=O2g@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 27 Feb 2023 16:04:05 +0000
Message-ID: <CAJwJo6a9NF=o+ON04t5uFThNfDypBE-QUg=7A8jNrTuTcZEEew@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 16:02, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> Hi Gragory,

s/Gragory/Gregory/
Sorry, a typo!

-- 
             Dmitry
