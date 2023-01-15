Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8684C66B074
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjAOKyv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Jan 2023 05:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjAOKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:54:49 -0500
X-Greylist: delayed 1458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 02:54:47 PST
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B86E3BE;
        Sun, 15 Jan 2023 02:54:46 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <thomas@m3y3r.de>)
        id 1pH0HM-0006mM-Hc; Sun, 15 Jan 2023 11:30:20 +0100
Received: from [77.185.92.28] (helo=[127.0.0.1])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <thomas@m3y3r.de>)
        id 1pH0HL-000JFs-5T; Sun, 15 Jan 2023 11:30:19 +0100
Date:   Sun, 15 Jan 2023 11:30:17 +0100
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] rust: arch/um: Use 'pie' relocation mode under UML
User-Agent: K-9 Mail for Android
In-Reply-To: <20221217044436.4138642-2-davidgow@google.com>
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-2-davidgow@google.com>
Message-ID: <387962BE-A8FA-4D35-9905-30D3685E38AC@m3y3r.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26782/Sun Jan 15 09:20:34 2023)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Am 17. Dezember 2022 05:44:34 MEZ schrieb David Gow <davidgow@google.com>:
>UML expects a position independent executable for some reason, 

I think I did add this to make UML build on Debian...

> so tell
>rustc to generate pie objects. Otherwise we get a bunch of relocations
>we can't deal with in libcore.
>
>Signed-off-by: David Gow <davidgow@google.com>
>---
> arch/um/Makefile | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/um/Makefile b/arch/um/Makefile
>index f1d4d67157be..ae321282dc6f 100644
>--- a/arch/um/Makefile
>+++ b/arch/um/Makefile
>@@ -68,6 +68,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
> 	-Din6addr_loopback=kernel_in6addr_loopback \
> 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
> 
>+KBUILD_RUSTFLAGS += -Crelocation-model=pie
>+
> KBUILD_AFLAGS += $(ARCH_INCLUDE)
> 
> USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \

-- 
Diese Nachricht wurde von meinem Android-Gerät mit K-9 Mail gesendet.
