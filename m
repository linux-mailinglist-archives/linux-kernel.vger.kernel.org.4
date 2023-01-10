Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC88D66422D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjAJNqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbjAJNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:46:11 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2BD1208A;
        Tue, 10 Jan 2023 05:46:08 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id v6so17570658edd.6;
        Tue, 10 Jan 2023 05:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NZqRJmnFIorDTrRXJ2YTmVjJ4mNfBULNZqJURGRWr0=;
        b=hz8+vzsPIFVkBm2vOhleaHvMcMnaoebdFEXW+yT5sH8FPyQr5E94+etyfrzM25TSdb
         4Y++SsYTfu306QxlZQgLBkv23u90YD8jG+w9zSd/9mVtzI03VdP/4JS0lrhz2GBcL/PB
         EZoyglkeUhiD/Avzmrst5LB5YbUy/oxYd41TXZv9YEqCGF1gcAx8f52U1sMAQ/nE4XBC
         pqNRkiQ7vdAQ68OBe/mbdaxLFDDGqrvrJF27Q1m0tfx8Au8urcGAcEqB7CXOYobnakC3
         6lNpDI63MFZBF734qiQfEhT2QiQ48lCQNoWHyAz6qO05P7TKK1QQFulV37LCBjZKWjt8
         3v+Q==
X-Gm-Message-State: AFqh2kro/5C1/piZG30WMbYQuhlFjlYzozd7Xf2g0PtlQfsaydRb4u9w
        +dhOEwWdj0M3AAsjKiILWvjs1GZf17rsmelIHwKUKRQ1
X-Google-Smtp-Source: AMrXdXsOKU/xHupfJ/bcMMWqOE/KsPdBWdUzkTeIFGcbIxnUfsBXWg1gFvncYzUxE5LqD3vOAaqhCNK6H2GtXAXJ6gc=
X-Received: by 2002:a05:6402:298b:b0:47f:7465:6e76 with SMTP id
 eq11-20020a056402298b00b0047f74656e76mr6434814edb.181.1673358366989; Tue, 10
 Jan 2023 05:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20230109135828.879136-1-mark.rutland@arm.com> <20230109135828.879136-3-mark.rutland@arm.com>
In-Reply-To: <20230109135828.879136-3-mark.rutland@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 14:45:55 +0100
Message-ID: <CAJZ5v0hMLRPqMOBjbJ9AFbBQ00TJ7VyntnXwBJqtuSw6FsHaxg@mail.gmail.com>
Subject: Re: [PATCH 2/8] ACPI: Don't build ACPICA with '-Os'
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>, catalin.marinas@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        peterz@infradead.org, revest@chromium.org, rostedt@goodmis.org,
        will@kernel.org
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

On Mon, Jan 9, 2023 at 2:58 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> The ACPICA code has been built with '-Os' since the beginning of git
> history, though there's no explanatory comment as to why.
>
> This is unfortunate as building with '-Os' overrides -falign-functions,
> which prevents CONFIG_FUNCITON_ALIGNMENT and
> CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B from having their expected effect
> on the ACPICA code. This is doubly unfortunate as in subsequent patches
> arm64 will depend upon CONFIG_FUNCTION_ALIGNMENT for its ftrace
> implementation.
>
> Drop the '-Os' flag when building the ACPICA code. With this removed,
> the code builds cleanly and works correctly in testing so far.

Fair enough.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please feel free to route this through the arch tree along with
the rest of the series.

Thanks!

> I've tested this by selecting CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
> building and booting a kernel using ACPI, and looking for misaligned
> text symbols:
>
> * arm64:
>
>   Before:
>     #  grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
>     908
>     #  grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
>     576
>
>   After:
>     # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
>     322
>     # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
>     0
>
> * x86_64:
>
>   Before:
>     # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
>     2057
>     # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
>     706
>
>   After:
>     # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
>     1351
>     # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
>     0
>
> With the patch applied, the remaining unaligned text labels are a
> combination of static call trampolines and labels in assembly, which
> will be dealt with in subsequent patches.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florent Revest <revest@chromium.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/acpica/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index 9e0d95d76fff7..30f3fc13c29d1 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for ACPICA Core interpreter
>  #
>
> -ccflags-y                      := -Os -D_LINUX -DBUILDING_ACPICA
> +ccflags-y                      := -D_LINUX -DBUILDING_ACPICA
>  ccflags-$(CONFIG_ACPI_DEBUG)   += -DACPI_DEBUG_OUTPUT
>
>  # use acpi.o to put all files here into acpi.o modparam namespace
> --
> 2.30.2
>
