Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1754F69B40D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQUiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBQUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:38:11 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832902A6DC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:38:09 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f26so1001204ion.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QW1U0BdBx7Jx8kPGyXfr0Re3UnOpioEFLwDuydQbjM=;
        b=03Qqa8iulXI39rGuZGvUnr1cd60q0K6fePLUgetpk/SjU81oBjlBQpzV/77WUPU928
         lO5N0nk8iKBudMAGpCzboTfrxNFL1VVF08fpkHFT0hwHf1pLKxLNBoLZrdJJHJlqS7sJ
         CIVsowbrrq87cc/k6aM2wwakwL4S6Z5y++4RF9cyTqeFwV+ZveU76zEYw9J4vLJ9Pt4Q
         JZ7WqzMIAos1A+oS9NmCEXzFT/GcxJEQ8KghXYNcw2kZF6kfiaByHbdSZsJ9ahLZLuPy
         KBDkvLW7qZSEVY2Q5A8B3gygAkijQZNJ9YdqKojPCSc1fvI9fU6E04t6PBqGnxG7ItNY
         +m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QW1U0BdBx7Jx8kPGyXfr0Re3UnOpioEFLwDuydQbjM=;
        b=vzacA7syaLklRWxAK3lQYLb/TW4EZNyeuGttGjHs/nbI7nLJ9b1TlFkWozNuo0+9eQ
         WBkiavkNFxv4xlRkWow5g6DdWQFRdyDXx2mJlCWUqCjPNnsC3bMpGDnD3szqAZQuHn9v
         fK1RASqxkRTebQh6os7AjIWyDoECZN87tiE3n81RDcANKg4C2/ngHbFVZWY/o0Umqb6D
         6vlO9PytCymNuAcc6eWc/IiBV+oaC6ohiq8nHhwXX6QkxK4237hC1FSgsIeFPvDGnRBO
         /xCLGQmgxZcOTSwT0K7pc9VZL8snRawyx26Lk+DybkLhG9hXV5MdbsmdGQRVczWZglQc
         TNxQ==
X-Gm-Message-State: AO0yUKVDWYPHYNNMMzecBcWfKp3fVOkSx2Vw5HEXKzXC9QNs/dBtIpXM
        r7HkKoRPaFBVCN88zMjigiBpOw==
X-Google-Smtp-Source: AK7set8hN4MPWUVNlWZduo6D5QmHgRQl2zP/sHLvJowbKiJcCnsTqE0hGcGJTzdO40QqrbiSa0r6Lw==
X-Received: by 2002:a05:6602:26d3:b0:70a:9fce:853c with SMTP id g19-20020a05660226d300b0070a9fce853cmr2300877ioo.2.1676666288852;
        Fri, 17 Feb 2023 12:38:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bh25-20020a056602371900b00740710c0a65sm1709811iob.47.2023.02.17.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:38:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <6f249f9b02a3490283ef0278096556de41aa0cf0.1676626130.git.christophe.jaillet@wanadoo.fr>
References: <6f249f9b02a3490283ef0278096556de41aa0cf0.1676626130.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] blk-mq: Reorder fields in 'struct blk_mq_tag_set'
Message-Id: <167666628814.273360.17235110926752683174.b4-ty@kernel.dk>
Date:   Fri, 17 Feb 2023 13:38:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2023 10:29:10 +0100, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct blk_mq_tag_set'
> from 304 to 296 bytes.
> 
> 

Applied, thanks!

[1/1] blk-mq: Reorder fields in 'struct blk_mq_tag_set'
      commit: d88cbbb39b4db057feb1552de31f22c02a21b36f

Best regards,
-- 
Jens Axboe



