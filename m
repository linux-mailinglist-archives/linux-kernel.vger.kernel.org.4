Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859162EA55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiKRAbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiKRAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:31:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77B6D497
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:31:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o13so3601893pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdXW0qNT9EJ55g7ZecMibSPRKy2hZHqw3Yh8nMlwERE=;
        b=aU25zccRjTs3wP43k0MIJn4DgVbsnZCNuzNnI2CpXWYIZxXulCGxIQevzOUHHZBnNX
         P9dqjL6CLaVk8Gd/8VV9yHkQnYw6wZLIF25d9n4/Hz+qw11dfo4C3uVe8ugX4akyWpVq
         2j/LOKCC5xRDK3aE2eqqxuB+wZP/Rdy2IY2yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdXW0qNT9EJ55g7ZecMibSPRKy2hZHqw3Yh8nMlwERE=;
        b=U3XjQKqCfLxSaWysCg22M8DqbUGZCPGQ/JswVW6Rulzk53AxQ47U+nitB/xFFHfsiw
         COh/aO4Wdx7MxuQINT7vHg1bGQMFw1nF2l/s0PM37o0iDE7e2QuF2feqRS3MkvVs1miE
         HWxTcnni8AFRF+sSS9xc7Ypux02XbMNkq9Go2X7SUPc5XmuTw9DUKNj+ZSrlSWvEFFNO
         UJJX1CZWZJQQPhq6bWuXVLnO+Kuz0QJDiGTXlpk8XrJ/5Oruj6ub8WArofQ2fX6yDcyX
         BvUtHH1jTHT8jVEdC3ThmctEW1k25mpGrASWXvkF4ndRyemc/pfLcGe4lyAqrpvkfNFX
         ZEwg==
X-Gm-Message-State: ANoB5plgZJBwzHZt4g1qNkIW3ZVjnqbCxVsUfGFfG02h2hl8qw9tI7fB
        oGFlKWs4MIOvYVZF6dbelWkTtQ==
X-Google-Smtp-Source: AA0mqf4Eg6efWFkC4PcZKO6M1HjEMRT/hWrF7/OJe6t0KCBzvaZRup/szSwa3Jgy88qqEUfyA5B6Hg==
X-Received: by 2002:a65:53ca:0:b0:476:dd80:fb29 with SMTP id z10-20020a6553ca000000b00476dd80fb29mr4360083pgr.619.1668731485545;
        Thu, 17 Nov 2022 16:31:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00186b6bb2f48sm2022328plk.129.2022.11.17.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:31:25 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:31:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
Message-ID: <202211171630.8EABF5EDD@keescook>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
 <202211171439.CDE720EAD@keescook>
 <CAHk-=wjykbz-4xVTWF7vkvGJnFoTSXNVeMzfsXaLnGm3CRd8rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjykbz-4xVTWF7vkvGJnFoTSXNVeMzfsXaLnGm3CRd8rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:20:01PM -0800, Linus Torvalds wrote:
> On Thu, Nov 17, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Oh, er, why does get_arg_page() even need FOLL_FORCE? This is writing the
> > new stack contents to the nascent brpm->vma, which was newly allocated
> > with VM_STACK_FLAGS, which an arch can override, but they all appear to include
> > VM_WRITE | VM_MAYWRITE.
> 
> Yeah, it does seem entirely superfluous.
> 
> It's been there since the very beginning (although in that original
> commit b6a2fea39318 it was there as a '1' to the 'force' argument to
> get_user_pages()).
> 
> I *think* it can be just removed. But as long as it exists, it should
> most definitely not be renamed to FOLL_PTRACE.
> 
> There's a slight worry that it currently hides some other setup issue
> that makes it matter, since it's been that way so long, but I can't
> see what it is.

My test system boots happily with it removed. I'll throw it into -next
and see if anything melts...

-- 
Kees Cook
