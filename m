Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B14661558
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 14:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjAHNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 08:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAHNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:06:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F85E0B3;
        Sun,  8 Jan 2023 05:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E49B80990;
        Sun,  8 Jan 2023 13:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F24C433F1;
        Sun,  8 Jan 2023 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673183203;
        bh=25sUiVh4DX8OMquO6qi9c91N6UurO7I+2sKVuFyi8Ss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j9x0q7EQaif6gdcoQr04EGOVR3cnk+lnN8ynnP5di2yjuHfS4p2ae7GLr6XGqDLI0
         6tByzYQoDXcCIUYVfggZcmNWVBExRFitz9q14B4qP/ZrDrBpHt+P77oAM3C6B4Ffws
         bMxMAIb+p/WJtuuvqLIKQ0g2sbhv8EVmhJodzOrwd5hVIPWAUgysylcDdypiFuIBer
         R/LqeYjyPlESexkxYN8jmOU/+uHQvc7eFJ+M9Vu1nGdXGroRuON9M9tY8uBzLXSDc9
         yM/cdeEtWBuMAGWg1THV8XZqj2YN0LifIvhD2t9HdjAbnm4GmLc+dKf1rx2dtsYXRz
         6Orp+NEiZFjhw==
Received: by mail-oi1-f174.google.com with SMTP id v70so4998830oie.3;
        Sun, 08 Jan 2023 05:06:43 -0800 (PST)
X-Gm-Message-State: AFqh2kpSpXIY6k5nhuQo3fCRuoHhpPILtLUOgjUpzlBQ3g0IlvImBUjJ
        d14Pf08djHuL55aHnRabYUXDMbmwqAafRNsstdg=
X-Google-Smtp-Source: AMrXdXttsIb+osoRYUtlo6mHs9sMSFOyY8orlp8b1KRq+emvjg97MdfSUhB2KcNMVIpkQs+3U+ueqWYXTTizTj0H7Is=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr3679754oia.287.1673183202567; Sun, 08
 Jan 2023 05:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20230107091820.3382134-1-masahiroy@kernel.org> <CANiq72nY9X1cyu=3MwfRKTcxMUNHRTUGPFC7VR=OtL8V-NPQog@mail.gmail.com>
In-Reply-To: <CANiq72nY9X1cyu=3MwfRKTcxMUNHRTUGPFC7VR=OtL8V-NPQog@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 Jan 2023 22:06:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_VTo1A7rfQq8zMzLYfRRCUzruPQL=akALTg-GYKaQzw@mail.gmail.com>
Message-ID: <CAK7LNAR_VTo1A7rfQq8zMzLYfRRCUzruPQL=akALTg-GYKaQzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kbuild: refactor host*_flags
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023 at 12:12 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Jan 7, 2023 at 10:18 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Remove _host*_flags.
> >
> > This will change the -Wp,-MMD,$(depfile) order in the command line
> > but no functional change is intended.
>
> Looks fine to me. I gave it a quick test with just this patch on top
> of v6.2-rc2 and checked that the order indeed changed (was there a
> reason to not keep it the same?).


No, there is no reason. Just my whimsy.

I will do something like the following just in case.

hostc_flags  =  -Wp,-MMD,$(depfile)  \
                $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
                $(HOSTCFLAGS_$(target-stem).o)

>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> Thanks!
>
> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
