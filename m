Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C377367E1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjA0Kas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjA0Kaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:30:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8913503
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674815398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eca9c7qo8eB3nh6kdmgANWZsjB9aO/pdYCMOTO/h+eU=;
        b=QWWRBInaITrObn+JAaegiTBG4ExIK4j9u9HLPxO5tgDESPaz4a9eOEOwI556fxPnqrnN14
        z0oPMHvn8itQuvzRbMwZqsvxR8BMWW6lNNHy46vr8BRevgIknx4sgNvl2+Ifg1ux2XQtoD
        s1U0yYwvj9EOFS8axsgmfDFbFHOyidY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-cANPtElXPi-YWKkUOe0C_Q-1; Fri, 27 Jan 2023 05:29:53 -0500
X-MC-Unique: cANPtElXPi-YWKkUOe0C_Q-1
Received: by mail-ej1-f72.google.com with SMTP id ds1-20020a170907724100b008775bfcef62so3142138ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eca9c7qo8eB3nh6kdmgANWZsjB9aO/pdYCMOTO/h+eU=;
        b=Yn9PmtBGTRogdh4gXxfXb51E85QcpLh1kizFz6C202xx8blqEYIvK9zqsElUywaPud
         tG9/lGtekTtxbzH9wRxdA36ZV0SlTRE+7/bQCjFsb/mhhoEOSf7HgJ4C/bSNjngySdRu
         ih4S8Y+zAsNU81gNUdxsHVhLVd/b4e5PW54VP+mX7fEaKyovS81aevyG9yV0XiZf4pYg
         FevEe9c/RWKH1x8SJcR79Itwzgye3cHZCWwVj9FVqO9uihAL0Emgndh3xcONRs4xksY0
         ud5WCe/w8cYUrN3q05An2xD3TyEgcMlES+MOyLiX9hpDlxjXpJHKhi3w/lpl+jX1nP67
         m3kw==
X-Gm-Message-State: AO0yUKX0Oza0Y6YHXRWkyhq83f+Pbhm0f00UL3FgAF5m/P0TY69xFLYb
        bQ8iLePcfocAzt1ldMfPCnSWtQTW3Aot9Ki99Ax8zMsxeeiUrAGzGqoZPm7jHE7e6Pfr1TCw8qh
        LstKNtPs/+NgxqBIajM0C0OhH
X-Received: by 2002:a17:906:9d87:b0:878:4e6c:344e with SMTP id fq7-20020a1709069d8700b008784e6c344emr6281219ejc.43.1674815392032;
        Fri, 27 Jan 2023 02:29:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+h10ut0cxRycIemYstJmoZPh215OT9jfPTJWRHWUR+m3SZgGBEvC96RhqS9Ea/kSTQvU7ogg==
X-Received: by 2002:a17:906:9d87:b0:878:4e6c:344e with SMTP id fq7-20020a1709069d8700b008784e6c344emr6281202ejc.43.1674815391832;
        Fri, 27 Jan 2023 02:29:51 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id my20-20020a1709065a5400b00878465f059dsm1992805ejc.59.2023.01.27.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:29:51 -0800 (PST)
Date:   Fri, 27 Jan 2023 05:29:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, hch@lst.de
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
Message-ID: <20230127052843-mutt-send-email-mst@kernel.org>
References: <20221223060021.28011-1-jasowang@redhat.com>
 <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
 <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 12:12:42PM +0800, Jason Wang wrote:
> > >@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> > >       if (asid >= vdpasim->dev_attr.nas)
> > >               return -EINVAL;
> > >
> > >+      if (vdpasim->iommu_pt[asid]) {
> >
> > We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true,
> > should be better to return an error, since this case should not happen?
> 
> So it's a question of how to behave when unmap is called without a
> map. I think we can leave the code as is or if we wish, it needs a
> separate patch.
> 
> (We didn't error this previously anyhow).
> 
> Thanks

OK I picked as is. Do we want WARN_ON maybe?

-- 
MST

