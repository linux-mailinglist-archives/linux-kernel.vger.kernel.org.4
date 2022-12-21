Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35CD652E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiLUIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiLUIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:50:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6C2098A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671612606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dBwPnF71tq2OBO2+/MVeKfW3ISUERpMcMh5zSeUYQo=;
        b=Dvwe/fgv3RdROeps1ZWhjDPLHSHBwevbfmt7eSB2Nzc53XzlRvHPQ7iyE4BLI/ntvzfkJG
        PmEmykTwOIWB2xPKOLcuuQO7ydgU3PENnNPS+tkaZNU9Qyy/dpADEx8VBFlj9AOwqnkZ/M
        tjTN2VjC35GFEkZMPiFFsn7vZ/cwS5A=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-DMI5Nkd9OoWoUZjxP2P4vQ-1; Wed, 21 Dec 2022 03:50:05 -0500
X-MC-Unique: DMI5Nkd9OoWoUZjxP2P4vQ-1
Received: by mail-oo1-f72.google.com with SMTP id v10-20020a4a860a000000b00480b3e2b5afso6664798ooh.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dBwPnF71tq2OBO2+/MVeKfW3ISUERpMcMh5zSeUYQo=;
        b=tlnUOT48O+Qa1f1NgKPIGiWMlZYRTreoa+lHuutLKe9K+v9SepKn8yFCSHJHX1oXnJ
         r4CiKG/7YnciVIt2sHwgJvcEZgTbV3OF5QXC6QhhXTrC73Rtfg6GSlRPDz+KJ/2cIYdl
         6Tl195zLG+o6Dlqv0d0TKr5PpV4cABePNUgT3RQjBkHw6NzuUgezBGBwyYPfGUKsHMOv
         o7W1uJ29lRF5IlQmUIocGxJJ4wfz8lPEa/njI4nZREFYSm3XrzaMAaGarxVMaKPlC3OV
         n0G15hREDnGcqZur5Cn1goerI0BjDGDXGLqnkwzXFvlNl/DJBoSYEARC9pZYKXBo7Pls
         bvAw==
X-Gm-Message-State: AFqh2kqpWE3s+jBQ2YRMlVa0HIEmwS9gLBoKjKLhknxdeoI2xF3Fis0Y
        IJpz/1q+iCYGHGqCjYh4PJgmLMHB/Mz9SEZFRazm+KBY+EHR/5ifVz5taC3AvOSeVjcf6q7aJAW
        q+lX4LFzyvTeKWrI+oBL9L0fo6+qhXw0lmITbhpXp
X-Received: by 2002:a4a:980c:0:b0:4a0:62e4:a192 with SMTP id y12-20020a4a980c000000b004a062e4a192mr51320ooi.78.1671612604601;
        Wed, 21 Dec 2022 00:50:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslyTOgeUlNt0sPUExCep8NUGSb37Gj09+Cg6gLHYKbelf9rY8DM5avfZcrkERlhspuorchfOA8RlSLk1PbuLE=
X-Received: by 2002:a4a:980c:0:b0:4a0:62e4:a192 with SMTP id
 y12-20020a4a980c000000b004a062e4a192mr51318ooi.78.1671612604440; Wed, 21 Dec
 2022 00:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20221220151415.856093-1-neelx@redhat.com> <9295b73a-5a3c-b1f6-d892-0da1d356ab9f@redhat.com>
In-Reply-To: <9295b73a-5a3c-b1f6-d892-0da1d356ab9f@redhat.com>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Wed, 21 Dec 2022 09:49:28 +0100
Message-ID: <CACjP9X90VT=sd_wT9MWg062qs=CRadsaj6V9gOMXSEJ7Up5Hzg@mail.gmail.com>
Subject: Re: [PATCH] cgroup/cpuset: no need to explicitly init a global static variable
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Dec 20, 2022 at 5:59 PM Waiman Long <longman@redhat.com> wrote:
>
> On 12/20/22 10:14, Daniel Vacek wrote:
> > cpuset_rwsem is a static variable. It's initialized at build time and so
> > there's no need for explicit runtime init leaking one percpu int.
>
> It will be clearer if you mention that DEFINE_STATIC_PERCPU_RWSEM() is
> used to set up cpuset_rwsem at build time. Other than that, the patch
> looks good to me.

That's true. I only figured later.
Whoever is going to apply it, feel free to amend the message if you like.

--nX

> Cheers,
> Longman
>

