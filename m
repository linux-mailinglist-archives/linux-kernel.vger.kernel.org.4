Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E127675980
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjATQGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A33B3D0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674230728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2Ykr4AjAONNT7kvDNwi4NL3fIdbk4VvZOuGIqx3cB4=;
        b=hge9e3Q/2n6NAXPR5yZQl6Ak6Ae7VNn+ywGk/e25HCvshNil0pOXyho+GMgm7t7xgblJmu
        arENv17c8dXVnojW93O9S448wOrLe5+kA29TT3o/T3kk7Prg3ygpBvExg4uOeCg+hZ7fA4
        BYbySwSFHbKuz/fa6A4EMe4JFEkge4g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-O4Z-hXYUPnCHqQZcNaR1Xg-1; Fri, 20 Jan 2023 11:05:27 -0500
X-MC-Unique: O4Z-hXYUPnCHqQZcNaR1Xg-1
Received: by mail-io1-f72.google.com with SMTP id g1-20020a5ec741000000b00704c92572b1so3098408iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2Ykr4AjAONNT7kvDNwi4NL3fIdbk4VvZOuGIqx3cB4=;
        b=IRVvjX4Q3OvJW4hYRXpQbxyo5OZYxrkZtbqahJD+cXg1Mu1Pe7KpPr5btBiqAaypMJ
         99R8hb4Y9eUGBxrImI93gT+O6NM+yhYUgsjHCWj8i6Frm23UDpltPAMpdzTQBazLWCgK
         GIE0VSLfkvzUlSedR2GDbb1KWDGnQYtoeXCDdZbVV1wedwIDR5icIwOBtgB5EXOC6MRN
         FRAhLXjjwRGSFwiYTQ83X4gW6XWDgF9OMrCL0Id372HjeWCvsyqdBeQWsKiMNc/28lBn
         e9IakTAQNL3DpiTri4T4ihMgPhPhg0PfmPv/qT2ulK8oP1k51hTrxFeW2cyV9sE4VQeE
         pNKQ==
X-Gm-Message-State: AFqh2kr9QDHTkMI7eFYXpDpnRA6qUy763xVtHnXB9Y0K/EaeVLdkyIlq
        V4owdaJTk5V16hQ+DaU2Gi+7zVjLl05L4SyNFw3chJo89kHdm5KDWi42+s1/645U+s+GKfPTx2D
        bUAm1qNtUTcRKhdILmPTaSFQr
X-Received: by 2002:a92:d489:0:b0:30d:bc94:7da6 with SMTP id p9-20020a92d489000000b0030dbc947da6mr11598281ilg.19.1674230726459;
        Fri, 20 Jan 2023 08:05:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAKBQccJ8QiFH48BvXOtBLQDew3xVVxws4W+b3F41bojnj94kXcOj3OcDy2eJ5mkQjNmmCvg==
X-Received: by 2002:a92:d489:0:b0:30d:bc94:7da6 with SMTP id p9-20020a92d489000000b0030dbc947da6mr11598256ilg.19.1674230726228;
        Fri, 20 Jan 2023 08:05:26 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id n1-20020a056638120100b0039e8e0ecbcbsm10363097jas.64.2023.01.20.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 08:05:25 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:05:23 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk, alexl@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH v3 2/2] selftests: add tests for prctl(SET_HIDE_SELF_EXE)
Message-ID: <Y8q7w7VXpijqWILs@x1>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230120102512.3195094-2-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120102512.3195094-2-gscrivan@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:25:12AM +0100, Giuseppe Scrivano wrote:
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

The other patch looks reasonable to me. I'm not familiar with this part
of the kernel so I'm not going to leave a R-b tag on it.

> --- /dev/null
> +++ b/tools/testing/selftests/prctl/hide-self-exe.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tests for prctl(PR_GET_HIDE_SELF_EXE, ...) / prctl(PR_SET_HIDE_SELF_EXE, ...)
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <inttypes.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/wait.h>
> +
> +#include <sys/prctl.h>
> +#include <linux/prctl.h>

Just a minor nit if you need to post a v4: Sort the includes by name.

Brian

