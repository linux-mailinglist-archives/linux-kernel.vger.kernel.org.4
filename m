Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD36005F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJQERz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJQERu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:17:50 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E24AD55
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:17:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r18so9391154pgr.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmlFhp2gD2G4j1JCH64b5MMoz3HAdDyEuPGIK7I2tp4=;
        b=cSeF/8PdTLHq9b3C8Yb1uo33XNH73VGFNbVQ2uSSOve2WdqcFbcwV/fPFiPI8m8GGZ
         sd0Lt388bLtDaR+hc/CLWFBluSbav9k+I6iMqDNzZEKSfkjV4Qroih5VmVGIlYFjpoMs
         CnPV3wslqjcnbckfl2Eg+42hH39DVRq4I7FDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmlFhp2gD2G4j1JCH64b5MMoz3HAdDyEuPGIK7I2tp4=;
        b=2W+GIJSr1/rHhdY8M+Kf72KVJ6AtEbDRJjojha++BeaBUAjiXnDSKYczYnqTuoNmIJ
         hycoR4VgqX0lzWt8HDan8J7qz4vN8G6CzveeALU1nwfkVf71HKLMwoNHWyk9oXVwGB0o
         aosGGKaBKRlxncBQ2DLTQadWgS06Sm/GeiC0jBHp8Ps2VVqvM81za5PJuzFI2rUTfkQI
         uAwhWfK3elbUThM2eMWL1816/7p4cowMZLd/bo/Jsd/szCNrUAtfS3vFIAJtoatTd72a
         XdfKRvkt+lQHFBgPbZ5cbno5ghsuj56niJ9lUcm+xoiALbdC3zX0Y2/EzKUszkK+bLIi
         +b9w==
X-Gm-Message-State: ACrzQf3neUqJj3prVNiAQw56xH7Lw2I2Ehp0hQHYVoglYrXB0+WObiZ+
        Au5pjj8y9EQU7TclZGuCpVIsrw==
X-Google-Smtp-Source: AMsMyM7Z3xrvgggbMnCIvl6m8TssiWUWoCABV2cstI1imeYirv8FHIIyCKuxXLOi8+Zf5/DWiv6yvw==
X-Received: by 2002:a63:6b88:0:b0:46a:ff3c:b64a with SMTP id g130-20020a636b88000000b0046aff3cb64amr8959352pgc.196.1665980268092;
        Sun, 16 Oct 2022 21:17:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3-20020aa796c3000000b0055fc0a132aasm5980424pfq.92.2022.10.16.21.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 21:17:47 -0700 (PDT)
Date:   Sun, 16 Oct 2022 21:17:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Anna Schumaker <anna@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 6.1rc1: NFS memcpy warning on mount
Message-ID: <202210162113.1A948FEAB@keescook>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <Y0zEzZwhOxTDcBTB@codemonkey.org.uk>
 <Y0zS/5WLi2q4Ua2U@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0zS/5WLi2q4Ua2U@debian.me>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:58:55AM +0700, Bagas Sanjaya wrote:
> On Sun, Oct 16, 2022 at 10:58:21PM -0400, Dave Jones wrote:
> > Started getting this during mount on a 6.1rc1 kernel..
> > not sure which mount it's complaining about, but they're all v3 tcp
> > mounts on that machine.
> > 
> > [   19.617475] memcpy: detected field-spanning write (size 28) of single field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)
> [...]
> Hmm, the blamed line in the warning is introduced by 38465f5d1af932 ("NFS:
> rename nfs_fs_context pointer arg in a few functions"). Cc: the commit
> author. Also Cc: Kees for authoring the patch [1] that have fixed
> similar warning.

The warning is from commit 54d9469bc515 ("fortify: Add run-time WARN
for cross-field memcpy()")

> Also, does v6.0 have this warning? If so, you need to bisect in the range
> of v6.0..v6.1-rc1.

No need for bisection -- this is almost certainly a false positive (as
detailed in the above commit: we're working on purging all of these
cases from the kernel).

> [1]: https://lore.kernel.org/lkml/20221011065243.583650-1-keescook@chromium.org/

Yeah, I have a v2 of this patch, which should also fix this request.sap
issue. Sending shortly...

-- 
Kees Cook
