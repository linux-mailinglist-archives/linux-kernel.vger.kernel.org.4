Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6E74F272
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGKOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjGKOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:38:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3565170A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:37:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78362f57500so283566839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086275; x=1691678275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xszDpG6ynJRU/KaL9F4XqI9E1A/LBVjEATofDViO1rk=;
        b=4SOvn8xOUaSgxQtG/GF03bQ3uxpHTvo7feOzeFuICwXdldG+sBCPh7rnTcGXeOZSzu
         BxHdyUv7cT2OQMv9y8lwRw/pxo3XRExeH88cGxAkQWJ7SJ6hLGaz//v93sNxsOlJDhja
         xoSdHAcPD3YaC70kPV1VPGPyol4DqmdDPqjJiGqODgFzm/pi1eEaA1LZfFt+w2J4nBcP
         cmukSd/1Lw1w53OWMEoHZKdIXsYFXWLXK/oivSVviEK57VolFTFkMS/SfX0nxXW+xn6H
         Hb3/7ZKqD33CiD3xIyh8s/IXNeAjU+Erq1Wy+N88UlK3fD43Afthjq+Lqa4wUQT+y5W6
         mpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086275; x=1691678275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xszDpG6ynJRU/KaL9F4XqI9E1A/LBVjEATofDViO1rk=;
        b=jFxyZjrmyoGUMok/v0UZ18cVreONX5hpYwN7JF2NKwbJUqy0xf4hqh2vKg6C8b/iOb
         wFH8PcAQJZ9/c4pqWpuFWXoajxvzs0fv3QbeJ3zt4eJ+kPldWUVyKL6pWIZZTSosPsnH
         Pa1BZh4jr7xF6O3ofVRc8BAoCstiLVPX1/9yKeaoVs22oovnmVRiMYABoOhRf+6bDX6K
         pu3C2F1W9p17SwFUhyDZzCddn/oACWBnwqTEZjVertMaAL/2CjN3c/xq2832qQ7HQ/lh
         59GLKSA0n7VBLIPJmIZ/mHOI8wOJaWWKHfMGv4WbGlyb086Da9enYUOOBl3TET++dgKT
         Hncg==
X-Gm-Message-State: ABy/qLal2w2pgjS7gcEB2Mhwhd1aAbKTFuMENIKIuMyDvJSzyhihzIKs
        U3RhrVKqui9QBQQdSYlRJQikd0sVTpl3XN5zyLWjmw==
X-Google-Smtp-Source: APBJJlGEMGiam/rAubvOIBgmfP3EaHXLJpOdqn7BTO6ROm4OL8Y6qLF9ggwuof9TElRDZRT/ViercHllXmJkG6rDh9Q=
X-Received: by 2002:a05:6602:2212:b0:786:e669:3059 with SMTP id
 n18-20020a056602221200b00786e6693059mr14659376ion.6.1689086275277; Tue, 11
 Jul 2023 07:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711143337.3086664-1-glider@google.com>
In-Reply-To: <20230711143337.3086664-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 11 Jul 2023 16:37:18 +0200
Message-ID: <CAG_fn=V3XvZCrAs21Ng6jTKeME7JCiMpYJqnRYQgXAM5mXJMUQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Implement MTE tag compression for swapped pages
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I accidentally sent some unwanted files along with the series.
Please disregard it, I will resend.
