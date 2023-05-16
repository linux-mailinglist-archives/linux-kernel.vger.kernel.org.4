Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A10704EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjEPNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjEPNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:05:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31307ED3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:05:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5343c3daff0so472782a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684242311; x=1686834311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyqClcGPpvz2y0EU2dPcVjbTz64qhuAJFHRk1lsXEq0=;
        b=gdEJ3IQeDPTblIOPnFQcmqH+Nx65U8u/ooeeP4mbvtICHQ8kyj8s75ij/OI9lqzrOG
         4ues86dnV4rymBsJElQhRKAdietBJAROyBbjLGamcOhzAZKMjGUDiyvNCNI10lzThBnZ
         U2CHEy4dSFmpXlvb1R7HxzjR6V93Q6kROgOJ+xUWo9HA9rs8txM3AtslzEUX/KjWeL1E
         zRZF2+zPLImsamEsi2a9Pxfj6wZQYOSBOVG8FmrgqUqgwXGjT/uuIcqxG0HY4iC4q4vg
         f3XT86EXsrg/zl2NIpz9YwB+H+YjEwTW7EiRiisXhuP9WONcGL/synx9rwOQ7aLMsM7i
         YX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242311; x=1686834311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyqClcGPpvz2y0EU2dPcVjbTz64qhuAJFHRk1lsXEq0=;
        b=Qywj42rK6XS/d2i4PVfGDFaOTDsXL7/3fwONDVvbJGMm7AqqHRkUxDPcFdep4F3S1Q
         dwN22S5tyqFJNO64xs9x9tKZ5OUJ3uHy/SKI18ty9jJsAdV8KXjo4UbOPu3QrEmEUJz/
         TeanqgFlXALsrXLPsfwNjWL9WGaySUphObi9FBp5wu7BvZ3BCWmbhNVo9AG+CUU6Y6cd
         r82PM2wO3sDPFCQxCrMfVsnQNRGPNllAsyluOkR+sP1qjZE38vwoZ4dqeUAkgKo2fMG8
         bIoyWn29iZ352Z1WSJvoZ6pImk8wbyQP53K72Hh5nwLqLYlNV6xBjNFXQ6IcOOPfETXR
         YXqg==
X-Gm-Message-State: AC+VfDwOKwaHYBJsm4XbdgrmIwUwVa5XToPndgAPBximPUNORRZXJx5Q
        QRVdSqbmuoER+LA3NKEauZtPH6tKOx21YQ==
X-Google-Smtp-Source: ACHHUZ79Bz5M8Eg3ZX+VhjgnSIl9WLhKD7ejlIPY/Ktx7Z0KtoalsJq4xIGea+kSnkVNkudsoXKAqg==
X-Received: by 2002:a17:903:1249:b0:1ab:220a:9068 with SMTP id u9-20020a170903124900b001ab220a9068mr49238065plh.42.1684242310464;
        Tue, 16 May 2023 06:05:10 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001ac912cac1asm15482436plk.175.2023.05.16.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:05:10 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     ihuguet@redhat.com
Cc:     corbet@lwn.net, danny@kdrag0n.dev, jgg@nvidia.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        masahiroy@kernel.org, mic@digikod.net, ojeda@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
Date:   Tue, 16 May 2023 22:04:37 +0900
Message-Id: <20230516130437.14753-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414101052.11012-1-ihuguet@redhat.com>
References: <20230414101052.11012-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Íñigo,

Thank you very much for this patch. I would really love to see .editorconfig
added to the Linux tree.

I need to work on different project and so, since last year, I applied the v2 of
this series to my local tree and it works great.

On Fri, Apr 14, 2023 at 12:11 PM Íñigo Huguet <ihuguet@redhat.com> wrote:
> EditorConfig is a specification to define the most basic code formatting
> stuff, and it's supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> 
> It allows to define formatting style related to indentation, charset,
> end of lines and trailing whitespaces. It also allows to apply different
> formats for different files based on wildcards, so for example it is
> possible to apply different configs to *.{c,h}, *.py and *.rs.
> 
> In linux project, defining a .editorconfig might help to those people
> that work on different projects with different indentation styles, so
> they cannot define a global style. Now they will directly see the
> correct indentation on every fresh clone of the project.
> 
> See https://editorconfig.org
> 
> Link: https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
> Link: https://lore.kernel.org/lkml/20230404075540.14422-1-ihuguet@redhat.com/
> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> ---
> v2:
>  - added special rule for patch files so it doesn't remove
>    trailing whitespaces, making them unusable.
> v3:
>  - moved all rules from [*] section to all the individual
>    sections so they doesn't affect to unexpected files.

I understand from from the past discussions that trim_trailing_whitespace or the
default indentation can not be apply broadly to all files. But what about those
three parameters?

  [*]
  charset = utf-8
  end_of_line = lf
  insert_final_newline = true

Those looks safe to me. Are there files for which we do not want utf-8 or for
which we do not what a final empty newline?

>  - added some extensions and files from a patch from Danny
>    Lin that didn't get to be merged:
>    https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
>    However, the following file types hasn't been added
>    because they don't have a clear common style:
>    rst,pl,cocci,tc,bconf,svg,xsl,manual pages
> ---
>  .editorconfig                          | 30 ++++++++++++++++++++++++++
>  .gitignore                             |  1 +
>  Documentation/process/4.Coding.rst     |  4 ++++
>  Documentation/process/coding-style.rst |  4 ++++
>  4 files changed, 39 insertions(+)
>  create mode 100644 .editorconfig
> 
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 000000000000..dce20d45c246
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +root = true
> +
> +# 8 width tabs
> +[{*.{c,h},Kconfig,Makefile,Makefile.*,*.mk}]
> +charset = utf-8
> +end_of_line = lf
> +trim_trailing_whitespace = true
> +insert_final_newline = true
> +indent_style = tab
> +indent_size = 8
> +
> +# 4 spaces
> +[{*.{json,pm,py,rs},tools/perf/scripts/*/bin/*}]
> +charset = utf-8
> +end_of_line = lf
> +trim_trailing_whitespace = true
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 4
> +
> +# 2 spaces
> +[{*.{rb,yaml},.clang-format}]
> +charset = utf-8
> +end_of_line = lf
> +trim_trailing_whitespace = true
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 2
> diff --git a/.gitignore b/.gitignore
> index 70ec6037fa7a..e4b3fe1d029b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -100,6 +100,7 @@ modules.order
>  #
>  !.clang-format
>  !.cocciconfig
> +!.editorconfig
>  !.get_maintainer.ignore
>  !.gitattributes
>  !.gitignore
> diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
> index 1f0d81f44e14..c2046dec0c2f 100644
> --- a/Documentation/process/4.Coding.rst
> +++ b/Documentation/process/4.Coding.rst
> @@ -66,6 +66,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
>  See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
>  for more details.
>  
> +Some basic editor settings, such as indentation and line endings, will be
> +set automatically if you are using an editor that is compatible with
> +EditorConfig. See the official EditorConfig website for more information:
> +https://editorconfig.org/
>  
>  Abstraction layers
>  ******************
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 007e49ef6cec..ec96462fa8be 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -735,6 +735,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
>  See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
>  for more details.
>  
> +Some basic editor settings, such as indentation and line endings, will be
> +set automatically if you are using an editor that is compatible with
> +EditorConfig. See the official EditorConfig website for more information:
> +https://editorconfig.org/
>  
>  10) Kconfig configuration files
>  -------------------------------
> -- 
> 2.39.2
