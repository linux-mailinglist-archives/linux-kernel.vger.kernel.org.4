Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B276F6E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjEDOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjEDOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:55:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9746596
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:53:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso4699145e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683211997; x=1685803997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lX/T27vjnEh8k9QeLjynwVpeQJ5Iqp1VjSSNsMcOBEs=;
        b=QhHC7viAls5QeeFDlr8Zxb6K0EZlwkRgePgufMqP08s34GEK45rZTvj2Rj0/EqNLwA
         0Q+PVahifxAYy4wnJlt9nFHcBO7gk7AROz7YCRzAHQfRbx4Wo9UFBw17ogFSOIED4oJb
         gCytz7C0GpOpIhQZ1PfuA3F3D5rT4vd4/xSlS7xjHQeB+lU3PcxRBkB3hevXwIsDb3I+
         3c8PtSzJvJ8ZVqosi1ECeolxhcEiPAD39C6nnBdMtuCuoT9zuNXi8BvX8fvja3JotePN
         fgOMDJhHJKF62H3E29aJw1a/vYRCCKoCk/H4RLqencEaoHC4TfjiEKDR+5myMhwr7t0z
         Og7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211997; x=1685803997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX/T27vjnEh8k9QeLjynwVpeQJ5Iqp1VjSSNsMcOBEs=;
        b=QshmT/Sf5rBjq5xUyquWike3qEsL74WoKsWoF4Pmplpud5ie5l9GW9tDBq3xtsLavu
         Y26SpHrNhHvMA03DsolVrWzMBP2veA4rnIb+A810Z8b7ijWtTJzw3VIogLdInS1jHi+t
         l41T1CLf1Q61qSbHc/6jLOES0LwlBXZB9rjBX9jZ5UN9YJD/4yeBbCSCFmQ5tXhDDakF
         5maDxLttBT7/EkRnnz3kqu3fV/8NnS2D6gjhRILBmqgxzUo5W9+BD5Xg4l1er0ztyBRr
         YFKCoOWp7I20QPIAZjDXvdfTBbSt8qM3ABdnijqGL57DMWfrEJ+klopdTQZ9ONCRSGoU
         9vYA==
X-Gm-Message-State: AC+VfDzDIgW2ekc8hfD4bE7YkNsOVeMRIF2F4/QiMfmxgGrLQpZZ5CBz
        4qgjmkadmKXzr6CmKTQt3z3U9Q==
X-Google-Smtp-Source: ACHHUZ6GzN7URCucXGCsHRKXlnQyu6W06FtpSOkUPc/LLEF2fjxm7I4m5YoT/ZUAKJT3AvAfP/qXmw==
X-Received: by 2002:a05:600c:2104:b0:3f1:6f44:ff3a with SMTP id u4-20020a05600c210400b003f16f44ff3amr17146491wml.13.1683211996867;
        Thu, 04 May 2023 07:53:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bce14000000b003f3195be0a0sm5161389wmc.31.2023.05.04.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:53:15 -0700 (PDT)
Date:   Thu, 4 May 2023 17:53:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo.mondi@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: greybus: fix GPF issue in
 gb_camera_capture
Message-ID: <bc5546c0-2c16-4b2d-ada1-c6dcf1d8c1a4@kili.mountain>
References: <20230504135841.1566958-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504135841.1566958-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:58:41PM +0800, Dongliang Mu wrote:
> In gb_camera_capture(), it does not check the value of settings
> before dereferencing it. And gb_camera_debugfs_capture calls
> gb_camera_capture with the 6th parameter settings as NULL.
> 
> Fix this by checking the value of setting at the starting of
> gb_camera_capture.
> 
> Fixes: 3265edaf0d70 ("greybus: Add driver for the camera class protocol")
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---

No.  The original code is correct.  memcpy(p, NULL, 0); is allowed.

I don't see a bug.

regards,
dan carpenter

