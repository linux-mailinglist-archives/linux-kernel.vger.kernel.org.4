Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC5673AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjASNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjASNpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:45:33 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B5613C8;
        Thu, 19 Jan 2023 05:45:31 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id y11so2817813edd.6;
        Thu, 19 Jan 2023 05:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmJ1PmU+O1t8VOqktlJmZss7v21USd4ogCE4ggNj4Ts=;
        b=r36gV3WhAw+6u8ZE38Sgw56ewTkFs27p0ky7ceWBB/HsenW/tZJMh8GA3ddRb5Im5n
         X9xMuRO389xt9Rp2+1j5ixuQrSIwJeh5lBN8jUenXepvQJyBrCAt6VOsXvdcJjx/mJtj
         psIEpyU1ZoidDbMN033lyvLiBACbyxITDHmjz/Ylb1wXQdwbmlXo98ktTB0YXHBo2tp+
         kmXUUJpfjbR0QyuWjcLC1kRliUxbU2xJVkj2QqWSL1qYvQvYLjJ6XvwSXqshgxTZ6rt1
         xLanAIsudTZN/9sCv/gLHNiB+8LLMwqEzqvLsjXsczcgltMFgJ5YAT6A561rjhijCYbL
         9v+w==
X-Gm-Message-State: AFqh2kr/svr5T4idSCZqCNFZtLm5eHJ8JlYxX9+sCq+j5U3vPDA/ZB8D
        VlGGmSpx94UUExA7PqQLbvE/IcfhE2A+WD6kYmI=
X-Google-Smtp-Source: AMrXdXvqk5X626uHwsxtL9TBtrt4Ic6yLlTOKzutzEgUvLa9gQF8kM8k+Dru6a6XZRn0SehYP8FHNeZ85vI2mDY8a0c=
X-Received: by 2002:a05:6402:1f0f:b0:47e:d7ea:d976 with SMTP id
 b15-20020a0564021f0f00b0047ed7ead976mr1014185edb.223.1674135930181; Thu, 19
 Jan 2023 05:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <CAJZ5v0h-QkrgyLYLn9S_mkWN5nN1fUXej8zmarU425xW-Lei0Q@mail.gmail.com> <5f90aef1-93e1-832a-6cee-6e2cb4d7ec25@linaro.org>
In-Reply-To: <5f90aef1-93e1-832a-6cee-6e2cb4d7ec25@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:45:18 +0100
Message-ID: <CAJZ5v0g+E9C_ruDZ-8zYxsR-+HCO_M__v9SNb_Kr_UL3B6ud0Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/core: Fix unregistering netlink at thermal
 init time
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 2:40 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/01/2023 14:28, Rafael J. Wysocki wrote:
> > On Wed, Jan 18, 2023 at 10:11 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The thermal subsystem initialization miss an netlink unregistering
> >> function in the error. Add it.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > What tree is this series based on?
>
> It is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

OK

Can this information be added to the patches or to a cover letter of
the series next time?
