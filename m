Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1F7315CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbjFOKxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjFOKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:53:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8931FEF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:53:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b445512846so7517491fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686826408; x=1689418408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12noQGaXaCio4xE7tY2PTj55pZiPVzsZBBs1ILnt2BY=;
        b=SvvtytZ1UIzmZ0doON8IzZxdgdCcEQNIoRw/yDFpUxow5PC3BRn+faXkaFkmZo7XMy
         zhK58k2zZnBYvNq+VUZ1DurzV2mjhIxoUi5cJBhf3GLiQZ7BpyA2rWMXNl7x9FcP3BR6
         Ok/4NvqHyfYw8wb2pf/m88GpjrHyWc/8UYXG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826408; x=1689418408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12noQGaXaCio4xE7tY2PTj55pZiPVzsZBBs1ILnt2BY=;
        b=cO9Yk3pJ25SBbebJwFqG9mfCZaSe5048+g4hVmuB2rXHQgWL3HshvVsS2Te7+qOn8U
         l8/KJbLbl33WZkH+7N3Qq1v1mR1kZmDjKSucXVKTSzR+WWwfDZvj7uSYZHWeep6VvttA
         oLLcRgDwBdWyl0X8pxk39FnkDDo9p6w44tt6IW/j0kRlDOCqHXtcfurGZvUwFpQjX6x7
         O2pMBbJfSfIguK5pxeMtql+pZFgr9eu4c9toBZPI/d+aqJJWIkxFqqBp1/2vKTw65rZb
         fvJbU3J4Bkh11WHt7Azrp+q4QnNtYk1zNURawNZP6QM5sVY/e6ONyu+1oD6Vyo7k47VD
         b30w==
X-Gm-Message-State: AC+VfDz8CoFMF8zrZ/H6AZ5X4q81JjV5GK5RvJpsZXSXQmj3td5CfFmT
        o6fbd5UAOfBbv8pW7LQ2iW43bw==
X-Google-Smtp-Source: ACHHUZ7LDb8n/Y3cXJ9Vpe9EVhKZPEAH3iI+mHFz6R7sMvp0xiUM+8je8H0Zmw/6wUXe+y6+PHNcGg==
X-Received: by 2002:a2e:8719:0:b0:2ad:a9c0:1236 with SMTP id m25-20020a2e8719000000b002ada9c01236mr8598104lji.6.1686826407909;
        Thu, 15 Jun 2023 03:53:27 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050bc6983041sm8727751edb.96.2023.06.15.03.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:53:27 -0700 (PDT)
Message-ID: <bd17c1a4-6102-3d93-5494-89fdb0a346e5@rasmusvillemoes.dk>
Date:   Thu, 15 Jun 2023 12:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
 <ZIiJWKBFojAcNCkA@smile.fi.intel.com> <20230613212651c8770218@mail.local>
 <ZImvjj34YILrNJU5@smile.fi.intel.com> <20230614135036a3e049c4@mail.local>
 <ZInZMEZBZ8Dm2jem@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZInZMEZBZ8Dm2jem@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 17.13, Andy Shevchenko wrote:

> When reading such a code the following questions are arisen:
> 1) Can the positive return value be the case?
> 2) If so, what is the meaning of a such?
> 3) Why do we not care about it?
> 
> All this can simply gone if we use
> 
> 	ret = foo(...);
> 	if (ret)
> 		return ret;
> 
> As it's clear that whatever is non-zero we accept as something to be promoted
> to the upper layer. I hope this explains my position.

But we're in a context (in this case an ->ioctl method) where _our_
caller expects 0/-ESOMETHING, so returning something positive would be a
bug - i.e., either way of spelling that if(), the reader must know that
foo() also has those 0/-ESOMETHING semantics.

I honestly didn't think much about it, but looking at the existing code
and the stuff I add, all other places actually do 'if (ret)', so I've
updated this site for consistency.

Rasmus

