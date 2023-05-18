Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33787707A11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjERGIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjERGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:08:33 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B3D2698
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:08:31 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-783fdeed241so345385241.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684390111; x=1686982111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aSWZec/J0A95SxR8LujGdt3ORI4eM1n8G0sqzEOmKqg=;
        b=VvJmt+2iJDjTXM5TCSHqebEa8w0nj/TQ09XLTx9AC1hDxo19cs9nvpCu0NVXOd6iEQ
         2N0zEb/cv9ZznUf5cHO7bkzs9tfI3IJEdBhUkVbwHre/96lT3/TdqSy5p2Qt1CV/2QfK
         1MRNQd+iDHqlIUSvzO6oc0muLxWQ26H1wk8mdQOmoKgTbZx0SgBCkckRBYHXThqEjJd0
         b91FlwpFFL6Y7uQSAIgrSF6Gjbb9nLJrwB9Cd8CZAsv8EoUJ2Jn2S/ch358KVd1nKTfH
         Oh3y32wtrvvPLf89kPKQphChPENIwRHyBqX/6aZqnwq5YxIr1KttsW+JHKVY7KGl5pAg
         IxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684390111; x=1686982111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSWZec/J0A95SxR8LujGdt3ORI4eM1n8G0sqzEOmKqg=;
        b=hfmpyp58ZrO/xwtD8o8LE0kRQ3FgqIqnMsMsDfYyZ2vlghBiUyw9hC1W7sTRUnBLuY
         c7wprwxHn1xMuxAOPNBHysgsM6FC4dR/mXzjxezydnEmlTvyypWmXbRoq1dGxGAIJa7M
         G589JnQldtHWVG6meuvTrdDyMt2RN5Cx/IxsRtJ8a4UlD7uf/M4zxHsb0q2mJPFfSMVD
         j2gzHxfqgiaZaeaYilUSfKcCjooKOZE/MOJj7X5WcZmuhXB/rFY8dj97wIeK6CvWd7e4
         kOrssbeVeTm6nHYTdD9YthbOa2f9/Rxl+8fJV2bmoJ/Dy5DYgqxUtFrx6f1K4rB4hddm
         fQ8Q==
X-Gm-Message-State: AC+VfDzfTnX7jDUiLn2iSxY49ejl/v88cPT5yQXAnYRwNGAeuGfw7HjQ
        3+Xo+emC53ZvcU3vemiJGSHgzbvAPw5sZczFLc1kLQ==
X-Google-Smtp-Source: ACHHUZ7vGQz7U1QKUL4G8JAwAxA4rm9CtFFkMegAQAGOmllOFW+EzKiyuTcXNAw+DMEHAgEuXjccFvVT54t/e+su+qc=
X-Received: by 2002:a67:ebcc:0:b0:434:768c:4966 with SMTP id
 y12-20020a67ebcc000000b00434768c4966mr157942vso.8.1684390110959; Wed, 17 May
 2023 23:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org> <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org> <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org> <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com> <ZGWnq/dAYELyKpTy@infradead.org>
In-Reply-To: <ZGWnq/dAYELyKpTy@infradead.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 May 2023 11:38:20 +0530
Message-ID: <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
> > In general: if user space controls it -> possibly forever -> long-term. Even
> > if in most cases it's a short delay: there is no trusting on user space.
> >
> > For example, iouring fixed buffers keep pages pinned until user space
> > decides to unregistered the buffers -> long-term.
> >
> > Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
> > unpin in essentially one operation.
>
> Btw, one thing that's been on my mind is that I think we got the
> polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
> behavior it really should be the default, with a FOLL_EPHEMERAL flag
> to opt out of it.  And every users of this flag is required to have
> a comment explaining the life time rules for the pin..

It does look like a better approach to me given the very nature of
user space pages.

-Sumit
