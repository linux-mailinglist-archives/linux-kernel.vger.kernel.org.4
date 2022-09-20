Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FCF5BE8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiITO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiITO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:29:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221CE1EC5B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:29:21 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y9so1440649ily.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=b4h6CnwfloglB8BX+JRYg+NYPY8n41O96rCGRmQYplY=;
        b=OHhSlzb9MwYwEhBf8fpJH0U5e1L2dVexdla0WM5KyZ4zbRtBzUfJn2XILD5bMabmkP
         ZDYLnP31LdiaWYG0Wwb/fO+FheyanTUkNiqNEezV2RWKBdzf9LIHsYrhplxM5eWMuejL
         KZOJLg2ngf0JRvBS5tOyMTJUbMN9/459HyY/2EgN/g+Ny+osHq7pvp8FqIKAflkSnnr2
         anLXXixBEMhRLTX7B1jKf+VfpB1h3vILSD18xhMHDC8+EoZDZB2LtCJvDLYRKim3SmJf
         nDquTgYKNxta4EhxfFuVtOCH3u0hhSa9xkNOAUkf+DHo1PrdbMxu8Fwcv58DUpJKNwhI
         VUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b4h6CnwfloglB8BX+JRYg+NYPY8n41O96rCGRmQYplY=;
        b=wNrd7lcFNqd3ps/vBkhSAlZvxEYjM6BP/2QFxr0nNRd9bLJ0iw39lt1YgjH9zMOPtS
         PCs2SInWM+tGnIuDkgCCTk7CQeyb3b2b1f2g39YC9PO7aOWGjgkEINcEeFjzzOOnbbkt
         XiFOhTxvmfWErQKfBEPQsEBNkKdSprhrCB8hi3+b2aTDIiq2VJ9rVcZ0SqDXczGcsPPY
         Mq4b3FEj9h080j9erC7YusVUIZqeD97zOqvSMPEqDOJBbwFzVnj0ZOzQ/Xtbbjvghn3Z
         6iIGTRzr40VktDlVH/7Bif9QU+9YsaEW+9d4/20JGkBM3tjUZDJN0B9I98sJTjDdC9n0
         b9Cw==
X-Gm-Message-State: ACrzQf3lPVRD1vAUP/xl/R0WWtLrgF2yIjGDSZBzUJinUuyll3yhTD/X
        /bdWBudsNVeXPfEHTYWt9CrfhpbIkwgpuA==
X-Google-Smtp-Source: AMsMyM5nQxxF50sNz7iolWQkkg2CR+NmBFf2et7lsbUK6kUIMnUm9voaFO3QFZyqwuacx1Bc42tS0A==
X-Received: by 2002:a92:6a12:0:b0:2f6:3bd1:fbdf with SMTP id f18-20020a926a12000000b002f63bd1fbdfmr1308703ilc.205.1663684160490;
        Tue, 20 Sep 2022 07:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d71-20020a02624a000000b003567503cf92sm683241jac.82.2022.09.20.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:29:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Li zeming <zeming@nfschina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220919012825.2936-1-zeming@nfschina.com>
References: <20220919012825.2936-1-zeming@nfschina.com>
Subject: Re: [PATCH] block: Remove unnecessary (void*) conversions
Message-Id: <166368415982.11026.4714198976076323254.b4-ty@kernel.dk>
Date:   Tue, 20 Sep 2022 08:29:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 09:28:25 +0800, Li zeming wrote:
> The key pointer does not need to cast the type.
> 
> 

Applied, thanks!

[1/1] block: Remove unnecessary (void*) conversions
      commit: a7609c68f7a117a77b3049c2353f555854be69e9

Best regards,
-- 
Jens Axboe


