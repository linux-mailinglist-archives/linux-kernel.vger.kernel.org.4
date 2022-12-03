Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190406416A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLCMTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 07:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLCMTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 07:19:39 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187351A39C;
        Sat,  3 Dec 2022 04:19:38 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id mn15so5144722qvb.13;
        Sat, 03 Dec 2022 04:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OrAUu7Ff3xgokUXDmmKP6mhi/0QSxx1iup4Fo4DXL7o=;
        b=O/Cc03u8Z1p5p75/IwB6FdLM/KSdWwo9G6jO010hcbWdiTwpbCC9fl5eSHek1fSw+a
         uSIlk++1rziLI9fNPXpuNnvposE/kN+sQKTymXKT0FFISwZW21/HFAgZWmsl8tPXVeyq
         9wZstA4V7Xb5SxRSgkUi8d+bn45EBaI/MIEtPNNRLCSB2HyKDPubqM5yURWL18V8dgcd
         3DXDWzH4Y/BCAnNoaj8tk1txh73zQKlyDENwfkMnWGI3ooWNQGrGKn+3hItuDdZmT/Pz
         M34OU3+xCHlz8IR09dPg47LjEaoRl+ktEaiai7x9UoLWQFMcMCtTbPrKOwxI/LwZSkas
         I13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrAUu7Ff3xgokUXDmmKP6mhi/0QSxx1iup4Fo4DXL7o=;
        b=cgXcmSgTBj+u7FuXzhrp0wKGskZdze4CnB7+ox3OYSzy2+PLbbd6QpUqxQFJcRrhGG
         5V0nHgfXhHvmp4MSNJnJcwR4ejMyzBqJGW86YvH9qKNDZNKTEy5OIpthicEWW2yOaLyl
         Sq8J/UIRjNKm6Sdb5YIlL3kaJIOcme5GH3JAk4e5M3ehmsNCWW10Ys0FiBu2Db6Lm1cT
         tDQ0oVbKkYeLuYC18s1G2ayzpbGEFBsjEsAqK+XioHNHk0nF5wGpX/s2sRhZ8lETwQIh
         WlBHarcu7VP+sxdJCfbvLmRHVAxcIFvwpsDw1FkY+zgdJR9LoTtz6Xs+nyXPIl3XMR8i
         qWdg==
X-Gm-Message-State: ANoB5pkGWNM4Qc7wWuOu87jyib28aTyDHkKlS/UesRZiQgQZz/MGUxu9
        enu3wu73y2Q0K6g9dddm0zwlZ3zIL6SE1ejWIac=
X-Google-Smtp-Source: AA0mqf6obvAdCmgnaE5I5dygMI8fFX/UgdQnVHs501p8+Dr41VsgeED1uWfPZoSQNR8BeuViburK3yMN9sj8aDQagV8=
X-Received: by 2002:ad4:57aa:0:b0:4c6:f83c:4741 with SMTP id
 g10-20020ad457aa000000b004c6f83c4741mr29888828qvx.11.1670069977099; Sat, 03
 Dec 2022 04:19:37 -0800 (PST)
MIME-Version: 1.0
References: <202212031424175433783@zte.com.cn> <CAHp75Vch84NZhZa_Gy4qNO1-6ZJq3GBGmJXHSDurW5jeoYzhdQ@mail.gmail.com>
In-Reply-To: <CAHp75Vch84NZhZa_Gy4qNO1-6ZJq3GBGmJXHSDurW5jeoYzhdQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Dec 2022 14:19:01 +0200
Message-ID: <CAHp75VdRs5jwY749bMME1ciPFyETv5C8L-ECqoJPer3QeP+5jA@mail.gmail.com>
Subject: Re: [PATCH linux-next] x86/platform/uv: use strscpy to instead of strncpy()
To:     yang.yang29@zte.com.cn
Cc:     steve.wahl@hpe.com, mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
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

On Sat, Dec 3, 2022 at 2:15 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 3, 2022 at 8:24 AM <yang.yang29@zte.com.cn> wrote:

...

> >         /* (remove possible '\n') */
> > -       strncpy(arg, val, ACTION_LEN - 1);
> > -       arg[ACTION_LEN - 1] = '\0';
> > +       strscpy(arg, val, ACTION_LEN - 1);
>
> Should be ACTION_LEN here, no?
>
> >         p = strchr(arg, '\n');
> >         if (p)
> >                 *p = '\0';
>
> Wouldn't be better to refactor this
>
> p = strnchrnul(val, ACTION_LEN, '\n');
> strscpy(arg, val, p - val);

Or even drop p completely

strscpy(arg, val, strnchrnul(val, ACTION_LEN, '\n') - val);

-- 
With Best Regards,
Andy Shevchenko
