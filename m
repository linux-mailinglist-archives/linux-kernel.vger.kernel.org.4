Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4615072C624
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjFLNik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFLNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:38:38 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B800E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:38:37 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55b619e0ed1so1881361eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686577116; x=1689169116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVRs83q6FuZiAjTvEfCpXamFjh2ThBg8h3S4sJ0ht9g=;
        b=WbdQ2Rybz2h6J4+VsJRzvE0XZvJHDJ9kdTBhb14dkLnDMQqPP4H5wNbeDZ3XNr2kst
         ThU4MTwadU0BiIdokY/BpgKiUiTcluVB7OjcavPCHvgUmEWON5ISHqMhTOsIBjN5/ZQp
         CJ8vASOmIs63t84e6NYAfUAk1HHx9WDN3bLXQPhd2vd4NEXGLCRLWtgi3U6mmtPIA5u8
         tL7hayebvS9O4bpzX2vbF4a1JWceg3wlQtGoUVslXT49Geq6fUwVFotXLZcTd/Tzuh6e
         hUQ4vn9DJdAj3qZJPTadEcL1CTdUQsbKujGLpggVFrT1ppRUtnNb8Yt75br3vhabmdPV
         TU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577116; x=1689169116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVRs83q6FuZiAjTvEfCpXamFjh2ThBg8h3S4sJ0ht9g=;
        b=KfsiXwPc+gosICAPGZxorJS8TcGkP7HGIQlsoKRsOMc9a9LTp9shlKz7WWbi4KvOiv
         WSCAy6mStvmqELR91pLdVZtsb3EkJPx7RNJMgAYgaBP9KTkkIwcKRG8sSeQsnzp1b034
         2w4F1PyyEsssyS3Aqk3jNQf8hyu18ZCfa9FYycz4/mWMwSrLCKjd4oTqR+yFe4LfnKaB
         YSiq9u37MyOX/Gyc/pp2m/1cFILziP4V5PXeHv9v+gJk7d1EncCtMVOCpzrCA/bUL0Za
         nahLQUXLEtmeKfOcQnxYViIxdDWqc7pOkDNpd1xvzHVz3KAbjI0d5yJEKgL+ucuwhHnb
         naOg==
X-Gm-Message-State: AC+VfDzX9oWUyqU/1vVWDpeLog8hMuYW66DhQv57k50XHM/RuMisMRKT
        99f8sbkTfGDMp7AHuSTT5ZzkIA==
X-Google-Smtp-Source: ACHHUZ6O8CV++68kg1oVwLuNyrayd1GMlfF45hrqby2eDjgBX9Y1fpq0whm4y4OMc3edXiyhmLAW1w==
X-Received: by 2002:a05:6358:9db0:b0:129:be5b:fff with SMTP id d48-20020a0563589db000b00129be5b0fffmr3710641rwo.9.1686577116423;
        Mon, 12 Jun 2023 06:38:36 -0700 (PDT)
Received: from localhost ([2601:58a:8200:2b0::e699])
        by smtp.gmail.com with ESMTPSA id g4-20020a5b0244000000b00bccc2241e14sm339418ybp.28.2023.06.12.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:38:36 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:38:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 6/7] mm: zswap: simplify writeback function
Message-ID: <ZIcf28uSeDnzo8B7@cmpxchg.org>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-7-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093815.133504-7-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:38:14AM +0200, Domenico Cerasuolo wrote:
> zswap_writeback_entry() used to be a callback for the backends, which
> don't know about struct zswap_entry.
> 
> Now that the only user is the generic zswap LRU reclaimer, it can be
> simplified: pass the pinned zswap_entry directly, and consolidate the
> refcount management in the shrink function.
> 
> Tested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
