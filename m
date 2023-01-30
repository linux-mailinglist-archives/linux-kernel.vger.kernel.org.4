Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946ED6804CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjA3EMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjA3EMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:12:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51D1ABC4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:12:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso14170560pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai70ynQmCHXhGl2C/AE4lN4+5TUlub5Z+/Q3Eyemse4=;
        b=i3+w2XqNNzaBzntpiVcuDr8dAlQke9XjcAW2RnuGmfaoXHKLxvowTikkTvICoQZ824
         FxWRvH652KRdla2lBngZSWcDEEy/rzU9IWdwReUfdPZIZf3WzNQVWJ8j9/WgKJ/E4qaN
         IDNhaVMCGR9IhqyZIfZ8uJWAF9zuY6EWVxTb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai70ynQmCHXhGl2C/AE4lN4+5TUlub5Z+/Q3Eyemse4=;
        b=3RoJj9T1uaHK7Dll3MeYv8VoxHnabi1Y9KvmwyCMA85a1DhAPiI24X56ckhH/9QNWO
         DPo5GmhJj0Ej18k2U+Nfzxd/XvFCyj8+DDFHRkG5ZQ2w0ChJxStBJB+rqnGSF34ysCVI
         X5zxGzBZLA5UIWKGFtdZANE0g9K71ozPCy4qKSar60dR7GHxtYlKr8KMluXodKI1u6c7
         h2BIc7JmMdp0zjdAjeDNTobVAqjl1U4dd8hf+/K7SqDduWVZNrZsAbuVPjb3lnPmeeVr
         ldyb2XirCpT0pO2C+WV1webrBEM1aSQAA0EsHbHRk/zbwet2DVLlFkhvVlZzkMrNzapb
         M5/w==
X-Gm-Message-State: AO0yUKVWStPxhcIbOb2E479X67VRtpc3x1ZZZE2Pz8DBdKUO7ZwkqEIa
        mXRlTCGkN/YBaM/v6pgaYvBZvfmYdy+1l/P4
X-Google-Smtp-Source: AK7set9i+Oe5EGkqpto77EHJj+INInYkWSOxgKI2rligM3yEbDNQ/vyd2tqfzqlyTisQFNv9vQginQ==
X-Received: by 2002:a17:902:e811:b0:196:893e:cbdb with SMTP id u17-20020a170902e81100b00196893ecbdbmr1758696plg.6.1675051968331;
        Sun, 29 Jan 2023 20:12:48 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jf14-20020a170903268e00b0019605a51d50sm6605846plb.61.2023.01.29.20.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:12:47 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:12:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ksmbd: replace rwlock with rcu for concurrenct
 access on conn list
Message-ID: <Y9dDu4WnDbHV/VhH@google.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
 <TYCP286MB23235FDD8102162698EF3154CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23235FDD8102162698EF3154CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/15 18:32), Dawei Li wrote:
> Currently, racing protection on conn list is implemented as rwlock,
> improve it by rcu primitive for its better performance.

Why is this a problem and what proves that this patch improves/solves
it? Numbers/benchmarks/analysis?
