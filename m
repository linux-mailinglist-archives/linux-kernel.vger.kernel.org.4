Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23CE663EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjAJLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbjAJLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:00:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2FFDF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:59:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso11496114wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvyggaS9KYFMF7nNkapset70h6IakNY/K5MFtvljeLU=;
        b=KVl77+w5T+h+pSIZ31gOfJhu0GPwnDsw0aWG/eL0OP+tG3+l9uMsZu6C/Jnt/gVJqo
         /3JfKyNachGrpegGR5zkTFqt5fWou3JuASlDX5B+AARAUBptemu4IVp5LLNps8yy8c+6
         u1/YXy9pSz298IIfpsGaQ9QltDsD1pT6hlzUJ5uZvZJRjL1D1LTh0JawFE7Y4rYUpAf9
         xGB+dGYUY0DXE9zqd4t5gIaI9b5NA10ylRct8BZgdHxJLbPDcT5MeQ9xqNNKPn5gfP1h
         jLHMo+G25HL6Vg0SHneEzQb7z1F+N+8T2atadtaiH92vd0NTbn32Y58FHn/MLWB5UEde
         KKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvyggaS9KYFMF7nNkapset70h6IakNY/K5MFtvljeLU=;
        b=bGsPxadvB+67sEXx8nitimQnEFr18sZGrMX3OFE9EsEySQ/9DBSiEv1hXzzoc5zd5f
         LMCD9wNJZGQGOW5LMDeIIzhTbIWNHDGEMEYQhf4tI0aFxr3E1puBx+Oa9bdv71+QEQUc
         HGzACKbLaa/3uONrHtkedjJ5mxqHZKo1eMQB9pdHkV45DdHCUlpVUAKhnBROS0ju4eQI
         JTL7r2TQhqRMva1jydFoR60DaQnSk4VsPOJW0+iFpR+GKqVIF/aRqRtGo8zEgBgjXdNE
         fm+3ZMvWXRFeupe7QY+TG3FjLxnJ1n3XwpBiBBTcOHmkF+q4WMg8ybhG+n0sV06G6QjC
         goQw==
X-Gm-Message-State: AFqh2kp0MJ5dmz7ujmtvF0AdJVhiOXJBVUJthJrqdZlaZiTtN/kbQIhA
        I4rDuvBWMzAkg+vbZQKjjXU=
X-Google-Smtp-Source: AMrXdXuttcKnbaO8ScUi+dScwNd/A7NKxR1L+bFkTFDgTLg8H/ewvC0e4EaNviBISkPhHZg5dAMHLA==
X-Received: by 2002:a05:600c:348b:b0:3d1:f16b:30e6 with SMTP id a11-20020a05600c348b00b003d1f16b30e6mr49201016wmq.28.1673348394809;
        Tue, 10 Jan 2023 02:59:54 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003cf71b1f66csm16546191wms.0.2023.01.10.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:59:54 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Jan 2023 11:59:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     michael.roth@amd.com, bp@alien8.de, hpa@zytor.com,
        tglx@linutronix.de, sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, brijesh.singh@amd.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, liwei391@huawei.com
Subject: Re: [PATCH] x86/boot/compressed: Register NMI handler in EFI boot
 loader
Message-ID: <Y71FJ+G0NGQe3Ppq@gmail.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110102745.2514694-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zeng Heng <zengheng4@huawei.com> wrote:

> +void do_boot_nmi_fault(struct pt_regs *regs, unsigned long error_code)
> +{
> +	/* ignore */
> +}
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index 6debb816e83d..b169c9728d52 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -60,6 +60,7 @@ void load_stage2_idt(void)
>  {
>  	boot_idt_desc.address = (unsigned long)boot_idt;
>  
> +	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
>  	set_idt_entry(X86_TRAP_PF, boot_page_fault);

So it's a bit sad to install a dummy handler that does nothing, while 
something clearly sent an NMI and expects an intelligent reaction - OTOH 
the unexpected NMIs from from watchdog during a kdump clearly make things 
worse by crashing the bootup.

Anyway, I cannot think of a better response here that the boot loading code 
could do either, so I've applied your fix to tip:x86/boot.

Thanks,

	Ingo
