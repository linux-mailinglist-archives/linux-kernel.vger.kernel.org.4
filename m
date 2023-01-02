Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7265B4F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbjABQPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjABQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:15:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14361FE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:15:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 572D661022
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 16:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95999C433F0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 16:15:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E1duccYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672676105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8OsgB6sF+YBHghSaIglnCuwKWStFMdBBwWbUet732Y=;
        b=E1duccYir85sL8gcOSr//g4uzwbI3/kBfMlaXA4CeQg1GAO+MhX1lY3fRuM1jfzpnXDUCx
        u3OERWK97fgvdveZdWqHEiL6D3nNzMc+TwNOLKBi+zawAhUBqeiksknsvO6YZDImbwOVgg
        EodByDp3JlRkxSvScMqvHm4JFP0nFAk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 39aeafe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 2 Jan 2023 16:15:05 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-4a2f8ad29d5so63115767b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:15:04 -0800 (PST)
X-Gm-Message-State: AFqh2kqyH7sLe3g7YYF57KDd1j8vzuoQxKgomMmvyjWUuJMr3jfg0tYf
        KOhdXEZQQWFMfLqThJq0POeEYL0bWqWoEBeW+4I=
X-Google-Smtp-Source: AMrXdXsglstfC95r3fpYAaEHUUGDq67reaILKz5VjN0bDJBFwd+RJFYrm3vTlbtvKviLO9JsIuPUxiMQV51Z/xgY+kc=
X-Received: by 2002:a0d:f344:0:b0:3dd:bcc2:e359 with SMTP id
 c65-20020a0df344000000b003ddbcc2e359mr4358996ywf.341.1672676103499; Mon, 02
 Jan 2023 08:15:03 -0800 (PST)
MIME-Version: 1.0
References: <Y5oy0vwZQAwzkDkr@zx2c4.com> <20221214203454.337299-1-Jason@zx2c4.com>
 <20221214213015.GA16072@ranerica-svr.sc.intel.com> <Y5zRTqDmjeJzjeFf@zx2c4.com>
 <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com>
 <Y7L4n0imic1ncHhe@zn.tnic> <CAHmME9rMTNQ+hZPG1cbpP2zA6Cq3-f=gXXPF3=WYhQWicEYV4w@mail.gmail.com>
 <Y7MCgS9Ix7qcLdct@zn.tnic>
In-Reply-To: <Y7MCgS9Ix7qcLdct@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 2 Jan 2023 17:14:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9qPViOzDPUx36Xm9UBMR_mP4_NUDS1QSm0kqw8EaQiQyg@mail.gmail.com>
Message-ID: <CAHmME9qPViOzDPUx36Xm9UBMR_mP4_NUDS1QSm0kqw8EaQiQyg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Mon, Jan 2, 2023 at 5:12 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 02, 2023 at 04:59:08PM +0100, Jason A. Donenfeld wrote:
> > Rest of series is intended to go through random.git tree, so it'd be
> > useful to not have to carry this there -- less pain.
>
> Ping me when the time has come and I'll ack it so that it can go through the
> random.git tree too. Provided there are no serious conflicts but we'll cross
> that bridge when we get to it...

Alright, we'll do that then.

tglx has been reviewing these -- though he's been busy as of late --
but if you're curious, here's the series:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/?h=vdso
https://lore.kernel.org/lkml/20230101162910.710293-1-Jason@zx2c4.com/
I wouldn't mind some feedback or acks on any subset of those.


Jason
