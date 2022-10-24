Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7B60B6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJXTLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiJXTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:10:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05614237E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:49:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id be13so17953617lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsjvrp3iW2kypJVaihgadkCqWB0OZ1nSN1yf4zAR9IQ=;
        b=YLCExCka/3quqw/y/vbP2KQEbdHCeTUqBI/pm3H4b6QQIZGUfPxjdjaf0wX0ti2M4g
         vqMwn6zwpDcQBLwivoJoEyzCZrSbFMcG2mWSvihjDpthlnm167NiuPFdSxGYGTnTfzWh
         ymJwL0BO/H0ifbx6+s0W+8Uwi6uTatMmoKspZWSR4IdGhzuRBMjr/HQxgG8BGJeph6Ic
         9y3EdlfuT4BaNAB4S2A3Lt+Ef3c2Zr6sarlxQK70aQ5CB1YoKlbgFEutUFmya3oFEONT
         GnQmjUFn6w7kgt0YJxswlIUR/yWMUtv0XFYnkESxs4KMqfNIfHpJZ33duPew5eb11HmP
         rwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rsjvrp3iW2kypJVaihgadkCqWB0OZ1nSN1yf4zAR9IQ=;
        b=HjhX8VifiHTy5TbfpOcmAkhJwI283OHlgOv/JbP2LSQy/BDlW5ZafnupvA9HDVilAm
         srq8XgyUfAvQ5LI3gw/2LSAWF7tVxqLUBlyixhfHQzvf9KBlPr/rlcifNJij1igVpUAW
         AL1HXY3MSUjj5FdccjeoLmZAEacD/CVlmnD7TPU7zpt4cmb9XRqf+yFcKKYTFgmomn0h
         4P5bekxLT0X/HX00F8jGN5yxB3Es3+g8zjaY/3pzd8yu63tFb+cCy5VcYdIRnAmCv/zZ
         Hsqtoej+TZPQ6UTXECE76n4S+jGC2Mfa+s/enLIcRZq0b3uTwfPnfc9WLI2m4NBAmmb3
         ynrA==
X-Gm-Message-State: ACrzQf1B+wDRwa4aBbmo02qoZt6/GVmINrxfJElIpgQHPRA4PVtfPhId
        4B6A+P1V09yPgfgwr4kzclwmRoo0QsaCfwdf7Unnmt7+qTxMzA==
X-Google-Smtp-Source: AMsMyM7sSpnp3OdyoCGSy/epo9odNWguoqqalz1vsaZgcUVCODKVFmSNmbmuB0NJst44GgZd1Plopgf2ZNo5vrjaa2c=
X-Received: by 2002:a05:6512:2282:b0:4a2:7dc5:6630 with SMTP id
 f2-20020a056512228200b004a27dc56630mr12195159lfu.645.1666629892982; Mon, 24
 Oct 2022 09:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221024150922.129814-1-gautammenghani201@gmail.com> <20221024111621.3ba17e2c@gandalf.local.home>
In-Reply-To: <20221024111621.3ba17e2c@gandalf.local.home>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 24 Oct 2022 09:44:16 -0700
Message-ID: <CAAa6QmSKtj6T2dW1tkg5_HVj2+rXj5inOLdEzr0MkJzQxxcPXQ@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: add tracepoint to collapse_file()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        akpm@linux-foundation.org, mhiramat@kernel.org,
        shy828301@gmail.com, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your mail, Gautam.

> I try to keep dereferences out of the calling path as much as possible
> (adds to I$ at the call site).

This was probably due to the way I handled
trace_mm_khugepaged_scan_file(). Perhaps that can be cleaned up at the
same time as this patch, for consistency.

Also, no qualms about adding this tracepoint; there are a few scan
result codes that overlap between hpage_collapse_scan_file() and those
possibly returned in collapse_file() such that, if we only have the
one tracepoint in hpage_collapse_scan_file(), it could be ambiguous
what callsite the error path stemmed from. Luckily this hasn't been an
issue thus far.

Lastly, a few other items we might care about capturing:

- is_shmem (perhaps the filename is enough to know this - but I know
at least once during development I was caught off-guard b/c a mount I
thought to be file-backed turned out to be tmpfs (and something I
didn't think to question until I had wasted some time on other
paths)).
- index

Best,
Zach


> Could you just pass in file, and then have:
>
>         __string(filename, file->f_path.dentry->d_iname)
>
>         [..]
>
>         __assign_string(filename, file->f_path.dentry->d_iname);
>
>
> If you are paranoid, you can have the above also be:
>
>                         file ? file->f_path.dentry ? file->f_path.dentry->d_iname : "(null)" : "(null)")
>
>
> -- Steve
>
>
> > +                                   nr, result);
> >       return result;
