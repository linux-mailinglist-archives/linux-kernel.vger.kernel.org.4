Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CE6E2AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDNTtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDNTtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:49:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0549FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:49:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y16so4972334ybb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681501746; x=1684093746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ued8RPGYYYnTKpEa2LQkIv8m2xddx8+vhFWcpImfwlQ=;
        b=tFpwAcRuO/oWarfIbQRGNUHywoAJAdE9Xr73K/XoYX/+lNNn90EfAngAnAUgZsn6K6
         qqlnwgtqd4LExnuakpYn63uO+fhrxTuyWr64ifHof0eLfAnMocwgHB8vuefYoby+u8fg
         BdeArXXzre+hm9KxIuaqyLhxfYpgUfp0h69B16oTP3FM5+oE/i9CmSfv6S2NK1u7L+EG
         OTBmnQDRZLFAUumpp2AV1kYLnHuEKLls9qwqjESqhSvYrUrQiTMrhyTTeaDlrm5j8wL0
         41rEK1DT0Ue4LSFHEvGsQQXGWnSdzqYM283OSgJMi10XGPXIrBPMSkI56q/Y8y+Pbf5U
         11QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681501746; x=1684093746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ued8RPGYYYnTKpEa2LQkIv8m2xddx8+vhFWcpImfwlQ=;
        b=RuuB483oz6AlevkcJ0+P+W7QT5QRjl7QVwQ9brb8GxDfV3KLKGOn/bqg3XPBXQ4ZR8
         U62ElWl81vQIjn76Gbuqil0x2wVujBc+oADbFjvCEgz2FQMqWkgfq7WHM/HuMIIOL+cY
         yevRLb626DmosxdFD62IY5njJMMNZP7YZ8NLgt+5s5o2aJeAnr6zuULW24N2e7moG4C0
         OZrrTMLbPzCHAiFn3BYi8ueIfoRNRi2sfmng7GgFa+IMLH1w0qcleFWBezJ7On18xDSR
         Vh6uXcZDcUllhXNb1UoMOJUajBr60yBvpAqe1ux1MbCwOnsiAM3TF6ufEHjdfjk9TP5k
         /NSw==
X-Gm-Message-State: AAQBX9ck+6On3woqvcUyamXkOoAimKtqgamNRb1UWb6v/r8PgQLATNBU
        bn5mVFn+DwNmoR8YHRcrqky9JJLsJ2WisL4FHgB0MA==
X-Google-Smtp-Source: AKy350bcXIOSLr/r2359jbDN5GOP5UXH4qto8PUFwqeUA+xt82gxkvE3IT8IM15dZAvOWwSCO2EtaPkwUH3+8tAqCWI=
X-Received: by 2002:a25:d057:0:b0:b8f:5c64:cc2e with SMTP id
 h84-20020a25d057000000b00b8f5c64cc2emr3418935ybg.12.1681501746075; Fri, 14
 Apr 2023 12:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230414180043.1839745-1-surenb@google.com> <ZDmetaUdmlEz/W8Q@casper.infradead.org>
In-Reply-To: <ZDmetaUdmlEz/W8Q@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 12:48:54 -0700
Message-ID: <CAJuCfpFPNiZmqQPP+K7CAuiFP5qLdd6W9T84VQNdRsN-9ggm1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:43=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wrote:
> > When page fault is handled under VMA lock protection, all swap page
> > faults are retried with mmap_lock because folio_lock_or_retry
> > implementation has to drop and reacquire mmap_lock if folio could
> > not be immediately locked.
> > Instead of retrying all swapped page faults, retry only when folio
> > locking fails.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thank you for the reviews!

>
> Let's just review what can now be handled under the VMA lock instead of
> the mmap_lock, in case somebody knows better than me that it's not safe.
>
>  - We can call migration_entry_wait().  This will wait for PG_locked to
>    become clear (in migration_entry_wait_on_locked()).  As previously
>    discussed offline, I think this is safe to do while holding the VMA
>    locked.
>  - We can call remove_device_exclusive_entry().  That calls
>    folio_lock_or_retry(), which will fail if it can't get the VMA lock.
>  - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody familiar
>    with Nouveau and amdkfd could comment on how safe this is?
>  - I believe we can't call handle_pte_marker() because we exclude UFFD
>    VMAs earlier.
>  - We can call swap_readpage() if we allocate a new folio.  I haven't
>    traced through all this code to tell if it's OK.
>
> So ... I believe this is all OK, but we're definitely now willing to
> wait for I/O from the swap device while holding the VMA lock when we
> weren't before.  And maybe we should make a bigger deal of it in the
> changelog.
>
> And maybe we shouldn't just be failing the folio_lock_or_retry(),
> maybe we should be waiting for the folio lock with the VMA locked.

Wouldn't that cause holding the VMA lock for the duration of swap I/O
(something you said we want to avoid in the previous paragraph) and
effectively undo d065bd810b6d ("mm: retry page fault when blocking on
disk transfer") for VMA locks?

>
