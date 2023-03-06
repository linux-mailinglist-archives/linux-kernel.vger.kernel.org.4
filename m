Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00156ACE25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCFTcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCFTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:32:35 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300D7202F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:31:49 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id l13so11865291qtv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT0gVkmom0UxjUl8vBAZK7+V1WRebb0if8VgviA2UHI=;
        b=k70BMj8vpXzXJqNYR3GzPjeRZ/qniB2tWoZMrDhoVeSuWlOtG5JHG3wrOKJIM2L+ih
         gHj9+Qswwoxi4ZljPhZgH+xzufxSPW5brB1tSF+hj1D4+xQeD0IaWaIQITrK/XZiiDa4
         YepNX/WUvzyIYe8IpM2DNiTGuu8/8w4lV6riQIfUKEs61QPrKgkzdCHQwhhFj8E+kVgf
         0RU60eGcLm154TOeltbiiePD8Ii6ubgfLUzLGU2Ma+31Jn4Y9QxUXCSqetW8jQ8oze59
         x2kTy2ETeFlb/8Gs9z77slM3iB9+Ukqesduz67gKy0dimAxixsaIWKOX6zqmFSqM9RpN
         qVNQ==
X-Gm-Message-State: AO0yUKUa9eW3uf51xQrodBKJSiQ0ExQSecwrq7NUskr4JbIONoVWspq4
        OXYYXcnwPAiNBKKvzn5n7O5t
X-Google-Smtp-Source: AK7set+4BUce3voOE0pK4zuN3f8Gsg0kwP96Q1jZXXZBfCpJK4J2hzKd34qRPINe3at3w5PjKmW1Ng==
X-Received: by 2002:a05:622a:387:b0:3bf:c29b:678b with SMTP id j7-20020a05622a038700b003bfc29b678bmr18818461qtx.50.1678131109092;
        Mon, 06 Mar 2023 11:31:49 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b003b9bc00c2f1sm8057244qta.94.2023.03.06.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:31:48 -0800 (PST)
Date:   Mon, 6 Mar 2023 14:31:47 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
Message-ID: <ZAY/o9ew9AtrCLE5@redhat.com>
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306134930.2878660-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2023 at  8:49P -0500,
Hou Tao <houtao@huaweicloud.com> wrote:

> From: Hou Tao <houtao1@huawei.com>
> 
> When neither no_read_workqueue nor no_write_workqueue are enabled,
> tasklet_trylock() in crypt_dec_pending() may still return false due to
> an uninitialized state, and dm-crypt will do io completion in io_queue
> instead of current context unnecessarily.

Have you actually experienced this?

> Fix it by initializing io->tasklet in crypt_io_init().

Really would rather avoid always calling tasklet_init(). But I can
optimize it away with a later patch.

Mike
