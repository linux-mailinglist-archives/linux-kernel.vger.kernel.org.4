Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAB6C095A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCTDfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTDfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:35:31 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDC22104;
        Sun, 19 Mar 2023 20:35:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h2so1659368iow.0;
        Sun, 19 Mar 2023 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679283319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wmh00mSkc1yZ2kAYcG5WXSz9CKFnfDRzRtU77CPNAeQ=;
        b=Sk1UO0BqWbVIcFRSdIKFLrdgojmDr9n8S/t7QQnrDxW60QXNx502h+HUyE5wCjyQYw
         ns8iHl+9x6RMc5cjnuaNTaSCUFR2p8PhGP3ww+USCuZXwnAzAxLwBxA1vY752BU+wTcv
         b3Wp5bDsu/nkqDLcagS5kORn1ATxDCbvVMjdT4MRgum431NMuMjB5yNiFA/UcAx4vvqj
         RHmRGuFby0812mCsaZ4Vyiv+ertgCSy7mnh27I6eDEgUI6XX0Tqx2HqDMz6E5k1z/Ca4
         6zLBsxp7lAD/h3CyIYvRevjP53ibxjv5DU8DVdgGEHGnh5cBC8sncBAluLABS63a+3Un
         bfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmh00mSkc1yZ2kAYcG5WXSz9CKFnfDRzRtU77CPNAeQ=;
        b=y7ZRxil4sFD/jkWyABvQNLH7p3cULACjyPo38VlYP+V3p9W+p+aQaxsf9DF8F4Vx4N
         MnygzooRbvUur/hmIIyPW2N//fJMnlCS3XClIc0qI0xBvihncnnlxu3u37UE5gwC7mcV
         FmIxe8T3WhsUm/JJHqAiGgZzOxLWewnOaz2bVy1iTH2X6zs/F1ay1/OOzPPJbMq9ZMV1
         xWrijv4AnYz5fbhrFSDMbUiYktGlTJY2N1tu993KYrGo9Ro+ckb5W3pM0KQ3MgoXlis3
         pg2mUiUZ8qOpyL2+Ynkbk0M4rkES5QEcAOnuSk/6uMQNvbq44vR/IYs33woL30bW3HJe
         SQuQ==
X-Gm-Message-State: AO0yUKXinwP7wDNKCTO8TyCw0BcgWu9mXqc/T5KZPQtbuj3GonTpBm7x
        htjYgqQvHWkid36aQwE5QxM2RfU6qpI=
X-Google-Smtp-Source: AK7set+BlDQo6auxxwphnPD+V6cZdPYewGRVL2C66NdtY01WQjeyEQFDE6hol0q6e9oU818n1R/k+g==
X-Received: by 2002:a6b:dd19:0:b0:753:ee63:3dc with SMTP id f25-20020a6bdd19000000b00753ee6303dcmr4487405ioc.20.1679283319602;
        Sun, 19 Mar 2023 20:35:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a056638214900b004063cfecdb8sm2690378jaj.113.2023.03.19.20.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 20:35:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 19 Mar 2023 20:35:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        heiko@sntech.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        huangtao@rock-chips.com, william.wu@rock-chips.com,
        jianwei.zheng@rock-chips.com, yubing.zhang@rock-chips.com,
        wmc@rock-chips.com
Subject: Re: [PATCH 4/4] usb: typec: tcpm: fix source caps may lost after
 soft reset
Message-ID: <7038030f-1d7a-4c91-a255-bec73847b7c9@roeck-us.net>
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-5-frank.wang@rock-chips.com>
 <f5650fa4-db16-b1e4-f5b4-917fbcabb415@roeck-us.net>
 <867179bc-a21f-5479-f27f-2e17fc5a9a01@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <867179bc-a21f-5479-f27f-2e17fc5a9a01@rock-chips.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:38:35AM +0800, Frank Wang wrote:
