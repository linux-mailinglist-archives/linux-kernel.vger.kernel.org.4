Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D85FB8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJKQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJKQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:54:58 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078AA17E27;
        Tue, 11 Oct 2022 09:54:56 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id y129so6947570vkg.8;
        Tue, 11 Oct 2022 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhLTcdB4WsCh/vP1czukbNh0ebYnCkF5kHJbcSwgwSY=;
        b=nE1SI2L61bOeyDQVfsAVXR9tLiJCDb/MT3KNmCLWWQkxjFida4aJ6DukRVwdaYroZT
         0gbAE+YsnR6IwIbVtnSmY/lHzTzrSax9urxIKmXww3pkUy8dTR5hokDuvbd6l+tRs1jT
         +g+yJF4uf4R6eY18ovAWUsBn1y9hfs/ZMATeGtKyx49KvWtWLZqzw5qOoj4ZlDvsHsaF
         LjAySYor7garmiQZCqwTsgSwo4b+LDN3CRp+QtvgNQVS5hqUATWjQK6kxyfwqDO4CdB/
         6N/wYOtz74zl8MXdXzWnaD2dO1u5xqHoBkKYg5D8tOeGt/U64xmwokYx7EYVErHG92wK
         Vz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhLTcdB4WsCh/vP1czukbNh0ebYnCkF5kHJbcSwgwSY=;
        b=wozLb11zDu5FpcgSlV/skCf+Cz1f5E/eNCqz1IO1FEgLhvUeLjlKY0r5WSP2v+9XKj
         R3QDIi8nfII4p6MM1JCQrfb1gdPQ0bSDYV4ExCz9f7D/STDA11ZZA9W6qz32VPEY1Hxf
         RJKFDc9ZFf7ZRKGrdwfKVg2wEnq0nIwR4Ut6DkBaYio5WksPsWYILOLEanTfyaM+41u9
         IvmNdvvU5ucrPTYklRhFqGWEmO9wr4ClGgmSku/OF7/JoVjF+hotcP1LOstGeR+ZzJdA
         A3W8Iy9QeIZ7pbgrw5zmwudTPnOwDmtToHoIXx+PQW+WTs1UYZ74x401JPDaBOBoPs9Y
         buAA==
X-Gm-Message-State: ACrzQf0zFllrR2e0XTUjP0tcvyZH67sJmXlD6zpdgsi/TuEdyiOgY1GZ
        sMv4Oj2b4/Z4F/+0u8KIlzrSScY1z0iQCA==
X-Google-Smtp-Source: AMsMyM6WD85RJrsWfWyb+GrHuCVmpzmrwbTaogLDboReDgPG9AtJdj/NiwKS8A23mRVKfztmS82bOg==
X-Received: by 2002:a17:902:e885:b0:183:dcb7:c4f8 with SMTP id w5-20020a170902e88500b00183dcb7c4f8mr3026070plg.160.1665507284779;
        Tue, 11 Oct 2022 09:54:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b0017f7b6e970esm8941708plx.146.2022.10.11.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:54:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 06:54:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/5] blk-iocost: disable writeback throttling
Message-ID: <Y0Wf01w6iNbvxgya@slm.duckdns.org>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011083547.1831389-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:35:43PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") disable
> wbt for bfq, because different write-throttling heuristics should not
> work together.
> 
> For the same reason, wbt and iocost should not work together as well,
> unless admin really want to do that, dispite that performance is
> affected.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
