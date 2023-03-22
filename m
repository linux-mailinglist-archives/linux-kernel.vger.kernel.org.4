Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9316C4D42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjCVOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCVOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:16:02 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFE64244
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:15:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536af432ee5so341808437b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679494557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Whislchss/sFlCFTwP31713E4FxIStQL6qfZ4WUEnIc=;
        b=tzVmChHwG5UdzVVOpXkf2rTQATcV+/+zaZ4pw3uDOzqEhkRt5Ve9ob8pgqEPs/Y1fe
         UTg2YOvzk6LqHz80jJegh3QK/C6Nw5mUFmQRuYQdxN/g06L4n2D8VqGTpKrEwVLXCMyg
         bcLY5fticeZdjLAS82sbu5TBTjdYbbZWwVewaUa46wFZTPzT8Iaeq+jOe9TXtX5fDQhM
         bH0UkD0Bze72U3h9g4fm9xhtBi74DWE9y5/g7HVJ77mStLDJNqI5IlGO35ZFBslvbkdt
         0tnWP6LHWVGlPLgYq0+b9Iy7dVlw0jYqZHf1nX5ZUpvjRTg0T1AmjYqWQfawOzmxCgxb
         Ollg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whislchss/sFlCFTwP31713E4FxIStQL6qfZ4WUEnIc=;
        b=KvDzzV+WAm4Pgj7iNrW+T6bJ15zOQkeeaN0PPTTiJMAUHcLfspGCasfYyoZvsnLvNI
         gdX6FXShUdB3O9vQ8Sf6i2vkenqgKPKy1FY8z/xz07h00eioPmqiS7MsvuXcloRqQ63m
         OjYCvHQvoZecXU4GeEqDdhbiHM09FMEYGCXIWSOX9L1Ks9n2SgB7ZFOHg0BWaHAziZs/
         +HnkGh9r7LYGY1+ENyLrMQtKNONeGG0TBYBfhEPpljlUL58HBF4SjIbNeRu0/XOGwwMN
         O/0ijo08N9ywa3DSHVtLyafEROJo+pS6SRelK90z50jbTX/8uDwkf3QYZ9G366BSWCxq
         MZnA==
X-Gm-Message-State: AO0yUKWh+ULv50rt+v9ZW0U6a0pNYLxPhXEqL20D2SGnG463kWxVRBXu
        sRsiycxVgdJVVULCsPthblTN6NCKq5IBfBCzLx4GQA==
X-Google-Smtp-Source: AK7set867nYOJLPUXEWSXWMJFE/YmBaPwP8V/3k5TMR93AJK29UptcHHOv2RuPaUN5WddwnxgNj1hw==
X-Received: by 2002:a05:7500:5bc3:b0:fb:d3c:28fe with SMTP id ed3-20020a0575005bc300b000fb0d3c28femr62914gab.29.1679494556330;
        Wed, 22 Mar 2023 07:15:56 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id f66-20020a37d245000000b00745f3200f54sm11293540qkj.112.2023.03.22.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:15:55 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:15:53 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nbd: s/handle/cookie/
Message-ID: <20230321235250.GA1426669@localhost.localdomain>
References: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317202749.419094-1-eblake@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 03:27:44PM -0500, Eric Blake wrote:
> v1 was here: https://lkml.org/lkml/2023/3/10/1162
> since then:
> - split original 1/3 into 1/5 and 5/5
> - new patch 2/5
> - reorder members of anon union
> - always send cookie in network order
> 
> Eric Blake (5):
>   uapi nbd: improve doc links to userspace spec
>   block nbd: send handle in network order
>   uapi nbd: add cookie alias to handle
>   block nbd: use req.cookie instead of req.handle
>   docs nbd: userspace NBD now favors github over sourceforge
> 
>  Documentation/admin-guide/blockdev/nbd.rst |  2 +-
>  drivers/block/nbd.c                        |  6 +++---
>  include/uapi/linux/nbd.h                   | 25 +++++++++++++++++-----
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 8d3c682a5e3d9dfc2448ecbb22f4cd48359b9e21

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