> Hi Guenter,
> 
> On 2023/3/17 20:58, Guenter Roeck wrote:
> > On 3/12/23 19:58, Frank Wang wrote:
> > > Invoke set_pd_rx() may flush the RX FIFO of PD controller, so do
> > > set_pd_rx() before sending Soft Reset in case Source caps may be flushed
> > > at debounce time between SOFT_RESET_SEND and SNK_WAIT_CAPABILITIES
> > > state.
> > > 
> > 
> > Isn't that a problem of the fusb302 driver that it flushes its buffers
> > unconditionally when its set_pd_rx() callback is called ?
> > 
> > Guenter
> > 
> 
> The story goes like this,  the fusb302 notified SOFT_RESET completion to
> TCPM and began to receive the Source Caps automatically,
> TCPM got completion from fusb302 and changed state to SNK_WAIT_CAPABILITIES
> and invoked set_pd_rx() callback. However, the
> fusb302 or TCPM's worker may be not scheduled in time, set_pd_rx() would be
> performed after the Source Caps packets had received
> into fusb302's FIFO, even after the GoodCRC (Source Caps) had be replied.
> 

Yes, but the fusb302 driver clears its fifo in the set_pd_rx() callback.
I see that as a problem in the fusb302 driver( it could clear its fifo when
it notifies the TCPM that soft reset is complete, for example), and I am
hesitant to work around that problem in the tcpm code.

Guenter

> So make forward set_pd_rx() process before PD_CTRL_SOFT_RESET sent at
> SOFT_RESET_SEND state can cleanup the context in our side
> and ensure the right PD commucation. I am not sure whether it is sensible?
> 
> BR.
> Frank
> 
> > > Without this patch, in PD charger stress test, the FUSB302 driver may
> > > occur the following exceptions in power negotiation stage.
> > > 
> > > [ ...]
> > > [ 4.512252] fusb302_irq_intn
> > > [ 4.512260] AMS SOFT_RESET_AMS finished
> > > [ 4.512269] state change SOFT_RESET_SEND ->SNK_WAIT_CAPABILITIES
> > > [rev3 NONE_AMS]
> > > [ 4.514511] pd := on
> > > [ 4.514516] pending state change SNK_WAIT_CAPABILITIES
> > > ->HARD_RESET_SEND @ 310 ms [rev3 NONE_AMS]
> > > [ 4.515428] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> > > [ 4.515431] IRQ: BC_LVL, handler pending
> > > [ 4.515435] IRQ: PD sent good CRC
> > > [ 4.516434] PD message header: 0
> > > [ 4.516437] PD message len: 0
> > > [ 4.516444] PD RX, header: 0x0 [1]
> > > 
> > > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > > ---
> > >   drivers/usb/typec/tcpm/tcpm.c | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c
> > > b/drivers/usb/typec/tcpm/tcpm.c
> > > index 9e583060e64fc..ba6bf71838eed 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -4321,10 +4321,12 @@ static void run_state_machine(struct
> > > tcpm_port *port)
> > >           tcpm_set_state(port, unattached_state(port), 0);
> > >           break;
> > >       case SNK_WAIT_CAPABILITIES:
> > > -        ret = port->tcpc->set_pd_rx(port->tcpc, true);
> > > -        if (ret < 0) {
> > > -            tcpm_set_state(port, SNK_READY, 0);
> > > -            break;
> > > +        if (port->prev_state != SOFT_RESET_SEND) {
> > > +            ret = port->tcpc->set_pd_rx(port->tcpc, true);
> > > +            if (ret < 0) {
> > > +                tcpm_set_state(port, SNK_READY, 0);
> > > +                break;
> > > +            }
> > >           }
> > >           /*
> > >            * If VBUS has never been low, and we time out waiting
> > > @@ -4603,6 +4605,7 @@ static void run_state_machine(struct tcpm_port
> > > *port)
> > >       case SOFT_RESET_SEND:
> > >           port->message_id = 0;
> > >           port->rx_msgid = -1;
> > > +        port->tcpc->set_pd_rx(port->tcpc, true);
> > >           if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
> > >               tcpm_set_state_cond(port, hard_reset_state(port), 0);
> > >           else
> > 
