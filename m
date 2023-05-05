Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C26F8CC1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjEEXUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjEEXUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:20:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE9F6A7E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:20:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efea87c578so20821e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683328831; x=1685920831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ner33wytaL924J/VZH8Oe/UDFZDEXhP0N8Fc46FnO1w=;
        b=q1yXk0sofT7Yy7hK8klAd1WMPn4xVVVyoHnXrzaRbuWiDl++uEScqiDioXKtDBySo2
         mRbUUWDeNEUlb8exXuHQp/4ue7gH5kDa8F4X1F42FyA2uDCZE0DXNZHHuxdpl0tvD7kt
         pjl9sIAAJhX+25HpyNpmw0/xD89CzvCBEQ4asLSfdU+/vxa6v3L/WLDZnBUqOAA7oz6n
         P+NoK9Fp8ihTjq0vLRQWlA29XnXquPROeX9V2HkDBtvV0HJFLAHw/L+mnFXjjtki7rRB
         GaTAPAZWhvF73AfuI8SPPC7h+rMAsgO3DwPBvWUV3HREeoyoE0XTJ8UEMVgX7SpYwTYL
         ly8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683328831; x=1685920831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ner33wytaL924J/VZH8Oe/UDFZDEXhP0N8Fc46FnO1w=;
        b=IrDoaKD5u3b1Sl0+jyI39+RIg5hth+PM/wV1rI4iXsAIDvfOYe3/IuxRL1eH6QYdmm
         ipDHA9yN7nF9Skmy11JVODAL5nWX7tUKLTYqQD1KjokkxPaEwP9KRfSFzDR8hIXebZXu
         9BHgcKLYw2fI6cf2uXM218uy5Wbnjye/Y0480YjGyoPefEDtsgbX4mSLRhh17WIXmh51
         DlxwfT/9qz3o+ymw6XI04KjYMOMdxkS2hqInD5cXBdAPCgfIjxr4oD+M+BCtm1CO1piJ
         7DEkaK94J0E5mAk49UpUw4FF4dWoBBtk0l0kkdPEw18Y69a/Vle0L0eoAhrJ+SlJczny
         1XoQ==
X-Gm-Message-State: AC+VfDyTQXXI8GzUYuDoxtV0CxEJrRD8/DkSPcf7sWjAX5ODkDPABzlL
        KOSMXjZjfDVNGJkKAOYlcX0f5YY9SeAjkiUKzxlu9Q==
X-Google-Smtp-Source: ACHHUZ6LM3worRhHcXnGFdzEtUxhiUXJYRZlJMZaC+j7T/2ptoRuXp1VsGyuwKVMt0gPVSuVDHWUyDA/CLCSSXLa8kc=
X-Received: by 2002:a05:6512:3598:b0:4f1:4726:7574 with SMTP id
 m24-20020a056512359800b004f147267574mr31235lfr.5.1683328831204; Fri, 05 May
 2023 16:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230505064811.2982849-1-cmllamas@google.com> <20230505203020.4101154-1-cmllamas@google.com>
