Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C977726A82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFGUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjFGUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7A1BCE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686168920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IbNJSMdQgU9VQLlBMF193RvlUeSC+D1EGbqTaY89bwo=;
        b=FxZJvWw26KAjaeYQcgBdHs+5SLJ/zoKI5emM38WbCDMp4Wm08pD0gcFq3HA29ANdLxfJZP
        y1+26YUmhOuiJIw5oXTkSmtGslkPuSUG6sP3hGw1OimWVoV8MKId2mfevKsU/Cp7dhhikr
        JGxzdWaVh8Jco1K+itj4pPn3Molk840=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-qgHJkevqMoym6B9B09jZAw-1; Wed, 07 Jun 2023 16:15:18 -0400
X-MC-Unique: qgHJkevqMoym6B9B09jZAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e7cfcae4so20603615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686168917; x=1688760917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbNJSMdQgU9VQLlBMF193RvlUeSC+D1EGbqTaY89bwo=;
        b=RJKgJyWeNhY8W2Aw4c+04AzwaYY9ExkaMXC4AkKtcpwJzlN7g+ozl3wJ6uhjKm8Akz
         AfvVTC3RFStqS01vcWiZSTrj0QJSQFuODzBMFNlvteXewswUaPqHJ3uij9HsS2PC3D5O
         vHxWtI/HoxAivLYA2fMlMHitFY2X6el40oTouR6wuwTaeLt8ntdmI0hnqd8ndiYE+Cx2
         vEOE6Hd9rJwwMyAeJBgK7CT4APATorNAob3zJOeNVEhRa4Hx33LxxCuwM76TPBC9LFXM
         dGu+It4HRXqbswbbqiYO2+71NWTkHiqJu19H5SMP0cl3+DBHRy/au/8P33i1YJQrkWMD
         X9aQ==
X-Gm-Message-State: AC+VfDxO/QwqF86RALfe5cRBK8Lc5EB2ss2KMlsgNOiVMCMlv4cSzpn7
        5AvtOpsPGVmiLOTdgWn5+7mT1xDuac6OZT8XJkdS7NF9Fw1xyeg8jP6cemE6XPjkgUIR8eTK4q5
        VJ8jfLU+0dNQfJ2ReZeHwwI0y
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:941d with SMTP id t23-20020a1c7717000000b003f7eadb941dmr7565500wmi.19.1686168917314;
        Wed, 07 Jun 2023 13:15:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BuNZENhGXmy7RykVEep93dqwtBJaN8D86qVbIP42EfYDXBC7+P61b2CTrPMue3++mbYka1g==
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:941d with SMTP id t23-20020a1c7717000000b003f7eadb941dmr7565477wmi.19.1686168916980;
        Wed, 07 Jun 2023 13:15:16 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003f727764b10sm3110831wmj.4.2023.06.07.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:15:16 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:15:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
Message-ID: <20230607161440-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602232902.446e1d71@kernel.org>
 <1685930301.215976-1-xuanzhuo@linux.alibaba.com>
 <ZICOl1hfsx5DwKff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZICOl1hfsx5DwKff@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:05:11AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 05, 2023 at 09:58:21AM +0800, Xuan Zhuo wrote:
> > On Fri, 2 Jun 2023 23:29:02 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Fri,  2 Jun 2023 17:21:56 +0800 Xuan Zhuo wrote:
> > > > Thanks for the help from Christoph.
> > >
> > > That said you haven't CCed him on the series, isn't the general rule to
> > > CC anyone who was involved in previous discussions?
> > 
> > 
> > Sorry, I forgot to add cc after git format-patch.
> 
> So I've been looking for this series elsewhere, but it seems to include
> neither lkml nor the iommu list, so I can't find it.  Can you please
> repost it?

I bounced to lkml now - does this help?

