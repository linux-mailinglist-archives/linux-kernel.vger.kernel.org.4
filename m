Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA376C896D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCXXl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjCXXlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:41:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3D12CD2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:41:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er18so2625378edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679701282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blNmP7fzJBK5OFePYsB620CQcO46wrdWBDUrlFUHYQQ=;
        b=UqHwrfg02dC+olMypt934/3zePsBsXN2nDW/vQzaPMUvdiokkPnutN7c4KvMq21kjf
         gaNkP3+PsOVbTnBJ6RqFocRyr8R9XR5OGlcJMpCHV1f5sP4KY/b0/WC0c4q6v7L0LWaL
         3WKyYZM2g5QeJuoSmBSyjc7U7/iVtTRZt9WcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blNmP7fzJBK5OFePYsB620CQcO46wrdWBDUrlFUHYQQ=;
        b=oQs0uxXl++qD3lUgPhKRnGM/AQEf5gMTfRv+UnXWiuDWiMZFPUBz85LfiFYxBKIsi9
         MLSRk5ztZ1uvkaw37xnz488G+a48XSM1HwB+MP36rDrWvgqhAompQHeuTreE1Q4JBovH
         e4rDoE+y1mBo+fWz9lX293NzUEHChpug3l4ic9oJA1MQD8YC/HFRFbpuQKKNCP9xgQCX
         XdZE+RyBM5DTyq/Hjs6rtUTydemqH6QHxqCG1H1Rj4TABHlJJdpZujMb0ivPu8pKlB9x
         3jAvG20/CBAeZ0MpXpla9lMtWAWlLVYQbR2Sw0yiHW/DJyY6+tTmIrJJTmWSE05Ac40n
         lvIw==
X-Gm-Message-State: AAQBX9fvJcbMCPOyjWPB9r+rDRIMvVDGTpExtzKzOUp5YtZP8BHL9mHc
        PIpiZBzYvIx+4hU5VpNW/j7CnJpACCd05m2dEFZjWvQ6
X-Google-Smtp-Source: AKy350aCyitw1JDyp7ClSpjDIrFVOeP6fNHYdqklSGj4U8aR1Iab2gkZP1mbLnV4v5Ii8T/Im7Nm2Q==
X-Received: by 2002:a17:906:4b51:b0:92f:3e2b:fbb7 with SMTP id j17-20020a1709064b5100b0092f3e2bfbb7mr4346361ejv.14.1679701282436;
        Fri, 24 Mar 2023 16:41:22 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b0093e9fb91837sm1018479ejc.76.2023.03.24.16.41.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 16:41:21 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id i5so14063592eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:41:20 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fa:da46:6f1c with SMTP id
 f17-20020a50a6d1000000b004fada466f1cmr2400386edc.2.1679701280484; Fri, 24 Mar
 2023 16:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org> <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com> <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org> <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
 <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org> <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
 <ZB4SoxgM6vydrxrj@bombadil.infradead.org> <ZB4x6IY/8P1Xam7d@bombadil.infradead.org>
In-Reply-To: <ZB4x6IY/8P1Xam7d@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 16:41:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsBkyD+y_zfif1MXWYEkvPt+TPLdVjP41573oKEOu4qA@mail.gmail.com>
Message-ID: <CAHk-=wjsBkyD+y_zfif1MXWYEkvPt+TPLdVjP41573oKEOu4qA@mail.gmail.com>
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted allocations
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 4:27=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> A magic values of 20 is completely empirical.

I suspect a magic value is fine in this context. I do not believe that
"hundreds of concurrent module loads" is a valid real-life load. It
sounds more like a "systemd does horrible things at startup".

20 sounds plenty big enough to me.

But I guess this is one of those "only real life will tell".

              Linus
