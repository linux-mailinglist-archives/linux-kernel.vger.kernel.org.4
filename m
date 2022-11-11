Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD9625020
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKKC0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiKKC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371D6239F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668133532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WaG6D9NPul5lwMcNCuIe3sGhugQZUKvnrKFJmGoro3c=;
        b=PWTZZynKGvfUR+JqAZVPOYCA2ZWbXYR3k49Prqqfk4ZoNFNUmD+lz54BXhMMCezCS6Cb69
        pBcffh+pcDKt1wpNpRgvUns8fT7jSGgCdRZDHhfJNBa34AhNJEAvmPp6ytexH0GSEsgVxa
        qeTLvdloFXhwus9Nks8QNylQy/L0bGk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-zK5Lo7vZOqSgW1IuKs0uEw-1; Thu, 10 Nov 2022 21:25:30 -0500
X-MC-Unique: zK5Lo7vZOqSgW1IuKs0uEw-1
Received: by mail-pg1-f197.google.com with SMTP id v18-20020a637a12000000b0046ed84b94efso1904111pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaG6D9NPul5lwMcNCuIe3sGhugQZUKvnrKFJmGoro3c=;
        b=lh65CwAx5WaS/dQPI/UD9WjJj8ASO9XJ8SkOeLPkgS9XexyoMJWpjF8xHoIxwkJ29v
         YaPUnAsU/gNtSZ0a1AWbrwuD4AZ/sRszNNJ9f8o6t5Wxi3yWjXazPpE2LsBgbl3yk9Zm
         4Ef6b6OwazfMMXnR0vbXLm8w4vIInsg9elJKRHqbMAyRbbedUxvEyUqNbmW/MH3nYluN
         MdVG6Gn88o8OvTB/LkUcVn/YnuNhekeqGvltHRYd7gTOnoq/FDQwT/Jisqb7jaEFftu5
         lnK20Ob6Obzr82Ps4z1lH3myPrG3TEUqd6fMmobNBDXWPRWa2o9jzI71HiDIZVvWWabc
         18QQ==
X-Gm-Message-State: ANoB5pl2xl2CYvC+TsRwAUitV6O4QlLfPsIwDYSm9sIsnCjR+zs9TmgA
        i/IAcAwsQ9a/t8uVFCCuM6U57kZaNhEf+G56g7mrHEs/sn8Zz6BLkUh4X8zzF4VfI61j2ggpCRV
        UnKcZ7GBJ4e/YO11qiLJHkDld
X-Received: by 2002:a17:902:f811:b0:187:19c4:373a with SMTP id ix17-20020a170902f81100b0018719c4373amr321314plb.163.1668133529853;
        Thu, 10 Nov 2022 18:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JE5CicYQ2l/VDcgKu1A3Opx/g/1lm/7vpkfRaW5I/+bVsxwi+MrsKOPNQCArSCBYFvx9qNQ==
X-Received: by 2002:a17:902:f811:b0:187:19c4:373a with SMTP id ix17-20020a170902f81100b0018719c4373amr321304plb.163.1668133529575;
        Thu, 10 Nov 2022 18:25:29 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm358845plk.238.2022.11.10.18.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:25:28 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:21:43 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, nasastry@in.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <20221111022143.xvpi3pfwwrw4qda2@Rk>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220901214610.768645-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Could the PowerPC tree take this patch set which resolves a
PowerVM/KVM-specific issue?

On Thu, Sep 01, 2022 at 05:46:06PM -0400, Stefan Berger wrote:
>The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
>vTPM 2.0 measurement logs across a kexec on PowerVM and PowerKVM. This
>series fixes this for the kexec_file_load() syscall using the flattened
>device tree (fdt) to carry the TPM measurement log's buffer across kexec.
>
>   Stefan
>
>v8:
> - Added Jarkko's, Coiby's, and Rob's tags
> - Rebase on v6.0-rc3 that absorbed 2 already upstreamed patches
>
>v7:
> - Added Nageswara's Tested-by tags
> - Added back original comment to inline function and removed Jarkko's R-b tag
>
>v6:
> - Add __init to get_kexec_buffer as suggested by Jonathan
> - Fixed issue detected by kernel test robot
>
>v5:
> - Rebased on 1 more patch that would otherwise create merge conflicts
>
>v4:
> - Rebased on 2 patches that would otherwise create merge conflicts;
>   posting these patches in this series with several tags removed so
>   krobot can test the series already
> - Changes to individual patches documented in patch descripitons
>
>v3:
> - Moved TPM Open Firmware related function to drivers/char/tpm/eventlog/tpm_of.c
>
>v2:
> - rearranged patches
> - fixed compilation issues for x86
>
>Palmer Dabbelt (1):
>  drivers: of: kexec ima: Support 32-bit platforms
>
>Stefan Berger (3):
>  tpm: of: Make of-tree specific function commonly available
>  of: kexec: Refactor IMA buffer related functions to make them reusable
>  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
>
> drivers/char/tpm/eventlog/of.c |  31 +--
> drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
> include/linux/kexec.h          |   6 +
> include/linux/of.h             |   9 +-
> include/linux/tpm.h            |  36 ++++
> kernel/kexec_file.c            |   6 +
> 6 files changed, 346 insertions(+), 78 deletions(-)
>
>
>base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
>-- 
>2.35.1
>

-- 
Best regards,
Coiby

