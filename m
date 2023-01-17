Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275866D9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjAQJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjAQJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:27:41 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73221F5EF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:26:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so73823153ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exVmUOS71oVOAqiELfUuXDuaGik6dNbe+Gp7QyuOUb8=;
        b=GpMinRaS96fMLTxeHgP6Jtmqj9EhhkeoXQsvfQH8lrHGiCaqLd72g0fB9soxTwRier
         JlE3/pwdPSu/kOk7S9xJQ83vcthyeqA4CqwB1zRMHvcUCngcYebAClrC2HO3RFGGvhrR
         Q6vQDWVqaVhEwUDFyqWuM8hpLBdfP1YPrglsx0ubhV8Bz02IpG0sEsI8iBYTQawXD12c
         7sqIT9NzVYEvMokLZVa0GEqrYIuo8kGf54k9JY0VfSZdUN+r5j0snoaBNGmJ8RjxbRNa
         ZI2x7Rj2WV3xzIfLu0PYIPsoqr9c97+xP/RgFiiseQpzwH8EB+aF/x9HpAm/hTbpvbxd
         H1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exVmUOS71oVOAqiELfUuXDuaGik6dNbe+Gp7QyuOUb8=;
        b=dodUa8SDE+iz+gkLEZCNUJH3hRGdXNdRA1PoPk9oXFGU50pZzMxDUAudc7JFUhwfpG
         YC2kLNOVhJdWA6IhiMmFH8ASyB+x5nKPkqa+N68/jZzS1bGywOpwRJFoLnxAYhUW9ef3
         K3RJR4xC/jSAHS5CW2dUNgjRLXME9VD37H4zQTT94SmYmf8slBHFDwfz6o1gzeJlDBNr
         rCn4m41td+VDvnACWycdWE1ChulGUFeqWOM9uHMR51oMVYeYOrXX2J5qsxpl1G3A/7Ri
         cv4WsuFUDroG45uvfrGB8MBY2HrxxIGxjyx7PLoaURGWNwBcBvxZ0m7cIGVz0xUl3XLV
         8iyw==
X-Gm-Message-State: AFqh2krG765jisegvcAjyjJV7ZtetA8+me73Y+Qopnee9S9/Uhf2W732
        BVhQUX7LLEGaMxW/9ZNfip8=
X-Google-Smtp-Source: AMrXdXuKr4bAS6tqS2mchJrJpKXUGMsa3MmPkAdloFDHqv0zcLBeA4MsdPSn6XcLDgEVV1Q6TB3V8Q==
X-Received: by 2002:a17:907:c618:b0:868:b2b6:ee71 with SMTP id ud24-20020a170907c61800b00868b2b6ee71mr2275817ejc.6.1673947561671;
        Tue, 17 Jan 2023 01:26:01 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id vo16-20020a170907a81000b0086dc174caf2sm3692018ejc.220.2023.01.17.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:26:01 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Jan 2023 10:25:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, jroedel@suse.de
Subject: Re: [PATCH v2 1/7] x86/boot: Remove verify_cpu() from
 secondary_startup_64()
Message-ID: <Y8ZppgQ3RyzcR8eJ@gmail.com>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.589522290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116143645.589522290@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> The boot trampolines from trampoline_64.S have code flow like:
> 
>   16bit BIOS			SEV-ES				64bit EFI
> 
>   trampoline_start()		sev_es_trampoline_start()	trampoline_start_64()
>     verify_cpu()			  |				|
>   switch_to_protected:    <---------------'				v
>        |							pa_trampoline_compat()
>        v								|
>   startup_32()		<-----------------------------------------------'
>        |
>        v
>   startup_64()
>        |
>        v
>   tr_start() := head_64.S:secondary_startup_64()

oh ... this nice flow chart should move into a prominent C comment I think, 
it's far too good to be forgotten in an Git commit changelog.

> Since AP bringup always goes through the 16bit BIOS path (EFI doesn't
> touch the APs), there is already a verify_cpu() invocation.
> 
> Removing the verify_cpu() invocation from secondary_startup_64()
> renders the whole secondary_startup_64_no_verify() thing moot, so
> remove that too.
> 
> Cc: jroedel@suse.de
> Cc: hpa@zytor.com
> Fixes: e81dc127ef69 ("x86/callthunks: Add call patching for call depth tracking")
> Reported-by: Joan Bruguera <joanbrugueram@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
