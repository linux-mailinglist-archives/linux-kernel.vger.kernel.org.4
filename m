Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2D68FCFA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjBICPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjBICPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:15:06 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2185F273C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:15:04 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h4so533513lja.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR54mJXwASvQGnAdij+ZNHiNC8eGa7TLZRG1R8sZ1FE=;
        b=CGN/82Z0Rf2APBROkVXBhyeM/niTSI8x1hqX4A2fudHYjjDuyT2/rKROdDEYgYmFTI
         Fw66UeDlGPJ1sOM+AaZtSJZuWBo3A5lcBYMDjQbQjMY6Z/1o6EUNPOYB7+asfROVfo8Z
         32rGO9TlqQ03qZfuAhF9IPX0sWUwTYCnT1U03OCCsYVze0ZT2lCfN55VY2w69qManxY8
         8GxP5U8z0TIZ6GFEBEyZfiVirNoKAV3u3wulYD/legsWhveNsCdF1pXutvrDIzgQ99pp
         6Dc+1dglsYQpmxHcU4pigvLC7cCeK3LHq6IF3KYglPTZhdSmva3SXbd/bbmrVMmKn9FZ
         p0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZR54mJXwASvQGnAdij+ZNHiNC8eGa7TLZRG1R8sZ1FE=;
        b=h3z28y9/Og/srqqWEwj/TQ0S3a45IWv5qlMF6nD48yciTiwQF7Df6+PPSJE0vXurxg
         n14cFoTb7IbKOqVoZY6vw5bVE2I55yEnpFTnNtjs+6TqPS42x3RmwjqJye+shAuS3soZ
         pco7QZS/qBaVAc2cx9dC6dK+JFhcz6pyCDG8bD6LMWXHOx3u8OHwtJ4pjWgii15VIxAW
         rdWaWKlmgc9MkngpMvN8jDFhFJmUskurSKyjmAtFcvaIuU4s9ed4d9iN6UHiG+hKHRII
         wtpJ1o5CerlU0Twlrs9O42U4+/eRh/mCOglOBb3lmZnkBKP7lkzmqF48A+R2R0rlvRub
         p+aA==
X-Gm-Message-State: AO0yUKVLu+SEHsVL7HaNTtsG9DpWP4O77puSqPlsj5AKZqoOBH3MiLRs
        5sSAAVLnO/LqlVeSsJ+J1HlJlb4F3725RPNtpms=
X-Google-Smtp-Source: AK7set+agdxY6pTTDEx797/vZ5UWomhA83EIT9xQ1l9iTwj7V4rHHdxzX0o/dedbejg+xZX2FUN6KBI/fg3c9kt1JUs=
X-Received: by 2002:a2e:8e6c:0:b0:28e:bba7:22dc with SMTP id
 t12-20020a2e8e6c000000b0028ebba722dcmr1669351ljk.56.1675908902331; Wed, 08
 Feb 2023 18:15:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675851111.git.chenfeiyang@loongson.cn> <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
 <de9439e489684965989ac4e96b87de41@AcuMS.aculab.com>
In-Reply-To: <de9439e489684965989ac4e96b87de41@AcuMS.aculab.com>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 9 Feb 2023 10:14:50 +0800
Message-ID: <CACWXhK=VXaMixrDTdo-ydgGw64vemu9kNUws5ef-91TFf-GPGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() when available
To:     David Laight <David.Laight@aculab.com>
Cc:     "w@1wt.eu" <w@1wt.eu>, "paulmck@kernel.org" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, 9 Feb 2023 at 06:39, David Laight <David.Laight@aculab.com> wrote:
>
> From: chris.chenfeiyang@gmail.com
> > Sent: 08 February 2023 10:18
> >
> > loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
> > openrisc have statx() and stat64() but not stat() or newstat().
> > Add statx() and make stat() rely on statx() to make them happy.
> >
> ...
> > +#ifdef __NR_statx
> > +static __attribute__((unused))
> > +int sys_stat(const char *path, struct stat *buf)
> > +{
> > +     struct statx stat;
>
> If seems wrong that 'stat' has type 'struct statx'
> and 'buf' type 'struct stat *'.
>
> Maybe s/stat./statx./ and s/buf->/stat->/ ?
>

Hi, David,

Yes, it looks better to use 'struct statx statx'. Thank you!
I'd like to keep 'buf' to be consistent with the stat() below.
int stat(const char *path, struct stat *buf);

Thanks,
Feiyang

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
