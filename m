Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C545F6446
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJFKVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJFKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5538183F15
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665051692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8PQYrKuK2/Hl24+POgcwMXBNTM5dRPCyF3STm9qM0g=;
        b=Fmmv83zGCBabIotizPxiunZAcoBfMCsSkKZw7txFcEP4Lh/k1EeNRhsuCIYPG6wXCMe6SX
        FMkB/IeIJKyMm1wSJOZcPlxEt/6tVWHS0x3O6UDL8KiHUm16R2egtBMKgI3SjdXQPZ/pac
        v+jtVfiJLNvvDhY1mSSysuNoQo3Egic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-DzRZ8RqYOYa97GtmQIBeDg-1; Thu, 06 Oct 2022 06:21:31 -0400
X-MC-Unique: DzRZ8RqYOYa97GtmQIBeDg-1
Received: by mail-wm1-f69.google.com with SMTP id i82-20020a1c3b55000000b003bf72acab9bso1835123wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=E8PQYrKuK2/Hl24+POgcwMXBNTM5dRPCyF3STm9qM0g=;
        b=00UBSB8RiV2+L3c0bm64nzfDSrLEwNp6JtS5ConHWJCrflSyHldIkDn9IXDZF7hyA3
         b9X0du8ZqrnsgkdoissVNXTjSZFnK1Y9kYkiXy5S6RJ7B61zCePKfVxQ9Qux2Ip19NVZ
         XsrMaR8TEIDfll3AFeZGjMnb0PLiyw+RZN0y8jSg/DP9UNQC8I27q0keg4K+1WU1Aux+
         dHHK1HWr+X+7I1NQ3dD5PVEAWUOzKrlZda2C8SIt+kYL2HfsegwCMivf+9LnZxN4/wpD
         W6ePvKP2qc1EY6RiBaczhaWwhJF6zvfnLQNF/5ojEEB5OpucsniJYfihIOtQ+DEjPVw0
         COog==
X-Gm-Message-State: ACrzQf1xHDIPzkbOG66bibC6uGiSxhDMjnkWoQ8p7Ss/HFwtsKN1BSSJ
        3DWYs2FZKBwTMyfzuJ/z9u0SS/N9vKcVJnnbhxnGlDVgC1wp6bGOtO9da/sWcVFbJ5oWXOh4bPo
        bVZ+6cP8YZto8NRw4Logtjrkd
X-Received: by 2002:a05:600c:524d:b0:3b4:8ad0:6d with SMTP id fc13-20020a05600c524d00b003b48ad0006dmr2717399wmb.194.1665051689860;
        Thu, 06 Oct 2022 03:21:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JVp31HaP/KRmbGPg8W12uqDcUB44zqvkXc5dl9LvnPr4lypZ4E1+srBSYlpGawuBaeq/W6g==
X-Received: by 2002:a05:600c:524d:b0:3b4:8ad0:6d with SMTP id fc13-20020a05600c524d00b003b48ad0006dmr2717390wmb.194.1665051689673;
        Thu, 06 Oct 2022 03:21:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b003a5ffec0b91sm4888829wms.30.2022.10.06.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:21:29 -0700 (PDT)
Message-ID: <b265d1b7bfcc602f6257877dc430bf89a0323e08.camel@redhat.com>
Subject: Re: [PATCH 1/1] net: fec: remove the unused functions
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Date:   Thu, 06 Oct 2022 12:21:28 +0200
In-Reply-To: <20221005131109.356046-1-shenwei.wang@nxp.com>
References: <20221005131109.356046-1-shenwei.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2022-10-05 at 08:11 -0500, Shenwei Wang wrote:
> Removed those unused functions since we simplified the driver
> by using the page pool to manage RX buffers.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

This looks net-next material.

The merge window has now started (after Linus tagged 6.0)
and will last until he tags 6.1-rc1 (~10 days from now). During this
time we'll not be taking any patches for net-next so
please repost in around 2 weeks.

When you will repost, please include the target tree into the subj.

Thanks,

Paolo

