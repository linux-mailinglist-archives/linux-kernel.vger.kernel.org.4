Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3B6567B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiL0HGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiL0HGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79B2609
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672124749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6B+5aJ0Guf5xJnrVgDQJOLVwGWWIObpNI/iqDeXCf0=;
        b=KdY9hD5i5pcWzts+WRUbCqnDwAz+dNmI5AX++W+a4OFquHWxzIyggtQ1e33pJbuRIWy+tG
        nPKzQeBIm6dWJk6VKnTKkb3oOyOcZ3zJ/0yJuDwurstcNUwwl29XE0SD1DlT4JQi06WGmb
        IQjkPqeL34f1prsTJGosRRTVKIJo0hI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-3v7Hs2HMOd6s4v6EMUFvMQ-1; Tue, 27 Dec 2022 02:05:47 -0500
X-MC-Unique: 3v7Hs2HMOd6s4v6EMUFvMQ-1
Received: by mail-wr1-f69.google.com with SMTP id d6-20020adfa346000000b0024211c0f988so1647367wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6B+5aJ0Guf5xJnrVgDQJOLVwGWWIObpNI/iqDeXCf0=;
        b=dvUYj8s/XbbFuECRCVVBz26xqSOyJuPwuzjOAw8CniO5njaq8z4BxgEoI+6j6D4aD2
         shh8vj2RR0x/3RfAhGvDYZjYT6gGiUf9l4AxZhknt1EpNapCQZKwb0UWsa2nKJ87o0MR
         DkBmej9uNQOj4PMH849fOv2NJwSRgANpal9/AM4laShv/0OSJqiaudENuSwiqvu3dcA9
         qc4djnZKOft85CiYqgLkr2IQmy8cUbWjdcnSR0Z9LMsKTctxDV6Vg3Yf8OOcju/Ry7w4
         q8MnffP3X5VMESE/prjbeM3LVWbPK+Zm/3MecFv1UvIrb3/yDGTbV8z54TAIytexKsRf
         SuPA==
X-Gm-Message-State: AFqh2kqvX3tArFVouSGWluqL6IRCJJdqeTTZilBvfmb6e+FjMhpFrkry
        RFZ6ylIqy+6kN0gdLX9+uG/TrGARURtmhh9ytKlAIgd5r1f1Fwt9OPVDR7CKjTN8Wm2/btCr8J5
        zp//Emw0QjGV+BR/IT8Hozg9+
X-Received: by 2002:a05:600c:3789:b0:3d1:f234:12cc with SMTP id o9-20020a05600c378900b003d1f23412ccmr14917380wmr.33.1672124746367;
        Mon, 26 Dec 2022 23:05:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7VxVFTlp1bWTB6ltmdqn/ESzBZWCVVlTMmPA5egsFORFko71Rv1M6SSn/w7ah7B/gMr/N1w==
X-Received: by 2002:a05:600c:3789:b0:3d1:f234:12cc with SMTP id o9-20020a05600c378900b003d1f23412ccmr14917367wmr.33.1672124746164;
        Mon, 26 Dec 2022 23:05:46 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003d359aa353csm15894121wmb.45.2022.12.26.23.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 23:05:45 -0800 (PST)
Date:   Tue, 27 Dec 2022 02:05:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to
 vringh_kiov
Message-ID: <20221227020425-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
 <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 02:04:03PM +0800, Jason Wang wrote:
> On Tue, Dec 27, 2022 at 10:25 AM Shunsuke Mie <mie@igel.co.jp> wrote:
> >
> > struct vringh_iov is defined to hold userland addresses. However, to use
> > common function, __vring_iov, finally the vringh_iov converts to the
> > vringh_kiov with simple cast. It includes compile time check code to make
> > sure it can be cast correctly.
> >
> > To simplify the code, this patch removes the struct vringh_iov and unifies
> > APIs to struct vringh_kiov.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> 
> While at this, I wonder if we need to go further, that is, switch to
> using an iov iterator instead of a vringh customized one.
> 
> Thanks

Possibly, but when doing changes like this one needs to be careful
to avoid breaking all the inlining tricks vringh relies on for
performance.

-- 
MST

