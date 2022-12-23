Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358F2655517
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 23:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiLWW2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 17:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiLWW2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B81DF2D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671834472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NtRKjrrbYIdgIGkqJ3VqinENOoahNs+OyBFqva7XmGo=;
        b=CcHGQm2e54rza0lfn/yfWTKLdGZ++AS4xm8UBx9NB45MQLP/TAxsvmEuWTgoEmn8c5y/fn
        /bJOcPrEz1ekWmRMD0J43ZL4WqdRnHWQS09vyiCHBHxLgYOPKmegzrKQF1jhyFRgOup7qr
        X0NflEAkTfqG86TTXJPwpASTFAtFkWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280-1tpW7_7QMyOkECm5_KlcMw-1; Fri, 23 Dec 2022 17:27:50 -0500
X-MC-Unique: 1tpW7_7QMyOkECm5_KlcMw-1
Received: by mail-wm1-f72.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso2836846wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtRKjrrbYIdgIGkqJ3VqinENOoahNs+OyBFqva7XmGo=;
        b=xpU9LK8m3QRpYW46eCPUZt3j8YiQI6DO5bDSXLfS7oKd8Rt7PUGQZ67+ahPCKrkkOp
         u+uw+Q0dLDeb+7adUeVB6hwFXz5KadH0+XLMxkU9tKWr4wO5lGRiyeSshSmYTDfUT9kV
         h63bhPD6VMztG0NiCnHMgu4THTREOe+r4XvjDO/LS51RKLQT6Iv6VkaE3VizrpEgak20
         POZWKRTe6AmFdcsd/G48csiAtbH8/PFpfBiXMqFi2zViBuuTku1TxlXNTbITizEb2bJy
         bPNImGayGsOpClTVP92PF6KFxd7Xv1lhkenu/Zp8hZdVTwCb4wDzSgD0hH1izA5yw8Tk
         0sbw==
X-Gm-Message-State: AFqh2kqwpww0EQlasF1cXsp/OGmYUTeVGRBl9ezveQUtO48cPGpfeOlj
        qt3U1G69x38DO7onm07nrQAWk6H2qUFfEAeYIOcUXQOTRZ+WN0LXVDTTVHMk7WPBTzZbh2SvNTW
        J7mAmvEG6YrAGVV09eWrkd35q
X-Received: by 2002:a1c:770b:0:b0:3cf:a18d:399c with SMTP id t11-20020a1c770b000000b003cfa18d399cmr8706231wmi.1.1671834468910;
        Fri, 23 Dec 2022 14:27:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtypUNzb7VgDxwSmNV5kkZqdNzHIvqFLFIqRXIsvO8K841mwmSg7ycczPWKeRCh2AE62HTTFw==
X-Received: by 2002:a1c:770b:0:b0:3cf:a18d:399c with SMTP id t11-20020a1c770b000000b003cfa18d399cmr8706186wmi.1.1671834468656;
        Fri, 23 Dec 2022 14:27:48 -0800 (PST)
Received: from redhat.com ([2.55.175.215])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003d355ad9bb7sm11729817wmq.20.2022.12.23.14.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 14:27:47 -0800 (PST)
Date:   Fri, 23 Dec 2022 17:27:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        almasrymina@google.com, alvaro.karsz@solid-run.com,
        anders.roxell@linaro.org, angus.chen@jaguarmicro.com,
        bobby.eshleman@bytedance.com, colin.i.king@gmail.com,
        dave@stgolabs.net, dengshaomin@cdjrlc.com, dmitry.fomichev@wdc.com,
        elic@nvidia.com, eperezma@redhat.com, gautam.dawar@xilinx.com,
        harshit.m.mogalapalli@oracle.com, jasowang@redhat.com,
        leiyang@redhat.com, lingshan.zhu@intel.com, lkft@linaro.org,
        lulu@redhat.com, m.szyprowski@samsung.com, nathan@kernel.org,
        pabeni@redhat.com, pizhenwei@bytedance.com, rafaelmendsr@gmail.com,
        ricardo.canuelo@collabora.com, ruanjinjie@huawei.com,
        sammler@google.com, set_pte_at@outlook.com, sfr@canb.auug.org.au,
        sgarzare@redhat.com, shaoqin.huang@intel.com,
        si-wei.liu@oracle.com, stable@vger.kernel.org, stefanha@gmail.com,
        sunnanyong@huawei.com, wangjianli@cdjrlc.com,
        wangrong68@huawei.com, weiyongjun1@huawei.com,
        xuanzhuo@linux.alibaba.com, yuancan@huawei.com
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20221223172549-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:54:41AM -0800, Linus Torvalds wrote:
> On Thu, Dec 22, 2022 at 11:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> I see none of this in linux-next.
> 
>                Linus

They were all there, just not as these commits, as I squashed fixups to
avoid bisect breakages with some configs. Did I do wrong?

-- 
MST

