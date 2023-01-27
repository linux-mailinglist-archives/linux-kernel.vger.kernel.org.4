Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD267EA26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjA0P75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjA0P7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:59:40 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329DC8661F;
        Fri, 27 Jan 2023 07:59:19 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 076C4FF80D;
        Fri, 27 Jan 2023 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674835152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwUvyQY9yRU9Kps/tTQepr1PT3uk85OHb20x3oTLZeE=;
        b=H8V67OhRZxSoFiHjZbsrUqofjNWKaI8I5plOXWne5ntYSeawDb7JbPcU5mzIu38NiKs8Nz
        Tuijj7CgTKJ3GUTNvF3xdCd3Pwvwx9R4TqSmtln/PpSQD+IKPki1gVvVXKjH4VHAEBqu06
        Bfx79Qj4IkG7MYunWVQJElwUG33JdJNTWQucc8mjJ9fKdyxnss+O3jShAdURfpyIZqspyY
        cVBj+ReQxmvQSBxBGAt9iBP8B0wQQsdZBz77XzgS+2pCErbjQMgYl/PMwlltA06+Or8vek
        5RklEXrtEelCkUlTeM935v28bpRT417JmFcVzS9vpBWwQqQJgPVg7PHjNp216Q==
Date:   Fri, 27 Jan 2023 16:59:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/24] rtc: pm8xxx: add support for uefi offset
Message-ID: <Y9P0zuovXqBbFSLs@mail.local>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-20-johan+linaro@kernel.org>
 <Y9PrdqLHZpZrdGJ4@mail.local>
 <Y9PtIiD1o8eBq2wk@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PtIiD1o8eBq2wk@hovoldconsulting.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 16:26:26+0100, Johan Hovold wrote:
> On Fri, Jan 27, 2023 at 04:19:18PM +0100, Alexandre Belloni wrote:
> > On 26/01/2023 15:20:52+0100, Johan Hovold wrote:
> > > On many Qualcomm platforms the PMIC RTC control and time registers are
> > > read-only so that the RTC time can not be updated. Instead an offset
> > > needs be stored in some machine-specific non-volatile memory, which the
> > > driver can take into account.
> > > 
> > > Add support for storing a 32-bit offset from the GPS time epoch in a
> > > UEFI variable so that the RTC time can be set on such platforms.
> > > 
> > 
> > Why are you using the GPS epoch? This seems pretty random.
> 
> Tell that to the Qualcomm firmware team. ;)
> 
> Perhaps I could have made it more clear, but this is the format that the
> firmware uses so Linux is not free to pick a different base here (or
> time would differ ten years between UEFI/Windows and Linux).

I expected this answer so please add this to the commit message, this
will be the fifth epoch we ave to handle then...

> 
> > > The UEFI variable is
> > > 
> > >             882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> > > 
> > > and holds a 12-byte structure where the first four bytes is a GPS time
> > > offset in little-endian byte order.
> 
> Johan

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
