Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF22E73696C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjFTKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:36:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37483CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:36:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668723729c5so1533136b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687257394; x=1689849394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbhGpsDAomrPFtOzOx10SN9nZPJqLIDxZxrdMydjsJM=;
        b=b+eGa0lKSuFUzxgtRZSELw7suVQ1VHVWXY+MrktaA1eOIixFyVS5s4pVVDYG8ERWgP
         ctbRvH9jgxHBxGCIyQSI8CFjA5VOgPk+yp8udL7LSI5FhrLJ5RTEijHWbxvglOhcojCi
         fQIw7m4kwJUO7YmhnMpsts4aokpidZhpu4gEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687257394; x=1689849394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbhGpsDAomrPFtOzOx10SN9nZPJqLIDxZxrdMydjsJM=;
        b=DP+fKDyS9MsVk901+Os0CgicpGIgkaM+/rgRx+RlYPseytBPsJZl4ysy/MUTjfQHAP
         erHZe19yt9hMMhe29hSkSgmGgRmoA2mcN72IGmo4wtO2RSdB4MSxCxQPJrLyq4qDh6Mq
         QPXUakIbbF811VexS6wDdgGggFbJ2QBKn4Zt3rdGC+W9Nlt98GBB8c0T3EoorxkIriam
         HVbg6TSagrDIN9HciPTZPbVDG8WBrx6/fHfwf3Wrdix1na+Vaml8jAWUL9kREQPhjr3q
         r2NGVXsBTnG6pvsTfn5doqbpAkUkiE+SOYNxr3TGJXq9LWODKkQsatNqD5aU+vEM++g7
         Pzcg==
X-Gm-Message-State: AC+VfDwaC5WFTonF1QVg8e3ZEa5ln3TQVOIQuIB+IzkbYCpnFa1VIldH
        bGSyAAzfCeLGq6qp4Frrvy2pVg==
X-Google-Smtp-Source: ACHHUZ4Dh9o0Uy9cnwLioSkX+MmLyeQQmgB8PCJzirr0vbvePQgW0GqSDwJ1VbkazJKgNTaZ2heloQ==
X-Received: by 2002:a05:6a00:1504:b0:668:9735:573c with SMTP id q4-20020a056a00150400b006689735573cmr1678585pfu.15.1687257394671;
        Tue, 20 Jun 2023 03:36:34 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:b84a:9c37:6b9:859b])
        by smtp.gmail.com with ESMTPSA id c12-20020aa78e0c000000b0063f2a5a59d1sm1073475pfr.190.2023.06.20.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:36:34 -0700 (PDT)
Date:   Tue, 20 Jun 2023 19:36:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Message-ID: <20230620103629.GA42985@google.com>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619143506.45253-2-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/19 17:35), Alexey Romanov wrote:
> 
> We use a variable of type unsigned int to store the offset
> of the first object at the subpage In turn, the offset cannot
> exceed the size of PAGE_SIZE, which is usually 4096. Thus,
> 12 bits are enough to store the offset.

[..]

> If the page size is 4Kb

It's certainly not a given. PAGE_SIZE is architecture specific.
PAGE_SIZE_16KB and PAGE_SIZE_64KB would be simple examples, but there
are, apparently, architectures that even can have PAGE_SIZE_256KB.