In-Reply-To: <20230505203020.4101154-1-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 5 May 2023 16:20:18 -0700
Message-ID: <CAHRSSEx61=PVXRG90zVsV4W6KNNqmu_nr1TE5X+Gm7dFtuHXsw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix UAF caused by faulty buffer cleanup
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Zi Fan Tan <zifantan@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 1:30=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> In binder_transaction_buffer_release() the 'failed_at' offset indicates
> the number of objects to clean up. However, this function was changed by
> commit 44d8047f1d87 ("binder: use standard functions to allocate fds"),
> to release all the objects in the buffer when 'failed_at' is zero.
>
> This introduced an issue when a transaction buffer is released without
> any objects having been processed so far. In this case, 'failed_at' is
> indeed zero yet it is misinterpreted as releasing the entire buffer.
>
> This leads to use-after-free errors where nodes are incorrectly freed
> and subsequently accessed. Such is the case in the following KASAN
> report:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in binder_thread_read+0xc40/0x1f30
>   Read of size 8 at addr ffff4faf037cfc58 by task poc/474
>
>   CPU: 6 PID: 474 Comm: poc Not tainted 6.3.0-12570-g7df047b3f0aa #5
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    dump_backtrace+0x94/0xec
>    show_stack+0x18/0x24
>    dump_stack_lvl+0x48/0x60
>    print_report+0xf8/0x5b8
>    kasan_report+0xb8/0xfc
>    __asan_load8+0x9c/0xb8
>    binder_thread_read+0xc40/0x1f30
>    binder_ioctl+0xd9c/0x1768
>    __arm64_sys_ioctl+0xd4/0x118
>    invoke_syscall+0x60/0x188
>   [...]
>
>   Allocated by task 474:
>    kasan_save_stack+0x3c/0x64
>    kasan_set_track+0x2c/0x40
>    kasan_save_alloc_info+0x24/0x34
>    __kasan_kmalloc+0xb8/0xbc
>    kmalloc_trace+0x48/0x5c
>    binder_new_node+0x3c/0x3a4
>    binder_transaction+0x2b58/0x36f0
>    binder_thread_write+0x8e0/0x1b78
>    binder_ioctl+0x14a0/0x1768
>    __arm64_sys_ioctl+0xd4/0x118
>    invoke_syscall+0x60/0x188
>   [...]
>
>   Freed by task 475:
>    kasan_save_stack+0x3c/0x64
>    kasan_set_track+0x2c/0x40
>    kasan_save_free_info+0x38/0x5c
>    __kasan_slab_free+0xe8/0x154
>    __kmem_cache_free+0x128/0x2bc
>    kfree+0x58/0x70
>    binder_dec_node_tmpref+0x178/0x1fc
>    binder_transaction_buffer_release+0x430/0x628
>    binder_transaction+0x1954/0x36f0
>    binder_thread_write+0x8e0/0x1b78
>    binder_ioctl+0x14a0/0x1768
>    __arm64_sys_ioctl+0xd4/0x118
>    invoke_syscall+0x60/0x188
>   [...]
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In order to avoid these issues, let's always calculate the intended
> 'failed_at' offset beforehand. This is renamed and wrapped in a helper
> function to make it clear and convenient.
>
> Fixes: 32e9f56a96d8 ("binder: don't detect sender/target during buffer cl=
eanup")
> Reported-by: Zi Fan Tan <zifantan@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
> v2: rename 'failed_at' to 'off_end_offsets' and drop the now unecessary
>     comments after the rename per Todd's feedback.
>
>  drivers/android/binder.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index fb56bfc45096..8fb7672021ee 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1934,24 +1934,23 @@ static void binder_deferred_fd_close(int fd)
>  static void binder_transaction_buffer_release(struct binder_proc *proc,
>                                               struct binder_thread *threa=
d,
>                                               struct binder_buffer *buffe=
r,
> -                                             binder_size_t failed_at,
> +                                             binder_size_t off_end_offse=
t,
>                                               bool is_failure)
>  {
>         int debug_id =3D buffer->debug_id;
> -       binder_size_t off_start_offset, buffer_offset, off_end_offset;
> +       binder_size_t off_start_offset, buffer_offset;
>
>         binder_debug(BINDER_DEBUG_TRANSACTION,
>                      "%d buffer release %d, size %zd-%zd, failed at %llx\=
n",
>                      proc->pid, buffer->debug_id,
>                      buffer->data_size, buffer->offsets_size,
> -                    (unsigned long long)failed_at);
> +                    (unsigned long long)off_end_offset);
>
>         if (buffer->target_node)
>                 binder_dec_node(buffer->target_node, 1, 0);
>
>         off_start_offset =3D ALIGN(buffer->data_size, sizeof(void *));
> -       off_end_offset =3D is_failure && failed_at ? failed_at :
> -                               off_start_offset + buffer->offsets_size;
> +
>         for (buffer_offset =3D off_start_offset; buffer_offset < off_end_=
offset;
>              buffer_offset +=3D sizeof(binder_size_t)) {
>                 struct binder_object_header *hdr;
> @@ -2111,6 +2110,21 @@ static void binder_transaction_buffer_release(stru=
ct binder_proc *proc,
>         }
>  }
>
> +/* Clean up all the objects in the buffer */
> +static inline void binder_release_entire_buffer(struct binder_proc *proc=
,
> +                                               struct binder_thread *thr=
ead,
> +                                               struct binder_buffer *buf=
fer,
> +                                               bool is_failure)
> +{
> +       binder_size_t off_end_offset;
> +
> +       off_end_offset =3D ALIGN(buffer->data_size, sizeof(void *));
> +       off_end_offset +=3D buffer->offsets_size;
> +
> +       binder_transaction_buffer_release(proc, thread, buffer,
> +                                         off_end_offset, is_failure);
> +}
> +
>  static int binder_translate_binder(struct flat_binder_object *fp,
>                                    struct binder_transaction *t,
>                                    struct binder_thread *thread)
> @@ -2806,7 +2820,7 @@ static int binder_proc_transaction(struct binder_tr=
ansaction *t,
>                 t_outdated->buffer =3D NULL;
>                 buffer->transaction =3D NULL;
>                 trace_binder_transaction_update_buffer_release(buffer);
> -               binder_transaction_buffer_release(proc, NULL, buffer, 0, =
0);
> +               binder_release_entire_buffer(proc, NULL, buffer, false);
>                 binder_alloc_free_buf(&proc->alloc, buffer);
>                 kfree(t_outdated);
>                 binder_stats_deleted(BINDER_STAT_TRANSACTION);
> @@ -3775,7 +3789,7 @@ binder_free_buf(struct binder_proc *proc,
>                 binder_node_inner_unlock(buf_node);
>         }
>         trace_binder_transaction_buffer_release(buffer);
> -       binder_transaction_buffer_release(proc, thread, buffer, 0, is_fai=
lure);
> +       binder_release_entire_buffer(proc, thread, buffer, is_failure);
>         binder_alloc_free_buf(&proc->alloc, buffer);
>  }
>
> --
> 2.40.1.521.gf1e218fcd8-goog
>
