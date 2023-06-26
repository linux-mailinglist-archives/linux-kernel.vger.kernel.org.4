Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D173ED11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFZVrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFZVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:47:22 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 14:47:19 PDT
Received: from port70.net (port70.net [81.7.13.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC8351701;
        Mon, 26 Jun 2023 14:47:19 -0700 (PDT)
Received: by port70.net (Postfix, from userid 1002)
        id A4A2AABEC0C7; Mon, 26 Jun 2023 23:38:40 +0200 (CEST)
Date:   Mon, 26 Jun 2023 23:38:40 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/4] openrisc: Support floating point user api
Message-ID: <20230626213840.GA1236108@port70.net>
References: <20230418165813.1900991-1-shorne@gmail.com>
 <20230418165813.1900991-4-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418165813.1900991-4-shorne@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stafford Horne <shorne@gmail.com> [2023-04-18 17:58:12 +0100]:
> Add support for handling floating point exceptions and forwarding the
> SIGFPE signal to processes.  Also, add fpu state to sigcontext.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
...
> --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> @@ -28,6 +28,7 @@
>  
>  struct sigcontext {
>  	struct user_regs_struct regs;  /* needs to be first */
> +	struct __or1k_fpu_state fpu;
>  	unsigned long oldmask;
>  };

this seems to break userspace abi.
glibc and musl have or1k abi without this field.

either this is a new abi where binaries opt-in with some marking
and then the base sigcontext should be unmodified,

or the fp state needs to be added to the signal frame in a way that
does not break existing abi (e.g. end of the struct ?) and also
advertise the new thing via a hwcap, otherwise userspace cannot
make use of it.

unless i'm missing something.
