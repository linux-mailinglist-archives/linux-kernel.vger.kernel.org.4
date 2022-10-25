Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1BC60C81E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJYJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiJYJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:30:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C72DAA8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:30:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f27so379023eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCSyuyQGpNlpd6dhjpOf9Qc4lZVxImyObiEpJP1xQh8=;
        b=TwXVFt1/Pqv27w/D+1kMCKoXoabMRQO3isas+A0kXa7tJPb5eSctRVpxnD6mIKJ5Lg
         rIiT5zttRRLzyLSytPpELrTt9i32DE5wCsCN1QySp4Jrq8RpEunimrqfwbxX4djqw4sT
         fc/nfmk8md450r262nPGyJ1AQL5iT50wFMHWOaiR/kEfFCuu8vKxUxStCIz0GEUUyxqN
         h9oqYGBVrkj+06T9/wg2ZGv6ibRhd9Y3UT15FBHXzEEDtcbQgA80754Eoye65K3mZEyY
         bCjwdbP2CSk1hzhmOz1m73HHV9+aRmr3woxzvBplooS1t5QXgu9tNuiu/0FoHDIphwe+
         9w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCSyuyQGpNlpd6dhjpOf9Qc4lZVxImyObiEpJP1xQh8=;
        b=HNFpY6ddclmXijFGGVNlkJmyBxJRKYQTdzK5kmLxrfy9pyRSQ6FMmpafzYZq/HJcX3
         nGk8DeIOMoA8kWCUiq9wQ1vStxOH9ctYqpRqR8ZzB8bEtEmK6RtsxvxLciY+EgIjo/eY
         Us1E7g5bwj1/rmz5yfnw3avu3kmRcpMYL95g05G/FIXLD807f8Q6qeQPu0BEDQ5oFOhY
         f4eAFe8u3eYhjAAuyIdPQeeLbbxu3OJ0ki4whEHhlfD+gDDuwWR3LlMu2bYtPUvCRdvU
         Won3vlL1nDLQ46KhTK89aqiU714ekYrH8wz7oZ2uizzTktTIonFJrNnv2qJJs1kbqDst
         7/Lg==
X-Gm-Message-State: ACrzQf1y7OTd6yobzVhmb4SUnFn3BdmUUGhK8AbtWGVXdA40K1HRLWla
        DqV88fRG5/zHuB9eSZyqeWw=
X-Google-Smtp-Source: AMsMyM4CXGFAEp1wVI6ujd95isc8QgYUQQBOGKhUFJZxr1hHQK+nnUiXH0R6Z9XX2ofECC5OY/TUxw==
X-Received: by 2002:a17:907:7245:b0:78d:ec9c:e743 with SMTP id ds5-20020a170907724500b0078dec9ce743mr32347841ejc.466.1666690228578;
        Tue, 25 Oct 2022 02:30:28 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b00788c622fa2csm1076361ejc.135.2022.10.25.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:30:28 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:30:16 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Message-ID: <20221025092737.GA254308@nam-dell>
References: <20221022174635.15643-1-namcaov@gmail.com>
 <810f1de0-769c-ce67-4ec6-007ce25acfe0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <810f1de0-769c-ce67-4ec6-007ce25acfe0@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:58:41AM +0000, Chaitanya Kulkarni wrote:
> On 10/22/22 10:46, Nam Cao wrote:
> > In nvme_tcp_ddgst_update(), sg_init_marker() is called with an
> > uninitialized scatterlist. This is probably fine, but gcc complains:
> > 
> >    CC [M]  drivers/nvme/host/tcp.o
> > In file included from ./include/linux/dma-mapping.h:10,
> >                   from ./include/linux/skbuff.h:31,
> >                   from ./include/net/net_namespace.h:43,
> >                   from ./include/linux/netdevice.h:38,
> >                   from ./include/net/sock.h:46,
> >                   from drivers/nvme/host/tcp.c:12:
> > In function ‘sg_mark_end’,
> >      inlined from ‘sg_init_marker’ at ./include/linux/scatterlist.h:356:2,
> >      inlined from ‘nvme_tcp_ddgst_update’ at drivers/nvme/host/tcp.c:390:2:
> > ./include/linux/scatterlist.h:234:11: error: ‘sg.page_link’ is used uninitialized [-Werror=uninitialized]
> >    234 |         sg->page_link |= SG_END;
> >        |         ~~^~~~~~~~~~~
> > drivers/nvme/host/tcp.c: In function ‘nvme_tcp_ddgst_update’:
> > drivers/nvme/host/tcp.c:388:28: note: ‘sg’ declared here
> >    388 |         struct scatterlist sg;
> >        |                            ^~
> > cc1: all warnings being treated as errors
> > 
> > Use sg_init_table() instead, which basically memset the scatterlist to
> > zero first before calling sg_init_marker().
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> 
> Looks good to me, can you please share what version if gcc you are
> using ? my test setup did not catch this error and I'd like to update
> with the one that can catch these errors.

It was just gcc12. But strange enough I cannot trigger this error again.
I was doing randconfig test build. Probably only a specific combination
of configs that can allow gcc to detect this...

And sorry but I was just start doing randconfig test and didn't think
about saving that .config file.

Best regards,
Nam

