Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF16E496C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDQNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDQNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:09:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F8BB84
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:08:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w1so2735544plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681736851; x=1684328851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2nbVjTG+rwOLIIWdYvkuFGThNWk4ROtsmXtB/FlaiQ=;
        b=GRPh4oRaAQNCW+Xy26biO1ezbnOT6FVEi2bJ554bozSaVO5cvtCICTkzvPcnKaOwMj
         xBlUjW0fh7gjbt+uO2YYE337FASfH1ycpy0PZgdtuTSxU06XN9eKc3BF2JbB84raTt0Q
         yeerFjzgOw4Ut0+51iZK/UC/WSwSc/EyymADM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736851; x=1684328851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2nbVjTG+rwOLIIWdYvkuFGThNWk4ROtsmXtB/FlaiQ=;
        b=TeOTtJRejCgyr8N42OygA6Oa+uQtf/IJzpqhYfl7TE7z7dRZyjRPnxRh1sskVDsG2D
         bJaYcv01L+7Er8I7xE3QlvCcm2I/07/r9GvmAuCcvK8BZ+83Pds7Eum5oULEGR8Q70Yx
         /usd7G+e8SsAJ2le0kZSPnmnd7tlmWizRMftZsha2bKpZUCNLipkDsMSk0NuTDfmTTI0
         G09CU0Jwl1XywE1AYj67dj9qhy179Yr9I0jZjOaQ1X/f1IwuOThB46uvWCEANqtEQ4/0
         AxxSU1eKKL2eN45AJtXAdlmeyv5F5Ims5UnZILNpOonOfkjo377FmmbSV9NRn6Kd3JSc
         zu9g==
X-Gm-Message-State: AAQBX9ejPWuiUhFxkzyt1LNg+Ggw+7ofXkW77YAXbkmXz4n+Kkmavy7h
        jFtnQbh9ktPGhmWbmZOWc6FKBA==
X-Google-Smtp-Source: AKy350a1Q+ozP5ds2WouV3VdrbzlHxFnlvwWwyTzWh+i79VACbeX/Z42ARrJ5Z6urwkNhi080uGLWQ==
X-Received: by 2002:a17:902:fb04:b0:1a6:97fd:29e7 with SMTP id le4-20020a170902fb0400b001a697fd29e7mr11195216plb.27.1681736851187;
        Mon, 17 Apr 2023 06:07:31 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c10400b001a194df5a58sm3590623pli.167.2023.04.17.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:07:30 -0700 (PDT)
Date:   Mon, 17 Apr 2023 22:07:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zsmalloc: reset compaction source zspage pointer after
 putback_zspage()
Message-ID: <20230417130726.GQ25053@google.com>
References: <20230304034835.2082479-4-senozhatsky@chromium.org>
 <20230417050140.1653593-1-senozhatsky@chromium.org>
 <CAJD7tkYX4JEFwk3yjmMLMCLVPF=8UfFbv1qaPAufcQ++z8XqDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYX4JEFwk3yjmMLMCLVPF=8UfFbv1qaPAufcQ++z8XqDQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (23/04/17 04:43), Yosry Ahmed wrote:
> <senozhatsky@chromium.org> wrote:
> >
> > Fixup.
> 
> I think the original patch landed in mm-stable already, so we might
> want a proper commit log and fixes tag.
> 
> I suspect we want:
> Fixes: 5a845e9f2d66 ("zsmalloc: rework compaction algorithm")

Oh, OK, let me send out a proper patch, just in case.

> >
> > Reported-by: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks.
