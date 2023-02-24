Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B06A23E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBXVjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBXVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:39:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBE5848F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:39:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so634181pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0U15SCPfIqC0m6RYPP1r/3VMkd/wkwS9VeVBVrqXrU=;
        b=lVbsh+JAQm9KLX22cboY+0x5+SxBfp+DmxmNW3BfdqOSRuS2TIEvatRUELvE4EL4bP
         LY7t8B+z/ivHwgQsshtk9bzikpNyM/CujqYRsPbTMekP9q1HKWSMBI4W0xkZnYVceEmT
         mWK6KqjqO6rb1tvHumq1YRMawzyPayHjp9YMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0U15SCPfIqC0m6RYPP1r/3VMkd/wkwS9VeVBVrqXrU=;
        b=WFQIltf81be1V2sCgBFH+n6BXmuBdmONJMdt2CG399K7cbElZj8i5r7PkvZ548RB1S
         3V5WksAp0JmQCCDCdOKqgd7/tViEbjEN971u5D7v7Wqod4EbWuhnDSvOJj5z4JA4+4DB
         dqD2DZkeA8HstjyDM8h1XdWkBv90vCLdNu8Js7g5GvRszzPRv7b8igDT3qsBppMzGk/n
         LHJwgdUh5Sr035VxfAb0/OHBnChjEzDi4AiUu34ZJct9SbmV6SVfKQSUgmxYomlehdmH
         H1odfI2TdyQdNuzdBysb65bGLdCf39iDP7CEOqlpjaarbaV8HF8/3jmBSBzZiNJqzCgM
         xuZw==
X-Gm-Message-State: AO0yUKU+H1xBSAuP2ZzR04CvJTdfThUNNl8flG+r0TlXc0jXOzy0CKac
        DuZj5x5QGzMlNcAxgfJoR7t4KA==
X-Google-Smtp-Source: AK7set9BbuYHHXnFHfMPPUgDVlsItcAL3sZ8dyfXgjAcXKnlZht64MAY/RK1Wp7HeHbkHd7PGJS6fA==
X-Received: by 2002:a05:6a21:6da2:b0:c7:8779:4167 with SMTP id wl34-20020a056a216da200b000c787794167mr19752281pzb.30.1677274791410;
        Fri, 24 Feb 2023 13:39:51 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b4b7:a941:f40c:bd01])
        by smtp.gmail.com with ESMTPSA id p18-20020a62ab12000000b005ae02dc6285sm5825pff.203.2023.02.24.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 13:39:50 -0800 (PST)
Date:   Fri, 24 Feb 2023 13:39:48 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, ganapathi017@gmail.com,
        alex000young@gmail.com, amitkarwar@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mwifiex: Fix use-after-free bug due to race condition
 between main thread thread and timer thread
Message-ID: <Y/kupIIGBHQ2rQIZ@google.com>
References: <20230218075956.1563118-1-zyytlz.wz@163.com>
 <Y/U+w7aMc+BttZwl@google.com>
 <CAJedcCzmnZCR=XF+zKHiJ+8PNK88sXFDm5n=RnwcTnJfO0ihOw@mail.gmail.com>
 <Y/aHHSkUOsOsU+Kq@google.com>
 <CAJedcCykky7E_uyeU=Pj1HR0rcpUTF1tKJ-2UmmM33bweDg=yw@mail.gmail.com>
 <CAJedcCztEkE=EB2GmH=BpTvD=r_bwGXk3RYDM2FU=f_SvEaJHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJedcCztEkE=EB2GmH=BpTvD=r_bwGXk3RYDM2FU=f_SvEaJHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:17:59PM +0800, Zheng Hacker wrote:
> This email is broken for the statement is too long, Here is the newest email.

It still wraps a bit weird, but it's good enough I suppose.

>               retn -EINPROGRESS in mwifiex_init_fw
>               mwifiex_free_adapter when in error

These two statements don't connect. _mwifiex_fw_dpc() only treats -1 as
a true error; -EINPROGRESS is treated as success, such that we continue
to wait for the command response. Now, we might hang here if that
response doesn't come, but that's a different problem...

I'm sure there are true bugs in here somewhere, but I've spent enough
time reading your incorrect reports and don't plan to spend more. (If
you're lucky, maybe you can pique my curiosity again, but don't count on
it.)

Regards,
Brian
