Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9445B6636D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAJBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjAJBpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:45:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A11D2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:45:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so11745279pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 17:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drQcN15jA9pCSZSjt4qzMvYyUPllGCNymcmpFqlpOWU=;
        b=OsmyZtaBm9t84mXKy0SMMBIOeY51LPl623bAGY3fyEkQSwdm7pJEqRsgiJTRjnnPOh
         2ZJ/BAeQQxb5dSY1ZpYlJ/kFq4xMCNxah8ouM1L8xgMT4wIQj2dUEqIf8SqG8uFpgcYt
         moVZUk+YJ7ClvTkYdMn5ftVpxqW5kqdZbKaUAmDl8EJ36ECt0gUfIUzgqPzYdydOWVeF
         DoZ5uQKkuDeqhl0buonNmY2mHSjFe7LzV+MauszDd9XLM8MgzB/3fXLRWKnzkoI2aeYA
         P2QwDo5oHQepa/THerf1wxDw6Ij6n9Huc7LCEQZ5RYpWSiy7WvoOXoiGJmIkUtNpc3ex
         5kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drQcN15jA9pCSZSjt4qzMvYyUPllGCNymcmpFqlpOWU=;
        b=HTaDhI+niyj2GaFM3LlyyprylU5NFi+g1cYI21ggu0Fp9FEOu8uPMvpbtLo13CxNm5
         /pfyIJ2EsC0pQJS0ldertbFYg13Bx6jLvcF/BzS809j0oVUmcLPoM1CWN+JPPFO6Jx/d
         e+DS4weyv3PQ6KJvVbx36OaZckuq41xyGhleksvEt65ivAZ9fcj4uBqotbZ/3qQqX2lW
         Zu/aLYiL0w2tkRigTZwS+KiZwfan2KOooX/oO2KyPvDtzwAnEOPXl7oeHKHtk4PJdIYN
         MW2hCADg4PPZwL2iN2yECACiO76HmKagy7AaiDcCX4mFtbPeO/d+AM6aLqT3TKho37Cu
         y5Kg==
X-Gm-Message-State: AFqh2kqP4bE4ONpJsTayOnap/xi+G2RPWrpTCmDtXc0qUjEtT7oKH1Z+
        11tsUwHtdUhXG4sbloLhUOM/VQ==
X-Google-Smtp-Source: AMrXdXuTX+q+bW/i9WBa80Mwm7w6MPhe2XnTu2YVzKgz1hvOTH6uBJ3UX7fE+0DPJUSjdDnFigkZWA==
X-Received: by 2002:a17:903:26cf:b0:193:236:3a2b with SMTP id jg15-20020a17090326cf00b0019302363a2bmr16154130plb.3.1673315117422;
        Mon, 09 Jan 2023 17:45:17 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0019101215f63sm6797214plh.93.2023.01.09.17.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 17:45:16 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:45:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kmem: Support legacy tracepoints
Message-ID: <Y7zC5imskN9tvtBn@leoy-yangtze.lan>
References: <20230108062400.250690-1-leo.yan@linaro.org>
 <14dd06c2-39f8-ccb5-ce59-f3a1e45c94d0@arm.com>
 <Y7w03A7f2zUWwihm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7w03A7f2zUWwihm@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:38:04PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > +	const char * const slab_legacy_events[] = {
> > > +	"-e", "kmem:kmalloc_node",
> > > +	"-e", "kmem:kmem_cache_alloc_node",
> > > +	};
> > 
> > Reviewed-by: James Clark <james.clark@arm.com>
> > 
> > This fixes the error with mem:kmalloc_node for me.

Thanks for reviewing and testing!

> > I was thinking that it might be best to add all events to the list
> > conditionally instead of just the legacy ones. That way, the same error
> > won't happen in the future. But maybe it's best to have an explicit
> > error again in case the breaking change was unintentional so it's fine
> > as it is I think.

Yeah, this is a good idea for refactoring.

James, do you mind to send patches for this?

> Just applied this, the changes you brains stormed may come as later
> patches, thanks,

Thanks, Arnaldo.

Leo
