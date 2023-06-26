Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41273EC06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFZUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjFZUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:46:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F79173C;
        Mon, 26 Jun 2023 13:46:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6687446eaccso3488598b3a.3;
        Mon, 26 Jun 2023 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687812376; x=1690404376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abXWxshL/+u8xLEuocBOBOfPh4KOKawZQbGDTC33PZ4=;
        b=aEm69tH4y2vqT7mMQYdk2zYhVgNmyj+IlFnAcDUNbf7orO46rRaTy4wqhr+nUwASWw
         26xA2AKIATgkRVCXu/0NJYm0zV1zmprviTuCSbU+zhyTxNG0ae97/26fVKVBX5RqGqpp
         WL6qn8jnnYV46NCKvPJUE6UmDHxsghh11ttLusz/5A/0cTY+oGg1+by30fWElEo/lnpb
         fMwtYp6+zeEBCuTBBWi1DZ0x6Y2akNNl3polboTYZhfTfmzO2kaIHwduCUUCVpV9SPWX
         yUH97BFulz1ASCV45RmPWS+6ddFCwNAK+vEF9ErRkcZhARs4fNOWWKnvDDn4eGOD/Uah
         U1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812376; x=1690404376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abXWxshL/+u8xLEuocBOBOfPh4KOKawZQbGDTC33PZ4=;
        b=STb4BfK9UhD0TUQVlh5f0AGMR8tzk155+iT5uox1dDF6vy/Ty5WQGmC74chVCEc00k
         LI2W+fSp4KrD7nCggTK5j+AaGa2Sg9sSDfO8AXy42/lNMBm++5jJBeB0CkbOqY2HmrWw
         2CWhC/q/CyqPjs3X5WmSj2j9IB939e/POOXUNcAg6+HuMut/vk2kar+WlXduB9ZcmHxk
         HztlJ6PQQPv4SqB0pguhdEt7HZB4n8MLwQt8utyrzj804To3uqGCIGOq/Imt4RU1KyXg
         w/xzPQIKDxuWgQ8i5DyxNbN35LeDWgyKOJDoGrjGakw0fd2PI8rngnGayvmBEA/PrGFL
         yjHA==
X-Gm-Message-State: AC+VfDyKuu/e7TwS6FMTbhe1tp2Nweq4mk6f5Uccq7Co+XSaFphS34qC
        IEvbBDLPQnHgWbbHgMqMtd0=
X-Google-Smtp-Source: ACHHUZ6kKDI19PV3gjIP1GxofqDbnPWWJC2aL4PzMWJSHKt/gwspnE1qLDSHSC/3/gnqL4T6MtuXDQ==
X-Received: by 2002:a05:6a00:2e0e:b0:66b:6021:10fe with SMTP id fc14-20020a056a002e0e00b0066b602110femr12260119pfb.31.1687812375855;
        Mon, 26 Jun 2023 13:46:15 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b0064cca73d911sm4206288pfn.103.2023.06.26.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:46:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 10:46:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH v2 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <ZJn5F4xb6gln0653@slm.duckdns.org>
References: <20230626050405.781253-1-chengming.zhou@linux.dev>
 <20230626050405.781253-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626050405.781253-4-chengming.zhou@linux.dev>
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

I only glanced the blk-mq core part but in general this looks a lot better
than the previous one.

On Mon, Jun 26, 2023 at 01:04:05PM +0800, chengming.zhou@linux.dev wrote:
> Note we don't skip setting alloc_time_ns and start_time_ns for all
> pre-allocated rq, since the first returned rq still need to be set.

This part is a bit curious for me tho. Why do we need to set it at batch
allocation time and then at actual dispensing from the bat later? Who uses
the alloc time stamp inbetween?

Thanks.

-- 
tejun
