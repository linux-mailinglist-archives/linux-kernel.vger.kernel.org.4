Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630A7688743
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjBBTAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjBBTAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:00:50 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE412F19
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:00:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r18so2003782pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p3ZYbtaIavkAf5aV8P1noUyCGHCi0NGSeVESNHvFnYY=;
        b=tERd3yuEcFjOGwSs1S4VXGdkVqpN6d4UcJwqaiEYucEdFffjmVwx6IDBVLa7XV4kOY
         nkeXbAEzLNpaYr3MNTHiUQ8AU6tUR3k35WlLLOUxlKQYXW1vs7nUDrTUnF75dZCDdl3o
         Vgb3Jmf8Oj2ZVHxRhbmUPbn+Wq6fNVwAlOjMd2lxhqQwYZsk471YYelimQvNaCIsbFtR
         97gVJnMI13LURT+JSYWHTIWHKmrVE0AkyLru+Y6TE74DiYtQBmSakWGDyIk6aOfMhCTv
         ZcAes6tsNcN4zMcgAOcWyvVFf1+5DdwWbLSuazZCgEA3RdGPwAcIUl50DbZA5YxsBPnw
         Jx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3ZYbtaIavkAf5aV8P1noUyCGHCi0NGSeVESNHvFnYY=;
        b=5XyXjeyYtCfw+G3LCzylvJSkLFMMJUntTaNqv+WpCeiKtneLxpzPS/1CWh9nLnyDZQ
         0dPTFt+g4fmVhq2dxpRSiFzH5WBzOp0tLQTbhYo9gBrBGis2yCGQnv4qENyfXOqeGUg2
         PzjyZqfQ71yJyse+whl7wBluGvIHOoSxw77kYkHuu9PbeIB0mEuKtCVBYA67O57RQqyh
         Q70bUH3fHs13FGfKmZij/1CWBF06UObQLghCQDl1Lc+AnDZ3z2DfCjDoCOtAYPz6akiN
         GqdiDdk85lqedHSJw3gTFrNByCe4JNzgh241X3vL7bRXPdsowH14HNzSkn1AITq3ejwk
         7gkA==
X-Gm-Message-State: AO0yUKUaeKsgid+D5xl0GV+PiqRFrPGI8qtRTfUobmjyma+YgCjyGyVf
        mWBBvEGK3qr4Uupu3CvgC8OdYFBp/pdy2YQxEAn7Jw==
X-Google-Smtp-Source: AK7set8NvDoA9gf4AicHigBtu9UpVuZVLhwEfuP2Vzy2j1FjpsC9TsZ1y3DDjZctSawx3/ctiEaprHJ0rsQLVFXvU3g=
X-Received: by 2002:a63:dd43:0:b0:4da:af6:ed with SMTP id g3-20020a63dd43000000b004da0af600edmr1187478pgj.30.1675364449073;
 Thu, 02 Feb 2023 11:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20230202-dm-parenthesis-warning-v1-1-ebdee213eeb9@kernel.org>
In-Reply-To: <20230202-dm-parenthesis-warning-v1-1-ebdee213eeb9@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Feb 2023 11:00:37 -0800
Message-ID: <CAKwvOdnffHbU4ObT2jDr_iASEC==CUsX2FfqdA-+iLU4y5Ma=g@mail.gmail.com>
Subject: Re: [PATCH] dm flakey: Fix clang -Wparentheses-equality in flakey_map()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     agk@redhat.com, snitzer@kernel.org, trix@redhat.com,
        sweettea-kernel@dorminy.me, mpatocka@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
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

On Thu, Feb 2, 2023 at 9:00 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   ../drivers/md/dm-flakey.c:369:28: error: equality comparison with extraneous parentheses [-Werror,-Wparentheses-equality]
>                           if ((fc->corrupt_bio_rw == WRITE)) {
>                                ~~~~~~~~~~~~~~~~~~~^~~~~~~~
>   ../drivers/md/dm-flakey.c:369:28: note: remove extraneous parentheses around the comparison to silence this warning
>                           if ((fc->corrupt_bio_rw == WRITE)) {
>                               ~                   ^       ~
>   ../drivers/md/dm-flakey.c:369:28: note: use '=' to turn this equality comparison into an assignment
>                           if ((fc->corrupt_bio_rw == WRITE)) {
>                                                   ^~
>                                                   =
>   1 error generated.
>
> GCC only warns when one set of parentheses are used for assignment
> expressions, whereas clang additionally warns when two sets of
> parentheses are used for equality comparisons. Remove the extra set of
> parentheses to silence the warning as it suggests, as this is obviously
> supposed to be an equality comparison.
>
> Fixes: 0e766389cedc ("dm flakey: fix logic when corrupting a bio")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1798
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> I do not mind this change being squashed with the offending commit, as I
> noticed it was Cc'd for stable, which would minimize the chance for
> breakage.
> ---
>  drivers/md/dm-flakey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
> index 08f9aa476d97..335684a1aeaa 100644
> --- a/drivers/md/dm-flakey.c
> +++ b/drivers/md/dm-flakey.c
> @@ -366,7 +366,7 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
>                  * Corrupt matching writes.
>                  */
>                 if (fc->corrupt_bio_byte) {
> -                       if ((fc->corrupt_bio_rw == WRITE)) {
> +                       if (fc->corrupt_bio_rw == WRITE) {
>                                 if (all_corrupt_bio_flags_match(bio, fc))
>                                         corrupt_bio_data(bio, fc);
>                         }
>
> ---
> base-commit: 6f30cc248507ee96c22ff4c3cbc86099ff12b7a9
> change-id: 20230202-dm-parenthesis-warning-6139f4b5020b
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


-- 
Thanks,
~Nick Desaulniers
