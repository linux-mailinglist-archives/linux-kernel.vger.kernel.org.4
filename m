Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E86C6C98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjCWPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:53:17 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC238A59
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:53:15 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id h17so21090290wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586794;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+TKUCmR9gfXMA0n/ry5oLIWbm0kINX2ZUTI+cvMxkhE=;
        b=D7T7I2vRyypIgXUSYd0sVhTpodxWWxYfyza0geRpA/FcgBH+ZcYDZV4AjKd8/LLT+s
         UvOuA+lVpjK35QGFdSCw+325mNzGshd0+WJwR5Cu/WkN7Yuc0H2q2ZWkB2fwQMBO+SqV
         Dq47JSnWIcGKlOKKiPnkeTn3+t2h42J1kIAlWXpjDF5Hty3a9NqIwUaVmtUJOUdzycTf
         NyO985pCnfTffGC4jBjduGRTGTmehFNWzVXKwAqrCjB46lwmkRJCoSB+Vkp/h7DdGfEi
         agI5qGZylxSBVEYhmNkB6s8Ey+keHt+rDo1867sgiLlEFNkSH8+NFdy8TdGPkuQuPR3R
         pwaA==
X-Gm-Message-State: AAQBX9cM7+PqLW6T0O0ZVmCwCc8Qn34xZKpt7iX6C0CM/OcIGbsbQgqd
        BQIHWOsSFkNI9PlaUSa5lH8M2zjZSqmqiEH0
X-Google-Smtp-Source: AKy350afa2c66pbR2VfjPz+s/GcSJI2hIYLsASzSQMnMko6lnSOT1LFGB1kY565oLywRma0IHzQXMw==
X-Received: by 2002:a5d:58d6:0:b0:2d3:3cda:b3c6 with SMTP id o22-20020a5d58d6000000b002d33cdab3c6mr3147818wrf.40.1679586794280;
        Thu, 23 Mar 2023 08:53:14 -0700 (PDT)
Received: from Johanness-MBP.fritz.box ([2001:a62:1493:d101:d423:498b:c14e:a659])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm9532684wrt.73.2023.03.23.08.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 08:53:13 -0700 (PDT)
Subject: Re: [PATCH 1/1] mcb: Remove requesting memory region to avoid memory
 overlapping
To:     =?UTF-8?Q?Rodr=c3=adguez_Barbarin=2c_Jos=c3=a9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>, "mmoese@suse.de" <mmoese@suse.de>
References: <20230323124900.898035-1-josejavier.rodriguez@duagon.com>
 <20230323124900.898035-2-josejavier.rodriguez@duagon.com>
 <c08407ec-8553-87ca-85d5-1988b8f9172b@kernel.org>
 <121decd1d4f8c4aa469636756557fce02b245ddc.camel@duagon.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <9851e06c-8430-0303-f5c2-ebcb5e38996b@kernel.org>
Date:   Thu, 23 Mar 2023 16:53:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <121decd1d4f8c4aa469636756557fce02b245ddc.camel@duagon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.23 16:11, Rodríguez Barbarin, José Javier wrote:
> One thing we can do is modify the chameleon_parse_cells prototype to
> return the actual "chameleon table" size instead of the number of cells
> which can have an undetermined size. At the moment, the return value is
> only used for error checking but the number of cells is never used.
>
> After that, we can check the actual "chameleon table" size and
> drop/reallocate if needed.
Hi Javier,

Yeah that sounds reasonable. mcb_bus_add_devices() calls device_attach()
for the respective IP cores, so they individual driver's ->probe() function
shouldn't be called before mcb_bus_add_devices(). So you could shrink
the resource between chameleon_parse_cells() and mcb_add_devices().

Btw, mcb-lpc.c needs the same fix as well.

Byte,
    Johannes
