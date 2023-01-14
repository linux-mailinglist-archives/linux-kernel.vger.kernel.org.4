Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0D66A9A3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjANGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjANGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:34:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DDD4ECF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:34:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso29101238pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FC4fErQDfAyHR7ZGMoj5e6fREj8MDVbT9AFPr/L2b0E=;
        b=TkqtPJ4S9qPDJC+Ko/igmT0XKrOpWgciGyn+YENRtwBngxPVzdBm7o/llinQEhOkuc
         DoaKX5qMeS6U3c5PlqZWqDj+peyfjE80hWnLBNmpkbxLBIvSPC5DJPeXLjMXux9uVx4f
         WUmOcAbfbrzEuRwIwwqaOF6/frcJnkhJgE7sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC4fErQDfAyHR7ZGMoj5e6fREj8MDVbT9AFPr/L2b0E=;
        b=gil0R5OXB7BA2dGLs0FBUBOg3wNa9MUmOKJ9MMOYJIK+xhbQpquCm5YQVhBDdslSSd
         bbcXES7D0NZFCqFkI0Fk8UCSvVSzVel+SRHLMIIf1Semgnc+EzlWu9iDL7Lzl4OhiY0L
         HY20itZ/QUVsDFLODrnG3zpO21aJ2qb71cqzw+hCSI98NxRAcV1YUJoWuQlKzqzD+kD7
         eY6RaLFni7+1SGu5DGvaXLj17YQBYvJYAp+TWhnnIHs/K0RNWRGxxoVbgiqCxD4GrAPO
         uzd0CQNUYj0pe5TJ4pbqAQPLD9k+l7TAo7NBiyHbEMfeCPk/Uc0qOYMbIi939m6bPF73
         njng==
X-Gm-Message-State: AFqh2kpFFLl8uXIwy0Mp74fOOLbQ+QbGyzzzi4OIljRu8MzgXotUbdjH
        yoOdouVSQmT8jaCr6bPUG403kJNwcdcD8y25
X-Google-Smtp-Source: AMrXdXsaeYO4kzyU+9AbVNd+TUPEewesTUVS05OKcZohuP69bVmFzv+FC7rWszJcMymedmpI7kwIEQ==
X-Received: by 2002:a05:6a20:4b03:b0:ad:79bb:7869 with SMTP id fp3-20020a056a204b0300b000ad79bb7869mr90267137pzb.56.1673678092240;
        Fri, 13 Jan 2023 22:34:52 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm14587254pfl.136.2023.01.13.22.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 22:34:51 -0800 (PST)
Date:   Sat, 14 Jan 2023 15:34:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8JNB76LDcw+R18v@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8G3nJ9+k2lB0kas@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/13 11:57), Mike Kravetz wrote:
> The following BUG shows up after this series in linux-next.  I can easily
> recreate by doing the following:
> 
> # echo large_value > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> where 'large_value' is a so big that there could never possibly be that
> many 2MB huge pages in the system.

Just to make sure. Do you have this patch applied?
https://lore.kernel.org/lkml/20230112071443.1933880-1-senozhatsky@chromium.org
