Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6F67FA76
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjA1TcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjA1TcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:32:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA225285
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:32:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s3so7554627edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cC5LWwkS5oHHU3J7uBpKKLwM/6KMxzZpM0d2JkhtNMI=;
        b=C49QyXZ2n2/zYAQxrfKH9Pncw2x8nq6dVONERsstLdU63OGnldPXCyROd6Lkf8r79g
         jjvi6xIq/05bsRfkW3D9+S8V1z/IR6O5+qdO4BbSWfDpz3OWQoko8/qQZNfUbntdy6N3
         ZrYi2TjEjmdT7zkICJ7e/xdbFD6stZs6J1gHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC5LWwkS5oHHU3J7uBpKKLwM/6KMxzZpM0d2JkhtNMI=;
        b=4ODOdz8qa5ODNBrXkLIo7jtqu1GiLHqG836ZCj8+KOjVKTCYrDPwDVEiDlyfSQ2war
         YYoRcrKPALCygAdpFnhQ5+al/t/b1Li/nMNNAJ7jG1qdz9dRixmDK6SQikTz4CGQezJ3
         l2te5TG7GhF8faObtRy9e3WQF356RsaFnmCwrygcdi16A5F0OpXfHSzi/62LuBamzJuZ
         jB/JGsgxZjhZ+kXc3UXhVjej8t/uKN0F/wvsOWRFk6g5ZNiGlRzP/eiUaCrK7MetbJrJ
         32ZeifWXJ6iJQ+1ZgS5X6d5zv5cFV3qqLF9pwoT9kcostMKK0DhfCPHlzVoCJCfyLgc7
         adLQ==
X-Gm-Message-State: AO0yUKUGuVTTBiIqQmIq2zaLy/7W/gDQzC6cxAekOoSsGkN3p1yVmLCq
        Ex29abwKmTiLivdSY/OdHxdZMfPICKU4HLiOPl0=
X-Google-Smtp-Source: AK7set+TXIltfKGkitQarngwqrkjqN27z+oikwLhGz6ilz9DjoZ98a6VGxNqsBMf720HvVbAbyIwVg==
X-Received: by 2002:a05:6402:361:b0:4a0:e2d0:efd8 with SMTP id s1-20020a056402036100b004a0e2d0efd8mr9351781edw.14.1674934332479;
        Sat, 28 Jan 2023 11:32:12 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id k6-20020aa7d8c6000000b00487fc51c532sm4343221eds.33.2023.01.28.11.32.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 11:32:11 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id g11so7501435eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:32:11 -0800 (PST)
X-Received: by 2002:a05:6402:5514:b0:49c:48ad:3d17 with SMTP id
 fi20-20020a056402551400b0049c48ad3d17mr7885089edb.17.1674934331251; Sat, 28
 Jan 2023 11:32:11 -0800 (PST)
MIME-Version: 1.0
References: <1522976022.11185.53.camel@perches.com> <CA+55aFw=EQyJv52LjUje8ExMeX99u=8zzPsQAFv2MZ_N4V=Kog@mail.gmail.com>
 <3de4cbc2198105bcbc09ee355cd69a8b8756b89c.camel@perches.com>
 <CAHk-=wgSH8Dqfp2XVTeBrtAxf+2ZN_4pMjYOHwUt9i4NOGTkBg@mail.gmail.com> <9be6b6d57745452b66c4e96c40ead74cb1eabdb9.camel@perches.com>
In-Reply-To: <9be6b6d57745452b66c4e96c40ead74cb1eabdb9.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Jan 2023 11:31:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSWXYCPywfPj6TBE+Nsum71DsUqiv7furmA+ryFTPjVA@mail.gmail.com>
Message-ID: <CAHk-=wjSWXYCPywfPj6TBE+Nsum71DsUqiv7furmA+ryFTPjVA@mail.gmail.com>
Subject: Re: git source files with rw permissions
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Fri, Jan 27, 2023 at 8:06 PM Joe Perches <joe@perches.com> wrote:
>
> fyi: there's one more straggler:

And I think there's one more.

Here's another one-liner shell script for finding suspicious files:

    git ls-files -s |
        grep '^100755' | cut -f2 |
        xargs grep -L '^#!'

and I don't think 'scripts/atomic/atomics.tbl' should be in that set.

At least that file has a reasonable explanation for why it's
executable - over-eager "mark all these scripts executable" without
noticing that one of the files in question was just the input file to
another script.

            Linus
