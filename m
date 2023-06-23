Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3773AFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFWF0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFWF0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:26:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D5C2136
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:26:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b512309c86so2230615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687497961; x=1690089961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I74A3FzNlMiWSwenHJ0qW6K9Kk3RrnXa52gDQFbNI94=;
        b=FE8O7Vw+I3Rj3/ymdkfv8Bc+lpDZ080s6kF+VZ6KYuJ8IcvSDzEvJHrYtehbevzDKJ
         k39KSog3mD45RBSDswKQweqzUA8WL0SL0uOXty3tY4QBaCgZzpYfPiVwVN0bS3NDj5Wp
         Vlnc7que1gB/FOXny+Xqd3OrpA8296BqQ44lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687497961; x=1690089961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I74A3FzNlMiWSwenHJ0qW6K9Kk3RrnXa52gDQFbNI94=;
        b=I/NP36SOxIKGHTNT0HcFjl1qjrY3INvEpE60bXDi0rDiz7NBcPBRerVATkKc/4InEA
         JqzzGFRLP5zdrbFtuJeUL8jcwj5KcZfXujXV0o5TBz2qNt4KnlVaXoVulV0sjwgQcLzn
         91K4wEOY+E5Z+2SzMUTzizOCTTGFp/+wOI8sZc2hu28AIc6ue19Y8mZQ1GnBK5H1IKft
         E4jLCQBYcA3SbrZyHIGAUBJyhWj1jf0gQFmLQ52Vdob8orZrJ/DN2TDECB/sPI0Y0jyh
         Xs0sL1ZE7zYRAIoasvM1Jy+IjRWpk3Tf4qYuQmI+HScpDX7Vt0+ONjMlzOby4r3SvAXd
         /h3w==
X-Gm-Message-State: AC+VfDwkWz9Chq1ehn0zho5Z8zK4kudKIs364TYDUFEpx1vz+9q4SLnm
        ORWu7NHqiqzmYFB4ToE4XHTsBw==
X-Google-Smtp-Source: ACHHUZ5sPbLx4vVXAJjIGembGjCJJyMTydKicDo1snyQX4c1P9pglVj/z3vqORh1yZ2I9l32bGJbWQ==
X-Received: by 2002:a17:902:ecc6:b0:1ae:8fa:cd4c with SMTP id a6-20020a170902ecc600b001ae08facd4cmr41235916plh.7.1687497961344;
        Thu, 22 Jun 2023 22:26:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b00192aa53a7d5sm6288753plg.8.2023.06.22.22.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:26:00 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:25:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/29] mm: shrinker: move shrinker-related code into a
 separate file
Message-ID: <20230623052554.GA11471@google.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-30-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622085335.77010-30-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/22 16:53), Qi Zheng wrote:
> +/*
> + * Remove one
> + */
> +void unregister_shrinker(struct shrinker *shrinker)
> +{
> +	struct dentry *debugfs_entry;
> +	int debugfs_id;
> +
> +	if (!(shrinker->flags & SHRINKER_REGISTERED))
> +		return;
> +
> +	shrinker_put(shrinker);
> +	wait_for_completion(&shrinker->completion_wait);
> +
> +	mutex_lock(&shrinker_mutex);
> +	list_del_rcu(&shrinker->list);

Should this function wait for RCU grace period(s) before it goes
touching shrinker fields?

> +	shrinker->flags &= ~SHRINKER_REGISTERED;
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
> +	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> +	mutex_unlock(&shrinker_mutex);
> +
> +	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
> +
> +	kfree(shrinker->nr_deferred);
> +	shrinker->nr_deferred = NULL;
> +}
> +EXPORT_SYMBOL(unregister_shrinker);

[..]

> +void shrinker_free(struct shrinker *shrinker)
> +{
> +	kfree(shrinker);
> +}
> +EXPORT_SYMBOL(shrinker_free);
> +
> +void unregister_and_free_shrinker(struct shrinker *shrinker)
> +{
> +	unregister_shrinker(shrinker);
> +	kfree_rcu(shrinker, rcu);
> +}

Seems like this

	unregister_shrinker();
	shrinker_free();

is not exact equivalent of this

	unregister_and_free_shrinker();
