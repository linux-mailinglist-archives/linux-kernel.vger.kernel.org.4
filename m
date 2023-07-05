Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2A748F94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjGEVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGEVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:11:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1919A2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:11:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a337ddff16so119853b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688591464; x=1691183464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQrTNkqXIn8AEtwjMFYzAXuEIG3rdsBzjM8m4Q99lIk=;
        b=nMasCfUEodGC7sLNWqUQ3rRKqwRy511OtuaoDL5GR5Uq4uqtDwDR7ZIjWLOq0gbvu7
         uG0I4/cWuJt+o9wVG/A0OnqBVkOCNJx/AlNsRoT0oyGIBA3QzwFef/F9LZhQsXc7K/XW
         uBRKlTg2NTbbajdmkQUhGABuZvslJXIiapsy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688591464; x=1691183464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQrTNkqXIn8AEtwjMFYzAXuEIG3rdsBzjM8m4Q99lIk=;
        b=jtk5IO/KD2FYj2DK+zxgzNaJJwkb3mW4jQNZ7gV7JjDSr021mc0KQBribsRqz+f3WR
         dEkC12pmZ67UCJcF9Mrq0cCEloxkqyR/oZIpygh+AAhhpsYhakKqhUXI7NT65ws6iNCe
         OVWqAIwEgxGgRuPqMY52YsY2V8fExVgKqMm6QJDiKzHlSilepSaaHctXl4CoE3WLbNX0
         tjC6bbWMoxG47RCUsDKY1oqyjVOWMRlmQO5V989MrWQPqB1xoRlLVxbG9rmtphSPXBzY
         UDDL3kPg/r7mDeiffRYsGOsCAYNOj3xy5JfTc6UxJhoHdPyhGvc/kWnIQocPi6UR2jnu
         r2ew==
X-Gm-Message-State: AC+VfDxXaYWdN1DJquzl5poNtyolm+WkSI2QaJBCiqO9X5DTP+ZiwbaI
        XPSdCVyAYHfFN+3NY5vT7sbf1w==
X-Google-Smtp-Source: ACHHUZ7D/Y+nkLim7yg1njmHhll4TA7487jUsc/injzNY8G+JDXXIBUtNWr+V6XQcdUzotEeSXZ7QQ==
X-Received: by 2002:a05:6808:64b:b0:3a1:e13e:a89e with SMTP id z11-20020a056808064b00b003a1e13ea89emr16673048oih.19.1688591464262;
        Wed, 05 Jul 2023 14:11:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i20-20020a635414000000b0055acfd94c20sm4329pgb.35.2023.07.05.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:11:03 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:11:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ch9: Replace bmSublinkSpeedAttr 1-element array
 with flexible array
Message-ID: <202307051408.E16A95E@keescook>
References: <20230629190900.never.787-kees@kernel.org>
 <2023062950-landowner-goofiness-d5d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062950-landowner-goofiness-d5d2@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:17:23PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 29, 2023 at 12:09:00PM -0700, Kees Cook wrote:
> > Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
> > UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> > bmSublinkSpeedAttr will trigger a warning, so make it a proper flexible
> > array. Add a union to keep the struct size identical for userspace in
> > case anything was depending on the old size.
> > 
> > False positive warning was:
> > 
> > UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31 index 1 is out of range for type '__le32 [1]'
> > 
> > for this line of code:
> > 
> > 	ssp_cap->bmSublinkSpeedAttr[offset++] = cpu_to_le32(attr);
> > 
> > Reported-by: Borislav Petkov <bp@alien8.de>
> > Closes: https://lore.kernel.org/lkml/2023062945-fencing-pebble-0411@gregkh/
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/uapi/linux/usb/ch9.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Thanks for the quick response, I'll queue it up after 6.5-rc1 is out.

I'm going to send this before -rc1, since we've had another report[1] that
was fixed by this. Given the verification there and Boris's testing, I
think this is good to land. I'll toss it in -next now and send it to
Linus on Friday after making sure there are no more surprises.

-Kees

[1] https://lore.kernel.org/lkml/DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org/

-- 
Kees Cook
