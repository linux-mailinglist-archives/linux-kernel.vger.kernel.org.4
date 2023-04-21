Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8A6EB251
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjDUTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjDUTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:38:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D0D2139
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:38:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso2167819b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682105891; x=1684697891;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g+8KsC/ps0LMXEpHmka3cbEEb7/Wjlyl8f2Ais31wDg=;
        b=TK6vvebPUf1UeLmGpfiJxvNuCRWGMhitiOmb9/goJ91+yAjgSFg+mHSRB/KVVsb18A
         RFxJbBfGPaCqHVrO0InPUKhDVPt6zgbxJtw6otYnZGVxlX91i5CVrfhb6MrSbRC2nTok
         colBViehRtzJ/qltyNiMi7m6qufynv//C2Uhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105891; x=1684697891;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+8KsC/ps0LMXEpHmka3cbEEb7/Wjlyl8f2Ais31wDg=;
        b=kc9Gu/FN39jKZFZDYjdZY/8YROmwAeg2Yf8b8eWoTQybZq6y1AXMv9fIX1o8eDmBby
         79FO32X9R3vNa2F16FODOIbj57NmOHLwXAWGt2fawnzz2cpN8wyoYtP6MGwqcKw4DzXO
         5tcBw8whN/XnEyoBFw4+7+074wfLMxBhYRHr2y2ZdZKbzLiDYVLOJGP38ZVr6QoL8ZPQ
         wzMsF2r1qgkp0uWoBO4TnxQF9yh3lxdQe6u/L30tFJ4m+Kyabg9Iic1UNo27064ND91L
         /vrJCykLmYZU/tRKyUhRgNCpcH7s0hJ1OnsFJ1GTiB23jM+DPD59LqMMQzgKUTBuwlc8
         wmhQ==
X-Gm-Message-State: AAQBX9duaYl5zZlY/w50+bdjuTq4rnBmhF/2WxKHgn4Vg+khNAGrkQ1/
        iY60byXgNmxsHlXSdqTTUvq2YQ==
X-Google-Smtp-Source: AKy350bfqz+mZsZOStlbT0+QIWIq9Tqr3Q9vUdYvJgyrTPWlg5kO0aBPO6oy9v7iFdSfvZQ9yjTOvA==
X-Received: by 2002:a05:6a21:3297:b0:f2:bd5a:9ba1 with SMTP id yt23-20020a056a21329700b000f2bd5a9ba1mr2142265pzb.62.1682105890935;
        Fri, 21 Apr 2023 12:38:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa9-20020a056a002d0900b0062622ae3648sm3331494pfb.78.2023.04.21.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:38:10 -0700 (PDT)
Message-ID: <6442e622.050a0220.827f3.7171@mx.google.com>
X-Google-Original-Message-ID: <202304211238.@keescook>
Date:   Fri, 21 Apr 2023 12:38:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 05/11] LSM: Create lsm_list_modules system call
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-6-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:53AM -0700, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include choosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
