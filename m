Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52959613B68
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiJaQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiJaQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:34:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68EDE8C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:34:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y4so11237657plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=obeX+yDYnUsYZGh7gFLc0dAPSqRBY1nlM7mpKrWzBOA=;
        b=qYAwmbATVdxnl6xZoLspVQcidYpVhDWl4z8HcsLjA9ESU8O3opsUZhwPRLlLGXI1Gr
         rLtjiY6SX160DIs9fQCyeYd6+D2qldG/XGzugE17bTcfbmD+AFpdWCJ/rgwdYyi3Ja0I
         K1YolTZJScgEDm1brDYZkb87hLbnTYCR4MwoICrOocBflruLjTZVMGHLgbX4YB1vXBT7
         t5+uYxaDY6j/9LvQgVhkL6DmJjmTwumu7nz/w8lAkw0BSIyTVPqjF7f4uakMlfwvQ4Fq
         Il1Mxp5G3efEoqzTsE4jrlqfNtdByhh0HJ4cTuPbcJVPaGbcR5I8DqTxVNZA6oDnOJeW
         oSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obeX+yDYnUsYZGh7gFLc0dAPSqRBY1nlM7mpKrWzBOA=;
        b=KqSCXr5zK0ol0Njb1qxS6pHgTEpzC9qEswKq5Y2j/BxtWFkrQhg2bZ3YguAGWAj7ml
         vnhSM0eAyVmUnZdboYLSReWTuE9dwtzdhOtpqDLnDzivD+6Rrx4CcrDcz/mjhrYTOYdb
         MWr4MC5xw3PYM03sJplxFvNIUMv79tGkOGVZNP7H7JdPnChOWDqn3gyzMRtq6s0ts+Fw
         5+b7XKCJR0V11GxlorUkZFggL8fXpO9auEhRGTck1fpjzM2xtre7p5wMTKCXDJgi5L0O
         fwYqFdIxn+YHaU3N92acxhkxg7SuwvE4Rga+s98z1jtgdKMtBl6ycd2QU37xWPwSTtDC
         b6Mg==
X-Gm-Message-State: ACrzQf3SSQdhI1T88mVBhqmF7vlltKxeap3S5VSoMeEYJ3xFcM6SRdC2
        kru+mQvAAqCdP8s8AfRDR7EC9A==
X-Google-Smtp-Source: AMsMyM5n5QRcU/Q1Cu32sx3uHNDTwIx9cPeQsxyyuGiTbaAhYzpgE/+wXgva2Um4sCYzUaCMPQKwdQ==
X-Received: by 2002:a17:90b:4a4a:b0:213:43bc:91b3 with SMTP id lb10-20020a17090b4a4a00b0021343bc91b3mr33066443pjb.151.1667234063190;
        Mon, 31 Oct 2022 09:34:23 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b001866a019010sm4677680ple.97.2022.10.31.09.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:34:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nishanth Menon <nm@ti.com>, Nicolas Frayer <nfrayer@baylibre.com>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        glaroque@baylibre.com
Subject: Re: [PATCH v3] soc: ti: Convert allocations to devm
In-Reply-To: <20221028185647.d74ncedmocfbr2s4@debating>
References: <20221028180033.606362-1-nfrayer@baylibre.com>
 <20221028185647.d74ncedmocfbr2s4@debating>
Date:   Mon, 31 Oct 2022 09:34:22 -0700
Message-ID: <7h8rkw2bqp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> On 20:00-20221028, Nicolas Frayer wrote:
>
> Quick cosmetics:
> linux-arm-kernel@lists.infradead.org (moderated list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
> is part of the results of get_maintainers.pl  why drop not CC it?
>
>  git log --oneline drivers/soc/ti/k3-socinfo.c
> soc: ti: k3-socinfo:
>
> Please fix the $subject
>
>> Changed the memory and resource allocations in the probe function
>> to devm. Also added a remove callback.
>
> Yes, but why are we doing this change, what benefit do we get by doing
> this change?
>
>
>> 
>> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>> ---
>> 
>> v2->v3:
>> dropped module conversion part of this series while other driver dependencies
>> on socinfo are worked out.
>> A dependency issue is introduced by changing subsys_initcall()
>> to module_platform_driver(). Some drivers using the socinfo information probe
>> before the socinfo driver itself and it makes their probe fail.
>> 
>> Dropped series:
>> https://lore.kernel.org/all/20221010131538.7333-1-nfrayer@baylibre.com/
>
> OK - if we are'nt going to convert this into modules, then is there a
> reason for this patch?

Yeah, Nishanth has a good point here.  Lets wait on this patch an
included it with the module conversion once we figure out the deferred
probe issues around this.

Kevin

