Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8476CF147
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2RmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjC2RmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:42:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750AD4EC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:42:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so66715628eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680111727; x=1682703727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pRW8ZygO7FUWeXFZhnZuyISfnteILKf1nQphP6NhE8=;
        b=J6bc3ZJblNqV7MlNcQNw6v9ofrHU5L9x99BqGLQjRsaTjDxCNeXLiOxXxKBS/j14wF
         AGUrm5BzNs0VWZaQDcb5xoESr7eP1kJfXU6jo8F28fRXyGg5UkQmDa05+lThbucpiXUw
         80tGsIxc/iEOLDj1BoA3Jdy7gpbboRY6AtREU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111727; x=1682703727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pRW8ZygO7FUWeXFZhnZuyISfnteILKf1nQphP6NhE8=;
        b=fmnu+QcUoFYS2D3ayejPRa/vnemsdesydk/WGsDYv18nkmIz4T6Xp8N0RYv4AhH7Wb
         g+uvZf6Qs6KmZpWnhBLdJGD2ciR23SYBLBYGUujft0DCLEEeaP/nwGMkfVfAXRLcJ9lf
         eETCFFxeoR98aehdRnvhG9m8VMrm8npiDp98J5elNJ0rdLHnU0ZxNthBNe2owSUbDEdA
         VzTQG9TjjX4psnytHYwXNV5W+ONfFkbx+68yJK6S4k1YgE8P+pUgAG+j6bVE01bk+MnO
         VsdNon65PQqHe1kcbsCChTngJen70d8wThQGjENB/Lho97T283vdNZW2gOoiA9oKQJhO
         LqCQ==
X-Gm-Message-State: AAQBX9ck8Js572c3rWADTaFxV/NLibV8qNyHWDg6cCmcIBuFD7wwpOiq
        ARqyrwTkpAktj/V22hVCnFtDD+xDuCzjglMS4IUWEoNE
X-Google-Smtp-Source: AKy350ZAhAd9vjE8N8R1CE6tQS/+G2lD6i2BN4ua9M7XAfpOe8PYtYrhBh5V98BpM+Kr3Q38QlXQGw==
X-Received: by 2002:a17:906:d1cf:b0:8b1:7aaa:4c25 with SMTP id bs15-20020a170906d1cf00b008b17aaa4c25mr22302201ejb.29.1680111727676;
        Wed, 29 Mar 2023 10:42:07 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id le1-20020a170907170100b00930d505a567sm16697277ejc.128.2023.03.29.10.42.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:42:07 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id er13so25508311edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:42:07 -0700 (PDT)
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr10331819ejb.15.1680111726812; Wed, 29
 Mar 2023 10:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230306122549.236561-1-douglas.raillard@arm.com>
 <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
 <20230328190306.3337b7b0@gandalf.local.home> <ZCOH9pc3hBKU3G3Z@google.com>
In-Reply-To: <ZCOH9pc3hBKU3G3Z@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 10:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=VDrd=kR7Q4DrvJ5yapinKfCmHiFSty3k5CTyawMmDg@mail.gmail.com>
Message-ID: <CAHk-=wg=VDrd=kR7Q4DrvJ5yapinKfCmHiFSty3k5CTyawMmDg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        patchwork-bot+f2fs@kernel.org,
        Douglas RAILLARD <douglas.raillard@arm.com>, chao@kernel.org,
        mhiramat@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:36=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Thanks for heads-up. I sent a pull request having the above patch to Linu=
s.

.. and it's merged now.

               Linus
