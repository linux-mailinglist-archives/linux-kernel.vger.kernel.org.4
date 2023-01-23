Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED898678515
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjAWSkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjAWSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:40:02 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF37241E1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:40:01 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 80-20020a621453000000b0058952aa1c39so5625947pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bN8JvZ9hp8tuola9y1jeIFB84hc7FTQzabUJBM21sv4=;
        b=VdRkRSZOSO2Pw83rSgomIRmzdUd/wRXtowUAj21MTs86PAzrSnmBXR+vB9Bn7Wncq+
         y3FiPTruc1+E6GlWEY2PNG7EIUP/RXuxAQ0qr7fr9R26ZRISL1ZtoDkBkZujqeEzbPvR
         QCkBaL6yHkHddAPnpPOXY6WiTCctr90L4TFChyD+XncekLmAu1rxqLDNtUb5ExD6X9vk
         wzLgm/KUtTUoNZpDyT3I/hxe9a28y+Sb3bA89qThnUD7IyijQP+EIa9XNTwJMB/81LHX
         Es2lsKIRb4EVlIui2Vv50T2PgvEfs0f4/uUbfef7P+dyzvSwMtxi4SkzLstRUMbSBBF8
         1X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bN8JvZ9hp8tuola9y1jeIFB84hc7FTQzabUJBM21sv4=;
        b=xmeHS3BdGknfHYsjRjzRWBmTusqM1G0/JfG8taoIXeTbyNYHNXqVaDWq9y9vbzy1vg
         bGfxaEmTVhD+ZYD6av1R9TsGPqHmn4uzbj+ROzcb+s0hf9W72vcEScP3si7jLqdX+twz
         3Oi+YqVaY6EMGyDdfQYgEa3tpHyM3602kuKTF0zwwlM4dxvAxdM529+eu5jOWtZeL+8o
         I5Dbke9UUE2ePZnw32FyhrEGyP3Kym8HkUnuaHxIC8P1/G2WLsuZqkCGKUQzB5vhMlcw
         KA90/QvgJRpnvlwPpqLX54LGggHoNkA568OrqRBedSbEUfB4VSyFqx8M/7B2YF8P2o70
         3/GA==
X-Gm-Message-State: AO0yUKWJD+Kc7b+NsScu5L0q6ss1ljacUloTCMPVqo//yEyv5uYKDTTE
        VleCFj80+W9EAlp/iHOo46fxogs=
X-Google-Smtp-Source: AK7set+bQAfcJ5dAv95dxrMMN85wSEUYHR31H/QuLejvqZO2FBFtGy+zppANv4kIO14bIka/luzEXyE=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a17:90b:2485:b0:229:f43c:4049 with SMTP id
 nt5-20020a17090b248500b00229f43c4049mr77962pjb.0.1674499200383; Mon, 23 Jan
 2023 10:40:00 -0800 (PST)
Date:   Mon, 23 Jan 2023 18:39:59 +0000
In-Reply-To: <20221227203249.1213526-24-sashal@kernel.org>
Mime-Version: 1.0
References: <20221227203249.1213526-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230123183959.3692697-1-ovt@google.com>
Subject: [PATCH AUTOSEL 6.1 24/28] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     sashal@kernel.org
Cc:     chuck.lever@oracle.com, dai.ngo@oracle.com, hdthky0@gmail.com,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does this patch need to be backported to 5.15 and all other supported LTS branches
or only 6.1 is affected?

Thank you
