Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C315BB480
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIPWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPWvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D717642F4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663368712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjRlA0RY+t+BjRtrMPnyV7oK33culdAZroSIg+6DGuo=;
        b=Zr+iE7Ke+rxamz8l8L4uW9wr0KPdYZo5q+zY1Zyb2m6FLxXcVOqr/7Tak0j1IEnUmUq2O1
        yo38w6pGFBgo6YAoOtbAklrOKOBoQXoEB6p8XrlgUlx3SHe2FqPEB+4P6cjJU3okOBGEHN
        xhJAXL7HvP8RanxnLIQ+R7UYuW7sq0U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-l7-ApqnbMMWTXzYGqOiq4g-1; Fri, 16 Sep 2022 18:51:51 -0400
X-MC-Unique: l7-ApqnbMMWTXzYGqOiq4g-1
Received: by mail-qv1-f71.google.com with SMTP id e19-20020ad44433000000b004aaa7d00846so15683483qvt.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pjRlA0RY+t+BjRtrMPnyV7oK33culdAZroSIg+6DGuo=;
        b=ydjz1tE6oRh6US/tNoUdoOQr2HqfTmqfNN3yNbTeLsYtPCy1AkFt3WYv6WjWNigvQm
         czTkj4XLEeS1P2dITEyNDGhZ8pCuGP4vNN3YrK3/u/jYbInPrApVm+8xXrsAS4dkE8fG
         gEEzjf521Y3QLvTCU2k1RrZuObQZ86nMn48S/4UjpuurOKbYiutoBQCLtTtuXbiMAXra
         Rrm0Ny+oWTckziPFMnKy9Uyoi/CzCXbsycTp8KmzMW7WDhYprG6aO/+U3p65RhPevsDz
         i6HWRrjN3bk00ZniBaSt7CLnUPxpd1ZNuEF1QwBGPSWI/+e/yfdlQMxfZcghe0U2lEL6
         zCpg==
X-Gm-Message-State: ACrzQf2lanEQIDkqflKZxFO8EUG6jDdnuQiPzBw5+JZlkzaPWIAeou0O
        MIttDGjjFOdB0xPcDZwFTpRSIbHlqP+TLg622LPlbwZ51ZDSbdgI8a/TXaFbyYn2WfiC3k3Pw/c
        Wpstph6mtxP2+tF7ZhQfgI4/s
X-Received: by 2002:a05:622a:1ba7:b0:35c:b9f1:e1eb with SMTP id bp39-20020a05622a1ba700b0035cb9f1e1ebmr6386244qtb.323.1663368710881;
        Fri, 16 Sep 2022 15:51:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZIE5CGN/wozN3NkecdxG6632/8GbZYKJKWtN0pDzveB8P7MsjbCm03j2Qoe043eCXA8tiGw==
X-Received: by 2002:a05:622a:1ba7:b0:35c:b9f1:e1eb with SMTP id bp39-20020a05622a1ba700b0035cb9f1e1ebmr6386234qtb.323.1663368710695;
        Fri, 16 Sep 2022 15:51:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id bq10-20020a05620a468a00b006ce51b541dfsm7353834qkb.36.2022.09.16.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:51:49 -0700 (PDT)
Message-ID: <9e374f8091b9d0a225137eee15349e22bff15110.camel@redhat.com>
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Sep 2022 18:51:48 -0400
In-Reply-To: <YyT9p9Gf/sTgSW1I@google.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
         <c434ba87606d3d7696ae076684ceea67bfe662e3.camel@ew.tq-group.com>
         <a959cfe90356b702727413e7c14b246875eb88b6.camel@ew.tq-group.com>
         <4b0d603814c8740b125cc6130b67c79e37405d69.camel@redhat.com>
         <YyT9p9Gf/sTgSW1I@google.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sgtm then :), will try to look at this early next week

On Fri, 2022-09-16 at 15:50 -0700, Dmitry Torokhov wrote:
> On Fri, Sep 16, 2022 at 06:39:18PM -0400, Lyude Paul wrote:
> > Would my review count at all here? I hadn't reviewed until now because I
> > wasn't sure it would, but I'm happy to take a look if you think that'd help.
> 
> Absolutely. All reviews count, and they also show that there is interest
> in the patches/new functionality.
> 
> Thanks.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

