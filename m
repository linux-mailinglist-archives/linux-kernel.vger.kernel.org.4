Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC4D60229F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJRD07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJRD0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:26:11 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB718FD6B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:20:21 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h10so8589259qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3EJPLuHCZII89uVYzOjn1X2EducGWYxzzv+F3hec68=;
        b=EkcuM11o46mE8+iwpXAdRuMtd1CnBhrKVvB/J6DVQQ2Vl42H6UsX6COavt1W7zNQYb
         BPZX/JJIyjuixuHjJYvrj2ZZgUgo1P92Goctm6NC/PDmZc9ZM26c1hApvRRJUxey+PR4
         1wM/c6dtNsyVmmKPiB+SaeRcOl0BgyeTayTL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3EJPLuHCZII89uVYzOjn1X2EducGWYxzzv+F3hec68=;
        b=j9d4m4ERRg3L/DyNBGFudmQy0AuL6XkzEd+269548PG5aWXMIw841Ng/beGqUJglUe
         fY8NoVVDBZkN54+i+QNBVUuOC8nS8X4j6GTx5ueefn52JLcXgAeEcOyndez4eihJkQGC
         Bn9u0wvmHWjd+gS6Q61kz8jFp5AiEEkpIDq9FQKKPsvjXJj+/BF5KPOvmqOo+jV4vYou
         Vqnj6kHMMhceiAMWx6sAdH3dBgetiY5AbigjoM5k9KXreqjvjGEWAFTghClcnZtxCn0D
         uQwuODI30WJDugole+KIBQQdUHadElV9hv3nLzv8RkTUQsIL/oSczmRBucJm8ILyUWc/
         8s0w==
X-Gm-Message-State: ACrzQf2W990yb80zYcjj8n50fztCxfnwfxb9FSkGWb4XzofW8V38hvhU
        lPDjTSyrFLcU9D1WLINWepZ5sT9KzXwGcA==
X-Google-Smtp-Source: AMsMyM7zDUmbyc+oDaHt9DLVQREcejjAmTjxw1cvo6tp97Znrga+c0gcrmZhscaOuQO3o+9aXJEskg==
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id t18-20020a1709028c9200b0017829d4600fmr881694plo.40.1666062684131;
        Mon, 17 Oct 2022 20:11:24 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm6909976pga.73.2022.10.17.20.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:11:23 -0700 (PDT)
Date:   Tue, 18 Oct 2022 12:11:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 0/8] zram: Support multiple compression streams
Message-ID: <Y04ZV7RVhEi3xHSP@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009090720.1040633-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I will send a rebased (v4) series shortly. Please drop the
patches from your tree.
