Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F76017AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiJQTaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJQT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:29:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE4792D5;
        Mon, 17 Oct 2022 12:28:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y191so12028897pfb.2;
        Mon, 17 Oct 2022 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhUgipz8KQA+Nb0UJBop4f3vYMVn4vujHt2cKAuNWjk=;
        b=FXTIoUQRDTwcJPRSIT4V4YAORAn7g67+EaCCufpJ5HCiBsglXCHJIHvn8qpnh3eWLK
         LN3W2cri+i84pYn0SyqyDYWWs4ym6nJO7DNn8Da4N1Xm7hyjuWuCwdthD+6AApb+RhGi
         uzyx1XzKU3VdtwbNwVfZogIP+YMZY7sBGx39vaeVoMkuuiLgVGIi3ZhtYG1CJWA2fdY2
         nQGMDU0l9OcvQ9fImtGsDjaMnLyCkcmnQr814f7Yu/73EePmXURcj2WAPyWmAu4Smd8M
         KMjJ39lHt6zyadqwQbLoWIERQGRDnPIcPoAcXEHN80jJHMX3QEvkdwTvPjQU99X1CGbv
         Nxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhUgipz8KQA+Nb0UJBop4f3vYMVn4vujHt2cKAuNWjk=;
        b=hjFrlUJFio4XRmIWMNo2ZX8332za9LHgHYuAkkef4Mmrwsu3AtINej0PmZOokWTeld
         MtvCXGj/5whRqMtISQ4CZidrtFSqbNpcngGzUsoit2VzH32PBI+1wTzgrJEAUAANpZMy
         3nWsW6NA6dL4an0yV+B+39gVLC8R82w276Rt2iX+UTUvhSfYmjRVAtEZ+ZTv8K4dLqLw
         modN4K/OsyWJ0AsGIOH5avNg+UQWysuJ08F2+YvM7Hz2H+F3SkSUuqUq0NoI5m06iXlN
         ESRbQFvN2ua9pCDw+NujJvI4dXiVE84vV9Zi7aybomzeCJbvPCdlZZIPtWKd8x8O9586
         nv8Q==
X-Gm-Message-State: ACrzQf35T+qfDyPACOmeOEPkttJgUyKDry2z5TI8nrpSHQS/pQAQQv6/
        K2D+wY8dFJ4EnajdtAXhpGqi+Wmtfxx6WA==
X-Google-Smtp-Source: AMsMyM5aiquUAAIoBCB5fNzPoIm2XhC1tJfx5tcAF0ZTinw5x7j04sw9qN+vcISH7dm/2VN2yvOjag==
X-Received: by 2002:a62:84d1:0:b0:565:b27c:8140 with SMTP id k200-20020a6284d1000000b00565b27c8140mr14045379pfd.14.1666034891431;
        Mon, 17 Oct 2022 12:28:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00180a7ff78ccsm7001746plh.126.2022.10.17.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:28:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:28:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.1-fixes] blkcg: Update MAINTAINERS entry
Message-ID: <Y02sydfDCLXnfZ37@slm.duckdns.org>
References: <Y02aBVTCSggxKWXT@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02aBVTCSggxKWXT@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:08:05AM -1000, Tejun Heo wrote:
> Josef wrote iolatency and iocost is missing from the files list. Let's add
> Josef as a maintainer and add blk-iocost.c to the files list.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-6.1-fixes.

Thanks.

-- 
tejun
