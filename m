Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C05F6DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJFTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiJFTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:13:22 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B67A3F45
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:13:22 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id q70-20020a4a3349000000b0047f9951ad3aso1544867ooq.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++tJ09hb5C6OONscG3KYoTuEWAIgjFjs1S6s28i5l/8=;
        b=BHp3zkMCg6w1bIPYjUTPU6mOldXCSyDBXTh+8mG6ZT/vKgM4GIVazS5lufHEWFfmZ9
         Z7WKUL9jx3dglIMa9uE5D0ylx/IJGWu5IVJPjS3Uwt7eZUU1m6WkxayFO9M+ndzkkif3
         r9/uocdIxcN/19KxAcq7DCi6lNWNYYCu44ghc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++tJ09hb5C6OONscG3KYoTuEWAIgjFjs1S6s28i5l/8=;
        b=Oxjm5PIlJLGt8vOi8NCEERa2peElOFXlo6+rZqRZSo7u52LMy5E9L+18KMy+KbD8Wr
         ArBVXcYEuOQMBZuaBZxWjFPXSdiZkOEmHGJTDl6Lv261y7SY1mWwB535na2UvNlCtij3
         YwVmsafUyVTUTwwDbAtCvtjm5mvkRlGzUU5+iHQ/Si0/BmeZea9t6bXjRyPiKz7YAWZI
         2xxiPjAa1qfvgeZl9kuz8XwePXQ2OQNpcMMIjTU97jz32ltJFeC8H25Ics14rmJ/F6l8
         4Fjv2esLAwGy9UJncwzsE1dMidxM+C4Xb4yk/PgD3ZSUPWOzY+ITqAary7zGmRisJ2gE
         K9vg==
X-Gm-Message-State: ACrzQf3UxImaGoOp+xmcKERp/SL8cJs4t9au+Rns4Ewr9i0TuXjgyZiI
        yK8tzBlgag4tBwKt9nvgEqhe8QLni2CfHQ==
X-Google-Smtp-Source: AMsMyM7+e1loSTLWCgOhq7lntqBcysqJBqNWFy9H/gOrWS99z3R9m8O2w/D+5LbzTtu86bk9Ql7b1Q==
X-Received: by 2002:a05:6830:911:b0:661:283:336e with SMTP id v17-20020a056830091100b006610283336emr623694ott.96.1665083600849;
        Thu, 06 Oct 2022 12:13:20 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id i28-20020a9d611c000000b00639749ef262sm212641otj.9.2022.10.06.12.13.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:13:20 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1321a1e94b3so3321139fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:13:19 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr712518oab.229.1665083599726; Thu, 06
 Oct 2022 12:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <Yz0koHybNXGTFfDr@debian> <Yz1ew+EdD94TjQYK@sirena.org.uk> <CACRpkda-dquOCUChDMwFgGy7kUNFE05H+Bebb2bB5=UQGgwyCA@mail.gmail.com>
In-Reply-To: <CACRpkda-dquOCUChDMwFgGy7kUNFE05H+Bebb2bB5=UQGgwyCA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 12:13:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOwH87ftq1jUgk0md-6FaRyXVNMniGpoiAuCEAG6ZvyA@mail.gmail.com>
Message-ID: <CAHk-=wjOwH87ftq1jUgk0md-6FaRyXVNMniGpoiAuCEAG6ZvyA@mail.gmail.com>
Subject: Re: mainline build failure due to 81c0386c1376 ("regmap: mmio:
 Support accelerared noinc operations")
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
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

On Wed, Oct 5, 2022 at 1:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> There were some further issues with the fix (alpha is really hairy)
> but Arnd stepped in and fixed those too, it should all be fixed up when
> the arch tree gets pulled.

That is now pulled and pushed out.

Sudip, can you confirm that the alpha build is ok now?

                  Linus
