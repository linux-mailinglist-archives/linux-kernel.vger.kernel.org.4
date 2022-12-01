Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9883E63E801
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLACnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLACnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:43:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BAF95800
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:43:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x2so639302edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMuFoLwq6if5lfsejZqkU+pkwkmJVnwkSd6yWbaeyOY=;
        b=QFoku3nZm3W8q3prt+EhbRpDYHxv4fc7ergeIIGsDpA+3Us5h/oncs8WpRUeKomnd0
         pO6VNkJd8slm/hEijPmdOIuqWZNazLV9gkrAwJ1ulptle/tSyJChy6osS7TPbu5fukMY
         8kQiONr6xYZWU2QR+Yasaf4UX7q0xgko6Kik9x5HBtqiwl9xH4yHYqWQckGrt/xAm5xP
         Seg86FyFzAHMbABPIJQmygBFBUrIXUxUYSTx3RtmiwEQteE3JQflis3tLloUhcBkaPQp
         8mCSNbyfIy1D0e6hSbnKmBBcgRYeQhCO/Nc3Ru18Zt6EsiLncfRYlb5jF1iqjkJ0HfaY
         /hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMuFoLwq6if5lfsejZqkU+pkwkmJVnwkSd6yWbaeyOY=;
        b=m7vNRY99wBe1i2CMJN3zBQ3ujbHUdq1Vy+Zo9si3ttOzvIx81nVb6WBXP+zQ9kuxi8
         00LPqgg+n28HMTQa2VUVDCAapK8JLO5Ej+L47bZmJUO+q4ylFVn4ut4Sj9Sb55FH1GyZ
         SejKTiLw6J9yHamRje+RpRmBie9+/ab5Fdt/2rLX8zn9WV/8B3RJ7khywVa9LeF2Qavd
         mBpyxnIT71JXk6sE9s9y+d4mcqPfT8kP08HCE9KmWO5aBEYnWWBB8ykY1Tt549g1nIHt
         XA0L7AuBypiVfAa45fwXgi+zjTnr/lewveQbokOgAqk6hXsIOp+JFqceJmcL951INbsB
         crmg==
X-Gm-Message-State: ANoB5pnDBywfEGKX8oshaydCI0MHrJkOSPHTRkBPWCdm9puxm7LrMzDA
        YQfbWGybjSfc6Key01abUj+OPg==
X-Google-Smtp-Source: AA0mqf6v2PExAoNMrIKI4AK1MjDKAsaOkEr1IGWcxKgj9FPBNjIQkw8GS+pomOGeXWinf7x9/1e4hw==
X-Received: by 2002:a05:6402:206b:b0:46a:d5ed:e066 with SMTP id bd11-20020a056402206b00b0046ad5ede066mr24110003edb.335.1669862619507;
        Wed, 30 Nov 2022 18:43:39 -0800 (PST)
Received: from andrea (host-79-26-70-104.retail.telecomitalia.it. [79.26.70.104])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402040300b004616b006871sm1210741edv.82.2022.11.30.18.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 18:43:38 -0800 (PST)
Date:   Thu, 1 Dec 2022 03:43:32 +0100
From:   Andrea Parri <andrea@rivosinc.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, guoren@kernel.org,
        jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: fix race when vmap stack overflow
Message-ID: <Y4gSJnVh1/lUSnWo@andrea>
References: <mhng-72408cf8-cbde-489b-9042-379b5aa8624f@palmer-ri-x1c9>
 <F84A2656-5938-45F7-A097-58CE348B7119@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F84A2656-5938-45F7-A097-58CE348B7119@jrtc27.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> @@ -23,6 +23,7 @@
> >>> #define REG_L          __REG_SEL(ld, lw)
> >>> #define REG_S          __REG_SEL(sd, sw)
> >>> #define REG_SC         __REG_SEL(sc.d, sc.w)
> >>> +#define REG_AMOSWAP_AQ __REG_SEL(amoswap.d.aq, amoswap.w.aq)
> >> Below is the reason why I use the relax version here:
> >> https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com/T/#u
> > 
> > Sorry, I hadn't seen that one.  Adding Andrea.  IMO the acquire/release pair is necessary here, with just relaxed the stack stores inside the lock could show up on the next hart trying to use the stack.
> 
> I think what you really want is a *consume* barrier, and since you have
> the data dependency between the amoswap and the memory accesses (and
> this isn’t Alpha) you’re technically fine without the acquire, since
> you’re writing assembly and have the data dependency as syntactic.
> Though you may still want (need?) the acquire so loads/stores unrelated
> to the stack pointer that happen later in program order get ordered
> after the load of the new stack pointer in case there could be weird
> issues *there*.

Agreed.

Just the fact that this is the 4th iteration of this discussion strongly
suggests to stick to the acquire and these inline comments to me.  ;)

  Andrea
