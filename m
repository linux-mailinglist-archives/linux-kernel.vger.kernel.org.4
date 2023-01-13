Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2366A0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjAMR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjAMR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:28:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E1149C6;
        Fri, 13 Jan 2023 09:16:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k18so29776pll.5;
        Fri, 13 Jan 2023 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzEJEzPtTofWyuttDFBOYjcrqfFRv23f6yz9rpf4lRo=;
        b=KkG+VALTfAtr+TWe1dI2KkT8jkWR78vaqXnXef5+AbqH43GTDclgqxJ0QPT10XULYO
         gVVQ+8SmLP1J2ZJ+3ePP0YvvO+WQBfnxL66AZ3jxY/IHwKYjJ3KJG+U9/fE1VELmfDMo
         8wclb033O4b7dDEDBAYB3+SS9L09Du7m91KZFM3Hoy5tDRCHMrdOrd765LYseTGCD94+
         ujMpVJocsGXXpEEVNz+pRmq5Dc4+1wMXshbqG3tdj0rT7CTz4sha6lrkkauI7GRO9Wbs
         qrzLKTBKrGrHfA11NhvUFFylLsd7R3P8an2bv3efdrGJd+NmzQfkhPgHy8lf08LBtQMz
         uyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzEJEzPtTofWyuttDFBOYjcrqfFRv23f6yz9rpf4lRo=;
        b=1wxBMj8eEMbMNWZqSdjBuqbDw1otU5rF2DGnitx3Cm9FRnp1BhOf0rG1wBMu87EVL2
         tLx6lhn3YYH7QvMIKi2hnIWBWnDWaVTN5ZY6uWw5J+5fQtW3D9IB9GbiC2gkA04L7ikM
         uFrah4apoDsr47WnwhbhJ+VQ/pEsNXWVdCHDTrMacSdoGmfOHLWEgMTu+LETrfsxF6T+
         +eyd/Dm3xp8twSnniow/5c1s2D3DhHuPIqKQnH7B+qKvC/bba702ea5nay4oqlHPpWlp
         mEz4eVFGU3+tXNDws2tI4s+2qajHsC3ydr3LjRoIRbhAidL469F1IxRdLaAFLBe0VuEa
         d/2A==
X-Gm-Message-State: AFqh2krhgPiHCBubHlPoi8LQw+Upu9k9LtUZqPMSKCzIeCdWjixREAce
        3BpxUtHsuhyBGyo8AT5oLJVod8vf0QQ=
X-Google-Smtp-Source: AMrXdXv5bLO3RINRJjP+VruHEHlyaJdER2Bn+ow0voASoROxiGfVfZECedvNbgcokEw0AA2qgI80wg==
X-Received: by 2002:a17:902:a5cc:b0:192:f999:1e73 with SMTP id t12-20020a170902a5cc00b00192f9991e73mr29988243plq.51.1673630202079;
        Fri, 13 Jan 2023 09:16:42 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001929827731esm14338051plg.201.2023.01.13.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:16:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Jan 2023 07:16:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
Message-ID: <Y8GR+Jnif/uUG3+w@slm.duckdns.org>
References: <20230113143102.2e94d74f@canb.auug.org.au>
 <Y8GHXUcXYJcHPkOY@slm.duckdns.org>
 <xhsmhzgamidp8.mognet@vschneid.remote.csb>
 <xhsmhwn5qidnm.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhwn5qidnm.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:48:29PM +0000, Valentin Schneider wrote:
> On 13/01/23 16:47, Valentin Schneider wrote:
> > On 13/01/23 06:31, Tejun Heo wrote:
> >> On Fri, Jan 13, 2023 at 02:31:02PM +1100, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> After merging the workqueues tree, today's linux-next build (x86_64
> >>> allnoconfig and several others) produced this warning:
> >>>
> >>> kernel/workqueue.c:1993:13: warning: 'rebind_worker' defined but not used [-Wunused-function]
> >>>  1993 | static void rebind_worker(struct worker *worker, struct worker_pool *pool)
> >>>       |             ^~~~~~~~~~~~~
> >>>
> >>> Introduced by commit
> >>>
> >>>   793777bc193b ("workqueue: Factorize unbind/rebind_workers() logic")
> >>
> >> Valentin, this is caused by rebind_worker() being only used by
> >> rebind_workers() which is inside CONFIG_SMP. I don't see any other uses of
> >> rebind_worker(). Just fold it back into rebind_workers()?
> >>
> >
> > Woops! Yes I only did it to keep things aligned with unbind_workers(), let
> > me resend with that folded back in. Sorry!
> >
> 
> Unless you'd prefer a fixup patch on top of those you've already picked up?

Yeah, just send another patch to fold it back in.

Thanks.

-- 
tejun
