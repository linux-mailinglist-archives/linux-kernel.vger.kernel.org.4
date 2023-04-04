Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968FC6D5F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjDDLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDDLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B728F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680608267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ1ixt4I5eKbz7gsvcX9jwc/HOMjJPpO7V63NSQms/A=;
        b=E5W2AiStuu7T+Vznxd5rTb2FaOYwmK1qW7IkW9yMTTVRjBvwHdT0EpZj01PQg/xX2wVRG5
        LwVOd0QwEgiIC0LJzv8yLqwBh/0D1LXNokDq57o3bgrrmAOBeHsxiT5fhcKGwWFUjERg87
        oNWq+LK9g0nxdHDNrdQVg9pSBB+XNYU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-ngb4sOebNnGBqysFPpmDJw-1; Tue, 04 Apr 2023 07:37:46 -0400
X-MC-Unique: ngb4sOebNnGBqysFPpmDJw-1
Received: by mail-lj1-f197.google.com with SMTP id t7-20020a2e8e67000000b002a5faaf797fso5519468ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680608265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ1ixt4I5eKbz7gsvcX9jwc/HOMjJPpO7V63NSQms/A=;
        b=W8GN/CKB+GtkrA7y0mKePTZ5rIBpXYllGU+6puu4s9RQ6fsz+9RBY9bebFs/bzOpPR
         ZUG1/cLLjb6hXt8aPCCAgVsqNQahm2Dc2teBDziNQLxVJMXHx4PUZELCT5Tq0agATF/f
         eVAfr5+ZBRW1uOzQrLigv8ehQGrMNB777NPKWoQJSWZSDswWiBS967l2v/JBuSOB2GIL
         c9ky4q1Nwmo4nz44i130sxwnnEEvzLYOiokwjIQqp57jdxhx+i4JrpI+scsToBez717o
         BO0OQcwvkdhP4PRwMa8y41P4Yamo1ZVkdF45kd7nSsS/MnSbJNTn0YzZIjEhgLIUOYYN
         qORw==
X-Gm-Message-State: AAQBX9fdkq0jHeOLj+ZeVjSfv5hnQl6rF7woad+rIo3rlWmnakUki41B
        TU7cSDtSf4fDWpnuwLZ31g9iRo88lX25i003kBmmdiYTczCdC1fp0U943eSgFfkdUlkqqGxQIaV
        M53k7xf3zBT5Nz9WoNE41hmLQLqlYqwFeoQGqMCZq
X-Received: by 2002:ac2:592b:0:b0:4d5:ca32:9bd6 with SMTP id v11-20020ac2592b000000b004d5ca329bd6mr635862lfi.2.1680608264961;
        Tue, 04 Apr 2023 04:37:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350bseP7CFaPX0tyIyB7qXk1VPHrYZeXwVaUUl6Pd06XKgxqWIlx83Po83mrxQGvoHE11M/6n0v8nr1sUtubUpbk=
X-Received: by 2002:ac2:592b:0:b0:4d5:ca32:9bd6 with SMTP id
 v11-20020ac2592b000000b004d5ca329bd6mr635853lfi.2.1680608264646; Tue, 04 Apr
 2023 04:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230404075540.14422-1-ihuguet@redhat.com> <CANiq72mkORtWGuCZBdTy8eEuf9jAtkvA63nnw47MUkREp+j6YA@mail.gmail.com>
In-Reply-To: <CANiq72mkORtWGuCZBdTy8eEuf9jAtkvA63nnw47MUkREp+j6YA@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Tue, 4 Apr 2023 13:37:33 +0200
Message-ID: <CACT4ouf1+xkjEbTMepOcdZ9tBuJ+5nbK1GaHdKce9SOj5o7gXg@mail.gmail.com>
Subject: Re: [PATCH v2] Add .editorconfig file for basic formatting
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Danny Lin <danny@kdrag0n.dev>, ojeda@kernel.org,
        masahiroy@kernel.org, jgg@nvidia.com, mic@digikod.net,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 11:51=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi =C3=8D=C3=B1igo,
>
> On Tue, Apr 4, 2023 at 9:55=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@re=
dhat.com> wrote:
> >
> > EditorConfig is a specification to define the most basic code formattin=
g
> > stuff, and it's supported by many editors and IDEs, either directly or
> > via plugins, including VSCode/VSCodium, Vim, emacs and more.
>
> Please see https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdr=
ag0n.dev/
> for a previous patch & discussion, as well as commit fa60ce2cb450
> ("treewide: remove editor modelines and cruft") for a related cleanup.
> Cc'ing those that gave some feedback back then.
>
> Danny's v2 patch has some extra extensions/languages it manages as
> well as some docs, and yours handles things that one doesn't, like the
> Rust files and `Makefile.*` cases. So it would be nice to get a
> version that merges everything from both of you, likely as
> co-developers.

I will be happy to prepare the patch, as co-developers, if Danny agrees.

> It still remains important to see if somebody's workflow could break
> due to this, especially for the catch-all section `[*]` and for
> options like `trim_trailing_whitespace` which can actually break
> things like patch files as you note in the changelog. Perhaps landing
> it in linux-next for an extended period of time (e.g. a few kernel
> cycles) is one way to find out, or we could start without the
> "dangerous" options. What do others think?

I can move everything from [*] to the extension based sections
(*.{c,h} and so on), so it is safer. It can only happen that someone
notices that a weird file is not auto-formatted, and hopefully gives
feedback to add it to .editorconfig.

About the potential break of some workflows, and after reading the
previous conversation, I don't think there is much else we can do. In
any case, it won't be that harmful: using editorconfig is almost
always opt-in, and if anyone has a problem, he will disable
editorconfig to complete the changes and hopefully give feedback.

If you think that it's better to keep it in linux-next for some time,
it's fine, but I don't think it's necessary. As I say, I don't think
it can be that much disturbing.

Finally, about the files without extension but with a shebang,
mentioned by Masahiro, it seems that they're seriously considering
supporting tags based on language, like [[python]] and [[bash]], but
nothing has been done yet, so, again, there's no much we can do. If
someone frequently update specific files and want editorconfig
formatting for them, their full paths can be added.

Regards

> By the way, for the next/merged version, in your side please keep
> `!.editorconfig` sorted and in the other side please avoid the
> duplicated `.tc` case (which I just noticed).
>
> Cheers,
> Miguel
>


--=20
=C3=8D=C3=B1igo Huguet

