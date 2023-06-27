Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D674038A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjF0SrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjF0SrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:47:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945F198C;
        Tue, 27 Jun 2023 11:47:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso26981515ad.2;
        Tue, 27 Jun 2023 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687891636; x=1690483636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nskFnIR+vNrUwu23eKTEjEghZKHWyJdqmqViuTv4bA=;
        b=e5Hc/8MwnYOktlk0TRuebEIyds4lWrB9+iZk9WJrnO1pDcMkmPJSm7lG0NrBZAZIhc
         Au3Y8bpqL7PPNkdWUQWkzKS9B5CWKtOojKSuXo7SG+tUkY9R8eMXtbBvJrJOuTxjfB3L
         sH9J29a0OjYBbKn/za0M0qvWP5N+l+XgnynlVTMecNfBzn6ppWkuQ+I6QTGsPMFGnO18
         txamc7XyRQoNSWb7wcbJsXbB5Bf/c7zTi3yOF74esAPNrty4OUW540bnIgYLQq/6sPhL
         tGm8Ex2iiwLg0kHrd+Onr5v2m3AqECdl2CDXura37BopOhl0PsUzR98EMOmAuhqvzsYR
         itjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687891636; x=1690483636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nskFnIR+vNrUwu23eKTEjEghZKHWyJdqmqViuTv4bA=;
        b=btBsEe24G0+xDKP0iIXeznCvX1BzFZPxBtH5pW1+u+OIIh/9pvhnRxsJwRTUkYZgxQ
         sIT/t6smkevyR2Jfk4mnuVeKY7cjL38U8tdOaq8gv5NakOFsLoGvmlPn8/FIET/3L01s
         XLiEUvdE+qMqpYE2dtH73vwhL5W9p5/2LDPnppzK1NlYEI0Iqx2+rUQDYJo29g3mRKIE
         VmoNdRcTgpxRv+ZmMBJuBNPTsQvtgsZNxAbX+lBIiZc89GIYqpPm2DQGXLYGKZ0Vl5gT
         m+NhcgIkNWZmTyLrON0PP2x/5zSiaEcK+NUZRUKZOaOwa0Lv+X3+uQNaRHYPzcrlBC6Z
         j58g==
X-Gm-Message-State: AC+VfDzPTKOHY67mf1VS1YUqfBv4NDsUPwlqhIYlVyP5Yyhta2bVDlen
        prpjAztX89GGRiurmp0FPt8=
X-Google-Smtp-Source: ACHHUZ79MgIQz7V/is2VUreMxsMlAFohfnfnkiegQWml0rD9YuwMW7v5ZfbP46l5EyVG/wnL+tZ05A==
X-Received: by 2002:a17:902:7445:b0:1b3:dcf1:97 with SMTP id e5-20020a170902744500b001b3dcf10097mr12287727plt.25.1687891635868;
        Tue, 27 Jun 2023 11:47:15 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b001b03a7a40e7sm666396pll.19.2023.06.27.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:47:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jun 2023 08:47:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH v2 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <ZJsuszuMcX72R7qD@slm.duckdns.org>
References: <20230626050405.781253-1-chengming.zhou@linux.dev>
 <20230626050405.781253-4-chengming.zhou@linux.dev>
 <ZJn5F4xb6gln0653@slm.duckdns.org>
 <e1da325b-8f16-f4d2-d6bf-65976a4239b4@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1da325b-8f16-f4d2-d6bf-65976a4239b4@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 27, 2023 at 07:32:42PM +0800, Chengming Zhou wrote:
> Since all requests in batch allocation use the same alloc and start time, so this patch
> just leave it as it is, and reset it at actual used time.
> 
> I think both way is ok, do you think it's better to just set the popped one request, leave
> other requests time to 0 ? If so, I can update to do it.

I think it'd be clearer if the rule is that the alloc time is set once when
the request is actually dispensed for use in all cases, so yeah, let's just
set it once when it actually starts getting used.

Thanks.

-- 
tejun
