Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D916967C119
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjAYXoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjAYXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:44:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA02915D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:43:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d22so31127iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lLsfGB7o6bQLZlJn8wIPp4i153QNI/rS+u5LYvXXrlI=;
        b=C4DSrmntZfcfbtjDjVey7HsRIcI7mPcVbjwJayVjP4yni5Piwsg3/nnLLMhSIRKLb+
         ZJYt7M8EI7h4MlBqVDJTtJx7hdaC2/WadGhfsAFvYlVO+8yX9QzaBwbBcQUu2aOu+mVR
         4S5Fa5Ml8zL4Ly0yLdI0jqLcdEUWkqlEX2d6PFLBpuQnMKTPJaBW9LdLBf1QpeXq0WS/
         AWlpSgS59URInsUKVZ/A73x7YNfxYciIliiQMGaksQ7VTBvJZUut8HOJOAzBpiJPWxQO
         dHR2BS0OnRMGNPzxkGgrpU3dUW97Kpmjwx9jdiLMIuMsfIuCXgVAuk4LrY5OzPY9DNDO
         bdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLsfGB7o6bQLZlJn8wIPp4i153QNI/rS+u5LYvXXrlI=;
        b=K8ghgapsNF4l4DwRy6VYFmMCrPZ5Ml9xhydHVtw52M+7ItfYZpGyhBIM0sVb5rGQMm
         oW3Z0UNyRVt6e7RsjXFjZwUoo7+aiS2HV0TUZOjTWIvCIgtCaRs54s1Ow3vRnYfg5AlY
         dAP21Lo75ZPX+B8yqX84S9wQz4pa6bOj7uGoFeiAxZC0B8fGANXXdyvcsas48NI7H3+b
         7nKBW+RkZLJGe12Fy0FVEVQ5JNMeOmoTjX//tq8Q+/E9ZYoZUN6cUp8xaTuETkLwFvPt
         3Z9n2TLgnAjveAwfyRd17QU6PYrd4dSYFeq71BWUdYR3+XlNWL3GBHBFAH1LguCWHMOt
         d7cg==
X-Gm-Message-State: AFqh2kpdrK239Q3KP/NwqcTBHv9rkcFnrCZU/92glUCX++4y5VLAXp6y
        ATx7UW9Hz0zXW5DlQnx8D/AVDx0crxJlHN21ds0=
X-Google-Smtp-Source: AMrXdXv+qBRy2MHr0D1QR2YXL2+ixa7Z3IXZPhf8EhPY6E8nwAlB1zBAWBubqNe1sePEF/3y7BJHwrKFzbPqQi0EtYY=
X-Received: by 2002:a05:6638:36c6:b0:39e:8c9c:7e37 with SMTP id
 t6-20020a05663836c600b0039e8c9c7e37mr3674865jau.77.1674690207948; Wed, 25 Jan
 2023 15:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20230124234156.211569-1-avagin@google.com> <Y9Fq7hcWDfMKUvPZ@google.com>
In-Reply-To: <Y9Fq7hcWDfMKUvPZ@google.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 25 Jan 2023 15:43:16 -0800
Message-ID: <CANaxB-xy_ikjuWOzsCk7u5jRqxxevcDOGHJrKCSPx2U_jv3ZcA@mail.gmail.com>
Subject: Re: [PATCH 0/6 v4] seccomp: add the synchronous mode for seccomp_unotify
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:46 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jan 24, 2023, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
>
> Is attributing your personal email intentional, or is user.email in your git config
> misconfigured?  Quite a few folks use non-corp accounts, but I don't think I've
> ever seen a case where someone intentionally posts from their corp email on behalf
> of a personal account.
>
> I don't mean to be the SoB police, this just stood out as being very odd.

I was more often working on kernel changes unrelated to my work at
Google. They were around the CRIU project. It is why I used my personal
email in the kernel git config. I will fix that.

Thanks,
Andrei
