Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34D5B4AD5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIJXXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 19:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIJXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 19:23:04 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52241983
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:23:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d17so2978950qko.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gAh0um/m+ykZ+JIcJQ0J8f0pH78Jfp+soM0rxxd5C7I=;
        b=P/X+iO8smfwRNjyX+sIG6K2vmo0ffexU18WbP2Lly4u5YLMjeqlCim87Tp9gnyO3pM
         8uEAjZJmua0E9d0HTMDNBzbqLgfCY5ucoaCmqlFSB9q4nbo2pvE/MXZOE2Ax8FaKw7fF
         MSzriN28pNkO3RL7uOo2AZEgGtsoLp7DNUilBrm2FhzvV4rmnByE6H79wfM3dO46ks+z
         HcQqnWyKxhlwwl8Epcr1oNj38tyzcylesf39DUuXQjhnapoLfgiA4zJOE4epWpUBgEL7
         evAAASBxYnZlA5rG9jv4lYhOsMR9yhiJqeDIWtyUc7HrSJcopg9VmqfrAsSlNXfIq9Qo
         3Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gAh0um/m+ykZ+JIcJQ0J8f0pH78Jfp+soM0rxxd5C7I=;
        b=MaBu/8jmM25nRNC0RoDgXcByd+Ye6+vcTfKqYS0d+Sp47Ey+riUZ3sJLIMvbnzRqk3
         obBq+xgEWOFW9hWVIrQivWZUu59C+76HEDRZpM7VxsPNLX8cShKeTkD/UoxRsTKbXbYM
         QLC4ZI8MWKFmaBvDywDrTEg85UykYD3HyxojwRX/8Txu2Lfjg9NA8Tji36UIORc6Jw7T
         Lh7T09OvdEiYxiSTIWKbUfdL04Dm/p3J9YBpuWW4Klszzn9ZuVCjJINJD+TN3eJroJ8l
         kuUsR1ZYVNElBzXeAM31bZyo9ISKaqmaQ7BK99fvdF7zkj+zcxrmyPdZk8VXOETLZPBt
         BXZA==
X-Gm-Message-State: ACgBeo1z7ZpTXMv8lYhZMVwq0XsZr4aGvXs4KIGwZ00fg66u4DMCAoE1
        0z0N0wUGyug0yvAbRKOeVH8RV8gTDWWNBjqEQdo=
X-Google-Smtp-Source: AA6agR5qejqmrkDAUGRO2GLZzpbFpiBpGVCM8e/gsqKBkFyWoN+PWqnyTH9XojvofiZaUw4RbEfPaS/8jmaLVFrqMlI=
X-Received: by 2002:a05:620a:254f:b0:6bc:5763:de4b with SMTP id
 s15-20020a05620a254f00b006bc5763de4bmr14293905qko.207.1662852183307; Sat, 10
 Sep 2022 16:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220907110015.11489-1-vincenzo.frascino@arm.com>
In-Reply-To: <20220907110015.11489-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 01:22:52 +0200
Message-ID: <CA+fCnZe+ZW7_aeetYGpgyrS06ajfqFB1ULYLKEL++JZx4tLWBw@mail.gmail.com>
Subject: Re: [PATCH v2] mte: Initialize tag storage to KASAN_TAG_INVALID
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 1:00 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> When the kernel is entered on aarch64, the MTE allocation tags are in an
> UNKNOWN state.
>
> With MTE enabled, the tags are initialized:
>  - When a page is allocated and the user maps it with PROT_MTE.
>  - On allocation, with in-kernel MTE enabled (HW_TAGS KASAN).
>
> If the tag pool is zeroed by the hardware at reset, it makes it
> difficult to track potential places where the initialization of the
> tags was missed.
>
> This can be observed under QEMU for aarch64, which initializes the MTE
> allocation tags to zero.
>
> Initialize to tag storage to KASAN_TAG_INVALID to catch potential
> places where the initialization of the tags was missed.

Hi Vincenzo,

Cold you clarify what kind of places this refers to? Like the kernel
allocating memory and not setting the tags? Or is this related to
userspace applications? I'm not sure what's the user story for this
new flag is.

> This is done introducing a new kernel command line parameter
> "mte.tags_init" that enables the debug option.

Depending on the intended use, this can be extended to "mte.tags_init=<tag>".

> Note: The proposed solution should be considered a debug option because
> it might have performance impact on large machines at boot.

Thanks!
