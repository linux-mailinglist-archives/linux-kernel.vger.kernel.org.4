Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D97611DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJ1W5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ1W4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:56:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E0228CE6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:56:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v17so3037090plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQVwlOrzjvZiwM1yWaKuSc9d6GkFqbVluxP+1zRoo5U=;
        b=eU8VLE4GEjE+APWuWM6WRrEfDSltFZWeZlSXHgeGp5TncgAyuPYWq7hMBq0IfiTrC8
         DZVXxlLkRH6qA+M+RNmZYXcvXR46nDJ18CyPAht469DmLhfezSz3AJYGBA0IaOqn+csV
         2eVii3ad+U/qMLpjwXtpwdBEaGNoJ9vWoTF2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQVwlOrzjvZiwM1yWaKuSc9d6GkFqbVluxP+1zRoo5U=;
        b=zggR/3HlwjR63qpefIpZtONuOohLyhvWRCOz7bEL316bELzz8itPWzCiIyqB8BSc75
         qWksBYbN9g0XorRzImBusnh3grll5/kTdS8SRjMCCUrdYJ1hd9TgjCVW0XalNOt/Cv02
         7KMk+YcayaxK8FDkic/xjeoJ6/uTnXsszyzPTqOsSGSA7JBf9w2QlOVRvgHfLn4v8bfB
         B/nYKgdae8/4HZDorAegjsCbr9GRWdkBczG1j3VdC5lnGedHwIrZeGwapUZEWE1H7y4R
         oDmnNvmj7XUf/GRZxKNmUlxDS9f4GObKBsQ7H5BBzOjFJFE+EwmllvMZkJFuJuUNAtjS
         Lqug==
X-Gm-Message-State: ACrzQf2vZysw9SagN0U6mY1eDpWs++jgXL7mwThlO6d/WS56y17NAGf/
        pw0xhh36J11u2NwPXS0iA4PeSg==
X-Google-Smtp-Source: AMsMyM71FiYjLx0f78sa5ClLCKOCsteQvvfwYpKRsKxw8Q9/oGoGzeAAt58B/ZtFZEwdoblo2PGEqg==
X-Received: by 2002:a17:90b:1804:b0:213:1a9c:5ae with SMTP id lw4-20020a17090b180400b002131a9c05aemr19031610pjb.81.1666997799152;
        Fri, 28 Oct 2022 15:56:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f130-20020a623888000000b0056c06d583fasm3289439pfa.219.2022.10.28.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:56:38 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:56:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: Fix fortify moan in symlink
Message-ID: <202210281526.B32C79C4@keescook>
References: <20221022203913.264855-1-linux@treblig.org>
 <202210241021.6E9E1EF65@keescook>
 <Y1beLWto/J2W1Stu@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1beLWto/J2W1Stu@gallifrey>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 07:49:17PM +0100, Dr. David Alan Gilbert wrote:
> * Kees Cook (keescook@chromium.org) wrote:
> > On Sat, Oct 22, 2022 at 09:39:14PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > JFS has in jfs_incore.h:
> > > 
> > >       /* _inline may overflow into _inline_ea when needed */
> > >       /* _inline_ea may overlay the last part of
> > >        * file._xtroot if maxentry = XTROOTINITSLOT
> > >        */
> > >       union {
> > >         struct {
> > >           /* 128: inline symlink */
> > >           unchar _inline[128];
> > >           /* 128: inline extended attr */
> > >           unchar _inline_ea[128];
> > >         };
> > >         unchar _inline_all[256];
> > > 
> > > and currently the symlink code copies into _inline;
> > > if this is larger than 128 bytes it triggers a fortify warning of the
> > > form:
> > > 
> > >   memcpy: detected field-spanning write (size 132) of single field
> > >      "ip->i_link" at fs/jfs/namei.c:950 (size 18446744073709551615)
> > 
> > Which compiler are you using for this build?
> 
> I think that report was the same on gcc on Fedora 37 and whatever
> syzkaller was running.
> 
> > This size report (SIZE_MAX)
> > should be impossible to reach. But also, the size is just wrong --
> > i_inline is 128 bytes, not SIZE_MAX. So, the detection is working
> > (132 > 128), but the report is broken, and I can't see how...
> 
> Yeh, and led me down a blind alley for a while thinking something had
> really managed to screwup the strlen somehow.

This looks like a GCC bug (going at least back to GCC 10.2)[1], but some
extra care around the macro appears to make it go away, so the reporting
variable doesn't get confused/re-evaluated:

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 09a032f6ce6b..9e2d96993c30 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -550,13 +550,18 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 
 #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
 			     p_size_field, q_size_field, op) ({		\
-	size_t __fortify_size = (size_t)(size);				\
-	WARN_ONCE(fortify_memcpy_chk(__fortify_size, p_size, q_size,	\
-				     p_size_field, q_size_field, #op),	\
+	const size_t __fortify_size = (size_t)(size);			\
+	const size_t __p_size = (p_size);				\
+	const size_t __q_size = (q_size);				\
+	const size_t __p_size_field = (p_size_field);			\
+	const size_t __q_size_field = (q_size_field);			\
+	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
+				     __q_size, __p_size_field,		\
+				     __q_size_field, #op),		\
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
 		  __fortify_size,					\
 		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
-		  p_size_field);					\
+		  __p_size_field);					\
 	__underlying_##op(p, q, __fortify_size);			\
 })
 


[1] https://syzkaller.appspot.com/bug?id=23d613df5259b977dac1696bec77f61a85890e3d

-- 
Kees Cook
