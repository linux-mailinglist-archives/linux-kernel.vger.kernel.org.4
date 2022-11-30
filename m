Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381E63DF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiK3SsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiK3SsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D8899F0F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669834030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYspDGFmdTOZmLvPy00urGApPjCU59KLp/BmLc8k3eY=;
        b=Bty/GR474OZoEq9MX7zBvPDrYkuV5Zw9CCd+2nKVs8UqVfzs86Xhsw/DKAbN9bgI+0fuHI
        cBMPzZinGqoUyBTStluilSqDQX07tSAM2OdQ4GORhN3y6DDv68boqHJ7rT6S75NPwux27h
        292ypHbXw9HAbrUI1fZsNzGdIouHNZo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-ns7TwGRENhWhUW2emL5oMA-1; Wed, 30 Nov 2022 13:47:08 -0500
X-MC-Unique: ns7TwGRENhWhUW2emL5oMA-1
Received: by mail-qk1-f198.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso41140001qkb.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYspDGFmdTOZmLvPy00urGApPjCU59KLp/BmLc8k3eY=;
        b=iEjDDNnQ1i4B4vcuH6UIT4Hf+sCxJqxUna9bfg3fu+d5zk1nTmwJ4KO9ZsWAD8Vhn/
         OKqYTtSXlXy16qc6PCNaa6Iywy+2PHrtkcI2yKe77Gzzc4kx9hRi1xkFsm9b8dNSLb4O
         /DcqfNrWAkUaDIN2by27O4mAcSnYNo810coCF/WCUfnO30gjnMrpmr0G+0Ce1NnFnYi5
         EmzanJUMqk3SxB5SkjfBTbkP9mr2kJlySPZRj3lXowmwyHQ9rqHI7D033Bdjf3emnXHm
         yuUnEywHG14Jcp6SUiqABlKgxlAmNWUpD+6yte0XVFv6IyPQm58Qj6YiUS6WJH13B+0v
         M93w==
X-Gm-Message-State: ANoB5pkVtxuoClAB67fbPNplLN77Azhkp6qEun+tqo7FQqqeft/XSuta
        axL95bVlvgs73aGgsrNsSw7sKBXNzbdwlwBYgbefKjeM/QaB/29y3cu4/rF5Dtw40n0uBj1hwiH
        g6HwvFES+HnqxCCYhNyPtqlzW
X-Received: by 2002:a37:88c7:0:b0:6ec:537f:3d94 with SMTP id k190-20020a3788c7000000b006ec537f3d94mr39198699qkd.376.1669834028031;
        Wed, 30 Nov 2022 10:47:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+PtR+97OErwqdtdpLAmgCc7T40kDzRQ5HWQtrOB3wKppJCMd6/feeidNP2xvCl08lGMIJFw==
X-Received: by 2002:a37:88c7:0:b0:6ec:537f:3d94 with SMTP id k190-20020a3788c7000000b006ec537f3d94mr39198684qkd.376.1669834027810;
        Wed, 30 Nov 2022 10:47:07 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id dt4-20020a05620a478400b006fc9847d207sm1654902qkb.79.2022.11.30.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:47:07 -0800 (PST)
Date:   Wed, 30 Nov 2022 13:47:06 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Tianhao Chai <cth451@gmail.com>
Cc:     irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: fix check for invalid ethernet addresses
Message-ID: <Y4elKoff5qYRJkJw@x1>
References: <20221130174259.1591567-1-bmasney@redhat.com>
 <Y4eZg56XBWwR+pkr@x1>
 <20221130182640.GA394566@cth-desktop-dorm.rtp.nc.cth451.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130182640.GA394566@cth-desktop-dorm.rtp.nc.cth451.me>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:26:40PM -0500, Tianhao Chai wrote:
> I'm not familar with this particular board, but this probably shouldn't
> be done in kernel. AFAIK uboot allows overriding MAC with env 'ethaddr'.
> uboot then either writes this MAC into DT or calls NIC specific code to
> set the MAC into NIC memory before booting the kernel.

Our Boot Loader is ABL on the Qualcomm platform.

> The other way around I can think of is to use systemd-networkd or some
> other network management daemon to override the mac address as it tries
> to establish a network connection. This might be less hassle if you
> don't want to mess with the boot loader, but for embedded devices you'd
> need a different root fs image for every board.

We'll look into the systemd approach. I see that our board serial number
is available in /sys/devices/soc0/serial_number and we can have a script
generate a MAC address based on that. 

> Acked-by: Tianhao Chai <cth451@gmail.com>

Thanks!

Brian

