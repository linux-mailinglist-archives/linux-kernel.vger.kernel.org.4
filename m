Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA33964317A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiLETO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiLETOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:14:19 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803A22521
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:14:13 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 3so1959897iou.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFyCIXZXXj52B6+TRuXYxnhDZPZi9MBnfF7ElnTFN0o=;
        b=KQGUU1Mz8tE4FwG55UuWK/DUEkyHdjC6KTQ4N+hj3x0ZlJuuTc/kGeD5/B6LgnUu/S
         xvJeckIeV8aKAbciCxa3sgM6JZxhtmx9pd4+am3DyFTPmz04pnk1xB/g4kahK7DENpu+
         rmKjl1FEIA/X1Ff3dM3ZgxaFCX3lKhsKjUlyxcBQqMl0OKlVgWU5h11YGOaWFIZsxRyt
         XwqdPO2DUJ2AuRL6F7yTO8blbdlbbTuR9F5rQKRp0SUtegBSmO8uVO6Yi0gcps2NbhaW
         zzS/ckngN3ZtcWj88HJFBh7DfGVIhhGFeAXbN7TEkpnK1GoeTaafGNV0gYvUCz0U7AM5
         tvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFyCIXZXXj52B6+TRuXYxnhDZPZi9MBnfF7ElnTFN0o=;
        b=Hp026bRlm7ovKobxlMcMDHAxrlmPg+/0eN/MF8YqiaDgVH4295Qjuph65T3Ih+iJR0
         mfxrpNHEzkoWd4sBe14wpbYC1MgBmgyQn8NKT0yVMCDoJuzhdgxsJR7aDCMG+qbGCTZJ
         0W67VzzhnZKveXIV/uUnfg9D3jzRCyTt6qsDsUezEiWgfcIOdQ01n++SjtAUCpy8V0Ek
         k6DLdNoxo5F8xezqMOaSXDsZOL9W5JlYqs6Yn1MsfPGOzmFtqXCavqT7CAmNmcJ4GDsw
         1rX52BrH1o8A4c88uTGWLOCHEfaT1dK7xekSPlhZu+25inEo1qWP7ORxTfjx4JbVae91
         hhmA==
X-Gm-Message-State: ANoB5pmHwptpA9lQb0gxGzBYYXh4fAS+XYzb6Q6iFI8NaTUuLG1gswBO
        XvlP2IU3ZBE0oQzeqzwe5Roh7XnjMls7pwJRmapzhg==
X-Google-Smtp-Source: AA0mqf5z+bsAKNYfj1j6BbUt9D4MCk7ZIBrj8IAdK2ejaTvyL2OacLKX78s44UxNUH1xT8V7DYXP6zYQ+wAgnvyJhN4=
X-Received: by 2002:a5d:97c9:0:b0:6a2:e3df:a40e with SMTP id
 k9-20020a5d97c9000000b006a2e3dfa40emr38722107ios.113.1670267652805; Mon, 05
 Dec 2022 11:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20221205020046.1876356-1-Jason@zx2c4.com> <20221205020046.1876356-2-Jason@zx2c4.com>
In-Reply-To: <20221205020046.1876356-2-Jason@zx2c4.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Dec 2022 20:13:36 +0100
Message-ID: <CAG48ez2R=Ov2Z9zn_W9+C3gHqOkPdQKAY=4SMWDUG=NfP=3eJw@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] random: add vgetrandom_alloc() syscall
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 3:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> +       mm->def_flags |=
> +               /*
> +                * Don't allow state to be written to swap, to preserve forward secrecy.
> +                * This works in conjunction with MAP_LOCKED in do_mmap(), below, which
> +                * actually does the locking (and associated permission check and accounting).
> +                * Here, VM_LOCKONFAULT together with VM_NORESERVE simply make the mlocking
> +                * happen the first time it's actually used, the same as when calling
> +                * mlock2(MLOCK_ONFAULT) from userspace.
> +                */
> +               VM_LOCKONFAULT | VM_NORESERVE |

Have you checked the interaction with this line in dup_mmap()?
"tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);"

As the mlock.2 manpage says, "Memory locks are not inherited by a
child created via fork(2)". I think the intention here is that the VMA
should stay unswappable after fork(), right?

Of course, trying to reserve more mlocked memory in fork() would also
be problematic...
