Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D346D66B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjDDPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjDDPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:04:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96F35BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:04:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so2362906wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680620643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBdBtzyHFd6lc83YrQIneyeohpNPTJ/y3GLkeIJnfvo=;
        b=gkpaUlEImekGGm0xeTEjW/sQV7ex2AWGhlLK447E4ZfuKspHi6VwBheI3NIGcQxJRm
         wD2o1vYPxVT5hXvusr8G5O11sBeKOkAay9cpQIurpmU86sryhDrBYL17lkjWCguGZrtz
         emLFUqUlZcoDLML3HklU6z19yXOsrh74oN9O6QsqbhILv5Xv+kKxWgZsxgBSnsczwJuM
         pvXfOMmpwz3WbDCw2n2qfy40UD+zc3+Rv7XfNUX6kvHOvYCqMdDdgMsSH2oZqjrxyw9w
         7cdGd4UXjjkFQDmo11zUBb6SLI0ErWduKUWK2Ac5UK/VMiVEA6P1LpLiV9h0nAmzIOD0
         7o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBdBtzyHFd6lc83YrQIneyeohpNPTJ/y3GLkeIJnfvo=;
        b=DYJUJ/ubUilz1++K7WwPT+mYrQz6GqZqrXhC31tajErGMlsp+HYefFB2xfxEBwHXIo
         yM0aXEn/QnYdnddEWzHM+vyf5QOair0e8rEzOCFWuE+f0gU7b6DeiMU6O53kCIIdgaa9
         TNjz0r9FcvFMdFnzmXi16p3NEHfQr5ai/b8rp5vRTAzKDan0oXbnQipT/xQkxqVoEreX
         VFz0PPXVL/XwhYgcsk69JLOm8GXdOHKlkRpn717N7IOQazWTo2nMxQ/5V6o+T9AfI4Mb
         waYhUxiCtEnJ61EOfbbZqkQ/9tgzVSJDhtBnIcYESGyFbxoh8Ksu7RGN9cTcH0Z7QO3N
         6JPQ==
X-Gm-Message-State: AAQBX9f3DOCiZADFfumrBWrWVebDTWTSmsrz4GUBsiytW+4+drELWDn0
        8SiFyRUHi1yly1rN0UmMPYYWvWIPIpgVqQ==
X-Google-Smtp-Source: AKy350bNnmlpCILUHmdUFYCLAb/iqR3do08Nj32nLRxLYpqec4RmcscQRBFttmaJwosh4wJ7chwjog==
X-Received: by 2002:a05:600c:3646:b0:3ed:9ed7:d676 with SMTP id y6-20020a05600c364600b003ed9ed7d676mr2446609wmq.13.1680620642903;
        Tue, 04 Apr 2023 08:04:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003ef5bb63f13sm23180970wms.10.2023.04.04.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:04:02 -0700 (PDT)
Date:   Tue, 4 Apr 2023 18:03:58 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philip Li <philip.li@intel.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev,
        Heming Zhao via Ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error
 code 'status'
Message-ID: <c6304335-9b5f-4082-b804-e754cf77ce0c@kili.mountain>
References: <9e1d6835-34fc-49cd-869e-d99d9b546d17@kili.mountain>
 <4154b815-3be4-53de-1bc0-ca87ecb925a4@linux.alibaba.com>
 <1e7d7076-ddd6-41b3-b824-673986c35477@kili.mountain>
 <ZCw5Ucw5CS6nXosr@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCw5Ucw5CS6nXosr@rli9-mobl>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:50:57PM +0800, Philip Li wrote:
> On Mon, Apr 03, 2023 at 02:20:55PM +0300, Dan Carpenter wrote:
> > Sorry, the kbuild bot is not supposed to send duplicate warnings.  I
> > don't know why it was sent again...
> 
> Sorry about this, we should ignore this commit in the bot. Now it is configured
> to avoid the false positive report.
> 

Fantastic.  Thanks, Philip!

regards,
dan carpenter

