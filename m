Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B57967F131
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjA0WgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0WgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:36:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A647962C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:36:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p24so6376850plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hg9InPQN4tioHiMOdnKqvlrPm/hTugTIRh5hdEkItHk=;
        b=IkBYUtYDZafcPWMLulxZiUJSeNAA86Kv8Xpi33/kVI4jpXr82P4LQyDIDQABFSUhas
         17MmT36jpLUUQAtas8M7WDGmlJi9YAfYXks0Zx9284ToWbnGxty13qfnO0lfwxAWw5G+
         XmsoPUQ++jfe8+g/sdKeTkDE3eiJNE4Yfb0OHE9yJ5Bv6krz6EFTKnbjpLvTzK7ZFLyu
         H2cIrJ1hsKIq2/P/mfcfHdyWqV1v73KsC2h/vEJvs6GeCNhTmykcht2XBSa19lfgH8ax
         MZ7PXY2xBsRaxyDJ+e3G/9/39QKW/VOdGZI5Igvu/s3houV1VAvscksWTGUw2lUpA9ci
         yEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hg9InPQN4tioHiMOdnKqvlrPm/hTugTIRh5hdEkItHk=;
        b=KL9q8ZcoU5v8M6e0aR9J/WcY+GQrod+z1VWy6/RQdbEie4bIN2G4mKYQf9hMmyWmtY
         liOyOB4tjlYAJoAO9kPFdut+elEwZqMXqw36mOtO+4cldY1hIvq3XyOXkaUcTejhJllf
         ywys0vazazZ81foYQ09UIv9mrR4CHEDNckZUcQ09FC9EtPBzsyh9SQkCZKlnwyg81zKm
         dwlWxdOJYsW6HlIsX/FNg7OemIbYhl0rTZXiYzHp2Rf1F2B3uLbeXSbOJDkkAhnPTOA/
         3zBPmimUS9sUBkiZSljgTQaf1x20GAJZ8eO44G51D7WGQJWgAo+6FTzRitqponbm8XE9
         lorw==
X-Gm-Message-State: AFqh2kqoJrSRtv7y7RhIkKlymWu+jZi0mmeBXgpConUbXAh2AtFIOujj
        /kk6yvNFkneb9wotUhBZo2OVwCM2STYiBqqNrZlN0eRF12rk
X-Google-Smtp-Source: AMrXdXvzWbZmDFbaDAfHsJMk2b5d62SU6fcAEF0ZvE0if6bNDtDttm18NnlrjsNl8TDbMsKuTJp/ByVLd+bOX8i8ai4=
X-Received: by 2002:a17:90a:5b0c:b0:223:fa07:7bfb with SMTP id
 o12-20020a17090a5b0c00b00223fa077bfbmr5371755pji.38.1674858963877; Fri, 27
 Jan 2023 14:36:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674682056.git.rgb@redhat.com> <68eb0c2dd50bca1af91203669f7f1f8312331f38.1674682056.git.rgb@redhat.com>
In-Reply-To: <68eb0c2dd50bca1af91203669f7f1f8312331f38.1674682056.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 17:35:52 -0500
Message-ID: <CAHC9VhSZNGs+SQU7WCD+ObMcwv-=1ZkBts8oHn40qWsQ=n0pXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] io_uring,audit: audit IORING_OP_FADVISE but not IORING_OP_MADVISE
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:24 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Since FADVISE can truncate files and MADVISE operates on memory, reverse
> the audit_skip tags.
>
> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  io_uring/opdef.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index 3aa0d65c50e3..a2bf53b4a38a 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -306,12 +306,12 @@ const struct io_op_def io_op_defs[] = {
>         },
>         [IORING_OP_FADVISE] = {
>                 .needs_file             = 1,
> -               .audit_skip             = 1,
>                 .name                   = "FADVISE",
>                 .prep                   = io_fadvise_prep,
>                 .issue                  = io_fadvise,
>         },

I've never used posix_fadvise() or the associated fadvise64*()
syscalls, but from quickly reading the manpages and the
generic_fadvise() function in the kernel I'm missing where the fadvise
family of functions could be used to truncate a file, can you show me
where this happens?  The closest I can see is the manipulation of the
page cache, but that shouldn't actually modify the file ... right?

>         [IORING_OP_MADVISE] = {
> +               .audit_skip             = 1,
>                 .name                   = "MADVISE",
>                 .prep                   = io_madvise_prep,
>                 .issue                  = io_madvise,

I *think* this should be okay, what testing/verification have you done
on this?  One of the things I like to check is to see if any LSMs
might perform an access check and/or generate an audit record on an
operation, if there is a case where that could happen we should setup
audit properly.  I did a very quick check of do_madvise() and nothing
jumped out at me, but I would be interested in knowing what testing or
verification you did here.

-- 
paul-moore.com
