Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3E6ED257
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjDXQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjDXQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:23:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3513C18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:23:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7637c5ed865so418042539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682353391; x=1684945391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GIxhCllL9emfLEeLtesjmIIXkU0PWD8X6W28r7Ovd4=;
        b=fBeu/6nerHhcPptVpuRUWEkHHLBJoisIIXWTDGPw61BIhe7KXcQhl/EibWd0iqcrO5
         G1xpT371wjti7GAnEgkBnHGufHa00VZHtgT1HhHZRZriH6KMN5v2Egwegtk11QP+iqGW
         8TEHA+yyXu2ybyzmB8mHhszUg0H3VCsE0ReeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353391; x=1684945391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GIxhCllL9emfLEeLtesjmIIXkU0PWD8X6W28r7Ovd4=;
        b=HcIK/z4GiwjHUxYc8Mem2rvJEg6DRgK3XGS8zFYrF7N2fwqOVDGpdI2GkDj9gYcrwq
         IdED8RCLyzJ+7t1F884YscANNfR951hOK0jaSgUcLC/BrRSZVvDNT04m4rtcwzOumZpO
         pgnKUqBtQaiK1WEJ+QYg3mJTWk4LQvD1Pw9nvOGU5JeRz8sMLaom0V+1sqztGGdnfwQC
         /iTtdFn4xL4KPHFphnVJ0YnprWowGuJVAdQ/CKnx57vjQoznPHNAcQQtXwOysGfBwQEO
         q6dGeyFXb1NVf4GOVnYDobTyNUwsQspOHfLyZmZO8vhQkMpyfBZwBPXCC+eMMoENU+hD
         EC2A==
X-Gm-Message-State: AAQBX9f1STBIWAWlyQjjOHsjLwPenl4YeWws6pjayYkHSCyE7ClhSMXR
        1onEGAWKagq4eAspy/S87kNQnDhmAZPfiSTs/ZY=
X-Google-Smtp-Source: AKy350Zb0aM6LbIz41xPAQII//3NBi47FluV9eQabTXB68wNrdQNCr+Mh45ZTfeI376GUz6BrlipdQ==
X-Received: by 2002:a5e:c913:0:b0:760:ec52:254d with SMTP id z19-20020a5ec913000000b00760ec52254dmr6219457iol.2.1682353391690;
        Mon, 24 Apr 2023 09:23:11 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id b14-20020a056638150e00b0040f783066a5sm3331039jat.31.2023.04.24.09.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 09:23:09 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-325f728402cso1077045ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:23:09 -0700 (PDT)
X-Received: by 2002:a05:6e02:16cf:b0:325:d0d8:2ddb with SMTP id
 15-20020a056e0216cf00b00325d0d82ddbmr508009ilx.15.1682353388677; Mon, 24 Apr
 2023 09:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid> <20230424082254.gopb4y2c7d65icpl@techsingularity.net>
In-Reply-To: <20230424082254.gopb4y2c7d65icpl@techsingularity.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 09:22:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRMiDxKyLKGKL3ekk8CjRt6puT1PReD+pE21JGgF4TQw@mail.gmail.com>
Message-ID: <CAD=FV=XRMiDxKyLKGKL3ekk8CjRt6puT1PReD+pE21JGgF4TQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 24, 2023 at 1:22=E2=80=AFAM Mel Gorman <mgorman@techsingularity=
.net> wrote:
>
> > @@ -1295,10 +1296,13 @@ static inline int folio_wait_bit_common(struct =
folio *folio, int bit_nr,
> >               /* Loop until we've been woken or interrupted */
> >               flags =3D smp_load_acquire(&wait->flags);
> >               if (!(flags & WQ_FLAG_WOKEN)) {
> > +                     if (!timeout)
> > +                             break;
> > +
>
> An io_schedule_timeout of 0 is valid so why the special handling? It's
> negative timeouts that cause schedule_timeout() to complain.

It's not expected that the caller passes in a timeout of 0 here. The
test here actually handles the case that the previous call to
io_schedule_timeout() returned 0. In my patch, after the call to
io_schedule_timeout() we unconditionally "continue" and end up back at
the top of the loop. The next time through the loop if we don't see
the WOKEN flag then we'll check for the two "error" conditions
(timeout or signal pending) and break for either of them.

To make it clearer, I'll add this comment for the next version:

/* Break if the last io_schedule_timeout() said no time left */
