Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01020662335
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbjAIK2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjAIK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:28:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853381A0;
        Mon,  9 Jan 2023 02:28:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ja17so5899632wmb.3;
        Mon, 09 Jan 2023 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEhA0ngAfEFL1HJCgzpGpDyeaM2Lphh/z9kK4dnHP7E=;
        b=PC77vZC8SH1jVuTyvKejeVCBeYiSmIaSBH+od2qXT+oTfp7mJ8T4esklJl+LO4UOq9
         FqrV/NmbT7m/mD8sQHPG3xuRdxwxsW6++tTsyLiXC+ZN3Emk+eWZDjyBaXk6xEWltO7M
         5PUTUQq5xj/NK6djO+vCJo8YdIY+/UutNostML71eye4hFygNBvX5q5iUfWNtb3PaiyG
         siPkvpT5n2nlNWYJInsqBW2mYIHmUl46ZUjeZBFRX8oA9qnw32qQh6RLSQlI6Sr7kc4s
         rNh0Gmpxl396kTo3K25+Ft1sU5OQNz5aVuLjaW2AoKhW2RwbmRwlcuwzCPHsCtO5IiAU
         Nq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEhA0ngAfEFL1HJCgzpGpDyeaM2Lphh/z9kK4dnHP7E=;
        b=wVAGQoIW/h71hnz/u7v14EOOh8EUdEkJ6V7w72OUB3xSRWZ8lIfvpvHIsDbeX/Rfsy
         Y7r8SkpyrAW9BekPKErLQebvNcdBDWvy/z1heGaL5awtXfsWmC5IeCO3bhqGUv6nwdks
         byb3XdknTEhdRDYrJmDevA7/OpY5qRpixGrK5a3TV71WJ0uoypBd+Ecg8bjI7H3D2mpw
         8KaDDr9LCcseeTJEng1iXa3516TF6KKVYVU1H72o/mAdtlHyf+MNyqWkE9R9K0JIowRB
         8lFFHx/QMEzrTvjs+BGH58uPitiwuBkfpOdjsLSmqqcBJUtViORayNw9p27srajMf2OU
         XRUA==
X-Gm-Message-State: AFqh2kr5Tq40vDj5MdZ6t3gw2HZaTgYt5uF2froBDtbztn5hrm/RU1gD
        O8RSNTnl//CkkiEfPvPgrMc=
X-Google-Smtp-Source: AMrXdXtqX16sE+ajBjQhiLCE6WXu/5ampSI6HvxUNMjvp9KQRjeS9q9bqKmDIDhXPy7JHiM9pQ1hrw==
X-Received: by 2002:a05:600c:4f11:b0:3d9:ee01:ae5b with SMTP id l17-20020a05600c4f1100b003d9ee01ae5bmr2798840wmq.12.1673260105081;
        Mon, 09 Jan 2023 02:28:25 -0800 (PST)
Received: from gmail.com (1F2EF719.nat.pool.telekom.hu. [31.46.247.25])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm17237133wms.15.2023.01.09.02.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:28:24 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Jan 2023 11:28:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/retbleed: add "stuff" mode admin documentation
Message-ID: <Y7vsQz8qompLCk3h@gmail.com>
References: <20230108213700.5703-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108213700.5703-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> Add admin documentation for "retbleed=stuff", based on commit
> description and source code.
> 
> Fixes: d82a0345cf21 ("x86/retbleed: Add call depth tracking mitigation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5364,6 +5364,14 @@
>  				       when STIBP is not available. This is
>  				       the alternative for systems which do not
>  				       have STIBP.
> +			stuff        - Enables "stuffing" mode mitigation,
> +				       which uses return thunking and call depth
> +				       tracking.  Only if effect if
> +				       CONFIG_CALL_DEPTH_TRACKING is set and
> +				       Spectre V2 mitigation mode is
> +				       "retpoline".
> +				       IBRS is fully secure mitigation but is
> +				       more costly (slower) than stuffing.

Typo:

  s/only if effect if
   /only in effect if

Other than that:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
