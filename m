Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26B86DE9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDLDPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:15:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D55A10F1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:15:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q23so15886366ejz.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681269305; x=1683861305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2aLD25Ot081xFob7JhFohIXGHn7ePe7bEvSfkHbEzo=;
        b=IpcH9Q5RdjkcrWgoK6dPL+vOgohLeK5Sl9VH74j3++/zDYM0fYW2mAWg/iFZ35ETvp
         pkEph8dHH2vuakarqoTWXf1ykKmpgbK7rDnbG/3tz1+E0OX4iITnr+0c3DMxQ4ZLoV2U
         JLY1j+hOdY1R3c98/cFfBKL9fRiJ5EAClNHJp73IJsfFl3ga5KVYAoSqSD+YT6lbSMiv
         3rtI3DFqX5jGjPGHf2kXt+c2+OpoWI51QuvYt82GfUbHgOhkejZ/zrKFbrc32pdnFhnJ
         lUyN0JtbnKNM0OP2Ows7iP3Hna65oOX7Jy2vtFJ8H18yBAl9utThM77lPkelDYJuCThF
         hpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681269305; x=1683861305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2aLD25Ot081xFob7JhFohIXGHn7ePe7bEvSfkHbEzo=;
        b=hcCJaAJSt6VX9YzDagnNBqqkLLXkz4ksCgC4i0BI+RGbJ+WiBz3gbGl5zcTvRqEnA0
         Gexph9dP0Ls88q/5nNjxBGsSqVMS+aCqkE9FBknK13OcXvgooN/sd4LpUhEPs44wJrj1
         uqOVy+AhKnQLDxSmRQLSgZzCTAxe0MuV2Kla53D5Yc36j9o5xeAXFUfGz8Jqawdfm1+G
         /W991DPWcH5z2RDCCt6tuSDireLn7hal0RANKlHVThZ25433LtsVFbeeuM46RqkuQxsr
         mCbl0NLqNUGleOskygvkzlDtLTTUmDDf+iyrjY3xBDmnQOhyMw8yeJtgznr43ekMRvrd
         xjaA==
X-Gm-Message-State: AAQBX9cmXRIFRLLcCQKmFJmlkWpanM43b94BYCfUWMfNW6IuFdsvgIML
        s1B6qJPFzM9Qu5SkeW//EPZwwb7P3fISAQVZ86+bcA==
X-Google-Smtp-Source: AKy350bXMQ/JFvjKN6x09Spo/NNwaCuecL9LjgLWZ0jv6Ne0hw1NstU+xOIJmCnF4MdPyJlkwm89MScbQO6GmyoFPD0=
X-Received: by 2002:a17:906:dac9:b0:933:1967:a984 with SMTP id
 xi9-20020a170906dac900b009331967a984mr5493106ejb.15.1681269304798; Tue, 11
 Apr 2023 20:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230411143852.868524-1-senozhatsky@chromium.org>
 <20230411224652.576dd18c@gandalf.local.home> <20230412030759.GD25053@google.com>
In-Reply-To: <20230412030759.GD25053@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 11 Apr 2023 20:14:28 -0700
Message-ID: <CAJD7tkZjAPZjxoAdGjZmEmDhd7S78bVrtVa6XuK0aPRZPoyzkw@mail.gmail.com>
Subject: Re: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 8:08=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/11 22:46), Steven Rostedt wrote:
> > > Sometimes we use seq_buf to format a string buffer, which
> > > we then pass to printk(). However, in certain situations
> > > the seq_buf string buffer can get too big, exceeding the
> > > PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
> > > truncate the string.
> > >
> > > Add a new seq_buf helper. This helper prints the seq_buf
> > > string buffer line by line, using \n as a delimiter,
> > > rather than passing the whole string buffer to printk()
> > > at once.
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
> > Looks good to me. Want me to pull this in my tree, or do you have
> > patches dependent on this?
>
> Thanks, would be great if you can pull this in your tree. The MM
> patches that Yosry is working on will be posted after the merge
> window.

Yes, thanks Sergey and Steven.

The sooner this patch ends up in Linus's tree the better for me so I
can send my MM patches based off of it. I am guessing through your
tree is the easiest way for that.

Thanks again.
