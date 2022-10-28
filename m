Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56413610B79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJ1HmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJ1HmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:42:06 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05EFA001
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:42:05 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id p9so2091218vkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ennOQKFOTwsP0hyLNdo0z1k0y6OG1jhsLXFhNIam/zE=;
        b=RMQWpuATlVIwbvb2c5IDualoj7xt9KjdY8SfP6kH7GH6Rp7kM+RSjQktoo5ZRwNoaN
         axAfzAi/ppoWLQp0umuuDbqW9yCjsQNeZM8w9TYJvN5Ii6RV6mpeS/CTkabzbjdUK2li
         4X9IuQetRuS7p0MMH7l6Uy7FSUCubxgHn2Y8bZoGoUVfew3y7Ovs8+kU39ZtyK++w8o3
         pFUMWM5Eh73tpsrFT5p7DWui+9qU3mA/k+7rZgQOgVL2YL65Oe4cPdMSR54rEKCvNx94
         TeZ2RRWBFDZ8y6oPlOlc2Et+dSDVErFGIyNH1X7yqQ1/7eiMMit2dHaUXSAWOgmSOSEM
         3w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ennOQKFOTwsP0hyLNdo0z1k0y6OG1jhsLXFhNIam/zE=;
        b=nb3KuW8SLMQBXRU6Hk9B9pyMGkht2m2/zhYp91PJX4siNf63WXERA7+x+QC9ZvX+C9
         tOsbk1VznibgQqbwda4C62ycbsQMDHBSBP2H05EziRYHYiPY5hgwsNCobfSmfd2svTUv
         7GfvowGQRuUrwEVndhYyvmnHAe7MZTJntspLOUo/y6tRJFk5D8ibq+RR5qq+B7kNJSCS
         c48KiC7vcVGjU6pHR3PY490tQaGfN39/D5UODbnr3+Djua8HjFBjKiYjoodbLur786ML
         Otsmx8Z+RFk0mFBIjhH6NGbOA4H783D1CPIPen801UiLp5L3iDE0w7wbcoS/m9KbshF3
         8c9g==
X-Gm-Message-State: ACrzQf0krztQA1CM2b0dLMUTBmq3Y4uE3cZjywvqGJaYWyxJvV+CtayG
        nkeK53Sx+AE61LjY/t07NQZaPzYxf6EOYcTzeNyoHLG00S8Ms0WNq6U=
X-Google-Smtp-Source: AMsMyM5OGqik8I98x+1T7m1YLDt44URvqhh31TER1G3asikOjsHwkZ5yg4Q1WSqd7twier+Ny5ZP2j+htkuzjLnc/QU=
X-Received: by 2002:ac5:c981:0:b0:3b7:c85d:cfeb with SMTP id
 e1-20020ac5c981000000b003b7c85dcfebmr4176168vkm.30.1666942924249; Fri, 28 Oct
 2022 00:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221024094853.2877441-1-yulei.sh@bytedance.com> <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Fri, 28 Oct 2022 15:41:53 +0800
Message-ID: <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
Subject: RE: [PATCH] usb: gadget: aspeed: fix buffer overflow
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 2:59 PM Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> Thanks for your feedback.
> I tried to reproduce it on my side, and it cannot be reproduce it.
> Here are my test sequences:
> 1. emulate one of the vhub port to usb ethernet through Linux gadget (ncm=
)

We are using rndis instead of ncm.

> 2. connect BMC vhub to Host
> 3. BMC & Host can ping each other (both usb eth dev default mtu is 1500)
> 4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu to 2000, it's =
maxmtu is 1500)

Not sure if it's related, but in my case (USB rndis, Debian 10 OS) it
should be able to set MTU to 2000.

> 5. ping BMC with `s -1500` argument from Host OS
> 6. BMC kernel no oops
>
> I dumped the `req` related members in ast_vhub_epn_handle_ack() to see if=
 whether the received data length exceeds the buffer length.
> In my case `req.length` is 16384 bytes, so it never exceeds it in this ca=
se.
> I'm wondering what's the value of `req.length` in your test scenario? And=
 how can I reproduce it?

The last 3 calls of ast_vhub_epn_handle_ack():

ast_vhub_epn_handle_ack=EF=BC=9Areq->last_desc=3D-1
req.actual=3D1024,req.length=3D1578,ep->ep.maxpacket=3D512
ast_vhub_epn_handle_ack=EF=BC=9Areq->last_desc=3D-1
req.actual=3D1536,req.length=3D1578,ep->ep.maxpacket=3D512
ast_vhub_epn_handle_ack=EF=BC=9Areq->last_desc=3D1
req.actual=3D1634,req.length=3D1578,ep->ep.maxpacket=3D512

We can see the last packet 1634 exceeds the req.legnth 1578, and
that's when the buffer overflow occurs.
