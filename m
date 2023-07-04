Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685B74730F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGDNoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDNoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CA10A;
        Tue,  4 Jul 2023 06:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1497611DA;
        Tue,  4 Jul 2023 13:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0110DC433C7;
        Tue,  4 Jul 2023 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688478275;
        bh=H4vf7WM7e//1spLCgBt6uXZ6Gx9o7KTTE0hMPXndmEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpKjFTz5+ezLR2ggcecegf3HfyBY2WjGF7EM0sSQzwufFtUZnPoKpCXODQjvwKte4
         awDpj49KK/Gz2h+p0fZi8E+oIrrQNOUmo7hUb/ftj13p3q1wc74r9RmcgmjV8WN0Jd
         jY1POHgmlbjqIC7aGATIxOl6zZMIGcRehqSQpqMA=
Date:   Tue, 4 Jul 2023 14:44:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, samsagax@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
Message-ID: <2023070402-festive-rind-9274@gregkh>
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
 <20230704131715.44454-6-gregkh@linuxfoundation.org>
 <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 06:39:07AM -0700, Guenter Roeck wrote:
> On 7/4/23 06:17, Greg Kroah-Hartman wrote:
> > Drivers should not have a single static variable for the type of device
> > they are bound to.  While this driver is really going to only have one
> > device at a time in the system, remove the static variable and instead,
> > look up the device type when needed.
> > 
> 
> This is expensive. I think it would be much better to just move
> the board type detection into the init code and not instantiate
> the driver in the fist place if the board type is unknown.

The board type detection is all over the place in the driver, it's not
just for "unknown" types, so how about just saving the board type at
probe time and using it then for all other places?

> We can handle the static variable separately if it really bothers
> you that much.

I did this change to make patch 2/3 more "obvious" what is happening
when the in_visible() callback happens, so that you don't have to worry
about the saved value or not.  But this whole patch isn't really needed
if you don't mind the lookup just happening in the in_visible() callback
for the first time.

thanks,

greg k-h
