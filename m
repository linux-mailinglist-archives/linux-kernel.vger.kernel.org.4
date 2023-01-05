Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC31D65F401
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjAES4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjAES41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:56:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5838AC0;
        Thu,  5 Jan 2023 10:56:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so40807124pju.3;
        Thu, 05 Jan 2023 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zq1H+uB2+TPFwR7JPq5kiGxVeV7Cch9Igvb+l9VMkoU=;
        b=GhGjZD9BB3QbgnyPJCaaoMELJWaEY6VztHanVKgGEBXsSyHxLHHPZ/IJ9hH6X/l4WM
         9fq6OtuN5sKeR7SAkmrJU2UVPDb/Hdx4C4Qsm+opMN4VdE9eVtrPzM1CbSm5AB6mRr0a
         VV2dYenznVMFEHLCN7RTQ3/8g9Ktky8JtMO0N+aHLa6FzrqPoS0LXu373YMJ+e9hcu/u
         Z7KX3oC07Sa3qCZtkGANw1HceMDAaOcwvvvH/byHu31frsz8zNZg/e43biYqVSDeyZWr
         98fVK7jPmddHpJz+FY51Kq+yaOLKEQeT6vwHob+gJxmTRZqEZXTkkIjpkjTh/LkdO5yW
         QGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq1H+uB2+TPFwR7JPq5kiGxVeV7Cch9Igvb+l9VMkoU=;
        b=U+OXIr9r+XgSVm6FBNMZuunzjxpbbkax0/pXQHualnR7DjMbUWQyxFX7obQsIsVa2G
         FvaDx2+UuiAfJZHoBRcDprPnalz1b6U+Q5ajuvccrM1GDzZrjNfXtxyCG+DFN+SepBbl
         7rjMKdlHLEukJu4VCrQUAHn1YAgCkvaR6y+lOW3yM8Zy/mQYlmiSN2vkSCJV4jmYpes3
         thsVR7pisbCSCIMVmTZxHevcyYJYikIhsYp30l7SJ1+PzkbMhrKBVVZSZl8fq3ppVTB5
         FduQ9N2bhYUmIZGrPXmZbqQYyM8e9T+vGejOBAb2uJRnqIjSz220iWn6+w7nC3DNaTgD
         VfBQ==
X-Gm-Message-State: AFqh2krYENB/5XHkRjXJEBSxvHTN2bjrj1MSopu6rQSWRPzE4EYL9tIZ
        GJaZ4v59ZR45K4JlLzn+6cc=
X-Google-Smtp-Source: AMrXdXsm1ZesheS5aaRquP+/qq4vvR+aTui9k5ETx9QVJ82Wf3o+MeYG325HuUvJ/BxY8vEaHZUewg==
X-Received: by 2002:a17:902:ccce:b0:189:e577:c83e with SMTP id z14-20020a170902ccce00b00189e577c83emr62761826ple.36.1672944985441;
        Thu, 05 Jan 2023 10:56:25 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00192e7269af1sm3764350plh.253.2023.01.05.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:56:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 08:56:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] blkcg: Improve blkg config helpers and
 make iolatency init lazy
Message-ID: <Y7cdV0vlExjtkF6C@slm.duckdns.org>
References: <20230105002007.157497-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105002007.157497-1-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:20:03PM -1000, Tejun Heo wrote:
> Hello,
> 
> * Improve blkg config helpers so that they can be used consistently for all
>   the existing use cases. This also allows keeps using the same bdev open
>   instance across lazy init of rq_qos policies.
> 
> * Update iolatency so that it initializes lazily when a latency target is
>   set for the first time. This avoids registering the rq_qos policy when
>   iolatency is not used which removes unnecessary calls into iolat from IO
>   hot paths.

I forgot to update bfq. Will post v2 soon.

Thanks.

-- 
tejun
