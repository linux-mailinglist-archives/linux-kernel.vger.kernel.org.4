Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC1691372
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjBIWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBIWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:37:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0EB54554
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:37:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d8so3360196plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hwtypz4GumTJ+cjPZt4+9SVVyQ90xH/ty3YTeW6kigU=;
        b=Y1Ik3yXSoCWksBSOEEuendxNYIN/xRSmMBO4kuKOOzb/4pqRhDbtHKarNLLfASTJtj
         gcrzE/sQ2ij2u9ByfMCDD0pEb/ddZ4faEEWQP9wkoboYUZWr/gfOWDkX33YMSZyYYo0/
         foait9jJpeNrPgBsK4omT9/6tvuotS7kmeiAuwBv9Z4VcyvB3An62Wv8uIBsh72bZhhU
         N3+d1/+sBMC1hasttKa2cHcBPh6ELQudvtSNIi4wqNJYQ4vbOgvrKrIjLUSWYiLaDGUR
         s+YdFt6dtEMRtI8noI3lb2zdgsINk895c9UP/ylNESVJxfPXOlaXqYCIh8RtOTKrTCpY
         5e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hwtypz4GumTJ+cjPZt4+9SVVyQ90xH/ty3YTeW6kigU=;
        b=CDV+1cPAtbUaLTqYK4so0+58GtG4jKU2ZJBKfPEsjyE5247bAsFOPdrTxD5HS7zyOI
         dSmknZk7VnfXsqTEV4Uf/ci78W5iRwWLtd/3/EdWboqfcWjkXbcRcDy7uIiZnW9Jvjmi
         RtJJB0iotAweY08CwQKOm9uk3HCbdy7DukkKjj5DEgb+8MhwsUYWHKHA0C7Rc13WbTfI
         rB2Q8ktAKNw+TcKXQroXl5WIch3DpTzj/bcpjIYpaxtKucMhcRpyEd2x1DSOH34vuUwO
         +LjhyCCFaoro1K2eN0AEC8+HigrqB5E1FN14PJoZGKi3plrgfrta8UTp4hlkyx5Q9N9s
         s3XQ==
X-Gm-Message-State: AO0yUKWaIoHL49HBPwDoFXQtxah519wZTwW34Qnu9jYNGrEN6cMUpt3P
        h79l0K10JNamcZNeCxWqwmBnA0zzfyqgCdbFd78S
X-Google-Smtp-Source: AK7set9TglaxYfjekFil+jFiNjwYsr8jWmSQ++F779gm/+8NIlCPQYs53uzH3AzBWNKyl8pzsR+e5WB/o7jnRyXS4gs=
X-Received: by 2002:a17:90a:4f85:b0:22c:41c7:c7ed with SMTP id
 q5-20020a17090a4f8500b0022c41c7c7edmr2117292pjh.61.1675982253954; Thu, 09 Feb
 2023 14:37:33 -0800 (PST)
MIME-Version: 1.0
References: <b5dfdcd541115c86dbc774aa9dd502c964849c5f.1675282642.git.rgb@redhat.com>
 <CAHC9VhS0rPfkwUT1WMfqsTF-qYXdbbhHAfVPs=d3ZQVgbXBHnw@mail.gmail.com> <Y+VrSLZKZoAGikUS@madcap2.tricolour.ca>
In-Reply-To: <Y+VrSLZKZoAGikUS@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Feb 2023 17:37:22 -0500
Message-ID: <CAHC9VhTNb4gOpk9=49-ABtYs1DFKqqwXPSc-2bhJX7wcZ82o=g@mail.gmail.com>
Subject: Re: [PATCH v2] io_uring,audit: don't log IORING_OP_MADVISE
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Stefan Roesch <shr@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 4:53 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2023-02-01 16:18, Paul Moore wrote:
> > On Wed, Feb 1, 2023 at 3:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > fadvise and madvise both provide hints for caching or access pattern for
> > > file and memory respectively.  Skip them.
> >
> > You forgot to update the first sentence in the commit description :/
>
> I didn't forget.  I updated that sentence to reflect the fact that the
> two should be treated similarly rather than differently.

Ooookay.  Can we at least agree that the commit description should be
rephrased to make it clear that the patch only adjusts madvise?  Right
now I read the commit description and it sounds like you are adjusting
the behavior for both fadvise and madvise in this patch, which is not
true.

> > I'm still looking for some type of statement that you've done some
> > homework on the IORING_OP_MADVISE case to ensure that it doesn't end
> > up calling into the LSM, see my previous emails on this.  I need more
> > than "Steve told me to do this".
> >
> > I basically just want to see that some care and thought has gone into
> > this patch to verify it is correct and good.
>
> Steve suggested I look into a number of iouring ops.  I looked at the
> description code and agreed that it wasn't necessary to audit madvise.
> The rationale for fadvise was detemined to have been conflated with
> fallocate and subsequently dropped.  Steve also suggested a number of
> others and after investigation I decided that their current state was
> correct.  *getxattr you've advised against, so it was dropped.  It
> appears fewer modifications were necessary than originally suspected.

My concern is that three of the four changes you initially proposed
were rejected, which gives me pause about the fourth.  You mention
that based on your reading of madvise's description you feel auditing
isn't necessary - and you may be right - but based on our experience
so far with this patchset I would like to hear that you have properly
investigated all of the madvise code paths, and I would like that in
the commit description.

-- 
paul-moore.com
