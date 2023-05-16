Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6417049E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjEPJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjEPJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:56:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598624C0A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:56:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so9978803a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684230992; x=1686822992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jop3WRAIBdeJ+cGkD/8aASCa0KJMz2ce93Rl3Wno8kI=;
        b=d9czTb8yW/LttxTFErN/V0jRaSbRNVNmqkXfNfRncr9YYlned+xxmMxmEyI17wVYtp
         o1qawn4Ph5xfYJqWVki9ALsQBqARxcMjB+cWyamOpihz5e91Kg0rc4YyAz598YBwb6dz
         rGsQd1XBaq8JOvP/BgKDn+BOKpAHjOdXNPitg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230992; x=1686822992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jop3WRAIBdeJ+cGkD/8aASCa0KJMz2ce93Rl3Wno8kI=;
        b=g5kF3lG3TrCWqO3qtZug4Hb921c65/iteGhu3n0k5pGY2yZaHg0vrRNUKiluZFvEG/
         qaaHzD8tpV/d6j7D3Bh9pZOJz2dBHFURxYcyTcrP0XqgL5KkaSJR3KwCyGjPMHjuuNjz
         1EeZw6fhLiQRSIQ+yVwEFwEgmREPJjjT+lXYOfk6pG1Eroi0qjzYqCuxvdAf+KoR6kgO
         Wxb6pQyLMw9j79Siw8rhT7U/yWcVJW2wHns2tDsUDpk7mS8oAJeB9i/q1KSscADBkDWX
         A+Y9uz4sH7reSoVlXXZg4K56Eda0WjcK3foJjkxYo0XT28iuO2r5a/4jzVzjyRxnQ5Nx
         Q1Gw==
X-Gm-Message-State: AC+VfDzD/rPBAa7Jc7bIGNGTcsO5KgTRRoEKiKkmIqAFgtbZWK12K1bb
        dn2gc49G21mUWq5Rys84wml6AA==
X-Google-Smtp-Source: ACHHUZ6FSleq3tLBdv2Tee+eFgAgFRsAOH5PakX6ZfRGDGRTZaPtK+7c7lD/99+MfIFSIjuLG226zQ==
X-Received: by 2002:a17:90a:5a06:b0:253:2c87:9459 with SMTP id b6-20020a17090a5a0600b002532c879459mr670797pjd.45.1684230992497;
        Tue, 16 May 2023 02:56:32 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b001a661000398sm15103379plh.103.2023.05.16.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:56:32 -0700 (PDT)
Date:   Tue, 16 May 2023 18:56:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: Re: [PATCH v1 2/2] mm/zsmalloc: get rid of PAGE_MASK
Message-ID: <20230516095627.GB15689@google.com>
References: <20230516095029.49036-1-avromanov@sberdevices.ru>
 <20230516095029.49036-2-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516095029.49036-2-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/16 12:50), Alexey Romanov wrote:
> 
> Use offset_in_page() macro instead of 'val & ~PAGE_MASK'
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
