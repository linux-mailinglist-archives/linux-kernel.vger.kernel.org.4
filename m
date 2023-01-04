Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4265DE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbjADVMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:12:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141421B1CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:12:10 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c2so9642862plc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sDtKTYpyMvS9DLDncnqTPzsSYrOam1zdNiKzk1tunAc=;
        b=hQcZmlJvr9nU+pDNvynboWtT/ftpA0xEa6Y7jN3vL7Gl2uiHadg9Ei8xycbOwy0IrU
         c12LHrHR04VPG2QBrjLGJnQLmIStPMVVHHf2e3QJbiGXR+3iAFXwATMrQakD6pb64FJB
         XYS5px2b9gyPnrvE6pEQfwWNdsZDVs7utZxZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDtKTYpyMvS9DLDncnqTPzsSYrOam1zdNiKzk1tunAc=;
        b=oPegtYi9XjmqxdVsDfylZ13lSyayoLtu6XUBUPt8Gz1vkucod9cfc1D80GUCiQPtcD
         bcWy3rw+EB2uKXKmvnKNFyou3UtaTPmqv/ld5MaV9MoffiYc9VHAVT9Doo7fynYiB8Y5
         Tmv3CxhqENu7n9yuGc4TsLeu2kllj9lwenTGWqcJSddeDz/m5N5RtMlXLhGdfz0P9ge0
         x5mWiGKnAAteVsqXCzWQsxbXLUD4cXUi0ido08KdqtT63EAjSYwqqukiKOgRwjq+n3DM
         DYoNLgWKY5/OKuAPKHTfHXXEOibOztgAKmspz6mYrCzCCoDz1bAjfa/ceED87XQgugvx
         +/0w==
X-Gm-Message-State: AFqh2koJCT6SOQ2vbKOJCtpGtbssPLPT+qhTfXfXPShaKg+xMk5bw6bi
        XA6e+y9NWnFu3o5QEnqm+LJjaWJPvNQhfbRc4rA=
X-Google-Smtp-Source: AMrXdXvt5eWIGCwvc0xNXyv8Em4pdfcbd6X1CkYsH4ovpqyPG40YFtpjSYzRP1z47W2nB2fQ4NKQFQ==
X-Received: by 2002:a17:903:1cd:b0:192:b52f:33bb with SMTP id e13-20020a17090301cd00b00192b52f33bbmr28166704plh.45.1672866729253;
        Wed, 04 Jan 2023 13:12:09 -0800 (PST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b0019251e959b1sm4827724plh.262.2023.01.04.13.12.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 13:12:07 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id y1so1690252plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:12:07 -0800 (PST)
X-Received: by 2002:a17:902:a984:b0:189:d081:1ebb with SMTP id
 bh4-20020a170902a98400b00189d0811ebbmr2329507plb.130.1672866727144; Wed, 04
 Jan 2023 13:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20221212-uvc-race-v6-0-2a662f8de011@chromium.org>
 <20230103022540.3667-1-hdanton@sina.com> <CANiDSCuTZ17ohj=G3c_36NmnCTtwt0aBZ1Fkh-+rzwEgufK5kw@mail.gmail.com>
 <20230104205412.4294-1-hdanton@sina.com>
In-Reply-To: <20230104205412.4294-1-hdanton@sina.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 4 Jan 2023 22:11:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCtUmS2rO6Pejutpy9kbbZTJ5LC_WaPwy=4un22c72kKkQ@mail.gmail.com>
Message-ID: <CANiDSCtUmS2rO6Pejutpy9kbbZTJ5LC_WaPwy=4un22c72kKkQ@mail.gmail.com>
Subject: Re: [PATCH v6] media: uvcvideo: Fix race condition with usb_kill_urb
To:     Hillf Danton <hdanton@sina.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf

On Wed, 4 Jan 2023 at 21:54, Hillf Danton <hdanton@sina.com> wrote:
>
> On 3 Jan 2023 10:08:56 +0100 Ricardo Ribalda <ribalda@chromium.org>
> >
> > Would it work?
>
> How did you test your patch v6?

I have not tested v6 besides the compile test. The last one that I
device tested was v4 (with atomics) and it didn't crash on x86. I
assumed that since this is more restrictive it was less likely to
fail.

I put this patch on top of my "granular power saving" patch, because
it is more likely to run into race conditions, and then try to
exercise the driver.

So you have a suggestion to trigger the race conditions more effectively?

To be clear, what I mean by would it work with smp_store_release and
smp_load_aqcuire, is that based on the doc it seems like the right
choe, but I am sure that you have more experience than me here :). I
usually rely on mutexes for this.

Thanks!



-- 
Ricardo Ribalda
