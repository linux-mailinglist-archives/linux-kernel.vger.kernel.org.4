Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B9709458
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjESKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjESKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:00:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7010D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:00:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae87bde5c9so2470835ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684490432; x=1687082432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxFT/eH6fI01yzQTav7apbXJs4Zkvkdbiyhdl2n33zI=;
        b=cvDpCNTPA3iJ2kdFkRCSMFHRtdReYV2KXQhy8iT3L9ZJ57nbIqLq8LmQb7Z118jA9Z
         SeD9I7cI3Y8OG8enSiToTsSgDB8PDXjPB4UZO1pcKN7MMHybvVarhYsNfDvDhCTgFGvb
         ZFPdyRXJ9FO6OyoWmqeWJD7xnpT4bdCerCbZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490432; x=1687082432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxFT/eH6fI01yzQTav7apbXJs4Zkvkdbiyhdl2n33zI=;
        b=Rc0nQxqLQ2DAOfJspjqqdKif+kCgR5LUo9Ed+SL5kj3+JJHJvhNlIz/PzZamAEOxDA
         JAMG+FqiRsogAquXSEBR2NgtI5B3iUsogwUngzKEANZqGgjUHv8pe86Jgm1aNXp7rXHX
         S4U9cd6L+7vVvA05fEOfZqr3VcfVfGkXVkGfFYMDv0WBjvIh4r6L/z8ctd5CDKRQRSmA
         UnWw628T+cgBW4sKVAwjlE6t7vntJke3xw1Hyd76SvsSW4Sve9a4IjwBsduLuHW0wi/0
         qMzcILzyy9zYth9+/JJ90AF5uba1Ac2o95umQgEdXNlWKB2O3WIOE1ZP9fCrRQZ+256B
         OyUQ==
X-Gm-Message-State: AC+VfDzPstNqQ9QqwIAXWaxy3Kvx/w2gXH0UKIlPKKljfsoPgcsSMrtb
        D5/Bt48cAgbytt/6AQgXqxQsfA==
X-Google-Smtp-Source: ACHHUZ65Vmg+CYxf6B2/ULrLmerlLS1jMd3W4m8M1xENFlfJroRC/2WxG/uzsCpP0fQnBk7vlkPoRQ==
X-Received: by 2002:a17:902:ef84:b0:1ad:bb42:7672 with SMTP id iz4-20020a170902ef8400b001adbb427672mr2227133plb.29.1684490430693;
        Fri, 19 May 2023 03:00:30 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001ab12545508sm3043029plm.67.2023.05.19.03.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:00:30 -0700 (PDT)
Date:   Fri, 19 May 2023 10:00:24 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        m.szyprowski@samsung.com, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, eagle.zhou@nxp.com, bin.liu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, daniel.almeida@collabora.com,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic
 allocated
Message-ID: <20230519100024.en7immda3jdj2wwq@chromium.org>
References: <4e2cb832-de83-4ba6-bd8a-119a19038cfe@kili.mountain>
 <a88b93cc-a81f-6186-09fc-02223867e677@collabora.com>
 <b0018f7b-0556-0ac1-d2fa-89787a27fba1@xs4all.nl>
 <20230324084830.GA18895@pendragon.ideasonboard.com>
 <d4b6ad10-1889-0a63-5a14-cb1320e2dc09@xs4all.nl>
 <7ad524a1-c54f-a01c-3453-2cf1f0f82a13@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad524a1-c54f-a01c-3453-2cf1f0f82a13@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:56:34AM +0100, Benjamin Gaignard wrote:
> 
> Le 24/03/2023 à 09:52, Hans Verkuil a écrit :
> > On 24/03/2023 09:48, Laurent Pinchart wrote:
> > > On Fri, Mar 24, 2023 at 09:31:35AM +0100, Hans Verkuil wrote:
> > > > On 24/03/2023 09:11, Benjamin Gaignard wrote:
> > > > > Le 24/03/2023 à 06:01, Dan Carpenter a écrit :
> > > > > > Hi Benjamin,
> > > > > > 
> > > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > > > 
> > > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
> > > > > > base:   git://linuxtv.org/media_tree.git master
> > > > > > patch link:    https://lore.kernel.org/r/20230321102855.346732-3-benjamin.gaignard%40collabora.com
> > > > > > patch subject: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic allocated
> > > > > > config: arm64-randconfig-m041-20230319 (https://download.01.org/0day-ci/archive/20230324/202303240148.lKRnUqW9-lkp@intel.com/config)
> > > > > > compiler: aarch64-linux-gcc (GCC) 12.1.0
> > > > > > 
> > > > > > If you fix the issue, kindly add following tag where applicable
> > > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > > > > | Link: https://lore.kernel.org/r/202303240148.lKRnUqW9-lkp@intel.com/
> > > > > > 
> > > > > > smatch warnings:
> > > > > > include/media/videobuf2-core.h:1272 vb2_queue_add_buffer() warn: sleeping in atomic context
> > > > > > drivers/media/common/videobuf2/videobuf2-core.c:2456 vb2_core_queue_init() warn: Please consider using kcalloc instead of kmalloc_array
> > > > > > 
> > > > > > vim +1272 include/media/videobuf2-core.h
> > > > > > 
> > > > > > 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1263  static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> > > > > > 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1264  {
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1265      bool ret = false;
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1266
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1267      spin_lock(&q->bufs_lock);
> > > > > >                                                           ^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > Holding a spin lock.
> > > > > > 
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1268
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1269      if (vb->index >= q->max_num_bufs) {
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1270          struct vb2_buffer **tmp;
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1271
> > > > > > 487d3f14d12ecf Benjamin Gaignard 2023-03-21 @1272          tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
> > > > > >                                                                                                                                        ^^^^^^^^^^
> > > > > > Sleeping allocation.  GFP_ATOMIC?  Or is there a way to move the
> > > > > > allocation outside the lock?
> > > > > I will add GFP_ATOMIC flag in next version.
> > > > No need. Instead, don't use realloc here, just allocate a new array, copy over all
> > > > the data from the old, and then switch q->bufs with the spinlock held. Then you
> > > > can free the old one.
> > > > 
> > > > It's only when you update q->bufs that you need the lock.
> > > The copy also needs to be protected by the lock.
> > I suspect that that is not needed, since you shouldn't be able to add buffers here
> > since a mutex should be held at this time.
> > 
> > That said, it's something that Benjamin needs to analyze.

I spent some time looking through the call sites of vb2_get_buffer() and
how those can be called and it turned out to be a massive list of code
paths, including a lot of calls originating from codec drivers calling
vb2_find_buffer() in random contexts (possibly even interrupt). So a
spinlock protecting the array pointer makes sense indeed.

> 
> Does using GFP_ATOMIC is problematic ?
> 

Yes, because the ability to reclaim memory is drastically limited and
the allocation is more likely to fail (as in: it's actually possible).
(And generally the time with interrupts disabled should be minimized to
keep system latency reasonable.)

Best regards,
Tomasz
