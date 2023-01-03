Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CB65C555
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbjACRrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjACRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:47:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2956455;
        Tue,  3 Jan 2023 09:47:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fc4so75718925ejc.12;
        Tue, 03 Jan 2023 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7cyotX0l7ebhA4GIXOl1W2CMlFAspZ6Tf1buLbR5Nw=;
        b=iu960tRompiJyFTJnEjBi11ZS+9d8i6l02Zfuya9QRR8fqgx5gmgJyEeRmp/naqHrV
         RBN9Sav3ZMUUYu3T9rHQrg2bpeRXsi3Uc/wWc0MYB7BZCLptyqc1rOYs7F757gICKEBE
         Pox0q6WWxbNtjQ4tQwP5ymahr6+GNAZ7P4e1zKCE1ojoGoLHoKC9CZS37Bai0Dwyd6C2
         7fr8j6/IOU6VyTTHDPJrPGBBtb7ikxjmgd3IWoPofp6rIJ7/j66xA1moZx0G6B8UlbDV
         fjfFCK5JLX/FQg7F2G35yZQatml97b9Or2BOgOaSfmXMW4G94bkY3rgf4cfxRyL8FAYG
         HHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7cyotX0l7ebhA4GIXOl1W2CMlFAspZ6Tf1buLbR5Nw=;
        b=brsnKIAziDgh5Z9yai8qXy6VrsrdpRNgMjnvi+A/ORMhbIk3FWDyxqSvH2O6aP68Di
         MbPh8JM3cs8m2ydIFAITf4RnvDuDupc7dIRFcW/4JHCSjBIgZKLbtmZ3zWMSjb+F9PPs
         eh9hdF817s2N8PmleDrQwCwiIZeGETvukeUcIVzmNMGcty3JBVbiwq7Oo8mkF0TWKkFO
         TrFic2Ou2/qzBGGAQaBr0Jhr5+qEHpnzVvWpu4y4umYN8k9HYrKtsANMG2d/gp7dIYqc
         KSNOEJTaPgU4ui8xNUMQ8/RreU/8Njz5IzvT55G5pdS5FFvNyYNawKq3Gz875ID0pz7f
         QJxw==
X-Gm-Message-State: AFqh2kpS4EaiOOuCku2on/ZVRlsYOfH+2fwxELEOmmGzDmNBnkkBXtYj
        RitxZGDyYhLd3HEWbHk5w9Y=
X-Google-Smtp-Source: AMrXdXtEgaqK+gulQ7OcVitdluoQBbDA+fdlh+FFGqJNxGkLF4DjAh8aeRkqM3BM6+nwYfYaYrBRsw==
X-Received: by 2002:a17:906:82c3:b0:7c1:9041:8c5 with SMTP id a3-20020a17090682c300b007c1904108c5mr52710406ejy.41.1672768067457;
        Tue, 03 Jan 2023 09:47:47 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id kx20-20020a170907775400b0078d3f96d293sm14352978ejc.30.2023.01.03.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:47:46 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Jan 2023 18:47:44 +0100
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
Message-ID: <Y7RqQNH0OuiYCDeE@gmail.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com>
 <Y7RA3bmko0AjO8hQ@zx2c4.com>
 <Y7RfPnyK/25pxpKs@gmail.com>
 <Y7RmDVI/ScoeBO2a@zn.tnic>
 <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> On Tue, Jan 3, 2023 at 6:29 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Jan 03, 2023 at 06:00:46PM +0100, Ingo Molnar wrote:
> > > > I guess you missed the conversation with Borislav yesterday about that.
> > > > He mentioned that I'd just take it through random.git when this whole
> > > > series goes in.
> > >
> > > Please base your tree off on tip:x86/asm then (or pull it in) - it only
> >
> > My idea was a lot simpler: avoid the tree inter-dependency by us acking this
> > patch so that it can go through the random.git tree.
> 
> Indeed I would prefer this.
> 
> Or... just put this in 6.2 because it's trivial anyway? Heck, even mark 
> it as stable@ so make future backporting easier. Then it'll meet tip's 
> urgent criteria.

Yeah - that's sensible too, it does fix a header namespace bug - I've put 
it into tip:x86/urgent.

Thanks,

	Ingo
