Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81C5F5011
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJEHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJEHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:01:59 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEB6DFAF;
        Wed,  5 Oct 2022 00:01:57 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id i16so2470244uak.1;
        Wed, 05 Oct 2022 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UHE5t3RzuZq9XWIvg02NUOpVAjCk9hgPmV9IZeL6AF0=;
        b=kP3f4YiUiDivevu4zAGXlYrKAOJlutMNKn6F5yIFF00YcICIH5rjJl0LBZT5GCCjsY
         69s/Bby2S72Hh7TBgL7MwHdMO0YQpgUh7FevpScA+LznPtgic6mmLxWx8UzxnKfRLKAV
         noMyp9oDFwwtsdzsxtp//jreujUdk889nkHGqvPg909Cp/3u12fgcN+CeroJg7y05qgK
         OXodXbrPEFrYc5ZJDbU/kvd7z9ZcivDaJ3Eude90UhwXHOZTQiKiQI1869Rc1KWBlzfR
         NSdzTujvLTApSxjzmBEQ3XMwKlaLluwAsp133cg9cK5dTJBw+NZjAY6OA5EMIkSx/Irp
         hDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UHE5t3RzuZq9XWIvg02NUOpVAjCk9hgPmV9IZeL6AF0=;
        b=NXFe7GJ62E0Yu1tPiMR0Xk6FAgBF2LOXX6RZIKqn1ugNCgAvjPyUmVBNLxQWkEVxZM
         6pAoN807nLFUNhdJEGK7tdqgzWGaecDYpjd1+fym71rSQrFGwQRKIFuVzM5ji4lydPfa
         rHREojp+wrO1PbrnAioaG7nE0daMEGCHzdXfcWAouTf7OhH9xYKLix5xzHOwqPIreBi2
         LBWOz62acdRqvd+UkNkb17RJ6KxSpC7/KsbXvrLfG1G5g6Xqdynr6BTg3m3ARKT/TatC
         TqTBcdq71zZVN75sym4f5FAZyGiaKrNo2KqQ1S31c3Xo2a7Pim/ufDoYxG+xpbxYm0fA
         IeIw==
X-Gm-Message-State: ACrzQf32vWa8zSnvbBIDIbuDcOIXr6QbHtzcCUnWuQSIIrc7qtjraNWd
        SZtTMDZE/ikioQd5no59eNk0Wq+o48JODSSIJJM=
X-Google-Smtp-Source: AMsMyM7opRWyJTc9JIX5uLYrdIGDJWkxhKLOsdSnzRVdpu9POeg0Wb6Q0q1K2dyoWLvENxdOt6ZXyzNGD5uCI3sPYcg=
X-Received: by 2002:ab0:992:0:b0:3cb:c597:48ff with SMTP id
 x18-20020ab00992000000b003cbc59748ffmr14169017uag.19.1664953316796; Wed, 05
 Oct 2022 00:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <YzzjKyHDuFoQAVCu@work> <202210042006.9A12D208@keescook>
In-Reply-To: <202210042006.9A12D208@keescook>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 5 Oct 2022 02:01:45 -0500
Message-ID: <CAH2r5muz9cGwtX5HF5wL0g9ix=cKs6C35BZObqMr6dgL-sOF-g@mail.gmail.com>
Subject: Re: [PATCH][next] cifs: Replace a couple of one-element arrays with
 flexible-array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Tue, Oct 4, 2022 at 10:17 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Oct 04, 2022 at 08:51:39PM -0500, Gustavo A. R. Silva wrote:
> > One-element arrays are deprecated, and we are replacing them with flexible
> > array members instead. So, replace one-element arrays with flexible-array
> > member in structs negotiate_req and extended_response, and refactor the
> > rest of the code, accordingly.
> >
> > Also, make use of the DECLARE_FLEX_ARRAY() helper to declare flexible
> > array member EncryptionKey in union u. This new helper allows for
> > flexible-array members in unions.
> >
> > Change pointer notation to proper array notation in a call to memcpy()
> > where flexible-array member DialectsArray is being used as destination
> > argument.
> >
> > Important to mention is that doing a build before/after this patch results
> > in no binary output differences.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> >
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/229
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Looks good to me; thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook



-- 
Thanks,

Steve
