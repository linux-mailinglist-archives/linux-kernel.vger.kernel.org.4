Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7957964BB78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiLMSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiLMSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:00:02 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A923EAF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:00:01 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i2so15455067vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KbRAnoqymAJfC3zXHkWF5bbjiGJlFTBQeIItWXOJas0=;
        b=U08O6w0iGNcFlw4uzxsh16PLz3Tcq/00MpL2G94L81w0985I6T9RfhMThVC5y/56l+
         PmNnIduXpbypaPgRTjZnxEf+CR/gawJa3UmVYv2ce5L8L38dUK6BMrikv/525YL58TXY
         yXGn0D1Si/ormMDVmNHmkJFzz6IYhR9KHkQuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbRAnoqymAJfC3zXHkWF5bbjiGJlFTBQeIItWXOJas0=;
        b=7iCaoK3IHIbayLb0lqPfnc+1KeUezd1HfQQL/5rC6+xpfwyoP6MHxAgWoNc2dqUrAZ
         PrSaST1bf4DpJFyxSz85D8E4281+gEXByD4QcAUpNSWGD+u1BdPkeiZg+hiQ3B1bw8mJ
         JvMwHvjAlchCVgVDNfvqmGSBQowIJWnbCDkZFxga7UKfuqwiDChf86qpDvQaSSf7dGqv
         qsYQE4pbDhsl1oUam+ByGJsQ8gMP2D1IQBi/geGJQtgcOQo7Cqpg4TarSJqyAxj+5peK
         JjDJidDleZncmH4P400dkUjmy5RsnhSKMa1Yqb5k6UAoqIQcReuD6jLIAAgvYbypbvP0
         PaIg==
X-Gm-Message-State: ANoB5pmjOJx/HzOqs87ueXK4kxACBXd9rZO0dFaI6w8nsXuVNv5aw0Z4
        dH6RNtcnVVSb7JE5FVxlGb9fNXwsSe+fp5zS
X-Google-Smtp-Source: AA0mqf43FquSuawxNBh2K221i09nIioTMBI4+BHqubYCtOI3Dg25Zy5IvtRzwnFqYMUbca9nbcxQ1Q==
X-Received: by 2002:a05:6102:34f2:b0:3b1:6079:9bb7 with SMTP id bi18-20020a05610234f200b003b160799bb7mr11965662vsb.11.1670954400187;
        Tue, 13 Dec 2022 10:00:00 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a241600b006fcb2d3f284sm8428822qkn.67.2022.12.13.09.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:59:59 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id p18so250777qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:59:59 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr84435150qkd.697.1670954399159; Tue, 13
 Dec 2022 09:59:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
In-Reply-To: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 09:59:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK_Ocw+Xmeq=XTQATV_MDwj+kE+F2jyPg+2=jc3hzH8g@mail.gmail.com>
Message-ID: <CAHk-=whK_Ocw+Xmeq=XTQATV_MDwj+kE+F2jyPg+2=jc3hzH8g@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.2
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 7:06 PM Paul Moore <paul@paul-moore.com> wrote:
>
>  You can fix those up yourself or you can pull the tag
> below which has the fixes and has been sanity tested today;

Thanks. That was a particularly trivial merge, but I always appreciate
just being able to double-check my end result that there wasn't
something I missed.

                Linus
