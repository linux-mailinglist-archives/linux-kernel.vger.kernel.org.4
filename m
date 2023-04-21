Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FD6EB063
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjDURQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjDURP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:15:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4FF0;
        Fri, 21 Apr 2023 10:15:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso1946092e87.3;
        Fri, 21 Apr 2023 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682097355; x=1684689355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19W3G3W6cWz8Mtt5/t2079hKyw4xMXf5e8wPFhIjWhc=;
        b=bYXZd2Ght5UbrrL3pHg/rnjL4qFVMJo8Kj9VJsMEYFM0rcqY5y5jmsYhWJbgnEoWCv
         zfw6J6xZisgZk/yKuLtJzP80nnqoFYapU0LgL+GvTFlstGZjzDDSQ7vQWhes4UkWW0qP
         3gqptwpgLDXnnhARgIBs3VzdH6nGDtUZatJPqvfHhJUdLEJq2LpCDGMWUDu1hMn2A1og
         rnoLm4o2DhR5TTP+IWbFqBtau+VVGXxE4ocXPBQ2rcY94t9gDSs2M1O/sarnRhagtwdt
         A3FSme5ttcNU6GVnAVWCxrLLiCQ9BPEH0/fY0seFYfKxXCqBOpgPtzu1Hfu9WtSg3GcG
         nS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097355; x=1684689355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19W3G3W6cWz8Mtt5/t2079hKyw4xMXf5e8wPFhIjWhc=;
        b=GBwaKW5sNmiRV66fJb5Ir7vOUnyPbLpyYGqKgaBO/zCb3fTSUcwMXEF2GPzv7PwqNw
         FOM346znS+g5sQPtvwhYlvmPP/2nZYmYDTla+rfnNl2MGl4cNh8d5yajoxxbmvCshU3v
         jacLAmnvF7sDXVGBvc6WI3udzAAnY1KxjSCKS7MjytDBy3rxj+8hFilp8ZFqrZ+7/fKG
         TAcp0ook+QMqwgT6woJX5YT5ypUvCkLnTxz9i52It+fpqXCgvpN541CtpauIuf3StBQQ
         lNv2XD/rb9lCmbeSU77RL3YFq/lubktao3RiK+q8Rj1pmzkrYYAeDHqjse0Fz+CMFQJG
         Pm3Q==
X-Gm-Message-State: AAQBX9cqaz+JTpoC7fSBAGe8QePfPC5uAMdW5bh40p+6YAB+pWcwlEDu
        51Z4u/oaGWcke+ges0mxhj8=
X-Google-Smtp-Source: AKy350a3To+SLDun2WAQLm83TlFNcG/hziHEYIX0LLlSy2XZMz7gvV+IJ9cSL9P+zQXY3pbeQv12ag==
X-Received: by 2002:ac2:4c08:0:b0:4ed:d2be:37e5 with SMTP id t8-20020ac24c08000000b004edd2be37e5mr1781340lfq.7.1682097354741;
        Fri, 21 Apr 2023 10:15:54 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id c15-20020ac244af000000b004d5a6dcb94fsm620295lfm.33.2023.04.21.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:15:54 -0700 (PDT)
Date:   Fri, 21 Apr 2023 20:15:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "rohitner@google.com" <rohitner@google.com>
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
Message-ID: <20230421171552.qvunrlxxpqusd5h3@mobilestation>
References: <20230420055131.2048959-1-joychakr@google.com>
 <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation>
 <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
 <969a083998224016947f5e77218f4587@AcuMS.aculab.com>
 <20230421164838.52euobr5ohfyxxti@mobilestation>
 <CAOSNQF14TcJCU3BBvkL7PuokNXAczTyU=0mOisujBCYNNc2rZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF14TcJCU3BBvkL7PuokNXAczTyU=0mOisujBCYNNc2rZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:40:44PM +0530, Joy Chakraborty wrote:
> On Fri, Apr 21, 2023 at 10:18 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Fri, Apr 21, 2023 at 04:39:30PM +0000, David Laight wrote:
> > > From: Joy Chakraborty
> > > > Sent: 21 April 2023 10:22
> > > ...
> > > > Sure, I can make the following change in the formatting and send the
> > > > patch series:
> > > >          dws->n_bytes =
> > > >                  roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
> > > >                                                  BITS_PER_BYTE));
> > >
> >
> > > Won't checkpatch bleat about that?
> >
> > Why would it?
> 
> I ran checkpatch on this and it seems to be fine with minor spacing changes.

What spacing do you mean? No problem with the change as is:
[fancer@mobilestation] kernel $ git show HEAD | grep -A1 -B2 roundup_pow_of_two
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes =
+		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
+						BITS_PER_BYTE));
[fancer@mobilestation] kernel $ ./scripts/checkpatch.pl --git HEAD
total: 0 errors, 0 warnings, 10 lines checked

Commit e18b699257db ("spi: dw: Round of n_bytes to power of 2") has no obvious style problems and is ready for submission.

-Serge(y)

> 
> >
> > >
> > > Is it ever actually valid for the caller to provide a
> > > value that isn't 8, 16 or 32 ?
> >
> > Judging by this
> > https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/spi/spi.c#L3630
> > it is. SPI-controller also supports word lengths within the
> > pre-synthesized range. So it's up to the SPI-peripherals and their
> > protocols what word length to select.
> >
> > -Serge(y)
> >
> > >
> > > I'm sure it looked as though some other lengths/counts
> > > where likely to go badly wrong.
> > >
> > > I know there are times when it is useful to bit-bang 'odd'
> > > numbers of bits - like command+address+delay for fast reads
> > > but that is a sub-32bit transfer so (at least somewhere)
> > > is 1 word but not all the bits.
> > >
> > >       David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
