Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9E69830D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBOSRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjBOSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31873B66E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676485021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uessFhdI9WdEulNO2xW+TQ3mB+8qWJXKcAD4iyGADLA=;
        b=CR41fEVZ6ciTHr3MNw8metMh3yGabfjx1V2MiRx9TDzavVTw8x9AUBcCASSx47pIDXwkmK
        49vTWYpiWdtGFFMcfChoZ5czosINDdmvt8RAaAh322yG9DxKOYJ2meRpaVfT+hmvoP2Vxs
        6PXmpsYZkh1r01Gk7c6GEMSlb3KNEjw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-AS_ex99IPnKhqnTlgOy1Dw-1; Wed, 15 Feb 2023 13:17:00 -0500
X-MC-Unique: AS_ex99IPnKhqnTlgOy1Dw-1
Received: by mail-qv1-f69.google.com with SMTP id e5-20020a056214110500b0053547681552so11008778qvs.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uessFhdI9WdEulNO2xW+TQ3mB+8qWJXKcAD4iyGADLA=;
        b=gDlLw19pVslKJvx45uTQtgYwUosQW7DhI8439dStTJ01bC6fxZQYMU28sO1ZRGOOC2
         qczCYk516/JsdI7Yh+5KjlAzG5quzaW27bCWs1mStSdH6RhxRisl5di+dJdmem0qjedg
         zK4MxynhhYvOr/ZBdB/fMycNW5F5ZIeNBicjuUWQG0+1h1KnJcJsvwelRmCEjJojPpyg
         M7cpDzU9tN70SdRIBiln1WM7hLELQx/gPcqNrUHDXKxrhvTieUxXGrH+ykFdxMtzIa1T
         Ty/KqIcXBdbmy39Mtpx+23MZGVwzS7auvv5uzPXLIERXw8AnZI3ZjOyTs8zbmNNv7VHx
         3Kgg==
X-Gm-Message-State: AO0yUKX9gBs2Yo8Uy46emY+0yvhvdkMGqdjAmlSvq++xUvgjAZ3b+1JL
        Jb59GhS3ZzNbxo41uwspQmG6KVLUTf/SkseyApBhHouxBX7GDIU3e90a0vi1NdgM+4nMoaQRvnJ
        LcBn75bIccageQs1wCnQ0wDdPi8+VvfJRa1p0+a4YdssM03yIv32CrzGBJX7Tcy/z+jZ0VLwdvI
        lIh2IsJQ==
X-Received: by 2002:ac8:5a43:0:b0:3b9:d5db:9cc0 with SMTP id o3-20020ac85a43000000b003b9d5db9cc0mr4554382qta.43.1676485019211;
        Wed, 15 Feb 2023 10:16:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8FU3eoyL28ybs08sAywzxth4kBSlJ2NA6RcMM6MilEjKlhqWQYIXy6AB+vAmjRxgxJgmty4g==
X-Received: by 2002:ac8:5a43:0:b0:3b9:d5db:9cc0 with SMTP id o3-20020ac85a43000000b003b9d5db9cc0mr4554338qta.43.1676485018834;
        Wed, 15 Feb 2023 10:16:58 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id 17-20020ac82091000000b003b960aad697sm13414533qtd.9.2023.02.15.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:16:58 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     ye.xingchen@zte.com.cn, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: remove duplicate include header in
 topology.c
In-Reply-To: <202302091512245950001@zte.com.cn>
References: <202302091512245950001@zte.com.cn>
Date:   Wed, 15 Feb 2023 18:16:55 +0000
Message-ID: <xhsmh4jrmrdyg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/23 15:12, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> linux/bsearch.h is included more than once.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  kernel/sched/topology.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ebc8cbeb55dc..eb339751fe90 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1766,7 +1766,6 @@ bool find_numa_distance(int distance)
>   *   there is an intermediary node C, which is < N hops away from both
>   *   nodes A and B, the system is a glueless mesh.
>   */
> -#include <linux/bsearch.h>
>

This doesn't exist upstream, and I can't find any proof of it ever existing
in the git history, so I don't think you're working on an upstream tree.

>  static void init_numa_topology_type(int offline_node)
>  {
> --
> 2.25.1

