Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C79660DB9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjAGKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjAGKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:21:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6046B585
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:21:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ja17so2648171wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwZ6DNVnfIB+W/mkRCm0E3L/QObg6wnuFzYCkYmf6wI=;
        b=Q/e2KnuzjAKgdUkzAT7lO6QdIpWGQHJT8Xf7hjGBNvxWtNbdy66cKdafcqqs+seXr7
         P52Rjc6hF503T23rooeXa43iLYeK9CtJcLxd2pfuzYuMyFtw2pP6JXT4noaTFK3rvPO1
         GnWFjCDBLgxAz5sqVfiIknbgcozxG3Oa3vXcmSr0OvcWUgScoW1SkhE0P0HLGO3OKVGV
         yDP/SG+EaYDUnPp4FcyQPyqTpG2OJS5cn1SegSDHMCRmuup2N2Ufmq2OHxUZ8YEPLXxj
         oHQjy6+o/xzVA4qOJnU24VpAPGC3jO2NCAq2LQKAgQfyd7tfVj4gxH0OVr7fx9VSUuft
         /7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwZ6DNVnfIB+W/mkRCm0E3L/QObg6wnuFzYCkYmf6wI=;
        b=EDVBENuR/58Fi7V+sENBb5k28q4TYDSpG08zKaCeFpHHXzlxh3g0PqIOpynlF6t9W6
         2Se8pJRTC50Jz/FqtIMFa7j7em0EX/dauArS0qOQnqMiVhmzlhDWpw8XyFZCd8Dchcgl
         0TrsuUIDxc0cFDG9gRxA7WOhV1ix0yPw/ymC5j9b/akPF+Sq+XzExzdVXETz378C96zQ
         0ZAJd+2q5nHiVv7HJO4sin1eQUP06nChPMZHXDx5b+VG7fhm5K/w+plMJV/uGpHpebth
         J08Y55XtbRxX8gOLPiiu7m+xClNWwSz0+n1xzw13sDE7zMEXTPsDTRpgS8tao+dhZpxQ
         pKuA==
X-Gm-Message-State: AFqh2ko2cbltbVpn+TWPi7z1xz/RdXLfMgxYUHcEXdF3VspnQys+6Cbe
        riFzo7VzU5r8q3E3SWz5fkA=
X-Google-Smtp-Source: AMrXdXvgj7WJXgL/O/krYz60H4JU969uB0AKG+nlWVdeOrcW5xNqfH+0SfSwFQ+JYOrTORDecb7Z5Q==
X-Received: by 2002:a1c:4c12:0:b0:3c6:e63e:89a6 with SMTP id z18-20020a1c4c12000000b003c6e63e89a6mr41596718wmf.2.1673086901829;
        Sat, 07 Jan 2023 02:21:41 -0800 (PST)
Received: from gmail.com (1F2EF507.nat.pool.telekom.hu. [31.46.245.7])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c1c0100b003cfaae07f68sm10255499wms.17.2023.01.07.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 02:21:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 7 Jan 2023 11:21:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jpoimboe@redhat.com, peterz@infradead.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        sfr@canb.auug.org.au, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] objtool: continue if find_insn() fails in
 decode_instructions()
Message-ID: <Y7lHsw4diDgVc9ip@gmail.com>
References: <20221208072813.25799-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208072813.25799-1-sv@linux.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sathvika Vasireddy <sv@linux.ibm.com> wrote:

> Currently, decode_instructions() is failing if it is not able to find
> instruction, and this is happening since commit dbcdbdfdf137b4
> ("objtool: Rework instruction -> symbol mapping") because it is
> expecting instruction for STT_NOTYPE symbols.
> 
> Due to this, the following objtool warnings are seen:
>  [1] arch/powerpc/kernel/optprobes_head.o: warning: objtool: optprobe_template_end(): can't find starting instruction
>  [2] arch/powerpc/kernel/kvm_emul.o: warning: objtool: kvm_template_end(): can't find starting instruction
>  [3] arch/powerpc/kernel/head_64.o: warning: objtool: end_first_256B(): can't find starting instruction
> 
> The warnings are thrown because find_insn() is failing for symbols that
> are at the end of the file, or at the end of the section. Given how
> STT_NOTYPE symbols are currently handled in decode_instructions(),
> continue if the instruction is not found, instead of throwing warning
> and returning.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>

The SOB chain doesn't look valid: is Naveen N. Rao, the first SOB line, the 
author of the patch? If yes then a matching From: line is needed.

Or if two people developed the patch, then Co-developed-by should be used:

        Co-developed-by: First Co-Author <first@coauthor.example.org>
        Signed-off-by: First Co-Author <first@coauthor.example.org>
        Co-developed-by: Second Co-Author <second@coauthor.example.org>
        Signed-off-by: Second Co-Author <second@coauthor.example.org>

[ In this SOB sequence "Second Co-Author" is the one who submits the patch. ]

[ Please only use Co-developed-by if actual lines of code were written by 
  the co-author that created copyrightable material - it's not a courtesy 
  tag. Reviewed-by/Acked-by/Tested-by can be used to credit non-code 
  contributions. ]

Thanks,

	Ingo
