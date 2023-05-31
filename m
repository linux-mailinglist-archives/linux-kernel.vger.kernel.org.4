Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA57176D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjEaG0c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 02:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjEaG03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:26:29 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B59F;
        Tue, 30 May 2023 23:26:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6F1F661CECF8;
        Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OMHGyQ5Lvv4L; Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 21F3561A7038;
        Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6iJ5euobrcBa; Wed, 31 May 2023 08:26:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E70AC616B2CF;
        Wed, 31 May 2023 08:26:26 +0200 (CEST)
Date:   Wed, 31 May 2023 08:26:26 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        oe-kbuild-all <oe-kbuild-all@lists.linux.dev>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <959209724.158062.1685514386841.JavaMail.zimbra@nod.at>
In-Reply-To: <8033fb8f9677cf9aae411e97eb554d251ca03011.camel@sipsolutions.net>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org> <8033fb8f9677cf9aae411e97eb554d251ca03011.camel@sipsolutions.net>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: hWem4mJ9JdjGKB725Dk79ubQ3raPHg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> Ah, yeah, this is another "not actually in the kernel" cases. Let's ignore this
>> strlcpy for now.
>> 
> 
> Well, strlcpy() isn't part of libc either, so all this would need is to
> add it to user.h just like strlcpy() is now?

I think so.
Azeem, can you please test your changes with this fixup applied?

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bda66e5a9d4e3..e5d3fbbafe4d2 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -52,6 +52,7 @@ static inline int printk(const char *fmt, ...)
 extern int in_aton(char *str);
 extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
+extern ssize_t strscpy(char *, const char *, size_t);
 
 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")

Thanks,
//richard
