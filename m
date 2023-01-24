Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6B67A277
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjAXTRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXTRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:17:30 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1044B76E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:17:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z194so7513685iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FOFOSaLQOrkRQoByx+MHZFZu3IjU9ciUcRKHbAJFwzM=;
        b=RaQGn0EtgD0GlvmR/XS9WApiV6r0aktN1RBGXfqEf7K/gEi8/d2NAtaZTTC2MDxzK9
         BUqJBi2FX2S5XlW6pmWOfxvk7xPkZayiVdXGn0TSn670hNHyj2s0EIshMaadZMsci5U2
         a/MLaUK5i52xba5UNuzERP2mrf88CsO7WFAKj1BFGIbMmTV3u1+lNMcByX5ACboMC37D
         36AyPh8KlkZHKRjvPsYXuAX42LNF5frgMJeVMzE/O8fVgQvx20VELC3NLicW8x+QUZx7
         8+Wac4hEZrJOWuTX327GX7So21xHsJRVoi8UMFG0UnmzmlqxZhYFcgwG9OuqfTvCr9u+
         drnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOFOSaLQOrkRQoByx+MHZFZu3IjU9ciUcRKHbAJFwzM=;
        b=OZq8UOX16b7Z3nsb2TeHY/6ZXdCC/PsH0SbopElk/nQMUwSRumpIq9INjEGH2y29lI
         8geYNgfPR1L8IK+oq3Uy/zqW2OcM6/QerW1mDFd0UwIzBMssiBrx+kCfWxE5k3OFxOOH
         MV4IVdJ+jmxrdFFIP35K6DnlHTNTE+bG8iWXVdzx1K4XiaTW+vjTlseOpo6EEnDPMrqn
         QyD39Ld2Z70ORFXCCq0VP1YmU1CVdhZQoCgNMnP4r5RnzjUpHHFqgNyWSmAmho/Kcp+q
         5LGkPmx6W7f4/yUb4QOPtuqR7RjYBmSZpsSK19WdFB1CMGsb6Uj+sFvPXZYOPrz8OEUA
         slzQ==
X-Gm-Message-State: AFqh2kr71Vw8AJYI4uajmnzqRaquR6LMwIA4YtHSZAp2rIAFKesQkAYI
        MnsYL8VPPQcsvdg0vurUwLhctZU81Kd9gFarJxk=
X-Google-Smtp-Source: AMrXdXugUsSf6tn59cesSQb3K9xBzA3rCCvfpoyAK5SJ01jH7GQtQgFOQ4APw5oJhjiroLLlTOf5q3ujRBTFdJLLDVw=
X-Received: by 2002:a05:6638:ec5:b0:38a:4fbc:b85a with SMTP id
 q5-20020a0566380ec500b0038a4fbcb85amr3058779jas.277.1674587847072; Tue, 24
 Jan 2023 11:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20230120102512.3195094-1-gscrivan@redhat.com> <20230124015348.6rvic5g6ymsfvj4e@senku>
In-Reply-To: <20230124015348.6rvic5g6ymsfvj4e@senku>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 24 Jan 2023 11:17:15 -0800
Message-ID: <CANaxB-xczp4NSHUN0xCoRve+OgaGEQuac5w2X4mqegmsQQT7ug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        bmasney@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 6:04 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2023-01-20, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> > This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> > processes to hide their own /proc/*/exe file. When this prctl is
> > used, every access to /proc/*/exe for the calling process will
> > fail with ENOENT.
> >
> > This is useful for preventing issues like CVE-2019-5736, where an
> > attacker can gain host root access by overwriting the binary
> > in OCI runtimes through file-descriptor mishandling in containers.
> >
> > The current fix for CVE-2019-5736 is to create a read-only copy or
> > a bind-mount of the current executable, and then re-exec the current
> > process.  With the new prctl, the read-only copy or bind-mount copy is
> > not needed anymore.
> >
> > While map_files/ also might contain symlinks to files in host,
> > proc_map_files_get_link() permissions checks are already sufficient.
>
> I suspect this doesn't protect against the execve("/proc/self/exe")
> tactic (because it clears the bit on execve), so I'm not sure this is
> much safer than PR_SET_DUMPABLE (yeah, it stops root in the source
> userns from accessing /proc/$pid/exe but the above attack makes that no
> longer that important).
>
> I think the only way to fix this properly is by blocking re-opens of
> magic links that have more permissions than they originally did. I just
> got back from vacation, but I'm working on fixing up [1] so it's ready
> to be an RFC so we can close this hole once and for all.
>
> [1]: https://github.com/cyphar/linux/tree/magiclink/open_how-reopen

pls add me into cc when you will send this change. We need to be sure
that it doesn't break CRIU...

Thanks,
Andrei
