Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FB0607D91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJURbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJURa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:30:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08F1DCCD6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:30:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f22so2091223qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKY1L+lJIm4gPIxJdoGGbk/A7TDtsvdp4yyzJCKLBqM=;
        b=JRbXxQcsHuXNTo4JRd4r631w0scHbQpGmP/39nHpYieavieNk4jUPngmABP9sTEHFj
         6PWhkBdteDM0nqif6TGLlmPSRtEApQVMhKNR88q3OEInoDgh8NwHSxNcSU52UzHR6sY8
         dFofSJNlVbDCkSLnOAr4UJ64KMsV2vvhJZcWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKY1L+lJIm4gPIxJdoGGbk/A7TDtsvdp4yyzJCKLBqM=;
        b=NFvYIgUx+k8YPrQnxQYsrCrTyyfL6gggf8DiGtm0DNuTcS4JsQH1fGbqQomE6q4K9q
         uCOpxd1Gsz+wC+Eof1mRhYVSLyBYBn/ISXZykLBprdwQrows21TPpniFnmb1FIus0qbP
         4Thy8zvJn0/W7lfVCGoVeAeaNMuo3ptsxKBr9wDH7KoXkz77eyTWt4CGSwHkX0Twqokc
         JfvUyUhSy0ltg3+oQprLBWz09j+aduXy/7yqVcJQKWO4nG8jt85ed9xXaS8mhGer8OQJ
         +2rdoWx7JM7YwNwgGAA1zEVO8ZPxoUZyp3gagY23XVsmlfKTjmHcNyrZIVva7+urKBIg
         nj2Q==
X-Gm-Message-State: ACrzQf0rMme8VcPDsbtyWDySmgMI61tNTJKZVXFenF9oVFdrqUPUmWxV
        2YV+y4940oICx0NSjkDABG9B4VBXGqOyRQ==
X-Google-Smtp-Source: AMsMyM4VNgM//HKy18IQtCTGlee/EvRmUAaMYWMsOskHp2R0YO5c5KgShLXPJtFIHpHcxIZpgHDHMw==
X-Received: by 2002:ac8:578b:0:b0:39c:f006:3563 with SMTP id v11-20020ac8578b000000b0039cf0063563mr17062438qta.636.1666373455545;
        Fri, 21 Oct 2022 10:30:55 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006cfc9846594sm9790087qkg.93.2022.10.21.10.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 10:30:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-36a4b86a0abso13951217b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:30:53 -0700 (PDT)
X-Received: by 2002:a81:6088:0:b0:361:52e4:dec8 with SMTP id
 u130-20020a816088000000b0036152e4dec8mr17641670ywb.352.1666373453275; Fri, 21
 Oct 2022 10:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
In-Reply-To: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 10:30:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
Message-ID: <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The function handle_control_request() casts the urb buffer to a char *,
> and then treats it like a unsigned char buffer when assigning data to
> it.  On some architectures, "char" is really signed, so let's just
> properly set this pointer to a u8 to take away any potential problems as
> that's what is really wanted here.

I think you might as well also remove the cast that was always a bit odd:

                buf[0] = (u8)dum->devstatus;

although maybe it's intentional ("look, ma, I'm truncating this
value") because 'devstatus' is a 'u16' type?

I suspect a comment would be more readable than an odd cast that
doesn't actually change anything (since the assignment does it
anyway).

Or maybe people wrote it that way on purpose, and used that variable
name on purpose.

Because 'dum' is Swedish for 'stupid', and maybe there's a coded
message in that driver?

                  Linus
