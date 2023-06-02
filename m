Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DE7207E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjFBQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjFBQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:47:01 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D91B3;
        Fri,  2 Jun 2023 09:47:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f8008cb772so20788301cf.3;
        Fri, 02 Jun 2023 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685724420; x=1688316420;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eoN2DyKs5X+s+DyCZK8A4ivF3BEc52nu/fFwt4W6Js=;
        b=qjGHtXZxoBBdS2HT2JkrKSST/yA4++3X0V+xwfmvFh9WP4br4vOwfY/p02/dOh/Hti
         /d1coxNhXhmoHYQzGJIHccxZqRwqCIPpKsul96SdosuIgxQxByyWX8RWqLk1fVYlKLkw
         uZlLU0Q1KKvaa0Gy0W5plYTHm9Upu2tHq5ovT8rmmRUfcw4mOiMZp9QicqJZIVNo7hhA
         0KBsx/tOCH9SwmmSQMSOPaKlrLXBDoYRAzV3jw8crDS8C9KgKPaAs+AQ4GcQqX97+m0B
         Q+UaZ76XrVuuVQLkp0VYh5OIQxYEtEupMTxHK2atoSEFgywcvAMTB47ukoaYqEApW+MG
         3VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724420; x=1688316420;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eoN2DyKs5X+s+DyCZK8A4ivF3BEc52nu/fFwt4W6Js=;
        b=lGsFds7RLC3O5bjTuafItI0k/JvXmDTwYfaDXwIRJqF4QRbgkZRcD/XrxkLjx3KxUt
         vmcg+2BMnhCiR/wYSj0sS9DJKGwiTcfknIteTKzrpBLvOCWi/j5usksj+ty3WyYNgVmT
         8mVYNBR3RRkjVvd5YDEoXjUDRChvTymGFPpeKETkYfAsnCan+Opx9GwWfCipfRcBX65x
         L2w2NDWYmqh0JmY+bHeESMkJmLHkB12OpFTDrI5HVrkRyEglCXvUBhixCQCaxbUfDxyF
         s1C/vjNuaqVbltG/nvtmVhZOP+o5aM65KtvInhscibmuVLugxxv4r1y0xPMTwfI/DraL
         lp6A==
X-Gm-Message-State: AC+VfDyTm/v1e15LMjSWEFu4f8CXlOj0rsLGUwhEn4Ieq9FzFqfyhxNO
        vLrXEZ5ISprrlYVd8pH4qQ==
X-Google-Smtp-Source: ACHHUZ7EOoJZ6L7R1UJCRQzjWBBZWjNY4vgxY0heC6yYd/8OioyvT8szOiU6EybWHfv5vJbwiyYBEg==
X-Received: by 2002:a05:622a:181b:b0:3e4:e430:94e with SMTP id t27-20020a05622a181b00b003e4e430094emr16704854qtc.64.1685724419595;
        Fri, 02 Jun 2023 09:46:59 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y28-20020ac87c9c000000b003e89e2b3c23sm963638qtv.58.2023.06.02.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:46:58 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:27c2:60bf:3f0f:e3a1])
        by serve.minyard.net (Postfix) with ESMTPSA id B29E41800C3;
        Fri,  2 Jun 2023 16:46:57 +0000 (UTC)
Date:   Fri, 2 Jun 2023 11:46:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZHodALMLTWk72Vvm@mail.minyard.net>
Reply-To: minyard@acm.org
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
 <ZGtlnWGSc31Wdhxa@mail.minyard.net>
 <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:53:31PM +0200, Johan Hovold wrote:
> On Mon, May 22, 2023 at 07:52:45AM -0500, Corey Minyard wrote:
> > On Mon, May 22, 2023 at 01:59:36PM +0200, Johan Hovold wrote:
> 
> > > I just verified that break works on the first port of my cp2105 but not
> > > on the second one (I seem to receive the last characters sent instead).
> > > 
> > > Apparently this is expected as the datasheet (AN571) says the following
> > > about the SET_BREAK command:
> > > 
> > > 	This command is not supported on the second CP2105 interface.
> > > 
> > > Which port are you seeing this behaviour with?
> > 
> > I'm guessing this is it.  From the schematic I think this is the
> > TXD_ECI pin, though I'm not 100% sure.  I'd have to dig through the
> > device tree and SOC manual to be sure which port is which.
> 
> It should be the second SCI interface which do not support break.
> 
> > Would it be possible to return an error in this situation instead of it
> > silently not working?  Just to avoid others having the same issue.
> 
> I just posted a patch series which does that. The USB serial drivers do
> not currently return any errors related to break signalling even though
> this has been possible since 2008.
> 
> The same mechanism can be used to report that break signalling is not
> supported by a device or driver, but the USB serial drivers would be the
> first tty drivers that actually do this. If it turns out to cause any
> trouble we can still use this series to avoid the unnecessary wait.
> 
> Care to give the series a try?
> 
> 	https://lore.kernel.org/lkml/20230602124642.19076-1-johan@kernel.org

I have tested this series.  I can verify that one of the CP2105 ports
(ttyUSB0) does not return an error on sending the break, and the other
(ttyUSB1) does.  This is the only USB serial device on the system.

However, the device hooked to the remote console (ttyUSB0), the one not
returning an error on sending a break, still doesn't send a break.  So
my problem isn't fixed :-(.

# ls -l /dev/serial/by-path
total 0
lrwxrwxrwx 1 root root 13 Jun  2 15:28 pci-0000:00:1d.0-usb-0:1.1:1.0-port0 -> ../../ttyUSB0
lrwxrwxrwx 1 root root 13 Jun  2 15:28 pci-0000:00:1d.0-usb-0:1.1:1.1-port0 -> ../../ttyUSB1

-corey

> 
> Johan
