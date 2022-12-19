Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5446507A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLSGiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLSGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:38:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884446402;
        Sun, 18 Dec 2022 22:38:12 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w20so1495408ply.12;
        Sun, 18 Dec 2022 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6wBmBynq3nQh89d9yjAKo+Zm4+3fSnMMUhm5AG3pJM=;
        b=S+g8KqllwWEGtkNcOGEJzH+dxc16IDbnHaLIL8kA1qbNRTBzIEPovDirRmORPFY261
         eAOgaIZWWRdqk1aV2+eaL2PijXAcAgqYhHeY5F2pOrETsfYdmTiwD2QUHYSn5dJBeEOW
         u2LG4O8Lw2+FFfQJaXecxQR0SrcMrRNakG03ZZ4PXF+dmbLI9/UATauOzqKKaYOHGHcv
         ODQbTFOSdr62rOsO1JGLLg7RkcCazHP8/1bue+WqY/9Zi0r3PAEKx1cbTDXAjAWihV3t
         tW0YH/ZfeO58ePx0FACiVpJNY3ej6AKDhgt/kiOu+hTq4+LIE35r4Nc7dtpMPdbH/Pmb
         rixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6wBmBynq3nQh89d9yjAKo+Zm4+3fSnMMUhm5AG3pJM=;
        b=IbIbrTueEneqn/eOO21pKO6CAfRJIrKDdXs957JBbKLOmcd7IuNRzECOqzqC72honk
         gcbzyZJ7CyPULOt1Vaqcx1cC1ZGTBzsEL0IUcozzCKjZWNIj4sKxsi5Q1YnbobVG506i
         kLat6TwUR7TWKL2a9DM+TXJ/ZOj7dKFEUlnPmEgX4I/1ugltwPmZg0nyDpMwW/Y9M04Q
         PHYhMCd51F4aietaT5O1Dpkq2q6nou/93vFk5ZU9V4hI9dkANW5d1fI0dwp4RYvYrxgf
         WukOs2vUog24fIV9xUXrWicgpVHy3sQEefEvQ82CdaEM507Lre0QyAiU67gYzRfc2nIP
         zidg==
X-Gm-Message-State: ANoB5pliAPYzi3AQvrO/6aOXLnIEdEgfJYSXKDlLjc5dYL+K6D3lkjQd
        fJxEQpH6+y3TqV0K8/abc5I=
X-Google-Smtp-Source: AA0mqf6d27dF2FPb3UEwEblMV/YWAgfd/LMdLUPq7GmumP7yoieAsA+YVfvpB/Zr1edEyaAcu1kKcA==
X-Received: by 2002:a17:902:ef47:b0:187:1b7a:6930 with SMTP id e7-20020a170902ef4700b001871b7a6930mr47705835plx.6.1671431891959;
        Sun, 18 Dec 2022 22:38:11 -0800 (PST)
Received: from localhost ([103.152.220.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b0018b025d9a40sm6163746plf.256.2022.12.18.22.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Dec 2022 22:38:11 -0800 (PST)
Date:   Sun, 18 Dec 2022 22:38:09 -0800
From:   Dan Li <ashimida.1990@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT] CFI: Add support for gcc CFI in aarch64
Message-ID: <20221219063809.xgd6jjio4f7j5ysw@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219061758.23321-1-ashimida.1990@gmail.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cc: linux-hardening@vger.kernel.org
On 12/18, Dan Li wrote:
> Based on Sami's patch[1], this patch makes the corresponding kernel
> configuration of CFI available when compiling the kernel with the gcc[2].
> 
> The code after enabling cfi is as follows:
> 
> int (*p)(void);
> int func (int)
> {
> 	p();
> }
> 
> __cfi_func:
>         .4byte 0x439d3502
> func:
>         ......
>         adrp    x0, p
>         add     x0, x0, :lo12:p
>         mov     w1, 23592
>         movk    w1, 0x4601, lsl 16
>         cmp     w0, w1
>         beq     .L2
>         ......
>         bl      cfi_check_failed
> .L2:
>         blr     x19
>         ret
> 
> In the compiler part[4], there are some differences from Sami's
> implementation[3], mainly including:
