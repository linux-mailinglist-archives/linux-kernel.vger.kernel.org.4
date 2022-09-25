Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754885E9478
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiIYQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiIYQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:50:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880F1929A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:50:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so3460570pfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ky5Adl6C+4aX3Brpf29Pzd/6UXQ2gwW9189O0+AcBu4=;
        b=Zw/6SNPliN4Fe5XyZ1d+VE8fT6X2mSHXbuYtpmc6vjjwCnEU2V1R+CVRzjQPP5151t
         JF9Mc9xqm/0qNdafsTsfDn1jJvmf/DCTZCpbct6wJJy6fbWJhYXiekdFoA131N+5Sgdk
         UPxJ8ZzVsmGB2p0uUbY5cL9YMkghkyRKi/8ejuuEF7bOLW9jXxwoTVIaC4Kqr4YIf0Bs
         CVEERVJxVgEVuQ51XIB/O8JzhNKwARdfZKM80wnEA1jElP60OYwoVey5Fk/kKJUe2fNJ
         QnMzaExxCMnQNH8J69u/fmJIjtJPK2wFt2IjW5x4bFUXQDNn/e0JXMNtw183rvxzRI3r
         5nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ky5Adl6C+4aX3Brpf29Pzd/6UXQ2gwW9189O0+AcBu4=;
        b=2qQpwqFroUVTse3rsKReb64DHUsgnEI6ObF2t95Wqg0kJidmlYwxcVMdGs4ZCJNfqd
         4EBVwyDX8zmecx2Q7wjdew8c+MSO1GWI/SMw4iPhZhLrvrqgevy3gpo0CxQ2+R3RyYM/
         Eime/fTk//HCKGryYj1KbnZv+43sA5byza+8/VULTTffBJNWAZiFrf5Cw9MuiB9LpvSI
         6U+KPEdSnOsNTHUPECSf6GQOFhgu0+Hb0SdPW0XY1iQGNWIsIRZxzw6bbWttmc/GAkZW
         oJ7K8Vn4hiGOOoowO16BTbXPA/u2JgFfxZLqPshdxEAgdm577G5eIgHdmhdr/xnvC5+c
         GD0w==
X-Gm-Message-State: ACrzQf2N9k916rA6P2GgA3MplJhKS7psYoU//rfcxZdU13m+lQlxm8hp
        xmkLaIxr6idg2ljjn6fl+j5hqDDcJ4dQ6gArQnM=
X-Google-Smtp-Source: AMsMyM6N79iUigMA4+KyJLYWZ2r3yoHBoZpTBd68QEMFzNV9HsluaCZuTdZgSgrorvGq7UKCM+0VGcxKTgebDXgXtLI=
X-Received: by 2002:a05:6a00:16c8:b0:53b:3b9f:7283 with SMTP id
 l8-20020a056a0016c800b0053b3b9f7283mr19567668pfc.46.1664124608056; Sun, 25
 Sep 2022 09:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20220819032706.695212-3-xiehuan09@gmail.com>
 <20220924160136.5029e942@rorschach.local.home> <CAEr6+ECbocOnr_fSp_rwnu7ugg_q0wrYWShYsW3XOJffqwSOYA@mail.gmail.com>
 <20220925115335.44b58732@rorschach.local.home>
In-Reply-To: <20220925115335.44b58732@rorschach.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 26 Sep 2022 00:49:56 +0800
Message-ID: <CAEr6+EDft-pFrCdatd1ypWbjk9_KkMpBXcS6q4zaUgmkQuW0Eg@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] trace/objtrace: Get the value of the object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
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

On Sun, Sep 25, 2022 at 11:53 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 25 Sep 2022 13:27:10 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> >
> > It also looks like the "add" command field has been removed,
> > Masami previously suggested I to add a reserved command field for the
> > future (see [1] and [2]):
> >
> > [1]:
> > https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org/
> >
> > [2]:
> > https://lore.kernel.org/lkml/20211105004704.3f4aa456c2c537a56f64e65a@kernel.org/
>
> Ah, I see. add means enable the tracing and del means disable.
>
> Masami, perhaps we should call it "enable/disable" instead? Because, to
> me "del" means to remove it (permanently), where as "enable/disable"
> matches other triggers like the "enable/disable event" that starts and
> stops another event.
>
> >
> >
> > > This code is available in the kprobe code that eprobes also uses:
> > >
> > > See process_fetch_insn() in kernel/trace/trace_eprobe.c
> > >
> > > and the parsing of the string is in kernel/trace/trace_probe.c:
> > >
> > >   parse_probe_arg()
> > >
> >
> > Thanks for your guidance, but the next merge window is coming soon,
> > and since I'm not doing full-time kernel development,
> > I can't guarantee that the development and testing of this change will
> > be completed before the next window merge.
> >
> >  Anyone familiar with this code providing a patch is welcome ;-)
>
> If I get a chance, I may see if I can quickly implement it.

Thanks a lot ;-)

>
> >
> > >
> > > I think doing this will make it much more extensive, not to mention it
> > > will match the syntax of other code in the tracing infrastructure.
> >
> > I super agree.
>
> Thanks for you patience, and I'm sorry it took so long for me to review
> it.

Nevermind, I've always been a fan of ftrace.

>
> -- Steve



-- 
Thanks,
JeffXie
