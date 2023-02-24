Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024FD6A247F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBXWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBXWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:51:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6A1C595
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:51:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d30so3299102eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XetVmJJp94Tm+T8Ok6omBAdD9XAfcZ6uupziRkiZMk4=;
        b=O992ZC0d4Fin+fSMDEuc/r4oFcV7GuLj9xW5Jaak+IJxNIGgsgHvuvCcZiaX+GMlBS
         N776OX1MKa2ocMIExB/CvqrGqgUncIQxhKN3EjfIdflSlixcjzb9Pf0PvLdScnculsFz
         Jb+JalT+9UXEQKhI1dBBcBnwv7Q14O8TVsOwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XetVmJJp94Tm+T8Ok6omBAdD9XAfcZ6uupziRkiZMk4=;
        b=GPTa6P2nPPnSfKIFmpZOtP9hWDXAZKJnLBbOLkzPSUj1aksBJuSVemwXGNy9OLvEP8
         N7njL7gmUQrHuJHpQOdBTF8+uISPpfwiPqnRrIs/LDFxb3de6f98Ndj/nIN3OKRkJKaP
         Dhcu8elyFWk7D+hPW/SU2ejp7Pij1jwHfVtff1P6Vq+QOU+JRXb4EzmfvNTf5gAQF9j0
         O3APKhUV+R5cAmQ1UiP12NlavVxhBxxtP85wcNi27qN77P2aqoJ3bZU659Jz0FFB353P
         iwwfyPD/gnb6kaiTtSlIrre4P2u+h6S7PvxP+uLun2oYTSNrO1dIdaHrFVz43pITXaYM
         OEBg==
X-Gm-Message-State: AO0yUKVor/FSxy6M6/14I82TMD1PWKTASgXUVeArOSZJJXDRNgDtrY7p
        NpWSl9WcfKv6HHBZpEukUBMW8CsFuHntf6ELEHIh5w==
X-Google-Smtp-Source: AK7set9TqA1l6VzGsk9qpSXzMQ9jwafMr6ZRSj2xV2KQgaBD5LuS/B1jy2lYtskIHMZ8XCpNloLUYA==
X-Received: by 2002:a17:906:6444:b0:8af:2af5:1191 with SMTP id l4-20020a170906644400b008af2af51191mr22964029ejn.18.1677279063842;
        Fri, 24 Feb 2023 14:51:03 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id s24-20020a50ab18000000b004af6b93f00asm228375edc.23.2023.02.24.14.51.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 14:51:02 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id i34so3246861eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:51:02 -0800 (PST)
X-Received: by 2002:a50:9fae:0:b0:4ab:4d34:9762 with SMTP id
 c43-20020a509fae000000b004ab4d349762mr8258013edf.5.1677279062350; Fri, 24 Feb
 2023 14:51:02 -0800 (PST)
MIME-Version: 1.0
References: <Y/Tlx8j3i17n5bzL@nvidia.com>
In-Reply-To: <Y/Tlx8j3i17n5bzL@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 14:50:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiy2XRdvxchyuVYJJ618sAcGiPPam14z8yAW+kyCzgPmA@mail.gmail.com>
Message-ID: <CAHk-=wiy2XRdvxchyuVYJJ618sAcGiPPam14z8yAW+kyCzgPmA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
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

On Tue, Feb 21, 2023 at 7:39 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> iommufd for 6.3
>
> Some polishing and small fixes for iommufd:

Hmm. About half the patches seem to not be about iommufd, but about
'isolated_msi', which isn't even mentioned in the pull request at all
(well, it's there in the shortlog, but not in the actual "this is what
happened")

I already merged it, and am not sure what I would add to the commit
message, but I really would have liked to see that mentioned,
considering that it wasn't some small part of it all.

              Linus
