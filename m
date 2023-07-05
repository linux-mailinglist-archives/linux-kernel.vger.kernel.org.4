Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A188748944
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGEQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGEQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:29:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8AE1726;
        Wed,  5 Jul 2023 09:29:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5701eaf0d04so79625277b3.2;
        Wed, 05 Jul 2023 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688574587; x=1691166587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBEK/lw/ilhI/xD/pTdWuhtDRm0vZrHXe/seB58iuhE=;
        b=oi9npZN4bQwNcSUNmXcsNlRrT+lIdkKXDUsc9SOwUUw2zp6vsjA+y+2kHRxzPU6v7h
         ZeAzJHQU422qNb8nIWaF+SoyTuNUr7r7/KSBDO9dJLP4J0E/XCOCUj7x4mrtcLzOzwwB
         vz0xdVp8er4W4dO98DIkOgX60JnwdKAildENfO9cf2TjoOjQktnR9M+3rnMUAL8NPY4P
         KkZqS+tfhII6uO+n2xICG4jWT2WKr3RStDiMqFs1j0Z3O7cJHhaIH3OmA4F51+E9lI1y
         JirhcMo2GBxCtsh7koiScGAIm+Zm001GfTqCxuzI/6GEIDiHhTDVNVByYRWUZwM8s7uv
         NfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574587; x=1691166587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBEK/lw/ilhI/xD/pTdWuhtDRm0vZrHXe/seB58iuhE=;
        b=VwmptJPFo/Z8SKuURocd57S3kUH8Pic7WCaV1Xfk7hFfaLGKB5pR8Uto8YZwS8vmp9
         AzTYFIeA+bGnmkKcwhNb6mmw4SL+5WxSiTo+ilVCnBbndfhmrP4GtIbN18ywcwXza2ie
         FE5nQpc7rfn/1vDMxLVQUZkk9DemnBO0AKIpCCT2p9ilT4lTXZbKEkU131JvsdmTnCAL
         Qobqs33LfxqixTFl3CXkeCgGBi6dWDxw8Mhe2qZwvjG3FQg2hvbKyAuijA4athIx2G9t
         xqqegusAzwrdZhWKsAoVl0qGb/JqrLt0/CTLuDlS3ToHcZ4oLO7qX1VALyyI811Hk3Dz
         XYpA==
X-Gm-Message-State: ABy/qLbWvo2jzE45Sm5547gEmQVrvBra/fkp9l+zmNuPrWu0HwQNE0AG
        hQ8Ed7TnOvKxc7MTAZwnMZA=
X-Google-Smtp-Source: APBJJlHgAg2w3zbtsi7F7/4A/Tu2LATPYFrBF8E9+XnaXesNNyoCMtT9HF6N+46bnGheqK1QSidZsg==
X-Received: by 2002:a0d:d849:0:b0:577:fd1:2dce with SMTP id a70-20020a0dd849000000b005770fd12dcemr15829002ywe.29.1688574587034;
        Wed, 05 Jul 2023 09:29:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7-20020a81dd07000000b00576bfc14bf3sm5390750ywn.107.2023.07.05.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:29:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Jul 2023 09:29:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
Message-ID: <af60105b-65e7-4fdb-8e82-cfe52eb6d237@roeck-us.net>
References: <20230704084611.071971014@linuxfoundation.org>
 <824705ec-38ca-1587-573c-595b146ee2e1@roeck-us.net>
 <2023070529-barcode-unpleased-5705@gregkh>
 <2bbf215e-840d-138b-511f-b2602a3eeda8@roeck-us.net>
 <2023070551-matcher-camping-98f0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070551-matcher-camping-98f0@gregkh>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:25:24PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jul 05, 2023 at 09:13:58AM -0700, Guenter Roeck wrote:
> > On 7/5/23 09:06, Greg Kroah-Hartman wrote:
> > > On Wed, Jul 05, 2023 at 07:23:30AM -0700, Guenter Roeck wrote:
> > > > On 7/4/23 01:48, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.1.38 release.
> > > > > There are 13 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > > The whole patch series can be found in one patch at:
> > > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc2.gz
> > > > > or in the git tree and branch at:
> > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > > and the diffstat can be found below.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > > 
> > > > > -------------
> > > > > Pseudo-Shortlog of commits:
> > > > > 
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >       Linux 6.1.38-rc2
> > > > > 
> > > > > Linus Torvalds <torvalds@linux-foundation.org>
> > > > >       gup: avoid stack expansion warning for known-good case
> > > > > 
> > > > 
> > > > I am a bit puzzled by this patch. It avoids a warning introduced with
> > > > upstream commit a425ac5365f6 ("gup: add warning if some caller would
> > > > seem to want stack expansion"), or at least it says so, but that patch
> > > > is not in v6.1.y. Why is this patch needed here ?
> > > 
> > > It isn't, and was dropped for -rc2, right?
> > > 
> > 
> > The above is from the -rc2 log so, no, it was not dropped. I checked in the
> > repository to be sure. It is also in v6.3.12-rc2 and v6.4.2-rc2, but there
> > it makes sense because a425ac5365f6 was applied/backported to those branches.
> 
> Ah, I must have dropped it right after the -rc2 announcement, it's been
> a long week already:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=a5847f7c495fdc9c0a7b63703237f2891a6b6ed1
> 
> but be sure, it's gone from all branches now.
> 
Great, thanks!

Guenter
