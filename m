Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CA5F7C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJGRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJGRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972ED25AF;
        Fri,  7 Oct 2022 10:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2D761751;
        Fri,  7 Oct 2022 17:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC4C433D7;
        Fri,  7 Oct 2022 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665165049;
        bh=XdASqid1WjCP+zuDzOTglZo+FyNPpRDuWBihXnZGd/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ddFWbzcxGiqXaL7INczMieqLxcU7mZaVhxUIG9EpKEHyfuxfErlYzO1nZQFzSleeU
         BLyuzuysWRBvYbx3CVtqS78iYxkhz/vM6xbugw0QW/0HmNCNbNe5Oib3N3y9q5cTm7
         rbwZUphxaVa3ydueKcT0jqYaIIDIigDjNw3Gt4JBJBcQN1fMgGWMChqLsKv43t8Sxn
         L56Sy0UuKRfoLw4FDexS8Dqo3nem0CbidNzl4LOnlJ209C0G1rhg+jlw11Mybjx7FA
         4Sbv6mdoEw4+FSc7UzCqFAKDopO3avzblER5RZGABWGFt/JQdNoGQ78hgDvtdEe7On
         tphsxwoFaVDeQ==
Received: by mail-ej1-f43.google.com with SMTP id bj12so12800692ejb.13;
        Fri, 07 Oct 2022 10:50:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf2jxXsP5if4uNsa4vN2fIDVXSJFLFnyFWzW1iRkz7f9VzaBKpE7
        n9/38BQVH/cK0fonz9X4Dplx+1E69/vw51TMczM=
X-Google-Smtp-Source: AMsMyM6OCZvuhLpktn8u7uUs7KATxARIi8VCIZiFZdHyw1cSIqnVMhtjwvyyvk280gtm9TfJJOT3sOvGsr5M29wBgXk=
X-Received: by 2002:a17:907:a0c7:b0:787:ea3d:21c0 with SMTP id
 hw7-20020a170907a0c700b00787ea3d21c0mr5017045ejc.707.1665165047315; Fri, 07
 Oct 2022 10:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221006220840.275-1-jonathan.derrick@linux.dev> <20221006220840.275-4-jonathan.derrick@linux.dev>
In-Reply-To: <20221006220840.275-4-jonathan.derrick@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Oct 2022 10:50:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Ur8ic_u3nj9-TSpZ96jWqBa3GLEnw207sN8eJECYwZg@mail.gmail.com>
Message-ID: <CAPhsuW6Ur8ic_u3nj9-TSpZ96jWqBa3GLEnw207sN8eJECYwZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/bitmap: Add chunk-count-based bitmap flushing
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 3:09 PM Jonathan Derrick
<jonathan.derrick@linux.dev> wrote:

[...]

> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index cfd7395de8fd..e0aeedbdde17 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -11,10 +11,12 @@
>  /* version 4 insists the bitmap is in little-endian order
>   * with version 3, it is host-endian which is non-portable
>   * Version 5 is currently set only for clustered devices
> ++ * Version 6 supports the flush-chunks threshold
>   */
>  #define BITMAP_MAJOR_HI 4
>  #define BITMAP_MAJOR_CLUSTERED 5
>  #define        BITMAP_MAJOR_HOSTENDIAN 3
> +#define BITMAP_MAJOR_CHUNKFLUSH 6
>
>  /*
>   * in-memory bitmap:
> @@ -135,7 +137,8 @@ typedef struct bitmap_super_s {
>                                   * reserved for the bitmap. */
>         __le32 nodes;        /* 68 the maximum number of nodes in cluster. */
>         __u8 cluster_name[64]; /* 72 cluster name to which this md belongs */
> -       __u8  pad[256 - 136]; /* set to zero */
> +       __le32 daemon_flush_chunks; /* 136 dirty chunks between flushes */
> +       __u8  pad[256 - 140]; /* set to zero */
>  } bitmap_super_t;

Do we really need this to be persistent? How about we configure it at run
time via a sysfs file?

Also, please share more data on the performance benefit of the set.

Thanks,
Song

>
>  /* notes:
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index b4e2d8b87b61..d25574e46283 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -497,6 +497,7 @@ struct mddev {
>                 struct mutex            mutex;
>                 unsigned long           chunksize;
>                 unsigned long           daemon_sleep; /* how many jiffies between updates? */
> +               unsigned int            daemon_flush_chunks; /* how many dirty chunks between updates */
>                 unsigned long           max_write_behind; /* write-behind mode */
>                 int                     external;
>                 int                     nodes; /* Maximum number of nodes in the cluster */
> --
> 2.31.1
>
