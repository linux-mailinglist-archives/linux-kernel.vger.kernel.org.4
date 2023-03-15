Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE66BA7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCOGmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCOGmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:42:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09DE64268
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:42:34 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81D063F1C3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678862553;
        bh=QQPXWCJGAVqPCrDQDEiksVm9saVIlCxHx75WTxvRwxc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=lEhqhxsrafnfDpcICJi2w5eogkuoQcG7guMTPpfjfpeSj4h5O4h6xirO54X1HPvy0
         KeJtodia/jmnqgkIa5JSKVZaRi2UpiQ1KwGuMTAyokmC/mz5wEDD2M1ffJVAfopzZC
         6xixagdrzXdlPj5TLBKqWHNpCaV4yuDlqSTtob7pk6jAE0abb5q3v7aqhTrCBs7H4W
         piK3b8TIOKZtILY2z5enaBFC9Xi4n2UGhv/Yxz9RkjbIWIgvauPZBC4oh9rqDElmBM
         BMS6uQM2iI3DM3cJvtv8g+z+buc9q3Vp7Jripq0NOhWO5egmUj0gwvGkioxyK6imL4
         7CJqx8/2R4/Lg==
Received: by mail-ed1-f72.google.com with SMTP id dn8-20020a05640222e800b004bd35dd76a9so25521539edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQPXWCJGAVqPCrDQDEiksVm9saVIlCxHx75WTxvRwxc=;
        b=XZqAWTw3MQRXRDdpDopJ5c8EeyGjUM7IyYpj6sbfvgGMI0xQwXf7MyUjgrGT0gf94G
         IS+VvFFvhNNJCHWF07Tv4g8aFp3+4zQ+12SGWpc77vqe6KVBNPZAgFo3Z2AZAJKkzzcq
         0u7dr4o1u2AXXoQDiBKHz0DHXzdgh2R15i1NyNmYLbF6qQglCwHaGWxcIcYVnGZzT4Jz
         8Nkev7fOXz07YXPvBWlsDZfVp1EfJqdXn96epwQUa4yT0z6v3FJLZ97xW4i39CN3BYFC
         7AXxH6p9JKZFEUwiuKuYsc5/YRxMvJVrp9PKDMBkPWASxg0YtPHbu0PKsJxtGHT4Jw1i
         d9sA==
X-Gm-Message-State: AO0yUKVGvS5JkNGANbwESzhC0MRorDIFC6wWI0ANOfyLRRfgbe6qT3Ni
        WFdSlbNh3UXqPtQI6GEvwWR2GnVdQcpsm3ZnAxEKx3iZqygYIXzEIxCjZDZOv77dQaW9EwlXhrr
        wT1e38OYeHV9vqjC1CuTwySnESvnPU8zp2Klle1LZyg==
X-Received: by 2002:a17:906:a90:b0:877:5938:6f6d with SMTP id y16-20020a1709060a9000b0087759386f6dmr6042288ejf.56.1678862553246;
        Tue, 14 Mar 2023 23:42:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set+sXcC3b5v3NhXMiaV4FPaQsAZNt5dpTsGP5MtjsAqIfCkshWOBfqoxo2XpOeQysXCGjQnV9g==
X-Received: by 2002:a17:906:a90:b0:877:5938:6f6d with SMTP id y16-20020a1709060a9000b0087759386f6dmr6042270ejf.56.1678862552956;
        Tue, 14 Mar 2023 23:42:32 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id go37-20020a1709070da500b00927b85e48b0sm2016585ejc.111.2023.03.14.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:42:32 -0700 (PDT)
Date:   Wed, 15 Mar 2023 07:42:31 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: boot regression on ppc64 with linux 6.2
Message-ID: <ZBFo18eqFIWvdwpo@righiandr-XPS-13-7390>
References: <ZA7oJr1/Z4vzWy4N@righiandr-XPS-13-7390>
 <878rfyofma.fsf@mpe.ellerman.id.au>
 <ZBFhUAlL+1ZVKcwQ@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBFhUAlL+1ZVKcwQ@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:10:25AM +0100, Andrea Righi wrote:
> On Wed, Mar 15, 2023 at 02:30:53PM +1100, Michael Ellerman wrote:
> > Andrea Righi <andrea.righi@canonical.com> writes:
> > > I'm triggering the following bug when booting my qemu powerpc VM:
> > 
> > I'm not seeing that here :/
> > 
> > Can you give a bit more detail?
> >  - qemu version
> >  - qemu command line
> >  - what userspace are you using?
> >  - full dmesg of the failing case
> 
> Yeah, ignore this for now, it could be related to another custom patch
> that I had applied (and forgot about it sorry), this one:
> https://lore.kernel.org/lkml/20230119155709.20d87e35.gary@garyguo.net/T/
> 
> That is causing other issues on ppc64, so I think it might be related to
> that, I'll do more tests making sure I use a vanilla kernel.
> 
> Sorry for the noise.

In fact, I confirm that everything works fine with v6.2.6.

Thanks,
-Andrea
