Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564B70CB2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjEVUem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjEVUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:34:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F00103
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:34:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f475366514so44954095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684787673; x=1687379673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1k/J8wtFm5kDn20aklLt0C/fMQkAC0oAe25hCJGf0Q=;
        b=lBeW+EHJMxul6+5/7kn6rk9lSsCsk82kmOlwBbUowAS1ltePVbyFf7dcIqTvQJdxGi
         XaR4E3msp2L79vV5+9HDT4OvFHK6PuAALlOtAL3m0k8tUKqnViT3s53wH8Qe6UE9snxs
         DTbCKVUH7CrqcT44TBncHGmKJJUsdGM3r9lz+zl7JWr5tR6W1XLIIfBrL6G1o5Bz3+RN
         lfUXD+oo8Jg/97lKiTl+Y5/8P8kxbXCltRxzHh1fOJ4wROuqnB6CWwFsC4pTqBHMtSa1
         UGwWTRQYOLsuxX49WlGpyBeadV4E760vAdK3hZcvb1+AmIhpXP/XJYPxk5hA9MepJa1/
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787673; x=1687379673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1k/J8wtFm5kDn20aklLt0C/fMQkAC0oAe25hCJGf0Q=;
        b=NEsi0xpJnCRf9w4LyWhTBU6lNzYSzUtXKoJka0hxy1v1psbOcc62sI0o6ugYdH8N7/
         sSrt2daRhmsY9Z62By8+5EflQ7JovBHZg+b69zPuqmitTWN4p7D5QXjmiKSn56fW4HIf
         BWYb+EWfyescoVZZlgWjT22eR5U/6mz8z5zqtGbiWPiXEb1kdVVvU1yXlko4+3yCo3vH
         s3eSnGC2XDWn/Oqp517pNuGKBeKulvlGrwWf0Ie4bduAjMa0qEueAlmXVqK6GmAmeD97
         QBSVY3Kh0Xk8Df7L2LVMoMNGjenZwUT+TqaLJ0A999Oz+RXFhXvL+5ED1mpdPV2bFqBw
         aTJg==
X-Gm-Message-State: AC+VfDyYHCl2R39PwEe94iBUAxsjj8LtmggR6hAsiXoGCSiS5mwLoYT0
        RaLa3Nlv3cOst+WZSt610rk/+heNyJo=
X-Google-Smtp-Source: ACHHUZ7laiEhM3jTpA8y0JkDQEEWh3yB9M8uLoT70L3vrTPn8GfHIb9iH2cn6xSwpud4LrkRul0sNw==
X-Received: by 2002:a1c:cc02:0:b0:3f4:fc5e:fbf2 with SMTP id h2-20020a1ccc02000000b003f4fc5efbf2mr8715097wmb.8.1684787673287;
        Mon, 22 May 2023 13:34:33 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003f42e008c8dsm12664696wmi.44.2023.05.22.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:34:32 -0700 (PDT)
Date:   Mon, 22 May 2023 21:34:31 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap: refactor mlock_future_check()
Message-ID: <fbbba8cd-77d1-44c3-ba70-18beae5719d1@lucifer.local>
References: <20230522082412.56685-1-lstoakes@gmail.com>
 <20230522132851.ccc9fafac91d7eb9ba922e94@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522132851.ccc9fafac91d7eb9ba922e94@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:28:51PM -0700, Andrew Morton wrote:
> On Mon, 22 May 2023 09:24:12 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > In all but one instance, mlock_future_check() is treated as a boolean
> > function despite returning an error code. In one instance, this error code
> > is ignored and replaced with -ENOMEM.
> >
> > This is confusing, and the inversion of true -> failure, false -> success
> > is not warranted. Convert the function to a bool, lightly refactor and
> > return true if the check passes, false if not.
>
> Yup.
>
> I don't think the name does a good job of conveying the
> function's use.
>
> > -	if (mlock_future_check(mm, vm_flags, len))
> > +	if (!mlock_future_check(mm, vm_flags, len))
> >  		return -EAGAIN;
>
> 	if (!may_mlock_future(...))
>
> or
>
> 	if (!mlock_future_ok(...))
>
> ?
>
>

Yeah I struggled with this, because the check only triggers if VM_LOCKED. I was
originally toying with can_mlock_future() but of course, it also returns true if
!VM_LOCKED...

I think your suggestion of mlock_future_ok() works well, could you change it to
that? Thanks!
