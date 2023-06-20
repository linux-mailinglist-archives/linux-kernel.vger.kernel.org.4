Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F2736A15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjFTK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjFTK6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:58:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3610F9;
        Tue, 20 Jun 2023 03:57:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-763a3b3949cso142240485a.3;
        Tue, 20 Jun 2023 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687258672; x=1689850672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/mp0Ngy4nsVmS7qXoq+Hpkgz3O371XCxZT/IH4msvY=;
        b=qm7g+dhP5pFnsiqSiC+oUSMfPLiuKg0aWweYBu4VPvlvxIl1+G1OzBJHrlNAM0N/vv
         FyRC1KnZixegGYMXxzQ9jwth5lm4+mPlY1zCMQi04qwipf00w2l8UOYW5EVECSEA4wpd
         0Xol+MZMcGMy3r7QqFMMvppzB5z9q2kOCsg/KaFnF3Wkhgm1kpq+6mZnwfTmz9PN7NRZ
         Oxi7lquds5TQaefpU8cyZpa7ORBgE/bEE0UObhuCQPUjtB2TtpcTGsOQ0oQWlMTPGNqS
         M1hwoAG4jtXU5atnLabniPTiQ5P1+YOA2yI/joIwMZxjL2Mflt4LjbbvVxFoqOibLNp7
         EPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258672; x=1689850672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/mp0Ngy4nsVmS7qXoq+Hpkgz3O371XCxZT/IH4msvY=;
        b=HAmuoklky/GgG746F4T658ke8qdLw85xmzkteJvk1FHF/SD0PEkOYJtNiIFZK9g873
         n9rBapaQSkeP3NeqOXZRZGallSpCj2phQRFbTNlK5tO1UIlanY4JpLHVaD5F26KyqKBw
         ZpsPdh7/8Yo4IjPLG5UAEkDTdoMK4ZShB54x2QvcWUY/1EIZMa7yqqP2reh3aVD+r9lC
         jEGiPQsuAsb4pYn61PTnKvlDrTNZa3YCP/D9AJMwUm0MR7dhUdIy1coJPEFZpcHMGUUq
         vcHiMK+FEG0MAhtK45fuIg2Kdjgf7CuH5dblntAUWBcXRc9b78CE08IIy1B3uEUt2zrG
         d5JA==
X-Gm-Message-State: AC+VfDwLf2oSJPXp6xFdox8ckPm3QJ/N5ZSrqsyFHiQDLy/GrQ23M7fW
        v4I8u6BYQ2xi6MTv3VPrEIm9luTmG2D+5nZJas0=
X-Google-Smtp-Source: ACHHUZ522vTFV+46xTCfVymg53gHKyEaSka9joR80wLGiVJbJhJTPnzEi4F7tgJG7clfurjMp7dc59RtKwWsQ7sqviI=
X-Received: by 2002:a05:620a:838a:b0:75d:5640:22e7 with SMTP id
 pb10-20020a05620a838a00b0075d564022e7mr11713898qkn.55.1687258672354; Tue, 20
 Jun 2023 03:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com>
In-Reply-To: <20230614095158.1133673-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Jun 2023 12:57:39 +0200
Message-ID: <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:52=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> @@ -597,7 +614,11 @@ void kasan_report_async(void)
>         pr_err("Asynchronous fault: no details available\n");
>         pr_err("\n");
>         dump_stack_lvl(KERN_ERR);
> -       end_report(&flags, NULL);
> +       /*
> +        * Conservatively set is_write=3Dtrue, because no details are ava=
ilable.
> +        * In this mode, kasan.fault=3Dpanic_on_write is like kasan.fault=
=3Dpanic.
> +        */
> +       end_report(&flags, NULL, true);

Hi Marco,

When asymm mode is enabled, kasan_report_async should only be called
for read accesses. I think we could check the mode and panic
accordingly.

Please also update the documentation to describe the flag behavior wrt
async/asymm modes.

On a related note, it looks like we have a typo in KASAN
documentation: it states that asymm mode detects reads synchronously,
and writes - asynchronously. Should be the reverse.

Thanks!
