Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C728570334D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbjEOQf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbjEOQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17C3AB2;
        Mon, 15 May 2023 09:35:24 -0700 (PDT)
Date:   Mon, 15 May 2023 18:35:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684168523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpZYBpEggjix2lXh0EkRGiWcWZ+gWNXWguy09L3ZWFo=;
        b=idprkij9Ji8PZhPMWq6aoSzEH8+2jN/ETtFQT7ACe008pFjEE3aHS4sbSJagxHHgRmRs0L
        46nzfKiXI0/774OYNChfbqckqFdW4PdR16yLIlVkHq+P1c1X4xTwpRw7LQa6OLdc28KkHa
        +Xx84/qpSRh1YxTyPeh8k5Mqgw6cRiiYSuVTBjFada2oA5BfE/M+vsMw4gbs56H1yFWw3G
        CGpuoanXr1CRv6x/vZOrpVdMaBZY8NbDN8T2B7JCNQSv9KBQDsdf/t1GdmvASAq3V9cGur
        lXhej6RXhEzc9j6rDdHa6KUcZII3Ud/Z/RZxpWd9m4tMLr+cBGTCGx33jWzrcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684168523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpZYBpEggjix2lXh0EkRGiWcWZ+gWNXWguy09L3ZWFo=;
        b=BvkDLcSZCdcpH9bLqK0zNiYytt6B2Zni6b4vgZ+kdkgJ7V6xZ+X7YpHnKlHzfumRV4hzNm
        VZy0UcjgFZbLG5Cw==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] scripts/tags.sh: Resolve gtags empty index
 generation
Message-ID: <ZGJfSaIXbTiCzNWv@lx-t490>
References: <20230504201833.202494-1-darwi@linutronix.de>
 <20230509012616.81579-1-darwi@linutronix.de>
 <20230509012616.81579-2-darwi@linutronix.de>
 <CAK7LNARO6HOutPf2VZJMTR2Xmepj_3UiUgH-SLXhH57CNnGfOg@mail.gmail.com>
 <ZGJOht09HwRY7GK+@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGJOht09HwRY7GK+@lx-t490>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Ahmed S. Darwish wrote:
> On Fri, 12 May 2023, Masahiro Yamada wrote:
> >
> > You can write it in one line.
> >
> > dogtags()
> > {
> >     all_target_sources | gtags -i -C "${tree:-.}" -f - "${PWD}"
> > }
> >
>
> Ditto. The script was almost-fully POSIX style (except the first line),
> so I avoided bash features on purpose.
>

Nitpick for correctness sake the "Use default values" parameter
expansion is actually POSIX-ly correct:

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

Thanks,
Ahmed
