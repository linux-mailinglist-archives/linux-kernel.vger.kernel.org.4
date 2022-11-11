Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E7625160
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiKKDPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiKKDPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:15:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87FC760
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:15:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v28so3774572pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwfTiLzBNiq3UGSuRV53jnzzUVq8yp9gLs6VSoyYYIY=;
        b=gZCI8KVjBN7kl3vowgoO723z9038r1Q7Rn824uf1rMAzO0KPmQmYS9isn/OEPBSsHO
         zqAHD0ToyrZis6ESaYLdJB/CrYW2eQk/qY9eKlpAmGIGLtdM+yhpN7Y6RZTOz8SJ9h5u
         XE2xv1pKPkSpLbPoeUm/+tihq4ihjbcCBwBv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwfTiLzBNiq3UGSuRV53jnzzUVq8yp9gLs6VSoyYYIY=;
        b=4yDK7/eV+6YsvNU/AIxRyoTn8O6vh1iMCRG1+iL/oKd3C9Rzf4Tn1sbYOztVN8kXV0
         l8Z/21o5vuqq0RvjEE3aQ3c2tTEQvjHP1Yxo6cxp8ootX9LM5wK9xr7bUBaq2ws1YoSD
         zprqNxExYcPGIPBjavCu2+1RQMek8pyOCc5EDHnPBH66Skw5qjfuWJgzaVam3g/nqM8X
         URWxGdEAL01LP5F0mEaod92fGkVzto/oFBuE96XMa2nWJ5ohfofBtKbKzgpbMPHAzsUp
         iQ6oID8VJ1bySm44QDCiiVybft7Qf/UE+L7jhJNjESRbwB2WipwamSOhaxq0CMcQKrrP
         vfTg==
X-Gm-Message-State: ANoB5pkzQc0Rkqb4IGtiY0+N0Awm9HGB6CyJJUVQx3t8C9qHB1KnWnzi
        o8qv72CBnaU607IRB2aZ8XBcMQ==
X-Google-Smtp-Source: AA0mqf7TQE+OkvPXRKVatlxKEdVrVGcR694siFnt5CSyd0ClsvheQbjo5FKS5cSiQ1WfM8aY/5cU9A==
X-Received: by 2002:a63:d111:0:b0:473:ef9c:e1e5 with SMTP id k17-20020a63d111000000b00473ef9ce1e5mr1759870pgg.241.1668136507168;
        Thu, 10 Nov 2022 19:15:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 186-20020a6206c3000000b00553d573222fsm387724pfg.199.2022.11.10.19.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 19:15:06 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:15:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <202211101904.7A0B0C3@keescook>
References: <202211100847.388C61B3@keescook>
 <Y22WtxzDXM5PfFnb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22WtxzDXM5PfFnb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:26:31AM +0900, Sergey Senozhatsky wrote:
> On (22/11/10 08:47), coverity-bot wrote:
> > *** CID 1527270:    (OVERRUN)
> > drivers/block/zram/zram_drv.c:1727 in zram_recompress()
> > 1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
> > 1722     		src = kmap_atomic(page);
> > 1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
> > 1724     		kunmap_atomic(src);
> > 1725
> > 1726     		if (ret) {
> > vvv     CID 1527270:    (OVERRUN)
> > vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
> 
> Hmm... I don't really see how prio can evaluate to 4.

Yeah, I agree. This looks like a false positive. I'm not sure why
Coverity triggered for it. Looking at the extended report, it seems to
not have any idea that prio_max is correctly bounded.

Sorry for the noise!

-- 
Kees Cook
