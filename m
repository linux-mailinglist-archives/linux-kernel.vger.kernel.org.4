Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E318364D02E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiLNTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiLNTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:43:31 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9C248F4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:43:29 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d14so7066754ilq.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mo0zxBwzxFipCiGCCwccoKGO7YvtvSURarcs0pMhQI=;
        b=lvENkja2zLcChQJAHLDCQQqh3zlQH8Dsoq55tTl87sB+2c0MjiwdB7LOF6vWIz22Fu
         eCICg9Fj6TfwXA8yG7XYMiaf2z12/uwOtxGbirrVMlhelM9zsuZSiJc0fsCQcVkxIqWi
         RQd2jNWuTv9nWpvqSBjTE6mk9xX/4Ih+TD6DNwKiit6DgH/l7Dbq4AiiFcND0y8/5zYZ
         HcmI74WEhjBHTUZjZl0MFiaX3CzA+Q2HPYKOJGeQA+jYIBNJZTtivM8BtmFfUwTiLPqK
         ov7lyv5b6U8d6dtzpDcDCl9w8rm+uTR3Js1B0DGhRtqpJZkWRzUSkxytnCYJqyMhzm2G
         G9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Mo0zxBwzxFipCiGCCwccoKGO7YvtvSURarcs0pMhQI=;
        b=go/1sa0efHr+BzH8IrwhHk0DPjeu8tYYcqCy+Z1yezV0QBAbENqSugrEohc67JUZ5e
         0CuKKuW/svW0eUUi8p9kzr8nHqd63sMqYks8+6rtGqFyDHVpb3JpQmsF7KqfHNxD+asT
         orzcgxNCo9lq2Tc/hIzauxT3kDD5wkzgz5jWT+0PVmayNjaH0zoGPD2cw00/kQewCW6Z
         vGCa9cFJ57yq3RxtGIORjV2Q7iC73iggEFP9Ea8hclhGRm4+h/Y8KS8pkEBjaVh7Fgs/
         d1knVlc221D9S7Tn3AVqS4lZrsoyjYMesSzjgoo/ZjOqBAyJ0yq3sqjT6BnVEhyqHa/S
         s3VA==
X-Gm-Message-State: ANoB5pku/8/FNIOMMfZlH2n5+95G5oaNedko5gAUsub87Iw+41PRPKAh
        SiNvbnbfeZ08VL6W7+n1uOXu3Q==
X-Google-Smtp-Source: AA0mqf6WKbG+uIycnikl1gYVo8MJ2Ro9/CeBqRYhcftKzrxuMs24gD/X3ikbzVraxdgzchJF9GRhRA==
X-Received: by 2002:a05:6e02:1a27:b0:304:b2dc:4274 with SMTP id g7-20020a056e021a2700b00304b2dc4274mr2666051ile.3.1671047009066;
        Wed, 14 Dec 2022 11:43:29 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u11-20020a02b1cb000000b0038a5b48f3d4sm1980125jah.3.2022.12.14.11.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:43:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        darklight2357@icloud.com, Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
Subject: Re: (subset) [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak
 on add_disk() failures
Message-Id: <167104700802.18171.11122547200509229739.b4-ty@kernel.dk>
Date:   Wed, 14 Dec 2022 12:43:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Dec 2022 08:33:10 -1000, Tejun Heo wrote:
> When a gendisk is successfully initialized but add_disk() fails such as when
> a loop device has invalid number of minor device numbers specified,
> blkcg_init_disk() is called during init and then blkcg_exit_disk() during
> error handling. Unfortunately, iolatency gets initialized in the former but
> doesn't get cleaned up in the latter.
> 
> This is because, in non-error cases, the cleanup is performed by
> del_gendisk() calling rq_qos_exit(), the assumption being that rq_qos
> policies, iolatency being one of them, can only be activated once the disk
> is fully registered and visible. That assumption is true for wbt and iocost,
> but not so for iolatency as it gets initialized before add_disk() is called.
> 
> [...]

Applied, thanks!

[1/2] blk-iolatency: Fix memory leak on add_disk() failures
      commit: 813e693023ba10da9e75067780f8378465bf27cc

Best regards,
-- 
Jens Axboe


