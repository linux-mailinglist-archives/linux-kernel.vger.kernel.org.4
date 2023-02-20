Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B412D69C7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjBTJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjBTJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2665AE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676885481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/2hEfHyhsS/IdkC85EBrleARAWcDpZrTsae9Uls03Y=;
        b=g8vgnyAXMrRIKhwxbk11dk9d33wIjf0iAG8x8gLgHIfmpt5MSY/pINRgVy8Ar1B1M+WF2a
        1DTuY9Q2z1tS+5u9I9gM75GOmXMsOD2qs0AXO80shs+b2bbc1LUNQEkWopIWEFJlPdmnEw
        bz55EirS+WokZAT0WqcjAN2Zr/20aNo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-TPiKchSDPiemkd99vHp28Q-1; Mon, 20 Feb 2023 04:31:20 -0500
X-MC-Unique: TPiKchSDPiemkd99vHp28Q-1
Received: by mail-yb1-f199.google.com with SMTP id 191-20020a2503c8000000b008ee1c76c25dso2115121ybd.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/2hEfHyhsS/IdkC85EBrleARAWcDpZrTsae9Uls03Y=;
        b=opMRAkbQlJbE2hpcG3+UIv/Phzn8AIp/6RfrRet4wWWxOOZk4J2M2ACztRJJwVVYFJ
         iRx3oYx2yMgkyzv58VTwYkgeuNO/tVeDFAUYMyrLeN2uPtylO+VXlgBMWj2sS8P5AUiX
         1esgshecN1uQA1cI7TpiZNn1DeX5wKN0b14zwZrLMNy/B1XiRm1mfxlfJcTJtnVhN4Cq
         dBaidslzpeUWHd6niKxTZFNjZeYrbvauXEY8lUltiPyLBmqVtj/5JeJPWliA8fPRtV3t
         N9xqaV9YoHGuWau2GrH46+J3+T17dJWvx/g5YIlt8bp8KEjiXCTeMZ1x1v/gFBmU15/R
         K6Fg==
X-Gm-Message-State: AO0yUKVl+ybwtPTsgQkXiNxoY3dFUcSRedTYv7LbEmsp5+L4QwZ9Rpc8
        yKJZDaJ74fdle44Z2CushOxhve9rIMraszXJJZMXT4zDM/IbEv2AlO0ls5R+oubR5YTBc7vvwgA
        jauF3m6uPiEHhRretobyZLLQAzMLhP2QdOtacF6JH
X-Received: by 2002:a81:86c4:0:b0:52e:eb3f:41ab with SMTP id w187-20020a8186c4000000b0052eeb3f41abmr1658489ywf.287.1676885479746;
        Mon, 20 Feb 2023 01:31:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+GKDE1fmfkWyXmZMcFemjLeuON9REVdfPKIpqRCZV1b3nYJWIXAhug2L7b6fBD09FEwIMfA4bY4yy0T9KHQ4U=
X-Received: by 2002:a81:86c4:0:b0:52e:eb3f:41ab with SMTP id
 w187-20020a8186c4000000b0052eeb3f41abmr1658485ywf.287.1676885479485; Mon, 20
 Feb 2023 01:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20230215-wip-mcp2221-v2-1-109f71fd036e@redhat.com> <nycvar.YFH.7.76.2302201009430.1142@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2302201009430.1142@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 20 Feb 2023 10:31:08 +0100
Message-ID: <CAO-hwJKQRL1Tp42yWL-+mJgy-_nFskc3kXEHQSFC-LSnk1cFzA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: mcp-2221: prevent UAF in delayed work
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Rishi Gupta <gupt21@gmail.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:10 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 16 Feb 2023, Benjamin Tissoires wrote:
>
> > If the device is plugged/unplugged without giving time for mcp_init_work()
> > to complete, we might kick in the devm free code path and thus have
> > unavailable struct mcp_2221 while in delayed work.
> >
> > Canceling the delayed_work item is enough to solve the issue, because
> > cancel_delayed_work_sync will prevent the work item to requeue itself.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks a lot.
I realized I was missing the Fixes 960f9df7c620 and Cc: stable tags.

I am adding those right now and will push it as soon as the minimum CI
reports back that it's OK.

Cheers,
Benjamin

>
> Thanks Benjamin.
>
> --
> Jiri Kosina
> SUSE Labs
>

