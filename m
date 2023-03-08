Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA696B064D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCHLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCHLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:47:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4D8B9C94
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:46:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so2043603pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678276013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOKINkye3tuYPwZB/WM78Qa+Qktd4CzqAu8Jgly0MS0=;
        b=RpnNvdOOWeSEZyeZO4itdh5QjH/ue0UOwTkXiE0G6XszWBmCCw104DAeJFhBPFrANT
         Z2Ueb0BCBXvRMFIvL07gTbqEtLLrRh/Hl61uzHyef9DMNMkIoPbkYo4MV+kLCc7TJPGR
         pAqp6R/IhTCdblHScXu9qNsV2NqrAb7fpnwWDSprKqm2kRxavpATJ6VMm4si37RHMM6P
         GIq5NZ6jAR/8Jqdxox4tBBuV9tIQiALVmZZCvrvfLnyX7JyqTMZLy63dFw30SCVumfRd
         ctd30cgLb1dZxuCYk9p/VOoUGvzsX0VIh/WxGt9lS3DggvVS9SH84uQMQxdOcImAtgFc
         /TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOKINkye3tuYPwZB/WM78Qa+Qktd4CzqAu8Jgly0MS0=;
        b=Fbe518F8tzPCsb3uiwlVOejf2EZbtvY+Od3uQ4Up25EkYrPYBfRV1OCm5HmUNtI+O8
         ZF3OHd0ZVjCMs0VvScTJCZyXQPrkf8j4XoTOl1X55QghLYRX/Y2l2ncGcQhB+aHORg+g
         3PY+FuTfSL8A3C+o0CUFVWUogPRuL8k/EBPXKNiBgffKO9zGJhy58KafwD+JcJVd1SuY
         OpK+1KT6T6Tqkyc0VYVJgJfnFIJBUjyoAHWVVBnh0Y2hC6+/PG5sjt82BIYviMvvQOHo
         RiCnzWZrpNLkycJxLPFFV2PQ9fcKRmd8s6kvhd8oLNYaDzpJyIMFAKsS5/oCdrd3qHIH
         qCog==
X-Gm-Message-State: AO0yUKVBXKhF6JSKWQhKH663V2YVY6ybDkVrmeUGx0wtoZM8S0yLtDZs
        /iyn9UHGlU/r2gUDhi3225h/DQ==
X-Google-Smtp-Source: AK7set+fIh/cq5RGx3k8dHKcUQa4MqtJzpA2lxY2RAenNKh+wh1dNlCpr5vg9bdByCHCvi2JxyYDrA==
X-Received: by 2002:a05:6a20:8e28:b0:c6:6fef:545c with SMTP id y40-20020a056a208e2800b000c66fef545cmr19887853pzj.21.1678276013010;
        Wed, 08 Mar 2023 03:46:53 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9342740pfh.61.2023.03.08.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:46:52 -0800 (PST)
Date:   Wed, 8 Mar 2023 19:46:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, al.grant@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] perf cs-etm: Reduce verbosity of ts_source warning
Message-ID: <20230308114644.GC19253@leoy-yangtze.lan>
References: <20230308094843.287093-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094843.287093-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 09:48:42AM +0000, James Clark wrote:
> This is printed as a warning but it is normal behavior that users
> shouldn't be expected to do anything about. Reduce the warning level to
> debug3 so it's only seen in verbose mode to avoid confusion.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org
