Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E976D6765
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjDDPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjDDPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:33:16 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB334C27
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:33:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g16so3995922iom.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680622390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA8/1Y9g9Wa3mobUSBG3c9E7bnhvwcUMBAt0ZCfz+zQ=;
        b=w7FU3VoD6ht6HAR4r1pJo7SM1rGY+6SLqDNAa1gAI5PZ2n+fC3CXKxxfSN7t4+VACl
         Iw8ShezDwnnxc5+iDaVcuJkrulaOLsjxyFJtsxrCrP4QrGciJaQEpHU6//HuFFht8xOx
         VLsdeWVIuSGahuO//dFevP0VKBw+lDUqHGFfmIJyvUjCcL6EKLfV4DHLZwwtibuTBSXt
         jb11RdNnoiXrG+E5xQ1XUcdSAK+NzdUxVN3335vPfg0WqZpttHAf3U+D8mw9cemHwODI
         qxPFbvVSpR76LgTYToklbIFjxrxYmISLRDh/6dOVJ8HoT51oM3gR8CJR4u8U37SYLxKd
         A6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA8/1Y9g9Wa3mobUSBG3c9E7bnhvwcUMBAt0ZCfz+zQ=;
        b=BpMu/9OgKFe69EWV+rWdVtdMeDWTnUGcXFRQNt0F18QLjg0kQisPzcARTkC05oweAs
         OV4TwKnIKHJWgbD8cO/RVOk9cfXDeC0HDOQyLMFl8yJsd1E+ursqAeZgOceRkTGsvD1L
         ZUUDFdb68Onmcy9VRjsjb1d2OffPkXkOhFcvZbzj/whnizDw/u3pTMiyV1t/Ls5FxGkk
         wtkaSHei2NoVrnfHjmZLr+3PzP1iOybGaud0M6VMg07OJjPZ7G4VsyUxWHrDj+fRGQo2
         AF+J5BY1KgKZ2bGDBiPqXIAn/QBQoiVLTzUhOmcAzMNUBDrFqCjQTt5nnkeJWLFRq9gD
         XEcw==
X-Gm-Message-State: AAQBX9ciadUjavay9cDMOVQjlViZE+2TiMH6x4AeLWt7PZefYpHpMPDz
        inDNxQBxFkjxao79xiopvcmvZKpLg9KH6jwesWbdFw==
X-Google-Smtp-Source: AKy350Ybwi1HxNc2GqE/pXdwSR+Iqt/VszvEOPDfz+S67Zx3GvG72GAzjK0MIi2RK8plKNq/PnjPzw==
X-Received: by 2002:a05:6602:807:b0:75c:f48c:2075 with SMTP id z7-20020a056602080700b0075cf48c2075mr1909570iow.2.1680622389710;
        Tue, 04 Apr 2023 08:33:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m32-20020a026d20000000b00404f3266fd7sm3372092jac.159.2023.04.04.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:33:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <cover.1680576071.git.asml.silence@gmail.com>
References: <cover.1680576071.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 00/13] optimise registered buffer/file updates
Message-Id: <168062238890.178314.6474910053250200653.b4-ty@kernel.dk>
Date:   Tue, 04 Apr 2023 09:33:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 13:39:44 +0100, Pavel Begunkov wrote:
> The patchset optimises registered files and buffers updates / removals,
> The rsrc-update-bench test showes 11x improvement (1040K -> 11468K
> updates / sec). It also improves latency by eliminating rcu grace
> period waiting and bouncing it to another worker, and reduces
> memory footprint by removing percpu refs.
> 
> That's quite important for apps updating files/buffers with medium or
> higher frequency as updates are slow and expensive, and it currently
> takes quite a number of IO requests per update to make using fixed
> files/buffers worthwhile.
> 
> [...]

Applied, thanks!

[01/13] io_uring/rsrc: use non-pcpu refcounts for nodes
        commit: b8fb5b4fdd67f9d18109c5d21d44a8bd4ddb608b
[02/13] io_uring/rsrc: keep cached refs per node
        commit: 8e15c0e71b8ae64fb7163532860f8d608165281f
[03/13] io_uring: don't put nodes under spinlocks
        commit: 2ad4c6d08018e4eec130c29992028dc356ab2181
[04/13] io_uring: io_free_req() via tw
        commit: 03adabe81abb20221079b48343783b4327bd1186
[05/13] io_uring/rsrc: protect node refs with uring_lock
        commit: ef8ae64ffa9578c12e44de42604004c2cc3e9c27
[06/13] io_uring/rsrc: kill rsrc_ref_lock
        commit: 0a4813b1abdf06e44ce60cdebfd374cfd27c46bf
[07/13] io_uring/rsrc: rename rsrc_list
        commit: c824986c113f15e2ef2c00da9a226c09ecaac74c
[08/13] io_uring/rsrc: optimise io_rsrc_put allocation
        commit: ff7c75ecaa9e6b251f76c24e289d4bfe413ffe31
[09/13] io_uring/rsrc: don't offload node free
        commit: 36b9818a5a84cb7c977fb723babca1c8d74f288f
[10/13] io_uring/rsrc: cache struct io_rsrc_node
        commit: 9eae8655f9cd2eeed99fb7a0d2bb22816c17e497
[11/13] io_uring/rsrc: add lockdep sanity checks
        commit: 1f2c8f610aa6c6a3dc3523f93eaf28c25051df6f
[12/13] io_uring/rsrc: optimise io_rsrc_data refcounting
        commit: 757ef4682b6aa29fdf752ad47f0d63eb48b261cf
[13/13] io_uring/rsrc: add custom limit for node caching
        commit: 69bbc6ade9d9d4e3c556cb83e77b6f3cd9ad3d18

Best regards,
-- 
Jens Axboe



