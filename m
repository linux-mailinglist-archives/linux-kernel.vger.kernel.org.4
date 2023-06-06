Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4045723420
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFFAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFFAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:46:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2EABE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:46:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-650bacd6250so3125879b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 17:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686012415; x=1688604415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yI11++T/L5lBeXkeNTjihRq2YfRTI8fGCX9agASUvk=;
        b=KhiEIuWwisJ64nb7oADv/W5nqmaBtNa8G1RmqvZUesa4csOL1T/m1/xO3Ro6OXBcQB
         JM46wGBSgfb3tepOH7zmW44Po9kVidHv3fde6PXWKpHx4wlivJx5wQsSdaX+IlCWqfT0
         BpkWjkKmSal2JQH1WoxQXcajnA9fG87qCYoEMGJ/bJbY8xUvb4IbZkEy1ejj3SLdKLMf
         aLHIj9xNftG16pkkqEKSzoHqNmtYcdy/68Ctc1rY3cYAhEyTuk51nT05S5ojXfx2p2Nt
         XcAclcy/lUws7WybpPtBjpcQgfE7/Dr2gYwuS2uD236mAbXLV8XW+LiW5VfIUl8HoIm5
         XicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686012415; x=1688604415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yI11++T/L5lBeXkeNTjihRq2YfRTI8fGCX9agASUvk=;
        b=eSkn0tv7yoWODrj08joMlXR/3ddThbOrztNmvhd4b7ElWv0jIPd68JqkwIx1MKRCPU
         GE4Uq2ZKLF0JO7beALD3wZDSWoezay5qZp+5RPCM5bwbmKlntPZymXFehN7u1ZaO73zF
         Vr21TKva53vjofHR/IRQ8rbES3mSKvkb8pT9xTB8ehJ8HbWu4ns2X3nrwjZs4h2JRiWX
         0pDKpyfWOVNYZpLdLrbphQhCXZgVemUW538Z/jNohhNuT93gWbhyjwcMzm3235GO/ZQH
         e+0oXuw4B8eceG1yOGXYaKUtB6PuyPfpEJyls9wFVPhnz8b1SYrdfoFKGiDWMg42Moux
         nX7Q==
X-Gm-Message-State: AC+VfDwfvcF+jLfObaZnN8TN2wx85GdCdIPACKAzws+hyfPZlC0PkaPr
        BHwxaQvWH3ltKRgAM2dZtSP4rA==
X-Google-Smtp-Source: ACHHUZ7cyZ3JhDDLWNI9zaNMYxv9oSFHsCJyasxO3QHJZy1+i8dryMEVT93ZWSy5z2tRoQHKLHipyA==
X-Received: by 2002:a05:6a20:4428:b0:115:197c:e7d4 with SMTP id ce40-20020a056a20442800b00115197ce7d4mr560388pzb.35.1686012415379;
        Mon, 05 Jun 2023 17:46:55 -0700 (PDT)
Received: from leoy-huanghe ([156.59.96.151])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001a6cd1e4205sm7136386plb.279.2023.06.05.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:46:54 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:46:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        denik@chromium.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf cs-etm: Track exception level
Message-ID: <20230606004648.GB18315@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <ZH47LeSnwY2uKs//@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH47LeSnwY2uKs//@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Jun 05, 2023 at 04:44:45PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 24, 2023 at 02:19:54PM +0100, James Clark escreveu:
> > Some fixes to support an issue reported by Denis Nikitin where decoding
> > trace that contains different EL1 and EL2 kernels can crash or go into
> > an infinite loop because the wrong kernel maps are used for the decode.
> > 
> > This still doesn't support distinguishing guest and host userspace,
> > we'd still have to fix the timestamps and do a bit more work to
> > correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
> > possible outcome of cs_etm__cpu_mode(). As far as I know this could
> > never have been returned anyway because machine__is_host(machine) was
> > always true due to session.machines.host being hard coded. And I'm not
> > sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
> > and PERF_RECORD_MISC_HYPERVISOR in this scenario.
> > 
> > The first commit is a tidy up, second fixes a bug that I found when
> > comparing the exception level and thread of branch records, the third
> > is the main fix, and the last commit is some extra error checking. 
> > 
> > Applies to acme/perf-tools (4e111f0cf0)
> 
> So there seems to be agreement the first two patches can be applied? May
> I go ahead and do that now?

Could you pick up the first patch in this series?

I would like ask James to refine a bit for the second patch.

Thanks,
Leo
