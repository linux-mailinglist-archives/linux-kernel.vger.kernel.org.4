Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286616D3543
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjDBC2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 22:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDBC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 22:28:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6FFF37
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 19:28:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id le6so24975490plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 19:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680402524; x=1682994524;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybLUlu3Ru7Wc/LW+Yha3uRgx/7krEyN346oSPVy26Ww=;
        b=PSvA+fAlNjvV/y70khe3o4h+mkSRV/zmKh+J9w+9xF5v/S7P74OTpLwfHAvPMePiUA
         OZ+7jLMm6ZMfpBn8RDMs4XMpxHf8lXOecmdJZjTYfup4YCwjGFPEv7omy7Q8voDQ750B
         R296XoK3w2I4gBTmj9jIPN4Jsf8I4oJSqjmQKA9sHPauEmQTPcUEPkLP+IXtT09nk5AQ
         v4xVgYVX6/Ahf2+Kx+S7w6fTg8DdG/1mJ8dEB+Ujx+Ov3rEkhi7BxyziYCXYdiVHzpY1
         Iy6NbZb8CgPNbY7zhJKR9YnLDOysxSEXhTvAGPCmcJtWSmaEMYqh3kCUSiLubR8ged3z
         zKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680402524; x=1682994524;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybLUlu3Ru7Wc/LW+Yha3uRgx/7krEyN346oSPVy26Ww=;
        b=gSgiMYwZcLxdoy14lbEVW69d9lSbq0PGeaXsCHDu3EoTCllzMZNoZ3oiT+FuXwqCxl
         3+vvHK79iI1HKjRVI1tLuChS3tbGZsmwpXHq8nD3mjkNVrvZJsCwrCAaRkv+bTsn0bI3
         TdnCJvUj52zahcjzxb3o1fj0r0/5GdaMiVEjMoz2mVt+Cg6OATPR4op1r9y/AID5RU5a
         pKVzne65du2SqwuVRXuhs1hloNRXJRbABAA7aV95pziZlvBy7B6hwrkNIChqixgaCmaj
         ROM2gyF9KeqmzPObNhCbgKe7qDs81pGBJAobr3DjjRM6t/5m3s/Dmu1C5P3jqCfQsKGm
         mlJg==
X-Gm-Message-State: AAQBX9fdy9AD10mwxnUuxI3kps/9ZEv7c7dLVHij0GY89QTbG8Jx+JNq
        nauHOzPwlTEX5D9kCjNW4gwzeiw7ZuaYT17dD0/nFw==
X-Google-Smtp-Source: AKy350a0dWPFX1JDDSzcLkLWS9H4pD56Fisx4aIvFW3iHYlHnT2NxVShDJ/e1An2xCQpdr2QOtN+Gg==
X-Received: by 2002:a05:6a20:72a3:b0:e4:173c:cdec with SMTP id o35-20020a056a2072a300b000e4173ccdecmr10449694pzk.0.1680402524033;
        Sat, 01 Apr 2023 19:28:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n23-20020a62e517000000b0061ddff8c53dsm4184006pff.151.2023.04.01.19.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 19:28:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 0/7] Assorted DRBD refactoring
Message-Id: <168040252316.200172.16639804916232097700.b4-ty@kernel.dk>
Date:   Sat, 01 Apr 2023 20:28:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-20972
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2023 12:27:37 +0200, Christoph Böhmwalder wrote:
> Another set of "backported" DRBD refactoring patches to bring the
> in-tree version closer to out-of-tree.
> 
> These are (hopefully) no-ops, pretty much just preparation for future
> upstreaming work.
> 
> Changes since v2:
> - Rebase to for-6.4/block
> 
> [...]

Applied, thanks!

[1/7] genetlink: make _genl_cmd_to_str static
      commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da
[2/7] drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
      commit: 33f7d31673eb43298b25b0cca30acc487e8a332a
[3/7] drbd: Add peer device parameter to whole-bitmap I/O handlers
      commit: 8164dd6c8ae158ec0740bf37f0f14645a1fb5355
[4/7] drbd: INFO_bm_xfer_stats(): Pass a peer device argument
      commit: 5e54c2a6010bc88e33a5a66aa16c95fa5d017065
[5/7] drbd: drbd_uuid_compare: pass a peer_device
      commit: db445db1cde540f819265dcae2d916a35616bda0
[6/7] drbd: pass drbd_peer_device to __req_mod
      commit: ad878a0d8815a291a1cbb2dc8279dc2910c999cc
[7/7] drbd: Pass a peer device to the resync and online verify functions
      commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da

Best regards,
-- 
Jens Axboe



