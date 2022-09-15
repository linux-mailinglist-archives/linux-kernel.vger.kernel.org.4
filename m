Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E65BA040
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIORKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIORKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:10:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261F2870E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:10:20 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 130so28664840ybz.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=st13mJuSkkLLd32MNsEtbcrb0dlPB41H5qgInX0H9Ck=;
        b=TommpFC5Soi7b4uD9M2oEetvhtEt+UCAbLRoLIjRsaP2Nk0+sxzCakEkeI2zA288hU
         ZbcEulYLvrnyC40LHVDTO4u1EnUeKb+rLrSfxgPH3SD1SMt7fvAKgsg0HqHVEjhb452E
         gDer54IMky5E3tq2Li9f3yYWxfUpwjIuxXmlcTXlXWee6lRJqb9KNrP6jiLHp9FI52mV
         Z1ip3i6oIUf3deCPl+yGQ3eTGetJS9lnbGu5HbkjfxdROykmEOnBaK+gcIPyAepGexoz
         MYogNTNa4gPfLl9nC3A3IrnKqeGECCGDmJCjJbHyIQgogxBvy0OY0gxYZ6mWFQ0nyMIq
         UI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=st13mJuSkkLLd32MNsEtbcrb0dlPB41H5qgInX0H9Ck=;
        b=zB1btx3G5gpcmIhwS2tqimbSPRC4DH1po12diRRr3G5yJUSskX/GIYwYJN50HZfr66
         VhKRXhac3p+vAR6jh3rYREYEPqeIXkXHsn1vBcRdWrRC/SF6h9olymttp0t9ytiQ7uUW
         u4NZn2UIFpQ2IA4I4UP1i+FZTBmIILwV+fSCdyYw8X0udoU63Zjd2313O46qtt6h1lzB
         wdXH7UvzrslKdjhuT4BOIrqhUKM4ADFw2Z31EFXkrMDtcjxa1yhFOxxxAl1ZEtpl+3Hj
         VOt5IRBQOQWvVGC/omN/mJ7CyRdE62EurjAVsC+2GKQVAB+fxmX6wkwl8CFyb+7/g8eo
         5xGw==
X-Gm-Message-State: ACrzQf00uoThSEP581yDML8sCuqqcfGh5EV7nFaEG+ocnmdxI7ahwTx5
        2VcckGBRCiGl64zmv+vU7LBl1DCC9fpbqUtl0A8=
X-Google-Smtp-Source: AMsMyM4SyrR/dl+FfeqUh2DlhFJJOL729BgaayleZBYbjxMRoKK3sCDHyc3lgP/i1Q0NBNxwyHopC4FF3A45umC7sbw=
X-Received: by 2002:a25:dfd6:0:b0:6af:fa4d:33f5 with SMTP id
 w205-20020a25dfd6000000b006affa4d33f5mr686627ybg.253.1663261819306; Thu, 15
 Sep 2022 10:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220914080016.67951-1-namcaov@gmail.com> <1a1d346e-be81-19a5-5cb7-8b5ac896d835@gmail.com>
In-Reply-To: <1a1d346e-be81-19a5-5cb7-8b5ac896d835@gmail.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Thu, 15 Sep 2022 19:10:08 +0200
Message-ID: <CA+sZ8B__mUdYxCBqzD4TGAKKcaa1FtLsrJCQD=b9aYBKJhZUTA@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: replace spin_lock_irqsave with spin_lock
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
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

On Wed, Sep 14, 2022 at 8:55 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/14/22 10:00, Nam Cao wrote:
> > In vt6655 driver, there is a single interrupt handler: vnt_interrupt(),
> > and it does not take the spinlock. The interrupt handler only schedules
> > a workqueue, and the spinlock is taken in this workqueue. Thus, there is
> > no need to use spin_lock_irqsave, as the spinlock is never taken by an
> > interrupt. Replace spin_lock_irqsave (and spin_unlock_irqsave) with
> > spin_lock (and spin_unlock).
> >
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
>
> Hi Nam,
>
> I am lol ... my computer freezed (you don mind if I do not try this
> patch again? Please send a v2) ;-)
> I was digging for the log see below. (kern.log)
> I hope you can do something with it.

Thank you so much for testing the patch and providing the log. I think my patch
introduces deadlock, which caused your computer to freeze. My bad, sorry about
that. I may send v2 in the future, when I fully understand what is going on.

Best regards,
Nam
