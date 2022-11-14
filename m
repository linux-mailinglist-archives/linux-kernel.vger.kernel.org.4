Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967C628ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiKNUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiKNUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:53:34 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10AF641F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:53:32 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h21so7594245qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ngVb8uJJUhIWa/AElJ6h2291IQqLZ5chCdSoy/INKDE=;
        b=PhXFGiSsGmxHsfpNFJxPmpLKMrwuwOxrIoNKgXS8yxdt4zZ+zQocDot/VAmBZRcRwd
         +Er9IKtxkd5b4yBV1FZXD6hYoB8djT1LpbXoAABCHnXp639/rjrEM+Ga7L29L0dvBfq7
         HVavIgkX0TOX0bpYkUFxCHeywmLEhwiUkZAeD9iSAVoRKkac5zqzcSpUCRJ0BY/PFEkJ
         vr7oSrENMmtwEE6kGOFo9VuDjDTqaTSPF8YeVWtuO/04qIsM2xWApVCNaNgiVok/H9z2
         tHqU/UZdUPAq7FEfBuJJ3W0GHFDierX0shummOoBdytqhPnu08YPaIOtvp5ZVg0n4uJT
         YFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngVb8uJJUhIWa/AElJ6h2291IQqLZ5chCdSoy/INKDE=;
        b=Zdqqwje24kO13EvWNlDhXtlWl3OgxOx1NJ/ooJW+/uD0EN9Ze/XfNtsY7k5ouVHWI2
         BSB5UNSC5VavtSI+JVpsibJyeU2yKGJD0iGmFPYYKRpUU0tHvb/832xe4GVSH0umFHXv
         aJuf/tCPvXxsmHQk5IFUr493cTIkOFLXi3fmE3gCD2twktIMsRvBKXwN+mSxY+XXIHJL
         ScF7LlpShy3lk1KOZshsMj7PJ1BcNY69l/sg5jpVFA9d5qK9Q7Xh8Abc8j4ePW0DZ3Gs
         6eQR2inHn97Ou67YNrw1XM6yIxgdzc0/fpfBrVvHNuGYq6j3FVn/aGr9HBb/y/sSu3xy
         EkKA==
X-Gm-Message-State: ANoB5pnDpqfuzVUpBCQD5Jtf3PzcupwVQq3tJlHa9V8seY9lLRAP3cT0
        0giquXWaJqVlFyeeDtyiqxaC6/IZAPA6SCmf4l8RyA==
X-Google-Smtp-Source: AA0mqf6ZpX+mewvYmqni2zCZ+IZNgjxtvuLekIvqhVROT8s8B9nU/CXu3Tp34Ctxu1ZQuBcF9tfK5QcKTEmOcA28D8M=
X-Received: by 2002:ac8:67c4:0:b0:3a5:2e13:bd82 with SMTP id
 r4-20020ac867c4000000b003a52e13bd82mr14080023qtp.480.1668459211981; Mon, 14
 Nov 2022 12:53:31 -0800 (PST)
MIME-Version: 1.0
References: <1668396484-4596-1-git-send-email-yangtiezhu@loongson.cn>
 <1668396484-4596-3-git-send-email-yangtiezhu@loongson.cn> <Y3J7KW1xQc7aO18/@google.com>
In-Reply-To: <Y3J7KW1xQc7aO18/@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 20:53:20 +0000
Message-ID: <CACdoK4LhwrGqYHrOV6a42wHkX1=jqMWVhFa-b3QZ8P=1kMxcSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpftool: Check argc first before "file" in do_batch()
To:     sdf@google.com
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 17:30, <sdf@google.com> wrote:
>
> On 11/14, Tiezhu Yang wrote:
> > If the parameters for batch are more than 2, check argc first can
> > return immediately, no need to use strcmp() to check "file" with
> > a little overhead and then check argc, it is better to check "file"
> > only when the parameters for batch are 2.

Thanks for the patch

> Seems fine if you respin with is_prefix instead of strcmp.
> Has the potential of breaking some buggy users which pass
> more than one file, but I don't think it's a good justification
> no to do the fix? Quentin?

I don't think it could break, the argc check is already enforced
(currently after the check on "file") and no more than one batch file
can be passed. I'm not sure it's super useful to swap the checks
either, because you can similarly argue that there's no need to check
argc is <= 2 if the first arg for "bpftool batch" is different from
"file" (or a prefix). The argc check is faster than the is_prefix()
comparison, but that's a minor optimization for one specific error
case. I don't really see the point, but I'm not opposed to the patch
either if you repost with is_prefix() as suggested by Stanislav.
