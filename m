Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65018640E91
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiLBTgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLBTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:35:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1FD80EB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:35:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c7so2426052pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXLe4AcieipOgmpyanQu8zzMg2qhrzhfuhvzqnhslJw=;
        b=evwD0fS0pXDFe1tsORxOMMXoQD5AV4Psap6kmuMWWk81iWpXFJLdxivtmCE/jBFQO2
         yeTuZNMJA2bv076C7c8IQVsJJASFjqUFRAV6D5qtcTPAyRMd+5uQFKmDzNJ58b90lr4l
         pUD2dP22qqSjXi9NDoOAuJEIqHBh5IpDtNFFrLz4qLWCJiUqUa9R1rNpgofVS3XE9+jQ
         4Jk2USIlix1B2KnDK13YbLazuKaVCjbyY/V25AqBQkMjiTkT/LkSDXMYQZ1rlf8GKYIR
         iWFIY04Lnv1mFU5/oBHFdleDpTZAjPi4HWtW7auL43VCdxoYvxoRQgIW4Mot+mkiKql/
         t6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXLe4AcieipOgmpyanQu8zzMg2qhrzhfuhvzqnhslJw=;
        b=USXICnvh3W+RolnnmIxHABnJ0V8hRs0v9ol6TjMemwjtCyopFIjMFYxgl1inHAA0T+
         7cB0nycFBMNTElsEOX6LX0Pzia+sQx4ETYgfXT/Jks41uYhtvbDDKyWAUei0oHzbMFz7
         u8BzoHzD5sxC/TTEoE/rX91rQG15wJsj9/LWxjLLlRmo57JK1YJ8ftCiC8MJIUI49zOX
         bwmdg1Ly81krwIppSBYrOMzfRVzBlH0+MU7duLS+FW4EIHoMc9N53q4eqmbgXQpJ4rSi
         SLkP04sTHvTTlUw0a1TfuODvYbIvaf2vs7Zn88p6aiAUu36dRx7Y9k+DYmVrgO7NAr6o
         spow==
X-Gm-Message-State: ANoB5pmv4oKviuG+3u8NVEEU6Ep/CNb5cYInqmuw5yCeIqBxOqf+adLP
        9h5qarXln9K3qminPPD3ltNeOQ==
X-Google-Smtp-Source: AA0mqf4g6gzRFmPZif4Mg9zZwILm88jWN4WgiKf4IcKDWlLGDKhoxfmGDBbPhbDlshcx4MQ+LwF+aw==
X-Received: by 2002:a05:6a00:1d81:b0:571:ea17:e111 with SMTP id z1-20020a056a001d8100b00571ea17e111mr53786630pfw.25.1670009757265;
        Fri, 02 Dec 2022 11:35:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b004351358f056sm4454617pgg.85.2022.12.02.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:35:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>,
        Peter Osterlund <petero2@telia.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-Id: <167000975630.934246.12888337558390915330.b4-ty@kernel.dk>
Date:   Fri, 02 Dec 2022 12:35:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Dec 2022 19:27:58 +0100, Greg Kroah-Hartman wrote:
> Way back in 2016 in commit 5a8b187c61e9 ("pktcdvd: mark as unmaintained
> and deprecated") this driver was marked as "will be removed soon".  5
> years seems long enough to have it stick around after that, so finally
> remove the thing now.
> 
> 

Applied, thanks!

[1/1] pktcdvd: remove driver.
      commit: f40eb99897af665f11858dd7b56edcb62c3f3c67

Best regards,
-- 
Jens Axboe


