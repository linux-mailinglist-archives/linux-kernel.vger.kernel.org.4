Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8940C6FFC21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjEKVzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjEKVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:55:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3D03C1B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:55:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64395e2a715so9202859b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683842106; x=1686434106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYm5zbUoXvdWIIZXy8x+n7jNjexrKMjFs8iZueww7nk=;
        b=oXs2eM/yvZexnnpdmxfsrd7zRsaq3g2sJh2MHT1oELeZFpkKjkBEJIkOJR/jDAePzC
         9fHDcwvGL0LoPfoexCswVshOQpWmlVqekET0XPyMhlHP/duuOOuBDgXwALhf2SjKEzpx
         jDBoIlxvTPtHLtaMU2EMRkiDNW3SlWHc6guPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842106; x=1686434106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYm5zbUoXvdWIIZXy8x+n7jNjexrKMjFs8iZueww7nk=;
        b=YfzoQPQTH2xc1eM5BKG//RgNXDyJgF72dcIz0WoZhL7XN411dnKo3sVpRTv1XRHTDO
         9gQJwC3w+P0N6NSQgHENIyY0IeOIM8cF5HP7ihC9X7gmkABJupu3dC2OWNK8OyEanTgC
         s61Xc/Xgj5ETmTqONcmhfJa+kRgjqTbNK0qVSZfVz+F4zZqBLvDlpqxBlxTWqysQVzZe
         JGgM3WDGdRUlUvZSJU74XLx4rlmy9df5QgcSteJW15thigggXbpmgQZLV/s0H8BVC6W+
         RjJ0oXoKGPWRXpCXwqSxff1TQdX2Xmr6su4CNGJvMlCLKbBYA28CgSrzF9Uu8O0mlQ4B
         H6QA==
X-Gm-Message-State: AC+VfDzziWyZGAQbLsL0bDqHVQR1QL7WkVirdumWxU0ZhzuEoU73rdtw
        EvGPXVWvQ5zRud8h7bkkR4s2tg==
X-Google-Smtp-Source: ACHHUZ5VnBXv0IpdLguOXUNVfu9OdAeXFEuVvxq29s+dS+1xyrg5TY3p75gjO9lG9WeyS9PiHyRwjg==
X-Received: by 2002:a05:6a00:218a:b0:637:aea0:b23d with SMTP id h10-20020a056a00218a00b00637aea0b23dmr31347173pfi.10.1683842106648;
        Thu, 11 May 2023 14:55:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f3-20020aa78b03000000b0064385a057dfsm5754939pfd.181.2023.05.11.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:55:06 -0700 (PDT)
Date:   Thu, 11 May 2023 14:55:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Message-ID: <202305111453.082DC179@keescook>
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
> On 5/11/23 14:34, Kees Cook wrote:
> > In the ongoing effort to convert all fake flexible arrays to proper
> > flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> > flexible array.
> > 
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: apparmor@lists.ubuntu.com
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this into my tree.

Thanks!

> 
> > ---
> > One thing I notice here is that it may be rare for "buffer" to ever change
> > for a given kernel. Could this just be made PATH_MAX * 2 directly and
> > remove the module parameter, etc, etc?
> 
> possibly. Currently the only use case I know of is for some stress testing
> where we drop the buffer size down really small to try and break things.
> This isn't part of the regular regression runs and could be handle with a
> config/compile time to a buffer size constant.

Okay, cool. I figured the conversion to fixed-size is sort of nice, but
it probably won't be of much use as-is since it's the buffer, not the
aa_buffer, is passed around. The compiler would still not have any idea
what the bounds are. :)

-- 
Kees Cook
