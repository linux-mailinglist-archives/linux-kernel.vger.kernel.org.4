Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E372A770
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjFJBcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFJBcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:32:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D83835BB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:32:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso1976503b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 18:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686360757; x=1688952757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMoAwEd9SlzlxTzlnGrB3GqIf4l0rMIqn94dDmyDoGA=;
        b=OOm3OhgjZM+KfutyMsF6l5PCN2dehGk7rml7KOoEYV2LPG1G6PnhgikuF+d7n+Rfo0
         srY09o5ZRTX4h+Edx0x979EiH4CeYQHvPdXrYoWpjZAbz4lFTuK6V+dkYYLXYxLoKJF7
         Xjj5sXug6afD45tlamE69r4bKhD1YOZVgwrAldLc4ecC4WK6MCWn9vRto3q+xw+azMVD
         BrIH4uR6n1OVuQqSBq2zHMo4NV1yx8gzika/0NV3i6V1AXMYp5iaTyCpgPI8oyAXN9bN
         SgXXwfc5Y+kcNkNNRX0UrdRhBWTA8Zp8z80ym0R9tXvzrdUnbsyavLDJkEbeyqdlDo6p
         A4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686360757; x=1688952757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMoAwEd9SlzlxTzlnGrB3GqIf4l0rMIqn94dDmyDoGA=;
        b=Uoj5Atuw6RXPL4o4AJwIp/YJt93rZ5pwXMHo2stT5smDvvSQTIX1700vdkKlWftur/
         oUQ8BajUDKLlcuFV11mxWLoDHEf4E5omgCCSneNQulcwxtBIN5fgcWFAjHChlEr5KFmf
         4ZVzB1hU2RIYPKRZ9qWveBlMXVdojOjsAVSvzhJkMowcbtSU2CQ7G2W1Gc0T1r1TnKrp
         2c5z1L627fJztIRjgL2lZaE3XIRqLzkqShuNZVADwD7w6fNbfuM6/rRd+1YKHngQW9QV
         lp3gUQiAcQrrdL+VzkvCe/2WRG9cSXf+aBXYspuasUFyUyPECzdUqIt6CR3hwi3buHX2
         GDTg==
X-Gm-Message-State: AC+VfDxErjnJO3tvOg2swdXR9PDv1TYA9c5roEzk1c5xOuGm/9eH5eOw
        4M3h1hZloZLV7dgQncxot/FlAQ==
X-Google-Smtp-Source: ACHHUZ6F1bMqDS02GmSF45tEnoZN27ZPLrIBrde419+hbZHXY9r32fa9M8hlCOzYq5YAwpP4C88hEg==
X-Received: by 2002:a05:6a20:8405:b0:10d:f812:e4b5 with SMTP id c5-20020a056a20840500b0010df812e4b5mr2858569pzd.35.1686360757014;
        Fri, 09 Jun 2023 18:32:37 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b0063d24fcc2b7sm3210133pfn.1.2023.06.09.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 18:32:36 -0700 (PDT)
Date:   Sat, 10 Jun 2023 09:32:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v2 3/5] perf cs-etm: Make PID format accessible from
 struct cs_etm_auxtrace
Message-ID: <20230610013228.GB174906@leoy-huanghe>
References: <20230608105930.1389276-1-james.clark@arm.com>
 <20230608105930.1389276-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608105930.1389276-4-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:59:27AM +0100, James Clark wrote:
> To avoid every user of PID format having to use their own static
> local variable, cache it on initialisation and change the accessor to
> take struct cs_etm_auxtrace.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
