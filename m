Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8578672698E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjFGTOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFGTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1738E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686165230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8I7kw7AcDs0Cw2p2WeNVFn3l9e0W0IdAowzm/tOL8QA=;
        b=B36ZxsUj/sA4OrCScHfrbrJxQjpEx2aHhaIsyltQdqa0Oyjmsyem6gCZL6e9nazUwnAbfU
        8cqRGM4AWVTreYkLH0YcvazzQ6br5NMPwA9pstL7UWJPgYASDUXy4SIw3OAOGtmVOl6CSA
        OH9TJmpFldbRW4YggwmhHAkOoQUcxPs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-XOxc41MQPSeGA8EfpKTv4g-1; Wed, 07 Jun 2023 15:13:49 -0400
X-MC-Unique: XOxc41MQPSeGA8EfpKTv4g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6c58d57adso11842311cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686165228; x=1688757228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I7kw7AcDs0Cw2p2WeNVFn3l9e0W0IdAowzm/tOL8QA=;
        b=OzuT6xxCK6KeUFnPmdCGynyU24qa2FQhFMbAancxm1BzM1BcLpxHxS3hvVnD0XF0Yr
         UKSKZq+cYnO6rVQPr02DX13SN/qxQWkpj52Yz6XvUTVCmPVrVyjklbAj1wlkrIOCd5Rn
         SfpmvX5HqbzOmgvp8KNW0f6AioRJREoKfiGwQVv/oOxMLkyrVmPXKqG1u6E4OP75FkqQ
         tySrpIlGn1yEJmiVk/FIjzPc3yBdeedOnCGMIkKaVMBTMfp3cUOxc6QWeIGVC5yRaSpx
         qsEhslSzSBYnptJmTw8xB/5umimFSiJvwLQaFPhb0isZRzRktEZpoS7CHBpaxHojFPIs
         s2FQ==
X-Gm-Message-State: AC+VfDw9aGvqdx56hJlXG1i5EnFebDtCcIfIshcDoczCwEbEwD4uEHM/
        zj0jVb/HVioAa7vRBgvZW9vBPR3J7wiYeIJGlRAYG8+LApT2JpoxtCUzQzIif6LItIIXOkrYdJx
        7a6SLgiQeBcIMEP46XHo3chSa99yS3UOG
X-Received: by 2002:a05:622a:1a1c:b0:3f6:a9e9:1e96 with SMTP id f28-20020a05622a1a1c00b003f6a9e91e96mr3212290qtb.2.1686165228514;
        Wed, 07 Jun 2023 12:13:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/sqsSvuqMxrEkC3Wsj0pNky39gd8DkhKY9i1WMP7EtHiMtnjjRkiYQ40C+KjGi7WZTSEUzw==
X-Received: by 2002:a05:622a:1a1c:b0:3f6:a9e9:1e96 with SMTP id f28-20020a05622a1a1c00b003f6a9e91e96mr3212275qtb.2.1686165228260;
        Wed, 07 Jun 2023 12:13:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85908000000b003f86c08b3e7sm142954qty.21.2023.06.07.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:13:47 -0700 (PDT)
Date:   Wed, 7 Jun 2023 15:13:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix iteration in collapse_file
Message-ID: <ZIDW6qFAIwrYBOob@x1n>
References: <20230607053135.2087354-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607053135.2087354-1-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:31:35PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Remove an unnecessary call to xas_set(index) when iterating over the
> target range in collapse_file. The extra call to xas_set reset the xas
> cursor to the top of the tree, causing the xas_next call on the next
> iteration to walk the tree to index instead of advancing to index+1.
> This returned the same page again, which would cause collapse_file to
> fail because the page is already locked.
> 
> This bug was hidden when CONFIG_DEBUG_VM was set. When that config was
> used, the xas_load in a subsequent VM_BUG_ON assert would walk xas from
> the top of the tree to index, causing the xas_next call on the next loop
> iteration to advance the cursor as expected.
> 
> Fixes: a2e17cc2efc7 ("mm/khugepaged: maintain page cache uptodate flag")
> Signed-off-by: David Stevens <stevensd@chromium.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

