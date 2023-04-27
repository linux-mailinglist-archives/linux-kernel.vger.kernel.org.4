Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC66F00F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbjD0Gk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbjD0GkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426434497
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682577576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPgT1XWD9d2y5CAUKsljbODvEs9Jrlwdja8eU+CRgw4=;
        b=ZXxJwmyp/h8UWOf2o22KaSVpp1FfSb8YAXOQaiuovaq8QQ3QltFtcMovG+FSDI/vCGXeKn
        lYzMtpPoCEUF0GdehuzfW3KgQD3Y+dHm6q1Vjjf4Ter2T/ExptStixsh7dxdElK8Ak3A+3
        U3MYTK7mepMKmSJG6cOto7mqG8DRv+0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-UHxRKJyEPNWNgJUw3R4jaQ-1; Thu, 27 Apr 2023 02:39:32 -0400
X-MC-Unique: UHxRKJyEPNWNgJUw3R4jaQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f17b63c8c4so13647995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682577572; x=1685169572;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPgT1XWD9d2y5CAUKsljbODvEs9Jrlwdja8eU+CRgw4=;
        b=TMCOjfYTbGiEc+56Ujt5kVLRoUjrTArzN+9+GgaymEFFbAHz2VumabYiUMoncGBc+z
         l2F8prDs5CtvAcmZ6n3E5zAyB5MromsJ99zsRRkGI76vDtnRNay3nU4pf4JkFzH+NjV/
         6NGsZCiybkZOxbn6RiT9PSYL4kRrQ2AC47XUVbExTenlKZMhHDZ0f++x0JSkQV3yIJBV
         ZVi0F9rB9yugQfdPk634LgJoijwp/upmnU+wYxBustNLWlnn6mey5sxIErriYqQLMeIA
         HrdjBu2G+jPha7AdGjoBaTOyWxgtHbL+ghoMp/QoDjG0o6bLvOACHXi2bBRND0D/ZxNT
         1nUQ==
X-Gm-Message-State: AC+VfDxXrSWXtKcNMbEU7/wDTLHDd2S952hrDQ4XeB5C1Z0+7FDFlbXw
        ENTl1xEfj2tUF8x6XNSg2toy9CCNDWg2UGLcdv9xoCOs8LD51JqNTvP5+2kNWVYst/62sBJEce7
        hKfpVzadM7EBeiMuFu7jgQLpL
X-Received: by 2002:a05:600c:3542:b0:3f1:727f:1967 with SMTP id i2-20020a05600c354200b003f1727f1967mr562870wmq.4.1682577571773;
        Wed, 26 Apr 2023 23:39:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nfw/gigju/G5+W4XvHrkkofOyr4OClCYOMyOx1Xwo8l5UX2w+C9oIum9isKIt2hEzyr23Ug==
X-Received: by 2002:a05:600c:3542:b0:3f1:727f:1967 with SMTP id i2-20020a05600c354200b003f1727f1967mr562846wmq.4.1682577571460;
        Wed, 26 Apr 2023 23:39:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-21.dyn.eolo.it. [146.241.243.21])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003eddc6aa5fasm19760644wmb.39.2023.04.26.23.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 23:39:30 -0700 (PDT)
Message-ID: <9f678eac46332679ea3457ba71e82cf6e96b991d.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 0/6] Brcm ASP 2.0 Ethernet controller
From:   Paolo Abeni <pabeni@redhat.com>
To:     Justin Chen <justinpopo6@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     justin.chen@broadcom.com, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Date:   Thu, 27 Apr 2023 08:39:23 +0200
In-Reply-To: <1682535272-32249-1-git-send-email-justinpopo6@gmail.com>
References: <1682535272-32249-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-26 at 11:54 -0700, Justin Chen wrote:
> v2
> 	- Updates to yaml dt documentation
> 	- Replace a couple functions with helper functions
> 	- Minor formatting fixes
> 	- Fix a few WoL issues
>=20
> Add support for the Broadcom ASP 2.0 Ethernet controller which is first
> introduced with 72165.
>=20
> Add support for 74165 10/100 integrated Ethernet PHY which also uses
> the ASP 2.0 Ethernet controller.

Note that the changelog should be located after the cover letter
itself. Changelog in the individual patches should be more helpful,
too. In that case, it should be located after the tags and a '---'
separator.

## Form letter - net-next-closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after May 8th.

RFC patches sent for review only are obviously welcome at any time.
--=20
pw-bot: defer


