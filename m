Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB5669B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAMPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAMPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:01:12 -0500
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792463D17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=KwQ22b8Nr1nOkVeoMuuOuuiuzvEAnD1GlpwPb7e64as=;
        b=NnbFIHNQsE4SGlyOpADh5QOibw62s4YIpk8BfSxLHZkosThjDfZasg47Xf95DMgstg4iLLH91bCyA
         s0tGTA6wMUOCvS5ytmDUTq15usC/vdlh1CBYHZ7zAZDDQN5qt40GbQalL76aWwVxkhA5Ldl7F93HT1
         sISdwEfCKZu4YhbeMF76SfoCYSofMnYx4j46O4NqXIu+aZN/dWMKx7WgOAFvVhXoG5y1cQwSlCu8nS
         AibyXw8+/MSQNMhds2N9oNgNn6mgSiSv/CS8xGWLoEO3qwQPcm76FklvC2cHQu2wejHu9eoIt1kwS7
         HubLJxSep0UrRwLYmuStCShFOnvm/3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=KwQ22b8Nr1nOkVeoMuuOuuiuzvEAnD1GlpwPb7e64as=;
        b=jXTnJnPbpPvp28lUNFIDX6bN9rE1EJYDsoziEwow3qmbI5T60a0vGRZAw8SefUhP005zyh4s8JP9S
         MqfcaBdCw==
X-HalOne-ID: dac2612b-9351-11ed-80f4-93f0a866dfbb
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id dac2612b-9351-11ed-80f4-93f0a866dfbb;
        Fri, 13 Jan 2023 14:52:11 +0000 (UTC)
Date:   Fri, 13 Jan 2023 15:52:09 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed
 during disable
Message-ID: <Y8FwGTWeYtX0j8MX@ravnborg.org>
References: <20230106030108.2542081-1-swboyd@chromium.org>
 <Y7nV+aeFiq5aD0xU@ravnborg.org>
 <CAE-0n50QOv_+j1Pe19xKj4Cx2Y5_Ak5Kt68UBJuZt10D-jQ44g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50QOv_+j1Pe19xKj4Cx2Y5_Ak5Kt68UBJuZt10D-jQ44g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
On Tue, Jan 10, 2023 at 11:29:41AM -0800, Stephen Boyd wrote:
> Quoting Sam Ravnborg (2023-01-07 12:28:41)
> 
> >
> > For this case we could ask ourself if the display needs to enter sleep
> > mode right before we disable the regulator. But if the regulator is
> > fixed, so the disable has no effect, this seems OK.
> 
> What do you mean by fixed?
What I tried to say here is if we have a fixed regulator - or in others
words a supply voltage we cannot turn off, then entering sleep mode is
important to reduce power consumption.
But any sane design where power consumption is a concern will have the
possibility to turn off the power anyway.

> 
> >
> > Please fix the unprepare to not jump out early, on top of or together
> > with the other fix.
> 
> After this patch the unprepare only bails out early if the bool
> 'prepared' flag isn't set.
OK, then everything is fine.

	Sam
