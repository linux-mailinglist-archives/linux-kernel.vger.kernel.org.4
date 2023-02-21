Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09E669E05A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjBUM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjBUM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3AD40FA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676982463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH9Zs3Ynup8QEj3M7umA2rpBmSqMBswm4cOHxTio+fY=;
        b=VJJzrzLtUARcIFj80xfTHV1Xzo/bOXFXMKDTBDfx4cdqO9aPIddkyGfLE28Y0DOZTMye3Q
        cZnr+k/UGauUVwAQXWGvnKsE32NZW4AvdOe3OzUDp6c4ktQSYUDTw0duQXJK34aKa3MTnj
        Zgv/RI88ika21aAxy29vuUoa0B8FcU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-ziB41gpAPEO1KCL2H5WAeA-1; Tue, 21 Feb 2023 07:27:42 -0500
X-MC-Unique: ziB41gpAPEO1KCL2H5WAeA-1
Received: by mail-wr1-f69.google.com with SMTP id bt1-20020a056000080100b002c557db0e0fso909206wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676982461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH9Zs3Ynup8QEj3M7umA2rpBmSqMBswm4cOHxTio+fY=;
        b=erB5nXwLquN28QKEXeS0fJhEs3TV17DdtBaiPCOK3wlwO5Er25q0mfb0VZ6cl6ClKX
         hPJsTeNAkefWkWKjEMIRvVnhazL+w7wR21IqOLZhWQMeFbL91kbhhX01vJwNNFLQI5V+
         f+WKIRNHGHH27j6dXE+WFqm9gv9fSTZ00xCXbrax66s75ob5yz+Rdqguu7CpEdqw1TK+
         GbCY3HXYeiVnvAsE7ngfPG28n4dfUgFDsWiDldYIrwckWYVVHtRJgZk5NlhEZBvAqnnn
         iEQyhgdXcbQqsxBT+mk0dvFzf5Ny86gg9IRQMKZUncagrp1JcUKUNyzPe99PNAM/zUF0
         kydQ==
X-Gm-Message-State: AO0yUKVOY97fY7C80v3yZKafFu/fSTSzbbhCPG2NLHdZuw7v4IhgHc56
        m77LeA21iOVar8yRMUxCAKTK000rqr1jZ1xz/V3imUC1Oi+PbI+pl28VfNb+zMbl/7GLVRi9PJt
        JOdcEH0akNt37NYjdcqOK2B6v
X-Received: by 2002:a5d:5956:0:b0:2c5:595a:1c92 with SMTP id e22-20020a5d5956000000b002c5595a1c92mr2875377wri.6.1676982461555;
        Tue, 21 Feb 2023 04:27:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9a3kH8ia6rTQ7nRpyFWjsQn3JJlzvkPw+s98kN7nZ74eIb64/SpsJ2QhQdjDYzZAo5zrZSiA==
X-Received: by 2002:a5d:5956:0:b0:2c5:595a:1c92 with SMTP id e22-20020a5d5956000000b002c5595a1c92mr2875370wri.6.1676982461215;
        Tue, 21 Feb 2023 04:27:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b002c54c8e70b1sm4705292wrm.9.2023.02.21.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:27:40 -0800 (PST)
Message-ID: <48429c16fdaee59867df5ef487e73d4b1bf099af.camel@redhat.com>
Subject: Re: [PATCH net] udp: fix memory schedule error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Xing <kerneljasonxing@gmail.com>,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date:   Tue, 21 Feb 2023 13:27:39 +0100
In-Reply-To: <20230221110344.82818-1-kerneljasonxing@gmail.com>
References: <20230221110344.82818-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-21 at 19:03 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> Quoting from the commit 7c80b038d23e ("net: fix sk_wmem_schedule()
> and sk_rmem_schedule() errors"):
>=20
> "If sk->sk_forward_alloc is 150000, and we need to schedule 150001 bytes,
> we want to allocate 1 byte more (rounded up to one page),
> instead of 150001"

I'm wondering if this would cause measurable (even small) performance
regression? Specifically under high packet rate, with BH and user-space
processing happening on different CPUs.

Could you please provide the relevant performance figures?

Thanks!

Paolo

