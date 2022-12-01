Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B063EFB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiLALmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiLALlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654D98972
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669894856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yW/cZ2Z5o6i4KxEquTb7/X2nGHQmwqZNw+btvVM7fIs=;
        b=F95Ljwq3imZL2QBW8/7k2fDyy+aJ4+RbEwiexT04o0OfMOyb3sL/RdR5PKMjTBRk0obsET
        YTfNS4BuJimIKUZ3/mkLxhXiFYPmIE+huKc+GfGQB3uTwHQD4mzPi/d4+2j7lwNcCtu2/K
        NAqIIYSBPZa1HZhB26te8Hl0l+Aiwq4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-LRJaV9cPPuut8gc7Yuw94g-1; Thu, 01 Dec 2022 06:40:54 -0500
X-MC-Unique: LRJaV9cPPuut8gc7Yuw94g-1
Received: by mail-wm1-f72.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so2421593wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yW/cZ2Z5o6i4KxEquTb7/X2nGHQmwqZNw+btvVM7fIs=;
        b=dfpjxczjLf5GqhHTogbaeZNwlYtyHiKJQJQxgfhEU7I/Vlsw9F5vbmorycQP1iRbCh
         fTcUeHfe/a9PowJGuBho66aqL/F4qoaQ1Vbyp+OVJWLK9g+cg7Uc8c70IUd7flm2MSe+
         rXATH68sRlf3rLbrNBGojKwUzsuxJQN/gykJKQ/91BmYpjeXP0S1tBBaLm1VERcctw9H
         CAejashKe/sTK5WS9Xlb+p6f/WXWNCdSfyewm1F/qu0EBuSpAT9Ok+Q4cU9UmR7x+Dbl
         qFn5eRN0nJIQxU+EHle5774+Utr6K7UarsjCHpseiG5Xl12NjZbku8iOF1VWbfFBRXoQ
         gXEw==
X-Gm-Message-State: ANoB5pntdjhqyUtiaAnLy8s+gSh3v0vVhpP3Un5URjPg6wNIFD72rCHb
        U9bo9k28dj2wXdz8FLNmxSNBLsROGcfGgeQztia6eDz7oOgVIZ+v/veclxHIzeVWFwZc+L051BV
        creB1NAuhtBV+b19Oib1KU360
X-Received: by 2002:a05:600c:aca:b0:3c6:6f2c:64ef with SMTP id c10-20020a05600c0aca00b003c66f2c64efmr41468670wmr.91.1669894853535;
        Thu, 01 Dec 2022 03:40:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7KYx7l14jHtR36fJ0R07i3GNEthiTcJzcmBeHhKJjQrq0ypw62l+DxXKeXhWGqqRMPx2xXfg==
X-Received: by 2002:a05:600c:aca:b0:3c6:6f2c:64ef with SMTP id c10-20020a05600c0aca00b003c66f2c64efmr41468651wmr.91.1669894853321;
        Thu, 01 Dec 2022 03:40:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm11182535wmo.0.2022.12.01.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:40:52 -0800 (PST)
Message-ID: <9fdc4e0eee7ead18c119b6bc3e93f7f73d2980cd.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 4/6] net: ethernet: ti: am65-cpsw: Add
 suspend/resume support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Roger Quadros <rogerq@kernel.org>, davem@davemloft.net,
        maciej.fijalkowski@intel.com, kuba@kernel.org
Cc:     andrew@lunn.ch, edumazet@google.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Dec 2022 12:40:51 +0100
In-Reply-To: <20221129133501.30659-5-rogerq@kernel.org>
References: <20221129133501.30659-1-rogerq@kernel.org>
         <20221129133501.30659-5-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-29 at 15:34 +0200, Roger Quadros wrote:
> @@ -555,11 +556,26 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
>  	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  	int ret, i;
> +	u32 reg;
>  
>  	ret = pm_runtime_resume_and_get(common->dev);
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Idle MAC port */
> +	cpsw_sl_ctl_set(port->slave.mac_sl, CPSW_SL_CTL_CMD_IDLE);
> +	cpsw_sl_wait_for_idle(port->slave.mac_sl, 100);
> +	cpsw_sl_ctl_reset(port->slave.mac_sl);
> +
> +	/* soft reset MAC */
> +	cpsw_sl_reg_write(port->slave.mac_sl, CPSW_SL_SOFT_RESET, 1);
> +	mdelay(1);
> +	reg = cpsw_sl_reg_read(port->slave.mac_sl, CPSW_SL_SOFT_RESET);
> +	if (reg) {
> +		dev_err(common->dev, "soft RESET didn't complete\n");

I *think* Andrew was asking for dev_dbg() here, but let's see what he
has to say :)

Cheers,

Paolo

