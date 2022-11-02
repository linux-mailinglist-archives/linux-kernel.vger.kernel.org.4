Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5B616D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKBTJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiKBTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:08:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A5D1263E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:08:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q71so17044174pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btNV1F5raSfgVHS1/gKMO9RappBFKUG6No8ZOPbnTjE=;
        b=WnF/CAavVaQFZ6hu1mucTiUFMFRH07YS8pP+nQhN6HJJeWng0qN/pqcGUZWF8DF3YJ
         UKrrhCuT8pZe5efQKDQYbL4sl4O0d0Yq7dniUij9mlyoue48MfGSkAiZceOt6LH7Zyla
         DMmq4Zy98pWpB2nYorJEhV8afi41FbMNfLd98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btNV1F5raSfgVHS1/gKMO9RappBFKUG6No8ZOPbnTjE=;
        b=fa7kgKdjaKOt/iggVfGHnBaB5kl+k3zQ9f/Z+GLK6kHSV1HTn7zoX/Fk/RZwz4sL2o
         a0R8bGiXs+fD5AlhmTzhOYMUo8CWJn4a42EgE6Z+LchA9ILo+msbdAPoYSFdgv52F2fS
         AuXe4jNzaJ13SeyoDsh4PXEbm7v3poUNOkkRZy9eFPpom/ZRYsFpPW9voQDwhNzTjW6H
         VPGGp4govbrGnOXF1AwG8hfL2s4LDAaQITrUuBzhRHwjlL7csQ6SA37Jz0M96Chvz0NX
         xRfKO0PIeEF8fMGE/msynPosjmRziGU1s1scBxSDghB+SwrNQpLEG5Ba0XpdVFDxa53W
         FoVA==
X-Gm-Message-State: ACrzQf2xVUsuu3rk4CDrj4ox8Yz5HpqIVDcY1KNbSzsfrqgz7+EW5Rk5
        Mr7EdFaTmhCYCxBSGfA56IDW1g7injzULw==
X-Google-Smtp-Source: AMsMyM50I03PG/OQ4Z3UbjQlDLWWsbg4/BuY9JFwssVj3kEUSn2BZVgoliMdNU8wDNVwlvCFhiI/zg==
X-Received: by 2002:a63:501f:0:b0:46f:a711:c455 with SMTP id e31-20020a63501f000000b0046fa711c455mr18062893pgb.402.1667416111214;
        Wed, 02 Nov 2022 12:08:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v20-20020a63f214000000b0045ff216a0casm4784265pgh.3.2022.11.02.12.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:08:30 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:08:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] scsi: elx: libefc: Fix second parameter type in state
 callbacks
Message-ID: <202211021208.055D396D8E@keescook>
References: <20221102161906.2781508-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102161906.2781508-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:19:06AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/scsi/elx/libefc/efc_node.c:811:22: error: incompatible function pointer types assigning to 'void (*)(struct efc_sm_ctx *, u32, void *)' (aka 'void (*)(struct efc_sm_ctx *, unsigned int, void *)') from 'void (*)(struct efc_sm_ctx *, enum efc_sm_event, void *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>                   ctx->current_state = state;
>                                     ^ ~~~~~
>   drivers/scsi/elx/libefc/efc_node.c:878:21: error: incompatible function pointer types assigning to 'void (*)(struct efc_sm_ctx *, u32, void *)' (aka 'void (*)(struct efc_sm_ctx *, unsigned int, void *)') from 'void (*)(struct efc_sm_ctx *, enum efc_sm_event, void *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           node->nodedb_state = state;
>                             ^ ~~~~~
>   drivers/scsi/elx/libefc/efc_node.c:905:6: error: incompatible function pointer types assigning to 'void (*)(struct efc_sm_ctx *, enum efc_sm_event, void *)' from 'void (*)(struct efc_sm_ctx *, u32, void *)' (aka 'void (*)(struct efc_sm_ctx *, unsigned int, void *)') [-Werror,-Wincompatible-function-pointer-types-strict]
>                   pf = node->nodedb_state;
>                     ^ ~~~~~~~~~~~~~~~~~~
> 
>   drivers/scsi/elx/libefc/efc_device.c:455:22: error: incompatible function pointer types assigning to 'void (*)(struct efc_sm_ctx *, u32, void *)' (aka 'void (*)(struct efc_sm_ctx *, unsigned int, void *)') from 'void (struct efc_sm_ctx *, enum efc_sm_event, void *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>                   node->nodedb_state = __efc_d_init;
>                                     ^ ~~~~~~~~~~~~
> 
>   drivers/scsi/elx/libefc/efc_sm.c:41:22: error: incompatible function pointer types assigning to 'void (*)(struct efc_sm_ctx *, u32, void *)' (aka 'void (*)(struct efc_sm_ctx *, unsigned int, void *)') from 'void (*)(struct efc_sm_ctx *, enum efc_sm_event, void *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>                   ctx->current_state = state;
>                                     ^ ~~~~~
> 
> The type of the second parameter in the prototypes of ->current_state()
> and ->nodedb_state() ('u32') does not match the implementations, which
> have a second parameter type of 'enum efc_sm_event'. Update the
> prototypes to have the correct second parameter type, clearing up all
> the warnings and CFI failures.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
