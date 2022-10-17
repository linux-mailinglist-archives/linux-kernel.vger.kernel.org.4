Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29B600611
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJQE6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJQE6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:58:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC74F66E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:58:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l4so9737709plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pkUG8SB3NXfjwmJffISRFNjCCZaK7tUK5ZqdyRYa2w=;
        b=MXGGmPfJSRlNTRXe0jVUtuRaDsOm/6WhkDCeF1vMLMwdNl4nNhEHpxZFCui3VT8lro
         +gcA1u9SyWr0LhAI2cQRXm0npYhIdBYO0z4+dKIx6mlSb0Q1Utz25ON8JdUNvsowuDDb
         WEyrZG64c9pQFsUZHRFMEaq7yrx3pmZE+ft4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pkUG8SB3NXfjwmJffISRFNjCCZaK7tUK5ZqdyRYa2w=;
        b=aPLGdZ3cximRHWz2zcaUeley4h59jqa8KRw7yfozgRdvmyTIE1eQcD3OLY5bB67Dmw
         7eZFZhySw3xFVrkCuXrvdCN/1Ek2hFBsEljYTU0LkZ0iKzZRqymBAEQxP1qJy3HZDK8Y
         IQdPQYj8zqlFoOYfTE3rdAAkTRSjhmAkLSYvqdD0OgoDuzlg5jFVjTrQN3bekco2bGZn
         yg1G8xPkhuwqe6yccE92bPqnNH7CdSAzEb/KcX7/QgzSuLr6+LYw4c4sxhJdHVHRnU2l
         fzX//2kQiOJB7+7GKEF9hed66Y4UM1Vczj4QGDxhjonL189TH7LMva/rlGvdiTx5awxd
         Z2HA==
X-Gm-Message-State: ACrzQf0nYOqZO34tdYBngqx98SU9HwmivhImk8TQNd5+N/rOAgpT9XOQ
        VwgkGhlssi9i4VpsTtPad2Gx5Q==
X-Google-Smtp-Source: AMsMyM62HTRnQRHK6brOgEL9tcaRxDkmJMjLzDzxg0lYVZMvzaihmTRJRFx4UDibn8qweq/xyrakEw==
X-Received: by 2002:a17:902:f706:b0:184:7a4c:fdd0 with SMTP id h6-20020a170902f70600b001847a4cfdd0mr10178998plo.98.1665982681673;
        Sun, 16 Oct 2022 21:58:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b00178b070416asm5676810plh.36.2022.10.16.21.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 21:58:00 -0700 (PDT)
Date:   Sun, 16 Oct 2022 21:57:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 6.1rc1: NFS memcpy warning on mount
Message-ID: <202210162144.76FBC7271@keescook>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <Y0zEzZwhOxTDcBTB@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0zEzZwhOxTDcBTB@codemonkey.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 10:58:21PM -0400, Dave Jones wrote:
> [   19.617475] memcpy: detected field-spanning write (size 28) of single field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)

I've sent this, which should fix it:
https://lore.kernel.org/lkml/20221017043107.never.457-kees@kernel.org/

However, the -1 size tells me something has gone slightly wrong with the
runtime warning, as it _should_ be ignoring destinations with "unknown"
size -- in this case, struct sockaddr has a trailing array, which is
treated (currently) as a fake flexible array, so __builtin_object_size()
is reporting the "-1". But with the coming -fstrict-flex-arrays, this
will need fixing anyway. I will re-check the runtime warning logic...

-- 
Kees Cook
