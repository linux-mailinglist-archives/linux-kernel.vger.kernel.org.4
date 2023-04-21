Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343D96EB256
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjDUTjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjDUTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F42702
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982C961CBD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 19:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2EAC433EF;
        Fri, 21 Apr 2023 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1682105952;
        bh=9jm7Yk/V2fA6/l+FztUl37nK9oPvvNK38u0eLqXt43o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vwKgMUq/niZu6Zr6QGOacFycbzkShwJwXE0iZaRgJGRwCHOmgVSU+AfL6aODnPa02
         oAFu7qC/Zg91tLl/jrghkRhQBc3ZoVg7rA5sJjdkCKwnAtWoU7jJPd4u3Oj06kOc69
         8jRXajxsU6zGUSALmIQiicXxFXi0eXi0GZUgTM5k=
Date:   Fri, 21 Apr 2023 12:39:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: use __builtin_mul_overflow() more
Message-Id: <20230421123911.3c4b1e3b56781ffdf043ef58@linux-foundation.org>
In-Reply-To: <dd85c092-379e-4d14-88f0-8f3910de9f7f@p183>
References: <dd85c092-379e-4d14-88f0-8f3910de9f7f@p183>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 21:54:36 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> __builtin_mul_overflow() can do multiplication and overflow check
> in one line.
> 
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1651,9 +1651,8 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
>  
>  	/* *Estimated* file count and total data size needed */
>  	count = cprm->vma_count;
> -	if (count > UINT_MAX / 64)
> +	if (__builtin_mul_overflow(count, 64, &size))
>  		return -EINVAL;
> -	size = count * 64;

Huh, what the heck is that ;)


include/linux/overflow.h has check_mul_overflow() for us to use here.


tools/lib/bpf/libbpf_internal.h uses

	#if __has_builtin(__builtin_mul_overflow)

but check_mul_overflow() didn't bother testing for availability. 
Probably tools/lib/bpf/libbpf_internal.h should just use
check_mul_overflow().


