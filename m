Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290C66A9F3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjANH3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjANH25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:28:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717C2721
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:28:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i65so14209030pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj/v1C7ObzwCYX0T0GImX7B0KU9xll3yGxS8N/pE9qA=;
        b=Wa3Qd1CSmr93w/c4gs1yEM+KlAke276iY2a13DhU9Py0m2DOgqhqJWkFbZMbShkyq9
         Qi54NIHr+y9TYytb+xK3uik5+YnCF8Dvzk3JtjS2Sq+xD73v9oQXN0d9LA/PWK8b3n2b
         KTooglZ2NhwPqgNt+41hV9b+0xNSjfQ2G+WUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj/v1C7ObzwCYX0T0GImX7B0KU9xll3yGxS8N/pE9qA=;
        b=fVvCw2YRD9nZHU+dSaS7Z4tyVxgRXcc9ey4j3xMZx/4X8v8gEtbO4ViK3uuH2/v0fr
         blcblCJPztO1d4sS0uAuQT+VNl4n0qwVnIqkaVSvemaG2h/5dNyVIs1Sjh1Nh0Ytc/qS
         t2kvnBtk6XkFReV3hd7xAsRCric7xeGYUo/Rsq9qnftR2eo21jUDbwtO+fgUYHDySV7L
         nFbPfWzyVQWrC8BI9I7emVFReVOLzTCO1JQdbQorRRRFThYALyQcaeGlFFsNuRubAatj
         eU0ah5v83AhCl1CgSf8B7hlnjOxLBCE6xdtNCFWOLYwxCMdKmsW2L5KcnMwheA1hKh1R
         xtKw==
X-Gm-Message-State: AFqh2krd3zDhd8z19KrMMlTSwh+f3vmFvtRHF97+/WzbxvCC4d4RHWZi
        rq9+akOavPBxX2nCsPX0zMSePgweGvh4sM7T
X-Google-Smtp-Source: AMrXdXvAz4V6j+Lg7bZA0JGEsRKrT9Fv7khp2DY230IQpkWsrNwonQDfvZh3XaOd0yU2HpzjHoKZsw==
X-Received: by 2002:aa7:8c4e:0:b0:58b:b9ce:cda1 with SMTP id e14-20020aa78c4e000000b0058bb9cecda1mr5392577pfd.28.1673681335825;
        Fri, 13 Jan 2023 23:28:55 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a69-20020a621a48000000b0056b9df2a15esm6582960pfa.62.2023.01.13.23.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:28:55 -0800 (PST)
Date:   Sat, 14 Jan 2023 16:28:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 4/4] zsmalloc: set default zspage chain size to 8
Message-ID: <Y8JZszQw5iL2aHEl@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <20230109033838.2779902-5-senozhatsky@chromium.org>
 <Y8GqzpA8G8KOoV2n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GqzpA8G8KOoV2n@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/13 11:02), Minchan Kim wrote:
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> Thanks for great work, Sergey!

Thank you!
