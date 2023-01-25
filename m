Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E197467BA84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjAYTQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjAYTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:16:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66EC1F4BC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:16:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ss4so50242105ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpHOzPSp0+2DVR/IBcmdeeYd61gBn1vynCwibN+pOkE=;
        b=cQIGVXdlZr5h+z0gvRmUwKcGYka6xYqdS+WGzhpAJT3CvI3E7xt44LpyFEfKMzz1lF
         vYaxf2dK5jLgitazYDJZVD3O3vBBvUW7ZLUe5dHKuzQLdJy74ArtqjZD9hPlzxRoGNG3
         /bew91YduRwZNbWH92+zOG8DJJzcXqe/Ip3ZJ1/AUsXJ53Tu43JPupQ3Xsv8jpFKMk5V
         nHSL6mUsw7I/hr4mxEA5pLhBKfpHDNLFilq1yUTelK4bfE9mFQcA3WoY6A1DIZ6+q/mR
         zKSRadM5sp5YbHdEPDarGDtaCZ8FB3PE79xUMR+oj0rCuo1atPeenTQyNUSvQuxM61sF
         dnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpHOzPSp0+2DVR/IBcmdeeYd61gBn1vynCwibN+pOkE=;
        b=qEPJQ2bsMdYNErVtr4NgBvD2U92ekCj8f2MzwYO6WqzZf2ZMqOToD6Syk4oDwuq7PH
         Db5Axh+MK62b/5ez9VlQOos7CutuVb7T4PYbN3PDPSTrBxdcCouKVlxBrGKSQIZ/oR0d
         BzTaVMrZCLhBzkLpjV1oZfuIfp2sRUbDDMlffdrtC1p0jTZHXO+a+0Dzy13K8XCHhwtX
         IuipEcZ3Jq4jfNc6RyNWfe9+aoAMV1yMYdtzTijjKPidUX+NDq+KQ9CuwVyr9OdQwLoS
         WBh04sFFxISPsmYGp07Q07OsTgG7juxAF27QzN7K/5cxfhTS7hMFbdxOmDmPT6S8WA06
         eY+A==
X-Gm-Message-State: AFqh2koclAuXMIdOo3kqgt+G95EY/ApThQKhfEikvWz2onCtyp9uUrKP
        tu7u+9dGH8dzr4GFVhDbfTopjQ+3T4PNoH9kPL+v1Q==
X-Google-Smtp-Source: AMrXdXsQXSEjRXyJwHDDL6MhuMFTJ4G2vBKWsi2XwmtB50ZOdY40wNWBTow7hyW4IHJ2RZBeJUEIrT0kjuyLvMjYSjc=
X-Received: by 2002:a17:906:7754:b0:86f:2cc2:7028 with SMTP id
 o20-20020a170906775400b0086f2cc27028mr3333891ejn.133.1674674171046; Wed, 25
 Jan 2023 11:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20230125015738.912924-1-zokeefe@google.com> <CAHbLzkoF+gbgopWBSP0Xe0+g-DLF_n-NQ_7gvg+0EEGpv8Q7Tw@mail.gmail.com>
In-Reply-To: <CAHbLzkoF+gbgopWBSP0Xe0+g-DLF_n-NQ_7gvg+0EEGpv8Q7Tw@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 25 Jan 2023 11:15:34 -0800
Message-ID: <CAAa6QmRL1H0VEhE0oA87=jyi4hL3v_T+XO7izfCtArnXcBP4DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page refcount
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:06 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Jan 24, 2023 at 5:58 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > During collapse, in a few places we check to see if a given small page
> > has any unaccounted references.  If the refcount on the page doesn't
> > match our expectations, it must be there is an unknown user concurrently
> > interested in the page, and so it's not safe to move the contents
> > elsewhere. However, the unaccounted pins are likely an ephemeral state.
> >
> > In such a situation, make MADV_COLLAPSE set EAGAIN errno, indicating that
> > collapse may succeed on retry.
>
> The page may be DMA pinned (for example, pin_user_pages()), it is not
> worth retrying for such pages. But it may also not be worth optimizing
> for this case at this point.
>
> So the patch looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

Thanks as always, Yang, and good point about DMA pinning. As you
mentioned, I don't know if it's worth considering that too much right
now, as it's unlikely these two uses (MADV_COLLAPSE and DMA pining)
would be used together. We can revisit if necessary later if it's an
issue, but for now, I think it's a win that MADV_COLLAPSE (+ a bounded
userspace retry loop based off erno) is more likely to succeed.
