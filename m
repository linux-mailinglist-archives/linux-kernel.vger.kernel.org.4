Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E378D6B85DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCMXIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCMXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:08:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B27B9AC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:08:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so52140wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678748890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCAgZtvsvzEwpyf+tDTv88lry9y+fkPb0SFZ89lPlIY=;
        b=U6ICPpoPPnsA6GsxHGPXzbQn2+EEE6xLdbLQfH0Zm21MgYRzBEptOazyKUi2PCUrIm
         VTG7ywGv7Q/POGk0pJFJw6vo8Z43W9rWiLHzTtkDUqDwCn/+n/Xzuj/W636hqcU97SbO
         eKhU0EQTzSy3uj/lXi1FFFOsV1YedONHfnVjEipSceLLEWprp0+uuy40fMLIannRlbVI
         SZp6yhGjMZrFRgPkL4MpjiyD95VvegFGfEq/6Xab6UGsfzs5Sq9oMkTdaPhgcGA4polx
         Gfew9da7JTsYxxU6xUFcN0IXinXBI1j1X2ZKFLl2EIeYj8GseDysmHFY+43ueyMHTtry
         +wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678748890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCAgZtvsvzEwpyf+tDTv88lry9y+fkPb0SFZ89lPlIY=;
        b=rDPLqpT1LHPi/edtOpEGSa2e8gNgnj5NVaLJvBjeYQfWLQ7bU28rWLJw5tV83vAgyk
         GuB8xvTZlNX5c/2eJT8aIdXra0Ko1IhU12mGslxnwtUq4k50lDSSoZFMlbQE/8Lfhgh2
         YgQuKDOHAOkaoJ27bZE5XojFBcGwa8nLCxhWVdiMDWWwWk+YP+bk9LEIl/M9O0h6eIAD
         jfPeK+Q4noQaiRe3KZwKy8gmvlPRONU7B2GTX36xWyeYPni9ATOZ5TtGZd7E+lFkOvM2
         lrRaEXwokTz6bf/EB0D8zfR+ker6uSSjt54Vi11QacYW8HVJ4njNP9sWPySsNOlRAHI8
         WYuA==
X-Gm-Message-State: AO0yUKW9QfiBPo9SeMueMNPSWLm/DVPODIrtkpvrVyvqGuk8MwZd1GV5
        rjQpPevnQyUhJNI9Ngekb0LJwhcC3l6+9mjaAc3LFA==
X-Google-Smtp-Source: AK7set9NFQkbop6nJgcwtia/x3RdY5/3UU85190ckqLwVyrIVh+aws8dF2LEUlwSbgMaOHOssSbOdj/4KqZebXkzEWw=
X-Received: by 2002:a05:600c:4709:b0:3e2:2107:b7f2 with SMTP id
 v9-20020a05600c470900b003e22107b7f2mr3569275wmo.6.1678748890480; Mon, 13 Mar
 2023 16:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230310193325.620493-1-nhuck@google.com> <ZA+qt0gakiyAoacr@sol.localdomain>
In-Reply-To: <ZA+qt0gakiyAoacr@sol.localdomain>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Mon, 13 Mar 2023 16:07:59 -0700
Message-ID: <CAJkfWY5eg2wLMUKUL5whU6zoHFogiUna1NPE+W8fPHm8YS-ReA@mail.gmail.com>
Subject: Re: [PATCH v2] fsverity: Remove WQ_UNBOUND from fsverity read workqueue
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev,
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

Thanks Eric.

On Mon, Mar 13, 2023 at 3:59=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Fri, Mar 10, 2023 at 11:33:25AM -0800, Nathan Huckleberry wrote:
> > WQ_UNBOUND causes significant scheduler latency on ARM64/Android.  This
> > is problematic for latency sensitive workloads, like I/O
> > post-processing.
> >
> > Removing WQ_UNBOUND gives a 96% reduction in fsverity workqueue related
> > scheduler latency and improves app cold startup times by ~30ms.
> > WQ_UNBOUND was also removed from the dm-verity workqueue for the same
> > reason [1].
> >
> > This code was tested by running Android app startup benchmarks and
> > measuring how long the fsverity workqueue spent in the runnable state.
> >
> > Before
> > Total workqueue scheduler latency: 553800us
> > After
> > Total workqueue scheduler latency: 18962us
> >
> > [1]: https://lore.kernel.org/all/20230202012348.885402-1-nhuck@google.c=
om/
> >
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> > Changelog:
> > v1 -> v2:
> > - Added comment about WQ_UNBOUND
> > - Added info about related dm-verity patches in commit message
> >
> >  fs/verity/verify.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> > index f50e3b5b52c9..782b8b4a24c1 100644
> > --- a/fs/verity/verify.c
> > +++ b/fs/verity/verify.c
> > @@ -387,15 +387,15 @@ EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
> >  int __init fsverity_init_workqueue(void)
> >  {
> >       /*
> > -      * Use an unbound workqueue to allow bios to be verified in paral=
lel
> > -      * even when they happen to complete on the same CPU.  This sacri=
fices
> > -      * locality, but it's worthwhile since hashing is CPU-intensive.
> > -      *
> >        * Also use a high-priority workqueue to prioritize verification =
work,
> >        * which blocks reads from completing, over regular application t=
asks.
> > +      *
> > +      * This workqueue is not marked as unbound for performance reason=
s.
> > +      * Using an unbound workqueue for crypto operations causes excess=
ive
> > +      * scheduler latency on ARM64.
> >        */
> >       fsverity_read_workqueue =3D alloc_workqueue("fsverity_read_queue"=
,
> > -                                               WQ_UNBOUND | WQ_HIGHPRI=
,
> > +                                               WQ_HIGHPRI,
> >                                                 num_online_cpus());
>
> Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=3D=
for-next
>
> I adjusted the comment slightly so that the first paragraph doesn't start=
 with
> "Also".
>
> - Eric
