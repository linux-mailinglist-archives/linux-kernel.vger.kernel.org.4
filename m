Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAE741076
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjF1LyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjF1LyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:54:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F332D7F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:54:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso3403439a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687953239; x=1690545239;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zkjLZhOVtTx/BDuXOcpTlp6uLGDZb2tSxiVbZH19B3g=;
        b=WQbiZHh7jtzFTCFBty1UsvIzGe2BxcSNDw+uRQSl3ABnnlB792WNPxjyxVvqjLwuoZ
         YithYe7wgk4QhmbwWR5SFFaXZl5b0fTgfkAZI7Z1SJVKwxLyaBW/VdCVIiZ5THFtIxrj
         hFAd0EtXhwAaX4d7gR7XX+8tiUmxQ1n7lr6reZvgADjrWT6IXYkfYc2vwXIad9TDtrVU
         8D+AwFWzrrCTrgETWPYH0QKjFHfjpZayUXzKJGiqsLUsJK81TaVnYy0H3HHPhOU1gk0L
         7Foq87mXRwAf7T4mAWDojd2Zu/JcJoqO4XZdCHMHcNsvOfKxsNtrgLPR25xsclhcF9Ea
         M03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953239; x=1690545239;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkjLZhOVtTx/BDuXOcpTlp6uLGDZb2tSxiVbZH19B3g=;
        b=YNBxYNxFKpbyzlE6fqHF5rkfeQDKv68jzSvesMctrHzV6DX0jJms9GDzZq2Pg7u4g8
         AK4bRkfvBtFH77rJrw5hFK+UIa0YSG57wj/Doex3sVfK+c7C696Jca6/XGgjGOLylOQm
         HlRNdZcfn0asG7LdKaY8AqYNujUeC+djJeUVK79laGvKPqNezB7Lon2SDEJpnt3dUcrm
         xJqCjoHIfXBSaQhDHdvcDJgVNxDzbvNOFIoXn8mHbpQsc01fGXnycZHtiH/Twjzfg1sD
         zuwhMBlC7cpTu76kjwWawX/SXipZFUS52YyNkDFkvcczZ/206XYJQF/hCcn7Kke1ISRQ
         702Q==
X-Gm-Message-State: AC+VfDzZLlf1oqYt53OC4aWOL6QIZqE8Gv/xbG0/s3bknV6n4NjpOq6w
        P/SmkB6Co8eYPkDHG6ZMjLYEsBwsfL8orb/h8MY=
X-Google-Smtp-Source: ACHHUZ5taKhBe+oR9xjBO6iSinRSEEDA5to8FKcrpf8yQrbBjraYeSDrcoXNDCiXfyEp3nD3l5ZfIw==
X-Received: by 2002:a17:906:684c:b0:98e:4c96:6e1f with SMTP id a12-20020a170906684c00b0098e4c966e1fmr7878594ejs.69.1687953239351;
        Wed, 28 Jun 2023 04:53:59 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id lo23-20020a170906fa1700b00992579c637bsm1003738ejb.57.2023.06.28.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:58 -0700 (PDT)
References: <20230316145539.300523-1-nmi@metaspace.dk>
 <ZBQ3sgoN8oX5HXOJ@x1-carbon>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] block: ublk: enable zoned storage support
Date:   Wed, 28 Jun 2023 13:51:50 +0200
In-reply-to: <ZBQ3sgoN8oX5HXOJ@x1-carbon>
Message-ID: <87edlvhkfe.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Thu, Mar 16, 2023 at 03:55:38PM +0100, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Hello Andreas,
>
>
> I think that this patch is starting to look very nice!

Thanks!

>
>
<snip>
>> +
>> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
>> +{
>> +	unsigned int done_zones = 0;
>> +	struct ublk_device *ub = disk->private_data;
>> +	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
>> +	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
>> +	struct blk_zone *buffer;
>> +	size_t buffer_length;
>> +	unsigned int max_zones_per_request;
>
> Nit: I would sort the variables differently.
>
> Perhaps:
>> +	struct ublk_device *ub = disk->private_data;
>> +	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
>> +	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
>> +	unsigned int done_zones = 0;
>> +	unsigned int max_zones_per_request;
>> +	struct blk_zone *buffer;
>> +	size_t buffer_length;
>

Can I ask what is the reasoning behind this? I think they way you
propose looks better, but are there any rules one can follow for this?

Best regards
Andreas
