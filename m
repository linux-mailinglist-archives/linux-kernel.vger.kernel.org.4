Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB461E69B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKFVkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKFVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:40:06 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11999BC2E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:40:03 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h21so6046405qtu.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo7D366kVu3SrxVktqc4LKs9aaH2aa4rKZe1IVS8u5g=;
        b=XrOkgpqMp7xklkIuOQGXPfnegAeupS9fT7UqiULwzWkt1SZH1EWCX0L9blgprAbOZP
         VqYp/LdCrgDCTxGuXTWnOS7D76lxAOdGLEt8uMZGamb6BJHN3trSdQA5niB53Te6649w
         F+Tl8iQ6hT/YK5fST/drg5X1DY39YkJ1syHPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo7D366kVu3SrxVktqc4LKs9aaH2aa4rKZe1IVS8u5g=;
        b=UeYNfGIPEi4HrivbFAGjMFDJ8gxv99uem2yv1NDtcjIZaPzMmx39x9eSJnZ11oWJm3
         knVa+zESVzsJqhSLpCo1gxQwj7Ph3s6ds5tmTjBTCLMHC8snb3lhiY/rIeSyJc52ReOv
         0PnzruYvSTkTFmJKozh7FL5PybWKdPgSjdcC1hZcic/GGbHN0nbP3d2F8w0OXSEWgv+c
         +//HrlY0blHcc2uptgep3i3NdgWC62KdXhMgL7qQ4xQq8ZeH+KKmCoqsa1+jDxz9EpKV
         ZRY3GczM7ulLOiEZeeXRu96cEcLA5kp3agQlTFFEP2W6fJVLIK+KzG5WHq765W2I8e5F
         FfEw==
X-Gm-Message-State: ACrzQf0MUqJ6kH5ldWJZFVnlfatQxqIHtQHCpM9llsOacSh4AyXCNOcl
        4t81saJoQzbHp89JvMdJqiy2a+hpyonveA==
X-Google-Smtp-Source: AMsMyM5m2EAXAMqXi4YW/ygYGScLSYbt2tqkmGzSZRz3buLaVKIhoJbxZ004/RQNjKb7SJLhT6O9cQ==
X-Received: by 2002:ac8:5b03:0:b0:3a5:a44:8dfd with SMTP id m3-20020ac85b03000000b003a50a448dfdmr37479368qtw.497.1667770801868;
        Sun, 06 Nov 2022 13:40:01 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006bb29d932e1sm53064qkb.105.2022.11.06.13.40.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 13:40:01 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id r3so11609432yba.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 13:40:01 -0800 (PST)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr42703657ybu.101.1667770800966; Sun, 06
 Nov 2022 13:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20221106054535.709068702@goodmis.org> <20221106054649.099333291@goodmis.org>
 <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com> <20221106160956.2414d73f@rorschach.local.home>
In-Reply-To: <20221106160956.2414d73f@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 13:39:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
Message-ID: <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to timer_shutdown*()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
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

On Sun, Nov 6, 2022 at 1:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>   ... when strict
>       when != ptr->timer.function = E;

.. and I tried this with just 'ptr->timer', and it doesn't seem to
make any difference, so apparently that NULL pointer initialization
was the only case.

And then - like you and Guenter - I went through the patch manually to
look for anything that looked odd, and didn't find anything.

So yes, I'm happy with this. It looks like a very reasonable "let's
handle the scripted trivial cases automatically", and then anything
more complicated can be left for 6.2.

And with that cocci script (and how to run it), people can see what
the script was, and even run it themselves to verify, and that just
makes me feel all warm and fuzzy about it.

                 Linus
