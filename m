Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44F8731C26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjFOPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjFOPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60918273D;
        Thu, 15 Jun 2023 08:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F009160C36;
        Thu, 15 Jun 2023 15:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C229C433C0;
        Thu, 15 Jun 2023 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686841554;
        bh=4wkotvA1EgdVqwtRibR0PvE40CcTrbovkSp7EW/Frug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEBoqfVoj7mhPuR6aCuMRHuXIpDWxK66fSBsmnokeudE7zxizcDxAqN3Xj9koXRYg
         NLagRHCPnNHPrNabNg11/nVLVCOKDO6Nf4RTL91Wy8nySr3SK/1X7iRaJJutI23vFC
         sLU44UAMao68eSvpdwrAtbRsyWL5V34FdC9Wnwh0=
Date:   Thu, 15 Jun 2023 17:05:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023061556-hypnoses-quartet-766a@gregkh>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
 <2023061547-staleness-camper-ae8a@gregkh>
 <d5561151-08bb-9f5f-aa51-44c5ad31976b@quicinc.com>
 <2023061512-vowed-panther-38ed@gregkh>
 <551145bb-18f7-45af-b75e-7caccca113bc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551145bb-18f7-45af-b75e-7caccca113bc@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:28:13PM +0530, Prashanth K wrote:
> 
> 
> On 15-06-23 08:06 pm, Greg Kroah-Hartman wrote:
> > On Thu, Jun 15, 2023 at 07:52:32PM +0530, Prashanth K wrote:
> > > 
> > > In that case, can I resubmit v1 of this patch again, where I have used a
> > > macro in usb-conn-gpio driver ? something like this.
> > > 
> > > @@ -27,6 +27,8 @@
> > >   #define USB_CONN_IRQF	\
> > >   	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
> > > 
> > > +#define USB_ROLE_UNKNOWN (USB_ROLE_NONE -1)
> > 
> > Are you referencing an existing enum here and assuming it is a specific
> > value?
> 
> I' not assuming UBS_ROLE_NONE to be a specific value, but I want an integer
> (for macro) which is not equal to USB_ROLE_NONE/DEVICE/HOST, that's why I'm
> using (USB_ROLE_NONE - 1), assuming enumerators NONE, DEVICE & HOST will be
> having adjacent integer values. Wouldn't that help?

You can't do "math" on an enumerated type and expect the result to be
anything constant over time.

And yes, you can hope that enumerated types are sequential, and the spec
says so, but please never rely on that as what happens if someone adds a
new one in the list without you ever noticing it.

Pleasae treat enumerated types as an opaque thing that you never know
the real value of, it's a symbol only.

thanks,

greg k-h
