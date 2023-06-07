Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D023726DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjFGUod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjFGUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:44:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898A106
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:44:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9c299f35dso9770771cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686170650; x=1688762650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uBtObePEJMpXLUdvR0d7lMNYDfd/1CWLLE/+yHsMKo=;
        b=OxZBBCYEhIrvwilPeyYAZFxKMThGWPKFtvT8oMlyBxMhifnnpwTGJA3Bw/eJIxgy1H
         iTYPYBylFsDtuhH207pppa3AwkSdc3r92VwecbqE3bP+g3liBFKIbd/NbNpf4enILb8H
         pUZJDS11SVTHkROPU7jL9Zb9HTKRSWftA7uacAmuWtb8eNcIV0arySXPDwZZBYelCtKw
         4j1XztZcYuVoExn1ZacU6MUE/9h6+U5nHGy1Bnq1+JcHgpKxgQ9HSNKazdiIPrGAOZp8
         +FG9EbUQmVjC4LDUIloOrRsGw3Wey4tyLiC4qdjaQGo2SKZJ/J+HRF5QzvKEfFpvrRMK
         XQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170650; x=1688762650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uBtObePEJMpXLUdvR0d7lMNYDfd/1CWLLE/+yHsMKo=;
        b=e+pHd7iavvDW62a6O3y4CTv4+ozpWkpH755EzJY9t86HD8nyNBVSzo7myhLpGW4fto
         INY1L1180ETU7PtUqTtIZhTv58w12n8b2evPJO2TeLVHs9MJrX6a0BFoI9cg/OPpgHn1
         LoUdIm3CAcBcbn2L6UiP6dQzFUE8zWGSFUJbcGoO27rbSfbeVzMWCiq6eHswCuuuynwu
         Jj+HMWnjcOxMi5yhdHCkG79WD0C5SfnDNEsTTQmP1yva26V1XJVOMneQRrJuLCTCiQQY
         oa/tA/xil5TC32rJfpkKllZ/bmbEIN5afSVvh8zIo6FBkzvK5abwXbNgp4EMgGp5IxFa
         MsTA==
X-Gm-Message-State: AC+VfDz42LFdsfeoU9sou+7Vuz0lL3guZj149cycKLAB/VijfSLjhe1Q
        TqI0HHFmr5ZJpA+ksvhQn/cOwpb4x8SMiuJxHTg=
X-Google-Smtp-Source: ACHHUZ4N4t6tphKjaDaXXafqoNfYjiMYvpmcCkdxaqEcbN27M95rCwdK1/mGDtr3FMQ4HlUihB5P6A==
X-Received: by 2002:ac8:7dd0:0:b0:3f7:a54c:c106 with SMTP id c16-20020ac87dd0000000b003f7a54cc106mr5072909qte.56.1686170649788;
        Wed, 07 Jun 2023 13:44:09 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id fy5-20020a05622a5a0500b003f9adf7c9fbsm174163qtb.71.2023.06.07.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:44:09 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:44:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: zswap: support exclusive loads
Message-ID: <20230607204408.GB340728@cmpxchg.org>
References: <20230607195143.1473802-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607195143.1473802-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:51:43PM +0000, Yosry Ahmed wrote:
> Commit 71024cb4a0bf ("frontswap: remove frontswap_tmem_exclusive_gets")
> removed support for exclusive loads from frontswap as it was not used.
> Bring back exclusive loads support to frontswap by adding an "exclusive"
> output parameter to frontswap_ops->load.
> 
> On the zswap side, add a module parameter to enable/disable exclusive
> loads, and a config option to control the boot default value.
> Refactor zswap entry invalidation in zswap_frontswap_invalidate_page()
> into zswap_invalidate_entry() to reuse it in zswap_frontswap_load() if
> exclusive loads are enabled.
> 
> With exclusive loads, we avoid having two copies of the same page in
> memory (compressed & uncompressed) after faulting it in from zswap. On
> the other hand, if the page is to be reclaimed again without being
> dirtied, it will be re-compressed. Compression is not usually slow, and
> a page that was just faulted in is less likely to be reclaimed again
> soon.
> 
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
