Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A966D9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjAQJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjAQJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:32:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9014E91
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:31:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id v6so30905718ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdnu+i46i2gnFS4iiJrllb1w2/cjIXrWKzQRHis/CFU=;
        b=J1vTmhiewt53nz0Aw/xd1Nkmv7FSoF283O3i2YTmIIqDBDOic1wlubmcsmDvQxDvO4
         QJJRMt5X9KB8BosQozglpBSaVcfQLVyazmkMvi/2G81lxgBFUGc6AKAr8/cFDxO23ada
         qJPsjKGuFDUhQ0womaUeXwkVfLpNp8fvvNK3Qf+fmrZV4I+Rm9Vf+Sog7ZOY1lk7Z7Zo
         O7aH+phliKhjKAsepC1stYUeuxBiwV1ymu+3Jj8Tp0YbmfxH8q2e9wemDFD892gfzbI5
         Hng8xTaD6TkJqzNTURbkAXfzMiuC6YuIkirf7yqoNz2mjydfVWSCXtDnmYXo/hguNMXq
         Xm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdnu+i46i2gnFS4iiJrllb1w2/cjIXrWKzQRHis/CFU=;
        b=QR5wuY3AdbQ8HO/XKfmk3flYfzDDdYOQm+BkliaXSX8mC7xYkpYEWaj8ziw176AcrY
         kgOaX4mpb2kpHRrXeoCHyBm5e1aB6O1xl02gww5tPKRcGsnc1VyG2G1vYZyBbvdVBAD+
         lDVAhEs5jufk2blw0HI0D42Am5/fA4spYEvWzDRq/GkEk0e0V5vcOhBnAmKzJbEHR0Rm
         gCzWWwXNpl8cqrsH9oQiZ1Sr521hpQ29Up4FzWkowoahE+czmzSL6wDnkefabhjoUm0y
         ZOOIDGClgXKLwuwr1MK5tW6MLnvhq07sHYw63aaN634r6rq9qNn6QPTlyxCaDifX6C14
         5+DA==
X-Gm-Message-State: AFqh2krgCjGbNvkve9IIG7+voxMHGmQSrGcrbkD6MxH/Bh3Y8Cisceez
        dpSDkVGPqmbga92eini2Se8=
X-Google-Smtp-Source: AMrXdXvAbl6az2nEprKe4qbBEkiakEEniymcQ+bk8FYAhM2poQzyIc90typ8o1yTNjA99vtnWkmtJQ==
X-Received: by 2002:a17:907:20e9:b0:7c0:dcc2:e7b1 with SMTP id rh9-20020a17090720e900b007c0dcc2e7b1mr2127024ejb.43.1673947868545;
        Tue, 17 Jan 2023 01:31:08 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709061be100b0086f40238403sm3073376ejg.223.2023.01.17.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:31:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Jan 2023 10:31:05 +0100
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 6/7] x86/power: Sprinkle some noinstr
Message-ID: <Y8Zq2WaYmxnOjfk8@gmail.com>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.888786209@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116143645.888786209@infradead.org>
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

> +	/*
> +	 * Definitely wrong, but at this point we should have at least enough
> +	 * to do CALL/RET (consider SKL callthunks) and this avoids having
> +	 * to deal with the noinstr explosion for now :/
> +	 */
> +	instrumentation_begin();

BTW., readability side note: instrumentation_begin()/end() are the 
misnomers of the century - they don't signal the start/end of instrumented 
code areas like the name falsely & naively suggests, but the exact 
opposite: start/end of *non-*instrumented code areas.

As such they should probably be something like:

	noinstr_begin();
	...
	noinstr_end();

... to reuse the nomenclature of the 'noinstr' attribute?

Thanks,

	Ingo
