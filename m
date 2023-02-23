Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850006A1230
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBWVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBWVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:40:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657B5C155
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:40:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cq23so47150764edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eu4dlgDvM7BF/2CvEqDDQA7UHs/G9uWjlrCzs/6VT/8=;
        b=OBJUot5ArA8AuZr5Am1iNpiGcg163grwYHt/S/lfdzEng2GEOmwCK61b4pdn9e1Rvz
         9ZdxgOBLRiDoqtPUUEXz/Z1CFCLXAhoMCcyW2xMALKstCSjCh62EgVAkaFd3JSDOIfp4
         63bQ2FerOD+OayzoALa+Mh6V67wCIFrWQjsEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eu4dlgDvM7BF/2CvEqDDQA7UHs/G9uWjlrCzs/6VT/8=;
        b=LYSYkjftDBVB1a1m9RunEMBbofcr7d4F88zMZhYyr7meAOGD9FjdWxxvbPauyhGifh
         Nd5Bmlwb9ZYSnbDrzJlNLhW7hSaBPGUaIn547usibXZqNrwg9L+2MQ+9C3e/WcO7vit/
         uVSkJ5eVwyz1xvxXs1kkQc1pcPigorzxPdMf6r+x4kBJfhwUuhM+s9dRLUwUGYfIJqgx
         5CTLX7kNv0THd6fDZ0XsD0Pd241IH8N0UzD+HLi5pqSlGalMgXQ7QPx0PKTpUdgoAETh
         nD2IfjImSXzMhGcCMStZb80Az1qqnLUm/wDEA9xHUDcDmCwXdjpgkFwhJdCtV8f3o4zw
         IFiw==
X-Gm-Message-State: AO0yUKV0TwBtsPmijuG+eq/2Kho//EVdQWQ88xOe4YSRJQmXRptaQfA+
        B9gnsgm0N9geigbsItpiLJopyde/kWi8XQv7DWPvZA==
X-Google-Smtp-Source: AK7set/+I27tGYIvUSLtXmesKtB1q+SMrhOohTZzKofXUS/p2sRuZMMbWDD+tfxK5EQmgOP4l5KPOA==
X-Received: by 2002:aa7:d692:0:b0:4af:64b8:27de with SMTP id d18-20020aa7d692000000b004af64b827demr5926249edr.9.1677188400574;
        Thu, 23 Feb 2023 13:40:00 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id k25-20020a50c099000000b004ad7c42a17esm5192805edf.25.2023.02.23.13.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:39:59 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id ee7so32322837edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:39:59 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr9516620ejc.0.1677188399093; Thu, 23
 Feb 2023 13:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20230223141542.672463796@linuxfoundation.org> <adc1b0b7-f837-fbb4-332b-4ce18fc55709@roeck-us.net>
 <Y/eVSi4ZTcOmPBTv@kroah.com> <cfd03ee0-b47a-644d-4364-79601025f35f@roeck-us.net>
 <CAHk-=whCG1zudvDsqdFo89pHARvDv4=r6vaZ8GWc_Q9amxBM6Q@mail.gmail.com>
 <Y/fC3d3RqoeawG0Y@dev-arch.thelio-3990X> <CAHk-=whkNnShBugM01Kzcypkp+f-uHeBWuAgtUiMpiSZuW+QDQ@mail.gmail.com>
 <Y/fZbQEEPBNZQ2w7@kroah.com>
In-Reply-To: <Y/fZbQEEPBNZQ2w7@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 13:39:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whiuJH_DYQZw1hPtibDQZcNy8QYf1cZJCsezuPobSXCKw@mail.gmail.com>
Message-ID: <CAHk-=whiuJH_DYQZw1hPtibDQZcNy8QYf1cZJCsezuPobSXCKw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.96-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
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

On Thu, Feb 23, 2023 at 1:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Quilt should be depending on patch here, I think it's something in my
> set of "turn this series of patches into a mbox, split the mbox up into
> patches" sequence that is causing the problem.

Well, it might also be that quilt just re-generates the patch with
'diff', and then in the process loses the information again.

We can happily continue to support the "we lost the executable bit",
since it sounds like Nathan is willing to cook up a patch.

I'm just too lazy and personally unaffected to care (and too busy with
merges - excuses, excuses).

            Linus
