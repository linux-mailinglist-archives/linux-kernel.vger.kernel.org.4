Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196B05BB1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIPSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIPSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C81B6D23
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663351452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=;
        b=R6UmTAooTjPGG1eD6g0Bl3UNXD0szNzqM3i7w6+WrWfrQ3JATrrWUcXZcdx7pQOAMwdEuh
        1lqdXt2ZnTOTQK0JGyVIC2qFSSdzG33wRTQ91OMNJaOkCvhJ1UYmVaLztATZYYDzYX+rBI
        pmLPNxGDqm9P9byOBnvdKXs8hz9kyCw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-n7om1aerOzOlD59pr9M1AQ-1; Fri, 16 Sep 2022 14:04:11 -0400
X-MC-Unique: n7om1aerOzOlD59pr9M1AQ-1
Received: by mail-qt1-f199.google.com with SMTP id u9-20020a05622a14c900b0035cc7e8cbaeso3473783qtx.19
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=;
        b=vC7XoABptlzCXaW6an/MhLH2K49YfmWMNBZoLZnEg4RSR5yzsU1PKAB6D+dJ74XxGQ
         trd4DditLZiFz81X2aGzHS2vBJ4h2rHBfDYnZL8TgU4lCSN29W32g4rjAErLj88bLdh6
         rFIN/1g8gIC8Et0kg7ZO5EBosI+iCe4CYPfyIwDpfbyZi/8P1ueFCrtivqsdtHIXETgs
         pHFIslqP3UFdYtk7v3TmVydOR6qwYJOIWo66k4tvPuSf3Lz5pn3c4D0FG8xwwwiRs9aF
         xt4kHGZA/nWzCx0uY1NU87o/EIXXsyGl5QZ1V07zZqmw9piFq7EVQqpLpku7qJhx/IhM
         YJZw==
X-Gm-Message-State: ACrzQf3fl3MxlDKncc4krhBQcpNh+4B2OXav92huZpdqe1Sg7gOm4kz/
        Ac6Po2gWw8UvjB1f6WVznsGE4kSr8o0POb6RT+3J10j2QA9aXFmznIVSSL126Jb66eJA2fAdfwO
        zN3cBdtHO43WEcBFSS1Frg1g=
X-Received: by 2002:a05:622a:310:b0:344:89e4:cf8a with SMTP id q16-20020a05622a031000b0034489e4cf8amr5512045qtw.206.1663351450853;
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4avfW/4YAwR1npdBqO0O8h7AEDzFTbb8jsyKyqwPyhkUAoMtuvNzFwbiGDh+VRZqHyNgc5tQ==
X-Received: by 2002:a05:622a:310:b0:344:89e4:cf8a with SMTP id q16-20020a05622a031000b0034489e4cf8amr5512014qtw.206.1663351450637;
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a410f00b006b5df4d2c81sm7417854qko.94.2022.09.16.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
Date:   Fri, 16 Sep 2022 14:04:09 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org, linux-kernel@vger.kernel.org,
        Johannes.Thumshirn@wdc.com, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        gost.dev@samsung.com, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v13 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YyS6mUzqjq9P0+OG@redhat.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5@eucas1p2.samsung.com>
 <20220912082204.51189-14-p.raghav@samsung.com>
 <YyIG3i++QriS9Gyy@redhat.com>
 <e42a0579-61b2-7b77-08cb-6723278490cc@samsung.com>
 <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16 2022 at  1:57P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> >>
> >> Are you certain you shouldn't at least be exposing a different
> >> logical_block_size to upper layers?
> >>
> > To be honest, I tested my patches in QEMU with 4k Logical block size and on
> > a device with 4k LBA size.
> > 
> > I did a quick test with 512B LBA size in QEMU, and I didn't see any
> > failures when I ran my normal test suite.
> > 
> > Do you see any problem with exposing the same LBA as the underlying device?
> > 
> 
> Do you see any issues here? If not, I can send the next version with the
> other two changes you suggested.

That's fine, I just thought there might be special considerations
needed.  But if yo've tested it and upper layers work as expected then
obviously my concern wasn't applicable.

Thanks,
Mike

