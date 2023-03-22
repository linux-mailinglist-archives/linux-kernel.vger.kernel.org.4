Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7906C5807
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCVUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCVUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:46:15 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F765C9D5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:42:22 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i19so10544899ila.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679517742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeLzAkC8ofe4r03oiTnUMuqRyEUnaMbKdmxdI/cMXiM=;
        b=kqhsjOaIgYeqkmaxknXrou/E9CAWLLXCWtke8nsMd+V+dAl8Ga7iynfXqBHTcRVMLF
         zLiOHRlLUHVULCL+pKdRDQ2qoJnga+m+BrogLYKkZ7JpHIg4qOwtY8UQR4Fkg1i/Ct4O
         UlKS3TeJhDOTfy9v1vVyHjn05NVO6hmcPAj/WLe08+vavEqYhAdZ3frgHvAwvHzMa5C7
         ch1CE72tMkDsQOScDRmZyqj1JaTc1fjB1GyGwOE9Y3QRU0F8SCxgycpIiAgaQAKxPPug
         xjeGyOIuX8JcCMJ9dpeBdsU5+obmhYIz4If+Vdv4GY5+HmVG+hA3aUq3d03iul6mCcJU
         PjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679517742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeLzAkC8ofe4r03oiTnUMuqRyEUnaMbKdmxdI/cMXiM=;
        b=JHp0ohnH9BfcPqEdZTkalRfGMumvZJckxRSGQswuyyxDWC4EpeZcDfmdCE2mwfNd+m
         98BJ+4DlH0yHISeVxzHSKZ2oCFKVW1bN9Ea/IO2hX5PIWDQmtHxvLXQ/JBs0jkWH6FJY
         jaWIs7sl8+UzYsF1CtqZRcTOKEQXOUeNpZ3Iub9aJkcrPwsnUGRZAqJz1V4N0vgoMDrz
         IfS8Vwqp060Rm7OCBrgfMn7VQJik+h1/gyOBDz+5mhOa5ywUDncZ32FYH/PQtOXf4ZzT
         TpoelyHS/8twoQIhRB+4MJd+JFxly2pulTdEVyGyMXumD7JM3aUQX5FlcUDxd/Kd9aCs
         VZIg==
X-Gm-Message-State: AO0yUKWnWpMvKLoLIUdGM+iHOulvx55mdNAmHOqQKEMEhUXoRD27WYzY
        7ljOH+kpE74AuIujIkt54saW1F3g4EONU2KaO9+d0w==
X-Google-Smtp-Source: AK7set/06aJHdEyDBbceHYokSH5vndvb5S1yTg7EcEj+8vu430ajLvdUnVHF0SntvV7+l8P8X7HezQ==
X-Received: by 2002:a92:d102:0:b0:325:bc3f:f760 with SMTP id a2-20020a92d102000000b00325bc3ff760mr2290215ilb.0.1679517741531;
        Wed, 22 Mar 2023 13:42:21 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7419:4945:3325:dd1e])
        by smtp.gmail.com with ESMTPSA id y16-20020a027310000000b004061d6abcd1sm5274857jab.162.2023.03.22.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:42:21 -0700 (PDT)
Date:   Wed, 22 Mar 2023 14:42:17 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
Message-ID: <20230322204217.GA3076000@google.com>
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:09:21PM +0100, Ricardo Ribalda wrote:
> Clang16 links the purgatory text in two sections:
> 
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>        00000000000011a1  0000000000000000  AX       0     0     16
>   [ 2] .rela.text        RELA             0000000000000000  00003498
>        0000000000000648  0000000000000018   I      24     1     8
>   ...
>   [17] .text.hot.        PROGBITS         0000000000000000  00003220
>        000000000000020b  0000000000000000  AX       0     0     1
>   [18] .rela.text.hot.   RELA             0000000000000000  00004428
>        0000000000000078  0000000000000018   I      24    17     8
> 
> And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> area pointed by `e_entry`.
> 
> This causes that image->start is calculated twice, once for .text and
> another time for .text.hot. The second calculation leaves image->start
> in a random location.
> 
> Because of this, the system crashes inmediatly after:
> 
> kexec_core: Starting new kernel
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>

> ---
> kexec: Fix kexec_file_load for llvm16
> 
> When upreving llvm I realised that kexec stopped working on my test
> platform. This patch fixes it.
> 
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v3:
> - Fix initial value. Thanks Ross!
> - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> 
> Changes in v2:
> - Fix if condition. Thanks Steven!.
> - Update Philipp email. Thanks Baoquan.
> - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
> ---
>  kernel/kexec_file.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1a0e4e3fb5c..25a37d8f113a 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		}
>  
>  		offset = ALIGN(offset, align);
> +
> +		/*
> +		 * Check if the segment contains the entry point, if so,
> +		 * calculate the value of image->start based on it.
> +		 * If the compiler has produced more than one .text sections
> +		 * (Eg: .text.hot), they are generally after the main .text
> +		 * section, and they shall not be used to calculate
> +		 * image->start. So do not re-calculate image->start if it
> +		 * is not set to the initial value.
> +		 */
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -					 + sechdrs[i].sh_size)) {
> +					 + sechdrs[i].sh_size) &&
> +		    kbuf->image->start == pi->ehdr->e_entry) {
>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
>  		}
> 
> ---
> base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> change-id: 20230321-kexec_clang16-4510c23d129c
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
