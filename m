Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E361210D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJ2HcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2HcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:32:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38E1BB952
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:32:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 192so6603522pfx.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZy5lCa/2Ecq1kSp+TM41cU7cXmzgRAAem3qyDrtqVE=;
        b=A6ozaRuL05mZkdsRzdSlURHF6+RyhhlQMHJ17oRbpBtm3eHluiPPTe/pjG6GCA10vk
         tspsEtfuGzEps6YAzOIbVmjuDaXvqm1pWzEH1nBnDI3wqRh0OvIqYp2m7/OwTKipwoyl
         NAZ2yriUdMjhNWS1Wx7WX9sK0FE0Y59FOGeLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZy5lCa/2Ecq1kSp+TM41cU7cXmzgRAAem3qyDrtqVE=;
        b=mMTuGAwqmL8TU8QnGbfP0a19luUgZjpPRo9TS97rUN2MJ6grp1R7Jyge3Ij/DhIWlL
         MwOubnhIXIU4OohjtwcAjUu36MjxulEbgRoMF9dSBv6G6kNqf3OA08KZTUW9zlN81+Jv
         kKvCYba4Nso6mdEWSUhMJwI56T7GRjJFABh1vfiLdnseN7s+R7qot5TeWeD70tQEphiq
         tuO8RQxFaltqIS+wpClVw8Kcrsk+Z3XSiUjbawW3RuzT+EPhz3f5vK4hA74hzueDoRvL
         NaM9QTsh7rBvxJOZTMNCKwAEUpsoYZNRqblO0j2fK/nPeXHgOMDSykJsD5x4LmftrPdy
         1VCQ==
X-Gm-Message-State: ACrzQf3dUx5s8q8MbQdltcwxvbCThnY1SPXsg+pyyT0WnCaA/BIRhnkS
        4jT2G27DoP1qWqz/wkxgrL+ZJA==
X-Google-Smtp-Source: AMsMyM6/CT3Vh+btOf4K3+q/dntWfviHzwWozBtDItq+XamMQLfaCbtowXk6VHNabYjKDdbmPNU6XA==
X-Received: by 2002:a05:6a02:10a:b0:461:26b8:1c95 with SMTP id bg10-20020a056a02010a00b0046126b81c95mr2895261pgb.503.1667028736033;
        Sat, 29 Oct 2022 00:32:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b001868ba9a867sm607345pll.303.2022.10.29.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:32:15 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:32:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     airlied@linux.ie, trix@redhat.com, dlatypov@google.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        llvm@lists.linux.dev, arnd@kernel.org,
        intel-gfx@lists.freedesktop.org, nathan@kernel.org,
        rodrigo.vivi@intel.com, mchehab@kernel.org,
        tvrtko.ursulin@linux.intel.com, mauro.chehab@linux.intel.com,
        ndesaulniers@google.com, gustavoars@kernel.org, vitor@massaru.org,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v5] overflow: Introduce overflows_type() and
 castable_to_type()
Message-ID: <202210290029.3CD089A86C@keescook>
References: <20220926191109.1803094-1-keescook@chromium.org>
 <20221024201125.1416422-1-gwan-gyeong.mun@intel.com>
 <ffcfb7ce-7646-c827-8d29-7c41e4b121d6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffcfb7ce-7646-c827-8d29-7c41e4b121d6@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:55:43AM +0300, Gwan-gyeong Mun wrote:
> Hi Kees,

Hi! :)

> I've updated to v5 with the last comment of Nathan.
> Could you please kindly review what more is needed as we move forward with
> this patch?

It looks fine to me -- I assume it'll go via the drm tree? Would you
rather I carry the non-drm changes in my tree instead?

>
-- 
Kees Cook
