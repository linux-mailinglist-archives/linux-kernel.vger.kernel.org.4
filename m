Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7B679F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjAXQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAXQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:50:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88946735
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:50:53 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v19so1001742qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcOp8zyil3pWriy3DlCZcCWX0BKo/EQlllqJn2itDhU=;
        b=XMZnv57FFlW/8DP3GzKZcYJqtSAnU3ltiqRs6kOnzb17LLhdNsdByR1qsb8V3yCLoA
         kjvzL/UvnIRGMd/l9mcFro/sBo7GgSoD0e10N1GFRA/d9FuooB5NTGtdjWBfrRQDKnc5
         nJWZx6FDnJynmGWBFKYJ+K5RTU4ljksQee4ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcOp8zyil3pWriy3DlCZcCWX0BKo/EQlllqJn2itDhU=;
        b=KNkQXEf+g0SdzvzF5Wz0UDVPxZw2OM59OmR6rvTvtN6yh5kO2Wl7oYm3b9UM90vUM7
         2mDYx0QrbJHDIAEBIwoLZXvo+kk5iDq30Nx5pqnKjXwYT+hXWue7WfB3a6jfyRROtWDI
         uh5gWT75NE7yzd0jT2Ylrf58DvQLb2zoALTCvU+1hRwZ84ADtjzgf8cV+JdfBed9lLSK
         y7e1GNGU/mEoHixCNxbiJQ97GFos6hZcVQZyHnjILMZDACZnMF6bCvoAGmPXfEmvkTWc
         hHf5cMdku+8qolcRWcgFp7PW6SFD+rqfmhGrgvyOlbRY4ptC6QIb4QUU6wV1L80gspi7
         sApQ==
X-Gm-Message-State: AFqh2kq7y8l8TQxrKT0WBWdWyoswnwOqSVvdHatMl8O70SuYSCzleeCZ
        jwtnMuTFGYlSLqIwcZYiu7kHACXwedzx1/K9
X-Google-Smtp-Source: AMrXdXsUryYgobAwlHTS3TcDdLl84I+mBmeFmfeHNnx4hgt5lpXCG7nLtpZCnrX3hatanyzH2n3n8w==
X-Received: by 2002:ac8:550a:0:b0:3b6:3022:688e with SMTP id j10-20020ac8550a000000b003b63022688emr49253825qtq.53.1674579052131;
        Tue, 24 Jan 2023 08:50:52 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a07ec00b00706b42c0842sm1716566qkk.49.2023.01.24.08.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:50:51 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id z9so8436490qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:50:50 -0800 (PST)
X-Received: by 2002:a05:620a:144a:b0:6ff:cbda:a128 with SMTP id
 i10-20020a05620a144a00b006ffcbdaa128mr1503997qkl.697.1674579050396; Tue, 24
 Jan 2023 08:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20230124134131.637036-1-sashal@kernel.org> <20230124134131.637036-35-sashal@kernel.org>
In-Reply-To: <20230124134131.637036-35-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 08:50:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
Message-ID: <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 35/35] ext4: deal with legacy signed xattr
 name hash values
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>, Jason Donenfeld <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 5:42 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> [ Upstream commit f3bbac32475b27f49be201f896d98d4009de1562 ]
>
> We potentially have old hashes of the xattr names generated on systems
> with signed 'char' types.  Now that everybody uses '-funsigned-char',
> those hashes will no longer match.

This patch does not work correctly without '-funsigned-char', and I
don't think that has been back-ported to stable kernels.

That said, the patch *almost* works. You'd just have to add something
like this to it:

  --- a/fs/ext4/xattr.c
  +++ b/fs/ext4/xattr.c
  @@ -3096,7 +3096,7 @@ static __le32 ext4_xattr_hash_entry(char *name,
        while (name_len--) {
                hash = (hash << NAME_HASH_SHIFT) ^
                       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
  -                    *name++;
  +                    (unsigned char)*name++;
        }
        while (value_count--) {
                hash = (hash << VALUE_HASH_SHIFT) ^

to make it work right (ie just make sure that the proper xattr name
hashing actually uses unsigned chars for its hash).

                    Linus
