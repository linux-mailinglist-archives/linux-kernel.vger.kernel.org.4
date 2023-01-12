Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F056671D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjALMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjALMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:13:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D11BBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:13:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c17so26516555edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rMbanEkiTZXC1SYY43oQzK0GtyNp4kNyLJCdJ4ttVo=;
        b=gb5LoMjBQ178DQnDa/b1ZWJaBlHi0qZhKJj2U5qZ1UwJQ/ywGgeNJ9AEsudC7FEXOy
         NxRY0bI1kPoUmutRRPZhVKVOJvbkkuFPL68E0j790LNh1zoIRSRrBIycl1FghYWxvj1s
         Vkeh3ixBUA2q6BRVm/qyE13r4cbaqQCWAQohQyjniA9eNthZ/FPld5ApwkMbf/s0BzAK
         OobIOnmfzzU+7XWasHTyQY477ccEs7j3CY74SiEjiueMbSXPO1LXQqV7PejOG+CJPE+9
         2Uo99cPk87sQ+JvKS47bhqb3aEsnvOCT8g/e00MiXqu4MpX8ufGSFC8+YoE6oJIjXBXx
         Vk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rMbanEkiTZXC1SYY43oQzK0GtyNp4kNyLJCdJ4ttVo=;
        b=fHeCiCLNh4M9yitJmdKrJQeNbV6NGaNbWp+MtBD+9BZxNZ5Nwl4BJo95Nj04IE+C4n
         E9oulFL4Ufest0dduzklNnbn936wmDxwtUa0BiVDt6gn+2GQBqQd0UxLC6f576i4Xz2S
         S7YOk7HID6IRx0HCg17uBWXWCPZJ/a5dzrYCu/+62Fj2fpJJK2fYwbhIRJ2/PzLQ/eiT
         QcDW+oUspKmJfb+MQ7z5HkJ7AR7ffnxgAB+7dKJIw2dRhh5BXv32ZQws6MwcxhH+I1aW
         U7Sx3FC02dNbRmjr9uuuu+1uXLMKFIHDYQUpul4eTstw71LnTFrEJbzbgOyKAk04FR/k
         sPMw==
X-Gm-Message-State: AFqh2kqoiniRh/49oGS7e/1SGXkCXVicBQx0szLlrsJmIOb9LV3tpHAO
        KGY0lwdxXXUsopuVXfrKT34=
X-Google-Smtp-Source: AMrXdXv7ldueNqkwHFr4IF3a6zSirqNF5htYIuA6aY3PuA0cRchJEZEege9DqxASp4mXluWvFF3zHA==
X-Received: by 2002:a05:6402:4015:b0:46a:3bd0:4784 with SMTP id d21-20020a056402401500b0046a3bd04784mr74535972eda.7.1673525604987;
        Thu, 12 Jan 2023 04:13:24 -0800 (PST)
Received: from gmail.com ([31.46.242.235])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7d781000000b0048ecd372fc9sm7117071edq.2.2023.01.12.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:13:24 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Jan 2023 13:13:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, brgerst@gmail.com,
        chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 0/5] x86: Enable LKGS instruction
Message-ID: <Y7/5YPxbRE2AWgT0@gmail.com>
References: <20230112072032.35626-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112072032.35626-1-xin3.li@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Xin Li <xin3.li@intel.com> wrote:

> LKGS instruction is introduced with Intel FRED (flexible return and event 
> delivery) specification. As LKGS is independent of FRED, we enable it as 
> a standalone CPU feature.
> 
> LKGS behaves like the MOV to GS instruction except that it loads the base 
> address into the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s 
> descriptor cache, which is exactly what Linux kernel does to load user 
> level GS base.  Thus, with LKGS, there is no need to SWAPGS away from the 
> kernel GS base.

Ok, this looks good to me.

I've applied the first 4 patches to tip:x86/cpu, as the instruction exists 
in a public document and these patches are fine stand-alone as well, such 
as the factoring out of load_gs_index() methods from a high-use low level 
header into a new header file.

Planning to apply the final, LKGS enabler patch as well, unless there's any 
objections from others?

Thanks,

	Ingo
