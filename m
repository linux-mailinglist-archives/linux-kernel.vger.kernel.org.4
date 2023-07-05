Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDCA748557
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjGENpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGENps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:45:48 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77D919A3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:45:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76754b9eac0so411495285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1688564745; x=1691156745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhVVYDS8SeKVHr9R1nEvh9jKIZzXtU+coyKWJqnnG/4=;
        b=1YaPE2cNCl6KjPwF/B9ho3gStPjZTWQAoK46cJUhHQuuKdcuOSq7ePJCcJuVPxIBPc
         A6H2tQW0Knsxo3rQ0i8Z0L2HGQYHnGuZ0G3cFUQJgJqe5djxD+twFRQ2zZgCMROBuEw2
         noCqssAYYqTCIgp1Loz+sNLEb3y5uBXB9NR2MlbjMHJUG6fGebZRuyfDA4PwlRr58Fmd
         JfHsKjI4XnKgXmLsWH3hIS/N+EXAcdOGu3Fhgn5rhpwutz5bL89Jt3VnnEoYi0qvve+j
         3c3tSj0yWySAa2lER2dV9S8/MgJIjr/k9xcb2uDhsiSe5izglZLXq5rYIjzawa3bUHHX
         bxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564745; x=1691156745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhVVYDS8SeKVHr9R1nEvh9jKIZzXtU+coyKWJqnnG/4=;
        b=UH2noZ0n6xphLLw9WjUWQVboIpvc4rLbU9REKcIzVzqjI2+NKZ3Ytf9Ex8xuS4M+4/
         NHYiAW7qAUmtyCL7sCTzXLCjrOMvByf129pddQ+ncZXFQ/oX8gLr41gItVsWk+BvxsJb
         gbkwMoAFVfKOKPhybK0QSblTYuICHvOKhQdonGEeVmdo1hejjoqXgkXy+c2teabRBXfr
         YOoKSQVOuYlkTE8MLWgCV3n4KA40Joj+zgtAwCx+Rs6FGEcpkQgklDsvzbmPH26pj+An
         k8Il4rCeYUKhYIRl+IDvPci7NclhlxYvf4apCX6lFTPm576jnE11ybARaoZIxsBO9Nxw
         WsNQ==
X-Gm-Message-State: AC+VfDyhKePTi/1bRqULbQG01DI7nbJt+qBvgk/hOtS2IiaCv1zaSVZL
        7hBXWZU9jzKFGxC8ZHLl2YZypg==
X-Google-Smtp-Source: ACHHUZ7mlgtrJCdxWcClgY0y50S27TG/hIFeDTqIUNJW13mzTvtpAxaRi6M5hIYSJJ4s3LSMXeWVlg==
X-Received: by 2002:a05:620a:280d:b0:767:2a7e:1dbc with SMTP id f13-20020a05620a280d00b007672a7e1dbcmr15290826qkp.17.1688564744876;
        Wed, 05 Jul 2023 06:45:44 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a166300b007678ee16016sm820747qko.45.2023.07.05.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:45:44 -0700 (PDT)
Date:   Wed, 5 Jul 2023 09:45:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, surenb@google.com, minchan@kernel.org,
        quic_pkondeti@quicinc.com, quic_smanapra@quicinc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm: madvise: fix uneven accounting of psi
Message-ID: <20230705134543.GB156754@cmpxchg.org>
References: <1688393201-11135-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688393201-11135-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 07:36:41PM +0530, Charan Teja Kalla wrote:
> A folio turns into a Workingset during:
> 1) shrink_active_list() placing the folio from active to inactive list.
> 2) When a workingset transition is happening during the folio refault.
> 
> And when Workingset is set on a folio, PSI for memory can be accounted
> during a) That folio is being reclaimed and b) Refault of that folio,
> for usual reclaims.
> 
> This accounting of PSI for memory is not consistent for reclaim +
> refault operation between usual reclaim and madvise(COLD/PAGEOUT) which
> deactivate or proactively reclaim a folio:
> a) A folio started at inactive and moved to active as part of accesses.
> Workingset is absent on the folio thus refault of it when reclaimed
> through MADV_PAGEOUT operation doesn't account for PSI.
> 
> b) When the same folio transition from inactive->active and then to
> inactive through shrink_active_list(). Workingset is set on the folio
> thus refault of it when reclaimed through MADV_PAGEOUT operation
> accounts for PSI.
> 
> c) When the same folio is part of active list directly as a result of
> folio refault and this was a workingset folio prior to eviction.
> Workingset is set on the folio thus the refault of it when reclaimed
> through MADV_PAGEOUT/MADV_COLD operation accounts for PSI.
> 
> d) MADV_COLD transfers the folio from active list to inactive
> list. Such folios may not have the Workingset thus refault operation on
> such folio doesn't account for PSI.
> 
> As said above, refault operation caused because of MADV_PAGEOUT on a
> folio is accounts for memory PSI in b) and c) but not in a). Refault
> caused by the reclaim of a folio on which MADV_COLD is performed
> accounts memory PSI in c) but not in d). These behaviours are
> inconsistent w.r.t usual reclaim + refault operation. Make this PSI
> accounting always consistent by turning a folio into a workingset one
> whenever it is leaving the active list. Also, accounting of PSI on a
> folio whenever it leaves the active list as part of the
> MADV_COLD/PAGEOUT operation helps the users whether they are operating
> on proper folios[1].
> 
> [1] https://lore.kernel.org/all/20230605180013.GD221380@cmpxchg.org/
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: Sai Manobhiram Manapragada <quic_smanapra@quicinc.com>
> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Charan
