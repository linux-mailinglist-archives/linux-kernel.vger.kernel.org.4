Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8903625E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKKPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiKKPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:38:55 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883314D20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:38:53 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r81so3817650iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlHsWdECQ3tv3fcWIrqXb+HedmBJAx9FZPX5VGtHlJU=;
        b=06E4IE2EK4Xe7YJnb5xdW2QGv3nMsk7WXIBYseXjSBDuxkcOemdsx43M4AEUVfN+pp
         S28Kq2MsoSMYF0+fp1Jghtivtd27tJ2cDQuPjWOfmrVwmTyy3GUmRdRnyDxjAZ2BdRq/
         M26oAlxdPYxyAR2KQzFr6Ue0iAQpE9O6iKk/RL5E9QD023lfp5og0H9lT78dBrqFP5u3
         N3aafdTe0RAreWUsJ10QjCR74pd2JBXNkbrvUkiu7YWfVXVSEcXa7nAFmxuYrtMhgXXO
         qlUPqu+Jwz+s4kqadzjThpqgUXaB9acKCHCMgMDcXPu88NFe0IcuDY3KdPwhoPf1XFU/
         FQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlHsWdECQ3tv3fcWIrqXb+HedmBJAx9FZPX5VGtHlJU=;
        b=4d7vV4pxu9SHRQzppCud5cGf1TMx8M3z3dE+/CYkbCsV6+WQIRfE6AIjSCFYb2Ty1M
         HPZSdM9whmRBdip+QZdKArXai8lcSOyxUPEoMlIBvBk39k8hv0ZBZOG8LpWWntB+dDDH
         cmdDts6wXaeRxRQ2+aGf8QTyL11KuMr+LJlALPEnFIvzQNTWEp3WdCbxHgXzYFBYlpY/
         D28PLxwooTePdLtYYELSrhnCOk86FjqXzjRZ8BsKqKGFrdj6Gz3bC3B8+Ux/Ebe5Dm5e
         OX4rLAv4T/JqX2Eem2OceJGtyEplulHs0BsCSypgld88zMKDt+V9jGDCUkyLfw8htY1u
         bwbw==
X-Gm-Message-State: ANoB5pnbZF31VkbIg241ILeGO1VL9TgMbgdsMMQp16rfmUEg3PU7MeoR
        Y4lff1Vn+B0k5J7RHANNGsXTew==
X-Google-Smtp-Source: AA0mqf62/n8/c0Lbyw7i6gXxgtwSe5PEh/+r46m4qbOmL7CL/xHAVdWJn3E930xksqUa6ca85sInxA==
X-Received: by 2002:a05:6602:4188:b0:6d2:da5f:304c with SMTP id bx8-20020a056602418800b006d2da5f304cmr1258091iob.17.1668181132383;
        Fri, 11 Nov 2022 07:38:52 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id co17-20020a0566383e1100b00349deda465asm893160jab.39.2022.11.11.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:38:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Hugh Dickins <hughd@google.com>, Keith Busch <kbusch@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20221105231055.25953-1-krisman@suse.de>
References: <20221105231055.25953-1-krisman@suse.de>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued tags
Message-Id: <166818113152.9209.17718783188573289588.b4-ty@kernel.dk>
Date:   Fri, 11 Nov 2022 08:38:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2022 19:10:55 -0400, Gabriel Krisman Bertazi wrote:
> sbitmap suffers from code complexity, as demonstrated by recent fixes,
> and eventual lost wake ups on nested I/O completion.  The later happens,
> from what I understand, due to the non-atomic nature of the updates to
> wait_cnt, which needs to be subtracted and eventually reset when equal
> to zero.  This two step process can eventually miss an update when a
> nested completion happens to interrupt the CPU in between the wait_cnt
> updates.  This is very hard to fix, as shown by the recent changes to
> this code.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: Use single per-bitmap counting to wake up queued tags
      commit: 4f8126bb2308066b877859e4b5923ffb54143630

Best regards,
-- 
Jens Axboe


