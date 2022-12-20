Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73583651DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiLTJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiLTJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBC1109
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NoS+Bqz9ATFzWnlIG9oJwXTJiAoyqlPjgi89DKPgSU=;
        b=Ii7O1Vin8T/B4QwSEDA84JIbbNnI8P4J/paF2XqmlDRh/G4GioMP4z1iDAlzsQvkCOF+oS
        DI7KGmFpv9ffv4ZVOM76b4yjU7mrxrcyAUJLf7oxhPlkfLibOzvrQqpkHDfs7PbcqasAEF
        f9sJn6G3DmZGiYHRuccAYY+LAWrzhSg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-KQvy0uoZOxapWSsITfUBAg-1; Tue, 20 Dec 2022 04:45:32 -0500
X-MC-Unique: KQvy0uoZOxapWSsITfUBAg-1
Received: by mail-qt1-f197.google.com with SMTP id j26-20020ac84c9a000000b003a7e6d38e01so5304349qtv.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NoS+Bqz9ATFzWnlIG9oJwXTJiAoyqlPjgi89DKPgSU=;
        b=GpiBryIH92VC81RPxsVlYriZKSr42fB7NQBC0lkTiOqq3M+YNYgmdHlm0crqrsdGvf
         snyQGhUnG10pmzY5fsUH1EpmUlr/LvbHHY3E9WLY5WkMaQHyH4mi9bSbt/kD4x356B1B
         veqJDbrPCL5ztN18Fgt6ccj029mU3acpm+D71b2RHEtabz7xfbfu0B+xYsceh6vw0OMr
         jrIvUdZO8eGTnjbIf3lByPf1be0XBYwBmjn9b81OM6a9XB+eT5n1agqreRPCWFrxx4v7
         GoUZhz/VbrWwwOxaf+tYEYeWl4HY+vzfLwNMh+o6e30mhI/dPavtbkHVNZmb9XmS1bZe
         rjBg==
X-Gm-Message-State: AFqh2kq9IRXMqmUUpZ1/JvlkTRLUNb6oktXsreinf3UgfB1bAE+4/MRT
        TSyXDR17NFtEs08DX3cyZqDhl2+aUOtd/Bb4L9qDQC3uk75G3e9q/KP7vqswg14Vbbc2F/iZKmf
        EJ/tXKLWnIaunZ0U7euYC/Wnc
X-Received: by 2002:ac8:4752:0:b0:3a5:6961:e1c5 with SMTP id k18-20020ac84752000000b003a56961e1c5mr2603572qtp.48.1671529531667;
        Tue, 20 Dec 2022 01:45:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXta/lY2p7viJf764arQSIM+mAkP5mp0z/MMrwsYN8PvneFOw07z0yJIqG58rVh6SkI8fJdTIg==
X-Received: by 2002:ac8:4752:0:b0:3a5:6961:e1c5 with SMTP id k18-20020ac84752000000b003a56961e1c5mr2603558qtp.48.1671529531425;
        Tue, 20 Dec 2022 01:45:31 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id 124-20020a370582000000b006fae7e6204bsm8403328qkf.108.2022.12.20.01.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:45:30 -0800 (PST)
Message-ID: <ddac533a2c4db7efd4214a5a4f7f9f5797bf2a51.camel@redhat.com>
Subject: Re: [PATCH] net: alx: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
 pm_sleep_ptr()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christoph Heiss <christoph@c8h4.io>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 10:45:27 +0100
In-Reply-To: <20221217104024.1954875-1-christoph@c8h4.io>
References: <20221217104024.1954875-1-christoph@c8h4.io>
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

On Sat, 2022-12-17 at 11:40 +0100, Christoph Heiss wrote:
> Using these macros allows to remove an #ifdef-guard on CONFIG_PM_SLEEP.
> No functional changes.
> 
> Signed-off-by: Christoph Heiss <christoph@c8h4.io>

# Form letter - net-next is closed

We have already submitted the networking pull request to Linus
for v6.2 and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.

