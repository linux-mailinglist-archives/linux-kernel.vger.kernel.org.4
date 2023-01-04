Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4150B65DDAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjADU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjADU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:26:06 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115210B41;
        Wed,  4 Jan 2023 12:26:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id tz12so85431851ejc.9;
        Wed, 04 Jan 2023 12:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nsiYCj7E7B/biignvWJEgK9zv09wv8jx0ObzuZD7BA=;
        b=fJo+QzADxBj8/jQzpQWRnaynpQlqiQTaU8QRE0zlmtiZtHSDcIvUYgewPOiKgZNZTe
         /yRGQZvqwnny1JWPcL1tclqzX0QV5ufBq8bti84ktBySJJEGiRypr3Kkq4TOyKLp6AXD
         mfMt7OPZ64ktLHIucPvlMzAaH52uZBe0AD7iAWOEY4Iow+ySDaLfa8dHyU36aK37Vc3F
         dTRI+AYLnjue07kLuxOAdUchHCm74+vc9J0xsrL+a4Coml52gdkW3ScywY02wLj7yxtF
         L4dEStUENFQcp9YA/7ExVOXgTkvX80J2DTlQSkAAqAK6G5ZHNL1NlNrXkTonCP1bXbIM
         2eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nsiYCj7E7B/biignvWJEgK9zv09wv8jx0ObzuZD7BA=;
        b=NXC6x0m1Eth6BviJ3yCqXJOI7KF4rZXxSfhYbP72SdoI+GQHg1oAkMhjI/CoG2LXK+
         nGo4Az9FWFtf6RYEbj+LqYjJ3Ox+vrrE3+hRQtvFyTRX7ChHQRjVX9rA8zfDDj1vRTjs
         cOfn8ol64gn5OIfa3Y55Pmqz104ulGBktuwWOifMCuz596Jy2ejQTkgba76QWgjzJTce
         SNI6fEHA8EHcptLlP2Te6BbvJ+o702aY1JxU/Yhv3wBAiakIYgK5/58qaahVlhBHSKG1
         IPllS32LdEPgvoai+wLJQitTCEohaf1eqKDop5/W0KrojoSatxN/hSDK7XXFUy2JSt00
         0Mmw==
X-Gm-Message-State: AFqh2kqhRfExQAiZkfpJwgSc4vfkv+2OZmEQjq/Uz3gMclR1zzB+d7iK
        u/WvoaM0qpF1MDaH4t/aVVQ=
X-Google-Smtp-Source: AMrXdXv39pIwvzSW1JK083DyvEaIimvX/j6XZ5/7LzVNcY31rmnGqXtGzu/G8SSUDyZANJn3v1+kpw==
X-Received: by 2002:a17:907:80ce:b0:7c1:26b9:c556 with SMTP id io14-20020a17090780ce00b007c126b9c556mr44908907ejc.15.1672863963331;
        Wed, 04 Jan 2023 12:26:03 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b007c0f2d051f4sm15462557ejh.203.2023.01.04.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:26:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Jan 2023 21:25:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v14 1/7] x86: lib: Separate instruction decoder MMIO type
 from MMIO trace
Message-ID: <Y7Xg19H39FqTwyEL@gmail.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com>
 <Y7RA3bmko0AjO8hQ@zx2c4.com>
 <Y7RfPnyK/25pxpKs@gmail.com>
 <Y7RmDVI/ScoeBO2a@zn.tnic>
 <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
 <Y7RqQNH0OuiYCDeE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7RqQNH0OuiYCDeE@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > On Tue, Jan 3, 2023 at 6:29 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Tue, Jan 03, 2023 at 06:00:46PM +0100, Ingo Molnar wrote:
> > > > > I guess you missed the conversation with Borislav yesterday about that.
> > > > > He mentioned that I'd just take it through random.git when this whole
> > > > > series goes in.
> > > >
> > > > Please base your tree off on tip:x86/asm then (or pull it in) - it only
> > >
> > > My idea was a lot simpler: avoid the tree inter-dependency by us acking this
> > > patch so that it can go through the random.git tree.
> > 
> > Indeed I would prefer this.
> > 
> > Or... just put this in 6.2 because it's trivial anyway? Heck, even mark 
> > it as stable@ so make future backporting easier. Then it'll meet tip's 
> > urgent criteria.
> 
> Yeah - that's sensible too, it does fix a header namespace bug - I've put 
> it into tip:x86/urgent.

This namespace clash fix is now upstream as of 512dee0c00ad & later kernels.

Thanks,

	Ingo
