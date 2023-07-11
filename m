Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4174E280
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGKAWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGKAWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:22:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D06120
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:22:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666eef03ebdso2313367b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689034937; x=1691626937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMWKdLu1pApPhx1zc2qBUJCatrJQgfwkyhGPgql0sFM=;
        b=L8Ox1aEajphnkCyKy0BirVdMRtbRNootMuVxvHTl1xMinkJrUVVYjvHHhZCRnqHYbd
         7fMGLTb+4FD1oFXwQh4NiY5wSPc5dLmRPlTxSYpaPMtOYwGCFKLoUxQo5a1/Is+efsbp
         /I9yqkuWNEEFXLUBIQE0U66Wo6VALCyam1mww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689034937; x=1691626937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMWKdLu1pApPhx1zc2qBUJCatrJQgfwkyhGPgql0sFM=;
        b=G5ZHIz0I+rBcfoIMALBe7pQIqtQ04QDabgufu1eAvkyMeYpi7oXlOIZ543qt1lmEaY
         /N5YDPizh+3ieQ8tSbDiRtq3BWCeuhz4wOvzDFJBDiUZpMDVEvLbcujIosPWvMKeeYia
         jYbk2deENXl3rg9MqbOjyj2tAVNWJ7uz2OoXMExq4bsFrnanZePJF3ZE1Wona05ELKq8
         bL4XspuOUn67QOrMeaPotjkPGIJcc/cyk2eeOwIQxJk+IwMSi4weIUTd7bhuv8REk7KO
         QT595H7E952KmO3fozN5J1f6SEjvlzry3NFx1j+GZDrbwuAJ38fe60rC4lBHoRcbQjkP
         Xejw==
X-Gm-Message-State: ABy/qLadiqMO5fo6tBhYFbvhhf7D5EsmE/IhbMVUpEhRU1gx9T3+JHyK
        aIsykCUnINRs478nHmXzpmSX4Q==
X-Google-Smtp-Source: APBJJlGzA95RiUAeEohdjOBbevC+2byj+GsbV00urWFTwXkbMyNlUE1M0IgnJhc1vEy0ugo+IU4ZFQ==
X-Received: by 2002:a05:6a20:7f8e:b0:12f:df4:6102 with SMTP id d14-20020a056a207f8e00b0012f0df46102mr14632812pzj.27.1689034937299;
        Mon, 10 Jul 2023 17:22:17 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ff0100b001b8b26fa6c1sm469764plj.115.2023.07.10.17.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:22:16 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:22:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 5/5] printk: Rename
 abandon_console_lock_in_panic() to other_cpu_in_panic()
Message-ID: <20230711002211.GA12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/10 15:51), John Ogness wrote:
> Currently abandon_console_lock_in_panic() is only used to determine if
> the current CPU should immediately release the console lock because
> another CPU is in panic. However, later this function will be used by
> the CPU to immediately release other resources in this situation.
> 
> Rename the function to other_cpu_in_panic(), which is a better
> description and does not assume it is related to the console lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
