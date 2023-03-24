Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59C6C8335
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCXRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8828B771
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679678350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRdG1BtF0+O5vmK82BeeaZgtX/zg2FQsRJkCdAg4C4A=;
        b=fQDk/YQL11mG+LooVGZBivjPdfmGFixdEoEiCX8SOdqFDxDhiRLK3bYZVooBFARtyYYSTS
        Ouf2motaX0WQEW6wl0HLb+qMoQY/CV6J4j/BAAgZEjn8/dlVaD9AANPlOvxrs0/YH3sDir
        qlFc28I6FwBHmRia30hytzHolH7eIqE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-abBHhgGEM2uDz4kZuAycSA-1; Fri, 24 Mar 2023 13:19:09 -0400
X-MC-Unique: abBHhgGEM2uDz4kZuAycSA-1
Received: by mail-qt1-f198.google.com with SMTP id h6-20020a05622a170600b003e22c6de617so1418622qtk.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRdG1BtF0+O5vmK82BeeaZgtX/zg2FQsRJkCdAg4C4A=;
        b=VUbJy/kvXPzE6IrwKy4xB7AVFvc8+if9GVbGYDCS1uE5KwoK1Iazij/4UZLyU6bkDY
         +TUoFOUcw0CVtkgBDgQv1t0gjz6akJ0Ek7Egrz5VaNcFNpwgbTfoiVekIHXaAanD+8HM
         y7PXo3mFixonSBIq4d18ADNjhmL6HvfFZh7NX3w3zdmJT2OpFEHvGWdfCu0dZ054pj/D
         xn5sXFZZ873W7VVuJc5qEN6G3BUe9kIliMCUHTuU2ymI2tRqDS7/bOIunV2IONzNKQAC
         b6tc4rEkvjP9/1RSJAn5z152z5c8FISYPnaqO+qd4IqlWe5MEsZkrBhnceZA24z2Ig2Q
         ZnIg==
X-Gm-Message-State: AO0yUKXYWkCMGsv1KFVLWVhNs4g2fOeGJ4fO1Lxtq8hGyY1cVja8Ti+4
        9wydCpkJe//h0De7Vn6TdSqoQl9qI/UwLdnoIaarAdKGwnn1dUyuCv0cuEWmejRxP87z0zpvWS2
        B1QFXuvCTNcUDwYDtFeCRFXHmgY8urE5o
X-Received: by 2002:ac8:58cb:0:b0:3bf:b75a:d7a7 with SMTP id u11-20020ac858cb000000b003bfb75ad7a7mr17488891qta.7.1679678348514;
        Fri, 24 Mar 2023 10:19:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Rbq4oH8qL3Uss5BKUMIP1q48p9N04PxOZSlI1W/66wpmMW3fNVZpbRku5c8MRrbOWeWkkpA==
X-Received: by 2002:ac8:58cb:0:b0:3bf:b75a:d7a7 with SMTP id u11-20020ac858cb000000b003bfb75ad7a7mr17488859qta.7.1679678348241;
        Fri, 24 Mar 2023 10:19:08 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id s128-20020a372c86000000b0074374e2b630sm14534036qkh.119.2023.03.24.10.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:19:07 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:19:09 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
Message-ID: <20230324171909.t6hhuwzduypj5b5b@echanude>
References: <20230309233945.1199358-1-echanude@redhat.com>
 <20230322025519.a5vrqljezo74qxwi@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322025519.a5vrqljezo74qxwi@ripper>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:55:19PM -0700, Bjorn Andersson wrote:
> On Thu, Mar 09, 2023 at 06:39:48PM -0500, Eric Chanudet wrote:
> > ABL uses the __symbols__ section to process the DTB before passing it
> > forward. Without it, the bootstrap is interrupted.
> > 
> 
> If the reason is that ABL refuses to boot without it, then please have
> ABL fixed. If on the other hand there is a valid reason for ABL to
> require the dtb to have __symbols__ defined, please describe that - if
> nothing else so that others know when this is supposed to be used.

Here is what I understand from the ABL sources and discussions with
Prasad:

Android Boot Loader (ABL), the UEFI application to run before executing
the kernel, implements the Qualcomm SCM protocol to call into TZ. One of
these SCM call is trapped by the hypervisor, itself provided with the
firmware package for the board, and returns to ABL some information
about our VM. These information may include one or more DTBO. ABL then
proceeds and tries to apply the overlays on the DTB it loaded from the
Android Boot Image it is trying to boot.

If there is an hypervisor and it returned at least one DTBO, ABL treats
a failure to apply the DTBO (e.g, if __symbols__ are not available in
the DTB) as critical and ends the boot. I was only ever given a firmware
package that included the hypervisor and it always returned at least one
DTBO. So enabling overlays is required to run this board, using the
firmware I know of, with an upstream kernel and DTB at time of writing.

I suppose ABL could be made to handle such failure as a warning and
continue booting? Which comes down to ignoring the DTBO provided by the
hypervisor. Maybe that still allows the kernel to run the board with
limited functionality?

Prior cases in the git history for enabling overlays covered board
variants and extension headers (ti and nvidia). These do not fit what is
happening here. In hindsight, I should have sent this as an RFC, with
the above explanation to begin with, to ask about the limits and
requirements.

Maybe Prasad, or someone with a more comprehensive knowledge of this
board, can fill the remaining gaps or correct my understanding of the
boot sequence if I got something wrong?

Thanks,

-- 
Eric Chanudet

