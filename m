Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8773CEA6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 08:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjFYGKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFYGKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:10:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7C10D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 23:10:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668711086f4so1390396b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687673439; x=1690265439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UrRbtsIQ4Yd61xZRgL9SjIk2KI+P+O78zCw2dzLggI=;
        b=RMBiJTbQB9cQfh5/fC9tyUSf2VgutH4bLkPDgdGklZPB1jUton/6y7U/bPC5wxw7nA
         35U679roV0e7GxRisR3sdRaugL7NBhw/LbENmlqMI7IBieFQRuCfks1AzFd8/FXPZAjU
         Z5AFkLI1uWQ0azy0eHYU+13lOAIufSDxIt870=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687673439; x=1690265439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UrRbtsIQ4Yd61xZRgL9SjIk2KI+P+O78zCw2dzLggI=;
        b=VM4Vfxyu21qz6ZwTvjMDGxwjNDU7t3nO8XFQ3F5JDyooezk5pnzexjCwCKDPpFaFt2
         jXYLq6ZrEFOz96uTjN1HKgyL5YWS3HzZF7wwwpgTAArjfl4G04f2yl3yuvxgoYjI5MLD
         ZIUku4hcp00jkEMhcAPf/FJYSC6yHpRPFd9mjlQg2q/prrF/3K6c67YcB+Xad/+bNEtB
         wIazjN33AcVeQDnO3bpdfyhL7polKx2SJC6DhbYLzRTqzeyxRI5Fckha1A3ePj7ez/vo
         DNiAys4q3OjP2sDZexjhaN23c5WpNg/Jn7NRKiQTHJzo2uwEf1JobsL8kWysWpir/2gc
         Apmw==
X-Gm-Message-State: AC+VfDwG5jOmb/F73ih1UmWemLt2XSq41jupa1eDSCD2ipDt9E3OyZCg
        Ha5GVaRR5/o71ZxX2n/uCw2yPoG4/038PSLeAA4=
X-Google-Smtp-Source: ACHHUZ6XDvwR4oyGmAht+F0e/A8jB0u/506m7wzLGq0VRJoBGT+IQOuLqu3wfpAF/HuLNfA5uRx8bQ==
X-Received: by 2002:a05:6a20:1b1e:b0:117:19d1:8385 with SMTP id ch30-20020a056a201b1e00b0011719d18385mr27274561pzb.20.1687673439458;
        Sat, 24 Jun 2023 23:10:39 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id n189-20020a6327c6000000b0055387ffef10sm2060764pgn.24.2023.06.24.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 23:10:38 -0700 (PDT)
Date:   Sun, 25 Jun 2023 15:10:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/3] zsmalloc: remove zs_compact_control
Message-ID: <20230625061035.GH2934656@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624053120.643409-4-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/24 14:12), Sergey Senozhatsky wrote:
> __zs_compact always putback src_zspage into class list after
> migrate_zspage. Thus, we don't need to keep last position of
> src_zspage any more. Let's remove it.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
