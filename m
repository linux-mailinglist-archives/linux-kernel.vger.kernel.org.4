Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F96D6AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjDDRtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjDDRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:49:10 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A41FDA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:48:27 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id on15so10950611qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680630506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb4UlbgNUBjFEiIuxVNvAB9dErFsvyXvvy0R6TUZ3Og=;
        b=Sj5jDxkYzRgaqnqi5URFmqEqk4tLDhWqGTkhmtvyUlzrNNfYySQ2DBS8+uNdjX2NvJ
         w7c0Vcze36VSnsbwLxTY4q8SdKzD8jv1df68Aj3pLU0ohyvAJLJDNlPU7OV35rygU9CG
         K7XRn6Nfo7OcVRO3IjfE4aSwHdI9RVRcF1gwUOqUhigic2PsQIRNVGQ7TVoUWBFSPmMu
         fVHjoxJiz7RlmdDnYwqIczExMIsIrIb+FYcIp0af/lGBYR0E8fvViygiiAk7Bk3UVcQz
         fC7emvS0WUgW7P2awR44Opi79sZBXVLNruv1SZu+j/2TyE/rbsrTv2FkKStzMUctekdt
         ZyKg==
X-Gm-Message-State: AAQBX9c1U2HjBaoCBo3qC5WFAFldzzVwQiYrobcMmH3C27A8exn0Xux0
        izhj/w8Cf/kdC1mLdahzrD7hJK/hyp725dGWkfG5
X-Google-Smtp-Source: AKy350a/8D9NxKsEY8kuTWND8t08XKRZNRiPqVXk15c5G0YDBaTT31CfCtDZqcD3EWyLnQhy9dLOWw==
X-Received: by 2002:a05:6214:27ea:b0:5ce:6636:a45 with SMTP id jt10-20020a05621427ea00b005ce66360a45mr5360407qvb.25.1680630506534;
        Tue, 04 Apr 2023 10:48:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id o207-20020a3741d8000000b007486052d731sm3343606qka.10.2023.04.04.10.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:48:26 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:48:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm: Add error information printing for dm_register_target()
Message-ID: <ZCxi6A5iXt5N0HNL@redhat.com>
References: <20230318131633.41573-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318131633.41573-1-frank.li@vivo.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18 2023 at  9:16P -0400,
Yangtao Li <frank.li@vivo.com> wrote:

> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing. BTW, remove
> redundant printing information.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Hi,

I've picked this up with a few changes (your patch caused me to look
closer at some of the target code and we had some missed cleanup):
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.4&id=6827af4a9a9f5bb664c42abf7c11af4978d72201
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.4&id=6b79a428c02769f2a11f8ae76bf866226d134887

So I rebased your patch and tweaked it slightly (and splitting it), see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.4&id=e6c908b5d86faf3dbcf314b1c07c342268e32def
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.4&id=2a455a0b418f972d61b68f9321b7d1892c16b4f7

Thanks,
Mike
