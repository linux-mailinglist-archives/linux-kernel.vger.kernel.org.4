Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DD6251C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiKKDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKDit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:38:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0B124
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:38:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g62so3821809pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBNei5h4u7yfXoS80paK9OSVEakmAYHRYKZMGMpdlsE=;
        b=YTJOtdlboLe7NHWdyua3Xha6po+V4K7iL7s/tUMK0qzBMsZSWqzdbfM6UkSy31v3oi
         iqWjvWDNzPimsRrpbymbpWN7qOiLBqnxbFgmvIOQHobtBLMu1pXIPq75m2WgmaBSIxmz
         QneCiBIS//+FpQ5H7QbFR3ZrdCsM2sfI+kuEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBNei5h4u7yfXoS80paK9OSVEakmAYHRYKZMGMpdlsE=;
        b=xsnzPvoInD7MLb57owGSSureO8FS94NrEENuAC8G4BPHmsG0jeSa4nrr2ut82Gxtiu
         sbyz+hh2VPUfAefOBD/Xcg2U71WgKRYyTy5t4oiVnNmXi79kFG5wQC7NbhPkfQi09Zq5
         XD3rY3E8wDmBSSaQXu68197n+s1E23bsdjgxG5C0LlNfhVTYD5jJ4ReIRg9qZmJnc1P6
         xZ70dmkBniioGOH2Sgl2KOM9KjxvF9SuFVphcMy/X5rvJQew95lU/LSMnbVTsWXmOGTC
         yIjwM0j4GQ/AMvwQ+Vfoee5KtNPD+lBVAXaXxxrvPqHvRWNskL2nRGFzbbDYA8B2jdfN
         PEKg==
X-Gm-Message-State: ANoB5pmECMFQBE+YwZ9dMf8HJH7stV0MXV1CsTazdrVYXYG82clbMXD4
        6oarYyoOa9gZgyWOw3AGtdqq7rfwmFgcLA==
X-Google-Smtp-Source: AA0mqf4j95CO8KetxfmT+m9ed9cGkWk+oGq+gFsPdc3TkiKPWRYtI9pGv5K9FL4RgZfMlQ5/O9H+Sg==
X-Received: by 2002:aa7:9839:0:b0:56b:d363:a31b with SMTP id q25-20020aa79839000000b0056bd363a31bmr598232pfl.78.1668137926642;
        Thu, 10 Nov 2022 19:38:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7-20020a635347000000b0046fe244ed6esm379447pgl.23.2022.11.10.19.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 19:38:45 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:38:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, dalias@libc.org,
        ebiederm@xmission.com, sam@gentoo.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] fs/binfmt_elf: Fix memsz > filesz handling
Message-ID: <202211101934.22CACD615@keescook>
References: <20221108110715.227062-1-pedro.falcato@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108110715.227062-1-pedro.falcato@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:07:15AM +0000, Pedro Falcato wrote:
> [...]
> +		 * This tail logic is skippable if we're the last phdr, as
> +		 * nothing can map an address >= our p_vaddr, since ELF phdr
> +		 * PT_LOAD segments are required to be sorted in an increasing
> +		 * order.

I'm still looking through the patch, but I do want to call this bit out
as a problem. The kernel cannot, unfortunately, make this assumption. See:
https://lore.kernel.org/linux-fsdevel/YfOooXQ2ScpZLhmD@fractal.localdomain/

"It turns out that almost all native Linux games published by the Virtual
Programming company have this kind of weird PT_LOAD ordering including
the famous Bioshock Infinite ... Someone should probably ask Virtual
Programming, what kind of tooling they use to create such convoluted
ELF binaries."

So, even though it's in violation of the spec, these binaries exist in
the real world, and we cannot break them. :(

-- 
Kees Cook
