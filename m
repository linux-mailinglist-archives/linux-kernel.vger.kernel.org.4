Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB18613BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiJaQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiJaQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:59:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9D12D05
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:59:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b22so2185708qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdLGdG8ecpCPiRxQ3vcPFkgCyzaEnHg5Ky957Nfa+rA=;
        b=Kqcb89AGHtjCOi4RVPMU03ECoVqM759Z5LLPtY8Yb/Id7hFNaoC0kpqJ41eEGWZy2J
         Ma8dvtC23dgYIwZd7NgsLNU/YBeeAMT03Xaj0hQQWajsRKqPmIO1d4CeDBDsWVOLcIuH
         zfoY/HMLcU+VkKZS1H+6lEo5hHjX/j4UHusdBAnfPGC38qE3SIfGsWKp7wftJxSvjDAM
         1XdY8gcv38Kaax2yTMZyDNicQC2WKddXlQSJnOe8iUej4C1QtMvRpUVJmZDCOLGOiyHc
         7J7whff4658tJxUWHs1tYOJikIHA07eKFnH1872oK1J0WTMIDAhDb1LBonAYLMosbCy+
         gYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdLGdG8ecpCPiRxQ3vcPFkgCyzaEnHg5Ky957Nfa+rA=;
        b=tZTA3caUlMmFNHra+IpkJEj2UmBAqE5cMm2v9nGSJO5Dm9c7/MK9kLoYqGqQ7siM1t
         18a5380yBVasasB6TLWVt2UUTM3W2U/R5NEkDXpgdKAfY5fNXLDWwsbzTCqu+RA/Tk/C
         gCt8KmJeyxmUYUKUfKGFolzEbUkOLIvs/PYglHTY4stHj6oXZvYbFNMmhq/LVA5Hzk8W
         t5UztUq7YLC/j7vCfW3UtmX6LcNhzgMH0B60Hm/neo7Wt8cb1rppWiFPlaE6wxH2t1fU
         yI717jYQFRLlIinfH6YvinQZDiBuBfGAle+/UU79ip/wIa6A+zuHe7CjmCuGaEjWHAq1
         +6WQ==
X-Gm-Message-State: ACrzQf15oQaniDgglvcqN8b4eg6eAUja2hNMmAX5DbKWP3KADrEinwvo
        7CVX8xyPnJWKL91JgPljhZkS0g==
X-Google-Smtp-Source: AMsMyM5APjmeKu6/PEtkwFyKsTp5fWQcPioOBJb/ouiwws7I25mvLzEsItuKTJPZga+hxggpGYn9Iw==
X-Received: by 2002:a05:622a:1452:b0:39d:9de:171c with SMTP id v18-20020a05622a145200b0039d09de171cmr11264029qtx.294.1667235547154;
        Mon, 31 Oct 2022 09:59:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006cbcdc6efedsm5047858qkp.41.2022.10.31.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:59:06 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:59:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.1-fixes] cgroup: Implement DEBUG_CGROUP_REF
Message-ID: <Y1/+3I2mJ+uAlAYc@cmpxchg.org>
References: <Y1w9EKH/CZhNGLJj@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1w9EKH/CZhNGLJj@slm.duckdns.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:35:28AM -1000, Tejun Heo wrote:
> It's really difficult to debug when cgroup or css refs leak. Let's add a
> debug option to force the refcnt function to not be inlined so that they can
> be kprobed for debugging.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Applying this to for-6.1-fixes. Holler for any objections.

The out-of-line versions need EXPORT_SYMBOL as they're used by modules
(loop e.g.). Otherwise it looks good to me.
