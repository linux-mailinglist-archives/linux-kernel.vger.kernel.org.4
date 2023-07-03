Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E49745C79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGCMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGCMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:46:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB545BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:46:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31438512cafso860408f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688388393; x=1690980393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/79rfMRjpcwLCOmyx92ptoqeCBOS3BP6XcahjrCSAk=;
        b=hSCpnp9yUnzVAFZ4O8bs/QvQ5pUMK17iyGi99r2c/pe1HrbY2+ej9D2V1XR/fYvbIV
         A/yN3jsqX4ROVNjPL2H+0QTv8UcpMh3/en2zcjYN85JMoX7IJ8rIrCd9tc93MfKtHwdY
         8OPFTz6J4gPWX7Av3gcxFoJoi/2DXjaZIN/2TJY7M4DfoMlcx0OpN1POtAH75tksA7Yb
         xIl9fekIJa4BNC/sA6OBlFwQ3o+4XquAnDxYP8VHOKqyEiJ5rHgbTnHVUisc3xJ+1uBL
         t3cxiglooe9WX2yTxqXkncBug5Kw9+rgR+ccWZKIDuYz+KomMuJJL84eYPTMOIdF67Is
         Exkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388393; x=1690980393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/79rfMRjpcwLCOmyx92ptoqeCBOS3BP6XcahjrCSAk=;
        b=GlVky7ZBTghBEk3QvGYRCy3IS1dBQgzGsiLRY/RQkTUI1EaFFYU4ImJyAJrsfnEQMT
         9uTsvbrJIGRWM1pQOq60tmJazl7B2VyRIGFGUhtrbCDB7A1hHsF0tyzzH67gsi120GtZ
         0S3PsDoQ7frkUagQwbOPT7+iIiHi/QlzntOYPr3gJQS48xrAiNUbXPKvCoopH04AyfK7
         nCkL6q1//gnP9r93PzuoSpXj90TNjo5u12SZYCvdwiJO1Qs0MzCsFDVu+IOl1Zkg1cJJ
         fuvml6EI9ealeK3dJDs1a+lbX+VarhPfO18upBIKEu7PJLPRlkgI9zsXLscM2YGkQ7VY
         KiAA==
X-Gm-Message-State: ABy/qLYWjs2FYLothenSvqoaTxF+hot/zGUmF6HPAnkvr47gRWmnGUfi
        1/57SZDAexx9Po34ph1RjSREcg==
X-Google-Smtp-Source: APBJJlFKvCGlRhkpK4us53cBFtT4zZ/fnBK9/a4aEGOPnNXkNQ8FNrgDBBOqv4bnTejmfq33R8m9/Q==
X-Received: by 2002:adf:f60c:0:b0:313:e741:1caa with SMTP id t12-20020adff60c000000b00313e7411caamr9199998wrp.25.1688388393212;
        Mon, 03 Jul 2023 05:46:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b3-20020a056000054300b002c70ce264bfsm25687679wrf.76.2023.07.03.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:46:31 -0700 (PDT)
Date:   Mon, 3 Jul 2023 15:46:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
Message-ID: <4eba81ec-14e8-4204-8429-4b686881a9df@kadam.mountain>
References: <20230627181030.95608-2-irogers@google.com>
 <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:05:22AM -0700, Ian Rogers wrote:
> On Fri, Jun 30, 2023 at 9:35 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> > > PMUs before parsing").
> >
> > Will the chances ever grow to add another imperative change suggestion?
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n94
> 
> 
> Sorry, I can't parse this.

Markus is banned from vger.  Just ignore him.

regards,
dan carpenter

