Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6F738384
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjFUMSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFUMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:18:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BE10C;
        Wed, 21 Jun 2023 05:18:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46cad2fd9so59730591fa.1;
        Wed, 21 Jun 2023 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687349898; x=1689941898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pZTs7wMZ0BYXuZPnTcmyw2sMgPd+LLhQOmvBxF+zh0=;
        b=hPY3aaZKh3+hpknbkVrtmxsGiIGpyQb7f+K9ZaIrdyRzeHndbyBBituhAfeeCH+Ix1
         sT925xkkVEVyIJn6zsVntEvtPIX4Q/UhzHeBUBQKOflaJYJWKcAQvXwxDaBhu9Il6aeA
         bWibsITaEbM5lxI4iOpnHuVOBb+0g5o+55eq2givzfpZHbrX/9NKs8awvu5hWeIRg7OH
         jWsty0b/nP+hCKVM5k/pSvuS0ZFGJK6Q5SMaRUOc9bAZYhmntXEB3GIWGC0fpWJKONsk
         28g4WmvNLZWKrn+7fbaK1YTvXSyPCvHRncZZWyIG7bYweMBihyBzRKIkjl7q+FK4lCid
         EWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349898; x=1689941898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pZTs7wMZ0BYXuZPnTcmyw2sMgPd+LLhQOmvBxF+zh0=;
        b=TjmniI4+G66N7RWpRHDXwlZ2bMpcxWTRMg4k1hCIRfkjQEJ7llarR6Z6NPzVW87ZVK
         4S4HQW4712gifgn4U3zR2Z5vIAcxggvob+r1l8qrBz9ZOvNSxXupdXJ4i62sYAjQ4fPR
         ijP+nTw21d7zcxvxsJMJt3BcKvjn3JrNnpYbHmm7xXDpkcfTqm7R7ASl/OpdHyJzL+T6
         0LBM7Xxl12NXzzMan7mlIBUB+nTxa6dN5kCcw8l5np/HI2G+N5v6sKgh8j9Si31pW/6i
         StgFG1ELnZekDFREpqmjp+eZ8Ml3vFHTt1IyfZTwxf0kK1/INTZGZRAfkO7HDg9Isl7n
         K4BQ==
X-Gm-Message-State: AC+VfDwFk3adVFsUhArUBou54GeZE0X0uMDgK6Gc9X5ZVoWMQI/dVyvn
        742txqSVlOqjmoWsdstrnOo=
X-Google-Smtp-Source: ACHHUZ7RUDikRcO1bSyrPSV6dRKWHu6Oic1opMvMZxTIQ7EEmU1OIBYEkfljxBhr3LduxHDLt5XcnA==
X-Received: by 2002:a2e:8443:0:b0:2b1:d588:a1a5 with SMTP id u3-20020a2e8443000000b002b1d588a1a5mr9268781ljh.52.1687349897805;
        Wed, 21 Jun 2023 05:18:17 -0700 (PDT)
Received: from emma-rogzephyrusg14ga401iv (sa-84-52-56-253.saturn.infonet.ee. [84.52.56.253])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002b44b8409b5sm887141lji.75.2023.06.21.05.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:18:17 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:18:06 +0300
From:   emma <emma.t.christy@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] media: rkvdec: removed redundant blank
 line
Message-ID: <20230621151806.6b56f121@emma-rogzephyrusg14ga401iv>
In-Reply-To: <2023062136-drench-pasty-79a2@gregkh>
References: <20230621092223.10805-1-emma.t.christy@gmail.com>
        <2023062136-drench-pasty-79a2@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 12:51:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jun 21, 2023 at 12:22:23PM +0300, emma christy wrote:
> > Adhere to Linux kernel coding style. Removed redundant blank line.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: emma christy <emma.t.christy@gmail.com>  
> 
> You might need to write this as "Emma Christy", right?
> 
> Also, your "Subject" line has an additional [PATCH] and "Subject:" in
> it somehow.
> 
> thanks,
> 
> greg k-h

I am sorry for the errors, I am still new at this.

I did mean to sign as "Emma Christy". Should I resubmit the patch,
because of this?
The extra "Subject" got added during "git send-email" and I didn't
notice. The extra "[PATCH]" was added by me as I did not know it would
be added automatically later. I will not make these mistakes again.

Thank You,

Emma Christy
