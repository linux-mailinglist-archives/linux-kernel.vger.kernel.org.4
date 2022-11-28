Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67B763A065
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiK1EOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiK1ENs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:13:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B8D6575
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:13:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so13943903wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8biN610IG6cF6/xqgfdvBvEZJr3V5lZ2u/iXOKMw25c=;
        b=AeNsj1pKPeyg+SIWcMQHhoM7PKtpOOXUa96TqSseSpngwrapTAoI9AXE2sl0ZVS9KX
         Q4FGkmNiPGcJr2K1wujtY2fUpGZv9LaoNgLf82WJEq0yf0wJK9fvfWficshG0H7SMP0N
         4CFleZlpLnlbdf5y1qUG4wxp9IMamIdyytYZxA8ExoSLJxvi7RoT5SDvBSarapYlX7nJ
         6Gu1PQLYRsuagB7wI88QEi1cTqrhl9lJnJVG+br8OcktvvY5AcivvwVzChd9uLbXZiOH
         3oiMX4RAkWh0Sa0ATRvVVENmkJv3Kv+zdij5owWKmxxIdkxw2PcBFbqPtvSMxyjcLI/e
         an5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8biN610IG6cF6/xqgfdvBvEZJr3V5lZ2u/iXOKMw25c=;
        b=8BSTmO78f7t1Rh1nxftRRLr07KPurhVo6v/1B4UEHWLr12WgzNRY7dkaJ528hFn6wu
         ZRj4H4CzWLkWQJXoRy/49sB7qCb2DkSCNRVZ9n7QUuWcOofXsEmWlLiwIea3+b7GGgU8
         RfsukxVV/yue4mYMfmRs7nQJdqfL58cxVQkHUFokjkbra3m8wh4FrEsD75W80iFj417s
         WidrszHROiYjIlvJ2tWEWb4Y2Jesn5u/15l4hVc1U/p+g+NJ9jLQPARpqpJqVjvxrMvt
         awt2Z8NQd/7WTK6oB4WE01ZRb+PvU/rQWql0CXyRikH52hRacJ9kBJQvgpW2Gz6upTij
         71Fw==
X-Gm-Message-State: ANoB5pnBHybIlGGb35xS5j31V5JRSt1CroUPX6UN5ajV+0oahjY/OynT
        1ITQbpob1CdMF3aGDt3DtJA=
X-Google-Smtp-Source: AA0mqf6afd5S1XwVgpfCa/MZ2Ep0V6C9/AcwP41bJVg6WfRl46ndbc0RXBKKXsMofcHeHt9kYPgn4w==
X-Received: by 2002:adf:fb0e:0:b0:241:87cb:6e0c with SMTP id c14-20020adffb0e000000b0024187cb6e0cmr19497534wrr.166.1669608824229;
        Sun, 27 Nov 2022 20:13:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d6e42000000b0024194bba380sm9495337wrz.22.2022.11.27.20.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:13:43 -0800 (PST)
Date:   Mon, 28 Nov 2022 07:13:40 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com, Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Message-ID: <Y4Q1dOgAY3fWuZBn@kadam>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
 <20221126181822-mutt-send-email-mst@kernel.org>
 <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
 <20221127113416-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127113416-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, after you add the check to vduse_validate_config() you can test
that it silences the Smatch warning by doing:

kchecker --info drivers/vdpa/vdpa_user/vduse_dev.c | tee out
~/smatch/smatch_data/db/reload_partial.sh out
kchecker drivers/vdpa/vdpa_user/vduse_dev.c

You might need to do a second --info and reload for the changes to
propagate.

regards,
dan carpenter
