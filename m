Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44B85E8BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiIXLKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiIXLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:10:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93982EF16
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:10:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u69so2493014pgd.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pTdV8j9qoHZXoBn7Z3qVOuNbqVagO5O4zPpZJ11W9tA=;
        b=aPH4LPkPED8aK4R/Dv7TE3ep6sfceoTpUGvrpUO4/Z188OOqNfMaf3xFltdhgmgZ5k
         KFxY+wIeNS3zzX9e7K75WwjJRL9J6cgZagmYm2ag2VHTC1vkVGHBXJ5ZxfBvwQlhusSs
         zNY6IGeRVdB5qKjj+5xqTiCBlijD5OeTeQlP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pTdV8j9qoHZXoBn7Z3qVOuNbqVagO5O4zPpZJ11W9tA=;
        b=aB9qBe6KVNHU71tz1DKIdqbBkuBKdAXVr6q8IsfLe17mYWo9DxFPdfsejdP1Uvspfl
         Ri97XIxzBCW1hVF+rD/ZoOuDQ3r4Mw5XQs9GHwIQYNqWCVJCOy6/CnsG/0icPAtdsWUy
         nr1I0LXV1C4JmiQXFS4tIdTcLlo3zBi8dxtdTwLxseF4yBM5EeB3k3L4lb3nv8AHuZBV
         b0/pcq/QWAPj7nLoCzstBe2CsSDMsQCbIAniwyi0G+HlnaqWnF2lJqjlyX9v9QFxxOR/
         hxsY9XX3k/91AxjYodF977bpDCptEAWo2tF5bDaxmxwgpemUcalNwFQHcRy62nUzis6D
         uyyA==
X-Gm-Message-State: ACrzQf0v8BF16O7nuyu+9SsXcfDZiAXwIIviAoHu7hyFpeL1hvhF1Je7
        tqR4l7DTrXs9C+2b/Z485cW3Cg==
X-Google-Smtp-Source: AMsMyM560XfjvCll1ATxl5nJMLEt9zP2sf3UVxRqexoS6YC3n0oAPt/4fn34sEIT5435zON7xNp+yA==
X-Received: by 2002:a63:243:0:b0:43c:75c:d92a with SMTP id 64-20020a630243000000b0043c075cd92amr11601592pgc.497.1664017803218;
        Sat, 24 Sep 2022 04:10:03 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id 14-20020a62160e000000b00540963470d1sm8101490pfw.84.2022.09.24.04.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 04:10:02 -0700 (PDT)
Date:   Sat, 24 Sep 2022 20:09:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 15/18] printk: Add struct cons_text_buf
Message-ID: <Yy7lhjebrLniJqOR@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-16-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-16-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Create a data structure to replace the open coded separate buffers for
> regular and extended formatting.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
