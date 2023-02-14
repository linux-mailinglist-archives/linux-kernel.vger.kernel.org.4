Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7754569700A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjBNVtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBNVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:49:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5529E3F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:49:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so2203675pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K24hJmuuzDCWGJfa7cedDOeMiqAh7XOOikUOicrsYLk=;
        b=Nop4t4j/Ezoqqr7Wxz59BFFcsJEksG49eS0wzKJYp0Ewg6CRR2Z56e7MIKXOcTQroZ
         jmH+t/mxjQ/cE3U0i3+oUfIcqKyoLXqpDUBtpmA/0ewOc3LRubdiII7zMuWfo6pP5zs/
         U1qsI3khO4ndqEQ+91O3IXBhxmHP6OccfJk/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K24hJmuuzDCWGJfa7cedDOeMiqAh7XOOikUOicrsYLk=;
        b=GgxlEi7Arv1mzkRIefH7kDRwXblEqW6wBU3mxtooiRZ8EjZ/GITwNuLbFvVkmOMmLB
         J+ahHqxrofbMiFJ9hSvsLkVw7hQbLi7XO9ZXmyDTrMIyET8qfyM6o4qd/a0bKbHTtTI8
         sDXAll9ZTT2XKR8bLQfGC9lRQp8LP40zhhwYYK4QI+oOmKXNySw+SdUFSJLP28u5GYil
         oll7AhXkXv+p8gJKkxWLiEekIDnhkiP4DTcRj/gnlgdMerB+4qI9zbmrsSFFJb3nmGk1
         iaroPEpNRpNL98Q6K4vjSm7RySjNGxapySOCQSbVyskMzr5o54Clsa/XdySMUYSrhUvx
         ZijA==
X-Gm-Message-State: AO0yUKX4fThj0aFnCl38uC9KDseGy+w9GzKmGl1ecvs/dxszyk5l7tit
        mZTbZldwZ2EyGKiN2JBspX4xpA==
X-Google-Smtp-Source: AK7set9ijZSYts9u+A6XDClyLfPMQi8mabb6Pc9oedy/Kth90eU0jMozxH4xbvCYUALbaqjcfNSilA==
X-Received: by 2002:a17:90b:4b42:b0:234:5eb:2177 with SMTP id mi2-20020a17090b4b4200b0023405eb2177mr403521pjb.9.1676411376902;
        Tue, 14 Feb 2023 13:49:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q35-20020a17090a1b2600b002343bac52aesm30108pjq.7.2023.02.14.13.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:49:36 -0800 (PST)
Message-ID: <63ec01f0.170a0220.94c76.011e@mx.google.com>
X-Google-Original-Message-ID: <202302141348.@keescook>
Date:   Tue, 14 Feb 2023 13:49:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] scsi: ipr: work around fortify-string warning
References: <20230214132831.2118392-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214132831.2118392-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 02:28:08PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ipr_log_vpd_compact() function triggers a fortified memcpy() warning
> about a potential string overflow with all versions of clang:

Perhaps this is arch or config specific? I haven't been able to reproduce
this for some reason.

-- 
Kees Cook
