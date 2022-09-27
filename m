Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E395ECF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiI0VYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiI0VYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:24:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6741EC9BF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:24:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16694622pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AVs41GVux0bxpSDCyOTBQY/cRUdKNCstV7tk8chN4jY=;
        b=DeFeq6EOWo5k00wksQVeaxeRFtcLC7+qeETTnDbgFMXpBtspyh5XRAjm9zTjLkmiCO
         mZ6kvnWBwp1nHY3SeGufM8TDTZsLXraVYdP5gXdfEAXxIfG7AqqVbqZ0eMXbO5MQdXxS
         o4cyGmO6Rqv+XsJfPOOG+JKr27L1F7V0N66BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AVs41GVux0bxpSDCyOTBQY/cRUdKNCstV7tk8chN4jY=;
        b=wVt+33ahq+e79XfGl90McLd7iL05pdD2YPqbqnSd1mcsv8PVVThLMpM0e4parpyQlJ
         uEZ8arzCTeUvhVFry209xU08uIGYlhUne6jmq+fCafxeMRROj8vcVybNatrUKPLWSobC
         MMOtSOAKdJyKE5yOTjAn6EWfEuC2pdk4sCVNwSDR3n0HezobWppUEdwqG6LBv3o9AbAK
         hiIclNCn5RtdJc4jMbpbHOcCD0MSBXUwo+mE0ItC87K7aPGjleRoESRsHfONvG1kT/9h
         ZluDd/d//QzBhXN7MrNcC02SpiEz1K3lyvGXdbI5PrmASvnHN8RT7/uXwrTCFNrHRgJH
         Y8+g==
X-Gm-Message-State: ACrzQf0cd+RAWrYIb1Wopfbtc4xpGUCiY2xcsAN6lgHf34NcQMPhAKy4
        ARFBXhg5+Q4r8388LmelHfcaRw==
X-Google-Smtp-Source: AMsMyM5vmo9268X1rr3fivj592ANmqiYo0xnHXYRVI8INujHbyz/5EMOQO4g/UhAmT+YLx2Nuw8skg==
X-Received: by 2002:a17:90b:4c50:b0:202:c7b1:b1f9 with SMTP id np16-20020a17090b4c5000b00202c7b1b1f9mr6661977pjb.77.1664313840953;
        Tue, 27 Sep 2022 14:24:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b00172cb8b97a8sm2056148plh.5.2022.09.27.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:24:00 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:23:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Split memcpy of flex-array
Message-ID: <202209271423.EA345AD@keescook>
References: <20220924030741.3345349-1-keescook@chromium.org>
 <Yy58rt9N0+dHrNtt@work>
 <202209232119.E32C14857@keescook>
 <Yy7dJP4p0FMQfPl5@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy7dJP4p0FMQfPl5@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 10:34:12AM +0000, Wei Liu wrote:
> Hi Kees
> 
> On Fri, Sep 23, 2022 at 09:22:55PM -0700, Kees Cook wrote:
> > On Fri, Sep 23, 2022 at 10:42:38PM -0500, Gustavo A. R. Silva wrote:
> > > On Fri, Sep 23, 2022 at 08:07:41PM -0700, Kees Cook wrote:
> > > > To work around a misbehavior of the compiler's ability to see into
> > > > composite flexible array structs (as detailed in the coming memcpy()
> > > > hardening series[1]), split the memcpy() of the header and the payload
> > > > so no false positive run-time overflow warning will be generated. As it
> > > > turns out, this appears to actually reduce the text size:
> > 
> > Er, actually, I can't read/math. ;) It _does_ grow the text size. (That's
> > 2_3_ not 22 at the start of the text size...) On examination, it appears
> > to unroll the already inlined memcpy further.
> 
> Can you provide an updated commit message? No need to resend.

Since I got more testing from Nathan (and the original warning message),
I figured a full v2 respin would easier. Now sent. :) Thanks!

-Kees

-- 
Kees Cook
