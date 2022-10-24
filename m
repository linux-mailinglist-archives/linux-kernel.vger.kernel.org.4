Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780AD60B15F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJXQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiJXQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:19:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA681162CB;
        Mon, 24 Oct 2022 08:05:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f37so17170889lfv.8;
        Mon, 24 Oct 2022 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7JPnJvXqFbvBoRpm+OqekbXXGAEcbqpdHjX7ItqpWs=;
        b=VbYvePPjnjhYzFBxfrQKw+39o49V3T/55TmMcUR+G5etqw1/hoUwbhwb5c8izheWyg
         HER1eEGVqTbiaVAA85krDx0VUrli00i0iV8upz0f7Rkt0MKftABDFmNeM9a5guJdUlox
         NlQsitGp1DQRq7W4XBu9zkkOUgYqsNFyoncJoF0hccvlkGawFsv6MqnlL7LLKPox9mba
         UsAxYimIcyRDai0sIwS/3DDBHQWH2aSSaSCt7zpyEOCDs7N3kYuI5urgcIWsU4FR4OSN
         9O0ES/H0UOiqQtT2YqCdSFOT5Oj4gkvNGNyUXn9qjDZrT06zotXkQ2TiU5c795BOUfmu
         17pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7JPnJvXqFbvBoRpm+OqekbXXGAEcbqpdHjX7ItqpWs=;
        b=AY3mubHrHq+dx+ojfHaL9UUCkVzhvyFfOWaaS5goTLm0Zm2QSB+sC2Icj6GwHQbznA
         sUBt49MAzqMzUEq71aOSawts3I86vdz0QdjWzNxlgSMlHtKEgbtgz6uKMO5xBoLP8PvU
         yOavfSXVEnw2QEOa8DM8KJTiX8A6ZyhEDIiP28fJyR/PRAv0WgslyTWoDDJw5EuMKs9p
         Tnmv+P7cknSeTEQRWbqxLFJmV6OGfQqsmQ9BPThhtDBPT+Xm/E39xFlHT3+PQ729vbku
         epXg1Fnm4AKzkphg+pAkl3UqIZ+iO/1ACk3v+1MpxAnszMAGpDkGKfp1qogwr2YZ3HZJ
         1PQg==
X-Gm-Message-State: ACrzQf17AcTqfQB2wWKAtcV45Oy7bXNJ9yQTo+9jxio1owSaMo077Rww
        XxQTgEGxcmxLDAVsjFaRcaYWFx2nIbS0PcQnFrJASjrljYY=
X-Google-Smtp-Source: AMsMyM7e0L2h6G7AwXCVistYpyvTVjWoFBNncmJXYIRXEd7dzljAFiXwDB/SM4XTPbqfJ26lVYR907Pr/JcEilAWRYI=
X-Received: by 2002:a17:907:2d2c:b0:78d:d289:7efd with SMTP id
 gs44-20020a1709072d2c00b0078dd2897efdmr27869758ejc.166.1666622814120; Mon, 24
 Oct 2022 07:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Mon, 24 Oct 2022 23:46:42 +0900
Message-ID: <CAFNWusaY7NyW1zEAki0mEGzuCPpOONXfo2bHPCdDG=5ktgAFuw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 5:42 AM Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
>
> The virtblk_map_data() function returns negative error codes, however, the
> 'nents' field of vbr->sg_table is an unsigned int, which causes the error
> handling not to work correctly.
>
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..291f705e61a8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>                                         struct virtblk_req *vbr)
>  {
>         blk_status_t status;
> +       int num;
>
>         status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>         if (unlikely(status))
>                 return status;
>
> -       vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
> -       if (unlikely(vbr->sg_table.nents < 0)) {
> +       num = virtblk_map_data(hctx, req, vbr);
> +       if (unlikely(num < 0)) {
>                 virtblk_cleanup_cmd(req);
>                 return BLK_STS_RESOURCE;
>         }
> +       vbr->sg_table.nents = num;
>
>         blk_mq_start_request(req);
>
> --
> 2.34.1
>

Looks good to me!

Reviewed-by: Suwan Kim <suwan.kim027@gmail.com>
