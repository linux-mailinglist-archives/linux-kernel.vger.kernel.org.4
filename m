Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF767FCF2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjA2Fsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Fs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155B2195A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674971261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tphhCAxDZYJ2LTB6FYhPTBLXCb38alsFESQTQXvgBWs=;
        b=QsvHJKbpeOeeGehp9iPoGhyd7j15vBqXtofUTSrR80mCfmf5PR2MWRzul5Hc1cQgVwo5/C
        Fgiu/yMS6+TV2ugPTmV3k0phkwc2NFmAV+9/uUx8WzKGoMdLLuK5N4PjEVNtpzsMUcgNzB
        gvQqj8xql8AiaPOG+5HnXU+r4SK6Rvc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-yuCYb2mBOBujPjOika58FQ-1; Sun, 29 Jan 2023 00:47:34 -0500
X-MC-Unique: yuCYb2mBOBujPjOika58FQ-1
Received: by mail-oo1-f70.google.com with SMTP id r5-20020a4ad4c5000000b0051754772eeaso185748oos.20
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tphhCAxDZYJ2LTB6FYhPTBLXCb38alsFESQTQXvgBWs=;
        b=jRXEYVQD/VWrMMpeeeFDn00b5TBJxVXqZe22SqCY9GzTloFxPynzJkKwWMBGdI8FmP
         zoHx2aMi4I0czqLdxouKuBqF5TE01BG48W692/Ljmp8zvmIyAOKIRWibWbqvjv9o0SSL
         WfIaXTYb/rZkt3gM9/yvzGlvWzzQYo9BTPPV5L2o/no32Qx7o/ooUM8yjHrVyy19Zuls
         sFN37aGmSVqpt1PKm2kxYgOhw+K0u0V+nYuQffiYEGT8NyoHLDnPRJe4RLfjE4riMIPD
         fHA4ZorFiqhwk+o6y8X8Ocs5z6ZQPaoTVmy3y4spzMQnvavkkSfZMD67NoEqEWf0lJWk
         c4KA==
X-Gm-Message-State: AFqh2ko5MrojZ824e13LzQ82Eg+rBdykmOYbzgjVHsLsnRFJYwGQulRM
        FT+yr/4e2GHVLLepFp0S9MsWQMRJhijU0ZdYdAy+LCCtXQC446/L4cO2H+4K2p9pXgwR/VYZjo5
        DDhl0E3uhufoff0qgu9mxMLBpJFbZB5IAAsNpisNj
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id m126-20020aca3f84000000b0036ef5f8cce1mr789752oia.35.1674971253922;
        Sat, 28 Jan 2023 21:47:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4L143R3NJsjNmkthKVkYXMjUbXNs9jA0GlrAw7Vj0fC09s68MgNkw4fOiThtvdWjm/P7Isb2r/10/5A6QBh8=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr789748oia.35.1674971253564; Sat, 28
 Jan 2023 21:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20221223060021.28011-1-jasowang@redhat.com> <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
 <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com> <20230127052843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127052843-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 29 Jan 2023 13:47:22 +0800
Message-ID: <CACGkMEsPX7KswcrXodwZs6F+pv9JMBrj+bXcNqFi61v_bcLMnQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 6:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 26, 2022 at 12:12:42PM +0800, Jason Wang wrote:
> > > >@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> > > >       if (asid >= vdpasim->dev_attr.nas)
> > > >               return -EINVAL;
> > > >
> > > >+      if (vdpasim->iommu_pt[asid]) {
> > >
> > > We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true,
> > > should be better to return an error, since this case should not happen?
> >
> > So it's a question of how to behave when unmap is called without a
> > map. I think we can leave the code as is or if we wish, it needs a
> > separate patch.
> >
> > (We didn't error this previously anyhow).
> >
> > Thanks
>
> OK I picked as is. Do we want WARN_ON maybe?

This could be triggered by the userspace, so I'm not sure it's worth it.

Thanks

>
> --
> MST
>

