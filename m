Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201616143ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 05:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiKAEhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 00:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKAEhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:37:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49713E1C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:37:35 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n18so9619347qvt.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BURuUnZws+d426Nk/rZ14JQYHoSs9yu2RF2/NW8d2Mg=;
        b=ELzD9yr3HEn0sUpe2bo1MuNwBwXTxMIamLVo/UttI+zBocvtbmtG/k7ZyghqYu2X5I
         z77CPq2D8pprvsuii+eSCXtMf4U5NvQ5ZAF4A0fQ2eCxp88xc/7VU8lAUaW4GGQHsHCr
         RGJL1PuANq0VXvtYN1nkIn0UQ4YVusqGlT7jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BURuUnZws+d426Nk/rZ14JQYHoSs9yu2RF2/NW8d2Mg=;
        b=5ZIoH0pi2sSCZHuTDDUaFfuzLLet/xOc/Tn0hDdEiQXPox0LVQsTgACni3xWSuifr5
         R7SvMpZ8W6uSTqMyRCSotwZzIuPywQIkOoxvXxkf6xiSewqy6Tr6wJzJNaugcc9cSIo9
         g5tFQ0usInEpUnAzviTj2GEXHMb1ouqdJocC2gscQui33dbBUwTS5qM+45nNTbqeE4QP
         uboHXhXTRLI34gYOVYRMb6Wao3EuiXpzDOXkDDBLBLB0QhgKNBo62OjozMm7mBaaGcKc
         VopcWBFZA+nMOKJ5bgsYF6GgvxgyfXhFOrwIWpACX5NfYYxLiTlgEZ0Lo0xCRRgufFhZ
         jUPQ==
X-Gm-Message-State: ACrzQf1jT+v6k5E5nxaEw5RBmwc/+HDhwaq6EiDUyiZVNl4coErDvncP
        lo2cVKPegD4N2oIGyv2MiM9peuA05ktnqQ==
X-Google-Smtp-Source: AMsMyM4m16BklxGqIcAUCJ8qTf+tw9dlNQ0gsFctxHe6hGBWhRcfcJ/0A+gA7wYYrxlLnT+YqTohzg==
X-Received: by 2002:ad4:5cc4:0:b0:4bb:70de:bb81 with SMTP id iu4-20020ad45cc4000000b004bb70debb81mr14096667qvb.55.1667277454429;
        Mon, 31 Oct 2022 21:37:34 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id e5-20020ac84905000000b003a5092ed8cdsm4645252qtq.9.2022.10.31.21.37.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 21:37:33 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id k2so3342876qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:37:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:6ee:d68b:5b26 with SMTP id
 v9-20020a05620a440900b006eed68b5b26mr11902150qkp.47.1667277452789; Mon, 31
 Oct 2022 21:37:32 -0700 (PDT)
MIME-Version: 1.0
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 31 Oct 2022 21:37:20 -0700
X-Gmail-Original-Message-ID: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
Message-ID: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
Subject: Why don't we always grab bfqd->lock for bio_bfqq?
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm investigating a NULL deref crash in bfq_add_bfqq_busy(), wherein
bfqq->woken_list_node is hashed, but bfqq->waker_bfqq is NULL - which
seems inconsistent per my reading of the code.

Wherein I see bfq_allow_bio_merge() both accesses and modifies
accesses bfqd->bio_bfqq without bfqd->lock, which strikes me as odd.
The call there though to bfq_setup_cooperator and bfq_merge_bfqqs()
seem wrong to me. In particular, the call to bfq_merge_bfqqs() I am
suspecting can cause the inconsistency seen above, since it's the only
place I've found that modifies bfqq->waker_bfqq without bfqd->lock.

But I'm curious in general - what's special about bio_bfqq? Should we
grab bfqd->lock when touching it? e.g. bfq_request_merge() also
accesses bio_bfqq without grabbing the lock, where-in we traverse
bfqq->sort_list - that strikes me as odd as well, but I'm not fully
familiar with the locking conventions here. But it feels like,
especially since we can merge bfqqs, so bio_bfqq is shared - this
lockless access seems wrong.
