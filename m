Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCD611639
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJ1Pqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJ1Pqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:46:34 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9941E046F;
        Fri, 28 Oct 2022 08:46:33 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id l9so3655901qkk.11;
        Fri, 28 Oct 2022 08:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKQqdCWDDAGGP8gb8rCqO8l0puH1w2x+5jwsSPT3dH8=;
        b=T6KSc//YaVzwvKMk9mK9qFbojevZ2W/a0hrjNZm6T6/X21GdqRDKydTTuvrSdfL3vV
         RXepDFEERtxeaTwjKBUBKF+6gBl4YYaTHBbnrgGgoTKbLSVwpuDSox82iikoflekAHhX
         UpJ4PuGs5DJ2FspMRtlXzsOKvOSM2eaiGf1OHTcvSxEqvWY8qJN57/08xrYybDvWpeob
         0+jLbc+o2WHnuw2g6MCjXMVxizDtYcKKBtZ9AL+k3dkBwjB0rFbo3NnjpSzejrj373xp
         dxRvRrLYLzFUXdwsXyMSPJ6GXRt4pkWUCuZ974C14nWNG9QNOihKhdOyXGDC/IYNXkQb
         42OA==
X-Gm-Message-State: ACrzQf2Q8SKDruRn+YgmWH1oqZ3mEBeYButiCaF+DMkIhXvHza832wPf
        jgzle+pnYXewYS6tcZ+Jzo+zsMJTIA+E8vaHi14=
X-Google-Smtp-Source: AMsMyM7JGKws7/zx7E8lbz506/vh57h5RoEHBHCrQMMQwd1SsZeEo1RWTkguImcsTHuJy2nPGjgsEVR8wAfAV/8Il0M=
X-Received: by 2002:a37:b1c2:0:b0:6fa:1185:4dbf with SMTP id
 a185-20020a37b1c2000000b006fa11854dbfmr138484qkf.764.1666971993053; Fri, 28
 Oct 2022 08:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221019073443.248215-1-chenzhongjin@huawei.com>
In-Reply-To: <20221019073443.248215-1-chenzhongjin@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 17:46:22 +0200
Message-ID: <CAJZ5v0hV2AFEgiuxxbDFUWLa0ZthSz3a=-9U4pjXm-GmmSgexw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix use-after-free in acpi_ps_parse_aml()
To:     Chen Zhongjin <chenzhongjin@huawei.com>, robert.moore@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, rafael.j.wysocki@intel.com, lenb@kernel.org,
        lv.zheng@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 9:38 AM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> KASAN reports a use-after-free problem and causes kernel panic
> triggered by: modprobe acpiphp_ibm
>
> BUG: KASAN:
> use-after-free in acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
> Read of size 8 at addr ffff888002f843f0 by task modprobe/519
>
> CPU: 2 PID: 519 Comm: modprobe Not tainted 6.0.0+
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>     Call Trace:
>     <TASK>
>     acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
>     acpi_ds_method_error (drivers/acpi/acpica/dsmethod.c:232)
>     acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
>     ...
>     </TASK>
>
>     Allocated by task 519:
>     ...
>     __kasan_kmalloc (mm/kasan/common.c:526)
>     acpi_ds_create_walk_state (drivers/acpi/acpica/dswstate.c:519)
>     acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:498)
>     acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
>     ...
>
>     Freed by task 519:
>     ...
>     __kmem_cache_free+0xb6/0x3c0
>     acpi_ds_delete_walk_state (drivers/acpi/acpica/dswstate.c:722)
>     acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:586)
>     acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
>     ...
> ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> In the error path in acpi_ps_parse_aml():
>
>     acpi_ds_call_control_method()
>         acpi_ds_create_walk_state()
>             acpi_ds_push_walk_state()
>             # thread->walk_state_list = walk_state
>
>         acpi_ds_init_aml_walk # *fail*
>         goto cleanup:
>         acpi_ds_delete_walk_state() # ACPI_FREE(walk_state)
>
>     acpi_ds_method_error()
>         acpi_ds_dump_method_stack()
>         # using freed thread->walk_state_list
>
> Briefly, the walk_state is pushed to thread, and freed without being poped.
> Then it is used in acpi_ds_dump_method_stack() and causes use-after-free.
>
> Add acpi_ds_pop_walk_state(thread) to the error path to fix the problem.
>
> Fixes: 0bac4295526c ("ACPICA: Dispatcher: Move stack traversal code to dispatcher")
>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

This should be submitted to the upstream project on GitHub, but it
looks bad enough, so I'll take care of this.

Applied as 6.1-rc material, thanks!

> ---
>  drivers/acpi/acpica/dsmethod.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
> index ae2e768830bf..19da7fc73186 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -581,6 +581,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
>
>         acpi_ds_terminate_control_method(obj_desc, next_walk_state);
>         acpi_ds_delete_walk_state(next_walk_state);
> +       acpi_ds_pop_walk_state(thread);
>
>         return_ACPI_STATUS(status);
>  }
> --

Bob, this looks correct to me, but I may be missing something in which
case please let me know.
