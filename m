Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4C6542D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLVOXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiLVOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C6D28774
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671718945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMgekTLXsAQ2q0wUPkhRLoJ34D3Iu1pE56+7MU/IOrE=;
        b=RljNesQGix9TL+CI/S1mXZu9G8HSl3FH1RldVqn3/BygxWKJpVl8xE/+9h39d0Wg+tF6LF
        ApfBKxfdGMsZkGPyIRtPxjFIDzEkNp3Y0wffIvTufjs9vNES8kCsNDwm/IV3CQ13BO/JQN
        vrOsm1lw8o7VsTXPvfmC6l9YIoFSxF0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-qIx2KSWEOGm2jImMSj88kQ-1; Thu, 22 Dec 2022 09:22:16 -0500
X-MC-Unique: qIx2KSWEOGm2jImMSj88kQ-1
Received: by mail-vs1-f71.google.com with SMTP id 64-20020a670843000000b003aea5f5ab18so451336vsi.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMgekTLXsAQ2q0wUPkhRLoJ34D3Iu1pE56+7MU/IOrE=;
        b=7uDjLNgNUZ7DKwbmcSz12bi0iUY4Di5EsmhACsOmwg6P/COmpVHE2v7kFitF44zC1U
         nDKHmPSif37uN3a9wcqyZk4naesogOv6hajjjL5h0Bia3KPj8B/Sn/ZmHedQYrr4xK17
         3tfpvdfIjfEHm8ROfn3TeNMdAP3d+2ONjhqYDisypXjjKWt96gKrytkHmOddveihq7jH
         CUvr8mwZMC6gPQYdQemOE8r4iUSTHYbxcfokSGLdIpis9zpQIWOWuPVjrZJ+0Jd3noQm
         7hMjA1g5DbdV1mDsV8u0/8BlplRgpwf65y4TTgHS7KxLXcHUbFD9St+HfGNSw22dBACx
         z71Q==
X-Gm-Message-State: AFqh2kqR1ktUKTrMJ/eCWq0EamP62bOTwhCVAjr458jwZuH5+RUS5d2X
        fJ3V6YuGTnfIaLdN5Co0i/lK5XhRx1QwmIhrTo+FkQmTrF/WAkUSW+MDEz/0Kkg8NSXRCRA8pX1
        zPAQdMlndB3oRnXxoMyY8HA00
X-Received: by 2002:a67:eb5a:0:b0:3b5:1c66:8462 with SMTP id x26-20020a67eb5a000000b003b51c668462mr2629850vso.12.1671718935776;
        Thu, 22 Dec 2022 06:22:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwyw9Z+LcJ9dpEG9P9afhFXLi0GxMfLp+zU4iEXlv4iTOSPG+1dv6HL0kIQQrmS+UX20ycGw==
X-Received: by 2002:a67:eb5a:0:b0:3b5:1c66:8462 with SMTP id x26-20020a67eb5a000000b003b51c668462mr2629819vso.12.1671718935509;
        Thu, 22 Dec 2022 06:22:15 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id bq43-20020a05620a46ab00b0070209239b87sm380834qkb.41.2022.12.22.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:22:14 -0800 (PST)
Message-ID: <0efd4a7072fb90cc9bc9992b00d9ade233a38de1.camel@redhat.com>
Subject: Re: [PATCH net 0/8] Add support for two classes of VCAP rules
From:   Paolo Abeni <pabeni@redhat.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     UNGLinuxDriver@microchip.com, Randy Dunlap <rdunlap@infradead.org>,
        Casper Andersson <casper.casan@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Machon <daniel.machon@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Dan Carpenter <error27@gmail.com>
Date:   Thu, 22 Dec 2022 15:22:10 +0100
In-Reply-To: <20221221132517.2699698-1-steen.hegelund@microchip.com>
References: <20221221132517.2699698-1-steen.hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Wed, 2022-12-21 at 14:25 +0100, Steen Hegelund wrote:
> This adds support for two classes of VCAP rules:
> 
> - Permanent rules (added e.g. for PTP support)
> - TC user rules (added by the TC userspace tool)
> 
> For this to work the VCAP Loopups must be enabled from boot, so that the
> "internal" clients like PTP can add rules that are always active.
> 
> When the TC tool add a flower filter the VCAP rule corresponding to this
> filter will be disabled (kept in memory) until a TC matchall filter creates
> a link from chain 0 to the chain (lookup) where the flower filter was
> added.
> 
> When the flower filter is enabled it will be written to the appropriate
> VCAP lookup and become active in HW.
> 
> Likewise the flower filter will be disabled if there is no link from chain
> 0 to the chain of the filter (lookup), and when that happens the
> corresponding VCAP rule will be read from the VCAP instance and stored in
> memory until it is deleted or enabled again.

Despite the 'net' target, this looks really like net-next material as
most patches look like large refactor. I see there are a bunch of fixes
in patches 3-8, but quite frankly it's not obvious at all what the
refactors/new features described into the commit messages themself
really fix.

I suggest to move this series to net-next (and thus repost after Jan
2), unless you come-up with some good reasons to keep it in net.

Thanks,

Paolo

