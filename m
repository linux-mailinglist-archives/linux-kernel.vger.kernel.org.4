Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8816D71DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjDEBEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjDEBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:04:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C01FEC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:04:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w4so32950673plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680656647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnup48kNbwmS3XgWTsGF004OeqwAJMW3we57q8YBy5k=;
        b=0VJ8Q9+9CSuh+W3dVtEi0tdl+V+R1MkWb+sjU4rD3CnmbjZUbLJZWbPbCyQu/RNIvu
         wPR65/pSPUW7kYxR6QQ35soqixLkhM5NCs1F3w4Ayitf/4nD+jF+dEuQD2HMdG72Evcy
         wbDAwckJpo4wCM/kU1h63ndSSXr6dNthxcxDMhiv09sQdWS+ZTq8bpXNYMSXPUm2kvFy
         MCzJXSRSonB7wyIZD6i3Qfqa7820FAKkv/Zo63RdG6TTc46My81zIHroklMvns0xOatv
         3HSy4Pq52/syJIAJ7QlU1NyEG1oSnSiWaEHFuOJR324h3yqXL/F/R0knF9kxjCA64q+w
         wd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680656647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnup48kNbwmS3XgWTsGF004OeqwAJMW3we57q8YBy5k=;
        b=kBoRjXXkTllm9Ax869pjY64thMreqOhplDvqnCqE2IJGLi7ddIAozhcbjDXaHAW6Tg
         +tGk1hPnqUq1/xINwxBWN+m5F7yOXAKAVvUIJ5iYLonP/RZ24vQdvRv7dtSOgths+uMJ
         MMR1+ltViqS5Uj3AGaSKBEgCqplyn0d2F6qhNo+ML/YoY9Sl/Y85Kp4BJhwdeN1837Gv
         Evc2Kr2iIp5WZLIjSTPsA32u4kwrxyhhk0zfD+SvCXld6TGkpu6Angnuuln91i0UV9GY
         mAFj/RXAdAnwkwW/lkHTkcwaPpyKD3Y/IXvSKQQfrfDAeoL1znc7T9R9NxdAx5ZmuWaU
         gs+g==
X-Gm-Message-State: AAQBX9dgp3qYdI6P9G7guDRU2kMtXM5Hv0PJl5ezudg8uikuObjYdkIQ
        HAn5V7yei7I7mh2LRI6wz0O3Cte5I0vwkT/t8po=
X-Google-Smtp-Source: AKy350b4jeXFFgyCyMumPUPEfLWcaS8tR6iV/68X5r2IUbpaA8UIKVqQPQqc/PQt/1KAOc+06CTCIw==
X-Received: by 2002:a17:90b:3b46:b0:23d:449a:db70 with SMTP id ot6-20020a17090b3b4600b0023d449adb70mr4872400pjb.28.1680656646898;
        Tue, 04 Apr 2023 18:04:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id gc6-20020a17090b310600b0023b15e61f07sm180633pjb.12.2023.04.04.18.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 18:04:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pjrZD-00H8rp-8L; Wed, 05 Apr 2023 11:04:03 +1000
Date:   Wed, 5 Apr 2023 11:04:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Use for_each_perag() to iterate all available AGs
Message-ID: <20230405010403.GO3223426@dread.disaster.area>
References: <20230404084701.2791683-1-ryasuoka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404084701.2791683-1-ryasuoka@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 05:47:01PM +0900, Ryosuke Yasuoka wrote:
> for_each_perag_wrap() doesn't expect 0 as 2nd arg.
> To iterate all the available AGs, just use for_each_perag() instead.

Thanks, Ryosuke-san. IIUC, this is a fix for the recent sysbot
reported filestreams oops regression?

Can you include the context of the failure it reported (i.e. the
trace from the oops), and the 'reported-by' tag for the syzbot
report?

It should probably also include a 'Fixes: bd4f5d09cc93 ("xfs:
refactor the filestreams allocator pick functions")' tag as well.

> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  fs/xfs/xfs_filestream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
> index 22c13933c8f8..48f43c340c58 100644
> --- a/fs/xfs/xfs_filestream.c
> +++ b/fs/xfs/xfs_filestream.c
> @@ -151,7 +151,7 @@ xfs_filestream_pick_ag(
>  		 * grab.
>  		 */
>  		if (!max_pag) {
> -			for_each_perag_wrap(args->mp, 0, start_agno, args->pag)
> +			for_each_perag(args->mp, start_agno, args->pag)
>  				break;

While this will definitely avoid the oops, I don't think it is quite
right. If we want to iterate all AGs, then we should be starting the
iteration at AG 0, not start_agno. i.e.

+			for_each_perag(args->mp, 0, args->pag)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
