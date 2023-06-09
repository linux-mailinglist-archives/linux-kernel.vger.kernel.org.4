Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B372A56B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFIVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFIVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:35:12 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A13A95
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:34:56 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-78a0c37428cso812055241.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686346496; x=1688938496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g2CkLL/4yGzWZqO3b6RZAXklev+mp6Fy0i6OZOPQIk=;
        b=EO09QpsjpKrLGL7DHyLbPLp+EWHMBIFl3CGbn03V+M9RmYJaSLIVwEycdhNNy7ifKi
         Ign6Sy4zZkhiHyKeFymndPSMkSJqy2WIMxjqKrZVHDXVM8/juTkKFKs5oT7abFw77Kub
         CESJnLTikhwVXJs3B0OMVH5N4K1kV8OLARSfKfZoePsneLfQvb7kHRyuoE8cy71iwJsx
         f1oJ2gmHelpkOxHNsZaTa/netb0FZAIYUggjQO7No4ttZ/MBVTq6wjP9FzF5tCbL4Bxm
         Y/xedyP3uaKAw4C3o2dv9jSH6U71N4G81qRvBR4lhK2M5uGGSYzE+wCtpNPxQeLbtMxH
         t+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686346496; x=1688938496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g2CkLL/4yGzWZqO3b6RZAXklev+mp6Fy0i6OZOPQIk=;
        b=AoJoygIkXmx1OJpRAIs8yiXNu/UUO4vLlFeUbj0jkHUDKyYM/t1oLaXlnLx2W/nKjS
         cqkuZZCo8fMo0fCKP1O1UI5bD7dW6rSXl79EjEHz+aNx3JdUalMefzKLMN3z1jSzyoye
         MwkPXpqkgq59jQqAzBKcMSFV+L800yx0/sDAglsiQcgjtIrX40jv4Q0/n5b283fNVWRH
         Ov5TNwe3ZQmfI/Vo4XB17Qnn6RcmoqYgYj4LxPgbO3vCoA9lXOQzsjgVtd2CF+AsoAol
         heAeEOYwixXhkSr0xw6zi5fV1TxmYQaYflKxGg1z56lT0kAo5sV8JTmjfS8dgnztpp53
         gLxQ==
X-Gm-Message-State: AC+VfDzKHGZdSEYL+S3KOIVWdUboM6jpkVrDRWMzvNsmZBThjnlSRdv2
        3CTzt58ZcCp0VdrezuH1ejQM3dUR3ZhyedOTmwv7L7SDBzuJcPX4apo=
X-Google-Smtp-Source: ACHHUZ4uOlZrQzARsnpEKvHVVeGTzA69TCoAo9WRUuK65g8a56cI413B+BDwzV32gGdkFpzHAkebZEqdVXOVyAdVUe0=
X-Received: by 2002:a67:fc59:0:b0:43b:37d8:2608 with SMTP id
 p25-20020a67fc59000000b0043b37d82608mr1882079vsq.29.1686346495600; Fri, 09
 Jun 2023 14:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-4-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Jun 2023 14:34:10 -0700
Message-ID: <CAKwvOdmA7oPvUZ-AhY8J9DGk0j5z=xCED8r3Ug=n2S9q-BWb+Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 7:24=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> whether the EXPORT_SYMBOL() is placed in *.c or *.S.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


--=20
Thanks,
~Nick Desaulniers
