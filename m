Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833A68F8C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBHUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBHUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:22:09 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7214ECF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:22:08 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id o36so448wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whX4C61GgBtlsDv83tBoxxHpqsraTaM5Z3iiHDkCmlI=;
        b=RdPW0nzDdd6ISBBE3w9FrKvy/uIPrlICjZ3okVhx43veJMSldNbXkbQ+gjke4a9N0b
         q+XQ/f9eaUyZIyjpLeWpHABEAwGNSTIewsCuZk3aP5Te82hcwKjg9cuSGmweIm2SuTeP
         n1t+pce/po/sJsfOMq1C1c5bImN+TFC/QW3Tzjta2AAxoQaKzofunY9d1A0XfgGE7d9+
         EELyjli1lNYEthKTnG6j6q5PnvE3c4TbeFXvQzLAPs5CWkrSudaExOHmKDe9BqL555yh
         yvu3Yh2i3AY07CJQDUleNJnyvS/+e9S+e/COYCHyZ4LRwiGG3zLHZHWbQVWm799YyTbW
         JYZQ==
X-Gm-Message-State: AO0yUKVkV/mJ7P01eQLzSRgu/gW/tpXgipF/AcobQ4wDHtkpgaHadkus
        Qj12npRKoflirZbr1fQ1LYjr89z24cFXyYkzgADqbw==
X-Google-Smtp-Source: AK7set8mFmcZwrfoUF+UsfjsCjfyy2JmCcaPpGmT92/3tEiDQxszx6B3Xv37h2kdcdcRcd/eF1vexw==
X-Received: by 2002:a05:600c:1e8a:b0:3df:e57d:f4ba with SMTP id be10-20020a05600c1e8a00b003dfe57df4bamr10215648wmb.7.1675887726561;
        Wed, 08 Feb 2023 12:22:06 -0800 (PST)
Received: from fedora.fritz.box (p549440c4.dip0.t-ipconnect.de. [84.148.64.196])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003e0015c8618sm2940269wmb.6.2023.02.08.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:22:06 -0800 (PST)
Date:   Wed, 8 Feb 2023 21:22:02 +0100
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <Y+QEak2HWlkNuJ3U@fedora.fritz.box>
Reply-To: Damian Tometzki <dtometzki@fedoraproject.org>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208171756.898991570@infradead.org>
User-Agent: Mutt
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08. Feb 18:17, Peter Zijlstra wrote:
> Hi,
> 
> Boris complained he could no longer build allyesconfig on his 32G desktop
> machine without having OOM terminate either objtool or chrome.
> 
> After talking about these patches on IRC, Nathan mentioned the linux-clang CI
> was also having trouble of recent, and these patches appear to make it happy
> again.
> 
> In total these patches shrink an allyesconfig run by about 6G:
> 
> pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
> post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem
> 
> Also at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core
> 
Hello Peter,

with clang-17 the build failed: 
In file included from weak.c:10:
In file included from /home/damian/kernel/linux/tools/objtool/include/objtool/objtool.h:13:
/home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:88:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
static_assert(offsetof(struct reloc, rela.r_offset) == offsetof(struct reloc, offset));
                                                                                     ^
                                                                                     , ""
In file included from arch/x86/special.c:4:
In file included from /home/damian/kernel/linux/tools/objtool/include/objtool/special.h:10:
In file included from /home/damian/kernel/linux/tools/objtool/include/objtool/check.h:11/home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:
In file included from :89:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
/home/damian/kernel/linux/tools/objtool/include/objtool/arch.h:11:
In file included from static_assert(offsetof(struct reloc, rela.r_addend) == offsetof(struct reloc, addend));
                                                                                     ^
                                                                                     , ""
/home/damian/kernel/linux/tools/objtool/include/objtool/objtool.h:13:
/home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:88:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
static_assert(offsetof(struct reloc, rela.r_offset) == offsetof(struct reloc, offset));
                                                                                     ^
                                                                                     , ""
/home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:89:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
static_assert(offsetof(struct reloc, rela.r_addend) == offsetof(struct reloc, addend));
                                                                                     ^
                                                                                     , ""
2 errors generated.
In file included from builtin-check.c:10:
In file included from /home/damian/kernel/linux/tools/objtool/include/objtool/objtool.h:13:
/home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:88:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
static_assert(offsetof(struct reloc, rela.r_offset) == offsetof(struct reloc, offset));
...

Best regards
Damian

