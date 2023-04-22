Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E09B6EB84B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDVJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 05:45:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192CEE6F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 02:45:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so2406418f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682156716; x=1684748716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnyeSeDoQt5xayBqxmJ4+9xcveaUtfXwuDg05vHt+yk=;
        b=bgUUoP+ifj+A6YakQarfnw6siDlPE7FcFykOQD7DBTpkTn6rp09MmzjJqkFV8VPlof
         Ahs1oFPLZ6X91sEiGkoGC7d6BYUDmi+ziKdgx+Syys1+8lTqrCDEU2rWqkzxXDsGFO/8
         C92VMZv/BRifS5872CMNasH4Z54j6iQN9H3Qr153+54F03fbN7AVhHxC/NEqV36BQPLJ
         glvpwnarLQr67m8XNdWc4RCauLluE36yauLm5s52i0hCMzQGeB5T/2K3DPIukFqpp7yx
         ceu2SK75wiAM8qRkkxvGtVcixjNPS7XJSd8sUHVJqJMst4znUBDbD3cIi8zsIEy21pqv
         Ot1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682156716; x=1684748716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnyeSeDoQt5xayBqxmJ4+9xcveaUtfXwuDg05vHt+yk=;
        b=gvoEpVaH0GcwqJZuA9Zwv3+wWq+O/gfXvcB33iFd4nIRhUztVUR9tO71Z5r6ibb1kD
         Uvu1KpJPnUK+Pq+2gbSLMtNRn1OMLAl+syFcO7y5sh+i02lQ5ZSLyLM8zjGQTOBhG0cL
         vzDSzuh4ZhGsIqiGtDa//mLqgQEB3c9Md4wI8lZfLZ+goxOoOe2HdeTUdgofCJ9aBnWV
         BVSA1X/kHimaEWCyNYAKa9R1RWuiL7iXjuuGk2h87TmEGiY4J6zizfAPa/gEGWzCUmSX
         JZz5rXaCz6AfTU3sgEjXrPetWxt2A2J5AtQVyTwFCSkkkPcN5ed5bmMESd1ebITBZHYe
         h10g==
X-Gm-Message-State: AAQBX9dF0W2VLI9HVknz+Hw5oQBksRmwD2rkqcj1HYUU+tw+pNGvtnyV
        3rYFt+lpYQDgQQIZkjTZ/TaNKBkt3w==
X-Google-Smtp-Source: AKy350b0zs8DNDUHsUETaNR2LgM6qXO4pRinoLUhGRaX/3lL994iUuWwaGqteuRhlhG1pjTXpVAxmw==
X-Received: by 2002:adf:e8c4:0:b0:2f5:aadb:4642 with SMTP id k4-20020adfe8c4000000b002f5aadb4642mr5588115wrn.41.1682156716419;
        Sat, 22 Apr 2023 02:45:16 -0700 (PDT)
Received: from p183 ([46.53.251.93])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c028e00b003f18b942338sm6616525wmk.3.2023.04.22.02.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 02:45:16 -0700 (PDT)
Date:   Sat, 22 Apr 2023 12:45:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: use __builtin_mul_overflow() more
Message-ID: <a7f51d49-cb6a-4066-a58f-2505e29f25e8@p183>
References: <dd85c092-379e-4d14-88f0-8f3910de9f7f@p183>
 <20230421123911.3c4b1e3b56781ffdf043ef58@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230421123911.3c4b1e3b56781ffdf043ef58@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:39:11PM -0700, Andrew Morton wrote:
> On Fri, 21 Apr 2023 21:54:36 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > __builtin_mul_overflow() can do multiplication and overflow check
> > in one line.
> > 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1651,9 +1651,8 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
> >  
> >  	/* *Estimated* file count and total data size needed */
> >  	count = cprm->vma_count;
> > -	if (count > UINT_MAX / 64)
> > +	if (__builtin_mul_overflow(count, 64, &size))
> >  		return -EINVAL;
> > -	size = count * 64;
> 
> Huh, what the heck is that ;)
> 
> 
> include/linux/overflow.h has check_mul_overflow() for us to use here.

Oh, no, wrappers.

> tools/lib/bpf/libbpf_internal.h uses
> 
> 	#if __has_builtin(__builtin_mul_overflow)
> 
> but check_mul_overflow() didn't bother testing for availability. 

gcc 5.1 has __builtin_mul_overflow()

> Probably tools/lib/bpf/libbpf_internal.h should just use
> check_mul_overflow().

I don't know, this is userspace stuff.
