Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070905E8876
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIXFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiIXFCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:02:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F20E3690
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:02:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w10so1826517pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MMEBYaMOzdpzXPogcv8kr+syTk85OJi0zwEq0z3+2Qc=;
        b=F2svVoqMctp1emwUly/fI3soo/qx5BPNZ5fw+jsptt3cqIkZ5dETpLNhDK1U7poO5/
         YpF0c1BMSk8+Tituvui3HYKaZX/1JqgTAAqSlLFuOj33sGDQaeOhBNkbF2chSdmZpgJR
         AUP10UyCFL1vNAs2CvS3zBLcs5xVgVsJybQpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MMEBYaMOzdpzXPogcv8kr+syTk85OJi0zwEq0z3+2Qc=;
        b=HYwPyaPpN3alQGrPNmzXybv7CJ3FdZmarfPcAtCgv6YNi20XqZccOi5d2/U6mFNLDX
         zuGvzBx+jXZuCnejFH7/ZrZ3JrFZSREHwRfcrGXqZ+hxeYG+GQ1DTFm7ti4pFxteBbYO
         U29jQQbY0C+lBNU0xZeCHDj93cQj7FAlczOTx60mBGwltofPILOn7gMiRlocb8Rw58Jn
         910EnL9BncFMFnkEqyuqe2Pv9jKDgqnjSMwUjIpxgH+cqME9Ne3kHKtSxhkakHYTFaO5
         ukgu8Kn3DTvYVbzq2dPJf1hg7I74ogoq5dNXtUOq5bTMPZtywPUKcoPekYoKKpWuQrrg
         X7eQ==
X-Gm-Message-State: ACrzQf02461solZXNPAMOka6r8Rn6RoPPASb8eHXHWTcvxc6JS/VjahS
        rYk8AKZQShhEqgR7plAR9U3bgg==
X-Google-Smtp-Source: AMsMyM5XuVXKp0flb6caZ+0I2u3XYXF4c+/Yej8tJULd/fmk5wIHKol0DuXh9lomXZnX3l0y9JUfEA==
X-Received: by 2002:a17:902:7894:b0:178:bb0b:5740 with SMTP id q20-20020a170902789400b00178bb0b5740mr12011675pll.65.1663995749292;
        Fri, 23 Sep 2022 22:02:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902edc500b0017534ffd491sm6807984plk.163.2022.09.23.22.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:02:28 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:02:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] fs/exec: switch timens when a task gets a new mm
Message-ID: <202209232159.BA0DA829@keescook>
References: <20220921003120.209637-1-avagin@google.com>
 <202209212028.0C060F98@keescook>
 <CANaxB-xGhJM4Boo-_fc2=kTE=0RpAL1CUxisNpvzpME_WNM_sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-xGhJM4Boo-_fc2=kTE=0RpAL1CUxisNpvzpME_WNM_sQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:47:46PM -0700, Andrei Vagin wrote:
> On Wed, Sep 21, 2022 at 8:29 PM Kees Cook <keescook@chromium.org> wrote:
> ...
> >
> > This looks good -- my intention is for this to go into -next after the
> > v6.1 merge window closes. Does that match everyone's expectations?
> >
> 
> This works for me.
> 
> If everything goes well, it will be merged to v6.2. Do I understand this right?

Right, that's what I'm expecting. :)

-- 
Kees Cook
