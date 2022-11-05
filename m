Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08AE61A6A5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKEBdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiKEBdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:33:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20963FBAC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:33:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g12so9591988lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLjZmA04cO7CyEtDE5CIymPs3G5llSHxY5wJX/7cOtE=;
        b=DN3w/DtmfzpE/9PbDBO2EGwHLRF83DAaeukGGd+ZNpqp2MSWkDSOBCZfKZrmh3+7Um
         YL0t4kN/+a2vu4mQr0Vs7QH+N3df/SHKOsqxEliuQkz97lssxXdgW0RIsk45su/fH0uV
         6kFXZn6h8j0zDSc7TZAD/rlRhqykv8OuliYgpwd0DGzi+9aS99IqdDEpHQa6GJm3uWNX
         wgBOovjMCdUrUMxt9s6lxEonr+vBvnbFO0yQxXXcATK9mslq6fNcD8RkCgGBYN4zyZqM
         KkfNKDtuGhicZii+jh7lDERcuclkX4NhmoHtM0d+qEye30RHsHnRz/Y48HMqZoiHjX2q
         D3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLjZmA04cO7CyEtDE5CIymPs3G5llSHxY5wJX/7cOtE=;
        b=cMugUnL8C42tXdfD0LIJgPvFY5LG5puSS427AWNHrt/vnWe71qGhnjV9zsfvzxKGcD
         9/ZIyCNEtlxLWYkK7Y49vZJBHpR+djIyJSRf2JSA8Q3OWHExF/OUEVlWXwWKByErjMBg
         ds50EUpQivzxcf6WqChOdY+jO3fn306MYvGlVoRbe3kzofxfW/OPo9r06pUKHECjZwFz
         7X0LaNJIWubaIAOK54XzhKIxfLM2aBk5xhWAf5Be4k6Nc/iUB5SKg6NhOiYGjtKAvBg6
         GOKATl93i/BUOqnhh8dtEwBxGxqP+HBKm+f1bhKFjvbyPolve0Z7RzlL/oHnUWlFDt6b
         oLfw==
X-Gm-Message-State: ACrzQf1awQu5TEpGuw5UaYhRbD8cwgymIsMRKkEs0sKIwJhkDh1OJic9
        AxOreQ//z6V8QrfYvN2OO4m0RhDOrJ1LfDauIq5WbQ==
X-Google-Smtp-Source: AMsMyM5m+4FsN5673Xbksie1Vx5PskCWrFHP9iJ4Z1oHa1pMh0J7gDD09lFVdMgjIHmg/pFrNH/WK6+HaFsiBInVB6I=
X-Received: by 2002:a05:6512:138d:b0:4ae:5116:8ddb with SMTP id
 p13-20020a056512138d00b004ae51168ddbmr15300899lfa.558.1667612014965; Fri, 04
 Nov 2022 18:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com> <20221104230040.2346862-4-dionnaglaze@google.com>
In-Reply-To: <20221104230040.2346862-4-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Nov 2022 19:33:23 -0600
Message-ID: <CAMkAt6pqBoLguQiZMXgAY3H+wUj4WE5jkWZchLWWK9Sg33BfMA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] virt: sev-guest: Remove err in handle_guest_request
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Haowen Bai <baihaowen@meizu.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 5:01 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The err variable may not be set in the call to snp_issue_guest_request,
> yet it is unconditionally written back to fw_err if fw_err is non-null.
> This is undefined behavior, and currently returns uninitialized kernel
> stack memory to user space.
>
> The fw_err argument is better to just pass through to
> snp_issue_guest_request, so we do that by passing along the ioctl
> argument. This removes the need for an argument to handle_guest_request.
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
>
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
