Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065E664A06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjAJS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjAJS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:28:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC075633AD;
        Tue, 10 Jan 2023 10:24:10 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so14055797plb.13;
        Tue, 10 Jan 2023 10:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DSDWSC5oI8TQxnm4gch91xIJryMU4lgAF90s/UwWWk=;
        b=A3fMIP7fGQT8mhJMIpgNcr0rts9CVAZRFeqHDJG8x53GoQiiiIF1b8cGpuE0hHa53P
         ltgntzNTQNGojWqN/Lnq9CocTb1V8MOhbc3yb0lUZ25Ycbj+YNGEAToLIZ+UAozb9OmE
         ZypcGHDDE4xhl5bYlMtsNeO+L+J6omu91J/8swISZgxP8phCaglMphO8dcyP+lSMdERs
         9S+9JHgsFjD+HylQ3fAksbrOVnsc/zIo6yP5bc7ikoyO8mMFSN4uLi5mGOuKtOJeNPoz
         Rx05hFTUZqJZODLB+URCvYmDuogQgRdLBDVFRD9G52SiuDzRrVw4Qe1vGnXr6NzW1myl
         pCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DSDWSC5oI8TQxnm4gch91xIJryMU4lgAF90s/UwWWk=;
        b=O5vkKvg9cgMTBWssww5RVOy73y7E8DSyOL+piG+7BNIiRb+ho+DPVfm/c2QnzUIDfC
         +gS+ndFGd/i42bqJOWJwK1UGBu0f1oh4lpSpOUUUn1nZkB5GyqjBVwAEvExEgURic4kG
         FQEGiPChulg47TS0+QL9pMOOvuT2X2UH+Tp7WWJBLctyO8wkbk0eSZbYJ2OnLfzbcK2p
         38mNiSTk1/rsN+ep4PTmBf2KsT5uXukyUc3JQv9x5HYm+I1gfmGrTTG/9/n8zu1KF4+Q
         b+2s5eRy1R831TLEhk/9qCVaZa0xmROn4W/Vhkwf+Tec5iSyM+wUz79vfUqXzACreMlp
         OwRA==
X-Gm-Message-State: AFqh2koDorprPTuUMWnga1ZQh9CUo64ZLQLD4ILb0RUHxKASMi48jskF
        3GBlJiTY141Z+sxp581o0fU=
X-Google-Smtp-Source: AMrXdXtXVoul7y2ASo4NkUZUjHF15E9skqNkwo6cBqs0hjiByPDcgbex+D2ueZTZGIZGi8AVuISzWg==
X-Received: by 2002:a05:6a20:8423:b0:b5:f180:56ab with SMTP id c35-20020a056a20842300b000b5f18056abmr8270009pzd.60.1673375049955;
        Tue, 10 Jan 2023 10:24:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b00186a2444a43sm8400073plg.27.2023.01.10.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:24:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 08:24:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from
 blkg_conf_prep/finish()
Message-ID: <Y72tSI0eQky7Tr42@slm.duckdns.org>
References: <20230105212432.289569-1-tj@kernel.org>
 <20230105212432.289569-2-tj@kernel.org>
 <20230108170240.GA19165@lst.de>
 <Y7x9t+4EwXFl7OwS@slm.duckdns.org>
 <20230110064900.GA10277@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110064900.GA10277@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 10, 2023 at 07:49:00AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 09, 2023 at 10:48:55AM -1000, Tejun Heo wrote:
> > Now that all RCU flavors have been combined, holding a spin lock, disabling
> > irq, disabling preemption all imply RCU read lock.
> 
> Can you write it like this in the commit log, please? 

Sure, will do.

> > I can drop the changes but this actually bothers me. The annotation has been
> > broken for a *long* time and nobody noticed. Furthermore, I can't remember a
> > time when __acquires/__releases notation caught anything that lockdep
> > couldn't trivially and can't even think of a way how it could. AFAICS, these
> > annotations don't contribute anything other than preservation of themselves.
> > I don't see why we would want to keep them.
> 
> People have noticed it.  It just hasn't been a priority as there are
> lots of even more problematic things.

That doesn't really shed a positive light on them, does it? I'll drop this
part but can you think of actual reasons to keep these around other than to
keep sparse happy? I'm genuninely curious and have asked several people.
Nobody had a good answer.

Thanks.

-- 
tejun
