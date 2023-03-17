Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5356BF4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCQWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCQWEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:04:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1C26CFE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:04:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x11so4819861pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeVDNpWJl53ZnaDoxPvGH8qR1g2kd/7wpgFcVj0ZMKo=;
        b=HbnOrqjrgsdCYkSbjxbOSubQfOEdfGlX0qkHb4uUWbi+Y4yEPfTTGHzjGyH13hiY9r
         TAOFBR/D/lwZKpymkiJhkYoeqM9A2EOzF5QPnHY7eckNdx7fbRMoW98jC6HD4f2uZlxN
         zTpfpGYULuqJPRVbNbV8mWDKHSlmmqb6W+RUGPLSVl5xo2op/ontYjVHT2J/VCLgbnMu
         azGKZL4sxc4MuU0oBkYkUqBgHKbuTv0C5RcxfyPryIbHV0DeGO418fUpHWS+RN/282jK
         7vcHJVG5FjBhbJhc1ssFhkxaporZH4BhjH0uqj9CJ0mTPzBoAnXOsyVQHZSv1Y+GxPU/
         ontg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeVDNpWJl53ZnaDoxPvGH8qR1g2kd/7wpgFcVj0ZMKo=;
        b=V754c1bgiin+SrKknsnvnNHYaGBTgfBCKDQpG+ZTkMVwLl+FTjNqltLt90M2r9zYIm
         AQU6oRdUOvuewEbjgbAZnBX0WMGdS+T+RKbWzKGsWJ6J+dLcWwQuGcYHBi0Cqgv4fhWb
         /BEUYy0X713KS14efLluUXelY7H4zD0l4/n1Nwxa3NBY39dMxTTBPrgZQNWGaSrLU4C4
         1hyT3WYJQnrsgV7kX48m+SNB2SKEMzSIo2UJlVSQkg5eWweAt/PPykH5PfhqeBqrQEnG
         HYaqWDo1k513kQdNpDFrhLKBlnf84jDSjGtTHkjL/ula37Qvjl15U1mzsMciAKdO++FP
         8LpA==
X-Gm-Message-State: AO0yUKUh9X6kGpiTbmTh3c+qpv23lsOs9hL4h9E6BD+LWRD+WE9Y0cN4
        PItg4ynYBoI5nTApKUsFWnAqHue7+fQ=
X-Google-Smtp-Source: AK7set/5qVVDwdM3a1Sc3CgxjK/ZLjlFDTwOMWzX7dOg8PKju8XllHvLcLLVwRnm62AMRJg+1xnlVA==
X-Received: by 2002:a17:902:e54f:b0:19d:19fb:55ec with SMTP id n15-20020a170902e54f00b0019d19fb55ecmr4910627plf.6.1679090694281;
        Fri, 17 Mar 2023 15:04:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b00195f0fb0c18sm2012474plt.31.2023.03.17.15.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:04:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 17 Mar 2023 12:04:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] workqueue: Debugging improvements
Message-ID: <ZBTkBIMXIvVhlSNL@slm.duckdns.org>
References: <20230307125335.28805-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307125335.28805-1-pmladek@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 01:53:30PM +0100, Petr Mladek wrote:
> Petr Mladek (5):
>   workqueue: Fix hung time report of worker pools
>   workqueue: Warn when a new worker could not be created
>   workqueue: Interrupted create_worker() is not a repeated event
>   workqueue: Warn when a rescuer could not be created
>   workqueue: Print backtraces from CPUs with hung CPU bound workqueues

Applied to wq/for-6.4.

Thanks.

-- 
tejun
