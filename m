Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95F65680C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiL0H5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiL0H45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45885B79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672127770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXIiVrztZsdU7pju6USGfTMhcaQjY/sBo8HpMhE5ZAA=;
        b=VaJjcKiI7m6Ip3ToUh+HHHMX68WqbDp4wvwRdzl35sTDWgqMm0x+4MB+8Uppm1j6jPqXF8
        F3Aun8Joh6E+NtfAPfBWlRzQG6LiaUIGNc++GcIQhh0PsicJa/Fd6HdoWlDouOYN8Z4PrM
        bKrD1pYOvH6pm+cZKL+uACggmql70I4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-vqWY112fOoK2XXVRfrkJPg-1; Tue, 27 Dec 2022 02:56:08 -0500
X-MC-Unique: vqWY112fOoK2XXVRfrkJPg-1
Received: by mail-ej1-f69.google.com with SMTP id ne1-20020a1709077b8100b007c198bb8c0eso8590919ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXIiVrztZsdU7pju6USGfTMhcaQjY/sBo8HpMhE5ZAA=;
        b=4WRgG4DUI8ik10chdl4NjRQeZHVy+WA2pC9TnNc77NXRzkieqga3hTshVHcBkPbJXG
         Up8MENxewcDlxSaAmT07bF1H0L7r0hUolKo/WUC2mNEHgdnnw2FCgNJjU3w6Qnp1SG5f
         x5nk1lO2K7l/a3vcDOssJS1+FBjRj1bZZZF5vCiJpRw9FSCk3j8JX13Pw/EsewufnDg4
         E4tJHTJ6jxKjNnor+P6BmZI6jwsSGwh3hPeLq0pyEYKc+zn3WgiRG7hsKtH6wtWSbT0e
         MVqVE+JyLpyt6yZekzcj03+lMQN0awqZSwj5gnkrGOtM+Z3Ybcjfg7f+1iiheY4KlGzR
         jFRw==
X-Gm-Message-State: AFqh2krh7vKJoD3n44hKtJUgBGRC57hYGISy24+afFWtoPqgZBO5beg8
        kZ8czWly8wXOhcN2/kK3XeJ+FGXMNHo92blmoVG2/R8PYdK38q9YUw9fHUs7GFCUTUsKIt46dMb
        06HlWJ/flWK59i2EyeVwJTg2O
X-Received: by 2002:a17:906:abc6:b0:7ad:d835:e822 with SMTP id kq6-20020a170906abc600b007add835e822mr19018391ejb.42.1672127767729;
        Mon, 26 Dec 2022 23:56:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVNGbHfVGyJQhVKDfEoIS76PHdndlS5IKd1waWV9EOOy+ytuh7yvRbAC+e0kyXprTc9YN9KA==
X-Received: by 2002:a17:906:abc6:b0:7ad:d835:e822 with SMTP id kq6-20020a170906abc600b007add835e822mr19018382ejb.42.1672127767500;
        Mon, 26 Dec 2022 23:56:07 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906684100b007c0f90a9cc5sm5716281ejs.105.2022.12.26.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 23:56:06 -0800 (PST)
Date:   Tue, 27 Dec 2022 02:56:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to
 vringh_kiov
Message-ID: <20221227025534-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
 <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
 <20221227020425-mutt-send-email-mst@kernel.org>
 <CANXvt5pXkS=TTOU0+Lkx6CjcV7xvDHRS6FbFikJ4Ww8832sg8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5pXkS=TTOU0+Lkx6CjcV7xvDHRS6FbFikJ4Ww8832sg8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 04:13:49PM +0900, Shunsuke Mie wrote:
> 2022年12月27日(火) 16:05 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Dec 27, 2022 at 02:04:03PM +0800, Jason Wang wrote:
> > > On Tue, Dec 27, 2022 at 10:25 AM Shunsuke Mie <mie@igel.co.jp> wrote:
> > > >
> > > > struct vringh_iov is defined to hold userland addresses. However, to use
> > > > common function, __vring_iov, finally the vringh_iov converts to the
> > > > vringh_kiov with simple cast. It includes compile time check code to make
> > > > sure it can be cast correctly.
> > > >
> > > > To simplify the code, this patch removes the struct vringh_iov and unifies
> > > > APIs to struct vringh_kiov.
> > > >
> > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > >
> > > While at this, I wonder if we need to go further, that is, switch to
> > > using an iov iterator instead of a vringh customized one.
> > >
> > > Thanks
> >
> > Possibly, but when doing changes like this one needs to be careful
> > to avoid breaking all the inlining tricks vringh relies on for
> > performance.
> Definitely, I'm evaluating the performance using vringh_test. I'll add a
> result of the evaluation. But, If there are other evaluation methods, could you
> please tell me?

high level tests over virtio blk and net are possible, but let's
start with vringh_test.

> > --
> > MST
> >
> 
> Best,
> Shunsuke

