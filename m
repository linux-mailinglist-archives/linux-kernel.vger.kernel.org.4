Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22F06A8ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCCBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:37:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A36A5F0;
        Thu,  2 Mar 2023 17:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E03A1B8161C;
        Fri,  3 Mar 2023 01:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8AEC433EF;
        Fri,  3 Mar 2023 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677807474;
        bh=20VXKyNfJN9zSFhzr0rYOP4ot/127qDIv810fbKi6ko=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fDamD9pnsAdrgaMFHDZ3NISCI+thvyvYKOjUanl9RYYazBT1nfAita+/5iTn09glh
         WZH6HUy/g0F0+SBYuoKFs/thaXR/L0Gvi4uaT7DtgVQqhTTS4irRvSIg436gxjCLXD
         867paPtEvE31Iy32v704vfuN6rJoZFs3hrZC0rmLmj1DFRGOH5Kmbo7o53jGrp4QYx
         DZExRsgIyi0b3b6m7ZmM6WUKNSiTdlfTQC7b1uTdtXM2eM9CbNR9yWfAUvf+afETDk
         iIjgSBkdtESUqfTCKV8FySngG29XfjAjzhSn/LCf+vJn4d13TMyO9CYfP8c5iau6Hc
         zSG/XXrYOcaTA==
Date:   Thu, 02 Mar 2023 17:37:51 -0800
From:   Kees Cook <kees@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>, Puyou Lu <puyou.lu@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Improve buffer overflow reporting
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdkfCQJcpx3zh0pwHfnBP2v2ieqxqTUzOUyW14s3Xsaf-w@mail.gmail.com>
References: <20230302225808.never.375-kees@kernel.org> <CAKwvOdkfCQJcpx3zh0pwHfnBP2v2ieqxqTUzOUyW14s3Xsaf-w@mail.gmail.com>
Message-ID: <35F16A63-E946-4467-AD4D-D5E1331EA4D5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 2, 2023 3:21:11 PM PST, Nick Desaulniers <ndesaulniers@google=2Eco=
m> wrote:
>On Thu, Mar 2, 2023 at 2:58=E2=80=AFPM Kees Cook <keescook@chromium=2Eorg=
> wrote:
>>
>> diff --git a/include/linux/fortify-string=2Eh b/include/linux/fortify-s=
tring=2Eh
>> index c9de1f59ee80=2E=2E981e2838f99a 100644
>> --- a/include/linux/fortify-string=2Eh
>> +++ b/include/linux/fortify-string=2Eh
>> @@ -170,11 +170,13 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, =
1, 2)
>>  char *strcat(char * const POS p, const char *q)
>>  {
>>         size_t p_size =3D __member_size(p);
>> +       size_t size;
>>
>>         if (p_size =3D=3D SIZE_MAX)
>>                 return __underlying_strcat(p, q);
>> -       if (strlcat(p, q, p_size) >=3D p_size)
>> -               fortify_panic(__func__);
>> +       size =3D strlcat(p, q, p_size);
>> +       if (p_size < size)
>
>What happens when they're equal? I think this patch changes
>behavior=2E=2E=2E? Intentional?
>
>Did flipping this conditional drop what should be `<=3D`?
>
>Was there an off by one, or is this version of this patch potentially
>introducing one? Or am I misremembering my boolean algebra?

Whoops! Thanks for catching that=2E I was going too fast=2E And I'm bother=
ed that my regression tests missed it=2E :|

I will send a v2=2E=2E=2E

-Kees


--=20
Kees Cook
