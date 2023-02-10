Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055169286F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjBJUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjBJUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:37:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281605A9DA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:37:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m8so5785891edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V5hbvtyrVhBU5KLvd4luM4pmIGBHWSgPPjkAzLVdXdc=;
        b=XJVb1xKfBvelCl8Xuh4Bkq319Cx2dxwUHidMnSfKqGDU/b9SmTwk9u5Vp4ORhPDBNt
         uLp+1raScNofpejxVBGtMzdmvBtnEGPM6qvYjZcLw/dIFGbo6cMI3yaedOJppVXrhg5I
         8ihrf6+ZhqT/79pvdvMQsBrrZs8E6lxb26z2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5hbvtyrVhBU5KLvd4luM4pmIGBHWSgPPjkAzLVdXdc=;
        b=2DiAboz8k2ukquEkP8Rq8LKpVpx+fJ0PBqIfCTNbYktql5o7T/Ot09RmBSH9X+Iete
         AybpFD9UPIivIfzHvSAi6AfJQL5AnjKigZu9RFEc5NB5mzT7SkHS+nQJTIFin7KMYVH/
         jyvEwgQF/mjFbZbMH/NMAewqOi+BJ4oStqa75vUEB3zZZtDxt5BlrjorYaBA8qxnBK7P
         kwTzk37BRs0lnZWPWo5GpyD7EFZrmE5cM/trGlqKMLbuP/GTLpMk68yeEuSldQH0uXuV
         nwUyhBDm4zCnwyUnph5k8z2aLFoiQBsnmS39uIwxdyouEUf9muCm8DyR2GyYYSuIGdF9
         /DCw==
X-Gm-Message-State: AO0yUKXmb3kV/MsTL6qOQKCVtfOIRBLsmeqaX4NTpUpT/2NdugfDq1DG
        ay+hLtyGk3iZKLJILOOEGIX7acvCjixkXuioVRk=
X-Google-Smtp-Source: AK7set8pvN+TceajZzPXIvmQCmL4orI/QOdaTMtJTM5lcFTKGr9Ov4smMDXxQjABvEhkFHOoTYdekQ==
X-Received: by 2002:a50:c04d:0:b0:4ab:100e:1653 with SMTP id u13-20020a50c04d000000b004ab100e1653mr11087099edd.15.1676061437223;
        Fri, 10 Feb 2023 12:37:17 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id v15-20020a50954f000000b0049e9e9204basm2767656eda.21.2023.02.10.12.37.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:37:16 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id qb15so16810834ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:37:16 -0800 (PST)
X-Received: by 2002:a17:906:f749:b0:8af:2ad9:9a1d with SMTP id
 jp9-20020a170906f74900b008af2ad99a1dmr1552969ejb.0.1676061435878; Fri, 10 Feb
 2023 12:37:15 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com> <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
In-Reply-To: <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:36:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
Message-ID: <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Fri, Feb 10, 2023 at 12:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> No, we very much do have that for io_uring zerocopy sends, which was in
> the bit below you snipped from the reply. It'll tell you when data has
> been sent out, and when the data has been acked.

Hmm. splice() itself definitely doesn't have that data - there's no
"io context" for it.

There is only the pipe buffers, and they are released when the data
has been accepted - which is not the same as used (eg the networking
layer just takes another ref to the page and says "I'm done").

Maybe adding some io context to the pipe buffer would be possible, but
it's certainly not obvious how, without changing splice() semantics
completely.

             Linus
