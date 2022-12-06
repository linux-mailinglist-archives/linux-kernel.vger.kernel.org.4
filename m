Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055726439D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFAQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiLFAQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:16:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517238A3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:16:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so13202486pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0MaHRRiqHIESS4RVFnR6xMW+UY9asEzeHWMqoFz84s=;
        b=RIpE3NyGcARnWYcRj4bwZYE7KpnzVzhZAG+qcWvD/jwMkPbcboDs3SQEPdUY/g0Ri6
         BI0rP7Aznv7nG7eZ4ag25ya8XISq5m0z0s0lq6cGN4rSTGjYrIODpJ5n8rcw+c6P8JRN
         B0K2mfz7VVgwAkSLCuoAZw7dbA3rJecVyX0cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0MaHRRiqHIESS4RVFnR6xMW+UY9asEzeHWMqoFz84s=;
        b=qmcvi3ItMIMp7+PgImJWVr170jRAZMG9Av8zCuQ0jFxJQf8g6d7oOrivrJDX1xXsMO
         7B1xk1BPbG10dH7rmy+4IPw9BUdhVTcbpV1Ge888HaGatbXSLXOeUZqu10sL4IPNjZMr
         epOlzQplC5wFmw3MpN046/3rpQeRmukAw62yUUzSmpn9J46IEF1p2boDujDCXK5uBj7U
         larcmvClHliOnV81leUg4aYKqC4OeYMtV9CDBMIlayifKZTlXk+djOAtwonVs3cBD6f0
         LkHTITXYQ6B7afHkRF+UeD5AH1B2krtT2MH6hPOn0AcZ5yqB11vE4R8zlNL2q6dpXvbW
         a0ew==
X-Gm-Message-State: ANoB5pkGXHcJVgBrD/CAhFUIIeD3pKeS/yX/Gv0UMiqk+YWZVZByXh4m
        ZvROUTdkzdzJMSvUmXjE/jchQA==
X-Google-Smtp-Source: AA0mqf5TTCbWD9D7sGsaPw7m1v7kOKJUqiRLJ0Y9f2Vfc0df+ZdSBMs/omk302+37+Z8oddO1AxsCA==
X-Received: by 2002:a17:902:a703:b0:187:137c:b2ea with SMTP id w3-20020a170902a70300b00187137cb2eamr67052434plq.52.1670285785755;
        Mon, 05 Dec 2022 16:16:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8-20020a056a0000c800b0053e38ac0ff4sm3482136pfj.115.2022.12.05.16.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:16:24 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>, swboyd@chromium.org,
        anton@enomsg.org, ccross@android.com
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        rppt@kernel.org, bgeffon@google.com
Subject: Re: [PATCH] pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP
Date:   Mon,  5 Dec 2022 16:16:15 -0800
Message-Id: <167028577239.2860027.4300649046470353371.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205233136.3420802-1-swboyd@chromium.org>
References: <20221205233136.3420802-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 15:31:36 -0800, Stephen Boyd wrote:
> An oops can be induced by running 'cat /proc/kcore > /dev/null' on
> devices using pstore with the ram backend because kmap_atomic() assumes
> lowmem pages are accessible with __va().
> 
>  Unable to handle kernel paging request at virtual address ffffff807ff2b000
>  Mem abort info:
>  ESR = 0x96000006
>  EC = 0x25: DABT (current EL), IL = 32 bits
>  SET = 0, FnV = 0
>  EA = 0, S1PTW = 0
>  FSC = 0x06: level 2 translation fault
>  Data abort info:
>  ISV = 0, ISS = 0x00000006
>  CM = 0, WnR = 0
>  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000081d87000
>  [ffffff807ff2b000] pgd=180000017fe18003, p4d=180000017fe18003, pud=180000017fe18003, pmd=0000000000000000
>  Internal error: Oops: 96000006 [#1] PREEMPT SMP
>  Modules linked in: dm_integrity
>  CPU: 7 PID: 21179 Comm: perf Not tainted 5.15.67-10882-ge4eb2eb988cd #1 baa443fb8e8477896a370b31a821eb2009f9bfba
>  Hardware name: Google Lazor (rev3 - 8) (DT)
>  pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __memcpy+0x110/0x260
>  lr : vread+0x194/0x294
>  sp : ffffffc013ee39d0
>  x29: ffffffc013ee39f0 x28: 0000000000001000 x27: ffffff807ff2b000
>  x26: 0000000000001000 x25: ffffffc0085a2000 x24: ffffff802d4b3000
>  x23: ffffff80f8a60000 x22: ffffff802d4b3000 x21: ffffffc0085a2000
>  x20: ffffff8080b7bc68 x19: 0000000000001000 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: ffffffd3073f2e60
>  x14: ffffffffad588000 x13: 0000000000000000 x12: 0000000000000001
>  x11: 00000000000001a2 x10: 00680000fff2bf0b x9 : 03fffffff807ff2b
>  x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
>  x5 : ffffff802d4b4000 x4 : ffffff807ff2c000 x3 : ffffffc013ee3a78
>  x2 : 0000000000001000 x1 : ffffff807ff2b000 x0 : ffffff802d4b3000
>  Call trace:
>  __memcpy+0x110/0x260
>  read_kcore+0x584/0x778
>  proc_reg_read+0xb4/0xe4
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP
      https://git.kernel.org/kees/c/e6b842741b4f

-- 
Kees Cook

