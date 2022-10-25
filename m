Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACB860D577
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiJYUYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiJYUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:24:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA9D0383
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:24:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h2so6518198pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u11EWAKeLUJjTlcgljXJYk/tXJByUFK75HMgC2lMe7k=;
        b=SQQuGKX2fxIJZySXey4OiS/VwQA6X75XgjJZiwbO2QDm1SqCfQClRfLEPmXTGtb7R8
         Q/NJ3mX3dDATuQenL7R7QNaA+lx/kZtMfVTCGNYgq3iQOgkZ4yeq6uYWibwWjJLwOLtT
         dqbTk00iEiLJ49eXdOUWPOcqvHWoNSIdBV1JBEFK9AK893TmXijWPQDHpZtbjom0H9SZ
         YmPZtrnje63XQOh95NRocjV5keb7br7v+ugt++bPVfWOwruV0k+uUN9x5yBB+BOTweEl
         +5OAjv48h4UC+UEuOf3LyByff+N7YzHn+QeYoH6z5gJ7kGhSVFrAVz89GGJLv9ZKxtRt
         AyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u11EWAKeLUJjTlcgljXJYk/tXJByUFK75HMgC2lMe7k=;
        b=IbNLfbhrxatQhalJtphDVzPqJMB0YcLTZw/L1JZnhdA4hGlqho77JquxqWnoswraUc
         pgDOqoMXHH3mOYEaP6paWxpMJVwvlCuYS15YdM1kvn9kWNiYqbeTr5ssC8u5uV/9yueQ
         GoRdev4Xap5pJY95ol9ivjrgPMN/iRTkjGCmSLrf7gtNI6+f9UcOkBCJOmHvY8R34rrd
         vQu8fysjputjeQcJ0Vl9F6Zd5dMwtk+gHtPX307yQDmF+pwHaV9RqekrLiEeIIA1IEWe
         jLd9TnqyUnxA9ZbKtGVUL4zz3iIlUetiKAGrds7IKN2hieYTvPNIXy3Pvok51Ka533mz
         4JZQ==
X-Gm-Message-State: ACrzQf2LXuQMF/3t7QAwKK6IUSPP4GpHAykuK3YljSZOlt7f4KjL0Hcv
        QKwwWTtOXJ9+lEeiloW8bhxA9ExUADomAA==
X-Google-Smtp-Source: AMsMyM6PsF6KdDeegyUvkmj4HLJqUk4RCyc/VLSpaSVCQOeD9o5flGNTttvr0ss/q2yKmqA+/jOA5w==
X-Received: by 2002:a17:902:db0b:b0:185:51cc:811a with SMTP id m11-20020a170902db0b00b0018551cc811amr40037503plx.85.1666729430027;
        Tue, 25 Oct 2022 13:23:50 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902d14400b0017dd839f2a5sm1581616plt.38.2022.10.25.13.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:23:49 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:23:45 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/khugepaged: Initialize index and nr in collapse_file()
Message-ID: <Y1hF0bQL6CbueBe/@google.com>
References: <20221025173407.3423241-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025173407.3423241-1-nathan@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix, Nathan,

Best,
Zach

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
