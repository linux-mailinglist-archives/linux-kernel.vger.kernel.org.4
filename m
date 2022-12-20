Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28879652304
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiLTOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiLTOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F35F66
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671547624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0z2BB7HZepudK9U4VAxjDq32wvem0CZa2ZoIWPry1PE=;
        b=aWEuZTBVF+RY+cJM6qM+cMX2I4bpwjD21Kl3Wlz3HhYtFOSgf/xk+a2JyFRzl23Q7arcrA
        PPcrskr4qvUCv3MkxH4yL72hb8YreZbz1/nu9R9kdM8R/4pN9KO33moWqKfGBOUoE6f3bM
        ueke70TgPcsZ2gQKWp1ifLrYFWoTeOE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-UjWTUs5tN9WretwQ8GEh7w-1; Tue, 20 Dec 2022 09:47:01 -0500
X-MC-Unique: UjWTUs5tN9WretwQ8GEh7w-1
Received: by mail-qv1-f72.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso7218248qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z2BB7HZepudK9U4VAxjDq32wvem0CZa2ZoIWPry1PE=;
        b=tLFrDF1EOASS4qbzKebRGVJys1VTmXh6gp+l0QAZ271K71qS0ZX9ADM/wWzHp0XkQA
         +GaqbXYsbq2WxhiGpzQdzexJqizdND1dMMf7yD+9lcQjVZPOMK2pjZqg6S5qpuOpGXpU
         +uivFhasUElQZXQRGH7R2Wh24OJTLV66Pyumav+gHiBie7ktR/JIZUXpMbh63ten9n3N
         Wo/mB2xePiXNQT970DaGcUPeRT5j7dXxH0GWVqnj1/bIvTef9d69pVRnKD9/MgNDrtaV
         GFWdCcorgcTUnqI/5O9ouGmyLsPCa4RWa8jAs+IcFrcDxUp+X7usBUE6uppo+/16n/XO
         Xwbg==
X-Gm-Message-State: AFqh2koPKk+UoiCQDo301Kh6JWxKAzj2VZpatzPzZu0ahEyYBieBsP2Q
        19Xaw5hE9zYsCmbZiqIoTrpdBkSIv69kp2sjCctYgfEcf1q/oUCAARcLhGUijExhqiDF3Smz+A5
        bQOZI+urKjrzSiF/5AzM5xhIQ
X-Received: by 2002:a0c:c210:0:b0:4c6:e48c:be32 with SMTP id l16-20020a0cc210000000b004c6e48cbe32mr18364191qvh.17.1671547620909;
        Tue, 20 Dec 2022 06:47:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsMEBtuagmbBe6KrwoaOPH1vEEQMfGXchud6JSoqnl5N1KzPW1meaxpM4qob1da1TNN0knbqw==
X-Received: by 2002:a0c:c210:0:b0:4c6:e48c:be32 with SMTP id l16-20020a0cc210000000b004c6e48cbe32mr18364170qvh.17.1671547620655;
        Tue, 20 Dec 2022 06:47:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a11b800b006fc2cee4486sm8843945qkk.62.2022.12.20.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:47:00 -0800 (PST)
Message-ID: <90ff72e75142e377273ef980ca2d26951449610c.camel@redhat.com>
Subject: Re: [PATCH net] net: fec: Coverity issue: Dereference null return
 value
From:   Paolo Abeni <pabeni@redhat.com>
To:     wei.fang@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        linux-imx@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 15:46:56 +0100
In-Reply-To: <20221215091149.936369-1-wei.fang@nxp.com>
References: <20221215091149.936369-1-wei.fang@nxp.com>
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

Hello,

On Thu, 2022-12-15 at 17:11 +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The build_skb might return a null pointer but there is no check on the
> return value in the fec_enet_rx_queue(). So a null pointer dereference
> might occur. To avoid this, we check the return value of build_skb. If
> the return value is a null pointer, the driver will recycle the page and
> update the statistic of ndev. Then jump to rx_processing_done to clear
> the status flags of the BD so that the hardware can recycle the BD.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Shenwei Wang <Shenwei.wang@nxp.com>

You need to include a suitable fixes tag here. Please repost adding it
and retaining  Alex's reviwed-by tag, thanks!

Paolo

