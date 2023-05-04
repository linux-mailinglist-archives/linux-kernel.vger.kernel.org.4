Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448E06F6294
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEDBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEDBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:14:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A251BD4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:14:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64384274895so100998b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 18:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683162875; x=1685754875;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qSvl+7IsNg0oxUR2IQBQ0ewbdwDR1gb4NbmEVGoaIOc=;
        b=MO2btvr0aDZ2ZJCOiFuxq8Z1gRZ/DVHNYO2n+fB2noLsX4Kz0m8+IwigmqdLflDVxA
         Jd9qDTFfbiWN5jdCKwToEjTqyJcSqdZuuL7383LeW5bntd0aqTADoSonNPviTXV4yw0/
         mTVwxa3QXGw9i7CSTJ9ai9tueAiMWr/dcIpkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683162875; x=1685754875;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSvl+7IsNg0oxUR2IQBQ0ewbdwDR1gb4NbmEVGoaIOc=;
        b=dlRkArdYKQGhqKu6VKtB3NfglCRjegvVqt04S1YUCaw+2nMboPj8mSD1g+VCEHP45n
         neboeo9Ki8m9sEFjwNF+ZkXiqnSX5DpB5xi2D36Xhb6lEwnS7fx1j/zlCPbCi67/3D54
         YG38d2RNLMPdOfSmBKGKeQGRXQjmXDN7GKspL+hIaGnQb9/jGweIQjrZ+JoKgsk4tYyD
         4QTqEq795OVoP0v/bpXdvZVHzjiHQ28GkGHkeQ0Wpn4F1wQF+UkrePkXHM0NWgVCDSro
         L8z/SsQsvNfMQiLOE/Ywb1YrqvlQbD9OBSpT6aqG8QQi0dgDiR1/BreHLJKWhERuccLw
         xFOQ==
X-Gm-Message-State: AC+VfDxXdDZXH7uNIHoWLB0U0aW5GlzpjDKGIDAR621eGoq5AUQmPvIY
        fobfqZP/3+jvYWB/ho3K6fx9pw==
X-Google-Smtp-Source: ACHHUZ6garluQu4ItJ09QRgaQsY23VtAX0MIgCpgB06QAaiyxOLGuzZM+yhQiVmkbqHftNmYXOzspg==
X-Received: by 2002:a05:6a21:380a:b0:f0:b18d:78fc with SMTP id yi10-20020a056a21380a00b000f0b18d78fcmr529423pzb.30.1683162875114;
        Wed, 03 May 2023 18:14:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v2-20020a62c302000000b0063b54ccc123sm22657300pfg.196.2023.05.03.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 18:14:34 -0700 (PDT)
Message-ID: <645306fa.620a0220.a363f.f9d0@mx.google.com>
X-Google-Original-Message-ID: <202305031814.@keescook>
Date:   Wed, 3 May 2023 18:14:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yue Zhao <findns94@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: replace ll_rw_block with submit_bh
References: <20230503162944.3969-1-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503162944.3969-1-findns94@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:29:44AM +0800, Yue Zhao wrote:
> Function ll_rw_block was removed in commit 79f597842069 ("fs/buffer:
> remove ll_rw_block() helper"). There is no unified function to sumbit
> read or write buffer in block layer for now. Consider similar sematics,
> we can choose submit_bh() to replace ll_rw_block() as predefined crash
> point. In submit_bh(), it also takes read or write flag as the first
> argument and invoke submit_bio() to submit I/O request to block layer.
> 
> Fixes: 79f597842069 ("fs/buffer: remove ll_rw_block() helper")
> 
> Signed-off-by: Yue Zhao <findns94@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
