Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B726720071
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjFBLb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjFBLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A46C197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685705439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F00vpVMdWa9TR3+Nam4tbq5OQWssX8hYIk9OI5cMqFY=;
        b=NQ8VKrQ7SJtR4wo8UZYL/+D7ikqSD7BuQr3TdDmSHCiBCoGOpMfoZGTsnjegtgUVxpcYYb
        a/vP5qQKEnmyBgYnM0JNB3QZZGvVh/0j9nY9nsimK7qLu1KcNhfznp2dhnaNVbPtv0T0jT
        Gmb6DS2fHnn0Mu8aRDfpOWQHH+gAhRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-B_JtcF96NhaqsgBOAUQOsQ-1; Fri, 02 Jun 2023 07:30:38 -0400
X-MC-Unique: B_JtcF96NhaqsgBOAUQOsQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30af00323b0so1071498f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685705437; x=1688297437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F00vpVMdWa9TR3+Nam4tbq5OQWssX8hYIk9OI5cMqFY=;
        b=U1MORW05H3Q/Frw362QnTF2T5/GCDRf5w2vZ6dpirUltwuV1eExA6kd/JmRx931uCc
         3WGaIgUoJRzAkGso7FxH/ch/g03QjSyUy/4YKwN6kxJ5GyAdZPitl8AiFwYvJezrZ9mm
         /2oLHO1XzdSMicKG+tqfXu30MNv5ujX3ixYRkMziMYCLCW1L7QSq65fdOaRZNXWZPFfv
         yeWWavJkWdklLlDM6zz3o841/Zrt7iVTNbCbI7rmWg4xtsZqpRwBejeYwpVp9zfiCwsP
         hKJKFDrsBeQrQMcg5EMt+4RK8YVzyk49J5X5P/XTqAqKkmcjPi9NH5OiP7FNSRSTPX45
         ywcA==
X-Gm-Message-State: AC+VfDwM8FJa0vGv4EZ04wqwwrHVP+N4poJCsxa4Z/BUx8alurBMhPcQ
        skvby0Xx2KcpXivh8okHeRs3U2FtwRZEU3I9GaWWV4Lk+87i+DyAxMnKGNmH1bp8vcErk5a/dmk
        DKYBX4RZ9XPCa1H8fyQXaYmDo
X-Received: by 2002:a05:6000:1141:b0:307:7f38:37f with SMTP id d1-20020a056000114100b003077f38037fmr3299571wrx.66.1685705437012;
        Fri, 02 Jun 2023 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51q8bGzTk7RTQC1JX4flfHvzngWe3LU5wYEXOankGsD1jwSofiDuWc4F6Hnz+ZttjZWbaCmQ==
X-Received: by 2002:a05:6000:1141:b0:307:7f38:37f with SMTP id d1-20020a056000114100b003077f38037fmr3299553wrx.66.1685705436723;
        Fri, 02 Jun 2023 04:30:36 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b002fe96f0b3acsm1439241wrs.63.2023.06.02.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:30:36 -0700 (PDT)
Date:   Fri, 2 Jun 2023 07:30:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC PATCH net 2/3] virtio-net: allow usage of vrings smaller
 than MAX_SKB_FRAGS + 2
Message-ID: <20230602072957-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430131518.2708471-3-alvaro.karsz@solid-run.com>
 <20230430093009-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723043772ACAF516D6BFA79D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230501061401-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723AA2ABCE91928BE735DEBD46E9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4723AA2ABCE91928BE735DEBD46E9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 11:59:42AM +0000, Alvaro Karsz wrote:
> > First up to 4k should not be a problem. Even jumbo frames e.g. 9k
> > is highly likely to succeed. And a probe time which is often boot
> > even 64k isn't a problem ...
> > 
> > Hmm. We could allocate large buffers at probe time. Reuse them and
> > copy data over.
> > 
> > IOW reusing  GOOD_COPY_LEN flow for this case.  Not yet sure how I feel
> > about this. OTOH it removes the need for the whole feature blocking
> > approach, does it not?
> > WDYT?
> > 
> 
> It could work..
> 
> In order to remove completely the feature blocking approach, we'll need to let the control commands fail (as you mentioned in the other patch).
> I'm not sure I like it, it means many warnings from virtnet..
> And it means accepting features that we know for sure that are not going to work.
>

Well they will work yes? just with an extra copy.

-- 
MST 

