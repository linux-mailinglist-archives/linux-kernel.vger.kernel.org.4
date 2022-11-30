Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39D63DABE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiK3Qfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiK3Qfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:35:48 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C247BFAF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:35:46 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id cg5so11481280qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlGYTTmeO0EUox22y7jt3qfj33sZxc4kBIXv9Hio3X4=;
        b=Ta+9ZV6veBLcewaLVaKLLBPK1EYk5skvb7SppnWat36NhrXRkK8XZqdyS8ZmJMXDPW
         iGLpTyJcEbORvx+xbvgV0gI0bhrFAs9Z/t4z4QRxlau40yDqCSL5eQryVQ5lTTcXkMTP
         t18xpMEzzrwo8aT86whoaUEqlwM5zAkXOAYFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlGYTTmeO0EUox22y7jt3qfj33sZxc4kBIXv9Hio3X4=;
        b=GUY7HQtM2/ikk3fpyyyaqu1TlFQjDiQMwQj9+QYDHX+IJbuTU5vWBUVQ63263DQrKH
         FnUCw52QL7PmV1Fyfh04oFJSn3MgTD8TQAoPyGHBhPWRQ4rhLIGUV2NYtUFXc21qvEIc
         K/G/mpgp1zXCgXSF0AmSyYCBeA0mhiJDEKwGyjLiiU9qmYeI1q4ApeTnjC0dTxB6Hq4W
         1RLjtkr0Pw8ZfhuwCY5VCOxpbERfOOscFYgaoEO7Z79NOtzn49icrhSmT3I5ry/xbbKh
         gyjNLHcmzJYv4Frql04fh0ThWNBih7YNHup0vmcyZZpjok2x3YViY/PApTpJSMJCCLgY
         jXZg==
X-Gm-Message-State: ANoB5pm7DSwds1yO1TXxAkD5HOZ+YcNE5Dm7qnca28cpaewVn5aWs/KR
        7u3UsRAnClzld5diYtImQ+e+fJzG/s3ptQ==
X-Google-Smtp-Source: AA0mqf6C4xGMVr8qzi8rYbyfAHiVm8AUcGPRWydmfx6wa+uA9CSOF4aYOlY5t94LwKQZcagffYoJ9A==
X-Received: by 2002:ac8:74c5:0:b0:3a5:2bd0:67a4 with SMTP id j5-20020ac874c5000000b003a52bd067a4mr57379595qtr.428.1669826145549;
        Wed, 30 Nov 2022 08:35:45 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id bt12-20020ac8690c000000b003a51e6b6c95sm1116292qtb.14.2022.11.30.08.35.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:35:45 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id w4so11525160qts.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:35:45 -0800 (PST)
X-Received: by 2002:a37:2c45:0:b0:6fc:a3eb:b504 with SMTP id
 s66-20020a372c45000000b006fca3ebb504mr115076qkh.216.1669826134401; Wed, 30
 Nov 2022 08:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-2-tj@kernel.org>
In-Reply-To: <20221130082313.3241517-2-tj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Nov 2022 08:35:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8wvB4vo-PaCSMSRaCd2c+rk8OnE72eF+skDVMdk9LsA@mail.gmail.com>
Message-ID: <CAHk-=wg8wvB4vo-PaCSMSRaCd2c+rk8OnE72eF+skDVMdk9LsA@mail.gmail.com>
Subject: Re: [PATCH 01/31] rhashtable: Allow rhashtable to be used from
 irq-safe contexts
To:     Tejun Heo <tj@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:23 AM Tejun Heo <tj@kernel.org> wrote:
>
>
>  static inline void rht_lock(struct bucket_table *tbl,
> -                           struct rhash_lock_head __rcu **bkt)
> +                           struct rhash_lock_head __rcu **bkt,
> +                           unsigned long *flags)

I guess it doesn't matter as long as this actually gets inlined, but
wouldn't it be better to have

   flags = rht_lock(..);
   ...
   rht_unlock(.., flags);

as the calling convention? Rather than passing a pointer to the stack around.

That's what the native _raw_spin_lock_irqsave() interface is (even if
"spin_lock_irqsave()" itself for historical reasons uses that inline
asm-like "pass argument by reference *without* using a pointer")

And gaah, we should have made 'flags' be a real type long ago, but I
guess 'unsigned long' is too ingrained and traditional to change that
now.

              Linus
