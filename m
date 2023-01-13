Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85225669E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAMQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjAMQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:36:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E4F848F5;
        Fri, 13 Jan 2023 08:31:30 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 78so15335793pgb.8;
        Fri, 13 Jan 2023 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgCWvW8jX2wErUKxI+z8+BgYAV94/Tfe5mI1Ig8QDC4=;
        b=qZkE3mLWRTvty5Mxr1y4bHFKSlzRssHJnZyCDg9zv4d61DQ/E99yCB3YTwCXUXo4Iw
         SDmYOS3sGHBjpsZW7WyXDFPFg9C3blE6Rp0Vnz15GAmY4kjeM/afYaabuKoE5kIYWP7A
         EC79oB0ZVNqoky4xizSPnYAMWPAZU7N30QDFJI7AYSV302b7rq2whcNlIFZGC4YXXJM2
         po/SbpKL0d1RyiSKDToGZgSUfacoDyMldFbCtdlA2uOnT/rHSHkbTzg7nrStxvqA3lrb
         NYGVz0f+AFVEBxfl1higVGDK8XokeRfSvBA6H+vQKPqbMHLebdLPLB+fzmOWJxQQsnqW
         kplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgCWvW8jX2wErUKxI+z8+BgYAV94/Tfe5mI1Ig8QDC4=;
        b=UwPIhkKsVRYcj4WGDl4oh+MSYzLBugbnyD+jyppaW8Lh/1dueXvuQYtlj6EyxasQxW
         PIDS5IGo68mvAA4yrH98KWJq42tFPMBI1Ml8di11QdfYogRPNQNHPX6m7AlXtO3BhyZ4
         mU6DX5eWkQkdpfwSaF/V6YN1MnDromvcWory6oyzZdz9SKe3WM08jY01UAhW3qcdHFdH
         7cpILbrQY/CsYAaSGVfangkok+qqn13JuV7AAP6M3A/hpid1b6NVq3lcqEKpEhvTE+1n
         lu8X4bp0RlTTHBfojxHGcdIM9olGrczznKYl1azEsJkMZOhQfV49wFWOcGIUiSclwQO6
         scjg==
X-Gm-Message-State: AFqh2ko8zhgcUIhahu6D7xSxh2w//MDhTMMcP0Z/kbqqXYEEOyd3bvVv
        B7dUyU0ZsAq1khghpVXPeFY=
X-Google-Smtp-Source: AMrXdXv/TF3ixaHLICwM75AhYPxrA1TJHfw06SvJA5qxr6b/vPoZeiAJ0qe8UV1ZTksYL6UstOEesw==
X-Received: by 2002:a62:6001:0:b0:582:33b4:4c57 with SMTP id u1-20020a626001000000b0058233b44c57mr10338463pfb.33.1673627489305;
        Fri, 13 Jan 2023 08:31:29 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00580cc63dce8sm11780694pfb.77.2023.01.13.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:31:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Jan 2023 06:31:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
Message-ID: <Y8GHXUcXYJcHPkOY@slm.duckdns.org>
References: <20230113143102.2e94d74f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113143102.2e94d74f@canb.auug.org.au>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:31:02PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the workqueues tree, today's linux-next build (x86_64
> allnoconfig and several others) produced this warning:
> 
> kernel/workqueue.c:1993:13: warning: 'rebind_worker' defined but not used [-Wunused-function]
>  1993 | static void rebind_worker(struct worker *worker, struct worker_pool *pool)
>       |             ^~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   793777bc193b ("workqueue: Factorize unbind/rebind_workers() logic")

Valentin, this is caused by rebind_worker() being only used by
rebind_workers() which is inside CONFIG_SMP. I don't see any other uses of
rebind_worker(). Just fold it back into rebind_workers()?

Thanks.

-- 
tejun
