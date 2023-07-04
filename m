Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9074720C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGDNDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDNDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B910C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688475746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDRjVUli4/Wo+gosprzbDZbukIPaouraxRxHctBqUJI=;
        b=EoOXHKgFIIbRcffB+jAPqwp3nuIDaQvI7MzO0lGNSCL5CpnbEjmuzNjeLFd4trlwuJZB8b
        8CR3PCjAGnWFRAgPUjv/fGju9yazhYzv9lvFFGbjw+qxaRnfToFQlKErPYN0PIBK1NJusE
        NTX+9WHbZlBMGVMiso0a3nvwPn5+JcU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-sK1vneRPMpqGEC3u3gs8vQ-1; Tue, 04 Jul 2023 09:02:25 -0400
X-MC-Unique: sK1vneRPMpqGEC3u3gs8vQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7673887b2cfso153913585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688475745; x=1691067745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDRjVUli4/Wo+gosprzbDZbukIPaouraxRxHctBqUJI=;
        b=ktESMR79+TBamN9xPyQ5oVT5jIsLaX0E6wf5kCcB98NPCPUSwsJyd9oBrT0xUeXn2X
         bE0HXPC1jMsMwGus4pDHn0/7XQHK1wE0inIUdFmLW5s3P9Qf58W/qTYJcgXPxR9n8U6h
         uoLdK86DaxyCuyF2hclpz6gf7B8OzTnWyn+H32zW/4CzpA3v1dbdiv0wikPKt4POQFRi
         vl2EJmIsakeShGJ/zS6v8RXAGK7QZylKEyio0oMITZooSpNT2lcUIidBssFs2LOwwKn7
         FFTf0Hr7GRL9KYTRcj9BwRtHWQabj8+bO4G7eAKP4f7OCasxftevZAYG3zfP2jcFrBNu
         0nQg==
X-Gm-Message-State: ABy/qLb2CsYwfe9XWp5jgREJT5si/P+Rjbb8AuZNgQVl47jSKMAKNq3Z
        ctoyditm6nWjF6vrEwQrk6pwjJLgUjukpxxpVG5EImnvlkTeGtcaE5YduGJKSm6qWmLzOVmFQjZ
        Rol+VpK5Wa4003vPcshG7N0Pc
X-Received: by 2002:a05:6214:1c44:b0:62f:e386:1e45 with SMTP id if4-20020a0562141c4400b0062fe3861e45mr14935033qvb.1.1688475745318;
        Tue, 04 Jul 2023 06:02:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1Ng7cnLpEMncNqQT8Wu70KWYSGYSrZZ+7l3UsJbbqOgTckJ0WeHx6v6IWOw9pN7kOy54sMw==
X-Received: by 2002:a05:6214:1c44:b0:62f:e386:1e45 with SMTP id if4-20020a0562141c4400b0062fe3861e45mr14934983qvb.1.1688475744669;
        Tue, 04 Jul 2023 06:02:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id h1-20020a0cf401000000b0063007ccaf42sm3480598qvl.57.2023.07.04.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:02:24 -0700 (PDT)
Message-ID: <8ad620b632d723bc2f61ec1efb81d16c465d58bb.camel@redhat.com>
Subject: Re: [PATCH net-next] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
From:   Paolo Abeni <pabeni@redhat.com>
To:     menglong8.dong@gmail.com, michael.chan@broadcom.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Date:   Tue, 04 Jul 2023 15:02:21 +0200
In-Reply-To: <20230704085236.9791-1-imagedong@tencent.com>
References: <20230704085236.9791-1-imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-04 at 16:52 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
>=20
> Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> to clear the unnecessary noise of "kfree_skb" event.
>=20
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle
--=20
pw-bot: defer

