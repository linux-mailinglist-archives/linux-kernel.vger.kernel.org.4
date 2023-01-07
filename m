Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D0660D08
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjAGIhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjAGIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:36:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020D62E4;
        Sat,  7 Jan 2023 00:36:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m3so2571368wmq.0;
        Sat, 07 Jan 2023 00:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Kpmp5ViMXQZaBwFWZ1zqfOIbWm4lMVj5MdpfVpHf2I=;
        b=neQVFbf4EoP+oScH8OC24LRifXnt+vY6/gyroJsaeg7+8njaUfvkAzQzZcikIwpYHb
         TJW7EhnLmpstDJbkKfIIQUyRnquhzoj5hfSd7kXrq2XXjKldHl/oUzwvZrz2fydTai8P
         DWj+nicLFA6CEV1Qyf8UnSFTMjhh+DNtPE4Am7BiPk7p2s0juXtRp2JgTrX8O3c3/Keo
         g8gS+nTrzRJSbxHrGfcCCGpefvS/UoX3W1UYWJOtGx0LYKa9oFfbiepYx83wCs+8zViT
         eu6+smHsrGLdKdYZhwIxTmi1gQMI09DR+kYNzgQS7lOMrXS/EUCJ7jXhlewyEadsUDTU
         kbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kpmp5ViMXQZaBwFWZ1zqfOIbWm4lMVj5MdpfVpHf2I=;
        b=WfalXUyW4aeVCQg5PmpBijlod1UVX1DvBrvTDbtDG3R1YVpjpXHIG02vpzEuwbJHCY
         H65rzq6ACw6q5nF/i5HsQIVINYYm9Tfv5hP1HqQ8EHNf13dXo98biqrRRlB2iqA3mBpg
         vyiYQMUojGAtWs/jiduUaCvuTB+jsFEmjUVzJeWulY3LKurAqsUjc8JxqpEeX5sK3b7R
         2G/6fki0EhhhPrWZJK3nIbTKicFdfQOvnHA4YUKv8LYhvIwCGK76+kuydtWbFmtFxsn5
         GJzjV/7h4Q10rtfOOteM2b0Y0JCg1A+SyT+iwTCFRMjgeCq8D0JuHbg9gHGXq6IBYe7O
         VFWA==
X-Gm-Message-State: AFqh2kpXvO2VozFxjp20E4ERLGCtEE+ULYRYX14q3uEPlz/i4OawUmLf
        C1LFnTepcY41HC6mT1ktuBg=
X-Google-Smtp-Source: AMrXdXu+1UTGj9TxEIS1UXUF4nUQzygqcPHzx2yn1IcguqEi74bhpVFdZDeTbsu7IAO+wDxMcH96jA==
X-Received: by 2002:a05:600c:22ca:b0:3d1:ebdf:d586 with SMTP id 10-20020a05600c22ca00b003d1ebdfd586mr41267755wmg.29.1673080616209;
        Sat, 07 Jan 2023 00:36:56 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm4419716wmb.47.2023.01.07.00.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 00:36:55 -0800 (PST)
Date:   Sat, 7 Jan 2023 11:36:51 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep()
 from blk_put_queue()
Message-ID: <Y7kvI5BKiONibGow@kadam>
References: <Y7g3L6fntnTtOm63@kili>
 <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
 <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
 <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:45:12PM -0800, Luis Chamberlain wrote:
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://lkml.kernel.org/r/Y7g3L6fntnTtOm63@kili
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Fixes: e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal") # v5.9+
> 
> *tons* has changed since e8c7d14ac6c3 and so the bots might think that
> *if* this patch is applied upstream it is justified for older kernels
> and I don't think that's yet been verified and doubt it.

If you enable the correct debug option then the might_sleep() causes a
stack trace.  Eventually syzbot will find it.

I would backport it.

regards,
dan carpenter
