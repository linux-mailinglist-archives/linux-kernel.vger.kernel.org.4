Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F24731C73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjFOP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbjFOP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:26:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB66212B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:26:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b517ee9157so5616355ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686842772; x=1689434772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTxeaxXFn5GNkcVsWJTf9D5g3nTYEaM86Nc45vNWBR4=;
        b=U+3bso/Vm9pUh7xz0npUzHyVDR5CzodEcM7fFoco4BuXpWwCjquik+lxENBhrMcsOj
         47Ax7BphyLNVPJtOvGwxU7iIoUcYpizzcBRj5urmQYZCCcoQdeIrsNIWpI+/klxOwyJ8
         rSeQ35lLDEKNLBw1GKnC3v2STOrd17u5fZiRJmCbaoONzjRkpjdgTVGYNcEJOvKMZ0Zq
         znHO1uxq1JyIbH93OcfJe2V8LiSfeihsjC9/Q4TBmmP7236UKtmm9AqXxTiS//zyfkA2
         QLuFK1SD8fY8z7zaxBTIbR0OOXmJugf9fyhb/8t49LxdyOhrxB8io/WGjavrSVdxUflL
         cewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686842772; x=1689434772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTxeaxXFn5GNkcVsWJTf9D5g3nTYEaM86Nc45vNWBR4=;
        b=D4r1xeIhcG5CeFWTmQhclCpDFmw56gAGskwBPjuJn/Jir4cAaT1U49Sw5ylkPFPX55
         tM2/ihXag2cuLZL6Fulku2RzhBaqkNggLwm6RRqwe5pSNly46LIU/9n8/rvj47ZjDMoo
         3qQ/7eaVUDYsXM2Q+i2jEty1XO4pBO60zf91pLZr4+6cdBbOtHzfUc9Gf6AD8VpwlldG
         /YuCOcAyjIv+InzYvoXA/pARTNWD13fXm+FBIwbNdl/7ndPHjUvw8sb40XDlsjPQ7fQC
         IPtSw+XCwg4v8mqXp6p5AOCgZNNbRupjWPXC3ps0konMKZXPDJiG9FCggDtlLwvoPwuA
         Qjjg==
X-Gm-Message-State: AC+VfDydKf7H8LZ9/QNrz6/yIAGa/XwrJoEpxBcBJhBzRq+3awnp+XIk
        RqRyODPdw+lzyAlAHyF2n7qBIw==
X-Google-Smtp-Source: ACHHUZ6zhkxnK3m0+W2oZ3v6Wv41P+H4hsW2NlUutS9ndUuE/gSDgZwQhIQlfr5b/Sh8t/0At9tMIQ==
X-Received: by 2002:a17:902:c94f:b0:1b0:7c3c:31f7 with SMTP id i15-20020a170902c94f00b001b07c3c31f7mr17437450pla.28.1686842772232;
        Thu, 15 Jun 2023 08:26:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902690b00b001b02bd00c61sm14181120plk.237.2023.06.15.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:26:11 -0700 (PDT)
Date:   Thu, 15 Jun 2023 15:26:07 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     yixuanjiang <yixuanjiang@google.com>, vkoul@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
Message-ID: <ZIstjzsar5a4bCFN@google.com>
References: <20230613062350.271107-1-yixuanjiang@google.com>
 <92159f51-2e17-4c6b-8fd4-0bde8b1dd38a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92159f51-2e17-4c6b-8fd4-0bde8b1dd38a@sirena.org.uk>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:56:35AM +0100, Mark Brown wrote:
> On Tue, Jun 13, 2023 at 02:23:50PM +0800, yixuanjiang wrote:
> > Modify the error handling flow by release lock.
> > The require pcm_mutex will keep holding if open fail.
> 
> > +++ b/sound/soc/soc-compress.c
> > @@ -166,6 +166,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
> >  	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
> >  out:
> >  	dpcm_path_put(&list);
> > +	mutex_unlock(&fe->card->pcm_mutex);
> >  be_err:
> 
> This is really hard to follow due to the lack of any mutex_lock()s in
> the function, I think because this is intended to undo
> snd_soc_dpcm_mutex_lock(fe) but if that's the case why is it not using
> snd_soc_dpcm_mutex_unlock(fe) like the success path does?  Given the use
> of classes not doing that looks like it'll create lockdep issues.
> 
> I'd expect the unlock to match the lock.

Yes, and judging from the context of the patch I believe this was based
off of stable 5.15.y tree. The locking has been refactored since. So
Yixuan, please rebase/adjust your patch on top of Linus's mainline tree
and resend. Thanks!

--
Carlos Llamas
