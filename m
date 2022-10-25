Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435FF60C17F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJYCEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJYCEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:04:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E192AE14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:04:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h2so4126960pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2JFb3R2icFlQ5sGGRLhm0+5Vke/6AqkTDq7yNmGg4I=;
        b=FmQ9xbXJReGqIuEaGypcCNgkZoOI4Q9JLwSLxsuSt6qyuFAjG2hQ0vKFUcmTgRP6gF
         UTQL3iF7tmZZSxyEqDqwnSAjGGswZY4RC44ZT45i2Lf3+bV1rx70sVCiuj7EqgaDYTdY
         clu5sCkx9qJNW9UDosOesZB9CwNgkm2IpJtME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2JFb3R2icFlQ5sGGRLhm0+5Vke/6AqkTDq7yNmGg4I=;
        b=Wk5b4cYaLbMpKFCX7MFY8lOo3SdMbhub5mJ+7VPcYuHaBQ2/5modjth1z8pKR3TPai
         O54cR25XDP00tYE9/UWaXAq2nVdJkTI0fjSewf3i9YIwaSm5ywneCAOglt90h0KIqvB5
         3Z8GMFbyaAt4GD5oyw1wBNnTG7/Ky+n7tVS6d6VyCWCZcpKHxToNopM3LVLe9GxWzxY4
         CVI0nPHD32kDdmfhsZ3mLYiiGZAoqOpc10gxePm2goZpq3MKJL9bsNb8v4v6UsT7c8MM
         gTDmeXOHk+68sXSWTJ9Eu8vncihAPhIURmuQBNu0aTqvV5VWCd3AHEkYWZ7GFzwqpRgM
         hhHQ==
X-Gm-Message-State: ACrzQf2TR4D8sERLpnOTNe4IT5FxgdOkRrsMzBpV/3IjQz3vYRgmHdPQ
        l7+mYO+E2srzRw8lUD4FVXiQiraYlD9ueA==
X-Google-Smtp-Source: AMsMyM4AAZlx2mrF2N+N3NYrb+A9PXYMKxcbTLz7FF4gxCWkprV/sI1niymi5a0Eav9KiYnG1DqMiw==
X-Received: by 2002:aa7:96c7:0:b0:56b:c569:99c with SMTP id h7-20020aa796c7000000b0056bc569099cmr8998571pfq.4.1666663484601;
        Mon, 24 Oct 2022 19:04:44 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b001782a6fbcacsm337123pln.101.2022.10.24.19.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:04:44 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:04:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     minchan@kernel.org, ngupta@vflare.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-ID: <Y1dEOLjD+kpdz0Vo@google.com>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1dBpLDf+mRH6cLf@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 10:53), Sergey Senozhatsky wrote:
> > +unsigned int zs_get_class_size(struct zs_pool *pool, unsigned int size)
> > +{
> > +	struct size_class *class = pool->size_class[get_size_class_index(size)];
> > +
> > +	return class->size;
> > +}
> > +EXPORT_SYMBOL_GPL(zs_get_class_size);
> 
> I'll kindly ask for v2. This conflicts with configurable zspage order
> patch set which I posted last night. get_size_class_index() now takes
> the pool parameter.

Oh, apparently Andrew already has a fixup patch for this.
