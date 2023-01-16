Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A339366CD00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjAPRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjAPRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:31:45 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFABB442E2;
        Mon, 16 Jan 2023 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CN5uEZxXBCYPT2Yo5HjKTJcUlbPD7LwQL3H+jpdCImQ=; b=ZNOkrhum/ZspnKIDYRAcxe9lFU
        lwa97xUJWJPckA3V3LNIUsCjXwS7Mvk/qj8za04D4cdH3EfFBTzM7AO8bbsuYZuNYBzm074hSJTFw
        iCORVq0Wp/vAt3vcEu1x+FxWHZeVg8Wj5UKcl811NtM14OZ71UnTb2Qmypn0IamCV0kOexPaokDGX
        h6wPcmO7TiqjguHuIo02cuRp7lY4X3u8lLut71JlXY1e4iwKT4kPmdkNoOnvzHOaU7SJUAr0LlBqv
        20HdDuk6EivWErPwWPV1PSbsjlzjxxv3UqG32nH7/vwXiLGcCHE40YmNhBp3SGpWuFeCAz58cGN/8
        haTITfYw==;
Received: from p200300ccff0748001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff07:4800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pHSxy-0003Jz-99; Mon, 16 Jan 2023 18:08:14 +0100
Date:   Mon, 16 Jan 2023 18:08:13 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        brgl@bgdev.pl, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: use dynamic allocation of base
Message-ID: <20230116180813.08cb1fb0@aktux>
In-Reply-To: <CACRpkdauDEys-XyYvb=jt1U6FcKc-qiie-A3W0WQ08rnm42DwQ@mail.gmail.com>
References: <20230113205922.2312951-1-andreas@kemnade.info>
        <CACRpkdauDEys-XyYvb=jt1U6FcKc-qiie-A3W0WQ08rnm42DwQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Jan 2023 15:24:42 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> > maybe CC stable? not sure about good fixes tag.  
> 
> I wouldn't do that from the outset. If there are no problems
> for a few kernel releases we can think about doing that.

I have the impression that numbering somehow changed here.
In earlier kernel, omap_gpmc started at >400 and gpio-twl4030 also
(both base = -1 now), so no conflicts with the static allocation of
the soc-gpios.  I have not investigated/bisected yet. But perhaps
additionally, a patch ensuring that dynamic allocation starts at
a higher number to not interfer with static numbering with be interesting.

That could then be more easily backportable.

Regards,
Andreas 
