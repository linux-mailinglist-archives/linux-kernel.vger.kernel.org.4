Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EE6C6F99
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCWRpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:45:04 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA63AAE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:45:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c19so27507599qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679593501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+aviwg+yLbOH7NuEkcwn79zl3PJ/u1Tvv20Vv8v5PYI=;
        b=Ug+/n7OA7vIk6CMZwgcqzI8bs9/jzQ3aXxHAVSn71Uha9aPr5cP43W/yGEGYZ4aVzI
         nRzr/OWkG/p2AJRdrEfK7jt+QefO3dqFLZmzC2o7yDGU+eUA+gz/kjs2L8B0La1Gc1LI
         8Mzwnbvz3LDcgFSxBb1Q7jKVWFW8rkARg4KvaCfrbTJ8liGMgclWK5Pk5niHuHDFwMnD
         u9q8AHabM1aK6ChvRLnkzzKwu0Htxjo1KFvkhUcEQdJMugteLph0g3FhvvndniQUUqSQ
         Z5Gdia1v5GVX/4DbUzkEgsYnh7/39YANHFHyUYRc0uiZodcF7XKErFZO2QQi21jP4rgN
         6M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aviwg+yLbOH7NuEkcwn79zl3PJ/u1Tvv20Vv8v5PYI=;
        b=Nx9NygfbNl5ky0hJMbUBvxuwisBGWXV9FnYTcIqIC2SA/Es6io8mv4ByQL8AyG3DFF
         pFkLM5v2mHeOpbsX+Y/X/B/eZxiklUuEfbrZRAop39UtWw+7bYpDC0HJ1gBHRjvoU2xd
         xkK68iw2QpZRBUh/76yxXvG3U8z/1XilGwMnHcaJcn3kLf1cDtTUpcCxWdrfpObMOwTV
         GWFpjavazUif69TYj+X3vqxEuHKejbw3DkbGcLnxgP+/6LwbzTXzqhmzWs3JXaKIXnZF
         jNffP1MFyO6PEtXFo5bS+OB8QHHk2/lKfFEJtr1OsiR6HvNRg0L3k2F2+riRcmpcmbS7
         pU7g==
X-Gm-Message-State: AO0yUKUd1fWdZgA1gu7iL5qRAk2OvzsmkEY9bluAYIaCtZBb/zfVMG7o
        rAnFYz2s9eKQ7D2IDj0X87JFLg==
X-Google-Smtp-Source: AK7set+GkGAJP/6ZaSGzw4g30W301lZ5o/7gxo/UhQDvCoYd9ncyFnk6K9iT4ZtPqwbSOgthY/rzSw==
X-Received: by 2002:a05:622a:28d:b0:3de:6964:7bff with SMTP id z13-20020a05622a028d00b003de69647bffmr10942384qtw.20.1679593501062;
        Thu, 23 Mar 2023 10:45:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id e16-20020ac86710000000b003ba2a15f93dsm5321291qtp.26.2023.03.23.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:45:00 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:44:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <20230323174459.GH739026@cmpxchg.org>
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
 <20230323103350.40569-4-cerasuolodomenico@gmail.com>
 <CAJuCfpFh0iL0cE8V3dh-HkDx3-20Kyo+ZAt0vnqvOzA33HwnFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFh0iL0cE8V3dh-HkDx3-20Kyo+ZAt0vnqvOzA33HwnFg@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:55:11AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 23, 2023 at 3:34 AM Domenico Cerasuolo
> > @@ -1254,16 +1262,19 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
> >  }
> >
> >  struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > -                       char *buf, enum psi_res res)
> > +                       char *buf, enum psi_res res, struct file *file)
> >  {
> >         struct psi_trigger *t;
> >         enum psi_states state;
> >         u32 threshold_us;
> > +       bool privileged;
> >         u32 window_us;
> >
> >         if (static_branch_likely(&psi_disabled))
> >                 return ERR_PTR(-EOPNOTSUPP);
> >
> > +       privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
> 
> I missed one detail here. We are moving the cap check from open() to
> write(). That might break potential users which open the file from a
> process with that cap and then pass that FD to an unprivileged process
> to create the trigger by writing to that file. I'm not aware of any
> use of such a pattern but it is possible there are such users.
> With this change such users would have to delegate trigger creation to
> the privileged process too and the received FD would be used only for
> polling. IMHO that's a safer pattern because triggers are created by
> the privileged process.

Oh, it's checking file->f_cred, which is set up at open(). So if the
opener is privileged, the write can be delegated to an unprivileged
process.

But I agree that this is subtle and could use a comment.

This was a usecase specifically requested by Christian, actually.
