Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3DE6816B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbjA3QnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjA3QnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:43:03 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00269EF9B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:43:00 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e2so1934412iot.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpgjZckYLztvcV7QaalQFibYSLZqpEGZ7gtC9W6bdz8=;
        b=Afcz2fTE+YSsGPS35qV0/dfhcg6EXXNCfjLLjhvWFbb6GTv/9L4aeaZYTTtgqudl44
         KMdzZnO82RoyAdsvs/MR5PW7j4ZMMkBDfV4ZdzqfRbzaNk1NhPkgLKFyU72OV4uRVwrn
         utN2m0aauf8YznDYM5xgLLkoo8GR7bBdrIyMH2qAD43GSyYbxI9Gb0EvPVQtocm+EAKD
         u883jNUA/Tri8FNC0e4V6+Cel7P1Vm8K6HXkJzYY/mgAGjhtakdP6cBhSb9q9bZbON37
         Oz+BuqkCVVngX0T3E//8ifpDbB2Gz43EtRcXWCD1RREav8a9KQOtR+npJwl80oDzupQ2
         j7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpgjZckYLztvcV7QaalQFibYSLZqpEGZ7gtC9W6bdz8=;
        b=DeWiww9GTiEaU/PPgtZDPGR/vpPuBTdkfyoWF9D/strSZskrCpInbRN3xvJghB1Ls/
         vQLzfKpMUHMHnrQZH4m6iXC+B5RxgYDz9V0k4ymYerKV04XiUKlZdcSUtPISIbLMwkxu
         d+2ltzxaCfiZpkYLxKpmuDDYBkteWfQ+fBzqCmVRdfnn/TqVJVn8WVAHjlz4nlRq3t33
         FQCPzWwz+RsG6bLocE2HspR/ZTu7fitz5c3DQYo+a2lUCQLFnt5wPdwf3m/0sJvE4NXE
         wmy4GIgFE7BeOpt6WAaZl/mMbjNyXfWCsyvD4HO5rWI0+YCqLOuVDMpldH1IB1BPxvqM
         CPPg==
X-Gm-Message-State: AFqh2krxuj4hY/tR3f76fAGNX69jsbBVDI2XWgGUBk7WQ9BAAb5DZzjQ
        FLRgeCM9dBeE4blp7SMi7SnibQ==
X-Google-Smtp-Source: AMrXdXtnhT4UZe4nXa9KXjxZ0fYwopxfn3O5t7qzwwKB75N7Bao7hUdLU/LFIAHTV1KsEZDNkV50TA==
X-Received: by 2002:a5d:9e4d:0:b0:707:6808:45c0 with SMTP id i13-20020a5d9e4d000000b00707680845c0mr6332948ioi.1.1675096980275;
        Mon, 30 Jan 2023 08:43:00 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638169000b003a432de0547sm1858710jat.163.2023.01.30.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:42:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130121240.159456-1-ulf.hansson@linaro.org>
References: <20230130121240.159456-1-ulf.hansson@linaro.org>
Subject: Re: [PATCH] block: Default to use cgroup support for BFQ
Message-Id: <167509697947.219033.9483130158448775537.b4-ty@kernel.dk>
Date:   Mon, 30 Jan 2023 09:42:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 13:12:40 +0100, Ulf Hansson wrote:
> Assuming that both Kconfig options, BLK_CGROUP and IOSCHED_BFQ are set, we
> most likely want cgroup support for BFQ too (BFQ_GROUP_IOSCHED), so let's
> make it default y.
> 
> 

Applied, thanks!

[1/1] block: Default to use cgroup support for BFQ
      commit: 4a6a7bc21d4726c5772e47525e6039852555b391

Best regards,
-- 
Jens Axboe



