Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF376D1630
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCaEGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaEGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:06:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096EEC76
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:06:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso24125348pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680235564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQi3ts4AtbQXr7O97Iyh1MT9Vc4OCSBMmMoqYVWvSdw=;
        b=BC5MKj5C11A1fpqalr4OsdYX7pU2qkXaezZ8PICniK0xNX+Viu6u/Hhiu/51tJn7wC
         b571Am7PxDh7Ag7J0R+MUiJs/75F4xmqiDJAo/JToqrse6BivboLnAIeXlKlKrzXcWtR
         xivFyk/wm1hrQlKcNz3gBTOmVqf4h3GhFi40k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680235564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQi3ts4AtbQXr7O97Iyh1MT9Vc4OCSBMmMoqYVWvSdw=;
        b=BAYX4/WHYHBfVGj9ylyZsdpKbbxnozJd3CE5t3Hhu9mT01Onnb+OkV4qDqv5UHKzd+
         K+4lpEc+koBk4Hl7Sz2l+b6FCq0EKaXvquR3VWIB1IBqWA/C7sWRdw4n+oqbqvTTuYlf
         dPGCkBmIzJpr/HBkhY17MCa5Sdy3m8X5kfJqrn0lU0RiN/PfwP0AJZR8PZ+yIjMNU7T6
         RAnnH8JpUcMAKRyhiPtynZXsJI2uvjofVCbE/hVTPri4/X4/wwa7pGvrzpxJ4jKMpKpT
         BVU4KBog9FlOS086qKAuOsJ+0eXRdBX7x7Aik3ZWz1h5CxDXOS+yIFTToVeatEbZjvkT
         jdTg==
X-Gm-Message-State: AO0yUKWEkhQumVl/L+ZFU8+ZN7tUSCosIhnZg8954id6uCMST6SvseHu
        K0pA6l2F+58uf2XApbkEzRvSLA==
X-Google-Smtp-Source: AK7set++xuMdgde4LUlcfnhqa8GigmuJkwEX4KHN0n7oAr9WWDs6jNHugQpku3K1N0cCxeyWtDK1gg==
X-Received: by 2002:a05:6a20:1221:b0:d9:5a7c:b1c5 with SMTP id v33-20020a056a20122100b000d95a7cb1c5mr22606007pzf.11.1680235564283;
        Thu, 30 Mar 2023 21:06:04 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b005a9ea5d43ddsm636512pfh.174.2023.03.30.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 21:06:03 -0700 (PDT)
Date:   Fri, 31 Mar 2023 13:05:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove obsoleted check for non-existent "user"
 object
Message-ID: <20230331040559.GB12892@google.com>
References: <167929571877.2810.9926967619100618792.stgit@skinsburskii.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167929571877.2810.9926967619100618792.stgit@skinsburskii.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/20 00:02), Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>
> 
> The original check for non-null "user" object was introduced by commit
> e11fea92e13f ("kmsg: export printk records to the /dev/kmsg interface") when
> "user" could be NULL if /dev/ksmg was opened for writing.
> 
> Subsequent change 750afe7babd1 ("printk: add kernel parameter to control
> writes to /dev/kmsg") made "user" context required for files opened for write,
> but didn't remove now redundant checks for it to be non-NULL.
> 
> This patch removes the dead code while preserving the current logic.
> 
> Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>
> CC: Petr Mladek <pmladek@suse.com>
> CC: Sergey Senozhatsky <senozhatsky@chromium.org>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: John Ogness <john.ogness@linutronix.de>
> CC: linux-kernel@vger.kernel.org

Looks like we should be fine
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
