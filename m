Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3761F5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiKGO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiKGO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:27:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8BF1EAC9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:22:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14756015pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik2+y8IF52g+m5bk/aYkFet3pzFw8bcdKkBwNiPEt0M=;
        b=O6GsnmkroB+yLenPGib3vLB6XCa713TB2eFHALv47vfGZ+iUkcwn72gn+eruvUNoDe
         /DuTQVeRXHGbVb/ISMmwQ9fkihMqluxPc7VRwL2YLO9JWvpDRp6qGysP5ggH8FZ3Wmu2
         O+M+njIVIcLy7ZiogIkVKjL96R7msY/VC7iXd2999bcVVtWMXGfzJdXxjofRUKGrPx6G
         fPlceLpYm7eQyFlF35qtksa/JsXzxUrQLyjAHUKDgN+sxIJfp8g962yZteCu0deZ/PRA
         LQPW6OB2CmgjJB0Quu7jAx7eLvGjKuDuzQaCzJQbQ8Pis3X5v9AABj19IKHLCpf/Ltfw
         ldEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik2+y8IF52g+m5bk/aYkFet3pzFw8bcdKkBwNiPEt0M=;
        b=O9TpNs4008gB//Wlv9RcxuT7ly7kIKTHA4h2bO9TWP6KARr22zJpbVVPE2EN0CFTFN
         bj9O/ptfajIZwsf4F7tD12jzVksnaHiB4jWGIhFvV+Va2nQH3QWeH9SXDLB3U+TOu8tM
         xM/0PLqgEx3i0znyCPdFIY80qXgBPay8CLeHumZMI1k9Y4K0Sf9qb/TeYj33G4PL0MU6
         j4iniGrcNkQu/yqZXjyhEVI+7oeRRNrJ/gJxiPUhRyMDfRhk7t7dYGeoWgxkMYx9GAKo
         xtCEVnT6UVJLPJSB4dAzO8G3BWwIM9x+ypyBONSn7wd3DG+55ThniYCVW8ZfuYLVuC/B
         UNvQ==
X-Gm-Message-State: ACrzQf1Y62swfFaoNN61QHtVtw/x+5lkBwDxkWAC7VE1Eg/tIhEWdLfP
        2zisaC9SjiOKFLZhVTBNxKUuyv6JJiuzCYbU
X-Google-Smtp-Source: AMsMyM5eOXuxL/d9kFFYFKnRWdYXVtHtUAmNQOKshJPGdfxXjQDv6JeTY/Ru2NGOqwuACdYvJdKj7A==
X-Received: by 2002:a17:902:9888:b0:186:9c32:79ca with SMTP id s8-20020a170902988800b001869c3279camr50375067plp.17.1667830933937;
        Mon, 07 Nov 2022 06:22:13 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001869394a372sm5074355pla.201.2022.11.07.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:22:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20221107062255.2685-1-yang.lee@linux.alibaba.com>
References: <20221107062255.2685-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] block: Fix some kernel-doc comments
Message-Id: <166783093301.6467.9896856409636651914.b4-ty@kernel.dk>
Date:   Mon, 07 Nov 2022 07:22:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 14:22:55 +0800, Yang Li wrote:
> Remove the description of @required_features in elevator_match()
> to clear the below warning:
> 
> block/elevator.c:103: warning: Excess function parameter 'required_features' description in 'elevator_match'
> 
> 

Applied, thanks!

[1/1] block: Fix some kernel-doc comments
      commit: 5b2560c4c20e6d6933625b4b56f6843d6c7faf0f

Best regards,
-- 
Jens Axboe


